# RAM map

`src/ram_addrs.inc` is the machine-consumed RAM inventory. It currently defines
976 observed 68000 work-RAM addresses and 28 observed Z80-RAM addresses. Most
still have neutral size/address names. The first reviewed semantic fields are
`GameModeIndex`, `GameSubstateIndex`, `StageTableIndex`, and
`Entity_ObjectPool`; `VDPCommand` predates this review. All remain subject to
the evidence policy in `docs/naming.md`.

## Address spaces

| Space | Range | Access | Current evidence |
|---|---|---|---|
| 68000 work RAM | `0xFF0000-0xFFFFFF` | native 68000 | hardware fact |
| Sign-extended work RAM notation | `0xFFFF0000-0xFFFFFFFF` | assembler operands | static encoding fact |
| Z80 RAM window | `0xA00000-0xA01FFF` | 68000 via bus request | hardware fact |
| YM2612 ports | from `0xA04000` | shared sound hardware | hardware fact |

`M68K_RAM_PHYSICAL` and `M68K_RAM_END_PHYSICAL` exist specifically for ROM
header fields, which store 24-bit physical addresses. Most instructions use
the sign-extended `0xFFFFxxxx` form because that is how their absolute-short or
absolute-long operands were reconstructed.

## Review policy

- `byte_`, `word_`, and `dword_` state observed access width, not purpose.
- Overlapping names may be valid when code accesses fields at different widths;
  do not merge them from address proximity alone.
- A semantic rename requires cross-reference analysis and preferably a runtime
  assertion that exercises both reads and writes.
- Record structure extent only after bounds are supported by iteration limits,
  adjacent accesses, or runtime traces.
- Runtime scenarios should use reviewed semantic aliases. Raw address names are
  acceptable only while the expectation is explicitly marked `unknown` or
  `hypothesis`.

The current file is therefore an address inventory, not yet a fully semantic
RAM map. Release 0.5 work must promote the state variables used by its six
runtime scenarios and document their evidence.
