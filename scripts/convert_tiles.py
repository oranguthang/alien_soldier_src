#!/usr/bin/env python3
"""
Convert tile data blocks to binclude directives.
Handles both inline dc.b data and existing data_byte_*.bin files.
"""

import re
import shutil
from pathlib import Path


def normalize_addr(addr_str):
    """Normalize address - remove leading zeros."""
    return addr_str.lstrip('0').upper()


def parse_dc_value(value_str, dc_type):
    """Parse a single dc value and return bytes."""
    value_str = value_str.strip()
    if not value_str:
        return None

    # String literal
    if value_str.startswith(("'", '"')):
        text = value_str[1:-1]
        return text.encode('latin1')

    # Hex: $XXXX (check BEFORE label detection!)
    if value_str.startswith('$'):
        try:
            num = int(value_str[1:], 16)
        except ValueError:
            return None
    elif value_str.startswith('0x') or value_str.startswith('0X'):
        try:
            num = int(value_str, 16)
        except ValueError:
            return None
    elif value_str.startswith('%'):
        try:
            num = int(value_str[1:], 2)
        except ValueError:
            return None
    elif value_str.lstrip('-').isdigit():
        num = int(value_str)
    else:
        return None

    if dc_type == 'dc.b':
        if num < 0:
            num = (256 + num) & 0xFF
        return bytes([num & 0xFF])
    elif dc_type == 'dc.w':
        if num < 0:
            num = (65536 + num) & 0xFFFF
        return num.to_bytes(2, 'big', signed=False)
    elif dc_type == 'dc.l':
        if num < 0:
            num = (4294967296 + num) & 0xFFFFFFFF
        return num.to_bytes(4, 'big', signed=False)

    return None


def parse_dc_line(line):
    """Parse dc.b/dc.w/dc.l line and return binary data."""
    match = re.match(r'^[^;]*?(dc\.[bwl])\s+(.+?)(?:\s*;.*)?$', line, re.IGNORECASE)
    if not match:
        return None

    dc_type = match.group(1).lower()
    values_str = match.group(2)

    values = []
    current = ""
    in_quote = False
    quote_char = None

    for char in values_str + ',':
        if char in ('"', "'") and not in_quote:
            in_quote = True
            quote_char = char
            current += char
        elif char == quote_char and in_quote:
            in_quote = False
            quote_char = None
            current += char
        elif char == ',' and not in_quote:
            if current.strip():
                values.append(current.strip())
            current = ""
        else:
            current += char

    result = bytearray()
    for val in values:
        data = parse_dc_value(val, dc_type)
        if data is None:
            return None
        result.extend(data)

    return bytes(result) if result else None


def main():
    project_dir = Path(__file__).parent.parent
    asm_file = project_dir / 'alien_soldier_j.s'
    data_dir = project_dir / 'data'
    addrs_file = data_dir / 'tiles_addrs.txt'

    # Read addresses
    with open(addrs_file, 'r') as f:
        addresses = [line.strip() for line in f if line.strip()]

    print(f"Processing {len(addresses)} tile addresses...")

    # Read source
    with open(asm_file, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()

    # Build label -> line mapping
    label_pattern = re.compile(r'^(byte_[0-9A-Fa-f]+):')
    dc_pattern = re.compile(r'^\s*dc\.[bwl]\s+', re.IGNORECASE)
    binclude_pattern = re.compile(r'binclude\s+"([^"]+)"')

    changes = []

    for addr in addresses:
        norm_addr = normalize_addr(addr)
        label = f"byte_{norm_addr}"

        # Find label in source
        label_line_idx = None
        for i, line in enumerate(lines):
            if line.startswith(f"{label}:"):
                label_line_idx = i
                break

        if label_line_idx is None:
            print(f"  [SKIP] {label} not found in source")
            continue

        line = lines[label_line_idx]

        # Check if already binclude
        binclude_match = binclude_pattern.search(line)
        if binclude_match:
            old_file = binclude_match.group(1)
            new_file = f"data/tiles_{addr}.bin"

            if old_file == new_file:
                print(f"  [OK] {label} already uses tiles_{addr}.bin")
                continue

            # Rename file and update reference
            old_path = project_dir / old_file
            new_path = project_dir / new_file

            if old_path.exists():
                shutil.copy2(old_path, new_path)
                print(f"  [COPY] {old_path.name} -> {new_path.name}")

            # Update line
            new_line = line.replace(old_file, new_file)
            changes.append((label_line_idx, new_line, f"rename {label}"))
            print(f"  [RENAME] {label}: {old_file} -> {new_file}")
        else:
            # Inline data - need to extract
            # Find all dc lines for this label
            data = bytearray()
            end_line_idx = label_line_idx

            # Check if label line has data
            if '\tdc.' in line or ' dc.' in line:
                parts = line.split(':', 1)
                if len(parts) > 1:
                    line_data = parse_dc_line(parts[1])
                    if line_data:
                        data.extend(line_data)

            # Continue reading dc lines
            for i in range(label_line_idx + 1, len(lines)):
                l = lines[i]
                if not l.strip() or l.strip().startswith(';'):
                    continue
                if dc_pattern.match(l):
                    line_data = parse_dc_line(l)
                    if line_data:
                        data.extend(line_data)
                        end_line_idx = i
                    else:
                        break  # Label reference
                else:
                    break  # Non-dc line

            if len(data) == 0:
                print(f"  [SKIP] {label} has no parseable data")
                continue

            # Save binary
            bin_file = data_dir / f"tiles_{addr}.bin"
            with open(bin_file, 'wb') as f:
                f.write(data)

            # Create replacement
            label_part = f"{label}:"
            new_content = f"{label_part}\tbinclude\t\"data/tiles_{addr}.bin\"\n"
            new_content += f"{label}_End:\n"

            changes.append((label_line_idx, end_line_idx + 1, new_content,
                          f"extract {label} ({len(data)} bytes)"))
            print(f"  [EXTRACT] {label}: {len(data)} bytes -> tiles_{addr}.bin")

    if not changes:
        print("\nNo changes needed")
        return

    print(f"\nApplying {len(changes)} changes...")

    # Sort by line number descending (to not mess up indices)
    # Handle both rename (single line) and extract (range) changes
    sorted_changes = []
    for c in changes:
        if len(c) == 3:  # Rename: (idx, new_line, desc)
            sorted_changes.append((c[0], c[0] + 1, c[1], c[2]))
        else:  # Extract: (start, end, content, desc)
            sorted_changes.append(c)

    sorted_changes.sort(key=lambda x: x[0], reverse=True)

    for start_idx, end_idx, new_content, desc in sorted_changes:
        lines[start_idx:end_idx] = [new_content]

    # Write back
    print(f"Writing modified source...")
    with open(asm_file, 'w', encoding='utf-8', newline='\n') as f:
        f.writelines(lines)

    print(f"\n[OK] Done! Applied {len(changes)} changes")


if __name__ == '__main__':
    main()
