Enemy_BirdFireWrapper:                              ; DATA XREF: ROM:0002DB42   o  ; was: sub_2DBDA
                bsr.w Enemy_BirdFireProjectile
                rts
; End of function Enemy_BirdFireWrapper
; Bird flying state setting animation and timer parameters
Enemy_BirdFlyState:                              ; DATA XREF: ROM:0002DB44   o  ; was: sub_2DBE0
                ori.w   #$8000,2(a5)
                move.w  #8,$5C(a5)
                move.w  #4,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_BirdFlyState
; Checks wall collision and dispatches player action
Player_WallCheckAndDispatch:
                jsr (Physics_EntityWallCheck).l  ; was: sub_2DBF8
                jmp Player_ActionDispatcher
; End of function Player_WallCheckAndDispatch
; Bird dive attack with gravity and ground collision detection
Enemy_BirdDiveAttack:                              ; DATA XREF: ROM:0002DB46   o  ; was: sub_2DC04
                jsr (Physics_EntityWallCheck).l
                move.b  7(a5),$58(a5)
                btst    #7,$1C(a5)
                bne.s   loc_2DC26
                jsr (Player_ActionDispatcher).l
                btst    #0,6(a5)
                bne.s Enemy_BirdTransitionToWait
loc_2DC26:                              ; CODE XREF: Enemy_BirdDiveAttack+12   j
                jsr (Physics_TerrainCheckWithVelocity).l
                addi.l  #$4000,$1C(a5)
                cmpi.l  #$58000,$1C(a5)
                bgt.s   loc_2DC40
                rts
; ---------------------------------------------------------------------------
loc_2DC40:                              ; CODE XREF: Enemy_BirdDiveAttack+38   j
                move.w  #8,$5C(a5)
                addq.w  #8,4(a5)
                rts
; ---------------------------------------------------------------------------
; Transitions bird to waiting state with hover movement
Enemy_BirdTransitionToWait:                              ; CODE XREF: Enemy_BirdDiveAttack+20   j  ; was: loc_2DC4C
                clr.l   $18(a5)
                move.w  #$C,$5C(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_BirdDiveAttack
; Bird waiting state with timer countdown before movement
Enemy_BirdWaitState:                              ; DATA XREF: ROM:0002DB48   o  ; was: sub_2DC62
                move.w  #$C,$5C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_2DC78
                subq.w  #1,$4A(a5)
                beq.s   loc_2DC7A
                addq.w  #2,4(a5)
locret_2DC78:                           ; CODE XREF: Enemy_BirdWaitState+A   j
                rts
; ---------------------------------------------------------------------------
loc_2DC7A:                              ; CODE XREF: Enemy_BirdWaitState+10   j
                move.w  #$C,$5C(a5)
                move.w  #$40,$48(a5) ; '@'
                addq.w  #4,4(a5)
                rts
; End of function Enemy_BirdWaitState
; Bird chases player calculating direction and dive distance
Enemy_BirdChasePlayer:                              ; DATA XREF: ROM:0002DB4A   o  ; was: sub_2DC8C
                jsr (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s   loc_2DCA0
                move.l  #$FFFE0000,$18(a5)
                bra.s   loc_2DCA8
; ---------------------------------------------------------------------------
loc_2DCA0:                              ; CODE XREF: Enemy_BirdChasePlayer+8   j
                move.l  #$20000,$18(a5)
loc_2DCA8:                              ; CODE XREF: Enemy_BirdChasePlayer+12   j
                cmpi.w  #$80,d0
                bcc.s   loc_2DCC2
                move.w  #8,$5C(a5)
                move.l  #$FFFA8000,$1C(a5)
                addq.w  #6,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_2DCC2:                              ; CODE XREF: Enemy_BirdChasePlayer+20   j
                subq.w  #4,4(a5)
                tst.b   $58(a5)
                beq.s   loc_2DCDC
                move.w  #8,$5C(a5)
                move.l  #$FFFB0000,$1C(a5)
                bra.s   locret_2DCEA
; ---------------------------------------------------------------------------
loc_2DCDC:                              ; CODE XREF: Enemy_BirdChasePlayer+3E   j
                move.w  #$10,$5C(a5)
                move.l  #$FFFD8000,$1C(a5)
locret_2DCEA:                           ; CODE XREF: Enemy_BirdChasePlayer+4E   j
                rts
; End of function Enemy_BirdChasePlayer
; Bird enemy wait state timer countdown before state transition
Enemy_BirdWaitTimer:                              ; DATA XREF: ROM:0002DB4C   o  ; was: sub_2DCEC
                subq.w  #1,$48(a5)
                bpl.s   locret_2DCFC
                move.w  #4,$4A(a5)
                subq.w  #2,4(a5)
locret_2DCFC:                           ; CODE XREF: Enemy_BirdWaitTimer+4   j
                rts
; End of function Enemy_BirdWaitTimer
; Bird descends with negative velocity until reaching threshold
Enemy_BirdDescendToThreshold:                              ; DATA XREF: ROM:0002DB4E   o  ; was: sub_2DCFE
                addi.l  #-$4000,$1C(a5)
                cmpi.l  #$FFFA8000,$1C(a5)
                bgt.s   locret_2DD14
                addq.w  #2,4(a5)
locret_2DD14:                           ; CODE XREF: Enemy_BirdDescendToThreshold+10   j
                rts
; End of function Enemy_BirdDescendToThreshold
; Bird accelerates upward with gravity until reaching threshold
Enemy_BirdAccelerate:                              ; DATA XREF: ROM:0002DB50   o  ; was: sub_2DD16
                addi.l  #$4000,$1C(a5)
                cmpi.l  #$28000,$1C(a5)
                blt.s   locret_2DD2C
                addq.w  #2,4(a5)
locret_2DD2C:                           ; CODE XREF: Enemy_BirdAccelerate+10   j
                rts
; End of function Enemy_BirdAccelerate
; Bird decelerates downward with negative gravity and state change
Enemy_BirdDecelerate:                              ; DATA XREF: ROM:0002DB52   o  ; was: sub_2DD2E
                addi.l  #-$4000,$1C(a5)
                cmpi.l  #$FFFE0000,$1C(a5)
                bgt.s   locret_2DD50
                move.w  #$100,$48(a5)
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
locret_2DD50:                           ; CODE XREF: Enemy_BirdDecelerate+10   j
                rts
; End of function Enemy_BirdDecelerate
; Bird attack state with AI movement and projectile firing
Enemy_BirdAttackState:                              ; DATA XREF: ROM:0002DB54   o  ; was: sub_2DD52
                bsr.w Enemy_BirdAITracking
                bsr.w Enemy_BirdFireProjectile
                subq.w  #1,$48(a5)
                bne.s   locret_2DD6A
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
locret_2DD6A:                           ; CODE XREF: Enemy_BirdAttackState+C   j
                rts
; End of function Enemy_BirdAttackState
; Bird ascends with positive velocity until reaching threshold
Enemy_BirdAscendToThreshold:                              ; DATA XREF: ROM:0002DB56   o  ; was: sub_2DD6C
                addi.l  #$4000,$1C(a5)
                cmpi.l  #$20000,$1C(a5)
                blt.s   locret_2DD82
                addq.w  #2,4(a5)
locret_2DD82:                           ; CODE XREF: Enemy_BirdAscendToThreshold+10   j
                rts
; End of function Enemy_BirdAscendToThreshold
; Bird oscillates velocity values for horizontal and vertical movement
Enemy_BirdOscillateMovement:                              ; DATA XREF: ROM:0002DB58   o  ; was: sub_2DD84
                btst    #7,$1C(a5)
                bne.s   loc_2DD94
                addi.l  #-$2000,$1C(a5)
loc_2DD94:                              ; CODE XREF: Enemy_BirdOscillateMovement+6   j
                btst    #7,$18(a5)
                bne.s   loc_2DDA6
                addi.l  #$800,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2DDA6:                              ; CODE XREF: Enemy_BirdOscillateMovement+16   j
                addi.l  #-$800,$18(a5)
                rts
; End of function Enemy_BirdOscillateMovement
; Bird AI tracks player position with velocity adjustments and randomization
Enemy_BirdAITracking:                              ; CODE XREF: Enemy_BirdAttackState   p  ; was: sub_2DDB0
                move.w  (word_FFA000).w,d7
                andi.w  #$1F,d7
                bne.s   loc_2DDDA
                move.b  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                subi.w  #$40,d0 ; '@'
                move.w  d0,$4C(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0 ; '?'
                subi.w  #$20,d0 ; ' '
                move.w  d0,$4E(a5)
loc_2DDDA:                              ; CODE XREF: Enemy_BirdAITracking+8   j
                move.w  (word_FF8248).w,d0
                add.w   $4C(a5),d0
                move.w  (word_FF824A).w,d1
                subi.w  #$60,d1 ; '`'
                add.w   $4E(a5),d1
                sub.w   $10(a5),d0
                beq.s   loc_2DE2E
                tst.w   d0
                bpl.s   loc_2DE14
                subi.l  #$2000,$18(a5)
                cmpi.l  #$FFFE0000,$18(a5)
                bge.s   loc_2DE2E
                move.l  #$FFFE0000,$18(a5)
                bra.s   loc_2DE2E
; ---------------------------------------------------------------------------
loc_2DE14:                              ; CODE XREF: Enemy_BirdAITracking+46   j
                addi.l  #$2000,$18(a5)
                cmpi.l  #$20000,$18(a5)
                ble.s   loc_2DE2E
                move.l  #$20000,$18(a5)
loc_2DE2E:                              ; CODE XREF: Enemy_BirdAITracking+42   j
                                        ; Enemy_BirdAITracking+58   j ...
                sub.w   $14(a5),d1
                beq.s   locret_2DE6E
                tst.w   d1
                bpl.s   loc_2DE54
                subi.l  #$4000,$1C(a5)
                cmpi.l  #$FFFE0000,$1C(a5)
                bge.s   locret_2DE6E
                move.l  #$FFFE0000,$1C(a5)
                bra.s   locret_2DE6E
; ---------------------------------------------------------------------------
loc_2DE54:                              ; CODE XREF: Enemy_BirdAITracking+86   j
                addi.l  #$4000,$1C(a5)
                cmpi.l  #$20000,$1C(a5)
                ble.s   locret_2DE6E
                move.l  #$20000,$1C(a5)
locret_2DE6E:                           ; CODE XREF: Enemy_BirdAITracking+82   j
                                        ; Enemy_BirdAITracking+98   j ...
                rts
; End of function Enemy_BirdAITracking
; Spawns bird projectile with direction
Enemy_BirdFireProjectile:                              ; CODE XREF: Enemy_BirdFireWrapper   p  ; was: sub_2DE70
                                        ; Enemy_BirdAttackState+4   p
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   locret_2DEC6
                jsr (Projectile_UpdateTrajectory).l
                move.w  #$2BC,(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.w  $14(a5),$14(a0)
                addi.w  #4,$14(a0)
                move.w  $10(a5),$10(a0)
                btst    #7,$18(a5)
                beq.s   loc_2DEB8
                move.l  #$2000,$18(a0)
                addi.w  #$10,$10(a0)
                rts
; ---------------------------------------------------------------------------
loc_2DEB8:                              ; CODE XREF: Enemy_BirdFireProjectile+36   j
                move.l  #$FFFFE000,$18(a0)
                addi.w  #-$10,$10(a0)
locret_2DEC6:                           ; CODE XREF: Enemy_BirdFireProjectile+8   j
                rts
; End of function Enemy_BirdFireProjectile
; Bird enemy bounces off with reversed velocity after hit
Enemy_BirdBounceOff:                              ; CODE XREF: Enemy_BirdMain+A   j  ; was: sub_2DEC8
                                        ; Enemy_BirdMain+12   j ...
                clr.w   4(a5)
                move.w  #$1DC,(a5)
                move.l  $18(a5),d0
                neg.l   d0
                move.l  d0,$18(a5)
                move.l  #$FFFD8000,$1C(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $23(a5)
                move.w  #4,$4A(a5)
                move.w  #8,$5C(a5)
                bra.w Enemy_UpdateBirdAnimation
; End of function Enemy_BirdBounceOff
; Bird spawns projectiles with gravity and explosion effect
Enemy_BirdProjectileSpawn:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2DEFE
                bsr.w Enemy_ToggleSpriteVisibility
                addi.l  #$2000,$1C(a5)
                tst.w   4(a5)
                bne.s   loc_2DF1A
                tst.w   $1C(a5)
                bmi.s   loc_2DF1A
                addq.w  #2,4(a5)
loc_2DF1A:                              ; CODE XREF: Enemy_BirdProjectileSpawn+10   j
                                        ; Enemy_BirdProjectileSpawn+16   j
                move.w  (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   locret_2DF7C
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2DF7C
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E953C,8(a0)
                jsr (Sprite_InitializeProperties).l
                subq.w  #1,$4A(a5)
                bne.s   locret_2DF7C
                moveq   #2,d0
                moveq   #4,d1
                movea.l #off_E953C,a1
                jsr (Projectile_SpawnMultiPattern).l
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                cmpi.w  #$1B8,(word_FFDB20).w
                beq.s   loc_2DF76
                moveq   #7,d0
                jmp Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2DF76:                              ; CODE XREF: Enemy_BirdProjectileSpawn+6E   j
                bset    #4,2(a5)
locret_2DF7C:                           ; CODE XREF: Enemy_BirdProjectileSpawn+24   j
                                        ; Enemy_BirdProjectileSpawn+2C   j ...
                rts
; End of function Enemy_BirdProjectileSpawn
; Main dispatcher for Stage 10 fly enemy
Enemy_Stage10FlyMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2DF7E
                move.w  4(a5),d0
                lea     off_2DF8A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage10FlyMain
; ---------------------------------------------------------------------------
off_2DF8A:      dc.w Enemy_Stage10FlyInit-*        ; DATA XREF: Enemy_Stage10FlyMain+4   o
                dc.w Enemy_Stage10FlyInit_GravityAccel-*


; Initializes Stage 10 fly enemy with physics
Enemy_Stage10FlyInit:                              ; DATA XREF: ROM:off_2DF8A   o  ; was: sub_2DF8E
                move.w  #$8F00,2(a5)
                move.w  #$44C8,$E(a5)
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                move.b  #$80,$21(a5)
                move.b  #$80,$23(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F808F808,$28(a5)
                addq.w  #2,4(a5)
                cmpi.w  #$1B8,(word_FFDB20).w
                bne.s Enemy_Stage10FlyInit_GravityAccel
                ori.w   #$8000,$E(a5)
; Applies gravity acceleration to projectile movement
Enemy_Stage10FlyInit_GravityAccel:                              ; CODE XREF: Enemy_Stage10FlyInit+3E   j  ; was: loc_2DFD4
                                        ; DATA XREF: ROM:0002DF8C   o
                addi.l  #$2000,$1C(a5)
                bclr    #6,$22(a5)
                bne.s   loc_2E032
                bclr    #7,$22(a5)
                bne.s   loc_2E032
                cmpi.w  #$1B8,(word_FFDB20).w
                bne.s   loc_2E024
                move.w  (dword_FFDB34).w,d0
                subq.w  #8,d0
                cmp.w   $14(a5),d0
                bhi.s   loc_2E018
                move.w  (dword_FFDB30).w,d0
                cmp.w   $10(a5),d0
                bhi.s   loc_2E018
                move.w  (dword_FFDB30).w,d0
                addi.w  #$100,d0
                cmp.w   $10(a5),d0
                bcc.s   loc_2E032
loc_2E018:                              ; CODE XREF: Enemy_Stage10FlyInit+70   j
                                        ; Enemy_Stage10FlyInit+7A   j
                cmpi.w  #$150,$14(a5)
                blt.s   locret_2E046
                bra.w   loc_2E416
; ---------------------------------------------------------------------------
loc_2E024:                              ; CODE XREF: Enemy_Stage10FlyInit+64   j
                moveq   #0,d0
                moveq   #0,d1
                jsr (Collision_InitBufferPointers).l
                move.w  d2,d2
                beq.s   locret_2E046
loc_2E032:                              ; CODE XREF: Enemy_Stage10FlyInit+54   j
                                        ; Enemy_Stage10FlyInit+5C   j ...
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$C8,$26(a5)
                jmp Projectile_CheckLifetime
; ---------------------------------------------------------------------------
locret_2E046:                           ; CODE XREF: Enemy_Stage10FlyInit+90   j
                                        ; Enemy_Stage10FlyInit+A2   j
                rts
; End of function Enemy_Stage10FlyInit
; Initializes Stage 10 wasp enemy sprite
Enemy_Stage10WaspInit:                              ; CODE XREF: Enemy_Stage10WaspState1+2   p  ; was: sub_2E048
                move.w  #$EF00,2(a5)
                move.w  (word_FF8278).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.b  #$48,$20(a5) ; 'H'
                move.b  #$C0,$21(a5)
                move.l  #$FC04FC04,$2C(a5)
                move.l  #$F010F010,$28(a5)
                lea     word_2E096(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_Stage10WaspInit
; ---------------------------------------------------------------------------
word_2E096:     dc.w $1806, $1100       ; DATA XREF: Enemy_Stage10WaspInit+2E   o


; Updates animation frame from table
Enemy_UpdateAnimationFrame:                              ; CODE XREF: Enemy_Stage10WaspMain+58   p  ; was: sub_2E09A
                move.w  $5C(a5),d0
                beq.s   locret_2E0AC
                subq.w  #4,d0
                move.l  off_2E0AE(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2E0AC:                           ; CODE XREF: Enemy_UpdateAnimationFrame+4   j
                rts
; End of function Enemy_UpdateAnimationFrame
; ---------------------------------------------------------------------------
off_2E0AE:      dc.l off_EB278          ; DATA XREF: Enemy_UpdateAnimationFrame+8   r
                dc.l off_EB294
                dc.l off_EB2B4
                dc.l off_EB2CC


; Main handler for Stage 10 wasp enemy
Enemy_Stage10WaspMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E0BE
                tst.w   4(a5)
                beq.s Enemy_WaspMainLoop
                tst.w   $24(a5)
                bmi.w Enemy_Stage10WaspDeath
                tst.w   (word_FF808C).w
                bpl.w Enemy_Stage10WaspDeath
                bclr    #7,$22(a5)
                beq.s   loc_2E10A
                btst    #4,$22(a5)
                bne.w Enemy_Stage10WaspDeath
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E953C,8(a5)
                clr.w   $C(a5)
                jmp Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_2E10A:                              ; CODE XREF: Enemy_Stage10WaspMain+1C   j
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Main loop for wasp enemy dispatching state and updating animation
Enemy_WaspMainLoop:                              ; CODE XREF: Enemy_Stage10WaspMain+4   j  ; was: loc_2E114
                bsr.s Enemy_Stage10WaspDispatcher
                bsr.w Enemy_UpdateAnimationFrame
                bra.w Enemy_UpdateSpriteFlip
; End of function Enemy_Stage10WaspMain
; State dispatcher for wasp enemy
Enemy_Stage10WaspDispatcher:                              ; CODE XREF: Enemy_Stage10WaspMain:loc_2E114   p  ; was: sub_2E11E
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2E12E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage10WaspDispatcher
; ---------------------------------------------------------------------------
off_2E12E:      dc.w Enemy_Stage10WaspState1-*        ; DATA XREF: Enemy_Stage10WaspDispatcher+8   o
                dc.w Enemy_Stage10WaspState2-*
                dc.w Enemy_Stage10WaspState3-*
                dc.w Enemy_Stage10WaspState4-*
                dc.w Enemy_Stage10WaspState5-*
                dc.w Enemy_WaspLoopTimer-*


; Wasp state 1 initialization
Enemy_Stage10WaspState1:                              ; DATA XREF: ROM:off_2E12E   o  ; was: sub_2E13A
                moveq   #0,d0
                bsr.w Enemy_Stage10WaspInit
                move.w  #$C,$5C(a5)
                addq.w  #2,4(a5)
                move.w  #3,$4A(a5)
                move.w  #3,$4C(a5)
                btst    #0,$5F(a5)
                bne.s   loc_2E166
                move.w  #$1E0,$10(a5)
                rts
; ---------------------------------------------------------------------------
loc_2E166:                              ; CODE XREF: Enemy_Stage10WaspState1+22   j
                move.w  #$70,$10(a5) ; 'p'
                rts
; End of function Enemy_Stage10WaspState1
; Wasp state 2 flight with physics
Enemy_Stage10WaspState2:                              ; DATA XREF: ROM:0002E130   o  ; was: sub_2E16E
                jsr (Physics_EntityWallCheck).l
                btst    #7,$1C(a5)
                bne.s   loc_2E18A
                jsr (Player_ActionDispatcher).l
                btst    #0,6(a5)
                bne.s Enemy_WaspTransitionToWait
loc_2E18A:                              ; CODE XREF: Enemy_Stage10WaspState2+C   j
                jsr (Physics_TerrainCheckWithVelocity).l
                addi.l  #$4000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
; Transitions wasp to waiting state with hover configuration
Enemy_WaspTransitionToWait:                              ; CODE XREF: Enemy_Stage10WaspState2+1A   j  ; was: loc_2E19A
                clr.l   $18(a5)
                move.w  #$10,$5C(a5)
                move.w  #$A,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage10WaspState2
; Wasp state 3 delay timer
Enemy_Stage10WaspState3:                              ; DATA XREF: ROM:0002E132   o  ; was: sub_2E1B0
                subq.w  #1,$48(a5)
                bne.s   locret_2E1C6
                tst.w   $4C(a5)
                beq.s   loc_2E1C2
                subq.w  #1,$4A(a5)
                beq.s   loc_2E1C8
loc_2E1C2:                              ; CODE XREF: Enemy_Stage10WaspState3+A   j
                addq.w  #2,4(a5)
locret_2E1C6:                           ; CODE XREF: Enemy_Stage10WaspState3+4   j
                rts
; ---------------------------------------------------------------------------
loc_2E1C8:                              ; CODE XREF: Enemy_Stage10WaspState3+10   j
                move.w  #4,$5C(a5)
                move.w  #$20,$48(a5) ; ' '
                addq.w  #6,4(a5)
                rts
; End of function Enemy_Stage10WaspState3
; Wasp state 4 animation setup
Enemy_Stage10WaspState4:                              ; DATA XREF: ROM:0002E134   o  ; was: sub_2E1DA
                move.w  #8,$5C(a5)
                move.w  #$A,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage10WaspState4
; Wasp state 5 attack dive
Enemy_Stage10WaspState5:                              ; DATA XREF: ROM:0002E136   o  ; was: sub_2E1EC
                subq.w  #1,$48(a5)
                bne.s   locret_2E22A
                subq.w  #6,4(a5)
                jsr (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s   loc_2E20A
                move.l  #$FFFE0000,$18(a5)
                bra.s   loc_2E212
; ---------------------------------------------------------------------------
loc_2E20A:                              ; CODE XREF: Enemy_Stage10WaspState5+12   j
                move.l  #$20000,$18(a5)
loc_2E212:                              ; CODE XREF: Enemy_Stage10WaspState5+1C   j
                move.w  #$C,$5C(a5)
                move.l  #$FFFA0000,$1C(a5)
                tst.w   $4C(a5)
                bne.s   locret_2E22A
                neg.l   $18(a5)
locret_2E22A:                           ; CODE XREF: Enemy_Stage10WaspState5+4   j
                                        ; Enemy_Stage10WaspState5+38   j
                rts
; End of function Enemy_Stage10WaspState5
; Wasp enemy loop timer that decrements counters and loops state
Enemy_WaspLoopTimer:                              ; DATA XREF: ROM:0002E138   o  ; was: sub_2E22C
                subq.w  #1,$48(a5)
                bpl.s   locret_2E240
                subq.w  #1,$4C(a5)
                move.w  #3,$4A(a5)
                subq.w  #4,4(a5)
locret_2E240:                           ; CODE XREF: Enemy_WaspLoopTimer+4   j
                rts
; End of function Enemy_WaspLoopTimer
; Handles wasp enemy death
Enemy_Stage10WaspDeath:                              ; CODE XREF: Enemy_Stage10WaspMain+A   j  ; was: sub_2E242
                                        ; Enemy_Stage10WaspMain+12   j ...
                move.w  #$2C4,(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #off_EB2B4,8(a5)
                clr.w   $C(a5)
                move.w  #$10,$48(a5)
                move.l  #$FFFB2000,$1C(a5)
                move.l  #$FFFEA000,$18(a5)
                btst    #3,$E(a5)
                beq.s   locret_2E280
                neg.l   $18(a5)
locret_2E280:                           ; CODE XREF: Enemy_Stage10WaspDeath+38   j
                rts
; End of function Enemy_Stage10WaspDeath
; Wasp explosion with gravity and sound
Enemy_Stage10WaspExplode:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E282
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_2E2A8
                jsr (Projectile_ExplodeWithSound).l
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                moveq   #7,d0
                jmp Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2E2A8:                              ; CODE XREF: Enemy_Stage10WaspExplode+C   j
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2E2BC
                bclr    #7,2(a5)
locret_2E2BC:                           ; CODE XREF: Enemy_Stage10WaspExplode+32   j
                rts
; End of function Enemy_Stage10WaspExplode
; Initializes Stage 12 floater enemy
Enemy_Stage12FloaterInit:                              ; CODE XREF: Enemy_Stage12FloaterAttack+2   p  ; was: sub_2E2BE
                                        ; Enemy_Stage12LauncherWait+2   p
                move.w  #$EF00,2(a5)
                moveq   #0,d1
                ori.w   #$8000,d1
                move.w  d1,$E(a5)
                move.b  #$10,$20(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F808F808,$28(a5)
                lea     word_2E304(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_Stage12FloaterInit
; ---------------------------------------------------------------------------
word_2E304:     dc.w $1804, $1100, $1802, $1100
                                        ; DATA XREF: Enemy_Stage12FloaterInit+26   o


; Main handler for floater enemy
Enemy_Stage12FloaterMain:                              ; CODE XREF: Enemy_Stage12FloaterDispatcher+2C   j  ; was: sub_2E30C
                                        ; Enemy_Stage12LauncherDispatcher+2C   j
                move.w  $5C(a5),d0
                beq.s   locret_2E31E
                subq.w  #4,d0
                move.l  off_2E320(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2E31E:                           ; CODE XREF: Enemy_Stage12FloaterMain+4   j
                rts
; End of function Enemy_Stage12FloaterMain
; ---------------------------------------------------------------------------
off_2E320:      dc.l off_1A0F1A         ; DATA XREF: Enemy_Stage12FloaterMain+8   r
                dc.l off_1A0F2E


; State dispatcher for floater
Enemy_Stage12FloaterDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E328
                tst.w   4(a5)
                beq.s   loc_2E352
                tst.w   $24(a5)
                bmi.w Enemy_Stage12LauncherMain
                tst.w   (word_FF808C).w
                bpl.w Enemy_Stage12LauncherMain
                bclr    #7,$22(a5)
                bne.w Enemy_Stage12LauncherMain
                jsr     (RandomNumber).l
                clr.w   6(a5)
loc_2E352:                              ; CODE XREF: Enemy_Stage12FloaterDispatcher+4   j
                bsr.s Enemy_Stage12FloaterState1
                bra.w Enemy_Stage12FloaterMain
; End of function Enemy_Stage12FloaterDispatcher
; Floater state 1 movement
Enemy_Stage12FloaterState1:                              ; CODE XREF: Enemy_Stage12FloaterDispatcher:loc_2E352   p  ; was: sub_2E358
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2E368(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage12FloaterState1
; ---------------------------------------------------------------------------
off_2E368:      dc.w Enemy_Stage12FloaterAttack-*        ; DATA XREF: Enemy_Stage12FloaterState1+8   o
                dc.w Enemy_Stage12FloaterAttack_CheckDistance-*
                dc.w Enemy_Stage12FloaterCheckBounds-*
                dc.w Enemy_Stage12FloaterFall-*
                dc.w Enemy_FallUntilOffscreen-*
                dc.w nullsub_67-*
                dc.w nullsub_68-*


; Floater attack with projectile
Enemy_Stage12FloaterAttack:                              ; DATA XREF: ROM:off_2E368   o  ; was: sub_2E376
                moveq   #0,d0
                bsr.w Enemy_Stage12FloaterInit
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
; Calculates distance to player and initiates dive attack when close enough
Enemy_Stage12FloaterAttack_CheckDistance:                              ; DATA XREF: ROM:0002E36A   o  ; was: loc_2E386
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$60,d0 ; '`'
                bcc.w   locret_2E3A0
                move.l  #$FFFE0000,$1C(a5)
                addq.w  #2,4(a5)
locret_2E3A0:                           ; CODE XREF: Enemy_Stage12FloaterAttack+1A   j
                rts
; End of function Enemy_Stage12FloaterAttack
; Checks if floater reached Y bound
Enemy_Stage12FloaterCheckBounds:                              ; DATA XREF: ROM:0002E36C   o  ; was: sub_2E3A2
                cmpi.w  #$150,$14(a5)
                bcc.s   locret_2E3AE
                addq.w  #2,4(a5)
locret_2E3AE:                           ; CODE XREF: Enemy_Stage12FloaterCheckBounds+6   j
                rts
; End of function Enemy_Stage12FloaterCheckBounds
; Floater falling state with collision
Enemy_Stage12FloaterFall:                              ; DATA XREF: ROM:0002E36E   o  ; was: sub_2E3B0
                moveq   #0,d0
                moveq   #0,d1
                jsr (Collision_InitBufferPointers).l
                tst.w   d2
                bne.s   locret_2E3F2
                addq.w  #2,4(a5)
                move.b  #$C0,$21(a5)
                move.l  #$FFFB8000,$1C(a5)
                move.w  #8,$5C(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                add.w   d0,d0
                lea     (word_1B514).l,a1
                move.w  (a1,d0.w),d0
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a5)
locret_2E3F2:                           ; CODE XREF: Enemy_Stage12FloaterFall+C   j
                rts
; End of function Enemy_Stage12FloaterFall
; Entity falls with gravity until offscreen then transitions to explosion
Enemy_FallUntilOffscreen:                              ; DATA XREF: ROM:0002E370   o  ; was: sub_2E3F4
                                        ; ROM:0002E630   o
                addi.l  #$2000,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_2E414
                ori.w   #$1000,$E(a5)
                cmpi.w  #$150,$14(a5)
                blt.s   locret_2E414
                bra.s   loc_2E416
; ---------------------------------------------------------------------------
locret_2E414:                           ; CODE XREF: Enemy_FallUntilOffscreen+E   j
                                        ; Enemy_FallUntilOffscreen+1C   j
                rts
; ---------------------------------------------------------------------------
loc_2E416:                              ; CODE XREF: Enemy_Stage10FlyInit+92   j
                                        ; Enemy_FallUntilOffscreen+1E   j ...
                movea.w a5,a0
                jsr (Enemy_GetEntityAddress).l
                move.l  #off_1A0E96,8(a5)
                move.w  #$C000,$E(a5)
                move.l  #$FFFD8000,$1C(a5)
                rts
; End of function Enemy_FallUntilOffscreen
nullsub_67:                             ; DATA XREF: ROM:0002E372   o
                                        ; ROM:0002E632   o
                rts
; End of function nullsub_67


nullsub_68:                             ; DATA XREF: ROM:0002E374   o
                rts
; End of function nullsub_68


; Main handler for launcher enemy
Enemy_Stage12LauncherMain:                              ; CODE XREF: Enemy_Stage12FloaterDispatcher+A   j  ; was: sub_2E43A
                                        ; Enemy_Stage12FloaterDispatcher+12   j ...
                tst.w   $24(a5)
                bmi.s   loc_2E46C
                btst    #4,$22(a5)
                bne.s   loc_2E46C
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                move.l  #off_E953C,8(a5)
                clr.w   $C(a5)
                jmp Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_2E46C:                              ; CODE XREF: Enemy_Stage12LauncherMain+4   j
                                        ; Enemy_Stage12LauncherMain+C   j
                clr.w   4(a5)
                move.w  #$2D0,(a5)
                move.w  #$10,$48(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #$FFFB8000,$1C(a5)
                rts
; End of function Enemy_Stage12LauncherMain
; Launcher explosion with flicker
Enemy_Stage12LauncherExplode:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E490
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_2E4C6
                jsr (Projectile_ExplodeWithSound).l
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                cmpi.w  #$1B8,(word_FFDB20).w
                beq.s   loc_2E4BE
                moveq   #$F,d0
                jmp Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2E4BE:                              ; CODE XREF: Enemy_Stage12LauncherExplode+24   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2E4C6:                              ; CODE XREF: Enemy_Stage12LauncherExplode+C   j
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2E4DA
                bclr    #7,2(a5)
locret_2E4DA:                           ; CODE XREF: Enemy_Stage12LauncherExplode+42   j
                rts
; End of function Enemy_Stage12LauncherExplode
; Main handler for turret enemy
Enemy_Stage12TurretMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E4DC
                tst.w   (word_FF808C).w
                bpl.w Enemy_Stage12TurretHide
                bsr.s Enemy_Stage12TurretDispatcher
                move.l  (dword_FFDB30).w,$10(a5)
                move.l  (dword_FFDB34).w,$14(a5)
                cmpi.w  #4,4(a5)
                bcc.w Enemy_Stage12TurretFire
                rts
; End of function Enemy_Stage12TurretMain
; State dispatcher for turret
Enemy_Stage12TurretDispatcher:                              ; CODE XREF: Enemy_Stage12TurretMain+8   p  ; was: sub_2E4FE
                move.w  4(a5),d0
                lea     off_2E50A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage12TurretDispatcher
; ---------------------------------------------------------------------------
off_2E50A:      dc.w Enemy_Stage12TurretInit-*        ; DATA XREF: Enemy_Stage12TurretDispatcher+4   o
                dc.w Enemy_Stage12TurretIdle-*
                dc.w Enemy_Stage12TurretAttack-*
                dc.w Enemy_Stage12TurretReload-*
                dc.w Enemy_Stage12TurretCheckPlayer-*
                dc.w Enemy_Stage12TurretDefeat-*
                dc.w Enemy_Stage12TurretExplode-*


; Initializes turret sprite
Enemy_Stage12TurretInit:                              ; DATA XREF: ROM:off_2E50A   o  ; was: sub_2E518
                move.w  #$D00,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage12TurretInit
; Turret idle state
Enemy_Stage12TurretIdle:                              ; DATA XREF: ROM:0002E50C   o  ; was: sub_2E524
                cmpi.w  #$1B8,(word_FFDB20).w
                bne.s   locret_2E53E
                cmpi.w  #6,(word_FFDB24).w
                bcs.s   locret_2E53E
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
locret_2E53E:                           ; CODE XREF: Enemy_Stage12TurretIdle+6   j
                                        ; Enemy_Stage12TurretIdle+E   j
                rts
; End of function Enemy_Stage12TurretIdle
; Turret attack state
Enemy_Stage12TurretAttack:                              ; DATA XREF: ROM:0002E50E   o  ; was: sub_2E540
                subq.w  #1,$48(a5)
                bne.s   locret_2E54A
                addq.w  #2,4(a5)
locret_2E54A:                           ; CODE XREF: Enemy_Stage12TurretAttack+4   j
                rts
; End of function Enemy_Stage12TurretAttack
; Turret reload delay
Enemy_Stage12TurretReload:                              ; DATA XREF: ROM:0002E510   o  ; was: sub_2E54C
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2E560
                move.w  #$10,(a0)
                move.w  a0,$4A(a5)
                addq.w  #2,4(a5)
locret_2E560:                           ; CODE XREF: Enemy_Stage12TurretReload+6   j
                rts
; End of function Enemy_Stage12TurretReload
; Checks player position for firing
Enemy_Stage12TurretCheckPlayer:                              ; DATA XREF: ROM:0002E512   o  ; was: sub_2E562
                cmpi.w  #$140,$14(a5)
                bcs.s   locret_2E58C
                movea.w $4A(a5),a0
                move.w  #$2E4,(a0)
                addq.w  #2,4(a5)
                move.w  #$38,$4E(a0) ; '8'
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$50,d0 ; 'P'
                move.w  d0,$4C(a0)
locret_2E58C:                           ; CODE XREF: Enemy_Stage12TurretCheckPlayer+6   j
                rts
; End of function Enemy_Stage12TurretCheckPlayer
; Turret defeat sequence
Enemy_Stage12TurretDefeat:                              ; DATA XREF: ROM:0002E514   o  ; was: sub_2E58E
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage12TurretDefeat
; Turret explosion effect
Enemy_Stage12TurretExplode:                              ; DATA XREF: ROM:0002E516   o  ; was: sub_2E59A
                subq.w  #1,$48(a5)
                bne.s   locret_2E5A6
                move.w  #6,4(a5)
locret_2E5A6:                           ; CODE XREF: Enemy_Stage12TurretExplode+4   j
                rts
; End of function Enemy_Stage12TurretExplode
; Turret fires projectile
Enemy_Stage12TurretFire:                              ; CODE XREF: Enemy_Stage12TurretMain+1C   j  ; was: sub_2E5A8
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                bne.s   loc_2E5BE
                move.w  (word_FFA000).w,d7
                andi.w  #$FF,d7
                bne.s   locret_2E5E0
                bra.s   loc_2E5C8
; ---------------------------------------------------------------------------
loc_2E5BE:                              ; CODE XREF: Enemy_Stage12TurretFire+8   j
                move.w  (word_FFA000).w,d7
                andi.w  #$1FF,d7
                bne.s   locret_2E5E0
loc_2E5C8:                              ; CODE XREF: Enemy_Stage12TurretFire+14   j
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2E5E0
                move.w  #$90,(a0)
                move.w  #1,$5E(a0)
                move.w  #$B0,$14(a0)
locret_2E5E0:                           ; CODE XREF: Enemy_Stage12TurretFire+12   j
                                        ; Enemy_Stage12TurretFire+1E   j ...
                rts
; End of function Enemy_Stage12TurretFire
; Hides turret enemy
Enemy_Stage12TurretHide:                              ; CODE XREF: Enemy_Stage12TurretMain+4   j  ; was: sub_2E5E2
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_Stage12TurretHide
; State dispatcher for launcher
Enemy_Stage12LauncherDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E5EA
                tst.w   4(a5)
                beq.s   loc_2E614
                tst.w   $24(a5)
                bmi.w Enemy_Stage12LauncherMain
                tst.w   (word_FF808C).w
                bpl.w Enemy_Stage12LauncherMain
                bclr    #7,$22(a5)
                bne.w Enemy_Stage12LauncherMain
                jsr     (RandomNumber).l
                clr.w   6(a5)
loc_2E614:                              ; CODE XREF: Enemy_Stage12LauncherDispatcher+4   j
                bsr.s Enemy_Stage12LauncherInit
                bra.w Enemy_Stage12FloaterMain
; End of function Enemy_Stage12LauncherDispatcher
; Initializes launcher sprite
Enemy_Stage12LauncherInit:                              ; CODE XREF: Enemy_Stage12LauncherDispatcher:loc_2E614   p  ; was: sub_2E61A
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2E62A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage12LauncherInit
; ---------------------------------------------------------------------------
off_2E62A:      dc.w Enemy_Stage12LauncherWait-*        ; DATA XREF: Enemy_Stage12LauncherInit+8   o
                dc.w Enemy_Stage12LauncherWait_UpdateLoop-*
                dc.w Enemy_LauncherPrepareShot-*
                dc.w Enemy_FallUntilOffscreen-*
                dc.w nullsub_67-*


; Launcher wait state with position update
Enemy_Stage12LauncherWait:                              ; DATA XREF: ROM:off_2E62A   o  ; was: sub_2E634
                moveq   #4,d0
                bsr.w Enemy_Stage12FloaterInit
                move.b  #0,$20(a5)
                move.b  #$80,$21(a5)
                move.b  #$40,$23(a5) ; '@'
                move.w  #$ED00,2(a5)
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
; Update launcher position while waiting for timer
Enemy_Stage12LauncherWait_UpdateLoop:                              ; DATA XREF: ROM:0002E62C   o  ; was: loc_2E65C
                bsr.w Enemy_Stage12LauncherUpdatePosition
                subq.w  #1,$4E(a5)
                bne.s   locret_2E670
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
locret_2E670:                           ; CODE XREF: Enemy_Stage12LauncherWait+30   j
                rts
; End of function Enemy_Stage12LauncherWait
; Updates launcher position relative to ship
Enemy_Stage12LauncherUpdatePosition:                              ; CODE XREF: Enemy_Stage12LauncherWait:loc_2E65C   p  ; was: sub_2E672
                                        ; sub_2E690   p
                move.l  (dword_FFDB30).w,$10(a5)
                move.l  (dword_FFDB34).w,$14(a5)
                move.w  $4C(a5),d0
                add.w   d0,$10(a5)
                move.w  $4E(a5),d0
                add.w   d0,$14(a5)
                rts
; End of function Enemy_Stage12LauncherUpdatePosition
; Stage 12 launcher prepares shot with timer and velocity setup
Enemy_LauncherPrepareShot:                              ; DATA XREF: ROM:0002E62E   o  ; was: sub_2E690
                bsr.w Enemy_Stage12LauncherUpdatePosition
                subq.w  #1,$48(a5)
                bne.s   locret_2E6C0
                ori.b   #$40,$21(a5) ; '@'
                move.w  #$EF00,2(a5)
                move.l  #$FFFB8000,$1C(a5)
                move.w  #8,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                addq.w  #2,4(a5)
locret_2E6C0:                           ; CODE XREF: Enemy_LauncherPrepareShot+8   j
                rts
; End of function Enemy_LauncherPrepareShot
; Main dispatcher for Stage 10 bomber enemy
Enemy_Stage10BomberMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E6C2
                move.w  #$120,$10(a5)
                move.w  #$154,$14(a5)
                move.w  4(a5),d0
                lea     off_2E6DA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage10BomberMain
; ---------------------------------------------------------------------------
off_2E6DA:      dc.w Enemy_Stage10BomberInit-*        ; DATA XREF: Enemy_Stage10BomberMain+10   o
                dc.w Enemy_Stage10BomberSpawn-*
                dc.w Enemy_Stage10BomberWait-*
                dc.w Enemy_Stage10BomberComplete-*


; Initializes Stage 10 bomber sprite
Enemy_Stage10BomberInit:                              ; DATA XREF: ROM:off_2E6DA   o  ; was: sub_2E6E2
                move.w  #$D00,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage10BomberInit
; Spawns bomber projectile at random position
Enemy_Stage10BomberSpawn:                              ; DATA XREF: ROM:0002E6DC   o  ; was: sub_2E6EE
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2E73A
                jsr     (RandomNumber).l
                move.w  a0,$4C(a5)
                addq.w  #2,4(a5)
                move.w  #$2D4,(a0)
                move.w  $14(a5),$14(a0)
                move.w  $5E(a5),$5E(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                add.w   d0,$14(a0)
                move.b  (dword_FFFF08).w,d0
                andi.b  #1,d0
                beq.s Enemy_BomberSetSpawnX
                move.w  #$1C8,$10(a0)
                rts
; ---------------------------------------------------------------------------
; Sets bomber enemy spawn X position based on random flag
Enemy_BomberSetSpawnX:                              ; CODE XREF: Enemy_Stage10BomberSpawn+3C   j  ; was: loc_2E734
                move.w  #$78,$10(a0) ; 'x'
locret_2E73A:                           ; CODE XREF: Enemy_Stage10BomberSpawn+6   j
                rts
; End of function Enemy_Stage10BomberSpawn
; Waits for spawned projectile destruction
Enemy_Stage10BomberWait:                              ; DATA XREF: ROM:0002E6DE   o  ; was: sub_2E73C
                movea.w $4C(a5),a0
                cmpi.w  #$2D4,(a0)
                beq.s   locret_2E750
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
locret_2E750:                           ; CODE XREF: Enemy_Stage10BomberWait+8   j
                rts
; End of function Enemy_Stage10BomberWait
; Completes bomber sequence
Enemy_Stage10BomberComplete:                              ; DATA XREF: ROM:0002E6E0   o  ; was: sub_2E752
                subq.w  #1,$48(a5)
                bne.s   locret_2E766
                cmpi.w  #$1B8,(word_FFDB20).w
                beq.s   loc_2E768
                move.w  #2,4(a5)
locret_2E766:                           ; CODE XREF: Enemy_Stage10BomberComplete+4   j
                rts
; ---------------------------------------------------------------------------
loc_2E768:                              ; CODE XREF: Enemy_Stage10BomberComplete+C   j
                bset    #4,2(a5)
                rts
; End of function Enemy_Stage10BomberComplete
; Initializes Stage 10 beetle enemy sprite
Enemy_Stage10BeetleInit:                              ; CODE XREF: Enemy_Stage10BeetleState1+2   p  ; was: sub_2E770
                move.w  #$EF00,2(a5)
                moveq   #0,d1
                ori.w   #$8000,d1
                move.w  d1,$E(a5)
                move.b  #0,$20(a5)
                move.b  #$80,$21(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F010F010,$28(a5)
                lea     word_2E7C8(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                move.l  #off_1A0F42,8(a5)
                clr.w   $C(a5)
                rts
; End of function Enemy_Stage10BeetleInit
; ---------------------------------------------------------------------------
word_2E7C8:     dc.w $1804, $1100       ; DATA XREF: Enemy_Stage10BeetleInit+2C   o


; Main handler for Stage 10 beetle enemy
Enemy_Stage10BeetleMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E7CC
                tst.w   4(a5)
                beq.s Enemy_BeetleMainLoop
                tst.w   $24(a5)
                bmi.w Enemy_Stage10BeetleDefeat
                tst.w   (word_FF808C).w
                bpl.w Enemy_Stage10BeetleDefeat
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Main loop for beetle enemy with state dispatch and animation
Enemy_BeetleMainLoop:                              ; CODE XREF: Enemy_Stage10BeetleMain+4   j  ; was: loc_2E7EC
                bsr.s Enemy_Stage10BeetleDispatcher
                bsr.w Enemy_UpdateSpriteFlip
                tst.l   $1C(a5)
                bne.s   locret_2E804
                move.l  #off_1A0F42,8(a5)
                clr.w   $C(a5)
locret_2E804:                           ; CODE XREF: Enemy_Stage10BeetleMain+2A   j
                rts
; End of function Enemy_Stage10BeetleMain
; State dispatcher for beetle enemy
Enemy_Stage10BeetleDispatcher:                              ; CODE XREF: Enemy_Stage10BeetleMain:loc_2E7EC   p  ; was: sub_2E806
                move.w  4(a5),d0
                lea     off_2E812(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage10BeetleDispatcher
; ---------------------------------------------------------------------------
off_2E812:      dc.w Enemy_Stage10BeetleState1-*        ; DATA XREF: Enemy_Stage10BeetleDispatcher+4   o
                dc.w Enemy_BeetleWalkState-*
                dc.w Enemy_Stage10BeetleState2-*
                dc.w Enemy_BeetleFallAndLand-*
                dc.w Enemy_BeetleFallOffscreen-*


; Beetle state 1 initialization with delay
Enemy_Stage10BeetleState1:                              ; DATA XREF: ROM:off_2E812   o  ; was: sub_2E81C
                moveq   #0,d0
                bsr.w Enemy_Stage10BeetleInit
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5) ; '@'
                cmpi.w  #$120,$10(a5)
                bcc.s   loc_2E83C
                move.w  #1,$18(a5)
                bra.s Enemy_BeetleWalkState
; ---------------------------------------------------------------------------
loc_2E83C:                              ; CODE XREF: Enemy_Stage10BeetleState1+16   j
                move.w  #$FFFF,$18(a5)
; Beetle walking state with timer countdown and delay lookup
Enemy_BeetleWalkState:                              ; CODE XREF: Enemy_Stage10BeetleState1+1E   j  ; was: loc_2E842
                                        ; DATA XREF: ROM:0002E814   o
                subq.w  #1,$48(a5)
                bne.s   locret_2E85A
                clr.w   $4C(a5)
                bsr.w Enemy_Stage10BeetleDelayTable
                move.w  #$100,$4E(a5)
                addq.w  #2,4(a5)
locret_2E85A:                           ; CODE XREF: Enemy_Stage10BeetleState1+2A   j
                rts
; End of function Enemy_Stage10BeetleState1
; Beetle state 2 movement pattern
Enemy_Stage10BeetleState2:                              ; DATA XREF: ROM:0002E816   o  ; was: sub_2E85C
                btst    #0,$5F(a5)
                beq.s   loc_2E86A
                subq.w  #1,$4E(a5)
                beq.s   loc_2E892
loc_2E86A:                              ; CODE XREF: Enemy_Stage10BeetleState2+6   j
                subq.w  #1,$48(a5)
                bne.s   locret_2E890
                bsr.w Enemy_Stage10BeetleDelayTable
                move.b  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                add.w   d0,d0
                lea     (word_1B514).l,a1
                move.w  (a1,d0.w),d0
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a5)
locret_2E890:                           ; CODE XREF: Enemy_Stage10BeetleState2+12   j
                rts
; ---------------------------------------------------------------------------
loc_2E892:                              ; CODE XREF: Enemy_Stage10BeetleState2+C   j
                clr.l   $18(a5)
                move.l  #$FFFB8000,$1C(a5)
                move.w  #3,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage10BeetleState2
; Gets delay value from timing table
Enemy_Stage10BeetleDelayTable:                              ; CODE XREF: Enemy_Stage10BeetleState1+30   p  ; was: sub_2E8AA
                                        ; Enemy_Stage10BeetleState2+14   p
                move.w  $4C(a5),d0
                move.w  word_2E8C6(pc,d0.w),$48(a5)
                addq.w  #2,$4C(a5)
                cmpi.w  #$20,$4C(a5) ; ' '
                bcs.s   locret_2E8C4
                clr.w   $4C(a5)
locret_2E8C4:                           ; CODE XREF: Enemy_Stage10BeetleDelayTable+14   j
                rts
; End of function Enemy_Stage10BeetleDelayTable
; ---------------------------------------------------------------------------
word_2E8C6:     dc.w $10, 8, $20, $40, 8, $10, 8, $10, 4, 8, $10, $40, 8, 8, 4, $20
                                        ; DATA XREF: Enemy_Stage10BeetleDelayTable+4   r


; Beetle falls with gravity and lands on terrain with alignment
Enemy_BeetleFallAndLand:                              ; DATA XREF: ROM:0002E818   o  ; was: sub_2E8E6
                addi.l  #$2000,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_2E92A
                cmpi.w  #$150,$14(a5)
                bgt.w   loc_2E416
                moveq   #0,d0
                moveq   #0,d1
                jsr (Collision_InitBufferPointers).l
                tst.w   d2
                beq.s   locret_2E92A
                moveq   #0,d0
                moveq   #0,d1
                jsr (Physics_AlignToTerrain).l
                move.l  #$FFFE0000,$1C(a5)
                subq.w  #1,$4A(a5)
                bne.s   locret_2E92A
                addq.w  #2,4(a5)
locret_2E92A:                           ; CODE XREF: Enemy_BeetleFallAndLand+E   j
                                        ; Enemy_BeetleFallAndLand+26   j ...
                rts
; End of function Enemy_BeetleFallAndLand
; Beetle falls with gravity checking if below screen threshold
Enemy_BeetleFallOffscreen:                              ; DATA XREF: ROM:0002E81A   o  ; was: sub_2E92C
                addi.l  #$2000,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_2E946
                cmpi.w  #$150,$14(a5)
                bgt.w   loc_2E416
locret_2E946:                           ; CODE XREF: Enemy_BeetleFallOffscreen+E   j
                rts
; End of function Enemy_BeetleFallOffscreen
; Handles beetle enemy defeat
Enemy_Stage10BeetleDefeat:                              ; CODE XREF: Enemy_Stage10BeetleMain+A   j  ; was: sub_2E948
                                        ; Enemy_Stage10BeetleMain+12   j
                tst.w   $24(a5)
                bmi.s   loc_2E97A
                btst    #4,$22(a5)
                bne.s   loc_2E97A
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                move.l  #off_E953C,8(a5)
                clr.w   $C(a5)
                jmp Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_2E97A:                              ; CODE XREF: Enemy_Stage10BeetleDefeat+4   j
                                        ; Enemy_Stage10BeetleDefeat+C   j
                clr.w   4(a5)
                move.w  #$2D8,(a5)
                move.w  #$10,$48(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #$FFFB8000,$1C(a5)
                rts
; End of function Enemy_Stage10BeetleDefeat
; Falling beetle with explosion
Enemy_Stage10BeetleFall:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E99E
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_2E9BA
                jsr (Projectile_ExplodeWithSound).l
                moveq   #$F,d0
                jmp Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2E9BA:                              ; CODE XREF: Enemy_Stage10BeetleFall+C   j
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2E9CE
                bclr    #7,2(a5)
locret_2E9CE:                           ; CODE XREF: Enemy_Stage10BeetleFall+28   j
                rts
; End of function Enemy_Stage10BeetleFall
; Checks beetle death conditions and spawns explosion effect
Enemy_BeetleDeathCheck:
                tst.w   $24(a5)  ; was: sub_2E9D0
                bmi.s   locret_2E9FA
                btst    #4,$22(a5)
                bne.s   locret_2E9FA
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                move.l  #off_E953C,8(a5)
                clr.w   $C(a5)
                jmp Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
locret_2E9FA:                           ; CODE XREF: Enemy_BeetleDeathCheck+4   j
                                        ; Enemy_BeetleDeathCheck+C   j
                rts
; End of function Enemy_BeetleDeathCheck
; Flying enemy main handler
Enemy_FlyerMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E9FC
                move.w  4(a5),d0
                lea     off_2EA08(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyerMain
; ---------------------------------------------------------------------------
off_2EA08:      dc.w Enemy_FlyerDispatcher-*        ; DATA XREF: Enemy_FlyerMain+4   o
                dc.w Enemy_FlyerSpawnInit-*
                dc.w Enemy_FlyerState1-*


; Flying enemy dispatcher
Enemy_FlyerDispatcher:                              ; DATA XREF: ROM:off_2EA08   o  ; was: sub_2EA0E
                clr.w   (dword_FF9400).w
                clr.w   (dword_FF9400+2).w
                move.w  #$FFFF,(dword_FF9404).w
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerDispatcher
; Flying enemy spawn init
Enemy_FlyerSpawnInit:                              ; DATA XREF: ROM:0002EA0A   o  ; was: sub_2EA28
                subq.w  #1,$48(a5)
                bne.s   locret_2EA50
                lea     (dword_FF9400).w,a4
                adda.w  $4C(a5),a4
                tst.w   (a4)
                bmi.s   loc_2EA52
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_2EA46
                move.w  a0,(a4)
                bsr.s Enemy_FlyerMovement1
loc_2EA46:                              ; CODE XREF: Enemy_FlyerSpawnInit+18   j
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,$4C(a5)
locret_2EA50:                           ; CODE XREF: Enemy_FlyerSpawnInit+4   j
                rts
; ---------------------------------------------------------------------------
loc_2EA52:                              ; CODE XREF: Enemy_FlyerSpawnInit+10   j
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerSpawnInit
; Flying enemy movement 1
Enemy_FlyerMovement1:                              ; CODE XREF: Enemy_FlyerSpawnInit+1C   p  ; was: sub_2EA58
                                        ; Enemy_FlyerState1+20   p
                bsr.w Enemy_FlyerMovement2
                move.w  a5,$4E(a0)
                move.w  $4A(a5),d0
                move.w  word_2EA8A(pc,d0.w),$10(a0)
                move.w  #$180,$14(a0)
                addq.w  #2,$4A(a5)
                andi.w  #7,$4A(a5)
                cmpi.w  #$120,$10(a0)
                bcs.s   locret_2EA88
                bset    #3,$E(a0)
locret_2EA88:                           ; CODE XREF: Enemy_FlyerMovement1+28   j
                rts
; End of function Enemy_FlyerMovement1
; ---------------------------------------------------------------------------
word_2EA8A:     dc.w $1A0, $A0, $1A0, $A0, $1A0, $A0, $1A0, $A0
                                        ; DATA XREF: Enemy_FlyerMovement1+C   r


; Flyer state handler 1
Enemy_FlyerState1:                              ; DATA XREF: ROM:0002EA0C   o  ; was: sub_2EA9A
                lea     (dword_FF9400).w,a4
loc_2EA9E:                              ; CODE XREF: Enemy_FlyerState1+12   j
                movea.w (a4),a0
                cmpi.w  #$44C,(a0)
                bne.s   loc_2EAB0
                addq.w  #2,a4
                cmpi.w  #$FFFF,(a4)
                bne.s   loc_2EA9E
locret_2EAAE:                           ; CODE XREF: Enemy_FlyerState1+1C   j
                rts
; ---------------------------------------------------------------------------
loc_2EAB0:                              ; CODE XREF: Enemy_FlyerState1+A   j
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2EAAE
                move.w  a0,(a4)
                bsr.s Enemy_FlyerMovement1
                rts
; End of function Enemy_FlyerState1
; Flying enemy movement 2
Enemy_FlyerMovement2:                              ; CODE XREF: Enemy_FlyerMovement1   p  ; was: sub_2EABE
                move.w  #$44C,(a0)
                move.w  #$400,$E(a0)
                move.l  #word_EB408,8(a0)
                move.w  #$CC00,2(a0)
                move.b  #$C0,$21(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #4,$24(a0)
                move.w  #$14,$26(a0)
                move.b  #$60,$20(a0) ; '`'
                rts
; End of function Enemy_FlyerMovement2
; Flying enemy attack
Enemy_FlyerAttack:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2EB00
                tst.w   4(a5)
                beq.s   loc_2EB68
                tst.w   $24(a5)
                bmi.w Enemy_FlyerExplode
                tst.w   (word_FF808C).w
                bpl.w Enemy_FlyerExplode
                cmpi.w  #$1C,4(a5)
                bcc.s   loc_2EB2E
                movea.w $4E(a5),a0
                cmpi.w  #$454,(a0)
                beq.s   loc_2EB2E
                move.w  #$1C,4(a5)
loc_2EB2E:                              ; CODE XREF: Enemy_FlyerAttack+1C   j
                                        ; Enemy_FlyerAttack+26   j
                jsr     (RandomNumber).l
                movea.w $5C(a5),a0
                move.w  $14(a5),$14(a0)
                addi.w  #$14,$14(a0)
                move.w  $10(a5),$10(a0)
                move.w  $48(a0),d0
                add.w   d0,$10(a0)
                btst    #3,$E(a5)
                bne.s   loc_2EB62
                addi.w  #$14,$10(a0)
                bra.s   loc_2EB68
; ---------------------------------------------------------------------------
loc_2EB62:                              ; CODE XREF: Enemy_FlyerAttack+58   j
                addi.w  #-$14,$10(a0)
loc_2EB68:                              ; CODE XREF: Enemy_FlyerAttack+4   j
                                        ; Enemy_FlyerAttack+60   j
                move.w  4(a5),d0
                lea     off_2EB74(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyerAttack
; ---------------------------------------------------------------------------
off_2EB74:      dc.w Enemy_FlyerSpawnProjectile-*        ; DATA XREF: Enemy_FlyerAttack+6C   o
                dc.w Enemy_FlyerCheckBounds1-*
                dc.w Enemy_FlyerCheckBounds2-*
                dc.w Enemy_FlyerAccelerate-*
                dc.w Enemy_FlyerTrackPlayer-*
                dc.w Enemy_FlyerState2-*
                dc.w Enemy_FlyerState3-*
                dc.w Enemy_FlyerState4-*
                dc.w Enemy_FlyerState6-*
                dc.w Enemy_FlyerState7-*
                dc.w Enemy_FlyerState8-*
                dc.w Projectile_FlyerBullet1-*
                dc.w Projectile_FlyerBullet2-*
                dc.w Projectile_FlyerBullet3-*
                dc.w Enemy_FlyerDestroy-*
                dc.w Enemy_FlyerDecelerate-*


; Spawns flyer projectile
Enemy_FlyerSpawnProjectile:                              ; DATA XREF: ROM:off_2EB74   o  ; was: sub_2EB94
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2EBD0
                move.w  #$10,(a0)
                move.w  #$CC00,2(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  #word_EB486,8(a0)
                move.w  $E(a5),$E(a0)
                clr.w   $C(a0)
                move.w  a0,$5C(a5)
                move.w  #$FFFC,$1C(a5)
                addq.w  #2,4(a5)
locret_2EBD0:                           ; CODE XREF: Enemy_FlyerSpawnProjectile+6   j
                rts
; End of function Enemy_FlyerSpawnProjectile
; Boundary check 1
Enemy_FlyerCheckBounds1:                              ; DATA XREF: ROM:0002EB76   o  ; was: sub_2EBD2
                cmpi.w  #$160,$14(a5)
                bgt.s   locret_2EBDE
                addq.w  #2,4(a5)
locret_2EBDE:                           ; CODE XREF: Enemy_FlyerCheckBounds1+6   j
                rts
; End of function Enemy_FlyerCheckBounds1
; Boundary check 2
Enemy_FlyerCheckBounds2:                              ; DATA XREF: ROM:0002EB78   o  ; was: sub_2EBE0
                move.w  (word_FF824A).w,d0
                addi.w  #$40,d0 ; '@'
                cmp.w   $14(a5),d0
                blt.s   locret_2EBF2
                addq.w  #2,4(a5)
locret_2EBF2:                           ; CODE XREF: Enemy_FlyerCheckBounds2+C   j
                rts
; End of function Enemy_FlyerCheckBounds2
; Acceleration handler
Enemy_FlyerAccelerate:                              ; DATA XREF: ROM:0002EB7A   o  ; was: sub_2EBF4
                addi.l  #$4000,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_2EC12
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5) ; '@'
locret_2EC12:                           ; CODE XREF: Enemy_FlyerAccelerate+E   j
                rts
; End of function Enemy_FlyerAccelerate
; Track player movement
Enemy_FlyerTrackPlayer:                              ; DATA XREF: ROM:0002EB7C   o  ; was: sub_2EC14
                move.w  (word_FF824A).w,d0
                bsr.w Enemy_FlyerAdjustVelocity
                subq.w  #1,$48(a5)
                bne.s   locret_2EC32
                addq.w  #2,4(a5)
                move.w  (word_FF824A).w,$4C(a5)
                move.w  #$10,$48(a5)
locret_2EC32:                           ; CODE XREF: Enemy_FlyerTrackPlayer+C   j
                rts
; End of function Enemy_FlyerTrackPlayer
; Flyer state handler 2
Enemy_FlyerState2:                              ; DATA XREF: ROM:0002EB7E   o  ; was: sub_2EC34
                move.w  $4C(a5),d0
                bsr.w Enemy_FlyerAdjustVelocity
                subq.w  #1,$48(a5)
                bne.s   locret_2EC82
                btst    #0,(dword_FFFF08+1).w
                bne.s   loc_2EC7C
                btst    #1,(dword_FFFF08+1).w
                bne.s   loc_2EC7C
                move.w  #$10,4(a5)
                move.l  #word_EB432,8(a5)
                clr.w   $C(a5)
                btst    #3,$E(a5)
                beq.s   loc_2EC74
                move.w  #4,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2EC74:                              ; CODE XREF: Enemy_FlyerState2+36   j
                move.w  #$FFFC,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2EC7C:                              ; CODE XREF: Enemy_FlyerState2+14   j
                                        ; Enemy_FlyerState2+1C   j
                move.w  #$C,4(a5)
locret_2EC82:                           ; CODE XREF: Enemy_FlyerState2+C   j
                rts
; End of function Enemy_FlyerState2
; Flyer state handler 3
Enemy_FlyerState3:                              ; DATA XREF: ROM:0002EB80   o  ; was: sub_2EC84
                move.w  $4C(a5),d0
                bsr.w Enemy_FlyerAdjustVelocity
                move.w  #8,$48(a5)
                move.w  #$10,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerState3
; Flyer state handler 4
Enemy_FlyerState4:                              ; DATA XREF: ROM:0002EB82   o  ; was: sub_2EC9E
                move.w  $4C(a5),d0
                bsr.w Enemy_FlyerAdjustVelocity
                move.w  $48(a5),d0
                movea.w $5C(a5),a0
                bsr.w Enemy_FlyerState5
                subq.w  #1,$48(a5)
                bne.s   locret_2ED20
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_2ED14
                movem.w a5,-(sp)
                movea.w $5C(a5),a5
                btst    #3,$E(a5)
                beq.s   loc_2ECDA
                move.w  #$100,d6
                move.w  #$FFE8,d0
                bra.s   loc_2ECE0
; ---------------------------------------------------------------------------
loc_2ECDA:                              ; CODE XREF: Enemy_FlyerState4+30   j
                moveq   #0,d6
                move.w  #$18,d0
loc_2ECE0:                              ; CODE XREF: Enemy_FlyerState4+3A   j
                moveq   #0,d1
                move.w  #$8004,d2
                jsr (Enemy_InitHomingProjectile).l
                movem.w (sp)+,a5
                btst    #3,$E(a5)
                beq.s   loc_2ED00
                move.w  #$FFFA,$50(a0)
                bra.s   loc_2ED06
; ---------------------------------------------------------------------------
loc_2ED00:                              ; CODE XREF: Enemy_FlyerState4+58   j
                move.w  #6,$50(a0)
loc_2ED06:                              ; CODE XREF: Enemy_FlyerState4+60   j
                subq.w  #1,$4A(a5)
                beq.s   loc_2ED14
                move.w  #8,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_2ED14:                              ; CODE XREF: Enemy_FlyerState4+20   j
                                        ; Enemy_FlyerState4+6C   j
                move.w  #$40,$48(a5) ; '@'
                move.w  #8,4(a5)
locret_2ED20:                           ; CODE XREF: Enemy_FlyerState4+18   j
                rts
; End of function Enemy_FlyerState4
; Flyer state handler 5
Enemy_FlyerState5:                              ; CODE XREF: Enemy_FlyerState4+10   p  ; was: sub_2ED22
                btst    #3,$E(a5)
                beq.s   loc_2ED32
                lea     word_2ED52(pc),a1
                nop
                bra.s   loc_2ED38
; ---------------------------------------------------------------------------
loc_2ED32:                              ; CODE XREF: Enemy_FlyerState5+6   j
                lea     word_2ED42(pc),a1
                nop
loc_2ED38:                              ; CODE XREF: Enemy_FlyerState5+E   j
                add.w   d0,d0
                move.w  (a1,d0.w),$48(a0)
                rts
; End of function Enemy_FlyerState5
; ---------------------------------------------------------------------------
word_2ED42:     dc.w 0, $FFFF, $FFFE, $FFFD, $FFFC, $FFFD, $FFFE, $FFFF
                                        ; DATA XREF: Enemy_FlyerState5:loc_2ED32   o
word_2ED52:     dc.w 0, 1, 2, 3, 4, 3, 2, 1
                                        ; DATA XREF: Enemy_FlyerState5+8   o


; Flyer state handler 6
Enemy_FlyerState6:                              ; DATA XREF: ROM:0002EB84   o  ; was: sub_2ED62
                move.w  $4C(a5),d0
                bsr.w Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2ED7C
                addi.l  #-$4000,$18(a5)
                bra.s   loc_2ED84
; ---------------------------------------------------------------------------
loc_2ED7C:                              ; CODE XREF: Enemy_FlyerState6+E   j
                addi.l  #$4000,$18(a5)
loc_2ED84:                              ; CODE XREF: Enemy_FlyerState6+18   j
                tst.l   $18(a5)
                bne.s   locret_2ED9A
                move.l  #word_EB45C,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
locret_2ED9A:                           ; CODE XREF: Enemy_FlyerState6+26   j
                rts
; End of function Enemy_FlyerState6
; Flyer state handler 7
Enemy_FlyerState7:                              ; DATA XREF: ROM:0002EB86   o  ; was: sub_2ED9C
                move.w  $4C(a5),d0
                bsr.w Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2EDC0
                addi.l  #-$4000,$18(a5)
                cmpi.l  #$FFFA0000,$18(a5)
                bgt.s   locret_2EDD6
                bra.s   loc_2EDD2
; ---------------------------------------------------------------------------
loc_2EDC0:                              ; CODE XREF: Enemy_FlyerState7+E   j
                addi.l  #$4000,$18(a5)
                cmpi.l  #$60000,$18(a5)
                blt.s   locret_2EDD6
loc_2EDD2:                              ; CODE XREF: Enemy_FlyerState7+22   j
                addq.w  #2,4(a5)
locret_2EDD6:                           ; CODE XREF: Enemy_FlyerState7+20   j
                                        ; Enemy_FlyerState7+34   j
                rts
; End of function Enemy_FlyerState7
; Flyer state handler 8
Enemy_FlyerState8:                              ; DATA XREF: ROM:0002EB88   o  ; was: sub_2EDD8
                move.w  $4C(a5),d0
                bsr.w Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2EDF2
                cmpi.w  #$E0,$10(a5)
                bgt.s   locret_2EE0A
                bra.s   loc_2EDFA
; ---------------------------------------------------------------------------
loc_2EDF2:                              ; CODE XREF: Enemy_FlyerState8+E   j
                cmpi.w  #$160,$10(a5)
                blt.s   locret_2EE0A
loc_2EDFA:                              ; CODE XREF: Enemy_FlyerState8+18   j
                move.l  #word_EB408,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
locret_2EE0A:                           ; CODE XREF: Enemy_FlyerState8+16   j
                                        ; Enemy_FlyerState8+20   j
                rts
; End of function Enemy_FlyerState8
; Flyer bullet projectile 1
Projectile_FlyerBullet1:                              ; DATA XREF: ROM:0002EB8A   o  ; was: sub_2EE0C
                move.w  $4C(a5),d0
                bsr.w Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2EE28
                addi.l  #$4000,$18(a5)
                bne.s   locret_2EE42
                bra.s   loc_2EE32
; ---------------------------------------------------------------------------
loc_2EE28:                              ; CODE XREF: Projectile_FlyerBullet1+E   j
                addi.l  #-$4000,$18(a5)
                bne.s   locret_2EE42
loc_2EE32:                              ; CODE XREF: Projectile_FlyerBullet1+1A   j
                move.l  #word_EB432,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
locret_2EE42:                           ; CODE XREF: Projectile_FlyerBullet1+18   j
                                        ; Projectile_FlyerBullet1+24   j
                rts
; End of function Projectile_FlyerBullet1
; Flyer bullet projectile 2
Projectile_FlyerBullet2:                              ; DATA XREF: ROM:0002EB8C   o  ; was: sub_2EE44
                move.w  $4C(a5),d0
                bsr.w Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2EE68
                addi.l  #$4000,$18(a5)
                cmpi.l  #$60000,$18(a5)
                blt.s   locret_2EE7E
                bra.s   loc_2EE7A
; ---------------------------------------------------------------------------
loc_2EE68:                              ; CODE XREF: Projectile_FlyerBullet2+E   j
                addi.l  #-$4000,$18(a5)
                cmpi.l  #$FFFA0000,$18(a5)
                bgt.s   locret_2EE7E
loc_2EE7A:                              ; CODE XREF: Projectile_FlyerBullet2+22   j
                addq.w  #2,4(a5)
locret_2EE7E:                           ; CODE XREF: Projectile_FlyerBullet2+20   j
                                        ; Projectile_FlyerBullet2+34   j
                rts
; End of function Projectile_FlyerBullet2
; Flyer bullet projectile 3
Projectile_FlyerBullet3:                              ; DATA XREF: ROM:0002EB8E   o  ; was: sub_2EE80
                move.w  $4C(a5),d0
                bsr.w Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2EE9A
                cmpi.w  #$1A0,$10(a5)
                blt.s   locret_2EEBE
                bra.s   loc_2EEA2
; ---------------------------------------------------------------------------
loc_2EE9A:                              ; CODE XREF: Projectile_FlyerBullet3+E   j
                cmpi.w  #$A0,$10(a5)
                bgt.s   locret_2EEBE
loc_2EEA2:                              ; CODE XREF: Projectile_FlyerBullet3+18   j
                clr.l   $18(a5)
                move.l  #word_EB408,8(a5)
                clr.w   $C(a5)
                move.w  #$40,$48(a5) ; '@'
                move.w  #8,4(a5)
locret_2EEBE:                           ; CODE XREF: Projectile_FlyerBullet3+16   j
                                        ; Projectile_FlyerBullet3+20   j
                rts
; End of function Projectile_FlyerBullet3
; Destroy flyer enemy
Enemy_FlyerDestroy:                              ; DATA XREF: ROM:0002EB90   o  ; was: sub_2EEC0
                ori.w   #$200,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerDestroy
; Deceleration handler
Enemy_FlyerDecelerate:                              ; DATA XREF: ROM:0002EB92   o  ; was: sub_2EECC
                addi.l  #-$4000,$1C(a5)
                rts
; End of function Enemy_FlyerDecelerate
; Velocity adjustment
Enemy_FlyerAdjustVelocity:                              ; CODE XREF: Enemy_FlyerTrackPlayer+4   p  ; was: sub_2EED6
                                        ; Enemy_FlyerState2+4   p ...
                sub.w   $14(a5),d0
                beq.w   locret_2EF18
                tst.w   d0
                bpl.s   loc_2EEFE
                addi.l  #-$1000,$1C(a5)
                cmpi.l  #$FFFE0000,$1C(a5)
                bgt.s   locret_2EF18
                move.l  #$FFFE0000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2EEFE:                              ; CODE XREF: Enemy_FlyerAdjustVelocity+A   j
                addi.l  #$1000,$1C(a5)
                cmpi.l  #$20000,$1C(a5)
                blt.s   locret_2EF18
                move.l  #$20000,$1C(a5)
locret_2EF18:                           ; CODE XREF: Enemy_FlyerAdjustVelocity+4   j
                                        ; Enemy_FlyerAdjustVelocity+1C   j ...
                rts
; End of function Enemy_FlyerAdjustVelocity
; Explosion handler
Enemy_FlyerExplode:                              ; CODE XREF: Enemy_FlyerAttack+A   j  ; was: sub_2EF1A
                                        ; Enemy_FlyerAttack+12   j
                jsr (Projectile_ExplodeOnImpact).l
                move.w  #$1000,2(a5)
                movea.w $5C(a5),a0
                move.w  #$1000,2(a0)
                rts
; End of function Enemy_FlyerExplode
; Dispatches train end entity state using jump table
Entity_TrainEndDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2EF32
                clr.w   6(a5)
                move.w  4(a5),d0
                lea     off_2EF42(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Entity_TrainEndDispatcher
; ---------------------------------------------------------------------------
off_2EF42:      dc.w Entity_TrainEndInit-*        ; DATA XREF: Entity_TrainEndDispatcher+8   o
                dc.w Entity_TransitionAnimationState-*
                dc.w Entity_TrainJumpPrep-*
                dc.w Entity_TrainJumpWait-*
                dc.w Entity_TrainJumpFall-*
                dc.w Entity_TrainJumpComplete-*


; Initializes train end entity with animation and position
Entity_TrainEndInit:                              ; DATA XREF: ROM:off_2EF42   o  ; was: sub_2EF4E
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                bsr.w Entity_TrainEndLoadPalette
                bset    #3,$E(a5)
                move.w  #$100,$10(a5)
                move.w  (dword_FFA904).w,d0
                bsr.w Entity_TrainUpdateYPosition
                move.l  #word_EBD32,8(a5)
                clr.w   $C(a5)
                rts
; End of function Entity_TrainEndInit
; Loads palette and sprite parameters for train end
Entity_TrainEndLoadPalette:                              ; CODE XREF: Entity_TrainEndInit+A   p  ; was: sub_2EF7E
                                        ; Entity_XiTigerIntroDispatcher+4   p
                lea     (byte_C1C2).l,a0
                jsr     (LoadPalette).l
                move.w  #$CD00,2(a5)
                move.w  #$E400,$E(a5)
                move.l  #$F010F808,$2C(a5)
                move.l  #$F010F808,$28(a5)
                move.b  #$C0,$21(a5)
                move.b  #$10,$23(a5)
                move.b  #$60,$20(a5) ; '`'
                rts
; End of function Entity_TrainEndLoadPalette
; Updates entity Y position based on train scroll
Entity_TrainUpdateYPosition:                              ; CODE XREF: Entity_TrainEndInit+1E   p  ; was: sub_2EFBA
                                        ; sub_2EFC8   p ...
                move.w  (dword_FFA904).w,$14(a5)
                addi.w  #$A8,$14(a5)
                rts
; End of function Entity_TrainUpdateYPosition
; Transitions entity animation state with frame update
Entity_TransitionAnimationState:                              ; DATA XREF: ROM:0002EF44   o  ; was: sub_2EFC8
                bsr.w Entity_TrainUpdateYPosition
                subq.w  #1,$48(a5)
                bne.s   locret_2EFE8
                move.l  #word_EBD5C,8(a5)
                clr.w   $C(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_2EFE8:                           ; CODE XREF: Entity_TransitionAnimationState+8   j
                rts
; End of function Entity_TransitionAnimationState
; Prepares entity for train jump with animation setup
Entity_TrainJumpPrep:                              ; DATA XREF: ROM:0002EF46   o  ; was: sub_2EFEA
                bsr.w Entity_TrainUpdateYPosition
                subq.w  #1,$48(a5)
                bne.s   locret_2F018
                move.l  #word_EBD32,8(a5)
                clr.w   $C(a5)
                move.l  #$FFFA0000,$1C(a5)
                move.w  #$FFFC,$18(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_2F018:                           ; CODE XREF: Entity_TrainJumpPrep+8   j
                rts
; End of function Entity_TrainJumpPrep
; Waits for timer then changes to falling animation
Entity_TrainJumpWait:                              ; DATA XREF: ROM:0002EF48   o  ; was: sub_2F01A
                subq.w  #1,$48(a5)
                bne.s   locret_2F030
                move.l  #word_EBD7A,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
locret_2F030:                           ; CODE XREF: Entity_TrainJumpWait+4   j
                rts
; End of function Entity_TrainJumpWait
; Handles player falling from train with gravity
Entity_TrainJumpFall:                              ; DATA XREF: ROM:0002EF4A   o  ; was: sub_2F032
                btst    #7,$1C(a5)
                bne.s   loc_2F048
                jsr (Player_ActionDispatcher).l
                btst    #0,6(a5)
                bne.s Entity_TrainJumpLanded
loc_2F048:                              ; CODE XREF: Entity_TrainJumpFall+6   j
                addi.l  #$4000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
; Train jump landed state setting up animation and next phase
Entity_TrainJumpLanded:                              ; CODE XREF: Entity_TrainJumpFall+14   j  ; was: loc_2F052
                clr.l   $18(a5)
                move.w  #$80,$48(a5)
                move.l  #word_EBD32,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Entity_TrainJumpFall
; Completes train jump restoring palette and flags
Entity_TrainJumpComplete:                              ; DATA XREF: ROM:0002EF4C   o  ; was: sub_2F06E
                subq.w  #1,$48(a5)
                bne.s   locret_2F08A
                move.w  #$1000,2(a5)
                clr.w   (word_FFA02A).w
                lea     (byte_C1A2).l,a0
                jmp     LoadPalette
; ---------------------------------------------------------------------------
locret_2F08A:                           ; CODE XREF: Entity_TrainJumpComplete+4   j
                rts
; End of function Entity_TrainJumpComplete
; Xi-Tiger intro entity initialization
Entity_XiTigerIntro:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2F08C
                clr.w   6(a5)
                move.w  4(a5),d0
                lea     off_2F09C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Entity_XiTigerIntro
; ---------------------------------------------------------------------------
off_2F09C:      dc.w Entity_XiTigerIntroDispatcher-*        ; DATA XREF: Entity_XiTigerIntro+8   o
                dc.w Entity_XiTigerIntroStartState-*
                dc.w Entity_XiTigerIntroState2-*
                dc.w Boss_XiTigerIntroState3-*
                dc.w Boss_XiTigerIntroState4-*
                dc.w Boss_XiTigerIntroState5-*


; Dispatcher for Xi-Tiger intro states
Entity_XiTigerIntroDispatcher:                              ; DATA XREF: ROM:off_2F09C   o  ; was: sub_2F0A8
                addq.w  #2,4(a5)
                bsr.w Entity_TrainEndLoadPalette
                bsr.w Entity_XiTigerIntroState1
                move.w  #$60,$10(a5) ; '`'
                rts
; End of function Entity_XiTigerIntroDispatcher
; Xi-Tiger intro state with animation
Entity_XiTigerIntroState1:                              ; CODE XREF: Entity_XiTigerIntroDispatcher+8   p  ; was: sub_2F0BC
                                        ; Entity_XiTigerIntroStartState+6   p ...
                move.w  (dword_FFA904).w,$14(a5)
                addi.w  #$128,$14(a5)
                rts
; End of function Entity_XiTigerIntroState1
; Xi-Tiger intro start state
Entity_XiTigerIntroStartState:                              ; DATA XREF: ROM:0002F09E   o  ; was: sub_2F0CA
                move.w  #$60,$10(a5) ; '`'
                bsr.w Entity_XiTigerIntroState1
                tst.w   (dword_FFA908).w
                bpl.s   locret_2F0F4
                move.l  #$FFFA0000,$1C(a5)
                move.w  #2,$18(a5)
                move.l  #word_EBD7A,8(a5)
                addq.w  #2,4(a5)
locret_2F0F4:                           ; CODE XREF: Entity_XiTigerIntroStartState+E   j
                rts
; End of function Entity_XiTigerIntroStartState
; Xi-Tiger intro state advancing to cutscene
Entity_XiTigerIntroState2:                              ; DATA XREF: ROM:0002F0A0   o  ; was: sub_2F0F6
                btst    #7,$1C(a5)
                bne.s   loc_2F10C
                jsr (Player_ActionDispatcher).l
                btst    #0,6(a5)
                bne.s   loc_2F116
loc_2F10C:                              ; CODE XREF: Entity_XiTigerIntroState2+6   j
                addi.l  #$4000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2F116:                              ; CODE XREF: Entity_XiTigerIntroState2+14   j
                clr.l   $18(a5)
                move.l  #word_EBD5C,8(a5)
                clr.w   $C(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Entity_XiTigerIntroState2
; Xi Tiger boss intro state 3 with animation and sound trigger
Boss_XiTigerIntroState3:                              ; DATA XREF: ROM:0002F0A2   o  ; was: sub_2F132
                bsr.w Entity_XiTigerIntroState1
                subq.w  #1,$48(a5)
                bne.s   locret_2F160
                move.l  #word_EBD32,8(a5)
                clr.w   $C(a5)
                move.w  #$20,$48(a5) ; ' '
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
                move.b  #$20,d0 ; ' '
                jsr (Sound_PlaySFX).l
locret_2F160:                           ; CODE XREF: Boss_XiTigerIntroState3+8   j
                rts
; End of function Boss_XiTigerIntroState3
; Xi Tiger boss intro state 4 with animation cycling
Boss_XiTigerIntroState4:                              ; DATA XREF: ROM:0002F0A4   o  ; was: sub_2F162
                bsr.w Entity_XiTigerIntroState1
                subq.w  #1,$48(a5)
                bne.s   locret_2F192
                move.w  $4A(a5),d0
                lsl.w   #2,d0
                move.l  off_2F194(pc,d0.w),8(a5)
                clr.w   $C(a5)
                move.w  #4,$48(a5)
                addq.w  #1,$4A(a5)
                cmpi.w  #2,$4A(a5)
                bne.s   locret_2F192
                addq.w  #2,4(a5)
locret_2F192:                           ; CODE XREF: Boss_XiTigerIntroState4+8   j
                                        ; Boss_XiTigerIntroState4+2A   j
                rts
; End of function Boss_XiTigerIntroState4
; ---------------------------------------------------------------------------
off_2F194:      dc.l word_EBD02         ; DATA XREF: Boss_XiTigerIntroState4+10   r
                dc.l word_EBCD8


; Xi Tiger boss intro state 5 continuing intro animation
Boss_XiTigerIntroState5:                              ; DATA XREF: ROM:0002F0A6   o  ; was: sub_2F19C
                bsr.w Entity_XiTigerIntroState1
                rts
; End of function Boss_XiTigerIntroState5
; Xi Tiger boss main attack pattern dispatcher
Boss_XiTigerAttackMain:
                bsr.w Boss_HandleInputOffset  ; was: sub_2F1A2
                move.w  4(a5),d0
                lea     off_2F1B2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_XiTigerAttackMain
; ---------------------------------------------------------------------------
off_2F1B2:      dc.w Boss_XiTigerAttackInit-*        ; DATA XREF: Boss_XiTigerAttackMain+8   o
                dc.w Boss_XiTigerSpawnProjectiles-*


; Xi Tiger boss attack initialization with position setup
Boss_XiTigerAttackInit:                              ; DATA XREF: ROM:off_2F1B2   o  ; was: sub_2F1B6
                move.w  #$C00,2(a5)
                move.w  #$18,$50(a5)
                move.w  #$120,$10(a5)
                move.w  #$F0,$14(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_XiTigerAttackInit
; Xi Tiger spawns 8 projectiles with random trajectories using sine table
Boss_XiTigerSpawnProjectiles:                              ; DATA XREF: ROM:0002F1B4   o  ; was: sub_2F1D4
                move.w  #7,d7
loc_2F1D8:                              ; CODE XREF: Boss_XiTigerSpawnProjectiles:loc_2F29C   j
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$52(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                move.w  d0,$54(a5)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                move.w  d0,$56(a5)
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_2F2A0
                bsr.w   nullsub_69
                lea     (word_1B514).l,a4
                move.w  $52(a5),d0
                andi.w  #$1FE,d0
                move.w  (a4,d0.w),d2
                move.w  -$80(a4,d0.w),d3
                muls.w  $50(a5),d2
                muls.w  $50(a5),d3
                swap    d2
                swap    d3
                move.w  d2,$4C(a0)
                move.w  d3,$4E(a0)
                move.w  $54(a5),d0
                add.w   $4C(a5),d0
                andi.w  #$1FE,d0
                muls.w  (a4,d0.w),d2
                asl.l   #2,d2
                move.w  $56(a5),d0
                add.w   $4E(a5),d0
                andi.w  #$1FE,d0
                muls.w  (a4,d0.w),d3
                asl.l   #2,d3
                tst.l   d2
                bne.s   loc_2F278
                tst.l   d3
                bne.s   loc_2F278
                move.w  #$1000,2(a0)
                bra.w   loc_2F29C
; ---------------------------------------------------------------------------
loc_2F278:                              ; CODE XREF: Boss_XiTigerSpawnProjectiles+94   j
                                        ; Boss_XiTigerSpawnProjectiles+98   j
                move.w  a5,$4A(a0)
                move.w  $54(a5),$58(a0)
                move.w  $56(a5),$5A(a0)
                move.l  d2,$18(a0)
                move.l  d3,$1C(a0)
                asr.l   #4,d2
                asr.l   #4,d3
                move.l  d2,$50(a0)
                move.l  d3,$54(a0)
loc_2F29C:                              ; CODE XREF: Boss_XiTigerSpawnProjectiles+A0   j
                dbf     d7,loc_2F1D8
locret_2F2A0:                           ; CODE XREF: Boss_XiTigerSpawnProjectiles+3C   j
                rts
; End of function Boss_XiTigerSpawnProjectiles
nullsub_69:                             ; CODE XREF: Boss_XiTigerSpawnProjectiles+40   p
                rts
; End of function nullsub_69


; Initializes Xi Tiger projectile with position and animation
Boss_XiTigerProjectileInit:
                move.w  #$4E00,2(a0)  ; was: sub_2F2A4
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  #$60,$20(a0) ; '`'
                move.w  #$480,$E(a0)
                move.l  #word_E91FA,8(a0)
                move.w  #8,$48(a0)
                rts
; End of function Boss_XiTigerProjectileInit
; Adjusts entity offset based on input bits 2 and 3
Boss_HandleInputOffset:                              ; CODE XREF: Boss_XiTigerAttackMain   p  ; was: sub_2F2D2
                btst    #3,(word_FFF706).w
                beq.s   loc_2F2DE
                addq.w  #1,$50(a5)
loc_2F2DE:                              ; CODE XREF: Boss_HandleInputOffset+6   j
                btst    #2,(word_FFF706).w
                beq.s   locret_2F2EA
                subq.w  #1,$50(a5)
locret_2F2EA:                           ; CODE XREF: Boss_HandleInputOffset+12   j
                rts
; End of function Boss_HandleInputOffset
; Applies velocity to position and dispatches to state handler
Boss_ApplyVelocityDispatch:
                move.l  $50(a5),d0  ; was: sub_2F2EC
                add.l   d0,$18(a5)
                move.l  $54(a5),d0
                add.l   d0,$1C(a5)
                move.w  4(a5),d0
                lea     off_2F308(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ApplyVelocityDispatch
; ---------------------------------------------------------------------------
off_2F308:      dc.w Boss_TimerAdvanceState-*        ; DATA XREF: Boss_ApplyVelocityDispatch+14   o
                dc.w Boss_SyncPositionToParent-*


; Counts down timer and advances state when reaching zero
Boss_TimerAdvanceState:                              ; DATA XREF: ROM:off_2F308   o  ; was: sub_2F30C
                subq.w  #1,$48(a5)
                bne.s   locret_2F322
                bset    #7,2(a5)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_2F322:                           ; CODE XREF: Boss_TimerAdvanceState+4   j
                rts
; End of function Boss_TimerAdvanceState
; Synchronizes position using sine table based on parent entity angles
Boss_SyncPositionToParent:                              ; DATA XREF: ROM:0002F30A   o  ; was: sub_2F324
                movea.w $4A(a5),a0
                move.w  $4C(a0),d0
                cmp.w   $5C(a5),d0
                beq.s   loc_2F356
                move.w  d0,$5C(a5)
                move.w  $4C(a5),d2
                move.w  $58(a5),d0
                add.w   $4C(a0),d0
                andi.w  #$1FE,d0
                muls.w  (a4,d0.w),d2
                asl.l   #2,d2
                move.l  d2,$18(a5)
                asr.l   #4,d2
                move.l  d2,$50(a5)
loc_2F356:                              ; CODE XREF: Boss_SyncPositionToParent+C   j
                move.w  $4E(a0),d0
                cmp.w   $5E(a5),d0
                beq.w   loc_2F386
                move.w  d0,$5E(a5)
                move.w  $4E(a5),d3
                move.w  $5A(a5),d0
                add.w   $4E(a0),d0
                andi.w  #$1FE,d0
                muls.w  (a4,d0.w),d3
                asl.l   #2,d3
                move.l  d3,$1C(a5)
                asr.l   #4,d3
                move.l  d3,$54(a5)
loc_2F386:                              ; CODE XREF: Boss_SyncPositionToParent+3A   j
                subq.w  #1,$48(a5)
                bne.s   locret_2F392
                move.w  #$1000,2(a5)
locret_2F392:                           ; CODE XREF: Boss_SyncPositionToParent+66   j
                rts
; End of function Boss_SyncPositionToParent
nullsub_70:
                rts
; End of function nullsub_70


; Tiny wrapper calling state handler
Enemy_TinyWrapper:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2F396
                moveq   #0,d0
                bra.s   loc_2F39E
; End of function Enemy_TinyWrapper
; Spawns multiple projectiles in spread pattern
Enemy_SpawnMultiShot:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2F39A
                move.w  #1,d0
loc_2F39E:                              ; CODE XREF: Enemy_TinyWrapper+2   j
                move.w  (word_FFA000).w,d1
                andi.w  #1,d1
                eor.w   d0,d1
                move.w  d1,$48(a5)
                move.w  4(a5),d0
                beq.s Enemy_MultiShotDispatcher
                cmpi.w  #4,d0
                beq.s Enemy_MultiShotDispatcher
                cmpi.w  #$70,$10(a5) ; 'p'
                bpl.s   loc_2F3C8
                move.w  #4,4(a5)
                bra.s Enemy_MultiShotDispatcher
; ---------------------------------------------------------------------------
loc_2F3C8:                              ; CODE XREF: Enemy_SpawnMultiShot+24   j
                nop
; State dispatcher for multi-shot enemy projectile handler
Enemy_MultiShotDispatcher:                              ; CODE XREF: Enemy_SpawnMultiShot+16   j  ; was: loc_2F3CA
                                        ; Enemy_SpawnMultiShot+1C   j ...
                move.w  4(a5),d0
                movea.w off_2F3DA(pc,d0.w),a0
                adda.l  #Enemy_TwinProjectileHandler,a0
                jmp     (a0)
; End of function Enemy_SpawnMultiShot
; ---------------------------------------------------------------------------
off_2F3DA:      dc.w Enemy_TwinProjectileHandler-Enemy_TwinProjectileHandler
                                        ; DATA XREF: Enemy_SpawnMultiShot+34   r
                dc.w Enemy_DestroyOnContact-Enemy_TwinProjectileHandler
                dc.w Boss_AntroidUpdateTiles-Enemy_TwinProjectileHandler
                dc.w Boss_AntroidPhaseCounter-Enemy_TwinProjectileHandler
                dc.w Boss_CheckPhaseTrigger-Enemy_TwinProjectileHandler
                dc.w Boss_AdvanceToNextPhase-Enemy_TwinProjectileHandler


; Handles paired projectile spawn with symmetric angles
Enemy_TwinProjectileHandler:                              ; DATA XREF: Enemy_SpawnMultiShot+38   o  ; was: sub_2F3E6
                                        ; ROM:off_2F3DA   o ...
                addq.w  #2,4(a5)
                move.w  #$100,2(a5)
                move.w  #$20,$4A(a5) ; ' '
                move.w  #5,$4E(a5)
                move.w  $5E(a5),d0
                move.w  word_2F41A(pc,d0.w),$50(a5)
                move.w  #$4000,$52(a5)
                move.b  #0,$54(a5)
                move.b  #1,$55(a5)
locret_2F418:                           ; CODE XREF: Boss_AntroidUpdateTiles+18   j
                                        ; Boss_UpdateTilesDMA+4   j
                rts
; End of function Enemy_TwinProjectileHandler
; ---------------------------------------------------------------------------
word_2F41A:     dc.w $42E4, $4290, $42B4, $42E0, $4284, $42B0, $42D4, $4280
                                        ; DATA XREF: Enemy_TwinProjectileHandler+1A   r


; Checks collision flags and destroys on player contact
Enemy_DestroyOnContact:                              ; DATA XREF: ROM:0002F3DC   o  ; was: sub_2F42A
                cmpi.w  #$1A8,$10(a5)
                bpl.s   locret_2F46A
                subq.w  #1,$4A(a5)
                bpl.s   locret_2F46A
                move.w  #6,4(a5)
                jsr (Sprite_FindFreeEnemySlot).l
                bne.s   locret_2F46A
                move.w  #$2B0,(a0)
                move.b  #$B,$5F(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addq.w  #8,$14(a0)
                move.b  #$45,d0 ; 'E'
                jsr (Sound_PlaySFX).l
locret_2F46A:                           ; CODE XREF: Enemy_DestroyOnContact+6   j
                                        ; Enemy_DestroyOnContact+C   j ...
                rts
; End of function Enemy_DestroyOnContact
; Increments phase counter until reaching 8 then advances state
Boss_AntroidPhaseCounter:                              ; DATA XREF: ROM:0002F3E0   o  ; was: sub_2F46C
                tst.w   $48(a5)
                bne.s   locret_2F498
                addq.w  #2,$4C(a5)
                cmpi.w  #8,$4C(a5)
                bne.w Boss_AntroidDMATileTransfer
                addq.w  #2,4(a5)
                move.w  #$20,$4A(a5) ; ' '
                bra.w Boss_AntroidDMATileTransfer
; End of function Boss_AntroidPhaseCounter
; Checks if boss phase trigger condition met
Boss_CheckPhaseTrigger:                              ; DATA XREF: ROM:0002F3E2   o  ; was: sub_2F48E
                subq.w  #1,$4A(a5)
                bpl.s   locret_2F498
                addq.w  #2,4(a5)
locret_2F498:                           ; CODE XREF: Boss_AntroidPhaseCounter+4   j
                                        ; Boss_CheckPhaseTrigger+4   j ...
                rts
; End of function Boss_CheckPhaseTrigger
; Advances boss to next phase state
Boss_AdvanceToNextPhase:                              ; DATA XREF: ROM:0002F3E4   o  ; was: sub_2F49A
                tst.w   $48(a5)
                bne.s   locret_2F498
                subq.w  #2,$4C(a5)
                bne.w Boss_AntroidDMATileTransfer
                subq.w  #1,$4E(a5)
                bmi.s   loc_2F4CE
                move.w  #2,4(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$40,d0 ; '@'
                move.w  d0,$4A(a5)
                bra.w Boss_AntroidDMATileTransfer
; End of function Boss_AdvanceToNextPhase
; Updates boss tiles via DMA transfer based on state
Boss_AntroidUpdateTiles:                              ; DATA XREF: ROM:0002F3DE   o  ; was: sub_2F4C8
                tst.w   $48(a5)
                bne.s   locret_2F498
loc_2F4CE:                              ; CODE XREF: Boss_AdvanceToNextPhase+12   j
                bset    #4,2(a5)
                clr.w   $4C(a5)
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_2F4DC:                              ; CODE XREF: Boss_AntroidUpdateTiles+10   j
                                        ; Boss_EnableVisibilityFlag+10   j
                tst.w   $48(a5)
                bne.w   locret_2F418
; Transfers Antroid boss tiles via DMA using lookup table
Boss_AntroidDMATileTransfer:                              ; CODE XREF: Boss_AntroidPhaseCounter+10   j  ; was: loc_2F4E4
                                        ; Boss_AntroidPhaseCounter+1E   j ...
                move.w  $4C(a5),d0
                move.w  word_2F4FA(pc,d0.w),$56(a5)
                movea.w a5,a0
                adda.w  #$50,a0 ; 'P'
                jmp Gfx_DMATransferTiles
; End of function Boss_AntroidUpdateTiles
; ---------------------------------------------------------------------------
word_2F4FA:     dc.w $878C, $888D, $898E, $8A8F, $8B90
                                        ; DATA XREF: Boss_AntroidUpdateTiles+20   r


; Initializes 6 debris entities in loop
Enemy_InitStage10Debris:                              ; CODE XREF: Stage_LoadStage10Graphics+A   p  ; was: sub_2F504
                movea.w #(byte_FFD8E0-M68K_RAM),a0
                moveq   #5,d7
loc_2F50A:                              ; CODE XREF: Enemy_InitStage10Debris+C   j
                bsr.s Enemy_InitDebrisEntity
                lea     $60(a0),a0
                dbf     d7,loc_2F50A
                rts
; End of function Enemy_InitStage10Debris
; Initializes single debris entity with position
Enemy_InitDebrisEntity:                              ; CODE XREF: Enemy_InitStage10Debris:loc_2F50A   p  ; was: sub_2F516
                move.w  #$208,(a0)
                move.w  #$8C80,2(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.b  #$7C,$20(a0) ; '|'
                move.w  (dword_FFA900).w,$48(a0)
                move.w  #$44F5,$E(a0)
; Sets random velocity and position for debris entities
Enemy_DebrisSetRandomVelocity:                              ; CODE XREF: Enemy_DebrisUpdate+8   j  ; was: loc_2F53E
                                        ; Enemy_DebrisUpdate+12   j ...
                moveq   #0,d0
                move.w  (dword_FFFF08+2).w,d0
                andi.w  #$7FFF,d0
                addi.w  #-$8000,d0
                move.l  d0,$1C(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                addi.w  #$A0,d0
                move.w  (dword_FFA900).w,d1
                sub.w   $48(a0),d1
                add.w   d1,d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$7F,d0
                addi.w  #$80,d0
                move.w  d0,$14(a0)
                jmp     (RandomNumber).l
; End of function Enemy_InitDebrisEntity
; Updates debris position with screen bounds
Enemy_DebrisUpdate:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2F580
                movea.w a5,a0
                cmpi.w  #$80,$10(a5)
                bmi.w Enemy_DebrisSetRandomVelocity
                cmpi.w  #$1C0,$10(a5)
                bpl.w Enemy_DebrisSetRandomVelocity
                cmpi.w  #$138,$14(a5)
                bpl.w Enemy_DebrisSetRandomVelocity
                move.w  (dword_FFA900).w,d0
                sub.w   $48(a5),d0
                asr.w   #1,d0
                sub.w   d0,$10(a5)
                move.w  (dword_FFA900).w,$48(a5)
                move.l  (dword_FF8240).w,d0
                asl.l   #1,d0
                move.l  d0,$18(a5)
                rts
; End of function Enemy_DebrisUpdate
; Main handler for ship platform
Enemy_ShipMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2F5C0
                move.l  $54(a5),d0
                add.l   d0,(dword_FFA908).w
                move.w  4(a5),d0
                movea.w off_2F5D8(pc,d0.w),a0
                adda.l  #Enemy_ShipInit,a0
                jmp     (a0)
; End of function Enemy_ShipMain
; ---------------------------------------------------------------------------
off_2F5D8:      dc.w Enemy_ShipInit-Enemy_ShipInit
                                        ; DATA XREF: Enemy_ShipMain+C   r
                dc.w Enemy_ShipInitPosition_Return-Enemy_ShipInit
                dc.w Enemy_ShipUpdatePosition-Enemy_ShipInit
                dc.w Enemy_ShipSpawnCannons-Enemy_ShipInit
                dc.w Enemy_ShipSpawnCannons_MainState-Enemy_ShipInit
                dc.w Enemy_ShipSpawnCannons_RiseUp-Enemy_ShipInit
                dc.w Enemy_ShipSpawnCannons_CheckDestruction-Enemy_ShipInit
                dc.w Enemy_ShipSpawnCannons_MainLoop-Enemy_ShipInit


; Initializes ship platform entity
Enemy_ShipInit:                              ; DATA XREF: Enemy_ShipMain+10   o  ; was: sub_2F5E8
                                        ; ROM:off_2F5D8   o ...
                addq.w  #2,4(a5)
                move.w  #$8D00,2(a5)
                move.w  #1,$24(a5)
                clr.w   $50(a5)
                clr.l   $54(a5)
                clr.w   $58(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$20,$21(a5) ; ' '
                move.w  #2,$46(a5)
                move.l  #$FFFC00F0,$28(a5)
                move.w  $10(a5),$4C(a5)
                move.w  $14(a5),$4E(a5)
; Return after ship enemy position init
Enemy_ShipInitPosition_Return:                           ; DATA XREF: ROM:0002F5DA   o  ; was: locret_2F62C
                rts
; End of function Enemy_ShipInit
; Updates ship platform position
Enemy_ShipUpdatePosition:                              ; DATA XREF: ROM:0002F5DC   o  ; was: sub_2F62E
                move.l  (dword_FFA900).w,-(sp)
                move.w  $50(a5),d0
                add.w   d0,(dword_FFA900).w
                jsr (Gfx_GetCameraPosition).l
                move.l  (sp)+,(dword_FFA900).w
                addq.w  #8,$50(a5)
                cmpi.w  #$90,$50(a5)
                bmi.w   locret_2F8B6
                move.w  #$38,(word_FFF74A).w ; '8'
                move.b  #3,(byte_FFA95A).w
                bset    #7,(dword_FFA20E).w
                addq.w  #2,4(a5)
                move.b  #$8B,d0
                jmp Input_CheckButtonMode
; End of function Enemy_ShipUpdatePosition
; Spawns 4 cannons on ship
Enemy_ShipSpawnCannons:                              ; DATA XREF: ROM:0002F5DE   o  ; was: sub_2F672
                move.b  #$55,d0 ; 'U'
                jsr (Sound_PlaySFX).l
loc_2F67C:                              ; CODE XREF: Enemy_ShipSpawnCannons+68   j
                move.w  #2,$58(a5)
                move.l  #$22000,$1C(a5)
                move.w  #8,4(a5)
; Main state for spawning and managing ship cannons
Enemy_ShipSpawnCannons_MainState:                              ; DATA XREF: ROM:0002F5E0   o  ; was: loc_2F690
                tst.w   $24(a5)
                bmi.w   loc_2F700
                bclr    #1,$5A(a5)
                bne.s   loc_2F6BC
                bclr    #0,$5A(a5)
                bne.s   loc_2F6E8
                bsr.w Enemy_ShipWaitForCannons
                bsr.w Enemy_ShipCheckDestroyed
                bsr.w Enemy_ShipExit
                bsr.w Stage_ShipDestructionCheckInput
                bra.w Enemy_ShipCannonSpawn
; ---------------------------------------------------------------------------
loc_2F6BC:                              ; CODE XREF: Enemy_ShipSpawnCannons+2C   j
                                        ; Enemy_ShipSpawnCannons+80   j
                move.w  #$A,4(a5)
                move.l  #$FFFEF000,$1C(a5)
; Ship rises up with upward velocity acceleration
Enemy_ShipSpawnCannons_RiseUp:                              ; DATA XREF: ROM:0002F5E2   o  ; was: loc_2F6CA
                addi.l  #$210,$1C(a5)
                bmi.s   loc_2F6DC
                cmpi.w  #$12C,$14(a5)
                bpl.s   loc_2F67C
loc_2F6DC:                              ; CODE XREF: Enemy_ShipSpawnCannons+60   j
                bsr.w Enemy_ShipCheckDestroyed
                bsr.w Stage_ShipDestructionCheckInput
                bra.w Enemy_ShipCannonSpawn
; ---------------------------------------------------------------------------
loc_2F6E8:                              ; CODE XREF: Enemy_ShipSpawnCannons+34   j
                addq.w  #4,4(a5)
; Checks destruction status and continues cannon spawning
Enemy_ShipSpawnCannons_CheckDestruction:                              ; DATA XREF: ROM:0002F5E4   o  ; was: loc_2F6EC
                bclr    #1,$5A(a5)
                bne.s   loc_2F6BC
                bsr.w Enemy_ShipCheckDestroyed
                bsr.w Stage_ShipDestructionCheckInput
                bra.w Enemy_ShipCannonSpawn
; ---------------------------------------------------------------------------
loc_2F700:                              ; CODE XREF: Enemy_ShipSpawnCannons+22   j
                move.w  #$E,4(a5)
; Main state updating ship palette, cannon fire, debris, and spawn logic
Enemy_ShipSpawnCannons_MainLoop:                              ; DATA XREF: ROM:0002F5E6   o  ; was: loc_2F706
                lea     word_2F726(pc),a4
                nop
                jsr (VBlank_UpdateSharpssteelPalette).l
                bsr.w Enemy_ShipCannonFirePattern
                bsr.w Enemy_ShipSpawnDebrisProjectile
                bsr.w Enemy_ShipWaitForCannons
                bsr.w Enemy_ShipCheckDestroyed
                bra.w Enemy_ShipCannonSpawn
; End of function Enemy_ShipSpawnCannons
; ---------------------------------------------------------------------------
word_2F726:     dc.w $A, $E322, $E324, $E326, $E328, $E32A, $E32C, $E32E, $E332, $E334, $E336, $E338
                                        ; DATA XREF: Enemy_ShipSpawnCannons:loc_2F706   o


; Waits for all cannons destroyed
Enemy_ShipWaitForCannons:                              ; CODE XREF: Enemy_ShipSpawnCannons+36   p  ; was: sub_2F73E
                                        ; Enemy_ShipSpawnCannons+A8   p
                tst.w   $58(a5)
                bne.s   loc_2F766
                cmpi.w  #$12E,$14(a5)
                bmi.s   loc_2F788
                move.l  $1C(a5),d0
                bpl.s   loc_2F75A
                cmpi.l  #$FFFF0000,d0
                bmi.s   locret_2F78E
loc_2F75A:                              ; CODE XREF: Enemy_ShipWaitForCannons+12   j
                subi.l  #$2000,d0
                move.l  d0,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2F766:                              ; CODE XREF: Enemy_ShipWaitForCannons+4   j
                cmpi.w  #$13C,$14(a5)
                bpl.s   loc_2F788
                move.l  $1C(a5),d0
                bmi.s   loc_2F77C
                cmpi.l  #$10000,d0
                bpl.s   locret_2F78E
loc_2F77C:                              ; CODE XREF: Enemy_ShipWaitForCannons+34   j
                addi.l  #$2000,d0
                move.l  d0,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2F788:                              ; CODE XREF: Enemy_ShipWaitForCannons+C   j
                                        ; Enemy_ShipWaitForCannons+2E   j
                eori.w  #2,$58(a5)
locret_2F78E:                           ; CODE XREF: Enemy_ShipWaitForCannons+1A   j
                                        ; Enemy_ShipWaitForCannons+3C   j
                rts
; End of function Enemy_ShipWaitForCannons
; Checks if all cannons destroyed
Enemy_ShipCheckDestroyed:                              ; CODE XREF: Enemy_ShipSpawnCannons+3A   p  ; was: sub_2F790
                                        ; sub_2F672:loc_2F6DC   p ...
                cmpi.l  #$C000,(dword_FF830A).w
                bpl.s   loc_2F7A2
                addi.l  #$100,(dword_FF830A).w
loc_2F7A2:                              ; CODE XREF: Enemy_ShipCheckDestroyed+8   j
                clr.l   (dword_FF8240).w
                btst    #5,(byte_FF8244).w
                bne.s   loc_2F7B6
                btst    #0,(byte_FF8244).w
                beq.s   loc_2F7C2
loc_2F7B6:                              ; CODE XREF: Enemy_ShipCheckDestroyed+1C   j
                move.l  $54(a5),d0
                neg.l   d0
                asr.l   #2,d0
                move.l  d0,(dword_FF8240).w
loc_2F7C2:                              ; CODE XREF: Enemy_ShipCheckDestroyed+24   j
                cmpi.l  #$B0000,$54(a5)
                bpl.s   locret_2F7D4
                addi.l  #$400,$54(a5)
locret_2F7D4:                           ; CODE XREF: Enemy_ShipCheckDestroyed+3A   j
                rts
; End of function Enemy_ShipCheckDestroyed
; Ship exit sequence
Enemy_ShipExit:                              ; CODE XREF: Enemy_ShipSpawnCannons+3E   p  ; was: sub_2F7D6
                tst.w   (word_FF80E6).w
                bne.w Enemy_ShipCannonFirePattern
                btst    #0,(byte_FF8244).w
                bne.s Enemy_ShipCannonFirePattern
                btst    #2,(word_FFF706).w
                beq.s   loc_2F80A
                cmpi.w  #$70,$10(a5) ; 'p'
                bmi.s   loc_2F848
loc_2F7F6:                              ; CODE XREF: Enemy_ShipCannonFirePattern+10   j
                cmpi.l  #$FFFD0000,$18(a5)
                bmi.s   locret_2F808
                subi.l  #$2000,$18(a5)
locret_2F808:                           ; CODE XREF: Enemy_ShipExit+28   j
                                        ; Enemy_ShipExit+4C   j
                rts
; ---------------------------------------------------------------------------
loc_2F80A:                              ; CODE XREF: Enemy_ShipExit+16   j
                btst    #3,(word_FFF706).w
                beq.s Enemy_ShipCannonFirePattern
                cmpi.w  #$100,$10(a5)
                bpl.s   loc_2F848
loc_2F81A:                              ; CODE XREF: Enemy_ShipCannonFirePattern+18   j
                cmpi.l  #$30000,$18(a5)
                bpl.s   locret_2F808
                addi.l  #$2000,$18(a5)
                rts
; End of function Enemy_ShipExit
; Cannon firing pattern logic
Enemy_ShipCannonFirePattern:                              ; CODE XREF: Enemy_ShipSpawnCannons+A0   p  ; was: sub_2F82E
                                        ; Enemy_ShipExit+4   j ...
                move.w  $10(a5),d0
                subi.w  #$B0,d0
                bmi.s   loc_2F840
                cmpi.w  #$10,d0
                bmi.s   loc_2F848
                bra.s   loc_2F7F6
; ---------------------------------------------------------------------------
loc_2F840:                              ; CODE XREF: Enemy_ShipCannonFirePattern+8   j
                cmpi.w  #$FFF0,d0
                bpl.s   loc_2F848
                bra.s   loc_2F81A
; ---------------------------------------------------------------------------
loc_2F848:                              ; CODE XREF: Enemy_ShipExit+1E   j
                                        ; Enemy_ShipExit+42   j ...
                move.l  $18(a5),d0
                bpl.s   loc_2F858
                addi.l  #$1800,d0
                bmi.s   loc_2F862
                bra.s   loc_2F860
; ---------------------------------------------------------------------------
loc_2F858:                              ; CODE XREF: Enemy_ShipCannonFirePattern+1E   j
                subi.l  #$1800,d0
                bpl.s   loc_2F862
loc_2F860:                              ; CODE XREF: Enemy_ShipCannonFirePattern+28   j
                moveq   #0,d0
loc_2F862:                              ; CODE XREF: Enemy_ShipCannonFirePattern+26   j
                                        ; Enemy_ShipCannonFirePattern+30   j
                move.l  d0,$18(a5)
                rts
; End of function Enemy_ShipCannonFirePattern
; Checks input flags for scroll updates
Stage_ShipDestructionCheckInput:                              ; CODE XREF: Enemy_ShipSpawnCannons+42   p  ; was: sub_2F868
                                        ; Enemy_ShipSpawnCannons+6E   p ...
                btst    #0,(word_FFA000+1).w
                beq.s   locret_2F884
                btst    #1,(word_FFA000+1).w
                beq.s   loc_2F886
                move.l  #$4C705B01,d0
                jsr (Scroll_UpdateStage14Scroll).l
locret_2F884:                           ; CODE XREF: Stage_ShipDestructionCheckInput+6   j
                rts
; ---------------------------------------------------------------------------
loc_2F886:                              ; CODE XREF: Stage_ShipDestructionCheckInput+E   j
                move.l  #$4C705CA1,d0
                jsr (Scroll_UpdateStage14Scroll).l
                rts
; End of function Stage_ShipDestructionCheckInput
; Spawns single cannon entity
Enemy_ShipCannonSpawn:                              ; CODE XREF: Enemy_ShipSpawnCannons+46   j  ; was: sub_2F894
                                        ; Enemy_ShipSpawnCannons+72   j ...
                move.w  #$40,d0 ; '@'
                sub.w   $10(a5),d0
                neg.w   d0
                move.w  d0,(word_FFE400).w
                move.w  $14(a5),d0
                addi.w  #-$30,d0
                neg.w   d0
                move.w  (word_FFA012).w,d1
                add.w   d1,d0
                move.w  d0,(word_FFEC00).w
locret_2F8B6:                           ; CODE XREF: Enemy_ShipUpdatePosition+20   j
                rts
; End of function Enemy_ShipCannonSpawn
; Spawns debris projectile with random offset
Enemy_ShipSpawnDebrisProjectile:                              ; CODE XREF: Enemy_ShipSpawnCannons+A4   p  ; was: sub_2F8B8
                jsr (Projectile_SpawnAtPosition).l
                bne.s   locret_2F90C
                jsr (Sprite_InitFromTable).l
                move.b  #0,$20(a0)
                move.w  #$FFFD,$1C(a0)
                move.w  (dword_FFFF08+2).w,$1E(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0 ; '?'
                andi.w  #$3F,d1 ; '?'
                subi.w  #$10,d0
                subi.w  #$18,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
locret_2F90C:                           ; CODE XREF: Enemy_ShipSpawnDebrisProjectile+6   j
                rts
; End of function Enemy_ShipSpawnDebrisProjectile
; Main handler for ship cannon 1
Enemy_ShipCannon1Main:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2F90E
                move.w  4(a5),d0
                movea.w off_2F91E(pc,d0.w),a0
                adda.l  #Enemy_ShipCannon1Init,a0
                jmp     (a0)
; End of function Enemy_ShipCannon1Main
; ---------------------------------------------------------------------------
off_2F91E:      dc.w Enemy_ShipCannon1Init-Enemy_ShipCannon1Init
                                        ; DATA XREF: Enemy_ShipCannon1Main+4   r
                dc.w Enemy_ShipCannonEmptyWait-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon1Init_WaitCamera-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon1Wait-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon1Wait_FallGravity-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon1Destroyed-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon1Wait_FacePlayer-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon1Wait_SecondTimer-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon1Wait_ApplyGravity-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon1Destroyed_WaitTimer-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon2Main-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon2Init-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon2Dispatcher-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon2Dispatcher_FireState-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon2Wait-Enemy_ShipCannon1Init
                dc.w Enemy_ShipCannon2Wait_ApplyGravity-Enemy_ShipCannon1Init


; Initializes ship cannon 1
Enemy_ShipCannon1Init:                              ; DATA XREF: Enemy_ShipCannon1Main+8   o  ; was: sub_2F93E
                                        ; ROM:off_2F91E   o ...
                addq.w  #4,4(a5)
                move.w  #$ED00,2(a5)
                move.w  #$8000,$E(a5)
                move.l  #off_1A0F76,8(a5)
                clr.w   $C(a5)
                move.b  #$3C,$20(a5) ; '<'
                move.w  #$800,$24(a5)
                move.b  #$80,$21(a5)
                move.l  #$F60AF40C,$28(a5)
                move.w  #$120,$14(a5)
; Waits for camera position to reach threshold before activation
Enemy_ShipCannon1Init_WaitCamera:                              ; DATA XREF: ROM:0002F922   o  ; was: loc_2F97A
                cmpi.w  #$17A0,(dword_FFA900).w
                bmi.s   loc_2F9B8
                movea.w #(word_FFC620-M68K_RAM),a0
loc_2F986:                              ; CODE XREF: Enemy_ShipCannon1Init+56   j
                cmpi.w  #$36C,(a0)
                beq.s   loc_2F9B8
                lea     $60(a0),a0
                cmpa.w  #$DB20,a0
                bmi.s   loc_2F986
                bset    #0,(byte_FFA272).w
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5) ; '@'
                move.l  #off_1A0F62,8(a5)
                clr.w   $C(a5)
                clr.b   $21(a5)
                rts
; ---------------------------------------------------------------------------
loc_2F9B8:                              ; CODE XREF: Enemy_ShipCannon1Init+42   j
                                        ; Enemy_ShipCannon1Init+4C   j
                tst.w   $24(a5)
                bmi.s   loc_2F9C2
                bra.w Enemy_CannonFireProjectile
; ---------------------------------------------------------------------------
loc_2F9C2:                              ; CODE XREF: Enemy_ShipCannon1Init+7E   j
                clr.b   $21(a5)
                move.w  #2,4(a5)
                move.l  #off_1A0FD2,8(a5)
                clr.w   $C(a5)
                bclr    #0,(byte_FFA272).w
                rts
; End of function Enemy_ShipCannon1Init
; Empty wait handler for ship cannon enemy
Enemy_ShipCannonEmptyWait:                             ; CODE XREF: Enemy_ShipCannon1Wait+4   j  ; was: nullsub_71
                                        ; Enemy_ShipCannon1Wait+26   j ...
                rts
; End of function Enemy_ShipCannonEmptyWait
; Cannon 1 wait state
Enemy_ShipCannon1Wait:                              ; DATA XREF: ROM:0002F924   o  ; was: sub_2F9E2
                subq.w  #1,$48(a5)
                bpl.s Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.l  #$FFFD8000,$1C(a5)
                move.l  #off_1A0EB6,8(a5)
                clr.w   $C(a5)
; Applies gravity until cannon reaches floor position at Y=120
Enemy_ShipCannon1Wait_FallGravity:                              ; DATA XREF: ROM:0002F926   o  ; was: loc_2FA00
                addi.l  #$3800,$1C(a5)
                bmi.s Enemy_ShipCannonEmptyWait
                cmpi.w  #$120,$14(a5)
                bmi.s Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5) ; ' '
                move.w  #$120,$14(a5)
                clr.l   $1C(a5)
                move.l  #off_1A0FA6,8(a5)
                clr.w   $C(a5)
                btst    #0,(byte_FFA209).w
                bne.w   loc_2FA8E
                rts
; End of function Enemy_ShipCannon1Wait
; Cannon 1 destroyed state
Enemy_ShipCannon1Destroyed:                              ; DATA XREF: ROM:0002F928   o  ; was: sub_2FA3E
                bsr.w Enemy_UpdateFlipToPlayer
                subq.w  #1,$48(a5)
                bpl.s Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.w  #$A0,$48(a5)
                move.l  #off_1A0F8A,8(a5)
                clr.w   $C(a5)
; Updates cannon flip direction to face player
Enemy_ShipCannon1Wait_FacePlayer:                              ; DATA XREF: ROM:0002F92A   o  ; was: loc_2FA5E
                bsr.w Enemy_UpdateFlipToPlayer
                subq.w  #1,$48(a5)
                bpl.w Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                bclr    #3,$E(a5)
                move.w  #$40,$48(a5) ; '@'
                move.l  #off_1A0FB2,8(a5)
                clr.w   $C(a5)
; Second timer wait state before cannon fires
Enemy_ShipCannon1Wait_SecondTimer:                              ; DATA XREF: ROM:0002F92C   o  ; was: loc_2FA86
                subq.w  #1,$48(a5)
                bpl.w Enemy_ShipCannonEmptyWait
loc_2FA8E:                              ; CODE XREF: Enemy_ShipCannon1Wait+56   j
                move.w  #$10,4(a5)
                move.l  #off_1A0EDE,8(a5)
                clr.w   $C(a5)
                move.b  (byte_FFA420).w,$20(a5)
                move.l  #$FFFF5000,$18(a5)
                move.l  #$FFFA0000,$1C(a5)
; Applies upward then downward gravity to cannon
Enemy_ShipCannon1Wait_ApplyGravity:                              ; DATA XREF: ROM:0002F92E   o  ; was: loc_2FAB6
                addi.l  #$4000,$1C(a5)
                bmi.w Enemy_ShipCannonEmptyWait
                bclr    #7,$E(a5)
                cmpi.l  #$54000,$1C(a5)
                bmi.w Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5) ; ' '
                move.w  #$E000,2(a5)
; Cannon post-destruction wait state before next animation phase
Enemy_ShipCannon1Destroyed_WaitTimer:                              ; DATA XREF: ROM:0002F930   o  ; was: loc_2FAE4
                bsr.w Enemy_ShipCannon3Main
                subq.w  #1,$48(a5)
                bpl.w Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5) ; ' '
                move.l  #off_1A0EDE,8(a5)
                clr.w   $C(a5)
                move.b  #$18,d0
                jmp (Sound_PlaySFX).l
; End of function Enemy_ShipCannon1Destroyed
; Main handler for ship cannon 2
Enemy_ShipCannon2Main:                              ; DATA XREF: ROM:0002F932   o  ; was: sub_2FB10
                bsr.w Enemy_ShipCannon3Main
                subq.w  #1,$48(a5)
                bpl.w Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.l  #off_1A0ED2,8(a5)
                clr.w   $C(a5)
                addq.w  #2,(word_FFA950).w
                addq.w  #2,(word_FFDB24).w
                move.w  #$F,(word_FF829E).w
                bclr    #0,(byte_FFA272).w
                move.l  #off_1A0EB6,8(a5)
                rts
; End of function Enemy_ShipCannon2Main
; Initializes ship cannon 2
Enemy_ShipCannon2Init:                              ; DATA XREF: ROM:0002F934   o  ; was: sub_2FB4A
                move.b  (byte_FFA420).w,$20(a5)
                bra.w Enemy_ShipCannon3Main
; End of function Enemy_ShipCannon2Init
; State dispatcher for cannon 2
Enemy_ShipCannon2Dispatcher:                              ; DATA XREF: ROM:0002F936   o  ; was: sub_2FB54
                addq.w  #2,4(a5)
                move.l  #off_1A0EDE,8(a5)
                clr.w   $C(a5)
; Branches to cannon projectile fire routine
Enemy_ShipCannon2Dispatcher_FireState:                              ; DATA XREF: ROM:0002F938   o  ; was: loc_2FB64
                bra.w Enemy_CannonFireProjectile
; End of function Enemy_ShipCannon2Dispatcher
; Cannon 2 wait state
Enemy_ShipCannon2Wait:                              ; DATA XREF: ROM:0002F93A   o  ; was: sub_2FB68
                addq.w  #2,4(a5)
                move.l  #off_1A0FD6,8(a5)
                clr.w   $C(a5)
                move.w  #$EE00,2(a5)
; Applies upward velocity to cannon during wait state
Enemy_ShipCannon2Wait_ApplyGravity:                              ; DATA XREF: ROM:0002F93C   o  ; was: loc_2FB7E
                addi.l  #$2000,$1C(a5)
                rts
; End of function Enemy_ShipCannon2Wait
; Periodically fires downward projectiles with sound effect
Enemy_CannonFireProjectile:                              ; CODE XREF: Enemy_ShipCannon1Init+80   j  ; was: sub_2FB88
                                        ; sub_2FB54:loc_2FB64   j
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0 ; '?'
                bne.s   locret_2FBE8
                move.b  #$2C,d0 ; ','
                jsr (Sound_PlaySFX).l
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2FBE8
                move.w  #$188,(a0)
                move.w  #$8500,2(a0)
                move.w  #$C168,$E(a0)
                move.w  #$D00,8(a0)
                move.w  #$F0F8,$A(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$FFFF,$1C(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                subi.w  #$10,$14(a0)
                move.w  #$18,$48(a0)
locret_2FBE8:                           ; CODE XREF: Enemy_CannonFireProjectile+8   j
                                        ; Enemy_CannonFireProjectile+1A   j
                rts
; End of function Enemy_CannonFireProjectile
; Main handler for ship cannon 3
Enemy_ShipCannon3Main:                              ; CODE XREF: Enemy_ShipCannon1Destroyed:loc_2FAE4   p  ; was: sub_2FBEA
                                        ; sub_2FB10   p ...
                bset    #3,$E(a5)
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  $10(a0),d0
                addi.w  #$44,d0 ; 'D'
                move.w  d0,$10(a5)
                move.w  $14(a0),d0
                subi.w  #$27,d0 ; '''
                move.w  d0,$14(a5)
                rts
; End of function Enemy_ShipCannon3Main
; Updates horizontal sprite flip based on player X position
Enemy_UpdateFlipToPlayer:                              ; CODE XREF: Enemy_ShipCannon1Destroyed   p  ; was: sub_2FC0E
                                        ; sub_2FA3E:loc_2FA5E   p
                bclr    #3,$E(a5)
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bpl.s   locret_2FC24
                bset    #3,$E(a5)
locret_2FC24:                           ; CODE XREF: Enemy_UpdateFlipToPlayer+E   j
                rts
; End of function Enemy_UpdateFlipToPlayer
; Main dispatcher checking screen bounds and routing to state
Enemy_ProjectileMainDispatch:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2FC26
                cmpi.w  #$70,$10(a5) ; 'p'
                bpl.s   loc_2FC34
                move.w  #4,4(a5)
loc_2FC34:                              ; CODE XREF: Enemy_ProjectileMainDispatch+6   j
                nop
                move.w  4(a5),d0
                movea.w off_2FC46(pc,d0.w),a0 ; debug this link
                adda.l  #Enemy_ProjectileInit,a0
                jmp     (a0)
; End of function Enemy_ProjectileMainDispatch
; ---------------------------------------------------------------------------
off_2FC46:      dc.w Projectile_Stage18Homing+2-Enemy_ProjectileInit
                                        ; DATA XREF: Enemy_ProjectileMainDispatch+14   r
                                        ; debug this link
                dc.w Enemy_SpawnFromTable-Enemy_ProjectileInit
                dc.w Enemy_SpawnFromTable_CheckSpawn-Enemy_ProjectileInit


; Initializes projectile sprite with graphics and movement parameters
Enemy_ProjectileInit:                              ; DATA XREF: Enemy_ProjectileMainDispatch+18   o  ; was: sub_2FC4C
                                        ; ROM:off_2FC46   o ...
                addq.w  #2,4(a5)
                move.w  #$100,2(a5)
                ori.w   #$8000,2(a5)
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2FC78
                move.w  #$C4AC,$E(a5)
                bra.s   loc_2FC7E
; ---------------------------------------------------------------------------
loc_2FC78:                              ; CODE XREF: Enemy_ProjectileInit+22   j
                move.w  #$C4B4,$E(a5)
loc_2FC7E:                              ; CODE XREF: Enemy_ProjectileInit+2A   j
                move.w  #$20,$4A(a5) ; ' '
                move.w  #5,$4E(a5)
                move.w  $5E(a5),d0
                move.w  word_2FCA8(pc,d0.w),$50(a5)
                move.w  #$4000,$52(a5)
                move.b  #0,$54(a5)
                move.b  #1,$55(a5)
                rts
; End of function Enemy_ProjectileInit
; ---------------------------------------------------------------------------
word_2FCA8:     dc.w $42E5, $4291, $42B5, $42E1, $4285, $42B1, $42D5, $4281
                                        ; DATA XREF: Enemy_ProjectileInit+42   r


nullsub_72:                             ; CODE XREF: Boss_EnableVisibilityFlag+4   j
                rts
; End of function nullsub_72


; Waits for animation then enables sprite visibility flag
Boss_EnableVisibilityFlag:
                tst.w   $48(a5)  ; was: sub_2FCBA
                bne.s   nullsub_72
                bset    #4,2(a5)
                clr.w   $4C(a5)
                bra.w   loc_2F4DC
; End of function Boss_EnableVisibilityFlag
; Updates boss graphics tiles via DMA based on animation frame
Boss_UpdateTilesDMA:
                tst.w   $48(a5)  ; was: sub_2FCCE
                bne.w   locret_2F418
                move.w  $4C(a5),d0
                move.w  word_2FCEC(pc,d0.w),$56(a5)
                movea.w a5,a0
                adda.w  #$50,a0 ; 'P'
                jmp Gfx_DMATransferTiles
; End of function Boss_UpdateTilesDMA
; ---------------------------------------------------------------------------
word_2FCEC:     dc.w $878C, $888D, $898E, $8A8F, $8B90
                                        ; DATA XREF: Boss_UpdateTilesDMA+C   r


; Floating enemy that oscillates horizontally and vertically
Enemy_FloatingOscillator:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2FCF6
                tst.w   4(a5)
                bne.s   loc_2FD4A
                addq.w  #2,4(a5)
                move.b  #$20,$21(a5) ; ' '
                move.w  #2,$46(a5)
                move.w  #$C500,2(a5)
                move.w  #$480,$E(a5)
                move.l  #word_E907A,8(a5)
                move.w  #$A050,$2A(a5)
                move.w  $10(a5),$4C(a5)
                move.w  $14(a5),$4E(a5)
                clr.w   $50(a5)
                clr.w   $52(a5)
                clr.w   $54(a5)
                move.w  #$160,$10(a5)
                move.w  #$110,$14(a5)
loc_2FD4A:                              ; CODE XREF: Enemy_FloatingOscillator+4   j
                subq.w  #1,$54(a5)
                bpl.s   loc_2FD5C
                move.w  #9,$54(a5)
                eori.w  #1,$52(a5)
loc_2FD5C:                              ; CODE XREF: Enemy_FloatingOscillator+58   j
                tst.w   $52(a5)
                bne.s   loc_2FD6C
                subi.l  #$12000,$10(a5)
                bra.s   loc_2FD74
; ---------------------------------------------------------------------------
loc_2FD6C:                              ; CODE XREF: Enemy_FloatingOscillator+6A   j
                addi.l  #$12000,$10(a5)
loc_2FD74:                              ; CODE XREF: Enemy_FloatingOscillator+74   j
                tst.w   $50(a5)
                bne.s   loc_2FD92
                move.l  #$FFFEDD00,$1C(a5)
                cmpi.w  #$100,$14(a5)
                bpl.s   locret_2FDA8
                eori.w  #1,$50(a5)
                bra.s   locret_2FDA8
; ---------------------------------------------------------------------------
loc_2FD92:                              ; CODE XREF: Enemy_FloatingOscillator+82   j
                move.l  #$12300,$1C(a5)
                cmpi.w  #$140,$14(a5)
                bmi.s   locret_2FDA8
                eori.w  #1,$50(a5)
locret_2FDA8:                           ; CODE XREF: Enemy_FloatingOscillator+92   j
                                        ; Enemy_FloatingOscillator+9A   j ...
                rts
; End of function Enemy_FloatingOscillator
; Boss spawn and initialization
Boss_DestroyerMK2Spawn:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2FDAA
                bclr    #7,$E(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
                tst.w   4(a5)
                bne.w   loc_2FE14
                addq.w  #2,4(a5)
                move.w  #$CD00,2(a5)
                move.l  #word_1B1090,8(a5)
                move.w  #$4470,$E(a5)
                cmpi.w  #$18,(word_FFA204).w
                bcc.s   loc_2FDEE
                move.l  #word_1A0CD0,8(a5)
                move.w  #$4000,$E(a5)
loc_2FDEE:                              ; CODE XREF: Boss_DestroyerMK2Spawn+34   j
                move.b  #$20,$21(a5) ; ' '
                move.w  #2,$46(a5)
                move.l  #$FFE00020,$28(a5)
                move.w  $10(a5),$4C(a5)
                move.w  $14(a5),$4E(a5)
                move.w  $4E(a5),$52(a5)
loc_2FE14:                              ; CODE XREF: Boss_DestroyerMK2Spawn+12   j
                bclr    #0,6(a5)
                bne.s   loc_2FE28
                subq.w  #1,$50(a5)
                bpl.s   loc_2FE34
                clr.w   $50(a5)
                bra.s   loc_2FE34
; ---------------------------------------------------------------------------
loc_2FE28:                              ; CODE XREF: Boss_DestroyerMK2Spawn+70   j
                cmpi.w  #6,$50(a5)
                bpl.s   loc_2FE34
                addq.w  #1,$50(a5)
loc_2FE34:                              ; CODE XREF: Boss_DestroyerMK2Spawn+76   j
                                        ; Boss_DestroyerMK2Spawn+7C   j ...
                move.w  $50(a5),d0
                add.w   $52(a5),d0
                move.w  d0,$14(a5)
                btst    #0,$5F(a5)
                bne.w   loc_2FEC4
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                move.w  d0,d5
                bpl.s   loc_2FE58
                neg.w   d0
loc_2FE58:                              ; CODE XREF: Boss_DestroyerMK2Spawn+AA   j
                cmpi.w  #$10,d0
                bpl.s   loc_2FE7C
                move.l  $18(a5),d0
                move.l  d0,d1
                bpl.s   loc_2FE68
                neg.l   d0
loc_2FE68:                              ; CODE XREF: Boss_DestroyerMK2Spawn+BA   j
                cmpi.l  #$2000,d0
                bpl.s   loc_2FE76
                clr.l   $18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2FE76:                              ; CODE XREF: Boss_DestroyerMK2Spawn+C4   j
                tst.l   d1
                bmi.s   loc_2FE98
                bpl.s   loc_2FEBA
loc_2FE7C:                              ; CODE XREF: Boss_DestroyerMK2Spawn+B2   j
                tst.w   d5
                bmi.s   loc_2FEA2
                tst.w   $18(a5)
                bmi.s   loc_2FE98
                cmpi.w  #2,$18(a5)
                bmi.s   loc_2FE98
                move.l  #$20000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2FE98:                              ; CODE XREF: Boss_DestroyerMK2Spawn+CE   j
                                        ; Boss_DestroyerMK2Spawn+DA   j ...
                addi.l  #$1200,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2FEA2:                              ; CODE XREF: Boss_DestroyerMK2Spawn+D4   j
                tst.w   $18(a5)
                bpl.s   loc_2FEBA
                cmpi.w  #$FFFE,$18(a5)
                bpl.s   loc_2FEBA
                move.l  #$FFFE0000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2FEBA:                              ; CODE XREF: Boss_DestroyerMK2Spawn+D0   j
                                        ; Boss_DestroyerMK2Spawn+FC   j ...
                subi.l  #$1200,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2FEC4:                              ; CODE XREF: Boss_DestroyerMK2Spawn+9C   j
                cmpi.w  #$70,$10(a5) ; 'p'
                bpl.s   locret_2FED2
                bset    #4,2(a5)
locret_2FED2:                           ; CODE XREF: Boss_DestroyerMK2Spawn+120   j
                rts
; End of function Boss_DestroyerMK2Spawn
; Initializes Stage 18 enemies
Enemy_Stage18Init:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2FED4
                tst.w   $50(a5)
                bne.w Projectile_Stage18Bullet
                cmpi.w  #2,4(a5)
                bne.s   loc_2FF08
                move.w  $24(a5),d1
                movea.w $44(a5),a0
                move.w  #$B,d0
loc_2FEF0:                              ; CODE XREF: Enemy_Stage18Init+24   j
                add.w   $24(a0),d1
                movea.w $44(a0),a0
                dbf     d0,loc_2FEF0
                cmpi.w  #$CE0,d1
                bcc.s   loc_2FF08
                move.w  #4,4(a5)
loc_2FF08:                              ; CODE XREF: Enemy_Stage18Init+E   j
                                        ; Enemy_Stage18Init+2C   j
                move.w  4(a5),d0
                lea     off_2FF14(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage18Init
; ---------------------------------------------------------------------------
off_2FF14:      dc.w Enemy_Stage18SpawnerMain-*        ; DATA XREF: Enemy_Stage18Init+38   o
                dc.w Enemy_Stage18FloaterAttack-*
                dc.w Boss_InitJetsripperSpread-*
                dc.w Boss_UpdateFallingSpawner-*


; Enemy spawner main handler
Enemy_Stage18SpawnerMain:                              ; DATA XREF: ROM:off_2FF14   o  ; was: sub_2FF1C
                bsr.w Enemy_Stage18FloaterMain
                move.w  #$D00,2(a5)
                clr.b   $21(a5)
                clr.w   $5A(a5)
                tst.w   $5E(a5)
                beq.s   loc_2FF4A
                move.w  $10(a5),d0
                addi.w  #$20,d0 ; ' '
                cmp.w   (dword_FFA410).w,d0
                bcc.w   locret_30BB8
                move.w  #1,$5A(a5)
loc_2FF4A:                              ; CODE XREF: Enemy_Stage18SpawnerMain+16   j
                lea     off_30028(pc),a4
                nop
                lea     dword_30058(pc),a3
                nop
                movea.w a5,a1
                move.w  #$1000,2(a5)
                move.w  #$B,d7
loc_2FF62:                              ; CODE XREF: Enemy_Stage18SpawnerMain+8E   j
                jsr (Projectile_FindFreeSlotAndClear).l
                bne.w   locret_30BB8
                move.w  #$1000,2(a0)
                move.w  #$448,(a0)
                move.w  #1,$50(a0)
                move.w  #$100,$24(a0)
                move.w  a0,$44(a1)
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                clr.w   4(a0)
                move.w  d7,d0
                lsl.w   #1,d0
                move.l  (a3,d0.w),$54(a0)
                lsl.w   #1,d0
                move.l  (a4,d0.w),8(a0)
                movea.w a0,a1
                dbf     d7,loc_2FF62
                move.w  #$D00,2(a5)
                movea.w a5,a0
                move.w  #$B,d7
loc_2FFBA:                              ; CODE XREF: Enemy_Stage18SpawnerMain+A8   j
                movea.w $44(a0),a0
                move.w  #$CD00,2(a0)
                dbf     d7,loc_2FFBA
                clr.w   $44(a1)
                clr.w   $54(a5)
                bsr.w Enemy_Stage18FloaterInit
                move.l  #word_EB4A6,8(a5)
                bra.w   loc_301E6
; End of function Enemy_Stage18SpawnerMain
; Floater enemy initialization
Enemy_Stage18FloaterInit:                              ; CODE XREF: Enemy_Stage18SpawnerMain+B4   p  ; was: sub_2FFE0
                                        ; sub_304A4   j
                addq.w  #2,4(a5)
; End of function Enemy_Stage18FloaterInit
; Floater enemy main handler
Enemy_Stage18FloaterMain:                              ; CODE XREF: Enemy_Stage18SpawnerMain   p  ; was: sub_2FFE4
                move.w  #$CD00,2(a5)
                move.w  #$380,$E(a5)
                move.b  #$20,$20(a5) ; ' '
                move.b  #$C0,$21(a5)
                move.l  #$F808F808,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$26(a5) ; '('
                move.w  #$100,$24(a5)
                tst.w   (word_FFFF0E).w
                beq.w   locret_30BB8
                move.w  #$104,$24(a5)
                rts
; End of function Enemy_Stage18FloaterMain
; ---------------------------------------------------------------------------
off_30028:      dc.l word_EB51E         ; DATA XREF: Enemy_Stage18SpawnerMain:loc_2FF4A   o
                dc.l word_EB4EE
                dc.l word_EB4EE
                dc.l word_EB4EE
                dc.l word_EB4EE
                dc.l word_EB4EE
                dc.l word_EB4EE
                dc.l word_EB4EE
                dc.l word_EB4EE
                dc.l word_EB4EE
                dc.l word_EB4EE
                dc.l word_EB4EE
dword_30058:    dc.l $80004, $40004, $40004, $40004, $40004, $40004
                                        ; DATA XREF: Enemy_Stage18SpawnerMain+34   o
off_30070:      dc.l off_3007C          ; DATA XREF: Boss_UpdateAnimationCycle+4   o
                                        ; Projectile_Stage18Homing+10   o
                dc.l off_300BC
                dc.l off_300FC
off_3007C:      dc.l word_EB4A6         ; DATA XREF: ROM:off_30070   o
                                        ; Enemy_Stage18FloaterAttack+18   o
                dc.l word_EB4D6
                dc.l word_EB4CA
                dc.l word_EB4B2
                dc.l word_EB4A6
                dc.l word_EB4D6
                dc.l word_EB4CA
                dc.l word_EB4B2
                dc.l word_EB4A6
                dc.l word_EB4B2
                dc.l word_EB4CA
                dc.l word_EB4D6
                dc.l word_EB4A6
                dc.l word_EB4B2
                dc.l word_EB4CA
                dc.l word_EB4D6
off_300BC:      dc.l word_EB4EE         ; DATA XREF: ROM:00030074   o
                dc.l word_EB512
                dc.l word_EB506
                dc.l word_EB4FA
                dc.l word_EB4EE
                dc.l word_EB512
                dc.l word_EB506
                dc.l word_EB4FA
                dc.l word_EB4EE
                dc.l word_EB4FA
                dc.l word_EB506
                dc.l word_EB512
                dc.l word_EB4EE
                dc.l word_EB4FA
                dc.l word_EB506
                dc.l word_EB512
off_300FC:      dc.l word_EB51E         ; DATA XREF: ROM:00030078   o
                dc.l word_EB54E
                dc.l word_EB542
                dc.l word_EB52A
                dc.l word_EB51E
                dc.l word_EB54E
                dc.l word_EB542
                dc.l word_EB52A
                dc.l word_EB51E
                dc.l word_EB52A
                dc.l word_EB542
                dc.l word_EB54E
                dc.l word_EB51E
                dc.l word_EB52A
                dc.l word_EB542
                dc.l word_EB54E
word_3013C:     dc.w $380, $380, $1B80, $1B80, $1B80, $1B80, $380, $380, $1380, $1380, $1380, $B80, $B80, $B80, $B80, $1380
                                        ; DATA XREF: Enemy_Stage18FloaterAttack+1C   o
                                        ; Boss_UpdateAnimationCycle+24   o ...


; Floater enemy attack pattern
Enemy_Stage18FloaterAttack:                              ; DATA XREF: ROM:0002FF16   o  ; was: sub_3015C
                bsr.w Enemy_Stage18FloaterDeath
                bsr.w Enemy_Stage18TurretInit
                addi.l  #$2000,$1C(a5)
                bsr.w Enemy_Stage18TurretMain
                move.w  d0,$58(a5)
                lea     off_3007C(pc),a0
                lea     word_3013C(pc),a1
                move.l  (a0,d0.w),8(a5)
                lsr.w   #1,d0
                move.w  (a1,d0.w),$E(a5)
                clr.w   d0
                move.w  #0,d1
                jsr (Physics_AddEntityOffset).l
                bne.s   loc_301D6
                tst.w   $10(a5)
                bmi.s   loc_301A8
                cmpi.w  #$200,$14(a5)
                bcs.w   locret_30BB8
loc_301A8:                              ; CODE XREF: Enemy_Stage18FloaterAttack+40   j
                move.w  #$1000,2(a5)
                movea.w $44(a5),a4
                tst.w   $44(a5)
                beq.w   locret_30BB8
                move.w  #$B,d6
loc_301BE:                              ; CODE XREF: Enemy_Stage18FloaterAttack+74   j
                move.w  #$1000,2(a4)
                tst.w   $44(a4)
                beq.w   locret_30BB8
                movea.w $44(a4),a4
                dbf     d6,loc_301BE
                rts
; ---------------------------------------------------------------------------
loc_301D6:                              ; CODE XREF: Enemy_Stage18FloaterAttack+3A   j
                move.b  #$EC,d0
                jsr (Sound_PlaySFX).l
                jsr (Physics_AlignToTerrain).l
loc_301E6:                              ; CODE XREF: Enemy_Stage18SpawnerMain+C0   j
                move.l  #$FFFB0000,$1C(a5)
                move.l  $14(a5),$4C(a5)
                move.w  #6,$52(a5)
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                cmpi.w  #$4C0,d0
                bcc.s   loc_30220
                eori.w  #1,$5A(a5)
                bne.s   loc_30220
                move.l  #$20000,$18(a5)
                move.l  $18(a5),$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_30220:                              ; CODE XREF: Enemy_Stage18FloaterAttack+AA   j
                                        ; Enemy_Stage18FloaterAttack+B2   j
                move.l  #$FFFE0000,$18(a5)
                move.l  $18(a5),$48(a5)
                rts
; End of function Enemy_Stage18FloaterAttack
; Floater enemy death handler
Enemy_Stage18FloaterDeath:                              ; CODE XREF: Enemy_Stage18FloaterAttack   p  ; was: sub_30230
                tst.w   $52(a5)
                beq.w   locret_30BB8
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                move.l  #off_EB566,8(a0)
                movea.w a0,a4
                jsr (Projectile_InitType88).l
                move.w  #$380,$E(a4)
loc_30258:                              ; CODE XREF: Boss_UpdateFallingSpawner+42   p
                move.l  $10(a5),$10(a4)
                move.l  $14(a5),$14(a4)
                jsr     (RandomNumber).l
                andi.w  #$FE,d0
                addi.w  #$100,d0
                bsr.w Enemy_GustheadGetAngleToPlayer
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a4)
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a4)
                rts
; End of function Enemy_Stage18FloaterDeath
; Turret enemy initialization
Enemy_Stage18TurretInit:                              ; CODE XREF: Enemy_Stage18FloaterAttack+4   p  ; was: sub_30288
                                        ; sub_304B0   p
                tst.w   $52(a5)
                beq.w   locret_30BB8
                subq.w  #1,$52(a5)
                bne.w   locret_30BB8
                tst.w   $44(a5)
                beq.w   locret_30BB8
                movea.w $44(a5),a0
                move.l  $48(a5),$18(a0)
                move.l  $48(a5),$48(a0)
                move.l  $4C(a5),$14(a0)
                move.l  $4C(a5),$4C(a0)
                move.l  #$FFFB0000,$1C(a0)
                move.w  #6,$52(a0)
                rts
; End of function Enemy_Stage18TurretInit
; Initializes 12 projectiles in spread pattern for Jetsripper boss
Boss_InitJetsripperSpread:                              ; DATA XREF: ROM:0002FF18   o  ; was: sub_302CC
                bsr.w Boss_CalcRandomAngle
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                clr.w   $56(a5)
                clr.b   $21(a5)
                move.w  #0,d0
                jsr (Boss_JetsripperAttackPattern1).l
                move.w  #$A,d5
                movea.w $44(a5),a4
                move.w  #$B,d6
loc_302F6:                              ; CODE XREF: Boss_InitJetsripperSpread+6A   j
                jsr (Projectile_FindFreeSlot).l
                bne.s   loc_30314
                move.w  #$FF,d0
                jsr     (loc_2BD20).l
                move.w  $10(a4),$10(a0)
                move.w  $14(a4),$14(a0)
loc_30314:                              ; CODE XREF: Boss_InitJetsripperSpread+30   j
                bsr.w Boss_CalcRandomAngle
                move.l  d0,$18(a4)
                move.l  d1,$1C(a4)
                move.w  d5,$56(a4)
                move.w  #4,4(a4)
                clr.b   $21(a4)
                addi.w  #$A,d5
                movea.w $44(a4),a4
                dbf     d6,loc_302F6
                move.b  #$C1,d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_InitJetsripperSpread
; Calculates random velocity at angle toward player
Boss_CalcRandomAngle:                              ; CODE XREF: Boss_InitJetsripperSpread   p  ; was: sub_3034A
                                        ; sub_302CC:loc_30314   p
                jsr     (RandomNumber).l
                andi.w  #$FE,d0
                addi.w  #$100,d0
                bsr.w Enemy_GustheadGetAngleToPlayer
                ext.l   d0
                asl.l   #3,d0
                ext.l   d1
                asl.l   #3,d1
                rts
; End of function Boss_CalcRandomAngle
; Updates falling entity that periodically spawns projectiles
Boss_UpdateFallingSpawner:                              ; DATA XREF: ROM:0002FF1A   o  ; was: sub_30366
                                        ; ROM:000304A2   o
                bsr.w Boss_UpdateAnimationCycle
                addi.l  #$2000,$1C(a5)
                clr.w   d0
                clr.w   d1
                jsr (Physics_AddEntityOffset).l
                bne.s   loc_303AE
                addq.w  #1,$56(a5)
                move.w  $56(a5),d0
                andi.w  #$1F,d0
                bne.w   locret_30BB8
loc_3038E:                              ; CODE XREF: Boss_UpdateFallingSpawner+4E   j
                jsr (Projectile_FindFreeSlotAndClear).l
                bne.w   locret_30BB8
                move.l  #off_E953C,8(a0)
                movea.w a0,a4
                jsr (Projectile_InitType88).l
                bsr.w   loc_30258
                rts
; ---------------------------------------------------------------------------
loc_303AE:                              ; CODE XREF: Boss_UpdateFallingSpawner+16   j
                move.w  #$1000,2(a5)
                bra.w   loc_3038E
; End of function Boss_UpdateFallingSpawner
; Updates animation and graphics based on rotation counter
Boss_UpdateAnimationCycle:                              ; CODE XREF: Boss_UpdateFallingSpawner   p  ; was: sub_303B8
                move.w  $54(a5),d0
                lea     off_30070(pc),a0
                movea.l (a0,d0.w),a0
                move.w  $58(a5),d0
                move.w  d0,d1
                andi.w  #$20,d0 ; ' '
                addi.w  #4,d1
                andi.w  #$1C,d1
                or.w    d1,d0
                move.w  d0,$58(a5)
                lea     word_3013C(pc),a1
                move.l  (a0,d0.w),8(a5)
                lsr.w   #1,d0
                move.w  (a1,d0.w),$E(a5)
                rts
; End of function Boss_UpdateAnimationCycle
; Turret enemy main handler
Enemy_Stage18TurretMain:                              ; CODE XREF: Enemy_Stage18FloaterAttack+10   p  ; was: sub_303F0
                                        ; Projectile_Stage18Homing+18   p
                bsr.w Enemy_Stage18TurretAim
                tst.l   $18(a5)
                bpl.w   locret_30BB8
                addi.w  #$20,d0 ; ' '
                rts
; End of function Enemy_Stage18TurretMain
; Turret aiming at player
Enemy_Stage18TurretAim:                              ; CODE XREF: Enemy_Stage18TurretMain   p  ; was: sub_30402
                move.l  $1C(a5),d1
                move.l  $18(a5),d0
                bmi.s Enemy_Stage18TurretFire
                tst.l   d1
                bpl.s   loc_30424
                neg.l   d1
                cmpi.l  #$40000,d1
                bcc.s   loc_30486
                cmpi.l  #$10000,d1
                bcc.s Enemy_Stage18TurretDeath
                bra.s   loc_30462
; ---------------------------------------------------------------------------
loc_30424:                              ; CODE XREF: Enemy_Stage18TurretAim+C   j
                cmpi.l  #$40000,d1
                bcc.s   loc_3046E
                cmpi.l  #$10000,d1
                bcc.s   loc_30468
                bra.s   loc_30462
; End of function Enemy_Stage18TurretAim
nullsub_73:
                rts
; End of function nullsub_73


; Turret firing projectile
Enemy_Stage18TurretFire:                              ; CODE XREF: Enemy_Stage18TurretAim+8   j  ; was: sub_30438
                tst.l   d1
                bpl.s   loc_30450
                neg.l   d1
                cmpi.l  #$40000,d1
                bcc.s   loc_30486
                cmpi.l  #$10000,d1
                bcc.s   loc_30480
                bra.s   loc_3047A
; ---------------------------------------------------------------------------
loc_30450:                              ; CODE XREF: Enemy_Stage18TurretFire+2   j
                cmpi.l  #$40000,d1
                bcc.s   loc_3046E
                cmpi.l  #$10000,d1
                bcc.s   loc_30474
                bra.s   loc_3047A
; ---------------------------------------------------------------------------
loc_30462:                              ; CODE XREF: Enemy_Stage18TurretAim+20   j
                                        ; Enemy_Stage18TurretAim+32   j
                move.w  #0,d0
                rts
; ---------------------------------------------------------------------------
loc_30468:                              ; CODE XREF: Enemy_Stage18TurretAim+30   j
                move.w  #4,d0
                rts
; ---------------------------------------------------------------------------
loc_3046E:                              ; CODE XREF: Enemy_Stage18TurretAim+28   j
                                        ; Enemy_Stage18TurretFire+1E   j
                move.w  #8,d0
                rts
; ---------------------------------------------------------------------------
loc_30474:                              ; CODE XREF: Enemy_Stage18TurretFire+26   j
                move.w  #$C,d0
                rts
; ---------------------------------------------------------------------------
loc_3047A:                              ; CODE XREF: Enemy_Stage18TurretFire+16   j
                                        ; Enemy_Stage18TurretFire+28   j
                move.w  #$10,d0
                rts
; ---------------------------------------------------------------------------
loc_30480:                              ; CODE XREF: Enemy_Stage18TurretFire+14   j
                move.w  #$14,d0
                rts
; ---------------------------------------------------------------------------
loc_30486:                              ; CODE XREF: Enemy_Stage18TurretAim+16   j
                                        ; Enemy_Stage18TurretFire+C   j
                move.w  #$18,d0
                rts
; End of function Enemy_Stage18TurretFire
; Turret death handler
Enemy_Stage18TurretDeath:                              ; CODE XREF: Enemy_Stage18TurretAim+1E   j  ; was: sub_3048C
                move.w  #$1C,d0
                rts
; End of function Enemy_Stage18TurretDeath
; Stage 18 bullet projectile
Projectile_Stage18Bullet:                              ; CODE XREF: Enemy_Stage18Init+4   j  ; was: sub_30492
                move.w  4(a5),d0
                lea     off_3049E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_Stage18Bullet
; ---------------------------------------------------------------------------
off_3049E:      dc.w Projectile_Stage18Missile-*        ; DATA XREF: Projectile_Stage18Bullet+4   o
                dc.w Projectile_Stage18Laser-*
                dc.w Boss_UpdateFallingSpawner-*


; Attributes: thunk
; Stage 18 missile projectile
Projectile_Stage18Missile:                              ; DATA XREF: ROM:off_3049E   o  ; was: sub_304A4
                bra.w Enemy_Stage18FloaterInit
; End of function Projectile_Stage18Missile
; Stage 18 laser projectile
Projectile_Stage18Laser:                              ; DATA XREF: ROM:000304A0   o  ; was: sub_304A8
                tst.l   $18(a5)
                beq.w   locret_30BB8
; End of function Projectile_Stage18Laser
; Stage 18 homing projectile
Projectile_Stage18Homing:                              ; DATA XREF: ROM:off_2FC46   o  ; was: sub_304B0
                bsr.w Enemy_Stage18TurretInit
                addi.l  #$2000,$1C(a5)
                move.w  $54(a5),d0
                lea     off_30070(pc),a0
                movea.l (a0,d0.w),a0
                bsr.w Enemy_Stage18TurretMain
                move.w  d0,$58(a5)
                lea     word_3013C(pc),a1
                move.l  (a0,d0.w),8(a5)
                lsr.w   #1,d0
                move.w  (a1,d0.w),$E(a5)
                rts
; End of function Projectile_Stage18Homing
; State dispatcher for falling object enemy type
Enemy_FallingObjectDispatch:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_304E4
                move.w  4(a5),d0
                lea     off_304F0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FallingObjectDispatch
; ---------------------------------------------------------------------------
off_304F0:      dc.w Enemy_FallingObjectInit-*        ; DATA XREF: Enemy_FallingObjectDispatch+4   o
                dc.w Enemy_CheckSpawnTimer-*


; Initializes falling object with graphics and spawn data pointer
Enemy_FallingObjectInit:                              ; DATA XREF: ROM:off_304F0   o  ; was: sub_304F4
                move.w  #$6000,2(a5)
                move.w  #$8000,$E(a5)
                move.l  #off_1A0F76,8(a5)
                move.l  #word_3055C,$40(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FallingObjectInit
; Checks camera position against spawn table timer
Enemy_CheckSpawnTimer:                              ; DATA XREF: ROM:000304F2   o  ; was: sub_30516
                move.w  (dword_FFA904).w,d0
                movea.l $40(a5),a4
; End of function Enemy_CheckSpawnTimer
; Spawns enemy at position from table when camera reaches Y coordinate
Enemy_SpawnFromTable:                              ; DATA XREF: ROM:0002FC48   o  ; was: sub_3051E
                cmp.w   (a4),d0
; Checks camera Y position and spawns enemy from table
Enemy_SpawnFromTable_CheckSpawn:                              ; DATA XREF: ROM:0002FC4A   o  ; was: loc_30520
                bcs.w   locret_30BB8
                jsr (Projectile_FindFreeSlotAndClear).l
                bne.s   loc_30554
                move.w  #$CD00,2(a0)
                move.w  #$3A0,(a0)
                move.w  (a4)+,d0
                sub.w   (dword_FFA904).w,d0
                neg.w   d0
                addi.w  #$C0,d0
                move.w  d0,$14(a0)
                move.w  (a4)+,$10(a0)
                clr.w   4(a0)
                move.l  a4,$40(a5)
                rts
; ---------------------------------------------------------------------------
loc_30554:                              ; CODE XREF: Enemy_SpawnFromTable+C   j
                addq.w  #4,a4
                move.l  a4,$40(a5)
                rts
; End of function Enemy_SpawnFromTable
; ---------------------------------------------------------------------------
word_3055C:     dc.w $E190, $200, $E1F0, $40, $E230, $200, $E290, $40, $E2E0, $40, $E320, $200, $E360, $200, $FFFF
                                        ; DATA XREF: Enemy_FallingObjectInit+14   o


; State dispatcher for flying enemy with multiple phases
Enemy_FlyingEnemyDispatch:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3057A
                move.w  4(a5),d0
                lea     off_30586(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyingEnemyDispatch
; ---------------------------------------------------------------------------
off_30586:      dc.w Boss_JetsripperWeaponInit-*        ; DATA XREF: Enemy_FlyingEnemyDispatch+4   o
                dc.w Boss_JetsripperWeaponWaitAndMove-*
                dc.w Boss_JetsripperWeaponMoveAndSpawn-*
                dc.w Boss_JetsripperWeaponDelayDestroy-*


; Initialize Jetsripper boss weapon properties and state
Boss_JetsripperWeaponInit:                              ; DATA XREF: ROM:off_30586   o  ; was: sub_3058E
                move.w  #$CD00,2(a5)
                move.w  #$A300,$E(a5)
                move.l  #word_EB386,8(a5)
                move.b  #$3C,$20(a5) ; '<'
                move.w  #$64,$24(a5) ; 'd'
                move.b  #$40,$21(a5) ; '@'
                move.l  #$FC04FC04,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$26(a5) ; '('
                move.w  #$80,$40(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperWeaponInit
; Wait for timer then move horizontally based on position
Boss_JetsripperWeaponWaitAndMove:                              ; DATA XREF: ROM:00030588   o  ; was: sub_305D6
                cmpi.w  #$100,$14(a5)
                bcs.w   locret_30BB8
                tst.w   $40(a5)
                beq.s   loc_305EC
                subq.w  #1,$40(a5)
                rts
; ---------------------------------------------------------------------------
loc_305EC:                              ; CODE XREF: Boss_JetsripperWeaponWaitAndMove+E   j
                move.l  #$12000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bcs.s   loc_30606
                ori.w   #$800,$E(a5)
                neg.l   $18(a5)
loc_30606:                              ; CODE XREF: Boss_JetsripperWeaponWaitAndMove+24   j
                move.w  #$50,$40(a5) ; 'P'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperWeaponWaitAndMove
; Move weapon and spawn projectiles before reversing direction
Boss_JetsripperWeaponMoveAndSpawn:                              ; DATA XREF: ROM:0003058A   o  ; was: sub_30612
                subq.w  #1,$40(a5)
                beq.s   loc_30650
                cmpi.w  #$10,$40(a5)
                bne.w   locret_30BB8
                move.w  $10(a5),d5
                move.w  $14(a5),d6
                move.w  #4,d3
                cmpi.w  #$120,$10(a5)
                bcc.s   loc_30642
                addi.w  #$20,d5 ; ' '
                clr.w   d4
                bsr.w Boss_JetsripperSpawnDirectionalProjectile
                rts
; ---------------------------------------------------------------------------
loc_30642:                              ; CODE XREF: Boss_JetsripperWeaponMoveAndSpawn+22   j
                subi.w  #$20,d5 ; ' '
                move.w  #$10,d4
                bsr.w Boss_JetsripperSpawnDirectionalProjectile
                rts
; ---------------------------------------------------------------------------
loc_30650:                              ; CODE XREF: Boss_JetsripperWeaponMoveAndSpawn+4   j
                neg.l   $18(a5)
                move.w  #$60,$40(a5) ; '`'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperWeaponMoveAndSpawn
; Wait for timer countdown then destroy weapon entity
Boss_JetsripperWeaponDelayDestroy:                              ; DATA XREF: ROM:0003058C   o  ; was: sub_30660
                subq.w  #1,$40(a5)
                bne.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperWeaponDelayDestroy
; Spawn projectile with directional offset and sound effect
Boss_JetsripperSpawnDirectionalProjectile:                              ; CODE XREF: Boss_JetsripperWeaponMoveAndSpawn+2A   p  ; was: sub_30670
                                        ; Boss_JetsripperWeaponMoveAndSpawn+38   p ...
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                move.w  #$ED00,2(a0)
                move.l  #off_E968C,8(a0)
                move.w  #$3A4,(a0)
                move.w  d3,$4E(a0)
                move.w  d4,$50(a0)
                move.w  a5,$48(a0)
                move.w  d5,$10(a0)
                sub.w   $10(a5),d5
                move.w  d5,$4A(a0)
                move.w  d6,$14(a0)
                sub.w   $14(a5),d6
                move.w  d6,$4C(a0)
                move.b  #0,$20(a0)
                move.w  d4,d0
                lsr.w   #1,d0
                move.w  #$480,d1
                or.w    (word_FF808A).w,d1
                lea     word_30834(pc),a1
                nop
                or.w    (a1,d0.w),d1
                move.w  d1,$E(a0)
                move.w  #$3A4,(a0)
                clr.w   4(a0)
                move.w  #$10,$46(a0)
                move.b  #$CE,d0
                jsr (Sound_PlaySFX).l
                rts
; End of function Boss_JetsripperSpawnDirectionalProjectile
; Projectile state dispatcher using jump table for behavior selection
Projectile_StateDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_306EA
                move.w  4(a5),d0
                lea     off_306F6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_StateDispatcher
; ---------------------------------------------------------------------------
off_306F6:      dc.w Boss_JetsripperProjectileTrackAndSplit-*        ; DATA XREF: Projectile_StateDispatcher+4   o
                dc.w Boss_JetsripperFragmentDelayMove-*
                dc.w Boss_JetsripperSpawnFragmentSpread-*
                dc.w Boss_JetsripperFragmentHandleHit-*
                dc.w Projectile_CheckAnimThreshold-*
                dc.w Projectile_ApplyGravity-*


; Track parent entity position then split into fragment spread
Boss_JetsripperProjectileTrackAndSplit:                              ; DATA XREF: ROM:off_306F6   o  ; was: sub_30702
                movea.w $48(a5),a4
                move.w  $10(a4),d0
                add.w   $4A(a5),d0
                move.w  d0,$10(a5)
                move.w  $14(a4),d0
                add.w   $4C(a5),d0
                move.w  d0,$14(a5)
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.w  2(a5),d5
                andi.w  #$DFFF,d5
                move.w  #$1000,2(a5)
                lea     $54(a5),a3
                move.w  $50(a5),d4
                move.w  $4E(a5),d3
loc_30740:                              ; CODE XREF: Boss_JetsripperProjectileTrackAndSplit+C8   j
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                move.w  d5,2(a0)
                move.l  #$FF01FF01,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  d4,$50(a0)
                move.b  #0,$20(a0)
                move.w  $E(a5),$E(a0)
                move.w  #$3A4,(a0)
                move.w  #2,4(a0)
                move.w  d3,d0
                lsl.w   #1,d0
                move.w  d0,d1
                lsl.w   #1,d0
                add.w   d1,d0
                addq.w  #1,d0
                move.w  d0,$46(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  d4,d0
                move.l  off_30814(pc,d0.w),8(a0)
                move.l  dword_307D4(pc,d0.w),$48(a0)
                move.l  dword_307F4(pc,d0.w),$4C(a0)
                move.l  $48(a0),d0
                move.l  d0,d1
                lsl.l   #1,d0
                add.l   d1,d0
                swap    d0
                add.w   d0,$10(a0)
                move.l  $4C(a0),d0
                move.l  d0,d1
                lsl.l   #1,d0
                add.l   d1,d0
                swap    d0
                add.w   d0,$14(a0)
                move.w  a0,(a3)+
                dbf     d3,loc_30740
                bsr.w Boss_JetsripperCopyFragmentReferences
                rts
; End of function Boss_JetsripperProjectileTrackAndSplit
; ---------------------------------------------------------------------------
dword_307D4:    dc.l $40000, $2D414     ; DATA XREF: Boss_JetsripperProjectileTrackAndSplit+9A   r
                                        ; Boss_JetsripperSpawnFragmentSpread+8C   o
                dc.l 0, $FFFD2BEC
                dc.l $FFFC0000, $FFFD2BEC
                dc.l 0, $2D414
dword_307F4:    dc.l 0, $2D414          ; DATA XREF: Boss_JetsripperProjectileTrackAndSplit+A0   r
                                        ; Boss_JetsripperSpawnFragmentSpread+96   o
                dc.l $40000, $2D414
                dc.l 0, $FFFD2BEC
                dc.l $FFFC0000, $FFFD2BEC
off_30814:      dc.l word_E9530         ; DATA XREF: Boss_JetsripperProjectileTrackAndSplit+94   r
                                        ; Boss_JetsripperSpawnFragmentSpread+82   o
                dc.l word_E9536
                dc.l word_E952A
                dc.l word_E9536
                dc.l word_E9530
                dc.l word_E9536
                dc.l word_E952A
                dc.l word_E9536
word_30834:     dc.w $800, $1800, $1800, $1000, 0, 0, $800, $800
                                        ; DATA XREF: Boss_JetsripperSpawnDirectionalProjectile+52   o
                                        ; Boss_JetsripperSpawnFragmentSpread+AA   o


; Copy fragment entity references between parent and child
Boss_JetsripperCopyFragmentReferences:                              ; CODE XREF: Boss_JetsripperProjectileTrackAndSplit+CC   p  ; was: sub_30844
                move.b  #$40,$21(a0) ; '@'
                move.w  #$28,$26(a0) ; '('
                lea     $54(a5),a3
                lea     $54(a0),a4
                move.w  $4E(a5),d3
                move.w  d3,$52(a0)
loc_30860:                              ; CODE XREF: Boss_JetsripperCopyFragmentReferences+1E   j
                move.w  (a3)+,(a4)+
                dbf     d3,loc_30860
                rts
; End of function Boss_JetsripperCopyFragmentReferences
; Calculate 8-way directional index from player position flags
Boss_JetsripperGetDirectionIndex:                              ; CODE XREF: Boss_JetsripperSpawnFragmentSpread+34   p  ; was: sub_30868
                btst    #3,(word_FFF706).w
                bne.s   loc_30894
                btst    #3,(word_FFF706).w
                bne.s   loc_308A6
                btst    #0,(word_FFF706).w
                bne.s   loc_308DC
                btst    #1,(word_FFF706).w
                bne.s   loc_308C4
                move.w  (word_FFA40E).w,d0
                andi.w  #$800,d0
                bne.s   loc_308B8
                bra.s   loc_308D0
; ---------------------------------------------------------------------------
loc_30894:                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+6   j
                btst    #0,(word_FFF706).w
                bne.s   loc_308E2
                btst    #1,(word_FFF706).w
                bne.s   loc_308BE
                bra.s   loc_308B8
; ---------------------------------------------------------------------------
loc_308A6:                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+E   j
                btst    #0,(word_FFF706).w
                bne.s   loc_308D6
                btst    #1,(word_FFF706).w
                bne.s   loc_308CA
                bra.s   loc_308D0
; ---------------------------------------------------------------------------
loc_308B8:                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+28   j
                                        ; Boss_JetsripperGetDirectionIndex+3C   j
                move.w  #$10,d4
                rts
; ---------------------------------------------------------------------------
loc_308BE:                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+3A   j
                move.w  #$14,d4
                rts
; ---------------------------------------------------------------------------
loc_308C4:                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+1E   j
                move.w  #$18,d4
                rts
; ---------------------------------------------------------------------------
loc_308CA:                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+4C   j
                move.w  #$1C,d4
                rts
; ---------------------------------------------------------------------------
loc_308D0:                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+2A   j
                                        ; Boss_JetsripperGetDirectionIndex+4E   j
                move.w  #0,d4
                rts
; ---------------------------------------------------------------------------
loc_308D6:                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+44   j
                move.w  #4,d4
                rts
; ---------------------------------------------------------------------------
loc_308DC:                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+16   j
                move.w  #8,d4
                rts
; ---------------------------------------------------------------------------
loc_308E2:                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+32   j
                move.w  #$C,d4
                rts
; End of function Boss_JetsripperGetDirectionIndex
; Wait for timer then apply stored velocity to fragment
Boss_JetsripperFragmentDelayMove:                              ; DATA XREF: ROM:000306F8   o  ; was: sub_308E8
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.l  $48(a5),$18(a5)
                move.l  $4C(a5),$1C(a5)
                move.w  #$40,$46(a5) ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperFragmentDelayMove
; Spawn circular spread of fragments when hit by player
Boss_JetsripperSpawnFragmentSpread:                              ; DATA XREF: ROM:000306FA   o  ; was: sub_30908
                subq.w  #1,$46(a5)
                beq.w   loc_309EA
                bclr    #7,$22(a5)
                beq.w   locret_30BB8
                bclr    #4,$22(a5)
                beq.w   locret_30BB8
                move.w  2(a5),d5
                lea     $54(a5),a3
                move.w  $52(a5),d3
loc_30930:                              ; CODE XREF: Boss_JetsripperSpawnFragmentSpread+30   j
                movea.w (a3)+,a4
                move.w  #$1000,2(a4)
                dbf     d3,loc_30930
                bsr.w Boss_JetsripperGetDirectionIndex
                move.w  $52(a5),d3
loc_30944:                              ; CODE XREF: Boss_JetsripperSpawnFragmentSpread+DC   j
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                move.w  d5,2(a0)
                clr.b   $22(a0)
                move.b  #1,$21(a0)
                bsr.w Boss_JetsripperSetDifficultyHP2
                move.w  #$3A4,(a0)
                move.b  #0,$20(a0)
                move.w  #6,4(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  d3,d0
                lsl.w   #4,d0
                move.w  d4,d1
                lsr.w   #1,d1
                add.w   d1,d0
                move.w  word_309F2(pc,d0.w),d0
                lea     off_30814(pc),a1
                move.l  (a1,d0.w),8(a0)
                lea     dword_307D4(pc),a1
                move.l  (a1,d0.w),$18(a0)
                lea     dword_307F4(pc),a1
                move.l  (a1,d0.w),$1C(a0)
                lsr.w   #1,d0
                move.w  #$480,d1
                or.w    (word_FF808A).w,d1
                lea     word_30834(pc),a1
                or.w    (a1,d0.w),d1
                move.w  d1,$E(a0)
                move.l  $18(a0),d0
                move.l  d0,d1
                lsl.l   #1,d0
                add.l   d1,d0
                swap    d0
                add.w   d0,$10(a0)
                move.l  $1C(a0),d0
                move.l  d0,d1
                lsl.l   #1,d0
                add.l   d1,d0
                swap    d0
                add.w   d0,$14(a0)
                move.w  #$40,$46(a0) ; '@'
                dbf     d3,loc_30944
                rts
; ---------------------------------------------------------------------------
loc_309EA:                              ; CODE XREF: Boss_JetsripperSpawnFragmentSpread+4   j
                                        ; Boss_JetsripperFragmentHandleHit+8   j ...
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperSpawnFragmentSpread
; ---------------------------------------------------------------------------
word_309F2:     dc.w $10, $14, $18, $1C, 0, 4, 8, $C, $14, $18, $1C, 0, 4, 8, $C, $10, $C
                                        ; DATA XREF: Boss_JetsripperSpawnFragmentSpread+7E   r
                dc.w $10, $14, $18, $1C, 0, 4, 8, $18, $1C, 0, 4, 8, $C, $10, $14, 8, $C
                dc.w $10, $14, $18, $1C, 0, 4


; Handle fragment collision and destroy after timer expires
Boss_JetsripperFragmentHandleHit:                              ; DATA XREF: ROM:000306FC   o  ; was: sub_30A42
                bsr.w Projectile_HandleHit
                subq.w  #1,$46(a5)
                beq.s   loc_309EA
                rts
; End of function Boss_JetsripperFragmentHandleHit
; Checks if animation frame counter exceeds threshold for state change
Projectile_CheckAnimThreshold:                              ; DATA XREF: ROM:000306FE   o  ; was: sub_30A4E
                cmpi.w  #$80,$C(a5)
                bcs.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; End of function Projectile_CheckAnimThreshold
; Applies gravity to projectile with hit detection and lifetime check
Projectile_ApplyGravity:                              ; DATA XREF: ROM:00030700   o  ; was: sub_30A60
                addi.l  #$2000,$1C(a5)
                bsr.w Projectile_HandleHit
                subq.w  #1,$46(a5)
                beq.w   loc_309EA
                rts
; End of function Projectile_ApplyGravity
; Handles projectile hit changing sprite state and clearing collision flags
Projectile_HandleHit:                              ; CODE XREF: Boss_JetsripperFragmentHandleHit   p  ; was: sub_30A76
                                        ; Projectile_ApplyGravity+8   p
                bclr    #7,$22(a5)
                beq.w   locret_30BB8
                clr.b   $22(a5)
                move.w  #$8480,$E(a5)
                move.w  #$EC00,2(a5)
                move.l  #off_E9850,8(a5)
                clr.w   $C(a5)
                clr.b   $21(a5)
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #8,4(a5)
                rts
; End of function Projectile_HandleHit
; Handles projectile deflection and bounce with directional velocity
Projectile_DeflectBounce:                              ; CODE XREF: Enemy_InitProjectileType+68   j  ; was: sub_30ABA
                                        ; Projectile_GravityBounce+1A   j ...
                clr.b   $22(a5)
                move.w  #$3A4,(a5)
                move.w  #$80,$46(a5)
                move.w  #$A,4(a5)
                move.b  #1,$21(a5)
                bsr.w Boss_JetsripperSetDifficultyHP1
                move.l  #$FFFE0000,$1C(a5)
                btst    #3,(word_FFF706).w
                bne.s   loc_30B04
                btst    #3,(word_FFF706).w
                bne.s   loc_30AFA
                move.w  (word_FFA40E).w,d0
                andi.w  #$800,d0
                bne.s   loc_30B04
loc_30AFA:                              ; CODE XREF: Projectile_DeflectBounce+34   j
                move.l  #$FFFA0000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_30B04:                              ; CODE XREF: Projectile_DeflectBounce+2C   j
                                        ; Projectile_DeflectBounce+3E   j
                move.l  #$60000,$18(a5)
                rts
; End of function Projectile_DeflectBounce
; Set entity HP value based on difficulty level check
Boss_JetsripperSetDifficultyHP1:                              ; CODE XREF: Projectile_DeflectBounce+1A   p  ; was: sub_30B0E
                tst.w   (word_FFFF0E).w
                beq.s   loc_30B1C
                move.w  #$64,$26(a5) ; 'd'
                rts
; ---------------------------------------------------------------------------
loc_30B1C:                              ; CODE XREF: Boss_JetsripperSetDifficultyHP1+4   j
                move.w  #$C8,$26(a5)
                rts
; End of function Boss_JetsripperSetDifficultyHP1
; Set entity HP value based on difficulty level check
Boss_JetsripperSetDifficultyHP2:                              ; CODE XREF: Boss_JetsripperSpawnFragmentSpread+54   p  ; was: sub_30B24
                tst.w   (word_FFFF0E).w
                beq.s   loc_30B32
                move.w  #$64,$26(a0) ; 'd'
                rts
; ---------------------------------------------------------------------------
loc_30B32:                              ; CODE XREF: Boss_JetsripperSetDifficultyHP2+4   j
                move.w  #$C8,$26(a0)
                rts
; End of function Boss_JetsripperSetDifficultyHP2
; Dispatch to spawner state handler via jump table
Stage_SpawnerDispatcher1:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_30B3A
                move.w  4(a5),d0
                lea     off_30B46(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Stage_SpawnerDispatcher1
; ---------------------------------------------------------------------------
off_30B46:      dc.w Stage_SpawnerInit1-*        ; DATA XREF: Stage_SpawnerDispatcher1+4   o
                dc.w Stage_SpawnerSpawnByTimer-*


; Initialize spawner entity properties and difficulty spawn table
Stage_SpawnerInit1:                              ; DATA XREF: ROM:off_30B46   o  ; was: sub_30B4A
                move.w  #$6000,2(a5)
                move.w  #$8000,$E(a5)
                move.l  #off_1A0F76,8(a5)
                addq.w  #2,4(a5)
                tst.w   (word_FFFF0E).w
                bne.w   loc_30B74
                move.l  #word_30C54,$40(a5)
                rts
; ---------------------------------------------------------------------------
loc_30B74:                              ; CODE XREF: Stage_SpawnerInit1+1C   j
                move.l  #word_30BC6,$40(a5)
                rts
; End of function Stage_SpawnerInit1
; Spawn entities at positions from table based on scroll timer
Stage_SpawnerSpawnByTimer:                              ; DATA XREF: ROM:00030B48   o  ; was: sub_30B7E
                tst.l   (dword_FFA41C).w
                bne.w   locret_30BB8
                move.w  (dword_FFA904).w,d0
                sub.w   (dword_FFA414).w,d0
                movea.l $40(a5),a4
                cmp.w   (a4)+,d0
                bcs.w   locret_30BB8
loc_30B98:                              ; CODE XREF: Stage_SpawnerSpawnByTimer+34   j
                jsr (Projectile_FindFreeSlotAndClear).l
                bne.s   loc_30BBA
                move.w  #$384,(a0)
                move.w  (a4)+,$10(a0)
                move.w  (a4)+,$14(a0)
                clr.w   4(a0)
                tst.w   (a4)
                bpl.s   loc_30B98
                move.l  a4,$40(a5)
locret_30BB8:                           ; CODE XREF: Enemy_Stage18SpawnerMain+24   j
                                        ; Enemy_Stage18SpawnerMain+4C   j ...
                rts
; ---------------------------------------------------------------------------
loc_30BBA:                              ; CODE XREF: Stage_SpawnerSpawnByTimer+20   j
                                        ; Stage_SpawnerSpawnByTimer+40   j
                addq.w  #4,a4
                tst.w   (a4)
                bpl.s   loc_30BBA
                move.l  a4,$40(a5)
                rts
; End of function Stage_SpawnerSpawnByTimer
; ---------------------------------------------------------------------------
word_30BC6:     dc.w $E080, $90, $70, $1B0, $68
                                        ; DATA XREF: Stage_SpawnerInit1:loc_30B74   o
                dc.w $E0D0, $C0, $68, $150, $70
                dc.w $180, $60, $E120, $90, $60
                dc.w $F0, $68, $150, $58, $E170
                dc.w $F0, $68, $120, $50, $150
                dc.w $58, $1B0, $70, $E1C0, $90
                dc.w $70, $C0, $58, $150, $50
                dc.w $180, $68, $E210, $C0, $48
                dc.w $120, $60, $180, $70, $1B0
                dc.w $58, $E260, $90, $70, $F0
                dc.w $60, $120, $68, $150, $58
                dc.w $1B0, $50, $E2B0, $90, $58
                dc.w $C0, $40, $F0, $68, $150
                dc.w $50, $180, $70, $1B0, $60
                dc.w $FFFF
word_30C54:     dc.w $E080, $90, $70, $1B0, $68
                                        ; DATA XREF: Stage_SpawnerInit1+20   o
                dc.w $E0D0, $C0, $68, $180, $60
                dc.w $E120, $C0, $68, $150, $58
                dc.w $E170, $F0, $68, $180, $70
                dc.w $E1C0, $90, $70, $180, $50
                dc.w $1B0, $68, $E210, $90, $48
                dc.w $C0, $60, $F0, $70, $1B0
                dc.w $58, $E260, $F0, $60, $120
                dc.w $68, $150, $58, $E2B0, $90
                dc.w $58, $C0, $40, $180, $70
                dc.w $1B0, $60, $FFFF


; Dispatch to spawner state handler via jump table
Stage_SpawnerDispatcher2:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_30CBE
                move.w  4(a5),d0
                lea     off_30CCA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Stage_SpawnerDispatcher2
; ---------------------------------------------------------------------------
off_30CCA:      dc.w Boss_JetsripperDebrisInit-*        ; DATA XREF: Stage_SpawnerDispatcher2+4   o
                dc.w Enemy_BounceOnGround-*


; Initialize falling debris entity properties and physics
Boss_JetsripperDebrisInit:                              ; DATA XREF: ROM:off_30CCA   o  ; was: sub_30CCE
                move.w  #$CD00,2(a5)
                move.w  #$A300,$E(a5)
                move.l  #word_EB36E,8(a5)
                move.b  #0,$20(a5)
                move.w  #$800,$24(a5)
                move.b  #$C0,$21(a5)
                move.l  #$F40CF40C,$2C(a5)
                move.l  #$E817E818,$28(a5)
                move.b  #$10,$23(a5)
                move.w  #$28,$26(a5) ; '('
                clr.w   $44(a5)
                move.w  #$FFFF,$46(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperDebrisInit
; Enemy bouncing on ground
Enemy_BounceOnGround:                              ; DATA XREF: ROM:00030CCC   o  ; was: sub_30D20
                addi.l  #$4000,$1C(a5)
                tst.w   $44(a5)
                beq.s   loc_30D34
                subq.w  #1,$44(a5)
                rts
; ---------------------------------------------------------------------------
loc_30D34:                              ; CODE XREF: Enemy_BounceOnGround+C   j
                clr.w   d0
                move.w  #$18,d1
                jsr (Physics_AddEntityOffset).l
                bne.s   loc_30D54
                cmpi.w  #$180,$14(a5)
                bcs.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_30D54:                              ; CODE XREF: Enemy_BounceOnGround+20   j
                move.w  #3,(word_FFA010).w
                move.b  #$53,d0 ; 'S'
                jsr (Sound_PlaySFX).l
                move.l  $1C(a5),$40(a5)
                jsr (Physics_AlignToTerrain).l
                move.l  $40(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                tst.w   $46(a5)
                bmi.s   loc_30D8A
                move.w  #$18,$44(a5)
                rts
; ---------------------------------------------------------------------------
loc_30D8A:                              ; CODE XREF: Enemy_BounceOnGround+60   j
                clr.w   $46(a5)
                rts
; End of function Enemy_BounceOnGround
; Main handler for Stage 11 boss part
Enemy_Stage11BossPartMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_30D90
                cmpi.w  #$14,4(a5)
                bcc.s   loc_30DA6
                tst.w   $24(a5)
                bpl.w   loc_30DA6
                move.w  #$14,4(a5)
loc_30DA6:                              ; CODE XREF: Enemy_Stage11BossPartMain+6   j
                                        ; Enemy_Stage11BossPartMain+C   j
                move.w  4(a5),d0
                lea     off_30DB2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage11BossPartMain
; ---------------------------------------------------------------------------
off_30DB2:      dc.w Enemy_Stage11BossPartInit-*        ; DATA XREF: Enemy_Stage11BossPartMain+1A   o
                dc.w Enemy_Stage11BossPartFloat-*
                dc.w Enemy_Stage11BossPartSpawn-*
                dc.w Enemy_Stage11BossPartFallInit-*
                dc.w Enemy_Stage11BossPartFallDelay-*
                dc.w Boss_JetsripperPartSetVelocity-*
                dc.w Boss_JetsripperPartDecelerateStop-*
                dc.w Boss_JetsripperDecelerateUp-*
                dc.w Boss_JetsripperAccelerateDown-*
                dc.w Boss_JetsripperDecelerateAndReset-*
                dc.w Boss_JetsripperInitFallVelocity-*
                dc.w Boss_JetsripperSpawnProjectilesUntilLowY-*


; Initializes Stage 11 boss part
Enemy_Stage11BossPartInit:                              ; DATA XREF: ROM:off_30DB2   o  ; was: sub_30DCA
                move.w  #$CF00,2(a5)
                move.w  #$8C2,$E(a5)
                move.l  #word_EB356,8(a5)
                move.b  #$3C,$20(a5) ; '<'
                move.w  #$64,$24(a5) ; 'd'
                move.b  #$C0,$21(a5)
                move.l  #$FC04FC04,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$26(a5) ; '('
                move.l  #$FFFD0000,$1C(a5)
                move.l  #$FFFE8000,$18(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartInit
; Boss part floating state
Enemy_Stage11BossPartFloat:                              ; DATA XREF: ROM:00030DB4   o  ; was: sub_30E1C
                addi.l  #$4000,$1C(a5)
                bne.w   locret_30BB8
                clr.l   $1C(a5)
                clr.l   $18(a5)
                move.w  #$20,$46(a5) ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartFloat
; Boss part spawns projectile
Enemy_Stage11BossPartSpawn:                              ; DATA XREF: ROM:00030DB6   o  ; was: sub_30E3C
                jsr (Projectile_FindFreeSlotAndClear).l
                bne.s   loc_30E70
                move.w  #$8F00,2(a0)
                move.w  #$38C,(a0)
                move.w  $10(a5),$10(a0)
                subi.w  #$18,$10(a0)
                move.w  $14(a5),$14(a0)
                subi.w  #$14,$14(a0)
                move.w  $5E(a5),$5E(a0)
                clr.w   4(a0)
loc_30E70:                              ; CODE XREF: Enemy_Stage11BossPartSpawn+6   j
                move.l  #$40000,$1C(a5)
                move.l  #$30000,$18(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartSpawn
; Initializes falling state
Enemy_Stage11BossPartFallInit:                              ; DATA XREF: ROM:00030DB8   o  ; was: sub_30E86
                move.l  #$FFFC0000,$1C(a5)
                move.l  #$FFFD0000,$18(a5)
                move.w  #4,$44(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartFallInit
; Delays before next fall iteration
Enemy_Stage11BossPartFallDelay:                              ; DATA XREF: ROM:00030DBA   o  ; was: sub_30EA2
                clr.l   $1C(a5)
                clr.l   $18(a5)
                subq.w  #1,$44(a5)
                bne.w   locret_30BB8
                subq.w  #1,$46(a5)
                beq.s   loc_30EBE
                subq.w  #4,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_30EBE:                              ; CODE XREF: Enemy_Stage11BossPartFallDelay+14   j
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartFallDelay
; Set vertical and horizontal velocity for boss part
Boss_JetsripperPartSetVelocity:                              ; DATA XREF: ROM:00030DBC   o  ; was: sub_30EC4
                move.l  #$30000,$1C(a5)
                move.l  #$18000,$18(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperPartSetVelocity
; Decelerate vertical velocity until stopped then wait
Boss_JetsripperPartDecelerateStop:                              ; DATA XREF: ROM:00030DBE   o  ; was: sub_30EDA
                subi.l  #$4000,$1C(a5)
                bne.w   locret_30BB8
                clr.l   $18(a5)
                move.w  #$20,$46(a5) ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperPartDecelerateStop
; Decelerates upward movement with timer countdown for Jetsripper boss part
Boss_JetsripperDecelerateUp:                              ; DATA XREF: ROM:00030DC0   o  ; was: sub_30EF6
                subi.l  #$A00,$18(a5)
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.w  #$40,$46(a5) ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperDecelerateUp
; Accelerates downward movement with timer countdown for Jetsripper boss part
Boss_JetsripperAccelerateDown:                              ; DATA XREF: ROM:00030DC2   o  ; was: sub_30F12
                addi.l  #$A00,$18(a5)
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.w  #$20,$46(a5) ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperAccelerateDown
; Decelerates upward and resets to initial movement state with specific velocities
Boss_JetsripperDecelerateAndReset:                              ; DATA XREF: ROM:00030DC4   o  ; was: sub_30F2E
                subi.l  #$A00,$18(a5)
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.l  #$FFFD0000,$1C(a5)
                move.l  #$FFFE8000,$18(a5)
                move.w  #2,4(a5)
                rts
; End of function Boss_JetsripperDecelerateAndReset
; Initializes downward velocity for Jetsripper boss part movement
Boss_JetsripperInitFallVelocity:                              ; DATA XREF: ROM:00030DC6   o  ; was: sub_30F56
                clr.l   $18(a5)
                move.l  #$8000,$1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperInitFallVelocity
; Spawns projectiles periodically until Y position falls below 180h
Boss_JetsripperSpawnProjectilesUntilLowY:                              ; DATA XREF: ROM:00030DC8   o  ; was: sub_30F68
                bsr.w Boss_JetsripperSpawnUpwardProjectile
                cmpi.w  #$180,$14(a5)
                bcs.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperSpawnProjectilesUntilLowY
; Creates projectile every 4 frames and negates vertical velocity for upward firing
Boss_JetsripperSpawnUpwardProjectile:                              ; CODE XREF: Boss_JetsripperSpawnProjectilesUntilLowY   p  ; was: sub_30F7E
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_30BB8
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                bsr.w Boss_GustheadSpawnAngleProjectile
                tst.l   $1C(a4)
                bmi.w   locret_30BB8
                neg.l   $1C(a4)
                rts
; End of function Boss_JetsripperSpawnUpwardProjectile
; State dispatcher for boss part
Enemy_Stage11BossPartDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_30FA6
                move.w  4(a5),d0
                lea     off_30FB2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage11BossPartDispatcher
; ---------------------------------------------------------------------------
off_30FB2:      dc.w Enemy_Stage11BossPartState1-*        ; DATA XREF: Enemy_Stage11BossPartDispatcher+4   o
                dc.w Boss_JetsripperFallAndFirePattern-*


; Boss part state 1 initialization
Enemy_Stage11BossPartState1:                              ; DATA XREF: ROM:off_30FB2   o  ; was: sub_30FB6
                jsr     (RandomNumber).l
                andi.w  #6,d0
                move.w  d0,$40(a5)
                bsr.w Enemy_Stage11BossPartUpdatePalette
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                move.b  #$40,$20(a5) ; '@'
                move.w  #$800,$24(a5)
                move.b  #$C0,$21(a5)
                move.l  #$FC04FC04,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$26(a5) ; '('
                move.w  $5E(a5),d0
                move.l  dword_31018(pc,d0.w),$1C(a5)
                move.l  dword_31018+$10(pc,d0.w),$18(a5)
                move.l  dword_31018+$20(pc,d0.w),$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartState1
; ---------------------------------------------------------------------------
dword_31018:    dc.l $FFFB0000, $FFFC0000
                                        ; DATA XREF: Enemy_Stage11BossPartState1+4A   r
                dc.l $FFFD0000, $FFFE0000
                dc.l $FFFD0000, $FFFD8000
                dc.l $FFFE0000, $FFFE8000
                dc.l $1800, $1400
                dc.l $1000, $C00


; Falls with applied velocity while firing projectiles until Y position reaches 180h
Boss_JetsripperFallAndFirePattern:                              ; DATA XREF: ROM:00030FB4   o  ; was: sub_31048
                bsr.w Boss_JetsripperFrameCheck
                bsr.w Boss_JetsripperSpawnRandomAngleProjectile
                move.l  $48(a5),d0
                add.l   d0,$1C(a5)
                cmpi.w  #$180,$14(a5)
                bcs.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperFallAndFirePattern
; Checks frame counter mod 4 for timing projectile spawn
Boss_JetsripperFrameCheck:                              ; CODE XREF: Boss_JetsripperFallAndFirePattern   p  ; was: sub_3106A
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_30BB8
; End of function Boss_JetsripperFrameCheck
; Updates boss part palette cycle
Enemy_Stage11BossPartUpdatePalette:                              ; CODE XREF: Enemy_Stage11BossPartState1+E   p  ; was: sub_31076
                move.w  $40(a5),d0
                addq.w  #2,d0
                cmpi.w  #6,d0
                bcs.s   loc_31084
                clr.w   d0
loc_31084:                              ; CODE XREF: Enemy_Stage11BossPartUpdatePalette+A   j
                move.w  d0,$40(a5)
                move.w  word_31090(pc,d0.w),$E(a5)
                rts
; End of function Enemy_Stage11BossPartUpdatePalette
; ---------------------------------------------------------------------------
word_31090:     dc.w $2109, $2112, $211B
                                        ; DATA XREF: Enemy_Stage11BossPartUpdatePalette+12   r


; Spawns projectile at random angle after taking damage from specific hit flags
Boss_JetsripperSpawnRandomAngleProjectile:                              ; CODE XREF: Boss_JetsripperFallAndFirePattern+4   p  ; was: sub_31096
                bclr    #6,$22(a5)
                bne.s   loc_310A8
                bclr    #7,$22(a5)
                bne.s   loc_310A8
                rts
; ---------------------------------------------------------------------------
loc_310A8:                              ; CODE XREF: Boss_JetsripperSpawnRandomAngleProjectile+6   j
                                        ; Boss_JetsripperSpawnRandomAngleProjectile+E   j
                jsr     (RandomNumber).l
                andi.w  #$1FE,d0
                move.w  d0,d4
                move.w  $10(a5),d5
                move.w  $14(a5),d6
                jsr (Enemy_SpawnProjectileAtAngle).l
                jsr     (RandomNumber).l
                andi.w  #$F,d0
                bne.s   loc_310DE
                jsr     (RandomNumber).l
                move.w  #$F,d0
                jmp Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_310DE:                              ; CODE XREF: Boss_JetsripperSpawnRandomAngleProjectile+36   j
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperSpawnRandomAngleProjectile
; Main handler for Gusthead eye enemy
Enemy_GustheadEyeMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_310E6
                bsr.w Enemy_GustheadEyeDestroy
                move.w  4(a5),d0
                lea     off_310F6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_GustheadEyeMain
; ---------------------------------------------------------------------------
off_310F6:      dc.w Enemy_GustheadEyeInit-*        ; DATA XREF: Enemy_GustheadEyeMain+8   o
                dc.w Enemy_GustheadEyeSpawnChain-*
                dc.w nullsub_74-*


; Initializes Gusthead eye sprite
Enemy_GustheadEyeInit:                              ; DATA XREF: ROM:off_310F6   o  ; was: sub_310FC
                move.w  #$D00,2(a5)
                move.b  #$50,$20(a5) ; 'P'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_GustheadEyeInit
; Spawns chain of 8 projectiles
Enemy_GustheadEyeSpawnChain:                              ; DATA XREF: ROM:000310F8   o  ; was: sub_3110E
                cmpi.w  #$180,$10(a5)
                bcc.w   locret_30BB8
                move.w  #7,d7
                move.w  a5,$44(a5)
loc_31120:                              ; CODE XREF: Enemy_GustheadEyeSpawnChain+44   j
                jsr (Projectile_FindFreeSlotAndClear).l
                bne.s   loc_31164
                movea.w $44(a5),a1
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                move.w  #$394,(a0)
                move.w  d7,d1
                lsl.w   #3,d1
                addq.w  #1,d1
                move.w  d1,$46(a0)
                clr.w   4(a0)
                move.w  a1,$44(a0)
                move.w  a0,$44(a5)
                dbf     d7,loc_31120
                move.w  #$398,(a0)
                move.w  a5,$48(a0)
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_31164:                              ; CODE XREF: Enemy_GustheadEyeSpawnChain+18   j
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_GustheadEyeSpawnChain
nullsub_74:                             ; DATA XREF: ROM:000310FA   o
                rts
; End of function nullsub_74


; Destroys eye and projectile chain
Enemy_GustheadEyeDestroy:                              ; CODE XREF: Enemy_GustheadEyeMain   p  ; was: sub_3116E
                cmpi.w  #$60,$10(a5) ; '`'
                bcc.w   locret_30BB8
                movea.w a5,a4
                move.w  #7,d7
loc_3117E:                              ; CODE XREF: Enemy_GustheadEyeDestroy:loc_3118E   j
                tst.w   $44(a4)
                beq.s   loc_3118E
                movea.w $44(a4),a4
                move.w  #$1000,2(a4)
loc_3118E:                              ; CODE XREF: Enemy_GustheadEyeDestroy+14   j
                dbf     d7,loc_3117E
                rts
; End of function Enemy_GustheadEyeDestroy
; Main dispatcher for small eye
Enemy_GustheadSmallEyeMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_31194
                move.w  4(a5),d0
                lea     off_311A0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_GustheadSmallEyeMain
; ---------------------------------------------------------------------------
off_311A0:      dc.w Enemy_GustheadSmallEyeInit-*        ; DATA XREF: Enemy_GustheadSmallEyeMain+4   o
                dc.w Enemy_GustheadSmallEyeWait-*
                dc.w Enemy_GustheadSmallEyeAttack-*
                dc.w Enemy_GustheadSmallEyeUpdate-*
                dc.w Boss_GustheadRotateAndRepeatAttack-*
                dc.w Boss_GustheadRotateToHome-*
                dc.w Boss_GustheadFallAndSpawnSlowProjectiles-*


; Initializes small eye enemy
Enemy_GustheadSmallEyeInit:                              ; DATA XREF: ROM:off_311A0   o  ; was: sub_311AE
                move.w  #$CD00,2(a5)
                move.w  #$1B9,$E(a5)
                move.l  #word_EB350,8(a5)
                move.b  #$60,$20(a5) ; '`'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_GustheadSmallEyeInit
; Wait state before spawning
Enemy_GustheadSmallEyeWait:                              ; DATA XREF: ROM:000311A2   o  ; was: sub_311CE
                bsr.w Enemy_GustheadUpdatePosition
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.w  #$180,$40(a5)
                clr.w   $42(a5)
                move.w  #4,4(a5)
loc_311EA:                              ; CODE XREF: Enemy_GustheadSmallEyeSpawn+26   j
                                        ; Enemy_GustheadSmallEyeCheckSpawn+8   j
                jsr     (RandomNumber).l
                andi.w  #$FE,d0
                addi.w  #$100,d0
                move.w  d0,d4
                move.w  $10(a5),d5
                move.w  #$148,d6
                jmp Enemy_SpawnProjectileAtAngle
; End of function Enemy_GustheadSmallEyeWait
; Spawns projectile with sound
Enemy_GustheadSmallEyeSpawn:                              ; DATA XREF: ROM:000313B6   o  ; was: sub_31208
                bsr.w Enemy_GustheadUpdatePosition
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.w  #$180,$40(a5)
                clr.w   $42(a5)
                move.b  #$4D,d0 ; 'M'
                jsr (Sound_PlaySFX).l
                move.w  #4,4(a5)
                bra.w   loc_311EA
; End of function Enemy_GustheadSmallEyeSpawn
; Attack state with projectile spawn
Enemy_GustheadSmallEyeAttack:                              ; DATA XREF: ROM:000311A4   o  ; was: sub_31232
                                        ; ROM:000313B8   o
                bsr.w Enemy_GustheadUpdatePosition
                bsr.w Enemy_GustheadSmallEyeCheckSpawn
                addq.w  #8,$42(a5)
                cmpi.w  #$40,$42(a5) ; '@'
                bne.w   locret_30BB8
                move.w  #3,$46(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_GustheadSmallEyeAttack
; Updates small eye position
Enemy_GustheadSmallEyeUpdate:                              ; DATA XREF: ROM:000311A6   o  ; was: sub_31254
                                        ; ROM:000313BA   o
                bsr.w Enemy_GustheadUpdatePosition
                subq.w  #2,$40(a5)
                cmpi.w  #$140,$40(a5)
                bcc.w   locret_30BB8
                addq.w  #2,4(a5)
                rts
; End of function Enemy_GustheadSmallEyeUpdate
; Spawns projectile in direction of player when animation frame equals 19Eh
Boss_JetsripperSpawnDirectionalProjectileAtFrame:                              ; CODE XREF: Boss_JetsripperSpawnDirectionalWrapper   p  ; was: sub_3126C
                cmpi.w  #$19E,$40(a5)
                bne.w   locret_30BB8
                move.w  $10(a5),d5
                move.w  $14(a5),d6
                move.w  #2,d3
                move.w  (dword_FFA410).w,d0
                cmp.w   $10(a5),d0
                bcs.s   loc_31292
                clr.w   d4
                bra.w Boss_JetsripperSpawnDirectionalProjectile
; ---------------------------------------------------------------------------
loc_31292:                              ; CODE XREF: Boss_JetsripperSpawnDirectionalProjectileAtFrame+1E   j
                move.w  #$10,d4
                bra.w Boss_JetsripperSpawnDirectionalProjectile
; End of function Boss_JetsripperSpawnDirectionalProjectileAtFrame
; Wrapper function calling directional projectile spawn check
Boss_JetsripperSpawnDirectionalWrapper:                              ; DATA XREF: ROM:000313BC   o  ; was: sub_3129A
                bsr.w Boss_JetsripperSpawnDirectionalProjectileAtFrame
; End of function Boss_JetsripperSpawnDirectionalWrapper
; Updates position and increments rotation counter, repeats attack pattern or advances state
Boss_GustheadRotateAndRepeatAttack:                              ; DATA XREF: ROM:000311A8   o  ; was: sub_3129E
                bsr.w Enemy_GustheadUpdatePosition
                addq.w  #2,$40(a5)
                cmpi.w  #$1A0,$40(a5)
                bcs.w   locret_30BB8
                subq.w  #1,$46(a5)
                beq.s   loc_312BC
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_312BC:                              ; CODE XREF: Boss_GustheadRotateAndRepeatAttack+16   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadRotateAndRepeatAttack
; Updates position and decrements rotation counter until reaching home angle FFF8h
Boss_GustheadRotateToHome:                              ; DATA XREF: ROM:000311AA   o  ; was: sub_312C2
                bsr.w Enemy_GustheadUpdatePosition
                subq.w  #8,$42(a5)
                cmpi.w  #$FFF8,$42(a5)
                bne.w   locret_30BB8
                move.w  #$C0,$46(a5)
                move.w  #2,4(a5)
                rts
; End of function Boss_GustheadRotateToHome
; Updates position, spawns small eyes, rotates to home angle, plays sound effect 4Dh
Boss_GustheadRotateSpawnEyesAndSound:                              ; DATA XREF: ROM:000313BE   o  ; was: sub_312E2
                bsr.w Enemy_GustheadUpdatePosition
                bsr.w Enemy_GustheadSmallEyeCheckSpawn
                subq.w  #8,$42(a5)
                cmpi.w  #$FFF8,$42(a5)
                bne.w   locret_30BB8
                move.b  #$4D,d0 ; 'M'
                jsr (Sound_PlaySFX).l
                move.w  #$C0,$46(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadRotateSpawnEyesAndSound
; Checks if should spawn projectile
Enemy_GustheadSmallEyeCheckSpawn:                              ; CODE XREF: Enemy_GustheadSmallEyeAttack+4   p  ; was: sub_3130E
                                        ; Boss_GustheadRotateSpawnEyesAndSound+4   p ...
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                beq.w   loc_311EA
                rts
; End of function Enemy_GustheadSmallEyeCheckSpawn
; Updates position and spawns small eyes while waiting for timer to reach A0h
Boss_GustheadWaitAndSpawnEyes:                              ; DATA XREF: ROM:000313C0   o  ; was: sub_3131C
                bsr.w Enemy_GustheadUpdatePosition
                bsr.w Enemy_GustheadSmallEyeCheckSpawn
                subq.w  #1,$46(a5)
                cmpi.w  #$A0,$46(a5)
                bne.w   locret_30BB8
                move.w  #2,4(a5)
                rts
; End of function Boss_GustheadWaitAndSpawnEyes
; Calculates angle to player
Enemy_GustheadGetAngleToPlayer:                              ; CODE XREF: Enemy_Stage18FloaterDeath+42   p  ; was: sub_3133A
                                        ; Boss_CalcRandomAngle+E   p ...
                lea     (word_1B494).l,a0
                move.w  (a0,d0.w),d1
                addi.w  #$80,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d0
                rts
; End of function Enemy_GustheadGetAngleToPlayer
; Main handler for eye chain projectile
Enemy_GustheadEyeChainMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_31352
                cmpi.w  #$E,4(a5)
                bcc.w   loc_313A8
                tst.w   $24(a5)
                bpl.w   loc_313A8
                movea.w $48(a5),a4
                move.w  #7,d7
loc_3136C:                              ; CODE XREF: Enemy_GustheadEyeChainMain+4A   j
                movea.w $44(a4),a4
                move.w  #$C,4(a4)
                jsr     (RandomNumber).l
                andi.w  #$7E,d0 ; '~'
                addi.w  #$140,d0
                bsr.w Enemy_GustheadGetAngleToPlayer
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a4)
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a4)
                clr.b   $21(a4)
                dbf     d7,loc_3136C
                move.w  #$E,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_313A8:                              ; CODE XREF: Enemy_GustheadEyeChainMain+6   j
                                        ; Enemy_GustheadEyeChainMain+E   j
                move.w  4(a5),d0
                lea     off_313B4(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_GustheadEyeChainMain
; ---------------------------------------------------------------------------
off_313B4:      dc.w Enemy_GustheadEyeChainInit-*        ; DATA XREF: Enemy_GustheadEyeChainMain+5A   o
                dc.w Enemy_GustheadSmallEyeSpawn-*
                dc.w Enemy_GustheadSmallEyeAttack-*
                dc.w Enemy_GustheadSmallEyeUpdate-*
                dc.w Boss_JetsripperSpawnDirectionalWrapper-*
                dc.w Boss_GustheadRotateSpawnEyesAndSound-*
                dc.w Boss_GustheadWaitAndSpawnEyes-*
                dc.w Boss_GustheadFallAndSpawnProjectiles-*


; Initializes eye chain segment
Enemy_GustheadEyeChainInit:                              ; DATA XREF: ROM:off_313B4   o  ; was: sub_313C4
                move.w  #$CD00,2(a5)
                move.w  #$1B9,$E(a5)
                move.l  #word_EB338,8(a5)
                move.b  #$5C,$20(a5) ; '\'
                move.w  #$64,$24(a5) ; 'd'
                move.b  #$C0,$21(a5)
                move.l  #$F010F010,$2C(a5)
                move.l  #$E818E818,$28(a5)
                clr.b   $22(a5)
                move.b  #5,$23(a5)
                move.w  #$28,$26(a5) ; '('
                addq.w  #2,4(a5)
                rts
; End of function Enemy_GustheadEyeChainInit
; Accelerates downward and spawns doubled-velocity projectiles every 4 frames until Y >= 1A0h
Boss_GustheadFallAndSpawnProjectiles:                              ; DATA XREF: ROM:000313C2   o  ; was: sub_31410
                addi.l  #$1800,$1C(a5)
                cmpi.w  #$1A0,$14(a5)
                bcc.w Boss_GustheadResetState
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_30BB8
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                bsr.w Boss_GustheadSpawnAngleProjectile
                asl     $18(a4)
                asl     $1C(a4)
                rts
; End of function Boss_GustheadFallAndSpawnProjectiles
; Accelerates downward slowly and spawns projectiles every 8 frames until Y >= 180h
Boss_GustheadFallAndSpawnSlowProjectiles:                              ; DATA XREF: ROM:000311AC   o  ; was: sub_31446
                addi.l  #$1000,$1C(a5)
                cmpi.w  #$180,$14(a5)
                bcc.s Boss_GustheadResetState
                move.w  (word_FFA280).w,d0
                andi.w  #7,d0
                bne.w   locret_30BB8
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
; End of function Boss_GustheadFallAndSpawnSlowProjectiles
; Spawns projectile with sound BBh at calculated angle toward player with offset positioning
Boss_GustheadSpawnAngleProjectile:                              ; CODE XREF: Boss_JetsripperSpawnUpwardProjectile+16   p  ; was: sub_3146C
                                        ; Boss_GustheadFallAndSpawnProjectiles+28   p
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
                move.l  #off_E95DC,8(a0)
                jsr (Projectile_InitType88).l
                movea.w a0,a4
                jsr     (RandomNumber).l
                andi.w  #$1FE,d0
                bsr.w Enemy_GustheadGetAngleToPlayer
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a4)
                asl.l   #2,d0
                add.l   $10(a5),d0
                move.l  d0,$10(a4)
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a4)
                asl.l   #2,d1
                add.l   $14(a5),d1
                move.l  d1,$14(a4)
                rts
; End of function Boss_GustheadSpawnAngleProjectile
; Resets boss state to 1000h value
Boss_GustheadResetState:                              ; CODE XREF: Boss_GustheadFallAndSpawnProjectiles+E   j  ; was: sub_314BA
                                        ; Boss_GustheadFallAndSpawnSlowProjectiles+E   j
                move.w  #$1000,2(a5)
                rts
; End of function Boss_GustheadResetState
; Updates entity slot
Enemy_UpdateEntitySlot:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_314C2
                move.w  $48(a5),d0
                lea     off_314CE(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_UpdateEntitySlot
; ---------------------------------------------------------------------------
off_314CE:      dc.w Boss_DestroyerProtoMain-*        ; DATA XREF: Enemy_UpdateEntitySlot+4   o
                dc.w Boss_DestroyerProtoState4-*
                dc.w Boss_DestroyerProtoState5-*
                dc.w Projectile_DestroyerProtoMain-*
                dc.w Enemy_Stage14TurretInit-*


; Main boss handler
Boss_DestroyerProtoMain:                              ; DATA XREF: ROM:off_314CE   o  ; was: sub_314D8
                jsr (Gfx_InitPaletteFade).l
                bsr.w Boss_DestroyerProtoGfxUpdate
                cmpi.w  #$2E,4(a5) ; '.'
                bcc.s   loc_31502
                tst.w   (word_FF8200).w
                bne.s   loc_31502
                bset    #0,(byte_FFA272).w
                move.w  #1,(dword_FF9414+2).w
                move.w  #$2E,4(a5) ; '.'
loc_31502:                              ; CODE XREF: Boss_DestroyerProtoMain+10   j
                                        ; Boss_DestroyerProtoMain+16   j
                move.w  4(a5),d0
                lea     off_3150E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerProtoMain
; ---------------------------------------------------------------------------
off_3150E:      dc.w Boss_DestroyerProtoIntroInit-*        ; DATA XREF: Boss_DestroyerProtoMain+2E   o
                dc.w Boss_DestroyerProtoIntroMove-*
                dc.w Boss_DestroyerProtoState3-*
                dc.w Boss_DestroyerProtoAttack1-*
                dc.w Boss_DestroyerProtoAttack2-*
                dc.w Boss_DestroyerProtoAttack3-*
                dc.w Boss_DestroyerProtoAttack4Wait-*
                dc.w Boss_DestroyerProtoAttack4Rise-*
                dc.w Boss_DestroyerProtoAttack4Descend-*
                dc.w Boss_DestroyerProtoAttack4Delay-*
                dc.w Boss_DestroyerProtoAttack4Retreat-*
                dc.w Boss_DestroyerProtoAttack4-*
                dc.w Boss_DestroyerProtoShootPattern1-*
                dc.w Boss_DestroyerProtoShootPattern2-*
                dc.w Boss_DestroyerProtoAttack5Rise-*
                dc.w Boss_DestroyerProtoAttack5Retreat-*
                dc.w Boss_DestroyerProtoAttack6Wait-*
                dc.w Boss_DestroyerProtoAttack6Prepare-*
                dc.w Boss_DestroyerProtoAttack6Delay-*
                dc.w Boss_DestroyerProtoAttack6Execute-*
                dc.w Boss_DestroyerProtoAttack6FadeOut-*
                dc.w Boss_DestroyerProtoAttack6Wait2-*
                dc.w Boss_DestroyerProtoAttack6Retreat-*
                dc.w Boss_DestroyerProtoSpawnProjectile1-*
                dc.w Boss_DestroyerProtoSpawnProjectile3-*


; Boss graphics update
