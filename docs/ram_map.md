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

The active palette aliases use zero-padded decimal CRAM indices. Full-word
aliases name a 12-bit Genesis color; byte aliases explicitly name only the
high-byte view used by byte-oriented code.

| Symbols | Buffer positions | Static evidence |
|---|---|---|
| `PaletteActiveColorNN` for indices 01, 02, 03, 06, 08, 10, 11, 12, 14--16, 18--22, 29--34, 46, 48--52, 54, and 59--63 | Corresponding word indices in `$FFFFE300-$FFFFE37F` | Their addresses are aligned entries inside the 64-word active palette image; palette fades, frontend code, cutscenes, and bosses read or write them as Genesis colors. |
| `PaletteActiveColor17Hi`, `PaletteActiveColor41Hi`, `PaletteActiveColor56Hi`, `PaletteActiveColor58Hi` | High bytes of active colors 17, 41, 56, and 58 | These aliases expose only one byte of the corresponding active CRAM word and therefore do not claim a full-color access. |
| `PaletteShadowColorNN` for indices 01, 03, 20--22, 29, 30, 49, 50, 54, and 61--63 | Corresponding word indices in `$FFFFE380-$FFFFE3FF` | These aligned entries belong to the stable shadow palette image used as a fade source and mirrored color store. |
| `PaletteShadowPair16`, `PaletteShadowPair33`, `PaletteShadowPair41`, `PaletteShadowPair47`, and `PaletteShadowColor32Hi` | Two-color pairs beginning at indices 16, 33, 41, and 47, plus the high byte of color 32 | The access widths are retained explicitly: longword users span two adjacent CRAM colors, while the byte alias exposes only one component byte. |

The visible H-scroll table stores one Plane A word followed by one Plane B word
per scanline. Row numbers in the aliases below are decimal. Several imported
`byte_*` names are intentionally replaced by word-row names because every live
consumer uses the even address as a word-aligned destination.

| Symbols | Workspace positions | Static evidence |
|---|---|---|
| `HScrollPlaneBRow0`, `HScrollPlaneBRow2`, `HScrollPlaneBRow4`, `HScrollPlaneBRow32`, `HScrollPlaneBRow104`, `HScrollPlaneBRow112`, `HScrollPlaneBRow128` | Plane B word of the stated visible-table row | Scroll writers advance by four bytes per row; VBlank and effect code consume the interleaved Plane A/Plane B layout. |
| `HScrollPlaneARow32`, `HScrollPlaneARow72`, `HScrollPlaneARow75`, `HScrollPlaneARow96`, `HScrollPlaneARow104`, `HScrollPlaneARow112`, `HScrollPlaneARow184`, `HScrollPlaneARow200` | Plane A word of the stated visible-table row | Stage, cutscene, and boss raster builders use these aligned row anchors and preserve the four-byte row stride. |
| `HScrollAuxBuffer` | `$FFFFE800`, second half of the 2,048-byte H-scroll workspace | The Seven Forces diagnostic builds a second scroll table here; the normal 448-word H-scroll DMA begins at `HScrollBuffer`, so this name does not claim that the auxiliary half is directly displayed. |

The first half of `VScrollBuffer` mirrors the Mega Drive VSRAM column-scroll
layout: twenty screen columns, each containing a Plane A word followed by a
Plane B word. Column numbers below are decimal. Imported byte aliases at
columns 4 and at the auxiliary-half boundary are replaced according to the
word accesses made by their live consumers.

| Symbols | Workspace positions | Static evidence |
|---|---|---|
| `VScrollPlaneAColumn1`--`VScrollPlaneAColumn19`, for the represented columns | Plane A word of the stated VSRAM column | Cutscene, transition, and boss writers address same-plane values with a four-byte column stride. |
| `VScrollPlaneBColumn0`, `VScrollPlaneBColumn4`, `VScrollPlaneBColumn8`, `VScrollPlaneBColumn9`, `VScrollPlaneBColumn10` | Plane B word of the stated VSRAM column | VBlank and scroll writers address these words two bytes after their corresponding Plane A position. |
| `VScrollAuxBuffer` | `$FFFFEC50`, second half of the 160-byte V-scroll workspace | The Seven Forces diagnostic constructs a mirrored secondary table here; normal V-scroll DMA begins at `VScrollBuffer`. |
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
| `VBlankUpdateReady` | `$FFFFF704` | Reset sets this byte before enabling interrupts; the extended VBlank path requires it, clears it around transfers/input/timer work, and restores it before returning. |
| `VDPQueueStagingBoundary` | `$FFFFF400` | Initialization resets both VDP queue cursors to this pivot; 16-byte command records grow downward, staged payload grows upward, and VBlank finishes traversal back at this address. |
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

## Reviewed visible-object list

The list at `$FFFFED00` contains 16-bit low-address pointers to active object
records. Producers append one pointer at a time; rendering and camera-motion
passes consume the resulting count.

| Symbol | Address | Static evidence |
|---|---:|---|
| `VisibleObjectList` | `$FFFFED00` | Object and projectile scanners append 16-bit record pointers here; sprite rendering and camera-relative motion iterate the same base. |
| `VisibleObjectListCursor` | `$FFFFF758` | The begin routine initializes this word to `$ED00`; each accepted object advances it by two before the count is derived. |
| `VisibleObjectCount` | `$FFFFF75A` | The finalizer computes `(cursor - $ED00) / 2`; rendering and camera-motion loops use the result as their entry count. |

## Reviewed VBlank sound scheduling

| Symbol | Address | Static evidence |
|---|---:|---|
| `SoundUpdateBusy` | `$FFFFF745` | The VBlank event handler skips a nested sound update while this byte is nonzero and brackets `Sound_UpdateThunk` by setting and clearing it. |
| `VBlankSoundRequestDelay` | `$FFFFF762` | While nonzero, the VBlank event handler decrements this word and defers processing the pending sound-request byte. |
| `VBlankPendingSound` | `$FFFFF764` | When the delay is zero, VBlank passes this byte to `Sound_QueueRequest` and clears it only after the request is accepted. |

## Reviewed sound-driver global state

The driver stores 48-byte playback records consecutively from `$FFF840`.
Names for sparse absolute aliases use the statically proven record family and
zero-based index; they do not claim a musical voice identity.

| Symbol | Address | Static evidence |
|---|---:|---|
| `SoundCurrentPriority` | `$FFFFF800` | Request selection compares queued priorities with this byte, updates it for the accepted request, and clears it when ordinary SFX playback stops. |
| `SoundTempoCounter` | `$FFFFF801` | Tempo processing decrements this byte and reloads it from `SoundTempoReload` on expiry. |
| `SoundTempoReload` | `$FFFFF802` | BGM headers and sequence command `$EA` install this value; each tempo expiry copies it to `SoundTempoCounter`. |
| `SoundCommunicationByte` | `$FFFFF803` | Sequence command `$E2` copies its single parameter here; no reconstructed reader proves a narrower communication endpoint. |
| `SoundFadeStepsRemaining` | `$FFFFF804` | Music fade-out initializes this byte to 40 and consumes one step every time the tick counter expires. |
| `SoundFadeTickCounter` | `$FFFFF806` | Fade-out initializes and reloads this byte to three, decrementing it between volume steps. |
| `SoundPauseState` | `$FFFFF807` | VBlank posts pause/resume values; the sound update consumes them and uses `$FF` as the stable paused state. |
| `SoundPCMEventFlag` | `$FFFFF808` | The driver clears this byte before FM processing and sets bit 7 after decoding a PCM sequence event; stopped-channel handling tests that bit. |
| `SoundSelectedRequest` | `$FFFFF809` | Priority selection stores the winning sound ID here; dispatch consumes it and restores the empty `$FF` sentinel. |
| `SoundRequestQueue` | `$FFFFF80A` | `Sound_QueueRequest` fills four consecutive request bytes and the driver priority scan consumes the same four slots. |
| `SoundChannelGroupFlags` | `$FFFFF80E` | The update loop publishes zero for BGM, `$80` for ordinary SFX, and `$40` for special SFX while shared sequence handlers run. |
| `SoundFM3SpecialMode` | `$FFFFF80F` | The FM3 special-mode command sets this byte; frequency and stopped-channel paths use it to select operator-frequency handling. |
| `SoundBGMFM3Offsets` | `$FFFFF810` | Four words hold BGM FM3 operator frequency offsets selected when `SoundChannelGroupFlags` is zero. |
| `SoundSFXFM3Offsets` | `$FFFFF818` | Four words hold the corresponding non-BGM FM3 operator offsets. |
| `SoundBGMDataPtr` | `$FFFFF820` | BGM initialization resolves this pointer from the selected header; shared LFO and instrument handlers reload it as BGM data. |
| `SoundSpecialSFXDataPtr` | `$FFFFF824` | Special-SFX loading resolves this pointer; shared instrument and channel-restoration paths use it for the dedicated records. |
| `SoundManualVolumeState` | `$FFFFF828` | Extended commands request attenuation or restoration through this byte; the volume-transition state machine consumes those states. |
| `SoundFMVolumeStep` | `$FFFFF829` | Manual or voice-DAC ducking setup stores the FM attenuation step consumed by all active BGM FM records. |
| `SoundPSGVolumeStep` | `$FFFFF82A` | The matching PSG attenuation step is applied to all active BGM PSG records. |
| `SoundVoiceDuckingState` | `$FFFFF82B` | Voice-DAC launch and Z80 status transitions advance this byte through pending, active, and released ducking states. |
| `SoundVoiceSlotToggle` | `$FFFFF82C` | Voice-DAC allocation tests, sets, or clears bit zero while choosing between the two Z80 playback slots. |
| `SoundPCMChannelRecord` | `$FFFFF840` | The main update treats this 48-byte record as the BGM PCM sequence channel before advancing to FM records. |
| `SoundBGMFMChannels` | `$FFFFF870` | This is the first of six consecutive 48-byte BGM FM records processed by update, fade, and volume-transition loops. |
| `SoundBGMFMChannel3` | `$FFFFF900` | This sparse alias is BGM FM record index three; dedicated special FM SFX marks and restores its override flags. |
| `SoundBGMPSGChannels` | `$FFFFF990` | This is the first of three consecutive 48-byte BGM PSG records initialized and processed after the FM range. |
| `SoundBGMPSGChannel2` | `$FFFFF9F0` | This sparse alias is BGM PSG record index two; the dedicated special PSG channel overrides and restores it. |
| `SoundSFXFMChannels` | `$FFFFFA20` | This is the first of three consecutive 48-byte ordinary SFX FM records. |
| `SoundSFXFMChannel1` | `$FFFFFA50` | This sparse alias is ordinary SFX FM record index one and is checked when special SFX ownership changes. |
| `SoundSFXPSGChannel2` | `$FFFFFB10` | This sparse alias is ordinary SFX PSG record index two and is checked when special PSG ownership changes. |
| `SoundSpecialSFXFM` | `$FFFFFB40` | Dedicated special-SFX loading, playback, stop, and restoration paths use this 48-byte FM record. |
| `SoundSpecialSFXPSG` | `$FFFFFB70` | The matching dedicated 48-byte PSG record is selected for negative channel types. |
| `SoundFMShadowIndexBase` | `$FFFFFBA0` | YM2612 writers add register numbers `$40-$4F` to this adjusted base to address the port-zero total-level shadows. |
| `SoundFMPort1IndexBase` | `$FFFFFBB0` | Its offset from `SoundFMShadowIndexBase` selects the parallel port-one total-level shadows. |
| `SoundFMLevelShadows` | `$FFFFFBE0` | The resulting 32-byte region stores both ports' operator total-level values and is saved across pause muting. |
| `SoundFMShadowsEnd` | `$FFFFFC00` | Pause handling uses this exclusive end address while restoring the 32-byte shadow region backward. |

## Reviewed Z80 RAM exchange fields

The 68000 accesses these bytes only while holding the Z80 bus. Slot A and B
store parallel voice-DAC records. Unknown DPCM header members remain numbered
by their verified byte order rather than receiving invented codec meanings.

| Symbol | Address | Static evidence |
|---|---:|---|
| `PauseMenuZ80SpriteData` | `$A00C00` | The pause renderer submits this fixed Z80-RAM address as one of its two sprite-data sources. |
| `Z80DriverBusy` | `$A01F2A` | YM2612 and pause paths poll this byte under bus ownership and retry while it is nonzero. |
| `Z80VoiceSlotADesc0` | `$A01F80` | Voice-slot setup copies descriptor byte zero to the first byte of slot A. |
| `Z80VoiceSlotADesc1` | `$A01F81` | Voice-slot setup copies descriptor byte one to the second byte of slot A. |
| `Z80VoiceSlotAHeader0` | `$A01F82` | Slot A receives byte zero of the four-byte DPCM sample header here. |
| `Z80VoiceSlotAHeader1` | `$A01F83` | Slot A receives byte one of the DPCM sample header here. |
| `Z80VoiceSlotAHeader2` | `$A01F84` | Slot A receives byte two of the DPCM sample header here. |
| `Z80VoiceSlotAHeader3` | `$A01F85` | Slot A receives byte three of the DPCM sample header here. |
| `Z80VoiceSlotAActive` | `$A01F86` | The 68000 writes `$80` when publishing slot A and later reads the byte to test availability. |
| `Z80VoiceSlotAFlags` | `$A01F87` | Descriptor byte five is copied here; selection compares its upper priority bits with new requests. |
| `Z80VoiceSlotBDesc0` | `$A01FA0` | Voice-slot setup copies descriptor byte zero to the first byte of slot B. |
| `Z80VoiceSlotBDesc1` | `$A01FA1` | Voice-slot setup copies descriptor byte one to the second byte of slot B. |
| `Z80VoiceSlotBHeader0` | `$A01FA2` | Slot B receives byte zero of the four-byte DPCM sample header here. |
| `Z80VoiceSlotBHeader1` | `$A01FA3` | Slot B receives byte one of the DPCM sample header here. |
| `Z80VoiceSlotBHeader2` | `$A01FA4` | Slot B receives byte two of the DPCM sample header here. |
| `Z80VoiceSlotBHeader3` | `$A01FA5` | Slot B receives byte three of the DPCM sample header here. |
| `Z80VoiceSlotBActive` | `$A01FA6` | The 68000 writes `$80` when publishing slot B and later reads the byte to test availability. |
| `Z80VoiceSlotBFlags` | `$A01FA7` | Descriptor byte five is copied here; selection compares its upper priority bits with new requests. |
| `Z80DACCommandByte2` | `$A01FE6` | Immediate PCM and voice paths copy logical descriptor byte two to this mailbox position. |
| `Z80DACCommandByte3` | `$A01FE7` | Immediate PCM and voice paths copy logical descriptor byte three to this mailbox position. |
| `Z80DACCommandByte0` | `$A01FE8` | Immediate PCM and voice paths copy logical descriptor byte zero to this mailbox position. |
| `Z80DACCommandByte1` | `$A01FE9` | Immediate PCM and voice paths copy logical descriptor byte one to this mailbox position. |
| `Z80DACPanningUpdate` | `$A01FF8` | Active DAC pan changes are written here only when the Z80 request-state byte permits the update. |
| `Z80DACPanning` | `$A01FF9` | PCM submission publishes channel panning here; resume logic reads it back for YM2612 restoration. |
| `Z80DACCommandByte6` | `$A01FFA` | Immediate requests copy descriptor byte six here; slot requests publish the fixed `$C0` control value. |
| `Z80DACCommandByte5` | `$A01FFB` | PCM and voice submissions copy logical descriptor byte five to this shared mailbox byte. |
| `Z80DACStatus` | `$A01FFC` | Selection and ducking paths read its active-slot, priority, and voice-active status bits under bus ownership. |
| `Z80DACRequestState` | `$A01FFD` | PCM writes one and voice requests write `$80`; later paths test zero/sign before replacing data or panning. |
| `Z80DACCommandByte4` | `$A01FFE` | Immediate requests copy descriptor byte four here; slot-preemption setup may instead publish `$80`. |
| `Z80VBlankActive` | `$A01FFF` | The interrupt path sets this byte after acquiring the Z80 bus and clears it before releasing the VBlank-side bus window. |

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

## Reviewed data-loader state

| Symbol | Address | Static evidence |
|---|---:|---|
| `DataLoaderControl` | `$FFFFF720` | Descriptor setup stores the handler selector with bit 15 set; the dispatcher selects a loader from it, clears it at the terminator, and clients test its sign bit as the busy state. |
| `DataLoaderLength` | `$FFFFF722` | Descriptor parsing stores the transfer or decode length here; copy, DMA, and decompression handlers consume it as their remaining word or block count. |
| `DataLoaderRecordPtr` | `$FFFFF724` | Descriptor setup saves the cursor for the next record; the dispatcher reloads it before processing subsequent work. |
| `DataLoaderSourcePtr` | `$FFFFF728` | Descriptor parsing stores the source pointer here and every copy or decompression handler reloads it as the source. |
| `DataLoaderDestination` | `$FFFFF72C` | Descriptor parsing stores the target address here; RAM-copy, DMA, and decompression handlers reload it as their destination. |
| `DataLoaderCodecState` | `$FFFFF730` | Tile decoding uses the two halves as bit count and bit buffer, while LZSS loading stores its source-end pointer in the same longword; the union name avoids claiming one incompatible role. |

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

## Reviewed timer-control fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `StageTimerPauseFlag` | `$FFFFA272` | Bit 0 suppresses the stage-time decrement and low-time warning; boss/transition paths set it and STAGE/FIGHT message paths clear it. |
| `VBlankCountdown` | `$FFFFA282` | Decremented once per VBlank while nonzero; no reconstructed writer or completion consumer proves a narrower role. |

## Reviewed player-object header and motion fields

The object record beginning at `$FFFFA400` is the live player object. Its first
word is type `$0008`; the following fields use the same offsets as the shared
object update and rendering machinery.

| Symbol | Address | Static evidence |
|---|---:|---|
| `PlayerObjectType` | `$FFFFA400` | Player initialization writes type `$0008`; disabling player processing clears this word and the adjacent flags. |
| `PlayerObjectFlags` | `$FFFFA402` | Initialized to `$4D00`; update, renderer, camera, and cutscene paths manipulate individual control/display bits. |
| `PlayerStateOffset` | `$FFFFA404` | Even values select the player state dispatcher; initialization clears it and transitions install later states. |
| `PlayerSpriteMapping` | `$FFFFA408` | Player rendering consumes the pointer, the secondary-object copier preserves it, and the motion-projectile path compares it with the teleport-dash mapping. |
| `PlayerAnimationTimer` | `$FFFFA40C` | Animation paths count it down and reload frame delays; state setup commonly primes it with `$FFFF`. |
| `PlayerSpriteAttributes` | `$FFFFA40E` | Initialized to `$4DC0`; facing, rendering, and cutscene paths manipulate its attribute bits. |
| `PlayerXPosition` | `$FFFFA410` | Signed 16.16 world X coordinate consumed by camera, targeting, enemies, bosses, and projectile placement. |
| `PlayerYPosition` | `$FFFFA414` | Signed 16.16 world Y coordinate consumed by camera, targeting, bosses, and projectile placement. |
| `PlayerXVelocity` | `$FFFFA418` | Signed 16.16 horizontal velocity integrated into the X position by shared physics. |
| `PlayerYVelocity` | `$FFFFA41C` | Signed 16.16 vertical velocity integrated into the Y position by shared physics. |
| `PlayerInvulnTimer` | `$FFFFA45E` | Counted down by the player invulnerability/flash updater; initialization and damage/death transitions install positive durations. |

The overlapping byte at `$FFFFA407` and the following field at `$FFFFA420`
remain address-derived. Their references establish control bits and propagated
values, but not yet a stable shared meaning.

## Reviewed controller-input fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `ControllerHeldState` | `$FFFFF706` | Two bytes hold the current active-high button masks for controller ports one and two. |
| `ControllerPressedState` | `$FFFFF708` | Per-port `current AND (previous XOR current)` values identify newly pressed buttons. |
| `ControllerReleasedState` | `$FFFFF70A` | Per-port `previous AND (previous XOR current)` values identify newly released buttons. |
| `PlayerPressedInput` | `$FFFFA46A` | Player input copies and masks the first pressed-state byte here; scripted input can synthesize the same field. |

## Reviewed primary-camera fields

| Symbol | Address | Static evidence |
|---|---:|---|
| `PrimaryCameraXPosition` | `$FFFFA900` | Signed 16.16 X coordinate updated by horizontal follow and stage-scroll paths and consumed by primary tilemap streaming. |
| `PrimaryCameraYPosition` | `$FFFFA904` | Signed 16.16 Y coordinate updated by vertical camera/stage paths and consumed by primary tilemap streaming. |
| `SecondaryCameraXPos` | `$FFFFA908` | Signed 16.16 secondary-camera X coordinate consumed by secondary tilemap streaming and Plane B horizontal scroll generation. |
| `SecondaryCameraYPos` | `$FFFFA90C` | Signed 16.16 secondary-camera Y coordinate consumed by secondary tilemap streaming and Plane B vertical scroll generation. |
| `CameraXDelta` | `$FFFFA910` | Current primary-camera X minus its previous-frame snapshot; applied to camera-relative objects and secondary scrolling. |
| `CameraYDelta` | `$FFFFA914` | Current primary-camera Y minus its previous-frame snapshot; applied to camera-relative objects. |
| `Stage9RasterScrollPhase` | `$FFFFA918` | Stage 9 advances this 16.16 phase by `$8000`, combines it with secondary-camera X, and emits the high word across its raster rows. |
| `StageCameraYVelocity` | `$FFFFA91C` | Signed 16.16 velocity integrated into primary-camera Y by the Caterpillar bounce path; Xi-Tiger landing paths load its initial upward impulse. |
| `PreviousCameraXPosition` | `$FFFFA928` | Previous high word of `PrimaryCameraXPosition`, refreshed after deriving `CameraXDelta`. |
| `PreviousCameraYPosition` | `$FFFFA92C` | Previous high word of `PrimaryCameraYPosition`, refreshed after deriving `CameraYDelta`. |
| `PhysicsXVelocityLimit` | `$FFFFA938` | Symmetric horizontal velocity clamp used before object X integration; player initialization loads `$74000`. |
| `PhysicsYVelocityLimit` | `$FFFFA93C` | Symmetric vertical velocity clamp used before object Y integration; player initialization loads `$74000`. |

## Reviewed tilemap-row transfer state

| Symbol | Address | Static evidence |
|---|---:|---|
| `TilemapTransferBase` | `$FFFFA940` | Scrolling mode stores a VRAM-parameter pointer; constant/direct fill modes reuse the high word as a VDP destination base. |
| `TilemapRowCountdown` | `$FFFFA944` | Initialized to rows-minus-one, decremented after each queued row, and considered complete when negative. |
| `TilemapRowXOrFillWord` | `$FFFFA946` | Camera X in scrolling mode; repeated tile word in constant-row and direct-plane-fill modes. |
| `TilemapRowYPosition` | `$FFFFA948` | World Y used by the scrolling row builder and reduced by eight after each row. |

## Reviewed stage-dispatch and camera-motion controls

| Symbol | Address | Static evidence |
|---|---:|---|
| `StageStateOffset` | `$FFFFA950` | Stage records install an even handler offset; the selected stage subsystem dispatches it and transitions advance it by two. |
| `CameraMotionLockFlags` | `$FFFFA959` | Bit 6 suppresses X camera displacement and bit 7 suppresses Y displacement before camera-relative objects are moved. |

## Reviewed horizontal-camera bounds

| Symbol | Address | Static evidence |
|---|---:|---|
| `CameraXLowerBound` | `$FFFFA970` | Horizontal follow clamps the primary camera to this lower world-X limit; stage and boss transitions move it, and projectile bounds checks consume it. |
| `CameraXUpperBound` | `$FFFFA974` | Horizontal follow clamps the primary camera to this upper world-X limit; stage and boss transitions move it, and projectile bounds checks consume it. |

## Reviewed second-controller debug commands

| Symbol | Address | Static evidence |
|---|---:|---|
| `DebugJumpInput` | `$FFFFA980` | Written as one for newly pressed controller-two bit 4; no reconstructed static reader proves its downstream effect. |
| `DebugAttackInput` | `$FFFFA9C0` | Written as one for newly pressed controller-two bit 6; no reconstructed static reader proves its downstream effect. |
| `DebugInputXDirection` | `$FFFFA9D0` | Cleared as a longword, then its leading word receives -1 or +1 for controller-two left or right; no reconstructed static reader exists. |
| `DebugInputYDirection` | `$FFFFA9D4` | Cleared as a longword, then its leading word receives -1 or +1 for controller-two up or down; no reconstructed static reader exists. |

## Reviewed shared effect-object pool

| Symbol | Address | Static evidence |
|---|---:|---|
| `SharedEffectObjectPool` | `$FFFFBFC0` | Weapon, projectile, player-effect, and collision paths scan 96-byte object records from this base; common helpers clear between eight and seventeen consecutive records. |
| `EffectCollisionOddStart` | `$FFFFC020` | Collision processing alternates between the pool base and this second 96-byte record on successive frame parities. |
| `PlayerEffectObjectPool` | `$FFFFC2C0` | Base of eight 96-byte records used by player special attacks, weapon indicators, target sight, homing companions, Phoenix trails, and triple shots. |
| `PlayerEffectAllocStart` | `$FFFFC320` | One record after the player-effect base; free-slot allocation scans seven records from here, and weapon selection uses the first four as indicators. |
| `PlayerSpecialObjectSlot` | `$FFFFC5C0` | Dedicated record initialized or cleared by player dash, teleport, projectile, impact, and Seven Forces paths and checked separately for special-attack collisions. |

## Reviewed primary entity record

`Entity_ObjectPool` begins with a 96-byte record whose concrete owner changes
between stages, bosses, cutscenes, and credits. Absolute references to that
record therefore use structural `PrimaryEntity` names rather than a boss name.

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `PrimaryEntityFlags` | `$FFFFC622` | `$02` | Display/control flags matching offset two of all ordinary entity records. |
| `PrimaryEntityState` | `$FFFFC624` | `$04` | Even state-table offset cleared by setup, advanced by transitions, and compared by entity handlers. |
| `PrimaryEntityMapping` | `$FFFFC628` | `$08` | Sprite-mapping pointer; password-screen paths replace it with the selected cursor mapping. |
| `PrimaryEntitySpriteAttr` | `$FFFFC62E` | `$0E` | Sprite/tile attribute word; the ending-planet animation writes its attribute cycle here. |
| `PrimaryEntityXPos` | `$FFFFC630` | `$10` | Signed 16.16 world-X coordinate used by bosses, projectiles, cutscenes, and credits. |
| `PrimaryEntityYPos` | `$FFFFC634` | `$14` | Signed 16.16 world-Y coordinate used by linked parts, projectiles, cutscenes, and credits. |
| `PrimaryEntityXVelocity` | `$FFFFC638` | `$18` | Signed 16.16 horizontal velocity; some boss code deliberately reuses the primary record field as scratch motion state. |
| `PrimaryEntityAngle` | `$FFFFC640` | `$20` | Primary entity angle compared with linked Jampan objects' offset-`$20` angles. |
| `PrimaryEntityStatus` | `$FFFFC641` | `$21` | Broad entity status/control byte; only Shield Viper bit-six tests are proven for the absolute alias. |
| `PrimaryEntityWork4A` | `$FFFFC66A` | `$4A` | Owner-dependent work byte; Gusthead tests bit seven to distinguish attached and detached segment handling. |
| `PrimaryEntityWork4B` | `$FFFFC66B` | `$4B` | Owner-dependent work byte copied by one VBlank effect into the register-10 shadow; no stable entity-wide role is proven. |
| `PrimaryEntityWork4C` | `$FFFFC66C` | `$4C` | Owner-dependent work word used as Epsilon 1 mode bits and independently as a Stage 3 orbit-angle offset. |
| `PrimaryEntityWork58` | `$FFFFC678` | `$58` | Owner-dependent work word used as a Shield Viper defeat flag and a Sunset Sting selected-chain offset. |
| `PrimaryEntityWork5A` | `$FFFFC67A` | `$5A` | Owner-dependent work word used by the Sunset Sting transition as a vertical reference for linked parts. |
| `PrimaryEntityWork5C` | `$FFFFC67C` | `$5C` | Owner-dependent work word populated and consumed as Sunset Sting's linked-body-part count. |
| `PrimaryEntityWork5E` | `$FFFFC67E` | `$5E` | Owner-dependent work word cleared and advanced as Sunset Sting graphics-animation progress. |

## Reviewed secondary entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `SecondaryEntityType` | `$FFFFC680` | `$00` | Object type and base of the second 96-byte pool record; clearing it deactivates the record. |
| `SecondaryEntityFlags` | `$FFFFC682` | `$02` | Display/control flags written by scene setup and manipulated across linked records. |
| `SecondaryEntityState` | `$FFFFC684` | `$04` | Even state-table offset used by the ending planet's vertical-motion dispatcher. |
| `SecondaryEntityXPos` | `$FFFFC690` | `$10` | Signed 16.16 X coordinate of the second entity; Epsilon 1 uses it as its battle center. |
| `SecondaryEntityYPos` | `$FFFFC694` | `$14` | Signed 16.16 Y coordinate of the second entity; Epsilon 1 movement and other boss paths consume it. |
| `SecondaryEntityXVel` | `$FFFFC698` | `$18` | Signed 16.16 X velocity installed, reversed, and cleared during Epsilon 1 transitions. |
| `SecondaryEntityYVel` | `$FFFFC69C` | `$1C` | Signed 16.16 Y velocity accelerated for the battle center and copied to spawned ring projectiles. |
| `SecondaryEntityStatus` | `$FFFFC6A1` | `$21` | Second-record status byte set and cleared with linked Destroyer MK2 objects. |
| `SecondaryEntityWork40` | `$FFFFC6C0` | `$40` | Owner-specific work word; Destroyer Proto uses it as a linked-part angle. |
| `SecondaryEntityWork46` | `$FFFFC6C6` | `$46` | Owner-specific work word written by the Viblack transition setup. |
| `SecondaryEntityWork4C` | `$FFFFC6CC` | `$4C` | Union work word used as an angle by Bugmax/Stage 3 and as a body offset by Epsilon 1. |
| `SecondaryEntityWork52` | `$FFFFC6D2` | `$52` | Owner-specific linked-object control word used by Jampan. |
| `SecondaryEntityWork58` | `$FFFFC6D8` | `$58` | Union work longword used for Epsilon 1 motion and Sunset Sting oscillation phase. |
| `SecondaryEntityWork5C` | `$FFFFC6DC` | `$5C` | Union work longword used as motion or byte-granular control state by different owners. |

## Reviewed tertiary entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `TertiaryEntityType` | `$FFFFC6E0` | `$00` | Object type and base of the third 96-byte pool record; clearing it deactivates the record. |
| `TertiaryEntityFlags` | `$FFFFC6E2` | `$02` | Display/control flags written by cutscene setup and cleared during transition cleanup. |
| `TertiaryEntityAttr` | `$FFFFC6EE` | `$0E` | Sprite-attribute word whose priority bit is toggled by the ship-arrival flash. |
| `TertiaryEntityXPos` | `$FFFFC6F0` | `$10` | Signed 16.16 X coordinate consumed by Bugmax linked-chain geometry. |
| `TertiaryEntityYPos` | `$FFFFC6F4` | `$14` | Signed 16.16 Y coordinate consumed by Bugmax geometry and direction calculations. |
| `TertiaryEntityStatus` | `$FFFFC701` | `$21` | Status byte set and cleared with linked Destroyer MK2 records and cleared during Epsilon 1 defeat. |
| `TertiaryEntityWork40` | `$FFFFC720` | `$40` | Owner-specific work word used as a linked-part angle by Destroyer Proto. |
| `TertiaryEntityWork4C` | `$FFFFC72C` | `$4C` | Owner-specific work word used as Bugmax's second joint angle. |
| `TertiaryEntityWork50` | `$FFFFC730` | `$50` | Owner-specific work word used as a Bugmax linked-part projection radius. |
| `TertiaryEntityWork52` | `$FFFFC732` | `$52` | Owner-specific linked-object control word used by Jampan. |
| `SunsetStingTrailSpan` | `$FFFFC738` | `$58` | Vertical span used to distribute Sunset Sting's eight trail objects. |
| `SunsetStingTrailStep` | `$FFFFC73C` | `$5C` | Accumulating contraction step subtracted from the trail span. |
| `SunsetStingAimAngle` | `$FFFFC73E` | `$5E` | Cached angle-to-player sample used by the second-form body layout. |

## Reviewed quaternary entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `QuaternaryEntityType` | `$FFFFC740` | `$00` | Object type and base of the fourth 96-byte pool record; boss, projectile, cutscene, and credits code use it as a record base. |
| `QuaternaryEntityFlags` | `$FFFFC742` | `$02` | Display/control flags initialized with the preceding star-row entity records. |
| `QuaternaryEntityState` | `$FFFFC744` | `$04` | Even state-table offset tested by Destroyer MK2 cleanup and Epsilon 1 defeat handling. |
| `QuaternaryEntityStatus` | `$FFFFC761` | `$21` | Status byte cleared with the controller and third record when Epsilon 1 begins defeat. |
| `QuaternaryEntityWork40` | `$FFFFC780` | `$40` | Owner-specific work word used as a linked-part angle by Destroyer Proto. |
| `QuaternaryEntityWork46` | `$FFFFC786` | `$46` | Owner-specific second angle word used by Destroyer Proto. |
| `QuaternaryEntityWork52` | `$FFFFC792` | `$52` | Owner-specific linked-part control word used by Jampan. |
| `SunsetStingChainPeriod` | `$FFFFC79C` | `$5C` | Reload period for the second-form active-chain countdown. |

## Reviewed fifth entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `FifthEntityType` | `$FFFFC7A0` | `$00` | Object type and base of the fifth 96-byte pool record; several subsystems traverse later records from here. |
| `FifthEntityFlags` | `$FFFFC7A2` | `$02` | Display/control flags initialized with adjacent star-row records. |
| `FifthEntityState` | `$FFFFC7A4` | `$04` | Epsilon 1 ring-controller state and common linked-record state field checked by Destroyer MK2. |
| `FifthEntityWork40` | `$FFFFC7E0` | `$40` | Owner-specific work word used as a linked-part angle by Destroyer Proto. |
| `FifthEntityWork52` | `$FFFFC7F2` | `$52` | Owner-specific linked-part control word used by Jampan. |
| `SunsetStingChainCycle` | `$FFFFC7F8` | `$58` | Packed chain selector and per-chain countdown used by Sunset Sting's second form. |
| `FifthEntityWork5C` | `$FFFFC7FC` | `$5C` | Union word/byte storage used for Sunset Sting turning and Madam Barbar rotation bounds. |
| `SunsetStingPoseRadius` | `$FFFFC7FD` | `$5D` | Low-byte pose radius derived from randomness and player distance. |
| `FifthEntityWork5E` | `$FFFFC7FE` | `$5E` | Union work word used for Epsilon 1 ring commands and Madam Barbar rotation bounds. |

## Reviewed sixth entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `SixthEntityType` | `$FFFFC800` | `$00` | Object type and base of the sixth 96-byte pool record. |
| `SixthEntityFlags` | `$FFFFC802` | `$02` | Display/control flags initialized with adjacent star-row records. |
| `SixthEntityState` | `$FFFFC804` | `$04` | Linked-part state activated and polled by Destroyer MK2. |
| `SixthEntityWork40` | `$FFFFC840` | `$40` | Owner-specific work word used as a linked-part angle by Destroyer Proto. |
| `SixthEntityWork52` | `$FFFFC852` | `$52` | Owner-specific linked-part control word used by Jampan. |
| `SixthEntityWork56` | `$FFFFC856` | `$56` | Owner-specific work byte used as a pose-grid anchor by Sirene. |

## Reviewed seventh entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `SeventhEntityType` | `$FFFFC860` | `$00` | Object type and base of the seventh 96-byte pool record. |
| `SeventhEntityFlags` | `$FFFFC862` | `$02` | Display/control flags manipulated by Jampan and ordinary record-based code. |
| `SeventhEntityState` | `$FFFFC864` | `$04` | Linked-part state activated and polled by Destroyer MK2. |
| `SeventhEntityXPos` | `$FFFFC870` | `$10` | Signed 16.16 X coordinate copied by Jampan into spawned attack objects. |
| `SeventhEntityYPos` | `$FFFFC874` | `$14` | Signed 16.16 Y coordinate; Bugmax also reuses its high word as owner-specific scratch. |
| `SeventhEntityXVel` | `$FFFFC878` | `$18` | Signed 16.16 horizontal velocity seeded and consumed by Bugmax. |
| `SeventhEntityYVel` | `$FFFFC87C` | `$1C` | Signed 16.16 vertical velocity seeded and consumed by Bugmax. |
| `SeventhEntityWork40` | `$FFFFC8A0` | `$40` | Owner-specific linked-part angle word used by Destroyer Proto. |
| `SeventhEntityWork46` | `$FFFFC8A6` | `$46` | Owner-specific second linked-part angle word used by Destroyer Proto. |
| `SeventhEntityWork4A` | `$FFFFC8AA` | `$4A` | Owner-specific work word used as a Jampan shield-formation angle base. |
| `SeventhEntityWork4C` | `$FFFFC8AC` | `$4C` | Union work word used by Jampan formation geometry and Bugmax linked-part spin. |
| `SeventhEntityWork4E` | `$FFFFC8AE` | `$4E` | Owner-specific work word used as a Jampan shield-formation angle base. |
| `SeventhEntityWork52` | `$FFFFC8B2` | `$52` | Owner-specific linked-part control word used by Jampan. |

## Reviewed eighth entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `EighthEntityType` | `$FFFFC8C0` | `$00` | Object type and base of the eighth 96-byte pool record. |
| `EighthEntityFlags` | `$FFFFC8C2` | `$02` | Display/control flags initialized with adjacent star-row records. |
| `EighthEntityState` | `$FFFFC8C4` | `$04` | Linked-part state activated and polled by Destroyer MK2. |

## Reviewed ninth entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `NinthEntityType` | `$FFFFC920` | `$00` | Object type and base of the ninth 96-byte pool record. |
| `NinthEntityFlags` | `$FFFFC922` | `$02` | Display/control flags initialized with adjacent star-row records. |

## Reviewed tenth entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `TenthEntityType` | `$FFFFC980` | `$00` | Object type and base of the tenth 96-byte pool record. |
| `TenthEntityFlags` | `$FFFFC982` | `$02` | Display/control flags initialized with adjacent star-row records. |
| `ValkirieAuxFlags` | `$FFFFC9DE` | `$5E` | Bitfield coordinating Valkirie auxiliary attachment, launch, rotation, and targeting transitions. |

## Reviewed eleventh entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `EleventhEntityType` | `$FFFFC9E0` | `$00` | Object type and base of the eleventh 96-byte pool record. |
| `EleventhEntityFlags` | `$FFFFC9E2` | `$02` | Display/control flags and active bit used by the planet-grid sequence. |
| `EleventhEntityXPos` | `$FFFFC9F0` | `$10` | Integer X-position half copied into the sprite-grid center. |
| `EleventhEntityYPos` | `$FFFFC9F4` | `$14` | Integer Y-position half copied into the sprite-grid center. |
| `EleventhEntityXVel` | `$FFFFC9F8` | `$18` | Signed 16.16 horizontal velocity used by the first planet-grid sequence. |
| `EleventhEntityYVel` | `$FFFFC9FC` | `$1C` | Signed 16.16 vertical velocity used by the second planet-grid sequence. |

## Reviewed twelfth entity record

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `TwelfthEntityType` | `$FFFFCA40` | `$00` | Object type and base of the twelfth 96-byte pool record. |
| `TwelfthEntityFlags` | `$FFFFCA42` | `$02` | Display/control flags and active bit used by the ship-grid sequence. |
| `TwelfthEntityXPos` | `$FFFFCA50` | `$10` | Integer X-position half copied into the ship-grid center. |
| `TwelfthEntityYPos` | `$FFFFCA54` | `$14` | Integer Y-position half copied into the ship-grid center. |
| `TwelfthEntityXVel` | `$FFFFCA58` | `$18` | Signed 16.16 horizontal velocity used by the first ship-grid sequence. |
| `TwelfthEntityYVel` | `$FFFFCA5C` | `$1C` | Signed 16.16 vertical velocity used by the second ship-grid sequence. |

## Reviewed later entity record bases

| Symbol | Address | Record | Static evidence |
|---|---:|---:|---|
| `ThirteenthEntityType` | `$FFFFCAA0` | 13 | Flying Neo traverses ordinary linked-object fields from this record base. |
| `FourteenthEntityType` | `$FFFFCB00` | 14 | Sharpssteel and linked-object code use this fixed record base. |
| `FourteenthEntityXPos` | `$FFFFCB10` | 14 | Valkirie targeting reads the record's integer X coordinate. |
| `FourteenthEntityYPos` | `$FFFFCB14` | 14 | Valkirie targeting reads the record's integer Y coordinate. |
| `FifteenthEntityType` | `$FFFFCB60` | 15 | Bugmax and Antroid select this fixed object record. |
| `SixteenthEntityType` | `$FFFFCBC0` | 16 | Shiper and Artemis select this fixed object record. |
| `SixteenthEntityWork56` | `$FFFFCC16` | 16 | Sirene uses this owner-specific work byte as a pose-grid anchor. |
| `SeventeenthEntityType` | `$FFFFCC20` | 17 | Destroyer MK2 fragments and Medusa pose parts traverse from this record. |
| `EighteenthEntityType` | `$FFFFCC80` | 18 | Enemy-projectile allocation and Valkirie selection use this record base. |
| `NineteenthEntityType` | `$FFFFCCE0` | 19 | Valkirie bullet allocation and part commands use this record base. |
| `TwentiethEntityType` | `$FFFFCD40` | 20 | Joker linked objects and Victor ring setup use this record base. |
| `TwentyFirstEntityType` | `$FFFFCDA0` | 21 | Artemis, Joker, Victor, and Z-Leo use this fixed record. |
| `TwentyFirstEntityWork4C` | `$FFFFCDEC` | 21 | Owner-specific work word assigned during Victor ring deployment. |
| `TwentySecondEntityType` | `$FFFFCE00` | 22 | Enemy allocation and Joker linked-part rendering use this record base. |
| `TwentyThirdEntityType` | `$FFFFCE60` | 23 | Jampan shield traversal and Joker linked-part rendering use this record. |
| `TwentyThirdEntityAttr` | `$FFFFCE6E` | 23 | Sprite attribute whose priority bit controls Jampan shield collision. |
| `TwentyThirdEntityStatus` | `$FFFFCE81` | 23 | Status byte set and cleared with Jampan shield activation. |
| `TwentyThirdEntityWork26` | `$FFFFCE86` | 23 | Owner-specific shield collision control word. |
| `TwentyThirdEntityWork2C` | `$FFFFCE8C` | 23 | Owner-specific paired shield collision extents. |
| `TwentyFourthEntityType` | `$FFFFCEC0` | 24 | Destroyer Proto projectiles and Z-Leo wing code use this record base. |
| `TwentyFourthEntityFlags` | `$FFFFCEC2` | 24 | Display/control flags initialized by Destroyer Proto projectile setup. |
| `TwentyFifthEntityType` | `$FFFFCF20` | 25 | Shellshogun and Wolf Garopa use this fixed part record. |
| `TwentySixthEntityType` | `$FFFFCF80` | 26 | Forward projectile allocation and several fixed boss parts start here. |
| `TwentySixthEntityWork56` | `$FFFFCFD6` | 26 | Sirene uses this owner-specific work byte as a pose-row anchor. |
| `TwentySeventhEntityType` | `$FFFFCFE0` | 27 | Valkirie, Madam Barbar, and Z-Leo use this fixed linked-object record. |
| `TwentyEighthEntityType` | `$FFFFD040` | 28 | Jampan, Madam Barbar, Shellshogun, and Wolf Garopa use this record. |
| `TwentyEighthEntityAttr` | `$FFFFD04E` | 28 | Sprite attribute copied into Jampan's projected shield objects. |
| `JampanShieldWork20` | `$FFFFD060` | 28 | Owner-specific byte copied into each projected Jampan shield's offset `$20`. |
| `TwentyNinthEntityType` | `$FFFFD0A0` | 29 | Jampan's post-defeat shield and Madam Barbar use this fixed record. |
| `TwentyNinthEntityFlags` | `$FFFFD0A2` | 29 | Display/control flags updated during Jampan's post-defeat transition. |
| `TwentyNinthEntityXPos` | `$FFFFD0B0` | 29 | Integer X position copied into Jampan's post-defeat controller. |
| `TwentyNinthEntityYPos` | `$FFFFD0B4` | 29 | Integer Y position tested and copied during Jampan's defeat. |
| `TwentyNinthEntityYVel` | `$FFFFD0BC` | 29 | Signed 16.16 vertical velocity cleared after the defeat-shield descent. |
| `ThirtiethEntityType` | `$FFFFD100` | 30 | Z-Leo uses this fixed linked-part record. |
| `ThirtiethEntityXPos` | `$FFFFD110` | 30 | Integer X source position used by Artemis projectile setup. |
| `ThirtiethEntityYPos` | `$FFFFD114` | 30 | Integer Y source position used by Artemis projectile setup. |
| `ThirtyFirstEntityType` | `$FFFFD160` | 31 | Wolf Garopa uses this fixed orb record. |
| `ThirtySecondEntityType` | `$FFFFD1C0` | 32 | Victor starts reverse ring-link traversal from this record. |
| `VictorRingEndMapping` | `$FFFFD1C8` | 32 | Mapping pointer switched when Victor reverses ring deployment. |
| `ThirtySecondEntityXPos` | `$FFFFD1D0` | 32 | Integer X coordinate measured by Valkirie's tracking state. |
| `ThirtySecondEntityYPos` | `$FFFFD1D4` | 32 | Integer Y coordinate measured by Valkirie's tracking state. |
| `ThirtyThirdEntityType` | `$FFFFD220` | 33 | Z-Leo uses this fixed linked-part record. |
| `ThirtyFourthEntityType` | `$FFFFD280` | 34 | Caterpillar and Sunset Sting begin bounded projectile searches here. |
| `ThirtyEighthEntityType` | `$FFFFD400` | 38 | Joker begins a bounded descending-shot allocation range here. |
| `FortySixthEntityType` | `$FFFFD700` | 46 | Several boss and stage paths begin bounded projectile allocation here. |
| `EndingPlanetDebrisType` | `$FFFFD820` | 49 | Fixed ending-planet debris object type and record base. |
| `EndingPlanetDebrisFlags` | `$FFFFD822` | 49 | Display/control flags of the ending-planet debris object. |
| `EndingPlanetDebrisXVel` | `$FFFFD838` | 49 | Signed 16.16 horizontal velocity accelerated during debris motion. |
| `FiftiethEntityType` | `$FFFFD880` | 50 | Sirene and Terobuster begin bounded projectile searches here. |
| `AmbientParticlePool` | `$FFFFD8E0` | 51 | Six consecutive Stage 10/11 ambient-particle records. |
| `FiftyThirdEntityType` | `$FFFFD9A0` | 53 | Back Stringer tail slots and the reverse projectile scan start here. |

## Reviewed entity record 57

| Symbol | Address | Offset | Static evidence |
|---|---:|---:|---|
| `Entity57Type` | `$FFFFDB20` | `$00` | Shared record type used by effects, transitions, enemies, bosses, and projectiles. |
| `Entity57Flags` | `$FFFFDB22` | `$02` | Display/control flags manipulated by transitions and Z-Leo. |
| `Entity57State` | `$FFFFDB24` | `$04` | Even state index cleared by transitions and advanced by Stage 12 logic. |
| `Entity57XPos` | `$FFFFDB30` | `$10` | Signed 16.16 X position copied or compared by multiple owners. |
| `Entity57YPos` | `$FFFFDB34` | `$14` | Signed 16.16 Y position and shared vertical reference. |
| `Entity57XVel` | `$FFFFDB38` | `$18` | Signed 16.16 horizontal velocity used by Sharpssteel. |
| `Entity57YVel` | `$FFFFDB3C` | `$1C` | Signed 16.16 vertical velocity used by Z-Leo and Sharpssteel. |
| `Entity57Status` | `$FFFFDB41` | `$21` | Status byte cleared during record reconfiguration. |
| `Entity57CollisionFlags` | `$FFFFDB42` | `$22` | Object collision flags; the rising-shot path sets bit six. |
| `Entity57Work24` | `$FFFFDB44` | `$24` | Owner-dependent work word initialized by Stage 10-to-13 setup. |
| `Entity57Work56` | `$FFFFDB76` | `$56` | Owner-dependent Medusa pose and movement gate byte. |
| `Entity57Work58` | `$FFFFDB78` | `$58` | Owner-dependent Sharpssteel phase-control word. |
| `Entity57Work5A` | `$FFFFDB7A` | `$5A` | Owner-dependent Sharpssteel complex-phase flag byte. |

## Reviewed entity records 58–60

| Symbol | Address | Record/offset | Static evidence |
|---|---:|---:|---|
| `Entity58Type` | `$FFFFDB80` | 58/`$00` | Shared Valkirie, Z-Leo, transition, and arena-boundary record. |
| `Entity58YPos` | `$FFFFDB94` | 58/`$14` | Integer Y coordinate written by Valkirie projectile growth. |
| `Entity59Type` | `$FFFFDBE0` | 59/`$00` | Shared transition and arena-boundary record type. |
| `Entity59State` | `$FFFFDBE4` | 59/`$04` | Even object state advanced by Sharpssteel. |
| `Entity59XPos` | `$FFFFDBF0` | 59/`$10` | Integer X coordinate computed by Sharpssteel. |
| `Entity59YPos` | `$FFFFDBF4` | 59/`$14` | Integer Y coordinate computed by Sharpssteel. |
| `Entity59XVel` | `$FFFFDBF8` | 59/`$18` | Signed 16.16 horizontal velocity initialized by Sharpssteel. |
| `Entity59YVel` | `$FFFFDBFC` | 59/`$1C` | Signed 16.16 vertical velocity initialized by Sharpssteel. |
| `Entity60Type` | `$FFFFDC40` | 60/`$00` | Shared Seven Forces and late-boss record type. |
| `Entity60XPos` | `$FFFFDC50` | 60/`$10` | Integer X coordinate checked during Wolf Garopa transition. |
| `Entity60XVel` | `$FFFFDC58` | 60/`$18` | Signed 16.16 horizontal velocity consumed by Sylpheed. |
| `Entity60YVel` | `$FFFFDC5C` | 60/`$1C` | Signed 16.16 vertical velocity consumed by Sylpheed. |

## Reviewed gameplay and weapon-mode state

| Symbol | Address | Static evidence |
|---|---:|---|
| `GameplayStateBuffer` | `$FFFF8000` | Full initialization clears 2 KiB from this base, while the explicit broad reset clears the complete 8 KiB state block. |
| `WeaponTargetOrFrame` | `$FFFF801C` | Targeting modes store an object pointer here; icon mode reuses the word as its even frame counter. |
| `WeaponIconFrameTile` | `$FFFF801E` | State-twelve icon animation copies the selected frame's tile word here after clearing it with the other runtime parameters. |
| `WeaponAnimationDataPtr` | `$FFFF8020` | Circle-attack setup and weapon icon mode install and consume an animation-data pointer here. |
| `WeaponYMotionParameter` | `$FFFF8024` | Weapon setup derives a fixed-point vertical motion term here; impact particles add it to vertical velocity. |
| `WeaponXMotionParameter` | `$FFFF8028` | The paired fixed-point term is added to horizontal velocity; other weapon modes intentionally reuse its halves as parameters. |
| `WeaponModeParameter` | `$FFFF802C` | Weapon modes store either a motion-table pointer or a word-sized damage/count value here, so the neutral union name is intentional. |
| `SpecialMoveSpawnXOffset` | `$FFFF8032` | Special activation initializes this word and the circle-effect spawner adds it to the player's X position. |
| `SpecialMoveSpawnYOffset` | `$FFFF8034` | Special activation initializes this word and the circle-effect spawner adds it to the player's Y position. |

These weapon fields are mode-dependent unions. The map records all observed
roles rather than pretending that one weapon state's interpretation applies to
every state.

## Reviewed large tilemap and terrain workspaces

| Symbol | Address | Static evidence |
|---|---:|---|
| `LargeTilemapBuffer` | `$FFFF4000` | Frontend and ending paths walk `$800` longwords from this base, proving an 8 KiB shared tilemap workspace. |
| `FlyingNeoTileAttrRangeA` | `$FFFF4020` | Flying Neo clears the priority bit on 240 consecutive tile words beginning here. |
| `FlyingNeoTileAttrRangeB` | `$FFFF4AC0` | The second range in the same operation contains sixteen consecutive tile words. |
| `FlyingNeoTileAttrRangeC` | `$FFFF4360` | The third range contains 48 consecutive tile words whose priority bits are cleared. |
| `FlyingNeoTileAttrRangeD` | `$FFFF4400` | The fourth range contains the matching 48 tile words. |
| `LargeTilemapPage2` | `$FFFF5000` | This address is exactly 4 KiB after the shared buffer base; Stage 8 writes its first tile and credits edits 256 words from it. |
| `CreditsXiTigerTilemap` | `$FFFF5180` | Credits updates tile indices across three 16-word rows loaded for the Xi-Tiger scene. |
| `Stage8StridedControl` | `$FFFF615D` | Train and Flying Neo profiles write three byte pairs at offsets zero, eight, and sixteen from this base. |
| `TerobusterIntroPalette` | `$FFFF644A` | Terobuster initialization writes its five-byte intro palette sequence beginning here. |
| `WeaponSetupWriteFlag` | `$FFFF7001` | Weapon-setup initialization writes one here; no reconstructed reader supports a narrower role. |
| `TerrainCollisionBuffer` | `$FFFF7800` | Terrain probes and enemy placement consistently pass this base with an `$80` bound; stage transitions clear 224 bytes from it. |
| `Stage8TilemapMode` | `$FFFF780C` | Stage 8 setup writes `$82`, and the Stage 9 corridor transition clears the same byte. |
| `Stage9TilemapMode` | `$FFFF780D` | Stage 9 writes `$82` after filling its four plane-map rows. |
| `WeaponSetupTilemapMode` | `$FFFF78FF` | Weapon setup writes `$82` after initializing its three plane-map color tables. |
| `Stage20PlaneMode0` | `$FFFF7981` | Stage 20 plane setup writes `$82`; the Sylpheed cleanup clears it with the adjacent mode bytes. |
| `Stage20PlaneMode1` | `$FFFF7982` | Stage 20 plane setup writes `$90`; the Sylpheed cleanup clears it. |
| `Stage20PlaneMode2` | `$FFFF7983` | Stage 20 plane setup writes `$92`; the Sylpheed cleanup clears it. |
| `Stage17TilemapMode` | `$FFFF7AFF` | Stage 17 writes `$82` after filling four complete plane-map rows. |
| `SevenForcesTilemapMode` | `$FFFF7B00` | Artemis setup writes two before filling its row; the shared Seven Forces cleanup clears it. |

The three paired bytes at `Stage8StridedControl` and the write-only weapon flag
remain deliberately structural names because no current reader proves their
bit-level protocol.

## Reviewed plane-tilemap and cutscene work buffers

The `$FFFF0000` plane map uses 64 words (`$80` bytes) per row. These sparse
anchors are the rows explicitly initialized by stage and frontend code; no
ownership beyond the observed shared plane-map storage is implied.

| Symbol | Address | Static evidence |
|---|---:|---|
| `PlaneTilemapRow9` | `$FFFF0480` | Stage 8 fills 64 words here in parallel with rows 10 and 24. |
| `PlaneTilemapRow10` | `$FFFF0500` | This is the next `$80`-byte row and receives the same 64-word Stage 8 fill. |
| `PlaneTilemapRow22` | `$FFFF0B00` | Artemis setup fills this complete 64-word tilemap row with tile `$0300`. |
| `PlaneTilemapRow24` | `$FFFF0C00` | Stage 8 and Stage 17 fill this complete row; its address is 24 row strides from the plane-map base. |
| `PlaneTilemapRow25` | `$FFFF0C80` | Stage 9, Stage 17, and Stage 20 setup fill this 64-word row. |
| `PlaneTilemapRow26` | `$FFFF0D00` | Stage and weapon-setup paths fill this complete 64-word row. |
| `PlaneTilemapRow27` | `$FFFF0D80` | Stage and weapon-setup paths fill this complete 64-word row. |
| `PlaneTilemapRow28` | `$FFFF0E00` | Stage and weapon-setup paths fill this complete 64-word row. |
| `PlaneTilemapRow29` | `$FFFF0E80` | The unreferenced Stage 20 variant fills this complete 64-word row. |
| `CutsceneWorkBuffer` | `$FFFF1000` | Story-title expansion clears and builds here, the ship reveal uses it as a `$240`-byte pattern buffer, and ending starfield reuses it for X positions. |
| `EndingStarYPositions` | `$FFFF1400` | Starfield initialization writes 256 fixed-point Y positions and the updater selects one of four `$100`-byte banks. |
| `StoryTitleLeftOrigin` | `$FFFF14C3` | Story-title expansion starts its leftward destination traversal from this byte in the shared workspace. |
| `StoryTitleRightOrigin` | `$FFFF1500` | The matching rightward expansion traversal starts from this aligned workspace address. |
| `EndingStarDepthValues` | `$FFFF1800` | Starfield initialization creates 256 depth/frame accumulators and update selects one of four banks. |
| `EndingStarXVelocities` | `$FFFF1C00` | Starfield initialization stores the fixed-point horizontal velocity paired with each X position. |
| `EndingStarYVelocities` | `$FFFF2000` | Starfield initialization stores the fixed-point vertical velocity paired with each Y position. |
| `ShipArrivalTilemap` | `$FFFF2020` | Ship arrival toggles priority on exactly `$160` consecutive staged tile words before requeueing the map. |
| `StoryTitleMirroredGlyph` | `$FFFF2380` | Glyph setup writes 128 bytes of mirrored source nibbles beginning here. |
| `StoryTitleGlyphReadBase` | `$FFFF2384` | Both title-expansion paths begin their reverse source traversal relative to this interior glyph-buffer anchor. |

## Reviewed controller, timing, results, and demo state

| Symbol | Address | Static evidence |
|---|---:|---|
| `Controller1TypeID` | `$FFFFFF06` | Port-one polling stores the four-bit hardware response and accepts `$D` as the connected controller signature. |
| `Controller2TypeID` | `$FFFFFF07` | Port-two polling stores the corresponding hardware response before applying the same `$D` connection test. |
| `DeveloperSignatureTREA` | `$FFFFFF10` | Reset compares this longword with `TREA` and writes it as the first half of the warm-reset developer signature. |
| `DeveloperSignatureSURE` | `$FFFFFF14` | Reset compares this longword with `SURE` and writes it as the second half of the warm-reset developer signature. |
| `P1ButtonASourceBit` | `$FFFFFF20` | Optional port-one remapping reads this byte as the source bit mapped onto output button A; reset installs identity bit six. |
| `P2ButtonASourceBit` | `$FFFFFF21` | Optional port-two remapping reads this byte as the source bit mapped onto output button A; reset installs identity bit six. |
| `P1ButtonBSourceBit` | `$FFFFFF22` | Optional port-one remapping reads this byte as the source bit mapped onto output button B; reset installs identity bit four. |
| `P2ButtonBSourceBit` | `$FFFFFF23` | Optional port-two remapping reads this byte as the source bit mapped onto output button B; reset installs identity bit four. |
| `P1ButtonCSourceBit` | `$FFFFFF24` | Optional port-one remapping reads this byte as the source bit mapped onto output button C; reset installs identity bit five. |
| `P2ButtonCSourceBit` | `$FFFFFF25` | Optional port-two remapping reads this byte as the source bit mapped onto output button C; reset installs identity bit five. |
| `ConsoleVersionFlags` | `$FFFFFF26` | Reset snapshots the console version register; VBlank tests its bit six before applying the alternate timing delay. |
| `FrameSkipLevel` | `$FFFFFF3E` | HUD controls clamp this value to zero through three, while VBlank subtracts it from the update interval. |
| `ResultsExtendedLayout` | `$FFFFFF46` | Credits sets this word before entering results; results consumes and clears it while selecting extended scroll bounds. |
| `DemoCurrentInputWord` | `$FFFFFF48` | Playback holds the current packed held/pressed input here; recording retains the previous sample for run-length encoding. |
| `DemoInputRunFrames` | `$FFFFFF4A` | Playback counts down the current input run, while recording increments and emits the same run length. |
| `DemoInputStreamPtr` | `$FFFFFF4C` | Playback saves and advances the pointer to the next run-length encoded input record. |
| `DemoRecordingOffset` | `$FFFFFF50` | Recording advances this word by four bytes for each count/input pair written into its RAM buffer. |
| `DemoPlaybackInputWord` | `$FFFFFF52` | Playback copies the selected packed input here before publishing its two bytes to held and pressed controller state. |
| `DemoRecordingMode` | `$FFFFFF56` | Zero selects ROM playback; a nonzero value selects the RAM recording path and suppresses input injection. |
| `DemoFramesRemaining` | `$FFFFFF58` | Demo startup loads `$1000`; each update decrements the word and exits on zero. |
| `SavedDifficultyMode` | `$FFFFFF5E` | Demo entry saves the selected difficulty here and restores it on exit. |
| `SavedSoundDisableFlags` | `$FFFFFF60` | Demo and credits temporarily save the sound-disable options here and restore them on exit. |
| `DemoRotationIndex` | `$FFFFFF62` | Each completed demo advances this even index modulo eight to select the next stage and input stream. |
| `SavedControlLayoutFlags` | `$FFFFFF66` | Demo entry saves the control-layout byte here and restores it on exit. |

The adjacent `$FFFFFF00` clear-only longword and `$FFFFFF36` boot-only option
word remain raw: their exact roles are not established by the current static
references.

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
