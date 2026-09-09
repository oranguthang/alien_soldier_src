word_ECF8E:     dc.w    $5800, $500, 8                  ; DATA XREF: Boss_ShieldViperInitialize+4E   o
                                        ; ROM:Boss_ShieldViperControllerAngularMappingRecords   o
                dc.w    $5804, $E00, $E8
                dc.w    $4804, $E00, $E8E8
                dc.w    $C800, $500, $F008
word_ECFA6:     dc.w    $4824, $200, $F10F              ; DATA XREF: ROM:0004F560   o
                                        ; ROM:0004F580   o
                dc.w    $4820, $C00, $E9F7
                dc.w    $C810, $F00, $F1EF
word_ECFB8:     dc.w    $402B, $B00, $F8E8              ; DATA XREF: ROM:0004F568   o
                                        ; ROM:0004F588   o
                dc.w    $4027, $500, $E8F0
                dc.w    $4827, $500, $E800
                dc.w    $C82B, $B00, $F800
word_ECFD0:     dc.w    $484B, $200, $F1E9              ; DATA XREF: ROM:0004F570   o
                                        ; ROM:0004F590   o
                dc.w    $4847, $C00, $E9E9
                dc.w    $C837, $F00, $F1F1
word_ECFE2:     dc.w    $C88E, $500, $F8F8              ; DATA XREF: ROM:0004E270   o
                                        ; ROM:0004E278   o
word_ECFE8:     dc.w    $C892, $500, $F8F8              ; DATA XREF: ROM:0004E280   o
                                        ; ROM:0004E288   o
word_ECFEE:     dc.w    $C896, $500, $F8F8              ; DATA XREF: ROM:0004E290   o
                                        ; ROM:0004E298   o
word_ECFF4:     dc.w    $C89A, 0, $FCFC                 ; DATA XREF: Projectile_InitShieldViperOrbitShot+18   o
                                        ; ROM:Projectile_ShieldViperOrbitShotAnimationRecords   o
word_ECFFA:     dc.w    $C89B, $500, $F8F8              ; DATA XREF: Boss_ShieldViperInitialize+124   o
                                        ; ROM:0004F166   o
word_ED000:     dc.w    $C89F, $A00, $F4F4              ; DATA XREF: ROM:0004F16E   o
word_ED006:     dc.w    $C8A8, $F00, $F0F0              ; DATA XREF: ROM:0004F176   o
word_ED00C:     dc.w    $C8B8, $F00, $F0F0              ; DATA XREF: ROM:0004F17E   o
word_ED012:     dc.w    $C8C8, $F00, $F0F0              ; DATA XREF: ROM:0004F186   o
word_ED018:     dc.w    $C8D8, $F00, $F0F0              ; DATA XREF: ROM:0004F18E   o
word_ED01E:     dc.w    $C8E8, $F00, $F0F0              ; DATA XREF: ROM:0004F196   o
                                        ; ROM:0004F19E   o
word_ED024:     dc.w    $6038, $500, $FA00              ; DATA XREF: ROM:off_ED152   o
                                        ; ROM:off_ED156   o
                dc.w    $E838, $500, $FAF0
word_ED030:     dc.w    $483C, $D00, $FBD0              ; DATA XREF: ROM:off_ED13E   o
                dc.w    $483C, $D00, $FBF0
                dc.w    $483C, $D00, $FB10
                dc.w    $6038, $500, $FA30
                dc.w    $E838, $500, $FAC0
word_ED04E:     dc.w    $583C, $D00, $F5D0              ; DATA XREF: ROM:000ED142   o
                dc.w    $583C, $D00, $F6F0
                dc.w    $583C, $D00, $F510
                dc.w    $6038, $500, $FA30
                dc.w    $E838, $500, $FAC0
word_ED06C:     dc.w    $403C, $D00, $FBD0              ; DATA XREF: ROM:000ED14A   o
                dc.w    $403C, $D00, $FBF0
                dc.w    $403C, $D00, $FB10
                dc.w    $6038, $500, $FA30
                dc.w    $E838, $500, $FAC0
word_ED08A:     dc.w    $503C, $D00, $F6D0              ; DATA XREF: ROM:000ED146   o
                dc.w    $503C, $D00, $F7F0
                dc.w    $503C, $D00, $F610
                dc.w    $6038, $500, $FA30
                dc.w    $E838, $500, $FAC0
word_ED0A8:     dc.w    $6838, $500, $FAE4              ; DATA XREF: ROM:000ED15E   o
                dc.w    $6038, $500, $FA0C
                dc.w    $C83C, $D00, $FAF0
word_ED0BA:     dc.w    $6838, $500, $FADC              ; DATA XREF: ROM:000ED162   o
                dc.w    $403C, $D00, $FAE6
                dc.w    $6038, $500, $FA14
                dc.w    $C83C, $D00, $FAFA
word_ED0D2:     dc.w    $6838, $500, $FAD4              ; DATA XREF: ROM:000ED166   o
                dc.w    $483C, $D00, $FAE0
                dc.w    $6038, $500, $FA1C
                dc.w    $C03C, $D00, $FA00
word_ED0EA:     dc.w    $483C, $D00, $FAF0              ; DATA XREF: ROM:000ED16A   o
                dc.w    $6838, $500, $FACC
                dc.w    $483C, $D00, $FAD7
                dc.w    $6038, $500, $FA24
                dc.w    $C03C, $D00, $FA09
word_ED108:     dc.w    $583C, $D00, $F5F0              ; DATA XREF: ROM:000ED16E   o
                dc.w    $6838, $500, $FAC4
                dc.w    $403C, $D00, $FAD0
                dc.w    $6038, $500, $FA2C
                dc.w    $C83C, $D00, $FA10
word_ED126:     dc.w    $6838, $500, $FAEB              ; DATA XREF: ROM:000ED15A   o
                dc.w    $6038, $500, $FA05
                dc.w    $C83C, $D00, $FAF0
                dc.w    $E837, 0, $1FFF
off_ED13E:      dc.w    word_ED030-*                    ; DATA XREF: Projectile_MissirayBulletWaitForTransformFrame+8   o
                                        ; ROM:000ED14E   o
                dc.w    1
                dc.w    word_ED04E-*
                dc.w    1
                dc.w    word_ED08A-*
                dc.w    1
                dc.w    word_ED06C-*
                dc.w    1
                dc.w    off_ED13E-*
                dc.w    0
off_ED152:      dc.w    word_ED024-*                    ; DATA XREF: Projectile_InitMissirayBullet+4   o
                dc.w    $FF
off_ED156:      dc.w    word_ED024-*                    ; DATA XREF: Projectile_MissirayBulletTransform+6   o
                dc.w    1
                dc.w    word_ED126-*
                dc.w    1
                dc.w    word_ED0A8-*
                dc.w    1
                dc.w    word_ED0BA-*
                dc.w    1
                dc.w    word_ED0D2-*
                dc.w    1
                dc.w    word_ED0EA-*
                dc.w    1
                dc.w    word_ED108-*
                dc.w    $FF
