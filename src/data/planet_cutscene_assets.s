word_189D38:    dc.w    $2880, $F00, $C0                ; DATA XREF: Cutscene_SetupFirstPlanetGrid+18   o
                dc.w    $2870, $F00, $E0
                dc.w    $2860, $F00, 0
                dc.w    $2850, $F00, $20
                dc.w    $2840, $F00, $E0C0
                dc.w    $2830, $F00, $E0E0
                dc.w    $2820, $F00, $E000
                dc.w    $A810, $F00, $E020
word_189D68:    dc.w    $28C0, $400, $AF0               ; DATA XREF: Cutscene_SetupStarRows+18   o
                                        ; Cutscene_SetupStarRows+48   o
                dc.w    $28BC, $C00, $A00
                dc.w    $28B8, $C00, $A20
                dc.w    $28B0, $700, $EAF0
                dc.w    $28A0, $F00, $EA00
                dc.w    $A890, $F00, $EA20
word_189D8C:    dc.w    $2880, $F00, $C0                ; DATA XREF: Cutscene_SetupFirstShipGrid+18   o
                dc.w    $2870, $F00, $E0
                dc.w    $2860, $F00, 0
                dc.w    $2850, $F00, $20
                dc.w    $2840, $F00, $E0C0
                dc.w    $2830, $F00, $E0E0
                dc.w    $2820, $F00, $E000
                dc.w    $A810, $F00, $E020
word_189DBC:    dc.w    $2880, $F00, $20E0              ; DATA XREF: Cutscene_SetupSecondPlanetGrid+20   o
                dc.w    $2870, $F00, $E0
                dc.w    $2860, $F00, $E0E0
                dc.w    $2850, $F00, $C0E0
                dc.w    $2840, $F00, $2000
                dc.w    $2830, $F00, 0
                dc.w    $2820, $F00, $E000
                dc.w    $A810, $F00, $C000
word_189DEC:    dc.w    $2810, $F00, $20E0              ; DATA XREF: Cutscene_SetupSecondShipGrid+20   o
                dc.w    $2820, $F00, $E0
                dc.w    $2830, $F00, $E0E0
                dc.w    $2840, $F00, $C0E0
                dc.w    $2850, $F00, $2000
                dc.w    $2860, $F00, 0
                dc.w    $2870, $F00, $E000
                dc.w    $A880, $F00, $C000
                dc.w    $2880, $F00, $C0
                dc.w    $2870, $F00, $E0
                dc.w    $2860, $F00, 0
                dc.w    $2850, $F00, $20
                dc.w    $2840, $F00, $E0C0
                dc.w    $2830, $F00, $E0E0
                dc.w    $2820, $F00, $E000
                dc.w    $A810, $F00, $E020
tiles_189E4C:   binclude "data/artcomp/tiles_189E4C.bin"
tiles_189E4C_End:
word_18B04A:    dc.w    $873, 0, $734                   ; DATA XREF: Cutscene_InitPlanetScene+EA   o
                dc.w    $800, $900, $BFF4
                dc.w    $8E5, $100, $1742
                dc.w    $826, $F00, $CFCC
                dc.w    $8DF, $600, $2FC2
                dc.w    $8D3, $B00, $2FDC
                dc.w    $8C3, $F00, $2FF4
                dc.w    $8BB, $D00, $2F15
                dc.w    $8B8, $200, $17AA
                dc.w    $8A4, $300, $FDA
                dc.w    $8A8, $F00, $FB2
                dc.w    $884, $F00, $F02
                dc.w    $894, $F00, $FE2
                dc.w    $874, $F00, $F22
                dc.w    $85E, $F00, $EFD2
                dc.w    $836, $700, $CFC2
                dc.w    $86E, $300, $EFCA
                dc.w    $872, 0, $FFC2
                dc.w    $84E, $F00, $EFF2
                dc.w    $83E, $F00, $EF12
                dc.w    $816, $F00, $CFEA
                dc.w    $8806, $F00, $CF0A
word_18B0CE:    dc.w    $291B, 0, $AEB                  ; DATA XREF: Cutscene_InitPlanetScene+B6   o
                dc.w    $2900, $700, $F2E3
                dc.w    $28F8, $D00, $E2DB
                dc.w    $28F7, 0, $EAFB
                dc.w    $2918, $200, $1AEB
                dc.w    $2908, $F00, $12F3
                dc.w    $A8E7, $F00, $F2F3
word_18B0F8:    dc.w    $891C, 0, $FCFC                 ; DATA XREF: ROM:off_18B11C   o
                                        ; ROM:0018B124   o
word_18B0FE:    dc.w    $891D, 0, $FCFC                 ; DATA XREF: ROM:0018B120   o
                                        ; ROM:0018B128   o
word_18B104:    dc.w    $891E, 0, $FCFC                 ; DATA XREF: ROM:0018B134   o
                                        ; ROM:0018B138   o
word_18B10A:    dc.w    $891F, $500, $F8F8              ; DATA XREF: ROM:off_18B13C   o
word_18B110:    dc.w    $8923, $500, $F8F8              ; DATA XREF: ROM:0018B140   o
word_18B116:    dc.w    $8927, $500, $F8F8              ; DATA XREF: ROM:0018B144   o
                                        ; ROM:0018B148   o
off_18B11C:     dc.w    word_18B0F8-*                   ; DATA XREF: Stage_Stage18Init+12   o
                dc.w    5
                dc.w    word_18B0FE-*
                dc.w    5
                dc.w    word_18B0F8-*
                dc.w    5
                dc.w    word_18B0FE-*
                dc.w    5
                dc.w    word_18B0F8-*
                dc.w    5
                dc.w    word_18B0FE-*
                dc.w    5
                dc.w    word_18B104-*
                dc.w    5
                dc.w    word_18B104-*
                dc.w    $FF
off_18B13C:     dc.w    word_18B10A-*                   ; DATA XREF: Effect_CreatePlanetDebris+E   o
                dc.w    2
                dc.w    word_18B110-*
                dc.w    2
                dc.w    word_18B116-*
                dc.w    2
                dc.w    word_18B116-*
                dc.w    $FF
