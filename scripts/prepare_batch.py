#!/usr/bin/env python3
"""
Batch Preparation Script

Automatically prepares next batch of procedures for analysis:
- Extracts pending procedures from database
- Runs get_procedure.py for each one
- Saves output to file for analysis
"""

import csv
import subprocess
import argparse
from pathlib import Path


def load_pending_procedures(csv_file, batch_size=40):
    """Load pending procedures from CSV database."""
    procedures = []

    with open(csv_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            # Only process procedures that are pending
            if row['status'] == 'pending':
                procedures.append({
                    'old_name': row['old_name'],
                    'scene': row['scene'],
                    'frame': row['frame']
                })

                if len(procedures) >= batch_size:
                    break

    return procedures


def extract_procedures(procedures, asm_file, output_file):
    """Extract all procedures using get_procedure.py."""
    project_dir = Path(__file__).parent.parent
    get_proc_script = project_dir / 'scripts' / 'get_procedure.py'

    with open(output_file, 'w', encoding='utf-8') as out:
        out.write(f"=" * 80 + "\n")
        out.write(f"BATCH EXTRACTION - {len(procedures)} procedures\n")
        out.write(f"=" * 80 + "\n\n")

        for i, proc in enumerate(procedures, 1):
            proc_name = proc['old_name']
            print(f"[{i}/{len(procedures)}] Extracting {proc_name}...")

            out.write("=" * 80 + "\n")
            out.write(f"Procedure {i}/{len(procedures)}: {proc_name}\n")
            out.write(f"Scene: {proc['scene']}, Frame: {proc['frame']}\n")
            out.write("=" * 80 + "\n\n")

            try:
                result = subprocess.run(
                    ['python', str(get_proc_script), proc_name],
                    cwd=project_dir,
                    capture_output=True,
                    text=True,
                    timeout=30
                )

                out.write(result.stdout)
                if result.stderr:
                    out.write("\nSTDERR:\n")
                    out.write(result.stderr)
                out.write("\n\n")

            except subprocess.TimeoutExpired:
                out.write(f"ERROR: Timeout extracting {proc_name}\n\n")
            except Exception as e:
                out.write(f"ERROR: {e}\n\n")

    print(f"\nExtraction complete! Output saved to: {output_file}")
    print(f"Extracted {len(procedures)} procedures")


def main():
    parser = argparse.ArgumentParser(description='Prepare next batch of procedures')
    parser.add_argument('--database', default='procedure_database.csv',
                       help='Procedure database CSV')
    parser.add_argument('--source', default='alien_soldier_j.s',
                       help='Assembly source file')
    parser.add_argument('--batch-size', type=int, default=40,
                       help='Number of procedures to extract')
    parser.add_argument('--output', default='batch_extract.txt',
                       help='Output file for extracted procedures')
    parser.add_argument('--project-dir', default='.',
                       help='Project directory')

    args = parser.parse_args()

    project_dir = Path(args.project_dir).resolve()
    db_file = project_dir / args.database
    asm_file = project_dir / args.source
    output_file = project_dir / args.output

    if not db_file.exists():
        print(f"Error: Database file not found: {db_file}")
        return 1

    if not asm_file.exists():
        print(f"Error: Assembly file not found: {asm_file}")
        return 1

    print(f"Loading procedures from {db_file}...")
    procedures = load_pending_procedures(db_file, args.batch_size)

    if not procedures:
        print("No pending procedures found in database")
        return 0

    print(f"Found {len(procedures)} pending procedures")
    print(f"Scene: {procedures[0]['scene']}")
    print(f"\nExtracting to {output_file}...")

    extract_procedures(procedures, asm_file, output_file)

    print("\nNext steps:")
    print(f"  1. Review extracted code in: {output_file}")
    print(f"  2. Analyze procedures and update database")
    print(f"  3. Run rename script")
    print(f"  4. Build and verify ROM")
    print(f"  5. Commit changes")

    return 0


if __name__ == '__main__':
    import sys
    sys.exit(main())
