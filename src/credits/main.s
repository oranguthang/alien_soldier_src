Credits_InitXiTiger:                                    ; DATA XREF: Sys_DispatchGameState+E2   o  ; was: sub_20956
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                jsr     (Sys_InitGameMode).l
                jsr     (Gfx_QueueLargeFontDMACommand81).l
                movea.l #Credits_XiTigerAssetLoadList,a0
                jsr     (LoadObjData).l
                lea     (word_FF5000).l,a0
                move.w  #$FF,d7
Credits_InitXiTiger_ClearTileAttributesLoop:            ; CODE XREF: Credits_InitXiTiger+34   j  ; was: loc_20982
                move.w  (a0),d0
                andi.w  #$FEFF,d0
                move.w  d0,(a0)+
                dbf     d7,Credits_InitXiTiger_ClearTileAttributesLoop
                jsr     (Sys_ClearEntityObjectPool).l
                lea     (dword_FF5180).l,a0
                move.w  #$A000,d0
                move.w  #0,d1
                move.w  #2,d7
                jsr     (Gfx_UpdateTilemapIndices).l
                lea     (dword_FF6180).l,a0
                moveq   #0,d0
                move.w  #$1F,d1
Credits_InitXiTiger_ClearTilemapBufferLoop:             ; CODE XREF: Credits_InitXiTiger+64   j  ; was: loc_209B8
                move.l  d0,(a0)+
                dbf     d1,Credits_InitXiTiger_ClearTilemapBufferLoop
                move.l  #$81828300,(dword_FF6194).l
                move.l  #$85868700,(dword_FF619C).l
                move.l  #$898A8B00,(dword_FF61A4).l
                lea     (Gfx_DefaultVRAMTransferParameters).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                jsr     (Tilemap_TransferFullMapDirectToVRAM).l
                lea     (Gfx_ScrollVRAMTransferParameters).l,a0
                move.w  #$800,d0
                move.w  #0,d1
                jsr     (Tilemap_TransferFullMapDirectToVRAM).l
                lea     (CreditsAndPlanetPaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.w  #$EA8,(word_FFE3A8).w
                move.w  #$E86,(word_FFE3AA).w
                move.w  #$E64,(word_FFE3AC).w
                move.b  #6,(VDPReg11Shadow+1).w
                move.b  #3,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                clr.l   (EndingScrollPhase).l
                move.l  #$1000,(EndingScrollRate).l
                move.l  #$FFF80000,d0
                lea     (HScrollBuffer).w,a0
                move.w  #$1B,d7
Credits_InitXiTiger_InitHorizontalScrollLoop:           ; CODE XREF: Credits_InitXiTiger+102   j  ; was: loc_20A52
                move.l  d0,(a0)
                adda.w  #$20,a0                         ; ' '
                dbf     d7,Credits_InitXiTiger_InitHorizontalScrollLoop
                lea     (VScrollBuffer).w,a0
                move.w  #$13,d7
Credits_InitXiTiger_InitVerticalScrollLoop:             ; CODE XREF: Credits_InitXiTiger+110   j  ; was: loc_20A64
                move.l  d0,(a0)+
                dbf     d7,Credits_InitXiTiger_InitVerticalScrollLoop
                lea     (word_FFC680).w,a5
                move.w  #$CC00,word_FFC682-word_FFC680(a5)
                move.w  #$10,(a5)
                move.l  #Credits_XiTigerSpriteFrames,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$90,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5)                    ; '`'
                lea     (word_FFC6E0).w,a5
                move.w  #$CC00,word_FFC6E2-word_FFC6E0(a5)
                move.w  #$10,(a5)
                move.l  #Credits_XiTigerSpriteFrames,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$1B0,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5)                    ; '`'
                clr.w   (word_FFE306).w
                clr.w   (word_FFE386).w
                move.w  #$FFF2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (PaletteActiveBuffer).w,a0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.b  #0,(VDPReg18Shadow+1).w
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA90C).w
                clr.w   (dword_FFA908).w
                jsr     (Scroll_PreparePlaneBuffersAndRegisterShadows).l
                move.w  (SoundDisableFlags).w,(word_FFFF60).w
                move.w  #0,(SoundDisableFlags).w
                move.b  #$90,d0
                jsr     (Sound_QueueBGMRequest).l
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                clr.w   (FrameCounter).w
                rts
; End of function Credits_InitXiTiger
; ---------------------------------------------------------------------------
Credits_XiTigerAssetLoadList:   dc.w    7               ; field_0  ; was: stru_20B4A
                                        ; DATA XREF: Credits_InitXiTiger+16   o
                dc.l    CreditsAndEndingTileArt         ; field_2
                dc.w    $4000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedCreditsTileArtB000        ; field_2
                dc.w    $B000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedCreditsResultsMappingData4020  ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedCreditsResultsMappingData6000  ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7000                           ; field_6
                dc.w    $FFFF

; Main loop for credits sequence processing objects and graphics
Credits_MainLoop:                                       ; DATA XREF: Sys_DispatchGameState+E6   o  ; was: sub_20B74
                jsr     (Object_ApplyCameraMotion).l
                jsr     (Sprite_InitializePriorityBuckets).l
                jsr     (Sys_BeginVisibleObjectList).l
                jsr     (Sys_ProcessVisibleObjects).l
                bsr.w   Credits_StateDispatcher
                jsr     (Sys_UpdateObjectCount).l
                jsr     (Sprite_RenderObjectList).l
                jsr     (Gfx_FadePaletteTransition).l
                jsr     (Scroll_PreparePlaneBuffersAndRegisterShadows).l
                addq.w  #1,(FrameCounter).w
                rts
; End of function Credits_MainLoop
; Dispatches to current credits state handler based on state index
Credits_StateDispatcher:                                ; CODE XREF: Credits_MainLoop+18   p  ; was: sub_20BAE
                subq.w  #1,(word_FF0188).l
                move.w  (GameSubstateIndex).w,d0
                lea     Credits_StateHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Credits_StateDispatcher
; ---------------------------------------------------------------------------
Credits_StateHandlers:  dc.w    Credits_FadeInState-*   ; DATA XREF: Credits_StateDispatcher+A   o  ; was: off_20BC0
                dc.w    Credits_ScrollWithColorCycle-*
                dc.w    Credits_WaitForTimerEnd-*
                dc.w    Credits_FadeOutAndClearVRAM-*
                dc.w    Credits_FadeInFromBlack-*
                dc.w    Credits_WaitForScrollEnd-*
                dc.w    Credits_FadeOutAndExit-*

; Handles fade-in transition at start of credits sequence
Credits_FadeInState:                                    ; DATA XREF: ROM:Credits_StateHandlers   o  ; was: sub_20BCE
                jsr     Credits_UpdateScrollTables(pc)  ; (pc)
                nop
                move.w  (FrameCounter).w,d0
                cmpi.w  #$80,d0
                bcs.w   Credits_StateReturn
                andi.w  #$F,d0
                bne.w   Credits_StateReturn
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (PaletteActiveBuffer).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   Credits_StateReturn
                move.w  #$FFF0,(word_FF0176).l
                clr.w   (SharedSequenceState).l
                clr.w   (word_FF017C).l
                move.w  #$4D80,(word_FF0188).l
                addq.w  #2,(GameSubstateIndex).w
Credits_StateReturn:                                    ; CODE XREF: Credits_FadeInState+E   j  ; was: locret_20C30
                                        ; Credits_FadeInState+16   j
                rts
; End of function Credits_FadeInState
; Scrolls credits text with color cycling palette effect
Credits_ScrollWithColorCycle:                           ; DATA XREF: ROM:00020BC2   o  ; was: sub_20C32
                jsr     (CreditsGlyphSequence_Dispatch).l
                bsr.w   Credits_HandleXiTigerMusicCues
                jsr     Credits_UpdateScrollTables(pc)  ; (pc)
                nop
                bsr.w   Credits_CyclePaletteColors
                move.w  (FrameCounter).w,d0
                cmpi.w  #$11C0,d0
                bcs.w   Credits_StateReturn
                andi.w  #$F,d0
                bne.w   Credits_StateReturn
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE360).w,a0
                move.w  #$F,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   Credits_StateReturn
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_ScrollWithColorCycle
; Waits for timer to reach specific value before advancing state
Credits_WaitForTimerEnd:                                ; DATA XREF: ROM:00020BC4   o  ; was: sub_20C88
                jsr     (CreditsGlyphSequence_Dispatch).l
                bsr.w   Credits_HandleXiTigerMusicCues
                jsr     Credits_UpdateScrollTables(pc)  ; (pc)
                nop
                bsr.w   Credits_CyclePaletteColors
                cmpi.w  #$3000,(word_FF0188).l
                bne.w   Credits_StateReturn
                move.w  #0,(word_FF0176).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_WaitForTimerEnd
; Cycles RGB color values in palette entries with XOR operation
Credits_CyclePaletteColors:                             ; CODE XREF: Credits_ScrollWithColorCycle+10   p  ; was: sub_20CB6
                                        ; Credits_WaitForTimerEnd+10   p
                eori.w  #$22E,(word_FFE328).w
                eori.w  #$2E2,(word_FFE32A).w
                eori.w  #$226,(word_FFE32C).w
                rts
; End of function Credits_CyclePaletteColors
; Updates horizontal scroll tables with 3D rotation effect
Credits_UpdateScrollTables:                             ; CODE XREF: Credits_FadeInState   p  ; was: sub_20CCA
                                        ; Credits_ScrollWithColorCycle+A   p
                move.l  (EndingScrollRate).l,d0
                add.l   d0,(EndingScrollPhase).l
                move.l  (EndingScrollPhase).l,d1
                move.l  d1,d3
                asr.l   #2,d3
                move.l  d1,d0
                asr.l   #1,d0
                neg.l   d0
                lea     (word_FFE5C2).w,a0
                move.w  #$D,d7
Credits_UpdateScrollTables_UpperForwardLoop:            ; CODE XREF: Credits_UpdateScrollTables+32   j  ; was: loc_20CEE
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #$20,a0                         ; ' '
                dbf     d7,Credits_UpdateScrollTables_UpperForwardLoop
                move.l  (EndingScrollPhase).l,d1
                move.l  d1,d0
                asr.l   #1,d0
                lea     (word_FFE5A2).w,a0
                move.w  #$D,d7
Credits_UpdateScrollTables_UpperReverseLoop:            ; CODE XREF: Credits_UpdateScrollTables+56   j  ; was: loc_20D12
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #$20,a0                         ; ' '
                dbf     d7,Credits_UpdateScrollTables_UpperReverseLoop
                move.l  (EndingScrollPhase).l,d1
                move.l  d1,d3
                asr.l   #1,d3
                move.l  d1,d0
                neg.l   d0
                asl.l   #1,d1
                lea     (word_FFEC2A).w,a0
                move.w  #9,d7
Credits_UpdateScrollTables_LowerForwardLoop:            ; CODE XREF: Credits_UpdateScrollTables+80   j  ; was: loc_20D3C
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #4,a0
                dbf     d7,Credits_UpdateScrollTables_LowerForwardLoop
                move.l  (EndingScrollPhase).l,d1
                move.l  d1,d0
                asl.l   #1,d1
                lea     (word_FFEC26).w,a0
                move.w  #9,d7
Credits_UpdateScrollTables_LowerReverseLoop:            ; CODE XREF: Credits_UpdateScrollTables+A4   j  ; was: loc_20D60
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #4,a0
                dbf     d7,Credits_UpdateScrollTables_LowerReverseLoop
                rts
; End of function Credits_UpdateScrollTables
; Fades out palette and clears VRAM plane data
Credits_FadeOutAndClearVRAM:                            ; DATA XREF: ROM:00020BC6   o  ; was: sub_20D74
                jsr     (CreditsGlyphSequence_Dispatch).l
                bsr.w   Credits_HandleXiTigerMusicCues
                jsr     Credits_UpdateScrollTables(pc)  ; (pc)
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.w   Credits_StateReturn
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   Credits_StateReturn
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
Credits_FadeOutAndClearVRAM_PlaneALoop:                 ; CODE XREF: Credits_FadeOutAndClearVRAM+6C   j  ; was: loc_20DDE
                move.w  d1,(a0)
                dbf     d0,Credits_FadeOutAndClearVRAM_PlaneALoop
                move    (sp)+,sr
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$60000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
Credits_FadeOutAndClearVRAM_PlaneBLoop:                 ; CODE XREF: Credits_FadeOutAndClearVRAM+9A   j  ; was: loc_20E0C
                move.w  d1,(a0)
                dbf     d0,Credits_FadeOutAndClearVRAM_PlaneBLoop
                move    (sp)+,sr
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_FadeOutAndClearVRAM
; Fades palette from black to normal colors
Credits_FadeInFromBlack:                                ; DATA XREF: ROM:00020BC8   o  ; was: sub_20E1A
                jsr     (CreditsGlyphSequence_Dispatch).l
                bsr.w   Credits_HandleXiTigerMusicCues
                move.w  (FrameCounter).w,d0
                andi.w  #3,d0
                bne.w   Credits_StateReturn
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   Credits_StateReturn
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_FadeInFromBlack
; Waits for scroll sequence to complete before advancing
Credits_WaitForScrollEnd:                               ; DATA XREF: ROM:00020BCA   o  ; was: sub_20E5E
                jsr     (CreditsGlyphSequence_Dispatch).l
                bsr.w   Credits_HandleXiTigerMusicCues
                bsr.w   Credits_ScrollStateDispatcher
                tst.w   (word_FF0188).l
                bne.w   Credits_StateReturn
                move.w  #0,(word_FF0176).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_WaitForScrollEnd
; Fades out and returns to title screen mode
Credits_FadeOutAndExit:                                 ; DATA XREF: ROM:00020BCC   o  ; was: sub_20E84
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (PaletteActiveBuffer).w,a0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   Credits_StateReturn
                move.w  #1,(word_FFFF46).w
                move.w  (word_FFFF60).w,(SoundDisableFlags).w
                jsr     (Sys_ClearEntityObjectPool).l
                move.w  #$84,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; End of function Credits_FadeOutAndExit
; Queue the Xi-Tiger credits music cues at their three scroll milestones
Credits_HandleXiTigerMusicCues:                         ; CODE XREF: Credits_ScrollWithColorCycle+6   p  ; was: sub_20ECC
                                        ; Credits_WaitForTimerEnd+6   p
                cmpi.w  #$1F40,(word_FF0188).l
                beq.s   Credits_QueueXiTigerMusicFadeOut
                cmpi.w  #$1EC0,(word_FF0188).l
                beq.s   Credits_QueueXiTigerBGM94
                cmpi.w  #$A0,(word_FF0188).l
                beq.s   Credits_QueueXiTigerMusicFadeOut
                rts
; ---------------------------------------------------------------------------
Credits_QueueXiTigerMusicFadeOut:                       ; CODE XREF: Credits_HandleXiTigerMusicCues+8   j  ; was: loc_20EEC
                                        ; Credits_HandleXiTigerMusicCues+1C   j
                move.b  #1,d0
                jmp     (Sound_QueueBGMRequest).l
; ---------------------------------------------------------------------------
Credits_QueueXiTigerBGM94:                              ; CODE XREF: Credits_HandleXiTigerMusicCues+12   j  ; was: loc_20EF6
                move.b  #$94,d0
                jmp     (Sound_QueueBGMRequest).l
; End of function Credits_HandleXiTigerMusicCues
; Dispatches to scroll sequence state handler
Credits_ScrollStateDispatcher:                          ; CODE XREF: Credits_WaitForScrollEnd+A   p  ; was: sub_20F00
                move.w  (word_FF017C).l,d0
                lea     Credits_SceneStateHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Credits_ScrollStateDispatcher
; ---------------------------------------------------------------------------
Credits_SceneStateHandlers: dc.w    Credits_InitializeSceneSequence-*  ; DATA XREF: Credits_ScrollStateDispatcher+6   o  ; was: off_20F0E
                dc.w    Credits_LoadNextScene-*
                dc.w    Credits_WaitForSceneActivation-*
                dc.w    Credits_UpdateScene-*
                dc.w    Credits_PrepareSpecialScenePalette-*
                dc.w    Credits_LoadTreasureScene-*
                dc.w    Credits_WaitForSpecialSceneActivation-*
                dc.w    Credits_FadeInSpecialScene-*
                dc.w    Credits_PrepareSpecialScenePalette-*
                dc.w    Credits_LoadSegaScene-*
                dc.w    Credits_WaitForSpecialSceneActivation-*
                dc.w    Credits_FadeInSpecialScene-*
                dc.w    Credits_SceneStateIdle-*

; Initialize credits screen with sprite objects and palette data
Credits_InitializeSceneSequence:                        ; DATA XREF: ROM:Credits_SceneStateHandlers   o  ; was: sub_20F28
                clr.w   (word_FF017E).l
                lea     Credits_InitialAssetLoadList(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                lea     Credits_InitialPalette(pc),a0
                nop
                lea     (word_FFE340).w,a1
                bsr.w   Data_Copy32Bytes
                lea     (word_FFC680).w,a5
                move.w  #$CC00,word_FFC682-word_FFC680(a5)
                move.w  #$10,(a5)
                move.l  #Credits_XiTigerSpriteFrames,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$90,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5)                    ; '`'
                lea     (word_FFC6E0).w,a5
                move.w  #$CC00,word_FFC6E2-word_FFC6E0(a5)
                move.w  #$10,(a5)
                move.l  #Credits_XiTigerSpriteFrames,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$1B0,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5)                    ; '`'
                clr.w   (word_FFE306).w
                move.b  #3,(VDPReg11Shadow+1).w
                move.b  #1,(byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                lea     (HScrollBuffer).w,a0
                move.l  #$7F008000,d1
                move.w  #$EF,d0
Credits_InitializeSceneSequence_FillPaletteBufferLoop:  ; CODE XREF: Credits_InitializeSceneSequence+B2   j  ; was: loc_20FD8
                move.l  d1,(a0)+
                dbf     d0,Credits_InitializeSceneSequence_FillPaletteBufferLoop
                move.w  #$AA,(word_FF018E).l
                move.l  #Credits_SceneDataPointers,(dword_FF018A).l
                move.l  #$FFFFE320,(dword_FF0190).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_InitializeSceneSequence
; Load next phase of credits data and process pointer
Credits_LoadNextScene:                                  ; DATA XREF: ROM:00020F10   o  ; was: sub_21002
                subq.w  #1,(word_FF018E).l
                bne.w   Credits_StateReturn
                movea.l (dword_FF018A).l,a2
                movea.l (a2)+,a0
                movea.l (dword_FF0190).l,a1
                bsr.w   Data_Copy32Bytes
                movea.l (a2)+,a0
                jsr     (Data_ProcessPointer).l
                move.w  #$160,(word_FF018E).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_LoadNextScene
; Wait for timer and check player input to advance
Credits_WaitForSceneActivation:                         ; DATA XREF: ROM:00020F12   o  ; was: sub_21036
                subq.w  #1,(word_FF018E).l
                tst.w   (word_FFF720).w
                bmi.w   Credits_StateReturn
                clr.w   (word_FF0194).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_WaitForSceneActivation
; Main credits update loop with data cycling
Credits_UpdateScene:                                    ; DATA XREF: ROM:00020F14   o  ; was: sub_21052
                bsr.w   Gfx_FadeInPaletteEntry
                bsr.w   Gfx_FadeAllPaletteEntries
                subq.w  #1,(word_FF018E).l
                bne.w   Credits_StateReturn
                move.w  #$AA,(word_FF018E).l
                move.w  #2,(word_FF017C).l
                addq.l  #8,(dword_FF018A).l
                eori.l  #$40,(dword_FF0190).l           ; '@'
                movea.l (dword_FF018A).l,a2
                tst.l   (a2)
                bpl.w   Credits_StateReturn
                move.w  #$1A0,(word_FF018E).l
                move.w  #8,(word_FF017C).l
                rts
; End of function Credits_UpdateScene
; Fade in single palette entry by modifying color value
Gfx_FadeInPaletteEntry:                                 ; CODE XREF: Credits_UpdateScene   p  ; was: sub_210A2
                move.w  (word_FF0194).l,d0
                cmpi.w  #$1E0,d0
                bcc.w   Credits_StateReturn
                addq.w  #2,(word_FF0194).l
                move.w  Credits_PaletteFadeOrder(pc,d0.w),d1
                lea     (HScrollBuffer).w,a0
                move.l  (a0,d1.w),d2
                subi.l  #$7FFF8,d2
                move.l  d2,(a0,d1.w)
                rts
; End of function Gfx_FadeInPaletteEntry
; ---------------------------------------------------------------------------
Credits_PaletteFadeOrder:   binclude "data/other/word_210CE.bin"  ; was: word_210CE
Credits_PaletteFadeOrder_End:                           ; was: word_210CE_End

; Fade all palette entries in buffer
Gfx_FadeAllPaletteEntries:                              ; CODE XREF: Credits_UpdateScene+4   p  ; was: sub_212AE
                lea     (HScrollBuffer).w,a0
                move.l  #$7FFF8,d1
                move.w  #$EF,d0
Credits_FadeAllPaletteEntries_Loop:                     ; CODE XREF: Gfx_FadeAllPaletteEntries+20   j  ; was: loc_212BC
                move.l  (a0),d2
                andi.l  #$FF00FF,d2
                beq.s   Credits_FadeAllPaletteEntries_Next
                move.l  (a0),d2
                sub.l   d1,d2
                move.l  d2,(a0)
Credits_FadeAllPaletteEntries_Next:                     ; CODE XREF: Gfx_FadeAllPaletteEntries+16   j  ; was: loc_212CC
                addq.l  #4,a0
                dbf     d0,Credits_FadeAllPaletteEntries_Loop
                rts
; End of function Gfx_FadeAllPaletteEntries
; Copies the staged palette before loading a special credits scene
Credits_PrepareSpecialScenePalette:                     ; DATA XREF: ROM:00020F16   o  ; was: sub_212D4
                                        ; ROM:00020F1E   o
                subq.w  #1,(word_FF018E).l
                bne.w   Credits_StateReturn
                move.w  #$160,(word_FF018E).l
                move.w  #0,(word_FF0176).l
                lea     (word_FFE320).w,a0
                lea     (dword_FFE3A0).w,a1
                bsr.w   Data_Copy32Bytes
                bsr.w   Data_Copy32Bytes
                bsr.w   Data_Copy32Bytes
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_PrepareSpecialScenePalette
; Fades out the rolling credits and loads the treasure scene
Credits_LoadTreasureScene:                              ; DATA XREF: ROM:00020F18   o  ; was: sub_2130A
                subq.w  #1,(word_FF018E).l
                move.w  (FrameCounter).w,d0
                andi.w  #3,d0
                bne.w   Credits_StateReturn
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   Credits_StateReturn
                clr.w   (word_FFC680).w
                clr.w   (word_FFC6E0).w
                move.b  #0,(VDPReg11Shadow+1).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA908).w
                move.b  #4,(byte_FFA95A).w
                move.b  #4,(byte_FFA95B).w
                lea     Credits_TreasurePaletteData(pc),a0
                nop
                lea     (dword_FFE3A0).w,a1
                bsr.w   Data_Copy32Bytes
                bsr.w   Data_Copy32Bytes
                bsr.w   Data_Copy32Bytes
                lea     Credits_TreasureAssetLoadList(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                move.w  #$220,(word_FF018E).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_LoadTreasureScene
; Waits until the special-scene state may advance
Credits_WaitForSpecialSceneActivation:                  ; DATA XREF: ROM:00020F1A   o  ; was: sub_2139A
                                        ; ROM:00020F22   o
                subq.w  #1,(word_FF018E).l
                tst.w   (word_FFF720).w
                bmi.w   Credits_StateReturn
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_WaitForSpecialSceneActivation
; Fades a newly loaded special scene in from black
Credits_FadeInSpecialScene:                             ; DATA XREF: ROM:00020F1C   o  ; was: sub_213B0
                                        ; ROM:00020F24   o
                subq.w  #1,(word_FF018E).l
                move.w  (FrameCounter).w,d0
                andi.w  #3,d0
                bne.w   Credits_StateReturn
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   Credits_StateReturn
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_FadeInSpecialScene
; Fades out the treasure scene and loads the SEGA presentation
Credits_LoadSegaScene:                                  ; DATA XREF: ROM:00020F20   o  ; was: sub_213F2
                subq.w  #1,(word_FF018E).l
                move.w  (FrameCounter).w,d0
                andi.w  #3,d0
                bne.w   Credits_StateReturn
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   Credits_StateReturn
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
Credits_LoadSegaScene_ClearPlaneALoop:                  ; CODE XREF: Credits_LoadSegaScene+64   j  ; was: loc_21454
                move.w  d1,(a0)
                dbf     d0,Credits_LoadSegaScene_ClearPlaneALoop
                move    (sp)+,sr
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$60000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
Credits_LoadSegaScene_ClearPlaneBLoop:                  ; CODE XREF: Credits_LoadSegaScene+92   j  ; was: loc_21482
                move.w  d1,(a0)
                dbf     d0,Credits_LoadSegaScene_ClearPlaneBLoop
                move    (sp)+,sr
                lea     Credits_SegaPalette(pc),a0
                nop
                lea     ((dword_FFE3DE+2)).w,a1
                bsr.w   Data_Copy32Bytes
                lea     Credits_SegaAssetLoadList(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                move.w  #$1E0,(word_FF018E).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_LoadSegaScene
Credits_SceneStateIdle:                                 ; DATA XREF: ROM:00020F26   o  ; was: nullsub_54
                rts
; End of function Credits_SceneStateIdle

; Copy 32 bytes (8 longwords) from source to destination
