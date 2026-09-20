from __future__ import annotations

import json
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
AUDIT = ROOT / "config/name_audit.json"


class DistinctRamFieldEvidenceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.records = {
            record["address"]: record
            for record in json.loads(AUDIT.read_text(encoding="utf-8"))["records"]
        }

    def test_active_and_shadow_palette_roles_are_distinct(self) -> None:
        active = self.records["0xFFE300"]["basis"]
        shadow = self.records["0xFFE380"]["basis"]
        self.assertNotEqual(active, shadow)
        self.assertIn("CRAM", active[0])
        self.assertIn("fade", shadow[0])

        transfer = (ROOT / "src/rendering/vblank_dma.s").read_text(encoding="utf-8")
        self.assertIn("Gfx_RunVBlankTransfers_UploadPalette:", transfer)
        self.assertIn("move.w  #$9580,(a0)", transfer)
        self.assertIn("move.w  #$96F1,(a0)", transfer)
        fades = (ROOT / "src/rendering/palette_fades.s").read_text(encoding="utf-8")
        self.assertIn("lea     (PaletteActiveBuffer).w,a0", fades)
        self.assertIn("lea     (PaletteShadowBuffer).w,a1", fades)

    def test_weapon_menu_offsets_follow_separate_axes(self) -> None:
        x_basis = self.records["0xFFFF8032"]["basis"][-1]
        y_basis = self.records["0xFFFF8034"]["basis"][-1]
        self.assertNotEqual(x_basis, y_basis)
        self.assertIn("X accumulator d5", x_basis)
        self.assertIn("Y accumulator d6", y_basis)
        source = (ROOT / "src/weapons/special_firing_and_feedback.s").read_text(
            encoding="utf-8"
        )
        self.assertIn("add.w   (WeaponMenuSpawnXOffset).w,d5", source)
        self.assertIn("add.w   (WeaponMenuSpawnYOffset).w,d6", source)

    def test_vdp_register_shadows_have_separate_roles(self) -> None:
        reg1 = self.records["0xFFF7D2"]["basis"]
        reg7 = self.records["0xFFF7DE"]["basis"]
        self.assertNotEqual(reg1, reg7)
        self.assertIn("display-enable", reg1[0])
        self.assertIn("backdrop", reg7[0])
        vblank = (ROOT / "src/rendering/vblank_dma.s").read_text(encoding="utf-8")
        self.assertIn("move.w  (VDPReg1Shadow).w,(a0)", vblank)
        self.assertIn("move.w  (VDPReg7Shadow).w,(a0)", vblank)
        demo = (ROOT / "src/demo/playback.s").read_text(encoding="utf-8")
        self.assertIn("bclr    #6,(VDPReg1Shadow+1).w", demo)
        self.assertIn("move.b  #$10,(VDPReg7Shadow+1).w", demo)

    def test_shared_pattern_rows_have_exact_physical_range_review(self) -> None:
        reviews = json.loads(
            (ROOT / "config/duplicate_basis_reviews.json").read_text(encoding="utf-8")
        )["reviews"]
        basis = (
            "Many mutually exclusive scene and boss users overlap this range, so the "
            "physical row name does not claim one subsystem owner."
        )
        review = next(item for item in reviews if item["basis"] == basis)
        self.assertEqual(
            ["0xFFFF9400", "0xFFFF9420"],
            [member["address"] for member in review["members"]],
        )
        source = (ROOT / "src/effects/transition_scroll.s").read_text(
            encoding="utf-8"
        )
        self.assertIn("movea.w #(TransitionPatternRow0-M68K_RAM),a0", source)
        self.assertIn("movea.w #(TransitionPatternRow1-M68K_RAM),a1", source)
        self.assertIn("dbf     d7,Effect_ApplyTransitionMask_Loop", source)


if __name__ == "__main__":
    unittest.main()
