"""Guard the flagged address table that canonical byte checks cannot type-check."""

from pathlib import Path
import re
import unittest


ROOT = Path(__file__).resolve().parents[1]
CORE = ROOT / "src/bosses/entity_type_1c0_core.s"


class EntityType1C0TableTests(unittest.TestCase):
    def test_body_part_table_matches_longword_reader(self) -> None:
        source = CORE.read_text(encoding="utf-8")
        table = source.split("EntityType1C0_BodyPartInitTable:", 1)[1]
        table = table.split("; End of", 1)[0]
        table = table.split("\n\n", 1)[0]
        entries = re.findall(r"(?m)^\s*dc\.l\s+([^;\n]+)", table)
        self.assertEqual(61, len(entries))
        self.assertNotRegex(table, r"(?m)^\s*dc\.[wb]\s+")
        self.assertEqual(
            5,
            sum("$20000000+EntityType1C0_EarlyFormPartMapping" in x for x in entries),
        )
        self.assertEqual(
            19,
            sum("$60000000+EntityType1C0_PartAnimationMappings" in x for x in entries),
        )
        self.assertRegex(source, r"move\.l\s+\(a1\)\+,d4")


if __name__ == "__main__":
    unittest.main()
