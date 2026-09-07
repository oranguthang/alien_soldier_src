Data_Copy32Bytes:                                       ; CODE XREF: Stage_InitializeCreditsScreen+1C   p  ; was: sub_214B6
                                        ; Stage_LoadCreditsDataPhase+18   p
                move.l  (a0)+,(a1)+
                move.l  (a0)+,(a1)+
                move.l  (a0)+,(a1)+
                move.l  (a0)+,(a1)+
                move.l  (a0)+,(a1)+
                move.l  (a0)+,(a1)+
                move.l  (a0)+,(a1)+
                move.l  (a0)+,(a1)+
                rts
; End of function Data_Copy32Bytes
; ---------------------------------------------------------------------------
off_214C8:      dc.l    word_2165E                      ; DATA XREF: Stage_InitializeCreditsScreen+BE   o
                dc.l    stru_2167E
                dc.l    word_216C2
                dc.l    stru_216E2
                dc.l    word_216F4
                dc.l    stru_21714
                dc.l    word_21758
                dc.l    stru_21778
                dc.l    word_2162C
                dc.l    stru_2164C
                dc.l    word_21596
                dc.l    stru_215B6
                dc.l    word_215C8
                dc.l    stru_215E8
                dc.l    word_2178A
                dc.l    stru_217AA
                dc.l    word_21690
                dc.l    stru_216B0
                dc.l    word_21726
                dc.l    stru_21746
                dc.l    word_217BC
                dc.l    stru_217DC
                dc.l    word_217EE
                dc.l    stru_2180E
                dc.l    word_21820
                dc.l    stru_21840
                dc.l    word_215FA
                dc.l    stru_2161A
                dc.l    word_21852
                dc.l    stru_21872
                dc.l    word_21884
                dc.l    stru_218A4
                dc.l    word_218B6
                dc.l    stru_218D6
                dc.l    word_218E8
                dc.l    stru_21908
                dc.l    word_2191A
                dc.l    stru_2193A
                dc.l    word_2194C
                dc.l    stru_2196C
                dc.l    $FFFFFFFF
word_2156C:     dc.w    0, 0, $EEE, $EE, $AE, $6E, $E, 4, $48, $C88, $EAA, $ECC, $EEE, $600, $840, $C84
                                        ; DATA XREF: Stage_InitializeCreditsScreen+12   o
stru_2158C:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_InitializeCreditsScreen+6   o
                dc.l    byte_14ADEE                     ; field_2
                dc.w    $B000                           ; field_6
                dc.w    $FFFF
word_21596:     dc.w    0, $202, $404, $626, $848, $A6A, $EEE, $C8C, $EAE, $22, $EEE, $46, $28A, $6CE, $E, 0
                                        ; DATA XREF: ROM:000214F0   o
stru_215B6:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:000214F4   o
                dc.l    tiles_14AE08                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_14B91C                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_215C8:     dc.w    0, 0, $EEE, $ECC, $AA8, $884, $EEE, $206, $42C, $A8E, $440, $28A, $6CC, $224, $248, $68C
                                        ; DATA XREF: ROM:000214F8   o
stru_215E8:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:000214FC   o
                dc.l    tiles_14BB82                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_14D064                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    $FFFF
word_215FA:     dc.w    0, 0, $EEE, $FFFF, $FFFF, $FFFF, $FFFF, $CCA, $AA6, $A64, $642, $46E, $2A, 6, $2AC, $46
                                        ; DATA XREF: ROM:00021530   o
stru_2161A:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:00021534   o
                dc.l    tiles_14D272                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_14F2B6                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_2162C:     dc.w    0, 0, $EEE, $ECC, $EAA, $E88, $FFFF, $422, $644, $C68, $206, $42C, $88E, $42, $284, $2CA
                                        ; DATA XREF: ROM:000214E8   o
stru_2164C:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:000214EC   o
                dc.l    tiles_14F542                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_14FD6A                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    $FFFF
word_2165E:     dc.w    0, 0, $EEE, $ECC, $CAA, $A88, $FFFF, 4, $26, $4A, $6C, $2AE, $222, $444, $2A, $46E
                                        ; DATA XREF: ROM:off_214C8   o
stru_2167E:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:000214CC   o
                dc.l    tiles_14FF06                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_150D1C                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    $FFFF
word_21690:     dc.w    0, 0, $EEE, $ECC, $EAA, $E88, $FFFF, $204, $208, $20C, $44E, $88E, $24, $46, $6A, $2AE
                                        ; DATA XREF: ROM:00021508   o
stru_216B0:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:0002150C   o
                dc.l    tiles_150EC8                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_151CDE                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    $FFFF
word_216C2:     dc.w    0, $200, $CEE, $226, $88A, $24, $FFFF, $46, $28A, $6CE, $4C, 8, 4, $FFFF, $668, $AAC
                                        ; DATA XREF: ROM:000214D0   o
stru_216E2:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:000214D4   o
                dc.l    tiles_151F30                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_152D60                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_216F4:     dc.w    0, 0, $EEE, $6E4, $80, $28, $FFFF, $6C, $AE, $422, $446, $488, $8CC, 6, $20C, $66E
                                        ; DATA XREF: ROM:000214D8   o
stru_21714:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:000214DC   o
                dc.l    tiles_152FC4                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_15389A                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    $FFFF
word_21726:     dc.w    0, 0, $EEE, $6E4, $80, $28, $FFFF, $6C, $AE, $422, $446, $488, $8CC, 6, $20C, $66E
                                        ; DATA XREF: ROM:00021510   o
stru_21746:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:00021514   o
                dc.l    tiles_153B34                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_1543E0                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_21758:     dc.w    0, 0, $EEE, $6AC, $48A, $268, $FFFF, $246, $24, $206, $22A, $26C, 0, $202, $624, $868
                                        ; DATA XREF: ROM:000214E0   o
stru_21778:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:000214E4   o
                dc.l    tiles_1545E4                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_1557D6                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_2178A:     dc.w    0, 0, $EEE, $FFFF, $FFFF, $FFFF, $FFFF, $8C, $6A, $48, $26, $46E, $2A, 6, $888, $444
                                        ; DATA XREF: ROM:00021500   o
stru_217AA:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:00021504   o
                dc.l    tiles_1559BE                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_157036                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_217BC:     dc.w    0, 0, $EEE, $ECC, $EAA, $E88, $FFFF, $E02, $420, $A44, 6, $2A, $46E, $24, $268, $4AC
                                        ; DATA XREF: ROM:00021518   o
stru_217DC:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:0002151C   o
                dc.l    tiles_1571FE                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_158674                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    $FFFF
word_217EE:     dc.w    0, 0, $EEE, $ECC, $EAA, $E88, $FFFF, 6, $2A, $46E, $22, $244, $288, $26, $48, $8C
                                        ; DATA XREF: ROM:00021520   o
stru_2180E:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:00021524   o
                dc.l    tiles_158854                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_159440                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_21820:     dc.w    0, 0, $EEE, $ECC, $A88, $866, $FFFF, $644, $422, $26, $4A, $8E, $400, $A42, $E86, 8
                                        ; DATA XREF: ROM:00021528   o
stru_21840:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:0002152C   o
                dc.l    tiles_15960E                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_15B086                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    $FFFF
word_21852:     dc.w    0, $204, $EEE, $ACA, $466, $44, $EEE, $2CE, $8C, $8E, $4C, $2A, $208, $68, $6AE, $AEE
                                        ; DATA XREF: ROM:00021538   o
stru_21872:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:0002153C   o
                dc.l    tiles_15B2B6                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_15C020                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    $FFFF
word_21884:     dc.w    0, $600, $EEE, $666, $444, $442, $EEE, $AAA, $866, $E48, $C26, $A24, $802, $26, $8C, $EAC
                                        ; DATA XREF: ROM:00021540   o
stru_218A4:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:00021544   o
                dc.l    tiles_15C24E                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_15D00A                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_218B6:     dc.w    0, $220, $EEE, $28C, $46, $242, $EEE, $C8, $84, $4C6, $284, $62, $42, $40, $6C, $4EA
                                        ; DATA XREF: ROM:00021548   o
stru_218D6:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:0002154C   o
                dc.l    tiles_15D13E                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_15E960                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    $FFFF
word_218E8:     dc.w    0, $402, $EEE, $66C, $448, $224, $EEE, $A8A, $668, $CCA, $A88, $866, $222, $28, $6E, $CCC
                                        ; DATA XREF: ROM:00021550   o
stru_21908:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:00021554   o
                dc.l    tiles_15EB98                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_15FF52                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_2191A:     dc.w    0, $202, $EEE, $6EE, $28A, $222, $EEE, $EA8, $A64, $EA8, $E62, $C22, $802, $402, $484, $EEC
                                        ; DATA XREF: ROM:00021558   o
stru_2193A:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:0002155C   o
                dc.l    tiles_160124                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_16114A                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    $FFFF
word_2194C:     dc.w    0, 0, $EEE, $E88, $844, $422, 0, $200, 2, 4, $24, $46, $268, $4AC, $6CE, $AE
                                        ; DATA XREF: ROM:00021560   o
stru_2196C:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:00021564   o
                dc.l    tiles_161336                    ; field_2
                dc.w    $2000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_163A32                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_2197E:     dc.w    0, $EEE, $EEC, $ECA, $CA8, $A86, $864, $642, $420, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE
                                        ; DATA XREF: Credits_TreasureScreen2+5E   o
                dc.w    0, $200, $400, $600, $802, $A04, $C06, $E08, $E2A, $E4C, $E6E, $E8E, $EAE, $ECE, $EEE, $EEE
                dc.w    0, $EEE, $EEE, 2, 4, 6, $28, $4A, $6C, $8E, $AE, $CE, $2EE, $6EE, $AEE, $EEE
stru_219DE:     dc.w    7                               ; field_0
                                        ; DATA XREF: Credits_TreasureScreen2+74   o
                dc.l    tiles_163E1E                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_164ADA                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_16494A                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_164E24                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF
word_21A00:     dc.w    0, $EEE, $EC0, $EA0, $E80, $E60, $E40, $E20, $E00, $C00, $A00, $800, $E00, $E00, $E00, $EEE
                                        ; DATA XREF: Credits_SegaScreen+98   o
stru_21A20:     dc.w    7                               ; field_0
                                        ; DATA XREF: Credits_SegaScreen+A6   o
                dc.l    tiles_164F02                    ; field_2
                dc.w    $800                            ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_16537C                     ; field_2
                dc.w    $C61C                           ; field_6
                dc.w    $FFFF
word_21A32:     dc.w    $580, $F0F, $A0F0               ; DATA XREF: Credits_InitXiTiger+122   o
                                        ; Credits_InitXiTiger+158   o
                dc.w    $580, $F0F, $C0F0
                dc.w    $580, $F0F, $E0F0
                dc.w    $580, $F0F, $F0
                dc.w    $580, $F0F, $20F0
                dc.w    $580, $F0F, $40F0
                dc.w    $8580, $F0F, $60F0

; Dispatcher for selection menu state machine
