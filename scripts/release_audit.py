#!/usr/bin/env python3
"""Audit the static evidence behind the release contract and its manifest."""

from __future__ import annotations

import argparse
import json
import subprocess
from pathlib import Path
import re

import lint_project
import lint_source


HEX_DIGEST = re.compile(r"^[0-9a-f]+$")
GENERIC_NAME_BASES = (
    "The name follows the instruction-level condition or side effect and its in-module callers.",
    "All named predecessor paths converge at this RTS.",
    "The enclosing DBF or countdown branch returns to this label.",
    "An indexed load or relative dispatch reads this table directly.",
    "The state or subtype becomes a table offset here before an indirect jump.",
    "State-table membership, explicit writes to controller field 4, and direct branch flow establish this Medusa state-machine control point without assigning an unverified attack name.",
    "State-table membership, explicit writes to controller field 4, and direct branch flow establish this Sirene state-machine control point without assigning an unverified attack name.",
    "The routines interpret pose commands, interpolate frame data, distribute values across the 28-part Sirene metasprite, and begin shared part traversal.",
    "Direct branches inside the named Valkirie controller state establish this convergence path observable role.",
    "Incoming control flow and the fields read or written at this address establish the narrowly stated helper role.",
    "All documented wait, timer, or convergence branches at this state converge on this shared return.",
    "The label follows the local options-screen control flow and the state field read or written at that branch.",
    "The adjacent comparison and direct field update establish this narrowly named branch role.",
    "The documented wait or limit branches converge on this shared return address.",
    "Branches and loop bounds inside the enclosing palette, tile-index, DMA, or asset-set routine establish the control-flow role stated by this name.",
    "The enclosing state-machine branches converge at this return; the name is scoped to that owning routine.",
    "Direct branch conditions and the adjacent controller-field writes establish this narrowly named path.",
    "Direct branches and field accesses in the auxiliary-group update establish this attached, launch, rotation, timer, or velocity-convergence path.",
    "Direct control flow enters here while installing the matching even value in controller field 4 and initializing that state fields.",
    "This state convergence path loads its pose script and branches to the shared Valkirie animation/metasprite renderer.",
    "The 19-entry controller table selects this path for the matching field-4 state code; the body processes that state animation events and transitions.",
    "All documented speed-limit branches converge at this shared return address.",
    "Direct palette-RAM accesses and the fade or color-update caller establish this palette-specific role.",
    "The renderer writes Genesis OAM Y/size-link/tile/X entries, clips them to the screen bounds, and chains them through 64 priority buckets.",
    "Bit 11 selects horizontal reflection, bit 15 terminates mapping entries or preserves object priority, and the local control flow establishes the narrower role stated by the symbol.",
    "Bit 11 selects horizontal reflection; this table-frame path retains object bit 15 before XOR-merging entry attributes, and the local control flow establishes the narrower role stated by the symbol.",
    "Gfx_LoadPaletteCommand proves the destination/count/CRAM-word format, while the direct caller or Boss_LoadAssetSet record proves the owner scope; plural and bank names retain multiple embedded command boundaries without guessing visual colors.",
    "The local tests, loop direction, and completion writes establish the narrower branch role stated by the symbol.",
    "The local branch, timer, cache, pointer, or transfer operation establishes the narrower role stated by the symbol.",
    "The local timer, radial-distance update, sprite write, branch, or return directly establishes the narrower role stated by the symbol name.",
    "Its callers and destination fields distinguish rendering work from game-state, score, or player behavior.",
    "The immediate nibble test, attribute branch, DMA setup, tilemap write, loop, or return establishes the narrower role stated by the symbol name.",
    "The local cursor, slot offset, direction bits, tile position, or force-name operation establishes the narrower role stated by the symbol.",
    "Call and branch references in the fresh assembler listing confirm the definition address and scope.",
    "The local comparison, delay, clamp, loop, or return at this address directly establishes the narrower role stated by the symbol name.",
    "The local angle, radius, directional-bit, slot-offset, or close-transition operations establish the narrower role stated by this symbol.",
    "The counting frames return here.",
    "The local phase, offset-table, tile-buffer, palette, dither-pattern, or VDP queue operation establishes the narrower role stated by the symbol.",
    "The local input, lookup, selection, or rendering operation acts on that controller-layout index or its stored flag byte.",
    "Boss_LoadAssetSet consumes this record as entity type, optional graphics-load-list pointer, and optional palette-command pointer; the caller and value's dispatch-table slot establish the stated owner or neutral entity type.",
    "The owning asset-set record points here, and Data_ProcessPointer consumes the tagged source/VRAM records through the $FFFF terminator.",
    "The setup state table reaches this path after loadout and controller selection; it renders EXIT, handles confirmation/return input, or advances the closing sprite fade.",
    "The routine compares the live setup-screen X position with its target and changes it by one signed unit until equal.",
    "WeaponSetup_StateHandlerOffsets dispatches the ROM-ordered loadout, controller-layout, exit, fade, text, confirmation, and idle states.",
    "The local input, state, text, rendering, or initialization operations establish the narrower role stated by the symbol.",
    "MessageSequenceState directly indexes the ROM-ordered handler table; this entry dispatches, advances, ends, or finalizes that shared stage/result/boss/cutscene message state machine.",
    "The local state test, table lookup, state write, or graphics-finalization call establishes the narrower role stated by the symbol name.",
    "The local path selects, highlights, or navigates the encoded SHOOTING MODE, MOVING, and FIX strings and updates ShootingMode.",
    "WeaponStateIndex dispatches the shared weapon-state machine while WeaponSlotOffset selects one of the four WeaponSlotConfig words.",
    "The local cooldown, loadout-selection, state-transition, remaining-ammunition, or shared-parameter operations establish the narrower role stated by this symbol.",
    "The initializer and update paths implement a two-phase spawner: timed radial particles followed by directional acceleration and horizontal trail emission.",
    "The pose interpreter reads event commands, loop/end markers, frame delays, and frame-data offsets before updating the 19-angle interpolation buffer.",
    "The routine updates two effect anchors, clamps their coordinates, and writes mirrored distortion-offset fields; it does not allocate a projectile.",
    "The routines interpret $FFFF/$FFFE pose commands, load frame data, calculate interpolation deltas, and prepare the pose buffer; no projectile slot is allocated.",
    "The helper and its branches derive or apply Valkirie facing-relative direction from the player delta and field $54.",
    "The visible half of the blink returns here.",
    "The backward loop edge repeats the owning routine's named operation over its fixed linked-object or output range.",
    "The helper compares Medusa X against a requested target and changes signed horizontal velocity by fixed acceleration steps within hard limits.",
)


def load(root: Path, relative: str) -> dict:
    return json.loads((root / relative).read_text(encoding="utf-8"))


def count_generic_name_bases(records: list[dict]) -> int:
    return sum(
        any(basis in GENERIC_NAME_BASES for basis in record.get("basis", []))
        for record in records
    )


STATUSES = {"satisfied", "partial", "planned", "unsupported", "not_applicable"}
MANIFEST_FIELDS = (
    "release_line", "release", "release_kind", "tag", "status", "reference",
    "included_scope", "excluded_scope", "delta", "requirements", "profiles",
    "runtime_coverage", "toolchain", "artifacts", "aggregate_gates",
    "layout_deviations", "licensing", "provenance",
)


def tracked_history_paths(root: Path) -> list[str] | None:
    """Every path ever tracked in the reachable history, or None without git."""
    try:
        result = subprocess.run(
            ["git", "log", "--all", "--pretty=format:", "--name-only"],
            cwd=root, capture_output=True, text=True, check=True, errors="replace",
        )
    except (OSError, subprocess.CalledProcessError):
        return None
    return sorted({line.strip() for line in result.stdout.splitlines() if line.strip()})


def audit_manifest(root: Path, manifest: dict, makefile: str, runtime: dict) -> list[str]:
    """Resolve every claim the release manifest makes to something that exists."""
    errors: list[str] = []
    for field in MANIFEST_FIELDS:
        if field not in manifest:
            errors.append(f"release manifest is missing {field}")
    if manifest.get("release_line") != "1.0":
        errors.append("release manifest does not declare release line 1.0")
    if manifest.get("release_kind") != "preservation":
        errors.append("release manifest does not declare a preservation release")
    if manifest.get("status") not in {"development", "tag-ready", "tagged"}:
        errors.append("release manifest has an unknown status")

    excluded_ids = {item["id"] for item in manifest.get("excluded_scope", [])}
    excluded_ids |= {
        item["registry"] for item in manifest.get("excluded_scope", []) if "registry" in item
    }
    for item in manifest.get("excluded_scope", []):
        if item.get("status") not in STATUSES:
            errors.append(f"excluded scope {item.get('id')} has an unknown status")
        if item.get("status") != "not_applicable" and not item.get("control"):
            errors.append(f"excluded scope {item.get('id')} declares no control")

    scenario_ids = {item["id"] for item in runtime.get("scenarios", [])}
    artifact_ids = {item["id"] for item in manifest.get("artifacts", [])}
    for name, requirement in manifest.get("requirements", {}).items():
        if requirement.get("status") not in STATUSES:
            errors.append(f"requirement {name} has an unknown status")
        if not requirement.get("statement"):
            errors.append(f"requirement {name} has no statement")
        evidence = requirement.get("evidence", {})
        for target in evidence.get("targets", []):
            if not re.search(rf"^{re.escape(target)}\s*:", makefile, re.MULTILINE):
                errors.append(f"requirement {name} cites missing target {target}")
        for relative in evidence.get("files", []):
            if not (root / relative).exists():
                errors.append(f"requirement {name} cites missing path {relative}")
        for scenario in evidence.get("scenarios", []):
            if scenario not in scenario_ids:
                errors.append(f"requirement {name} cites unknown scenario {scenario}")
        for artifact in evidence.get("artifacts", []):
            if artifact not in artifact_ids:
                errors.append(f"requirement {name} cites unknown artifact {artifact}")
        if requirement.get("status") in {"partial", "planned", "unsupported"}:
            named = set(requirement.get("excluded", []))
            if not named & excluded_ids:
                errors.append(
                    f"requirement {name} is {requirement['status']} without naming an excluded scope"
                )

    for deviation in manifest.get("layout_deviations", []):
        for field in ("rule_id", "actual_path", "reason", "equivalent_control"):
            if not deviation.get(field):
                errors.append(f"layout deviation {deviation.get('rule_id')} is missing {field}")

    for gate in manifest.get("aggregate_gates", {}).values():
        for command in gate:
            target = command.removeprefix("make ")
            if not re.search(rf"^{re.escape(target)}\s*:", makefile, re.MULTILINE):
                errors.append(f"aggregate gate cites missing target {command}")

    for artifact in manifest.get("artifacts", []):
        if artifact.get("tracked"):
            errors.append(f"artifact {artifact['id']} is declared as tracked")
        if len(artifact.get("sha1", "")) != 40 or len(artifact.get("sha256", "")) != 64:
            errors.append(f"artifact {artifact['id']} has an invalid digest")

    history = tracked_history_paths(root)
    if history is None:
        errors.append("git history is unavailable, so tracked payloads cannot be audited")
    else:
        forbidden = tuple(manifest.get("prohibited_tracked_extensions", []))
        prefixes = tuple(manifest.get("prohibited_tracked_prefixes", []))
        offenders = [
            path for path in history
            if (forbidden and path.endswith(forbidden)) or (prefixes and path.startswith(prefixes))
        ]
        if offenders:
            errors.append(
                f"{len(offenders)} ROM-derived path(s) appear in the reachable history: "
                f"{offenders[:5]}"
            )

    if manifest.get("status") == "tag-ready":
        errors.extend(audit_tag_ready(root, manifest))
    elif manifest.get("status") == "tagged":
        errors.extend(audit_tagged(root, manifest))
    return errors


def audit_tag_ready(root: Path, manifest: dict) -> list[str]:
    """The pre-tag conditions that only apply once the manifest claims readiness."""
    errors: list[str] = []
    try:
        status = subprocess.run(
            ["git", "status", "--porcelain"],
            cwd=root, capture_output=True, text=True, check=True, errors="replace",
        ).stdout.strip()
        tags = subprocess.run(
            ["git", "tag", "--list", manifest["tag"]],
            cwd=root, capture_output=True, text=True, check=True, errors="replace",
        ).stdout.strip()
    except (OSError, subprocess.CalledProcessError):
        return ["tag-ready status claimed but git state cannot be read"]
    if status:
        errors.append("tag-ready status claimed with a dirty working tree")
    if tags:
        errors.append(f"tag-ready status claimed but {manifest['tag']} already exists")
    return errors


def audit_tagged(root: Path, manifest: dict) -> list[str]:
    """Require an annotated tag on this release, not merely a tagged claim.

    The one permitted successor to the tagged commit is the metadata commit
    that records the new status in the manifest and release document. Any
    later source change needs a new release candidate and gate run.
    """
    tag = manifest.get("tag", "")
    ref = f"refs/tags/{tag}"

    def git(*args: str) -> str:
        return subprocess.run(
            ["git", *args], cwd=root, capture_output=True, text=True,
            check=True, errors="replace",
        ).stdout.strip()

    try:
        kind = git("cat-file", "-t", ref)
        target = git("rev-parse", f"{ref}^{{commit}}")
        head = git("rev-parse", "HEAD")
        tag_object = git("cat-file", "-p", ref)
    except (OSError, subprocess.CalledProcessError):
        return [f"tagged status claimed but {tag} cannot be resolved"]

    errors: list[str] = []
    try:
        if git("status", "--porcelain", "--untracked-files=all"):
            errors.append("tagged status claimed with a dirty working tree")
    except (OSError, subprocess.CalledProcessError):
        errors.append("tagged status claimed but working-tree state cannot be read")
    if kind != "tag":
        errors.append(f"tagged status claimed but {tag} is not annotated")
    if not tag_object.partition("\n\n")[2].strip():
        errors.append(f"tagged status claimed but {tag} has no release description")

    if target != head:
        try:
            parent = git("rev-parse", "HEAD^")
        except (OSError, subprocess.CalledProcessError):
            parent = ""
        if target != parent:
            errors.append(f"tagged status claimed but {tag} does not identify this release")
        else:
            try:
                changed = set(git("diff", "--name-only", target, head).splitlines())
            except (OSError, subprocess.CalledProcessError):
                changed = {"<unreadable>"}
            metadata = {
                "config/source_reconstruction_1_0.json",
                "docs/source_reconstruction_1_0.md",
            }
            if not changed or changed - metadata:
                errors.append("tagged status claimed after non-metadata changes")

    try:
        at_tag = json.loads(git("show", f"{target}:config/source_reconstruction_1_0.json"))
    except (OSError, subprocess.CalledProcessError, json.JSONDecodeError):
        errors.append(f"tagged status claimed but {tag} has no readable release manifest")
    else:
        expected = "tagged" if target == head else "tag-ready"
        if at_tag.get("status") != expected:
            errors.append(f"tagged status claimed but {tag} targets a {at_tag.get('status')} manifest")
    return errors


RAM_EQUATE = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*\s+equ\s", re.MULTILINE)


def audit_counters(
    root: Path, manifest: dict, policy: dict, layout: dict, stats: dict[str, int]
) -> list[str]:
    """Recount every figure the documentation quotes.

    Prose counters go stale silently: a module split or a rename moves the real
    number and nothing complains. The manifest declares each one and this
    recounts it from the artefact that owns it, so a drifted figure fails the
    release rather than surviving into a tag.
    """
    errors: list[str] = []
    declared = manifest.get("counters")
    if not declared:
        return ["the manifest declares no counters to recount"]
    inventory = lint_source.scan(policy, root)
    ram_map = (root / "src/ram_addrs.inc").read_text(encoding="utf-8")
    name_audit = load(root, "config/name_audit.json")
    actual = {
        "modules": len(layout["modules"]),
        "assets": stats.get("assets", -1),
        "runtime_scenarios": stats.get("runtime_scenarios", -1),
        "runtime_expectations": stats.get("runtime_expectations", -1),
        "definitions": len(inventory.definitions),
        "provenance_mappings": len(inventory.provenance),
        "name_audit_records": len(name_audit["records"]),
        "generic_evidence_bases": count_generic_name_bases(name_audit["records"]),
        "hypothesis_name_records": sum(
            record.get("evidence") == "hypothesis"
            for record in name_audit["records"]
        ),
        "ram_fields": len(RAM_EQUATE.findall(ram_map)),
        "declared_subsystems": len(policy["naming"]["subsystem_vocabulary"]),
        "resolved_branch_targets": inventory.call_targets,
        "tracked_text_files": len(lint_project.tracked_text_files(root)),
        "dma_transferred_payloads": sum(
            1 for item in load(root, "assets/manifest.json")["assets"]
            if item["region"] in set(layout["dma_alignment"]["transferred_regions"])
        ),
    }
    for name, value in sorted(declared.items()):
        if name not in actual:
            errors.append(f"counter {name} has no source to recount it from")
        elif actual[name] != value:
            errors.append(f"counter {name} says {value} but the source has {actual[name]}")
    missing = sorted(set(actual) - set(declared))
    if missing:
        errors.append(f"the manifest leaves these counters undeclared: {missing}")
    provenance = manifest.get("provenance", {})
    for field, source in (
        ("exact_address_records", "name_audit_records"),
        ("provenance_markers", "provenance_mappings"),
    ):
        if provenance.get(field) != actual[source]:
            errors.append(
                f"provenance {field} says {provenance.get(field)} "
                f"but the source has {actual[source]}"
            )
    if manifest.get("status") in {"tag-ready", "tagged"} and actual[
        "generic_evidence_bases"
    ]:
        errors.append("tag-ready release retains generic name-evidence bases")
    if manifest.get("status") in {"tag-ready", "tagged"} and actual[
        "hypothesis_name_records"
    ]:
        errors.append("tag-ready release retains hypothesis-level name records")
    stats["counters"] = len(declared)
    return errors


def audit(root: Path, contract: dict) -> tuple[list[str], dict[str, int]]:
    errors: list[str] = []
    stats: dict[str, int] = {}
    threshold = contract["thresholds"]
    assets = load(root, "assets/manifest.json")
    layout = load(root, "config/rom_layout.json")
    policy = load(root, "config/source_policy.json")
    source_contract = load(root, "config/source_reconstruction_1_0.json")
    runtime = load(root, "config/runtime_scenarios.json")
    toolchain = load(root, "config/toolchain.json")

    if contract.get("release") != "0.5" or contract.get("status") != "development":
        errors.append("0.5 must remain explicitly marked as a development release")
    if contract.get("target_contract") != "Source Reconstruction 1.0":
        errors.append("target contract is not Source Reconstruction 1.0")
    if source_contract.get("release", {}).get("name") != contract.get("target_contract"):
        errors.append("release target differs from source reconstruction contract")
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
    if len(modules) < threshold["minimum_module_count"]:
        errors.append(
            f"layout has {len(modules)} modules; expected at least "
            f"{threshold['minimum_module_count']}"
        )
    if layout["target"]["max_module_lines"] != threshold["max_module_lines"]:
        errors.append("module line ceiling differs from release contract")
    source_shape = source_contract["source_shape"]
    strict_line_limit = source_shape["default_maximum_module_lines"]
    if threshold["max_module_lines"] != strict_line_limit:
        errors.append("release module line ceiling is weaker than source contract")
    if policy["unknowns"]["maximum_address_derived_definitions"] != source_shape[
        "maximum_address_derived_definitions"
    ]:
        errors.append("address-derived ceiling differs from source contract")
    generic_pattern = re.compile(source_shape["generic_container_pattern"], re.IGNORECASE)
    generic_modules = [
        item["file"] for item in modules if generic_pattern.search(Path(item["file"]).stem)
    ]
    stats["generic_modules"] = len(generic_modules)
    if len(generic_modules) > source_shape["maximum_generic_container_names"]:
        errors.append(f"layout contains generic module names: {generic_modules}")
    if layout["target"]["cartridge_size"] != canonical["size"]:
        errors.append("layout cartridge size differs from canonical ROM")
    if policy["provenance"]["minimum_unique_mappings"] < threshold["minimum_provenance_mappings"]:
        errors.append("source policy weakened the provenance floor")

    scenarios = runtime["scenarios"]
    stats["runtime_scenarios"] = len(scenarios)
    stats["runtime_expectations"] = sum(len(item["expectations"]) for item in scenarios)
    actual_ids = [item["id"] for item in scenarios]
    if actual_ids != contract["required_runtime_ids"]:
        errors.append("runtime scenario IDs/order differ from release contract")
    if len(scenarios) != threshold["runtime_scenarios"]:
        errors.append(f"runtime contract has {len(scenarios)} scenarios")
    if stats["runtime_expectations"] < threshold["minimum_runtime_expectations"]:
        errors.append(f"runtime contract has {stats['runtime_expectations']} expectations")
    movies = runtime["movies"]
    for movie_id, movie in movies.items():
        if not (root / movie["path"]).is_file():
            errors.append(f"runtime movie {movie_id} is missing: {movie['path']}")
        if not re.fullmatch(r"[0-9a-f]{64}", movie["sha256"]):
            errors.append(f"runtime movie {movie_id} has no pinned SHA-256")
    for scenario in scenarios:
        if scenario["movie"] not in movies:
            errors.append(f"runtime scenario {scenario['id']} names undeclared movie {scenario['movie']}")
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
    for command in source_contract["required_commands"]:
        target = command.removeprefix("make ")
        if not re.search(rf"^{re.escape(target)}\s*:", makefile, re.MULTILINE):
            errors.append(f"source reconstruction command missing: {command}")

    errors.extend(audit_manifest(root, source_contract, makefile, runtime))
    errors.extend(audit_counters(root, source_contract, policy, layout, stats))
    stats["requirements"] = len(source_contract.get("requirements", {}))
    stats["layout_deviations"] = len(source_contract.get("layout_deviations", []))
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
        f"[OK] release audit: {stats['assets']} assets, {stats['modules']} modules, "
        f"{stats['runtime_scenarios']} runtime scenarios with "
        f"{stats['runtime_expectations']} named RAM expectations, "
        f"{stats['requirements']} resolved requirements, "
        f"{stats['counters']} recounted figures, "
        f"{stats['layout_deviations']} declared layout deviations"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
