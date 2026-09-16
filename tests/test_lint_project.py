from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import lint_project  # noqa: E402


class ProjectPolicyTests(unittest.TestCase):
    def test_repository_matches_project_policy(self) -> None:
        self.assertEqual([], lint_project.check(ROOT))

    def test_every_repository_text_file_is_covered(self) -> None:
        tracked = lint_project.tracked_text_files(ROOT)
        self.assertGreater(len(tracked), 400)
        names = {path.relative_to(ROOT).as_posix() for path in tracked}
        for expected in ("Makefile", "README.md", "src/main.s", "config/rom_layout.json"):
            self.assertIn(expected, names)

    def test_text_hygiene_rejects_crlf_and_loose_whitespace(self) -> None:
        cases = {
            "good.md": (b"one\ntwo\n", []),
            "crlf.md": (b"one\r\ntwo\n", ["contains CR"]),
            "trailing.md": (b"one \ntwo\n", ["trailing whitespace"]),
            "no_newline.md": (b"one", ["missing final newline"]),
            "extra_newline.md": (b"one\n\n", ["more than one final newline"]),
            "not_utf8.md": (b"\xff\xfe\n", ["not valid UTF-8"]),
        }
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for name, (payload, wanted) in cases.items():
                path = root / name
                path.write_bytes(payload)
                errors: list[str] = []
                lint_project.check_text_hygiene(root, path, errors)
                for fragment in wanted:
                    self.assertTrue(
                        any(fragment in error for error in errors), (name, errors)
                    )
                if not wanted:
                    self.assertEqual([], errors, name)


if __name__ == "__main__":
    unittest.main()
