from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import clean_project  # noqa: E402


class CleanPolicyTests(unittest.TestCase):
    def test_clean_only_targets_reproducible_outputs(self) -> None:
        targets = {Path(item).as_posix() for item in clean_project.ROOT_TARGETS}
        self.assertEqual(
            {
                "build/main.p",
                "build/main.lst",
                "build/source_inventory.json",
                "alien_soldier_j.p",
                "alien_soldier_j.lst",
                "asbuilt.bin",
            },
            targets,
        )
        self.assertEqual(["__pycache__"], clean_project.RECURSIVE_PATTERNS)

    def test_clean_never_targets_preservation_inputs_or_work(self) -> None:
        rendered = "\n".join(clean_project.ROOT_TARGETS + clean_project.RECURSIVE_PATTERNS)
        for protected in ("data", "assets", "movies", "logs", "workflow", "backup"):
            self.assertNotIn(protected, rendered.lower())

    def test_checked_target_rejects_escape_and_links(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            self.assertEqual(root / "build", clean_project.checked_target(root, "build"))
            for unsafe in (".", "..", "build/../data", root):
                with self.subTest(unsafe=str(unsafe)):
                    with self.assertRaises(ValueError):
                        clean_project.checked_target(root, unsafe)
            outside = root.parent / (root.name + "_outside")
            link = root / "runtime"
            try:
                link.symlink_to(outside, target_is_directory=True)
            except (OSError, NotImplementedError):
                return
            with self.assertRaises(ValueError):
                clean_project.checked_target(root, "runtime/captures")

    def test_clean_preserves_inputs_and_unrelated_work(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            for relative in (
                "build/main.p",
                "build/main.lst",
                "build/source_inventory.json",
                "build/their_config.json",
                "runtime/captures/boot.genstate",
                "runtime/captures/boot/000020.genstate",
                "runtime/captures/boot/000020.png",
                "runtime/captures/boot/private.png",
                "scripts/__pycache__/test.pyc",
                "data/other/asset.bin",
                "reference/__pycache__/private.pyc",
            ):
                path = root / relative
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_bytes(b"test")
            config = root / "config/runtime_scenarios.json"
            config.parent.mkdir(parents=True, exist_ok=True)
            config.write_text('{"scenarios": [{"id": "boot", "frame": 20}]}', encoding="utf-8")
            clean_project.clean(root)
            for relative in (
                "build/main.p", "build/main.lst", "build/source_inventory.json",
                "runtime/captures/boot/000020.genstate",
                "runtime/captures/boot/000020.png", "scripts/__pycache__",
            ):
                self.assertFalse((root / relative).exists(), relative)
            for relative in (
                "build/their_config.json",
                "runtime/captures/boot.genstate",
                "runtime/captures/boot/private.png",
                "data/other/asset.bin",
                "reference/__pycache__/private.pyc",
            ):
                self.assertEqual(b"test", (root / relative).read_bytes())


if __name__ == "__main__":
    unittest.main()
