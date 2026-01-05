import os
import sys
import argparse
from array import array


def unpack_tiles(data, addr, output_dir):
    """Decompress tile data from ROM using LZSS-like algorithm"""
    arr = data[addr:]
    res = array('B')

    idx = 2
    idx_res = 0
    size = arr[0] * 0x100 + arr[1]
    print(f'Address: 0x{addr:06X}, compressed size: 0x{size:04X} ({size} bytes)')

    while idx <= size and idx <= len(arr):
        byte_read = arr[idx]
        if byte_read >= 0x80:
            # LZSS backreference
            tmp = byte_read
            cnt = ((byte_read >> 2) & 0x1F) + 1
            tmp = (tmp << 8) & 0xFFFF
            idx += 1
            s = arr[idx]
            tmp += s
            tmp = (tmp & 0x3FF) + 1
            idx_window = idx_res - tmp
            for _ in range(cnt + 1):
                s = res[idx_window]
                idx_window += 1
                res.append(s)
                idx_res += 1
        else:
            if (byte_read & (1 << 5)) != 0:
                if (byte_read & (1 << 6)) != 0:
                    # RLE pairs (alternating)
                    cnt = (byte_read & 0x1F) + 1
                    idx += 1
                    z = arr[idx]
                    for _ in range(cnt + 1):
                        res.append(z)
                        idx += 1
                        s = arr[idx]
                        res.append(s)
                        idx_res += 2
                else:
                    # RLE single byte
                    cnt = (byte_read & 0x1F) + 1
                    idx += 1
                    s = arr[idx]
                    for _ in range(cnt + 1):
                        res.append(s)
                        idx_res += 1
            else:
                if (byte_read & (1 << 6)) != 0:
                    # RLE pairs (2-byte pattern)
                    cnt = (byte_read & 0x1F) + 1
                    s1 = arr[idx + 1]
                    s2 = arr[idx + 2]
                    idx += 2
                    for _ in range(cnt + 1):
                        res.append(s1)
                        res.append(s2)
                        idx_res += 2
                else:
                    # Literal data
                    cnt = (byte_read & 0x1F)
                    for _ in range(cnt + 1):
                        idx += 1
                        s = arr[idx]
                        res.append(s)
                        idx_res += 1

        idx += 1

    # Write decompressed data
    output_file = os.path.join(output_dir, f'tiles_{addr:06X}.bin')
    with open(output_file, 'wb') as binary_file:
        res.tofile(binary_file)

    print(f'  Decompressed size: 0x{len(res):04X} ({len(res)} bytes) -> {output_file}')
    return len(res)


def main():
    parser = argparse.ArgumentParser(description='Extract and decompress tile data from Alien Soldier ROM')
    parser.add_argument('-f', '--rom-file', required=True,
                        help='Original ROM file')
    parser.add_argument('-o', '--output', default='data',
                        help='Output directory for extracted tiles (default: data)')
    parser.add_argument('-a', '--addrs', default='data/tiles_addrs.txt',
                        help='File containing tile addresses (default: data/tiles_addrs.txt)')

    args = parser.parse_args()

    # Check if ROM file exists
    if not os.path.exists(args.rom_file):
        print(f'Error: Original ROM file "{args.rom_file}" not found!')
        print('Please place the original ROM in the project directory.')
        return 1

    # Check if addresses file exists
    if not os.path.exists(args.addrs):
        print(f'Error: Tile addresses file "{args.addrs}" not found!')
        return 1

    # Create output directory if needed
    os.makedirs(args.output, exist_ok=True)

    # Load ROM data
    print(f'Loading ROM: {args.rom_file}')
    data = array('B')
    with open(args.rom_file, 'rb') as rom:
        raw_data = rom.read()
        data.frombytes(raw_data)

    print(f'ROM size: 0x{len(data):X} ({len(data)} bytes)')

    # Load tile addresses
    print(f'Loading addresses from: {args.addrs}')
    with open(args.addrs, 'r') as f:
        tiles_addrs = f.readlines()
        tiles_addrs = [int(hex_string.strip(), 16) for hex_string in tiles_addrs if hex_string.strip()]

    print(f'Found {len(tiles_addrs)} tile addresses to extract\n')

    # Extract all tiles
    success_count = 0
    fail_count = 0

    for addr in tiles_addrs:
        try:
            unpack_tiles(data, addr, args.output)
            success_count += 1
        except Exception as e:
            print(f'Error at address 0x{addr:06X}: {str(e)}')
            fail_count += 1

    print(f'\nExtraction complete: {success_count} successful, {fail_count} failed')

    return 1 if fail_count > 0 else 0


if __name__ == '__main__':
    sys.exit(main())
