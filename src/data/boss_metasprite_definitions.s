; Antroid directional frames, child descriptors, radii, links, and neutral pose
Boss_AntroidPrimaryRotationFrames:  dc.l    Boss_AntroidSpriteMapping09  ; DATA XREF: ROM:000349CA   o  ; was: off_3494C
                                        ; ROM:000349D2   o
                dc.l    Boss_AntroidSpriteMapping08
                dc.l    Boss_AntroidSpriteMapping07
                dc.l    Boss_AntroidSpriteMapping06
                dc.l    Boss_AntroidSpriteMapping05
                dc.l    Boss_AntroidSpriteMapping04
                dc.l    Boss_AntroidSpriteMapping03
                dc.l    Boss_AntroidSpriteMapping02
Boss_AntroidSecondaryRotationFrames:    dc.l    Boss_AntroidSpriteMapping10  ; DATA XREF: ROM:000349D6   o  ; was: off_3496C
                                        ; ROM:000349EE   o
                dc.l    Boss_AntroidSpriteMapping11
                dc.l    Boss_AntroidSpriteMapping12
                dc.l    Boss_AntroidSpriteMapping13
                dc.l    Boss_AntroidSpriteMapping14
                dc.l    Boss_AntroidSpriteMapping15
                dc.l    Boss_AntroidSpriteMapping16
                dc.l    Boss_AntroidSpriteMapping17
Boss_AntroidInlineSpriteDescriptorA:        dc.w    $305, $F00, $F0F0  ; DATA XREF: ROM:000349BA   o  ; was: word_3498C
Boss_AntroidInlineSpriteDescriptorB:        dc.w    $325, $A00, $F4F4  ; DATA XREF: ROM:Boss_AntroidPrimaryMetaspriteDescriptors   o  ; was: word_34992
Boss_AntroidInlineSpriteDescriptorC:        dc.w    $315, $F00, $F0F0  ; DATA XREF: ROM:000349C2   o  ; was: word_34998
Boss_AntroidInlineSpriteDescriptorD:        dc.w    $337, $A00, $F4F4  ; DATA XREF: ROM:Boss_AntroidSecondaryMetaspriteDescriptors   o  ; was: word_3499E
Boss_AntroidInlineSpriteDescriptorE:        dc.w    $32E, $A00, $F4F4  ; DATA XREF: ROM:000349E2   o  ; was: word_349A4
Boss_AntroidInlineSpriteDescriptorF:        dc.w    $300, $500, $F8F8  ; DATA XREF: ROM:000349CE   o  ; was: word_349AA
Boss_AntroidInlineSpriteDescriptorG:        dc.w    $304, 0, $FCFC  ; DATA XREF: ROM:000349EA   o  ; was: word_349B0
Boss_AntroidPrimaryMetaspriteDescriptors:   dc.l    Boss_AntroidInlineSpriteDescriptorB+1  ; DATA XREF: Boss_AntroidInitPhase+E   o  ; was: off_349B6
                dc.l    Boss_AntroidInlineSpriteDescriptorA+1
                dc.l    Boss_AntroidSpriteMapping01+$400000
                dc.l    Boss_AntroidInlineSpriteDescriptorC+1
Boss_AntroidSecondaryMetaspriteDescriptors: dc.l    Boss_AntroidInlineSpriteDescriptorD+1  ; DATA XREF: Boss_AntroidInitPhase+28   o  ; was: off_349C6
                dc.l    Boss_AntroidPrimaryRotationFrames
                dc.l    Boss_AntroidInlineSpriteDescriptorF+1
                dc.l    Boss_AntroidPrimaryRotationFrames
                dc.l    Boss_AntroidSecondaryRotationFrames+$8000000
                dc.l    0
                dc.l    Boss_AntroidPrimaryRotationFrames
                dc.l    Boss_AntroidInlineSpriteDescriptorE+1
                dc.l    Boss_AntroidPrimaryRotationFrames
                dc.l    Boss_AntroidInlineSpriteDescriptorG+1
                dc.l    Boss_AntroidSecondaryRotationFrames-$18000000
Boss_AntroidPrimaryPartRadii:   dc.b    $00, $12, $14, $13  ; was: off_349F2
Boss_AntroidSecondaryPartRadii: dc.w    $80C, $D0C, $1A06  ; DATA XREF: Boss_AntroidInitPhase+2E   o  ; was: word_349F6
                dc.w    $101E, $1222, $600
Boss_AntroidPrimaryPartLinks:   dc.w    $C009, $C008, $4067  ; was: word_34A02
                                        ; DATA XREF: Boss_AntroidInitPhase+1A   o
                dc.w    $C009, $C064, $4185
                dc.w    $C1E4, $4245, $4244
                dc.w    $120, $4366, $C365
                dc.w    $4425, $C426, $44E5
Boss_AntroidSecondaryPartLinks: dc.w    $C069, $45AA, $C609  ; was: word_34A20
                                        ; DATA XREF: Boss_AntroidInitPhase+34   o
                dc.w    $466A, $4669, $120
                dc.w    $478A, $C789, $4849
                dc.w    $C84A, $4909
Boss_AntroidNeutralPose:    dc.w    $8080, $C080, $E090  ; was: word_34A36
                                        ; DATA XREF: Boss_AntroidBeginPoseInterpolation   o
                dc.w    $80E0, $9080, $8080
                dc.w    $8080, $8000
; Terobuster directional frames and metasprite definition
Boss_TerobusterPrimaryRotationFrames:   dc.l    Boss_TerobusterSpriteMapping07  ; DATA XREF: ROM:00034A90   o  ; was: off_34A46
                                        ; ROM:00034A98   o
                dc.l    Boss_TerobusterSpriteMapping06
                dc.l    Boss_TerobusterSpriteMapping05
                dc.l    Boss_TerobusterSpriteMapping04
                dc.l    Boss_TerobusterSpriteMapping03
                dc.l    Boss_TerobusterSpriteMapping02
                dc.l    Boss_TerobusterSpriteMapping01
                dc.l    Boss_TerobusterSpriteMapping00
Boss_TerobusterSecondaryRotationFrames: dc.l    Boss_TerobusterSpriteMapping08  ; DATA XREF: ROM:00034AA0   o  ; was: off_34A66
                                        ; ROM:00034AB4   o
                dc.l    Boss_TerobusterSpriteMapping09
                dc.l    Boss_TerobusterSpriteMapping10
                dc.l    Boss_TerobusterSpriteMapping11
                dc.l    Boss_TerobusterSpriteMapping12
                dc.l    Boss_TerobusterSpriteMapping13
                dc.l    Boss_TerobusterSpriteMapping14
                dc.l    Boss_TerobusterSpriteMapping15
Boss_TerobusterInlineSpriteDescriptor:  dc.w    $E35E, $F00, $F0F0  ; DATA XREF: ROM:00034A94   o  ; was: word_34A86
                                        ; ROM:00034AA8   o
Boss_TerobusterMetaspriteDescriptors:   dc.l    0       ; DATA XREF: Boss_TerobusterSetup+16   o  ; was: dword_34A8C
                dc.l    Boss_TerobusterPrimaryRotationFrames
                dc.l    Boss_TerobusterInlineSpriteDescriptor+1
                dc.l    Boss_TerobusterPrimaryRotationFrames
                dc.l    0
                dc.l    Boss_TerobusterSecondaryRotationFrames-$30000000
                dc.l    Boss_TerobusterPrimaryRotationFrames
                dc.l    Boss_TerobusterInlineSpriteDescriptor+1
                dc.l    Boss_TerobusterPrimaryRotationFrames
                dc.l    0
                dc.l    Boss_TerobusterSecondaryRotationFrames-$30000000
Boss_TerobusterPartRadii:   dc.w    $90, $A898, $A484   ; DATA XREF: Boss_TerobusterSetup+1C   o  ; was: word_34AB8
                dc.w    $1028, $1824, $400
Boss_TerobusterPartLinks:   dc.w    5, 3, 1             ; DATA XREF: Boss_TerobusterSetup+22   o  ; was: word_34AC4
                dc.w    $C3, $C0, $182
                dc.w    7, 5, $2A7
                dc.w    $2A0, $366
Boss_TerobusterNeutralPose: dc.w    $A080, $80A0, $8080  ; was: word_34ADA
                                        ; DATA XREF: Boss_TerobusterCalculateDeltas   o
; Shellshogun directional frames and metasprite definition
Boss_ShellshogunRotationFramesA:    dc.l    Boss_ShellshogunSpriteMapping26  ; DATA XREF: ROM:00034BE4   o  ; was: off_34AE0
                                        ; ROM:00034BEC   o
                dc.l    Boss_ShellshogunSpriteMapping25
                dc.l    Boss_ShellshogunSpriteMapping24
                dc.l    Boss_ShellshogunSpriteMapping23
                dc.l    Boss_ShellshogunSpriteMapping22
                dc.l    Boss_ShellshogunSpriteMapping21
                dc.l    Boss_ShellshogunSpriteMapping20
                dc.l    Boss_ShellshogunSpriteMapping19
Boss_ShellshogunRotationFramesB:    dc.l    Boss_ShellshogunSpriteMapping10  ; DATA XREF: ROM:00034C08   o  ; was: off_34B00
                dc.l    Boss_ShellshogunSpriteMapping09
                dc.l    Boss_ShellshogunSpriteMapping08
                dc.l    Boss_ShellshogunSpriteMapping07
                dc.l    Boss_ShellshogunSpriteMapping06
                dc.l    Boss_ShellshogunSpriteMapping05
                dc.l    Boss_ShellshogunSpriteMapping04
                dc.l    Boss_ShellshogunSpriteMapping03
Boss_ShellshogunRotationFramesC:    dc.l    Boss_ShellshogunSpriteMapping18  ; DATA XREF: ROM:00034BF0   o  ; was: off_34B20
                dc.l    Boss_ShellshogunSpriteMapping17
                dc.l    Boss_ShellshogunSpriteMapping16
                dc.l    Boss_ShellshogunSpriteMapping15
                dc.l    Boss_ShellshogunSpriteMapping14
                dc.l    Boss_ShellshogunSpriteMapping13
                dc.l    Boss_ShellshogunSpriteMapping12
                dc.l    Boss_ShellshogunSpriteMapping11
Boss_ShellshogunRotationFramesD:    dc.l    Boss_ShellshogunSpriteMapping19  ; DATA XREF: ROM:00034BB8   o  ; was: off_34B40
                                        ; ROM:00034BC0   o
                dc.l    Boss_ShellshogunSpriteMapping20
                dc.l    Boss_ShellshogunSpriteMapping21
                dc.l    Boss_ShellshogunSpriteMapping22
                dc.l    Boss_ShellshogunSpriteMapping23
                dc.l    Boss_ShellshogunSpriteMapping24
                dc.l    Boss_ShellshogunSpriteMapping25
                dc.l    Boss_ShellshogunSpriteMapping26
Boss_ShellshogunRotationFramesE:    dc.l    Boss_ShellshogunSpriteMapping03  ; DATA XREF: ROM:00034BDC   o  ; was: off_34B60
                dc.l    Boss_ShellshogunSpriteMapping04
                dc.l    Boss_ShellshogunSpriteMapping05
                dc.l    Boss_ShellshogunSpriteMapping06
                dc.l    Boss_ShellshogunSpriteMapping07
                dc.l    Boss_ShellshogunSpriteMapping08
                dc.l    Boss_ShellshogunSpriteMapping09
                dc.l    Boss_ShellshogunSpriteMapping10
Boss_ShellshogunRotationFramesF:    dc.l    Boss_ShellshogunSpriteMapping11  ; DATA XREF: ROM:00034BC4   o  ; was: off_34B80
                                        ; sub_39EE4   o
                dc.l    Boss_ShellshogunSpriteMapping12
                dc.l    Boss_ShellshogunSpriteMapping13
                dc.l    Boss_ShellshogunSpriteMapping14
                dc.l    Boss_ShellshogunSpriteMapping15
                dc.l    Boss_ShellshogunSpriteMapping16
                dc.l    Boss_ShellshogunSpriteMapping17
                dc.l    Boss_ShellshogunSpriteMapping18
Boss_ShellshogunInlineSpriteDescriptorA:    dc.w    $6457, $A00, $F4F4  ; DATA XREF: ROM:00034BD0   o  ; was: word_34BA0
                                        ; ROM:00034BFC   o
Boss_ShellshogunInlineSpriteDescriptorB:    dc.w    $6460, $500, $F8F8  ; DATA XREF: ROM:00034BBC   o  ; was: word_34BA6
                                        ; ROM:00034BD8   o
Boss_ShellshogunMetaspriteDescriptors:  dc.l    0       ; DATA XREF: Boss_ShellshogunSetupPhase+3C   o  ; was: dword_34BAC
                dc.l    Boss_ShellshogunSpriteMapping00+$400000
                dc.l    Boss_ShellshogunSpriteMapping02+$400000
                dc.l    Boss_ShellshogunRotationFramesD+$48000000
                dc.l    Boss_ShellshogunInlineSpriteDescriptorB+1
                dc.l    Boss_ShellshogunRotationFramesD+$48000000
                dc.l    Boss_ShellshogunRotationFramesF+$48000000
                dc.l    0
                dc.l    Boss_ShellshogunRotationFramesD+$48000000
                dc.l    Boss_ShellshogunInlineSpriteDescriptorA+1
                dc.l    Boss_ShellshogunRotationFramesD+$48000000
                dc.l    Boss_ShellshogunInlineSpriteDescriptorB+1
                dc.l    Boss_ShellshogunRotationFramesE+$48000000
                dc.l    Boss_ShellshogunSpriteMapping02+$400000
                dc.l    Boss_ShellshogunRotationFramesA-$30000000
                dc.l    Boss_ShellshogunInlineSpriteDescriptorB+1
                dc.l    Boss_ShellshogunRotationFramesA-$30000000
                dc.l    Boss_ShellshogunRotationFramesC-$30000000
                dc.l    0
                dc.l    Boss_ShellshogunRotationFramesA-$30000000
                dc.l    Boss_ShellshogunInlineSpriteDescriptorA+1
                dc.l    Boss_ShellshogunRotationFramesA-$30000000
                dc.l    Boss_ShellshogunInlineSpriteDescriptorB+1
                dc.l    Boss_ShellshogunRotationFramesB-$30000000
Boss_ShellshogunPartRadii:  dc.w    $22, $260C, $1A0C   ; DATA XREF: Boss_ShellshogunSetupPhase+42   o  ; was: word_34C0C
                dc.w    $1C18, $101E, $101C
                dc.w    $826, $C1A, $C1C
                dc.w    $1810, $1E10, $1C08
Boss_ShellshogunPartLinks:  dc.w    4, 4, 4             ; DATA XREF: Boss_ShellshogunSetupPhase+48   o  ; was: word_34C24
                dc.w    $C7, $C6, $185
                dc.w    $183, 4, $2AB
                dc.w    $2AA, $36A, $36B
                dc.w    $42B, 7, $4EA
                dc.w    $4E9, $5A8, $5A3
                dc.w    4, $6CD, $6CC
                dc.w    $78C, $78D, $84D
Boss_ShellshogunNeutralPose:    dc.w    $40, $6070, $40E0  ; DATA XREF: Boss_ShellshogunCalculatePoseDeltas   o  ; was: word_34C54
                dc.w    $8000, $4000, $7080
                dc.w    $E080, $A000
; Xi-Tiger directional frames and metasprite definition
Boss_XiTigerRotationFramesA:    dc.l    Boss_XiTigerSpriteMapping01  ; DATA XREF: ROM:00034D16   o  ; was: off_34C64
                                        ; ROM:00034D1E   o
                dc.l    Boss_XiTigerSpriteMapping02
                dc.l    Boss_XiTigerSpriteMapping03
                dc.l    Boss_XiTigerSpriteMapping04
                dc.l    Boss_XiTigerSpriteMapping05
                dc.l    Boss_XiTigerSpriteMapping06
                dc.l    Boss_XiTigerSpriteMapping07
                dc.l    Boss_XiTigerSpriteMapping08
Boss_XiTigerRotationFramesB:    dc.l    Boss_XiTigerSpriteMapping10  ; DATA XREF: ROM:00034D3E   o  ; was: off_34C84
                dc.l    Boss_XiTigerSpriteMapping11
                dc.l    Boss_XiTigerSpriteMapping12
                dc.l    Boss_XiTigerSpriteMapping13
                dc.l    Boss_XiTigerSpriteMapping14
                dc.l    Boss_XiTigerSpriteMapping15
                dc.l    Boss_XiTigerSpriteMapping16
                dc.l    Boss_XiTigerSpriteMapping17
Boss_XiTigerRotationFramesC:    dc.l    Boss_XiTigerSpriteMapping08  ; DATA XREF: ROM:00034D02   o  ; was: off_34CA4
                                        ; ROM:00034D0A   o
                dc.l    Boss_XiTigerSpriteMapping07
                dc.l    Boss_XiTigerSpriteMapping06
                dc.l    Boss_XiTigerSpriteMapping05
                dc.l    Boss_XiTigerSpriteMapping04
                dc.l    Boss_XiTigerSpriteMapping03
                dc.l    Boss_XiTigerSpriteMapping02
                dc.l    Boss_XiTigerSpriteMapping01
Boss_XiTigerRotationFramesD:    dc.l    Boss_XiTigerSpriteMapping17  ; DATA XREF: ROM:00034D56   o  ; was: off_34CC4
                dc.l    Boss_XiTigerSpriteMapping16
                dc.l    Boss_XiTigerSpriteMapping15
                dc.l    Boss_XiTigerSpriteMapping14
                dc.l    Boss_XiTigerSpriteMapping13
                dc.l    Boss_XiTigerSpriteMapping12
                dc.l    Boss_XiTigerSpriteMapping11
                dc.l    Boss_XiTigerSpriteMapping10
Boss_XiTigerInlineSpriteDescriptorA:    dc.w    $62D4, $500, $F8F8  ; DATA XREF: ROM:00034D3A   o  ; was: word_34CE4
                                        ; ROM:00034D52   o
Boss_XiTigerInlineSpriteDescriptorB:    dc.w    $62D8, $A00, $F4F4  ; DATA XREF: ROM:00034D06   o  ; was: word_34CEA
                                        ; ROM:00034D1A   o
Boss_XiTigerInlineSpriteDescriptorC:    dc.w    $62E1, $A00, $F4F4  ; DATA XREF: ROM:00034D32   o  ; was: word_34CF0
                                        ; ROM:00034D4A   o
Boss_XiTigerMetaspriteDescriptors:  dc.l    0           ; DATA XREF: Boss_XiTigerSetup+10   o  ; was: dword_34CF6
                dc.l    Boss_XiTigerGroundedBodyMapping+$400000
                dc.l    Boss_XiTigerSpriteMapping00+$400000
                dc.l    Boss_XiTigerRotationFramesC
                dc.l    Boss_XiTigerInlineSpriteDescriptorB+1
                dc.l    Boss_XiTigerRotationFramesC
                dc.l    0
                dc.l    Boss_XiTigerSpriteMapping00-$7C00000
                dc.l    Boss_XiTigerRotationFramesA+$18000000
                dc.l    Boss_XiTigerInlineSpriteDescriptorB+1-$8000000
                dc.l    Boss_XiTigerRotationFramesA+$18000000
                dc.l    0
                dc.l    Boss_XiTigerSpriteMapping09+$400000
                dc.l    0
                dc.l    Boss_XiTigerRotationFramesA+$18000000
                dc.l    Boss_XiTigerInlineSpriteDescriptorC+1
                dc.l    Boss_XiTigerRotationFramesC
                dc.l    Boss_XiTigerInlineSpriteDescriptorA+1
                dc.l    Boss_XiTigerRotationFramesB+$18000000
                dc.l    0
                dc.l    Boss_XiTigerRotationFramesA+$18000000
                dc.l    Boss_XiTigerInlineSpriteDescriptorC+1+$8000000
                dc.l    Boss_XiTigerRotationFramesA+$8000000
                dc.l    Boss_XiTigerInlineSpriteDescriptorA+1+$8000000
                dc.l    Boss_XiTigerRotationFramesD
Boss_XiTigerPartRadii:  dc.w    $E, $2E14, $2410        ; DATA XREF: Boss_XiTigerSetup+16   o  ; was: word_34D5A
                dc.w    $222C, $1424, $1022
                dc.w    $3214, $A1C, $E1C
                dc.w    $714, $A1C, $E1C
                dc.w    $700
Boss_XiTigerPartLinks:  dc.w    $8000, $8005, $8005     ; was: word_34D74
                                        ; DATA XREF: Boss_XiTigerSetup+1C   o
                dc.w    $80C5, $80C5, $8184
                dc.w    $8180, $8005, $82A5
                dc.w    $82A5, $8364, $8360
                dc.w    $8009, $8488, $84E7
                dc.w    $84E6, $85A7, $85A7
                dc.w    $8667, $8488, $8727
                dc.w    $8726, $87E7, $87E7
                dc.w    $88A7
Boss_XiTigerNeutralPose:    dc.w    $2060, $70C0, $80A0  ; was: word_34DA6
                                        ; DATA XREF: Boss_XiTigerBeginPoseInterpolation   o
                dc.w    $9080, $4000, $8000
                dc.w    $E040, $4080
; Madam Barbar directional frames and metasprite definition
Boss_MadamBarbarRotationFramesA:    dc.l    Boss_MadamBarbarSpriteMapping07  ; DATA XREF: ROM:00034E60   o  ; was: off_34DB6
                                        ; ROM:00034E78   o
                dc.l    Boss_MadamBarbarSpriteMapping06
                dc.l    Boss_MadamBarbarSpriteMapping04
                dc.l    Boss_MadamBarbarSpriteMapping01
                dc.l    Boss_MadamBarbarSpriteMapping02
                dc.l    Boss_MadamBarbarSpriteMapping00
                dc.l    Boss_MadamBarbarSpriteMapping03
                dc.l    Boss_MadamBarbarSpriteMapping05
Boss_MadamBarbarRotationFramesB:    dc.l    Boss_MadamBarbarSpriteMapping05  ; DATA XREF: ROM:00034E5C   o  ; was: off_34DD6
                                        ; ROM:00034E74   o
                dc.l    Boss_MadamBarbarSpriteMapping03
                dc.l    Boss_MadamBarbarSpriteMapping00
                dc.l    Boss_MadamBarbarSpriteMapping02
                dc.l    Boss_MadamBarbarSpriteMapping01
                dc.l    Boss_MadamBarbarSpriteMapping04
                dc.l    Boss_MadamBarbarSpriteMapping06
                dc.l    Boss_MadamBarbarSpriteMapping07
Boss_MadamBarbarRotationFramesC:    dc.l    Boss_MadamBarbarSpriteMapping08  ; DATA XREF: ROM:00034E94   o  ; was: off_34DF6
                                        ; ROM:00034E9C   o
                dc.l    Boss_MadamBarbarSpriteMapping09
                dc.l    Boss_MadamBarbarSpriteMapping10
                dc.l    Boss_MadamBarbarSpriteMapping11
                dc.l    Boss_MadamBarbarSpriteMapping12
                dc.l    Boss_MadamBarbarSpriteMapping13
                dc.l    Boss_MadamBarbarSpriteMapping14
                dc.l    Boss_MadamBarbarSpriteMapping15
Boss_MadamBarbarRotationFramesD:    dc.l    Boss_MadamBarbarSpriteMapping15  ; DATA XREF: ROM:00034E7C   o  ; was: off_34E16
                                        ; ROM:00034E84   o
                dc.l    Boss_MadamBarbarSpriteMapping14
                dc.l    Boss_MadamBarbarSpriteMapping13
                dc.l    Boss_MadamBarbarSpriteMapping12
                dc.l    Boss_MadamBarbarSpriteMapping11
                dc.l    Boss_MadamBarbarSpriteMapping10
                dc.l    Boss_MadamBarbarSpriteMapping09
                dc.l    Boss_MadamBarbarSpriteMapping08
Boss_MadamBarbarInlineSpriteDescriptorA:    dc.w    $6390, $F00, $F0F0  ; DATA XREF: ROM:00034E58   o  ; was: word_34E36
                                        ; ROM:00034E70   o
Boss_MadamBarbarInlineSpriteDescriptorB:    dc.w    $63A0, $A00, $F4F4  ; DATA XREF: ROM:00034E4C   o  ; was: word_34E3C
                                        ; ROM:00034E50   o
Boss_MadamBarbarInlineSpriteDescriptorC:    dc.w    $43C4, 0, $FCFC  ; DATA XREF: ROM:00034E80   o  ; was: word_34E42
                                        ; ROM:00034E8C   o
Boss_MadamBarbarMetaspriteDescriptors:  dc.l    0       ; DATA XREF: Boss_MadamBarbarSetupState+14   o  ; was: dword_34E48
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorB+1
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorB+1
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorB+1
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorA+1
                dc.l    Boss_MadamBarbarRotationFramesB
                dc.l    Boss_MadamBarbarRotationFramesA+$18000000
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorB+1
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorB+1
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorB+1
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorA+1
                dc.l    Boss_MadamBarbarRotationFramesB
                dc.l    Boss_MadamBarbarRotationFramesA+$18000000
                dc.l    Boss_MadamBarbarRotationFramesD
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorC+1
                dc.l    Boss_MadamBarbarRotationFramesD
                dc.l    Boss_MadamBarbarRotationFramesD
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorC+1
                dc.l    Boss_MadamBarbarRotationFramesD
                dc.l    Boss_MadamBarbarRotationFramesC+$18000000
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorC+1
                dc.l    Boss_MadamBarbarRotationFramesC+$18000000
                dc.l    Boss_MadamBarbarRotationFramesC+$18000000
                dc.l    Boss_MadamBarbarInlineSpriteDescriptorC+1
                dc.l    Boss_MadamBarbarRotationFramesC+$18000000
                dc.l    0
                dc.l    0
                dc.l    0
                dc.l    0
Boss_MadamBarbarPartRadii:  dc.w    $10, $C10, $121C    ; DATA XREF: Boss_MadamBarbarSetupState+1A   o  ; was: word_34EBC
                dc.w    $1C10, $C10, $121C
                dc.w    $1C06, $608, $606
                dc.w    $806, $608, $606
                dc.w    $80D, $D0D, $D00
Boss_MadamBarbarPartLinks:  dc.w    $8000, $8007, $8066  ; was: word_34EDA
                                        ; DATA XREF: Boss_MadamBarbarSetupState+20   o
                dc.w    $80C5, $8124, $184
                dc.w    $184, $8007, $82A6
                dc.w    $8305, $8364, $3C4
                dc.w    $3C4, 7, $4E6
                dc.w    $546, 7, $606
                dc.w    $666, 7, $726
                dc.w    $786, 7, $846
                dc.w    $8A6, $540, $660
                dc.w    $780, $8A0
Boss_MadamBarbarNeutralPose:    dc.w    $8080, $80, $80  ; DATA XREF: Boss_MadamBarbarCalculatePoseDeltas   o  ; was: word_34F14
                dc.w    $80, $8080, $8080
; Flying Neo directional frames and metasprite definition
Boss_FlyingNeoRotationFrames:   dc.l    word_EBBDC      ; DATA XREF: ROM:00034F4A   o  ; was: off_34F20
                                        ; ROM:00034F52   o
                dc.l    word_EBBE2
                dc.l    word_EBBE8
                dc.l    word_EBBEE
                dc.l    word_EBBF4
                dc.l    word_EBBFA
                dc.l    word_EBC00
                dc.l    word_EBC06
Boss_FlyingNeoInlineSpriteDescriptor:   dc.w    $6380, $600, $F8F4  ; DATA XREF: ROM:00034F4E   o  ; was: word_34F40
                                        ; ROM:00034F5E   o
Boss_FlyingNeoMetaspriteDescriptors:    dc.l    0       ; DATA XREF: Boss_FlyingNeoSetup+C   o  ; was: dword_34F46
                dc.l    Boss_FlyingNeoRotationFrames+$18000000
                dc.l    Boss_FlyingNeoInlineSpriteDescriptor+1
                dc.l    Boss_FlyingNeoRotationFrames+$18000000
                dc.l    word_EBC18+$8400000
                dc.l    Boss_FlyingNeoRotationFrames+$18000000
                dc.l    Boss_FlyingNeoInlineSpriteDescriptor+1
                dc.l    Boss_FlyingNeoRotationFrames+$18000000
                dc.l    word_EBC18+$8400000
Boss_FlyingNeoPartRadii:    dc.w    8, $1810, $1F08     ; DATA XREF: Boss_FlyingNeoSetup+12   o  ; was: word_34F6A
                dc.w    $1810, $1F00
Boss_FlyingNeoPartLinks:    dc.w    0, $8065, $C064     ; DATA XREF: Boss_FlyingNeoSetup+18   o  ; was: word_34F74
                dc.w    $8124, $8123, $806B
                dc.w    $C06A, $82AA, $82A9
Boss_FlyingNeoNeutralPose:  dc.w    $A0A0, $A0A0        ; DATA XREF: Boss_FlyingNeoBeginPoseInterpolation   o  ; was: word_34F86
; Joker directional frames and metasprite definition
Boss_JokerRotationFramesA:  dc.l    word_EBC24          ; DATA XREF: ROM:0003507E   o  ; was: off_34F8A
                                        ; ROM:00035086   o
                dc.l    word_EBC2A
                dc.l    word_EBC30
                dc.l    word_EBC36
                dc.l    word_EBC3C
                dc.l    word_EBC42
                dc.l    word_EBC48
                dc.l    word_EBC4E
Boss_JokerRotationFramesB:  dc.l    word_EBC4E          ; DATA XREF: ROM:0003505A   o  ; was: off_34FAA
                                        ; ROM:00035062   o
                dc.l    word_EBC48
                dc.l    word_EBC42
                dc.l    word_EBC3C
                dc.l    word_EBC36
                dc.l    word_EBC30
                dc.l    word_EBC2A
                dc.l    word_EBC24
Boss_JokerRotationFramesC:  dc.l    word_EBC54          ; DATA XREF: ROM:0003508E   o  ; was: off_34FCA
                                        ; ROM:00035096   o
                dc.l    word_EBC5A
                dc.l    word_EBC60
                dc.l    word_EBC66
                dc.l    word_EBC6C
                dc.l    word_EBC72
                dc.l    word_EBC78
                dc.l    word_EBC7E
Boss_JokerRotationFramesD:  dc.l    word_EBC7E          ; DATA XREF: ROM:0003506A   o  ; was: off_34FEA
                                        ; ROM:00035072   o
                dc.l    word_EBC78
                dc.l    word_EBC72
                dc.l    word_EBC6C
                dc.l    word_EBC66
                dc.l    word_EBC60
                dc.l    word_EBC5A
                dc.l    word_EBC54
Boss_JokerRotationFramesE:  dc.l    word_EBC84          ; DATA XREF: ROM:0003509E   o  ; was: off_3500A
                dc.l    word_EBC8A
                dc.l    word_EBC9C
                dc.l    word_EBCA8
                dc.l    word_EBCAE
                dc.l    word_EBCB4
                dc.l    word_EBCC6
                dc.l    word_EBCD2
Boss_JokerRotationFramesF:  dc.l    word_EBCD2          ; DATA XREF: ROM:0003507A   o  ; was: off_3502A
                dc.l    word_EBCC6
                dc.l    word_EBCB4
                dc.l    word_EBCAE
                dc.l    word_EBCA8
                dc.l    word_EBC9C
                dc.l    word_EBC8A
                dc.l    word_EBC84
Boss_JokerInlineSpriteDescriptorA:  dc.w    $636E, $500, $F8F8  ; DATA XREF: ROM:0003506E   o  ; was: word_3504A
                                        ; ROM:00035092   o
Boss_JokerInlineSpriteDescriptorB:  dc.w    $6366, $500, $F8F8  ; DATA XREF: ROM:00035066   o  ; was: word_35050
                                        ; ROM:0003508A   o
Boss_JokerMetaspriteDescriptors:    dc.l    0           ; DATA XREF: Boss_JokerSetup+32   o  ; was: dword_35056
                dc.l    Boss_JokerRotationFramesB
                dc.l    0
                dc.l    Boss_JokerRotationFramesB
                dc.l    Boss_JokerInlineSpriteDescriptorB+1
                dc.l    Boss_JokerRotationFramesD
                dc.l    Boss_JokerInlineSpriteDescriptorA+1
                dc.l    Boss_JokerRotationFramesD
                dc.l    0
                dc.l    Boss_JokerRotationFramesF
                dc.l    Boss_JokerRotationFramesA+$18000000
                dc.l    0
                dc.l    Boss_JokerRotationFramesA+$18000000
                dc.l    Boss_JokerInlineSpriteDescriptorB+1+$8000000
                dc.l    Boss_JokerRotationFramesC+$18000000
                dc.l    Boss_JokerInlineSpriteDescriptorA+1+$8000000
                dc.l    Boss_JokerRotationFramesC+$18000000
                dc.l    0
                dc.l    Boss_JokerRotationFramesE+$18000000
Boss_JokerPartRadii:    dc.w    $84, $8888, $928C       ; DATA XREF: Boss_JokerSetup+38   o  ; was: word_350A2
                dc.w    $9990, $9B81, $8488
                dc.w    $8892, $8C99, $909B
                dc.w    $8100
Boss_JokerPartLinks:    dc.w    0, $728, $720           ; DATA XREF: Boss_JokerSetup+3E   o  ; was: word_350B6
                dc.w    $C7, $C6, $788
                dc.w    $787, $248, $240
                dc.w    $309, $7E8, $7E0
                dc.w    $427, $426, $848
                dc.w    $847, $5A8, $5A0
                dc.w    $669
Boss_JokerNeutralPose:  dc.w    $80, $8080, $E080       ; DATA XREF: Boss_JokerCalculatePoseDeltas   o  ; was: word_350DC
                dc.w    $A0A0, $8060
; Back Stringer directional frames and dual-position segment-chain definition
Boss_BackStringerRotationFramesA:   dc.l    word_EC38E  ; DATA XREF: ROM:00035180   o  ; was: off_350E6
                                        ; ROM:00035198   o
                dc.l    word_EC394
                dc.l    word_EC39A
                dc.l    word_EC3A6
                dc.l    word_EC3AC
                dc.l    word_EC3B2
                dc.l    word_EC3B8
                dc.l    word_EC3C4
Boss_BackStringerRotationFramesB:   dc.l    word_EC3C4  ; DATA XREF: ROM:0003518C   o  ; was: off_35106
                                        ; ROM:000351A4   o
                dc.l    word_EC3B8
                dc.l    word_EC3B2
                dc.l    word_EC3AC
                dc.l    word_EC3A6
                dc.l    word_EC39A
                dc.l    word_EC394
                dc.l    word_EC38E
Boss_BackStringerRotationFramesC:   dc.l    word_EC3D0  ; DATA XREF: ROM:00035178   o  ; was: off_35126
                                        ; ROM:0003517C   o
                dc.l    word_EC3D6
                dc.l    word_EC3DC
                dc.l    word_EC3E2
                dc.l    word_EC3E8
                dc.l    word_EC3EE
                dc.l    word_EC3F4
                dc.l    word_EC3FA
Boss_BackStringerRotationFramesD:   dc.l    word_EC3FA  ; DATA XREF: ROM:00035184   o  ; was: off_35146
                                        ; ROM:00035188   o
                dc.l    word_EC3F4
                dc.l    word_EC3EE
                dc.l    word_EC3E8
                dc.l    word_EC3E2
                dc.l    word_EC3DC
                dc.l    word_EC3D6
                dc.l    word_EC3D0
Boss_BackStringerInlineSpriteDescriptor:    dc.w    $63DE, $A00, $F4F4  ; DATA XREF: ROM:Boss_BackStringerMetaspriteDescriptors   o  ; was: word_35166
Boss_BackStringerMetaspriteDescriptors:     dc.l    Boss_BackStringerInlineSpriteDescriptor+1  ; DATA XREF: Boss_BackStringerInitializeState+E   o  ; was: off_3516C
                dc.l    0
                dc.l    0
                dc.l    Boss_BackStringerRotationFramesC+$18000000
                dc.l    Boss_BackStringerRotationFramesC+$18000000
                dc.l    Boss_BackStringerRotationFramesA+$18000000
                dc.l    Boss_BackStringerRotationFramesD
                dc.l    Boss_BackStringerRotationFramesD
                dc.l    Boss_BackStringerRotationFramesB
                dc.l    Boss_BackStringerRotationFramesC+$18000000
                dc.l    Boss_BackStringerRotationFramesC+$18000000
                dc.l    Boss_BackStringerRotationFramesA+$18000000
                dc.l    Boss_BackStringerRotationFramesD
                dc.l    Boss_BackStringerRotationFramesD
                dc.l    Boss_BackStringerRotationFramesB
                dc.l    Boss_BackStringerRotationFramesC+$18000000
                dc.l    Boss_BackStringerRotationFramesC+$18000000
                dc.l    Boss_BackStringerRotationFramesA+$18000000
                dc.l    Boss_BackStringerRotationFramesD
                dc.l    Boss_BackStringerRotationFramesD
                dc.l    Boss_BackStringerRotationFramesB
Boss_BackStringerPartRadii: dc.w    $98, $9F96, $8E8C   ; DATA XREF: Boss_BackStringerInitializeState+14   o  ; was: word_351C0
                dc.w    $968E, $8C92, $8A8C
                dc.w    $928A, $8C96, $8E8C
                dc.w    $968E, $8C00
Boss_BackStringerPartLinks: dc.w    5, 4, 4             ; DATA XREF: Boss_BackStringerInitializeState+1A   o  ; was: word_351D6
                dc.w    6, $126, $186
                dc.w    6, $246, $2A6
                dc.w    6, $366, $3C6
                dc.w    6, $486, $4E6
                dc.w    6, $5A6, $606
                dc.w    6, $6C6, $726
Boss_BackStringerNeutralPose:   dc.w    $40C0, $80, $8080  ; DATA XREF: Anim_BackStringerCalcInterpolation   o  ; was: word_35200
                dc.w    $8080, $80, $8080
                dc.w    $8080, $80, $8080
                dc.w    $8080
; Sharpssteel metasprite definition and neutral pose
Boss_SharpssteelInlineSpriteDescriptorA:    dc.w    $63F9, $A00, $F4F4  ; DATA XREF: ROM:00035238   o  ; was: word_35214
                                        ; ROM:0003523C   o
Boss_SharpssteelInlineSpriteDescriptorB:    dc.w    $6402, $500, $F8F8  ; DATA XREF: ROM:00035240   o  ; was: word_3521A
                                        ; ROM:00035250   o
Boss_SharpssteelMetaspriteDescriptors:  dc.l    word_EC142+$400000  ; DATA XREF: Boss_SharpssteelInitializeState+E   o  ; was: off_35220
                dc.l    word_EC12A+$400000
                dc.l    word_EC112+$400000
                dc.l    word_EC15A+$400000
                dc.l    word_EC166+$400000
                dc.l    word_EC172+$400000
                dc.l    Boss_SharpssteelInlineSpriteDescriptorA+1
                dc.l    Boss_SharpssteelInlineSpriteDescriptorA+1
                dc.l    Boss_SharpssteelInlineSpriteDescriptorB+1
                dc.l    word_EC196+$400000
                dc.l    Boss_SharpssteelInlineSpriteDescriptorA+1
                dc.l    Boss_SharpssteelInlineSpriteDescriptorA+1
                dc.l    Boss_SharpssteelInlineSpriteDescriptorB+1
                dc.l    word_EC196+$400000
                dc.l    0
                dc.l    0
                dc.l    0
                dc.l    0
Boss_SharpssteelPartRadii:  dc.w    $809C, $A098, $9894  ; was: word_35268
                                        ; DATA XREF: Boss_SharpssteelInitializeState+14   o
                dc.w    $9C90, $8E92, $9C90
                dc.w    $8E92, $A0A0, $C0C0
Boss_SharpssteelPartLinks:  dc.w    $8007, $8006, $8065  ; was: word_3527A
                                        ; DATA XREF: Boss_SharpssteelInitializeState+1A   o
                dc.w    $8007, $8127, $8187
                dc.w    $8066, $246, $2A6
                dc.w    $8304, $8066, $3C6
                dc.w    $426, $8484, $360
                dc.w    $4E0, $360, $4E0
Boss_SharpssteelNeutralPose:    dc.w    $8080, $8080, $8080, $8080  ; was: word_3529E
                                        ; DATA XREF: Boss_SharpssteelInitializeBladePoseInterpolation   o
; Wolf Garopa directional frames and metasprite definition
Boss_WolfGaropaRotationFramesA: dc.l    word_ED1CC      ; DATA XREF: ROM:00035320   o  ; was: off_352A6
                                        ; ROM:00035334   o
                dc.l    word_ED1D2
                dc.l    word_ED1DE
                dc.l    word_ED1E4
                dc.l    word_ED1F0
                dc.l    word_ED1F6
                dc.l    word_ED202
                dc.l    word_ED208
Boss_WolfGaropaRotationFramesB: dc.l    word_ED214      ; DATA XREF: ROM:00035348   o  ; was: off_352C6
                                        ; ROM:0003535C   o
                dc.l    word_ED226
                dc.l    word_ED238
                dc.l    word_ED24A
                dc.l    word_ED25C
                dc.l    word_ED26E
                dc.l    word_ED280
                dc.l    word_ED292
Boss_WolfGaropaRotationFramesC: dc.l    word_ED2A4      ; DATA XREF: ROM:00035328   o  ; was: off_352E6
                                        ; ROM:0003533C   o
                dc.l    word_ED2B0
                dc.l    word_ED2BC
                dc.l    word_ED2C8
                dc.l    word_ED2D4
                dc.l    word_ED2E0
                dc.l    word_ED2EC
                dc.l    word_ED2F8
Boss_WolfGaropaInlineSpriteDescriptor:  dc.w    $63DE, $500, $F8F8  ; DATA XREF: ROM:00035324   o  ; was: word_35306
                                        ; ROM:0003532C   o
Boss_WolfGaropaMetaspriteDescriptors:   dc.l    0       ; DATA XREF: Boss_WolfGaropaInitialize+1E   o  ; was: dword_3530C
                dc.l    0
                dc.l    0
                dc.l    0
                dc.l    0
                dc.l    Boss_WolfGaropaRotationFramesA+$18000000
                dc.l    Boss_WolfGaropaInlineSpriteDescriptor+1
                dc.l    Boss_WolfGaropaRotationFramesC+$18000000
                dc.l    Boss_WolfGaropaInlineSpriteDescriptor+1
                dc.l    word_ED304+$8400000
                dc.l    Boss_WolfGaropaRotationFramesA+$18000000
                dc.l    Boss_WolfGaropaInlineSpriteDescriptor+1
                dc.l    Boss_WolfGaropaRotationFramesC+$18000000
                dc.l    Boss_WolfGaropaInlineSpriteDescriptor+1
                dc.l    word_ED304+$8400000
                dc.l    Boss_WolfGaropaRotationFramesB+$18000000
                dc.l    Boss_WolfGaropaInlineSpriteDescriptor+1
                dc.l    Boss_WolfGaropaRotationFramesC+$18000000
                dc.l    Boss_WolfGaropaInlineSpriteDescriptor+1
                dc.l    word_ED304+$8400000
                dc.l    Boss_WolfGaropaRotationFramesB+$18000000
                dc.l    Boss_WolfGaropaInlineSpriteDescriptor+1
                dc.l    Boss_WolfGaropaRotationFramesC+$18000000
                dc.l    Boss_WolfGaropaInlineSpriteDescriptor+1
                dc.l    word_ED304+$8400000
Boss_WolfGaropaPartRadii:   dc.w    $2C, $2612, $1891   ; DATA XREF: Boss_WolfGaropaInitialize+24   o  ; was: word_35370
                dc.w    $A290, $9F88, $1122
                dc.w    $F1F, $893, $A694
                dc.w    $A688, $1326, $1426
                dc.w    $800
Boss_WolfGaropaPartLinks:   dc.w    0, 0, 0             ; DATA XREF: Boss_WolfGaropaInitialize+2A   o  ; was: word_3538A
                dc.w    0, 0, $4063
                dc.w    $64, $4243, $244
                dc.w    $4303, $40C8, $C9
                dc.w    $4428, $429, $44E8
                dc.w    $4123, $124, $4603
                dc.w    $604, $46C3, $4188
                dc.w    $189, $47E8, $7E9
                dc.w    $48A8
; Valkirie directional frames and primary metasprite definition
Boss_ValkirieRotationFramesA:   dc.l    word_EC6FC      ; DATA XREF: ROM:00035438   o  ; was: off_353BC
                                        ; ROM:0003544C   o
                dc.l    word_EC702
                dc.l    word_EC708
                dc.l    word_EC70E
                dc.l    word_EC714
                dc.l    word_EC71A
                dc.l    word_EC720
                dc.l    word_EC726
Boss_ValkirieRotationFramesB:   dc.l    word_EC72C      ; DATA XREF: ROM:0003542C   o  ; was: off_353DC
                                        ; ROM:00035434   o
                dc.l    word_EC732
                dc.l    word_EC738
                dc.l    word_EC744
                dc.l    word_EC74A
                dc.l    word_EC750
                dc.l    word_EC756
                dc.l    word_EC762
Boss_ValkirieRotationFramesC:   dc.l    word_EC6C0      ; DATA XREF: ROM:00035454   o  ; was: off_353FC
                                        ; ROM:00035464   o
                dc.l    word_EC6D2
                dc.l    word_EC6D2
                dc.l    word_EC6E4
                dc.l    word_EC6E4
                dc.l    word_EC6E4
                dc.l    word_EC6E4
                dc.l    word_EC6C0
Boss_ValkirieMetaspriteDescriptors: dc.l    word_EC7D4+$400000  ; DATA XREF: Debug_ValkirieViewerInitialize+18   o  ; was: off_3541C
                dc.l    0
                dc.l    word_EC82E+$400000
                dc.l    0
                dc.l    Boss_ValkirieRotationFramesB+$18000000
                dc.l    word_EC7DA+$400000
                dc.l    Boss_ValkirieRotationFramesB+$18000000
                dc.l    Boss_ValkirieRotationFramesA+$18000000
                dc.l    0
                dc.l    Boss_ValkirieRotationFramesB+$18000000
                dc.l    word_EC7DA+$400000
                dc.l    Boss_ValkirieRotationFramesB+$18000000
                dc.l    Boss_ValkirieRotationFramesA+$18000000
                dc.l    0
                dc.l    Boss_ValkirieRotationFramesC
                dc.l    word_EC7E0+$400000
                dc.l    word_EC7B0+$400000
                dc.l    0
                dc.l    Boss_ValkirieRotationFramesC
                dc.l    word_EC7E0+$400000
                dc.l    word_EC7B0+$400000
Boss_ValkiriePartRadii: dc.w    0, $A, $8A95            ; DATA XREF: Debug_ValkirieViewerInitialize+1E   o  ; was: word_35470
                dc.w    $909D, $A0A, $1510
                dc.w    $1D0A, $E1C, $100A
                dc.w    $E1C, $1000
Boss_ValkiriePartLinks: dc.w    $8009, 0, $8007         ; DATA XREF: Debug_ValkirieViewerInitialize+24   o  ; was: word_35486
                dc.w    $60, $8124, $8123
                dc.w    $81E4, $81E3, $60
                dc.w    $830F, $830E, $83CF
                dc.w    $83CF, $C0, $84EA
                dc.w    $84E9, $85A8, $C0
                dc.w    $866C, $866B, $872A
; Alternate Valkirie data reused as rotation frames and interpolation pose bytes
Boss_ValkirieAlternateRotationFramesAndNeutralPose: dc.l    word_EC6FC  ; DATA XREF: ROM:0003552C   o  ; was: off_354B0
                                        ; ROM:00035540   o
                dc.l    word_EC702
                dc.l    word_EC708
                dc.l    word_EC70E
                dc.l    word_EC714
                dc.l    word_EC71A
                dc.l    word_EC720
                dc.l    word_EC726
Boss_ValkirieAlternateRotationFramesB:  dc.l    word_EC72C  ; DATA XREF: ROM:00035520   o  ; was: off_354D0
                                        ; ROM:00035528   o
                dc.l    word_EC732
                dc.l    word_EC738
                dc.l    word_EC744
                dc.l    word_EC74A
                dc.l    word_EC750
                dc.l    word_EC756
                dc.l    word_EC762
Boss_ValkirieAlternateRotationFramesC:  dc.l    word_EC6C0  ; DATA XREF: ROM:00035548   o  ; was: off_354F0
                                        ; ROM:00035558   o
                dc.l    word_EC6D2
                dc.l    word_EC6D2
                dc.l    word_EC6E4
                dc.l    word_EC6E4
                dc.l    word_EC6E4
                dc.l    word_EC6E4
                dc.l    word_EC6C0
                dc.l    word_EC7D4+$400000
                dc.l    0
                dc.l    word_EC82E+$400000
                dc.l    0
                dc.l    Boss_ValkirieAlternateRotationFramesB+$18000000
                dc.l    word_EC7DA+$400000
                dc.l    Boss_ValkirieAlternateRotationFramesB+$18000000
                dc.l    Boss_ValkirieAlternateRotationFramesAndNeutralPose+$18000000
                dc.l    0
                dc.l    Boss_ValkirieAlternateRotationFramesB+$18000000
                dc.l    word_EC7DA+$400000
                dc.l    Boss_ValkirieAlternateRotationFramesB+$18000000
                dc.l    Boss_ValkirieAlternateRotationFramesAndNeutralPose+$18000000
                dc.l    0
                dc.l    Boss_ValkirieAlternateRotationFramesC
                dc.l    word_EC7E0+$400000
                dc.l    word_EC7B0+$400000
                dc.l    0
                dc.l    Boss_ValkirieAlternateRotationFramesC
                dc.l    word_EC7E0+$400000
                dc.l    word_EC7B0+$400000
                dc.w    0, $A, $8A95
                dc.w    $909D, $A0A, $1510
                dc.w    $1D0A, $E1C, $100A
                dc.w    $E1C, $1000, $8009
                dc.w    0, $8007, $60
                dc.w    $8124, $8123, $81E4
                dc.w    $81E3, $60, $830F
                dc.w    $830E, $83CF, $83CF
                dc.w    $C0, $84EA, $84E9
                dc.w    $85A8, $C0, $866C
                dc.w    $866B, $872A
; Z-Leo definition also reused by Valkirie Force as setup and interpolation data
Boss_ZLeoValkirieForceSharedMetaspriteData: dc.l    0   ; DATA XREF: Boss_ZLeoIntroInit+22   o  ; was: dword_355A4
                                        ; Boss_ValkirieForceInit+10   o
                dc.l    0
                dc.l    0
                dc.l    word_ED3C4+$400000
                dc.l    word_ED3DC+$400000
                dc.l    word_ED3C4+$400000
                dc.l    word_ED424+$400000
                dc.l    word_ED3C4+$400000
                dc.l    word_ED3DC+$400000
                dc.l    word_ED3EE+$400000
                dc.l    word_ED3DC+$400000
                dc.l    word_ED3EE+$400000
                dc.l    word_ED3E8+$400000
                dc.l    word_ED3EE+$400000
                dc.l    word_ED3E8+$400000
                dc.l    word_ED3AC+$400000
Boss_ZLeoPartRadii: dc.w    $38, $3818, $1818           ; DATA XREF: Boss_ZLeoIntroInit+28   o  ; was: word_355E4
                dc.w    $1E18, $280C, $1C10
                dc.w    $200C, $1C1A
Boss_ZLeoPartLinks: dc.w    $8000, 0, $8000             ; DATA XREF: Boss_ZLeoIntroInit+2E   o  ; was: word_355F4
                dc.w    $806B, $812A, $8189
                dc.w    $81E9, $80CF, $80CE
                dc.w    $830D, $830C, $83CB
                dc.w    $83CA, $8489, $8488
                dc.w    $8547
