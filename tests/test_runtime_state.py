from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from runtime_state import Genstate, M68K_RAM  # noqa: E402


class RuntimeStateTests(unittest.TestCase):
    def test_m68k_host_word_byte_order(self) -> None:
        ram = bytearray(0x10000)
        ram[0] = 0x34
        ram[1] = 0x12
        state = Genstate(frame=1, rom_checksum=0, sections={M68K_RAM: bytes(ram)})
        self.assertEqual(0x12, state.m68k_u8(0xFF0000))
        self.assertEqual(0x1234, state.m68k_u16(0xFF0000))


if __name__ == "__main__":
    unittest.main()
