from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import lint_source  # noqa: E402


class SourcePolicyTests(unittest.TestCase):
    def test_repository_matches_source_policy(self) -> None:
        policy = json.loads((ROOT / "config/source_policy.json").read_text(encoding="utf-8"))
        inventory = lint_source.scan(policy, ROOT)
        self.assertEqual([], inventory.errors)
        self.assertGreaterEqual(
            len(inventory.provenance), policy["provenance"]["minimum_unique_mappings"]
        )
        self.assertEqual(9755, len(inventory.address_derived))

    def test_style_violations_are_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "src").mkdir()
            (root / "config").mkdir()
            (root / "src" / "main.s").write_text(
                '    include "src/bad_name.s"\n', encoding="utf-8"
            )
            (root / "src" / "bad_name.s").write_text(
                " IndentedLabel:\n" + ";" * 21,
                encoding="utf-8",
            )
            layout = {
                "target": {"max_module_lines": 10},
                "modules": [{"file": "src/bad_name.s"}],
            }
            (root / "config" / "layout.json").write_text(
                json.dumps(layout), encoding="utf-8"
            )
            policy = {
                "assembly_root": "src",
                "entrypoint": "src/main.s",
                "layout": "config/layout.json",
                "style": {
                    "maximum_line_length": 20,
                    "definitions_column_zero": True,
                    "includes_only_in_entrypoint": True,
                    "lowercase_source_paths": True,
                    "require_final_newline": True,
                },
                "provenance": {
                    "legacy_name_pattern": r"^sub_[0-9A-F]+$",
                    "minimum_unique_mappings": 0,
                },
                "unknowns": {
                    "address_derived_name_pattern": r"^sub_[0-9A-F]+$",
                    "maximum_address_derived_definitions": 10,
                },
            }
            errors = lint_source.scan(policy, root).errors

        self.assertTrue(any("column zero" in error for error in errors))
        self.assertTrue(any("missing final newline" in error for error in errors))
        self.assertTrue(any("limit is 20" in error for error in errors))


if __name__ == "__main__":
    unittest.main()
