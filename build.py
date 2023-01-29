import os
import subprocess

AS_BIN = os.path.join(os.getcwd(), 'bin', 'asw')
AS_ARGS = '-maxerrors 2'

P2_BIN = os.path.join(os.getcwd(), 'bin', 'p2bin')
P2_BIN_DST_EXT = '.bin'

MAIN_SRC = os.path.join(os.getcwd(), 'alien_soldier_j.s')
ROM_NAME = os.path.join(os.getcwd(), 'rom.bin')


def run_process(cmd):
    p = subprocess.Popen(cmd, bufsize=2048, shell=True)
    p.wait()


def assemble_main_src(base_dir):
    os.chdir(base_dir)

    run_process('%s %s %s' % (AS_BIN, AS_ARGS, MAIN_SRC))

    pre, ext = os.path.splitext(MAIN_SRC)
    run_process('%s %s %s' % (P2_BIN, pre + '.p', ROM_NAME))


if __name__ == '__main__':
    basedir = os.getcwd()
    assemble_main_src(basedir)
