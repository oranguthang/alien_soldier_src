# Unknowns register

The machine-readable thresholds live in `config/source_policy.json`.

At the start of release 0.5 work the source contained 10,497 defined symbols
with neutral address-derived names: 9,493 ROM labels and 1,004 RAM equates.
This is a burn-down ceiling: new such names fail lint, while evidence-backed
work should reduce the count. The preservation contract does not require zero,
but Source Reconstruction 1.0 does. An unresolved release-quality name must be
role-neutral, independent of its address, and registered here with its evidence
level.

The first evidence-backed RAM pass reduced the live count to 10,493 by naming
`GameModeIndex`, `GameSubstateIndex`, `StageTableIndex`, and
`Entity_ObjectPool`. Their old address names remain in provenance markers.

The first Sonnet-label audit reduced it again to 10,491 by naming the two
graphics-effect handler tables at `0x0040AC` and `0x00432E`. The corrected
dispatcher claims and their static evidence are recorded in
`config/name_audit.json`.

The asset-bank reconstruction reduced it to 10,488. `SegaScreenPalette` is
confirmed by its 16-color payload and the frontend copy loop. Two address-based
placeholders became role-neutral unknowns pending stronger evidence.

The first subsystem-complete naming pass reduced it to 10,379 by replacing all
109 address-derived definitions in `src/system/`. Branch targets now carry
their owning routine and control-flow role; tables and text carry their static
consumer role. Every replacement retains its imported name in a `; was:`
marker.

The `src/math/` and `src/demo/` pass replaced 45 directly address-named
definitions plus five associated `_End` labels. It also corrected the imported
description of `Math_SquareRoot`: the implementation is a restoring bit-pair
algorithm, not Newton-Raphson. During this audit the policy was strengthened to
recognize address suffixes on every IDA type prefix, including `sprite_*`,
`tiles_*`, and `_End` labels. The honest expanded baseline is therefore 11,262
live address-derived definitions; this exposes 928 names that the equivalent
post-pass count under the earlier narrow regex would have missed.

The credits pass reduced the expanded count to 11,152 by replacing all 110
address-derived definitions in `src/credits/`. Its 20 numbered scene pairs are
named by their verified order in `Credits_SceneDataPointers`; character or
staff-role claims are deliberately deferred. Five demonstrably incorrect
generated Z-Leo names are recorded in `config/name_audit.json`.

The debug and shared-effect pass reduced the count to 11,063. The sprite editor
was separated from 22 cross-subsystem sprite-frame tables, the misplaced
Shield Viper block was reclassified under `src/bosses/`, and the unrelated
`Object_CopyDataBlock` helper was moved into `src/gameplay/`. Six generated
Shield Viper names that described pattern-buffer rendering as movement,
palette, cleanup, or shooting logic are recorded in the name audit.

The collision pass reduced the count to 10,982 without splitting its two
cohesive 525--566-line modules. Static data flow corrected eleven generated
names, including an alleged OAM writer that actually checks the player's
special-attack object, and an alleged Stage 17 initializer that resolves
contact with a moving platform's underside. The corrections and evidence are
recorded in `config/name_audit.json`.

The shared-object and Jetsripper-stage actor pass reduced the count to 10,902.
The 682-line helper library remains cohesive under
`src/actors/shared_object_helpers.s`; the adjacent 457-line state-machine block
was moved between its real Jetsripper neighbors as
`src/enemies/jetsripper_stage_actors.s`. Static control flow also exposed
generated names that claimed velocity calculation, projectile destruction, or
boss-specific behavior where the code actually updates display priority,
stamps terrain tiles, or interprets a callback script. These corrections are
recorded in the name audit.

The weapon-system pass reduced the count to 10,775 by replacing all 127 live
address-derived definitions in `src/weapons/`. The ROM-ordered block now uses
three cohesive 397--649-line weapon modules; its unrelated 51-line shared
object-pool clearing primitive moved to `src/system/object_pool_clearing.s`.
Static control and data flow corrected generated claims about player rendering,
damage thresholds, sprite priority, and particle spawning. The code actually
dispatches weapon fire, removes objects at state or animation boundaries, and
updates multi-state effects. These corrections are recorded in the name audit.

The effects pass reduced the count to 10,644 by replacing all 131 live
address-derived definitions in `src/effects/`. Its five modules are already
cohesive and remain between 68 and 682 lines. The audit corrected several
generated VDP and palette claims: the affected routines only build, clear, or
mask transition buffers in RAM, with a separate helper queuing the eventual
VDP-register update. The wave-buffer clear was also documented at its actual
DBF count of 81 longwords rather than 80. These corrections are recorded in
the name audit.

The gameplay-infrastructure pass reduced the count to 10,417 by replacing all
227 live address-derived definitions in `src/gameplay/`. Its existing modules
were already cohesive and remain between 14 and 478 lines. Static audit
corrected generated claims about projectile trajectories, boss-only clearing,
Destroyer-MK2 palette loading, weapon-icon selection, and VDP/LZSS behavior.
The code actually scans object pools, applies shared camera motion, converts
the stage number to BCD, and distinguishes direct memory decompression from
staged VRAM DMA. These corrections are recorded in the name audit.

The HUD ownership correction reduced the count to 10,406 by replacing the 11
address-derived definitions in the block formerly stored as
`src/player/physics.s`. Instruction-level inspection proved that the block
does not apply friction or update any entity velocity: it builds, terminates,
and submits a HUD sprite list. It now lives at
`src/ui/hud_sprite_list.s`; dependent gameplay and Xi Tiger labels no longer
claim a physics step. The corrections and their evidence are recorded in the
name audit.

The player-terrain pass reduced the count to 10,346 by replacing all 60
address-derived definitions in `terrain_collision.s`, `terrain_responses.s`,
and `terrain_wrappers.s`. The three ROM-adjacent modules remain cohesive at
276--619 lines. Their handlers are now named by the actual five-point probe
geometry and by mechanically visible alignment operations. Static audit also
removed false velocity, acceleration, gravity, animation, boss, and player
ownership claims from shared terrain code. The strongest corrections are
recorded in the name audit.

The player input/status pass reduced the count to 10,332 by replacing all 14
address-derived definitions in `input_and_status.s`. Branches and hitbox data
now describe their mechanically visible roles. The three palette data sets
remain neutral variants because their selection conditions are visible but
their precise gameplay meanings have not yet been established.

The player-rendering pass reduced the count to 10,306 by replacing all 26
address-derived definitions in `rendering_and_defeat.s`. It also corrected
generated boss/death claims attached to ordinary ground and ceiling movement,
composite-sprite construction, and the player's damage-impact object. Frame
tables with unproved visual roles retain neutral primary/secondary or variant
names. These cross-module corrections are recorded in the name audit.

The player projectile/effect pass reduced the count to 10,279 by replacing all
27 address-derived definitions in `projectiles_and_effects.s`. Its loops now
describe sprite-stream expansion, particle allocation, shot orientation, and
dash-trail state directly. Static inspection also proved that the generated
screen-pulse label was false: the routine builds four OAM entries for a
transient signed three-digit value and never accesses scroll or VDP state.

The player core-state pass reduced the count to 10,251 by replacing all 28
address-derived definitions in `core_states.s`. The state table and its branch
targets now expose the death, jump, landing, special-move, and damage phases.
Static audit removed generated boss physics/health claims from player damage
states, an invincibility claim from a display-bit setter, and death/collision
claims from ordinary player rendering helpers. These corrections are recorded
in the name audit.

The player cutscene/damage pass reduced the count to 10,222 by replacing all
29 address-derived definitions in `cutscene_and_damage_states.s`. Upper-terrain
idle and damage states, knockback physics, cutscene control, and the recovery
after a special move now have explicit branches. Object-free routines formerly
described as particle/debris spawners and a boss-victory path are now recorded
as the input-driven alternate-special state they actually implement.

The player air/ground pass reduced the count to 10,196 by replacing all 26
address-derived definitions in `air_and_ground_states.s`. Cross-checking each
handler against the player state table distinguished upper-terrain dash,
landing, counter, and armed-control states. It also removed generated Artemis,
credits, projectile, screen-side, and force-weapon claims from small player
animation, teleport, state-thunk, and mode-toggle routines.

The player falling/special pass reduced the count to 10,160 by replacing all
36 address-derived definitions in `fall_and_special_attack.s`. The long falling
handler now exposes its gravity, terrain, input, velocity-clamp, and rendering
phases without being split into artificial files. Static inspection removed
generated boss-part, Gusthead-intro, boss-health UI, and death-effect claims
from ordinary dash-exit, falling-transition, frame-selection, and armed-render
helpers.

The final player dash/Phoenix pass reduced the count to 10,118 by replacing all
42 address-derived definitions in `dash_and_phoenix.s`. All eleven modules in
`src/player/` now contain zero live address-derived definitions and remain
cohesive at 180--637 lines. The final state-table audit distinguished armed
lower-terrain state 0x04 and the active dash-attack handler from the generated
wall-idle, air-attack, and dash-cancel claims.

The weapon-selection object pass reduced the count to 10,106 by replacing its
12 address-derived branch labels. Static consumers and field accesses proved
that `0x02BB86--0x02BCFB` manages weapon-selection animation, input, counters,
and palette refresh rather than enemy or boss AI. The block therefore moved to
`src/ui/weapon_selection_object.s`; the following resource-pickup runtime begins
at the next dispatch-table handler in `src/actors/resource_pickups.s`.
The three corrected generated function claims are recorded in the name audit.

The pickup and explosion pass reduced the count to 10,077 by replacing all 29
address-derived definitions across the former shared-combat and
Snake/Bugmax blocks. Object type `$194` adds score and player resource on
collection; types `$1A0` and `$1A4` are the two explosion controllers created
by the adjacent spawn routines. That evidence produced three cohesive modules:
`resource_pickups.s` (145 lines), `explosion_patterns.s` (363 lines), and
`bugmax_debris_spawner.s` (98 lines). Generated boss-state, enemy-health, and
Snake-projectile claims were removed and recorded in the name audit.

The shared enemy spawn/movement pass reduced the count to 10,054 by replacing
all 23 address-derived definitions in the former `jetsripper_movement.s`.
The gameplay loop calls this block as a global spawn director: it allocates one
of four enemy slots and searches terrain near the player before creating entity
type `$1C`. The latter half supplies that enemy family's sprite, movement,
tracked-projectile, and defeat-object helpers. It now lives as the cohesive
348-line `src/enemies/spawn_and_movement.s`; generated Jetsripper/boss claims
are recorded in the name audit.

The shared projectile-attack enemy pass reduced the count to 10,031 by
replacing all 23 address-derived definitions in the former
`jetsripper_and_joker.s`. Its first state machine approaches, leaps, and fires
from the ground; its second emits difficulty-scaled bursts of homing
projectiles. Both use common enemy initialization and defeat-to-pickup paths,
with no Jetsripper or Joker state. The cohesive 290-line block now lives at
`src/enemies/projectile_attack_states.s`; six corrected generated claims are
recorded in the name audit.

The ship/shared-helper pass reduced the count to 10,020 by replacing all 11
address-derived definitions in the former `ship.s`. Its 38-line ship-patrol
controller now closes the preceding projectile-attack enemy module, while the
following 102 source lines are isolated as
`src/enemies/shared_enemy_helpers.s`. Those helpers implement facing, capped
gravity, terrain checks, visibility, and the next phase enemy's sprite and
animation setup. Generated boss, player-physics, and VDP-register claims are
recorded in the name audit.

The phase/circling pass reduced the count to 9,984 by replacing all 36
address-derived definitions in the former `phase_attacks.s` and `circle.s`.
Entity type `$28C` owns the phase-pattern state machine and type `$290` owns
its bouncing defeat-debris controller. The sprite, rotation, and circular
motion helpers at the following ROM boundary travel with their circling-enemy
consumer. The result is a 218-line `src/enemies/phase_and_debris_states.s`
module and a 335-line `src/enemies/circling_enemies.s` module. Four materially
incorrect generated claims are recorded in the name audit.

The Stage 9 fly/Viblack shot pass reduced the count to 9,953 by replacing all
31 address-derived definitions in the former `stage_17.s`. The ROM ordering
interleaves the Stage 9 fly formation controller and its type-`$2A8` children
with Viblack's type-`$2F4` side shots and a four-shot sequence controller, so
the honest 371-line module is
`src/enemies/stage_9_flies_and_viblack_shots.s`. The old Stage 17 walker and
fly-death descriptions contradicted live constructors and state behavior;
those corrections are recorded in the name audit.

The bird-enemy pass reduced the count to 9,916 by replacing all 37
address-derived definitions in the former `bird.s`. The cohesive 460-line
`src/enemies/bird_enemy.s` now covers sprite setup, the complete fourteen-state
bird controller, directional shot creation, and the type-`$1DC` defeat-debris
handler. Direction claims were checked against signed velocity writes and the
engine's downward-positive screen coordinates; six contradicted generated
names are recorded in the name audit.

The falling-shot/Stage 10 wasp pass reduced the count to 9,894 by replacing
all 22 address-derived definitions in the former `stage_10_fliers.s`. Its first
handler is the generic type-`$2BC` falling shot created by the bird controller,
not a Stage 10 fly. The adjacent type-`$2C0` wasp and type-`$2C4` defeat debris
form the rest of the honest 287-line
`src/enemies/stage_10_wasp_and_falling_shot.s` ROM-ordered module. The two
incorrect Stage 10 fly claims are recorded in the name audit.

The Stage 12 enemy pass reduced the count to 9,865 by replacing all 29
address-derived definitions in the former `stage_12.s`. The 398-line
`src/enemies/stage_12_enemies.s` keeps the ROM-interleaved floater, launcher,
camera-attached turret, and their shared falling/debris states together. The
old main/attack/reload/check-player names were checked against state-table
ownership, constructors, and field accesses; six contradicted claims are
recorded in the name audit.

The Stage 10 beetle pass reduced the count to 9,844 by replacing all 21
address-derived definitions in the former `stage_10_ground.s`. Its alleged
bomber is the type-`$2DC` wave controller that creates and waits for type-`$2D4`
beetles at alternating screen edges. The cohesive 291-line
`src/enemies/stage_10_beetles.s` also owns beetle roaming, terrain bounces,
lower-bound exit, and type-`$2D8` defeat debris. Four contradicted generated
claims are recorded in the name audit.

The Stage 11 fish pass reduced the count to 9,793 by replacing all 51
address-derived definitions in the former `flyer.s`. Entity type `$454` is a
wave controller that creates type-`$44C` fish before the Gusthead encounter;
each fish rises into the playfield, tracks the player's height, optionally
fires a sixteen-shot homing volley, crosses the screen, and returns to its
outer edge. Its type-`$10` child is an attached projectile-origin sprite, not
one of the emitted shots. The cohesive 484-line implementation now lives in
`src/enemies/stage_11_fish.s`; contradicted generic-flyer, projectile, and
motion claims are recorded in the name audit.

The Xi-Tiger entrance pass reduced the count to 9,780 by replacing all 13
remaining address-derived definitions in the former
`src/cutscenes/train_and_xi_tiger.s`. Entity type `$45C`, created by the Stage
8 train initializer, drives Xi-Tiger's first train-roof appearance and jump;
entity type `$460`, created after the Stage 9 ship sequence, drives his jump
into the boss encounter. Both use the same palette, object setup, and sprite
frames, so the cohesive 223-line implementation now lives in
`src/cutscenes/xi_tiger_entrance_sequences.s`. Incorrect train-end, player,
dispatcher, and generic state claims are recorded in the name audit.

The orphaned radial-particle pass reduced the count to 9,766 by replacing all
14 address-derived definitions in the former `src/bosses/xi_tiger.s`. No code
or data reference, absolute ROM pointer, or entity-dispatch entry reaches any
of its three plausible entry points. Bounded breakpoint runs through all
90,000 frames of the pinned TAS likewise did not execute `0x02F1A2`,
`0x02F2A4`, or `0x02F2EC`. Static data flow identifies an input-adjustable
radius, randomized sine-based motion for eight candidate slots, and a child
state that follows changing parent angles; the empty slot-setup hook leaves
the released implementation incomplete. The honest 176-line module is
`src/debug/orphaned_radial_particle_test.s`; it remains separate despite being
below the normal target size because merging unrelated Antroid code would
obscure the ROM boundary. Incorrect Xi-Tiger and generic boss claims are
recorded in the name audit.

The stage-environment pass reduced the count to 9,755 by replacing all 11
address-derived definitions in the former
`src/bosses/antroid_and_debris.s`. The first state machine is shared by
sixteen entity types across multiple stages: spawn parameter `$5E` selects
one of eight terrain-layout bases, and its five forward/rewind frames are
written through `Gfx_DMATransferTiles`. It neither belongs to Antroid nor
implements a multi-shot enemy. The adjacent type-`$208` system is initialized
only by the Stage 10 graphics setup and continuously recycles six
non-colliding objects within screen bounds, so the unsupported debris claim
has been narrowed to ambient particles without asserting their exact visual
identity. Both environmental visual systems now form the cohesive 202-line
`src/effects/stage_environment.s`; fourteen materially incorrect enemy,
projectile, Antroid and debris claims are recorded in the name audit.

The Stage 12 yacht pass reduced the count to 9,712 by replacing all 43
address-derived definitions in the former `src/enemies/ship_cannons.s`.
Pinned-TAS breakpoints place the fixed-slot yacht controller at frame 23,660
and the small blue teddy-bear actor at frame 23,676; captured frames show that
actor boarding the yacht and later piloting it. Static data flow confirms that
the alleged cannon-spawn helpers instead update yacht motion, scrolling-plane
offsets and steering. The cohesive 545-line stage implementation now lives in
`src/stages/stage_12_yacht.s`. The adjacent 78-line
`src/debug/orphaned_cross_stage_handlers.s` remains a documented short-file
exception: its entity dispatcher has no known constructor and was not reached
in the full pinned TAS, while the following terrain-animation companion has no
live reference. Seventeen contradicted cannon, projectile and boss claims are
recorded in the name audit.

The Stage 18 pass reduced the count to 9,659 by replacing all 53 remaining
address-derived definitions in `src/enemies/stage_18.s`. Pinned-TAS execution
places the type-`$448` dispatcher at frame 41,189; the frame-41,220 capture and
RAM state show two visible blue worms, each represented by a head and a linked
twelve-segment chain. This turns the alleged floater, turret, Jetsripper spread
and missile/laser/homing routines into cohesive worm spawn, follower,
direction-frame, scatter and falling-segment states. A separate type-`$3DC`
actor is the moving platform visible at frame 41,500 and preserved by the
Destroyer-MK2 arena setup, not a boss constructor. The leading oscillator has
no known constructor and was not reached in all 90,000 pinned TAS frames, so
its orphan status is explicit. The resulting 641-line module remains intact;
its state-table and linked-object ownership provide a semantic boundary, not
an arbitrary line-count split. Sixteen materially incorrect generated claims
are recorded in the name audit.

The Stage 15 fragment-hazard pass reduced the count to 9,612. The pinned TAS
first executes entity type `$39C` at frame 31,751 while `StageTableIndex` is
`$1C` and the captured screen identifies Stage 15; its schedule creates seven
type-`$3A0` side emitters at camera thresholds. The first emitter initializes
at frame 31,798 and calls the type-`$3A4` fragment-cluster constructor at frame
32,001. Static flow shows that the cluster follows its emitter, expands into
linked directional fragments, reacts to impact or deflection, and applies
difficulty-dependent health. Entity types `$380` and `$384` execute in the
same scene at frames 31,751 and 31,782; their difficulty-selected schedules,
terrain collision and damped vertical bounce identify the falling-rock wave.
Gusthead and Jetsripper callers reuse the fragment projectile API, but neither
owns the implementation. The artificial 67-line
`src/enemies/falling_spawners.s` and 448-line
`src/bosses/jetsripper_weapons.s` split is therefore replaced by the coherent
663-line `src/stages/stage_15_fragment_hazards.s`; all 44 address-derived
definitions in the joined ROM range and three caller-local address labels are
gone. Thirty-three corrected generated claims are recorded in the name audit.

The Stage 11 rising-hazard pass reduced the count to 9,602 by replacing the
remaining ten address-derived definitions in the former
`src/enemies/stage_11_boss_parts.s`. Pinned-TAS breakpoints place entity types
`$388` and `$38C` at frames 21,765 and 21,778, and the captured screen plus
`StageTableIndex=$14` identify Stage 11. RAM captures show the type-`$388`
launcher below the playfield and three staggered type-`$38C` children rising
from below it; static flow confirms the launch, palette, hit-reaction,
projectile and removal states. The exact visual identity is not established,
so `src/stages/stage_11_rising_hazards.s` deliberately uses a behavioral name.
Its cohesive 269 lines are a documented below-target exception instead of
being padded with the adjacent but separately owned Gusthead linked chain.
Twenty-one corrected generated claims are recorded in the name audit.

The Gusthead linked-chain pass reduced the count to 9,587. Static ownership
shows that type `$390` allocates and links eight segments through offset `$44`,
using type `$394` for ordinary segments and type `$398` for the damageable
terminal segment. The terminal walks the complete chain when hit, assigns
scattered velocities, and moves every segment into a falling projectile state.
The former eye/small-eye terminology is not supported by the code and has been
replaced with neutral controller/segment/terminal names. Likewise,
`Enemy_GustheadGetAngleToPlayer` was demonstrably false: it reads no player
state and is an instruction-identical duplicate of the sine/cosine pair
lookup, with callers in Stage 18 and Destroyer Proto. A provisional run on the
currently unpinned emulator placed types `$390`, `$394`, and `$398` at frames
21,989 and 22,000 immediately before the documented Gusthead fight. Because
the sibling emulator moved away from pinned commit `a97abb6`, that ownership
remains `hypothesis` in the name audit until the same breakpoints are replayed
with the pinned toolchain. The coherent 352-line implementation now lives in
`src/bosses/gusthead_linked_chain.s`; the unrelated type-`$3B8` subtype
dispatcher was moved to the adjacent Destroyer Proto module. Forty new audit
records and two corrected earlier records cover the pass.

The Destroyer Proto pass reduced the count to 9,547 and replaced the former
964-line monolith with four ROM-contiguous modules following actual control and
data ownership: 281 lines of dispatch, introduction, and linked-part geometry;
413 lines of target selection and twin-shot, spread, and aimed-stream combat;
197 lines of defeat scatter and arena effects; and 224 lines of private
velocity, offset, mapping, and type-`$3B8` projectile handlers shared with
Stage 14. Static callers disproved seven generated Jetsripper ownership claims
in the shared projectile tail. Forty address-derived definitions were removed,
and 63 corrected or newly meaningful names are recorded in the name audit.
Runtime ownership remains unclaimed until these paths can be replayed with the
pinned emulator; the current evidence level is static or hypothesis as recorded
per symbol.

The Victor pass reduced the count to 9,498. The former
`jetsripper_stage_14.s` was a systematic ownership error: the type-`$3C0`
dispatcher builds Victor's twelve-part ring and implements the Stage 14 boss
sequence, while the independently runtime-confirmed Jetsripper uses type `$48`
and separate component handlers. The mixed 844-line file is now two coherent
modules of 411 and 387 inventory lines: Victor's initialization and ring attack,
then its launched parts, split shots, defeat, and component states. The
preceding 50-line type-`$3B8` hit-response tail was restored to the shared
Destroyer Proto/Victor projectile module. This ownership is supported by the
canonical movie scene map, object types and static state tables; individual
low-level behavior names retain static or hypothesis evidence as recorded.

The adjacent Wolf Garopa reward-emitter pass reduced the count to 9,495. Type
`$494` is installed by the post-battle transition and emits randomized pickups
from a fixed arena point; it is not an idle or attack-state implementation for
the boss itself. The coherent 68-line helper remains a documented compact
module as `src/bosses/wolf_garopa_reward_shower.s`.

The formation-wave/Stage 21 pass reduced the count to 9,439. The former
`tracker.s` mixed a compact type-`$3B4` oscillating formation family with the
unrelated asteroid-field subsystem. The generated `Tracker` ownership has no
static support: the family is created by `Stage2_FifthObjectSpawnList` and is
named only for its visible cloning and motion behavior. Type `$3AC` is
installed directly by `Stage_TransitionGraphics`, creates type-`$3B0` large,
small, and ambient rocks, and emits type-`$458` debris. The two families now
live in the ROM-contiguous `formation_wave.s` and `stage_21_asteroids.s`. The
accompanying data was also separated into its asteroid/Destroyer Proto
mappings and a compressed tile asset whose actual consumer is the Stage 3
phase 3 object set.

The rising-shot/Missiray pass reduced the count to 9,396. The former
`missiray_flyer.s` contained no coherent flyer enemy. Type `$3C8`, installed by
both the post-Destroyer Proto transition and Stage 24 initialization, manages
ten delayed rising-shot members and an optional Stage 11 fish-wave companion.
The adjacent controller at `0x0337E4` has neither a static caller nor an
absolute ROM pointer and remains explicitly orphaned. Type `$3C4` is shared by
Missiray falling shots and the rising-wave members, with two later states used
only by Stage 24. These three ROM-contiguous roles now live in
`rising_shot_waves.s`, `orphaned_rising_shot_pair.s`, and
`missiray_and_rising_shots.s`; their generated flyer, collision, damage, and
animation ownership claims were removed.

The adjacent Stage 24 visual pass reduced the count to 9,391. Four generated
names claimed background, foreground, palette, and tile work, but the type
`$3C4` state path actually creates a radial burst and a short vertical trail
when a rising shot crosses the camera's top edge. Those states are now part of
the same `missiray_and_rising_shots.s` module as the rest of the type `$3C4`
state machine; the former 98-line `stage_24_visuals.s` fragment was removed.

The former `boss_patterns.s` pass reduced the count to 9,365. Its first range
is the type-`$3CC` Missiray bullet continuation: fall, transformation, and an
impact burst made from type-`$160` particles. That range now completes
`missiray_and_rising_shots.s`. The second range is the type-`$190` controller
created directly by the Stage 3 camera; it manages boss health, a central
object, and eight sine-positioned parts. Static evidence supports the neutral
name `stage_3_orbiting_formation.s`, but no canonical character name is yet
claimed without stronger visual or runtime evidence.

The `boss_metasprites.s` audit reduced the count to 9,327. Its shared routines
now distinguish traversal setup, eight-frame and four-frame directional
rotation, Back Stringer's dual-position segment chain, and the animation
interpolation buffer. In particular, the former
`Boss_ValkiriePlayIntroSFX` name was contradicted by the implementation: the
routine makes no sound call and instead aligns Valkirie's five-part group
between two object anchors. The corrected name and its static basis are
recorded in `name_audit.json`.

The adjacent data audit renamed `boss_sprite_tables.s` to
`boss_metasprite_definitions.s` and reduced the address-derived count to
9,218. The 801-line module remains intact because it is one coherent registry
for the shared initializer: directional frame pointers, inline descriptors,
part radii, packed parent links/flags, and interpolation poses for twelve boss
definition groups. Static evidence also shows deliberate type-punning in the
original data. Valkirie reads one rotation table bytewise as a neutral pose, while
Z-Leo and Valkirie Force interpret the shared block at `$0355A4` differently;
the names preserve those dual roles instead of claiming a single false type.

The `jetsripper_core.s` control-flow audit reduced the count to 9,171. All 47
formerly address-derived branches now describe their observed state-machine,
angle-cycle, segment-rendering, dive, swing, or defeat role. The shared helper
formerly called `Boss_CheckScreenBounds` was also corrected: it returns no
boolean result and instead replaces out-of-range coordinates with fallback
X=`$FEB0`, so its name now states that clamping side effect.

The `jetsripper_segments.s` audit reduced the count to 9,142. Its 29 imported
branch and table labels now describe angle-buffer traversal, per-segment radius
assignment, chain positioning, directional mappings, palette selection, and
death-segment physics. The audit also corrected three generated behavioral
claims: the former segment-Y routine only distributes radius field `$54`, the
former generic math helper writes horizontal velocity directly to the current
object, and the sine helper returns its value in `d2` rather than writing a
vertical-velocity field. The shared four-direction renderer is now explicitly
named for both end pieces because live callers use it for the head and tail.

The adjacent Jetsripper-projectile/Shiper boundary audit reduced the count to
9,129. `projectiles/jetsripper.s` now ends with its palette update at `$036419`;
the following Shiper main handler, state table, encounter initializer, no-op,
and background configuration moved into `bosses/shiper_core.s` without moving
any ROM byte. This corrects a subsystem ownership error, not merely a file-size
split. Static control flow also disproved the generated player-distance and
player-proximity claims: the two routines respectively run Shiper's complete
state machine and begin its encounter/background transition.

The `shiper_core.s` state audit reduced the count to 9,100. Its 29 imported
labels now identify the asset and tile-DMA descriptors, auxiliary-part setup,
signed attack selection, motion-state exits, and defeat cleanup. The generated
`WaitDescend` name was removed because the routine never reads a position or
velocity; it waits on accumulated movement coordinate `$16C`. These names
remain static claims about visible data flow, not assertions about unobserved
animation intent.

The `shiper_movement.s` audit reduced the count to 9,059. Its 41 imported
labels now expose the movement and rotation dispatch tables, signed horizontal
acceleration, bounded rotation phases, vertical integration, sprite jitter,
two independently oscillating tentacle angles, rotation history, and the
five-part chain traversal. The coherent 526-line module remains intact; its
size reflects one connected movement/geometry subsystem rather than an
arbitrary ROM slice.

The adjacent Shiper projectile audit reduced the count to 9,030 and exposed a
previously hidden subsystem boundary. The old `projectiles/shiper.s` container
mixed Shiper line-scroll/effects, a Shellshogun debris spawner, and Shiper's
two projectile handlers. Those ranges are now separate ROM-ordered modules.
Object types `$98` and `$35C` link the two Shiper spawners to their dispatch
handlers, which is the static basis for replacing the broad imported names
`Enemy_BossProjectileMovement` and `Enemy_BounceRotateProjectile`.

The first Antroid audit reduced the count to 9,004. The former 834-line core
is now split at state-entry boundaries into core/standard attacks (434 lines),
jump/slam/projectile-wait (294), and charge/ram/defeat (104). Static control flow also
disproved two imported names: `Boss_AntroidEarthquakeAttack` is the timed state
that increments the boss-health value, while `Boss_AntroidSetIdleAnim` selects
attack-preparation state `$08` and falls through to its handler. The replacement
names state only those visible effects; the intended animation poses remain
unclaimed.

The Antroid jump/slam audit reduced the count to 8,985. Its state-table links
show the ordinary jump (`$10` through `$14`), the two-arc jump-slam (`$26`
through `$30`), and the projectile-wait pair (`$16`/`$18`). In particular,
the imported `Boss_AntroidInitIdleState` name was rejected: it selects state
`$16` and falls directly into the projectile-wait handler. Variant and arc
names describe the visible control flow without assigning unverified poses.

The Antroid ram/defeat audit reduced the count to 8,979. The entry at `$37D3A`
does not implement a separate charge behavior: it initializes state `$1E`,
velocity, facing, and flags before falling into the ram handler. Its former
`Boss_AntroidChargeAttack` name is therefore replaced by
`Boss_AntroidBeginRamAttack`; the subsequent rebound, fade, and removal paths
are named from their direct state changes.

The Antroid rendering/projectile audit reduced the count to 8,966 and exposed
two more generated-name errors. `Boss_AntroidInitPhysics` only propagates the
facing bit across linked metasprite parts, while `Boss_AntroidLoadAnimTable`
does not read a table: it enters state `d0`, resets motion/pose fields, and
binds two fixed part slots. The type `$158` projectile is now a separate
ROM-ordered module; its identity is established by both the spawner's type
write and the corresponding `Entity_UpdateHandlerTable` entry.

The Antroid animation audit reduced the count to 8,940. All command streams
are now named for their proven state consumers, including the unterminated
jump-slam retry prefix that intentionally continues into the first-arc stream.
The audit also rejected two misleading generated names: the former
`Boss_AntroidResetAnimation` begins a 15-channel pose interpolation, while
`Boss_AntroidSwapPaletteBuffers` exchanges pose-channel groups and never
touches palette memory.

The first Terobuster core audit reduced the count to 8,928. Its dispatcher
uses offsets relative to the same address that holds the four-step part
oscillation sequence; the semantic name records both the live data consumer
and that intentional offset base. Setup, the ordinary/recovery decision-state
entry, part ordering, tile-load descriptor, and fixed-slot binding are now
named from their direct operations. Later attack-state labels remain in the
review queue rather than inheriting assumptions from this setup pass.

The Terobuster attack-selection audit reduced the count to 8,901. States $06
and $08/$1C are two statically distinct homing-missile pose streams, so they
are named sequence A and B instead of assigning unobserved pose meanings.
State $1E is identified as the falling-rock sequence by its direct call to
`Boss_TerobusterSpawnFallingRock`; after its timer expires, the handler calls
`Boss_TerobusterSpawnMultiDirectional` before returning to the decision state.

The Terobuster intro and defeat-entry audit reduced the count to 8,887 and
rejected three generated control-flow claims. The former `Descend` state only
loads a timed sequence of compressed tile records; descent begins in the next
state. The former `BattleEnd` and `PostBattleCleanup` handlers are on the
setup-to-battle path: they open the shared UI gate, wait for it to close, and
then enter attack selection. Conversely, the former broad `BattleState` is
reached only when shared boss health becomes zero and initializes Terobuster's
defeat motion and ten-part conversion loop.

The Terobuster defeat and shared-update audit reduced the count to 8,874. The
three imported `AttackPattern` names were false: states $0A, $0C, and $0E are
the post-health-zero bounce, randomized debris, and fade/explosion sequence.
The former `InitMetasprite` is likewise a per-frame linked-body update that
also publishes an oscillation and attempts a periodic projectile spawn. Its
replacement name records those operations rather than claiming one-time
initialization.

The Terobuster projectile and defeat-part audit reduced the count to 8,845.
Object type `$138` links the boss's missile spawner to its homing handler and
its direction-frame, trail, velocity-clamping, and player-steering paths.
Handler-table offset `$B8` also disproved the broad imported
`Boss_TerobusterMovementPhysics` name: defeat entry converts marked linked
parts to `$B8`, whose repeated-bounce and optional rotation-frame handler now
lives in the ROM-ordered `effects/terobuster_defeat_parts.s` module rather
than the projectile container.

The Terobuster pose and intro-tile audit reduced the count further to 8,809.
State consumers prove the roles of the bounded pose-command streams, and the
shared generated helper expands packed bytes into six fixed-point pose
channels; the former `Boss_TerobusterLoadFrameDelays` name was therefore
rejected. The 19 intro tile-load records are named only by their proven table
indices rather than guessed visual content. The complete Terobuster code/data
range now has no live address-derived definitions.

The first Shellshogun audit reduced the count to 8,798. It covers the main
dispatcher and the complete initialization-to-combat path. The imported
`MoveLeft` and `MoveRight` names were rejected: these states implement the
pre-battle delay and readiness gate rather than directional motion.
Names for the two three-record initialization loops deliberately stop at
`AuxiliaryParts` and `SecondaryObjects` until their downstream handlers prove
narrower identities.

The contiguous Shellshogun defeat audit reduced the count further to 8,790.
The zero-health branch proves that the former `IdleState` and `ChargeAttack`
names were false: states `$12`, `$14`, `$16`, and `$18` implement launch,
palette, dissolve, and completion-delay phases. The similarly broad imported
`InitPositionTracking`, `UpdatePositionDelta`, and `TrackPlayerPosition`
names were replaced from the same state-machine evidence.

The Shellshogun decision-state audit reduced the count to 8,782. The former
`AttackPattern` routine is a state selector, and the former
`Attack_ShellProjectile` state only advances shared stage progress while
running a bounded pose stream; neither routine allocates a projectile. The
state selected with pose cursor four remains conservatively named
`PoseGateState` until its following control flow is fully audited.

The completed pose-gate and slam audit reduced the count to 8,774. The
imported `SpawnShells` name was false: state `$0C` contains no allocation or
projectile initialization and instead gates a return-or-slam decision on pose
events, position, facing, stage progress, and player distance. The following
states `$0E` and `$10` do form one coherent slam preparation/follow-through
sequence, so their narrower names are retained with static state-machine
evidence.

The Shellshogun directional-attack audit reduced the count to 8,767. The
former `VerticalMovement` name was rejected: state `$1C` updates horizontal
velocity field `$18` according to facing, while its `$1A` predecessor is the
pose windup. Event-counter, stage-progress, effect, velocity, rendering, and
sprite-flip names are limited to operations visible in the state chain.

The remaining Shellshogun core-state audit reduced the count to 8,753 and
left `bosses/shellshogun_core.s` with no live address-derived definitions.
The first jump pair is named only from its two bounded pose streams. The
former `DescendUpdate`/`LandingSequence` pair was corrected to leap windup and
flight: it explicitly installs upward vertical velocity, applies gravity, and
ends at the linked-part landing threshold before a signed-velocity recovery.
The final wrapper's fallthrough from core into rendering is also recorded as
intentional module-boundary control flow.

The first Shellshogun rendering audit reduced the count to 8,746. Three
especially misleading imported names were rejected: `CheckDefeat` only derives
facing from signed horizontal player delta, `DeathSequence` only changes five
linked-part flags for zero-facing orientation, and `InitPalette` only sets bit
seven on eight linked records. The renderer's former generic position helper
is now documented as a bounded three-part sine/cosine orbit update with an
explicit source/radius table.

The rotating-part rendering audit reduced the count to 8,740. The former
`PhysicsUpdate` helper only selects a linked-part pointer and derives a wrapped
rotation value; no velocity integration or collision query is present. The
former `SetTileData` routine is now bounded to the behavior visible in its
body: angle-based frame and flip selection, anchor copying, and optional
sine/cosine positioning of two trailing parts.

The interleaved Madam Barbar palette-cycle audit reduced the count to 8,738.
Its two control-flow labels now describe the signed fade-step direction and
the common four-color application path. The 56-byte routine remains a small
standalone module because its ROM ownership changes from Shellshogun to Madam
Barbar and back again immediately afterward.

The Shellshogun pose-system audit reduced the count to 8,721 and left the
three Shellshogun modules with no live address-derived definitions. The former
`FlashOnHit` name was rejected: the defeat-launch caller uses it to create a
type-`$A4` object with inverted boss velocity and a randomized nearby position.
The interpreter, its stop/loop/interpolation paths, ten state-specific command
streams, and shared pose-target data now carry names tied to their static
consumers. The decision stream's additional entity-dispatch-table reference
is retained as an explicit unresolved cross-reference rather than explained
away.

The first Madam Barbar audit reduced the count to 8,714. The main routine is
now documented as a 13-state relative-offset dispatcher with a separate
external-transition path. Initialization, 29-part metasprite setup, compressed
tile commands, two intro states, their shared pose update, and the main-attack
entry are named only from visible state transitions and direct consumers. No
meaning is inferred from the two still-unaudited transition helper names called
at intro completion.

The Madam Barbar barrage and idle-state audit reduced the count to 8,705. The
former `DefeatSequence` label was rejected: state `$0C` follows the timed bullet
barrage without a health check, updates all 29 linked parts, clears their flag
bit seven, and finally clears an object range. States `$08`, `$0A`, `$0C`,
`$0E`, and `$18` are now described as player-sequence wait, bullet barrage,
post-barrage cleanup, AI entry, and idle-progress flow respectively.

The Madam Barbar attack-selector audit reduced the count to 8,688. The former
right/left attack names were reversed relative to their proven selector:
signed delta `playerX - bossX` below zero chooses the player-left pose, while a
nonnegative delta chooses the player-right pose. Because those states primarily
advance pose streams and swap linked anchors, they remain conservatively named
pose states rather than attacks. Center-spin and drop-projectile behavior is
retained where direct progress, sound, angle, and spawn operations support it.

The Madam Barbar linked-part audit reduced the count to 8,676. Six layout loops
are named by their exact signed X/Y operations instead of inferred anatomy. The
former `SetCollision` helper only applies bit three to eight linked parts, and
the former `CheckBounds` helper publishes shared screen coordinates before the
common clamp. The former `SpawnBullet` is now a barrage particle because it
initializes generic type `$A4` with randomized position and velocity rather than
a boss-specific projectile type.

The Madam Barbar pose-system audit reduced the count to 8,661 and left
`bosses/madam_barbar_core.s` with no live address-derived definitions. The
interpreter's optional SFX prefix, stop/loop controls, 12-channel interpolation,
angle publication, six state-specific streams, and pose-target base are all
named from direct consumers. The former `LoadFrameDelays` wrapper is now an
initial-pose channel loader; the generic callee converts source bytes to
fixed-point channel values and does not read timing data.

The first Madam Barbar debris-projectile audit reduced the count to 8,639.
It names the type-`$160` conversion, horizontal timers and reversals, numbered
motion states, offset probes, and shared-effect publication from operations
visible in the routine. The imported `CheckCollision` name was narrowed to a
vertical-offset probe because the helper only supplies offsets zero and `$0C`
to `Physics_AddEntityOffset`; no boss-center or collision-direction claim is
made. The state names remain numeric until runtime or stronger cross-reference
evidence establishes their gameplay meaning.

The remaining Madam Barbar projectile audit reduced the count to 8,629 and
left `projectiles/madam_barbar.s` with no live address-derived definitions.
It also rejected an interim semantic mistake: `SpawnProjectile` actually
creates type `$38`, whose dispatch entry is only `Anim_UpdateSpriteFrame`, so
the routine and its table are now an animation effect. Consequently boss state
eight is a player-sequence wait, keyed by player behavior state `$FF80C2`, not
a projectile wait. The separate type-`$11C` drop object retains projectile
terminology because its dedicated handler applies falling motion, probes
terrain contacts, optionally creates a pickup, and converts to an explosion.

The first Joker audit reduced the count to 8,621. Its main entry is now
explicitly split into palette/screen-X publication and a 20-state relative
offset dispatcher. Setup retains only operations visible in the ROM: four
tilemap steps, a 19-record metasprite, four auxiliary type-`$10` slots, an
object-init table, an 18-byte compressed-tile command stream, and flag-bit
updates across 18 linked records. No anatomy or attack purpose is inferred for
the auxiliary slots or linked records.

The Joker phase-gate audit reduced the count to 8,614 and rejected the entire
interim `DefeatInit`/`DefeatWait`/`DefeatAnim` interpretation. That sequence
contains no health check, requests player/UI sequence five, waits on player
behavior state `$FF80C2`, and then returns to `Boss_JokerSelectNextState`. It is
now documented as states `$18`, `$1A`, and `$1C` of a battle phase gate, with
its own looping pose stream, bounded body-height adjustment, facing toggle,
and render path. Joker's actual health-zero branch remains the separate
falling transition beginning at `Boss_JokerBeginDefeatFall`.

The Joker health-zero transition audit reduced the count to 8,604. The actual
defeat path is now explicit from the `$FF8200 == 0` branch through the falling
delay, palette update, fade-out, player-spawn replacement, inverse fade-in, and
final cleanup. The former `FadeComplete` state was corrected to fade-in because
it decreases the same counter that the preceding state increases. The former
`SpawnDebris` helper was broadened to a defeat effect: only one selector value
uses the debris initializer, while the other seven create type `$160` with one
of two mapping/velocity combinations.

The Joker state-selection and dive audit reduced the count to 8,594. The
former attack selector does not inspect health; it combines shared progress,
absolute player-X distance, and frame-derived bits to choose interrupt-wait,
dive preparation, or jump preparation. The imported `Taunt` description is
now a neutral interrupt-wait pose because no static consumer establishes its
presentation. Likewise `ApplySpinGravity` and `SpinDive` were rejected: the
code updates a fixed-point body-height accumulator and vertical velocity, then
continues into a descent state without an explicit rotation operation. Four
pose streams are named only from their direct state consumers.

The Joker jump, body-height, and stretch audit reduced the count to 8,582 and
left `bosses/joker_core.s` with no live address-derived definitions. The
former `Landing*` chain is an upward jump followed by body-height compression
and recovery: preparation installs negative Y velocity, ascent adds positive
acceleration, and the next two states manipulate fixed-point body height rather
than applying a falling velocity. The former `GroundBounceAttack` is therefore
kept as a neutral bounce-motion state. Its shared acceleration helper performs
no terrain query, and all four adjacent pose streams are named from their exact
state consumers.

The first Joker rendering audit reduced the count to 8,566. It corrected the
imported `CalculateYPosition` description: the helper derives Y exclusively
from fixed-point body-height field `$1DC`, with no horizontal input. The main
renderer now exposes only operations visible in the routine: linked-part
positioning, fixed versus screen-relative horizontal offsets, a descending
96-word ramp, paired body-height raster values, two tile-word tables, and a
bounded secondary tile-frame index. The exact visual role of the raster
buffers and tile groups remains unclaimed pending runtime evidence.

The Joker pose-interpreter audit reduced the count to 8,559 and corrected two
more imported descriptions. `UpdateAnimation` is now `UpdatePose`: callers
supply a command stream, `$FFFE` stops it, `$FFFF` loops it, optional `$80`
prefixes emit sound effects, and ordinary commands select ten-channel pose
targets for interpolation and linked-part angle publication. Likewise the
former `LoadFrameDelays` wrapper initializes fixed-point pose channels from
source bytes; it does not load animation timing data.

The final Joker shot-emitter audit reduced the count to 8,551 and left
`bosses/joker_rendering.s` with no live address-derived definitions. The
imported `Bomb` terminology was not supported by a named graphic or another
consumer, so type `$198` is now a descending shot emitter. Its handler follows
the player object's X coordinate while descending to Y `$148`, emits timed
directional projectiles, jitters one display field near each emission, and
ends with the shared four-way burst. These operations establish the emitter
name without asserting an unsupported visual identity.

The first Flying Neo core audit reduced the count to 8,538. It rejected the
imported `ClearPalettes` claim because the helper only clears bit 15 across
four explicit palette-buffer ranges. It also corrected the alleged active
battle state: state `$08` waits on player-sequence word `$FF80C2`, after which
state `$0A` runs a `$30`-frame attack-start delay. Main-loop labels retain
neutral health-threshold, shared-phase, palette-fade, defeat-check, and
screen-X terminology where the exact presentation meaning is not yet proven.

The Flying Neo defeat and player-control audit reduced the count to 8,523.
The first two defeat states now describe their actual forward and reverse walk
through linked-object slots, converting each selected record to an
upward-moving type-`$38` particle. Later states launch a fixed type-`$88`
record, emit randomized type-`$88` rain, load the final tile command, publish
player-sequence value `$5C`, and maintain scrolling. The alleged collision
center helper was narrowed to the defeat-effect origin fields used by these
states; the player-controlled state is retained because it directly consumes
the four directional bits of input word `$FFF706`.

The Snake pass reduced the count to 8,029 and left `bosses/snake.s` with no
live address-derived definitions. Static flow disproved the imported
`RandomizeSegments` claim: the routine changes the sine/cosine amplitudes used
by head steering and never writes a segment record. The former generic
`Phase1` and `Phase2` states are a timed departure arc and downward exit, while
the independent health-zero path starts the explosion and destroys all 23
children in slot order. A provisional replay placed type `$298` and its
type-`$29C` chain in the documented Stage 13 Snake encounter at frames
27,720-28,480. Because that replay used the currently unpinned emulator, the
visual identity remains `hypothesis`; the state, movement, shot, and destruction
names rely on static instruction-level evidence recorded in the name audit.

The Sunset Sting controller, segment, early-form, attack, transition, defeat,
and wave passes, followed by the Viblack core/support/chain pass, reduced the
count to 7,684 and left
`bosses/sunset_sting_core.s`,
`bosses/sunset_sting_attacks.s`,
`bosses/sunset_sting_transition_and_defeat.s`,
`bosses/sunset_sting_main.s`, and `bosses/sunset_sting_segments.s` with no live
address-derived definitions. The controller audit
corrected two labels falsely attributed to Viblack: states `$06` and `$08`
belong to the Sunset Sting controller table and reposition its controller and
visible core before returning to battle state `$04`; neither is a defeat
state. The former `VictoryCheck` entry starts the shared battle-entry banner,
and the two segment-attack states are distinguished by positive and negative
ring rotation. A provisional replay observed type `$1EC` progressing through
the documented Sunset Sting encounter, including defeat states `$14`, `$16`,
and `$18`. Because that replay used the unpinned emulator, the visual boss
identity and exact presentation of the state-`$10` arena transition remain
hypotheses; instruction-level behavior is recorded as static evidence. The
segment pass also separated primary type `$1F0`, secondary type `$1F4`, and
defeat-core type `$20C` state machines. It rejected the former Viblack names
for the attached-segment state and type-`$1F8` shot, because the only creator
is the Sunset Sting secondary-segment controller.

The early-form audit reconstructed the complete 22-entry state table at
`0x040D02`, its weighted attack selectors, body-part hierarchy, pose-angle
sequences, and health-zero transition into scattered body-part debris. It also
rejected the former `CheckVictory` and `InitializeAttackPhase` descriptions:
the first queues intro message selector five, while the second is reached from
the shared-health-zero gate and begins the form's defeat transition. The six
unreferenced bytes after the state table remain explicitly `unknown`; no use
was invented for them. Exact visual ownership remains a runtime hypothesis
until the pinned emulator can repeat the encounter capture.

The attack pass reconstructed the later form's nineteen-entry state table,
four chain roots, tracking and pose-pattern data, random-chain homing shots,
and health-threshold loop. The former `CheckVictoryAlt` is another intro-message
state. The former `RiseAndSpawnRing` neither rises nor creates a ring: it adds
two to shared health each frame until `$01E0` and applies pose pattern C to all
four chains, so it is now the health-refill state. The exact appearance of pose
patterns A/B/C remains deliberately neutral pending pinned runtime evidence.

The transition-and-defeat pass showed that the former `StartDeathSequence` is
not itself a death state: it enters state `$1A`, where four chain roots
oscillate while the controller moves between vertical bounds. States `$1E`
through `$24` descend while firing, activate an eight-object trail, contract
its vertical span, and return to health-state selection. The later primary-
health-zero path resets the form controller; the distinct subsequent routines
scatter its body parts, stagger their conversion to explosions, and finally
remove the controller. Shared angle and weighted-choice helpers in the same ROM
range now have subsystem-neutral names. The arctangent lookup starts in the
instruction bytes at `0x042838` and continues through the extracted 32-byte
table tail; that code/data overlap is preserved explicitly rather than called
unused data.

The wave pass reconstructed both row-buffer builders and corrected another
misleading Sonnet name: the former `UpdateCore` neither writes a core object nor
tests contact with one. It measures an object's screen-relative X/Y distance
against the central flight bounds. Primary, secondary, and defeat-fall segment
states remain active while that result is nonzero and advance or retire after
leaving the bounded area, so their former `CheckCore` names and documentation
were corrected as part of the same evidence chain.

The Viblack pass removed another false ownership boundary. States
`$1A`, `$1C`, and `$1E` are entries in Viblack's own state table, not Back
Stringer routines. The former `UpdateAngle`, `CopyPalette`, and `SpawnRing`
names were also contradicted by their operands: those routines build and clip
the `$FF9480` vertical-scroll profile and position an already allocated
companion object. Viblack transition/scroll/particle support now lives in a
430-line boss module, while the type-`$2EC` controller and ten type-`$2F0`
children form a separate 252-line chain-projectile module.

The same pass reconstructed the full sixteen-entry Viblack controller. The
former `DefeatCheck` is the normal target-selection state for chain and radial
attacks; defeat is forced separately by the main handler when shared boss
health reaches zero. The old `DefeatMoveUp` and `DefeatMoveDown` labels were
also reversed relative to their velocity changes and Y thresholds. Finally,
the former broad `RopePhysics` claim was narrowed to the behavior visible in
the instructions: an oscillating transition displacement and ten paired
transition offsets written through `$FFEC24` and `$FFEC28`; their exact
renderer role remains unproven.

The Back Stringer pass reduced the count to 7,550 and reconstructed its full
23-entry controller, entrance, repeated attack selection, transformation,
dive, tracking attack, and defeat sequence. It also corrected a false Epsilon
1 ownership boundary. Back Stringer's falling-drop spawner creates type
`$318`, its transformation creates two type-`$328` angled shots, and those
shots create type `$360` when they rebound. The object dispatch table leads
all three types back into the same contiguous ROM range, so the former
`Boss_Epsilon1BounceProjectile`, `Boss_Epsilon1DebrisPhysics`, and
`Boss_Epsilon1ProjectileRotation` names were rejected. The audited subsystem
is now divided by behavior and ROM order into a 752-line controller, a
510-line rendering/pose/tail support module, and a 261-line projectile module.

The controller's alternate input branch is named only for the behavior visible
in the instructions: it reads directional and button bits, moves the boss,
updates its angle, and can spawn its angled shots. No ordinary state-table edge
has yet been found that enables the branch, so a debug or development purpose
is not asserted. Exact visual ownership remains a runtime hypothesis until the
pinned emulator can repeat the encounter capture; the state and object-family
claims are static evidence recorded in the name audit.

The first Epsilon 1 support pass reduced the count to 7,494 and rejected the
old `epsilon_1_final_phase.s` boundary. That 417-line range is shared support,
not a final-phase state machine: it steers the fixed-point battle center,
builds the twenty-word buffer consumed by `Gfx_WriteScrollValues`, loads or
clears four tile bands from screen-space visibility, queues animated tile DMA,
and ends with a separate four-state intro-object controller. It now lives in
`bosses/epsilon_1_shared_support.s` with no live address-derived definitions.

Three especially broad Sonnet labels were contradicted directly. The former
`SpawnProjectileRing` allocates no object and only integrates center motion;
the former `BerserkCheck` cycles a Genesis palette color without checking
health; and the former `UpdateRotationMatrix` writes a scroll profile rather
than a matrix. The paired nonzero and zero-source compressed-tile descriptors
in `epsilon_1_core.s` were also renamed as load/clear commands for four visible
tile bands. These are static data-flow conclusions; exact visual presentation
still awaits the pinned emulator.

The Epsilon 1 core pass reduced the count further to 7,468. Its 561-line module
now has 55 definitions and no live address-derived names. The audit covers the
main presentation path, angle-history maintenance, linked-part positioning,
the 64-entry ROM-ordered controller table, the first four controller states,
and both initial compressed-tile load groups. In particular, the former broad
`BattleSetup` is now limited to the state that clears encounter buffers and
initializes the controller, linked parts, and twelve ring objects; the former
`IntroTransition` is an initial fade-and-tile-load state. Later attack and
defeat handlers referenced by the table remain separate review queues, so this
pass does not treat their inherited semantic names as confirmed.

The attack-controller pass reduced the count to 7,422. Its 588-line module has
86 definitions and no live address-derived names. The ROM table proves that
the former `Type1Main` through `Type5Main`, `Homing`, `Spiral`, `Wave`,
`Bounce`, and `Laser` routines are consecutive Epsilon 1 controller states,
not projectile handlers. Their actual data flow forms three attack branches:
a paired spread launch, a ring-only cycle, and a vertical sweep that reserves
two spread slots, attaches twelve projectile slots to the twelve ring objects,
releases them, and returns the shared battle center to its selection height.
The shared helper at `0x046674` returns zero only when the current angle equals
all six delayed samples. These claims are backed by the controller table,
object-slot addresses, allocations, and fixed-point position writes; names do
not assert unobserved projectile visuals.

The Epsilon 1 transition-and-defeat pass reduced the count to 7,376. Its
548-line module has 86 definitions and no live address-derived names. The
controller table and shared-center writes disprove seven inherited defeat
claims at states `$4E-$5A`: these states align the angle history, leave the
central horizontal interval, descend to Y `$100`, wait, return above Y `$40`,
and resume attack selection. In particular, the former `WaitForLowHealth`
state reads no health value. The true defeat sequence starts at state `$5C`,
hides the controller and linked parts, destroys the parts and twelve fixed ring
objects, drives two timed palette-fade intervals, publishes the post-battle
sequence value, and finally removes the controller.

The same pass reconstructed the five-state body-pose machine and eight-state
linked-part machine. The former rotation states actually change the horizontal
body offset through `+8`, `-8`, and zero; the main handler adds that word to
controller X. The linked parts wait for a random/render-bit trigger, extend and
retract their radial offset, then use distinct inactive, delayed-destruction,
explosion-animation, debris-spawn, and debris-delay states. A legacy
code-address subtraction that happened to encode RAM `$FFFF08` was replaced by
the direct RAM symbol and verified byte-identical. All 86 names and the
rejected health, shield, fade, cutscene, and rotation claims are recorded as
static evidence in the name audit; exact visual presentation still awaits the
pinned emulator.

The Epsilon 1 ring-controller pass reduced the count to 7,347 and narrowed an
overly specific subsystem boundary. The former 326-line
`bosses/epsilon_1_intro.s` is now the 331-line
`bosses/epsilon_1_ring_controller.s`; its 43 definitions have no live
address-derived names. The dispatch-table entry at offset `$278` leads to this
fixed controller. Battle setup initializes it, while the separate intro and
attack controllers activate it and select its mode through field `$5E` at
`FFC7FE`. Thus `Intro` described only one caller, while the inherited
`Miniboss` names had no corresponding object creation and were rejected.

The zero mode copies the first entity-pool object's coordinates, steers the
ring toward the player, reserves an inert aim-marker slot in `FF9420`, and
repeats or deactivates after its finish delay; the boss spread launcher later
consumes that saved marker position. The nonzero mode, used by the intro cycle
and ring-only attack, initializes and randomizes an eight-byte order array,
reserves an inert slot, positions the ring using a signed horizontal-offset
table, and later activates the saved slot as entity type `$2E8`. The exact
screen appearance, the semantic meaning of the global option word at
`FFFF0E`, and the external conditions that advance the two no-op hold states
remain deliberately unclaimed. All 43 names are recorded as static evidence
in `config/name_audit.json`.

The Epsilon 1 projectile-and-ring-object pass reduced the count to 7,303. The
611-line `projectiles/epsilon_1_projectiles.s` module has 77 definitions and no
live address-derived names. Its four consecutive dispatch-table entries and
their creators establish distinct entity roles: type `$27C` is the five- or
eleven-part spread projectile; type `$2E8` is the barrage emitter activated by
the ring controller; type `$280` is one of the emitter's eight vertically
spaced barrage-row projectiles; and type `$284` is one of the twelve fixed ring
objects created during battle setup. Keeping this range together documents the
actual producer/consumer chain while remaining inside the project's
300-to-1,000-line module target.

This pass rejects several inherited Sonnet claims. The former
`Projectile_Epsilon1DefeatDebris` is the live spread handler, and the former
`Projectile_Epsilon1IntroMain` is a barrage emitter shared by intro and attack
callers. Likewise, the old `Chain`, `Tracking`, `Burst`, and four
`DefeatSpark` labels all belong to the fixed type-`$284` ring-object state
machine. Static field and allocation evidence proves delay, emission,
positioning, release, linked-projectile, defeat, and despawn behavior. The
narrow meanings of entity words eight and `$A`, exact visual presentation,
and runtime timing remain deliberately unclaimed. All 77 definitions are
recorded as static evidence in `config/name_audit.json`.

The first Sharpssteel pass reduced the count to 7,280 and corrected the
projectile boundary at the start of the former Jampan module. The 276-line
`projectiles/sharpssteel.s` module now contains the complete producer and
handler chains for three Sharpssteel object types and has 31 audited
definitions with no live address-derived names. Type `$364` is emitted in two
groups totalling ten falling shots; type `$3BC` comprises the fourteen
embedded fragments initialized when Sharpssteel's health reaches zero; and
type `$414` comprises six short-lived shots emitted from its final blade part.

Static creation and dispatch edges disprove three inherited ownership claims.
The former `Enemy_FallingBombLogic` handles only Sharpssteel's type `$364`, the
former `Effect_ShipDestructionDebris` handles only its type `$3BC` defeat
fragments, and the former `Boss_JampanFlashToggle` handles type `$414`, which
is created only by Sharpssteel. That last handler at `0x049100-0x04912D` was
moved out of `bosses/jampan_core.s`, so the Jampan module now begins at its
actual main handler at `0x04912E`. The exact visual form of these shots and the
identity of the object region used for the type-`$364` one-time deflection
test remain deliberately unclaimed. All 31 definitions are recorded as
static evidence in `config/name_audit.json`.

The Sharpssteel main-controller pass reduced the count to 7,228. Its 750-line
`bosses/sharpssteel_core.s` module has 90 definitions and no live
address-derived names. The audit reconstructs the complete thirty-entry state
table through the start of state `$2C`: encounter and blade entrance,
assembly-trigger waits, alternating horizontal motion, randomized angle-shot
emission, falling-shot cycles, distance-based blade attacks, a vertical dive,
and the transition into the following complex phase. All five inherited
`Boss_Jampan_State*` labels in this range were rejected because these entries
are selected directly by the Sharpssteel table at states `$10`, `$14`, `$18`,
`$1A`, and `$2A` and operate exclusively on its embedded blade fields.

Several other Sonnet names were narrowed or disproved by direct data flow.
The former `UpdateCore` shifts a six-word target history rather than moving the
core; `DefeatStart` only loads the last history sample; and `BladeDefeat` is a
live close-range attack with its own hitbox and sound trigger. The former
`RisingAttack` increases screen Y until `$200`, so it is now the dive state.
The visually specific meaning of several blade pose tables, the purpose of the
otherwise unreferenced manual-control initializer, and the no-op hook below
the falling-cycle `$60` threshold remain deliberately unclaimed. All 90
definitions are recorded as static evidence in `config/name_audit.json`.

The Sharpssteel blade-system pass reduced the count to 7,167. Its 700-line
`bosses/sharpssteel_blades.s` module has 93 audited definitions and no live
address-derived names. Together with the preceding controller, it completes
states `$2C-$34`: alignment and acceleration lead into bounded vertical
oscillation, three animation-triggered six-shot bursts, horizontal steering
toward the shared target, and a final fall back to the post-dive selector.
These are mechanically established state roles; the exact visual meaning of
their pose command streams remains deliberately unclaimed.

This pass also removes several materially false Sonnet descriptions. The
former `VerticalMovementClamp` changes horizontal velocity toward
`word_FF8248`; the routines described as enabling and disabling broad hitbox
groups at field `$E` actually change the sprite-priority bit of embedded blade
parts. Collision control instead uses bit six of field `$21` and values in
field `$26`. The former palette-index writers update those collision values,
the former palette-fade/core-idle pair writes collision-box group sizes, and
the former core-defeat routine merely initializes pose interpolation. Blade
graphics selection, core sprite-frame updates, palette animation, background
fade, and the pose-command interpreter are now separated by their observed
data flow. All 93 definitions and the rejected vertical, hitbox, palette, and
defeat claims are recorded as static evidence in `config/name_audit.json`.

The first Jampan pass reduced the count to 7,114. The 675-line
`bosses/jampan_core.s` module has 76 audited definitions and no live
address-derived names. It now describes the controller's shared update and
53-entry state dispatch, complete encounter-object initialization, opening
bounce sequence, live attack selection, recovery movement, and the first
three states of its offset attack. The sixteen orbiting parts are initialized
from explicit parallel type, sprite-attribute, radius, angle, and sprite-frame
tables, followed by six reserved shield slots.

This pass rejects two broad groups of generated claims. The former
`Projectile_JampanBullet`, `Projectile_JampanWave`,
`Projectile_JampanHoming`, and `Enemy_JampanMinion` are states `$0E-$14` of
the main boss controller, not independently dispatched entities. Likewise,
the former `DefeatInit`, `DefeatTeleport`, and `DefeatFade` are states
`$22-$26` selected by the live random attack selector: they clear linked-part
state, choose a signed direction from the player's side, and create entity
type `$238`. The former `DescendToHeight` also had its direction reversed;
it decreases screen Y until `$F0` and is now named as a rise. Exact visual
identities of the orbiting parts and the type-`$238` attack object remain
deliberately unclaimed. All 76 definitions and the rejected projectile,
minion, defeat, and direction claims are recorded as static evidence in
`config/name_audit.json`.

The Jampan attack-and-defeat pass reduced the count to 7,066. The 598-line
`bosses/jampan_attacks.s` module has 83 audited definitions and no live
address-derived names; seven shared tracking, geometry, and coordinate
helpers in the adjacent support/defeat modules were audited with it. States
`$28-$4E` now document the end of the offset attack and two live shield
patterns: radius expansion and collapse, forward/backward angular motion,
player tracking, vertical centering, recovery, and return to attack
selection. The three one-instruction slots at `$2A`, `$2C`, and `$50` are
named only as no-op states, without inventing dormant behavior.

The same pass establishes state `$52` as the real defeat boundary. Its
sequence settles the orbit offsets, disables collision, falls with explosion
debris, creates and waits for the type-`$23C` shield object, fades the palette
out and back in, rebuilds the linked objects, and enters timed post-defeat
movement. A separate two-state entity type `$240` maintains the post-defeat
orbiting geometry and is preserved into the following encounter setup. The
former `DamageHandler`, `DefeatDebris`, and `FlashOnDamage` helpers were
disproved: they respectively update sixteen orbiting parts, update the six
shield objects, and project one part from three angles and a radius. The
former `CheckHealth` only publishes controller-derived stage coordinates.
Exact visual identities and the narrative role of the post-defeat movement
remain deliberately unclaimed. All 90 audited definitions are recorded as
static evidence in `config/name_audit.json`.

The Jampan support-object pass reduced the count below seven thousand, from
7,066 to 6,999. The 574-line `bosses/jampan_support.s` module now has 96
definitions and no live address-derived names. Together with the fourth
orbit-group state at the start of the adjacent module, this pass adds 96 new
static audit records. It also corrects the previous pass's object identity:
entity type `$23C` is the shield handler, while type `$238` is the temporary
object created by the offset attack.

The support graph is now documented by dispatch identity and observable field
use. Type `$224` projects itself radially around an anchor and extends or
retracts according to field `$52`; type `$228` copies an anchor position and
plays a six-entry mapping sequence under the same signal field; type `$22C`
initializes and rotates the fixed-point angles of 13 linked records. Type
`$23C` falls, performs damped bounces, emits four type-`$88` projectiles, and
then converts itself into another type-`$88` projectile. The former
`Shadow`, `Teleport`, `UpdateSprite`, `UpdatePalette`, `ComboAttack`,
`SpecialAttack`, and `DefeatExplosion` names are therefore rejected. The
visual identities of types `$224`, `$228`, and `$238`, and the display meaning
of the type-`$238` oscillated parameter, remain deliberately unclaimed.

The Jampan geometry-and-input pass reduced the count from 6,999 to 6,983.
The former 230-line `bosses/jampan_defeat.s` tail was renamed to
`bosses/jampan_geometry_and_input.s`: the actual defeat states are already in
`bosses/jampan_attacks.s`, while this ROM range contains the reverse
orbit-group state, held-input parameter adjustment, coordinate publication,
and the projection of 16 linked parts. All 24 definitions now have exact
static audit coverage and the module has no live address-derived names; 17
records were added here and seven shared definitions were audited by the
preceding Jampan passes.

The old `DebugController` description is narrowed deliberately. The routine
does read directional-plus-button combinations and changes three shared orbit
angles or the radius offset by two, and it is called by the post-defeat
movement states. Static code alone does not prove its original debug purpose,
nor the earlier claim that it has no visible effect, so both claims have been
removed pending pinned runtime evidence.

The Destroyer MK2 core pass reduced the count from 6,983 to 6,933. The
703-line `bosses/destroyer_mk2_core.s` module now has 83 audited definitions
and no live address-derived names; five directly used helpers in the adjacent
modules were audited with it, for 88 new static records in total. Main state
flow is now described as the code implements it: initialization constructs
four inactive linked display records and eight active orbiting records, then
drives stage-14 scroll deformation and the linked-part ring before entering
the final-transition states.

This pass rejects the generated attack and animation vocabulary in the core.
The former `SpawnMissile` and `ProjectileMissile` only enable collision fields;
the former `ProjectileLaser` clears them; `Land` initializes a 256-entry
descending index table; and `CollisionCheck` swaps two randomly selected table
entries. `ShootPattern1` writes four shuffled scroll rows, `HitReaction` seeds
four signed row velocities, and `StunState` integrates the 255-row offset and
velocity buffers. The other two `ShootPattern` helpers respectively cycle two
palette words and update linked-object geometry, while `IntroRoar`,
`PlayIntroSFX`, and `PlayFootstep` are scroll or frame-selection helpers and
call no sound routine. The exact visual identity of the eight orbiting records
remains deliberately unclaimed until pinned runtime evidence is available.

The Destroyer MK2 pattern-and-component pass reduced the count from 6,933 to
6,881. The misleading 600-line `bosses/destroyer_mk2_defeat.s` filename was
replaced by `bosses/destroyer_mk2_patterns_and_components.s`; keeping this as
one cohesive module is intentional because its size is already inside the
300-1,000-line target and its three consecutive roles share the same
controller, linked records, and transition state flow. All 92 definitions in
the module now have exact static audit coverage, including the scroll helper
audited in the preceding core pass; this pass adds 91 records and brings the
name-audit total to 4,281.

The old defeat and berserk vocabulary is rejected by direct control flow.
The first half contains nested patterns selected by main state `$24`: it
activates linked records according to player side, projects short angular
sweeps, emits three delayed type-`$258` projectiles, or emits a ten-projectile
spread. Main states `$26-$28` repeat those patterns. The actual final
transition begins at state `$2A`: it waits for five linked records, disables
collision, runs debris, performs two palette/tile changes, clears transition
flags and most of the object pool, then removes the controller. The tail is
the ten-state handler for entity type `$248`, covering linked-state activation,
four stage-14 scroll presets, component-projectile creation, and indexed
scroll-layer motion. The precise rendered identity of the projected effects
and type-`$248` components remains deliberately unclaimed pending pinned
runtime evidence. Provenance now contains 8,942 unique mappings.

The adjacent Destroyer MK2 linked-parts-and-debris pass reduced the count from
6,881 to 6,814 and raised provenance to 9,009 unique mappings. The former
`bosses/destroyer_mk2_effects.s` module was renamed to the 770-line
`bosses/destroyer_mk2_linked_parts_and_debris.s`; all 112 definitions have
exact static audit coverage, with 108 records added here and four geometry or
palette helpers already covered by the core pass. The name-audit total is now
4,389.

This pass establishes entity type `$25C` as a three-mode moving-part handler:
its central mode waits for controller state `$2A` or a negative part field
`$24`, launches with signed velocity, rotates while falling, and emits
type-`$88` particles; its other two
modes implement related collision, rotation, and bounce sequences. Type
`$24C` is a separate bounded horizontal-motion object. Type `$260` controls an
eight-record fragment group, while type `$264` is deliberately named generic
transition debris because Epsilon 1 explicitly preserves it and the static
code does not make it Destroyer-specific. The former `PlayRoar`, `PlayJump`,
`PlayLand`, `DefeatShake`, `DefeatFlash`, spark, smoke, and weapon-timer claims
were rejected: the affected code instead dispatches motion, initializes or
waits for fragments, converts collided debris, or activates linked records
from encounter flags. Exact on-screen identities of the moving parts and
transition debris remain unclaimed pending pinned runtime evidence.

The Bugmax core pass reduced the count from 6,814 to 6,758 and raised
provenance to 9,065 unique mappings. The cohesive 887-line
`bosses/bugmax_core.s` module now has 88 audited definitions and no live
address-derived names; the name-audit total is 4,477. Its size is retained
because this single controller range couples four geometry modes, the shared
position/angle history buffers, linked-record initialization, the opening
transition, and the first linked-part motion states. Splitting inside those
cross-cutting loops would reproduce the formal fragmentation rejected for the
earlier source.

The pass corrects the most consequential generated Bugmax claim. Main states
`$08-$0C` are not a defeat sequence: they run before the spin, jump, and battle
states, wait for two stage-scroll thresholds, load two replacement tile sets,
and emit transition debris from linked-record coordinates. The actual forced
final boundary is state `$56`, selected only after the encounter flags and
`word_FF8200` clear. The former `UpdateLegs`, `RotateParts`, and generic
`CalculatePerspective` labels are also narrowed to the implemented linked
chain direction, history buffer, joint-angle clamp, or perspective-row
operation. The opening transition's exact narrative presentation and the
on-screen identity of each linked record remain deliberately unclaimed until
pinned runtime evidence is available.

The Bugmax battle-and-final-sequence pass reduced the address-derived unknown
count from 6,758 to 6,684 and raised provenance to 9,139 unique mappings. The
former `bosses/bugmax_attacks.s` is now the 847-line
`bosses/bugmax_battle_and_final_sequence.s`; retaining one module is
intentional because its contiguous main states `$18-$62` initialize the same
linked records, select two projectile volleys and one linked-chain strike, and
then execute the forced final sequence. Splitting that state table would make
the control flow less legible while the file is already inside the agreed
300-1,000-line range. All 114 definitions in the module and nine directly
used contact/mapping helpers have exact static audit records, bringing the
name-audit total to 4,600.

This pass rejects the remaining generated `Mouth`, generic `SpecialAttack`,
`SmartPositioning`, landing, and reversed vertical-motion claims. The first
battle pattern emits a timed volley of horizontally scattered projectiles.
The middle pattern bends the eight-record secondary chain, aims its shared
angle at the player, enables collision on the central linked object, processes
contact effects, and retracts the chain. The other projectile pattern chooses
the player or a `$D0` side offset and emits eight bouncing sine projectiles.
State `$56` begins the real final sequence: it waits for a wave band, pulses
the palette, converts 22 linked records into falling type-`$344` parts, sends
the controller upward with a negative velocity while emitting particles,
relocates it, and then accelerates through the final descent. The exact visual
identity of both battle tile sets, the central linked part, and the scattered
type-`$344` parts remains deliberately unclaimed pending pinned runtime
evidence.

The Bugmax projectile pass reduced the address-derived unknown count from
6,684 to 6,646 and raised provenance to 9,177 unique mappings. The cohesive
542-line `projectiles/bugmax.s` module now has exact static audit coverage for
all 65 definitions and no live address-derived names; 59 records were added
in this pass because six aimed-chain contact helpers were already covered by
the preceding battle pass. The name-audit total is now 4,659.

Entity dispatch and creation sites now distinguish the four previously mixed
roles. Type `$338` is a normal or special hit fragment emitted when an opening
linked record exposes collision flag bit 6. Type `$33C` is the horizontally
scattered battle projectile: one contact path locks two palette ranges through
fade-out, hold, and restore states, while terrain contact converts the object
to type `$88`. Type `$340` derives its launch velocity from a shared sine
phase, performs up to three terrain bounces, and may convert into a random
pickup on two collision flags. Type `$344` is assigned to the 22 linked
records scattered by the final sequence and adds gravity while optionally
emitting a periodic type-`$88` trail. The former generic `Enemy`, `Debris`,
`MainController`, screen-shake, and `ExplosionWait` descriptions are therefore
rejected. Exact rendered identities of the type-`$338` variants and the two
standard fragment mappings remain deliberately unclaimed.

The Bugmax movement and palette pass reduced the address-derived unknown
count from 6,646 to 6,598 and raised provenance to 9,225 unique mappings.
The cohesive 362-line `bosses/bugmax_movement.s` module now has exact static
audit coverage for all 62 definitions and no live address-derived names; 59
records were added in this pass because the central-part mapping helper and
its two exits were already audited. The name-audit total is now 4,718.

The opening controller's horizontal target steering is now separated from
the eight-record object-pool clamp. The clamp table contains only seven
explicit minimum/maximum pairs even though the original loop visits eight
records; the eighth indexed pair therefore overlaps the first two instruction
words of the following palette routine. This original ROM behaviour is
recorded in the audit evidence rather than normalized in the preservation
source. The former perspective helper is now identified narrowly as a signed
wave-displacement palette offset, while the battle movement path is split into
wave integration, bounded horizontal steering, and vertical-band steering.
The two unreferenced controller-input routines are described only by their
observed angle, position, and wave-accumulator effects. Exact visual identities
of the opening records and the original development purpose of those
unreferenced helpers remain deliberately unclaimed.

The Shield Viper core pass reduced the address-derived unknown count from
6,598 to 6,555 and raised provenance to 9,268 unique mappings. The cohesive
686-line `bosses/shield_viper_core.s` module now has exact static audit
coverage for all 66 definitions and no live address-derived names. Ten
directly used geometry, movement, rendering, and projectile helpers were
audited with it, bringing the name-audit total to 4,794.

The controller now exposes its two distinct body-layout paths. Trail mode
shifts the controller angle and packed position through parallel history
buffers and samples them at fixed intervals for 24 body records. Linked-body
mode accumulates polar offsets across sixteen records, optionally anchors X
and Y to selected records independently, projects eight trailing records from
their predecessors, and maintains a separate trailing-angle history. The
opening state path creates those 24 records from an explicit radius/subtype/
mapping table plus two auxiliary records. Its first battle sequence alternates
entry side and angular direction, switches geometry when the center record
reaches angle `$80`, applies symmetric target offsets through three bend
phases, and emits sixteen timed type-`$374` shots from an orbiting auxiliary
record.

This pass rejects the old generic `Dispatcher`, `Collision`, `IdleState`,
`AttackState1/2`, `SpinAttack`, and `WolfGaropaMovement1` claims. The former
collision helper only approaches a wrapped angular-offset target; the former
idle helper updates a signed triangle-wave radial step; and the supposed Wolf
Garopa movement routine only forces Shield Viper sprite flip attributes. The
exact rendered identities of individual body mappings and both auxiliary
records remain deliberately unclaimed pending pinned runtime evidence.

The Shield Viper attack-sequence pass reduced the address-derived unknown
count from 6,555 to 6,513 and raised provenance to 9,310 unique mappings. The
cohesive 509-line `bosses/shield_viper_attacks.s` module now has no live
address-derived names and exact static audit coverage for all 77 unique
definition addresses; its binary-asset `_End` alias shares address `0x04EAC4`
with the following routine and retains explicit provenance instead of a
duplicate audit record. Six associated movement, steering, and orbit-shot
helpers were audited with the module, bringing the name-audit total to 4,875.

The state sequence now separates three mechanisms that the imported names had
conflated. States `$32`-`$36` perform two eight-sample passes which periodically
choose the sign of angular motion toward the player and allocate no projectile.
States `$44`-`$48` wind up and emit frame-gated type-`$374` shots from the
orbiting auxiliary record. States `$54`-`$56` attach empty type-`$10` records
to as many as 24 body records with staggered activation, while states `$58`-
`$5A` independently build a randomized index order and spawn up to twelve
type-`$378` projectiles from a 32-record binary table. A later state sequence
releases linked records across the body one at a time before restoring the
tracking cycle.

This pass rejects the old `SpawnProjectile1`, difficulty, damage, ascent,
generic multi-shot, child-array spawn, and Wolf Garopa implications. The
supposed difficulty branch uses a bit of the current RNG result; the supposed
damage helpers only choose rotation direction toward the player, a random
vertical target, or fixed arena point `($120,$F0)`; and the old child-array
initializer only prepares a pointer, count, and timer. Type-`$10` records are
therefore described structurally rather than assigned an unsupported visual
or projectile identity. Exact visual identities of the type-`$374` and
type-`$378` mappings remain deliberately unclaimed pending pinned runtime
evidence.

The Shield Viper body-record and projectile pass reduced the address-derived
unknown count from 6,513 to 6,467 and raised provenance to 9,356 unique
mappings. The cohesive 489-line `projectiles/shield_viper.s` module now has no
live address-derived names and exact static audit coverage for all 66
definition addresses. Its shared quantized-angle mapping helper and the two
eight-record controller/body mapping tables were audited with it, bringing the
name-audit total to 4,942.

Entity type `$370` is now documented as the per-body-record state machine. It
does not spawn a projectile. Its first linked-record sequence copies a body
record's visual state to an already allocated type-`$10` record, hides and
disables collision on the body, waits for the controller-supplied stagger,
then launches the linked visual perpendicular to the effective body angle.
After that record leaves the arena, the body waits detached. The later
sequence starts a replacement linked visual at radial offset `$300`, contracts
the offset to zero, and finally restores the body's saved display and collision
state. These operations establish a body-visual relationship, but not the
fictional or anatomical identity of each individual mapping.

The two projectile types are also separated. Type `$378` waits on a stagger
value supplied by the 32-record pattern asset, enables collision, blinks for
sixteen frames, loads its X/Y velocity, and is retired against bounds chosen by
the velocity signs. Visible type-`$378` records convert to the shared defeat
object once the boss-defeat flag is set. Type `$374` is the independently
emitted orbit shot: it advances through eight timed mapping records and a
terminator, and its destruction path requests a random pickup. The entry at
`0x04F01E` is explicitly recorded as a deliberate fall-through that only moves
the current-record pointer into `a0`; it never copies an entity.

Controller states `$70`-`$78` now describe the complete transition into
defeat: convert displayed controller/body or linked records to type `$37C`
with increasing even timers, wait for the stagger, run the post-defeat palette
cycle, step the final palette fade, then hold its terminal step for four frames
before removal. This rejects the old `SpawnProjectile2`, generic bullet,
child-circular-motion, spin-attack, copy-entity, explosion, and movement-helper
claims. In particular, the former `Movement1` only selects a mapping and
orientation bits from a quantized angle, while the former projectile
`Explode` routine performs palette work and allocates no effect.

The Shield Viper defeat and shared-geometry pass reduced the address-derived
unknown count from 6,467 to 6,439 and raised provenance to 9,384 unique
mappings. The 402-line `bosses/shield_viper_defeat.s` module now has no live
address-derived names and exact static audit coverage for all 48 definitions:
35 records were added here and 13 geometry/mapping helpers had already been
audited with the preceding core and projectile passes. The project-wide
name-audit total is now 4,977.

Entity type `$37C` is now represented as its own three-state defeat-object
machine. Each converted controller, body, linked visual, or pattern shot waits
for the assigned stagger, enables its display state, creates a falling
type-`$88` burst, and derives a radial acceleration vector from its effective
angle. The active state adds that vector to X/Y velocity every update and
rotates the mapping when the conversion supplied a mapping table. The third
state is an explicit no-op. This replaces the non-descriptive `DefeatState1`
and `DefeatState2` labels without claiming an unsupported on-screen identity
for every converted record.

The internal geometry paths now name their actual loops: trail mode writes
four angle/position samples across each adjacent-record interval; linked mode
rebases effective body angles and seeds eight-sample trailing-angle groups;
the body-bend helper writes symmetric target offsets; and radial movement
scales sine components by the shared step. Three routines with no static
callers remain documented strictly by their observed data flow. One writes
four wrapped-angle samples between sixteen adjacent body records, one stores
the magnitude and sign of an input-versus-bend-step delta, and one clamps
record field `$14` inside the vertical band. The last routine was previously
misnamed `ClampXPosition`: it never accesses X field `$10`, so the old axis
claim is explicitly rejected.

The Shield Viper debug and pattern-effect pass audited the remaining 41 names
in the 325-line `bosses/shield_viper_debug_and_effects.s` module. Together
with eight helpers already covered by earlier Shield Viper passes, all 49
definitions in the module now have exact static audit records, bringing the
project-wide total to 5,018. This pass intentionally leaves the
address-derived unknown count at 6,439 and provenance at 9,384: its targets
were pre-existing semantic names rather than raw address labels, so claiming
numeric burn-down here would be misleading.

Entity type `$3A8`, created as Shield Viper's second auxiliary record, is now
identified as a pattern-effect controller rather than `Movement2`. On even
frames it clears a 96-longword workspace, advances the primary range phase,
selects a palette word, dispatches one of four local pattern states, and queues
the workspace for rendering. Those states implement two ten-frame delays, a
timed secondary phase, and a combined secondary/tertiary phase. The old
`UpdateSprites`, `AnimationScript`, `ProjectileMain`, and `ProjectileBullet`
names are rejected: the routines neither walk sprite records nor interpret a
script nor allocate projectiles.

The unreferenced manual-control entries are also described only by observed
effects. They adjust the controller angle, shared body-bend step, or X/Y fields
of two selected records; a separate input-gated helper performs one radial
movement update and never triggers an attack state. Another input branch
chooses between frame-gated orbit-shot emission and hiding the orbit record.
Likewise, the two trailing unreferenced effect helpers are no longer asserted
to be particle gravity: one accumulates progressively negative deltas across
96 longwords and copies their high words to a strided buffer, while the other
increments or decrements four counters according to frame parity. Their
original development purpose remains unclaimed without runtime evidence.

The Wolf Garopa controller pass reduced the address-derived unknown count from
6,439 to 6,386 and raised provenance to 9,437 unique mappings. The cohesive
762-line `bosses/wolf_garopa_core.s` module now has no live address-derived
names and exact static audit coverage for all 85 definitions. Twenty-three
directly coupled pose, orb, effect, projectile, and post-defeat helpers were
audited with it, bringing the project-wide name-audit total to 5,126.

The controller now exposes two nested state machines instead of a flat list of
supposed attacks. The outer type-`$3E8` machine builds the composite boss,
runs its left-side entry, maintains a timed orb charge/projectile cycle,
sweeps the orb through fixed wrapped angles `$140`, `$C0`, and `$180`, and
then selects one of two type-`$424` sequences. The inner field-`$35C` machine
steers fixed-point X velocity toward a target, applies three distinct
gravity/launch transitions, consumes pose-event bits, and selects linked RAM
records whose Y coordinate is forced to `$148`.

The adjacent helpers establish what the old `ShootPattern` and
`SpawnProjectile` names had conflated. One routine is a pose-script
interpreter with duration, event, loop, and terminator commands; another only
calculates interpolation deltas. The former `SpawnProjectile3` updates the
auxiliary orb's mapping, center, radius, and endpoint without allocating an
object, while the former `SpawnProjectile4` merely approaches a requested
wrapped angle and reports completion in `d3`. Actual allocation is isolated
to the paired projectile emitter and the orbit-centered star, spark, and
type-`$188` explosion effects.

This pass also rejects the old `Bullet1`, `Bullet2`, `Homing`, `Laser`,
`Damage`, `Collision`, `DefeatInit`, `DefeatAnim`, and generic animation
claims. Those entries respectively wait for battle readiness, steer the orb,
allocate a projectile pair, choose a direction mapping, drive the defeat
fade, emit orbit sparks, emit a charge star, calculate an emitter position,
or run post-defeat timing. The visual identities of type `$424`, the three
lazily loaded attack-effect tile variants, individual pose scripts, and the
four linked RAM records remain deliberately unclaimed pending pinned runtime
evidence.

The Wolf Garopa pose, orb, and projectile pass reduced the address-derived
unknown count from 6,386 to 6,322 and raised provenance to 9,501 unique
mappings. All 78 unique definition addresses in the 688-line
`projectiles/wolf_garopa.s` module now have exact static audit coverage: 65
records were added here and 13 public helpers were covered by the controller
pass. The binary pose-target `_End` alias shares address `0x0509B0` with the
following routine and retains source provenance without duplicating an audit
address. The project-wide name-audit total is now 5,191.

The former shooting-pattern block is now separated into a real pose-command
interpreter, four composite-part angle groups, six named command streams, a
binary target table, and the interpolation initializer. Commands distinguish
timed target interpolation from event-byte updates, `$FFFF` looping, and
`$FFFE` termination. The orb path separately approaches wrapped angles,
selects directional mappings, computes its center and attached endpoint, and
cycles three tile-transfer frames. None of those helpers allocates a
projectile.

The actual emitter creates a pair of object records at the calculated orb
position. Entity type `$408` is now conservatively named an orb shot: its
handler checks arena bounds, reflects velocity, can convert the record to type
`$160`, or enters a fallback that either requests a small pickup or marks the
record for removal. This rejects the imported `Wave` identity because no wave
table or wave-motion update exists. Exact on-screen identities of the
projectile pair, type `$160` conversion, and attack-effect variants A/B/C
remain unclaimed without pinned runtime evidence.

The Wolf Garopa effects-and-transition pass reduced the address-derived
unknown count from 6,322 to 6,294 and raised provenance to 9,529 unique
mappings. The misleading `bosses/valkirie_screen_transition.s` container is
now `bosses/wolf_garopa_attack_effects_and_transition.s`: all callers and
state writes prove that its 243 lines belong to Wolf Garopa. Together with the
three remaining returns in `bosses/wolf_garopa_defeat.s`, 31 unique addresses
were added to the audit, bringing the project-wide total to 5,222. Both
modules now have zero live address-derived definitions and exact audit
coverage for all unique addresses.

The former Valkirie-labelled routines are the paired type-`$418`/`$420`
attack effect created by Wolf Garopa's two lazy effect loaders. Type `$418`
tracks a screen-relative boundary, compares a vertical band with the player,
and pushes player X when the boundary is crossed; it never forces player Y to
the ceiling. Type `$420` follows that boundary while it exists, otherwise
scrolls independently until its lifetime expires. No Valkirie caller or state
dependency exists, so the old `InitScreenPair`, `ForcePlayerToCeiling`, and
`ScreenTimer` identities are explicitly rejected rather than retained for
historical familiarity.

The latter half now names the defeat timer, bounded fade steps, randomized
type-`$88` debris emission, post-defeat delay, and auxiliary-orb palette pulse
directly. The exact on-screen appearance and original design terminology for
the boundary pair remain unclaimed; `Boundary` describes only the statically
observed coordinate comparisons and player-X constraint.

The Valkirie composite-viewer pass reduced the address-derived unknown count
from 6,294 to 6,264 and raised provenance to 9,559 unique mappings. The
442-line `bosses/valkirie_core.s` container has moved to
`debug/valkirie_composite_viewer.s`, and all 40 definitions now have exact
static audit coverage with no live address-derived names. The project-wide
name-audit total is now 5,262.

Entity type `$3EC` does not implement a Valkirie battle controller. Its table
contains only initialization and an interactive update: controller-1 bits
five and six change facing and DMA tile sets, while bits two and three adjust
the displayed angle. Each frame then advances a fixed pose-command stream,
updates twenty composite parts, positions mirrored part pairs and a gun
mapping, and writes a shared screen anchor. There is no attack selection,
damage handling, player targeting, or defeat state in this module. The
`debug` classification therefore describes observed interactive viewer
behaviour; it does not claim that the object is unreachable in every retail
execution path.

The pose data is now separated into base values, a command stream, four target
records, interpolation setup, and the sixteen-component writer. This rejects
the old `ValkirieForce_StateInit` and broad `AnimationController` names: the
former is the persistent controller-input update, not initialization, and the
latter is specifically the viewer pose-script interpreter. The original
development-menu name and intended artist workflow remain unclaimed pending
runtime or documentary evidence.

The secondary Valkirie viewer pass reduced the address-derived unknown count
from 6,264 to 6,236 and raised provenance to 9,587 unique mappings. The former
`bosses/valkirie_miniboss.s` and `bosses/valkirie_auxiliary.s` containers are
now the ROM-ordered `debug/valkirie_secondary_composite_viewer.s` and
`debug/valkirie_tertiary_composite_viewer.s`. All 42 definitions across the
pair have exact static audit coverage and no live address-derived names,
bringing the project-wide name-audit total to 5,304.

Each module begins with a minimal two-state controller for type `$3F0` or
`$3F4`: initialization assigns a fixed position and self links, while state
two only publishes readiness byte `FFA958` after global wait `FF80C2` clears.
Neither controller initializes a metasprite, selects an attack, or implements
damage. The old `Miniboss`, `Part3`, `ValkirieForce_State20`, and
`ValkirieForce_State34` claims are therefore rejected in favor of explicit
type-number names.

The remaining entry in each module has no static caller. Both read controller
up/down, adjust a wrapped angle, run a fixed eighteen-component pose script,
and begin traversal of 25 composite parts. They are documented as secondary
and tertiary viewer entries because that is the observable behavior, but
their menu wiring, reachability, and original developer-facing names remain
unknown. The separate files are retained because they are adjacent,
self-contained ROM ranges of roughly 230 lines and use different pose-target
tables.

The first Z-Leo core pass reduced the address-derived unknown count from 6,236
to 6,212 and raised provenance to 9,611 unique mappings. It gives exact static
audit coverage to all 31 definitions in ROM range `$051AD6-$051EB4`, bringing
the project-wide name-audit total to 5,335.

The main handler advances three independent signed palette-fade counters
toward zero, applies them to palette ranges `FFE302`, `FFE322`, and `FFE362`,
dispatches the even-valued boss state, then clears `FF9500`. The latter is
called a per-frame projectile flag because the Z-Leo drop-projectile handler
sets it and the Z-Leo rendering path tests it; no broader lifetime or global
meaning is claimed. The 29-entry state table remains ROM ordered, and its
single-instruction subtraction anchor is now the neutral `Boss_ZLeoNoOp`
rather than the imported ordinal `nullsub_120`.

The initialization block now distinguishes the stage gate, composite-part
setup, three-by-three intro-part rows, six lower intro parts, descent setup,
and shared rendering handoff. The old `Attack_State8` name was misleading:
that state only lowers the selected composite coordinate to `$E8` and clears
an intro flag. The adjacent controller-reading entry has no static caller and
is recorded as `Debug_ZLeoPositionAndStartIntro`; its directional movement and
two adjustments of shared coordinate `FFDB34` are observable, while its
original menu wiring and intended developer workflow remain unknown.

The second Z-Leo core pass reduced the address-derived unknown count from
6,212 to 6,200 and raised provenance to 9,623 unique mappings. All 19
definitions in ROM range `$051EB6-$052045` now have exact static audit
coverage, bringing the project-wide name-audit total to 5,354.

This range is now expressed as a continuous transition rather than a list of
numbered "attack states": intro countdown, battle-entry movement and fade,
entry-pose hold, animated battle pose, timed battle-ready pose, boss-message
delay, and the message wait gate. In particular, former `Attack_State14` only
waits on an entry-pose timer, while former `Attack_State20` only holds the
final pose before starting the shared boss message; neither name justified an
attack claim. The exact visual meaning of the pose tables remains outside this
pass, so the new names describe control flow and observable side effects
rather than inventing animation titles.

The boss-message and Z-Leo health-zero correction reduced the address-derived
unknown count from 6,200 to 6,187 and raised provenance to 9,636 unique
mappings. Twenty-five new audit records bring the project-wide total to 5,379.
The widely used `UI_CheckVictoryCondition` name was rejected: its callers are
boss intro and phase gates, and the routine selects a text pointer, stores it
in `FF80C8`, and publishes wait gate `FF80C2`; it never reads boss health or
tests victory. It is now `UI_StartBossMessage`, with named special-message,
selector, pointer-store, and pointer-table labels. The derived Bugmax,
Missiray, and Shiper victory/defeat names and several stale audit descriptions
were corrected with it; those states only start or wait for the same message
gate before ordinary battle flow resumes.

That cross-call evidence also separates Z-Leo's pre-message states from its
actual defeat. The former states at `$051FC6-$052045` prepare phase tiles,
pose, and message timing before entering the first attack cycle. The true
defeat spans `$052046-$0521C1`, reached directly from `Boss_ZLeoMain` only when
shared health `FF8200` is zero, then runs transition, fade, whiteout, object
clearing, paired palette fill, post-defeat delay, and an inert final state.
`Boss_ZLeoLoadPhaseTiles` replaces the false defeat-only helper name because a
later live attack phase calls the same tile loader.

The first Z-Leo attack-selection pass reduced the address-derived unknown
count from 6,187 to 6,178 and raised provenance to 9,645 unique mappings. All
12 definitions in ROM range `$0521C2-$052289` now have exact static audit
coverage, bringing the project-wide name-audit total to 5,391.

The old `AttackPattern1` wrapper only resets pose state and returns to selector
state `$1E`. That selector waits on its timer, uses health thresholds `$4200`
and `$2500` to choose a random mask, then branches to either the alternate
initializer or a laser opening. The latter starts one laser, holds for `$80`
ticks, swaps the shared phase tiles at `$60`, and selects one of four pose
streams before entering the orb-attack pose. Names in this range describe
that control flow without assigning an unsupported visual identity to the
alternate opening.

The following Z-Leo orb-sequence pass reduced the address-derived unknown
count from 6,178 to 6,169 and raised provenance to 9,654 unique mappings. Its
12 code and data definitions at `$05228A-$0522F5` and
`$052CC2-$052D1B` have exact static audit records, bringing the name-audit
total to 5,403.

The four opening pose streams all issue event command `$8001`; the state at
`$05228A` consumes event bit zero before entering state `$22`. That state
calls `Boss_ZLeoSpawnOrb` while the selected pose is active. Its terminal
`$FFFE` command makes the pose cursor negative, which starts state `$24` and
the shared recovery pose. Recovery returns to attack selection only after
that pose also terminates. This evidence replaces the old numeric `State1`,
`State28`, and `State30` labels with roles in the observed orb sequence.

The scrolling-laser entry pass reduced the address-derived unknown count from
6,169 to 6,165 and raised provenance to 9,658 mappings. Seven definitions in
code range `$0522F6-$0523A9` plus pose stream `$052D1C-$052D43` now have exact
static audit records, taking the audit registry to 5,410 entries.

This is the selector's alternate branch: it installs state `$26` and waits
for event `$8001` from a dedicated entry pose. The event enables stage-motion
flags, seeds a negative scroll velocity, and advances to state `$28`. That
state stops the initial velocity at coordinate `$40`, keeps rendering the
same pose, and on `$FFFE` initializes the following laser-spawn counter to
three. The previous `AttackInit`, `AttackSequence`, and
`ultimate move` wording overstated what these entry states alone establish.

The laser-burst loop pass reduced the address-derived unknown count from
6,165 to 6,160 and raised provenance to 9,663 mappings. Six definitions in
`$0523AA-$0523FF` and pose stream `$052D44-$052D57` now have exact static
audit records; the registry contains 5,416 unique entries.

State `$2A` restarts the same pose whenever it reaches `$FFFE`. Each pass
emits event `$8001`, selects one of two anchor objects, and calls
`Projectile_ZLeoSpawnLasers`, which creates two laser projectiles. Although
the counter begins at three, it is decremented before the signed-negative
test, so the transition occurs after four events. The fourth event enters
state `$2C`, enables the scrolling flag, clears its acceleration field, and
starts an `$80`-frame interval.

The scroll acceleration/cruise pass reduced the address-derived unknown count
from 6,160 to 6,155 and raised provenance to 9,668 mappings. Seven definitions
across `$052400-$05248D` now have exact static audit records, taking the
registry to 5,423 entries.

State `$2C` raises its local scroll rate by `$4000` per frame to a `$78000`
ceiling, integrates four times that rate into Z-Leo's vertical base, clamps
the base at `$180`, and updates the stage scroll for `$80` frames. State
`$2E` then holds the established motion for a second `$80`-frame interval.
Its expiry seeds the reverse stage coordinate and velocity, adjusts the two
scroll bounds, and enters state `$30`. The prior numbered `final attack 1/2`
comments conveyed none of this control flow and have been removed.

The reversal/drop-attack pass reduced the address-derived unknown count from
6,155 to 6,147 and raised provenance to 9,676 mappings. Eleven definitions
across `$05248E-$05254F` now have exact static audit records, bringing the
registry to 5,434 entries.

State `$30` clears stage-motion flags at coordinate `$C0`, subtracts `$880`
per frame from the external velocity until it crosses zero, and simultaneously
drives Z-Leo's local rate toward signed `$FFF88000`. Once external motion has
stopped, its `$80`-frame delay counts down into state `$32`. Both states share
an update that rotates three attack-palette entries and, after the stage
trigger clears, spawns a drop projectile every 16 frames. State `$32` holds
that behavior until scroll coordinate `FFA90C` falls below `$240`, then enters
the rising phase. This replaces the unsupported `final attack 3/4` wording.

The rising-return pass reduced the address-derived unknown count from 6,147
to 6,139 and raised provenance to 9,684 mappings. Eleven definitions in code
range `$052550-$052623` and data range `$052D58-$052D67` now have exact static
audit records, increasing the registry to 5,445 entries.

The `$240` scroll threshold starts state `$34` with Z-Leo's vertical base at
`$240` and the existing signed-negative local rate. Each frame integrates
that rate and updates stage scroll until the vertical base passes below
`$F0`. The transition then restores scroll/base values, clears the attack
flag, and enters state `$36`; after a `$20`-frame pose delay it installs the
normal `$80` selection delay and returns to `Boss_ZLeoBeginAttackSelection`.
This proves the old `rising attack`, `final attack 5`, and `ultimate finale`
descriptions were backwards: the block returns from the attack.

The shared Z-Leo render-tail pass reduced the address-derived unknown count
from 6,139 to 6,136 and raised provenance to 9,687 mappings. The three labels
at `$052624-$052681` now have exact static audit records, increasing the
registry to 5,448 entries. The first synchronizes the external stage
coordinate; the common tail then updates pose segments, composite parts,
camera coordinates, tiles, graphics, and the frame-dependent flash color.

This pass also establishes a subsystem milestone: `z_leo_core.s` now contains
zero live address-derived definitions. The remaining Z-Leo backlog is 40 in
`z_leo_rendering.s` and 31 in `projectiles/z_leo.s`; those figures are recorded
as a bounded continuation target rather than hidden by semantic guesses.

The Z-Leo tile-stream pass reduced the address-derived unknown count from
6,136 to 6,125 and raised provenance to 9,698 mappings. Eleven definitions in
`$0526E2-$052765` now have exact static audit records, bringing the registry
to 5,459 entries. The rendering-module backlog fell from 40 to 29.

`Boss_ZLeoTileUpdate` compares the signed stage scroll coordinate with an
ordered threshold table and moves a stream index in either direction. Moving
forward selects one of six VRAM destinations and copies a corresponding
six-byte tile-source-index row into a generated one-row descriptor. Moving
back builds the same descriptor with six zero indices. Both paths tail-call
`Gfx_LoadCompressedTiles`. The new names describe descriptor structure and
directional behavior without guessing what the artwork depicts.

The Z-Leo tile-loader/HBlank pass reduced the address-derived unknown count
from 6,125 to 6,120 and raised provenance to 9,703 mappings. Seven definitions
in `$0527EA-$052879` now have exact static audit records, increasing the
registry to 5,466 entries and reducing the rendering backlog from 29 to 24.

The old `Boss_ZLeoAnimationUpdate1` contains no animation logic: both callers
feed its two-index descriptor directly to `Gfx_LoadCompressedTiles`, so it is
now `Boss_ZLeoLoadPrimaryTiles`. The neighboring phase loader has its own
descriptor. `Boss_ZLeoGraphicsInit2` was likewise too vague: it writes four
groups of VDP register values (`8Axx`, vertical value, `8Bxx`, `82xx`) into
effect buffer `FF9E00`, with split lines derived from the stage coordinate.
Its name now states that it builds the Z-Leo HBlank register buffer.

The initial-graphics/defeat-effects pass reduced the address-derived unknown
count from 6,120 to 6,111 and raised provenance to 9,712 mappings. Twelve
definitions across `$05287A-$052A7F` now have exact static audit records,
bringing the registry to 5,478 entries and the rendering backlog from 24 to
15.

`Boss_ZLeoGraphicsInit3` is now named for its two observable operations:
loading the initial tile descriptor and setting pattern `$81` on four queued
sprites. The blade pointer table is passed to the four-direction frame helper,
and the former anonymous head tail writes three linked part positions.

Two further Sonnet `AnimationUpdate` names were false. The first defeat-only
helper updates the explosion and spawns either debris or a randomized type-160
particle around Z-Leo. The second contains no animation logic at all: it adds
`$800` to the defeat-stage velocity until coordinate `FFDB34` reaches `$200`,
then clamps the coordinate and clears both stage-scroll control words.

The Z-Leo pose-interpreter pass reduced the address-derived unknown count from
6,111 to 6,096 and raised provenance to 9,727 mappings. All 15 remaining
definitions in `z_leo_rendering.s`, spanning code `$052A8A-$052C33`, pose
streams `$052C56-$052D67`, and keyframe blob `$052D68-$052EE1`, now have exact
static audit records. The registry contains 5,493 entries.

The interpreter consumes `$80xx` event commands, `$FFFF` loop commands,
`$FFFE` terminal commands, and four-byte interpolation commands. For the last
form, the low command byte configures interpolation, the following signed word
selects a record relative to `Boss_ZLeoPoseKeyframeData`, and the high command
byte becomes the frame duration. Fourteen interpolation channels are then
projected into the linked segment chain and boss/camera coordinates. The six
formerly anonymous streams are named from their exclusive state consumers.

This completes a second subsystem milestone: both `z_leo_core.s` and
`z_leo_rendering.s` now contain zero live address-derived definitions. The
bounded Z-Leo backlog is now only the 31 definitions in `projectiles/z_leo.s`.

The first Z-Leo projectile pass reduced the address-derived unknown count from
6,096 to 6,090 and raised provenance to 9,733 mappings. Six definitions in
`$052EFE-$053059` now have exact static audit records, bringing the registry
to 5,499 entries and reducing the projectile backlog from 31 to 25.

`Boss_ZLeoScrollUpdate` has separate positive- and negative-rate paths that
integrate into `FFA90C`, normalize around their respective wrap boundaries,
then pass a four-pair lookup table to the shared coordinate helper. The orb
spawner gates itself to every fourth frame, selects one of two initial field
values, allocates two projectile slots, and uses a segment angle to select one
of eight signed spawn-offset pairs. The convergence label is deliberately
named `FinishOrbVelocitySelection`: it is shared by both random outcomes and
does not claim that either value is the canonical one.

The Z-Leo orb-lifecycle pass reduced the address-derived unknown count from
6,090 to 6,082 and raised provenance to 9,741 mappings. Eight definitions in
`$053070-$0530ED` now have exact static audit records, taking the registry to
5,507 entries and the projectile backlog from 25 to 17.

The ordinary orb path enforces horizontal bounds `$80-$1BF` and a lower
vertical bound of `$70`, then reflects positive vertical velocity when the orb
crosses the external stage coordinate. A status-bit path reflects both
velocity components and changes sprite data; the removal path has a one-in-four
RNG branch to `Pickup_SpawnSmallFromCurrentObject`. Frame-counter bit zero
alternates the two sprite attribute words. The following dispatch target is a
confirmed one-instruction no-op rather than an unexplained `nullsub`.

The Z-Leo laser-lifecycle pass reduced the address-derived unknown count from
6,082 to 6,072 and raised provenance to 9,751 mappings. Ten anonymous
definitions in `$053180-$053317` and one existing semantic label now have exact
static audit records, taking the registry to 5,518 entries and the projectile
backlog from 17 to 7.

The initial projectile starts with radius four and a frame-derived angular
phase. While its vertical coordinate remains in `$80-$17F`, the ordinary path
advances the angle by six and radius by five, then derives position and velocity
from the sine table around the center at `FFC630/FFC634`. Its status paths can
convert it to a type-160 particle or change it to object type `$498`, clear
vertical velocity, and launch it horizontally in a direction selected by bit
three of `FFA40E`.

The old `Projectile_ZLeoLaser_CollisionCheck` name understated its role. Object
type `$498` dispatches directly to this full horizontal-laser handler: status
bit seven converts the laser to an impact effect, while its ordinary path emits
a trail every fourth frame. Both phases share the trail spawner, which creates
a type-`$88` particle at a randomized nearby coordinate with velocity opposite
the source laser.

The final Z-Leo projectile pass reduced the address-derived unknown count from
6,072 to 6,065 and raised provenance to 9,758 mappings. All seven remaining
definitions in `projectiles/z_leo.s`, spanning `$0533BC-$0534FF`, now have exact
static audit records, taking the registry to 5,525 entries.

The scrolling-attack pair has a shared allocation-failure return, and its
timed laser applies `$80000` of negative vertical acceleration until lifetime
expiry. The drop-attack spawner selects horizontal velocity `+$60000` below X
`$120` and `-$60000` at or above that coordinate. Its companion moves upward
to Y `$F0`, pauses for `$10` ticks, then continues subtracting `$20` from Y
until it leaves the screen. This corrects the former Sonnet prose claim that
the post-pause motion fell downward.

This completes the Z-Leo subsystem milestone: `z_leo_core.s`,
`z_leo_rendering.s`, and `projectiles/z_leo.s` now contain zero live
address-derived definitions.

The Valkirie Force pose pass reduced the address-derived unknown count from
6,065 to 6,051 and raised provenance to 9,772 mappings. All 14 anonymous
definitions in `bosses/valkirie_force.s` and one incorrect existing semantic
label now have exact static audit records, taking the registry to 5,540
entries. The module now has zero live address-derived definitions.

The two-state dispatcher initializes the shared Z-Leo/Valkirie Force
metasprite, then enters an interactive state that maps controller bits two and
three to opposing changes in a wrapped nine-bit rotation. Its pose interpreter
uses the same command classes established for Z-Leo: `$80xx` events, `$FFFF`
loop, `$FFFE` terminal, and ordinary four-byte interpolation commands. The
ordinary form uses the low byte for delta setup, a signed following offset into
the keyframe block, and the high byte as duration before projecting the
interpolated buffer into linked-part angles.

The former `Boss_Sirene_State2` is now correctly the Valkirie Force interactive
state. The trailing eight-word table was also misplaced semantically: only
Missiray code consumes its `$C680-$C920` RAM addresses, so it is now
`Boss_MissiraySegmentObjectPointers`.

The Seven Forces Valkirie projectile pass reduced the address-derived unknown
count from 6,051 to 6,037 and raised provenance to 9,786 mappings. All 14
anonymous definitions in `projectiles/seven_forces_valkirie.s` and two
incorrect existing semantic labels now have exact static audit records, taking
the registry to 5,556 entries. The module now has zero live address-derived
definitions.

The setup loop initializes nine consecutive `$60`-byte sub-entities, and the
position updater anchors one plus four helpers to the primary object and four
to its `$180`-offset companion. The projectile itself uses an eight-state
relative dispatcher whose single-return base is also reused as a deliberate
wait target by the Valkirie and top-level Seven Forces handlers. Its shared
shadow at `FFDB80` follows with offsets X `$0B` and Y `$10`; growth and shrink
states use field `$48` to select five 10-byte tile-transfer descriptors.

Two Sonnet names were structurally wrong. `Boss_ValkirieApplyGravity` modifies
horizontal velocity `$18`, subtracting `$C00` during the leftward states, so it
is now `Entity_ValkirieProjectileAccelerateLeft`. The former
`Boss_ValkirieDMATransferTable` is executable code rather than data; it is now
`Entity_ValkirieProjectileTransferAnimationTiles`, separate from the actual
five-pointer descriptor table that follows it.

The alternate Valkirie pass reduced the address-derived unknown count from
6,037 to 6,024 and raised provenance to 9,799 mappings. All 13 anonymous
definitions and all 10 existing semantic definitions in
`bosses/valkirie_alternate.s` now have exact static audit records, taking the
registry to 5,579 entries. The module now has zero live address-derived
definitions.

The alternate entity dispatches states zero, two, and four. State zero builds
the metasprite and enters state four; the separate state-two initializer and
the state-four initializer reset the same pose/motion fields. States two and
four both select one looping pose and converge on a renderer that updates a
12-channel interpolation buffer, reflects paired part angles around `$100`,
and begins metasprite traversal.

This pass corrects the contradictory Sonnet state names: the former
`Boss_ValkirieState3Setup` is the state-two table entry, while
`Boss_Valkirie_AltState2` is the state-four entry. The pose code is now named as
one interpreter with explicit read, control-word, loop/interpolation, delta,
step, and part-angle projection phases; the two anonymous data blocks are its
shared state pose and keyframe base.

The unidentified Seven Force pass reduced the address-derived unknown count
from 6,024 to 6,009 and raised provenance to 9,814 mappings. All 15 anonymous
definitions and all 11 existing semantic definitions in
`bosses/unidentified_seven_force.s` now have exact static audit records, taking
the registry to 5,605 entries. The module now has zero live address-derived
definitions.

The entity owns a three-entry dispatcher for states zero, two, and four. Its
live initialization constructs the composite object group as type `$43C` and
enters state four. State two provides controller-driven rotation, while the
ordinary state-four entry selects the same looping pose; the common renderer
updates an 18-channel interpolation buffer and projects it into chained and
mirrored part angles. Separate state-two and timed state-four initialization
entries have no static canonical references, so the audit records that limit
instead of inventing callers.

The former `Boss_Sylpheed_AltState1` is actually the state-four table entry of
this unidentified form. The broad `Boss_Valkirie*` names on its angle and pose
helpers have likewise been narrowed to the owning entity. The source does not
establish which named Seven Force form type `$43C` represents, so this pass
deliberately preserves the `UnidentifiedSevenForce` identity rather than
turning a visual or ordinal guess into source-level fact.

The player/Seven Forces ownership pass corrected a structural Sonnet error at
`0x019DAE-0x01A27F`. The first `$C2` bytes had been left at the end of
`cutscenes/stage_intros.s`, while the following contiguous range was called
`bosses/seven_force_projectiles.s`. Both ranges operate on the player object;
`Player_Update` selects them through special battle flags set by Stage 3 and
the Seven Forces transition. They now form one 437-line, ROM-ordered module at
`player/seven_forces_battle.s`, and `rom_layout.json` records the corrected
cutscene/player boundary at `0x019DAD/0x019DAE`.

This structural pass deliberately does not endorse the inherited mixed
Sylpheed, Artemis, Sirene, and Destroyer Proto labels inside that module. Their
instruction-level audit and replacement are the next reconstruction queue;
keeping that distinction prevents a file move from being presented as proof
of unverified names.

The subsequent Seven Forces player-state pass reduced the address-derived
unknown count from 6,009 to 5,974 and raised provenance to 9,849 mappings. All
35 anonymous definitions and all 21 inherited semantic definitions in
`player/seven_forces_battle.s` now have exact static audit records, taking the
registry to 5,661 entries. The 437-line module now has zero live
address-derived definitions.

The code is a seven-entry player dispatcher for states `0/2/4/6/8/A/C`.
States zero and two handle input, special activation, dash entry, damage, and
player rendering; state four waits through a weapon transition; state six is
the active dash; state eight is timed damage; state A is the defeat animation;
and state C resets the battle state. Directional state two accelerates toward
sine-derived velocity targets using a 16-byte input-angle map. The player
update tail then applies its fall clamp, direction, invulnerability, hitbox,
and center-position work.

This pass rejects every inherited boss attribution in the module. The former
`Gfx_LoadArtemisTiles` starts the player dash, `Gfx_LoadArtemisPalette` updates
dash state six, `Boss_DestroyerProtoDefeat*` is the player's defeat path, and
the Sylpheed/Sirene projectile names are player states, velocity helpers, and
renderers. None of those routines accesses the named boss entity or performs
the operation claimed by the old name.

The shared Seven Forces metasprite-data pass then reduced the address-derived
unknown count from 5,974 to 5,930 and raised provenance to 9,893 mappings. All
44 anonymous definitions and the one inherited semantic definition in the
`0x059D2C-0x05A43B` module now have exact static audit records, taking the
registry to 5,706 entries. The 435-line module has zero live address-derived
definitions.

The old `bosses/sylpheed_rendering.s` ownership was false: the range contains
metasprite initialization tables for Valkirie, Medusa, Sylpheed, Artemis,
Sirene, alternate Valkirie, and the unidentified Seven Force. It now lives at
`rendering/seven_forces_metasprites.s`. Each form's `a0`, `a1`, and `a2`
inputs are identified as part descriptors, initial angles, and packed parent
links from the reads in `Sprite_InitMetaspriteComplex`; the tables stored at
object offset `$2FC` are identified as pose-angle targets from their later use
by `Anim_CalculateInterpolationDeltas`.

The former `Boss_SylpheedSetGraphics` also has no Sylpheed reference. Its only
visible behavior is alternating object graphics word `$E` between `$C4D6` and
`$C4DF` from global-frame bit zero, so the narrower
`Object_SelectAlternatingGraphicsFrame` name replaces the unsupported owner.

The following Seven Forces cutscene ownership pass corrected the adjacent
`0x054B84-0x05575D` boundary. `cutscenes/seven_forces_intro.s` contained the
controller and its state-offset table through `0x054F9D`, while the states
selected by that same table were isolated as `bosses/seven_forces_forms.s`.
The two pieces are now one 941-line, ROM-ordered cutscene module, and
`rom_layout.json` records the combined range as a single owner. This also
reduces the layout from 341 to 340 modules without changing emitted bytes.

This structural merge deliberately does not endorse the 46 address-derived
or 52 inherited semantic definitions in the combined module. Their
instruction-level audit is the next reconstruction pass; recording that
separation prevents a better file boundary from being mistaken for semantic
proof of the existing Sonnet names.

The first semantic pass over that combined controller reduced the
address-derived count from 5,930 to 5,912 and raised provenance to 9,911
mappings. All 28 definitions in `0x054B84-0x054F9D` now have exact static
audit records, taking the registry to 5,734 entries; 18 anonymous labels were
replaced.

The state table now exposes the initial `0/2/4/6/8/A` entrance sequence. In
particular, the former `Entity_SevenForcesText*` routines never access text:
they finish the entrance timer, switch the transformation mapping, and wait
for shared transition work. The isolated `0x054C82` routine is retained as a
debug scroll-table test because it reads live directional input and builds
paired scroll buffers, but its audit explicitly records that no static caller
is present. The same no-caller limit is recorded for the adjacent three-DMA
intro setup routine instead of inventing a live execution path.

The second controller pass reconstructed all 51 definitions in states
`C-E` and `$10-$3E`. It reduced the address-derived count from 5,912 to 5,887,
raised provenance to 9,936 mappings, and took the audit registry to 5,785
entries. The sequence now explicitly follows Valkirie, Medusa, Sylpheed,
Artemis, and Sirene entrance/hold/fade states before the random-explosion and
final stage-transition states.

This removes several unsupported action names: the former boss `Main` and
`Dispatcher` routines are states of the introduction controller, both
`*UpdateSprites` routines only advance palette-fade counters, the former
`Boss_SireneShootPattern3` only resets controller state, and the generic
`Cutscene_SevenForcesEffect*` labels are now named for their observable
explosion, final-fade, and transition behavior.

The final Seven Forces intro pass audited all 19 definitions in
`0x055460-0x05575D`, removed the last three address-derived labels from the
941-line module, raised provenance to 9,939 mappings, and took the registry to
5,804 entries. `cutscenes/seven_forces_intro.s` now has zero live
address-derived definitions.

The former `Boss_MedusaBattleStart` is actually a nine-entry post-battle
transition dispatcher shared by completed Seven Force bosses. Its caller
supplies indices for the next form, controller resume states, the final
explosion transition, or a no-op. The palette helpers are likewise separated
by observable one-, three-, and four-range fades instead of being described
as boss initialization, and the generic fourth effect is identified as the
randomized transition-particle spawner used by the final fade.

The complete 834-line Valkirie battle controller at `0x05575E-0x05605B` is
now reconstructed as one coherent 19-entry state machine. All 108 definitions
in `bosses/valkirie_battle.s` have exact static audit records, all 70 former
address-derived definitions were replaced, provenance reached 10,009 mappings,
and the audit registry reached 5,912 entries. The module now has zero live
address-derived definitions without being split below its natural subsystem
boundary.

This pass also corrected several unsupported Sonnet-era descriptions. The
four former `Camera_BossMode_State*` labels are ordinary Valkirie controller
states `$04`, `$1A`, `$1E`, and `$24`; none writes camera state. The former
`Boss_ValkirieSpawnProjectile1/2` helpers only disable an old pair of body-part
objects and enable a new pair, while the former `SpawnProjectile3/4` labels are
state `$1C` and `$20` handlers. The actual bullet allocator is isolated at
`Projectile_SpawnValkirieBullet`, and the packed part-motion and part-hide
tables now name the decoders that consume them.

The companion 447-line `bosses/valkirie_rendering.s` module is also fully
reconstructed. Its 50 definitions now cover the pose interpreter, twelve
named pose streams, the included pose-frame block, the six-object auxiliary
group, and the shared Seven Forces battle-palette flash. They have 49
address-distinct audit records because `Valkirie_PoseFrameDataEnd` shares
`0x0566B6` with the following initializer. This removed all 38 remaining
address-derived definitions from the module, raised provenance to 10,047
mappings, and took the audit registry to 5,960 exact-address entries.

The former `Boss_ValkirieMovePattern1` is specifically the auxiliary-group
initializer, while `MovePattern2` is that group's entity update handler with
attached rotation, launch, and detached tracking paths. Two comments claiming
Y velocity were corrected after tracing fields `$1F8/$1FC` as the auxiliary
part's horizontal/vertical motion pair. The palette updater was renamed from
Valkirie-specific to Seven Forces-wide because Valkirie, Medusa, Sirene,
Artemis, Sylpheed, the alternate form, and the unidentified form all call it.

The ROM span `0x02A03C-0x02A30D` is no longer presented as a Valkirie-only
source file. It is now the 236-line
`projectiles/shared_boss_projectiles.s`, reflecting its actual mix of Valkirie
bullet logic, Z-Leo drop graphics, Wolf Garopa type-$424 and orb helpers, a
two-phase directional spawner, gravity/drag, and the explosion initializer
shared by several bosses and enemies.

All 29 definitions in that module have exact static audit records and its 18
address-derived labels were eliminated. Provenance reached 10,065 mappings,
the audit registry reached 5,989 entries, and the project-wide unknown ceiling
fell to 5,758. In particular, the former `Projectile_CheckLifetime` does not
check a timer: both its entry points immediately configure the shared type-$C4
explosion. The former random-frame helper instead animates Wolf Garopa's orb
from the deterministic global animation phase.

The lower Medusa block at `0x05717A-0x057435` is now separated conceptually
from the battle AI above it. Its first entity is a three-state falling-part
controller that synchronizes X to a source object and alternates terrain-wait
and gravity states; the old damage, health, projectile-main, and defeat names
did not describe those operations. The second routine consumes scroll-keyed
eight-byte records that spawn ordinary entities, small or large pickups, or
commands back into the Medusa controller.

All 19 definitions in this block were reconstructed with 18 address-distinct
audit records: `Medusa_ScriptedSpawnSequenceDataEnd` and the following
`Medusa_StateASpawnSchedule` intentionally share `0x0573E6`. This removed 14
more address-derived labels, raised provenance to 10,079 mappings, took the
audit registry to 6,007 entries, and lowered the project ceiling to 5,744.

The upper Medusa block at `0x05699C-0x057179` is now reconstructed as one
11-entry even-state controller (`0, 2, 4, 6, 8, A, C, E, 10, 12, 14`) plus its
horizontal targeting and pose-rendering pipeline. The state names deliberately
remain numeric where static flow proves the state but does not prove an attack
name. In particular, seven old `Boss_Valkirie_Behavior_*` labels were branches
of this Medusa table, while the old shooting and four projectile-spawn helpers
only interpret pose records, interpolate frames, distribute values across the
20-part metasprite, and begin shared part traversal.

All 80 renamed definitions have address-backed static audit records. This
eliminated the remaining 56 address-derived definitions from `medusa.s`, raised
provenance to 10,135 mappings, took the audit registry to 6,087 entries, and
lowered the project ceiling to 5,688. The module remains a cohesive 794-line
boss implementation, within the ordinary 1,000-line limit, so no split or
size waiver is needed.

Four especially broad data labels are explicitly registered:

| Symbol | ROM address | Evidence | Current statement |
|---|---:|---|---|
| `UnidentifiedSegaTilemap` | `0x0E8020` | hypothesis | 48 sequential tile words adjacent to the SEGA art; no live pointer has been found. |
| `UnidentifiedTilemapData` | `0x180000` | unknown | Tile-like words at the frontend asset boundary; no live pointer has been found. |
| `Credits_UnidentifiedTrailingData` | `0x0225CC` | unknown | Opaque block ending at the demo subsystem boundary; no live reference has been found, so neither purpose nor unused status is asserted. |
| `Stage11_UnidentifiedAsset` | `0x01AE96` | unknown | 314-byte asset selected by the Stage 11 configuration; its format and intended use are not established by a live consumer. |

Semantic names with `; was:` history are a second review queue. Their default
level is `hypothesis`, not `confirmed`; see `docs/provenance.md`.
