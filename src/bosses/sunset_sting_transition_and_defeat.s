; Enters the chain-oscillation state after the low-health transition
Boss_SunsetStingBeginChainOscillationState:             ; CODE XREF: Boss_SunsetStingCheckPhaseTransition+4   j  ; was: sub_4200A
                move.w  #$1A,4(a5)
                move.b  #0,$4B(a5)
                move.w  #4,(dword_FFC6D8).w
                bra.w   Boss_SunsetStingSecondFormUpdate
; End of function Boss_SunsetStingBeginChainOscillationState
; Moves five link radii one unit toward the requested radius
Boss_SunsetStingApproachChainLinkRadius:                ; CODE XREF: Boss_SunsetStingUpdateAllChainRadii+4   p  ; was: sub_42020
                                        ; Boss_SunsetStingUpdateAllChainRadii+A   p
                lea     $60(a4),a3
                move.w  #4,d4
Boss_SunsetStingApproachChainLinkRadiusLoop:            ; CODE XREF: Boss_SunsetStingApproachChainLinkRadius+1E   j  ; was: loc_42028
                move.w  #1,d0
                cmp.w   $4C(a3),d2
                beq.s   Boss_SunsetStingApproachChainLinkRadiusAdvance
                bpl.s   Boss_SunsetStingApproachChainLinkRadiusApplyStep
                neg.w   d0
Boss_SunsetStingApproachChainLinkRadiusApplyStep:       ; CODE XREF: Boss_SunsetStingApproachChainLinkRadius+12   j  ; was: loc_42036
                add.w   d0,$4C(a3)
Boss_SunsetStingApproachChainLinkRadiusAdvance:         ; CODE XREF: Boss_SunsetStingApproachChainLinkRadius+10   j  ; was: loc_4203A
                adda.w  #$60,a3                         ; '`'
                dbf     d4,Boss_SunsetStingApproachChainLinkRadiusLoop
                rts
; End of function Boss_SunsetStingApproachChainLinkRadius
; Updates the link radii of all four chains
Boss_SunsetStingUpdateAllChainRadii:                    ; CODE XREF: Boss_SunsetStingOscillateChainsState+96   p  ; was: sub_42044
                lea     $2A0(a5),a4
                bsr.s   Boss_SunsetStingApproachChainLinkRadius
                lea     $4E0(a5),a4
                bsr.s   Boss_SunsetStingApproachChainLinkRadius
                lea     $720(a5),a4
                bsr.s   Boss_SunsetStingApproachChainLinkRadius
                lea     $960(a5),a4
                bsr.s   Boss_SunsetStingApproachChainLinkRadius
                rts
; End of function Boss_SunsetStingUpdateAllChainRadii
; Oscillates the chain angles while moving between vertical bounds
Boss_SunsetStingOscillateChainsState:                   ; DATA XREF: ROM:00041960   o  ; was: sub_4205E
                move.w  #1,d1
                btst    #0,(word_FFA000).w
                bne.s   Boss_SunsetStingAdvanceChainOscillationPhase
                neg.w   d1
Boss_SunsetStingAdvanceChainOscillationPhase:           ; CODE XREF: Boss_SunsetStingOscillateChainsState+A   j  ; was: loc_4206C
                add.w   d1,(dword_FFC6D8).w
                move.w  #$70,d1                         ; 'p'
                move.w  d1,d2
                move.w  (dword_FFC6D8).w,d0
                bpl.s   Boss_SunsetStingClampChainOscillationPhase
                neg.w   d0
                neg.w   d1
Boss_SunsetStingClampChainOscillationPhase:             ; CODE XREF: Boss_SunsetStingOscillateChainsState+1C   j  ; was: loc_42080
                cmp.w   d2,d0
                bcs.s   Boss_SunsetStingUpdateOscillationVelocity
                move.w  d1,(dword_FFC6D8).w
Boss_SunsetStingUpdateOscillationVelocity:              ; CODE XREF: Boss_SunsetStingOscillateChainsState+24   j  ; was: loc_42088
                movea.l #Math_SineTable,a2
                move.b  (dword_FFC6DC+1).w,d1
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
                beq.s   Boss_SunsetStingSetUpwardVelocity
                bpl.s   Boss_SunsetStingCheckLowerVerticalBound
                cmpi.w  #$C0,d1
                bhi.s   Boss_SunsetStingUpdateOscillatingChains
                move.l  #$10000,$1C(a5)
                bra.w   Boss_SunsetStingUpdateOscillatingChains
; ---------------------------------------------------------------------------
Boss_SunsetStingCheckLowerVerticalBound:                ; CODE XREF: Boss_SunsetStingOscillateChainsState+5A   j  ; was: loc_420CC
                cmpi.w  #$160,d1
                bcs.s   Boss_SunsetStingUpdateOscillatingChains
Boss_SunsetStingSetUpwardVelocity:                      ; CODE XREF: Boss_SunsetStingOscillateChainsState+58   j  ; was: loc_420D2
                move.l  #$FFFF0000,$1C(a5)
                bra.w   *+4
; ---------------------------------------------------------------------------
Boss_SunsetStingUpdateOscillatingChains:                ; CODE XREF: Boss_SunsetStingOscillateChainsState+60   j  ; was: loc_420DE
                                        ; Boss_SunsetStingOscillateChainsState+6A   j
                move.w  (dword_FFC6D8).w,d0
                bsr.w   Boss_SunsetStingUpdateChainRootAngles
                move.w  (dword_FFC6D8).w,d2
                bpl.s   Boss_SunsetStingUseOscillationMagnitude
                neg.w   d2
Boss_SunsetStingUseOscillationMagnitude:                ; CODE XREF: Boss_SunsetStingOscillateChainsState+8C   j  ; was: loc_420EE
                lsr.w   #2,d2
                addi.w  #$20,d2                         ; ' '
                bsr.w   Boss_SunsetStingUpdateAllChainRadii
                move.w  (dword_FFC6D8).w,d1
                asr.w   #3,d1
                add.w   d1,$56(a5)
                bra.w   Boss_SunsetStingSecondFormUpdate
; End of function Boss_SunsetStingOscillateChainsState
; Supplies a common target angle to all four chain roots
Boss_SunsetStingUpdateChainRootAngles:                  ; CODE XREF: Boss_SunsetStingOscillateChainsState+84   p  ; was: sub_42106
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                lea     (sp),a3
                bsr.w   Boss_SunsetStingInterpolateChainRootAngles
                addq.w  #8,sp
                rts
; End of function Boss_SunsetStingUpdateChainRootAngles
; Smoothly approaches the target angle of each chain root
Boss_SunsetStingInterpolateChainRootAngles:             ; CODE XREF: Boss_SunsetStingUpdateChainRootAngles+A   p  ; was: sub_42118
                lea     Boss_SunsetStingChainRootOffsets(pc),a2
                move.w  #3,d4
Boss_SunsetStingInterpolateChainRootAnglesLoop:         ; CODE XREF: Boss_SunsetStingInterpolateChainRootAngles+1C   j  ; was: loc_42120
                movea.w (a2)+,a4
                adda.w  a5,a4
                move.w  (word_FFC67A).w,d2
                add.w   (a3)+,d2
                sub.w   $58(a4),d2
                asr.w   #3,d2
                add.w   d2,$58(a4)
                dbf     d4,Boss_SunsetStingInterpolateChainRootAnglesLoop
                rts
; End of function Boss_SunsetStingInterpolateChainRootAngles
; Calculates horizontal direction to player
Boss_SunsetStingGetDirectionToPlayer:
                move.w  #1,d1                           ; was: sub_4213A
                lea     (word_FFA400).w,a0
                move.w  dword_FFA410-word_FFA400(a0),d0
                sub.w   $10(a5),d0
                bhi.s   Boss_SunsetStingGetDirectionToPlayerReturn
                neg.w   d1
Boss_SunsetStingGetDirectionToPlayerReturn:             ; CODE XREF: Boss_SunsetStingGetDirectionToPlayer+10   j  ; was: locret_4214E
                rts
; End of function Boss_SunsetStingGetDirectionToPlayer
; Descends while firing, then enables collision on all four chains
Boss_SunsetStingDescendAndActivateChainsState:          ; DATA XREF: ROM:00041964   o  ; was: sub_42150
                addi.l  #$400,$1C(a5)
                move.l  #$200020,d1
                jsr     (Boss_SunsetStingSpawnRandomOffsetProjectile).l
                cmpi.w  #$1C0,$14(a5)
                bcs.w   Boss_SunsetStingSecondFormUpdateBody
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
                bra.w   Boss_SunsetStingSecondFormUpdateBody
; End of function Boss_SunsetStingDescendAndActivateChainsState
; Waits while firing, then activates the eight trail objects
Boss_SunsetStingWaitThenActivateTrailState:             ; DATA XREF: ROM:00041966   o  ; was: sub_421B0
                move.l  #$400040,d1
                jsr     (Boss_SunsetStingSpawnRandomOffsetProjectile).l
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingSecondFormUpdateBody
                addq.w  #2,4(a5)
                move.w  $14(a5),(word_FFC738).w
                clr.w   (word_FFC73C).w
                lea     $BA0(a5),a4
                move.w  #7,d4
Boss_SunsetStingActivateTrailObjectsLoop:               ; CODE XREF: Boss_SunsetStingWaitThenActivateTrailState+3A   j  ; was: loc_421DA
                move.w  $14(a5),$14(a4)
                ori.w   #$8000,2(a4)
                lea     $60(a4),a4
                dbf     d4,Boss_SunsetStingActivateTrailObjectsLoop
                bra.w   Boss_SunsetStingSecondFormUpdateBody
; End of function Boss_SunsetStingWaitThenActivateTrailState
; Contracts the vertical trail span until it reaches $80
Boss_SunsetStingContractTrailState:                     ; DATA XREF: ROM:00041968   o  ; was: sub_421F2
                move.l  #$400040,d1
                jsr     (Boss_SunsetStingSpawnRandomOffsetProjectile).l
                addq.w  #1,(word_FFC73C).w
                move.w  (word_FFC73C).w,d0
                lsr.w   #2,d0
                sub.w   d0,(word_FFC738).w
                cmpi.w  #$80,(word_FFC738).w
                bhi.w   Boss_SunsetStingSecondFormUpdateBody
                addq.w  #2,4(a5)
                move.b  #$20,$4B(a5)                    ; ' '
                bra.w   Boss_SunsetStingSecondFormUpdateBody
; End of function Boss_SunsetStingContractTrailState
; Finishes the trail transition and returns to health-state selection
Boss_SunsetStingFinishTrailTransitionState:             ; DATA XREF: ROM:0004196A   o  ; was: sub_42224
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingSecondFormUpdateBody
                clr.b   (byte_FF80EC).w
                bra.w   Boss_SunsetStingCheckHealthThreshold
; End of function Boss_SunsetStingFinishTrailTransitionState
; Calculates a direction-dependent horizontal screen offset
Boss_SunsetStingCalculateDirectionalScreenOffset:
                move.w  (dword_FFA900).w,d0             ; was: sub_42234
                add.w   $10(a5),d0
                tst.w   $18(a5)
                bpl.s   Boss_SunsetStingCalculateRightwardScreenOffset
                subi.w  #$12C0,d0
                rts
; ---------------------------------------------------------------------------
Boss_SunsetStingCalculateRightwardScreenOffset:         ; CODE XREF: Boss_SunsetStingCalculateDirectionalScreenOffset+C   j  ; was: loc_42248
                move.w  #$1400,d1
                sub.w   d0,d1
                rts
; End of function Boss_SunsetStingCalculateDirectionalScreenOffset
; Faces the player and adds the caller-provided angle offset
Boss_SunsetStingFacePlayerWithAngleOffset:
                andi.w  #$F7FF,$E(a5)                   ; was: sub_42250
                movem.l d3,-(sp)
                lea     (word_FFA400).w,a4
                jsr     (Physics_CalculateAngleToTarget).l
                movem.l (sp)+,d3
                move.b  d0,d2
                bpl.s   Boss_SunsetStingStoreFacingAngle
                ori.w   #$800,$E(a5)
                neg.b   d2
Boss_SunsetStingStoreFacingAngle:                       ; CODE XREF: Boss_SunsetStingFacePlayerWithAngleOffset+1A   j  ; was: loc_42274
                move.w  d3,$5A(a5)
                add.w   $5A(a5),d2
                move.w  d2,6(a5)
                rts
; End of function Boss_SunsetStingFacePlayerWithAngleOffset
; Moves the body angle one quarter of the way toward the facing angle
Boss_SunsetStingInterpolateBodyAngle:
                move.w  $56(a5),d1                      ; was: sub_42282
                lsr.w   #1,d1
                move.w  6(a5),d0
                sub.b   d1,d0
                asr.b   #2,d0
                ext.w   d0
                add.w   d0,$56(a5)
                rts
; End of function Boss_SunsetStingInterpolateBodyAngle
; Shared update for the later segmented form
Boss_SunsetStingSecondFormUpdate:                       ; CODE XREF: Boss_SunsetStingBeginChainOscillationState+12   j  ; was: sub_42298
                                        ; Boss_SunsetStingOscillateChainsState+A4   j
                lea     $960(a5),a4
                jsr     Boss_SunsetStingUpdateChainEndpointMotion(pc)  ; (pc)
                nop
                lea     $2A0(a5),a4
                jsr     Boss_SunsetStingUpdateChainEndpointMotion(pc)  ; (pc)
                nop
                lea     $4E0(a5),a4
                jsr     Boss_SunsetStingUpdateChainEndpointMotion(pc)  ; (pc)
                nop
                lea     $720(a5),a4
                jsr     Boss_SunsetStingUpdateChainEndpointMotion(pc)  ; (pc)
                nop
Boss_SunsetStingSecondFormUpdateBody:                   ; CODE XREF: Boss_SunsetStingUpdateMovement+138   j  ; was: loc_422C0
                                        ; Boss_SunsetStingDescendAndActivateChainsState+1A   j
                move.b  (byte_FFC73E).w,d0
                add.w   d0,d0
                sub.w   $56(a5),d0
                move.w  d0,$B6(a5)
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_SunsetStingSecondFormRender
                btst    #1,(byte_FF80EC).w
                bne.s   Boss_SunsetStingSecondFormRender
                move.w  (word_FF8200).w,d0
                beq.w   Boss_SunsetStingResetAfterPrimaryHealthDepletion
                tst.b   (dword_FFC6DC).w
                bne.s   Boss_SunsetStingSecondFormRender
                cmpi.w  #$3000,d0
                bhi.s   Boss_SunsetStingSecondFormRender
                move.b  #1,(dword_FFC6DC).w
                move.w  #$1E,4(a5)
                move.b  #6,(byte_FF80EC).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
Boss_SunsetStingSecondFormRender:                       ; CODE XREF: Boss_SunsetStingSecondFormUpdate+3C   j  ; was: loc_4230C
                                        ; Boss_SunsetStingSecondFormUpdate+44   j
                lea     Boss_SunsetStingSecondFormBodyPartInitTable(pc),a1
                jsr     (Boss_SunsetStingUpdateBodyPartPositions).l
                bsr.w   Boss_SunsetStingUpdateScreenBounds
                lea     Boss_SunsetStingSecondFormTileAnimationOffsets(pc),a0
                move.w  (word_FFC67E).w,d0
                lsr.w   #2,d0
                bsr.w   Gfx_LoadIndexedAnimationTiles
                addq.w  #1,(word_FFC67E).w
                ori.w   #$1800,$48E(a5)
                andi.w  #$E7FF,$6CE(a5)
                andi.w  #$E7FF,$90E(a5)
                ori.w   #$1800,$B4E(a5)
                bsr.w   Boss_SunsetStingUpdateTrail
                rts
; End of function Boss_SunsetStingSecondFormUpdate
; Propagates chain angles and derives endpoint motion
Boss_SunsetStingUpdateChainEndpointMotion:              ; CODE XREF: Boss_SunsetStingSecondFormUpdate+4   p  ; was: sub_4234A
                                        ; Boss_SunsetStingSecondFormUpdate+E   p
                move.w  $58(a4),d2
                tst.b   d2
                bpl.s   Boss_SunsetStingNormalizeChainRootAngle
                neg.b   d2
                subq.b  #1,d2
Boss_SunsetStingNormalizeChainRootAngle:                ; CODE XREF: Boss_SunsetStingUpdateChainEndpointMotion+6   j  ; was: loc_42356
                andi.w  #$7F,d2
                subi.w  #$40,d2                         ; '@'
                lea     $60(a4),a3
                move.w  d2,$56(a3)
                move.w  #4,d4
Boss_SunsetStingCopyChainLinkAnglesLoop:                ; CODE XREF: Boss_SunsetStingUpdateChainEndpointMotion+2A   j  ; was: loc_4236A
                move.w  $B6(a4),$56(a3)
                adda.w  #$60,a3                         ; '`'
                dbf     d4,Boss_SunsetStingCopyChainLinkAnglesLoop
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
; End of function Boss_SunsetStingUpdateChainEndpointMotion
; Resolves an indexed animation entry and loads its compressed tiles
Gfx_LoadIndexedAnimationTiles:                          ; CODE XREF: Boss_SunsetStingSecondFormUpdate+8C   p  ; was: sub_423CE
                and.w   (a0)+,d0
                adda.w  d0,a0
                adda.w  (a0),a0
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadIndexedAnimationTiles
; Resets the form controller after primary boss health reaches zero
Boss_SunsetStingResetAfterPrimaryHealthDepletion:       ; CODE XREF: Boss_SunsetStingSecondFormUpdate+4A   j  ; was: sub_423DA
                bset    #0,(byte_FFA272).w
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #$7FFF,(word_FF8200).w
                clr.b   (dword_FFC6DC).w
                clr.w   4(a5)
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                bra.w   Boss_SunsetStingSecondFormUpdate
; End of function Boss_SunsetStingResetAfterPrimaryHealthDepletion
; Waits, then scatters the body parts with randomized motion
Boss_SunsetStingScatterSecondFormBodyPartsState:
                subq.b  #1,$4B(a5)                      ; was: sub_4240A
                bne.w   Boss_SunsetStingSecondFormUpdate
                addq.w  #2,4(a5)
                clr.b   $21(a5)
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
                lea     (Math_SineTable).l,a2
Boss_SunsetStingInitializeScatteredBodyPartsLoop:       ; CODE XREF: Boss_SunsetStingScatterSecondFormBodyPartsState+6A   j  ; was: loc_4242A
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
                dbf     d4,Boss_SunsetStingInitializeScatteredBodyPartsLoop
                addi.l  #$800,$1C(a5)
                cmpi.w  #$1C0,$14(a5)
                bhi.s   Boss_SunsetStingBeginStaggeredBodyPartRemoval
                move.l  #$200020,d1
                bsr.w   Boss_SunsetStingSpawnDefeatImpact
                bsr.w   Boss_SunsetStingUpdateScreenBounds
                rts
; ---------------------------------------------------------------------------
Boss_SunsetStingBeginStaggeredBodyPartRemoval:          ; CODE XREF: Boss_SunsetStingScatterSecondFormBodyPartsState+7C   j  ; was: loc_42498
                move.b  #$40,$4B(a5)                    ; '@'
                addq.w  #2,4(a5)
                move.w  #1,d5
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
Boss_SunsetStingAssignBodyPartRemovalDelayLoop:         ; CODE XREF: Boss_SunsetStingScatterSecondFormBodyPartsState+B0   j  ; was: loc_424B0
                move.b  d5,$4B(a4)
                addq.w  #1,d5
                lea     $60(a4),a4
                dbf     d4,Boss_SunsetStingAssignBodyPartRemovalDelayLoop
                rts
; End of function Boss_SunsetStingScatterSecondFormBodyPartsState
; Holds the scroll mode, then removes the form controller
Boss_SunsetStingRemoveAfterBodyPartFadeState:
                move.w  #4,(word_FFA010).w              ; was: sub_424C0
                move.w  #4,(word_FFA014).w
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingRemoveAfterBodyPartFadeReturn
                clr.w   (a5)
Boss_SunsetStingRemoveAfterBodyPartFadeReturn:          ; CODE XREF: Boss_SunsetStingRemoveAfterBodyPartFadeState+10   j  ; was: locret_424D6
                rts
; End of function Boss_SunsetStingRemoveAfterBodyPartFadeState
; Animates a scattered body part until its staggered removal delay expires
Boss_SunsetStingUpdateScatteredBodyPart:
                tst.b   $4B(a5)                         ; was: sub_424D8
                beq.s   Boss_SunsetStingAnimateScatteredBodyPart
                subq.b  #1,$4B(a5)
                beq.s   Boss_SunsetStingConvertBodyPartToExplosion
Boss_SunsetStingAnimateScatteredBodyPart:               ; CODE XREF: Boss_SunsetStingUpdateScatteredBodyPart+4   j  ; was: loc_424E4
                move.w  $5C(a5),d0
                add.w   d0,$56(a5)
                move.l  $50(a5),d0
                beq.s   Boss_SunsetStingUpdateScatteredBodyPartReturn
                movea.l d0,a1
                move.w  $56(a5),d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a5)
Boss_SunsetStingUpdateScatteredBodyPartReturn:          ; CODE XREF: Boss_SunsetStingUpdateScatteredBodyPart+18   j  ; was: locret_42504
                rts
; ---------------------------------------------------------------------------
Boss_SunsetStingConvertBodyPartToExplosion:             ; CODE XREF: Boss_SunsetStingUpdateScatteredBodyPart+A   j  ; was: loc_42506
                lea     (a5),a0
                jsr     (Effect_InitSharedExplosion).l
                clr.b   $21(a5)
                rts
; End of function Boss_SunsetStingUpdateScatteredBodyPart
; Spawns a shared impact sprite at a random offset with mirrored velocity
Boss_SunsetStingSpawnDefeatImpact:                      ; CODE XREF: Boss_SunsetStingScatterSecondFormBodyPartsState+84   p  ; was: sub_42514
                move.l  d1,-(sp)
                jsr     (Projectile_UpdateWithImpactFrames).l
                bne.s   Boss_SunsetStingSpawnDefeatImpactReturn
                jsr     (Sprite_InitFromTable).l
                clr.b   $20(a0)
                move.l  $18(a5),$18(a0)
                move.l  $1C(a5),$1C(a0)
                neg.l   $18(a0)
                neg.l   $1C(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
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
Boss_SunsetStingSpawnDefeatImpactReturn:                ; CODE XREF: Boss_SunsetStingSpawnDefeatImpact+8   j  ; was: loc_4256C
                move.l  (sp)+,d1
                rts
; End of function Boss_SunsetStingSpawnDefeatImpact
; Updates boss screen boundary values
Boss_SunsetStingUpdateScreenBounds:                     ; CODE XREF: Boss_SunsetStingSecondFormUpdate+7E   p  ; was: sub_42570
                                        ; Boss_SunsetStingScatterSecondFormBodyPartsState+88   p
                move.w  #$A8,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$48,d0                         ; 'H'
                move.w  d0,(dword_FFA90C).w
                jmp     Boss_ClampSharedScreenPosition
; End of function Boss_SunsetStingUpdateScreenBounds
; ---------------------------------------------------------------------------
Boss_SunsetStingSecondFormBodyPartInitTable:
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorA  ; DATA XREF: Boss_SunsetStingSecondFormLoadGraphicsState+28   o  ; was: off_4258E
                                        ; Boss_SunsetStingSecondFormUpdate:Boss_SunsetStingSecondFormRender   o
                dc.l    0
                dc.l    $80000001
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorA
                dc.l    $100140
                dc.l    $80000000
                dc.l    $80000001
                dc.l    word_EBE88
                dc.l    $A10000
                dc.l    $80000001
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorC
                dc.l    $200190
                dc.l    $80000000
                dc.l    $80000001
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorC
                dc.l    $200070
                dc.l    $80000000
                dc.l    $80000001
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorD
                dc.l    $3001D0
                dc.l    $80000000
                dc.l    $80000001
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorD
                dc.l    $300030
                dc.l    $80000000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $A10040
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    word_EBE94
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $A100C0
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    word_EBE94
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $A10140
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    word_EBE94
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $A101C0
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    Boss_SunsetStingBodyPartSpriteDescriptorB
                dc.l    $210000
                dc.l    word_EBE94
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000000
Boss_SunsetStingSecondFormObjectInitTable:
                dc.w    $C620, $1408, $E41C, $E41C, $10, $C6E0, $1078, $F010, $F010, $10, $CAA0, $1008, $F010, $F010, $10, $C980  ; was: word_426DA
                                        ; DATA XREF: Boss_SunsetStingSecondFormLoadGraphicsState+C   o
                dc.w    $1008, $F010, $F010, $10, $CCE0, $1008, $F010, $F010, $10, $CBC0, $1008, $F010, $F010, $10, $CF20, $1008
                dc.w    $F010, $F010, $10, $CE00, $1008, $F010, $F010, $10, $D160, $1008, $F010, $F010, $10, $D040, $1008, $F010
                dc.w    $F010, $10, $FFFE

; Initializes eight trail objects with graphics pointer and properties
Boss_SunsetStingInitTrail:                              ; CODE XREF: Boss_SunsetStingSecondFormLoadGraphicsState+34   p  ; was: sub_42740
                lea     $BA0(a5),a4
                move.w  #7,d4
Boss_SunsetStingInitTrailLoop:                          ; CODE XREF: Boss_SunsetStingInitTrail+2A   j  ; was: loc_42748
                move.w  #$4000,2(a4)
                move.l  #Boss_SunsetStingBodyPartSpriteDescriptorB,8(a4)
                move.w  #$10,(a4)
                move.w  $E(a5),$E(a4)
                move.b  #$C8,$20(a4)
                lea     $60(a4),a4
                dbf     d4,Boss_SunsetStingInitTrailLoop
                rts
; End of function Boss_SunsetStingInitTrail
; Updates trail-object positions following boss movement
Boss_SunsetStingUpdateTrail:                            ; CODE XREF: Boss_SunsetStingSecondFormUpdate+AC   p  ; was: sub_42770
                lea     $BA0(a5),a4
                btst    #7,2(a4)
                beq.s   Boss_SunsetStingUpdateTrailReturn
                move.w  $10(a5),d1
                move.l  $14(a5),d2
                subi.l  #$200000,d2
                move.l  d2,d3
                moveq   #0,d0
                move.w  (word_FFC738).w,d0
                swap    d0
                sub.l   d0,d3
                asr.l   #3,d3
                move.w  #7,d4
Boss_SunsetStingPositionTrailObjectsLoop:               ; CODE XREF: Boss_SunsetStingUpdateTrail+3A   j  ; was: loc_4279C
                move.w  d1,$10(a4)
                move.l  d2,$14(a4)
                sub.l   d3,d2
                lea     $60(a4),a4
                dbf     d4,Boss_SunsetStingPositionTrailObjectsLoop
Boss_SunsetStingUpdateTrailReturn:                      ; CODE XREF: Boss_SunsetStingUpdateTrail+A   j  ; was: locret_427AE
                rts
; End of function Boss_SunsetStingUpdateTrail
; Calculates angle from X/Y velocity components
Physics_CalculateAngleFromVelocity:
                pea     Physics_AddAngleOffset(pc)      ; was: sub_427B0
                lea     Physics_AngleOctantBaseTable(pc),a0
                ext.l   d0
                beq.s   Physics_ReturnVerticalAxisAngle
                bpl.s   Physics_NormalizeVelocityX
                neg.l   d0
                addq.l  #4,a0
Physics_NormalizeVelocityX:                             ; CODE XREF: Physics_CalculateAngleFromVelocity+C   j  ; was: loc_427C2
                ext.l   d1
                beq.s   Physics_ReturnHorizontalAxisAngle
                bpl.s   Physics_NormalizeVelocityY
                neg.l   d1
                addq.l  #2,a0
Physics_NormalizeVelocityY:                             ; CODE XREF: Physics_CalculateAngleFromVelocity+16   j  ; was: loc_427CC
                bra.s   Physics_OrderAngleRatioComponents
; End of function Physics_CalculateAngleFromVelocity
; Computes a vertical-axis angle from the target position
Physics_CalculateVerticalTargetAngle:                   ; CODE XREF: Physics_CalculateAngleToTarget+1C   j  ; was: sub_427CE
                move.w  $14(a4),d1
                sub.w   $14(a5),d1
Physics_ReturnVerticalAxisAngle:                        ; CODE XREF: Physics_CalculateAngleFromVelocity+A   j  ; was: loc_427D6
                move.w  d1,d0
                lsr.w   #8,d0
                andi.w  #$80,d0
                addi.w  #$40,d0                         ; '@'
                rts
; End of function Physics_CalculateVerticalTargetAngle
; Returns the horizontal-axis angle selected by the current octant
Physics_ReturnHorizontalAxisAngle:                      ; CODE XREF: Physics_CalculateAngleFromVelocity+14   j  ; was: sub_427E4
                                        ; Physics_CalculateAngleToTarget+2C   j
                move.b  (a0),d0
                andi.w  #$80,d0
                rts
; ---------------------------------------------------------------------------
; Calculates the angle from the source object to a target object
Physics_CalculateAngleToTarget:                         ; CODE XREF: Boss_SunsetStingCalculateAngleAndFlip+E   p  ; was: loc_427EC
                                        ; Boss_SunsetStingMainDispatcher+18   p
                pea     Physics_AddAngleOffset(pc)
                lea     Physics_AngleOctantBaseTable(pc),a0
                moveq   #0,d0
                moveq   #0,d1
                move.w  $10(a4),d0
                sub.w   $10(a5),d0
                beq.s   Physics_CalculateVerticalTargetAngle
                bgt.s   Physics_NormalizeTargetDeltaX
                neg.w   d0
                addq.l  #4,a0
Physics_NormalizeTargetDeltaX:                          ; CODE XREF: Physics_CalculateAngleToTarget+1E   j  ; was: loc_42808
                move.w  $14(a4),d1
                sub.w   $14(a5),d1
                beq.s   Physics_ReturnHorizontalAxisAngle
                bgt.s   Physics_OrderAngleRatioComponents
                neg.w   d1
                addq.l  #2,a0
Physics_OrderAngleRatioComponents:                      ; CODE XREF: Physics_CalculateAngleFromVelocity:Physics_NormalizeVelocityY   j  ; was: loc_42818
                                        ; Physics_CalculateAngleToTarget+2E   j
                cmp.w   d0,d1
                bcs.s   Physics_CalculateAngleRatio
                exg     d0,d1
                addq.l  #1,a0
Physics_CalculateAngleRatio:                            ; CODE XREF: Physics_CalculateAngleToTarget+36   j  ; was: loc_42820
                asl.l   #2,d0
                divu.w  d1,d0
                cmpi.w  #$23,d0                         ; '#'
                bcs.s   Physics_LookupArctangent
                moveq   #$23,d0                         ; '#'
Physics_LookupArctangent:                               ; CODE XREF: Physics_CalculateAngleToTarget+44   j  ; was: loc_4282C
                move.b  Physics_ApplyArctangentRatio(pc,d0.w),d0
                move.b  (a0),d1
                add.b   d1,d1
                bcc.s   Physics_ApplyArctangentRatio
                neg.b   d0
Physics_ApplyArctangentRatio:                           ; CODE XREF: Physics_CalculateAngleToTarget+50   j  ; was: loc_42838
                                        ; DATA XREF: Physics_CalculateAngleToTarget:Physics_LookupArctangent   r
                add.b   d1,d0
                rts
; End of function Physics_CalculateAngleToTarget
; ---------------------------------------------------------------------------
Physics_ArctangentRatioTableTail:
                binclude "data/other/arctangent_ratio_table_tail.bin"  ; was: unused_9
Physics_AngleOctantBaseTable:
                dc.b    0, $A0, $80, $60, $C0, $20, $40, $E0  ; was: byte_4285C
                                        ; DATA XREF: Physics_CalculateAngleFromVelocity+4   o
                                        ; Physics_CalculateAngleToTarget+C   o

; Adds 90 degrees offset to angle value
Physics_AddAngleOffset:                                 ; DATA XREF: Physics_CalculateAngleFromVelocity   o  ; was: sub_42864
                                        ; Physics_CalculateAngleToTarget   o
                addi.b  #$40,d0                         ; '@'
                rts
; End of function Physics_AddAngleOffset
; Selects an entry from a table of weight-and-value pairs
Math_SelectWeightedChoice:                              ; CODE XREF: Math_JumpToWeightedChoice   p  ; was: sub_4286A
                jsr     (RandomNumber).l
Math_SelectWeightedChoiceLoop:                          ; CODE XREF: Math_SelectWeightedChoice+C   j  ; was: loc_42870
                sub.w   (a0)+,d0
                bls.s   Math_SelectWeightedChoiceReturn
                addq.w  #2,a0
                bra.s   Math_SelectWeightedChoiceLoop
; ---------------------------------------------------------------------------
Math_SelectWeightedChoiceReturn:                        ; CODE XREF: Math_SelectWeightedChoice+8   j  ; was: loc_42878
                move.w  (a0),d0
                rts
; End of function Math_SelectWeightedChoice
; Selects and jumps to a weighted relative target
Math_JumpToWeightedChoice:                              ; CODE XREF: Boss_SunsetStingIdleState+40   j  ; was: sub_4287C
                                        ; Boss_SunsetStingCloseRangeAttack+4   j
                bsr.s   Math_SelectWeightedChoice
                adda.w  (a0),a0
                jmp     (a0)
; End of function Math_JumpToWeightedChoice

; Gets sine and cosine values
Math_GetSinCos:                                         ; CODE XREF: Math_GetScaledSinCos   p  ; was: sub_42882
                lsr.w   #1,d0
                andi.w  #$1FE,d0
                lea     (Math_QuarterSineTable).l,a0
                move.w  (a0,d0.w),d1
                addi.w  #$80,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d0
                rts
; End of function Math_GetSinCos
; Gets scaled sine and cosine
Math_GetScaledSinCos:                                   ; CODE XREF: Boss_SunsetStingSegmentOrbitState:Boss_SunsetStingSegmentOrbitUpdatePosition   p  ; was: sub_428A0
                                        ; Boss_SunsetStingSegmentOrbitState+68   p
                bsr.s   Math_GetSinCos
                muls.w  d2,d0
                muls.w  d2,d1
                rts
; End of function Math_GetScaledSinCos
; Clears X and Y velocity values
Physics_ClearVelocity:                                  ; CODE XREF: Boss_SunsetStingBattleActive   p  ; was: sub_428A8
                                        ; sub_43048   p
                moveq   #0,d0
                move.l  d0,$18(a5)
                move.l  d0,$1C(a5)
                rts
; End of function Physics_ClearVelocity
