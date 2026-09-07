from __future__ import annotations

import json
import re
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
AUDIT = ROOT / "config" / "name_audit.json"
EVIDENCE_LEVELS = {"unknown", "hypothesis", "static", "runtime", "confirmed"}


class NameAuditTests(unittest.TestCase):
    def test_records_are_unique_and_traceable(self) -> None:
        audit = json.loads(AUDIT.read_text(encoding="utf-8"))
        records = audit["records"]
        addresses = [record["address"] for record in records]
        names = [record["current_name"] for record in records]

        self.assertEqual(len(addresses), len(set(addresses)))
        self.assertEqual(len(names), len(set(names)))
        for record in records:
            self.assertRegex(record["address"], r"^0x[0-9A-F]{6}$")
            self.assertRegex(
                record["legacy_name"],
                r"^(?:sub|loc|locret|nullsub|byte|word|dword|off|unk|unknown|stru)_[0-9A-F]+$",
            )
            self.assertIn(record["evidence"], EVIDENCE_LEVELS)
            self.assertGreater(len(record["basis"]), 0)

    def test_audited_current_names_exist_in_source(self) -> None:
        audit = json.loads(AUDIT.read_text(encoding="utf-8"))
        source = "\n".join(
            path.read_text(encoding="utf-8") for path in (ROOT / "src").rglob("*")
            if path.suffix in {".s", ".inc"}
        )
        for record in audit["records"]:
            definition = re.compile(
                rf"^{re.escape(record['current_name'])}(?::|\s+equ\b)", re.MULTILINE
            )
            self.assertRegex(source, definition)


if __name__ == "__main__":
    unittest.main()
