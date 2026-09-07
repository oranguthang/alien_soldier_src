word_ECB28:     dc.w    $68FC, $600, $F0F0              ; DATA XREF: Boss_BugmaxJumpInit+62   o
                                        ; Boss_BugmaxToggleMouthSprite+E   o
                dc.w    $68F8, $500, $F000
                dc.w    $E8F7, 0, $F010
word_ECB3A:     dc.w    $6902, $500, $F000              ; DATA XREF: Boss_BugmaxToggleMouthSprite:loc_4DB72   o
                dc.w    $E8FC, $600, $F0F0
word_ECB46:     dc.w    $E907, 0, $FCFC                 ; DATA XREF: ROM:off_4CB2E   o
                                        ; ROM:0004CB32   o
word_ECB4C:     dc.w    $E906, 0, $FCFC                 ; DATA XREF: ROM:0004CB3A   o
                                        ; ROM:0004CB3E   o
word_ECB52:     dc.w    $E908, $F00, $F0F0              ; DATA XREF: Boss_BugmaxJumpInit+22   o
word_ECB58:     dc.w    $E918, $A00, $F4F4              ; DATA XREF: ROM:stru_4CB06   o
word_ECB5E:     dc.w    $E921, $500, $F8F8              ; DATA XREF: ROM:0004CB0E   o
                                        ; ROM:0004CB16   o
word_ECB64:     dc.w    $E925, $500, $F8F8              ; DATA XREF: ROM:0004CB1E   o
                                        ; ROM:0004CB26   o
word_ECB6A:     dc.w    $78FC, $600, $F2F4              ; DATA XREF: Boss_BugmaxUpdateLegSprite+4E   o
                dc.w    $78F8, $500, $FA04
                dc.w    $F8F7, 0, $214
word_ECB7C:     dc.w    $692F, $500, $F8                ; DATA XREF: Boss_BugmaxUpdateLegSprite+2E   o
                dc.w    $E929, $900, $F0F8
word_ECB88:     dc.w    $6939, 0, $FCF3                 ; DATA XREF: Boss_BugmaxInit+88   o
                                        ; Boss_BugmaxUpdateLegSprite+3E   o
                dc.w    $E933, $600, $F4FB
word_ECB94:     dc.w    $E93A, $F00, $F0F0              ; DATA XREF: Boss_BugmaxInit+3E   o
word_ECB9A:     dc.w    $E94A, $A00, $F4F4              ; DATA XREF: ROM:stru_4C5BE   o
word_ECBA0:     dc.w    $E953, $500, $F8F8              ; DATA XREF: ROM:0004C5C6   o
                                        ; ROM:0004C5CE   o
word_ECBA6:     dc.w    $E957, $500, $F8F8              ; DATA XREF: ROM:0004C5D6   o
                                        ; ROM:0004C5DE   o
word_ECBAC:     dc.w    $E95B, $A00, $F4F4              ; DATA XREF: ROM:off_ECBD0   o
word_ECBB2:     dc.w    $E976, $500, $F8F8              ; DATA XREF: ROM:000ECBD4   o
word_ECBB8:     dc.w    $E964, $A00, $F4F4              ; DATA XREF: ROM:off_ECBDC   o
word_ECBBE:     dc.w    $E96D, $A00, $F4F4              ; DATA XREF: ROM:000ECBE0   o
word_ECBC4:     dc.w    $F164, $A00, $F4F4              ; DATA XREF: ROM:000ECBE4   o
word_ECBCA:     dc.w    $F16D, $A00, $F4F4              ; DATA XREF: ROM:000ECBE8   o
off_ECBD0:      dc.w    word_ECBAC-*                    ; DATA XREF: Projectile_InitBugmaxSpread+A   o
                                        ; ROM:000ECBD8   o
                dc.w    2
                dc.w    word_ECBB2-*
                dc.w    2
                dc.w    off_ECBD0-*
                dc.w    0
off_ECBDC:      dc.w    word_ECBB8-*                    ; DATA XREF: Projectile_InitBugmaxSine+A   o
                                        ; ROM:000ECBEC   o
                dc.w    6
                dc.w    word_ECBBE-*
                dc.w    6
                dc.w    word_ECBC4-*
                dc.w    6
                dc.w    word_ECBCA-*
                dc.w    6
                dc.w    off_ECBDC-*
                dc.w    0
                dc.w    $6909, $D00, $F8
                dc.w    $6889, $D00, $F0F8
                dc.w    $E891, $200, $F0F0
                dc.w    $6894, $D00, $F8
                dc.w    $6891, $200, $F0F0
                dc.w    $E889, $D00, $F0F8
                dc.w    $E89C, $E00, $F0F0
                dc.w    $E8A8, $A00, $F4F3
                dc.w    $E8B1, $600, $F4F8
                dc.w    $E8B7, $A00, $F3F4
                dc.w    $68D6, $C00, $2F6
                dc.w    $E8D0, $900, $F2F6
                dc.w    $68D6, $C00, $2F3
                dc.w    $E8C8, $D00, $F2F3
                dc.w    $68C0, $D00, $F2F1
                dc.w    $E8D6, $C00, $2F1
                dc.w    $68DA, $900, $2F3
                dc.w    $E8C8, $D00, $F2F3
                dc.w    $E8E0, $700, $F1F8
                dc.w    $E8E8, $600, $F4F6
                dc.w    $E8EE, $A00, $F4F4
                dc.w    $E8F7, $A00, $F4F4
                dc.w    $E900, $500, $F8F8
                dc.w    $E904, $500, $F8F8
                dc.w    $E908, 0, $FCFC
word_ECC86:     dc.w    $4E, 0, $FAE7                   ; DATA XREF: ROM:off_59D42   o
                                        ; ROM:00059D7E   o
                dc.w    $8042, $E00, $F2EF
word_ECC92:     dc.w    $8036, $E00, $F2EF              ; DATA XREF: ROM:00059D46   o
                                        ; ROM:00059D7A   o
word_ECC98:     dc.w    $35, 0, $BEF                    ; DATA XREF: ROM:00059D4A   o
                                        ; ROM:00059D76   o
                dc.w    $8029, $E00, $F3EF
word_ECCA4:     dc.w    $801D, $B00, $F2F6              ; DATA XREF: ROM:00059D4E   o
                                        ; ROM:00059D72   o
word_ECCAA:     dc.w    $1C, 0, $11FC                   ; DATA XREF: ROM:00059D52   o
                                        ; ROM:00059D6E   o
                dc.w    $8010, $B00, $F1F4
word_ECCB6:     dc.w    $9868, $B00, $F1F4              ; DATA XREF: ROM:00059D56   o
                                        ; ROM:00059D6A   o
word_ECCBC:     dc.w    $1867, 0, $90D                  ; DATA XREF: ROM:00059D5A   o
                                        ; ROM:00059D66   o
                dc.w    $985B, $B00, $F1F5
word_ECCC8:     dc.w    $984F, $E00, $F3F3              ; DATA XREF: ROM:00059D5E   o
                                        ; ROM:off_59D62   o
                dc.w    $184E, 0, $FD12
                dc.w    $9842, $E00, $F5F2
word_ECCDA:     dc.w    $8074, $A00, $F3F5              ; DATA XREF: ROM:00059D82   o
                                        ; ROM:00059DBE   o
word_ECCE0:     dc.w    $98B5, $A00, $F2F4              ; DATA XREF: ROM:00059D86   o
                                        ; ROM:00059DBA   o
word_ECCE6:     dc.w    $18B4, 0, $EBFC                 ; DATA XREF: ROM:00059D8A   o
                                        ; ROM:00059DB6   o
                dc.w    $98AB, $A00, $F3F4
word_ECCF2:     dc.w    $98A2, $A00, $F3F4              ; DATA XREF: ROM:00059D8E   o
                                        ; ROM:00059DB2   o
word_ECCF8:     dc.w    $9899, $A00, $F2F4              ; DATA XREF: ROM:00059D92   o
                                        ; ROM:00059DAE   o
word_ECCFE:     dc.w    $9890, $A00, $F3F3              ; DATA XREF: ROM:00059D96   o
                                        ; ROM:00059DAA   o
word_ECD04:     dc.w    $188F, 0, $FCEC                 ; DATA XREF: ROM:00059D9A   o
                                        ; ROM:00059DA6   o
                dc.w    $9886, $A00, $F4F4
word_ECD10:     dc.w    $987D, $A00, $F4F4              ; DATA XREF: ROM:00059D9E   o
                                        ; ROM:off_59DA2   o
word_ECD16:     dc.w    $88D9, $900, $F7F3              ; DATA XREF: ROM:off_59DC2   o
                                        ; ROM:00059DFE   o
word_ECD1C:     dc.w    $98D3, $900, $F7F3              ; DATA XREF: ROM:00059DC6   o
                                        ; ROM:00059DFA   o
word_ECD22:     dc.w    $98CA, $A00, $F5F3              ; DATA XREF: ROM:00059DCA   o
                                        ; ROM:00059DF6   o
word_ECD28:     dc.w    $98C4, $600, $F5FA              ; DATA XREF: ROM:00059DCE   o
                                        ; ROM:00059DF2   o
word_ECD2E:     dc.w    $98BE, $600, $F4F9              ; DATA XREF: ROM:00059DD2   o
                                        ; ROM:00059DEE   o
word_ECD34:     dc.w    $90C4, $600, $F5F8              ; DATA XREF: ROM:00059DD6   o
                                        ; ROM:00059DEA   o
word_ECD3A:     dc.w    $90CA, $A00, $F5F6              ; DATA XREF: ROM:00059DDA   o
                                        ; ROM:00059DE6   o
word_ECD40:     dc.w    $90D3, $900, $F7F6              ; DATA XREF: ROM:00059DDE   o
                                        ; ROM:off_59DE2   o
word_ECD46:     dc.w    $8105, $D00, $F7EE              ; DATA XREF: ROM:off_59E02   o
                                        ; ROM:00059E3E   o
word_ECD4C:     dc.w    $101, $500, $F6FF               ; DATA XREF: ROM:00059E06   o
                                        ; ROM:00059E3A   o
                dc.w    $80FD, $500, $F9EF
word_ECD58:     dc.w    $F5, $700, $ED02                ; DATA XREF: ROM:00059E0A   o
                                        ; ROM:00059E36   o
                dc.w    $80EF, $600, $F5F2
word_ECD64:     dc.w    $E7, $500, $F0F9                ; DATA XREF: ROM:00059E0E   o
                                        ; ROM:00059E32   o
                dc.w    $80EB, $500, $F6
word_ECD70:     dc.w    $88DF, $700, $F1F8              ; DATA XREF: ROM:00059E12   o
                                        ; ROM:00059E2E   o
word_ECD76:     dc.w    $8EB, $500, $FA                 ; DATA XREF: ROM:00059E16   o
                                        ; ROM:00059E2A   o
                dc.w    $88E7, $500, $F0F7
word_ECD82:     dc.w    $8F5, $700, $EDEE               ; DATA XREF: ROM:00059E1A   o
                                        ; ROM:00059E26   o
                dc.w    $88EF, $600, $F5FE
word_ECD8E:     dc.w    $901, $500, $F6F2               ; DATA XREF: ROM:00059E1E   o
                                        ; ROM:off_59E22   o
                dc.w    $88FD, $500, $F902
word_ECD9A:     dc.w    $891D, $500, $F8F8              ; DATA XREF: ROM:off_59E42   o
                                        ; ROM:00059E7E   o
word_ECDA0:     dc.w    $8921, $500, $F8F8              ; DATA XREF: ROM:00059E46   o
                                        ; ROM:00059E7A   o
word_ECDA6:     dc.w    $8925, $500, $F8F8              ; DATA XREF: ROM:00059E4A   o
                                        ; ROM:00059E76   o
word_ECDAC:     dc.w    $8929, $500, $F9F8              ; DATA XREF: ROM:00059E4E   o
                                        ; ROM:00059E72   o
word_ECDB2:     dc.w    $910D, $500, $F8F9              ; DATA XREF: ROM:00059E52   o
                                        ; ROM:00059E6E   o
word_ECDB8:     dc.w    $9111, $500, $F8F9              ; DATA XREF: ROM:00059E56   o
                                        ; ROM:00059E6A   o
word_ECDBE:     dc.w    $9115, $500, $F9FA              ; DATA XREF: ROM:00059E5A   o
                                        ; ROM:00059E66   o
word_ECDC4:     dc.w    $9119, $500, $F9F9              ; DATA XREF: ROM:00059E5E   o
                                        ; ROM:off_59E62   o
word_ECDCA:     dc.w    $961, $100, $4EC                ; DATA XREF: Boss_MedusaIntroMove+10   o
                                        ; ROM:off_59E94   o
                dc.w    $956, $200, $ECEC
                dc.w    $959, $D00, $4F4
                dc.w    $894A, $E00, $ECF4
                dc.w    $4800, $600, $E0F8
                dc.w    $4806, $900, $F8F8
                dc.w    $C80C, $600, $8F8
word_ECDF4:     dc.w    $4824, 0, $1007                 ; DATA XREF: ROM:off_ECE90   o
                dc.w    $4825, $C00, $18EF
                dc.w    $481E, $600, $F7
                dc.w    $481C, $400, $FFF7
                dc.w    $4818, $C00, $F7EF
                dc.w    $C812, $600, $DFF7
word_ECE18:     dc.w    $483C, $100, $10F2              ; DATA XREF: ROM:000ECE94   o
                dc.w    $4834, $700, $FA
                dc.w    $4832, $400, $FBF6
                dc.w    $C82A, $700, $DBF6
word_ECE30:     dc.w    $4848, $700, $FA                ; DATA XREF: ROM:000ECE98   o
                dc.w    $4846, $400, $FBF6
                dc.w    $C83E, $700, $DBF6
word_ECE42:     dc.w    $4861, $C00, $18F1              ; DATA XREF: ROM:000ECE9C   o
                dc.w    $485B, $600, $F9
                dc.w    $4859, $400, $F6
                dc.w    $4856, $800, $F8F6
                dc.w    $C850, $600, $E0F6
word_ECE60:     dc.w    $4869, $800, $18F4              ; DATA XREF: ROM:000ECEA0   o
                dc.w    $4867, $400, $10F4
                dc.w    $4865, $100, $FC
                dc.w    $4846, $400, $FBF6
                dc.w    $C83E, $700, $DBF6
word_ECE7E:     dc.w    $486C, $700, $F8                ; DATA XREF: ROM:000ECEA4   o
                dc.w    $4832, $400, $FBF6
                dc.w    $C82A, $700, $DBF6
off_ECE90:      dc.w    word_ECDF4-*                    ; DATA XREF: Entity_ValkirieProjectileWaitTimer+C   o
                                        ; Entity_SevenForcesIntro+18   o
                dc.w    9
                dc.w    word_ECE18-*
                dc.w    8
                dc.w    word_ECE30-*
                dc.w    8
                dc.w    word_ECE42-*
                dc.w    9
                dc.w    word_ECE60-*
                dc.w    8
                dc.w    word_ECE7E-*
                dc.w    8
                dc.w    off_ECE90-*
                dc.w    0
word_ECEAC:     dc.w    $FF36, $FF, $3A                 ; DATA XREF: Entity_ValkirieProjectileInit+1E   o
                                        ; Entity_ValkirieProjectileCleanup+4   o
                dc.w    $400, $FF0, $83A
                dc.w    $400, $F00, $32
                dc.w    $700, $EFF0, $8832
                dc.w    $700, $EF00, $42
                dc.w    $800, $8EC, $842
                dc.w    $800, $8FC, $883C
                dc.w    $900, $F8F4, $45
                dc.w    $900, $8EC, $845
                dc.w    $900, $8FC, $883C
                dc.w    $900, $F8F4, $8829
                dc.w    $A00, $F4F4
word_ECEF2:     dc.w    $842, $400, $1DF8               ; DATA XREF: ROM:00032128   o
                                        ; ROM:00032148   o
                dc.w    $83A, $700, $FDF8
                dc.w    $882A, $F00, $DDF0
word_ECF04:     dc.w    $85C, $100, $F8DB               ; DATA XREF: ROM:000316AA   o
                                        ; ROM:off_32118   o
                dc.w    $854, $D00, $F8E3
                dc.w    $8844, $F00, $F003
word_ECF16:     dc.w    $874, $A00, $FBDD               ; DATA XREF: ROM:0003211C   o
                                        ; ROM:00032134   o
                dc.w    $86E, $600, $F3F5
                dc.w    $885E, $F00, $EB05
word_ECF28:     dc.w    $898, $400, $3FD                ; DATA XREF: ROM:00032120   o
                                        ; ROM:00032130   o
                dc.w    $896, $100, $F3F5
                dc.w    $88D, $A00, $3E5
                dc.w    $887D, $F00, $E3FD
word_ECF40:     dc.w    $8AA, $A00, $BEE                ; DATA XREF: ROM:00032124   o
                                        ; ROM:0003212C   o
                dc.w    $8B3, $900, $FBF6
                dc.w    $889A, $F00, $DBF6
word_ECF52:     dc.w    $88B9, $800, $FBF5              ; DATA XREF: ROM:off_322C8   o
                                        ; ROM:000322E8   o
word_ECF58:     dc.w    $88BC, $900, $F6F5              ; DATA XREF: ROM:000322CC   o
                                        ; ROM:000322E4   o
word_ECF5E:     dc.w    $88C2, $A00, $F4F3              ; DATA XREF: ROM:000322D0   o
                                        ; ROM:000322E0   o
word_ECF64:     dc.w    $88CB, $600, $F4F7              ; DATA XREF: ROM:000322D4   o
                                        ; ROM:000322DC   o
word_ECF6A:     dc.w    $88D1, $200, $F3FC              ; DATA XREF: ROM:000322D8   o
                                        ; ROM:000322F8   o
word_ECF70:     dc.w    $88D4, $500, $F8F8              ; DATA XREF: ROM:off_316A6   o
word_ECF76:     dc.w    $C84E, $F00, $F0F0              ; DATA XREF: ROM:stru_4E1E0   o
                                        ; ROM:0004E1E8   o
word_ECF7C:     dc.w    $C85E, $F00, $EEF2              ; DATA XREF: ROM:0004F5A0   o
                                        ; ROM:0004F5C0   o
word_ECF82:     dc.w    $C86E, $F00, $F0F0              ; DATA XREF: ROM:0004F5A8   o
                                        ; ROM:0004F5C8   o
word_ECF88:     dc.w    $C87E, $F00, $EEEE              ; DATA XREF: ROM:0004F5B0   o
                                        ; ROM:0004F5D0   o
