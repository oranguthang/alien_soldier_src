    cpu 68000
    page 0
    supmode on
    padding off


    include "src/macros.inc"
    include "src/ports.inc"
    include "src/equals.inc"
    include "src/ram_addrs.inc"

; ROM modules, strictly ordered by cartridge address.
    include "src/system/vectors_and_core.s"
    include "src/system/input_and_vblank_033fa.s"
    include "src/cutscenes/opening_08a7a.s"
    include "src/stages/stage_systems_0d714.s"
    include "src/rendering/background_and_scroll_10d16.s"
    include "src/gameplay/collision_and_player_13b2a.s"
    include "src/player/movement_and_damage_16f36.s"
    include "src/player/weapons_and_projectiles_1c16a.s"
    include "src/ui/results_and_transitions_20190.s"
    include "src/actors/enemies_and_boss_helpers_2a30e.s"
    include "src/actors/enemies_and_projectiles_2dbda.s"
    include "src/bosses/boss_code_31540.s"
    include "src/bosses/boss_code_35614.s"
    include "src/bosses/boss_code_3923e.s"
    include "src/bosses/boss_code_3d15a.s"
    include "src/bosses/boss_code_40ef0.s"
    include "src/bosses/boss_code_44c3c.s"
    include "src/bosses/boss_code_484e4.s"
    include "src/bosses/boss_code_4bd50.s"
    include "src/bosses/boss_code_4f64e.s"
    include "src/bosses/boss_code_535be.s"
    include "src/bosses/boss_code_570ec.s"
    include "src/bosses/boss_code_59866.s"
    include "src/sound/driver_82324.s"
    include "src/data/bank_0e8000.s"
    include "src/data/bank_180000.s"
