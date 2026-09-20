from __future__ import annotations

import json
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
REVIEWS = ROOT / "config/duplicate_basis_reviews.json"


class BossPairEvidenceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.reviews = {
            item["basis"]: item
            for item in json.loads(REVIEWS.read_text(encoding="utf-8"))["reviews"]
        }

    def test_caterpillar_gate_is_shared_but_mapping_cycles_differ(self) -> None:
        basis = (
            "After initialization, execution enters here to test the segment's "
            "health and dispatch defeat to the shared explosion handler."
        )
        self.assertEqual(
            ["0x03D332", "0x03D3C4"],
            [member["address"] for member in self.reviews[basis]["members"]],
        )
        source = (ROOT / "src/bosses/caterpillar.s").read_text(encoding="utf-8")
        for variant in ("FourPhase", "TwoPhase"):
            with self.subTest(variant=variant):
                gate = source.split(f"Boss_CaterpillarUpdate{variant}Segment:", 1)[1]
                gate = gate.split(f"Boss_CaterpillarPosition{variant}Segment:", 1)[0]
                self.assertIn("tst.w   $24(a5)", gate)
                self.assertIn(f"bpl.s   Boss_CaterpillarPosition{variant}Segment", gate)
                self.assertIn("jmp     Boss_CaterpillarSpawnExplosion", gate)
        self.assertIn("move.w  #$58,$24(a5)", source)
        self.assertIn("move.w  #$6E,$24(a5)", source)

    def test_antroid_contact_gate_is_shared_but_followups_differ(self) -> None:
        basis = (
            "After selecting one of two linked parts, this branch tests its Y "
            "coordinate before applying attack impact."
        )
        self.assertEqual(
            ["0x037810", "0x0378DA"],
            [member["address"] for member in self.reviews[basis]["members"]],
        )
        source = (ROOT / "src/bosses/antroid_core.s").read_text(encoding="utf-8")
        for variant in ("A", "B"):
            with self.subTest(variant=variant):
                gate = source.split(f"Boss_AntroidLeapAttack{variant}CheckContact:", 1)[1]
                gate = gate.split(f"Boss_AntroidLeapAttack{variant}CheckScreenRange:", 1)[0]
                self.assertIn("cmpi.w  #$14E,$14(a0)", gate)
                self.assertIn(f"Boss_AntroidLeapAttack{variant}Animate", gate)
                self.assertIn("bsr.w   Boss_AntroidApplyAttackImpact", gate)
        self.assertIn("bra.w   Boss_AntroidEnterLeapAttackBPreparation", source)
        self.assertIn("bra.w   Boss_AntroidEnterLeapAttackAPreparation", source)

    def test_shield_viper_walkers_share_stride_not_flip_selection(self) -> None:
        basis = "All linked-record outcomes advance to the next $60-byte body record."
        self.assertEqual(
            ["0x04E5F8", "0x04E630"],
            [member["address"] for member in self.reviews[basis]["members"]],
        )
        source = (ROOT / "src/bosses/shield_viper_attacks.s").read_text(
            encoding="utf-8"
        )
        for label, loop in (
            ("Gfx_ShieldViperAdvanceHorizontalFlipLoop", "Gfx_ShieldViperUpdateHorizontalFlipLoop"),
            ("Gfx_ShieldViperAdvanceForcedHorizontalFlipLoop", "Gfx_ShieldViperForceHorizontalFlipLoop"),
        ):
            with self.subTest(label=label):
                stride = source.split(label + ":", 1)[1].split("; End of function", 1)[0]
                self.assertIn("lea     $60(a0),a0", stride)
                self.assertIn(f"dbf     d7,{loop}", stride)
        self.assertIn("or.w    d0,$E(a0)", source)
        self.assertIn("ori.w   #$2000,$E(a0)", source)

    def test_terobuster_part_windows_differ_between_missile_attacks(self) -> None:
        basis = (
            "The pose cursor range and side field determine whether the two "
            "fixed part slots are exchanged."
        )
        self.assertEqual(
            ["0x038802", "0x0388CC"],
            [member["address"] for member in self.reviews[basis]["members"]],
        )
        source = (ROOT / "src/bosses/terobuster_core.s").read_text(
            encoding="utf-8"
        )
        for variant, low, high in (("A", "5", "$18"), ("B", "$10", "$20")):
            with self.subTest(variant=variant):
                entry = f"Boss_TerobusterMissileAttack{variant}Update"
                bind = f"Boss_TerobusterMissileAttack{variant}BindPart"
                block = source.split(entry + ":", 1)[1].split(
                    bind + ":", 1
                )[0]
                slots = block.split("movea.w #(SixthEntityType-M68K_RAM),a0", 1)[1]
                self.assertIn("#(SixthEntityType-M68K_RAM),a0", block)
                self.assertIn("#(EleventhEntityType-M68K_RAM),a1", block)
                self.assertIn("tst.w   $A(a5)", slots)
                self.assertEqual(2, slots.count("exg     a0,a1"))
                self.assertIn(f"cmpi.w  #{low},$58(a5)", slots)
                self.assertIn(f"cmpi.w  #{high},$58(a5)", slots)

    def test_jampan_priority_returns_share_comparison_tail(self) -> None:
        basis = "The set- and clear-priority paths converge on this return."
        self.assertEqual(
            ["0x04A3B6", "0x04A462"],
            [member["address"] for member in self.reviews[basis]["members"]],
        )
        source = (ROOT / "src/bosses/jampan_support.s").read_text(
            encoding="utf-8"
        )
        for owner, clear, ret in (
            ("Boss_JampanRadialLinkedObjectMain", "Boss_JampanClearRadialObjectPriorityFlag",
             "Boss_JampanRadialLinkedObjectMainReturn"),
            ("Boss_JampanLinkedAnimationObjectMain", "Boss_JampanClearAnimationObjectPriorityFlag",
             "Boss_JampanLinkedAnimationObjectMainReturn"),
        ):
            with self.subTest(owner=owner):
                block = source.split(owner + ":", 1)[1].split(
                    "; End of function " + owner, 1
                )[0]
                self.assertIn("cmp.b   (PrimaryEntityAngle).w,d0", block)
                self.assertIn(f"bhi.s   {clear}", block)
                self.assertIn("ori.w   #$8000,$E(a5)", block)
                self.assertIn(f"bra.s   {ret}", block)
                self.assertIn("andi.w  #$7FFF,$E(a5)", block)
                self.assertIn(ret + ":", block)

    def test_destroyer_bouncing_parts_share_downward_core(self) -> None:
        basis = (
            "The state rotates, adds $4000 to vertical velocity, "
            "and disables drawing at Y $180."
        )
        self.assertEqual(
            ["0x04B8DA", "0x04B9D2"],
            [member["address"] for member in self.reviews[basis]["members"]],
        )
        source = (
            ROOT / "src/bosses/destroyer_mk2_linked_parts_and_debris.s"
        ).read_text(encoding="utf-8")
        for variant in ("A", "B"):
            with self.subTest(variant=variant):
                owner = f"Object_DestroyerMK2AccelerateBouncingPart{variant}Downward"
                body = source.split(owner + ":", 1)[1].split(
                    "; End of function " + owner, 1
                )[0]
                for instruction in (
                    "addi.w  #$10,$4C(a5)", "andi.w  #$1FE,d2",
                    "bsr.w   Boss_DestroyerMK2SelectCurrentObjectForFrame",
                    "addi.l  #$4000,$1C(a5)", "cmpi.w  #$180,$14(a5)",
                    "move.w  #$1000,2(a5)",
                ):
                    self.assertIn(instruction, body)
                self.assertIn(f"blt.s   Object_DestroyerMK2BouncingPart{variant}FallReturn", body)

    def test_terobuster_exit_orders_use_different_cursor_pairs_and_tests(self) -> None:
        basis = "This block chooses the two terminal cursor values according to side field $0A."
        self.assertEqual(
            ["0x0387CC", "0x038886"],
            [member["address"] for member in self.reviews[basis]["members"]],
        )
        source = (ROOT / "src/bosses/terobuster_core.s").read_text(
            encoding="utf-8"
        )
        for variant, first, second, branch in (
            ("A", "8", "$18", "beq.w"),
            ("B", "$10", "$20", "bne.w"),
        ):
            with self.subTest(variant=variant):
                owner = f"Boss_TerobusterMissileAttack{variant}ChooseExitOrder"
                block = source.split(owner + ":", 1)[1].split(
                    "; ---------------------------------------------------------------------------", 1
                )[0]
                self.assertIn(f"moveq   #{first},d0", block)
                self.assertIn(f"moveq   #{second},d1", block)
                self.assertIn("tst.w   $A(a5)", block)
                self.assertIn("exg     d0,d1", block)
                self.assertIn("cmp.w   $58(a5),d0", block)
                self.assertIn(f"{branch}   Boss_TerobusterSelectPartOrderA", block)

    def test_medusa_no_play_returns_have_distinct_frame_masks(self) -> None:
        basis = (
            "This branch is the explicit no-play return of the adjacent "
            "frame-masked Medusa sound helper."
        )
        self.assertEqual(
            ["0x057030", "0x057042"],
            [member["address"] for member in self.reviews[basis]["members"]],
        )
        source = (ROOT / "src/bosses/medusa.s").read_text(encoding="utf-8")
        for period, mask in ((4, 3), (8, 7)):
            with self.subTest(period=period):
                owner = f"Boss_MedusaPlaySFXEvery{period}Frames"
                ret = f"Boss_PlayMedusaSFXEvery{period}FramesReturn"
                block = source.split(owner + ":", 1)[1].split(
                    "; End of function " + owner, 1
                )[0]
                self.assertIn(f"andi.w  #{mask},d1", block)
                self.assertIn(f"bne.s   {ret}", block)
                self.assertIn("jmp     (Sound_QueueSFXRequest).l", block)
                self.assertIn(ret + ":", block)


if __name__ == "__main__":
    unittest.main()
