# Alien Soldier (J) Disassembly

Alien Soldier (J) source code disassembly project. The source assembles with the AS Macro Assembler.

**AS Assembler**: http://john.ccac.rwth-aachen.de:8000/as/index.html

**Inspired by**: https://github.com/lab313ru/quackshot_src/

## Project Structure

```
alien_soldier_src/
├── bin/                    # Assembler tools (AS, p2bin, msg files)
├── data/                   # Extracted tile data from original ROM
│   ├── tiles_*.bin        # Decompressed tile graphics
│   └── tiles_addrs.txt    # Addresses of compressed tiles in ROM
├── scripts/                # Build and extraction scripts
│   ├── build.py           # Main build script (configurable via CLI args)
│   ├── clean.py           # Cross-platform file cleanup utility
│   └── split.py           # ROM data extraction and tile decompressor
├── src/                    # Include files
│   ├── equals.inc         # Constants and equates
│   ├── ports.inc          # Hardware I/O port definitions
│   └── ram_addrs.inc      # RAM address definitions (~1014 lines)
├── alien_soldier_j.s       # Main disassembled source (11 MB, ~157k lines)
├── database.idb            # IDA Pro database
├── Makefile                # Build system
└── README.md               # Project documentation
```

## Build System

### Building
```bash
make build      # Assemble and build ROM
make clean      # Remove build artifacts
make split      # Extract data from original ROM (requires alien_soldier_j.bin)
make help       # Show all available targets
```

### Build Process
1. **scripts/build.py** - Python build script that orchestrates the build
2. **asw.exe** - Macro Assembler (AS 1.42 Beta) assembles alien_soldier_j.s → alien_soldier_j.p
3. **p2bin.exe** - Converts .p object file → asbuilt.bin (2 MB)

The build script runs the assembler from the bin/ directory where the required .msg files are located.

### Advanced Usage

Both scripts support command-line arguments for customization:

**Build script:**
```bash
python scripts/build.py --help
python scripts/build.py --source alien_soldier_j.s --output myrom.bin
```

**ROM data extractor:**
```bash
python scripts/split.py --help
python scripts/split.py -f alien_soldier_j.bin -o output_dir -a data/tiles_addrs.txt
```

### Build Status
- Build succeeds with 1 warning at line 79003
- Warning: `btst #$B,$E(a4)` - bit number will be truncated (bit 11 > 7 for byte operation)

## Code Analysis

### Sprite Mapping Data Structure

The game uses a complex sprite mapping system found around $E8000-$E9000 in ROM.

#### Structure Format (per sprite frame)
```asm
dc.w $8XX               ; Sprite count + flags (bit 15 = end marker)
dc.l <longword_data>    ; 32-bit data (see below)
dc.w <Y_offset>         ; Y position offset
dc.w $8XX               ; Next sprite data...
```

#### The 32-bit Longword Mystery

IDA disassembled these as: `dc.l byte_FXXXX+$Y000000` where:
- `byte_FXXXX` - Points to tile data (address ~$F0000-$F5000)
- `+$Y000000` - Large offset ($1000000 to $E000000)

**Example from alien_soldier_j.s:124973:**
```asm
dc.l byte_F2F5A+$E000000    ; IDA representation
```

**Actual ROM data:**
```
Address $E86FA: 0x0E0F2F5A  ; byte_F2F5A ($000F2F5A) + $E000000 = $0E0F2F5A
```

**Analysis:**
- The assembler correctly calculates: $000F2F5A + $0E000000 = $0E0F2F5A
- These values are NOT ROM addresses (would exceed 4MB limit = $3FFFFF)
- Likely purpose:
  - Tile pattern numbers with extended attributes
  - VDP VRAM addresses
  - Engine-specific data format
  - Upper bits may encode palette, priority, flip flags

#### Code Usage (sub_174A8)
The sprite data is processed by copying longwords directly:
```asm
move.l  (a1)+,(a3)+    ; Copy 32-bit value as-is to sprite buffer
```

This confirms these are raw data values, not pointers to be dereferenced.

### Known Issues

#### 1. Broken Code Regions (when moving code)
- **$3C000-$40000**: Gusthead boss is broken
- **$50000-$58000**: Wolfgunblood Garopa boss is broken
- **$82324-$E8000**: PCM sounds are broken
- **$E8000-$121932**: Graphics in levels are broken

These suggest the code has hardcoded addresses that need relocation when code is moved.

#### 2. IDA Quirks
- Line 79003: `btst #$B,$E(a4)` - bit 11 used for byte operation
- Sprite mappings represented as base+offset instead of raw values
- ~277 instances of `+$X000000` patterns in sprite data

## Tile Compression

The game uses a custom LZSS-based compression algorithm for tile graphics.

### Decompression Algorithm (scripts/split.py)

Format:
- **Header**: 16-bit size
- **Data**: Variable length compressed stream

Compression modes (determined by control byte):
```
Bit 7 = 1: LZSS backreference
  - Bits 5-2: Length (0-31) + 1
  - Bits 1-0 + next byte: Window offset (0-1023) + 1

Bit 7 = 0:
  Bit 6 = 1, Bit 5 = 1: RLE pairs
    - Bits 4-0: Count + 1
    - Next byte: Value1
    - Following bytes: alternating Value1, Value2

  Bit 6 = 1, Bit 5 = 0: RLE pairs (2-byte pattern)
    - Bits 4-0: Count + 1
    - Next 2 bytes: Pattern to repeat

  Bit 6 = 0, Bit 5 = 1: RLE single byte
    - Bits 4-0: Count + 1
    - Next byte: Value to repeat

  Bit 6 = 0, Bit 5 = 0: Literal data
    - Bits 4-0: Count (direct copy)
    - Next N bytes: Raw data
```

### Tile Data
- Located in `data/` directory
- ~120+ compressed tile sets extracted
- File naming: `tiles_<ROM_ADDR>.bin`
- Addresses listed in `data/tiles_addrs.txt`

## TODO

1. Fix several bugs when moving code:
   - $3C000-$40000 - Gusthead is broken
   - $50000-$58000 - Wolfgunblood Garopa is broken
   - $82324-$E8000 - PCM sounds are broken
   - $E8000-$121932 - graphics in levels are broken

2. Create compressor for tiles (based on LZSS)
3. Map data structures
4. Decompose data to separate files
5. Create data folder for mappings
6. Fix btst warning at line 79003
7. Test ROM in emulator
8. Compare with original ROM for byte-accurate verification

## Next Steps

1. **Understand sprite data format** - Need to determine what the 32-bit values represent
2. **Fix hardcoded addresses** - Identify and fix relocations in broken code regions
3. **Improve code structure** - Separate data into proper structures
4. **Create mapping tables** - Document sprite mappings, tile mappings, boss data
5. **Create tile compressor** - Implement the reverse of the decompression algorithm in split.py
6. **Test ROM** - Verify assembled ROM works in emulator
7. **Compare with original** - Get original ROM for byte-accurate comparison
