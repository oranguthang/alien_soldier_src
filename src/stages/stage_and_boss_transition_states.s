; Dispatches the current stage-transition state
Stage_DispatchTransitionState:                          ; DATA XREF: ROM:0000FF42   o  ; was: sub_F0F0
                movea.w Stage_TransitionStateOffsets(pc,d0.w),a0
                adda.l  #StageTransition_InitializeAsteroidField,a0
                jmp     (a0)
; End of function Stage_DispatchTransitionState
; ---------------------------------------------------------------------------
Stage_TransitionStateOffsets:   dc.w    StageTransition_InitializeAsteroidField-StageTransition_InitializeAsteroidField  ; was: off_F0FC
                dc.w    StageTransition_UpdateAsteroidFieldEntry-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_StartAsteroidFieldScroll-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_FinishAsteroidFieldScroll-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_LoadDestroyerProtoAssets-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_InitializeDestroyerProtoBackdrop-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_UpdateDestroyerProtoBackdropFade-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_UpdatePostDestroyerProtoScroll-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_WaitForShieldViperEntry-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_LoadShieldViperAssets-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_UpdateShieldViperBackdrop-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_BeginShieldViperFade-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_CompleteShieldViperFade-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_WaitForShieldViperVramTransfer-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_WaitForShieldViperExit-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_UpdateWolfGaropaApproach-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_UpdateWolfGaropaBackdropApproach-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_RenderWolfGaropaBackdrop-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_FinalizeWolfGaropaBackdrop-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_AdvanceAfterWolfGaropaBackdrop-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_LoadWolfGaropaAssets-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_WaitForWolfGaropaObjectClear-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_RestartDestroyerProtoBackdrop-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_RestartWolfGaropaBackdropFinalize-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_WaitForWolfGaropaTransitionTrigger-StageTransition_InitializeAsteroidField
                dc.w    StageTransition_UpdateWolfGaropaScroll-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Stage24_Init-StageTransition_InitializeAsteroidField
                dc.w    Stage24_InitLoop-StageTransition_InitializeAsteroidField
                dc.w    Boss_MissirayTransition-StageTransition_InitializeAsteroidField
                dc.w    Boss_MissirayInit-StageTransition_InitializeAsteroidField
                dc.w    Boss_MissirayPaletteUpdate-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Stage24_InitCutscene-StageTransition_InitializeAsteroidField
                dc.w    Camera_ScrollAccelerate-StageTransition_InitializeAsteroidField
                dc.w    Scroll_ClampVerticalPos-StageTransition_InitializeAsteroidField
                dc.w    Stage_CheckPhaseComplete-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Stage_IncrementPhase-StageTransition_InitializeAsteroidField
                dc.w    Stage_IncrementPhase_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Stage25_TransitionInit-StageTransition_InitializeAsteroidField
                dc.w    Stage25_TransitionLoop-StageTransition_InitializeAsteroidField
                dc.w    Boss_ZLeoTransition-StageTransition_InitializeAsteroidField
                dc.w    Stage_CheckTransitionTrigger-StageTransition_InitializeAsteroidField
                dc.w    Stage_Stage25CameraUpdate-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Stage_SetStage25ScrollTimer-StageTransition_InitializeAsteroidField
                dc.w    Gfx_UpdateScrollWrapper-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField
                dc.w    Boss_DestroyerProtoTransition_Return-StageTransition_InitializeAsteroidField

; Transition graphics handler
StageTransition_InitializeAsteroidField:                ; DATA XREF: Stage_DispatchTransitionState+4   o  ; was: sub_F19A
                                        ; ROM:Stage_TransitionStateOffsets   o
                addq.w  #2,(word_FFA950).w
                move.b  #$80,(byte_FFA958).w
                clr.l   (dword_FFA964).w
                clr.w   (word_FFA968).w
                clr.b   (byte_FFA96A).w
                move.l  #$10000,(dword_FF8062).w
                move.l  #$10000,(dword_FFA960).w
                move.l  #$7000,(dword_FF9D9E).w
                move.l  #$C000,(dword_FF9DA2).w
                move.b  #3,(VDPReg11Shadow+1).w
                move.b  #1,(byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.w  #$3AC,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
; Handles graphics transition with scroll updates
StageTransition_UpdateAsteroidFieldEntry:               ; DATA XREF: ROM:0000F0FE   o  ; was: loc_F1EC
                bsr.w   Stage_ScrollUpdate2
                bsr.w   Stage_ScrollUpdate3
                subi.l  #$100,(dword_FF8062).w
                subi.l  #$80,(dword_FFA960).w
                cmpi.w  #$FFFC,(dword_FFA960).w
                bpl.w   Stage_ScrollUpdate1
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                rts
; End of function StageTransition_InitializeAsteroidField
; Transition to asteroids
StageTransition_StartAsteroidFieldScroll:               ; DATA XREF: ROM:0000F100   o  ; was: sub_F218
                bsr.w   Stage_ScrollUpdate2
                bsr.w   Stage_ScrollUpdate3
                tst.b   (byte_FFA96A).w
                beq.w   Stage_ScrollUpdate1
                addq.w  #2,(word_FFA950).w
                move.b  #$40,(byte_FFA958).w            ; '@'
                andi.w  #$FF,(dword_FFA904).w
                addi.w  #-$900,(dword_FFA904).w
                bra.w   Stage_AsteroidsGraphicsUpdate
; End of function StageTransition_StartAsteroidFieldScroll
; Asteroids scroll handler
StageTransition_FinishAsteroidFieldScroll:              ; DATA XREF: ROM:0000F102   o  ; was: sub_F242
                bsr.w   Stage_ScrollUpdate2
                bsr.w   Stage_ScrollUpdate3
                cmpi.w  #$F600,(dword_FFA904).w
                bpl.w   Stage_AsteroidsGraphicsUpdate
                move.w  #$8000,(word_FF808A).w
                move.b  #$80,(byte_FFA958).w
                move.w  #$80,(word_FF9DB0).w
                jmp     Stage_TransitionToNextPhase
; End of function StageTransition_FinishAsteroidFieldScroll
; Transition to boss
StageTransition_LoadDestroyerProtoAssets:               ; DATA XREF: ROM:0000F104   o  ; was: sub_F26C
                bsr.w   Stage_ScrollUpdate3
                subq.w  #1,(word_FF9DB0).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                lea     (Boss_DestroyerProtoAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function StageTransition_LoadDestroyerProtoAssets
; Initializes the Destroyer Proto transition backdrop
StageTransition_InitializeDestroyerProtoBackdrop:       ; DATA XREF: ROM:0000F106   o  ; was: sub_F288
                bsr.w   Stage_ScrollUpdate3
                tst.w   (Entity_ObjectPool).w
                bne.w   Boss_DestroyerProtoTransition_Return
                move.w  #$1C,(word_FF9DAE).w
                bsr.w   Boss_DestroyerProtoPaletteInit
                jsr     (UI_InitScoreTimer).l
                lea     (DestroyerProtoIntroPaletteCommands).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
StageTransition_ConfigureDestroyerProtoBackdrop:        ; CODE XREF: StageTransition_RestartDestroyerProtoBackdrop+14   j  ; was: loc_F2B0
                clr.b   (byte_FFA958).w
                move.w  #$50,(RasterEffectIndex).w      ; 'P'
                clr.w   (RasterEffectInitState).w
                move.w  #$16,(word_FF8090).w
                move.w  #$60,(word_FF9D94).w            ; '`'
                move.l  #$4000,(dword_FF9D9E).w
                move.l  #$8000,(dword_FF9DA2).w
                move.l  #$2000000,(dword_FF9DAA).w
                move.l  #$1E80000,(dword_FF9DB2).w
                move.l  #Gfx_DefaultVRAMTransferParameters,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$F500,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                rts
; End of function StageTransition_InitializeDestroyerProtoBackdrop
; Restarts the Destroyer Proto transition backdrop
StageTransition_RestartDestroyerProtoBackdrop:          ; DATA XREF: ROM:0000F128   o  ; was: sub_F304
                move.w  #$C,(word_FFA950).w
                clr.w   (MessageSequenceState).w
                clr.w   (word_FF9DAE).w
                move.b  #3,(VDPReg11Shadow+1).w
                bra.w   StageTransition_ConfigureDestroyerProtoBackdrop
; End of function StageTransition_RestartDestroyerProtoBackdrop
; Updates the Destroyer Proto backdrop fade
StageTransition_UpdateDestroyerProtoBackdropFade:       ; DATA XREF: ROM:0000F108   o  ; was: sub_F31C
                move.l  #$2000000,(dword_FF9DAA).w
                bsr.w   Boss_DestroyerProtoPaletteInit
                bsr.w   loc_FBD8
                bsr.w   Boss_DestroyerProtoRenderSegments
                tst.w   (word_FFA944).w
                bmi.s   StageTransition_CompleteDestroyerProtoBackdropFade
                jsr     (Gfx_RenderScrollingBackground).l
                bra.s   StageTransition_DestroyerProtoBackdropFadeReturn
; ---------------------------------------------------------------------------
StageTransition_CompleteDestroyerProtoBackdropFade:     ; CODE XREF: StageTransition_UpdateDestroyerProtoBackdropFade+18   j  ; was: loc_F33E
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                clr.w   (word_FF820C).w
                clr.b   (byte_FFA209).w
StageTransition_DestroyerProtoBackdropFadeReturn:       ; CODE XREF: StageTransition_UpdateDestroyerProtoBackdropFade+20   j  ; was: locret_F34E
                rts
; End of function StageTransition_UpdateDestroyerProtoBackdropFade
; Updates the post-Destroyer Proto scroll transition
StageTransition_UpdatePostDestroyerProtoScroll:         ; DATA XREF: ROM:0000F10A   o  ; was: sub_F350
                bsr.w   Boss_DestroyerProtoPaletteInit
                bsr.w   loc_FBD8
                bsr.w   Boss_DestroyerProtoRenderSegments
                move.w  (dword_FF9DAA).w,d0
                addi.w  #$60,d0                         ; '`'
                move.w  d0,(dword_FF9D90).w
                tst.b   (byte_FFA958).w
                bne.s   StageTransition_AdvancePostDestroyerProtoScroll
                moveq   #0,d7
                cmpi.l  #$FFFF8000,(dword_FF9D9E).w
                beq.s   StageTransition_CheckPostDestroyerProtoSecondarySpeed
                subi.l  #$80,(dword_FF9D9E).w
                addq.w  #1,d7
StageTransition_CheckPostDestroyerProtoSecondarySpeed:  ; CODE XREF: StageTransition_UpdatePostDestroyerProtoScroll+28   j  ; was: loc_F384
                cmpi.l  #$FFFF8000,(dword_FF9DA2).w
                beq.s   StageTransition_CheckPostDestroyerProtoSpeedsComplete
                subi.l  #$80,(dword_FF9DA2).w
                addq.w  #1,d7
StageTransition_CheckPostDestroyerProtoSpeedsComplete:  ; CODE XREF: StageTransition_UpdatePostDestroyerProtoScroll+3C   j  ; was: loc_F398
                tst.w   d7
                bne.s   StageTransition_PostDestroyerProtoScrollReturn
                move.b  #1,(byte_FFA958).w
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                move.w  #$2A,(StageTableIndex).w        ; '*'
                move.w  #$166,(dword_FF9D96).w
                move.l  #$2000000,(dword_FF9DAA).w
                move.w  #$3C8,(word_FFDB20).w
StageTransition_AdvancePostDestroyerProtoScroll:        ; CODE XREF: StageTransition_UpdatePostDestroyerProtoScroll+1C   j  ; was: loc_F3C2
                addi.l  #$10,(dword_FF9DA2).w
                tst.w   (dword_FF9DAA).w
                bne.s   StageTransition_PostDestroyerProtoScrollReturn
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FF9DA2).w
                move.w  #$E0,(dword_FFA904).w
StageTransition_PostDestroyerProtoScrollReturn:         ; CODE XREF: StageTransition_UpdatePostDestroyerProtoScroll+4A   j  ; was: locret_F3DE
                                        ; StageTransition_UpdatePostDestroyerProtoScroll+7E   j
                rts
; End of function StageTransition_UpdatePostDestroyerProtoScroll
; Transition to boss
StageTransition_WaitForShieldViperEntry:                ; DATA XREF: ROM:0000F10C   o  ; was: sub_F3E0
                bsr.w   loc_FBD8
                bsr.w   Boss_DestroyerProtoRenderSegments
                cmpi.w  #$FF80,(dword_FF9D96).w
                bpl.s   StageTransition_ShieldViperEntryWaitReturn
                addq.w  #2,(word_FFA950).w
                clr.w   (RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                clr.w   (word_FF8090).w
StageTransition_ShieldViperEntryWaitReturn:             ; CODE XREF: StageTransition_WaitForShieldViperEntry+E   j  ; was: locret_F400
                rts
; End of function StageTransition_WaitForShieldViperEntry
; Loads the Shield Viper encounter assets
StageTransition_LoadShieldViperAssets:                  ; DATA XREF: ROM:0000F10E   o  ; was: sub_F402
                bsr.w   loc_FBD8
                bsr.w   Boss_ShieldViperScrollSetup
                move.b  #0,(byte_FFA958).w
                jsr     (Stage_TransitionToNextPhase).l
                lea     (Boss_ShieldViperAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
                clr.w   (word_FF9DFC).w
                clr.w   (word_FF9DFE).w
                rts
; End of function StageTransition_LoadShieldViperAssets
; Builds the Shield Viper transition backdrop
StageTransition_UpdateShieldViperBackdrop:              ; DATA XREF: ROM:0000F110   o  ; was: sub_F42C
                bsr.w   loc_FBD8
                bsr.w   Boss_ShieldViperScrollSetup
                bsr.w   Boss_ShieldViperRenderBackground
                cmpi.w  #$C,(word_FF9DFE).w
                bmi.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                rts
; End of function StageTransition_UpdateShieldViperBackdrop
; Begins the Shield Viper transition fade
StageTransition_BeginShieldViperFade:                   ; DATA XREF: ROM:0000F112   o  ; was: sub_F448
                bsr.w   loc_FBD8
                bsr.w   Boss_ShieldViperScrollSetup
                tst.w   (Entity_ObjectPool).w
                bne.w   Boss_DestroyerProtoTransition_Return
                move.b  #1,(byte_FF830E).w
                addq.w  #2,(word_FFA950).w
                move.l  #Gfx_DefaultVRAMTransferParameters,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$F100,(word_FFA948).w
                move.w  #$10,(word_FFA944).w
                move.w  #$E,(word_FF9DAE).w
                bra.w   loc_FD08
; End of function StageTransition_BeginShieldViperFade
; Completes the Shield Viper transition fade
StageTransition_CompleteShieldViperFade:                ; DATA XREF: ROM:0000F114   o  ; was: sub_F484
                bsr.w   loc_FD08
                jsr     (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                move.w  #$20,(dword_FF8128).w           ; ' '
                move.l  #Gfx_ScrollVRAMTransferParameters,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$F400,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                move.b  #4,(byte_FFA95B).w
                move.w  #$A000,d0
                bra.w   Gfx_AdjustTransitionTileIndexRows
; End of function StageTransition_CompleteShieldViperFade
; Waits for the Shield Viper transition VRAM transfer
StageTransition_WaitForShieldViperVramTransfer:         ; DATA XREF: ROM:0000F116   o  ; was: sub_F4C6
                bsr.w   loc_FD08
                subq.w  #1,(dword_FF8128).w
                bmi.s   StageTransition_UpdateShieldViperVramTransfer
                rts
; ---------------------------------------------------------------------------
StageTransition_UpdateShieldViperVramTransfer:          ; CODE XREF: StageTransition_WaitForShieldViperVramTransfer+8   j  ; was: loc_F4D2
                cmpi.w  #$1B,(word_FFA944).w
                bmi.s   StageTransition_CompleteShieldViperVramTransfer
                jmp     Gfx_RenderScrollingBackground
; End of function StageTransition_WaitForShieldViperVramTransfer
; Completes the Shield Viper transition VRAM transfer
StageTransition_CompleteShieldViperVramTransfer:        ; CODE XREF: StageTransition_WaitForShieldViperVramTransfer+12   j  ; was: sub_F4E0
                move.w  #$6000,(dword_FFA940).w
                clr.w   (word_FFA946).w
                jsr     (Sprite_SetupDMA).l
                tst.w   (word_FFA944).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                move.w  #$50,(RasterEffectIndex).w      ; 'P'
                clr.w   (RasterEffectInitState).w
                move.w  #$16,(word_FF8090).w
                clr.l   (dword_FF8066).w
                move.l  #$600000,(dword_FF9D90).w
                clr.l   (dword_FF9DAA).w
                clr.w   (dword_FFA908).w
                move.w  #$F4E2,(dword_FFA90C).w
                jmp     Stage_TriggerPhaseTransition
; End of function StageTransition_CompleteShieldViperVramTransfer
; Waits for the Shield Viper exit conditions
StageTransition_WaitForShieldViperExit:                 ; DATA XREF: ROM:0000F118   o  ; was: sub_F528
                bsr.w   loc_FD08
                bsr.w   Boss_DestroyerProtoRenderSegments
                tst.w   (word_FF9DAE).w
                bmi.s   StageTransition_CheckShieldViperMessageComplete
                beq.s   StageTransition_CheckShieldViperMessageComplete
                subq.w  #1,(word_FF9DAE).w
                rts
; ---------------------------------------------------------------------------
StageTransition_CheckShieldViperMessageComplete:        ; CODE XREF: StageTransition_WaitForShieldViperExit+C   j  ; was: loc_F53E
                                        ; StageTransition_WaitForShieldViperExit+E   j
                tst.w   (MessageSequenceState).w
                bne.s   StageTransition_ShieldViperExitWaitReturn
                move.b  #$89,d0
                jsr     (Sound_QueueBGMOrStop).l
                addq.w  #2,(word_FFA950).w
                addq.w  #2,(StageTableIndex).w
                move.l  #$10000,(dword_FF9DB6).w
StageTransition_ShieldViperExitWaitReturn:              ; CODE XREF: StageTransition_WaitForShieldViperExit+1A   j  ; was: locret_F55E
                rts
; End of function StageTransition_WaitForShieldViperExit
; Transition to boss
StageTransition_UpdateWolfGaropaApproach:               ; DATA XREF: ROM:0000F11A   o  ; was: sub_F560
                bsr.w   StageTransition_UpdateWolfGaropaBackdropCoordinates
                bsr.w   Boss_DestroyerProtoRenderSegments
                subi.l  #$8000,(dword_FF9DAA).w
                subi.l  #$8000,(dword_FF9D90).w
                bpl.s   StageTransition_WolfGaropaApproachReturn
                addq.w  #2,(word_FFA950).w
                clr.w   (dword_FFA90C+2).w
                move.w  #$12,(PalettePrimaryIndex).w
                bsr.w   StageTransition_InitializeWolfGaropaArenaBoundaries
StageTransition_WolfGaropaApproachReturn:               ; CODE XREF: StageTransition_UpdateWolfGaropaApproach+18   j  ; was: locret_F58C
                rts
; End of function StageTransition_UpdateWolfGaropaApproach
; Updates the Wolf Garopa backdrop approach
StageTransition_UpdateWolfGaropaBackdropApproach:       ; DATA XREF: ROM:0000F11C   o  ; was: sub_F58E
                bsr.w   StageTransition_UpdateWolfGaropaBackdropCoordinates
                move.w  (dword_FFA90C).w,(dword_FFA904).w
                cmpi.w  #$F400,(dword_FFA90C).w
                bpl.s   StageTransition_CheckWolfGaropaBackdropPosition
                subi.l  #$400,(dword_FF9DB6).w
StageTransition_CheckWolfGaropaBackdropPosition:        ; CODE XREF: StageTransition_UpdateWolfGaropaBackdropApproach+10   j  ; was: loc_F5A8
                cmpi.w  #$F3E0,(dword_FFA90C).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.w   (RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                clr.w   (word_FF8090).w
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.l  #Gfx_DefaultVRAMTransferParameters,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                clr.w   (word_FFA946).w
                move.w  #$F400,(word_FFA948).w
                move.w  #$2000,d0
                bra.w   Gfx_AdjustTransitionTileIndexRows
; End of function StageTransition_UpdateWolfGaropaBackdropApproach
; Renders the Wolf Garopa transition backdrop
StageTransition_RenderWolfGaropaBackdrop:               ; DATA XREF: ROM:0000F11E   o  ; was: sub_F5EE
                move.l  (dword_FF8062).w,d0
                sub.l   d0,(dword_FFA908).w
                move.w  (dword_FFA908).w,(dword_FFA900).w
                move.w  (dword_FFA90C).w,(dword_FFA904).w
                jsr     (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.s   StageTransition_WolfGaropaBackdropRenderReturn
                addq.w  #2,(word_FFA950).w
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                clr.w   (word_FFA946).w
StageTransition_WolfGaropaBackdropRenderReturn:         ; CODE XREF: StageTransition_RenderWolfGaropaBackdrop+1E   j  ; was: locret_F622
                rts
; End of function StageTransition_RenderWolfGaropaBackdrop
; Finalizes the Wolf Garopa transition backdrop
StageTransition_FinalizeWolfGaropaBackdrop:             ; DATA XREF: ROM:0000F120   o  ; was: sub_F624
                bsr.w   StageTransition_UpdateWolfGaropaHorizontalScroll
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                jsr     (Sprite_SetupDMA).l
                tst.w   (word_FFA944).w
                bpl.s   StageTransition_WolfGaropaBackdropFinalizeReturn
                addq.w  #2,(word_FFA950).w
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                clr.b   (byte_FFA209).w
                move.w  #$494,(word_FFDB20).w
                clr.w   (word_FFDB24).w
                clr.w   (word_FFDB22).w
                clr.b   (byte_FFDB41).w
StageTransition_WolfGaropaBackdropFinalizeReturn:       ; CODE XREF: StageTransition_FinalizeWolfGaropaBackdrop+1A   j  ; was: locret_F660
                rts
; End of function StageTransition_FinalizeWolfGaropaBackdrop
; Restarts Wolf Garopa backdrop finalization
StageTransition_RestartWolfGaropaBackdropFinalize:      ; DATA XREF: ROM:0000F12A   o  ; was: sub_F662
                move.w  #$24,(word_FFA950).w            ; '$'
                move.l  #$FFF88000,(dword_FF8062).w
                bsr.w   StageTransition_InitializeWolfGaropaArenaBoundaries
                bset    #0,(byte_FFA209).w
                rts
; End of function StageTransition_RestartWolfGaropaBackdropFinalize
; Advances after the Wolf Garopa backdrop
StageTransition_AdvanceAfterWolfGaropaBackdrop:         ; DATA XREF: ROM:0000F122   o  ; was: sub_F67C
                bsr.w   StageTransition_UpdateWolfGaropaHorizontalScroll
                jmp     Stage_TransitionToNextPhase
; End of function StageTransition_AdvanceAfterWolfGaropaBackdrop
; Loads the Wolf Garopa encounter assets
StageTransition_LoadWolfGaropaAssets:                   ; DATA XREF: ROM:0000F124   o  ; was: sub_F686
                bsr.w   StageTransition_DecelerateWolfGaropaScroll
                tst.w   (MessageSequenceState).w
                bne.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FF9DBA).w
                lea     (Boss_WolfGaropaAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function StageTransition_LoadWolfGaropaAssets
; Waits for the Wolf Garopa object slots to clear
StageTransition_WaitForWolfGaropaObjectClear:           ; DATA XREF: ROM:0000F126   o  ; was: sub_F6A6
                bsr.w   StageTransition_UpdateWolfGaropaHorizontalScroll
                tst.w   (Entity_ObjectPool).w
                bne.s   StageTransition_WolfGaropaObjectClearWaitReturn
                move.w  #$30,(word_FFA950).w            ; '0'
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                move.w  #$80,(dword_FF8128).w
StageTransition_WolfGaropaObjectClearWaitReturn:        ; CODE XREF: StageTransition_WaitForWolfGaropaObjectClear+8   j  ; was: locret_F6C2
                rts
; End of function StageTransition_WaitForWolfGaropaObjectClear
; Waits for the Wolf Garopa transition trigger
StageTransition_WaitForWolfGaropaTransitionTrigger:     ; DATA XREF: ROM:0000F12C   o  ; was: sub_F6C4
                bsr.w   StageTransition_UpdateWolfGaropaHorizontalScroll
                tst.w   (MessageSequenceState).w
                bne.s   StageTransition_WolfGaropaTriggerWaitReturn
                subq.w  #1,(dword_FF8128).w
                bpl.s   StageTransition_WolfGaropaTriggerWaitReturn
                tst.w   (word_FF8230).w
                bne.s   StageTransition_WolfGaropaTriggerWaitReturn
                tst.w   (word_FF8138).w
                bne.s   StageTransition_WolfGaropaTriggerWaitReturn
                move.b  #$8F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w   Stage_InitTransitionState
; ---------------------------------------------------------------------------
StageTransition_WolfGaropaTriggerWaitReturn:            ; CODE XREF: StageTransition_WaitForWolfGaropaTransitionTrigger+8   j  ; was: locret_F6F2
                                        ; StageTransition_WaitForWolfGaropaTransitionTrigger+E   j
                rts
; End of function StageTransition_WaitForWolfGaropaTransitionTrigger
; Updates the Wolf Garopa transition scroll
StageTransition_UpdateWolfGaropaScroll:                 ; DATA XREF: ROM:0000F12E   o  ; was: sub_F6F4
                bsr.w   StageTransition_UpdateWolfGaropaHorizontalScroll
                rts
; End of function StageTransition_UpdateWolfGaropaScroll
; Decelerates the Wolf Garopa transition scroll
StageTransition_DecelerateWolfGaropaScroll:             ; CODE XREF: StageTransition_LoadWolfGaropaAssets   p  ; was: sub_F6FA
                cmpi.l  #$FFFF0000,(dword_FF8240).w
                beq.s   StageTransition_UpdateWolfGaropaCameraPosition
                subi.l  #$800,(dword_FF8240).w
StageTransition_UpdateWolfGaropaCameraPosition:         ; CODE XREF: StageTransition_DecelerateWolfGaropaScroll+8   j  ; was: loc_F70C
                move.l  (dword_FF8062).w,d0
                cmpi.l  #$FFF60000,d0
                bmi.s   StageTransition_UpdateWolfGaropaHorizontalScroll
                beq.s   StageTransition_UpdateWolfGaropaHorizontalScroll
                subi.l  #$800,d0
                move.l  d0,(dword_FF8062).w
; End of function StageTransition_DecelerateWolfGaropaScroll
; Updates the Wolf Garopa horizontal transition scroll
StageTransition_UpdateWolfGaropaHorizontalScroll:       ; CODE XREF: StageTransition_FinalizeWolfGaropaBackdrop   p  ; was: sub_F724
                                        ; StageTransition_AdvanceAfterWolfGaropaBackdrop   p
                move.l  (dword_FF8062).w,d0
                sub.l   d0,(dword_FFA900).w
                tst.b   (byte_FF9DBA).w
                beq.s   StageTransition_ClampWolfGaropaHorizontalScroll
                bmi.s   StageTransition_WolfGaropaHorizontalScrollReturn
                tst.w   (dword_FFA900).w
                bmi.s   StageTransition_WolfGaropaHorizontalScrollReturn
                cmpi.w  #$200,(dword_FFA900).w
                bmi.s   StageTransition_WolfGaropaHorizontalScrollReturn
                clr.b   (byte_FF9DBA).w
                bsr.w   Gfx_LoadWolfGaropaTransitionTiles
StageTransition_ClampWolfGaropaHorizontalScroll:        ; CODE XREF: StageTransition_UpdateWolfGaropaHorizontalScroll+C   j  ; was: loc_F74A
                andi.w  #$3F,(dword_FFA900).w           ; '?'
StageTransition_WolfGaropaHorizontalScrollReturn:       ; CODE XREF: StageTransition_UpdateWolfGaropaHorizontalScroll+E   j  ; was: locret_F750
                                        ; StageTransition_UpdateWolfGaropaHorizontalScroll+14   j
                rts
; End of function StageTransition_UpdateWolfGaropaHorizontalScroll
; Loads the Wolf Garopa transition tiles
Gfx_LoadWolfGaropaTransitionTiles:                      ; CODE XREF: StageTransition_UpdateWolfGaropaHorizontalScroll+22   p  ; was: sub_F752
                                        ; Effect_WolfGaropaBoundaryMain+28   p
                lea     Gfx_WolfGaropaTransitionTileDmaDescriptor(pc),a0
                nop
                jsr     (Gfx_DMATransferTiles).l
                lea     Gfx_WolfGaropaTransitionCompressedTileCommands(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadWolfGaropaTransitionTiles
; ---------------------------------------------------------------------------
Gfx_WolfGaropaTransitionTileDmaDescriptor:  dc.b    $44, $58, $40, 0, 1, 3, $1F  ; was: byte_F76A
                                        ; DATA XREF: Gfx_LoadWolfGaropaTransitionTiles   o
                dc.b    $1E, $21, $20, $23, $22, $25, $24
Gfx_WolfGaropaTransitionCompressedTileCommands: dc.b    $4C, $50, $40, 0, 4, 1, $26, $27  ; was: byte_F778
                                        ; DATA XREF: Gfx_LoadWolfGaropaTransitionTiles+C   o
                dc.b    $26, $27, $26, $28, $29, $28, $29, $28

; Updates the Wolf Garopa transition backdrop coordinates
StageTransition_UpdateWolfGaropaBackdropCoordinates:    ; CODE XREF: StageTransition_UpdateWolfGaropaApproach   p  ; was: sub_F788
                                        ; StageTransition_UpdateWolfGaropaBackdropApproach   p
                move.l  (dword_FF9DB6).w,d0
                sub.l   d0,(dword_FFA90C).w
                move.l  (dword_FF8062).w,d0
                sub.l   d0,(dword_FFA908).w
                moveq   #0,d0
                move.w  (dword_FFA90C).w,d1
                subi.w  #$F8,d1
                lea     (Gfx_ScrollVRAMTransferParameters).l,a0
                bra.w   loc_109E0
; End of function StageTransition_UpdateWolfGaropaBackdropCoordinates
; Adjusts tile indices in the stage-transition rows
Gfx_AdjustTransitionTileIndexRows:                      ; CODE XREF: StageTransition_CompleteShieldViperFade+3E   j  ; was: sub_F7AC
                                        ; StageTransition_UpdateWolfGaropaBackdropApproach+5C   j
                movea.l #$FFFF4300,a0
                moveq   #$30,d7                         ; '0'
                jmp     Gfx_AdjustTileIndexRows
; End of function Gfx_AdjustTransitionTileIndexRows
; Unreferenced transition-scroll initializer
UnreferencedInitializeTransitionScroll:
                addq.w  #2,(word_FFA950).w              ; was: sub_F7BA
                move.b  #$40,(byte_FFA958).w            ; '@'
                move.w  #$FFFE,(dword_FFA960).w
                clr.b   (VDPReg11Shadow+1).w
                rts
; End of function UnreferencedInitializeTransitionScroll
; Unreferenced asteroid-scroll target updater
UnreferencedUpdateAsteroidScrollToTarget:
                bsr.w   Stage_ScrollUpdate3             ; was: sub_F7D0
                bsr.w   Stage_AsteroidsGraphicsUpdate
                cmpi.w  #$F3E0,(dword_FFA904).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                move.b  #0,(byte_FFA958).w
                move.w  #$F3E0,(dword_FFA904).w
                clr.l   (dword_FFA960).w
                rts
; End of function UnreferencedUpdateAsteroidScrollToTarget
UnreferencedEmptyTransitionHandler:
                ; was: nullsub_29
                rts
; End of function UnreferencedEmptyTransitionHandler

; Stage initialization
