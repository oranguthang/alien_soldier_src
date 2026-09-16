#!/usr/bin/env python3
"""Replay the pinned movies and capture one state for each runtime scenario."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import subprocess
import sys
from pathlib import Path


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def run_hidden(command: list[str], cwd: Path, timeout: int) -> subprocess.CompletedProcess:
    startupinfo = None
    if os.name == "nt":
        startupinfo = subprocess.STARTUPINFO()
        startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
        startupinfo.wShowWindow = 0
    return subprocess.run(command, cwd=cwd, timeout=timeout, startupinfo=startupinfo)


def resolve_movies(root: Path, config: dict) -> dict[str, Path] | None:
    """Check every declared movie against its pinned hash before any replay."""
    movies: dict[str, Path] = {}
    for movie_id, entry in config["movies"].items():
        path = root / entry["path"]
        if not path.is_file():
            print(f"[ERROR] missing runtime movie {movie_id}: {path}", file=sys.stderr)
            return None
        actual = sha256(path)
        if actual != entry["sha256"]:
            print(f"[ERROR] movie {movie_id} SHA-256 is {actual}", file=sys.stderr)
            return None
        movies[movie_id] = path.resolve()
    return movies


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scenarios", default="config/runtime_scenarios.json")
    parser.add_argument("--gens", default="../gens_automation/Output/Gens.exe")
    parser.add_argument("--rom", default="asbuilt.bin")
    parser.add_argument("--output-dir", default="runtime/captures")
    parser.add_argument("--minimum-timeout", type=int, default=60)
    parser.add_argument("--seconds-per-1000-frames", type=int, default=20)
    args = parser.parse_args()

    root = Path.cwd()
    config = json.loads((root / args.scenarios).read_text(encoding="utf-8"))
    gens = (root / args.gens).resolve()
    rom = (root / args.rom).resolve()
    if not gens.is_file() or not rom.is_file():
        print(f"[ERROR] missing runtime input: gens={gens.is_file()} rom={rom.is_file()}", file=sys.stderr)
        return 1
    movies = resolve_movies(root, config)
    if movies is None:
        return 1

    output_root = root / args.output_dir
    total_frames = 0
    for scenario in config["scenarios"]:
        movie = movies.get(scenario["movie"])
        if movie is None:
            print(f"[ERROR] {scenario['id']}: undeclared movie {scenario['movie']}", file=sys.stderr)
            return 1
        scenario_dir = output_root / scenario["id"]
        scenario_dir.mkdir(parents=True, exist_ok=True)
        for old_output in list(scenario_dir.glob("*.genstate")) + list(scenario_dir.glob("*.png")):
            old_output.unlink()
        frame = int(scenario["frame"])
        # The emulator replays from frame zero every time, so the wall-clock cost
        # of a scenario is proportional to the frame it stops at.
        timeout = max(args.minimum_timeout, frame * args.seconds_per_1000_frames // 1000)
        command = [
            str(gens), "-rom", str(rom), "-play", str(movie),
            "-screenshot-interval", str(frame), "-screenshot-dir", str(scenario_dir),
            "-max-frames", str(frame + 1), "-save-state-dumps",
            "-turbo", "-frameskip", "0", "-nosound",
        ]
        print(f"[RUN] {scenario['id']}: {scenario['movie']} frame {frame}", flush=True)
        result = run_hidden(command, root, timeout)
        state = scenario_dir / f"{frame:06d}.genstate"
        screenshot = scenario_dir / f"{frame:06d}.png"
        if result.returncode != 0 or not state.is_file() or not screenshot.is_file():
            print(f"[ERROR] {scenario['id']}: capture failed (exit {result.returncode})", file=sys.stderr)
            return 1
        total_frames += frame
    print(f"[OK] captured {len(config['scenarios'])} runtime scenarios "
          f"from {len(movies)} movies, {total_frames} replayed frames")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
