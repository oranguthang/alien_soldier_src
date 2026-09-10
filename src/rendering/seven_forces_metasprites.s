; Alternate an object's graphics word on successive global frames
Object_SelectAlternatingGraphicsFrame:                  ; was: sub_59D2C
                move.w  #$C4D6,$E(a5)
                btst    #0,(word_FFA000+1).w
                beq.s   Object_SelectAlternatingGraphicsFrameReturn
                move.w  #$C4DF,$E(a5)
Object_SelectAlternatingGraphicsFrameReturn:            ; CODE XREF: Object_SelectAlternatingGraphicsFrame+C   j  ; was: locret_59D40
                rts
; End of function Object_SelectAlternatingGraphicsFrame
; ---------------------------------------------------------------------------
; Shared eight-direction frame-pointer tables used by Seven Forces parts
SevenForcesRotationFrameTable0: dc.l    word_ECC86      ; DATA XREF: ROM:00059EB8   o  ; was: off_59D42
                                        ; ROM:00059EE4   o
                dc.l    word_ECC92
                dc.l    word_ECC98
                dc.l    word_ECCA4
                dc.l    word_ECCAA
                dc.l    word_ECCB6
                dc.l    word_ECCBC
                dc.l    word_ECCC8
SevenForcesRotationFrameTable1: dc.l    word_ECCC8      ; DATA XREF: ROM:00059EA4   o  ; was: off_59D62
                                        ; ROM:00059ECC   o
                dc.l    word_ECCBC
                dc.l    word_ECCB6
                dc.l    word_ECCAA
                dc.l    word_ECCA4
                dc.l    word_ECC98
                dc.l    word_ECC92
                dc.l    word_ECC86
                dc.l    word_ECCDA
                dc.l    word_ECCE0
                dc.l    word_ECCE6
                dc.l    word_ECCF2
                dc.l    word_ECCF8
                dc.l    word_ECCFE
                dc.l    word_ECD04
                dc.l    word_ECD10
SevenForcesRotationFrameTable2: dc.l    word_ECD10      ; DATA XREF: ROM:00059EA0   o  ; was: off_59DA2
                                        ; ROM:0005A034   o
                dc.l    word_ECD04
                dc.l    word_ECCFE
                dc.l    word_ECCF8
                dc.l    word_ECCF2
                dc.l    word_ECCE6
                dc.l    word_ECCE0
                dc.l    word_ECCDA
SevenForcesRotationFrameTable3: dc.l    word_ECD16      ; DATA XREF: ROM:00059EF4   o  ; was: off_59DC2
                                        ; ROM:00059F6E   o
                dc.l    word_ECD1C
                dc.l    word_ECD22
                dc.l    word_ECD28
                dc.l    word_ECD2E
                dc.l    word_ECD34
                dc.l    word_ECD3A
                dc.l    word_ECD40
SevenForcesRotationFrameTable4: dc.l    word_ECD40      ; DATA XREF: ROM:00059EDC   o  ; was: off_59DE2
                                        ; ROM:00059F66   o
                dc.l    word_ECD3A
                dc.l    word_ECD34
                dc.l    word_ECD2E
                dc.l    word_ECD28
                dc.l    word_ECD22
                dc.l    word_ECD1C
                dc.l    word_ECD16
SevenForcesRotationFrameTable5: dc.l    word_ECD46      ; DATA XREF: ROM:00059EC4   o  ; was: off_59E02
                                        ; ROM:00059EEC   o
                dc.l    word_ECD4C
                dc.l    word_ECD58
                dc.l    word_ECD64
                dc.l    word_ECD70
                dc.l    word_ECD76
                dc.l    word_ECD82
                dc.l    word_ECD8E
SevenForcesRotationFrameTable6: dc.l    word_ECD8E      ; DATA XREF: ROM:00059EB0   o  ; was: off_59E22
                                        ; ROM:00059ED4   o
                dc.l    word_ECD82
                dc.l    word_ECD76
                dc.l    word_ECD70
                dc.l    word_ECD64
                dc.l    word_ECD58
                dc.l    word_ECD4C
                dc.l    word_ECD46
SevenForcesRotationFrameTable7: dc.l    word_ECD9A      ; DATA XREF: ROM:00059EB4   o  ; was: off_59E42
                dc.l    word_ECDA0
                dc.l    word_ECDA6
                dc.l    word_ECDAC
                dc.l    word_ECDB2
                dc.l    word_ECDB8
                dc.l    word_ECDBE
                dc.l    word_ECDC4
SevenForcesRotationFrameTable8: dc.l    word_ECDC4      ; DATA XREF: ROM:00059EC8   o  ; was: off_59E62
                dc.l    word_ECDBE
                dc.l    word_ECDB8
                dc.l    word_ECDB2
                dc.l    word_ECDAC
                dc.l    word_ECDA6
                dc.l    word_ECDA0
                dc.l    word_ECD9A
; Inline descriptors: graphics word, mapping offset, and packed position
SevenForcesInlinePartDescriptor0:   dc.w    $42D, $F00, $F0F0  ; DATA XREF: ROM:00059E98   o  ; was: word_59E82
                                        ; ROM:0005A038   o
SevenForcesInlinePartDescriptor1:   dc.w    $43D, $A00, $F4F4  ; DATA XREF: ROM:00059E9C   o  ; was: word_59E88
                                        ; ROM:Boss_ValkirieAuxiliaryMetaspritePartDescriptors   o
SevenForcesInlinePartDescriptor2:   dc.w    $446, $500, $F8F8  ; DATA XREF: ROM:00059EAC   o  ; was: word_59E8E
                                        ; ROM:00059EC0   o
; Primary Valkirie metasprite initialization and neutral-pose data
Boss_ValkirieMetaspritePartDescriptors: dc.l    word_ECDCA+$400000  ; DATA XREF: Entity_InitValkirieBattleState0+10   o  ; was: off_59E94
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable2-$40000000
                dc.l    SevenForcesRotationFrameTable1
                dc.l    0
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable6
                dc.l    SevenForcesRotationFrameTable7+$8000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    0
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesRotationFrameTable8
                dc.l    SevenForcesRotationFrameTable1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable6
                dc.l    0
                dc.l    SevenForcesRotationFrameTable4
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    0
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesInlinePartDescriptor2+1
Boss_ValkirieMetaspriteInitialAngles:   dc.w    $12, $E15, $1F09  ; DATA XREF: Entity_InitValkirieBattleState0+16   o  ; was: word_59EFC
                dc.w    $1212, $251F, $912
                dc.w    $1225, $192C, $1426
                dc.w    $E04, $192C, $1426
                dc.w    $E04
Boss_ValkirieMetaspritePartLinks:   dc.w    $C004, $C004, $C064  ; was: word_59F16
                                        ; DATA XREF: Entity_InitValkirieBattleState0+1C   o
                dc.w    $C002, $C002, $C182
                dc.w    $C182, $C241, $C240
                dc.w    $C002, $C362, $C362
                dc.w    $C421, $C420, $C0C6
                dc.w    $C0C6, $C5A6, $C5A5
                dc.w    $C664, $C665, $C0C6
                dc.w    $C0C6, $C7E6, $C7E5
                dc.w    $C8A4, $C8A5
Boss_ValkirieMetaspritePoseAngles:  dc.w    $C080, $4000, $8080  ; was: word_59F4A
                                        ; DATA XREF: Entity_InitValkirieBattleState0+28   o
                dc.w    $8080, $80E0, $8080
                dc.w    $80A0, $8080, $8080
                dc.w    $8080
; Six-part auxiliary group created by Valkirie's movement initializer
Boss_ValkirieAuxiliaryMetaspritePartDescriptors:    dc.l    SevenForcesInlinePartDescriptor1+1  ; DATA XREF: Entity_InitValkirieAuxiliaryGroup+1E   o  ; was: off_59F5E
                dc.l    SevenForcesRotationFrameTable1
                dc.l    SevenForcesRotationFrameTable4
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    0
Boss_ValkirieAuxiliaryMetaspriteInitialAngles:  dc.w    $14, $2C14, $2C18  ; DATA XREF: Entity_InitValkirieAuxiliaryGroup+24   o  ; was: word_59F76
Boss_ValkirieAuxiliaryMetaspritePartLinks:      dc.w    $C000, $C001, $C001  ; was: word_59F7C
                                        ; DATA XREF: Entity_InitValkirieAuxiliaryGroup+2A   o
                dc.w    $C001, $C001, 0
; Medusa metasprite initialization and neutral-pose data
Boss_MedusaMetaspritePartDescriptors:   dc.l    word_ECDCA+$400000  ; DATA XREF: Boss_InitMedusaState0+1C   o  ; was: off_59F88
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
Boss_MedusaMetaspriteInitialAngles: dc.w    $18, $1010, $100F  ; DATA XREF: Boss_InitMedusaState0+22   o  ; was: word_59FDC
                dc.w    $1810, $1010, $F18
                dc.w    $1010, $100F, $1810
                dc.w    $1010, $F00
Boss_MedusaMetaspritePartLinks: dc.w    $C005, $C003, $C064  ; was: word_59FF2
                                        ; DATA XREF: Boss_InitMedusaState0+28   o
                dc.w    $C0C4, $C124, $C184
                dc.w    $C003, $C244, $C2A4
                dc.w    $C304, $C364, $C003
                dc.w    $C424, $C484, $C4E4
                dc.w    $C544, $C003, $C604
                dc.w    $C664, $C6C4, $C724
Boss_MedusaMetaspritePoseAngles:    dc.w    $8080, $8080, $8080  ; was: word_5A01C
                                        ; DATA XREF: Boss_InitMedusaState0+34   o
                dc.w    $8000
; Sylpheed metasprite initialization and neutral-pose data
Boss_SylpheedMetaspritePartDescriptors: dc.l    word_ECDCA+$400000  ; DATA XREF: Boss_SylpheedBattleStart+10   o  ; was: off_5A024
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable2
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable4
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesRotationFrameTable6
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable1-$80000000
                dc.l    SevenForcesRotationFrameTable1-$80000000
                dc.l    SevenForcesRotationFrameTable1-$80000000
                dc.l    SevenForcesRotationFrameTable4
                dc.l    SevenForcesRotationFrameTable1
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesRotationFrameTable6
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable0-$68000000
                dc.l    SevenForcesRotationFrameTable0-$68000000
                dc.l    SevenForcesRotationFrameTable0-$68000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable0+$18000000
Boss_SylpheedMetaspriteInitialAngles:   dc.w    $1A, $E0E, $E18  ; DATA XREF: Boss_SylpheedBattleStart+16   o  ; was: word_5A090
                dc.w    $1613, $1318, $1416
                dc.w    $121D, $1212, $1212
                dc.w    $1216, $121D, $1212
                dc.w    $1212, $1200
Boss_SylpheedMetaspritePartLinks:   dc.w    $C00A, $C009, $C068  ; was: word_5A0AC
                                        ; DATA XREF: Boss_SylpheedBattleStart+1C   o
                dc.w    $C0C8, $C128, $C00A
                dc.w    $C1EA, $C24A, $C2AA
                dc.w    $C309, $C36B, $C007
                dc.w    $C426, $C485, $C4E4
                dc.w    $C543, $C5A2, $C602
                dc.w    $C4E6, $C00D, $C72C
                dc.w    $C78D, $C7ED, $C84D
                dc.w    $C8AD, $C90D, $C7ED
Boss_SylpheedMetaspritePoseAngles:  dc.w    $80, $C080, $4040  ; DATA XREF: Boss_SylpheedBattleStart+28   o  ; was: word_5A0E2
                dc.w    $80C0, $8080, $8080
; Artemis metasprite initialization and neutral-pose data
Boss_ArtemisMetaspritePartDescriptors:  dc.l    SevenForcesInlinePartDescriptor0+1  ; DATA XREF: Boss_ArtemisBattleStart+10   o  ; was: off_5A0EE
                dc.l    word_ECDCA+$400000
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable1-$80000000
                dc.l    SevenForcesRotationFrameTable2
                dc.l    SevenForcesRotationFrameTable0-$38000000
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    0
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable1-$80000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable3-$68000000
                dc.l    SevenForcesRotationFrameTable1-$80000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable3-$68000000
                dc.l    SevenForcesRotationFrameTable6
                dc.l    SevenForcesRotationFrameTable1
                dc.l    SevenForcesRotationFrameTable3+$18000000
Boss_ArtemisMetaspriteInitialAngles:    dc.w    $1C, $141A, $120A  ; DATA XREF: Boss_ArtemisBattleStart+16   o  ; was: word_5A166
                dc.w    $1020, $1020, $808
                dc.w    $1020, $1020, $810
                dc.w    $1010, $2208, $1010
                dc.w    $1022, $812, $1212
Boss_ArtemisMetaspritePartLinks:    dc.w    $C008, $C007, $C007  ; was: word_5A184
                                        ; DATA XREF: Boss_ArtemisBattleStart+1C   o
                dc.w    $C067, $C126, $C061
                dc.w    $C1E3, $C1E2, $C2A3
                dc.w    $C2A1, $C361, $C060
                dc.w    $C429, $C42A, $C4E9
                dc.w    $C4E8, $C5A8, $C0C6
                dc.w    $C666, $C6C6, $C6C4
                dc.w    $C784, $C0CB, $C84C
                dc.w    $C8AB, $C8AA, $C96A
                dc.w    $C0C8, $CA27, $CA87
Boss_ArtemisMetaspritePoseAngles:   dc.w    $80, $C0, $C080  ; DATA XREF: Boss_ArtemisBattleStart+28   o  ; was: word_5A1C0
                dc.w    $80C0, $C080, $80A0
                dc.w    $8080, $A080, $8080
                dc.w    $80F0
; Sirene metasprite initialization and neutral-pose data
Boss_SireneMetaspritePartDescriptors:   dc.l    word_ECDCA+$400000  ; DATA XREF: Boss_InitSireneMetasprite+10   o  ; was: off_5A1D4
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesRotationFrameTable2-$40000000
                dc.l    0
                dc.l    SevenForcesRotationFrameTable1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    0
                dc.l    SevenForcesRotationFrameTable0+$18000000
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    0
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
Boss_SireneMetaspriteInitialAngles: dc.w    $8098, $9598, $8494  ; was: word_5A244
                                        ; DATA XREF: Boss_InitSireneMetasprite+16   o
                dc.w    $9090, $9097, $9797
                dc.w    $9798, $8494, $9090
                dc.w    $9097, $9797, $9794
                dc.w    $8EA0, $9898
Boss_SireneMetaspritePartLinks: dc.w    $C008, $C008, $C007  ; was: word_5A260
                                        ; DATA XREF: Boss_InitSireneMetasprite+1C   o
                dc.w    $C000, $C125, $C124
                dc.w    $C1E4, $C244, $C2A2
                dc.w    $C303, $C303, $C303
                dc.w    $C303, $C000, $C4E5
                dc.w    $C4E4, $C5A4, $C604
                dc.w    $C662, $C6C3, $C6C3
                dc.w    $C6C3, $C6C3, $C068
                dc.w    $68, $C908, $C968
                dc.w    $C9C8
Boss_SireneMetaspritePoseAngles:    dc.w    $2080, $60, $8080  ; DATA XREF: Boss_InitSireneMetasprite+28   o  ; was: word_5A298
                dc.w    $C080, $4080
; Alternate Valkirie metasprite initialization and neutral-pose data
Boss_ValkirieAlternateMetaspritePartDescriptors:    dc.l    word_ECDCA+$400000  ; DATA XREF: Boss_ValkirieAlternateInit+10   o  ; was: off_5A2A2
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesRotationFrameTable4
                dc.l    SevenForcesRotationFrameTable6
                dc.l    SevenForcesRotationFrameTable1+$10000000
                dc.l    SevenForcesRotationFrameTable1+$10000000
                dc.l    SevenForcesRotationFrameTable1+$10000000
                dc.l    SevenForcesRotationFrameTable1+$10000000
                dc.l    SevenForcesRotationFrameTable4+$10000000
                dc.l    SevenForcesRotationFrameTable0+$8000000
                dc.l    SevenForcesRotationFrameTable0+$8000000
                dc.l    SevenForcesRotationFrameTable0+$8000000
                dc.l    SevenForcesRotationFrameTable0+$8000000
                dc.l    SevenForcesRotationFrameTable3+$8000000
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable6
                dc.l    SevenForcesRotationFrameTable4
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesRotationFrameTable4
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesRotationFrameTable3+$18000000
Boss_ValkirieAlternateMetaspriteInitialAngles:  dc.w    $1A, $1814, $1D15  ; DATA XREF: Boss_ValkirieAlternateInit+16   o  ; was: word_5A302
                dc.w    $1515, $151D, $1515
                dc.w    $1515, $1428, $1014
                dc.w    $2810, $1412, $1412
Boss_ValkirieAlternateMetaspritePartLinks:  dc.w    $C002, $C003, $C001  ; was: word_5A31A
                                        ; DATA XREF: Boss_ValkirieAlternateInit+1C   o
                dc.w    $C068, $C002, $C182
                dc.w    $C1E2, $C242, $C2A2
                dc.w    $C002, $C362, $C3C2
                dc.w    $C422, $C482, $C063
                dc.w    $C063, $C5A2, $C063
                dc.w    $C063, $C6C2, $C004
                dc.w    $C784, $C004, $C844
Boss_ValkirieAlternateMetaspritePoseAngles: dc.w    0, 0, $C0  ; DATA XREF: Boss_ValkirieAlternateInit+28   o  ; was: word_5A34A
                dc.w    $E0C0, $20C0, $8080
; Unidentified Seven Force metasprite initialization and neutral-pose data
Boss_UnidentifiedSevenForceMetaspritePartDescriptors:   dc.l    word_ECDCA+$400000  ; DATA XREF: Boss_UnidentifiedSevenForceInit+10   o  ; was: off_5A356
                dc.l    SevenForcesInlinePartDescriptor0+1
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesRotationFrameTable1-$80000000
                dc.l    SevenForcesRotationFrameTable2
                dc.l    SevenForcesRotationFrameTable0-$38000000
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesRotationFrameTable3-$48000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    0
                dc.l    SevenForcesInlinePartDescriptor1+1
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesRotationFrameTable3-$48000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable1-$80000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable3-$68000000
                dc.l    SevenForcesRotationFrameTable1-$80000000
                dc.l    SevenForcesRotationFrameTable3+$18000000
                dc.l    SevenForcesRotationFrameTable5+$18000000
                dc.l    SevenForcesInlinePartDescriptor2+1
                dc.l    SevenForcesRotationFrameTable3-$68000000
                dc.l    SevenForcesRotationFrameTable1
                dc.l    SevenForcesRotationFrameTable1
                dc.l    SevenForcesRotationFrameTable3+$28000000
Boss_UnidentifiedSevenForceMetaspriteInitialAngles: dc.w    $1C, $141A, $120A  ; DATA XREF: Boss_UnidentifiedSevenForceInit+16   o  ; was: word_5A3CE
                dc.w    $1020, $1020, $808
                dc.w    $1020, $1020, $810
                dc.w    $1010, $2008, $1010
                dc.w    $1020, $812, $1212
Boss_UnidentifiedSevenForceMetaspritePartLinks: dc.w    $C007, $C008, $C067  ; was: word_5A3EC
                                        ; DATA XREF: Boss_UnidentifiedSevenForceInit+1C   o
                dc.w    $C007, $C126, $C001
                dc.w    $C1E3, $C1E2, $C2A3
                dc.w    $C2A1, $C361, $C000
                dc.w    $C429, $C42A, $C4E9
                dc.w    $C4E8, $C5A8, $C0C6
                dc.w    $C665, $C6C6, $C6C4
                dc.w    $C784, $C0CB, $C84C
                dc.w    $C8AB, $C8AA, $C96A
                dc.w    $C0C7, $CA27, $CA87
Boss_UnidentifiedSevenForceMetaspritePoseAngles:    dc.w    $8080, $C0, $8080  ; DATA XREF: Boss_UnidentifiedSevenForceInit+28   o  ; was: word_5A428
                dc.w    $80C0, $8080, $80A0
                dc.w    $8080, $A080, $8080
                dc.w    $8080
