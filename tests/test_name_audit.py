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
