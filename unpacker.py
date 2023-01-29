import os

import argparse
from array import array

DATA_FOLDER = 'data'
DEFAULT_ROM_NAME = 'alien_soldier_j.bin'
ADDRS_FILE = 'tiles_addrs.txt'


def log_hex_data(data):
    print()
    idx = 0
    for rec in data:
        print(f'{rec:02X}', end=' ')
        idx += 1
        if idx == 8:
            print('  ', end='')
        if idx == 16:
            idx = 0
            print()


def unpack(data, addr):
    arr = data[addr:]
    res = []

    idx = 2
    idx_res = 0
    size = arr[0] * 0x100 + arr[1]
    print(f'Address: {addr:02X}, size: {size:02X}')

    while idx <= size and idx <= len(arr):
        byte_read = arr[idx]
        if byte_read >= 0x80:
            cnt = ((byte_read >> 2) & 0x1F) + 1
            idx += 1
            s = arr[idx]
            tmp = byte_read + s
            tmp = (tmp << 8) & 0xFFFF
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
                    cnt = (byte_read & 0x1F) + 1
                    idx += 1
                    s = arr[idx]
                    for _ in range(cnt + 1):
                        res.append(s)
                        idx_res += 1
            else:
                if (byte_read & (1 << 6)) != 0:
                    cnt = (byte_read & 0x1F) + 1
                    s1 = arr[idx + 1]
                    s2 = arr[idx + 2]
                    idx += 2
                    for _ in range(cnt + 1):
                        res.append(s1)
                        res.append(s2)
                        idx_res += 2
                else:
                    cnt = (byte_read & 0x1F)
                    for _ in range(cnt + 1):
                        idx += 1
                        s = arr[idx]
                        res.append(s)
                        idx_res += 1

        idx += 1
        # log_hex_data(res)

    with open(os.path.join(DATA_FOLDER, f'tiles_{addr:02X}.bin'), 'wb') as binary_file:
        for rec in res:
            binary_file.write(rec)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--file', help='ROM filename', dest='file',
                        default=DEFAULT_ROM_NAME, type=str)
    args = parser.parse_args()

    data = array('B')
    with open(args.file, 'rb') as rom:
        raw_data = rom.read()
        data.frombytes(raw_data)

    with open(os.path.join(DATA_FOLDER, ADDRS_FILE), 'r') as f:
        tiles_addrs = f.readlines()
        tiles_addrs = [int(hex_string, 16) for hex_string in tiles_addrs]

    for addr in tiles_addrs:
        try:
            unpack(data, addr)
        except Exception as e:
            print(f'Error: {str(e)}')
