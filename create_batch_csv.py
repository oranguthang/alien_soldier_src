import csv

procedures = [
    # Z-Leo boss battle completion (22 procedures)
    ('sub_5294E', 'Z-Leo boss', '65160', 'Boss_ZLeoUpdateHeadPosition', 'Update head sprite positions', 'Boss', 'analyzed'),
    ('sub_528B2', 'Z-Leo boss', '65520', 'Boss_ZLeoUpdateBladeSprite', 'Update blade sprite', 'Boss', 'analyzed'),
    ('sub_528D8', 'Z-Leo boss', '65520', 'Boss_ZLeoUpdateWingSprites', 'Update wing sprites', 'Boss', 'analyzed'),
    ('sub_528FE', 'Z-Leo boss', '65520', 'Boss_ZLeoUpdateWingPositions', 'Calculate wing positions', 'Boss', 'analyzed'),
    ('sub_51FAA', 'Z-Leo boss', '65700', 'Boss_ZLeoBattleState1', 'Battle state 1 handler', 'Boss', 'analyzed'),
    ('sub_51FE8', 'Z-Leo boss', '65700', 'Boss_ZLeoBattleState2', 'Battle state 2 handler', 'Boss', 'analyzed'),
    ('sub_52766', 'Z-Leo boss', '65700', 'Boss_ZLeoEnableParts', 'Enable boss parts flags', 'Boss', 'analyzed'),
    ('sub_527DE', 'Z-Leo boss', '65700', 'Boss_ZLeoLoadDefeatTiles', 'Load defeat tiles', 'Graphics', 'analyzed'),
    ('sub_52028', 'Z-Leo boss', '65880', 'Boss_ZLeoDefeatCheck', 'Check defeat condition', 'Boss', 'analyzed'),
    ('sub_530EE', 'Z-Leo boss', '66060', 'Boss_ZLeoSpawnLaser', 'Spawn laser projectile', 'Boss', 'analyzed'),
    ('sub_53182', 'Z-Leo boss', '66060', 'Projectile_ZLeoLaserMain', 'Laser projectile main', 'Projectile', 'analyzed'),
    ('sub_5228A', 'Z-Leo boss', '66240', 'Boss_ZLeoAttackState1', 'Attack state 1 handler', 'Boss', 'analyzed'),
    ('sub_52F32', 'Z-Leo boss', '66240', 'Boss_ZLeoSpawnOrb', 'Spawn orb projectile', 'Boss', 'analyzed'),
    ('sub_5305A', 'Z-Leo boss', '66240', 'Projectile_ZLeoOrbMain', 'Orb projectile main', 'Projectile', 'analyzed'),
    ('sub_521C2', 'Z-Leo boss', '66600', 'Boss_ZLeoAttackPattern1', 'Attack pattern 1 handler', 'Boss', 'analyzed'),
    ('sub_52046', 'Z-Leo boss', '66780', 'Boss_ZLeoAttackPattern2', 'Attack pattern 2 handler', 'Boss', 'analyzed'),
    ('sub_527F2', 'Z-Leo boss', '66780', 'Boss_ZLeoAnimationUpdate1', 'Animation update handler 1', 'Boss', 'analyzed'),
    ('sub_529CE', 'Z-Leo boss', '66780', 'Boss_ZLeoAnimationUpdate2', 'Animation update handler 2', 'Boss', 'analyzed'),
    ('sub_52A54', 'Z-Leo boss', '66780', 'Boss_ZLeoAnimationUpdate3', 'Animation update handler 3', 'Boss', 'analyzed'),
    ('sub_22466', 'Z-Leo boss', '66960', 'Boss_ZLeoPaletteEffect1', 'Palette effect handler 1', 'Boss', 'analyzed'),
    ('sub_2249A', 'Z-Leo boss', '66960', 'Boss_ZLeoPaletteEffect2', 'Palette effect handler 2', 'Boss', 'analyzed'),
    ('sub_223E2', 'Z-Leo boss', '66960', 'Boss_ZLeoPaletteUpdate', 'Palette update handler', 'Boss', 'analyzed'),
    # Credits and ending (14 procedures)
    ('sub_16A4A', 'Credits', '75180', 'Credits_VBlankHandler', 'VBlank handler for credits', 'Credits', 'analyzed'),
    ('sub_22216', 'Credits', '83520', 'Credits_PaletteInit', 'Initialize credits palette', 'Credits', 'analyzed'),
    ('sub_2257C', 'Credits', '83520', 'Credits_UpdateTilemap', 'Update credits tilemap', 'Credits', 'analyzed'),
    ('sub_2222E', 'Credits', '83700', 'Credits_ScrollUpdate1', 'Credits scroll update 1', 'Credits', 'analyzed'),
    ('sub_22262', 'Credits', '83700', 'Credits_ScrollUpdate2', 'Credits scroll update 2', 'Credits', 'analyzed'),
    ('sub_22278', 'Credits', '83700', 'Credits_ScrollUpdate3', 'Credits scroll update 3', 'Credits', 'analyzed'),
    ('sub_22296', 'Credits', '83700', 'Credits_ScrollUpdate4', 'Credits scroll update 4', 'Credits', 'analyzed'),
    ('sub_222BA', 'Credits', '83700', 'Credits_ScrollUpdate5', 'Credits scroll update 5', 'Credits', 'analyzed'),
    ('sub_222DE', 'Credits', '83700', 'Credits_UpdateGraphics1', 'Credits graphics update 1', 'Credits', 'analyzed'),
    ('sub_222FA', 'Credits', '83700', 'Credits_UpdateGraphics2', 'Credits graphics update 2', 'Credits', 'analyzed'),
    ('sub_2230A', 'Credits', '83700', 'Credits_UpdateGraphics3', 'Credits graphics update 3', 'Credits', 'analyzed'),
    ('sub_2231A', 'Credits', '83700', 'Credits_UpdateGraphics4', 'Credits graphics update 4', 'Credits', 'analyzed'),
    ('sub_2232E', 'Credits', '83700', 'Credits_LoadTiles', 'Load credits tiles', 'Credits', 'analyzed'),
    ('sub_223CC', 'Credits', '83700', 'Credits_FadeOut', 'Credits fade out effect', 'Credits', 'analyzed'),
    ('sub_20ECC', 'Xi-Tiger (credits)', '83880', 'Credits_XiTigerVBlankSync', 'Xi-Tiger VBlank sync', 'Credits', 'analyzed'),
    ('sub_212D4', 'Computer designed by Treasure', '87840', 'Credits_TreasureScreen1', 'Treasure screen handler 1', 'Credits', 'analyzed'),
    ('sub_2130A', 'Computer designed by Treasure', '87840', 'Credits_TreasureScreen2', 'Treasure screen handler 2', 'Credits', 'analyzed'),
    ('sub_213F2', 'Presented by Sega', '88380', 'Credits_SegaScreen', 'Sega presentation screen', 'Credits', 'analyzed'),
    # Results screen (5 procedures)
    ('sub_4386', 'Results', '89100', 'Results_UpdateNumbers', 'Update result numbers', 'Results', 'analyzed'),
    ('sub_1DEA4', 'Results', '89100', 'Results_DisplayTime', 'Display completion time', 'Results', 'analyzed'),
    ('sub_1DECC', 'Results', '89100', 'Results_DisplayScore', 'Display score value', 'Results', 'analyzed'),
    ('sub_1DF0E', 'Results', '89100', 'Results_DisplayContinues', 'Display continues used', 'Results', 'analyzed'),
    ('sub_1DF24', 'Results', '89100', 'Results_DisplayBonus', 'Display bonus points', 'Results', 'analyzed'),
    # Miscellaneous final procedures (3 procedures)
    ('sub_2CBC6', 'Jetstripper boss', '89100', 'Projectile_JetsripperFalling', 'Falling projectile handler', 'Projectile', 'analyzed'),
    ('sub_D3A6', 'Caterpillar stage', '17460', 'Stage_CaterpillarScrollHandler', 'Caterpillar scroll handler', 'Stage', 'analyzed'),
    ('sub_2F0CA', 'Xi-Tiger intro', '17460', 'Entity_XiTigerIntroStartState', 'Xi-Tiger intro start state', 'Entity', 'analyzed'),
]

with open('batch_analysis.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['old_name', 'scene', 'frame', 'new_name', 'description', 'category', 'status'])
    writer.writerows(procedures)

print(f'Created batch_analysis.csv with {len(procedures)} procedures')
print('FINAL BATCH - This completes the entire Alien Soldier disassembly project!')
