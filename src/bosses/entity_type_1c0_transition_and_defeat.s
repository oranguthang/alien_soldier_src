; Enters the chain-oscillation state after the low-health transition
EntityType1C0_BeginChainOscillationState:               ; CODE XREF: EntityType1C0_CheckPhaseTransition+4   j  ; was: sub_4200A
                move.w  #$1A,4(a5)
                move.b  #0,$4B(a5)
                move.w  #4,(SecondaryEntityWork58).w
                bra.w   EntityType1C0_SecondFormUpdate
; End of function EntityType1C0_BeginChainOscillationState
; Moves five link radii one unit toward the requested radius
EntityType1C0_ApproachChainLinkRadius:                  ; CODE XREF: EntityType1C0_UpdateAllChainRadii+4   p  ; was: sub_42020
                                        ; EntityType1C0_UpdateAllChainRadii+A   p
                lea     $60(a4),a3
                move.w  #4,d4
EntityType1C0_ApproachChainLinkRadiusLoop:              ; CODE XREF: EntityType1C0_ApproachChainLinkRadius+1E   j  ; was: loc_42028
                move.w  #1,d0
                cmp.w   $4C(a3),d2
                beq.s   EntityType1C0_ApproachChainLinkRadiusAdvance
                bpl.s   EntityType1C0_ApproachChainLinkRadiusApplyStep
                neg.w   d0
EntityType1C0_ApproachChainLinkRadiusApplyStep:         ; CODE XREF: EntityType1C0_ApproachChainLinkRadius+12   j  ; was: loc_42036
                add.w   d0,$4C(a3)
EntityType1C0_ApproachChainLinkRadiusAdvance:           ; CODE XREF: EntityType1C0_ApproachChainLinkRadius+10   j  ; was: loc_4203A
                adda.w  #$60,a3                         ; '`'
                dbf     d4,EntityType1C0_ApproachChainLinkRadiusLoop
                rts
; End of function EntityType1C0_ApproachChainLinkRadius
; Updates the link radii of all four chains
EntityType1C0_UpdateAllChainRadii:                      ; CODE XREF: EntityType1C0_OscillateChainsState+96   p  ; was: sub_42044
                lea     $2A0(a5),a4
                bsr.s   EntityType1C0_ApproachChainLinkRadius
                lea     $4E0(a5),a4
                bsr.s   EntityType1C0_ApproachChainLinkRadius
                lea     $720(a5),a4
                bsr.s   EntityType1C0_ApproachChainLinkRadius
                lea     $960(a5),a4
                bsr.s   EntityType1C0_ApproachChainLinkRadius
                rts
; End of function EntityType1C0_UpdateAllChainRadii
; Oscillates the chain angles while moving between vertical bounds
EntityType1C0_OscillateChainsState:                     ; DATA XREF: ROM:00041960   o  ; was: sub_4205E
                move.w  #1,d1
                btst    #0,(FrameCounter).w
                bne.s   EntityType1C0_AdvanceChainOscillationPhase
                neg.w   d1
EntityType1C0_AdvanceChainOscillationPhase:             ; CODE XREF: EntityType1C0_OscillateChainsState+A   j  ; was: loc_4206C
                add.w   d1,(SecondaryEntityWork58).w
                move.w  #$70,d1                         ; 'p'
                move.w  d1,d2
                move.w  (SecondaryEntityWork58).w,d0
                bpl.s   EntityType1C0_ClampChainOscillationPhase
                neg.w   d0
                neg.w   d1
EntityType1C0_ClampChainOscillationPhase:               ; CODE XREF: EntityType1C0_OscillateChainsState+1C   j  ; was: loc_42080
                cmp.w   d2,d0
                bcs.s   EntityType1C0_UpdateOscillationVelocity
                move.w  d1,(SecondaryEntityWork58).w
EntityType1C0_UpdateOscillationVelocity:                ; CODE XREF: EntityType1C0_OscillateChainsState+24   j  ; was: loc_42088
                movea.l #Math_SineTable,a2
                move.b  (SecondaryEntityWork5C+1).w,d1
                add.w   d1,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                move.w  #2,d2
                ext.l   d1
                asl.l   d2,d1
                move.l  d1,$18(a5)
                move.w  $14(a5),d1
                tst.l   $1C(a5)
                beq.s   EntityType1C0_SetUpwardVelocity
                bpl.s   EntityType1C0_CheckLowerVerticalBound
                cmpi.w  #$C0,d1
                bhi.s   EntityType1C0_UpdateOscillatingChains
                move.l  #$10000,$1C(a5)
                bra.w   EntityType1C0_UpdateOscillatingChains
; ---------------------------------------------------------------------------
EntityType1C0_CheckLowerVerticalBound:                  ; CODE XREF: EntityType1C0_OscillateChainsState+5A   j  ; was: loc_420CC
                cmpi.w  #$160,d1
                bcs.s   EntityType1C0_UpdateOscillatingChains
EntityType1C0_SetUpwardVelocity:                        ; CODE XREF: EntityType1C0_OscillateChainsState+58   j  ; was: loc_420D2
                move.l  #$FFFF0000,$1C(a5)
                bra.w   *+4
; ---------------------------------------------------------------------------
EntityType1C0_UpdateOscillatingChains:                  ; CODE XREF: EntityType1C0_OscillateChainsState+60   j  ; was: loc_420DE
                                        ; EntityType1C0_OscillateChainsState+6A   j
                move.w  (SecondaryEntityWork58).w,d0
                bsr.w   EntityType1C0_UpdateChainRootAngles
                move.w  (SecondaryEntityWork58).w,d2
                bpl.s   EntityType1C0_UseOscillationMagnitude
                neg.w   d2
EntityType1C0_UseOscillationMagnitude:                  ; CODE XREF: EntityType1C0_OscillateChainsState+8C   j  ; was: loc_420EE
                lsr.w   #2,d2
                addi.w  #$20,d2                         ; ' '
                bsr.w   EntityType1C0_UpdateAllChainRadii
                move.w  (SecondaryEntityWork58).w,d1
                asr.w   #3,d1
                add.w   d1,$56(a5)
                bra.w   EntityType1C0_SecondFormUpdate
; End of function EntityType1C0_OscillateChainsState
; Supplies a common target angle to all four chain roots
EntityType1C0_UpdateChainRootAngles:                    ; CODE XREF: EntityType1C0_OscillateChainsState+84   p  ; was: sub_42106
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                lea     (sp),a3
                bsr.w   EntityType1C0_InterpolateChainRootAngles
                addq.w  #8,sp
                rts
; End of function EntityType1C0_UpdateChainRootAngles
; Smoothly approaches the target angle of each chain root
EntityType1C0_InterpolateChainRootAngles:               ; CODE XREF: EntityType1C0_UpdateChainRootAngles+A   p  ; was: sub_42118
                lea     EntityType1C0_ChainRootOffsets(pc),a2
                move.w  #3,d4
EntityType1C0_InterpolateChainRootAnglesLoop:           ; CODE XREF: EntityType1C0_InterpolateChainRootAngles+1C   j  ; was: loc_42120
                movea.w (a2)+,a4
                adda.w  a5,a4
                move.w  (PrimaryEntityWork5A).w,d2
                add.w   (a3)+,d2
                sub.w   $58(a4),d2
                asr.w   #3,d2
                add.w   d2,$58(a4)
                dbf     d4,EntityType1C0_InterpolateChainRootAnglesLoop
                rts
; End of function EntityType1C0_InterpolateChainRootAngles
; Calculates horizontal direction to player
EntityType1C0_GetDirectionToPlayer:
                move.w  #1,d1                           ; was: sub_4213A
                lea     (PlayerObjectType).w,a0
                move.w  PlayerXPosition-PlayerObjectType(a0),d0
                sub.w   $10(a5),d0
                bhi.s   EntityType1C0_GetDirectionToPlayerReturn
                neg.w   d1
EntityType1C0_GetDirectionToPlayerReturn:               ; CODE XREF: EntityType1C0_GetDirectionToPlayer+10   j  ; was: locret_4214E
                rts
; End of function EntityType1C0_GetDirectionToPlayer
; Descends while firing, then enables collision on all four chains
EntityType1C0_DescendAndActivateChainsState:            ; DATA XREF: ROM:00041964   o  ; was: sub_42150
                addi.l  #$400,$1C(a5)
                move.l  #$200020,d1
                jsr     (EntityType1C0_SpawnRandomOffsetProjectile).l
                cmpi.w  #$1C0,$14(a5)
                bcs.w   EntityType1C0_SecondFormUpdateBody
                addq.w  #2,4(a5)
                move.b  #$20,$4B(a5)                    ; ' '
                clr.l   $1C(a5)
                ori.b   #$40,$4A1(a5)                   ; '@'
                ori.b   #$10,$4A3(a5)
                ori.b   #$40,$6E1(a5)                   ; '@'
                ori.b   #$10,$6E3(a5)
                ori.b   #$40,$921(a5)                   ; '@'
                ori.b   #$10,$923(a5)
                ori.b   #$40,$B61(a5)                   ; '@'
                ori.b   #$10,$B63(a5)
                bra.w   EntityType1C0_SecondFormUpdateBody
; End of function EntityType1C0_DescendAndActivateChainsState
; Waits while firing, then activates the eight trail objects
EntityType1C0_WaitThenActivateTrailState:               ; DATA XREF: ROM:00041966   o  ; was: sub_421B0
                move.l  #$400040,d1
                jsr     (EntityType1C0_SpawnRandomOffsetProjectile).l
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_SecondFormUpdateBody
                addq.w  #2,4(a5)
                move.w  $14(a5),(EntityType1C0TrailSpan).w
                clr.w   (EntityType1C0TrailStep).w
                lea     $BA0(a5),a4
                move.w  #7,d4
EntityType1C0_ActivateTrailObjectsLoop:                 ; CODE XREF: EntityType1C0_WaitThenActivateTrailState+3A   j  ; was: loc_421DA
                move.w  $14(a5),$14(a4)
                ori.w   #$8000,2(a4)
                lea     $60(a4),a4
                dbf     d4,EntityType1C0_ActivateTrailObjectsLoop
                bra.w   EntityType1C0_SecondFormUpdateBody
; End of function EntityType1C0_WaitThenActivateTrailState
; Contracts the vertical trail span until it reaches $80
EntityType1C0_ContractTrailState:                       ; DATA XREF: ROM:00041968   o  ; was: sub_421F2
                move.l  #$400040,d1
                jsr     (EntityType1C0_SpawnRandomOffsetProjectile).l
                addq.w  #1,(EntityType1C0TrailStep).w
                move.w  (EntityType1C0TrailStep).w,d0
                lsr.w   #2,d0
                sub.w   d0,(EntityType1C0TrailSpan).w
                cmpi.w  #$80,(EntityType1C0TrailSpan).w
                bhi.w   EntityType1C0_SecondFormUpdateBody
                addq.w  #2,4(a5)
                move.b  #$20,$4B(a5)                    ; ' '
                bra.w   EntityType1C0_SecondFormUpdateBody
; End of function EntityType1C0_ContractTrailState
; Finishes the trail transition and returns to health-state selection
EntityType1C0_FinishTrailTransitionState:               ; DATA XREF: ROM:0004196A   o  ; was: sub_42224
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_SecondFormUpdateBody
                clr.b   (BossColorEffectFlags).w
                bra.w   EntityType1C0_CheckHealthThreshold
; End of function EntityType1C0_FinishTrailTransitionState
; Calculates a direction-dependent horizontal screen offset
EntityType1C0_CalculateDirectionalScreenOffset:
                move.w  (PrimaryCameraXPosition).w,d0   ; was: sub_42234
                add.w   $10(a5),d0
                tst.w   $18(a5)
                bpl.s   EntityType1C0_CalculateRightwardScreenOffset
                subi.w  #$12C0,d0
                rts
; ---------------------------------------------------------------------------
EntityType1C0_CalculateRightwardScreenOffset:           ; CODE XREF: EntityType1C0_CalculateDirectionalScreenOffset+C   j  ; was: loc_42248
                move.w  #$1400,d1
                sub.w   d0,d1
                rts
; End of function EntityType1C0_CalculateDirectionalScreenOffset
; Faces the player and adds the caller-provided angle offset
EntityType1C0_FacePlayerWithAngleOffset:
                andi.w  #$F7FF,$E(a5)                   ; was: sub_42250
                movem.l d3,-(sp)
                lea     (PlayerObjectType).w,a4
                jsr     (Physics_CalculateAngleToTarget).l
                movem.l (sp)+,d3
                move.b  d0,d2
                bpl.s   EntityType1C0_StoreFacingAngle
                ori.w   #$800,$E(a5)
                neg.b   d2
EntityType1C0_StoreFacingAngle:                         ; CODE XREF: EntityType1C0_FacePlayerWithAngleOffset+1A   j  ; was: loc_42274
                move.w  d3,$5A(a5)
                add.w   $5A(a5),d2
                move.w  d2,6(a5)
                rts
; End of function EntityType1C0_FacePlayerWithAngleOffset
; Moves the body angle one quarter of the way toward the facing angle
EntityType1C0_InterpolateBodyAngle:
                move.w  $56(a5),d1                      ; was: sub_42282
                lsr.w   #1,d1
                move.w  6(a5),d0
                sub.b   d1,d0
                asr.b   #2,d0
                ext.w   d0
                add.w   d0,$56(a5)
                rts
; End of function EntityType1C0_InterpolateBodyAngle
; Shared update for the later segmented form
EntityType1C0_SecondFormUpdate:                         ; CODE XREF: EntityType1C0_BeginChainOscillationState+12   j  ; was: sub_42298
                                        ; EntityType1C0_OscillateChainsState+A4   j
                lea     $960(a5),a4
                jsr     EntityType1C0_UpdateChainEndpointMotion(pc)  ; (pc)
                nop
                lea     $2A0(a5),a4
                jsr     EntityType1C0_UpdateChainEndpointMotion(pc)  ; (pc)
                nop
                lea     $4E0(a5),a4
                jsr     EntityType1C0_UpdateChainEndpointMotion(pc)  ; (pc)
                nop
                lea     $720(a5),a4
                jsr     EntityType1C0_UpdateChainEndpointMotion(pc)  ; (pc)
                nop
EntityType1C0_SecondFormUpdateBody:                     ; CODE XREF: EntityType1C0_UpdateMovement+138   j  ; was: loc_422C0
                                        ; EntityType1C0_DescendAndActivateChainsState+1A   j
                move.b  (EntityType1C0AimAngle).w,d0
                add.w   d0,d0
                sub.w   $56(a5),d0
                move.w  d0,$B6(a5)
                btst    #2,(BossColorEffectFlags).w
                bne.s   EntityType1C0_SecondFormRender
                btst    #1,(BossColorEffectFlags).w
                bne.s   EntityType1C0_SecondFormRender
                move.w  (BossHealth).w,d0
                beq.w   EntityType1C0_ResetAfterPrimaryHealthDepletion
                tst.b   (SecondaryEntityWork5C).w
                bne.s   EntityType1C0_SecondFormRender
                cmpi.w  #$3000,d0
                bhi.s   EntityType1C0_SecondFormRender
                move.b  #1,(SecondaryEntityWork5C).w
                move.w  #$1E,4(a5)
                move.b  #6,(BossColorEffectFlags).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
EntityType1C0_SecondFormRender:                         ; CODE XREF: EntityType1C0_SecondFormUpdate+3C   j  ; was: loc_4230C
                                        ; EntityType1C0_SecondFormUpdate+44   j
                lea     EntityType1C0_SecondFormBodyPartInitTable(pc),a1
                jsr     (EntityType1C0_UpdateBodyPartPositions).l
                bsr.w   EntityType1C0_UpdateScreenBounds
                lea     EntityType1C0_SecondFormTileAnimationOffsets(pc),a0
                move.w  (PrimaryEntityWork5E).w,d0
                lsr.w   #2,d0
                bsr.w   Gfx_LoadIndexedAnimationTiles
                addq.w  #1,(PrimaryEntityWork5E).w
                ori.w   #$1800,$48E(a5)
                andi.w  #$E7FF,$6CE(a5)
                andi.w  #$E7FF,$90E(a5)
                ori.w   #$1800,$B4E(a5)
                bsr.w   EntityType1C0_UpdateTrail
                rts
; End of function EntityType1C0_SecondFormUpdate
; Propagates chain angles and derives endpoint motion
EntityType1C0_UpdateChainEndpointMotion:                ; CODE XREF: EntityType1C0_SecondFormUpdate+4   p  ; was: sub_4234A
                                        ; EntityType1C0_SecondFormUpdate+E   p
                move.w  $58(a4),d2
                tst.b   d2
                bpl.s   EntityType1C0_NormalizeChainRootAngle
                neg.b   d2
                subq.b  #1,d2
EntityType1C0_NormalizeChainRootAngle:                  ; CODE XREF: EntityType1C0_UpdateChainEndpointMotion+6   j  ; was: loc_42356
                andi.w  #$7F,d2
                subi.w  #$40,d2                         ; '@'
                lea     $60(a4),a3
                move.w  d2,$56(a3)
                move.w  #4,d4
EntityType1C0_CopyChainLinkAnglesLoop:                  ; CODE XREF: EntityType1C0_UpdateChainEndpointMotion+2A   j  ; was: loc_4236A
                move.w  $B6(a4),$56(a3)
                adda.w  #$60,a3                         ; '`'
                dbf     d4,EntityType1C0_CopyChainLinkAnglesLoop
                movea.l #Math_SineTable,a2
                move.w  $56(a5),d1
                add.w   $56(a4),d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  $4C(a4),d0
                muls.w  $4C(a4),d1
                add.l   -$4C(a3),d0
                sub.l   $14(a4),d0
                move.l  -4(a3),d2
                move.l  d0,-4(a3)
                sub.l   d2,d0
                neg.l   d0
                move.l  d0,-$44(a3)
                add.l   -$50(a3),d1
                sub.l   $10(a4),d1
                move.l  -8(a3),d0
                move.l  d1,-8(a3)
                sub.l   d0,d1
                neg.l   d1
                move.l  d1,-$48(a3)
                rts
; End of function EntityType1C0_UpdateChainEndpointMotion
; Resolves an indexed animation entry and loads its compressed tiles
Gfx_LoadIndexedAnimationTiles:                          ; CODE XREF: EntityType1C0_SecondFormUpdate+8C   p  ; was: sub_423CE
                and.w   (a0)+,d0
                adda.w  d0,a0
                adda.w  (a0),a0
                jmp     Tilemap_QueueIndexedRows
; End of function Gfx_LoadIndexedAnimationTiles
; Resets the form controller after primary boss health reaches zero
EntityType1C0_ResetAfterPrimaryHealthDepletion:         ; CODE XREF: EntityType1C0_SecondFormUpdate+4A   j  ; was: sub_423DA
                bset    #0,(StageTimerPauseFlag).w
                move.w  #4,(PlaneAShakeLevel).w
                move.w  #4,(PlaneBShakeLevel).w
                move.w  #$7FFF,(BossHealth).w
                clr.b   (SecondaryEntityWork5C).w
                clr.w   4(a5)
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                bra.w   EntityType1C0_SecondFormUpdate
; End of function EntityType1C0_ResetAfterPrimaryHealthDepletion
; Waits, then scatters the body parts with randomized motion
EntityType1C0_ScatterSecondFormBodyPartsState:
                subq.b  #1,$4B(a5)                      ; was: sub_4240A
                bne.w   EntityType1C0_SecondFormUpdate
                addq.w  #2,4(a5)
                clr.b   $21(a5)
                move.w  (PrimaryEntityWork5C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
                lea     (Math_SineTable).l,a2
EntityType1C0_InitializeScatteredBodyPartsLoop:         ; CODE XREF: EntityType1C0_ScatterSecondFormBodyPartsState+6A   j  ; was: loc_4242A
                move.w  #$CD40,2(a4)
                jsr     (RandomNumber).l
                rol.l   #8,d0
                move.w  d0,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  #4,d1
                muls.w  #4,d0
                move.l  d1,$18(a4)
                move.l  d0,$1C(a4)
                clr.b   $4B(a4)
                jsr     (RandomNumber).l
                rol.l   #8,d0
                ext.w   d0
                asr.w   #3,d0
                move.w  d0,$5C(a4)
                clr.b   $21(a4)
                lea     $60(a4),a4
                dbf     d4,EntityType1C0_InitializeScatteredBodyPartsLoop
                addi.l  #$800,$1C(a5)
                cmpi.w  #$1C0,$14(a5)
                bhi.s   EntityType1C0_BeginStaggeredBodyPartRemoval
                move.l  #$200020,d1
                bsr.w   EntityType1C0_SpawnDefeatImpact
                bsr.w   EntityType1C0_UpdateScreenBounds
                rts
; ---------------------------------------------------------------------------
EntityType1C0_BeginStaggeredBodyPartRemoval:            ; CODE XREF: EntityType1C0_ScatterSecondFormBodyPartsState+7C   j  ; was: loc_42498
                move.b  #$40,$4B(a5)                    ; '@'
                addq.w  #2,4(a5)
                move.w  #1,d5
                move.w  (PrimaryEntityWork5C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
EntityType1C0_AssignBodyPartRemovalDelayLoop:           ; CODE XREF: EntityType1C0_ScatterSecondFormBodyPartsState+B0   j  ; was: loc_424B0
                move.b  d5,$4B(a4)
                addq.w  #1,d5
                lea     $60(a4),a4
                dbf     d4,EntityType1C0_AssignBodyPartRemovalDelayLoop
                rts
; End of function EntityType1C0_ScatterSecondFormBodyPartsState
; Holds the scroll mode, then removes the form controller
EntityType1C0_RemoveAfterBodyPartFadeState:
                move.w  #4,(PlaneAShakeLevel).w         ; was: sub_424C0
                move.w  #4,(PlaneBShakeLevel).w
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_RemoveAfterBodyPartFadeReturn
                clr.w   (a5)
EntityType1C0_RemoveAfterBodyPartFadeReturn:            ; CODE XREF: EntityType1C0_RemoveAfterBodyPartFadeState+10   j  ; was: locret_424D6
                rts
; End of function EntityType1C0_RemoveAfterBodyPartFadeState
; Animates a scattered body part until its staggered removal delay expires
EntityType1C0_UpdateScatteredBodyPart:
                tst.b   $4B(a5)                         ; was: sub_424D8
                beq.s   EntityType1C0_AnimateScatteredBodyPart
                subq.b  #1,$4B(a5)
                beq.s   EntityType1C0_ConvertBodyPartToExplosion
EntityType1C0_AnimateScatteredBodyPart:                 ; CODE XREF: EntityType1C0_UpdateScatteredBodyPart+4   j  ; was: loc_424E4
                move.w  $5C(a5),d0
                add.w   d0,$56(a5)
                move.l  $50(a5),d0
                beq.s   EntityType1C0_UpdateScatteredBodyPartReturn
                movea.l d0,a1
                move.w  $56(a5),d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a5)
EntityType1C0_UpdateScatteredBodyPartReturn:            ; CODE XREF: EntityType1C0_UpdateScatteredBodyPart+18   j  ; was: locret_42504
                rts
; ---------------------------------------------------------------------------
EntityType1C0_ConvertBodyPartToExplosion:               ; CODE XREF: EntityType1C0_UpdateScatteredBodyPart+A   j  ; was: loc_42506
                lea     (a5),a0
                jsr     (Effect_InitSharedExplosion).l
                clr.b   $21(a5)
                rts
; End of function EntityType1C0_UpdateScatteredBodyPart
; Spawns a shared impact sprite at a random offset with mirrored velocity
EntityType1C0_SpawnDefeatImpact:                        ; CODE XREF: EntityType1C0_ScatterSecondFormBodyPartsState+84   p  ; was: sub_42514
                move.l  d1,-(sp)
                jsr     (Projectile_PrepareImpactSpawn).l
                bne.s   EntityType1C0_SpawnDefeatImpactReturn
                jsr     (Sprite_InitFromTable).l
                clr.b   $20(a0)
                move.l  $18(a5),$18(a0)
                move.l  $1C(a5),$1C(a0)
                neg.l   $18(a0)
                neg.l   $1C(a0)
                move.b  (RandomNumberState).w,d0
                move.b  (RandomNumberState+1).w,d1
                move.w  (sp),d2
                add.w   d2,d2
                subq.w  #1,d2
                and.w   d2,d0
                sub.w   (sp),d0
                move.w  2(sp),d2
                add.w   d2,d2
                subq.w  #1,d2
                and.w   d2,d1
                sub.w   2(sp),d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
EntityType1C0_SpawnDefeatImpactReturn:                  ; CODE XREF: EntityType1C0_SpawnDefeatImpact+8   j  ; was: loc_4256C
                move.l  (sp)+,d1
                rts
; End of function EntityType1C0_SpawnDefeatImpact
; Updates boss screen boundary values
EntityType1C0_UpdateScreenBounds:                       ; CODE XREF: EntityType1C0_SecondFormUpdate+7E   p  ; was: sub_42570
                                        ; EntityType1C0_ScatterSecondFormBodyPartsState+88   p
                move.w  #$A8,d0
                sub.w   $10(a5),d0
                move.w  d0,(SecondaryCameraXPos).w
                move.w  $14(a5),d0
                addi.w  #$48,d0                         ; 'H'
                move.w  d0,(SecondaryCameraYPos).w
                jmp     Boss_ClampSharedScreenPosition
; End of function EntityType1C0_UpdateScreenBounds
; ---------------------------------------------------------------------------
EntityType1C0_SecondFormBodyPartInitTable:
                dc.l    EntityType1C0_BodyPartSpriteDescriptorA  ; DATA XREF: EntityType1C0_SecondFormLoadGraphicsState+28   o  ; was: off_4258E
                                        ; EntityType1C0_SecondFormUpdate:EntityType1C0_SecondFormRender   o
                dc.l    0
                dc.l    $80000001
                dc.l    EntityType1C0_BodyPartSpriteDescriptorA
                dc.l    $100140
                dc.l    $80000000
                dc.l    $80000001
                dc.l    EntityType1C0_SecondFormSpriteMapping
                dc.l    $A10000
                dc.l    $80000001
                dc.l    EntityType1C0_BodyPartSpriteDescriptorC
                dc.l    $200190
                dc.l    $80000000
                dc.l    $80000001
                dc.l    EntityType1C0_BodyPartSpriteDescriptorC
                dc.l    $200070
                dc.l    $80000000
                dc.l    $80000001
                dc.l    EntityType1C0_BodyPartSpriteDescriptorD
                dc.l    $3001D0
                dc.l    $80000000
                dc.l    $80000001
                dc.l    EntityType1C0_BodyPartSpriteDescriptorD
                dc.l    $300030
                dc.l    $80000000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $A10040
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    SharedVictorSunsetStingSegmentMappingA
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $A100C0
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    SharedVictorSunsetStingSegmentMappingA
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $A10140
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    SharedVictorSunsetStingSegmentMappingA
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $A101C0
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    EntityType1C0_BodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    SharedVictorSunsetStingSegmentMappingA
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000000
EntityType1C0_SecondFormObjectInitTable:
                dc.w    $C620, $1408, $E41C, $E41C, $10, $C6E0, $1078, $F010, $F010, $10, $CAA0, $1008, $F010, $F010, $10, $C980  ; was: word_426DA
                                        ; DATA XREF: EntityType1C0_SecondFormLoadGraphicsState+C   o
                dc.w    $1008, $F010, $F010, $10, $CCE0, $1008, $F010, $F010, $10, $CBC0, $1008, $F010, $F010, $10, $CF20, $1008
                dc.w    $F010, $F010, $10, $CE00, $1008, $F010, $F010, $10, $D160, $1008, $F010, $F010, $10, $D040, $1008, $F010
                dc.w    $F010, $10, $FFFE

; Initializes eight trail objects with graphics pointer and properties
EntityType1C0_InitTrail:                                ; CODE XREF: EntityType1C0_SecondFormLoadGraphicsState+34   p  ; was: sub_42740
                lea     $BA0(a5),a4
                move.w  #7,d4
EntityType1C0_InitTrailLoop:                            ; CODE XREF: EntityType1C0_InitTrail+2A   j  ; was: loc_42748
                move.w  #$4000,2(a4)
                move.l  #EntityType1C0_BodyPartSpriteDescriptorB,8(a4)
                move.w  #$10,(a4)
                move.w  $E(a5),$E(a4)
                move.b  #$C8,$20(a4)
                lea     $60(a4),a4
                dbf     d4,EntityType1C0_InitTrailLoop
                rts
; End of function EntityType1C0_InitTrail
; Updates trail-object positions following boss movement
EntityType1C0_UpdateTrail:                              ; CODE XREF: EntityType1C0_SecondFormUpdate+AC   p  ; was: sub_42770
                lea     $BA0(a5),a4
                btst    #7,2(a4)
                beq.s   EntityType1C0_UpdateTrailReturn
                move.w  $10(a5),d1
                move.l  $14(a5),d2
                subi.l  #$200000,d2
                move.l  d2,d3
                moveq   #0,d0
                move.w  (EntityType1C0TrailSpan).w,d0
                swap    d0
                sub.l   d0,d3
                asr.l   #3,d3
                move.w  #7,d4
EntityType1C0_PositionTrailObjectsLoop:                 ; CODE XREF: EntityType1C0_UpdateTrail+3A   j  ; was: loc_4279C
                move.w  d1,$10(a4)
                move.l  d2,$14(a4)
                sub.l   d3,d2
                lea     $60(a4),a4
                dbf     d4,EntityType1C0_PositionTrailObjectsLoop
EntityType1C0_UpdateTrailReturn:                        ; CODE XREF: EntityType1C0_UpdateTrail+A   j  ; was: locret_427AE
                rts
; End of function EntityType1C0_UpdateTrail
