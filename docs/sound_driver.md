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

## Audited 68000 update core

The complete `0x082324-0x0829A9` update core is now instruction-audited. Its
93 definitions distinguish the DAC/PCM sequence path, the BGM, ordinary SFX,
and special-SFX FM/PSG channel loops, FM pitch-envelope and vibrato handling,
FM3 special-frequency writes, pan animation, and pause/resume restoration.
The adjacent entry at `0x084A70` is also identified as the common PSG channel
processor.

This pass rejects four misleading generated descriptions. The old
`Sound_PlayPSGSequence` writes a DAC sample descriptor to the Z80 mailbox;
`Sound_SetFMFrequency` parses and updates PSG channels; the supposed tremolo
path consumes the three pan-animation sequences documented above; and the old
`Sound_HandleZ80BusRequest` implements the complete pause/resume transition,
with bus arbitration only as one implementation detail. The standalone
stack-skip helper at `0x08277C` has no static caller and remains explicitly
registered with `unknown` evidence.

## Audited request and voice-DAC dispatcher

The `0x0829AA-0x082F6B` block is now the cohesive
`sound/command_dispatch_and_dac.s` module rather than the misleading former
`fades_and_envelopes.s`. It selects one request from the four queue bytes at
`$FFF80A-$FFF80D`, dispatches the documented control, voice DAC, SFX, BGM, and
special-SFX ID ranges, and routes voice descriptors either through the
immediate Z80 command mailbox or through the primary and secondary playback
slots at `$A01F80` and `$A01FA0`.

All 47 voice IDs `$10-$3E` index eight-byte records in
`Sound_VoiceDACDescriptors`; `$3F` is explicitly rejected. The former
`Sound_UpdateEnvelope` actually performs this ID dispatch, and the former
`Sound_ReadEnvelopeData` reconstructs a packed sample address and reads its
four-byte DPCM header. The adjacent `$81-$9F` handler formerly called
`Sound_ProcessDAC` is now `Sound_LoadBGMRequest`, because its sole data source
is `BGM_PointerTable` and it initializes the song's DAC, FM, and PSG channel
records.

## Audited playback and loading core

The complete `0x082F6C-0x0834D1` span is now the cohesive 542-line
`sound/playback_and_loading.s` module. Its 75 definitions cover BGM FM/PSG
record initialization, ordinary and dedicated SFX loading, displaced-channel
override bookkeeping, SFX stop-and-restore paths, the 40-step music fade-out,
tempo ticks, and global FM/PSG shutdown. This is one connected playback-state
subsystem and fits the preferred 200-700-line range without a mechanical
split.

Several inherited semantic labels were contradicted by the instructions.
`Sound_ProcessFM` and `Sound_ProcessSpecialChannels` stop SFX records and
restore the BGM channels they displaced. `Sound_WriteRegister` only starts the
music fade-out. `Sound_InitializeChannels` advances that fade once every four
frames. `Sound_MuteAllChannels` writes maximum attenuation and release rate to
the current FM channel's four operators, while `Sound_KeyOffAllChannels`
addresses only the six FM channels. Finally, `Sound_UpdateFMEnvelope` clears
the playback RAM and silences every FM and PSG channel.

The 24-byte block at `0x083284` is preserved as
`Sound_UnreferencedSFXChannelPointers`. It contains six big-endian pointers to
the BGM/SFX records at `$FFF900`, `$FFF9F0`, `$FFFA50`, `$FFFB10`, `$FFFB40`,
and `$FFFB70`. No static source reference reaches the block, so the name states
only its observable format and current reference status rather than inventing
a runtime role.

## Hardware and volume-transition boundary

The former 337-line `sound/hardware_interface.s` mixed two independently
entered services. The ROM boundary at `0x0836A0` now separates the 210-line
hardware module (`0x0834D2-0x08369F`) from the 126-line
`sound/volume_transitions.s` module (`0x0836A0-0x08381F`). The former owns
playback-state reset, Z80-program loading, channel key-on/key-off filtering,
YM2612 port writes, Z80-bus arbitration, and its retry delay. The latter owns
the BGM attenuation/restore state machine, including its voice-DAC status
handshake.

The final 12-word table at `0x083808` remains adjacent to the transition code
in ROM order even though `Sound_CalculatePitch` is its consumer. This small
cross-module private-data exception avoids inventing a third six-line wrapper
module merely to move one contiguous table.

The hardware half is now instruction-audited at all 27 definitions. The
channel-aware write API clears bit 2 of the FM selector to choose YM2612 port
1 and otherwise chooses port 0; it adds the remaining channel number to the
register address before entering the matching synchronized writer. Port 0
uses `Z80_YM2612` offsets 0/1, while port 1 uses offsets 2/3. Both writers
preserve total-level register shadows, wait for the Z80 bus and YM2612 busy
bit, and retry after the same fixed sixteen-NOP delay.

This corrects several generated descriptions. `Sound_CheckPauseFlag` checks
the per-channel BGM-override bit and conditionally writes a register; it never
reads the pause state. `Sound_CheckChannelFlags` conditionally sends key-on
rather than returning a flag result. The former unqualified YM2612 writers
are now explicitly `Sound_WriteYM2612Port0` and `Sound_WriteYM2612Port1`.
Finally, `Sound_ResetDriver` is narrowed to `Sound_ResetPlaybackState`: it
clears the 68000 playback records while preserving the driver mode byte, but
does not reload the Z80 program.

The 126-line transition half is also fully audited. Manual command state 1
applies one configured attenuation step and state `$80` restores it. The
voice-DAC path watches Z80 status byte `$A01FFC` bit 5: when a marked voice
starts, it attenuates BGM FM/PSG channels using the configured steps (or
defaults `$0A`/`$02`); when the bit clears, it subtracts those retained steps
and clears them. `Sound_UpdateBGMVolumeTransitions` therefore replaces the
broader generated fade/envelope description.

Although this natural module is below the preferred 200-line band, merging it
back into hardware arbitration would obscure its independent state machine.
The twelve words at `Sound_FMNoteFrequencyTable` are the semitone F-numbers
used by `Sound_CalculatePitch`; keeping that tiny ROM-adjacent table at the
module tail avoids a content-free wrapper file.
