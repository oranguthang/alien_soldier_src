from __future__ import annotations

import sys
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
                "build",
                "runtime/captures",
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


if __name__ == "__main__":
    unittest.main()
