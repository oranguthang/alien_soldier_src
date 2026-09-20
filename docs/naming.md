# Naming contract

Names describe behavior only as strongly as the available evidence permits.
The source currently contains thousands of names from an earlier automated
interpretation pass; those names are hypotheses until reviewed.

## Rules

- Prefer `Subsystem_ActionObject` for behavior with direct evidence, for
  example `Sound_LoadZ80Driver`.
- During migration, leave an existing address-derived name unchanged until its
  references have been reviewed. Release 1.0 contains no live address-derived
  identifiers: unresolved definitions receive stable role-neutral names and a
  corresponding unknowns-register entry. A wrong semantic name is worse than
  an explicit unknown.
- Use a broad role-neutral concept name for a module whose exact ownership is
  not yet established. ROM addresses and containers such as `bank` or
  `boss_code` are not module identities.
- Preserve the original IDA symbol through its `; was:` provenance mapping
  when renaming a definition.
- Record corrections to earlier generated semantic names, including their
  evidence basis, in `config/name_audit.json`.
- Rename all references atomically and require `make verify` afterward.
- Do not infer behavior solely from a caller name that is itself provisional.

## Subsystem vocabulary

Every definition in assembly source must satisfy one of three rules, which
`make lint` checks:

- the name is owned by a declared subsystem, which is the segment before the
  first underscore or, for a name without one, its leading capitalised word;
- the name derives from a symbol that exists, as `Owner_Detail` derives from
  `Owner` and `Block_End` from `Block`;
- the name is a declared hardware exception.

The vocabulary is the `naming.subsystem_vocabulary` list in
`config/source_policy.json`. It is closed: a name owned by a token that is not
on the list fails lint until the token is added deliberately. The list was
adopted from the reviewed state of the source at Source Reconstruction 1.0
rather than designed in advance, so it records which subsystems this program
actually has.

The hardware exceptions are the definitions in `src/equals.inc`,
`src/ports.inc` and `src/ram_addrs.inc`, which name the machine rather than the
program, plus two sets named by their formats: the twelve 68000 exception
vector targets referenced from `Sys_VectorTable`, which keep the name of the
vector they serve, and the Mega Drive cartridge header fields, which keep the
name the header format gives them.

## Evidence levels

- `unknown`: no supported semantic claim.
- `hypothesis`: plausible static interpretation; not independently verified.
- `static`: supported by instructions, data flow, and call sites.
- `runtime`: observed through a named emulator scenario or trace.
- `confirmed`: supported by independent static and runtime evidence, or by an
  authoritative hardware/data-format specification plus matching behavior.

Descriptions and maps must state the level when a reader could otherwise
mistake a hypothesis for a confirmed fact.

An `evidence` value alone is not proof: its `basis` must identify the relevant
instruction, field, table, caller, or observation. Sixty Gusthead template
bases have now been replaced with record-specific evidence, but a wider scan
found 301 records elsewhere matching other generic sentences. Reviewing the
options, Jampan, Sharpssteel, Sirene, Medusa, Valkirie, graphics/asset, and
Missiray paths exhausted that initial queue. A wider duplicate scan then
exposed 457 records matching 17 more generic sentences; 18 timer-return,
41 palette-fade, 66 OAM/mapping, 30 object-pipeline, 20 stage-intro, 26
time-bonus, 26 message-render, 26 message-script, 20 options-menu, 19
weapon-selection, 33 weapon-setup loadout, 31 controller/background, 32 boss
asset-set, 29 graphics-list, 35 asset-set palette-command, and 17 standalone
or banked palette-command records have since been reviewed. The curated
`NAME-002` detector now has zero matches across 68 known sentences. A wider
duplicate-basis review is still required before the 1.0 tag; zero matches do
not prove every explanation or name correct.
The read-only `make semantic-audit` now counts the wider duplicate queue, and
`--duplicate-bases` on its underlying script locates each repeated sentence
by address and source module. The queue includes legitimate uniform data
tables, so each group still needs a semantic decision rather than automatic
rejection.
Accepted uniform groups are recorded in `config/duplicate_basis_reviews.json`
with a reason and exact address, name, and module membership. The release audit
reopens a review if its membership changes and blocks `tag-ready` while any
group remains unreviewed. The eight `Player_AnimationFrameTable` mapping
entries are the first accepted group: the frame helper masks its index with
`$1C` and the eight table slots point to those mappings in order. This does
not assert what any frame looks like. Two more accepted groups cover 69 shared
combat mapping records actually reached by relative-offset animation streams
and 33 stream headers consumed by `Anim_ResolveTimedMappingFrame`. Three
Stage 15 fragment mappings were excluded from that mapping group and renamed
for their direct pointer-table consumer. A fourth accepted group covers the 40
Seven Forces rotation frames selected by nine labelled table bases. Table1
has an extra unlabelled eight-pointer run; its reachability is not inferred
from the masked eight-slot renderer. A fifth accepted group covers the 33
`Enemy_ProjectileSpriteMapping` records selected by ten named relative-offset
animation streams. A sixth covers 30 Shellshogun mappings selected by six
rotation tables, direct metasprite/body assignments, or the rotating-part
frame table. A seventh covers the 26 encoded TYPE strings, with table order
and decimal bytes checked against their names. The old 23-way Bugmax sentence
was not valid for hit fragments, central-part selection, linked-part tables,
and two projectile animations; those names and bases are now role-specific.
The shared weapon-setup text sentence also hid two executable handlers; they
now have code-level bases, while 20 actual encoded strings have an exact-member
review. The Shield Viper mapping sentence also mixed body-angle, controller-
angle, initialization-tail, and orbit-shot records; those 19 names now follow
their actual pointer tables, including the mapping shared by an auxiliary
record and the shot animation. A ninth exact-member review accepts 18 Teddy Bear
frames whose relative animation entries and high-bit terminators are checked;
it does not infer that the streams without direct callers run in gameplay.
Antroid's 18-way sentence was different: two direct blink mappings and two
eight-frame rotation tables were not one interchangeable family. Their names
and exact-address bases now follow those consumers; the primary table runs
in reverse ROM order. Jetsripper's 18-way sentence mixed a shared initial
segment mapping, head/body/tail tables, a direct dive-windup mapping, and a
two-frame movement cycle; those owners now have separate names and evidence.
Xi-Tiger's 18-way sentence likewise hid two direct metasprite entries and two
eight-frame rotation sets, each consumed once forward and once backward. The
names and exact-address bases now follow those four tables and descriptor
slots. A tenth exact-member review accepts 17 phase-pattern mappings: every
one is a relative target of the seven selector streams and has a high-bit
terminator. Madam Barbar's 16 mapping records form two distinct eight-frame
sets; the four rotation tables select them in exact forward/permuted and
reverse orders. Their names and bases now state those relationships rather
than suggesting unspecified direct assignments. The remaining queue has
232 groups. Terobuster's 16 former generic mappings are now split into
primary and secondary rotation frames, with reverse and forward table order
verified; the first secondary frame also has direct linked-record assignments.
An eleventh exact-member review pins 13 Stage 10 Wasp mappings to the four
selector streams and high-bit terminators; selector `0C` is also assigned by
the defeat-conversion path. A twelfth exact-member review confirms 13
Sharpssteel byte streams are loaded into the blade-pose interpreter and end
with its command terminators; that test does not certify their visual poses.
Eleven palette-offset lists also have a common loader-format claim and exact
static owners. The two-list Continue record was excluded from that group:
only its first list has a direct source pointer, and the second list's
reachability is unresolved. The remaining queue has 228 groups.
Nine Valkirie battle-state pose scripts share direct `lea ... (pc),a1` paths
into `Anim_UpdateValkiriePoseScript`; an exact-member review pins those paths
and their stream endings. Three airborne scripts were excluded because the
state-E selector first stores their addresses in `$41C(a5)` for indirect use.
Their former High/Mid/Low labels implied visual height that the selector does
not prove, so they now have neutral Pattern00/01/02 names and individual
selection-path evidence. The 12 middle longwords of the two shared pattern
RAM rows also have one reviewed structural basis: the four-iteration mask loop
consumes eight longwords from each row, while other scene users overlay those
addresses. Destroyer Proto's former 11-frame sentence mixed five animated-part
mappings, five projectile mappings, and one intro-only part mapping; these now
have separate owner names and exact table-slot evidence. The repeated-basis
queue has 225 open groups.
Seven visual boss identities remain hypotheses (`NAME-003`).

## Mechanical style

- Global labels and EQU definitions begin in column zero; instructions and
  directives remain indented.
- Only `src/main.s` owns include directives.
- Source paths are lowercase and source files end with a newline.
- Assembly lines are at most 200 characters. This accommodates imported XREF
  comments without allowing generated annotations to grow without bound.

The preservation subset of these rules is currently enforced by `make lint`.
The stricter destination and its migration order are declared in
`config/source_reconstruction_1_0.json` and `docs/modularization_plan.md`.
Passing mechanical style checks never establishes semantic confidence in a
label.
