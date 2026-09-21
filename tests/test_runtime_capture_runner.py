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
            for scenario, frame in (("first", 100), ("second", 200)):
                capture = root / "captures" / scenario
                capture.mkdir(parents=True)
                (capture / f"{frame:06d}.genstate").write_bytes(b"old state")
                (capture / f"{frame:06d}.png").write_bytes(b"old image")
                (capture / "manual.genstate").write_bytes(b"manual state")
                (capture / "manual.png").write_bytes(b"manual image")

            calls: list[tuple[list[str], int]] = []

            def fake_run(
                command: list[str], cwd: Path, timeout: int
            ) -> subprocess.CompletedProcess:
                calls.append((command, timeout))
                self.assertEqual(root, cwd)
                capture = Path(command[command.index("-screenshot-dir") + 1])
                frame = int(command[command.index("-screenshot-interval") + 1])
                self.assertFalse((capture / f"{frame:06d}.genstate").exists())
                self.assertFalse((capture / f"{frame:06d}.png").exists())
                self.assertEqual(b"manual state", (capture / "manual.genstate").read_bytes())
                self.assertEqual(b"manual image", (capture / "manual.png").read_bytes())
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
            for scenario, frame in (("first", 100), ("second", 200)):
                capture = root / "captures" / scenario
                self.assertEqual(b"new state", (capture / f"{frame:06d}.genstate").read_bytes())
                self.assertEqual(b"new image", (capture / f"{frame:06d}.png").read_bytes())
                self.assertEqual(b"manual state", (capture / "manual.genstate").read_bytes())
                self.assertEqual(b"manual image", (capture / "manual.png").read_bytes())

    def test_bad_movie_hash_stops_before_capture_or_cleanup(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_inputs(root, movie_hash="0" * 64)
            capture = root / "captures" / "first"
            capture.mkdir(parents=True)
            old = capture / "000100.genstate"
            old.write_bytes(b"old state")
            fake_run = mock.Mock()

            self.assertEqual(1, self.run_capture(root, fake_run))
            self.assertIn("movie tas SHA-256", self.capture_stderr)
            fake_run.assert_not_called()
            self.assertEqual(b"old state", old.read_bytes())

    def test_unsafe_scenario_id_cannot_escape_capture_root(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_inputs(root)
            config_path = root / "scenarios.json"
            config = json.loads(config_path.read_text(encoding="utf-8"))
            config["scenarios"][0]["id"] = "../user"
            config_path.write_text(json.dumps(config), encoding="utf-8")
            outside = root / "user"
            outside.mkdir()
            old = outside / "000100.genstate"
            old.write_bytes(b"user state")
            fake_run = mock.Mock()

            self.assertEqual(1, self.run_capture(root, fake_run))
            self.assertIn("unsafe runtime scenario id", self.capture_stderr)
            fake_run.assert_not_called()
            self.assertEqual(b"user state", old.read_bytes())

    def test_nonfile_target_is_not_removed(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_inputs(root)
            capture = root / "captures" / "first"
            capture.mkdir(parents=True)
            blocked = capture / "000100.png"
            blocked.mkdir()
            fake_run = mock.Mock()

            self.assertEqual(1, self.run_capture(root, fake_run))
            self.assertIn("unsafe capture output path", self.capture_stderr)
            fake_run.assert_not_called()
            self.assertTrue(blocked.is_dir())

    def test_linked_scenario_directory_is_not_followed(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_inputs(root)
            capture = root / "captures" / "first"
            capture.mkdir(parents=True)
            old = capture / "000100.genstate"
            old.write_bytes(b"user state")
            fake_run = mock.Mock()

            with mock.patch.object(
                run_runtime_scenarios.Path,
                "is_symlink",
                autospec=True,
                side_effect=lambda path: path == capture,
            ):
                self.assertEqual(1, self.run_capture(root, fake_run))
            self.assertIn("unsafe runtime capture directory", self.capture_stderr)
            fake_run.assert_not_called()
            self.assertEqual(b"user state", old.read_bytes())

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
