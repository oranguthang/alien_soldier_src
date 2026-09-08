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

Four especially broad data labels are explicitly registered:

| Symbol | ROM address | Evidence | Current statement |
|---|---:|---|---|
| `UnidentifiedSegaTilemap` | `0x0E8020` | hypothesis | 48 sequential tile words adjacent to the SEGA art; no live pointer has been found. |
| `UnidentifiedTilemapData` | `0x180000` | unknown | Tile-like words at the frontend asset boundary; no live pointer has been found. |
| `Credits_UnidentifiedTrailingData` | `0x0225CC` | unknown | Opaque block ending at the demo subsystem boundary; no live reference has been found, so neither purpose nor unused status is asserted. |
| `Stage11_UnidentifiedAsset` | `0x01AE96` | unknown | 314-byte asset selected by the Stage 11 configuration; its format and intended use are not established by a live consumer. |

Semantic names with `; was:` history are a second review queue. Their default
level is `hypothesis`, not `confirmed`; see `docs/provenance.md`.
