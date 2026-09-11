# RAM map

`src/ram_addrs.inc` is the machine-consumed RAM inventory. It currently defines
976 observed 68000 work-RAM addresses and 28 observed Z80-RAM addresses. Most
still have neutral size/address names. The first reviewed semantic fields are
`GameModeIndex`, `GameSubstateIndex`, `StageTableIndex`, `Entity_ObjectPool`,
`DifficultyMode`, `MessageMode`, `SoundDisableFlags`, `StageTimeRemaining`,
`ScoreValueBCD`, `ScoreAddendBCD`, `ScoreAddendPrefixByte`,
`StagePhaseSplitTimes`, `StageCompletionTimes`, `StageResultVisits`,
`MessageSequenceState`, `MessageSequenceFlags`, `WeaponStateIndex`,
`WeaponSlotOffset`, `WeaponSavedSlotOffset`, `WeaponMenuRadius`,
`WeaponMenuAngle`, `WeaponStateCooldown`, `WeaponMenuAngularStep`, and
`WeaponMenuSlotOffset`, `ShootingMode`, `ControlLayoutFlags`, and
`RandomNumberState`, `FrameCounter`, `PaletteEffectControl`,
`PaletteEntryLists`, `PalettePrimaryIndex`, and `PaletteSecondaryIndex`;
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
| `ScoreAddendPrefixByte` | `$FFFFA005` | The packed-BCD score adder clears this byte immediately before staging its four-byte operand at the following address. No other source reference accesses it independently. |
| `ScoreAddendBCD` | `$FFFFA006` | The score adder writes `d0` here and consumes all four bytes with predecrement `ABCD` instructions. |
| `ScoreValueBCD` | `$FFFFA212` | Gameplay rewards and the result time bonus add packed-BCD values here; initialization clears it, while the HUD and results screen render all eight digits. |
| `StageTimeRemaining` | `$FFFFA270` | Loaded from the 25-entry packed-BCD stage time-limit table, decremented once per second, rendered by the HUD, and saved at phase/result boundaries. |
| `StagePhaseSplitTimes` | `$FFFFAA00` | `Results_StorePhaseSplitTime` stores one word selected by `StageTableIndex`; the results builder traverses 25 entries. |
| `StageCompletionTimes` | `$FFFFAA80` | `Results_StoreStageCompletionTime` stores the final per-stage timer snapshot; the results builder traverses 25 entries and derives elapsed intervals. |
| `StageResultVisits` | `$FFFFAB00` | The results transition increments the current stage entry, saturating at 999, and the summary traverses the same 25 words. |

The three history arrays are initialized together to `$FFFF`, the missing-value
sentinel. `StageResultVisits` deliberately uses the neutral word
“visit”: the ROM renders its aggregate under `TOTAL CONTINUE`, but static code
alone does not yet prove the exact player-facing counting convention.

## Reviewed pseudo-random state

| Symbol | Address | Static evidence |
|---|---:|---|
| `RandomNumberState` | `$FFFFFF08` | `RandomNumber` replaces this longword on every call, and gameplay consumers sample its bytes and words. Demo playback writes a fixed seed here so its recorded input remains deterministic. |

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

## Reviewed palette, scroll, and VDP-control fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `PaletteActiveBuffer` | `$FFFFE300` | Palette loaders write the visible 64-color image here, and VBlank DMA uploads this 128-byte buffer to CRAM. |
| `PaletteShadowBuffer` | `$FFFFE380` | Palette loaders mirror the active image here; fades and palette effects use it as the stable source while changing the active buffer. |
| `HScrollBuffer` | `$FFFFE400` | Camera and effect code publish horizontal scroll words here; the VBlank DMA command targets the VRAM horizontal-scroll table at `$F000`. |
| `VScrollBuffer` | `$FFFFEC00` | Camera and effect code publish vertical scroll words here; the corresponding VBlank DMA command targets VSRAM. |
| `HScrollDMASource` | `$FFFFF710` | Initialization points this longword at `HScrollBuffer`; the horizontal-scroll DMA builder encodes it as the transfer source. |
| `VScrollDMASource` | `$FFFFF714` | Initialization points this longword at `VScrollBuffer`; the vertical-scroll DMA builder encodes it as the transfer source. |
| `FrameTimingDebugFlag` | `$FFFFF746` | A debug controller chord toggles its sign bit; the gameplay loop then emits VDP timing markers between subsystem updates and runs the debug backdrop helpers. |
| `PaletteFadeStep` | `$FFFFF75C` | The full-screen fade engine adds this signed word to `PaletteFadeProgress`; zero means no active fade. |
| `PaletteFadeProgress` | `$FFFFF75E` | Its high byte supplies the per-channel delta, and the fade engine clamps the word at zero or `$1000`. |
| `VDPReg1Shadow` | `$FFFFF7D2` | The VDP settings loader writes this `$81xx` command word; display helpers clear or restore register 1 display-enable bit 6. |
| `VDPReg7Shadow` | `$FFFFF7DE` | The VDP settings loader writes this `$87xx` command word, and backdrop helpers restore it after diagnostic writes. |
| `PaletteFillColor` | `$FFFFFF28` | With palette DMA disabled, VBlank fills all 64 CRAM entries with this word; zero/nonzero also selects the black/white endpoint in the full-screen fade engine. |

## Reviewed palette-effect control fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `FrameCounter` | `$FFFFA000` | Gameplay and frontend loops increment this word once per completed frame. Animation, palette, projectile, and boss code use its low bits as periodic phase selectors, while demo initialization clears it before deterministic playback. |
| `PaletteEffectControl` | `$FFFF8218` | Palette handlers consume this word as a countdown, RGB delta, or bitfield controlling selected color-cycle slots; producers set it together with an effect selector. |
| `PaletteEntryLists` | `$FFFF821A` | Stage 8 and 9 lightning flows point this longword at two consecutive counted palette-entry lists; the paired-list handler applies opposite RGB deltas to them. |
| `PalettePrimaryIndex` | `$FFFF8220` | Stage configuration writes this even selector, and the primary dispatcher uses it directly as an offset into its ten-entry handler table. |
| `PaletteSecondaryIndex` | `$FFFF8222` | Stage configuration and transition code write this even selector, and the secondary dispatcher uses it directly as an offset into its four-entry handler table. |

## Reviewed cutscene and story-title fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `StoryTitleGlyphCursor` | `$FFFF0100` | Only the story-title reveal stores and advances this longword pointer through the twelve glyph codes in `StoryTitle_LogoRevealCharacters`. |
| `CutsceneTimer` | `$FFFF0106` | Story, credits, starfield, and planet states initialize and decrement this shared word as their state timer; planet zoom also uses its low bits for update cadence. |
| `StoryTitleExpandSpan` | `$FFFF0108` | Only the story-title states initialize this word to `$21`, reduce it by four, and use it as the horizontal pixel and scroll-run span. |
| `StoryTitleGlyphsLeft` | `$FFFF010A` | Only the story-title reveal initializes this word to twelve and decrements it after each revealed `ALIENSOLDIER` glyph. |
| `CutscenePaletteStep` | `$FFFF010C` | Story-title, credits, starfield, and planet states use this shared word as the signed or indexed step supplied to their palette-update routines. |

## Reviewed cutscene grid and pattern-dissolve fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `PatternVDPCommand` | `$FFFF00C0` | Planet and frontend setups store the base VDP write command here; dissolve selection adds its chosen pattern-word offset before queuing DMA. |
| `PatternDissolveStep` | `$FFFF00C6` | Erase and reveal routines move this signed index through the 64-entry shuffled word order and test its `$40` and negative endpoints. |
| `PatternFrameMask` | `$FFFF00C8` | Pattern-step routines AND the frame counter with this value to select their update cadence. |
| `ShipPatternVDPCommand` | `$FFFF00CA` | Ship-grid setup stores the pattern VRAM command here; ship dissolve selection adds the selected word offset. |
| `ShipPatternStep` | `$FFFF00D0` | Ship erase and reveal routines move this signed index through the common dissolve order. |
| `ShipPatternFrameMask` | `$FFFF00D2` | Ship pattern-step routines AND the frame counter with this value to select their cadence. |
| `SpriteGridCenterY` | `$FFFF00D4` | The planet-object copier and frontend setups write the vertical center consumed by the generic grid renderer. |
| `SpriteGridCenterX` | `$FFFF00D6` | The planet-object copier and frontend setups write the horizontal center consumed by the generic grid renderer. |
| `SpriteGridRowLimit` | `$FFFF00D8` | The generic renderer uses this DBF limit both to center and enumerate grid rows. |
| `SpriteGridColumnLimit` | `$FFFF00DA` | The generic renderer uses this DBF limit both to center and enumerate grid columns. |
| `SpriteGridFirstTile` | `$FFFF00DC` | Setup code stores the first tile attribute here and the renderer increments it across emitted cells. |
| `ShipGridCenterY` | `$FFFF00DE` | The ship-grid renderer copies the object's vertical coordinate here before centering rows. |
| `ShipGridCenterX` | `$FFFF00E0` | The ship-grid renderer copies the object's horizontal coordinate here before centering columns. |
| `ShipGridRowLimit` | `$FFFF00E2` | The ship renderer uses this DBF limit to center and enumerate its rows. |
| `ShipGridColumnLimit` | `$FFFF00E4` | The ship renderer uses this DBF limit to center and enumerate its columns. |
| `ShipGridFirstTile` | `$FFFF00E6` | Ship-grid setup stores the first tile attribute here and the renderer increments it across emitted cells. |
| `StarRowSeparation` | `$FFFF00E8` | Expansion and collapse change this word while the updater subtracts it from the upper row and adds it to the lower row. |
| `StarRowState` | `$FFFF00EA` | The star-row dispatcher uses this even word directly as its six-entry table index. |
| `PlanetGridState` | `$FFFF00EE` | The planet-grid dispatcher uses this even word directly as its eleven-entry table index. |
| `ShipGridState` | `$FFFF00F0` | The ship-grid dispatcher uses this even word directly as its ten-entry table index. |
| `PlanetGridTimer` | `$FFFF00F2` | Planet-grid setup and hold states load and decrement this word as their frame timer. |
| `ShipGridTimer` | `$FFFF00F4` | Ship-grid delay and hold states load and decrement this word as their frame timer. |
| `StarRowTimer` | `$FFFF00FE` | Star-row delay and hold states load and decrement this word as their frame timer. |

## Reviewed story-text streaming fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `StoryTextVRAMAddress` | `$FFFF00F6` | The story row streamer advances this circular plane-A destination by `$180` and wraps it at `$5000`. |
| `StoryFontGlyphCursor` | `$FFFF0120` | The Japanese-font states initialize this pointer to `font_japanese_mappings` and advance it by one word after every glyph. |
| `StoryFontState` | `$FFFF0126` | The Japanese-font dispatcher uses this even word directly as its three-entry state-table index. |
| `StoryTextAccentCursor` | `$FFFF0172` | Story initialization and streaming advance this longword through the 99 fixed-size accent rows. |
| `StoryTextState` | `$FFFF0178` | Frontend and story initialization clear this word; `StoryText_Dispatch` uses it as its two-state table index. |
| `StoryFontScrollY` | `$FFFF0180` | The font update decrements this word once or twice per frame, and VBlank writes it to the VDP vertical-scroll data port. |
| `StoryFontNextGlyphY` | `$FFFF0182` | The glyph streamer compares this threshold with `StoryFontScrollY` and subtracts `$10` after each queued glyph. |
| `StoryFontVRAMAddress` | `$FFFF0184` | The glyph streamer advances this circular destination by `$80` and wraps from `$8000` to `$7000`. |

## Reviewed ending-starfield and planet fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `EndingScrollPhase` | `$FFFF0110` | The ending planet and credits perspective effects integrate their signed fixed-point scroll position here before deriving symmetric H/V scroll bands. |
| `EndingScrollRate` | `$FFFF0114` | Perspective states add `$80` acceleration to this longword and then add the resulting rate to `EndingScrollPhase`. |
| `PlanetZoomFrameIndex` | `$FFFF0118` | The zoom loop advances this word up to `$3E` and uses it to select fixed-size entries from `Sprite_SharedGraphicsFrameTable`. |
| `PlanetZoomAngle` | `$FFFF011A` | Planet zoom initializes this word to `$1A0`, subtracts four per frame, and passes it to the sine/cosine lookup. |
| `PlanetZoomRadius` | `$FFFF011C` | Planet zoom initializes this fixed-point radius to `$200000` and subtracts `$8000` per frame until it reaches zero. |

## Reviewed VBlank transfer and VDP-shadow fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `SpriteOAMBuffer` | `$FFFFE000` | Sprite renderers build eight-byte hardware entries here and cap the list at 80; VBlank uploads the complete 640-byte table to VRAM `$F400`. |
| `VDPCommandQueueHead` | `$FFFFF70C` | Command producers prepend 16-byte records below the `$F400` pivot; VBlank traverses from this address back to the pivot. |
| `VDPStagingDataCursor` | `$FFFFF70E` | Graphics producers allocate payload bytes upward from `$F400`, encode this cursor as the DMA source, and advance it by the payload size. |
| `VDPTransferPending` | `$FFFFF754` | Transfer setup sets this byte, synchronous callers wait on it, and the VBlank transfer tail clears it after issuing the queued work. |
| `PaletteDMAHIntEnabled` | `$FFFFF755` | Zero selects a full-CRAM fill and suppresses register 0 horizontal interrupts; nonzero selects palette DMA and preserves the register 0 shadow. |
| `VDPReg0Shadow` | `$FFFFF7D0` | The contiguous initialization loop stores the `$80xx` register command here; HBlank/VBlank code modifies its horizontal-interrupt bit. |
| `VDPReg2Shadow` | `$FFFFF7D4` | The initialization loop stores the `$82xx` register command here and the per-frame writer sends it to the VDP. |
| `VDPReg3Shadow` | `$FFFFF7D6` | The initialization loop stores the `$83xx` register command here and the per-frame writer sends it to the VDP. |
| `VDPReg4Shadow` | `$FFFFF7D8` | The initialization loop stores the `$84xx` register command here and the per-frame writer sends it to the VDP. |
| `VDPReg5Shadow` | `$FFFFF7DA` | The initialization loop stores the `$85xx` register command here and the per-frame writer sends it to the VDP. |
| `VDPReg10Shadow` | `$FFFFF7E4` | The initialization loop stores the `$8Axx` register command here and the per-frame writer sends it to the VDP. |
| `VDPReg11Shadow` | `$FFFFF7E6` | Its scroll-mode bits select the horizontal and vertical table lengths used by VBlank DMA. |
| `VDPReg12Shadow` | `$FFFFF7E8` | The initialization loop stores the `$8Cxx` register command here and the per-frame writer sends it to the VDP. |
| `VDPReg13Shadow` | `$FFFFF7EA` | The initialization loop stores the `$8Dxx` register command here and the per-frame writer sends it to the VDP. |
| `VDPReg15Shadow` | `$FFFFF7EE` | The initialization loop stores the `$8Fxx` register command here and the per-frame writer sends it to the VDP. |
| `VDPReg16Shadow` | `$FFFFF7F0` | The initialization loop stores the `$90xx` register command here and the per-frame writer sends it to the VDP. |
| `VDPReg17Shadow` | `$FFFFF7F2` | The initialization loop stores the `$91xx` register command here and the per-frame writer sends it to the VDP. |
| `VDPReg18Shadow` | `$FFFFF7F4` | The initialization loop stores the `$92xx` register command here and the per-frame writer sends it to the VDP. |

## Reviewed raster-effect control fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `HBlankRAMCode` | `$FFFFEE00` | Function-copy descriptors install raster handlers here, the level-4 interrupt vector jumps here, and disabling the effect writes the `RTE` opcode `$4E73`. |
| `RasterEffectIndex` | `$FFFFF74A` | This even word directly indexes the 23-entry raster-effect handler table. Scene and boss setup code publishes its selected table offset here. |
| `RasterEffectInitState` | `$FFFFF74E` | Every raster-effect handler tests this word as its one-time installation guard and advances it from zero to four after installing RAM code. |

## Reviewed graphics staging fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `GraphicsStagingBuffer` | `$FFFFB400` | Initialization clears the full 1 KiB region. The tile codec uses its first 128 bytes as word-sized pixel output, while LZSS-to-VRAM loading uses it as a `$400`-byte staging block. |
| `TileDecodeBufferEnd` | `$FFFFB480` | The tile decoder stops at this address, exactly 64 word-sized pixels after `GraphicsStagingBuffer`. |
| `TileDMABatchBuffer` | `$FFFFB600` | The batched tile path packs at most 16 32-byte tiles into this 512-byte half-buffer before queuing its DMA transfer. |

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
