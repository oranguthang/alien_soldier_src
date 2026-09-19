#!/usr/bin/env python3
"""Verify that the exported symbol map covers layout and runtime contracts."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re

from extract_symbols import EQU, LABEL, LISTING_ROW, SOURCE_COLUMN


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


def load_all_listing_names(path: Path) -> tuple[dict[str, int], list[str]]:
    """Keep aliases discarded by the canonical symbol export."""
    by_name: dict[str, int] = {}
    errors: list[str] = []
    with path.open(encoding="latin-1") as listing:
        for line_number, line in enumerate(listing, 1):
            row = LISTING_ROW.match(line)
            if not row or len(line) <= SOURCE_COLUMN:
                continue
            source = line[SOURCE_COLUMN:].lstrip()
            label = LABEL.match(source)
            equ = EQU.match(source)
            if label:
                name = label.group(1)
                address = int(row.group(1), 16) & 0xFFFFFF
            elif equ:
                name = equ.group(1)
                address = int(equ.group(2), 16) & 0xFFFFFF
            else:
                continue
            previous = by_name.setdefault(name, address)
            if previous != address:
                errors.append(
                    f"{path}:{line_number}: {name} has listing addresses "
                    f"0x{previous:06X} and 0x{address:06X}"
                )
    return by_name, errors


def validate_name_audit_addresses(
    records: list[dict], listing_names: dict[str, int]
) -> list[str]:
    """Compare every provenance record to its assembled, 24-bit bus address."""
    errors: list[str] = []
    seen: set[str] = set()
    for record in records:
        name = record["current_name"]
        if name in seen:
            errors.append(f"duplicate name-audit record for {name}")
        seen.add(name)
        if name not in listing_names:
            errors.append(f"name-audit symbol missing from listing: {name}")
            continue
        expected = number(record["address"]) & 0xFFFFFF
        actual = listing_names[name]
        if expected != actual:
            errors.append(
                f"name-audit {name} says 0x{expected:06X}; "
                f"listing has 0x{actual:06X}"
            )
    return errors


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
    parser.add_argument("--listing", required=True)
    parser.add_argument("--name-audit", required=True)
    parser.add_argument("--minimum", type=int, default=15000)
    args = parser.parse_args()

    by_address, by_name, errors = load_symbols(Path(args.symbols))
    layout = json.loads(Path(args.layout).read_text(encoding="utf-8"))
    runtime = json.loads(Path(args.runtime).read_text(encoding="utf-8"))
    required = required_symbols(layout, runtime)
    errors.extend(validate(by_address, by_name, required, args.minimum))
    listing_names, listing_errors = load_all_listing_names(Path(args.listing))
    errors.extend(listing_errors)
    name_records = json.loads(Path(args.name_audit).read_text(encoding="utf-8"))["records"]
    errors.extend(validate_name_audit_addresses(name_records, listing_names))
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
    print(
        f"[OK] name provenance: {len(name_records)} exact-address records "
        "match the assembler listing"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
