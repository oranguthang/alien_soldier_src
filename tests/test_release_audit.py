from __future__ import annotations

import json
import copy
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import release_audit  # noqa: E402


class ReleaseAuditTests(unittest.TestCase):
    def test_repository_contract_passes_static_audit(self) -> None:
        contract = json.loads(
            (ROOT / "config/release_0_5.json").read_text(encoding="utf-8")
        )
        errors, stats = release_audit.audit(ROOT, contract)
        self.assertEqual([], errors)
        self.assertEqual(579, stats["assets"])
        self.assertGreaterEqual(stats["modules"], 26)
        self.assertEqual(6, stats["runtime_scenarios"])

    def test_weakened_scope_and_threshold_are_rejected(self) -> None:
        contract = json.loads(
            (ROOT / "config/release_0_5.json").read_text(encoding="utf-8")
        )
        contract = copy.deepcopy(contract)
        contract["excluded_profiles"] = []
        contract["thresholds"]["asset_count"] = 580
        errors, _ = release_audit.audit(ROOT, contract)
        self.assertTrue(any("European" in error for error in errors))
        self.assertTrue(any("asset manifest has" in error for error in errors))


if __name__ == "__main__":
    unittest.main()
