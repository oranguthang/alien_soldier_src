from __future__ import annotations

import json
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "config" / "source_reconstruction_1_0.json"
LAYOUT = ROOT / "config" / "rom_layout.json"
POLICY = ROOT / "config" / "source_policy.json"
RELEASE = ROOT / "config" / "release_contract.json"


class SourceReconstructionContractTests(unittest.TestCase):
    def test_strict_source_shape_is_not_weaker_than_the_agreed_contract(self) -> None:
        contract = json.loads(CONTRACT.read_text(encoding="utf-8"))
        shape = contract["source_shape"]
        preferred = shape["preferred_module_lines"]

        self.assertIn(contract["status"], {"development", "tag-ready", "tagged"})
        self.assertEqual(200, preferred["minimum"])
        self.assertEqual(700, preferred["maximum"])
        self.assertEqual(1000, shape["default_maximum_module_lines"])
        self.assertEqual(0, shape["maximum_address_derived_definitions"])
        self.assertEqual(0, shape["maximum_generic_container_names"])

        layout = json.loads(LAYOUT.read_text(encoding="utf-8"))
        policy = json.loads(POLICY.read_text(encoding="utf-8"))
        release = json.loads(RELEASE.read_text(encoding="utf-8"))
        self.assertEqual(
            shape["default_maximum_module_lines"],
            layout["target"]["max_module_lines"],
        )
        self.assertEqual(
            shape["default_maximum_module_lines"],
            release["thresholds"]["max_module_lines"],
        )
        self.assertEqual(
            shape["maximum_address_derived_definitions"],
            policy["unknowns"]["maximum_address_derived_definitions"],
        )

    def test_user_facing_release_commands_are_fixed(self) -> None:
        contract = json.loads(CONTRACT.read_text(encoding="utf-8"))
        self.assertEqual(
            [
                "make split",
                "make build",
                "make verify",
                "make test",
                "make format",
                "make lint",
            ],
            contract["required_commands"],
        )


if __name__ == "__main__":
    unittest.main()
