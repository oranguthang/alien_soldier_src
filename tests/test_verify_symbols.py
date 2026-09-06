from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import verify_symbols  # noqa: E402


class VerifySymbolsTests(unittest.TestCase):
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
