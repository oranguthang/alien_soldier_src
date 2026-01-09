#!/usr/bin/env python3
"""Show documentation progress statistics."""

import csv
from pathlib import Path
from collections import Counter

def main():
    # Find database file
    script_dir = Path(__file__).parent
    project_dir = script_dir.parent
    db_file = project_dir / 'procedure_database.csv'

    if not db_file.exists():
        print(f"Error: {db_file} not found")
        return 1

    # Read database
    with open(db_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    # Count by status
    status_counts = Counter(row['status'] for row in rows)

    # Count by scene (only analyzed)
    scene_counts = Counter(row['scene'] for row in rows if row['status'] == 'analyzed')

    # Calculate percentage
    total = len(rows)
    analyzed = status_counts.get('analyzed', 0)
    pending = status_counts.get('pending', 0)
    percentage = (analyzed / total * 100) if total > 0 else 0

    # Print results
    print("=" * 60)
    print(f"ALIEN SOLDIER DOCUMENTATION PROGRESS")
    print("=" * 60)
    print(f"\nOverall Progress:")
    print(f"  Analyzed: {analyzed:4d} procedures ({percentage:.1f}%)")
    print(f"  Pending:  {pending:4d} procedures")
    print(f"  Total:    {total:4d} procedures")

    print(f"\nTop Scenes (analyzed procedures):")
    for scene, count in scene_counts.most_common(10):
        print(f"  {count:3d}  {scene}")

    print("=" * 60)

    return 0

if __name__ == '__main__':
    import sys
    sys.exit(main())
