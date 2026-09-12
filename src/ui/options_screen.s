UI_InitOptionsScreen:                                   ; DATA XREF: Sys_DispatchGameState+72   o  ; was: sub_95CA
                tst.w   (GameSubstateIndex).w
                bne.s   UI_InitOptionsScreenLoadDisplay
                jsr     (Sys_InitGameMode).l
                movea.l #Options_AssetLoadDescriptors,a0
                jsr     (LoadObjData).l
                jsr     (Sys_ClearEntityObjectPool).l
                move.w  #4,(PaletteFadeMode).w
                move.w  #$FFF4,(PaletteFadeColorOffset).w
                clr.b   (PaletteFadeMaskStatus).w
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                addq.w  #2,(GameSubstateIndex).w
                jmp     Gfx_QueueLargeFontDMACommand81
; ---------------------------------------------------------------------------
UI_InitOptionsScreenLoadDisplay:                        ; CODE XREF: UI_InitOptionsScreen+4   j  ; was: loc_9612
                cmpi.w  #4,(GameSubstateIndex).w
                beq.w   UI_ActivateOptionsScreen
                addq.w  #2,(GameSubstateIndex).w
                lea     (Gfx_FrontendAlternateVRAMTransferParameters).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                move.w  d0,(SecondaryCameraXPos).w
                move.w  d1,(SecondaryCameraYPos).w
                jsr     (Tilemap_TransferFullMapDirectToVRAM).l
                lea     (OptionsScreenPaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                jsr     (Gfx_FadePaletteTransition).l
                move.b  #0,(VDPReg18Shadow+1).w
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                clr.w   (PrimaryCameraYPosition).w
                clr.w   (PrimaryCameraXPosition).w
                jsr     (Scroll_PreparePlaneBuffersAndRegisterShadows).l
                clr.w   (dword_FF8062+2).w
                clr.w   (dword_FF8062).w
                clr.b   (dword_FF805E+3).w
                clr.b   (dword_FF8066).w
                clr.b   (dword_FF806A+2).w
                move.w  #$20,(dword_FF8066+2).w         ; ' '
                lea     (Text_Options).l,a0
                move.w  #$8300,d0
                move.w  #$4122,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                lea     (Text_Level).l,a0
                move.w  #$8300,d0
                move.w  #$4290,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                lea     (Text_BGMSwitch).l,a0
                move.w  #$8300,d0
                move.w  #$4490,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                lea     (Text_SFXSwitch).l,a0
                move.w  #$8300,d0
                move.w  #$4590,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                lea     (Text_BGMTest).l,a0
                move.w  #$8300,d0
                move.w  #$4710,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                lea     (Text_SFXTest).l,a0
                move.w  #$8300,d0
                move.w  #$4810,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                lea     (Text_VoiceTest).l,a0
                move.w  #$8300,d0
                move.w  #$4910,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                lea     (Text_PressStartToExit).l,a0
                move.w  #$A300,d0
                move.w  #$4B14,d4
                jmp     (Text_QueueDoubleHeightStringWrapped).l
; ---------------------------------------------------------------------------
UI_ActivateOptionsScreen:                               ; CODE XREF: UI_InitOptionsScreen+4E   j  ; was: loc_9728
                move.w  #$20,(GameModeIndex).w          ; ' '
                clr.w   (GameSubstateIndex).w
                move.w  #$118,d0
                move.w  #$B3,d1
                move.l  #FrontendCursor_SpriteMappings,d2
                jsr     (FrontendCursor_Initialize).l
                clr.b   (dword_FF806A).w
                clr.b   (dword_FF806A+1).w
                clr.b   d5
                bsr.w   UI_UpdateDifficultyOption
                clr.b   d5
                bsr.w   UI_UpdateBGMOption
                clr.b   d5
                bsr.w   UI_UpdateSFXOption
                clr.b   d5
                bsr.w   UI_UpdateBGMTest
                clr.b   d5
                bsr.w   UI_UpdateSFXTest
                clr.b   d5
                bsr.w   UI_UpdateVoiceTest
                rts
; End of function UI_InitOptionsScreen
; Updates options screen with input handling and object processing
UI_UpdateOptionsScreen:                                 ; DATA XREF: Sys_DispatchGameState+76   o  ; was: sub_9774
                bclr    #1,(PaletteFadeMaskStatus).w
                beq.s   UI_UpdateOptionsScreenActive
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jmp     UI_ResetPaletteAndMessageMode_Clear
; ---------------------------------------------------------------------------
UI_UpdateOptionsScreenActive:                           ; CODE XREF: UI_UpdateOptionsScreen+6   j  ; was: loc_978C
                tst.w   (PaletteFadeMode).w
                bne.s   UI_UpdateOptionsScreenFrame
                btst    #7,(ControllerPressedState).w
                beq.s   UI_UpdateOptionsScreenFrame
                move.b  #2,(byte_FF830E).w
                move.b  #$C4,d0
                jsr     (Sound_QueueRequest).l
                move.w  #2,(PaletteFadeMode).w
                clr.w   (PaletteFadeColorOffset).w
UI_UpdateOptionsScreenFrame:                            ; CODE XREF: UI_UpdateOptionsScreen+1C   j  ; was: loc_97B4
                                        ; UI_UpdateOptionsScreen+24   j
                jsr     Frontend_AnimateMenuPalette(pc)  ; (pc)
                nop
                jsr     (Object_ApplyCameraMotion).l
                jsr     (Sprite_InitializePriorityBuckets).l
                jsr     (Sys_BeginVisibleObjectList).l
                jsr     (Sys_ProcessVisibleObjects).l
                bsr.w   UI_HandleOptionsInput
                jsr     (Sys_UpdateObjectCount).l
                jsr     (Sprite_RenderObjectList).l
                jsr     (Gfx_FadePaletteTransition).l
                jmp     Scroll_PreparePlaneBuffersAndRegisterShadows
; End of function UI_UpdateOptionsScreen
; Processes directional input and button presses in options menu
UI_HandleOptionsInput:                                  ; CODE XREF: UI_UpdateOptionsScreen+5E   p  ; was: sub_97EE
                bsr.w   FrontendCursor_UpdateFlash
                btst    #0,(dword_FF805E+2).w
                bne.w   OptionsCursor_Animate
                btst    #0,(ControllerPressedState).w
                beq.s   UI_HandleOptionsInputCheckDown
                move.b  #$DB,d0
                jsr     (Sound_QueueRequest).l
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w         ; ' '
                subq.w  #2,(dword_FF8062).w
                bpl.s   UI_HandleOptionsInputCheckDown
                move.w  #$A,(dword_FF8062).w
UI_HandleOptionsInputCheckDown:                         ; CODE XREF: UI_HandleOptionsInput+14   j  ; was: loc_982C
                                        ; UI_HandleOptionsInput+36   j
                btst    #1,(ControllerPressedState).w
                beq.w   UI_HandleOptionsInputUpdateCurrentRow
                move.b  #$DB,d0
                jsr     (Sound_QueueRequest).l
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w         ; ' '
                addq.w  #2,(dword_FF8062).w
                cmpi.w  #$C,(dword_FF8062).w
                bmi.s   UI_HandleOptionsInputReturn
                clr.w   (dword_FF8062).w
UI_HandleOptionsInputReturn:                            ; CODE XREF: UI_HandleOptionsInput+6E   j  ; was: locret_9862
                rts
; ---------------------------------------------------------------------------
UI_HandleOptionsInputUpdateCurrentRow:                  ; CODE XREF: UI_HandleOptionsInput+44   j  ; was: loc_9864
                move.b  (ControllerPressedState).w,(dword_FF806A).w
                move.b  (ControllerHeldState).w,(dword_FF806A+1).w
                move.b  (ControllerPressedState).w,d5
                btst    #4,d5
                beq.s   UI_HandleOptionsInputCheckHorizontal
                move.w  #$20,(dword_FF8066+2).w         ; ' '
                move.b  #4,d0
                jmp     (Sound_QueueRequest).l
; ---------------------------------------------------------------------------
UI_HandleOptionsInputCheckHorizontal:                   ; CODE XREF: UI_HandleOptionsInput+8A   j  ; was: loc_988A
                andi.b  #$60,d5                         ; '`'
UI_ProcessSelectedOptionInput:                          ; CODE XREF: UI_HandleSecondaryOptionsInput+8A   j  ; was: loc_988E
                move.b  (ControllerPressedState).w,d0
                andi.b  #$C,d0
                beq.s   UI_UpdateSelectedOptionRepeatDelay
                move.b  #$AD,d0
                jsr     (Sound_QueueRequest).l
UI_UpdateSelectedOptionRepeatDelay:                     ; CODE XREF: UI_HandleOptionsInput+A8   j  ; was: loc_98A2
                btst    #2,(ControllerHeldState).w
                bne.s   UI_DecrementSelectedOptionRepeatDelay
                btst    #3,(ControllerHeldState).w
                bne.s   UI_DecrementSelectedOptionRepeatDelay
                move.w  #$20,(dword_FF8066+2).w         ; ' '
                bra.s   UI_DispatchSelectedOption
; ---------------------------------------------------------------------------
UI_DecrementSelectedOptionRepeatDelay:                  ; CODE XREF: UI_HandleOptionsInput+BA   j  ; was: loc_98BA
                                        ; UI_HandleOptionsInput+C2   j
                tst.w   (dword_FF8066+2).w
                beq.s   UI_DispatchSelectedOption
                subq.w  #1,(dword_FF8066+2).w
UI_DispatchSelectedOption:                              ; CODE XREF: UI_HandleOptionsInput+CA   j  ; was: loc_98C4
                                        ; UI_HandleOptionsInput+D0   j
                move.w  (dword_FF8062).w,d0
                movea.w UI_OptionHandlerOffsets(pc,d0.w),a0
                adda.l  #UI_UpdateDifficultyOption,a0
                jmp     (a0)
; End of function UI_HandleOptionsInput
; ---------------------------------------------------------------------------
UI_OptionHandlerOffsets:    dc.w    UI_UpdateDifficultyOption-UI_UpdateDifficultyOption  ; was: off_98D4
                dc.w    UI_UpdateBGMOption-UI_UpdateDifficultyOption
                dc.w    UI_UpdateSFXOption-UI_UpdateDifficultyOption
                dc.w    UI_UpdateBGMTest-UI_UpdateDifficultyOption
                dc.w    UI_UpdateSFXTest-UI_UpdateDifficultyOption
                dc.w    UI_UpdateVoiceTest-UI_UpdateDifficultyOption

; Renders first row of options with tile graphics
UI_UpdateDifficultyOption:                              ; CODE XREF: UI_InitOptionsScreen+186   p  ; was: sub_98E0
                                        ; DATA XREF: UI_HandleOptionsInput+DE   o
                lea     Options_SuperEasyLabelTiles(pc),a1
                nop
                lea     Options_SuperHardLabelTiles(pc),a2
                nop
                movea.w #(DifficultyMode-M68K_RAM),a4
                move.w  #$429E,d6
                bra.w   Options_UpdateBit1Toggle
; End of function UI_UpdateDifficultyOption
; Update the BGM test entry, queue its request, and render its track label
UI_UpdateBGMTest:                                       ; CODE XREF: UI_InitOptionsScreen+198   p  ; was: sub_98F8
                                        ; DATA XREF: ROM:000098DA   o
                movea.l #Options_BGMTestEntries,a1
                moveq   #0,d0
                move.b  (dword_FF805E+3).w,d0
                asl.w   #5,d0
                adda.l  d0,a1
                tst.b   d5
                beq.s   UI_RenderBGMTestEntry
                move.w  #$20,(dword_FF8066+2).w         ; ' '
                move.b  (a1),d0
                jmp     (Sound_QueueRequest).l
; ---------------------------------------------------------------------------
UI_RenderBGMTestEntry:                                  ; CODE XREF: UI_UpdateBGMTest+12   j  ; was: loc_991A
                movea.w (VDPStagingDataCursor).w,a0
                adda.l  #2,a1
                movea.l a1,a2
                moveq   #$E,d7
UI_CopyBGMTestEntryTopRow:                              ; CODE XREF: UI_UpdateBGMTest+32   j  ; was: loc_9928
                move.w  (a1)+,(a0)+
                dbf     d7,UI_CopyBGMTestEntryTopRow
                moveq   #$E,d7
UI_CopyBGMTestEntryBottomRow:                           ; CODE XREF: UI_UpdateBGMTest+3E   j  ; was: loc_9930
                move.w  (a2)+,d0
                addq.w  #1,d0
                move.w  d0,(a0)+
                dbf     d7,UI_CopyBGMTestEntryBottomRow
                move.b  (dword_FF805E+3).w,d0
                btst    #2,(dword_FF806A).w
                beq.s   UI_CheckIncrementBGMTestSelection
                move.w  #$A,(dword_FF8062+2).w
                tst.b   d0
                bne.s   UI_DecrementBGMTestSelection
                move.b  #$14,d0
                bra.s   UI_StoreAndRenderBGMTestSelection
; ---------------------------------------------------------------------------
UI_DecrementBGMTestSelection:                           ; CODE XREF: UI_UpdateBGMTest+56   j  ; was: loc_9956
                subq.b  #1,d0
                bra.s   UI_StoreAndRenderBGMTestSelection
; ---------------------------------------------------------------------------
UI_CheckIncrementBGMTestSelection:                      ; CODE XREF: UI_UpdateBGMTest+4C   j  ; was: loc_995A
                btst    #3,(dword_FF806A).w
                beq.s   UI_StoreAndRenderBGMTestSelection
                move.w  #$A,(dword_FF8062+2).w
                cmpi.b  #$14,d0
                bne.s   UI_IncrementBGMTestSelection
                clr.b   d0
                bra.s   UI_StoreAndRenderBGMTestSelection
; ---------------------------------------------------------------------------
UI_IncrementBGMTestSelection:                           ; CODE XREF: UI_UpdateBGMTest+74   j  ; was: loc_9972
                addq.b  #1,d0
UI_StoreAndRenderBGMTestSelection:                      ; CODE XREF: UI_UpdateBGMTest+5C   j  ; was: loc_9974
                                        ; UI_UpdateBGMTest+60   j
                move.b  d0,(dword_FF805E+3).w
                move.w  #$4726,d0
                moveq   #$F,d3
                bsr.w   Options_QueueStagedTileDMA
                move.w  #$47A6,d0
                moveq   #$F,d3
                bra.w   Options_QueueStagedTileDMA
; End of function UI_UpdateBGMTest
; ---------------------------------------------------------------------------
Options_BGMTestEntries: binclude "data/other/options_bgm_test_entries.bin"  ; was: word_998C
Options_BGMTestEntries_End:                             ; was: word_998C_End

; Update the SFX test index and queue the selected low- or high-range SFX ID
UI_UpdateSFXTest:                                       ; CODE XREF: UI_InitOptionsScreen+19E   p  ; was: sub_9C4C
                                        ; DATA XREF: ROM:000098DC   o
                move.b  (dword_FF8066).w,d0
                tst.b   d5
                beq.s   UI_UpdateSFXTestSelection
                lea     Options_SFXTestLowRequestIDs(pc),a0
                nop
                move.b  (a0,d0.w),d0
                jmp     (Sound_QueueRequest).l
; ---------------------------------------------------------------------------
UI_UpdateSFXTestSelection:                              ; CODE XREF: UI_UpdateSFXTest+6   j  ; was: loc_9C64
                moveq   #1,d1
                tst.w   (dword_FF8066+2).w
                bne.s   UI_CheckSFXTestPrimaryInput
                btst    #0,(VBlankFrameCounter+1).w
                bne.s   UI_StoreAndRenderSFXTestSelection
                btst    #2,(dword_FF806A+1).w
                bne.s   UI_SelectPreviousSFXTestID
                btst    #3,(dword_FF806A+1).w
                bne.s   UI_SelectNextSFXTestID
                bra.s   UI_StoreAndRenderSFXTestSelection
; ---------------------------------------------------------------------------
UI_CheckSFXTestPrimaryInput:                            ; CODE XREF: UI_UpdateSFXTest+1E   j  ; was: loc_9C86
                btst    #2,(dword_FF806A).w
                beq.s   UI_CheckNextSFXTestID
                move.w  #6,(dword_FF8062+2).w
UI_SelectPreviousSFXTestID:                             ; CODE XREF: UI_UpdateSFXTest+2E   j  ; was: loc_9C94
                movem.l d0,-(sp)
                move.b  #4,d0
                jsr     (Sound_QueueRequest).l
                movem.l (sp)+,d0
                tst.b   d0
                bne.s   UI_DecrementSFXTestSelection
                move.b  #$98,d0
                bra.s   UI_StoreAndRenderSFXTestSelection
; ---------------------------------------------------------------------------
UI_DecrementSFXTestSelection:                           ; CODE XREF: UI_UpdateSFXTest+5C   j  ; was: loc_9CB0
                subq.b  #1,d0
                bra.s   UI_StoreAndRenderSFXTestSelection
; ---------------------------------------------------------------------------
UI_CheckNextSFXTestID:                                  ; CODE XREF: UI_UpdateSFXTest+40   j  ; was: loc_9CB4
                btst    #3,(dword_FF806A).w
                beq.s   UI_StoreAndRenderSFXTestSelection
                move.w  #6,(dword_FF8062+2).w
UI_SelectNextSFXTestID:                                 ; CODE XREF: UI_UpdateSFXTest+36   j  ; was: loc_9CC2
                movem.l d0,-(sp)
                move.b  #4,d0
                jsr     (Sound_QueueRequest).l
                movem.l (sp)+,d0
                cmpi.b  #$98,d0
                bne.s   UI_IncrementSFXTestSelection
                clr.b   d0
                bra.s   UI_StoreAndRenderSFXTestSelection
; ---------------------------------------------------------------------------
UI_IncrementSFXTestSelection:                           ; CODE XREF: UI_UpdateSFXTest+8C   j  ; was: loc_9CDE
                addq.b  #1,d0
UI_StoreAndRenderSFXTestSelection:                      ; CODE XREF: UI_UpdateSFXTest+26   j  ; was: loc_9CE0
                                        ; UI_UpdateSFXTest+38   j
                move.b  d0,(dword_FF8066).w
                lea     (Math_PackedBCDLookup).l,a0
                asl.w   #1,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d1
                move.w  #$483C,d0
                bra.w   Options_QueueThreeDigitBCD
; End of function UI_UpdateSFXTest
; Update the voice test index and queue the selected voice-DAC request ID
UI_UpdateVoiceTest:                                     ; CODE XREF: UI_InitOptionsScreen+1A4   p  ; was: sub_9CFC
                                        ; DATA XREF: ROM:000098DE   o
                move.b  (dword_FF806A+2).w,d0
                tst.b   d5
                beq.s   UI_UpdateVoiceTestSelection
                lea     Options_VoiceTestRequestIDs(pc),a0
                nop
                move.b  (a0,d0.w),d0
                jmp     (Sound_QueueRequest).l
; ---------------------------------------------------------------------------
UI_UpdateVoiceTestSelection:                            ; CODE XREF: UI_UpdateVoiceTest+6   j  ; was: loc_9D14
                moveq   #1,d1
                tst.w   (dword_FF8066+2).w
                bne.s   UI_CheckVoiceTestPrimaryInput
                btst    #0,(VBlankFrameCounter+1).w
                bne.s   UI_StoreAndRenderVoiceTestSelection
                btst    #2,(dword_FF806A+1).w
                bne.s   UI_SelectPreviousVoiceTestID
                btst    #3,(dword_FF806A+1).w
                bne.s   UI_SelectNextVoiceTestID
                bra.s   UI_StoreAndRenderVoiceTestSelection
; ---------------------------------------------------------------------------
UI_CheckVoiceTestPrimaryInput:                          ; CODE XREF: UI_UpdateVoiceTest+1E   j  ; was: loc_9D36
                btst    #2,(dword_FF806A).w
                beq.s   UI_CheckNextVoiceTestID
                move.w  #6,(dword_FF8062+2).w
UI_SelectPreviousVoiceTestID:                           ; CODE XREF: UI_UpdateVoiceTest+2E   j  ; was: loc_9D44
                tst.b   d0
                bne.s   UI_DecrementVoiceTestSelection
                move.b  #$25,d0                         ; '%'
                bra.s   UI_StoreAndRenderVoiceTestSelection
; ---------------------------------------------------------------------------
UI_DecrementVoiceTestSelection:                         ; CODE XREF: UI_UpdateVoiceTest+4A   j  ; was: loc_9D4E
                subq.w  #1,d0
                bra.s   UI_StoreAndRenderVoiceTestSelection
; ---------------------------------------------------------------------------
UI_CheckNextVoiceTestID:                                ; CODE XREF: UI_UpdateVoiceTest+40   j  ; was: loc_9D52
                btst    #3,(dword_FF806A).w
                beq.s   UI_StoreAndRenderVoiceTestSelection
                move.w  #6,(dword_FF8062+2).w
UI_SelectNextVoiceTestID:                               ; CODE XREF: UI_UpdateVoiceTest+36   j  ; was: loc_9D60
                cmpi.b  #$25,d0                         ; '%'
                bne.s   UI_IncrementVoiceTestSelection
                clr.b   d0
                bra.s   UI_StoreAndRenderVoiceTestSelection
; ---------------------------------------------------------------------------
UI_IncrementVoiceTestSelection:                         ; CODE XREF: UI_UpdateVoiceTest+68   j  ; was: loc_9D6A
                addq.w  #1,d0
UI_StoreAndRenderVoiceTestSelection:                    ; CODE XREF: UI_UpdateVoiceTest+26   j  ; was: loc_9D6C
                                        ; UI_UpdateVoiceTest+38   j
                move.b  d0,(dword_FF806A+2).w
                lea     (Math_PackedBCDLookup).l,a0
                asl.w   #1,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d1
                move.w  #$493E,d0
                bra.w   Options_QueueTwoDigitBCD
; End of function UI_UpdateVoiceTest
; Update the otherwise unreferenced message-mode toggle row
UI_UpdateMessageOption:
                lea     Options_OnLabelTiles(pc),a1     ; was: sub_9D88
                nop
                lea     Options_OffLabelTiles(pc),a2
                nop
                movea.w #(MessageMode-M68K_RAM),a4
                move.w  #$43B6,d6
                bra.w   Options_UpdateBit2Toggle
; End of function UI_UpdateMessageOption
; Update the BGM enable toggle in the shared sound-disable flags
UI_UpdateBGMOption:                                     ; CODE XREF: UI_InitOptionsScreen+18C   p  ; was: sub_9DA0
                                        ; DATA XREF: ROM:000098D6   o
                lea     Options_OnLabelTiles(pc),a1
                nop
                lea     Options_OffLabelTiles(pc),a2
                nop
                movea.w #(SoundDisableFlags-M68K_RAM),a4
                move.w  #$44B6,d6
                bra.w   Options_UpdateBit1Toggle
; End of function UI_UpdateBGMOption
; Update the SFX enable toggle in the shared sound-disable flags
UI_UpdateSFXOption:                                     ; CODE XREF: UI_InitOptionsScreen+192   p  ; was: sub_9DB8
                                        ; DATA XREF: ROM:000098D8   o
                lea     Options_OnLabelTiles(pc),a1
                nop
                lea     Options_OffLabelTiles(pc),a2
                nop
                movea.w #(SoundDisableFlags-M68K_RAM),a4
                move.w  #$45B6,d6
                bra.w   Options_UpdateBit2Toggle
; End of function UI_UpdateSFXOption
; Initialize the secondary options path that reuses the three sound-test rows
UI_InitSecondaryOptionsMenu:                            ; DATA XREF: Sys_DispatchGameState+A2   o  ; was: sub_9DD0
                tst.w   (GameSubstateIndex).w
                bne.s   UI_ActivateSecondaryOptionsMenu
                jsr     (Sys_InitGameMode).l
                movea.l #Options_AssetLoadDescriptors,a0
                jsr     (LoadObjData).l
                move.w  #4,(PaletteFadeMode).w
                move.w  #$FFF4,(PaletteFadeColorOffset).w
                clr.b   (PaletteFadeMaskStatus).w
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                addq.w  #2,(GameSubstateIndex).w
                jmp     Gfx_QueueLargeFontDMACommand81
; ---------------------------------------------------------------------------
UI_ActivateSecondaryOptionsMenu:                        ; CODE XREF: UI_InitSecondaryOptionsMenu+4   j  ; was: loc_9E12
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                move.w  #$800,d0
                moveq   #0,d1
                jsr     (Tilemap_DirectTransferWithPrimaryDescriptor).l
                lea     (FrontendFullPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                jsr     (Gfx_FadePaletteTransition).l
                move.b  #0,(VDPReg18Shadow+1).w
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                move.w  #$FFF0,(PrimaryCameraYPosition).w
                clr.w   (PrimaryCameraXPosition).w
                jsr     (Scroll_PreparePlaneBuffersAndRegisterShadows).l
                clr.w   (dword_FF8062+2).w
                clr.w   (dword_FF8062).w
                clr.w   (dword_FF805E).w
                move.w  #$20,(dword_FF8066+2).w         ; ' '
                move.w  #$118,d0
                move.w  #$CA,d1
                move.l  #FrontendCursor_SpriteMappings,d2
                jsr     (FrontendCursor_Initialize).l
                clr.b   (dword_FF806A).w
                clr.b   (dword_FF806A+1).w
; End of function UI_InitSecondaryOptionsMenu
; Update the secondary options path and its shared sound-test handlers
UI_UpdateSecondaryOptionsMenu:                          ; DATA XREF: Sys_DispatchGameState+A6   o  ; was: sub_9E88
                bclr    #1,(PaletteFadeMaskStatus).w
                beq.s   UI_UpdateSecondaryOptionsMenuActive
                move.w  #$54,(GameModeIndex).w          ; 'T'
                clr.w   (GameSubstateIndex).w
                jmp     UI_ResetPaletteAndMessageMode_Clear
; ---------------------------------------------------------------------------
UI_UpdateSecondaryOptionsMenuActive:                    ; CODE XREF: UI_UpdateSecondaryOptionsMenu+6   j  ; was: loc_9EA0
                tst.w   (PaletteFadeMode).w
                bne.s   UI_UpdateSecondaryOptionsMenuFrame
                btst    #7,(ControllerPressedState).w
                beq.s   UI_UpdateSecondaryOptionsMenuFrame
                move.b  #$C4,d0
                jsr     (Sound_QueueRequest).l
                move.w  #2,(PaletteFadeMode).w
                clr.w   (PaletteFadeColorOffset).w
UI_UpdateSecondaryOptionsMenuFrame:                     ; CODE XREF: UI_UpdateSecondaryOptionsMenu+1C   j  ; was: loc_9EC2
                                        ; UI_UpdateSecondaryOptionsMenu+24   j
                jsr     (Object_ApplyCameraMotion).l
                jsr     (Sprite_InitializePriorityBuckets).l
                jsr     (Sys_BeginVisibleObjectList).l
                jsr     (Sys_ProcessVisibleObjects).l
                bsr.w   UI_HandleSecondaryOptionsInput
                jsr     (Sys_UpdateObjectCount).l
                jsr     (Sprite_RenderObjectList).l
                jsr     (Gfx_FadePaletteTransition).l
                jmp     Scroll_PreparePlaneBuffersAndRegisterShadows
; End of function UI_UpdateSecondaryOptionsMenu
; Processes D-pad input for options menu cursor
UI_HandleSecondaryOptionsInput:                         ; CODE XREF: UI_UpdateSecondaryOptionsMenu+52   p  ; was: sub_9EF6
                bsr.w   FrontendCursor_UpdateFlash
                btst    #0,(dword_FF805E+2).w
                bne.w   SecondaryOptionsCursor_Animate
                move.w  (dword_FF805E).w,d0
                btst    #0,(ControllerPressedState).w
                beq.s   UI_HandleSecondaryOptionsInputCheckDown
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w         ; ' '
                subq.w  #2,d0
                bpl.s   UI_PlaySecondaryOptionsMoveSound
                moveq   #0,d0
UI_HandleSecondaryOptionsInputCheckDown:                ; CODE XREF: UI_HandleSecondaryOptionsInput+18   j  ; was: loc_9F28
                btst    #1,(ControllerPressedState).w
                beq.w   UI_StoreSecondaryOptionsSelection
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w         ; ' '
                addq.w  #2,d0
                cmpi.w  #6,d0
                bmi.s   UI_PlaySecondaryOptionsMoveSound
                moveq   #6,d0
                bra.s   UI_StoreSecondaryOptionsSelection
; ---------------------------------------------------------------------------
UI_PlaySecondaryOptionsMoveSound:                       ; CODE XREF: UI_HandleSecondaryOptionsInput+2E   j  ; was: loc_9F50
                                        ; UI_HandleSecondaryOptionsInput+54   j
                movem.l d0,-(sp)
                move.b  #$DB,d0
                jsr     (Sound_QueueRequest).l
                movem.l (sp)+,d0
UI_StoreSecondaryOptionsSelection:                      ; CODE XREF: UI_HandleSecondaryOptionsInput+38   j  ; was: loc_9F62
                                        ; UI_HandleSecondaryOptionsInput+58   j
                move.w  d0,(dword_FF805E).w
                move.w  UI_SecondaryOptionsHandlerIndices(pc,d0.w),(dword_FF8062).w
                move.b  (ControllerPressedState).w,(dword_FF806A).w
                move.b  (ControllerHeldState).w,(dword_FF806A+1).w
                move.b  (ControllerPressedState).w,d5
                andi.b  #$60,d5                         ; '`'
                bra.w   UI_ProcessSelectedOptionInput
; End of function UI_HandleSecondaryOptionsInput
; ---------------------------------------------------------------------------
; Values 6, 8, and $A select the three sound-test entries above. Value $C
; reads opcode $43FA after that table and reaches ROM $DCDA; the purpose of
; this code/data overlay is unresolved. The $E entry is outside this clamp
UI_SecondaryOptionsHandlerIndices:  dc.w    6, 8, $A, $C, $E  ; was: word_9F84

; Expands a three-digit packed-BCD value into two tile rows and queues both DMAs
Options_QueueThreeDigitBCD:                             ; CODE XREF: UI_UpdateSFXTest+AC   j  ; was: sub_9F8E
                movea.w (VDPStagingDataCursor).w,a0
                move.b  d1,d2
                move.w  d1,d3
                asr.b   #4,d1
                asr.w   #8,d3
                andi.w  #$F,d1
                andi.w  #$F,d2
                andi.w  #1,d3
                asl.w   #1,d1
                asl.w   #1,d2
                asl.w   #1,d3
                addi.w  #-$5CFE,d1
                addi.w  #-$5CFE,d2
                addi.w  #-$5CFE,d3
                move.w  d3,(a0)+
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                addq.w  #1,d1
                addq.w  #1,d2
                addq.w  #1,d3
                move.w  d3,(a0)+
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                moveq   #3,d3
                bsr.w   Options_QueueStagedTileDMA
                addi.w  #$80,d0
                moveq   #3,d3
                bra.w   Options_QueueStagedTileDMA
; End of function Options_QueueThreeDigitBCD
; Expands a two-digit packed-BCD value into two tile rows and queues both DMAs
Options_QueueTwoDigitBCD:                               ; CODE XREF: UI_UpdateVoiceTest+88   j  ; was: sub_9FDA
                movea.w (VDPStagingDataCursor).w,a0
                move.b  d1,d2
                asr.b   #4,d1
                andi.w  #$F,d1
                andi.w  #$F,d2
                asl.w   #1,d1
                asl.w   #1,d2
                addi.w  #-$5CFE,d1
                addi.w  #-$5CFE,d2
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                addq.w  #1,d1
                addq.w  #1,d2
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                moveq   #2,d3
                bsr.w   Options_QueueStagedTileDMA
                addi.w  #$80,d0
                moveq   #2,d3
; End of function Options_QueueTwoDigitBCD
; Prepends one options-tile DMA command and advances the staging cursor
Options_QueueStagedTileDMA:                             ; CODE XREF: UI_UpdateBGMTest+86   p  ; was: sub_A00E
                                        ; UI_UpdateBGMTest+90   j
                movea.w (VDPCommandQueueHead).w,a1
                move.w  #$83,-(a1)
                move.w  d0,-(a1)
                move.b  (VDPStagingDataCursor).w,d1
                move.b  (VDPStagingDataCursor+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009300,-(a1)
                move.b  d3,3(a1)
                move.w  a1,(VDPCommandQueueHead).w
                asl.w   #1,d3
                add.w   d3,(VDPStagingDataCursor).w
                rts
; End of function Options_QueueStagedTileDMA
; Updates bit 2 of the selected option field, then queues both choice labels
Options_UpdateBit2Toggle:                               ; CODE XREF: UI_UpdateMessageOption+14   j  ; was: sub_A04C
                                        ; UI_UpdateSFXOption+14   j
                moveq   #2,d5
                bra.s   Options_ApplyToggleAndQueueLabels
; ---------------------------------------------------------------------------
Options_UpdateBit1Toggle:                               ; CODE XREF: UI_UpdateDifficultyOption+14   j  ; was: loc_A050
                                        ; UI_UpdateBGMOption+14   j
                moveq   #1,d5
Options_ApplyToggleAndQueueLabels:                      ; CODE XREF: Options_UpdateBit2Toggle+2   j  ; was: loc_A052
                btst    #2,(dword_FF806A).w
                beq.s   Options_CheckToggleRight
                bclr    d5,1(a4)
                bra.s   Options_ResetToggleRepeatDelay
; ---------------------------------------------------------------------------
Options_CheckToggleRight:                               ; CODE XREF: Options_UpdateBit2Toggle+C   j  ; was: loc_A060
                btst    #3,(dword_FF806A).w
                beq.s   Options_SelectToggleAttributes
                bset    d5,1(a4)
Options_ResetToggleRepeatDelay:                         ; CODE XREF: Options_UpdateBit2Toggle+12   j  ; was: loc_A06C
                move.w  #$A,(dword_FF8062+2).w
Options_SelectToggleAttributes:                         ; CODE XREF: Options_UpdateBit2Toggle+1A   j  ; was: loc_A072
                move.w  #$2000,d1
                move.w  #$4000,d2
                btst    d5,1(a4)
                beq.s   Options_BeginToggleLabelCopy
                move.w  #$2000,d2
                move.w  #$4000,d1
Options_BeginToggleLabelCopy:                           ; CODE XREF: Options_UpdateBit2Toggle+32   j  ; was: loc_A088
                movea.w (VDPStagingDataCursor).w,a0
                moveq   #0,d7
Options_CopyFirstToggleLabel:                           ; CODE XREF: Options_UpdateBit2Toggle+50   j  ; was: loc_A08E
                move.w  (a1)+,d0
                cmpi.w  #$FFFF,d0
                beq.s   Options_CopySecondToggleLabel
                add.w   d1,d0
                move.w  d0,(a0)+
                addq.w  #1,d7
                bra.s   Options_CopyFirstToggleLabel
; ---------------------------------------------------------------------------
Options_CopySecondToggleLabel:                          ; CODE XREF: Options_UpdateBit2Toggle+48   j  ; was: loc_A09E
                                        ; Options_UpdateBit2Toggle+60   j
                move.w  (a2)+,d0
                cmpi.w  #$FFFF,d0
                beq.s   Options_BeginToggleBottomRow
                add.w   d2,d0
                move.w  d0,(a0)+
                addq.w  #1,d7
                bra.s   Options_CopySecondToggleLabel
; ---------------------------------------------------------------------------
Options_BeginToggleBottomRow:                           ; CODE XREF: Options_UpdateBit2Toggle+58   j  ; was: loc_A0AE
                movea.w (VDPStagingDataCursor).w,a1
                move.w  d7,d3
Options_CopyToggleBottomRow:                            ; CODE XREF: Options_UpdateBit2Toggle+6E   j  ; was: loc_A0B4
                move.w  (a1)+,d0
                addq.w  #1,d0
                move.w  d0,(a0)+
                dbf     d3,Options_CopyToggleBottomRow
                move.w  d6,d0
                move.w  d7,d3
                bsr.w   Options_QueueStagedTileDMA
                addi.w  #$80,d6
                move.w  d6,d0
                move.w  d7,d3
                bra.w   Options_QueueStagedTileDMA
; End of function Options_UpdateBit2Toggle
; Moves the primary options cursor toward its selected row by two pixels
OptionsCursor_Animate:                                  ; CODE XREF: UI_HandleOptionsInput+A   j  ; was: sub_A0D2
                movea.l #Options_CursorYPositions,a0
                movea.w #(Entity_ObjectPool-M68K_RAM),a1
                move.w  (dword_FF8062).w,d0
                clr.w   d2
                move.w  (a0,d0.w),d1
                sub.w   $14(a1),d1
                bmi.s   OptionsCursor_CheckUpwardDelta
                cmpi.w  #2,d1
                bmi.s   OptionsCursor_SnapToTarget
                addq.w  #2,$14(a1)
                rts
; ---------------------------------------------------------------------------
OptionsCursor_CheckUpwardDelta:                         ; CODE XREF: OptionsCursor_Animate+18   j  ; was: loc_A0F8
                cmpi.w  #$FFFE,d1
                bmi.s   OptionsCursor_MoveUpTwoPixels
OptionsCursor_SnapToTarget:                             ; CODE XREF: OptionsCursor_Animate+1E   j  ; was: loc_A0FE
                move.w  (a0,d0.w),$14(a1)
                bclr    #0,(dword_FF805E+2).w
                rts
; ---------------------------------------------------------------------------
; Decrements cursor Y position by 2 pixels for upward navigation
OptionsCursor_MoveUpTwoPixels:                          ; CODE XREF: OptionsCursor_Animate+2A   j  ; was: loc_A10C
                subq.w  #2,$14(a1)
                rts
; End of function OptionsCursor_Animate
; ---------------------------------------------------------------------------
Options_CursorYPositions:   dc.w    $B3, $D3, $E3, $FB, $10B, $11B  ; was: word_A112
                                        ; DATA XREF: OptionsCursor_Animate   o

; Moves the secondary options cursor toward its selected row by two pixels
SecondaryOptionsCursor_Animate:                         ; CODE XREF: UI_HandleSecondaryOptionsInput+A   j  ; was: sub_A11E
                lea     SecondaryOptions_CursorYPositions(pc),a0
                nop
                movea.w #(Entity_ObjectPool-M68K_RAM),a1
                move.w  (dword_FF805E).w,d0
                clr.w   d2
                move.w  (a0,d0.w),d1
                sub.w   $14(a1),d1
                bmi.s   SecondaryOptionsCursor_CheckUpwardDelta
                cmpi.w  #2,d1
                bmi.s   SecondaryOptionsCursor_SnapToTarget
                addq.w  #2,$14(a1)
                rts
; ---------------------------------------------------------------------------
SecondaryOptionsCursor_CheckUpwardDelta:                ; CODE XREF: SecondaryOptionsCursor_Animate+18   j  ; was: loc_A144
                cmpi.w  #$FFFE,d1
                bmi.s   SecondaryOptionsCursor_MoveUpTwoPixels
SecondaryOptionsCursor_SnapToTarget:                    ; CODE XREF: SecondaryOptionsCursor_Animate+1E   j  ; was: loc_A14A
                move.w  (a0,d0.w),$14(a1)
                bclr    #0,(dword_FF805E+2).w
                rts
; ---------------------------------------------------------------------------
SecondaryOptionsCursor_MoveUpTwoPixels:                 ; CODE XREF: SecondaryOptionsCursor_Animate+2A   j  ; was: loc_A158
                subq.w  #2,$14(a1)
                rts
; End of function SecondaryOptionsCursor_Animate
; ---------------------------------------------------------------------------
SecondaryOptions_CursorYPositions:  dc.w    $CA, $DA, $EA, $FA, $10A  ; was: word_A15E
                                        ; DATA XREF: SecondaryOptionsCursor_Animate   o

; Advances the shared frontend cursor flash and writes its palette color
FrontendCursor_UpdateFlash:                             ; CODE XREF: UI_HandleOptionsInput   p  ; was: sub_A168
                                        ; sub_9EF6   p
                move.w  (dword_FF8062+2).w,d0
                beq.s   FrontendCursor_ApplyFlashColor
                subq.w  #2,d0
                move.w  d0,(dword_FF8062+2).w
FrontendCursor_ApplyFlashColor:                         ; CODE XREF: FrontendCursor_UpdateFlash+4   j  ; was: loc_A174
                andi.w  #$E,d0
                move.w  FrontendCursor_FlashColors(pc,d0.w),(word_FFE35C).w
                rts
; End of function FrontendCursor_UpdateFlash
; ---------------------------------------------------------------------------
FrontendCursor_FlashColors: dc.w    $200, $400, $620, $840, $A60, $C82, $EA4, $EC6  ; was: word_A180

; Alternates two frontend palette colors from the VBlank frame counter
Frontend_AnimateMenuPalette:                            ; CODE XREF: TitleScreen_Update+110   p  ; was: sub_A190
                                        ; sub_9774:UI_UpdateOptionsScreenFrame   p
                move.w  (VBlankFrameCounter).w,d1
                asl.w   #1,d1
                andi.w  #2,d1
                move.w  Frontend_MenuPaletteCycleColors(pc,d1.w),d0
                move.w  d0,(word_FFE376).w
                addq.w  #4,d1
                move.w  Frontend_MenuPaletteCycleColors(pc,d1.w),d0
                move.w  d0,(word_FFE37E).w
                rts
; End of function Frontend_AnimateMenuPalette
; ---------------------------------------------------------------------------
Frontend_MenuPaletteCycleColors:    dc.w    $E00, $E44, $4C4, $40  ; was: word_A1AE
Frontend_TitleAssetLoadDescriptors: dc.w    3           ; field_0  ; was: stru_A1B6
                                        ; DATA XREF: TitleScreen_Initialize+12   o
                                        ; Frontend_InitializeSegaScreen+1C   o
                dc.l    SharedTitleAndOptionsType3DataA  ; field_2
                dc.w    0                               ; field_6
                dc.w    3                               ; field_0
                dc.l    SharedTitleAndOptionsType3DataB  ; field_2
                dc.w    $2000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    FrontendTitleTileArt3000        ; field_2
                dc.w    $3000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    FrontendTitleMappingData6000    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    FrontendTitleMappingData4000    ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedFrontendAndTransitionMappingDataA  ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedFrontendAndTransitionMappingDataB  ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedFrontendAndTransitionMappingData7000  ; field_2
                dc.w    $7000                           ; field_6
                dc.w    $FFFF
Options_AssetLoadDescriptors:   dc.w    3               ; field_0  ; was: stru_A1F8
                                        ; DATA XREF: UI_InitOptionsScreen+C   o
                                        ; UI_InitSecondaryOptionsMenu+C   o
                dc.l    SharedTitleAndOptionsType3DataA  ; field_2
                dc.w    $2000                           ; field_6
                dc.w    3                               ; field_0
                dc.l    SharedTitleAndOptionsType3DataB  ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedFrontendAndTransitionMappingDataA  ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedFrontendAndTransitionMappingDataB  ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedFrontendAndTransitionMappingData7000  ; field_2
                dc.w    $7000                           ; field_6
Options_OnLabelTiles:   dc.w    $8332, $8330, $8300, $8300, $FFFF  ; was: word_A220
                                        ; DATA XREF: UI_UpdateMessageOption   o
                                        ; sub_9DA0   o
Options_OffLabelTiles:  dc.w    $8332, $8320, $8320, $FFFF  ; was: word_A22A
                                        ; DATA XREF: UI_UpdateMessageOption+6   o
                                        ; UI_UpdateBGMOption+6   o
Options_SuperEasyLabelTiles:    dc.w    $833A, $833E, $8334, $831E, $8338, $831E, $8316, $833A, $8346, $8300, $FFFF  ; was: word_A232
                                        ; DATA XREF: UI_UpdateDifficultyOption   o
Options_SuperHardLabelTiles:    dc.w    $833A, $833E, $8334, $831E, $8338, $8324, $8316, $8338, $831C, $FFFF  ; was: word_A248
                                        ; DATA XREF: UI_UpdateDifficultyOption+6   o
                dc.w    $8330, $8332, $8338, $832E, $8316, $832C, $8300, $FFFF, $831C, $8326
                dc.w    $8338, $831E, $831A, $833C, $831E, $8338, $831A, $833E, $833C, $FFFF
Options_VoiceTestRequestIDs:    dc.w    $1011, $1213, $1415, $1617, $1819, $1A1B, $1C1D, $1E1F, $2023, $2425  ; was: word_A284
                                        ; DATA XREF: UI_UpdateVoiceTest+8   o
                dc.w    $2628, $2A2B, $2C2D, $2E2F, $3031, $3233, $3536, $3738, $393A
Options_SFXTestLowRequestIDs:   dc.b    $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F  ; was: byte_A2AA
                                        ; DATA XREF: UI_UpdateSFXTest+8   o
                dc.b    $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
                dc.b    $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
                dc.b    $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
Options_SFXTestHighRequestIDs:  dc.b    $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF  ; was: byte_A2EA
                dc.b    $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
                dc.b    $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
                dc.b    $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
                dc.b    $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7, $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
                dc.b    $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $FB, $FC, $FF

; Initializes the shared options/password cursor object from caller parameters
FrontendCursor_Initialize:                              ; CODE XREF: UI_InitOptionsScreen+176   p  ; was: sub_A346
                                        ; UI_InitSecondaryOptionsMenu+AA   p
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$F8,(a0)
                move.w  #$CC00,2(a0)
                move.w  #0,$E(a0)
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,8(a0)
                rts
; End of function FrontendCursor_Initialize
; Type $F8 is the frontend cursor; its object update is intentionally a no-op
FrontendCursor_NoOpUpdate:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: nullsub_5
                rts
; End of function FrontendCursor_NoOpUpdate
; ---------------------------------------------------------------------------
FrontendCursor_SpriteMappings:  dc.w    $4101, $E00, $F400  ; DATA XREF: UI_InitOptionsScreen+170   o  ; was: word_A36A
                                        ; UI_InitSecondaryOptionsMenu+A4   o
                dc.w    $4101, $E00, $F420
                dc.w    $4101, $E00, $F440
                dc.w    $4101, $E00, $F460
                dc.w    $4101, $E00, $F4E0
                dc.w    $4101, $E00, $F4C0
                dc.w    $C101, $E00, $F4A0
