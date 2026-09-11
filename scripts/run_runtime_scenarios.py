#!/usr/bin/env python3
"""Replay the pinned movie and capture one state for each runtime scenario."""

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


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scenarios", default="config/runtime_scenarios.json")
    parser.add_argument("--gens", default="../gens_automation/Output/Gens.exe")
    parser.add_argument("--rom", default="asbuilt.bin")
    parser.add_argument("--output-dir", default="runtime/captures")
    parser.add_argument("--timeout", type=int, default=300)
    args = parser.parse_args()

    root = Path.cwd()
    config = json.loads((root / args.scenarios).read_text(encoding="utf-8"))
    movie = root / config["movie"]["path"]
    gens = (root / args.gens).resolve()
    rom = (root / args.rom).resolve()
    if not gens.is_file() or not rom.is_file() or not movie.is_file():
        print(f"[ERROR] missing runtime input: gens={gens.is_file()} rom={rom.is_file()} movie={movie.is_file()}", file=sys.stderr)
        return 1
    actual_movie_hash = sha256(movie)
    if actual_movie_hash != config["movie"]["sha256"]:
        print(f"[ERROR] runtime movie SHA-256 is {actual_movie_hash}", file=sys.stderr)
        return 1

    output_root = root / args.output_dir
    for scenario in config["scenarios"]:
        scenario_dir = output_root / scenario["id"]
        scenario_dir.mkdir(parents=True, exist_ok=True)
        for old_output in list(scenario_dir.glob("*.genstate")) + list(scenario_dir.glob("*.png")):
            old_output.unlink()
        frame = int(scenario["frame"])
        command = [
            str(gens), "-rom", str(rom), "-play", str(movie),
            "-screenshot-interval", str(frame), "-screenshot-dir", str(scenario_dir),
            "-max-frames", str(frame + 1), "-save-state-dumps",
            "-turbo", "-frameskip", "0", "-nosound",
        ]
        print(f"[RUN] {scenario['id']}: frame {frame}", flush=True)
        result = run_hidden(command, root, args.timeout)
        state = scenario_dir / f"{frame:06d}.genstate"
        screenshot = scenario_dir / f"{frame:06d}.png"
        if result.returncode != 0 or not state.is_file() or not screenshot.is_file():
            print(f"[ERROR] {scenario['id']}: capture failed (exit {result.returncode})", file=sys.stderr)
            return 1
    print(f"[OK] captured {len(config['scenarios'])} runtime scenarios")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
