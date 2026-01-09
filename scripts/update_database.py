#!/usr/bin/env python3
"""
Update Database from Batch Analysis

Updates procedure_database.csv with analyzed procedures from batch_analysis.csv:
- Merges new_name, description, and category fields
- Preserves existing database structure
- Validates input data
"""

import csv
import argparse
from pathlib import Path


def update_database(batch_file, database_file):
    """Update database with batch analysis results."""
    # Read batch analysis
    print(f"Reading batch analysis from {batch_file}...")
    batch_data = {}
    batch_count = 0

    with open(batch_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            if not row['old_name']:
                continue
            batch_data[row['old_name']] = row
            batch_count += 1

    print(f"Found {batch_count} procedures in batch analysis")

    # Read and update database
    print(f"Reading database from {database_file}...")
    updated_rows = []
    updated_count = 0

    with open(database_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            if row['old_name'] in batch_data:
                # Update with batch data
                batch_row = batch_data[row['old_name']]
                row['new_name'] = batch_row['new_name']
                row['description'] = batch_row['description']
                row['category'] = batch_row['category']
                row['status'] = 'analyzed'
                print(f"  {row['old_name']:12} -> {row['new_name']}")
                updated_count += 1
            updated_rows.append(row)

    # Write updated database
    print(f"\nWriting updated database to {database_file}...")
    with open(database_file, 'w', encoding='utf-8', newline='') as f:
        fieldnames = ['old_name', 'scene', 'frame', 'new_name', 'description', 'category', 'status']
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(updated_rows)

    print(f"\nDatabase updated successfully!")
    print(f"Updated {updated_count} procedures")

    return updated_count


def main():
    parser = argparse.ArgumentParser(
        description='Update procedure database with batch analysis results'
    )
    parser.add_argument(
        '--batch',
        default='batch_analysis.csv',
        help='Batch analysis CSV file (default: batch_analysis.csv)'
    )
    parser.add_argument(
        '--database',
        default='procedure_database.csv',
        help='Procedure database CSV file (default: procedure_database.csv)'
    )

    args = parser.parse_args()

    # Resolve paths
    script_dir = Path(__file__).parent
    project_dir = script_dir.parent

    batch_file = project_dir / args.batch
    database_file = project_dir / args.database

    # Check files exist
    if not batch_file.exists():
        print(f"Error: Batch file not found: {batch_file}")
        return 1

    if not database_file.exists():
        print(f"Error: Database file not found: {database_file}")
        return 1

    # Update database
    try:
        update_database(batch_file, database_file)
        return 0
    except Exception as e:
        print(f"Error updating database: {e}")
        return 1


if __name__ == '__main__':
    exit(main())
