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
    def test_enemy_projectile_mapping_review_matches_animation_targets(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item for item in reviews
            if item["basis"].startswith("Named Enemy_Projectile animation streams")
        )
        source = (ROOT / "src/data/enemy_projectile_animation_mappings.s").read_text(
            encoding="utf-8"
        )
        targets = set(
            re.findall(r"\bdc\.w\s+(Enemy_ProjectileSpriteMapping\d\d)-\*", source)
        )
        self.assertEqual(
            {member["current_name"] for member in review["members"]}, targets
        )
        headers = set(re.findall(r"(?m)^(Enemy_ProjectileAnimation\d\d):", source))
        controller = (ROOT / "src/enemies/jetsripper_stage_actors.s").read_text(
            encoding="utf-8"
        )
        pointer_table = controller.split("Enemy_ProjectileAnimationPointers:", 1)[1].split(
            "Physics_SetHorizontalVelocityByFlip:", 1
        )[0]
        pointers = re.findall(
            r"\bdc\.l\s+(Enemy_ProjectileAnimation\d\d)\b", pointer_table
        )
        self.assertEqual(10, len(pointers))
        self.assertEqual(headers, set(pointers))
        self.assertRegex(
            controller,
            r"move\.l\s+Enemy_ProjectileAnimationPointers\(pc,d0\.w\),8\(a5\)",
        )

    def test_seven_forces_rotation_review_matches_tables_and_eight_slot_mask(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item for item in reviews
            if item["basis"].startswith("The eight-direction SevenForcesRotationFrameTable0")
        )
        source = (ROOT / "src/rendering/seven_forces_metasprites.s").read_text(
            encoding="utf-8"
        )
        tables = source[
            source.index("SevenForcesRotationFrameTable0:"):
            source.index("SevenForcesInlinePartDescriptor0:")
        ]
        starts = list(
            re.finditer(r"(?m)^SevenForcesRotationFrameTable[0-8]:", tables)
        )
        self.assertEqual(9, len(starts))
        segments = [
            tables[start.start():starts[index + 1].start()]
            if index + 1 < len(starts) else tables[start.start():]
            for index, start in enumerate(starts)
        ]
        pointers = [
            re.findall(r"\bdc\.l\s+(SevenForcesRotationSpriteFrame\d\d)\b", segment)
            for segment in segments
        ]
        self.assertEqual([8, 16, 8, 8, 8, 8, 8, 8, 8], list(map(len, pointers)))
        self.assertEqual(
            {member["current_name"] for member in review["members"]},
            {target for segment in pointers for target in segment},
        )
        renderer = (ROOT / "src/rendering/boss_metasprites.s").read_text(
            encoding="utf-8"
        ).split("Sprite_ApplyMetaspriteEightFrameRotation:", 1)[1].split(
            "; End of function Sprite_ApplyMetaspriteEightFrameRotation", 1
        )[0]
        self.assertRegex(renderer, r"andi\.w\s+#\$1C,d1")
        self.assertRegex(renderer, r"move\.l\s+\(a0,d1\.w\),8\(a4\)")

    def test_shared_combat_reviews_match_relative_streams_and_renderer(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        frames_review = next(
            review for review in reviews
            if review["basis"].startswith("A SharedCombatSpriteAnimation stream names")
        )
        animations_review = next(
            review for review in reviews
            if review["basis"].startswith("Anim_ResolveTimedMappingFrame reads")
        )
        streams = (ROOT / "src/data/shared_combat_sprite_animations.s").read_text(
            encoding="utf-8"
        )
        frame_targets = set(
            re.findall(r"\bdc\.w\s+(SharedCombatSpriteFrame\d\d)-\*", streams)
        )
        self.assertIn("SharedCombatSpriteFrame06", frame_targets)
        frame_targets.remove("SharedCombatSpriteFrame06")
        self.assertEqual(
            {member["current_name"] for member in frames_review["members"]},
            frame_targets,
        )
        stream_headers = set(
            re.findall(
                r"(?m)^(SharedCombatSpriteAnimation\d\d):\s+dc\.w\s+SharedCombatSpriteFrame\d\d-\*",
                streams,
            )
        )
        self.assertEqual(
            {member["current_name"] for member in animations_review["members"]},
            stream_headers,
        )
        renderer = (ROOT / "src/rendering/sprite_object_pipeline.s").read_text(
            encoding="utf-8"
        )
        self.assertRegex(renderer, r"bsr\.w\s+Anim_ResolveTimedMappingFrame")
        self.assertRegex(renderer, r"bsr\.w\s+Sprite_RenderMapping")
        resolver = renderer.split("Anim_ResolveTimedMappingFrame:", 1)[1].split(
            "; End of function Anim_ResolveTimedMappingFrame", 1
        )[0]
        self.assertRegex(resolver, r"addq\.w\s+#4,a4")
        self.assertRegex(resolver, r"adda\.w\s+\(a4\),a4")
        self.assertRegex(resolver, r"move\.w\s+2\(a4\),d0")

    def test_fragment_frames_are_direct_stage15_table_entries(self) -> None:
        stage = (ROOT / "src/stages/stage_15_fragment_hazards.s").read_text(
            encoding="utf-8"
        )
        table = stage.split("Projectile_FragmentSpriteFrames:", 1)[1].split(
            "Projectile_FragmentOrientationAttributes:", 1
        )[0]
        slots = re.findall(r"\bdc\.l\s+(Projectile_FragmentSpriteFrame\d\d)\b", table)
        self.assertEqual(
            [
                "Projectile_FragmentSpriteFrame01",
                "Projectile_FragmentSpriteFrame02",
                "Projectile_FragmentSpriteFrame00",
                "Projectile_FragmentSpriteFrame02",
                "Projectile_FragmentSpriteFrame01",
                "Projectile_FragmentSpriteFrame02",
                "Projectile_FragmentSpriteFrame00",
                "Projectile_FragmentSpriteFrame02",
            ],
            slots,
        )
        self.assertRegex(stage, r"move\.l\s+Projectile_FragmentSpriteFrames\(pc,d0\.w\),8\(a0\)")
        self.assertRegex(stage, r"move\.l\s+\(a1,d0\.w\),8\(a0\)")

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
