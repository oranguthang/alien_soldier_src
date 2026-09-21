#!/usr/bin/env python3
"""Remove only reproducible outputs within this checkout."""

from pathlib import Path
import json
import os
import re
import shutil


# Exact reproducible files. Other build/ and runtime/captures/ contents may be
# maintainer research and are not owned by this target.
ROOT_TARGETS = [
    os.path.join('build', 'main.p'),
    os.path.join('build', 'main.lst'),
    os.path.join('build', 'source_inventory.json'),
    'alien_soldier_j.p',
    'alien_soldier_j.lst',
    'asbuilt.bin',
]

# Safe interpreter caches only. Analysis logs, source backups, configuration,
# extracted data, and maintainer work are deliberately preserved.
RECURSIVE_PATTERNS = [
    '__pycache__',
]
CACHE_ROOTS = ('scripts', 'tests')
PROJECT_ROOT = Path(__file__).resolve().parents[1]


def checked_target(root: Path, relative: str | Path) -> Path:
    """Reject paths outside the checkout and all links/junctions on the way."""
    root = root.resolve()
    relative = Path(relative)
    if relative.is_absolute() or not relative.parts or any(
        part in ('.', '..') for part in relative.parts
    ):
        raise ValueError(f"unsafe cleanup target: {relative}")
    path = root
    for part in relative.parts:
        path /= part
        if path.is_symlink() or getattr(path, 'is_junction', lambda: False)():
            raise ValueError(f"cleanup target crosses a link: {path}")
    if path == root or not path.resolve().is_relative_to(root):
        raise ValueError(f"cleanup target escapes checkout: {path}")
    return path


def remove_path(root: Path, relative: str | Path, *, allow_directory: bool = False) -> bool:
    """Remove one validated, reproducible file or directory."""
    path = checked_target(root, relative)
    if path.is_file():
        path.unlink()
        print(f"  Removed file: {relative}")
        return True
    if path.is_dir():
        if not allow_directory:
            raise ValueError(f"expected cleanup file, found directory: {path}")
        shutil.rmtree(path)
        print(f"  Removed dir:  {relative}")
        return True
    return False


def runtime_capture_targets(root: Path) -> tuple[list[Path], list[Path]]:
    """Return only outputs declared by the current runtime scenario contract."""
    config = json.loads((root / 'config' / 'runtime_scenarios.json').read_text(encoding='utf-8'))
    files = []
    directories = []
    for scenario in config['scenarios']:
        scenario_id = scenario['id']
        frame = scenario['frame']
        if not isinstance(scenario_id, str) or not re.fullmatch(r'[a-z][a-z0-9_]*', scenario_id):
            raise ValueError(f"unsafe runtime scenario id: {scenario_id!r}")
        if isinstance(frame, bool) or not isinstance(frame, int) or frame < 0:
            raise ValueError(f"unsafe runtime frame: {frame!r}")
        directory = Path('runtime') / 'captures' / scenario_id
        directories.append(directory)
        files.extend(directory / f'{frame:06d}.{suffix}' for suffix in ('genstate', 'png'))
    return files, directories


def clean(root: Path = PROJECT_ROOT) -> int:
    """Clean fixed outputs and interpreter caches under code/test directories."""
    root = root.resolve()
    print("Cleaning project...")
    removed = 0
    capture_files, capture_directories = runtime_capture_targets(root)
    for target in ROOT_TARGETS:
        if remove_path(root, target):
            removed += 1

    for target in capture_files:
        if remove_path(root, target):
            removed += 1
    for target in [*capture_directories, Path('runtime') / 'captures']:
        directory = checked_target(root, target)
        if directory.is_dir():
            try:
                directory.rmdir()
            except OSError:
                pass  # Other captures belong to their owner, not make clean.

    for base in CACHE_ROOTS:
        directory = checked_target(root, base)
        if not directory.is_dir():
            continue
        for current, children, _ in os.walk(directory, topdown=True, followlinks=False):
            current = Path(current)
            safe_children = []
            for child in children:
                relative = (current / child).relative_to(root)
                candidate = checked_target(root, relative)
                if child in RECURSIVE_PATTERNS:
                    if remove_path(root, relative, allow_directory=True):
                        removed += 1
                elif candidate.is_dir():
                    safe_children.append(child)
            children[:] = safe_children
    for pattern in RECURSIVE_PATTERNS:
        if remove_path(root, pattern, allow_directory=True):
            removed += 1

    if removed == 0:
        print("  Nothing to clean")
    else:
        print(f"\n Removed {removed} item(s)")

    print("  Extracted data was preserved; only 'make split' overwrites it.")
    return removed


def main() -> None:
    clean()


if __name__ == '__main__':
    main()
