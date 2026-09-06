from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import verify_layout  # noqa: E402


class VerifyLayoutTests(unittest.TestCase):
    def test_numbers_accept_manifest_forms(self) -> None:
        self.assertEqual(0x82324, verify_layout.number("0x082324"))
        self.assertEqual(2097152, verify_layout.number(2097152))

    def test_listing_parsers(self) -> None:
        lines = [
            '      13/       0 : include "src/system/example.s"',
            '(1)    7/     200 :                     Reset: rts',
        ]
        self.assertEqual([(0, "src/system/example.s")], verify_layout.listing_includes(lines))
        self.assertEqual({"Reset": 0x200}, verify_layout.listing_symbols(lines))


if __name__ == "__main__":
    unittest.main()
