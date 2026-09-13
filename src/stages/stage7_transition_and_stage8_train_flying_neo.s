Stage7_WaitForPlayerStage8Trigger:                      ; DATA XREF: ROM:0000C896   o  ; was: sub_CDFA
                cmpi.w  #$140,(PlayerXPosition).w
                bmi.s   Stage7_WaitForPlayerStage8Trigger_Return
                addq.w  #2,(StageStateOffset).w
                move.w  #$40,(dword_FF8058).w           ; '@'
Stage7_WaitForPlayerStage8Trigger_Return:               ; CODE XREF: Stage7_WaitForPlayerStage8Trigger+6   j  ; was: locret_CE0C
                rts
; End of function Stage7_WaitForPlayerStage8Trigger
; Wait for the Stage 7 exit delay, then start the Stage 8 transition
Stage7_StartTransitionToStage8:                         ; DATA XREF: ROM:0000C898   o  ; was: sub_CE0E
                subq.w  #1,(dword_FF8058).w
                bmi.s   Stage7_StartTransitionToStage8_CheckReady
Stage7_StartTransitionToStage8_Return:                  ; CODE XREF: Stage7_StartTransitionToStage8+C   j  ; was: locret_CE14
                rts
; ---------------------------------------------------------------------------
Stage7_StartTransitionToStage8_CheckReady:              ; CODE XREF: Stage7_StartTransitionToStage8+4   j  ; was: loc_CE16
                tst.w   (GameplayExitMode).w
                bne.s   Stage7_StartTransitionToStage8_Return
                move.b  #$89,(PendingStageBGMRequest).w
                move.l  #StageTransitionMessageSequence_TrainAndBugmax,(StageMessageCursor).w
                bra.w   Stage_StartInterstageTransition
; End of function Stage7_StartTransitionToStage8
; Write six source bytes to three strided pairs in the Stage 8 control region
Stage8_WriteStridedControlBytes:                        ; CODE XREF: Stage8_InitializeTrainSequence+38   p  ; was: sub_CE2E
                                        ; Stage8_InitializeFlyingNeoEncounter+1A   p
                lea     (M68K_RAM_PHYSICAL+(Stage8StridedControl-M68K_RAM)).l,a0
                move.b  (a1)+,(a0)
                move.b  (a1)+,1(a0)
                move.b  (a1)+,8(a0)
                move.b  (a1)+,9(a0)
                move.b  (a1)+,$10(a0)
                move.b  (a1)+,$11(a0)
                rts
; End of function Stage8_WriteStridedControlBytes
; ---------------------------------------------------------------------------
Stage8_TrainStridedControlBytes:    dc.b    $19, $1A, $1E, $1F, $23, $24  ; was: byte_CE4C
                                        ; DATA XREF: Stage8_InitializeTrainSequence+34   o
Stage8_FlyingNeoStridedControlBytes:    dc.b    $1C, $1D, $21, $22, $26, $27  ; was: byte_CE52
                                        ; DATA XREF: Stage8_InitializeFlyingNeoEncounter+16   o

; Initialize the Stage 8 train sequence and Flying Neo composite
Stage8_InitializeTrainSequence:                         ; DATA XREF: ROM:0000C89A   o  ; was: sub_CE58
                move.w  #1,(MidgameLightningMode).w
                addq.w  #2,(StageStateOffset).w
                move.w  #$730,(PrimaryCameraXPosition).w
                move.w  #0,(PrimaryCameraYPosition).w
                move.w  (PrimaryCameraXPosition).w,(PreviousCameraXPosition).w
                move.w  (PrimaryCameraYPosition).w,(PreviousCameraYPosition).w
                move.b  #3,(VDPReg11Shadow+1).w
                move.b  #$30,(byte_FFA95A).w            ; '0'
                move.b  #4,(byte_FFA95B).w
                lea     Stage8_TrainStridedControlBytes(pc),a1
                bsr.s   Stage8_WriteStridedControlBytes
                bsr.w   Stage8_InitializeFlyingNeoComposite
                move.w  #$34,(PlayerScriptStateOffset).w  ; '4'
                move.w  #$45C,(Entity_ObjectPool).w
                clr.w   (PrimaryEntityState).w
; Update the Stage 8 train until camera X reaches $EC0
Stage8_UpdateTrainSequence:                             ; DATA XREF: ROM:0000C89C   o  ; was: loc_CEA6
                cmpi.w  #$EC0,(PrimaryCameraXPosition).w
                bmi.s   Stage8_UpdateTrainSequence_UpdateScroll
                move.w  #$16,(PlayerScriptStateOffset).w
                bsr.w   Stage_TransitionToNextPhase
Stage8_UpdateTrainSequence_UpdateScroll:                ; CODE XREF: Stage8_InitializeTrainSequence+54   j  ; was: loc_CEB8
                bsr.w   Stage8_UpdateTrainScrollAndTilemap
; End of function Stage8_InitializeTrainSequence
; Update Stage 8 train lightning, parallax, and vertical oscillation
Stage8_UpdateTrainEffectsAndVerticalOscillation:        ; CODE XREF: Stage8_InitializeFlyingNeoApproach+4   p  ; was: sub_CEBC
                                        ; Stage8_UpdateFlyingNeoApproachEffects+E   j
                move.l  #Stage8_TrainLightningPaletteEntryLists,(PaletteEntryLists).w
                bsr.w   Midgame_UpdateRandomLightningEffect
                bsr.w   Midgame_UpdateTrainAndFlyCorridorParallaxRows
                tst.w   (dword_FFA960).w
                bmi.s   Stage8_UpdateTrainEffectsAndVerticalOscillation_Return
                bne.s   Stage8_UpdateTrainEffectsAndVerticalOscillation_AccelerateDown
                subi.l  #$1400,(PrimaryCameraYPosition).w
                bpl.s   Stage8_UpdateTrainEffectsAndVerticalOscillation_Return
                addq.w  #1,(dword_FFA960).w
                bra.s   Stage8_UpdateTrainEffectsAndVerticalOscillation_Return
; ---------------------------------------------------------------------------
Stage8_UpdateTrainEffectsAndVerticalOscillation_AccelerateDown:  ; CODE XREF: Stage8_UpdateTrainEffectsAndVerticalOscillation+16   j  ; was: loc_CEE4
                addi.l  #$1400,(PrimaryCameraYPosition).w
                cmpi.w  #$18,(PrimaryCameraYPosition).w
                bmi.s   Stage8_UpdateTrainEffectsAndVerticalOscillation_Return
                clr.w   (dword_FFA960).w
Stage8_UpdateTrainEffectsAndVerticalOscillation_Return:  ; CODE XREF: Stage8_UpdateTrainEffectsAndVerticalOscillation+14   j  ; was: locret_CEF8
                                        ; Stage8_UpdateTrainEffectsAndVerticalOscillation+20   j
                rts
; End of function Stage8_UpdateTrainEffectsAndVerticalOscillation
; Update the four repeating Stage 8 train parallax values
Midgame_UpdateTrainAndFlyCorridorParallaxRows:          ; CODE XREF: Stage8_UpdateTrainEffectsAndVerticalOscillation+C   p  ; was: sub_CEFA
                                        ; Stage8_UpdateFlyingNeoVerticalScrollAndEffects+2E   p
                movea.w #(HorizontalScrollProfile-M68K_RAM),a5
                subi.l  #$28000,(VerticalScrollProfile).w
                move.w  (RandomNumberState).w,d0
                andi.w  #7,d0
                addq.w  #8,d0
                subi.w  #$41,(MidgameParallaxValue0).w  ; 'A'
                sub.w   d0,(MidgameParallaxValue1).w
                subi.w  #$10,(MidgameParallaxValue2).w
                subi.w  #$13,(MidgameParallaxValue3).w
                move.w  #$C,d6
                move.w  (FrameCounter).w,d0
                asl.w   #2,d0
                movea.w #(MidgameParallaxValue0-M68K_RAM),a0
                and.w   d6,d0
                move.w  (a0,d0.w),d1
                addq.w  #4,d0
                and.w   d6,d0
                move.w  (a0,d0.w),d2
                addq.w  #4,d0
                and.w   d6,d0
                move.w  (a0,d0.w),d3
                addq.w  #4,d0
                and.w   d6,d0
                move.w  (a0,d0.w),d4
                addq.w  #4,d0
                movea.w #(HorizontalScrollProfile-M68K_RAM),a5
                move.w  #$2F,d7                         ; '/'
Midgame_UpdateTrainAndFlyCorridorParallaxRows_FillBuffer:  ; CODE XREF: Midgame_UpdateTrainAndFlyCorridorParallaxRows+6A   j  ; was: loc_CF5C
                move.w  d1,(a5)+
                move.w  d2,(a5)+
                move.w  d3,(a5)+
                move.w  d4,(a5)+
                dbf     d7,Midgame_UpdateTrainAndFlyCorridorParallaxRows_FillBuffer
                rts
; End of function Midgame_UpdateTrainAndFlyCorridorParallaxRows
; Advance the train to the Flying Neo approach boundary
Stage8_InitializeFlyingNeoApproach:                     ; DATA XREF: ROM:0000C89E   o  ; was: sub_CF6A
                bsr.w   Scroll_AdvanceTrainHorizontalAndRenderTilemap
                bsr.w   Stage8_UpdateTrainEffectsAndVerticalOscillation
                cmpi.w  #$F00,(PrimaryCameraXPosition).w
                bmi.s   Stage8_InitializeFlyingNeoApproach_Return
                addq.w  #2,(StageStateOffset).w
                move.w  #$80,(dword_FFA960+2).w
                clr.l   (CameraXDelta).w
                move.w  #$F00,d0
                move.w  d0,(PrimaryCameraXPosition).w
                move.w  d0,(CameraXLowerBound).w
                move.w  d0,(CameraXUpperBound).w
Stage8_InitializeFlyingNeoApproach_Return:              ; CODE XREF: Stage8_InitializeFlyingNeoApproach+E   j  ; was: locret_CF98
                rts
; End of function Stage8_InitializeFlyingNeoApproach
; Wait for the Flying Neo approach delay and shared gate
Stage8_UpdateFlyingNeoApproachDelay:                    ; DATA XREF: ROM:0000C8A0   o  ; was: sub_CF9A
                subq.w  #1,(dword_FFA960+2).w
                bpl.s   Stage8_UpdateFlyingNeoApproachEffects
                tst.w   (ScriptedInputActive).w
                bne.s   Stage8_UpdateFlyingNeoApproachEffects
                addq.w  #2,(StageStateOffset).w
                clr.l   (dword_FFA964).w
                bsr.w   Stage8_StartFlyingNeoCompositeAndQueueTiles
Stage8_UpdateFlyingNeoApproachEffects:                  ; CODE XREF: Stage8_UpdateFlyingNeoApproachDelay+4   j  ; was: loc_CFB2
                                        ; Stage8_UpdateFlyingNeoApproachDelay+A   j
                move.w  (PrimaryCameraXPosition).w,(SecondaryCameraXPos).w
                move.w  (PrimaryCameraYPosition).w,(SecondaryCameraYPos).w
                bra.w   Stage8_UpdateTrainEffectsAndVerticalOscillation
; End of function Stage8_UpdateFlyingNeoApproachDelay
; Decelerate the Flying Neo approach's vertical velocity
Stage8_DecelerateFlyingNeoVerticalScroll:               ; DATA XREF: ROM:0000C8A4   o  ; was: sub_CFC2
                subi.l  #$1000,(dword_FFA964).w
                bpl.s   Stage8_UpdateFlyingNeoVerticalScrollAndEffects
                addq.w  #2,(StageStateOffset).w
                move.w  #1,(dword_FFA960).w
                move.w  #$40,(dword_FFA960+2).w         ; '@'
                bra.s   Stage8_UpdateFlyingNeoVerticalScrollAndEffects
; End of function Stage8_DecelerateFlyingNeoVerticalScroll
; Accelerate the Flying Neo approach's vertical velocity
Stage8_AccelerateFlyingNeoVerticalScroll:               ; DATA XREF: ROM:0000C8A2   o  ; was: sub_CFDE
                cmpi.w  #5,(dword_FFA964).w
                bpl.s   Stage8_AccelerateFlyingNeoVerticalScroll_CheckPosition
                addi.l  #$1000,(dword_FFA964).w
Stage8_AccelerateFlyingNeoVerticalScroll_CheckPosition:  ; CODE XREF: Stage8_AccelerateFlyingNeoVerticalScroll+6   j  ; was: loc_CFEE
                cmpi.w  #$40,(PrimaryCameraYPosition).w  ; '@'
                bmi.s   Stage8_UpdateFlyingNeoVerticalScrollAndEffects
                addq.w  #2,(StageStateOffset).w
                move.w  #$1A,(PlayerScriptStateOffset).w
Stage8_UpdateFlyingNeoVerticalScrollAndEffects:         ; CODE XREF: Stage8_DecelerateFlyingNeoVerticalScroll+8   j  ; was: loc_D000
                                        ; Stage8_DecelerateFlyingNeoVerticalScroll+1A   j
                move.l  (dword_FFA964).w,d0
                add.l   d0,(PrimaryCameraYPosition).w
                bsr.w   Stage8_UpdateFlyingNeoScrollAndTilemap
                bsr.w   Midgame_UpdateTrainAndFlyCorridorParallaxRows
                move.l  #Stage8_FlyingNeoLightningPaletteEntryLists,(PaletteEntryLists).w
                bsr.w   Midgame_UpdateRandomLightningEffect
                rts
; End of function Stage8_AccelerateFlyingNeoVerticalScroll
; Submit Flying Neo's assets and initialize its encounter controls
Stage8_InitializeFlyingNeoEncounter:                    ; DATA XREF: ROM:0000C8A6   o  ; was: sub_D01E
                subq.w  #1,(dword_FFA960+2).w
                bpl.s   Stage8_UpdateFlyingNeoEncounterEffects
                addq.w  #2,(StageStateOffset).w
                lea     (Boss_FlyingNeoAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
                lea     Stage8_FlyingNeoStridedControlBytes(pc),a1
                bsr.w   Stage8_WriteStridedControlBytes
                bsr.w   Midgame_LoadFlyingNeoPaletteCommands
Stage8_UpdateFlyingNeoEncounterEffects:                 ; CODE XREF: Stage8_InitializeFlyingNeoEncounter+4   j  ; was: loc_D040
                                        ; Stage8_UpdateFlyingNeoEncounter+4   j
                move.l  #Stage8_FlyingNeoLightningPaletteEntryLists,(PaletteEntryLists).w
                bsr.w   Midgame_UpdateRandomLightningEffect
                move.w  (PrimaryCameraXPosition).w,(SecondaryCameraXPos).w
                move.w  (PrimaryCameraYPosition).w,(SecondaryCameraYPos).w
                bsr.w   Midgame_UpdateTrainAndFlyCorridorParallaxRows
                tst.w   (dword_FFA960).w
                bne.s   Stage8_AdvanceFlyingNeoVerticalOscillation
                subi.l  #$4000,(PrimaryCameraYPosition).w
                cmpi.w  #$60,(PrimaryCameraYPosition).w  ; '`'
                bpl.s   Stage8_UpdateFlyingNeoEncounterEffects_Return
                addq.w  #1,(dword_FFA960).w
Stage8_UpdateFlyingNeoEncounterEffects_Return:          ; CODE XREF: Stage8_InitializeFlyingNeoEncounter+52   j  ; was: locret_D076
                                        ; Stage8_InitializeFlyingNeoEncounter+68   j
                rts
; ---------------------------------------------------------------------------
Stage8_AdvanceFlyingNeoVerticalOscillation:             ; CODE XREF: Stage8_InitializeFlyingNeoEncounter+42   j  ; was: loc_D078
                addi.l  #$4000,(PrimaryCameraYPosition).w
                cmpi.w  #$80,(PrimaryCameraYPosition).w
                bmi.s   Stage8_UpdateFlyingNeoEncounterEffects_Return
                clr.w   (dword_FFA960).w
                rts
; End of function Stage8_InitializeFlyingNeoEncounter
; Start the post-Flying-Neo transition after its message and shared gate clear
Stage8_StartPostFlyingNeoTransition:                    ; DATA XREF: ROM:0000C8AA   o  ; was: sub_D08E
                tst.w   (MessageSequenceState).w
                bne.w   Stage8_UpdateFlyingNeoEncounter
                tst.w   (GameplayExitMode).w
                bne.s   Stage8_UpdateFlyingNeoEncounter
                move.l  #StageTransitionMessageSequence_PostFlyingNeo,(StageMessageCursor).w
                tst.w   (MessageSequenceState).w
                beq.w   Stage_StartInterstageTransition
; End of function Stage8_StartPostFlyingNeoTransition
; Update the Flying Neo encounter camera and vertical oscillation
Stage8_UpdateFlyingNeoEncounter:                        ; CODE XREF: Stage8_StartPostFlyingNeoTransition+4   j  ; was: sub_D0AC
                                        ; Stage8_StartPostFlyingNeoTransition+C   j
                                        ; DATA XREF:
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Stage8_UpdateFlyingNeoEncounterEffects
; End of function Stage8_UpdateFlyingNeoEncounter
; Initializes Stage 9 with scroll and parameters
