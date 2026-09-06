Boss_SunsetStingCloseRangeAttack:                              ; CODE XREF: Boss_SunsetStingIdleState+3A   j  ; was: sub_40EF0
                lea     word_40EFA(pc),a0
                jmp     JumpRandomFunc
; End of function Boss_SunsetStingCloseRangeAttack
; ---------------------------------------------------------------------------
word_40EFA:     dc.w $A000              ; DATA XREF: Boss_SunsetStingCloseRangeAttack   o
                dc.w Boss_SunsetStingAttackRecover-*
                dc.w $8000
                dc.w Boss_SunsetStingAttackSetup2-*


; Calculates horizontal screen offset based on boss position and velocity direction
Boss_SunsetStingCalculateScreenOffset:                              ; CODE XREF: Boss_SunsetStingDashAttack+6E   p  ; was: sub_40F02
                                        ; Boss_SunsetStingDashAttack+7E   p ...
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                tst.w   $18(a5)
                bpl.s   loc_40F16
                subi.w  #$400,d0
                rts
; ---------------------------------------------------------------------------
loc_40F16:                              ; CODE XREF: Boss_SunsetStingCalculateScreenOffset+C   j
                move.w  #$600,d1
                sub.w   d0,d1
                rts
; End of function Boss_SunsetStingCalculateScreenOffset
; Disables collision flag for all 5 boss body segments
Boss_SunsetStingDisableCollision:                              ; CODE XREF: Boss_SunsetStingResetForAttack:loc_40E86   p  ; was: sub_40F1E
                andi.b  #$BF,$201(a5)
                andi.b  #$BF,$3E1(a5)
                andi.b  #$BF,$5C1(a5)
                andi.b  #$BF,$7A1(a5)
                andi.b  #$BF,$921(a5)
                rts
; End of function Boss_SunsetStingDisableCollision
; Enables collision flag for all 5 boss body segments
Boss_SunsetStingEnableCollision:                              ; CODE XREF: Boss_SunsetStingAttackSetup1+12   p  ; was: sub_40F3E
                                        ; Boss_SunsetStingAttackSetup2+12   p ...
                ori.b   #$40,$201(a5) ; '@'
                ori.b   #$40,$3E1(a5) ; '@'
                ori.b   #$40,$5C1(a5) ; '@'
                ori.b   #$40,$7A1(a5) ; '@'
                ori.b   #$40,$921(a5) ; '@'
                rts
; End of function Boss_SunsetStingEnableCollision
; Sets up boss attack state with counter values and enables collision
Boss_SunsetStingAttackSetup1:                              ; DATA XREF: ROM:00040EE6   o  ; was: sub_40F5E
                move.w  #$C,4(a5)
                move.b  #$30,$4B(a5) ; '0'
                move.b  #4,$4A(a5)
                bsr.s Boss_SunsetStingEnableCollision
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingAttackSetup1
; Executes dashing movement pattern with trajectory calculations
Boss_SunsetStingDashAttack:                              ; DATA XREF: ROM:00040D0E   o  ; was: sub_40F76
                move.w  #0,d3
                bsr.w Boss_SunsetStingCalculateAngleAndFlip
                bsr.w Boss_SunsetStingInterpolateRotation
                subq.b  #1,$4B(a5)
                bne.w Boss_SunsetStingUpdateGraphics
                move.b  #0,$4A(a5)
                addq.w  #2,4(a5)
                move.b  #$C,$4B(a5)
                clr.w   d0
                btst    #3,$E(a5)
                bne.s   loc_40FA8
                move.w  #$100,d0
loc_40FA8:                              ; CODE XREF: Boss_SunsetStingDashAttack+2C   j
                move.w  d0,6(a5)
; Move toward target using calculated trajectory
Boss_SunsetStingDashAttack_MoveToward:                              ; DATA XREF: ROM:00040D10   o  ; was: loc_40FAC
                                        ; ROM:00040D14   o
                move.w  #2,d2
                bsr.w Boss_SunsetStingCalculateTrajectory
                add.l   d1,$18(a5)
                add.l   d0,$1C(a5)
                subq.b  #1,$4B(a5)
                bne.w Boss_SunsetStingUpdateGraphics
                move.b  #$C,$4B(a5)
                addq.w  #2,4(a5)
                move.b  #4,$4A(a5)
; Move away from target with screen boundary check
Boss_SunsetStingDashAttack_MoveAway:                              ; DATA XREF: ROM:00040D12   o  ; was: loc_40FD4
                                        ; ROM:00040D16   o
                move.w  #2,d2
                bsr.w Boss_SunsetStingCalculateTrajectory
                sub.l   d1,$18(a5)
                sub.l   d0,$1C(a5)
                bsr.w Boss_SunsetStingCalculateScreenOffset
                bcs.w Boss_SunsetStingResetForAttack
                subq.b  #1,$4B(a5)
                bne.w Boss_SunsetStingUpdateGraphics
                bsr.w Boss_SunsetStingCalculateScreenOffset
                bcs.w Boss_SunsetStingResetForAttack
                move.b  #$C,$4B(a5)
                addq.w  #2,4(a5)
                move.b  #0,$4A(a5)
                subi.w  #$40,(word_FF8234).w ; '@'
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingDashAttack
; Initializes boss attack state with timer and collision detection
Boss_SunsetStingAttackSetup2:                              ; DATA XREF: ROM:00040F00   o  ; was: sub_41016
                move.w  #$18,4(a5)
                move.b  #$30,$4B(a5) ; '0'
                move.b  #4,$4A(a5)
                bsr.w Boss_SunsetStingEnableCollision
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingAttackSetup2
; Prepares boss dive attack by setting timer and adjusting screen offset
Boss_SunsetStingPrepareDive:                              ; DATA XREF: ROM:00040D1A   o  ; was: sub_41030
                move.w  #$20,d3 ; ' '
                bsr.w Boss_SunsetStingCalculateAngleAndFlip
                bsr.w Boss_SunsetStingInterpolateRotation
                subq.b  #1,$4B(a5)
                bne.w Boss_SunsetStingUpdateGraphics
                move.b  #6,$4A(a5)
                addq.w  #2,4(a5)
                move.b  #$30,$4B(a5) ; '0'
                subi.w  #$50,(word_FF8234).w ; 'P'
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingPrepareDive
; Waits for timer countdown before resetting attack state
Boss_SunsetStingTimerWait:                              ; DATA XREF: ROM:00040D1C   o  ; was: sub_4105E
                subq.b  #1,$4B(a5)
                bne.w Boss_SunsetStingUpdateGraphics
                bra.w Boss_SunsetStingResetForAttack
; End of function Boss_SunsetStingTimerWait
; Sets up boss attack with vertical velocity cleared
Boss_SunsetStingAttackSetup3:                              ; DATA XREF: ROM:00040EE2   o  ; was: sub_4106A
                move.w  #$1C,4(a5)
                move.b  #$30,$4B(a5) ; '0'
                move.b  #8,$4A(a5)
                clr.l   $1C(a5)
                bsr.w Boss_SunsetStingEnableCollision
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingAttackSetup3
; Performs serpentine movement pattern with trajectory reversals
Boss_SunsetStingSerpentineAttack:                              ; DATA XREF: ROM:00040D1E   o  ; was: sub_41088
                move.w  #2,d2
                bsr.w Boss_SunsetStingCalculateTrajectory
                neg.l   d1
                neg.l   d0
                move.l  d1,$18(a5)
                move.l  #$C00000,d0
                sub.l   $14(a5),d0
                asr.l   #2,d0
                move.l  d0,$1C(a5)
                move.w  #$40,d3 ; '@'
                bsr.w Boss_SunsetStingCalculateAngleAndFlip
                bsr.w Boss_SunsetStingInterpolateRotation
                subq.b  #1,$4B(a5)
                bne.w Boss_SunsetStingUpdateGraphics
                addq.w  #2,4(a5)
                move.b  #$10,$4B(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
; Serpentine pattern movement toward target
Boss_SunsetStingSerpentineAttack_MoveIn:                              ; DATA XREF: ROM:00040D20   o  ; was: loc_410CE
                move.w  #2,d2
                bsr.w Boss_SunsetStingCalculateTrajectory
                add.l   d1,$18(a5)
                add.l   d0,$1C(a5)
                subq.b  #1,$4B(a5)
                bne.w   loc_41112
                addq.w  #2,4(a5)
                move.b  #$10,$4B(a5)
                subi.w  #$140,(word_FF8234).w
; Serpentine pattern movement away from target
Boss_SunsetStingSerpentineAttack_MoveOut:                              ; DATA XREF: ROM:00040D22   o  ; was: loc_410F6
                move.w  #2,d2
                bsr.w Boss_SunsetStingCalculateTrajectory
                sub.l   d1,$18(a5)
                sub.l   d0,$1C(a5)
                subq.b  #1,$4B(a5)
                bne.w   loc_41112
                bra.w Boss_SunsetStingResetForAttack
; ---------------------------------------------------------------------------
loc_41112:                              ; CODE XREF: Boss_SunsetStingSerpentineAttack+5A   j
                                        ; Boss_SunsetStingSerpentineAttack+82   j
                bsr.w Boss_SunsetStingCalculateScreenOffset
                bcs.w Boss_SunsetStingResetForAttack
                cmpi.w  #$110,$14(a5)
                bcs.w Boss_SunsetStingUpdateGraphics
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                neg.l   $1C(a5)
                bra.w   *+4
; End of function Boss_SunsetStingSerpentineAttack
; Recovers from attack by setting state timer and enabling collision
Boss_SunsetStingAttackRecover:                              ; CODE XREF: Boss_SunsetStingSerpentineAttack+AC   j  ; was: sub_41138
                                        ; Boss_SunsetStingWobbleRotation+1C   j
                                        ; DATA XREF: ...
                move.w  #$22,4(a5) ; '"'
                move.b  #$38,$4B(a5) ; '8'
                move.b  #$A,$4A(a5)
                subi.w  #$148,(word_FF8234).w
                bsr.w Boss_SunsetStingEnableCollision
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingAttackRecover
; Decelerates rotation angle and resets attack when timer expires
Boss_SunsetStingRotationDecelerate:                              ; DATA XREF: ROM:00040D24   o  ; was: sub_41158
                addi.w  #$C,$56(a5)
                subq.b  #1,$4B(a5)
                beq.w Boss_SunsetStingResetForAttack
                move.l  $18(a5),d0
                asr.l   #4,d0
                sub.l   d0,$18(a5)
                bsr.w Boss_SunsetStingCalculateVerticalVelocity
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingRotationDecelerate
; Initializes idle state with long timer and cleared velocity
Boss_SunsetStingIdleSetup:                              ; DATA XREF: ROM:00040EEA   o  ; was: sub_41178
                move.w  #$24,4(a5) ; '$'
                move.b  #$60,$4B(a5) ; '`'
                move.b  #6,$4A(a5)
                clr.l   $1C(a5)
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingIdleSetup
; Applies wobbling rotation effect using sine wave pattern
Boss_SunsetStingWobbleRotation:                              ; DATA XREF: ROM:00040D26   o  ; was: sub_41192
                move.b  $4B(a5),d4
                lsr.w   #2,d4
                andi.w  #7,d4
                move.b  word_411B0(pc,d4.w),d4
                ext.w   d4
                add.w   d4,$56(a5)
                subq.b  #1,$4B(a5)
                bne.w Boss_SunsetStingUpdateGraphics
                bra.s Boss_SunsetStingAttackRecover
; End of function Boss_SunsetStingWobbleRotation
; ---------------------------------------------------------------------------
word_411B0:     dc.w $FFFD, $FCFF, $103, $401, $49ED, $60, $363C, 4
                                        ; DATA XREF: Boss_SunsetStingWobbleRotation+A   r


; Spawns multiple projectile debris with randomized trajectories
Boss_SunsetStingSpawnDebris:                              ; CODE XREF: Boss_SunsetStingSpawnDebris+5E   j  ; was: sub_411C0
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_41222
                move.w  #$1C4,(a0)
                ori.w   #$CD00,2(a0)
                jsr     (RandomNumber).l
                rol.l   #8,d0
                move.w  d0,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  #4,d1
                muls.w  #4,d0
                move.l  d1,$18(a0)
                move.l  d0,$1C(a0)
                jsr     (RandomNumber).l
                rol.l   #8,d0
                ext.w   d0
                asr.w   #3,d0
                move.w  d0,$5C(a0)
                clr.b   $21(a0)
                move.l  $10(a4),$10(a0)
                move.l  $14(a4),$14(a0)
                lea     $60(a4),a4
                dbf d3,Boss_SunsetStingSpawnDebris
loc_41222:                              ; CODE XREF: Boss_SunsetStingSpawnDebris+6   j
                bra.w Boss_SunsetStingResetForAttack
; End of function Boss_SunsetStingSpawnDebris
; Calculates movement trajectory using sine/cosine lookup table
Boss_SunsetStingCalculateTrajectory:                              ; CODE XREF: Boss_SunsetStingDashAttack+3A   p  ; was: sub_41226
                                        ; Boss_SunsetStingDashAttack+62   p ...
                move.w  $56(a5),d1
                asr.w   #1,d1
                sub.w   $5A(a5),d1
                add.w   d1,d1
                andi.w  #$1FE,d1
                lea     (word_1B514).l,a2
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                btst    #3,$E(a5)
                beq.s   loc_41250
                neg.w   d1
loc_41250:                              ; CODE XREF: Boss_SunsetStingCalculateTrajectory+26   j
                ext.l   d0
                ext.l   d1
                asl.l   d2,d0
                asl.l   d2,d1
                rts
; End of function Boss_SunsetStingCalculateTrajectory
; Checks distance to player and sets horizontal flip bit
Boss_SunsetStingCheckFlipDirection:
                andi.w  #$F7FF,$E(a5)  ; was: sub_4125A
                jsr (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s   locret_41270
                ori.w   #$800,$E(a5)
locret_41270:                           ; CODE XREF: Boss_SunsetStingCheckFlipDirection+E   j
                rts
; End of function Boss_SunsetStingCheckFlipDirection
; Calculates angle to player with flip flag
Boss_SunsetStingCalculateAngleAndFlip:                              ; CODE XREF: Boss_SunsetStingIncrementCounter+8   p  ; was: sub_41272
                                        ; Boss_SunsetStingDashAttack+4   p ...
                andi.w  #$F7FF,$E(a5)
                movem.l d3,-(sp)
                lea     (word_FFA400).w,a4
                jsr     (loc_427EC).l
                movem.l (sp)+,d3
                move.b  d0,d2
                bpl.s   loc_41296
                ori.w   #$800,$E(a5)
                neg.b   d2
loc_41296:                              ; CODE XREF: Boss_SunsetStingCalculateAngleAndFlip+1A   j
                move.w  d3,$5A(a5)
; End of function Boss_SunsetStingCalculateAngleAndFlip
; Applies angle offset to boss orientation register
Boss_SunsetStingApplyAngleOffset:
                add.w   $5A(a5),d2  ; was: sub_4129A
                move.w  d2,6(a5)
                rts
; End of function Boss_SunsetStingApplyAngleOffset
; Interpolates rotation angle towards target smoothly
Boss_SunsetStingInterpolateRotation:                              ; CODE XREF: Boss_SunsetStingIdleState+12   p  ; was: sub_412A4
                                        ; Boss_SunsetStingDashAttack+8   p ...
                move.w  $56(a5),d1
                lsr.w   #1,d1
                move.w  6(a5),d0
                sub.b   d1,d0
                asr.b   #2,d0
                ext.w   d0
                add.w   d0,$56(a5)
                rts
; End of function Boss_SunsetStingInterpolateRotation
; Calculates vertical velocity using sine wave for hovering
Boss_SunsetStingCalculateVerticalVelocity:                              ; CODE XREF: Boss_SunsetStingIntroMovement+18   p  ; was: sub_412BA
                                        ; Boss_SunsetStingIdleState+8   p ...
                clr.w   d0
                move.b  $4B(a5),d0
                asl.w   #2,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a0
                move.w  (a0,d0.w),d0
                ext.l   d0
                asl.l   #6,d0
                addi.l  #$1000000,d0
                sub.l   $14(a5),d0
                asr.l   #2,d0
                move.l  d0,$1C(a5)
                rts
; End of function Boss_SunsetStingCalculateVerticalVelocity
; Updates boss sprite graphics based on animation frame counter
Boss_SunsetStingUpdateGraphics:                              ; CODE XREF: Boss_SunsetStingIntroMovement:loc_40E5E   j  ; was: sub_412E6
                                        ; Boss_SunsetStingResetForAttack+28   j ...
                bsr.w Boss_SunsetStingUpdatePartAngles
                btst    #2,(byte_FF80EC).w
                bne.s   loc_41302
                btst    #1,(byte_FF80EC).w
                bne.s   loc_41302
                tst.w   (word_FF8200).w
                beq.w Boss_SunsetStingInitializeAttackPhase
loc_41302:                              ; CODE XREF: Boss_SunsetStingUpdateGraphics+A   j
                                        ; Boss_SunsetStingUpdateGraphics+12   j
                lea     word_41568(pc),a1
                jsr Boss_SunsetStingUpdateBodyPartPositions(pc)   ; (pc)
                nop
                bsr.w Boss_SunsetStingUpdateCameraOffset
                lea     word_40DC4(pc),a0
                move.w  (word_FFC67E).w,d0
                lsr.w   #3,d0
                bsr.w Boss_SunsetStingLoadTileTableEntry
                lea     word_40DD6+$24(pc),a0
                move.w  (word_FFC67E).w,d0
                lsr.w   #2,d0
                bsr.w Boss_SunsetStingLoadTileTableEntry
                addq.w  #1,(word_FFC67E).w
                rts
; End of function Boss_SunsetStingUpdateGraphics
; Loads compressed tile data from indexed table entry
Boss_SunsetStingLoadTileTableEntry:                              ; CODE XREF: Boss_SunsetStingUpdateGraphics+34   p  ; was: sub_41332
                                        ; Boss_SunsetStingUpdateGraphics+42   p
                and.w   (a0)+,d0
                adda.w  d0,a0
                adda.w  (a0),a0
                jmp Gfx_LoadCompressedTiles
; End of function Boss_SunsetStingLoadTileTableEntry
; Initializes boss attack phase with state flags and movement
Boss_SunsetStingInitializeAttackPhase:                              ; CODE XREF: Boss_SunsetStingUpdateGraphics+18   j  ; was: sub_4133E
                move.b  #1,(byte_FF830E).w
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr (Sprite_ClearObjectFlags).l
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #0,$4A(a5)
                move.w  #$26,4(a5) ; '&'
                move.b  #8,$4B(a5)
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingInitializeAttackPhase
; Spawns debris objects with random velocities in circular pattern
Boss_SunsetStingSpawnDebrisField:                              ; DATA XREF: ROM:00040D28   o  ; was: sub_41384
                subq.b  #1,$4B(a5)
                bne.w Boss_SunsetStingUpdateGraphics
                addq.w  #2,4(a5)
                clr.b   $21(a5)
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
                lea     (word_1B514).l,a2
loc_413A4:                              ; CODE XREF: Boss_SunsetStingSpawnDebrisField+6E   j
                move.w  #$1C4,(a4)
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
                dbf     d4,loc_413A4
; Spawn projectiles while rising until screen threshold
Boss_SunsetStingSpawnDebrisField_RiseLoop:                              ; DATA XREF: ROM:00040D2A   o  ; was: loc_413F6
                addi.l  #$800,$1C(a5)
                cmpi.w  #$1C0,$14(a5)
                bhi.s   loc_41416
                move.l  #$200020,d1
                bsr.w Projectile_SpawnWithRandomOffset
                bsr.w Boss_SunsetStingUpdateCameraOffset
                rts
; ---------------------------------------------------------------------------
loc_41416:                              ; CODE XREF: Boss_SunsetStingSpawnDebrisField+80   j
                move.b  #$40,$4B(a5) ; '@'
                addq.w  #2,4(a5)
                move.w  #1,d5
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
loc_4142E:                              ; CODE XREF: Boss_SunsetStingSpawnDebrisField+B4   j
                move.b  d5,$4B(a4)
                addq.w  #1,d5
                lea     $60(a4),a4
                dbf     d4,loc_4142E
                rts
; End of function Boss_SunsetStingSpawnDebrisField
; Fades out screen and destroys boss object when timer expires
Boss_SunsetStingFadeOutAndDestroy:                              ; DATA XREF: ROM:00040D2C   o  ; was: sub_4143E
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                subq.b  #1,$4B(a5)
                bne.w   locret_41454
                clr.w   (a5)
locret_41454:                           ; CODE XREF: Boss_SunsetStingFadeOutAndDestroy+10   j
                rts
; End of function Boss_SunsetStingFadeOutAndDestroy
; Updates debris particle rotation and animation frame
Effect_DebrisParticleAnimate:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_41456
                tst.b   $4B(a5)
                beq.s   loc_41462
                subq.b  #1,$4B(a5)
                beq.s   loc_41484
loc_41462:                              ; CODE XREF: Effect_DebrisParticleAnimate+4   j
                move.w  $5C(a5),d0
                add.w   d0,$56(a5)
                move.l  $50(a5),d0
                beq.s   locret_41482
                movea.l d0,a1
                move.w  $56(a5),d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a5)
locret_41482:                           ; CODE XREF: Effect_DebrisParticleAnimate+18   j
                rts
; ---------------------------------------------------------------------------
loc_41484:                              ; CODE XREF: Effect_DebrisParticleAnimate+A   j
                lea     (a5),a0
                jsr     (loc_2A2A4).l
                clr.b   $21(a5)
                rts
; End of function Effect_DebrisParticleAnimate
; Spawns projectile with randomized position offset
Projectile_SpawnWithRandomOffset:                              ; CODE XREF: Boss_SunsetStingSpawnDebrisField+88   p  ; was: sub_41492
                                        ; Boss_SunsetStingDescendAndActivate+E   p ...
                move.l  d1,-(sp)
                jsr (Projectile_InitTypeA4).l
                bne.s   loc_414EA
                jsr (Sprite_InitFromTable).l
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
loc_414EA:                              ; CODE XREF: Projectile_SpawnWithRandomOffset+8   j
                move.l  (sp)+,d1
                rts
; End of function Projectile_SpawnWithRandomOffset
; Calculates camera offset relative to boss position
Boss_SunsetStingUpdateCameraOffset:                              ; CODE XREF: Boss_SunsetStingUpdateGraphics+26   p  ; was: sub_414EE
                                        ; Boss_SunsetStingSpawnDebrisField+8C   p
                move.w  #$A4,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$4C,d0 ; 'L'
                move.w  d0,(dword_FFA90C).w
                jmp Boss_CheckScreenBounds
; End of function Boss_SunsetStingUpdateCameraOffset
; Updates animation angles for boss body parts
Boss_SunsetStingUpdatePartAngles:                              ; CODE XREF: Boss_SunsetStingUpdateGraphics   p  ; was: sub_4150C
                move.b  $4A(a5),d0
                andi.w  #$E,d0
                lea     word_4165C(pc),a1
                adda.w  d0,a1
                adda.w  (a1),a1
                lea     $60(a5),a4
loc_41520:                              ; CODE XREF: Boss_SunsetStingUpdatePartAngles+38   j
                move.w  (a1)+,d0
                beq.s   locret_41546
                lea     -2(a1,d0.w),a0
                move.w  (a0)+,d3
loc_4152A:                              ; CODE XREF: Boss_SunsetStingUpdatePartAngles+34   j
                move.w  (a0)+,d0
                bmi.s   loc_4153C
                ext.w   d0
                add.w   d0,d0
                sub.w   $56(a4),d0
                asr.w   #3,d0
                add.w   d0,$56(a4)
loc_4153C:                              ; CODE XREF: Boss_SunsetStingUpdatePartAngles+20   j
                lea     $60(a4),a4
                dbf     d3,loc_4152A
                bra.s   loc_41520
; ---------------------------------------------------------------------------
locret_41546:                           ; CODE XREF: Boss_SunsetStingUpdatePartAngles+16   j
                rts
; End of function Boss_SunsetStingUpdatePartAngles
; ---------------------------------------------------------------------------
                dc.l word_EBDBC
                dc.l word_EBDC2
                dc.l word_EBDC8
                dc.l word_EBD9E
                dc.l word_EBDA4
                dc.l word_EBDAA
                dc.l word_EBDB0
                dc.l word_EBDB6
word_41568:     dc.w $E, $BDB0, $80, 0, $8000, 1, $2004, $D2E, $83, $140, $6004, $1548
                                        ; DATA XREF: Boss_SunsetStingLoadGraphics+28   o
                                        ; sub_412E6:loc_41302   o
                dc.w $43, $A0, $6004, $1548, $4A, 0, $6004, $1548, $61, $60, $6004, $1548
                dc.w $60, $60, $8000, 0, $8000, 1, $2004, $D2E, $83, $160, $6004, $1548
                dc.w $43, $70, $6004, $1548, $4A, 0, $6004, $1548, $61, $50, $6004, $1548
                dc.w $60, $50, $8000, 0, $8000, 1, $2004, $D2E, $83, $180, $6004, $1548
                dc.w $43, $60, $6004, $1548, $4A, 0, $6004, $1548, $61, $60, $6004, $1548
                dc.w $60, $60, $8000, 0, $8000, 1, $2004, $D2E, $83, $1A0, $6004, $1548
                dc.w $43, $30, $6004, $1548, $4A, 0, $6004, $1548, $61, $50, $6004, $1548
                dc.w $60, $50, $8000, 0, $8000, 1, $2004, $D2E, $A3, $20, $6004, $1548
                dc.w $43, $FFB0, $6004, $1548, $4A, 0, $6004, $1548, $49, $FFA0, $8000, 0
                dc.w $8000, 0
word_4165C:	binclude	"data/other/word_4165C.bin"
word_4165C_End:


; Initializes boss body part sprites from pointer table
Boss_SunsetStingInitBodyParts:                              ; CODE XREF: Boss_SunsetStingLoadGraphics+2E   p  ; was: sub_417D8
                                        ; Boss_SunsetStingLoadGraphicsAlt+2E   p
                clr.w   d7
                movea.l a5,a3
                clr.l   -(sp)
                move.w  $E(a5),d5
loc_417E2:                              ; CODE XREF: Boss_SunsetStingInitBodyParts+18   j
                                        ; Boss_SunsetStingInitBodyParts+20   j ...
                move.l  (a1)+,d4
                bpl.s   loc_417FA
                andi.l  #$7FFFFFFF,d4
                beq.s   loc_417F2
                move.l  a5,-(sp)
                bra.s   loc_417E2
; ---------------------------------------------------------------------------
loc_417F2:                              ; CODE XREF: Boss_SunsetStingInitBodyParts+14   j
                move.l  (sp)+,d0
                beq.s   loc_41852
                movea.l d0,a5
                bra.s   loc_417E2
; ---------------------------------------------------------------------------
loc_417FA:                              ; CODE XREF: Boss_SunsetStingInitBodyParts+C   j
                move.w  d5,$E(a4)
                move.b  #$C0,$20(a4)
                bclr    #$1E,d4
                bne.s   loc_41814
                move.l  d4,8(a4)
                clr.l   $50(a4)
                bra.s   loc_41818
; ---------------------------------------------------------------------------
loc_41814:                              ; CODE XREF: Boss_SunsetStingInitBodyParts+30   j
                move.l  d4,$50(a4)
loc_41818:                              ; CODE XREF: Boss_SunsetStingInitBodyParts+3A   j
                swap    d4
                andi.w  #$FF00,d4
                asl.w   #2,d4
                or.w    d4,$E(a4)
                move.w  #$C000,2(a4)
                move.w  (a1)+,$4C(a4)
                move.b  $4D(a4),d0
                andi.b  #3,d0
                asl.b   #2,d0
                add.b   d0,$20(a4)
                move.w  (a1)+,$56(a4)
                move.w  a5,$4E(a4)
                addq.w  #1,d7
                move.w  #$10,(a4)
                lea     (a4),a5
                lea     $60(a4),a4
                bra.s   loc_417E2
; ---------------------------------------------------------------------------
loc_41852:                              ; CODE XREF: Boss_SunsetStingInitBodyParts+1C   j
                move.w  d7,(word_FFC67C).w
                lea     (a3),a5
                clr.w   $4E(a5)
                rts
; End of function Boss_SunsetStingInitBodyParts
; Updates positions of all boss body parts using sine/cosine
Boss_SunsetStingUpdateBodyPartPositions:                              ; CODE XREF: Boss_SunsetStingUpdateGraphics+20   p  ; was: sub_4185E
                                        ; Boss_SunsetStingMainUpdate+78   p
                move.w  (word_FFC67C).w,d7
                subq.w  #1,d7
                lea     $60(a5),a4
                movea.l #word_1B514,a2
                movem.l a5,-(sp)
                btst    #3,$E(a5)
                lea Boss_SunsetStingApplyParentOffset(pc),a5
                beq.s   loc_41882
                lea Boss_SunsetStingFlipHorizontal(pc),a5
loc_41882:                              ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+1E   j
                                        ; Boss_SunsetStingApplyParentOffset+18   j
                andi.w  #$F7FF,$E(a4)
                move.w  $56(a4),d6
                lea     (a4),a0
loc_4188E:                              ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+3C   j
                move.w  $4E(a0),d0
                beq.s   loc_4189C
                movea.w d0,a0
                add.w   $56(a0),d6
                bra.s   loc_4188E
; ---------------------------------------------------------------------------
loc_4189C:                              ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+34   j
                move.l  $50(a4),d0
                beq.s   loc_418B8
                movea.l d0,a1
                move.w  d6,d1
                move.w  #$F8,d0
                sub.w   d1,d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a4)
loc_418B8:                              ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+42   j
                move.w  d6,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  $4C(a4),d0
                muls.w  $4C(a4),d1
                jmp     (a5)
; End of function Boss_SunsetStingUpdateBodyPartPositions
; Negates values and flips horizontal sprite flag
Boss_SunsetStingFlipHorizontal:                              ; DATA XREF: Boss_SunsetStingUpdateBodyPartPositions+20   o  ; was: sub_418D2
                neg.l   d1
                eori.w  #$800,$E(a4)
; End of function Boss_SunsetStingFlipHorizontal
; Adds parent part position offsets to child body part
Boss_SunsetStingApplyParentOffset:                              ; DATA XREF: Boss_SunsetStingUpdateBodyPartPositions+1A   o  ; was: sub_418DA
                movea.w $4E(a4),a3
                add.l   $10(a3),d1
                move.l  d1,$10(a4)
                add.l   $14(a3),d0
                move.l  d0,$14(a4)
                lea     $60(a4),a4
                dbf     d7,loc_41882
                movem.l (sp)+,a5
                rts
; End of function Boss_SunsetStingApplyParentOffset
; Main boss control routine with state machine dispatch
Boss_SunsetStingMainDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_418FC
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_41932
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0 ; '?'
                beq.s   loc_41924
                lea     (word_FFA400).w,a4
                jsr     (loc_427EC).l
                move.b  d0,(byte_FFC73E).w
                move.b  d0,(dword_FFC6DC+1).w
                bra.s   loc_41932
; ---------------------------------------------------------------------------
loc_41924:                              ; CODE XREF: Boss_SunsetStingMainDispatcher+12   j
                lea     (word_FFA400).w,a4
                jsr     (loc_427EC).l
                move.b  d0,(dword_FFC6DC+1).w
loc_41932:                              ; CODE XREF: Boss_SunsetStingMainDispatcher+8   j
                                        ; Boss_SunsetStingMainDispatcher+26   j
                moveq   #4,d7
                jsr (Gfx_InitPaletteFade).l
                move.w  4(a5),d0
                lea     off_41946(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingMainDispatcher
; ---------------------------------------------------------------------------
off_41946:      dc.w Boss_SunsetStingInitState-*        ; DATA XREF: Boss_SunsetStingMainDispatcher+42   o
                dc.w Boss_SunsetStingLoadGraphicsAlt-*
                dc.w Boss_SunsetStingCheckVictoryAlt-*
                dc.w Boss_SunsetStingWaitTransition-*
                dc.w Boss_SunsetStingSetAttackState-*
                dc.w Boss_SunsetStingUpdateMovement-*
                dc.w Boss_SunsetStingAnimateSequence2-*
                dc.w Boss_SunsetStingAnimateSequence3-*
                dc.w Boss_SunsetStingCheckHealthThreshold-*
                dc.w Boss_SunsetStingAnimateSequence1-*
                dc.w Boss_SunsetStingAnimateSequence3-*
                dc.w Boss_SunsetStingCheckHealthThreshold-*
                dc.w Boss_SunsetStingMoveAndShoot_AttackLoop-*
                dc.w Boss_SunsetStingRotateAndMove-*
                dc.w Boss_SunsetStingRiseAndSpawnRing-*
                dc.w Boss_SunsetStingDescendAndActivate-*
                dc.w Boss_SunsetStingWaitAndInitSegments-*
                dc.w Boss_SunsetStingDescendToPosition-*
                dc.w Boss_SunsetStingEndInvulnerability-*
word_4196C:     dc.w $C82C, $D00, $F8F0 ; DATA XREF: ROM:off_4258E   o
                                        ; ROM:0004259A   o
word_41972:     dc.w $C834, $500, $F8F8 ; DATA XREF: ROM:000425FA   o
                                        ; ROM:00042602   o ...
word_41978:     dc.w $C851, 0, $FCFC    ; DATA XREF: ROM:000425B6   o
                                        ; ROM:000425C6   o
word_4197E:     dc.w $C852, 0, $FCFC    ; DATA XREF: ROM:000425D6   o
                                        ; ROM:000425E6   o


; Initializes boss state, clears sprites, sets starting position
Boss_SunsetStingInitState:                              ; DATA XREF: ROM:off_41946   o  ; was: sub_41984
                clr.b   (dword_FFC6DC).w
                move.w  #$1C8,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                addq.w  #2,4(a5)
                move.b  #$80,$4B(a5)
                clr.w   (word_FFC67E).w
                clr.w   (word_FFC678).w
                move.l  #$1C00000,$10(a5)
                move.l  #$2000000,$14(a5)
                rts
; End of function Boss_SunsetStingInitState
; Loads boss graphics tiles, palettes, and body parts
Boss_SunsetStingLoadGraphicsAlt:                              ; DATA XREF: ROM:00041948   o  ; was: sub_419B8
                tst.w   (word_FFF720).w
                bmi.w   locret_41A5E
                addq.w  #2,4(a5)
                movea.l #word_426DA,a1
                jsr (Sprite_InitFromPointerTable).l
                moveq   #6,d7
                jsr (Data_LoadPaletteTable).l
                move.w  (a5),-(sp)
                move.w  #$3300,$E(a5)
                lea     off_4258E(pc),a1 ; debug this
                lea     (a5),a4
                jsr (Boss_SunsetStingInitBodyParts).l
                jsr Boss_SunsetStingInitTrail(pc)   ; (pc)
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
loc_41A1A:                              ; CODE XREF: Boss_SunsetStingLoadGraphicsAlt+76   j
                move.l  #$1C00000,$10(a1)
                move.l  #$1C00000,$14(a1)
                adda.w  #$60,a1 ; '`'
                dbf     d3,loc_41A1A
                move.l  #$FFFF0000,$18(a5)
                move.b  #$18,(byte_FFC79C).w
                move.b  (byte_FFC79C).w,(word_FFC7F8+1).w
                move.b  #$FF,(byte_FFC7FC).w
                move.w  #$180,$56(a5)
                movea.l #word_41A60,a0
                jsr (Gfx_LoadCompressedTiles).l
locret_41A5E:                           ; CODE XREF: Boss_SunsetStingLoadGraphicsAlt+4   j
                rts
; End of function Boss_SunsetStingLoadGraphicsAlt
; ---------------------------------------------------------------------------
word_41A60:     dc.w $6100, $2000, $202, $595A, $5B5D, $5E5F, $6162, $63FF, $6306, $2000, 0, $5CFF, $6306, $2000, 0, $60FF
                                        ; DATA XREF: Boss_SunsetStingLoadGraphicsAlt+9A   o
                dc.w $6306, $2000, 0, $64FF
word_41A88:     dc.w $1E, $FFE6, $FFEC, $FFF2, $FFE8, $FFDE, $FFE4, $FFEA, $FFE0, $FFD6, $FFD4, $FFD2, $FFD0, $FFCE, $FFCC, $FFCA
                                        ; DATA XREF: Boss_SunsetStingMainUpdate+82   o
                dc.w $FFC8


; Checks victory condition and advances to next state
Boss_SunsetStingCheckVictoryAlt:                              ; DATA XREF: ROM:0004194A   o  ; was: sub_41AAA
                tst.w   (word_FF80C2).w
                bne.w   loc_41AD0
                moveq   #5,d0
                jsr (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                bra.w   loc_41AD0
; End of function Boss_SunsetStingCheckVictoryAlt
; Waits for transition to complete before advancing state
Boss_SunsetStingWaitTransition:                              ; DATA XREF: ROM:0004194C   o  ; was: sub_41AC2
                tst.w   (word_FF80C2).w
                bne.s   loc_41AD0
                clr.b   (byte_FF80EC).w
                addq.w  #2,4(a5)
loc_41AD0:                              ; CODE XREF: Boss_SunsetStingCheckVictoryAlt+4   j
                                        ; Boss_SunsetStingCheckVictoryAlt+14   j ...
                bra.w   loc_41B42
; End of function Boss_SunsetStingWaitTransition
; Sets boss to attack state mode and transitions to main loop
Boss_SunsetStingSetAttackState:                              ; DATA XREF: ROM:0004194E   o  ; was: sub_41AD4
                                        ; ROM:00041E44   o
                move.b  #4,$4B(a5)
                bra.w   loc_41AEA
; End of function Boss_SunsetStingSetAttackState
; Sets boss to idle state and initializes attack timer
Boss_SunsetStingSetIdleState:                              ; CODE XREF: Boss_SunsetStingMoveAndShoot+2A   j  ; was: sub_41ADE
                                        ; Boss_SunsetStingCheckPhaseTransition+8   j ...
                move.b  #$10,(byte_FFC79C).w
                move.b  #0,$4B(a5)
loc_41AEA:                              ; CODE XREF: Boss_SunsetStingSetAttackState+6   j
                move.w  #$A,4(a5)
                clr.w   (word_FFC7F8).w
                move.b  (byte_FFC79C).w,(word_FFC7F8+1).w
                bsr.w Boss_SunsetStingCalculateTargetDirection
                bra.w   loc_41C28
; End of function Boss_SunsetStingSetIdleState
; Updates boss vertical movement tracking player
Boss_SunsetStingUpdateMovement:                              ; DATA XREF: ROM:00041950   o  ; was: sub_41B02
                move.w  #$10,d2
                move.w  #$F0,d0
                sub.w   $14(a5),d0
                move.b  (byte_FFC7FC).w,d1
                asl.w   #8,d1
                eor.w   d0,d1
                bpl.s   loc_41B1A
                neg.w   d2
loc_41B1A:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+14   j
                tst.w   d0
                bpl.s   loc_41B20
                neg.w   d0
loc_41B20:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+1A   j
                cmpi.w  #$A,d0
                bcs.s   loc_41B42
                addi.w  #$100,d2
                lsr.w   #1,d2
                move.w  #1,d0
                move.w  $56(a5),d1
                lsr.w   #1,d1
                sub.b   d1,d2
                beq.s   loc_41B42
                bpl.s   loc_41B3E
                neg.w   d0
loc_41B3E:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+38   j
                add.w   d0,$56(a5)
loc_41B42:                              ; CODE XREF: Boss_SunsetStingWaitTransition:loc_41AD0   j
                                        ; Boss_SunsetStingUpdateMovement+22   j ...
                tst.b   (byte_FFC7FC).w
                bpl.s   loc_41B64
                ori.w   #$800,$4EE(a5)
                ori.w   #$800,$72E(a5)
                andi.w  #$F7FF,$2AE(a5)
                andi.w  #$F7FF,$96E(a5)
                bra.w   loc_41B7C
; ---------------------------------------------------------------------------
loc_41B64:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+44   j
                ori.w   #$800,$2AE(a5)
                ori.w   #$800,$96E(a5)
                andi.w  #$F7FF,$4EE(a5)
                andi.w  #$F7FF,$72E(a5)
loc_41B7C:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+5E   j
                moveq   #$FFFFFFFF,d6
                move.b  (word_FFC7F8+1).w,d3
                move.b  (word_FFC7F8).w,d0
                lea     word_41C3E(pc),a3
                bsr.w Boss_SunsetStingUpdatePartRotation
                move.b  (word_FFC7F8+1).w,d3
                move.b  (word_FFC7F8).w,d0
                eori.b  #$14,d0
                lea     word_41C46(pc),a3
                bsr.w Boss_SunsetStingUpdatePartRotation
                subq.b  #1,(word_FFC7F8+1).w
                bne.s   loc_41BF6
                addq.b  #4,(word_FFC7F8).w
                andi.b  #$E,(word_FFC7F8).w
                move.b  (byte_FFC79C).w,(word_FFC7F8+1).w
                bsr.w Boss_SunsetStingCalculateTargetDirection
                cmpi.w  #$A0,d0
                bhi.s   loc_41BEE
                tst.b   $4B(a5)
                bne.w   loc_41BEA
                move.w  (word_FFC678).w,d0
                move.b  (byte_FFC7FC).w,d1
                andi.w  #4,d1
                eori.w  #4,d0
                eor.b   d0,d1
                andi.w  #4,d1
                bne.w Boss_SunsetStingJumpRandomFunction
                move.b  #1,$4B(a5)
loc_41BEA:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+C4   j
                subq.b  #1,$4B(a5)
loc_41BEE:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+BE   j
                move.w  d6,-(sp)
                bsr.w Boss_SunsetStingSpawnRandomProjectile
                move.w  (sp)+,d6
loc_41BF6:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+A4   j
                tst.w   d6
                bmi.s   loc_41C28
                cmp.w   (word_FFC678).w,d6
                beq.s   loc_41C28
                lea     word_41FA0(pc),a2
                movea.w (a2,d6.w),a4
                adda.w  a5,a4
                move.l  #word_EBEA0,$1E8(a4)
                move.w  (word_FFC678).w,d0
                move.w  d6,(word_FFC678).w
                movea.w (a2,d0.w),a4
                adda.w  a5,a4
                move.l  #word_EBE94,$1E8(a4)
loc_41C28:                              ; CODE XREF: Boss_SunsetStingSetIdleState+20   j
                                        ; Boss_SunsetStingUpdateMovement+F6   j ...
                move.w  (word_FFC678).w,d6
                lea     word_41FA0(pc),a4
                movea.w (a4,d6.w),a4
                adda.l  a5,a4
                bsr.w Boss_SunsetStingCalculateChainPosition
                bra.w   loc_422C0
; End of function Boss_SunsetStingUpdateMovement
; ---------------------------------------------------------------------------
word_41C3E:     dc.w $2C, 0, $32, 0     ; DATA XREF: Boss_SunsetStingUpdateMovement+84   o
word_41C46:     dc.w $42, 0, $34, 0, 8, 0, $E, 0, $40, $FFC0, $FFC0, $FFC0, $FFC0, $FFE0, $FFE0, $FFE0
                                        ; DATA XREF: Boss_SunsetStingUpdateMovement+98   o
                dc.w $FFE0, $FFE0, 0, $20, $20, $20, $20, $FF80, $80, $80, $80, $80, 0, $FFE0, $FFE0, $FFE0
                dc.w $FFE0, $80, $FF80, $FF80, $FF80, $FF80, 0, $40, $40, $40, $40, $FFE0, $FFC0, $FFC0, $FFC0, $FFC0
word_41CA6:     dc.w $1A, 0, $FFCA, 0   ; DATA XREF: Boss_SunsetStingAnimateSequence3   o
                                        ; sub_41F6A:loc_41F82   o
word_41CAE:     dc.w 8, 0, $E, 0, $60, $20, $20, $20, $20, $FFA0, $FFE0, $FFE0, $FFE0, $FFE0
                                        ; DATA XREF: Boss_SunsetStingAnimateSequence2   o
word_41CCA:     dc.w $12, 0, 4, 0, $40, $60, $80, $A0, $C0, 0, 0, 0, 0, 0
                                        ; DATA XREF: Boss_SunsetStingAnimateSequence1   o


; Calculates target direction based on player position
Boss_SunsetStingCalculateTargetDirection:                              ; CODE XREF: Boss_SunsetStingSetIdleState+1C   p  ; was: sub_41CE6
                                        ; Boss_SunsetStingUpdateMovement+B6   p ...
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                move.b  d0,(byte_FFC7FD).w
                move.w  $14(a5),d0
                cmpi.w  #$120,d0
                bhi.s   loc_41D1E
                lea     (word_FFA400).w,a4
                move.w  dword_FFA410-word_FFA400(a4),d0
                sub.w   $10(a5),d0
                ext.l   d0
                bpl.s   loc_41D10
                neg.w   d0
loc_41D10:                              ; CODE XREF: Boss_SunsetStingCalculateTargetDirection+26   j
                add.b   d0,(byte_FFC7FD).w
                swap    d0
                move.b  d0,(byte_FFC7FC).w
                swap    d0
                rts
; ---------------------------------------------------------------------------
loc_41D1E:                              ; CODE XREF: Boss_SunsetStingCalculateTargetDirection+16   j
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
Boss_SunsetStingGetBodyPartPointer:                              ; CODE XREF: Boss_SunsetStingUpdatePartRotation:loc_41D58   p  ; was: sub_41D36
                                        ; Boss_SunsetStingFlipAndAnimate+1E   p
                tst.b   (byte_FFC7FC).w
                bmi.s   loc_41D40
                eori.b  #$10,d0
loc_41D40:                              ; CODE XREF: Boss_SunsetStingGetBodyPartPointer+4   j
                move.w  d0,d1
                lsr.w   #2,d0
                andi.w  #6,d0
                lea     word_41FA0(pc),a0
                movea.w (a0,d0.w),a4
                adda.l  a5,a4
                rts
; End of function Boss_SunsetStingGetBodyPartPointer
; Updates body part rotation angles with target tracking
Boss_SunsetStingUpdatePartRotation:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+88   p  ; was: sub_41D54
                                        ; Boss_SunsetStingUpdateMovement+9C   p
                move.w  #$20,d2 ; ' '
loc_41D58:                              ; CODE XREF: Boss_SunsetStingAnimateSequence3+14   p
                                        ; Boss_SunsetStingRiseAndSpawnRing+26   p
                bsr.s Boss_SunsetStingGetBodyPartPointer
                move.w  d1,-(sp)
                asl.w   #5,d1
                sub.w   d3,d1
                andi.w  #$FF,d1
                addi.b  #$40,d1 ; '@'
                btst    #7,d1
                beq.s   loc_41D70
                move.w  d0,d6
loc_41D70:                              ; CODE XREF: Boss_SunsetStingUpdatePartRotation+18   j
                move.w  (sp)+,d1
                andi.w  #6,d1
                lea     (a3,d1.w),a0
                adda.w  (a0),a0
                bsr.w Boss_SunsetStingAnimatePartSequence
                rts
; End of function Boss_SunsetStingUpdatePartRotation
; Animates sequence of connected body parts
Boss_SunsetStingAnimatePartSequence:                              ; CODE XREF: Boss_SunsetStingUpdatePartRotation+28   p  ; was: sub_41D82
                lea     $60(a4),a1
                move.w  #4,d4
loc_41D8A:                              ; CODE XREF: Boss_SunsetStingAnimatePartSequence+36   j
                move.w  (a0)+,d0
                ; Original immediate is $B; memory BTST uses its low three bits.
                dc.w    $082C, $000B, $000E ; btst #$B,$E(a4)
                beq.s   loc_41D96
                neg.w   d0
loc_41D96:                              ; CODE XREF: Boss_SunsetStingAnimatePartSequence+10   j
                sub.w   $56(a1),d0
                ext.l   d0
                divs.w  d3,d0
                add.w   d0,$56(a1)
                move.w  #1,d0
                cmp.w   $4C(a1),d2
                beq.s   loc_41DB4
                bpl.s   loc_41DB0
                neg.w   d0
loc_41DB0:                              ; CODE XREF: Boss_SunsetStingAnimatePartSequence+2A   j
                add.w   d0,$4C(a1)
loc_41DB4:                              ; CODE XREF: Boss_SunsetStingAnimatePartSequence+28   j
                adda.w  #$60,a1 ; '`'
                dbf     d4,loc_41D8A
                rts
; End of function Boss_SunsetStingAnimatePartSequence
; Spawns projectiles at random positions using jump table
Boss_SunsetStingSpawnRandomProjectile:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+EE   p  ; was: sub_41DBE
                tst.w   (word_FFFF0E).w
                beq.w   locret_41DFC
loc_41DC6:                              ; CODE XREF: Boss_SunsetStingMoveAndShoot+26   p
                jsr     (RandomNumber).l
                andi.w  #6,d0
                movem.l a5,-(sp)
                lea     word_41FA0(pc),a2
                adda.w  d0,a2
                movea.w (a2)+,a5
                adda.l  (sp),a5
                adda.w  #$1E0,a5
                lea     (word_FFA400).w,a4
                jsr     (loc_427EC).l
                movem.l d2/a2,-(sp)
                bsr.w Boss_SunsetStingInitHomingProjectile
                movem.l (sp)+,d2/a2
                movem.l (sp)+,a5
locret_41DFC:                           ; CODE XREF: Boss_SunsetStingSpawnRandomProjectile+4   j
                rts
; End of function Boss_SunsetStingSpawnRandomProjectile
; Initializes homing projectile with angle offset
Boss_SunsetStingInitHomingProjectile:                              ; CODE XREF: Boss_SunsetStingSpawnRandomProjectile+32   p  ; was: sub_41DFE
                andi.w  #$FF,d0
                subi.b  #$40,d0 ; '@'
                move.w  d0,-(sp)
                movea.w #(byte_FFD280-M68K_RAM),a0
                jsr     (loc_1C0A4).l
                bne.s   locret_41E2A
                move.w  (sp)+,d6
                add.w   d6,d6
                move.w  #0,d0
                move.w  #0,d1
                move.w  #$8000,d2
                jsr (Enemy_InitHomingProjectile).l
locret_41E2A:                           ; CODE XREF: Boss_SunsetStingInitHomingProjectile+14   j
                rts
; End of function Boss_SunsetStingInitHomingProjectile
; Jumps to random function for boss pattern variation
Boss_SunsetStingJumpRandomFunction:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+DE   j  ; was: sub_41E2C
                lea     word_41E36(pc),a0
                jmp     JumpRandomFunc
; End of function Boss_SunsetStingJumpRandomFunction
; ---------------------------------------------------------------------------
word_41E36:     dc.w $2000              ; DATA XREF: Boss_SunsetStingJumpRandomFunction   o
                dc.w Boss_SunsetStingMoveAndShoot-*
                dc.w $6000
                dc.w Boss_SunsetStingFlipDirection-*
                dc.w $6000
                dc.w Boss_SunsetStingFlipAndAnimate-*
                dc.w $6000
                dc.w Boss_SunsetStingSetAttackState-*


; Moves boss based on player position and spawns projectiles
Boss_SunsetStingMoveAndShoot:                              ; DATA XREF: ROM:00041E38   o  ; was: sub_41E46
                move.w  #$18,4(a5)
                move.b  #$40,$4B(a5) ; '@'
; Calculate direction and rotate while attacking
Boss_SunsetStingMoveAndShoot_AttackLoop:                              ; DATA XREF: ROM:0004195E   o  ; was: loc_41E52
                bsr.w Boss_SunsetStingCalculateTargetDirection
                move.b  (byte_FFC7FC).w,d0
                ext.w   d0
                add.w   d0,d0
                addq.w  #1,d0
                add.w   d0,$56(a5)
                subq.b  #1,$4B(a5)
                bne.w   loc_41B42
                bsr.w   loc_41DC6
                bra.w Boss_SunsetStingSetIdleState
; End of function Boss_SunsetStingMoveAndShoot
; Flips boss horizontal direction and updates animation
Boss_SunsetStingFlipDirection:                              ; DATA XREF: ROM:00041E3C   o  ; was: sub_41E74
                move.w  #$12,4(a5)
                andi.b  #8,(word_FFC7F8).w
                move.b  #$20,(word_FFC7F8+1).w ; ' '
                not.b   (byte_FFC7FC).w
                bra.w   loc_41C28
; End of function Boss_SunsetStingFlipDirection
; Loads animation sequence data for pattern execution
Boss_SunsetStingAnimateSequence1:                              ; DATA XREF: ROM:00041958   o  ; was: sub_41E8E
                lea     word_41CCA(pc),a3
                moveq   #0,d2
                move.b  (byte_FFC7FD).w,d2
                bra.w   loc_41EDE
; End of function Boss_SunsetStingAnimateSequence1
; Flips direction, toggles sprite flip flag, updates animation
Boss_SunsetStingFlipAndAnimate:                              ; DATA XREF: ROM:00041E40   o  ; was: sub_41E9C
                move.w  #$C,4(a5)
                andi.b  #8,(word_FFC7F8).w
                move.b  #$20,(word_FFC7F8+1).w ; ' '
                not.b   (byte_FFC7FC).w
                move.b  (word_FFC7F8).w,d0
                eori.b  #$14,d0
                bsr.w Boss_SunsetStingGetBodyPartPointer
                eori.w  #$800,$E(a4)
                bra.w   loc_41C28
; End of function Boss_SunsetStingFlipAndAnimate
; Loads alternate animation sequence for different pattern
Boss_SunsetStingAnimateSequence2:                              ; DATA XREF: ROM:00041952   o  ; was: sub_41EC8
                lea     word_41CAE(pc),a3
                moveq   #0,d2
                move.b  (byte_FFC7FD).w,d2
                bra.w   loc_41EDE
; End of function Boss_SunsetStingAnimateSequence2
; Loads third animation sequence and updates frame
Boss_SunsetStingAnimateSequence3:                              ; DATA XREF: ROM:00041954   o  ; was: sub_41ED6
                                        ; ROM:0004195A   o
                lea     word_41CA6(pc),a3
                move.w  #$20,d2 ; ' '
loc_41EDE:                              ; CODE XREF: Boss_SunsetStingAnimateSequence1+A   j
                                        ; Boss_SunsetStingAnimateSequence2+A   j
                move.b  (word_FFC7F8+1).w,d3
                move.b  (word_FFC7F8).w,d0
                eori.b  #$14,d0
                bsr.w   loc_41D58
                ori.b   #$40,-$3F(a1) ; '@'
                subq.b  #1,(word_FFC7F8+1).w
                bne.s   loc_41F2A
                move.b  (word_FFC7F8).w,d0
                addq.b  #4,(word_FFC7F8).w
                move.b  (word_FFC7F8).w,d1
                eor.b   d0,d1
                andi.b  #8,d1
                beq.s   loc_41F1E
                eori.b  #8,(word_FFC7F8).w
                addq.w  #2,4(a5)
                subi.w  #$80,(word_FF8234).w
loc_41F1E:                              ; CODE XREF: Boss_SunsetStingAnimateSequence3+36   j
                andi.b  #$E,(word_FFC7F8).w
                move.b  #$20,(word_FFC7F8+1).w ; ' '
loc_41F2A:                              ; CODE XREF: Boss_SunsetStingAnimateSequence3+22   j
                bra.w   loc_41C28
; End of function Boss_SunsetStingAnimateSequence3
; Checks boss health threshold for behavior branch
Boss_SunsetStingCheckHealthThreshold:                              ; CODE XREF: Boss_SunsetStingEndInvulnerability+C   j  ; was: sub_41F2E
                                        ; DATA XREF: ROM:00041956   o ...
                andi.b  #$BF,$4A1(a5)
                andi.b  #$BF,$6E1(a5)
                andi.b  #$BF,$921(a5)
                andi.b  #$BF,$B61(a5)
                cmpi.w  #$C0,(word_FF8234).w
                bgt.s Boss_SunsetStingCheckPhaseTransition
                bra.w Boss_SunsetStingInitRecoveryState
; End of function Boss_SunsetStingCheckHealthThreshold
; Checks if boss should transition to next phase
Boss_SunsetStingCheckPhaseTransition:                              ; CODE XREF: Boss_SunsetStingCheckHealthThreshold+1E   j  ; was: sub_41F52
                tst.b   (dword_FFC6DC).w
                bne.w Boss_SunsetStingStartDeathSequence
                bra.w Boss_SunsetStingSetIdleState
; End of function Boss_SunsetStingCheckPhaseTransition
; Initializes boss recovery state with timer
Boss_SunsetStingInitRecoveryState:                              ; CODE XREF: Boss_SunsetStingCheckHealthThreshold+20   j  ; was: sub_41F5E
                move.b  #$C0,$4B(a5)
                move.w  #$1C,4(a5)
; End of function Boss_SunsetStingInitRecoveryState
; Moves boss upward and spawns ring of projectiles
Boss_SunsetStingRiseAndSpawnRing:                              ; DATA XREF: ROM:00041962   o  ; was: sub_41F6A
                addi.w  #2,(word_FF8234).w
                cmpi.w  #$1E0,(word_FF8234).w
                bge.w Boss_SunsetStingSetIdleState
                move.w  #0,d0
                move.w  #3,d7
loc_41F82:                              ; CODE XREF: Boss_SunsetStingRiseAndSpawnRing+2E   j
                lea     word_41CA6(pc),a3
                move.w  #$30,d2 ; '0'
                move.b  (word_FFC7F8+1).w,d3
                move.w  d0,-(sp)
                bsr.w   loc_41D58
                move.w  (sp)+,d0
                addq.w  #8,d0
                dbf     d7,loc_41F82
                bra.w   loc_41C28
; End of function Boss_SunsetStingRiseAndSpawnRing
; ---------------------------------------------------------------------------
word_41FA0:     dc.w $2A0, $4E0, $720, $960
                                        ; DATA XREF: Boss_SunsetStingUpdateMovement+FE   o
                                        ; Boss_SunsetStingUpdateMovement+12A   o ...


; Calculates position using sine/cosine chain physics
Boss_SunsetStingCalculateChainPosition:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+134   p  ; was: sub_41FA8
                move.w  #5,d7
                move.w  $56(a5),d6
                clr.l   d3
                clr.l   d4
                lea     (a4),a3
                movea.l #word_1B514,a2
loc_41FBC:                              ; CODE XREF: Boss_SunsetStingCalculateChainPosition+38   j
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
                dbf     d7,loc_41FBC
                add.l   -$50(a3),d3
                add.l   -$4C(a3),d4
                move.l  d3,$10(a5)
                move.l  #$E00000,d0
                cmp.l   d0,d4
                bhi.s   loc_41FFC
                move.l  d0,d4
loc_41FFC:                              ; CODE XREF: Boss_SunsetStingCalculateChainPosition+50   j
                move.l  d4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; End of function Boss_SunsetStingCalculateChainPosition
; Initiates boss death animation sequence
Boss_SunsetStingStartDeathSequence:                              ; CODE XREF: Boss_SunsetStingCheckPhaseTransition+4   j  ; was: sub_4200A
                move.w  #$1A,4(a5)
                move.b  #0,$4B(a5)
                move.w  #4,(dword_FFC6D8).w
                bra.w Boss_SunsetStingMainUpdate
; End of function Boss_SunsetStingStartDeathSequence
; Updates scale factor of body segments
Boss_SunsetStingUpdateSegmentScale:                              ; CODE XREF: Boss_SunsetStingUpdateAllSegments+4   p  ; was: sub_42020
                                        ; Boss_SunsetStingUpdateAllSegments+A   p ...
                lea     $60(a4),a3
                move.w  #4,d4
loc_42028:                              ; CODE XREF: Boss_SunsetStingUpdateSegmentScale+1E   j
                move.w  #1,d0
                cmp.w   $4C(a3),d2
                beq.s   loc_4203A
                bpl.s   loc_42036
                neg.w   d0
loc_42036:                              ; CODE XREF: Boss_SunsetStingUpdateSegmentScale+12   j
                add.w   d0,$4C(a3)
loc_4203A:                              ; CODE XREF: Boss_SunsetStingUpdateSegmentScale+10   j
                adda.w  #$60,a3 ; '`'
                dbf     d4,loc_42028
                rts
; End of function Boss_SunsetStingUpdateSegmentScale
; Updates all four boss body segments
Boss_SunsetStingUpdateAllSegments:                              ; CODE XREF: Boss_SunsetStingRotateAndMove+96   p  ; was: sub_42044
                lea     $2A0(a5),a4
                bsr.s Boss_SunsetStingUpdateSegmentScale
                lea     $4E0(a5),a4
                bsr.s Boss_SunsetStingUpdateSegmentScale
                lea     $720(a5),a4
                bsr.s Boss_SunsetStingUpdateSegmentScale
                lea     $960(a5),a4
                bsr.s Boss_SunsetStingUpdateSegmentScale
                rts
; End of function Boss_SunsetStingUpdateAllSegments
; Rotates boss body and updates vertical movement
Boss_SunsetStingRotateAndMove:                              ; DATA XREF: ROM:00041960   o  ; was: sub_4205E
                move.w  #1,d1
                btst    #0,(word_FFA000).w
                bne.s   loc_4206C
                neg.w   d1
loc_4206C:                              ; CODE XREF: Boss_SunsetStingRotateAndMove+A   j
                add.w   d1,(dword_FFC6D8).w
                move.w  #$70,d1 ; 'p'
                move.w  d1,d2
                move.w  (dword_FFC6D8).w,d0
                bpl.s   loc_42080
                neg.w   d0
                neg.w   d1
loc_42080:                              ; CODE XREF: Boss_SunsetStingRotateAndMove+1C   j
                cmp.w   d2,d0
                bcs.s   loc_42088
                move.w  d1,(dword_FFC6D8).w
loc_42088:                              ; CODE XREF: Boss_SunsetStingRotateAndMove+24   j
                movea.l #word_1B514,a2
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
                beq.s   loc_420D2
                bpl.s   loc_420CC
                cmpi.w  #$C0,d1
                bhi.s   loc_420DE
                move.l  #$10000,$1C(a5)
                bra.w   loc_420DE
; ---------------------------------------------------------------------------
loc_420CC:                              ; CODE XREF: Boss_SunsetStingRotateAndMove+5A   j
                cmpi.w  #$160,d1
                bcs.s   loc_420DE
loc_420D2:                              ; CODE XREF: Boss_SunsetStingRotateAndMove+58   j
                move.l  #$FFFF0000,$1C(a5)
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_420DE:                              ; CODE XREF: Boss_SunsetStingRotateAndMove+60   j
                                        ; Boss_SunsetStingRotateAndMove+6A   j ...
                move.w  (dword_FFC6D8).w,d0
                bsr.w Boss_SunsetStingUpdateSegmentPositions
                move.w  (dword_FFC6D8).w,d2
                bpl.s   loc_420EE
                neg.w   d2
loc_420EE:                              ; CODE XREF: Boss_SunsetStingRotateAndMove+8C   j
                lsr.w   #2,d2
                addi.w  #$20,d2 ; ' '
                bsr.w Boss_SunsetStingUpdateAllSegments
                move.w  (dword_FFC6D8).w,d1
                asr.w   #3,d1
                add.w   d1,$56(a5)
                bra.w Boss_SunsetStingMainUpdate
; End of function Boss_SunsetStingRotateAndMove
; Updates X positions of all segments based on rotation
Boss_SunsetStingUpdateSegmentPositions:                              ; CODE XREF: Boss_SunsetStingRotateAndMove+84   p  ; was: sub_42106
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                lea     (sp),a3
                bsr.w Boss_SunsetStingSmoothSegmentTracking
                addq.w  #8,sp
                rts
; End of function Boss_SunsetStingUpdateSegmentPositions
; Smoothly interpolates segment positions
Boss_SunsetStingSmoothSegmentTracking:                              ; CODE XREF: Boss_SunsetStingUpdateSegmentPositions+A   p  ; was: sub_42118
                lea     word_41FA0(pc),a2
                move.w  #3,d4
loc_42120:                              ; CODE XREF: Boss_SunsetStingSmoothSegmentTracking+1C   j
                movea.w (a2)+,a4
                adda.w  a5,a4
                move.w  (word_FFC67A).w,d2
                add.w   (a3)+,d2
                sub.w   $58(a4),d2
                asr.w   #3,d2
                add.w   d2,$58(a4)
                dbf     d4,loc_42120
                rts
; End of function Boss_SunsetStingSmoothSegmentTracking
; Calculates horizontal direction to player
Boss_SunsetStingGetDirectionToPlayer:
                move.w  #1,d1  ; was: sub_4213A
                lea     (word_FFA400).w,a0
                move.w  dword_FFA410-word_FFA400(a0),d0
                sub.w   $10(a5),d0
                bhi.s   locret_4214E
                neg.w   d1
locret_4214E:                           ; CODE XREF: Boss_SunsetStingGetDirectionToPlayer+10   j
                rts
; End of function Boss_SunsetStingGetDirectionToPlayer
; Moves boss downward and activates body segments
Boss_SunsetStingDescendAndActivate:                              ; DATA XREF: ROM:00041964   o  ; was: sub_42150
                addi.l  #$400,$1C(a5)
                move.l  #$200020,d1
                jsr (Projectile_SpawnWithRandomOffset).l
                cmpi.w  #$1C0,$14(a5)
                bcs.w   loc_422C0
                addq.w  #2,4(a5)
                move.b  #$20,$4B(a5) ; ' '
                clr.l   $1C(a5)
                ori.b   #$40,$4A1(a5) ; '@'
                ori.b   #$10,$4A3(a5)
                ori.b   #$40,$6E1(a5) ; '@'
                ori.b   #$10,$6E3(a5)
                ori.b   #$40,$921(a5) ; '@'
                ori.b   #$10,$923(a5)
                ori.b   #$40,$B61(a5) ; '@'
                ori.b   #$10,$B63(a5)
                bra.w   loc_422C0
; End of function Boss_SunsetStingDescendAndActivate
; Waits for timer then initializes body segments
Boss_SunsetStingWaitAndInitSegments:                              ; DATA XREF: ROM:00041966   o  ; was: sub_421B0
                move.l  #$400040,d1
                jsr (Projectile_SpawnWithRandomOffset).l
                subq.b  #1,$4B(a5)
                bne.w   loc_422C0
                addq.w  #2,4(a5)
                move.w  $14(a5),(word_FFC738).w
                clr.w   (word_FFC73C).w
                lea     $BA0(a5),a4
                move.w  #7,d4
loc_421DA:                              ; CODE XREF: Boss_SunsetStingWaitAndInitSegments+3A   j
                move.w  $14(a5),$14(a4)
                ori.w   #$8000,2(a4)
                lea     $60(a4),a4
                dbf     d4,loc_421DA
                bra.w   loc_422C0
; End of function Boss_SunsetStingWaitAndInitSegments
; Descends boss to specific Y position
Boss_SunsetStingDescendToPosition:                              ; DATA XREF: ROM:00041968   o  ; was: sub_421F2
                move.l  #$400040,d1
                jsr (Projectile_SpawnWithRandomOffset).l
                addq.w  #1,(word_FFC73C).w
                move.w  (word_FFC73C).w,d0
                lsr.w   #2,d0
                sub.w   d0,(word_FFC738).w
                cmpi.w  #$80,(word_FFC738).w
                bhi.w   loc_422C0
                addq.w  #2,4(a5)
                move.b  #$20,$4B(a5) ; ' '
                bra.w   loc_422C0
; End of function Boss_SunsetStingDescendToPosition
; Ends invulnerability period
Boss_SunsetStingEndInvulnerability:                              ; DATA XREF: ROM:0004196A   o  ; was: sub_42224
                subq.b  #1,$4B(a5)
                bne.w   loc_422C0
                clr.b   (byte_FF80EC).w
                bra.w Boss_SunsetStingCheckHealthThreshold
; End of function Boss_SunsetStingEndInvulnerability
; Calculates alternate screen offset based on boss position
Boss_SunsetStingCalculateScreenOffsetAlt:
                move.w  (dword_FFA900).w,d0  ; was: sub_42234
                add.w   $10(a5),d0
                tst.w   $18(a5)
                bpl.s   loc_42248
                subi.w  #$12C0,d0
                rts
; ---------------------------------------------------------------------------
loc_42248:                              ; CODE XREF: Boss_SunsetStingCalculateScreenOffsetAlt+C   j
                move.w  #$1400,d1
                sub.w   d0,d1
                rts
; End of function Boss_SunsetStingCalculateScreenOffsetAlt
; Updates sprite orientation and animation frame
Boss_SunsetStingUpdateSpriteOrientation:
                andi.w  #$F7FF,$E(a5)  ; was: sub_42250
                movem.l d3,-(sp)
                lea     (word_FFA400).w,a4
                jsr     (loc_427EC).l
                movem.l (sp)+,d3
                move.b  d0,d2
                bpl.s   loc_42274
                ori.w   #$800,$E(a5)
                neg.b   d2
loc_42274:                              ; CODE XREF: Boss_SunsetStingUpdateSpriteOrientation+1A   j
                move.w  d3,$5A(a5)
                add.w   $5A(a5),d2
                move.w  d2,6(a5)
                rts
; End of function Boss_SunsetStingUpdateSpriteOrientation
; Updates boss rotation angle using animation frame
Boss_SunsetStingUpdateRotation:
                move.w  $56(a5),d1  ; was: sub_42282
                lsr.w   #1,d1
                move.w  6(a5),d0
                sub.b   d1,d0
                asr.b   #2,d0
                ext.w   d0
                add.w   d0,$56(a5)
                rts
; End of function Boss_SunsetStingUpdateRotation
; Main update routine for segments, animations, collision
Boss_SunsetStingMainUpdate:                              ; CODE XREF: Boss_SunsetStingStartDeathSequence+12   j  ; was: sub_42298
                                        ; Boss_SunsetStingRotateAndMove+A4   j ...
                lea     $960(a5),a4
                jsr Boss_SunsetStingUpdateSegmentPhysics(pc)   ; (pc)
                nop
                lea     $2A0(a5),a4
                jsr Boss_SunsetStingUpdateSegmentPhysics(pc)   ; (pc)
                nop
                lea     $4E0(a5),a4
                jsr Boss_SunsetStingUpdateSegmentPhysics(pc)   ; (pc)
                nop
                lea     $720(a5),a4
                jsr Boss_SunsetStingUpdateSegmentPhysics(pc)   ; (pc)
                nop
loc_422C0:                              ; CODE XREF: Boss_SunsetStingUpdateMovement+138   j
                                        ; Boss_SunsetStingDescendAndActivate+1A   j ...
                move.b  (byte_FFC73E).w,d0
                add.w   d0,d0
                sub.w   $56(a5),d0
                move.w  d0,$B6(a5)
                btst    #2,(byte_FF80EC).w
                bne.s   loc_4230C
                btst    #1,(byte_FF80EC).w
                bne.s   loc_4230C
                move.w  (word_FF8200).w,d0
                beq.w Boss_SunsetStingResetToIdle
                tst.b   (dword_FFC6DC).w
                bne.s   loc_4230C
                cmpi.w  #$3000,d0
                bhi.s   loc_4230C
                move.b  #1,(dword_FFC6DC).w
                move.w  #$1E,4(a5)
                move.b  #6,(byte_FF80EC).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
loc_4230C:                              ; CODE XREF: Boss_SunsetStingMainUpdate+3C   j
                                        ; Boss_SunsetStingMainUpdate+44   j ...
                lea     off_4258E(pc),a1 ; debug this
                jsr (Boss_SunsetStingUpdateBodyPartPositions).l
                bsr.w Boss_SunsetStingUpdateScreenBounds
                lea     word_41A88(pc),a0
                move.w  (word_FFC67E).w,d0
                lsr.w   #2,d0
                bsr.w Gfx_LoadAnimationFrame
                addq.w  #1,(word_FFC67E).w
                ori.w   #$1800,$48E(a5)
                andi.w  #$E7FF,$6CE(a5)
                andi.w  #$E7FF,$90E(a5)
                ori.w   #$1800,$B4E(a5)
                bsr.w Boss_SunsetStingUpdateTrail
                rts
; End of function Boss_SunsetStingMainUpdate
; Updates individual segment physics
Boss_SunsetStingUpdateSegmentPhysics:                              ; CODE XREF: Boss_SunsetStingMainUpdate+4   p  ; was: sub_4234A
                                        ; Boss_SunsetStingMainUpdate+E   p ...
                move.w  $58(a4),d2
                tst.b   d2
                bpl.s   loc_42356
                neg.b   d2
                subq.b  #1,d2
loc_42356:                              ; CODE XREF: Boss_SunsetStingUpdateSegmentPhysics+6   j
                andi.w  #$7F,d2
                subi.w  #$40,d2 ; '@'
                lea     $60(a4),a3
                move.w  d2,$56(a3)
                move.w  #4,d4
loc_4236A:                              ; CODE XREF: Boss_SunsetStingUpdateSegmentPhysics+2A   j
                move.w  $B6(a4),$56(a3)
                adda.w  #$60,a3 ; '`'
                dbf     d4,loc_4236A
                movea.l #word_1B514,a2
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
; End of function Boss_SunsetStingUpdateSegmentPhysics
; Loads compressed tile data for animation frame
Gfx_LoadAnimationFrame:                              ; CODE XREF: Boss_SunsetStingMainUpdate+8C   p  ; was: sub_423CE
                and.w   (a0)+,d0
                adda.w  d0,a0
                adda.w  (a0),a0
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_LoadAnimationFrame
; Resets boss to idle state after defeat
Boss_SunsetStingResetToIdle:                              ; CODE XREF: Boss_SunsetStingMainUpdate+4A   j  ; was: sub_423DA
                bset    #0,(byte_FFA272).w
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #$7FFF,(word_FF8200).w
                clr.b   (dword_FFC6DC).w
                clr.w   4(a5)
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                bra.w Boss_SunsetStingMainUpdate
; End of function Boss_SunsetStingResetToIdle
; Initializes fragment explosion with random velocities
Boss_SunsetStingInitFragmentExplosion:
                subq.b  #1,$4B(a5)  ; was: sub_4240A
                bne.w Boss_SunsetStingMainUpdate
                addq.w  #2,4(a5)
                clr.b   $21(a5)
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
                lea     (word_1B514).l,a2
loc_4242A:                              ; CODE XREF: Boss_SunsetStingInitFragmentExplosion+6A   j
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
                dbf     d4,loc_4242A
                addi.l  #$800,$1C(a5)
                cmpi.w  #$1C0,$14(a5)
                bhi.s   loc_42498
                move.l  #$200020,d1
                bsr.w Boss_SunsetStingSpawnFragmentProjectile
                bsr.w Boss_SunsetStingUpdateScreenBounds
                rts
; ---------------------------------------------------------------------------
loc_42498:                              ; CODE XREF: Boss_SunsetStingInitFragmentExplosion+7C   j
                move.b  #$40,$4B(a5) ; '@'
                addq.w  #2,4(a5)
                move.w  #1,d5
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
loc_424B0:                              ; CODE XREF: Boss_SunsetStingInitFragmentExplosion+B0   j
                move.b  d5,$4B(a4)
                addq.w  #1,d5
                lea     $60(a4),a4
                dbf     d4,loc_424B0
                rts
; End of function Boss_SunsetStingInitFragmentExplosion
; Handles boss death fade out effect
Boss_SunsetStingDeathFadeOut:
                move.w  #4,(word_FFA010).w  ; was: sub_424C0
                move.w  #4,(word_FFA014).w
                subq.b  #1,$4B(a5)
                bne.w   locret_424D6
                clr.w   (a5)
locret_424D6:                           ; CODE XREF: Boss_SunsetStingDeathFadeOut+10   j
                rts
; End of function Boss_SunsetStingDeathFadeOut
; Updates individual fragment animation
Boss_SunsetStingUpdateFragment:
                tst.b   $4B(a5)  ; was: sub_424D8
                beq.s   loc_424E4
                subq.b  #1,$4B(a5)
                beq.s   loc_42506
loc_424E4:                              ; CODE XREF: Boss_SunsetStingUpdateFragment+4   j
                move.w  $5C(a5),d0
                add.w   d0,$56(a5)
                move.l  $50(a5),d0
                beq.s   locret_42504
                movea.l d0,a1
                move.w  $56(a5),d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a5)
locret_42504:                           ; CODE XREF: Boss_SunsetStingUpdateFragment+18   j
                rts
; ---------------------------------------------------------------------------
loc_42506:                              ; CODE XREF: Boss_SunsetStingUpdateFragment+A   j
                lea     (a5),a0
                jsr     (loc_2A2A4).l
                clr.b   $21(a5)
                rts
; End of function Boss_SunsetStingUpdateFragment
; Spawns projectile fragment with random offset
Boss_SunsetStingSpawnFragmentProjectile:                              ; CODE XREF: Boss_SunsetStingInitFragmentExplosion+84   p  ; was: sub_42514
                move.l  d1,-(sp)
                jsr (Projectile_InitTypeA4).l
                bne.s   loc_4256C
                jsr (Sprite_InitFromTable).l
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
loc_4256C:                              ; CODE XREF: Boss_SunsetStingSpawnFragmentProjectile+8   j
                move.l  (sp)+,d1
                rts
; End of function Boss_SunsetStingSpawnFragmentProjectile
; Updates boss screen boundary values
Boss_SunsetStingUpdateScreenBounds:                              ; CODE XREF: Boss_SunsetStingMainUpdate+7E   p  ; was: sub_42570
                                        ; Boss_SunsetStingInitFragmentExplosion+88   p
                move.w  #$A8,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$48,d0 ; 'H'
                move.w  d0,(dword_FFA90C).w
                jmp Boss_CheckScreenBounds
; End of function Boss_SunsetStingUpdateScreenBounds
; ---------------------------------------------------------------------------
off_4258E:      dc.l word_4196C         ; DATA XREF: Boss_SunsetStingLoadGraphicsAlt+28   o
                                        ; sub_42298:loc_4230C   o
                                        ; debug this
                dc.l 0
                dc.l $80000001
                dc.l word_4196C
                dc.l $100140
                dc.l $80000000
                dc.l $80000001
                dc.l word_EBE88
                dc.l $A10000
                dc.l $80000001
                dc.l word_41978
                dc.l $200190
                dc.l $80000000
                dc.l $80000001
                dc.l word_41978
                dc.l $200070
                dc.l $80000000
                dc.l $80000001
                dc.l word_4197E
                dc.l $3001D0
                dc.l $80000000
                dc.l $80000001
                dc.l word_4197E
                dc.l $300030
                dc.l $80000000
                dc.l $80000000
                dc.l $80000001
                dc.l word_41972
                dc.l $A10040
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_EBE94
                dc.l $210000
                dc.l $80000000
                dc.l $80000001
                dc.l word_41972
                dc.l $A100C0
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_EBE94
                dc.l $210000
                dc.l $80000000
                dc.l $80000001
                dc.l word_41972
                dc.l $A10140
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_EBE94
                dc.l $210000
                dc.l $80000000
                dc.l $80000001
                dc.l word_41972
                dc.l $A101C0            ; UNUSED: Love Penguin sprite table entry
                                        ; See line 20999 for boss structure ($01C0)
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_41972
                dc.l $210000
                dc.l word_EBE94
                dc.l $210000
                dc.l $80000000
                dc.l $80000000
word_426DA:     dc.w $C620, $1408, $E41C, $E41C, $10, $C6E0, $1078, $F010, $F010, $10, $CAA0, $1008, $F010, $F010, $10, $C980
                                        ; DATA XREF: Boss_SunsetStingLoadGraphicsAlt+C   o
                dc.w $1008, $F010, $F010, $10, $CCE0, $1008, $F010, $F010, $10, $CBC0, $1008, $F010, $F010, $10, $CF20, $1008
                dc.w $F010, $F010, $10, $CE00, $1008, $F010, $F010, $10, $D160, $1008, $F010, $F010, $10, $D040, $1008, $F010
                dc.w $F010, $10, $FFFE


; Initializes 8 trail segments with graphics pointer and properties
Boss_SunsetStingInitTrail:                              ; CODE XREF: Boss_SunsetStingLoadGraphicsAlt+34   p  ; was: sub_42740
                lea     $BA0(a5),a4
                move.w  #7,d4
loc_42748:                              ; CODE XREF: Boss_SunsetStingInitTrail+2A   j
                move.w  #$4000,2(a4)
                move.l  #word_41972,8(a4)
                move.w  #$10,(a4)
                move.w  $E(a5),$E(a4)
                move.b  #$C8,$20(a4)
                lea     $60(a4),a4
                dbf     d4,loc_42748
                rts
; End of function Boss_SunsetStingInitTrail
; Updates trail segment positions following boss movement
Boss_SunsetStingUpdateTrail:                              ; CODE XREF: Boss_SunsetStingMainUpdate+AC   p  ; was: sub_42770
                lea     $BA0(a5),a4
                btst    #7,2(a4)
                beq.s   locret_427AE
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
loc_4279C:                              ; CODE XREF: Boss_SunsetStingUpdateTrail+3A   j
                move.w  d1,$10(a4)
                move.l  d2,$14(a4)
                sub.l   d3,d2
                lea     $60(a4),a4
                dbf     d4,loc_4279C
locret_427AE:                           ; CODE XREF: Boss_SunsetStingUpdateTrail+A   j
                rts
; End of function Boss_SunsetStingUpdateTrail
; Calculates angle from X/Y velocity components
Physics_CalculateAngleFromVelocity:
                pea     Physics_AddAngleOffset(pc)  ; was: sub_427B0
                lea     byte_4285C(pc),a0
                ext.l   d0
                beq.s   loc_427D6
                bpl.s   loc_427C2
                neg.l   d0
                addq.l  #4,a0
loc_427C2:                              ; CODE XREF: Physics_CalculateAngleFromVelocity+C   j
                ext.l   d1
                beq.s Physics_CalculateAngleToTarget
                bpl.s   loc_427CC
                neg.l   d1
                addq.l  #2,a0
loc_427CC:                              ; CODE XREF: Physics_CalculateAngleFromVelocity+16   j
                bra.s   loc_42818
; End of function Physics_CalculateAngleFromVelocity
; Computes angle offset from vertical position difference
Physics_GetVerticalAngleOffset:                              ; CODE XREF: Physics_CalculateAngleToTarget+1C   j  ; was: sub_427CE
                move.w  $14(a4),d1
                sub.w   $14(a5),d1
loc_427D6:                              ; CODE XREF: Physics_CalculateAngleFromVelocity+A   j
                move.w  d1,d0
                lsr.w   #8,d0
                andi.w  #$80,d0
                addi.w  #$40,d0 ; '@'
                rts
; End of function Physics_GetVerticalAngleOffset
; Calculates angle from current position to target using octant lookup
Physics_CalculateAngleToTarget:                              ; CODE XREF: Physics_CalculateAngleFromVelocity+14   j  ; was: sub_427E4
                                        ; Physics_CalculateAngleToTarget+2C   j
                move.b  (a0),d0
                andi.w  #$80,d0
                rts
; ---------------------------------------------------------------------------
loc_427EC:                              ; CODE XREF: Boss_SunsetStingCalculateAngleAndFlip+E   p
                                        ; Boss_SunsetStingMainDispatcher+18   p ...
                pea     Physics_AddAngleOffset(pc)
                lea     byte_4285C(pc),a0
                moveq   #0,d0
                moveq   #0,d1
                move.w  $10(a4),d0
                sub.w   $10(a5),d0
                beq.s Physics_GetVerticalAngleOffset
                bgt.s   loc_42808
                neg.w   d0
                addq.l  #4,a0
loc_42808:                              ; CODE XREF: Physics_CalculateAngleToTarget+1E   j
                move.w  $14(a4),d1
                sub.w   $14(a5),d1
                beq.s Physics_CalculateAngleToTarget
                bgt.s   loc_42818
                neg.w   d1
                addq.l  #2,a0
loc_42818:                              ; CODE XREF: Physics_CalculateAngleFromVelocity:loc_427CC   j
                                        ; Physics_CalculateAngleToTarget+2E   j
                cmp.w   d0,d1
                bcs.s   loc_42820
                exg     d0,d1
                addq.l  #1,a0
loc_42820:                              ; CODE XREF: Physics_CalculateAngleToTarget+36   j
                asl.l   #2,d0
                divu.w  d1,d0
                cmpi.w  #$23,d0 ; '#'
                bcs.s   loc_4282C
                moveq   #$23,d0 ; '#'
loc_4282C:                              ; CODE XREF: Physics_CalculateAngleToTarget+44   j
                move.b  loc_42838(pc,d0.w),d0
                move.b  (a0),d1
                add.b   d1,d1
                bcc.s   loc_42838
                neg.b   d0
loc_42838:                              ; CODE XREF: Physics_CalculateAngleToTarget+50   j
                                        ; DATA XREF: Physics_CalculateAngleToTarget:loc_4282C   r
                add.b   d1,d0
                rts
; End of function Physics_CalculateAngleToTarget
; ---------------------------------------------------------------------------
unused_9:	binclude	"data/other/unused_9.bin"
byte_4285C:     dc.b 0, $A0, $80, $60, $C0, $20, $40, $E0
                                        ; DATA XREF: Physics_CalculateAngleFromVelocity+4   o
                                        ; Physics_CalculateAngleToTarget+C   o


; Adds 90 degrees offset to angle value
Physics_AddAngleOffset:                              ; DATA XREF: Physics_CalculateAngleFromVelocity   o  ; was: sub_42864
                                        ; sub_427E4:loc_427EC   o
                addi.b  #$40,d0 ; '@'
                rts
; End of function Physics_AddAngleOffset
; Selects weighted random value from table
Gfx_WeightedRandomSelect:                              ; CODE XREF: JumpRandomFunc   p  ; was: sub_4286A
                jsr     (RandomNumber).l
loc_42870:                              ; CODE XREF: Gfx_WeightedRandomSelect+C   j
                sub.w   (a0)+,d0
                bls.s   loc_42878
                addq.w  #2,a0
                bra.s   loc_42870
; ---------------------------------------------------------------------------
loc_42878:                              ; CODE XREF: Gfx_WeightedRandomSelect+8   j
                move.w  (a0),d0
                rts
; End of function Gfx_WeightedRandomSelect
JumpRandomFunc:                         ; CODE XREF: Boss_SunsetStingIdleState+40   j
                                        ; Boss_SunsetStingCloseRangeAttack+4   j ...
                bsr.s Gfx_WeightedRandomSelect
                adda.w  (a0),a0
                jmp     (a0)
; End of function JumpRandomFunc


; Gets sine and cosine values
Math_GetSinCos:                              ; CODE XREF: Math_GetScaledSinCos   p  ; was: sub_42882
                lsr.w   #1,d0
                andi.w  #$1FE,d0
                lea     (word_1B494).l,a0
                move.w  (a0,d0.w),d1
                addi.w  #$80,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d0
                rts
; End of function Math_GetSinCos
; Gets scaled sine and cosine
Math_GetScaledSinCos:                              ; CODE XREF: Boss_SunsetStingSegmentInit:loc_433A8   p  ; was: sub_428A0
                                        ; Boss_SunsetStingSegmentInit+68   p ...
                bsr.s Math_GetSinCos
                muls.w  d2,d0
                muls.w  d2,d1
                rts
; End of function Math_GetScaledSinCos
; Clears X and Y velocity values
Physics_ClearVelocity:                              ; CODE XREF: Boss_SunsetStingBattleActive   p  ; was: sub_428A8
                                        ; sub_43048   p ...
                moveq   #0,d0
                move.l  d0,$18(a5)
                move.l  d0,$1C(a5)
                rts
; End of function Physics_ClearVelocity
; Updates boss core position
Boss_SunsetStingUpdateCore:                              ; CODE XREF: Boss_SunsetStingSegmentMove:loc_434C8   p  ; was: sub_428B4
                                        ; sub_43738:loc_43754   p ...
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                subi.w  #$780,d0
                bpl.s   loc_428C4
                neg.w   d0
loc_428C4:                              ; CODE XREF: Boss_SunsetStingUpdateCore+C   j
                cmpi.w  #$100,d0
                bcc.s   loc_428DC
                move.w  $14(a5),d0
                subi.w  #$F0,d0
                bpl.s   loc_428D6
                neg.w   d0
loc_428D6:                              ; CODE XREF: Boss_SunsetStingUpdateCore+1E   j
                cmpi.w  #$A0,d0
                bcs.s   locret_428DE
loc_428DC:                              ; CODE XREF: Boss_SunsetStingUpdateCore+14   j
                moveq   #0,d0
locret_428DE:                           ; CODE XREF: Boss_SunsetStingUpdateCore+26   j
                rts
; End of function Boss_SunsetStingUpdateCore
; Updates wave distortion screen effect
Boss_SunsetStingUpdateWaveScreen:                              ; CODE XREF: Boss_SunsetStingMain+A   p  ; was: sub_428E0
                cmpi.b  #$FF,(a4)
                bne.s   loc_428EE
                move.w  #$60,(word_FFE400).w ; '`'
                rts
; ---------------------------------------------------------------------------
loc_428EE:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+4   j
                move.l  $10(a3),d0
                btst    #0,(a4)
                beq.w   loc_42996
                lea     (dword_FF99A0).w,a0
                moveq   #$A,d7
loc_42900:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+28   j
                move.l  d0,-(a0)
                move.l  d0,-(a0)
                move.l  d0,-(a0)
                move.l  d0,-(a0)
                dbf     d7,loc_42900
                moveq   #$1B,d7
                move.l  $58(a5),d1
                move.l  d1,d2
                asr.l   #4,d2
loc_42916:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+42   j
                move.l  d0,-(a0)
                add.l   d1,d0
                add.l   d2,d1
                move.l  d0,-(a0)
                add.l   d1,d0
                add.l   d2,d1
                dbf     d7,loc_42916
                move.l  d0,$10(a5)
                lea     (word_FFE400).w,a0
                move.w  $14(a5),d0
                move.w  d0,d1
                subi.w  #$AC,d1
                move.w  d1,(dword_FFA90C).w
                subi.w  #$94,d0
                lsl.w   #2,d0
                adda.w  d0,a0
                move.w  $10(a5),d0
                moveq   #9,d7
loc_4294A:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+7C   j
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                lea     $10(a0),a0
                dbf     d7,loc_4294A
                lea     (word_FF9810).w,a1
                moveq   #$18,d7
loc_42966:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+B0   j
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                move.w  (a1),(a0)
                move.w  4(a1),4(a0)
                move.w  8(a1),8(a0)
                move.w  $C(a1),$C(a0)
                lea     $10(a0),a0
                lea     $10(a1),a1
                dbf     d7,loc_42966
                rts
; ---------------------------------------------------------------------------
loc_42996:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+16   j
                swap    d0
                move.w  d0,(word_FFE400).w
                lea     (word_FF9CE0).w,a0
                moveq   #0,d0
                move.w  #$158,d7
                sub.w   $14(a3),d7
                lsr.w   #1,d7
                move.w  #$1E0,d2
loc_429B0:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+D4   j
                move.w  d2,-(a0)
                addq.w  #2,d2
                dbf     d7,loc_429B0
                move.w  $14(a3),d0
                subi.w  #$71,d0 ; 'q'
                move.l  d0,d1
                subi.w  #$AC,d0
                neg.w   d0
                move.w  $14(a5),d2
                sub.w   d2,d1
                beq.s   loc_42A04
                move.w  d1,d7
                addi.w  #$48,d7 ; 'H'
                asr.w   #1,d7
                subq.w  #1,d7
                tst.w   d1
                bpl.s   loc_429E2
                neg.w   d1
                moveq   #0,d2
loc_429E2:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+FC   j
                asl.w   #8,d1
                divs.w  d7,d1
                ext.l   d1
                tst.w   d2
                bne.s   loc_429EE
                neg.l   d1
loc_429EE:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+10A   j
                asl.l   #8,d1
loc_429F0:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+120   j
                swap    d0
                add.l   d1,d0
                swap    d0
                move.w  d0,-(a0)
                cmpa.l  #$FFFF9C00,a0
                ble.s   locret_42A0E
                dbf     d7,loc_429F0
loc_42A04:                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+EE   j
                                        ; Boss_SunsetStingUpdateWaveScreen+12C   j
                move.w  d0,-(a0)
                cmpa.l  #$FFFF9C00,a0
                bne.s   loc_42A04
locret_42A0E:                           ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+11E   j
                rts
; End of function Boss_SunsetStingUpdateWaveScreen
; Main Sunset Sting boss handler
Boss_SunsetStingMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_42A10
                lea     (word_FF9800).w,a4
                lea     (word_FFC680).w,a3
                bsr.s Boss_SunsetStingDispatcher
                bsr.w Boss_SunsetStingUpdateWaveScreen
                move.w  4(a5),d0
                andi.w  #$FF,d0
                cmpi.w  #$12,d0
                bcc.s   locret_42A8A
                jsr (Gfx_InitPaletteFade).l
                tst.w   (word_FF8234).w
                bne.s   loc_42A54
                move.w  4(a5),d0
                andi.w  #$7FFF,d0
                cmpi.w  #$E,d0
                bcc.s   loc_42A54
                addi.b  #$20,$54(a5) ; ' '
                bne.s   loc_42A54
                move.w  #$E,4(a5)
loc_42A54:                              ; CODE XREF: Boss_SunsetStingMain+26   j
                                        ; Boss_SunsetStingMain+34   j ...
                tst.w   (word_FF8200).w
                bne.s   loc_42A6A
                bset    #0,(byte_FFA272).w
                bset    #7,(a4)
                move.w  #$12,4(a5)
loc_42A6A:                              ; CODE XREF: Boss_SunsetStingMain+48   j
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   locret_42A8A
                move.b  $48(a5),d0
                andi.w  #$F,d0
                movea.l off_42AB6(pc,d0.w),a0
                jsr (Gfx_LoadCompressedTiles).l
                addq.b  #4,$48(a5)
locret_42A8A:                           ; CODE XREF: Boss_SunsetStingMain+1A   j
                                        ; Boss_SunsetStingMain+62   j ...
                rts
; End of function Boss_SunsetStingMain
; State dispatcher for boss
Boss_SunsetStingDispatcher:                              ; CODE XREF: Boss_SunsetStingMain+8   p  ; was: sub_42A8C
                                        ; Boss_SunsetStingBattleActive+8C   j
                move.w  4(a5),d0
                andi.w  #$FF,d0
                lea     off_42A9C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingDispatcher
; ---------------------------------------------------------------------------
off_42A9C:      dc.w Boss_SunsetStingInit-*        ; DATA XREF: Boss_SunsetStingDispatcher+8   o
                dc.w Boss_SunsetStingIntro-*
                dc.w Boss_SunsetStingBattleActive-*
                dc.w Boss_ViblackDefeatStart-*
                dc.w Boss_ViblackBattleMovement-*
                dc.w Boss_SunsetStingSegmentAttack-*
                dc.w Boss_SunsetStingSegmentAttackAlt-*
                dc.w Boss_SunsetStingReturnToCenter-*
                dc.w Boss_SunsetStingIntroOscillate-*
                dc.w Boss_SunsetStingDefeatPhase-*
                dc.w Boss_SunsetStingDefeatWobble-*
                dc.w Boss_SunsetStingFinalDefeat-*
                dc.w Boss_SunsetStingDefeatFadeOut-*
off_42AB6:      dc.l word_42AC6         ; DATA XREF: Boss_SunsetStingMain+6C   r
                dc.l word_42ACE
                dc.l word_42AD6
                dc.l word_42ACE
word_42AC6:     dc.w $625C, $2000, 0, $6700
                                        ; DATA XREF: ROM:off_42AB6   o
word_42ACE:     dc.w $625C, $2000, 0, $6800
                                        ; DATA XREF: ROM:00042ABA   o
                                        ; ROM:00042AC2   o
word_42AD6:     dc.w $625C, $2000, 0, $6B00
                                        ; DATA XREF: ROM:00042ABE   o


; Initializes Sunset Sting boss with 16 segments
Boss_SunsetStingInit:                              ; DATA XREF: ROM:off_42A9C   o  ; was: sub_42ADE
                tst.w   (word_FFF720).w
                bmi.w   locret_432CE
                move.w  #$1EC,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                move.b  #1,(byte_FF830E).w
                move.w  #$1E0,$10(a5)
                move.w  #$D8,$14(a5)
                move.w  #$8D00,2(a5)
                move.b  #$50,$21(a5) ; 'P'
                move.b  #$84,$23(a5)
                move.w  #$14,$24(a5)
                move.w  #$95,$26(a5)
                move.l  #$F010F010,$28(a5)
                move.l  #$F20EF20E,$2C(a5)
                move.b  #$40,(byte_FFA420).w ; '@'
                lea     $60(a5),a0
                move.w  #$20C,(a0)
                move.b  #$40,$21(a0) ; '@'
                move.w  #$95,$26(a0)
                move.w  #$6300,$E(a0)
                moveq   #0,d0
                lea     word_42BCC(pc),a1
                moveq   #0,d2
                lea     $60(a0),a0
                bra.s   loc_42B66
; ---------------------------------------------------------------------------
loc_42B60:                              ; CODE XREF: Boss_SunsetStingInit+C0   j
                moveq   #$40,d0 ; '@'
                lea     word_42BD8(pc),a1
loc_42B66:                              ; CODE XREF: Boss_SunsetStingInit+80   j
                moveq   #7,d7
loc_42B68:                              ; CODE XREF: Boss_SunsetStingInit+B6   j
                move.w  #$6300,$E(a0)
                move.w  (a1),(a0)
                move.w  2(a1),$26(a0)
                move.l  4(a1),$28(a0)
                move.l  8(a1),$2C(a0)
                move.w  d0,6(a0)
                move.w  d2,$46(a0)
                addi.w  #$80,d0
                addq.w  #1,d2
                lea     $60(a0),a0
                dbf     d7,loc_42B68
                cmpa.l  #word_42BD8,a1
                bne.s   loc_42B60
                move.w  #8,4(a4)
                move.w  #2,(word_FF8640).w
                lea     word_42BBA(pc),a0
                jsr (Gfx_LoadCompressedTiles).l
                bra.w Boss_SunsetStingNextState
; End of function Boss_SunsetStingInit
; ---------------------------------------------------------------------------
word_42BBA:     dc.w $6058, $2000, $105, $6C6F, $7073, $6566, $696A, $6D6E, $7172
                                        ; DATA XREF: Boss_SunsetStingInit+CE   o
word_42BCC:     dc.w $1F0, $52, $F40C, $F40C, $FC04, $FC04
                                        ; DATA XREF: Boss_SunsetStingInit+76   o
word_42BD8:     dc.w $1F4, $25, 0, 0, $FE02, $F808
                                        ; DATA XREF: Boss_SunsetStingInit+84   o
                                        ; Boss_SunsetStingInit+BA   o


; Boss intro sequence
Boss_SunsetStingIntro:                              ; DATA XREF: ROM:00042A9E   o  ; was: sub_42BE4
                bset    #7,4(a5)
                bne.s   loc_42C34
                move.w  #$780,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  d0,$10(a3)
                move.w  #$10,$14(a5)
                move.w  #$90,$14(a3)
                clr.b   (byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.b  #0,(word_FFF7E6+1).w
                move.w  #$34,(word_FFF74A).w ; '4'
                clr.w   (word_FFF74E).w
                bclr    #0,(a4)
                move.l  #$FFFFF000,$58(a5)
                move.w  #1,$1C(a5)
loc_42C34:                              ; CODE XREF: Boss_SunsetStingIntro+6   j
                btst    #6,4(a5)
                bne.s Boss_SunsetStingIntroMovementAlt
                cmpi.w  #$140,$14(a3)
                beq.s   loc_42C62
                addq.w  #2,$14(a3)
                cmpi.w  #$140,$14(a3)
                bne.s   loc_42C62
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #2,$1C(a5)
loc_42C62:                              ; CODE XREF: Boss_SunsetStingIntro+5E   j
                                        ; Boss_SunsetStingIntro+6A   j
                cmpi.w  #$C0,$14(a5)
                bcs.w   locret_432CE
                bset    #6,4(a5)
                moveq   #3,d0
; End of function Boss_SunsetStingIntro
; Checks victory condition
Boss_SunsetStingVictoryCheck:
                jsr (UI_CheckVictoryCondition).l  ; was: sub_42C74
                move.b  #$8A,d0
                jsr (Input_CheckButtonMode).l
                rts
; End of function Boss_SunsetStingVictoryCheck
; Handles vertical oscillation during boss intro phase 2
Boss_SunsetStingIntroMovementAlt:                              ; CODE XREF: Boss_SunsetStingIntro+56   j  ; was: sub_42C86
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                moveq   #1,d7
                swap    d7
                tst.w   $58(a5)
                bpl.s   loc_42C9A
                neg.l   d7
loc_42C9A:                              ; CODE XREF: Boss_SunsetStingIntroMovementAlt+10   j
                cmp.l   $1C(a5),d7
                bne.s   loc_42CA4
                neg.l   $58(a5)
loc_42CA4:                              ; CODE XREF: Boss_SunsetStingIntroMovementAlt+18   j
                tst.w   (word_FF80C2).w
                bne.w   locret_432CE
                clr.b   (byte_FF80EC).w
                move.w  #$620,(word_FFA970).w
                move.w  #$6A0,(word_FFA974).w
                bra.w Boss_SunsetStingNextState
; End of function Boss_SunsetStingIntroMovementAlt
; Active battle state
Boss_SunsetStingBattleActive:                              ; DATA XREF: ROM:00042AA0   o  ; was: sub_42CC0
                bsr.w Physics_ClearVelocity
                btst    #0,(a4)
                bne.s   loc_42CE8
                clr.l   $4A(a5)
                moveq   #1,d7
                move.w  $14(a3),d0
                subi.w  #$71,d0 ; 'q'
                cmp.w   $14(a5),d0
                beq.s   loc_42D2C
                bpl.s   loc_42CE2
                neg.w   d7
loc_42CE2:                              ; CODE XREF: Boss_SunsetStingBattleActive+1E   j
                add.w   d7,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_42CE8:                              ; CODE XREF: Boss_SunsetStingBattleActive+8   j
                bset    #7,4(a5)
                bne.s   loc_42D12
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_42CFC
                neg.w   d0
loc_42CFC:                              ; CODE XREF: Boss_SunsetStingBattleActive+38   j
                cmpi.w  #$80,d0
                bcc.s   loc_42D2C
                move.l  $58(a5),d0
                asr.l   #5,d0
                move.w  d0,$4A(a5)
                move.w  #$20,$4C(a5) ; ' '
loc_42D12:                              ; CODE XREF: Boss_SunsetStingBattleActive+2E   j
                move.w  $4A(a5),d0
                ext.l   d0
                sub.l   d0,$58(a5)
                subq.w  #1,$4C(a5)
                bne.w   locret_42A8A
                move.w  #6,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_42D2C:                              ; CODE XREF: Boss_SunsetStingBattleActive+1C   j
                                        ; Boss_SunsetStingBattleActive+40   j
                tst.w   $4C(a5)
                beq.s   loc_42D5C
                move.w  $4C(a5),d0
                bpl.s   loc_42D3A
                neg.w   d0
loc_42D3A:                              ; CODE XREF: Boss_SunsetStingBattleActive+76   j
                cmpi.w  #$20,d0 ; ' '
                bne.s   loc_42D50
                move.w  #$A,4(a5)
                move.w  #$200,$56(a5)
                bra.w Boss_SunsetStingDispatcher
; ---------------------------------------------------------------------------
loc_42D50:                              ; CODE XREF: Boss_SunsetStingBattleActive+7E   j
                clr.l   $4A(a5)
                move.w  #6,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_42D5C:                              ; CODE XREF: Boss_SunsetStingBattleActive+70   j
                move.w  #$FFFF,2(a4)
                subi.w  #$50,(word_FF8234).w ; 'P'
                moveq   #$A,d7
                jsr     (RandomNumber).l
                andi.w  #7,d0
                bne.s   loc_42D78
                addq.w  #2,d7
loc_42D78:                              ; CODE XREF: Boss_SunsetStingBattleActive+B4   j
                move.w  d7,4(a5)
                move.w  #$200,$56(a5)
                clr.l   $4A(a5)
                rts
; End of function Boss_SunsetStingBattleActive
; Initiates defeat sequence with screen shake
Boss_ViblackDefeatStart:                              ; DATA XREF: ROM:00042AA2   o  ; was: sub_42D88
                bset    #7,4(a5)
                bne.s   loc_42DB4
                clr.b   (byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.b  #0,(word_FFF7E6+1).w
                move.w  #$34,(word_FFF74A).w ; '4'
                clr.w   (word_FFF74E).w
                bclr    #0,(a4)
                move.w  #$14,$4A(a5)
loc_42DB4:                              ; CODE XREF: Boss_ViblackDefeatStart+6   j
                addq.w  #2,$14(a5)
                subq.w  #1,$4A(a5)
                bne.w   locret_432CE
                move.l  #$FFFBC000,$1C(a5)
                move.l  #$1000,$4A(a5)
                addi.w  #$30,(word_FF8234).w ; '0'
                bra.w Boss_SunsetStingNextState
; End of function Boss_ViblackDefeatStart
; Controls Viblack vertical movement relative to player
Boss_ViblackBattleMovement:                              ; DATA XREF: ROM:00042AA4   o  ; was: sub_42DDA
                btst    #6,4(a5)
                bne.w   loc_42E86
                tst.l   $4A(a3)
                beq.s   loc_42E36
                move.l  $4A(a3),d0
                add.l   d0,$1C(a3)
                bmi.s   loc_42DFA
                move.w  #$102,$26(a3)
loc_42DFA:                              ; CODE XREF: Boss_ViblackBattleMovement+18   j
                move.w  $10(a3),$10(a5)
                cmpi.w  #$140,$14(a3)
                bcs.w   loc_42E86
                move.w  #$95,$26(a3)
                move.w  #$140,$14(a3)
                move.w  #8,(word_FFA014).w
                clr.l   $18(a3)
                clr.l   $1C(a3)
                clr.l   $4A(a3)
                subi.w  #$50,(word_FF8234).w ; 'P'
                bset    #6,4(a5)
                bra.s   loc_42E86
; ---------------------------------------------------------------------------
loc_42E36:                              ; CODE XREF: Boss_ViblackBattleMovement+E   j
                move.w  $14(a3),d0
                sub.w   $14(a5),d0
                cmpi.w  #$A0,d0
                bcs.s   loc_42E86
                move.l  #$FFFA0000,$1C(a3)
                move.l  #$2000,$4A(a3)
                move.w  $10(a5),d0
                move.w  d0,d1
                add.w   (dword_FFA900).w,d0
                move.l  #$FFFF0000,d7
                subi.w  #$780,d0
                bpl.s   loc_42E6E
                neg.w   d0
                neg.l   d7
loc_42E6E:                              ; CODE XREF: Boss_ViblackBattleMovement+8E   j
                subi.w  #$80,d0
                bcc.s   loc_42E82
                move.l  #$10000,d7
                cmp.w   (dword_FFA410).w,d1
                bpl.s   loc_42E82
                neg.l   d7
loc_42E82:                              ; CODE XREF: Boss_ViblackBattleMovement+98   j
                                        ; Boss_ViblackBattleMovement+A4   j
                move.l  d7,$18(a3)
loc_42E86:                              ; CODE XREF: Boss_ViblackBattleMovement+6   j
                                        ; Boss_ViblackBattleMovement+2C   j ...
                btst    #7,4(a5)
                bne.s   loc_42EAC
                move.l  $4A(a5),d0
                add.l   d0,$1C(a5)
                cmpi.l  #$44000,$1C(a5)
                bne.w   locret_432CE
                clr.l   $1C(a5)
                bset    #7,4(a5)
loc_42EAC:                              ; CODE XREF: Boss_ViblackBattleMovement+B2   j
                move.w  $14(a3),d0
                subi.w  #$71,d0 ; 'q'
                cmp.w   $14(a5),d0
                beq.s   loc_42EC0
                subq.w  #1,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_42EC0:                              ; CODE XREF: Boss_ViblackBattleMovement+DE   j
                move.w  #4,4(a5)
                rts
; End of function Boss_ViblackBattleMovement
; Segment attack state
Boss_SunsetStingSegmentAttack:                              ; DATA XREF: ROM:00042AA6   o  ; was: sub_42EC8
                bset    #7,4(a5)
                bne.s   loc_42F0C
                move.b  #4,(byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                andi.b  #$EF,(word_FFF7D0+1).w
                move.b  #3,(word_FFF7E6+1).w
                bset    #0,(a4)
                jsr     (RandomNumber).l
                andi.w  #$3F,d0 ; '?'
                move.b  d0,$49(a5)
                tst.w   $4A(a5)
                bne.s   loc_42F0C
                move.w  #$FD00,$4A(a5)
                move.w  #$20,$4C(a5) ; ' '
loc_42F0C:                              ; CODE XREF: Boss_SunsetStingSegmentAttack+6   j
                                        ; Boss_SunsetStingSegmentAttack+36   j
                subq.w  #1,$56(a5)
                bne.s   loc_42F18
                move.w  #4,4(a5)
loc_42F18:                              ; CODE XREF: Boss_SunsetStingSegmentAttack+48   j
                bsr.s Boss_SunsetStingSegmentWait
                move.w  #$300,d7
                bsr.s Boss_SunsetStingSegmentRotate
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0 ; '?'
                bne.s   loc_42F36
                cmpi.w  #8,4(a4)
                beq.s   loc_42F36
                addq.w  #1,4(a4)
loc_42F36:                              ; CODE XREF: Boss_SunsetStingSegmentAttack+60   j
                                        ; Boss_SunsetStingSegmentAttack+68   j
                clr.w   2(a4)
                subq.b  #1,$49(a5)
                bne.w   locret_432CE
                jsr     (RandomNumber).l
                andi.b  #$3F,d0 ; '?'
                tst.w   (word_FFFF0E).w
                beq.s   loc_42F54
                lsr.b   #1,d0
loc_42F54:                              ; CODE XREF: Boss_SunsetStingSegmentAttack+88   j
                move.b  d0,$49(a5)
                swap    d0
                andi.w  #$F,d0
                bset    #3,d0
                moveq   #0,d1
                bset    d0,d1
                move.w  d1,2(a4)
                rts
; End of function Boss_SunsetStingSegmentAttack
; Segment wait state
Boss_SunsetStingSegmentWait:                              ; CODE XREF: Boss_SunsetStingSegmentAttack:loc_42F18   p  ; was: sub_42F6C
                                        ; sub_42FA6:loc_42FF6   p
                moveq   #1,d7
                ror.w   #3,d7
                move.w  $10(a5),d0
                cmp.w   (dword_FFA410).w,d0
                bpl.s   loc_42F7C
                neg.l   d7
loc_42F7C:                              ; CODE XREF: Boss_SunsetStingSegmentWait+C   j
                sub.l   d7,$10(a3)
                rts
; End of function Boss_SunsetStingSegmentWait
; Segment rotation during attack
Boss_SunsetStingSegmentRotate:                              ; CODE XREF: Boss_SunsetStingSegmentAttack+56   p  ; was: sub_42F82
                                        ; Boss_SunsetStingSegmentAttackAlt+58   p
                move.w  $4C(a5),d0
                add.w   d0,$4A(a5)
                move.w  $4A(a5),d0
                ext.l   d0
                add.l   d0,$58(a5)
                tst.w   $4C(a5)
                bpl.s   loc_42F9C
                neg.w   d0
loc_42F9C:                              ; CODE XREF: Boss_SunsetStingSegmentRotate+16   j
                cmp.w   d7,d0
                bne.s   locret_42FA4
                neg.w   $4C(a5)
locret_42FA4:                           ; CODE XREF: Boss_SunsetStingSegmentRotate+1C   j
                rts
; End of function Boss_SunsetStingSegmentRotate
; Manages segment rotation attack with random timing
Boss_SunsetStingSegmentAttackAlt:                              ; DATA XREF: ROM:00042AA8   o  ; was: sub_42FA6
                bset    #7,4(a5)
                bne.s   loc_42FEA
                move.b  #4,(byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                andi.b  #$EF,(word_FFF7D0+1).w
                move.b  #3,(word_FFF7E6+1).w
                bset    #0,(a4)
                jsr     (RandomNumber).l
                andi.w  #$3F,d0 ; '?'
                move.b  d0,$49(a5)
                tst.w   $4A(a5)
                bne.s   loc_42FEA
                move.w  #$F000,$4A(a5)
                move.w  #$200,$4C(a5)
loc_42FEA:                              ; CODE XREF: Boss_SunsetStingSegmentAttackAlt+6   j
                                        ; Boss_SunsetStingSegmentAttackAlt+36   j
                subq.w  #1,$56(a5)
                bne.s   loc_42FF6
                move.w  #4,4(a5)
loc_42FF6:                              ; CODE XREF: Boss_SunsetStingSegmentAttackAlt+48   j
                bsr.w Boss_SunsetStingSegmentWait
                move.w  #$1000,d7
                bsr.s Boss_SunsetStingSegmentRotate
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_43016
                cmpi.w  #$FFF8,4(a4)
                beq.s   loc_43016
                subq.w  #1,4(a4)
loc_43016:                              ; CODE XREF: Boss_SunsetStingSegmentAttackAlt+62   j
                                        ; Boss_SunsetStingSegmentAttackAlt+6A   j
                clr.w   2(a4)
                subq.b  #1,$49(a5)
                bne.w   locret_432CE
                jsr     (RandomNumber).l
                andi.b  #$7F,d0
                tst.w   (word_FFFF0E).w
                beq.s   loc_43034
                lsr.b   #1,d0
loc_43034:                              ; CODE XREF: Boss_SunsetStingSegmentAttackAlt+8A   j
                move.b  d0,$49(a5)
                swap    d0
                andi.w  #7,d0
                moveq   #0,d1
                bset    d0,d1
                move.w  d1,2(a4)
                rts
; End of function Boss_SunsetStingSegmentAttackAlt
; Returns boss to center position and decelerates rotation
Boss_SunsetStingReturnToCenter:                              ; DATA XREF: ROM:00042AAA   o  ; was: sub_43048
                bsr.w Physics_ClearVelocity
                btst    #0,(a4)
                bne.s   loc_43072
                clr.l   $4A(a5)
                moveq   #1,d7
                move.w  $14(a3),d0
                subi.w  #$71,d0 ; 'q'
                cmp.w   $14(a5),d0
                beq.w   loc_432CA
                bpl.s   loc_4306C
                neg.w   d7
loc_4306C:                              ; CODE XREF: Boss_SunsetStingReturnToCenter+20   j
                add.w   d7,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_43072:                              ; CODE XREF: Boss_SunsetStingReturnToCenter+8   j
                bset    #7,4(a5)
                bne.s   loc_4308A
                move.l  $58(a5),d0
                asr.l   #5,d0
                move.w  d0,$4A(a5)
                move.w  #$20,$4C(a5) ; ' '
loc_4308A:                              ; CODE XREF: Boss_SunsetStingReturnToCenter+30   j
                move.w  $4A(a5),d0
                ext.l   d0
                sub.l   d0,$58(a5)
                subq.w  #1,$4C(a5)
                beq.w Boss_SunsetStingNextState
                rts
; End of function Boss_SunsetStingReturnToCenter
; Oscillates boss vertically during intro
Boss_SunsetStingIntroOscillate:                              ; DATA XREF: ROM:00042AAC   o  ; was: sub_4309E
                bset    #7,4(a5)
                bne.s   loc_430D8
                clr.b   (byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.b  #0,(word_FFF7E6+1).w
                move.w  #$34,(word_FFF74A).w ; '4'
                clr.w   (word_FFF74E).w
                bclr    #0,(a4)
                move.w  #$14,$4A(a5)
                move.l  #$FFFFF000,$58(a5)
                move.w  #1,$1C(a5)
loc_430D8:                              ; CODE XREF: Boss_SunsetStingIntroOscillate+6   j
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                moveq   #1,d7
                swap    d7
                tst.w   $58(a5)
                bpl.s   loc_430EC
                neg.l   d7
loc_430EC:                              ; CODE XREF: Boss_SunsetStingIntroOscillate+4A   j
                cmp.l   $1C(a5),d7
                bne.s   loc_430F6
                neg.l   $58(a5)
loc_430F6:                              ; CODE XREF: Boss_SunsetStingIntroOscillate+52   j
                addq.w  #2,(word_FF8234).w
                btst    #0,(byte_FF8260).w
                beq.w   locret_432CE
                move.w  #4,4(a5)
                rts
; End of function Boss_SunsetStingIntroOscillate
; Defeat phase with screen clear
Boss_SunsetStingDefeatPhase:                              ; DATA XREF: ROM:00042AAE   o  ; was: sub_4310C
                move.b  #1,(byte_FF830E).w
                clr.b   $21(a5)
                clr.b   $23(a5)
                jsr (Gfx_UpdatePaletteFade).l
                bset    #7,4(a5)
                bne.s   loc_4315C
                clr.b   (byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.b  #0,(word_FFF7E6+1).w
                move.w  #$34,(word_FFF74A).w ; '4'
                clr.w   (word_FFF74E).w
                bclr    #0,(a4)
                move.w  $10(a3),$10(a5)
                bsr.w Physics_ClearVelocity
                move.l  d0,$18(a3)
                move.l  d0,$1C(a3)
                move.l  d0,$4A(a3)
loc_4315C:                              ; CODE XREF: Boss_SunsetStingDefeatPhase+1A   j
                moveq   #0,d1
                move.w  $14(a3),d0
                cmpi.w  #$140,d0
                bcc.s   loc_4316E
                addq.w  #2,$14(a3)
                addq.w  #1,d1
loc_4316E:                              ; CODE XREF: Boss_SunsetStingDefeatPhase+5A   j
                moveq   #1,d7
                subi.w  #$71,d0 ; 'q'
                cmp.w   $14(a5),d0
                beq.s   loc_43184
                bpl.s   loc_4317E
                neg.w   d7
loc_4317E:                              ; CODE XREF: Boss_SunsetStingDefeatPhase+6E   j
                add.w   d7,$14(a5)
                addq.w  #1,d1
loc_43184:                              ; CODE XREF: Boss_SunsetStingDefeatPhase+6C   j
                tst.w   d1
                bne.w   locret_432CE
                move.w  #$100,$4A(a5)
                clr.l   $4C(a5)
                move.w  #$FFF8,$1C(a5)
                addi.w  #$20,$14(a5) ; ' '
                bra.w Boss_SunsetStingNextState
; End of function Boss_SunsetStingDefeatPhase
; Wobble effect during defeat
Boss_SunsetStingDefeatWobble:                              ; DATA XREF: ROM:00042AB0   o  ; was: sub_431A4
                addi.b  #$40,$4C(a5) ; '@'
                bne.s   loc_431B0
                neg.l   $1C(a5)
loc_431B0:                              ; CODE XREF: Boss_SunsetStingDefeatWobble+6   j
                bsr.s Boss_SunsetStingSpawnDebrisRain
                jsr (Gfx_UpdatePaletteFade).l
                subq.w  #1,$4A(a5)
                beq.w Boss_SunsetStingNextState
                rts
; End of function Boss_SunsetStingDefeatWobble
; Spawns debris rain projectiles
Boss_SunsetStingSpawnDebrisRain:                              ; CODE XREF: Boss_SunsetStingDefeatWobble:loc_431B0   p  ; was: sub_431C2
                                        ; sub_43226:loc_43232   p
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_432CE
                jsr (Projectile_InitType88).l
                move.w  (dword_FFFF08).w,d0
                move.w  (dword_FFFF08+2).w,d1
                andi.w  #$3F,d0 ; '?'
                andi.w  #$3F,d1 ; '?'
                subi.w  #$20,d0 ; ' '
                subi.w  #$20,d1 ; ' '
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  #off_E95DC,8(a0)
                move.b  #$30,$20(a0) ; '0'
                bset    #7,$E(a0)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_432CE
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
                rts
; End of function Boss_SunsetStingSpawnDebrisRain
; Final defeat sequence
Boss_SunsetStingFinalDefeat:                              ; DATA XREF: ROM:00042AB2   o  ; was: sub_43226
                addi.b  #$40,$4C(a5) ; '@'
                bne.s   loc_43232
                neg.l   $1C(a5)
loc_43232:                              ; CODE XREF: Boss_SunsetStingFinalDefeat+6   j
                bsr.s Boss_SunsetStingSpawnDebrisRain
                bsr.s Gfx_ApplyDefeatFade
                cmpi.w  #$1C,6(a5)
                bcs.s   loc_4328E
                beq.s   loc_43278
                addq.b  #8,$4A(a5)
                bne.w   locret_432CE
                move.w  #$1EC,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                jsr (Effect_InitPlayerSpawn).l
                clr.w   (word_FF8640).w
                clr.l   $1C(a5)
                addi.w  #$38,$14(a0) ; '8'
                andi.w  #$FFFE,6(a5)
                move.w  #$FF00,$4A(a5)
                bra.w Boss_SunsetStingNextState
; ---------------------------------------------------------------------------
loc_43278:                              ; CODE XREF: Boss_SunsetStingFinalDefeat+18   j
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #4,(byte_FFA95A).w
                clr.w   2(a5)
                move.b  #$FF,(a4)
loc_4328E:                              ; CODE XREF: Boss_SunsetStingFinalDefeat+16   j
                addq.w  #1,6(a5)
                rts
; End of function Boss_SunsetStingFinalDefeat
; Fade out after defeat
Boss_SunsetStingDefeatFadeOut:                              ; DATA XREF: ROM:00042AB4   o  ; was: sub_43294
                tst.w   6(a5)
                beq.s   loc_4329E
                subq.w  #2,6(a5)
loc_4329E:                              ; CODE XREF: Boss_SunsetStingDefeatFadeOut+4   j
                bsr.s Gfx_ApplyDefeatFade
                addq.w  #2,$4A(a5)
                bne.w   locret_432CE
                bset    #4,2(a5)
                rts
; End of function Boss_SunsetStingDefeatFadeOut
; Applies defeat palette fade
Gfx_ApplyDefeatFade:                              ; CODE XREF: Boss_SunsetStingFinalDefeat+E   p  ; was: sub_432B0
                                        ; sub_43294:loc_4329E   p
                move.w  6(a5),d0
                asr.w   #1,d0
                lea     (word_FFE300).w,a0
                moveq   #$3F,d5 ; '?'
                move.w  #$E000,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Gfx_ApplyDefeatFade
; Advances to next state
Boss_SunsetStingNextState:                              ; CODE XREF: Boss_SunsetStingInit+D8   j  ; was: sub_432C6
                                        ; Boss_SunsetStingIntroMovementAlt+36   j ...
                clr.b   4(a5)
loc_432CA:                              ; CODE XREF: Boss_SunsetStingReturnToCenter+1C   j
                                        ; Boss_SunsetStingDefeatEnd+1C   j
                addq.w  #2,4(a5)
locret_432CE:                           ; CODE XREF: Boss_SunsetStingInit+4   j
                                        ; Boss_SunsetStingIntro+84   j ...
                rts
; End of function Boss_SunsetStingNextState
; Updates segment sprite based on angle
Boss_SunsetStingUpdateSegmentSprite:                              ; CODE XREF: Boss_SunsetStingSegmentInit+42   p  ; was: sub_432D0
                                        ; Boss_SunsetStingSegmentMove+56   p ...
                addi.w  #$20,d0 ; ' '
                lsr.w   #4,d0
                andi.w  #$3C,d0 ; '<'
                bset    #3,$E(a5)
                bclr    #4,$E(a5)
                bclr    #5,d0
                beq.s   loc_432F2
                eori.b  #$18,$E(a5)
loc_432F2:                              ; CODE XREF: Boss_SunsetStingUpdateSegmentSprite+1A   j
                move.l  (a0,d0.w),8(a5)
                rts
; End of function Boss_SunsetStingUpdateSegmentSprite
; ---------------------------------------------------------------------------
off_432FA:      dc.l word_EBED0         ; DATA XREF: Boss_SunsetStingSegmentInit+3E   o
                                        ; Boss_SunsetStingSegmentMove+52   o
                dc.l word_EBEE2
                dc.l word_EBEEE
                dc.l word_EBEF4
                dc.l word_EBEA6
                dc.l word_EBEB2
                dc.l word_EBEBE
                dc.l word_EBEC4
off_4331A:      dc.l word_EBF00         ; DATA XREF: Boss_SunsetStingSegmentFall+3E   o
                                        ; Boss_SunsetStingDefeatStart+14   o ...
                dc.l word_EBF06
                dc.l word_EBF0C
                dc.l word_EBF18
                dc.l word_EBF1E
                dc.l word_EBF24
                dc.l word_EBF2A
                dc.l word_EBF36


; Main segment handler
Boss_SunsetStingSegmentMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4333A
                lea     (Entity_ObjectPool).w,a3
                lea     (word_FF9800).w,a4
                bsr.s Boss_SunsetStingSegmentDispatcher
                cmpi.w  #$C,4(a5)
                beq.w   locret_432CE
                btst    #7,(a4)
                beq.s   loc_4335E
                clr.b   $21(a5)
                move.w  #$C,4(a5)
loc_4335E:                              ; CODE XREF: Boss_SunsetStingSegmentMain+18   j
                move.w  4(a4),d0
                add.w   d0,6(a5)
                rts
; End of function Boss_SunsetStingSegmentMain
; Segment state dispatcher
Boss_SunsetStingSegmentDispatcher:                              ; CODE XREF: Boss_SunsetStingSegmentMain+8   p  ; was: sub_43368
                movea.w 4(a5),a0
                lea     off_43374(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingSegmentDispatcher
; ---------------------------------------------------------------------------
off_43374:      dc.w Boss_SunsetStingSegmentInit-*        ; DATA XREF: Boss_SunsetStingSegmentDispatcher+4   o
                dc.w Boss_SunsetStingSegmentInit_AdvanceState-*
                dc.w Boss_SunsetStingSegmentInit_UpdateLoop-*
                dc.w Boss_SunsetStingSegmentMove-*
                dc.w Boss_SunsetStingSegmentFallInit-*
                dc.w Boss_SunsetStingSegmentWobble-*
                dc.w Boss_SunsetStingSegmentConvertToProjectile-*


; Initializes segment
Boss_SunsetStingSegmentInit:                              ; DATA XREF: ROM:off_43374   o  ; was: sub_43382
                move.w  #$CD00,2(a5)
                move.b  #$40,$20(a5) ; '@'
                addq.w  #2,4(a5)
; Advance to next state for segment initialization
Boss_SunsetStingSegmentInit_AdvanceState:                              ; DATA XREF: ROM:00043376   o  ; was: loc_43392
                addq.w  #2,4(a5)
; Calculate segment position and check for damage
Boss_SunsetStingSegmentInit_UpdateLoop:                              ; DATA XREF: ROM:00043378   o  ; was: loc_43396
                move.w  6(a5),d0
                move.w  $44(a5),d2
                cmpi.w  #$80,d2
                beq.s   loc_433A8
                addq.w  #2,$44(a5)
loc_433A8:                              ; CODE XREF: Boss_SunsetStingSegmentInit+20   j
                bsr.w Math_GetScaledSinCos
                add.l   $10(a3),d0
                add.l   $14(a3),d1
                move.l  d0,$10(a5)
                move.l  d1,$14(a5)
                move.w  6(a5),d0
                lea     off_432FA(pc),a0
                bsr.w Boss_SunsetStingUpdateSegmentSprite
                move.w  $46(a5),d0
                move.w  2(a4),d1
                btst    d0,d1
                beq.w   locret_432CE
                cmpi.w  #$FFFF,2(a4)
                beq.s   loc_433E4
                subi.w  #$F,(word_FF8234).w
loc_433E4:                              ; CODE XREF: Boss_SunsetStingSegmentInit+5A   j
                move.w  6(a5),d0
                moveq   #8,d2
                bsr.w Math_GetScaledSinCos
                move.l  d0,$18(a5)
                asr.l   #1,d0
                move.l  d1,$1C(a5)
                move.l  #$1800,$58(a5)
                move.w  (word_FFFF0E).w,d0
                lsr.w   #1,d0
                addq.w  #1,d0
                move.w  d0,$48(a5)
                move.b  #$C0,$21(a5)
                move.w  6(a5),$44(a5)
                clr.w   $4A(a5)
                move.w  #$10,$24(a5)
                addq.w  #2,4(a5)
                move.b  #$CC,d0
                jmp (Sound_PlaySFX).l
; End of function Boss_SunsetStingSegmentInit
; Segment movement logic
Boss_SunsetStingSegmentMove:                              ; DATA XREF: ROM:0004337A   o  ; was: sub_43430
                tst.w   $24(a5)
                bpl.s   loc_4346E
                bsr.w Physics_ClearVelocity
                move.b  d0,$21(a5)
                move.w  #8,4(a5)
                jsr (Projectile_ExplodeWithSound).l
                bclr    #4,$22(a5)
                beq.s   locret_4346C
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_4346C
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                jsr (Effect_SpawnDestructionBlast).l
locret_4346C:                           ; CODE XREF: Boss_SunsetStingSegmentMove+20   j
                                        ; Boss_SunsetStingSegmentMove+28   j
                rts
; ---------------------------------------------------------------------------
loc_4346E:                              ; CODE XREF: Boss_SunsetStingSegmentMove+4   j
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                move.w  $4A(a5),d0
                add.w   d0,$44(a5)
                move.w  $44(a5),d0
                lea     off_432FA(pc),a0
                bsr.w Boss_SunsetStingUpdateSegmentSprite
                tst.w   $48(a5)
                beq.s   loc_434C8
                move.l  $1C(a5),d0
                bmi.s   loc_434C8
                add.l   $14(a5),d0
                swap    d0
                addq.w  #8,d0
                cmpi.w  #$148,d0
                bcs.w   locret_432CE
                moveq   #$30,d0 ; '0'
                tst.w   $18(a5)
                bpl.s   loc_434B0
                neg.w   d0
loc_434B0:                              ; CODE XREF: Boss_SunsetStingSegmentMove+7C   j
                move.w  d0,$4A(a5)
                move.l  $1C(a5),d0
                move.l  d0,d1
                asr.l   #3,d1
                sub.l   d1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                subq.w  #1,$48(a5)
loc_434C8:                              ; CODE XREF: Boss_SunsetStingSegmentMove+5E   j
                                        ; Boss_SunsetStingSegmentMove+64   j ...
                bsr.w Boss_SunsetStingUpdateCore
                bne.w   locret_432CE
                move.w  #$A,4(a5)
                rts
; End of function Boss_SunsetStingSegmentMove
; Initializes falling segment
Boss_SunsetStingSegmentFallInit:                              ; DATA XREF: ROM:0004337C   o  ; was: sub_434D8
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                bra.s   loc_434C8
; End of function Boss_SunsetStingSegmentFallInit
; Segment wobble before fall
Boss_SunsetStingSegmentWobble:                              ; DATA XREF: ROM:0004337E   o  ; was: sub_434E2
                bsr.w Physics_ClearVelocity
                move.w  d0,$44(a5)
                move.b  d0,$21(a5)
                move.w  #4,4(a5)
                rts
; End of function Boss_SunsetStingSegmentWobble
; Converts segment to projectile
Boss_SunsetStingSegmentConvertToProjectile:                              ; DATA XREF: ROM:00043380   o  ; was: sub_434F6
                jsr (Enemy_GetEntityAddress).l
                move.l  #off_E95DC,8(a5)
                rts
; End of function Boss_SunsetStingSegmentConvertToProjectile
; Destroyed segment handler
Boss_SunsetStingSegmentDestroyed:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_43506
                lea     (Entity_ObjectPool).w,a3
                lea     (word_FF9800).w,a4
                bsr.s Boss_SunsetStingSegmentStateDispatch
                cmpi.w  #$E,4(a5)
                beq.w   locret_432CE
                btst    #7,(a4)
                beq.s   loc_4355C
                move.w  6(a5),d0
                moveq   #8,d2
                bsr.w Math_GetScaledSinCos
                move.l  d0,$18(a5)
                subq.w  #2,$1C(a5)
                move.l  #$1800,$58(a5)
                move.w  #$80,d1
                bpl.s   loc_43542
                neg.w   d1
loc_43542:                              ; CODE XREF: Boss_SunsetStingSegmentDestroyed+38   j
                move.w  6(a5),$48(a5)
                move.w  d1,$4A(a5)
                clr.b   $21(a5)
                move.w  #$CD00,2(a5)
                move.w  #$E,4(a5)
loc_4355C:                              ; CODE XREF: Boss_SunsetStingSegmentDestroyed+18   j
                move.w  4(a4),d0
                add.w   d0,6(a5)
                rts
; End of function Boss_SunsetStingSegmentDestroyed
; Segment state dispatch wrapper
Boss_SunsetStingSegmentStateDispatch:                              ; CODE XREF: Boss_SunsetStingSegmentDestroyed+8   p  ; was: sub_43566
                movea.w 4(a5),a0
                lea     off_43572(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingSegmentStateDispatch
; ---------------------------------------------------------------------------
off_43572:      dc.w Boss_SunsetStingSegmentFall-*        ; DATA XREF: Boss_SunsetStingSegmentStateDispatch+4   o
                dc.w Boss_SunsetStingSegmentFall_AdvanceState-*
                dc.w Boss_SunsetStingSegmentFall_UpdateLoop-*
                dc.w Boss_SunsetStingSegmentHit-*
                dc.w Boss_SunsetStingDefeatStart-*
                dc.w Boss_ViblackAttachedToPlayer-*
                dc.w Boss_SunsetStingSegmentDestroyInit-*
                dc.w Boss_SunsetStingSegmentFalling-*


; Segment falls after destruction
Boss_SunsetStingSegmentFall:                              ; DATA XREF: ROM:off_43572   o  ; was: sub_43582
                move.w  #$C100,2(a5)
                move.b  #$40,$20(a5) ; '@'
                addq.w  #2,4(a5)
; Advance to next state for segment falling
Boss_SunsetStingSegmentFall_AdvanceState:                              ; DATA XREF: ROM:00043574   o  ; was: loc_43592
                addq.w  #2,4(a5)
; Calculate falling segment position and collision
Boss_SunsetStingSegmentFall_UpdateLoop:                              ; DATA XREF: ROM:00043576   o  ; was: loc_43596
                move.w  6(a5),d0
                move.w  $44(a5),d2
                cmpi.w  #$98,d2
                beq.s   loc_435A8
                addq.w  #2,$44(a5)
loc_435A8:                              ; CODE XREF: Boss_SunsetStingSegmentFall+20   j
                bsr.w Math_GetScaledSinCos
                add.l   $10(a3),d0
                add.l   $14(a3),d1
                move.l  d0,$10(a5)
                move.l  d1,$14(a5)
                move.w  6(a5),d0
                lea     off_4331A(pc),a0
                bsr.w Boss_SunsetStingUpdateSegmentSprite
                move.w  $46(a5),d0
                move.w  2(a4),d1
                btst    d0,d1
                beq.w   locret_432CE
                cmpi.w  #$FFFF,2(a4)
                beq.s   loc_435F8
                move.w  6(a5),d0
                addi.w  #$20,d0 ; ' '
                andi.w  #$3FF,d0
                cmpi.w  #$240,d0
                bcc.w   locret_432CE
                subi.w  #$A,(word_FF8234).w
loc_435F8:                              ; CODE XREF: Boss_SunsetStingSegmentFall+5A   j
                move.w  6(a5),$44(a5)
                move.w  #$230,$48(a5)
                move.b  #$40,$21(a5) ; '@'
                bclr    #7,$22(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_SunsetStingSegmentFall
; ---------------------------------------------------------------------------
word_43616:     dc.w 3, 1               ; DATA XREF: Boss_SunsetStingSegmentHit+4   r


; Segment hit reaction
Boss_SunsetStingSegmentHit:                              ; DATA XREF: ROM:00043578   o  ; was: sub_4361A
                move.w  (word_FFFF0E).w,d2
                move.w  word_43616(pc,d2.w),d1
                move.b  $48(a5),d2
                ext.w   d2
                tst.b   $49(a5)
                beq.s   loc_43642
                subq.b  #1,$49(a5)
                bne.s   loc_4364E
                moveq   #$FFFFFFFC,d0
                tst.w   (word_FFFF0E).w
                beq.s   loc_4363E
                add.b   d0,d0
loc_4363E:                              ; CODE XREF: Boss_SunsetStingSegmentHit+20   j
                move.b  d0,$48(a5)
loc_43642:                              ; CODE XREF: Boss_SunsetStingSegmentHit+12   j
                move.w  (word_FFA000).w,d0
                and.w   d1,d0
                bne.s   loc_4364E
                addq.b  #1,$48(a5)
loc_4364E:                              ; CODE XREF: Boss_SunsetStingSegmentHit+18   j
                                        ; Boss_SunsetStingSegmentHit+2E   j
                move.w  $44(a5),d0
                bsr.w Math_GetScaledSinCos
                add.l   d0,$10(a5)
                add.l   d1,$14(a5)
                move.b  $2D(a5),d2
                ext.w   d2
                add.w   $14(a5),d2
                cmpi.w  #$148,d2
                bcs.s   loc_436B0
loc_4366E:                              ; CODE XREF: Boss_SunsetStingSegmentHit+C0   j
                move.w  6(a5),$48(a5)
                asr.l   #1,d0
                tst.w   (word_FFFF0E).w
                beq.s   loc_43682
                move.l  d1,d2
                asr.l   #2,d2
                sub.l   d2,d1
loc_43682:                              ; CODE XREF: Boss_SunsetStingSegmentHit+60   j
                neg.l   d1
                move.l  d1,$1C(a5)
                move.l  #$1400,$58(a5)
                moveq   #$40,d1 ; '@'
                move.l  d0,$18(a5)
                bpl.s   loc_4369A
                neg.w   d1
loc_4369A:                              ; CODE XREF: Boss_SunsetStingSegmentHit+7C   j
                move.w  d1,$4A(a5)
                clr.b   $21(a5)
                move.w  #$CD00,2(a5)
                move.w  #8,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_436B0:                              ; CODE XREF: Boss_SunsetStingSegmentHit+52   j
                lea     (word_FFA400).w,a0
                bclr    #7,$22(a5)
                beq.w   loc_43754
                bclr    #4,$22(a5)
                beq.s   loc_436DC
                tst.l   d0
                bpl.s   loc_436CC
                neg.l   d0
loc_436CC:                              ; CODE XREF: Boss_SunsetStingSegmentHit+AE   j
                btst    #3,$E(a0)
                bne.s   loc_436D6
                neg.l   d0
loc_436D6:                              ; CODE XREF: Boss_SunsetStingSegmentHit+B8   j
                move.l  d0,$18(a5)
                bra.s   loc_4366E
; ---------------------------------------------------------------------------
loc_436DC:                              ; CODE XREF: Boss_SunsetStingSegmentHit+AA   j
                move.w  $14(a5),d0
                sub.w   $14(a0),d0
                cmpi.w  #$18,d0
                bgt.s   loc_43754
                btst    #1,(byte_FF8244).w
                beq.s   loc_43702
                subi.b  #$14,d0
                bmi.s   loc_43702
                addi.b  #$14,d0
                add.w   d0,d0
                subi.w  #$18,d0
loc_43702:                              ; CODE XREF: Boss_SunsetStingSegmentHit+D6   j
                                        ; Boss_SunsetStingSegmentHit+DC   j
                move.b  d0,$49(a5)
                move.w  $10(a5),d0
                sub.w   $10(a0),d0
                btst    #3,$E(a0)
                bne.s   loc_43718
                neg.w   d0
loc_43718:                              ; CODE XREF: Boss_SunsetStingSegmentHit+FA   j
                move.b  d0,$48(a5)
                move.b  $E(a0),d0
                andi.w  #8,d0
                move.b  d0,$4A(a5)
                bsr.w Physics_ClearVelocity
                move.b  d0,$21(a5)
                move.w  #$A,4(a5)
                rts
; End of function Boss_SunsetStingSegmentHit
; Starts defeat sequence
Boss_SunsetStingDefeatStart:                              ; DATA XREF: ROM:0004357A   o  ; was: sub_43738
                addi.l  #$4000,$1C(a5)
                move.w  $4A(a5),d0
                add.w   d0,$48(a5)
                move.w  $48(a5),d0
                lea     off_4331A(pc),a0
                bsr.w Boss_SunsetStingUpdateSegmentSprite
loc_43754:                              ; CODE XREF: Boss_SunsetStingSegmentHit+A0   j
                                        ; Boss_SunsetStingSegmentHit+CE   j
                bsr.w Boss_SunsetStingUpdateCore
                bne.w   locret_432CE
                move.w  #$C,4(a5)
                rts
; End of function Boss_SunsetStingDefeatStart
; Updates position when attached to player
Boss_ViblackAttachedToPlayer:                              ; DATA XREF: ROM:0004357C   o  ; was: sub_43764
                addq.b  #1,$4B(a5)
                andi.b  #$F,$4B(a5)
                bne.s   loc_43774
                bsr.w Projectile_SpawnViblackBullet
loc_43774:                              ; CODE XREF: Boss_ViblackAttachedToPlayer+A   j
                move.w  $4A(a5),d0
                andi.w  #7,d0
                bne.s   loc_43786
                clr.b   $21(a5)
                subq.w  #1,(word_FFA216).w
loc_43786:                              ; CODE XREF: Boss_ViblackAttachedToPlayer+18   j
                lea     (word_FFA400).w,a0
                move.b  $48(a5),d0
                ext.w   d0
                move.b  $E(a0),d1
                andi.w  #8,d1
                bne.s   loc_4379C
                neg.w   d0
loc_4379C:                              ; CODE XREF: Boss_ViblackAttachedToPlayer+34   j
                cmp.b   $4A(a5),d1
                beq.s   loc_437AC
                bchg    #3,$E(a5)
                move.b  d1,$4A(a5)
loc_437AC:                              ; CODE XREF: Boss_ViblackAttachedToPlayer+3C   j
                add.w   $10(a0),d0
                move.w  d0,$10(a5)
                move.w  $48(a5),d0
                ext.w   d0
                btst    #1,(byte_FF8244).w
                beq.s   loc_437D6
                cmpi.w  #$FFF8,d0
                bpl.s   loc_437CE
                addi.w  #$18,d0
                bra.s   loc_437D6
; ---------------------------------------------------------------------------
loc_437CE:                              ; CODE XREF: Boss_ViblackAttachedToPlayer+62   j
                moveq   #$18,d1
                sub.w   d0,d1
                lsr.w   #1,d1
                add.w   d1,d0
loc_437D6:                              ; CODE XREF: Boss_ViblackAttachedToPlayer+5C   j
                                        ; Boss_ViblackAttachedToPlayer+68   j
                add.w   $14(a0),d0
                move.w  d0,$14(a5)
                btst    #4,(byte_FF8244).w
                beq.w   locret_432CE
                subq.w  #2,$1C(a5)
                move.l  #$1800,$58(a5)
                moveq   #$20,d0 ; ' '
                btst    #3,$E(a0)
                beq.s   loc_43800
                neg.w   d0
loc_43800:                              ; CODE XREF: Boss_ViblackAttachedToPlayer+98   j
                move.w  d0,$4A(a5)
                clr.b   $21(a5)
                move.w  #$CD00,2(a5)
                move.w  #8,4(a5)
                rts
; End of function Boss_ViblackAttachedToPlayer
; Initializes segment destruction
Boss_SunsetStingSegmentDestroyInit:                              ; DATA XREF: ROM:0004357E   o  ; was: sub_43816
                bsr.w Physics_ClearVelocity
                move.w  d0,$44(a5)
                move.b  d0,$21(a5)
                move.w  #$C100,2(a5)
                move.w  #4,4(a5)
                rts
; End of function Boss_SunsetStingSegmentDestroyInit
; Segment falling state
Boss_SunsetStingSegmentFalling:                              ; DATA XREF: ROM:00043580   o  ; was: sub_43830
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                move.w  $4A(a5),d0
                add.w   d0,$48(a5)
                move.w  $48(a5),d0
                lea     off_4331A(pc),a0
                bsr.w Boss_SunsetStingUpdateSegmentSprite
                bsr.w Boss_SunsetStingUpdateCore
                bne.w   locret_432CE
                clr.w   (a5)
                rts
; End of function Boss_SunsetStingSegmentFalling
; Boss falls during defeat
Boss_SunsetStingDefeatFall:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_43858
                lea     (Entity_ObjectPool).w,a3
                lea     (word_FF9800).w,a4
                bsr.s Boss_SunsetStingDefeatExplode
                btst    #7,(a4)
                beq.s   loc_4386C
                clr.b   $21(a5)
loc_4386C:                              ; CODE XREF: Boss_SunsetStingDefeatFall+E   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_43890
                addq.w  #4,6(a5)
                cmpi.w  #$C,6(a5)
                bne.s   loc_43886
                clr.w   6(a5)
loc_43886:                              ; CODE XREF: Boss_SunsetStingDefeatFall+28   j
                move.w  6(a5),d0
                move.l  off_43892(pc,d0.w),8(a5)
locret_43890:                           ; CODE XREF: Boss_SunsetStingDefeatFall+1C   j
                                        ; DATA XREF: ROM:000438AC   o
                rts
; End of function Boss_SunsetStingDefeatFall
; ---------------------------------------------------------------------------
off_43892:      dc.l word_EBF6C         ; DATA XREF: Boss_SunsetStingDefeatFall+32   r
                dc.l word_EBF78
                dc.l word_EBF84


; Boss explosion during defeat
Boss_SunsetStingDefeatExplode:                              ; CODE XREF: Boss_SunsetStingDefeatFall+8   p  ; was: sub_4389E
                movea.w 4(a5),a0
                lea     off_438AA(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingDefeatExplode
; ---------------------------------------------------------------------------
off_438AA:      dc.w Boss_SunsetStingDefeatEnd-*        ; DATA XREF: Boss_SunsetStingDefeatExplode+4   o
                dc.w locret_43890-*


; Ends defeat sequence
Boss_SunsetStingDefeatEnd:                              ; DATA XREF: ROM:off_438AA   o  ; was: sub_438AE
                move.w  #$CD00,2(a5)
                move.l  #word_EBF84,8(a5)
                move.b  #$40,$20(a5) ; '@'
                move.l  #$E008F010,$2C(a5)
                bra.w   loc_432CA
; End of function Boss_SunsetStingDefeatEnd
; Applies gravity and disables after timer expires
Projectile_ViblackFallAndDisable:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_438CE
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                subq.w  #1,$48(a5)
                bne.w   locret_432CE
                bset    #4,2(a5)
                rts
; End of function Projectile_ViblackFallAndDisable
; Spawns projectile at boss position with upward velocity
Projectile_SpawnViblackBullet:                              ; CODE XREF: Boss_ViblackAttachedToPlayer+C   p  ; was: sub_438E6
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_432CE
                move.w  #$1F8,(a0)
                move.w  #$CD00,2(a0)
                move.w  #$8480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                move.l  #word_E91FA,8(a0)
                move.b  #4,$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$3000,$58(a0)
                move.w  #$18,$48(a0)
                rts
; End of function Projectile_SpawnViblackBullet
; Sets up entity pointers and calls projectile dispatcher
Boss_ViblackProjectileDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_43930
                lea     (Entity_ObjectPool).w,a3
                lea     (word_FF9800).w,a4
                bsr.s   nullsub_7
                rts
; End of function Boss_ViblackProjectileDispatcher
; ---------------------------------------------------------------------------
                dc.l off_EBFC0
                dc.l off_EBFCC


nullsub_7:                              ; CODE XREF: Boss_ViblackProjectileDispatcher+8   p
                rts
; End of function nullsub_7


; Executes jump table based dispatcher for Viblack states
Boss_ViblackJumpTableDispatcher:
                movea.w 4(a5),a0  ; was: sub_43946
                lea     off_43952(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ViblackJumpTableDispatcher
; ---------------------------------------------------------------------------
off_43952:      dc.w Projectile_SpawnViblackMissile-*        ; DATA XREF: Boss_ViblackJumpTableDispatcher+4   o
                dc.w Projectile_SpawnViblackMissile-*


; Spawns missile projectile at entity position
Projectile_SpawnViblackMissile:                              ; DATA XREF: ROM:off_43952   o  ; was: sub_43956
                                        ; ROM:00043954   o
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_432CE
                move.w  #$210,(a0)
                move.w  #$ED00,2(a0)
                move.w  #$6300,$E(a0)
                move.l  #off_EBFCC,8(a0)
                move.b  #$3C,$20(a0) ; '<'
                move.w  $10(a3),$10(a0)
                move.w  $14(a3),$14(a0)
                rts
; End of function Projectile_SpawnViblackMissile
; Main Viblack mini-boss handler
Boss_ViblackMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4398C
                tst.w   4(a5)
                beq.w Boss_ViblackStateDispatch
                addq.w  #1,$4E(a5)
                lea     word_43B0A(pc),a2
                nop
                jsr (Gfx_ProcessColorFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$5E(a5)
                movea.w #(word_FFC680-M68K_RAM),a4
                btst    #2,(byte_FF80EC).w
                bne.s Boss_ViblackStateDispatch
                btst    #1,(byte_FF80EC).w
                bne.s Boss_ViblackStateDispatch
                tst.w   (word_FF8200).w
                beq.w Boss_ViblackDefeatInit
; State machine dispatcher for Viblack boss
Boss_ViblackStateDispatch:                              ; CODE XREF: Boss_ViblackMain+4   j  ; was: loc_439CC
                                        ; Boss_ViblackMain+2E   j ...
                move.w  4(a5),d0
                movea.w off_439DC(pc,d0.w),a0
                adda.l  #Boss_ViblackInit,a0
                jmp     (a0)
; End of function Boss_ViblackMain
; ---------------------------------------------------------------------------
off_439DC:      dc.w Boss_ViblackInit-Boss_ViblackInit
                                        ; DATA XREF: Boss_ViblackMain+44   r
                dc.w Boss_ViblackIntroSetup-Boss_ViblackInit
                dc.w Boss_ViblackDescend-Boss_ViblackInit
                dc.w Boss_ViblackFallOffScreen-Boss_ViblackInit
                dc.w Boss_ViblackDefeatCheck-Boss_ViblackInit
                dc.w Boss_ViblackAttackState-Boss_ViblackInit
                dc.w Boss_ViblackDefeat_MoveToTarget-Boss_ViblackInit
                dc.w Boss_ViblackDefeatWait-Boss_ViblackInit
                dc.w Boss_ViblackStartAttackPhase-Boss_ViblackInit
                dc.w Boss_ViblackProjectileAttack-Boss_ViblackInit
                dc.w Boss_ViblackDefeatMoveUp-Boss_ViblackInit
                dc.w Boss_ViblackDefeatMoveDown-Boss_ViblackInit
                dc.w Boss_ViblackRopePhysics-Boss_ViblackInit
                dc.w Boss_BackStringerTimerState-Boss_ViblackInit
                dc.w Boss_BackStringerSetDownVelocity-Boss_ViblackInit
                dc.w Boss_BackStringerTransitionFinish-Boss_ViblackInit


; Initializes Viblack mini-boss
Boss_ViblackInit:                              ; DATA XREF: Boss_ViblackMain+48   o  ; was: sub_439FC
                                        ; ROM:off_439DC   o ...
                addq.w  #2,4(a5)
                move.w  #$C2F8,(word_FF8110).w
                move.w  #$20,(word_FF8112).w ; ' '
                move.b  #4,(word_FFF7E6+1).w
                move.b  #8,(byte_FFA95A).w
                move.b  #$20,(byte_FFA95B).w ; ' '
                move.w  #1,(word_FF8218).w
                move.w  #$30,$48(a5) ; '0'
                move.b  #6,(byte_FF80EC).w
; Sets up intro graphics and position
Boss_ViblackIntroSetup:                              ; DATA XREF: ROM:000439DE   o  ; was: loc_43A30
                subq.w  #1,$48(a5)
                bpl.w   locret_43C44
                addq.w  #2,4(a5)
                move.w  #$D00,2(a5)
                move.w  #$5000,(word_FF8200).w
                move.w  #$5000,(word_FF8202).w
                move.w  #$1C,$24(a5)
                move.b  #$10,$21(a5)
                move.b  #$80,$23(a5)
                move.l  #$F010F010,$28(a5)
                move.w  (dword_FFA410).w,$10(a5)
                move.w  #$7C,$14(a5) ; '|'
                move.w  #8,$1C(a5)
                move.w  #$10,(a4)
                clr.w   2(a4)
                move.b  #$20,$21(a4) ; ' '
                move.w  #4,$46(a4)
                move.l  #$FF770088,$28(a4)
                lea     (byte_C464).l,a0
                jsr     (LoadPalette).l
                lea     word_43B0A(pc),a2
                nop
                jsr (Gfx_ClearColorFadeState).l
                lea     word_43AE0(pc),a0
                nop
                move.w  #$8000,d0
                jsr (Stage_LoadShipGraphics).l
                movea.l #$FFFF5520,a0
                move.w  #$2000,d0
                moveq   #$49,d7 ; 'I'
                jsr (Gfx_AdjustTileIndices).l
                lea     word_43AF0(pc),a0
                nop
                jsr (Gfx_LoadCompressedTiles).l
                bra.w Boss_ViblackUpdateAngle
; End of function Boss_ViblackInit
; ---------------------------------------------------------------------------
word_43AE0:     dc.w $4000, $8E8F, $9091, $9293, $9899, $9A9B, $9C9D, $A2FF
                                        ; DATA XREF: Boss_ViblackInit+B2   o
word_43AF0:     dc.w $6000, $4000, $901, $8E8F, $9091, $9293, $9899, $9A9B, 0, 0, $9C9D, 0, 0
                                        ; DATA XREF: Boss_ViblackInit+D4   o
word_43B0A:     dc.w $D, $E302, $E304, $E306, $E30C, $E30A, $E30C, $E30E, $E310, $E312, $E314, $E316, $E318, $E31A, $E31E
                                        ; DATA XREF: Boss_ViblackMain+C   o
                                        ; Boss_ViblackInit+A6   o ...


; Viblack descends from top
Boss_ViblackDescend:                              ; DATA XREF: ROM:000439E0   o  ; was: sub_43B28
                bsr.w Sound_ViblackPeriodic
                bsr.w Boss_ViblackUpdatePosition
                subi.l  #$2000,$1C(a5)
                move.w  (dword_FFA414).w,d0
                sub.w   $14(a5),d0
                cmpi.w  #$20,d0 ; ' '
                bpl.s   locret_43B82
                addq.w  #2,4(a5)
                move.l  #$30000,$1C(a5)
                move.w  #$30,(word_FFA02A).w ; '0'
                bset    #5,(byte_FF8245).w
                bset    #4,(word_FFA40E).w
                jsr (Sys_ClearObjectBufferSmall).l
                move.w  #$8000,(word_FF808A).w
                move.w  #4,(word_FFA010).w
                move.b  #$DA,d0
                jsr (Sound_PlaySFX).l
                bra.s   loc_43BD0
; ---------------------------------------------------------------------------
locret_43B82:                           ; CODE XREF: Boss_ViblackDescend+1C   j
                rts
; End of function Boss_ViblackDescend
; Viblack falls off screen
Boss_ViblackFallOffScreen:                              ; DATA XREF: ROM:000439E2   o  ; was: sub_43B84
                bsr.w Sound_ViblackPeriodic
                bsr.w Boss_ViblackUpdatePosition
                subi.l  #$2800,$1C(a5)
                bpl.s   loc_43BD0
                cmpi.w  #$FFFA,$1C(a5)
                bpl.s   loc_43BD0
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
                move.w  #$C,$5A(a5)
                move.w  #$FFFF,$50(a5)
                move.w  #$780,$52(a5)
                move.w  #$C8,$54(a5)
                clr.b   (byte_FF80EC).w
                clr.w   (word_FFA02A).w
                bclr    #5,(byte_FF8245).w
                addq.w  #2,(word_FFA404).w
loc_43BD0:                              ; CODE XREF: Boss_ViblackDescend+58   j
                                        ; Boss_ViblackFallOffScreen+10   j ...
                movea.w #(word_FFC680-M68K_RAM),a4
                move.w  $14(a4),d0
                addi.w  #$20,d0 ; ' '
                move.w  d0,(dword_FFA414).w
                rts
; End of function Boss_ViblackFallOffScreen
; Checks defeat condition
Boss_ViblackDefeatCheck:                              ; DATA XREF: ROM:000439E4   o  ; was: sub_43BE2
                bsr.w Boss_ViblackUpdatePosition
                bsr.w Boss_ViblackSpawnWalkerShot
                bsr.w Boss_ViblackMoveToTarget
                bne.s   locret_43C44
                move.w  (dword_FFFF08).w,d0
                subq.w  #1,$5A(a5)
                bpl.s   loc_43C20
                move.w  #$10,4(a5)
                andi.w  #$F,d0
                addi.w  #8,d0
                move.w  d0,$5A(a5)
                move.w  #2,$50(a5)
                move.w  #$780,$52(a5)
                move.w  #$C8,$54(a5)
                rts
; ---------------------------------------------------------------------------
loc_43C20:                              ; CODE XREF: Boss_ViblackDefeatCheck+16   j
                addq.w  #2,4(a5)
                bsr.w Boss_ViblackSpawnChain
                tst.w   (word_FFC740).w
                bne.s Boss_ViblackSetRandomDelay
                move.w  #$60,$48(a5) ; '`'
                rts
; ---------------------------------------------------------------------------
; Sets random delay timer for actions
Boss_ViblackSetRandomDelay:                              ; CODE XREF: Boss_ViblackDefeatCheck+4A   j  ; was: loc_43C36
                move.w  (dword_FFFF08).w,d0
                andi.w  #$40,d0 ; '@'
                addq.w  #8,d0
                move.w  d0,$48(a5)
locret_43C44:                           ; CODE XREF: Boss_ViblackInit+38   j
                                        ; Boss_ViblackDefeatCheck+C   j ...
                rts
; End of function Boss_ViblackDefeatCheck
; Attack state with timer and projectile spawning
Boss_ViblackAttackState:                              ; DATA XREF: ROM:000439E6   o  ; was: sub_43C46
                bsr.w Boss_ViblackUpdatePosition
                bsr.w Boss_ViblackSpawnWalkerShot
                subq.w  #1,$48(a5)
                bpl.s   locret_43C5E
loc_43C54:                              ; CODE XREF: Boss_ViblackProjectileAttack+8   j
                move.w  #8,4(a5)
                bra.w Boss_ViblackSetRandomTarget
; ---------------------------------------------------------------------------
locret_43C5E:                           ; CODE XREF: Boss_ViblackAttackState+C   j
                rts
; End of function Boss_ViblackAttackState
; Sets up Viblack boss attack phase with timer
Boss_ViblackStartAttackPhase:                              ; DATA XREF: ROM:000439EC   o  ; was: sub_43C60
                bsr.w Boss_ViblackUpdatePosition
                bsr.w Boss_ViblackMoveToTarget
                bne.s   locret_43C44
                addq.w  #2,4(a5)
                move.w  #$100,$48(a5)
                rts
; End of function Boss_ViblackStartAttackPhase
; Spawns projectiles with angle-based trajectory
Boss_ViblackProjectileAttack:                              ; DATA XREF: ROM:000439EE   o  ; was: sub_43C76
                bsr.w Boss_ViblackUpdatePosition
                subq.w  #1,$48(a5)
                bmi.w   loc_43C54
                cmpi.w  #$20,$48(a5) ; ' '
                bmi.w   locret_43C44
                btst    #0,(word_FFA000+1).w
                bne.w   locret_43C44
                lea     byte_43D52(pc),a1
                nop
                move.w  $48(a5),d0
                andi.w  #$F,d0
                moveq   #0,d6
                move.b  (a1,d0.w),d6
                asl.w   #1,d6
                moveq   #1,d5
loc_43CAE:                              ; CODE XREF: Boss_ViblackProjectileAttack+CA   j
                                        ; Boss_ViblackProjectileAttack+D6   j
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_43C44
                cmpi.w  #$A0,$48(a5)
                bpl.s   loc_43CCE
                move.w  #$8008,d2
                moveq   #$24,d7 ; '$'
                jsr (Enemy_SetProjectileDifficulty).l
                bra.s   loc_43CF8
; ---------------------------------------------------------------------------
loc_43CCE:                              ; CODE XREF: Boss_ViblackProjectileAttack+48   j
                lea     (dword_2AD4A).l,a1
                jsr (Sprite_InitFromTable).l
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d6.w),d0
                move.w  (a1,d6.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
loc_43CF8:                              ; CODE XREF: Boss_ViblackProjectileAttack+56   j
                move.w  $10(a5),d0
                tst.w   d5
                beq.s   loc_43D0E
                subi.w  #$1C,d0
                move.w  d6,d1
                move.w  #$100,d6
                sub.w   d1,d6
                bra.s   loc_43D18
; ---------------------------------------------------------------------------
loc_43D0E:                              ; CODE XREF: Boss_ViblackProjectileAttack+88   j
                addi.w  #$1C,d0
                bset    #3,$E(a0)
loc_43D18:                              ; CODE XREF: Boss_ViblackProjectileAttack+96   j
                move.w  d0,$10(a0)
                subi.w  #$80,d0
                bmi.s   loc_43D46
                cmpi.w  #$140,d0
                bpl.s   loc_43D46
                asr.w   #3,d0
                andi.w  #$FFFE,d0
                addi.w  #-$6B80,d0
                movea.w d0,a1
                move.w  (a1),d0
                neg.w   d0
                subi.w  #$160,d0
                move.w  d0,$14(a0)
                dbf     d5,loc_43CAE
                rts
; ---------------------------------------------------------------------------
loc_43D46:                              ; CODE XREF: Boss_ViblackProjectileAttack+AA   j
                                        ; Boss_ViblackProjectileAttack+B0   j
                bset    #4,2(a0)
                dbf     d5,loc_43CAE
                rts
; End of function Boss_ViblackProjectileAttack
; ---------------------------------------------------------------------------
byte_43D52:     dc.b $50, $4C, $48, $44, $40, $3C, $38, $34, $30, $34, $38, $3C, $40, $44, $48, $4C
                                        ; DATA XREF: Boss_ViblackProjectileAttack+20   o


; Initializes defeat sequence
Boss_ViblackDefeatInit:                              ; CODE XREF: Boss_ViblackMain+3C   j  ; was: sub_43D62
                move.b  #1,(byte_FF830E).w
                move.w  #$C,4(a5)
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                clr.b   $21(a5)
                move.w  #$80,(word_FF808C).w
                move.w  #$780,$52(a5)
                move.w  #$C8,$54(a5)
; Moves boss to target position during defeat
Boss_ViblackDefeat_MoveToTarget:                              ; DATA XREF: ROM:000439E8   o  ; was: loc_43D90
                bsr.w Boss_ViblackUpdateAll
                bsr.w Boss_ViblackMoveToTarget
                bne.s   locret_43DA8
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
                move.w  #$80,$48(a5)
locret_43DA8:                           ; CODE XREF: Boss_ViblackDefeatInit+36   j
                rts
; End of function Boss_ViblackDefeatInit
; Waiting state with timer countdown
Boss_ViblackDefeatWait:                              ; DATA XREF: ROM:000439EA   o  ; was: sub_43DAA
                bsr.w Boss_ViblackUpdateSpriteAndSpawn
                subq.w  #1,$48(a5)
                bpl.s   locret_43DBE
                move.w  #$14,4(a5)
                clr.w   (word_FF8112).w
locret_43DBE:                           ; CODE XREF: Boss_ViblackDefeatWait+8   j
                rts
; End of function Boss_ViblackDefeatWait
; Move up state with acceleration
Boss_ViblackDefeatMoveUp:                              ; DATA XREF: ROM:000439F0   o  ; was: sub_43DC0
                bsr.w Boss_ViblackUpdateSpriteAndSpawn
                addi.l  #$3000,$1C(a5)
                cmpi.w  #$100,$14(a5)
                bmi.s   locret_43DDC
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
locret_43DDC:                           ; CODE XREF: Boss_ViblackDefeatMoveUp+12   j
                rts
; End of function Boss_ViblackDefeatMoveUp
; Move down with deceleration and stage setup
Boss_ViblackDefeatMoveDown:                              ; DATA XREF: ROM:000439F2   o  ; was: sub_43DDE
                bsr.w Boss_ViblackUpdateSpriteAndSpawn
                subi.l  #$3000,$1C(a5)
                cmpi.w  #$C8,$14(a5)
                bpl.w   locret_43C44
                addq.w  #2,4(a5)
                clr.l   $1C(a5)
                clr.w   $52(a5)
                move.w  #$FFF0,$54(a5)
                btst    #4,(word_FFA40E).w
                beq.s   loc_43E20
                move.w  #$4C,(word_FFA404).w ; 'L'
                move.w  #$FFF8,(dword_FFA41C).w
                jsr (Sys_ClearObjectBufferSmall).l
loc_43E20:                              ; CODE XREF: Boss_ViblackDefeatMoveDown+2E   j
                move.w  #$320,(word_FFC680).w
                clr.w   (word_FFC682).w
                move.w  #2,(word_FFC6C6).w
                clr.l   (dword_FFC6DC).w
                move.b  #2,(byte_FFA95A).w
                move.b  #$4D,d0 ; 'M'
                jmp (Sound_PlaySFX).l
; End of function Boss_ViblackDefeatMoveDown
; Boss rope/tentacle physics calculation
Boss_ViblackRopePhysics:                              ; DATA XREF: ROM:000439F4   o  ; was: sub_43E44
                clr.w   $4E(a5)
                bsr.w Boss_ViblackUpdatePosAndPalette
                move.w  $52(a5),d1
                move.w  $54(a5),d0
                beq.s   loc_43E98
                bpl.s   loc_43E78
loc_43E58:                              ; CODE XREF: Boss_BackStringerTimerState+70   j
                                        ; Boss_BackStringerTransitionFinish+16   j
                cmpi.w  #$FFF0,d0
                bpl.s   loc_43E60
                moveq   #$FFFFFFF0,d0
loc_43E60:                              ; CODE XREF: Boss_ViblackRopePhysics+18   j
                cmp.w   d1,d0
                beq.s   loc_43E6E
                bpl.s   loc_43E6E
                subq.w  #4,$52(a5)
                subq.w  #4,d1
                bra.s   loc_43EB4
; ---------------------------------------------------------------------------
loc_43E6E:                              ; CODE XREF: Boss_ViblackRopePhysics+1E   j
                                        ; Boss_ViblackRopePhysics+20   j
                neg.w   $54(a5)
                subq.w  #2,$54(a5)
                bra.s   loc_43EB0
; ---------------------------------------------------------------------------
loc_43E78:                              ; CODE XREF: Boss_ViblackRopePhysics+12   j
                                        ; Boss_BackStringerTimerState+6C   j ...
                cmpi.w  #$10,d0
                bmi.s   loc_43E80
                moveq   #$10,d0
loc_43E80:                              ; CODE XREF: Boss_ViblackRopePhysics+38   j
                cmp.w   d1,d0
                beq.s   loc_43E8E
                bmi.s   loc_43E8E
                addq.w  #4,$52(a5)
                addq.w  #4,d1
                bra.s   loc_43EB4
; ---------------------------------------------------------------------------
loc_43E8E:                              ; CODE XREF: Boss_ViblackRopePhysics+3E   j
                                        ; Boss_ViblackRopePhysics+40   j
                neg.w   $54(a5)
                addq.w  #2,$54(a5)
                bra.s   loc_43EB0
; ---------------------------------------------------------------------------
loc_43E98:                              ; CODE XREF: Boss_ViblackRopePhysics+10   j
                tst.w   d1
                bpl.s   loc_43EA4
                clr.w   $52(a5)
                moveq   #0,d1
                bra.s   loc_43EB4
; ---------------------------------------------------------------------------
loc_43EA4:                              ; CODE XREF: Boss_ViblackRopePhysics+56   j
                addq.w  #2,4(a5)
                move.w  #$140,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_43EB0:                              ; CODE XREF: Boss_ViblackRopePhysics+32   j
                                        ; Boss_ViblackRopePhysics+52   j
                move.w  $52(a5),d1
loc_43EB4:                              ; CODE XREF: Boss_ViblackRopePhysics+28   j
                                        ; Boss_ViblackRopePhysics+48   j ...
                asr.w   #1,d1
                addi.w  #$C7,d1
                move.w  d1,$14(a5)
                move.w  (dword_FFA904).w,d0
                neg.w   d0
                moveq   #$18,d1
                move.w  $52(a5),d2
                neg.w   d2
                asl.w   #4,d2
                moveq   #9,d7
                movea.w #(word_FFEC24-M68K_RAM),a0
                movea.w #(word_FFEC28-M68K_RAM),a1
loc_43ED8:                              ; CODE XREF: Boss_ViblackRopePhysics+A6   j
                move.w  d2,d3
                ext.l   d3
                divs.w  d1,d3
                add.w   d0,d3
                move.w  d3,(a0)
                move.w  d3,(a1)
                subq.w  #4,a0
                addq.w  #4,a1
                addq.w  #3,d1
                dbf     d7,loc_43ED8
                rts
; End of function Boss_ViblackRopePhysics
; Timer-based state with stage transition
Boss_BackStringerTimerState:                              ; DATA XREF: ROM:000439F6   o  ; was: sub_43EF0
                subq.w  #1,$48(a5)
                bpl.s   loc_43F10
                addq.w  #2,4(a5)
                bclr    #1,(byte_FF80F8).w
                movea.w #(word_FFC6E0-M68K_RAM),a0
                lea     (stru_114D0).l,a1
                jsr     (loc_116AC).l
loc_43F10:                              ; CODE XREF: Boss_BackStringerTimerState+4   j
                move.w  $48(a5),d0
                cmpi.w  #$100,d0
                bne.s   loc_43F2C
                jsr (Stage_TransitionToNextPhase).l
                subq.w  #2,(word_FFA950).w
                move.w  #$FFF0,$54(a5)
                bra.s   loc_43F4E
; ---------------------------------------------------------------------------
loc_43F2C:                              ; CODE XREF: Boss_BackStringerTimerState+28   j
                bpl.s   loc_43F4A
                cmpi.w  #$E0,d0
                bpl.s   loc_43F4E
                cmpi.w  #$80,d0
                bne.s   loc_43F42
                move.w  #$FFE8,$54(a5)
                bra.s   loc_43F4E
; ---------------------------------------------------------------------------
loc_43F42:                              ; CODE XREF: Boss_BackStringerTimerState+48   j
                bpl.s   loc_43F4A
                cmpi.w  #$40,d0 ; '@'
                bpl.s   loc_43F4E
loc_43F4A:                              ; CODE XREF: Boss_BackStringerTimerState:loc_43F2C   j
                                        ; sub_43EF0:loc_43F42   j
                clr.w   $4E(a5)
loc_43F4E:                              ; CODE XREF: Boss_BackStringerTimerState+3A   j
                                        ; Boss_BackStringerTimerState+42   j ...
                bsr.w Boss_ViblackUpdatePosAndPalette
                move.w  $52(a5),d1
                move.w  $54(a5),d0
                beq.s   locret_43F64
                bpl.w   loc_43E78
                bra.w   loc_43E58
; ---------------------------------------------------------------------------
locret_43F64:                           ; CODE XREF: Boss_BackStringerTimerState+6A   j
                rts
; End of function Boss_BackStringerTimerState
; Sets downward velocity
Boss_BackStringerSetDownVelocity:                              ; DATA XREF: ROM:000439F8   o  ; was: sub_43F66
                move.w  #$FFB4,$54(a5)
                clr.w   $4E(a5)
                bra.w Boss_ViblackUpdatePosAndPalette
; End of function Boss_BackStringerSetDownVelocity
; Final state transition with palette load
Boss_BackStringerTransitionFinish:                              ; DATA XREF: ROM:000439FA   o  ; was: sub_43F74
                bsr.w Boss_BackStringerSpawnDebris
                bsr.w   loc_43FD8
                move.w  $52(a5),d1
                move.w  $54(a5),d0
                beq.s   loc_43F8E
                bpl.w   loc_43E78
                bra.w   loc_43E58
; ---------------------------------------------------------------------------
loc_43F8E:                              ; CODE XREF: Boss_BackStringerTransitionFinish+10   j
                bsr.w   loc_43EB4
                move.w  #$1000,2(a5)
                move.l  #$60A45441,d0
                jsr (Scroll_UpdateStage14Scroll).l
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                lea     (byte_C484).l,a0
                jmp     LoadPalette
; End of function Boss_BackStringerTransitionFinish
; Updates sprite and spawns projectiles
Boss_ViblackUpdateSpriteAndSpawn:                              ; CODE XREF: Boss_ViblackDefeatWait   p  ; was: sub_43FBC
                                        ; sub_43DC0   p ...
                bsr.w Sound_ViblackPeriodic
                bsr.w Boss_ViblackSpawnRandomProjectiles
; End of function Boss_ViblackUpdateSpriteAndSpawn
; Updates position, palette and spawns rings
Boss_ViblackUpdateAll:                              ; CODE XREF: Boss_ViblackDefeatInit:loc_43D90   p  ; was: sub_43FC4
                bsr.s Boss_ViblackUpdatePosition
                lea     word_43B0A(pc),a4
                jsr (VBlank_UpdateSharpssteelPalette).l
                bra.w Boss_ViblackSpawnRandomRings
; End of function Boss_ViblackUpdateAll
; Updates position and palette
Boss_ViblackUpdatePosAndPalette:                              ; CODE XREF: Boss_ViblackRopePhysics+4   p  ; was: sub_43FD4
                                        ; sub_43EF0:loc_43F4E   p ...
                bsr.w Boss_ViblackSpawnRandomProjectile2
loc_43FD8:                              ; CODE XREF: Boss_BackStringerTransitionFinish+4   p
                bsr.s Boss_ViblackUpdatePosition
                lea     word_43B0A(pc),a4
                jmp (VBlank_UpdateSharpssteelPalette).l
; End of function Boss_ViblackUpdatePosAndPalette
; Updates Viblack position
Boss_ViblackUpdatePosition:                              ; CODE XREF: Boss_ViblackDescend+4   p  ; was: sub_43FE4
                                        ; Boss_ViblackFallOffScreen+4   p ...
                bsr.s Boss_ViblackUpdateAngle
                bra.w Boss_ViblackSpawnRing
; End of function Boss_ViblackUpdatePosition
; Updates rotation angle
Boss_ViblackUpdateAngle:                              ; CODE XREF: Boss_ViblackInit+E0   j  ; was: sub_43FEA
                                        ; sub_43FE4   p
                movea.w #(word_FF9480-M68K_RAM),a0
                movea.w #(dword_FF8A00-M68K_RAM),a1
                moveq   #9,d7
loc_43FF4:                              ; CODE XREF: Boss_ViblackUpdateAngle+C   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_43FF4
                movea.w #(word_FF9480-M68K_RAM),a0
                move.w  #0,d0
                moveq   #$13,d7
loc_44004:                              ; CODE XREF: Boss_ViblackUpdateAngle+1C   j
                move.w  d0,(a0)+
                dbf     d7,loc_44004
                moveq   #0,d0
                move.w  #$120,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  #$168,d0
                add.w   $14(a5),d0
                move.w  d0,(dword_FFA90C).w
                neg.w   d0
                movea.w #(dword_FF9410-M68K_RAM),a0
                movea.w #(dword_FF9418-M68K_RAM),a1
                lea     dword_440B0(pc),a2
                nop
                move.w  $4E(a5),d1
                asl.w   #2,d1
                andi.w  #$1C,d1
                move.l  (a2,d1.w),d1
                moveq   #7,d7
loc_44044:                              ; CODE XREF: Boss_ViblackUpdateAngle+64   j
                swap    d0
                add.l   d1,d0
                swap    d0
                move.w  d0,-(a0)
                move.w  d0,(a1)+
                dbf     d7,loc_44044
                movea.w #(dword_FF9410-M68K_RAM),a0
                movea.w #(dword_FF9418-M68K_RAM),a1
                moveq   #0,d0
                move.w  (dword_FFA90C).w,d0
                neg.w   d0
                moveq   #1,d7
loc_44064:                              ; CODE XREF: Boss_ViblackUpdateAngle+84   j
                swap    d0
                sub.l   d1,d0
                swap    d0
                move.w  d0,(a0)+
                move.w  d0,-(a1)
                dbf     d7,loc_44064
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9480-M68K_RAM),a1
                moveq   #$13,d7
                move.w  (dword_FFA908).w,d0
                addi.w  #$F,d0
                move.w  d0,d1
                asr.w   #4,d1
                bpl.s   loc_4409A
                add.w   d1,d7
                bmi.s   locret_440AE
                move.w  d0,d1
                asr.w   #3,d1
                andi.w  #$FFFE,d1
                suba.w  d1,a1
                bra.s Boss_ViblackCopyPalette
; ---------------------------------------------------------------------------
loc_4409A:                              ; CODE XREF: Boss_ViblackUpdateAngle+9E   j
                sub.w   d1,d7
                bmi.s   locret_440AE
                move.w  d0,d1
                asr.w   #3,d1
                andi.w  #$FFFE,d1
                adda.w  d1,a0
; Copies palette data words in loop
Boss_ViblackCopyPalette:                              ; CODE XREF: Boss_ViblackUpdateAngle+AE   j  ; was: loc_440A8
                                        ; Boss_ViblackUpdateAngle+C0   j
                move.w  (a0)+,(a1)+
                dbf d7,Boss_ViblackCopyPalette
locret_440AE:                           ; CODE XREF: Boss_ViblackUpdateAngle+A2   j
                                        ; Boss_ViblackUpdateAngle+B2   j
                rts
; End of function Boss_ViblackUpdateAngle
; ---------------------------------------------------------------------------
dword_440B0:    dc.l 0, $FFFE8000, $FFFE0000, $FFFF0000
                                        ; DATA XREF: Boss_ViblackUpdateAngle+44   o
                dc.l 0, $18000, $20000, $10000


; Spawns ring projectile
Boss_ViblackSpawnRing:                              ; CODE XREF: Boss_ViblackUpdatePosition+2   j  ; was: sub_440D0
                move.w  $10(a5),$10(a4)
                move.w  (dword_FFA410).w,d0
                subi.w  #$80,d0
                bmi.s   locret_440FE
                cmpi.w  #$140,d0
                bpl.s   locret_440FE
                asr.w   #3,d0
                andi.w  #$FFFE,d0
                addi.w  #-$6B80,d0
                movea.w d0,a0
                move.w  (a0),d0
                neg.w   d0
                subi.w  #$168,d0
                move.w  d0,$14(a4)
locret_440FE:                           ; CODE XREF: Boss_ViblackSpawnRing+E   j
                                        ; Boss_ViblackSpawnRing+14   j
                rts
; End of function Boss_ViblackSpawnRing
; Sets random target position
Boss_ViblackSetRandomTarget:                              ; CODE XREF: Boss_ViblackAttackState+14   j  ; was: sub_44100
                move.w  #2,$50(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$740,d0
                move.w  d0,$52(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$1F,d0
                addi.w  #$E0,d0
                move.w  d0,$54(a5)
                rts
; End of function Boss_ViblackSetRandomTarget
; Spawns ring projectiles at random positions
Boss_ViblackSpawnRandomRings:                              ; CODE XREF: Boss_ViblackUpdateAll+C   j  ; was: sub_44128
                btst    #0,(word_FFA000+1).w
                bne.s   locret_4418C
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_4418C
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                addq.w  #8,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.l  #off_E95DC,8(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_44178
                move.l  #off_E953C,8(a0)
loc_44178:                              ; CODE XREF: Boss_ViblackSpawnRandomRings+46   j
                jsr (Projectile_InitType88).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                addq.w  #5,d0
                move.w  d0,$1C(a0)
locret_4418C:                           ; CODE XREF: Boss_ViblackSpawnRandomRings+6   j
                                        ; Boss_ViblackSpawnRandomRings+E   j
                rts
; End of function Boss_ViblackSpawnRandomRings
; Spawns random projectiles
Boss_ViblackSpawnRandomProjectile2:                              ; CODE XREF: Boss_ViblackUpdatePosAndPalette   p  ; was: sub_4418E
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_441EA
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.l  #off_E96FC,8(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_441D6
                move.l  #off_E95C0,8(a0)
loc_441D6:                              ; CODE XREF: Boss_ViblackSpawnRandomProjectile2+3E   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                subq.w  #3,d0
                move.w  d0,$1C(a0)
                jmp Projectile_InitType88
; ---------------------------------------------------------------------------
locret_441EA:                           ; CODE XREF: Boss_ViblackSpawnRandomProjectile2+6   j
                rts
; End of function Boss_ViblackSpawnRandomProjectile2
; Spawns random projectiles and debris
Boss_BackStringerSpawnDebris:                              ; CODE XREF: Boss_BackStringerTransitionFinish   p  ; was: sub_441EC
                btst    #0,(word_FFA000+1).w
                bne.w   locret_4427A
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_4427A
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                bne.s   loc_44212
                jsr (Effect_InitDebrisSprite).l
                bra.w   loc_44246
; ---------------------------------------------------------------------------
loc_44212:                              ; CODE XREF: Boss_BackStringerSpawnDebris+1A   j
                jsr (Projectile_InitType88).l
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a0)
                move.l  #off_E953C,8(a0)
                move.w  #$FFFD,$1C(a0)
                btst    #0,(dword_FFFF08).w
                beq.s   loc_44246
                move.l  #off_E96FC,8(a0)
                clr.w   $1C(a0)
loc_44246:                              ; CODE XREF: Boss_BackStringerSpawnDebris+22   j
                                        ; Boss_BackStringerSpawnDebris+4C   j
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #8,d0
                addi.w  #$C,d0
                move.b  d0,$20(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$F,d0
                andi.w  #7,d1
                subq.w  #8,d0
                subq.w  #8,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_4427A:                           ; CODE XREF: Boss_BackStringerSpawnDebris+6   j
                                        ; Boss_BackStringerSpawnDebris+10   j
                rts
; End of function Boss_BackStringerSpawnDebris
; Spawns random projectiles periodically
Boss_ViblackSpawnRandomProjectiles:                              ; CODE XREF: Boss_ViblackUpdateSpriteAndSpawn+4   p  ; was: sub_4427C
                btst    #0,(word_FFA000+1).w
                bne.w   locret_43C44
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_43C44
                move.b  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                addi.w  #$A0,d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0 ; '?'
                addi.w  #$A0,d0
                move.w  d0,$14(a0)
                lea     (dword_2AE2E).l,a1
                move.w  #9,$1C(a0)
                jmp Sprite_InitFromTable
; End of function Boss_ViblackSpawnRandomProjectiles
; Calculates movement toward target using arctan2
Boss_ViblackMoveToTarget:                              ; CODE XREF: Boss_ViblackDefeatCheck+8   p  ; was: sub_442C2
                                        ; Boss_ViblackStartAttackPhase+4   p ...
                move.w  $52(a5),d0
                move.w  $54(a5),d1
                sub.w   $5E(a5),d0
                sub.w   $14(a5),d1
                jsr (Math_Arctan2Lookup).l
                asr.w   #7,d2
                andi.w  #$1FE,d2
                move.w  $50(a5),d3
                bmi.s   loc_442EA
                cmpi.w  #6,d3
                bpl.s   loc_442F0
loc_442EA:                              ; CODE XREF: Boss_ViblackMoveToTarget+20   j
                addq.w  #2,d3
                move.w  d3,$50(a5)
loc_442F0:                              ; CODE XREF: Boss_ViblackMoveToTarget+26   j
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d2.w),d0
                move.w  (a0,d2.w),d1
                muls.w  d3,d0
                muls.w  d3,d1
                move.l  d0,$1C(a5)
                move.l  d1,$18(a5)
                move.w  $5E(a5),d2
                sub.w   $52(a5),d2
                bpl.s   loc_44316
                neg.w   d2
loc_44316:                              ; CODE XREF: Boss_ViblackMoveToTarget+50   j
                cmpi.w  #2,d2
                beq.s   loc_4431E
                bpl.s   loc_44350
loc_4431E:                              ; CODE XREF: Boss_ViblackMoveToTarget+58   j
                move.w  $14(a5),d2
                sub.w   $54(a5),d2
                bpl.s   loc_4432A
                neg.w   d2
loc_4432A:                              ; CODE XREF: Boss_ViblackMoveToTarget+64   j
                cmpi.w  #2,d2
                beq.s   loc_44332
                bpl.s   loc_44350
loc_44332:                              ; CODE XREF: Boss_ViblackMoveToTarget+6C   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  $52(a5),d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  $54(a5),$14(a5)
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_44350:                              ; CODE XREF: Boss_ViblackMoveToTarget+5A   j
                                        ; Boss_ViblackMoveToTarget+6E   j
                moveq   #1,d0
locret_44352:                           ; CODE XREF: Sound_ViblackPeriodic+8   j
                rts
; End of function Boss_ViblackMoveToTarget
; Plays Viblack sound effect every 4 frames
Sound_ViblackPeriodic:                              ; CODE XREF: Boss_ViblackDescend   p  ; was: sub_44354
                                        ; sub_43B84   p ...
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_44352
                move.b  #$CD,d0
                jmp (Sound_PlaySFX).l
; End of function Sound_ViblackPeriodic
; Periodically spawns walker shot projectiles
Boss_ViblackSpawnWalkerShot:                              ; CODE XREF: Boss_ViblackDefeatCheck+4   p  ; was: sub_44368
                                        ; Boss_ViblackAttackState+4   p
                move.w  (word_FFA000).w,d0
                andi.w  #$FF,d0
                cmpi.w  #$2F,d0 ; '/'
                bpl.w   locret_43C44
                andi.w  #$F,d0
                bne.w   locret_43C44
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_43C44
                move.w  #$6F0,d0
                btst    #0,(word_FFA000).w
                bne.s   loc_4439A
                move.w  #$810,d0
loc_4439A:                              ; CODE XREF: Boss_ViblackSpawnWalkerShot+2C   j
                sub.w   (dword_FFA900).w,d0
                jmp Projectile_Stage17WalkerShot
; End of function Boss_ViblackSpawnWalkerShot
; Spawns chain of connected projectiles
Boss_ViblackSpawnChain:                              ; CODE XREF: Boss_ViblackDefeatCheck+42   p  ; was: sub_443A4
                cmpi.w  #$CE,$14(a5)
                bmi.w   locret_44482
                movea.w #(word_FFC6E0-M68K_RAM),a0
                tst.w   (a0)
                beq.s   loc_443C0
                movea.w #(word_FFC740-M68K_RAM),a0
                tst.w   (a0)
                bne.w   locret_44482
loc_443C0:                              ; CODE XREF: Boss_ViblackSpawnChain+10   j
                move.b  #$CE,d0
                jsr (Sound_PlaySFX).l
                movea.w #(dword_FFA100-M68K_RAM),a1
                move.w  a0,(a1)+
                moveq   #9,d6
loc_443D2:                              ; CODE XREF: Boss_ViblackSpawnChain+44   j
                jsr (Projectile_FindFreeSlotAndClear).l
                bne.w   locret_44482
                move.w  #$10,(a0)
                bset    #4,2(a0)
                move.w  a0,(a1)+
                dbf     d6,loc_443D2
                movea.w #(dword_FFA100-M68K_RAM),a3
                movea.w (a3)+,a0
                move.w  #$2EC,(a0)
                move.w  #$8D00,2(a0)
                move.w  #$2E,$24(a0) ; '.'
                move.w  #$80,$40(a0)
                move.w  #$10,$44(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #2,d0
                move.w  d0,$42(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7E,d0 ; '~'
                addi.w  #$140,d0
                move.w  d0,6(a0)
                bsr.w Boss_ViblackInitChainSegment
                movea.w a0,a1
                movea.w a0,a2
                adda.w  #$48,a1 ; 'H'
                move.w  (dword_FFA900).w,d4
                add.w   $10(a5),d4
                move.w  $14(a5),d5
                moveq   #9,d6
loc_44444:                              ; CODE XREF: Boss_ViblackSpawnChain+DA   j
                movea.w (a3)+,a0
                move.w  #$2F0,(a0)
                move.w  #$8000,2(a0)
                move.w  a0,(a1)+
                move.w  a2,6(a0)
                move.w  d4,$48(a0)
                move.w  d4,$4A(a0)
                move.w  d4,$4C(a0)
                move.w  d4,$4E(a0)
                move.w  d5,$50(a0)
                move.w  d5,$52(a0)
                move.w  d5,$54(a0)
                move.w  d5,$56(a0)
                bsr.s Boss_ViblackInitChainSegment
                move.w  #$7000,$24(a0)
                dbf     d6,loc_44444
locret_44482:                           ; CODE XREF: Boss_ViblackSpawnChain+6   j
                                        ; Boss_ViblackSpawnChain+18   j ...
                rts
; End of function Boss_ViblackSpawnChain
; Initializes chain segment object properties
Boss_ViblackInitChainSegment:                              ; CODE XREF: Boss_ViblackSpawnChain+86   p  ; was: sub_44484
                                        ; Boss_ViblackSpawnChain+D2   p
                clr.w   4(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.b  #$7C,$20(a0) ; '|'
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                clr.b   $21(a0)
                move.l  #$FF01FF01,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #$4E,$26(a0) ; 'N'
                rts
; End of function Boss_ViblackInitChainSegment
; Chain projectile main handler
Projectile_ViblackChainMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_444C2
                tst.w   (word_FF808C).w
                bpl.s   loc_444CE
                tst.w   $24(a5)
                bpl.s   loc_44514
loc_444CE:                              ; CODE XREF: Projectile_ViblackChainMain+4   j
                movea.w a5,a1
                adda.w  #$48,a1 ; 'H'
                moveq   #2,d6
                moveq   #9,d7
loc_444D8:                              ; CODE XREF: Projectile_ViblackChainMain+28   j
                movea.w (a1)+,a0
                clr.b   $21(a0)
                move.w  d6,6(a0)
                move.w  #4,4(a0)
                addq.w  #2,d6
                dbf     d7,loc_444D8
                clr.l   $18(a5)
                clr.l   $1C(a5)
loc_444F6:                              ; CODE XREF: Projectile_ViblackChainSegment+1A   j
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
                move.l  #$42000,$1C(a5)
                lea     (dword_2ABF0).l,a1 ; make offsets?
                jmp Sys_PassObjectAddress
; ---------------------------------------------------------------------------
loc_44514:                              ; CODE XREF: Projectile_ViblackChainMain+A   j
                cmpi.w  #$200,$14(a5)
                bmi.s   loc_44538
                bset    #4,2(a5)
                movea.w a5,a1
                adda.w  #$48,a1 ; 'H'
                moveq   #9,d7
loc_4452A:                              ; CODE XREF: Projectile_ViblackChainMain+70   j
                movea.w (a1)+,a0
                move.w  #2,4(a0)
                dbf     d7,loc_4452A
                rts
; ---------------------------------------------------------------------------
loc_44538:                              ; CODE XREF: Projectile_ViblackChainMain+58   j
                andi.w  #$1F8,6(a5)
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  $14(a5),d1
                move.w  6(a5),d3
                addi.w  #$20,d3 ; ' '
                asr.w   #5,d3
                andi.w  #$E,d3
                moveq   #0,d7
                tst.w   $44(a5)
                bpl.s   loc_44570
                move.w  #$8000,d7
                move.b  #$10,$20(a5)
                move.b  #$C0,$21(a5)
loc_44570:                              ; CODE XREF: Projectile_ViblackChainMain+9C   j
                lea     word_4469E(pc),a0
                nop
                move.w  (a0,d3.w),$E(a5)
                or.w    d7,$E(a5)
                or.w    d7,d3
                movea.w a5,a3
                adda.w  #$48,a3 ; 'H'
                moveq   #9,d7
loc_4458A:                              ; CODE XREF: Projectile_ViblackChainMain+F2   j
                movea.w (a3)+,a0
                movea.w a0,a1
                movea.w a0,a2
                adda.w  #$48,a0 ; 'H'
                adda.w  #$50,a1 ; 'P'
                adda.w  #$58,a2 ; 'X'
                moveq   #3,d6
loc_4459E:                              ; CODE XREF: Projectile_ViblackChainMain+EE   j
                move.w  (a0),d2
                move.w  d0,(a0)+
                move.w  d2,d0
                move.w  (a1),d2
                move.w  d1,(a1)+
                move.w  d2,d1
                move.w  (a2),d2
                move.w  d3,(a2)+
                move.w  d2,d3
                dbf     d6,loc_4459E
                dbf     d7,loc_4458A
                move.w  6(a5),d2
                moveq   #$14,d3
                tst.w   $44(a5)
                bpl.s   loc_445C6
                moveq   #$F,d3
loc_445C6:                              ; CODE XREF: Projectile_ViblackChainMain+100   j
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d2.w),d0
                move.w  (a0,d2.w),d1
                ext.l   d1
                muls.w  d3,d0
                asl.l   #3,d1
                move.l  d0,$1C(a5)
                move.l  d1,$18(a5)
                subq.w  #1,$44(a5)
                bpl.s   locret_44622
                move.w  $40(a5),d2
                sub.w   6(a5),d2
                bmi.w   loc_44616
                bne.s   loc_44608
                eori.w  #2,$42(a5)
                move.w  $42(a5),d0
                move.w  word_44624(pc,d0.w),$40(a5)
                rts
; ---------------------------------------------------------------------------
loc_44608:                              ; CODE XREF: Projectile_ViblackChainMain+132   j
                cmpi.w  #$100,d2
                bpl.w Projectile_ViblackChainAdjustY
loc_44610:                              ; CODE XREF: Projectile_ViblackChainMain+158   j
                addq.w  #8,6(a5)
                rts
; ---------------------------------------------------------------------------
loc_44616:                              ; CODE XREF: Projectile_ViblackChainMain+12E   j
                cmpi.w  #$FF00,d2
                bmi.w   loc_44610
; Adjusts Y velocity for chain projectile
Projectile_ViblackChainAdjustY:                              ; CODE XREF: Projectile_ViblackChainMain+14A   j  ; was: loc_4461E
                subq.w  #8,6(a5)
locret_44622:                           ; CODE XREF: Projectile_ViblackChainMain+124   j
                rts
; End of function Projectile_ViblackChainMain
; ---------------------------------------------------------------------------
word_44624:     dc.w $10, $F0           ; DATA XREF: Projectile_ViblackChainMain+13E   r


; Chain segment handler
Projectile_ViblackChainSegment:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_44628
                tst.w   4(a5)
                beq.s   loc_44648
                cmpi.w  #4,4(a5)
                beq.s   loc_4463E
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_4463E:                              ; CODE XREF: Projectile_ViblackChainSegment+C   j
                subq.w  #1,6(a5)
                bmi.w   loc_444F6
                rts
; ---------------------------------------------------------------------------
loc_44648:                              ; CODE XREF: Projectile_ViblackChainSegment+4   j
                movea.w 6(a5),a0
                move.w  $4E(a5),d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  $56(a5),$14(a5)
                move.w  $5E(a5),d3
                moveq   #0,d0
                bclr    #$F,d3
                beq.s Projectile_ViblackChainSetGraphics
                move.b  #$10,$20(a5)
                move.w  #$8000,d0
                move.b  #$C0,$21(a5)
; Sets graphics tile and priority for chain
Projectile_ViblackChainSetGraphics:                              ; CODE XREF: Projectile_ViblackChainSegment+40   j  ; was: loc_4467A
                lea     word_4469E(pc),a1
                nop
                move.w  (a1,d3.w),$E(a5)
                or.w    d0,$E(a5)
                move.w  #$7000,d0
                sub.w   $24(a5),d0
                sub.w   d0,$24(a0)
                move.w  #$7000,$24(a5)
                rts
; End of function Projectile_ViblackChainSegment
; ---------------------------------------------------------------------------
word_4469E:     dc.w $6389, $7380, $7392, $7B80, $6B89, $6B80, $6392, $6380
                                        ; DATA XREF: Projectile_ViblackChainMain:loc_44570   o
                                        ; sub_44628:loc_4467A   o


; Main boss handler dispatcher
Boss_BackStringerMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_446AE
                tst.w   4(a5)
                beq.w   loc_44702
                tst.w   8(a5)
                beq.s   loc_44702
                btst    #2,(byte_FF80EC).w
                bne.s   loc_446D4
                btst    #1,(byte_FF80EC).w
                bne.s   loc_446D4
                tst.w   (word_FF8200).w
                beq.w Boss_BackStringerDefeatInit
loc_446D4:                              ; CODE XREF: Boss_BackStringerMain+14   j
                                        ; Boss_BackStringerMain+1C   j
                jsr (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
                btst    #7,2(a5)
                beq.s   loc_44702
                move.w  #$F4F4,$A(a5)
                cmpi.w  #$100,$56(a5)
                bne.s   loc_44702
                move.w  #$F6F4,$A(a5)
loc_44702:                              ; CODE XREF: Boss_BackStringerMain+4   j
                                        ; Boss_BackStringerMain+C   j ...
                move.w  4(a5),d0
                movea.w off_44712(pc,d0.w),a0
                adda.l  #Boss_BackStringerInit,a0
                jmp     (a0)
; End of function Boss_BackStringerMain
; ---------------------------------------------------------------------------
off_44712:      dc.w Boss_BackStringerInit-Boss_BackStringerInit
                                        ; DATA XREF: Boss_BackStringerMain+58   r
                dc.w Boss_BackStringerSpawn-Boss_BackStringerInit
                dc.w Boss_Epsilon1PlayerControl-Boss_BackStringerInit
                dc.w Boss_BackStringer_State0-Boss_BackStringerInit
                dc.w Boss_BackStringer_State1-Boss_BackStringerInit
                dc.w Boss_BackStringer_State2-Boss_BackStringerInit
                dc.w Boss_BackStringer_State3-Boss_BackStringerInit
                dc.w Boss_BackStringer_State4-Boss_BackStringerInit
                dc.w Boss_BackStringer_State5-Boss_BackStringerInit
                dc.w Boss_BackStringer_State6-Boss_BackStringerInit
                dc.w Boss_BackStringer_State7-Boss_BackStringerInit
                dc.w Boss_BackStringer_State9-Boss_BackStringerInit
                dc.w Boss_BackStringer_SpawnDrops-Boss_BackStringerInit
                dc.w Boss_BackStringer_State13-Boss_BackStringerInit
                dc.w Boss_BackStringer_State15-Boss_BackStringerInit
                dc.w Boss_BackStringerDiveAttack-Boss_BackStringerInit
                dc.w Boss_BackStringer_State19-Boss_BackStringerInit
                dc.w Boss_BackStringerDiveDelay-Boss_BackStringerInit
                dc.w Boss_BackStringerCheckRotationComplete-Boss_BackStringerInit
                dc.w Boss_BackStringerCheckRotationStart-Boss_BackStringerInit
                dc.w Boss_BackStringerDefeatFadeOut-Boss_BackStringerInit
                dc.w Boss_BackStringer_State23-Boss_BackStringerInit
                dc.w Boss_BackStringer_State24-Boss_BackStringerInit


; Initial state waiting for start
Boss_BackStringerInit:                              ; DATA XREF: Boss_BackStringerMain+5C   o  ; was: sub_44740
                                        ; ROM:off_44712   o ...
                clr.w   8(a5)
                tst.w   (word_FFF720).w
                bmi.s   locret_44758
                addq.w  #2,4(a5)
                move.b  #$8C,d0
                jsr (Input_CheckButtonMode).l
locret_44758:                           ; CODE XREF: Boss_BackStringerInit+8   j
                rts
; End of function Boss_BackStringerInit
; Boss initialization with metasprite setup
Boss_BackStringerSpawn:                              ; DATA XREF: ROM:00044714   o  ; was: sub_4475A
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$8300,(dword_FF8040).w
                moveq   #$14,d7
                movea.l #off_3516C,a0
                movea.l #word_351C0,a1
                movea.l #word_351D6,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.w  #$314,(a5)
                move.w  #$8D00,2(a5)
                clr.w   6(a5)
                move.w  #$C000,$62(a5)
                move.w  #$C000,$C2(a5)
                move.b  #1,d0
                move.b  #3,d1
                move.b  #2,d2
                movea.w a5,a0
                moveq   #5,d7
loc_447AA:                              ; CODE XREF: Boss_BackStringerSpawn+60   j
                or.b    d0,$140(a0)
                or.b    d1,$1A0(a0)
                or.b    d2,$200(a0)
                lea     $120(a0),a0
                dbf     d7,loc_447AA
                bsr.w Boss_BackStringerInitProjectileSlots
                movea.l #word_1BDC0,a1
                jsr (Sprite_InitFromPointerTable).l
                move.w  #2,$1DE(a5)
                bra.w Boss_BackStringerAttackStateMachine
; End of function Boss_BackStringerSpawn
; Initializes Epsilon1 boss position state
Boss_Epsilon1Initialize:                              ; CODE XREF: Boss_Epsilon1PlayerControl+8   j  ; was: sub_447D8
                move.w  #4,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$110,$14(a5)
                clr.b   (byte_FF80EC).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                bra.w Boss_BackStringerResetBodySegments
; End of function Boss_Epsilon1Initialize
; Handles player input for Epsilon1 boss movement
Boss_Epsilon1PlayerControl:                              ; DATA XREF: ROM:00044716   o  ; was: sub_447FA
                btst    #6,(word_FFF708).w
                beq.s   loc_44806
                bra.w Boss_Epsilon1Initialize
; ---------------------------------------------------------------------------
loc_44806:                              ; CODE XREF: Boss_Epsilon1PlayerControl+6   j
                btst    #5,(word_FFF708).w
                beq.s   loc_44812
                bsr.w Boss_BackStringerRetractSegments
loc_44812:                              ; CODE XREF: Boss_Epsilon1PlayerControl+12   j
                btst    #0,(word_FFF706).w
                beq.s   loc_44822
                subi.l  #$10000,$2FC(a5)
loc_44822:                              ; CODE XREF: Boss_Epsilon1PlayerControl+1E   j
                btst    #1,(word_FFF706).w
                beq.s   loc_44832
                addi.l  #$10000,$2FC(a5)
loc_44832:                              ; CODE XREF: Boss_Epsilon1PlayerControl+2E   j
                bsr.w Boss_BackStringerUpdateSegmentPositions
                lea     word_45432(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                move.w  #0,$56(a5)
                bra.w Boss_BackStringerUpdateRender
; End of function Boss_Epsilon1PlayerControl
; Complex multi-phase attack state machine
Boss_BackStringerAttackStateMachine:                              ; CODE XREF: Boss_BackStringerSpawn+7A   j  ; was: sub_4484A
                move.w  #6,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$120,$10(a5)
                move.w  #$1C0,$14(a5)
; Back Stringer boss state 0 initialization
Boss_BackStringer_State0:                              ; DATA XREF: ROM:00044718   o  ; was: loc_44864
                cmpi.w  #$EA,$14(a5)
                bmi.s   loc_4487E
loc_4486C:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+EC   j
                lea     word_4544E(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                bsr.w Boss_BackStringerApplyCircularMotion
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_4487E:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+20   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$140,$11C(a5)
                move.b  #$E5,d0
                jsr (Sound_PlaySFX).l
                move.w  #$1E,(word_FFC624).w
; Back Stringer boss attack pattern 1
Boss_BackStringer_State1:                              ; DATA XREF: ROM:0004471A   o  ; was: loc_448A2
                move.w  #2,(word_FFA010).w
                subq.w  #1,$11C(a5)
                bmi.s   loc_448CC
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                addi.w  #8,d0
                move.w  d0,$B4(a5)
                lea     word_45484(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_448CC:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+62   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$18,$B4(a5)
                move.w  #$30,$11C(a5) ; '0'
; Back Stringer boss missile launch state
Boss_BackStringer_State2:                              ; DATA XREF: ROM:0004471C   o  ; was: loc_448E6
                subq.w  #1,$11C(a5)
                bmi.s   loc_448FA
                lea     word_4549E(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_448FA:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+A0   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Back Stringer boss movement phase
Boss_BackStringer_State3:                              ; DATA XREF: ROM:0004471E   o  ; was: loc_44908
                addq.w  #8,$56(a5)
                andi.w  #$1F8,$56(a5)
                cmpi.w  #$100,$56(a5)
                beq.s   loc_4492C
loc_4491A:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+FE   j
                lea     word_45460(pc),a1
                nop
loc_44920:                              ; CODE XREF: Boss_BackStringerTrackingAttack+12E   j
                bsr.w Boss_BackStringerAnimatePose
                bsr.w Boss_BackStringerApplyCircularMotion
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_4492C:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+CE   j
                addq.w  #2,4(a5)
; Back Stringer boss combo attack
Boss_BackStringer_State4:                              ; DATA XREF: ROM:00044720   o  ; was: loc_44930
                cmpi.w  #$140,$14(a5)
                bmi.w   loc_4486C
                addq.w  #2,4(a5)
; Back Stringer boss rapid fire
Boss_BackStringer_State5:                              ; DATA XREF: ROM:00044722   o  ; was: loc_4493E
                addq.w  #8,$56(a5)
                andi.w  #$1F8,$56(a5)
                bne.w   loc_4491A
                addq.w  #2,4(a5)
                move.w  #$40,$11C(a5) ; '@'
; Back Stringer boss tracking attack
Boss_BackStringer_State6:                              ; DATA XREF: ROM:00044724   o  ; was: loc_44956
                subq.w  #1,$11C(a5)
                bpl.w   loc_449FE
                addq.w  #2,4(a5)
                moveq   #1,d0
                jsr (UI_CheckVictoryCondition).l
; Back Stringer boss special move
Boss_BackStringer_State7:                              ; DATA XREF: ROM:00044726   o  ; was: loc_4496A
                tst.w   (word_FF80C2).w
                bne.w   loc_449FE
                clr.b   (byte_FF80EC).w
                move.w  #7,$41C(a5)
                move.w  #$FFFF,$47C(a5)
                move.w  #4,$47E(a5)
loc_44988:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+324   j
                                        ; Boss_BackStringerDiveDelay+4   j ...
                subq.w  #1,$41C(a5)
                bpl.s   loc_449A8
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                addq.w  #2,d0
                move.w  d0,$41C(a5)
                tst.w   $56(a5)
                bne.w Boss_BackStringerRotateLeft
                bra.w Boss_BackStringerRotateRight
; ---------------------------------------------------------------------------
loc_449A8:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+142   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                addi.w  #$C,d0
                move.w  d0,$11C(a5)
                move.w  #$16,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Back Stringer boss advanced pattern
Boss_BackStringer_State9:                              ; DATA XREF: ROM:00044728   o  ; was: loc_449D0
                bsr.w Projectile_BackStringerSpawnDrops
                subq.w  #1,$11C(a5)
                bpl.s   loc_449F0
                cmpi.w  #$140,(dword_FFC694).w
                bpl.w Boss_BackStringerTrackingAttack
                cmpi.w  #$1600,(word_FF8200).w
                bmi.w Boss_BackStringerTrackingAttack
                bra.s   loc_44A0C
; ---------------------------------------------------------------------------
loc_449F0:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+18E   j
                                        ; Boss_BackStringerDiveDelay+8   j
                lea     word_4549E(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_449FE:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+110   j
                                        ; Boss_BackStringerAttackStateMachine+124   j
                lea     word_4543C(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44A0C:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+1A4   j
                move.w  #$18,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $23E(a5)
                clr.w   $58(a5)
                clr.w   $29C(a5)
                move.w  #$FFFF,$C(a5)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #7,d0
                addq.w  #1,d0
                move.w  d0,$17C(a5)
                cmpi.w  #$90,$10(a5)
                bmi.s   loc_44A54
                cmpi.w  #$1B0,$10(a5)
                bpl.s   loc_44A54
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_44A64
loc_44A54:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+1F6   j
                                        ; Boss_BackStringerAttackStateMachine+1FE   j
                move.w  (word_FF8248).w,d1
                sub.w   $10(a5),d1
                beq.s   loc_44A64
                move.w  d1,$17E(a5)
                bra.s   loc_44A76
; ---------------------------------------------------------------------------
loc_44A64:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+208   j
                                        ; Boss_BackStringerAttackStateMachine+212   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$8000,d0
                move.w  d0,$17E(a5)
                move.w  #0,$17C(a5)
loc_44A76:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+218   j
                tst.w   $56(a5)
                beq.s Boss_BackStringer_SpawnDrops
                neg.w   $17E(a5)
; Spawns projectile drops during attack pattern
Boss_BackStringer_SpawnDrops:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+230   j  ; was: loc_44A80
                                        ; DATA XREF: ROM:0004472A   o
                bsr.w Projectile_BackStringerSpawnDrops
                tst.w   $23E(a5)
                beq.w   loc_44B22
                move.w  #$C9E0,d0
                move.w  #$C8C0,d1
                move.w  $29C(a5),d7
                move.w  (word_FF8248).w,d2
                sub.w   $10(a5),d2
                tst.w   $56(a5)
                beq.s   loc_44AA8
                neg.w   d2
loc_44AA8:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+25A   j
                tst.w   $17E(a5)
                bmi.s   loc_44AB8
                tst.w   d2
                bpl.s   loc_44ABC
loc_44AB2:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+270   j
                neg.w   $17E(a5)
                bra.s   loc_44ABC
; ---------------------------------------------------------------------------
loc_44AB8:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+262   j
                tst.w   d2
                bpl.s   loc_44AB2
loc_44ABC:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+266   j
                                        ; Boss_BackStringerAttackStateMachine+26C   j
                cmpi.w  #1,d7
                bne.s   loc_44AD0
                tst.w   $17E(a5)
                bpl.s   loc_44ACA
                exg     d0,d1
loc_44ACA:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+27C   j
                move.w  d0,$48(a5)
                bra.s   loc_44AE2
; ---------------------------------------------------------------------------
loc_44AD0:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+276   j
                cmpi.w  #3,d7
                bne.s   loc_44AE2
                tst.w   $17E(a5)
                bpl.s   loc_44ADE
                exg     d0,d1
loc_44ADE:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+290   j
                move.w  d1,$48(a5)
loc_44AE2:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+284   j
                                        ; Boss_BackStringerAttackStateMachine+28A   j
                cmpi.w  #1,d7
                bne.s   loc_44B22
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_44AF4
                neg.w   d0
loc_44AF4:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+2A6   j
                tst.w   $56(a5)
                bne.s   loc_44B12
                subq.w  #1,$17C(a5)
                bmi.s   loc_44B30
                cmpi.w  #$30,d0 ; '0'
                bpl.s   loc_44B22
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                beq.s   loc_44B22
                bra.s   loc_44B30
; ---------------------------------------------------------------------------
loc_44B12:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+2AE   j
                subq.w  #2,$17C(a5)
                bmi.w   loc_44BC4
                cmpi.w  #$20,d0 ; ' '
                bmi.w   loc_44BC4
loc_44B22:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+23E   j
                                        ; Boss_BackStringerAttackStateMachine+29C   j ...
                lea     word_454C4(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44B30:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+2B4   j
                                        ; Boss_BackStringerAttackStateMachine+2C6   j
                move.w  #$1A,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CD40,$4A(a5)
                clr.w   $58(a5)
                clr.w   $29C(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$18,$4DC(a5)
; Back Stringer boss transformation
Boss_BackStringer_State13:                              ; DATA XREF: ROM:0004472C   o  ; was: loc_44B54
                bsr.w Gfx_BackStringerUpdatePalette
                tst.w   $4DC(a5)
                bmi.s   loc_44B62
                subq.w  #1,$4DC(a5)
loc_44B62:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+312   j
                tst.w   $58(a5)
                bpl.s   loc_44B72
                move.w  #$13E,$14(a5)
                bra.w   loc_44988
; ---------------------------------------------------------------------------
loc_44B72:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+31C   j
                cmpi.w  #4,$29C(a5)
                bne.s   loc_44B9E
                cmpi.w  #$18,$B4(a5)
                bpl.s   loc_44B86
                addq.w  #1,$B4(a5)
loc_44B86:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+336   j
                cmpi.w  #$1F,$114(a5)
                bpl.s   loc_44B92
                addq.w  #1,$114(a5)
loc_44B92:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+342   j
                tst.w   $23E(a5)
                beq.s   loc_44B9E
                bsr.w Boss_Epsilon1SpawnDualProjectiles
                bra.s   loc_44BB6
; ---------------------------------------------------------------------------
loc_44B9E:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+32E   j
                                        ; Boss_BackStringerAttackStateMachine+34C   j
                cmpi.w  #2,$29C(a5)
                bne.s   loc_44BB6
                btst    #0,(word_FFA000+1).w
                bne.s   loc_44BB6
                subq.w  #1,$B4(a5)
                subq.w  #1,$114(a5)
loc_44BB6:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+352   j
                                        ; Boss_BackStringerAttackStateMachine+35A   j ...
                lea     word_454D6(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44BC4:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+2CC   j
                                        ; Boss_BackStringerAttackStateMachine+2D4   j
                move.w  #$1C,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                clr.w   $29C(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$17C(a5)
; Back Stringer boss final phase
Boss_BackStringer_State15:                              ; DATA XREF: ROM:0004472E   o  ; was: loc_44BE6
                bsr.w Projectile_BackStringerSpawnDrops
                subq.w  #1,$17C(a5)
                bmi.s   loc_44C1A
                move.w  #$18,$B4(a5)
                move.w  #$1F,$114(a5)
                btst    #1,$17D(a5)
                beq.s   loc_44C0C
                subq.w  #2,$B4(a5)
                subq.w  #4,$114(a5)
loc_44C0C:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+3B8   j
                lea     word_454A8(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44C1A:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+3A4   j
                addq.w  #2,4(a5)
                move.w  #$CD40,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$B7,d0
                jsr (Sound_PlaySFX).l
                bsr.w Boss_BackStringerResetBodySegments
; End of function Boss_BackStringerAttackStateMachine
; Executes BackStringer dive attack with vertical movement
