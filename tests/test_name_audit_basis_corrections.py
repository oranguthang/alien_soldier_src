"""Guard exact-address basis corrections and the control flow behind them."""

from __future__ import annotations

import json
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))
from patch_name_audit_bases import patch_bytes  # noqa: E402


class NameAuditBasisCorrectionTests(unittest.TestCase):
    def test_byte_preserving_patch_is_strict_and_idempotent(self) -> None:
        original = (
            b'{"records":[\r\n'
            b'  {"address":"0x000100","current_name":"Example","basis":["old"]}\r\n'
            b']}\r\n'
        )
        change = {
            "address": "0x000100",
            "current_name": "Example",
            "old_basis": "old",
            "new_basis": "new",
        }
        updated, count = patch_bytes(original, [change])
        self.assertEqual(1, count)
        self.assertEqual(original.replace(b'["old"]', b'["new"]'), updated)
        self.assertEqual((updated, 0), patch_bytes(updated, [change]))
        with self.assertRaisesRegex(ValueError, "expected old basis"):
            patch_bytes(original, [{**change, "old_basis": "wrong"}])
        with self.assertRaisesRegex(ValueError, "current name changed"):
            patch_bytes(original, [{**change, "current_name": "Other"}])

    def test_correction_ledger_matches_audit_and_exact_source_gates(self) -> None:
        changes = json.loads(
            (ROOT / "config/name_audit_basis_corrections.json").read_text(encoding="utf-8")
        )["corrections"]
        audit = {
            record["address"]: record
            for record in json.loads((ROOT / "config/name_audit.json").read_text(encoding="utf-8"))["records"]
        }
        self.assertEqual(16, len(changes))
        self.assertEqual(16, len({change["address"] for change in changes}))
        for change in changes:
            with self.subTest(address=change["address"]):
                record = audit[change["address"]]
                self.assertEqual(change["current_name"], record["current_name"])
                self.assertEqual([change["new_basis"]], record["basis"])
                self.assertNotEqual(change["old_basis"], change["new_basis"])

        seven = (ROOT / "src/player/seven_forces_battle.s").read_text(encoding="utf-8")
        ceiling = (ROOT / "src/player/air_and_ground_states.s").read_text(encoding="utf-8")
        self.assertIn("btst    #1,$69(a5)", seven)
        self.assertIn("bne.w   Player_ToggleSevenForcesShootingMode", seven)
        self.assertIn("btst    #0,$69(a5)", ceiling)
        self.assertIn("bne.w   Player_ToggleShootingMode", ceiling)
        for source in (seven, ceiling):
            self.assertIn("btst    #6,$6A(a5)", source)
            self.assertIn("tst.w   (WeaponStateCooldown).w", source)

        terrain = (ROOT / "src/player/terrain_collision.s").read_text(encoding="utf-8")
        lower = terrain.split("Physics_CheckLowerTerrainWhenDescending:", 1)[1].split(
            "; End of function Physics_CheckLowerTerrainWhenDescending", 1
        )[0]
        upper = terrain.split("Physics_CheckUpperTerrainWhenRising:", 1)[1].split(
            "; End of function Physics_CheckUpperTerrainWhenRising", 1
        )[0]
        self.assertEqual(3, lower.count("bmi.s   Physics_CheckLowerTerrainWhenDescending_Return"))
        self.assertEqual(3, upper.count("bpl.s   Physics_CheckUpperTerrainWhenRising_Return"))

        valkirie = (ROOT / "src/bosses/valkirie_rendering.s").read_text(encoding="utf-8")
        for instruction in (
            "tst.w   $23E(a5)", "move.l  #$2C000,$1F8(a5)",
            "move.l  #$FFFD4000,$1F8(a5)", "bclr    #6,$21(a5)",
            "move.w  #4,$5C(a5)", "move.l  #$12000,$1F8(a5)",
            "move.l  #$FFFEE000,$1F8(a5)",
        ):
            self.assertIn(instruction, valkirie)
        self.assertIn("beq.s   Entity_SetValkirieAuxiliaryFastNegativeVelocity", valkirie)
        self.assertIn("beq.s   Entity_SetValkirieAuxiliarySlowNegativeVelocity", valkirie)

        velocity = (ROOT / "src/player/terrain_wrappers.s").read_text(encoding="utf-8")
        self.assertIn("cmpi.l  #$FFFD6000,d0", velocity)
        self.assertIn("bmi.s   Physics_AccelerateHorizontalNegative_Store", velocity)
        self.assertIn("subi.l  #$A800,d0", velocity)
        self.assertIn("cmpi.l  #$2A000,d0", velocity)
        self.assertIn("bpl.s   Physics_AccelerateHorizontalPositive_Store", velocity)
        self.assertIn("addi.l  #$A800,d0", velocity)

        terrain = (ROOT / "src/player/terrain_collision.s").read_text(encoding="utf-8")
        for level, base, flag in (
            ("Lower", "Physics_HandleLowerLeftOuterTerrain", 0),
            ("Upper", "Physics_HandleUpperLeftOuterTerrain", 1),
        ):
            right = f"Physics_Handle{level}RightInnerTerrain"
            self.assertIn(f"movea.w Physics_{level}RightInnerResponseTable(pc,d2.w),a4", terrain)
            self.assertIn(f"adda.l  #{base},a4", terrain)
            self.assertIn(f"bset    #{flag},6(a5)", terrain)
            self.assertIn(right + "_Dispatch:", terrain)
        self.assertIn("bset    #2,6(a5)", terrain)

        bullet = (ROOT / "src/projectiles/shared_boss_projectiles.s").read_text(
            encoding="utf-8"
        )
        entry = bullet.split("Projectile_InitValkirieBulletFromSource:", 1)[1].split(
            "; End of function Projectile_InitValkirieBulletFromSource", 1
        )[0]
        packed = entry.split("Projectile_CopyValkiriePackedSizeFields:", 1)[1]
        self.assertIn("move.w  #$480,(a0)", entry)
        self.assertIn("move.w  d3,$48(a0)", entry)
        self.assertIn("move.w  d4,$4A(a0)", entry)
        self.assertIn("btst    #6,2(a0)", entry)
        self.assertIn("bne.s   Projectile_CopyValkiriePackedSizeFields", entry)
        self.assertIn("move.l  8(a1),8(a0)", packed)
        self.assertNotIn("#$480", packed)

        responses = (ROOT / "src/player/terrain_responses.s").read_text(
            encoding="utf-8"
        )
        for helper, seed, branch, caller in (
            ("Physics_PrepareVerticalOffset6", 6,
             "Physics_AlignFloorQuarterSubtractOffset", "Physics_ApplyOffset6Sub10"),
            ("Physics_PrepareQuarterAddOffset3", 3,
             "Physics_AlignFloorQuarterAddOffset", "Physics_ApplyOffset3Sub6"),
        ):
            with self.subTest(helper=helper):
                body = responses.split(helper + ":", 1)[1].split(
                    "; End of function " + helper, 1
                )[0]
                self.assertIn(f"moveq   #{seed},d3", body)
                self.assertIn(f"bra.s   {branch}", body)
                self.assertIn(f"bsr.s   {helper}", responses)
                self.assertIn(caller + ":", responses)


if __name__ == "__main__":
    unittest.main()
