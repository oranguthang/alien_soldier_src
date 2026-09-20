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

The nine READY/FIGHT banner-state records no longer inherit one sequence-wide
description. Their bases now identify the delay expiry that installs the
glyph source, the glyph-load completion and sound/timer setup, the held READY
line, the FIGHT start and phase-split store, and the offset/velocity update
that renders the moving line. The three return labels state their actual
converging paths. This is instruction-level evidence; no timing or visual
appearance was inferred from a screenshot.

Seven frame-timing backdrop records now distinguish the 16-command register
7 cycle from the separate blank and restore helpers. The cycle uses indices
`$F..0`, and all three paths are gated by the signed
`FrameTimingDebugFlag`. The code writes temporary or saved register values
directly to `VDP_CTRL`; it does not edit CRAM or the shadow words. A source
comment and each address basis now say that precisely. Only the cycle has a
symbolic caller in the current source; the other helpers are not declared
globally unreachable from that fact alone.

Six scroll-DMA queue records now separate the horizontal and vertical
destinations, source-address encoding, register-11 mode bits, transfer lengths,
and queue-head commit sites. The horizontal per-line command encodes `$1C0`
words (448); the vertical per-column command encodes `$28` words (40); their
full-screen branches each encode two words. The previous shared sentence
described both routines at every address, including the return labels.

Five Counter Force input/field records now state their own countdown, trigger
write, first-press rearm, or unconditional health-delta store. The timer is
decremented before input testing; a first B press seeds `$10`, and a second
press during the next sixteen updates sets trigger bit zero. The RAM map now
describes both that ordering and the `PhoenixAttackStatus` publication.

Six source-unreferenced pickup and RAM-clear entries were also checked at
their exact starts. Their audit bases now say only that no symbolic executable
caller names each entry and then describe its local work; no global runtime
dead-code conclusion is inferred. The pickup entry at `$02BD30` was renamed:
its condition is health unequal to maximum, not health below maximum. The
two clear helpers retain their measured 8 KiB and 128-byte ranges.

Sixteen directional-movement primary/secondary sprite mappings now cite their
actual longword-table index and byte offset, partner stream, and count of
art-piece pointers. The animation state cycles `$48(a5)` through offsets
`$00,$04,...,$1C` and indexes both tables with the same value. In both ROM
mapping banks, frame 07 physically precedes frame 00; comments and the two
frame-07 bases distinguish ROM order from animation order. No pose identity
was inferred from the numeric frame index.

Nine directional-spawner entries at `$02A154..$02A270` no longer share one
sequence-wide sentence. Their exact-address bases distinguish setup, the
signed X-acceleration choice, the timed radial-particle path, motion toward
the player Y, even-frame trail allocation, and each return. The `$02A198`
branch stores `$A000`, which the update sign-extends and adds to X velocity;
its label now says negative X acceleration rather than merely alternate.
This is static instruction evidence, not a claim about visual ownership or
runtime reachability.
The old shared sentence is the 51st known generic basis rejected by
`make release-audit`; zero records still match the curated detector.

Nine Valkirie pose-script records at `$056190..$056224` now cite their own
event-prefix, `$FFFE` stop, `$FFFF` loop, frame setup, interpolation, and
part-traversal instructions. The label at `$0561B6` was narrowed from a
general decoder to the stop-marker check it actually performs. The standalone
RTS at `$0561C8` is identified only as a no-op, without claiming it is
reachable. Their old sequence-wide sentence is now the 52nd rejected generic
basis; `NAME-002` still has zero matches in the curated detector.

The read-only semantic audit now reports exact duplicate-basis groups as a
separate review queue, joined back to source modules. At introduction, the
registry contained 254 repeated sentences across 1,212 exact-address uses;
those were not 1,212 proven naming errors, since many are uniform ROM-ordered
sprite or mapping records. All 1,212 uses resolved to a source module. The CLI
can list the largest groups or every member of a filtered group without a ROM
build or emulator. The module join now scans all definitions, including names
without a `; was:` marker; the unit test covers both marker-bearing and
marker-free names plus repeated text within one record.

The nine Sirene position/distortion records at `$05783C..$05799A` exposed a
misleading shared premise: the first position pair is the real
`PlayerXPosition`/`PlayerYPosition`, not a private effect anchor. The entry
adds angle-derived deltas to the player coordinates; a separate `$70/$74(a5)`
pair is then advanced and bounded before the routine writes mirrored plane-B
horizontal and vertical scroll offsets. Branch names now describe the next
operation at each address rather than a preceding clamp. The old nine-way
sentence is the 53rd known generic basis and has zero remaining matches.
After this pass the wider duplicate queue contained 253 groups across 1,203
uses, with zero unmapped uses; it was not a closed semantic audit.

Nine Medusa pose-script records at `$057044..$0570D8` now cite their own
event-prefix, `$FFFE` stop, `$FFFF` loop, frame setup, eight-channel
interpolation, and pose-buffer operations. Four labels were narrowed to the
specific marker check, loop check, part-traversal preparation, or delta
calculation they perform. The standalone RTS at `$05707C` remains a no-op
with no symbolic source caller, not a claim of runtime unreachability. Its
old nine-way sentence is the 54th rejected generic basis. After this pass the
wider queue contained 252 groups across 1,194 uses, with zero unmapped uses.

Eight Valkirie direction/sign records at `$055FD8..$05604A` now distinguish
the conditional negation of X velocity, the exact `d3=+1/-1` conditions, and
the shared field-$54 setter. The old comment called nonzero `$54` a leftward
facing flag, but the code only proves that it triggers negation; the setter
writes `$100` for nonnegative player X delta and is also called by Artemis.
The formerly Valkirie-only helper now has a neutral shared name. The old
eight-way sentence is the 55th rejected generic basis. The wider duplicate
queue contained 251 groups across 1,186 uses, still with zero unmapped uses.

Six defeat-blink RTS records across generic, Stage 10, and Stage 12 enemy
handlers no longer assert that only the visible half returns there. Each
active-timer path sets object bit 7, then either keeps or clears it according
to bit zero of timer byte `$49`, and both paths reach the same RTS. Their
expiration branches differ: some queue SFX `$BC`, one checks the Stage 12
yacht type before hiding or dropping a pickup, and the pickup arguments `7`
and `$F` are random-size masks, not pickup type IDs. The old sentence is the
56th rejected generic basis. After this pass the duplicate queue contained
250 groups across 1,180 uses, with zero unmapped uses.

Seven Missiray loop labels at `$053838..$053CF0` now distinguish their exact
four- or eight-segment ranges, `$60`-byte record stride, V-scroll bounds,
ready-flag scan, offset clear, activation fields, and defeat-timer table.
All seven are real loop entries, so their names remain; the shared sentence
was inadequate evidence because it attached the same operation to different
loops. It is now the 57th rejected generic basis. After this pass the wider
queue contained 249 groups across 1,173 uses, with zero unmapped uses.

Six Medusa horizontal-steering records at `$056E6E..$056EA2` exposed a
false function boundary and a false clamp claim. The `$056E6E` entry loads
the scripted X target from `$11E(a5)` and falls through into the shared
comparison at `$056E72`; it does not return after loading. The comparison
selects `-$2000` steps for targets left of current X and `+$2000` steps for
equal-or-right targets. Its signed thresholds only skip later steps; an
allowed step can cross the threshold, so they are not hard saturation limits.
The source names, comments, and seven affected audit bases now reflect the
two-entry flow. The old six-way sentence is the 58th rejected generic basis;
the wider queue now contains 248 groups across 1,167 uses, none unmapped.

The first valid duplicate-basis group is now explicitly reviewed rather than
silently left in the queue: eight `Player_StateAnimationSpriteMapping00..07`
records describe the same `Player_AnimationFrameTable` relationship. The frame
helper masks its accumulator with `$1C`, and the eight ordered longwords select
exactly those mappings. `config/duplicate_basis_reviews.json` pins the basis,
the eight addresses, names, modules, and the reason; any membership drift
fails the audit. A regression test also pins the consumer's `$1C` mask and
eight pointer slots, so the acceptance cannot outlive that evidence unnoticed.
The queue is still 248 total groups, one accepted and 247
unreviewed. This validates the review mechanism, not the remaining groups.

The largest remaining duplicate sentence exposed a real scope error. It
claimed that `Anim_UpdateFrame` and `Sprite_PrepareOAM` connected all 72
shared-combat frame records, but those are retired names and the final three
records are not animation-stream targets at all. The actual resolver is
`Anim_ResolveTimedMappingFrame`, and the ordinary draw path calls
`Sprite_RenderMapping`. The 69 stream-referenced frames now cite that path;
their exact target set is accepted with a regression check against every
relative `dc.w Frame-*` operand. The three excluded records are Stage 15
fragment mappings selected directly in `Projectile_FragmentSpriteFrames`;
they now have `Projectile_FragmentSpriteFrame00..02` names and individual
zero-based table-slot evidence. The neighboring 33 shared animation headers
also cite the current resolver and have a separate exact-member review. Six
other bases and `docs/unknowns.md` were corrected where they still used the
retired resolver name. A test rejects those retired names in current evidence
while preserving them in `previous_name` provenance. Both old repeated
sentences are now rejected by the
curated detector as entries 59 and 60. The wider queue remains 248 groups,
with three reviewed, 245 open, and 1,164 exact-address uses in total.

The 40 Seven Forces rotation frame records have a uniform table-owner basis
that the source supports: nine labelled table bases collectively point to all
40 mappings, and the eight-frame renderer masks its byte offset with `$1C`.
The table section also revealed eight extra pointers after Table1's first
eight slots. A masked index from Table1 cannot reach that second run, and no
separate symbolic base for it is established, so its wider reachability stays
unknown. The source comment and unknowns register now state that limitation.
The exact 40 members and the nine table spans (Table1 is 16 pointers; the
others eight each) are pinned by a regression test. The wider queue is still
248 groups, now four reviewed and 244 open.

The 33 `Enemy_ProjectileSpriteMapping` records form another valid uniform
mapping group. Each appears as a relative `dc.w Mapping-*` target in the ten
`Enemy_ProjectileAnimation00..09` streams, and
`Enemy_ProjectileAnimationPointers` enumerates those ten streams for
`Anim_UpdateProjectileAnimation`. The frame suffixes remain ROM ordering, not
visual-pose claims. The exact 33-to-10 relationship is pinned by a regression
test; the separate eight-entry directional table is not mistaken for eight
additional streams. The wider queue is now five reviewed, 243 open.

All 30 `Boss_ShellshogunSpriteMapping` records have one of three static owners:
the six eight-entry `Boss_ShellshogunRotationFramesA..F` tables, direct body or
metasprite assignments, or the four-slot rotating-part frame table. A source
test checks all 30 names against those owner operands and pins the six table
lengths and rotating-part order. The common basis claims only mapping
selection and ROM order, not a visual pose. Six duplicate-basis groups are
reviewed; 242 remain open.

The 26 `WeaponSetup_ControlTypeXXText` records also share justified evidence.
`WeaponSetup_ControlTypeTextPointers` lists them exactly in index order, and
`WeaponSetup_RenderSelectedControlType` uses `WeaponSetupControlIndex * 4` to
select a longword. A regression test checks all 26 eight-byte strings: the
common TYPE prefix, the matching decimal digit codes (`1` for zero through
`$A` for nine), single-digit spacer, and `$FF` terminator. That makes the
`TYPE 1` through `TYPE 26` claim checkable rather than inferred from labels.
Seven duplicate-basis groups are reviewed; 241 remain open.

The former 23-way Bugmax frame basis combined unrelated owners into one
sentence. The source now separates two hit-fragment mappings, two central
toggle mappings, secondary and primary linked-part frames, battle/opening
controller frames, three angle-selected central frames, three opening linked
frames, and spread/sine projectile frames. Each exact-address record cites its
specific table slot, initializer store, angle condition, or animation entry;
the old sentence is the 61st rejected generic basis. A regression test checks
the role-specific source references, linked-part pointer orders, two animation
streams, and the absence of the retired 23 names. The wider queue shrinks to
247 groups across 1,141 uses: seven reviewed and 240 still open.

The 22-way weapon-setup text sentence concealed two executable routines.
`WeaponSetup_LoadControlTestText` was renamed to
`WeaponSetup_RenderControlTestRowsAndLoadPalette`: its loop queues eight
layout rows and then enters the palette loader. `WeaponSetup_RenderExitText`
is also code; its separate basis now cites the EXIT pointer, position, and
tail call to the text renderer. The remaining 20 records are `dc.b` strings.
A regression test decodes their A–Z glyph bytes, checks the names against the
visible word prefixes, and requires each to have a setup-screen `lea` or
`dc.l` reference. Those exact 20 members are accepted; the two handlers have
their own instruction-level test. The wider queue stays at 247 groups across
1,139 uses: eight reviewed, 239 open.

The former 19-way Shield Viper mapping basis mixed four different consumers.
`Boss_ShieldViperBodyAngularMappingRecords` selects four body-angle frames;
`Boss_ShieldViperControllerAngularMappingRecords` selects four controller
frames; the final six body initialization records use three tail mappings;
and `Projectile_ShieldViperOrbitShotAnimationRecords` selects eight orbit-shot
frames. The second shot frame is also assigned to the first auxiliary record,
so its audit basis records both uses without asserting a visual identity.
All 19 definitions and exact-address audit records now have owner-specific
names and distinct, table-slot evidence. A regression test checks the 24
initialization records, both eight-slot angle tables, and the nine animation
records. The old shared sentence is the 62nd rejected generic basis. The
queue is now 246 groups across 1,120 uses: eight reviewed, 238 open.

The 18 Stage 12 Teddy Bear mapping records share a defensible table-level
claim. Each A-R mapping is the target of a `dc.w Mapping-*` entry in the
adjacent timed streams, and each ends with a sprite command whose first word
has bit 15 set. `Anim_ResolveTimedMappingFrame` adds those signed offsets to
the stream cursor. An exact-member review and a regression test pin all 18
targets and their terminators. Streams named `UnreferencedTeddyGroupAnimation*`
have no proven source caller; neither the review nor the test claims runtime
reachability or a particular visual pose. The 246 groups remain; nine are
reviewed and 237 open.

The former 18-way Antroid mapping basis also mixed owners. Two direct
mappings are selected as default and alternate by the blink renderer and
reused by state paths. The primary rotation table points to eight mapping
records in reverse ROM order; the secondary table points to eight in forward
order, with its first mapping also assigned directly to linked records.
Those 18 definitions now have role-specific names and individual address-
level bases. A regression test pins both pointer orders, the blink selector,
and the direct secondary-frame assignment. The old common sentence is the
63rd rejected generic basis. The queue drops to 245 groups across 1,102
uses: nine reviewed, 236 open.

The old 18-way Jetsripper mapping basis concealed six selection paths.
The first mapping is shared by initialization and the head table, so it is
not labeled head-only. Two more mappings occur in the four-slot head table;
nine belong to the quantized body-direction table; three serve the tail;
one is assigned directly during dive windup; and two form a FrameCounter-
selected movement cycle. All 18 definitions now have owner-specific names
and exact-address bases. A regression test pins the four, sixteen, four,
and two pointer orders plus both direct assignments. The old sentence is
the 64th rejected generic basis. The queue drops to 244 groups across
1,084 uses: nine reviewed, 235 open.

The 18-way Xi-Tiger mapping basis mixed two direct metasprite-descriptor
entries with two eight-frame rotation sets. Frames 01-08 are selected by
forward table A and reverse table C; frames 10-17 by forward B and reverse D.
The other two mappings occupy descriptor slots 2 and 7, and slot 12, with
attribute arithmetic; neither belongs to the rotation tables. The source and
exact-address audit now use role-specific names and per-slot evidence. A
regression test pins all four eight-pointer orders and three direct descriptor
references. The old sentence is the 65th rejected generic basis. The queue
drops to 243 groups across 1,066 uses: nine reviewed, 234 open.

The 17 `Enemy_PhasePatternSpriteMappingA` through `Q` records share an exact
stream-level basis. All are referenced by `dc.w Mapping-*` entries across the
seven streams selected by `Enemy_PhasePatternAnimationBySelector`, and each
mapping ends with a high-bit sprite command. The new exact-member review is
backed by a regression test of all 17 targets, mapping terminators, and the
seven-entry selector table in `shared_enemy_helpers.s`. It does not assert
that every selector is reached in every runtime state or assign visual poses.
The 243 groups remain; ten are reviewed and 233 open.

The former 16-way Madam Barbar mapping sentence claimed pointer tables or
direct assignments, but all 16 records belong to two eight-frame rotation
sets. Table A selects the first set in a non-ROM permutation and B reverses
that exact order; C selects the second set in ROM order and D reverses it.
The source and exact-address audit now name the two sets and record each
table slot. A regression test pins all four pointer sequences. The old
sentence is the 66th rejected generic basis; the queue is 242 groups across
1,050 uses: ten reviewed, 232 open.

The former 16-way Terobuster mapping sentence also mixed two owner tables.
The primary eight-frame table selects mappings in reverse ROM order; the
secondary table selects its eight frames forward. Its first frame is also
assigned directly during falling-rock and landing paths. All 16 records now
carry primary/secondary names and individual table-slot bases, and a
regression test checks both orders plus three direct writes. The old sentence
is the 67th rejected generic basis. The queue is 241 groups across 1,034
uses: ten reviewed, 231 open.

The 13 Stage 10 Wasp mapping records A-M share valid stream-level evidence.
Every one is targeted by a self-relative entry across four selector streams,
and every mapping ends with a high-bit sprite command. The selector table is
read by `Enemy_UpdateStage10WaspAnimation`; selector `0C` is also assigned
directly in the defeat-conversion path. An exact-member review and regression
test pin all targets, mapping endings, the four table slots, and this second
assignment without claiming an exclusive runtime role or visual pose. The
241 groups remain: eleven reviewed, 230 open.

The 13 Sharpssteel pose-command records share a valid interpreter-level
claim. Each is a `dc.b` stream loaded by a named `lea ... (pc),a1` site in
the core or blade module; the assembly update path calls
`Boss_SharpssteelRunBladePoseCommands`, and manual control calls it directly.
Each stream ends in `$FF,$FF` or `$FF,$FE`. An exact-member review and test
pin the 13 names, source references, terminators, and interpreter connection.
They do not, by themselves, prove the higher-level visual pose names. The
241 groups remain: twelve reviewed, 229 open.

The 12-way shared palette-offset-list sentence contained one exception.
`ContinueScreenPaletteOffsetLists` holds two consecutive zero-terminated
four-offset lists at `$00B95A` and `$00B964`, while `Continue_InitializeScreen`
passes a direct pointer only to the first. Its exact-address basis now states
both lists and leaves the second list's reachability unresolved. The other
11 records each define one terminated signed-offset list, have a screen,
cutscene, or stage-configuration source pointer, and are consumed by
`Gfx_LoadMultiplePalettes` relative to `Gfx_LoadPalettePreservingSharedColor`.
An exact-member review and test pin their terminations, offset expressions,
static owners, and the loader arithmetic. The queue remains 241 groups over
1,033 uses: thirteen reviewed, 228 open.

The 12 Valkirie battle-state pose scripts had one shared sentence, but only
nine are loaded directly by `lea Script(pc),a1` before
`Entity_RenderValkirieBattleAnimation` calls `Anim_UpdateValkiriePoseScript`.
Those nine form a reviewed exact-member group with checked `$FFFE`/`$FFFF`
stream endings. State E selects the other three by storing a pointer in
`$41C(a5)`; the shared airborne updater loads it indirectly. The former
High/Mid/Low names inferred visual height from branches that also contain
random fallbacks, so source labels and six exact-address audit records now
use neutral Pattern00/01/02 names with individual selection evidence. Two
regression tests pin both the direct and indirect paths. The queue is 241
groups across 1,030 uses: fourteen reviewed, 227 open; seven separate visual
boss identities remain hypotheses.

The 12 SharedPatternRow0/1Long1-6 records have the same structural, not
scene-specific, claim. Their equates run at four-byte intervals in two
32-byte RAM rows. `Effect_ApplyTransitionMask` begins at the two row bases,
reads and writes two longwords per row in each of four iterations, and thus
covers elements 0-7; elements 0 and 7 have separate boundary evidence. A
new exact-member review and regression test pin all 12 addresses, row aliases,
and loop shape. The queue remains 241 groups across 1,030 uses: fifteen
reviewed, 226 open.

The 11 Destroyer Proto mappings previously shared one part-or-projectile
sentence. The 16-entry animated-part table selects frames 00-04, the
16-entry projectile table selects a distinct five-frame family, and the
two-entry intro part table additionally selects one standalone mapping plus
animated-part frame 01. Their source names and exact-address bases now
follow those three owners and each table position; a regression test pins all
three pointer sequences. The old sentence becomes the 68th rejected generic
basis. The queue falls to 240 groups across 1,019 uses: fifteen reviewed,
225 open.

The eleven Missiray bullet sprite mappings do share an exact stream-level
claim. The initial stream points to frame 00; the loop stream selects
01/02/04/03 and loops to itself; the transform stream selects
00/10/05/06/07/08/09 and ends with `$FF`. The projectile initializer and
state handlers install these three stream pointers in the sprite-animation
field. An exact-member review and regression test pin the eleven targets,
three orders, loop/end commands, and pointer assignments. No visual
transformation stage is asserted. The queue remains 240 groups across 1,019
uses: sixteen reviewed, 224 open.

The eleven Bird mappings are all selected by relative frame entries in four
animation streams. Streams 00/01 traverse frames 00-06 in the same forward
and backward order with different delays; 02 loops among 07-09, and 03
selects 09/08/07/10 before its `$FF` end. The four pointers appear in
`Enemy_BirdAnimationMappings`, and each mapping ends in a high-bit sprite
command. An exact-member review and test pin the stream orders, loop/end
markers, selector entries, and mapping endings, without asserting visual
poses or gameplay reachability of every selector. The queue remains 240
groups across 1,019 uses: seventeen reviewed, 223 open.

The Shiper tentacle mapping sentence suggested pointer tables or direct
assignments, but all eight mapping labels are referenced only by the
eight-entry `Boss_ShiperTentacleDirectionFrames` table. The movement routine
masks each of two angles to `$E0`, shifts by three to index the table's
longword slots, then stores selected pointers in fields `$1E8` and `$2A8`.
The replacement shared basis states this exact table role without inventing
visual direction names; an exact-member review and test pin slot order
04/03/02/01/00/07/06/05 and one-sprite terminators. The old sentence is the
69th rejected generic basis. The queue remains 240 groups across 1,019 uses:
eighteen reviewed, 222 open.

The eight-way Medusa sentence mixed seven state-selected pose scripts with
one pose-frame-data base and repeated the already-disproved possibility that
these are initial interpolation delays. Every script has a direct
`lea Script(pc),a1` path into `Boss_RenderMedusaPose`, which invokes the pose
interpreter; each stream ends with `$FFFE` or `$FFFF`. The frame-data base is
instead stored in `$35C(a5)`, and the interpreter adds a script offset to it
before calculating deltas. `Medusa_InitialPoseChannelValues` already has
separate evidence for eight initial fixed-point values. The seven scripts
now have one exact-member review and test; the frame base has a unique
exact-address basis. The old sentence is the 70th rejected generic basis.
The queue remains 240 groups across 1,018 uses: nineteen reviewed, 221 open.

The eight former `Player_DeathParticleSpriteMapping` records did not map the
particles emitted by the fixed OAM loop. `Player_RenderDeathParticles` calls
`Player_WriteDeathParticleSprite` repeatedly and appends that scratch OAM
buffer first; only then does it shift `FrameCounter`, mask with `$1C`, and
index an eight-longword table to write a mapping pointer to player field
`8(a5)`. The table, eight mappings, and six referenced art-segment names are
now `DeathSequence`-scoped, while the true OAM particle writer retains its
name. Their audit records preserve the prior semantic names and original
IDA provenance; an exact-member review and test pin the operation order,
pointer table, and art references. Three obsolete sentences (particle-loop,
table, and mapping) join the rejected generic detector, now 73 entries. The
queue remains 240 groups across 1,018 uses: twenty reviewed, 220 open.

Sirene's seven-way pose-data sentence mixed three directly loaded pose
scripts, three scripts chosen indirectly through two four-pointer state-14
tables, and a frame-data base stored in `$35C(a5)`. The direct and indirect
families now have separate exact-member reviews and a regression test for
their references, terminators, table orders, pointer field, and interpreter
path; the frame base has individual offset-arithmetic evidence. In
`Sirene_State14PoseScript2`, five more words follow the first `$FFFE` stop
at `$057D0C`; no direct symbolic pointer to the tail at `$057D0E` is known.
The ASM now shows this boundary explicitly and the unknowns register records
the reachability limit. The old sentence is the 74th rejected generic basis.
The queue has 241 groups across 1,017 uses: twenty-two reviewed, 219 open.

The first eight `Sound_PCMBank` records form a real uniform bank group:
`PCMPart1` through `PCMPart8` occupy consecutive `$8000`-byte ranges from
`$098000` to `$0D8000`, and the PCM and voice DAC descriptor tables encode
their bases as `Sound_PCMBankN >> $8` followed by sample parameters. The
ninth asset begins at `$0D8000` but is only `$1A5E` bytes, so its separate
name evidence is not folded into the full-bank group. An exact-member review
and test pin addresses, lengths, binclude owners, and descriptor references
without inventing individual sample identities. The queue remains 241
groups across 1,017 uses: twenty-three reviewed, 218 open.

Sharpssteel's seven pose-command labels had shared one sentence claiming
pose-buffer access and direct interpolation-helper calls at every address.
The instruction paths instead distinguish the `$80` event, `$FFFE` stop,
`$FFFF` loop, target-offset setup, interpolation step, angle distribution,
and final part-position writes. Their seven audit records now cite the local
operations individually; a regression test pins each address and control
path. No visual blade pose is inferred. The misleading shared sentence is
the 75th rejected generic basis. The queue falls to 240 groups across 1,010
uses: twenty-three reviewed, 217 open.

Medusa's lower block had three more shared explanations that conflated distinct
control points: seven falling-part states and transitions, seven spawn-sequence
entry/branch/data labels, and two pickup-spawn branches. Sixteen exact-address
records now describe their own instructions or, for the binary-backed schedule,
its ROM range and pointer installation. A regression test pins the three-state
relative dispatch, the terrain-bit transitions, eight-byte cursor advance,
camera comparison, difficulty/record-type branches, pickup jumps, and the
`$0572B0-$0573E6` asset boundary. The old three sentences are the 76th-78th
rejected generic bases. The queue falls to 237 groups across 994 uses:
twenty-three reviewed, 214 open.

The Jampan encounter initializer indexes six parallel 16-slot tables but
consumes each differently: type into `(a0)`, radius into `$48(a0)`, sprite
attribute bits ORed into `$E(a0)`, two angles into `$4A/$4C(a0)`, and a
longword mapping pointer into `8(a0)`. The geometry updater later reads the
radius and angles. The former `OrbitingPartSpriteFrames` label was corrected
to `OrbitingPartMappingPointers`, with its prior semantic name and imported
`off_494FE` provenance retained. The two selected mapping records now refer
to the corrected table name. Six address-level explanations and a regression
test pin the table consumers, widths, sixteen slots, and pointer order. The
old shared sentence is the 79th rejected generic basis. The queue falls to
236 groups across 988 uses: twenty-three reviewed, 213 open.

Sharpssteel's collision helpers shared an explanation claiming that every
entry touches both collision flags and collision-value fields. The two enable
entry points do write their direct pair's values before reaching the shared
four-part enable tail, but the disable paths clear bit six without changing
any value word. The six-core-segment helper instead ORs `$50` (bits four and
six) into flag bytes and does not write values. Six exact-address bases now
state those distinct effects, with a test pinning the direct groups, linked
tails, and absence of value writes in the disable/core paths. The old sentence
is the 80th rejected generic basis. The queue falls to 235 groups across 982
uses: twenty-three reviewed, 212 open.

Sirene's type-$490 projectile had a `...TowardPlayer` label, but its motion
path subtracts projectile coordinates from `Entity57XPos/YPos`, not any player
coordinate. `Gfx_InitSireneBattleEffect` initializes that slot as type `$48C`
for this encounter. The label is now `...TowardEntity57`; its prior semantic
name and original IDA marker remain in the audit/provenance. The other five
labels in the former shared group now have separate evidence for bounds,
removal flag, status gating, pickup initialization, and type-$160 conversion.
The weapon-setup highlight group likewise separates its phase update, writes
to palette colors 49/50, and two eight-word tables; the generic sentence had
incorrectly included the background palette. Two new regression tests pin
these paths. The old sentences are the 81st and 82nd rejected bases. The
queue falls to 233 groups across 971 uses: twenty-three reviewed, 210 open.

Two sprite-mapping groups have now passed exact-member review. The three
periodic-shot enemy streams cover seven mappings, each with nine six-byte
sprite entries and a high-bit final entry. The four randomly chosen midgame
lightning streams divide into a 00/01/03 family referencing mappings 00-06
and a separate 02 family referencing 07-12. Mapping06 in the first family
contains only one sprite entry, so its old shared sentence's `composite`
claim was removed and registered as the 83rd rejected generic basis. The new
shared basis states only the relative frame-reference relationship, with no
visual pose or piece count inferred. Two tests pin all stream orders, table
selectors, exact member addresses, mapping lengths, and terminator bits. The
queue remains 233 groups across 971 uses: twenty-five reviewed, 208 open.

Joker and Shellshogun each have six contiguous `$20`-byte rotation tables of
eight longword sprite-mapping pointers. Their respective metasprite descriptor
tables reference all six. Joker's A/B, C/D, and E/F pairs traverse three
eight-frame mapping families in opposite orders; Shellshogun's A/B/C descend
their three families and D/E/F ascend them. Shellshogun's F table is also
indexed directly by `Boss_ShellshogunUpdateSpriteFlip` with an angle-derived
offset masked to `$1C`; the review does not claim it is descriptor-only.
Two exact-member reviews and one regression test pin all twelve addresses,
pointer orders, descriptor references, and this direct reader, without
assigning visual compass directions. The queue remains 233 groups across 971
uses: twenty-seven reviewed, 206 open.

The shared Z-Leo/Valkirie Force metasprite base at `$0355A4` has one exact-
member review for five mapping targets in its 16-longword descriptor run.
Z-Leo supplies this run as the mapping input `a0` alongside separate radius
and link inputs. Valkirie Force supplies the same base as all three inputs,
so its other two inputs reinterpret the bytes; static sharing does not prove
that both bosses display every mapping in the same way. The new test pins the
descriptor order, five mapping addresses and piece counts, high-bit endings,
both callers, and the initializer's distinct `a0/a1/a2` reads. No visual pose
identity or ROM-order meaning for the A-E suffixes is claimed. The queue
remains 233 groups across 971 uses: twenty-eight reviewed, 205 open.

The five Wolf Garopa type-$424 labels at `$02A0D6`–`$02A124` no longer share
one sentence claiming both allocation and timer-driven visibility. The two
boss-state callers invoke the allocator, which fills a free slot with type
`$424`, fixed sprite fields and timer `$40`; its separate return also handles
allocation failure. The update-table entry selects a different routine that
decrements the timer, expires on underflow and otherwise sets display bit 7
before testing timer-low-byte bit 2 to clear it. A regression test pins the
two callers, dispatch entry and branch instructions. The old sentence is the
84th rejected generic basis. The queue drops to 232 groups across 966 uses:
twenty-eight reviewed, 204 open.

The adjacent orb-animation labels at `$02A126/$02A128/$02A140` also carried
one sentence that wrongly treated all ten words as four selected pairs. The
reader masks its word offset with `$C`, selecting four pairs in the first
eight words. The two trailing words at `$02A150` are preserved verbatim but
not reached by that reader; their data/code role is now explicitly unknown
in `docs/unknowns.md`. The wrapper entry, frame reader, and table have
separate evidence and a test pins the mask, two writes, four selected pairs,
tail words, and caller. This is the 85th rejected generic basis; the queue
falls to 231 groups across 963 uses: twenty-eight reviewed, 203 open.

Two sprite-mapping groups now have exact-member reviews. The five
`Enemy_BehaviorSpriteMapping00..04` records contain 5/4/4/6/6 six-byte
pieces; both wait and grounded streams reference all five, and the attack-
cooldown stream additionally references frame 00. The five
`Enemy_CirclingAnimationSpriteMappingA..E` records are single-piece mappings
selected in order by the loop stream, each for two ticks before a self-
relative loop. Tests pin addresses, piece counts, high-bit terminators,
stream order, and the circling selector's pointer. The suffixes remain
ordering labels, not visual identities. The queue stays at 231 groups across
963 uses: thirty reviewed, 201 open.

Three player-mapping groups now have exact-member reviews for the five weapon
animation mappings and the five primary/alternate layout mappings each. The
weapon table has a sixth, distinct dash mapping beyond the five reviewed
records. Both layout tables list 00-04 by index but their mapping bodies occur
in ROM order 04/03/00/02/01; the terrain index tables yield only longword
offsets 0/4/8/C/10. The test pins all fifteen addresses, source-piece counts,
pointer slots, terrain index words and the separate weapon sixth slot. No
visual pose or ROM-order claim is inferred from an index suffix. The queue
remains 231 groups across 963 uses: thirty-three reviewed, 198 open.

Three Missiray indexed-transfer groups now have exact-member reviews: three
column wrappers, four column descriptors, and five direct indexed-row
wrappers. Column sets 00-02 each contain six words with header `$0102`, while
set 03 contains five with `$0101`; its wait state directly passes the
descriptor to `Tilemap_QueueIndexedColumns`, rather than invoking the named
loader claimed by the old evidence sentence. The latter is the 86th rejected
generic basis. Row set 01 uses a shared jump tail and set 06 is embedded in
a rise-state branch, so neither belongs to the five direct-wrapper members.
The test pins all exact addresses, wrapper/descriptor pairs, header lengths,
shared-tail exception, and set-03 branch path. The queue remains 231 groups
across 963 uses: thirty-six reviewed, 195 open.

The five HBlank `$20` length fields at `$001422`, `$001532`, `$00159E`,
`$001948`, and `$001AD2` previously shared a sentence calling `$20` the size
of the following handler. `LoadFuncToRAM` actually copies eight longwords
from the address immediately after each length word. The handlers reach
`rte` before that 32-byte window ends, so the copies also include 14, 14,
4, 14, and 24 bytes respectively from the following ROM routine. Their five
records now state the individual start/end addresses and spill lengths; a
test pins the install-list pointers, `$20` fields, handler boundaries, and
loader loop. The old statement is the 87th rejected generic basis. The
queue falls to 230 groups across 958 uses: thirty-six reviewed, 194 open.

The four Valkirie-rendering labels that shared a vague control-flow sentence
were distinct: three branches update/clamp `$1FC/$1F8(a5)` against signed
scaled targets, while the fourth writes active Seven Forces palette colors.
The palette's other shared sentence was also wrong: `FrameCounter` bit zero
chooses restore versus flash, but seven battle callers supply fixed byte
offsets `0,6,$C,$12,$18,$1E,$24` into the 21-word color table. The six
records now have local instruction or caller evidence, and the source comment
no longer calls the triplet frame-selected. A regression test pins the three
velocity paths, seven callers, table size and three palette writes. The old
sentences become the 88th and 89th rejected generic bases. The queue falls
to 228 groups across 952 uses: thirty-six reviewed, 192 open.

The four Options choice strings at `$00A220/$00A22A/$00A232/$00A248` have
an exact-member review grounded in the message/BGM/SFX and difficulty
handlers. The toggle renderer consumes a1 and a2 only through their first
`$FFFF` terminators, after 4/3/10/9 tile words respectively. The broad
sentence treating these specific tile strings as possible request IDs or
unclassified menu data was replaced by per-record evidence and added as the
90th rejected generic basis. Two more terminated strings follow the
SuperHard record at `$00A25C–$00A283`; they have no direct symbolic source
pointer, so their role/reachability is recorded in `docs/unknowns.md` rather
than attributed to the difficulty toggle. The test pins all four addresses,
consumer pointers, terminators and trailing boundaries. The queue is now 227
groups across 948 uses: thirty-seven reviewed, 190 open.

Four scroll-DMA RAM records now distinguish the storage buffers at
`$FFFFE400/$FFFFEC00` from the longword source-pointer fields at
`$FFFFF710/$FFFFF714`. Reset writes the buffer addresses into the pointer
fields; the clear and scroll-plane routines address the buffers themselves;
the horizontal/vertical DMA builders read the pointer fields and select
two versus 448/40 words using VDP-register-11 bits 1/2. Eight per-record
evidence sentences replace the two broad shared sentences, now the 91st and
92nd rejected generic bases. A test pins all four RAM addresses, reset
assignments, direct buffer writers, DMA destinations and mode lengths. The
queue falls to 225 groups across 940 uses: thirty-seven reviewed, 188 open.

The four Sharpssteel blade-graphics labels at `$048898/$0488EA/$0488F0/$0488F4`
did not all perform the same writes. The first two load the A/B mapping tables;
the third enters the shared writer with six iterations; the fourth is the loop
that masks and ORs tile attributes and stores each mapping pointer. Their
records now carry separate instruction evidence. A regression test pins both
table selectors, the six-entry mapping lists, and the writer loop. The broad
shared sentence is the 93rd rejected generic basis. The queue falls to 224
groups across 936 uses: thirty-seven reviewed, 187 open.
