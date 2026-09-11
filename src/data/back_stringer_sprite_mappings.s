; Back Stringer part-angle, body-rotation, and projectile sprite mappings
Boss_BackStringerPartAngleMapping4: dc.w    $7836, $E00, $F8  ; was: word_EC2E6
                dc.w    $7842, $600, $E8
                dc.w    $6842, $600, $E8E8
                dc.w    $E836, $E00, $E8F8
Boss_BackStringerPartAngleMapping5: dc.w    $6868, $500, $8E8  ; was: word_EC2FE
                dc.w    $6860, $D00, $8F8
                dc.w    $6858, $700, $E8E8
                dc.w    $E848, $F00, $E8F8
Boss_BackStringerPartAngleMapping6: dc.w    $700C, $900, $E8E8  ; was: word_EC316
                dc.w    $7000, $B00, $F8E8
                dc.w    $780C, $900, $E800
                dc.w    $F800, $B00, $F800
Boss_BackStringerPartAngleMapping7: dc.w    $7032, $500, $E808  ; was: word_EC32E
                dc.w    $702A, $D00, $E8E8
                dc.w    $7022, $700, $F808
                dc.w    $F012, $F00, $F8E8
Boss_BackStringerPartAngleMapping0: dc.w    $7887, $D00, $F0  ; was: word_EC346
                dc.w    $E887, $D00, $F0F0
Boss_BackStringerPartAngleMapping1: dc.w    $689E, $500, $FEF2  ; was: word_EC352
                dc.w    $6898, $600, $E6F2
                dc.w    $688F, 0, $FE12
                dc.w    $E890, $700, $EE02
Boss_BackStringerPartAngleMapping2: dc.w    $706C, $700, $F0F0  ; was: word_EC36A
                dc.w    $F86C, $700, $F000
Boss_BackStringerPartAngleMapping3: dc.w    $7086, 0, $E6FE  ; was: word_EC376
                dc.w    $707E, $D00, $EEEE
                dc.w    $707A, $500, $FEFE
                dc.w    $F074, $900, $FEE6

Boss_BackStringerRotationMappingA0: dc.w    $E8A2, $800, $FCF4  ; was: word_EC38E
Boss_BackStringerRotationMappingA1: dc.w    $E8A5, $900, $F8F4  ; was: word_EC394
Boss_BackStringerRotationMappingA2: dc.w    $68AF, $400, $2F4  ; was: word_EC39A
                dc.w    $E8AB, $500, $F2FC
Boss_BackStringerRotationMappingA3: dc.w    $E8B1, $600, $F5FA  ; was: word_EC3A6
Boss_BackStringerRotationMappingA4: dc.w    $E8B7, $200, $F5FC  ; was: word_EC3AC
Boss_BackStringerRotationMappingA5: dc.w    $E0B1, $600, $F5F8  ; was: word_EC3B2
Boss_BackStringerRotationMappingA6: dc.w    $60AF, $400, $3FE  ; was: word_EC3B8
                dc.w    $E0AB, $500, $F3F6
Boss_BackStringerRotationMappingA7: dc.w    $E0A5, $900, $F8F5  ; was: word_EC3C4
                dc.w    $E0A2, $800, $FCF5
Boss_BackStringerRotationMappingC0: dc.w    $E8BA, $800, $FCF4  ; was: word_EC3D0
Boss_BackStringerRotationMappingC1: dc.w    $E8BD, $900, $F8F3  ; was: word_EC3D6
Boss_BackStringerRotationMappingC2: dc.w    $E8C3, $A00, $F4F4  ; was: word_EC3DC
Boss_BackStringerRotationMappingC3: dc.w    $E8CC, $600, $F3F9  ; was: word_EC3E2
Boss_BackStringerRotationMappingC4: dc.w    $E8D2, $200, $F4FC  ; was: word_EC3E8
Boss_BackStringerRotationMappingC5: dc.w    $E0CC, $600, $F3F7  ; was: word_EC3EE
Boss_BackStringerRotationMappingC6: dc.w    $E0C3, $A00, $F4F4  ; was: word_EC3F4
Boss_BackStringerRotationMappingC7: dc.w    $E0BD, $900, $F8F4  ; was: word_EC3FA
                dc.w    $E8BA, $800, $FCF4

Projectile_BackStringerFallingDropMapping:  dc.w    $E8D5, $A00, $F4F3  ; was: word_EC406
                dc.w    $E0D5, $A00, $F4F6
Projectile_BackStringerAngledShotMappingA:      dc.w    $E8EF, $F00, $F0F0  ; was: word_EC412
Projectile_BackStringerAngledShotMappingB:      dc.w    $E8FF, $A00, $F4F4  ; was: word_EC418
Projectile_BackStringerAngledShotMappingC:      dc.w    $E908, $500, $F8F8  ; was: word_EC41E
Projectile_BackStringerAngledShotMappingD:      dc.w    $E90C, 0, $FCFC  ; was: word_EC424
Projectile_BackStringerReboundShotAnimation:    dc.w    Projectile_BackStringerAngledShotMappingA-*  ; was: off_EC42A
                dc.w    3
                dc.w    Projectile_BackStringerAngledShotMappingB-*
                dc.w    3
                dc.w    Projectile_BackStringerAngledShotMappingC-*
                dc.w    2
                dc.w    Projectile_BackStringerAngledShotMappingD-*
                dc.w    1
                dc.w    Projectile_BackStringerAngledShotMappingD-*
                dc.w    $FF
