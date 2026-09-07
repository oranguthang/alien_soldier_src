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

Four especially broad data labels are explicitly registered:

| Symbol | ROM address | Evidence | Current statement |
|---|---:|---|---|
| `UnidentifiedSegaTilemap` | `0x0E8020` | hypothesis | 48 sequential tile words adjacent to the SEGA art; no live pointer has been found. |
| `UnidentifiedTilemapData` | `0x180000` | unknown | Tile-like words at the frontend asset boundary; no live pointer has been found. |
| `Credits_UnidentifiedTrailingData` | `0x0225CC` | unknown | Opaque block ending at the demo subsystem boundary; no live reference has been found, so neither purpose nor unused status is asserted. |
| `Stage11_UnidentifiedAsset` | `0x01AE96` | unknown | 314-byte asset selected by the Stage 11 configuration; its format and intended use are not established by a live consumer. |

Semantic names with `; was:` history are a second review queue. Their default
level is `hypothesis`, not `confirmed`; see `docs/provenance.md`.
