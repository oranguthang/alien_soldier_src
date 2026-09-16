#!/usr/bin/env python3
"""Validate named RAM expectations in captured runtime scenarios."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

from runtime_state import Genstate, M68K_RAM


EQUATE = re.compile(r"^([A-Za-z_][A-Za-z0-9_]*)\s+equ\s+\$([0-9A-F]+)", re.IGNORECASE)


def number(value: str | int) -> int:
    return value if isinstance(value, int) else int(value, 0)


def ram_symbols(path: Path) -> dict[str, int]:
    symbols = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        match = EQUATE.match(line)
        if match:
            symbols[match.group(1)] = int(match.group(2), 16) & 0xFFFFFF
    return symbols


def validate(config: dict, capture_root: Path, symbols: dict[str, int]) -> list[str]:
    errors: list[str] = []
    readers = {"u8": Genstate.m68k_u8, "u16": Genstate.m68k_u16, "u32": Genstate.m68k_u32}
    minimum = int(config.get("minimum_expectations_per_scenario", 2))
    for scenario in config["scenarios"]:
        frame = int(scenario["frame"])
        path = capture_root / scenario["id"] / f"{frame:06d}.genstate"
        try:
            state = Genstate.read(path)
        except (OSError, ValueError, KeyError) as error:
            errors.append(f"{scenario['id']}: cannot read capture: {error}")
            continue
        if state.rom_checksum != number(config["rom_checksum"]):
            errors.append(f"{scenario['id']}: ROM checksum is 0x{state.rom_checksum:08X}")
        if len(state.sections.get(M68K_RAM, b"")) != 65536:
            errors.append(f"{scenario['id']}: M68K RAM section is not 64 KiB")
            continue
        if len(scenario.get("expectations", [])) < minimum:
            errors.append(f"{scenario['id']}: fewer than {minimum} named expectations")
        for expectation in scenario.get("expectations", []):
            symbol = expectation["symbol"]
            if symbol not in symbols:
                errors.append(f"{scenario['id']}: unknown RAM symbol {symbol}")
                continue
            address = number(expectation["address"])
            offset = number(expectation.get("offset", 0))
            if (symbols[symbol] + offset) & 0xFFFFFF != address:
                errors.append(f"{scenario['id']}: {symbol}+0x{offset:X} does not equal 0x{address:06X}")
                continue
            value_type = expectation["type"]
            if value_type not in readers:
                errors.append(f"{scenario['id']}: unsupported type {value_type}")
                continue
            actual = readers[value_type](state, address)
            expected = number(expectation["equals"])
            if actual != expected:
                field = expectation.get("field", symbol)
                errors.append(
                    f"{scenario['id']}: {field} at 0x{address:06X} is "
                    f"0x{actual:X}, expected 0x{expected:X}"
                )
    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scenarios", default="config/runtime_scenarios.json")
    parser.add_argument("--capture-dir", default="runtime/captures")
    parser.add_argument("--ram-map", default="src/ram_addrs.inc")
    args = parser.parse_args()
    config = json.loads(Path(args.scenarios).read_text(encoding="utf-8"))
    errors = validate(config, Path(args.capture_dir), ram_symbols(Path(args.ram_map)))
    if errors:
        for error in errors:
            print(f"[ERROR] {error}", file=sys.stderr)
        return 1
    expectations = sum(len(item["expectations"]) for item in config["scenarios"])
    movies = len({item["movie"] for item in config["scenarios"]})
    print(f"[OK] runtime: {len(config['scenarios'])} scenarios from {movies} movies, "
          f"{expectations} named RAM assertions")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
