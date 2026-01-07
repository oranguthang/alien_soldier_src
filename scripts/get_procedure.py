#!/usr/bin/env python3
"""
Procedure Code Extractor

Extracts a specific procedure's code from the assembly file for analysis.
Shows the procedure definition, code, and end marker with context.
"""

import re
import argparse
from pathlib import Path


def find_procedure(asm_file, proc_name):
    """Find and extract procedure code from assembly file."""
    with open(asm_file, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()

    # Find procedure start
    proc_pattern = re.compile(rf'^{re.escape(proc_name)}:\s*')
    start_line = None

    for i, line in enumerate(lines):
        if proc_pattern.match(line):
            start_line = i
            break

    if start_line is None:
        return None, None, None

    # Find procedure end (look for "; End of function" marker)
    end_line = None
    end_pattern = re.compile(r'^; End of function\s+' + re.escape(proc_name))

    for i in range(start_line + 1, min(start_line + 500, len(lines))):
        if end_pattern.match(lines[i]):
            end_line = i
            break

    # If no end marker found, look for next procedure or blank lines
    if end_line is None:
        for i in range(start_line + 1, min(start_line + 200, len(lines))):
            # Stop at next procedure or significant gap
            if re.match(r'^(sub_|loc_|[a-zA-Z_][a-zA-Z0-9_]*):($|\s)', lines[i]):
                # Check if it's a local label (loc_) or new procedure (sub_)
                if lines[i].startswith('sub_') or not lines[i].startswith('loc_'):
                    end_line = i - 1
                    break

    if end_line is None:
        end_line = min(start_line + 100, len(lines) - 1)

    # Extract procedure with some context
    context_before = 5
    context_after = 2

    extract_start = max(0, start_line - context_before)
    extract_end = min(len(lines), end_line + context_after)

    return lines[extract_start:extract_end], start_line - extract_start, extract_end - extract_start


def format_output(lines, proc_line, end_offset, show_line_numbers=True):
    """Format extracted code for display."""
    output = []

    for i, line in enumerate(lines):
        line = line.rstrip()

        if show_line_numbers:
            line_marker = f"{i + 1:4d} "
        else:
            line_marker = ""

        # Highlight procedure start
        if i == proc_line:
            output.append(f"{line_marker}>>> {line}")
        else:
            output.append(f"{line_marker}    {line}")

    return '\n'.join(output)


def main():
    parser = argparse.ArgumentParser(description='Extract procedure code from assembly file')
    parser.add_argument('procedure', help='Procedure name (e.g., sub_2016)')
    parser.add_argument('--source', default='alien_soldier_j.s', help='Assembly source file')
    parser.add_argument('--project-dir', default='.', help='Project directory')
    parser.add_argument('--no-line-numbers', action='store_true', help='Hide line numbers')

    args = parser.parse_args()

    project_dir = Path(args.project_dir).resolve()
    asm_file = project_dir / args.source

    if not asm_file.exists():
        print(f"Error: Assembly file not found: {asm_file}")
        return 1

    print(f"Extracting {args.procedure} from {asm_file}...")
    print("=" * 80)

    lines, proc_line, end_offset = find_procedure(asm_file, args.procedure)

    if lines is None:
        print(f"Error: Procedure {args.procedure} not found")
        return 1

    output = format_output(lines, proc_line, end_offset, not args.no_line_numbers)
    print(output)

    print("=" * 80)
    print(f"Procedure {args.procedure} extracted ({len(lines)} lines)")

    return 0


if __name__ == '__main__':
    import sys
    sys.exit(main())
