Boss_SylpheedSetGraphics:
                move.w  #$C4D6,$E(a5)                   ; was: sub_59D2C
                btst    #0,(word_FFA000+1).w
                beq.s   locret_59D40
                move.w  #$C4DF,$E(a5)
locret_59D40:                                           ; CODE XREF: Boss_SylpheedSetGraphics+C   j
                rts
; End of function Boss_SylpheedSetGraphics
; ---------------------------------------------------------------------------
off_59D42:      dc.l    word_ECC86                      ; DATA XREF: ROM:00059EB8   o
                                        ; ROM:00059EE4   o
                dc.l    word_ECC92
                dc.l    word_ECC98
                dc.l    word_ECCA4
                dc.l    word_ECCAA
                dc.l    word_ECCB6
                dc.l    word_ECCBC
                dc.l    word_ECCC8
off_59D62:      dc.l    word_ECCC8                      ; DATA XREF: ROM:00059EA4   o
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
off_59DA2:      dc.l    word_ECD10                      ; DATA XREF: ROM:00059EA0   o
                                        ; ROM:0005A034   o
                dc.l    word_ECD04
                dc.l    word_ECCFE
                dc.l    word_ECCF8
                dc.l    word_ECCF2
                dc.l    word_ECCE6
                dc.l    word_ECCE0
                dc.l    word_ECCDA
off_59DC2:      dc.l    word_ECD16                      ; DATA XREF: ROM:00059EF4   o
                                        ; ROM:00059F6E   o
                dc.l    word_ECD1C
                dc.l    word_ECD22
                dc.l    word_ECD28
                dc.l    word_ECD2E
                dc.l    word_ECD34
                dc.l    word_ECD3A
                dc.l    word_ECD40
off_59DE2:      dc.l    word_ECD40                      ; DATA XREF: ROM:00059EDC   o
                                        ; ROM:00059F66   o
                dc.l    word_ECD3A
                dc.l    word_ECD34
                dc.l    word_ECD2E
                dc.l    word_ECD28
                dc.l    word_ECD22
                dc.l    word_ECD1C
                dc.l    word_ECD16
off_59E02:      dc.l    word_ECD46                      ; DATA XREF: ROM:00059EC4   o
                                        ; ROM:00059EEC   o
                dc.l    word_ECD4C
                dc.l    word_ECD58
                dc.l    word_ECD64
                dc.l    word_ECD70
                dc.l    word_ECD76
                dc.l    word_ECD82
                dc.l    word_ECD8E
off_59E22:      dc.l    word_ECD8E                      ; DATA XREF: ROM:00059EB0   o
                                        ; ROM:00059ED4   o
                dc.l    word_ECD82
                dc.l    word_ECD76
                dc.l    word_ECD70
                dc.l    word_ECD64
                dc.l    word_ECD58
                dc.l    word_ECD4C
                dc.l    word_ECD46
off_59E42:      dc.l    word_ECD9A                      ; DATA XREF: ROM:00059EB4   o
                dc.l    word_ECDA0
                dc.l    word_ECDA6
                dc.l    word_ECDAC
                dc.l    word_ECDB2
                dc.l    word_ECDB8
                dc.l    word_ECDBE
                dc.l    word_ECDC4
off_59E62:      dc.l    word_ECDC4                      ; DATA XREF: ROM:00059EC8   o
                dc.l    word_ECDBE
                dc.l    word_ECDB8
                dc.l    word_ECDB2
                dc.l    word_ECDAC
                dc.l    word_ECDA6
                dc.l    word_ECDA0
                dc.l    word_ECD9A
word_59E82:     dc.w    $42D, $F00, $F0F0               ; DATA XREF: ROM:00059E98   o
                                        ; ROM:0005A038   o
word_59E88:     dc.w    $43D, $A00, $F4F4               ; DATA XREF: ROM:00059E9C   o
                                        ; ROM:off_59F5E   o
word_59E8E:     dc.w    $446, $500, $F8F8               ; DATA XREF: ROM:00059EAC   o
                                        ; ROM:00059EC0   o
off_59E94:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_ValkirieIntroStop+10   o
                dc.l    word_59E82+1
                dc.l    word_59E88+1
                dc.l    off_59DA2-$40000000
                dc.l    off_59D62
                dc.l    0
                dc.l    word_59E8E+1
                dc.l    off_59E22
                dc.l    off_59E42+$8000000
                dc.l    off_59D42+$18000000
                dc.l    0
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    off_59E62
                dc.l    off_59D62
                dc.l    word_59E8E+1
                dc.l    off_59E22
                dc.l    0
                dc.l    off_59DE2
                dc.l    word_59E8E+1
                dc.l    off_59D42+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    0
                dc.l    off_59DC2+$18000000
                dc.l    word_59E8E+1
word_59EFC:     dc.w    $12, $E15, $1F09                ; DATA XREF: Boss_ValkirieIntroStop+16   o
                dc.w    $1212, $251F, $912
                dc.w    $1225, $192C, $1426
                dc.w    $E04, $192C, $1426
                dc.w    $E04
word_59F16:     dc.w    $C004, $C004, $C064
                                        ; DATA XREF: Boss_ValkirieIntroStop+1C   o
                dc.w    $C002, $C002, $C182
                dc.w    $C182, $C241, $C240
                dc.w    $C002, $C362, $C362
                dc.w    $C421, $C420, $C0C6
                dc.w    $C0C6, $C5A6, $C5A5
                dc.w    $C664, $C665, $C0C6
                dc.w    $C0C6, $C7E6, $C7E5
                dc.w    $C8A4, $C8A5
word_59F4A:     dc.w    $C080, $4000, $8080
                                        ; DATA XREF: Boss_ValkirieIntroStop+28   o
                dc.w    $8080, $80E0, $8080
                dc.w    $80A0, $8080, $8080
                dc.w    $8080
off_59F5E:      dc.l    word_59E88+1                    ; DATA XREF: Boss_ValkirieMovePattern1+1E   o
                dc.l    off_59D62
                dc.l    off_59DE2
                dc.l    off_59D42+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    0
word_59F76:     dc.w    $14, $2C14, $2C18               ; DATA XREF: Boss_ValkirieMovePattern1+24   o
word_59F7C:     dc.w    $C000, $C001, $C001
                                        ; DATA XREF: Boss_ValkirieMovePattern1+2A   o
                dc.w    $C001, $C001, 0
off_59F88:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_MedusaAttackState2+1C   o
                dc.l    word_59E88+1
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    word_59E88+1
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    word_59E88+1
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    word_59E88+1
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59DC2+$18000000
word_59FDC:     dc.w    $18, $1010, $100F               ; DATA XREF: Boss_MedusaAttackState2+22   o
                dc.w    $1810, $1010, $F18
                dc.w    $1010, $100F, $1810
                dc.w    $1010, $F00
word_59FF2:     dc.w    $C005, $C003, $C064
                                        ; DATA XREF: Boss_MedusaAttackState2+28   o
                dc.w    $C0C4, $C124, $C184
                dc.w    $C003, $C244, $C2A4
                dc.w    $C304, $C364, $C003
                dc.w    $C424, $C484, $C4E4
                dc.w    $C544, $C003, $C604
                dc.w    $C664, $C6C4, $C724
word_5A01C:     dc.w    $8080, $8080, $8080
                                        ; DATA XREF: Boss_MedusaAttackState2+34   o
                dc.w    $8000
off_5A024:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_SylpheedBattleStart+10   o
                dc.l    word_59E88+1
                dc.l    word_59E8E+1
                dc.l    word_59E8E+1
                dc.l    off_59DA2
                dc.l    word_59E82+1
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59E02+$18000000
                dc.l    word_59E88+1
                dc.l    off_59DE2
                dc.l    word_59E82+1
                dc.l    off_59E22
                dc.l    word_59E88+1
                dc.l    off_59D62-$80000000
                dc.l    off_59D62-$80000000
                dc.l    off_59D62-$80000000
                dc.l    off_59DE2
                dc.l    off_59D62
                dc.l    word_59E82+1
                dc.l    off_59E22
                dc.l    word_59E88+1
                dc.l    off_59D42-$68000000
                dc.l    off_59D42-$68000000
                dc.l    off_59D42-$68000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59D42+$18000000
word_5A090:     dc.w    $1A, $E0E, $E18                 ; DATA XREF: Boss_SylpheedBattleStart+16   o
                dc.w    $1613, $1318, $1416
                dc.w    $121D, $1212, $1212
                dc.w    $1216, $121D, $1212
                dc.w    $1212, $1200
word_5A0AC:     dc.w    $C00A, $C009, $C068
                                        ; DATA XREF: Boss_SylpheedBattleStart+1C   o
                dc.w    $C0C8, $C128, $C00A
                dc.w    $C1EA, $C24A, $C2AA
                dc.w    $C309, $C36B, $C007
                dc.w    $C426, $C485, $C4E4
                dc.w    $C543, $C5A2, $C602
                dc.w    $C4E6, $C00D, $C72C
                dc.w    $C78D, $C7ED, $C84D
                dc.w    $C8AD, $C90D, $C7ED
word_5A0E2:     dc.w    $80, $C080, $4040               ; DATA XREF: Boss_SylpheedBattleStart+28   o
                dc.w    $80C0, $8080, $8080
off_5A0EE:      dc.l    word_59E82+1                    ; DATA XREF: Boss_ArtemisBattleStart+10   o
                dc.l    word_ECDCA+$400000
                dc.l    word_59E88+1
                dc.l    off_59D62-$80000000
                dc.l    off_59DA2
                dc.l    off_59D42-$38000000
                dc.l    word_59E88+1
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2+$18000000
                dc.l    0
                dc.l    word_59E88+1
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2+$18000000
                dc.l    off_59D62-$80000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2-$68000000
                dc.l    off_59D62-$80000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2-$68000000
                dc.l    off_59E22
                dc.l    off_59D62
                dc.l    off_59DC2+$18000000
word_5A166:     dc.w    $1C, $141A, $120A               ; DATA XREF: Boss_ArtemisBattleStart+16   o
                dc.w    $1020, $1020, $808
                dc.w    $1020, $1020, $810
                dc.w    $1010, $2208, $1010
                dc.w    $1022, $812, $1212
word_5A184:     dc.w    $C008, $C007, $C007
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
word_5A1C0:     dc.w    $80, $C0, $C080                 ; DATA XREF: Boss_ArtemisBattleStart+28   o
                dc.w    $80C0, $C080, $80A0
                dc.w    $8080, $A080, $8080
                dc.w    $80F0
off_5A1D4:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_SireneIntroStop+10   o
                dc.l    word_59E82+1
                dc.l    off_59DA2-$40000000
                dc.l    0
                dc.l    off_59D62
                dc.l    word_59E8E+1
                dc.l    word_59E8E+1
                dc.l    word_59E8E+1
                dc.l    word_59E82+1
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    0
                dc.l    off_59D42+$18000000
                dc.l    word_59E8E+1
                dc.l    word_59E8E+1
                dc.l    word_59E8E+1
                dc.l    word_59E82+1
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59E02+$18000000
                dc.l    0
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
word_5A244:     dc.w    $8098, $9598, $8494
                                        ; DATA XREF: Boss_SireneIntroStop+16   o
                dc.w    $9090, $9097, $9797
                dc.w    $9798, $8494, $9090
                dc.w    $9097, $9797, $9794
                dc.w    $8EA0, $9898
word_5A260:     dc.w    $C008, $C008, $C007
                                        ; DATA XREF: Boss_SireneIntroStop+1C   o
                dc.w    $C000, $C125, $C124
                dc.w    $C1E4, $C244, $C2A2
                dc.w    $C303, $C303, $C303
                dc.w    $C303, $C000, $C4E5
                dc.w    $C4E4, $C5A4, $C604
                dc.w    $C662, $C6C3, $C6C3
                dc.w    $C6C3, $C6C3, $C068
                dc.w    $68, $C908, $C968
                dc.w    $C9C8
word_5A298:     dc.w    $2080, $60, $8080               ; DATA XREF: Boss_SireneIntroStop+28   o
                dc.w    $C080, $4080
off_5A2A2:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_ValkirieAlternateInit+10   o
                dc.l    word_59E82+1
                dc.l    off_59DE2
                dc.l    off_59E22
                dc.l    off_59D62+$10000000
                dc.l    off_59D62+$10000000
                dc.l    off_59D62+$10000000
                dc.l    off_59D62+$10000000
                dc.l    off_59DE2+$10000000
                dc.l    off_59D42+$8000000
                dc.l    off_59D42+$8000000
                dc.l    off_59D42+$8000000
                dc.l    off_59D42+$8000000
                dc.l    off_59DC2+$8000000
                dc.l    word_59E88+1
                dc.l    off_59E22
                dc.l    off_59DE2
                dc.l    word_59E88+1
                dc.l    off_59E02+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    word_59E82+1
                dc.l    off_59DE2
                dc.l    word_59E82+1
                dc.l    off_59DC2+$18000000
word_5A302:     dc.w    $1A, $1814, $1D15               ; DATA XREF: Boss_ValkirieAlternateInit+16   o
                dc.w    $1515, $151D, $1515
                dc.w    $1515, $1428, $1014
                dc.w    $2810, $1412, $1412
word_5A31A:     dc.w    $C002, $C003, $C001
                                        ; DATA XREF: Boss_ValkirieAlternateInit+1C   o
                dc.w    $C068, $C002, $C182
                dc.w    $C1E2, $C242, $C2A2
                dc.w    $C002, $C362, $C3C2
                dc.w    $C422, $C482, $C063
                dc.w    $C063, $C5A2, $C063
                dc.w    $C063, $C6C2, $C004
                dc.w    $C784, $C004, $C844
word_5A34A:     dc.w    0, 0, $C0                       ; DATA XREF: Boss_ValkirieAlternateInit+28   o
                dc.w    $E0C0, $20C0, $8080
off_5A356:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_UnidentifiedSevenForceInit+10   o
                dc.l    word_59E82+1
                dc.l    word_59E88+1
                dc.l    off_59D62-$80000000
                dc.l    off_59DA2
                dc.l    off_59D42-$38000000
                dc.l    word_59E88+1
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    off_59DC2-$48000000
                dc.l    off_59DC2+$18000000
                dc.l    0
                dc.l    word_59E88+1
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    off_59DC2-$48000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59D62-$80000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2-$68000000
                dc.l    off_59D62-$80000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2-$68000000
                dc.l    off_59D62
                dc.l    off_59D62
                dc.l    off_59DC2+$28000000
word_5A3CE:     dc.w    $1C, $141A, $120A               ; DATA XREF: Boss_UnidentifiedSevenForceInit+16   o
                dc.w    $1020, $1020, $808
                dc.w    $1020, $1020, $810
                dc.w    $1010, $2008, $1010
                dc.w    $1020, $812, $1212
word_5A3EC:     dc.w    $C007, $C008, $C067
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
word_5A428:     dc.w    $8080, $C0, $8080               ; DATA XREF: Boss_UnidentifiedSevenForceInit+28   o
                dc.w    $80C0, $8080, $80A0
                dc.w    $8080, $A080, $8080
                dc.w    $8080

; Empty entity state handler in main dispatch table
