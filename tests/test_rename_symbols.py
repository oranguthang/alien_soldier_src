from __future__ import annotations

import re
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import rename_symbols  # noqa: E402


class RenameSymbolsTests(unittest.TestCase):
    def test_replaces_symbols_but_preserves_quoted_asset_paths(self) -> None:
        mapping = {"word_1234": "Demo_InputStream"}
        pattern = re.compile(r"\b(word_1234)\b")
        line = 'word_1234: binclude "data/word_1234.bin" ; word_1234'

        renamed, count = rename_symbols.substitute_unquoted(line, pattern, mapping)

        self.assertEqual(
            'Demo_InputStream: binclude "data/word_1234.bin" ; Demo_InputStream',
            renamed,
        )
        self.assertEqual(2, count)

    def test_preserves_single_quoted_assembly_constants(self) -> None:
        mapping = {"SEGA": "Renamed"}
        pattern = re.compile(r"\b(SEGA)\b")

        renamed, count = rename_symbols.substitute_unquoted(
            "move.l #'SEGA',SEGA", pattern, mapping
        )

        self.assertEqual("move.l #'SEGA',Renamed", renamed)
        self.assertEqual(1, count)


if __name__ == "__main__":
    unittest.main()
