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
    def test_weapon_setup_text_review_decodes_labels_and_has_render_refs(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item for item in reviews
            if item["basis"].startswith("The encoded glyph bytes decode")
        )
        expected = {
            "WeaponSetup_HeadingText": "SETUP YOUR WEAPONS",
            "WeaponSetup_BusterForceText": "BUSTER FORCE",
            "WeaponSetup_RangerForceText": "RANGER FORCE",
            "WeaponSetup_FlameForceText": "FLAME FORCE",
            "WeaponSetup_HomingForceText": "HOMING FORCE",
            "WeaponSetup_SwordForceText": "SWORD FORCE",
            "WeaponSetup_LancerForceText": "LANCER FORCE",
            "WeaponSetup_ShootingModeText": "SHOOTING MODE",
            "WeaponSetup_MovingModeText": "MOVING",
            "WeaponSetup_FixedModeText": "FIX",
            "WeaponSetup_StatusWindowText": "STATUS WINDOW",
            "WeaponSetup_ExitText": "EXIT",
            "WeaponSetup_ControlTestText": "CONTROL TEST",
            "WeaponSetup_WeaponSelectControlText": "WEAPON SELECT",
            "WeaponSetup_ShotControlText": "SHOT",
            "WeaponSetup_JumpControlText": "JUMP",
            "WeaponSetup_ShootingModeChangeControlText": "SHOOT MODE CHANGE",
            "WeaponSetup_ZeroTeleportControlText": "ZERO TELEPORT",
            "WeaponSetup_CounterForceControlText": "COUNTER FORCE",
            "WeaponSetup_HoveringControlText": "HOVERING",
        }
        self.assertEqual(
            set(expected), {member["current_name"] for member in review["members"]}
        )
        data = (ROOT / "src/ui/weapon_setup_background_and_text.s").read_text(
            encoding="utf-8"
        )
        screen = (ROOT / "src/ui/weapon_setup_screen.s").read_text(encoding="utf-8")
        for name, decoded in expected.items():
            with self.subTest(name=name):
                definition = re.search(r"(?m)^" + re.escape(name) + r":\s+dc\.b\b", data)
                self.assertIsNotNone(definition)
                tail = data[definition.start():]
                next_line = tail.index("\n") + 1
                next_label = re.search(
                    r"(?m)^[A-Za-z_][A-Za-z0-9_]*:", tail[next_line:]
                )
                body = tail[:next_line + next_label.start()] if next_label else tail
                operands = re.findall(r"\bdc\.b\s+([^;\r\n]+)", body)
                values = [
                    int(token.strip()[1:], 16) if token.strip().startswith("$")
                    else int(token.strip())
                    for row in operands for token in row.split(",")
                ]
                letters = []
                for value in values:
                    if value == 0:
                        letters.append(" ")
                    elif 0xB <= value <= 0x24:
                        letters.append(chr(ord("A") + value - 0xB))
                    else:
                        break
                self.assertEqual(decoded, "".join(letters).strip())
                self.assertRegex(
                    screen, r"\b(?:lea|dc\.l)\s+" + re.escape(name) + r"\b"
                )

    def test_control_type_text_review_matches_table_slots_and_decimal_bytes(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item for item in reviews
            if item["basis"].startswith("WeaponSetup_ControlTypeTextPointers selects")
        )
        data = (ROOT / "src/ui/weapon_setup_background_and_text.s").read_text(
            encoding="utf-8"
        )
        encoded = re.findall(
            r"(?m)^WeaponSetup_ControlType(\d\d)Text:\s+dc\.b\s+([^;\r\n]+)",
            data,
        )
        self.assertEqual(26, len(encoded))
        self.assertEqual(
            [member["current_name"] for member in review["members"]],
            [f"WeaponSetup_ControlType{suffix}Text" for suffix, _ in encoded],
        )
        for index, (suffix, operands) in enumerate(encoded, 1):
            with self.subTest(control_type=index):
                self.assertEqual(f"{index:02}", suffix)
                values = [
                    int(token.strip()[1:], 16) if token.strip().startswith("$")
                    else int(token.strip())
                    for token in operands.split(",")
                ]
                digits = (
                    [index + 1, 0] if index < 10
                    else [index // 10 + 1, index % 10 + 1]
                )
                self.assertEqual([0x1E, 0x23, 0x1A, 0x0F, 0x2E, *digits, 0xFF], values)
        source = (ROOT / "src/ui/weapon_setup_screen.s").read_text(
            encoding="utf-8"
        )
        table = source.split("WeaponSetup_ControlTypeTextPointers:", 1)[1].split(
            "WeaponSetup_ControlTypeValues:", 1
        )[0]
        pointers = re.findall(r"\bdc\.l\s+(WeaponSetup_ControlType\d\dText)\b", table)
        self.assertEqual(
            [member["current_name"] for member in review["members"]], pointers
        )
        renderer = source.split("WeaponSetup_RenderSelectedControlType:", 1)[1].split(
            "; End of function WeaponSetup_RenderSelectedControlType", 1
        )[0]
        self.assertRegex(renderer, r"move\.w\s+\(WeaponSetupControlIndex\)\.w,d1")
        self.assertRegex(renderer, r"asl\.w\s+#2,d1")
        self.assertRegex(renderer, r"movea\.l\s+\(a0,d1\.w\),a0")

    def test_shellshogun_mapping_review_matches_all_pointer_owners(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item for item in reviews
            if item["basis"].startswith("Boss_Shellshogun pointer tables")
        )
        data = (
            ROOT / "src/data/antroid_terobuster_shellshogun_xi_tiger_metasprites.s"
        ).read_text(encoding="utf-8")
        renderer = (ROOT / "src/bosses/shellshogun_rendering.s").read_text(
            encoding="utf-8"
        )
        core = (ROOT / "src/bosses/shellshogun_core.s").read_text(encoding="utf-8")
        owners = set(
            re.findall(
                r"\b(?:dc\.l|move\.l)\s+#?(Boss_ShellshogunSpriteMapping\d\d)\b",
                data + renderer + core,
            )
        )
        self.assertEqual(
            {member["current_name"] for member in review["members"]}, owners
        )
        tables = data[
            data.index("Boss_ShellshogunRotationFramesA:"):
            data.index("Boss_ShellshogunInlineSpriteDescriptorA:")
        ]
        starts = list(re.finditer(r"(?m)^Boss_ShellshogunRotationFrames[A-F]:", tables))
        self.assertEqual(6, len(starts))
        for index, start in enumerate(starts):
            segment = (
                tables[start.start():starts[index + 1].start()]
                if index + 1 < len(starts) else tables[start.start():]
            )
            self.assertEqual(
                8,
                len(re.findall(r"\bdc\.l\s+Boss_ShellshogunSpriteMapping\d\d", segment)),
            )
        rotating = renderer.split("Boss_ShellshogunRotatingPartFrameTable:", 1)[1]
        self.assertEqual(
            ["29", "28", "27", "28"],
            re.findall(r"\bdc\.l\s+Boss_ShellshogunSpriteMapping(\d\d)", rotating),
        )

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
