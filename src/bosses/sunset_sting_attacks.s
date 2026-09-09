; Main boss control routine with state machine dispatch
Boss_SunsetStingMainDispatcher:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_418FC
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   Boss_SunsetStingDispatchSecondFormState
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0                         ; '?'
                beq.s   Boss_SunsetStingRefreshAimSample
                lea     (word_FFA400).w,a4
                jsr     (Physics_CalculateAngleToTarget).l
                move.b  d0,(byte_FFC73E).w
                move.b  d0,(dword_FFC6DC+1).w
                bra.s   Boss_SunsetStingDispatchSecondFormState
; ---------------------------------------------------------------------------
Boss_SunsetStingRefreshAimSample:                       ; CODE XREF: Boss_SunsetStingMainDispatcher+12   j  ; was: loc_41924
                lea     (word_FFA400).w,a4
                jsr     (Physics_CalculateAngleToTarget).l
                move.b  d0,(dword_FFC6DC+1).w
Boss_SunsetStingDispatchSecondFormState:                ; CODE XREF: Boss_SunsetStingMainDispatcher+8   j  ; was: loc_41932
                                        ; Boss_SunsetStingMainDispatcher+26   j
                moveq   #4,d7
                jsr     (Gfx_InitPaletteFade).l
                move.w  4(a5),d0
                lea     Boss_SunsetStingSecondFormStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingMainDispatcher
; ---------------------------------------------------------------------------
Boss_SunsetStingSecondFormStates:
                dc.w    Boss_SunsetStingSecondFormInitializeState-*  ; DATA XREF: Boss_SunsetStingMainDispatcher+42   o  ; was: off_41946
                dc.w    Boss_SunsetStingSecondFormLoadGraphicsState-*
                dc.w    Boss_SunsetStingQueueSecondFormIntroMessageState-*
                dc.w    Boss_SunsetStingWaitForSecondFormIntroMessageState-*
                dc.w    Boss_SunsetStingBeginMovementState-*
                dc.w    Boss_SunsetStingUpdateMovement-*
                dc.w    Boss_SunsetStingApplyPosePatternBState-*
                dc.w    Boss_SunsetStingApplyPosePatternCState-*
                dc.w    Boss_SunsetStingCheckHealthThreshold-*
                dc.w    Boss_SunsetStingApplyPosePatternAState-*
                dc.w    Boss_SunsetStingApplyPosePatternCState-*
                dc.w    Boss_SunsetStingCheckHealthThreshold-*
                dc.w    Boss_SunsetStingMoveAndShoot_AttackLoop-*
                dc.w    Boss_SunsetStingOscillateChainsState-*
                dc.w    Boss_SunsetStingRefillHealthState-*
                dc.w    Boss_SunsetStingDescendAndActivateChainsState-*
                dc.w    Boss_SunsetStingWaitThenActivateTrailState-*
                dc.w    Boss_SunsetStingContractTrailState-*
                dc.w    Boss_SunsetStingFinishTrailTransitionState-*
Boss_SunsetStingBodyPartSpriteDescriptorA:
                dc.w    $C82C, $D00, $F8F0              ; DATA XREF: ROM:Boss_SunsetStingSecondFormBodyPartInitTable   o  ; was: word_4196C
                                        ; ROM:0004259A   o
Boss_SunsetStingBodyPartSpriteDescriptorB:
                dc.w    $C834, $500, $F8F8              ; DATA XREF: ROM:000425FA   o  ; was: word_41972
                                        ; ROM:00042602   o
Boss_SunsetStingBodyPartSpriteDescriptorC:
                dc.w    $C851, 0, $FCFC                 ; DATA XREF: ROM:000425B6   o  ; was: word_41978
                                        ; ROM:000425C6   o
Boss_SunsetStingBodyPartSpriteDescriptorD:
                dc.w    $C852, 0, $FCFC                 ; DATA XREF: ROM:000425D6   o  ; was: word_4197E
                                        ; ROM:000425E6   o

; Initializes boss state, clears sprites, sets starting position
Boss_SunsetStingSecondFormInitializeState:              ; DATA XREF: ROM:Boss_SunsetStingSecondFormStates   o  ; was: sub_41984
                clr.b   (dword_FFC6DC).w
                move.w  #$1C8,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                addq.w  #2,4(a5)
                move.b  #$80,$4B(a5)
                clr.w   (word_FFC67E).w
                clr.w   (word_FFC678).w
                move.l  #$1C00000,$10(a5)
                move.l  #$2000000,$14(a5)
                rts
; End of function Boss_SunsetStingSecondFormInitializeState
; Loads boss graphics tiles, palettes, and body parts
Boss_SunsetStingSecondFormLoadGraphicsState:            ; DATA XREF: ROM:00041948   o  ; was: sub_419B8
                tst.w   (word_FFF720).w
                bmi.w   Boss_SunsetStingSecondFormLoadGraphicsReturn
                addq.w  #2,4(a5)
                movea.l #Boss_SunsetStingSecondFormObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                moveq   #6,d7
                jsr     (Data_LoadPaletteTable).l
                move.w  (a5),-(sp)
                move.w  #$3300,$E(a5)
                lea     Boss_SunsetStingSecondFormBodyPartInitTable(pc),a1
                lea     (a5),a4
                jsr     (Boss_SunsetStingInitBodyParts).l
                jsr     Boss_SunsetStingInitTrail(pc)   ; (pc)
                nop
                move.w  (sp)+,(a5)
                ori.w   #$100,$482(a5)
                ori.w   #$100,$6C2(a5)
                ori.w   #$100,$902(a5)
                ori.w   #$100,$B42(a5)
                move.w  #$D00,2(a5)
                lea     (a5),a1
                move.w  (word_FFC67C).w,d3
                subq.w  #1,d3
Boss_SunsetStingInitializeSecondFormPartPositions:      ; CODE XREF: Boss_SunsetStingSecondFormLoadGraphicsState+76   j  ; was: loc_41A1A
                move.l  #$1C00000,$10(a1)
                move.l  #$1C00000,$14(a1)
                adda.w  #$60,a1                         ; '`'
                dbf     d3,Boss_SunsetStingInitializeSecondFormPartPositions
                move.l  #$FFFF0000,$18(a5)
                move.b  #$18,(byte_FFC79C).w
                move.b  (byte_FFC79C).w,(word_FFC7F8+1).w
                move.b  #$FF,(byte_FFC7FC).w
                move.w  #$180,$56(a5)
                movea.l #Boss_SunsetStingSecondFormTileLoadCommands,a0
                jsr     (Gfx_LoadCompressedTiles).l
Boss_SunsetStingSecondFormLoadGraphicsReturn:           ; CODE XREF: Boss_SunsetStingSecondFormLoadGraphicsState+4   j  ; was: locret_41A5E
                rts
; End of function Boss_SunsetStingSecondFormLoadGraphicsState
; ---------------------------------------------------------------------------
Boss_SunsetStingSecondFormTileLoadCommands:
                dc.w    $6100, $2000, $202, $595A, $5B5D, $5E5F, $6162, $63FF, $6306, $2000, 0, $5CFF, $6306, $2000, 0, $60FF  ; was: word_41A60
                                        ; DATA XREF: Boss_SunsetStingSecondFormLoadGraphicsState+9A   o
                dc.w    $6306, $2000, 0, $64FF
Boss_SunsetStingSecondFormTileAnimationOffsets:
                dc.w    $1E, $FFE6, $FFEC, $FFF2, $FFE8, $FFDE, $FFE4, $FFEA, $FFE0, $FFD6, $FFD4, $FFD2, $FFD0, $FFCE, $FFCC, $FFCA  ; was: word_41A88
                                        ; DATA XREF: Boss_SunsetStingSecondFormUpdate+82   o
                dc.w    $FFC8

; Queues the second-form intro message after the preceding transition
Boss_SunsetStingQueueSecondFormIntroMessageState:       ; DATA XREF: ROM:0004194A   o  ; was: sub_41AAA
                tst.w   (word_FF80C2).w
                bne.w   Boss_SunsetStingSecondFormIntroUpdate
                moveq   #5,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                bra.w   Boss_SunsetStingSecondFormIntroUpdate
; End of function Boss_SunsetStingQueueSecondFormIntroMessageState
; Waits for the second-form intro message to complete before advancing
Boss_SunsetStingWaitForSecondFormIntroMessageState:     ; DATA XREF: ROM:0004194C   o  ; was: sub_41AC2
                tst.w   (word_FF80C2).w
                bne.s   Boss_SunsetStingSecondFormIntroUpdate
                clr.b   (byte_FF80EC).w
                addq.w  #2,4(a5)
Boss_SunsetStingSecondFormIntroUpdate:                  ; CODE XREF: Boss_SunsetStingQueueSecondFormIntroMessageState+4   j  ; was: loc_41AD0
                                        ; Boss_SunsetStingQueueSecondFormIntroMessageState+14   j
                bra.w   Boss_SunsetStingMovementUpdatePartFacing
; End of function Boss_SunsetStingWaitForSecondFormIntroMessageState
; Sets boss to attack state mode and transitions to main loop
Boss_SunsetStingBeginMovementState:                     ; DATA XREF: ROM:0004194E   o  ; was: sub_41AD4
                                        ; ROM:00041E44   o
                move.b  #4,$4B(a5)
                bra.w   Boss_SunsetStingInitializeMovementState
; End of function Boss_SunsetStingBeginMovementState
; Sets boss to idle state and initializes attack timer
Boss_SunsetStingSetIdleState:                           ; CODE XREF: Boss_SunsetStingMoveAndShoot+2A   j  ; was: sub_41ADE
                                        ; Boss_SunsetStingCheckPhaseTransition+8   j
                move.b  #$10,(byte_FFC79C).w
                move.b  #0,$4B(a5)
Boss_SunsetStingInitializeMovementState:                ; CODE XREF: Boss_SunsetStingBeginMovementState+6   j  ; was: loc_41AEA
                move.w  #$A,4(a5)
                clr.w   (word_FFC7F8).w
                move.b  (byte_FFC79C).w,(word_FFC7F8+1).w
                bsr.w   Boss_SunsetStingCalculateTargetDirection
                bra.w   Boss_SunsetStingMovementUpdateSelectedChain
; End of function Boss_SunsetStingSetIdleState
; Updates boss vertical movement tracking player
Boss_SunsetStingUpdateMovement:                         ; DATA XREF: ROM:00041950   o  ; was: sub_41B02
                move.w  #$10,d2
                move.w  #$F0,d0
                sub.w   $14(a5),d0
                move.b  (byte_FFC7FC).w,d1
                asl.w   #8,d1
                eor.w   d0,d1
                bpl.s   Boss_SunsetStingMovementNormalizeVerticalDelta
                neg.w   d2
Boss_SunsetStingMovementNormalizeVerticalDelta:         ; CODE XREF: Boss_SunsetStingUpdateMovement+14   j  ; was: loc_41B1A
                tst.w   d0
                bpl.s   Boss_SunsetStingMovementAdjustBodyAngle
                neg.w   d0
Boss_SunsetStingMovementAdjustBodyAngle:                ; CODE XREF: Boss_SunsetStingUpdateMovement+1A   j  ; was: loc_41B20
                cmpi.w  #$A,d0
                bcs.s   Boss_SunsetStingMovementUpdatePartFacing
                addi.w  #$100,d2
                lsr.w   #1,d2
                move.w  #1,d0
                move.w  $56(a5),d1
                lsr.w   #1,d1
                sub.b   d1,d2
                beq.s   Boss_SunsetStingMovementUpdatePartFacing
                bpl.s   Boss_SunsetStingMovementApplyBodyAngleStep
                neg.w   d0
Boss_SunsetStingMovementApplyBodyAngleStep:             ; CODE XREF: Boss_SunsetStingUpdateMovement+38   j  ; was: loc_41B3E
                add.w   d0,$56(a5)
Boss_SunsetStingMovementUpdatePartFacing:               ; CODE XREF: Boss_SunsetStingWaitForSecondFormIntroMessageState:Boss_SunsetStingSecondFormIntroUpdate   j  ; was: loc_41B42
                                        ; Boss_SunsetStingUpdateMovement+22   j
                tst.b   (byte_FFC7FC).w
                bpl.s   Boss_SunsetStingMovementFacePositive
                ori.w   #$800,$4EE(a5)
                ori.w   #$800,$72E(a5)
                andi.w  #$F7FF,$2AE(a5)
                andi.w  #$F7FF,$96E(a5)
                bra.w   Boss_SunsetStingMovementUpdatePosePatterns
; ---------------------------------------------------------------------------
Boss_SunsetStingMovementFacePositive:                   ; CODE XREF: Boss_SunsetStingUpdateMovement+44   j  ; was: loc_41B64
                ori.w   #$800,$2AE(a5)
                ori.w   #$800,$96E(a5)
                andi.w  #$F7FF,$4EE(a5)
                andi.w  #$F7FF,$72E(a5)
Boss_SunsetStingMovementUpdatePosePatterns:             ; CODE XREF: Boss_SunsetStingUpdateMovement+5E   j  ; was: loc_41B7C
                moveq   #$FFFFFFFF,d6
                move.b  (word_FFC7F8+1).w,d3
                move.b  (word_FFC7F8).w,d0
                lea     Boss_SunsetStingPrimaryTrackingPoseOffsets(pc),a3
                bsr.w   Boss_SunsetStingUpdatePartRotation
                move.b  (word_FFC7F8+1).w,d3
                move.b  (word_FFC7F8).w,d0
                eori.b  #$14,d0
                lea     Boss_SunsetStingSecondaryTrackingPoseOffsets(pc),a3
                bsr.w   Boss_SunsetStingUpdatePartRotation
                subq.b  #1,(word_FFC7F8+1).w
                bne.s   Boss_SunsetStingMovementUpdateActiveChain
                addq.b  #4,(word_FFC7F8).w
                andi.b  #$E,(word_FFC7F8).w
                move.b  (byte_FFC79C).w,(word_FFC7F8+1).w
                bsr.w   Boss_SunsetStingCalculateTargetDirection
                cmpi.w  #$A0,d0
                bhi.s   Boss_SunsetStingMovementTrySpawnProjectile
                tst.b   $4B(a5)
                bne.w   Boss_SunsetStingMovementDecrementShotDelay
                move.w  (word_FFC678).w,d0
                move.b  (byte_FFC7FC).w,d1
                andi.w  #4,d1
                eori.w  #4,d0
                eor.b   d0,d1
                andi.w  #4,d1
                bne.w   Boss_SunsetStingChooseMovementVariation
                move.b  #1,$4B(a5)
Boss_SunsetStingMovementDecrementShotDelay:             ; CODE XREF: Boss_SunsetStingUpdateMovement+C4   j  ; was: loc_41BEA
                subq.b  #1,$4B(a5)
Boss_SunsetStingMovementTrySpawnProjectile:             ; CODE XREF: Boss_SunsetStingUpdateMovement+BE   j  ; was: loc_41BEE
                move.w  d6,-(sp)
                bsr.w   Boss_SunsetStingSpawnRandomProjectile
                move.w  (sp)+,d6
Boss_SunsetStingMovementUpdateActiveChain:              ; CODE XREF: Boss_SunsetStingUpdateMovement+A4   j  ; was: loc_41BF6
                tst.w   d6
                bmi.s   Boss_SunsetStingMovementUpdateSelectedChain
                cmp.w   (word_FFC678).w,d6
                beq.s   Boss_SunsetStingMovementUpdateSelectedChain
                lea     Boss_SunsetStingChainRootOffsets(pc),a2
                movea.w (a2,d6.w),a4
                adda.w  a5,a4
                move.l  #word_EBEA0,$1E8(a4)
                move.w  (word_FFC678).w,d0
                move.w  d6,(word_FFC678).w
                movea.w (a2,d0.w),a4
                adda.w  a5,a4
                move.l  #word_EBE94,$1E8(a4)
Boss_SunsetStingMovementUpdateSelectedChain:            ; CODE XREF: Boss_SunsetStingSetIdleState+20   j  ; was: loc_41C28
                                        ; Boss_SunsetStingUpdateMovement+F6   j
                move.w  (word_FFC678).w,d6
                lea     Boss_SunsetStingChainRootOffsets(pc),a4
                movea.w (a4,d6.w),a4
                adda.l  a5,a4
                bsr.w   Boss_SunsetStingCalculateChainPosition
                bra.w   Boss_SunsetStingSecondFormUpdateBody
; End of function Boss_SunsetStingUpdateMovement
; ---------------------------------------------------------------------------
Boss_SunsetStingPrimaryTrackingPoseOffsets:
                dc.w    $2C, 0, $32, 0                  ; DATA XREF: Boss_SunsetStingUpdateMovement+84   o  ; was: word_41C3E
Boss_SunsetStingSecondaryTrackingPoseOffsets:
                dc.w    $42, 0, $34, 0, 8, 0, $E, 0, $40, $FFC0, $FFC0, $FFC0, $FFC0, $FFE0, $FFE0, $FFE0  ; was: word_41C46
                                        ; DATA XREF: Boss_SunsetStingUpdateMovement+98   o
                dc.w    $FFE0, $FFE0, 0, $20, $20, $20, $20, $FF80, $80, $80, $80, $80, 0, $FFE0, $FFE0, $FFE0
                dc.w    $FFE0, $80, $FF80, $FF80, $FF80, $FF80, 0, $40, $40, $40, $40, $FFE0, $FFC0, $FFC0, $FFC0, $FFC0
Boss_SunsetStingPosePatternC:
                dc.w    $1A, 0, $FFCA, 0                ; DATA XREF: Boss_SunsetStingApplyPosePatternCState   o  ; was: word_41CA6
                                        ; Boss_SunsetStingRefillHealthState:Boss_SunsetStingRefillApplyPoseToChain   o
Boss_SunsetStingPosePatternB:
                dc.w    8, 0, $E, 0, $60, $20, $20, $20, $20, $FFA0, $FFE0, $FFE0, $FFE0, $FFE0  ; was: word_41CAE
                                        ; DATA XREF: Boss_SunsetStingApplyPosePatternBState   o
Boss_SunsetStingPosePatternA:
                dc.w    $12, 0, 4, 0, $40, $60, $80, $A0, $C0, 0, 0, 0, 0, 0  ; was: word_41CCA
                                        ; DATA XREF: Boss_SunsetStingApplyPosePatternAState   o

; Calculates target direction based on player position
Boss_SunsetStingCalculateTargetDirection:               ; CODE XREF: Boss_SunsetStingSetIdleState+1C   p  ; was: sub_41CE6
                                        ; Boss_SunsetStingUpdateMovement+B6   p
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                move.b  d0,(byte_FFC7FD).w
                move.w  $14(a5),d0
                cmpi.w  #$120,d0
                bhi.s   Boss_SunsetStingTargetDirectionUseBodyAngle
                lea     (word_FFA400).w,a4
                move.w  dword_FFA410-word_FFA400(a4),d0
                sub.w   $10(a5),d0
                ext.l   d0
                bpl.s   Boss_SunsetStingTargetDirectionStoreDelta
                neg.w   d0
Boss_SunsetStingTargetDirectionStoreDelta:              ; CODE XREF: Boss_SunsetStingCalculateTargetDirection+26   j  ; was: loc_41D10
                add.b   d0,(byte_FFC7FD).w
                swap    d0
                move.b  d0,(byte_FFC7FC).w
                swap    d0
                rts
; ---------------------------------------------------------------------------
Boss_SunsetStingTargetDirectionUseBodyAngle:            ; CODE XREF: Boss_SunsetStingCalculateTargetDirection+16   j  ; was: loc_41D1E
                move.w  $56(a5),d0
                lsr.w   #1,d0
                ext.w   d0
                lsr.w   #8,d0
                move.b  d0,(byte_FFC7FC).w
                move.w  #$1FF,d0
                move.b  d0,(byte_FFC7FD).w
                rts
; End of function Boss_SunsetStingCalculateTargetDirection
; Gets pointer to specific body part based on angle
Boss_SunsetStingGetBodyPartPointer:                     ; CODE XREF: Boss_SunsetStingUpdatePartRotation:Boss_SunsetStingUpdatePartRotationForTarget   p  ; was: sub_41D36
                                        ; Boss_SunsetStingFlipAndAnimate+1E   p
                tst.b   (byte_FFC7FC).w
                bmi.s   Boss_SunsetStingResolveBodyPartIndex
                eori.b  #$10,d0
Boss_SunsetStingResolveBodyPartIndex:                   ; CODE XREF: Boss_SunsetStingGetBodyPartPointer+4   j  ; was: loc_41D40
                move.w  d0,d1
                lsr.w   #2,d0
                andi.w  #6,d0
                lea     Boss_SunsetStingChainRootOffsets(pc),a0
                movea.w (a0,d0.w),a4
                adda.l  a5,a4
                rts
; End of function Boss_SunsetStingGetBodyPartPointer
; Updates body part rotation angles with target tracking
Boss_SunsetStingUpdatePartRotation:                     ; CODE XREF: Boss_SunsetStingUpdateMovement+88   p  ; was: sub_41D54
                                        ; Boss_SunsetStingUpdateMovement+9C   p
                move.w  #$20,d2                         ; ' '
Boss_SunsetStingUpdatePartRotationForTarget:            ; CODE XREF: Boss_SunsetStingApplyPosePatternCState+14   p  ; was: loc_41D58
                                        ; Boss_SunsetStingRefillHealthState+26   p
                bsr.s   Boss_SunsetStingGetBodyPartPointer
                move.w  d1,-(sp)
                asl.w   #5,d1
                sub.w   d3,d1
                andi.w  #$FF,d1
                addi.b  #$40,d1                         ; '@'
                btst    #7,d1
                beq.s   Boss_SunsetStingApplyPartPoseSequence
                move.w  d0,d6
Boss_SunsetStingApplyPartPoseSequence:                  ; CODE XREF: Boss_SunsetStingUpdatePartRotation+18   j  ; was: loc_41D70
                move.w  (sp)+,d1
                andi.w  #6,d1
                lea     (a3,d1.w),a0
                adda.w  (a0),a0
                bsr.w   Boss_SunsetStingAnimatePartSequence
                rts
; End of function Boss_SunsetStingUpdatePartRotation
; Animates sequence of connected body parts
Boss_SunsetStingAnimatePartSequence:                    ; CODE XREF: Boss_SunsetStingUpdatePartRotation+28   p  ; was: sub_41D82
                lea     $60(a4),a1
                move.w  #4,d4
Boss_SunsetStingAnimatePartSequenceLoop:                ; CODE XREF: Boss_SunsetStingAnimatePartSequence+36   j  ; was: loc_41D8A
                move.w  (a0)+,d0
                ; Original immediate is $B; memory BTST uses its low three bits
                dc.w    $082C, $000B, $000E             ; btst #$B,$E(a4)
                beq.s   Boss_SunsetStingInterpolatePartPose
                neg.w   d0
Boss_SunsetStingInterpolatePartPose:                    ; CODE XREF: Boss_SunsetStingAnimatePartSequence+10   j  ; was: loc_41D96
                sub.w   $56(a1),d0
                ext.l   d0
                divs.w  d3,d0
                add.w   d0,$56(a1)
                move.w  #1,d0
                cmp.w   $4C(a1),d2
                beq.s   Boss_SunsetStingAdvancePartPose
                bpl.s   Boss_SunsetStingIncreasePartRadius
                neg.w   d0
Boss_SunsetStingIncreasePartRadius:                     ; CODE XREF: Boss_SunsetStingAnimatePartSequence+2A   j  ; was: loc_41DB0
                add.w   d0,$4C(a1)
Boss_SunsetStingAdvancePartPose:                        ; CODE XREF: Boss_SunsetStingAnimatePartSequence+28   j  ; was: loc_41DB4
                adda.w  #$60,a1                         ; '`'
                dbf     d4,Boss_SunsetStingAnimatePartSequenceLoop
                rts
; End of function Boss_SunsetStingAnimatePartSequence
; Spawns projectiles at random positions using jump table
Boss_SunsetStingSpawnRandomProjectile:                  ; CODE XREF: Boss_SunsetStingUpdateMovement+EE   p  ; was: sub_41DBE
                tst.w   (word_FFFF0E).w
                beq.w   Boss_SunsetStingSpawnRandomProjectileReturn
Boss_SunsetStingSpawnRandomProjectileFromPart:          ; CODE XREF: Boss_SunsetStingMoveAndShoot+26   p  ; was: loc_41DC6
                jsr     (RandomNumber).l
                andi.w  #6,d0
                movem.l a5,-(sp)
                lea     Boss_SunsetStingChainRootOffsets(pc),a2
                adda.w  d0,a2
                movea.w (a2)+,a5
                adda.l  (sp),a5
                adda.w  #$1E0,a5
                lea     (word_FFA400).w,a4
                jsr     (Physics_CalculateAngleToTarget).l
                movem.l d2/a2,-(sp)
                bsr.w   Boss_SunsetStingInitHomingProjectile
                movem.l (sp)+,d2/a2
                movem.l (sp)+,a5
Boss_SunsetStingSpawnRandomProjectileReturn:            ; CODE XREF: Boss_SunsetStingSpawnRandomProjectile+4   j  ; was: locret_41DFC
                rts
; End of function Boss_SunsetStingSpawnRandomProjectile
; Initializes homing projectile with angle offset
Boss_SunsetStingInitHomingProjectile:                   ; CODE XREF: Boss_SunsetStingSpawnRandomProjectile+32   p  ; was: sub_41DFE
                andi.w  #$FF,d0
                subi.b  #$40,d0                         ; '@'
                move.w  d0,-(sp)
                movea.w #(byte_FFD280-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckExtendedRange).l
                bne.s   Boss_SunsetStingInitHomingProjectileReturn
                move.w  (sp)+,d6
                add.w   d6,d6
                move.w  #0,d0
                move.w  #0,d1
                move.w  #$8000,d2
                jsr     (Enemy_InitHomingProjectile).l
Boss_SunsetStingInitHomingProjectileReturn:             ; CODE XREF: Boss_SunsetStingInitHomingProjectile+14   j  ; was: locret_41E2A
                rts
; End of function Boss_SunsetStingInitHomingProjectile
; Jumps to random function for boss pattern variation
Boss_SunsetStingChooseMovementVariation:                ; CODE XREF: Boss_SunsetStingUpdateMovement+DE   j  ; was: sub_41E2C
                lea     Boss_SunsetStingMovementVariationChoices(pc),a0
                jmp     Math_JumpToWeightedChoice
; End of function Boss_SunsetStingChooseMovementVariation
; ---------------------------------------------------------------------------
Boss_SunsetStingMovementVariationChoices:
                dc.w    $2000                           ; DATA XREF: Boss_SunsetStingChooseMovementVariation   o  ; was: word_41E36
                dc.w    Boss_SunsetStingMoveAndShoot-*
                dc.w    $6000
                dc.w    Boss_SunsetStingFlipDirection-*
                dc.w    $6000
                dc.w    Boss_SunsetStingFlipAndAnimate-*
                dc.w    $6000
                dc.w    Boss_SunsetStingBeginMovementState-*

; Moves boss based on player position and spawns projectiles
Boss_SunsetStingMoveAndShoot:                           ; DATA XREF: ROM:00041E38   o  ; was: sub_41E46
                move.w  #$18,4(a5)
                move.b  #$40,$4B(a5)                    ; '@'
; Calculate direction and rotate while attacking
Boss_SunsetStingMoveAndShoot_AttackLoop:                ; DATA XREF: ROM:0004195E   o  ; was: loc_41E52
                bsr.w   Boss_SunsetStingCalculateTargetDirection
                move.b  (byte_FFC7FC).w,d0
                ext.w   d0
                add.w   d0,d0
                addq.w  #1,d0
                add.w   d0,$56(a5)
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingMovementUpdatePartFacing
                bsr.w   Boss_SunsetStingSpawnRandomProjectileFromPart
                bra.w   Boss_SunsetStingSetIdleState
; End of function Boss_SunsetStingMoveAndShoot
; Flips boss horizontal direction and updates animation
Boss_SunsetStingFlipDirection:                          ; DATA XREF: ROM:00041E3C   o  ; was: sub_41E74
                move.w  #$12,4(a5)
                andi.b  #8,(word_FFC7F8).w
                move.b  #$20,(word_FFC7F8+1).w          ; ' '
                not.b   (byte_FFC7FC).w
                bra.w   Boss_SunsetStingMovementUpdateSelectedChain
; End of function Boss_SunsetStingFlipDirection
; Applies pose pattern A with a randomized target radius
Boss_SunsetStingApplyPosePatternAState:                 ; DATA XREF: ROM:00041958   o  ; was: sub_41E8E
                lea     Boss_SunsetStingPosePatternA(pc),a3
                moveq   #0,d2
                move.b  (byte_FFC7FD).w,d2
                bra.w   Boss_SunsetStingApplySelectedPosePattern
; End of function Boss_SunsetStingApplyPosePatternAState
; Flips direction, toggles sprite flip flag, updates animation
Boss_SunsetStingFlipAndAnimate:                         ; DATA XREF: ROM:00041E40   o  ; was: sub_41E9C
                move.w  #$C,4(a5)
                andi.b  #8,(word_FFC7F8).w
                move.b  #$20,(word_FFC7F8+1).w          ; ' '
                not.b   (byte_FFC7FC).w
                move.b  (word_FFC7F8).w,d0
                eori.b  #$14,d0
                bsr.w   Boss_SunsetStingGetBodyPartPointer
                eori.w  #$800,$E(a4)
                bra.w   Boss_SunsetStingMovementUpdateSelectedChain
; End of function Boss_SunsetStingFlipAndAnimate
; Applies pose pattern B with a randomized target radius
Boss_SunsetStingApplyPosePatternBState:                 ; DATA XREF: ROM:00041952   o  ; was: sub_41EC8
                lea     Boss_SunsetStingPosePatternB(pc),a3
                moveq   #0,d2
                move.b  (byte_FFC7FD).w,d2
                bra.w   Boss_SunsetStingApplySelectedPosePattern
; End of function Boss_SunsetStingApplyPosePatternBState
; Applies pose pattern C with a fixed target radius
Boss_SunsetStingApplyPosePatternCState:                 ; DATA XREF: ROM:00041954   o  ; was: sub_41ED6
                                        ; ROM:0004195A   o
                lea     Boss_SunsetStingPosePatternC(pc),a3
                move.w  #$20,d2                         ; ' '
Boss_SunsetStingApplySelectedPosePattern:               ; CODE XREF: Boss_SunsetStingApplyPosePatternAState+A   j  ; was: loc_41EDE
                                        ; Boss_SunsetStingApplyPosePatternBState+A   j
                move.b  (word_FFC7F8+1).w,d3
                move.b  (word_FFC7F8).w,d0
                eori.b  #$14,d0
                bsr.w   Boss_SunsetStingUpdatePartRotationForTarget
                ori.b   #$40,-$3F(a1)                   ; '@'
                subq.b  #1,(word_FFC7F8+1).w
                bne.s   Boss_SunsetStingFinishPosePatternUpdate
                move.b  (word_FFC7F8).w,d0
                addq.b  #4,(word_FFC7F8).w
                move.b  (word_FFC7F8).w,d1
                eor.b   d0,d1
                andi.b  #8,d1
                beq.s   Boss_SunsetStingNormalizePosePatternIndex
                eori.b  #8,(word_FFC7F8).w
                addq.w  #2,4(a5)
                subi.w  #$80,(word_FF8234).w
Boss_SunsetStingNormalizePosePatternIndex:              ; CODE XREF: Boss_SunsetStingApplyPosePatternCState+36   j  ; was: loc_41F1E
                andi.b  #$E,(word_FFC7F8).w
                move.b  #$20,(word_FFC7F8+1).w          ; ' '
Boss_SunsetStingFinishPosePatternUpdate:                ; CODE XREF: Boss_SunsetStingApplyPosePatternCState+22   j  ; was: loc_41F2A
                bra.w   Boss_SunsetStingMovementUpdateSelectedChain
; End of function Boss_SunsetStingApplyPosePatternCState
; Checks boss health threshold for behavior branch
Boss_SunsetStingCheckHealthThreshold:                   ; CODE XREF: Boss_SunsetStingFinishTrailTransitionState+C   j  ; was: sub_41F2E
                                        ; DATA XREF: ROM:00041956   o
                andi.b  #$BF,$4A1(a5)
                andi.b  #$BF,$6E1(a5)
                andi.b  #$BF,$921(a5)
                andi.b  #$BF,$B61(a5)
                cmpi.w  #$C0,(word_FF8234).w
                bgt.s   Boss_SunsetStingCheckPhaseTransition
                bra.w   Boss_SunsetStingBeginHealthRefillState
; End of function Boss_SunsetStingCheckHealthThreshold
; Checks if boss should transition to next phase
Boss_SunsetStingCheckPhaseTransition:                   ; CODE XREF: Boss_SunsetStingCheckHealthThreshold+1E   j  ; was: sub_41F52
                tst.b   (dword_FFC6DC).w
                bne.w   Boss_SunsetStingBeginChainOscillationState
                bra.w   Boss_SunsetStingSetIdleState
; End of function Boss_SunsetStingCheckPhaseTransition
; Initializes boss recovery state with timer
Boss_SunsetStingBeginHealthRefillState:                 ; CODE XREF: Boss_SunsetStingCheckHealthThreshold+20   j  ; was: sub_41F5E
                move.b  #$C0,$4B(a5)
                move.w  #$1C,4(a5)
; End of function Boss_SunsetStingBeginHealthRefillState
; Refills shared health while applying pose pattern C to all four chains
Boss_SunsetStingRefillHealthState:                      ; DATA XREF: ROM:00041962   o  ; was: sub_41F6A
                addi.w  #2,(word_FF8234).w
                cmpi.w  #$1E0,(word_FF8234).w
                bge.w   Boss_SunsetStingSetIdleState
                move.w  #0,d0
                move.w  #3,d7
Boss_SunsetStingRefillApplyPoseToChain:                 ; CODE XREF: Boss_SunsetStingRefillHealthState+2E   j  ; was: loc_41F82
                lea     Boss_SunsetStingPosePatternC(pc),a3
                move.w  #$30,d2                         ; '0'
                move.b  (word_FFC7F8+1).w,d3
                move.w  d0,-(sp)
                bsr.w   Boss_SunsetStingUpdatePartRotationForTarget
                move.w  (sp)+,d0
                addq.w  #8,d0
                dbf     d7,Boss_SunsetStingRefillApplyPoseToChain
                bra.w   Boss_SunsetStingMovementUpdateSelectedChain
; End of function Boss_SunsetStingRefillHealthState
; ---------------------------------------------------------------------------
Boss_SunsetStingChainRootOffsets:
                dc.w    $2A0, $4E0, $720, $960          ; was: word_41FA0
                                        ; DATA XREF: Boss_SunsetStingUpdateMovement+FE   o
                                        ; Boss_SunsetStingUpdateMovement+12A   o

; Calculates position using sine/cosine chain physics
Boss_SunsetStingCalculateChainPosition:                 ; CODE XREF: Boss_SunsetStingUpdateMovement+134   p  ; was: sub_41FA8
                move.w  #5,d7
                move.w  $56(a5),d6
                clr.l   d3
                clr.l   d4
                lea     (a4),a3
                movea.l #Math_SineTable,a2
Boss_SunsetStingAccumulateChainOffsets:                 ; CODE XREF: Boss_SunsetStingCalculateChainPosition+38   j  ; was: loc_41FBC
                add.w   $56(a3),d6
                move.w  d6,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  $4C(a3),d0
                muls.w  $4C(a3),d1
                sub.l   d1,d3
                sub.l   d0,d4
                lea     $60(a3),a3
                dbf     d7,Boss_SunsetStingAccumulateChainOffsets
                add.l   -$50(a3),d3
                add.l   -$4C(a3),d4
                move.l  d3,$10(a5)
                move.l  #$E00000,d0
                cmp.l   d0,d4
                bhi.s   Boss_SunsetStingClampChainAnchorY
                move.l  d0,d4
Boss_SunsetStingClampChainAnchorY:                      ; CODE XREF: Boss_SunsetStingCalculateChainPosition+50   j  ; was: loc_41FFC
                move.l  d4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; End of function Boss_SunsetStingCalculateChainPosition
