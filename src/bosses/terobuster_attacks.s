; Applies gravity, performs one bounce, then advances to the defeat-debris state
Boss_TerobusterDefeatBounceState:                       ; DATA XREF: ROM:00038580   o  ; was: sub_38B5C
                addi.l  #$3000,$1C(a5)
                bmi.s   Boss_TerobusterUpdateDefeatScreenPosition
                cmpi.w  #$142,$14(a5)
                bmi.s   Boss_TerobusterUpdateDefeatScreenPosition
                move.w  #6,(PlaneAShakeLevel).w
                move.w  #6,(PlaneBShakeLevel).w
                addq.w  #1,$48(a5)
                beq.s   Boss_TerobusterBeginDefeatBounce
                addq.w  #2,4(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$A0,$48(a5)
                bra.s   Boss_TerobusterUpdateDefeatScreenPosition
; ---------------------------------------------------------------------------
Boss_TerobusterBeginDefeatBounce:                       ; CODE XREF: Boss_TerobusterDefeatBounceState+22   j  ; was: loc_38B94
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  #$FFFDE000,$1C(a5)
; End of function Boss_TerobusterDefeatBounceState
; Publishes Terobuster's defeat position to the shared screen-coordinate pair
Boss_TerobusterUpdateDefeatScreenPosition:              ; CODE XREF: Boss_TerobusterDefeatBounceState+8   j  ; was: sub_38BA6
                                        ; Boss_TerobusterDefeatBounceState+10   j
                move.w  #$CC,d0
                sub.w   $10(a5),d0
                move.w  d0,(SecondaryCameraXPos).w
                move.w  $14(a5),d0
                addi.w  #$3E,d0                         ; '>'
                move.w  d0,(SecondaryCameraYPos).w
                rts
; End of function Boss_TerobusterUpdateDefeatScreenPosition
; Counts down while emitting randomized defeat debris around Terobuster
Boss_TerobusterDefeatDebrisState:                       ; DATA XREF: ROM:00038582   o  ; was: sub_38BC0
                subq.w  #1,$48(a5)
                bpl.s   Boss_TerobusterUpdateDefeatDebris
                addq.w  #2,4(a5)
                clr.w   6(a5)
Boss_TerobusterUpdateDefeatDebris:                      ; CODE XREF: Boss_TerobusterDefeatDebrisState+4   j  ; was: loc_38BCE
                                        ; Boss_TerobusterDefeatFadeState+E   j
                bsr.w   Boss_TerobusterUpdateDefeatScreenPosition
                cmpi.w  #$40,$48(a5)                    ; '@'
                bpl.s   Boss_TerobusterTrySpawnDefeatDebris
                btst    #0,(FrameCounter+1).w
                bne.s   Boss_TerobusterTrySpawnDefeatDebris
                move.w  #$FFD0,(SecondaryCameraYPos).w
Boss_TerobusterTrySpawnDefeatDebris:                    ; CODE XREF: Boss_TerobusterDefeatDebrisState+18   j  ; was: loc_38BE8
                                        ; Boss_TerobusterDefeatDebrisState+20   j
                move.w  #2,(PlaneAShakeLevel).w
                move.w  #2,(PlaneBShakeLevel).w
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Boss_TerobusterDefeatDebrisReturn
                movea.l #Projectile_SpawnSpriteFrames,a1
                btst    #1,(FrameCounter+1).w
                bne.s   Boss_TerobusterInitializeDefeatDebris
                movea.l #Boss_TerobusterProjectileSpriteFrames,a1
                move.l  #$FFFD2000,$1C(a0)
Boss_TerobusterInitializeDefeatDebris:                  ; CODE XREF: Boss_TerobusterDefeatDebrisState+48   j  ; was: loc_38C18
                jsr     (Sprite_InitTypeA4FromTable).l
                move.b  #0,$20(a0)
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                subi.w  #$3C,d0                         ; '<'
                subi.w  #$34,d1                         ; '4'
                move.b  (RandomNumberState).w,d2
                move.b  (RandomNumberState+1).w,d3
                andi.w  #$3C,d2                         ; '<'
                andi.w  #$3C,d3                         ; '<'
                add.w   d2,d0
                add.w   d3,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.s   Boss_TerobusterDefeatDebrisReturn
                move.b  #$BB,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
Boss_TerobusterDefeatDebrisReturn:                      ; CODE XREF: Boss_TerobusterDefeatDebrisState+3A   j  ; was: locret_38C64
                                        ; Boss_TerobusterDefeatDebrisState+98   j
                rts
; End of function Boss_TerobusterDefeatDebrisState
; Advances the defeat fade, then replaces debris with the main explosion
Boss_TerobusterDefeatFadeState:                         ; DATA XREF: ROM:00038584   o  ; was: sub_38C66
                bsr.w   Boss_TerobusterSetFadeParams
                addq.w  #1,6(a5)
                cmpi.w  #$F,6(a5)
                bmi.w   Boss_TerobusterUpdateDefeatDebris
                move.w  #$22,4(a5)                      ; '"'
                move.w  #8,$48(a5)
                move.w  #$FFD0,(SecondaryCameraYPos).w
                move.b  #4,(byte_FFA95A).w
                move.w  #$B4,d0
                move.w  #$12C,d1
                jsr     (Object_ClearAllExceptTypes).l
                jsr     (AlternateTransition_SpawnAtOwner).l
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                subi.w  #$18,d0
                subi.w  #$10,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                rts
; End of function Boss_TerobusterDefeatFadeState
; Defeat timer countdown before final state
Boss_TerobusterDefeatTimer:                             ; DATA XREF: ROM:00038598   o  ; was: sub_38CBE
                subq.w  #1,$48(a5)
                bpl.s   Boss_TerobusterDefeatTimerUpdateFade
                addq.w  #2,4(a5)
                move.w  #$C0,$48(a5)
Boss_TerobusterDefeatTimerUpdateFade:                   ; CODE XREF: Boss_TerobusterDefeatTimer+4   j  ; was: loc_38CCE
                bra.w   Boss_TerobusterSetFadeParams
; End of function Boss_TerobusterDefeatTimer
; Completes defeat sequence removing boss entity
Boss_TerobusterDefeatComplete:                          ; DATA XREF: ROM:0003859A   o  ; was: sub_38CD2
                subq.w  #1,$48(a5)
                bpl.s   Boss_TerobusterDefeatCompleteUpdateFade
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
Boss_TerobusterDefeatCompleteUpdateFade:                ; CODE XREF: Boss_TerobusterDefeatComplete+4   j  ; was: loc_38CE0
                subq.w  #1,6(a5)
                bpl.w   Boss_TerobusterSetFadeParams
                rts
; End of function Boss_TerobusterDefeatComplete
; Sets graphics fade parameters using boss state value for death sequence
Boss_TerobusterSetFadeParams:                           ; CODE XREF: Boss_TerobusterDefeatFadeState   p  ; was: sub_38CEA
                                        ; Boss_TerobusterDefeatTimer:Boss_TerobusterDefeatTimerUpdateFade   j
                move.w  6(a5),d0
                jmp     (Gfx_SetFadeParams).l
; End of function Boss_TerobusterSetFadeParams
; Publishes a symmetric eight-step oscillation to two shared part values
Boss_TerobusterUpdateSharedOscillation:                 ; CODE XREF: Boss_TerobusterUpdateMetaspriteAndProjectile+C   p  ; was: sub_38CF4
                move.w  (FrameCounter).w,d0
                asr.w   #2,d0
                andi.w  #$E,d0
                move.w  Boss_TerobusterOscillationValues(pc,d0.w),d0
                move.w  d0,(word_FFE37E).w
                move.w  d0,(word_FFE3FE).w
                rts
; End of function Boss_TerobusterUpdateSharedOscillation
; ---------------------------------------------------------------------------
Boss_TerobusterOscillationValues:   dc.w    2, 6, $A, $C, $C, $A, 6, 2  ; was: word_38D0C
                                        ; DATA XREF: Boss_TerobusterUpdateSharedOscillation+A   r

; Stops descent, initializes the landing pose, and plays its impact sound
Boss_TerobusterInitializeLandingPose:                   ; CODE XREF: Boss_TerobusterBeginLanding   p  ; was: sub_38D1C
                clr.l   $1C(a5)
                move.w  #$C800,$4A(a5)
                move.w  #$14C,$1F4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #5,(PlaneAShakeLevel).w
                move.w  #5,(PlaneBShakeLevel).w
                move.b  #$DA,d0
                jmp     (Sound_PlaySFX).l
; End of function Boss_TerobusterInitializeLandingPose
; Updates boss body part positions with offset calculations
Boss_TerobusterUpdateBodyParts:                         ; CODE XREF: Boss_TerobusterUpdateMetaspriteAndProjectile+8   p  ; was: sub_38D4C
                move.w  $1DE(a5),d1
                move.w  $10(a5),$490(a5)
                move.w  $14(a5),$494(a5)
                addi.w  #-$10,$490(a5)
                addi.w  #$18,$494(a5)
                add.w   d1,$494(a5)
                cmpi.w  #$13C,$494(a5)
                bmi.s   Boss_TerobusterUpdateProjectileOffset
                move.w  #$13C,$494(a5)
Boss_TerobusterUpdateProjectileOffset:                  ; CODE XREF: Boss_TerobusterUpdateBodyParts+26   j  ; was: loc_38D7A
                move.w  $23C(a5),d0
                beq.s   Boss_TerobusterStoreProjectileOffset
                subq.w  #4,d0
                bpl.s   Boss_TerobusterStoreProjectileOffset
                moveq   #0,d0
Boss_TerobusterStoreProjectileOffset:                   ; CODE XREF: Boss_TerobusterUpdateBodyParts+32   j  ; was: loc_38D86
                                        ; Boss_TerobusterUpdateBodyParts+36   j
                move.w  d0,$23C(a5)
                add.w   $10(a5),d0
                addi.w  #-$44,d0
                move.w  d0,$430(a5)
                move.w  $14(a5),$434(a5)
                addi.w  #-$2C,$434(a5)
                add.w   d1,$434(a5)
                move.w  #$CC,d0
                sub.w   $10(a5),d0
                move.w  d0,(SecondaryCameraXPos).w
                add.w   $14(a5),d1
                addi.w  #$3E,d1                         ; '>'
                move.w  d1,(SecondaryCameraYPos).w
                jmp     Boss_ClampSharedScreenPosition
; End of function Boss_TerobusterUpdateBodyParts
; Spawns projectiles with trajectory and velocity updates
Boss_TerobusterSpawnProjectile:                         ; CODE XREF: Boss_TerobusterUpdateMetaspriteAndProjectile+10   j  ; was: sub_38DC4
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.s   Boss_TerobusterSpawnProjectileReturn
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Boss_TerobusterSpawnProjectileReturn
                movea.l #Boss_TerobusterProjectileSpriteFrames,a1
                jsr     (Sprite_InitTypeA4FromTable).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addi.w  #$14,$10(a0)
                addi.w  #-$30,$14(a0)
                move.b  #4,$20(a0)
                move.w  #2,$18(a0)
Boss_TerobusterSpawnProjectileReturn:                   ; CODE XREF: Boss_TerobusterSpawnProjectile+8   j  ; was: locret_38E06
                                        ; Boss_TerobusterSpawnProjectile+10   j
                rts
; End of function Boss_TerobusterSpawnProjectile
; Updates and renders the linked body, then attempts its periodic projectile
Boss_TerobusterUpdateMetaspriteAndProjectile:           ; CODE XREF: Boss_TerobusterDecisionState+82   j  ; was: sub_38E08
                                        ; Boss_TerobusterDecisionState+134   j
                moveq   #9,d7
                jsr     (Sprite_BeginMetaspritePartTraversal).l
                bsr.w   Boss_TerobusterUpdateBodyParts
                bsr.w   Boss_TerobusterUpdateSharedOscillation
                bra.w   Boss_TerobusterSpawnProjectile
; End of function Boss_TerobusterUpdateMetaspriteAndProjectile
; Periodically spawns homing missiles from Terobuster boss body position
Boss_TerobusterSpawnHomingMissile:                      ; CODE XREF: Boss_TerobusterDecisionState:Boss_TerobusterMissileAttackAUpdate   p  ; was: sub_38E1C
                                        ; Boss_TerobusterDecisionState:Boss_TerobusterMissileAttackBUpdate   p
                tst.w   (DifficultyMode).w
                bne.s   Boss_TerobusterTrySpawnHomingMissile
                cmpi.w  #$1190,$BC(a5)
                bmi.s   Boss_TerobusterSpawnHomingMissileReturn
Boss_TerobusterTrySpawnHomingMissile:                   ; CODE XREF: Boss_TerobusterSpawnHomingMissile+4   j  ; was: loc_38E2A
                move.w  (FrameCounter).w,d0
                btst    #8,d0
                bne.s   Boss_TerobusterSpawnHomingMissileReturn
                andi.w  #$1F,d0
                bne.s   Boss_TerobusterSpawnHomingMissileReturn
                movea.w #(FiftiethEntityType-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckFinalRange).l
                bne.s   Boss_TerobusterSpawnHomingMissileReturn
                move.w  #$138,(a0)
                move.w  #$8D00,2(a0)
                move.b  #$C0,$21(a0)
                move.b  #8,$23(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.b  #8,$20(a0)
                move.w  #$14,$26(a0)
                move.w  $490(a5),$10(a0)
                move.w  $494(a5),$14(a0)
                addi.w  #$C,$10(a0)
                addi.w  #-$30,$14(a0)
                move.w  #$180,$56(a0)
                move.b  #$4A,d0                         ; 'J'
                jsr     (Sound_PlaySFX).l
Boss_TerobusterSpawnHomingMissileReturn:                ; CODE XREF: Boss_TerobusterSpawnHomingMissile+C   j  ; was: locret_38EA0
                                        ; Boss_TerobusterSpawnHomingMissile+16   j
                rts
; End of function Boss_TerobusterSpawnHomingMissile
; Updates homing missile trajectory with rotation, trail spawning, and player tracking
