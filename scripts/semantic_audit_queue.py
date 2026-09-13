#!/usr/bin/env python3
"""Report provenance-backed names that still need a current-name audit record."""

from __future__ import annotations

import argparse
from collections import Counter
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


def source_files(source_root: Path) -> list[Path]:
    return sorted(source_root.rglob("*.s")) + sorted(source_root.rglob("*.inc"))


def scan_provenance(source_root: Path) -> list[ProvenanceName]:
    records: list[ProvenanceName] = []
    for path in source_files(source_root):
        current_name: str | None = None
        previous_nonempty = ""
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
                            and bool(re.search(r"\bbinclude\b", previous_nonempty, re.IGNORECASE))
                        ),
                    )
                )
            if line.strip():
                previous_nonempty = line
    return records


def audited_names(audit_path: Path) -> set[str]:
    audit = json.loads(audit_path.read_text(encoding="utf-8"))
    return {record["current_name"] for record in audit["records"]}


def pending_records(
    source_root: Path, audit_path: Path
) -> tuple[list[ProvenanceName], list[ProvenanceName]]:
    provenance = scan_provenance(source_root)
    audited = audited_names(audit_path)
    return provenance, [item for item in provenance if item.current_name not in audited]


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-root", default="src")
    parser.add_argument("--audit", default="config/name_audit.json")
    parser.add_argument("--limit", type=int, default=25)
    parser.add_argument("--json", action="store_true", dest="as_json")
    args = parser.parse_args()

    provenance, pending = pending_records(Path(args.source_root), Path(args.audit))
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
    for file, count in by_file.most_common(max(args.limit, 0)):
        print(f"{count:4}  {file}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
