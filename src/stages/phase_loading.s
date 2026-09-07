Stage_LoadStage16Objects:                              ; DATA XREF: ROM:00011750   o  ; was: sub_11A5C
                                        ; ROM:00011752   o ...
                move.w  #4,(word_FFA206).w
                lea     stru_11A6E(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage16Objects
; ---------------------------------------------------------------------------
stru_11A6E:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage16Objects+6   o
                dc.l tiles_1A2C46       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F2816        ; field_2
                dc.w $5F00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A6276        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A648A        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A74F6        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads initial object set for Stage 2 phase 1
Stage_LoadStage2Phase1:                              ; DATA XREF: ROM:00011756   o  ; was: sub_11AB0
                move.w  #4,(word_FFA206).w
                lea     stru_11AC2(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage2Phase1
; ---------------------------------------------------------------------------
stru_11AC2:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage2Phase1+6   o
                dc.l tiles_1A752A       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1A8F0E       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A8B30        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A8B88        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads Stage 18 palette
Gfx_LoadStage18Palette:                              ; DATA XREF: ROM:00011758   o  ; was: sub_11AF4
                                        ; ROM:0001175A   o
                move.w  #8,(word_FFA206).w
                lea     stru_11B06(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Gfx_LoadStage18Palette
; ---------------------------------------------------------------------------
stru_11B06:     dc.w 7                  ; field_0
                                        ; DATA XREF: Gfx_LoadStage18Palette+6   o
                dc.l tiles_1A9CC4       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1ACB68       ; field_2
                dc.w $2A00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1ABB28        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1ABC72        ; field_2
                dc.w $6400              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1ABCFC        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1AF030        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1AF09C        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B3A26        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B109C        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1B0F08       ; field_2
                dc.w $8E00              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 2 phase 2
Stage_LoadStage2Phase2:
                move.w  #8,(word_FFA206).w  ; was: sub_11B60
                lea     stru_11B72(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage2Phase2
; ---------------------------------------------------------------------------
stru_11B72:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage2Phase2+6   o
                dc.l tiles_1B10FA       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B33E8        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B3458        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B3A26        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads Stage 20 tiles
Gfx_LoadStage20Tiles:                              ; DATA XREF: ROM:0001175C   o  ; was: sub_11B9C
                move.w  #8,(word_FFA206).w
                lea     stru_11BAE(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Gfx_LoadStage20Tiles
; ---------------------------------------------------------------------------
stru_11BAE:     dc.w 7                  ; field_0
                                        ; DATA XREF: Gfx_LoadStage20Tiles+6   o
                dc.l tiles_1B5466       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1B3A9E       ; field_2
                dc.w $3000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B6C40        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B6C82        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B3EDE        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B401E        ; field_2
                dc.w $6200              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B412A        ; field_2
                dc.w $6400              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B41DA        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B3A26        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 1
Stage_LoadStage3Phase1:                              ; DATA XREF: ROM:00011762   o  ; was: sub_11C00
                move.w  #$C,(word_FFA206).w
                bset    #0,(byte_FF8144).w
                bset    #7,(byte_FFA959).w
                bra.s   loc_11C2A
; End of function Stage_LoadStage3Phase1
; Loads object set for Stage 3 phase 2
Stage_LoadStage3Phase2:                              ; DATA XREF: ROM:0001175E   o  ; was: sub_11C14
                                        ; ROM:00011760   o
                move.w  #$C,(word_FFA206).w
                bset    #0,(byte_FF8144).w
                bset    #7,(byte_FFA959).w
                bsr.w Stage_LoadTiles2
loc_11C2A:                              ; CODE XREF: Stage_LoadStage3Phase1+12   j
                lea     stru_11C36(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase2
; ---------------------------------------------------------------------------
stru_11C36:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase2:loc_11C2A   o
                dc.l tiles_1BE762       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C0FB2        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1108        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C17AC        ; field_2
                dc.w $5A00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CF798        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 3
Stage_LoadStage3Phase3:                              ; DATA XREF: ROM:00011764   o  ; was: sub_11C70
                move.w  #$C,(word_FFA206).w
                lea     stru_11C82(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase3
; ---------------------------------------------------------------------------
stru_11C82:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase3+6   o
                dc.l tiles_1C1A94       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1CECB4       ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C2934        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C2968        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 4
Stage_LoadStage3Phase4:
                move.w  #$C,(word_FFA206).w  ; was: sub_11CB4
                lea     stru_11CC6(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase4
; ---------------------------------------------------------------------------
stru_11CC6:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase4+6   o
                dc.l tiles_1C2B90       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1CE2E0       ; field_2
                dc.w $5800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C5506        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C55CE        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 5
Stage_LoadStage3Phase5:
                move.w  #$C,(word_FFA206).w  ; was: sub_11CF8
                lea     stru_11D0A(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase5
; ---------------------------------------------------------------------------
stru_11D0A:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase5+6   o
                dc.l tiles_1C5DE4       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C65FA        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C6620        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 6
Stage_LoadStage3Phase6:                              ; DATA XREF: ROM:00011766   o  ; was: sub_11D34
                move.w  #$C,(word_FFA206).w
                lea     stru_11D46(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase6
; ---------------------------------------------------------------------------
stru_11D46:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase6+6   o
                dc.l tiles_1C92B0       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1C67BE       ; field_2
                dc.w $1800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C9FDC        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CA046        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C8C34        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C8CB4        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CF7BE        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 7
Stage_LoadStage3Phase7:                              ; DATA XREF: ROM:00011768   o  ; was: sub_11D90
                move.w  #$C,(word_FFA206).w
                bset    #0,(byte_FF8144).w
                lea     stru_11DA8(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase7
; ---------------------------------------------------------------------------
stru_11DA8:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase7+C   o
                dc.l tiles_1CA32E       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CD746        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CD7EC        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Stage state machine dispatcher
