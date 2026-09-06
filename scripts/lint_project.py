#!/usr/bin/env python3
"""Check repository-owned configuration, Python, docs, and file naming."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path


MARKDOWN_LINK = re.compile(r"\[[^]]+\]\(([^)]+)\)")


def check(project_root: Path) -> list[str]:
    errors: list[str] = []

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
    print("[OK] project policy: JSON, Python, documentation names and links")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
