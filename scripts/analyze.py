#!/usr/bin/env python3
"""
ROM Procedure Analyzer (Parallel)

Analyzes which procedures affect visual output by:
1. Disabling each sub_XXXXX procedure (adding RTS at start)
2. Building modified ROM
3. Comparing screenshots with reference during TAS playback
4. Recording first frame where difference occurs

Supports parallel execution with multiple workers.
"""

import os
import sys
import re
import subprocess
import shutil
import argparse
import csv
import tempfile
from pathlib import Path
from concurrent.futures import ProcessPoolExecutor, as_completed
from multiprocessing import Manager
import time


def find_procedures(source_file):
    """Find all sub_XXXXX procedures in the source file."""
    procedures = []
    pattern = re.compile(r'^(sub_[0-9A-Fa-f]+):')

    with open(source_file, 'r', encoding='utf-8') as f:
        for line_num, line in enumerate(f, 1):
            match = pattern.match(line)
            if match:
                procedures.append({
                    'name': match.group(1),
                    'line': line_num
                })

    return procedures


def disable_procedure(source_file, proc_name):
    """Add 'rts' after procedure label to disable it."""
    pattern = re.compile(rf'^({re.escape(proc_name)}:.*?)$', re.MULTILINE)

    with open(source_file, 'r', encoding='utf-8') as f:
        content = f.read()

    def replacer(match):
        return match.group(1) + '\n\trts\t; DISABLED BY ANALYZER'

    new_content = pattern.sub(replacer, content, count=1)

    with open(source_file, 'w', encoding='utf-8') as f:
        f.write(new_content)


def setup_worker_dir(project_dir, proc_name, temp_base):
    """Create isolated worker directory with project copy."""
    worker_dir = os.path.join(temp_base, proc_name)

    # Clean and recreate
    if os.path.exists(worker_dir):
        shutil.rmtree(worker_dir)
    os.makedirs(worker_dir)

    # Copy essential files
    src_file = os.path.join(project_dir, 'alien_soldier_j.s')
    shutil.copy(src_file, worker_dir)

    # Copy Makefile
    shutil.copy(os.path.join(project_dir, 'Makefile'), worker_dir)

    # Copy directories (symlinks require admin on Windows)
    for dirname in ['bin', 'data', 'src', 'scripts']:
        src_path = os.path.join(project_dir, dirname)
        dst_path = os.path.join(worker_dir, dirname)
        if os.path.exists(src_path) and not os.path.exists(dst_path):
            shutil.copytree(src_path, dst_path)

    return worker_dir


def build_rom(worker_dir):
    """Build ROM using make."""
    result = subprocess.run(
        ['make', 'build'],
        cwd=worker_dir,
        capture_output=True,
        text=True
    )
    return result.returncode == 0, result.stderr


def run_comparison(gens_exe, rom_file, movie_file, reference_dir, diffs_dir,
                   proc_name, interval=20, max_frames=90000, max_diffs=1):
    """Run emulator in comparison mode."""
    proc_diffs_dir = os.path.join(diffs_dir, proc_name)
    if os.path.exists(proc_diffs_dir):
        for f in os.listdir(proc_diffs_dir):
            os.remove(os.path.join(proc_diffs_dir, f))
    else:
        os.makedirs(proc_diffs_dir)

    # Emulator must run from its own directory to find DLLs
    gens_dir = os.path.dirname(gens_exe)

    cmd = [
        gens_exe,
        '-rom', rom_file,
        '-play', movie_file,
        '-screenshot-interval', str(interval),
        '-reference-dir', reference_dir,
        '-screenshot-dir', proc_diffs_dir,
        '-max-frames', str(max_frames),
        '-max-diffs', str(max_diffs),
        '-turbo',
        '-frameskip', '0',
        '-nosound'
    ]

    subprocess.run(cmd, capture_output=True, cwd=gens_dir)

    diffs = sorted([f for f in os.listdir(proc_diffs_dir) if f.endswith('.png')])

    if diffs:
        first_diff = int(diffs[0].replace('.png', ''))
        return first_diff, len(diffs)
    else:
        os.rmdir(proc_diffs_dir)

    return None, 0


def analyze_single_procedure(args_tuple):
    """Analyze a single procedure (worker function)."""
    (proc, project_dir, temp_base, gens_exe, movie_file,
     reference_dir, diffs_dir, interval, max_frames, max_diffs) = args_tuple

    proc_name = proc['name']

    try:
        # Setup worker directory (unique per procedure)
        worker_dir = setup_worker_dir(project_dir, proc_name, temp_base)
        source_file = os.path.join(worker_dir, 'alien_soldier_j.s')
        rom_file = os.path.join(worker_dir, 'asbuilt.bin')

        # Disable procedure
        disable_procedure(source_file, proc_name)

        # Build ROM
        success, error = build_rom(worker_dir)
        if not success:
            return {
                'procedure': proc_name,
                'line': proc['line'],
                'first_diff_frame': 'BUILD_ERROR',
                'diff_count': 0,
                'status': 'error'
            }

        # Run comparison
        first_diff, diff_count = run_comparison(
            gens_exe, rom_file, movie_file, reference_dir, diffs_dir,
            proc_name, interval, max_frames, max_diffs
        )

        if first_diff is not None:
            status = 'visual'
        else:
            status = 'no_change'

        return {
            'procedure': proc_name,
            'line': proc['line'],
            'first_diff_frame': first_diff if first_diff else '',
            'diff_count': diff_count,
            'status': status
        }

    except Exception as e:
        return {
            'procedure': proc_name,
            'line': proc['line'],
            'first_diff_frame': f'ERROR: {str(e)}',
            'diff_count': 0,
            'status': 'error'
        }


def analyze_procedures(args):
    """Main analysis loop with parallel execution."""
    project_dir = str(Path(args.project_dir).resolve())
    source_file = os.path.join(project_dir, args.source)
    movie_file = os.path.join(project_dir, args.movie)
    reference_dir = os.path.join(project_dir, args.reference)
    diffs_dir = os.path.join(project_dir, args.diffs)
    gens_exe = os.path.join(project_dir, args.gens)
    results_file = os.path.join(project_dir, args.output)

    # Verify paths
    if not os.path.exists(source_file):
        print(f"Error: Source file not found: {source_file}")
        return 1
    if not os.path.exists(reference_dir):
        print(f"Error: Reference directory not found: {reference_dir}")
        return 1
    if not os.path.exists(gens_exe):
        print(f"Error: Emulator not found: {gens_exe}")
        return 1
    if not os.path.exists(movie_file):
        print(f"Error: Movie file not found: {movie_file}")
        return 1

    # Find procedures
    print("Finding procedures...")
    procedures = find_procedures(source_file)
    print(f"Found {len(procedures)} procedures")

    if args.limit:
        procedures = procedures[:args.limit]
        print(f"Limited to first {args.limit} procedures")

    if args.start_from:
        start_idx = 0
        for i, proc in enumerate(procedures):
            if proc['name'] == args.start_from:
                start_idx = i
                break
        procedures = procedures[start_idx:]
        print(f"Starting from {args.start_from} ({len(procedures)} remaining)")

    # Create directories
    os.makedirs(diffs_dir, exist_ok=True)

    # Create temp directory for workers
    temp_base = os.path.join(project_dir, 'tmp', 'analyze_workers')
    if os.path.exists(temp_base):
        shutil.rmtree(temp_base)
    os.makedirs(temp_base)

    print(f"\nAnalyzing {len(procedures)} procedures with {args.workers} workers...")
    print("=" * 60)

    # Prepare tasks
    tasks = []
    for proc in procedures:
        tasks.append((
            proc, project_dir, temp_base, gens_exe, movie_file,
            reference_dir, diffs_dir, args.interval, args.max_frames, args.max_diffs
        ))

    # Run in parallel
    results = []
    completed = 0
    start_time = time.time()

    with ProcessPoolExecutor(max_workers=args.workers) as executor:
        futures = {executor.submit(analyze_single_procedure, task): task[0] for task in tasks}

        for future in as_completed(futures):
            proc = futures[future]
            result = future.result()
            results.append(result)
            completed += 1

            # Progress output
            status_char = 'V' if result['status'] == 'visual' else ('E' if result['status'] == 'error' else '.')
            elapsed = time.time() - start_time
            rate = completed / elapsed if elapsed > 0 else 0
            eta = (len(procedures) - completed) / rate if rate > 0 else 0

            print(f"\r[{completed}/{len(procedures)}] {status_char} {result['procedure']:<20} "
                  f"({rate:.1f}/s, ETA: {eta/60:.0f}m)      ", end='', flush=True)

    print("\n" + "=" * 60)

    # Cleanup temp directories
    print("Cleaning up temporary files...")
    shutil.rmtree(temp_base, ignore_errors=True)

    # Sort results by line number
    results.sort(key=lambda x: x['line'] if isinstance(x['line'], int) else 0)

    # Save results
    print(f"Saving results to {results_file}...")
    with open(results_file, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=['procedure', 'line', 'first_diff_frame', 'diff_count', 'status'])
        writer.writeheader()
        writer.writerows(results)

    # Summary
    visual_count = sum(1 for r in results if r['status'] == 'visual')
    no_change_count = sum(1 for r in results if r['status'] == 'no_change')
    error_count = sum(1 for r in results if r['status'] == 'error')
    elapsed = time.time() - start_time

    print(f"\nSummary:")
    print(f"  Visual impact: {visual_count}")
    print(f"  No change:     {no_change_count}")
    print(f"  Errors:        {error_count}")
    print(f"  Total:         {len(results)}")
    print(f"  Time:          {elapsed/60:.1f} minutes")

    return 0


def main():
    parser = argparse.ArgumentParser(description='Analyze ROM procedures for visual impact')
    parser.add_argument('--project-dir', default='.', help='Project directory')
    parser.add_argument('--source', default='alien_soldier_j.s', help='Source file')
    parser.add_argument('--rom', default='asbuilt.bin', help='Built ROM file')
    parser.add_argument('--movie', default='dammit,truncated-aliensoldier.gmv', help='TAS movie file')
    parser.add_argument('--reference', default='reference', help='Reference screenshots directory')
    parser.add_argument('--diffs', default='diffs', help='Diffs output directory')
    parser.add_argument('--gens', default='gens-rerecording/Gens-rr/Output/Gens.exe', help='Gens emulator path')
    parser.add_argument('--output', default='analysis_results.csv', help='Output CSV file')
    parser.add_argument('--interval', type=int, default=20, help='Screenshot interval')
    parser.add_argument('--max-frames', type=int, default=90000, help='Max frames to analyze')
    parser.add_argument('--max-diffs', type=int, default=1, help='Stop after N diffs per procedure')
    parser.add_argument('--limit', type=int, help='Limit number of procedures to analyze')
    parser.add_argument('--start-from', help='Start from specific procedure name')
    parser.add_argument('--workers', '-j', type=int, default=4, help='Number of parallel workers')

    args = parser.parse_args()
    return analyze_procedures(args)


if __name__ == '__main__':
    sys.exit(main())
