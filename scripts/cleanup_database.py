#!/usr/bin/env python3
"""
Database Cleanup Script

Cleans up procedure_database.csv by removing entries for procedures that have
already been successfully renamed:
- Checks if old_name no longer exists as a label in source
- Checks if new_name exists as a label in source
- Clears new_name/description for already-renamed procedures

This prevents collision errors when applying new renames to procedures that
were already renamed in previous batches.
"""

import csv
import re
import argparse
from pathlib import Path


def get_source_labels(source_file):
    """Extract all label definitions from assembly source file."""
    print(f"Reading source file: {source_file}")
    labels = set()

    with open(source_file, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            # Match label definitions (word followed by colon at start of line)
            match = re.match(r'^(\w+):\s', line)
            if match:
                labels.add(match.group(1))

    print(f"Found {len(labels)} label definitions in source")
    return labels


def cleanup_database(database_file, source_labels):
    """Clean up database by clearing already-renamed procedures."""
    print(f"\nReading database: {database_file}")

    rows = []
    cleared_count = 0

    with open(database_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            # Only check if there's a new name
            if row['new_name']:
                old_name = row['old_name']
                new_name = row['new_name']

                # Check if old_name no longer exists but new_name does
                if old_name not in source_labels and new_name in source_labels:
                    # This procedure was already renamed successfully
                    print(f"  Clearing: {old_name} -> {new_name} (already renamed)")
                    row['new_name'] = ''
                    row['description'] = ''
                    cleared_count += 1
                elif old_name not in source_labels and new_name not in source_labels:
                    # Neither exists - might have been deleted or renamed differently
                    print(f"  Warning: {old_name} -> {new_name} (neither exists, clearing)")
                    row['new_name'] = ''
                    row['description'] = ''
                    cleared_count += 1

            rows.append(row)

    # Write updated database
    print(f"\nWriting updated database...")
    with open(database_file, 'w', encoding='utf-8', newline='') as f:
        fieldnames = ['old_name', 'scene', 'frame', 'new_name', 'description', 'category', 'status']
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"\nCleanup complete!")
    print(f"Cleared {cleared_count} already-renamed procedures from database")

    return cleared_count


def main():
    parser = argparse.ArgumentParser(
        description='Clean up database by removing already-renamed procedures'
    )
    parser.add_argument(
        '--database',
        default='procedure_database.csv',
        help='Procedure database CSV file (default: procedure_database.csv)'
    )
    parser.add_argument(
        '--source',
        default='alien_soldier_j.s',
        help='Assembly source file (default: alien_soldier_j.s)'
    )

    args = parser.parse_args()

    # Resolve paths
    script_dir = Path(__file__).parent
    project_dir = script_dir.parent

    database_file = project_dir / args.database
    source_file = project_dir / args.source

    # Check files exist
    if not database_file.exists():
        print(f"Error: Database file not found: {database_file}")
        return 1

    if not source_file.exists():
        print(f"Error: Source file not found: {source_file}")
        return 1

    # Get labels and clean database
    try:
        source_labels = get_source_labels(source_file)
        cleanup_database(database_file, source_labels)
        return 0
    except Exception as e:
        print(f"Error during cleanup: {e}")
        return 1


if __name__ == '__main__':
    exit(main())
