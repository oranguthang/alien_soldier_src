import os
import sys
import argparse
import glob


def remove_files(patterns, verbose=True):
    """Remove files matching the given patterns"""
    removed_count = 0
    for pattern in patterns:
        for file_path in glob.glob(pattern):
            try:
                if os.path.isfile(file_path):
                    os.remove(file_path)
                    if verbose:
                        print(f'Removed: {file_path}')
                    removed_count += 1
            except Exception as e:
                print(f'Error removing {file_path}: {e}', file=sys.stderr)
    return removed_count


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Clean build artifacts')
    parser.add_argument('files', nargs='+', help='File patterns to remove')
    parser.add_argument('-q', '--quiet', action='store_true', help='Quiet mode')

    args = parser.parse_args()

    count = remove_files(args.files, verbose=not args.quiet)

    if not args.quiet:
        print(f'Removed {count} file(s)')
