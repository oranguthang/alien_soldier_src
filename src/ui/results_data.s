UI_PrepareResultsData:                                  ; CODE XREF: Results_InitializeDataDisplay+1AC   p  ; was: sub_2024A
                lea     (UI_StageWeaponSelectionTable).l,a1
                lea     (word_FFAA00).w,a2
                lea     (word_FFAA80).w,a3
                lea     (word_FFAB00).w,a4
                move.w  #$18,d7
                clr.w   (dword_FF9434).w
                clr.w   (dword_FF9438).w
                clr.w   (dword_FF9434+2).w
loc_2026C:                                              ; CODE XREF: UI_PrepareResultsData+82   j
                tst.w   (a2)
                bpl.s   loc_20276
                tst.w   (a4)
                bmi.w   loc_202C4
loc_20276:                                              ; CODE XREF: UI_PrepareResultsData+24   j
                move.b  (a1),d0
                bsr.w   Math_BCDToDecimal
                move.w  d0,d2
                move.b  1(a1),d0
                bsr.w   Math_BCDToDecimal
                move.w  d0,d3
                mulu.w  #$3C,d2                         ; '<'
                add.w   d2,d3
                add.w   d3,(dword_FF9434).w
                move.w  (a4),d0
                addq.w  #1,d0
                add.w   d0,(dword_FF9438).w
                move.w  (a1),(dword_FF9410+2).w
                move.w  (a3),(dword_FF9410).w
                bmi.w   loc_202C4
                bsr.w   Math_CalculateBCDDifference
                move.w  d2,d0
                bsr.w   Math_BCDToDecimal
                move.w  d0,d2
                move.w  d3,d0
                bsr.w   Math_BCDToDecimal
                move.w  d0,d3
                mulu.w  #$3C,d2                         ; '<'
                add.w   d2,d3
                add.w   d3,(dword_FF9434+2).w
loc_202C4:                                              ; CODE XREF: UI_PrepareResultsData+28   j
                                        ; UI_PrepareResultsData+58   j
                addq.w  #2,a1
                addq.w  #2,a2
                addq.w  #2,a3
                addq.w  #2,a4
                dbf     d7,loc_2026C
                lea     (Math_PackedBCDLookup).l,a1
                lea     (dword_FF9428).w,a0
                move.w  (dword_FF9434).w,d6
                bsr.w   Math_ConvertSecondsToTime
                lea     (dword_FF9430).w,a0
                move.w  (dword_FF9438).w,d5
                divu.w  #$A,d5
                move.w  d5,d0
                add.w   d0,d0
                move.w  (a1,d0.w),(a0)+
                swap    d5
                add.w   d5,d5
                move.w  (a1,d5.w),d0
                andi.w  #$F,d0
                lsl.w   #4,d0
                move.b  d0,(a0)
                lea     (dword_FF942C).w,a0
                move.w  (dword_FF9434+2).w,d6
                bsr.w   Math_ConvertSecondsToTime
                bsr.w   UI_BuildResultsTotalText
                rts
; End of function UI_PrepareResultsData
; Builds formatted text strings for total time and clear count display
UI_BuildResultsTotalText:                               ; CODE XREF: UI_PrepareResultsData+C8   p  ; was: sub_20318
                lea     ((dword_FF944E+2)).w,a0
                adda.w  #(word_FF9852-(dword_FF944E+2)),a0
                lea     word_20910(pc),a1
                nop
                move.w  #$15,d7
loc_2032A:                                              ; CODE XREF: UI_BuildResultsTotalText+14   j
                move.b  (a1)+,(a0)+
                dbf     d7,loc_2032A
                lea     (dword_FF9428).w,a1
                move.b  (a1)+,d0
                bsr.w   UI_ConvertBCDToDigits
                move.b  (a1)+,d0
                move.b  #$25,(a0)+                      ; '%'
                bsr.w   UI_ConvertBCDToDigits
                move.b  #$25,(a0)+                      ; '%'
                move.b  (a1)+,d0
                bsr.w   UI_ConvertBCDToDigits
                move.w  #6,d7
                move.b  #0,d0
loc_20356:                                              ; CODE XREF: UI_BuildResultsTotalText+40   j
                move.b  d0,(a0)+
                dbf     d7,loc_20356
                bsr.w   UI_WriteEndMarker
                lea     word_20927(pc),a1
                nop
                move.w  #$15,d7
loc_2036A:                                              ; CODE XREF: UI_BuildResultsTotalText+54   j
                move.b  (a1)+,(a0)+
                dbf     d7,loc_2036A
                lea     (dword_FF942C).w,a1
                move.b  (a1)+,d0
                bsr.w   UI_ConvertBCDToDigits
                move.b  (a1)+,d0
                move.b  #$25,(a0)+                      ; '%'
                bsr.w   UI_ConvertBCDToDigits
                move.b  #$25,(a0)+                      ; '%'
                move.b  (a1)+,d0
                bsr.w   UI_ConvertBCDToDigits
                move.w  #6,d7
                move.b  #0,d0
loc_20396:                                              ; CODE XREF: UI_BuildResultsTotalText+80   j
                move.b  d0,(a0)+
                dbf     d7,loc_20396
                bsr.w   UI_WriteEndMarker
                lea     word_2093E(pc),a1
                nop
                move.w  #$15,d7
loc_203AA:                                              ; CODE XREF: UI_BuildResultsTotalText+94   j
                move.b  (a1)+,(a0)+
                dbf     d7,loc_203AA
                lea     (dword_FF9430).w,a1
                move.b  #0,(a0)+
                move.b  #0,(a0)+
                move.b  #0,(a0)+
                move.b  (a1)+,d0
                bsr.w   UI_ConvertBCDToDigits
                move.b  (a1)+,d0
                bsr.w   UI_ConvertBCDToDigits
                move.b  (a1),d0
                lsr.b   #4,d0
                addq.b  #1,d0
                move.b  d0,(a0)+
                move.w  #6,d7
                move.b  #0,d0
loc_203DC:                                              ; CODE XREF: UI_BuildResultsTotalText+C6   j
                move.b  d0,(a0)+
                dbf     d7,loc_203DC
                bsr.w   UI_WriteEndMarker
                rts
; End of function UI_BuildResultsTotalText
; Converts seconds value to hours:minutes:seconds format
Math_ConvertSecondsToTime:                              ; CODE XREF: UI_PrepareResultsData+94   p  ; was: sub_203E8
                                        ; UI_PrepareResultsData+C4   p
                divu.w  #$E10,d6
                move.w  d6,d0
                bsr.w   UI_WriteDigitFromTable
                clr.w   d6
                swap    d6
                divu.w  #$3C,d6                         ; '<'
                move.w  d6,d0
                bsr.w   UI_WriteDigitFromTable
                clr.w   d6
                swap    d6
                move.w  d6,d0
                bsr.w   UI_WriteDigitFromTable
                rts
; End of function Math_ConvertSecondsToTime
; Converts BCD-encoded nibbles to decimal value (multiply high nibble by 10)
Math_BCDToDecimal:                                      ; CODE XREF: UI_PrepareResultsData+2E   p  ; was: sub_2040C
                                        ; UI_PrepareResultsData+38   p
                move.w  d0,d1
                lsr.w   #4,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                muls.w  #$A,d1
                add.w   d1,d0
                rts
; End of function Math_BCDToDecimal
; Writes single digit to buffer by looking up value in table
UI_WriteDigitFromTable:                                 ; CODE XREF: Math_ConvertSecondsToTime+6   p  ; was: sub_20420
                                        ; Math_ConvertSecondsToTime+14   p
                add.w   d0,d0
                move.w  (a1,d0.w),d0
                andi.w  #$FF,d0
                move.b  d0,(a0)+
                rts
; End of function UI_WriteDigitFromTable
; Updates results screen viewport position and renders visible rows
UI_UpdateResultsViewport:                               ; CODE XREF: UI_CheckResultsScrollBounds+1A   p  ; was: sub_2042E
                                        ; sub_20024:loc_200C4   p
                move.w  #$90,d1
                sub.w   (dword_FFA904).w,d1
                andi.w  #$FFF0,d1
                lsr.w   #4,d1
                move.w  d1,d4
                cmpi.w  #9,d1
                bcs.w   loc_20450
                cmp.w   (dword_FF943C+2).w,d1
                bhi.w   loc_20450
                bra.s   loc_20458
; ---------------------------------------------------------------------------
loc_20450:                                              ; CODE XREF: UI_UpdateResultsViewport+14   j
                                        ; UI_UpdateResultsViewport+1C   j
                move.w  d1,(dword_FF9414).w
                bra.w   loc_20578
; ---------------------------------------------------------------------------
loc_20458:                                              ; CODE XREF: UI_UpdateResultsViewport+20   j
                tst.w   (dword_FF941C).w
                bmi.s   loc_20464
                subi.w  #9,d1
                bra.s   loc_20466
; ---------------------------------------------------------------------------
loc_20464:                                              ; CODE XREF: UI_UpdateResultsViewport+2E   j
                addq.w  #7,d1
loc_20466:                                              ; CODE XREF: UI_UpdateResultsViewport+34   j
                move.w  d1,(dword_FF9414).w
                move.w  d1,d0
                mulu.w  #$16,d0
                move.w  d0,(dword_FF941C+2).w
                move.w  d1,d0
                mulu.w  #$26,d1                         ; '&'
                lea     ((dword_FF944E+2)).w,a0
                adda.w  d1,a0
                move.w  a0,(dword_FF9420+2).w
                subi.w  #9,d4
                andi.w  #$F,d4
                mulu.w  #$100,d4
                move.w  d4,(dword_FF9404).w
                addi.w  #$4006,d4
                move.w  (StageTableIndex).w,d3
                lsr.w   #1,d3
                cmp.w   d0,d3
                beq.s   loc_204C2
                cmpi.b  #$2A,4(a0)                      ; '*'
                bne.s   loc_204B0
                move.w  #$2300,d0
                bra.s   loc_204B4
; ---------------------------------------------------------------------------
loc_204B0:                                              ; CODE XREF: UI_UpdateResultsViewport+7A   j
                move.w  #$4300,d0
loc_204B4:                                              ; CODE XREF: UI_UpdateResultsViewport+80   j
                cmp.w   (dword_FF9418).w,d4
                bne.s   loc_204D4
                move.w  #$FFFF,(dword_FF9418).w
                bra.s   loc_204D4
; ---------------------------------------------------------------------------
loc_204C2:                                              ; CODE XREF: UI_UpdateResultsViewport+72   j
                move.w  #$6300,d0
                move.w  d1,(dword_FF9414+2).w
                move.w  d4,(dword_FF9418).w
                move.w  (dword_FF941C+2).w,(dword_FF9420).w
loc_204D4:                                              ; CODE XREF: UI_UpdateResultsViewport+8A   j
                                        ; UI_UpdateResultsViewport+92   j
                move.w  (dword_FF9414).w,d7
                cmpi.w  #$1B,d7
                bcs.w   loc_204F0
                cmpi.w  #$1D,d7
                bhi.w   loc_204F0
                adda.w  #$16,a0
                addi.w  #$2A,d4                         ; '*'
loc_204F0:                                              ; CODE XREF: UI_UpdateResultsViewport+AE   j
                                        ; UI_UpdateResultsViewport+B6   j
                jsr     (UI_RenderTextStringWrapped).l
                move.w  (dword_FF9414).w,d0
                cmpi.w  #$1B,d0
                bne.s   loc_20508
                lea     word_20910(pc),a0
                nop
                bra.s   loc_20522
; ---------------------------------------------------------------------------
loc_20508:                                              ; CODE XREF: UI_UpdateResultsViewport+D0   j
                cmpi.w  #$1C,d0
                bne.s   loc_20516
                lea     word_20927(pc),a0
                nop
                bra.s   loc_20522
; ---------------------------------------------------------------------------
loc_20516:                                              ; CODE XREF: UI_UpdateResultsViewport+DE   j
                cmpi.w  #$1D,d0
                bne.s   loc_20534
                lea     word_2093E(pc),a0
                nop
loc_20522:                                              ; CODE XREF: UI_UpdateResultsViewport+D8   j
                                        ; UI_UpdateResultsViewport+E6   j
                move.w  #$300,d0
                move.w  (dword_FF9404).w,d4
                addi.w  #$4006,d4
                jsr     (UI_RenderTextStringWrapped).l
loc_20534:                                              ; CODE XREF: UI_UpdateResultsViewport+EC   j
                movea.w (dword_FF9420+2).w,a0
                move.b  $B(a0),d0
                cmpi.b  #$22,d0                         ; '"'
                bne.s   loc_2055C
                cmpi.b  #$2A,4(a0)                      ; '*'
                bne.s   loc_20550
                move.w  #$2300,d0
                bra.s   loc_20554
; ---------------------------------------------------------------------------
loc_20550:                                              ; CODE XREF: UI_UpdateResultsViewport+11A   j
                move.w  #$4300,d0
loc_20554:                                              ; CODE XREF: UI_UpdateResultsViewport+120   j
                lea     word_20650(pc),a0
                nop
                bra.s   loc_2056A
; ---------------------------------------------------------------------------
loc_2055C:                                              ; CODE XREF: UI_UpdateResultsViewport+112   j
                move.w  #$6300,d0
                lea     word_20666(pc),a0
                nop
                adda.w  (dword_FF941C+2).w,a0
loc_2056A:                                              ; CODE XREF: UI_UpdateResultsViewport+12C   j
                move.w  (dword_FF9404).w,d4
                addi.w  #$4050,d4
                jsr     (UI_RenderTextStringWrapped).l
loc_20578:                                              ; CODE XREF: UI_UpdateResultsViewport+26   j
                move.w  (dword_FF941C).w,d0
                add.w   d0,(dword_FFA904).w
                move.w  (dword_FFA904).w,d0
                cmpi.w  #$A,(dword_FF9400).w
                bne.s   locret_20590
                bsr.w   UI_CheckResultsInputDelay
locret_20590:                                           ; CODE XREF: UI_UpdateResultsViewport+15C   j
                rts
; End of function UI_UpdateResultsViewport
; Checks input buttons with delay before playing sound effect
UI_CheckResultsInputDelay:                              ; CODE XREF: UI_UpdateResultsViewport+15E   p  ; was: sub_20592
                btst    #0,(word_FFA000+1).w
                bne.s   locret_205AC
                btst    #1,(word_FFA000+1).w
                bne.s   locret_205AC
                move.b  #$EF,d0
                jsr     (Sound_PlaySFX).l
locret_205AC:                                           ; CODE XREF: UI_CheckResultsInputDelay+6   j
                                        ; UI_CheckResultsInputDelay+E   j
                rts
; End of function UI_CheckResultsInputDelay
; Renders flashing cursor for results screen row selection
UI_RenderResultsCursor:                                 ; CODE XREF: UI_CompleteResultsScroll+14   p  ; was: sub_205AE
                                        ; UI_WaitForResultsTransition+8   p
                tst.b   (dword_FF9418).w
                bmi.s   locret_20622
                btst    #1,(word_FFA280+1).w
                beq.s   loc_205C6
                move.w  #$300,d0
                move.w  d0,(dword_FF9404+2).w
                bra.s   loc_205CE
; ---------------------------------------------------------------------------
loc_205C6:                                              ; CODE XREF: UI_RenderResultsCursor+C   j
                move.w  #$6300,d0
                move.w  d0,(dword_FF9404+2).w
loc_205CE:                                              ; CODE XREF: UI_RenderResultsCursor+16   j
                lea     ((dword_FF944E+2)).w,a0
                adda.w  (dword_FF9414+2).w,a0
                move.w  a0,(dword_FF9420+2).w
                move.w  (dword_FF9418).w,d4
                btst    #$E,d4
                beq.s   loc_205EA
                jsr     (UI_RenderTextStringWrapped).l
loc_205EA:                                              ; CODE XREF: UI_RenderResultsCursor+34   j
                movea.w (dword_FF9420+2).w,a0
                move.b  $B(a0),d0
                cmpi.b  #$22,d0                         ; '"'
                bne.s   loc_20600
                lea     word_20650(pc),a0
                nop
                bra.s   loc_2060A
; ---------------------------------------------------------------------------
loc_20600:                                              ; CODE XREF: UI_RenderResultsCursor+48   j
                lea     word_20666(pc),a0
                nop
                adda.w  (dword_FF9420).w,a0
loc_2060A:                                              ; CODE XREF: UI_RenderResultsCursor+50   j
                move.w  (dword_FF9404+2).w,d0
                move.w  (dword_FF9418).w,d4
                addi.w  #$4A,d4                         ; 'J'
                btst    #$E,d4
                beq.s   locret_20622
                jsr     (UI_RenderTextStringWrapped).l
locret_20622:                                           ; CODE XREF: UI_RenderResultsCursor+4   j
                                        ; UI_RenderResultsCursor+6C   j
                rts
; End of function UI_RenderResultsCursor
; Handles up/down scrolling for results screen viewport
UI_HandleResultsScroll:
                btst    #0,(word_FFF706).w              ; was: sub_20624
                beq.s   loc_20638
                cmpi.w  #$90,(dword_FFA904).w
                bge.s   loc_20638
                addq.w  #2,(dword_FFA904).w
loc_20638:                                              ; CODE XREF: UI_HandleResultsScroll+6   j
                                        ; UI_HandleResultsScroll+E   j
                btst    #1,(word_FFF706).w
                beq.s   locret_2064E
                move.w  (dword_FFA904).w,d0
                cmp.w   (dword_FF943C).w,d0
                ble.s   locret_2064E
                subq.w  #2,(dword_FFA904).w
locret_2064E:                                           ; CODE XREF: UI_HandleResultsScroll+1A   j
                                        ; UI_HandleResultsScroll+24   j
                rts
; End of function UI_HandleResultsScroll
; ---------------------------------------------------------------------------
word_20650:     dc.w    $2A2A, $2A2A, $2A2A, $2A2A, 0, 0, 0, 0, 0, 0, $FF
                                        ; DATA XREF: UI_RenderResultsDataRow:loc_1FE66   o
                                        ; sub_1FEE2:loc_1FF62   o
word_20666:     binclude "data/other/word_20666.bin"
word_20666_End:
word_20910:     dc.w    0, $1E19, $1E0B, $1600, $1613, $1713, $1E00, $1E13, $170F, 0, 0
                                        ; DATA XREF: UI_BuildResultsTotalText+8   o
                                        ; UI_UpdateResultsViewport+D2   o
                dc.b    $FF
word_20927:     dc.w    0, $1E19, $1E0B, $1600, $D16, $F0B, $1C00, $1E13, $170F, 0, 0
                                        ; DATA XREF: UI_BuildResultsTotalText+48   o
                                        ; UI_UpdateResultsViewport+E0   o
                dc.b    $FF
word_2093E:     dc.w    0, $1E19, $1E0B, $1600, $D19, $181E, $1318, $1F0F, 0, 0, 0
                                        ; DATA XREF: UI_BuildResultsTotalText+88   o
                                        ; UI_UpdateResultsViewport+EE   o
                dc.w    $FFFF

; Initializes Xi Tiger credits sequence with graphics and palettes
