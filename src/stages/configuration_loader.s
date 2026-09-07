Stage_LoadPalette:                              ; CODE XREF: Stage_LoadTiles2+40   p  ; was: sub_12648
                movea.l (dword_FF8058).w,a4
                movea.l (dword_FF8040).w,a0
                movea.l #$FFFF6000,a2
                moveq   #0,d6
                move.w  (word_FF8048).w,d7
loc_1265C:                              ; CODE XREF: Stage_LoadPalette+5E   j
                move.w  (word_FF804A).w,d5
                move.w  d5,d4
                addq.w  #1,d4
                asl.w   #5,d4
loc_12666:                              ; CODE XREF: Stage_LoadPalette+26   j
                move.l  (a0,d6.w),(a2)+
                addi.w  #$20,d6 ; ' '
                dbf     d5,loc_12666
                movea.l a2,a3
                move.w  (word_FF804A).w,d5
                addq.w  #1,d5
                asl.w   #2,d5
                subq.w  #1,d5
loc_1267E:                              ; CODE XREF: Stage_LoadPalette+44   j
                moveq   #0,d0
                move.b  -(a3),d0
                move.b  d0,d1
                asr.w   #4,d0
                asl.w   #4,d1
                add.b   d1,d0
                move.b  d0,(a2)+
                dbf     d5,loc_1267E
                sub.w   d4,d6
                addq.w  #4,d6
                move.w  d6,d0
                andi.w  #$1C,d0
                bne.s   loc_126A2
                add.w   d4,d6
                subi.w  #$20,d6 ; ' '
loc_126A2:                              ; CODE XREF: Stage_LoadPalette+52   j
                move.w  (word_FF804A).w,d5
                dbf     d7,loc_1265C
                movea.l #$FFFF6000,a2
                movea.l #$FFFF0000,a0
                move.w  (word_FF8048).w,d7
                asr.w   #3,d7
                moveq   #0,d5
                move.w  (word_FF804A).w,d5
                addq.w  #1,d5
                asl.w   #3,d5
                swap    d5
loc_126C8:                              ; CODE XREF: Stage_LoadPalette+E6   j
                moveq   #7,d1
loc_126CA:                              ; CODE XREF: Stage_LoadPalette+DE   j
                move.l  (a4)+,d3
                move.w  #$17,d2
                moveq   #0,d4
loc_126D2:                              ; CODE XREF: Stage_LoadPalette+D0   j
                moveq   #3,d6
loc_126D4:                              ; CODE XREF: Stage_LoadPalette+C8   j
                move.b  (a2,d4.w),d0
                btst    #$1F,d4
                beq.s   loc_126E0
                asl.b   #4,d0
loc_126E0:                              ; CODE XREF: Stage_LoadPalette+94   j
                andi.b  #$F0,d0
                swap    d4
                add.l   d3,d4
                cmp.l   d5,d4
                bmi.s   loc_126EE
                sub.l   d5,d4
loc_126EE:                              ; CODE XREF: Stage_LoadPalette+A2   j
                move.b  d0,(a0)
                swap    d4
                move.b  (a2,d4.w),d0
                btst    #$1F,d4
                bne.s   loc_126FE
                asr.b   #4,d0
loc_126FE:                              ; CODE XREF: Stage_LoadPalette+B2   j
                andi.b  #$F,d0
                swap    d4
                add.l   d3,d4
                cmp.l   d5,d4
                bmi.s   loc_1270C
                sub.l   d5,d4
loc_1270C:                              ; CODE XREF: Stage_LoadPalette+C0   j
                or.b    d0,(a0)+
                swap    d4
                dbf     d6,loc_126D4
                adda.w  #$1C,a0
                dbf     d2,loc_126D2
                adda.w  #$FD04,a0
                swap    d5
                adda.w  d5,a2
                swap    d5
                dbf     d1,loc_126CA
                adda.w  #$2E0,a0
                dbf     d7,loc_126C8
                rts
; End of function Stage_LoadPalette
CheckFlagsLoadObjData:                  ; CODE XREF: Stage_LoadStage1Objects+A   j
                                        ; Stage_LoadStage1Phase1+E   j ...
                cmpi.w  #$3C,(GameModeIndex).w ; '<'
                beq.s   loc_12752
                cmpi.w  #$C,(GameModeIndex).w
                beq.s   loc_12752
                cmpi.w  #$10,(GameModeIndex).w
                beq.s   loc_12752
                jmp (Data_ProcessPointer).l
; ---------------------------------------------------------------------------
loc_12752:                              ; CODE XREF: CheckFlagsLoadObjData+6   j
                                        ; CheckFlagsLoadObjData+E   j ...
                jmp     (LoadObjData).l
; End of function CheckFlagsLoadObjData


; Loads stage configuration data including positions and palettes
Stage_LoadConfigData:                              ; CODE XREF: Stage_LoadXiTigerSprites+6   p  ; was: sub_12758
                                        ; Stage_InitStage1Data+6   j ...
                move.w  (a0)+,(word_FFA950).w
                move.l  (a0)+,(dword_FFA20E).w
                move.w  (a0)+,(word_FF8114).w
                move.b  (a0)+,(word_FF8220+1).w
                move.b  (a0)+,(word_FF8222+1).w
                move.w  (a0)+,(word_FF808A).w
                move.w  (a0)+,(dword_FFA900).w
                move.w  (a0)+,(dword_FFA904).w
                move.w  (a0)+,(dword_FFA908).w
                move.w  (a0)+,(dword_FFA90C).w
                move.w  (a0)+,(word_FF80AA).w
                move.w  (a0)+,(word_FF80AC).w
                moveq   #0,d0
                move.b  (a0)+,d0
                addi.w  #$80,d0
                move.w  d0,(dword_FFA410).w
                moveq   #0,d0
                move.b  (a0)+,d0
                addi.w  #$80,d0
                move.w  d0,(dword_FFA414).w
                movea.l (a0)+,a4
                jmp Gfx_LoadMultiplePalettes
; End of function Stage_LoadConfigData
; ---------------------------------------------------------------------------
stru_127A8:     dc.w 0                  ; field_0
                                        ; DATA XREF: Stage_InitStage1Data   o
                dc.l word_1A3E8         ; field_2
                dc.w 2                  ; field_6
                dc.b 2                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B988          ; field_1A
stru_127C6:     dc.w $A                 ; field_0
                                        ; DATA XREF: Stage_InitStage2Data   o
                dc.l word_1A4D8         ; field_2
                dc.w 0                  ; field_6
                dc.b 2                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $700               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B988          ; field_1A
stru_127E4:     dc.w $12                ; field_0
                                        ; DATA XREF: Stage_LoadStage2ConfigAlt   o
                dc.l word_1A6B8         ; field_2
                dc.w 0                  ; field_6
                dc.b 2                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $BC0               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B988          ; field_1A
stru_12802:     dc.w $22                ; field_0
                                        ; DATA XREF: Stage_LoadStage2Config2   o
                dc.l word_1A754         ; field_2
                dc.w 0                  ; field_6
                dc.b 4                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $1200              ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B98C          ; field_1A
stru_12820:     dc.w $2E                ; field_0
                                        ; DATA XREF: Stage_LoadStage2Config3   o
                dc.l word_1A882         ; field_2
                dc.w 0                  ; field_6
                dc.b 6                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B992          ; field_1A
stru_1283E:     dc.w $38                ; field_0
                                        ; DATA XREF: Stage_LoadStage2Config4   o
                dc.l word_1A9B0         ; field_2
                dc.w 0                  ; field_6
                dc.b 6                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $480               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B992          ; field_1A
stru_1285C:     dc.w $40                ; field_0
                                        ; DATA XREF: Stage_LoadStage2Config5   o
                dc.l word_1AB24         ; field_2
                dc.w 0                  ; field_6
                dc.b 6                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $AA0               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B992          ; field_1A
stru_1287A:     dc.w $50                ; field_0
                                        ; DATA XREF: Stage_InitStage8Data   o
                dc.l word_1ABC2         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $C00               ; field_C
                dc.w 0                  ; field_E
                dc.w $730               ; field_10
                dc.w $F700              ; field_12
                dc.w 8                  ; field_14
                dc.w 8                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B996          ; field_1A
stru_12898:     dc.w $62                ; field_0
                                        ; DATA XREF: Stage_InitStage8Palettes   o
                dc.l word_1AC60         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $800               ; field_C
                dc.w 0                  ; field_E
                dc.w $C00               ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 8                  ; field_16
                dc.b $60                ; field_18
                dc.b $A8                ; field_19
                dc.l word_B99A          ; field_1A
stru_128B6:     dc.w 0                  ; field_0
                                        ; DATA XREF: Stage_InitStage10Data   o
                dc.l word_1AC62         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w $FC00              ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $78                ; field_19
                dc.l word_B9A4          ; field_1A
stru_128D4:     dc.w $A                 ; field_0
                                        ; DATA XREF: Stage_LoadStage10ConfigAlt   o
                dc.l word_1AD8E         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $7B0               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w $FC00              ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $A0                ; field_18
                dc.b $78                ; field_19
                dc.l word_B9A4          ; field_1A
; ===============================================================================
; UNUSED GRAPHICS: Unknown Purpose
; Source: TCRF research (ROM offset 0x1291DE)
; Description: 314 bytes of unknown graphics data
; Binary File: word_1AE96.bin
; Referenced by: stru_128F2
; Loader Function: sub_12386
; Status: Purpose unknown, possibly test graphics or scrapped UI element
; ===============================================================================
stru_128F2:     dc.w $14                ; Structure size/ID
                                        ; DATA XREF: Stage_LoadStage11Config   o
                dc.l word_1AE96         ; Unknown graphics data pointer (line 34452)
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $10C0              ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w $FC00              ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $5C                ; field_18
                dc.b $70                ; field_19
                dc.l word_B9A4          ; field_1A
; ===============================================================================
; UNUSED INTRO SPRITES: Kaede and Unknown Man
; Source: TCRF https://tcrf.net/Alien_Soldier (ROM offset 0x188A16)
; Description: Cut intro cutscene featuring Kaede and unidentified character
; Graphics Data: word_1A3E6 (line 34368)
; Loader Function: sub_12390 (line 22614)
; Sprite Size: 4x4 tiles (32x32 pixels)
; Palette: Bank $40, Index $80
; Status: Complete sprite structure, never displayed in final game
; ===============================================================================
stru_12910:     dc.w $34                ; Structure size/ID
                                        ; DATA XREF: Stage_InitCutsceneData   o
                dc.l word_1A3E6         ; Sprite graphics data pointer
                dc.w 0                  ; X position
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; Flags
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w $FC00              ; field_12
                dc.w 4                  ; Sprite width (tiles)
                dc.w 4                  ; Sprite height (tiles)
                dc.b $40                ; Palette bank
                dc.b $80                ; Palette index
                dc.l word_B9A4          ; Animation/mapping data
stru_1292E:     dc.w $40                ; field_0
                                        ; DATA XREF: Stage_LoadStage13ConfigAlt   o
                dc.l word_1AFD0         ; field_2
                dc.w 0                  ; field_6
                dc.b $C                 ; field_8
                dc.b 4                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w $E100              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $58                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9A8          ; field_1A
stru_1294C:     dc.w $4A                ; field_0
                                        ; DATA XREF: Stage_LoadStage14Config   o
                dc.l word_1B00C         ; field_2
                dc.w 0                  ; field_6
                dc.b $C                 ; field_8
                dc.b 4                  ; field_9
                dc.w $8000              ; field_A
                dc.w $480               ; field_C
                dc.w $E100              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9A8          ; field_1A
stru_1296A:     dc.w $56                ; field_0
                                        ; DATA XREF: Stage_InitStage16Data   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b $C                 ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $620               ; field_C
                dc.w $E440              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $A0                ; field_18
                dc.b $C0                ; field_19
                dc.l word_B9A8          ; field_1A
stru_12988:     dc.w $6C                ; field_0
                                        ; DATA XREF: Stage_InitStage17Boss+6   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 0                  ; field_14
                dc.w 8                  ; field_16
                dc.b $40                ; field_18
                dc.b $80                ; field_19
                dc.l word_B9AC          ; field_1A
stru_129A6:     dc.w 0                  ; field_0
                                        ; DATA XREF: Gfx_Stage18Foreground   o
                dc.l word_1B03E         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w $8008              ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B0          ; field_1A
stru_129C4:     dc.w $A                 ; field_0
                                        ; DATA XREF: Stage_LoadStage18ConfigAlt   o
                dc.l word_1B2BA         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $D50               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w $8008              ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B0          ; field_1A
stru_129E2:     dc.w $28                ; field_0
                                        ; DATA XREF: Stage_LoadStage20Config1   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b $10                ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B4          ; field_1A
stru_12A00:     dc.w $30                ; field_0
                                        ; DATA XREF: Stage_LoadStage20Config2   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b $10                ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B4          ; field_1A
stru_12A1E:     dc.w $38                ; field_0
                                        ; DATA XREF: Stage_LoadStage20Config3   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b $10                ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B4          ; field_1A
stru_12A3C:     dc.w $40                ; field_0
                                        ; DATA XREF: Stage_LoadStage20Config4   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b $10                ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B4          ; field_1A
stru_12A5A:     dc.w $70                ; field_0
                                        ; DATA XREF: Stage_InitStage25Tilemap+18   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $600               ; field_C
                dc.w $F800              ; field_E
                dc.w 0                  ; field_10
                dc.w $F500              ; field_12
                dc.w 8                  ; field_14
                dc.w 4                  ; field_16
                dc.b $80                ; field_18
                dc.b 0                  ; field_19
                dc.l word_B9B8          ; field_1A
stru_12A78:     dc.w 0                  ; field_0
                                        ; DATA XREF: Stage_InitStage26Config+C   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b $E                 ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w $F800              ; field_E
                dc.w 0                  ; field_10
                dc.w $F100              ; field_12
                dc.w 8                  ; field_14
                dc.w 8                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9C6          ; field_1A
stru_12A96:     dc.w $2C                ; field_0
                                        ; DATA XREF: Stage_InitStage27Config+C   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b $E                 ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w $F600              ; field_E
                dc.w 0                  ; field_10
                dc.w $F100              ; field_12
                dc.w 8                  ; field_14
                dc.w 8                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9CC          ; field_1A
stru_12AB4:     dc.w $2E                ; field_0
                                        ; DATA XREF: Stage_InitStage28Config+C   o
                dc.l word_1B3F4         ; field_2
                dc.w 0                  ; field_6
                dc.b $12                ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w $F3E0              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 0                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9C6          ; field_1A
stru_12AD2:     dc.w $40                ; field_0
                                        ; DATA XREF: Stage_InitStage29Config   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9D2          ; field_1A
stru_12AF0:     dc.w $4E                ; field_0
                                        ; DATA XREF: Stage_InitStage30Config+6   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9D8          ; field_1A
stru_12B0E:     dc.w $62                ; field_0
                                        ; DATA XREF: Stage_InitStage31Config+6   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w $FF00              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9DE          ; field_1A
stru_12B2C:     dc.w $76                ; field_0
                                        ; DATA XREF: Stage_InitStage32Config   o
                dc.l word_1B3F6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w $FE00              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $60                ; field_19
                dc.l word_B9E2          ; field_1A
stru_12B4A:     dc.w $8A                ; field_0
                                        ; DATA XREF: Stage_InitStage33Config   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9E6          ; field_1A


nullsub_1:                              ; CODE XREF: Stage_LoadXiTigerGraphics+4   p
                                        ; Sys_InitStageState+4   p ...
                rts
; End of function nullsub_1


; Renders HUD element health or ammo
