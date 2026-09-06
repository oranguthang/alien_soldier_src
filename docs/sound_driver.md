# Alien Soldier sound driver

Alien Soldier uses Treasure's modified SMPS 68k Type 2 driver. The 68000
sequence engine runs once per frame with timeout-based tempo handling. A small
Z80 driver is responsible for DAC playback.

The format information and ID maps in this document were verified against the
[Alien Soldier SMPS rip](https://github.com/sonicretro/smps-rips/tree/master/68k/Alien%20Soldier),
created by Valley Bell as part of the SMPS Research project. The sequence bytes
were also compared with this disassembly: 153 of the 157 explicit SFX blocks
match the reference files byte for byte. The remaining four SFX are binary
includes whose pointer positions and sizes match the reference.

## Driver layout

| Data | ROM address |
|---|---:|
| 68000 sound driver entry points | `$082324` |
| DAC pointer table | `$0824A2` |
| Pan animation list | `$082884` |
| Voice DAC pointer list | `$082DEC` |
| Z80 DAC driver | `$083E70` |
| General sound pointer list | `$084CA4` |
| Modulation envelope pointers | `$084CC8` |
| PSG volume envelope pointers | `$084D8C` |
| Music pointer list | `$084E78` |
| Main SFX pointer list | `$084FF2` |
| Special SFX pointer list | `$085156` |
| Music data | `$085266` |
| SFX data | `$094D4C` |
| PCM data | `$098000` |
| Sound driver RAM | `$FFF800` |

The Z80 driver occupies `$83E70-$84A6F` (3072 bytes). It is still included as
binary data; the reference repository contains the same kind of binary dump,
not Z80 source code.

## Sound ID ranges

| IDs | Meaning |
|---|---|
| `$00` | Stop all sound |
| `$01-$0F` | Driver commands; `$05-$0F` are unused |
| `$10-$3F` | DAC SFX |
| `$40-$7F` | Sequence SFX through `SFX_40_7F_PointerTable` |
| `$81-$9F` | Music/song-format sequences |
| `$A0-$F8` | Sequence SFX through `SFX_PointerTable` |
| `$F9-$FC` | Special override SFX through `SpecialSFX_PointerTable` |
| `$FD-$FF` | Unused |

The filenames in `smps-rips` toggle bit 7 of the runtime SFX ID:

| Runtime IDs | Reference files |
|---|---|
| `$A0-$F8` | `20.sfx-78.sfx` |
| `$F9-$FC` | `79.sfx-7C.sfx` |
| `$40-$7F` | `C0.sfx-FF.sfx` |

Thus `runtime_id = reference_file_id XOR $80`.

The reference files identify sequence boundaries and IDs, but do not provide
semantic effect names. Weapon, enemy, UI, and boss effect names still need to
be established through call-site analysis or playback.

## Music IDs

| ID | Track |
|---:|---|
| `$81` | Runner, AD2025 |
| `$82` | Blacksheep |
| `$83` | Over!!! |
| `$84` | Unnamed in the reference; currently `fromobjectornointro` |
| `$85` | With Treasure |
| `$86` | !!! Shade |
| `$87` | Sidelimits |
| `$88` | Flashback |
| `$89` | Soltype |
| `$8A` | From Objector |
| `$8B` | Epsilons-Ally |
| `$8C` | Lurk!!! |
| `$8D` | Perfect-Thing |
| `$8E` | Slap-Up |
| `$8F` | X-Ages |
| `$90` | Oblivious Past; currently named `theend` in the disassembly |
| `$91` | Title Theme |
| `$92` | Silent |
| `$93` | Galaxy Desert |
| `$94` | Soldiers Song |
| `$95` | Alone'Z' variation with an initial delay |
| `$96` | 7th Force |
| `$97` | 3-Prayers |
| `$98` | Alone'Z' |
| `$99-$9E` | Aliases of Runner, AD2025 |
| `$9F` | Song-format SFX sequence |

The `$90` title differs from the existing `theend` label and should be checked
against the in-game sound test before that label is changed.

## Sequence commands

Commands `$E0-$FE` are dispatched by `Sound_CommandDispatcher`. `$FF` falls
through to `Sound_ExtendedCommandDispatch` and reads a second command byte.

| Command | Meaning |
|---:|---|
| `$E0` | Pan and YM2612 AMS/FMS |
| `$E1` | Detune |
| `$E2` | Set communication byte |
| `$E3` | Mute and stop track |
| `$E4` | Pan animation |
| `$E5` | Separate PSG/FM volume change |
| `$E6` | FM volume change |
| `$E7` | Hold next note |
| `$E8` | Note stop timeout |
| `$E9` | YM2612 LFO and AMS/FMS |
| `$EA` | Set tempo |
| `$EB` | Queue another sound ID |
| `$EC` | PSG volume change |
| `$ED` | Write register on current FM channel |
| `$EE` | Write register on YM2612 port 0/FM1 |
| `$EF` | Select FM instrument |
| `$F0` | Set custom modulation parameters |
| `$F1` | Select separate PSG/FM modulation envelopes |
| `$F2` | Stop track |
| `$F3` | Set PSG noise mode |
| `$F4` | Select modulation envelope |
| `$F5` | Select PSG instrument |
| `$F6` | Relative jump |
| `$F7` | Counted loop |
| `$F8` | Call relative sequence subroutine |
| `$F9` | Return from sequence subroutine |
| `$FA` | Set current track tick multiplier |
| `$FB` | Add transposition |
| `$FC` | Enable modulation |
| `$FD` | Disable modulation |
| `$FE` | Configure YM2612 channel 3 special mode |
| `$FF $00` | Configure SSG-EG/full attack |
| `$FF $01` | Pause or resume music |
| `$FF $02` | Set tick multiplier for all tracks |
| `$FF $03` | Start special fade |
| `$FF $04` | Stop special fade |

Relative pointers used by `$F6-$F8` are relative to the byte after the pointer
field, matching the standard SMPS 68k pointer format.

## Envelopes and pan animation

The driver has eight modulation envelopes and ten PSG volume envelopes. Their
pointer tables are at `$84CC8` and `$84D8C`, respectively.

Three pan-animation sequences begin at `$82890`, `$82892`, and `$82895`:

```asm
dc.b $40, $80
dc.b $40, $C0, $80
dc.b $C0, $80, $C0, $40, $00
```

Two original tracks intentionally read beyond the nominal pan data:

- Track `$8C` reads two bytes from the following code section.
- Track `$91` reads one zero padding byte after the pan table.

These quirks must be preserved when reorganizing the sound data.

## DAC data

The game uses Treasure's DPCM DAC format. The music DAC table has IDs
`$81-$96`; the voice table has IDs `$00-$2F`. Several IDs alias the same sample
at different rates. The table layout is shared with Dynamite Headdy.

The project currently preserves PCM as nine large `PCMPart` binary chunks.
Splitting them into individual samples would change the asset layout and
should only be attempted with byte-accurate ROM comparison available.
