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
    def test_muzzle_offset_tables_and_bit_three_mirroring(self) -> None:
        records = {
            record["address"]: record
            for record in json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        }
        reviews = {
            review["basis"]: review
            for review in json.loads(
                (ROOT / "config/duplicate_basis_reviews.json").read_text(
                    encoding="utf-8"
                )
            )["reviews"]
        }
        cases = (
            (
                "primary",
                "Weapon_UpdatePlayerFiring consumes this primary-layout table as eight signed X offsets followed by eight signed Y offsets.",
                ((0x0198D2, 0), (0x0198E2, 1), (0x019912, 2), (0x019922, 3)),
            ),
            (
                "alternate",
                "Weapon_UpdatePlayerFiring consumes this alternate-layout table as eight signed X offsets followed by eight signed Y offsets.",
                ((0x0198C2, 1), (0x0198F2, 2), (0x019902, 3)),
            ),
        )
        data = (ROOT / "src/weapons/targeting_and_projectile_runtime.s").read_text(
            encoding="utf-8"
        )
        consumers = "\n".join(
            path.read_text(encoding="utf-8")
            for path in (ROOT / "src/player").glob("*.s")
        )
        for layout, basis, members in cases:
            with self.subTest(layout=layout):
                expected = [
                    (f"0x{address:06X}", f"Player_{layout.title()}LayoutMuzzleOffsets{index}")
                    for address, index in members
                ]
                self.assertEqual(
                    expected,
                    [
                        (member["address"], member["current_name"])
                        for member in reviews[basis]["members"]
                    ],
                )
                for address, name in expected:
                    self.assertIn(basis, records[address]["basis"])
                    match = re.search(
                        rf"(?m)^{name}:\s+dc\.w\s+([^;\r\n]+)", data
                    )
                    self.assertIsNotNone(match)
                    self.assertEqual(8, len(match.group(1).split(",")))
                    self.assertIn(f"lea     ({name}).l,a4", consumers)

        firing = (ROOT / "src/weapons/firing.s").read_text(encoding="utf-8")
        self.assertIn("move.b  (a4,d6.w),d1", firing)
        self.assertIn("move.b  8(a4,d6.w),d2", firing)
        self.assertRegex(
            firing,
            r"btst\s+#3,\$E\(a5\)\s+beq\.s\s+Weapon_UpdatePlayerFiring_ApplyMuzzleOffset\s+neg\.w\s+d1",
        )
        self.assertIn("only when bit 3 is set", records["0x017EF4"]["basis"][0])

    def test_shared_explosion_entries_have_distinct_evidence(self) -> None:
        records = {
            record["address"]: record
            for record in json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        }
        names = (
            ("0x02A2A2", "Effect_InitSharedExplosionFromCurrent"),
            ("0x02A2A4", "Effect_InitSharedExplosion"),
            ("0x02A2C8", "Effect_ConfigureSharedExplosion"),
        )
        bases = []
        for address, name in names:
            self.assertEqual(name, records[address]["current_name"])
            self.assertEqual("static", records[address]["evidence"])
            bases.append(records[address]["basis"][0])
        self.assertEqual(3, len(set(bases)))
        self.assertIn("a5 to a0", bases[0])
        self.assertIn("type $C4", bases[1])
        self.assertIn("SFX $BC", bases[2])

        source = (ROOT / "src/projectiles/shared_boss_projectiles.s").read_text(
            encoding="utf-8"
        )
        adapter = source.split("Effect_InitSharedExplosionFromCurrent:", 1)[1].split(
            "Effect_InitSharedExplosion:", 1
        )[0]
        initializer = source.split("Effect_InitSharedExplosion:", 1)[1].split(
            "Effect_ConfigureSharedExplosion:", 1
        )[0]
        finisher = source.split("Effect_ConfigureSharedExplosion:", 1)[1].split(
            "; End of function", 1
        )[0]
        self.assertIn("movea.w a5,a0", adapter)
        self.assertIn("move.w  #$C4,(a0)", initializer)
        self.assertIn("move.l  #$FFFDC000,$1C(a0)", initializer)
        self.assertIn("btst    #4,$E(a0)", initializer)
        self.assertIn("move.l  #SharedCombatSpriteAnimation01,8(a0)", finisher)
        self.assertIn("move.b  #$BC,d0", finisher)
        self.assertNotIn("#$C4", finisher)

    def test_death_sequence_mappings_are_separate_from_particle_oam(self) -> None:
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        by_address = {record["address"]: record for record in records}
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("After appending particle OAM")
        )
        expected = [f"Player_DeathSequenceSpriteMapping{index:02}" for index in range(8)]
        self.assertEqual(expected, [member["current_name"] for member in review["members"]])
        for index, member in enumerate(review["members"]):
            record = by_address[member["address"]]
            self.assertEqual(expected[index], record["current_name"])
            self.assertEqual(
                f"Player_DeathParticleSpriteMapping{index:02}",
                record["previous_name"],
            )
            self.assertEqual(review["basis"], record["basis"][0])
        table_record = by_address["0x017242"]
        self.assertEqual("Player_DeathSequenceAnimationFrames", table_record["current_name"])
        self.assertEqual("Player_DeathParticleAnimationFrames", table_record["previous_name"])
        self.assertIn("first appends particle OAM", " ".join(table_record["basis"]))
        self.assertIn("only after particle OAM", by_address["0x01721E"]["basis"][0])
        player = (ROOT / "src/player/rendering_and_defeat.s").read_text(
            encoding="utf-8"
        )
        mappings = (ROOT / "src/data/player_special_and_death_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        art = (ROOT / "src/data/player_sprite_art.s").read_text(encoding="utf-8")
        self.assertNotRegex(
            player + mappings + art,
            r"\bPlayer_DeathParticle(?:AnimationFrames|SpriteMapping|SpriteArt)",
        )
        routine = player.split("Player_RenderDeathParticles:", 1)[1].split(
            "Player_DeathSequenceAnimationFrames:", 1
        )[0]
        self.assertLess(
            routine.index("bsr.w   Player_WriteDeathParticleSprite"),
            routine.index("Sprite_AppendOAMEntries"),
        )
        self.assertLess(
            routine.index("Sprite_AppendOAMEntries"),
            routine.index("Player_DeathSequenceAnimationFrames(pc,d0.w),8(a5)"),
        )
        self.assertIn("andi.w  #$1C,d0", routine)
        table = player.split("Player_DeathSequenceAnimationFrames:", 1)[1].split(
            "Player_WriteDeathParticleSprite:", 1
        )[0]
        self.assertEqual(
            expected,
            re.findall(r"\bdc\.l\s+(Player_DeathSequenceSpriteMapping\d\d)", table),
        )
        art_records = [
            record
            for record in records
            if (record["previous_name"] or "").startswith("Player_DeathParticleSpriteArt")
        ]
        self.assertEqual(6, len(art_records))
        for record in art_records:
            with self.subTest(name=record["current_name"]):
                self.assertTrue(record["current_name"].startswith("Player_DeathSequenceSpriteArt"))
                self.assertIn(record["current_name"] + ":", art)
                self.assertIn(record["current_name"], mappings)
                self.assertIn("Player_DeathSequenceSpriteMapping", record["basis"][0])

    def test_destroyer_proto_mappings_follow_part_projectile_and_intro_owners(self) -> None:
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        reviewed = [
            record
            for record in records
            if re.fullmatch(
                r"Boss_DestroyerProtoSpriteFrame(?:0\d|10)",
                record["previous_name"] or "",
            )
        ]
        self.assertEqual(11, len(reviewed))
        self.assertEqual(11, len({record["basis"][0] for record in reviewed}))
        expected = {
            *(f"Boss_DestroyerProtoPartFrame{index:02}" for index in range(5)),
            *(f"Projectile_DestroyerProtoFrame{index:02}" for index in range(5)),
            "Boss_DestroyerProtoIntroPartFrame",
        }
        self.assertEqual(expected, {record["current_name"] for record in reviewed})
        mappings = (ROOT / "src/data/destroyer_proto_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        core = (ROOT / "src/bosses/destroyer_proto_core.s").read_text(
            encoding="utf-8"
        )
        projectiles = (
            ROOT / "src/projectiles/destroyer_proto_and_victor_projectiles.s"
        ).read_text(encoding="utf-8")
        self.assertNotRegex(
            mappings + core + projectiles,
            r"\bBoss_DestroyerProtoSpriteFrame(?:0\d|10)\b",
        )
        self.assertEqual(
            expected,
            set(
                re.findall(
                    r"(?m)^((?:Boss|Projectile)_DestroyerProto\w*Frame\d\d|"
                    r"Boss_DestroyerProtoIntroPartFrame):",
                    mappings,
                )
            ),
        )
        intro_table = core.split("Boss_DestroyerProtoPartMappingTable:", 1)[1].split(
            "Boss_DestroyerProtoGraphicsLoadDescriptor:", 1
        )[0]
        part_table = projectiles.split(
            "Boss_DestroyerProtoPartMappingFrameTable:", 1
        )[1].split("Boss_DestroyerProtoLaunchTwinProjectiles:", 1)[0]
        projectile_table = projectiles.split(
            "Projectile_DestroyerProtoMappingFrameTable:", 1
        )[1].split("Projectile_DestroyerProtoCheckHorizontalReflection:", 1)[0]
        self.assertEqual(
            ["Boss_DestroyerProtoIntroPartFrame", "Boss_DestroyerProtoPartFrame01"],
            re.findall(r"\bdc\.l\s+(Boss_DestroyerProto\w+Frame\w*)", intro_table),
        )
        self.assertEqual(
            ["01", "02", "03", "04", "00", "04", "03", "02"] * 2,
            re.findall(r"\bdc\.l\s+Boss_DestroyerProtoPartFrame(\d\d)", part_table),
        )
        self.assertEqual(
            ["00", "01", "02", "03", "04", "03", "02", "01"] * 2,
            re.findall(r"\bdc\.l\s+Projectile_DestroyerProtoFrame(\d\d)", projectile_table),
        )
        self.assertIn("Boss_DestroyerProtoPartMappingTable(pc,d0.w),8(a4)", core)
        self.assertIn("lea     Projectile_DestroyerProtoMappingFrameTable(pc),a0", projectiles)

    def test_terobuster_mapping_names_follow_rotation_tables(self) -> None:
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        reviewed = [
            record
            for record in records
            if re.fullmatch(
                r"Boss_TerobusterSpriteMapping\d\d", record["previous_name"] or ""
            )
        ]
        self.assertEqual(16, len(reviewed))
        self.assertEqual(16, len({record["basis"][0] for record in reviewed}))
        mappings = (ROOT / "src/data/terobuster_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        descriptors = (
            ROOT / "src/data/antroid_terobuster_shellshogun_xi_tiger_metasprites.s"
        ).read_text(encoding="utf-8")
        core = (ROOT / "src/bosses/terobuster_core.s").read_text(encoding="utf-8")
        self.assertNotRegex(
            mappings + descriptors + core, r"\bBoss_TerobusterSpriteMapping\d\d\b"
        )
        self.assertEqual(
            {record["current_name"] for record in reviewed},
            set(re.findall(r"(?m)^(Boss_Terobuster\w+Frame\d\d):", mappings)),
        )
        primary = descriptors.split("Boss_TerobusterPrimaryRotationFrames:", 1)[
            1
        ].split("Boss_TerobusterSecondaryRotationFrames:", 1)[0]
        secondary = descriptors.split("Boss_TerobusterSecondaryRotationFrames:", 1)[
            1
        ].split("Boss_TerobusterInlineSpriteDescriptor:", 1)[0]
        self.assertEqual(
            [f"{index:02}" for index in reversed(range(8))],
            re.findall(
                r"\bdc\.l\s+Boss_TerobusterPrimaryRotationFrame(\d\d)\b",
                primary,
            ),
        )
        self.assertEqual(
            [f"{index:02}" for index in range(8)],
            re.findall(
                r"\bdc\.l\s+Boss_TerobusterSecondaryRotationFrame(\d\d)\b",
                secondary,
            ),
        )
        for offset in ("8", "$1E8", "$3C8"):
            self.assertIn(
                f"move.l  #Boss_TerobusterSecondaryRotationFrame00,{offset}(a0)",
                core,
            )

    def test_madam_barbar_mapping_names_follow_four_rotation_tables(self) -> None:
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        reviewed = [
            record
            for record in records
            if re.fullmatch(
                r"Boss_MadamBarbarSpriteMapping\d\d", record["previous_name"] or ""
            )
        ]
        self.assertEqual(16, len(reviewed))
        self.assertEqual(16, len({record["basis"][0] for record in reviewed}))
        mappings = (ROOT / "src/data/madam_barbar_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        descriptors = (
            ROOT / "src/data/madam_barbar_flying_neo_joker_back_stringer_sharpssteel_metasprites.s"
        ).read_text(encoding="utf-8")
        self.assertNotRegex(
            mappings + descriptors, r"\bBoss_MadamBarbarSpriteMapping\d\d\b"
        )
        self.assertEqual(
            {record["current_name"] for record in reviewed},
            set(
                re.findall(
                    r"(?m)^(Boss_MadamBarbarRotationSet[AB]Frame\d\d):", mappings
                )
            ),
        )
        expected = {
            "A": ("A", ["07", "06", "04", "01", "02", "00", "03", "05"]),
            "B": ("A", ["05", "03", "00", "02", "01", "04", "06", "07"]),
            "C": ("B", [f"{index:02}" for index in range(8)]),
            "D": ("B", [f"{index:02}" for index in reversed(range(8))]),
        }
        for table, (family, suffixes) in expected.items():
            section = descriptors.split(f"Boss_MadamBarbarRotationFrames{table}:", 1)[1].split(
                "\nBoss_", 1
            )[0]
            self.assertEqual(
                suffixes,
                re.findall(
                    rf"\bdc\.l\s+Boss_MadamBarbarRotationSet{family}Frame(\d\d)\b",
                    section,
                ),
            )

    def test_xi_tiger_mapping_names_follow_forward_reverse_tables(self) -> None:
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        reviewed = [
            record
            for record in records
            if re.fullmatch(
                r"Boss_XiTigerSpriteMapping\d\d", record["previous_name"] or ""
            )
        ]
        self.assertEqual(18, len(reviewed))
        self.assertEqual(18, len({record["basis"][0] for record in reviewed}))
        mappings = (ROOT / "src/data/xi_tiger_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        descriptors = (
            ROOT / "src/data/antroid_terobuster_shellshogun_xi_tiger_metasprites.s"
        ).read_text(encoding="utf-8")
        self.assertNotRegex(
            mappings + descriptors, r"\bBoss_XiTigerSpriteMapping\d\d\b"
        )
        self.assertEqual(
            {record["current_name"] for record in reviewed},
            set(
                re.findall(
                    r"(?m)^(Boss_XiTiger(?:DirectDescriptorFrame\d\d|RotationSet[AB]Frame\d\d)):",
                    mappings,
                )
            ),
        )
        for family, forward, reverse in (
            ("A", "A", "C"),
            ("B", "B", "D"),
        ):
            for table, expected in (
                (forward, range(8)),
                (reverse, reversed(range(8))),
            ):
                start = f"Boss_XiTigerRotationFrames{table}:"
                section = descriptors.split(start, 1)[1].split("\nBoss_", 1)[0]
                self.assertEqual(
                    [f"{index:02}" for index in expected],
                    re.findall(
                        rf"\bdc\.l\s+Boss_XiTigerRotationSet{family}Frame(\d\d)\b",
                        section,
                    ),
                )
        descriptor_table = descriptors.split(
            "Boss_XiTigerMetaspriteDescriptors:", 1
        )[1].split("Boss_XiTigerPartRadii:", 1)[0]
        descriptor_entries = [
            entry.strip()
            for entry in re.findall(r"\bdc\.l\s+([^;\r\n]+)", descriptor_table)
        ]
        self.assertEqual(
            "Boss_XiTigerDirectDescriptorFrame00+$400000", descriptor_entries[2]
        )
        self.assertEqual(
            "Boss_XiTigerDirectDescriptorFrame00-$7C00000", descriptor_entries[7]
        )
        self.assertEqual(
            "Boss_XiTigerDirectDescriptorFrame01+$400000", descriptor_entries[12]
        )
        self.assertEqual(
            2, descriptor_table.count("Boss_XiTigerDirectDescriptorFrame00")
        )
        self.assertEqual(
            1, descriptor_table.count("Boss_XiTigerDirectDescriptorFrame01")
        )
        for name in (
            "Boss_XiTigerDirectDescriptorFrame00",
            "Boss_XiTigerDirectDescriptorFrame01",
        ):
            rotation_tables = descriptors.split("Boss_XiTigerRotationFramesA:", 1)[
                1
            ].split("Boss_XiTigerInlineSpriteDescriptorA:", 1)[0]
            self.assertNotIn(name, rotation_tables)

    def test_jetsripper_mapping_names_follow_segment_tables(self) -> None:
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        reviewed = [
            record
            for record in records
            if re.fullmatch(
                r"Boss_JetsripperSpriteMapping\d\d", record["previous_name"] or ""
            )
        ]
        self.assertEqual(18, len(reviewed))
        self.assertEqual(18, len({record["basis"][0] for record in reviewed}))
        mappings = (ROOT / "src/data/jetsripper_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        segments = (ROOT / "src/bosses/jetsripper_segments.s").read_text(
            encoding="utf-8"
        )
        core = (ROOT / "src/bosses/jetsripper_core.s").read_text(encoding="utf-8")
        self.assertNotRegex(
            mappings + segments + core, r"\bBoss_JetsripperSpriteMapping\d\d\b"
        )
        self.assertEqual(
            {record["current_name"] for record in reviewed},
            set(re.findall(r"(?m)^(Boss_Jetsripper\w+):", mappings)),
        )

        def pointers(source: str, start: str, end: str) -> list[str]:
            section = source.split(start + ":", 1)[1].split(end, 1)[0]
            return re.findall(r"\bdc\.l\s+(Boss_Jetsripper\w+)\b", section)

        self.assertEqual(
            [
                "Boss_JetsripperSharedSegmentBaseFrame",
                "Boss_JetsripperHeadFrame01",
                "Boss_JetsripperHeadFrame02",
                "Boss_JetsripperHeadFrame01",
            ],
            pointers(
                segments,
                "Boss_JetsripperHeadFrames",
                "Boss_JetsripperBodyDirectionFrames:",
            ),
        )
        body_suffixes = [
            "00", "05", "06", "07", "08", "07", "06", "05",
            "00", "03", "01", "04", "02", "04", "01", "03",
        ]
        self.assertEqual(
            [f"Boss_JetsripperBodyDirectionFrame{suffix}" for suffix in body_suffixes],
            pointers(
                segments,
                "Boss_JetsripperBodyDirectionFrames",
                "Boss_JetsripperTailFrames:",
            ),
        )
        self.assertEqual(
            [
                f"Boss_JetsripperTailFrame{suffix}"
                for suffix in ("00", "01", "02", "01")
            ],
            pointers(segments, "Boss_JetsripperTailFrames", "; Fills angle buffer"),
        )
        self.assertEqual(
            ["Boss_JetsripperMovementFrame00", "Boss_JetsripperMovementFrame01"],
            pointers(core, "Boss_JetsripperBodyFrames", "Boss_JetsripperDivePrep:"),
        )
        self.assertIn("move.l  #Boss_JetsripperSharedSegmentBaseFrame,8(a0)", core)
        self.assertIn("move.l  #Boss_JetsripperDiveWindupFrame,8(a5)", core)

    def test_antroid_mapping_names_follow_blink_and_rotation_tables(self) -> None:
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        reviewed = [
            record
            for record in records
            if re.fullmatch(
                r"Boss_AntroidSpriteMapping\d\d", record["previous_name"] or ""
            )
        ]
        self.assertEqual(18, len(reviewed))
        self.assertEqual(18, len({record["basis"][0] for record in reviewed}))
        mappings = (ROOT / "src/data/antroid_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        tables = (
            ROOT / "src/data/antroid_terobuster_shellshogun_xi_tiger_metasprites.s"
        ).read_text(encoding="utf-8")
        rendering = (ROOT / "src/bosses/antroid_rendering.s").read_text(
            encoding="utf-8"
        )
        core = (ROOT / "src/bosses/antroid_core.s").read_text(encoding="utf-8")
        self.assertNotRegex(
            mappings + tables + rendering + core,
            r"\bBoss_AntroidSpriteMapping\d\d\b",
        )
        definitions = set(
            re.findall(r"(?m)^(Boss_Antroid\w+(?:Mapping|Frame\d\d)):", mappings)
        )
        self.assertEqual({record["current_name"] for record in reviewed}, definitions)

        primary = tables.split("Boss_AntroidPrimaryRotationFrames:", 1)[1].split(
            "Boss_AntroidSecondaryRotationFrames:", 1
        )[0]
        secondary = tables.split("Boss_AntroidSecondaryRotationFrames:", 1)[1].split(
            "Boss_AntroidInlineSpriteDescriptorA:", 1
        )[0]
        self.assertEqual(
            [f"{index:02}" for index in reversed(range(8))],
            re.findall(
                r"\bdc\.l\s+Boss_AntroidPrimaryRotationFrame(\d\d)\b", primary
            ),
        )
        self.assertEqual(
            [f"{index:02}" for index in range(8)],
            re.findall(
                r"\bdc\.l\s+Boss_AntroidSecondaryRotationFrame(\d\d)\b",
                secondary,
            ),
        )
        blink = rendering.split("Boss_AntroidRenderBlinkingPose:", 1)[1].split(
            "; End of function Boss_AntroidRenderBlinkingPose", 1
        )[0]
        self.assertIn("move.l  #Boss_AntroidBlinkDefaultMapping,$C8(a5)", blink)
        self.assertIn("move.l  #Boss_AntroidBlinkAlternateMapping,$C8(a5)", blink)
        self.assertIn("move.l  #Boss_AntroidSecondaryRotationFrame00,8(a0)", core)

    def test_shield_viper_mapping_names_follow_exact_consumers(self) -> None:
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        reviewed = [
            record
            for record in records
            if re.fullmatch(
                r"Boss_ShieldViperSpriteFrame\d\d", record["previous_name"] or ""
            )
        ]
        self.assertEqual(19, len(reviewed))
        self.assertEqual(19, len({record["basis"][0] for record in reviewed}))
        names = {record["current_name"] for record in reviewed}
        core = (ROOT / "src/bosses/shield_viper_core.s").read_text(encoding="utf-8")
        defeat = (ROOT / "src/bosses/shield_viper_defeat.s").read_text(encoding="utf-8")
        projectile = (ROOT / "src/projectiles/shield_viper.s").read_text(encoding="utf-8")
        mappings = (ROOT / "src/data/shield_viper_and_missiray_mappings.s").read_text(
            encoding="utf-8"
        )
        source = core + defeat + projectile + mappings
        self.assertNotRegex(source, r"\bBoss_ShieldViperSpriteFrame\d\d\b")
        self.assertEqual(
            names,
            set(
                re.findall(
                    r"^((?:Boss|Projectile)_ShieldViper\w*Frame\d\d):",
                    mappings,
                    re.M,
                )
            ),
        )

        def pointers(text: str, table: str, end: str, family: str) -> list[str]:
            section = text.split(table + ":", 1)[1].split(end, 1)[0]
            return re.findall(r"\bdc\.l\s+" + re.escape(family) + r"(\d\d)\b", section)

        self.assertEqual(
            ["00"] * 18,
            pointers(
                core,
                "Boss_ShieldViperBodyInitializationRecords",
                "Boss_ShieldViperPlaceForIntroDelay:",
                "Boss_ShieldViperBodyAngleFrame",
            ),
        )
        self.assertEqual(
            ["00", "00", "01", "01", "02", "02"],
            pointers(
                core,
                "Boss_ShieldViperBodyInitializationRecords",
                "Boss_ShieldViperPlaceForIntroDelay:",
                "Boss_ShieldViperBodyInitTailFrame",
            ),
        )
        for table, end, family in (
            (
                "Boss_ShieldViperControllerAngularMappingRecords",
                "Boss_ShieldViperBodyAngularMappingRecords:",
                "Boss_ShieldViperControllerAngleFrame",
            ),
            (
                "Boss_ShieldViperBodyAngularMappingRecords",
                "; Debug routine",
                "Boss_ShieldViperBodyAngleFrame",
            ),
        ):
            self.assertEqual(
                ["00", "01", "02", "03"] * 2,
                pointers(defeat, table, end, family),
            )
        self.assertEqual(
            [f"{index:02}" for index in range(8)] + ["07"],
            pointers(
                projectile,
                "Projectile_ShieldViperOrbitShotAnimationRecords",
                "; Defeat main handler",
                "Projectile_ShieldViperOrbitShotFrame",
            ),
        )
        self.assertIn("move.l  #Projectile_ShieldViperOrbitShotFrame00,8(a0)", projectile)
        self.assertIn("move.l  #Projectile_ShieldViperOrbitShotFrame01,8(a0)", core)

    def test_weapon_setup_text_handlers_are_audited_as_code(self) -> None:
        records = {
            record["address"]: record
            for record in json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        }
        self.assertEqual(
            "WeaponSetup_RenderControlTestRowsAndLoadPalette",
            records["0x01F3E6"]["current_name"],
        )
        self.assertEqual(
            "WeaponSetup_RenderExitText", records["0x01F70C"]["current_name"]
        )
        for address in ("0x01F3E6", "0x01F70C"):
            self.assertNotIn("encoded glyph bytes", " ".join(records[address]["basis"]))
        source = (ROOT / "src/ui/weapon_setup_screen.s").read_text(encoding="utf-8")
        control = source.split("WeaponSetup_RenderControlTestRowsAndLoadPalette:", 1)[1].split(
            "; End of function WeaponSetup_RenderControlTestRowsAndLoadPalette", 1
        )[0]
        self.assertRegex(control, r"cmpi\.w\s+#\$40,\(WeaponSetupCursorOffset\)\.w")
        self.assertRegex(control, r"jsr\s+\(Text_QueueDoubleHeightStringWrapped\)\.l")
        self.assertRegex(control, r"jmp\s+Gfx_LoadMultiplePalettes")
        exit_text = source.split("WeaponSetup_RenderExitText:", 1)[1].split(
            "; End of function WeaponSetup_RenderExitText", 1
        )[0]
        self.assertRegex(exit_text, r"lea\s+WeaponSetup_ExitText\(pc\),a0")
        self.assertRegex(
            exit_text, r"jmp\s+\(Text_QueueDoubleHeightStringWrapped\)\.l"
        )

    def test_bugmax_frame_names_match_their_static_consumers(self) -> None:
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        reviewed = [
            record for record in records
            if re.fullmatch(r"Boss_BugmaxSpriteFrame\d\d", record["previous_name"] or "")
        ]
        self.assertEqual(23, len(reviewed))
        names = {record["current_name"] for record in reviewed}
        projectile = (ROOT / "src/projectiles/bugmax.s").read_text(encoding="utf-8")
        opening = (ROOT / "src/bosses/bugmax_opening_states.s").read_text(
            encoding="utf-8"
        )
        battle = (ROOT / "src/bosses/bugmax_battle_and_final_sequence.s").read_text(
            encoding="utf-8"
        )
        movement = (ROOT / "src/bosses/bugmax_movement.s").read_text(
            encoding="utf-8"
        )
        data = (ROOT / "src/data/bugmax_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        all_source = projectile + opening + battle + movement + data
        self.assertNotRegex(all_source, r"\bBoss_BugmaxSpriteFrame\d\d\b")
        selected = set(
            re.findall(
                r"\b(?:dc\.l|move\.l|dc\.w)\s+#?((?:Boss|Projectile)_Bugmax\w*Frame\w*)",
                all_source,
            )
        )
        self.assertEqual(names, selected)

        def pointer_suffixes(source: str, start: str, end: str, family: str) -> list[str]:
            section = source.split(start + ":", 1)[1].split(end + ":", 1)[0]
            return re.findall(r"\bdc\.l\s+" + re.escape(family) + r"(\d\d)\b", section)

        self.assertEqual(
            ["00", "01"],
            pointer_suffixes(
                projectile, "Boss_BugmaxStandardHitFragmentMappings",
                "Gfx_BugmaxApplyWavePaletteOffset", "Projectile_BugmaxHitFragmentFrame",
            ),
        )
        self.assertEqual(
            ["00", "01", "01", "02", "02"],
            pointer_suffixes(
                opening, "Boss_BugmaxLinkedPartDescriptors",
                "Gfx_BugmaxLoadInitialTiles", "Boss_BugmaxOpeningLinkFrame",
            ),
        )
        self.assertEqual(
            ["00", "01", "01", "02", "02"],
            pointer_suffixes(
                battle, "Boss_BugmaxPrimaryLinkedPartDescriptors",
                "Boss_BugmaxSecondaryLinkedPartMappings", "Boss_BugmaxPrimaryLinkFrame",
            ),
        )
        secondary = battle.split("Boss_BugmaxSecondaryLinkedPartMappings:", 1)[1].split(
            "Boss_BugmaxRotateLinkedAssemblyToward140:", 1
        )[0]
        self.assertEqual(
            ["00"] * 3 + ["01"] * 5,
            re.findall(r"\bdc\.l\s+Boss_BugmaxSecondaryLinkFrame(\d\d)\b", secondary),
        )
        angle = opening.split("Boss_BugmaxSelectCentralPartFrameByAngle:", 1)[1].split(
            "; End of function Boss_BugmaxSelectCentralPartFrameByAngle", 1
        )[0]
        for role in ("Lower", "Middle", "Upper"):
            self.assertIn(f"Boss_BugmaxCentralPart{role}AngleFrame", angle)
        for family, count in (("Spread", 2), ("Sine", 4)):
            self.assertEqual(
                [f"{index:02}" for index in range(count)],
                re.findall(
                    r"\bdc\.w\s+Projectile_Bugmax" + family + r"Frame(\d\d)-\*",
                    data,
                ),
            )
        self.assertIn("move.l  #Boss_BugmaxCentralPartToggleFrame01,8(a0)", movement)
        self.assertIn("move.l  #Boss_BugmaxBattleControllerFrame,8(a5)", battle)
        self.assertIn("move.l  #Boss_BugmaxOpeningControllerFrame,8(a5)", opening)

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
