off_3494C:      dc.l    word_EB774                      ; DATA XREF: ROM:000349CA   o
                                        ; ROM:000349D2   o
                dc.l    word_EB76E
                dc.l    word_EB768
                dc.l    word_EB762
                dc.l    word_EB75C
                dc.l    word_EB756
                dc.l    word_EB750
                dc.l    word_EB74A
off_3496C:      dc.l    word_EB77A                      ; DATA XREF: ROM:000349D6   o
                                        ; ROM:000349EE   o
                dc.l    word_EB780
                dc.l    word_EB78C
                dc.l    word_EB798
                dc.l    word_EB7A4
                dc.l    word_EB7AA
                dc.l    word_EB7B6
                dc.l    word_EB7C2
word_3498C:     dc.w    $305, $F00, $F0F0               ; DATA XREF: ROM:000349BA   o
word_34992:     dc.w    $325, $A00, $F4F4               ; DATA XREF: ROM:off_349B6   o
word_34998:     dc.w    $315, $F00, $F0F0               ; DATA XREF: ROM:000349C2   o
word_3499E:     dc.w    $337, $A00, $F4F4               ; DATA XREF: ROM:off_349C6   o
word_349A4:     dc.w    $32E, $A00, $F4F4               ; DATA XREF: ROM:000349E2   o
word_349AA:     dc.w    $300, $500, $F8F8               ; DATA XREF: ROM:000349CE   o
word_349B0:     dc.w    $304, 0, $FCFC                  ; DATA XREF: ROM:000349EA   o
off_349B6:      dc.l    word_34992+1                    ; DATA XREF: Boss_AntroidInitPhase+E   o
                dc.l    word_3498C+1
                dc.l    word_EB732+$400000
                dc.l    word_34998+1
off_349C6:      dc.l    word_3499E+1                    ; DATA XREF: Boss_AntroidInitPhase+28   o
                dc.l    off_3494C
                dc.l    word_349AA+1
                dc.l    off_3494C
                dc.l    off_3496C+$8000000
                dc.l    0
                dc.l    off_3494C
                dc.l    word_349A4+1
                dc.l    off_3494C
                dc.l    word_349B0+1
                dc.l    off_3496C-$18000000
off_349F2:      dc.b    $00, $12, $14, $13              ; NOT a pointer! Just sprite data bytes
word_349F6:     dc.w    $80C, $D0C, $1A06               ; DATA XREF: Boss_AntroidInitPhase+2E   o
                dc.w    $101E, $1222, $600
word_34A02:     dc.w    $C009, $C008, $4067
                                        ; DATA XREF: Boss_AntroidInitPhase+1A   o
                dc.w    $C009, $C064, $4185
                dc.w    $C1E4, $4245, $4244
                dc.w    $120, $4366, $C365
                dc.w    $4425, $C426, $44E5
word_34A20:     dc.w    $C069, $45AA, $C609
                                        ; DATA XREF: Boss_AntroidInitPhase+34   o
                dc.w    $466A, $4669, $120
                dc.w    $478A, $C789, $4849
                dc.w    $C84A, $4909
word_34A36:     dc.w    $8080, $C080, $E090
                                        ; DATA XREF: Boss_AntroidResetAnimation   o
                dc.w    $80E0, $9080, $8080
                dc.w    $8080, $8000
off_34A46:      dc.l    word_EB7F8                      ; DATA XREF: ROM:00034A90   o
                                        ; ROM:00034A98   o
                dc.l    word_EB7F2
                dc.l    word_EB7EC
                dc.l    word_EB7E6
                dc.l    word_EB7E0
                dc.l    word_EB7DA
                dc.l    word_EB7D4
                dc.l    word_EB7CE
off_34A66:      dc.l    word_EB7FE                      ; DATA XREF: ROM:00034AA0   o
                                        ; ROM:00034AB4   o
                dc.l    word_EB80A
                dc.l    word_EB816
                dc.l    word_EB822
                dc.l    word_EB82E
                dc.l    word_EB83A
                dc.l    word_EB846
                dc.l    word_EB852
word_34A86:     dc.w    $E35E, $F00, $F0F0              ; DATA XREF: ROM:00034A94   o
                                        ; ROM:00034AA8   o
dword_34A8C:    dc.l    0                               ; DATA XREF: Boss_TerobusterSetup+16   o
                dc.l    off_34A46
                dc.l    word_34A86+1
                dc.l    off_34A46
                dc.l    0
                dc.l    off_34A66-$30000000
                dc.l    off_34A46
                dc.l    word_34A86+1
                dc.l    off_34A46
                dc.l    0
                dc.l    off_34A66-$30000000
word_34AB8:     dc.w    $90, $A898, $A484               ; DATA XREF: Boss_TerobusterSetup+1C   o
                dc.w    $1028, $1824, $400
word_34AC4:     dc.w    5, 3, 1                         ; DATA XREF: Boss_TerobusterSetup+22   o
                dc.w    $C3, $C0, $182
                dc.w    7, 5, $2A7
                dc.w    $2A0, $366
word_34ADA:     dc.w    $A080, $80A0, $8080
                                        ; DATA XREF: Boss_TerobusterCalculateDeltas   o
off_34AE0:      dc.l    word_EB984                      ; DATA XREF: ROM:00034BE4   o
                                        ; ROM:00034BEC   o
                dc.l    word_EB97E
                dc.l    word_EB978
                dc.l    word_EB972
                dc.l    word_EB96C
                dc.l    word_EB966
                dc.l    word_EB960
                dc.l    word_EB95A
off_34B00:      dc.l    word_EB8EE                      ; DATA XREF: ROM:00034C08   o
                dc.l    word_EB8E8
                dc.l    word_EB8DC
                dc.l    word_EB8D0
                dc.l    word_EB8C4
                dc.l    word_EB8BE
                dc.l    word_EB8B2
                dc.l    word_EB8AC
off_34B20:      dc.l    word_EB94E                      ; DATA XREF: ROM:00034BF0   o
                dc.l    word_EB942
                dc.l    word_EB936
                dc.l    word_EB92A
                dc.l    word_EB91E
                dc.l    word_EB912
                dc.l    word_EB906
                dc.l    word_EB8FA
off_34B40:      dc.l    word_EB95A                      ; DATA XREF: ROM:00034BB8   o
                                        ; ROM:00034BC0   o
                dc.l    word_EB960
                dc.l    word_EB966
                dc.l    word_EB96C
                dc.l    word_EB972
                dc.l    word_EB978
                dc.l    word_EB97E
                dc.l    word_EB984
off_34B60:      dc.l    word_EB8AC                      ; DATA XREF: ROM:00034BDC   o
                dc.l    word_EB8B2
                dc.l    word_EB8BE
                dc.l    word_EB8C4
                dc.l    word_EB8D0
                dc.l    word_EB8DC
                dc.l    word_EB8E8
                dc.l    word_EB8EE
off_34B80:      dc.l    word_EB8FA                      ; DATA XREF: ROM:00034BC4   o
                                        ; sub_39EE4   o
                dc.l    word_EB906
                dc.l    word_EB912
                dc.l    word_EB91E
                dc.l    word_EB92A
                dc.l    word_EB936
                dc.l    word_EB942
                dc.l    word_EB94E
word_34BA0:     dc.w    $6457, $A00, $F4F4              ; DATA XREF: ROM:00034BD0   o
                                        ; ROM:00034BFC   o
word_34BA6:     dc.w    $6460, $500, $F8F8              ; DATA XREF: ROM:00034BBC   o
                                        ; ROM:00034BD8   o
dword_34BAC:    dc.l    0                               ; DATA XREF: Boss_ShellshogunSetupPhase+3C   o
                dc.l    word_EB876+$400000
                dc.l    word_EB8A0+$400000
                dc.l    off_34B40+$48000000
                dc.l    word_34BA6+1
                dc.l    off_34B40+$48000000
                dc.l    off_34B80+$48000000
                dc.l    0
                dc.l    off_34B40+$48000000
                dc.l    word_34BA0+1
                dc.l    off_34B40+$48000000
                dc.l    word_34BA6+1
                dc.l    off_34B60+$48000000
                dc.l    word_EB8A0+$400000
                dc.l    off_34AE0-$30000000
                dc.l    word_34BA6+1
                dc.l    off_34AE0-$30000000
                dc.l    off_34B20-$30000000
                dc.l    0
                dc.l    off_34AE0-$30000000
                dc.l    word_34BA0+1
                dc.l    off_34AE0-$30000000
                dc.l    word_34BA6+1
                dc.l    off_34B00-$30000000
word_34C0C:     dc.w    $22, $260C, $1A0C               ; DATA XREF: Boss_ShellshogunSetupPhase+42   o
                dc.w    $1C18, $101E, $101C
                dc.w    $826, $C1A, $C1C
                dc.w    $1810, $1E10, $1C08
word_34C24:     dc.w    4, 4, 4                         ; DATA XREF: Boss_ShellshogunSetupPhase+48   o
                dc.w    $C7, $C6, $185
                dc.w    $183, 4, $2AB
                dc.w    $2AA, $36A, $36B
                dc.w    $42B, 7, $4EA
                dc.w    $4E9, $5A8, $5A3
                dc.w    4, $6CD, $6CC
                dc.w    $78C, $78D, $84D
word_34C54:     dc.w    $40, $6070, $40E0               ; DATA XREF: Boss_ShellshogunCollisionCheck   o
                dc.w    $8000, $4000, $7080
                dc.w    $E080, $A000
off_34C64:      dc.l    word_EBAB0                      ; DATA XREF: ROM:00034D16   o
                                        ; ROM:00034D1E   o
                dc.l    word_EBAB6
                dc.l    word_EBABC
                dc.l    word_EBAC2
                dc.l    word_EBAC8
                dc.l    word_EBACE
                dc.l    word_EBAD4
                dc.l    word_EBADA
off_34C84:      dc.l    word_EBAEC                      ; DATA XREF: ROM:00034D3E   o
                dc.l    word_EBAF2
                dc.l    word_EBAF8
                dc.l    word_EBAFE
                dc.l    word_EBB04
                dc.l    word_EBB0A
                dc.l    word_EBB10
                dc.l    word_EBB16
off_34CA4:      dc.l    word_EBADA                      ; DATA XREF: ROM:00034D02   o
                                        ; ROM:00034D0A   o
                dc.l    word_EBAD4
                dc.l    word_EBACE
                dc.l    word_EBAC8
                dc.l    word_EBAC2
                dc.l    word_EBABC
                dc.l    word_EBAB6
                dc.l    word_EBAB0
off_34CC4:      dc.l    word_EBB16                      ; DATA XREF: ROM:00034D56   o
                dc.l    word_EBB10
                dc.l    word_EBB0A
                dc.l    word_EBB04
                dc.l    word_EBAFE
                dc.l    word_EBAF8
                dc.l    word_EBAF2
                dc.l    word_EBAEC
word_34CE4:     dc.w    $62D4, $500, $F8F8              ; DATA XREF: ROM:00034D3A   o
                                        ; ROM:00034D52   o
word_34CEA:     dc.w    $62D8, $A00, $F4F4              ; DATA XREF: ROM:00034D06   o
                                        ; ROM:00034D1A   o
word_34CF0:     dc.w    $62E1, $A00, $F4F4              ; DATA XREF: ROM:00034D32   o
                                        ; ROM:00034D4A   o
dword_34CF6:    dc.l    0                               ; DATA XREF: Boss_XiTigerSetup+10   o
                dc.l    word_EBA2C+$400000
                dc.l    word_EBA1A+$400000
                dc.l    off_34CA4
                dc.l    word_34CEA+1
                dc.l    off_34CA4
                dc.l    0
                dc.l    word_EBA1A-$7C00000
                dc.l    off_34C64+$18000000
                dc.l    word_34CEA+1-$8000000
                dc.l    off_34C64+$18000000
                dc.l    0
                dc.l    word_EBAE0+$400000
                dc.l    0
                dc.l    off_34C64+$18000000
                dc.l    word_34CF0+1
                dc.l    off_34CA4
                dc.l    word_34CE4+1
                dc.l    off_34C84+$18000000
                dc.l    0
                dc.l    off_34C64+$18000000
                dc.l    word_34CF0+1+$8000000
                dc.l    off_34C64+$8000000
                dc.l    word_34CE4+1+$8000000
                dc.l    off_34CC4
word_34D5A:     dc.w    $E, $2E14, $2410                ; DATA XREF: Boss_XiTigerSetup+16   o
                dc.w    $222C, $1424, $1022
                dc.w    $3214, $A1C, $E1C
                dc.w    $714, $A1C, $E1C
                dc.w    $700
word_34D74:     dc.w    $8000, $8005, $8005
                                        ; DATA XREF: Boss_XiTigerSetup+1C   o
                dc.w    $80C5, $80C5, $8184
                dc.w    $8180, $8005, $82A5
                dc.w    $82A5, $8364, $8360
                dc.w    $8009, $8488, $84E7
                dc.w    $84E6, $85A7, $85A7
                dc.w    $8667, $8488, $8727
                dc.w    $8726, $87E7, $87E7
                dc.w    $88A7
word_34DA6:     dc.w    $2060, $70C0, $80A0
                                        ; DATA XREF: Boss_XiTigerCalculateDeltas   o
                dc.w    $9080, $4000, $8000
                dc.w    $E040, $4080
off_34DB6:      dc.l    word_EBB7C                      ; DATA XREF: ROM:00034E60   o
                                        ; ROM:00034E78   o
                dc.l    word_EBB70
                dc.l    word_EBB58
                dc.l    word_EBB34
                dc.l    word_EBB40
                dc.l    word_EBB28
                dc.l    word_EBB4C
                dc.l    word_EBB64
off_34DD6:      dc.l    word_EBB64                      ; DATA XREF: ROM:00034E5C   o
                                        ; ROM:00034E74   o
                dc.l    word_EBB4C
                dc.l    word_EBB28
                dc.l    word_EBB40
                dc.l    word_EBB34
                dc.l    word_EBB58
                dc.l    word_EBB70
                dc.l    word_EBB7C
off_34DF6:      dc.l    word_EBB88                      ; DATA XREF: ROM:00034E94   o
                                        ; ROM:00034E9C   o
                dc.l    word_EBB8E
                dc.l    word_EBB94
                dc.l    word_EBB9A
                dc.l    word_EBBA0
                dc.l    word_EBBA6
                dc.l    word_EBBAC
                dc.l    word_EBBB2
off_34E16:      dc.l    word_EBBB2                      ; DATA XREF: ROM:00034E7C   o
                                        ; ROM:00034E84   o
                dc.l    word_EBBAC
                dc.l    word_EBBA6
                dc.l    word_EBBA0
                dc.l    word_EBB9A
                dc.l    word_EBB94
                dc.l    word_EBB8E
                dc.l    word_EBB88
word_34E36:     dc.w    $6390, $F00, $F0F0              ; DATA XREF: ROM:00034E58   o
                                        ; ROM:00034E70   o
word_34E3C:     dc.w    $63A0, $A00, $F4F4              ; DATA XREF: ROM:00034E4C   o
                                        ; ROM:00034E50   o
word_34E42:     dc.w    $43C4, 0, $FCFC                 ; DATA XREF: ROM:00034E80   o
                                        ; ROM:00034E8C   o
dword_34E48:    dc.l    0                               ; DATA XREF: Boss_MadamBarbarSetup+14   o
                dc.l    word_34E3C+1
                dc.l    word_34E3C+1
                dc.l    word_34E3C+1
                dc.l    word_34E36+1
                dc.l    off_34DD6
                dc.l    off_34DB6+$18000000
                dc.l    word_34E3C+1
                dc.l    word_34E3C+1
                dc.l    word_34E3C+1
                dc.l    word_34E36+1
                dc.l    off_34DD6
                dc.l    off_34DB6+$18000000
                dc.l    off_34E16
                dc.l    word_34E42+1
                dc.l    off_34E16
                dc.l    off_34E16
                dc.l    word_34E42+1
                dc.l    off_34E16
                dc.l    off_34DF6+$18000000
                dc.l    word_34E42+1
                dc.l    off_34DF6+$18000000
                dc.l    off_34DF6+$18000000
                dc.l    word_34E42+1
                dc.l    off_34DF6+$18000000
                dc.l    0
                dc.l    0
                dc.l    0
                dc.l    0
word_34EBC:     dc.w    $10, $C10, $121C                ; DATA XREF: Boss_MadamBarbarSetup+1A   o
                dc.w    $1C10, $C10, $121C
                dc.w    $1C06, $608, $606
                dc.w    $806, $608, $606
                dc.w    $80D, $D0D, $D00
word_34EDA:     dc.w    $8000, $8007, $8066
                                        ; DATA XREF: Boss_MadamBarbarSetup+20   o
                dc.w    $80C5, $8124, $184
                dc.w    $184, $8007, $82A6
                dc.w    $8305, $8364, $3C4
                dc.w    $3C4, 7, $4E6
                dc.w    $546, 7, $606
                dc.w    $666, 7, $726
                dc.w    $786, 7, $846
                dc.w    $8A6, $540, $660
                dc.w    $780, $8A0
word_34F14:     dc.w    $8080, $80, $80                 ; DATA XREF: Boss_MadamBarbarCalcDeltas   o
                dc.w    $80, $8080, $8080
off_34F20:      dc.l    word_EBBDC                      ; DATA XREF: ROM:00034F4A   o
                                        ; ROM:00034F52   o
                dc.l    word_EBBE2
                dc.l    word_EBBE8
                dc.l    word_EBBEE
                dc.l    word_EBBF4
                dc.l    word_EBBFA
                dc.l    word_EBC00
                dc.l    word_EBC06
word_34F40:     dc.w    $6380, $600, $F8F4              ; DATA XREF: ROM:00034F4E   o
                                        ; ROM:00034F5E   o
dword_34F46:    dc.l    0                               ; DATA XREF: Boss_FlyingNeoSetup+C   o
                dc.l    off_34F20+$18000000
                dc.l    word_34F40+1
                dc.l    off_34F20+$18000000
                dc.l    word_EBC18+$8400000
                dc.l    off_34F20+$18000000
                dc.l    word_34F40+1
                dc.l    off_34F20+$18000000
                dc.l    word_EBC18+$8400000
word_34F6A:     dc.w    8, $1810, $1F08                 ; DATA XREF: Boss_FlyingNeoSetup+12   o
                dc.w    $1810, $1F00
word_34F74:     dc.w    0, $8065, $C064                 ; DATA XREF: Boss_FlyingNeoSetup+18   o
                dc.w    $8124, $8123, $806B
                dc.w    $C06A, $82AA, $82A9
word_34F86:     dc.w    $A0A0, $A0A0                    ; DATA XREF: Boss_FlyingNeoCalculateDeltas   o
off_34F8A:      dc.l    word_EBC24                      ; DATA XREF: ROM:0003507E   o
                                        ; ROM:00035086   o
                dc.l    word_EBC2A
                dc.l    word_EBC30
                dc.l    word_EBC36
                dc.l    word_EBC3C
                dc.l    word_EBC42
                dc.l    word_EBC48
                dc.l    word_EBC4E
off_34FAA:      dc.l    word_EBC4E                      ; DATA XREF: ROM:0003505A   o
                                        ; ROM:00035062   o
                dc.l    word_EBC48
                dc.l    word_EBC42
                dc.l    word_EBC3C
                dc.l    word_EBC36
                dc.l    word_EBC30
                dc.l    word_EBC2A
                dc.l    word_EBC24
off_34FCA:      dc.l    word_EBC54                      ; DATA XREF: ROM:0003508E   o
                                        ; ROM:00035096   o
                dc.l    word_EBC5A
                dc.l    word_EBC60
                dc.l    word_EBC66
                dc.l    word_EBC6C
                dc.l    word_EBC72
                dc.l    word_EBC78
                dc.l    word_EBC7E
off_34FEA:      dc.l    word_EBC7E                      ; DATA XREF: ROM:0003506A   o
                                        ; ROM:00035072   o
                dc.l    word_EBC78
                dc.l    word_EBC72
                dc.l    word_EBC6C
                dc.l    word_EBC66
                dc.l    word_EBC60
                dc.l    word_EBC5A
                dc.l    word_EBC54
off_3500A:      dc.l    word_EBC84                      ; DATA XREF: ROM:0003509E   o
                dc.l    word_EBC8A
                dc.l    word_EBC9C
                dc.l    word_EBCA8
                dc.l    word_EBCAE
                dc.l    word_EBCB4
                dc.l    word_EBCC6
                dc.l    word_EBCD2
off_3502A:      dc.l    word_EBCD2                      ; DATA XREF: ROM:0003507A   o
                dc.l    word_EBCC6
                dc.l    word_EBCB4
                dc.l    word_EBCAE
                dc.l    word_EBCA8
                dc.l    word_EBC9C
                dc.l    word_EBC8A
                dc.l    word_EBC84
word_3504A:     dc.w    $636E, $500, $F8F8              ; DATA XREF: ROM:0003506E   o
                                        ; ROM:00035092   o
word_35050:     dc.w    $6366, $500, $F8F8              ; DATA XREF: ROM:00035066   o
                                        ; ROM:0003508A   o
dword_35056:    dc.l    0                               ; DATA XREF: Boss_JokerSetup+32   o
                dc.l    off_34FAA
                dc.l    0
                dc.l    off_34FAA
                dc.l    word_35050+1
                dc.l    off_34FEA
                dc.l    word_3504A+1
                dc.l    off_34FEA
                dc.l    0
                dc.l    off_3502A
                dc.l    off_34F8A+$18000000
                dc.l    0
                dc.l    off_34F8A+$18000000
                dc.l    word_35050+1+$8000000
                dc.l    off_34FCA+$18000000
                dc.l    word_3504A+1+$8000000
                dc.l    off_34FCA+$18000000
                dc.l    0
                dc.l    off_3500A+$18000000
word_350A2:     dc.w    $84, $8888, $928C               ; DATA XREF: Boss_JokerSetup+38   o
                dc.w    $9990, $9B81, $8488
                dc.w    $8892, $8C99, $909B
                dc.w    $8100
word_350B6:     dc.w    0, $728, $720                   ; DATA XREF: Boss_JokerSetup+3E   o
                dc.w    $C7, $C6, $788
                dc.w    $787, $248, $240
                dc.w    $309, $7E8, $7E0
                dc.w    $427, $426, $848
                dc.w    $847, $5A8, $5A0
                dc.w    $669
word_350DC:     dc.w    $80, $8080, $E080               ; DATA XREF: Boss_JokerCalcDeltas   o
                dc.w    $A0A0, $8060
off_350E6:      dc.l    word_EC38E                      ; DATA XREF: ROM:00035180   o
                                        ; ROM:00035198   o
                dc.l    word_EC394
                dc.l    word_EC39A
                dc.l    word_EC3A6
                dc.l    word_EC3AC
                dc.l    word_EC3B2
                dc.l    word_EC3B8
                dc.l    word_EC3C4
off_35106:      dc.l    word_EC3C4                      ; DATA XREF: ROM:0003518C   o
                                        ; ROM:000351A4   o
                dc.l    word_EC3B8
                dc.l    word_EC3B2
                dc.l    word_EC3AC
                dc.l    word_EC3A6
                dc.l    word_EC39A
                dc.l    word_EC394
                dc.l    word_EC38E
off_35126:      dc.l    word_EC3D0                      ; DATA XREF: ROM:00035178   o
                                        ; ROM:0003517C   o
                dc.l    word_EC3D6
                dc.l    word_EC3DC
                dc.l    word_EC3E2
                dc.l    word_EC3E8
                dc.l    word_EC3EE
                dc.l    word_EC3F4
                dc.l    word_EC3FA
off_35146:      dc.l    word_EC3FA                      ; DATA XREF: ROM:00035184   o
                                        ; ROM:00035188   o
                dc.l    word_EC3F4
                dc.l    word_EC3EE
                dc.l    word_EC3E8
                dc.l    word_EC3E2
                dc.l    word_EC3DC
                dc.l    word_EC3D6
                dc.l    word_EC3D0
word_35166:     dc.w    $63DE, $A00, $F4F4              ; DATA XREF: ROM:off_3516C   o
off_3516C:      dc.l    word_35166+1                    ; DATA XREF: Boss_BackStringerSpawn+E   o
                dc.l    0
                dc.l    0
                dc.l    off_35126+$18000000
                dc.l    off_35126+$18000000
                dc.l    off_350E6+$18000000
                dc.l    off_35146
                dc.l    off_35146
                dc.l    off_35106
                dc.l    off_35126+$18000000
                dc.l    off_35126+$18000000
                dc.l    off_350E6+$18000000
                dc.l    off_35146
                dc.l    off_35146
                dc.l    off_35106
                dc.l    off_35126+$18000000
                dc.l    off_35126+$18000000
                dc.l    off_350E6+$18000000
                dc.l    off_35146
                dc.l    off_35146
                dc.l    off_35106
word_351C0:     dc.w    $98, $9F96, $8E8C               ; DATA XREF: Boss_BackStringerSpawn+14   o
                dc.w    $968E, $8C92, $8A8C
                dc.w    $928A, $8C96, $8E8C
                dc.w    $968E, $8C00
word_351D6:     dc.w    5, 4, 4                         ; DATA XREF: Boss_BackStringerSpawn+1A   o
                dc.w    6, $126, $186
                dc.w    6, $246, $2A6
                dc.w    6, $366, $3C6
                dc.w    6, $486, $4E6
                dc.w    6, $5A6, $606
                dc.w    6, $6C6, $726
word_35200:     dc.w    $40C0, $80, $8080               ; DATA XREF: Anim_BackStringerCalcInterpolation   o
                dc.w    $8080, $80, $8080
                dc.w    $8080, $80, $8080
                dc.w    $8080
word_35214:     dc.w    $63F9, $A00, $F4F4              ; DATA XREF: ROM:00035238   o
                                        ; ROM:0003523C   o
word_3521A:     dc.w    $6402, $500, $F8F8              ; DATA XREF: ROM:00035240   o
                                        ; ROM:00035250   o
off_35220:      dc.l    word_EC142+$400000              ; DATA XREF: Boss_SharpssteelInit+E   o
                dc.l    word_EC12A+$400000
                dc.l    word_EC112+$400000
                dc.l    word_EC15A+$400000
                dc.l    word_EC166+$400000
                dc.l    word_EC172+$400000
                dc.l    word_35214+1
                dc.l    word_35214+1
                dc.l    word_3521A+1
                dc.l    word_EC196+$400000
                dc.l    word_35214+1
                dc.l    word_35214+1
                dc.l    word_3521A+1
                dc.l    word_EC196+$400000
                dc.l    0
                dc.l    0
                dc.l    0
                dc.l    0
word_35268:     dc.w    $809C, $A098, $9894
                                        ; DATA XREF: Boss_SharpssteelInit+14   o
                dc.w    $9C90, $8E92, $9C90
                dc.w    $8E92, $A0A0, $C0C0
word_3527A:     dc.w    $8007, $8006, $8065
                                        ; DATA XREF: Boss_SharpssteelInit+1A   o
                dc.w    $8007, $8127, $8187
                dc.w    $8066, $246, $2A6
                dc.w    $8304, $8066, $3C6
                dc.w    $426, $8484, $360
                dc.w    $4E0, $360, $4E0
word_3529E:     dc.w    $8080, $8080, $8080, $8080
                                        ; DATA XREF: Boss_SharpssteelCoreDefeat   o
off_352A6:      dc.l    word_ED1CC                      ; DATA XREF: ROM:00035320   o
                                        ; ROM:00035334   o
                dc.l    word_ED1D2
                dc.l    word_ED1DE
                dc.l    word_ED1E4
                dc.l    word_ED1F0
                dc.l    word_ED1F6
                dc.l    word_ED202
                dc.l    word_ED208
off_352C6:      dc.l    word_ED214                      ; DATA XREF: ROM:00035348   o
                                        ; ROM:0003535C   o
                dc.l    word_ED226
                dc.l    word_ED238
                dc.l    word_ED24A
                dc.l    word_ED25C
                dc.l    word_ED26E
                dc.l    word_ED280
                dc.l    word_ED292
off_352E6:      dc.l    word_ED2A4                      ; DATA XREF: ROM:00035328   o
                                        ; ROM:0003533C   o
                dc.l    word_ED2B0
                dc.l    word_ED2BC
                dc.l    word_ED2C8
                dc.l    word_ED2D4
                dc.l    word_ED2E0
                dc.l    word_ED2EC
                dc.l    word_ED2F8
word_35306:     dc.w    $63DE, $500, $F8F8              ; DATA XREF: ROM:00035324   o
                                        ; ROM:0003532C   o
dword_3530C:    dc.l    0                               ; DATA XREF: Boss_WolfGaropaMovement3+1E   o
                dc.l    0
                dc.l    0
                dc.l    0
                dc.l    0
                dc.l    off_352A6+$18000000
                dc.l    word_35306+1
                dc.l    off_352E6+$18000000
                dc.l    word_35306+1
                dc.l    word_ED304+$8400000
                dc.l    off_352A6+$18000000
                dc.l    word_35306+1
                dc.l    off_352E6+$18000000
                dc.l    word_35306+1
                dc.l    word_ED304+$8400000
                dc.l    off_352C6+$18000000
                dc.l    word_35306+1
                dc.l    off_352E6+$18000000
                dc.l    word_35306+1
                dc.l    word_ED304+$8400000
                dc.l    off_352C6+$18000000
                dc.l    word_35306+1
                dc.l    off_352E6+$18000000
                dc.l    word_35306+1
                dc.l    word_ED304+$8400000
word_35370:     dc.w    $2C, $2612, $1891               ; DATA XREF: Boss_WolfGaropaMovement3+24   o
                dc.w    $A290, $9F88, $1122
                dc.w    $F1F, $893, $A694
                dc.w    $A688, $1326, $1426
                dc.w    $800
word_3538A:     dc.w    0, 0, 0                         ; DATA XREF: Boss_WolfGaropaMovement3+2A   o
                dc.w    0, 0, $4063
                dc.w    $64, $4243, $244
                dc.w    $4303, $40C8, $C9
                dc.w    $4428, $429, $44E8
                dc.w    $4123, $124, $4603
                dc.w    $604, $46C3, $4188
                dc.w    $189, $47E8, $7E9
                dc.w    $48A8
off_353BC:      dc.l    word_EC6FC                      ; DATA XREF: ROM:00035438   o
                                        ; ROM:0003544C   o
                dc.l    word_EC702
                dc.l    word_EC708
                dc.l    word_EC70E
                dc.l    word_EC714
                dc.l    word_EC71A
                dc.l    word_EC720
                dc.l    word_EC726
off_353DC:      dc.l    word_EC72C                      ; DATA XREF: ROM:0003542C   o
                                        ; ROM:00035434   o
                dc.l    word_EC732
                dc.l    word_EC738
                dc.l    word_EC744
                dc.l    word_EC74A
                dc.l    word_EC750
                dc.l    word_EC756
                dc.l    word_EC762
off_353FC:      dc.l    word_EC6C0                      ; DATA XREF: ROM:00035454   o
                                        ; ROM:00035464   o
                dc.l    word_EC6D2
                dc.l    word_EC6D2
                dc.l    word_EC6E4
                dc.l    word_EC6E4
                dc.l    word_EC6E4
                dc.l    word_EC6E4
                dc.l    word_EC6C0
off_3541C:      dc.l    word_EC7D4+$400000              ; DATA XREF: Boss_ValkirieInit+18   o
                dc.l    0
                dc.l    word_EC82E+$400000
                dc.l    0
                dc.l    off_353DC+$18000000
                dc.l    word_EC7DA+$400000
                dc.l    off_353DC+$18000000
                dc.l    off_353BC+$18000000
                dc.l    0
                dc.l    off_353DC+$18000000
                dc.l    word_EC7DA+$400000
                dc.l    off_353DC+$18000000
                dc.l    off_353BC+$18000000
                dc.l    0
                dc.l    off_353FC
                dc.l    word_EC7E0+$400000
                dc.l    word_EC7B0+$400000
                dc.l    0
                dc.l    off_353FC
                dc.l    word_EC7E0+$400000
                dc.l    word_EC7B0+$400000
word_35470:     dc.w    0, $A, $8A95                    ; DATA XREF: Boss_ValkirieInit+1E   o
                dc.w    $909D, $A0A, $1510
                dc.w    $1D0A, $E1C, $100A
                dc.w    $E1C, $1000
word_35486:     dc.w    $8009, 0, $8007                 ; DATA XREF: Boss_ValkirieInit+24   o
                dc.w    $60, $8124, $8123
                dc.w    $81E4, $81E3, $60
                dc.w    $830F, $830E, $83CF
                dc.w    $83CF, $C0, $84EA
                dc.w    $84E9, $85A8, $C0
                dc.w    $866C, $866B, $872A
off_354B0:      dc.l    word_EC6FC                      ; DATA XREF: ROM:0003552C   o
                                        ; ROM:00035540   o
                dc.l    word_EC702
                dc.l    word_EC708
                dc.l    word_EC70E
                dc.l    word_EC714
                dc.l    word_EC71A
                dc.l    word_EC720
                dc.l    word_EC726
off_354D0:      dc.l    word_EC72C                      ; DATA XREF: ROM:00035520   o
                                        ; ROM:00035528   o
                dc.l    word_EC732
                dc.l    word_EC738
                dc.l    word_EC744
                dc.l    word_EC74A
                dc.l    word_EC750
                dc.l    word_EC756
                dc.l    word_EC762
off_354F0:      dc.l    word_EC6C0                      ; DATA XREF: ROM:00035548   o
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
                dc.l    off_354D0+$18000000
                dc.l    word_EC7DA+$400000
                dc.l    off_354D0+$18000000
                dc.l    off_354B0+$18000000
                dc.l    0
                dc.l    off_354D0+$18000000
                dc.l    word_EC7DA+$400000
                dc.l    off_354D0+$18000000
                dc.l    off_354B0+$18000000
                dc.l    0
                dc.l    off_354F0
                dc.l    word_EC7E0+$400000
                dc.l    word_EC7B0+$400000
                dc.l    0
                dc.l    off_354F0
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
dword_355A4:    dc.l    0                               ; DATA XREF: Boss_ZLeoIntroInit+22   o
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
word_355E4:     dc.w    $38, $3818, $1818               ; DATA XREF: Boss_ZLeoIntroInit+28   o
                dc.w    $1E18, $280C, $1C10
                dc.w    $200C, $1C1A
word_355F4:     dc.w    $8000, 0, $8000                 ; DATA XREF: Boss_ZLeoIntroInit+2E   o
                dc.w    $806B, $812A, $8189
                dc.w    $81E9, $80CF, $80CE
                dc.w    $830D, $830C, $83CB
                dc.w    $83CA, $8489, $8488
                dc.w    $8547

; Checks if boss position is within valid screen bounds
