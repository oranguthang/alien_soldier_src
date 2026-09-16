from __future__ import annotations

import json
import re
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
AUDIT = ROOT / "config" / "name_audit.json"
SOURCE_POLICY = ROOT / "config" / "source_policy.json"
EVIDENCE_LEVELS = {"unknown", "hypothesis", "static", "runtime", "confirmed"}
DEFINITION = re.compile(
    r"^([A-Za-z_][A-Za-z0-9_]*)(?::|\s+equ\b)", re.IGNORECASE | re.MULTILINE
)


class NameAuditTests(unittest.TestCase):
    def test_records_are_unique_and_traceable(self) -> None:
        audit = json.loads(AUDIT.read_text(encoding="utf-8"))
        policy = json.loads(SOURCE_POLICY.read_text(encoding="utf-8"))
        legacy_name_pattern = policy["provenance"]["legacy_name_pattern"]
        records = audit["records"]
        addresses = [record["address"] for record in records]
        names = [record["current_name"] for record in records]
        aliases = [alias for record in records for alias in record.get("aliases", [])]

        self.assertEqual(len(addresses), len(set(addresses)))
        self.assertEqual(len(names), len(set(names)))
        self.assertEqual(len(aliases), len(set(aliases)))
        self.assertEqual(set(), set(names) & set(aliases))
        for record in records:
            self.assertRegex(
                record["address"], r"^0x(?:[0-9A-F]{6}|FFFF[0-9A-F]{4})$"
            )
            # A null legacy name means the import carried no symbol at all for
            # that address, which is different from carrying a generated one.
            if record["legacy_name"] is not None:
                self.assertRegex(record["legacy_name"], legacy_name_pattern)
                self.assertIsNotNone(record["previous_name"])
            self.assertIn(record["evidence"], EVIDENCE_LEVELS)
            self.assertGreater(len(record["basis"]), 0)

    def test_audited_current_names_exist_in_source(self) -> None:
        audit = json.loads(AUDIT.read_text(encoding="utf-8"))
        source_names: set[str] = set()
        for path in (ROOT / "src").rglob("*"):
            if path.suffix in {".s", ".inc"}:
                source_names.update(
                    DEFINITION.findall(path.read_text(encoding="utf-8"))
                )

        missing = sorted(
            name
            for record in audit["records"]
            for name in [record["current_name"], *record.get("aliases", [])]
            if name not in source_names
        )
        self.assertEqual([], missing)


if __name__ == "__main__":
    unittest.main()
