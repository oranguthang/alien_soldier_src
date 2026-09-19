# Tooling progress

## 2026-09-19: procedure batch source lookup

`scripts/prepare_batch.py` now reads the ROM-ordered `.s` includes from
`src/main.s`, locates each requested procedure in its owning module, and prints
that module in the batch. A missing included module fails explicitly. The two
focused tests in `tests/test_prepare_batch.py` pass, a live lookup finds `Reset`
in `src/system/boot.s` among 379 modules, and `make lint` passes.

This was one piece of the legacy tooling migration, not a release claim. The
exploratory workflow remains outside the release interface described in
`docs/tooling_status.md`.

The module-aware `rename_symbols.py` now preserves every `; was:` suffix when
renaming live references. A focused test covers the case where a provenance
alias is itself another symbol being renamed; the alias remains historical
evidence rather than turning into the new name.

Batch extraction now scans the entire owning module for its matching imported
`End of function` marker, including routines longer than 500 lines. If that
marker is absent, it shows the module remainder and explicitly says the
procedure boundary is uncertain; it no longer invents a 100-line boundary.

`make rename` now calls `scripts/rename_batch.py`, which delegates all source
edits to the module-aware `rename_symbols.py` and marks the selected movie's
analysis report only after a successful rename. The legacy single-file
`rename_procedures.py` CLI refuses to run. This fixes source targeting and
provenance handling; the semantic basis and byte identity still require human
review and `make verify`.

`make set-movie`, `make show-movie`, and `make prepare-batch` now use a shared
Python movie selector instead of POSIX `if`, `cat`, or shell redirection. The
batch command selects its report from the validated movie marker and extracts
source from the 379 ordered modules. Focused tests exercise the CLI arguments
and report selection without launching the emulator.

The extra tracked Python, test, and documentation files changed the release
manifest's tracked-text counter. It was recounted from the current tree so
`make release-audit` remains a useful drift detector after this migration.

`make find-unanalyzed` now selects delimited code routines whose current-name
evidence is `hypothesis` in `config/name_audit.json`, in ROM order. The current
tree yields seven code candidates. The former transfer-tuple hypothesis is
now an explicit `unknown`, not a code perturbation candidate. Old unpinned
`analysis_results.csv`
cannot silently remove candidates. `analyze_procedures.py` resolves each name
to its owning module, changes only a unique temporary worker copy, records
module and ROM order in its output, and defaults to one worker. The old
monolithic finder CLI refuses to run. These are static and isolated-test
results only: no emulator batch was run, so the findings are not release
runtime evidence.

The old `debug-pointers` and `report-pointers` CLIs are now retired. Their
address-derived data-label search cannot select the current semantic source,
and their cleanup could delete prior diff directories. They fail before any
worker, emulator, or filesystem cleanup starts, directing maintainers to
`make verify-relocation`, the module-aware pointer gate already used by
`make release-check`. Existing diff data was not removed.

The direct `find_unreferenced_labels.py` command now scans all ROM-ordered
modules and included equates as one source graph, excluding comments and
quoted payload paths. On this tree it finds 399 labels without symbolic
references, including externally consumed cartridge-header fields; this is a
review queue, not a dead-code count. The old single-file data splitter now
refuses to run, because it would bypass canonical asset extraction and the
manifest. `prepare_batch.py` also defaults to `src/main.s` for direct use.

The imported cross-reference comments had 40 surviving address-derived symbol
names in 28 modules, not the older documented count of 207. Thirty-three map
uniquely through `; was:` provenance; the remaining seven table references
were resolved against the existing assembler listing at their ROM addresses.
Only comment text changed, and the provenance markers remain intact. Source
lint now rejects a retired name in a `CODE XREF`, `DATA XREF`, or continuation
`ROM:` comment, so this cleanup remains checkable.

The broad `docs/source_map.md` table had 23 stale file counts and two boundaries
that cut across a source module after the source was split into smaller
ROM-ordered modules. Its 57 ranges now count all 380 modules from
`config/rom_layout.json`. Project lint checks range continuity,
exactly one broad-range owner per module, and the count in each row; future
semantic splits cannot silently leave the orientation map stale.

The former long `stages/stage_and_boss_transition_states.s` was divided at
the Missiray entry-state boundary `$00F7FA`. Its dispatch, table, asteroid,
Destroyer Proto, Shield Viper, and Wolf Garopa block remains 583 lines;
the Missiray/Stage 24/Z-Leo block is 278 lines in
`stages/missiray_stage24_z_leo_transitions.s`. The source is now 381 modules:
208 in the 200-700 line preference, 145 shorter, 28 longer, none over 1000.

The former long ship-arrival source had a second, actor-owned ROM block starting
at `$008F90`: two timed spawn scripts and the ship-piece/debris handlers and
tables. `cutscenes/ship_sequence.s` now keeps the complete timeline and its
private pattern/arrival data at 644 lines; `cutscenes/ship_piece_and_debris.s`
owns the cohesive 167-line actor block. Inventory is 382 modules: 209 inside
the preferred size band, 146 shorter, 27 longer, none over 1000.

The former long UI message module contained a separate message-script and
glyph-list bank after the completed sprite-line writer at ROM `$00B43E`.
`ui/stage_message_sequences.s` now holds the stage-entry, time-bonus, and
shared renderer block (544 lines); `ui/message_scripts_and_glyph_lists.s`
owns the battle-banner records, boss/ship selectors, glyph lists, and encoded
scripts (213 lines). Inventory is 383 modules: 211 in the preferred band,
146 shorter, 26 longer, none over 1000.

The Gusthead name audit had 70 `static` records with the same generic basis
sentence. Thirteen were checked against the root update, segment setup,
pattern selector, joint sweep, and debris consumers; each now cites the
instruction or data flow it relies on. Two overstated names were corrected:
`CheckStageExit` actually gates the defeat state, and `StoreSegmentRadius`
also finishes the segment record. Fifty-seven template bases remain as
`NAME-002` debt, recounted by `make release-audit`. The release requirement is
marked partial until that number reaches zero.

The next Gusthead pass resolved eighteen more template bases in one coherent
movement/state span: horizontal and vertical target selection, signed step
directions, vertical and middle-joint speed limits, oscillation-cycle exit,
and the bounce-turn angle table. Each basis now names the relevant field,
comparison, and branch effect. `NAME-002` falls from 57 to 39; no source
instructions or label identities changed in this pass.

A further pass verified the outer, middle, and inner joint-angle velocity
entrypoints and the descent/re-alignment states. Ten template bases now name
the sampled angle, flag-gated sine calculation, output fields, and transition
conditions. Two labels that falsely implied an early store or a joint-speed
write now describe calculation of Y velocity and storage of the resulting
root X/Y components. `NAME-002` falls from 39 to 29; byte identity is retained.

The remaining 29 Gusthead template bases have been checked against concrete
instructions and consumers across combat, detached segments, debris, arena
scroll, and joint history. One name falsely attributed a difficulty-dependent
angle offset to arena side; it now names the `DifficultyMode` condition.
`NAME-002` reaches zero. Seven provisional visual boss-identity records are
tracked separately as `NAME-003`, with a manifest counter and tag-ready gate;
this pass does not claim runtime confirmation for them.

A follow-up audit found that `NAME-002` had been defined too narrowly: its
counter matched one retired generic sentence but missed 60 other Gusthead
records using four repeated loop, RTS, dispatch, or table sentences. The
release audit now recognizes all five sentences and restores the honest debt
count to 60. This corrects the preceding zero claim; the 29 records reviewed
there remain instruction-specific, and the seven visual hypotheses are tracked
separately.

All 60 Gusthead loop, RTS, dispatch, and table records now cite their actual
field, branch, or table consumer. Two rotation paths were renamed because they
decelerate joint speed, not a countdown. A wider duplicate-basis scan then
found 301 records elsewhere with fifteen more vacuous evidence sentences.
`NAME-002` now tracks twenty known boilerplate sentences, not just the five
Gusthead forms; 301 records await review. This is a broader audit boundary,
not a regression in the Gusthead work.

The primary and secondary options-screen audit replaced twenty generic bases
with input-bit, timer, state, and relative-handler-table evidence. The Jampan
attack/defeat audit replaced sixteen more and corrected a label that implied
both defeat offsets converge, though the code only gates completion on the
primary offset. The known `NAME-002` queue falls from 301 to 265; no ROM bytes
changed.

The Sharpssteel blade, vertical-oscillation, horizontal-steering, and palette
pass reviewed 35 records: 26 previously counted generic bases, seven bases
from two newly recognized boilerplate sentences, and two separate imprecise
claims. The source now names direct steering toward `PlayerCenterX` and the
toggle of acceleration phase rather than a supposed shared target or instant
velocity reversal. The known `NAME-002` queue falls from 265 to 239, with
22 boilerplate sentences covered by the release audit.

The Sirene pass reviews 43 exact-address records. Twenty-seven state-machine
records now cite the controller field, branch, timer, or state-specific side
effect that supports each name. Sixteen pose-render and interpolation records
formerly shared a single broad sentence; each now cites its actual command,
loop bound, field, or helper call. The latter sentence is added to the
release audit's known-template list, so this pass closes it explicitly.
`NAME-002` falls from 239 to 212 across 23 known boilerplate sentences.
No source instruction or ROM byte changed; visual boss identity remains a
separate seven-record hypothesis queue.

The Medusa controller pass checks 45 state entries and branch labels against
the actual dispatch table and instructions. Their evidence now records the
input bits, pose and velocity fields, command values, timers, transition
targets, and render paths local to each address. The unusual rightward
velocity branch at `$056E44` is described as written, without assigning a
speed-limit interpretation. `NAME-002` falls from 212 to 167; the count of
known template sentences remains 23. No source instruction or ROM byte changed.

The Valkirie battle-controller pass checks 38 state and branch records against
their local instruction streams. Four labels were narrowed: random attack to
random state selection, dual shot to state-$22 selection, rising attack to
state-$C rise, and collision event to a close-range event check. No projectile,
collision, or attack identity is inferred from those branches alone. The
records now identify the relevant event bits, bounds, motion fields, part
pointers, and transition targets. `NAME-002` falls from 167 to 129; ROM bytes
remain unchanged.

A second Valkirie battle-controller pass reviews 36 state-entry, state-update,
and render-path records from its 19-entry dispatch table. Each now cites its
local event bit, timer or pose field, selected script, and transition. Calls
to the gated bullet-spawn helper are described as calls, not guaranteed
spawns. `NAME-002` falls from 129 to 93; the 23-template detector is unchanged.

Ten Valkirie auxiliary-group branches in the rendering module now cite the
actual flag bits, angle limits, timer, sine-table lookup, and velocity fields
at their addresses. The names were already narrow enough, so this pass
updates evidence only. `NAME-002` falls from 93 to 83; no ROM bytes changed.

Fifteen palette, tile-index, font-DMA, and boss-asset records now cite their
actual pointer or sentinel, loop bounds, bit masks, bus-acquisition branch,
or asset-table fields. The two timed Sirene records distinguish their type,
graphics pointer, and palette command. `NAME-002` falls from 83 to 68;
ROM bytes remain unchanged.

The Jampan core follow-up reviews 30 previously generic branch/return bases.
Two state names were corrected: `$0496AA` waits for `MessageSequenceState`,
not object clearing; `$049898` waits for `BossCounterMaxFlag` bit 0, not a
stage-motion flag. Their return labels and state-record evidence were
updated too. The 30 records now cite their actual counters, fields, branch
conditions, or transition writes. `NAME-002` falls from 68 to 38; `; was:`
provenance and ROM bytes remain unchanged.

The Jampan attack/defeat follow-up replaces 24 shared return bases with their
actual timer, radius, angle, offset, palette-index, or object-position exit
condition. The former shield-descent label at `$049E9A` was misleading:
the unsigned branch waits while the object's Y is at least `$60` and advances
only below `$60`. Its state and return names, references, and basis now say
that directly. `NAME-002` falls from 38 to 14; only Missiray remains in the
current known-template queue.

The final fourteen Missiray return records in the previous 23-template
detector now cite their actual loader flag, segment-ready byte, attack
sequence offset, timer, or palette-frame gate. That queue reached zero.
A broader duplicate-basis scan immediately exposed 457 records matching
seventeen additional boilerplate sentences across rendering, palettes,
UI, and asset families. The release audit now tracks 40 known templates.
This is expanded accounting, not a reversal of the reviewed source work;
the 457 records require address-specific evidence before the 1.0 tag.

The first follow-up on the expanded queue replaces the 18 exact-match
"The counting frames return here" records with their actual timer, flag,
state, or spawn-gate condition. These include five Z-Leo ending states and
thirteen object, effect, and enemy paths. `NAME-002` falls from 457 to 439;
the broader 40-template detector remains in force.

The full-screen palette-fade pass replaces 41 generic local-branch bases.
Each record now distinguishes its black/white direction, source and
destination buffers, red/green/blue component clamp, progress threshold,
or completion side effect. Four paths are kept separate: from black, to
black, from white, and to white. `NAME-002` falls from 439 to 398 without
changing ROM instructions.

The sprite mapping and OAM pass reviews 66 records across priority-bucket
initialization, linked OAM output, static and dynamic mappings, table-frame
selection, and appended cutscene/world entries. Two previously shared generic
bases are replaced per renderer record; a third table-frame variant is added
to the detector before its six records are retired. `Sprite_AppendOAMEntries`
had a subtle evidence error: `MOVEA` preserves CCR, so its `BEQ` tests the
earlier `SpriteOAMEntryCount` load, not the OAM write pointer. The source now
says this explicitly. `NAME-002` falls from 398 to 332 under 41 known
templates; ROM bytes remain unchanged.

The sprite object-pipeline pass replaces two shared boilerplate bases in 30
records with exact-address evidence for list traversal, object flags, dynamic
mapping cache and DMA queue handling, and two distinct timed-sequence formats.
The active DMA paths call `Gfx_PrependDMATransferCommand`; the offset-sequence
scan stores the next entry separately from resolution of the current mapping.
`NAME-002` falls from 332 to 302 under the same 41-template detector. Source
instructions and ROM bytes are unchanged.

The stage-intro pass reviews 20 banner and sprite-layout records against their
counter, state, glyph-loader, sound-request, and packed tile-index operations.
The label at `$00AEF6` was misleading: it does not clamp X, but converges after
the conditional cap and checks the stage-number sound timer. It is now named
`StageIntro_CheckStageNumberSound`. `NAME-002` falls from 302 to 282; the label
change preserves assembled bytes.

The remaining-time bonus pass reviews 26 exact-address records covering its
glyph setup, radial motion, hold, BCD score path, sprite writes, and tile
layout. `Results_SlowTimeBonusSpin` did not change angle, and the subsequent
`Results_FinishTimeBonusSpin` only waits before storing completion time. Their
current names and the shared radial renderer now state those narrower roles;
the dispatch table and cross-reference comments were updated together.
`NAME-002` falls from 282 to 256, with byte identity retained.

The shared message-render pass reviews 26 records across radial text movement,
hold and wait states, sine/cosine sprite coordinates, tile-index expansion,
glyph DMA setup, and compact line-sprite writing. The former fade-in and
fade-out names were inaccurate: these states move Y and wait on a hold timer,
without changing palette or brightness. The dispatcher, source cross-references,
and audit names now say this. `NAME-002` falls from 256 to 230.

The encoded message-script pass reviews 26 exact-address records for dispatch,
glyph-row nibble substitution, DMA commands, and four-word tilemap chunks.
`MessagePackedDigitsA/B` were incorrect RAM aliases: the two longwords are
scratch copies for high and low pixel-nibble tests, so source and RAM map now
name that role. The `$FFFE` command queues 256 words of tile art to VRAM
`$5E00`; it does not write the tilemap, so its label is corrected to
`MessageScript_QueueTileArtDMA`. `NAME-002` falls from 230 to 204.

The primary and secondary options-menu pass checks 20 records against their
existing instruction-specific bases. Their first basis already identifies
the exact state gate, input bits, cursor offsets, dispatch table, or secondary
selection clamp. The redundant second sentence that merely cited assembler
listing references is removed. The `$C` code/data-overlay slot remains
explicitly unresolved; no unsupported name is assigned. `NAME-002` falls
from 204 to 184 without changing source or ROM bytes.

The four-slot weapon-selection pass replaces shared evidence in 19 records
with their exact slot-offset, angle, radius, input-bit, and state operations.
The old `WeaponSelect_StartCloseDelay` label hid a fallthrough: after queuing
sound $A7 and setting cooldown eight, control enters
`Weapon_AdvanceCurrentState` without returning. Its source label, provenance
record, and comment now state the full transition. `NAME-002` falls from 184
to 165 with byte identity preserved.

The weapon-setup pass checks 33 addresses, including 21 previously known
generic-basis records. It corrects force-cursor versus slot-cursor names,
the exit tilemap-fill state, and a supposed three-sprite loop that has no
back edge. More importantly, the setup scroll writes `SecondaryCameraYPos`
by four, not an X position by one. Nine other bases falsely described a
closing sprite fade. Both false sentences are added to the known detector
before being retired with exact instruction evidence. The count falls from
165 to 144 under 43 known templates; ROM bytes remain unchanged.

The controller-layout and weapon-setup background pass reviews 31 addresses.
Each state and branch now cites its input bit, index bound, or render write;
the background records cite phase arithmetic, 97 raster-line words, two
mirrored offset passes, twenty eight-longword pattern groups, and seven-byte
dither columns. A `ClearBackgroundTileLoop` label was wrong: it seeds patterned
rows, so it is now `WeaponSetup_SeedBackgroundTileRows`. `NAME-002` falls from
144 to 113. Two ROM quirks are documented as static facts rather than guessed
intent: the controller lookup can store out-of-range index 26 on a miss, and
phase `$01500000` indexes one word beyond each ten-word palette data run.

The boss asset-set pass checks 32 exact-address records against their direct
callers, entity-type words, optional graphics lists, and palette commands.
The source `DATA XREF` comments now name the current callers, including both
Jampan paths. Types `$3EC`, `$3F0`, and `$3F4` remain neutral because their
dormant callers and asset pointers do not prove a visual identity. `NAME-002`
falls from 113 to 81; the seven separate visual hypotheses remain open.

The 29 graphics-load lists now cite their referencing asset sets and every
tagged source/destination pair before `$FFFF`, including Wolf Garopa's two tile
art sources and the shared Valkirie/Sirene list. Two numeric source cross-
references became symbolic, and the shared list now shows both owners.
`NAME-002` falls from 81 to 52 without changing assembled bytes.

The 35 palette-command records reached through boss asset sets now cite their
exact owning pointer, header offsets, destination bytes, inclusive color counts,
and first/last encoded color words. Epsilon 1 has three embedded commands;
the `$3F4`, `$3FC`, and Z-Leo records have two each. The loader reads only one
header per call, so later command boundaries are recorded as data, not as an
automatic playback sequence. Two numeric cross-references became symbolic.
`NAME-002` falls from 52 to 17; neutral entity types remain neutral.

The remaining 17 palette records are now checked against the palette loader
and all symbolic offset-list references. Three extracted banks split cleanly
into 13, 5, and 9 complete commands; the inline Stage 17 bank contains four.
Every statically listed nonzero offset lands on a command header. Two labels
were corrected from the byte evidence: the frontend block contains two
commands (`FrontendPaletteCommands`), while the Artemis transition contains
one (`SevenForcesArtemisTransitionPaletteCommand`). The curated 43-sentence
`NAME-002` queue reaches zero. This does not finish the wider duplicate-basis
review or resolve the seven visual identities. The release-audit test now
injects a known generic sentence to test the rejection path, instead of
assuming the repository itself still contains one.

An exact-address audit of all 15,833 name records against the assembler
listing found two false addresses inherited from numeric `nullsub` IDs:
`WeaponSetup_IdleState` is `$01F494`, not `$000053`, and the unreferenced
visual-asset RTS is `$012110`, not `$01210E`. `make verify-symbols` now checks
every audit name against the uncollapsed listing, including aliases and
24-bit-normalized RAM equates, so a wrong address cannot pass the release gate.

A wider duplicate-basis scan found twelve weapon-setup records carrying both
an inaccurate table summary (it claimed a fade state) and a vacuous local-role
sentence. The seven actual handlers are loadout, control input, exit input,
exit tilemap fill, control-test text, confirmation, and idle. All twelve
records now cite their local dispatch, loop, text destination, or branch
effect. The status-label entry points were renamed to include the selected
controller type they also render. Both retired sentences are guarded by the
release audit, raising the known-template set from 43 to 45 while keeping its
match count at zero; the remaining duplicate-basis review is still open.

The next duplicate-basis pass checked ten shared message-dispatch records and
nine shooting-mode input/rendering records against their local code. It
replaced three more repeated summaries with address-specific conditions,
state writes, table dimensions, and graphics-finalization effects. The input
label at `$01F1D2` had its direction reversed: pressed bit three chooses the
nonzero MOVING mode when D1 is zero, so it is now
`WeaponSetup_CheckMovingModeInput`. The curated detector grows from 45 to 48
sentences and still has zero matches. This static review does not establish
the seven visual boss identities or close the remaining duplicate-basis scan.

Ten weapon-state records in the same wider scan now cite their precise active-
slot pointer, signed cooldown tests, relative handler-table lookup, display-
index mapping, transient-field clearing, and saved-slot restoration. The
label at `$017C40` did not write `WeaponStateIndex` as its former name claimed;
it is now `Weapon_FinalizeStateTransition`, matching its icon-transfer state,
cooldown, and object-block effects. Two retired shared evidence sentences join
the detector, bringing it from 48 to 50 known templates with zero matches.
The rest of the duplicate-basis and visual-identity reviews remain open.

The 958 content lines in the player sprite-mapping bank were divided only at
the complete mapping records `$0E8A1A` and `$0E8E6A`. Three named modules now
own movement/dash (345 lines), state/fall/weapon animation (416), and special/
death mappings (200); `src/main.s` retains their exact ROM order. The source
text slices concatenated byte-for-byte before three descriptive comments were
added. The layout map now has 385 modules: 214 in the preferred 200–700 band,
146 shorter, 25 longer, none over 1000. The rebuilt ROM passed `make verify`
and `make compare` byte-for-byte, and `make verify-symbols` matched every
15,833 name record to the freshly assembled listing.

The next mapping-layout pass divided the shared-combat bank at `$0E953C`,
between its 73 complete frame records and 34 relative-offset animation
streams. The two files are 264 and 466 lines, and the original text slices
concatenated exactly before their explanatory headers were adjusted. Include
and layout order still follows the ROM. There are now 386 modules, 216 inside
the preferred 200–700-line band, 146 shorter, and 24 longer; the maximum
remains 986. `make verify` and `make compare` confirm byte identity, while
`make verify-symbols` confirms all 15,833 audited addresses against the new
listing. Numeric frame suffixes remain neutral because mixed consumers do not
establish a shared visual identity.

The 939 content lines of the Seven Forces intro were split at complete state
and function boundaries `$054F9E`, `$05523C`, and `$0555C8`. Four cutscene
modules now own setup/debug (321 lines), form sequences (207), finale and
effects (283), and post-battle transitions (132); all remain under
`cutscenes/`, preserving the earlier ownership correction. The original
source slices reconstructed the old text exactly before four module headers
were added. The layout now has 389 modules: 219 in the preferred band, 147
shorter, 23 longer, and none over 1000. `make verify` and `make compare`
confirmed byte identity; `make verify-symbols` matched all 15,833 records.

The 811-line multi-boss metasprite registry has also been divided at whole
owner groups `$034DB6` and `$0352A6`. Explicit filenames list the owners in
each ROM-ordered group: Antroid through Xi-Tiger (280 lines), Madam Barbar
through Sharpssteel (318), and Wolf Garopa/Valkirie/Z-Leo (217). The slices
reconstructed the old file exactly before descriptive headers were added.
The shared initializer format and Valkirie/Z-Leo dual-use data remain as
previously audited. There are now 391 modules: 222 preferred, 147 shorter,
22 longer, none over 1000. `make verify`, `make compare`, and
`make verify-symbols` confirm unchanged ROM bytes and 15,833 audited addresses.

The 725-line sequence-command block was split at `$083B0A`, after the FM
instrument parameter/register tables and before the channel-vibrato handler.
The 355-line dispatch/instrument module and 372-line channel/extended-command
module remain adjacent in `src/main.s`; command and extended-command dispatch
still resolve to their original addresses. The old source slices concatenated
exactly before adding file headers. Inventory is now 392 modules: 224 in the
preferred band, 147 shorter, 21 longer, none over 1000. `make verify` and
`make compare` confirm byte identity, and `make verify-symbols` confirms all
15,833 name-audit addresses against the listing.

The 765-line SFX payload module was divided at `$0967EC`, where the ROM-order
track IDs jump from `$EF` to `$40`. One file holds request IDs `$A0`–`$EF`
(401 lines); the next holds `$40`–`$7F`, then `$F0`–`$FC`, including the
existing 32KB PCM alignment (367 lines). The source slices concatenated
exactly before explanatory headers were added. Layout now has 393 modules:
226 preferred, 147 shorter, 20 longer, none over 1000. The 20 long modules
are all boss-specific, but their cohesion still needs review under
`LAYOUT-001`. `make verify`, `make compare`, and `make verify-symbols` confirm
ROM byte identity and all 15,833 audit addresses.

The 986-line Xi-Tiger core is now three adjacent ROM-order modules: 509 lines
of battle states, 286 lines of defeat/rendering, and 191 lines of pose
animation. The split points are the `Boss_XiTigerBeginDefeatLeap` entry at
`$03DEBA` and `Boss_XiTigerUpdatePoseAnimation` at `$03E21C`; concatenating
the three source bodies reproduces the old file line for line. The shared
`Boss_ApplyDefeatPaletteFade` entry stays in its original ROM position inside
the defeat/rendering module; Shellshogun still calls it across modules. The
layout now contains 395 modules: 228 preferred, 148 shorter, 19 longer, with
an 887-line maximum. `make verify`, `make compare`, and `make verify-symbols`
confirm the canonical ROM bytes and all 15,833 name-audit addresses.

The 887-line Bugmax controller module is now two ROM-order owner slices.
`bugmax_controller_and_geometry.s` keeps the main handler, geometry modes,
and state dispatcher (427 lines); `bugmax_opening_states.s` starts at the
actual main-state table `$04C3D8` and owns encounter setup, opening scroll
thresholds, and linked-part spin (461 lines, including one new header).
Before the header, the two source slices concatenated exactly to the old
file. The layout now has 396 modules: 230 preferred, 148 shorter, 18 longer,
with an 878-line maximum. `make verify`, `make compare`, and
`make verify-symbols` confirm unchanged ROM bytes and address provenance.

The 878-line Deep Strider source has three procedural regions in ROM order:
controller/intro/battle (488 lines), defeat and dive-motion helpers (224),
then linked-part rendering and angled projectile creation (166). Boundaries
are the `Boss_DeepStriderBeginDefeat` entry at `$03EBCA` and
`Boss_DeepStriderUpdateParts` at `$03EED8`; concatenation of the three files
is exactly the prior source. The short final module is kept cohesive rather
than padded with unrelated code. The layout now has 398 modules: 232 within
the preferred 200–700 band, 149 shorter, 17 longer, with an 869-line
maximum. `make verify`, `make compare`, and `make verify-symbols` confirm
canonical bytes and all 15,833 exact-address name-audit records.

The Sunset Sting state at `$04309E` exposed a false visual-transition
description in the name audit. Its state body increments `BossCombatCounter`
by two and exits only on `BossCounterMaxFlag` bit zero; the gameplay HUD sets
that bit when it clamps the counter to `BossCombatCounterMax`. Four labels in
this state now describe the refill/oscillation, limit selection, and maximum
check rather than an unproven arena transition. Their exact-address evidence
was corrected, while the state entry retains hypothesis level because the
Sunset Sting visual owner has not been confirmed by pinned runtime evidence.

The thirteen state-eight weapon-targeting records that shared the same two
whole-routine sentences now cite their own threshold, motion-table lookup,
indicator initialization, lock-on scan, or collision-list selection
instructions. The old `Weapon_State8CompareTargetValue` label at `$017DDE`
actually sits on `dbf` and the final selected-pointer store; the comparison
is at `$017DE8`. Both labels were corrected, with previous names retained in
the exact-address audit. This removes one repeated-basis cluster from the
wider `NAME-002` review without claiming that the entire review is closed.

Five state-$0A weapon records repeated a claim that palette slot 54 was a
"gauge". The code instead selects a direction-vector pointer from the active
slot's value and writes one of four frame-indexed Genesis colors to both
active and shadow palette slot 54; state $0C writes the same palette slot for
its icon animation. No static consumer identifies the state-$0A color as a
gauge. The five labels and their exact-address bases now state only the
motion-index and palette-color operations; the former names remain traceable
in the audit registry.

The state-$02 weapon handler's former "damage" value is actually the initial
projectile lifetime. Its ammo thresholds select even values `$08` through
`$0E`; `Weapon_FireProjectile` copies that word to object field `$5E`, then
`Weapon_InitProjectileSprite` changes the object to type `$14`, whose update
handler decrements `$5E` as a timer. Two labels and the RAM-map explanation
were corrected. Five state-$06 records now cite their own frame/slot speed
choice, sine-derived velocity, ammo-offset clamp, or direction-vector lookup;
the latter two labels were corrected from misleading table-selection/clamp
names. Exact-address audit history and ROM bytes remain unchanged.

State-$04 and state-$08 weapon setup were also calling six type-$A0 objects
"indicators" without evidence. The actual type-$A0 handler checks its field
`$48` against a nearby parent type and copies that parent's sprite transform.
State $04 stores `$22C` there, the type assigned to spread projectiles; state
$08 stores `$6C`, the seeking-projectile type. Four state-$04 and two
state-$08 labels now identify companion initialization and continuation,
while the state-$04 exit label names its branch to the targeting reticle.
The RAM-map description distinguishes those companions from the actual
weapon-selection slot sprites.

The five state-$0C icon records also had one whole-routine evidence sentence.
They now separately explain the null-pointer/terminal-frame returns, bounded
frame advance, ShootingMode selection of the second 16-color ramp, and the
tile/art-source preparation followed by a jump into
`UI_QueueWeaponStateIconTransferFromSource`. The former `Load...Frame` label
was too strong for a routine that only queues a DMA command; it is now
`Weapon_QueueState12IconFrameTransfer`. The color table's plural name records
its two ramps. This completes local review of the adjacent state-$02 through
state-$0C groups, not the wider `NAME-002` registry.

The 41 full-screen palette-fade records were checked again at their own
addresses. Each already had a local instruction-level basis, so the two
identical whole-routine sentences were removed from every record. One local
basis at `$000F20` was wrong: `move.b (PaletteFadeProgress).w,d5` reads the
high byte of that word on the 68000, not its low byte. The basis and source
header now say so. This removes a repeated-basis cluster without changing
the assembled fade or closing the wider `NAME-002` review.

The SFX and voice-test menu paths exposed another two boilerplate clusters:
18 records now state their own held/pressed-input gate, wrap boundary, index
change, BCD-render destination or request-table range. Six branch labels
called a selection index a request ID or called an input test an ID test;
they now identify the actual index/input operation. Voice navigation covers
all 38 table bytes (indices zero through `$25`). SFX navigation covers
combined-table indices zero through `$98`; the trailing `$FB/$FC/$FF` request
bytes are present in ROM but outside that normal navigation range. This is
static menu-flow evidence, not a claim that no other state can read them.

The adjacent BGM-test path has eight more formerly duplicated bases. The
selected 32-byte record supplies a request byte and 15 label tile words;
the render path stages one row verbatim and a second row with each tile word
incremented, then queues two tile DMA operations. Its preserved payload is
704 bytes, or 22 records, while the normal menu wraps at index `$14` and
therefore selects 21. All eight records now state address-local operations;
the final record's other possible uses are not inferred.

The 26 Counter Force code, branch, and frame-table records that shared two
family-wide sentences now carry one address-specific basis each. The review
followed grounded, airborne, ceiling, and Seven Forces state timers; the
effect constructor and position handoff; the C-plus-down dash check; and the
four primary/secondary sprite-frame pairs. The preserved terrain entry at
`$015372` has no symbolic executable caller or state-table pointer in the
current source, but that does not prove it never runs. Its name was narrowed
from `Unused` to `Unreferenced`, with its original `; was:` marker retained.
The adjacent Counter Force sprite-art records were left for a separate pass.

The 17 adjacent Counter Force mapping/art records have now been reviewed
separately. Four mapping addresses are tied to the four ordered primary-frame
table entries and their four, three, two, and four piece pointers. Each of
the thirteen art addresses now names the exact mapping pointer expression
and preserved `binclude` payload it supplies. Source comments explain why
the physical ROM art order differs from the piece indices. This establishes
pointer ownership and byte provenance, not an inferred appearance for any
individual piece.

The neighboring weapon-selection review replaces two shared button-A
sentences in 23 normal, recovery, ceiling, and Seven Forces code records.
Each basis now identifies its own pressed/held-input branch, signed cooldown
gate, selector state, terrain exit, or sprite-render handoff. The normal
ground and ceiling start paths retest a direction bit already excluded by
their initial branch; comments preserve that observation without removing
the original instructions or assuming no other entry could ever exist.

Ten raster-effect initialization/descriptor records now have local evidence
instead of a shared claim that the loader copies only the following handler.
`LoadFuncToRAM` actually reads an explicit byte count at the ROM source and
copies that many longwords into `HBlankRAMCode` at `$FFFFEE00`. The seven
reviewed descriptors request `$20`, `$40`, or `$200` bytes. The third VBlank
initializer at `$0014EE` also now cites its actual VSRAM-two command rather
than preserving the earlier CRAM mistake. In particular,
the Stage 10 descriptor copies ROM `$1848..$1A47` into RAM
`$FFFFEE00..$FFFFEFFF`, extending past its HBlank handler into adjacent ROM
code. No copied bytes or descriptor lengths were changed.
