from __future__ import annotations

import json
import re
import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import semantic_audit_queue  # noqa: E402


class SemanticAuditQueueTests(unittest.TestCase):
    def test_reviewed_player_mapping_group_still_matches_its_consumer(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        player_review = next(
            review for review in reviews
            if review["basis"].startswith("Player_AnimationFrameTable selects")
        )
        source = (ROOT / "src/player/rendering_and_defeat.s").read_text(encoding="utf-8")
        consumer = source.split("Player_AdvanceAnimationFrame:", 1)[1].split(
            "; End of function Player_AdvanceAnimationFrame", 1
        )[0]
        self.assertRegex(consumer, r"andi\.w\s+#\$1C,d0")
        self.assertRegex(
            consumer, r"move\.l\s+Player_AnimationFrameTable\(pc,d0\.w\),8\(a5\)"
        )
        table = source.split("Player_AnimationFrameTable:", 1)[1].split("\n\n", 1)[0]
        slots = re.findall(r"\bdc\.l\s+(Player_StateAnimationSpriteMapping\d\d)\b", table)
        self.assertEqual(
            [member["current_name"] for member in player_review["members"]], slots
        )
        self.assertEqual(8, len(slots))

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

            reviews = root / "reviews.json"
            reviews.write_text(
                json.dumps(
                    {
                        "schema_version": 1,
                        "reviews": [
                            {
                                "basis": "shared explanation",
                                "reason": "Both entries occupy the same fixed-format table.",
                                "members": [
                                    {"address": "0x000010", "current_name": "First", "file": "src/first.s"},
                                    {"address": "0x000020", "current_name": "Second", "file": "src/second.s"},
                                ],
                            }
                        ],
                    }
                ),
                encoding="utf-8",
            )
            unreviewed, errors = semantic_audit_queue.unreviewed_duplicate_bases(
                groups, reviews, root
            )
            self.assertEqual([], errors)
            self.assertEqual([], unreviewed)

            (source / "second.s").write_text("Renamed:\n", encoding="utf-8")
            audit_data = json.loads(audit.read_text(encoding="utf-8"))
            audit_data["records"][1]["current_name"] = "Renamed"
            audit.write_text(json.dumps(audit_data), encoding="utf-8")
            groups = semantic_audit_queue.duplicate_basis_groups(audit, source)
            _, errors = semantic_audit_queue.unreviewed_duplicate_bases(
                groups, reviews, root
            )
            self.assertTrue(any("reviewed members drifted" in error for error in errors))

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
