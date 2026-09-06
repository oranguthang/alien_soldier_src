#!/usr/bin/env python3
"""Check the declared ROM layout against source, listing, and built image."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


INCLUDE_ROW = re.compile(r'^\s*\d+/\s*([0-9A-F]+) :\s+include "([^"]+)"')
LISTING_ROW = re.compile(r'^\(\d+\)\s+\d+/\s*([0-9A-F]+)\s*:')
LABEL = re.compile(r'^([A-Za-z_][A-Za-z0-9_]*):')


def number(value: str | int) -> int:
    if isinstance(value, int):
        return value
    return int(value, 16) if value.lower().startswith("0x") else int(value, 0)


def listing_includes(lines: list[str]) -> list[tuple[int, str]]:
    rows = []
    for line in lines:
        match = INCLUDE_ROW.match(line)
        if match:
            rows.append((int(match.group(1), 16), match.group(2).replace("\\", "/")))
    return rows


def listing_symbols(lines: list[str]) -> dict[str, int]:
    symbols: dict[str, int] = {}
    for line in lines:
        row = LISTING_ROW.match(line)
        if not row or len(line) < 40:
            continue
        label = LABEL.match(line[40:])
        if label:
            symbols[label.group(1)] = int(row.group(1), 16)
    return symbols


def check_modules(layout: dict, lines: list[str], errors: list[str]) -> int:
    includes = listing_includes(lines)
    actual_modules = [row for row in includes if row[1].endswith(".s")]
    actual_shared = [path for _, path in includes if path.endswith(".inc")]
    declared = layout["modules"]

    if len(actual_modules) != len(declared):
        errors.append(
            f"listing has {len(actual_modules)} modules; layout declares {len(declared)}"
        )
        return 0

    image_size = number(layout["rom_image"]["size"])
    line_limit = layout["target"]["max_module_lines"]
    for index, (entry, (start, path)) in enumerate(zip(declared, actual_modules)):
        end = actual_modules[index + 1][0] - 1 if index + 1 < len(actual_modules) else image_size - 1
        if entry["file"] != path:
            errors.append(f"module {index}: listing has {path}; layout declares {entry['file']}")
            continue
        if number(entry["start"]) != start or number(entry["end"]) != end:
            errors.append(
                f"{path}: listing range 0x{start:06X}-0x{end:06X}; "
                f"layout range {entry['start']}-{entry['end']}"
            )
        source = Path(path)
        if not source.is_file():
            errors.append(f"module is missing: {path}")
        else:
            line_count = len(source.read_text(encoding="utf-8").splitlines())
            if line_count > line_limit:
                errors.append(f"{path}: {line_count} lines exceeds limit {line_limit}")

    expected_shared = [entry["file"] for entry in layout["shared_definitions"]]
    if actual_shared != expected_shared:
        errors.append(f"shared includes are {actual_shared}; layout declares {expected_shared}")
    return len(declared)


def check_landmarks(layout: dict, lines: list[str], errors: list[str]) -> int:
    symbols = listing_symbols(lines)
    landmarks = layout["rom_image"].get("landmarks", [])
    for landmark in landmarks:
        name = landmark["symbol"]
        if name not in symbols:
            errors.append(f"landmark {name} is absent from the listing")
        elif symbols[name] != number(landmark["address"]):
            errors.append(
                f"landmark {name} is at 0x{symbols[name]:06X}; "
                f"layout declares {landmark['address']}"
            )
    return len(landmarks)


def check_image(layout: dict, rom_path: Path, errors: list[str]) -> int:
    if not rom_path.is_file():
        errors.append(f"built ROM is missing: {rom_path}")
        return 0
    data = rom_path.read_bytes()
    image = layout["rom_image"]
    if len(data) != number(image["size"]):
        errors.append(f"{rom_path}: size {len(data)}; layout declares {image['size']}")
        return 0

    padding = number(image["padding_byte"])
    checked = 0
    for gap in image.get("gaps", []):
        start, end = number(gap["start"]), number(gap["end"])
        expected_size = end - start + 1
        if expected_size != number(gap["size"]):
            errors.append(f"gap {gap['start']}-{gap['end']} has inconsistent size")
            continue
        wrong = next((offset for offset in range(start, end + 1) if data[offset] != padding), None)
        if wrong is not None:
            errors.append(
                f"gap {gap['start']}-{gap['end']} is not all {image['padding_byte']}; "
                f"first mismatch at 0x{wrong:06X}"
            )
        checked += expected_size
    return checked


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--layout", default="config/rom_layout.json")
    parser.add_argument("--listing", default="build/main.lst")
    parser.add_argument("--rom", default="asbuilt.bin")
    args = parser.parse_args()

    layout_path = Path(args.layout)
    layout = json.loads(layout_path.read_text(encoding="utf-8"))
    if layout.get("schema_version") != 1:
        print("[ERROR] unsupported ROM layout schema", file=sys.stderr)
        return 1
    listing_path = Path(args.listing)
    if not listing_path.is_file():
        print(f"[ERROR] listing is missing: {listing_path}", file=sys.stderr)
        return 1
    lines = listing_path.read_text(encoding="latin-1").splitlines()

    errors: list[str] = []
    modules = check_modules(layout, lines, errors)
    landmarks = check_landmarks(layout, lines, errors)
    padding = check_image(layout, Path(args.rom), errors)
    if errors:
        for error in errors:
            print(f"[ERROR] {error}", file=sys.stderr)
        return 1
    print(
        f"[OK] ROM layout: {modules} modules, {landmarks} landmarks, "
        f"{padding} padding bytes"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
