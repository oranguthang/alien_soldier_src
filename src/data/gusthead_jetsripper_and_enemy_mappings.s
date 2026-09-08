; Damageable terminal and ordinary-segment mappings for Gusthead's linked chain
Boss_GustheadLinkedChainTerminalMapping:    dc.w    $6010, $F00, $E0  ; DATA XREF: Boss_GustheadLinkedChainTerminalInit+C   o  ; was: word_EB338
                dc.w    $6000, $F00, $E0E0
                dc.w    $6810, $F00, 0
                dc.w    $E800, $F00, $E000
Boss_GustheadLinkedChainSegmentMapping: dc.w    $E820, $A00, $F4F4  ; DATA XREF: Boss_GustheadLinkedChainSegmentInit+C   o  ; was: word_EB350
word_EB356:                             dc.w    $6816, $700, $F4EA  ; DATA XREF: Stage11_RisingHazardLauncherInit+C   o
                dc.w    $6806, $F00, $F4FA
                dc.w    $6802, $C00, $ECF4
                dc.w    $E800, $400, $E402
word_EB36E:     dc.w    $4009, $A00, $E8                ; DATA XREF: Stage15_FallingRockInit+C   o
                dc.w    $4809, $A00, 0
                dc.w    $4000, $A00, $E8E8
                dc.w    $C800, $A00, $E800
word_EB386:     dc.w    $4812, $E00, $F600              ; DATA XREF: Stage15_FragmentEmitterInit+C   o
                dc.w    $C81E, $F00, $F0E0
word_EB392:     dc.w    $6804, $D00, $F0                ; DATA XREF: ROM:off_EB3C8   o
                dc.w    $6000, $500, $F0F0
                dc.w    $E800, $500, $F000
word_EB3A4:     dc.w    $680C, $D00, $F0                ; DATA XREF: ROM:000EB3CC   o
                dc.w    $6000, $500, $F0F0
                dc.w    $E800, $500, $F000
word_EB3B6:     dc.w    $6814, $D00, $F0                ; DATA XREF: ROM:000EB3D0   o
                dc.w    $6000, $500, $F0F0
                dc.w    $E800, $500, $F000
off_EB3C8:      dc.w    word_EB392-*                    ; DATA XREF: Enemy_FormationWaveInitMember+38   o
                                        ; ROM:000EB3D4   o
                dc.w    3
                dc.w    word_EB3A4-*
                dc.w    3
                dc.w    word_EB3B6-*
                dc.w    3
                dc.w    off_EB3C8-*
                dc.w    0
word_EB3D8:     dc.w    $6800, $700, $E5F8              ; DATA XREF: Projectile_InitMissirayFallingShot+6   o
                                        ; ROM:off_EB492   o
                dc.w    $E808, $700, $FAF8
word_EB3E4:     dc.w    $6800, $700, $E3F8              ; DATA XREF: ROM:000EB496   o
                dc.w    $E808, $700, $FCF8
word_EB3F0:     dc.w    $6800, $700, $E1F8              ; DATA XREF: ROM:000EB49A   o
                dc.w    $E808, $700, $FEF8
word_EB3FC:     dc.w    $6800, $700, $E0F8              ; DATA XREF: Projectile_InitRisingShotWaveMember+6   o
                                        ; Projectile_MissirayFallingShotDescend+14   o
                dc.w    $E808, $700, $FFF8
word_EB408:     dc.w    $6842, $D00, $5EF               ; DATA XREF: Enemy_InitStage11Fish+A   o
                                        ; Enemy_Stage11FishWaitForInnerEdgeState_Finish   o
                dc.w    $6810, $F00, $F600
                dc.w    $684A, $100, $5E7
                dc.w    $6820, $E00, $F6E0
                dc.w    $683A, $100, $E6DF
                dc.w    $682C, $400, $EEF
                dc.w    $E82E, $E00, $DEE7
word_EB432:     dc.w    $683A, $100, $E6DF              ; DATA XREF: Enemy_Stage11FishChoosePassState+24   o
                                        ; Enemy_Stage11FishBrakeInwardMotionState_Finish   o
                dc.w    $6852, $700, $5EF
                dc.w    $684C, $600, $5FF
                dc.w    $6820, $E00, $F6E0
                dc.w    $6810, $F00, $F600
                dc.w    $682C, $400, $EEF
                dc.w    $E82E, $E00, $DEE7
word_EB45C:     dc.w    $6860, $600, $F4ED              ; DATA XREF: Enemy_Stage11FishBrakeOutwardMotionState+28   o
                dc.w    $685A, $600, $FCFD
                dc.w    $6820, $E00, $F6E0
                dc.w    $6810, $F00, $F600
                dc.w    $683A, $100, $E6DF
                dc.w    $682C, $400, $EEF
                dc.w    $E82E, $E00, $DEE7
word_EB486:     dc.w    $683C, $C00, $F6                ; DATA XREF: Enemy_Stage11FishInitEmitterState+1C   o
                dc.w    $E840, $400, $F8F6
off_EB492:      dc.w    word_EB3D8-*                    ; DATA XREF: Projectile_MissirayFallingShotApplyGravity+1C   o
                dc.w    1
                dc.w    word_EB3E4-*
                dc.w    1
                dc.w    word_EB3F0-*
                dc.w    1
                dc.w    word_EB3FC-*
                dc.w    1
                dc.w    word_EB3FC-*
                dc.w    $FF
word_EB4A6:     dc.w    $603A, $600, $F4F0              ; DATA XREF: Stage18_SegmentedWormSpawnSegments+B8   o
                                        ; ROM:off_3007C   o
                dc.w    $E800, $A00, $F400
word_EB4B2:     dc.w    $6809, 0, $F313                 ; DATA XREF: ROM:00030088   o
                                        ; ROM:00030098   o
                dc.w    $6819, 0, $BFB
                dc.w    $6816, $800, $3F3
                dc.w    $E80A, $E00, $EBF3
word_EB4CA:     dc.w    $7823, $900, $F6                ; DATA XREF: ROM:00030084   o
                                        ; ROM:00030094   o
                dc.w    $E81A, $A00, $E8F6
word_EB4D6:     dc.w    $6838, 0, $FBED                 ; DATA XREF: ROM:00030080   o
                                        ; ROM:00030090   o
                dc.w    $6839, 0, $1305
                dc.w    $6835, $200, $F3F5
                dc.w    $E829, $B00, $F3FD
word_EB4EE:     dc.w    $603A, $600, $F4F0              ; DATA XREF: ROM:0003002C   o
                                        ; ROM:00030030   o
                dc.w    $E83A, $600, $F400
word_EB4FA:     dc.w    $6848, $800, $3F3               ; DATA XREF: ROM:000300C8   o
                                        ; ROM:000300D8   o
                dc.w    $E840, $D00, $F3F3
word_EB506:     dc.w    $7823, $900, $F6                ; DATA XREF: ROM:000300C4   o
                                        ; ROM:000300D4   o
                dc.w    $E823, $900, $F0F6
word_EB512:     dc.w    $6048, $800, $4F6               ; DATA XREF: ROM:000300C0   o
                                        ; ROM:000300D0   o
                dc.w    $E040, $D00, $F4EE
word_EB51E:     dc.w    $685D, 0, $F0F4                 ; DATA XREF: ROM:off_30028   o
                                        ; ROM:off_300FC   o
                dc.w    $E855, $D00, $F8EC
word_EB52A:     dc.w    $6866, 0, $BF7                  ; DATA XREF: ROM:00030108   o
                                        ; ROM:00030118   o
                dc.w    $6867, $200, $FBEF
                dc.w    $6864, $400, $3F7
                dc.w    $E85E, $900, $F3F7
word_EB542:     dc.w    $6854, 0, $2F0                  ; DATA XREF: ROM:00030104   o
                                        ; ROM:00030114   o
                dc.w    $E84C, $700, $F2F8
word_EB54E:     dc.w    $6872, 0, $F6ED                 ; DATA XREF: ROM:00030100   o
                                        ; ROM:00030110   o
                dc.w    $6873, $800, $EEED
                dc.w    $6870, $100, $F6F5
                dc.w    $E86A, $600, $F6FD
off_EB566:      dc.w    word_EB58C-*                    ; DATA XREF: Stage18_SegmentedWormEmitParticle+12   o
                dc.w    4
                dc.w    word_EB586-*
                dc.w    4
                dc.w    word_EB58C-*
                dc.w    4
                dc.w    word_EB586-*
                dc.w    4
                dc.w    word_EB58C-*
                dc.w    4
                dc.w    word_EB586-*
                dc.w    4
                dc.w    word_EB58C-*
                dc.w    4
                dc.w    word_EB58C-*
                dc.w    $FF
word_EB586:     dc.w    $8876, $500, $F8F8              ; DATA XREF: ROM:000EB56A   o
                                        ; ROM:000EB572   o
word_EB58C:     dc.w    $887A, 0, $FCFC                 ; DATA XREF: ROM:off_EB566   o
                                        ; ROM:000EB56E   o
word_EB592:     dc.w    $6812, $400, $FCE0              ; DATA XREF: Sprite_AdvanceToNextFrame   o
                dc.w    $780C, $600, $F0
                dc.w    $680C, $600, $E8F0
                dc.w    $7800, $E00, 0
                dc.w    $E800, $E00, $E800
word_EB5B0:     dc.w    $E814, $A00, $F4F4              ; DATA XREF: Sprite_AdvanceToNextFrame+5E   o
word_EB5B6:     dc.w    $2128, $600, $7F1               ; DATA XREF: ROM:off_3D37A   o
                dc.w    $2928, $600, $701
                dc.w    $2122, $600, $EFF1
                dc.w    $A922, $600, $EF01
word_EB5CE:     dc.w    $212E, $600, $7F1               ; DATA XREF: ROM:0003D37E   o
                                        ; ROM:0003D386   o
                dc.w    $292E, $600, $701
                dc.w    $2122, $600, $EFF1
                dc.w    $A922, $600, $EF01
