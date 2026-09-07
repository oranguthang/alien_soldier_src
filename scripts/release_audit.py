#!/usr/bin/env python3
"""Audit the static evidence behind the release 0.5 contract."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re


HEX_DIGEST = re.compile(r"^[0-9a-f]+$")


def load(root: Path, relative: str) -> dict:
    return json.loads((root / relative).read_text(encoding="utf-8"))


def audit(root: Path, contract: dict) -> tuple[list[str], dict[str, int]]:
    errors: list[str] = []
    stats: dict[str, int] = {}
    threshold = contract["thresholds"]
    assets = load(root, "assets/manifest.json")
    layout = load(root, "config/rom_layout.json")
    policy = load(root, "config/source_policy.json")
    runtime = load(root, "config/runtime_scenarios.json")
    toolchain = load(root, "config/toolchain.json")

    if contract.get("release") != "0.5" or contract.get("status") != "development":
        errors.append("0.5 must remain explicitly marked as a development release")
    if contract.get("target_contract") != "Source Reconstruction 1.0":
        errors.append("target contract is not Source Reconstruction 1.0")
    excluded = {item["id"] for item in contract.get("excluded_profiles", [])}
    if "europe" not in excluded:
        errors.append("European profile is not explicitly excluded")

    reference = assets["reference_rom"]
    canonical = contract["canonical_profile"]
    for field in ("filename", "size", "sha1", "sha256"):
        contract_field = "rom_filename" if field == "filename" else field
        if reference.get(field) != canonical.get(contract_field):
            errors.append(f"canonical ROM {field} differs from asset manifest")
    if reference.get("profile") != canonical.get("id"):
        errors.append("canonical ROM profile differs from asset manifest")

    asset_rows = assets["assets"]
    stats["assets"] = len(asset_rows)
    if len(asset_rows) != threshold["asset_count"]:
        errors.append(f"asset manifest has {len(asset_rows)} rows")
    names = set()
    paths = set()
    for index, item in enumerate(asset_rows):
        regional_name = (item["region"], item["name"])
        if regional_name in names or item["path"] in paths:
            errors.append(f"asset row {index} duplicates a regional name or path")
        names.add(regional_name)
        paths.add(item["path"])
        start = int(item["address"], 16)
        end = int(item["end"], 16)
        if end - start != item["size"] or not (0 <= start < end <= reference["size"]):
            errors.append(f"asset row {index} has an invalid ROM range")
        digest = item.get("sha1", "")
        if len(digest) != 40 or not HEX_DIGEST.fullmatch(digest):
            errors.append(f"asset row {index} has an invalid SHA-1")

    modules = layout["modules"]
    stats["modules"] = len(modules)
    if len(modules) != threshold["module_count"]:
        errors.append(f"layout has {len(modules)} modules")
    if layout["target"]["max_module_lines"] != threshold["max_module_lines"]:
        errors.append("module line ceiling differs from release contract")
    if layout["target"]["cartridge_size"] != canonical["size"]:
        errors.append("layout cartridge size differs from canonical ROM")
    if policy["provenance"]["minimum_unique_mappings"] < threshold["minimum_provenance_mappings"]:
        errors.append("source policy weakened the provenance floor")

    scenarios = runtime["scenarios"]
    stats["runtime_scenarios"] = len(scenarios)
    actual_ids = [item["id"] for item in scenarios]
    if actual_ids != contract["required_runtime_ids"]:
        errors.append("runtime scenario IDs/order differ from release contract")
    if len(scenarios) != threshold["runtime_scenarios"]:
        errors.append(f"runtime contract has {len(scenarios)} scenarios")
    for scenario in scenarios:
        if len(scenario["expectations"]) < threshold["minimum_expectations_per_scenario"]:
            errors.append(f"runtime scenario {scenario['id']} has too few expectations")
        for expectation in scenario["expectations"]:
            if expectation.get("evidence") not in {
                "unknown", "hypothesis", "static", "runtime", "static+runtime", "confirmed"
            }:
                errors.append(f"runtime scenario {scenario['id']} has invalid evidence")

    components = {item["id"]: item for item in toolchain["components"]}
    if set(contract["required_toolchain_components"]) - components.keys():
        errors.append("a required toolchain component is missing")
    for component_id in contract["required_toolchain_components"]:
        component = components.get(component_id)
        if component is None:
            continue
        if component_id == "emulator" and not re.fullmatch(
            r"[0-9a-f]{40}", component.get("source_commit", "")
        ):
            errors.append("emulator source commit is not pinned")
        files = [entry for rows in component["files"].values() for entry in rows]
        if not files:
            errors.append(f"toolchain component {component_id} has no files")
        for item in files:
            digest = item.get("sha256", "")
            if len(digest) != 64 or not HEX_DIGEST.fullmatch(digest):
                errors.append(f"toolchain file {item.get('path')} has an invalid SHA-256")

    for relative in contract["required_documents"]:
        path = root / relative
        if relative != relative.lower() or not path.is_file():
            errors.append(f"required documentation missing or not lowercase: {relative}")

    makefile = (root / "Makefile").read_text(encoding="utf-8")
    for target in contract["release_interface"]:
        if not re.search(rf"^{re.escape(target)}\s*:", makefile, re.MULTILINE):
            errors.append(f"release interface target missing: {target}")
    return errors, stats


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--contract", default="config/release_0_5.json")
    args = parser.parse_args()
    root = Path.cwd()
    contract = load(root, args.contract)
    if contract.get("schema_version") != 1:
        print("[ERROR] unsupported release contract schema")
        return 1
    errors, stats = audit(root, contract)
    if errors:
        for error in errors:
            print(f"[ERROR] {error}")
        return 1
    print(
        f"[OK] release 0.5 audit: {stats['assets']} assets, "
        f"{stats['modules']} modules, {stats['runtime_scenarios']} runtime scenarios"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
