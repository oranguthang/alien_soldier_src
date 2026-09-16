#!/usr/bin/env python3
"""Check repository-owned configuration, Python, docs, and file naming."""

from __future__ import annotations

import json
import re
import subprocess
import sys
from pathlib import Path


MARKDOWN_LINK = re.compile(r"\[[^]]+\]\(([^)]+)\)")
TEXT_SUFFIXES = {".s", ".inc", ".py", ".md", ".txt", ".json", ".dot"}
TEXT_FILENAMES = {".gitattributes", ".gitignore", ".editorconfig", "Makefile"}


def tracked_text_files(project_root: Path) -> list[Path]:
    """Every tracked file the repository treats as text.

    Line endings and whitespace are checked against the working tree rather
    than the index, because that is what an editor, a generator script and the
    assembler all see. .gitattributes normalizes what git stores; nothing but
    this check notices when a tool writes CRLF back into the tree.
    """
    result = subprocess.run(
        ["git", "ls-files"], cwd=project_root,
        capture_output=True, text=True, check=False,
    )
    if result.returncode != 0:
        return []
    paths = [project_root / line for line in result.stdout.splitlines() if line]
    return [
        path for path in paths
        if path.is_file() and (path.suffix in TEXT_SUFFIXES or path.name in TEXT_FILENAMES)
    ]


def check_text_hygiene(project_root: Path, path: Path, errors: list[str]) -> None:
    relative = path.relative_to(project_root).as_posix()
    try:
        text = path.read_bytes().decode("utf-8")
    except UnicodeDecodeError:
        errors.append(f"{relative}: not valid UTF-8")
        return
    if "\r" in text:
        errors.append(f"{relative}: contains CR; text files use LF")
    if text and not text.endswith("\n"):
        errors.append(f"{relative}: missing final newline")
    if text.endswith("\n\n"):
        errors.append(f"{relative}: more than one final newline")
    for number, line in enumerate(text.split("\n"), 1):
        if line != line.rstrip():
            errors.append(f"{relative}:{number}: trailing whitespace")


def check(project_root: Path) -> list[str]:
    errors: list[str] = []

    for path in tracked_text_files(project_root):
        check_text_hygiene(project_root, path, errors)

    for path in sorted((project_root / "docs").glob("*")):
        if path.is_file() and path.name != path.name.lower():
            errors.append(f"{path.relative_to(project_root)}: documentation filename is not lowercase")

    for path in sorted(project_root.glob("config/*.json")) + [project_root / "assets/manifest.json"]:
        try:
            json.loads(path.read_text(encoding="utf-8"))
        except (OSError, UnicodeError, json.JSONDecodeError) as error:
            errors.append(f"{path.relative_to(project_root)}: invalid JSON: {error}")

    python_files = sorted((project_root / "scripts").glob("*.py")) + sorted(
        (project_root / "tests").glob("*.py")
    )
    for path in python_files:
        try:
            source = path.read_text(encoding="utf-8")
            compile(source, str(path), "exec")
        except (OSError, UnicodeError, SyntaxError) as error:
            errors.append(f"{path.relative_to(project_root)}: invalid Python: {error}")

    markdown_files = [project_root / "README.md"] + sorted((project_root / "docs").glob("*.md"))
    for path in markdown_files:
        text = path.read_text(encoding="utf-8")
        for target in MARKDOWN_LINK.findall(text):
            if target.startswith(("http://", "https://", "mailto:", "#")):
                continue
            clean_target = target.split("#", 1)[0]
            if clean_target and not (path.parent / clean_target).resolve().exists():
                errors.append(f"{path.relative_to(project_root)}: broken link {target}")

    return errors


def main() -> int:
    errors = check(Path.cwd())
    if errors:
        for error in errors:
            print(f"[ERROR] {error}", file=sys.stderr)
        return 1
    print(
        "[OK] project policy: text hygiene across "
        f"{len(tracked_text_files(Path.cwd()))} tracked text files, "
        "JSON, Python, documentation names and links"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
