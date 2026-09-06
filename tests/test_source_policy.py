from __future__ import annotations

import json
import sys
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
        self.assertEqual(4826, len(inventory.provenance))
        self.assertEqual(10493, len(inventory.address_derived))


if __name__ == "__main__":
    unittest.main()
