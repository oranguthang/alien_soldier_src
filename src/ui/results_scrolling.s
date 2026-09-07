Results_CheckSkipButton:                                ; CODE XREF: Results_HandleCompletion+4   p  ; was: sub_1FBEC
                                        ; Results_MainLoop+A   p
                bsr.s   Results_DispatchHandler
                move.w  (dword_FFA900).w,(dword_FFA908).w
                tst.w   (word_FF9442).w
                beq.s   locret_1FC0C
                btst    #7,(word_FFF708).w
                beq.s   locret_1FC0C
                move.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
locret_1FC0C:                                           ; CODE XREF: Results_CheckSkipButton+C   j
                                        ; Results_CheckSkipButton+14   j
                rts
; End of function Results_CheckSkipButton
; Dispatches results screen handler by state
Results_DispatchHandler:                                ; CODE XREF: Results_CheckSkipButton   p  ; was: sub_1FC0E
                move.w  (dword_FF9400).w,d0
                lea     off_1FC1A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Results_DispatchHandler
; ---------------------------------------------------------------------------
off_1FC1A:      dc.w    Results_InitializeDataDisplay-*  ; DATA XREF: Results_DispatchHandler+4   o
                dc.w    UI_RenderResultsDataRow-*
                dc.w    UI_ScrollResultsScreen-*
                dc.w    UI_RenderResultsRowWithScroll-*
                dc.w    UI_CompleteResultsScroll-*
                dc.w    UI_WaitForResultsTransition-*

; Initializes results data display with score breakdown
Results_InitializeDataDisplay:                          ; DATA XREF: ROM:off_1FC1A   o  ; was: sub_1FC26
                addq.w  #2,(dword_FF9400).w
                move.w  #1,d0
                move.w  (word_FFFF46).w,(word_FF9442).w
                clr.w   (word_FFFF46).w
                tst.w   (word_FF9442).w
                bne.s   loc_1FC50
                tst.w   d0
                bne.s   loc_1FC50
                move.w  #$13,(dword_FF943C+2).w
                move.w  #$FF40,(dword_FF943C).w
                bra.s   loc_1FC5C
; ---------------------------------------------------------------------------
loc_1FC50:                                              ; CODE XREF: Results_InitializeDataDisplay+16   j
                                        ; Results_InitializeDataDisplay+1A   j
                move.w  #$17,(dword_FF943C+2).w
                move.w  #$FEF0,(dword_FF943C).w
loc_1FC5C:                                              ; CODE XREF: Results_InitializeDataDisplay+28   j
                move.w  #$50,(dword_FFA90C).w           ; 'P'
                move.w  #$F0,(dword_FFA904).w
                clr.w   (dword_FFA900).w
                move.w  #$18,d7
                lea     ((dword_FF944E+2)).w,a0
                lea     (UI_StageWeaponSelectionTable).l,a1
                lea     (word_FFAA00).w,a2
                lea     (word_FFAA80).w,a3
                lea     (word_FFAB00).w,a4
                moveq   #1,d5
                moveq   #0,d6
loc_1FC8A:                                              ; CODE XREF: Results_InitializeDataDisplay+190   j
                sub.w   d4,d4
                abcd    d5,d6
                move.w  d6,d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                move.w  (dword_FF9400+2).w,d0
                addq.w  #2,(dword_FF9400+2).w
                cmp.w   (StageTableIndex).w,d0
                bhi.s   loc_1FCCC
                tst.w   (a2)
                bpl.s   loc_1FCB4
                cmp.w   (StageTableIndex).w,d0
                bne.s   loc_1FCCC
loc_1FCB4:                                              ; CODE XREF: Results_InitializeDataDisplay+86   j
                move.w  (a1),(dword_FF9408+2).w
                move.b  (a1),d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   UI_WritePercentSign
                move.b  1(a1),d0
                bsr.w   UI_ConvertBCDToDigits
                bra.s   loc_1FCE0
; ---------------------------------------------------------------------------
loc_1FCCC:                                              ; CODE XREF: Results_InitializeDataDisplay+82   j
                                        ; Results_InitializeDataDisplay+8C   j
                bsr.w   UI_WriteAsterisk
                bsr.w   UI_WriteAsterisk
                bsr.w   UI_WritePercentSign
                bsr.w   UI_WriteAsterisk
                bsr.w   UI_WriteAsterisk
loc_1FCE0:                                              ; CODE XREF: Results_InitializeDataDisplay+A4   j
                addq.w  #2,a1
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                move.w  (a2)+,(dword_FF940C).w
                bmi.s   loc_1FD02
                move.w  (dword_FF9408+2).w,(dword_FF9410+2).w
                move.w  (dword_FF940C).w,(dword_FF9410).w
                bsr.w   UI_FormatTimeDifference
                bra.s   loc_1FD16
; ---------------------------------------------------------------------------
loc_1FD02:                                              ; CODE XREF: Results_InitializeDataDisplay+C8   j
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   UI_WritePercentSign
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
loc_1FD16:                                              ; CODE XREF: Results_InitializeDataDisplay+DA   j
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                move.w  (a3)+,(dword_FF940C+2).w
                bmi.s   loc_1FD36
                move.w  (dword_FF940C).w,(dword_FF9410+2).w
                move.w  (dword_FF940C+2).w,(dword_FF9410).w
                bsr.w   UI_FormatTimeDifference
                bra.s   loc_1FD4A
; ---------------------------------------------------------------------------
loc_1FD36:                                              ; CODE XREF: Results_InitializeDataDisplay+FC   j
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   UI_WritePercentSign
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
loc_1FD4A:                                              ; CODE XREF: Results_InitializeDataDisplay+10E   j
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                tst.w   (dword_FF940C+2).w
                bmi.s   loc_1FD6A
                move.w  (dword_FF9408+2).w,(dword_FF9410+2).w
                move.w  (dword_FF940C+2).w,(dword_FF9410).w
                bsr.w   UI_FormatTimeDifference
                bra.s   loc_1FD7E
; ---------------------------------------------------------------------------
loc_1FD6A:                                              ; CODE XREF: Results_InitializeDataDisplay+130   j
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   UI_WritePercentSign
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
loc_1FD7E:                                              ; CODE XREF: Results_InitializeDataDisplay+142   j
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                move.w  (a4)+,d0
                bpl.s   loc_1FD90
                tst.w   -2(a3)
                bmi.s   loc_1FDA6
loc_1FD90:                                              ; CODE XREF: Results_InitializeDataDisplay+162   j
                addq.w  #1,d0
                movem.w a0,-(sp)
                lea     (word_5A43E).l,a0
                add.w   d0,d0
                move.w  (a0,d0.w),d0
                movem.w (sp)+,a0
loc_1FDA6:                                              ; CODE XREF: Results_InitializeDataDisplay+168   j
                bsr.w   UI_ConvertBCDWordToDigits
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteEndMarker
                dbf     d7,loc_1FC8A
                move.w  #5,d6
loc_1FDBE:                                              ; CODE XREF: Results_InitializeDataDisplay+1A8   j
                move.w  #$24,d7                         ; '$'
loc_1FDC2:                                              ; CODE XREF: Results_InitializeDataDisplay+1A0   j
                bsr.w   UI_WriteNullByte
                dbf     d7,loc_1FDC2
                bsr.w   UI_WriteEndMarker
                dbf     d6,loc_1FDBE
                bsr.w   UI_PrepareResultsData
                clr.w   (dword_FF9400+2).w
                clr.w   (dword_FF9404).w
                clr.w   (dword_FF9404+2).w
                clr.w   (dword_FF9408).w
                clr.w   (dword_FF9424).w
                rts
; End of function Results_InitializeDataDisplay
; Renders a single row of results screen data with time/percentage display
UI_RenderResultsDataRow:                                ; DATA XREF: ROM:0001FC1C   o  ; was: sub_1FDEC
                lea     ((dword_FF944E+2)).w,a0
                adda.w  (dword_FF9404+2).w,a0
                move.w  a0,(dword_FF9420+2).w
                move.w  #$4006,d4
                add.w   (dword_FF9404).w,d4
                move.w  (StageTableIndex).w,d3
                lsr.w   #1,d3
                cmp.w   (dword_FF9400+2).w,d3
                beq.s   loc_1FE2C
                cmpi.b  #$2A,4(a0)                      ; '*'
                bne.s   loc_1FE1A
                move.w  #$2300,d0
                bra.s   loc_1FE1E
; ---------------------------------------------------------------------------
loc_1FE1A:                                              ; CODE XREF: UI_RenderResultsDataRow+26   j
                move.w  #$4300,d0
loc_1FE1E:                                              ; CODE XREF: UI_RenderResultsDataRow+2C   j
                cmp.w   (dword_FF9418).w,d4
                bne.s   loc_1FE40
                move.w  #$FFFF,(dword_FF9418).w
                bra.s   loc_1FE40
; ---------------------------------------------------------------------------
loc_1FE2C:                                              ; CODE XREF: UI_RenderResultsDataRow+1E   j
                move.w  #$6300,d0
                move.w  (dword_FF9404+2).w,(dword_FF9414+2).w
                move.w  (dword_FF941C+2).w,(dword_FF9420).w
                move.w  d4,(dword_FF9418).w
loc_1FE40:                                              ; CODE XREF: UI_RenderResultsDataRow+36   j
                                        ; UI_RenderResultsDataRow+3E   j
                jsr     (UI_RenderTextStringWrapped).l
                movea.w (dword_FF9420+2).w,a0
                move.b  $B(a0),d0
                cmpi.b  #$22,d0                         ; '"'
                bne.s   loc_1FE6E
                cmpi.b  #$2A,4(a0)                      ; '*'
                bne.s   loc_1FE62
                move.w  #$2300,d0
                bra.s   loc_1FE66
; ---------------------------------------------------------------------------
loc_1FE62:                                              ; CODE XREF: UI_RenderResultsDataRow+6E   j
                move.w  #$4300,d0
loc_1FE66:                                              ; CODE XREF: UI_RenderResultsDataRow+74   j
                lea     word_20650(pc),a0
                nop
                bra.s   loc_1FE7C
; ---------------------------------------------------------------------------
loc_1FE6E:                                              ; CODE XREF: UI_RenderResultsDataRow+66   j
                move.w  #$6300,d0
                lea     word_20666(pc),a0
                nop
                adda.w  (dword_FF941C+2).w,a0
loc_1FE7C:                                              ; CODE XREF: UI_RenderResultsDataRow+80   j
                move.w  #$4050,d4
                add.w   (dword_FF9404).w,d4
                jsr     (UI_RenderTextStringWrapped).l
                addi.w  #$100,(dword_FF9404).w
                addi.w  #$26,(dword_FF9404+2).w         ; '&'
                addi.w  #$16,(dword_FF941C+2).w
                addq.w  #1,(dword_FF9400+2).w
                cmpi.w  #$A,(dword_FF9400+2).w
                bcs.s   locret_1FEAC
                addq.w  #2,(dword_FF9400).w
locret_1FEAC:                                           ; CODE XREF: UI_RenderResultsDataRow+BA   j
                rts
; End of function UI_RenderResultsDataRow
; Handles vertical scrolling of results screen with position updates
UI_ScrollResultsScreen:                                 ; DATA XREF: ROM:0001FC1E   o  ; was: sub_1FEAE
                subq.w  #2,(dword_FFA90C).w
                subq.w  #2,(dword_FFA904).w
                cmpi.w  #$90,(dword_FFA904).w
                bne.s   locret_1FEE0
                addq.w  #2,(dword_FF9400).w
                tst.w   (word_FF9442).w
                bne.s   loc_1FEDA
                move.w  (StageTableIndex).w,d0
                lsl.w   #3,d0
                neg.w   d0
                addi.w  #$90,d0
                move.w  d0,(dword_FF9408).w
                rts
; ---------------------------------------------------------------------------
loc_1FEDA:                                              ; CODE XREF: UI_ScrollResultsScreen+18   j
                move.w  #$FEF0,(dword_FF9408).w
locret_1FEE0:                                           ; CODE XREF: UI_ScrollResultsScreen+E   j
                rts
; End of function UI_ScrollResultsScreen
; Renders results data row while handling screen scroll position
UI_RenderResultsRowWithScroll:                          ; DATA XREF: ROM:0001FC20   o  ; was: sub_1FEE2
                bsr.w   UI_CheckResultsScoreReached
                move.w  (dword_FF9408).w,d0
                cmp.w   (dword_FFA904).w,d0
                beq.s   loc_1FEF4
                subq.w  #2,(dword_FFA904).w
loc_1FEF4:                                              ; CODE XREF: UI_RenderResultsRowWithScroll+C   j
                lea     ((dword_FF944E+2)).w,a0
                adda.w  (dword_FF9404+2).w,a0
                move.w  a0,(dword_FF9420+2).w
                move.w  #$4006,d4
                add.w   (dword_FF9404).w,d4
                move.w  (StageTableIndex).w,d3
                lsr.w   #1,d3
                cmp.w   (dword_FF9400+2).w,d3
                beq.s   loc_1FF28
                cmpi.b  #$2A,4(a0)                      ; '*'
                bne.s   loc_1FF22
                move.w  #$2300,d0
                bra.s   loc_1FF3C
; ---------------------------------------------------------------------------
loc_1FF22:                                              ; CODE XREF: UI_RenderResultsRowWithScroll+38   j
                move.w  #$4300,d0
                bra.s   loc_1FF3C
; ---------------------------------------------------------------------------
loc_1FF28:                                              ; CODE XREF: UI_RenderResultsRowWithScroll+30   j
                move.w  #$6300,d0
                move.w  (dword_FF9404+2).w,(dword_FF9414+2).w
                move.w  (dword_FF941C+2).w,(dword_FF9420).w
                move.w  d4,(dword_FF9418).w
loc_1FF3C:                                              ; CODE XREF: UI_RenderResultsRowWithScroll+3E   j
                                        ; UI_RenderResultsRowWithScroll+44   j
                jsr     (UI_RenderTextStringWrapped).l
                movea.w (dword_FF9420+2).w,a0
                move.b  $B(a0),d0
                cmpi.b  #$22,d0                         ; '"'
                bne.s   loc_1FF6A
                cmpi.b  #$2A,4(a0)                      ; '*'
                bne.s   loc_1FF5E
                move.w  #$2300,d0
                bra.s   loc_1FF62
; ---------------------------------------------------------------------------
loc_1FF5E:                                              ; CODE XREF: UI_RenderResultsRowWithScroll+74   j
                move.w  #$4300,d0
loc_1FF62:                                              ; CODE XREF: UI_RenderResultsRowWithScroll+7A   j
                lea     word_20650(pc),a0
                nop
                bra.s   loc_1FF78
; ---------------------------------------------------------------------------
loc_1FF6A:                                              ; CODE XREF: UI_RenderResultsRowWithScroll+6C   j
                move.w  #$6300,d0
                lea     word_20666(pc),a0
                nop
                adda.w  (dword_FF941C+2).w,a0
loc_1FF78:                                              ; CODE XREF: UI_RenderResultsRowWithScroll+86   j
                move.w  #$4050,d4
                add.w   (dword_FF9404).w,d4
                jsr     (UI_RenderTextStringWrapped).l
                addi.w  #$16,(dword_FF941C+2).w
                addi.w  #$100,(dword_FF9404).w
                addi.w  #$26,(dword_FF9404+2).w         ; '&'
                addq.w  #1,(dword_FF9400+2).w
                cmpi.w  #$10,(dword_FF9400+2).w
                bcs.s   locret_1FFA8
                addq.w  #2,(dword_FF9400).w
locret_1FFA8:                                           ; CODE XREF: UI_RenderResultsRowWithScroll+C0   j
                rts
; End of function UI_RenderResultsRowWithScroll
; Completes results screen scroll animation and advances state
UI_CompleteResultsScroll:                               ; DATA XREF: ROM:0001FC22   o  ; was: sub_1FFAA
                bsr.w   UI_CheckResultsScoreReached
                bsr.s   UI_CheckResultsScrollBounds
                tst.w   (dword_FF941C).w
                beq.s   loc_1FFC4
                bsr.s   UI_CheckResultsScrollBounds
                tst.w   (dword_FF941C).w
                beq.s   loc_1FFC4
                bsr.w   UI_RenderResultsCursor
                rts
; ---------------------------------------------------------------------------
loc_1FFC4:                                              ; CODE XREF: UI_CompleteResultsScroll+A   j
                                        ; UI_CompleteResultsScroll+12   j
                addq.w  #2,(dword_FF9400).w
                rts
; End of function UI_CompleteResultsScroll
; Checks if results screen scroll position is within valid bounds
UI_CheckResultsScrollBounds:                            ; CODE XREF: UI_CompleteResultsScroll+4   p  ; was: sub_1FFCA
                                        ; UI_CompleteResultsScroll+C   p
                move.w  (dword_FF9408).w,d0
                cmp.w   (dword_FFA904).w,d0
                beq.s   loc_1FFEA
                move.w  (dword_FFA904).w,d0
                cmp.w   (dword_FF943C).w,d0
                ble.s   loc_1FFEA
                move.w  #$FFFF,(dword_FF941C).w
                bsr.w   UI_UpdateResultsViewport
                rts
; ---------------------------------------------------------------------------
loc_1FFEA:                                              ; CODE XREF: UI_CheckResultsScrollBounds+8   j
                                        ; UI_CheckResultsScrollBounds+12   j
                clr.w   (dword_FF941C).w
                rts
; End of function UI_CheckResultsScrollBounds
; Checks if results screen scroll reached score threshold and plays sound
UI_CheckResultsScoreReached:                            ; CODE XREF: UI_RenderResultsRowWithScroll   p  ; was: sub_1FFF0
                                        ; sub_1FFAA   p
                tst.w   (dword_FF9424).w
                bne.s   locret_20014
                move.w  (dword_FF9408).w,d0
                addi.w  #$48,d0                         ; 'H'
                cmp.w   (dword_FFA904).w,d0
                blt.s   locret_20014
                move.w  #1,(dword_FF9424).w
                move.b  #$85,d0
                jsr     (Sound_PlaySFX).l
locret_20014:                                           ; CODE XREF: UI_CheckResultsScoreReached+4   j
                                        ; UI_CheckResultsScoreReached+12   j
                rts
; End of function UI_CheckResultsScoreReached
; Waits for results screen transition with double call pattern
UI_WaitForResultsTransition:                            ; DATA XREF: ROM:0001FC24   o  ; was: sub_20016
                bsr.w   Input_HandleResultsNavigation
                bsr.w   Input_HandleResultsNavigation
                bsr.w   UI_RenderResultsCursor
                rts
; End of function UI_WaitForResultsTransition
; Handles D-pad input and navigation for results screen browsing
Input_HandleResultsNavigation:                          ; CODE XREF: UI_WaitForResultsTransition   p  ; was: sub_20024
                                        ; UI_WaitForResultsTransition+4   p
                btst    #2,(word_FFF706).w
                beq.s   loc_2004C
                move.w  (dword_FFA900).w,d0
                addi.w  #-1,d0
                cmpi.w  #0,d0
                blt.s   loc_20074
                move.w  #1,(dword_FF9438+2).w
                move.w  #$FFFF,(dword_FF9418+2).w
                addi.w  #-1,(dword_FFA900).w
loc_2004C:                                              ; CODE XREF: Input_HandleResultsNavigation+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_2008C
                move.w  (dword_FFA900).w,d0
                addq.w  #1,d0
                cmpi.w  #$D0,d0
                bgt.s   loc_20074
                move.w  #1,(dword_FF9438+2).w
                move.w  #1,(dword_FF9418+2).w
                addi.w  #1,(dword_FFA900).w
                bra.s   loc_2008C
; ---------------------------------------------------------------------------
loc_20074:                                              ; CODE XREF: Input_HandleResultsNavigation+14   j
                                        ; Input_HandleResultsNavigation+3A   j
                tst.w   (dword_FF9438+2).w
                beq.s   loc_20088
                clr.w   (dword_FF9438+2).w
                move.b  #$DB,d0
                jsr     (Sound_PlaySFX).l
loc_20088:                                              ; CODE XREF: Input_HandleResultsNavigation+54   j
                clr.w   (dword_FF9418+2).w
loc_2008C:                                              ; CODE XREF: Input_HandleResultsNavigation+2E   j
                                        ; Input_HandleResultsNavigation+4E   j
                btst    #0,(word_FFF706).w
                beq.s   loc_200A8
                move.w  (dword_FFA904).w,d0
                addq.w  #1,d0
                cmpi.w  #$90,d0
                bgt.s   loc_200CA
                move.w  #1,(dword_FF941C).w
                bra.s   loc_200C4
; ---------------------------------------------------------------------------
loc_200A8:                                              ; CODE XREF: Input_HandleResultsNavigation+6E   j
                btst    #1,(word_FFF706).w
                beq.w   loc_200D0
                move.w  (dword_FFA904).w,d0
                subq.w  #1,d0
                cmp.w   (dword_FF943C).w,d0
                blt.s   loc_200CA
                move.w  #$FFFF,(dword_FF941C).w
loc_200C4:                                              ; CODE XREF: Input_HandleResultsNavigation+82   j
                bsr.w   UI_UpdateResultsViewport
                rts
; ---------------------------------------------------------------------------
loc_200CA:                                              ; CODE XREF: Input_HandleResultsNavigation+7A   j
                                        ; Input_HandleResultsNavigation+98   j
                clr.w   (dword_FF941C).w
                rts
; ---------------------------------------------------------------------------
loc_200D0:                                              ; CODE XREF: Input_HandleResultsNavigation+8A   j
                tst.w   (dword_FF9418+2).w
                beq.s   loc_2012C
                move.w  (dword_FF9418+2).w,d0
                add.w   d0,(dword_FFA900).w
                move.w  (dword_FFA900).w,d0
                andi.w  #$F,d0
                bne.s   loc_2012C
                tst.w   (dword_FFA900).w
                beq.s   loc_2010E
                cmpi.w  #$30,(dword_FFA900).w           ; '0'
                beq.s   loc_2010E
                cmpi.w  #$60,(dword_FFA900).w           ; '`'
                beq.s   loc_2010E
                cmpi.w  #$A0,(dword_FFA900).w
                beq.s   loc_2010E
                cmpi.w  #$D0,(dword_FFA900).w
                bne.s   loc_2012C
loc_2010E:                                              ; CODE XREF: Input_HandleResultsNavigation+C8   j
                                        ; Input_HandleResultsNavigation+D0   j
                tst.b   (word_FFF706).w
                bne.s   loc_20128
                tst.w   (dword_FF9438+2).w
                beq.s   loc_20128
                clr.w   (dword_FF9438+2).w
                move.b  #$DB,d0
                jsr     (Sound_PlaySFX).l
loc_20128:                                              ; CODE XREF: Input_HandleResultsNavigation+EE   j
                                        ; Input_HandleResultsNavigation+F4   j
                clr.w   (dword_FF9418+2).w
loc_2012C:                                              ; CODE XREF: Input_HandleResultsNavigation+B0   j
                                        ; Input_HandleResultsNavigation+C2   j
                cmpi.w  #$D0,(dword_FFA900).w
                blt.s   loc_2013E
                move.w  #$D0,(dword_FFA900).w
                clr.w   (dword_FF9418+2).w
loc_2013E:                                              ; CODE XREF: Input_HandleResultsNavigation+10E   j
                cmpi.w  #0,(dword_FFA900).w
                bgt.s   loc_20150
                move.w  #0,(dword_FFA900).w
                clr.w   (dword_FF9418+2).w
loc_20150:                                              ; CODE XREF: Input_HandleResultsNavigation+120   j
                tst.w   (dword_FF941C).w
                beq.s   loc_20168
                bsr.w   UI_UpdateResultsViewport
                move.w  (dword_FFA904).w,d0
                andi.w  #$F,d0
                bne.s   loc_20168
                clr.w   (dword_FF941C).w
loc_20168:                                              ; CODE XREF: Input_HandleResultsNavigation+130   j
                                        ; Input_HandleResultsNavigation+13E   j
                cmpi.w  #$90,(dword_FFA904).w
                blt.s   loc_2017A
                move.w  #$90,(dword_FFA904).w
                clr.w   (dword_FF941C).w
loc_2017A:                                              ; CODE XREF: Input_HandleResultsNavigation+14A   j
                move.w  (dword_FFA904).w,d0
                cmp.w   (dword_FF943C).w,d0
                bgt.s   locret_2018E
                move.w  (dword_FF943C).w,(dword_FFA904).w
                clr.w   (dword_FF941C).w
locret_2018E:                                           ; CODE XREF: Input_HandleResultsNavigation+15E   j
                rts
; End of function Input_HandleResultsNavigation
; Writes end marker (0xFF) to UI text buffer
UI_WriteEndMarker:                                      ; CODE XREF: Results_InitializeDataDisplay+18C   p  ; was: sub_20190
                                        ; Results_InitializeDataDisplay+1A4   p
                move.b  #$FF,(a0)+
                rts
; End of function UI_WriteEndMarker
; Writes null byte (0x00) to UI text buffer
UI_WriteNullByte:                                       ; CODE XREF: Results_InitializeDataDisplay+6E   p  ; was: sub_20196
                                        ; Results_InitializeDataDisplay+72   p
                move.b  #0,(a0)+
                rts
; End of function UI_WriteNullByte
; Writes percent sign character to UI buffer
UI_WritePercentSign:                                    ; CODE XREF: Results_InitializeDataDisplay+98   p  ; was: sub_2019C
                                        ; Results_InitializeDataDisplay+AE   p
                move.b  #$25,(a0)+                      ; '%'
                rts
; End of function UI_WritePercentSign
; Writes asterisk character to UI buffer
UI_WriteAsterisk:                                       ; CODE XREF: Results_InitializeDataDisplay:loc_1FCCC   p  ; was: sub_201A2
                                        ; Results_InitializeDataDisplay+AA   p
                move.b  #$2A,(a0)+                      ; '*'
                rts
; End of function UI_WriteAsterisk
; Converts BCD-encoded byte to two digit characters for display
UI_ConvertBCDToDigits:                                  ; CODE XREF: Results_InitializeDataDisplay+6A   p  ; was: sub_201A8
                                        ; Results_InitializeDataDisplay+94   p
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
loc_201BE:                                              ; CODE XREF: UI_ConvertBCDToDigits+2   j
                move.b  #$22,(a0)+                      ; '"'
                move.b  #$22,(a0)+                      ; '"'
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
loc_201E6:                                              ; CODE XREF: UI_ConvertBCDWordToDigits+2   j
                move.b  #$22,(a0)+                      ; '"'
                move.b  #$22,(a0)+                      ; '"'
                move.b  #$22,(a0)+                      ; '"'
                rts
; End of function UI_ConvertBCDWordToDigits
; Formats time difference between two BCD values with percent separator
UI_FormatTimeDifference:                                ; CODE XREF: Results_InitializeDataDisplay+D6   p  ; was: sub_201F4
                                        ; Results_InitializeDataDisplay+10A   p
                bsr.s   Math_CalculateBCDDifference
                move.b  d2,d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   UI_WritePercentSign
                move.b  d3,d0
                bsr.w   UI_ConvertBCDToDigits
                rts
; End of function UI_FormatTimeDifference
; Calculates BCD subtraction between two time values with borrowing
Math_CalculateBCDDifference:                            ; CODE XREF: UI_FormatTimeDifference   p  ; was: sub_20208
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
                moveq   #$60,d3                         ; '`'
                sub.w   d4,d4
                abcd    d3,d0
loc_2022E:                                              ; CODE XREF: Math_CalculateBCDDifference+18   j
                sub.w   d4,d4
                sbcd    d1,d0
                move.b  d0,d3
                rts
; End of function Math_CalculateBCDDifference
; Clears 25 word entries in memory array at FFAA80
Data_ClearWordArray:
                move.w  #$18,d7                         ; was: sub_20236
                move.w  #0,d0
                lea     (word_FFAA80).w,a0
loc_20242:                                              ; CODE XREF: Data_ClearWordArray+E   j
                move.w  d0,(a0)+
                dbf     d7,loc_20242
                rts
; End of function Data_ClearWordArray
; Processes stage completion times and calculates totals for results screen
