from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import lint_project  # noqa: E402


class ProjectPolicyTests(unittest.TestCase):
    def test_repository_matches_project_policy(self) -> None:
        self.assertEqual([], lint_project.check(ROOT))


if __name__ == "__main__":
    unittest.main()
