#!/usr/bin/env python3
"""Verify vendored build tools and the pinned runtime emulator."""

from __future__ import annotations

import argparse
import hashlib
import json
import subprocess
import sys
from pathlib import Path


def sha256_of(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1 << 20), b""):
            digest.update(block)
    return digest.hexdigest()


def platform_key(explicit: str | None) -> str:
    if explicit:
        return explicit
    return "windows_i386" if sys.platform == "win32" else "linux_x86_64"


def check_files(entries: list[dict], errors: list[str], notes: list[str]) -> int:
    checked = 0
    for entry in entries:
        path = Path(entry["path"])
        if not path.is_file():
            if entry.get("observed_only"):
                notes.append(f"{path} is not present; nothing to record")
                continue
            errors.append(f"{path} is missing")
            continue
        size = path.stat().st_size
        digest = sha256_of(path)
        if entry.get("observed_only"):
            if digest != entry["sha256"] or size != entry["size"]:
                notes.append(f"{path} differs from the observed pinned runtime build")
            continue
        if size != entry["size"]:
            errors.append(f"{path} is {size} bytes, expected {entry['size']}")
        if digest != entry["sha256"]:
            errors.append(
                f"{path} SHA256 differs\n"
                f"        expected {entry['sha256']}\n"
                f"        actual   {digest}"
            )
        checked += 1
    return checked


def check_emulator_commit(component: dict, errors: list[str], notes: list[str]) -> None:
    entries = component.get("files", {}).get("any", [])
    if not entries:
        errors.append("emulator has no declared executable path")
        return
    checkout = Path(entries[0]["path"]).parent.parent
    if not (checkout / ".git").exists():
        notes.append(f"emulator checkout is absent at {checkout}")
        return
    result = subprocess.run(
        ["git", "-C", str(checkout), "rev-parse", "HEAD"],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        errors.append(f"could not read emulator commit at {checkout}")
        return
    actual = result.stdout.strip()
    expected = component["source_commit"]
    if actual != expected:
        errors.append(f"emulator is at {actual}, expected pinned commit {expected}")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", default="config/toolchain.json")
    parser.add_argument("--platform")
    parser.add_argument("--require-emulator", action="store_true")
    args = parser.parse_args()

    config = json.loads(Path(args.config).read_text(encoding="utf-8"))
    key = platform_key(args.platform)
    errors: list[str] = []
    notes: list[str] = []
    checked = 0
    for component in config["components"]:
        files = component.get("files", {})
        entries = files.get(key, files.get("any", []))
        if component["id"] == "emulator":
            present = any(Path(entry["path"]).is_file() for entry in entries)
            if not present and not args.require_emulator:
                notes.append("emulator is not built; it is required only by runtime targets")
                continue
            if not present:
                errors.append("emulator is not built; run 'make build-gens'")
                continue
            check_emulator_commit(component, errors, notes)
        checked += check_files(entries, errors, notes)

    for note in notes:
        print(f"[INFO] {note}")
    if errors:
        for error in errors:
            print(f"[ERROR] {error}", file=sys.stderr)
        print(f"[FAIL] toolchain does not match {args.config}", file=sys.stderr)
        return 1
    print(f"[OK] toolchain matches {args.config}: {checked} file(s) verified for {key}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
