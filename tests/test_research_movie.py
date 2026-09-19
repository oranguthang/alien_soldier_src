from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import research_movie  # noqa: E402


class ResearchMovieTests(unittest.TestCase):
    def test_set_and_resolve_report(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            marker = Path(directory) / "workflow" / ".movie"
            research_movie.set_movie(marker, "tas")
            self.assertEqual("tas", research_movie.selected_movie(marker))
            self.assertEqual(
                marker.parent / "analysis_report_tas.csv",
                research_movie.report_for_movie(marker),
            )

    def test_rejects_missing_or_unknown_movie(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            marker = Path(directory) / ".movie"
            with self.assertRaisesRegex(ValueError, "not found"):
                research_movie.selected_movie(marker)
            with self.assertRaisesRegex(ValueError, "unknown movie"):
                research_movie.set_movie(marker, "unrecognized")
            self.assertFalse(marker.exists())


if __name__ == "__main__":
    unittest.main()
