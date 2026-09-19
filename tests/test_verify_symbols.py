from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import verify_symbols  # noqa: E402


class VerifySymbolsTests(unittest.TestCase):
    def test_listing_retains_aliases_and_normalizes_ram_addresses(self) -> None:
        def row(address: int, source: str) -> str:
            return f"(1)  1/ {address:7X} :".ljust(40) + source + "\n"

        with tempfile.TemporaryDirectory() as directory:
            listing = Path(directory) / "main.lst"
            listing.write_text(
                row(0x1F494, "WeaponSetup_IdleState: rts")
                + row(0x1F494, "WeaponSetup_IdleAlias: rts")
                + row(0, "StageTimeRemaining equ $FFFFA270"),
                encoding="latin-1",
            )
            names, errors = verify_symbols.load_all_listing_names(listing)
        self.assertEqual([], errors)
        self.assertEqual(0x1F494, names["WeaponSetup_IdleState"])
        self.assertEqual(0x1F494, names["WeaponSetup_IdleAlias"])
        self.assertEqual(0xFFA270, names["StageTimeRemaining"])

    def test_name_audit_requires_every_exact_listing_address(self) -> None:
        records = [
            {"current_name": "WeaponSetup_IdleState", "address": "0x000053"},
            {"current_name": "StageTimeRemaining", "address": "0xFFA270"},
            {"current_name": "MissingName", "address": "0x1234"},
        ]
        errors = verify_symbols.validate_name_audit_addresses(
            records,
            {"WeaponSetup_IdleState": 0x1F494, "StageTimeRemaining": 0xFFA270},
        )
        self.assertEqual(2, len(errors))
        self.assertIn("0x000053; listing has 0x01F494", errors[0])
        self.assertIn("MissingName", errors[1])

    def test_runtime_offsets_resolve_to_base_symbol(self) -> None:
        layout = {"rom_image": {"landmarks": [{"symbol": "Reset", "address": "0x200"}]}}
        runtime = {
            "scenarios": [
                {
                    "expectations": [
                        {
                            "symbol": "Entity_ObjectPool",
                            "offset": "0x1E0",
                            "address": "0xFFC800",
                        }
                    ]
                }
            ]
        }
        self.assertEqual(
            {"Reset": 0x200, "Entity_ObjectPool": 0xFFC620},
            verify_symbols.required_symbols(layout, runtime),
        )

    def test_validation_requires_canonical_name_and_minimum(self) -> None:
        errors = verify_symbols.validate(
            {0x200: "Reset"},
            {"Reset": 0x200},
            {"Reset": 0x200, "GameModeIndex": 0xFFA284},
            minimum=2,
        )
        self.assertEqual(2, len(errors))
        self.assertIn("expected at least 2", errors[0])
        self.assertIn("GameModeIndex", errors[1])


if __name__ == "__main__":
    unittest.main()
