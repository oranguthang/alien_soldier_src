word_E8000:     dc.w 0, $EEE, $EC0, $EA0, $E80, $E60, $E40, $E20, $E00, $C00, $A00, $800, $E00, $E00, $E00, $EEE
                                        ; DATA XREF: UI_InitializeSEGAScreen+110   o
unknown_1:      dc.w $8040, $8041, $8042, $8043, $8044, $8045, $8046, $8047
                dc.w $8048, $8049, $804A, $804B, $804C, $804D, $804E, $804F
                dc.w $8050, $8051, $8052, $8053, $8054, $8055, $8056, $8057
                dc.w $8058, $8059, $805A, $805B, $805C, $805D, $805E, $805F
                dc.w $8060, $8061, $8062, $8063, $8064, $8065, $8066, $8067
                dc.w $8068, $8069, $806A, $806B, $806C, $806D, $806E, $806F
sega_tiles:	binclude	"data/artunc/sega.bin"
sega_tiles_End:
word_E8680:     dc.w $800, 0, $F00D     ; DATA XREF: Player_InitPhoenixTrail+E   o
                                        ; Effect_CreateDashTrail+38   o
                dc.w $801, 0, $1818
                dc.w $802, $E00, $F0
                dc.w $80E, $100, $1020
                dc.w $810, $600, $10
                dc.w $816, $100, $F0E5
                dc.w $8818, $F00, $E1ED
word_E86AA:     dc.w $800               ; DATA XREF: Player_InitPhoenixAttack:loc_1582A   o
                                        ; Player_InitiateDashAttack+A0   o ...
                dc.l sprite_F2A28
                dc.w $F00D
                dc.w $801
                dc.l sprite_F2CD0
                dc.w $1818
                dc.w $802
                dc.l sprite_F2A4A+$E000000
                dc.w $F0
                dc.w $80E
                dc.l sprite_F2C8E+$1000000
                dc.w $1020
                dc.w $810
                dc.l sprite_F2BCC+$6000000
                dc.w $10
                dc.w $816
                dc.l sprite_F2CF2+$1000000
                dc.w $F0E5
                dc.w $8818
                dc.l sprite_F2826+$F000000
                dc.w $E1ED
word_E86E2:     dc.w $800               ; DATA XREF: ROM:00016FA8   o
                dc.l sprite_F2D34+$E000000
                dc.w $E0E9
                dc.w $80C
                dc.l sprite_F2EB6+$8000000
                dc.w $D8F1
                dc.w $880F
                dc.l sprite_F2F18+$1000000
                dc.w $D809
word_E86FA:     dc.w $800               ; DATA XREF: ROM:off_16F8C   o
                dc.l sprite_F2F5A+$E000000
                dc.w $DFE7
                dc.w $80C
                dc.l sprite_F313E+$3000000
                dc.w $D707
                dc.w $810
                dc.l sprite_F31C0
                dc.w $D90F
                dc.w $8811
                dc.l sprite_F30DC+$8000000
                dc.w $D7EF
word_E871A:     dc.w $800               ; DATA XREF: ROM:00016F90   o
                dc.l sprite_F3448
                dc.w $D80F
                dc.w $801
                dc.l sprite_F33C6+$3000000
                dc.w $D807
                dc.w $805
                dc.l sprite_F3364+$8000000
                dc.w $D8EF
                dc.w $8808
                dc.l sprite_F31E2+$E000000
                dc.w $E0E7
word_E873A:     dc.w $800               ; DATA XREF: ROM:00016F94   o
                dc.l sprite_F346A+$E000000
                dc.w $E1E8
                dc.w $80C
                dc.l sprite_F3690
                dc.w $D910
                dc.w $80D
                dc.l sprite_F35EC+$8000000
                dc.w $D9F0
                dc.w $810
                dc.l sprite_F364E+$1000000
                dc.w $D908
                dc.w $8812
                dc.l sprite_F3C02+$4000000
                dc.w $F9E8
word_E8762:     dc.w $800               ; DATA XREF: ROM:00016F98   o
                dc.l sprite_F3896+$1000000
                dc.w $D80A
                dc.w $802
                dc.l sprite_F38D8+$8000000
                dc.w $F8EA
                dc.w $805
                dc.l sprite_F3834+$8000000
                dc.w $D8F2
                dc.w $8808
                dc.l sprite_F36B2+$E000000
                dc.w $E0EA
word_E8782:     dc.w $800               ; DATA XREF: ROM:00016F9C   o
                dc.l sprite_F3B9E+$4000000
                dc.w $F7FF
                dc.w $802
                dc.l sprite_F3BE0
                dc.w $EBDF
                dc.w $803
                dc.l sprite_F3B3C+$2000000
                dc.w $DFE7
                dc.w $8806
                dc.l sprite_F393A+$F000000
                dc.w $D7EF
word_E87A2:     dc.w $800               ; DATA XREF: ROM:00016FA0   o
                dc.l sprite_F3F0A+$1000000
                dc.w $D80F
                dc.w $802
                dc.l sprite_F3EA8+$2000000
                dc.w $D807
                dc.w $805
                dc.l sprite_F3E46+$8000000
                dc.w $D8EF
                dc.w $8808
                dc.l sprite_F3C44+$F000000
                dc.w $E0E7
word_E87C2:     dc.w $800               ; DATA XREF: ROM:00016FA4   o
                dc.l sprite_F4192+$1000000
                dc.w $D90F
                dc.w $802
                dc.l sprite_F4130+$2000000
                dc.w $D907
                dc.w $805
                dc.l sprite_F40CE+$8000000
                dc.w $D9EF
                dc.w $808
                dc.l sprite_F41D4+$8000000
                dc.w $F9E7
                dc.w $880B
                dc.l sprite_F3F4C+$E000000
                dc.w $E1E7
word_E87EA:     dc.w $800               ; DATA XREF: ROM:00016FC8   o
                dc.l sprite_F459E+$5000000
                dc.w $10FA
                dc.w $804
                dc.l sprite_F44DC+$9000000
                dc.w $1010
                dc.w $80A
                dc.l sprite_F441A+$6000000
                dc.w $F8E8
                dc.w $810
                dc.l sprite_F43B8+$8000000
                dc.w $F0F8
                dc.w $8813
                dc.l sprite_F4236+$E000000
                dc.w $F8F8
word_E8812:     dc.w $800               ; DATA XREF: ROM:off_16FAC   o
                dc.l sprite_F498A+$1000000
                dc.w $FFE7
                dc.w $802
                dc.l sprite_F4908+$5000000
                dc.w $FDF
                dc.w $806
                dc.l sprite_F4886+$3000000
                dc.w $F7EF
                dc.w $80A
                dc.l sprite_F4804+$5000000
                dc.w $FF17
                dc.w $80E
                dc.l sprite_F47A2+$8000000
                dc.w $EFF7
                dc.w $8811
                dc.l sprite_F4620+$E000000
                dc.w $F7F7
word_E8842:     dc.w $800               ; DATA XREF: ROM:00016FB0   o
                dc.l sprite_F4C32
                dc.w $F80F
                dc.w $801
                dc.l sprite_F4C54+$9000000
                dc.w $10E4
                dc.w $807
                dc.l sprite_F4BB0+$5000000
                dc.w $30F
                dc.w $80B
                dc.l sprite_F4B4E+$2000000
                dc.w $F8EF
                dc.w $880E
                dc.l sprite_F49CC+$B000000
                dc.w $F0F7
word_E886A:     dc.w $800               ; DATA XREF: ROM:00016FB4   o
                dc.l sprite_F5000
                dc.w $F90F
                dc.w $801
                dc.l sprite_F4FDE
                dc.w $90F
                dc.w $802
                dc.l sprite_F4FBC
                dc.w $11F7
                dc.w $803
                dc.l sprite_F4EFA+$9000000
                dc.w $11FF
                dc.w $809
                dc.l sprite_F4E98+$8000000
                dc.w $F1F7
                dc.w $880C
                dc.l sprite_F4D16+$E000000
                dc.w $F9EF
word_E889A:     dc.w $800               ; DATA XREF: ROM:00016FB8   o
                dc.l sprite_F532A+$1000000
                dc.w $D
                dc.w $802
                dc.l sprite_F5308
                dc.w $F80D
                dc.w $803
                dc.l sprite_F5206+$D000000
                dc.w $1000
                dc.w $80B
                dc.l sprite_F51A4+$8000000
                dc.w $F0F5
                dc.w $880E
                dc.l sprite_F5022+$E000000
                dc.w $F8ED
word_E88C2:     dc.w $800               ; DATA XREF: ROM:00016FBC   o
                dc.l sprite_F5674+$9000000
                dc.w $FDF
                dc.w $806
                dc.l sprite_F5612+$2000000
                dc.w $F7EF
                dc.w $809
                dc.l sprite_F5550+$6000000
                dc.w $FF17
                dc.w $80F
                dc.l sprite_F54EE+$8000000
                dc.w $EFF7
                dc.w $8812
                dc.l sprite_F536C+$E000000
                dc.w $F7F7
word_E88EA:     dc.w $800               ; DATA XREF: ROM:00016FC0   o
                dc.l sprite_F5A60
                dc.w $F80F
                dc.w $801
                dc.l sprite_F599E+$6000000
                dc.w $F
                dc.w $807
                dc.l sprite_F597C
                dc.w $18E7
                dc.w $808
                dc.l sprite_F58FA+$5000000
                dc.w $10EF
                dc.w $80C
                dc.l sprite_F57F8+$D000000
                dc.w $EF
                dc.w $8814
                dc.l sprite_F5736+$9000000
                dc.w $F0F7
word_E891A:     dc.w $800               ; DATA XREF: ROM:00016FC4   o
                dc.l sprite_F5D4A
                dc.w $F90F
                dc.w $801
                dc.l sprite_F5D08+$1000000
                dc.w $10F
                dc.w $803
                dc.l sprite_F5C46+$9000000
                dc.w $11FF
                dc.w $809
                dc.l sprite_F5B44+$D000000
                dc.w $1EF
                dc.w $8811
                dc.l sprite_F5A82+$9000000
                dc.w $F1F7
word_E8942:     dc.w $800               ; DATA XREF: Player_ProcessCollisionDamage+18   o
                                        ; Player_UpdateDashSprite+16   o ...
                dc.l sprite_F6036+$4000000
                dc.w $F0F8
                dc.w $802
                dc.l sprite_F6014
                dc.w $18E1
                dc.w $803
                dc.l sprite_F5F92+$5000000
                dc.w $10E9
                dc.w $807
                dc.l sprite_F5F70
                dc.w $1816
                dc.w $808
                dc.l sprite_F5EEE+$5000000
                dc.w $1006
                dc.w $880C
                dc.l sprite_F5D6C+$E000000
                dc.w $F8F0
word_E8972:     dc.w $800               ; DATA XREF: Player_HandleAirMovement+60   o
                                        ; Player_HandleSpecialAttack+B4   o ...
                dc.l sprite_F6078+$F000000
                dc.w $DAEC
                dc.w $810
                dc.l sprite_F627A
                dc.w $F40C
                dc.w $811
                dc.l sprite_F629C+$1000000
                dc.w $EAE4
                dc.w $8813
                dc.l sprite_F6036+$4000000
                dc.w $F0F8
word_E8992:     dc.w $800               ; DATA XREF: ROM:0001704E   o
                                        ; Player_UpdateDashSprite+2A   o ...
                dc.l sprite_F65E8
                dc.w $18E5
                dc.w $801
                dc.l sprite_F6566+$5000000
                dc.w $10ED
                dc.w $805
                dc.l sprite_F6544
                dc.w $180F
                dc.w $806
                dc.l sprite_F64C2+$5000000
                dc.w $10FF
                dc.w $80A
                dc.l sprite_F6460+$8000000
                dc.w $F0F7
                dc.w $880D
                dc.l sprite_F62DE+$E000000
                dc.w $F8EF
word_E89C2:     dc.w $800               ; DATA XREF: Player_HandleAirMovement+66   o
                                        ; Player_DefeatState+6   o ...
                dc.l sprite_F6914
                dc.w $18DF
                dc.w $801
                dc.l sprite_F6892+$5000000
                dc.w $10E7
                dc.w $805
                dc.l sprite_F6870
                dc.w $10F7
                dc.w $806
                dc.l sprite_F67AE+$9000000
                dc.w $10FF
                dc.w $80C
                dc.l sprite_F672C+$5000000
                dc.w $E8
                dc.w $8810
                dc.l sprite_F660A+$A000000
                dc.w $F8F7
word_E89F2:     dc.w $800               ; DATA XREF: Player_RenderWithWeapon+32   o
                                        ; Player_RenderWithWeapon+6E   o
                dc.l sprite_F6ADE+$D000000
                dc.w $10F2
                dc.w $808
                dc.l sprite_F6A9C+$4000000
                dc.w $18DA
                dc.w $80A
                dc.l sprite_F6A1A+$3000000
                dc.w $EA
                dc.w $80E
                dc.l sprite_F69F8
                dc.w $80A
                dc.w $880F
                dc.l sprite_F6936+$9000000
                dc.w $F2
word_E8A1A:     dc.w $800               ; DATA XREF: ROM:off_171EC   o
                dc.l sprite_F6E06
                dc.w $10E
                dc.w $801
                dc.l sprite_F6F2A+$5000000
                dc.w $1603
                dc.w $805
                dc.l sprite_F6E28+$D000000
                dc.w $6EE
                dc.w $80D
                dc.l sprite_F6DC4+$4000000
                dc.w $EE0E
                dc.w $80F
                dc.l sprite_F6D62+$8000000
                dc.w $E6EE
                dc.w $8812
                dc.l sprite_F6BE0+$E000000
                dc.w $EEEE
word_E8A4A:     dc.w $800               ; DATA XREF: ROM:000171F0   o
                dc.l sprite_F72D8
                dc.w $E9F8
                dc.w $801
                dc.l sprite_F7296+$1000000
                dc.w $E100
                dc.w $803
                dc.l sprite_F706E
                dc.w $F110
                dc.w $804
                dc.l sprite_F7152+$5000000
                dc.w $110
                dc.w $808
                dc.l sprite_F71D4+$9000000
                dc.w $1F8
                dc.w $80E
                dc.l sprite_F7090+$6000000
                dc.w $F1E8
                dc.w $8814
                dc.l sprite_F6FAC+$9000000
                dc.w $F1F8
word_E8A82:     dc.w $800               ; DATA XREF: ROM:000171F4   o
                dc.l sprite_F7686+$1000000
                dc.w $E2EE
                dc.w $802
                dc.l sprite_F7664
                dc.w $EAFE
                dc.w $803
                dc.l sprite_F7602+$2000000
                dc.w $FAE6
                dc.w $806
                dc.l sprite_F75E0
                dc.w $F21E
                dc.w $807
                dc.l sprite_F75BE
                dc.w $20E
                dc.w $808
                dc.l sprite_F74FC+$6000000
                dc.w $EA0E
                dc.w $880E
                dc.l sprite_F72FA+$F000000
                dc.w $F2EE
word_E8ABA:     dc.w $800               ; DATA XREF: ROM:000171F8   o
                dc.l sprite_F79D0+$8000000
                dc.w $DF00
                dc.w $803
                dc.l sprite_F790E+$9000000
                dc.w $E7F8
                dc.w $809
                dc.l sprite_F788C+$5000000
                dc.w $F7E8
                dc.w $80D
                dc.l sprite_F778A+$D000000
                dc.w $F7F8
                dc.w $8815
                dc.l sprite_F76C8+$9000000
                dc.w $7F0
word_E8AE2:     dc.w $1000              ; DATA XREF: ROM:000171FC   o
                dc.l sprite_F6E06
                dc.w $F7EC
                dc.w $1001
                dc.l sprite_F6F2A+$5000000
                dc.w $DAEF
                dc.w $1005
                dc.l sprite_F6E28+$D000000
                dc.w $EAF4
                dc.w $100D
                dc.l sprite_F6DC4+$4000000
                dc.w $AE4
                dc.w $100F
                dc.l sprite_F6D62+$8000000
                dc.w $12FC
                dc.w $9012
                dc.l sprite_F6BE0+$E000000
                dc.w $FAF4
word_E8B12:     dc.w $1000              ; DATA XREF: ROM:00017200   o
                dc.l sprite_F72D8
                dc.w $F00
                dc.w $1001
                dc.l sprite_F7296+$1000000
                dc.w $FF8
                dc.w $1003
                dc.l sprite_F706E
                dc.w $7E8
                dc.w $1004
                dc.l sprite_F7152+$5000000
                dc.w $EFE0
                dc.w $1008
                dc.l sprite_F71D4+$9000000
                dc.w $EFF0
                dc.w $100E
                dc.l sprite_F7090+$6000000
                dc.w $F708
                dc.w $9014
                dc.l sprite_F6FAC+$9000000
                dc.w $FFF0
word_E8B4A:     dc.w $1000              ; DATA XREF: ROM:00017204   o
                dc.l sprite_F7686+$1000000
                dc.w $E0A
                dc.w $1002
                dc.l sprite_F7664
                dc.w $EFA
                dc.w $1003
                dc.l sprite_F7602+$2000000
                dc.w $EE12
                dc.w $1006
                dc.l sprite_F75E0
                dc.w $6DA
                dc.w $1007
                dc.l sprite_F75BE
                dc.w $F6EA
                dc.w $1008
                dc.l sprite_F74FC+$6000000
                dc.w $FEE2
                dc.w $900E
                dc.l sprite_F72FA+$F000000
                dc.w $EEF2
word_E8B82:     dc.w $1000              ; DATA XREF: ROM:00017208   o
                dc.l sprite_F79D0+$8000000
                dc.w $18E8
                dc.w $1003
                dc.l sprite_F790E+$9000000
                dc.w $8F0
                dc.w $1009
                dc.l sprite_F788C+$5000000
                dc.w $F808
                dc.w $100D
                dc.l sprite_F778A+$D000000
                dc.w $F8E8
                dc.w $9015
                dc.l sprite_F76C8+$9000000
                dc.w $E8F8
word_E8BAA:     dc.w $800               ; DATA XREF: Player_DefeatState   o
                                        ; sub_1A122   o
                dc.l sprite_F7B76+$D000000
                dc.w $F3EE
                dc.w $808
                dc.l sprite_F7AF4+$5000000
                dc.w $E3EE
                dc.w $880C
                dc.l sprite_F7A32+$6000000
                dc.w $DBFE
word_E8BC2:     dc.w $800               ; DATA XREF: ROM:off_1735E   o
                dc.l sprite_F7EBE+$1000000
                dc.w $EAE5
                dc.w $802
                dc.l sprite_F7D7A+$4000000
                dc.w $E90D
                dc.w $804
                dc.l sprite_F7DBC+$D000000
                dc.w $EAED
                dc.w $880C
                dc.l sprite_F7C78+$D000000
                dc.w $DAED
word_E8BE2:     dc.w $800               ; DATA XREF: ROM:00017362   o
                dc.l sprite_F8124+$1000000
                dc.w $E2E9
                dc.w $802
                dc.l sprite_F8102
                dc.w $E511
                dc.w $8803
                dc.l sprite_F7F00+$F000000
                dc.w $DAF0
word_E8BFA:     dc.w $800               ; DATA XREF: ROM:00017366   o
                dc.l sprite_F8368+$1000000
                dc.w $E2EA
                dc.w $8802
                dc.l sprite_F8166+$F000000
                dc.w $DAF2
word_E8C0A:     dc.w $800               ; DATA XREF: ROM:0001736A   o
                dc.l sprite_F8610+$8000000
                dc.w $EACF
                dc.w $803
                dc.l sprite_F85CE+$1000000
                dc.w $E2E7
                dc.w $805
                dc.l sprite_F85AC
                dc.w $DA0F
                dc.w $8806
                dc.l sprite_F83AA+$F000000
                dc.w $DAEF
word_E8C2A:     dc.w $800               ; DATA XREF: Player_SelectFallAnimation:loc_15E80   o
                dc.l sprite_F891A
                dc.w $20F6
                dc.w $801
                dc.l sprite_F88B8+$8000000
                dc.w $18F6
                dc.w $804
                dc.l sprite_F8736+$E000000
                dc.w $EE
                dc.w $810
                dc.l sprite_F86F4+$4000000
                dc.w $F0F6
                dc.w $8812
                dc.l sprite_F8672+$C000000
                dc.w $F8EE
word_E8C52:     dc.w $800               ; DATA XREF: Player_SelectFallAnimation:loc_15E88   o
                dc.l sprite_F8ABE+$4000000
                dc.w $EFF6
                dc.w $802
                dc.l sprite_F8B00+$7000000
                dc.w $FFE
                dc.w $880A
                dc.l sprite_F893C+$E000000
                dc.w $F7EE
word_E8C6A:     dc.w $800               ; DATA XREF: Player_SelectFallAnimation+1A   o
                dc.l sprite_F8D86+$7000000
                dc.w $10FA
                dc.w $808
                dc.l sprite_F8CC4+$9000000
                dc.w $F2
                dc.w $880E
                dc.l sprite_F8C02+$9000000
                dc.w $F0F6
word_E8C82:     dc.w $800               ; DATA XREF: Gfx_DrawBossHealthUI:loc_15E56   o
                dc.l sprite_F906E+$2000000
                dc.w $D70E
                dc.w $803
                dc.l sprite_F902C+$1000000
                dc.w $DFEE
                dc.w $8805
                dc.l sprite_F8EAA+$B000000
                dc.w $D7F6
word_E8C9A:     dc.w $800               ; DATA XREF: Gfx_DrawBossHealthUI+E   o
                dc.l sprite_F92D8+$8000000
                dc.w $CFF6
                dc.w $803
                dc.l sprite_F9256+$C000000
                dc.w $D7F6
                dc.w $807
                dc.l sprite_F9214+$1000000
                dc.w $DFEE
                dc.w $809
                dc.l sprite_F91D2+$4000000
                dc.w $EFF6
                dc.w $880B
                dc.l sprite_F90D0+$D000000
                dc.w $DFF6
word_E8CC2:     dc.w $800               ; DATA XREF: ROM:off_1703A   o
                dc.l sprite_F951E+$9000000
                dc.w $10F6
                dc.w $806
                dc.l sprite_F94BC+$8000000
                dc.w $F0F6
                dc.w $8809
                dc.l sprite_F933A+$E000000
                dc.w $F8EE
word_E8CDA:     dc.w $800               ; DATA XREF: ROM:0001703E   o
                dc.l sprite_F95E0+$B000000
                dc.w $F0F8
                dc.w $880C
                dc.l sprite_F9762+$D000000
                dc.w $10F2
word_E8CEA:     dc.w $800               ; DATA XREF: ROM:00017042   o
                dc.l sprite_F99E6+$8000000
                dc.w $F0F8
                dc.w $803
                dc.l sprite_F9B6C
                dc.w $18E8
                dc.w $804
                dc.l sprite_F9B4A
                dc.w $1810
                dc.w $805
                dc.l sprite_F9864+$E000000
                dc.w $F8F0
                dc.w $8811
                dc.l sprite_F9A48+$D000000
                dc.w $10F0
word_E8D12:     dc.w $800               ; DATA XREF: ROM:00017046   o
                dc.l sprite_F9D10+$8000000
                dc.w $F0F8
                dc.w $803
                dc.l sprite_F9D72+$9000000
                dc.w $10F8
                dc.w $8809
                dc.l sprite_F9B8E+$E000000
                dc.w $F8F0
word_E8D2A:     dc.w $800               ; DATA XREF: ROM:0001704A   o
                dc.l sprite_FA0DC
                dc.w $18E9
                dc.w $801
                dc.l sprite_F9FDA+$D000000
                dc.w $10F1
                dc.w $809
                dc.l sprite_F9FB8
                dc.w $F0
                dc.w $80A
                dc.l sprite_F9F56+$8000000
                dc.w $8F0
                dc.w $880D
                dc.l sprite_F9E34+$A000000
                dc.w $F0F8
word_E8D52:     dc.w $800               ; DATA XREF: ROM:000172CC   o
                dc.l sprite_FA284+$4000000
                dc.w $F90B
                dc.w $802
                dc.l sprite_FA202+$C000000
                dc.w $F1FB
                dc.w $806
                dc.l sprite_FA1C0+$1000000
                dc.w $D1FB
                dc.w $8808
                dc.l sprite_FA0FE+$9000000
                dc.w $E1FB
word_E8D72:     dc.w $800               ; DATA XREF: ROM:000172C8   o
                dc.l sprite_FA3C8
                dc.w $F018
                dc.w $801
                dc.l sprite_FA44C+$5000000
                dc.w $D8E8
                dc.w $805
                dc.l sprite_FA3EA+$8000000
                dc.w $E0F8
                dc.w $8808
                dc.l sprite_FA2C6+$D000000
                dc.w $E8F8
word_E8D92:     dc.w $800               ; DATA XREF: ROM:off_172BC   o
                dc.l sprite_FA692+$9000000
                dc.w $E3DE
                dc.w $806
                dc.l sprite_FA5D0+$9000000
                dc.w $EBF6
                dc.w $880C
                dc.l sprite_FA4CE+$D000000
                dc.w $DBF6
word_E8DAA:     dc.w $800               ; DATA XREF: ROM:000172C4   o
                dc.l sprite_FA8B8+$9000000
                dc.w $F3EC
                dc.w $806
                dc.l sprite_FA876+$1000000
                dc.w $DB09
                dc.w $8808
                dc.l sprite_FA754+$A000000
                dc.w $DBF1
word_E8DC2:     dc.w $800               ; DATA XREF: ROM:000172C0   o
                dc.l sprite_FAABE+$6000000
                dc.w $F5F6
                dc.w $806
                dc.l sprite_FAA9C
                dc.w $D5FE
                dc.w $8807
                dc.l sprite_FA97A+$A000000
                dc.w $DDEE
word_E8DDA:     dc.w $800               ; DATA XREF: ROM:00017308   o
                dc.l sprite_FAD44+$6000000
                dc.w $CBF3
                dc.w $806
                dc.l sprite_FAD02+$4000000
                dc.w $FB0B
                dc.w $8808
                dc.l sprite_FAB80+$E000000
                dc.w $E3F3
word_E8DF2:     dc.w $800               ; DATA XREF: ROM:00017304   o
                dc.l sprite_FAF08+$5000000
                dc.w $F209
                dc.w $804
                dc.l sprite_FAFEC+$6000000
                dc.w $D7E1
                dc.w $80A
                dc.l sprite_FAF8A+$8000000
                dc.w $F2F1
                dc.w $880D
                dc.l sprite_FAE06+$D000000
                dc.w $E2F1
word_E8E12:     dc.w $800               ; DATA XREF: ROM:off_172F8   o
                dc.l sprite_FB354
                dc.w $E4E5
                dc.w $801
                dc.l sprite_FB2B0+$4000000
                dc.w $F40D
                dc.w $803
                dc.l sprite_FB2F2+$8000000
                dc.w $ECD5
                dc.w $8806
                dc.l sprite_FB0AE+$F000000
                dc.w $DCED
word_E8E32:     dc.w $800               ; DATA XREF: ROM:00017300   o
                dc.l sprite_FB5FA+$5000000
                dc.w $F6DD
                dc.w $804
                dc.l sprite_FB578+$5000000
                dc.w $EE0A
                dc.w $8808
                dc.l sprite_FB376+$F000000
                dc.w $DEEA
word_E8E4A:     dc.w $800               ; DATA XREF: ROM:000172FC   o
                dc.l sprite_FB7FE+$4000000
                dc.w $ED0A
                dc.w $802
                dc.l sprite_FB8A2+$1000000
                dc.w $E7EA
                dc.w $804
                dc.l sprite_FB840+$2000000
                dc.w $FAF2
                dc.w $8807
                dc.l sprite_FB67C+$B000000
                dc.w $DAF2
word_E8E6A:     dc.w 0                  ; DATA XREF: Player_PhoenixAttackUpdate+4E   o
                                        ; Player_InitiateDashAttack+84   o ...
                dc.l sprite_FBEF6+$D000000
                dc.w $B09
                dc.w 8
                dc.l sprite_FBEB4+$4000000
                dc.w $309
                dc.w $A
                dc.l sprite_FBE32+$C000000
                dc.w $FB09
                dc.w $E
                dc.l sprite_FBDD0+$8000000
                dc.w $F309
                dc.w $11
                dc.l sprite_FBDAE
                dc.w $E329
                dc.w $12
                dc.l sprite_FBAE8+$1000000
                dc.w $F3E9
                dc.w $14
                dc.l sprite_FBCAC+$D000000
                dc.w $E309
                dc.w $1C
                dc.l sprite_FBB2A+$E000000
                dc.w $3E9
                dc.w $28
                dc.l sprite_FB8E4+$5000000
                dc.w $F7D9
                dc.w $802C
                dc.l sprite_FB966+$B000000
                dc.w $E3F1
word_E8EBA:     dc.w 0                  ; DATA XREF: Credits_VBlankHandler+42   o
                                        ; Effect_CreateDashTrail+6   o ...
                dc.l sprite_FC728+$5000000
                dc.w $F430
                dc.w 4
                dc.l sprite_FC480
                dc.w $ECD8
                dc.w 5
                dc.l sprite_FC4A2+$D000000
                dc.w $E4E0
                dc.w $D
                dc.l sprite_FC5A4+$D000000
                dc.w $E400
                dc.w $15
                dc.l sprite_FC6A6+$5000000
                dc.w $E420
                dc.w $19
                dc.l sprite_FC23C+$E000000
                dc.w $F400
                dc.w $25
                dc.l sprite_FC3BE+$6000000
                dc.w $F420
                dc.w $2B
                dc.l sprite_FC7AA+$8000000
                dc.w $FB40
                dc.w $2E
                dc.l sprite_FC0BA+$E000000
                dc.w $F4E0
                dc.w $803A
                dc.l sprite_FBFF8+$6000000
                dc.w $F4D0
word_E8F0A:     dc.w $800               ; DATA XREF: Player_HandleDefeatByBoss+1E   o
                                        ; Player_RenderWithWeapon+1E   o ...
                dc.l sprite_FC8F0
                dc.w 3
                dc.w $801
                dc.l sprite_FC82E+$6000000
                dc.w $803
                dc.w $8807
                dc.l sprite_FC912+$B000000
                dc.w $EB
word_E8F22:     dc.w 4, 0, $ECD8        ; DATA XREF: Player_TeleportDash+60   o
                                        ; Player_SpawnProjectile+30   o ...
                dc.w 5, $D00, $E4E0
                dc.w $D, $D00, $E400
                dc.w $8015, $500, $E420
word_E8F3A:     dc.w $800               ; DATA XREF: Player_HandleSpecialAttack:loc_16056   o
                                        ; sub_16116   o ...
                dc.l sprite_FCF40+$5000000
                dc.w $17F9
                dc.w $804
                dc.l sprite_FCEBE+$5000000
                dc.w $1711
                dc.w $808
                dc.l sprite_FCD7A+$9000000
                dc.w $701
                dc.w $80E
                dc.l sprite_FCE3C+$5000000
                dc.w $7F1
                dc.w $812
                dc.l sprite_FCD38+$1000000
                dc.w $F7F1
                dc.w $8814
                dc.l sprite_FCA94+$A000000
                dc.w $EFF9
word_E8F6A:     dc.w $800               ; DATA XREF: Player_HandleSpecialAttack+A0   o
                                        ; Player_CheckSpecialAttack+E   o ...
                dc.l sprite_FCBB6+$E000000
                dc.w $EFF9
                dc.w $80C
                dc.l sprite_FCF40+$5000000
                dc.w $17F9
                dc.w $810
                dc.l sprite_FCEBE+$5000000
                dc.w $1711
                dc.w $814
                dc.l sprite_FCD7A+$9000000
                dc.w $701
                dc.w $81A
                dc.l sprite_FCE3C+$5000000
                dc.w $7F1
                dc.w $881E
                dc.l sprite_FCD38+$1000000
                dc.w $F7F1
word_E8F9A:     dc.w $800               ; DATA XREF: ROM:off_17242   o
                dc.l sprite_FD0C4+$9000000
                dc.w $5F3
                dc.w $806
                dc.l sprite_FCFC2+$7000000
                dc.w $E3F5
                dc.w $80E
                dc.l sprite_FD2EC
                dc.w $E2DC
                dc.w $80F
                dc.l sprite_FD26A+$C000000
                dc.w $E2E4
                dc.w $8813
                dc.l sprite_FD1E8+$C000000
                dc.w $E204
word_E8FC2:     dc.w $800               ; DATA XREF: ROM:00017246   o
                dc.l sprite_FD0C4+$9000000
                dc.w $5F3
                dc.w $806
                dc.l sprite_FCFC2+$7000000
                dc.w $E7F5
                dc.w $80E
                dc.l sprite_FD2EC
                dc.w $E2DC
                dc.w $80F
                dc.l sprite_FD26A+$C000000
                dc.w $E2E4
                dc.w $8813
                dc.l sprite_FD1E8+$C000000
                dc.w $E204
word_E8FEA:     dc.w $800               ; DATA XREF: ROM:0001724A   o
                dc.l sprite_FCFC2+$7000000
                dc.w $EAF5
                dc.w $808
                dc.l sprite_FD0C4+$9000000
                dc.w $5F3
                dc.w $80E
                dc.l sprite_FD2EC
                dc.w $E2DC
                dc.w $80F
                dc.l sprite_FD26A+$C000000
                dc.w $E2E4
                dc.w $8813
                dc.l sprite_FD1E8+$C000000
                dc.w $E204
word_E9012:     dc.w $800               ; DATA XREF: ROM:0001724E   o
                dc.l sprite_FCFC2+$7000000
                dc.w $ECF5
                dc.w $808
                dc.l sprite_FD186+$8000000
                dc.w $9F3
                dc.w $80B
                dc.l sprite_FD2EC
                dc.w $E2DC
                dc.w $80C
                dc.l sprite_FD26A+$C000000
                dc.w $E2E4
                dc.w $8810
                dc.l sprite_FD1E8+$C000000
                dc.w $E204
word_E903A:     dc.w $800               ; DATA XREF: ROM:00017252   o
                dc.l sprite_FCFC2+$7000000
                dc.w $EDF5
                dc.w $8808
                dc.l sprite_FD186+$8000000
                dc.w $9F3
word_E904A:     dc.w $800               ; DATA XREF: ROM:00017256   o
                dc.l sprite_FCFC2+$7000000
                dc.w $EEF5
                dc.w $8808
                dc.l sprite_FD186+$8000000
                dc.w $9F3
word_E905A:     dc.w $800               ; DATA XREF: ROM:0001725A   o
                dc.l sprite_FCFC2+$7000000
                dc.w $EAF5
                dc.w $8808
                dc.l sprite_FD186+$8000000
                dc.w $9F3
word_E906A:     dc.w $800               ; DATA XREF: ROM:0001725E   o
                dc.l sprite_FCFC2+$7000000
                dc.w $E6F5
                dc.w $8808
                dc.l sprite_FD186+$8000000
                dc.w $9F3
word_E907A:     dc.w $5079, $A00, $E8   ; DATA XREF: Enemy_FloatingOscillator+22   o
                                        ; ROM:000E9544   o ...
                dc.w $5879, $A00, 0
                dc.w $4079, $A00, $E8E8
                dc.w $C879, $A00, $E800
word_E9092:     dc.w $5082, $A00, $E8   ; DATA XREF: ROM:000E9548   o
                                        ; ROM:000E956C   o ...
                dc.w $4082, $A00, $E8E8
                dc.w $5882, $A00, 0
                dc.w $C882, $A00, $E800
word_E90AA:     dc.w $C88B, $F00, $F0F0 ; DATA XREF: ROM:000E954C   o
                                        ; ROM:000E9570   o ...
word_E90B0:     dc.w $C89B, $F00, $F0F0 ; DATA XREF: ROM:000E9550   o
                                        ; ROM:000E9574   o ...
word_E90B6:     dc.w $C8AB, $F00, $F0F0 ; DATA XREF: ROM:000E9554   o
                                        ; ROM:000E9578   o ...
word_E90BC:     dc.w $C8BB, $F00, $F0F0 ; DATA XREF: ROM:000E9558   o
                                        ; ROM:000E955C   o ...
word_E90C2:     dc.w $C800, $A00, $F4F4 ; DATA XREF: Boss_ArtemisUpdateSprites+2E   o
                                        ; ROM:off_E953C   o ...
word_E90C8:     dc.w $C8CB, $F00, $F0F0 ; DATA XREF: ROM:000E9540   o
                                        ; ROM:000E9564   o ...
word_E90CE:     dc.w $C8EC, $F00, $F0F0 ; DATA XREF: ROM:000E95E4   o
                                        ; ROM:000E960C   o
word_E90D4:     dc.w $C8FC, $100, $F8FC ; DATA XREF: ROM:0002B6CC   o
                                        ; ROM:off_E9774   o ...
word_E90DA:     dc.w $C8FE, $400, $FCF8 ; DATA XREF: ROM:off_2B6C4   o
                                        ; ROM:000E977C   o ...
word_E90E0:     dc.w $C900, $500, $F8F8 ; DATA XREF: ROM:0002B6C8   o
                                        ; ROM:000E9778   o ...
word_E90E6:     dc.w $C100, $500, $F8F8 ; DATA XREF: ROM:0002B6D0   o
                                        ; ROM:000E9780   o ...
word_E90EC:     dc.w $C86C, 0, $FCFC    ; DATA XREF: ROM:off_E97E0   o
word_E90F2:     dc.w $C86D, $500, $F8F8 ; DATA XREF: ROM:off_E97D4   o
word_E90F8:     dc.w $C871, 0, $FCFC    ; DATA XREF: ROM:000E97E4   o
word_E90FE:     dc.w $4873, 0, $FCFC    ; DATA XREF: ROM:000E97A0   o
                                        ; ROM:000E97B0   o
                dc.w $50DB, 0, $F8
                dc.w $58DB, 0, 0
                dc.w $40DB, 0, $F8F8
                dc.w $C8DB, 0, $F800
word_E911C:     dc.w $4840, $500, $F8F8 ; DATA XREF: ROM:000E97A4   o
                                        ; ROM:000E97AC   o
                dc.w $50DB, 0, $F8
                dc.w $58DB, 0, 0
                dc.w $40DB, 0, $F8F8
                dc.w $C8DB, 0, $F800
word_E913A:     dc.w $50DB, 0, $F8      ; DATA XREF: ROM:off_E979C   o
                dc.w $58DB, 0, 0
                dc.w $40DB, 0, $F8F8
                dc.w $C8DB, 0, $F800
word_E9152:     dc.w $50DC, 0, $F8      ; DATA XREF: ROM:off_E97B8   o
                dc.w $58DC, 0, 0
                dc.w $40DC, 0, $F8F8
                dc.w $C8DC, 0, $F800
word_E916A:     dc.w $4856, $A00, $F4F4 ; DATA XREF: ROM:000E97A8   o
                dc.w $50DB, 0, $F8
                dc.w $58DB, 0, 0
                dc.w $40DB, 0, $F8F8
                dc.w $C8DB, 0, $F800
word_E9188:     dc.w $C82C, $500, $F8F8 ; DATA XREF: ROM:000E95A8   o
                                        ; ROM:000E95C4   o ...
word_E918E:     dc.w $C830, $500, $F8F8 ; DATA XREF: ROM:000E95AC   o
                                        ; ROM:000E95C8   o
word_E9194:     dc.w $C834, $500, $F8F8 ; DATA XREF: ROM:000E95B0   o
                                        ; ROM:000E95CC   o
word_E919A:     dc.w $C838, $500, $F8F8 ; DATA XREF: ROM:000E95B4   o
                                        ; ROM:000E95D0   o
word_E91A0:     dc.w $C868, $500, $F8F8 ; DATA XREF: ROM:000E95B8   o
                                        ; ROM:000E95BC   o ...
word_E91A6:     dc.w $C809, $A00, $F4F4 ; DATA XREF: ROM:000E95EC   o
                                        ; ROM:000E9614   o
word_E91AC:     dc.w $C812, $A00, $F4F4 ; DATA XREF: ROM:000E95F0   o
                                        ; ROM:000E9618   o
word_E91B2:     dc.w $C81B, $A00, $F4F4 ; DATA XREF: ROM:000E95F4   o
                                        ; ROM:000E961C   o
word_E91B8:     dc.w $C824, $500, $F8F8 ; DATA XREF: ROM:000E95F8   o
                                        ; ROM:000E9620   o
word_E91BE:     dc.w $C828, $500, $F8F8 ; DATA XREF: ROM:000E95FC   o
                                        ; ROM:000E9600   o ...
word_E91C4:     dc.w $C83C, $500, $F8F8 ; DATA XREF: ROM:off_E962C   o
                                        ; ROM:off_E964C   o ...
word_E91CA:     dc.w $C840, $500, $F8F8 ; DATA XREF: ROM:000E9630   o
                                        ; ROM:000E9654   o ...
word_E91D0:     dc.w $C873, 0, $FCFC    ; DATA XREF: ROM:off_E9638   o
                                        ; ROM:000E9650   o
word_E91D6:     dc.w $C872, 0, $FCFC    ; DATA XREF: ROM:000E9640   o
                                        ; ROM:000E9658   o
                dc.w $4856, $A00, $F4F4
                dc.w $50DB, 0, $F8
                dc.w $58DB, 0, 0
                dc.w $40DB, 0, $F8F8
                dc.w $C8DB, 0, $F800
word_E91FA:     dc.w $C874, 0, $FCFC    ; DATA XREF: Boss_XiTigerProjectileInit+1E   o
                                        ; Boss_GustheadCoreDefeat+36   o ...
word_E9200:     dc.w $C875, 0, $FCFC    ; DATA XREF: ROM:000E9664   o
                                        ; ROM:000E9670   o ...
word_E9206:     dc.w $C856, $A00, $F4F4 ; DATA XREF: ROM:off_E9680   o
                                        ; ROM:off_E968C   o ...
word_E920C:     dc.w $C85F, $A00, $F4F4 ; DATA XREF: ROM:000E9684   o
                                        ; ROM:000E9690   o ...
word_E9212:     dc.w $C844, $500, $F8F8 ; DATA XREF: ROM:000E96BC   o
                                        ; ROM:000E96C8   o ...
word_E9218:     dc.w $C871, 0, $FCFC    ; DATA XREF: ROM:000E96C0   o
                                        ; ROM:000E96C4   o ...
word_E921E:     dc.w $C876, 0, $FCFC    ; DATA XREF: ROM:000E96E8   o
                                        ; ROM:000E96F4   o ...
word_E9224:     dc.w $C877, 0, $FCFC    ; DATA XREF: ROM:000E96E4   o
                                        ; ROM:000E9754   o
word_E922A:     dc.w $4873, 0, $FCFC    ; DATA XREF: ROM:000E97BC   o
                                        ; ROM:000E97CC   o
                dc.w $50DC, 0, $F8
                dc.w $58DC, 0, 0
                dc.w $40DC, 0, $F8F8
                dc.w $C8DC, 0, $F800
word_E9248:     dc.w $4840, $500, $F8F8 ; DATA XREF: ROM:000E97C0   o
                                        ; ROM:000E97C8   o
                dc.w $50DC, 0, $F8
                dc.w $58DC, 0, 0
                dc.w $40DC, 0, $F8F8
                dc.w $C8DC, 0, $F800
word_E9266:     dc.w $4856, $A00, $F4F4 ; DATA XREF: ROM:000E97C4   o
                dc.w $50DC, 0, $F8
                dc.w $58DC, 0, 0
                dc.w $40DC, 0, $F8F8
                dc.w $C8DC, 0, $F800
word_E9284:     dc.w $48E3, $A00, $FEFE ; DATA XREF: ROM:000E97F4   o
                dc.w $D0E3, $A00, $EAEA
word_E9290:     dc.w $40E0, $800, $FCE8 ; DATA XREF: ROM:000E97F0   o
                dc.w $C8E0, $800, $FC00
word_E929C:     dc.w $58DD, $200, $E8FC ; DATA XREF: ROM:off_E97EC   o
                dc.w $C8DD, $200, $FC
                dc.w $48E3, $A00, $EAEC
                dc.w $50E3, $A00, $D6D8
                dc.w $48E3, $A00, $1214
                dc.w $D0E3, $A00, $FE00
                dc.w $40E0, $800, $FCD0
                dc.w $48E0, $800, $FCE8
                dc.w $40E0, $800, $FC00
                dc.w $C8E0, $800, $FC18
                dc.w $58DD, $200, $FC
                dc.w $48DD, $200, $18FC
                dc.w $58DD, $200, $D0FC
                dc.w $C8DD, $200, $E8FC
word_E92F0:     dc.w $4809, $A00, $F409 ; DATA XREF: ROM:off_E9818   o
                dc.w $4812, $A00, $F4F9
                dc.w $481B, $A00, $F4EE
                dc.w $4824, $500, $F8E7
                dc.w $C828, $500, $F8DD
word_E930E:     dc.w $5809, $A00, $F409 ; DATA XREF: ROM:000E981C   o
                dc.w $5812, $A00, $F4F9
                dc.w $581B, $A00, $F4ED
                dc.w $5824, $500, $F8E6
                dc.w $D828, $500, $F8DD
word_E932C:     dc.w $5009, $A00, $F40A ; DATA XREF: ROM:000E9820   o
                dc.w $5012, $A00, $F4FA
                dc.w $501B, $A00, $F4ED
                dc.w $5024, $500, $F8E6
                dc.w $D028, $500, $F8DC
word_E934A:     dc.w $4009, $A00, $F40A ; DATA XREF: ROM:000E9824   o
                dc.w $4012, $A00, $F4FA
                dc.w $401B, $A00, $F4EE
                dc.w $4024, $500, $F8E7
                dc.w $C028, $500, $F8DC
word_E9368:     dc.w $48CB, $F00, $F0F0 ; DATA XREF: ROM:000E9838   o
                                        ; ROM:000E9858   o
                dc.w $488B, $F00, $F0
                dc.w $488B, $F00, $E0F0
                dc.w $488B, $F00, $F000
                dc.w $C88B, $F00, $F0E0
word_E9386:     dc.w $488B, $F00, $F0F0 ; DATA XREF: ROM:000E983C   o
                                        ; ROM:000E985C   o
                dc.w $588B, $F00, $DCF0
                dc.w $408B, $F00, $F0DC
                dc.w $488B, $F00, $F004
                dc.w $488B, $F00, $5F0
                dc.w $489B, $F00, $E0
                dc.w $409B, $F00, 0
                dc.w $589B, $F00, $E0E0
                dc.w $D09B, $F00, $E000
word_E93BC:     dc.w $488B, $F00, $F0F0 ; DATA XREF: ROM:000E9840   o
                                        ; ROM:000E9860   o
                dc.w $409B, $F00, $F0D8
                dc.w $589B, $F00, $D8F0
                dc.w $489B, $F00, $F008
                dc.w $489B, $F00, $8F0
                dc.w $489B, $F00, $3DD
                dc.w $409B, $F00, $303
                dc.w $509B, $F00, $DD03
                dc.w $D89B, $F00, $DDDD
word_E93F2:     dc.w $C84C, $500, $F8F8 ; DATA XREF: ROM:off_E96FC   o
                                        ; ROM:off_E9710   o ...
word_E93F8:     dc.w $C850, $500, $F8F8 ; DATA XREF: ROM:000E9700   o
                                        ; ROM:000E9714   o ...
word_E93FE:     dc.w $C854, 0, $FCFC    ; DATA XREF: ROM:000E9704   o
                                        ; ROM:000E9718   o ...
word_E9404:     dc.w $C855, 0, $FCFC    ; DATA XREF: ROM:000E9708   o
                                        ; ROM:000E970C   o ...
word_E940A:     dc.w $489B, $F00, $F0F0 ; DATA XREF: ROM:000E9844   o
                                        ; ROM:000E9864   o
                dc.w $58AB, $F00, $D6F0
                dc.w $40AB, $F00, $F00A
                dc.w $48AB, $F00, $AF0
                dc.w $48AB, $F00, $F0D6
                dc.w $58AB, $F00, $DB05
                dc.w $40AB, $F00, $5DB
                dc.w $48AB, $F00, $505
                dc.w $D0AB, $F00, $DBDB
word_E9440:     dc.w $48AB, $F00, $F0F0 ; DATA XREF: ROM:000E9848   o
                                        ; ROM:000E9868   o
                dc.w $40BB, $F00, $F00C
                dc.w $48BB, $F00, $CF0
                dc.w $48BB, $F00, $F0D4
                dc.w $58BB, $F00, $D4F0
                dc.w $48BB, $F00, $DBDB
                dc.w $40BB, $F00, $DB05
                dc.w $58BB, $F00, $5DB
                dc.w $D0BB, $F00, $505
word_E9476:     dc.w $48CB, $F00, $F0F0 ; DATA XREF: ROM:000E9878   o
                                        ; ROM:000E9898   o
                dc.w $588B, $F00, $E2F0
                dc.w $588B, $F00, $F0E4
                dc.w $D08B, $F00, $F0FC
word_E948E:     dc.w $48CB, $F00, $F0F0 ; DATA XREF: ROM:000E987C   o
                                        ; ROM:000E989C   o
                dc.w $588B, $F00, $DEF0
                dc.w $588B, $F00, $F0DE
                dc.w $D08B, $F00, $F002
word_E94A6:     dc.w $588B, $F00, $F0F0 ; DATA XREF: ROM:000E9880   o
                                        ; ROM:000E98A0   o
                dc.w $589B, $F00, $F0D9
                dc.w $509B, $F00, $F007
                dc.w $509B, $F00, $DDE3
                dc.w $D89B, $F00, $DDFD
word_E94C4:     dc.w $589B, $F00, $F0F0 ; DATA XREF: ROM:000E9884   o
                                        ; ROM:000E98A4   o
                dc.w $58AB, $F00, $F0D2
                dc.w $50AB, $F00, $F00E
                dc.w $58AB, $F00, $D8E0
                dc.w $D0AB, $F00, $D800
word_E94E2:     dc.w $58AB, $F00, $F0F0 ; DATA XREF: ROM:000E9888   o
                                        ; ROM:000E98A8   o
                dc.w $58BB, $F00, $F00F
                dc.w $50BB, $F00, $F0D1
                dc.w $58BB, $F00, $D5DF
                dc.w $D0BB, $F00, $D501
word_E9500:     dc.w $C878, 0, $FCFC    ; DATA XREF: ROM:off_E975C   o
word_E9506:     dc.w $4874, 0, $F8F8    ; DATA XREF: ROM:000E9764   o
                                        ; ROM:000E976C   o
                dc.w $C878, 0, $FCFC
                dc.w $C874, 0, $F8F8
word_E9518:     dc.w $4872, 0, $F8F8    ; DATA XREF: ROM:000E9768   o
                dc.w $C878, 0, $FCFC
                dc.w $C872, 0, $F8F8
word_E952A:     dc.w $C8DD, $200, $F4FC ; DATA XREF: ROM:0003081C   o
                                        ; ROM:0003082C   o
word_E9530:     dc.w $C8E0, $800, $FCF4 ; DATA XREF: ROM:off_30814   o
                                        ; ROM:00030824   o
word_E9536:     dc.w $C8E3, $A00, $F4F4 ; DATA XREF: ROM:00030818   o
                                        ; ROM:00030820   o ...
off_E953C:      dc.w word_E90C2-*       ; DATA XREF: Sprite_ShipDebrisUpdate+20   o
                                        ; ROM:off_2255C   o ...
                dc.w 1
                dc.w word_E90C8-*
                dc.w 1
                dc.w word_E907A-*
                dc.w 2
                dc.w word_E9092-*
                dc.w 1
                dc.w word_E90AA-*
                dc.w 4
                dc.w word_E90B0-*
                dc.w 3
                dc.w word_E90B6-*
                dc.w 2
                dc.w word_E90BC-*
                dc.w 2
                dc.w word_E90BC-*
                dc.w $FF
off_E9560:      dc.w word_E90C2-*       ; DATA XREF: Player_SpawnTripleShot:loc_17664   o
                                        ; sub_17678:loc_1768C   o ...
                dc.w 1
                dc.w word_E90C8-*
                dc.w 1
                dc.w word_E907A-*
                dc.w 2
                dc.w word_E9092-*
                dc.w 1
                dc.w word_E90AA-*
                dc.w 3
                dc.w word_E90B0-*
                dc.w 2
                dc.w word_E90B6-*
                dc.w 1
                dc.w word_E90BC-*
                dc.w 1
                dc.w word_E90BC-*
                dc.w $FF
off_E9584:      dc.w word_E90C8-*       ; DATA XREF: Sprite_InitProjectile+40   o
                                        ; ROM:00022564   o ...
                dc.w 1
                dc.w word_E907A-*
                dc.w 1
                dc.w word_E9092-*
                dc.w 1
                dc.w word_E90AA-*
                dc.w 2
                dc.w word_E90B0-*
                dc.w 1
                dc.w word_E90B6-*
                dc.w 1
                dc.w word_E90BC-*
                dc.w 1
                dc.w word_E90BC-*
                dc.w $FF
off_E95A4:      dc.w word_E90C2-*       ; DATA XREF: ROM:00022568   o
                                        ; ROM:0002256C   o ...
                dc.w 1
                dc.w word_E9188-*
                dc.w 3
                dc.w word_E918E-*
                dc.w 3
                dc.w word_E9194-*
                dc.w 3
                dc.w word_E919A-*
                dc.w 3
                dc.w word_E91A0-*
                dc.w 2
                dc.w word_E91A0-*
                dc.w $FF
off_E95C0:      dc.w word_E90C2-*       ; DATA XREF: Projectile_FallingSpawner+1C   o
                                        ; ROM:00031E88   o ...
                dc.w 1
                dc.w word_E9188-*
                dc.w 2
                dc.w word_E918E-*
                dc.w 2
                dc.w word_E9194-*
                dc.w 2
                dc.w word_E919A-*
                dc.w 2
                dc.w word_E91A0-*
                dc.w 1
                dc.w word_E91A0-*
                dc.w $FF
off_E95DC:      dc.w word_E90C2-*       ; DATA XREF: ROM:00022570   o
                                        ; Enemy_SpawnQuadProjectiles+2   o ...
                dc.w 1
                dc.w word_E90C8-*
                dc.w 1
                dc.w word_E90CE-*
                dc.w 1
                dc.w word_E90C2-*
                dc.w 1
                dc.w word_E91A6-*
                dc.w 2
                dc.w word_E91AC-*
                dc.w 3
                dc.w word_E91B2-*
                dc.w 3
                dc.w word_E91B8-*
                dc.w 3
                dc.w word_E91BE-*
                dc.w 2
                dc.w word_E91BE-*
                dc.w $FF
off_E9604:      dc.w word_E90C2-*       ; DATA XREF: ROM:stru_2B526   o
                                        ; ROM:stru_2B534   o ...
                dc.w 1
                dc.w word_E90C8-*
                dc.w 1
                dc.w word_E90CE-*
                dc.w 1
                dc.w word_E90C2-*
                dc.w 1
                dc.w word_E91A6-*
                dc.w 1
                dc.w word_E91AC-*
                dc.w 2
                dc.w word_E91B2-*
                dc.w 2
                dc.w word_E91B8-*
                dc.w 2
                dc.w word_E91BE-*
                dc.w 1
                dc.w word_E91BE-*
                dc.w $FF
off_E962C:      dc.w word_E91C4-*       ; DATA XREF: Projectile_SpawnWolfGaropaBomb+A   o
                                        ; ROM:000E9634   o
                dc.w 1
                dc.w word_E91CA-*
                dc.w 1
                dc.w off_E962C-*
                dc.w 0
off_E9638:      dc.w word_E91D0-*       ; DATA XREF: Enemy_TrailingExplosionSpawner+16   o
                                        ; ROM:000E9648   o
                dc.w 1
                dc.w word_E91FA-*
                dc.w 1
                dc.w word_E91D6-*
                dc.w 1
                dc.w word_E91FA-*
                dc.w 1
                dc.w off_E9638-*
                dc.w 0
off_E964C:      dc.w word_E91C4-*       ; DATA XREF: ROM:000E965C   o
                dc.w 1
                dc.w word_E91D0-*
                dc.w 1
                dc.w word_E91CA-*
                dc.w 1
                dc.w word_E91D6-*
                dc.w 1
                dc.w off_E964C-*
                dc.w 0
off_E9660:      dc.w word_E91FA-*       ; DATA XREF: ROM:000E9668   o
                dc.w 1
                dc.w word_E9200-*
                dc.w 1
                dc.w off_E9660-*
                dc.w 0
off_E966C:      dc.w word_E91FA-*       ; DATA XREF: ROM:000E9674   o
                dc.w 1
                dc.w word_E9200-*
                dc.w 1
                dc.w off_E966C-*
                dc.w 0
                dc.w word_E9200-*
                dc.w $FF
                dc.w word_E91FA-*
                dc.w $FF
off_E9680:      dc.w word_E9206-*       ; DATA XREF: Weapon_UpdateSeekingMissile+16   o
                                        ; Enemy_InitHomingProjectile+34   o ...
                dc.w 1
                dc.w word_E920C-*
                dc.w 1
                dc.w off_E9680-*
                dc.w 0
off_E968C:      dc.w word_E9206-*       ; DATA XREF: UI_InitWeaponSelectScreen+54   o
                                        ; Boss_JetsripperSpawnDirectionalProjectile+10   o ...
                dc.w 2
                dc.w word_E920C-*
                dc.w 2
                dc.w off_E968C-*
                dc.w 0
off_E9698:      dc.w word_E9206-*       ; DATA XREF: Weapon_SpawnHomingEffect+D8   o
                                        ; ROM:000E96A8   o
                dc.w 1
                dc.w word_E91CA-*
                dc.w 1
                dc.w word_E920C-*
                dc.w 1
                dc.w word_E91C4-*
                dc.w 1
                dc.w off_E9698-*
                dc.w 0
off_E96AC:      dc.w word_E9206-*       ; DATA XREF: ROM:000E96B8   o
                dc.w 1
                dc.w word_E9188-*
                dc.w 1
                dc.w word_E920C-*
                dc.w 1
                dc.w off_E96AC-*
                dc.w 0
                dc.w word_E9212-*
                dc.w 3
                dc.w word_E9218-*
                dc.w 3
                dc.w word_E9218-*
                dc.w $FF
                dc.w word_E9212-*
                dc.w 6
                dc.w word_E9218-*
                dc.w 6
                dc.w word_E9218-*
                dc.w $FF
                dc.w word_E9212-*
                dc.w 1
                dc.w word_E9218-*
                dc.w 1
                dc.w word_E9218-*
                dc.w $FF
off_E96E0:      dc.w word_E9218-*       ; DATA XREF: ROM:stru_2B526   o
                                        ; ROM:stru_2B534   o ...
                dc.w 2
                dc.w word_E9224-*
                dc.w 2
                dc.w word_E921E-*
                dc.w 2
                dc.w off_E96E0-*
                dc.w 0
off_E96F0:      dc.w word_E9218-*       ; DATA XREF: ROM:000E96F8   o
                dc.w 2
                dc.w word_E921E-*
                dc.w 2
                dc.w off_E96F0-*
                dc.w 0
off_E96FC:      dc.w word_E93F2-*       ; DATA XREF: Boss_ViblackSpawnRandomProjectile2+2E   o
                                        ; Boss_BackStringerSpawnDebris+4E   o ...
                dc.w 3
                dc.w word_E93F8-*
                dc.w 3
                dc.w word_E93FE-*
                dc.w 3
                dc.w word_E9404-*
                dc.w 3
                dc.w word_E9404-*
                dc.w $FF
off_E9710:      dc.w word_E93F2-*       ; DATA XREF: ROM:000546F2   o
                dc.w 5
                dc.w word_E93F8-*
                dc.w 5
                dc.w word_E93FE-*
                dc.w 5
                dc.w word_E9404-*
                dc.w 5
                dc.w word_E9404-*
                dc.w $FF
off_E9724:      dc.w word_E93F2-*       ; DATA XREF: ROM:000546FA   o
                dc.w 1
                dc.w word_E93F8-*
                dc.w 1
                dc.w word_E93FE-*
                dc.w 1
                dc.w word_E9404-*
                dc.w 1
                dc.w word_E9404-*
                dc.w $FF
off_E9738:      dc.w word_E90C2-*       ; DATA XREF: Effect_SpawnRandomDebris+46   o
                dc.w 1
                dc.w word_E93F2-*
                dc.w 2
                dc.w word_E93F8-*
                dc.w 2
                dc.w word_E93FE-*
                dc.w 2
                dc.w word_E9404-*
                dc.w 2
                dc.w word_E9404-*
                dc.w $FF
                dc.w word_E9218-*
                dc.w $FF
                dc.w word_E9224-*
                dc.w $FF
                dc.w word_E921E-*
                dc.w $FF
off_E975C:      dc.w word_E9500-*       ; DATA XREF: Boss_JetsripperMain+18   o
                                        ; Projectile_SpawnFallingDebris+28   o ...
                dc.w $20
                dc.w word_E9218-*
                dc.w 1
                dc.w word_E9506-*
                dc.w 1
                dc.w word_E9518-*
                dc.w 1
                dc.w word_E9506-*
                dc.w 1
                dc.w off_E975C-*
                dc.w 0
off_E9774:      dc.w word_E90D4-*       ; DATA XREF: ROM:000E9784   o
                dc.w 1
                dc.w word_E90E0-*
                dc.w 1
                dc.w word_E90DA-*
                dc.w 1
                dc.w word_E90E6-*
                dc.w 1
                dc.w off_E9774-*
                dc.w 0
off_E9788:      dc.w word_E90D4-*       ; DATA XREF: Enemy_HomingProjectileMain+3E   o
                                        ; Projectile_BulletWithDelayedPhysics+3E   o ...
                dc.w 2
                dc.w word_E90E0-*
                dc.w 2
                dc.w word_E90DA-*
                dc.w 2
                dc.w word_E90E6-*
                dc.w 2
                dc.w off_E9788-*
                dc.w 0
off_E979C:      dc.w word_E913A-*       ; DATA XREF: ROM:000E97B4   o
                dc.w $18
                dc.w word_E90FE-*
                dc.w 1
                dc.w word_E911C-*
                dc.w 1
                dc.w word_E916A-*
                dc.w 1
                dc.w word_E911C-*
                dc.w 1
                dc.w word_E90FE-*
                dc.w 1
                dc.w off_E979C-*
                dc.w 0
off_E97B8:      dc.w word_E9152-*       ; DATA XREF: Enemy_InitDestructionParticle+A   o
                                        ; ROM:000E97D0   o
                dc.w $18
                dc.w word_E922A-*
                dc.w 1
                dc.w word_E9248-*
                dc.w 1
                dc.w word_E9266-*
                dc.w 1
                dc.w word_E9248-*
                dc.w 1
                dc.w word_E922A-*
                dc.w 1
                dc.w off_E97B8-*
                dc.w 0
off_E97D4:      dc.w word_E90F2-*       ; DATA XREF: ROM:0002BDAC   o
                                        ; ROM:000E97DC   o
                dc.w 8
                dc.w word_E93F2-*
                dc.w 1
                dc.w off_E97D4-*
                dc.w 0
off_E97E0:      dc.w word_E90EC-*       ; DATA XREF: ROM:off_2BDA8   o
                                        ; ROM:000E97E8   o
                dc.w 8
                dc.w word_E90F8-*
                dc.w 1
                dc.w off_E97E0-*
                dc.w 0
off_E97EC:      dc.w word_E929C-*       ; DATA XREF: ROM:000E97FC   o
                dc.w 1
                dc.w word_E9290-*
                dc.w 1
                dc.w word_E9284-*
                dc.w 1
                dc.w word_E9206-*
                dc.w 5
                dc.w off_E97EC-*
                dc.w 0
off_E9800:      dc.w word_E9218-*       ; DATA XREF: Boss_CheckDefeatCondition+2C   o
                dc.w 1
                dc.w word_E90C2-*
                dc.w 1
                dc.w word_E90C8-*
                dc.w 2
                dc.w word_E907A-*
                dc.w 2
                dc.w word_E9092-*
                dc.w 1
                dc.w word_E90C8-*
                dc.w $FF
off_E9818:      dc.w word_E92F0-*       ; DATA XREF: ROM:000E9828   o
                dc.w 1
                dc.w word_E930E-*
                dc.w 1
                dc.w word_E932C-*
                dc.w 1
                dc.w word_E934A-*
                dc.w 1
                dc.w off_E9818-*
                dc.w 0
                dc.w word_E90C8-*
                dc.w 1
                dc.w word_E907A-*
                dc.w 1
                dc.w word_E9092-*
                dc.w 1
                dc.w word_E9368-*
                dc.w 2
                dc.w word_E9386-*
                dc.w 2
                dc.w word_E93BC-*
                dc.w 2
                dc.w word_E940A-*
                dc.w 2
                dc.w word_E9440-*
                dc.w 2
                dc.w word_E9404-*
                dc.w $FF
off_E9850:      dc.w word_E9092-*       ; DATA XREF: Projectile_HandleHit+1A   o
                                        ; Projectile_ZLeoLaserMain+120   o
                dc.w 1
                dc.w word_E907A-*
                dc.w 1
                dc.w word_E9368-*
                dc.w 1
                dc.w word_E9386-*
                dc.w 1
                dc.w word_E93BC-*
                dc.w 2
                dc.w word_E940A-*
                dc.w 1
                dc.w word_E9440-*
                dc.w 1
                dc.w word_E9404-*
                dc.w $FF
off_E9870:      dc.w word_E907A-*       ; DATA XREF: Boss_SpawnProjectile+2A   o
                dc.w 1
                dc.w word_E9092-*
                dc.w 1
                dc.w word_E9476-*
                dc.w 1
                dc.w word_E948E-*
                dc.w 1
                dc.w word_E94A6-*
                dc.w 2
                dc.w word_E94C4-*
                dc.w 2
                dc.w word_E94E2-*
                dc.w 2
                dc.w word_E9404-*
                dc.w $FF
                dc.w word_E907A-*
                dc.w 1
                dc.w word_E9092-*
                dc.w 1
                dc.w word_E9476-*
                dc.w 1
                dc.w word_E948E-*
                dc.w 1
                dc.w word_E94A6-*
                dc.w 1
                dc.w word_E94C4-*
                dc.w 2
                dc.w word_E94E2-*
                dc.w 1
                dc.w word_E9404-*
                dc.w $FF
word_E98B0:     dc.w $300, $F00, $F0D0  ; DATA XREF: UI_InitializeSEGAScreen+17C   o
                dc.w $310, $F00, $F0F0
                dc.w $8320, $F00, $F010
word_E98C2:     dc.w $300, $F00, $D4E4  ; DATA XREF: UI_InitializeTitleScreen+3A   o
                dc.w $310, $B00, $D404
                dc.w $31C, $F00, $F4E4
                dc.w $32C, $B00, $F404
                dc.w $338, $E00, $14E4
                dc.w $8344, $A00, $1404
                dc.w $65B4, $F00, $80F0
                dc.w $65B4, $F00, $A0F0
                dc.w $65B4, $F00, $C0F0
                dc.w $65B4, $F00, $E0F0
                dc.w $65B4, $F00, $F0
                dc.w $65B4, $F00, $20F0
                dc.w $65B4, $F00, $40F0
                dc.w $E5B4, $F00, $60F0
                dc.w $75C4, $500, $F0F0
                dc.w $7DC4, $500, $F000
                dc.w $65C4, $500, $F0
                dc.w $EDC4, $500, 0
                dc.w $75C8, $500, $F0F0
                dc.w $7DC8, $500, $F000
                dc.w $65C8, $500, $F0
                dc.w $EDC8, $500, 0
                dc.w $404C, $600, $F2F1
                dc.w $C84C, $600, $F201
word_E9952:     dc.w $4480, $A00, $F4F4 ; DATA XREF: Enemy_UpdateBossAI:loc_2BBF4   o
                dc.w $47F0, $500, $F8F0
                dc.w $CFF0, $500, $F8FF
word_E9964:     dc.w $47F0, $500, $F8F0 ; DATA XREF: ROM:off_178E6   o
                dc.w $4FF0, $500, $F8FF
                dc.w $C584, $500, $F8F8
word_E9976:     dc.w $47F0, $500, $F8F0 ; DATA XREF: ROM:000178EA   o
                dc.w $4FF0, $500, $F8FF
                dc.w $C588, $500, $F8F8
word_E9988:     dc.w $47F0, $500, $F8F0 ; DATA XREF: ROM:000178EE   o
                dc.w $4FF0, $500, $F8FF
                dc.w $C58C, $500, $F8F8
word_E999A:     dc.w $47F0, $500, $F8F0 ; DATA XREF: ROM:000178F2   o
                dc.w $4FF0, $500, $F8FF
                dc.w $C590, $500, $F8F8
word_E99AC:     dc.w $47F0, $500, $F8F0 ; DATA XREF: ROM:000178F6   o
                dc.w $4FF0, $500, $F8FF
                dc.w $C594, $500, $F8F8
word_E99BE:	binclude	"data/other/word_E99BE.bin"	; DATA XREF: ROM:000178FA   o
word_E99BE_End:
word_E9C2E:     dc.w $6863, $500, $10EE ; DATA XREF: ROM:off_E9E1C   o
                                        ; ROM:off_E9E40   o ...
                dc.w $6845, $C00, $EF1
                dc.w $6839, $E00, $F6F1
                dc.w $6871, $500, $10FD
                dc.w $E800, $D00, $E6F1
word_E9C4C:     dc.w $6863, $500, $10EE ; DATA XREF: ROM:000E9E20   o
                                        ; ROM:000E9E38   o ...
                dc.w $6829, $F00, $F8F3
                dc.w $6871, $500, $10FD
                dc.w $E800, $D00, $E8F3
word_E9C64:     dc.w $6863, $500, $10EE ; DATA XREF: ROM:000E9E24   o
                                        ; ROM:000E9E34   o ...
                dc.w $6819, $F00, $FAF3
                dc.w $6871, $500, $10FD
                dc.w $E800, $D00, $EAF3
word_E9C7C:     dc.w $6808, $D00, $EBF2 ; DATA XREF: ROM:000E9E28   o
                                        ; ROM:000E9E30   o ...
                dc.w $686B, 0, $1CFB
                dc.w $6867, $500, $14EB
                dc.w $6819, $F00, $FBF2
                dc.w $6875, 0, $1C0A
                dc.w $E876, $500, $14FA
word_E9CA0:     dc.w $6808, $D00, $EEF0 ; DATA XREF: ROM:000E9E2C   o
                                        ; ROM:000E9E50   o ...
                dc.w $686B, 0, $1CFB
                dc.w $6867, $500, $14EB
                dc.w $6819, $F00, $FEF0
                dc.w $6875, 0, $1C0A
                dc.w $E876, $500, $14FA
word_E9CC4:     dc.w $6808, $D00, $E6F2 ; DATA XREF: ROM:off_E9E08   o
                dc.w $6863, $500, $DEB
                dc.w $6839, $E00, $F6F2
                dc.w $6845, $C00, $EF2
                dc.w $687A, $800, $18FF
                dc.w $E87D, $400, $10F7
word_E9CE8:     dc.w $6808, $D00, $E4F4 ; DATA XREF: ROM:000E9E0C   o
                dc.w $6867, $500, $CEE
                dc.w $6829, $F00, $F4F4
                dc.w $686B, 0, $16FC
                dc.w $E871, $500, $10F9
word_E9D06:     dc.w $686F, $400, $10EE ; DATA XREF: ROM:000E9E10   o
                dc.w $686C, $800, $18F6
                dc.w $6819, $F00, $F6EF
                dc.w $6871, $500, $EF0
                dc.w $E800, $D00, $E6EF
word_E9D24:     dc.w $6863, $500, $10EE ; DATA XREF: ROM:000E9E14   o
                dc.w $6829, $F00, $F4F4
                dc.w $6875, 0, $1508
                dc.w $6876, $500, $DF8
                dc.w $E800, $D00, $E4F4
word_E9D42:     dc.w $6800, $D00, $E7F0 ; DATA XREF: ROM:000E9E6C   o
                                        ; ROM:000E9E7C   o
                dc.w $6857, $E00, $F7F0
                dc.w $6863, $500, $10EE
                dc.w $6845, $C00, $FEF
                dc.w $E871, $500, $10FD
word_E9D60:     dc.w $6808, $D00, $E6F2 ; DATA XREF: ROM:000E9E70   o
                                        ; ROM:000E9E78   o
                dc.w $6857, $E00, $F6F2
                dc.w $6863, $500, $10EE
                dc.w $6845, $C00, $EF1
                dc.w $E871, $500, $10FD
word_E9D7E:     dc.w $6818, 0, $F013    ; DATA XREF: ROM:000E9E74   o
                dc.w $6810, $D00, $E7F3
                dc.w $6849, $100, $F613
                dc.w $684B, $E00, $F6F3
                dc.w $6863, $500, $10EE
                dc.w $6845, $C00, $EF3
                dc.w $E871, $500, $10FD
word_E9DA8:     dc.w $6875, 0, $140B    ; DATA XREF: ROM:off_E9E80   o
                dc.w $6863, $500, $10ED
                dc.w $6845, $C00, $CF1
                dc.w $6876, $500, $CFB
                dc.w $6839, $E00, $F4F1
                dc.w $E808, $D00, $E4F2
word_E9DCC:     dc.w $686B, 0, $14FE    ; DATA XREF: ROM:000E9E88   o
                dc.w $6867, $500, $CEE
                dc.w $6808, $D00, $E4F2
                dc.w $6845, $C00, $CF1
                dc.w $6839, $E00, $F4F1
                dc.w $E871, $500, $10FD
word_E9DF0:     dc.w $6863, $500, $CEF  ; DATA XREF: ROM:000E9E84   o
                                        ; ROM:000E9E8C   o
                dc.w $6829, $F00, $F4F1
                dc.w $6808, $D00, $E4F2
                dc.w $E871, $500, $CFD
off_E9E08:      dc.w word_E9CC4-*       ; DATA XREF: ROM:0002C554   o
                                        ; ROM:000E9E18   o
                dc.w 4
                dc.w word_E9CE8-*
                dc.w 4
                dc.w word_E9D06-*
                dc.w 4
                dc.w word_E9D24-*
                dc.w 4
                dc.w off_E9E08-*
                dc.w 0
off_E9E1C:      dc.w word_E9C2E-*       ; DATA XREF: ROM:off_2C550   o
                                        ; ROM:000E9E3C   o
                dc.w 6
                dc.w word_E9C4C-*
                dc.w 5
                dc.w word_E9C64-*
                dc.w 4
                dc.w word_E9C7C-*
                dc.w 5
                dc.w word_E9CA0-*
                dc.w 6
                dc.w word_E9C7C-*
                dc.w 5
                dc.w word_E9C64-*
                dc.w 4
                dc.w word_E9C4C-*
                dc.w 5
                dc.w off_E9E1C-*
                dc.w 0
off_E9E40:      dc.w word_E9C2E-*       ; DATA XREF: ROM:0002C558   o
                dc.w 1
                dc.w word_E9C4C-*
                dc.w 1
                dc.w word_E9C64-*
                dc.w 2
                dc.w word_E9C7C-*
                dc.w 3
                dc.w word_E9CA0-*
                dc.w 4
                dc.w word_E9CA0-*
                dc.w 3
                dc.w word_E9C7C-*
                dc.w 2
                dc.w word_E9C64-*
                dc.w 1
                dc.w word_E9C4C-*
                dc.w 1
                dc.w word_E9C2E-*
                dc.w $FF
off_E9E68:      dc.w word_E9C2E-*       ; DATA XREF: ROM:0002C55C   o
                dc.w 3
                dc.w word_E9D42-*
                dc.w 6
                dc.w word_E9D60-*
                dc.w 8
                dc.w word_E9D7E-*
                dc.w $10
                dc.w word_E9D60-*
                dc.w 8
                dc.w word_E9D42-*
                dc.w $FF
off_E9E80:      dc.w word_E9DA8-*       ; DATA XREF: ROM:0002C560   o
                                        ; Boss_FireProjectilePattern+10   o ...
                dc.w 3
                dc.w word_E9DF0-*
                dc.w 2
                dc.w word_E9DCC-*
                dc.w 3
                dc.w word_E9DF0-*
                dc.w 2
                dc.w off_E9E80-*
                dc.w 0
word_E9E94:     dc.w $606F, $500, $6E8  ; DATA XREF: ROM:000EA012   o
                                        ; ROM:000EA02A   o ...
                dc.w $686F, $500, $608
                dc.w $6865, $100, $D2FC
                dc.w $6000, $A00, $E0E8
                dc.w $602D, $F00, $F8E0
                dc.w $605D, $C00, $18E0
                dc.w $685D, $C00, $1800
                dc.w $682D, $F00, $F800
                dc.w $E800, $A00, $E000
word_E9ECA:     dc.w $606B, $500, $8DE  ; DATA XREF: ROM:000EA016   o
                                        ; ROM:000EA026   o
                dc.w $686B, $500, $812
                dc.w $6861, $500, $D2F8
                dc.w $605D, $C00, $18E0
                dc.w $685D, $C00, $1800
                dc.w $6009, $A00, $E0E8
                dc.w $603D, $F00, $F8E0
                dc.w $683D, $F00, $F800
                dc.w $E809, $A00, $E000
word_E9F00:     dc.w $685D, $C00, $1800 ; DATA XREF: ROM:000EA01A   o
                                        ; ROM:000EA022   o
                dc.w $605D, $C00, $18E0
                dc.w $6067, $500, $BDA
                dc.w $6867, $500, $B16
                dc.w $6861, $500, $D4F8
                dc.w $604D, $F00, $F9E0
                dc.w $684D, $F00, $F900
                dc.w $6012, $A00, $E1E8
                dc.w $E812, $A00, $E100
word_E9F36:     dc.w $606F, $500, $4EA  ; DATA XREF: ROM:off_EA00E   o
                                        ; ROM:000EA02E   o ...
                dc.w $686F, $500, $406
                dc.w $6865, $100, $D1FC
                dc.w $6000, $A00, $E0E8
                dc.w $602D, $F00, $F8E0
                dc.w $605D, $C00, $18E0
                dc.w $685D, $C00, $1800
                dc.w $682D, $F00, $F800
                dc.w $E800, $A00, $E000
word_E9F6C:     dc.w $685D, $C00, $1800 ; DATA XREF: ROM:000EA01E   o
                dc.w $605D, $C00, $18E0
                dc.w $6067, $500, $DD8
                dc.w $6867, $500, $D18
                dc.w $6861, $500, $D5F8
                dc.w $604D, $F00, $F9E0
                dc.w $684D, $F00, $F900
                dc.w $6012, $A00, $E1E8
                dc.w $E812, $A00, $E100
word_E9FA2:     dc.w $606F, $500, $4EA  ; DATA XREF: ROM:000EA03A   o
                                        ; ROM:000EA042   o ...
                dc.w $686F, $500, $406
                dc.w $603D, $F00, $F8E0
                dc.w $683D, $F00, $F800
                dc.w $6861, $500, $D2F8
                dc.w $601B, $A00, $E0E8
                dc.w $681B, $A00, $E000
                dc.w $605D, $C00, $18E0
                dc.w $E85D, $C00, $1800
word_E9FD8:     dc.w $685D, $C00, $1800 ; DATA XREF: ROM:000EA03E   o
                dc.w $605D, $C00, $18E0
                dc.w $686F, $500, $FE03
                dc.w $606F, $500, $FEED
                dc.w $602D, $F00, $F9E0
                dc.w $682D, $F00, $F900
                dc.w $6024, $A00, $E1E8
                dc.w $6824, $A00, $E100
                dc.w $E861, $500, $D4F9
off_EA00E:      dc.w word_E9F36-*       ; DATA XREF: ROM:off_2C984   o
                                        ; ROM:000EA032   o
                dc.w 4
                dc.w word_E9E94-*
                dc.w 4
                dc.w word_E9ECA-*
                dc.w 4
                dc.w word_E9F00-*
                dc.w 3
                dc.w word_E9F6C-*
                dc.w 2
                dc.w word_E9F00-*
                dc.w 3
                dc.w word_E9ECA-*
                dc.w 4
                dc.w word_E9E94-*
                dc.w 4
                dc.w word_E9F36-*
                dc.w 4
                dc.w off_EA00E-*
                dc.w 0
off_EA036:      dc.w word_E9E94-*       ; DATA XREF: ROM:0002C98C   o
                                        ; ROM:000EA046   o
                dc.w 4
                dc.w word_E9FA2-*
                dc.w 5
                dc.w word_E9FD8-*
                dc.w 6
                dc.w word_E9FA2-*
                dc.w 5
                dc.w off_EA036-*
                dc.w 0
off_EA04A:      dc.w word_E9E94-*       ; DATA XREF: ROM:0002C988   o
                                        ; ROM:000EA056   o
                dc.w 4
                dc.w word_E9FA2-*
                dc.w 3
                dc.w word_E9F36-*
                dc.w 2
                dc.w off_EA04A-*
                dc.w 0
word_EA05A:     dc.w $6839, $E00, $EAF3 ; DATA XREF: ROM:off_EA5DC   o
                                        ; ROM:off_EA67C   o
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $DFB
                dc.w $6810, $E00, $FCF1
                dc.w $6835, $500, $12FB
                dc.w $6858, $400, $F209
                dc.w $E800, $F00, $DCF1
word_EA084:     dc.w $6839, $E00, $ECF3 ; DATA XREF: ROM:000EA5E0   o
                                        ; ROM:000EA5F0   o ...
                dc.w $6858, $400, $F409
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $EFB
                dc.w $6810, $E00, $FEF1
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DEF1
word_EA0AE:     dc.w $6839, $E00, $EEF2 ; DATA XREF: ROM:000EA5E4   o
                                        ; ROM:000EA5EC   o ...
                dc.w $6858, $400, $F608
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $FFA
                dc.w $6810, $E00, $FFF0
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DFF0
word_EA0D8:     dc.w $6839, $E00, $EFF1 ; DATA XREF: ROM:000EA5E8   o
                dc.w $6858, $400, $F707
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $FFA
                dc.w $6810, $E00, $FFEF
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DFEF
word_EA102:     dc.w $6839, $E00, $EFF1 ; DATA XREF: ROM:000EA684   o
                                        ; ROM:000EA694   o
                dc.w $6858, $400, $F707
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $10FA
                dc.w $6810, $E00, $1EF
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $E1EF
word_EA12C:     dc.w $6839, $E00, $F0F3 ; DATA XREF: ROM:off_EA5B8   o
                                        ; ROM:000EA614   o
                dc.w $6830, 0, $FF7
                dc.w $6810, $E00, $F1
                dc.w $6835, $500, $1202
                dc.w $6835, $500, $12ED
                dc.w $6858, $400, $F809
                dc.w $E800, $F00, $E0F1
word_EA156:     dc.w $6839, $E00, $ECF3 ; DATA XREF: ROM:000EA5BC   o
                                        ; ROM:000EA610   o
                dc.w $6831, $500, $BF0
                dc.w $6830, 0, $BFA
                dc.w $6810, $E00, $FDF1
                dc.w $6835, $500, $12FF
                dc.w $6858, $400, $F409
                dc.w $E800, $F00, $DDF1
word_EA180:     dc.w $6831, $500, $5F8  ; DATA XREF: ROM:000EA5C0   o
                                        ; ROM:000EA60C   o
                dc.w $6835, $500, $12F8
                dc.w $6839, $E00, $E8F3
                dc.w $6858, $400, $F009
                dc.w $6810, $E00, $FAF1
                dc.w $E800, $F00, $DAF1
word_EA1A4:     dc.w $6831, $500, $B02  ; DATA XREF: ROM:000EA5C4   o
                                        ; ROM:000EA608   o
                dc.w $6835, $500, $12F1
                dc.w $6830, 0, $A00
                dc.w $6839, $E00, $ECF3
                dc.w $6858, $400, $F409
                dc.w $6810, $E00, $FDF1
                dc.w $E800, $F00, $DDF1
word_EA1CE:     dc.w $6835, $500, $1202 ; DATA XREF: ROM:000EA5C8   o
                                        ; ROM:000EA604   o
                dc.w $6835, $500, $12ED
                dc.w $6830, 0, $F00
                dc.w $6839, $E00, $F0F3
                dc.w $6858, $400, $F809
                dc.w $6810, $E00, $F1
                dc.w $E800, $F00, $E0F1
word_EA1F8:     dc.w $6839, $E00, $ECF3 ; DATA XREF: ROM:000EA5CC   o
                                        ; ROM:000EA600   o
                dc.w $6835, $500, $12FE
                dc.w $6830, 0, $DFF
                dc.w $6810, $E00, $FDF1
                dc.w $6831, $500, $BF0
                dc.w $6858, $400, $F409
                dc.w $E800, $F00, $DDF1
word_EA222:     dc.w $6835, $500, $12F8 ; DATA XREF: ROM:000EA5D0   o
                                        ; ROM:000EA5FC   o
                dc.w $6830, 0, $CFD
                dc.w $6839, $E00, $E8F3
                dc.w $6858, $400, $F009
                dc.w $6810, $E00, $FAF1
                dc.w $E800, $F00, $DAF1
word_EA246:     dc.w $6835, $500, $12F1 ; DATA XREF: ROM:000EA5D4   o
                                        ; ROM:off_EA5F8   o
                dc.w $6830, 0, $EF9
                dc.w $6839, $E00, $ECF3
                dc.w $6810, $E00, $FDF0
                dc.w $6831, $500, $B02
                dc.w $6858, $400, $F409
                dc.w $E800, $F00, $DDF1
word_EA270:     dc.w $6839, $E00, $ECF0 ; DATA XREF: ROM:000EA620   o
                                        ; ROM:000EA630   o
                dc.w $6858, $400, $F405
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $EFA
                dc.w $6810, $E00, $FEF0
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DEF0
word_EA29A:     dc.w $6839, $E00, $ECEE ; DATA XREF: ROM:000EA624   o
                                        ; ROM:000EA62C   o
                dc.w $6858, $400, $F402
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $EF9
                dc.w $6810, $E00, $FEEF
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DEEF
word_EA2C4:     dc.w $6839, $E00, $ECED ; DATA XREF: ROM:000EA628   o
                dc.w $6858, $400, $F400
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $EF9
                dc.w $6810, $E00, $FEEE
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DEEE
word_EA2EE:     dc.w $6845, $A00, $EFF2 ; DATA XREF: ROM:000EA688   o
                                        ; ROM:000EA690   o
                dc.w $685A, $500, $E900
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $10FA
                dc.w $6810, $E00, $3EF
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $E3EF
word_EA318:     dc.w $6845, $A00, $E8F5 ; DATA XREF: ROM:off_EA634   o
                dc.w $685A, $500, $E204
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $DFB
                dc.w $6810, $E00, $FCF1
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DCF1
word_EA342:     dc.w $6845, $A00, $F1F0 ; DATA XREF: ROM:000EA68C   o
                dc.w $685A, $500, $EBFE
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $11FA
                dc.w $6810, $E00, $5EF
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $E5EF
word_EA36C:     dc.w $684E, $A00, $E8F4 ; DATA XREF: ROM:off_EA64C   o
                dc.w $685E, $100, $DCFC
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $DFB
                dc.w $6810, $E00, $FCF1
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DCF1
word_EA396:     dc.w $6845, $A00, $EAF3 ; DATA XREF: ROM:000EA638   o
                                        ; ROM:000EA648   o
                dc.w $685A, $500, $E501
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $EFA
                dc.w $6810, $E00, $FDF0
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DDF0
word_EA3C0:     dc.w $6845, $A00, $EBF2 ; DATA XREF: ROM:000EA63C   o
                                        ; ROM:000EA644   o
                dc.w $685A, $500, $E7FF
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $EFA
                dc.w $6810, $E00, $FEEF
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DEEF
word_EA3EA:     dc.w $6845, $A00, $EDF0 ; DATA XREF: ROM:000EA640   o
                dc.w $685A, $500, $E9FD
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $EF9
                dc.w $6810, $E00, $FEEE
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DEEE
word_EA414:     dc.w $684E, $A00, $EBF4 ; DATA XREF: ROM:000EA650   o
                                        ; ROM:000EA660   o
                dc.w $685E, $100, $E0FC
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $EFB
                dc.w $6810, $E00, $FDF1
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DDF1
word_EA43E:     dc.w $684E, $A00, $EDF4 ; DATA XREF: ROM:000EA654   o
                                        ; ROM:000EA65C   o
                dc.w $685E, $100, $E3FC
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $FFB
                dc.w $6810, $E00, $FEF1
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DEF1
word_EA468:     dc.w $684E, $A00, $EEF4 ; DATA XREF: ROM:000EA658   o
                dc.w $685E, $100, $E5FC
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $FFB
                dc.w $6810, $E00, $FFF1
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DFF1
word_EA492:     dc.w $7845, $A00, $ECF4 ; DATA XREF: ROM:off_EA664   o
                dc.w $785A, $500, $FA02
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $EFB
                dc.w $6810, $E00, $FEF1
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DEF1
word_EA4BC:     dc.w $7845, $A00, $EAF2 ; DATA XREF: ROM:000EA668   o
                                        ; ROM:000EA678   o
                dc.w $785A, $500, $F7FF
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $DFA
                dc.w $6810, $E00, $FDF0
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DDF0
word_EA4E6:     dc.w $7845, $A00, $E9F1 ; DATA XREF: ROM:000EA66C   o
                                        ; ROM:000EA674   o
                dc.w $785A, $500, $F5FD
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $CFA
                dc.w $6810, $E00, $FCEF
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DCEF
word_EA510:     dc.w $7845, $A00, $E8EF ; DATA XREF: ROM:000EA670   o
                dc.w $785A, $500, $F3FA
                dc.w $6835, $500, $12F4
                dc.w $6830, 0, $CF8
                dc.w $6810, $E00, $FCEE
                dc.w $6835, $500, $12FB
                dc.w $E800, $F00, $DCEE
word_EA53A:     dc.w $6831, $500, $FF1  ; DATA XREF: ROM:off_EA69C   o
                                        ; ROM:000EA6B0   o
                dc.w $6831, $500, $FF7
                dc.w $6845, $A00, $EDF2
                dc.w $685A, $500, $E9FF
                dc.w $6830, 0, $BF8
                dc.w $6810, $E00, $FAEF
                dc.w $E800, $F00, $DAEF
word_EA564:     dc.w $6831, $500, $12F1 ; DATA XREF: ROM:000EA6A0   o
                                        ; ROM:000EA6AC   o
                dc.w $6831, $500, $12F7
                dc.w $6845, $A00, $E9F2
                dc.w $685A, $500, $E5FF
                dc.w $6830, 0, $CF8
                dc.w $6810, $E00, $F9EF
                dc.w $E800, $F00, $D9EF
word_EA58E:     dc.w $6831, $500, $12F1 ; DATA XREF: ROM:000EA6A4   o
                                        ; ROM:off_EA6A8   o
                dc.w $6831, $500, $12F7
                dc.w $6845, $A00, $E5F2
                dc.w $685A, $500, $E0FF
                dc.w $6830, 0, $AF8
                dc.w $6810, $E00, $F8EF
                dc.w $E800, $F00, $D8EF
off_EA5B8:      dc.w word_EA12C-*       ; DATA XREF: ROM:0002CA94   o
                                        ; ROM:000EA5D8   o
                dc.w 5
                dc.w word_EA156-*
                dc.w 5
                dc.w word_EA180-*
                dc.w 5
                dc.w word_EA1A4-*
                dc.w 5
                dc.w word_EA1CE-*
                dc.w 5
                dc.w word_EA1F8-*
                dc.w 5
                dc.w word_EA222-*
                dc.w 5
                dc.w word_EA246-*
                dc.w 5
                dc.w off_EA5B8-*
                dc.w 0
off_EA5DC:      dc.w word_EA05A-*       ; DATA XREF: ROM:off_2CA90   o
                                        ; ROM:000EA5F4   o
                dc.w 8
                dc.w word_EA084-*
                dc.w 6
                dc.w word_EA0AE-*
                dc.w 4
                dc.w word_EA0D8-*
                dc.w 6
                dc.w word_EA0AE-*
                dc.w 4
                dc.w word_EA084-*
                dc.w 6
                dc.w off_EA5DC-*
                dc.w 0
off_EA5F8:      dc.w word_EA246-*       ; DATA XREF: ROM:0002CA98   o
                                        ; ROM:000EA618   o
                dc.w 6
                dc.w word_EA222-*
                dc.w 6
                dc.w word_EA1F8-*
                dc.w 6
                dc.w word_EA1CE-*
                dc.w 6
                dc.w word_EA1A4-*
                dc.w 6
                dc.w word_EA180-*
                dc.w 6
                dc.w word_EA156-*
                dc.w 6
                dc.w word_EA12C-*
                dc.w 6
                dc.w off_EA5F8-*
                dc.w 0
off_EA61C:      dc.w word_EA084-*       ; DATA XREF: ROM:0002CA9C   o
                                        ; ROM:off_2CB56   o ...
                dc.w 2
                dc.w word_EA270-*
                dc.w 2
                dc.w word_EA29A-*
                dc.w 2
                dc.w word_EA2C4-*
                dc.w 2
                dc.w word_EA29A-*
                dc.w 2
                dc.w word_EA270-*
                dc.w $FF
off_EA634:      dc.w word_EA318-*       ; DATA XREF: ROM:0002CAA0   o
                                        ; ROM:0002CB5E   o ...
                dc.w 2
                dc.w word_EA396-*
                dc.w 2
                dc.w word_EA3C0-*
                dc.w 2
                dc.w word_EA3EA-*
                dc.w 2
                dc.w word_EA3C0-*
                dc.w 2
                dc.w word_EA396-*
                dc.w $FF
off_EA64C:      dc.w word_EA36C-*       ; DATA XREF: ROM:0002CAA4   o
                                        ; ROM:0002CB6E   o
                dc.w 2
                dc.w word_EA414-*
                dc.w 2
                dc.w word_EA43E-*
                dc.w 2
                dc.w word_EA468-*
                dc.w 2
                dc.w word_EA43E-*
                dc.w 2
                dc.w word_EA414-*
                dc.w $FF
off_EA664:      dc.w word_EA492-*       ; DATA XREF: ROM:0002CAA8   o
                                        ; ROM:0002CB5A   o ...
                dc.w 2
                dc.w word_EA4BC-*
                dc.w 2
                dc.w word_EA4E6-*
                dc.w 2
                dc.w word_EA510-*
                dc.w 2
                dc.w word_EA4E6-*
                dc.w 2
                dc.w word_EA4BC-*
                dc.w $FF
off_EA67C:      dc.w word_EA05A-*       ; DATA XREF: ROM:0002CAAC   o
                dc.w 1
                dc.w word_EA0AE-*
                dc.w 2
                dc.w word_EA102-*
                dc.w 3
                dc.w word_EA2EE-*
                dc.w 3
                dc.w word_EA342-*
                dc.w 4
                dc.w word_EA2EE-*
                dc.w 3
                dc.w word_EA102-*
                dc.w 2
                dc.w word_EA0AE-*
                dc.w $FF
off_EA69C:      dc.w word_EA53A-*       ; DATA XREF: ROM:0002CAB0   o
                                        ; Boss_JetsripperIdle+10   o
                dc.w 4
                dc.w word_EA564-*
                dc.w 4
                dc.w word_EA58E-*
                dc.w $FF
off_EA6A8:      dc.w word_EA58E-*       ; DATA XREF: ROM:0002CAB4   o
                dc.w 6
                dc.w word_EA564-*
                dc.w 6
                dc.w word_EA53A-*
                dc.w $FF
word_EA6B4:     dc.w $6870, 0, $1AE8    ; DATA XREF: ROM:off_EA7E0   o
                                        ; ROM:off_EA814   o
                dc.w $686C, $500, $AE8
                dc.w $681F, $400, $DCEA
                dc.w $6813, $B00, $E4EA
                dc.w $6810, $200, $10D
                dc.w $E800, $F00, $F9ED
word_EA6D8:     dc.w $6870, 0, $19E8    ; DATA XREF: ROM:000EA7E4   o
                                        ; ROM:000EA80C   o ...
                dc.w $686C, $500, $9E8
                dc.w $682A, $400, $E5EA
                dc.w $6821, $A00, $EDEA
                dc.w $6810, $200, $10D
                dc.w $E800, $F00, $F9ED
word_EA6FC:     dc.w $682C, $A00, $EDEA ; DATA XREF: ROM:000EA7E8   o
                                        ; ROM:000EA808   o ...
                dc.w $6871, $800, $CDF
                dc.w $6810, $200, $D
                dc.w $E800, $F00, $F8ED
word_EA714:     dc.w $6835, $800, $FEEB ; DATA XREF: ROM:000EA7EC   o
                                        ; ROM:000EA804   o ...
                dc.w $6871, $800, $CDF
                dc.w $6810, $200, $D
                dc.w $E800, $F00, $F8ED
word_EA72C:     dc.w $7835, $800, $EC   ; DATA XREF: ROM:000EA7F0   o
                                        ; ROM:000EA800   o ...
                dc.w $6871, $800, $BDF
                dc.w $6810, $200, $FF0D
                dc.w $E800, $F00, $F7ED
word_EA744:     dc.w $6838, $A00, $2EE  ; DATA XREF: ROM:000EA7F4   o
                                        ; ROM:000EA7FC   o ...
                dc.w $6871, $800, $BDF
                dc.w $6810, $200, $FF0D
                dc.w $E800, $F00, $F7ED
word_EA75C:     dc.w $684A, $400, $19F0 ; DATA XREF: ROM:000EA7F8   o
                                        ; ROM:000EA82C   o
                dc.w $6841, $A00, $1F0
                dc.w $6871, $800, $ADF
                dc.w $6810, $200, $FE0D
                dc.w $E800, $F00, $F6ED
word_EA77A:     dc.w $684C, $A00, $4F6  ; DATA XREF: ROM:off_EA848   o
                                        ; ROM:000EA864   o
                dc.w $6862, $500, $10EB
                dc.w $6810, $200, $50D
                dc.w $E800, $F00, $FDED
word_EA792:     dc.w $684C, $A00, $5F7  ; DATA XREF: ROM:000EA84C   o
                                        ; ROM:000EA854   o ...
                dc.w $6866, $500, $10EB
                dc.w $6810, $200, $70F
                dc.w $E800, $F00, $FFEF
word_EA7AA:     dc.w $6857, $D00, $8F4  ; DATA XREF: ROM:000EA850   o
                                        ; ROM:off_EA85C   o
                dc.w $686A, $400, $18EB
                dc.w $6810, $200, $90E
                dc.w $E800, $F00, $1EE
word_EA7C2:     dc.w $684C, $A00, $3F4  ; DATA XREF: ROM:000EA868   o
                dc.w $6870, 0, $1BE8
                dc.w $686C, $500, $BE8
                dc.w $6810, $200, $30D
                dc.w $E800, $F00, $FBED
off_EA7E0:      dc.w word_EA6B4-*       ; DATA XREF: ROM:off_2DAA0   o
                                        ; ROM:000EA810   o
                dc.w 4
                dc.w word_EA6D8-*
                dc.w 3
                dc.w word_EA6FC-*
                dc.w 2
                dc.w word_EA714-*
                dc.w 1
                dc.w word_EA72C-*
                dc.w 2
                dc.w word_EA744-*
                dc.w 3
                dc.w word_EA75C-*
                dc.w 4
                dc.w word_EA744-*
                dc.w 3
                dc.w word_EA72C-*
                dc.w 2
                dc.w word_EA714-*
                dc.w 1
                dc.w word_EA6FC-*
                dc.w 2
                dc.w word_EA6D8-*
                dc.w 3
                dc.w off_EA7E0-*
                dc.w 0
off_EA814:      dc.w word_EA6B4-*       ; DATA XREF: ROM:0002DAA4   o
                                        ; ROM:000EA844   o
                dc.w 2
                dc.w word_EA6D8-*
                dc.w 1
                dc.w word_EA6FC-*
                dc.w 1
                dc.w word_EA714-*
                dc.w 1
                dc.w word_EA72C-*
                dc.w 1
                dc.w word_EA744-*
                dc.w 1
                dc.w word_EA75C-*
                dc.w 2
                dc.w word_EA744-*
                dc.w 1
                dc.w word_EA72C-*
                dc.w 1
                dc.w word_EA714-*
                dc.w 1
                dc.w word_EA6FC-*
                dc.w 1
                dc.w word_EA6D8-*
                dc.w 1
                dc.w off_EA814-*
                dc.w 0
off_EA848:      dc.w word_EA77A-*       ; DATA XREF: ROM:0002DAA8   o
                                        ; ROM:000EA858   o
                dc.w 6
                dc.w word_EA792-*
                dc.w 4
                dc.w word_EA7AA-*
                dc.w 6
                dc.w word_EA792-*
                dc.w 4
                dc.w off_EA848-*
                dc.w 0
off_EA85C:      dc.w word_EA7AA-*       ; DATA XREF: ROM:0002DAAC   o
                dc.w 2
                dc.w word_EA792-*
                dc.w 2
                dc.w word_EA77A-*
                dc.w 2
                dc.w word_EA7C2-*
                dc.w $FF
word_EA86C:     dc.w $601C, $400, $1FF0 ; DATA XREF: ROM:off_EADCA   o
                                        ; ROM:000EADE6   o ...
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6010, $D00, $E7E0
                dc.w $6810, $D00, $E700
                dc.w $6018, $C00, $17E0
                dc.w $6818, $C00, $1700
                dc.w $602E, $700, $F7F0
                dc.w $682E, $700, $F700
                dc.w $6000, $B00, $F7D8
                dc.w $E800, $B00, $F710
word_EA8B4:     dc.w $6010, $D00, $E7E0 ; DATA XREF: ROM:000EADCE   o
                                        ; ROM:000EADE2   o ...
                dc.w $6026, $700, $F7F0
                dc.w $6826, $700, $F700
                dc.w $601C, $400, $1FF0
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6810, $D00, $E700
                dc.w $6018, $C00, $17E0
                dc.w $6818, $C00, $1700
                dc.w $6000, $B00, $F7D8
                dc.w $E800, $B00, $F710
word_EA8FC:     dc.w $601E, $700, $F7F0 ; DATA XREF: ROM:000EADD2   o
                                        ; ROM:000EADDE   o ...
                dc.w $681E, $700, $F700
                dc.w $601C, $400, $1FF0
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6010, $D00, $E7E0
                dc.w $6810, $D00, $E700
                dc.w $6018, $C00, $17E0
                dc.w $6818, $C00, $1700
                dc.w $6000, $B00, $F7D8
                dc.w $E800, $B00, $F710
word_EA944:     dc.w $683E, $500, $FFF8 ; DATA XREF: ROM:000EADD6   o
                                        ; ROM:off_EADDA   o ...
                dc.w $6036, $700, $F7F0
                dc.w $6836, $700, $F700
                dc.w $601C, $400, $1FF0
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6010, $D00, $E7E0
                dc.w $6810, $D00, $E700
                dc.w $6018, $C00, $17E0
                dc.w $6818, $C00, $1700
                dc.w $6000, $B00, $F7D8
                dc.w $E800, $B00, $F710
word_EA992:     dc.w $683E, $500, $FFFA ; DATA XREF: ROM:000EAE0A   o
                                        ; ROM:000EAE1A   o
                dc.w $6036, $700, $F7F0
                dc.w $6836, $700, $F700
                dc.w $601C, $400, $1FF0
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6010, $D00, $E7E0
                dc.w $6810, $D00, $E700
                dc.w $6018, $C00, $17E0
                dc.w $6818, $C00, $1700
                dc.w $6000, $B00, $F7D8
                dc.w $E800, $B00, $F710
word_EA9E0:     dc.w $683E, $500, $FFFC ; DATA XREF: ROM:000EAE0E   o
                                        ; ROM:000EAE16   o
                dc.w $6036, $700, $F7F0
                dc.w $6836, $700, $F700
                dc.w $601C, $400, $1FF0
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6010, $D00, $E7E0
                dc.w $6810, $D00, $E700
                dc.w $6018, $C00, $17E0
                dc.w $6818, $C00, $1700
                dc.w $6000, $B00, $F7D8
                dc.w $E800, $B00, $F710
word_EAA2E:     dc.w $683E, $500, $FFFD ; DATA XREF: ROM:000EAE12   o
                dc.w $6036, $700, $F7F0
                dc.w $6836, $700, $F700
                dc.w $601C, $400, $1FF0
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6010, $D00, $E7E0
                dc.w $6810, $D00, $E700
                dc.w $6018, $C00, $17E0
                dc.w $6818, $C00, $1700
                dc.w $6000, $B00, $F7D8
                dc.w $E800, $B00, $F710
word_EAA7C:     dc.w $683E, $500, $FFF6 ; DATA XREF: ROM:000EAE22   o
                                        ; ROM:000EAE32   o
                dc.w $6036, $700, $F7F0
                dc.w $6836, $700, $F700
                dc.w $601C, $400, $1FF0
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6010, $D00, $E7E0
                dc.w $6810, $D00, $E700
                dc.w $6018, $C00, $17E0
                dc.w $6818, $C00, $1700
                dc.w $6000, $B00, $F7D8
                dc.w $E800, $B00, $F710
word_EAACA:     dc.w $683E, $500, $FFF4 ; DATA XREF: ROM:000EAE26   o
                                        ; ROM:000EAE2E   o
                dc.w $6036, $700, $F7F0
                dc.w $6836, $700, $F700
                dc.w $601C, $400, $1FF0
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6010, $D00, $E7E0
                dc.w $6810, $D00, $E700
                dc.w $6018, $C00, $17E0
                dc.w $6818, $C00, $1700
                dc.w $6000, $B00, $F7D8
                dc.w $E800, $B00, $F710
word_EAB18:     dc.w $683E, $500, $FFF3 ; DATA XREF: ROM:000EAE2A   o
                dc.w $6036, $700, $F7F0
                dc.w $6836, $700, $F700
                dc.w $601C, $400, $1FF0
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6010, $D00, $E7E0
                dc.w $6810, $D00, $E700
                dc.w $6018, $C00, $17E0
                dc.w $6818, $C00, $1700
                dc.w $6000, $B00, $F7D8
                dc.w $E800, $B00, $F710
word_EAB66:     dc.w $6026, $700, $F7F0 ; DATA XREF: ROM:off_EAE3A   o
                                        ; ROM:000EAE52   o
                dc.w $6826, $700, $F700
                dc.w $6018, $C00, $17E0
                dc.w $6000, $B00, $F7D8
                dc.w $604E, $A00, $DD8
                dc.w $6818, $C00, $1700
                dc.w $6800, $B00, $F710
                dc.w $684E, $A00, $D10
                dc.w $601C, $400, $1FF0
                dc.w $681C, $400, $1F00
                dc.w $600C, $500, $D7F0
                dc.w $680C, $500, $D700
                dc.w $6010, $D00, $E7E0
                dc.w $E810, $D00, $E700
word_EABBA:     dc.w $602E, $700, $F4F0 ; DATA XREF: ROM:000EAE3E   o
                                        ; ROM:000EAE4E   o
                dc.w $682E, $700, $F400
                dc.w $6018, $C00, $14E0
                dc.w $6000, $B00, $F4D8
                dc.w $604E, $A00, $DD9
                dc.w $6818, $C00, $1400
                dc.w $6800, $B00, $F410
                dc.w $684E, $A00, $D0F
                dc.w $601C, $400, $1CF0
                dc.w $681C, $400, $1C00
                dc.w $600C, $500, $D4F0
                dc.w $680C, $500, $D400
                dc.w $6010, $D00, $E4E0
                dc.w $E810, $D00, $E400
word_EAC0E:     dc.w $6026, $700, $F1F0 ; DATA XREF: ROM:000EAE42   o
                                        ; ROM:off_EAE4A   o
                dc.w $6826, $700, $F1FF
                dc.w $6018, $C00, $11E0
                dc.w $6000, $B00, $F1D8
                dc.w $6048, $600, $EE0
                dc.w $6800, $B00, $F110
                dc.w $6818, $C00, $1100
                dc.w $6848, $600, $E10
                dc.w $601C, $400, $19F0
                dc.w $681C, $400, $1900
                dc.w $600C, $500, $D1F0
                dc.w $680C, $500, $D100
                dc.w $6010, $D00, $E1E0
                dc.w $E810, $D00, $E100
word_EAC62:     dc.w $6000, $B00, $EED8 ; DATA XREF: ROM:000EAE46   o
                                        ; ROM:off_EAE5A   o
                dc.w $6818, $C00, $E00
                dc.w $6800, $B00, $EE10
                dc.w $6018, $C00, $EE0
                dc.w $6042, $600, $DDE
                dc.w $6842, $600, $D12
                dc.w $683E, $500, $F6F4
                dc.w $6836, $700, $EE00
                dc.w $6036, $700, $EEF0
                dc.w $601C, $400, $16F0
                dc.w $681C, $400, $1600
                dc.w $600C, $500, $CEF0
                dc.w $680C, $500, $CE00
                dc.w $6010, $D00, $DEE0
                dc.w $E810, $D00, $DE00
word_EACBC:     dc.w $6000, $B00, $EED8 ; DATA XREF: ROM:000EAE5E   o
                                        ; ROM:000EAE6E   o
                dc.w $6818, $C00, $E00
                dc.w $6800, $B00, $EE10
                dc.w $6018, $C00, $EE0
                dc.w $6042, $600, $DDC
                dc.w $6842, $600, $D14
                dc.w $683E, $500, $F6F4
                dc.w $6836, $700, $EE00
                dc.w $6036, $700, $EEF0
                dc.w $601C, $400, $16F0
                dc.w $681C, $400, $1600
                dc.w $600C, $500, $CEF0
                dc.w $680C, $500, $CE00
                dc.w $6010, $D00, $DEE0
                dc.w $E810, $D00, $DE00
word_EAD16:     dc.w $6000, $B00, $EFD8 ; DATA XREF: ROM:000EAE62   o
                                        ; ROM:000EAE6A   o
                dc.w $6018, $C00, $FE0
                dc.w $6818, $C00, $F00
                dc.w $6800, $B00, $EF10
                dc.w $6048, $600, $DDB
                dc.w $6848, $600, $D16
                dc.w $683E, $500, $F7F4
                dc.w $6836, $700, $EF00
                dc.w $6036, $700, $EFF0
                dc.w $601C, $400, $17F0
                dc.w $681C, $400, $1700
                dc.w $600C, $500, $CFF0
                dc.w $680C, $500, $CF00
                dc.w $6010, $D00, $DFE0
                dc.w $E810, $D00, $DF00
word_EAD70:     dc.w $6000, $B00, $F0D8 ; DATA XREF: ROM:000EAE66   o
                dc.w $6018, $C00, $10E0
                dc.w $6818, $C00, $1000
                dc.w $6800, $B00, $F010
                dc.w $604E, $A00, $DD1
                dc.w $684E, $A00, $D18
                dc.w $683E, $500, $F8F4
                dc.w $6836, $700, $F000
                dc.w $6036, $700, $F0F0
                dc.w $601C, $400, $18F0
                dc.w $681C, $400, $1800
                dc.w $600C, $500, $D0F0
                dc.w $680C, $500, $D000
                dc.w $6010, $D00, $E0E0
                dc.w $E810, $D00, $E000
off_EADCA:      dc.w word_EA86C-*       ; DATA XREF: ROM:0002D008   o
                dc.w 2
                dc.w word_EA8B4-*
                dc.w 2
                dc.w word_EA8FC-*
                dc.w 2
                dc.w word_EA944-*
                dc.w $FF
off_EADDA:      dc.w word_EA944-*       ; DATA XREF: ROM:0002D00C   o
                dc.w 2
                dc.w word_EA8FC-*
                dc.w 2
                dc.w word_EA8B4-*
                dc.w 2
                dc.w word_EA86C-*
                dc.w $FF
off_EADEA:      dc.w word_EA944-*       ; DATA XREF: ROM:off_2D004   o
                                        ; ROM:000EAE02   o
                dc.w $70
                dc.w word_EA8FC-*
                dc.w 1
                dc.w word_EA8B4-*
                dc.w 1
                dc.w word_EA86C-*
                dc.w 2
                dc.w word_EA8B4-*
                dc.w 1
                dc.w word_EA8FC-*
                dc.w 1
                dc.w off_EADEA-*
                dc.w 0
off_EAE06:      dc.w word_EA944-*       ; DATA XREF: ROM:0002D010   o
                dc.w 2
                dc.w word_EA992-*
                dc.w 2
                dc.w word_EA9E0-*
                dc.w 2
                dc.w word_EAA2E-*
                dc.w 2
                dc.w word_EA9E0-*
                dc.w 2
                dc.w word_EA992-*
                dc.w 2
                dc.w word_EA944-*
                dc.w 2
                dc.w word_EAA7C-*
                dc.w 2
                dc.w word_EAACA-*
                dc.w 2
                dc.w word_EAB18-*
                dc.w 2
                dc.w word_EAACA-*
                dc.w 2
                dc.w word_EAA7C-*
                dc.w 2
                dc.w word_EA944-*
                dc.w $FF
off_EAE3A:      dc.w word_EAB66-*       ; DATA XREF: ROM:0002D014   o
                dc.w 4
                dc.w word_EABBA-*
                dc.w 4
                dc.w word_EAC0E-*
                dc.w 4
                dc.w word_EAC62-*
                dc.w $FF
off_EAE4A:      dc.w word_EAC0E-*       ; DATA XREF: ROM:0002D018   o
                dc.w 5
                dc.w word_EABBA-*
                dc.w 5
                dc.w word_EAB66-*
                dc.w 5
                dc.w word_EA944-*
                dc.w $FF
off_EAE5A:      dc.w word_EAC62-*       ; DATA XREF: ROM:0002D01C   o
                                        ; ROM:000EAE72   o
                dc.w 2
                dc.w word_EACBC-*
                dc.w 2
                dc.w word_EAD16-*
                dc.w 2
                dc.w word_EAD70-*
                dc.w 2
                dc.w word_EAD16-*
                dc.w 2
                dc.w word_EACBC-*
                dc.w 2
                dc.w off_EAE5A-*
                dc.w 0
                dc.w $680C, $F00, $EFE9
                dc.w $6808, $500, $DFF9
                dc.w $6800, $700, $D709
                dc.w $6840, 0, $D919
                dc.w $6824, 0, $18
                dc.w $6825, $D00, $F8
                dc.w $E81C, $D00, $F008
                dc.w $680C, $F00, $F0EA
                dc.w $6808, $500, $E0FA
                dc.w $6800, $700, $D80A
                dc.w $6840, 0, $DA1A
                dc.w $6824, 0, $FF17
                dc.w $6825, $D00, $FFF7
                dc.w $E81C, $D00, $EF07
                dc.w $680C, $F00, $F1EA
                dc.w $6808, $500, $E1FA
                dc.w $6800, $700, $D90A
                dc.w $6840, 0, $DB1A
                dc.w $682D, $500, $FE0B
                dc.w $6837, $A00, $E60B
                dc.w $E831, $600, $F6FB
                dc.w $680C, $F00, $F2EB
                dc.w $6808, $500, $E2FB
                dc.w $6800, $700, $DA0B
                dc.w $6840, 0, $DC1B
                dc.w $682D, $500, $FE0A
                dc.w $6837, $A00, $E60A
                dc.w $E831, $600, $F6FA
word_EAF1E:     dc.w $604D, $500, $6F4  ; DATA XREF: ROM:off_EB278   o
                                        ; ROM:off_EB2CC   o
                dc.w $6851, $D00, $13ED
                dc.w $6841, $500, $FCF3
                dc.w $6849, $500, $2EC
                dc.w $680C, $F00, $EEE3
                dc.w $6808, $500, $DEF3
                dc.w $6800, $700, $D603
                dc.w $6840, 0, $D813
                dc.w $6824, 0, $FF12
                dc.w $6825, $D00, $FFF2
                dc.w $E81C, $D00, $EF02
word_EAF60:     dc.w $604D, $500, $7F6  ; DATA XREF: ROM:000EB27C   o
                                        ; ROM:000EB28C   o ...
                dc.w $6851, $D00, $13ED
                dc.w $6841, $500, $FEF5
                dc.w $6849, $500, $1F0
                dc.w $680C, $F00, $F0E6
                dc.w $6808, $500, $E0F6
                dc.w $6800, $700, $D806
                dc.w $6840, 0, $DA16
                dc.w $6824, 0, $FF13
                dc.w $6825, $D00, $FFF3
                dc.w $E81C, $D00, $EF03
word_EAFA2:     dc.w $7049, $500, $AF7  ; DATA XREF: ROM:000EB280   o
                                        ; ROM:000EB288   o ...
                dc.w $6851, $D00, $13ED
                dc.w $6041, $500, $5FD
                dc.w $6845, $500, $3F2
                dc.w $680C, $F00, $F1E8
                dc.w $6808, $500, $E1F8
                dc.w $6800, $700, $D908
                dc.w $6840, 0, $DB18
                dc.w $682D, $500, $FE09
                dc.w $6837, $A00, $E609
                dc.w $E831, $600, $F6F9
word_EAFE4:     dc.w $6841, $500, $902  ; DATA XREF: ROM:000EB284   o
                                        ; ROM:000EB29C   o ...
                dc.w $7845, $500, $DF8
                dc.w $6845, $500, $6F8
                dc.w $6851, $D00, $13ED
                dc.w $680C, $F00, $F2EB
                dc.w $6808, $500, $E2FB
                dc.w $6800, $700, $DA0B
                dc.w $6840, 0, $DC1B
                dc.w $682D, $500, $FE0A
                dc.w $6837, $A00, $E60A
                dc.w $E831, $600, $F6FA
word_EB026:     dc.w $7049, $500, $BF9  ; DATA XREF: ROM:000EB2A8   o
                dc.w $6841, $500, $402
                dc.w $6845, $500, $3FB
                dc.w $6851, $D00, $13ED
                dc.w $680C, $F00, $EEEF
                dc.w $6808, $500, $DEFF
                dc.w $6800, $700, $D60F
                dc.w $6840, 0, $D81F
                dc.w $682D, $500, $FA0E
                dc.w $6837, $A00, $E20E
                dc.w $E831, $600, $F2FE
word_EB068:     dc.w $7049, $500, $AF9  ; DATA XREF: ROM:000EB2AC   o
                dc.w $6851, $D00, $13ED
                dc.w $6841, $500, $300
                dc.w $6049, $500, $FBF9
                dc.w $680C, $F00, $E8F1
                dc.w $6808, $500, $D801
                dc.w $6800, $700, $D011
                dc.w $6840, 0, $D221
                dc.w $682D, $500, $F410
                dc.w $6837, $A00, $DC10
                dc.w $E831, $600, $EC00
word_EB0AA:     dc.w $7049, $500, $9F0  ; DATA XREF: ROM:000EB2B0   o
                                        ; ROM:off_EB2B4   o
                dc.w $6859, $A00, $12E5
                dc.w $604D, $500, $F9F5
                dc.w $6841, $500, $3F4
                dc.w $680C, $F00, $E2EF
                dc.w $6808, $500, $D2FF
                dc.w $6800, $700, $CA0F
                dc.w $6840, 0, $CC1F
                dc.w $682D, $500, $EE0E
                dc.w $6837, $A00, $D60E
                dc.w $E831, $600, $E6FE
word_EB0EC:     dc.w $6841, $500, $9FF  ; DATA XREF: ROM:000EB2A0   o
                dc.w $7845, $500, $DF5
                dc.w $6845, $500, $7F5
                dc.w $6851, $D00, $13ED
                dc.w $680C, $F00, $F6E7
                dc.w $6808, $500, $E6F7
                dc.w $6800, $700, $DE07
                dc.w $6840, 0, $E017
                dc.w $682D, $500, $206
                dc.w $6837, $A00, $EA06
                dc.w $E831, $600, $FAF6
word_EB12E:     dc.w $7049, $500, $BF3  ; DATA XREF: ROM:000EB2B8   o
                dc.w $6859, $A00, $14E8
                dc.w $604D, $500, $FBF3
                dc.w $6841, $500, $5F5
                dc.w $680C, $F00, $E4ED
                dc.w $6808, $500, $D4FD
                dc.w $6800, $700, $CC0D
                dc.w $6840, 0, $CE1D
                dc.w $682D, $500, $F00C
                dc.w $6837, $A00, $D80C
                dc.w $E831, $600, $E8FC
word_EB170:     dc.w $604D, $500, $EF5  ; DATA XREF: ROM:000EB2BC   o
                dc.w $6859, $A00, $1AEE
                dc.w $604D, $500, $FCF4
                dc.w $6841, $500, $5F5
                dc.w $680C, $F00, $E5EC
                dc.w $6808, $500, $D5FC
                dc.w $6800, $700, $CD0C
                dc.w $6840, 0, $CF1C
                dc.w $682D, $500, $F10B
                dc.w $6837, $A00, $D90B
                dc.w $E831, $600, $E9FB
word_EB1B2:     dc.w $6049, $500, $FBF6 ; DATA XREF: ROM:000EB2C0   o
                dc.w $604D, $500, $BFA
                dc.w $6859, $A00, $17F2
                dc.w $6841, $500, $4FB
                dc.w $680C, $F00, $E5EB
                dc.w $6808, $500, $D5FB
                dc.w $6800, $700, $CD0B
                dc.w $6840, 0, $CF1B
                dc.w $682D, $500, $F10A
                dc.w $6837, $A00, $D90A
                dc.w $E831, $600, $E9FA
word_EB1F4:     dc.w $6845, $500, $FAF6 ; DATA XREF: ROM:000EB2C4   o
                dc.w $604D, $500, $7FF
                dc.w $6859, $A00, $13F7
                dc.w $6841, $500, $FEFE
                dc.w $680C, $F00, $E6EA
                dc.w $6808, $500, $D6FA
                dc.w $6800, $700, $CE0A
                dc.w $6840, 0, $D01A
                dc.w $682D, $500, $F209
                dc.w $6837, $A00, $DA09
                dc.w $E831, $600, $EAF9
word_EB236:     dc.w $6049, $500, $305  ; DATA XREF: ROM:000EB2C8   o
                dc.w $6851, $D00, $D04
                dc.w $6845, $500, $FAF7
                dc.w $6841, $500, $FDFF
                dc.w $680C, $F00, $E6E9
                dc.w $6808, $500, $D6F9
                dc.w $6800, $700, $CE09
                dc.w $6840, 0, $D019
                dc.w $682D, $500, $F208
                dc.w $6837, $A00, $DA08
                dc.w $E831, $600, $EAF8
off_EB278:      dc.w word_EAF1E-*       ; DATA XREF: ROM:off_2E0AE   o
                                        ; ROM:000EB290   o
                dc.w 4
                dc.w word_EAF60-*
                dc.w 2
                dc.w word_EAFA2-*
                dc.w 2
                dc.w word_EAFE4-*
                dc.w 4
                dc.w word_EAFA2-*
                dc.w 2
                dc.w word_EAF60-*
                dc.w 2
                dc.w off_EB278-*
                dc.w 0
off_EB294:      dc.w word_EAF60-*       ; DATA XREF: ROM:0002E0B2   o
                dc.w 2
                dc.w word_EAFA2-*
                dc.w 2
                dc.w word_EAFE4-*
                dc.w 3
                dc.w word_EB0EC-*
                dc.w 4
                dc.w word_EAFE4-*
                dc.w 3
                dc.w word_EB026-*
                dc.w 2
                dc.w word_EB068-*
                dc.w 2
                dc.w word_EB0AA-*
                dc.w $FF
off_EB2B4:      dc.w word_EB0AA-*       ; DATA XREF: ROM:0002E0B6   o
                                        ; Enemy_Stage10WaspDeath+10   o
                dc.w 6
                dc.w word_EB12E-*
                dc.w 6
                dc.w word_EB170-*
                dc.w 6
                dc.w word_EB1B2-*
                dc.w 6
                dc.w word_EB1F4-*
                dc.w 6
                dc.w word_EB236-*
                dc.w $FF
off_EB2CC:      dc.w word_EAF1E-*       ; DATA XREF: ROM:0002E0BA   o
                dc.w 1
                dc.w word_EAF60-*
                dc.w 2
                dc.w word_EAFA2-*
                dc.w 3
                dc.w word_EAFE4-*
                dc.w 4
                dc.w word_EAFA2-*
                dc.w 3
                dc.w word_EAF60-*
                dc.w $FF
word_EB2E4:     dc.w $E800, $E00, $F7F0 ; DATA XREF: ROM:off_EB320   o
word_EB2EA:     dc.w $E80C, $E00, $F6F0 ; DATA XREF: ROM:000EB324   o
word_EB2F0:     dc.w $E818, $E00, $F6F0 ; DATA XREF: ROM:000EB328   o
word_EB2F6:     dc.w $E824, $E00, $F5F0 ; DATA XREF: ROM:000EB32C   o
word_EB2FC:     dc.w $E830, $E00, $F6F0 ; DATA XREF: ROM:000EB330   o
word_EB302:     dc.w $E83C, $B00, $EEF4 ; DATA XREF: ROM:0002D336   o
                                        ; ROM:0002D356   o
word_EB308:     dc.w $E848, $B00, $F0F5 ; DATA XREF: ROM:0002D332   o
                                        ; ROM:0002D33A   o ...
word_EB30E:     dc.w $E854, $F00, $F0F0 ; DATA XREF: ROM:0002D32E   o
                                        ; ROM:0002D33E   o ...
word_EB314:     dc.w $E864, $E00, $F5F0 ; DATA XREF: ROM:0002D32A   o
                                        ; ROM:0002D342   o ...
word_EB31A:     dc.w $E870, $E00, $F4EF ; DATA XREF: ROM:off_2D326   o
                                        ; ROM:0002D346   o
off_EB320:      dc.w word_EB2E4-*       ; DATA XREF: ROM:off_2D2EC   o
                                        ; ROM:000EB334   o
                dc.w 2
                dc.w word_EB2EA-*
                dc.w 2
                dc.w word_EB2F0-*
                dc.w 2
                dc.w word_EB2F6-*
                dc.w 2
                dc.w word_EB2FC-*
                dc.w 2
                dc.w off_EB320-*
                dc.w 0
word_EB338:     dc.w $6010, $F00, $E0   ; DATA XREF: Enemy_GustheadEyeChainInit+C   o
                dc.w $6000, $F00, $E0E0
                dc.w $6810, $F00, 0
                dc.w $E800, $F00, $E000
word_EB350:     dc.w $E820, $A00, $F4F4 ; DATA XREF: Enemy_GustheadSmallEyeInit+C   o
word_EB356:     dc.w $6816, $700, $F4EA ; DATA XREF: Enemy_Stage11BossPartInit+C   o
                dc.w $6806, $F00, $F4FA
                dc.w $6802, $C00, $ECF4
                dc.w $E800, $400, $E402
word_EB36E:     dc.w $4009, $A00, $E8   ; DATA XREF: Boss_JetsripperDebrisInit+C   o
                dc.w $4809, $A00, 0
                dc.w $4000, $A00, $E8E8
                dc.w $C800, $A00, $E800
word_EB386:     dc.w $4812, $E00, $F600 ; DATA XREF: Boss_JetsripperWeaponInit+C   o
                dc.w $C81E, $F00, $F0E0
word_EB392:     dc.w $6804, $D00, $F0   ; DATA XREF: ROM:off_EB3C8   o
                dc.w $6000, $500, $F0F0
                dc.w $E800, $500, $F000
word_EB3A4:     dc.w $680C, $D00, $F0   ; DATA XREF: ROM:000EB3CC   o
                dc.w $6000, $500, $F0F0
                dc.w $E800, $500, $F000
word_EB3B6:     dc.w $6814, $D00, $F0   ; DATA XREF: ROM:000EB3D0   o
                dc.w $6000, $500, $F0F0
                dc.w $E800, $500, $F000
off_EB3C8:      dc.w word_EB392-*       ; DATA XREF: Enemy_TrackerInitProjectile+38   o
                                        ; ROM:000EB3D4   o
                dc.w 3
                dc.w word_EB3A4-*
                dc.w 3
                dc.w word_EB3B6-*
                dc.w 3
                dc.w off_EB3C8-*
                dc.w 0
word_EB3D8:     dc.w $6800, $700, $E5F8 ; DATA XREF: Projectile_MissirayBulletInit+6   o
                                        ; ROM:off_EB492   o
                dc.w $E808, $700, $FAF8
word_EB3E4:     dc.w $6800, $700, $E3F8 ; DATA XREF: ROM:000EB496   o
                dc.w $E808, $700, $FCF8
word_EB3F0:     dc.w $6800, $700, $E1F8 ; DATA XREF: ROM:000EB49A   o
                dc.w $E808, $700, $FEF8
word_EB3FC:     dc.w $6800, $700, $E0F8 ; DATA XREF: Enemy_FlyerAnimation2+6   o
                                        ; Projectile_FlyerAccelerateDown+14   o ...
                dc.w $E808, $700, $FFF8
word_EB408:     dc.w $6842, $D00, $5EF  ; DATA XREF: Enemy_FlyerMovement2+A   o
                                        ; sub_2EDD8:loc_2EDFA   o ...
                dc.w $6810, $F00, $F600
                dc.w $684A, $100, $5E7
                dc.w $6820, $E00, $F6E0
                dc.w $683A, $100, $E6DF
                dc.w $682C, $400, $EEF
                dc.w $E82E, $E00, $DEE7
word_EB432:     dc.w $683A, $100, $E6DF ; DATA XREF: Enemy_FlyerState2+24   o
                                        ; sub_2EE0C:loc_2EE32   o
                dc.w $6852, $700, $5EF
                dc.w $684C, $600, $5FF
                dc.w $6820, $E00, $F6E0
                dc.w $6810, $F00, $F600
                dc.w $682C, $400, $EEF
                dc.w $E82E, $E00, $DEE7
word_EB45C:     dc.w $6860, $600, $F4ED ; DATA XREF: Enemy_FlyerState6+28   o
                dc.w $685A, $600, $FCFD
                dc.w $6820, $E00, $F6E0
                dc.w $6810, $F00, $F600
                dc.w $683A, $100, $E6DF
                dc.w $682C, $400, $EEF
                dc.w $E82E, $E00, $DEE7
word_EB486:     dc.w $683C, $C00, $F6   ; DATA XREF: Enemy_FlyerSpawnProjectile+1C   o
                dc.w $E840, $400, $F8F6
off_EB492:      dc.w word_EB3D8-*       ; DATA XREF: Enemy_FlyerAccelerateFall+1C   o
                dc.w 1
                dc.w word_EB3E4-*
                dc.w 1
                dc.w word_EB3F0-*
                dc.w 1
                dc.w word_EB3FC-*
                dc.w 1
                dc.w word_EB3FC-*
                dc.w $FF
word_EB4A6:     dc.w $603A, $600, $F4F0 ; DATA XREF: Enemy_Stage18SpawnerMain+B8   o
                                        ; ROM:off_3007C   o ...
                dc.w $E800, $A00, $F400
word_EB4B2:     dc.w $6809, 0, $F313    ; DATA XREF: ROM:00030088   o
                                        ; ROM:00030098   o ...
                dc.w $6819, 0, $BFB
                dc.w $6816, $800, $3F3
                dc.w $E80A, $E00, $EBF3
word_EB4CA:     dc.w $7823, $900, $F6   ; DATA XREF: ROM:00030084   o
                                        ; ROM:00030094   o ...
                dc.w $E81A, $A00, $E8F6
word_EB4D6:     dc.w $6838, 0, $FBED    ; DATA XREF: ROM:00030080   o
                                        ; ROM:00030090   o ...
                dc.w $6839, 0, $1305
                dc.w $6835, $200, $F3F5
                dc.w $E829, $B00, $F3FD
word_EB4EE:     dc.w $603A, $600, $F4F0 ; DATA XREF: ROM:0003002C   o
                                        ; ROM:00030030   o ...
                dc.w $E83A, $600, $F400
word_EB4FA:     dc.w $6848, $800, $3F3  ; DATA XREF: ROM:000300C8   o
                                        ; ROM:000300D8   o ...
                dc.w $E840, $D00, $F3F3
word_EB506:     dc.w $7823, $900, $F6   ; DATA XREF: ROM:000300C4   o
                                        ; ROM:000300D4   o ...
                dc.w $E823, $900, $F0F6
word_EB512:     dc.w $6048, $800, $4F6  ; DATA XREF: ROM:000300C0   o
                                        ; ROM:000300D0   o ...
                dc.w $E040, $D00, $F4EE
word_EB51E:     dc.w $685D, 0, $F0F4    ; DATA XREF: ROM:off_30028   o
                                        ; ROM:off_300FC   o ...
                dc.w $E855, $D00, $F8EC
word_EB52A:     dc.w $6866, 0, $BF7     ; DATA XREF: ROM:00030108   o
                                        ; ROM:00030118   o ...
                dc.w $6867, $200, $FBEF
                dc.w $6864, $400, $3F7
                dc.w $E85E, $900, $F3F7
word_EB542:     dc.w $6854, 0, $2F0     ; DATA XREF: ROM:00030104   o
                                        ; ROM:00030114   o ...
                dc.w $E84C, $700, $F2F8
word_EB54E:     dc.w $6872, 0, $F6ED    ; DATA XREF: ROM:00030100   o
                                        ; ROM:00030110   o ...
                dc.w $6873, $800, $EEED
                dc.w $6870, $100, $F6F5
                dc.w $E86A, $600, $F6FD
off_EB566:      dc.w word_EB58C-*       ; DATA XREF: Enemy_Stage18FloaterDeath+12   o
                dc.w 4
                dc.w word_EB586-*
                dc.w 4
                dc.w word_EB58C-*
                dc.w 4
                dc.w word_EB586-*
                dc.w 4
                dc.w word_EB58C-*
                dc.w 4
                dc.w word_EB586-*
                dc.w 4
                dc.w word_EB58C-*
                dc.w 4
                dc.w word_EB58C-*
                dc.w $FF
word_EB586:     dc.w $8876, $500, $F8F8 ; DATA XREF: ROM:000EB56A   o
                                        ; ROM:000EB572   o ...
word_EB58C:     dc.w $887A, 0, $FCFC    ; DATA XREF: ROM:off_EB566   o
                                        ; ROM:000EB56E   o ...
word_EB592:     dc.w $6812, $400, $FCE0 ; DATA XREF: Sprite_AdvanceToNextFrame   o
                dc.w $780C, $600, $F0
                dc.w $680C, $600, $E8F0
                dc.w $7800, $E00, 0
                dc.w $E800, $E00, $E800
word_EB5B0:     dc.w $E814, $A00, $F4F4 ; DATA XREF: Sprite_AdvanceToNextFrame+5E   o
word_EB5B6:     dc.w $2128, $600, $7F1  ; DATA XREF: ROM:off_3D37A   o
                dc.w $2928, $600, $701
                dc.w $2122, $600, $EFF1
                dc.w $A922, $600, $EF01
word_EB5CE:     dc.w $212E, $600, $7F1  ; DATA XREF: ROM:0003D37E   o
                                        ; ROM:0003D386   o
                dc.w $292E, $600, $701
                dc.w $2122, $600, $EFF1
                dc.w $A922, $600, $EF01
word_EB5E6:     dc.w $211A, $700, $F0F1 ; DATA XREF: Boss_CaterpillarPart2+18   o
                dc.w $A91A, $700, $F001
word_EB5F2:     dc.w $2134, $600, $7F1  ; DATA XREF: ROM:0003D382   o
                dc.w $2934, $600, $701
                dc.w $2122, $600, $EFF1
                dc.w $A922, $600, $EF01
word_EB60A:     dc.w $2142, $700, $EFF1 ; DATA XREF: ROM:off_3D40A   o
                dc.w $A942, $700, $EF01
word_EB616:     dc.w $214A, $700, $EFF1 ; DATA XREF: ROM:0003D40E   o
                dc.w $A94A, $700, $EF01
word_EB622:     dc.w $2152, $700, $EFF1 ; DATA XREF: Boss_CaterpillarPart1+24   o
                dc.w $A952, $700, $EF01
word_EB62E:     dc.w $A95A, $A00, $F5F5 ; DATA XREF: Boss_CaterpillarShipInit+76   o
                                        ; ROM:off_EB640   o
word_EB634:     dc.w $A963, $A00, $F7F3 ; DATA XREF: ROM:000EB644   o
                                        ; ROM:000EB64C   o
word_EB63A:     dc.w $A96C, $500, $F8F8 ; DATA XREF: ROM:000EB648   o
off_EB640:      dc.w word_EB62E-*       ; DATA XREF: ROM:000EB650   o
                dc.w 8
                dc.w word_EB634-*
                dc.w 4
                dc.w word_EB63A-*
                dc.w 6
                dc.w word_EB634-*
                dc.w 4
                dc.w off_EB640-*
                dc.w 0
word_EB654:     dc.w $6804, $E00, $F3EE ; DATA XREF: Boss_JetsripperInitBody+1E   o
                                        ; Boss_JetsripperDeathInit+36   o ...
                dc.w $E800, $500, $F90E
word_EB660:     dc.w $6832, $900, $BF4  ; DATA XREF: ROM:00035F6E   o
                                        ; ROM:00035F76   o
                dc.w $6826, $E00, $F3ED
                dc.w $E820, $600, $F70D
word_EB672:     dc.w $6050, $B00, $FDE8 ; DATA XREF: ROM:00035F72   o
                dc.w $6850, $B00, $FD00
                dc.w $E838, $D00, $EDF0
word_EB684:     dc.w $E86C, $D00, $F8F0 ; DATA XREF: ROM:off_35F7A   o
                                        ; ROM:00035F9A   o
word_EB68A:     dc.w $E874, $E00, $F2F0 ; DATA XREF: ROM:00035FA2   o
                                        ; ROM:00035FB2   o
word_EB690:     dc.w $E88C, $F00, $EFF1 ; DATA XREF: ROM:00035FAA   o
word_EB696:     dc.w $605C, $F00, $FDE0 ; DATA XREF: Boss_JetsripperDiveExecute+CE   o
                dc.w $685C, $F00, $FD00
                dc.w $E838, $D00, $EDF0
word_EB6A8:     dc.w $E89C, $D00, $F7E9 ; DATA XREF: ROM:off_35FBA   o
word_EB6AE:     dc.w $E8A4, $E00, $EFEA ; DATA XREF: ROM:00035FBE   o
                                        ; ROM:00035FC6   o
word_EB6B4:     dc.w $E8B0, $B00, $E7F4 ; DATA XREF: ROM:00035FC2   o
word_EB6BA:     dc.w $E8D8, $E00, $F2F1 ; DATA XREF: ROM:00035F9E   o
                                        ; ROM:00035FB6   o
word_EB6C0:     dc.w $E8C8, $F00, $F2EF ; DATA XREF: ROM:00035FA6   o
                                        ; ROM:00035FAE   o
word_EB6C6:     dc.w $E8BC, $E00, $F4F1 ; DATA XREF: ROM:00035F7E   o
                                        ; ROM:00035F96   o
word_EB6CC:     dc.w $E880, $E00, $F4F0 ; DATA XREF: ROM:00035F82   o
                                        ; ROM:00035F92   o
word_EB6D2:     dc.w $E840, $F00, $EDEF ; DATA XREF: ROM:00035F86   o
                                        ; ROM:00035F8E   o
word_EB6D8:     dc.w $E810, $F00, $EFF0 ; DATA XREF: ROM:00035F8A   o
                dc.w $68FE, $400, $13ED
                dc.w $68F2, $B00, $F3ED
                dc.w $68F0, $400, $B05
                dc.w $E8E4, $E00, $F305
word_EB6F6:     dc.w $68FE, $400, $19F4 ; DATA XREF: ROM:off_35B1C   o
                dc.w $68F2, $B00, $F9F4
                dc.w $68F0, $400, $110C
                dc.w $E8E4, $E00, $F90C
word_EB70E:     dc.w $6832, $900, $10FA ; DATA XREF: ROM:00035B20   o
                dc.w $6826, $E00, $F8F3
                dc.w $E820, $600, $FC13
word_EB720:     dc.w $4847, $600, $EF03 ; DATA XREF: Boss_AntroidJumpSlamAttack+12A   o
                                        ; Boss_AntroidJumpSlamAttack+1EC   o ...
                dc.w $484D, $400, $7FB
                dc.w $C84F, $500, $F7F3
word_EB732:     dc.w $4840, $500, $EF0B ; DATA XREF: ROM:000349BE   o
                                        ; Boss_AntroidJumpSlamAttack+198   o ...
                dc.w $4844, $200, $EF03
                dc.w $484D, $400, $7FB
                dc.w $C84F, $500, $F7F3
word_EB74A:     dc.w $C074, $D00, $F8F0 ; DATA XREF: ROM:00034968   o
word_EB750:     dc.w $C06C, $D00, $F8F0 ; DATA XREF: ROM:00034964   o
word_EB756:     dc.w $C063, $A00, $F4F4 ; DATA XREF: ROM:00034960   o
word_EB75C:     dc.w $C05B, $700, $F0F9 ; DATA XREF: ROM:0003495C   o
word_EB762:     dc.w $C853, $700, $F0F8 ; DATA XREF: ROM:00034958   o
word_EB768:     dc.w $C85B, $700, $EFF8 ; DATA XREF: ROM:00034954   o
word_EB76E:     dc.w $C863, $A00, $F3F4 ; DATA XREF: ROM:00034950   o
word_EB774:     dc.w $C86C, $D00, $F7F1 ; DATA XREF: ROM:off_3494C   o
                                        ; RAM:00FFC808   o
word_EB77A:     dc.w $C07C, $D00, $FAEB ; DATA XREF: ROM:off_3496C   o
                                        ; Boss_AntroidTransitionToIdle+42   o ...
word_EB780:     dc.w $58B8, $500, $1EF  ; DATA XREF: ROM:00034970   o
                dc.w $D8BC, $900, $F9F7
word_EB78C:     dc.w $58B0, $600, $FAF4 ; DATA XREF: ROM:00034974   o
                dc.w $D8B6, $400, $FA04
word_EB798:     dc.w $58AF, 0, $F609    ; DATA XREF: ROM:00034978   o
                dc.w $D8A7, $700, $F6F9
word_EB7A4:     dc.w $D89F, $700, $F5FB ; DATA XREF: ROM:0003497C   o
word_EB7AA:     dc.w $589B, $500, $F1FA ; DATA XREF: ROM:00034980   o
                dc.w $D895, $900, $1FA
word_EB7B6:     dc.w $588D, $900, $FDFB ; DATA XREF: ROM:00034984   o
                dc.w $D893, $400, $F5FB
word_EB7C2:     dc.w $588C, 0, $F0F6    ; DATA XREF: ROM:00034988   o
                dc.w $D884, $D00, $F8F8
word_EB7CE:     dc.w $E86E, $D00, $F8F1 ; DATA XREF: ROM:00034A62   o
word_EB7D4:     dc.w $E876, $E00, $F4F0 ; DATA XREF: ROM:00034A5E   o
word_EB7DA:     dc.w $E882, $F00, $EFF0 ; DATA XREF: ROM:00034A5A   o
word_EB7E0:     dc.w $E892, $B00, $F0F6 ; DATA XREF: ROM:00034A56   o
word_EB7E6:     dc.w $F09E, $700, $F0F8 ; DATA XREF: ROM:00034A52   o
word_EB7EC:     dc.w $F0A6, $B00, $F0F4 ; DATA XREF: ROM:00034A4E   o
word_EB7F2:     dc.w $F0B2, $F00, $F0F0 ; DATA XREF: ROM:00034A4A   o
word_EB7F8:     dc.w $F0C2, $E00, $F2F1 ; DATA XREF: ROM:off_34A46   o
word_EB7FE:     dc.w $60D6, $500, $F806 ; DATA XREF: ROM:off_34A66   o
                                        ; Boss_TerobusterMainAI+2A0   o ...
                dc.w $E0CE, $D00, $F8E6
word_EB80A:     dc.w $60E2, $600, $F805 ; DATA XREF: ROM:00034A6A   o
                dc.w $E0DA, $D00, $F8E5
word_EB816:     dc.w $60F0, $900, $F8   ; DATA XREF: ROM:00034A6E   o
                dc.w $E0E8, $D00, $F0E8
word_EB822:     dc.w $60FF, $A00, $1F5  ; DATA XREF: ROM:00034A72   o
                dc.w $E0F6, $A00, $E9ED
word_EB82E:     dc.w $6110, $500, $4F6  ; DATA XREF: ROM:00034A76   o
                dc.w $E108, $700, $E4F6
word_EB83A:     dc.w $611C, $900, $2EE  ; DATA XREF: ROM:00034A7A   o
                dc.w $E114, $700, $E2F6
word_EB846:     dc.w $6126, $E00, $F7EA ; DATA XREF: ROM:00034A7E   o
                dc.w $E122, $500, $E7FF
word_EB852:     dc.w $613A, $600, $E705 ; DATA XREF: ROM:00034A82   o
                dc.w $E132, $D00, $F8E5
                dc.w $694C, $D00, $6F8
                dc.w $E940, $E00, $EEF0
word_EB86A:     dc.w $695A, $E00, $F2EB ; DATA XREF: Boss_TerobusterSetup+96   o
                dc.w $E954, $600, $FA0B
word_EB876:     dc.w $683B, $C00, $6F7  ; DATA XREF: ROM:00034BB0   o
                                        ; Boss_ShellshogunTransitionState+2E   o ...
                dc.w $6835, $600, $F6E8
                dc.w $E829, $E00, $EEF7
word_EB888:     dc.w $6843, $400, $EFF  ; DATA XREF: Boss_ShellshogunAttackPattern+E0   o
                                        ; Boss_ShellshogunUpdateAnimation+E   o ...
                dc.w $683F, $C00, $6F7
                dc.w $6835, $600, $F6E8
                dc.w $E829, $E00, $EEF7
word_EB8A0:     dc.w $6851, $800, $BF8  ; DATA XREF: ROM:00034BB4   o
                                        ; ROM:00034BE0   o
                dc.w $E845, $E00, $F3F0
word_EB8AC:     dc.w $E854, $B00, $EBEF ; DATA XREF: ROM:00034B1C   o
                                        ; ROM:off_34B60   o
word_EB8B2:     dc.w $6868, $400, $3F7  ; DATA XREF: ROM:00034B18   o
                                        ; ROM:00034B64   o
                dc.w $E860, $D00, $F3E7
word_EB8BE:     dc.w $E86A, $D00, $FBE8 ; DATA XREF: ROM:00034B14   o
                                        ; ROM:00034B68   o
word_EB8C4:     dc.w $6875, $C00, $2E9  ; DATA XREF: ROM:00034B10   o
                                        ; ROM:00034B6C   o
                dc.w $E872, $800, $FAF1
word_EB8D0:     dc.w $687F, $800, $9EB  ; DATA XREF: ROM:00034B0C   o
                                        ; ROM:00034B70   o
                dc.w $E879, $900, $F9F3
word_EB8DC:     dc.w $6888, $500, $9F3  ; DATA XREF: ROM:00034B08   o
                                        ; ROM:00034B74   o
                dc.w $E882, $900, $F9F3
word_EB8E8:     dc.w $E88C, $700, $F8FB ; DATA XREF: ROM:00034B04   o
                                        ; ROM:00034B78   o
word_EB8EE:     dc.w $6898, $200, $F7FA ; DATA XREF: ROM:off_34B00   o
                                        ; ROM:00034B7C   o
                dc.w $E894, $300, $F702
word_EB8FA:     dc.w $68A1, $100, $F9F1 ; DATA XREF: ROM:00034B3C   o
                                        ; ROM:off_34B80   o
                dc.w $E89B, $600, $F1F9
word_EB906:     dc.w $68A9, $100, $FAF1 ; DATA XREF: ROM:00034B38   o
                                        ; ROM:00034B84   o
                dc.w $E8A3, $600, $F2F9
word_EB912:     dc.w $68B1, 0, $F1FA    ; DATA XREF: ROM:00034B34   o
                                        ; ROM:00034B88   o
                dc.w $E8AB, $900, $F8F2
word_EB91E:     dc.w $68B8, 0, $7FB     ; DATA XREF: ROM:00034B30   o
                                        ; ROM:00034B8C   o
                dc.w $E8B2, $900, $F7F3
word_EB92A:     dc.w $68BF, 0, $8FA     ; DATA XREF: ROM:00034B2C   o
                                        ; ROM:00034B90   o
                dc.w $E8B9, $900, $F8F2
word_EB936:     dc.w $68C6, 0, $7FA     ; DATA XREF: ROM:00034B28   o
                                        ; ROM:00034B94   o
                dc.w $E8C0, $900, $F7F2
word_EB942:     dc.w $68CD, 0, $FFF1    ; DATA XREF: ROM:00034B24   o
                                        ; ROM:00034B98   o
                dc.w $E8C7, $600, $F6F9
word_EB94E:     dc.w $68D4, 0, $FD07    ; DATA XREF: ROM:off_34B20   o
                                        ; ROM:00034B9C   o
                dc.w $E8CE, $600, $F5F7
word_EB95A:     dc.w $E8D5, $B00, $EDF2 ; DATA XREF: ROM:00034AFC   o
                                        ; ROM:off_34B40   o
word_EB960:     dc.w $E8E1, $A00, $F3F4 ; DATA XREF: ROM:00034AF8   o
                                        ; ROM:00034B44   o
word_EB966:     dc.w $E8EA, $E00, $F5EE ; DATA XREF: ROM:00034AF4   o
                                        ; ROM:00034B48   o
word_EB96C:     dc.w $E8F6, $D00, $F7EF ; DATA XREF: ROM:00034AF0   o
                                        ; ROM:00034B4C   o
word_EB972:     dc.w $E8FE, $E00, $F5EE ; DATA XREF: ROM:00034AEC   o
                                        ; ROM:00034B50   o
word_EB978:     dc.w $E90A, $A00, $F3F4 ; DATA XREF: ROM:00034AE8   o
                                        ; ROM:00034B54   o
word_EB97E:     dc.w $E913, $B00, $F1F2 ; DATA XREF: ROM:00034AE4   o
                                        ; ROM:00034B58   o
word_EB984:     dc.w $E91F, $700, $F0F8 ; DATA XREF: ROM:off_34AE0   o
                                        ; ROM:00034B5C   o
word_EB98A:     dc.w $793B, $300, $A5FC ; DATA XREF: Boss_ShellshogunSetupPhase+11A   o
                                        ; ROM:0003A0E2   o
                dc.w $7953, $300, $F1FC
                dc.w $693B, $300, $D5FC
                dc.w $F93B, $300, $B5FC
word_EB9A2:     dc.w $792B, $F00, $B6B7 ; DATA XREF: ROM:0003A0DE   o
                                        ; ROM:0003A0E6   o
                dc.w $792B, $F00, $C7C8
                dc.w $7943, $F00, $ECED
                dc.w $E12B, $F00, $DEDF
word_EB9BA:     dc.w $6927, $C00, $FCA3 ; DATA XREF: ROM:off_3A0DA   o
                dc.w $693F, $C00, $FCF1
                dc.w $6127, $C00, $FCD4
                dc.w $E927, $C00, $FCBB
                dc.w $2892, $500, $F0
                dc.w $A88A, $D00, 0
                dc.w $2898, $900, $F4E6
                dc.w $A896, $400, $FC06
word_EB9EA:     dc.w $A8C3, $500, $F6F9 ; DATA XREF: ROM:00036FDE   o
word_EB9F0:     dc.w $A8C7, $500, $F5FA ; DATA XREF: ROM:00036FDA   o
word_EB9F6:     dc.w $A8CB, $500, $F6F9 ; DATA XREF: ROM:00036FD6   o
word_EB9FC:     dc.w $A8CF, $500, $F6F9 ; DATA XREF: ROM:00036FD2   o
word_EBA02:     dc.w $A8D3, $500, $F7F9 ; DATA XREF: ROM:off_36FCE   o
word_EBA08:     dc.w $B0D7, $500, $F7F7 ; DATA XREF: ROM:00036FEA   o
word_EBA0E:     dc.w $B0DB, $500, $F7F7 ; DATA XREF: ROM:00036FE6   o
word_EBA14:     dc.w $B0DF, $500, $F7F7 ; DATA XREF: ROM:00036FE2   o
word_EBA1A:     dc.w $287E, $C00, $AEC  ; DATA XREF: ROM:00034CFE   o
                                        ; ROM:00034D12   o
                dc.w $287A, $300, $F20C
                dc.w $A86A, $F00, $EAEC
word_EBA2C:     dc.w $2829, $E00, $E4FE ; DATA XREF: ROM:00034CFA   o
                                        ; Boss_XiTigerIdleState+16   o ...
                dc.w $2844, $300, $ECF6
                dc.w $2838, $E00, $FCFE
                dc.w $2836, $100, $FC1E
                dc.w $A835, 0, $DCFE
word_EBA4A:     dc.w $2848, $E00, $FCFE ; DATA XREF: Boss_XiTigerJumpRise+A   o
                                        ; Boss_XiTigerAttackPattern1+C   o ...
                dc.w $2829, $E00, $E4FE
                dc.w $2844, $300, $ECF6
                dc.w $2836, $100, $FC1E
                dc.w $A835, 0, $DCFE
word_EBA68:     dc.w $30A0, $E00, $F3CE ; DATA XREF: Boss_XiTigerSetup+74   o
                                        ; Boss_XiTigerSetup+7C   o ...
                dc.w $B0AC, $F00, $F3EE
word_EBA74:     dc.w $30EE, 0, $FE4     ; DATA XREF: ROM:0003E170   o
                                        ; ROM:0003E188   o
                dc.w $30E5, $A00, $17DD
                dc.w $B0D5, $F00, $F7EC
word_EBA86:     dc.w $28D3, $400, $A12  ; DATA XREF: ROM:0003E178   o
                                        ; ROM:0003E180   o
                dc.w $28CB, $D00, $120B
                dc.w $28CA, 0, $2F4
                dc.w $28C4, $900, $3FC
                dc.w $A8BC, $D00, $F3F5
word_EBAA4:     dc.w $2894, $B00, $14F3 ; DATA XREF: ROM:0003E174   o
                                        ; ROM:0003E184   o
                dc.w $A884, $F00, $F4F3
word_EBAB0:     dc.w $A123, $F00, $EFF1 ; DATA XREF: ROM:off_34C64   o
                                        ; ROM:00034CC0   o
word_EBAB6:     dc.w $A117, $E00, $F3F2 ; DATA XREF: ROM:00034C68   o
                                        ; ROM:00034CBC   o
word_EBABC:     dc.w $A107, $F00, $F0F1 ; DATA XREF: ROM:00034C6C   o
                                        ; ROM:00034CB8   o
word_EBAC2:     dc.w $A0FB, $B00, $F2F4 ; DATA XREF: ROM:00034C70   o
                                        ; ROM:00034CB4   o
word_EBAC8:     dc.w $A933, $F00, $EFF0 ; DATA XREF: ROM:00034C74   o
                                        ; ROM:00034CB0   o
word_EBACE:     dc.w $A8FB, $B00, $F1F4 ; DATA XREF: ROM:00034C78   o
                                        ; ROM:00034CAC   o
word_EBAD4:     dc.w $A907, $F00, $EFF0 ; DATA XREF: ROM:00034C7C   o
                                        ; ROM:00034CA8   o
word_EBADA:     dc.w $A917, $E00, $F3EE ; DATA XREF: ROM:00034C80   o
                                        ; ROM:off_34CA4   o
word_EBAE0:     dc.w $20EF, $B00, $F0E8 ; DATA XREF: ROM:00034D26   o
                dc.w $A8EF, $B00, $F000
word_EBAEC:     dc.w $A167, $B00, $EDED ; DATA XREF: ROM:off_34C84   o
                                        ; ROM:00034CE0   o
word_EBAF2:     dc.w $A15B, $B00, $EEEC ; DATA XREF: ROM:00034C88   o
                                        ; ROM:00034CDC   o
word_EBAF8:     dc.w $A14F, $E00, $F7E8 ; DATA XREF: ROM:00034C8C   o
                                        ; ROM:00034CD8   o
word_EBAFE:     dc.w $A143, $E00, $F8E9 ; DATA XREF: ROM:00034C90   o
                                        ; ROM:00034CD4   o
word_EBB04:     dc.w $A197, $E00, $FAEC ; DATA XREF: ROM:00034C94   o
                                        ; ROM:00034CD0   o
word_EBB0A:     dc.w $B98B, $E00, $FBEE ; DATA XREF: ROM:00034C98   o
                                        ; ROM:00034CCC   o
word_EBB10:     dc.w $B97F, $B00, $F8F7 ; DATA XREF: ROM:00034C9C   o
                                        ; ROM:00034CC8   o
word_EBB16:     dc.w $B973, $B00, $F7F7 ; DATA XREF: ROM:00034CA0   o
                                        ; ROM:off_34CC4   o
word_EBB1C:     dc.w $28A0, $E00, $F613 ; DATA XREF: ROM:0003E17C   o
                dc.w $A8AC, $F00, $EEF3
word_EBB28:     dc.w $603C, $500, $105  ; DATA XREF: ROM:00034DCA   o
                                        ; ROM:00034DDE   o
                dc.w $E034, $700, $EEF5
word_EBB34:     dc.w $7846, $500, $ECFB ; DATA XREF: ROM:00034DC2   o
                                        ; ROM:00034DE6   o
                dc.w $F840, $600, $FCF6
word_EBB40:     dc.w $7852, $400, $ECF8 ; DATA XREF: ROM:00034DC6   o
                                        ; ROM:00034DE2   o
                dc.w $F84A, $700, $F4F8
word_EBB4C:     dc.w $605D, $500, $FE05 ; DATA XREF: ROM:00034DCE   o
                                        ; ROM:00034DDA   o
                dc.w $E054, $A00, $F1ED
word_EBB58:     dc.w $786A, $900, $EBF8 ; DATA XREF: ROM:00034DBE   o
                                        ; ROM:00034DEA   o
                dc.w $F861, $A00, $FBF3
word_EBB64:     dc.w $6074, $900, $F9FE ; DATA XREF: ROM:00034DD2   o
                                        ; ROM:off_34DD6   o
                dc.w $E070, $500, $F3EE
word_EBB70:     dc.w $7882, $500, $3EE  ; DATA XREF: ROM:00034DBA   o
                                        ; ROM:00034DEE   o
                dc.w $F87A, $D00, $F3F1
word_EBB7C:     dc.w $788E, $100, $F7EB ; DATA XREF: ROM:off_34DB6   o
                                        ; ROM:00034DF2   o
                dc.w $F886, $D00, $F7F3
word_EBB88:     dc.w $E8C6, $400, $FBF8 ; DATA XREF: ROM:off_34DF6   o
                                        ; ROM:00034E32   o
word_EBB8E:     dc.w $E8C8, $400, $FCF8 ; DATA XREF: ROM:00034DFA   o
                                        ; ROM:00034E2E   o
word_EBB94:     dc.w $E8CA, $500, $FAFA ; DATA XREF: ROM:00034DFE   o
                                        ; ROM:00034E2A   o
word_EBB9A:     dc.w $E8CE, $100, $F9FD ; DATA XREF: ROM:00034E02   o
                                        ; ROM:00034E26   o
word_EBBA0:     dc.w $E8D0, $100, $F8FD ; DATA XREF: ROM:00034E06   o
                                        ; ROM:00034E22   o
word_EBBA6:     dc.w $F0AB, $100, $F8FC ; DATA XREF: ROM:00034E0A   o
                                        ; ROM:00034E1E   o
word_EBBAC:     dc.w $F0AD, $500, $F6FB ; DATA XREF: ROM:00034E0E   o
                                        ; ROM:00034E1A   o
word_EBBB2:     dc.w $F0B1, $400, $FBFA ; DATA XREF: ROM:00034E12   o
                                        ; ROM:off_34E16   o
word_EBBB8:     dc.w $2866, $D00, $2FA  ; DATA XREF: Boss_FlyingNeoSetup+64   o
                                        ; Boss_FlyingNeoHoverDecision+104   o ...
                dc.w $2864, $400, $EAFA
                dc.w $A85C, $D00, $F2FA
word_EBBCA:     dc.w $286E, $D00, $2FA  ; DATA XREF: Boss_FlyingNeoHoverDecision+92   o
                                        ; Boss_FlyingNeoAnimationUpdate+18   o
                dc.w $2864, $400, $EAFA
                dc.w $A85C, $D00, $F2FA
word_EBBDC:     dc.w $A0C5, $D00, $F8F0 ; DATA XREF: ROM:off_34F20   o
word_EBBE2:     dc.w $A0BD, $D00, $F8F1 ; DATA XREF: ROM:00034F24   o
word_EBBE8:     dc.w $A0B4, $A00, $F5F3 ; DATA XREF: ROM:00034F28   o
word_EBBEE:     dc.w $A0A8, $B00, $F2F6 ; DATA XREF: ROM:00034F2C   o
word_EBBF4:     dc.w $A0A0, $700, $F1F8 ; DATA XREF: ROM:00034F30   o
word_EBBFA:     dc.w $A8A8, $B00, $F2F2 ; DATA XREF: ROM:00034F34   o
word_EBC00:     dc.w $A8B4, $A00, $F4F5 ; DATA XREF: ROM:00034F38   o
word_EBC06:     dc.w $A8BD, $D00, $F8F0 ; DATA XREF: ROM:00034F3C   o
word_EBC0C:     dc.w $287E, $100, $FBF2 ; DATA XREF: Boss_FlyingNeoHoverDecision+10C   o
                                        ; sub_3C9C0   o
                dc.w $A876, $D00, $FBFA
word_EBC18:     dc.w $28D6, $200, $FBF3 ; DATA XREF: ROM:00034F56   o
                                        ; ROM:00034F66   o ...
                dc.w $A8CE, $700, $FBFB
word_EBC24:     dc.w $E856, $500, $F9F8 ; DATA XREF: ROM:off_34F8A   o
                                        ; ROM:00034FC6   o
word_EBC2A:     dc.w $E85A, $500, $F9F8 ; DATA XREF: ROM:00034F8E   o
                                        ; ROM:00034FC2   o
word_EBC30:     dc.w $E85E, $500, $F9F8 ; DATA XREF: ROM:00034F92   o
                                        ; ROM:00034FBE   o
word_EBC36:     dc.w $E862, $500, $F9F8 ; DATA XREF: ROM:00034F96   o
                                        ; ROM:00034FBA   o
word_EBC3C:     dc.w $F046, $500, $F8FA ; DATA XREF: ROM:00034F9A   o
                                        ; ROM:00034FB6   o
word_EBC42:     dc.w $F04A, $500, $F9FA ; DATA XREF: ROM:00034F9E   o
                                        ; ROM:00034FB2   o
word_EBC48:     dc.w $F04E, $500, $F9F9 ; DATA XREF: ROM:00034FA2   o
                                        ; ROM:00034FAE   o
word_EBC4E:     dc.w $F052, $500, $F9F9 ; DATA XREF: ROM:00034FA6   o
                                        ; ROM:off_34FAA   o
word_EBC54:     dc.w $E093, $D00, $F8EF ; DATA XREF: ROM:off_34FCA   o
                                        ; ROM:00035006   o
word_EBC5A:     dc.w $E08B, $D00, $F7ED ; DATA XREF: ROM:00034FCE   o
                                        ; ROM:00035002   o
word_EBC60:     dc.w $E082, $A00, $F3F5 ; DATA XREF: ROM:00034FD2   o
                                        ; ROM:00034FFE   o
word_EBC66:     dc.w $E07A, $700, $F2F9 ; DATA XREF: ROM:00034FD6   o
                                        ; ROM:00034FFA   o
word_EBC6C:     dc.w $E872, $700, $F0F8 ; DATA XREF: ROM:00034FDA   o
                                        ; ROM:00034FF6   o
word_EBC72:     dc.w $E87A, $700, $F2F8 ; DATA XREF: ROM:00034FDE   o
                                        ; ROM:00034FF2   o
word_EBC78:     dc.w $E882, $A00, $F3F4 ; DATA XREF: ROM:00034FE2   o
                                        ; ROM:00034FEE   o
word_EBC7E:     dc.w $E88B, $D00, $F7F3 ; DATA XREF: ROM:00034FE6   o
                                        ; ROM:off_34FEA   o
word_EBC84:     dc.w $E09B, $D00, $FCE8 ; DATA XREF: ROM:off_3500A   o
                                        ; ROM:00035046   o
word_EBC8A:     dc.w $60D8, 0, 5        ; DATA XREF: ROM:0003500E   o
                                        ; ROM:00035042   o
                dc.w $60D7, 0, $F8FD
                dc.w $E0D1, $900, $ED
word_EBC9C:     dc.w $60D0, 0, $FC04    ; DATA XREF: ROM:00035012   o
                                        ; ROM:0003503E   o
                dc.w $E0CA, $600, $FCF4
word_EBCA8:     dc.w $E0C2, $700, $F8FC ; DATA XREF: ROM:00035016   o
                                        ; ROM:0003503A   o
word_EBCAE:     dc.w $F8BA, $700, $F8FE ; DATA XREF: ROM:0003501A   o
                                        ; ROM:00035036   o
word_EBCB4:     dc.w $78B9, 0, $F301    ; DATA XREF: ROM:0003501E   o
                                        ; ROM:00035032   o
                dc.w $78B8, 0, $FBF9
                dc.w $F8B2, $600, $FB01
word_EBCC6:     dc.w $78B1, 0, $F4FE    ; DATA XREF: ROM:00035022   o
                                        ; ROM:0003502E   o
                dc.w $F8AB, $900, $FCFE
word_EBCD2:     dc.w $F8A3, $D00, $F4F8 ; DATA XREF: ROM:00035026   o
                                        ; ROM:off_3502A   o
word_EBCD8:     dc.w $814, $100, $D8FD  ; DATA XREF: ROM:0002F198   o
                dc.w $804, 0, $E820
                dc.w $822, $C00, $18F0
                dc.w $816, $B00, $F8F0
                dc.w $805, 0, $F008
                dc.w $80B, $A00, $E0F0
                dc.w $8800, $C00, $E008
word_EBD02:     dc.w $814, $100, $D8FC  ; DATA XREF: ROM:off_2F194   o
                dc.w $805, 0, $F008
                dc.w $822, $C00, $18F0
                dc.w $816, $B00, $F8F0
                dc.w $85F, 0, $F018
                dc.w $835, 0, $E008
                dc.w $85C, $800, $E808
                dc.w $880B, $A00, $E0F0
word_EBD32:     dc.w $814, $100, $D8FB  ; DATA XREF: Entity_TrainEndInit+22   o
                                        ; Entity_TrainJumpPrep+A   o ...
                dc.w $822, $C00, $18F0
                dc.w $816, $B00, $F8F0
                dc.w $806, $100, $F010
                dc.w $808, $200, $E008
                dc.w $880B, $A00, $E0F0
                dc.w $8814, $100, $FAFC
word_EBD5C:     dc.w $86C, $100, $100C  ; DATA XREF: Entity_TransitionAnimationState+A   o
                                        ; Entity_XiTigerIntroState2+24   o
                dc.w $860, $B00, $F4
                dc.w $833, $100, $F0E4
                dc.w $826, 0, $E0FC
                dc.w $8827, $E00, $E8EC
word_EBD7A:     dc.w $858, $500, $10EE  ; DATA XREF: Entity_TrainJumpWait+6   o
                                        ; Entity_XiTigerIntroStartState+1E   o
                dc.w $856, $400, $1006
                dc.w $850, $900, $E6
                dc.w $848, $D00, $FE
                dc.w $842, $600, $E8E6
                dc.w $8836, $E00, $E8F6
word_EBD9E:     dc.w $A841, $D00, $F8F0 ; DATA XREF: ROM:00041554   o
word_EBDA4:     dc.w $B86D, $E00, $F3F1 ; DATA XREF: ROM:00041558   o
word_EBDAA:     dc.w $B851, $F00, $EFF0 ; DATA XREF: ROM:0004155C   o
word_EBDB0:     dc.w $B861, $B00, $EFF5 ; DATA XREF: ROM:00041560   o
word_EBDB6:     dc.w $B849, $700, $EFF8 ; DATA XREF: ROM:00041564   o
word_EBDBC:     dc.w $B061, $B00, $EFF4 ; DATA XREF: ROM:00041548   o
word_EBDC2:     dc.w $B051, $F00, $EFF1 ; DATA XREF: ROM:0004154C   o
word_EBDC8:     dc.w $B06D, $E00, $F2EF ; DATA XREF: ROM:00041550   o
word_EBDCE:     dc.w $8040, $F00, $EDED ; DATA XREF: ROM:0003EFBA   o
word_EBDD4:     dc.w $9860, $F00, $F0EF ; DATA XREF: ROM:0003EFB6   o
word_EBDDA:     dc.w $187C, $200, $F309 ; DATA XREF: ROM:0003EFB2   o
                dc.w $9870, $B00, $F3F1
word_EBDE6:     dc.w $9850, $F00, $F2F2 ; DATA XREF: ROM:off_3EFAE   o
                dc.w $8900, $A00, $F2F4
                dc.w $8909, $700, $F1FA
                dc.w $90EF, $A00, $F4F3
                dc.w $90F8, $D00, $F7F1
word_EBE04:     dc.w $8000, $F00, $EDF1 ; DATA XREF: ROM:0003EFCA   o
word_EBE0A:     dc.w $9830, $F00, $EEF2 ; DATA XREF: ROM:0003EFC6   o
word_EBE10:     dc.w $9820, $F00, $EFEF ; DATA XREF: ROM:0003EFC2   o
word_EBE16:     dc.w $9810, $F00, $EFF0 ; DATA XREF: ROM:off_3EFBE   o
                dc.w $8C2, 0, $FFE5
                dc.w $88BA, $D00, $F7ED
                dc.w $8CB, $200, $2F0
                dc.w $88C3, $700, $F2F8
                dc.w $8D6, 0, $1401
                dc.w $88CE, $700, $F4F9
                dc.w $10B8, $400, $80A
                dc.w $90B0, $D00, $F8F3
word_EBE4C:     dc.w $988B, $900, $F7F3 ; DATA XREF: ROM:0003EFDA   o
                                        ; ROM:off_3EFDE   o
word_EBE52:     dc.w $987F, $600, $F6F9 ; DATA XREF: ROM:0003EFD6   o
                                        ; ROM:0003EFE2   o
word_EBE58:     dc.w $8085, $600, $F7F9 ; DATA XREF: ROM:0003EFD2   o
                                        ; ROM:0003EFE6   o
word_EBE5E:     dc.w $8091, $900, $F8F8 ; DATA XREF: ROM:off_3EFCE   o
                                        ; ROM:0003EFEA   o
                dc.w $88D7, $900, $F9F2
                dc.w $88DD, $600, $F6FC
                dc.w $88E3, $600, $F7FB
                dc.w $88E9, $900, $F4F8
word_EBE7C:     dc.w $18A8, $D00, $F0   ; DATA XREF: ROM:off_3F000   o
                                        ; ROM:0003F010   o
                dc.w $88A8, $D00, $F0F0
word_EBE88:     dc.w $5849, $D00, $F0   ; DATA XREF: ROM:000425AA   o
                dc.w $C849, $D00, $F0F0
word_EBE94:     dc.w $4038, $700, $F0F0 ; DATA XREF: Boss_JetsripperSpawnCircleShots+66   o
                                        ; Boss_JetsripperRetractCircle+A6   o ...
                dc.w $C838, $700, $F000
word_EBEA0:     dc.w $C840, $A00, $F3F3 ; DATA XREF: Boss_JetsripperReverseCircle+62   o
                                        ; Boss_SunsetStingUpdateMovement+108   o
word_EBEA6:     dc.w $1810, $400, $ECF8 ; DATA XREF: ROM:0004330A   o
                dc.w $9800, $F00, $F4F0
word_EBEB2:     dc.w $1022, $400, $EDF6 ; DATA XREF: ROM:0004330E   o
                dc.w $9012, $F00, $F5EF
word_EBEBE:     dc.w $9024, $F00, $F2F1 ; DATA XREF: ROM:00043312   o
word_EBEC4:     dc.w $1044, $100, $F7EB ; DATA XREF: ROM:00043316   o
                dc.w $9034, $F00, $F0F3
word_EBED0:     dc.w $84E, $100, $F70D  ; DATA XREF: ROM:off_432FA   o
                dc.w $1846, $D00, $FFED
                dc.w $8846, $D00, $EFED
word_EBEE2:     dc.w $1844, $100, $F60D ; DATA XREF: ROM:000432FE   o
                dc.w $9834, $F00, $EFED
word_EBEEE:     dc.w $9824, $F00, $F1EF ; DATA XREF: ROM:00043302   o
word_EBEF4:     dc.w $1822, $400, $ECFA ; DATA XREF: ROM:00043306   o
                dc.w $9812, $F00, $F4F1
word_EBF00:     dc.w $8865, $800, $FCF4 ; DATA XREF: ROM:off_4331A   o
word_EBF06:     dc.w $985F, $900, $F4F3 ; DATA XREF: ROM:0004331E   o
word_EBF0C:     dc.w $1859, $100, $FEF8 ; DATA XREF: ROM:00043322   o
                dc.w $985B, $500, $F600
word_EBF18:     dc.w $9853, $600, $F4FB ; DATA XREF: ROM:00043326   o
word_EBF1E:     dc.w $9850, $200, $F4FC ; DATA XREF: ROM:0004332A   o
word_EBF24:     dc.w $9053, $600, $F4F5 ; DATA XREF: ROM:0004332E   o
word_EBF2A:     dc.w $1059, $100, $FF01 ; DATA XREF: ROM:00043332   o
                dc.w $905B, $500, $F7F1
word_EBF36:     dc.w $905F, $900, $F5F6 ; DATA XREF: ROM:00043336   o
                dc.w $986E, $400, $FBF6
                dc.w $986C, $400, $FCF6
                dc.w $986A, $400, $FCF4
                dc.w $9868, $100, $F9FB
                dc.w $8070, $100, $F9FC
                dc.w $9068, $100, $F9FC
                dc.w $906A, $400, $FCFB
                dc.w $906C, $400, $FCFA
word_EBF6C:     dc.w $BB, $D00, $FFE0   ; DATA XREF: ROM:off_43892   o
                dc.w $88BB, $D00, $FF00
word_EBF78:     dc.w $C3, $D00, $FFE0   ; DATA XREF: ROM:00043896   o
                dc.w $88C3, $D00, $FF00
word_EBF84:     dc.w $CB, $D00, $FFE0   ; DATA XREF: ROM:0004389A   o
                                        ; Boss_SunsetStingDefeatEnd+6   o
                dc.w $88CB, $D00, $FF00
word_EBF90:     dc.w $8D3, $A00, $F6F4  ; DATA XREF: ROM:off_EBFC0   o
                dc.w $88DF, $800, $8F4
word_EBF9C:     dc.w $8D3, $A00, $F8F4  ; DATA XREF: ROM:000EBFC4   o
                                        ; ROM:off_EBFCC   o
                dc.w $88DC, $800, $8F4
word_EBFA8:     dc.w $8D3, $A00, $F7F4  ; DATA XREF: ROM:000EBFD0   o
                                        ; ROM:000EBFD8   o
                dc.w $88DC, $800, $8F4
word_EBFB4:     dc.w $8D3, $A00, $F6F4  ; DATA XREF: ROM:000EBFD4   o
                dc.w $88DC, $800, $8F4
off_EBFC0:      dc.w word_EBF90-*       ; DATA XREF: ROM:0004393C   o
                                        ; ROM:000EBFC8   o
                dc.w 5
                dc.w word_EBF9C-*
                dc.w 5
                dc.w off_EBFC0-*
                dc.w 0
off_EBFCC:      dc.w word_EBF9C-*       ; DATA XREF: ROM:00043940   o
                                        ; Projectile_SpawnViblackMissile+1A   o ...
                dc.w 8
                dc.w word_EBFA8-*
                dc.w 3
                dc.w word_EBFB4-*
                dc.w 8
                dc.w word_EBFA8-*
                dc.w 3
                dc.w off_EBFCC-*
                dc.w 0
word_EBFE0:     dc.w $6828, $500, $11F8 ; DATA XREF: ROM:off_3F198   o
                dc.w $6800, $D00, $E2F0
                dc.w $681C, $B00, $F2E8
                dc.w $E810, $B00, $F200
word_EBFF8:     dc.w $6808, $D00, $E2F0 ; DATA XREF: ROM:0003F19C   o
                                        ; Boss_GustheadSetupParts+78   o
                dc.w $6828, $500, $11F8
                dc.w $681C, $B00, $F2E8
                dc.w $E810, $B00, $F200
word_EC010:     dc.w $E82C, $F00, $F0F0 ; DATA XREF: ROM:off_4054A   o
                                        ; ROM:0004054E   o ...
word_EC016:     dc.w $E83C, $F00, $F1EF ; DATA XREF: ROM:00040556   o
                                        ; ROM:0004055A   o
word_EC01C:     dc.w $E84C, $F00, $F2EE ; DATA XREF: ROM:0004055E   o
                                        ; ROM:00040562   o
word_EC022:     dc.w $E85C, $F00, $F3EE ; DATA XREF: Boss_GustheadSetupParts+A2   o
                                        ; ROM:00040566   o ...
word_EC028:     dc.w $E86C, $A00, $F4F5 ; DATA XREF: ROM:0004056E   o
                                        ; ROM:00040572   o
word_EC02E:     dc.w $E875, $A00, $F5F4 ; DATA XREF: ROM:00040576   o
                                        ; ROM:0004057A   o
word_EC034:     dc.w $E87E, $A00, $F6F3 ; DATA XREF: ROM:0004057E   o
                                        ; ROM:00040582   o ...
                dc.w $2808, $700, $F8
                dc.w $A800, $700, $E0F8
word_EC046:     dc.w $2018, $B00, $EFE8 ; DATA XREF: Boss_Epsilon1BattleSetup+AE   o
                                        ; Boss_Epsilon1RotationEnd+6   o ...
                dc.w $2818, $B00, $EF00
                dc.w $2024, $100, $DFF0
                dc.w $A824, $100, $DF08
word_EC05E:     dc.w $2026, $B00, $F0E8 ; DATA XREF: Boss_Epsilon1StartRotation:loc_46BAA   o
                                        ; sub_46B8A:loc_46BD2   o
                dc.w $2826, $B00, $F000
                dc.w $2024, $100, $E0F0
                dc.w $2824, $100, $E008
                dc.w $2032, 0, $10F8
                dc.w $A832, 0, $1000
word_EC082:     dc.w $2843, $100, $2F4  ; DATA XREF: Boss_Epsilon1BattleSetup+11E   o
                                        ; Boss_Epsilon1BattleSetup+16C   o
                dc.w $A833, $F00, $F2FC
word_EC08E:     dc.w $2008, $A00, $1E8  ; DATA XREF: ROM:00048912   o
                dc.w $2808, $A00, $100
                dc.w $2000, $700, $E1F0
                dc.w $A800, $700, $E100
word_EC0A6:     dc.w $201D, $900, $8E8  ; DATA XREF: ROM:0004890E   o
                dc.w $281D, $900, $800
                dc.w $2011, $B00, $E8E8
                dc.w $A811, $B00, $E800
word_EC0BE:     dc.w $2023, $B00, $ECEC ; DATA XREF: ROM:off_4890A   o
                dc.w $202F, $800, $CEC
                dc.w $282F, $800, $CFC
                dc.w $A823, $B00, $ECFC
word_EC0D6:     dc.w $2032, $700, $F0F0 ; DATA XREF: ROM:00048916   o
                dc.w $A832, $700, $F000
word_EC0E2:     dc.w $203A, $600, $F4F4 ; DATA XREF: ROM:0004891A   o
                dc.w $A83A, $600, $F4FC
word_EC0EE:     dc.w $204E, $100, $18F5 ; DATA XREF: ROM:0004891E   o
                dc.w $204C, $400, $10ED
                dc.w $284E, $100, $1805
                dc.w $284C, $400, $1005
                dc.w $2040, $B00, $F0ED
                dc.w $A840, $B00, $F0FD
word_EC112:     dc.w $3850, $D00, $E3   ; DATA XREF: ROM:00035228   o
                                        ; ROM:0004892A   o
                dc.w $3858, $A00, 3
                dc.w $2858, $A00, $E803
                dc.w $A850, $D00, $F0E3
word_EC12A:     dc.w $386D, $600, $E8   ; DATA XREF: ROM:00035224   o
                                        ; ROM:00048926   o
                dc.w $3861, $E00, $F8
                dc.w $286D, $600, $E8E8
                dc.w $A861, $E00, $E8F8
word_EC142:     dc.w $387F, $200, $FCEC ; DATA XREF: ROM:off_35220   o
                                        ; ROM:off_48922   o
                dc.w $287F, $200, $ECEC
                dc.w $3873, $E00, $FCF4
                dc.w $A873, $E00, $ECF4
word_EC15A:     dc.w $3882, $D00, $F0   ; DATA XREF: ROM:0003522C   o
                                        ; ROM:0004892E   o
                dc.w $A882, $D00, $F0F0
word_EC166:     dc.w $388A, $900, $FCF4 ; DATA XREF: ROM:00035230   o
                                        ; ROM:00048932   o
                dc.w $A88A, $900, $F4F4
word_EC172:     dc.w $38B6, $400, $418  ; DATA XREF: ROM:00035234   o
                                        ; ROM:00048936   o
                dc.w $28B6, $400, $F418
                dc.w $38B4, $100, $410
                dc.w $28B4, $100, $EC10
                dc.w $38A8, $E00, $FCF0
                dc.w $A8A8, $E00, $ECF0
word_EC196:     dc.w $38B8, $D00, $F4   ; DATA XREF: ROM:00035244   o
                                        ; ROM:00035254   o ...
                dc.w $38C0, $C00, $D4
                dc.w $38C4, $800, $BC
                dc.w $28C4, $800, $F8BC
                dc.w $28C0, $C00, $F8D4
                dc.w $A8B8, $D00, $F0F4
word_EC1BA:     dc.w $30D3, $200, $2EF8 ; DATA XREF: ROM:0004884E   o
                dc.w $38D3, $200, $2E00
                dc.w $30CF, $300, $EF8
                dc.w $38CF, $300, $E00
                dc.w $30C7, $700, $EEF0
                dc.w $B8C7, $700, $EE00
word_EC1DE:     dc.w $30F1, $D00, $EAEA ; DATA XREF: ROM:00048852   o
                dc.w $30F0, 0, $A12
                dc.w $30E4, $E00, $FAF2
                dc.w $30DC, $D00, $120A
                dc.w $B0D6, $900, $221A
                dc.w $A910, $400, $FCF8
                dc.w $B90E, $400, $FCF8
                dc.w $B90A, $500, $F8F8
                dc.w $A108, $100, $F8FC
                dc.w $A906, $100, $F8FC
word_EC21A:     dc.w $38F1, $D00, $EAF6 ; DATA XREF: ROM:0004884A   o
                dc.w $38F0, 0, $AE6
                dc.w $38E4, $E00, $FAEE
                dc.w $38DC, $D00, $12D6
                dc.w $B8D6, $900, $22CE
word_EC238:     dc.w 0, $100, $F8F8     ; DATA XREF: Boss_JampanMoveState+1D2   o
                                        ; ROM:off_494FE   o ...
                dc.w $8800, $100, $F800
word_EC244:     dc.w 2, $100, $F8F8     ; DATA XREF: Boss_JampanMoveState+D6   o
                                        ; Boss_JampanMoveState+126   o
                dc.w $8802, $100, $F800
word_EC250:     dc.w 4, $700, $F0F0     ; DATA XREF: ROM:00049502   o
                                        ; ROM:00049506   o
                dc.w $8804, $700, $F000
word_EC25C:     dc.w $D, $700, $F0F0    ; DATA XREF: Boss_JampanMoveState+AE   o
                                        ; Boss_JampanMoveState+FE   o ...
                dc.w $880D, $700, $F000
word_EC268:     dc.w $15, $700, $F0F0   ; DATA XREF: ROM:off_4A4F4   o
                                        ; ROM:0004A504   o
                dc.w $8815, $700, $F000
word_EC274:     dc.w $1D, $700, $F0F0   ; DATA XREF: ROM:0004A4F8   o
                                        ; ROM:0004A500   o
                dc.w $881D, $700, $F000
word_EC280:     dc.w $25, $700, $F0F0   ; DATA XREF: ROM:0004A4FC   o
                dc.w $8825, $700, $F000
word_EC28C:     dc.w $880C, 0, $FCFC    ; DATA XREF: ROM:0004950A   o
                                        ; ROM:0004950E   o ...
word_EC292:     dc.w $7F, $600, $F420   ; DATA XREF: Boss_DestroyerMK2ComponentSpawnProjectile+3A   o
                dc.w $873, $E00, $F400
                dc.w $87F, $600, $F4D0
                dc.w $8873, $E00, $F4E0
word_EC2AA:     dc.w $855, $800, $CEF   ; DATA XREF: Boss_DestroyerMK2Dispatcher+160   o
                                        ; Boss_DestroyerMK2ComponentSwitchAnimation+6   o
                dc.w $8845, $F00, $ECEF
word_EC2B6:     dc.w $86B, $D00, $CEF   ; DATA XREF: Boss_DestroyerMK2ComponentInitProjectile+8   o
                dc.w $868, $800, $E4EF
                dc.w $8858, $F00, $ECEF
word_EC2C8:     dc.w $8885, $300, $EFFC ; DATA XREF: ROM:off_4BD6C   o
                                        ; ROM:0004BD7C   o
word_EC2CE:     dc.w $8889, $B00, $EFF3 ; DATA XREF: ROM:0004BD70   o
                                        ; ROM:0004BD78   o
word_EC2D4:     dc.w $8895, $F00, $EFF0 ; DATA XREF: Boss_DestroyerMK2Dispatcher+1C0   o
                                        ; Boss_DestroyerMK2SpawnThreeProjectiles+48   o ...
word_EC2DA:     dc.w $88A5, $B00, $EFF5 ; DATA XREF: ROM:0004BD80   o
                                        ; ROM:0004BD88   o
word_EC2E0:     dc.w $88B1, $F00, $EFF0 ; DATA XREF: ROM:0004BD84   o
word_EC2E6:     dc.w $7836, $E00, $F8   ; DATA XREF: ROM:00045022   o
                dc.w $7842, $600, $E8
                dc.w $6842, $600, $E8E8
                dc.w $E836, $E00, $E8F8
word_EC2FE:     dc.w $6868, $500, $8E8  ; DATA XREF: ROM:00045026   o
                dc.w $6860, $D00, $8F8
                dc.w $6858, $700, $E8E8
                dc.w $E848, $F00, $E8F8
word_EC316:     dc.w $700C, $900, $E8E8 ; DATA XREF: ROM:0004502A   o
                dc.w $7000, $B00, $F8E8
                dc.w $780C, $900, $E800
                dc.w $F800, $B00, $F800
word_EC32E:     dc.w $7032, $500, $E808 ; DATA XREF: ROM:0004502E   o
                dc.w $702A, $D00, $E8E8
                dc.w $7022, $700, $F808
                dc.w $F012, $F00, $F8E8
word_EC346:     dc.w $7887, $D00, $F0   ; DATA XREF: ROM:off_45012   o
                dc.w $E887, $D00, $F0F0
word_EC352:     dc.w $689E, $500, $FEF2 ; DATA XREF: ROM:00045016   o
                dc.w $6898, $600, $E6F2
                dc.w $688F, 0, $FE12
                dc.w $E890, $700, $EE02
word_EC36A:     dc.w $706C, $700, $F0F0 ; DATA XREF: ROM:0004501A   o
                dc.w $F86C, $700, $F000
word_EC376:     dc.w $7086, 0, $E6FE    ; DATA XREF: ROM:0004501E   o
                dc.w $707E, $D00, $EEEE
                dc.w $707A, $500, $FEFE
                dc.w $F074, $900, $FEE6
word_EC38E:     dc.w $E8A2, $800, $FCF4 ; DATA XREF: ROM:off_350E6   o
                                        ; ROM:00035122   o
word_EC394:     dc.w $E8A5, $900, $F8F4 ; DATA XREF: ROM:000350EA   o
                                        ; ROM:0003511E   o
word_EC39A:     dc.w $68AF, $400, $2F4  ; DATA XREF: ROM:000350EE   o
                                        ; ROM:0003511A   o
                dc.w $E8AB, $500, $F2FC
word_EC3A6:     dc.w $E8B1, $600, $F5FA ; DATA XREF: ROM:000350F2   o
                                        ; ROM:00035116   o
word_EC3AC:     dc.w $E8B7, $200, $F5FC ; DATA XREF: ROM:000350F6   o
                                        ; ROM:00035112   o
word_EC3B2:     dc.w $E0B1, $600, $F5F8 ; DATA XREF: ROM:000350FA   o
                                        ; ROM:0003510E   o
word_EC3B8:     dc.w $60AF, $400, $3FE  ; DATA XREF: ROM:000350FE   o
                                        ; ROM:0003510A   o
                dc.w $E0AB, $500, $F3F6
word_EC3C4:     dc.w $E0A5, $900, $F8F5 ; DATA XREF: ROM:00035102   o
                                        ; ROM:off_35106   o
                dc.w $E0A2, $800, $FCF5
word_EC3D0:     dc.w $E8BA, $800, $FCF4 ; DATA XREF: ROM:off_35126   o
                                        ; ROM:00035162   o
word_EC3D6:     dc.w $E8BD, $900, $F8F3 ; DATA XREF: ROM:0003512A   o
                                        ; ROM:0003515E   o
word_EC3DC:     dc.w $E8C3, $A00, $F4F4 ; DATA XREF: ROM:0003512E   o
                                        ; ROM:0003515A   o
word_EC3E2:     dc.w $E8CC, $600, $F3F9 ; DATA XREF: ROM:00035132   o
                                        ; ROM:00035156   o
word_EC3E8:     dc.w $E8D2, $200, $F4FC ; DATA XREF: ROM:00035136   o
                                        ; ROM:00035152   o
word_EC3EE:     dc.w $E0CC, $600, $F3F7 ; DATA XREF: ROM:0003513A   o
                                        ; ROM:0003514E   o
word_EC3F4:     dc.w $E0C3, $A00, $F4F4 ; DATA XREF: ROM:0003513E   o
                                        ; ROM:0003514A   o
word_EC3FA:     dc.w $E0BD, $900, $F8F4 ; DATA XREF: ROM:00035142   o
                                        ; ROM:off_35146   o
                dc.w $E8BA, $800, $FCF4
word_EC406:     dc.w $E8D5, $A00, $F4F3 ; DATA XREF: Projectile_BackStringerSpawnDrops+46   o
                dc.w $E0D5, $A00, $F4F6
word_EC412:     dc.w $E8EF, $F00, $F0F0 ; DATA XREF: Projectile_SpawnAngled+12   o
                                        ; ROM:off_EC42A   o
word_EC418:     dc.w $E8FF, $A00, $F4F4 ; DATA XREF: ROM:000EC42E   o
word_EC41E:     dc.w $E908, $500, $F8F8 ; DATA XREF: ROM:000EC432   o
word_EC424:     dc.w $E90C, 0, $FCFC    ; DATA XREF: ROM:000EC436   o
                                        ; ROM:000EC43A   o
off_EC42A:      dc.w word_EC412-*       ; DATA XREF: Boss_Epsilon1DebrisPhysics+100   o
                dc.w 3
                dc.w word_EC418-*
                dc.w 3
                dc.w word_EC41E-*
                dc.w 2
                dc.w word_EC424-*
                dc.w 1
                dc.w word_EC424-*
                dc.w $FF
                dc.w $4858, 0, $5FE
                dc.w $4856, $400, $FDF6
                dc.w $C853, $800, $F5EE
                dc.w $4867, 0, $C00
                dc.w $485F, $700, $ECF0
                dc.w $C859, $600, $F400
                dc.w $4871, $400, $6F8
                dc.w $4870, 0, $FDE8
                dc.w $C868, $D00, $F6F0
                dc.w $4873, $400, $F0F3
                dc.w $487E, $400, $8F9
                dc.w $487D, 0, $F8E9
                dc.w $C875, $D00, $F8F1
                dc.w $C880, $500, $F8F8
                dc.w $C884, 0, $FCFC
                dc.w $C885, $500, $F8F8
                dc.w $C889, $D00, $F8ED
                dc.w $C891, $D00, $F8ED
                dc.w $C899, $A00, $F4F4
                dc.w $C8A2, $700, $F2F8
                dc.w $C8AA, $700, $F2F8
                dc.w $C0A2, $700, $F2F9
                dc.w $C099, $A00, $F4F5
                dc.w $C091, $D00, $F8F4
                dc.w $C8B2, $E00, $F5F0
                dc.w $C8BE, $E00, $F2F0
                dc.w $48D5, $400, $AF6
                dc.w $48D3, $100, $FAEE
                dc.w $C8CA, $A00, $F2F6
                dc.w $C8D7, $B00, $F0F6
                dc.w $C8E3, $B00, $F0F2
                dc.w $C0D7, $B00, $F0F3
                dc.w $40D5, $400, $AFB
                dc.w $40D3, $100, $FA0B
                dc.w $C0CA, $A00, $F2F3
                dc.w $C0BE, $E00, $F2F1
                dc.w $C8EF, $D00, $F7F0
                dc.w $48FF, $400, $7F2
                dc.w $C8F7, $D00, $F7F2
                dc.w $4909, 0, $CF7
                dc.w $4901, $100, $F407
                dc.w $C903, $600, $F4F7
                dc.w $C90A, $700, $F1F8
                dc.w $C912, $700, $F0F8
                dc.w $4922, $100, $FE07
                dc.w $C91A, $700, $EEF7
                dc.w $4929, $C00, $1F4
                dc.w $4926, $800, $F9F4
                dc.w $C924, $400, $F1F4
                dc.w $C92D, $D00, $F8F1
                dc.w $C935, $C00, $FCF0
                dc.w $493C, $400, $2F3
                dc.w $C939, $800, $FAF7
                dc.w $493E, 0, $F706
                dc.w $C93F, $600, $F7F6
                dc.w $4949, $100, $3FB
                dc.w $C945, $500, $F3FB
                dc.w $C94B, $300, $EFFC
                dc.w $494F, $200, $F0FA
                dc.w $C952, $100, $FC02
                dc.w $4958, $800, $1F7
                dc.w $C954, $500, $F1F7
                dc.w $495E, $C00, $FDF0
                dc.w $C95B, $800, $F5F0
                dc.w $6885, $500, $2000
                dc.w $687D, $700, 0
                dc.w $687B, $100, $F000
                dc.w $E875, $600, $D8F8
                dc.w $6892, $100, $20FC
                dc.w $688E, $300, $FC
                dc.w $688C, $100, $F0FC
                dc.w $E889, $200, $D8FC
                dc.w $6085, $500, $20F0
                dc.w $607D, $700, $F0
                dc.w $607B, $100, $F0F8
                dc.w $E075, $600, $D8F8
                dc.w $6885, $500, $10FE
                dc.w $687D, $700, $F0FE
                dc.w $E875, $600, $D8F8
                dc.w $6892, $100, $10FC
                dc.w $688E, $300, $F0FC
                dc.w $E889, $200, $D8FC
                dc.w $6085, $500, $10F2
                dc.w $607D, $700, $F0F2
                dc.w $E075, $600, $D8F8
                dc.w $689D, $F00, $F4F0
                dc.w $E894, $A00, $DCEE
                dc.w $68C5, $100, $F5EC
                dc.w $68B5, $F00, $F5F4
                dc.w $E8AD, $D00, $E5E5
                dc.w $68D7, $A00, $F8DE
                dc.w $E8C7, $F00, $F0F6
                dc.w $68F0, $A00, $8F3
                dc.w $E8E0, $F00, $E8F3
                dc.w $E8F9, $D00, $F8F0
                dc.w $6907, $500, $3FA
                dc.w $E901, $900, $F3FA
                dc.w $6913, $100, $FF09
                dc.w $E90B, $700, $EFF9
                dc.w $E915, $D00, $F8EE
                dc.w $E91D, $A00, $F7F3
                dc.w $E927, $A00, $F7F2
                dc.w $E930, $A00, $F7F2
                dc.w $E93A, $700, $F6F8
                dc.w $E130, $A00, $F7F8
                dc.w $E127, $A00, $F7F7
                dc.w $E11D, $A00, $F7F7
word_EC6C0:     dc.w $284D, $C00, $5F0  ; DATA XREF: ROM:off_353FC   o
                                        ; ROM:00035418   o ...
                dc.w $284B, $100, $F5F0
                dc.w $A843, $D00, $F5F8
word_EC6D2:     dc.w $285E, $400, $7FA  ; DATA XREF: ROM:00035400   o
                                        ; ROM:00035404   o ...
                dc.w $285A, $300, $F70A
                dc.w $A851, $A00, $EFF2
word_EC6E4:     dc.w $2862, $700, $F6FA ; DATA XREF: ROM:00035408   o
                                        ; ROM:0003540C   o ...
                dc.w $A860, $400, $EEFA
word_EC6F0:     dc.w $2870, $100, $FEF4 ; DATA XREF: Boss_ValkirieInit+D4   o
                dc.w $A86A, $600, $F6FC
word_EC6FC:     dc.w $A872, $500, $F8F8 ; DATA XREF: ROM:off_353BC   o
                                        ; ROM:off_354B0   o
word_EC702:     dc.w $A876, $500, $F8F8 ; DATA XREF: ROM:000353C0   o
                                        ; ROM:000354B4   o
word_EC708:     dc.w $A87A, $500, $F9F8 ; DATA XREF: ROM:000353C4   o
                                        ; ROM:000354B8   o
word_EC70E:     dc.w $A87E, $500, $F8F8 ; DATA XREF: ROM:000353C8   o
                                        ; ROM:000354BC   o
word_EC714:     dc.w $A882, $500, $F8F9 ; DATA XREF: ROM:000353CC   o
                                        ; ROM:000354C0   o
word_EC71A:     dc.w $A886, $500, $F8F9 ; DATA XREF: ROM:000353D0   o
                                        ; ROM:000354C4   o
word_EC720:     dc.w $A88A, $500, $F7F9 ; DATA XREF: ROM:000353D4   o
                                        ; ROM:000354C8   o
word_EC726:     dc.w $A88E, $500, $F7F8 ; DATA XREF: ROM:000353D8   o
                                        ; ROM:000354CC   o
word_EC72C:     dc.w $A892, $D00, $F7F0 ; DATA XREF: ROM:off_353DC   o
                                        ; ROM:off_354D0   o
word_EC732:     dc.w $A89A, $900, $F6F7 ; DATA XREF: ROM:000353E0   o
                                        ; ROM:000354D4   o
word_EC738:     dc.w $28A6, $100, $FBF5 ; DATA XREF: ROM:000353E4   o
                                        ; ROM:000354D8   o
                dc.w $A8A0, $600, $F3FD
word_EC744:     dc.w $A8A8, $600, $F1FA ; DATA XREF: ROM:000353E8   o
                                        ; ROM:000354DC   o
word_EC74A:     dc.w $A8AE, $700, $F0F8 ; DATA XREF: ROM:000353EC   o
                                        ; ROM:000354E0   o
word_EC750:     dc.w $A0A8, $600, $F1F7 ; DATA XREF: ROM:000353F0   o
                                        ; ROM:000354E4   o
word_EC756:     dc.w $20A6, $100, $FB04 ; DATA XREF: ROM:000353F4   o
                                        ; ROM:000354E8   o
                dc.w $A0A0, $600, $F3F4
word_EC762:     dc.w $A09A, $900, $F6F3 ; DATA XREF: ROM:000353F8   o
                                        ; ROM:000354EC   o
                dc.w $A8B6, $D00, $F8EF
                dc.w $A8BE, $D00, $F5F0
                dc.w $28CE, $400, $2F1
                dc.w $A8C6, $D00, $F2F1
                dc.w $28D6, $500, $1F5
                dc.w $A8D0, $900, $F1F6
                dc.w $A8DA, $700, $F1FB
word_EC792:     dc.w $A8E2, $700, $F0F7 ; DATA XREF: Boss_ValkirieInit+EE   o
                                        ; Boss_ValkirieInit+274   o
                dc.w $28EE, $900, $FFF4
                dc.w $A8EA, $500, $EFF4
                dc.w $28FA, $500, $FB02
                dc.w $A8F4, $600, $F2F2
word_EC7B0:     dc.w $290D, $500, $23EA ; DATA XREF: ROM:0003545C   o
                                        ; ROM:0003546C   o ...
                dc.w $2907, $900, $13EA
                dc.w $A8FE, $A00, $FBF1
word_EC7C2:     dc.w $A911, $900, $F8FB ; DATA XREF: Boss_ValkirieInit+68   o
                                        ; Boss_ValkirieInit+9C   o ...
word_EC7C8:     dc.w $A917, $900, $FBF8 ; DATA XREF: Boss_ValkirieInit+1D0   o
                                        ; Boss_ValkirieInit+20A   o
word_EC7CE:     dc.w $A91D, $500, $F8F2 ; DATA XREF: Boss_ValkirieInit+82   o
                                        ; Boss_ValkirieInit+B6   o
word_EC7D4:     dc.w $A921, $500, $F8F9 ; DATA XREF: ROM:off_3541C   o
                                        ; ROM:00035510   o
word_EC7DA:     dc.w $A925, $500, $F8F8 ; DATA XREF: ROM:00035430   o
                                        ; ROM:00035444   o ...
word_EC7E0:     dc.w $A929, $500, $F8F8 ; DATA XREF: ROM:00035458   o
                                        ; ROM:00035468   o ...
word_EC7E6:     dc.w $A8B6, $D00, $F3E4 ; DATA XREF: ROM:off_5139A   o
word_EC7EC:     dc.w $A8BE, $D00, $F4E2 ; DATA XREF: ROM:0005139E   o
word_EC7F2:     dc.w $28CE, $400, $7E4  ; DATA XREF: ROM:000513A2   o
                dc.w $A8C6, $D00, $F7E4
word_EC7FE:     dc.w $28D6, $500, $9EA  ; DATA XREF: ROM:000513A6   o
                dc.w $A8D0, $900, $F9EB
word_EC80A:     dc.w $A8DA, $700, $FBF4 ; DATA XREF: ROM:000513AA   o
word_EC810:     dc.w $A8E2, $700, $FCF5 ; DATA XREF: ROM:000513AE   o
word_EC816:     dc.w $28EE, $900, $AF7  ; DATA XREF: ROM:000513B2   o
                dc.w $A8EA, $500, $FAF7
word_EC822:     dc.w $28FA, $500, $509  ; DATA XREF: ROM:000513B6   o
                dc.w $A8F4, $600, $FBF9
word_EC82E:	binclude	"data/other/word_EC82E.bin"	; DATA XREF: ROM:00035424   o
word_EC82E_End:
word_ECB1C:     dc.w $E8F2, $500, $F8F8 ; DATA XREF: ROM:off_4DA1A   o
word_ECB22:     dc.w $E8F6, 0, $FCFC    ; DATA XREF: ROM:0004DA1E   o
word_ECB28:     dc.w $68FC, $600, $F0F0 ; DATA XREF: Boss_BugmaxJumpInit+62   o
                                        ; Boss_BugmaxToggleMouthSprite+E   o ...
                dc.w $68F8, $500, $F000
                dc.w $E8F7, 0, $F010
word_ECB3A:     dc.w $6902, $500, $F000 ; DATA XREF: Boss_BugmaxToggleMouthSprite:loc_4DB72   o
                dc.w $E8FC, $600, $F0F0
word_ECB46:     dc.w $E907, 0, $FCFC    ; DATA XREF: ROM:off_4CB2E   o
                                        ; ROM:0004CB32   o ...
word_ECB4C:     dc.w $E906, 0, $FCFC    ; DATA XREF: ROM:0004CB3A   o
                                        ; ROM:0004CB3E   o ...
word_ECB52:     dc.w $E908, $F00, $F0F0 ; DATA XREF: Boss_BugmaxJumpInit+22   o
word_ECB58:     dc.w $E918, $A00, $F4F4 ; DATA XREF: ROM:stru_4CB06   o
word_ECB5E:     dc.w $E921, $500, $F8F8 ; DATA XREF: ROM:0004CB0E   o
                                        ; ROM:0004CB16   o
word_ECB64:     dc.w $E925, $500, $F8F8 ; DATA XREF: ROM:0004CB1E   o
                                        ; ROM:0004CB26   o
word_ECB6A:     dc.w $78FC, $600, $F2F4 ; DATA XREF: Boss_BugmaxUpdateLegSprite+4E   o
                dc.w $78F8, $500, $FA04
                dc.w $F8F7, 0, $214
word_ECB7C:     dc.w $692F, $500, $F8   ; DATA XREF: Boss_BugmaxUpdateLegSprite+2E   o
                dc.w $E929, $900, $F0F8
word_ECB88:     dc.w $6939, 0, $FCF3    ; DATA XREF: Boss_BugmaxInit+88   o
                                        ; Boss_BugmaxUpdateLegSprite+3E   o
                dc.w $E933, $600, $F4FB
word_ECB94:     dc.w $E93A, $F00, $F0F0 ; DATA XREF: Boss_BugmaxInit+3E   o
word_ECB9A:     dc.w $E94A, $A00, $F4F4 ; DATA XREF: ROM:stru_4C5BE   o
word_ECBA0:     dc.w $E953, $500, $F8F8 ; DATA XREF: ROM:0004C5C6   o
                                        ; ROM:0004C5CE   o
word_ECBA6:     dc.w $E957, $500, $F8F8 ; DATA XREF: ROM:0004C5D6   o
                                        ; ROM:0004C5DE   o
word_ECBAC:     dc.w $E95B, $A00, $F4F4 ; DATA XREF: ROM:off_ECBD0   o
word_ECBB2:     dc.w $E976, $500, $F8F8 ; DATA XREF: ROM:000ECBD4   o
word_ECBB8:     dc.w $E964, $A00, $F4F4 ; DATA XREF: ROM:off_ECBDC   o
word_ECBBE:     dc.w $E96D, $A00, $F4F4 ; DATA XREF: ROM:000ECBE0   o
word_ECBC4:     dc.w $F164, $A00, $F4F4 ; DATA XREF: ROM:000ECBE4   o
word_ECBCA:     dc.w $F16D, $A00, $F4F4 ; DATA XREF: ROM:000ECBE8   o
off_ECBD0:      dc.w word_ECBAC-*       ; DATA XREF: Projectile_InitBugmaxSpread+A   o
                                        ; ROM:000ECBD8   o
                dc.w 2
                dc.w word_ECBB2-*
                dc.w 2
                dc.w off_ECBD0-*
                dc.w 0
off_ECBDC:      dc.w word_ECBB8-*       ; DATA XREF: Projectile_InitBugmaxSine+A   o
                                        ; ROM:000ECBEC   o
                dc.w 6
                dc.w word_ECBBE-*
                dc.w 6
                dc.w word_ECBC4-*
                dc.w 6
                dc.w word_ECBCA-*
                dc.w 6
                dc.w off_ECBDC-*
                dc.w 0
                dc.w $6909, $D00, $F8
                dc.w $6889, $D00, $F0F8
                dc.w $E891, $200, $F0F0
                dc.w $6894, $D00, $F8
                dc.w $6891, $200, $F0F0
                dc.w $E889, $D00, $F0F8
                dc.w $E89C, $E00, $F0F0
                dc.w $E8A8, $A00, $F4F3
                dc.w $E8B1, $600, $F4F8
                dc.w $E8B7, $A00, $F3F4
                dc.w $68D6, $C00, $2F6
                dc.w $E8D0, $900, $F2F6
                dc.w $68D6, $C00, $2F3
                dc.w $E8C8, $D00, $F2F3
                dc.w $68C0, $D00, $F2F1
                dc.w $E8D6, $C00, $2F1
                dc.w $68DA, $900, $2F3
                dc.w $E8C8, $D00, $F2F3
                dc.w $E8E0, $700, $F1F8
                dc.w $E8E8, $600, $F4F6
                dc.w $E8EE, $A00, $F4F4
                dc.w $E8F7, $A00, $F4F4
                dc.w $E900, $500, $F8F8
                dc.w $E904, $500, $F8F8
                dc.w $E908, 0, $FCFC
word_ECC86:     dc.w $4E, 0, $FAE7      ; DATA XREF: ROM:off_59D42   o
                                        ; ROM:00059D7E   o
                dc.w $8042, $E00, $F2EF
word_ECC92:     dc.w $8036, $E00, $F2EF ; DATA XREF: ROM:00059D46   o
                                        ; ROM:00059D7A   o
word_ECC98:     dc.w $35, 0, $BEF       ; DATA XREF: ROM:00059D4A   o
                                        ; ROM:00059D76   o
                dc.w $8029, $E00, $F3EF
word_ECCA4:     dc.w $801D, $B00, $F2F6 ; DATA XREF: ROM:00059D4E   o
                                        ; ROM:00059D72   o
word_ECCAA:     dc.w $1C, 0, $11FC      ; DATA XREF: ROM:00059D52   o
                                        ; ROM:00059D6E   o
                dc.w $8010, $B00, $F1F4
word_ECCB6:     dc.w $9868, $B00, $F1F4 ; DATA XREF: ROM:00059D56   o
                                        ; ROM:00059D6A   o
word_ECCBC:     dc.w $1867, 0, $90D     ; DATA XREF: ROM:00059D5A   o
                                        ; ROM:00059D66   o
                dc.w $985B, $B00, $F1F5
word_ECCC8:     dc.w $984F, $E00, $F3F3 ; DATA XREF: ROM:00059D5E   o
                                        ; ROM:off_59D62   o
                dc.w $184E, 0, $FD12
                dc.w $9842, $E00, $F5F2
word_ECCDA:     dc.w $8074, $A00, $F3F5 ; DATA XREF: ROM:00059D82   o
                                        ; ROM:00059DBE   o
word_ECCE0:     dc.w $98B5, $A00, $F2F4 ; DATA XREF: ROM:00059D86   o
                                        ; ROM:00059DBA   o
word_ECCE6:     dc.w $18B4, 0, $EBFC    ; DATA XREF: ROM:00059D8A   o
                                        ; ROM:00059DB6   o
                dc.w $98AB, $A00, $F3F4
word_ECCF2:     dc.w $98A2, $A00, $F3F4 ; DATA XREF: ROM:00059D8E   o
                                        ; ROM:00059DB2   o
word_ECCF8:     dc.w $9899, $A00, $F2F4 ; DATA XREF: ROM:00059D92   o
                                        ; ROM:00059DAE   o
word_ECCFE:     dc.w $9890, $A00, $F3F3 ; DATA XREF: ROM:00059D96   o
                                        ; ROM:00059DAA   o
word_ECD04:     dc.w $188F, 0, $FCEC    ; DATA XREF: ROM:00059D9A   o
                                        ; ROM:00059DA6   o
                dc.w $9886, $A00, $F4F4
word_ECD10:     dc.w $987D, $A00, $F4F4 ; DATA XREF: ROM:00059D9E   o
                                        ; ROM:off_59DA2   o
word_ECD16:     dc.w $88D9, $900, $F7F3 ; DATA XREF: ROM:off_59DC2   o
                                        ; ROM:00059DFE   o
word_ECD1C:     dc.w $98D3, $900, $F7F3 ; DATA XREF: ROM:00059DC6   o
                                        ; ROM:00059DFA   o
word_ECD22:     dc.w $98CA, $A00, $F5F3 ; DATA XREF: ROM:00059DCA   o
                                        ; ROM:00059DF6   o
word_ECD28:     dc.w $98C4, $600, $F5FA ; DATA XREF: ROM:00059DCE   o
                                        ; ROM:00059DF2   o
word_ECD2E:     dc.w $98BE, $600, $F4F9 ; DATA XREF: ROM:00059DD2   o
                                        ; ROM:00059DEE   o
word_ECD34:     dc.w $90C4, $600, $F5F8 ; DATA XREF: ROM:00059DD6   o
                                        ; ROM:00059DEA   o
word_ECD3A:     dc.w $90CA, $A00, $F5F6 ; DATA XREF: ROM:00059DDA   o
                                        ; ROM:00059DE6   o
word_ECD40:     dc.w $90D3, $900, $F7F6 ; DATA XREF: ROM:00059DDE   o
                                        ; ROM:off_59DE2   o
word_ECD46:     dc.w $8105, $D00, $F7EE ; DATA XREF: ROM:off_59E02   o
                                        ; ROM:00059E3E   o
word_ECD4C:     dc.w $101, $500, $F6FF  ; DATA XREF: ROM:00059E06   o
                                        ; ROM:00059E3A   o
                dc.w $80FD, $500, $F9EF
word_ECD58:     dc.w $F5, $700, $ED02   ; DATA XREF: ROM:00059E0A   o
                                        ; ROM:00059E36   o
                dc.w $80EF, $600, $F5F2
word_ECD64:     dc.w $E7, $500, $F0F9   ; DATA XREF: ROM:00059E0E   o
                                        ; ROM:00059E32   o
                dc.w $80EB, $500, $F6
word_ECD70:     dc.w $88DF, $700, $F1F8 ; DATA XREF: ROM:00059E12   o
                                        ; ROM:00059E2E   o
word_ECD76:     dc.w $8EB, $500, $FA    ; DATA XREF: ROM:00059E16   o
                                        ; ROM:00059E2A   o
                dc.w $88E7, $500, $F0F7
word_ECD82:     dc.w $8F5, $700, $EDEE  ; DATA XREF: ROM:00059E1A   o
                                        ; ROM:00059E26   o
                dc.w $88EF, $600, $F5FE
word_ECD8E:     dc.w $901, $500, $F6F2  ; DATA XREF: ROM:00059E1E   o
                                        ; ROM:off_59E22   o
                dc.w $88FD, $500, $F902
word_ECD9A:     dc.w $891D, $500, $F8F8 ; DATA XREF: ROM:off_59E42   o
                                        ; ROM:00059E7E   o
word_ECDA0:     dc.w $8921, $500, $F8F8 ; DATA XREF: ROM:00059E46   o
                                        ; ROM:00059E7A   o
word_ECDA6:     dc.w $8925, $500, $F8F8 ; DATA XREF: ROM:00059E4A   o
                                        ; ROM:00059E76   o
word_ECDAC:     dc.w $8929, $500, $F9F8 ; DATA XREF: ROM:00059E4E   o
                                        ; ROM:00059E72   o
word_ECDB2:     dc.w $910D, $500, $F8F9 ; DATA XREF: ROM:00059E52   o
                                        ; ROM:00059E6E   o
word_ECDB8:     dc.w $9111, $500, $F8F9 ; DATA XREF: ROM:00059E56   o
                                        ; ROM:00059E6A   o
word_ECDBE:     dc.w $9115, $500, $F9FA ; DATA XREF: ROM:00059E5A   o
                                        ; ROM:00059E66   o
word_ECDC4:     dc.w $9119, $500, $F9F9 ; DATA XREF: ROM:00059E5E   o
                                        ; ROM:off_59E62   o
word_ECDCA:     dc.w $961, $100, $4EC   ; DATA XREF: Boss_MedusaIntroMove+10   o
                                        ; ROM:off_59E94   o ...
                dc.w $956, $200, $ECEC
                dc.w $959, $D00, $4F4
                dc.w $894A, $E00, $ECF4
                dc.w $4800, $600, $E0F8
                dc.w $4806, $900, $F8F8
                dc.w $C80C, $600, $8F8
word_ECDF4:     dc.w $4824, 0, $1007    ; DATA XREF: ROM:off_ECE90   o
                dc.w $4825, $C00, $18EF
                dc.w $481E, $600, $F7
                dc.w $481C, $400, $FFF7
                dc.w $4818, $C00, $F7EF
                dc.w $C812, $600, $DFF7
word_ECE18:     dc.w $483C, $100, $10F2 ; DATA XREF: ROM:000ECE94   o
                dc.w $4834, $700, $FA
                dc.w $4832, $400, $FBF6
                dc.w $C82A, $700, $DBF6
word_ECE30:     dc.w $4848, $700, $FA   ; DATA XREF: ROM:000ECE98   o
                dc.w $4846, $400, $FBF6
                dc.w $C83E, $700, $DBF6
word_ECE42:     dc.w $4861, $C00, $18F1 ; DATA XREF: ROM:000ECE9C   o
                dc.w $485B, $600, $F9
                dc.w $4859, $400, $F6
                dc.w $4856, $800, $F8F6
                dc.w $C850, $600, $E0F6
word_ECE60:     dc.w $4869, $800, $18F4 ; DATA XREF: ROM:000ECEA0   o
                dc.w $4867, $400, $10F4
                dc.w $4865, $100, $FC
                dc.w $4846, $400, $FBF6
                dc.w $C83E, $700, $DBF6
word_ECE7E:     dc.w $486C, $700, $F8   ; DATA XREF: ROM:000ECEA4   o
                dc.w $4832, $400, $FBF6
                dc.w $C82A, $700, $DBF6
off_ECE90:      dc.w word_ECDF4-*       ; DATA XREF: Entity_ValkirieProjectileWaitTimer+C   o
                                        ; Entity_SevenForcesIntro+18   o ...
                dc.w 9
                dc.w word_ECE18-*
                dc.w 8
                dc.w word_ECE30-*
                dc.w 8
                dc.w word_ECE42-*
                dc.w 9
                dc.w word_ECE60-*
                dc.w 8
                dc.w word_ECE7E-*
                dc.w 8
                dc.w off_ECE90-*
                dc.w 0
word_ECEAC:     dc.w $FF36, $FF, $3A    ; DATA XREF: Entity_ValkirieProjectileInit+1E   o
                                        ; Entity_ValkirieProjectileCleanup+4   o ...
                dc.w $400, $FF0, $83A
                dc.w $400, $F00, $32
                dc.w $700, $EFF0, $8832
                dc.w $700, $EF00, $42
                dc.w $800, $8EC, $842
                dc.w $800, $8FC, $883C
                dc.w $900, $F8F4, $45
                dc.w $900, $8EC, $845
                dc.w $900, $8FC, $883C
                dc.w $900, $F8F4, $8829
                dc.w $A00, $F4F4
word_ECEF2:     dc.w $842, $400, $1DF8  ; DATA XREF: ROM:00032128   o
                                        ; ROM:00032148   o
                dc.w $83A, $700, $FDF8
                dc.w $882A, $F00, $DDF0
word_ECF04:     dc.w $85C, $100, $F8DB  ; DATA XREF: ROM:000316AA   o
                                        ; ROM:off_32118   o ...
                dc.w $854, $D00, $F8E3
                dc.w $8844, $F00, $F003
word_ECF16:     dc.w $874, $A00, $FBDD  ; DATA XREF: ROM:0003211C   o
                                        ; ROM:00032134   o ...
                dc.w $86E, $600, $F3F5
                dc.w $885E, $F00, $EB05
word_ECF28:     dc.w $898, $400, $3FD   ; DATA XREF: ROM:00032120   o
                                        ; ROM:00032130   o ...
                dc.w $896, $100, $F3F5
                dc.w $88D, $A00, $3E5
                dc.w $887D, $F00, $E3FD
word_ECF40:     dc.w $8AA, $A00, $BEE   ; DATA XREF: ROM:00032124   o
                                        ; ROM:0003212C   o ...
                dc.w $8B3, $900, $FBF6
                dc.w $889A, $F00, $DBF6
word_ECF52:     dc.w $88B9, $800, $FBF5 ; DATA XREF: ROM:off_322C8   o
                                        ; ROM:000322E8   o
word_ECF58:     dc.w $88BC, $900, $F6F5 ; DATA XREF: ROM:000322CC   o
                                        ; ROM:000322E4   o ...
word_ECF5E:     dc.w $88C2, $A00, $F4F3 ; DATA XREF: ROM:000322D0   o
                                        ; ROM:000322E0   o ...
word_ECF64:     dc.w $88CB, $600, $F4F7 ; DATA XREF: ROM:000322D4   o
                                        ; ROM:000322DC   o ...
word_ECF6A:     dc.w $88D1, $200, $F3FC ; DATA XREF: ROM:000322D8   o
                                        ; ROM:000322F8   o
word_ECF70:     dc.w $88D4, $500, $F8F8 ; DATA XREF: ROM:off_316A6   o
word_ECF76:     dc.w $C84E, $F00, $F0F0 ; DATA XREF: ROM:stru_4E1E0   o
                                        ; ROM:0004E1E8   o ...
word_ECF7C:     dc.w $C85E, $F00, $EEF2 ; DATA XREF: ROM:0004F5A0   o
                                        ; ROM:0004F5C0   o
word_ECF82:     dc.w $C86E, $F00, $F0F0 ; DATA XREF: ROM:0004F5A8   o
                                        ; ROM:0004F5C8   o
word_ECF88:     dc.w $C87E, $F00, $EEEE ; DATA XREF: ROM:0004F5B0   o
                                        ; ROM:0004F5D0   o
word_ECF8E:     dc.w $5800, $500, 8     ; DATA XREF: Boss_ShieldViperDispatcher+4E   o
                                        ; ROM:stru_4F558   o ...
                dc.w $5804, $E00, $E8
                dc.w $4804, $E00, $E8E8
                dc.w $C800, $500, $F008
word_ECFA6:     dc.w $4824, $200, $F10F ; DATA XREF: ROM:0004F560   o
                                        ; ROM:0004F580   o
                dc.w $4820, $C00, $E9F7
                dc.w $C810, $F00, $F1EF
word_ECFB8:     dc.w $402B, $B00, $F8E8 ; DATA XREF: ROM:0004F568   o
                                        ; ROM:0004F588   o
                dc.w $4027, $500, $E8F0
                dc.w $4827, $500, $E800
                dc.w $C82B, $B00, $F800
word_ECFD0:     dc.w $484B, $200, $F1E9 ; DATA XREF: ROM:0004F570   o
                                        ; ROM:0004F590   o
                dc.w $4847, $C00, $E9E9
                dc.w $C837, $F00, $F1F1
word_ECFE2:     dc.w $C88E, $500, $F8F8 ; DATA XREF: ROM:0004E270   o
                                        ; ROM:0004E278   o
word_ECFE8:     dc.w $C892, $500, $F8F8 ; DATA XREF: ROM:0004E280   o
                                        ; ROM:0004E288   o
word_ECFEE:     dc.w $C896, $500, $F8F8 ; DATA XREF: ROM:0004E290   o
                                        ; ROM:0004E298   o
word_ECFF4:     dc.w $C89A, 0, $FCFC    ; DATA XREF: Projectile_ShieldViperSpawnEffect+18   o
                                        ; ROM:stru_4F15E   o
word_ECFFA:     dc.w $C89B, $500, $F8F8 ; DATA XREF: Boss_ShieldViperDispatcher+124   o
                                        ; ROM:0004F166   o
word_ED000:     dc.w $C89F, $A00, $F4F4 ; DATA XREF: ROM:0004F16E   o
word_ED006:     dc.w $C8A8, $F00, $F0F0 ; DATA XREF: ROM:0004F176   o
word_ED00C:     dc.w $C8B8, $F00, $F0F0 ; DATA XREF: ROM:0004F17E   o
word_ED012:     dc.w $C8C8, $F00, $F0F0 ; DATA XREF: ROM:0004F186   o
word_ED018:     dc.w $C8D8, $F00, $F0F0 ; DATA XREF: ROM:0004F18E   o
word_ED01E:     dc.w $C8E8, $F00, $F0F0 ; DATA XREF: ROM:0004F196   o
                                        ; ROM:0004F19E   o
word_ED024:     dc.w $6038, $500, $FA00 ; DATA XREF: ROM:off_ED152   o
                                        ; ROM:off_ED156   o
                dc.w $E838, $500, $FAF0
word_ED030:     dc.w $483C, $D00, $FBD0 ; DATA XREF: ROM:off_ED13E   o
                dc.w $483C, $D00, $FBF0
                dc.w $483C, $D00, $FB10
                dc.w $6038, $500, $FA30
                dc.w $E838, $500, $FAC0
word_ED04E:     dc.w $583C, $D00, $F5D0 ; DATA XREF: ROM:000ED142   o
                dc.w $583C, $D00, $F6F0
                dc.w $583C, $D00, $F510
                dc.w $6038, $500, $FA30
                dc.w $E838, $500, $FAC0
word_ED06C:     dc.w $403C, $D00, $FBD0 ; DATA XREF: ROM:000ED14A   o
                dc.w $403C, $D00, $FBF0
                dc.w $403C, $D00, $FB10
                dc.w $6038, $500, $FA30
                dc.w $E838, $500, $FAC0
word_ED08A:     dc.w $503C, $D00, $F6D0 ; DATA XREF: ROM:000ED146   o
                dc.w $503C, $D00, $F7F0
                dc.w $503C, $D00, $F610
                dc.w $6038, $500, $FA30
                dc.w $E838, $500, $FAC0
word_ED0A8:     dc.w $6838, $500, $FAE4 ; DATA XREF: ROM:000ED15E   o
                dc.w $6038, $500, $FA0C
                dc.w $C83C, $D00, $FAF0
word_ED0BA:     dc.w $6838, $500, $FADC ; DATA XREF: ROM:000ED162   o
                dc.w $403C, $D00, $FAE6
                dc.w $6038, $500, $FA14
                dc.w $C83C, $D00, $FAFA
word_ED0D2:     dc.w $6838, $500, $FAD4 ; DATA XREF: ROM:000ED166   o
                dc.w $483C, $D00, $FAE0
                dc.w $6038, $500, $FA1C
                dc.w $C03C, $D00, $FA00
word_ED0EA:     dc.w $483C, $D00, $FAF0 ; DATA XREF: ROM:000ED16A   o
                dc.w $6838, $500, $FACC
                dc.w $483C, $D00, $FAD7
                dc.w $6038, $500, $FA24
                dc.w $C03C, $D00, $FA09
word_ED108:     dc.w $583C, $D00, $F5F0 ; DATA XREF: ROM:000ED16E   o
                dc.w $6838, $500, $FAC4
                dc.w $403C, $D00, $FAD0
                dc.w $6038, $500, $FA2C
                dc.w $C83C, $D00, $FA10
word_ED126:     dc.w $6838, $500, $FAEB ; DATA XREF: ROM:000ED15A   o
                dc.w $6038, $500, $FA05
                dc.w $C83C, $D00, $FAF0
                dc.w $E837, 0, $1FFF
off_ED13E:      dc.w word_ED030-*       ; DATA XREF: Boss_ProjectileWaitAnimation+8   o
                                        ; ROM:000ED14E   o
                dc.w 1
                dc.w word_ED04E-*
                dc.w 1
                dc.w word_ED08A-*
                dc.w 1
                dc.w word_ED06C-*
                dc.w 1
                dc.w off_ED13E-*
                dc.w 0
off_ED152:      dc.w word_ED024-*       ; DATA XREF: Projectile_InitMissirayBullet+4   o
                dc.w $FF
off_ED156:      dc.w word_ED024-*       ; DATA XREF: Boss_ProjectileTransformAttack+6   o
                dc.w 1
                dc.w word_ED126-*
                dc.w 1
                dc.w word_ED0A8-*
                dc.w 1
                dc.w word_ED0BA-*
                dc.w 1
                dc.w word_ED0D2-*
                dc.w 1
                dc.w word_ED0EA-*
                dc.w 1
                dc.w word_ED108-*
                dc.w $FF
word_ED172:     dc.w $480B, $100, $F8E9 ; DATA XREF: Boss_WolfGaropaMovement3+94   o
                dc.w $4803, $D00, $F8F1
                dc.w $C800, $800, $F0F3
                dc.w $480D, $800, $EBF2
                dc.w $C810, $E00, $F3F2
word_ED190:     dc.w $4824, $400, $FBE1 ; DATA XREF: Boss_WolfGaropaMovement3+AE   o
                                        ; ROM:off_50586   o
                dc.w $C81C, $D00, $F8F0
word_ED19C:     dc.w $482F, $500, $CEA  ; DATA XREF: ROM:0005058A   o
                dc.w $482C, $800, $4EC
                dc.w $C826, $900, $F4F4
word_ED1AE:     dc.w $483B, $100, $10FB ; DATA XREF: ROM:0005058E   o
                dc.w $C833, $700, $F0F8
word_ED1BA:     dc.w $4846, $500, $C07  ; DATA XREF: ROM:00050592   o
                dc.w $4843, $800, $4FD
                dc.w $C83D, $900, $F4F5
word_ED1CC:     dc.w $C84A, $E00, $F4F0 ; DATA XREF: ROM:off_352A6   o
word_ED1D2:     dc.w $4859, $D00, $FAEE ; DATA XREF: ROM:000352AA   o
                dc.w $C856, $800, $F2F6
word_ED1DE:     dc.w $C861, $A00, $F5F4 ; DATA XREF: ROM:000352AE   o
word_ED1E4:     dc.w $486D, $700, $F3F7 ; DATA XREF: ROM:000352B2   o
                dc.w $C86A, $200, $F307
word_ED1F0:     dc.w $C875, $B00, $F0F4 ; DATA XREF: ROM:000352B6   o
word_ED1F6:     dc.w $406A, $200, $F2F2 ; DATA XREF: ROM:000352BA   o
                dc.w $C06D, $700, $F2FA
word_ED202:     dc.w $C061, $A00, $F4F5 ; DATA XREF: ROM:000352BE   o
word_ED208:     dc.w $4056, $800, $F1F2 ; DATA XREF: ROM:000352C2   o
                dc.w $C059, $D00, $F9F2
word_ED214:     dc.w $4890, $500, $F9E7 ; DATA XREF: ROM:off_352C6   o
                dc.w $4884, $E00, $F9F7
                dc.w $C881, $800, $F1F9
word_ED226:     dc.w $48A0, $800, $9F6  ; DATA XREF: ROM:000352CA   o
                dc.w $4894, $E00, $F1F6
                dc.w $C8A3, $500, $FEE6
word_ED238:     dc.w $48B9, 0, $DF4     ; DATA XREF: ROM:000352CE   o
                dc.w $48B7, $100, $5EC
                dc.w $C8A7, $F00, $EDF4
word_ED24A:     dc.w $48C9, $100, $AF9  ; DATA XREF: ROM:000352D2   o
                dc.w $48C6, $200, $FAF1
                dc.w $C8BA, $B00, $EAF9
word_ED25C:     dc.w $49C5, $500, $8F9  ; DATA XREF: ROM:000352D6   o
                dc.w $49C2, $200, $EEF1
                dc.w $C9B6, $B00, $E8F9
word_ED26E:     dc.w $48DA, $500, $9FD  ; DATA XREF: ROM:000352DA   o
                dc.w $48D7, $200, $F10A
                dc.w $C8CB, $B00, $E9F2
word_ED280:     dc.w $48EE, $800, $C00  ; DATA XREF: ROM:000352DE   o
                dc.w $48EA, $C00, $4F8
                dc.w $C8DE, $E00, $ECF0
word_ED292:     dc.w $48FD, 0, $803     ; DATA XREF: ROM:000352E2   o
                dc.w $48FE, $500, $FE0B
                dc.w $C8F1, $E00, $F0EB
word_ED2A4:     dc.w $490A, $100, $F9E9 ; DATA XREF: ROM:off_352E6   o
                dc.w $C902, $D00, $F9F1
word_ED2B0:     dc.w $4910, $500, $FAF0 ; DATA XREF: ROM:000352EA   o
                dc.w $C90C, $500, $F600
word_ED2BC:     dc.w $491A, $500, $3F2  ; DATA XREF: ROM:000352EE   o
                dc.w $C914, $900, $F3F6
word_ED2C8:     dc.w $4922, $500, $1F7  ; DATA XREF: ROM:000352F2   o
                dc.w $C91E, $500, $F1FB
word_ED2D4:     dc.w $492E, $400, $FFA  ; DATA XREF: ROM:000352F6   o
                dc.w $C926, $700, $EFFA
word_ED2E0:     dc.w $4934, $500, $FC   ; DATA XREF: ROM:000352FA   o
                dc.w $C930, $500, $F0F8
word_ED2EC:     dc.w $493E, $500, $FD05 ; DATA XREF: ROM:000352FE   o
                dc.w $C938, $600, $F1F5
word_ED2F8:     dc.w $4946, $500, $F802 ; DATA XREF: ROM:00035302   o
                dc.w $C942, $500, $F4F2
word_ED304:     dc.w $C94A, $900, $F9EF ; DATA XREF: ROM:00035330   o
                                        ; ROM:00035344   o ...
word_ED30A:     dc.w $C950, $600, $FBFB ; DATA XREF: Boss_WolfGaropaShootPattern6+96   o
word_ED310:     dc.w $4965, 0, $BF2     ; DATA XREF: Boss_WolfGaropaSetPattern1   o
                                        ; Boss_WolfGaropaShootPattern5+140   o
                dc.w $4966, $600, $FCE2
                dc.w $495A, $400, $EBF4
                dc.w $C95C, $A00, $F3F2
word_ED328:     dc.w $497B, $900, $DEC  ; DATA XREF: Boss_WolfGaropaMovement3+E6   o
                                        ; Boss_WolfGaropaShootPattern5+14C   o
                dc.w $496C, $800, $EDEC
                dc.w $C96F, $E00, $F5EC
word_ED33A:     dc.w $498F, $200, $E0E4 ; DATA XREF: Boss_WolfGaropaMovement3+CE   o
                                        ; sub_50220:loc_5034E   o
                dc.w $4992, $D00, $F8EC
                dc.w $4981, $100, $E80C
                dc.w $C983, $E00, $E0EC
word_ED352:     dc.w $49B4, $400, $FADF ; DATA XREF: Boss_WolfGaropaShootPattern5+11E   o
                dc.w $49AC, $D00, $FAEF
                dc.w $499A, $E00, $E2EF
                dc.w $C9A6, $600, $E2DF
                dc.w 0, $700, $F0F0
                dc.w $8800, $700, $F000
                dc.w $8808, $300, $F0FC
                dc.w $880C, $300, $F0FC
word_ED382:     dc.w $10, $B00, $ECE8   ; DATA XREF: Projectile_ZLeoSpawnLasers+1A   o
                dc.w $8810, $B00, $EC00
                dc.w $881C, $500, $F8F8
word_ED394:     dc.w $A820, $200, $F4FC ; DATA XREF: Boss_ZLeoIntroInit+154   o
                                        ; Boss_ZLeoIntroInit+16C   o
word_ED39A:     dc.w $2837, $200, $8E8  ; DATA XREF: Boss_ZLeoIntroInit+14C   o
                                        ; Boss_ZLeoIntroInit+164   o
                dc.w $2833, $300, $F0
                dc.w $A823, $700, $F0F8
word_ED3AC:     dc.w $284A, $500, $8F8  ; DATA XREF: ROM:000355E0   o
                dc.w $A83A, $F00, $E8F0
word_ED3B8:     dc.w $A84E, $200, $F3FC ; DATA XREF: Boss_ZLeoIntroInit+100   o
word_ED3BE:     dc.w $A851, $100, $F8FC ; DATA XREF: Boss_ZLeoIntroInit+114   o
word_ED3C4:     dc.w $2867, 0, $CEC     ; DATA XREF: ROM:000355B0   o
                                        ; ROM:000355B8   o ...
                dc.w $2868, $C00, $CF4
                dc.w $2863, $300, $ECEC
                dc.w $A853, $F00, $ECF4
word_ED3DC:     dc.w $386C, $D00, $F0   ; DATA XREF: ROM:000355B4   o
                                        ; ROM:000355C4   o ...
                dc.w $A86C, $D00, $F0F0
word_ED3E8:     dc.w $A874, $A00, $F4F4 ; DATA XREF: ROM:000355D4   o
                                        ; ROM:000355DC   o
word_ED3EE:     dc.w $A87D, $500, $F8F8 ; DATA XREF: ROM:000355C8   o
                                        ; ROM:000355D0   o ...
word_ED3F4:     dc.w $3889, $D00, $E0   ; DATA XREF: ROM:off_528C8   o
                dc.w $3881, $D00, 0
                dc.w $2889, $D00, $F0E0
                dc.w $A881, $D00, $F000
word_ED40C:     dc.w $28A4, $F00, $FCE4 ; DATA XREF: ROM:000528CC   o
                dc.w $289E, $900, $FC04
                dc.w $289D, 0, $F4F4
                dc.w $A891, $E00, $E4FC
word_ED424:     dc.w $20BC, $700, $F0   ; DATA XREF: ROM:000355BC   o
                                        ; ROM:000528D0   o
                dc.w $20B4, $700, $E0F0
                dc.w $28BC, $700, 0
                dc.w $A8B4, $700, $E000
word_ED43C:     dc.w $20A4, $F00, $FCFC ; DATA XREF: ROM:000528D4   o
                dc.w $209E, $900, $FCE4
                dc.w $209D, 0, $F404
                dc.w $A091, $E00, $E4E4
                dc.w $A8C4, $800, $FCF4
                dc.w $28C9, $500, $FAF2
                dc.w $A8C7, $100, $F202
                dc.w $A8CD, $200, $F4FD
                dc.w $20C9, $500, $F9FF
                dc.w $A0C7, $100, $F1F7
word_ED478:     dc.w $A82B, $700, $F0F8 ; DATA XREF: Boss_ZLeoIntroInit+144   o
                                        ; Boss_ZLeoIntroInit+15C   o
word_ED47E:     dc.w $80C, $300, $70FC  ; DATA XREF: Projectile_ZLeoSpawnLasers+60   o
                                        ; Projectile_ZLeoSpawnDropProjectile+3C   o
                dc.w $808, $300, $50FC
                dc.w $808, $300, $30FC
                dc.w $808, $300, $10FC
                dc.w $808, $300, $F0FC
                dc.w $808, $300, $D0FC
                dc.w $808, $300, $B0FC
                dc.w 0, $700, $90F0
                dc.w $8800, $700, $9000
tiles_ED4B4:	binclude	"data/artcomp/tiles_0ED4B4.bin"
tiles_ED4B4_End:
tiles_font:	binclude	"data/artunc/font.bin"
tiles_font_End:
tiles_F10A4:	binclude	"data/artcomp/tiles_F10A4.bin"
tiles_F10A4_End:
tiles_F276E:	binclude	"data/artcomp/tiles_0F276E.bin"
tiles_F276E_End:
tiles_F2816:	binclude	"data/artcomp/tiles_0F2816.bin"
tiles_F2816_End:
sprite_F2826:	binclude	"data/artunc/sprite_F2826.bin"	; DATA XREF: ROM:000E86DC   o
sprite_F2826_End:
sprite_F2A28:	binclude	"data/artunc/sprite_F2A28.bin"
sprite_F2A28_End:
sprite_F2A4A:	binclude	"data/artunc/sprite_F2A4A.bin"
sprite_F2A4A_End:
sprite_F2BCC:	binclude	"data/artunc/sprite_F2BCC.bin"
sprite_F2BCC_End:
sprite_F2C8E:	binclude	"data/artunc/sprite_F2C8E.bin"
sprite_F2C8E_End:
sprite_F2CD0:	binclude	"data/artunc/sprite_F2CD0.bin"
sprite_F2CD0_End:
sprite_F2CF2:	binclude	"data/artunc/sprite_F2CF2.bin"
sprite_F2CF2_End:
sprite_F2D34:	binclude	"data/artunc/sprite_F2D34.bin"
sprite_F2D34_End:
sprite_F2EB6:	binclude	"data/artunc/sprite_F2EB6.bin"
sprite_F2EB6_End:
sprite_F2F18:	binclude	"data/artunc/sprite_F2F18.bin"
sprite_F2F18_End:
sprite_F2F5A:	binclude	"data/artunc/sprite_F2F5A.bin"
sprite_F2F5A_End:
sprite_F30DC:	binclude	"data/artunc/sprite_F30DC.bin"
sprite_F30DC_End:
sprite_F313E:	binclude	"data/artunc/sprite_F313E.bin"
sprite_F313E_End:
sprite_F31C0:	binclude	"data/artunc/sprite_F31C0.bin"
sprite_F31C0_End:
sprite_F31E2:	binclude	"data/artunc/sprite_F31E2.bin"
sprite_F31E2_End:
sprite_F3364:	binclude	"data/artunc/sprite_F3364.bin"
sprite_F3364_End:
sprite_F33C6:	binclude	"data/artunc/sprite_F33C6.bin"
sprite_F33C6_End:
sprite_F3448:	binclude	"data/artunc/sprite_F3448.bin"
sprite_F3448_End:
sprite_F346A:	binclude	"data/artunc/sprite_F346A.bin"
sprite_F346A_End:
sprite_F35EC:	binclude	"data/artunc/sprite_F35EC.bin"
sprite_F35EC_End:
sprite_F364E:	binclude	"data/artunc/sprite_F364E.bin"
sprite_F364E_End:
sprite_F3690:	binclude	"data/artunc/sprite_F3690.bin"
sprite_F3690_End:
sprite_F36B2:	binclude	"data/artunc/sprite_F36B2.bin"
sprite_F36B2_End:
sprite_F3834:	binclude	"data/artunc/sprite_F3834.bin"
sprite_F3834_End:
sprite_F3896:	binclude	"data/artunc/sprite_F3896.bin"
sprite_F3896_End:
sprite_F38D8:	binclude	"data/artunc/sprite_F38D8.bin"
sprite_F38D8_End:
sprite_F393A:	binclude	"data/artunc/sprite_F393A.bin"
sprite_F393A_End:
sprite_F3B3C:	binclude	"data/artunc/sprite_F3B3C.bin"
sprite_F3B3C_End:
sprite_F3B9E:	binclude	"data/artunc/sprite_F3B9E.bin"
sprite_F3B9E_End:
sprite_F3BE0:	binclude	"data/artunc/sprite_F3BE0.bin"
sprite_F3BE0_End:
sprite_F3C02:	binclude	"data/artunc/sprite_F3C02.bin"
sprite_F3C02_End:
sprite_F3C44:	binclude	"data/artunc/sprite_F3C44.bin"
sprite_F3C44_End:
sprite_F3E46:	binclude	"data/artunc/sprite_F3E46.bin"
sprite_F3E46_End:
sprite_F3EA8:	binclude	"data/artunc/sprite_F3EA8.bin"
sprite_F3EA8_End:
sprite_F3F0A:	binclude	"data/artunc/sprite_F3F0A.bin"
sprite_F3F0A_End:
sprite_F3F4C:	binclude	"data/artunc/sprite_F3F4C.bin"
sprite_F3F4C_End:
sprite_F40CE:	binclude	"data/artunc/sprite_F40CE.bin"
sprite_F40CE_End:
sprite_F4130:	binclude	"data/artunc/sprite_F4130.bin"
sprite_F4130_End:
sprite_F4192:	binclude	"data/artunc/sprite_F4192.bin"
sprite_F4192_End:
sprite_F41D4:	binclude	"data/artunc/sprite_F41D4.bin"
sprite_F41D4_End:
sprite_F4236:	binclude	"data/artunc/sprite_F4236.bin"
sprite_F4236_End:
sprite_F43B8:	binclude	"data/artunc/sprite_F43B8.bin"
sprite_F43B8_End:
sprite_F441A:	binclude	"data/artunc/sprite_F441A.bin"
sprite_F441A_End:
sprite_F44DC:	binclude	"data/artunc/sprite_F44DC.bin"
sprite_F44DC_End:
sprite_F459E:	binclude	"data/artunc/sprite_F459E.bin"
sprite_F459E_End:
sprite_F4620:	binclude	"data/artunc/sprite_F4620.bin"
sprite_F4620_End:
sprite_F47A2:	binclude	"data/artunc/sprite_F47A2.bin"
sprite_F47A2_End:
sprite_F4804:	binclude	"data/artunc/sprite_F4804.bin"
sprite_F4804_End:
sprite_F4886:	binclude	"data/artunc/sprite_F4886.bin"
sprite_F4886_End:
sprite_F4908:	binclude	"data/artunc/sprite_F4908.bin"
sprite_F4908_End:
sprite_F498A:	binclude	"data/artunc/sprite_F498A.bin"
sprite_F498A_End:
sprite_F49CC:	binclude	"data/artunc/sprite_F49CC.bin"
sprite_F49CC_End:
sprite_F4B4E:	binclude	"data/artunc/sprite_F4B4E.bin"
sprite_F4B4E_End:
sprite_F4BB0:	binclude	"data/artunc/sprite_F4BB0.bin"
sprite_F4BB0_End:
sprite_F4C32:	binclude	"data/artunc/sprite_F4C32.bin"
sprite_F4C32_End:
sprite_F4C54:	binclude	"data/artunc/sprite_F4C54.bin"
sprite_F4C54_End:
sprite_F4D16:	binclude	"data/artunc/sprite_F4D16.bin"
sprite_F4D16_End:
sprite_F4E98:	binclude	"data/artunc/sprite_F4E98.bin"
sprite_F4E98_End:
sprite_F4EFA:	binclude	"data/artunc/sprite_F4EFA.bin"
sprite_F4EFA_End:
sprite_F4FBC:	binclude	"data/artunc/sprite_F4FBC.bin"
sprite_F4FBC_End:
sprite_F4FDE:	binclude	"data/artunc/sprite_F4FDE.bin"
sprite_F4FDE_End:
sprite_F5000:	binclude	"data/artunc/sprite_F5000.bin"
sprite_F5000_End:
sprite_F5022:	binclude	"data/artunc/sprite_F5022.bin"
sprite_F5022_End:
sprite_F51A4:	binclude	"data/artunc/sprite_F51A4.bin"
sprite_F51A4_End:
sprite_F5206:	binclude	"data/artunc/sprite_F5206.bin"
sprite_F5206_End:
sprite_F5308:	binclude	"data/artunc/sprite_F5308.bin"
sprite_F5308_End:
sprite_F532A:	binclude	"data/artunc/sprite_F532A.bin"
sprite_F532A_End:
sprite_F536C:	binclude	"data/artunc/sprite_F536C.bin"
sprite_F536C_End:
sprite_F54EE:	binclude	"data/artunc/sprite_F54EE.bin"
sprite_F54EE_End:
sprite_F5550:	binclude	"data/artunc/sprite_F5550.bin"
sprite_F5550_End:
sprite_F5612:	binclude	"data/artunc/sprite_F5612.bin"
sprite_F5612_End:
sprite_F5674:	binclude	"data/artunc/sprite_F5674.bin"
sprite_F5674_End:
sprite_F5736:	binclude	"data/artunc/sprite_F5736.bin"
sprite_F5736_End:
sprite_F57F8:	binclude	"data/artunc/sprite_F57F8.bin"
sprite_F57F8_End:
sprite_F58FA:	binclude	"data/artunc/sprite_F58FA.bin"
sprite_F58FA_End:
sprite_F597C:	binclude	"data/artunc/sprite_F597C.bin"
sprite_F597C_End:
sprite_F599E:	binclude	"data/artunc/sprite_F599E.bin"
sprite_F599E_End:
sprite_F5A60:	binclude	"data/artunc/sprite_F5A60.bin"
sprite_F5A60_End:
sprite_F5A82:	binclude	"data/artunc/sprite_F5A82.bin"
sprite_F5A82_End:
sprite_F5B44:	binclude	"data/artunc/sprite_F5B44.bin"
sprite_F5B44_End:
sprite_F5C46:	binclude	"data/artunc/sprite_F5C46.bin"
sprite_F5C46_End:
sprite_F5D08:	binclude	"data/artunc/sprite_F5D08.bin"
sprite_F5D08_End:
sprite_F5D4A:	binclude	"data/artunc/sprite_F5D4A.bin"
sprite_F5D4A_End:
sprite_F5D6C:	binclude	"data/artunc/sprite_F5D6C.bin"
sprite_F5D6C_End:
sprite_F5EEE:	binclude	"data/artunc/sprite_F5EEE.bin"
sprite_F5EEE_End:
sprite_F5F70:	binclude	"data/artunc/sprite_F5F70.bin"
sprite_F5F70_End:
sprite_F5F92:	binclude	"data/artunc/sprite_F5F92.bin"
sprite_F5F92_End:
sprite_F6014:	binclude	"data/artunc/sprite_F6014.bin"
sprite_F6014_End:
sprite_F6036:	binclude	"data/artunc/sprite_F6036.bin"
sprite_F6036_End:
sprite_F6078:	binclude	"data/artunc/sprite_F6078.bin"
sprite_F6078_End:
sprite_F627A:	binclude	"data/artunc/sprite_F627A.bin"
sprite_F627A_End:
sprite_F629C:	binclude	"data/artunc/sprite_F629C.bin"
sprite_F629C_End:
sprite_F62DE:	binclude	"data/artunc/sprite_F62DE.bin"
sprite_F62DE_End:
sprite_F6460:	binclude	"data/artunc/sprite_F6460.bin"
sprite_F6460_End:
sprite_F64C2:	binclude	"data/artunc/sprite_F64C2.bin"
sprite_F64C2_End:
sprite_F6544:	binclude	"data/artunc/sprite_F6544.bin"
sprite_F6544_End:
sprite_F6566:	binclude	"data/artunc/sprite_F6566.bin"
sprite_F6566_End:
sprite_F65E8:	binclude	"data/artunc/sprite_F65E8.bin"
sprite_F65E8_End:
sprite_F660A:	binclude	"data/artunc/sprite_F660A.bin"
sprite_F660A_End:
sprite_F672C:	binclude	"data/artunc/sprite_F672C.bin"
sprite_F672C_End:
sprite_F67AE:	binclude	"data/artunc/sprite_F67AE.bin"
sprite_F67AE_End:
sprite_F6870:	binclude	"data/artunc/sprite_F6870.bin"
sprite_F6870_End:
sprite_F6892:	binclude	"data/artunc/sprite_F6892.bin"
sprite_F6892_End:
sprite_F6914:	binclude	"data/artunc/sprite_F6914.bin"
sprite_F6914_End:
sprite_F6936:	binclude	"data/artunc/sprite_F6936.bin"
sprite_F6936_End:
sprite_F69F8:	binclude	"data/artunc/sprite_F69F8.bin"
sprite_F69F8_End:
sprite_F6A1A:	binclude	"data/artunc/sprite_F6A1A.bin"
sprite_F6A1A_End:
sprite_F6A9C:	binclude	"data/artunc/sprite_F6A9C.bin"
sprite_F6A9C_End:
sprite_F6ADE:	binclude	"data/artunc/sprite_F6ADE.bin"
sprite_F6ADE_End:
sprite_F6BE0:	binclude	"data/artunc/sprite_F6BE0.bin"
sprite_F6BE0_End:
sprite_F6D62:	binclude	"data/artunc/sprite_F6D62.bin"
sprite_F6D62_End:
sprite_F6DC4:	binclude	"data/artunc/sprite_F6DC4.bin"
sprite_F6DC4_End:
sprite_F6E06:	binclude	"data/artunc/sprite_F6E06.bin"
sprite_F6E06_End:
sprite_F6E28:	binclude	"data/artunc/sprite_F6E28.bin"
sprite_F6E28_End:
sprite_F6F2A:	binclude	"data/artunc/sprite_F6F2A.bin"
sprite_F6F2A_End:
sprite_F6FAC:	binclude	"data/artunc/sprite_F6FAC.bin"
sprite_F6FAC_End:
sprite_F706E:	binclude	"data/artunc/sprite_F706E.bin"
sprite_F706E_End:
sprite_F7090:	binclude	"data/artunc/sprite_F7090.bin"
sprite_F7090_End:
sprite_F7152:	binclude	"data/artunc/sprite_F7152.bin"
sprite_F7152_End:
sprite_F71D4:	binclude	"data/artunc/sprite_F71D4.bin"
sprite_F71D4_End:
sprite_F7296:	binclude	"data/artunc/sprite_F7296.bin"
sprite_F7296_End:
sprite_F72D8:	binclude	"data/artunc/sprite_F72D8.bin"
sprite_F72D8_End:
sprite_F72FA:	binclude	"data/artunc/sprite_F72FA.bin"
sprite_F72FA_End:
sprite_F74FC:	binclude	"data/artunc/sprite_F74FC.bin"
sprite_F74FC_End:
sprite_F75BE:	binclude	"data/artunc/sprite_F75BE.bin"
sprite_F75BE_End:
sprite_F75E0:	binclude	"data/artunc/sprite_F75E0.bin"
sprite_F75E0_End:
sprite_F7602:	binclude	"data/artunc/sprite_F7602.bin"
sprite_F7602_End:
sprite_F7664:	binclude	"data/artunc/sprite_F7664.bin"
sprite_F7664_End:
sprite_F7686:	binclude	"data/artunc/sprite_F7686.bin"
sprite_F7686_End:
sprite_F76C8:	binclude	"data/artunc/sprite_F76C8.bin"
sprite_F76C8_End:
sprite_F778A:	binclude	"data/artunc/sprite_F778A.bin"
sprite_F778A_End:
sprite_F788C:	binclude	"data/artunc/sprite_F788C.bin"
sprite_F788C_End:
sprite_F790E:	binclude	"data/artunc/sprite_F790E.bin"
sprite_F790E_End:
sprite_F79D0:	binclude	"data/artunc/sprite_F79D0.bin"
sprite_F79D0_End:
sprite_F7A32:	binclude	"data/artunc/sprite_F7A32.bin"
sprite_F7A32_End:
sprite_F7AF4:	binclude	"data/artunc/sprite_F7AF4.bin"
sprite_F7AF4_End:
sprite_F7B76:	binclude	"data/artunc/sprite_F7B76.bin"
sprite_F7B76_End:
sprite_F7C78:	binclude	"data/artunc/sprite_F7C78.bin"
sprite_F7C78_End:
sprite_F7D7A:	binclude	"data/artunc/sprite_F7D7A.bin"
sprite_F7D7A_End:
sprite_F7DBC:	binclude	"data/artunc/sprite_F7DBC.bin"
sprite_F7DBC_End:
sprite_F7EBE:	binclude	"data/artunc/sprite_F7EBE.bin"
sprite_F7EBE_End:
sprite_F7F00:	binclude	"data/artunc/sprite_F7F00.bin"
sprite_F7F00_End:
sprite_F8102:	binclude	"data/artunc/sprite_F8102.bin"
sprite_F8102_End:
sprite_F8124:	binclude	"data/artunc/sprite_F8124.bin"
sprite_F8124_End:
sprite_F8166:	binclude	"data/artunc/sprite_F8166.bin"
sprite_F8166_End:
sprite_F8368:	binclude	"data/artunc/sprite_F8368.bin"
sprite_F8368_End:
sprite_F83AA:	binclude	"data/artunc/sprite_F83AA.bin"
sprite_F83AA_End:
sprite_F85AC:	binclude	"data/artunc/sprite_F85AC.bin"
sprite_F85AC_End:
sprite_F85CE:	binclude	"data/artunc/sprite_F85CE.bin"
sprite_F85CE_End:
sprite_F8610:	binclude	"data/artunc/sprite_F8610.bin"
sprite_F8610_End:
sprite_F8672:	binclude	"data/artunc/sprite_F8672.bin"
sprite_F8672_End:
sprite_F86F4:	binclude	"data/artunc/sprite_F86F4.bin"
sprite_F86F4_End:
sprite_F8736:	binclude	"data/artunc/sprite_F8736.bin"
sprite_F8736_End:
sprite_F88B8:	binclude	"data/artunc/sprite_F88B8.bin"
sprite_F88B8_End:
sprite_F891A:	binclude	"data/artunc/sprite_F891A.bin"
sprite_F891A_End:
sprite_F893C:	binclude	"data/artunc/sprite_F893C.bin"
sprite_F893C_End:
sprite_F8ABE:	binclude	"data/artunc/sprite_F8ABE.bin"
sprite_F8ABE_End:
sprite_F8B00:	binclude	"data/artunc/sprite_F8B00.bin"
sprite_F8B00_End:
sprite_F8C02:	binclude	"data/artunc/sprite_F8C02.bin"
sprite_F8C02_End:
sprite_F8CC4:	binclude	"data/artunc/sprite_F8CC4.bin"
sprite_F8CC4_End:
sprite_F8D86:	binclude	"data/artunc/sprite_F8D86.bin"
sprite_F8D86_End:
sprite_F8EAA:	binclude	"data/artunc/sprite_F8EAA.bin"
sprite_F8EAA_End:
sprite_F902C:	binclude	"data/artunc/sprite_F902C.bin"
sprite_F902C_End:
sprite_F906E:	binclude	"data/artunc/sprite_F906E.bin"
sprite_F906E_End:
sprite_F90D0:	binclude	"data/artunc/sprite_F90D0.bin"
sprite_F90D0_End:
sprite_F91D2:	binclude	"data/artunc/sprite_F91D2.bin"
sprite_F91D2_End:
sprite_F9214:	binclude	"data/artunc/sprite_F9214.bin"
sprite_F9214_End:
sprite_F9256:	binclude	"data/artunc/sprite_F9256.bin"
sprite_F9256_End:
sprite_F92D8:	binclude	"data/artunc/sprite_F92D8.bin"
sprite_F92D8_End:
sprite_F933A:	binclude	"data/artunc/sprite_F933A.bin"
sprite_F933A_End:
sprite_F94BC:	binclude	"data/artunc/sprite_F94BC.bin"
sprite_F94BC_End:
sprite_F951E:	binclude	"data/artunc/sprite_F951E.bin"
sprite_F951E_End:
sprite_F95E0:	binclude	"data/artunc/sprite_F95E0.bin"
sprite_F95E0_End:
sprite_F9762:	binclude	"data/artunc/sprite_F9762.bin"
sprite_F9762_End:
sprite_F9864:	binclude	"data/artunc/sprite_F9864.bin"
sprite_F9864_End:
sprite_F99E6:	binclude	"data/artunc/sprite_F99E6.bin"
sprite_F99E6_End:
sprite_F9A48:	binclude	"data/artunc/sprite_F9A48.bin"
sprite_F9A48_End:
sprite_F9B4A:	binclude	"data/artunc/sprite_F9B4A.bin"
sprite_F9B4A_End:
sprite_F9B6C:	binclude	"data/artunc/sprite_F9B6C.bin"
sprite_F9B6C_End:
sprite_F9B8E:	binclude	"data/artunc/sprite_F9B8E.bin"
sprite_F9B8E_End:
sprite_F9D10:	binclude	"data/artunc/sprite_F9D10.bin"
sprite_F9D10_End:
sprite_F9D72:	binclude	"data/artunc/sprite_F9D72.bin"
sprite_F9D72_End:
sprite_F9E34:	binclude	"data/artunc/sprite_F9E34.bin"
sprite_F9E34_End:
sprite_F9F56:	binclude	"data/artunc/sprite_F9F56.bin"
sprite_F9F56_End:
sprite_F9FB8:	binclude	"data/artunc/sprite_F9FB8.bin"
sprite_F9FB8_End:
sprite_F9FDA:	binclude	"data/artunc/sprite_F9FDA.bin"
sprite_F9FDA_End:
sprite_FA0DC:	binclude	"data/artunc/sprite_FA0DC.bin"
sprite_FA0DC_End:
sprite_FA0FE:	binclude	"data/artunc/sprite_FA0FE.bin"
sprite_FA0FE_End:
sprite_FA1C0:	binclude	"data/artunc/sprite_FA1C0.bin"
sprite_FA1C0_End:
sprite_FA202:	binclude	"data/artunc/sprite_FA202.bin"
sprite_FA202_End:
sprite_FA284:	binclude	"data/artunc/sprite_FA284.bin"
sprite_FA284_End:
sprite_FA2C6:	binclude	"data/artunc/sprite_FA2C6.bin"
sprite_FA2C6_End:
sprite_FA3C8:	binclude	"data/artunc/sprite_FA3C8.bin"
sprite_FA3C8_End:
sprite_FA3EA:	binclude	"data/artunc/sprite_FA3EA.bin"
sprite_FA3EA_End:
sprite_FA44C:	binclude	"data/artunc/sprite_FA44C.bin"
sprite_FA44C_End:
sprite_FA4CE:	binclude	"data/artunc/sprite_FA4CE.bin"
sprite_FA4CE_End:
sprite_FA5D0:	binclude	"data/artunc/sprite_FA5D0.bin"
sprite_FA5D0_End:
sprite_FA692:	binclude	"data/artunc/sprite_FA692.bin"
sprite_FA692_End:
sprite_FA754:	binclude	"data/artunc/sprite_FA754.bin"
sprite_FA754_End:
sprite_FA876:	binclude	"data/artunc/sprite_FA876.bin"
sprite_FA876_End:
sprite_FA8B8:	binclude	"data/artunc/sprite_FA8B8.bin"
sprite_FA8B8_End:
sprite_FA97A:	binclude	"data/artunc/sprite_FA97A.bin"
sprite_FA97A_End:
sprite_FAA9C:	binclude	"data/artunc/sprite_FAA9C.bin"
sprite_FAA9C_End:
sprite_FAABE:	binclude	"data/artunc/sprite_FAABE.bin"
sprite_FAABE_End:
sprite_FAB80:	binclude	"data/artunc/sprite_FAB80.bin"
sprite_FAB80_End:
sprite_FAD02:	binclude	"data/artunc/sprite_FAD02.bin"
sprite_FAD02_End:
sprite_FAD44:	binclude	"data/artunc/sprite_FAD44.bin"
sprite_FAD44_End:
sprite_FAE06:	binclude	"data/artunc/sprite_FAE06.bin"
sprite_FAE06_End:
sprite_FAF08:	binclude	"data/artunc/sprite_FAF08.bin"
sprite_FAF08_End:
sprite_FAF8A:	binclude	"data/artunc/sprite_FAF8A.bin"
sprite_FAF8A_End:
sprite_FAFEC:	binclude	"data/artunc/sprite_FAFEC.bin"
sprite_FAFEC_End:
sprite_FB0AE:	binclude	"data/artunc/sprite_FB0AE.bin"
sprite_FB0AE_End:
sprite_FB2B0:	binclude	"data/artunc/sprite_FB2B0.bin"
sprite_FB2B0_End:
sprite_FB2F2:	binclude	"data/artunc/sprite_FB2F2.bin"
sprite_FB2F2_End:
sprite_FB354:	binclude	"data/artunc/sprite_FB354.bin"
sprite_FB354_End:
sprite_FB376:	binclude	"data/artunc/sprite_FB376.bin"
sprite_FB376_End:
sprite_FB578:	binclude	"data/artunc/sprite_FB578.bin"
sprite_FB578_End:
sprite_FB5FA:	binclude	"data/artunc/sprite_FB5FA.bin"
sprite_FB5FA_End:
sprite_FB67C:	binclude	"data/artunc/sprite_FB67C.bin"
sprite_FB67C_End:
sprite_FB7FE:	binclude	"data/artunc/sprite_FB7FE.bin"
sprite_FB7FE_End:
sprite_FB840:	binclude	"data/artunc/sprite_FB840.bin"
sprite_FB840_End:
sprite_FB8A2:	binclude	"data/artunc/sprite_FB8A2.bin"
sprite_FB8A2_End:
sprite_FB8E4:	binclude	"data/artunc/sprite_FB8E4.bin"
sprite_FB8E4_End:
sprite_FB966:	binclude	"data/artunc/sprite_FB966.bin"
sprite_FB966_End:
sprite_FBAE8:	binclude	"data/artunc/sprite_FBAE8.bin"
sprite_FBAE8_End:
sprite_FBB2A:	binclude	"data/artunc/sprite_FBB2A.bin"
sprite_FBB2A_End:
sprite_FBCAC:	binclude	"data/artunc/sprite_FBCAC.bin"
sprite_FBCAC_End:
sprite_FBDAE:	binclude	"data/artunc/sprite_FBDAE.bin"
sprite_FBDAE_End:
sprite_FBDD0:	binclude	"data/artunc/sprite_FBDD0.bin"
sprite_FBDD0_End:
sprite_FBE32:	binclude	"data/artunc/sprite_FBE32.bin"
sprite_FBE32_End:
sprite_FBEB4:	binclude	"data/artunc/sprite_FBEB4.bin"
sprite_FBEB4_End:
sprite_FBEF6:	binclude	"data/artunc/sprite_FBEF6.bin"
sprite_FBEF6_End:
sprite_FBFF8:	binclude	"data/artunc/sprite_FBFF8.bin"
sprite_FBFF8_End:
sprite_FC0BA:	binclude	"data/artunc/sprite_FC0BA.bin"
sprite_FC0BA_End:
sprite_FC23C:	binclude	"data/artunc/sprite_FC23C.bin"
sprite_FC23C_End:
sprite_FC3BE:	binclude	"data/artunc/sprite_FC3BE.bin"
sprite_FC3BE_End:
sprite_FC480:	binclude	"data/artunc/sprite_FC480.bin"
sprite_FC480_End:
sprite_FC4A2:	binclude	"data/artunc/sprite_FC4A2.bin"
sprite_FC4A2_End:
sprite_FC5A4:	binclude	"data/artunc/sprite_FC5A4.bin"
sprite_FC5A4_End:
sprite_FC6A6:	binclude	"data/artunc/sprite_FC6A6.bin"
sprite_FC6A6_End:
sprite_FC728:	binclude	"data/artunc/sprite_FC728.bin"
sprite_FC728_End:
sprite_FC7AA:	binclude	"data/artunc/sprite_FC7AA.bin"
sprite_FC7AA_End:
sprite_FC82E:	binclude	"data/artunc/sprite_FC82E.bin"
sprite_FC82E_End:
sprite_FC8F0:	binclude	"data/artunc/sprite_FC8F0.bin"
sprite_FC8F0_End:
sprite_FC912:	binclude	"data/artunc/sprite_FC912.bin"
sprite_FC912_End:
sprite_FCA94:	binclude	"data/artunc/sprite_FCA94.bin"
sprite_FCA94_End:
sprite_FCBB6:	binclude	"data/artunc/sprite_FCBB6.bin"
sprite_FCBB6_End:
sprite_FCD38:	binclude	"data/artunc/sprite_FCD38.bin"
sprite_FCD38_End:
sprite_FCD7A:	binclude	"data/artunc/sprite_FCD7A.bin"
sprite_FCD7A_End:
sprite_FCE3C:	binclude	"data/artunc/sprite_FCE3C.bin"
sprite_FCE3C_End:
sprite_FCEBE:	binclude	"data/artunc/sprite_FCEBE.bin"
sprite_FCEBE_End:
sprite_FCF40:	binclude	"data/artunc/sprite_FCF40.bin"
sprite_FCF40_End:
sprite_FCFC2:	binclude	"data/artunc/sprite_FCFC2.bin"
sprite_FCFC2_End:
sprite_FD0C4:	binclude	"data/artunc/sprite_FD0C4.bin"
sprite_FD0C4_End:
sprite_FD186:	binclude	"data/artunc/sprite_FD186.bin"
sprite_FD186_End:
sprite_FD1E8:	binclude	"data/artunc/sprite_FD1E8.bin"
sprite_FD1E8_End:
sprite_FD26A:	binclude	"data/artunc/sprite_FD26A.bin"
sprite_FD26A_End:
sprite_FD2EC:	binclude	"data/artunc/sprite_FD2EC.bin"
sprite_FD2EC_End:
sprite_FD30E:	binclude	"data/artunc/sprite_FD30E.bin"
sprite_FD30E_End:
sprite_FD62E:	binclude	"data/artunc/sprite_FD62E.bin"
sprite_FD62E_End:
sprite_FD86E:	binclude	"data/artunc/sprite_FD86E.bin"
sprite_FD86E_End:
sprite_FDB8E:	binclude	"data/artunc/sprite_FDB8E.bin"
sprite_FDB8E_End:
sprite_FDC0E:	binclude	"data/artunc/sprite_FDC0E.bin"
sprite_FDC0E_End:
sprite_FDC8E:	binclude	"data/artunc/sprite_FDC8E.bin"
sprite_FDC8E_End:
sprite_FDD0E:	binclude	"data/artunc/sprite_FDD0E.bin"
sprite_FDD0E_End:
sprite_FDD8E:	binclude	"data/artunc/sprite_FDD8E.bin"
sprite_FDD8E_End:
sprite_FDE0E:	binclude	"data/artunc/sprite_FDE0E.bin"
sprite_FDE0E_End:
sprite_FDE8E:	binclude	"data/artunc/sprite_FDE8E.bin"
sprite_FDE8E_End:
sprite_FDF0E:	binclude	"data/artunc/sprite_FDF0E.bin"
sprite_FDF0E_End:
sprite_FDF8E:	binclude	"data/artunc/sprite_FDF8E.bin"
sprite_FDF8E_End:
sprite_FE00E:	binclude	"data/artunc/sprite_FE00E.bin"
sprite_FE00E_End:
sprite_FE08E:	binclude	"data/artunc/sprite_FE08E.bin"
sprite_FE08E_End:
sprite_FE10E:	binclude	"data/artunc/sprite_FE10E.bin"
sprite_FE10E_End:
sprite_FE18E:	binclude	"data/artunc/sprite_FE18E.bin"
sprite_FE18E_End:
sprite_FE20E:	binclude	"data/artunc/sprite_FE20E.bin"
sprite_FE20E_End:
sprite_FE28E:	binclude	"data/artunc/sprite_FE28E.bin"
sprite_FE28E_End:
sprite_FE30E:	binclude	"data/artunc/sprite_FE30E.bin"
sprite_FE30E_End:
sprite_FE38E:	binclude	"data/artunc/sprite_FE38E.bin"
sprite_FE38E_End:
sprite_FE40E:	binclude	"data/artunc/sprite_FE40E.bin"
sprite_FE40E_End:
sprite_FE48E:	binclude	"data/artunc/sprite_FE48E.bin"
sprite_FE48E_End:
sprite_FE50E:	binclude	"data/artunc/sprite_FE50E.bin"
sprite_FE50E_End:
sprite_FE58E:	binclude	"data/artunc/sprite_FE58E.bin"
sprite_FE58E_End:
sprite_FE60E:	binclude	"data/artunc/sprite_FE60E.bin"
sprite_FE60E_End:
sprite_FE68E:	binclude	"data/artunc/sprite_FE68E.bin"
sprite_FE68E_End:
sprite_FE70E:	binclude	"data/artunc/sprite_FE70E.bin"
sprite_FE70E_End:
sprite_FE78E:	binclude	"data/artunc/sprite_FE78E.bin"
sprite_FE78E_End:
tiles_FEB6E:	binclude	"data/artcomp/tiles_0FEB6E.bin"
tiles_FEB6E_End:
tiles_1001D6:	binclude	"data/artcomp/tiles_1001D6.bin"
tiles_1001D6_End:
tiles_100DA2:	binclude	"data/artcomp/tiles_100DA2.bin"
tiles_100DA2_End:
tiles_1018F0:	binclude	"data/artcomp/tiles_1018F0.bin"
tiles_1018F0_End:
tiles_10213C:	binclude	"data/artcomp/tiles_10213C.bin"
tiles_10213C_End:
tiles_102AE0:	binclude	"data/artcomp/tiles_102AE0.bin"
tiles_102AE0_End:
tiles_103124:	binclude	"data/artcomp/tiles_103124.bin"
tiles_103124_End:
tiles_103A26:	binclude	"data/artcomp/tiles_103A26.bin"
tiles_103A26_End:
tiles_104310:	binclude	"data/artcomp/tiles_104310.bin"
tiles_104310_End:
tiles_104784:	binclude	"data/artcomp/tiles_104784.bin"
tiles_104784_End:
tiles_104B22:	binclude	"data/artcomp/tiles_104B22.bin"
tiles_104B22_End:
tiles_105196:	binclude	"data/artcomp/tiles_105196.bin"
tiles_105196_End:
tiles_1067C2:	binclude	"data/artcomp/tiles_1067C2.bin"
tiles_1067C2_End:
tiles_1081AA:	binclude	"data/artcomp/tiles_1081AA.bin"
tiles_1081AA_End:
tiles_109546:	binclude	"data/artcomp/tiles_109546.bin"
tiles_109546_End:
tiles_10B9FE:	binclude	"data/artcomp/tiles_10B9FE.bin"
tiles_10B9FE_End:
tiles_10DA6C:	binclude	"data/artcomp/tiles_10DA6C.bin"
tiles_10DA6C_End:
tiles_10F51C:	binclude	"data/artcomp/tiles_10F51C.bin"
tiles_10F51C_End:
tiles_10F840:	binclude	"data/artcomp/tiles_10F840.bin"
tiles_10F840_End:
tiles_112288:	binclude	"data/artcomp/tiles_112288.bin"
tiles_112288_End:
tiles_113934:	binclude	"data/artcomp/tiles_113934.bin"
tiles_113934_End:
tiles_114DF8:	binclude	"data/artcomp/tiles_114DF8.bin"
tiles_114DF8_End:
tiles_1163AE:	binclude	"data/artcomp/tiles_1163AE.bin"
tiles_1163AE_End:
tiles_116C9C:	binclude	"data/artcomp/tiles_116C9C.bin"
tiles_116C9C_End:
tiles_1195BA:	binclude	"data/artcomp/tiles_1195BA.bin"
tiles_1195BA_End:
word_1198D2:    dc.w $4818, $300, $F3EB ; DATA XREF: Cutscene_XiTigerInit+10   o
                dc.w $4810, $D00, $3F3
                dc.w $C800, $F00, $E3F3
tiles_1198E4:	binclude	"data/artcomp/tiles_1198E4.bin"
tiles_1198E4_End:
byte_11A61A:    dc.b 0, $27, $31, 0, 1, $12, $13, $84, $14, $12, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24, $25, $26, $20, 1, 2
                                        ; DATA XREF: ROM:0001E8B4   o
                dc.b $27, $28, $29, $84, $2F, $80, 7, $A4, $34, $FF
byte_11A644:	binclude	"data/mappings/byte_11A644.bin"
byte_11A644_End:
tiles_11A8FC:	binclude	"data/artcomp/tiles_11A8FC.bin"	; UNUSED: Love Penguin boss graphics
                                        ; Referenced by: stru_11542 (Boss ID $01C0)
                                        ; See line 20999 for boss structure
tiles_11A8FC_End:
tiles_11B542:	binclude	"data/artcomp/tiles_11B542.bin"
tiles_11B542_End:
tiles_11D002:	binclude	"data/artcomp/tiles_11D002.bin"
tiles_11D002_End:
tiles_11E5E0:	binclude	"data/artcomp/tiles_11E5E0.bin"
tiles_11E5E0_End:
tiles_11F310:	binclude	"data/artcomp/tiles_11F310.bin"
tiles_11F310_End:
tiles_120E1C:	binclude	"data/artcomp/tiles_120E1C.bin"
tiles_120E1C_End:
tiles_120FF8:	binclude	"data/artcomp/tiles_120FF8.bin"
tiles_120FF8_End:
tiles_121932:	binclude	"data/artcomp/tiles_121932.bin"
tiles_121932_End:
tiles_1233B4:	binclude	"data/artcomp/tiles_1233B4.bin"
tiles_1233B4_End:
tiles_12453E:	binclude	"data/artcomp/tiles_12453E.bin"
tiles_12453E_End:
tiles_124CCE:	binclude	"data/artcomp/tiles_124CCE.bin"
tiles_124CCE_End:
tiles_125902:	binclude	"data/artcomp/tiles_125902.bin"	; UNUSED: Lambda Bunny boss graphics
                                        ; Referenced by: stru_115B2 (Boss ID $03EC)
                                        ; See stru_115A8 for complete boss structure (line 21055)
tiles_125902_End:
tiles_12772E:	binclude	"data/artcomp/tiles_12772E.bin"	; UNUSED: Unknown boss $3F0 graphics
                                        ; Referenced by: stru_115CE (Boss ID $3F0)
                                        ; See stru_115C4 for complete boss structure (line 21076)
tiles_12772E_End:
tiles_12AB8C:	binclude	"data/artcomp/tiles_12AB8C.bin"
tiles_12AB8C_End:
tiles_12D012:	binclude	"data/artcomp/tiles_12D012.bin"	; UNUSED: Dragon boss graphics
                                        ; Referenced by: Boss ID $03FC (line 21104)
tiles_12D012_End:
tiles_12E96C:	binclude	"data/artcomp/tiles_12E96C.bin"	; UNUSED: Unknown boss $3F4 graphics
                                        ; Referenced by: stru_115EA (Boss ID $3F4)
                                        ; See stru_115E0 for complete boss structure (line 21120)
                                        ; Possibly Praying Mantis or Sigma Fox
tiles_12E96C_End:
tiles_130B4E:	binclude	"data/artcomp/tiles_130B4E.bin"
tiles_130B4E_End:
tiles_132E9A:	binclude	"data/artcomp/tiles_132E9A.bin"
tiles_132E9A_End:
tiles_1338F2:	binclude	"data/artcomp/tiles_1338F2.bin"
tiles_1338F2_End:
tiles_134F02:	binclude	"data/artcomp/tiles_134F02.bin"
tiles_134F02_End:
tiles_1355D6:	binclude	"data/artcomp/tiles_1355D6.bin"
tiles_1355D6_End:
tiles_136512:	binclude	"data/artcomp/tiles_136512.bin"
tiles_136512_End:
tiles_13963E:	binclude	"data/artcomp/tiles_13963E.bin"
tiles_13963E_End:
tiles_13A92A:	binclude	"data/artcomp/tiles_13A92A.bin"
tiles_13A92A_End:
tiles_13C166:	binclude	"data/artcomp/tiles_13C166.bin"
tiles_13C166_End:
byte_13F4B0:	binclude	"data/mappings/byte_13F4B0.bin"
byte_13F4B0_End:
byte_1402E2:	binclude	"data/mappings/byte_1402E2.bin"
byte_1402E2_End:
byte_140B0C:    dc.b 0, $89, 5, 4, 5, 6, 7, $14, $15, $20, $16, 7, 8, 9, $A, $B, $18, $19, $1A, $1B, $21, 0, 2, 3, $23, 2, $53, 0, 0, 3, $C, $D
                                        ; DATA XREF: ROM:00011916   o
                dc.b $24, $25, $40, $C, $D, 3, $10, $11, $28, $29, $40, $E, $F, $40, 1, $17, $40, $12, $13, $52, 0, 0, $88, $3F, $40, $24, $25, $80, $3B, $41, $28, $29
                dc.b $80, $3B, $41, 1, $17, $52, 0, 0, $90, $7F, $90, $3F, $88, $43, $88, $3F, $88, $43, $52, 0, 0, $FC, $3F, $FC, $FF, $98, $BF, 1, $2A, $2B, $81, 1
                dc.b $80, 3, $88, $FB, $89, 1, $52, 0, 0, $42, $24, $25, $88, $3B, $40, $2A, $2B, $91, $3D, $FD, $3F, $A1, $7F, 3, $1C, $1D, $1E, $1F, $85, $B4, 3, $10
                dc.b $20, $21, $22, $89, $B5, 1, 1, $2C, $55, 0, 0, $FF
byte_140B98:	binclude	"data/mappings/byte_140B98.bin"
byte_140B98_End:
byte_140F00:	binclude	"data/mappings/byte_140F00.bin"
byte_140F00_End:
byte_141018:	binclude	"data/mappings/byte_141018.bin"
byte_141018_End:
font_japanese_tiles:	binclude	"data/artunc/font_japanese.bin"
font_japanese_tiles_End:
font_japanese_mappings:	binclude	"data/mappings/font_japanese.bin"
font_japanese_mappings_End:
byte_14ADEE:    dc.b 0, $18, $5F, $33, $33, $5F, $33, $33, $5F, $33, $33, $5F, $33, $33, $5F, $33, $33, $5F, $33, $33, $5F, $33, $33, $57, $33, $33
                                        ; DATA XREF: ROM:00020B52   o
                                        ; ROM:stru_2158C   o
tiles_14AE08:	binclude	"data/artcomp/tiles_14AE08.bin"
tiles_14AE08_End:
byte_14B91C:	binclude	"data/mappings/byte_14B91C.bin"
byte_14B91C_End:
tiles_14BB82:	binclude	"data/artcomp/tiles_14BB82.bin"
tiles_14BB82_End:
byte_14D064:	binclude	"data/mappings/byte_14D064.bin"
byte_14D064_End:
tiles_14D272:	binclude	"data/artcomp/tiles_14D272.bin"
tiles_14D272_End:
byte_14F2B6:	binclude	"data/mappings/byte_14F2B6.bin"
byte_14F2B6_End:
tiles_14F542:	binclude	"data/artcomp/tiles_14F542.bin"
tiles_14F542_End:
byte_14FD6A:	binclude	"data/mappings/byte_14FD6A.bin"
byte_14FD6A_End:
tiles_14FF06:	binclude	"data/artcomp/tiles_14FF06.bin"
tiles_14FF06_End:
byte_150D1C:	binclude	"data/mappings/byte_150D1C.bin"
byte_150D1C_End:
tiles_150EC8:	binclude	"data/artcomp/tiles_150EC8.bin"
tiles_150EC8_End:
byte_151CDE:	binclude	"data/mappings/byte_151CDE.bin"
byte_151CDE_End:
tiles_151F30:	binclude	"data/artcomp/tiles_151F30.bin"
tiles_151F30_End:
byte_152D60:	binclude	"data/mappings/byte_152D60.bin"
byte_152D60_End:
tiles_152FC4:	binclude	"data/artcomp/tiles_152FC4.bin"
tiles_152FC4_End:
byte_15389A:	binclude	"data/mappings/byte_15389A.bin"
byte_15389A_End:
tiles_153B34:	binclude	"data/artcomp/tiles_153B34.bin"
tiles_153B34_End:
byte_1543E0:	binclude	"data/mappings/byte_1543E0.bin"
byte_1543E0_End:
tiles_1545E4:	binclude	"data/artcomp/tiles_1545E4.bin"
tiles_1545E4_End:
byte_1557D6:	binclude	"data/mappings/byte_1557D6.bin"
byte_1557D6_End:
tiles_1559BE:	binclude	"data/artcomp/tiles_1559BE.bin"
tiles_1559BE_End:
byte_157036:	binclude	"data/mappings/byte_157036.bin"
byte_157036_End:
tiles_1571FE:	binclude	"data/artcomp/tiles_1571FE.bin"
tiles_1571FE_End:
byte_158674:	binclude	"data/mappings/byte_158674.bin"
byte_158674_End:
tiles_158854:	binclude	"data/artcomp/tiles_158854.bin"
tiles_158854_End:
byte_159440:	binclude	"data/mappings/byte_159440.bin"
byte_159440_End:
tiles_15960E:	binclude	"data/artcomp/tiles_15960E.bin"
tiles_15960E_End:
byte_15B086:	binclude	"data/mappings/byte_15B086.bin"
byte_15B086_End:
tiles_15B2B6:	binclude	"data/artcomp/tiles_15B2B6.bin"
tiles_15B2B6_End:
byte_15C020:	binclude	"data/mappings/byte_15C020.bin"
byte_15C020_End:
tiles_15C24E:	binclude	"data/artcomp/tiles_15C24E.bin"
tiles_15C24E_End:
byte_15D00A:	binclude	"data/mappings/byte_15D00A.bin"
byte_15D00A_End:
tiles_15D13E:	binclude	"data/artcomp/tiles_15D13E.bin"
tiles_15D13E_End:
byte_15E960:	binclude	"data/mappings/byte_15E960.bin"
byte_15E960_End:
tiles_15EB98:	binclude	"data/artcomp/tiles_15EB98.bin"
tiles_15EB98_End:
byte_15FF52:	binclude	"data/mappings/byte_15FF52.bin"
byte_15FF52_End:
tiles_160124:	binclude	"data/artcomp/tiles_160124.bin"
tiles_160124_End:
byte_16114A:	binclude	"data/mappings/byte_16114A.bin"
byte_16114A_End:
tiles_161336:	binclude	"data/artcomp/tiles_161336.bin"
tiles_161336_End:
byte_163A32:	binclude	"data/mappings/byte_163A32.bin"
byte_163A32_End:
tiles_163E1E:	binclude	"data/artcomp/tiles_163E1E.bin"
tiles_163E1E_End:
byte_16494A:	binclude	"data/mappings/byte_16494A.bin"
byte_16494A_End:
tiles_164ADA:	binclude	"data/artcomp/tiles_164ADA.bin"
tiles_164ADA_End:
byte_164E24:    dc.b 0, $DC, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0
                                        ; DATA XREF: ROM:000219F6   o
                dc.b $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $FF, $DD, 0, 0, $50, 0, 0, $62, $64, 1, 2, 3, 4, $5F, 0, 0, $57
                dc.b 0, 0, $66, $64, 5, 6, 7, 8, 9, $A, $B, $C, $5F, 0, 0, $54, 0, 0, $68, $64, $D, $E, $F, $10, $11, $12, $13, $14, $15, $16, $5F, 0
                dc.b 0, $53, 0, 0, $68, $64, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $5F, 0, 0, $55, 0, 0, $64, $64, $21, $22, $23, $24, $25, $26, $5F, 0
                dc.b 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $8B, $FB, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0
                dc.b 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F
                dc.b 0, 0, $FF, $DD, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $57, 0, 0
tiles_164F02:	binclude	"data/artcomp/tiles_164F02.bin"
tiles_164F02_End:
byte_16537C:    dc.b 0, $4A, $6A, $60, $40, $44, $48, $4C, $50, $54, $58, $5C, $60, $64, $68, $6C, $5F, 0, 0, $51, 0, 0, $6A, $60, $41, $45, $49, $4D, $51, $55, $59, $5D
                                        ; DATA XREF: ROM:00021A28   o
                dc.b $61, $65, $69, $6D, $5F, 0, 0, $51, 0, 0, $6A, $60, $42, $46, $4A, $4E, $52, $56, $5A, $5E, $62, $66, $6A, $6E, $5F, 0, 0, $51, 0, 0, $6A, $60
                dc.b $43, $47, $4B, $4F, $53, $57, $5B, $5F, $63, $67, $6B, $6F
                ;dc.b [$1AC38]$FF
                org $180000
