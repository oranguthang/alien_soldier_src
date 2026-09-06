#!/usr/bin/env python3
"""Verify that the exported symbol map covers layout and runtime contracts."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re


SYMBOL_ROW = re.compile(r"^([0-9A-Fa-f]{8})\s+([A-Za-z_][A-Za-z0-9_]*)$")


def number(value: str | int) -> int:
    if isinstance(value, int):
        return value
    return int(value, 16) if value.lower().startswith("0x") else int(value, 0)


def load_symbols(path: Path) -> tuple[dict[int, str], dict[str, int], list[str]]:
    by_address: dict[int, str] = {}
    by_name: dict[str, int] = {}
    errors: list[str] = []
    for line_number, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        match = SYMBOL_ROW.match(raw)
        if not match:
            errors.append(f"{path}:{line_number}: invalid symbol row")
            continue
        address = int(match.group(1), 16)
        name = match.group(2)
        if address > 0xFFFFFF:
            errors.append(f"{path}:{line_number}: address exceeds the 68000 bus")
        if address in by_address:
            errors.append(f"{path}:{line_number}: duplicate address 0x{address:06X}")
        if name in by_name:
            errors.append(f"{path}:{line_number}: duplicate name {name}")
        by_address[address] = name
        by_name[name] = address
    return by_address, by_name, errors


def required_symbols(layout: dict, runtime: dict) -> dict[str, int]:
    required = {
        item["symbol"]: number(item["address"])
        for item in layout["rom_image"]["landmarks"]
    }
    for scenario in runtime["scenarios"]:
        for expectation in scenario["expectations"]:
            symbol = expectation["symbol"]
            base = number(expectation["address"]) - number(expectation.get("offset", 0))
            previous = required.setdefault(symbol, base)
            if previous != base:
                raise ValueError(f"conflicting required addresses for {symbol}")
    return required


def validate(
    by_address: dict[int, str],
    by_name: dict[str, int],
    required: dict[str, int],
    minimum: int,
) -> list[str]:
    errors = []
    if len(by_address) < minimum:
        errors.append(f"only {len(by_address)} addressed symbols; expected at least {minimum}")
    for name, address in required.items():
        if name not in by_name:
            errors.append(f"required symbol missing: {name}")
        elif by_name[name] != address:
            errors.append(
                f"{name} is 0x{by_name[name]:06X}; expected 0x{address:06X}"
            )
        elif by_address.get(address) != name:
            errors.append(f"{name} is not canonical at 0x{address:06X}")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--symbols", required=True)
    parser.add_argument("--layout", required=True)
    parser.add_argument("--runtime", required=True)
    parser.add_argument("--minimum", type=int, default=15000)
    args = parser.parse_args()

    by_address, by_name, errors = load_symbols(Path(args.symbols))
    layout = json.loads(Path(args.layout).read_text(encoding="utf-8"))
    runtime = json.loads(Path(args.runtime).read_text(encoding="utf-8"))
    required = required_symbols(layout, runtime)
    errors.extend(validate(by_address, by_name, required, args.minimum))
    if errors:
        for error in errors:
            print(f"[ERROR] {error}")
        return 1
    rom = sum(address < 0x400000 for address in by_address)
    mapped = len(by_address) - rom
    print(
        f"[OK] symbols: {len(by_address)} canonical addresses "
        f"({rom} ROM, {mapped} RAM/hardware), {len(required)} contract symbols"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
