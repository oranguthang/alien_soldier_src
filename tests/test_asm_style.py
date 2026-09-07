from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import asm_style  # noqa: E402


class AssemblyStyleTests(unittest.TestCase):
    def test_instruction_and_inline_comment_columns(self) -> None:
        line = asm_style.normalize_line("  move.w  #1,d0 ; done.", 0)
        self.assertTrue(line.startswith("                move.w  #1,d0"))
        self.assertEqual(asm_style.COMMENT_COLUMN, line.index(";"))
        self.assertTrue(line.endswith("; done"))

    def test_semicolon_in_string_is_not_a_comment(self) -> None:
        source = 'Label: dc.b "; text",0'
        self.assertIn('"; text"', asm_style.normalize_line(source, 0))

    def test_ida_period_after_reference_flag_leaves_no_trailing_space(self) -> None:
        self.assertEqual("; sub_1234   p", asm_style.normalize_comment("; sub_1234   p ."))

    def test_label_table_uses_one_shared_column(self) -> None:
        lines = ["A: dc.w 1", "LongLabel: dc.w 2"]
        columns = asm_style.label_columns(lines, asm_style.MNEMONIC_COLUMN)
        self.assertEqual(columns[0], columns[1])

    def test_as_local_assignment_stays_in_definition_field(self) -> None:
        line = asm_style.normalize_line("\t.diff := address - *", 1)
        self.assertTrue(line.startswith(".diff"))
        self.assertIn(":=", line)

    def test_normalization_is_idempotent(self) -> None:
        once = asm_style.normalize_file("  move.w  #1,d0\nLabel:  rts\n")
        self.assertEqual(once, asm_style.normalize_file(once))


if __name__ == "__main__":
    unittest.main()
