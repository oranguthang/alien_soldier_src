; Shield Viper sprite mappings followed by the adjacent Missiray bullet animation family
; Frame suffixes preserve ROM order without guessing unverified poses

Boss_ShieldViperSpriteFrame00:  dc.w    $C84E, $F00, $F0F0  ; DATA XREF: ROM:Boss_ShieldViperBodyInitializationRecords   o  ; was: word_ECF76
                                        ; ROM:0004E1E8   o
Boss_ShieldViperSpriteFrame01:  dc.w    $C85E, $F00, $EEF2  ; DATA XREF: ROM:0004F5A0   o  ; was: word_ECF7C
                                        ; ROM:0004F5C0   o
Boss_ShieldViperSpriteFrame02:  dc.w    $C86E, $F00, $F0F0  ; DATA XREF: ROM:0004F5A8   o  ; was: word_ECF82
                                        ; ROM:0004F5C8   o
Boss_ShieldViperSpriteFrame03:  dc.w    $C87E, $F00, $EEEE  ; DATA XREF: ROM:0004F5B0   o  ; was: word_ECF88
                                        ; ROM:0004F5D0   o

Boss_ShieldViperSpriteFrame04:  dc.w    $5800, $500, 8  ; DATA XREF: Boss_ShieldViperInitialize+4E   o  ; was: word_ECF8E
                                        ; ROM:Boss_ShieldViperControllerAngularMappingRecords   o
                dc.w    $5804, $E00, $E8
                dc.w    $4804, $E00, $E8E8
                dc.w    $C800, $500, $F008
Boss_ShieldViperSpriteFrame05:  dc.w    $4824, $200, $F10F  ; DATA XREF: ROM:0004F560   o  ; was: word_ECFA6
                                        ; ROM:0004F580   o
                dc.w    $4820, $C00, $E9F7
                dc.w    $C810, $F00, $F1EF
Boss_ShieldViperSpriteFrame06:  dc.w    $402B, $B00, $F8E8  ; DATA XREF: ROM:0004F568   o  ; was: word_ECFB8
                                        ; ROM:0004F588   o
                dc.w    $4027, $500, $E8F0
                dc.w    $4827, $500, $E800
                dc.w    $C82B, $B00, $F800
Boss_ShieldViperSpriteFrame07:  dc.w    $484B, $200, $F1E9  ; DATA XREF: ROM:0004F570   o  ; was: word_ECFD0
                                        ; ROM:0004F590   o
                dc.w    $4847, $C00, $E9E9
                dc.w    $C837, $F00, $F1F1
Boss_ShieldViperSpriteFrame08:  dc.w    $C88E, $500, $F8F8  ; DATA XREF: ROM:0004E270   o  ; was: word_ECFE2
                                        ; ROM:0004E278   o
Boss_ShieldViperSpriteFrame09:  dc.w    $C892, $500, $F8F8  ; DATA XREF: ROM:0004E280   o  ; was: word_ECFE8
                                        ; ROM:0004E288   o
Boss_ShieldViperSpriteFrame10:  dc.w    $C896, $500, $F8F8  ; DATA XREF: ROM:0004E290   o  ; was: word_ECFEE
                                        ; ROM:0004E298   o
Boss_ShieldViperSpriteFrame11:  dc.w    $C89A, 0, $FCFC  ; DATA XREF: Projectile_InitShieldViperOrbitShot+18   o  ; was: word_ECFF4
                                        ; ROM:Projectile_ShieldViperOrbitShotAnimationRecords   o
Boss_ShieldViperSpriteFrame12:  dc.w    $C89B, $500, $F8F8  ; DATA XREF: Boss_ShieldViperInitialize+124   o  ; was: word_ECFFA
                                        ; ROM:0004F166   o
Boss_ShieldViperSpriteFrame13:  dc.w    $C89F, $A00, $F4F4  ; DATA XREF: ROM:0004F16E   o  ; was: word_ED000
Boss_ShieldViperSpriteFrame14:  dc.w    $C8A8, $F00, $F0F0  ; DATA XREF: ROM:0004F176   o  ; was: word_ED006
Boss_ShieldViperSpriteFrame15:  dc.w    $C8B8, $F00, $F0F0  ; DATA XREF: ROM:0004F17E   o  ; was: word_ED00C
Boss_ShieldViperSpriteFrame16:  dc.w    $C8C8, $F00, $F0F0  ; DATA XREF: ROM:0004F186   o  ; was: word_ED012
Boss_ShieldViperSpriteFrame17:  dc.w    $C8D8, $F00, $F0F0  ; DATA XREF: ROM:0004F18E   o  ; was: word_ED018
Boss_ShieldViperSpriteFrame18:  dc.w    $C8E8, $F00, $F0F0  ; DATA XREF: ROM:0004F196   o  ; was: word_ED01E
                                        ; ROM:0004F19E   o
; ---------------------------------------------------------------------------
; Missiray bullet frames and relative-offset animation streams
Projectile_MissirayBulletSpriteFrame00: dc.w    $6038, $500, $FA00  ; DATA XREF: ROM:Projectile_MissirayBulletInitialSpriteAnimation   o  ; was: word_ED024
                                        ; ROM:Projectile_MissirayBulletTransformSpriteAnimation   o
                dc.w    $E838, $500, $FAF0
Projectile_MissirayBulletSpriteFrame01: dc.w    $483C, $D00, $FBD0  ; DATA XREF: ROM:Projectile_MissirayBulletLoopSpriteAnimation   o  ; was: word_ED030
                dc.w    $483C, $D00, $FBF0
                dc.w    $483C, $D00, $FB10
                dc.w    $6038, $500, $FA30
                dc.w    $E838, $500, $FAC0
Projectile_MissirayBulletSpriteFrame02: dc.w    $583C, $D00, $F5D0  ; DATA XREF: ROM:000ED142   o  ; was: word_ED04E
                dc.w    $583C, $D00, $F6F0
                dc.w    $583C, $D00, $F510
                dc.w    $6038, $500, $FA30
                dc.w    $E838, $500, $FAC0
Projectile_MissirayBulletSpriteFrame03: dc.w    $403C, $D00, $FBD0  ; DATA XREF: ROM:000ED14A   o  ; was: word_ED06C
                dc.w    $403C, $D00, $FBF0
                dc.w    $403C, $D00, $FB10
                dc.w    $6038, $500, $FA30
                dc.w    $E838, $500, $FAC0
Projectile_MissirayBulletSpriteFrame04: dc.w    $503C, $D00, $F6D0  ; DATA XREF: ROM:000ED146   o  ; was: word_ED08A
                dc.w    $503C, $D00, $F7F0
                dc.w    $503C, $D00, $F610
                dc.w    $6038, $500, $FA30
                dc.w    $E838, $500, $FAC0
Projectile_MissirayBulletSpriteFrame05: dc.w    $6838, $500, $FAE4  ; DATA XREF: ROM:000ED15E   o  ; was: word_ED0A8
                dc.w    $6038, $500, $FA0C
                dc.w    $C83C, $D00, $FAF0
Projectile_MissirayBulletSpriteFrame06: dc.w    $6838, $500, $FADC  ; DATA XREF: ROM:000ED162   o  ; was: word_ED0BA
                dc.w    $403C, $D00, $FAE6
                dc.w    $6038, $500, $FA14
                dc.w    $C83C, $D00, $FAFA
Projectile_MissirayBulletSpriteFrame07: dc.w    $6838, $500, $FAD4  ; DATA XREF: ROM:000ED166   o  ; was: word_ED0D2
                dc.w    $483C, $D00, $FAE0
                dc.w    $6038, $500, $FA1C
                dc.w    $C03C, $D00, $FA00
Projectile_MissirayBulletSpriteFrame08: dc.w    $483C, $D00, $FAF0  ; DATA XREF: ROM:000ED16A   o  ; was: word_ED0EA
                dc.w    $6838, $500, $FACC
                dc.w    $483C, $D00, $FAD7
                dc.w    $6038, $500, $FA24
                dc.w    $C03C, $D00, $FA09
Projectile_MissirayBulletSpriteFrame09: dc.w    $583C, $D00, $F5F0  ; DATA XREF: ROM:000ED16E   o  ; was: word_ED108
                dc.w    $6838, $500, $FAC4
                dc.w    $403C, $D00, $FAD0
                dc.w    $6038, $500, $FA2C
                dc.w    $C83C, $D00, $FA10
Projectile_MissirayBulletSpriteFrame10: dc.w    $6838, $500, $FAEB  ; DATA XREF: ROM:000ED15A   o  ; was: word_ED126
                dc.w    $6038, $500, $FA05
                dc.w    $C83C, $D00, $FAF0
                dc.w    $E837, 0, $1FFF
Projectile_MissirayBulletLoopSpriteAnimation:   dc.w    Projectile_MissirayBulletSpriteFrame01-*  ; DATA XREF: Projectile_MissirayBulletWaitForTransformFrame+8   o  ; was: off_ED13E
                                        ; ROM:000ED14E   o
                dc.w    1
                dc.w    Projectile_MissirayBulletSpriteFrame02-*
                dc.w    1
                dc.w    Projectile_MissirayBulletSpriteFrame04-*
                dc.w    1
                dc.w    Projectile_MissirayBulletSpriteFrame03-*
                dc.w    1
                dc.w    Projectile_MissirayBulletLoopSpriteAnimation-*
                dc.w    0
Projectile_MissirayBulletInitialSpriteAnimation:    dc.w    Projectile_MissirayBulletSpriteFrame00-*  ; DATA XREF: Projectile_InitMissirayBullet+4   o  ; was: off_ED152
                dc.w    $FF
Projectile_MissirayBulletTransformSpriteAnimation:  dc.w    Projectile_MissirayBulletSpriteFrame00-*  ; DATA XREF: Projectile_MissirayBulletTransform+6   o  ; was: off_ED156
                dc.w    1
                dc.w    Projectile_MissirayBulletSpriteFrame10-*
                dc.w    1
                dc.w    Projectile_MissirayBulletSpriteFrame05-*
                dc.w    1
                dc.w    Projectile_MissirayBulletSpriteFrame06-*
                dc.w    1
                dc.w    Projectile_MissirayBulletSpriteFrame07-*
                dc.w    1
                dc.w    Projectile_MissirayBulletSpriteFrame08-*
                dc.w    1
                dc.w    Projectile_MissirayBulletSpriteFrame09-*
                dc.w    $FF
