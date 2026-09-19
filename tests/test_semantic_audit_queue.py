from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import semantic_audit_queue  # noqa: E402


class SemanticAuditQueueTests(unittest.TestCase):
    def test_duplicate_bases_join_addresses_to_modules_once_per_record(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "src"
            source.mkdir()
            (source / "first.s").write_text(
                "First: ; was: sub_10\n", encoding="utf-8"
            )
            (source / "second.s").write_text("Second:\n", encoding="utf-8")
            audit = root / "audit.json"
            audit.write_text(
                json.dumps(
                    {
                        "records": [
                            {
                                "address": "0x000010",
                                "current_name": "First",
                                "basis": ["shared explanation", "shared explanation", "solo"],
                            },
                            {
                                "address": "0x000020",
                                "current_name": "Second",
                                "basis": ["shared explanation"],
                            },
                        ]
                    }
                ),
                encoding="utf-8",
            )
            groups = semantic_audit_queue.duplicate_basis_groups(audit, source)

            self.assertEqual(["shared explanation"], [group.basis for group in groups])
            self.assertEqual(
                [
                    ("0x000010", "First", (source / "first.s").as_posix()),
                    ("0x000020", "Second", (source / "second.s").as_posix()),
                ],
                [
                    (item.address, item.current_name, item.file)
                    for item in groups[0].references
                ],
            )

    def test_queue_scans_modules_and_excludes_audited_current_names(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "src"
            source.mkdir()
            (source / "first.s").write_text(
                "Reviewed:\n                rts ; was: sub_10\n"
                "Pending:\n                rts ; was: sub_12\n",
                encoding="utf-8",
            )
            (source / "second.inc").write_text(
                'Asset: binclude "asset.bin" ; was: byte_10\n'
                "                ; continued evidence comment\n"
                "Asset_End: ; was: byte_20\n",
                encoding="utf-8",
            )
            audit = root / "audit.json"
            audit.write_text(
                json.dumps(
                    {
                        "records": [
                            {"current_name": "Reviewed", "aliases": ["Asset_End"]}
                        ]
                    }
                ),
                encoding="utf-8",
            )

            provenance, pending = semantic_audit_queue.pending_records(source, audit)

            self.assertEqual(4, len(provenance))
            self.assertEqual(["Pending", "Asset"], [item.current_name for item in pending])
            self.assertFalse(pending[0].binary_backed_end)
            self.assertFalse(pending[1].binary_backed_end)
            self.assertEqual(
                ["first.s", "second.inc"],
                [Path(item.file).name for item in pending],
            )


if __name__ == "__main__":
    unittest.main()
