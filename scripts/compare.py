#!/usr/bin/env python3
"""
ROM Comparison Tool

Compares built ROM with original ROM to verify they are identical.
"""

import sys
import argparse
from pathlib import Path


def compare_files(file1, file2):
    """Compare two binary files byte-by-byte."""
    with open(file1, 'rb') as f1, open(file2, 'rb') as f2:
        data1 = f1.read()
        data2 = f2.read()

    if len(data1) != len(data2):
        return False, f"Size mismatch: {len(data1)} vs {len(data2)} bytes"

    if data1 == data2:
        return True, "Files are identical"

    # Find first difference
    for i, (b1, b2) in enumerate(zip(data1, data2)):
        if b1 != b2:
            return False, f"First difference at offset 0x{i:X}: 0x{b1:02X} vs 0x{b2:02X}"

    return True, "Files are identical"


def main():
    parser = argparse.ArgumentParser(description='Compare built ROM with original')
    parser.add_argument('--built', default='asbuilt.bin', help='Built ROM file')
    parser.add_argument('--original', default='alien_soldier_j.bin', help='Original ROM file')
    parser.add_argument('--project-dir', default='.', help='Project directory')

    args = parser.parse_args()

    project_dir = Path(args.project_dir).resolve()
    built_file = project_dir / args.built
    original_file = project_dir / args.original

    # Check files exist
    if not built_file.exists():
        print(f"Error: Built ROM not found: {built_file}")
        print("Run 'make build' first")
        return 1

    if not original_file.exists():
        print(f"Error: Original ROM not found: {original_file}")
        return 1

    # Compare files
    identical, message = compare_files(built_file, original_file)

    if identical:
        print("=" * 60)
        print("SUCCESS: ROMs are identical!")
        print("=" * 60)
        print(f"  Built:    {built_file.name} ({built_file.stat().st_size:,} bytes)")
        print(f"  Original: {original_file.name} ({original_file.stat().st_size:,} bytes)")
        print()
        print("✓ Assembly source matches original ROM perfectly")
        print("✓ All procedure renames preserve binary output")
        return 0
    else:
        print("=" * 60)
        print("MISMATCH: ROMs differ!")
        print("=" * 60)
        print(f"  Built:    {built_file.name} ({built_file.stat().st_size:,} bytes)")
        print(f"  Original: {original_file.name} ({original_file.stat().st_size:,} bytes)")
        print()
        print(f"Difference: {message}")
        return 1


if __name__ == '__main__':
    sys.exit(main())
