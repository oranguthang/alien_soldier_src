Results_CheckSkipButton:                                ; CODE XREF: Results_WaitForPostStageConfirmation+4   p  ; was: sub_1FBEC
                                        ; Results_UpdateFinalSummary+A   p
                bsr.s   Results_DispatchHandler
                move.w  (PrimaryCameraXPosition).w,(SecondaryCameraXPos).w
                tst.w   (word_FF9442).w
                beq.s   Results_CheckSkipButtonReturn
                btst    #7,(ControllerPressedState).w
                beq.s   Results_CheckSkipButtonReturn
                move.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
Results_CheckSkipButtonReturn:                          ; CODE XREF: Results_CheckSkipButton+C   j  ; was: locret_1FC0C
                                        ; Results_CheckSkipButton+14   j
                rts
; End of function Results_CheckSkipButton
; Dispatches results screen handler by state
Results_DispatchHandler:                                ; CODE XREF: Results_CheckSkipButton   p  ; was: sub_1FC0E
                move.w  (dword_FF9400).w,d0
                lea     Results_HandlerOffsets(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Results_DispatchHandler
; ---------------------------------------------------------------------------
Results_HandlerOffsets: dc.w    Results_InitializeDataDisplay-*  ; DATA XREF: Results_DispatchHandler+4   o  ; was: off_1FC1A
                dc.w    UI_RenderResultsDataRow-*
                dc.w    UI_ScrollResultsScreen-*
                dc.w    UI_RenderResultsRowWithScroll-*
                dc.w    UI_CompleteResultsScroll-*
                dc.w    Results_UpdateBrowsingState-*

; Initializes results data display with score breakdown
Results_InitializeDataDisplay:                          ; DATA XREF: ROM:Results_HandlerOffsets   o  ; was: sub_1FC26
                addq.w  #2,(dword_FF9400).w
                move.w  #1,d0
                move.w  (word_FFFF46).w,(word_FF9442).w
                clr.w   (word_FFFF46).w
                tst.w   (word_FF9442).w
                bne.s   Results_SetExtendedScrollBounds
                tst.w   d0
                bne.s   Results_SetExtendedScrollBounds
                move.w  #$13,(dword_FF943C+2).w
                move.w  #$FF40,(dword_FF943C).w
                bra.s   Results_ConfigureInitialViewport
; ---------------------------------------------------------------------------
Results_SetExtendedScrollBounds:                        ; CODE XREF: Results_InitializeDataDisplay+16   j  ; was: loc_1FC50
                                        ; Results_InitializeDataDisplay+1A   j
                move.w  #$17,(dword_FF943C+2).w
                move.w  #$FEF0,(dword_FF943C).w
Results_ConfigureInitialViewport:                       ; CODE XREF: Results_InitializeDataDisplay+28   j  ; was: loc_1FC5C
                move.w  #$50,(SecondaryCameraYPos).w
                move.w  #$F0,(PrimaryCameraYPosition).w
                clr.w   (PrimaryCameraXPosition).w
                move.w  #$18,d7
                lea     ((dword_FF944E+2)).w,a0
                lea     (StageTimeLimitTable).l,a1
                lea     (StagePhaseSplitTimes).w,a2
                lea     (StageCompletionTimes).w,a3
                lea     (StageResultVisits).w,a4
                moveq   #1,d5
                moveq   #0,d6
Results_BuildStageRowsLoop:                             ; CODE XREF: Results_InitializeDataDisplay+190   j  ; was: loc_1FC8A
                sub.w   d4,d4
                abcd    d5,d6
                move.w  d6,d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                move.w  (dword_FF9400+2).w,d0
                addq.w  #2,(dword_FF9400+2).w
                cmp.w   (StageTableIndex).w,d0
                bhi.s   Results_WriteMissingWeaponSelection
                tst.w   (a2)
                bpl.s   Results_WriteWeaponSelection
                cmp.w   (StageTableIndex).w,d0
                bne.s   Results_WriteMissingWeaponSelection
Results_WriteWeaponSelection:                           ; CODE XREF: Results_InitializeDataDisplay+86   j  ; was: loc_1FCB4
                move.w  (a1),(dword_FF9408+2).w
                move.b  (a1),d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   Results_WriteTimeSeparator
                move.b  1(a1),d0
                bsr.w   UI_ConvertBCDToDigits
                bra.s   Results_AdvanceToFirstInterval
; ---------------------------------------------------------------------------
Results_WriteMissingWeaponSelection:                    ; CODE XREF: Results_InitializeDataDisplay+82   j  ; was: loc_1FCCC
                                        ; Results_InitializeDataDisplay+8C   j
                bsr.w   Results_WriteMissingGlyph
                bsr.w   Results_WriteMissingGlyph
                bsr.w   Results_WriteTimeSeparator
                bsr.w   Results_WriteMissingGlyph
                bsr.w   Results_WriteMissingGlyph
Results_AdvanceToFirstInterval:                         ; CODE XREF: Results_InitializeDataDisplay+A4   j  ; was: loc_1FCE0
                addq.w  #2,a1
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                move.w  (a2)+,(dword_FF940C).w
                bmi.s   Results_WriteMissingFirstInterval
                move.w  (dword_FF9408+2).w,(dword_FF9410+2).w
                move.w  (dword_FF940C).w,(dword_FF9410).w
                bsr.w   Results_FormatBCDTimeDifference
                bra.s   Results_AdvanceToSecondInterval
; ---------------------------------------------------------------------------
Results_WriteMissingFirstInterval:                      ; CODE XREF: Results_InitializeDataDisplay+C8   j  ; was: loc_1FD02
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   Results_WriteTimeSeparator
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
Results_AdvanceToSecondInterval:                        ; CODE XREF: Results_InitializeDataDisplay+DA   j  ; was: loc_1FD16
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                move.w  (a3)+,(dword_FF940C+2).w
                bmi.s   Results_WriteMissingSecondInterval
                move.w  (dword_FF940C).w,(dword_FF9410+2).w
                move.w  (dword_FF940C+2).w,(dword_FF9410).w
                bsr.w   Results_FormatBCDTimeDifference
                bra.s   Results_AdvanceToTotalInterval
; ---------------------------------------------------------------------------
Results_WriteMissingSecondInterval:                     ; CODE XREF: Results_InitializeDataDisplay+FC   j  ; was: loc_1FD36
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   Results_WriteTimeSeparator
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
Results_AdvanceToTotalInterval:                         ; CODE XREF: Results_InitializeDataDisplay+10E   j  ; was: loc_1FD4A
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                tst.w   (dword_FF940C+2).w
                bmi.s   Results_WriteMissingTotalInterval
                move.w  (dword_FF9408+2).w,(dword_FF9410+2).w
                move.w  (dword_FF940C+2).w,(dword_FF9410).w
                bsr.w   Results_FormatBCDTimeDifference
                bra.s   Results_PrepareStageCount
; ---------------------------------------------------------------------------
Results_WriteMissingTotalInterval:                      ; CODE XREF: Results_InitializeDataDisplay+130   j  ; was: loc_1FD6A
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   Results_WriteTimeSeparator
                move.b  #$FF,d0
                bsr.w   UI_ConvertBCDToDigits
Results_PrepareStageCount:                              ; CODE XREF: Results_InitializeDataDisplay+142   j  ; was: loc_1FD7E
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                move.w  (a4)+,d0
                bpl.s   Results_ConvertStageCountToBCD
                tst.w   -2(a3)
                bmi.s   Results_WriteStageCount
Results_ConvertStageCountToBCD:                         ; CODE XREF: Results_InitializeDataDisplay+162   j  ; was: loc_1FD90
                addq.w  #1,d0
                movem.w a0,-(sp)
                lea     (Math_PackedBCDLookup).l,a0
                add.w   d0,d0
                move.w  (a0,d0.w),d0
                movem.w (sp)+,a0
Results_WriteStageCount:                                ; CODE XREF: Results_InitializeDataDisplay+168   j  ; was: loc_1FDA6
                bsr.w   UI_ConvertBCDWordToDigits
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteNullByte
                bsr.w   UI_WriteEndMarker
                dbf     d7,Results_BuildStageRowsLoop
                move.w  #5,d6
Results_AppendBlankRowsLoop:                            ; CODE XREF: Results_InitializeDataDisplay+1A8   j  ; was: loc_1FDBE
                move.w  #$24,d7
Results_ClearBlankRowLoop:                              ; CODE XREF: Results_InitializeDataDisplay+1A0   j  ; was: loc_1FDC2
                bsr.w   UI_WriteNullByte
                dbf     d7,Results_ClearBlankRowLoop
                bsr.w   UI_WriteEndMarker
                dbf     d6,Results_AppendBlankRowsLoop
                bsr.w   Results_ComputeSummaryData
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
                beq.s   Results_SelectCurrentStageRow
                cmpi.b  #$2A,4(a0)                      ; missing-field glyph
                bne.s   Results_SelectAvailableRowPalette
                move.w  #$2300,d0
                bra.s   Results_CheckInitialRowCursor
; ---------------------------------------------------------------------------
Results_SelectAvailableRowPalette:                      ; CODE XREF: UI_RenderResultsDataRow+26   j  ; was: loc_1FE1A
                move.w  #$4300,d0
Results_CheckInitialRowCursor:                          ; CODE XREF: UI_RenderResultsDataRow+2C   j  ; was: loc_1FE1E
                cmp.w   (dword_FF9418).w,d4
                bne.s   Results_RenderInitialPrimaryLine
                move.w  #$FFFF,(dword_FF9418).w
                bra.s   Results_RenderInitialPrimaryLine
; ---------------------------------------------------------------------------
Results_SelectCurrentStageRow:                          ; CODE XREF: UI_RenderResultsDataRow+1E   j  ; was: loc_1FE2C
                move.w  #$6300,d0
                move.w  (dword_FF9404+2).w,(dword_FF9414+2).w
                move.w  (dword_FF941C+2).w,(dword_FF9420).w
                move.w  d4,(dword_FF9418).w
Results_RenderInitialPrimaryLine:                       ; CODE XREF: UI_RenderResultsDataRow+36   j  ; was: loc_1FE40
                                        ; UI_RenderResultsDataRow+3E   j
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                movea.w (dword_FF9420+2).w,a0
                move.b  $B(a0),d0
                cmpi.b  #$22,d0                         ; missing-BCD glyph
                bne.s   Results_SelectInitialDetailText
                cmpi.b  #$2A,4(a0)                      ; missing-field glyph
                bne.s   Results_SelectMissingDetailPalette
                move.w  #$2300,d0
                bra.s   Results_SelectMissingDetailText
; ---------------------------------------------------------------------------
Results_SelectMissingDetailPalette:                     ; CODE XREF: UI_RenderResultsDataRow+6E   j  ; was: loc_1FE62
                move.w  #$4300,d0
Results_SelectMissingDetailText:                        ; CODE XREF: UI_RenderResultsDataRow+74   j  ; was: loc_1FE66
                lea     Results_MissingDetailText(pc),a0
                nop
                bra.s   Results_RenderInitialDetailLine
; ---------------------------------------------------------------------------
Results_SelectInitialDetailText:                        ; CODE XREF: UI_RenderResultsDataRow+66   j  ; was: loc_1FE6E
                move.w  #$6300,d0
                lea     Results_StageDetailTextTable(pc),a0
                nop
                adda.w  (dword_FF941C+2).w,a0
Results_RenderInitialDetailLine:                        ; CODE XREF: UI_RenderResultsDataRow+80   j  ; was: loc_1FE7C
                move.w  #$4050,d4
                add.w   (dword_FF9404).w,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                addi.w  #$100,(dword_FF9404).w
                addi.w  #$26,(dword_FF9404+2).w
                addi.w  #$16,(dword_FF941C+2).w
                addq.w  #1,(dword_FF9400+2).w
                cmpi.w  #$A,(dword_FF9400+2).w
                bcs.s   Results_RenderInitialRowReturn
                addq.w  #2,(dword_FF9400).w
Results_RenderInitialRowReturn:                         ; CODE XREF: UI_RenderResultsDataRow+BA   j  ; was: locret_1FEAC
                rts
; End of function UI_RenderResultsDataRow
; Handles vertical scrolling of results screen with position updates
UI_ScrollResultsScreen:                                 ; DATA XREF: ROM:0001FC1E   o  ; was: sub_1FEAE
                subq.w  #2,(SecondaryCameraYPos).w
                subq.w  #2,(PrimaryCameraYPosition).w
                cmpi.w  #$90,(PrimaryCameraYPosition).w
                bne.s   Results_InitialScrollReturn
                addq.w  #2,(dword_FF9400).w
                tst.w   (word_FF9442).w
                bne.s   Results_SetExtendedScrollTarget
                move.w  (StageTableIndex).w,d0
                lsl.w   #3,d0
                neg.w   d0
                addi.w  #$90,d0
                move.w  d0,(dword_FF9408).w
                rts
; ---------------------------------------------------------------------------
Results_SetExtendedScrollTarget:                        ; CODE XREF: UI_ScrollResultsScreen+18   j  ; was: loc_1FEDA
                move.w  #$FEF0,(dword_FF9408).w
Results_InitialScrollReturn:                            ; CODE XREF: UI_ScrollResultsScreen+E   j  ; was: locret_1FEE0
                rts
; End of function UI_ScrollResultsScreen
; Renders results data row while handling screen scroll position
UI_RenderResultsRowWithScroll:                          ; DATA XREF: ROM:0001FC20   o  ; was: sub_1FEE2
                bsr.w   Results_QueueCompletionMusicAtScrollThreshold
                move.w  (dword_FF9408).w,d0
                cmp.w   (PrimaryCameraYPosition).w,d0
                beq.s   Results_RenderScrolledRow
                subq.w  #2,(PrimaryCameraYPosition).w
Results_RenderScrolledRow:                              ; CODE XREF: UI_RenderResultsRowWithScroll+C   j  ; was: loc_1FEF4
                lea     ((dword_FF944E+2)).w,a0
                adda.w  (dword_FF9404+2).w,a0
                move.w  a0,(dword_FF9420+2).w
                move.w  #$4006,d4
                add.w   (dword_FF9404).w,d4
                move.w  (StageTableIndex).w,d3
                lsr.w   #1,d3
                cmp.w   (dword_FF9400+2).w,d3
                beq.s   Results_SelectScrolledCurrentStageRow
                cmpi.b  #$2A,4(a0)                      ; missing-field glyph
                bne.s   Results_SelectScrolledAvailablePalette
                move.w  #$2300,d0
                bra.s   Results_RenderScrolledPrimaryLine
; ---------------------------------------------------------------------------
Results_SelectScrolledAvailablePalette:                 ; CODE XREF: UI_RenderResultsRowWithScroll+38   j  ; was: loc_1FF22
                move.w  #$4300,d0
                bra.s   Results_RenderScrolledPrimaryLine
; ---------------------------------------------------------------------------
Results_SelectScrolledCurrentStageRow:                  ; CODE XREF: UI_RenderResultsRowWithScroll+30   j  ; was: loc_1FF28
                move.w  #$6300,d0
                move.w  (dword_FF9404+2).w,(dword_FF9414+2).w
                move.w  (dword_FF941C+2).w,(dword_FF9420).w
                move.w  d4,(dword_FF9418).w
Results_RenderScrolledPrimaryLine:                      ; CODE XREF: UI_RenderResultsRowWithScroll+3E   j  ; was: loc_1FF3C
                                        ; UI_RenderResultsRowWithScroll+44   j
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                movea.w (dword_FF9420+2).w,a0
                move.b  $B(a0),d0
                cmpi.b  #$22,d0                         ; missing-BCD glyph
                bne.s   Results_SelectScrolledDetailText
                cmpi.b  #$2A,4(a0)                      ; missing-field glyph
                bne.s   Results_SelectScrolledMissingDetailPalette
                move.w  #$2300,d0
                bra.s   Results_SelectScrolledMissingDetailText
; ---------------------------------------------------------------------------
Results_SelectScrolledMissingDetailPalette:             ; CODE XREF: UI_RenderResultsRowWithScroll+74   j  ; was: loc_1FF5E
                move.w  #$4300,d0
Results_SelectScrolledMissingDetailText:                ; CODE XREF: UI_RenderResultsRowWithScroll+7A   j  ; was: loc_1FF62
                lea     Results_MissingDetailText(pc),a0
                nop
                bra.s   Results_RenderScrolledDetailLine
; ---------------------------------------------------------------------------
Results_SelectScrolledDetailText:                       ; CODE XREF: UI_RenderResultsRowWithScroll+6C   j  ; was: loc_1FF6A
                move.w  #$6300,d0
                lea     Results_StageDetailTextTable(pc),a0
                nop
                adda.w  (dword_FF941C+2).w,a0
Results_RenderScrolledDetailLine:                       ; CODE XREF: UI_RenderResultsRowWithScroll+86   j  ; was: loc_1FF78
                move.w  #$4050,d4
                add.w   (dword_FF9404).w,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                addi.w  #$16,(dword_FF941C+2).w
                addi.w  #$100,(dword_FF9404).w
                addi.w  #$26,(dword_FF9404+2).w
                addq.w  #1,(dword_FF9400+2).w
                cmpi.w  #$10,(dword_FF9400+2).w
                bcs.s   Results_RenderScrolledRowReturn
                addq.w  #2,(dword_FF9400).w
Results_RenderScrolledRowReturn:                        ; CODE XREF: UI_RenderResultsRowWithScroll+C0   j  ; was: locret_1FFA8
                rts
; End of function UI_RenderResultsRowWithScroll
; Completes results screen scroll animation and advances state
UI_CompleteResultsScroll:                               ; DATA XREF: ROM:0001FC22   o  ; was: sub_1FFAA
                bsr.w   Results_QueueCompletionMusicAtScrollThreshold
                bsr.s   UI_CheckResultsScrollBounds
                tst.w   (dword_FF941C).w
                beq.s   Results_FinishScrollPhase
                bsr.s   UI_CheckResultsScrollBounds
                tst.w   (dword_FF941C).w
                beq.s   Results_FinishScrollPhase
                bsr.w   Results_RenderSelectedRowHighlight
                rts
; ---------------------------------------------------------------------------
Results_FinishScrollPhase:                              ; CODE XREF: UI_CompleteResultsScroll+A   j  ; was: loc_1FFC4
                                        ; UI_CompleteResultsScroll+12   j
                addq.w  #2,(dword_FF9400).w
                rts
; End of function UI_CompleteResultsScroll
; Checks if results screen scroll position is within valid bounds
UI_CheckResultsScrollBounds:                            ; CODE XREF: UI_CompleteResultsScroll+4   p  ; was: sub_1FFCA
                                        ; UI_CompleteResultsScroll+C   p
                move.w  (dword_FF9408).w,d0
                cmp.w   (PrimaryCameraYPosition).w,d0
                beq.s   Results_StopViewportUpdate
                move.w  (PrimaryCameraYPosition).w,d0
                cmp.w   (dword_FF943C).w,d0
                ble.s   Results_StopViewportUpdate
                move.w  #$FFFF,(dword_FF941C).w
                bsr.w   Results_UpdateViewport
                rts
; ---------------------------------------------------------------------------
Results_StopViewportUpdate:                             ; CODE XREF: UI_CheckResultsScrollBounds+8   j  ; was: loc_1FFEA
                                        ; UI_CheckResultsScrollBounds+12   j
                clr.w   (dword_FF941C).w
                rts
; End of function UI_CheckResultsScrollBounds
; Queues the completion music once the scrolling rows reach the trigger point
Results_QueueCompletionMusicAtScrollThreshold:          ; CODE XREF: UI_RenderResultsRowWithScroll   p  ; was: sub_1FFF0
                                        ; sub_1FFAA   p
                tst.w   (dword_FF9424).w
                bne.s   Results_CompletionMusicReturn
                move.w  (dword_FF9408).w,d0
                addi.w  #$48,d0
                cmp.w   (PrimaryCameraYPosition).w,d0
                blt.s   Results_CompletionMusicReturn
                move.w  #1,(dword_FF9424).w
                move.b  #$85,d0
                jsr     (Sound_PlaySFX).l
Results_CompletionMusicReturn:                          ; CODE XREF: Results_QueueCompletionMusicAtScrollThreshold+4   j  ; was: locret_20014
                                        ; Results_QueueCompletionMusicAtScrollThreshold+12   j
                rts
; End of function Results_QueueCompletionMusicAtScrollThreshold
; Updates the interactive results view and draws its flashing row cursor
Results_UpdateBrowsingState:                            ; DATA XREF: ROM:0001FC24   o  ; was: sub_20016
                bsr.w   Results_HandleNavigation
                bsr.w   Results_HandleNavigation
                bsr.w   Results_RenderSelectedRowHighlight
                rts
; End of function Results_UpdateBrowsingState
; Handles D-pad scrolling and column snapping for results screen browsing
Results_HandleNavigation:                               ; CODE XREF: Results_UpdateBrowsingState   p  ; was: sub_20024
                                        ; Results_UpdateBrowsingState+4   p
                btst    #2,(ControllerHeldState).w
                beq.s   Results_CheckRightNavigation
                move.w  (PrimaryCameraXPosition).w,d0
                addi.w  #-1,d0
                cmpi.w  #0,d0
                blt.s   Results_StopHorizontalNavigation
                move.w  #1,(dword_FF9438+2).w
                move.w  #$FFFF,(dword_FF9418+2).w
                addi.w  #-1,(PrimaryCameraXPosition).w
Results_CheckRightNavigation:                           ; CODE XREF: Results_HandleNavigation+6   j  ; was: loc_2004C
                btst    #3,(ControllerHeldState).w
                beq.s   Results_CheckUpNavigation
                move.w  (PrimaryCameraXPosition).w,d0
                addq.w  #1,d0
                cmpi.w  #$D0,d0
                bgt.s   Results_StopHorizontalNavigation
                move.w  #1,(dword_FF9438+2).w
                move.w  #1,(dword_FF9418+2).w
                addi.w  #1,(PrimaryCameraXPosition).w
                bra.s   Results_CheckUpNavigation
; ---------------------------------------------------------------------------
Results_StopHorizontalNavigation:                       ; CODE XREF: Results_HandleNavigation+14   j  ; was: loc_20074
                                        ; Results_HandleNavigation+3A   j
                tst.w   (dword_FF9438+2).w
                beq.s   Results_ClearHorizontalStep
                clr.w   (dword_FF9438+2).w
                move.b  #$DB,d0
                jsr     (Sound_PlaySFX).l
Results_ClearHorizontalStep:                            ; CODE XREF: Results_HandleNavigation+54   j  ; was: loc_20088
                clr.w   (dword_FF9418+2).w
Results_CheckUpNavigation:                              ; CODE XREF: Results_HandleNavigation+2E   j  ; was: loc_2008C
                                        ; Results_HandleNavigation+4E   j
                btst    #0,(ControllerHeldState).w
                beq.s   Results_CheckDownNavigation
                move.w  (PrimaryCameraYPosition).w,d0
                addq.w  #1,d0
                cmpi.w  #$90,d0
                bgt.s   Results_StopVerticalNavigation
                move.w  #1,(dword_FF941C).w
                bra.s   Results_UpdateVerticalViewport
; ---------------------------------------------------------------------------
Results_CheckDownNavigation:                            ; CODE XREF: Results_HandleNavigation+6E   j  ; was: loc_200A8
                btst    #1,(ControllerHeldState).w
                beq.w   Results_ContinueHorizontalStep
                move.w  (PrimaryCameraYPosition).w,d0
                subq.w  #1,d0
                cmp.w   (dword_FF943C).w,d0
                blt.s   Results_StopVerticalNavigation
                move.w  #$FFFF,(dword_FF941C).w
Results_UpdateVerticalViewport:                         ; CODE XREF: Results_HandleNavigation+82   j  ; was: loc_200C4
                bsr.w   Results_UpdateViewport
                rts
; ---------------------------------------------------------------------------
Results_StopVerticalNavigation:                         ; CODE XREF: Results_HandleNavigation+7A   j  ; was: loc_200CA
                                        ; Results_HandleNavigation+98   j
                clr.w   (dword_FF941C).w
                rts
; ---------------------------------------------------------------------------
Results_ContinueHorizontalStep:                         ; CODE XREF: Results_HandleNavigation+8A   j  ; was: loc_200D0
                tst.w   (dword_FF9418+2).w
                beq.s   Results_ClampHorizontalMaximum
                move.w  (dword_FF9418+2).w,d0
                add.w   d0,(PrimaryCameraXPosition).w
                move.w  (PrimaryCameraXPosition).w,d0
                andi.w  #$F,d0
                bne.s   Results_ClampHorizontalMaximum
                tst.w   (PrimaryCameraXPosition).w
                beq.s   Results_HandleHorizontalSnapPoint
                cmpi.w  #$30,(PrimaryCameraXPosition).w
                beq.s   Results_HandleHorizontalSnapPoint
                cmpi.w  #$60,(PrimaryCameraXPosition).w
                beq.s   Results_HandleHorizontalSnapPoint
                cmpi.w  #$A0,(PrimaryCameraXPosition).w
                beq.s   Results_HandleHorizontalSnapPoint
                cmpi.w  #$D0,(PrimaryCameraXPosition).w
                bne.s   Results_ClampHorizontalMaximum
Results_HandleHorizontalSnapPoint:                      ; CODE XREF: Results_HandleNavigation+C8   j  ; was: loc_2010E
                                        ; Results_HandleNavigation+D0   j
                tst.b   (ControllerHeldState).w
                bne.s   Results_ClearHorizontalStepAtSnap
                tst.w   (dword_FF9438+2).w
                beq.s   Results_ClearHorizontalStepAtSnap
                clr.w   (dword_FF9438+2).w
                move.b  #$DB,d0
                jsr     (Sound_PlaySFX).l
Results_ClearHorizontalStepAtSnap:                      ; CODE XREF: Results_HandleNavigation+EE   j  ; was: loc_20128
                                        ; Results_HandleNavigation+F4   j
                clr.w   (dword_FF9418+2).w
Results_ClampHorizontalMaximum:                         ; CODE XREF: Results_HandleNavigation+B0   j  ; was: loc_2012C
                                        ; Results_HandleNavigation+C2   j
                cmpi.w  #$D0,(PrimaryCameraXPosition).w
                blt.s   Results_ClampHorizontalMinimum
                move.w  #$D0,(PrimaryCameraXPosition).w
                clr.w   (dword_FF9418+2).w
Results_ClampHorizontalMinimum:                         ; CODE XREF: Results_HandleNavigation+10E   j  ; was: loc_2013E
                cmpi.w  #0,(PrimaryCameraXPosition).w
                bgt.s   Results_ContinueVerticalStep
                move.w  #0,(PrimaryCameraXPosition).w
                clr.w   (dword_FF9418+2).w
Results_ContinueVerticalStep:                           ; CODE XREF: Results_HandleNavigation+120   j  ; was: loc_20150
                tst.w   (dword_FF941C).w
                beq.s   Results_ClampVerticalUpperBound
                bsr.w   Results_UpdateViewport
                move.w  (PrimaryCameraYPosition).w,d0
                andi.w  #$F,d0
                bne.s   Results_ClampVerticalUpperBound
                clr.w   (dword_FF941C).w
Results_ClampVerticalUpperBound:                        ; CODE XREF: Results_HandleNavigation+130   j  ; was: loc_20168
                                        ; Results_HandleNavigation+13E   j
                cmpi.w  #$90,(PrimaryCameraYPosition).w
                blt.s   Results_ClampVerticalLowerBound
                move.w  #$90,(PrimaryCameraYPosition).w
                clr.w   (dword_FF941C).w
Results_ClampVerticalLowerBound:                        ; CODE XREF: Results_HandleNavigation+14A   j  ; was: loc_2017A
                move.w  (PrimaryCameraYPosition).w,d0
                cmp.w   (dword_FF943C).w,d0
                bgt.s   Results_NavigationReturn
                move.w  (dword_FF943C).w,(PrimaryCameraYPosition).w
                clr.w   (dword_FF941C).w
Results_NavigationReturn:                               ; CODE XREF: Results_HandleNavigation+15E   j  ; was: locret_2018E
                rts
; End of function Results_HandleNavigation
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
; Writes the custom-font separator between packed-BCD time fields
Results_WriteTimeSeparator:                             ; CODE XREF: Results_InitializeDataDisplay+98   p  ; was: sub_2019C
                                        ; Results_InitializeDataDisplay+AE   p
                move.b  #$25,(a0)+
                rts
; End of function Results_WriteTimeSeparator
; Writes one custom-font glyph used to mark a missing result field
Results_WriteMissingGlyph:                              ; CODE XREF: Results_InitializeDataDisplay:Results_WriteMissingWeaponSelection   p  ; was: sub_201A2
                                        ; Results_InitializeDataDisplay+AA   p
                move.b  #$2A,(a0)+
                rts
; End of function Results_WriteMissingGlyph
; Converts BCD-encoded byte to two digit characters for display
UI_ConvertBCDToDigits:                                  ; CODE XREF: Results_InitializeDataDisplay+6A   p  ; was: sub_201A8
                                        ; Results_InitializeDataDisplay+94   p
                tst.b   d0
                bmi.s   Results_WriteMissingBCDByte
                move.b  d0,d1
                lsr.b   #4,d1
                addq.b  #1,d1
                move.b  d1,(a0)+
                andi.b  #$F,d0
                addq.b  #1,d0
                move.b  d0,(a0)+
                rts
; ---------------------------------------------------------------------------
Results_WriteMissingBCDByte:                            ; CODE XREF: UI_ConvertBCDToDigits+2   j  ; was: loc_201BE
                move.b  #$22,(a0)+                      ; missing-BCD glyph
                move.b  #$22,(a0)+                      ; missing-BCD glyph
                rts
; End of function UI_ConvertBCDToDigits
; Converts BCD-encoded word to three digit characters for display
UI_ConvertBCDWordToDigits:                              ; CODE XREF: Results_InitializeDataDisplay:Results_WriteStageCount   p  ; was: sub_201C8
                tst.w   d0
                bmi.s   Results_WriteMissingBCDWord
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
Results_WriteMissingBCDWord:                            ; CODE XREF: UI_ConvertBCDWordToDigits+2   j  ; was: loc_201E6
                move.b  #$22,(a0)+                      ; missing-BCD glyph
                move.b  #$22,(a0)+                      ; missing-BCD glyph
                move.b  #$22,(a0)+                      ; missing-BCD glyph
                rts
; End of function UI_ConvertBCDWordToDigits
; Formats the difference between two packed-BCD times with a field separator
Results_FormatBCDTimeDifference:                        ; CODE XREF: Results_InitializeDataDisplay+D6   p  ; was: sub_201F4
                                        ; Results_InitializeDataDisplay+10A   p
                bsr.s   Math_CalculateBCDDifference
                move.b  d2,d0
                bsr.w   UI_ConvertBCDToDigits
                bsr.w   Results_WriteTimeSeparator
                move.b  d3,d0
                bsr.w   UI_ConvertBCDToDigits
                rts
; End of function Results_FormatBCDTimeDifference
; Calculates BCD subtraction between two time values with borrowing
Math_CalculateBCDDifference:                            ; CODE XREF: Results_FormatBCDTimeDifference   p  ; was: sub_20208
                                        ; Results_ComputeSummaryData+5C   p
                move.b  (dword_FF9410+2).w,d0
                move.b  (dword_FF9410).w,d1
                sub.w   d4,d4
                sbcd    d1,d0
                move.b  d0,d2
                move.b  (dword_FF9410+3).w,d0
                move.b  (dword_FF9410+1).w,d1
                cmp.b   d1,d0
                bcc.s   Results_SubtractBCDLowByte
                moveq   #1,d3
                sub.w   d4,d4
                sbcd    d3,d2
                moveq   #$60,d3
                sub.w   d4,d4
                abcd    d3,d0
Results_SubtractBCDLowByte:                             ; CODE XREF: Math_CalculateBCDDifference+18   j  ; was: loc_2022E
                sub.w   d4,d4
                sbcd    d1,d0
                move.b  d0,d3
                rts
; End of function Math_CalculateBCDDifference
; Clears 25 word entries in memory array at FFAA80
Results_ClearSecondIntervalArray:                       ; was: sub_20236
                move.w  #$18,d7
                move.w  #0,d0
                lea     (StageCompletionTimes).w,a0
Results_ClearSecondIntervalArrayLoop:                   ; CODE XREF: Results_ClearSecondIntervalArray+E   j  ; was: loc_20242
                move.w  d0,(a0)+
                dbf     d7,Results_ClearSecondIntervalArrayLoop
                rts
; End of function Results_ClearSecondIntervalArray
