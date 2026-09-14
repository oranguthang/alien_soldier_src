; Sharpssteel main controller, entrance, attack selection, and movement states
Boss_SharpssteelMain:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_47C1C
                tst.w   4(a5)
                beq.w   Boss_SharpssteelDispatchState
                tst.w   8(a5)
                beq.s   Boss_SharpssteelDispatchState
                btst    #2,(BossColorEffectFlags).w
                bne.s   Boss_SharpssteelUpdatePaletteAndCore
                btst    #1,(BossColorEffectFlags).w
                bne.s   Boss_SharpssteelUpdatePaletteAndCore
                tst.w   (BossHealth).w
                beq.w   Boss_SharpssteelBeginDefeatFragmentBurst
Boss_SharpssteelUpdatePaletteAndCore:                   ; CODE XREF: Boss_SharpssteelMain+14   j
                                        ; Boss_SharpssteelMain+1C   j
                jsr     (Gfx_ProcessDefaultColorFade).l
                bsr.w   Boss_SharpssteelShiftBladeTargetHistory
Boss_SharpssteelDispatchState:                          ; CODE XREF: Boss_SharpssteelMain+4   j
                                        ; Boss_SharpssteelMain+C   j
                move.w  4(a5),d0
                movea.w Boss_SharpssteelStates(pc,d0.w),a0
                adda.l  #Boss_SharpssteelStateReturn,a0
                jmp     (a0)
; End of function Boss_SharpssteelMain
; ---------------------------------------------------------------------------
Boss_SharpssteelStates: dc.w    Boss_SharpssteelWaitForPlayerReadyState-Boss_SharpssteelStateReturn
                                        ; DATA XREF: Boss_SharpssteelMain+34   r
                dc.w    Boss_SharpssteelInitializeState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelManualControlState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelOpeningVerticalTurnState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelMoveBladeAssemblyToThresholdState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelBladeAssemblySweepState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelRunBladeEntranceDelayState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelWaitForPlayerAfterBladeEntranceState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelAdvanceBladePartOffsetState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelAccelerateBladeAssemblyState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelBladeAssemblyDelayState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelWaitForTwoBladeTriggersState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelWaitForSevenBladeTriggersState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelWaitForRotationSweepState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelAttackSelectionDelayState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelDefeatFadeAndRemovalState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelFarRangeBladeAttackState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelDiveAttackState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelPostDiveDelayState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelFallingShotCycleState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelWaitBeforeAttackSelectionState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelSelectDistanceAttackState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelWaitForComplexAlignmentState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelAccelerateComplexMotionState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelComplexOscillationState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelBladeShotBurstState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelComplexExitFallState-Boss_SharpssteelStateReturn
                dc.w    Boss_SharpssteelCloseRangeBladeAttackState-Boss_SharpssteelStateReturn

Boss_SharpssteelStateReturn:                            ; CODE XREF: Boss_SharpssteelPostDiveDelayState+4   j
                                        ; DATA XREF: Boss_SharpssteelMain+38   o
                rts
; End of function Boss_SharpssteelStateReturn

; Waits for the shared player-ready word before initializing the encounter
Boss_SharpssteelWaitForPlayerReadyState:                ; DATA XREF: ROM:Boss_SharpssteelStates   o  ; was: sub_47C96
                tst.w   (MessageSequenceState).w
                bne.s   Boss_SharpssteelWaitForPlayerReadyReturn
                addq.w  #2,4(a5)
                clr.w   8(a5)
Boss_SharpssteelWaitForPlayerReadyReturn:               ; CODE XREF: Boss_SharpssteelWaitForPlayerReadyState+4   j
                rts
; End of function Boss_SharpssteelWaitForPlayerReadyState
; Creates the eighteen-part metasprite and initializes the blade encounter
Boss_SharpssteelInitializeState:                        ; DATA XREF: ROM:00047C5E   o  ; was: sub_47CA6
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$8300,(MetaspriteBaseTileWord).w
                moveq   #$11,d7
                movea.l #Boss_SharpssteelMetaspriteDescriptors,a0
                movea.l #Boss_SharpssteelPartRadii,a1
                movea.l #Boss_SharpssteelPartLinks,a2
                jsr     (Sprite_InitializeLinkedMetaspriteParts).l
                move.w  #$C300,$36E(a5)
                move.w  #$C300,$4EE(a5)
                move.w  #$21C,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                move.w  #$CC00,$C2(a5)
                bsr.w   Boss_SharpssteelConfigureBladeGraphicsSetA
                movea.l #Boss_SharpssteelObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                move.w  #2,$1DE(a5)
                bra.w   Boss_SharpssteelInitializeBladeEntrance
; End of function Boss_SharpssteelInitializeState
; Alternate entry that initializes the otherwise unreferenced manual-control state
Boss_SharpssteelInitializeManualControl:
                move.w  #4,4(a5)                        ; was: sub_47D06
                move.w  #$120,$10(a5)
                move.w  #$100,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.b   (BossColorEffectFlags).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                moveq   #4,d0
                bsr.w   Boss_SharpssteelSetInnerBladeGroupSizes
; End of function Boss_SharpssteelInitializeManualControl
; Development-style manual controls for core mode and blade angle
Boss_SharpssteelManualControlState:                     ; DATA XREF: ROM:00047C60   o  ; was: sub_47D3C
                btst    #5,(ControllerPressedState).w
                beq.s   Boss_SharpssteelCheckManualCoreActivationInput
                bsr.w   Boss_SharpssteelConfigureBladeGraphicsSetA
Boss_SharpssteelCheckManualCoreActivationInput:         ; CODE XREF: Boss_SharpssteelManualControlState+6   j
                btst    #4,(ControllerPressedState).w
                beq.s   Boss_SharpssteelCheckManualAngleIncreaseInput
                bsr.w   Boss_SharpssteelConfigureBladeGraphicsSetB
Boss_SharpssteelCheckManualAngleIncreaseInput:          ; CODE XREF: Boss_SharpssteelManualControlState+12   j
                btst    #2,(ControllerHeldState).w
                beq.s   Boss_SharpssteelCheckManualAngleDecreaseInput
                addq.w  #2,$56(a5)
Boss_SharpssteelCheckManualAngleDecreaseInput:          ; CODE XREF: Boss_SharpssteelManualControlState+1E   j
                btst    #3,(ControllerHeldState).w
                beq.s   Boss_SharpssteelApplyManualAngle
                subq.w  #2,$56(a5)
Boss_SharpssteelApplyManualAngle:                       ; CODE XREF: Boss_SharpssteelManualControlState+2A   j
                andi.w  #$1FE,$56(a5)
                lea     Boss_SharpssteelManualControlPoseCommands(pc),a1
                nop
                bsr.w   Boss_SharpssteelRunBladePoseCommands
                bra.w   Boss_SharpssteelUpdateBladePresentation
; End of function Boss_SharpssteelManualControlState
; Updates the final fade and removes the controller when its timer expires
Boss_SharpssteelDefeatFadeAndRemovalState:              ; DATA XREF: ROM:00047C7A   o  ; was: sub_47D80
                jsr     (Gfx_UpdateRandomizedPaletteRange).l
                subq.w  #1,$48(a5)
                bpl.s   Boss_SharpssteelDefeatFadeAndRemovalReturn
                bset    #4,2(a5)
Boss_SharpssteelDefeatFadeAndRemovalReturn:             ; CODE XREF: Boss_SharpssteelDefeatFadeAndRemovalState+A   j
                rts
; End of function Boss_SharpssteelDefeatFadeAndRemovalState
; Initializes the blade entrance sequence and shared encounter parameters
Boss_SharpssteelInitializeBladeEntrance:                ; CODE XREF: Boss_SharpssteelInitializeState+5C   j  ; was: sub_47D94
                move.w  #$C,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #3,$182(a5)
                move.w  #$FFE0,$190(a5)
                move.w  #$168,$3D4(a5)
                move.w  #$C7A0,$48(a5)
                move.w  #$C9E0,$4A(a5)
                move.w  #$80,$56(a5)
                move.w  #1,$11C(a5)
                move.w  #$120,$11E(a5)
                move.w  #$A0,$17C(a5)
                bsr.w   Boss_SharpssteelConfigureBladeGraphicsSetA
                bsr.w   Boss_SharpssteelSetBladePartPriorityBits
                moveq   #$C,d0
                bsr.w   Boss_SharpssteelSetInnerBladeGroupSizes
; End of function Boss_SharpssteelInitializeBladeEntrance
; Runs horizontal/blade motion during the entrance delay
Boss_SharpssteelRunBladeEntranceDelayState:             ; DATA XREF: ROM:00047C68   o  ; was: sub_47DE8
                subq.w  #1,$17C(a5)
                bmi.s   Boss_SharpssteelFinishBladeEntranceDelay
                bsr.w   Boss_SharpssteelUpdateHorizontalAttackMotion
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelFinishBladeEntranceDelay:               ; CODE XREF: Boss_SharpssteelRunBladeEntranceDelayState+4   j
                addq.w  #2,4(a5)
                moveq   #4,d0
                jsr     (BossMessage_Start).l
; End of function Boss_SharpssteelRunBladeEntranceDelayState
; Continues entrance motion until the shared player-ready word clears
Boss_SharpssteelWaitForPlayerAfterBladeEntranceState:   ; DATA XREF: ROM:00047C6A   o  ; was: sub_47E02
                tst.w   (MessageSequenceState).w
                beq.s   Boss_SharpssteelAdvanceFromBladeEntrance
                bsr.w   Boss_SharpssteelUpdateHorizontalAttackMotion
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelAdvanceFromBladeEntrance:               ; CODE XREF: Boss_SharpssteelWaitForPlayerAfterBladeEntranceState+4   j
                addq.w  #2,4(a5)
; Advances one blade-part offset to its entrance threshold
Boss_SharpssteelAdvanceBladePartOffsetState:            ; DATA XREF: ROM:00047C6C   o  ; was: loc_47E14
                addq.w  #1,$3D4(a5)
                cmpi.w  #$1C0,$3D4(a5)
                bpl.s   Boss_SharpssteelFinishBladePartOffsetAdvance
                bsr.w   Boss_SharpssteelUpdateHorizontalAttackMotion
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelFinishBladePartOffsetAdvance:           ; CODE XREF: Boss_SharpssteelWaitForPlayerAfterBladeEntranceState+1C   j
                bclr    #3,$182(a5)
                addq.w  #2,4(a5)
                bsr.w   Boss_SharpssteelInitializeFallingShotCycle
; End of function Boss_SharpssteelWaitForPlayerAfterBladeEntranceState
; Accelerates the blade assembly while its fixed-point travel value remains nonnegative
Boss_SharpssteelAccelerateBladeAssemblyState:           ; DATA XREF: ROM:00047C6E   o  ; was: sub_47E36
                subi.l  #$22000,$2FC(a5)
                bmi.s   Boss_SharpssteelFinishBladeAssemblyAcceleration
                move.w  (SharpssteelTargetTrail).w,$190(a5)
                bsr.w   Boss_SharpssteelUpdateBladeTargetVelocity
                lea     Boss_SharpssteelAssemblyDelayPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelFinishBladeAssemblyAcceleration:        ; CODE XREF: Boss_SharpssteelAccelerateBladeAssemblyState+8   j
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                move.b  #$10,$E1(a5)
; Holds the blade assembly for the configured post-acceleration delay
Boss_SharpssteelBladeAssemblyDelayState:                ; DATA XREF: ROM:00047C70   o  ; was: loc_47E64
                subq.w  #1,$11C(a5)
                bmi.s   Boss_SharpssteelFinishBladeAssemblyDelay
                move.w  (SharpssteelTargetTrail).w,$190(a5)
                bsr.w   Boss_SharpssteelUpdateBladeTargetVelocity
                lea     Boss_SharpssteelAssemblyDelayPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelFinishBladeAssemblyDelay:               ; CODE XREF: Boss_SharpssteelAccelerateBladeAssemblyState+32   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $29C(a5)
                bsr.w   Boss_SharpssteelSetBladeGroupBPriorityBits
                bsr.w   Boss_SharpssteelSetBladeGroupAPriorityBits
; End of function Boss_SharpssteelAccelerateBladeAssemblyState
; Runs blade assembly motion until two trigger events have completed
Boss_SharpssteelWaitForTwoBladeTriggersState:           ; DATA XREF: ROM:00047C72   o  ; was: sub_47E98
                cmpi.w  #2,$29C(a5)
                bpl.s   Boss_SharpssteelBeginSevenBladeTriggerWait
Boss_SharpssteelUpdateBladeAssemblyMotion:              ; CODE XREF: Boss_SharpssteelWaitForTwoBladeTriggersState+30   j
                                        ; Boss_SharpssteelWaitForTwoBladeTriggersState+50   j
                move.w  (SharpssteelTargetTrail).w,$190(a5)
                bsr.w   Boss_SharpssteelUpdateBladeTargetVelocity
                lea     Boss_SharpssteelAssemblyTriggerPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelBeginSevenBladeTriggerWait:             ; CODE XREF: Boss_SharpssteelWaitForTwoBladeTriggersState+6   j
                addq.w  #2,4(a5)
                addq.w  #2,(Entity59State).w
; Continues blade assembly motion until seven trigger events have completed
Boss_SharpssteelWaitForSevenBladeTriggersState:         ; DATA XREF: ROM:00047C74   o  ; was: loc_47EBC
                cmpi.w  #7,$29C(a5)
                bpl.s   Boss_SharpssteelBeginRotationSweep
                bsr.w   Boss_SharpssteelPublishBladePartTargets
                bra.s   Boss_SharpssteelUpdateBladeAssemblyMotion
; ---------------------------------------------------------------------------
Boss_SharpssteelBeginRotationSweep:                     ; CODE XREF: Boss_SharpssteelWaitForTwoBladeTriggersState+2A   j
                addq.w  #2,4(a5)
                addq.w  #2,(Entity59State).w
                move.l  #$FFFD8000,(Entity59XVel).w
                move.l  #$FFFD0000,(Entity59YVel).w
; Waits for the signed rotation-sweep completion flag
Boss_SharpssteelWaitForRotationSweepState:              ; DATA XREF: ROM:00047C76   o  ; was: loc_47EE2
                tst.w   $58(a5)
                bmi.s   Boss_SharpssteelFinishRotationSweep
                bra.s   Boss_SharpssteelUpdateBladeAssemblyMotion
; ---------------------------------------------------------------------------
Boss_SharpssteelFinishRotationSweep:                    ; CODE XREF: Boss_SharpssteelWaitForTwoBladeTriggersState+4E   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                bsr.w   Boss_SharpssteelFillBladeTargetHistory
; End of function Boss_SharpssteelWaitForTwoBladeTriggersState
; Holds the pre-selection delay while updating the blade pose
Boss_SharpssteelAttackSelectionDelayState:              ; DATA XREF: ROM:00047C78   o  ; was: sub_47F02
                subq.w  #1,$11C(a5)
                bpl.s   Boss_SharpssteelUpdateAttackSelectionDelayPose
                clr.b   (BossColorEffectFlags).w
                move.w  #$B,$35C(a5)
                bra.w   Boss_SharpssteelAdvanceAttackSelection
; ---------------------------------------------------------------------------
Boss_SharpssteelUpdateAttackSelectionDelayPose:         ; CODE XREF: Boss_SharpssteelAttackSelectionDelayState+4   j
                bsr.w   Boss_SharpssteelLoadBladeTargetHistoryTail
                lea     Boss_SharpssteelAssemblyDelayPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; End of function Boss_SharpssteelAttackSelectionDelayState
; Publishes two blade-part coordinates to the shared target words
Boss_SharpssteelPublishBladePartTargets:                ; CODE XREF: Boss_SharpssteelWaitForTwoBladeTriggersState+2C   p  ; was: sub_47F24
                move.w  $370(a5),d0
                addi.w  #0,d0
                move.w  d0,(Entity59XPos).w
                move.w  $374(a5),d0
                addi.w  #-$10,d0
                move.w  d0,(Entity59YPos).w
                rts
; End of function Boss_SharpssteelPublishBladePartTargets
; Initializes the vertical opening and later ten-shot falling-projectile cycle
Boss_SharpssteelInitializeFallingShotCycle:             ; CODE XREF: Boss_SharpssteelWaitForPlayerAfterBladeEntranceState+30   p  ; was: sub_47F3E
                                        ; Boss_SharpssteelOpeningVerticalTurnState+F0   p
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$C7A0,$48(a5)
                move.w  #$C7A0,$4A(a5)
                move.w  #$120,$194(a5)
                move.w  #$120,$190(a5)
                move.b  #$10,(PlayerOAMBucketOffset).w
                move.l  #$E00000,$2FC(a5)
                bsr.w   Boss_SharpssteelDisableCoreSegmentCollision
                move.w  #$FFD8,$35E(a5)
                move.w  #0,$3BC(a5)
                move.w  #1,$3BE(a5)
                clr.w   $56(a5)
                bsr.w   Boss_SharpssteelConfigureBladeGraphicsSetB
                bsr.w   Boss_SharpssteelClearBladePartPriorityBits
                moveq   #$18,d0
                bsr.w   Boss_SharpssteelSetInnerBladeGroupSizes
                moveq   #$18,d0
                bra.w   Boss_SharpssteelSelectOuterBladeGroup
; End of function Boss_SharpssteelInitializeFallingShotCycle
; Loads the sixth blade-target history sample into the active target field
Boss_SharpssteelLoadBladeTargetHistoryTail:             ; CODE XREF: Boss_SharpssteelAttackSelectionDelayState:Boss_SharpssteelUpdateAttackSelectionDelayPose   p  ; was: sub_47F9C
                                        ; Boss_SharpssteelInitializeAttackSelection+10   p
                move.w  (SharpssteelTargetTail).w,$190(a5)
; End of function Boss_SharpssteelLoadBladeTargetHistoryTail
; Derives the blade target velocity from shared motion and the travel accumulator
Boss_SharpssteelUpdateBladeTargetVelocity:              ; CODE XREF: Boss_SharpssteelAccelerateBladeAssemblyState+10   p  ; was: sub_47FA2
                                        ; Boss_SharpssteelAccelerateBladeAssemblyState+3A   p
                move.w  (Entity57YPos).w,d0
                add.w   $2FC(a5),d0
                addi.w  #-$C,d0
                move.w  d0,$194(a5)
                rts
; End of function Boss_SharpssteelUpdateBladeTargetVelocity
; Fills all six blade-target history samples with the current shared target
Boss_SharpssteelFillBladeTargetHistory:                 ; CODE XREF: Boss_SharpssteelWaitForTwoBladeTriggersState+66   p  ; was: sub_47FB4
                movea.w #(SharpssteelTargetTrail-M68K_RAM),a0
                move.w  (Entity57XPos).w,d1
                addi.w  #$74,d1                         ; 't'
                moveq   #5,d7
Boss_SharpssteelFillBladeTargetHistoryLoop:             ; CODE XREF: Boss_SharpssteelFillBladeTargetHistory+10   j
                move.w  d1,(a0)+
                dbf     d7,Boss_SharpssteelFillBladeTargetHistoryLoop
                rts
; End of function Boss_SharpssteelFillBladeTargetHistory
; Shifts a new shared target through the six-sample blade history
Boss_SharpssteelShiftBladeTargetHistory:                ; CODE XREF: Boss_SharpssteelMain+2C   p  ; was: sub_47FCA
                movea.w #(SharpssteelTargetTrail-M68K_RAM),a0
                move.w  (Entity57XPos).w,d1
                addi.w  #$74,d1                         ; 't'
                moveq   #5,d7
Boss_SharpssteelShiftBladeTargetHistoryLoop:            ; CODE XREF: Boss_SharpssteelShiftBladeTargetHistory+14   j
                move.w  (a0),d0
                move.w  d1,(a0)+
                move.w  d0,d1
                dbf     d7,Boss_SharpssteelShiftBladeTargetHistoryLoop
                rts
; End of function Boss_SharpssteelShiftBladeTargetHistory
; Selects alternating horizontal targets, accelerates toward them, and updates blade pose
Boss_SharpssteelUpdateHorizontalAttackMotion:           ; CODE XREF: Boss_SharpssteelRunBladeEntranceDelayState+6   p  ; was: sub_47FE4
                                        ; Boss_SharpssteelWaitForPlayerAfterBladeEntranceState+6   p
                btst    #0,$23E(a5)
                beq.s   Boss_SharpssteelUpdateHorizontalTargetAndVelocity
                moveq   #2,d7
                move.w  $2B0(a5),d5
                bsr.w   Boss_SharpssteelSpawnRandomAngleShots
Boss_SharpssteelUpdateHorizontalTargetAndVelocity:      ; CODE XREF: Boss_SharpssteelUpdateHorizontalAttackMotion+6   j
                move.w  $10(a5),d0
                move.l  $198(a5),d1
                tst.w   $11C(a5)
                bmi.s   Boss_SharpssteelHandleLeftwardTarget
                cmp.w   $11E(a5),d0
                bmi.s   Boss_SharpssteelAccelerateHorizontalMotionRight
                move.w  #$FFFF,$11C(a5)
                move.w  (RandomNumberState).w,d0
                andi.w  #$7F,d0
                addq.w  #8,d0
                neg.w   d0
                add.w   $10(a5),d0
                move.w  d0,$11E(a5)
                cmpi.w  #$B0,d0
                bpl.s   Boss_SharpssteelStoreLeftwardVelocity
                move.w  #$B0,$11E(a5)
                bra.s   Boss_SharpssteelStoreLeftwardVelocity
; ---------------------------------------------------------------------------
Boss_SharpssteelAccelerateHorizontalMotionRight:        ; CODE XREF: Boss_SharpssteelUpdateHorizontalAttackMotion+24   j
                tst.l   d1
                bmi.s   Boss_SharpssteelStoreRightwardVelocity
                cmpi.l  #$10000,d1
                bpl.s   Boss_SharpssteelUseHighSpeedBladePose
Boss_SharpssteelStoreRightwardVelocity:                 ; CODE XREF: Boss_SharpssteelUpdateHorizontalAttackMotion+50   j
                                        ; Boss_SharpssteelUpdateHorizontalAttackMotion+8E   j
                addi.l  #$E00,d1
                move.l  d1,$198(a5)
                lea     Boss_SharpssteelRightwardPoseCommands(pc),a1
                nop
                rts
; ---------------------------------------------------------------------------
Boss_SharpssteelHandleLeftwardTarget:                   ; CODE XREF: Boss_SharpssteelUpdateHorizontalAttackMotion+1E   j
                cmp.w   $11E(a5),d0
                bpl.s   Boss_SharpssteelAccelerateHorizontalMotionLeft
                move.w  #1,$11C(a5)
                move.w  (RandomNumberState).w,d0
                andi.w  #$3F,d0                         ; '?'
                addq.w  #8,d0
                add.w   $10(a5),d0
                move.w  d0,$11E(a5)
                cmpi.w  #$160,d0
                bmi.s   Boss_SharpssteelStoreRightwardVelocity
                move.w  #$160,$11E(a5)
                bra.s   Boss_SharpssteelStoreRightwardVelocity
; ---------------------------------------------------------------------------
Boss_SharpssteelAccelerateHorizontalMotionLeft:         ; CODE XREF: Boss_SharpssteelUpdateHorizontalAttackMotion+70   j
                tst.l   d1
                bpl.s   Boss_SharpssteelStoreLeftwardVelocity
                cmpi.l  #$FFFE2000,d1
                bmi.s   Boss_SharpssteelUseHighSpeedBladePose
Boss_SharpssteelStoreLeftwardVelocity:                  ; CODE XREF: Boss_SharpssteelUpdateHorizontalAttackMotion+44   j
                                        ; Boss_SharpssteelUpdateHorizontalAttackMotion+4C   j
                subi.l  #$2000,d1
                move.l  d1,$198(a5)
Boss_SharpssteelUseHighSpeedBladePose:                  ; CODE XREF: Boss_SharpssteelUpdateHorizontalAttackMotion+58   j
                                        ; Boss_SharpssteelUpdateHorizontalAttackMotion+A2   j
                lea     Boss_SharpssteelHighSpeedPoseCommands(pc),a1
                nop
                rts
; End of function Boss_SharpssteelUpdateHorizontalAttackMotion
; Emits the requested count of generic shots at randomized angles
Boss_SharpssteelSpawnRandomAngleShots:                  ; CODE XREF: Boss_SharpssteelUpdateHorizontalAttackMotion+E   p  ; was: sub_4809A
                move.w  #$150,d6
                movea.w #(RandomNumberState-M68K_RAM),a4
Boss_SharpssteelSpawnRandomAngleShotsLoop:              ; CODE XREF: Boss_SharpssteelSpawnRandomAngleShots+1A   j
                move.b  (a4)+,d4
                andi.w  #$3E,d4                         ; '>'
                addi.w  #$120,d4
                jsr     (Projectile_SpawnType1A8AtAngle).l
                bne.s   Boss_SharpssteelFinishRandomAngleShotEmission
                dbf     d7,Boss_SharpssteelSpawnRandomAngleShotsLoop
Boss_SharpssteelFinishRandomAngleShotEmission:          ; CODE XREF: Boss_SharpssteelSpawnRandomAngleShots+18   j
                move.b  #$4C,d0                         ; 'L'
                jmp     (Sound_QueueSFXRequest).l
; End of function Boss_SharpssteelSpawnRandomAngleShots
; Enters the distance-based attack selector after the inter-cycle delay
Boss_SharpssteelInitializeAttackSelection:              ; CODE XREF: Boss_SharpssteelFallingShotCycleState+38   j  ; was: sub_480C2
                move.w  #$2A,4(a5)                      ; '*'
                clr.w   $23E(a5)
; Chooses another attack cycle or updates the idle selection pose
Boss_SharpssteelSelectDistanceAttackState:              ; DATA XREF: ROM:00047C86   o  ; was: loc_480CC
                tst.w   $23E(a5)
                bne.s   Boss_SharpssteelAdvanceAttackSelection
                bsr.w   Boss_SharpssteelLoadBladeTargetHistoryTail
                lea     Boss_SharpssteelAssemblyDelayPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelAdvanceAttackSelection:                 ; CODE XREF: Boss_SharpssteelAttackSelectionDelayState+10   j
                                        ; Boss_SharpssteelInitializeAttackSelection+E   j
                subq.w  #1,$35C(a5)
                bpl.s   Boss_SharpssteelChooseAttackByPlayerDistance
                move.w  (RandomNumberState).w,d0
                andi.w  #$1F,d0
                addi.w  #$20,d0                         ; ' '
                move.w  d0,$11C(a5)
                move.b  (RandomNumberState).w,d0
                andi.w  #1,d0
                addq.w  #1,d0
                move.w  d0,$35C(a5)
                bra.w   Boss_SharpssteelInitializeDiveAttack
; ---------------------------------------------------------------------------
Boss_SharpssteelChooseAttackByPlayerDistance:           ; CODE XREF: Boss_SharpssteelInitializeAttackSelection+22   j
                jsr     (Physics_GetPlayerDelta).l
                move.b  (RandomNumberState).w,d2
                clr.w   $54(a5)
                tst.w   d1
                bmi.w   Boss_SharpssteelCheckPlayerHorizontalDistance
                move.w  #$100,$54(a5)
Boss_SharpssteelCheckPlayerHorizontalDistance:          ; CODE XREF: Boss_SharpssteelInitializeAttackSelection+56   j
                cmpi.w  #$3C,d0                         ; '<'
                bpl.s   Boss_SharpssteelSelectFarRangeBladeAttack
                bra.w   Boss_SharpssteelInitializeCloseRangeBladeAttack
; ---------------------------------------------------------------------------
Boss_SharpssteelSelectFarRangeBladeAttack:              ; CODE XREF: Boss_SharpssteelInitializeAttackSelection+64   j
                bra.w   *+4
; ---------------------------------------------------------------------------
Boss_SharpssteelInitializeFarRangeBladeAttack:          ; CODE XREF: Boss_SharpssteelInitializeAttackSelection:Boss_SharpssteelSelectFarRangeBladeAttack   j
                move.w  #$20,4(a5)                      ; ' '
                clr.w   $58(a5)
                clr.w   $23E(a5)
                move.w  #$FFFF,$C(a5)
                bsr.w   Boss_SharpssteelClearBladePartPriorityBits
                moveq   #$40,d0                         ; '@'
                bsr.w   Boss_SharpssteelSetInnerBladeGroupSizes
; End of function Boss_SharpssteelInitializeAttackSelection
; Runs the far-range blade attack and its animation-triggered hitbox/flash events
Boss_SharpssteelFarRangeBladeAttackState:               ; DATA XREF: ROM:00047C7C   o  ; was: sub_4814E
                tst.w   $58(a5)
                bmi.w   Boss_SharpssteelAdvanceAttackSelection
                btst    #0,$23E(a5)
                beq.s   Boss_SharpssteelTriggerFarRangeBladeHitbox
                bsr.w   Boss_SharpssteelSetBladeGroupAPriorityBits
                move.w  #$A7,d1
                bsr.w   Boss_SharpssteelEnableInnerBladeHitboxes
                move.b  #$D1,d0
                jsr     (Sound_QueueSFXRequest).l
Boss_SharpssteelTriggerFarRangeBladeHitbox:             ; CODE XREF: Boss_SharpssteelFarRangeBladeAttackState+E   j
                btst    #1,$23E(a5)
                beq.s   Boss_SharpssteelUpdateFarRangeBladePose
                bsr.w   Boss_SharpssteelDisableInnerBladeHitboxes
Boss_SharpssteelUpdateFarRangeBladePose:                ; CODE XREF: Boss_SharpssteelFarRangeBladeAttackState+2C   j
                bsr.w   Boss_SharpssteelLoadBladeTargetHistoryTail
                lea     Boss_SharpssteelFarRangeAttackPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelInitializeCloseRangeBladeAttack:        ; CODE XREF: Boss_SharpssteelInitializeAttackSelection+66   j
                move.w  #$36,4(a5)                      ; '6'
                clr.w   $58(a5)
                clr.w   $23E(a5)
                move.w  #$FFFF,$C(a5)
                bsr.w   Boss_SharpssteelClearBladePartPriorityBits
                moveq   #$10,d0
                bsr.w   Boss_SharpssteelSetInnerBladeGroupSizes
; End of function Boss_SharpssteelFarRangeBladeAttackState
; Runs the close-range blade attack and its animation-triggered hitbox/flash events
Boss_SharpssteelCloseRangeBladeAttackState:             ; DATA XREF: ROM:00047C92   o  ; was: sub_481AC
                tst.w   $58(a5)
                bmi.w   Boss_SharpssteelAdvanceAttackSelection
                btst    #0,$23E(a5)
                beq.s   Boss_SharpssteelTriggerCloseRangeBladeHitbox
                bsr.w   Boss_SharpssteelSetBladeGroupAPriorityBits
                move.w  #$82,d1
                bsr.w   Boss_SharpssteelEnableInnerBladeHitboxes
                move.b  #$DC,d0
                jsr     (Sound_QueueSFXRequest).l
Boss_SharpssteelTriggerCloseRangeBladeHitbox:           ; CODE XREF: Boss_SharpssteelCloseRangeBladeAttackState+E   j
                btst    #1,$23E(a5)
                beq.s   Boss_SharpssteelUpdateCloseRangeBladePose
                bsr.w   Boss_SharpssteelDisableInnerBladeHitboxes
                bsr.w   Boss_SharpssteelSetOuterBladeGroupSizes
Boss_SharpssteelUpdateCloseRangeBladePose:              ; CODE XREF: Boss_SharpssteelCloseRangeBladeAttackState+2C   j
                bsr.w   Boss_SharpssteelLoadBladeTargetHistoryTail
                lea     Boss_SharpssteelCloseRangeAttackPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; End of function Boss_SharpssteelCloseRangeBladeAttackState
; Initializes the vertical dive attack, blade pose, collision, and palette state
Boss_SharpssteelInitializeDiveAttack:                   ; CODE XREF: Boss_SharpssteelInitializeAttackSelection+42   j  ; was: sub_481F0
                move.w  #$22,4(a5)                      ; '"'
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $11E(a5)
                clr.w   $54(a5)
                move.w  #6,$35E(a5)
                move.w  #0,$3BC(a5)
                move.w  #2,$3BE(a5)
                move.w  #$C6E0,$48(a5)
                move.w  #$C6E0,$4A(a5)
                clr.l   $D8(a5)
                move.l  #$FFFDC000,$DC(a5)
                bsr.w   Boss_SharpssteelDisableCoreSegmentCollision
                bsr.w   Boss_SharpssteelClearBladeGroupAPriorityBits
                bsr.w   Boss_SharpssteelClearBladeGroupBPriorityBits
                bsr.w   Boss_SharpssteelClearBladePartPriorityBits
                bsr.w   Boss_SharpssteelSetOuterBladeGroupSizes
; End of function Boss_SharpssteelInitializeDiveAttack
; Advances the vertical dive, spawning its one-shot effect after crossing Y $160
Boss_SharpssteelDiveAttackState:                        ; DATA XREF: ROM:00047C7E   o  ; was: sub_48246
                cmpi.w  #$200,$14(a5)
                bpl.w   Boss_SharpssteelStopAfterDive
                addi.l  #$4000,$DC(a5)
                tst.w   $11E(a5)
                bne.s   Boss_SharpssteelUpdateDiveAttackPose
                cmpi.w  #$160,$14(a5)
                bmi.s   Boss_SharpssteelUpdateDiveAttackPose
                addq.w  #1,$11E(a5)
                move.w  $10(a5),d5
                move.w  #$150,d6
                moveq   #$60,d3                         ; '`'
                clr.w   (GlobalSpritePriorityBit).w
                jsr     (Projectile_SpawnFourDirectionalShotsWithSubtypeInD3).l
                move.w  #$8000,(GlobalSpritePriorityBit).w
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_QueueSFXRequest).l
Boss_SharpssteelUpdateDiveAttackPose:                   ; CODE XREF: Boss_SharpssteelDiveAttackState+16   j
                                        ; Boss_SharpssteelDiveAttackState+1E   j
                lea     Boss_SharpssteelDivePoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; End of function Boss_SharpssteelDiveAttackState
; Stops vertical motion and initializes the fixed post-dive delay
Boss_SharpssteelInitializePostDiveDelay:                ; CODE XREF: Boss_SharpssteelOpeningVerticalTurnState+DC   j  ; was: sub_48298
                move.w  (RandomNumberState).w,d0
                move.w  #$F,d0
                addi.w  #$10,d0
                move.w  d0,$11C(a5)
Boss_SharpssteelStopAfterDive:                          ; CODE XREF: Boss_SharpssteelDiveAttackState+6   j
                move.w  #$24,4(a5)                      ; '$'
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                bsr.w   Boss_SharpssteelDisableCoreSegmentCollision
; End of function Boss_SharpssteelInitializePostDiveDelay
; Waits after the dive, then selects a falling-shot cycle or the next phase
Boss_SharpssteelPostDiveDelayState:                     ; DATA XREF: ROM:00047C80   o  ; was: sub_482C2
                subq.w  #1,$11C(a5)
                bpl.w   Boss_SharpssteelStateReturn
Boss_SharpssteelSelectPostDiveCycle:                    ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+112   j
                subq.w  #1,$35C(a5)
                bpl.s   Boss_SharpssteelInitializeFallingShotCycleFromDelay
                move.b  (RandomNumberState).w,d0
                andi.w  #3,d0
                addq.w  #6,d0
                move.w  d0,$35C(a5)
                bra.w   Boss_SharpssteelInitializeFallingShotCycleFromSelection
; ---------------------------------------------------------------------------
Boss_SharpssteelInitializeFallingShotCycleFromDelay:    ; CODE XREF: Boss_SharpssteelPostDiveDelayState+C   j
                move.w  #6,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$120,$D0(a5)
                move.w  #$190,$D4(a5)
                clr.w   $56(a5)
                move.w  #$C6E0,$48(a5)
                move.w  #$C6E0,$4A(a5)
                clr.l   $D8(a5)
                move.l  #$FFF80000,$DC(a5)
                move.w  #$FFE4,$35E(a5)
                move.w  #1,$3BC(a5)
                move.w  #1,$3BE(a5)
                bsr.w   Boss_SharpssteelConfigureBladeGraphicsSetB
                bsr.w   Boss_SharpssteelClearBladePartPriorityBits
                bsr.w   Boss_SharpssteelSetOuterBladeGroupSizes
                bsr.w   Boss_SharpssteelSpawnTenFallingShots
                move.b  #$4C,d0                         ; 'L'
                jsr     (Sound_QueueSFXRequest).l
; End of function Boss_SharpssteelPostDiveDelayState
; Turns the opening vertical motion before the blade-assembly sweep
Boss_SharpssteelOpeningVerticalTurnState:               ; DATA XREF: ROM:00047C62   o  ; was: sub_48346
                addi.l  #$1400,$DC(a5)
                bpl.s   Boss_SharpssteelFinishOpeningVerticalTurn
                lea     Boss_SharpssteelOpeningTurnPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelFinishOpeningVerticalTurn:              ; CODE XREF: Boss_SharpssteelOpeningVerticalTurnState+8   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$100,$56(a5)
                bsr.w   Boss_SharpssteelConfigureBladeGraphicsSetB
                bsr.w   Boss_SharpssteelSetBladePartPriorityBits
                bsr.w   Boss_SharpssteelEnableCoreSegmentCollision
; Moves the blade assembly to the shared vertical threshold
Boss_SharpssteelMoveBladeAssemblyToThresholdState:      ; DATA XREF: ROM:00047C64   o  ; was: loc_4837A
                addi.l  #$2000,$DC(a5)
                move.w  (Entity57YPos).w,d0
                subi.w  #$20,d0                         ; ' '
                cmp.w   $D4(a5),d0
                bmi.s   Boss_SharpssteelBeginBladeAssemblySweep
                lea     Boss_SharpssteelAssemblyThresholdPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelBeginBladeAssemblySweep:                ; CODE XREF: Boss_SharpssteelOpeningVerticalTurnState+48   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $11E(a5)
                move.w  #8,(PlaneAShakeLevel).w
                move.w  #4,(PlaneBShakeLevel).w
                move.b  #$2F,d0                         ; '/'
                jsr     (Sound_QueueSFXRequest).l
                move.l  #$20000,(Entity57YVel).w
                move.w  #2,(Entity57Work58).w
                moveq   #0,d0
                move.w  #$B0,d0
                sub.w   (Entity57XPos).w,d0
                swap    d0
                asr.l   #5,d0
                move.l  d0,$D8(a5)
                move.l  #$FFFD8000,$DC(a5)
; Sweeps the blade assembly through the player-height trigger and lower bound
Boss_SharpssteelBladeAssemblySweepState:                ; DATA XREF: ROM:00047C66   o  ; was: loc_483EA
                addi.l  #$3A00,$DC(a5)
                tst.w   $11E(a5)
                bne.s   Boss_SharpssteelUpdateBladeAssemblySweepPose
                cmpi.w  #$160,$D4(a5)
                bmi.s   Boss_SharpssteelUpdateBladeAssemblySweepPose
                addq.w  #1,$11E(a5)
                move.w  $10(a5),d5
                move.w  #$150,d6
                jsr     (Projectile_SpawnFourDirectionalShots).l
                move.b  #$4C,d0                         ; 'L'
                jsr     (Sound_QueueSFXRequest).l
Boss_SharpssteelUpdateBladeAssemblySweepPose:           ; CODE XREF: Boss_SharpssteelOpeningVerticalTurnState+B0   j
                                        ; Boss_SharpssteelOpeningVerticalTurnState+B8   j
                cmpi.w  #$240,$D4(a5)
                bpl.w   Boss_SharpssteelInitializePostDiveDelay
                lea     Boss_SharpssteelAssemblySweepPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelInitializeFallingShotCycleFromSelection:  ; CODE XREF: Boss_SharpssteelPostDiveDelayState+1C   j
                move.w  #$26,4(a5)                      ; '&'
                bsr.w   Boss_SharpssteelInitializeFallingShotCycle
; End of function Boss_SharpssteelOpeningVerticalTurnState
; Runs the falling-shot cycle until its fixed-point travel accumulator expires
Boss_SharpssteelFallingShotCycleState:                  ; DATA XREF: ROM:00047C82   o  ; was: sub_4843A
                subi.l  #$22000,$2FC(a5)
                bmi.s   Boss_SharpssteelFinishFallingShotCycle
                cmpi.w  #$60,$2FC(a5)                   ; '`'
                bmi.s   Boss_SharpssteelUpdateFallingShotCyclePose
                bsr.w   Boss_SharpssteelFallingShotCycleThresholdHook
Boss_SharpssteelUpdateFallingShotCyclePose:             ; CODE XREF: Boss_SharpssteelFallingShotCycleState+10   j
                bsr.w   Boss_SharpssteelLoadBladeTargetHistoryTail
                lea     Boss_SharpssteelAssemblyDelayPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelFinishFallingShotCycle:                 ; CODE XREF: Boss_SharpssteelFallingShotCycleState+8   j
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                move.b  #$10,$E1(a5)
; Waits before entering the distance-based attack selector
Boss_SharpssteelWaitBeforeAttackSelectionState:         ; DATA XREF: ROM:00047C84   o  ; was: loc_4846E
                subq.w  #1,$11C(a5)
                bmi.w   Boss_SharpssteelInitializeAttackSelection
                bsr.w   Boss_SharpssteelLoadBladeTargetHistoryTail
                lea     Boss_SharpssteelAssemblyDelayPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; End of function Boss_SharpssteelFallingShotCycleState
Boss_SharpssteelFallingShotCycleThresholdHook:          ; CODE XREF: Boss_SharpssteelFallingShotCycleState+12   p
                rts
; End of function Boss_SharpssteelFallingShotCycleThresholdHook

; Initializes state $2C and its position, velocity, hitboxes, and animation data
Boss_SharpssteelInitializeComplexPhase:
                move.w  #$2C,4(a5)                      ; ','  ; was: sub_48486
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  (Entity57XPos).w,d0
                addi.w  #$74,d0                         ; 't'
                move.w  d0,$10(a5)
                move.w  #$200,$14(a5)
                clr.w   $56(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.l   $18(a5)
                move.l  #$FFFD0000,$1C(a5)
                bsr.w   Boss_SharpssteelConfigureBladeGraphicsSetB
                bsr.w   Boss_SharpssteelSetBladePartPriorityBits
                movea.l #Boss_SharpssteelComplexPhaseInitialPose,a0
                bsr.w   Boss_SharpssteelInitializeBladePoseChannels
                move.w  #$FFD8,$35E(a5)
                move.w  #0,$3BC(a5)
                move.w  #1,$3BE(a5)
; End of function Boss_SharpssteelInitializeComplexPhase
