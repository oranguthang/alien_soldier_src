"""Pin fresh-capture behavior without launching the emulator."""

from __future__ import annotations

import hashlib
import json
import subprocess
import sys
import tempfile
import unittest
from contextlib import redirect_stderr, redirect_stdout
from io import StringIO
from pathlib import Path
from unittest import mock


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import run_runtime_scenarios  # noqa: E402


class RuntimeCaptureRunnerTests(unittest.TestCase):
    def make_inputs(self, root: Path, movie_hash: str | None = None) -> None:
        movie = root / "movies" / "run.gmv"
        movie.parent.mkdir()
        movie.write_bytes(b"pinned movie")
        (root / "gens.exe").write_bytes(b"emulator placeholder")
        (root / "rom.bin").write_bytes(b"rom placeholder")
        config = {
            "movies": {
                "tas": {
                    "path": "movies/run.gmv",
                    "sha256": movie_hash or hashlib.sha256(movie.read_bytes()).hexdigest(),
                }
            },
            "scenarios": [
                {"id": "first", "movie": "tas", "frame": 100},
                {"id": "second", "movie": "tas", "frame": 200},
            ],
        }
        (root / "scenarios.json").write_text(json.dumps(config), encoding="utf-8")

    def run_capture(self, root: Path, fake_run: object) -> int:
        argv = [
            "run_runtime_scenarios.py", "--scenarios", "scenarios.json",
            "--gens", "gens.exe", "--rom", "rom.bin",
            "--output-dir", "captures", "--minimum-timeout", "1",
            "--seconds-per-1000-frames", "20",
        ]
        with mock.patch.object(run_runtime_scenarios.Path, "cwd", return_value=root):
            with mock.patch.object(run_runtime_scenarios.sys, "argv", argv):
                with mock.patch.object(run_runtime_scenarios, "run_hidden", side_effect=fake_run):
                    stdout = StringIO()
                    stderr = StringIO()
                    with redirect_stdout(stdout), redirect_stderr(stderr):
                        result = run_runtime_scenarios.main()
        self.capture_stdout = stdout.getvalue()
        self.capture_stderr = stderr.getvalue()
        return result

    def test_each_capture_replaces_stale_outputs_at_pinned_frame(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_inputs(root)
            for scenario in ("first", "second"):
                capture = root / "captures" / scenario
                capture.mkdir(parents=True)
                (capture / "stale.genstate").write_bytes(b"old state")
                (capture / "stale.png").write_bytes(b"old image")

            calls: list[tuple[list[str], int]] = []

            def fake_run(
                command: list[str], cwd: Path, timeout: int
            ) -> subprocess.CompletedProcess:
                calls.append((command, timeout))
                self.assertEqual(root, cwd)
                capture = Path(command[command.index("-screenshot-dir") + 1])
                frame = int(command[command.index("-screenshot-interval") + 1])
                self.assertFalse((capture / "stale.genstate").exists())
                self.assertFalse((capture / "stale.png").exists())
                (capture / f"{frame:06d}.genstate").write_bytes(b"new state")
                (capture / f"{frame:06d}.png").write_bytes(b"new image")
                return subprocess.CompletedProcess(command, 0)

            self.assertEqual(0, self.run_capture(root, fake_run))
            self.assertIn("captured 2 runtime scenarios", self.capture_stdout)
            self.assertEqual(2, len(calls))
            for (command, timeout), frame in zip(calls, (100, 200)):
                with self.subTest(frame=frame):
                    self.assertEqual(
                        str((root / "rom.bin").resolve()),
                        command[command.index("-rom") + 1],
                    )
                    self.assertEqual(
                        str((root / "movies" / "run.gmv").resolve()),
                        command[command.index("-play") + 1],
                    )
                    self.assertEqual(str(frame + 1), command[command.index("-max-frames") + 1])
                    self.assertIn("-save-state-dumps", command)
                    self.assertEqual(frame * 20 // 1000, timeout)

    def test_bad_movie_hash_stops_before_capture_or_cleanup(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_inputs(root, movie_hash="0" * 64)
            capture = root / "captures" / "first"
            capture.mkdir(parents=True)
            old = capture / "stale.genstate"
            old.write_bytes(b"old state")
            fake_run = mock.Mock()

            self.assertEqual(1, self.run_capture(root, fake_run))
            self.assertIn("movie tas SHA-256", self.capture_stderr)
            fake_run.assert_not_called()
            self.assertEqual(b"old state", old.read_bytes())

    def test_missing_screenshot_fails_without_advancing_to_next_scenario(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_inputs(root)
            calls = 0

            def fake_run(
                command: list[str], cwd: Path, timeout: int
            ) -> subprocess.CompletedProcess:
                nonlocal calls
                calls += 1
                capture = Path(command[command.index("-screenshot-dir") + 1])
                frame = int(command[command.index("-screenshot-interval") + 1])
                (capture / f"{frame:06d}.genstate").write_bytes(b"new state")
                return subprocess.CompletedProcess(command, 0)

            self.assertEqual(1, self.run_capture(root, fake_run))
            self.assertIn("first: capture failed", self.capture_stderr)
            self.assertEqual(1, calls)
            self.assertFalse((root / "captures" / "second").exists())


if __name__ == "__main__":
    unittest.main()
