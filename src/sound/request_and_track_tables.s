Sound_BGMPointerTable:  dc.l    runnerad2025            ; DATA XREF: Sound_LoadBGMRequest+16   o  ; was: off_84E78
                                        ; Sound_DriverInterfaceTable+8   o
                dc.l    blacksheep
                dc.l    over
                dc.l    fromobjectornointro
                dc.l    withtreasure
                dc.l    shade
                dc.l    sidelimits
                dc.l    flashback
                dc.l    soltype
                dc.l    fromobjector
                dc.l    epsilonsally
                dc.l    lurk
                dc.l    perfectthing
                dc.l    slapup
                dc.l    xages
                dc.l    theend
                dc.l    titletheme
                dc.l    silent
                dc.l    galaxydesert
                dc.l    soldierssong
                dc.l    alonezvariation
                dc.l    seventhforce
                dc.l    threeprayers
                dc.l    alonez
                dc.l    runnerad2025
                dc.l    runnerad2025
                dc.l    runnerad2025
                dc.l    runnerad2025
                dc.l    runnerad2025
                dc.l    runnerad2025
                dc.l    specialsfxtrack
Sound_RequestPriorityTable: dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF  ; was: byte_84EF4
                                        ; DATA XREF: Sound_SelectPendingRequest   o
                                        ; Sound_DriverInterfaceTable   o
                dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                dc.b    $55, $5A, $52, $53, $4E, $5B, $5B, $5A, $53, $54, $53, $5A, $5A, $53, $5B, $5A
                dc.b    $54, $5B, $50, $50, $5C, $5A, $53, $53, $5A, $53, $60, $50, $50, $50, $50, $50
                dc.b    $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50
                dc.b    $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $5B, $50, $50, $50, $FF
                dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $55
                dc.b    $5A, $50, $5A, $54, $55, $52, $59, $52, $53, $55, $5A, $5A, $4F, $52, $50, $4F
                dc.b    $40, $53, $45, $45, $45, $45, $54, $60, $4E, $45, $5B, $5B, $5A, $5A, $45, $52
                dc.b    $60, $52, $53, $5A, $50, $53, $50, $51, $50, $60, $54, $53, $50, $53, $50, $53
                dc.b    $53, $60, $45, $60, $5A, $40, $5A, $45, $54, $5A, $45, $50, $50, $46, $46, $5B
                dc.b    $59, $54, $54, $5B, $5B, $5A, $5A, $54, $54, $54, $45, $52, $53, $53, $50, $5B
                dc.b    $55, $55, $55, $5B, $5B, $5B, $5B, $5B, $FF, $FF, $FF, $FF, $FF, $FF
; Ordinary SFX pointer base shared by the $40-$7F and $A0-$F8 index paths
Sound_OrdinarySFXPointerTableBase:  dc.l    SFX_A0      ; DATA XREF: Sound_LoadSFX:Sound_SelectLowRangeSFXPointerTable   o  ; was: off_84FF2
                                        ; Sound_DriverInterfaceTable+$C   o
                                        ; Sound_LoadSFX:Sound_SelectHighRangeSFXPointerTable   o
                dc.l    SFX_A1
                dc.l    SFX_A2
                dc.l    SFX_A3
                dc.l    SFX_A4
                dc.l    SFX_A5
                dc.l    SFX_A6
                dc.l    SFX_A7
                dc.l    SFX_A8
                dc.l    SFX_A9
                dc.l    SFX_AA
                dc.l    SFX_AB
                dc.l    SFX_AC
                dc.l    SFX_AD
                dc.l    SFX_AE
                dc.l    SFX_AF
                dc.l    SFX_B0
                dc.l    SFX_B1
                dc.l    SFX_B2
                dc.l    SFX_B3
                dc.l    SFX_B4
                dc.l    SFX_B5
                dc.l    SFX_B6
                dc.l    SFX_B7
                dc.l    SFX_B8
                dc.l    SFX_B9
                dc.l    SFX_BA
                dc.l    SFX_BB
                dc.l    SFX_BC
                dc.l    SFX_BD
                dc.l    SFX_BE
                dc.l    SFX_BF
                dc.l    SFX_C0
                dc.l    SFX_C1
                dc.l    SFX_C2
                dc.l    SFX_C3
                dc.l    SFX_C4
                dc.l    SFX_C5
                dc.l    SFX_C6
                dc.l    SFX_C7
                dc.l    SFX_C8
                dc.l    SFX_C9
                dc.l    SFX_CA
                dc.l    SFX_CB
                dc.l    SFX_CC
                dc.l    SFX_CD
                dc.l    SFX_CE
                dc.l    SFX_CF
                dc.l    SFX_D0
                dc.l    SFX_D1
                dc.l    SFX_D2
                dc.l    SFX_D3
                dc.l    SFX_D4
                dc.l    SFX_D5
                dc.l    SFX_D6
                dc.l    SFX_D7
                dc.l    SFX_D8
                dc.l    SFX_D9
                dc.l    SFX_DA
                dc.l    SFX_DB
                dc.l    SFX_DC
                dc.l    SFX_DD
                dc.l    SFX_DE
                dc.l    SFX_DF
                dc.l    SFX_E0
                dc.l    SFX_E1
                dc.l    SFX_E2
                dc.l    SFX_E3
                dc.l    SFX_E4
                dc.l    SFX_E5
                dc.l    SFX_E6
                dc.l    SFX_E7
                dc.l    SFX_E8
                dc.l    SFX_E9
                dc.l    SFX_EA
                dc.l    SFX_EB
                dc.l    SFX_EC
                dc.l    SFX_ED
                dc.l    SFX_EE
                dc.l    SFX_EF
                dc.l    SFX_F0
                dc.l    SFX_F1
                dc.l    SFX_F2
                dc.l    SFX_F3
                dc.l    SFX_F4
                dc.l    SFX_F5
                dc.l    SFX_F6
                dc.l    SFX_F7
                dc.l    SFX_F8
Sound_SpecialSFXPointerTable:   dc.l    SFX_F9          ; DATA XREF: Sound_LoadSpecialSFX:Sound_ResolveSpecialSFXHeader   o  ; was: off_85156
                                        ; Sound_DriverInterfaceTable+4   o
                dc.l    SFX_FA
                dc.l    SFX_FB
                dc.l    SFX_FC
; Low-range table reached through the shared ordinary-SFX arithmetic base
Sound_LowRangeSFXPointerTable:  dc.l    SFX_40          ; DATA XREF: Sound_DriverInterfaceTable+$20   o  ; was: off_85166
                dc.l    SFX_41
                dc.l    SFX_42
                dc.l    SFX_43
                dc.l    SFX_44
                dc.l    SFX_45
                dc.l    SFX_46
                dc.l    SFX_47
                dc.l    SFX_48
                dc.l    SFX_49
                dc.l    SFX_4A
                dc.l    SFX_4B
                dc.l    SFX_4C
                dc.l    SFX_4D
                dc.l    SFX_4E
                dc.l    SFX_4F
                dc.l    SFX_50
                dc.l    SFX_51
                dc.l    SFX_52
                dc.l    SFX_53
                dc.l    SFX_54
                dc.l    SFX_55
                dc.l    SFX_56
                dc.l    SFX_57
                dc.l    SFX_58
                dc.l    SFX_59
                dc.l    SFX_5A
                dc.l    SFX_5B
                dc.l    SFX_5C
                dc.l    SFX_5D
                dc.l    SFX_5E
                dc.l    SFX_5F
                dc.l    SFX_60
                dc.l    SFX_61
                dc.l    SFX_62
                dc.l    SFX_63
                dc.l    SFX_64
                dc.l    SFX_65
                dc.l    SFX_66
                dc.l    SFX_67
                dc.l    SFX_68
                dc.l    SFX_69
                dc.l    SFX_6A
                dc.l    SFX_6B
                dc.l    SFX_6C
                dc.l    SFX_6D
                dc.l    SFX_6E
                dc.l    SFX_6F
                dc.l    SFX_70
                dc.l    SFX_71
                dc.l    SFX_72
                dc.l    SFX_73
                dc.l    SFX_74
                dc.l    SFX_75
                dc.l    SFX_76
                dc.l    SFX_77
                dc.l    SFX_78
                dc.l    SFX_79
                dc.l    SFX_7A
                dc.l    SFX_7B
                dc.l    SFX_7C
                dc.l    SFX_7D
                dc.l    SFX_7E
                dc.l    SFX_7F
