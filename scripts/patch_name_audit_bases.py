#!/usr/bin/env python3
"""Apply exact-address basis corrections without reformatting name_audit.json."""

from __future__ import annotations

import argparse
import json
import os
import re
import tempfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_AUDIT = ROOT / "config/name_audit.json"
DEFAULT_CHANGES = ROOT / "config/name_audit_basis_corrections.json"
ADDRESS_RE = re.compile(r'"address"\s*:\s*"(0x[0-9A-Fa-f]+)"')


def patch_bytes(audit: bytes, changes: list[dict[str, str]]) -> tuple[bytes, int]:
    """Return a validated byte-preserving rewrite of one-line audit records."""
    lines = audit.splitlines(keepends=True)
    locations: dict[str, int] = {}
    for index, line in enumerate(lines):
        match = ADDRESS_RE.search(line.decode("utf-8"))
        if match:
            address = match.group(1).upper().replace("0X", "0x")
            if address in locations:
                raise ValueError(f"duplicate audit address {address}")
            locations[address] = index

    seen: set[str] = set()
    pending = 0
    for change in changes:
        required = {"address", "current_name", "old_basis", "new_basis"}
        if set(change) != required:
            raise ValueError(f"basis correction fields must be {sorted(required)}")
        address = change["address"].upper().replace("0X", "0x")
        if address in seen:
            raise ValueError(f"duplicate correction address {address}")
        seen.add(address)
        if not change["new_basis"] or change["old_basis"] == change["new_basis"]:
            raise ValueError(f"empty or unchanged basis for {address}")
        if address not in locations:
            raise ValueError(f"audit address not found: {address}")

        index = locations[address]
        line = lines[index]
        try:
            record = json.loads(line.decode("utf-8").strip().removesuffix(","))
        except json.JSONDecodeError as error:
            raise ValueError(f"{address}: record must occupy one line") from error
        if record["current_name"] != change["current_name"]:
            raise ValueError(f"{address}: current name changed")
        if record["basis"] == [change["new_basis"]]:
            continue
        if record["basis"] != [change["old_basis"]]:
            raise ValueError(f"{address}: expected old basis differs from audit")

        old = json.dumps(change["old_basis"], ensure_ascii=False).encode("utf-8")
        new = json.dumps(change["new_basis"], ensure_ascii=False).encode("utf-8")
        if line.count(old) != 1:
            raise ValueError(f"{address}: old basis is not unique on its record line")
        lines[index] = line.replace(old, new, 1)
        pending += 1

    result = b"".join(lines)
    if pending:
        # Validate the edited JSON before any filesystem mutation.
        json.loads(result)
    return result, pending


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--audit", type=Path, default=DEFAULT_AUDIT)
    parser.add_argument("--changes", type=Path, default=DEFAULT_CHANGES)
    parser.add_argument("--write", action="store_true", help="apply pending corrections")
    args = parser.parse_args(argv)

    changes = json.loads(args.changes.read_text(encoding="utf-8"))["corrections"]
    before = args.audit.read_bytes()
    after, pending = patch_bytes(before, changes)
    if not args.write:
        print(f"[OK] {pending} basis correction(s) pending; no file written")
        return 0
    if pending == 0:
        print("[OK] all basis corrections already applied")
        return 0

    temporary: Path | None = None
    try:
        with tempfile.NamedTemporaryFile(
            mode="wb", prefix=".name_audit.", suffix=".tmp",
            dir=args.audit.parent, delete=False,
        ) as handle:
            temporary = Path(handle.name)
            handle.write(after)
        os.replace(temporary, args.audit)
    finally:
        if temporary is not None and temporary.exists():
            temporary.unlink()
    print(f"[OK] applied {pending} exact-address basis correction(s)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
