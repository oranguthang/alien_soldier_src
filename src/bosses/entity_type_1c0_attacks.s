; Dispatches type $1C8 in the dormant type-$1C0-family code
; REVIEWED VIS-003: role-only name; this is not the live Sunset Sting; see docs/unknowns.md
EntityType1C0_MainDispatcher:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_418FC
                move.w  (FrameCounter).w,d0
                andi.w  #$F,d0
                bne.s   EntityType1C0_DispatchSecondFormState
                move.w  (FrameCounter).w,d0
                andi.w  #$3F,d0                         ; '?'
                beq.s   EntityType1C0_RefreshAimSample
                lea     (PlayerObjectType).w,a4
                jsr     (Physics_CalculateAngleToTarget).l
                move.b  d0,(EntityType1C0AimAngle).w
                move.b  d0,(SecondaryEntityWork5C+1).w
                bra.s   EntityType1C0_DispatchSecondFormState
; ---------------------------------------------------------------------------
EntityType1C0_RefreshAimSample:                         ; CODE XREF: EntityType1C0_MainDispatcher+12   j  ; was: loc_41924
                lea     (PlayerObjectType).w,a4
                jsr     (Physics_CalculateAngleToTarget).l
                move.b  d0,(SecondaryEntityWork5C+1).w
EntityType1C0_DispatchSecondFormState:                  ; CODE XREF: EntityType1C0_MainDispatcher+8   j  ; was: loc_41932
                                        ; EntityType1C0_MainDispatcher+26   j
                moveq   #4,d7
                jsr     (Gfx_ProcessDefaultColorFade).l
                move.w  4(a5),d0
                lea     EntityType1C0_SecondFormStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function EntityType1C0_MainDispatcher
; ---------------------------------------------------------------------------
EntityType1C0_SecondFormStates:
                dc.w    EntityType1C0_SecondFormInitializeState-*  ; DATA XREF: EntityType1C0_MainDispatcher+42   o  ; was: off_41946
                dc.w    EntityType1C0_SecondFormLoadGraphicsState-*
                dc.w    EntityType1C0_QueueSecondFormIntroMessageState-*
                dc.w    EntityType1C0_WaitForSecondFormIntroMessageState-*
                dc.w    EntityType1C0_BeginMovementState-*
                dc.w    EntityType1C0_UpdateMovement-*
                dc.w    EntityType1C0_ApplyPosePatternBState-*
                dc.w    EntityType1C0_ApplyPosePatternCState-*
                dc.w    EntityType1C0_CheckHealthThreshold-*
                dc.w    EntityType1C0_ApplyPosePatternAState-*
                dc.w    EntityType1C0_ApplyPosePatternCState-*
                dc.w    EntityType1C0_CheckHealthThreshold-*
                dc.w    EntityType1C0_MoveAndShoot_AttackLoop-*
                dc.w    EntityType1C0_OscillateChainsState-*
                dc.w    EntityType1C0_RefillHealthState-*
                dc.w    EntityType1C0_DescendAndActivateChainsState-*
                dc.w    EntityType1C0_WaitThenActivateTrailState-*
                dc.w    EntityType1C0_ContractTrailState-*
                dc.w    EntityType1C0_FinishTrailTransitionState-*
EntityType1C0_BodyPartSpriteDescriptorA:
                dc.w    $C82C, $D00, $F8F0              ; DATA XREF: ROM:EntityType1C0_SecondFormBodyPartInitTable   o  ; was: word_4196C
                                        ; ROM:0004259A   o
EntityType1C0_BodyPartSpriteDescriptorB:
                dc.w    $C834, $500, $F8F8              ; DATA XREF: ROM:000425FA   o  ; was: word_41972
                                        ; ROM:00042602   o
EntityType1C0_BodyPartSpriteDescriptorC:
                dc.w    $C851, 0, $FCFC                 ; DATA XREF: ROM:000425B6   o  ; was: word_41978
                                        ; ROM:000425C6   o
EntityType1C0_BodyPartSpriteDescriptorD:
                dc.w    $C852, 0, $FCFC                 ; DATA XREF: ROM:000425D6   o  ; was: word_4197E
                                        ; ROM:000425E6   o

; Initializes boss state, clears sprites, sets starting position
EntityType1C0_SecondFormInitializeState:                ; DATA XREF: ROM:EntityType1C0_SecondFormStates   o  ; was: sub_41984
                clr.b   (SecondaryEntityWork5C).w
                move.w  #$1C8,d0
                moveq   #0,d1
                jsr     (Object_ClearEntityRecordsExceptTwoTypes).l
                addq.w  #2,4(a5)
                move.b  #$80,$4B(a5)
                clr.w   (PrimaryEntityWork5E).w
                clr.w   (PrimaryEntityWork58).w
                move.l  #$1C00000,$10(a5)
                move.l  #$2000000,$14(a5)
                rts
; End of function EntityType1C0_SecondFormInitializeState
; Loads boss graphics tiles, palettes, and body parts
EntityType1C0_SecondFormLoadGraphicsState:              ; DATA XREF: ROM:00041948   o  ; was: sub_419B8
                tst.w   (DataLoaderControl).w
                bmi.w   EntityType1C0_SecondFormLoadGraphicsReturn
                addq.w  #2,4(a5)
                movea.l #EntityType1C0_SecondFormObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                moveq   #6,d7
                jsr     (Gfx_ResetDefaultColorFadeState).l
                move.w  (a5),-(sp)
                move.w  #$3300,$E(a5)
                lea     EntityType1C0_SecondFormBodyPartInitTable(pc),a1
                lea     (a5),a4
                jsr     (EntityType1C0_InitBodyParts).l
                jsr     EntityType1C0_InitTrail(pc)     ; (pc)
                nop
                move.w  (sp)+,(a5)
                ori.w   #$100,$482(a5)
                ori.w   #$100,$6C2(a5)
                ori.w   #$100,$902(a5)
                ori.w   #$100,$B42(a5)
                move.w  #$D00,2(a5)
                lea     (a5),a1
                move.w  (PrimaryEntityWork5C).w,d3
                subq.w  #1,d3
EntityType1C0_InitializeSecondFormPartPositions:        ; CODE XREF: EntityType1C0_SecondFormLoadGraphicsState+76   j  ; was: loc_41A1A
                move.l  #$1C00000,$10(a1)
                move.l  #$1C00000,$14(a1)
                adda.w  #$60,a1                         ; '`'
                dbf     d3,EntityType1C0_InitializeSecondFormPartPositions
                move.l  #$FFFF0000,$18(a5)
                move.b  #$18,(EntityType1C0ChainPeriod).w
                move.b  (EntityType1C0ChainPeriod).w,(EntityType1C0ChainCycle+1).w
                move.b  #$FF,(FifthEntityWork5C).w
                move.w  #$180,$56(a5)
                movea.l #EntityType1C0_SecondFormTileLoadCommands,a0
                jsr     (Tilemap_QueueIndexedRows).l
EntityType1C0_SecondFormLoadGraphicsReturn:             ; CODE XREF: EntityType1C0_SecondFormLoadGraphicsState+4   j  ; was: locret_41A5E
                rts
; End of function EntityType1C0_SecondFormLoadGraphicsState
; ---------------------------------------------------------------------------
EntityType1C0_SecondFormTileLoadCommands:
                dc.w    $6100, $2000, $202, $595A, $5B5D, $5E5F, $6162, $63FF, $6306, $2000, 0, $5CFF, $6306, $2000, 0, $60FF  ; was: word_41A60
                                        ; DATA XREF: EntityType1C0_SecondFormLoadGraphicsState+9A   o
                dc.w    $6306, $2000, 0, $64FF
EntityType1C0_SecondFormTileAnimationOffsets:
                dc.w    $1E, $FFE6, $FFEC, $FFF2, $FFE8, $FFDE, $FFE4, $FFEA, $FFE0, $FFD6, $FFD4, $FFD2, $FFD0, $FFCE, $FFCC, $FFCA  ; was: word_41A88
                                        ; DATA XREF: EntityType1C0_SecondFormUpdate+82   o
                dc.w    $FFC8

; Queues the second-form intro message after the preceding transition
EntityType1C0_QueueSecondFormIntroMessageState:         ; DATA XREF: ROM:0004194A   o  ; was: sub_41AAA
                tst.w   (MessageSequenceState).w
                bne.w   EntityType1C0_SecondFormIntroUpdate
                moveq   #5,d0
                jsr     (BossMessage_Start).l
                addq.w  #2,4(a5)
                bra.w   EntityType1C0_SecondFormIntroUpdate
; End of function EntityType1C0_QueueSecondFormIntroMessageState
; Waits for the second-form intro message to complete before advancing
EntityType1C0_WaitForSecondFormIntroMessageState:       ; DATA XREF: ROM:0004194C   o  ; was: sub_41AC2
                tst.w   (MessageSequenceState).w
                bne.s   EntityType1C0_SecondFormIntroUpdate
                clr.b   (BossColorEffectFlags).w
                addq.w  #2,4(a5)
EntityType1C0_SecondFormIntroUpdate:                    ; CODE XREF: EntityType1C0_QueueSecondFormIntroMessageState+4   j  ; was: loc_41AD0
                                        ; EntityType1C0_QueueSecondFormIntroMessageState+14   j
                bra.w   EntityType1C0_MovementUpdatePartFacing
; End of function EntityType1C0_WaitForSecondFormIntroMessageState
; Sets boss to attack state mode and transitions to main loop
EntityType1C0_BeginMovementState:                       ; DATA XREF: ROM:0004194E   o  ; was: sub_41AD4
                                        ; ROM:00041E44   o
                move.b  #4,$4B(a5)
                bra.w   EntityType1C0_InitializeMovementState
; End of function EntityType1C0_BeginMovementState
; Sets boss to idle state and initializes attack timer
EntityType1C0_SetIdleState:                             ; CODE XREF: EntityType1C0_MoveAndShoot+2A   j  ; was: sub_41ADE
                                        ; EntityType1C0_CheckPhaseTransition+8   j
                move.b  #$10,(EntityType1C0ChainPeriod).w
                move.b  #0,$4B(a5)
EntityType1C0_InitializeMovementState:                  ; CODE XREF: EntityType1C0_BeginMovementState+6   j  ; was: loc_41AEA
                move.w  #$A,4(a5)
                clr.w   (EntityType1C0ChainCycle).w
                move.b  (EntityType1C0ChainPeriod).w,(EntityType1C0ChainCycle+1).w
                bsr.w   EntityType1C0_CalculateTargetDirection
                bra.w   EntityType1C0_MovementUpdateSelectedChain
; End of function EntityType1C0_SetIdleState
; Updates boss vertical movement tracking player
EntityType1C0_UpdateMovement:                           ; DATA XREF: ROM:00041950   o  ; was: sub_41B02
                move.w  #$10,d2
                move.w  #$F0,d0
                sub.w   $14(a5),d0
                move.b  (FifthEntityWork5C).w,d1
                asl.w   #8,d1
                eor.w   d0,d1
                bpl.s   EntityType1C0_MovementNormalizeVerticalDelta
                neg.w   d2
EntityType1C0_MovementNormalizeVerticalDelta:           ; CODE XREF: EntityType1C0_UpdateMovement+14   j  ; was: loc_41B1A
                tst.w   d0
                bpl.s   EntityType1C0_MovementAdjustBodyAngle
                neg.w   d0
EntityType1C0_MovementAdjustBodyAngle:                  ; CODE XREF: EntityType1C0_UpdateMovement+1A   j  ; was: loc_41B20
                cmpi.w  #$A,d0
                bcs.s   EntityType1C0_MovementUpdatePartFacing
                addi.w  #$100,d2
                lsr.w   #1,d2
                move.w  #1,d0
                move.w  $56(a5),d1
                lsr.w   #1,d1
                sub.b   d1,d2
                beq.s   EntityType1C0_MovementUpdatePartFacing
                bpl.s   EntityType1C0_MovementApplyBodyAngleStep
                neg.w   d0
EntityType1C0_MovementApplyBodyAngleStep:               ; CODE XREF: EntityType1C0_UpdateMovement+38   j  ; was: loc_41B3E
                add.w   d0,$56(a5)
EntityType1C0_MovementUpdatePartFacing:                 ; CODE XREF: EntityType1C0_WaitForSecondFormIntroMessageState:EntityType1C0_SecondFormIntroUpdate   j  ; was: loc_41B42
                                        ; EntityType1C0_UpdateMovement+22   j
                tst.b   (FifthEntityWork5C).w
                bpl.s   EntityType1C0_MovementFacePositive
                ori.w   #$800,$4EE(a5)
                ori.w   #$800,$72E(a5)
                andi.w  #$F7FF,$2AE(a5)
                andi.w  #$F7FF,$96E(a5)
                bra.w   EntityType1C0_MovementUpdatePosePatterns
; ---------------------------------------------------------------------------
EntityType1C0_MovementFacePositive:                     ; CODE XREF: EntityType1C0_UpdateMovement+44   j  ; was: loc_41B64
                ori.w   #$800,$2AE(a5)
                ori.w   #$800,$96E(a5)
                andi.w  #$F7FF,$4EE(a5)
                andi.w  #$F7FF,$72E(a5)
EntityType1C0_MovementUpdatePosePatterns:               ; CODE XREF: EntityType1C0_UpdateMovement+5E   j  ; was: loc_41B7C
                moveq   #$FFFFFFFF,d6
                move.b  (EntityType1C0ChainCycle+1).w,d3
                move.b  (EntityType1C0ChainCycle).w,d0
                lea     EntityType1C0_PrimaryTrackingPoseOffsets(pc),a3
                bsr.w   EntityType1C0_UpdatePartRotation
                move.b  (EntityType1C0ChainCycle+1).w,d3
                move.b  (EntityType1C0ChainCycle).w,d0
                eori.b  #$14,d0
                lea     EntityType1C0_SecondaryTrackingPoseOffsets(pc),a3
                bsr.w   EntityType1C0_UpdatePartRotation
                subq.b  #1,(EntityType1C0ChainCycle+1).w
                bne.s   EntityType1C0_MovementUpdateActiveChain
                addq.b  #4,(EntityType1C0ChainCycle).w
                andi.b  #$E,(EntityType1C0ChainCycle).w
                move.b  (EntityType1C0ChainPeriod).w,(EntityType1C0ChainCycle+1).w
                bsr.w   EntityType1C0_CalculateTargetDirection
                cmpi.w  #$A0,d0
                bhi.s   EntityType1C0_MovementTrySpawnProjectile
                tst.b   $4B(a5)
                bne.w   EntityType1C0_MovementDecrementShotDelay
                move.w  (PrimaryEntityWork58).w,d0
                move.b  (FifthEntityWork5C).w,d1
                andi.w  #4,d1
                eori.w  #4,d0
                eor.b   d0,d1
                andi.w  #4,d1
                bne.w   EntityType1C0_ChooseMovementVariation
                move.b  #1,$4B(a5)
EntityType1C0_MovementDecrementShotDelay:               ; CODE XREF: EntityType1C0_UpdateMovement+C4   j  ; was: loc_41BEA
                subq.b  #1,$4B(a5)
EntityType1C0_MovementTrySpawnProjectile:               ; CODE XREF: EntityType1C0_UpdateMovement+BE   j  ; was: loc_41BEE
                move.w  d6,-(sp)
                bsr.w   EntityType1C0_SpawnRandomProjectile
                move.w  (sp)+,d6
EntityType1C0_MovementUpdateActiveChain:                ; CODE XREF: EntityType1C0_UpdateMovement+A4   j  ; was: loc_41BF6
                tst.w   d6
                bmi.s   EntityType1C0_MovementUpdateSelectedChain
                cmp.w   (PrimaryEntityWork58).w,d6
                beq.s   EntityType1C0_MovementUpdateSelectedChain
                lea     EntityType1C0_ChainRootOffsets(pc),a2
                movea.w (a2,d6.w),a4
                adda.w  a5,a4
                move.l  #SharedVictorSunsetStingSegmentMappingB,$1E8(a4)
                move.w  (PrimaryEntityWork58).w,d0
                move.w  d6,(PrimaryEntityWork58).w
                movea.w (a2,d0.w),a4
                adda.w  a5,a4
                move.l  #SharedVictorSunsetStingSegmentMappingA,$1E8(a4)
EntityType1C0_MovementUpdateSelectedChain:              ; CODE XREF: EntityType1C0_SetIdleState+20   j  ; was: loc_41C28
                                        ; EntityType1C0_UpdateMovement+F6   j
                move.w  (PrimaryEntityWork58).w,d6
                lea     EntityType1C0_ChainRootOffsets(pc),a4
                movea.w (a4,d6.w),a4
                adda.l  a5,a4
                bsr.w   EntityType1C0_CalculateChainPosition
                bra.w   EntityType1C0_SecondFormUpdateBody
; End of function EntityType1C0_UpdateMovement
; ---------------------------------------------------------------------------
EntityType1C0_PrimaryTrackingPoseOffsets:
                dc.w    $2C, 0, $32, 0                  ; DATA XREF: EntityType1C0_UpdateMovement+84   o  ; was: word_41C3E
EntityType1C0_SecondaryTrackingPoseOffsets:
                dc.w    $42, 0, $34, 0, 8, 0, $E, 0, $40, $FFC0, $FFC0, $FFC0, $FFC0, $FFE0, $FFE0, $FFE0  ; was: word_41C46
                                        ; DATA XREF: EntityType1C0_UpdateMovement+98   o
                dc.w    $FFE0, $FFE0, 0, $20, $20, $20, $20, $FF80, $80, $80, $80, $80, 0, $FFE0, $FFE0, $FFE0
                dc.w    $FFE0, $80, $FF80, $FF80, $FF80, $FF80, 0, $40, $40, $40, $40, $FFE0, $FFC0, $FFC0, $FFC0, $FFC0
EntityType1C0_PosePatternC:
                dc.w    $1A, 0, $FFCA, 0                ; DATA XREF: EntityType1C0_ApplyPosePatternCState   o  ; was: word_41CA6
                                        ; EntityType1C0_RefillHealthState:EntityType1C0_RefillApplyPoseToChain   o
EntityType1C0_PosePatternB:
                dc.w    8, 0, $E, 0, $60, $20, $20, $20, $20, $FFA0, $FFE0, $FFE0, $FFE0, $FFE0  ; was: word_41CAE
                                        ; DATA XREF: EntityType1C0_ApplyPosePatternBState   o
EntityType1C0_PosePatternA:
                dc.w    $12, 0, 4, 0, $40, $60, $80, $A0, $C0, 0, 0, 0, 0, 0  ; was: word_41CCA
                                        ; DATA XREF: EntityType1C0_ApplyPosePatternAState   o

; Calculates target direction based on player position
EntityType1C0_CalculateTargetDirection:                 ; CODE XREF: EntityType1C0_SetIdleState+1C   p  ; was: sub_41CE6
                                        ; EntityType1C0_UpdateMovement+B6   p
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                move.b  d0,(EntityType1C0PoseRadius).w
                move.w  $14(a5),d0
                cmpi.w  #$120,d0
                bhi.s   EntityType1C0_TargetDirectionUseBodyAngle
                lea     (PlayerObjectType).w,a4
                move.w  PlayerXPosition-PlayerObjectType(a4),d0
                sub.w   $10(a5),d0
                ext.l   d0
                bpl.s   EntityType1C0_TargetDirectionStoreDelta
                neg.w   d0
EntityType1C0_TargetDirectionStoreDelta:                ; CODE XREF: EntityType1C0_CalculateTargetDirection+26   j  ; was: loc_41D10
                add.b   d0,(EntityType1C0PoseRadius).w
                swap    d0
                move.b  d0,(FifthEntityWork5C).w
                swap    d0
                rts
; ---------------------------------------------------------------------------
EntityType1C0_TargetDirectionUseBodyAngle:              ; CODE XREF: EntityType1C0_CalculateTargetDirection+16   j  ; was: loc_41D1E
                move.w  $56(a5),d0
                lsr.w   #1,d0
                ext.w   d0
                lsr.w   #8,d0
                move.b  d0,(FifthEntityWork5C).w
                move.w  #$1FF,d0
                move.b  d0,(EntityType1C0PoseRadius).w
                rts
; End of function EntityType1C0_CalculateTargetDirection
; Gets pointer to specific body part based on angle
EntityType1C0_GetBodyPartPointer:                       ; CODE XREF: EntityType1C0_UpdatePartRotation:EntityType1C0_UpdatePartRotationForTarget   p  ; was: sub_41D36
                                        ; EntityType1C0_FlipAndAnimate+1E   p
                tst.b   (FifthEntityWork5C).w
                bmi.s   EntityType1C0_ResolveBodyPartIndex
                eori.b  #$10,d0
EntityType1C0_ResolveBodyPartIndex:                     ; CODE XREF: EntityType1C0_GetBodyPartPointer+4   j  ; was: loc_41D40
                move.w  d0,d1
                lsr.w   #2,d0
                andi.w  #6,d0
                lea     EntityType1C0_ChainRootOffsets(pc),a0
                movea.w (a0,d0.w),a4
                adda.l  a5,a4
                rts
; End of function EntityType1C0_GetBodyPartPointer
; Updates body part rotation angles with target tracking
EntityType1C0_UpdatePartRotation:                       ; CODE XREF: EntityType1C0_UpdateMovement+88   p  ; was: sub_41D54
                                        ; EntityType1C0_UpdateMovement+9C   p
                move.w  #$20,d2                         ; ' '
EntityType1C0_UpdatePartRotationForTarget:              ; CODE XREF: EntityType1C0_ApplyPosePatternCState+14   p  ; was: loc_41D58
                                        ; EntityType1C0_RefillHealthState+26   p
                bsr.s   EntityType1C0_GetBodyPartPointer
                move.w  d1,-(sp)
                asl.w   #5,d1
                sub.w   d3,d1
                andi.w  #$FF,d1
                addi.b  #$40,d1                         ; '@'
                btst    #7,d1
                beq.s   EntityType1C0_ApplyPartPoseSequence
                move.w  d0,d6
EntityType1C0_ApplyPartPoseSequence:                    ; CODE XREF: EntityType1C0_UpdatePartRotation+18   j  ; was: loc_41D70
                move.w  (sp)+,d1
                andi.w  #6,d1
                lea     (a3,d1.w),a0
                adda.w  (a0),a0
                bsr.w   EntityType1C0_AnimatePartSequence
                rts
; End of function EntityType1C0_UpdatePartRotation
; Animates sequence of connected body parts
EntityType1C0_AnimatePartSequence:                      ; CODE XREF: EntityType1C0_UpdatePartRotation+28   p  ; was: sub_41D82
                lea     $60(a4),a1
                move.w  #4,d4
EntityType1C0_AnimatePartSequenceLoop:                  ; CODE XREF: EntityType1C0_AnimatePartSequence+36   j  ; was: loc_41D8A
                move.w  (a0)+,d0
                ; Original immediate is $B; memory BTST uses its low three bits
                dc.w    $082C, $000B, $000E             ; btst #$B,$E(a4)
                beq.s   EntityType1C0_InterpolatePartPose
                neg.w   d0
EntityType1C0_InterpolatePartPose:                      ; CODE XREF: EntityType1C0_AnimatePartSequence+10   j  ; was: loc_41D96
                sub.w   $56(a1),d0
                ext.l   d0
                divs.w  d3,d0
                add.w   d0,$56(a1)
                move.w  #1,d0
                cmp.w   $4C(a1),d2
                beq.s   EntityType1C0_AdvancePartPose
                bpl.s   EntityType1C0_IncreasePartRadius
                neg.w   d0
EntityType1C0_IncreasePartRadius:                       ; CODE XREF: EntityType1C0_AnimatePartSequence+2A   j  ; was: loc_41DB0
                add.w   d0,$4C(a1)
EntityType1C0_AdvancePartPose:                          ; CODE XREF: EntityType1C0_AnimatePartSequence+28   j  ; was: loc_41DB4
                adda.w  #$60,a1                         ; '`'
                dbf     d4,EntityType1C0_AnimatePartSequenceLoop
                rts
; End of function EntityType1C0_AnimatePartSequence
; Spawns projectiles at random positions using jump table
EntityType1C0_SpawnRandomProjectile:                    ; CODE XREF: EntityType1C0_UpdateMovement+EE   p  ; was: sub_41DBE
                tst.w   (DifficultyMode).w
                beq.w   EntityType1C0_SpawnRandomProjectileReturn
EntityType1C0_SpawnRandomProjectileFromPart:            ; CODE XREF: EntityType1C0_MoveAndShoot+26   p  ; was: loc_41DC6
                jsr     (RandomNumber).l
                andi.w  #6,d0
                movem.l a5,-(sp)
                lea     EntityType1C0_ChainRootOffsets(pc),a2
                adda.w  d0,a2
                movea.w (a2)+,a5
                adda.l  (sp),a5
                adda.w  #$1E0,a5
                lea     (PlayerObjectType).w,a4
                jsr     (Physics_CalculateAngleToTarget).l
                movem.l d2/a2,-(sp)
                bsr.w   EntityType1C0_InitHomingProjectile
                movem.l (sp)+,d2/a2
                movem.l (sp)+,a5
EntityType1C0_SpawnRandomProjectileReturn:              ; CODE XREF: EntityType1C0_SpawnRandomProjectile+4   j  ; was: locret_41DFC
                rts
; End of function EntityType1C0_SpawnRandomProjectile
; Initializes homing projectile with angle offset
EntityType1C0_InitHomingProjectile:                     ; CODE XREF: EntityType1C0_SpawnRandomProjectile+32   p  ; was: sub_41DFE
                andi.w  #$FF,d0
                subi.b  #$40,d0                         ; '@'
                move.w  d0,-(sp)
                movea.w #(ThirtyFourthEntityType-M68K_RAM),a0
                jsr     (Projectile_FindFreeSlotForward20).l
                bne.s   EntityType1C0_InitHomingProjectileReturn
                move.w  (sp)+,d6
                add.w   d6,d6
                move.w  #0,d0
                move.w  #0,d1
                move.w  #$8000,d2
                jsr     (Projectile_InitializeDifficultyScaledTwoSpeedShot).l
EntityType1C0_InitHomingProjectileReturn:               ; CODE XREF: EntityType1C0_InitHomingProjectile+14   j  ; was: locret_41E2A
                rts
; End of function EntityType1C0_InitHomingProjectile
; Jumps to random function for boss pattern variation
EntityType1C0_ChooseMovementVariation:                  ; CODE XREF: EntityType1C0_UpdateMovement+DE   j  ; was: sub_41E2C
                lea     EntityType1C0_MovementVariationChoices(pc),a0
                jmp     Math_JumpToWeightedChoice
; End of function EntityType1C0_ChooseMovementVariation
; ---------------------------------------------------------------------------
EntityType1C0_MovementVariationChoices:
                dc.w    $2000                           ; DATA XREF: EntityType1C0_ChooseMovementVariation   o  ; was: word_41E36
                dc.w    EntityType1C0_MoveAndShoot-*
                dc.w    $6000
                dc.w    EntityType1C0_FlipDirection-*
                dc.w    $6000
                dc.w    EntityType1C0_FlipAndAnimate-*
                dc.w    $6000
                dc.w    EntityType1C0_BeginMovementState-*

; Moves boss based on player position and spawns projectiles
EntityType1C0_MoveAndShoot:                             ; DATA XREF: ROM:00041E38   o  ; was: sub_41E46
                move.w  #$18,4(a5)
                move.b  #$40,$4B(a5)                    ; '@'
; Calculate direction and rotate while attacking
EntityType1C0_MoveAndShoot_AttackLoop:                  ; DATA XREF: ROM:0004195E   o  ; was: loc_41E52
                bsr.w   EntityType1C0_CalculateTargetDirection
                move.b  (FifthEntityWork5C).w,d0
                ext.w   d0
                add.w   d0,d0
                addq.w  #1,d0
                add.w   d0,$56(a5)
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_MovementUpdatePartFacing
                bsr.w   EntityType1C0_SpawnRandomProjectileFromPart
                bra.w   EntityType1C0_SetIdleState
; End of function EntityType1C0_MoveAndShoot
; Flips boss horizontal direction and updates animation
EntityType1C0_FlipDirection:                            ; DATA XREF: ROM:00041E3C   o  ; was: sub_41E74
                move.w  #$12,4(a5)
                andi.b  #8,(EntityType1C0ChainCycle).w
                move.b  #$20,(EntityType1C0ChainCycle+1).w  ; ' '
                not.b   (FifthEntityWork5C).w
                bra.w   EntityType1C0_MovementUpdateSelectedChain
; End of function EntityType1C0_FlipDirection
; Applies pose pattern A with a randomized target radius
EntityType1C0_ApplyPosePatternAState:                   ; DATA XREF: ROM:00041958   o  ; was: sub_41E8E
                lea     EntityType1C0_PosePatternA(pc),a3
                moveq   #0,d2
                move.b  (EntityType1C0PoseRadius).w,d2
                bra.w   EntityType1C0_ApplySelectedPosePattern
; End of function EntityType1C0_ApplyPosePatternAState
; Flips direction, toggles sprite flip flag, updates animation
EntityType1C0_FlipAndAnimate:                           ; DATA XREF: ROM:00041E40   o  ; was: sub_41E9C
                move.w  #$C,4(a5)
                andi.b  #8,(EntityType1C0ChainCycle).w
                move.b  #$20,(EntityType1C0ChainCycle+1).w  ; ' '
                not.b   (FifthEntityWork5C).w
                move.b  (EntityType1C0ChainCycle).w,d0
                eori.b  #$14,d0
                bsr.w   EntityType1C0_GetBodyPartPointer
                eori.w  #$800,$E(a4)
                bra.w   EntityType1C0_MovementUpdateSelectedChain
; End of function EntityType1C0_FlipAndAnimate
; Applies pose pattern B with a randomized target radius
EntityType1C0_ApplyPosePatternBState:                   ; DATA XREF: ROM:00041952   o  ; was: sub_41EC8
                lea     EntityType1C0_PosePatternB(pc),a3
                moveq   #0,d2
                move.b  (EntityType1C0PoseRadius).w,d2
                bra.w   EntityType1C0_ApplySelectedPosePattern
; End of function EntityType1C0_ApplyPosePatternBState
; Applies pose pattern C with a fixed target radius
EntityType1C0_ApplyPosePatternCState:                   ; DATA XREF: ROM:00041954   o  ; was: sub_41ED6
                                        ; ROM:0004195A   o
                lea     EntityType1C0_PosePatternC(pc),a3
                move.w  #$20,d2                         ; ' '
EntityType1C0_ApplySelectedPosePattern:                 ; CODE XREF: EntityType1C0_ApplyPosePatternAState+A   j  ; was: loc_41EDE
                                        ; EntityType1C0_ApplyPosePatternBState+A   j
                move.b  (EntityType1C0ChainCycle+1).w,d3
                move.b  (EntityType1C0ChainCycle).w,d0
                eori.b  #$14,d0
                bsr.w   EntityType1C0_UpdatePartRotationForTarget
                ori.b   #$40,-$3F(a1)                   ; '@'
                subq.b  #1,(EntityType1C0ChainCycle+1).w
                bne.s   EntityType1C0_FinishPosePatternUpdate
                move.b  (EntityType1C0ChainCycle).w,d0
                addq.b  #4,(EntityType1C0ChainCycle).w
                move.b  (EntityType1C0ChainCycle).w,d1
                eor.b   d0,d1
                andi.b  #8,d1
                beq.s   EntityType1C0_NormalizePosePatternIndex
                eori.b  #8,(EntityType1C0ChainCycle).w
                addq.w  #2,4(a5)
                subi.w  #$80,(BossCombatCounter).w
EntityType1C0_NormalizePosePatternIndex:                ; CODE XREF: EntityType1C0_ApplyPosePatternCState+36   j  ; was: loc_41F1E
                andi.b  #$E,(EntityType1C0ChainCycle).w
                move.b  #$20,(EntityType1C0ChainCycle+1).w  ; ' '
EntityType1C0_FinishPosePatternUpdate:                  ; CODE XREF: EntityType1C0_ApplyPosePatternCState+22   j  ; was: loc_41F2A
                bra.w   EntityType1C0_MovementUpdateSelectedChain
; End of function EntityType1C0_ApplyPosePatternCState
; Checks boss health threshold for behavior branch
EntityType1C0_CheckHealthThreshold:                     ; CODE XREF: EntityType1C0_FinishTrailTransitionState+C   j  ; was: sub_41F2E
                                        ; DATA XREF: ROM:00041956   o
                andi.b  #$BF,$4A1(a5)
                andi.b  #$BF,$6E1(a5)
                andi.b  #$BF,$921(a5)
                andi.b  #$BF,$B61(a5)
                cmpi.w  #$C0,(BossCombatCounter).w
                bgt.s   EntityType1C0_CheckPhaseTransition
                bra.w   EntityType1C0_BeginHealthRefillState
; End of function EntityType1C0_CheckHealthThreshold
; Checks if boss should transition to next phase
EntityType1C0_CheckPhaseTransition:                     ; CODE XREF: EntityType1C0_CheckHealthThreshold+1E   j  ; was: sub_41F52
                tst.b   (SecondaryEntityWork5C).w
                bne.w   EntityType1C0_BeginChainOscillationState
                bra.w   EntityType1C0_SetIdleState
; End of function EntityType1C0_CheckPhaseTransition
; Initializes boss recovery state with timer
EntityType1C0_BeginHealthRefillState:                   ; CODE XREF: EntityType1C0_CheckHealthThreshold+20   j  ; was: sub_41F5E
                move.b  #$C0,$4B(a5)
                move.w  #$1C,4(a5)
; End of function EntityType1C0_BeginHealthRefillState
; Refills shared health while applying pose pattern C to all four chains
EntityType1C0_RefillHealthState:                        ; DATA XREF: ROM:00041962   o  ; was: sub_41F6A
                addi.w  #2,(BossCombatCounter).w
                cmpi.w  #$1E0,(BossCombatCounter).w
                bge.w   EntityType1C0_SetIdleState
                move.w  #0,d0
                move.w  #3,d7
EntityType1C0_RefillApplyPoseToChain:                   ; CODE XREF: EntityType1C0_RefillHealthState+2E   j  ; was: loc_41F82
                lea     EntityType1C0_PosePatternC(pc),a3
                move.w  #$30,d2                         ; '0'
                move.b  (EntityType1C0ChainCycle+1).w,d3
                move.w  d0,-(sp)
                bsr.w   EntityType1C0_UpdatePartRotationForTarget
                move.w  (sp)+,d0
                addq.w  #8,d0
                dbf     d7,EntityType1C0_RefillApplyPoseToChain
                bra.w   EntityType1C0_MovementUpdateSelectedChain
; End of function EntityType1C0_RefillHealthState
; ---------------------------------------------------------------------------
EntityType1C0_ChainRootOffsets:
                dc.w    $2A0, $4E0, $720, $960          ; was: word_41FA0
                                        ; DATA XREF: EntityType1C0_UpdateMovement+FE   o
                                        ; EntityType1C0_UpdateMovement+12A   o

; Calculates position using sine/cosine chain physics
EntityType1C0_CalculateChainPosition:                   ; CODE XREF: EntityType1C0_UpdateMovement+134   p  ; was: sub_41FA8
                move.w  #5,d7
                move.w  $56(a5),d6
                clr.l   d3
                clr.l   d4
                lea     (a4),a3
                movea.l #Math_SineTable,a2
EntityType1C0_AccumulateChainOffsets:                   ; CODE XREF: EntityType1C0_CalculateChainPosition+38   j  ; was: loc_41FBC
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
                dbf     d7,EntityType1C0_AccumulateChainOffsets
                add.l   -$50(a3),d3
                add.l   -$4C(a3),d4
                move.l  d3,$10(a5)
                move.l  #$E00000,d0
                cmp.l   d0,d4
                bhi.s   EntityType1C0_ClampChainAnchorY
                move.l  d0,d4
EntityType1C0_ClampChainAnchorY:                        ; CODE XREF: EntityType1C0_CalculateChainPosition+50   j  ; was: loc_41FFC
                move.l  d4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; End of function EntityType1C0_CalculateChainPosition
