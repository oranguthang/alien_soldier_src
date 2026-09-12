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
written through `Tilemap_QueueIndexedColumns`. It neither belongs to Antroid nor
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
lookup, with callers in Stage 18 and Destroyer Proto. A provisional run placed
types `$390`, `$394`, and `$398` at frames 21,989 and 22,000 immediately before
the documented Gusthead fight. The evidence runner used for that observation
is now pinned at commit `f62b2cf`, including its Z80 sound-register tracing
support. The visual ownership remains `hypothesis` in the name audit because
the capture proves timing and object presence, not the exact player-facing
identity. The coherent 352-line implementation now lives in
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
static support: the family is created by `Stage7_ObjectSpawnList` and is
named only for its visible cloning and motion behavior. Type `$3AC` is
installed directly by `StageTransition_InitializeAsteroidField`, creates
type-`$3B0` large,
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
`BossHealth` clear. The former `UpdateLegs`, `RotateParts`, and generic
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
in `FF80C8`, and publishes `MessageSequenceState` as its wait gate; it never reads boss health or
tests victory. It was first corrected to `UI_StartBossMessage` and is now the
more subsystem-specific `BossMessage_Start`, with named special-message,
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
`Tilemap_QueueIndexedRows`. The new names describe descriptor structure and
directional behavior without guessing what the artwork depicts.

The Z-Leo tile-loader/HBlank pass reduced the address-derived unknown count
from 6,125 to 6,120 and raised provenance to 9,703 mappings. Seven definitions
in `$0527EA-$052879` now have exact static audit records, increasing the
registry to 5,466 entries and reducing the rendering backlog from 29 to 24.

The old `Boss_ZLeoAnimationUpdate1` contains no animation logic: both callers
feed its two-index descriptor directly to `Tilemap_QueueIndexedRows`, so it is
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
lowered the project ceiling to 5,688. After normalizing its inherited XREF
comments, the module remains a cohesive 791-line
boss implementation, within the ordinary 1,000-line limit, so no split or
size waiver is needed.

The adjacent Sirene block at `0x057498-0x057EBD` is now reconstructed as the
same explicit 11-state shape (`0` through `$14` in even steps), its 28-part
pose pipeline, the battle distortion/display effect, and the type-$490
projectile update. Numeric state names are retained where control flow is
stronger evidence than an attack interpretation. The old `Enemy_Projectile`
state names were actually entries in Sirene's boss table; the old attack,
movement, bullet, and two projectile labels around `0x05783C-0x057C99` were
effect-buffer or pose operations rather than projectile handlers.

All 78 renamed definitions have address-backed static audit records. This
eliminated all 52 address-derived definitions from `sirene.s`, raised
provenance to 10,187 mappings, took the audit registry to 6,165 entries, and
lowered the project ceiling to 5,636. The cohesive boss module remains 792
lines and requires neither a split nor a size waiver.

The Artemis controller span `0x057EBE-0x0584DB` is now expressed as a
twelve-entry even-state machine (`0` through `$16`), with explicit state-entry
transitions, active-part positioning, packed part commands, and the shared
pose-rendering tail. Numeric state names are retained because the static flow
proves their dispatch identity but not an attack or visual identity. In
particular, the two inherited `Boss_Medusa_State*` labels are Artemis states
6 and 8, while the old bullet, laser, homing, wave, spread, projectile-spawn,
shooting-pattern, and attack-state labels mostly update the boss controller,
part links, motion, or pose and do not describe projectile implementations.

All 65 renamed definitions in `bosses/artemis_core.s` have exact-address
static audit records. This eliminates all 38 address-derived definitions from
the 522-line module, raises provenance to 10,225 mappings, takes the audit
registry to 6,230 entries, and lowers the project ceiling to 5,598. The core
controller remains a cohesive module within the ordinary 1,000-line limit;
the adjacent Artemis rendering and projectile families remain separate audit
work.

The former 512-line `bosses/artemis_rendering.s` container is now divided at
the actual entity boundary `0x0589E8`: a 312-line Artemis pose module owns the
pose interpreter, interpolation pipeline, eleven state-selected streams, and
380-byte frame block, while the 198-line `projectiles/artemis.s` owns creation
and update of entity type `$488`, its radial emission, collision/reflection
paths, conversion to a shared effect, and child-shot constructors. The latter
is two lines below the preferred 200-line range because the ROM presents a
clean subsystem boundary there; no unrelated bytes were retained merely to
meet a statistical target.

All 50 renamed definitions have 49 address-distinct audit records because
`Artemis_PoseFrameDataEnd` and `Boss_SpawnArtemisRadialEmitter` intentionally
share `0x0589E8`. This pass eliminates all 37 address-derived definitions from
the old mixed module plus one supporting shared-data address label, lowering
the project-wide ceiling from 5,598 to 5,560. Provenance rises to 10,263 mappings,
the registry reaches 6,279 entries, and the ROM layout now contains 341
natural modules. The old generic `AttackState`, `MovePattern`, `AnimationScript`,
and `UpdateSprites` claims are replaced by the observable pose or type-$488
entity operations they actually implement.

The Sylpheed reconstruction replaces the former 754-line `sylpheed_core.s`
container with a natural boundary at `0x059A00`. The 499-line core module owns
the fifteen-state dispatcher, entrance and attack cycle, jump/dive/charge
states, and target-directed velocity helpers. The 257-line
`sylpheed_pose.s` module owns the twelve-channel pose projection, script
interpreter, nine state-selected streams, and pose-frame data. Both modules
have zero live address-derived definitions; the ROM layout now contains 342
modules with no file above 1,000 lines and no generic container filename.

All 82 definitions in `0x0593D4-0x059D2B` now have exact-address audit
records. The pass removes 49 address-derived names, lowering the project-wide
ceiling from 5,560 to 5,511, raises provenance to 10,312 mappings, and takes
the name registry to 6,361 records. It also rejects inherited Sonnet ownership
claims: the six `Sirene_Alt*` and `Artemis_Alt*` labels are entries in the
Sylpheed state table, `DefeatInit` merely randomizes movement-target offsets,
the four `ShootPattern*` routines only perform tracking and approach motion,
and the old `AnimationScript` entry initializes state `$1A` rather than parsing
animation data. The sole standalone RTS at `0x059BAA` remains explicitly
`unknown` evidence because no static caller establishes a stronger role.

The pre-sound data audit identifies `0x05A43E` as the shared packed-BCD lookup,
not an anonymous word block. Its first 10,000 bytes are exactly 5,000
big-endian packed-BCD words for values 0000 through 4999; options, password,
HUD, player, results, and conversion code all index that base by even offsets.
The preservation asset deliberately remains one of the pinned 579 segments:
its final 36 bytes are recorded as opaque trailing data rather than split or
assigned a speculative role. `PreSoundPreservedDataEnd` therefore names the
asset boundary, not a claimed end of the logical BCD table.

This evidence also corrects the Sonnet name `Math_LookupCosineValue`: the
routine at `0x01B404` performs no trigonometry and is now
`Math_LookupPackedBCDWord`. Four exact-address audit records cover the helper,
the empty entity slot, the lookup base, and the preserved-data boundary. The
two address-derived data definitions are removed, lowering the ceiling from
5,511 to 5,509; provenance rises to 10,314 mappings and the registry to 6,365
records.

The first 68000 sound-driver reconstruction audits all 93 definitions in the
cohesive 698-line `sound/driver_core.s` span at `0x082324-0x0829A9`, plus the
shared PSG processor entry at `0x084A70`. The update loop now explicitly walks
the DAC, BGM FM/PSG, ordinary SFX FM/PSG, and special-SFX channel families.
Its event parsing, duration, FM pitch, vibrato, FM3 special-frequency, pan
animation, Z80 PCM-mailbox, and pause/resume paths have instruction-backed
names. The module fits the preferred 200-700-line range without an artificial
split or size waiver.

This pass rejects the inherited Sonnet claims that the DAC sequence processor
was a PSG player, the common PSG update was an FM-frequency setter, the pan
animation was tremolo, and the pause/resume state machine merely handled a Z80
bus request. All 94 address-distinct definitions have audit records; the
standalone stack-skip helper at `0x08277C` remains honestly `unknown` because
no static caller reaches it. The 55 live address-derived definitions are
eliminated, lowering the project ceiling from 5,509 to 5,454. Provenance rises
to 10,369 mappings and the audit registry reaches 6,459 records. The direct
canonical build remains byte-identical to SHA-1
`8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`.

The following sound pass replaces the misleading 443-line
`sound/fades_and_envelopes.s` container with the cohesive 444-line
`sound/command_dispatch_and_dac.s` module at `0x0829AA-0x082F6B`. Static flow
shows a four-slot pending-request selector, the complete sound-ID range
dispatcher, the 47-entry voice-DAC descriptor table, immediate Z80 command
submission, and primary/secondary voice-DAC mailbox selection. The module has
37 definitions and no live address-derived names; its filename and contents
now agree without an artificial split.

This pass corrects three more generated claims: `Sound_ProcessFade` selects a
queued request by priority and does not fade volume; `Sound_UpdateEnvelope`
dispatches sound IDs and does not interpret an envelope; and
`Sound_ReadEnvelopeData` reconstructs a PCM address and reads a four-byte DPCM
sample header. The adjacent `$81-$9F` entry is also corrected from the false
`Sound_ProcessDAC` to `Sound_LoadBGMRequest`, since it indexes
`Sound_BGMPointerTable` and initializes music channels. Thirty-nine exact-address
audit records cover the complete module and those two BGM entries. The pass
removes 33 address-derived definitions, lowering the project ceiling from
5,454 to 5,421; provenance rises from 10,369 to 10,402 mappings and the audit
registry reaches 6,498 records. The canonical ROM remains byte-identical.

The playback-and-loading sound pass audits the complete 542-line
`sound/playback_and_loading.s` span at `0x082F6C-0x0834D1`. All 75 definitions
now have exact-address records; 73 are new because the two BGM dispatcher
entries were already covered by the preceding pass. BGM channel construction,
ordinary and dedicated SFX loading, channel-override restoration, fade-out,
tempo, and all-channel shutdown remain together as one connected subsystem
inside the preferred 200-700-line range.

This pass corrects the generated claims that the two SFX stop routines were
generic FM/special-channel processors, that control request one wrote a chip
register, that the fade updater initialized channels, and that the global
shutdown routine updated an FM envelope. It also narrows the old
`Sound_MuteAllChannels` and `Sound_KeyOffAllChannels` claims to their observed
FM-only scopes. The preserved 24-byte `unused_10` block is six pointers to
sound channel records and has no static reference; it is therefore retained as
`Sound_UnreferencedSFXChannelPointers` without a speculative runtime purpose.

The 58 live address-derived definitions are eliminated, lowering the project
ceiling from 5,421 to 5,363. The added preserved-data marker raises provenance
from 10,402 to 10,461 mappings, and 73 new exact-address records take the audit
registry from 6,498 to 6,571 entries. The canonical Japanese ROM remains
byte-identical at SHA-1 `8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`.

The following structural pass replaces the mixed 337-line
`sound/hardware_interface.s` range with a natural ROM boundary at `0x0836A0`:
the 210-line hardware interface ends at `0x08369F`, and the 126-line
`sound/volume_transitions.s` module owns the BGM attenuation/restore and
voice-DAC handshake code through `0x08381F`. The 12-word FM pitch table at the
tail stays ROM-adjacent rather than creating an artificial six-line data
module. `src/main.s` and `rom_layout.json` now describe 343 modules in exact
ROM order.

This is deliberately a byte-preserving ownership change, not a semantic-name
endorsement: the address-derived ceiling remains 5,363 until both new module
ranges receive their instruction-backed naming audits. Layout verification and
the direct canonical build both pass, with Japanese ROM SHA-1
`8f6eb584ed9487b8504fbc21d86783f58e6c9cd6` unchanged.

The hardware-interface semantic pass audits all 27 definitions in the
210-line `sound/hardware_interface.s` module at `0x0834D2-0x08369F`. It now
exposes distinct YM2612 port-0 and port-1 write APIs, their Z80-bus and chip-
busy polling states, the Z80-program copy loop, optional key-on/key-off paths,
and the playback-state reset used by BGM loading. All callers across the sound
driver use those narrowed interfaces.

The pass rejects the Sonnet claims that channel override bit 2 was a pause
flag and that both YM2612 ports shared one unqualified register writer. It
also narrows `Sound_ResetDriver` because the routine clears only the 68000
playback region and preserves its mode byte; Z80 loading is a separate entry.
Its initial direction assigned to the conditional key-register helper is
superseded by the hardware-bit correction in the later sequence-command pass.
Thirteen live address-derived definitions are removed, lowering the ceiling
from 5,363 to 5,350. Provenance rises from 10,461 to 10,474 mappings, and 27
exact-address records take the audit registry from 6,571 to 6,598 entries.

The volume-transition pass audits all 18 definitions in the natural 126-line
`sound/volume_transitions.s` module at `0x0836A0-0x08381F`. Static state flow
separates command-driven attenuation/restoration from voice-DAC ducking: Z80
status `$A01FFC` bit 5 starts and ends the latter, and the retained FM/PSG
steps are applied to the nine active BGM channels in matched add/subtract
loops. The final twelve words are confirmed as the semitone-indexed FM
frequency table consumed by `Sound_CalculatePitch`.

The generated `Sound_ProcessVolumeFade` description is narrowed to
`Sound_UpdateBGMVolumeTransitions`, because no envelope is accessed and each
request applies a configured volume step rather than running an independent
time-based fade. The below-target module length is retained as an explicit
natural-boundary choice: merging it with Z80/YM2612 hardware arbitration would
hide the independent transition state machine, while splitting its tiny pitch
table would create an artificial wrapper. Seventeen address-derived
definitions are removed, lowering the ceiling from 5,350 to 5,333; provenance
rises from 10,474 to 10,491 mappings, and 18 audit records take the registry
from 6,598 to 6,616 entries.

The sequence-command pass audits all 78 definitions in the cohesive 583-line
`sound/sequence_commands.s` module at `0x083820-0x083CED`. Static parser and
consumer flow confirms both ordered dispatch tables, the complete `$E0-$FE`
command family, extended prefix `$FF`, FM instrument programming, carrier-only
volume adjustment, stopped-SFX BGM restoration, relative control flow, and
FM3/SSG-EG configuration. Forty live address-derived definitions are removed,
lowering the project ceiling from 5,333 to 5,293. The newly restored markers,
including the original `loc_83928` identity recovered from the initial
disassembly, raise provenance from 10,491 to 10,532 mappings; 78 exact-address
records take the audit registry from 6,616 to 6,694 entries.

This pass rejects several plausible but incorrect generated descriptions.
Command `$E0` replaces panning while preserving the stored AMS/FMS bits, and
`$EE` is a general YM2612 port-0 write rather than an FM1-only register API.
The fields previously described generically as modulation divide into custom
vibrato controls, pitch-envelope selection, and PSG volume-envelope selection.
Most importantly, YM2612 register `$28` proves that the two previously audited
key names were reversed: `$F0 | channel` enables all four FM operators, while
the bare channel selector disables them. The corrected
`Sound_SendFMKeyOn`/`Sound_SendFMKeyOff` names and their wrappers are now used
by note start, note timeout, pause, SFX stop, and sequence-stop callers.

The following global-control pass audits all 24 definitions in the former
144-line `sound/global_control.s` range at `0x083CEE-0x083E6F`. These are not a
separate subsystem: all four public entries are direct handlers of the
extended sequence-command table immediately before them in ROM. The range is
therefore merged into `sound/sequence_commands.s`, producing one cohesive
726-line, 102-definition module and reducing the declared ROM layout from 343
to 342 modules without changing a byte.

The pause command is now explicit about the ten BGM records it changes: one
PCM sequence record, six FM records, and three PSG records. Its resume half
also restores DAC panning through the Z80 mailbox and avoids replacing FM6
panning while DAC playback owns that channel. The generated
`Sound_InitializeFadeParams` and `Sound_CheckFadeComplete` claims are rejected;
extended commands `$FF $03` and `$FF $04` request one manual BGM attenuation
step and its later restoration through the transition state audited above.
Twenty address-derived definitions are removed, lowering the ceiling from
5,293 to 5,273. Provenance rises from 10,532 to 10,552 mappings, and 24
exact-address records take the audit registry from 6,694 to 6,718 entries.

The PSG playback-and-envelope pass replaces the artificial adjacent
`sound/channel_playback.s` and `sound/frequency_and_envelopes.s` files with the
cohesive 307-line `sound/psg_playback_and_envelopes.s` module covering
`0x084A70-0x084E77`. All 51 definitions now have exact-address audit records;
50 are new because `Sound_ProcessPSGChannel` was already audited with the
driver core. The shared layout consequently contains 341 modules.

Static consumers establish separate pitch and loudness data families. Channel
field `$0A` selects one of eight signed pitch-offset streams through
`Sound_PitchEnvelopePointerTable`, while field `$0B` selects one of ten PSG
attenuation streams through `Sound_PSGVolumeEnvelopePointerTable`. The latter
interpreter handles cursor commands `$80-$82` and termination command `$83`.
This directly rejects the generated `Sound_ProcessFMModulation` claim: the
routine neither selects an FM channel nor writes the YM2612.

The period table and mute paths are likewise narrowed to their observable PSG
roles. One mixed nine-longword driver table at `0x084CA4` has no static source
reference; its current name describes the pointers and scalar it contains,
without claiming a runtime consumer. Because the initial disassembly emitted
that block without a definition, its audit records `unlabeled_84CA4` as the
legacy identity and deliberately adds no false provenance marker. Fourteen
live address-derived definitions are eliminated, lowering the project ceiling
from 5,273 to 5,259. Thirty-four truthful imported-name markers raise
provenance from 10,552 to 10,586 mappings, and 50 new exact-address records
take the audit registry from 6,718 to 6,768 entries. The fresh assembler listing
contains zero errors and zero warnings.

The request-table pass merges the adjacent 50-line
`sound/music_and_priority_tables.s` and 160-line
`sound/sfx_pointer_tables.s` containers into the cohesive 213-line
`sound/request_and_track_tables.s` range at `0x084E78-0x085265`. Its five
definitions are all instruction-backed: BGM IDs `$81-$9F`, the 256-byte
request-priority map, ordinary SFX IDs `$A0-$F8`, special override IDs
`$F9-$FC`, and low-range SFX IDs `$40-$7F`.

The low and high ordinary-SFX paths prove why the two pointer blocks belong
together. High IDs subtract `$A0` from the shared base; low IDs add `$1D`, then
the common four-byte scale lands at the low-range table exactly `$174` bytes
after that base. Five inherited semantic names now have exact static audit
records and truthful `off_84E78`, `byte_84EF4`, `off_84FF2`, `off_85156`, and
`off_85166` provenance. The address-derived ceiling remains 5,259 because this
was a Sonnet-name audit rather than a raw-label burn-down; provenance rises
from 10,586 to 10,591 mappings, the audit registry rises from 6,768 to 6,773
entries, and the ROM layout decreases from 341 to 340 modules.

The sound-effect payload audit replaces the four hexadecimal storage buckets
`sfx_a0_cf.s`, `sfx_d0_df.s`, `sfx_e0_fc.s`, and `sfx_40_7f.s` with the
single ROM-ordered `sound/sfx_tracks.s` data-family module. All 157 track
headers are now named by their proven request IDs in the `Sound_SFX_XX`
namespace and have exact static audit/provenance records. No effect meaning is
guessed from the payload bytes. The four `_End` definitions delimit extracted
binary fragments and had no imported IDA symbols.

This pass reduces the layout from 340 to 337 modules, raises provenance from
10,591 to 10,748 mappings and the name-audit registry from 6,773 to 6,930
records. The address-derived ceiling remains 5,259 because these were already
request-ID names.

The remaining binary-backed sound-boundary audit verifies 35 names without
collapsing three genuinely distinct formats into one module. Twenty-five music
payloads are now neutral `Sound_BGM_XX` request identities; external rip titles
remain only in preservation filenames and the sound-driver reference table.
This rejects treating the known `$90`/`theend.bin` mismatch as source truth.
Nine `Sound_PCMBank` names are supported by the DAC descriptors' high-byte
base plus offset addressing, and `Sound_Z80DriverProgram` is supported by the
loader's exact `$C00`-byte copy into `Z80_RAM`.

All 35 imported starts have exact static audit and provenance records. The
associated `_End` labels are extraction boundaries rather than imported IDA
symbols. Provenance rises from 10,748 to 10,783 mappings and the name-audit
registry from 6,930 to 6,965 records. Module count and the 5,259
address-derived ceiling are unchanged.

The shared-combat sprite-mapping pass reconstructs the cohesive
`data/shared_combat_sprite_mappings.s` bank as 73 ROM-ordered frame records
and 34 relative-offset animation streams. `Anim_UpdateFrame` proves the
format by reading a frame-relative offset and its duration/control word;
`Sprite_PrepareOAM` then consumes the resolved frame. All 106 remaining
`word_E...` and `off_E...` definitions in the bank are replaced with typed,
stable indices, while the already semantic frame at `0x0E90C2` is audited
again. Its generated `SharedCombatSpriteFrameDataBase` name is rejected:
every animation offset is relative to the word containing it, so there is no
single shared base address.

The indices deliberately make no visual-content claim. Static consumers give
the following narrower evidence; entries described as internal have no live
reference outside this bank and remain visual-identity unknowns:

| Animation indices | Proven consumers |
|---|---|
| `00-06` | Shared particles, debris, impacts, player shots, and enemy-projectile configurations. |
| `07` | Wolf Garopa orb explosion. |
| `08` | Trailing explosion spawner. |
| `09-11` | Internal bank entries only. |
| `12` | Homing projectiles, seeking missiles, asteroids, and related impacts. |
| `13` | Weapon-selection display and fragment projectiles. |
| `14` | Player homing-weapon effect. |
| `15` | Internal bank entry only. |
| `16` | Destroyer Proto and shared directional-projectile configuration. |
| `17` | Internal bank entry only. |
| `18-20` | Viblack, Wolf Garopa, and Missiray defeat/debris selection. |
| `21` | Random debris effect. |
| `22` | Jetsripper and shared falling debris. |
| `23` | Internal bank entry only. |
| `24` | Homing-projectile impacts and Shellshogun debris. |
| `25` | Internal bank entry only. |
| `26` | Stage 25 destruction particle. |
| `27-28` | Large and small resource pickups, respectively. |
| `29` | Internal bank entry only. |
| `30` | Player damage-impact object. |
| `31` | Internal bank entry only. |
| `32` | Z-Leo laser and Stage 15 fragment impacts. |
| `33` | Jetsripper type-`$C4` projectile. |

This pass adds 106 truthful provenance mappings and 106 net audit records,
raising those totals from 10,783 to 10,889 and from 6,965 to 7,071. It removes
106 live address-derived definitions, lowering the enforced ceiling from
5,259 to 5,153 without changing module count or ROM layout.

The `0x0ECB1C-0x0ED171` mapping audit removes another inherited mixed-data
container. The two Bugmax frames previously stranded at the end of
`valkirie_sprite_mappings.s` now begin `bugmax_sprite_mappings.s`; the former
`bugmax_and_medusa_mappings.s` is separated at exact consumer boundaries into
Bugmax, shared Seven Forces/Valkirie, and Destroyer Proto modules. The four
Shield Viper frames formerly stranded at its end are joined to the renamed
`shield_viper_and_missiray_mappings.s`. This replaces three misleading layout
entries with five natural ROM-ordered entries, taking the project from 337 to
339 modules. The short Destroyer Proto data module is retained as a genuine
entity boundary rather than padded with an unrelated boss merely to reach a
line-count target.

All 118 imported definitions in the affected range now state their proven
type and owner. The 40 Seven Forces rotation frames are selected by the nine
forward/reversed eight-direction tables in `seven_forces_metasprites.s`;
Bugmax, Destroyer Proto, and Shield Viper frames are tied to their constructor
or descriptor consumers. Valkirie, Bugmax, and Missiray relative-offset
animations have explicit role names. Numeric frame suffixes preserve ROM
order only: they do not claim an unverified pose, body part, or appearance.
The unlabeled Bugmax mapping rows at `0x0ECBF0-0x0ECC85` remain a visual-role
unknown rather than receiving a fabricated Medusa identity from the former
filename.

This pass adds 118 truthful provenance mappings and audit records, raising the
totals from 10,889 to 11,007 and from 7,071 to 7,189. It removes 118 live
address-derived definitions, lowering the enforced ceiling from 5,153 to
5,035. Module ranges, symbols, and byte identity are checked against the new
five-entry layout.

The palette-transition control-flow audit splits the former 764-line
`rendering/palette_transitions.s` at the exact `0x003C08` entry boundary. The
296-line transition/channel-adjust module now ends at `0x003C07`; the
470-line `rendering/color_fades.s` owns the list-driven and target-color fades
through `0x004093`. Both are cohesive and remain inside the preferred module
size range, taking the layout from 339 to 340 modules.

All 87 imported branch/data labels now describe their verified loop, channel,
clamp, merge, state, or table role. CRAM masks establish the channel naming:
`$00E` is red, `$0E0` is green, and `$E00` is blue. Six generated semantic
names are corrected as part of the same audit. In particular,
`Gfx_AdjustPaletteBits` did not manipulate tile palette-selection bits and is
now `Gfx_AdjustSelectedColorChannels`; the former
`Gfx_ClampGreenChannel` is the common blue-channel merge/store path. Two
Sharpsteel-only names are neutralized because Bugmax, Viblack, and ship code
also use the counted entry-list updater. The former generic loader and init
names at `0x003C08` and `0x003C20` now state their observable fall-through
contracts: reset default fade state and process the default fade table.

The 87 newly imported-name mappings raise provenance from 11,007 to 11,094.
The 87 raw labels plus six corrected semantic entries add 93 audit records,
raising the registry from 7,189 to 7,282. Address-derived definitions fall
from 5,035 to 4,948; no inferred color or control-flow name depends on visual
guesswork.

Four especially broad data labels are explicitly registered:

| Symbol | ROM address | Evidence | Current statement |
|---|---:|---|---|
| `UnidentifiedSegaTilemap` | `0x0E8020` | hypothesis | 48 sequential tile words adjacent to the SEGA art; no live pointer has been found. |
| `MessageDisplay_FontPatternFillSource` | `0x180000` | static | The message engine directly uses the 48 repeated `$C7F8` words as the source of fixed 32-word and 40-word pattern-fill DMAs. |
| `Credits_UnidentifiedTrailingData` | `0x0225CC` | unknown | Opaque block ending at the demo subsystem boundary; no live reference has been found, so neither purpose nor unused status is asserted. |
| `Stage12_ObjectSpawnList` | `0x01AE96` | static | 314 bytes form 26 twelve-byte records plus a `$7FFF` terminator; `Sys_ProcessSpawnList` consumes this exact format through the Stage 12 configuration pointer. |

Semantic names with `; was:` history are a second review queue. Their default
level is `hypothesis`, not `confirmed`; see `docs/provenance.md`.

The `0x00B900-0x011721` palette and asset-loading audit replaces the former
address vocabulary with names derived from the actual command consumers. A
palette command begins with destination and inclusive word-count bytes followed
by CRAM words. `Gfx_LoadPaletteCommand` copies those words to the selected
palette buffer and its shadow. `Gfx_LoadMultiplePalettes` first clears eight
palette blocks, loads the common command, then follows signed offsets relative
to `Gfx_LoadPalettePreservingSharedColor`. Boss asset-set records contain an
entity-type word and optional graphics-list and palette-command pointers;
`Boss_LoadAssetSet` initializes the object and consumes both lists.

This evidence corrects twelve generated semantic claims. Notably, the former
`Gfx_UpdateBossPalette` also loads graphics and initializes the selected entity,
so it is now `Boss_LoadAssetSet`. The former `VDP_SetupPaletteTransfer` points
at font tiles and VRAM `$6000`, so it is now `Gfx_QueueSmallFontDMA`. The former
`Stage_LoadShipGraphics` adjusts selected tile blocks rather than loading ship
art. The exact corrections and evidence levels are recorded in
`config/name_audit.json`.

External research calls some resource sets Love Penguin, Lambda Bunny, Dragon,
Praying Mantis, or Sigma Fox. Static ROM evidence establishes only entity types
`$1C0`, `$3EC`, `$3F0`, `$3F4`, and `$3FC` and their asset records. The source
therefore uses `EntityType*` names and keeps those identities in
`docs/unused_content.md` as unproven attributions. The `$3EC`, `$3F0`, and
`$3F4` loaders are entries in the late Stage 18 state table, so the earlier
claim that they were unreferenced unused loaders was also removed.

The mixed `rendering/asset_transfers.s` container is split at the exact
`0x011316` boundary into the 172-line `rendering/vdp_asset_transfers.s`
(`0x011170-0x011315`) and 440-line `rendering/boss_asset_sets.s`
(`0x011316-0x011721`). This takes the layout from 340 to 341 modules. The pass
also renames `data/xi_tiger_and_unused_boss_art.s` to the evidence-neutral
`data/xi_tiger_and_boss_art.s`; neither its filename nor its comments now
assert that the externally attributed entity art is unused. The pass
adds 164 provenance mappings and 181 audit records, raising the totals from
11,094 to 11,258 and from 7,282 to 7,463. It removes 166 address-derived
definitions, lowering the enforced ceiling from 4,948 to 4,782. The canonical
Japanese ROM remains byte-identical after the split and renames.

The adjacent `0x0EB5E6-0x0EBBB7` sprite-mapping audit removes two more
mixed-owner data containers. `caterpillar_jetsripper_and_antroid_mappings.s`
and `terobuster_shellshogun_and_xi_tiger_mappings.s` interleaved records for
eight independently consumed entities and omitted several of those owners from
their filenames. They are now exact ROM-ordered modules for Caterpillar,
Jetsripper, Antroid, Terobuster, Shellshogun, Shiper's tentacle, Xi-Tiger, and
Madam Barbar. The split replaces two modules with eight and takes the layout
from 341 to 347 modules.

These mapping modules range from 8 to 91 source lines, below the preferred
general-purpose size band. That is an intentional data-boundary exception, not
arbitrary fragmentation: every file contains the complete contiguous mapping
run for one entity, and combining them solely to increase line count would
recreate the misleading mixed containers this reconstruction is removing.

All 125 formerly address-derived definitions in the two original containers
are selected by named pointer tables or direct mapping assignments. Names use
the proven boss and sprite-mapping format while numeric suffixes retain ROM
order without claiming an unverified visual pose. The seven existing semantic
Xi-Tiger body and claw names were already backed by their grounded, airborne,
and symmetric claw-angle consumers and remain unchanged. This pass adds 125
provenance mappings and 125 audit records, raising the totals from 11,258 to
11,383 and from 7,463 to 7,588. Address-derived definitions fall from 4,782 to
4,657, and the rebuilt canonical Japanese ROM remains byte-identical.

The `0x0EA05A-0x0EA86B` animation-data audit separates the former
`projectile_and_bird_animation_mappings.s` at the exact `0x0EA6B4` owner
boundary. The 387-line `enemy_projectile_animation_mappings.s` contains the
ten streams selected by `Enemy_ProjectileAnimationPointers` and their shared
sprite mappings. The 133-line `bird_animation_mappings.s` contains the four
streams selected by `Enemy_BirdAnimationMappings` and their mappings. This
natural split takes the layout from 347 to 348 modules.

All 58 definitions now state the consumer-proven family and format. Animation
suffixes match the selector-table index; sprite-mapping suffixes preserve ROM
order without inventing pose names. The relative mapping-and-delay entries and
their restart or termination words establish the stream format independently
of visual inspection. This pass adds 58 provenance mappings and 58 audit
records, raising the totals from 11,383 to 11,441 and from 7,588 to 7,646.
Address-derived definitions fall from 4,657 to 4,599. The preservation build
remains the unchanged canonical Japanese ROM. The complete project suite then
passes all 37 tests against this split and rename set.

The game-side sound-request and options-screen audit corrects a cluster of
misleading generated names. `Sound_QueueRequest` at `0x0034EE` does not read
buttons: it deduplicates a request ID and inserts it into the first free byte
of the four-slot `$FFF80A-$FFF80D` queue consumed by the sound driver.
`Sound_QueueBGMRequest` at `0x0034DA` does not wait for VBlank: it gates the
request on the BGM-disable option. The related stage, frontend, and Xi-Tiger
credits helpers now name their observed BGM selection, fade request, queueing,
and transition roles. Twenty-two corrected entry/branch/table names have exact
static evidence in `config/name_audit.json`.

The normal options screen is now described by its six proven rows: difficulty,
BGM enable, SFX enable, BGM test, SFX test, and voice test. Its 704-byte BGM
test include is renamed `options_bgm_test_entries.bin`; each selected 32-byte
record provides one request ID and fifteen displayed tile words. The SFX and
voice handlers are distinguished by their request tables and bounds, rather
than the former generated character-selection names. The review corrects 12
existing semantic names, replaces 76 address-derived option definitions, and
promotes `DifficultyMode`, `MessageMode`, and `SoundDisableFlags` in the RAM
map.

Two password cursor mappings at `0x00A394-0x00A39F` were not options data. They
now form the exact ROM-ordered `ui/password_cursor_mappings.s` boundary between
the 890-line options module and the password code. The intentionally short
three-line data module preserves a real consumer/ownership boundary; merging
it back only to meet an average line target would misstate that ownership.
This takes the layout from 348 to 349 modules.

One secondary-options behavior remains unresolved. Its handler-index words are
`6, 8, $A, $C, $E`, while the local navigation clamp reaches only the first
four. Values `6`, `8`, and `$A` dispatch the three sound-test handlers. Value
`$C` makes the relative dispatch read opcode word `$43FA` immediately after
the six-entry primary handler table; adding it to base `0x0098E0` lands exactly
at `Stage13_BeginSnakeSequence` (`0x00DCDA`). This is verified as a
code/data overlay, but its purpose and whether a shipped path intentionally
selects it remain unknown. The `$E` entry is unreachable through this local
navigation clamp.

This package adds 80 provenance mappings from address/RAM labels plus one
restored SFX-table marker, raising provenance from 11,441 to 11,522. It adds
109 evidence records, raising the name-audit registry from 7,646 to 7,755, and
lowers the enforced address-derived ceiling from 4,599 to 4,519. The direct
pinned-toolchain preservation build remains byte-identical to the canonical
Japanese ROM (`8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`), and all
37 project tests pass against the resulting source and audit data.

The player sprite-mapping audit resolves all 70 imported `word_E...`
definitions in the complete `0x0E8680-0x0E9079` bank. This remains one
cohesive 959-line `data/player_sprite_mappings.s` module: it is a single
consumer family, fits the agreed 1,000-line ceiling, and has no natural owner
boundary that would justify a cosmetic split.

The names follow three kinds of static evidence. Directional, state-animation,
weapon-animation, defeat, terrain-layout, and death-particle records use their
exact selector-table indices. Directly loaded records use the narrow shared
role proven by their callers, such as the common primary stream, knockback
primary stream, teleport-dash trail, or special-attack secondary variants.
`Player_BuildSpritePieces` proves that these are primary/secondary sprite-piece
streams; direct assignments to object mapping pointers prove the remaining
records. Numeric suffixes express selector order only and do not claim an
unverified visual pose.

This pass adds 70 provenance mappings and 70 static audit records, raising the
totals from 11,522 to 11,592 and from 7,755 to 7,825. Address-derived
definitions fall from 4,519 to 4,449. Module count remains 349. The canonical
Japanese ROM remains byte-identical and all 37 project tests pass.

The results-scrolling pass reconstructs the complete 627-line
`ui/results_scrolling.s` state machine. All 61 local address-derived targets
now describe their observed jobs in data preparation, initial and scrolling
row rendering, viewport completion, horizontal column snapping, vertical
navigation, and packed-BCD formatting. Six adjacent text definitions in
`ui/results_data.s` (five data objects plus the include end label) are also
resolved from their direct consumers and custom-font bytes. The 682-byte
private include is consequently renamed from
`word_20666.bin` to `results_stage_detail_text.bin`; both render paths prove
that it is a 31-record, 22-byte-per-record stage-detail text table.

This audit also corrects seven generated semantic claims. The routine at
`0x01FFF0` does not test a score: it submits the one-shot completion-music
request `$85` once the vertical scroll reaches its trigger point. The final
state at `0x020016` updates interactive browsing rather than waiting for an
unseen transition, and its callee manages both axes of results navigation.
The clear loop at `0x020236` specifically resets the 25-word second-interval
array at `$FFAA80`. Finally, custom-font codes `$25`, `$2A`, and `$22` cannot
be named from their ASCII code points: static use proves only a packed-BCD
field separator and two missing-value glyphs, so the former percent-sign,
asterisk, and quote claims have been removed.

The package adds 67 provenance mappings and 73 static audit records, raising
the totals from 11,592 to 11,659 and from 7,825 to 7,898. It lowers the
enforced address-derived ceiling from 4,449 to 4,382. Module count remains
349; `ui/results_scrolling.s` now contains no live address-derived names. A
fresh `make split` reproduces all 579 canonical segments, the direct pinned
build reproduces the Japanese ROM byte for byte, and all 37 project tests pass.

The following results-data pass resolves all 37 remaining address-derived
targets in the 413-line `ui/results_data.s` module. Its names now expose the
25-entry summary accumulation, the three appended total rows, packed-BCD
conversion, entering-row redraw during vertical scrolling, alternating
selected-row highlight, and the otherwise unreferenced direct-scroll helper.
The latter remains explicitly documented as having no known static caller;
the rename describes its instructions without inventing a shipped route.

Cross-module evidence disproves another Sonnet-generated “weapon selection”
cluster. The table at `0x01CE4C` is a 25-entry packed-BCD stage time-limit
table, and `Stage_LoadTimeLimit` copies its selected word to the live timer at
`$FFFFA270`. Timer code decrements that word once per second and HUD code
renders its nibbles. The former weapon-selection routines actually save that
timer to the phase-split and stage-completion arrays at `$FFFFAA00` and
`$FFFFAA80`. The alleged score incrementer updates a separate per-stage
visit-count array at `$FFFFAB00`; its deliberately neutral name avoids
claiming the exact counting convention implied by the displayed
`TOTAL CONTINUE` label.

This package corrects 17 existing semantic names, promotes four RAM fields,
and replaces 37 local address-derived labels. It adds 41 provenance mappings
and 58 static audit records, raising the totals from 11,659 to 11,700 and from
7,898 to 7,956. The enforced address-derived ceiling falls from 4,382 to
4,341. Module count remains 349, and `ui/results_data.s` now contains no live
address-derived names. A fresh pinned-toolchain build remains byte-identical
to the canonical Japanese ROM, all 37 project tests pass, and the asset,
source-inventory, and ROM-layout gates remain green.

The stage-message audit rejects the generated interpretation of
`ui/results_sequence.s` as a generic results module. The exact state table
shows three distinct but cooperating flows in its 754-line ROM-ordered range:
the `STAGE` number and flashing `EMERGENCY` entry banners (states `$50-$5E`),
the post-boss remaining-time bonus (states `$2E-$40`), and the shared radial
text/boss-message script support. The cohesive module is therefore renamed
`ui/stage_message_sequences.s`; it remains within the agreed 300--1,000-line
range and is not cosmetically fragmented.

Cross-checking the glyph lists and consumers corrects the false names
`Player_Initialize`, score display, grade display, victory message, and weapon
acquired. The stage-number path renders the fixed `STAGE` label followed by
two packed-BCD digits. The alleged grade glyph set is exactly the unique
letters needed for `EMERGENCY`. The alleged weapon-acquired path records
`StageTimeRemaining`, applies its four packed-BCD digits to the sprite tiles,
and finally calls `Score_AddPackedBCD`, establishing it as the time-bonus flow.
The shared battle-entry glyph list supports the `READY/FIGHT` banner.

The nine encoded Japanese message scripts are named only by statically proven
selector groups; their byte payloads are not treated as ASCII and no dialogue
translation is invented. Selector two remains explicitly an unused static
slot because no caller supplying that value is known. The final short script
keeps a dual `ShipAndValkirieMessageScript` name because both the ship-name
pointer table and Valkirie's selector-eight path demonstrably reference it.

This package corrects 42 existing semantic ROM names, replaces 53 live
address-derived ROM definitions, and promotes `MessageSequenceState` and
`MessageSequenceFlags` in the RAM map. It adds 55 provenance mappings and 92
net audit records, raising the totals from 11,700 to 11,755 and from 7,956 to
8,048. The enforced address-derived ceiling falls from 4,341 to 4,286. Module
count remains 349, and `ui/stage_message_sequences.s` contains no live
address-derived definitions.

The adjacent engine audit renames the misleading 497-line
`ui/victory_sequence.s` to `ui/message_sequence_engine.s`. Its table is the
single dispatcher for encoded boss dialogue, the `READY/FIGHT` battle-entry
banner, post-boss time bonus, radial ship-name text, and stage-entry banners;
it is neither player behavior nor a victory-only subsystem. The table and all
of its state transitions now use the `MessageSequence_*`, `MessageScript_*`,
and `BattleBanner_*` namespaces.

Static ROM/VRAM operands also reject the former HScroll and compressed-tilemap
claims. The fixed DMA helpers copy message-display pattern data from
`MessageDisplay_FontPatternFillSource` and three six-word base-pattern blocks
to their encoded VDP destinations. Script command
`$FFFE` masks an embedded ROM source address and queues a direct DMA; it does
not invoke a decompressor. The glyph renderer treats each source nibble as a
transparency decision, constructs a 64-byte tile, queues its transfer, and
writes the corresponding tilemap words. Its eight local nibble branches are
named by that proven operation rather than by guessed pixels or characters.

This engine package corrects 24 existing semantic names and replaces all 28
live address-derived definitions in the module. It adds 28 provenance mappings
and 52 static audit records, raising the totals from 11,755 to 11,783 and from
8,048 to 8,100. The enforced address-derived ceiling falls from 4,286 to
4,258. Module count remains 349, and `ui/message_sequence_engine.s` contains
no live address-derived definitions.

The weapon-state audit rejects the generated interpretation of
`ui/weapon_display.s` as a display-only module. The ROM-ordered 544-line range
contains the shared weapon-state dispatcher, state-specific damage, motion,
targeting, gauge, and icon setup, plus the circular four-slot selection
overlay. It is therefore renamed `ui/weapon_state_and_selection.s`; the file
is cohesive and lies inside the agreed 300--1,000-line range.

The handler table proves only the even state values `$00` through `$14`, so
the state-specific routines deliberately retain numeric names instead of
inventing weapon identities. Direct consumers disprove the former health-bar,
enemy-velocity, and generic graphics claims: state two derives projectile
damage from the active slot's remaining ammo, state six builds sine/cosine
motion and selects an ammo-indexed data table, state eight selects an eligible
target, state ten animates a gauge palette, and state twelve queues icon DMA.
States `$12` and `$14` initialize and update the four-slot selection overlay.

This package corrects 26 generated semantic names, replaces 47 live
address-derived ROM definitions, and promotes eight weapon fields in the RAM
map. It adds 55 provenance mappings and 81 static audit records, raising the
totals from 11,783 to 11,838 and from 8,100 to 8,181. The enforced
address-derived ceiling falls from 4,258 to 4,203. Module count remains 349,
and `ui/weapon_state_and_selection.s` contains no live address-derived
definitions.

The weapon-setup audit replaces the misleading `ui/title_and_options.s` and
`cutscenes/planet_3d.s` containers with the ROM-ordered 568-line
`ui/weapon_setup_screen.s` and 265-line
`ui/weapon_setup_background_and_text.s`. The former contains the setup state
handlers, four-slot loadout controller, controller-layout selection, screen
renderers, and palette cycles. The latter contains the animated dithered
background generator and every encoded string consumed by those handlers.
Both modules are cohesive, fall within the release size policy, and now have
zero live address-derived definitions.

The embedded text directly disproves several generated interpretations. The
screen heading is `SETUP YOUR WEAPONS`; its six force names are `BUSTER`,
`RANGER`, `FLAME`, `HOMING`, `SWORD`, and `LANCER`. The alleged difficulty
selector is a 26-entry controller-layout selector whose strings are exactly
`TYPE 1` through `TYPE 26`. The remaining pages select `MOVING` or `FIX`
shooting mode, render `EXIT`, and show the `CONTROL TEST` assignments. Static
call flow also does not establish a planet: the former 3D-planet routine runs
on every weapon-setup update, builds line-offset and dither tables, writes a
tile buffer, and queues the result to the VDP, so its name is kept at the
provable background-effect level.

This package corrects 35 generated semantic names, replaces 106 live
address-derived ROM definitions, and promotes `ShootingMode` and
`ControlLayoutFlags` in the RAM map. It adds 108 provenance mappings and 142
static audit records, raising the totals from 11,838 to 11,946 and from 8,181
to 8,323. The enforced address-derived ceiling falls from 4,203 to 4,095;
module count remains 349.

The sprite-renderer audit moves the misleading `gameplay/object_update.s` and
the overly broad `rendering/sprites.s` into the ROM-ordered 204-line
`rendering/sprite_object_pipeline.s` and 496-line
`rendering/sprite_mapping_and_oam.s`. The first module traverses display
objects, resolves timed and offset-based mapping sequences, caches dynamic-art
sources, and queues changed sources for DMA. The second owns the 64 priority
buckets, Genesis OAM entry generation, mapping expansion, clipping,
reflection, and terminated static-entry appenders. Both modules are cohesive,
within the project size target, and contain no live address-derived
definitions.

The instruction-level behavior corrects two especially unsafe generated
interpretations. Tile-attribute bit 11 selects horizontal reflection and the
following helper negates each mapping entry's X offset using its encoded
width; it is not a large-sprite path. The six-byte frame-table variant retains
bit 15 of the object's tile attributes and then XOR-merges the entry word;
that bit is the Genesis sprite priority bit, not horizontal flip. Names that
distinguish dynamic mappings with retained entry attributes are limited to
what the masks and DMA-source cache prove.

This package corrects 44 generated semantic names, replaces 54 live
address-derived ROM definitions, and promotes six OAM-pipeline fields in the
RAM map. It adds 60 provenance mappings and 104 static audit records, raising
the totals from 11,946 to 12,006 and from 8,323 to 8,427. The enforced
address-derived ceiling falls from 4,095 to 4,035; module count remains 349.

The palette/VDP-control audit reconstructs the complete 415-line ROM block at
`0x000EF4-0x001354` without slicing it into undersized files. Its dominant
routine is the 64-color full-screen fade engine; the contiguous tail contains
the two scroll-table DMA builders and three frame-timing diagnostic helpers.
This keeps the module inside the 300--1,000-line target while making every
branch role explicit and retaining the ROM order.

The audit removes several plausible but mechanically false generated claims.
The old Plane B helper targets the horizontal-scroll table in VRAM `$F000`,
while the old Plane A helper targets VSRAM; their transfer lengths follow the
horizontal per-line and vertical per-column bits in VDP register 11. The old
background-color clearer actually cycles VDP register 7 color indices during
a debug timing pass, and the alleged display-layer helpers blank or restore
the global display and backdrop state. Two initialization loops previously
described as screen and enemy buffers are the 2,048-byte horizontal-scroll
and 160-byte vertical-scroll workspaces. A menu-buffer claim was also removed:
that loop clears the adjacent active and shadow palette buffers.

This package audits or corrects 16 generated semantic names, replaces all 48
live address-derived ROM definitions in `rendering/palette_fades.s`, and
promotes 12 palette, scroll, VDP-shadow, and timing-debug RAM fields. It adds
60 provenance mappings and 76 static audit records, raising the totals from
12,006 to 12,066 and from 8,427 to 8,503. The enforced address-derived ceiling
falls from 4,035 to 3,975; module count remains 349.

The VBlank-transfer audit reconstructs the complete 167-line
`rendering/vblank_dma.s` service as one cohesive unit. It uploads the
640-byte hardware sprite table, either fills CRAM or uploads the active
palette, drains the descending 16-byte VDP-command queue, uploads horizontal
and vertical scroll tables, emits four optional command blocks, restores the
VDP DMA state, and clears the transfer-pending flag. The module is shorter
than the preferred 300-line average, but joining it to an adjacent subsystem
would create artificial ownership; the size rule remains a project average
and a 1,000-line ceiling rather than a per-file minimum.

This audit also removes two unsafe generated claims. `Gfx_UpdateVDPDisplay`
did not control the display-enable bit: it writes VDP register 0 and
conditionally clears bit 4, the horizontal-interrupt enable bit. The alleged
graphics-chain buffer at `$FFFFE000` is the hardware sprite table: OAM
renderers build eight-byte entries there and VBlank transfers 80 entries to
VRAM `$F400`. The VDP register words are now named from their exact positions
in the contiguous 24-register shadow table, not from inferred scene behavior.

This package corrects or refines five generated semantic names, replaces all
14 live address-derived ROM definitions in `rendering/vblank_dma.s`, and
promotes 18 sprite, command-queue, transfer-state, and VDP-shadow RAM fields.
It adds 32 provenance mappings and 37 static audit records, raising the totals
from 12,066 to 12,098 and from 8,503 to 8,540. The enforced address-derived
ceiling falls from 3,975 to 3,943; module count remains 349.

The raster-effect audit reconstructs the complete 460-line
`rendering/vblank_effects.s` module and its 23-entry dispatcher. These are
two-stage effects: the selected VBlank handler copies a ROM code block to
`HBlankRAMCode` at `$FFFFEE00`, selects a scanline-data buffer and VDP
register state, then the level-4 interrupt executes that installed code.
The seven operation lists now identify the installed handler and its explicit
copy-length field instead of retaining anonymous `stru_`/`word_` pairs.

Port commands disprove four generated interpretations. The alleged null
handler disables horizontal interrupts and writes an `RTE` opcode over the
RAM handler entry. The alleged CRAM initializer installs a VSRAM-address-two
writer. The alleged sprite-data path is a one-shot vertical-scroll split, and
its HBlank handler neither touches sprite RAM nor horizontal scroll. The
former generic screen-mode handler installs a buffered writer specifically
for CRAM color index five. Story and Stage 10 update routines are also
identified as HBlank code rather than ordinary VBlank rendering.

This package corrects or refines 19 generated semantic names, replaces all 27
live address-derived ROM definitions in `rendering/vblank_effects.s`, and
promotes three raster-control RAM fields. It adds 30 provenance mappings and
49 static audit records, raising the totals from 12,098 to 12,128 and from
8,540 to 8,589. The enforced address-derived ceiling falls from 3,943 to
3,913; module count remains 349, and the audited module contains no live
address-derived definitions.

The HBlank raster audit reconstructs the adjacent 375-line
`rendering/hblank_effects.s` module without splitting one ordered group of
effect installers and their copied handlers. The Epsilon 1 path computes a
VScroll value and interrupt line, then installs a handler that writes VSRAM
slot two before changing scroll mode and the plane-A table base. The generic
buffered-control path streams VDP control words without claiming an unproven
scene owner. Destroyer Proto reuses the common VScroll-zero handler, Z-Leo
consumes a buffered sequence of control and VScroll commands, and the Seven
Forces intro installs delayed window-position writes. The module remains
within the 300--1,000-line target and now has no live address-derived
definitions.

Port commands and caller context disprove three generated descriptions. The
Destroyer Proto initializer does not update sprites; it installs a VScroll
writer and selects its buffer. Z-Leo's handler is not limited to parallax
scroll because its stream also supplies direct VDP-control commands. The
former scroll-and-sprite writer never touches sprite RAM: it writes one word
to the horizontal-scroll table at VRAM `$F000` and one word to VSRAM slot
zero. The generic stage-effect name is narrowed to Seven Forces because its
dispatcher slot is selected by `SevenForces_SetupIntroDma`, and its installed
handler writes VDP window registers 17 and 18.

This package corrects or refines eight generated semantic names and replaces
all 14 live address-derived ROM definitions in
`rendering/hblank_effects.s`. It adds 14 provenance mappings and 21 rename
audit records plus three confirmations of retained semantic names, raising
the totals from 12,128 to 12,142 and from 8,589 to 8,613. The enforced
address-derived ceiling falls from 3,913 to 3,899; module count remains 349.

The DMA-queue audit reconstructs the 337-line
`rendering/dma_queue.s` block as two pairs of byte-stream encoders, decimal
and hexadecimal digit formatters, a low-level DMA-command encoder, and the
adjacent optional palette-block loader. Both stream formats expand bytes to
words in `VDPStagingDataCursor`, use `$FE` between records and `$FF` at the
end, and prepend 16-byte commands below `VDPCommandQueueHead`; the first
format additionally skips a two-byte header before each VDP destination
command. Separate entry points choose copied bytes or zero-filled words.

This audit fixes a data/code boundary that semantic renaming alone could not
repair. The alleged `Gfx_QueueBCDDisplay` function at `$001EC0` was actually
the ten-byte table `1, 10, 100, 1000, 10000`, consumed by the preceding
decimal formatter. Re-expressing it as `DecimalDigitDivisors` reveals the
previously unlabeled hexadecimal formatter at `$001ECA`; its own table holds
powers of sixteen. The canonical ROM remains byte-identical after replacing
the accidental instruction rendering with explicit `dc.w` data. The palette
tail is retained here because splitting 39 contiguous helper lines would
create an artificial undersized module while the combined block remains
inside the project target.

This package corrects or refines eight generated semantic names, replaces all
24 live address-derived ROM definitions in `rendering/dma_queue.s`, and adds
two missing code-entry labels. It adds 24 provenance mappings and 34 static
audit records, raising the totals from 12,142 to 12,166 and from 8,613 to
8,647. The enforced address-derived ceiling falls from 3,899 to 3,875; module
count remains 349.

The tile-codec audit reconstructs the complete 351-line
`rendering/tile_processing.s` module. One compressed tile expands into 64
word-sized palette indices in the first 128 bytes of
`GraphicsStagingBuffer`; the packing paths then combine their low nibbles
into one 32-byte Mega Drive 4bpp tile for RAM or direct VDP output. The
decoder now exposes its five-bit tokens, optional tagged color-marker offsets,
prefix/payload run-length code, word-boundary reloads, and exact 64-pixel
termination instead of a flat sequence of `loc_` labels.

The audit also separates three scopes that the generated names had conflated.
`TileCodec_ClearDecodeBuffer` clears only the 128-byte per-tile workspace,
not a DMA queue. The startup helper clears the entire 1 KiB graphics staging
region—not the documented 256 bytes—and that region is shared by tile and
LZSS loaders. Finally, the former `Gfx_ExecuteDMATransfer` does not touch VDP
hardware: it queues a 16-byte command, advances its pointers, and sets
`VDPTransferPending`; VBlank performs the actual transfer later. The
overloaded `$FFFFF730` state remains raw because the tile codec treats it as
two bitstream words while other loader modes store an end pointer there.

This package corrects or refines eight generated semantic names, replaces all
27 live address-derived ROM definitions in `rendering/tile_processing.s`,
and promotes three graphics-staging RAM addresses. It adds 30 provenance
mappings and 38 static audit records, raising the totals from 12,166 to
12,196 and from 8,647 to 8,685. The enforced address-derived ceiling falls
from 3,875 to 3,845; module count remains 349.

The numeric-primitives audit corrects the ownership of the 0x003954--0x0039A9
block. It is now `math/bcd_and_random.s`, not a UI-only score module: the first
routine adds packed-BCD rewards from collision, pickup, and results flows,
while `RandomNumber` advances a shared PRNG state consumed throughout gameplay,
effects, projectiles, and bosses. Keeping this compact ROM-contiguous block is
an intentional cohesion exception; merging it into the following palette code
merely to increase its line count would assign false ownership.

The former `UI_AddScoreBCD` name is narrowed to `Score_AddPackedBCD` because
the routine performs no rendering. Four `ABCD` instructions add the staged
eight-digit operand to `ScoreValueBCD`, and carry saturates the result at
`99999999`. The adjacent one-instruction entry has no static references and is
therefore named only `Numeric_NoOp`, without guessing a caller or purpose.
The PRNG keeps its established `RandomNumber` entry name; its zero-state seed,
multiply-and-fold step, global state, and deterministic demo seed are now
documented explicitly.

This package replaces three live address-derived ROM definitions and promotes
four RAM fields: the BCD prefix byte, BCD addend, score, and PRNG state. It adds
seven provenance mappings and eight static audit records, raising the totals
from 12,196 to 12,203 and from 8,685 to 8,693. The enforced address-derived
ceiling falls from 3,845 to 3,838; module count remains 349.

The palette-effect audit reconstructs the complete 272-line
`rendering/palette_effects.s` module as two per-frame dispatchers and their
stage/boss color handlers. The primary selector indexes ten slots for shared
animation, the Stage 2 blink, lightning, Epsilon-1, midgame, Shield Viper,
three-highlight, and Wolf Garopa effects. The secondary selector indexes a
paired-list RGB adjustment and two midgame fade variants. Every dispatched
target writes active or shadow palette RAM; none manipulates camera scroll or
loads graphics.

Static data flow therefore rejects several generated semantic claims. The
former `Stage_SetScrollOffset` only alternates one palette color, and the
former `Scroll_AnimateOffset` implements the timed lightning flash. The
former Shield Viper and Wolf Garopa `LoadTiles` entries never access the VDP
or tile data; they animate fixed palette entries. The broad Sega-branded
handler is narrowed to the three highlight colors it actually toggles. The
two consecutive counted lists assigned by the Stage 8/9 lightning flows also
establish the exact paired-list contract without guessing a visual owner for
the shared primitive.

This package replaces all 27 live address-derived ROM definitions in
`rendering/palette_effects.s` and promotes five RAM fields: the global frame
counter and four palette-effect controls. It adds 27 provenance mappings and
44 static audit records, raising the totals from 12,203 to 12,230 and from
8,693 to 8,737. The enforced address-derived ceiling falls from 3,838 to
3,811; module count remains 349.

The frontend text audit joins the former 260-line `ui/results_numbers.s` and
205-line `rendering/text.s` into the ROM-contiguous 469-line
`rendering/text_and_numbers.s`. This is a control-flow repair, not a cosmetic
merge: the unreferenced fixed-width BCD entry at `$0044BC` deliberately falls
through across the former include boundary into the shared staged-word DMA
queue routine at `$004594`. The combined module now owns two packed-BCD glyph
builders, two double-height string builders, their common queue primitive,
and the immediately following frontend string table.

The first BCD routine is not a generic number updater. All callers already
provide packed BCD; it suppresses leading zero nibbles, advances the VRAM
destination for each omission, derives the lower glyph row by adding one to
each top-row tile, and queues both rows. The alternate entry renders every
requested nibble and has no static caller. The former broad
`Gfx_BuildVDPCommandList` name is narrowed because it creates exactly one
16-byte staged-word DMA record and advances `VDPStagingDataCursor`.

The text data now exposes the strings encoded by the byte values rather than
address labels, including the title tagline, options rows, password prompts,
continue labels, and results headings. Five previously unlabeled string
boundaries were added without moving bytes. The `$C9--$CD` sequence remains
neutral because its glyph meanings and caller are not established. The
overloaded four-byte scratch area at `$FFFF8040` also remains raw: unrelated
rendering, decompression, player, weapon, stage, effect, and boss code reuse
it for incompatible temporary values.

This package replaces all 62 live address-derived definitions in the two
former modules and adds five missing data labels. It adds 62 provenance
mappings and 73 static audit records, raising the totals from 12,230 to
12,292 and from 8,737 to 8,810. The enforced address-derived ceiling falls
from 3,811 to 3,749; the coherent merge reduces the module count from 349 to
348.

The story/title-transition audit joins the adjacent 214-line
`cutscenes/story_screen.s` and 483-line `cutscenes/title_letters.s` ranges as
the cohesive 687-line `cutscenes/story_screen_and_title_transition.s`. The
former boundary separated one thirteen-state dispatch table from its last five
handlers. The merged module now follows the complete path from plane clearing
and timed story cues through asset loading, the per-character logo reveal, the
full-logo expansion, exit fade, and transfer to title-screen mode `$14`.

Static inspection narrows several earlier generated claims. The alleged
button handlers only wait for exact timer values and queue sound cues. The
former generic title-letter setup clears both planes and the pattern workspace,
renders font codes `$00-$27`, stages the first glyph of `ALIENSOLDIER`, and
performs a direct pattern DMA. Its following state expands each of twelve
characters around the screen center, builds the spaced `ALIEN SOLDIER` pattern,
and uploads it; the next state expands that complete pattern and rebuilds the
centered horizontal-scroll table. The supposed immediate title transition
instead waits for a timer and starts an exit fade; only the final state selects
the title initializer after fade-complete bit 1 is observed.

The shared return at `$00514E` is intentionally named `Cutscene_Return`, not
as private story code: 109 conditional branches in the story, text, planet,
ship, rendering, and credits modules target this one `RTS`. Five adjacent RAM
fields are also promoted with their actual scope. Three are private to the
logo reveal (`StoryTitleGlyphCursor`, `StoryTitleExpandSpan`, and
`StoryTitleGlyphsLeft`); `CutsceneTimer` and `CutscenePaletteStep` are shared by
the story, credits, starfield, and planet flows.

This package replaces 54 live address-derived ROM definitions and promotes
five RAM fields. It adds 59 provenance mappings and 79 static audit records,
raising the totals from 12,292 to 12,351 and from 8,810 to 8,889. The enforced
address-derived ceiling falls from 3,749 to 3,690; the coherent merge reduces
the module count from 348 to 347, with a mean of 342.7 lines. The rebuilt
Japanese ROM remains byte-identical after all boundary, symbol, and shared-RAM
changes. The runtime toolchain is also repinned to the clean current
`gens_automation` commit `f62b2cf`, and its observed executable identity is
recorded in `config/toolchain.json`; standalone `make build` and `make verify`
therefore validate the same checked-out evidence runner.

The planet-grid package audits the complete 473-line
`cutscenes/planet_ship_and_star_sequences.s` controller and the nonadjacent
383-line `cutscenes/sprite_grid_and_pattern_effects.s` implementation. They
remain separate because story-text bytes lie between their ROM ranges, while
their names now make the cross-range relationship explicit. The first module
contains three independent state machines: two planet grids, two ship grids,
and a ten-object pair of expanding and collapsing star rows. The second builds
their centered OAM grids and implements the shared pattern effect.

Static data flow disproves the earlier generated palette and rotation names.
The effect initializes 32-byte all-one masks, changes one selected 4-bit nibble
per step in a shuffled 64-entry order, expands that word across one staged row,
and queues VRAM DMA. The two alleged palette-update routines instead compose
and queue sixteen pattern rows, and neither accesses palette RAM. The supposed
planet scroll routine emits OAM cells, while the supposed star fade changes row
separation and finally clears ten object slots.

This package audits all 75 ROM definitions in the two modules, corrects two
caller-state names that falsely claimed rotation, and promotes 23 shared or
sequence-private RAM fields. Fifty-five new provenance mappings raise the total
from 12,351 to 12,406; 100 static audit records raise the total from 8,889 to
8,989. The enforced address-derived ceiling falls from 3,690 to 3,635. Module
count remains 347, both files stay in the normal size band, and the rebuilt
Japanese ROM remains byte-identical.

The story-text and ending-credits package audits all 31 definitions in the
261-line `cutscenes/story_text.s` range and all 13 definitions in the renamed
171-line `cutscenes/ending_sequence_credits.s` range. The story module contains
two related systems: a two-state English story roll and a three-state Japanese
font-glyph streamer. The ending module initializes the credits and owns the
thirteen-state dispatch table that continues through the adjacent starfield,
planet, and zoom code; its filename no longer implies that the table stops at
the credits screen.

The two former address-named story blobs are now preservation assets
`story_text_primary_rows.bin` and `story_text_accent_rows.bin`. Each is exactly
99 fixed `$22`-byte records plus a final `$FE`. Static control flow shows that
the primary stream carries the complete English rows, while the sparse parallel
stream is rendered with separate tile attributes and four palette words that
alternate by frame parity. The Japanese path decrements the VDP vertical-scroll
value and queues the next 128-byte glyph whenever it crosses another
sixteen-pixel threshold.

This package renames 52 source definitions, including eight private RAM fields
and two co-addressed end aliases represented by their owning data records in
the unique-address audit. Thirty-two new provenance mappings raise the total
from 12,406 to 12,438; 50 static audit records raise the total from 8,989 to
9,039. The enforced address-derived ceiling falls from 3,635 to 3,603. Both
modules remain in the normal size band and the extracted-asset manifest retains
the original ranges, sizes, and hashes under their semantic paths.

The ending-starfield and planet package audits all 52 ROM definitions in the
644-line `cutscenes/ending_starfield_and_planet.s` range and promotes five
shared ending-state RAM fields. The filename now describes the complete
sequence: four interleaved star-particle banks, the transition-buffer setup,
planet reveal and dissolve states, the secondary zoom object, randomized burst
objects, graphics-frame animation, and the symmetric perspective-scroll tail.

Static control and data flow correct several generated claims. The starfield
exit is not Sega-screen-specific; it fades the ending stars and prepares the
planet buffers. The former planet palette dispatcher only changes the secondary
object's vertical velocity. The alleged stage-18 initializer creates 32 burst
objects around the ending planet, while its alleged offscreen cleanup tests an
object lifetime field rather than coordinates. The supposed 3D-rotation
routine integrates an accelerating scroll phase and writes mirrored horizontal
and vertical scroll bands; it performs no coordinate rotation.

This package replaces 25 live address-derived ROM definitions and records all
52 ROM definitions plus five RAM fields in the static name audit. Twenty-five
new provenance mappings raise the total from 12,438 to 12,463; 57 audit records
raise the total from 9,039 to 9,096. The enforced address-derived ceiling falls
from 3,603 to 3,578. Module count remains 347 and the reconstructed Japanese ROM
remains byte-identical.

The ship-sequence package audits all 90 ROM definitions in the cohesive
`cutscenes/ship_sequence.s` range, promotes fifteen private RAM fields, and
identifies ten sprite-frame records in `data/stage2_phase1_assets.s`. The module
retains its complete sixteen-state timeline, three-state flash loop, orphaned
three-state jitter experiment, eighteen-row pattern reveal, two timed spawn
scripts, and both object families. Keeping these directly coupled components in
one source file avoids another formal container split; the module remains below
the 1,000-line ceiling without a waiver.

Static data flow corrects the strongest earlier generated claims. The alleged
fade-in and zoom states change signed 16.16 vertical velocity, not alpha or
sprite scale. The alleged color updater changes vertical position and never
touches palette memory. The supposed animated-text renderer reveals shuffled
four-bit masks in eighteen pattern rows without reading character data, while
the supposed Sega-palette helper is only proven to apply fixed fades and five
grayscale accents. The unused effect dispatcher is now explicitly orphaned:
no static caller reaches its one-pixel vertical-jitter states.

This package replaces 66 live address-derived definitions and adds 115 static
audit records, covering every ROM definition in the module plus its RAM and
sprite-frame dependencies. Provenance rises from 12,463 to 12,529 and the audit
registry from 9,096 to 9,211. The enforced address-derived ceiling falls from
3,578 to 3,512; module count remains 347.

The title-screen package audits all 19 ROM definitions in the 192-line
`ui/title_screen.s` module and promotes three shared demo-playback RAM fields.
The module remains a natural standalone range: joining it to the following
890-line options module would cross the 1,000-line ceiling, while splitting
its short initialization and update paths would only create formal fragments.

Static flow establishes the complete three-choice encoding: zero opens the
password screen, two starts the game, and four opens options. At frame `$700`
the same updater activates deterministic demo playback; confirming while that
flag is active copies the selected demo-stage entry into `StageTableIndex`.
Two odd instruction pairs are documented without being normalized away: the
comparison with `$780` is overwritten by the following comparison with `$700`,
and the second consecutive zero-branch in selection dispatch is unreachable.
Both remain byte-significant source. The adjacent 26-byte preserved block is
24 zero bytes followed by `$FF00`; because no static reference reaches it, its
name records only title-range ownership and unreferenced status.

This package replaces thirteen local address labels and promotes three RAM
fields. The unreferenced-data marker adds one more historical mapping, so the
seventeen new provenance records raise the total from 12,529 to 12,546.
Twenty-two static audit records raise the registry from 9,211 to 9,233, and
the enforced address-derived ceiling falls from 3,512 to 3,496. Module count
remains 347, and a clean rebuild of the canonical Japanese ROM remains
byte-identical.

The strict options/frontend-helper re-audit covers all 99 definitions at the
98 unique addresses in the 890-line `ui/options_screen.s` module. The
co-addressed `Options_BGMTestEntries_End` alias is represented by its owning
record rather than violating the audit's unique-address rule. Fourteen new
records fill the former coverage gap, and twenty existing records now cite
the exact input bits, table consumers, cursor deltas, staged tile rows, and
palette writes that justify their names instead of generic control-flow text.

This pass also corrects subsystem ownership that the earlier formal rename
left behind. The BCD tile builders, staged DMA helper, and toggle-label path
are private `Options_*` routines rather than generic `Gfx_*` services. Cursor
initialization, no-op type-`$F8` update, flash colors, and the two-color menu
cycle are shared by options and password/title paths and therefore use the
`FrontendCursor_*` or `Frontend_*` namespace. The central word incremented by
`Sys_UpdateTimers` on every VBlank is now `VBlankFrameCounter`, distinct from
the separately maintained `FrameCounter` at `$FFFFA000`.

Thirty source definitions receive corrected scope names without inventing new
behavior. Promoting the VBlank counter adds one provenance mapping and removes
one live address-derived RAM definition: provenance rises from 12,546 to
12,547, the audit registry from 9,233 to 9,247, and the enforced unknown-name
ceiling from 3,496 to 3,495. Module count remains 347.
The package gate re-extracts all 579 assets, reproduces canonical SHA-1
`8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`, passes all 37 tests, and leaves
both formatter and lint clean.

The password-menu package audits all 51 ROM definitions across the exact
`ui/password_cursor_mappings.s` and `ui/password_screen.s` ranges. The
two-record cursor file remains intentionally short: it is the complete
password-owned mapping range between the options module and password code,
not a mechanically split fragment. The 430-line screen module remains one
cohesive editor, validation, cursor-motion, and text-data unit.

Static flow proves that `Password_StageCodeTable` contains 25 records with two
four-byte codes per stage. The first and second code select difficulty offsets
zero and two; the Continue display independently indexes the same table by
`StageTableIndex` and `DifficultyMode`. `PasswordDigits` names the four-byte
RAM value initialized to `01 01 01 01`, edited bytewise in the range one
through `$0A`, and compared as a longword during validation. Successful input
stores the zero-based even stage-table index and difficulty before entering
game mode `$70`.

The message streams are now named from their decoded glyphs and exact
consumers. A formerly hidden record at `$00A942` decodes as
`STAGE...LEVEL.NORMAL`; no reconstructed reference selects it, so the audit
records that negative evidence instead of claiming it is reachable. The five
palette words at `$00A4AC` are named only as password-menu overrides: the code
provably writes them to active-palette entries beginning at `$FFFFE322`, while
also copying them through the post-load `a2` value. No broader palette intent
is inferred from that unusual second write.

This package replaces 41 live address-derived ROM definitions and promotes
`PasswordDigits`, lowering the enforced ceiling from 3,495 to 3,453. The 41
renames, one RAM field, and newly exposed `$00A942` record add 43 provenance
mappings, raising the total from 12,547 to 12,590. Forty-nine screen records
plus the RAM record expand the already audited two cursor mappings, taking the
name-audit registry from 9,247 to 9,297. Module count remains 347.
The package gate re-extracts all 579 assets, reproduces canonical SHA-1
`8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`, passes all 37 tests, exports
16,057 canonical addresses, and leaves formatter and lint clean.

The message-display pattern follow-up resolves a false unknown-data claim and
tightens the earlier engine audit. The block at `0x180000` retains its original
`unknown_2` provenance but is no longer unreferenced: two fixed DMA builders
use its 48 repeated `$C7F8` words as 32-word and 40-word pattern-fill sources.
The adjacent addresses `0x180060`, `0x18006C`, and `0x180078` are the three
six-word base-pattern sources restored by the script-finalization path. Their
names deliberately retain numeric order and do not invent a visual identity.

The pass also corrects six tile/tilemap-oriented generated helper names to
their exact pattern-fill operations and promotes two message-owned RAM bytes.
`MessageAdvanceButtons` stores the controller value masked by `$70` and
short-circuits the glyph delay when nonzero. `MessageDisplayFlags` bit 7 spans
script entry through finalization and suppresses the signed HUD update while
set. Finally, the `MessageSequence_Idle` audit address is corrected from the
misread IDA ordinal `nullsub_22` to its actual listing address `0x00ABD0`.

Six restored or newly exposed provenance mappings raise the total from 12,590
to 12,596. Six new static audit records raise the registry from 9,297 to 9,303,
and the two RAM promotions lower the enforced address-derived ceiling from
3,453 to 3,451. The three newly labelled ROM boundaries raise the canonical
symbol export from 16,057 to 16,060 addresses; module count remains 347.

The stage-transition and Xi Tiger cutscene audit moves the shared route
dispatchers at `0x01E83E-0x01E869` out of the Xi Tiger module and into
`stages/transition_control.s`. Their three-entry initialization and update
tables select Xi Tiger, the Z-Leo ending scene, or shared ending-sequence handlers through the
transition route index. `cutscenes/xi_tiger.s` now begins at its natural
`0x01E86A` asset-loading entry and remains a cohesive 464-line module.

Static control-flow review also rejects four invented Sonnet claims. The
former `Cutscene_XiTigerWaitForInput` and `Cutscene_XiTigerSkipCheck` routines
never read controller state: they allocate two symmetric marker sprites. The
former `Cutscene_XiTigerComplete` only allocates a randomly positioned burst
particle, while the former `Cutscene_XiTigerProcessCommands` parses no command
stream and instead derives paired-object and layer positions from a fixed-point
phase. The shared particle animation is used by both this cutscene and Viblack
defeat code, so its old cutscene-completion-only name was also removed.

The package replaces all 24 live address-derived definitions across the two
modules and records exact static evidence for their 49 definitions plus the two
corrected sprite-frame tables. Provenance rises from 12,596 to 12,620, the
name-audit registry from 9,303 to 9,353, and the enforced address-derived
ceiling falls from 3,451 to 3,427. Module count remains 347 and the canonical
symbol count remains 16,060 because the source boundary moved without adding
or removing any ROM address.

The Missiray core pass reconstructs all 89 definitions in the cohesive
`0x0537B8-0x053E67` state-machine module. Its 22-entry main-state table now
names initialization, four transfer-gated opening stages, vertical placement,
linked-segment activation, message gating, the nine-entry attack sequence, and
the complete defeat pipeline. The direct and compressed graphics descriptors
use owner-scoped numeric set names because their transfer format and callers
are statically proven while their visual frame identity is not.

The audit rejects several inherited Sonnet descriptions. The former
`Boss_MissirayDispatcher` is the state-zero initializer, not another
dispatcher. `Boss_MissirayIntroMove` changes no position, and
`Boss_MissirayIntroStop` tests no stop coordinate; both are transfer gates.
`Boss_MissirayBattleStart` and `Boss_MissirayIdleState` are loader-only
routines also reused by attack states. The former `AttackState1/2` pair raises
the boss and initializes counters, while `GraphicsUpdate1` through
`GraphicsUpdate7` are the ordered defeat-motion, palette-fade, and tile-load
stages. The timed symmetric segment-separation helper is named by its body but
explicitly retains the fact that no live static caller is known.

All 51 live address-derived definitions in `bosses/missiray_core.s` are
eliminated and all 89 module definitions have exact-address audit coverage;
three message-gate records already existed, so 86 records are added. Provenance
rises from 12,620 to 12,671, the name-audit registry from 9,353 to 9,439, and
the enforced address-derived ceiling falls from 3,427 to 3,376. Module count
remains 347, the Missiray core remains a natural 622-line unit, and the
canonical ROM remains byte-identical.

The contiguous `bosses/missiray_attacks.s` pass reconstructs all 97
definitions in the `0x053E68-0x054456` attack-state module and removes its 55
live address-derived names. The first four-state machine repeatedly allocates
one type-`$10` projectile record and assigns it to a randomly selected idle
segment. The following state machines activate four ordered segment pairs,
arm all eight segments with one of four staggered delay patterns, and activate
the eight segments in a shuffled order before moving the controller vertically.
The shared allocation helper reserves eight projectile records atomically and
retires the partial set when allocation fails.

Static instruction review rejects the inherited `ShootPattern1` and
`ShootPattern2` split: these are consecutive allocation and segment-arming
states of one random-segment attack. The former `Attack1` and `Attack2` names
are replaced by their observable all-segment and shuffled sequential roles.
Most importantly, `Boss_MissirayMoveHorizontal` writes object Y at offset
`$14`, not X. The former facing-right/facing-left `AttackPattern4/5` claims
have no direct evidence; their five-state pipelines instead set Missiray mode
zero or one, wait for three named graphics transfers, and apply a fourteen-step
palette fade. `SpawnBulletRing` is also narrowed to allocation because the
helper creates and records type-`$10` objects but does not itself position or
fire them. The two standalone RTS bodies remain honest owner-scoped unused
no-ops because no live static reference reaches either address.

All 97 definitions now have exact-address static evidence in
`config/name_audit.json`. Provenance rises from 12,671 to 12,726, the audit
registry from 9,439 to 9,536, and the enforced address-derived ceiling falls
from 3,376 to 3,321. The cohesive module remains below the 1,000-line ceiling;
byte identity and the complete project gates are rechecked with this package.

The final Missiray pass reconstructs all 63 definitions in the contiguous
`bosses/missiray_segments.s` module and removes its 38 live address-derived
names. The three top-level segment modes are now explicit: ordinary projectile
launch, sine-derived offset transition, and the timed defeat flight. The
ordinary sequence initializes one of the projectile records reserved by the
attack controller, advances two differently scaled sine arcs, and returns to
idle after a fixed hold. The defeat sequence waits on its per-segment timer,
integrates vertical velocity, emits type-`$160` particles, and retires the
segment after it crosses Y `$180`.

This audit rejects four important inherited descriptions. The former
`Boss_MissirayUpdateGraphicsFrame` does not select a sprite frame: it walks a
15-word `E..0..E` wave consumed by the palette-fade wrapper. That wrapper is
Missiray-owned rather than a general graphics primitive. The unreferenced
`Boss_ValkirieInputControl` is neither Valkirie code nor horizontal movement;
its body gates on input modifier bit 6 and adjusts the active object's Y and
base-Y fields, so it is retained as an owner-neutral orphaned input helper.
Finally, the supposed missile identity is not statically established. The
proximity-gated producer and type-`$404`
state machine are named as proximity shots: an anchor follows its owner for
`$20` ticks, replaces itself with a moving record, and that record subsequently
adds a signed acceleration to vertical velocity.

All 63 definitions have exact-address static audit records. Provenance rises
from 12,726 to 12,764, the name-audit registry from 9,536 to 9,599, and the
enforced address-derived ceiling falls from 3,321 to 3,283. All three Missiray
modules now contain zero live address-derived definitions, remain cohesive at
622, 616, and 436 lines, and preserve their original ROM order.

The shared directional-and-gravity projectile pass reconstructs all 63
definitions in ROM range `0x02AFBE-0x02B6A4` and renames the former
`projectiles/enemy_patterns.s` container to the concrete 554-line
`projectiles/directional_and_gravity_shots.s`. All 48 live address-derived
definitions are removed and every definition receives an exact-address static
audit record. The module contains the staged eight-direction type-`$50/$4C`
shot, the type-`$148` two-speed shot family, an otherwise unidentified duplicate
handler at object type `$254`, descriptor-driven type-`$17C` delayed-collision
shots, and Terobuster's type-`$54` gravity shot.

This pass rejects several earlier generated descriptions. The alleged homing
shots never recalculate their heading after initialization: they use one-quarter
of their stored velocity for three ticks and then switch to full velocity. The
alleged bouncing type-`$17C` shot instead waits for its first animation to
finish, arms collision, and creates a reverse-velocity impact object without
bouncing. `Boss_DestroyerMK2UpdateSprite` allocates and initializes one projected
shot rather than updating boss graphics. The type-`$254` handler remains
owner-neutral because the object dispatch table proves the type, but no static
producer proves an entity owner.

Provenance rises from 12,764 to 12,812, the name-audit registry from 9,599 to
9,662, and the enforced address-derived ceiling falls from 3,283 to 3,235. The
renamed module has no live address-derived definitions, remains below the
1,000-line ceiling, and preserves the original ROM range and include order.

The stage-configuration pass reconstructs all 49 definitions in the former
`stages/configuration_loader.s` range and two directly coupled definitions in
the preceding configuration module. The former file boundary mixed two
unrelated jobs. ROM `0x012648-0x012733` is now the focused 99-line
`rendering/stage3_tile_resampling.s`; ROM `0x012734-0x012B69` is the 592-line
`stages/configuration_records.s`. Both remain adjacent in `src/main.s`, so the
ROM order is unchanged.

Static data flow disproves the inherited `Stage_LoadPalette` name. Its only
caller is the Stage 3 phase-2 path. The code gathers packed bytes from
`byte_1C09B2`, reverses their nibble order in scratch RAM, and resamples them
through a 96-entry fixed-point step table into `$FFFF0000` before the caller
uploads the result. No CRAM address or palette command is involved. The new
module and labels describe the observable packed-tile transformation without
claiming what the rendered graphic depicts.

The imported `CheckFlagsLoadObjData` name is also narrowed. The routine does
not inspect an unspecified flags structure: it compares `GameModeIndex` with
`$3C`, `$0C`, and `$10`. Those three modes tail-call `LoadObjData`; every other
mode tail-calls `Data_ProcessPointer`. Its exact historical spelling is kept as
a provenance-only exception and its new dispatcher name has a static audit
record. The former `Stage_LoadConfigData` is documented as a consumer of one
exact 30-byte record. Its field offsets and destinations are listed beside the
records rather than assigning unsupported gameplay meanings to the unknown
stage globals.

That field review also rejects two older commentary blocks. The 314-byte
`Stage12_ObjectSpawnList` is not unidentified graphics: it contains exactly 26
twelve-byte records followed by the `$7FFF` terminator consumed by
`Sys_ProcessSpawnList`. The alleged cut-intro configuration is the Stage 13
entry at byte index `$18` in the ordered stage-initializer table. Neither its
initializer nor its 30-byte record performs a cutscene-specific operation, so
the unsupported Kaede, sprite-size, unused-content, and TCRF attribution
comments are removed.

All 51 primary-pass definitions plus the corrected Stage 13 initializer and
Stage 12 spawn list have exact-address static audit records. The pass
removes 47 live address-derived identifiers, raises provenance from 12,812 to
12,860 and the name-audit registry from 9,662 to 9,715, and lowers the enforced
address-derived ceiling from 3,235 to 3,188. The natural split raises the
module count from 347 to 348 and changes the mean to 341.7 lines; there are
still no modules over 1,000 lines and no generic container filenames. A fresh
post-split rebuild reproduces the canonical Japanese ROM byte for byte.

The Wolf Garopa and Z-Leo mapping-data pass resolves all 51 definitions in
`data/wolf_garopa_and_z_leo_mappings.s`. The file remains a compact shared
data module rather than being split into artificial owner files of roughly 90
and 60 lines. Explicit owner comments separate the two contiguous groups while
preserving their original ROM order.

Wolf Garopa's 35 definitions are established by three named eight-entry
rotation pointer tables, the four-entry orb-direction table, direct
initializer assignments, and the audited player-relative mapping selector.
The two pose-angle mappings deliberately describe only the proven selection
ranges: one is used outside normalized angles `$10-$FE`, the other inside that
range. No visual pose identity is inferred from tile numbers.

Z-Leo's 16 definitions are established by its four-entry blade-direction
table, direct intro-part assignments, the metasprite table shared with
Valkirie Force, and the laser/drop-projectile initializers. The five shared
mappings use stable letter identities because the descriptor table reuses them
at several non-consecutive positions; pretending those letters were animation
frame numbers would overstate the evidence.

Every definition in the module now has an exact-address static audit record.
Provenance rises from 12,860 to 12,911, the name-audit registry from 9,715 to
9,766, and the enforced address-derived ceiling falls from 3,188 to 3,137.
The 155-line module has zero live address-derived definitions and remains
below the preferred 200-line band only because splitting or padding this
private mapping group would reduce cohesion without improving readability.

The phase-pattern, Stage 10 wasp, and circling-enemy mapping pass rejects the
former `data/ship_and_stage10_animation_mappings.s` container: no ship consumer
exists in its ROM range. Static pointer tables instead establish three natural
owners. The original `0x0EA86C-0x0EB337` range is now the adjacent
`data/phase_pattern_sprite_mappings.s` (`0x0EA86C-0x0EAE75`, 335 lines),
`data/stage10_wasp_sprite_mappings.s` (`0x0EAE76-0x0EB2E3`, 241 lines), and
`data/circling_enemy_sprite_mappings.s` (`0x0EB2E4-0x0EB337`, 31 lines).
The short circling module is one complete animation/rotation mapping set; merging
it back into an unrelated entity solely to reach the preferred line band would
make ownership less accurate.

The seven-entry phase-pattern pointer table proves the exact `$5C` selector for
each animation stream. The four-entry Stage 10 wasp table provides the same
evidence for its streams, and the circling handler separately proves one loop
animation plus five unique angle-selected mappings. Mapping letters identify
distinct records in ROM order; they do not claim unsupported visual frame
meanings. Four complete high-bit-terminated mappings at `0x0EAE76-0x0EAF1D`
have no source-level static reference. They are named
`UnreferencedPreWaspSpriteMappingA-D` to record their position and lack of a
consumer without asserting that their visual owner is the wasp.

All 52 imported address-derived definitions have exact-address static audit
records. Provenance rises from 12,911 to 12,963, the name-audit registry from
9,766 to 9,818, and the enforced address-derived ceiling falls from 3,137 to
3,085. The natural split raises the module count from 348 to 350 and changes
the mean to 339.8 lines; there are still no modules over 1,000 lines and no
generic container filenames. A fresh rebuild preserves the canonical Japanese
ROM byte for byte.

The shared stage-object mapping pass rejects the inherited
`data/ship_and_destroyer_mappings.s` identity. Its 53 definitions have no Ship
or Destroyer consumer. The actual references establish a shared projectile
mapping set used by Snake, Gusthead, Stage 12, Stage 18, and generic projectile
handlers; a pair of streams shared by Stage 12 floating objects, Gusthead
debris, and a Sharpssteel projectile; one Stage 18 moving-platform mapping; one
Stage 10 beetle animation; and the Stage 12 Teddy Bear mapping group.

The reconstructed `data/shared_stage_object_sprite_mappings.s` keeps those
interleaved mapping records together in their natural 299-line ROM bank. Names
encode proven consumers, exact per-frame durations, or stable record letters;
they do not invent visual poses. Four self-looping streams have no external
source reference and are therefore recorded as
`UnreferencedTeddyGroupAnimationA-D` instead of being assigned speculative
states. The three mappings used both by the Teddy Bear and Stage 15 hazard-wave
initializers are explicitly marked shared rather than owned by either caller.
The consumer audit also rejects an apparent `PilotLoop` interpretation: the
pilot-start routine writes that stream and then overwrites the mapping field in
the same straight-line path before returning. It is therefore named
`Stage12_TeddyBearOverwrittenPilotAnimation`; the surrounding live streams use
their proven rescue, pre-boarding, boarding-delay, landed, and boarding/pilot
transition roles.

The final 76 bytes are not sprite mappings. Both the Stage 10 enemy asset list
and teleport graphics asset list load them with type 6 at destination `$7800`,
so they now form the adjacent eight-line
`data/stage10_and_teleport_shared_asset.s` module at
`0x1A0FDA-0x1A1025`. The mapping bank retains `0x1A0CA6-0x1A0FD9`; the include
order and emitted bytes are unchanged.

All 53 imported definitions have exact-address static audit records.
Provenance rises from 12,963 to 13,016, the name-audit registry from 9,818 to
9,871, and the enforced address-derived ceiling falls from 3,085 to 3,032.
The asset split raises the layout from 350 to 351 modules and changes the mean
to 338.8 lines, with zero modules above 1,000 lines and zero generic container
filenames. A fresh rebuild again reproduces the canonical Japanese ROM byte
for byte.

The Flying Neo through Sunset Sting mapping pass rejects the partial
`data/flying_neo_and_train_mappings.s` identity. Only five records are shared
by the Stage 8 train and boss entrance controllers, and those records belong
to Xi-Tiger. The same ROM interval also contains independent Flying Neo,
Joker, Sunset Sting, and Deep Strider sprite mappings.

Static consumers establish six natural ROM-ordered modules:
`data/flying_neo_sprite_mappings.s` (`0x0EBBB8-0x0EBC23`),
`data/joker_sprite_mappings.s` (`0x0EBC24-0x0EBCD7`),
`data/xi_tiger_entrance_sprite_mappings.s` (`0x0EBCD8-0x0EBD9D`),
`data/sunset_sting_part_sprite_mappings.s` (`0x0EBD9E-0x0EBDCD`),
`data/deep_strider_sprite_mappings.s` (`0x0EBDCE-0x0EBE87`), and
`data/sunset_sting_second_form_sprite_mapping.s`
(`0x0EBE88-0x0EBE93`). The small modules are complete private mapping sets;
combining unrelated bosses merely to approach the preferred line band would
make ownership less accurate.

Flying Neo's named rotation table proves eight indexed mappings. Direct field
assignments separately prove its two auxiliary-part mappings and two
stage-relative anchor-part mappings. Joker's A, C, and E tables each select
eight physical mappings, while B, D, and F traverse those same sets in reverse.
Xi-Tiger's two entrance controllers distinguish a shared grounded mapping,
pre-jump/landing mapping, airborne mapping, and the ordered two-frame boss
landing pair. Sunset Sting's part table proves indices zero through seven; its
second-form body-part initialization table proves the final two-piece mapping.
No visual pose is inferred beyond those observed state and table roles.

All 50 formerly address-derived definitions have exact-address static audit
records. Provenance rises from 13,016 to 13,066, the name-audit registry from
9,871 to 9,921, and the enforced address-derived ceiling falls from 3,032 to
2,982. The natural split raises the layout from 351 to 356 modules and changes
the mean to 334.0 lines; the largest module remains 986 lines, with zero files
above 1,000 lines and zero generic container filenames. A fresh pinned-toolchain
build and direct verification reproduce the canonical Japanese ROM byte for
byte at SHA-1 `8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`.

The Jampan through Valkirie mapping pass rejects the inherited
`data/jampan_destroyer_and_epsilon_mappings.s` identity. No Epsilon 1 consumer
references this ROM interval. Static references instead establish Jampan,
Destroyer MK2, Back Stringer, and shared Valkirie rotation-C groups. The bytes
at `0x0EC43E-0x0EC6BF` form complete high-bit-terminated sprite mappings but
have no source-level pointer or direct assignment; they are isolated as
`data/unreferenced_post_back_stringer_sprite_mappings.s` rather than assigned
to the adjacent boss by conjecture.

The named groups become four owner modules around that neutral block:
`data/jampan_sprite_mappings.s` (`0x0EC238-0x0EC291`),
`data/destroyer_mk2_sprite_mappings.s` (`0x0EC292-0x0EC2E5`),
`data/back_stringer_sprite_mappings.s` (`0x0EC2E6-0x0EC43D`), and
`data/valkirie_shared_rotation_c_mappings.s` (`0x0EC6C0-0x0EC6EF`).
Jampan's initializer and two frame tables prove its shield, orbiting-part,
linked-part, and linked-animation roles. Destroyer MK2's direct assignments
and eight-entry angular table prove its projectile, component, and five
orbiting-part mappings. Back Stringer's angle table, forward/reverse rotation
tables, and projectile controllers establish its mapping indices and rebound
animation. The primary and alternate Valkirie definitions demonstrably share
the final three records.

All 49 formerly address-derived definitions have exact-address static audit
records. Provenance rises from 13,066 to 13,115, the name-audit registry from
9,921 to 9,970, and the enforced address-derived ceiling falls from 2,982 to
2,933. The natural split raises the layout from 356 to 360 modules and changes
the mean to 330.2 lines; the largest module remains 986 lines, with zero files
above 1,000 lines and zero generic container filenames. A fresh build remains
byte-identical to the canonical Japanese ROM.

The Victor, Sunset Sting, and Viblack mapping pass rejects the inherited
`data/victor_sunset_sting_and_viblack_mappings.s` container. The first two
records are demonstrably shared: Victor assigns them to its ring segments,
while Sunset Sting assigns them to active and inactive chain roots and embeds
the first mapping in its second-form tracking descriptors. They now form the
five-line `data/victor_and_sunset_sting_shared_sprite_mappings.s` module at
`0x0EBE94-0x0EBEA5`.

Sunset Sting's two eight-entry tables prove the exact angle indices of its
active and destroyed segment mappings. Its defeat-core table separately proves
three visible-core frames, with the third also assigned directly by the core
initializer. These records form the cohesive 43-line
`data/sunset_sting_segment_sprite_mappings.s` module at
`0x0EBEA6-0x0EBF8F`. Index numbers and neutral letters describe only the
observed table roles; they do not invent visual pose names.

The remaining range is a private Viblack missile set. The type-$210 missile
spawner directly assigns the second relative animation stream, and the two
streams select four adjacent sprite mappings with explicit durations. They are
isolated as the 26-line `data/viblack_missile_sprite_animations.s` module at
`0x0EBF90-0x0EBFDF`; the first stream's evidence is limited to its structure
and its position in the two-pointer pair immediately after the missile handler.

All 27 formerly address-derived definitions have exact-address static audit
records. Provenance rises from 13,115 to 13,142, the name-audit registry from
9,970 to 9,997, and the enforced address-derived ceiling falls from 2,933 to
2,906. The natural split raises the layout from 360 to 362 modules and changes
the mean to 328.4 lines; the largest module remains 986 lines, with zero files
above 1,000 lines and zero generic container filenames. A fresh pinned-toolchain
build and direct verification reproduce the canonical Japanese ROM byte for
byte at SHA-1 `8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`.

The Gusthead through Sharpssteel mapping pass corrects another imported owner
claim. `data/epsilon_1_and_valkirie_mappings.s` contains no Valkirie mapping:
its first three records are assigned by Epsilon 1, while every remaining record
is selected by Sharpssteel's blade-graphics, core-direction, or metasprite
tables. The boundary is exact because the final Epsilon linked-side-part
mapping ends at `0x0EC08D` and Sharpssteel's first mapping begins at
`0x0EC08E`.

The Epsilon records now form the 14-line
`data/epsilon_1_sprite_mappings.s` module at `0x0EC046-0x0EC08D`: one primary
body mapping, one alternate body mapping, and the mapping installed on both
linked side parts. The Sharpssteel records form the 73-line
`data/sharpssteel_sprite_mappings.s` module at `0x0EC08E-0x0EC237`. Its two
six-entry blade-graphics tables and four-entry directional-core table establish
every index; the metasprite descriptor table independently reuses all six set-A
mappings and the first core mapping.

The adjacent Gusthead bank remains one cohesive owner rather than being split
to satisfy a line target. It is renamed to the explicit 19-line
`data/gusthead_sprite_mappings.s` module at `0x0EBFE0-0x0EC045`. Gusthead's
root table already proved the first two records, while the sixteen-entry
angle-quantized segment table proves the remaining seven distinct mappings and
their repeated ranges. Neutral letters distinguish physical mapping records
without inventing visual pose semantics.

All 26 newly reviewed address-derived definitions have exact-address static
audit records. Provenance rises from 13,142 to 13,168, the name-audit registry
from 9,997 to 10,023, and the enforced address-derived ceiling falls from 2,906
to 2,880. The corrected owner split raises the layout from 362 to 363 modules
and changes the mean to 327.4 lines; the largest module remains 986 lines, with
zero files above 1,000 lines and zero generic container filenames. A fresh
pinned-toolchain build and direct verification again reproduce the canonical
Japanese ROM byte for byte.

The Valkirie mapping pass reviews the complete 80-line
`data/valkirie_sprite_mappings.s` module at `0x0EC6F0-0x0ECB1B` without
splitting one cohesive owner merely to enlarge small files. The primary and
alternate rotation tables prove all eight indices of both the A and B mapping
sets. Their shared use is explicit in the names; no visual pose is inferred
from the raw sprite records.

The composite viewer supplies stronger direct evidence for its private data.
Its initializer assigns the direct mapping, both repeated part-pair mappings,
and the extended-gun mapping to exact object fields. The pair-position update
selects the pair alternate, while the eight-entry quantized-angle gun table
proves each gun mapping index. The primary and alternate Valkirie metasprite
descriptor blocks independently prove the four neutral A-through-D mappings.

The final record at `0x0EC82E` is a manifest-backed 750-byte asset rather than
a single six-byte mapping. Both metasprite descriptor blocks reference it, and
its size covers 125 six-byte sprite records. It is therefore named as packed
Valkirie sprite mappings, with an exclusive end at `0x0ECB1C`. That end is
co-addressed with `Boss_BugmaxSpriteFrame00`, so the boundary retains its own
provenance marker but deliberately shares the next module's one address-level
audit record instead of creating a duplicate.

All 35 live address-derived definitions now have evidence-backed names. The 34
unique start addresses receive exact-address static audit records. Provenance
rises from 13,168 to 13,203, the name-audit registry from 10,023 to 10,057,
and the enforced address-derived ceiling falls from 2,880 to 2,845. The layout
remains 363 modules with a 327.4-line mean; the largest module remains 986
lines, with zero files above 1,000 lines and zero generic container filenames.
A fresh pinned-toolchain build and direct verification reproduce the canonical
Japanese ROM byte for byte at SHA-1
`8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`.

The Seven Forces stage-state pass replaces the vague singular
`stages/seven_force_stages.s` identity with the proper 255-line
`stages/seven_forces_stage_states.s` module at `0x00E7D8-0x00EA75`. The
dispatch table in `stages/epsilon1_and_stage18.s` proves the exact ROM order:
Stage 20 setup and scrolling lead through the Medusa, Sylpheed, Artemis, and
Sirene transitions and then into the Seven Forces victory sequence.

This pass also rejects two especially misleading Sonnet claims. The former
`Boss_SireneSpawnProjectile1` only counts down a transition timer and updates
the camera; the former `Boss_SireneSpawnProjectile2` initializes the victory
timer, tilemap indices, and display-transition word. Neither allocates an
object or emits a projectile. They are now the pre-victory wait and victory
transition initializer. The remaining exported handlers use the shared
Seven Forces stage owner because their state-table role is stronger evidence
than the adjacent form named by the earlier labels.

All 21 address-derived branches and returns receive behavior-specific names
and exact-address static audit records. The same audit explicitly corrects 19
existing Sonnet semantic names, for 40 new records in total. Provenance rises
from 13,203 to 13,224, the name-audit registry from 10,057 to 10,097, and the
enforced address-derived ceiling falls from 2,845 to 2,824. The layout remains
363 modules with a 327.4-line mean, zero files above 1,000 lines, and zero
generic container filenames. A fresh pinned-toolchain build and direct
verification reproduce the canonical Japanese ROM byte for byte at SHA-1
`8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`.

The companion Seven Forces transition-graphics pass rehomes the cohesive
529-line `stages/seven_forces_transition_graphics.s` module from the misleading
`cutscenes/seven_force_sequence.s` path. The ROM block combines the eight-state
victory sequence with the shared Stage 20, Medusa, Sylpheed, Artemis, and Sirene
plane-transition helpers used by the immediately preceding stage-state table;
keeping the block together preserves those direct state-to-renderer relations.

The audit rejects 30 inherited semantic claims. In particular, the alleged
Sylpheed and Sirene tile/palette loaders only advance scroll positions and
render planes, the alleged Artemis palette updater passes a stream to the
compressed-tile decoder, and `Boss_ArtemisShootPattern1` fills a 64-word
tilemap row without allocating or firing an object. The former generic RAM-flag
clearer is the matching tilemap-mode clear, while four already accurate camera
and cutscene-loader names are retained with explicit evidence.

All 77 definitions in the module now have exact-address static audit records.
The 43 formerly address-derived definitions receive provenance-preserving
behavioral names, raising provenance from 13,224 to 13,267 and the name-audit
registry from 10,097 to 10,174. The enforced address-derived ceiling falls from
2,824 to 2,781. Module count remains 363 with a 327.4-line mean, zero files over
1,000 lines, and zero generic container filenames. A fresh pinned-toolchain
build reproduces the canonical Japanese ROM byte for byte at SHA-1
`8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`.

The adjacent transition-boundary pass removes the artificial 147-line
`stages/transition_effects.s` container. Its first two called helpers are part
of the immediately preceding Seven Forces flow: the Artemis transition damps
the shared horizontal velocity toward zero, while the Sylpheed state updates
its foreground scroll velocity and position. They now extend the cohesive
`stages/seven_forces_transition_graphics.s` range through `0x00F0EF`. The
20-line palette-fade helper at `0x00F064` has no reconstructed static caller;
it remains explicitly unreferenced instead of receiving a speculative Seven
Forces or boss owner.

The remaining range begins with the process-table-selected transition
dispatcher and its complete relative-offset table. Those definitions belong
with the handlers they select, so they now precede
`StageTransition_InitializeAsteroidField` in the 584-line
`stages/stage_and_boss_transition_states.s` module at
`0x00F0F0-0x00F7F9`. This also corrects four inherited Sonnet claims: the
former Artemis projectile helper only damps velocity, the former Sylpheed
graphics helper only changes scroll motion, the former transition initializer
is a dispatcher, and the palette helper has no proven caller or owner.

All 11 definitions in the reviewed boundary have exact-address static audit
records. The seven formerly address-derived definitions receive
provenance-preserving behavioral names, raising provenance from 13,267 to
13,274 and the name-audit registry from 10,174 to 10,185. The enforced
address-derived ceiling falls from 2,781 to 2,774. The corrected boundary
reduces the layout from 363 to 362 modules and changes the mean to 328.3 lines;
the largest module remains 986 lines, with zero files above 1,000 lines and
zero generic container filenames.

The complete stage-and-boss transition-state audit reviews all 59 definitions
in `stages/stage_and_boss_transition_states.s`. Its state-table order proves
the progression from the Stage 21 asteroid field through Destroyer Proto,
Shield Viper, and Wolf Garopa transition backdrops. The former boss-centric
names overstated what these handlers do: they update global scroll, raster,
palette-fade, asset-transfer, message, and phase state rather than dispatching
the bosses' gameplay state machines.

The most misleading inherited claims are now explicit corrections.
`Boss_DestroyerProtoAnimationScript` interprets no script; it updates the
Destroyer Proto backdrop fade. `Boss_WolfGaropaSpawnProjectile2` allocates no
projectile; it waits for the object pool to clear. The former Wolf Garopa main
and dispatcher names only render and finalize the transition backdrop. The
former Shield Viper palette-restore state instead waits for a VRAM transfer.
Two unreferenced helpers and the empty handler at the end of the range retain
honest unreferenced names because neither the transition table nor another
static call site selects them.

The audit also follows the type-$41C records initialized by two transition
states into `stages/wolf_garopa_arena_boundaries.s`. They are paired Stage 23 arena
boundary records, not Wolf Garopa attack states, and their update handler
changes screen-relative position and a shared bound without touching palette
memory. Four definitions there are corrected and audited with the owning
transition package.

The 24 formerly address-derived definitions receive provenance-preserving
names, while 37 inherited semantic names are corrected or narrowed, for 61 new
exact-address audit records. Provenance rises from 13,274 to 13,298 and the
name-audit registry from 10,185 to 10,246. The enforced address-derived ceiling
falls from 2,774 to 2,750. The layout remains 362 modules with a 328.3-line
mean; the largest module remains 986 lines, with zero files above 1,000 lines
and zero generic container filenames.

The following Stage 24 and Missiray transition pass audits all 25 definitions
formerly isolated in `stages/stage24_missiray.s` and now joined to the complete
transition-state module. The first five dispatch states form a cohesive
Missiray entry and exit sequence: they initialize two type-$3E0 scene objects,
update full-, half-, and quarter-speed vertical parallax, load the explicit
Missiray asset set, start message sequence `$2E`, and wait for the message and
shared activity signals before starting the outgoing transition. The former
`Boss_MissirayInit` does not initialize the boss controller, and the former
`Boss_MissirayPaletteUpdate` writes no palette data; both claims are corrected.

The second state family initializes type-$410 and type-$10 Stage 24 scene
objects, accelerates the vertical scroll to `$00C0`, derives a bounded offset
from the first object's Y coordinate, and waits for the completion byte and
shared activity words before advancing the stage table. Its older generic
camera, scroll, and phase names are narrowed to their observed transition
roles. Entity type `$3E4` is also identified as the one-operation controller
that advances the global transition state; the adjacent table entry is its
inert return state.

All 25 definitions now have exact-address static audit records. The twelve
formerly address-derived branches and returns receive provenance-preserving
behavioral names, while thirteen inherited semantic names are corrected or
narrowed. Provenance rises from 13,298 to 13,310, the name-audit registry from
10,246 to 10,271, and the enforced address-derived ceiling falls from 2,750 to
2,738. The layout remains 362 modules with a 328.3-line mean, zero files above
1,000 lines, and zero generic container filenames.

The adjacent Z-Leo and shared-scroll pass completes the transition dispatcher
through address `0x00FB23`. The Z-Leo table states update the approach camera,
load the explicit boss asset set, wait for the object pool to clear, and then
hand off to the next phase. The former `Stage_SetStage25ScrollTimer` does
neither stage timing nor scrolling: game-mode table evidence proves that its
`$8C` write selects `Credits_InitXiTiger`, so it is now named
`StageTransition_StartXiTigerCredits`.

This pass also repairs the earlier formal file slicing. The Missiray, Stage 24,
and Z-Leo state families selected by one relative-offset table now live with
that table in the cohesive 862-line
`stages/stage_and_boss_transition_states.s` module. The following
`0x00FB24-0x00FC73` range is shared by the asteroid-field and Destroyer Proto
states: it integrates their fixed-point positions, fills alternating V-scroll
words, damps two backdrop velocities, and builds the segmented backdrop
pattern. It therefore becomes the naturally short 143-line
`stages/asteroid_and_destroyer_proto_scroll.s` helper module rather than
remaining under a misleading Stage 25 filename.

All 29 definitions in the reviewed range have exact-address static audit
records. Twelve address-derived branches and loops receive
provenance-preserving behavioral names, while seventeen inherited semantic
names are confirmed, corrected, or narrowed. Provenance rises from 13,310 to
13,322, the name-audit registry from 10,271 to 10,300, and the enforced
address-derived ceiling falls from 2,738 to 2,726. Rejoining the artificial
slices reduces the layout from 362 to 361 modules and changes the mean to 329.2
lines; the largest module remains 986 lines, with zero files above 1,000 lines
and zero generic container filenames.

The following transition-backdrop audit removes another semantic container:
`stages/boss_stage_rendering.s` mixed the raster workspaces shared by
Destroyer Proto, Shield Viper, and Wolf Garopa with the independent type-$41C
Wolf Garopa arena-boundary entity. The shared `0x00FC74-0x00FE9F` code now
forms the 229-line `stages/stage_transition_backdrop_effects.s` module, while
the already audited initializer and entity update occupy the naturally short
40-line `stages/wolf_garopa_arena_boundaries.s` module.

Static callers disprove the inherited owner claims. The former
`Boss_DestroyerProtoRenderSegments` is called from all three encounter
transitions and does not render boss objects; it builds clipped and
interpolated RAM buffers consumed by the backdrop raster effect. The former
`Boss_DestroyerProtoPaletteInit` is also shared with Shield Viper and updates
two palette-fade ranges rather than merely initializing one. The former
`Stage22_GraphicsUpdate1` advances fixed-point accumulators and builds the
common per-line offset workspace. Shield Viper's two wrappers are narrowed to
their observable V-scroll copy and queued backdrop-row operations.

All 24 definitions in the shared backdrop-effects range now have exact-address
static audit records. Nineteen address-derived branches, loops, and returns
receive provenance-preserving behavioral names, while five inherited semantic
names are corrected or narrowed. Provenance rises from 13,322 to 13,341, the
name-audit registry from 10,300 to 10,324, and the enforced address-derived
ceiling falls from 2,726 to 2,707. The entity split changes the layout from 361
to 362 modules and the mean to 328.3 lines; the largest module remains 986
lines, with zero files above 1,000 lines and zero generic container filenames.

The next ROM-adjacent audit replaces the generic
`stages/dispatch_helpers.s` filename with the behavioral
`stages/stage_process_dispatch.s`. The block is naturally short because it
contains the complete five-entry top-level stage-process table, the gate that
dispatches it, and the two default tables consumed when a stage advances to
the next encounter phase. The orphaned Stage 18 comment at its former end now
correctly precedes the Stage 18 tile routine in the following camera module.

The inherited `Stage_SetBossTransitionPalette` name is contradicted directly:
the routine never touches palette RAM. It indexes the stage table and writes
the paired boss-health fields at `$FFFF8200/$FFFF8202` and combat-counter
fields at `$FFFF8234/$FFFF8236`. The constant `$7000` table is therefore
`Stage_BossHealthDefaults`, while the mostly `$01E0` table retains the
neutral `Stage_BossCombatCounterDefaults` name because individual bosses use
the counter in different directions. The first routine at `0x00FF10` has no
static caller and clears a scratch word reused for unrelated stage and boss
purposes, so its speculative scroll-animation owner is replaced with an
explicitly unreferenced name.

All eight definitions in the block now have exact-address static audit
records. Four address-derived control/data labels receive
provenance-preserving names; the other four inherited semantic names are
retained, narrowed, or corrected. Provenance rises from 13,341 to 13,345, the
name-audit registry from 10,324 to 10,332, and the enforced address-derived
ceiling falls from 2,707 to 2,703. The layout remains 362 modules with a
328.3-line mean, zero files above 1,000 lines, and zero generic container
filenames.

The camera and scroll audit replaces another formal source split with three
behavioral ROM-ordered modules. The `0x010026-0x01038F` range is now the
404-line `rendering/camera_tracking_and_stage_scroll.s` module. It contains
the horizontal and vertical camera-follow algorithms together with the stage
wrappers that select them. The independent six-state phase-transition table at
`0x010390-0x0103F9` is the naturally short 43-line
`stages/stage_phase_transition_control.s` module. The following scroll-plane
setup was joined to its consumers in the 252-line
`rendering/scroll_plane_buffers.s` module instead of remaining separated from
the buffer-writing commands it initializes.

The audit corrects several inherited semantic claims. The former
`Gfx_LoadStage18Tiles`, `Gfx_LoadDestroyerMK2Tiles`, and `Gfx_LoadBossTiles`
routines load no graphics; they update camera positions and enter existing
tilemap renderers. `Camera_BoundedVerticalFollow` reads player X and changes
the horizontal stage coordinate, so it is retained only as an explicitly
unreferenced horizontal-bounds helper. The two alleged `Scroll_NoOp` entries
execute one `nop` and fall through into active scroll code rather than
returning. Camera names now distinguish horizontal anchors, bounds, and the
actual vertical-threshold path without assigning unsupported stage ownership.

All 55 definitions in the camera-tracking range now have exact-address static
audit records. Thirty-four address-derived branches and returns receive
provenance-preserving behavioral names; twenty-one inherited semantic names
are confirmed, narrowed, or corrected. Provenance rises from 13,345 to 13,379,
the name-audit registry from 10,332 to 10,387, and the enforced
address-derived ceiling falls from 2,703 to 2,669. The natural split changes
the layout from 362 to 363 modules and the mean to 327.4 lines; the largest
module remains 986 lines, with zero files above 1,000 lines and zero generic
container filenames.

The phase-transition and scroll-buffer follow-up audits all 24 definitions in
the adjacent `0x010390-0x0106C5` range. The message handler table disproves
two especially misleading inherited names. `UI_InitScoreTimer` writes message
state `$5C`, which starts `StageIntro_InitializePostBannerDelay`; it neither
reads nor writes the score. `Stage_TriggerPhaseTransition` writes state `$2E`,
which starts `Results_InitializeTimeBonus`. Both routines then advance the
stage controller, temporarily select the following `StageTableIndex`, and
dispatch that phase's visual-asset loader.

The generic stage-transition initializer is narrowed as well. Its post-fade
selector is 3; the gameplay loop maps that value to game mode `$34`, and the
game-state table maps `$34` to what is now `StageTransition_Initialize`.
Subsequent review disproved the earlier weapon-selection interpretation: the
route submits an optional stage BGM request and enters stage loading, while its
alternate code renders an interstage message and `PRESS START`; no weapon input
exists there. The section-change path instead selects message state `$50`, the
stage-number banner initializer. The already-audited adjacent wrapper is
therefore refined from generic section initialization to
`Stage_StartNextPhaseBannerWithDefaultBGM` as well, without adding a duplicate
audit record.

The following scroll module now distinguishes horizontal and vertical buffer
operations. The top-level routine selects the plane-base register shadows and
prepares both planes' interleaved scroll workspaces. Horizontal flags select a
direct value, a 224-line constant fill, a 28-cell constant fill, or a profile
from `$FFFF8800`; vertical flags select a direct value, a 20-column fill, or a
20-word profile from `$FFFF8A00`. The old singular/plural
`Gfx_WriteScrollValue(s)` pair concealed that material distinction.

Seventeen address-derived branches, loops, and returns receive
provenance-preserving behavioral names, while seven inherited semantic names
are corrected or narrowed. Provenance rises from 13,379 to 13,396, the
name-audit registry from 10,387 to 10,411, and the enforced address-derived
ceiling falls from 2,669 to 2,652. The layout remains 363 modules with a
327.4-line mean, zero files above 1,000 lines, and zero generic container
filenames.

The tilemap-column pass reconstructs the complete 284-line
`0x0106C6-0x0109A7` streaming unit and renames
`rendering/tilemap_rendering.s` to the narrower
`rendering/tilemap_column_streaming.s`. The main path resolves coarse and fine
tile lookup tables for nine successive rows, writes a column into staging RAM
and an optional mirror, then appends a 32-word DMA command with VDP
autoincrement `$80`. Its companion path populates an offset column through the
same lookup structure but adds no independent DMA command. The naturally
adjacent six-byte player helper remains at the module head instead of becoming
an artificial five-line file.

Three inherited names are directly disproved. `Gfx_InitScrollBuffer` only
writes object type `$08` to the player record at `$FFFFA400` and has no static
caller. `Gfx_GetCameraPosition` does not return after loading coordinates; it
falls through into the column queue path. `Camera_Stage18Lock` neither tests
nor changes camera bounds; it applies fixed coordinate offsets and populates
the unqueued Stage 18 column rows. The old generic tilemap renderer name is
also narrowed to the primary-plane column operation actually performed.

All 17 definitions receive exact-address static audit records. Ten
address-derived branches and returns receive provenance-preserving behavioral
names, while seven inherited semantic entries are corrected or narrowed.
Provenance rises from 13,396 to 13,406, the name-audit registry from 10,411 to
10,428, and the enforced address-derived ceiling falls from 2,652 to 2,642.
The layout remains 363 modules, with zero files above 1,000 lines and zero
generic container filenames.

The tilemap-row pass reconstructs the complete 324-line
`0x0109A8-0x010D15` unit and renames the generic
`rendering/scrolling_background.s` module to
`rendering/tilemap_row_streaming.s`. Its three related entry families now
state their actual transfer modes: queued one-row streaming from caller-supplied
coordinates and descriptors, synchronous direct transfer of all 32 rows while
holding the Z80 bus, and incremental one-row loading driven by the global
scrolling-transfer state.

Several inherited semantic names were materially misleading. The two
`Scroll_Get*Position` entries do not return coordinates; they fall through to
full-map transfers. The two `Data_LoadPointerTable*` entries select fixed
descriptors and immediately start those transfers. `Gfx_RenderSylpheedBackground`
is shared by multiple stage-transition paths and queues only one 64-word row,
while `Gfx_RenderScrollingBackground` likewise advances an incremental transfer
by exactly one row per call. The two wrappers at `$0109A8` and `$0109BC` retain
explicit unreferenced status because no reconstructed static caller establishes
the older generic or Stage 21 claims.

All 22 definitions receive exact-address static audit records. Thirteen
address-derived branches and loops receive provenance-preserving behavioral
names, while nine inherited semantic entries are corrected or narrowed.
Provenance rises from 13,406 to 13,419, the name-audit registry from 10,428 to
10,450, and the enforced address-derived ceiling falls from 2,642 to 2,629.
The layout remains 363 modules with a 327.4-line mean, zero files above 1,000
lines, and zero generic container filenames.

The first tilemap-DMA-primitives pass reconstructs the complete control flow
from `$010D16` through `$010F4D` and renames the containing 399-line module from
`rendering/dma_primitives.s` to the subsystem-specific
`rendering/tilemap_dma_primitives.s`. The code now distinguishes an offset row
written only to the RAM mirror, a separately queued scrolling row, incremental
64-word constant-row fills, a synchronous 2,048-word plane fill, and two
four-row DMA command encodings.

Four inherited semantic names were disproved. `Sprite_SetupDMA` never touches
sprite records; it fills one tilemap row with a constant word. `VDP_SetupDMA`
is specifically a complete tilemap-plane fill. `Gfx_CopyTileBlock8x8` copies a
4x4 block of tilemap words in RAM before queuing its rows, and it has no static
caller. `Scroll_UpdateStage14Scroll` changes no scroll coordinate and is shared
by Stage 12, Viblack, and Destroyer MK2 callers that supply packed DMA source
and destination addresses. The other long-source four-row entry is likewise
kept explicitly unreferenced.

All 16 definitions in this first half receive exact-address static audit
records. Ten address-derived loops and returns receive provenance-preserving
behavioral names, while six inherited semantic entries are corrected or
narrowed. Provenance rises from 13,419 to 13,429, the name-audit registry from
10,450 to 10,466, and the enforced address-derived ceiling falls from 2,629 to
2,619. The layout remains 363 modules with a 327.4-line mean, zero files above
1,000 lines, and zero generic container filenames.

The second tilemap-DMA-primitives pass reconstructs `$010F4E-$01116F`. The two
large routines do not decompress graphics or perform an undifferentiated tile
DMA. Both consume compact descriptors that select 32-byte source tiles by byte
index. One gathers eight-byte slices into horizontal rows and queues transfers
with VDP autoincrement two; the other gathers four vertically separated words
into columns and queues transfers with autoincrement `$80`. Optional descriptor
flags mirror the staged rectangle back into tilemap RAM.

`Gfx_LoadCompressedTiles` is therefore corrected to
`Tilemap_QueueIndexedRows`, and `Gfx_DMATransferTiles` becomes
`Tilemap_QueueIndexedColumns`. `Gfx_SetSpritePattern` is also disproved: it
rewrites offset `$0E` in consecutive 16-byte queue records, the high word of
their VDP destination commands, without accessing any sprite object or tile
pattern data. Finally, the 22-byte `unused_3` asset is identified structurally
as a complete 4x4 indexed-column descriptor and renamed in both the extraction
manifest and source; it remains explicitly unreferenced because no static
owner is known.

All 17 definitions in the second half receive exact-address static audit
records. Thirteen address-derived loops and returns receive
provenance-preserving behavioral names, while four inherited semantic/data
entries are corrected or narrowed. Provenance rises from 13,429 to 13,443, the
name-audit registry from 10,466 to 10,483, and the enforced address-derived
ceiling falls from 2,619 to 2,606. The layout remains 363 modules with a
327.4-line mean, zero files above 1,000 lines, and zero generic container
filenames.

The first downstream indexed-row terminology pass removes the same disproved
compression assumption from ten already-audited callers and descriptors owned
by Joker, Viblack, Wolf Garopa, Xi-Tiger, Artemis, and Z-Leo. These records are
plain indexed-row descriptors consumed by `Tilemap_QueueIndexedRows`; their
names no longer claim compressed payloads or a decoder that does not exist.
The Z-Leo helper also now states its second observed action precisely: it sets
VDP command high word `$81` on four queued records rather than setting sprite
patterns. Because this pass corrects semantic names that already carried
provenance and audit entries, the totals remain 13,443 mappings, 10,483 audit
records, and 2,606 address-derived unknowns.

The Missiray indexed-row terminology pass completes that correction across
the boss's two graphics-transition state machines and its initialization and
defeat paths. Seven small descriptor records are now named indexed-row sets
00 through 06, and their helpers explicitly queue those records through
`Tilemap_QueueIndexedRows`. Twenty-eight already-audited identifiers and two
additional audit descriptions no longer claim that these records are
compressed or decoded. Historical Sonnet-era names remain only in the
`previous_name` fields needed for provenance. This semantic correction does
not change the totals: 13,443 mappings, 10,483 audit records, and 2,606 live
address-derived unknowns.

The `object_loading.s` audit establishes that its entrypoint is an asset
dispatcher, not an object-spawn loader. It always loads one shared type-7
mappings record, indexes a 26-entry loader-offset table with `StageTableIndex`,
and then submits the selected stage graphics and mappings list. Stage 1 base
and phase lists, the Shellshogun arena list, Stage 8, Stage 10 enemy, and
teleport lists now have structural names. The Stage 10 trailing record is also
identified as the RAM base plus terminated block-index descriptor consumed by
`Gfx_AdjustSelectedTileBlocks`.

All 20 definitions in the module now have exact-address static audit records.
Eleven address-derived table and descriptor names gain provenance-preserving
semantic names, raising provenance from 13,443 to 13,454 and the audit registry
from 10,483 to 10,503. The enforced live address-derived ceiling falls from
2,606 to 2,595.

The adjacent `phase_loading.s` audit applies the same asset-list model through
Stage 16, Stage 2, Stage 18, Stage 20, and seven Stage 3 phase paths. Labels
that claimed to load only objects, a palette, or tiles now describe the mixed
graphics-and-mappings lists they actually submit. The common Stage 3 phase
1/2 tail is named from its shared control flow, and the otherwise unreachable
Stage 2 phase 2 and Stage 3 phase 4/5 loaders explicitly retain
`Unreferenced` status rather than implying live dispatch entries.

All 24 module definitions receive exact-address static audit records. Twelve
address-derived list or shared-tail names gain provenance-preserving semantic
names, raising provenance from 13,454 to 13,466 and the audit registry from
10,503 to 10,527. The enforced live address-derived ceiling falls from 2,595
to 2,583.

The first `visual_asset_loading.s` pass isolates and audits the module's
structural core without endorsing its still-questionable stage-owner labels.
`Stage_DispatchVisualAssetLoader` selects one of 26 relative entries using
`StageTableIndex`. The selected loaders feed compact streams into
`Stage_ExpandAndSubmitTileAssetCommands`, which copies already-complete odd
records verbatim, expands even source indices through a seven-entry shared
tile-source table, builds a terminated `LoadObjData` list in RAM, and submits
it through `Data_ProcessPointer`.

All seven definitions in this core range receive exact-address static audit
records. Four address-derived control-flow and table names gain provenance,
raising the totals to 13,470 mappings and 10,545 audit records. The enforced
live address-derived ceiling falls from 2,583 to 2,579. Individual visual-list
owners remain deliberately outside this endorsement pending their own audit.

The Stage 1–13 visual-loader pass resolves the first thirteen dispatch slots
using their ordered `StageTableIndex` positions, corroborated by existing
runtime mappings such as `$14` for Stage 11 and by the independently identified
Stage 8 train and Stage 9 flies code. Each palette/tile helper now names its
specific stage and each compact stream states that it contains tile-asset
commands. The old anonymous A/B pair becomes the ordered Stage 4/5 loaders.
The standalone source-zero-to-`$6000` helper has no reconstructed caller, so
its former Stage 4 claim is removed and its `Unreferenced` status is explicit.

All 27 definitions from `$011E86` through `$012045` receive exact-address
static audit records. Thirteen anonymous command streams gain provenance,
raising the totals to 13,483 mappings and 10,572 audit records. The enforced
live address-derived ceiling falls from 2,579 to 2,566.

The Stage 14–26 visual-loader pass completes the dispatch table and corrects
three material generated errors. The slot at `StageTableIndex=$1C`, confirmed
by pinned runtime evidence as Stage 15, was missing its leading digit and had
also caused its palette stream to be misowned by Stage 5. The following slot
is the Stage 16 visual loader, not Stage 17, while the next remains the actual
Stage 17 palette-only entry. Three immediate returns belong to Stage 23, 25,
and 26 visual dispatch slots, not the weapon system. Two standalone duplicate
loaders and two no-op hooks lack static callers and now say `Unreferenced`.

All 28 definitions from `$012046` through `$01219D` receive exact-address
static audit records. Thirteen anonymous lists and no-op labels gain
provenance, raising the totals to 13,496 mappings and 10,600 audit records.
The enforced live address-derived ceiling falls from 2,566 to 2,553.

The Xi-Tiger tail completes `visual_asset_loading.s`. Its entrypoint is now an
encounter-state initializer rather than a tile-graphics loader: it clears RAM,
normalizes weapon selection, applies a 30-byte stage configuration record,
processes palette slots, and initializes player stats. The former palette
loader is a one-entry configuration dispatcher selected by `XiTigerConfigIndex`, and
the alleged sprite loader applies that record before entering shared
color-table initialization. The record's fields now document the exact layout
consumed by `Stage_ApplyConfigurationRecord`.

All seven definitions in the Xi-Tiger tail receive exact-address static audit
records. Four control-flow, offset-table, and record labels gain provenance,
raising the totals to 13,500 mappings and 10,607 audit records. The enforced
live address-derived ceiling falls from 2,553 to 2,549, leaving
`visual_asset_loading.s` with zero live address-derived definitions.

The first `configuration.s` pass replaces all 16 remaining raw IDA labels in
the module with names tied directly to control flow and observed writes. The
stage initializer dispatch table, weapon-state convergence, scratch clearing,
four repeated range-fill paths, the Stage 13 buffer clear, Stage 17 asset and
tilemap data, and the shared Stage 18/20 setup blocks now have exact-address
static audit records. Potentially generated semantic names such as the
alternate Stage 2 configurations remain deliberately outside this package
until their dispatch slots and referenced records are cross-checked together.

Sixteen control-flow and data labels gain provenance, raising the totals to
13,516 mappings and 10,623 audit records. The enforced live address-derived
ceiling falls from 2,549 to 2,533, leaving `configuration.s` with zero live
address-derived definitions.

The Stage 1–9 configuration-table reconciliation corrects a systematic Sonnet
numbering error rather than preserving plausible-looking aliases. The table is
indexed directly by the even `StageTableIndex`: its `$04` through `$10`
entries are Stage 3 through Stage 9, consistent with the ordered visual table
and the pinned `$14`/Stage 11 and `$1C`/Stage 15 runtime anchors. Five supposed
Stage 2 alternatives are therefore the Stage 3–7 configuration wrappers and
records, while the supposed alternate Stage 8 initializer is Stage 9.

The corresponding spawn lists and shared palette lists now follow those proven
owners. The separate list installed only by `Stage_InitPostBoss` is named
`PostBossRuntimeSpawnList` without asserting an unproven stage owner. Sixteen
new exact-address audit records cover the nine initializer functions and seven
spawn lists; strengthened records cover the six renamed configuration records
and two palette lists. Provenance and the unknown ceiling remain 13,516 and
2,533, while the audit total rises from 10,623 to 10,639.

The Stage 10–19 configuration reconciliation removes the next run of shifted
Sonnet ownership. Ordered initializer entries `$12` through `$24` now match
Stage 10 through Stage 19, including the pinned `$14`/Stage 11 and
`$1C`/Stage 15 anchors. Configuration records, spawn lists, and shared palette
lists use the same ownership. The former Stage 18 alternate path is Stage 19,
and the supposed Stage 13 graphics loader is now the behaviorally exact
`Stage_ClearSharedStateBuffer`, which only clears 224 bytes at FF7800.

Ten initializer/helper functions and four newly reconciled spawn lists gain
exact-address audit records; existing record and palette evidence is updated
in place. Provenance and the unknown ceiling remain 13,516 and 2,533, while
the audit total rises from 10,639 to 10,653.

The Stage 20–26 configuration reconciliation completes all 26 entries in
`Stage_InitializerOffsets`. The seven live entries at `$26` through `$32` now
map to Stage 20 through Stage 26 instead of the generated Stage 25 through
Stage 33 sequence. Their configuration records, spawn-list owners, palette
lists, and the final post-stage palette reuse are updated consistently.

Four adjacent Stage 20 variant wrappers and two flag-setting configuration
wrappers have no static caller or dispatch-table entry. They and their records
now say `Unreferenced` instead of masquerading as additional numbered stages.
Thirteen wrapper/initializer functions and two spawn lists gain exact-address
audit records. Provenance and the unknown ceiling remain 13,516 and 2,533,
while the audit total rises from 10,653 to 10,668.

The gameplay-HUD entry pass corrects both module ownership and inherited
semantics across `0x012B6A-0x012E4F`. The former `debug_input_test.s` is now
`ui/gameplay_hud.s`: its live entry coordinates the stage timer, boss-health
clamp, alternating HUD sections, smoothed player-health bar, signed health
change, and the final VDP transfer command. The small input routine skipped by
the live entry has no reconstructed static caller; it is retained in ROM order
as `Debug_HandleDormantSoundAndMenuInput` without speculating about button
names or why it was disabled.

All 35 formerly address-derived local branches and loops now describe directly
observed timer, clamp, health-bar, digit, padding, or transfer behavior. The
two generated entrypoint names are audited as well. Provenance rises from
13,516 to 13,551 mappings, the name-audit registry from 10,668 to 10,705, and
the enforced live address-derived ceiling falls from 2,533 to 2,498. The
module remains within the project size target and has no live address-derived
definitions.

The adjacent `ui/hud_rendering.s` pass replaces its numbered HUD containers
with the two actual responsibilities: selected-weapon energy plus a transient
combat percentage, and the stage timer plus smoothed boss health. Direct data
flow also disproves four generated subsystem claims. The alleged palette-slot
pipeline queues icon-tile DMA for all four weapon slots, the alleged ship
scroll helper renders packed-BCD digits with leading-zero suppression, and the
alleged ship-health display reads the eight-digit `ScoreValueBCD` value.

All 37 formerly address-derived branches, loops, and tables now describe their
observed bar, timer, digit, padding, icon-transfer, or VDP-command roles. Twelve
pre-existing semantic names are corrected in the same exact-address audit.
Provenance rises from 13,551 to 13,588 mappings, the name-audit registry from
10,705 to 10,754, and the enforced live address-derived ceiling falls from
2,498 to 2,461. The module remains within the project size target and has no
live address-derived definitions.

The former `ui/status_display.s` mixed two unrelated owners across a clean ROM
boundary. Its live first 180 bytes now form the cohesive
`ui/weapon_state_icon_transfer.s`: pending even weapon-state selectors choose
one of eight icon-art sources, state one marks the queued VBlank command, and
the direct entry accepts an explicit source and destination. The remaining
dormant developer interface is `ui/debug_status_display.s`, containing its
own state dispatch, asset records, alternating tilemaps, and VDP transfers.
The small live module is retained intact because splitting its procedure from
its private source table would be artificial.

This pass also promotes RAM `$FFA21E` to `WeaponIconTransferState` and
corrects the generated score-DMA and generic-VDP names. The dormant standalone
status dispatcher and its private table explicitly say `Unreferenced`; the
debug-menu path remains reachable only through the previously documented
dormant input entry. Twenty-one ROM address names plus the RAM placeholder gain
provenance-preserving names. Provenance rises from 13,588 to 13,610 mappings,
the name-audit registry from 10,754 to 10,788, and the enforced live
address-derived ceiling falls from 2,461 to 2,439. Both new modules contain no
live address-derived definitions.

The dormant debug-menu control pass completes the adjacent developer interface
through `0x013AD9`. Data flow disproves the remaining generated stage and weapon
claims: the first page edits packed-BCD player health, the second edits the byte
submitted to `Sound_QueueRequest`, the third clears shared boss health, and the
last two select and edit a Mega Drive palette line. The color editor addresses
`PaletteShadowBuffer` and mirrors each changed RGB word into the active palette
buffer; the former weapon-tile table is its four-line palette preview.

All 39 raw ROM labels in `ui/debug_menu.s` and the eight private RAM fields at
`$FF8660-$FF866C` now have behavior-based, provenance-preserving names. Fourteen
pre-existing semantic names are corrected in the same exact-address audit.
Provenance rises from 13,610 to 13,657 mappings, the name-audit registry from
10,788 to 10,849, and the enforced live address-derived ceiling falls from
2,439 to 2,392. The 341-line module has no live address-derived definitions and
remains within the project size target.

The frontend-loop pass removes a generated results-screen identity from the
boot path at `0x01CE7E`. This state actually resets shared video state and
activates mode eight, whose ordered handlers run the Sega screen, title/story
transitions, stage-transition setup, and cutscene setup. The following update
routine is therefore the opening-sequence loop rather than the gameplay loop;
the real gameplay loop remains separately identified at `0x01C65C`.

All seven raw labels in `ui/frontend_loop.s` now describe their exact dispatch,
tile-attribute, scratch-clear, palette-copy, or asset-list roles. Six generated
semantic names are corrected with exact-address evidence. Provenance rises from
13,657 to 13,664 mappings, the name-audit registry from 10,849 to 10,862, and
the enforced live address-derived ceiling falls from 2,392 to 2,385. The
180-line module has no live address-derived definitions.

The opening-transition follow-up reconstructs the two state machines selected
by the frontend loop. The first erases, holds, and reveals the sprite-grid
pattern initialized with `sega_tiles` and `SegaScreenPalette`. The second runs
two title-pattern erase/reveal cycles and terminates at the table entry that
selects the story-screen mode. This disproves the generated planet, generic
delay, game-screen, and gameplay-setup claims while retaining neutral pattern
names where the exact pictured artwork is not statically established.

The six raw definitions in `ui/screen_transitions.s` and its shared return at
`0x01D3D8` gain provenance-preserving names; twelve generated semantic names
receive exact-address corrections. Provenance rises from 13,664 to 13,671
mappings, the name-audit registry from 10,862 to 10,879, and the enforced live
address-derived ceiling falls from 2,385 to 2,378. The 172-line transition
module now has no live address-derived definitions.

The adjacent scene-control pass completes the opening-sequence control block.
Its stage-transition and cutscene asset lists, frame-selection clamp/wrap
branches, wrapped scroll-column update, and final sprite-grid mapping now have
behavioral names. The frame-selection handler exposes an unusual ROM fact
instead of hiding it: selector offsets zero, four, eight, and twelve read four
longwords directly from the machine code of
`Cutscene_ScrollAndPlaneUpdateCode` before the frame loader runs.

The anonymous 156-byte block at `0x01D544` has no reconstructed static
reference and is retained neutrally as `UnreferencedOpeningTransitionData`;
its extracted asset, range-map row, and manifest entry use the matching
`unreferenced_opening_transition_data` name. Eight raw address labels and that
generic `unused_4` label gain provenance, while three generated semantic names
receive exact-address corrections. Provenance rises from 13,671 to 13,680
mappings, the name-audit registry from 10,879 to 10,891, and the enforced live
address-derived ceiling falls from 2,378 to 2,370. The 136-line module has no
live address-derived definitions.

The former `ui/stage_select.s` is now the behaviorally accurate
`ui/post_stage_results_flow.s`. The game-state chain loads and scrolls into the
results screen, renders results, offers the continue path, and finally reaches
game-over handling; no stage-selection input exists in this module. Its second
initializer has one proven predecessor, `UI_UpdateSecondaryOptionsMenu`, and
re-enters the same dispatcher directly at
`Results_WaitForPostStageConfirmation`.

The ten-entry state table, two initialization paths, entrance scroll and fade,
alternating HScroll builder, selected palette fades, and shared asset list now
use post-stage results terminology. `StageSelectFullPaletteCommand` is likewise
corrected to `PostStageFullPaletteCommand` because both results initialization
and `RetryPrompt_Initialize` consume it. All twelve raw definitions gain
provenance-preserving names, while nine generated semantic names receive
exact-address corrections. Provenance rises from 13,680 to 13,692 mappings,
the name-audit registry from 10,891 to 10,912, and the enforced live
address-derived ceiling falls from 2,370 to 2,358. The renamed 244-line module
has no live address-derived definitions.

The continue-screen pass corrects the remaining generated results, time, stage,
and game-over claims in `ui/continue_screen.s`. `$FFFFA228` is now
`ContinueCreditsBCD`: new-game setup initializes its packed-BCD value to three,
continue setup requires it to be nonzero, the accepted hard-mode path decrements
it with `SBCD`, and the screen renders it beside `CREDIT`. The value at
`dword_FF8066+2` is the integer part of a fixed-point continue countdown here,
not a stage number.

All twelve raw address definitions and the RAM field gain
provenance-preserving names, while twelve generated semantic names receive
exact-address corrections. Provenance rises from 13,692 to 13,705 mappings,
and the JSON name-audit registry gains 25 records, from 10,901 to 10,926. This
corrects the previously reported running audit total, which was 11 too high.
The enforced live address-derived ceiling falls from 2,358 to 2,345. The
242-line module has no live address-derived definitions.

The adjacent `ui/results_screen.s` pass separates the post-stage summary
states from the final score summary reached after the credits. Static callers
and screen destinations disprove four generated identities: the alleged time
renderer displays `HighScoreBCD`, the alleged continue renderer displays
`DestroyedEnemyCountBCD` beside `DESTROYED ENEMIES`, and the alleged bonus
renderer displays `PlayerDamageBCD` beside `PLAYER DAMAGE`. The former
`UI_DecrementCounterBCD` also stages packed-BCD one and uses `ABCD`; it is now
correctly named `Results_IncrementDestroyedEnemyCountBCD`.

Four result RAM fields now have evidence-backed names. `HighScoreBCD` is
initialized to 100000, compared with the current score, replaced by larger
scores, and rendered under `HIGH SCORE`. `PostStageEntryCountBCD` is incremented
once per post-stage initialization but has only an unreferenced renderer;
`DestroyedEnemyCountBCD` and `PlayerDamageBCD` are tied directly to their
collision writers and visible result rows.

All sixteen raw definitions in the 267-line module and the four RAM fields gain
provenance-preserving names. Fourteen generated semantic names are corrected;
one existing audit record is updated and 33 records are added. Provenance rises
from 13,705 to 13,725 mappings, the JSON name-audit registry from 10,926 to
10,959 records, and the enforced live address-derived ceiling falls from 2,345
to 2,325. The module has no live address-derived definitions.

The former `ui/password_entry.s` is now the behaviorally accurate
`ui/stage_ready_and_retry_prompt.s`. Its first state pair loads the selected
stage and shared entry assets, starts a 64-frame delay, and alternates blank
text with `READY` before stage loading. It reads and edits no password. The
shared initializer previously called `UI_InitGameStateFromContinue` is likewise
broader: both the direct continue route and the READY route use it, so it is now
`StageEntry_InitializeGameplayState`.

The second state pair renders `YOU LOST 3 CHANCES`, `TRY AGAIN`, and
`PRESS START`, then returns to stage loading after confirmation. It is therefore
a retry prompt rather than a password screen. Its handlers remain statically
identified but operationally unselected: the dispatcher assigns them game-mode
indices `$58` and `$5C`, while no source assignment to `$58` is currently known.
That reachability question remains open rather than being hidden by a confident
name.

All six raw definitions in the cohesive 116-line stage-entry module gain
provenance-preserving names. Nine generated semantic names are corrected,
including `StageReadyPaletteCommand`, `Text_BlankStageReadyStatus`, and three
shared stage-entry helpers; two existing audit records are updated and 13 are
added. Provenance rises from 13,725 to 13,731 mappings, the JSON name-audit
registry from 10,959 to 10,972 records, and the enforced live address-derived
ceiling falls from 2,325 to 2,319. The module is intentionally below the normal
size target because the next ROM range belongs to the credits subsystem.

The former `ui/weapon_select.s` is now `ui/stage_transition_messages.s`.
Its known zero-substate route submits `PendingStageBGMRequest` when present and
enters `StageTransition_LoadStage`; its alternate setup loads font tiles,
renders an interstage message plus `PRESS START`, and then reaches the same
loader. Neither route reads weapon-selection input or loadout choices. The
actual weapon-selection object and setup screen remain separately identified
elsewhere in the source.

The alternate setup is still an explicit reachability unknown. The gameplay
loop selects game mode `$34` with `GameSubstateIndex` cleared, so the known
entrance takes the direct stage-load branch. Reaching the message-screen setup
requires a nonzero substate, and no source assignment establishing that entry
has yet been found. `UnreferencedStageTransition_PrepareGraphics` likewise has
no source reference. These limits are recorded instead of converting a
behavioral reconstruction into an unsupported runtime claim.

The transition-message cursor, pending BGM byte, and three font-tile DMA words
now have evidence-backed RAM names. Four message streams are named only by
their proven caller scopes; the extracted Train/Bugmax stream and its manifest
entry are now `stage_transition_message_sequence_train_and_bugmax`. The helper
at `$01E254-$01E263` moves from `credits/entry.s` to the transition module,
correcting its owner and moving the documented module boundary without moving
ROM bytes.

All fourteen raw definitions in the resulting 196-line transition module and
five RAM fields gain provenance-preserving names. Ten generated semantic names
are corrected; four existing audit records are updated and 25 are added.
Provenance rises from 13,731 to 13,750 mappings, the JSON name-audit registry
from 10,972 to 10,997 records, and the enforced live address-derived ceiling
falls from 2,319 to 2,300. The preceding credits module now ends at its actual
owner boundary `$01E253`.

The shared health and transition-state RAM pass promotes eight stable fields
without inventing new behavioral labels. `PlayerHealth`, `PlayerMaxHealth`,
and `DisplayedPlayerHealth` are independently corroborated by initialization,
damage, pickups, and both HUD presentations. `BossHealth`, `BossMaxHealth`,
and `DisplayedBossHealth` are likewise corroborated by boss setup, collision
damage, defeat clearing, threshold checks, and the boss HUD.

`SetupTransitionIndex` retains a deliberately shared name: the weapon-setup
screen uses it as an even state-table offset, then transition control reuses
values `0`, `2`, and `4` for Xi-Tiger, the Z-Leo ending scene, and the shared
ending-sequence route.
`XiTigerConfigIndex` is narrower but still incomplete evidence: source proves
the zero writer and a one-entry configuration dispatcher, not any nonzero
variant. The frame-decompression accumulator and tilemap bias remain raw
instead of receiving speculative cutscene names.

The pass raises provenance from 13,750 to 13,758 mappings, takes the JSON
name-audit registry from 10,997 to 11,005 records, and lowers the enforced live
address-derived ceiling from 2,300 to 2,292.

The `stages/gameplay_initialization.s` audit corrects another imported
subsystem boundary rather than merely replacing six raw labels. Game modes
`$70` and `$74` are now `WeaponSetup_InitializeScreen` and
`WeaponSetup_UpdateScreen`: title, password confirmation, demo setup, and
continue acceptance enter `$70`, whose second phase loads the setup assets,
renders its labels, initializes loadout/ammunition state, and enters the
interactive setup updater. The former `UI_InitializeStageStart`,
`UI_LoadStageGraphics`, and `Sys_UpdateGameplayLoop` names were therefore too
broad or false.

Transition route two is separately identified as the Z-Leo ending scene. The
Z-Leo defeat path writes `SetupTransitionIndex = 2`; its initialization loads
the Stage 26 palette and dedicated asset stream, and its updater calls the
nineteen-state Z-Leo ending controller that ultimately selects game mode
`$8C`. Route four enters and updates the shared ending sequence, then advances
the stage only after that sequence raises its completion word. These paths are
kept distinct from the weapon-setup screen despite their ROM adjacency.

All 27 definitions in the 307-line module now have exact-address static audit
records and no live address-derived names. Fifteen symbols are corrected or
promoted, including the two descriptor streams and the setup exit branches.
Twelve already-correct audit records are retained rather than duplicated.
Provenance rises from 13,758 to 13,764 mappings, the JSON name-audit registry
from 11,005 to 11,020 records, and the enforced live address-derived ceiling
falls from 2,292 to 2,286.

The former `ui/selection_menu.s` and `effects/floating_icon.s` are one credits
subsystem, not a menu followed by a generic effect. Their contiguous ROM range
is now the 288-line `credits/animated_glyph_sequence.s`. The only dispatcher
callers are credits states; no routine reads controller input. The embedded
874-byte stream parses as 37 variable-length records containing two row
delays, glyph counts, and glyph IDs. Its first records decode to `ALIEN
SOLDIER`, `STAFF`, and developer names, proving the credits-text role.

Each nonzero glyph ID creates entity type `$464`, selects its glyph tile, and
runs a six-state orbit, hold, fall, and acceleration sequence. The palette-ramp
helper has no source caller and is therefore explicitly `Unreferenced` rather
than treated as part of the live animation. The extracted stream and manifest
entry are now `animated_glyph_sequence` under `data/credits`.

Three low-RAM words are promoted with deliberately shared names. Frontend
transitions and the credits glyph sequence both use `SharedSequenceState`;
story text and credits independently reuse `SharedSequenceCursor` and
`SharedSequenceTimer`. Narrow subsystem names would be false across these
lifetimes.

The merged module has 36 definitions at 35 unique ROM addresses:
`CreditsGlyphSequenceData_End` shares `$021F2A` with the following object
initializer and retains its own provenance marker without duplicating the
address-keyed audit record. Together with the three RAM fields, the pass adds
38 unique-address audit records. Thirty-nine symbols are corrected or
promoted, provenance rises from 13,764 to 13,780 mappings, and the JSON audit
registry rises from 11,020 to 11,058 records. The enforced live
address-derived ceiling falls from 2,286 to 2,270, and the module count drops
by one without changing ROM order.

The cutscene-projection pass corrects another false imported boundary. The
former `cutscenes/frame_decompression.s` did not decompress data: its live
path resamples symmetric source columns into twelve rows, queues their VDP
transfers, and builds a 32-word raster line-offset table. It is now the
cohesive `cutscenes/frame_projection.s`, with six supporting RAM fields named
from their fixed-point arithmetic, loop use, and Xi-Tiger consumers.

The trailing routine at `$0261D8` belongs to the adjacent wave renderer rather
than the cutscene projector. It calls only that subsystem's coordinate,
pointer, pixel-blending, and parameter-table helpers, so it now starts
`effects/wave_transition.s`. Because no source call or dispatch entry reaches
it, the name explicitly retains `Unreferenced` instead of claiming a live
runtime role.

All thirteen definitions across the corrected boundary now have exact-address
static audit records. Sixteen address-derived ROM/RAM names gain provenance;
provenance rises from 13,780 to 13,796 mappings, the JSON audit registry from
11,058 to 11,077 records, and the enforced live address-derived ceiling falls
from 2,270 to 2,254 without changing the module count or ROM order.

The defeat-transition audit replaces a set of plausible-sounding but false
Sonnet labels. `Effect_InitPlayerSpawn` never created a player: seven boss
defeat paths use it to create transition entity `$150` at the owner's
coordinates. The Shiper/Terobuster helper similarly creates alternate
transition entity `$354`, not an explosion. Their parallel five-state object
machines are now distinguished as the standard `TransitionEffect` and the
statically narrower `AlternateTransition` paths.

The former palette dispatcher and copy helpers were also misclassified. The
mode table builds raster transition buffers; its supposed palette copier moves
arbitrary `d7+1` blocks of 32 bytes. The game-over caller requests sixteen
blocks, a 512-byte transfer, proving that neither the helper nor its caller is
a fixed palette copy. Buffer modes remain numbered zero through four because
their arithmetic is established but final visual names are not.

The corrected 340-line owner is now
`effects/defeat_transition_control.s`. All 43 definitions in it have
exact-address static audit records. Sixteen directly affected definitions in
the adjacent transition-buffer implementation plus the corrected game-over
caller are audited at the same time. This adds 60 records, raising the JSON
name-audit registry from 11,077 to 11,137. No address-derived name was hidden
by this semantic correction, so provenance remains 13,796 and the enforced
live ceiling remains 2,254.

The former `cutscenes/game_over_and_tunnel.s` combined three unrelated source
owners across a large ROM span. It is now the 303-line
`cutscenes/game_over_landscape.s`, the 90-line
`effects/tunnel_transition.s`, and a two-line data wrapper for the 9-KiB
perspective lookup payload. This is a semantic ROM-order split: the tunnel
entity shares the transition-effect machinery but never calls the Game Over
landscape builder.

The Game Over audit also corrects generated behavior claims. Its first state
reads live controller words and rebuilds perspective buffers; it is not demo
playback. The supposed sprite-table initializer actually fills 112 pairs of
descending row values, and the alleged 3D renderer only performs perspective
division into RAM buffers without issuing VDP or sprite-render calls. The
alternate dither initializer has no source caller and is explicitly marked
`Unreferenced`.

All 43 definitions across the three resulting owners have provenance. There
are 42 distinct auditable owner addresses before the following VDP module;
`GameOver_PerspectiveLookupTable_End` shares `$029E2E` with that module's
first routine and therefore retains provenance while the shared address-keyed
record belongs to `RasterBuffer_CopySelectedLayout`. One Game Over entry was
audited in the preceding
pass, so this pass adds 41 records. The 25 address-derived definitions include
the two descriptor structures that the narrower initial count omitted.
Provenance rises from 13,796 to 13,821,
the JSON audit registry from 11,137 to 11,178, and the enforced live
address-derived ceiling falls from 2,254 to 2,229. The source-module count
rises from 368 to 370 because code and data now have honest owners.

The former `rendering/vdp_layouts.s` audit proves that the module neither
initializes VDP registers nor writes VRAM. VBlank selects one of thirteen
layouts with `word_FF8090`; each live handler copies or expands work-RAM
raster buffers. The alleged initial-palette loader moves 256 bytes and then
expands fourteen raster rows, while the supposed VRAM clearer copies nonzero
source words into paired destinations.

The module is now `rendering/raster_buffer_layouts.s`. Its handlers are named
for statically corroborated owners such as Xi-Tiger, weapon setup, Game Over,
Flying Neo, story transition, and Z-Leo; shared cases retain transition-level
names. The four copy primitives state their exact 64-byte, interleaved,
repeated, or paired behavior. All 20 definitions have exact-address audit
records, including `$029E2E`, which shares the preceding data-end alias.
Three address-derived labels gain provenance, raising provenance from 13,821
to 13,824 and the audit registry from 11,178 to 11,198. The enforced live
address-derived ceiling falls from 2,229 to 2,226.

The Stage 9 fly-corridor, Caterpillar-ship, and Xi-Tiger-transition audit
replaces the partial `stages/flies_and_caterpillar.s` identity with the
ROM-ordered 402-line
`stages/stage_9_flies_caterpillar_and_xi_tiger.s`. Its eleven consecutive
stage-dispatch entries cover the fly corridor, Caterpillar encounter and ship
exit, Xi-Tiger entrance wait, and the post-encounter transition; keeping them
together preserves their shared camera, lightning, oscillation, and raster-row
implementation without creating artificial fragments.

Static data flow disproves two especially misleading generated claims.
`Stage_FliesSpawnEnemies` creates no object: it clears one selected byte across
23 tilemap rows, queues the corresponding VDP transfer, and advances through
32 reveal columns at eight-frame intervals. `Stage_CaterpillarShipUpdate` is a
one-shot encounter initializer that creates Caterpillar entity type `$128`
before entering the recurring ship-traversal state. The otherwise unreachable
entry at `$00D1EA` and the unreferenced 32-byte permutation at `$00D266` are
explicitly marked `Unreferenced`; the latter contains every index from zero
through 31 exactly once, but no unsupported purpose is assigned to it.

All 49 definitions in the module now have exact-address static audit records.
The 32 formerly address-derived definitions gain evidence-backed names and 33
new provenance mappings, raising provenance from 13,824 to 13,857 and the audit
registry from 11,198 to 11,247. The enforced live address-derived ceiling falls
from 2,226 to 2,194, while the module count remains 370 and the file stays well
inside the 1,000-line ceiling.

The targeting and projectile-runtime pass removes the misleading UI-only
ownership of `ui/targeting_reticle.s`. The ROM range through `$0199F3` is now
the 267-line `weapons/targeting_and_projectile_runtime.s`: it owns the
rate-limited lock-on reticle scan and OAM builder, the shared direction-vector
windows, player muzzle offsets, circle-attack directional frame pointers, and
the dedicated eight-slot projectile processing loop. The following player
script dispatcher is moved to the front of `cutscenes/stage_intros.s`, making
that coherent owner 357 lines and moving its layout boundary to `$0199F4`.

Static consumers prove that the eight 40-longword tables are circular X/Y
direction-vector windows: callers read one component at the indexed address
and the other `$20` bytes later. Their fixed-point magnitudes run from `$60000`
through `$D0000`, so the former anonymous tables now state speeds six through
thirteen. `Weapon_UpdatePlayerFiring` proves the eight muzzle records as eight
signed X bytes followed by eight signed Y bytes; numbered variants retain only
the primary-versus-alternate layout distinction that their call sites support.
No unsupported pose identity is invented.

The former `UI_RenderTargetingReticle` name was also incomplete: the routine
first waits on a delay, rejects any active projectile slot, scans the
collision-built lock-on list, and only then appends four animated corner OAM
records. The former generic input helpers actually dispatch the even player
script state, merge generated button bytes, and expire the scripted-input
interval. The projectile routine is aligned with the existing visible-object
loop terminology and explicitly names its dedicated pool.

All 37 inherited definitions in the reconstructed range have exact-address
static audit records; the additional pointer-window label at `$01937E` is a
new structural anchor with no imported identity to preserve. Thirty raw labels
gain provenance, raising provenance from 13,857 to 13,887 and the audit
registry from 11,247 to 11,283. The enforced live address-derived ceiling
falls from 2,194 to 2,164, while the source-module count remains 370.

The early-stage process-state pass replaces the generic
`stages/camera_dispatch.s` owner with the 590-line
`stages/early_stage_process_states.s`. The stage configuration records provide
authoritative boundaries inside its shared relative-offset table: Stages 1-7
begin at offsets `$00`, `$0A`, `$12`, `$22`, `$2E`, `$38`, and `$40`.
Combining those boundaries with the boss asset sets proves consecutive
Jetsripper, Antroid, Shellshogun, Shiper, Madam Barbar, Joker, and Terobuster
state families. The dispatcher retains the later Stage 8 and Stage 9 table
entries because the ROM stores one contiguous early-stage table, while this
module's implementations end in the Stage 7 transition range.

This evidence corrects generated camera-centric descriptions rather than only
prefixing them with stage numbers. The former `Camera_ClampToBounds` never
changes a camera bound: it fills 128 raster words from the negated secondary
horizontal offset and 72 from the negated primary camera. It is now
`Stage4_FillShiperHorizontalRasterOffsets`. The former
`Stage_UpdateScrollOffset` derives two countdown-scaled arguments and
tail-calls `Gfx_FadeRGBColor_LoadEntryCount`; it is now the Terobuster intro
fade helper. The post-Shellshogun four-longword payload is named only as the
staged-row source selected by its producer and consumer; its internal format
is intentionally not claimed.

All 76 definitions in the module now have exact-address static audit records.
The 31 formerly raw definitions gain provenance, raising provenance from
13,887 to 13,918 and the audit registry from 11,283 to 11,357. The enforced
live address-derived ceiling falls from 2,164 to 2,133. Module count remains
370 and the reconstructed owner remains within the 200-700-line target.

The Terobuster-intro and Flying Neo effects pass corrects the ownership split
at `$00D6D6`. The type-`$178` Stage 7 boundary projectiles and their six
indexed-row descriptors now form the complete
`stages/terobuster_intro_projectiles.s` range through `$00D6D5`; the following
Flying Neo high-RAM composite initializer moves to the front of
`stages/flying_neo_effects.s`. This preserves ROM order while preventing a
Flying Neo routine from remaining attached to a Terobuster projectile file.
Both short modules are complete private procedure/data families rather than
arbitrary line-count fragments.

Static flow also rejects two generated lifecycle claims. The former
`Stage_FlyingNeoSpawn` allocates nothing: it updates the already initialized
high-RAM composite, assigns velocities, and queues indexed tile columns. The
former `Stage_FlyingNeoInitBoss` only submits the shared midgame palette-command
bank and is used by both Stage 8 and Stage 9. The lightning updater now states
its actual combination of randomized paired-palette control and optional
high-RAM composite creation. Its four mapping pointers and the three pairs of
counted palette-entry lists are named from their direct consumers without
inventing visual identities for individual palette addresses.

All 31 definitions across the reconstructed range have exact-address static
audit records. The 21 formerly address-derived definitions gain provenance,
raising provenance from 13,918 to 13,939 and the audit registry from 11,357 to
11,388. The enforced live address-derived ceiling falls from 2,133 to 2,112;
the module count remains 370.

The gameplay-entry pass replaces the misleading
`stages/xi_tiger_background.s` identity with the complete 172-line
`stages/gameplay_entry_states.s` module. Its two adjacent game-mode handlers
are parallel entry-state machines: the normal Stage mode at `$0C` and the
post-cutscene Xi-Tiger mode at `$80`. Both initialize their stage-specific
state, process two configured tilemap-plane row streams, select transfer
parameters from the same two pointer pairs, and enter gameplay mode `$10` only
after both row counters complete. Their shared data and mirrored control flow
make this one coherent owner rather than an address bucket.

This corrects the generated `Stage_LoadBackgroundGraphics` description: the
routine also initializes the graphics and stage chains, manages palette and
display state, changes the top-level game mode, and enters the active stage
process. The former `Stage_XiTigerHandler` is now explicitly the Xi-Tiger
gameplay-entry state machine rather than an unspecified stage handler. Plane
branches are named only for their proven order and direct row-transfer
operations; no visual background/foreground identity is asserted.

All 21 definitions in the module have exact-address static audit records. The
18 formerly address-derived definitions gain provenance, raising provenance
from 13,939 to 13,957 and the audit registry from 11,388 to 11,409. The
enforced live address-derived ceiling falls from 2,112 to 2,094; module count
remains 370.

The Stage 10-13 state-table pass uses configuration-record offsets rather than
the generated function names to recover the real boundaries in
`stages/stage10_to_stage13.s`: Stage 10 starts at `$00`, Stage 11 at `$0A`,
Stage 12 at `$14`, and Stage 13 at `$34`. The table itself continues through
later midgame modules, so its dispatcher and relative offsets now carry
midgame ownership instead of the false `Stage_InitStage10` identity.

Those boundaries expose several numbering errors from the automated pass.
The former `Stage_Stage12Init` is still the final post-Gusthead state of Stage
11; the former `Stage_Stage13Init`, `Stage_Stage13ScrollUpdate`, and
`Stage_Stage13CheckTransition` are Stage 12 exit and Sharpssteel-approach
states. The alleged `Stage_Stage14Init` is the post-Sharpssteel wait inside
Stage 12. Conversely, Stage 13 begins at the type-`$298` Snake initializer at
`$00DD0E` and proceeds to the Bugmax encounter and post-boss transition.
Teleport states crossing the Stage 12/13 boundary use an explicit
`Stage12To13` prefix.

The former `Stage_LoadStage10Graphics` also loads no graphics. It selects a
raster effect, creates six persistent type-`$208` ambient particles, and
advances the state; both Stage 10 and Stage 11 call it. The helper and the
already-audited particle initializer/update family therefore move from false
Stage-10-only ownership to `Midgame` ownership, with their existing audit
evidence corrected accordingly.

All 55 imported definitions in the 497-line controller have exact-address
static audit records; the additional Stage 13 fall-through anchor at
`$00DCDA` has no imported identity. The 17 formerly address-derived
definitions gain provenance, raising provenance from 13,957 to 13,974 and the
audit registry from 11,409 to 11,464. The enforced live address-derived
ceiling falls from 2,094 to 2,077; module count remains 370.

The Stage 14-16 state-table pass uses the next four configuration boundaries
to correct both generated names and module ownership. `Stage14ConfigRecord`,
`Stage15ConfigRecord`, `Stage16ConfigRecord`, and `Stage17BossConfigRecord`
seed offsets `$40`, `$4A`, `$56`, and `$6C`. The ROM range ending at `$00E11B`
therefore contains Stage 14 through Stage 16 only; the old
`stages/stage14_to_stage17.s` container is now the accurately bounded
`stages/stage14_to_stage16.s`, while Stage 17 begins with Epsilon 1 in the
following module.

The boundaries disprove several generated lifecycle claims. Offset `$48` is
the final post-Victor state of Stage 14 rather than a Stage 15 transition, and
offset `$54` is the final post-Sunset-Sting state of Stage 15. The former
`Stage_Stage17Transition` at offset `$5C` remains inside Stage 16 and starts
the post-Viblack vertical-scroll sequence. The supposed generic camera-bounds
wrapper at `$00DF8E` is specifically the Viblack encounter's fixed-anchor
camera state. Victor, Sunset Sting, and Viblack ownership is independently
corroborated by the asset-set and object-type writes in their respective state
families.

All 38 imported definitions in the 264-line controller now have exact-address
static audit records. The 15 formerly address-derived definitions gain
provenance, raising provenance from 13,974 to 13,989 and the audit registry
from 11,464 to 11,502. The enforced live address-derived ceiling falls from
2,077 to 2,062; the byte-emitting module count remains 365.

The Stage 17 and shared-helper pass removes the mixed
`stages/epsilon1_and_stage18.s` container. Exact procedure boundaries divide
its ROM interval into `stages/stage17_epsilon1_states.s` (`$00E11C-$00E287`),
`projectiles/shared_directional_volley_helpers.s` (`$00E288-$00E34D`),
`rendering/snake_background_scroll.s` (`$00E34E-$00E42B`), and
`stages/late_game_state_dispatch.s` (`$00E42C-$00E4DB`). These intentionally
short modules each own a complete private procedure/data family; combining
them merely to approach a line-count target would restore the mixed address
bucket that Source Reconstruction 1.0 rejects.

`Stage17BossConfigRecord` proves that offsets `$6C-$76` are the Epsilon 1
transition, approach, encounter, and planet-transition states. This corrects
the generic `Cutscene_PlanetInit` name at `$00E256` to the final Stage 17 state.
Two routines in the same range have no static caller and are now explicitly
`Unreferenced`: one applies controller-selected words to palette RAM, while
the other creates type `$308` and updates the Stage 17 parallax fields. Their
observable behavior is recorded without inventing a live gameplay path.

The shared projectile range exposes two valid entries into one four-shot
emitter: Deep Strider and Sharpssteel use subtype eight through `$00E288`,
while Sharpssteel also calls `$00E28A` after loading subtype `$60` in `D3`.
The velocity data is proven as four X longwords followed by four Y longwords.
The adjacent angular helper creates the same type-`$1A8` projectile and derives
its two velocity components from the sine table. The Snake renderer consumes
eight fixed-point deltas and four pairs of eight-byte nibble rows. Finally,
the table at `$00E438` spans Stage 18 through Seven Forces victory, so its
dispatcher now carries `LateGame` rather than false Stage-18-only ownership.

All 33 imported definitions across the four ranges now have exact-address
static audit records. The 19 formerly address-derived definitions gain
provenance, raising provenance from 13,989 to 14,008 and the audit registry
from 11,502 to 11,535. The enforced live address-derived ceiling falls from
2,062 to 2,043; the byte-emitting module count rises from 365 to 368 solely
because the four coherent owners replace one mixed module.

The Stage 18-19 and unused Stage 20 variant pass aligns the opening late-game
states with their configuration offsets. `Stage18ConfigRecord` begins at
`$00`, `Stage19ConfigRecord` at `$0A`, and the normal `Stage20ConfigRecord` at
`$70`. Consequently, offset `$08` is the final post-Destroyer-MK2 state of
Stage 18 rather than a Stage 19 initializer. In Stage 19, offsets `$0E` and
`$10` only advance the camera to Jampan's arena and enter a shared transition;
the actual Jampan asset submission occurs at offset `$12`. The old
`Boss_DestroyerMK2UpdateHealth` name is also rejected because its stage state
never accesses health: it waits for the primary object to clear and then
starts the bonus/preload sequence.

Four unreferenced configuration wrappers seed offsets `$28`, `$30`, `$38`,
and `$40`, whereas normal Stage 20 skips directly to `$70`. Their twelve
reachable state entries are therefore named as explicit
`UnreferencedStage20Variant` phases. The first reuses Jampan's asset set and
the other three load statically identified entity types `$3EC`, `$3F0`, and
`$3F4`; no unsupported boss identities or normal-play reachability are
claimed. The shared helper at `$00E67A` only stores camera X divided by eight
as a parallax offset, disproving its former generic transition identity.

All 37 imported definitions in the range now have exact-address static audit
records. The ten formerly address-derived definitions gain provenance,
raising provenance from 14,008 to 14,018 and the audit registry from 11,535
to 11,572. The enforced live address-derived ceiling falls from 2,043 to
2,033; module count remains 368.

The Stage 7-to-8 transition and Stage 8 train/Flying Neo pass uses the early
state table together with `Stage8ConfigRecord` offset `$50` and
`Stage9ConfigRecord` offset `$62`. Offsets `$4C/$4E` are therefore the final
Stage 7 player-position trigger and delayed interstage transition. Stage 8
then occupies `$50-$60`: train initialization and scroll, Flying Neo approach,
vertical acceleration/deceleration, encounter initialization/update, and the
post-encounter transition. The module is accordingly renamed from the
incomplete `stages/train_and_flying_neo.s` to
`stages/stage7_transition_and_stage8_train_flying_neo.s`.

Static consumers correct the former generic helper names. The six-byte writer
copies three strided byte pairs into the `$FF615D` control region; neither the
RAM map nor its two callers prove a general boss-parameter structure, so its
name now states only that operation. The former train-only parallax helper is
also called from the Stage 9 fly corridor: it is now the shared
`Midgame_UpdateTrainAndFlyCorridorParallaxRows` routine. Its inner loop repeats
four selected scroll values across 48 raster rows. Flying Neo's approach and
encounter states retain separate lifecycle names instead of conflating scroll,
asset submission, and recurring vertical oscillation.

All 30 imported definitions in the module now have exact-address static audit
records. The twelve formerly address-derived definitions gain provenance,
raising provenance from 14,018 to 14,030 and the audit registry from 11,572
to 11,602. The enforced live address-derived ceiling falls from 2,033 to
2,021; only 44 address-derived definitions remain outside data modules and
include files.

The transition-message boundary follow-up names the final live address-derived
definition in `ui/stage_transition_messages.s`. The zero-length alias at
`$01E6C6` is the exclusive end of the extracted Train/Bugmax message stream
and shares the following post-Flying-Neo sequence's start address. It gains an
exact-address provenance mapping; its evidence is folded into the existing
audit record for the shared address, so the registry remains at 11,602 while
provenance rises to 14,031. The enforced live address-derived ceiling falls
from 2,021 to 2,020.

The player scripted-input pass corrects the ownership of
`cutscenes/stage_intros.s`: all 28 dispatch entries operate on the player
record and synthesize controller input or control player motion. The coherent
357-line state machine therefore moves to
`player/scripted_input_sequences.s`. Static producers identify the post-Shiper,
post-Terobuster, post-Bugmax, Flying Neo, Xi-Tiger, Viblack, post-Jampan, and
Stage 20 sequences without treating the whole module as a generic cutscene
bucket.

The audit rejects two particularly misleading generated identities. The three
former `Enemy_Stage14Debris` handlers access no enemy object or debris data;
they form the post-Bugmax player run. `Boss_SireneShootPattern2` is selected by
Stage 8, Seven Forces, and Z-Leo code in addition to Sirene and only forces the
player to face right before conditionally emitting Up+C. All 49 definitions in
the range now have exact-address static audit coverage. Eighteen raw branch and
return labels gain provenance, raising the mapping count from 14,031 to 14,049
and the audit registry from 11,602 to 11,647. The enforced address-derived
ceiling falls from 2,020 to 2,002; only 25 such definitions remain outside data
modules and `ram_addrs.inc`.

The shared proximity/hazard pass removes the last address-derived definitions
from executable source and corrects a false module boundary. The former
`bosses/jetsripper_combat.s` range is not the Jetsripper boss core: the actual
core begins later at `Boss_JetsripperMainHandler` in
`bosses/jetsripper_core.s`. Its first fourteen lines are instead the mapping
selector used by Wolf Garopa's orb-projectile pair and now finish the adjacent
`projectiles/directional_and_gravity_shots.s` module. The remaining cohesive
286-line range becomes `projectiles/proximity_and_falling_hazards.s`.

The dispatch table proves handlers for object types `$48`, `$84`, `$104`,
`$108`, `$1D0`, and `$2B4`. Static flow identifies the type-`$48` proximity
object's optional large-pickup spawn and short-lived type-`$C4` conversion;
type-`$84` gravity bounce; the type-`$104` difficulty-timed falling-hazard
spawner and type-`$108` collision handler; the type-`$1D0` arcing hazard and
its repeated type-`$188` trail; and the type-`$2B4` oscillating contact
hazard. The runtime scenario still observes type `$48` at its pinned Stage 1
checkpoint, but that observation no longer misidentifies this generic handler
as Jetsripper's later boss core.

The 25 formerly address-derived definitions gain provenance, raising the
mapping count from 14,049 to 14,074. Thirty-five definitions in the corrected
ROM range plus the shared type-`$C4` conversion helper receive new exact-address
audit records, taking the registry from 11,647 to 11,683. The enforced
address-derived ceiling falls from 2,002 to 1,977: the remaining definitions
are confined to 831 RAM equates and 1,146 preserved-data labels, with none left
in executable source.

The first player-art pass replaces the first 80 address-derived definitions in
`data/player_sprite_art.s`: 40 uncompressed art-segment starts and their 40
exclusive-end aliases. This is not a visual guess. The already audited
`Player_PhoenixDashAttackSpriteMapping` and directional-primary mapping family
reference every segment directly, so each start is named by its exact mapping
and piece index. The original address-based segment names remain on both starts
and ends as provenance markers; the binary paths remain unchanged because they
are pinned extraction artifacts.

The 40 segment-start addresses receive static audit records. Their end aliases
share the following segment boundaries and are folded into the address-keyed
audit rather than creating duplicate-address records. Provenance rises from
14,074 to 14,154 mappings, the audit registry from 11,683 to 11,723, and the
enforced address-derived ceiling falls from 1,977 to 1,897. The remaining
backlog comprises 831 RAM equates and 1,066 preserved-data labels.

The completed player-art pass names the other 246 segment starts and their 246
exclusive-end aliases, leaving `data/player_sprite_art.s` with zero live
address-derived definitions. Of those segments, 218 are referenced directly
by one or more of the 68 audited player sprite mappings. Their names preserve
the first exact mapping and piece index; reuse by later mappings remains visible
in the mapping source rather than being hidden behind an invented visual pose.

The final 28 segments form the contiguous tail after the last piece referenced
by `player_sprite_mappings.s`, but they are not unreferenced. A full-source
assembly check caught that incomplete local classification before commit.
Twenty-four are the three eight-direction art sets selected by the audited
circle-attack frame tables; the other four are distinct DMA sources in the
audited weapon-state icon table. Their corrected names state those exact table
and index relationships without guessing the rendered image. All original
extraction filenames and all start/end names remain available through the
pinned binary paths and provenance markers.

The second pass adds 492 provenance mappings and 246 unique-address audit
records; end aliases share their following boundaries and are not duplicated
in the address-keyed registry. Provenance rises from 14,154 to 14,646 mappings,
the audit registry from 11,723 to 11,969, and the enforced address-derived
ceiling falls from 1,897 to 1,405. The remaining backlog comprises 831 RAM
equates and 574 preserved-data labels.

The credits-scene asset pass removes all 90 address-derived definitions from
`data/credits_scene_assets.s`. The twenty numbered scene asset-load lists prove
the nonsequential ROM ownership of twenty compressed tile-art sources and
twenty mapping-data sources. Their source names now follow the scene number
rather than their address, so the relationship visible in
`credits/palette_data.s` is also visible at each asset boundary.

The two special lists prove four Treasure-scene sources and two Sega-scene
sources. No character, background, or visual-subject identity is inferred from
the bytes. All 46 source addresses receive static audit records; the 44
exclusive-end aliases share the next asset boundary and retain provenance
without duplicate address records. Provenance rises from 14,646 to 14,736,
the audit registry from 11,969 to 12,015, and the enforced address-derived
ceiling falls from 1,405 to 1,315. The remaining backlog comprises 831 RAM
equates and 484 preserved-data labels.

The Xi-Tiger and boss-art pass removes all 56 address-derived definitions from
`data/xi_tiger_and_boss_art.s`. The Xi-Tiger transition's audited descriptor
list and display-object initializer prove its tile-art source, two mapping-data
sources, and three-piece sprite mapping. The remaining compressed sources are
named from their direct audited graphics-load lists: named bosses, neutral
entity types `$1C0/$3EC/$3F0/$3F4/$3FC`, the shared teleport load, and Stage 20.

Wolf Garopa and Z-Leo each retain numbered tile-art sources because their load
lists contain two independent compressed streams; no unsupported visual split
is asserted. Epsilon-1's source is also reused by the Stage 17 tile commands,
and the Stage 20 source is reused by its preserved reload list. The 29 unique
source addresses receive static audit records, while 27 exclusive-end aliases
retain provenance without duplicate address entries. Provenance rises from
14,736 to 14,792, the audit registry from 12,015 to 12,044, and the enforced
address-derived ceiling falls from 1,315 to 1,259. The remaining backlog is 831
RAM equates and 428 preserved-data labels.
