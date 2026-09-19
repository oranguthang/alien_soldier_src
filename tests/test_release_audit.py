from __future__ import annotations

import json
import copy
import subprocess
import sys
import tempfile
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
        errors = [error for error in errors if not error.startswith("tag-ready status claimed")]
        self.assertEqual([], errors)
        self.assertEqual(579, stats["assets"])
        self.assertGreaterEqual(stats["modules"], 26)
        self.assertEqual(12, stats["runtime_scenarios"])
        self.assertGreaterEqual(stats["runtime_expectations"], 60)

    def test_a_drifted_counter_is_rejected(self) -> None:
        contract = json.loads(
            (ROOT / "config/release_0_5.json").read_text(encoding="utf-8")
        )
        manifest = self._manifest()
        manifest["counters"]["modules"] += 1
        policy = json.loads(
            (ROOT / "config/source_policy.json").read_text(encoding="utf-8")
        )
        layout = json.loads(
            (ROOT / "config/rom_layout.json").read_text(encoding="utf-8")
        )
        errors = release_audit.audit_counters(ROOT, manifest, policy, layout, {})
        self.assertTrue(any("counter modules says" in error for error in errors), errors)
        self.assertEqual(len(contract["required_runtime_ids"]), manifest["counters"]["runtime_scenarios"])

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
        """The release manifest with its status pinned to development.

        Every claim the manifest makes must hold whatever the working tree looks
        like. Tag-ready and tagged status add git-dependent checks, exercised
        separately below.
        """
        manifest = json.loads(
            (ROOT / "config/source_reconstruction_1_0.json").read_text(encoding="utf-8")
        )
        manifest["status"] = "development"
        return manifest

    def _audit_manifest(self, manifest: dict) -> list[str]:
        makefile = (ROOT / "Makefile").read_text(encoding="utf-8")
        runtime = json.loads(
            (ROOT / "config/runtime_scenarios.json").read_text(encoding="utf-8")
        )
        return release_audit.audit_manifest(ROOT, manifest, makefile, runtime)

    def test_tag_readiness_adds_only_git_state_checks(self) -> None:
        """A tag-ready manifest adds git-state errors and nothing else.

        The static claims must hold no matter what the working tree looks like,
        so every test that checks them pins the status to development.
        """
        development = self._manifest()
        tag_ready = copy.deepcopy(development)
        tag_ready["status"] = "tag-ready"
        baseline = self._audit_manifest(development)
        extra = [
            error for error in self._audit_manifest(tag_ready) if error not in baseline
        ]
        for error in extra:
            self.assertTrue(error.startswith("tag-ready status claimed"), error)

    def test_tagged_release_is_exact_and_annotated(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)

            def git(*args: str) -> str:
                return subprocess.run(
                    ["git", *args], cwd=root, capture_output=True, text=True,
                    check=True,
                ).stdout.strip()

            tag = "source-reconstruction-1.0"
            manifest_path = root / "config/source_reconstruction_1_0.json"
            manifest_path.parent.mkdir()
            git("init", "-q")
            git("config", "user.name", "Release Audit Test")
            git("config", "user.email", "release-audit@example.invalid")
            manifest_path.write_text('{"status":"tag-ready"}\n', encoding="utf-8")
            git("add", "--", "config/source_reconstruction_1_0.json")
            git("commit", "-qm", "Release candidate")
            candidate = git("rev-parse", "HEAD")
            git("tag", "-a", tag, "-m", "Source Reconstruction 1.0")

            manifest_path.write_text('{"status":"tagged"}\n', encoding="utf-8")
            git("add", "--", "config/source_reconstruction_1_0.json")
            git("commit", "-qm", "Record release tag")
            self.assertEqual([], release_audit.audit_tagged(root, {"tag": tag}))

            untracked = root / "untracked.txt"
            untracked.write_text("not part of the release\n", encoding="utf-8")
            errors = release_audit.audit_tagged(root, {"tag": tag})
            self.assertTrue(any("dirty working tree" in error for error in errors))
            untracked.unlink()

            (root / "source.s").write_text("Source:\n", encoding="utf-8")
            git("add", "--", "source.s")
            git("commit", "-qm", "Change source after release")
            errors = release_audit.audit_tagged(root, {"tag": tag})
            self.assertTrue(any("does not identify this release" in error for error in errors))

            git("tag", "-d", tag)
            errors = release_audit.audit_tagged(root, {"tag": tag})
            self.assertTrue(any("cannot be resolved" in error for error in errors))

            git("tag", tag, candidate)
            errors = release_audit.audit_tagged(root, {"tag": tag})
            self.assertTrue(any("not annotated" in error for error in errors))

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
