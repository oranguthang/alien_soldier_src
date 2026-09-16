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
        self.assertEqual(12, stats["runtime_scenarios"])
        self.assertGreaterEqual(stats["runtime_expectations"], 60)

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

    def test_weakened_source_ceiling_is_rejected(self) -> None:
        contract = json.loads(
            (ROOT / "config/release_0_5.json").read_text(encoding="utf-8")
        )
        contract = copy.deepcopy(contract)
        contract["thresholds"]["max_module_lines"] = 6000
        errors, _ = release_audit.audit(ROOT, contract)
        self.assertTrue(any("weaker than source contract" in error for error in errors))


    def _manifest(self) -> dict:
        return json.loads(
            (ROOT / "config/source_reconstruction_1_0.json").read_text(encoding="utf-8")
        )

    def _audit_manifest(self, manifest: dict) -> list[str]:
        makefile = (ROOT / "Makefile").read_text(encoding="utf-8")
        runtime = json.loads(
            (ROOT / "config/runtime_scenarios.json").read_text(encoding="utf-8")
        )
        return release_audit.audit_manifest(ROOT, manifest, makefile, runtime)

    def test_manifest_evidence_resolves(self) -> None:
        self.assertEqual([], self._audit_manifest(self._manifest()))

    def test_unresolvable_manifest_evidence_is_rejected(self) -> None:
        manifest = copy.deepcopy(self._manifest())
        requirement = manifest["requirements"]["canonical_identity"]
        requirement["evidence"]["files"] = ["docs/does_not_exist.md"]
        requirement["evidence"]["targets"] = ["no-such-target"]
        requirement["evidence"]["artifacts"] = ["no_such_artifact"]
        errors = self._audit_manifest(manifest)
        self.assertTrue(any("missing path" in error for error in errors))
        self.assertTrue(any("missing target" in error for error in errors))
        self.assertTrue(any("unknown artifact" in error for error in errors))

    def test_unnamed_partial_requirement_is_rejected(self) -> None:
        manifest = copy.deepcopy(self._manifest())
        manifest["requirements"]["source_boundary"]["excluded"] = []
        errors = self._audit_manifest(manifest)
        self.assertTrue(
            any("without naming an excluded scope" in error for error in errors)
        )

    def test_uncontrolled_exclusion_is_rejected(self) -> None:
        manifest = copy.deepcopy(self._manifest())
        manifest["excluded_scope"][0].pop("control", None)
        errors = self._audit_manifest(manifest)
        self.assertTrue(any("declares no control" in error for error in errors))

    def test_incomplete_layout_deviation_is_rejected(self) -> None:
        manifest = copy.deepcopy(self._manifest())
        manifest["layout_deviations"][0]["equivalent_control"] = ""
        errors = self._audit_manifest(manifest)
        self.assertTrue(any("is missing equivalent_control" in error for error in errors))

    def test_tracked_rom_payload_is_rejected(self) -> None:
        manifest = copy.deepcopy(self._manifest())
        manifest["prohibited_tracked_extensions"] = [".md"]
        errors = self._audit_manifest(manifest)
        self.assertTrue(any("appear in the reachable history" in error for error in errors))


if __name__ == "__main__":
    unittest.main()
