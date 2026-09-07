from __future__ import annotations

import hashlib
import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import build_rom  # noqa: E402
import compare_roms  # noqa: E402
import verify_toolchain  # noqa: E402


class VerificationFailureTests(unittest.TestCase):
    def run_asset_check(self, root: Path, manifest: dict) -> subprocess.CompletedProcess[str]:
        manifest_path = root / "manifest.json"
        manifest_path.write_text(json.dumps(manifest), encoding="utf-8")
        return subprocess.run(
            [
                sys.executable,
                str(ROOT / "scripts" / "check_assets.py"),
                "--manifest",
                str(manifest_path),
                "--asset-dir",
                str(root / "data"),
            ],
            capture_output=True,
            text=True,
        )

    def test_asset_check_rejects_tamper_missing_and_stale_files(self) -> None:
        canonical = b"abc"
        manifest = {
            "schema_version": 1,
            "assets": [
                {
                    "path": "other/item.bin",
                    "region": "other",
                    "size": len(canonical),
                    "sha1": hashlib.sha1(canonical).hexdigest(),
                }
            ],
        }
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            asset = root / "data" / "other" / "item.bin"
            asset.parent.mkdir(parents=True)

            missing = self.run_asset_check(root, manifest)
            self.assertNotEqual(0, missing.returncode)
            self.assertIn("missing", missing.stderr)

            asset.write_bytes(b"abd")
            tampered = self.run_asset_check(root, manifest)
            self.assertNotEqual(0, tampered.returncode)
            self.assertIn("SHA1", tampered.stderr)

            asset.write_bytes(canonical)
            (asset.parent / "stale.bin").write_bytes(b"stale")
            stale = self.run_asset_check(root, manifest)
            self.assertNotEqual(0, stale.returncode)
            self.assertIn("unexpected stale", stale.stderr)

    def test_toolchain_check_rejects_changed_file(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "tool.bin"
            path.write_bytes(b"known")
            entry = {
                "path": str(path),
                "size": 5,
                "sha256": hashlib.sha256(b"known").hexdigest(),
            }
            errors: list[str] = []
            self.assertEqual(1, verify_toolchain.check_files([entry], errors, []))
            self.assertEqual([], errors)

            path.write_bytes(b"wrong")
            errors = []
            verify_toolchain.check_files([entry], errors, [])
            self.assertTrue(any("SHA256 differs" in error for error in errors))

    def test_rom_identity_and_first_difference_fail_closed(self) -> None:
        reference = {
            "size": 3,
            "sha1": hashlib.sha1(b"abc").hexdigest(),
        }
        self.assertIsNone(build_rom.canonical_rom_error(b"abc", reference))
        self.assertIn("actual 3 bytes", build_rom.canonical_rom_error(b"abd", reference))
        self.assertEqual(1, build_rom.first_difference(b"abc", b"axc"))
        self.assertEqual(3, build_rom.first_difference(b"abc", b"abcd"))
        self.assertEqual(
            (False, "First difference at offset 0x1: 0x62 vs 0x78"),
            compare_roms.compare_files_bytes(b"abc", b"axc"),
        )


if __name__ == "__main__":
    unittest.main()
