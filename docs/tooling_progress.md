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
