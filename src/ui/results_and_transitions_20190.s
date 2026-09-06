UI_WriteEndMarker:                              ; CODE XREF: Results_InitializeDataDisplay+18C   p  ; was: sub_20190
                                        ; Results_InitializeDataDisplay+1A4   p ...
                move.b  #$FF,(a0)+
                rts
; End of function UI_WriteEndMarker
; Writes null byte (0x00) to UI text buffer
UI_WriteNullByte:                              ; CODE XREF: Results_InitializeDataDisplay+6E   p  ; was: sub_20196
                                        ; Results_InitializeDataDisplay+72   p ...
                move.b  #0,(a0)+
                rts
; End of function UI_WriteNullByte
; Writes percent sign character to UI buffer
UI_WritePercentSign:                              ; CODE XREF: Results_InitializeDataDisplay+98   p  ; was: sub_2019C
                                        ; Results_InitializeDataDisplay+AE   p ...
                move.b  #$25,(a0)+ ; '%'
                rts
; End of function UI_WritePercentSign
; Writes asterisk character to UI buffer
UI_WriteAsterisk:                              ; CODE XREF: Results_InitializeDataDisplay:loc_1FCCC   p  ; was: sub_201A2
                                        ; Results_InitializeDataDisplay+AA   p ...
                move.b  #$2A,(a0)+ ; '*'
                rts
; End of function UI_WriteAsterisk
; Converts BCD-encoded byte to two digit characters for display
UI_ConvertBCDToDigits:                              ; CODE XREF: Results_InitializeDataDisplay+6A   p  ; was: sub_201A8
                                        ; Results_InitializeDataDisplay+94   p ...
                tst.b   d0
                bmi.s   loc_201BE
                move.b  d0,d1
                lsr.b   #4,d1
                addq.b  #1,d1
                move.b  d1,(a0)+
                andi.b  #$F,d0
                addq.b  #1,d0
                move.b  d0,(a0)+
                rts
; ---------------------------------------------------------------------------
loc_201BE:                              ; CODE XREF: UI_ConvertBCDToDigits+2   j
                move.b  #$22,(a0)+ ; '"'
                move.b  #$22,(a0)+ ; '"'
                rts
; End of function UI_ConvertBCDToDigits
; Converts BCD-encoded word to three digit characters for display
UI_ConvertBCDWordToDigits:                              ; CODE XREF: Results_InitializeDataDisplay:loc_1FDA6   p  ; was: sub_201C8
                tst.w   d0
                bmi.s   loc_201E6
                move.w  d0,d1
                lsr.w   #8,d1
                addq.b  #1,d1
                move.b  d1,(a0)+
                move.w  d0,d1
                lsr.w   #4,d1
                addq.b  #1,d1
                move.b  d1,(a0)+
                andi.b  #$F,d0
                addq.b  #1,d0
                move.b  d0,(a0)+
                rts
; ---------------------------------------------------------------------------
loc_201E6:                              ; CODE XREF: UI_ConvertBCDWordToDigits+2   j
                move.b  #$22,(a0)+ ; '"'
                move.b  #$22,(a0)+ ; '"'
                move.b  #$22,(a0)+ ; '"'
                rts
; End of function UI_ConvertBCDWordToDigits
; Formats time difference between two BCD values with percent separator
UI_FormatTimeDifference:                              ; CODE XREF: Results_InitializeDataDisplay+D6   p  ; was: sub_201F4
                                        ; Results_InitializeDataDisplay+10A   p ...
                bsr.s Math_CalculateBCDDifference
                move.b  d2,d0
                bsr.w UI_ConvertBCDToDigits
                bsr.w UI_WritePercentSign
                move.b  d3,d0
                bsr.w UI_ConvertBCDToDigits
                rts
; End of function UI_FormatTimeDifference
; Calculates BCD subtraction between two time values with borrowing
Math_CalculateBCDDifference:                              ; CODE XREF: UI_FormatTimeDifference   p  ; was: sub_20208
                                        ; UI_PrepareResultsData+5C   p
                move.b  (dword_FF9410+2).w,d0
                move.b  (dword_FF9410).w,d1
                sub.w   d4,d4
                sbcd    d1,d0
                move.b  d0,d2
                move.b  (dword_FF9410+3).w,d0
                move.b  (dword_FF9410+1).w,d1
                cmp.b   d1,d0
                bcc.s   loc_2022E
                moveq   #1,d3
                sub.w   d4,d4
                sbcd    d3,d2
                moveq   #$60,d3 ; '`'
                sub.w   d4,d4
                abcd    d3,d0
loc_2022E:                              ; CODE XREF: Math_CalculateBCDDifference+18   j
                sub.w   d4,d4
                sbcd    d1,d0
                move.b  d0,d3
                rts
; End of function Math_CalculateBCDDifference
; Clears 25 word entries in memory array at FFAA80
Data_ClearWordArray:
                move.w  #$18,d7  ; was: sub_20236
                move.w  #0,d0
                lea     (word_FFAA80).w,a0
loc_20242:                              ; CODE XREF: Data_ClearWordArray+E   j
                move.w  d0,(a0)+
                dbf     d7,loc_20242
                rts
; End of function Data_ClearWordArray
; Processes stage completion times and calculates totals for results screen
UI_PrepareResultsData:                              ; CODE XREF: Results_InitializeDataDisplay+1AC   p  ; was: sub_2024A
                lea     (word_1CE4C).l,a1
                lea     (word_FFAA00).w,a2
                lea     (word_FFAA80).w,a3
                lea     (word_FFAB00).w,a4
                move.w  #$18,d7
                clr.w   (dword_FF9434).w
                clr.w   (dword_FF9438).w
                clr.w   (dword_FF9434+2).w
loc_2026C:                              ; CODE XREF: UI_PrepareResultsData+82   j
                tst.w   (a2)
                bpl.s   loc_20276
                tst.w   (a4)
                bmi.w   loc_202C4
loc_20276:                              ; CODE XREF: UI_PrepareResultsData+24   j
                move.b  (a1),d0
                bsr.w Math_BCDToDecimal
                move.w  d0,d2
                move.b  1(a1),d0
                bsr.w Math_BCDToDecimal
                move.w  d0,d3
                mulu.w  #$3C,d2 ; '<'
                add.w   d2,d3
                add.w   d3,(dword_FF9434).w
                move.w  (a4),d0
                addq.w  #1,d0
                add.w   d0,(dword_FF9438).w
                move.w  (a1),(dword_FF9410+2).w
                move.w  (a3),(dword_FF9410).w
                bmi.w   loc_202C4
                bsr.w Math_CalculateBCDDifference
                move.w  d2,d0
                bsr.w Math_BCDToDecimal
                move.w  d0,d2
                move.w  d3,d0
                bsr.w Math_BCDToDecimal
                move.w  d0,d3
                mulu.w  #$3C,d2 ; '<'
                add.w   d2,d3
                add.w   d3,(dword_FF9434+2).w
loc_202C4:                              ; CODE XREF: UI_PrepareResultsData+28   j
                                        ; UI_PrepareResultsData+58   j
                addq.w  #2,a1
                addq.w  #2,a2
                addq.w  #2,a3
                addq.w  #2,a4
                dbf     d7,loc_2026C
                lea     (word_5A43E).l,a1
                lea     (dword_FF9428).w,a0
                move.w  (dword_FF9434).w,d6
                bsr.w Math_ConvertSecondsToTime
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
                bsr.w Math_ConvertSecondsToTime
                bsr.w UI_BuildResultsTotalText
                rts
; End of function UI_PrepareResultsData
; Builds formatted text strings for total time and clear count display
UI_BuildResultsTotalText:                              ; CODE XREF: UI_PrepareResultsData+C8   p  ; was: sub_20318
                lea     ((dword_FF944E+2)).w,a0
                adda.w  #(word_FF9852-(dword_FF944E+2)),a0
                lea     word_20910(pc),a1
                nop
                move.w  #$15,d7
loc_2032A:                              ; CODE XREF: UI_BuildResultsTotalText+14   j
                move.b  (a1)+,(a0)+
                dbf     d7,loc_2032A
                lea     (dword_FF9428).w,a1
                move.b  (a1)+,d0
                bsr.w UI_ConvertBCDToDigits
                move.b  (a1)+,d0
                move.b  #$25,(a0)+ ; '%'
                bsr.w UI_ConvertBCDToDigits
                move.b  #$25,(a0)+ ; '%'
                move.b  (a1)+,d0
                bsr.w UI_ConvertBCDToDigits
                move.w  #6,d7
                move.b  #0,d0
loc_20356:                              ; CODE XREF: UI_BuildResultsTotalText+40   j
                move.b  d0,(a0)+
                dbf     d7,loc_20356
                bsr.w UI_WriteEndMarker
                lea     word_20927(pc),a1
                nop
                move.w  #$15,d7
loc_2036A:                              ; CODE XREF: UI_BuildResultsTotalText+54   j
                move.b  (a1)+,(a0)+
                dbf     d7,loc_2036A
                lea     (dword_FF942C).w,a1
                move.b  (a1)+,d0
                bsr.w UI_ConvertBCDToDigits
                move.b  (a1)+,d0
                move.b  #$25,(a0)+ ; '%'
                bsr.w UI_ConvertBCDToDigits
                move.b  #$25,(a0)+ ; '%'
                move.b  (a1)+,d0
                bsr.w UI_ConvertBCDToDigits
                move.w  #6,d7
                move.b  #0,d0
loc_20396:                              ; CODE XREF: UI_BuildResultsTotalText+80   j
                move.b  d0,(a0)+
                dbf     d7,loc_20396
                bsr.w UI_WriteEndMarker
                lea     word_2093E(pc),a1
                nop
                move.w  #$15,d7
loc_203AA:                              ; CODE XREF: UI_BuildResultsTotalText+94   j
                move.b  (a1)+,(a0)+
                dbf     d7,loc_203AA
                lea     (dword_FF9430).w,a1
                move.b  #0,(a0)+
                move.b  #0,(a0)+
                move.b  #0,(a0)+
                move.b  (a1)+,d0
                bsr.w UI_ConvertBCDToDigits
                move.b  (a1)+,d0
                bsr.w UI_ConvertBCDToDigits
                move.b  (a1),d0
                lsr.b   #4,d0
                addq.b  #1,d0
                move.b  d0,(a0)+
                move.w  #6,d7
                move.b  #0,d0
loc_203DC:                              ; CODE XREF: UI_BuildResultsTotalText+C6   j
                move.b  d0,(a0)+
                dbf     d7,loc_203DC
                bsr.w UI_WriteEndMarker
                rts
; End of function UI_BuildResultsTotalText
; Converts seconds value to hours:minutes:seconds format
Math_ConvertSecondsToTime:                              ; CODE XREF: UI_PrepareResultsData+94   p  ; was: sub_203E8
                                        ; UI_PrepareResultsData+C4   p
                divu.w  #$E10,d6
                move.w  d6,d0
                bsr.w UI_WriteDigitFromTable
                clr.w   d6
                swap    d6
                divu.w  #$3C,d6 ; '<'
                move.w  d6,d0
                bsr.w UI_WriteDigitFromTable
                clr.w   d6
                swap    d6
                move.w  d6,d0
                bsr.w UI_WriteDigitFromTable
                rts
; End of function Math_ConvertSecondsToTime
; Converts BCD-encoded nibbles to decimal value (multiply high nibble by 10)
Math_BCDToDecimal:                              ; CODE XREF: UI_PrepareResultsData+2E   p  ; was: sub_2040C
                                        ; UI_PrepareResultsData+38   p ...
                move.w  d0,d1
                lsr.w   #4,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                muls.w  #$A,d1
                add.w   d1,d0
                rts
; End of function Math_BCDToDecimal
; Writes single digit to buffer by looking up value in table
UI_WriteDigitFromTable:                              ; CODE XREF: Math_ConvertSecondsToTime+6   p  ; was: sub_20420
                                        ; Math_ConvertSecondsToTime+14   p ...
                add.w   d0,d0
                move.w  (a1,d0.w),d0
                andi.w  #$FF,d0
                move.b  d0,(a0)+
                rts
; End of function UI_WriteDigitFromTable
; Updates results screen viewport position and renders visible rows
UI_UpdateResultsViewport:                              ; CODE XREF: UI_CheckResultsScrollBounds+1A   p  ; was: sub_2042E
                                        ; sub_20024:loc_200C4   p ...
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
loc_20450:                              ; CODE XREF: UI_UpdateResultsViewport+14   j
                                        ; UI_UpdateResultsViewport+1C   j
                move.w  d1,(dword_FF9414).w
                bra.w   loc_20578
; ---------------------------------------------------------------------------
loc_20458:                              ; CODE XREF: UI_UpdateResultsViewport+20   j
                tst.w   (dword_FF941C).w
                bmi.s   loc_20464
                subi.w  #9,d1
                bra.s   loc_20466
; ---------------------------------------------------------------------------
loc_20464:                              ; CODE XREF: UI_UpdateResultsViewport+2E   j
                addq.w  #7,d1
loc_20466:                              ; CODE XREF: UI_UpdateResultsViewport+34   j
                move.w  d1,(dword_FF9414).w
                move.w  d1,d0
                mulu.w  #$16,d0
                move.w  d0,(dword_FF941C+2).w
                move.w  d1,d0
                mulu.w  #$26,d1 ; '&'
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
                cmpi.b  #$2A,4(a0) ; '*'
                bne.s   loc_204B0
                move.w  #$2300,d0
                bra.s   loc_204B4
; ---------------------------------------------------------------------------
loc_204B0:                              ; CODE XREF: UI_UpdateResultsViewport+7A   j
                move.w  #$4300,d0
loc_204B4:                              ; CODE XREF: UI_UpdateResultsViewport+80   j
                cmp.w   (dword_FF9418).w,d4
                bne.s   loc_204D4
                move.w  #$FFFF,(dword_FF9418).w
                bra.s   loc_204D4
; ---------------------------------------------------------------------------
loc_204C2:                              ; CODE XREF: UI_UpdateResultsViewport+72   j
                move.w  #$6300,d0
                move.w  d1,(dword_FF9414+2).w
                move.w  d4,(dword_FF9418).w
                move.w  (dword_FF941C+2).w,(dword_FF9420).w
loc_204D4:                              ; CODE XREF: UI_UpdateResultsViewport+8A   j
                                        ; UI_UpdateResultsViewport+92   j
                move.w  (dword_FF9414).w,d7
                cmpi.w  #$1B,d7
                bcs.w   loc_204F0
                cmpi.w  #$1D,d7
                bhi.w   loc_204F0
                adda.w  #$16,a0
                addi.w  #$2A,d4 ; '*'
loc_204F0:                              ; CODE XREF: UI_UpdateResultsViewport+AE   j
                                        ; UI_UpdateResultsViewport+B6   j
                jsr (UI_RenderTextStringWrapped).l
                move.w  (dword_FF9414).w,d0
                cmpi.w  #$1B,d0
                bne.s   loc_20508
                lea     word_20910(pc),a0
                nop
                bra.s   loc_20522
; ---------------------------------------------------------------------------
loc_20508:                              ; CODE XREF: UI_UpdateResultsViewport+D0   j
                cmpi.w  #$1C,d0
                bne.s   loc_20516
                lea     word_20927(pc),a0
                nop
                bra.s   loc_20522
; ---------------------------------------------------------------------------
loc_20516:                              ; CODE XREF: UI_UpdateResultsViewport+DE   j
                cmpi.w  #$1D,d0
                bne.s   loc_20534
                lea     word_2093E(pc),a0
                nop
loc_20522:                              ; CODE XREF: UI_UpdateResultsViewport+D8   j
                                        ; UI_UpdateResultsViewport+E6   j
                move.w  #$300,d0
                move.w  (dword_FF9404).w,d4
                addi.w  #$4006,d4
                jsr (UI_RenderTextStringWrapped).l
loc_20534:                              ; CODE XREF: UI_UpdateResultsViewport+EC   j
                movea.w (dword_FF9420+2).w,a0
                move.b  $B(a0),d0
                cmpi.b  #$22,d0 ; '"'
                bne.s   loc_2055C
                cmpi.b  #$2A,4(a0) ; '*'
                bne.s   loc_20550
                move.w  #$2300,d0
                bra.s   loc_20554
; ---------------------------------------------------------------------------
loc_20550:                              ; CODE XREF: UI_UpdateResultsViewport+11A   j
                move.w  #$4300,d0
loc_20554:                              ; CODE XREF: UI_UpdateResultsViewport+120   j
                lea     word_20650(pc),a0
                nop
                bra.s   loc_2056A
; ---------------------------------------------------------------------------
loc_2055C:                              ; CODE XREF: UI_UpdateResultsViewport+112   j
                move.w  #$6300,d0
                lea     word_20666(pc),a0
                nop
                adda.w  (dword_FF941C+2).w,a0
loc_2056A:                              ; CODE XREF: UI_UpdateResultsViewport+12C   j
                move.w  (dword_FF9404).w,d4
                addi.w  #$4050,d4
                jsr (UI_RenderTextStringWrapped).l
loc_20578:                              ; CODE XREF: UI_UpdateResultsViewport+26   j
                move.w  (dword_FF941C).w,d0
                add.w   d0,(dword_FFA904).w
                move.w  (dword_FFA904).w,d0
                cmpi.w  #$A,(dword_FF9400).w
                bne.s   locret_20590
                bsr.w UI_CheckResultsInputDelay
locret_20590:                           ; CODE XREF: UI_UpdateResultsViewport+15C   j
                rts
; End of function UI_UpdateResultsViewport
; Checks input buttons with delay before playing sound effect
UI_CheckResultsInputDelay:                              ; CODE XREF: UI_UpdateResultsViewport+15E   p  ; was: sub_20592
                btst    #0,(word_FFA000+1).w
                bne.s   locret_205AC
                btst    #1,(word_FFA000+1).w
                bne.s   locret_205AC
                move.b  #$EF,d0
                jsr (Sound_PlaySFX).l
locret_205AC:                           ; CODE XREF: UI_CheckResultsInputDelay+6   j
                                        ; UI_CheckResultsInputDelay+E   j
                rts
; End of function UI_CheckResultsInputDelay
; Renders flashing cursor for results screen row selection
UI_RenderResultsCursor:                              ; CODE XREF: UI_CompleteResultsScroll+14   p  ; was: sub_205AE
                                        ; UI_WaitForResultsTransition+8   p
                tst.b   (dword_FF9418).w
                bmi.s   locret_20622
                btst    #1,(word_FFA280+1).w
                beq.s   loc_205C6
                move.w  #$300,d0
                move.w  d0,(dword_FF9404+2).w
                bra.s   loc_205CE
; ---------------------------------------------------------------------------
loc_205C6:                              ; CODE XREF: UI_RenderResultsCursor+C   j
                move.w  #$6300,d0
                move.w  d0,(dword_FF9404+2).w
loc_205CE:                              ; CODE XREF: UI_RenderResultsCursor+16   j
                lea     ((dword_FF944E+2)).w,a0
                adda.w  (dword_FF9414+2).w,a0
                move.w  a0,(dword_FF9420+2).w
                move.w  (dword_FF9418).w,d4
                btst    #$E,d4
                beq.s   loc_205EA
                jsr (UI_RenderTextStringWrapped).l
loc_205EA:                              ; CODE XREF: UI_RenderResultsCursor+34   j
                movea.w (dword_FF9420+2).w,a0
                move.b  $B(a0),d0
                cmpi.b  #$22,d0 ; '"'
                bne.s   loc_20600
                lea     word_20650(pc),a0
                nop
                bra.s   loc_2060A
; ---------------------------------------------------------------------------
loc_20600:                              ; CODE XREF: UI_RenderResultsCursor+48   j
                lea     word_20666(pc),a0
                nop
                adda.w  (dword_FF9420).w,a0
loc_2060A:                              ; CODE XREF: UI_RenderResultsCursor+50   j
                move.w  (dword_FF9404+2).w,d0
                move.w  (dword_FF9418).w,d4
                addi.w  #$4A,d4 ; 'J'
                btst    #$E,d4
                beq.s   locret_20622
                jsr (UI_RenderTextStringWrapped).l
locret_20622:                           ; CODE XREF: UI_RenderResultsCursor+4   j
                                        ; UI_RenderResultsCursor+6C   j
                rts
; End of function UI_RenderResultsCursor
; Handles up/down scrolling for results screen viewport
UI_HandleResultsScroll:
                btst    #0,(word_FFF706).w  ; was: sub_20624
                beq.s   loc_20638
                cmpi.w  #$90,(dword_FFA904).w
                bge.s   loc_20638
                addq.w  #2,(dword_FFA904).w
loc_20638:                              ; CODE XREF: UI_HandleResultsScroll+6   j
                                        ; UI_HandleResultsScroll+E   j
                btst    #1,(word_FFF706).w
                beq.s   locret_2064E
                move.w  (dword_FFA904).w,d0
                cmp.w   (dword_FF943C).w,d0
                ble.s   locret_2064E
                subq.w  #2,(dword_FFA904).w
locret_2064E:                           ; CODE XREF: UI_HandleResultsScroll+1A   j
                                        ; UI_HandleResultsScroll+24   j
                rts
; End of function UI_HandleResultsScroll
; ---------------------------------------------------------------------------
word_20650:     dc.w $2A2A, $2A2A, $2A2A, $2A2A, 0, 0, 0, 0, 0, 0, $FF
                                        ; DATA XREF: UI_RenderResultsDataRow:loc_1FE66   o
                                        ; sub_1FEE2:loc_1FF62   o ...
word_20666:	binclude	"data/other/word_20666.bin"
word_20666_End:
word_20910:     dc.w 0, $1E19, $1E0B, $1600, $1613, $1713, $1E00, $1E13, $170F, 0, 0
                                        ; DATA XREF: UI_BuildResultsTotalText+8   o
                                        ; UI_UpdateResultsViewport+D2   o
                dc.b $FF
word_20927:     dc.w 0, $1E19, $1E0B, $1600, $D16, $F0B, $1C00, $1E13, $170F, 0, 0
                                        ; DATA XREF: UI_BuildResultsTotalText+48   o
                                        ; UI_UpdateResultsViewport+E0   o
                dc.b $FF
word_2093E:     dc.w 0, $1E19, $1E0B, $1600, $D19, $181E, $1318, $1F0F, 0, 0, 0
                                        ; DATA XREF: UI_BuildResultsTotalText+88   o
                                        ; UI_UpdateResultsViewport+EE   o
                dc.w $FFFF


; Initializes Xi Tiger credits sequence with graphics and palettes
Credits_InitXiTiger:                              ; DATA XREF: Sys_DispatchGameState+E2   o  ; was: sub_20956
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr (Sys_InitGameMode).l
                jsr (Gfx_QueueVRAMCommand).l
                movea.l #stru_20B4A,a0
                jsr     (LoadObjData).l
                lea     (word_FF5000).l,a0
                move.w  #$FF,d7
loc_20982:                              ; CODE XREF: Credits_InitXiTiger+34   j
                move.w  (a0),d0
                andi.w  #$FEFF,d0
                move.w  d0,(a0)+
                dbf     d7,loc_20982
                jsr (Sys_ClearBossDataBuffer).l
                lea     (dword_FF5180).l,a0
                move.w  #$A000,d0
                move.w  #0,d1
                move.w  #2,d7
                jsr (Gfx_UpdateTilemapIndices).l
                lea     (dword_FF6180).l,a0
                moveq   #0,d0
                move.w  #$1F,d1
loc_209B8:                              ; CODE XREF: Credits_InitXiTiger+64   j
                move.l  d0,(a0)+
                dbf     d1,loc_209B8
                move.l  #$81828300,(dword_FF6194).l
                move.l  #$85868700,(dword_FF619C).l
                move.l  #$898A8B00,(dword_FF61A4).l
                lea     (dword_11326).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                jsr (Gfx_DirectVRAMTransfer).l
                lea     (dword_11346).l,a0
                move.w  #$800,d0
                move.w  #0,d1
                jsr (Gfx_DirectVRAMTransfer).l
                lea     (word_B982).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                move.w  #$EA8,(word_FFE3A8).w
                move.w  #$E86,(word_FFE3AA).w
                move.w  #$E64,(word_FFE3AC).w
                move.b  #6,(word_FFF7E6+1).w
                move.b  #3,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                clr.l   (dword_FF0110).l
                move.l  #$1000,(dword_FF0114).l
                move.l  #$FFF80000,d0
                lea     (word_FFE400).w,a0
                move.w  #$1B,d7
loc_20A52:                              ; CODE XREF: Credits_InitXiTiger+102   j
                move.l  d0,(a0)
                adda.w  #$20,a0 ; ' '
                dbf     d7,loc_20A52
                lea     (word_FFEC00).w,a0
                move.w  #$13,d7
loc_20A64:                              ; CODE XREF: Credits_InitXiTiger+110   j
                move.l  d0,(a0)+
                dbf     d7,loc_20A64
                lea     (word_FFC680).w,a5
                move.w  #$CC00,word_FFC682-word_FFC680(a5)
                move.w  #$10,(a5)
                move.l  #word_21A32,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$90,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5) ; '`'
                lea     (word_FFC6E0).w,a5
                move.w  #$CC00,word_FFC6E2-word_FFC6E0(a5)
                move.w  #$10,(a5)
                move.l  #word_21A32,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$1B0,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5) ; '`'
                clr.w   (word_FFE306).w
                clr.w   (word_FFE386).w
                move.w  #$FFF2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE300).w,a0
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.b  #0,(word_FFF7F4+1).w
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA90C).w
                clr.w   (dword_FFA908).w
                jsr (Gfx_SetupScrollPlanes).l
                move.w  (word_FFFF38).w,(word_FFFF60).w
                move.w  #0,(word_FFFF38).w
                move.b  #$90,d0
                jsr (Sys_WaitVBlank).l
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                clr.w   (word_FFA000).w
                rts
; End of function Credits_InitXiTiger
; ---------------------------------------------------------------------------
stru_20B4A:     dc.w 7                  ; field_0
                                        ; DATA XREF: Credits_InitXiTiger+16   o
                dc.l tiles_18B2FA       ; field_2
                dc.w $4000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_14ADEE        ; field_2
                dc.w $B000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18CD7C        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18CC50        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w $FFFF


; Main loop for credits sequence processing objects and graphics
Credits_MainLoop:                              ; DATA XREF: Sys_DispatchGameState+E6   o  ; was: sub_20B74
                jsr (Gfx_UpdateScrollPosition).l
                jsr (Sys_InitObjectPointers).l
                jsr (UI_CheckVBlankFlag).l
                jsr (Sys_ProcessVisibleObjects).l
                bsr.w Credits_StateDispatcher
                jsr (Sys_UpdateObjectCount).l
                jsr (Sys_ProcessObjectList).l
                jsr (Gfx_FadePaletteTransition).l
                jsr (Gfx_SetupScrollPlanes).l
                addq.w  #1,(word_FFA000).w
                rts
; End of function Credits_MainLoop
; Dispatches to current credits state handler based on state index
Credits_StateDispatcher:                              ; CODE XREF: Credits_MainLoop+18   p  ; was: sub_20BAE
                subq.w  #1,(word_FF0188).l
                move.w  (GameSubstateIndex).w,d0
                lea     off_20BC0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Credits_StateDispatcher
; ---------------------------------------------------------------------------
off_20BC0:      dc.w Credits_FadeInState-*        ; DATA XREF: Credits_StateDispatcher+A   o
                dc.w Credits_ScrollWithColorCycle-*
                dc.w Credits_WaitForTimerEnd-*
                dc.w Credits_FadeOutAndClearVRAM-*
                dc.w Credits_FadeInFromBlack-*
                dc.w Credits_WaitForScrollEnd-*
                dc.w Credits_FadeOutAndExit-*


; Handles fade-in transition at start of credits sequence
Credits_FadeInState:                              ; DATA XREF: ROM:off_20BC0   o  ; was: sub_20BCE
                jsr Credits_UpdateScrollTables(pc)   ; (pc)
                nop
                move.w  (word_FFA000).w,d0
                cmpi.w  #$80,d0
                bcs.w   locret_20C30
                andi.w  #$F,d0
                bne.w   locret_20C30
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE300).w,a0
                move.w  #$2F,d5 ; '/'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   locret_20C30
                move.w  #$FFF0,(word_FF0176).l
                clr.w   (word_FF00EC).l
                clr.w   (word_FF017C).l
                move.w  #$4D80,(word_FF0188).l
                addq.w  #2,(GameSubstateIndex).w
locret_20C30:                           ; CODE XREF: Credits_FadeInState+E   j
                                        ; Credits_FadeInState+16   j ...
                rts
; End of function Credits_FadeInState
; Scrolls credits text with color cycling palette effect
Credits_ScrollWithColorCycle:                              ; DATA XREF: ROM:00020BC2   o  ; was: sub_20C32
                jsr (UI_SelectionMenuDispatcher).l
                bsr.w Credits_XiTigerVBlankSync
                jsr Credits_UpdateScrollTables(pc)   ; (pc)
                nop
                bsr.w Credits_CyclePaletteColors
                move.w  (word_FFA000).w,d0
                cmpi.w  #$11C0,d0
                bcs.w   locret_20C30
                andi.w  #$F,d0
                bne.w   locret_20C30
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE360).w,a0
                move.w  #$F,d5
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   locret_20C30
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_ScrollWithColorCycle
; Waits for timer to reach specific value before advancing state
Credits_WaitForTimerEnd:                              ; DATA XREF: ROM:00020BC4   o  ; was: sub_20C88
                jsr (UI_SelectionMenuDispatcher).l
                bsr.w Credits_XiTigerVBlankSync
                jsr Credits_UpdateScrollTables(pc)   ; (pc)
                nop
                bsr.w Credits_CyclePaletteColors
                cmpi.w  #$3000,(word_FF0188).l
                bne.w   locret_20C30
                move.w  #0,(word_FF0176).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_WaitForTimerEnd
; Cycles RGB color values in palette entries with XOR operation
Credits_CyclePaletteColors:                              ; CODE XREF: Credits_ScrollWithColorCycle+10   p  ; was: sub_20CB6
                                        ; Credits_WaitForTimerEnd+10   p
                eori.w  #$22E,(word_FFE328).w
                eori.w  #$2E2,(word_FFE32A).w
                eori.w  #$226,(word_FFE32C).w
                rts
; End of function Credits_CyclePaletteColors
; Updates horizontal scroll tables with 3D rotation effect
Credits_UpdateScrollTables:                              ; CODE XREF: Credits_FadeInState   p  ; was: sub_20CCA
                                        ; Credits_ScrollWithColorCycle+A   p ...
                move.l  (dword_FF0114).l,d0
                add.l   d0,(dword_FF0110).l
                move.l  (dword_FF0110).l,d1
                move.l  d1,d3
                asr.l   #2,d3
                move.l  d1,d0
                asr.l   #1,d0
                neg.l   d0
                lea     (word_FFE5C2).w,a0
                move.w  #$D,d7
loc_20CEE:                              ; CODE XREF: Credits_UpdateScrollTables+32   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #$20,a0 ; ' '
                dbf     d7,loc_20CEE
                move.l  (dword_FF0110).l,d1
                move.l  d1,d0
                asr.l   #1,d0
                lea     (word_FFE5A2).w,a0
                move.w  #$D,d7
loc_20D12:                              ; CODE XREF: Credits_UpdateScrollTables+56   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #$20,a0 ; ' '
                dbf     d7,loc_20D12
                move.l  (dword_FF0110).l,d1
                move.l  d1,d3
                asr.l   #1,d3
                move.l  d1,d0
                neg.l   d0
                asl.l   #1,d1
                lea     (word_FFEC2A).w,a0
                move.w  #9,d7
loc_20D3C:                              ; CODE XREF: Credits_UpdateScrollTables+80   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #4,a0
                dbf     d7,loc_20D3C
                move.l  (dword_FF0110).l,d1
                move.l  d1,d0
                asl.l   #1,d1
                lea     (word_FFEC26).w,a0
                move.w  #9,d7
loc_20D60:                              ; CODE XREF: Credits_UpdateScrollTables+A4   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #4,a0
                dbf     d7,loc_20D60
                rts
; End of function Credits_UpdateScrollTables
; Fades out palette and clears VRAM plane data
Credits_FadeOutAndClearVRAM:                              ; DATA XREF: ROM:00020BC6   o  ; was: sub_20D74
                jsr (UI_SelectionMenuDispatcher).l
                bsr.w Credits_XiTigerVBlankSync
                jsr Credits_UpdateScrollTables(pc)   ; (pc)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_20C30
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5 ; '/'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   locret_20C30
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_20DDE:                              ; CODE XREF: Credits_FadeOutAndClearVRAM+6C   j
                move.w  d1,(a0)
                dbf     d0,loc_20DDE
                move    (sp)+,sr
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$60000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_20E0C:                              ; CODE XREF: Credits_FadeOutAndClearVRAM+9A   j
                move.w  d1,(a0)
                dbf     d0,loc_20E0C
                move    (sp)+,sr
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_FadeOutAndClearVRAM
; Fades palette from black to normal colors
Credits_FadeInFromBlack:                              ; DATA XREF: ROM:00020BC8   o  ; was: sub_20E1A
                jsr (UI_SelectionMenuDispatcher).l
                bsr.w Credits_XiTigerVBlankSync
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_20C30
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5 ; '/'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   locret_20C30
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_FadeInFromBlack
; Waits for scroll sequence to complete before advancing
Credits_WaitForScrollEnd:                              ; DATA XREF: ROM:00020BCA   o  ; was: sub_20E5E
                jsr (UI_SelectionMenuDispatcher).l
                bsr.w Credits_XiTigerVBlankSync
                bsr.w Credits_ScrollStateDispatcher
                tst.w   (word_FF0188).l
                bne.w   locret_20C30
                move.w  #0,(word_FF0176).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_WaitForScrollEnd
; Fades out and returns to title screen mode
Credits_FadeOutAndExit:                              ; DATA XREF: ROM:00020BCC   o  ; was: sub_20E84
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE300).w,a0
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   locret_20C30
                move.w  #1,(word_FFFF46).w
                move.w  (word_FFFF60).w,(word_FFFF38).w
                jsr (Sys_ClearBossDataBuffer).l
                move.w  #$84,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; End of function Credits_FadeOutAndExit
; Xi-Tiger VBlank sync
Credits_XiTigerVBlankSync:                              ; CODE XREF: Credits_ScrollWithColorCycle+6   p  ; was: sub_20ECC
                                        ; Credits_WaitForTimerEnd+6   p ...
                cmpi.w  #$1F40,(word_FF0188).l
                beq.s   loc_20EEC
                cmpi.w  #$1EC0,(word_FF0188).l
                beq.s   loc_20EF6
                cmpi.w  #$A0,(word_FF0188).l
                beq.s   loc_20EEC
                rts
; ---------------------------------------------------------------------------
loc_20EEC:                              ; CODE XREF: Credits_XiTigerVBlankSync+8   j
                                        ; Credits_XiTigerVBlankSync+1C   j
                move.b  #1,d0
                jmp (Sys_WaitVBlank).l
; ---------------------------------------------------------------------------
loc_20EF6:                              ; CODE XREF: Credits_XiTigerVBlankSync+12   j
                move.b  #$94,d0
                jmp (Sys_WaitVBlank).l
; End of function Credits_XiTigerVBlankSync
; Dispatches to scroll sequence state handler
Credits_ScrollStateDispatcher:                              ; CODE XREF: Credits_WaitForScrollEnd+A   p  ; was: sub_20F00
                move.w  (word_FF017C).l,d0
                lea     off_20F0E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Credits_ScrollStateDispatcher
; ---------------------------------------------------------------------------
off_20F0E:      dc.w Stage_InitializeCreditsScreen-*        ; DATA XREF: Credits_ScrollStateDispatcher+6   o
                dc.w Stage_LoadCreditsDataPhase-*
                dc.w Stage_WaitForPlayerInput-*
                dc.w Stage_UpdateCreditsLoop-*
                dc.w Credits_TreasureScreen1-*
                dc.w Credits_TreasureScreen2-*
                dc.w Stage_WaitTimerAndInput-*
                dc.w Gfx_FadeOutPaletteCredits-*
                dc.w Credits_TreasureScreen1-*
                dc.w Credits_SegaScreen-*
                dc.w Stage_WaitTimerAndInput-*
                dc.w Gfx_FadeOutPaletteCredits-*
                dc.w nullsub_54-*


; Initialize credits screen with sprite objects and palette data
Stage_InitializeCreditsScreen:                              ; DATA XREF: ROM:off_20F0E   o  ; was: sub_20F28
                clr.w   (word_FF017E).l
                lea     stru_2158C(pc),a0
                nop
                jsr (Data_ProcessPointer).l
                lea     word_2156C(pc),a0
                nop
                lea     (word_FFE340).w,a1
                bsr.w Data_Copy32Bytes
                lea     (word_FFC680).w,a5
                move.w  #$CC00,word_FFC682-word_FFC680(a5)
                move.w  #$10,(a5)
                move.l  #word_21A32,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$90,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5) ; '`'
                lea     (word_FFC6E0).w,a5
                move.w  #$CC00,word_FFC6E2-word_FFC6E0(a5)
                move.w  #$10,(a5)
                move.l  #word_21A32,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$1B0,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5) ; '`'
                clr.w   (word_FFE306).w
                move.b  #3,(word_FFF7E6+1).w
                move.b  #1,(byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                lea     (word_FFE400).w,a0
                move.l  #$7F008000,d1
                move.w  #$EF,d0
loc_20FD8:                              ; CODE XREF: Stage_InitializeCreditsScreen+B2   j
                move.l  d1,(a0)+
                dbf     d0,loc_20FD8
                move.w  #$AA,(word_FF018E).l
                move.l  #off_214C8,(dword_FF018A).l
                move.l  #$FFFFE320,(dword_FF0190).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Stage_InitializeCreditsScreen
; Load next phase of credits data and process pointer
Stage_LoadCreditsDataPhase:                              ; DATA XREF: ROM:00020F10   o  ; was: sub_21002
                subq.w  #1,(word_FF018E).l
                bne.w   locret_20C30
                movea.l (dword_FF018A).l,a2
                movea.l (a2)+,a0
                movea.l (dword_FF0190).l,a1
                bsr.w Data_Copy32Bytes
                movea.l (a2)+,a0
                jsr (Data_ProcessPointer).l
                move.w  #$160,(word_FF018E).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Stage_LoadCreditsDataPhase
; Wait for timer and check player input to advance
Stage_WaitForPlayerInput:                              ; DATA XREF: ROM:00020F12   o  ; was: sub_21036
                subq.w  #1,(word_FF018E).l
                tst.w   (word_FFF720).w
                bmi.w   locret_20C30
                clr.w   (word_FF0194).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Stage_WaitForPlayerInput
; Main credits update loop with data cycling
Stage_UpdateCreditsLoop:                              ; DATA XREF: ROM:00020F14   o  ; was: sub_21052
                bsr.w Gfx_FadeInPaletteEntry
                bsr.w Gfx_FadeAllPaletteEntries
                subq.w  #1,(word_FF018E).l
                bne.w   locret_20C30
                move.w  #$AA,(word_FF018E).l
                move.w  #2,(word_FF017C).l
                addq.l  #8,(dword_FF018A).l
                eori.l  #$40,(dword_FF0190).l ; '@'
                movea.l (dword_FF018A).l,a2
                tst.l   (a2)
                bpl.w   locret_20C30
                move.w  #$1A0,(word_FF018E).l
                move.w  #8,(word_FF017C).l
                rts
; End of function Stage_UpdateCreditsLoop
; Fade in single palette entry by modifying color value
Gfx_FadeInPaletteEntry:                              ; CODE XREF: Stage_UpdateCreditsLoop   p  ; was: sub_210A2
                move.w  (word_FF0194).l,d0
                cmpi.w  #$1E0,d0
                bcc.w   locret_20C30
                addq.w  #2,(word_FF0194).l
                move.w  word_210CE(pc,d0.w),d1
                lea     (word_FFE400).w,a0
                move.l  (a0,d1.w),d2
                subi.l  #$7FFF8,d2
                move.l  d2,(a0,d1.w)
                rts
; End of function Gfx_FadeInPaletteEntry
; ---------------------------------------------------------------------------
word_210CE:	binclude	"data/other/word_210CE.bin"
word_210CE_End:


; Fade all palette entries in buffer
Gfx_FadeAllPaletteEntries:                              ; CODE XREF: Stage_UpdateCreditsLoop+4   p  ; was: sub_212AE
                lea     (word_FFE400).w,a0
                move.l  #$7FFF8,d1
                move.w  #$EF,d0
loc_212BC:                              ; CODE XREF: Gfx_FadeAllPaletteEntries+20   j
                move.l  (a0),d2
                andi.l  #$FF00FF,d2
                beq.s   loc_212CC
                move.l  (a0),d2
                sub.l   d1,d2
                move.l  d2,(a0)
loc_212CC:                              ; CODE XREF: Gfx_FadeAllPaletteEntries+16   j
                addq.l  #4,a0
                dbf     d0,loc_212BC
                rts
; End of function Gfx_FadeAllPaletteEntries
; Treasure screen handler 1
Credits_TreasureScreen1:                              ; DATA XREF: ROM:00020F16   o  ; was: sub_212D4
                                        ; ROM:00020F1E   o
                subq.w  #1,(word_FF018E).l
                bne.w   locret_20C30
                move.w  #$160,(word_FF018E).l
                move.w  #0,(word_FF0176).l
                lea     (word_FFE320).w,a0
                lea     (dword_FFE3A0).w,a1
                bsr.w Data_Copy32Bytes
                bsr.w Data_Copy32Bytes
                bsr.w Data_Copy32Bytes
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_TreasureScreen1
; Treasure screen handler 2
Credits_TreasureScreen2:                              ; DATA XREF: ROM:00020F18   o  ; was: sub_2130A
                subq.w  #1,(word_FF018E).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_20C30
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5 ; '/'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   locret_20C30
                clr.w   (word_FFC680).w
                clr.w   (word_FFC6E0).w
                move.b  #0,(word_FFF7E6+1).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA908).w
                move.b  #4,(byte_FFA95A).w
                move.b  #4,(byte_FFA95B).w
                lea     word_2197E(pc),a0
                nop
                lea     (dword_FFE3A0).w,a1
                bsr.w Data_Copy32Bytes
                bsr.w Data_Copy32Bytes
                bsr.w Data_Copy32Bytes
                lea     stru_219DE(pc),a0
                nop
                jsr (Data_ProcessPointer).l
                move.w  #$220,(word_FF018E).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_TreasureScreen2
; Wait for timer countdown and check for player skip
Stage_WaitTimerAndInput:                              ; DATA XREF: ROM:00020F1A   o  ; was: sub_2139A
                                        ; ROM:00020F22   o
                subq.w  #1,(word_FF018E).l
                tst.w   (word_FFF720).w
                bmi.w   locret_20C30
                addq.w  #2,(word_FF017C).l
                rts
; End of function Stage_WaitTimerAndInput
; Fade out palette to black for credits
Gfx_FadeOutPaletteCredits:                              ; DATA XREF: ROM:00020F1C   o  ; was: sub_213B0
                                        ; ROM:00020F24   o
                subq.w  #1,(word_FF018E).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_20C30
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5 ; '/'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   locret_20C30
                addq.w  #2,(word_FF017C).l
                rts
; End of function Gfx_FadeOutPaletteCredits
; Sega presentation screen
Credits_SegaScreen:                              ; DATA XREF: ROM:00020F20   o  ; was: sub_213F2
                subq.w  #1,(word_FF018E).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_20C30
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5 ; '/'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   locret_20C30
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_21454:                              ; CODE XREF: Credits_SegaScreen+64   j
                move.w  d1,(a0)
                dbf     d0,loc_21454
                move    (sp)+,sr
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$60000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_21482:                              ; CODE XREF: Credits_SegaScreen+92   j
                move.w  d1,(a0)
                dbf     d0,loc_21482
                move    (sp)+,sr
                lea     word_21A00(pc),a0
                nop
                lea     ((dword_FFE3DE+2)).w,a1
                bsr.w Data_Copy32Bytes
                lea     stru_21A20(pc),a0
                nop
                jsr (Data_ProcessPointer).l
                move.w  #$1E0,(word_FF018E).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_SegaScreen
nullsub_54:                             ; DATA XREF: ROM:00020F26   o
                rts
; End of function nullsub_54


; Copy 32 bytes (8 longwords) from source to destination
Data_Copy32Bytes:                              ; CODE XREF: Stage_InitializeCreditsScreen+1C   p  ; was: sub_214B6
                                        ; Stage_LoadCreditsDataPhase+18   p ...
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
off_214C8:      dc.l word_2165E         ; DATA XREF: Stage_InitializeCreditsScreen+BE   o
                dc.l stru_2167E
                dc.l word_216C2
                dc.l stru_216E2
                dc.l word_216F4
                dc.l stru_21714
                dc.l word_21758
                dc.l stru_21778
                dc.l word_2162C
                dc.l stru_2164C
                dc.l word_21596
                dc.l stru_215B6
                dc.l word_215C8
                dc.l stru_215E8
                dc.l word_2178A
                dc.l stru_217AA
                dc.l word_21690
                dc.l stru_216B0
                dc.l word_21726
                dc.l stru_21746
                dc.l word_217BC
                dc.l stru_217DC
                dc.l word_217EE
                dc.l stru_2180E
                dc.l word_21820
                dc.l stru_21840
                dc.l word_215FA
                dc.l stru_2161A
                dc.l word_21852
                dc.l stru_21872
                dc.l word_21884
                dc.l stru_218A4
                dc.l word_218B6
                dc.l stru_218D6
                dc.l word_218E8
                dc.l stru_21908
                dc.l word_2191A
                dc.l stru_2193A
                dc.l word_2194C
                dc.l stru_2196C
                dc.l $FFFFFFFF
word_2156C:     dc.w 0, 0, $EEE, $EE, $AE, $6E, $E, 4, $48, $C88, $EAA, $ECC, $EEE, $600, $840, $C84
                                        ; DATA XREF: Stage_InitializeCreditsScreen+12   o
stru_2158C:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_InitializeCreditsScreen+6   o
                dc.l byte_14ADEE        ; field_2
                dc.w $B000              ; field_6
                dc.w $FFFF
word_21596:     dc.w 0, $202, $404, $626, $848, $A6A, $EEE, $C8C, $EAE, $22, $EEE, $46, $28A, $6CE, $E, 0
                                        ; DATA XREF: ROM:000214F0   o
stru_215B6:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:000214F4   o
                dc.l tiles_14AE08       ; field_2
                dc.w $8000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_14B91C        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_215C8:     dc.w 0, 0, $EEE, $ECC, $AA8, $884, $EEE, $206, $42C, $A8E, $440, $28A, $6CC, $224, $248, $68C
                                        ; DATA XREF: ROM:000214F8   o
stru_215E8:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:000214FC   o
                dc.l tiles_14BB82       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l byte_14D064        ; field_2
                dc.w $C000              ; field_6
                dc.w $FFFF
word_215FA:     dc.w 0, 0, $EEE, $FFFF, $FFFF, $FFFF, $FFFF, $CCA, $AA6, $A64, $642, $46E, $2A, 6, $2AC, $46
                                        ; DATA XREF: ROM:00021530   o
stru_2161A:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:00021534   o
                dc.l tiles_14D272       ; field_2
                dc.w $8000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_14F2B6        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_2162C:     dc.w 0, 0, $EEE, $ECC, $EAA, $E88, $FFFF, $422, $644, $C68, $206, $42C, $88E, $42, $284, $2CA
                                        ; DATA XREF: ROM:000214E8   o
stru_2164C:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:000214EC   o
                dc.l tiles_14F542       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l byte_14FD6A        ; field_2
                dc.w $C000              ; field_6
                dc.w $FFFF
word_2165E:     dc.w 0, 0, $EEE, $ECC, $CAA, $A88, $FFFF, 4, $26, $4A, $6C, $2AE, $222, $444, $2A, $46E
                                        ; DATA XREF: ROM:off_214C8   o
stru_2167E:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:000214CC   o
                dc.l tiles_14FF06       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l byte_150D1C        ; field_2
                dc.w $C000              ; field_6
                dc.w $FFFF
word_21690:     dc.w 0, 0, $EEE, $ECC, $EAA, $E88, $FFFF, $204, $208, $20C, $44E, $88E, $24, $46, $6A, $2AE
                                        ; DATA XREF: ROM:00021508   o
stru_216B0:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:0002150C   o
                dc.l tiles_150EC8       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l byte_151CDE        ; field_2
                dc.w $C000              ; field_6
                dc.w $FFFF
word_216C2:     dc.w 0, $200, $CEE, $226, $88A, $24, $FFFF, $46, $28A, $6CE, $4C, 8, 4, $FFFF, $668, $AAC
                                        ; DATA XREF: ROM:000214D0   o
stru_216E2:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:000214D4   o
                dc.l tiles_151F30       ; field_2
                dc.w $8000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_152D60        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_216F4:     dc.w 0, 0, $EEE, $6E4, $80, $28, $FFFF, $6C, $AE, $422, $446, $488, $8CC, 6, $20C, $66E
                                        ; DATA XREF: ROM:000214D8   o
stru_21714:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:000214DC   o
                dc.l tiles_152FC4       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l byte_15389A        ; field_2
                dc.w $C000              ; field_6
                dc.w $FFFF
word_21726:     dc.w 0, 0, $EEE, $6E4, $80, $28, $FFFF, $6C, $AE, $422, $446, $488, $8CC, 6, $20C, $66E
                                        ; DATA XREF: ROM:00021510   o
stru_21746:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:00021514   o
                dc.l tiles_153B34       ; field_2
                dc.w $8000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_1543E0        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_21758:     dc.w 0, 0, $EEE, $6AC, $48A, $268, $FFFF, $246, $24, $206, $22A, $26C, 0, $202, $624, $868
                                        ; DATA XREF: ROM:000214E0   o
stru_21778:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:000214E4   o
                dc.l tiles_1545E4       ; field_2
                dc.w $8000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_1557D6        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_2178A:     dc.w 0, 0, $EEE, $FFFF, $FFFF, $FFFF, $FFFF, $8C, $6A, $48, $26, $46E, $2A, 6, $888, $444
                                        ; DATA XREF: ROM:00021500   o
stru_217AA:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:00021504   o
                dc.l tiles_1559BE       ; field_2
                dc.w $8000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_157036        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_217BC:     dc.w 0, 0, $EEE, $ECC, $EAA, $E88, $FFFF, $E02, $420, $A44, 6, $2A, $46E, $24, $268, $4AC
                                        ; DATA XREF: ROM:00021518   o
stru_217DC:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:0002151C   o
                dc.l tiles_1571FE       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l byte_158674        ; field_2
                dc.w $C000              ; field_6
                dc.w $FFFF
word_217EE:     dc.w 0, 0, $EEE, $ECC, $EAA, $E88, $FFFF, 6, $2A, $46E, $22, $244, $288, $26, $48, $8C
                                        ; DATA XREF: ROM:00021520   o
stru_2180E:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:00021524   o
                dc.l tiles_158854       ; field_2
                dc.w $8000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_159440        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_21820:     dc.w 0, 0, $EEE, $ECC, $A88, $866, $FFFF, $644, $422, $26, $4A, $8E, $400, $A42, $E86, 8
                                        ; DATA XREF: ROM:00021528   o
stru_21840:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:0002152C   o
                dc.l tiles_15960E       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l byte_15B086        ; field_2
                dc.w $C000              ; field_6
                dc.w $FFFF
word_21852:     dc.w 0, $204, $EEE, $ACA, $466, $44, $EEE, $2CE, $8C, $8E, $4C, $2A, $208, $68, $6AE, $AEE
                                        ; DATA XREF: ROM:00021538   o
stru_21872:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:0002153C   o
                dc.l tiles_15B2B6       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l byte_15C020        ; field_2
                dc.w $C000              ; field_6
                dc.w $FFFF
word_21884:     dc.w 0, $600, $EEE, $666, $444, $442, $EEE, $AAA, $866, $E48, $C26, $A24, $802, $26, $8C, $EAC
                                        ; DATA XREF: ROM:00021540   o
stru_218A4:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:00021544   o
                dc.l tiles_15C24E       ; field_2
                dc.w $8000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_15D00A        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_218B6:     dc.w 0, $220, $EEE, $28C, $46, $242, $EEE, $C8, $84, $4C6, $284, $62, $42, $40, $6C, $4EA
                                        ; DATA XREF: ROM:00021548   o
stru_218D6:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:0002154C   o
                dc.l tiles_15D13E       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l byte_15E960        ; field_2
                dc.w $C000              ; field_6
                dc.w $FFFF
word_218E8:     dc.w 0, $402, $EEE, $66C, $448, $224, $EEE, $A8A, $668, $CCA, $A88, $866, $222, $28, $6E, $CCC
                                        ; DATA XREF: ROM:00021550   o
stru_21908:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:00021554   o
                dc.l tiles_15EB98       ; field_2
                dc.w $8000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_15FF52        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_2191A:     dc.w 0, $202, $EEE, $6EE, $28A, $222, $EEE, $EA8, $A64, $EA8, $E62, $C22, $802, $402, $484, $EEC
                                        ; DATA XREF: ROM:00021558   o
stru_2193A:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:0002155C   o
                dc.l tiles_160124       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l byte_16114A        ; field_2
                dc.w $C000              ; field_6
                dc.w $FFFF
word_2194C:     dc.w 0, 0, $EEE, $E88, $844, $422, 0, $200, 2, 4, $24, $46, $268, $4AC, $6CE, $AE
                                        ; DATA XREF: ROM:00021560   o
stru_2196C:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:00021564   o
                dc.l tiles_161336       ; field_2
                dc.w $2000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_163A32        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_2197E:     dc.w 0, $EEE, $EEC, $ECA, $CA8, $A86, $864, $642, $420, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE, $EEE
                                        ; DATA XREF: Credits_TreasureScreen2+5E   o
                dc.w 0, $200, $400, $600, $802, $A04, $C06, $E08, $E2A, $E4C, $E6E, $E8E, $EAE, $ECE, $EEE, $EEE
                dc.w 0, $EEE, $EEE, 2, 4, 6, $28, $4A, $6C, $8E, $AE, $CE, $2EE, $6EE, $AEE, $EEE
stru_219DE:     dc.w 7                  ; field_0
                                        ; DATA XREF: Credits_TreasureScreen2+74   o
                dc.l tiles_163E1E       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_164ADA       ; field_2
                dc.w $8000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_16494A        ; field_2
                dc.w $C000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_164E24        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF
word_21A00:     dc.w 0, $EEE, $EC0, $EA0, $E80, $E60, $E40, $E20, $E00, $C00, $A00, $800, $E00, $E00, $E00, $EEE
                                        ; DATA XREF: Credits_SegaScreen+98   o
stru_21A20:     dc.w 7                  ; field_0
                                        ; DATA XREF: Credits_SegaScreen+A6   o
                dc.l tiles_164F02       ; field_2
                dc.w $800               ; field_6
                dc.w 7                  ; field_0
                dc.l byte_16537C        ; field_2
                dc.w $C61C              ; field_6
                dc.w $FFFF
word_21A32:     dc.w $580, $F0F, $A0F0  ; DATA XREF: Credits_InitXiTiger+122   o
                                        ; Credits_InitXiTiger+158   o ...
                dc.w $580, $F0F, $C0F0
                dc.w $580, $F0F, $E0F0
                dc.w $580, $F0F, $F0
                dc.w $580, $F0F, $20F0
                dc.w $580, $F0F, $40F0
                dc.w $8580, $F0F, $60F0


; Dispatcher for selection menu state machine
UI_SelectionMenuDispatcher:                              ; CODE XREF: Credits_ScrollWithColorCycle   p  ; was: sub_21A5C
                                        ; sub_20C88   p ...
                move.w  (word_FF00EC).l,d0
                lea     off_21A6A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function UI_SelectionMenuDispatcher
; ---------------------------------------------------------------------------
off_21A6A:      dc.w UI_BuildSelectionMenu-*        ; DATA XREF: UI_SelectionMenuDispatcher+6   o
                dc.w UI_BuildSelectionMenu_ProcessLoop-*
                dc.w UI_WaitForMenuComplete-*
                dc.w UI_MenuDelayTimer-*
                dc.w nullsub_55-*


; Build selection menu with character icons
UI_BuildSelectionMenu:                              ; DATA XREF: ROM:off_21A6A   o  ; was: sub_21A74
                move.w  #$222,(word_FFE302).w
                move.w  #$EEE,(word_FFE304).w
                move.l  #word_21BC0,(dword_FF00F8).l
                addq.w  #2,(word_FF00EC).l
; Main loop processing menu item data and initializing floating icons
UI_BuildSelectionMenu_ProcessLoop:                              ; DATA XREF: ROM:00021A6C   o  ; was: loc_21A90
                lea     (word_FFC740).w,a0
                movea.l (dword_FF00F8).l,a1
                moveq   #0,d0
                move.b  (a1)+,d0
                bmi.w   loc_21B88
                add.w   d0,d0
                move.w  d0,(word_FF00FC).l
                move.b  (a1)+,d0
                beq.w   loc_21B0C
                move.w  d0,d1
                subq.w  #1,d1
                add.w   d1,d1
                add.w   d1,d1
                move.w  #$120,d3
                sub.w   d1,d3
                move.w  #$E4,d4
                move.w  d0,d1
                subq.w  #1,d1
                muls.w  #$10,d1
                move.w  #$180,d5
                sub.w   d1,d5
                move.w  d0,d7
                subq.w  #1,d7
loc_21AD4:                              ; CODE XREF: UI_BuildSelectionMenu+94   j
                move.b  (a1)+,d0
                cmpi.b  #0,d0
                beq.s   loc_21AFE
                bsr.w Effect_InitFloatingIcon
                add.w   d0,d0
                ori.w   #$8000,d0
                move.w  d0,$E(a0)
                move.w  d3,$10(a0)
                move.w  d4,$14(a0)
                move.w  d5,$4C(a0)
                move.w  (word_FF00FC).l,$46(a0)
loc_21AFE:                              ; CODE XREF: UI_BuildSelectionMenu+66   j
                addq.w  #8,d3
                addi.w  #$20,d5 ; ' '
                lea     $60(a0),a0
                dbf     d7,loc_21AD4
loc_21B0C:                              ; CODE XREF: UI_BuildSelectionMenu+38   j
                moveq   #0,d0
                move.b  (a1)+,d0
                add.w   d0,d0
                move.w  d0,(word_FF00FC).l
                move.b  (a1)+,d0
                beq.w   loc_21B7A
                move.w  d0,d1
                subq.w  #1,d1
                add.w   d1,d1
                add.w   d1,d1
                move.w  #$120,d3
                sub.w   d1,d3
                move.w  #$FC,d4
                move.w  d0,d1
                subq.w  #1,d1
                muls.w  #$10,d1
                addi.w  #$80,d1
                move.w  d1,d5
                move.w  d0,d7
                subq.w  #1,d7
loc_21B42:                              ; CODE XREF: UI_BuildSelectionMenu+102   j
                move.b  (a1)+,d0
                cmpi.b  #0,d0
                beq.s   loc_21B6C
                bsr.w Effect_InitFloatingIcon
                add.w   d0,d0
                ori.w   #$8000,d0
                move.w  d0,$E(a0)
                move.w  d3,$10(a0)
                move.w  d4,$14(a0)
                move.w  d5,$4C(a0)
                move.w  (word_FF00FC).l,$46(a0)
loc_21B6C:                              ; CODE XREF: UI_BuildSelectionMenu+D4   j
                addq.w  #8,d3
                subi.w  #$20,d5 ; ' '
                lea     $60(a0),a0
                dbf     d7,loc_21B42
loc_21B7A:                              ; CODE XREF: UI_BuildSelectionMenu+A6   j
                move.l  a1,(dword_FF00F8).l
                addq.w  #2,(word_FF00EC).l
                rts
; ---------------------------------------------------------------------------
loc_21B88:                              ; CODE XREF: UI_BuildSelectionMenu+2A   j
                move.w  #8,(word_FF00EC).l
                rts
; End of function UI_BuildSelectionMenu
; Wait for menu animation to complete
UI_WaitForMenuComplete:                              ; DATA XREF: ROM:00021A6E   o  ; was: sub_21B92
                lea     (word_FFC740).w,a0
                cmpi.w  #$464,(a0)
                beq.s   locret_21BAA
                move.w  #$10,(word_FF00FC).l
                addq.w  #2,(word_FF00EC).l
locret_21BAA:                           ; CODE XREF: UI_WaitForMenuComplete+8   j
                rts
; End of function UI_WaitForMenuComplete
; Delay timer for menu state transitions
UI_MenuDelayTimer:                              ; DATA XREF: ROM:00021A70   o  ; was: sub_21BAC
                subq.w  #1,(word_FF00FC).l
                bpl.s   locret_21BBC
                move.w  #2,(word_FF00EC).l
locret_21BBC:                           ; CODE XREF: UI_MenuDelayTimer+6   j
                rts
; End of function UI_MenuDelayTimer
nullsub_55:                             ; DATA XREF: ROM:00021A72   o
                rts
; End of function nullsub_55
; ---------------------------------------------------------------------------
word_21BC0:	binclude	"data/other/word_21BC0.bin"
word_21BC0_End:


; Initialize floating icon sprite properties
Effect_InitFloatingIcon:                              ; CODE XREF: UI_BuildSelectionMenu+68   p  ; was: sub_21F2A
                                        ; UI_BuildSelectionMenu+D6   p
                move.w  #$464,(a0)
                move.w  #$4000,2(a0)
                clr.b   $20(a0)
                move.l  #byte_21F4A,8(a0)
                clr.l   $18(a0)
                clr.l   $1C(a0)
                rts
; End of function Effect_InitFloatingIcon
; ---------------------------------------------------------------------------
byte_21F4A:     dc.b $83, 0, 1, 0, $F8, $FC
                                        ; DATA XREF: Effect_InitFloatingIcon+E   o


; Dispatcher for floating icon animation states
Effect_FloatingIconDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_21F50
                move.w  4(a5),d0
                lea     off_21F5C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Effect_FloatingIconDispatcher
; ---------------------------------------------------------------------------
off_21F5C:      dc.w Effect_FloatingIconInit-*        ; DATA XREF: Effect_FloatingIconDispatcher+4   o
                dc.w Effect_FloatingIconFloat-*
                dc.w Effect_FloatingIconReturn-*
                dc.w Effect_MoveUpAndSetTarget-*
                dc.w Effect_WaitAndSetFallGravity-*
                dc.w Physics_DecreaseGravity-*


; Initialize floating icon trajectory and velocity
Effect_FloatingIconInit:                              ; DATA XREF: ROM:off_21F5C   o  ; was: sub_21F68
                addq.w  #2,4(a5)
                move.l  $10(a5),$50(a5)
                move.l  $14(a5),$54(a5)
                move.w  #8,$4A(a5)
                move.w  $4C(a5),d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a4
                move.w  word_1B494-word_1B514(a4,d0.w),d1
                move.w  (a4,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                move.w  (word_FFA280).w,d0
                add.w   d0,$4C(a5)
                andi.w  #$1FE,$4C(a5)
                rts
; End of function Effect_FloatingIconInit
; Animate floating icon with circular motion
Effect_FloatingIconFloat:                              ; CODE XREF: Effect_FloatingIconFloat+24   j  ; was: sub_21FB4
                                        ; DATA XREF: ROM:00021F5E   o
                addq.w  #1,$48(a5)
                addi.w  #4,$4C(a5)
                addi.w  #2,$4E(a5)
                move.l  $18(a5),d0
                add.l   d0,$50(a5)
                move.l  $1C(a5),d0
                add.l   d0,$54(a5)
                subq.w  #1,$4A(a5)
                bne.s Effect_FloatingIconFloat
                cmpi.w  #$5C,$48(a5) ; '\'
                bcc.s   loc_21FEA
                move.w  #8,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_21FEA:                              ; CODE XREF: Effect_FloatingIconFloat+2C   j
                bsr.w Math_CalculateIconPosition
                neg.l   $18(a5)
                neg.l   $1C(a5)
                bset    #7,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Effect_FloatingIconFloat
; Calculate icon position using sine/cosine tables
Math_CalculateIconPosition:                              ; CODE XREF: Effect_FloatingIconFloat:loc_21FEA   p  ; was: sub_22002
                                        ; Effect_FloatingIconReturn+16   p ...
                move.w  $4C(a5),d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a4
                move.w  word_1B494-word_1B514(a4,d0.w),d1
                move.w  (a4,d0.w),d0
                muls.w  $4E(a5),d0
                muls.w  $4E(a5),d1
                asr.l   #1,d1
                add.l   $50(a5),d0
                add.l   $54(a5),d1
                move.l  d0,$10(a5)
                move.l  d1,$14(a5)
                rts
; End of function Math_CalculateIconPosition
; Return floating icon to original position
Effect_FloatingIconReturn:                              ; DATA XREF: ROM:00021F60   o  ; was: sub_22034
                subi.w  #4,$4C(a5)
                move.l  $18(a5),d0
                add.l   d0,$50(a5)
                move.l  $1C(a5),d0
                add.l   d0,$54(a5)
                bsr.w Math_CalculateIconPosition
                subq.w  #1,$48(a5)
                bne.s   locret_2205E
                andi.w  #$FFFE,$4E(a5)
                addq.w  #2,4(a5)
locret_2205E:                           ; CODE XREF: Effect_FloatingIconReturn+1E   j
                rts
; End of function Effect_FloatingIconReturn
; Update palette color based on icon animation frame
Gfx_UpdateIconPalette:
                cmpa.w  #$C740,a5  ; was: sub_22060
                bne.s   locret_22074
                move.w  $48(a5),d0
                lsr.w   #4,d0
                add.w   d0,d0
                move.w  word_22076(pc,d0.w),(word_FFE302).w
locret_22074:                           ; CODE XREF: Gfx_UpdateIconPalette+4   j
                rts
; End of function Gfx_UpdateIconPalette
; ---------------------------------------------------------------------------
word_22076:     dc.w $222, $444, $666, $888, $AAA, $CCC, $EEE
                                        ; DATA XREF: Gfx_UpdateIconPalette+E   r


; Moves object up by decrementing Y position, waits for timer, then sets target Y offset
Effect_MoveUpAndSetTarget:                              ; DATA XREF: ROM:00021F62   o  ; was: sub_22084
                subi.w  #$10,$4C(a5)
                bsr.w Math_CalculateIconPosition
                subq.w  #2,$4E(a5)
                bpl.s   locret_220A4
                move.w  $46(a5),d0
                addi.w  #$20,d0 ; ' '
                move.w  d0,$48(a5)
                addq.w  #2,4(a5)
locret_220A4:                           ; CODE XREF: Effect_MoveUpAndSetTarget+E   j
                rts
; End of function Effect_MoveUpAndSetTarget
; Waits for timer, then sets object to falling state with gravity value
Effect_WaitAndSetFallGravity:                              ; DATA XREF: ROM:00021F64   o  ; was: sub_220A6
                subq.w  #1,$48(a5)
                bne.s   locret_220C4
                bset    #1,2(a5)
                bset    #2,2(a5)
                move.l  #$10000,$1C(a5)
                addq.w  #2,4(a5)
locret_220C4:                           ; CODE XREF: Effect_WaitAndSetFallGravity+4   j
                rts
; End of function Effect_WaitAndSetFallGravity
; Decreases gravity/velocity by subtracting from long word at offset 0x1C
Physics_DecreaseGravity:                              ; DATA XREF: ROM:00021F66   o  ; was: sub_220C6
                subi.l  #$800,$1C(a5)
                rts
; End of function Physics_DecreaseGravity
; Main controller for Z-Leo boss fight, handles palette updates and state dispatch
Boss_ZLeoMainController:                              ; CODE XREF: Stage_UpdateGameplay+6   p  ; was: sub_220D0
                tst.w   (dword_FF9400).w
                beq.w   loc_220E0
                bsr.w Boss_ZLeoPaletteUpdate
                bsr.w Boss_ZLeoPaletteEffect1
loc_220E0:                              ; CODE XREF: Boss_ZLeoMainController+4   j
                move.w  (dword_FF9400).w,d0
                lea     off_220EC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ZLeoMainController
; ---------------------------------------------------------------------------
off_220EC:      dc.w Boss_ZLeoIntroSequence-*        ; DATA XREF: Boss_ZLeoMainController+14   o
                dc.w Boss_ZLeoIntroSequence_PaletteWait-*
                dc.w Boss_ZLeoWaitCameraPosition-*
                dc.w Boss_ZLeoWaitTimer-*
                dc.w Boss_ZLeoCameraScroll-*
                dc.w Credits_PaletteInit-*
                dc.w Credits_ScrollUpdate1-*
                dc.w Credits_ScrollUpdate2-*
                dc.w Credits_ScrollUpdate3-*
                dc.w Credits_ScrollUpdate4-*
                dc.w Credits_ScrollUpdate5-*
                dc.w Credits_UpdateGraphics1-*
                dc.w Credits_UpdateGraphics2-*
                dc.w Credits_UpdateGraphics3-*
                dc.w Credits_UpdateGraphics4-*
                dc.w Credits_LoadTiles-*
                dc.w Credits_FadeOutPrepare-*
                dc.w Credits_FadeOutWaitInput-*
                dc.w nullsub_56-*


; Initializes Z-Leo boss intro with palette effects, camera setup and credits
Boss_ZLeoIntroSequence:                              ; DATA XREF: ROM:off_220EC   o  ; was: sub_22112
                addq.w  #2,(dword_FF9400).w
                clr.w   (word_FFA45E).w
                lea     (Entity_ObjectPool).w,a0
                move.w  #$10,(a0)
                move.w  #$C00,2(a0)
                clr.w   $C(a0)
                move.w  #$40,$10(a0) ; '@'
                move.w  #$F0,$14(a0)
                move.w  #1,(dword_FF9410).w
                move.w  #$A0,(dword_FF9410+2).w
                move.w  #$F0,(dword_FF9414).w
                move.w  #$1F,(dword_FF9414+2).w
                move.w  #$7F,(dword_FF9418).w
                move.w  #7,(dword_FF941C).w
                bsr.w Boss_ZLeoPaletteEffect2
                move.w  #$40,(dword_FF9400+2).w ; '@'
; Wait for palette effect countdown during Z-Leo intro
Boss_ZLeoIntroSequence_PaletteWait:                              ; DATA XREF: ROM:000220EE   o  ; was: loc_22166
                bsr.w Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_2217E
                move.w  #4,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
                bsr.w Credits_UpdateTilemap
locret_2217E:                           ; CODE XREF: Boss_ZLeoIntroSequence+5C   j
                rts
; End of function Boss_ZLeoIntroSequence
; Waits for camera Y position to reach 0x1E0 before advancing state
Boss_ZLeoWaitCameraPosition:                              ; DATA XREF: ROM:000220F0   o  ; was: sub_22180
                bsr.w Boss_ZLeoPaletteEffect2
                cmpi.w  #$1E0,(dword_FFC630).w
                bcs.s   locret_2219A
                clr.w   (dword_FFC638).w
                move.w  #$40,(dword_FF9400+2).w ; '@'
                addq.w  #2,(dword_FF9400).w
locret_2219A:                           ; CODE XREF: Boss_ZLeoWaitCameraPosition+A   j
                rts
; End of function Boss_ZLeoWaitCameraPosition
; Waits for timer countdown with palette effects before advancing state
Boss_ZLeoWaitTimer:                              ; DATA XREF: ROM:000220F2   o  ; was: sub_2219C
                bsr.w Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_221AA
                addq.w  #2,(dword_FF9400).w
locret_221AA:                           ; CODE XREF: Boss_ZLeoWaitTimer+8   j
                rts
; End of function Boss_ZLeoWaitTimer
; Scrolls camera upward with acceleration until reaching final position
Boss_ZLeoCameraScroll:                              ; DATA XREF: ROM:000220F4   o  ; was: sub_221AC
                cmpi.w  #$60,(dword_FF9410+2).w ; '`'
                blt.s   loc_221C2
                move.w  (dword_FF9408+2).w,d0
                sub.w   d0,(dword_FF9410+2).w
                bsr.w Boss_ZLeoPaletteEffect2
                bra.s   loc_221EA
; ---------------------------------------------------------------------------
loc_221C2:                              ; CODE XREF: Boss_ZLeoCameraScroll+6   j
                move.w  #1,(dword_FF9410).w
                move.w  #$160,(dword_FF9410+2).w
                move.w  #$F0,(dword_FF9414).w
                move.w  #$FF,(dword_FF9414+2).w
                move.w  #$7F,(dword_FF9418).w
                move.w  #7,(dword_FF941C).w
                bsr.w Boss_ZLeoPaletteEffect2
loc_221EA:                              ; CODE XREF: Boss_ZLeoCameraScroll+14   j
                addi.l  #$800,(dword_FF9408+2).w
                cmpi.l  #$80000,(dword_FF9408+2).w
                bne.s   locret_22214
                bset    #0,(word_FFC622).w
                move.l  #$78000,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
                move.w  #$160,(dword_FF9410+2).w
locret_22214:                           ; CODE XREF: Boss_ZLeoCameraScroll+4E   j
                rts
; End of function Boss_ZLeoCameraScroll
; Initialize credits palette
Credits_PaletteInit:                              ; DATA XREF: ROM:000220F6   o  ; was: sub_22216
                bsr.w Boss_ZLeoPaletteEffect2
                cmpi.w  #$120,(dword_FFC630).w
                bgt.s   locret_2222C
                move.l  (dword_FF9408+2).w,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
locret_2222C:                           ; CODE XREF: Credits_PaletteInit+A   j
                rts
; End of function Credits_PaletteInit
; Credits scroll update 1
Credits_ScrollUpdate1:                              ; DATA XREF: ROM:000220F8   o  ; was: sub_2222E
                move.w  #2,(dword_FF9410).w
                move.w  #$160,(dword_FF9410+2).w
                move.w  #$F0,(dword_FF9414).w
                move.w  #$FF,(dword_FF9414+2).w
                move.w  #$7F,(dword_FF9418).w
                move.w  #7,(dword_FF941C).w
                bsr.w Boss_ZLeoPaletteEffect2
                addq.w  #2,(dword_FF9400).w
                move.w  #$80,(dword_FF9400+2).w
                rts
; End of function Credits_ScrollUpdate1
; Credits scroll update 2
Credits_ScrollUpdate2:                              ; DATA XREF: ROM:000220FA   o  ; was: sub_22262
                bsr.w Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_22276
                move.w  #$80,(dword_FF9400+2).w
                addq.w  #2,(dword_FF9400).w
locret_22276:                           ; CODE XREF: Credits_ScrollUpdate2+8   j
                rts
; End of function Credits_ScrollUpdate2
; Credits scroll update 3
Credits_ScrollUpdate3:                              ; DATA XREF: ROM:000220FC   o  ; was: sub_22278
                bsr.w Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_22294
                bclr    #0,(word_FFC622).w
                move.l  #$FFFE0000,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
locret_22294:                           ; CODE XREF: Credits_ScrollUpdate3+8   j
                rts
; End of function Credits_ScrollUpdate3
; Credits scroll update 4
Credits_ScrollUpdate4:                              ; DATA XREF: ROM:000220FE   o  ; was: sub_22296
                bsr.w Boss_ZLeoPaletteEffect2
                addi.l  #$1000,(dword_FFC638).w
                btst    #7,(dword_FFC638).w
                bne.s   locret_222B8
                move.b  #$D5,d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,(dword_FF9400).w
locret_222B8:                           ; CODE XREF: Credits_ScrollUpdate4+12   j
                rts
; End of function Credits_ScrollUpdate4
; Credits scroll update 5
Credits_ScrollUpdate5:                              ; DATA XREF: ROM:00022100   o  ; was: sub_222BA
                bsr.w Boss_ZLeoPaletteEffect2
                addi.l  #$1000,(dword_FFC638).w
                cmpi.w  #$1E0,(dword_FFC630).w
                blt.s   locret_222DC
                addq.w  #1,(dword_FF9410).w
                addq.w  #2,(dword_FF9400).w
                move.w  #$80,(dword_FF9400+2).w
locret_222DC:                           ; CODE XREF: Credits_ScrollUpdate5+12   j
                rts
; End of function Credits_ScrollUpdate5
; Credits graphics update 1
Credits_UpdateGraphics1:                              ; DATA XREF: ROM:00022102   o  ; was: sub_222DE
                bsr.w Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_222F8
                move.w  #$80,(dword_FF9400+2).w
                move.w  #4,(dword_FF9410).w
                addq.w  #2,(dword_FF9400).w
locret_222F8:                           ; CODE XREF: Credits_UpdateGraphics1+8   j
                rts
; End of function Credits_UpdateGraphics1
; Credits graphics update 2
Credits_UpdateGraphics2:                              ; DATA XREF: ROM:00022104   o  ; was: sub_222FA
                bsr.w Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_22308
                addq.w  #2,(dword_FF9400).w
locret_22308:                           ; CODE XREF: Credits_UpdateGraphics2+8   j
                rts
; End of function Credits_UpdateGraphics2
; Credits graphics update 3
Credits_UpdateGraphics3:                              ; DATA XREF: ROM:00022106   o  ; was: sub_2230A
                bsr.w Boss_ZLeoPaletteEffect2
                move.w  #$40,(dword_FF9400+2).w ; '@'
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Credits_UpdateGraphics3
; Credits graphics update 4
Credits_UpdateGraphics4:                              ; DATA XREF: ROM:00022108   o  ; was: sub_2231A
                bsr.w Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_2232C
                clr.w   (dword_FF9400+2).w
                addq.w  #2,(dword_FF9400).w
locret_2232C:                           ; CODE XREF: Credits_UpdateGraphics4+8   j
                rts
; End of function Credits_UpdateGraphics4
; Load credits tiles
Credits_LoadTiles:                              ; DATA XREF: ROM:0002210A   o  ; was: sub_2232E
                move.w  (dword_FF9400+2).w,d0
                bsr.w Credits_FadeOut
                btst    #0,(word_FFA280+1).w
                bne.s   loc_22378
                btst    #1,(word_FFA280+1).w
                bne.s   loc_22378
                addq.w  #1,(dword_FF9400+2).w
                cmpi.w  #$E,(dword_FF9400+2).w
                bls.s   locret_22376
                addq.w  #2,(dword_FF9400).w
                lea     (word_FFE380).w,a0
                move.w  #$1F,d7
                moveq   #0,d0
loc_22360:                              ; CODE XREF: Credits_LoadTiles+34   j
                move.l  d0,(a0)+
                dbf     d7,loc_22360
                move.w  #$80,(dword_FF9400+2).w
                move.b  #$C1,d0
                jsr (Sound_PlaySFX).l
locret_22376:                           ; CODE XREF: Credits_LoadTiles+22   j
                rts
; ---------------------------------------------------------------------------
loc_22378:                              ; CODE XREF: Credits_LoadTiles+E   j
                                        ; Credits_LoadTiles+16   j
                bsr.w Boss_ZLeoPaletteEffect2
                rts
; End of function Credits_LoadTiles
; Prepares fade out effect for credits sequence with timer countdown
Credits_FadeOutPrepare:                              ; DATA XREF: ROM:0002210C   o  ; was: sub_2237E
                move.w  #$E,d0
                bsr.w Credits_FadeOut
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_2239E
                move.w  #$E,(dword_FF9400+2).w
                clr.l   (dword_FF9408+2).w
                clr.w   (dword_FF9410).w
                addq.w  #2,(dword_FF9400).w
locret_2239E:                           ; CODE XREF: Credits_FadeOutPrepare+C   j
                rts
; End of function Credits_FadeOutPrepare
; Continues fade out while checking for player input to skip
Credits_FadeOutWaitInput:                              ; DATA XREF: ROM:0002210E   o  ; was: sub_223A0
                move.w  (dword_FF9400+2).w,d0
                bsr.w Credits_FadeOut
                btst    #0,(word_FFA280+1).w
                bne.s   locret_223C8
                btst    #1,(word_FFA280+1).w
                bne.s   locret_223C8
                subq.w  #1,(dword_FF9400+2).w
                bpl.s   locret_223C8
                move.w  #$8C,(GameModeIndex).w
                addq.w  #2,(dword_FF9400).w
locret_223C8:                           ; CODE XREF: Credits_FadeOutWaitInput+E   j
                                        ; Credits_FadeOutWaitInput+16   j ...
                rts
; End of function Credits_FadeOutWaitInput
nullsub_56:                             ; DATA XREF: ROM:00022110   o
                rts
; End of function nullsub_56


; Credits fade out effect
Credits_FadeOut:                              ; CODE XREF: Credits_LoadTiles+4   p  ; was: sub_223CC
                                        ; Credits_FadeOutPrepare+4   p ...
                andi.w  #$E,d0
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jmp (Gfx_ApplyPaletteFade).l
; End of function Credits_FadeOut
; Palette update handler
Boss_ZLeoPaletteUpdate:                              ; CODE XREF: Boss_ZLeoMainController+8   p  ; was: sub_223E2
                move.l  (dword_FF9408+2).w,d0
                add.l   d0,(dword_FFA900).w
                rts
; End of function Boss_ZLeoPaletteUpdate
; Debug function for manual camera control using directional inputs
Debug_CameraManualControl:
                btst    #2,(word_FFF706).w  ; was: sub_223EC
                beq.s   loc_223F8
                subq.w  #4,(dword_FFA410).w
loc_223F8:                              ; CODE XREF: Debug_CameraManualControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_22404
                addq.w  #4,(dword_FFA410).w
loc_22404:                              ; CODE XREF: Debug_CameraManualControl+12   j
                btst    #0,(word_FFF706).w
                beq.s   loc_22410
                subq.w  #4,(dword_FFA414).w
loc_22410:                              ; CODE XREF: Debug_CameraManualControl+1E   j
                btst    #1,(word_FFF706).w
                beq.s   locret_2241C
                addq.w  #4,(dword_FFA414).w
locret_2241C:                           ; CODE XREF: Debug_CameraManualControl+2A   j
                rts
; End of function Debug_CameraManualControl
; Updates camera position from sine/cosine table data for scrolling effects
Stage_UpdateCameraFromTable:
                lea     (word_1B514).l,a4  ; was: sub_2241E
                addi.w  #4,(dword_FF9404).w
                addi.w  #2,(dword_FF9404+2).w
                move.w  (dword_FF9404).w,d0
                addi.w  #$1FE,d0
                move.w  (a4,d0.w),d0
                muls.w  #$40,d0 ; '@'
                addi.l  #$1200000,d0
                move.l  d0,(dword_FFA410).w
                move.w  (dword_FF9404+2).w,d0
                addi.w  #$1FE,d0
                move.w  (a4,d0.w),d0
                muls.w  #$20,d0 ; ' '
                addi.l  #$F00000,d0
                move.l  d0,(dword_FFA414).w
                rts
; End of function Stage_UpdateCameraFromTable
; Palette effect handler 1
Boss_ZLeoPaletteEffect1:                              ; CODE XREF: Boss_ZLeoMainController+C   p  ; was: sub_22466
                cmpi.w  #$80,(dword_FFC630).w
                blt.s   loc_2248A
                cmpi.w  #$1C0,(dword_FFC630).w
                bgt.s   loc_2248A
                bset    #7,(word_FFA402).w
                move.l  (dword_FFC630).w,(dword_FFA410).w
                move.l  (dword_FFC634).w,(dword_FFA414).w
                rts
; ---------------------------------------------------------------------------
loc_2248A:                              ; CODE XREF: Boss_ZLeoPaletteEffect1+6   j
                                        ; Boss_ZLeoPaletteEffect1+E   j
                move.l  #$60,(dword_FFA410).w ; '`'
                bclr    #7,(word_FFA402).w
                rts
; End of function Boss_ZLeoPaletteEffect1
; Palette effect handler 2
Boss_ZLeoPaletteEffect2:                              ; CODE XREF: Boss_ZLeoIntroSequence+4A   p  ; was: sub_2249A
                                        ; sub_22112:loc_22166   p ...
                move.w  (dword_FF9410).w,d7
                subq.w  #1,d7
                bmi.w   locret_2254A
loc_224A4:                              ; CODE XREF: Boss_ZLeoPaletteEffect2+84   j
                jsr     (RandomNumber).l
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_2254A
                jsr (Sprite_InitializeProperties).l
                move.b  #$60,$20(a0) ; '`'
                move.b  (dword_FFFF08+2).w,d6
                andi.w  #3,d6
                add.w   d6,d6
                move.b  (dword_FFFF08).w,d0
                move.w  (dword_FF9414+2).w,d1
                and.w   d1,d0
                and.w   d1,d0
                addq.w  #1,d1
                lsr.w   #1,d1
                sub.w   d1,d0
                add.w   (dword_FF9410+2).w,d0
                add.w   word_2254C(pc,d6.w),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                move.w  (dword_FF9418).w,d1
                and.w   d1,d0
                addq.w  #1,d1
                lsr.w   #1,d1
                sub.w   d1,d0
                add.w   (dword_FF9414).w,d0
                add.w   word_22554(pc,d6.w),d0
                move.w  d0,$14(a0)
                move.l  (dword_FF9408+2).w,d0
                asr.l   #1,d0
                move.l  d0,$18(a0)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #7,d0
                lsl.w   #2,d0
                move.l  off_2255C(pc,d0.w),8(a0)
                dbf     d7,loc_224A4
                tst.w   (dword_FF941C).w
                beq.s   locret_2254A
                move.w  (dword_FFFF08).w,d0
                and.w   (dword_FF941C).w,d0
                bne.s   locret_2254A
                cmpi.w  #$18,(dword_FF9400).w
                bcc.s   loc_22540
                move.b  #$30,d0 ; '0'
                bra.s   loc_22544
; ---------------------------------------------------------------------------
loc_22540:                              ; CODE XREF: Boss_ZLeoPaletteEffect2+9E   j
                move.b  #$2F,d0 ; '/'
loc_22544:                              ; CODE XREF: Boss_ZLeoPaletteEffect2+A4   j
                jsr (Sound_PlaySFX).l
locret_2254A:                           ; CODE XREF: Boss_ZLeoPaletteEffect2+6   j
                                        ; Boss_ZLeoPaletteEffect2+16   j ...
                rts
; End of function Boss_ZLeoPaletteEffect2
; ---------------------------------------------------------------------------
word_2254C:     dc.w $20, 0, $FFE0, 0   ; DATA XREF: Boss_ZLeoPaletteEffect2+46   r
word_22554:     dc.w 0, $A, $FFF0, 0    ; DATA XREF: Boss_ZLeoPaletteEffect2+62   r
off_2255C:      dc.l off_E953C          ; DATA XREF: Boss_ZLeoPaletteEffect2+7E   r
                dc.l off_E9560
                dc.l off_E9584
                dc.l off_E95A4
                dc.l off_E95A4
                dc.l off_E95DC
                dc.l off_E9584
                dc.l off_E953C


; Update credits tilemap
Credits_UpdateTilemap:                              ; CODE XREF: Boss_ZLeoIntroSequence+68   p  ; was: sub_2257C
                lea     (word_FFA400).w,a5
                move.b  #$41,d0 ; 'A'
                jsr (Sound_PlaySFX).l
                movea.w #(word_FFC5C0-M68K_RAM),a0
                move.w  #$230,(a0)
                move.b  #$54,$21(a0) ; 'T'
                move.w  #$4000,2(a0)
                move.l  #word_E8F22,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                eori.w  #$1000,$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                rts
; End of function Credits_UpdateTilemap
; ---------------------------------------------------------------------------
unused_5:	binclude	"data/other/unused_5.bin"
unused_5_End:


; Demo playback system with input recording and VDP state management
Demo_PlaybackSystem:                              ; CODE XREF: Sys_DispatchGameState:loc_C6C   p  ; was: sub_23CBA
                tst.w   (word_FFFF5A).w
                beq.w   locret_23D46
                move.w  #0,(word_FFFF56).w
                tst.w   (word_FFFF5C).w
                bne.w   loc_23D48
                move.l  #$8522BD7A,(dword_FFFF08).w
                clr.w   (word_FFA280).w
                clr.w   (word_FFA000).w
                move.w  (word_FFFF0E).w,(word_FFFF5E).w
                move.w  (word_FFFF38).w,(word_FFFF60).w
                move.b  (byte_FFFF30).w,(byte_FFFF66).w
                move.w  #2,(word_FFFF0E).w
                move.w  #0,(word_FFFF38).w
                move.b  #0,(byte_FFFF30).w
                clr.w   (word_FFFF48).w
                move.w  (word_FFFF62).w,d0
                andi.w  #6,d0
                lea     word_23E96(pc),a0
                nop
                move.w  (a0,d0.w),(word_FFFF64).w
                lsl.w   #1,d0
                jsr Demo_GetInputPointer(pc)   ; (pc)
                nop
                move.w  (a0)+,(word_FFFF4A).w
                move.l  a0,(dword_FFFF4C).w
                move.w  #$1000,(word_FFFF58).w
                addq.w  #4,(word_FFFF5C).w
                tst.w   (word_FFFF56).w
                beq.w   locret_23D46
                clr.w   (word_FFFF50).w
                clr.w   (word_FFFF4A).w
locret_23D46:                           ; CODE XREF: Demo_PlaybackSystem+4   j
                                        ; Demo_PlaybackSystem+80   j ...
                rts
; ---------------------------------------------------------------------------
loc_23D48:                              ; CODE XREF: Demo_PlaybackSystem+12   j
                tst.w   (word_FFF720).w
                bmi.w   loc_23D5A
                btst    #7,(word_FFF708).w
                bne.w   loc_23D8C
loc_23D5A:                              ; CODE XREF: Demo_PlaybackSystem+92   j
                tst.w   (word_FFFF58).w
                beq.w   loc_23D8C
                cmpi.w  #$80,(word_FFFF58).w
                bne.s   loc_23D70
                move.b  #1,(byte_FF830E).w
loc_23D70:                              ; CODE XREF: Demo_PlaybackSystem+AE   j
                bsr.w Demo_HandlePlaybackInput
                tst.w   (word_FFFF56).w
                bne.s   loc_23D86
                move.b  (word_FFFF52).w,(word_FFF706).w
                move.b  (word_FFFF52+1).w,(word_FFF708).w
loc_23D86:                              ; CODE XREF: Demo_PlaybackSystem+BE   j
                subq.w  #1,(word_FFFF58).w
                rts
; ---------------------------------------------------------------------------
loc_23D8C:                              ; CODE XREF: Demo_PlaybackSystem+9C   j
                                        ; Demo_PlaybackSystem+A4   j
                clr.b   (byte_FFF807).w
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                clr.w   (word_FFFF5A).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.w  (word_FFFF5E).w,(word_FFFF0E).w
                move.w  (word_FFFF60).w,(word_FFFF38).w
                move.b  (byte_FFFF66).w,(byte_FFFF30).w
                addq.w  #2,(word_FFFF62).w
                andi.w  #6,(word_FFFF62).w
                move.b  #4,(dword_FFF80A).w
                lea     (word_FFE300).w,a0
                moveq   #0,d0
                move.w  #$3F,d1 ; '?'
loc_23DD2:                              ; CODE XREF: Demo_PlaybackSystem+11A   j
                move.l  d0,(a0)+
                dbf     d1,loc_23DD2
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.w  (word_FFF7D2).w,(VDP_CTRL).l
                move.b  #0,(word_FFF7F4+1).w
                move.w  (word_FFF7F4).w,(VDP_CTRL).l
                move.b  #$10,(word_FFF7DE+1).w
                move.w  (word_FFF7DE).w,(VDP_CTRL).l
                andi.b  #$EF,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
                rts
; End of function Demo_PlaybackSystem
; Handles demo playback mode with input recording and frame timing
Demo_HandlePlaybackInput:                              ; CODE XREF: Demo_PlaybackSystem:loc_23D70   p  ; was: sub_23E16
                tst.w   (word_FFFF56).w
                bne.w   loc_23E3E
                move.w  (word_FFFF48).w,(word_FFFF52).w
                subq.w  #1,(word_FFFF4A).w
                bne.w   locret_23D46
                movea.l (dword_FFFF4C).w,a0
                move.w  (a0)+,(word_FFFF48).w
                move.w  (a0)+,(word_FFFF4A).w
                move.l  a0,(dword_FFFF4C).w
                rts
; ---------------------------------------------------------------------------
loc_23E3E:                              ; CODE XREF: Demo_HandlePlaybackInput+4   j
                move.b  (word_FFF706).w,d0
                lsl.w   #8,d0
                move.b  (word_FFF708).w,d0
                cmp.w   (word_FFFF48).w,d0
                bne.s   loc_23E54
                addq.w  #1,(word_FFFF4A).w
                rts
; ---------------------------------------------------------------------------
loc_23E54:                              ; CODE XREF: Demo_HandlePlaybackInput+36   j
                lea     ($FFFC0000).l,a1
                movea.w (word_FFFF50).w,a0
                move.w  (word_FFFF4A).w,(a1,a0.w)
                move.w  d0,2(a1,a0.w)
                move.b  (word_FFF706).w,(word_FFFF48).w
                move.b  (word_FFF708).w,(word_FFFF48+1).w
                move.w  #1,(word_FFFF4A).w
                addi.w  #4,(word_FFFF50).w
                rts
; End of function Demo_HandlePlaybackInput
; Returns appropriate input data pointer for demo playback or recording
Demo_GetInputPointer:                              ; CODE XREF: Demo_PlaybackSystem+64   p  ; was: sub_23E82
                                        ; DATA XREF: Demo_PlaybackSystem+64   o
                tst.w   (word_FFFF56).w
                bne.s   loc_23E8E
                movea.l off_23E9E(pc,d0.w),a0
                rts
; ---------------------------------------------------------------------------
loc_23E8E:                              ; CODE XREF: Demo_GetInputPointer+4   j
                lea     ($FFFC0000).l,a0
                rts
; End of function Demo_GetInputPointer
; ---------------------------------------------------------------------------
word_23E96:     dc.w 2, $E, $12, $1E    ; DATA XREF: Demo_PlaybackSystem+56   o
off_23E9E:      dc.l word_23EAE         ; DATA XREF: Demo_GetInputPointer+6   r
                dc.l word_24A50
                dc.l word_25142
                dc.l word_259C8
word_23EAE:	binclude	"data/other/word_23EAE.bin"
word_23EAE_End:
word_24A50:	binclude	"data/other/word_24A50.bin"
word_24A50_End:
word_25142:	binclude	"data/other/word_25142.bin"
word_25142_End:
word_259C8:	binclude	"data/other/word_259C8.bin"
word_259C8_End:


; Decompresses cutscene graphics data
Gfx_DecompressCutsceneData:                              ; CODE XREF: Cutscene_InitializeScene+36   p  ; was: sub_260A2
                                        ; Cutscene_LoadInitialAssets+34   j
                move.l  #$1FFFE,(dword_FF9F08).w
                move.w  #$1E,(word_FF9F10).w
                move.w  #$B,(word_FF9F12).w
                move.w  #0,(word_FF9F14).w
                move.w  #8,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.w  #2,(word_FF8090).w
                rts
; End of function Gfx_DecompressCutsceneData
; Loads cutscene frame to video memory
Gfx_LoadCutsceneFrame:                              ; CODE XREF: Cutscene_HandleScrollInput+4E   j  ; was: sub_260CE
                                        ; Cutscene_XiTigerWaitComplete+44   j
                movea.l #$FFFF0400,a0
                move.w  #$9400,(dword_FF8040).w
                move.w  #$C400,(dword_FF8040+2).w
                move.l  (dword_FF9F08).w,d0
                move.l  d0,(dword_FF9F0C).w
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_260EC:                              ; CODE XREF: Gfx_LoadCutsceneFrame+1A   j
                moveq   #0,d3
                moveq   #0,d4
                moveq   #$13,d6
loc_260F2:                              ; CODE XREF: Gfx_LoadCutsceneFrame+64   j
                movea.w (dword_FF8040).w,a1
                movea.w (dword_FF8040).w,a2
                lea     $26(a1),a1
                lea     $28(a2),a2
                suba.w  d3,a1
                adda.w  d3,a2
                add.l   d0,d4
                move.l  d4,d1
                swap    d1
                andi.w  #$FFFE,d1
                move.w  d1,d2
                neg.w   d1
                move.w  #$80,d5
                move.w  (word_FF9F12).w,d7
loc_2611C:                              ; CODE XREF: Gfx_LoadCutsceneFrame+5E   j
                move.w  $26(a0,d1.w),(a1)
                move.w  $28(a0,d2.w),(a2)
                add.w   d5,d1
                add.w   d5,d2
                adda.w  d5,a1
                adda.w  d5,a2
                dbf     d7,loc_2611C
                addq.w  #2,d3
                dbf     d6,loc_260F2
                movea.w (word_FFF70C).w,a4
                move.w  (dword_FF8040+2).w,d0
                move.w  (word_FF9F12).w,d7
loc_26142:                              ; CODE XREF: Gfx_LoadCutsceneFrame+B2   j
                move.w  #$83,-(a4)
                move.w  d0,d4
                andi.w  #$3FFE,d4
                ori.w   #$4000,d4
                move.w  d4,-(a4)
                move.b  (dword_FF8040).w,d4
                move.b  (dword_FF8040+1).w,d5
                asr.b   #1,d4
                roxr.b  #1,d5
                move.b  d5,-(a4)
                move.b  #$95,-(a4)
                move.b  d4,-(a4)
                move.b  #$96,-(a4)
                move.l  #$8F02977F,-(a4)
                move.l  #$94009328,-(a4)
                addi.w  #$80,d0
                addi.w  #$80,(dword_FF8040).w
                dbf     d7,loc_26142
                move.w  a4,(word_FFF70C).w
                moveq   #$F,d0
                move.l  (dword_FF9F0C).w,d1
                movea.w #(byte_FF9F80-M68K_RAM),a1
                adda.w  (word_FF9F10).w,a1
                movea.w a1,a2
                subi.l  #$20000,d1
                asl.l   #2,d1
                move.w  #$FFFF,d4
                move.w  (word_FF9F14).w,d5
                moveq   #0,d6
                moveq   #0,d7
                sub.l   d1,d7
loc_261AE:                              ; CODE XREF: Gfx_LoadCutsceneFrame:loc_261D2   j
                cmpa.w  #$9F80,a1
                bmi.s   loc_261C0
                sub.l   d1,d6
                move.l  d6,d3
                swap    d3
                and.w   d4,d3
                add.w   d5,d3
                move.w  d3,-(a1)
loc_261C0:                              ; CODE XREF: Gfx_LoadCutsceneFrame+E4   j
                cmpa.w  #$9FC0,a2
                bpl.s   loc_261D2
                add.l   d1,d7
                move.l  d7,d3
                swap    d3
                and.w   d4,d3
                add.w   d5,d3
                move.w  d3,(a2)+
loc_261D2:                              ; CODE XREF: Gfx_LoadCutsceneFrame+F6   j
                dbf     d0,loc_261AE
                rts
; End of function Gfx_LoadCutsceneFrame
; Renders processed tilemap data to VRAM with VDP setup and DMA transfer
Gfx_RenderTilemapToVRAM:
                tst.w   (word_FFF720).w  ; was: sub_261D8
                bne.w   locret_2626A
                bsr.w Gfx_InitializeWaveParameters
loc_261E4:                              ; CODE XREF: Gfx_RenderTilemapToVRAM+3A   j
                bsr.w Gfx_CalculateTileCoordinates
                bsr.w Gfx_PrepareTilePointers
                bsr.w Gfx_PixelBlendDispatcher
                lea     1(a4),a4
                move.w  a4,d0
                move.w  d0,d1
                andi.w  #3,d0
                asl.w   #3,d1
                andi.w  #$FFE0,d1
                or.w    d1,d0
                andi.l  #$FFFF,d0
                addi.l  #-$10000,d0
                movea.l d0,a2
                dbf     d7,loc_261E4
                movea.l #word_26640,a0
                move.w  (word_FF8102).w,d0
                move.w  (a0,d0.w),d0
                move.w  #$1400,d1
                move.w  d0,d2
                rol.w   #2,d2
                andi.w  #3,d2
                swap    d0
                andi.l  #$3FFF0000,d0
                ori.l   #$40000000,d0
                move.w  d2,d0
                move    #$2700,sr
                lea     (VDP_DATA).l,a1
                lea     (VDP_CTRL).l,a2
                move.w  #$8F02,(a2)
                movea.l #$FFFF0000,a0
                move.l  d0,(a2)
loc_2625C:                              ; CODE XREF: Gfx_RenderTilemapToVRAM+86   j
                move.l  (a0)+,(a1)
                dbf     d1,loc_2625C
                move    #$2300,sr
                addq.w  #2,(word_FF8102).w
locret_2626A:                           ; CODE XREF: Gfx_RenderTilemapToVRAM+4   j
                rts
; End of function Gfx_RenderTilemapToVRAM
; Initializes scrolling effect parameters for stage background layer
Stage_InitScrollEffect1:
                move.w  #2,(word_FF8100).w  ; was: sub_2626C
                move.w  #0,(word_FF8102).w
                move.w  #0,(word_FF8104).w
                move.w  #$70,(word_FFEC02).w ; 'p'
                rts
; End of function Stage_InitScrollEffect1
; Stops scrolling effect by resetting state variables and counters
Stage_StopScrollEffect:
                move.b  #4,(word_FFF7D0+1).w  ; was: sub_26286
                move.b  #$30,(word_FFF7D4+1).w ; '0'
                move.w  #0,(word_FF8100).w
                move.w  #0,(word_FFEC02).w
                rts
; End of function Stage_StopScrollEffect
; Main controller for wave/distortion effect, dispatches to state handlers
Effect_WaveController:
                bsr.w Memory_ClearBuffer  ; was: sub_262A0
                movea.w (word_FF8104).w,a0
                movea.l off_262AE(pc,a0.w),a0
                jmp     (a0)
; End of function Effect_WaveController
; ---------------------------------------------------------------------------
off_262AE:      dc.l Effect_WaveInitialize          ; DATA XREF: Effect_WaveController+8   r
                dc.l Effect_WaveHoldState
                dc.l Effect_WaveFadeOut
                dc.l Effect_WaveLoopOrEnd
                dc.l Gfx_UpdateScrollEffect
                dc.l Gfx_ScrollEffectEmptyState


; Initializes wave effect by setting up buffer and incrementing counter
Effect_WaveInitialize:                              ; DATA XREF: ROM:off_262AE   o  ; was: sub_262C6
                movea.l #$FFFF9E40,a6
                bsr.w Gfx_GenerateWaveDeformation
                bsr.w   nullsub_57
                addq.w  #2,(word_FF8102).w
                cmpi.w  #$1C,(word_FF8102).w
                bne.w   locret_262EC
                addq.w  #4,(word_FF8104).w
                move.w  #$78,(dword_FF8040).w ; 'x'
locret_262EC:                           ; CODE XREF: Effect_WaveInitialize+18   j
                rts
; End of function Effect_WaveInitialize
; Holds wave effect active state while waiting for timer countdown
Effect_WaveHoldState:                              ; DATA XREF: ROM:000262B2   o  ; was: sub_262EE
                movea.l #$FFFF9E40,a6
                bsr.w Gfx_GenerateWaveDeformation
                subq.w  #1,(dword_FF8040).w
                bne.w   locret_2630A
                addq.w  #4,(word_FF8104).w
                move.w  #1,(dword_FF8040).w
locret_2630A:                           ; CODE XREF: Effect_WaveHoldState+E   j
                rts
; End of function Effect_WaveHoldState
; Fades out wave effect by decrementing counter back to minimum value
Effect_WaveFadeOut:                              ; DATA XREF: ROM:000262B6   o  ; was: sub_2630C
                movea.l #$FFFF9E80,a6
                bsr.w Gfx_GenerateWaveDeformation
                subq.w  #2,(word_FF8102).w
                cmpi.w  #6,(word_FF8102).w
                bne.w   locret_26328
                addq.w  #4,(word_FF8104).w
locret_26328:                           ; CODE XREF: Effect_WaveFadeOut+14   j
                rts
; End of function Effect_WaveFadeOut
; Loops wave effect or ends it based on remaining iteration counter
Effect_WaveLoopOrEnd:                              ; DATA XREF: ROM:000262BA   o  ; was: sub_2632A
                movea.l #$FFFF9E00,a6
                bsr.w Gfx_GenerateWaveDeformation
                addq.w  #2,(word_FF8102).w
                cmpi.w  #$1C,(word_FF8102).w
                bne.w   locret_26354
                subq.w  #1,(dword_FF8040).w
                bpl.w   loc_26350
                addq.w  #4,(word_FF8104).w
                rts
; ---------------------------------------------------------------------------
loc_26350:                              ; CODE XREF: Effect_WaveLoopOrEnd+1C   j
                subq.w  #4,(word_FF8104).w
locret_26354:                           ; CODE XREF: Effect_WaveLoopOrEnd+14   j
                rts
; End of function Effect_WaveLoopOrEnd
; Updates scroll effect with timing control and state increments
Gfx_UpdateScrollEffect:                              ; DATA XREF: ROM:000262BE   o  ; was: sub_26356
                movea.l #$FFFF9E00,a6
                bsr.w Gfx_GenerateWaveDeformation
                bsr.w   nullsub_57
                subq.w  #2,(word_FF8102).w
                bne.w   locret_26370
                addq.w  #4,(word_FF8104).w
locret_26370:                           ; CODE XREF: Gfx_UpdateScrollEffect+12   j
                rts
; End of function Gfx_UpdateScrollEffect
; Empty scroll effect graphics state
Gfx_ScrollEffectEmptyState:                             ; DATA XREF: ROM:000262C2   o  ; was: nullsub_58
                rts
; End of function Gfx_ScrollEffectEmptyState
nullsub_59:
                rts
; End of function nullsub_59


; Clears 0x50 dwords in RAM buffer starting at $FFFF9800
Memory_ClearBuffer:                              ; CODE XREF: Effect_WaveController   p  ; was: sub_26376
                movea.l #$FFFF9800,a0
                moveq   #0,d0
                move.w  #$50,d7 ; 'P'
loc_26382:                              ; CODE XREF: Memory_ClearBuffer+E   j
                move.l  d0,(a0)+
                dbf     d7,loc_26382
                rts
; End of function Memory_ClearBuffer
; Generates sine wave deformation tables for screen warping effect
Gfx_GenerateWaveDeformation:                              ; CODE XREF: Effect_WaveInitialize+6   p  ; was: sub_2638A
                                        ; Effect_WaveHoldState+6   p ...
                move.b  #$14,(word_FFF7D0+1).w
                move.b  #0,(word_FFF7E4+1).w
                move.b  #$38,(word_FFF7D4+1).w ; '8'
                move.w  (word_FF8102).w,d0
                movea.l #word_26434,a0
                move.w  (a0,d0.w),d0
                moveq   #0,d1
                moveq   #0,d2
                movea.l #$FFFF9F00,a0
                movea.l #$FFFF9F00,a1
                move.w  #$7F,d7
loc_263BE:                              ; CODE XREF: Gfx_GenerateWaveDeformation+4C   j
                suba.w  #2,a0
                add.w   d0,d1
                move.w  d1,d6
                lsr.w   #8,d6
                move.w  d6,(a0)
                adda.w  #2,a1
                sub.w   d0,d2
                move.w  d2,d6
                lsr.w   #8,d6
                move.w  d6,(a1)
                dbf     d7,loc_263BE
                move.w  (word_FF8102).w,d0
                movea.l #word_26416,a0
                move.w  (a0,d0.w),d7
                movea.l #$FFFF9800,a0
                adda.w  d0,a0
                movea.l a0,a1
                move.w  #$1C,d1
                sub.w   d0,d1
                addi.w  #$B,d1
                move.w  #3,d3
loc_26400:                              ; CODE XREF: Gfx_GenerateWaveDeformation+86   j
                move.w  d1,d2
loc_26402:                              ; CODE XREF: Gfx_GenerateWaveDeformation+7C   j
                move.w  d7,(a0)+
                addq.w  #1,d7
                dbf     d2,loc_26402
                adda.w  #$50,a1 ; 'P'
                movea.l a1,a0
                dbf     d3,loc_26400
                rts
; End of function Gfx_GenerateWaveDeformation
; ---------------------------------------------------------------------------
word_26416:     dc.w $85B8, $8520, $8490, $8408, $8388, $8310, $82A0, $8238, $81D8, $8180, $8130, $80E8, $80A8, $8070, $8040
                                        ; DATA XREF: Gfx_GenerateWaveDeformation+54   o
word_26434:     dc.w $E0, $D0, $C0, $B0, $A0, $90, $80, $70, $60, $50, $40, $30, $20, $10, 0
                                        ; DATA XREF: Gfx_GenerateWaveDeformation+16   o


; Calculates two tile coordinate pairs from wave deformation data
Gfx_CalculateTileCoordinates:                              ; CODE XREF: Gfx_RenderTilemapToVRAM:loc_261E4   p  ; was: sub_26452
                bsr.w Math_WaveToTileIndex
                move.w  d0,d2
                bsr.w Math_WaveToTileIndex
                move.w  d0,d3
                rts
; End of function Gfx_CalculateTileCoordinates
; Converts wave accumulator value to tile index with masking
Math_WaveToTileIndex:                              ; CODE XREF: Gfx_CalculateTileCoordinates   p  ; was: sub_26460
                                        ; Gfx_CalculateTileCoordinates+6   p
                add.w   d6,d5
                move.w  d5,d0
                move.w  d5,d1
                asr.w   #8,d0
                andi.w  #7,d0
                asr.w   #8,d1
                andi.w  #$FFF8,d1
                or.w    d1,d0
                rts
; End of function Math_WaveToTileIndex
; Calculates tile buffer addresses and pixel offset from coordinates
Gfx_PrepareTilePointers:                              ; CODE XREF: Gfx_RenderTilemapToVRAM+10   p  ; was: sub_26476
                asr.w   #1,d2
                bcs.w   loc_26482
                moveq   #0,d0
                bra.w   loc_26484
; ---------------------------------------------------------------------------
loc_26482:                              ; CODE XREF: Gfx_PrepareTilePointers+2   j
                moveq   #4,d0
loc_26484:                              ; CODE XREF: Gfx_PrepareTilePointers+8   j
                move.w  d2,d1
                andi.l  #3,d2
                asl.w   #3,d1
                andi.w  #$FFE0,d1
                or.w    d1,d2
                addi.l  #sega_tiles,d2
                movea.l d2,a0
                asr.w   #1,d3
                bcs.w   loc_264A4
                addq.w  #8,d0
loc_264A4:                              ; CODE XREF: Gfx_PrepareTilePointers+28   j
                move.w  d3,d1
                andi.l  #3,d3
                asl.w   #3,d1
                andi.w  #$FFE0,d1
                or.w    d1,d3
                addi.l  #sega_tiles,d3
                movea.l d3,a1
                rts
; End of function Gfx_PrepareTilePointers
; Dispatches to pixel blending routine based on alignment offset
Gfx_PixelBlendDispatcher:                              ; CODE XREF: Gfx_RenderTilemapToVRAM+14   p  ; was: sub_264BE
                move.w  #3,d2
                movea.w d0,a3
                movea.l off_264CA(pc,a3.w),a3
                jmp     (a3)
; End of function Gfx_PixelBlendDispatcher
; ---------------------------------------------------------------------------
off_264CA:      dc.l Gfx_BlendPixelsHighNibble          ; DATA XREF: Gfx_PixelBlendDispatcher+6   r
                dc.l Gfx_BlendPixelsShiftedHigh
                dc.l Gfx_BlendPixelsHighAndShifted
                dc.l Gfx_BlendPixelsFullyShifted


; Blends pixels preserving high nibble from first source
Gfx_BlendPixelsHighNibble:                              ; CODE XREF: Gfx_BlendPixelsHighNibble+32   j  ; was: sub_264DA
                                        ; DATA XREF: ROM:off_264CA   o
                move.w  #7,d3
loc_264DE:                              ; CODE XREF: Gfx_BlendPixelsHighNibble+20   j
                move.b  (a0),d0
                andi.w  #$F0,d0
                move.b  (a1),d1
                andi.w  #$F,d1
                or.w    d1,d0
                move.b  d0,(a2)
                lea     4(a0),a0
                lea     4(a1),a1
                lea     4(a2),a2
                dbf     d3,loc_264DE
                adda.l  #$160,a0
                adda.l  #$160,a1
                adda.w  d4,a2
                dbf d2,Gfx_BlendPixelsHighNibble
                rts
; End of function Gfx_BlendPixelsHighNibble
; Blends pixels with first source shifted to high nibble
Gfx_BlendPixelsShiftedHigh:                              ; CODE XREF: Gfx_BlendPixelsShiftedHigh+30   j  ; was: sub_26512
                                        ; DATA XREF: ROM:000264CE   o
                move.w  #7,d3
loc_26516:                              ; CODE XREF: Gfx_BlendPixelsShiftedHigh+1E   j
                move.b  (a0),d0
                asl.w   #4,d0
                move.b  (a1),d1
                andi.w  #$F,d1
                or.w    d1,d0
                move.b  d0,(a2)
                lea     4(a0),a0
                lea     4(a1),a1
                lea     4(a2),a2
                dbf     d3,loc_26516
                adda.l  #$160,a0
                adda.l  #$160,a1
                adda.w  d4,a2
                dbf d2,Gfx_BlendPixelsShiftedHigh
                rts
; End of function Gfx_BlendPixelsShiftedHigh
; Blends pixels with high nibble and shifted low nibble
Gfx_BlendPixelsHighAndShifted:                              ; CODE XREF: Gfx_BlendPixelsHighAndShifted+34   j  ; was: sub_26548
                                        ; DATA XREF: ROM:000264D2   o
                move.w  #7,d3
loc_2654C:                              ; CODE XREF: Gfx_BlendPixelsHighAndShifted+22   j
                move.b  (a0),d0
                andi.w  #$F0,d0
                move.b  (a1),d1
                lsr.w   #4,d1
                andi.w  #$F,d1
                or.w    d1,d0
                move.b  d0,(a2)
                lea     4(a0),a0
                lea     4(a1),a1
                lea     4(a2),a2
                dbf     d3,loc_2654C
                adda.l  #$160,a0
                adda.l  #$160,a1
                adda.w  d4,a2
                dbf d2,Gfx_BlendPixelsHighAndShifted
                rts
; End of function Gfx_BlendPixelsHighAndShifted
; Blends pixels with both sources shifted and combined
Gfx_BlendPixelsFullyShifted:                              ; CODE XREF: Gfx_BlendPixelsFullyShifted+32   j  ; was: sub_26582
                                        ; DATA XREF: ROM:000264D6   o
                move.w  #7,d3
loc_26586:                              ; CODE XREF: Gfx_BlendPixelsFullyShifted+20   j
                move.b  (a0),d0
                asl.w   #4,d0
                move.b  (a1),d1
                lsr.w   #4,d1
                andi.w  #$F,d1
                or.w    d1,d0
                move.b  d0,(a2)
                lea     4(a0),a0
                lea     4(a1),a1
                lea     4(a2),a2
                dbf     d3,loc_26586
                adda.l  #$160,a0
                adda.l  #$160,a1
                adda.w  d4,a2
                dbf d2,Gfx_BlendPixelsFullyShifted
                rts
; End of function Gfx_BlendPixelsFullyShifted
; Initializes wave deformation parameters from lookup tables
Gfx_InitializeWaveParameters:                              ; CODE XREF: Gfx_RenderTilemapToVRAM+8   p  ; was: sub_265BA
                move.w  (word_FF8102).w,d0
                moveq   #0,d5
                movea.l #$FFFF0000,a2
                movea.w #0,a4
                movea.l #word_265EC,a0
                move.w  (a0,d0.w),d6
                sub.w   d6,d5
                movea.l #word_26608,a0
                move.w  (a0,d0.w),d4
                movea.l #word_26624,a0
                move.w  (a0,d0.w),d7
                rts
; End of function Gfx_InitializeWaveParameters
; ---------------------------------------------------------------------------
word_265EC:     dc.w $DB, $C0, $AA, $99, $8B, $80, $76, $6D, $66, $60, $5A, $55, $50, $4C
                                        ; DATA XREF: Gfx_InitializeWaveParameters+10   o
word_26608:     dc.w $1A0, $1E0, $220, $260, $2A0, $2E0, $320, $360, $3A0, $3E0, $420, $460, $4A0, $4E0
                                        ; DATA XREF: Gfx_InitializeWaveParameters+1C   o
word_26624:     dc.w $37, $3F, $47, $4F, $57, $5F, $67, $6F, $77, $7F, $87, $8F, $97, $9F
                                        ; DATA XREF: Gfx_InitializeWaveParameters+26   o
word_26640:     dc.w $E00, $1500, $1D00, $2600, $3000, $3B00, $4700, $5400, $6200, $7100, $8100, $9200, $A400, $B700
                                        ; DATA XREF: Gfx_RenderTilemapToVRAM+3E   o


nullsub_57:                             ; CODE XREF: Effect_WaveInitialize+A   p
                                        ; Gfx_UpdateScrollEffect+A   p
                rts
; End of function nullsub_57
; ---------------------------------------------------------------------------
unused_6:	binclude	"data/other/unused_6.bin"


; Main loop for loading tiles to VRAM
Gfx_LoadTilesLoop:                              ; CODE XREF: Cutscene_InitCreditsScreen+3E   p  ; was: sub_2667C
                                        ; Stage_LoadTeleportGraphics+2C   j
                move.w  #1,(a0)
                move.w  #$20,(dword_FF8040).w ; ' '
loc_26686:                              ; CODE XREF: Gfx_LoadTilesLoop+48   j
                movea.w #(word_FF9800-M68K_RAM),a5
                move.l  #$8000,d0
                divs.w  (dword_FF8040).w,d0
                andi.l  #$FFFF,d0
                asl.l   #5,d0
                move.l  d0,d1
                asl.l   #3,d1
                clr.l   d2
                bsr.w Memory_ClearTileBuffer
loc_266A6:                              ; CODE XREF: Gfx_LoadTilesLoop+34   j
                bsr.w Gfx_InterpolateCompressedTiles
                cmpi.l  #$100000,d2
                bmi.w   loc_266A6
                bsr.w Gfx_TileLoadDispatcher
                move.w  (dword_FF8044+2).w,d7
                sub.w   d7,(dword_FF8040).w
                subq.w  #1,(word_FF804A).w
                bpl.w   loc_26686
                rts
; End of function Gfx_LoadTilesLoop
; Decompresses and loads tiles with interpolation into tile buffer
Gfx_DecompressTilesInterpolated:
                move.w  #1,(a0)  ; was: sub_266CA
                movea.w #(word_FF9800-M68K_RAM),a5
                move.l  #$8000,d0
                divs.w  (dword_FF8040).w,d0
                andi.l  #$FFFF,d0
                asl.l   #5,d0
                move.l  d0,d1
                asl.l   #3,d1
                clr.l   d2
                bsr.w Memory_ClearTileBuffer
loc_266EE:                              ; CODE XREF: Gfx_DecompressTilesInterpolated+2E   j
                bsr.w Gfx_InterpolateCompressedTiles
                cmpi.l  #$100000,d2
                bmi.w   loc_266EE
                bra.w Gfx_TileLoadDispatcher
; End of function Gfx_DecompressTilesInterpolated
; Interpolates between two compressed tile patterns for morphing effects
Gfx_InterpolateCompressedTiles:                              ; CODE XREF: Gfx_LoadTilesLoop:loc_266A6   p  ; was: sub_26700
                                        ; sub_266CA:loc_266EE   p
                movea.w a1,a2
                movea.w a1,a3
                movea.w a5,a4
                addq.w  #2,a4
                clr.l   d5
                clr.w   d7
                cmpi.w  #$8000,d2
                bmi.w   loc_26716
                addq.w  #1,d7
loc_26716:                              ; CODE XREF: Gfx_InterpolateCompressedTiles+10   j
                move.l  d2,d6
                swap    d6
                andi.w  #$FFFC,d6
                asl.w   #5,d6
                adda.w  d6,a2
                move.w  a2,(dword_FF8040+2).w
                move.l  d2,d3
                swap    d3
                andi.w  #3,d3
                add.l   d0,d2
                cmpi.l  #$100000,d2
                bmi.w   loc_26740
                move.l  #$FFFFF,d2
loc_26740:                              ; CODE XREF: Gfx_InterpolateCompressedTiles+36   j
                cmpi.w  #$8000,d2
                bpl.w   loc_2674A
                addq.w  #2,d7
loc_2674A:                              ; CODE XREF: Gfx_InterpolateCompressedTiles+44   j
                move.l  d2,d6
                swap    d6
                andi.w  #$FFFC,d6
                asl.w   #5,d6
                adda.w  d6,a3
                move.w  a3,(dword_FF8044).w
                move.l  d2,d4
                swap    d4
                andi.w  #3,d4
                add.l   d0,d2
                movem.l d0-d2,-(sp)
loc_26768:                              ; CODE XREF: Gfx_InterpolateCompressedTiles+AE   j
                move.b  (a2,d3.w),d0
                btst    #0,d7
                beq.w   loc_26776
                asl.b   #4,d0
loc_26776:                              ; CODE XREF: Gfx_InterpolateCompressedTiles+70   j
                andi.b  #$F0,d0
                move.b  (a3,d4.w),d2
                btst    #1,d7
                beq.w   loc_26788
                asr.b   #4,d2
loc_26788:                              ; CODE XREF: Gfx_InterpolateCompressedTiles+82   j
                andi.b  #$F,d2
                or.b    d0,d2
                move.b  d2,(a4)
                add.l   d1,d5
                move.l  d5,d0
                swap    d0
                andi.w  #$FFFC,d0
                movea.w d0,a2
                movea.w d0,a3
                adda.w  (dword_FF8040+2).w,a2
                adda.w  (dword_FF8044).w,a3
                addq.w  #4,a4
                cmpi.l  #$800000,d5
                bmi.w   loc_26768
                addq.w  #1,a5
                move.w  a5,d7
                andi.w  #3,d7
                bne.w   loc_267C4
                subq.w  #4,a5
                adda.w  #$80,a5
loc_267C4:                              ; CODE XREF: Gfx_InterpolateCompressedTiles+BA   j
                movem.l (sp)+,d0-d2
                rts
; End of function Gfx_InterpolateCompressedTiles
; Dispatches tile loading based on count
Gfx_TileLoadDispatcher:                              ; CODE XREF: Gfx_LoadTilesLoop+38   p  ; was: sub_267CA
                                        ; Gfx_DecompressTilesInterpolated+32   j
                cmpi.w  #$19,(dword_FF8040).w
                bpl.w   loc_268B4
                cmpi.w  #$11,(dword_FF8040).w
                bpl.w   loc_26854
                cmpi.w  #9,(dword_FF8040).w
                bpl.w   loc_26810
                move.w  #$20,(word_FF9800).w ; ' '
                move.w  #$FFFF,2(a0)
                move.w  #$9800,4(a0)
                move.w  (word_FF8048).w,6(a0)
                move.w  #$FFFF,8(a0)
                addi.w  #$20,(word_FF8048).w ; ' '
                bra.w Gfx_LoadObjectData
; ---------------------------------------------------------------------------
loc_26810:                              ; CODE XREF: Gfx_TileLoadDispatcher+1A   j
                move.w  #$40,(word_FF9800).w ; '@'
                move.w  #$FFFF,2(a0)
                move.w  #$9800,4(a0)
                move.w  (word_FF8048).w,6(a0)
                move.w  #$FFFF,8(a0)
                addi.w  #$40,(word_FF8048).w ; '@'
                bsr.w Gfx_LoadObjectData
                move.w  #$40,(word_FF9880).w ; '@'
                move.w  #$9880,4(a0)
                move.w  (word_FF8048).w,6(a0)
                addi.w  #$40,(word_FF8048).w ; '@'
                bra.w Gfx_LoadObjectData
; ---------------------------------------------------------------------------
loc_26854:                              ; CODE XREF: Gfx_TileLoadDispatcher+10   j
                move.w  #$60,(word_FF9800).w ; '`'
                move.w  #$FFFF,2(a0)
                move.w  #$9800,4(a0)
                move.w  (word_FF8048).w,6(a0)
                move.w  #$FFFF,8(a0)
                addi.w  #$60,(word_FF8048).w ; '`'
                bsr.w Gfx_LoadObjectData
                move.w  #$60,(word_FF9880).w ; '`'
                move.w  #$9880,4(a0)
                move.w  (word_FF8048).w,6(a0)
                addi.w  #$60,(word_FF8048).w ; '`'
                bsr.w Gfx_LoadObjectData
                move.w  #$60,(word_FF9900).w ; '`'
                move.w  #$9900,4(a0)
                move.w  (word_FF8048).w,6(a0)
                addi.w  #$60,(word_FF8048).w ; '`'
                bra.w Gfx_LoadObjectData
; ---------------------------------------------------------------------------
loc_268B4:                              ; CODE XREF: Gfx_TileLoadDispatcher+6   j
                move.w  #$200,(word_FF9800).w
                move.w  #$FFFF,2(a0)
                move.w  #$9800,4(a0)
                move.w  (word_FF8048).w,6(a0)
                move.w  #$FFFF,8(a0)
                addi.w  #$200,(word_FF8048).w
; End of function Gfx_TileLoadDispatcher
; Loads object data wrapper
Gfx_LoadObjectData:                              ; CODE XREF: Gfx_TileLoadDispatcher+42   j  ; was: sub_268D8
                                        ; Gfx_TileLoadDispatcher+6A   p ...
                movem.l d0-d2/a0-a5,-(sp)
                jsr     (LoadObjData).l
                movem.l (sp)+,d0-d2/a0-a5
                rts
; End of function Gfx_LoadObjectData
; Clears tile buffer in RAM
Memory_ClearTileBuffer:                              ; CODE XREF: Gfx_LoadTilesLoop+26   p  ; was: sub_268E8
                                        ; Gfx_DecompressTilesInterpolated+20   p
                movea.w #(word_FF9800-M68K_RAM),a3
                moveq   #0,d6
                move.w  #$7F,d7
loc_268F2:                              ; CODE XREF: Memory_ClearTileBuffer+C   j
                move.l  d6,(a3)+
                dbf     d7,loc_268F2
                rts
; End of function Memory_ClearTileBuffer
; Clears sprites except $150 entries for screen transition
Sprite_ClearForTransition:                              ; CODE XREF: Cutscene_FadeOutCredits+52   p  ; was: sub_268FA
                move.w  #$150,(a5)
                clr.w   4(a5)
                move.w  #$150,d0
                moveq   #0,d1
                jmp Sprite_ClearAllExcept
; End of function Sprite_ClearForTransition
; Initializes boss defeat explosion sprite at boss position
Boss_InitDefeatExplosion:                              ; CODE XREF: Boss_ShiperDefeatSequence+58   p  ; was: sub_2690E
                                        ; Boss_TerobusterDefeatInit+38   p
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$354,(a0)
                clr.w   4(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                rts
; End of function Boss_InitDefeatExplosion
; Boss defeat sequence state dispatcher using jump table
Boss_DefeatStateDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_26928
                move.w  4(a5),d0
                movea.w off_26938(pc,d0.w),a0
                adda.l  #Boss_DefeatInitAnimation,a0
                jmp     (a0)
; End of function Boss_DefeatStateDispatcher
; ---------------------------------------------------------------------------
off_26938:      dc.w Boss_DefeatInitAnimation-Boss_DefeatInitAnimation
                                        ; DATA XREF: Boss_DefeatStateDispatcher+4   r
                dc.w Boss_DefeatLoadGraphics-Boss_DefeatInitAnimation
                dc.w Boss_DefeatSetupState-Boss_DefeatInitAnimation
                dc.w Boss_DefeatScrollInit-Boss_DefeatInitAnimation
                dc.w Boss_DefeatScrollUpdate-Boss_DefeatInitAnimation


; Initializes boss defeat animation state and graphics mode
Boss_DefeatInitAnimation:                              ; DATA XREF: Boss_DefeatStateDispatcher+8   o  ; was: sub_26942
                                        ; ROM:off_26938   o ...
                move.w  #2,4(a5)
                move.w  #$100,2(a5)
                move.b  #4,(byte_FFA95B).w
                clr.w   (word_FF808A).w
                bra.w Effect_ClearPaletteBuffer
; End of function Boss_DefeatInitAnimation
; Loads boss defeat explosion animation graphics via DMA
Boss_DefeatLoadGraphics:                              ; DATA XREF: ROM:0002693A   o  ; was: sub_2695C
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                lea     stru_26976(pc),a0
                nop
                jsr     (LoadObjData).l
                movem.l (sp)+,a5
                rts
; End of function Boss_DefeatLoadGraphics
; ---------------------------------------------------------------------------
stru_26976:     dc.w 7                  ; field_0
                                        ; DATA XREF: Boss_DefeatLoadGraphics+8   o
                dc.l byte_18D562        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF


; Sets up boss defeat state initializing scroll timers and playing sound
Boss_DefeatSetupState:                              ; DATA XREF: ROM:0002693C   o  ; was: sub_26980
                addq.w  #2,4(a5)
                move.b  #3,(byte_FFA95B).w
                move.w  #$14,(word_FF8090).w
                move.w  #4,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #3,(word_FFF7E6+1).w
                clr.w   (word_FF807C).w
                move.w  #8,(word_FF807A).w
                move.b  #$CA,d0
                jmp (Sound_PlaySFX).l
; End of function Boss_DefeatSetupState
; Initializes boss defeat scroll animation with velocity parameters
Boss_DefeatScrollInit:                              ; DATA XREF: ROM:0002693E   o  ; was: sub_269B4
                addq.w  #2,4(a5)
                move.l  #$18000,(dword_FF80A0).w
                bsr.w Effect_InitDefeatScroll
; End of function Boss_DefeatScrollInit
; Updates boss defeat scroll position and checks for transition complete
Boss_DefeatScrollUpdate:                              ; DATA XREF: ROM:00026940   o  ; was: sub_269C4
                bsr.w Effect_UpdateScrollPosition
                move.w  $10(a5),(dword_FF807E).w
                move.w  $14(a5),(dword_FF807E+2).w
                addq.w  #3,(word_FF807C).w
                cmpi.w  #$7F,(word_FF807C).w
                bmi.w Effect_ResetTransitionState
                bra.w   loc_26ACE
; End of function Boss_DefeatScrollUpdate
; Initializes player spawn effect with position
Effect_InitPlayerSpawn:                              ; CODE XREF: Boss_InitPositionTracking+10   p  ; was: sub_269E6
                                        ; Boss_JokerFadeOut+2E   p ...
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$150,(a0)
                clr.w   4(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                rts
; End of function Effect_InitPlayerSpawn
; Effect state machine dispatcher
Effect_StateDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_26A00
                move.w  4(a5),d0
                movea.w off_26A10(pc,d0.w),a0
                adda.l  #Effect_TransitionInit,a0
                jmp     (a0)
; End of function Effect_StateDispatcher
; ---------------------------------------------------------------------------
off_26A10:      dc.w Effect_TransitionInit-Effect_TransitionInit
                                        ; DATA XREF: Effect_StateDispatcher+4   r
                dc.w Effect_LoadTransitionGraphics-Effect_TransitionInit
                dc.w Effect_StartTransition-Effect_TransitionInit
                dc.w Effect_SetupScroll-Effect_TransitionInit
                dc.w Effect_UpdateTransition-Effect_TransitionInit


; Initializes screen transition effect state
Effect_TransitionInit:                              ; DATA XREF: Effect_StateDispatcher+8   o  ; was: sub_26A1A
                                        ; ROM:off_26A10   o ...
                move.w  #2,4(a5)
                move.w  #$100,2(a5)
                move.b  #4,(byte_FFA95B).w
                clr.w   (word_FF808A).w
                bra.w Effect_ClearPaletteBuffer
; End of function Effect_TransitionInit
; Loads transition graphics data
Effect_LoadTransitionGraphics:                              ; DATA XREF: ROM:00026A12   o  ; was: sub_26A34
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                lea     stru_26A4E(pc),a0
                nop
                jsr     (LoadObjData).l
                movem.l (sp)+,a5
                rts
; End of function Effect_LoadTransitionGraphics
; ---------------------------------------------------------------------------
stru_26A4E:     dc.w 7                  ; field_0
                                        ; DATA XREF: Effect_LoadTransitionGraphics+8   o
                dc.l byte_18D562        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF


; Starts screen transition with sound
Effect_StartTransition:                              ; DATA XREF: ROM:00026A14   o  ; was: sub_26A58
                addq.w  #2,4(a5)
                move.b  #3,(byte_FFA95B).w
                move.w  #4,(word_FF8090).w
                move.w  #$10,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #3,(word_FFF7E6+1).w
                clr.w   (word_FF807C).w
                move.b  #$CA,d0
                jsr (Sound_PlaySFX).l
                move.w  #2,(word_FF807A).w
                rts
; End of function Effect_StartTransition
; Sets up scroll parameters for transition
Effect_SetupScroll:                              ; DATA XREF: ROM:00026A16   o  ; was: sub_26A8E
                addq.w  #2,4(a5)
                move.l  #$18000,(dword_FF80A0).w
                bsr.w Effect_ScrollUpdate
; End of function Effect_SetupScroll
; Updates transition effect with scroll and timer
Effect_UpdateTransition:                              ; DATA XREF: ROM:00026A18   o  ; was: sub_26A9E
                bsr.w Effect_UpdateScrollPosition
                move.w  $10(a5),(dword_FF807E).w
                move.w  $14(a5),(dword_FF807E+2).w
                subi.l  #$3C0,(dword_FF80A0).w
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                addq.w  #1,d0
                add.w   d0,(word_FF807C).w
                cmpi.w  #$7F,(word_FF807C).w
                bmi.w Effect_ResetTransitionState
loc_26ACE:                              ; CODE XREF: Boss_DefeatScrollUpdate+1E   j
                clr.w   (word_FF807A).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                clr.w   (word_FF8090).w
                bset    #4,2(a5)
                move.b  #4,(byte_FFA95B).w
                bra.w Effect_ClearPaletteBuffer
; End of function Effect_UpdateTransition
; Dispatches to transition effect handler based on state index
Effect_TransitionDispatcher:                              ; CODE XREF: Credits_InitializeScreen+84   p  ; was: sub_26AEE
                move.w  (word_FF807A).w,d0
                movea.w off_26AFE(pc,d0.w),a0
                adda.l  #Effect_InitializeTransition1,a0
                jmp     (a0)
; End of function Effect_TransitionDispatcher
; ---------------------------------------------------------------------------
off_26AFE:      dc.w Effect_InitializeTransition1-Effect_InitializeTransition1
                                        ; DATA XREF: Effect_TransitionDispatcher+4   r
                dc.w Effect_InitializeTransition2-Effect_InitializeTransition1
                dc.w Effect_InitializeTransition4-Effect_InitializeTransition1
                dc.w Effect_InitializeTransition4-Effect_InitializeTransition1
                dc.w Effect_InitializeTransition3-Effect_InitializeTransition1


; Initializes transition effect with fade and palette settings
Effect_InitializeTransition1:                              ; DATA XREF: Effect_TransitionDispatcher+8   o  ; was: sub_26B08
                                        ; ROM:off_26AFE   o ...
                move.w  #4,(word_FF8090).w
                move.b  #$80,(byte_FFA95B).w
                move.w  #$10,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #3,(word_FFF7E6+1).w
                clr.w   (word_FF807C).w
                rts
; End of function Effect_InitializeTransition1
; Initializes transition effect parameters (duplicate of sub_26B08)
Effect_InitializeTransition2:                              ; DATA XREF: ROM:00026B00   o  ; was: sub_26B2A
                move.w  #4,(word_FF8090).w
                move.b  #$80,(byte_FFA95B).w
                move.w  #$10,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #3,(word_FFF7E6+1).w
                clr.w   (word_FF807C).w
                rts
; End of function Effect_InitializeTransition2
; Initializes transition with longer duration ($14 vs $4)
Effect_InitializeTransition3:                              ; DATA XREF: ROM:00026B06   o  ; was: sub_26B4C
                move.w  #$14,(word_FF8090).w
                move.b  #$80,(byte_FFA95B).w
                move.w  #4,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #3,(word_FFF7E6+1).w
                clr.w   (word_FF807C).w
                rts
; End of function Effect_InitializeTransition3
; Initializes transition effect without clearing progress counter
Effect_InitializeTransition4:                              ; DATA XREF: ROM:00026B02   o  ; was: sub_26B6E
                                        ; ROM:00026B04   o
                move.w  #4,(word_FF8090).w
                move.b  #$80,(byte_FFA95B).w
                move.w  #$10,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #3,(word_FFF7E6+1).w
                rts
; End of function Effect_InitializeTransition4
; Palette effect dispatcher
Effect_PaletteDispatcher:                              ; CODE XREF: Cutscene_CreditsDispatcher   p  ; was: sub_26B8C
                                        ; Sys_GameplayMainLoop+118   p ...
                move.w  (word_FF807A).w,d0
                movea.w off_26B9C(pc,d0.w),a0
                adda.l  #Effect_PaletteUpdateMain,a0
                jmp     (a0)
; End of function Effect_PaletteDispatcher
; ---------------------------------------------------------------------------
off_26B9C:      dc.w nullsub_60-Effect_PaletteUpdateMain
                                        ; DATA XREF: Effect_PaletteDispatcher+4   r
                dc.w Effect_PaletteUpdateMain-Effect_PaletteUpdateMain
                dc.w Effect_InitializePaletteEffects-Effect_PaletteUpdateMain
                dc.w Effect_InitPaletteEffect-Effect_PaletteUpdateMain
                dc.w Effect_ComplexScrollWave-Effect_PaletteUpdateMain


; Main palette update routine
Effect_PaletteUpdateMain:                              ; DATA XREF: Effect_PaletteDispatcher+8   o  ; was: sub_26BA6
                                        ; ROM:off_26B9C   o ...
                bsr.w Effect_InitPaletteBuffers
                bra.w Effect_ApplyPaletteToVDP
; End of function Effect_PaletteUpdateMain
; Initializes palette buffers and applies two-stage effect setup
Effect_InitializePaletteEffects:                              ; DATA XREF: ROM:00026BA0   o  ; was: sub_26BAE
                bsr.w Effect_InitPaletteBuffers
                bsr.w Effect_InitScrollBuffers
                bsr.w Effect_ProcessConditionalScroll
; End of function Effect_InitializePaletteEffects
nullsub_60:                             ; DATA XREF: ROM:off_26B9C   o
                rts
; End of function nullsub_60


; Initializes palette effect by checking word_FF8082, clearing if negative, then calls buffer and effect setup routines
Effect_InitPaletteEffect:                              ; DATA XREF: ROM:00026BA2   o  ; was: sub_26BBC
                tst.w   (word_FF8082).w
                bpl.s   loc_26BC6
                clr.w   (word_FF8082).w
loc_26BC6:                              ; CODE XREF: Effect_InitPaletteEffect+4   j
                bsr.w Effect_ClearScrollBuffer
                bsr.w Effect_InitPaletteBuffers
                bsr.w Effect_FillScrollBuffer
                bra.w Effect_ProcessSimpleScroll
; End of function Effect_InitPaletteEffect
; Initializes scroll buffers at FF9480 using sine table data from word_26FBC, calculating 63 buffer values with interpolation
Effect_InitScrollBuffers:                              ; CODE XREF: Effect_InitializePaletteEffects+4   p  ; was: sub_26BD6
                movea.w #(word_FF9480-M68K_RAM),a0
                movea.w #(word_FF9480-M68K_RAM),a1
                moveq   #$3E,d7 ; '>'
                movea.l #word_26FBC,a2
                move.w  (word_FF807C).w,d0
                andi.w  #$1FE,d0
                cmpi.w  #$80,d0
                beq.s   loc_26C4A
                cmpi.w  #$180,d0
                beq.s   loc_26C4E
                move.w  (a2,d0.w),d1
                muls.w  #$60,d1 ; '`'
                asl.l   #2,d1
                move.l  #$300000,d0
loc_26C0A:                              ; CODE XREF: Effect_InitScrollBuffers+62   j
                tst.l   d0
                bpl.s   loc_26C12
loc_26C0E:                              ; CODE XREF: Effect_InitScrollBuffers+46   j
                clr.l   d0
                bra.s   loc_26C2C
; ---------------------------------------------------------------------------
loc_26C12:                              ; CODE XREF: Effect_InitScrollBuffers+36   j
                cmpi.l  #$600000,d0
                bpl.s   loc_26C26
                add.l   d1,d0
                bmi.s   loc_26C0E
                cmpi.l  #$600000,d0
                bmi.s   loc_26C2C
loc_26C26:                              ; CODE XREF: Effect_InitScrollBuffers+42   j
                move.l  #$600000,d0
loc_26C2C:                              ; CODE XREF: Effect_InitScrollBuffers+3A   j
                                        ; Effect_InitScrollBuffers+4E   j
                swap    d0
                move.w  d0,(a0)+
                swap    d0
                swap    d0
                move.w  d0,-(a1)
                swap    d0
                dbf     d7,loc_26C0A
loc_26C3C:                              ; CODE XREF: Effect_SetupScrollPointers   j
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                rts
; ---------------------------------------------------------------------------
loc_26C4A:                              ; CODE XREF: Effect_InitScrollBuffers+1C   j
                moveq   #$60,d0 ; '`'
                bra.s   loc_26C50
; ---------------------------------------------------------------------------
loc_26C4E:                              ; CODE XREF: Effect_InitScrollBuffers+22   j
                moveq   #0,d0
loc_26C50:                              ; CODE XREF: Effect_InitScrollBuffers+76   j
                                        ; Effect_InitScrollBuffers+7E   j
                move.w  d0,(a0)+
                move.w  d0,-(a1)
                dbf     d7,loc_26C50
; End of function Effect_InitScrollBuffers
; Attributes: thunk
; Thunk to set up scroll effect address registers a0/a2/a3 to point to scroll data buffers
Effect_SetupScrollPointers:
                bra.s   loc_26C3C  ; was: sub_26C58
; End of function Effect_SetupScrollPointers
; Sets d5 to alternate sine table address FFFF9B00 and branches to common scroll processing
Effect_ScrollSineTable1:
                move.l  #$FFFF9B00,d5  ; was: sub_26C5A
                bra.s   loc_26C68
; End of function Effect_ScrollSineTable1
; Processes scroll effect using sine table at word_26FBC, interpolating 63 values based on word_FF807C
Effect_ScrollSineTable2:
                move.l  #word_26FBC,d5  ; was: sub_26C62
loc_26C68:                              ; CODE XREF: Effect_ScrollSineTable1+6   j
                movea.w #(word_FF9480-M68K_RAM),a0
                movea.w #(word_FF9480-M68K_RAM),a2
                moveq   #$FFFFFFFE,d6
                moveq   #$3E,d7 ; '>'
                move.w  (word_FF807C).w,d1
                asl.w   #8,d1
                moveq   #0,d3
                move.w  (word_FF807C).w,d2
                beq.s   loc_26C94
                move.l  #$8000,d3
                divu.w  d2,d3
                andi.l  #$FFFF,d3
                asl.l   #1,d3
                asl.l   #8,d3
loc_26C94:                              ; CODE XREF: Effect_ScrollSineTable2+1E   j
                moveq   #0,d2
loc_26C96:                              ; CODE XREF: Effect_ScrollSineTable2+56   j
                cmpi.l  #$FE0000,d2
                bpl.s   loc_26CAE
                add.l   d3,d2
                move.l  d2,d4
                swap    d4
                ext.l   d4
                move.l  d5,d0
                sub.l   d4,d0
                and.l   d6,d0
                movea.l d0,a1
loc_26CAE:                              ; CODE XREF: Effect_ScrollSineTable2+3A   j
                move.w  (a1),d0
                muls.w  d1,d0
                swap    d0
                move.w  d0,-(a0)
                move.w  d0,(a2)+
                dbf     d7,loc_26C96
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                rts
; End of function Effect_ScrollSineTable2
; Fills scroll buffer starting at offset -6C00 with value from dword_FF807E+2, repeating word_FF8082 times
Effect_FillScrollBuffer:                              ; CODE XREF: Effect_InitPaletteEffect+12   p  ; was: sub_26CCA
                move.w  (word_FF807C).w,d0
                andi.w  #$1FE,d0
                addi.w  #-$6C00,d0
                movea.w d0,a0
                move.w  (dword_FF807E+2).w,d1
                move.w  (word_FF8082).w,d7
loc_26CE0:                              ; CODE XREF: Effect_FillScrollBuffer+18   j
                move.w  d1,(a0)+
                dbf     d7,loc_26CE0
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                rts
; End of function Effect_FillScrollBuffer
; Processes vertical scroll values for 127 entries, clamping to 0-160 range and computing scroll offsets
Effect_ProcessVerticalScroll:
                moveq   #1,d1  ; was: sub_26CF4
                move.w  #$FE,d2
                move.w  #$FFFE,d3
                move.w  #$120,d4
                moveq   #$7E,d7 ; '~'
loc_26D04:                              ; CODE XREF: Effect_ProcessVerticalScroll+56   j
                move.w  (a0)+,d0
                asl.w   #1,d0
                move.w  d4,d5
                sub.w   d0,d5
                and.w   d3,d5
                bpl.s   loc_26D1C
                asr.w   #1,d5
                add.w   d5,d0
                bpl.s   loc_26D18
                moveq   #0,d0
loc_26D18:                              ; CODE XREF: Effect_ProcessVerticalScroll+20   j
                moveq   #0,d5
                bra.s   loc_26D3E
; ---------------------------------------------------------------------------
loc_26D1C:                              ; CODE XREF: Effect_ProcessVerticalScroll+1A   j
                cmpi.w  #$140,d5
                bmi.s   loc_26D28
                moveq   #0,d5
                moveq   #0,d0
                bra.s   loc_26D3E
; ---------------------------------------------------------------------------
loc_26D28:                              ; CODE XREF: Effect_ProcessVerticalScroll+2C   j
                move.w  d0,d6
                add.w   d5,d6
                cmpi.w  #$A0,d6
                bmi.s   loc_26D3E
                subi.w  #$A0,d0
                add.w   d5,d0
                bpl.s   loc_26D3E
                moveq   #0,d5
                moveq   #0,d0
loc_26D3E:                              ; CODE XREF: Effect_ProcessVerticalScroll+26   j
                                        ; Effect_ProcessVerticalScroll+32   j ...
                move.w  d5,(a3)+
                move.w  d5,(a3)+
                sub.w   d1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                addq.w  #2,d1
                dbf     d7,loc_26D04
                rts
; End of function Effect_ProcessVerticalScroll
; Processes horizontal scroll data for 127 scanlines, calculating doubled scroll offsets with 160-pixel wraparound
Effect_ProcessHorizontalScroll:
                moveq   #1,d1  ; was: sub_26D50
                move.w  #$FE,d2
                move.w  #$FFFE,d3
                move.w  #$A0,d4
                moveq   #$7E,d7 ; '~'
loc_26D60:                              ; CODE XREF: Effect_ProcessHorizontalScroll+2A   j
                move.w  (a0),d0
                sub.w   d1,d0
                asl.w   #1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                move.w  (a0)+,d0
                asl.w   #1,d0
                move.w  d4,d5
                sub.w   d0,d5
                and.w   d3,d5
                move.w  d5,(a3)+
                move.w  d5,(a3)+
                addq.w  #1,d1
                dbf     d7,loc_26D60
                rts
; End of function Effect_ProcessHorizontalScroll
; Processes scroll with conditional vertical calculation based on dword_FF807E flag, quadruples values if enabled
Effect_ProcessConditionalScroll:                              ; CODE XREF: Effect_InitializePaletteEffects+8   p  ; was: sub_26D80
                moveq   #1,d1
                move.w  #$FE,d2
                move.w  #$A0,d4
                moveq   #$7E,d7 ; '~'
loc_26D8C:                              ; CODE XREF: Effect_ProcessConditionalScroll+2E   j
                move.w  (a0)+,d0
                sub.w   d1,d0
                asl.w   #1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                tst.w   (dword_FF807E).w
                beq.s   loc_26DAC
                move.w  -2(a0),d0
                asl.w   #2,d0
                move.w  #$140,d3
                sub.w   d0,d3
                move.w  d3,(a3)+
                move.w  d3,(a3)+
loc_26DAC:                              ; CODE XREF: Effect_ProcessConditionalScroll+1A   j
                addq.w  #1,d1
                dbf     d7,loc_26D8C
                rts
; End of function Effect_ProcessConditionalScroll
; Simple scroll processor that applies constant vertical offset from dword_FF807E to 127 horizontal scroll entries
Effect_ProcessSimpleScroll:                              ; CODE XREF: Effect_InitPaletteEffect+16   j  ; was: sub_26DB4
                moveq   #1,d1
                move.w  #$FE,d2
                moveq   #$7E,d7 ; '~'
                move.w  (dword_FF807E).w,d6
loc_26DC0:                              ; CODE XREF: Effect_ProcessSimpleScroll+1C   j
                move.w  (a0)+,d0
                sub.w   d1,d0
                asl.w   #1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                move.w  d6,(a3)+
                move.w  d6,(a3)+
                addq.w  #1,d1
                dbf     d7,loc_26DC0
                rts
; End of function Effect_ProcessSimpleScroll
; Initializes palette buffer pointers
Effect_InitPaletteBuffers:                              ; CODE XREF: Effect_PaletteUpdateMain   p  ; was: sub_26DD6
                                        ; sub_26BAE   p ...
                movea.w #(word_FF9500-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a1
                moveq   #6,d7
; End of function Effect_InitPaletteBuffers
; Copies palette data between buffers
Effect_CopyPaletteData:                              ; CODE XREF: Effect_CopyPaletteData+10   j  ; was: sub_26DE0
                                        ; Effect_ComplexScrollWave+A   p ...
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                dbf d7,Effect_CopyPaletteData
                rts
; End of function Effect_CopyPaletteData
; Applies sine wave modulation to scroll buffer using word_26EBC table and word_1B494 multiplier data
Effect_ApplySineWaveScroll:
                movea.l #word_26EBC,a0  ; was: sub_26DF6
                movea.w #(dword_FF9A00-M68K_RAM),a1
                movea.l #word_1B494,a2
                moveq   #$7F,d7
                move.w  (dword_FF807E).w,d1
                andi.w  #$1FE,d1
loc_26E10:                              ; CODE XREF: Effect_ApplySineWaveScroll+2C   j
                move.w  (a0)+,d2
                mulu.w  (a2,d1.w),d2
                asl.l   #3,d2
                swap    d2
                move.w  d2,(a1)+
                addq.w  #1,d1
                andi.w  #$FE,d1
                dbf     d7,loc_26E10
                rts
; End of function Effect_ApplySineWaveScroll
; Applies linear interpolation to scroll buffer using accumulator from dword_FF807E added to word_26EBC base values
Effect_ApplyLinearScroll:
                movea.l #word_26EBC,a0  ; was: sub_26E28
                movea.w #(dword_FF9A00-M68K_RAM),a1
                moveq   #$7F,d7
                moveq   #0,d0
                move.l  (dword_FF807E).w,d1
loc_26E3A:                              ; CODE XREF: Effect_ApplyLinearScroll+1E   j
                add.l   d1,d0
                swap    d0
                move.w  (a0)+,d2
                add.w   d0,d2
                swap    d0
                move.w  d2,(a1)+
                dbf     d7,loc_26E3A
                rts
; End of function Effect_ApplyLinearScroll
; Updates scroll position for effect
Effect_UpdateScrollPosition:                              ; CODE XREF: Boss_DefeatScrollUpdate   p  ; was: sub_26E4C
                                        ; sub_26A9E   p ...
                movea.w #(word_FFE37C-M68K_RAM),a1
                move.w  (word_FF807C).w,d0
                subi.w  #$40,d0 ; '@'
                bpl.s   loc_26E7A
                move.w  #$EEE,d0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_26E72
                btst    #0,(dword_FFFF08).w
                bne.s   loc_26E72
                move.w  #$8CE,d0
loc_26E72:                              ; CODE XREF: Effect_UpdateScrollPosition+18   j
                                        ; Effect_UpdateScrollPosition+20   j
                move.w  d0,$80(a1)
                move.w  d0,(a1)
                rts
; ---------------------------------------------------------------------------
loc_26E7A:                              ; CODE XREF: Effect_UpdateScrollPosition+C   j
                asr.w   #1,d0
                andi.w  #$1E,d0
                move.w  word_26E8C(pc,d0.w),$80(a1)
                move.w  word_26E8C(pc,d0.w),(a1)
                rts
; End of function Effect_UpdateScrollPosition
; ---------------------------------------------------------------------------
word_26E8C:     dc.w $EEE, $CEE, $AEE, $8EE, $6EE, $4CE, $2AE, $8E, $6E, $4E, $2E, $E, $C, $A, 8, 6
                                        ; DATA XREF: Effect_UpdateScrollPosition+34   r
                                        ; Effect_UpdateScrollPosition+3A   r


; Clears 64 longwords of scroll buffer starting at dword_FF9400 to zero
Effect_ClearScrollBuffer:                              ; CODE XREF: Effect_InitPaletteEffect:loc_26BC6   p  ; was: sub_26EAC
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #0,d0
                moveq   #$3F,d7 ; '?'
loc_26EB4:                              ; CODE XREF: Effect_ClearScrollBuffer+A   j
                move.l  d0,(a0)+
                dbf     d7,loc_26EB4
                rts
; End of function Effect_ClearScrollBuffer
; ---------------------------------------------------------------------------
word_26EBC:	binclude	"data/other/word_26EBC.bin"
word_26EBC_End:
word_26FBC:	binclude	"data/other/word_26FBC.bin"
word_26FBC_End:


; Applies palette data to VDP during VBlank
Effect_ApplyPaletteToVDP:                              ; CODE XREF: Effect_PaletteUpdateMain+4   j  ; was: sub_271BC
                movea.w #(byte_FF9B00-M68K_RAM),a0
                movea.w #(byte_FF9B00-M68K_RAM),a2
                movea.l #word_26FBC,a1
                move.w  #$FF00,d5
                moveq   #$FFFFFFFE,d6
                move.w  #$7E,d7 ; '~'
                move.w  (word_FF807C).w,d1
                asl.w   #8,d1
                asl.w   #1,d1
                moveq   #0,d3
                move.w  (word_FF807C).w,d2
                beq.s   loc_271F4
                move.l  (dword_FF80A0).w,d3
                divu.w  d2,d3
                andi.l  #$FFFF,d3
                asl.l   #1,d3
                asl.l   #8,d3
loc_271F4:                              ; CODE XREF: Effect_ApplyPaletteToVDP+26   j
                moveq   #0,d2
loc_271F6:                              ; CODE XREF: Effect_ApplyPaletteToVDP+5A   j
                sub.l   d3,d2
                move.l  d2,d4
                swap    d4
                and.l   d6,d4
                cmp.w   d5,d4
                bpl.s   loc_27206
                moveq   #0,d0
                bra.s   loc_27212
; ---------------------------------------------------------------------------
loc_27206:                              ; CODE XREF: Effect_ApplyPaletteToVDP+44   j
                move.w  (a1,d4.w),d0
                mulu.w  d1,d0
                swap    d0
                andi.w  #$FFFE,d0
loc_27212:                              ; CODE XREF: Effect_ApplyPaletteToVDP+48   j
                move.w  d0,-(a0)
                move.w  d0,(a2)+
                dbf     d7,loc_271F6
                movea.w #(dword_FF9A00-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                move.w  (dword_FF807E).w,d4
                subi.w  #$80,d4
                move.w  (dword_FF807E+2).w,d0
                subi.w  #$180,d0
                neg.w   d0
                andi.w  #$FFFE,d0
                adda.w  d0,a0
                moveq   #2,d1
                move.w  #$FE,d2
                moveq   #$7E,d7 ; '~'
loc_27246:                              ; CODE XREF: Effect_ApplyPaletteToVDP+E6   j
                move.w  (a0)+,d0
                cmpa.w  #$9A02,a0
                bmi.s   loc_27254
                cmpa.w  #$9C00,a0
                bmi.s   loc_27256
loc_27254:                              ; CODE XREF: Effect_ApplyPaletteToVDP+90   j
                moveq   #0,d0
loc_27256:                              ; CODE XREF: Effect_ApplyPaletteToVDP+96   j
                move.w  d4,d5
                sub.w   d0,d5
                move.w  d5,d6
                bmi.s   loc_27264
                cmpi.w  #4,d5
                bpl.s   loc_27276
loc_27264:                              ; CODE XREF: Effect_ApplyPaletteToVDP+A0   j
                asr.w   #1,d5
                add.w   d5,d0
                bpl.s   loc_2726C
loc_2726A:                              ; CODE XREF: Effect_ApplyPaletteToVDP+C8   j
                moveq   #0,d0
loc_2726C:                              ; CODE XREF: Effect_ApplyPaletteToVDP+AC   j
                moveq   #0,d5
                andi.w  #2,d6
                add.w   d6,d5
                bra.s   loc_27298
; ---------------------------------------------------------------------------
loc_27276:                              ; CODE XREF: Effect_ApplyPaletteToVDP+A6   j
                cmpi.w  #$9E,d0
                bmi.s   loc_27280
                move.w  #$9E,d0
loc_27280:                              ; CODE XREF: Effect_ApplyPaletteToVDP+BE   j
                cmpi.w  #$140,d5
                bpl.s   loc_2726A
                move.w  d5,d3
                asr.w   #1,d3
                add.w   d0,d3
                cmpi.w  #$100,d3
                bmi.s   loc_27298
                move.w  #$140,d0
                sub.w   d5,d0
loc_27298:                              ; CODE XREF: Effect_ApplyPaletteToVDP+B8   j
                                        ; Effect_ApplyPaletteToVDP+D4   j
                move.w  d5,(a3)+
                sub.w   d1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                addq.w  #2,d1
                dbf     d7,loc_27246
                rts
; End of function Effect_ApplyPaletteToVDP
; Clears palette effect buffer and resets state counters
Effect_ClearPaletteBuffer:                              ; CODE XREF: Boss_DefeatInitAnimation+16   j  ; was: sub_272A8
                                        ; Effect_TransitionInit+16   j ...
                clr.w   (word_FF8082).w
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #0,d0
                moveq   #$17,d7
loc_272B4:                              ; CODE XREF: Effect_ClearPaletteBuffer+E   j
                move.l  d0,(a0)+
                dbf     d7,loc_272B4
                bra.w   loc_27376
; End of function Effect_ClearPaletteBuffer
; Updates scroll values for transition
Effect_ScrollUpdate:                              ; CODE XREF: Effect_SetupScroll+C   p  ; was: sub_272BE
                                        ; Stage_TunnelSetScroll+C   p
                moveq   #0,d0
                move.l  #$EEEE0000,d1
                move.l  #$EEEEEEEE,d2
                move.l  d0,d3
                move.l  d1,d4
                move.l  d2,d5
loc_272D2:                              ; CODE XREF: Effect_ScrollMaskPattern1+38   j
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #3,d7
loc_272D8:                              ; CODE XREF: Effect_ScrollUpdate+1E   j
                move.l  d2,(a0)+
                move.l  d5,(a0)+
                dbf     d7,loc_272D8
                move.l  d0,(a0)+
                move.l  d3,(a0)+
                move.l  d1,(a0)+
                move.l  d4,(a0)+
                move.l  d2,(a0)+
                move.l  d5,(a0)+
                move.l  d2,(a0)+
                move.l  d5,(a0)+
                moveq   #2,d7
loc_272F2:                              ; CODE XREF: Effect_ScrollUpdate+38   j
                move.l  d0,(a0)+
                move.l  d3,(a0)+
                dbf     d7,loc_272F2
                move.l  d1,(a0)+
                move.l  d4,(a0)+
                bra.w   loc_27376
; End of function Effect_ScrollUpdate
; Initializes special scroll pattern with EEEEEEEE values for boss defeat effect, sets up 40 bytes of pattern
Effect_InitDefeatScroll:                              ; CODE XREF: Boss_DefeatScrollInit+C   p  ; was: sub_27302
                moveq   #0,d0
                move.l  #$EEEEEEEE,d2
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #7,d7
loc_27310:                              ; CODE XREF: Effect_InitDefeatScroll+10   j
                move.l  d2,(a0)+
                dbf     d7,loc_27310
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                moveq   #7,d7
loc_27328:                              ; CODE XREF: Effect_InitDefeatScroll+28   j
                move.l  d0,(a0)+
                dbf     d7,loc_27328
                bra.w   loc_27376
; End of function Effect_InitDefeatScroll
; Masks individual scroll buffer byte based on word_FF8082 timer, using lookup table to select byte offset
Effect_MaskScrollByte:
                movea.w #(dword_FF9400-M68K_RAM),a0  ; was: sub_27332
                lea     word_2739C(pc),a1
                nop
                move.b  #$F,d3
                move.w  (word_FF8082).w,d0
                cmpi.w  #$20,d0 ; ' '
                bmi.s   loc_2734E
                move.b  #$F0,d3
loc_2734E:                              ; CODE XREF: Effect_MaskScrollByte+16   j
                andi.w  #$1F,d0
                moveq   #0,d2
                move.b  (a1,d0.w),d2
                move.b  (a0,d2.w),d1
                and.b   d3,d1
                move.b  d1,(a0,d2.w)
                move.b  $20(a0,d2.w),d1
                and.b   d3,d1
                move.b  d1,$20(a0,d2.w)
                move.b  $40(a0,d2.w),d1
                and.b   d3,d1
                move.b  d1,$40(a0,d2.w)
loc_27376:                              ; CODE XREF: Effect_ClearPaletteBuffer+12   j
                                        ; Effect_ScrollUpdate+40   j ...
                movea.w (word_FFF70C).w,a1
                move.w  #$82,-(a1)
                move.w  #$73A0,-(a1)
                move.w  #$9500,-(a1)
                move.w  #$96CA,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009330,-(a1)
                move.w  a1,(word_FFF70C).w
                rts
; End of function Effect_MaskScrollByte
; ---------------------------------------------------------------------------
word_2739C:     dc.w $10, $111, $212, $313, $414, $515, $616, $717, $818, $919, $A1A, $B1B, $C1C, $D1D, $E1E, $F1F
                                        ; DATA XREF: Effect_MaskScrollByte+4   o


; Resets transition effect state
Effect_ResetTransitionState:                              ; CODE XREF: Boss_DefeatScrollUpdate+1A   j  ; was: sub_273BC
                                        ; Effect_UpdateTransition+2C   j ...
                lea     dword_2740E(pc),a1
                nop
                move.w  (word_FF807C).w,d2
                asr.w   #2,d2
                andi.w  #$1C,d2
                move.l  (a1,d2.w),d0
                move.l  $20(a1,d2.w),d1
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(dword_FF9420-M68K_RAM),a1
                movea.w #(word_FF9440-M68K_RAM),a2
                moveq   #3,d7
loc_273E2:                              ; CODE XREF: Effect_ResetTransitionState+4A   j
                move.l  (a0),d2
                move.l  (a1),d3
                move.l  (a2),d4
                and.l   d0,d2
                and.l   d0,d3
                and.l   d0,d4
                move.l  d2,(a0)+
                move.l  d3,(a1)+
                move.l  d4,(a2)+
                move.l  (a0),d2
                move.l  (a1),d3
                move.l  (a2),d4
                and.l   d1,d2
                and.l   d1,d3
                and.l   d1,d4
                move.l  d2,(a0)+
                move.l  d3,(a1)+
                move.l  d4,(a2)+
                dbf     d7,loc_273E2
                bra.w   loc_27376
; End of function Effect_ResetTransitionState
; ---------------------------------------------------------------------------
dword_2740E:    dc.l $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFF0FFF
                                        ; DATA XREF: Effect_ResetTransitionState   o
                dc.l $F0F0F0F, $F0F0F0F, $F0F0F0F, $F000F
                dc.l $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFF0FFF0
                dc.l $F0F0F0F0, $F0F0F0F0, $F0F0F0F0, $F000F000


; Applies masked scroll pattern using time-based lookup from dword_2748A table, creates layered effect masks
Effect_ScrollMaskPattern1:
                lea     dword_2748A(pc),a1  ; was: sub_2744E
                nop
                move.w  (word_FF807C).w,d2
                asr.w   #2,d2
                andi.w  #$1C,d2
                move.l  (a1,d2.w),d6
                move.l  $20(a1,d2.w),d7
                moveq   #0,d0
                move.l  #$EEEE0000,d1
                move.l  #$EEEEEEEE,d2
                move.l  d0,d3
                move.l  d1,d4
                move.l  d2,d5
                and.l   d6,d0
                and.l   d6,d1
                and.l   d6,d2
                and.l   d7,d3
                and.l   d7,d4
                and.l   d7,d5
                bra.w   loc_272D2
; End of function Effect_ScrollMaskPattern1
; ---------------------------------------------------------------------------
dword_2748A:    dc.l $FFFFFFFF, $FFFFFFF, $FFF0FFF, $F0F0FFF
                                        ; DATA XREF: Effect_ScrollMaskPattern1   o
                dc.l $F0F0F0F, $F0F0F, $F000F, $F
                dc.l $FFFFFFFF, $FFFFFFF0, $FFF0FFF0, $FFF0F0F0
                dc.l $F0F0F0F0, $F0F0F000, $F000F000, $F0000000


; Complex scroll wave effect combining palette copy, sine table scrolling, and clamped vertical offset calculations
Effect_ComplexScrollWave:                              ; DATA XREF: ROM:00026BA4   o  ; was: sub_274CA
                movea.w #(word_FF9500-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a1
                moveq   #3,d7
                bsr.w Effect_CopyPaletteData
                movea.w #(byte_FF9A80-M68K_RAM),a0
                movea.w #(byte_FF9A80-M68K_RAM),a2
                movea.l #word_26FBC,a1
                move.w  #$FF00,d5
                moveq   #$FFFFFFFE,d6
                move.w  #$3E,d7 ; '>'
                move.w  (word_FF807C).w,d1
                asl.w   #8,d1
                asl.w   #1,d1
                moveq   #0,d3
                move.w  (word_FF807C).w,d2
                beq.s   loc_27510
                move.l  (dword_FF80A0).w,d3
                divu.w  d2,d3
                andi.l  #$FFFF,d3
                asl.l   #1,d3
                asl.l   #8,d3
loc_27510:                              ; CODE XREF: Effect_ComplexScrollWave+34   j
                moveq   #0,d2
loc_27512:                              ; CODE XREF: Effect_ComplexScrollWave+68   j
                sub.l   d3,d2
                move.l  d2,d4
                swap    d4
                and.w   d6,d4
                cmp.w   d5,d4
                bpl.s   loc_27522
                moveq   #0,d0
                bra.s   loc_2752E
; ---------------------------------------------------------------------------
loc_27522:                              ; CODE XREF: Effect_ComplexScrollWave+52   j
                move.w  (a1,d4.w),d0
                mulu.w  d1,d0
                swap    d0
                andi.w  #$FFFC,d0
loc_2752E:                              ; CODE XREF: Effect_ComplexScrollWave+56   j
                move.w  d0,-(a0)
                move.w  d0,(a2)+
                dbf     d7,loc_27512
                movea.w #(dword_FF9A00-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                move.w  (dword_FF807E).w,d4
                subi.w  #$80,d4
                move.w  (dword_FF807E+2).w,d0
                subi.w  #$180,d0
                asr.w   #1,d0
                neg.w   d0
                andi.w  #$FFFE,d0
                adda.w  d0,a0
                moveq   #4,d1
                move.w  #$FC,d2
                moveq   #$3E,d7 ; '>'
loc_27564:                              ; CODE XREF: Effect_ComplexScrollWave+F6   j
                move.w  (a0)+,d0
                cmpa.w  #$9A02,a0
                bmi.s   loc_27572
                cmpa.w  #$9B00,a0
                bmi.s   loc_27574
loc_27572:                              ; CODE XREF: Effect_ComplexScrollWave+A0   j
                moveq   #0,d0
loc_27574:                              ; CODE XREF: Effect_ComplexScrollWave+A6   j
                move.w  d4,d5
                sub.w   d0,d5
                move.w  d5,d6
                bmi.s   loc_27582
                cmpi.w  #8,d5
                bpl.s   loc_27594
loc_27582:                              ; CODE XREF: Effect_ComplexScrollWave+B0   j
                asr.w   #1,d5
                add.w   d5,d0
                bpl.s   loc_2758A
loc_27588:                              ; CODE XREF: Effect_ComplexScrollWave+D8   j
                moveq   #0,d0
loc_2758A:                              ; CODE XREF: Effect_ComplexScrollWave+BC   j
                moveq   #0,d5
                andi.w  #4,d6
                add.w   d6,d5
                bra.s   loc_275B6
; ---------------------------------------------------------------------------
loc_27594:                              ; CODE XREF: Effect_ComplexScrollWave+B6   j
                cmpi.w  #$9E,d0
                bmi.s   loc_2759E
                move.w  #$9E,d0
loc_2759E:                              ; CODE XREF: Effect_ComplexScrollWave+CE   j
                cmpi.w  #$140,d5
                bpl.s   loc_27588
                move.w  d5,d3
                asr.w   #1,d3
                add.w   d0,d3
                cmpi.w  #$100,d3
                bmi.s   loc_275B6
                move.w  #$140,d0
                sub.w   d5,d0
loc_275B6:                              ; CODE XREF: Effect_ComplexScrollWave+C8   j
                                        ; Effect_ComplexScrollWave+E4   j
                move.w  d5,(a3)+
                sub.w   d1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                addq.w  #4,d1
                dbf     d7,loc_27564
                rts
; End of function Effect_ComplexScrollWave
; Initializes game over state, loads objects, sets up VDP registers, initializes various game state flags
Stage_InitGameOver:                              ; DATA XREF: Sys_DispatchGameState+CE   o  ; was: sub_275C6
                tst.w   (GameSubstateIndex).w
                bne.s   loc_275E2
                jsr (Sys_InitGameMode).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_275E2:                              ; CODE XREF: Stage_InitGameOver+4   j
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                move.w  #$4C,(word_FFF74A).w ; 'L'
                clr.w   (word_FFF74E).w
                move.b  #3,(word_FFF7E6+1).w
                move.w  #$12,(word_FF8090).w
                move.b  #$28,(word_FFF7D4+1).w ; '('
                move.b  #5,(word_FFF7D8+1).w
                move.b  #0,(word_FFF7F4+1).w
                move.b  #$11,(word_FFF7F0+1).w
                lea     stru_27676(pc),a0
                nop
                jsr     (LoadObjData).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                move.w  #$2C,(word_FFE302).w ; ','
                move.w  #0,(word_FFE304).w
                bsr.w Gfx_InitDitherPatterns1
                movea.w (word_FFF70C).w,a1
                move.w  #$80,-(a1)
                move.w  #$4020,-(a1)
                move.w  #$9500,-(a1)
                move.w  #$96CA,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009340,-(a1)
                move.w  a1,(word_FFF70C).w
                move.w  #1,(dword_FF807E).w
                move.b  #4,d0
                jsr (Input_ProcessButtons).l
                rts
; End of function Stage_InitGameOver
; ---------------------------------------------------------------------------
stru_27676:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_InitGameOver+52   o
                dc.l tiles_18D650       ; field_2
                dc.w $A000              ; field_6
                dc.w $FFFF


; Copies 16 palette entries from dword_FF9A00 to word_FF9800 then calls sub_27692 dispatcher
Effect_CopyGameOverPalette:                              ; DATA XREF: Sys_DispatchGameState+D2   o  ; was: sub_27680
                movea.w #(dword_FF9A00-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a1
                moveq   #$F,d7
                bsr.w Effect_CopyPaletteData
                bsr.s Stage_GameOverDispatcher
                rts
; End of function Effect_CopyGameOverPalette
; Dispatcher that jumps to game over state handler based on GameSubstateIndex index via offset table
Stage_GameOverDispatcher:                              ; CODE XREF: Effect_CopyGameOverPalette+E   p  ; was: sub_27692
                move.w  (GameSubstateIndex).w,d0
                movea.w off_276A2(pc,d0.w),a0
                adda.l  #Stage_DemoInputHandler,a0
                jmp     (a0)
; End of function Stage_GameOverDispatcher
; ---------------------------------------------------------------------------
off_276A2:      dc.w Stage_DemoInputHandler-Stage_DemoInputHandler
                                        ; DATA XREF: Stage_GameOverDispatcher+4   r
                dc.w Stage_CameraAutoAdvance-Stage_DemoInputHandler
                dc.w Gfx_RenderSceneThunk-Stage_DemoInputHandler


; Handles demo/debug input for rotating and adjusting 3D view parameters
Stage_DemoInputHandler:                              ; DATA XREF: Stage_GameOverDispatcher+8   o  ; was: sub_276A8
                                        ; ROM:off_276A2   o ...
                btst    #6,(word_FFF708).w
                beq.s   loc_276C2
                addi.w  #$400,(word_FF807C).w
                cmpi.w  #$2000,(word_FF807C).w
                bmi.s   loc_276C2
                clr.w   (word_FF807C).w
loc_276C2:                              ; CODE XREF: Stage_DemoInputHandler+6   j
                                        ; Stage_DemoInputHandler+14   j
                btst    #4,(word_FFF708).w
                beq.s   loc_276D8
                subi.w  #$400,(word_FF807C).w
                bpl.s   loc_276D8
                move.w  #$2000,(word_FF807C).w
loc_276D8:                              ; CODE XREF: Stage_DemoInputHandler+20   j
                                        ; Stage_DemoInputHandler+28   j
                btst    #1,(word_FFF706).w
                beq.s   loc_276E6
                addi.w  #$10,(dword_FF807E).w
loc_276E6:                              ; CODE XREF: Stage_DemoInputHandler+36   j
                btst    #0,(word_FFF706).w
                beq.s   loc_276FE
                subi.w  #$10,(dword_FF807E).w
                bmi.s   loc_276F8
                bne.s   loc_276FE
loc_276F8:                              ; CODE XREF: Stage_DemoInputHandler+4C   j
                move.w  #$10,(dword_FF807E).w
loc_276FE:                              ; CODE XREF: Stage_DemoInputHandler+44   j
                                        ; Stage_DemoInputHandler+4E   j
                btst    #6,(word_FFF708).w
                beq.s   loc_2771A
                addq.w  #2,(GameSubstateIndex).w
                clr.w   (dword_FF8128).w
                move.w  #$50,(dword_FF807E).w ; 'P'
                move.w  #$20,(word_FF8082).w ; ' '
loc_2771A:                              ; CODE XREF: Stage_DemoInputHandler+5C   j
                bsr.w Gfx_InitSpriteTable
                bra.w Gfx_Render3DLandscape
; End of function Stage_DemoInputHandler
; Auto-advances camera through predefined positions using data table
Stage_CameraAutoAdvance:                              ; DATA XREF: ROM:000276A4   o  ; was: sub_27722
                addi.w  #$18,(dword_FF807E).w
                cmpi.w  #$450,(dword_FF807E).w
                bmi.s   loc_27740
                addq.w  #2,(dword_FF8128).w
                move.w  #$20,(dword_FF807E).w ; ' '
                move.w  #$20,(word_FF8082).w ; ' '
loc_27740:                              ; CODE XREF: Stage_CameraAutoAdvance+C   j
                subq.w  #1,(word_FF8082).w
                move.w  (dword_FF8128).w,d0
                move.w  word_2775A(pc,d0.w),(word_FF807C).w
                bpl.s   loc_27756
                addq.w  #2,(GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_27756:                              ; CODE XREF: Stage_CameraAutoAdvance+2C   j
                bra.w Gfx_Render3DLandscape
; End of function Stage_CameraAutoAdvance
; ---------------------------------------------------------------------------
word_2775A:     dc.w 0, $400, $800, $C00, $1000, $1400, $1800, $400, $1C00, $800, $C00, $2000, $FFFF
                                        ; DATA XREF: Stage_CameraAutoAdvance+26   r


; Attributes: thunk
; Thunk to call 3D scene rendering routine
Gfx_RenderSceneThunk:                              ; DATA XREF: ROM:000276A6   o  ; was: sub_27774
                bra.w Gfx_InitSpriteTable
; End of function Gfx_RenderSceneThunk
; Initializes first set of dither patterns for 3D rendering
Gfx_InitDitherPatterns1:                              ; CODE XREF: Stage_InitGameOver+76   p  ; was: sub_27778
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.l  #$1010101,d4
                move.l  #$10101010,d5
                bsr.s Gfx_FillPatternBlock
                move.l  #0,(a0)+
                move.l  #$10000000,(a0)+
                move.l  #$1000000,(a0)+
                move.l  #$10100000,(a0)+
                move.l  #$1010000,(a0)+
                move.l  #$10101000,(a0)+
                move.l  #$1010100,(a0)+
                move.l  #$10101010,(a0)+
                move.l  #$22222222,d4
                move.l  #$22222222,d5
                bsr.s Gfx_FillPatternBlock
                move.l  #0,(a0)+
                move.l  #$20000000,(a0)+
                move.l  #$22000000,(a0)+
                move.l  #$22200000,(a0)+
                move.l  #$22220000,(a0)+
                move.l  #$22222000,(a0)+
                move.l  #$22222200,(a0)+
                move.l  #$22222220,(a0)+
                rts
; End of function Gfx_InitDitherPatterns1
; Fills 4 blocks with alternating pattern data
Gfx_FillPatternBlock:                              ; CODE XREF: Gfx_InitDitherPatterns1+10   p  ; was: sub_277FA
                                        ; Gfx_InitDitherPatterns1+4E   p
                moveq   #3,d7
loc_277FC:                              ; CODE XREF: Gfx_FillPatternBlock+6   j
                move.l  d4,(a0)+
                move.l  d5,(a0)+
                dbf     d7,loc_277FC
                rts
; End of function Gfx_FillPatternBlock
; Initializes second set of dither patterns for 3D rendering
Gfx_InitDitherPatterns2:
                movea.w #(dword_FF9400-M68K_RAM),a0  ; was: sub_27806
                moveq   #0,d0
                move.l  #$11000000,d1
                move.l  #$11110000,d2
                move.l  #$11111100,d3
                move.l  #$11111111,d4
                bsr.s Gfx_WriteDitherSequence
                moveq   #0,d0
                move.l  #$22000000,d1
                move.l  #$22220000,d2
                move.l  #$22222200,d3
                move.l  #$22222222,d4
; End of function Gfx_InitDitherPatterns2
; Writes decreasing dither pattern sequence to buffer
Gfx_WriteDitherSequence:                              ; CODE XREF: Gfx_InitDitherPatterns2+1E   p  ; was: sub_27840
                moveq   #7,d7
loc_27842:                              ; CODE XREF: Gfx_WriteDitherSequence+4   j
                move.l  d4,(a0)+
                dbf     d7,loc_27842
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d1,(a0)+
                move.l  d1,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d3,(a0)+
                move.l  d3,(a0)+
                rts
; End of function Gfx_WriteDitherSequence
; Initializes sprite table with descending values
Gfx_InitSpriteTable:                              ; CODE XREF: Stage_DemoInputHandler:loc_2771A   p  ; was: sub_2785A
                                        ; sub_27774   j
                movea.w #(word_FF9800-M68K_RAM),a0
                moveq   #$FFFFFFFF,d5
                move.w  #$6F,d7 ; 'o'
loc_27864:                              ; CODE XREF: Gfx_InitSpriteTable+10   j
                move.w  d5,(a0)+
                move.w  d5,(a0)+
                subq.w  #2,d5
                dbf     d7,loc_27864
                rts
; End of function Gfx_InitSpriteTable
; Renders 3D landscape using perspective division and texture mapping
Gfx_Render3DLandscape:                              ; CODE XREF: Stage_DemoInputHandler+76   j  ; was: sub_27870
                                        ; sub_27722:loc_27756   j
                tst.w   (dword_FF807E).w
                beq.w   locret_27916
                move.l  #$8000,d4
                divu.w  (dword_FF807E).w,d4
                subi.w  #$A0,d4
                moveq   #0,d0
                move.w  (word_FF807C).w,d0
                ext.l   d0
                addi.l  #dword_27A2E,d0
                movea.l d0,a0
                movea.w #(word_FF9800-M68K_RAM),a1
                movea.w #(byte_FF9000-M68K_RAM),a2
                move.w  d4,d1
                asl.w   #3,d1
                moveq   #0,d0
                move.w  (word_FF8082).w,d0
                asl.w   #3,d0
                add.w   d1,d0
                swap    d0
                moveq   #0,d1
                move.w  (dword_FF807E).w,d1
                swap    d1
                asr.l   #5,d1
                moveq   #$FFFFFFFF,d5
                move.w  (dword_FF807E).w,d6
                move.w  #$6F,d7 ; 'o'
loc_278C2:                              ; CODE XREF: Gfx_Render3DLandscape+A2   j
                                        ; Gfx_Render3DLandscape+B2   j
                move.l  d0,d2
                bmi.s   loc_27918
                swap    d2
                cmpi.w  #$400,d2
                bpl.s   loc_27928
                andi.w  #$3F8,d2
                moveq   #0,d3
                move.w  (a0,d2.w),d3
                divu.w  d6,d3
                add.w   d5,d3
                move.w  d3,(a1)+
                moveq   #0,d3
                move.w  4(a0,d2.w),d3
                divu.w  d6,d3
                add.w   d5,d3
                move.w  d3,(a1)+
                moveq   #0,d3
                move.w  2(a0,d2.w),d3
                divu.w  d6,d3
                sub.w   d4,d3
                move.w  d3,(a2)
                move.w  d3,4(a2)
                moveq   #0,d3
                move.w  6(a0,d2.w),d3
                divu.w  d6,d3
                sub.w   d4,d3
                move.w  d3,2(a2)
                move.w  d3,6(a2)
                subq.w  #2,d5
                addq.w  #8,a2
                add.l   d1,d0
                dbf     d7,loc_278C2
locret_27916:                           ; CODE XREF: Gfx_Render3DLandscape+4   j
                rts
; ---------------------------------------------------------------------------
loc_27918:                              ; CODE XREF: Gfx_Render3DLandscape+54   j
                move.w  d5,(a1)+
                move.w  d5,(a1)+
                subq.w  #2,d5
                addq.w  #8,a2
                add.l   d1,d0
                dbf     d7,loc_278C2
                rts
; ---------------------------------------------------------------------------
loc_27928:                              ; CODE XREF: Gfx_Render3DLandscape+5C   j
                                        ; Gfx_Render3DLandscape+BE   j
                move.w  d5,(a1)+
                move.w  d5,(a1)+
                subq.w  #2,d5
                dbf     d7,loc_27928
                rts
; End of function Gfx_Render3DLandscape
; Main state machine for tunnel/3D sequence
Stage_TunnelSequencer:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_27934
                move.w  4(a5),d0
                movea.w off_27944(pc,d0.w),a0
                adda.l  #Stage_TunnelInit,a0
                jmp     (a0)
; ---------------------------------------------------------------------------
off_27944:      dc.w Stage_TunnelInit-Stage_TunnelInit
                                        ; DATA XREF: Stage_TunnelSequencer+4   r
                dc.w Stage_TunnelLoadObjects-Stage_TunnelInit
                dc.w Stage_TunnelStartEffect-Stage_TunnelInit
                dc.w Stage_TunnelSetScroll-Stage_TunnelInit
                dc.w Stage_TunnelUpdate-Stage_TunnelInit
; End of function Stage_TunnelSequencer
; Initializes tunnel sequence state and palette
Stage_TunnelInit:                              ; DATA XREF: Stage_TunnelSequencer+8   o  ; was: sub_2794E
                                        ; sub_27934:off_27944   o ...
                move.w  #2,4(a5)
                move.w  #$100,2(a5)
                move.b  #4,(byte_FFA95B).w
                clr.w   (word_FF808A).w
                bra.w Effect_ClearPaletteBuffer
; End of function Stage_TunnelInit
; Loads objects for tunnel sequence
Stage_TunnelLoadObjects:                              ; DATA XREF: Stage_TunnelSequencer+12   o  ; was: sub_27968
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                lea     stru_27982(pc),a0
                nop
                jsr     (LoadObjData).l
                movem.l (sp)+,a5
                rts
; End of function Stage_TunnelLoadObjects
; ---------------------------------------------------------------------------
stru_27982:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_TunnelLoadObjects+8   o
                dc.l byte_18D562        ; field_2
                dc.w $E000              ; field_6
                dc.w $FFFF


; Starts tunnel visual effect with sound and scroll setup
Stage_TunnelStartEffect:                              ; DATA XREF: Stage_TunnelSequencer+14   o  ; was: sub_2798C
                addq.w  #2,4(a5)
                move.b  #3,(byte_FFA95B).w
                move.w  #4,(word_FF8090).w
                move.w  #$10,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #3,(word_FFF7E6+1).w
                clr.w   (word_FF807C).w
                move.b  #$AA,d0
                jsr (Sound_PlaySFX).l
                move.w  #2,(word_FF807A).w
                rts
; End of function Stage_TunnelStartEffect
; Sets scroll parameters for tunnel sequence
Stage_TunnelSetScroll:                              ; DATA XREF: Stage_TunnelSequencer+16   o  ; was: sub_279C2
                addq.w  #2,4(a5)
                move.l  #$18000,(dword_FF80A0).w
                bsr.w Effect_ScrollUpdate
; End of function Stage_TunnelSetScroll
; Updates tunnel sequence with scroll and fade effects
Stage_TunnelUpdate:                              ; DATA XREF: Stage_TunnelSequencer+18   o  ; was: sub_279D2
                bsr.w Effect_UpdateScrollPosition
                move.w  $10(a5),(dword_FF807E).w
                move.w  $14(a5),(dword_FF807E+2).w
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                addq.w  #1,d0
                add.w   d0,(word_FF807C).w
                cmpi.w  #$7F,(word_FF807C).w
                bmi.s   loc_27A1A
                clr.w   (word_FF807A).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                clr.w   (word_FF8090).w
                bset    #4,2(a5)
                move.b  #4,(byte_FFA95B).w
                bra.w Effect_ClearPaletteBuffer
; ---------------------------------------------------------------------------
locret_27A18:                           ; CODE XREF: Stage_TunnelUpdate+50   j
                rts
; ---------------------------------------------------------------------------
loc_27A1A:                              ; CODE XREF: Stage_TunnelUpdate+24   j
                move.w  (word_FF807C).w,d0
                subi.w  #$4E,d0 ; 'N'
                bmi.s   locret_27A18
                asr.w   #4,d0
                move.w  d0,(word_FF8082).w
                bra.w Effect_ResetTransitionState
; End of function Stage_TunnelUpdate
; ---------------------------------------------------------------------------
dword_27A2E:	binclude	"data/other/dword_27A2E.bin"
dword_27A2E_End:


; Initializes VDP register settings
Sys_InitVDPRegisters:                              ; CODE XREF: Sys_VBlankHandler+24   p  ; was: sub_29E2E
                move.w  (word_FF8090).w,d0
                movea.w off_29E3E(pc,d0.w),a0
                adda.l  #Sys_InitXiTigerVRAM,a0
                jmp     (a0)
; End of function Sys_InitVDPRegisters
; ---------------------------------------------------------------------------
off_29E3E:      dc.w locret_29F5A-Sys_InitXiTigerVRAM
                                        ; DATA XREF: Sys_InitVDPRegisters+4   r
                dc.w Sys_InitXiTigerVRAM-Sys_InitXiTigerVRAM
                dc.w Sys_LoadInitialPalette-Sys_InitXiTigerVRAM
                dc.w Sys_InitializeVRAMLayout3-Sys_InitXiTigerVRAM
                dc.w Sys_InitFliesVRAM-Sys_InitXiTigerVRAM
                dc.w Sys_CopyStateValue-Sys_InitXiTigerVRAM
                dc.w Sys_InitFlyingNeoVRAM-Sys_InitXiTigerVRAM
                dc.w Sys_SetupScrollVRAM-Sys_InitXiTigerVRAM
                dc.w Sys_InitializeVRAMLayout7-Sys_InitXiTigerVRAM
                dc.w Gfx_SetupVRAMLayout2-Sys_InitXiTigerVRAM
                dc.w Gfx_SetupVRAMLayout1-Sys_InitXiTigerVRAM
                dc.w Boss_DestroyerProtoVRAMSetup-Sys_InitXiTigerVRAM
                dc.w Boss_ZLeoCopySprites-Sys_InitXiTigerVRAM


; Initializes VRAM layout for Xi-Tiger cutscene
Sys_InitXiTigerVRAM:                              ; DATA XREF: Sys_InitVDPRegisters+8   o  ; was: sub_29E58
                                        ; ROM:off_29E3E   o ...
                movea.w #(byte_FF9F80-M68K_RAM),a2
                movea.w #(word_FF9FC0-M68K_RAM),a3
                moveq   #0,d7
                bra.w Sys_SetupVRAMLayout
; End of function Sys_InitXiTigerVRAM
; Loads initial palette from ROM
Sys_LoadInitialPalette:                              ; DATA XREF: ROM:00029E42   o  ; was: sub_29E66
                movea.w #(word_FF9500-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #3,d7
                bsr.w Sys_SetupVRAMLayout
                movea.w #(word_FF9600-M68K_RAM),a2
                movea.w #(byte_FFE40A-M68K_RAM),a3
                moveq   #$D,d7
                bra.w Sys_ClearVRAMRange
; End of function Sys_LoadInitialPalette
; Sets up VRAM layout for first graphics configuration
Gfx_SetupVRAMLayout1:                              ; DATA XREF: ROM:00029E52   o  ; was: sub_29E82
                movea.w #(word_FF9500-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #1,d7
                bsr.w Sys_SetupVRAMLayout
                movea.w #(word_FF9600-M68K_RAM),a2
                movea.w #(byte_FFE412-M68K_RAM),a3
                moveq   #$D,d7
                bra.w Gfx_CopyRowsRepeated
; End of function Gfx_SetupVRAMLayout1
; Initializes VRAM layout with mode 7 and plane addresses
Sys_InitializeVRAMLayout7:                              ; DATA XREF: ROM:00029E4E   o  ; was: sub_29E9E
                movea.w #(word_FF9C00-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #7,d7
                bra.w Sys_SetupVRAMLayout
; End of function Sys_InitializeVRAMLayout7
; Initializes VRAM layout with mode 3 and plane addresses
Sys_InitializeVRAMLayout3:                              ; DATA XREF: ROM:00029E44   o  ; was: sub_29EAC
                movea.w #(word_FF9C00-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #3,d7
                bra.w Sys_SetupVRAMLayout
; End of function Sys_InitializeVRAMLayout3
; Initializes VRAM layout for flies stage
Sys_InitFliesVRAM:                              ; DATA XREF: ROM:00029E46   o  ; was: sub_29EBA
                movea.w #(word_FF9C00-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #1,d7
                bra.w Sys_SetupVRAMLayout
; End of function Sys_InitFliesVRAM
; Copies system state value from backup to active register
Sys_CopyStateValue:                              ; DATA XREF: ROM:00029E48   o  ; was: sub_29EC8
                move.w  (word_FF9E02).w,(word_FF9E00).w
                rts
; End of function Sys_CopyStateValue
; Initializes VRAM layout for Flying-Neo boss
Sys_InitFlyingNeoVRAM:                              ; DATA XREF: ROM:00029E4A   o  ; was: sub_29ED0
                movea.w #(word_FF9500-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #0,d7
                bra.w Sys_SetupVRAMLayout
; End of function Sys_InitFlyingNeoVRAM
; Sets up VRAM layout with scroll buffer pointers for stage
Sys_SetupScrollVRAM:                              ; DATA XREF: ROM:00029E4C   o  ; was: sub_29EDE
                movea.w #(byte_FF9520-M68K_RAM),a2
                movea.w #(byte_FF9E1E-M68K_RAM),a3
                moveq   #2,d7
                bra.w Sys_SetupVRAMLayout
; End of function Sys_SetupScrollVRAM
; Sets up VRAM layout for second graphics configuration
Gfx_SetupVRAMLayout2:                              ; DATA XREF: ROM:00029E50   o  ; was: sub_29EEC
                movea.w #(dword_FF9A00-M68K_RAM),a2
                movea.w #(word_FF9C00-M68K_RAM),a3
                moveq   #6,d7
                bsr.w Sys_SetupVRAMLayout
                movea.w #(byte_FF9000-M68K_RAM),a2
                movea.w #(word_FFE400-M68K_RAM),a3
                moveq   #$D,d7
                bra.w Sys_SetupVRAMLayout
; End of function Gfx_SetupVRAMLayout2
; VRAM setup handler
Boss_DestroyerProtoVRAMSetup:                              ; DATA XREF: ROM:00029E54   o  ; was: sub_29F08
                movea.w #(dword_FF9A00-M68K_RAM),a2
                movea.w #(word_FF9C00-M68K_RAM),a3
                moveq   #3,d7
                bsr.w Sys_SetupVRAMLayout
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FFE400-M68K_RAM),a3
                moveq   #$D,d7
                bra.w Sys_ClearVRAMRange
; End of function Boss_DestroyerProtoVRAMSetup
; Copy sprite data
Boss_ZLeoCopySprites:                              ; DATA XREF: ROM:00029E56   o  ; was: sub_29F24
                movea.w #(word_FF9E00-M68K_RAM),a0
                movea.w #(word_FF9E40-M68K_RAM),a1
                moveq   #7,d7
loc_29F2E:                              ; CODE XREF: Boss_ZLeoCopySprites+C   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_29F2E
                rts
; End of function Boss_ZLeoCopySprites
; Sets up VRAM layout and plane mappings
Sys_SetupVRAMLayout:                              ; CODE XREF: Sys_InitXiTigerVRAM+A   j  ; was: sub_29F36
                                        ; Sys_LoadInitialPalette+A   p ...
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                dbf d7,Sys_SetupVRAMLayout
locret_29F5A:                           ; DATA XREF: ROM:off_29E3E   o
                rts
; End of function Sys_SetupVRAMLayout
; Copies rows of data to interleaved destination offsets
Gfx_CopyRowsInterleaved:                              ; CODE XREF: Gfx_CopyRowsInterleaved+42   j  ; was: sub_29F5C
                move.w  (a2)+,(a3)
                move.w  (a2)+,4(a3)
                move.w  (a2)+,8(a3)
                move.w  (a2)+,$C(a3)
                move.w  (a2)+,$10(a3)
                move.w  (a2)+,$14(a3)
                move.w  (a2)+,$18(a3)
                move.w  (a2)+,$1C(a3)
                move.w  (a2)+,$20(a3)
                move.w  (a2)+,$24(a3)
                move.w  (a2)+,$28(a3)
                move.w  (a2)+,$2C(a3)
                move.w  (a2)+,$30(a3)
                move.w  (a2)+,$34(a3)
                move.w  (a2)+,$38(a3)
                move.w  (a2)+,$3C(a3)
                lea     $40(a3),a3
                dbf d7,Gfx_CopyRowsInterleaved
                rts
; End of function Gfx_CopyRowsInterleaved
; Copies rows with each value repeated 4 times
Gfx_CopyRowsRepeated:                              ; CODE XREF: Gfx_SetupVRAMLayout1+18   j  ; was: sub_29FA4
                                        ; Gfx_CopyRowsRepeated+4A   j
                move.w  (a2)+,d0
                move.w  d0,(a3)
                move.w  d0,4(a3)
                move.w  d0,8(a3)
                move.w  d0,$C(a3)
                move.w  (a2)+,d0
                move.w  d0,$10(a3)
                move.w  d0,$14(a3)
                move.w  d0,$18(a3)
                move.w  d0,$1C(a3)
                move.w  (a2)+,d0
                move.w  d0,$20(a3)
                move.w  d0,$24(a3)
                move.w  d0,$28(a3)
                move.w  d0,$2C(a3)
                move.w  (a2)+,d0
                move.w  d0,$30(a3)
                move.w  d0,$34(a3)
                move.w  d0,$38(a3)
                move.w  d0,$3C(a3)
                lea     $40(a3),a3
                dbf d7,Gfx_CopyRowsRepeated
                rts
; End of function Gfx_CopyRowsRepeated
; Clears specified VRAM address range
Sys_ClearVRAMRange:                              ; CODE XREF: Sys_LoadInitialPalette+18   j  ; was: sub_29FF4
                                        ; Boss_DestroyerProtoVRAMSetup+18   j ...
                move.w  (a2),(a3)
                move.w  (a2)+,4(a3)
                move.w  (a2),8(a3)
                move.w  (a2)+,$C(a3)
                move.w  (a2),$10(a3)
                move.w  (a2)+,$14(a3)
                move.w  (a2),$18(a3)
                move.w  (a2)+,$1C(a3)
                move.w  (a2),$20(a3)
                move.w  (a2)+,$24(a3)
                move.w  (a2),$28(a3)
                move.w  (a2)+,$2C(a3)
                move.w  (a2),$30(a3)
                move.w  (a2)+,$34(a3)
                move.w  (a2),$38(a3)
                move.w  (a2)+,$3C(a3)
                lea     $40(a3),a3
                dbf d7,Sys_ClearVRAMRange
                rts
; End of function Sys_ClearVRAMRange
; Copies projectile data from source to Valkirie weapon object
Projectile_CopyValkirieData:                              ; CODE XREF: Projectile_ValkirieBullet+1A   j  ; was: sub_2A03C
                move.b  $20(a1),d2
                move.w  #$100,d0
                move.w  #$480,(a0)
                move.w  2(a1),d1
                andi.w  #$C080,d1
                or.w    d0,d1
                move.w  d1,2(a0)
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                move.w  $E(a1),$E(a0)
                move.b  d2,$20(a0)
                move.w  d3,$48(a0)
                move.w  d4,$4A(a0)
                btst    #6,2(a0)
                bne.s   loc_2A08A
                move.w  8(a1),8(a0)
                move.w  $A(a1),$A(a0)
                rts
; ---------------------------------------------------------------------------
loc_2A08A:                              ; CODE XREF: Projectile_CopyValkirieData+3E   j
                move.l  8(a1),8(a0)
                rts
; End of function Projectile_CopyValkirieData
; Projectile main handler
Projectile_ValkirieMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A092
                subq.w  #1,$48(a5)
                bpl.s   loc_2A0A0
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A0A0:                              ; CODE XREF: Projectile_ValkirieMain+4   j
                bset    #7,2(a5)
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                move.w  $4A(a5),d1
                eor.w   d0,d1
                bne.s   locret_2A0BC
                bclr    #7,2(a5)
locret_2A0BC:                           ; CODE XREF: Projectile_ValkirieMain+22   j
                rts
; End of function Projectile_ValkirieMain
; Sets graphics tile pattern and velocity values for sprite display
Gfx_SetupTileGraphics:                              ; CODE XREF: Projectile_ZLeoSpawnDropProjectile+84   p  ; was: sub_2A0BE
                move.w  #$C6B4,$E(a0)
                move.w  #$900,8(a0)
                move.w  #$F4F8,$A(a0)
                clr.b   $20(a0)
                rts
; End of function Gfx_SetupTileGraphics
; Finds free projectile slot and initializes type $424 projectile
Projectile_InitType424:                              ; CODE XREF: Boss_WolfGaropaDiveInit1+6   p  ; was: sub_2A0D6
                                        ; Boss_WolfGaropaDiveInit2+6   p
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_2A100
                move.w  #$424,(a0)
                move.w  #$C6B4,$E(a0)
                move.w  #$900,8(a0)
                move.w  #$F4F8,$A(a0)
                clr.b   $20(a0)
                move.w  #$40,$48(a0) ; '@'
                moveq   #0,d0
locret_2A100:                           ; CODE XREF: Projectile_InitType424+6   j
                rts
; End of function Projectile_InitType424
; Updates timer and toggles sprite visibility based on condition flags
Projectile_TimerAndVisibility:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A102
                subq.w  #1,$48(a5)
                bpl.s   loc_2A110
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A110:                              ; CODE XREF: Projectile_TimerAndVisibility+4   j
                bset    #7,2(a5)
                btst    #2,$49(a5)
                beq.s   locret_2A124
                bclr    #7,2(a5)
locret_2A124:                           ; CODE XREF: Projectile_TimerAndVisibility+1A   j
                rts
; End of function Projectile_TimerAndVisibility
; Sets sprite tile pattern from position table using random frame counter
Gfx_SetTileFromRandomTable:
                movea.w a5,a0  ; was: sub_2A126
loc_2A128:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+68   p
                move.w  (word_FFA000).w,d0
                asl.w   #2,d0
                andi.w  #$C,d0
                move.w  word_2A140(pc,d0.w),$E(a0)
                move.w  word_2A140+2(pc,d0.w),$A(a0)
                rts
; End of function Gfx_SetTileFromRandomTable
; ---------------------------------------------------------------------------
word_2A140:     dc.w $C6FC, $F0F0, $CEFC, $F0, $D6FC, $F000, $DEFC, 0, $30BC, $5C
                                        ; DATA XREF: Gfx_SetTileFromRandomTable+C   r
                                        ; Gfx_SetTileFromRandomTable+12   r


; Initializes projectile with position offset and directional velocity
Projectile_InitWithDirection:
                move.w  #$10,$48(a0)  ; was: sub_2A154
                move.w  #$18,$4A(a0)
                move.w  #$8F00,2(a0)
                add.w   $10(a5),d1
                move.w  d1,$10(a0)
                add.w   $14(a5),d2
                move.w  d2,$14(a0)
                ori.w   #$451F,d0
                move.w  d0,$E(a0)
                move.w  #$400,8(a0)
                move.w  #$F8FC,$A(a0)
                btst    #$B,d0
                beq.s   loc_2A198
                move.w  #$6000,$4C(a0)
                rts
; ---------------------------------------------------------------------------
loc_2A198:                              ; CODE XREF: Projectile_InitWithDirection+3A   j
                move.w  #$A000,$4C(a0)
                rts
; End of function Projectile_InitWithDirection
; Updates projectile trajectory and spawns child projectiles at intervals
Projectile_UpdateWithSpawning:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A1A0
                tst.b   $48(a5)
                bmi.s   loc_2A202
                subq.w  #1,$48(a5)
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2A200
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_2A200
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2A200
                movea.l #dword_2ABF0,a1 ; make offsets?
                bsr.w Sprite_InitFromTable
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                movea.l #word_1B514,a1
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #2,d1
                asl.l   #2,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
locret_2A200:                           ; CODE XREF: Projectile_UpdateWithSpawning+10   j
                                        ; Projectile_UpdateWithSpawning+1A   j ...
                rts
; ---------------------------------------------------------------------------
loc_2A202:                              ; CODE XREF: Projectile_UpdateWithSpawning+4   j
                subq.w  #1,$4A(a5)
                bmi.s   loc_2A234
                move.w  $4C(a5),d0
                ext.l   d0
                add.l   d0,$18(a5)
                tst.w   (word_FFA400).w
                beq.s   loc_2A234
                move.w  (dword_FFA414).w,d0
                cmp.w   $14(a5),d0
                bmi.s   loc_2A22C
                addi.l  #$2000,$1C(a5)
                bra.s   loc_2A234
; ---------------------------------------------------------------------------
loc_2A22C:                              ; CODE XREF: Projectile_UpdateWithSpawning+80   j
                subi.l  #$2000,$1C(a5)
loc_2A234:                              ; CODE XREF: Projectile_UpdateWithSpawning+66   j
                                        ; Projectile_UpdateWithSpawning+76   j ...
                btst    #0,(word_FFA000+1).w
                bne.s   locret_2A270
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2A270
                movea.l #dword_2ABF0,a1 ; make offsets?
                bsr.w Sprite_InitFromTable
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                btst    #3,$E(a5)
                beq.s   loc_2A26A
                move.w  #$FFFF,$18(a0)
                rts
; ---------------------------------------------------------------------------
loc_2A26A:                              ; CODE XREF: Projectile_UpdateWithSpawning+C0   j
                move.w  #1,$18(a0)
locret_2A270:                           ; CODE XREF: Projectile_UpdateWithSpawning+9A   j
                                        ; Projectile_UpdateWithSpawning+A2   j
                rts
; End of function Projectile_UpdateWithSpawning
; Applies downward acceleration and horizontal deceleration to projectile
Projectile_ApplyGravityEffect:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A272
                subq.w  #1,$48(a5)
                bpl.s   loc_2A280
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A280:                              ; CODE XREF: Projectile_ApplyGravityEffect+4   j
                addi.l  #$4000,$1C(a5)
                tst.w   $18(a5)
                bmi.s   loc_2A298
                subi.l  #$2000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A298:                              ; CODE XREF: Projectile_ApplyGravityEffect+1A   j
                addi.l  #$2000,$18(a5)
                rts
; End of function Projectile_ApplyGravityEffect
; Checks projectile lifetime timer
Projectile_CheckLifetime:                              ; CODE XREF: Enemy_InitProjectileType+80   p  ; was: sub_2A2A2
                                        ; Projectile_TerrainCollision+36   j ...
                movea.w a5,a0
loc_2A2A4:                              ; CODE XREF: Effect_DebrisParticleAnimate+30   p
                                        ; Boss_SunsetStingUpdateFragment+30   p
                move.w  #$C4,(a0)
                move.l  #$FFFDC000,$1C(a0)
                move.w  #$480,d0
                add.w   (word_FF808A).w,d0
                btst    #4,$E(a0)
                beq.s Projectile_InitializeExplosion
                bset    #$C,d0
                neg.l   $1C(a0)
; Initializes projectile explosion with sprite and sound effect
Projectile_InitializeExplosion:                              ; CODE XREF: Projectile_CheckLifetime+1C   j  ; was: loc_2A2C8
                move.w  d0,$E(a0)
                move.w  #$E500,2(a0)
                move.l  #off_E9560,8(a0)
                clr.w   $C(a0)
                move.b  #$10,$20(a0)
                move.w  #3,$48(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  #$F010F010,$2C(a0)
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.b  #$BC,d0
                jmp (Sound_PlaySFX).l
; End of function Projectile_CheckLifetime
; Checks object visibility timer and sets flags
