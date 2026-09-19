#!/usr/bin/env python3
"""Report missing name records and repeated evidence bases for source review."""

from __future__ import annotations

import argparse
from collections import Counter, defaultdict
from dataclasses import asdict, dataclass
import json
from pathlib import Path
import re


DEFINITION = re.compile(
    r"^([A-Za-z_][A-Za-z0-9_]*)(?::|\s+(?:equ|macro)\b)", re.IGNORECASE
)
PROVENANCE = re.compile(r";\s*was:\s*([A-Za-z_][A-Za-z0-9_]*)\s*$")


@dataclass(frozen=True)
class ProvenanceName:
    current_name: str
    legacy_name: str
    file: str
    line: int
    binary_backed_end: bool


@dataclass(frozen=True)
class BasisReference:
    address: str
    current_name: str
    file: str | None


@dataclass(frozen=True)
class DuplicateBasis:
    basis: str
    references: tuple[BasisReference, ...]


def source_files(source_root: Path) -> list[Path]:
    return sorted(source_root.rglob("*.s")) + sorted(source_root.rglob("*.inc"))


def definition_modules(source_root: Path) -> dict[str, str]:
    modules: dict[str, str] = {}
    for path in source_files(source_root):
        for line in path.read_text(encoding="utf-8").splitlines():
            if definition := DEFINITION.match(line):
                modules[definition.group(1)] = path.as_posix()
    return modules


def scan_provenance(source_root: Path) -> list[ProvenanceName]:
    records: list[ProvenanceName] = []
    for path in source_files(source_root):
        current_name: str | None = None
        previous_statement = ""
        for line_number, line in enumerate(
            path.read_text(encoding="utf-8").splitlines(), 1
        ):
            if definition := DEFINITION.match(line):
                current_name = definition.group(1)
            if marker := PROVENANCE.search(line):
                if current_name is None:
                    raise ValueError(
                        f"{path.as_posix()}:{line_number}: provenance has no definition"
                    )
                records.append(
                    ProvenanceName(
                        current_name=current_name,
                        legacy_name=marker.group(1),
                        file=path.as_posix(),
                        line=line_number,
                        binary_backed_end=(
                            current_name.endswith("_End")
                            and bool(re.search(r"\bbinclude\b", previous_statement, re.IGNORECASE))
                        ),
                    )
                )
            stripped = line.lstrip()
            if stripped and not stripped.startswith(";"):
                previous_statement = line
    return records


def audited_names(audit_path: Path) -> set[str]:
    audit = json.loads(audit_path.read_text(encoding="utf-8"))
    names: set[str] = set()
    for record in audit["records"]:
        names.add(record["current_name"])
        names.update(record.get("aliases", []))
    return names


def pending_records(
    source_root: Path, audit_path: Path
) -> tuple[list[ProvenanceName], list[ProvenanceName]]:
    provenance = scan_provenance(source_root)
    audited = audited_names(audit_path)
    return provenance, [item for item in provenance if item.current_name not in audited]


def duplicate_basis_groups(
    audit_path: Path, source_root: Path
) -> list[DuplicateBasis]:
    """Join exact duplicate sentences to their addresses and source modules.

    A duplicate is a review candidate, not automatically a false claim: ROM-
    ordered data records can legitimately share one format description.
    """
    file_by_name = definition_modules(source_root)
    grouped: dict[str, list[BasisReference]] = defaultdict(list)
    audit = json.loads(audit_path.read_text(encoding="utf-8"))
    for record in audit["records"]:
        reference = BasisReference(
            address=record["address"],
            current_name=record["current_name"],
            file=file_by_name.get(record["current_name"]),
        )
        for sentence in dict.fromkeys(record.get("basis", [])):
            if sentence.strip():
                grouped[sentence].append(reference)
    return sorted(
        (
            DuplicateBasis(sentence, tuple(references))
            for sentence, references in grouped.items()
            if len(references) > 1
        ),
        key=lambda group: (-len(group.references), group.basis),
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-root", default="src")
    parser.add_argument("--audit", default="config/name_audit.json")
    parser.add_argument("--limit", type=int, default=25)
    parser.add_argument("--json", action="store_true", dest="as_json")
    parser.add_argument("--duplicate-bases", action="store_true")
    parser.add_argument(
        "--basis-contains", help="show duplicate sentences containing this text"
    )
    args = parser.parse_args()
    if args.basis_contains and not args.duplicate_bases:
        parser.error("--basis-contains requires --duplicate-bases")

    audit_path = Path(args.audit)
    source_root = Path(args.source_root)
    provenance, pending = pending_records(source_root, audit_path)
    duplicates = duplicate_basis_groups(audit_path, source_root)
    duplicate_occurrences = sum(len(group.references) for group in duplicates)
    unmapped_basis_uses = sum(
        reference.file is None
        for group in duplicates
        for reference in group.references
    )
    selected = duplicates
    if args.basis_contains:
        needle = args.basis_contains.casefold()
        selected = [group for group in duplicates if needle in group.basis.casefold()]
    binary_end_aliases = [item for item in pending if item.binary_backed_end]
    other_end_names = [
        item
        for item in pending
        if item.current_name.endswith("_End") and not item.binary_backed_end
    ]
    actionable = [item for item in pending if not item.binary_backed_end]
    by_file = Counter(item.file for item in actionable)

    if args.as_json:
        print(
            json.dumps(
                {
                    "provenance_mappings": len(provenance),
                    "pending_current_names": len(pending),
                    "pending_binary_backed_end_aliases": len(binary_end_aliases),
                    "pending_other_end_names": len(other_end_names),
                    "actionable_upper_bound": len(actionable),
                    "duplicate_basis_groups": len(duplicates),
                    "duplicate_basis_occurrences": duplicate_occurrences,
                    "unmapped_basis_uses": unmapped_basis_uses,
                    "duplicate_bases": (
                        [asdict(group) for group in selected]
                        if args.duplicate_bases else []
                    ),
                    "modules": [
                        {"file": file, "pending": count}
                        for file, count in by_file.most_common()
                    ],
                    "records": [asdict(item) for item in actionable],
                },
                indent=2,
            )
        )
        return 0

    print(
        f"[OK] semantic audit queue: {len(provenance)} provenance mappings, "
        f"{len(pending)} pending current names"
    )
    print(
        f"[INFO] {len(binary_end_aliases)} binary-backed _End aliases, "
        f"{len(other_end_names)} other _End names; actionable upper bound "
        f"{len(actionable)}"
    )
    print(
        f"[INFO] {len(duplicates)} repeated basis sentences across "
        f"{duplicate_occurrences} exact-address uses "
        f"({unmapped_basis_uses} unmapped); repetition needs review, "
        "not automatic rejection"
    )
    for file, count in by_file.most_common(max(args.limit, 0)):
        print(f"{count:4}  {file}")
    if args.duplicate_bases:
        for group in selected[: max(args.limit, 0)]:
            print(f"{len(group.references):4}  {group.basis}")
            references = (
                group.references if args.basis_contains else group.references[:3]
            )
            for reference in references:
                print(
                    f"      {reference.address} {reference.current_name} "
                    f"({reference.file or 'unmapped'})"
                )
            if len(references) < len(group.references):
                print(f"      ... {len(group.references) - len(references)} more")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
