# RAM map

`src/ram_addrs.inc` is the machine-consumed RAM inventory. It currently defines
976 observed 68000 work-RAM addresses and 28 observed Z80-RAM addresses. Most
still have neutral size/address names. The first reviewed semantic fields are
`GameModeIndex`, `GameSubstateIndex`, `StageTableIndex`, `Entity_ObjectPool`,
`DifficultyMode`, `MessageMode`, `SoundDisableFlags`, `StageTimeRemaining`,
`ScoreValueBCD`, `ScoreAddendBCD`, `ScoreAddendPrefixByte`,
`StagePhaseSplitTimes`, `StageCompletionTimes`, `StageResultVisits`,
`SharedSequenceState`, `SharedSequenceCursor`, `SharedSequenceTimer`,
`ContinueCreditsBCD`, `HighScoreBCD`, `PostStageEntryCountBCD`,
`DestroyedEnemyCountBCD`, `PlayerDamageBCD`,
`MessageSequenceState`, `MessageSequenceFlags`, `MessageAdvanceButtons`,
`MessageDisplayFlags`, `StageMessageCursor`,
`PendingStageBGMRequest`, `FontTileDMAVRAMAddress`,
`FontTileDMACounter`, `FontTileDMASourceOffset`, `XiTigerConfigIndex`,
`CutsceneScaleStep`, `CutsceneScaleSnapshot`, `CutsceneOffsetCenter`,
`CutsceneRowLoopLimit`, `CutsceneVerticalOffset`, `CutsceneLineOffsetTable`,
`SetupTransitionIndex`, `PlayerHealth`, `PlayerMaxHealth`,
`DisplayedPlayerHealth`, `BossHealth`, `BossMaxHealth`,
`DisplayedBossHealth`, `WeaponStateIndex`,
`WeaponSlotOffset`, `WeaponSavedSlotOffset`, `WeaponMenuRadius`,
`WeaponMenuAngle`, `WeaponStateCooldown`, `WeaponMenuAngularStep`, and
`WeaponMenuSlotOffset`, `ShootingMode`, `ControlLayoutFlags`, and
`RandomNumberState`, `DemoPlaybackActive`, `DemoPlaybackState`,
`DemoStageTableIndex`, `VBlankFrameCounter`, `PasswordDigits`, `FrameCounter`,
`PaletteEffectControl`,
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

## Reviewed shared sequence scratch fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `SharedSequenceState` | `$FFFF00EC` | The Sega and title transition dispatchers use this even word as their state-table offset. Credits reuses it for the five-state animated-glyph sequence; each owner clears it before dispatch. |
| `SharedSequenceCursor` | `$FFFF00F8` | Story text advances this longword through fixed-size row records, while the credits-glyph sequence advances it through its variable-size two-row records. |
| `SharedSequenceTimer` | `$FFFF00FC` | Story text uses the word as its row cadence; the credits-glyph parser stores record delays here and the sequence delay state counts it down. |

The names deliberately preserve their scratch/shared lifetime. Naming these
fields after only story text or credits would misdescribe the other proven
owner.

## Reviewed cutscene-projection fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `CutsceneScaleStep` | `$FFFF9F08` | Initialized to fixed-point `$1.FFFE`, accumulated while selecting symmetric source columns, and reduced by `$0.1800` during the Xi-Tiger reveal. |
| `CutsceneScaleSnapshot` | `$FFFF9F0C` | Captures the current scale step once per frame before the line-offset increment is derived. |
| `CutsceneOffsetCenter` | `$FFFF9F10` | Holds byte offset `$1E` from the line-table base; the offset builder expands left and right from that point. |
| `CutsceneRowLoopLimit` | `$FFFF9F12` | Supplies the `$B` `DBF` limit to both the row-copy and transfer-queue loops, yielding twelve projected rows. |
| `CutsceneVerticalOffset` | `$FFFF9F14` | Derived from the Xi-Tiger layer phase, added to projected line offsets, and subtracted from the marker object's Y anchor. |
| `CutsceneLineOffsetTable` | `$FFFF9F80` | The frame builder fills bounded word offsets through `$FFFF9FBF`; the Xi-Tiger VRAM-layout initializer consumes the same base. |

These names describe the observed representation rather than an assumed visual
intent. In particular, the original initializer did not decompress data: it
only established projection, raster-effect, and layout state.

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
| `ContinueCreditsBCD` | `$FFFFA228` | New-game setup initializes this packed-BCD word to three. Continue setup requires it to be nonzero, the hard-mode accepted path decrements its low byte with `SBCD`, and the continue screen renders it beside `CREDIT`. |
| `HighScoreBCD` | `$FFFFFF2C` | Boot initializes this packed-BCD longword to 100000. The results summary replaces it when `ScoreValueBCD` is greater and renders it under `HIGH SCORE`. |
| `PostStageEntryCountBCD` | `$FFFFFF40` | New-game setup clears this packed-BCD word and post-stage initialization increments it once, saturating at 9999. Its only renderer is present but unreferenced. |
| `DestroyedEnemyCountBCD` | `$FFFFFF42` | Enemy-destruction collision paths increment this packed-BCD word; the results summary renders it beside `DESTROYED ENEMIES`. |
| `PlayerDamageBCD` | `$FFFFFF44` | Hostile-contact damage adds packed-BCD units to this word, saturating at 9999; the results summary renders it beside `PLAYER DAMAGE`. |
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

## Reviewed password field

| Symbol | Address | Static evidence |
|---|---:|---|
| `PasswordDigits` | `$FFFFFF3A` | Boot initializes the four bytes to one. The title-menu editor changes and clamps each byte from one through `$0A`, validates the longword against `Password_StageCodeTable`, and the Continue display stores the selected stage code back into the same field. |

## Reviewed demo-playback fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `DemoPlaybackActive` | `$FFFFFF5A` | The title timer sets this word at frame `$700`; `Demo_PlaybackSystem` gates all initialization and updates on it and clears it when returning to title mode. |
| `DemoPlaybackState` | `$FFFFFF5C` | The title trigger clears this word; demo playback treats zero as initialization and advances it by four before using the continuing playback path. |
| `DemoStageTableIndex` | `$FFFFFF64` | Demo initialization stores an entry from `Demo_StageIndexTable` here, and title confirmation copies it to `StageTableIndex` before gameplay starts. |

## Reviewed message-sequence fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `MessageSequenceFlags` | `$FFFF80A8` | Bit zero prevents the dispatcher from mirroring controller direction state during the ship-name path. `ShipName_StartScript` sets it; `BossMessage_Start` clears it. |
| `MessageSequenceState` | `$FFFF80C2` | The central dispatcher uses this even word directly as an offset into its handler table. Stage, result, boss, and ship-cutscene callers publish a starting state here and wait for it to return to zero. |
| `MessageAdvanceButtons` | `$FFFF8310` | The dispatcher stores the controller byte masked with `$70`; the glyph-delay state advances immediately when the result is nonzero. |
| `MessageDisplayFlags` | `$FFFFFF31` | Message-script entry sets bit 7 and finalization clears it. The signed HUD path suppresses its update while that bit is set; initialization clears the whole byte. |

## Reviewed interstage-transition fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `StageMessageCursor` | `$FFFFA22C` | Stage and boss transition handlers assign one of four message-sequence addresses. The interstage message updater queues the current record, advances this cursor, and clears it at the `$FD` terminator. |
| `PendingStageBGMRequest` | `$FFFFA230` | Visual-asset dispatch clears this byte, selected transitions store sound request IDs, and both interstage setup paths submit it through `Sound_QueueBGMOrStop` when nonzero. |
| `FontTileDMAVRAMAddress` | `$FFFF8146` | The dormant interstage graphics setup initializes this destination to `$6000`; `Gfx_QueueNextFontTileDMA` encodes it into the VDP command and advances it by `$400`. |
| `FontTileDMACounter` | `$FFFF8148` | Initialized to 15 by the dormant setup, tested for negative completion, and decremented after each queued font tile. |
| `FontTileDMASourceOffset` | `$FFFF814A` | Added to `tiles_font` to form the DMA source and advanced by `$400` after each queued tile. |

## Reviewed health fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `PlayerHealth` | `$FFFFA216` | Player-damage paths subtract from this word and clamp it at zero or one according to their invulnerability rules. Pickups restore it up to `PlayerMaxHealth`, while gameplay initialization and the HUD copy or render it. |
| `PlayerMaxHealth` | `$FFFFA218` | New-game initialization sets this and `PlayerHealth` to `$200`; pickups cap health against it, stage 25 can increase it to `$400`, and both HUD presentations use it as the maximum. |
| `DisplayedPlayerHealth` | `$FFFF820A` | Gameplay and Xi-Tiger initialization copy `PlayerHealth` here. The HUD approaches the current value in small steps before rendering the visible health bar. |
| `BossHealth` | `$FFFF8200` | Boss setup routines initialize it, combat collision paths subtract damage and clear it at defeat, and boss state machines use it for health thresholds. |
| `BossMaxHealth` | `$FFFF8202` | Boss setup initializes this alongside `BossHealth`; collision defeat paths clear both, and the alternate HUD presentation renders it as the reference maximum. |
| `DisplayedBossHealth` | `$FFFF8206` | Stage and Xi-Tiger setup copy or initialize boss health here. The boss HUD approaches `BossHealth` in `$100` steps before rendering it. |

These names describe the stable cross-subsystem role of the words, not a
particular boss or cutscene. The Xi-Tiger transition reuses the same health
fields to seed its displayed state.

## Reviewed setup and transition selector fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `SetupTransitionIndex` | `$FFFFA29C` | The weapon-setup updater uses even values as offsets into its seven-entry page/state table. The later transition dispatcher reuses values `0`, `2`, and `4` to select Xi-Tiger, the Z-Leo ending scene, or the shared ending sequence. |
| `XiTigerConfigIndex` | `$FFFF814C` | The Xi-Tiger cutscene initializer writes zero, and stage initialization uses the word as an offset into the adjacent Xi-Tiger configuration table. Only the zero entry and zero writer are currently present in source. |

`SetupTransitionIndex` is deliberately named for both observed lifetimes. A
narrow weapon-page or cutscene-route name would be false because the same RAM
word is reused after the setup screen. Nonzero `XiTigerConfigIndex` values and
their runtime reachability remain unproven.

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
| `VBlankFrameCounter` | `$FFFFA280` | `Sys_UpdateTimers` increments this word on every VBlank dispatch. Frontend, cutscene, HUD, effect, and boss code use its low bits for cadence and animation; demo initialization clears it. |
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

## Reviewed ship-sequence fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `ShipPieceScriptCursor` | `$FFFF0128` | Timeline initialization points this cursor at `ShipPiece_SpawnScript`; each matching seven-word record advances it to the following ship-piece event. |
| `ShipDebrisCursor` | `$FFFF012C` | Timeline initialization points this cursor at `ShipDebris_SpawnScript`; each matching four-word record advances it to the following debris event. |
| `ShipSequenceFrame` | `$FFFF0130` | The controller increments this master timeline frame, and both spawn scripts compare their next event trigger with it. |
| `ShipSequenceState` | `$FFFF0132` | The controller uses this even word directly as the sixteen-entry `ShipSequence_TimelineStates` index. |
| `ShipVerticalPosition` | `$FFFF0134` | Scroll integration adds velocity to this signed 16.16 position and publishes its integer word to vertical-scroll bands. |
| `ShipVerticalVelocity` | `$FFFF0138` | Arrival and flash states adjust this signed 16.16 velocity before the scroll updater integrates it. |
| `ShipTileLoadTimer` | `$FFFF013C` | The five arrival tile loaders use this word for their repeated `$20`-frame spacing. |
| `ShipRowRevealProgress` | `$FFFF0140` | Eighteen consecutive words independently track the next shuffled nibble for each pattern row. |
| `ShipRevealFrame` | `$FFFF0164` | The revealer divides this incrementing frame by eight to activate up to eighteen rows progressively. |
| `ShipMainFadeStep` | `$FFFF0166` | The final state raises this main-palette fade step from `$FFF2` toward two. |
| `ShipAccentFadeStep` | `$FFFF0168` | The final state lowers this accent-palette fade step from `$000E` every fourth frame. |
| `ShipFlashState` | `$FFFF016A` | The arrival-flash dispatcher uses this even word directly as its three-entry state index. |
| `ShipFlashTimer` | `$FFFF016C` | The active and restart flash states count this word through `$40`- and `$60`-frame phases. |
| `ShipJitterState` | `$FFFF016E` | Only the statically unreferenced vertical-jitter dispatcher reads this private three-state index. |
| `ShipJitterTimer` | `$FFFF0170` | Only the statically unreferenced vertical-jitter states initialize and count down this private timer. |

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

## Reviewed palette-transition and results fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `ResultsFirstColorOffset` | `$FFFF8014` | Post-stage setup clears this word; the selected-range fade passes it through RGB-component preparation only for the first four colors. |
| `ResultsOtherColorOffset` | `$FFFF8016` | Post-stage setup initializes this word to `$FFF2`; the range helper applies it to each of the remaining three palette ranges. |
| `PaletteFadeColorOffset` | `$FFFF80F0` | The shared transition advances this signed value toward a mode-specific limit and expands it into RGB component offsets. |
| `PaletteFadeMode` | `$FFFF80F2` | Zero disables processing; the low bits select the first or second mode and the sign selects transition direction. |
| `PaletteFadeMaskStatus` | `$FFFF80F4` | The upper bits select adjusted color channels, while completion paths publish status bits zero and one in the same word. |
| `PaletteFadeControlFlags` | `$FFFF80F8` | Bits zero and one force completion of the respective modes; bit two controls second-mode frame pacing. |
| `AlternateTimeBonusSound` | `$FFFF80FA` | Selected encounter-completion paths set this byte; results uses it to request BGM `$83` instead of the normal time-bonus SFX. |

## Reviewed story and credits control fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `EndingInitWriteOnlyFlag` | `$FFFF010E` | Ending initialization writes one; no reconstructed source reads the word, so its unknown downstream purpose is not invented. |
| `ScenePaletteFadeOffset` | `$FFFF0176` | Story and credits states step this signed value between zero and `$FFF2` and pass it to the shared palette-fade helper. |
| `CreditsSceneState` | `$FFFF017C` | The credits scene dispatcher uses this even word directly as its handler-table index. |
| `CreditsClearedSceneWord` | `$FFFF017E` | Initial scene setup clears this word, and no reconstructed source reads or otherwise writes it. |
| `StoryHBlankDelayCounter` | `$FFFF0186` | The story HBlank handler initializes it to `$10` and decrements it in a private busy-wait before changing the plane base. |
| `CreditsMasterCountdown` | `$FFFF0188` | The top-level credits dispatcher decrements it every frame; state changes and music cues compare fixed milestones. |
| `CreditsSceneDataCursor` | `$FFFF018A` | It starts at `Credits_SceneDataPointers`, supplies two pointers per normal scene, and advances by eight bytes. |
| `CreditsSceneTimer` | `$FFFF018E` | Scene states reload and count it down to pace loading, display, fades, and special scenes. |
| `CreditsPaletteTarget` | `$FFFF0190` | Normal scene loads copy palette data to this RAM pointer and alternate its destination by XORing `$40`. |
| `CreditsPaletteFadeIndex` | `$FFFF0194` | The ordered palette fade clears and advances this word as a byte offset into `Credits_PaletteFadeOrder`. |

## Reviewed cutscene pattern scratch fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `ShipPatternMaskBuffer` | `$FFFF0020` | Ship setup fills eight longwords here; dissolve selection updates one of the resulting sixteen mask words. |
| `PlanetPatternFillBuffer` | `$FFFF0040` | Planet reveal and erase paths repeat the selected mask word across this sixteen-word DMA source. |
| `ShipPatternFillBuffer` | `$FFFF0060` | Ship reveal and erase paths repeat the selected mask word across this sixteen-word DMA source. |
| `PlanetPatternRowBuffer` | `$FFFF0080` | The planet row composer writes sixteen words here and queues sixteen matching DMA records. |
| `ShipPatternRowBuffer` | `$FFFF00A0` | The ship row composer writes sixteen words here and queues sixteen matching DMA records. |
| `PlanetPatternWriteOnly` | `$FFFF00C4` | Several planet/frontend setup paths write `$000F`; no reconstructed source reads the word. |
| `ShipPatternWriteOnly` | `$FFFF00CE` | Both ship-grid setup paths write `$000F`; no reconstructed source reads the word. |

## Reviewed frame and RGB-adjust control fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `FrameFreezeTimer` | `$FFFF813C` | Impact/destruction paths load the timer; the gameplay loop decrements it and asserts the frame-control high bit while it remains nonnegative. |
| `FrameControlFlags` | `$FFFF813E` | The gameplay loop combines freeze and pause state here; a negative byte gates object, player, collision, palette, and message processing. |
| `PaletteRGBAdjustLevel` | `$FFFF8140` | The RGB-adjust routine converts this level to a component delta and reduces it by the configured step until zero. |
| `PaletteRGBChannelMask` | `$FFFF8142` | Bits five through seven independently enable the red, green, and blue computed deltas. |
| `PaletteRGBAdjustStep` | `$FFFF8143` | The RGB-adjust routine zero-extends this byte and subtracts it from the active level each update. |
| `PlayerModeFlags` | `$FFFF8144` | Player update uses bit one to clear the object and bits zero/two to select the two Seven Forces processing modes. |

## Reviewed wave, HUD, and enemy-spawn fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `WaveParameterIndex` | `$FFFF8102` | Wave routines use this even word to index parameter, step, and start-offset tables and move it in two-byte increments. |
| `WaveStateOffset` | `$FFFF8104` | The wave controller uses this byte offset to select a longword handler; states move it by four bytes. |
| `HUDDynamicStripTileAttr` | `$FFFF8110` | The HUD builder emits this word as the tile attribute of all six entries in the optional dynamic strip. |
| `HUDDynamicStripYOffset` | `$FFFF8112` | The HUD builder adds this signed word to the strip's base Y coordinate; Caterpillar and Viblack flows move or remove the strip through it. |
| `EnemySpawnDirectorState` | `$FFFF8114` | The enemy-spawn director uses this even word to select its idle, start, or timed-update handler. |
| `EnemySpawnDelayTimer` | `$FFFF8116` | The director counts down its low word and reloads it with a randomized `$20`--`$9F` delay; reset clears the containing longword. |

## Reviewed pickup and scripted-input fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `EnemySpawnClearedLongA` | `$FFFF811A` | The director reset clears this longword; reconstructed source has no other access, so its downstream purpose remains unknown. |
| `EnemySpawnClearedLongB` | `$FFFF811E` | The director reset clears this longword; reconstructed source has no other access, so its downstream purpose remains unknown. |
| `EnemySpawnClearedLongC` | `$FFFF8122` | The director reset clears this longword; reconstructed source has no other access, so its downstream purpose remains unknown. |
| `ActivePickupCountMinus1` | `$FFFF8126` | Collision-list construction starts at minus one and increments for each primary object with field-`$23` bit five; pickup creation sets that bit and enforces its cap through this value. |
| `ScriptedInputActive` | `$FFFF8138` | Script initializers set this word, completion and timeout paths clear it, and stage transitions wait for zero. |
| `ScriptedInputTimeout` | `$FFFF813A` | Script initializers load `$100` or `$200`; the per-frame scripted-input update decrements it and clears the active word after expiry. |

## Reviewed HUD, debug, and command-buffer fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `ColorFadePhase` | `$FFFF80EE` | The color-fade engine steps this word downward by five or advances its low phase modulo sixteen to derive RGB deltas. |
| `StageTimerFrameCounter` | `$FFFF8204` | Active gameplay reloads this byte to `$3B`; each expiry decrements the packed-BCD stage timer once. |
| `CombatPercentIndex` | `$FFFF8210` | Flagged hits copy the target damage-scale field here; the transient HUD halves it to index `CombatPercentDisplayTable`. |
| `DebugMenuStateOffset` | `$FFFF8226` | The debug dispatcher uses this even word as its handler-table byte offset. |
| `DebugSoundRequestId` | `$FFFF8228` | Debug controls edit and render its low byte, which the dormant handler can submit as a sound request. |
| `ResultsTimeBonusBCD` | `$FFFF822C` | Results preserves the masked stage time here and renders its four packed-BCD digits. |
| `StageNumberBCD` | `$FFFF8232` | The stage-index conversion writes a packed-BCD stage number that the message renderer splits into two digits. |
| `ContactDamageCooldown` | `$FFFF825D` | Hostile collision permits contact damage only after this signed byte expires; cutscene exit reloads `$30`. |
| `StageAssetCommandBuffer` | `$FFFF82A0` | The stage loader expands compact commands into terminated eight-byte load records beginning here. |
| `LowTimeWarningTimer` | `$FFFF8306` | Below time `$30`, expiry reloads `$26`, plays the warning sound, and blanks the displayed timer for that frame. |
| `WeaponIconDMABuffer` | `$FFFF8478` | VBlank submits the complete 16-byte weapon-icon VDP command block from this address. |
| `WeaponIconDMABufferEnd` | `$FFFF8488` | Weapon-icon setup predecrements from this exclusive end while constructing the command block. |

## Reviewed stage enemy tile-attribute slots

`Stage_ExpandAndSubmitTileAssetCommands` writes these seven consecutive words
from compact command indices `$00` through `$0C`. Each consumer combines the
loaded tile base with the active palette or orientation bits.

| Symbol | Address | Static consumer |
|---|---:|---|
| `SpawnedEnemyTileAttr` | `$FFFF826E` | Shared spawned-enemy setup. |
| `StandardEnemyTileAttr` | `$FFFF8270` | Standard enemy sprite setup. |
| `EnemyProjectileTileAttr` | `$FFFF8272` | Shared enemy-projectile setup. |
| `BirdEnemyTileAttr` | `$FFFF8274` | Bird-family setup. |
| `PhaseEnemyTileAttr` | `$FFFF8276` | Phase-pattern enemy setup. |
| `Stage10WaspTileAttr` | `$FFFF8278` | Stage 10 wasp setup. |
| `CirclingEnemyTileAttr` | `$FFFF827A` | Circling-enemy and Stage 9 fly setup. |

## Reviewed player targeting and health-feedback fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `StatusDisplayModeOffset` | `$FFFF820C` | The dormant status-display dispatcher uses this even word as its four-entry handler-table offset; transitions clear it. |
| `DebugResourceRefill` | `$FFFF822A` | Debug health selection `$FF` enables this word; collision update then restores maximum health and time `$5000`. |
| `WeaponFireCooldown` | `$FFFF8238` | Fire handlers require a negative value and load weapon-specific delays; weapon update counts it down. |
| `PlayerCenterX` | `$FFFF8248` | Player update computes hitbox midpoint plus object X; targeting code consumes the result. |
| `PlayerCenterY` | `$FFFF824A` | Player update computes hitbox midpoint plus object Y; targeting code consumes the result. |
| `HealthDeltaDisplayValue` | `$FFFF8262` | Damage sets bit 15 and pickups leave it clear; renderers consume the sign and lower three decimal digits. |
| `TransientValueScreenX` | `$FFFF8264` | Transient-value rendering uses this as the first digit X and advances by eight; its source writer is not reconstructed. |
| `TransientValueScreenY` | `$FFFF8266` | Rendering moves this Y upward every other frame and clamps it at `$A0`. |
| `HealthDeltaDisplayTimer` | `$FFFF8268` | Damage and pickups load `$30`; it paces HUD health convergence and expires the transient value. |

## Reviewed HUD DMA and debug tile buffers

Each DMA buffer is exactly 16 bytes: its producer predecrements from the
adjacent tile-buffer start, and VBlank consumes three longwords plus two words.
The weapon and boss tile regions are reused by the two debug pages.

| Symbol | Address | Static evidence |
|---|---:|---|
| `PrimaryHUDDMABuffer` | `$FFFF84A0` | Primary HUD transfer command block. |
| `PrimaryHUDTileBuffer` | `$FFFF84B0` | Player-health and score tile words. |
| `WeaponDebugDMABuffer` | `$FFFF8500` | Weapon HUD or primary-debug transfer command block. |
| `WeaponDebugTileBuffer` | `$FFFF8510` | Weapon HUD and primary-debug tile words. |
| `DebugHealthCursorTile` | `$FFFF8512` | Blinking health-selection cursor. |
| `DebugHealthHighTile` | `$FFFF851E` | Health selection high hexadecimal digit. |
| `DebugHealthLowTile` | `$FFFF8520` | Health selection low hexadecimal digit. |
| `BossClearCursorTile` | `$FFFF8522` | Blinking boss-clear cursor. |
| `PaletteEntryCursorTile` | `$FFFF8532` | Palette-entry cursor when channel edit is inactive. |
| `PalettePreviewBuffer` | `$FFFF8534` | Sixteen-word selected palette preview. |
| `ColorEditCursorTile` | `$FFFF8554` | Palette-channel cursor while color edit is active. |
| `BossDebugDMABuffer` | `$FFFF8560` | Boss HUD or secondary-debug transfer command block. |
| `BossDebugTileBuffer` | `$FFFF8570` | Boss HUD and secondary-debug tile words. |
| `DebugSoundCursorTile` | `$FFFF8572` | Blinking sound-request cursor. |
| `DebugSoundHighTile` | `$FFFF857E` | Sound request high hexadecimal digit. |
| `DebugSoundLowTile` | `$FFFF8580` | Sound request low hexadecimal digit. |
| `PaletteLineCursorTile` | `$FFFF8582` | Blinking palette-line cursor. |
| `PaletteLineNumberTile` | `$FFFF858A` | Selected palette-line digit. |
| `StageTimerTileBuffer` | `$FFFF85A8` | Stage timer portion of the boss/status tile row. |
| `DebugColorRedTile` | `$FFFF85B6` | Selected color red-component digit. |
| `DebugColorGreenTile` | `$FFFF85B8` | Selected color green-component digit. |
| `DebugColorBlueTile` | `$FFFF85BA` | Selected color blue-component digit. |

## Reviewed player input, scripted movement, and scroll fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `PlayerInputMask` | `$FFFF830F` | The input reader ANDs both held and pressed controller bytes with this mask; player states select `$7F`, dash/Phoenix states `$73`, and teleport states `$70`. |
| `ScrollPlaneBufferOffset` | `$FFFF8640` | Scroll preparation uses this word to select alternate VDP plane bases and offsets both horizontal and vertical buffer pairs; Sunset Sting sets it to two and clears it on exit. |
| `TargetReticleScanDelay` | `$FFFF8642` | Targeting update decrements the word before each scan, clears it while scanning, and reloads `$80` after a complete pass finds no eligible target. |
| `ScriptedInputStepTimer` | `$FFFF8644` | Scripted-input states load or copy this timer and count it down before advancing delayed run, input-hold, and Xi-Tiger intro steps. |
| `ScriptedInputTargetX` | `$FFFF8646` | Post-boss and Flying Neo sequences load fixed world-X destinations and compare them with the computed scripted player position. |
| `ScriptedInputDelay` | `$FFFF8648` | Post-boss runs load `$16` and copy it into the step timer; Flying Neo entry reuses the word as a direct `$0E`-tick vertical-motion delay. |
| `ScriptedPlayerWorldX` | `$FFFF8652` | The scripted-input dispatcher adds the camera X coordinate to the player's screen X every update; movement states compare this world position with their target. |

## Reviewed collision pointer lists

`Collision_BuildEntityLists` initializes every count to minus one and appends
16-bit object pointers to five adjacent `$80`-byte lists. Consumers load the
corresponding count into a `DBF` loop, so the stored values are explicitly
`count - 1` rather than ordinary counts.

| Symbol | Address | Static evidence |
|---|---:|---|
| `PrimaryListCountMinus1` | `$FFFF8D76` | Incremented for each alternating-frame primary collision entry and consumed with `PrimaryCollisionList`. |
| `TargetListCountMinus1` | `$FFFF8D78` | Incremented for entities carrying either target flag and consumed with `CollisionTargetList`. |
| `LockOnListCountMinus1` | `$FFFF8D7A` | Incremented for the lock-on subset and consumed by weapon targeting with `LockOnTargetList`. |
| `PlatformListCountMinus1` | `$FFFF8D7C` | Incremented for objects carrying the moving-platform flag and consumed with `MovingPlatformList`. |
| `WeaponListCountMinus1` | `$FFFF8D7E` | Incremented for objects carrying the player-weapon collision flag and consumed with `PlayerWeaponList`. |
| `PrimaryCollisionList` | `$FFFF8D80` | Pointer list used by player-hostile and special-attack collision scans. |
| `CollisionTargetList` | `$FFFF8E00` | Pointer list used by player-weapon, special-attack, and target-selection scans. |
| `LockOnTargetList` | `$FFFF8E80` | Subset of collision targets carrying flag bit four; targeting code scans it for lock-on objects. |
| `MovingPlatformList` | `$FFFF8F00` | Pointer list whose entries have cached previous/current positions for player-platform collision. |
| `PlayerWeaponList` | `$FFFF8F80` | Pointer list used as the weapon side of player-weapon-versus-enemy collision. |

## Reviewed sprite and scroll scratch fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `PlayerSpritePieceBuffer` | `$FFFF8780` | Player composite rendering expands primary and secondary frame streams into this buffer and publishes its address through the player object's sprite-piece pointer. |
| `HorizontalScrollProfile` | `$FFFF8800` | Stage-specific producers fill horizontal line/cell values here; the scroll writer copies this profile into alternating horizontal-scroll output words. |
| `VerticalScrollProfile` | `$FFFF8A00` | Caterpillar, Viblack, and Epsilon 1 build twenty-word profiles from this base; the vertical scroll writer copies exactly twenty consecutive words into its output column. |
| `MidgameParallaxValue0` | `$FFFF8A04` | Stage 8 subtracts `$41` from the first of four cyclic parallax values. |
| `MidgameParallaxValue1` | `$FFFF8A08` | Stage 8 subtracts a randomized value from `$08` through `$0F` from the second cyclic parallax value. |
| `MidgameParallaxValue2` | `$FFFF8A0C` | Stage 8 subtracts `$10` from the third cyclic parallax value. |
| `MidgameParallaxValue3` | `$FFFF8A10` | Stage 8 subtracts `$13` from the fourth cyclic parallax value. |

The four midgame words are stage-specific overlays inside the shared vertical
profile scratch region. The frame counter rotates their order and the producer
repeats the resulting four-word group into `HorizontalScrollProfile`.

## Reviewed encounter raster, timing, and trail fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `GameOverRasterBuffer` | `$FFFF9000` | The Game Over perspective projector writes four interleaved words per row from this base; the raster-layout copier expands fourteen 64-byte blocks into `HScrollBuffer`. |
| `Epsilon1ProximityTimer` | `$FFFF9472` | Epsilon 1 increments this word while the player remains within twelve pixels and the proximity flag is clear; difficulty selects a `$40` or `$80` threshold. |
| `Epsilon1ProximityFlag` | `$FFFF9474` | The proximity threshold sets this word; it changes attack selection and terminates ring repetitions until battle-center recovery clears it. |
| `Epsilon1VerticalAccel` | `$FFFF9478` | Epsilon 1 attack states load signed acceleration values here, and the shared motion helper adds the longword to the boss vertical velocity. |
| `ShieldViperTrailAngles` | `$FFFF94A0` | Shield Viper initializes and shifts angle-history words from this base, then applies or interpolates them across linked body records. |

## Reviewed screen-shake and player-script fields

The shake update owns a level and current offset for each scroll plane. Both
offsets feed the plane scroll builders; the Plane A offset additionally becomes
the Y compensation applied to world sprites so foreground sprites remain
aligned with the shaken plane.

| Symbol | Address | Static evidence |
|---|---:|---|
| `SpriteShakeYOffset` | `$FFFF8086` | Each update copies `PlaneAShakeOffset` here; every world-sprite renderer subtracts the value from its OAM Y coordinate. |
| `PlaneBShakeWriteOnly` | `$FFFF8088` | Each update copies `PlaneBShakeOffset` here, but reconstructed source contains no reader, so no downstream purpose is claimed. |
| `PlaneAShakeLevel` | `$FFFFA010` | Impact and explosion paths load a small level; the shake updater decrements it every eight frames and publishes it as the Plane A offset. |
| `PlaneAShakeOffset` | `$FFFFA012` | The updater derives this offset from the Plane A level; Plane A horizontal/vertical scroll, HBlank effects, and sprite Y compensation consume it. |
| `PlaneBShakeLevel` | `$FFFFA014` | Impact and explosion paths load a small level; the shake updater decrements it every eight frames and publishes it as the Plane B offset. |
| `PlaneBShakeOffset` | `$FFFFA016` | The updater derives this offset from the Plane B level; Plane B horizontal and vertical scroll consumers apply it. |
| `PlayerScriptStateOffset` | `$FFFFA02A` | The player scripted-input dispatcher uses this even word as its handler-table offset; cutscene states select offsets and completion paths clear it. |

## Reviewed global gameplay and stage-route fields

`GameplayStateBlock` is a structural start alias rather than a standalone
longword value. Full-game initialization clears 128 bytes from this address,
covering the adjacent stage, score, health, weapon, and route state.

| Symbol | Address | Static evidence |
|---|---:|---|
| `GameplayStateBlock` | `$FFFFA200` | `Sys_ClearGameplayStateBlock` clears eight groups of four longwords from this base, establishing the 128-byte block extent. |
| `StageProcessTableOffset` | `$FFFFA206` | Stage loaders select offsets `$00`, `$04`, `$08`, or `$0C`; the gameplay dispatcher uses the value to index the longword `Stage_ProcessHandlerTable`. |
| `StageRouteFlags` | `$FFFFA209` | Bit 0 is set by password/transition entry and tested by Stage 9 and Stage 12 route logic; bit 1 is set by post-stage entry and consumed by the boss-message initializer. |
| `StageObjectSpawnCursor` | `$FFFFA20E` | Configuration records load a spawn-list pointer; the spawner advances it over 12-byte records, while the sign bit suspends list processing. |

## Reviewed weapon loadout and ammunition fields

The four weapon slots use parallel word arrays. `WeaponSlotOffset` takes the
values 0, 2, 4, or 6 and selects the same slot in each array. The first array
stores the setup-screen configuration code; the following arrays hold a
regeneration delay, current ammunition, and maximum ammunition.

| Symbol | Address | Static evidence |
|---|---:|---|
| `WeaponSlotConfig0` | `$FFFFA250` | First setup configuration word; HUD, firing, selection, and regeneration consumers select it with slot offset zero. |
| `WeaponSlotConfig1` | `$FFFFA252` | Second setup configuration word selected with slot offset two. |
| `WeaponSlotConfig2` | `$FFFFA254` | Third setup configuration word selected with slot offset four. |
| `WeaponSlotConfig3` | `$FFFFA256` | Fourth setup configuration word selected with slot offset six. |
| `WeaponAmmoRegenTimers` | `$FFFFA258` | Base of four word timers; stage initialization clears them and the regeneration loop decrements and reloads each timer. |
| `WeaponSlotAmmo0` | `$FFFFA260` | First current-ammunition word; firing subtracts costs and inactive-slot regeneration adds two up to the paired maximum. |
| `WeaponSlotAmmo1` | `$FFFFA262` | Second current-ammunition word. |
| `WeaponSlotAmmo2` | `$FFFFA264` | Third current-ammunition word. |
| `WeaponSlotAmmo3` | `$FFFFA266` | Fourth current-ammunition word. |
| `WeaponSlotAmmoMax0` | `$FFFFA268` | First regeneration ceiling and stage-entry source for `WeaponSlotAmmo0`. |
| `WeaponSlotAmmoMax1` | `$FFFFA26A` | Second regeneration ceiling and stage-entry source for `WeaponSlotAmmo1`. |
| `WeaponSlotAmmoMax2` | `$FFFFA26C` | Third regeneration ceiling and stage-entry source for `WeaponSlotAmmo2`. |
| `WeaponSlotAmmoMax3` | `$FFFFA26E` | Fourth regeneration ceiling and stage-entry source for `WeaponSlotAmmo3`. |

The previously generated “slot animation” names were incorrect. The loop
does not touch sprite-frame state: it reloads a delay from the configuration-
indexed `Weapon_AmmoRegenStepDelays`, increments current ammunition by two,
and clamps it to the slot maximum.

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
