#!/usr/bin/env python3
"""
Extract Visual Procedures Database

Parses analysis_report.txt and extracts all procedures with 'visual effect' status
into a CSV database for documentation and renaming.
"""

import csv
import re
import argparse
from pathlib import Path


def parse_analysis_report(report_file):
    """Parse analysis report and extract visual_change procedures."""
    procedures = []
    current_scene = None

    with open(report_file, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()

            # Detect scene headers
            if line.startswith('--- ') and line.endswith(' ---'):
                current_scene = line[4:-4].strip()
                continue

            # Parse procedure lines: "sub_XXXXX: visual effect (frame YYYY)"
            if ': visual effect (frame ' in line:
                match = re.match(r'^(sub_[0-9A-Fa-f]+):\s*visual effect\s*\(frame\s+(\d+)\)', line)
                if match:
                    proc_name = match.group(1)
                    frame = int(match.group(2))

                    procedures.append({
                        'old_name': proc_name,
                        'scene': current_scene if current_scene else 'Unknown',
                        'frame': frame,
                        'new_name': '',
                        'description': '',
                        'category': '',
                        'status': 'pending'
                    })

    return procedures


def write_database(procedures, output_file):
    """Write procedures to CSV database."""
    fieldnames = ['old_name', 'scene', 'frame', 'new_name', 'description', 'category', 'status']

    with open(output_file, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(procedures)


def main():
    parser = argparse.ArgumentParser(description='Extract visual procedures from analysis report')
    parser.add_argument('--report', default='analysis_report.txt', help='Analysis report file')
    parser.add_argument('--output', default='procedure_database.csv', help='Output CSV database')
    parser.add_argument('--project-dir', default='.', help='Project directory')

    args = parser.parse_args()

    project_dir = Path(args.project_dir).resolve()
    report_file = project_dir / args.report
    output_file = project_dir / args.output

    if not report_file.exists():
        print(f"Error: Report file not found: {report_file}")
        return 1

    print(f"Parsing {report_file}...")
    procedures = parse_analysis_report(report_file)

    print(f"Found {len(procedures)} procedures with visual effects")

    # Statistics by scene
    scene_counts = {}
    for proc in procedures:
        scene = proc['scene']
        scene_counts[scene] = scene_counts.get(scene, 0) + 1

    print("\nProcedures by scene:")
    for scene, count in sorted(scene_counts.items(), key=lambda x: -x[1])[:10]:
        print(f"  {scene}: {count}")
    if len(scene_counts) > 10:
        print(f"  ... and {len(scene_counts) - 10} more scenes")

    print(f"\nWriting database to {output_file}...")
    write_database(procedures, output_file)

    print(f"Done! Database created with {len(procedures)} procedures")
    print(f"\nNext steps:")
    print(f"  1. Review {output_file}")
    print(f"  2. Use get_procedure.py to extract procedure code")
    print(f"  3. Analyze procedures and fill in new_name, description, category")
    print(f"  4. Use rename_procedures.py to apply renames")

    return 0


if __name__ == '__main__':
    import sys
    sys.exit(main())
