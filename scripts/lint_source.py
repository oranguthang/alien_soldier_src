#!/usr/bin/env python3
"""Enforce structural, provenance, and unknown-name source policy."""

from __future__ import annotations

import argparse
import json
import re
import sys
from dataclasses import dataclass
from pathlib import Path


LABEL = re.compile(r"^([A-Za-z_][A-Za-z0-9_]*):")
EQUATE = re.compile(r"^([A-Za-z_][A-Za-z0-9_]*)\s+equ\b", re.IGNORECASE)
INCLUDE = re.compile(r'^\s*include\s+"([^"]+)"', re.IGNORECASE)
WAS = re.compile(r";\s*was:\s*([A-Za-z_][A-Za-z0-9_]*)\s*$")
EMITTING = re.compile(
    r"^\s*(?:dc\.[bwl]|dcb\.[bwl]|binclude|incbin|org0?|align0?|cnop0?)\b",
    re.IGNORECASE,
)


@dataclass(frozen=True)
class Inventory:
    definitions: dict[str, str]
    provenance: dict[str, tuple[str, str]]
    address_derived: dict[str, str]
    errors: list[str]


def source_files(root: Path) -> list[Path]:
    return sorted(root.rglob("*.s")) + sorted(root.rglob("*.inc"))


def scan(policy: dict, project_root: Path) -> Inventory:
    source_root = project_root / policy["assembly_root"]
    old_name = re.compile(policy["provenance"]["legacy_name_pattern"], re.IGNORECASE)
    address_name = re.compile(policy["unknowns"]["address_derived_name_pattern"], re.IGNORECASE)
    entrypoint = project_root / policy["entrypoint"]
    layout = json.loads((project_root / policy["layout"]).read_text(encoding="utf-8"))
    line_limit = layout["target"]["max_module_lines"]

    definitions: dict[str, str] = {}
    provenance: dict[str, tuple[str, str]] = {}
    old_symbols: dict[str, str] = {}
    address_derived: dict[str, str] = {}
    errors: list[str] = []

    for path in source_files(source_root):
        relative = path.relative_to(project_root).as_posix()
        text = path.read_text(encoding="utf-8")
        lines = text.splitlines()
        if path.suffix == ".s" and path != entrypoint and len(lines) > line_limit:
            errors.append(f"{relative}: {len(lines)} lines exceeds limit {line_limit}")

        current_label: str | None = None
        for number, line in enumerate(lines, 1):
            where = f"{relative}:{number}"
            if line.rstrip(" \t") != line:
                errors.append(f"{where}: trailing whitespace")

            match = LABEL.match(line) or EQUATE.match(line)
            if match:
                name = match.group(1)
                current_label = name
                if name in definitions:
                    errors.append(f"{where}: {name} already defined at {definitions[name]}")
                else:
                    definitions[name] = where
                if address_name.fullmatch(name):
                    address_derived[name] = where

            marker = WAS.search(line)
            if marker:
                legacy = marker.group(1)
                if not old_name.fullmatch(legacy):
                    errors.append(f"{where}: malformed legacy name {legacy}")
                if current_label is None:
                    errors.append(f"{where}: provenance marker has no owning global label")
                elif current_label in provenance:
                    errors.append(f"{where}: duplicate provenance for {current_label}")
                elif legacy in old_symbols:
                    errors.append(f"{where}: {legacy} already mapped at {old_symbols[legacy]}")
                else:
                    provenance[current_label] = (legacy, where)
                    old_symbols[legacy] = where

    minimum = policy["provenance"]["minimum_unique_mappings"]
    if len(provenance) < minimum:
        errors.append(f"provenance has {len(provenance)} mappings; policy requires at least {minimum}")
    maximum = policy["unknowns"]["maximum_address_derived_definitions"]
    if len(address_derived) > maximum:
        errors.append(
            f"source has {len(address_derived)} address-derived definitions; ceiling is {maximum}"
        )

    main_text = entrypoint.read_text(encoding="utf-8")
    for number, line in enumerate(main_text.splitlines(), 1):
        if EMITTING.match(line):
            errors.append(f"{policy['entrypoint']}:{number}: entrypoint must not emit bytes")
    actual_modules = [
        match.group(1).replace("\\", "/")
        for line in main_text.splitlines()
        if (match := INCLUDE.match(line)) and match.group(1).endswith(".s")
    ]
    expected_modules = [entry["file"] for entry in layout["modules"]]
    if actual_modules != expected_modules:
        errors.append("entrypoint module order differs from config/rom_layout.json")
    for included in [
        match.group(1)
        for line in main_text.splitlines()
        if (match := INCLUDE.match(line))
    ]:
        if not (project_root / included).is_file():
            errors.append(f"{policy['entrypoint']}: missing include {included}")

    return Inventory(definitions, provenance, address_derived, errors)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--policy", default="config/source_policy.json")
    args = parser.parse_args()
    project_root = Path.cwd()
    policy = json.loads((project_root / args.policy).read_text(encoding="utf-8"))
    if policy.get("schema_version") != 1:
        print("[ERROR] unsupported source policy schema", file=sys.stderr)
        return 1
    inventory = scan(policy, project_root)
    if inventory.errors:
        for error in inventory.errors[:100]:
            print(f"[ERROR] {error}", file=sys.stderr)
        if len(inventory.errors) > 100:
            print(f"[ERROR] ... and {len(inventory.errors) - 100} more", file=sys.stderr)
        return 1
    print(
        f"[OK] source policy: {len(inventory.definitions)} definitions, "
        f"{len(inventory.provenance)} provenance mappings, "
        f"{len(inventory.address_derived)} address-derived unknowns"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
