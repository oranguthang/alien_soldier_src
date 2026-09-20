from __future__ import annotations

import json
import re
import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
AUDIT = ROOT / "config/name_audit.json"
sys.path.insert(0, str(ROOT / "scripts"))

import semantic_audit_queue  # noqa: E402


class SemanticAuditQueueTests(unittest.TestCase):
    def test_pcm_bank_review_pins_eight_full_banks_and_partial_ninth(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("The DAC descriptor tables encode this 0x8000-byte")
        )
        self.assertEqual(
            {f"Sound_PCMBank{index}" for index in range(1, 9)},
            {member["current_name"] for member in review["members"]},
        )
        self.assertEqual(
            {"src/sound/pcm_samples.s"},
            {member["file"] for member in review["members"]},
        )
        assets = json.loads((ROOT / "assets/manifest.json").read_text(encoding="utf-8"))[
            "assets"
        ]
        by_path = {asset["path"]: asset for asset in assets}
        source = (ROOT / "src/sound/pcm_samples.s").read_text(encoding="utf-8")
        descriptors = (
            (ROOT / "src/sound/driver_core.s").read_text(encoding="utf-8")
            + (ROOT / "src/sound/command_dispatch_and_dac.s").read_text(
                encoding="utf-8"
            )
        )
        for index, member in enumerate(review["members"], start=1):
            with self.subTest(bank=index):
                start = 0x98000 + (index - 1) * 0x8000
                asset = by_path[f"sound/PCMPart{index}.bin"]
                self.assertEqual(start, int(member["address"], 16))
                self.assertEqual(start, int(asset["address"], 16))
                self.assertEqual(start + 0x8000, int(asset["end"], 16))
                self.assertEqual(0x8000, asset["size"])
                self.assertIn(
                    f'Sound_PCMBank{index}: binclude "data/sound/PCMPart{index}.bin"',
                    source,
                )
                self.assertRegex(
                    descriptors,
                    rf"\bdc\.w\s+\(Sound_PCMBank{index} >> \$8\)[^\n]*\n\s*dc\.w\s+",
                )
        ninth = by_path["sound/PCMPart9.bin"]
        self.assertEqual(0xD8000, int(ninth["address"], 16))
        self.assertEqual(0x1A5E, ninth["size"])
        self.assertNotIn("Sound_PCMBank9", {member["current_name"] for member in review["members"]})

    def test_sirene_direct_and_indirect_pose_scripts_exclude_frame_data(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        direct = next(
            item
            for item in reviews
            if item["basis"].startswith("A named Sirene state loads this word")
        )
        indirect = next(
            item
            for item in reviews
            if item["basis"].startswith("Boss_EnterSireneState14 selects this word")
        )
        self.assertEqual(
            {"Sirene_State2PoseScript", "Sirene_ActivePoseScript", "Sirene_State4And6PoseScript"},
            {member["current_name"] for member in direct["members"]},
        )
        self.assertEqual(
            {f"Sirene_State14PoseScript{index}" for index in range(3)},
            {member["current_name"] for member in indirect["members"]},
        )
        self.assertEqual(
            {"src/bosses/sirene.s"},
            {member["file"] for item in (direct, indirect) for member in item["members"]},
        )
        source = (ROOT / "src/bosses/sirene.s").read_text(encoding="utf-8")
        self.assertEqual(
            {member["current_name"] for member in direct["members"]},
            set(re.findall(r"\blea\s+(Sirene_\w+PoseScript)\(pc\),a1", source)),
        )
        self.assertIn("bsr.w   Boss_UpdateSirenePoseScript", source)
        for name, end in (
            ("Sirene_State2PoseScript", "$FFFF"),
            ("Sirene_ActivePoseScript", "$FFFF"),
            ("Sirene_State4And6PoseScript", "$FFFE"),
        ):
            with self.subTest(script=name):
                body = re.search(
                    r"(?ms)^" + name + r":(.*?)(?=^[A-Za-z_][A-Za-z0-9_]*:|\Z)",
                    source,
                )
                self.assertIsNotNone(body)
                rows = re.findall(r"\bdc\.w\s+([^;\r\n]+)", body.group(1))
                self.assertEqual(end, rows[-1].split(",")[-1].strip())
        set0 = source.split("Sirene_State14PoseScriptSet0:", 1)[1].split(
            "Sirene_State14PoseScriptSet1:", 1
        )[0]
        set1 = source.split("Sirene_State14PoseScriptSet1:", 1)[1].split(
            "Boss_UpdateSireneBattlePositionsAndDistortion:", 1
        )[0]
        for block, expected in ((set0, ["0", "0", "2", "2"]), (set1, ["0", "0", "1", "1"])):
            self.assertEqual(
                expected,
                re.findall(r"\bdc\.l\s+Sirene_State14PoseScript([012])\b", block),
            )
        self.assertIn("andi.w  #$C,d0", source)
        self.assertIn("move.l  (a0,d0.w),$71C(a5)", source)
        self.assertIn("movea.l $71C(a5),a1", source)
        script2 = source.split("Sirene_State14PoseScript2:", 1)[1].split(
            "Sirene_PoseFrameData:", 1
        )[0]
        words = [
            int(token.strip()[1:], 16)
            for row in re.findall(r"\bdc\.w\s+([^;\r\n]+)", script2)
            for token in row.split(",")
        ]
        self.assertEqual([0xFFFE, 0x820, 0x50, 0x1414, 0x50, 0xFFFE], words[-6:])
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        frame = next(record for record in records if record["address"] == "0x057D18")
        self.assertEqual("Sirene_PoseFrameData", frame["current_name"])
        self.assertNotIn(frame["basis"][0], (direct["basis"], indirect["basis"]))
        self.assertIn("move.l  #Sirene_PoseFrameData,$35C(a5)", source)
        self.assertIn("add.l   $35C(a5),d0", source)

    def test_medusa_pose_scripts_exclude_frame_data_and_initial_values(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("The named Medusa state loads this word stream")
        )
        expected = {member["current_name"] for member in review["members"]}
        self.assertEqual(7, len(expected))
        self.assertEqual(
            {"src/bosses/medusa.s"},
            {member["file"] for member in review["members"]},
        )
        source = (ROOT / "src/bosses/medusa.s").read_text(encoding="utf-8")
        self.assertEqual(
            expected,
            set(re.findall(r"\blea\s+(Medusa_\w+PoseScript)\(pc\),a1", source)),
        )
        self.assertIn("bsr.w   Boss_UpdateMedusaPoseScript", source)
        self.assertIn("cmpi.w  #$FFFE,d3", source)
        self.assertIn("cmpi.w  #$FFFF,d3", source)
        for name in expected:
            with self.subTest(name=name):
                match = re.search(
                    r"(?ms)^" + re.escape(name) + r":(.*?)(?=^[A-Za-z_][A-Za-z0-9_]*:|\Z)",
                    source,
                )
                self.assertIsNotNone(match)
                rows = re.findall(r"\bdc\.w\s+([^;\r\n]+)", match.group(1))
                self.assertIn(rows[-1].split(",")[-1].strip(), ("$FFFE", "$FFFF"))
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        by_address = {record["address"]: record for record in records}
        frame = by_address["0x057132"]
        self.assertEqual("Medusa_PoseFrameData", frame["current_name"])
        self.assertNotEqual(review["basis"], frame["basis"][0])
        self.assertIn("$35C(a5)", frame["basis"][0])
        self.assertIn("move.l  #Medusa_PoseFrameData,$35C(a5)", source)
        self.assertIn("add.l   $35C(a5),d0", source)
        self.assertIn("bsr.w   Boss_CalculateMedusaPoseDeltas", source)
        initial = by_address["0x057172"]
        self.assertEqual("Medusa_InitialPoseChannelValues", initial["current_name"])
        self.assertIn("initial fixed-point pose values", " ".join(initial["basis"]))

    def test_shiper_tentacle_mappings_follow_one_indexed_direction_table(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("Boss_ShiperTentacleDirectionFrames selects")
        )
        expected = {f"Boss_ShiperTentacleSpriteMapping{index:02}" for index in range(8)}
        self.assertEqual(expected, {member["current_name"] for member in review["members"]})
        self.assertEqual(
            {"src/data/shiper_tentacle_sprite_mappings.s"},
            {member["file"] for member in review["members"]},
        )
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        for record in records:
            if record["current_name"] in expected:
                self.assertEqual(review["basis"], record["basis"][0])
        movement = (ROOT / "src/bosses/shiper_movement.s").read_text(
            encoding="utf-8"
        )
        table = movement.split("Boss_ShiperTentacleDirectionFrames:", 1)[1]
        self.assertEqual(
            ["04", "03", "02", "01", "00", "07", "06", "05"],
            re.findall(r"\bdc\.l\s+Boss_ShiperTentacleSpriteMapping(\d\d)", table),
        )
        self.assertIn("movea.l #Boss_ShiperTentacleDirectionFrames,a1", movement)
        self.assertEqual(2, movement.count("andi.w  #$E0,d2"))
        self.assertEqual(2, movement.count("asr.w   #3,d2"))
        for field in ("$1E8", "$2A8"):
            self.assertIn(f"move.l  (a1,d2.w),{field}(a5)", movement)
        mappings = (ROOT / "src/data/shiper_tentacle_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        for name in expected:
            with self.subTest(name=name):
                match = re.search(
                    rf"(?m)^{name}:\s+dc\.w\s+\$([0-9A-F]+)", mappings
                )
                self.assertIsNotNone(match)
                self.assertTrue(int(match.group(1), 16) & 0x8000)

    def test_bird_mapping_review_pins_four_streams_and_mapping_ends(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("Named Enemy_Bird animation streams select")
        )
        expected = {f"Enemy_BirdSpriteMapping{index:02}" for index in range(11)}
        self.assertEqual(expected, {member["current_name"] for member in review["members"]})
        self.assertEqual(
            {"src/data/bird_animation_mappings.s"},
            {member["file"] for member in review["members"]},
        )
        data = (ROOT / "src/data/bird_animation_mappings.s").read_text(
            encoding="utf-8"
        )
        streams = [
            data.split(f"Enemy_BirdAnimation{index:02}:", 1)[1].split(
                f"Enemy_BirdAnimation{index + 1:02}:", 1
            )[0]
            if index < 3
            else data.split("Enemy_BirdAnimation03:", 1)[1]
            for index in range(4)
        ]
        targets = [
            re.findall(r"\bdc\.w\s+Enemy_BirdSpriteMapping(\d\d)-\*", stream)
            for stream in streams
        ]
        self.assertEqual(
            ["00", "01", "02", "03", "04", "05", "06", "05", "04", "03", "02", "01"],
            targets[0],
        )
        self.assertEqual(targets[0], targets[1])
        self.assertEqual(["07", "08", "09", "08"], targets[2])
        self.assertEqual(["09", "08", "07", "10"], targets[3])
        self.assertEqual(
            expected,
            {f"Enemy_BirdSpriteMapping{index}" for stream in targets for index in stream},
        )
        for index, stream in enumerate(streams[:3]):
            with self.subTest(stream=index):
                self.assertIn(f"Enemy_BirdAnimation{index:02}-*", stream)
                self.assertRegex(stream, r"(?m)^\s*dc\.w\s+0\s*$")
        self.assertRegex(streams[3], r"(?m)^\s*dc\.w\s+\$FF\s*$")
        for name in expected:
            with self.subTest(mapping=name):
                body = re.search(
                    r"(?ms)^" + re.escape(name) + r":(.*?)(?=^[A-Za-z_][A-Za-z0-9_]*:|\Z)",
                    data,
                )
                self.assertIsNotNone(body)
                rows = re.findall(r"\bdc\.w\s+([^;\r\n]+)", body.group(1))
                self.assertTrue(int(rows[-1].split(",")[0].strip()[1:], 16) & 0x8000)
        bird = (ROOT / "src/enemies/bird_enemy.s").read_text(encoding="utf-8")
        self.assertEqual(
            [f"{index:02}" for index in range(4)],
            re.findall(r"\bdc\.l\s+Enemy_BirdAnimation(\d\d)\b", bird),
        )
        self.assertIn("Enemy_BirdAnimationMappings(pc,d0.w),8(a5)", bird)

    def test_missiray_bullet_mapping_review_pins_three_animation_streams(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("Missiray bullet animation streams select")
        )
        expected = {
            f"Projectile_MissirayBulletSpriteFrame{index:02}" for index in range(11)
        }
        self.assertEqual(expected, {member["current_name"] for member in review["members"]})
        self.assertEqual(
            {"src/data/shield_viper_and_missiray_mappings.s"},
            {member["file"] for member in review["members"]},
        )
        data = (ROOT / "src/data/shield_viper_and_missiray_mappings.s").read_text(
            encoding="utf-8"
        )
        loop = data.split("Projectile_MissirayBulletLoopSpriteAnimation:", 1)[1].split(
            "Projectile_MissirayBulletInitialSpriteAnimation:", 1
        )[0]
        initial = data.split("Projectile_MissirayBulletInitialSpriteAnimation:", 1)[
            1
        ].split("Projectile_MissirayBulletTransformSpriteAnimation:", 1)[0]
        transform = data.split("Projectile_MissirayBulletTransformSpriteAnimation:", 1)[
            1
        ]
        def targets(block: str) -> list[str]:
            return re.findall(
                r"\bdc\.w\s+Projectile_MissirayBulletSpriteFrame(\d\d)-\*", block
            )
        self.assertEqual(["01", "02", "04", "03"], targets(loop))
        self.assertEqual(["00"], targets(initial))
        self.assertEqual(["00", "10", "05", "06", "07", "08", "09"], targets(transform))
        self.assertEqual(
            expected,
            {
                f"Projectile_MissirayBulletSpriteFrame{index}"
                for index in targets(loop) + targets(initial) + targets(transform)
            },
        )
        self.assertIn("dc.w    Projectile_MissirayBulletLoopSpriteAnimation-*", loop)
        self.assertRegex(loop, r"(?m)^\s*dc\.w\s+0\s*$")
        for block in (initial, transform):
            self.assertRegex(block, r"(?m)^\s*dc\.w\s+\$FF\s*$")
        projectile = (ROOT / "src/projectiles/missiray_and_rising_shots.s").read_text(
            encoding="utf-8"
        )
        for stream in ("Initial", "Transform", "Loop"):
            self.assertIn(
                f"#Projectile_MissirayBullet{stream}SpriteAnimation,8(a",
                projectile,
            )

    def test_shared_pattern_middle_longwords_have_two_eight_element_rows(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("The structural name records exact width")
        )
        expected = {
            (0xFFFF9400 + 0x20 * row + 4 * index, f"SharedPatternRow{row}Long{index}")
            for row in range(2)
            for index in range(1, 7)
        }
        self.assertEqual(
            expected,
            {
                (int(member["address"], 16), member["current_name"])
                for member in review["members"]
            },
        )
        self.assertEqual(
            {"src/ram_addrs.inc"},
            {member["file"] for member in review["members"]},
        )
        ram = (ROOT / "src/ram_addrs.inc").read_text(encoding="utf-8")
        for address, name in expected:
            with self.subTest(name=name):
                self.assertRegex(
                    ram,
                    rf"(?m)^{name}\s+equ\s+\${address:08X}\b",
                )
        for row in range(2):
            self.assertIn(
                f"TransitionPatternRow{row}       equ     SharedPatternRow{row}Long0",
                ram,
            )
            self.assertIn(f"SharedPatternRow{row}Long7", ram)
        source = (ROOT / "src/effects/transition_scroll.s").read_text(
            encoding="utf-8"
        )
        loop = source.split("Effect_ApplyTransitionMask:", 1)[1].split(
            "Effect_TransitionMaskPatternsA:", 1
        )[0]
        self.assertIn("moveq   #3,d7", loop)
        self.assertIn("dbf     d7,Effect_ApplyTransitionMask_Loop", loop)
        for row, register in enumerate(("a0", "a1")):
            with self.subTest(register=register):
                self.assertIn(f"#(TransitionPatternRow{row}-M68K_RAM)", loop)
                self.assertEqual(2, loop.count(f"({register})+"))

    def test_valkirie_pose_script_review_excludes_indirect_airborne_variants(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("The named battle-state path loads this word stream")
        )
        self.assertEqual(9, len(review["members"]))
        self.assertEqual(
            {"src/bosses/valkirie_rendering.s"},
            {member["file"] for member in review["members"]},
        )
        expected = {member["current_name"] for member in review["members"]}
        battle = (ROOT / "src/bosses/valkirie_battle.s").read_text(encoding="utf-8")
        rendering = (ROOT / "src/bosses/valkirie_rendering.s").read_text(
            encoding="utf-8"
        )
        self.assertEqual(
            expected,
            set(re.findall(r"\blea\s+(Valkirie_\w+PoseScript)\(pc\),a1", battle)),
        )
        self.assertIn("bsr.w   Anim_UpdateValkiriePoseScript", battle)
        self.assertIn("move.b  1(a1,d0.w),$23E(a5)", rendering)
        self.assertIn("cmpi.w  #$FFFE,d3", rendering)
        for name in expected:
            with self.subTest(name=name):
                match = re.search(
                    r"(?ms)^" + re.escape(name) + r":(.*?)(?=^[A-Za-z_][A-Za-z0-9_]*:|\Z)",
                    rendering,
                )
                self.assertIsNotNone(match)
                words = [
                    int(token.strip()[1:], 16)
                    if token.strip().startswith("$")
                    else int(token.strip())
                    for row in re.findall(r"\bdc\.w\s+([^;\r\n]+)", match.group(1))
                    for token in row.split(",")
                ]
                self.assertIn(words[-1], (0xFFFE, 0xFFFF))

    def test_valkirie_airborne_variants_are_neutral_and_indirect(self) -> None:
        records = json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        by_address = {record["address"]: record for record in records}
        battle = (ROOT / "src/bosses/valkirie_battle.s").read_text(encoding="utf-8")
        rendering = (ROOT / "src/bosses/valkirie_rendering.s").read_text(
            encoding="utf-8"
        )
        for index, branch_address, script_address, old_role in (
            (0, "0x055B62", "0x056330", "High"),
            (1, "0x055B82", "0x056350", "Mid"),
            (2, "0x055B96", "0x056370", "Low"),
        ):
            with self.subTest(index=index):
                branch = f"Entity_ValkirieBattleStateEUsePattern{index:02}"
                script = f"Valkirie_AirbornePattern{index:02}PoseScript"
                self.assertEqual(branch, by_address[branch_address]["current_name"])
                self.assertEqual(script, by_address[script_address]["current_name"])
                self.assertEqual(
                    f"Entity_ValkirieBattleStateEUse{old_role}Pattern",
                    by_address[branch_address]["previous_name"],
                )
                self.assertEqual(
                    f"Valkirie_Airborne{old_role}PoseScript",
                    by_address[script_address]["previous_name"],
                )
                self.assertIn(f"{branch}:", battle)
                self.assertIn(f"move.l  #{script},$41C(a5)", battle)
                self.assertIn(f"{script}:", rendering)
                self.assertNotIn(f"Valkirie_Airborne{old_role}PoseScript:", rendering)
        fallback_basis = by_address["0x055B8C"]["basis"][0]
        self.assertIn("Valkirie_AirbornePattern00PoseScript", fallback_basis)
        self.assertIn("Valkirie_AirbornePattern02PoseScript", fallback_basis)
        self.assertGreaterEqual(battle.count("movea.l $41C(a5),a1"), 2)

    def test_palette_offset_list_review_excludes_two_list_continue_record(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("Gfx_LoadMultiplePalettes consumes these signed words")
        )
        owners = {
            "StoryScreenPaletteOffsetList": "src/cutscenes/story_screen_and_title_transition.s",
            "OptionsScreenPaletteOffsetList": "src/ui/options_menu_controllers.s",
            "StageStartPaletteOffsetList": "src/stages/gameplay_initialization.s",
            "ResultsScreenPaletteOffsetList": "src/ui/results_screen.s",
            "CreditsAndPlanetPaletteOffsetList": "src/cutscenes/ending_sequence_credits.s",
            "EarlyStagePaletteOffsetList": "src/stages/configuration_records.s",
            "ShellshogunStagePaletteOffsetList": "src/stages/early_stage_process_states.s",
            "Stage8InitialPaletteOffsetList": "src/stages/configuration_records.s",
            "XiTigerCutscenePaletteOffsetList": "src/cutscenes/xi_tiger.s",
            "Stage17PaletteOffsetList": "src/stages/configuration_records.s",
            "SevenForcesCutscenePaletteOffsetList": "src/stages/seven_forces_transition_graphics.s",
        }
        self.assertEqual(set(owners), {member["current_name"] for member in review["members"]})
        self.assertEqual(
            {"src/rendering/palettes.s"},
            {member["file"] for member in review["members"]},
        )
        palette_source = (ROOT / "src/rendering/palettes.s").read_text(
            encoding="utf-8"
        )
        for name, owner_path in owners.items():
            with self.subTest(name=name):
                record = re.search(
                    r"(?ms)^" + re.escape(name) + r":(.*?)(?=^[A-Za-z_][A-Za-z0-9_]*:|\Z)",
                    palette_source,
                )
                self.assertIsNotNone(record)
                operands = [
                    row.strip()
                    for row in re.findall(r"\bdc\.w\s+([^;\r\n]+)", record.group(1))
                ]
                self.assertEqual("0", operands[-1])
                self.assertEqual(1, operands.count("0"))
                self.assertTrue(
                    all(
                        row.endswith("-Gfx_LoadPalettePreservingSharedColor")
                        for row in operands[:-1]
                    )
                )
                owner = (ROOT / owner_path).read_text(encoding="utf-8")
                self.assertRegex(
                    owner,
                    r"(?m)^\s*(?:lea|movea\.l|dc\.l)\s+[^;\r\n]*\b"
                    + re.escape(name)
                    + r"\b",
                )
        continue_record = palette_source.split(
            "ContinueScreenPaletteOffsetLists:", 1
        )[1].split("ResultsScreenPaletteOffsetList:", 1)[0]
        self.assertEqual(2, len(re.findall(r"\bdc\.w\s+0\b", continue_record)))
        self.assertIn("move.w  (a4)+,d0", palette_source)
        self.assertIn("addi.l  #Gfx_LoadPalettePreservingSharedColor,d0", palette_source)

    def test_sharpssteel_pose_stream_review_pins_interpreter_inputs(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("The named Sharpssteel state or controller")
        )
        self.assertEqual(13, len(review["members"]))
        self.assertEqual(
            {"src/bosses/sharpssteel_blades.s"},
            {member["file"] for member in review["members"]},
        )
        expected = {member["current_name"] for member in review["members"]}
        core = (ROOT / "src/bosses/sharpssteel_core.s").read_text(
            encoding="utf-8"
        )
        blades = (ROOT / "src/bosses/sharpssteel_blades.s").read_text(
            encoding="utf-8"
        )
        loaded = set(
            re.findall(
                r"\blea\s+(Boss_Sharpssteel\w+PoseCommands)\(pc\),a1",
                core + blades,
            )
        )
        self.assertEqual(expected, loaded)
        for name in expected:
            with self.subTest(name=name):
                stream = re.search(
                    r"(?ms)^" + re.escape(name) + r":(.*?)(?=^[A-Za-z_][A-Za-z0-9_]*:|\Z)",
                    blades,
                )
                self.assertIsNotNone(stream)
                operands = re.findall(r"\bdc\.b\s+([^;\r\n]+)", stream.group(1))
                values = [
                    int(token.strip()[1:], 16)
                    if token.strip().startswith("$")
                    else int(token.strip())
                    for row in operands
                    for token in row.split(",")
                ]
                self.assertIn(values[-2:], ([0xFF, 0xFF], [0xFF, 0xFE]))
        assembly = blades.split("Boss_SharpssteelUpdateBladeAssembly:", 1)[1].split(
            "Boss_SharpssteelUpdateBladePresentation:", 1
        )[0]
        self.assertIn("bsr.w   Boss_SharpssteelRunBladePoseCommands", assembly)
        self.assertRegex(
            core,
            r"lea\s+Boss_SharpssteelManualControlPoseCommands\(pc\),a1"
            r"[\s\S]*?bsr\.w\s+Boss_SharpssteelRunBladePoseCommands",
        )

    def test_stage10_wasp_review_pins_streams_and_mapping_ends(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("One or more of the four streams selected")
        )
        expected = [
            f"Enemy_Stage10WaspSpriteMapping{chr(letter)}"
            for letter in range(ord("A"), ord("M") + 1)
        ]
        self.assertEqual(
            expected, [member["current_name"] for member in review["members"]]
        )
        self.assertEqual(
            {"src/data/stage10_wasp_sprite_mappings.s"},
            {member["file"] for member in review["members"]},
        )
        data = (ROOT / "src/data/stage10_wasp_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        stream_start = data.index("Enemy_Stage10WaspSelector04Animation:")
        targets = re.findall(
            r"\bdc\.w\s+(Enemy_Stage10WaspSpriteMapping[A-M])-\*",
            data[stream_start:],
        )
        self.assertEqual(set(expected), set(targets))
        for name in expected:
            with self.subTest(name=name):
                mapping = re.search(
                    r"(?ms)^" + re.escape(name) + r":(.*?)(?=^[A-Za-z_][A-Za-z0-9_]*:|\Z)",
                    data,
                )
                self.assertIsNotNone(mapping)
                command_words = re.findall(
                    r"\bdc\.w\s+\$([0-9A-F]+)", mapping.group(1)
                )
                self.assertTrue(command_words)
                self.assertNotEqual(0, int(command_words[-1], 16) & 0x8000)
        wasp = (ROOT / "src/enemies/stage_10_wasp_and_falling_shot.s").read_text(
            encoding="utf-8"
        )
        selector_table = wasp.split("Enemy_Stage10WaspAnimationMappings:", 1)[
            1
        ].split("\n\n", 1)[0]
        self.assertEqual(
            ["04", "08", "0C", "10"],
            re.findall(
                r"\bdc\.l\s+Enemy_Stage10WaspSelector([0-9A-F]{2})Animation",
                selector_table,
            ),
        )
        self.assertIn(
            "move.l  Enemy_Stage10WaspAnimationMappings(pc,d0.w),8(a5)", wasp
        )
        self.assertIn(
            "move.l  #Enemy_Stage10WaspSelector0CAnimation,8(a5)", wasp
        )

    def test_phase_pattern_review_pins_seven_streams_and_mapping_ends(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("One or more entries in the seven-stream")
        )
        expected = [
            f"Enemy_PhasePatternSpriteMapping{chr(letter)}"
            for letter in range(ord("A"), ord("Q") + 1)
        ]
        self.assertEqual(
            expected, [member["current_name"] for member in review["members"]]
        )
        self.assertEqual(
            {"src/data/phase_pattern_sprite_mappings.s"},
            {member["file"] for member in review["members"]},
        )
        data = (ROOT / "src/data/phase_pattern_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        stream_start = data.index("Enemy_PhasePatternSelector08Animation:")
        targets = re.findall(
            r"\bdc\.w\s+(Enemy_PhasePatternSpriteMapping[A-Q])-\*",
            data[stream_start:],
        )
        self.assertEqual(set(expected), set(targets))
        for name in expected:
            with self.subTest(name=name):
                mapping = re.search(
                    r"(?ms)^" + re.escape(name) + r":(.*?)(?=^[A-Za-z_][A-Za-z0-9_]*:|\Z)",
                    data,
                )
                self.assertIsNotNone(mapping)
                command_words = re.findall(
                    r"\bdc\.w\s+\$([0-9A-F]+)", mapping.group(1)
                )
                self.assertTrue(command_words)
                self.assertNotEqual(0, int(command_words[-1], 16) & 0x8000)
        helpers = (ROOT / "src/enemies/shared_enemy_helpers.s").read_text(
            encoding="utf-8"
        )
        selector_table = helpers.split(
            "Enemy_PhasePatternAnimationBySelector:", 1
        )[1].split("\n\n", 1)[0]
        self.assertEqual(
            ["04", "08", "0C", "10", "14", "18", "1C"],
            re.findall(
                r"\bdc\.l\s+Enemy_PhasePatternSelector([0-9A-F]{2})Animation",
                selector_table,
            ),
        )
        self.assertIn(
            "move.l  Enemy_PhasePatternAnimationBySelector(pc,d0.w),8(a5)",
            helpers,
        )

    def test_teddy_bear_mapping_review_pins_stream_targets_and_terminators(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        review = next(
            item
            for item in reviews
            if item["basis"].startswith("A Stage 12 Teddy Bear animation stream")
        )
        expected = [
            f"Stage12_TeddyBearSpriteMapping{chr(letter)}"
            for letter in range(ord("A"), ord("R") + 1)
        ]
        self.assertEqual(expected, [member["current_name"] for member in review["members"]])
        self.assertEqual(
            {"src/data/shared_stage_object_sprite_mappings.s"},
            {member["file"] for member in review["members"]},
        )
        data = (ROOT / "src/data/shared_stage_object_sprite_mappings.s").read_text(
            encoding="utf-8"
        )
        streams = data.split("; Animation streams", 1)[1]
        targets = re.findall(
            r"\bdc\.w\s+(Stage12_TeddyBearSpriteMapping[A-R])-\*", streams
        )
        self.assertEqual(set(expected), set(targets))
        for name in expected:
            with self.subTest(name=name):
                mapping = re.search(
                    r"(?ms)^" + re.escape(name) + r":(.*?)(?=^[A-Za-z_][A-Za-z0-9_]*:|\Z)",
                    data,
                )
                self.assertIsNotNone(mapping)
                command_words = re.findall(
                    r"\bdc\.w\s+\$([0-9A-F]+)", mapping.group(1)
                )
                self.assertTrue(command_words)
                self.assertNotEqual(0, int(command_words[-1], 16) & 0x8000)
        resolver = (ROOT / "src/rendering/sprite_object_pipeline.s").read_text(
            encoding="utf-8"
        )
        self.assertIn("adda.w  (a4),a4", resolver)

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
