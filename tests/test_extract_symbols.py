from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import extract_symbols  # noqa: E402


class ExtractSymbolsTests(unittest.TestCase):
    def extract(self, listing: str) -> dict[int, str]:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "main.lst"
            path.write_text(listing, encoding="latin-1")
            return extract_symbols.extract_symbols(path)

    def test_included_labels_data_and_equates(self) -> None:
        symbols = self.extract(
            "\n".join(
                [
                    "(1)    7/     200 :                     Reset: rts",
                    "(1)    8/     202 : 4E75                loc_202: rts",
                    "(1)    9/       0 : =$FFFFA284           GameModeIndex equ $FFFFA284",
                    "(1)   10/       0 : =0                   ZERO_FLAG equ $0",
                    "      11/     204 :                     MainFileLabel: rts",
                ]
            )
        )
        self.assertEqual("Reset", symbols[0x200])
        self.assertEqual("loc_202", symbols[0x202])
        self.assertEqual("MainFileLabel", symbols[0x204])
        self.assertEqual("GameModeIndex", symbols[0xFFA284])
        self.assertNotIn(0, symbols)

    def test_reviewed_alias_wins_at_same_address(self) -> None:
        symbols = self.extract(
            "\n".join(
                [
                    "(1)    1/   2B6D4 :                     sub_2B6D4:",
                    "(1)    2/   2B6D4 :                     Object_UpdateProximityPickupEmitterType48:",
                ]
            )
        )
        self.assertEqual("Object_UpdateProximityPickupEmitterType48", symbols[0x2B6D4])

    def test_default_filter_excludes_address_derived_names(self) -> None:
        symbols = {
            0x200: "Reset",
            0x202: "loc_202",
            0x204: "word_204",
            0xFFFFA284: "GameModeIndex",
        }
        self.assertEqual(
            {0x200: "Reset", 0xFFFFA284: "GameModeIndex"},
            extract_symbols.filter_symbols(symbols),
        )


if __name__ == "__main__":
    unittest.main()
