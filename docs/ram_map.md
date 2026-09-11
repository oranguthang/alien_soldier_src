# RAM map

`src/ram_addrs.inc` is the machine-consumed RAM inventory. It currently defines
976 observed 68000 work-RAM addresses and 28 observed Z80-RAM addresses. Most
still have neutral size/address names. The first reviewed semantic fields are
`GameModeIndex`, `GameSubstateIndex`, `StageTableIndex`, `Entity_ObjectPool`,
`DifficultyMode`, `MessageMode`, `SoundDisableFlags`, `StageTimeRemaining`,
`StagePhaseSplitTimes`, `StageCompletionTimes`, `StageResultVisits`,
`MessageSequenceState`, `MessageSequenceFlags`, `WeaponStateIndex`,
`WeaponSlotOffset`, `WeaponSavedSlotOffset`, `WeaponMenuRadius`,
`WeaponMenuAngle`, `WeaponStateCooldown`, `WeaponMenuAngularStep`, and
`WeaponMenuSlotOffset`, `ShootingMode`, and `ControlLayoutFlags`;
`VDPCommand` predates this review. All remain
subject to the evidence policy in `docs/naming.md`.

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

## Reviewed options fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `DifficultyMode` | `$FFFFFF0E` | The first normal options handler toggles bit 1 and renders the SUPER EASY/SUPER HARD labels from this word. |
| `MessageMode` | `$FFFFFF2A` | The otherwise unreferenced message-row handler toggles this word and renders ON/OFF at the MESSAGE SWITCH screen position. |
| `SoundDisableFlags` | `$FFFFFF38` | Options handlers toggle bit 1 for BGM and bit 2 for SFX; the game-side sound wrappers test the same bits before queueing requests. |

`MessageMode` has a statically identified options-row consumer, but the route
that makes that row user-visible is not yet proven. Its runtime effect on boss
messages therefore remains an open validation item rather than a confirmed
behavioral claim.

## Reviewed stage-results fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `StageTimeRemaining` | `$FFFFA270` | Loaded from the 25-entry packed-BCD stage time-limit table, decremented once per second, rendered by the HUD, and saved at phase/result boundaries. |
| `StagePhaseSplitTimes` | `$FFFFAA00` | `Results_StorePhaseSplitTime` stores one word selected by `StageTableIndex`; the results builder traverses 25 entries. |
| `StageCompletionTimes` | `$FFFFAA80` | `Results_StoreStageCompletionTime` stores the final per-stage timer snapshot; the results builder traverses 25 entries and derives elapsed intervals. |
| `StageResultVisits` | `$FFFFAB00` | The results transition increments the current stage entry, saturating at 999, and the summary traverses the same 25 words. |

The three history arrays are initialized together to `$FFFF`, the missing-value
sentinel. `StageResultVisits` deliberately uses the neutral word
“visit”: the ROM renders its aggregate under `TOTAL CONTINUE`, but static code
alone does not yet prove the exact player-facing counting convention.

## Reviewed message-sequence fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `MessageSequenceFlags` | `$FFFF80A8` | Bit zero prevents the dispatcher from mirroring controller direction state during the ship-name path. `ShipName_StartScript` sets it; `BossMessage_Start` clears it. |
| `MessageSequenceState` | `$FFFF80C2` | The central dispatcher uses this even word directly as an offset into its handler table. Stage, result, boss, and ship-cutscene callers publish a starting state here and wait for it to return to zero. |

## Reviewed weapon-state and selection fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `WeaponStateIndex` | `$FFFFA21C` | This even word directly indexes `Weapon_StateHandlerOffsets`; values `$12` and `$14` enter the four-slot selection-overlay initializer and updater. |
| `WeaponSlotOffset` | `$FFFFA24E` | Values `0`, `2`, `4`, and `6` select the active weapon record at `$FFFFA250`. |
| `WeaponSavedSlotOffset` | `$FFFFA220` | The special-state transition saves and restores this slot before recovering the active weapon record. |
| `WeaponMenuRadius` | `$FFFF8030` | Selection initialization sets `$A0`; the open-state update contracts it to `$20` before accepting input. |
| `WeaponMenuAngle` | `$FFFF8036` | The updater compares this angle with `WeaponSelect_TargetAngles` and advances it by the signed angular step. |
| `WeaponStateCooldown` | `$FFFF8038` | The shared updater decrements this field; the selection close path sets it to eight before committing the transition. |
| `WeaponMenuAngularStep` | `$FFFF803A` | Rotation input writes `+$10` or `-$10`, which the angle updater consumes. |
| `WeaponMenuSlotOffset` | `$FFFF803C` | Directional input maps to one of four slot offsets; the commit helper copies it to `WeaponSlotOffset`. |

## Reviewed weapon-setup fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `ShootingMode` | `$FFFFA22A` | The setup screen selects and highlights the encoded `MOVING`/`FIX` options from this zero-or-two word. Player rendering and every weapon-fire family branch on the same value. |
| `ControlLayoutFlags` | `$FFFFFF30` | The setup screen maps this stored byte through a 26-entry controller-layout table and displays the matching `TYPE 1`--`TYPE 26` string. HUD/input-prompt code tests its bits, while demo playback saves and restores it. |

## Reviewed sprite OAM pipeline fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `SpriteOAMEntryCount` | `$FFFFBE00` | Every OAM renderer loads and advances this byte as the generated-entry count; the hard limit is 80 Genesis sprite entries. |
| `SpriteOAMFreeSlots` | `$FFFFBE01` | Finalization stores 80 minus `SpriteOAMEntryCount` here after linking the priority buckets. |
| `SpriteOAMWritePointer` | `$FFFFBE02` | Renderers load this word as the next OAM write address and store the advanced pointer after appending entries. |
| `SpritePriorityBuckets` | `$FFFFBE04` | Initialization fills 64 four-byte bucket records; renderers update their tail pointers and finalization joins the nonempty buckets into one hardware link chain. |
| `SpriteOAMBuildActive` | `$FFFFF744` | Priority-bucket initialization sets this byte while a batch is open, and finalization clears it. |
| `SpriteOAMStartCount` | `$FFFFF756` | Initialization uses this word as the starting entry count and derives the first OAM write pointer from it, substituting one when it is zero. |

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
