#!/usr/bin/env python3
"""
Analysis Report Generator

Generates a report mapping procedures to their visual functionality by:
1. Parsing TAS description file with frame intervals and scene names
2. Analyzing diff screenshots to detect change types (black screen, frozen, etc.)
3. Mapping first diff frame to scene descriptions
"""

import os
import sys
import csv
import argparse
from pathlib import Path
from collections import defaultdict

# Optional: PIL for image analysis
try:
    from PIL import Image
    HAS_PIL = True
except ImportError:
    HAS_PIL = False


def parse_tas_description(filepath):
    """Parse TAS description file into list of (start, end, description) tuples."""
    scenes = []
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('Frames'):
                continue

            # Format: "start-end, description"
            parts = line.split(',', 1)
            if len(parts) != 2:
                continue

            frame_range = parts[0].strip()
            description = parts[1].strip()

            # Parse frame range
            if '-' in frame_range:
                start, end = frame_range.split('-')
                try:
                    scenes.append((int(start), int(end), description))
                except ValueError:
                    continue

    return scenes


def get_scene_for_frame(frame, scenes):
    """Find scene description for a given frame number."""
    for start, end, description in scenes:
        if start <= frame <= end:
            return description
    return None


def analyze_image(filepath):
    """Analyze image to detect type: black, red, or normal."""
    if not HAS_PIL:
        return 'unknown'

    try:
        img = Image.open(filepath).convert('RGB')
        pixels = list(img.getdata())
        total = len(pixels)

        if total == 0:
            return 'unknown'

        # Count pixel types
        black_count = 0
        red_count = 0

        for r, g, b in pixels:
            # Black: very dark pixels
            if r < 20 and g < 20 and b < 20:
                black_count += 1
            # Red: high red, low green/blue
            elif r > 150 and g < 50 and b < 50:
                red_count += 1

        black_ratio = black_count / total
        red_ratio = red_count / total

        if black_ratio > 0.95:
            return 'black_screen'
        elif red_ratio > 0.5:
            return 'red_screen'
        else:
            return 'normal'

    except Exception:
        return 'unknown'


def compare_images(path1, path2):
    """Check if two images are identical."""
    if not HAS_PIL:
        return False

    try:
        img1 = Image.open(path1)
        img2 = Image.open(path2)

        if img1.size != img2.size:
            return False

        # Compare pixel by pixel (sample for speed)
        pixels1 = list(img1.getdata())
        pixels2 = list(img2.getdata())

        return pixels1 == pixels2

    except Exception:
        return False


def analyze_procedure_diffs(proc_dir):
    """Analyze diff screenshots for a procedure to determine change type."""
    if not os.path.isdir(proc_dir):
        return 'no_diffs', []

    # Get all non-diff screenshots (the actual frames, not the diff overlays)
    screenshots = sorted([f for f in os.listdir(proc_dir)
                         if f.endswith('.png') and '_diff' not in f])

    if not screenshots:
        return 'no_diffs', []

    # Get frame numbers
    frames = []
    for s in screenshots:
        try:
            frame = int(s.replace('.png', ''))
            frames.append(frame)
        except ValueError:
            continue

    if not frames:
        return 'no_diffs', []

    # Analyze first screenshot
    first_screenshot = os.path.join(proc_dir, screenshots[0])
    first_type = analyze_image(first_screenshot)

    # Check for frozen game (consecutive identical screenshots)
    is_frozen = False
    if len(screenshots) >= 3:
        # Compare last few screenshots
        identical_count = 0
        for i in range(len(screenshots) - 1):
            path1 = os.path.join(proc_dir, screenshots[i])
            path2 = os.path.join(proc_dir, screenshots[i + 1])
            if compare_images(path1, path2):
                identical_count += 1

        # If most consecutive pairs are identical, game is frozen
        if identical_count >= len(screenshots) - 2:
            is_frozen = True

    # Determine change type
    if first_type == 'black_screen':
        change_type = 'black_screen'
    elif first_type == 'red_screen':
        change_type = 'red_screen'
    elif is_frozen:
        change_type = 'frozen'
    else:
        change_type = 'visual_change'

    return change_type, frames


def generate_report(args):
    """Generate the analysis report."""
    project_dir = Path(args.project_dir).resolve()
    tas_file = project_dir / args.tas_description
    results_file = project_dir / args.results
    diffs_dir = project_dir / args.diffs
    output_file = project_dir / args.output

    # Check files exist
    if not tas_file.exists():
        print(f"Error: TAS description not found: {tas_file}")
        return 1

    if not results_file.exists():
        print(f"Error: Analysis results not found: {results_file}")
        return 1

    if not diffs_dir.exists():
        print(f"Error: Diffs directory not found: {diffs_dir}")
        return 1

    # Parse TAS description
    print("Parsing TAS description...")
    scenes = parse_tas_description(tas_file)
    print(f"  Found {len(scenes)} scenes")

    # Read analysis results
    print("Reading analysis results...")
    procedures = []
    with open(results_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            procedures.append(row)

    visual_procs = [p for p in procedures if p['status'] == 'visual']
    print(f"  Found {len(visual_procs)} procedures with visual impact")

    # Analyze each procedure
    print("Analyzing diff screenshots...")
    report_entries = []

    # Group by scene for better organization
    scene_procedures = defaultdict(list)
    unknown_procedures = []

    for i, proc in enumerate(visual_procs):
        proc_name = proc['procedure']
        first_frame = proc['first_diff_frame']

        if not first_frame or not first_frame.isdigit():
            continue

        first_frame = int(first_frame)

        # Analyze diffs
        proc_diff_dir = diffs_dir / proc_name
        change_type, frames = analyze_procedure_diffs(proc_diff_dir)

        # Get scene for first diff frame
        scene = get_scene_for_frame(first_frame, scenes)

        # Format change type description
        if change_type == 'black_screen':
            change_desc = "causes black screen"
        elif change_type == 'red_screen':
            change_desc = "causes red screen (crash)"
        elif change_type == 'frozen':
            change_desc = "causes game freeze"
        elif change_type == 'visual_change':
            change_desc = "visual effect"
        else:
            change_desc = "unknown effect"

        entry = {
            'procedure': proc_name,
            'first_frame': first_frame,
            'scene': scene,
            'change_type': change_type,
            'change_desc': change_desc,
            'frame_count': len(frames)
        }

        if scene:
            scene_procedures[scene].append(entry)
        else:
            unknown_procedures.append(entry)

        # Progress
        if (i + 1) % 100 == 0:
            print(f"  Processed {i + 1}/{len(visual_procs)}...")

    print(f"  Done analyzing {len(visual_procs)} procedures")

    # Generate report
    print(f"Writing report to {output_file}...")

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("=" * 80 + "\n")
        f.write("ALIEN SOLDIER PROCEDURE ANALYSIS REPORT\n")
        f.write("=" * 80 + "\n\n")

        f.write(f"Total procedures analyzed: {len(procedures)}\n")
        f.write(f"Procedures with visual impact: {len(visual_procs)}\n")
        f.write(f"Procedures with no change: {len([p for p in procedures if p['status'] == 'no_change'])}\n")
        f.write(f"Procedures with errors: {len([p for p in procedures if p['status'] == 'error'])}\n\n")

        # Statistics by change type
        change_stats = defaultdict(int)
        for scene_procs in scene_procedures.values():
            for p in scene_procs:
                change_stats[p['change_type']] += 1
        for p in unknown_procedures:
            change_stats[p['change_type']] += 1

        f.write("Change type statistics:\n")
        for ctype, count in sorted(change_stats.items(), key=lambda x: -x[1]):
            f.write(f"  {ctype}: {count}\n")
        f.write("\n")

        f.write("=" * 80 + "\n")
        f.write("PROCEDURES BY SCENE\n")
        f.write("=" * 80 + "\n\n")

        # Sort scenes by frame order
        scene_order = {scene[2]: scene[0] for scene in scenes}
        sorted_scenes = sorted(scene_procedures.keys(),
                              key=lambda s: scene_order.get(s, 999999))

        for scene in sorted_scenes:
            procs = scene_procedures[scene]
            f.write(f"\n--- {scene} ---\n\n")

            # Sort by first frame
            procs.sort(key=lambda p: p['first_frame'])

            for p in procs:
                f.write(f"{p['procedure']}: {p['change_desc']} (frame {p['first_frame']})\n")

        if unknown_procedures:
            f.write(f"\n--- Unknown scene ---\n\n")
            unknown_procedures.sort(key=lambda p: p['first_frame'])
            for p in unknown_procedures:
                f.write(f"{p['procedure']}: {p['change_desc']} (frame {p['first_frame']})\n")

        f.write("\n")
        f.write("=" * 80 + "\n")
        f.write("PROCEDURES SUMMARY (alphabetical)\n")
        f.write("=" * 80 + "\n\n")

        # Collect all entries
        all_entries = []
        for procs in scene_procedures.values():
            all_entries.extend(procs)
        all_entries.extend(unknown_procedures)

        # Sort alphabetically
        all_entries.sort(key=lambda p: p['procedure'])

        for p in all_entries:
            scene_str = p['scene'] if p['scene'] else "unknown"
            f.write(f"{p['procedure']}: {scene_str} - {p['change_desc']}\n")

    print("Report generated successfully!")

    # Print summary
    print(f"\nSummary:")
    print(f"  Scenes with visual procedures: {len(scene_procedures)}")
    print(f"  Unknown scene procedures: {len(unknown_procedures)}")
    for ctype, count in sorted(change_stats.items(), key=lambda x: -x[1]):
        print(f"  {ctype}: {count}")

    return 0


def main():
    parser = argparse.ArgumentParser(description='Generate analysis report')
    parser.add_argument('--project-dir', default='.', help='Project directory')
    parser.add_argument('--tas-description', default='tas_description.txt',
                       help='TAS description file')
    parser.add_argument('--results', default='analysis_results.csv',
                       help='Analysis results CSV')
    parser.add_argument('--diffs', default='diffs', help='Diffs directory')
    parser.add_argument('--output', default='analysis_report.txt',
                       help='Output report file')

    args = parser.parse_args()
    return generate_report(args)


if __name__ == '__main__':
    sys.exit(main())
