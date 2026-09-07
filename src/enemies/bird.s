Enemy_InitBirdSprite:                                   ; CODE XREF: Enemy_BirdInit+2   p  ; was: sub_2DA3A
                move.w  #$6F00,2(a5)
                move.w  (word_FF8274).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.b  #$48,$20(a5)                    ; 'H'
                move.b  #$C0,$21(a5)
                move.l  #$FC04FC04,$2C(a5)
                move.l  #$F010F010,$28(a5)
                lea     word_2DA88(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_InitBirdSprite
; ---------------------------------------------------------------------------
word_2DA88:     dc.w    $1806, $1100                    ; DATA XREF: Enemy_InitBirdSprite+2E   o

; Updates bird enemy animation pointer based on state index
Enemy_UpdateBirdAnimation:                              ; CODE XREF: Enemy_BirdMain+58   p  ; was: sub_2DA8C
                                        ; Enemy_BirdBounceOff+32   j
                move.w  $5C(a5),d0
                beq.s   locret_2DA9E
                subq.w  #4,d0
                move.l  off_2DAA0(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2DA9E:                                           ; CODE XREF: Enemy_UpdateBirdAnimation+4   j
                rts
; End of function Enemy_UpdateBirdAnimation
; ---------------------------------------------------------------------------
off_2DAA0:      dc.l    off_EA7E0                       ; DATA XREF: Enemy_UpdateBirdAnimation+8   r
                dc.l    off_EA814
                dc.l    off_EA848
                dc.l    off_EA85C

; Updates sprite horizontal flip based on velocity
Enemy_UpdateSpriteFlip:                                 ; CODE XREF: Enemy_BirdMain+5C   j  ; was: sub_2DAB0
                                        ; Enemy_Stage10WaspMain+5C   j
                tst.l   $18(a5)
                beq.s   locret_2DACC
                btst    #7,$18(a5)
                bne.s   Sprite_SetHorizontalFlipBit
                andi.w  #$F7FF,$E(a5)
                rts
; ---------------------------------------------------------------------------
; Sets sprite horizontal flip bit based on velocity direction
Sprite_SetHorizontalFlipBit:                            ; CODE XREF: Enemy_UpdateSpriteFlip+C   j  ; was: loc_2DAC6
                ori.w   #$800,$E(a5)
locret_2DACC:                                           ; CODE XREF: Enemy_UpdateSpriteFlip+4   j
                rts
; End of function Enemy_UpdateSpriteFlip
; Main bird enemy update checking defeat conditions and player collision
Enemy_BirdMain:                                         ; DATA XREF: ROM:off_5DC   o  ; was: sub_2DACE
                tst.w   4(a5)
                beq.s   Enemy_BirdMainLoop
                tst.w   $24(a5)
                bmi.w   Enemy_BirdBounceOff
                tst.w   (word_FF808C).w
                bpl.w   Enemy_BirdBounceOff
                bclr    #7,$22(a5)
                beq.s   loc_2DB1A
                btst    #4,$22(a5)
                bne.w   Enemy_BirdBounceOff
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E953C,8(a5)
                clr.w   $C(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
loc_2DB1A:                                              ; CODE XREF: Enemy_BirdMain+1C   j
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Main loop for bird enemy dispatching state and updating animation
Enemy_BirdMainLoop:                                     ; CODE XREF: Enemy_BirdMain+4   j  ; was: loc_2DB24
                bsr.s   Enemy_BirdStateDispatcher
                bsr.w   Enemy_UpdateBirdAnimation
                bra.w   Enemy_UpdateSpriteFlip
; End of function Enemy_BirdMain
; Bird enemy state machine dispatcher using jump table
Enemy_BirdStateDispatcher:                              ; CODE XREF: Enemy_BirdMain:loc_2DB24   p  ; was: sub_2DB2E
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2DB3E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_BirdStateDispatcher
; ---------------------------------------------------------------------------
off_2DB3E:      dc.w    Enemy_BirdInit-*                ; DATA XREF: Enemy_BirdStateDispatcher+8   o
                dc.w    Enemy_BirdStartDive-*
                dc.w    Enemy_BirdFireWrapper-*
                dc.w    Enemy_BirdFlyState-*
                dc.w    Enemy_BirdDiveAttack-*
                dc.w    Enemy_BirdWaitState-*
                dc.w    Enemy_BirdChasePlayer-*
                dc.w    Enemy_BirdWaitTimer-*
                dc.w    Enemy_BirdDescendToThreshold-*
                dc.w    Enemy_BirdAccelerate-*
                dc.w    Enemy_BirdDecelerate-*
                dc.w    Enemy_BirdAttackState-*
                dc.w    Enemy_BirdAscendToThreshold-*
                dc.w    Enemy_BirdOscillateMovement-*

nullsub_66:
                rts
; End of function nullsub_66

; Initializes bird enemy position direction and movement state
Enemy_BirdInit:                                         ; DATA XREF: ROM:off_2DB3E   o  ; was: sub_2DB5C
                moveq   #0,d0
                bsr.w   Enemy_InitBirdSprite
                addq.w  #2,4(a5)
                btst    #0,$5F(a5)
                bne.s   loc_2DB7C
                move.w  #$1E0,$10(a5)
                ori.w   #$800,$E(a5)
                bra.s   loc_2DB88
; ---------------------------------------------------------------------------
loc_2DB7C:                                              ; CODE XREF: Enemy_BirdInit+10   j
                move.w  #$70,$10(a5)                    ; 'p'
                andi.w  #$F7FF,$E(a5)
loc_2DB88:                                              ; CODE XREF: Enemy_BirdInit+1E   j
                btst    #1,$5F(a5)
                bne.s   Enemy_BirdSetWaitState
                move.w  #2,4(a5)
                cmpi.w  #$1B8,(word_FFDB20).w
                bne.s   locret_2DBAC
                move.b  #2,$25(a5)
                rts
; ---------------------------------------------------------------------------
; Sets bird enemy to waiting state with timer
Enemy_BirdSetWaitState:                                 ; CODE XREF: Enemy_BirdInit+32   j  ; was: loc_2DBA6
                move.w  #6,4(a5)
locret_2DBAC:                                           ; CODE XREF: Enemy_BirdInit+40   j
                rts
; End of function Enemy_BirdInit
; Starts bird dive attack setting velocity and animation
Enemy_BirdStartDive:                                    ; DATA XREF: ROM:0002DB40   o  ; was: sub_2DBAE
                addq.w  #2,4(a5)
                move.w  #4,$5C(a5)
                ori.w   #$8000,2(a5)
                btst    #0,$5F(a5)
                bne.s   Enemy_BirdSetDiveVelocity
                move.l  #$FFFE0000,$18(a5)
                rts
; ---------------------------------------------------------------------------
; Sets bird vertical velocity based on flip flag for dive attack
Enemy_BirdSetDiveVelocity:                              ; CODE XREF: Enemy_BirdStartDive+16   j  ; was: loc_2DBD0
                move.l  #$20000,$18(a5)
                rts
; End of function Enemy_BirdStartDive
; Wrapper for bird enemy projectile firing
Enemy_BirdFireWrapper:                                  ; DATA XREF: ROM:0002DB42   o  ; was: sub_2DBDA
                bsr.w   Enemy_BirdFireProjectile
                rts
; End of function Enemy_BirdFireWrapper
; Bird flying state setting animation and timer parameters
Enemy_BirdFlyState:                                     ; DATA XREF: ROM:0002DB44   o  ; was: sub_2DBE0
                ori.w   #$8000,2(a5)
                move.w  #8,$5C(a5)
                move.w  #4,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_BirdFlyState
; Checks wall collision and dispatches player action
Player_WallCheckAndDispatch:
                jsr     (Physics_EntityWallCheck).l     ; was: sub_2DBF8
                jmp     Player_ActionDispatcher
; End of function Player_WallCheckAndDispatch
; Bird dive attack with gravity and ground collision detection
Enemy_BirdDiveAttack:                                   ; DATA XREF: ROM:0002DB46   o  ; was: sub_2DC04
                jsr     (Physics_EntityWallCheck).l
                move.b  7(a5),$58(a5)
                btst    #7,$1C(a5)
                bne.s   loc_2DC26
                jsr     (Player_ActionDispatcher).l
                btst    #0,6(a5)
                bne.s   Enemy_BirdTransitionToWait
loc_2DC26:                                              ; CODE XREF: Enemy_BirdDiveAttack+12   j
                jsr     (Physics_TerrainCheckWithVelocity).l
                addi.l  #$4000,$1C(a5)
                cmpi.l  #$58000,$1C(a5)
                bgt.s   loc_2DC40
                rts
; ---------------------------------------------------------------------------
loc_2DC40:                                              ; CODE XREF: Enemy_BirdDiveAttack+38   j
                move.w  #8,$5C(a5)
                addq.w  #8,4(a5)
                rts
; ---------------------------------------------------------------------------
; Transitions bird to waiting state with hover movement
Enemy_BirdTransitionToWait:                             ; CODE XREF: Enemy_BirdDiveAttack+20   j  ; was: loc_2DC4C
                clr.l   $18(a5)
                move.w  #$C,$5C(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_BirdDiveAttack
; Bird waiting state with timer countdown before movement
Enemy_BirdWaitState:                                    ; DATA XREF: ROM:0002DB48   o  ; was: sub_2DC62
                move.w  #$C,$5C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_2DC78
                subq.w  #1,$4A(a5)
                beq.s   loc_2DC7A
                addq.w  #2,4(a5)
locret_2DC78:                                           ; CODE XREF: Enemy_BirdWaitState+A   j
                rts
; ---------------------------------------------------------------------------
loc_2DC7A:                                              ; CODE XREF: Enemy_BirdWaitState+10   j
                move.w  #$C,$5C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #4,4(a5)
                rts
; End of function Enemy_BirdWaitState
; Bird chases player calculating direction and dive distance
Enemy_BirdChasePlayer:                                  ; DATA XREF: ROM:0002DB4A   o  ; was: sub_2DC8C
                jsr     (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s   loc_2DCA0
                move.l  #$FFFE0000,$18(a5)
                bra.s   loc_2DCA8
; ---------------------------------------------------------------------------
loc_2DCA0:                                              ; CODE XREF: Enemy_BirdChasePlayer+8   j
                move.l  #$20000,$18(a5)
loc_2DCA8:                                              ; CODE XREF: Enemy_BirdChasePlayer+12   j
                cmpi.w  #$80,d0
                bcc.s   loc_2DCC2
                move.w  #8,$5C(a5)
                move.l  #$FFFA8000,$1C(a5)
                addq.w  #6,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_2DCC2:                                              ; CODE XREF: Enemy_BirdChasePlayer+20   j
                subq.w  #4,4(a5)
                tst.b   $58(a5)
                beq.s   loc_2DCDC
                move.w  #8,$5C(a5)
                move.l  #$FFFB0000,$1C(a5)
                bra.s   locret_2DCEA
; ---------------------------------------------------------------------------
loc_2DCDC:                                              ; CODE XREF: Enemy_BirdChasePlayer+3E   j
                move.w  #$10,$5C(a5)
                move.l  #$FFFD8000,$1C(a5)
locret_2DCEA:                                           ; CODE XREF: Enemy_BirdChasePlayer+4E   j
                rts
; End of function Enemy_BirdChasePlayer
; Bird enemy wait state timer countdown before state transition
Enemy_BirdWaitTimer:                                    ; DATA XREF: ROM:0002DB4C   o  ; was: sub_2DCEC
                subq.w  #1,$48(a5)
                bpl.s   locret_2DCFC
                move.w  #4,$4A(a5)
                subq.w  #2,4(a5)
locret_2DCFC:                                           ; CODE XREF: Enemy_BirdWaitTimer+4   j
                rts
; End of function Enemy_BirdWaitTimer
; Bird descends with negative velocity until reaching threshold
Enemy_BirdDescendToThreshold:                           ; DATA XREF: ROM:0002DB4E   o  ; was: sub_2DCFE
                addi.l  #-$4000,$1C(a5)
                cmpi.l  #$FFFA8000,$1C(a5)
                bgt.s   locret_2DD14
                addq.w  #2,4(a5)
locret_2DD14:                                           ; CODE XREF: Enemy_BirdDescendToThreshold+10   j
                rts
; End of function Enemy_BirdDescendToThreshold
; Bird accelerates upward with gravity until reaching threshold
Enemy_BirdAccelerate:                                   ; DATA XREF: ROM:0002DB50   o  ; was: sub_2DD16
                addi.l  #$4000,$1C(a5)
                cmpi.l  #$28000,$1C(a5)
                blt.s   locret_2DD2C
                addq.w  #2,4(a5)
locret_2DD2C:                                           ; CODE XREF: Enemy_BirdAccelerate+10   j
                rts
; End of function Enemy_BirdAccelerate
; Bird decelerates downward with negative gravity and state change
Enemy_BirdDecelerate:                                   ; DATA XREF: ROM:0002DB52   o  ; was: sub_2DD2E
                addi.l  #-$4000,$1C(a5)
                cmpi.l  #$FFFE0000,$1C(a5)
                bgt.s   locret_2DD50
                move.w  #$100,$48(a5)
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
locret_2DD50:                                           ; CODE XREF: Enemy_BirdDecelerate+10   j
                rts
; End of function Enemy_BirdDecelerate
; Bird attack state with AI movement and projectile firing
Enemy_BirdAttackState:                                  ; DATA XREF: ROM:0002DB54   o  ; was: sub_2DD52
                bsr.w   Enemy_BirdAITracking
                bsr.w   Enemy_BirdFireProjectile
                subq.w  #1,$48(a5)
                bne.s   locret_2DD6A
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
locret_2DD6A:                                           ; CODE XREF: Enemy_BirdAttackState+C   j
                rts
; End of function Enemy_BirdAttackState
; Bird ascends with positive velocity until reaching threshold
Enemy_BirdAscendToThreshold:                            ; DATA XREF: ROM:0002DB56   o  ; was: sub_2DD6C
                addi.l  #$4000,$1C(a5)
                cmpi.l  #$20000,$1C(a5)
                blt.s   locret_2DD82
                addq.w  #2,4(a5)
locret_2DD82:                                           ; CODE XREF: Enemy_BirdAscendToThreshold+10   j
                rts
; End of function Enemy_BirdAscendToThreshold
; Bird oscillates velocity values for horizontal and vertical movement
Enemy_BirdOscillateMovement:                            ; DATA XREF: ROM:0002DB58   o  ; was: sub_2DD84
                btst    #7,$1C(a5)
                bne.s   loc_2DD94
                addi.l  #-$2000,$1C(a5)
loc_2DD94:                                              ; CODE XREF: Enemy_BirdOscillateMovement+6   j
                btst    #7,$18(a5)
                bne.s   loc_2DDA6
                addi.l  #$800,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2DDA6:                                              ; CODE XREF: Enemy_BirdOscillateMovement+16   j
                addi.l  #-$800,$18(a5)
                rts
; End of function Enemy_BirdOscillateMovement
; Bird AI tracks player position with velocity adjustments and randomization
Enemy_BirdAITracking:                                   ; CODE XREF: Enemy_BirdAttackState   p  ; was: sub_2DDB0
                move.w  (word_FFA000).w,d7
                andi.w  #$1F,d7
                bne.s   loc_2DDDA
                move.b  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                subi.w  #$40,d0                         ; '@'
                move.w  d0,$4C(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0                         ; '?'
                subi.w  #$20,d0                         ; ' '
                move.w  d0,$4E(a5)
loc_2DDDA:                                              ; CODE XREF: Enemy_BirdAITracking+8   j
                move.w  (word_FF8248).w,d0
                add.w   $4C(a5),d0
                move.w  (word_FF824A).w,d1
                subi.w  #$60,d1                         ; '`'
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
loc_2DE14:                                              ; CODE XREF: Enemy_BirdAITracking+46   j
                addi.l  #$2000,$18(a5)
                cmpi.l  #$20000,$18(a5)
                ble.s   loc_2DE2E
                move.l  #$20000,$18(a5)
loc_2DE2E:                                              ; CODE XREF: Enemy_BirdAITracking+42   j
                                        ; Enemy_BirdAITracking+58   j
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
loc_2DE54:                                              ; CODE XREF: Enemy_BirdAITracking+86   j
                addi.l  #$4000,$1C(a5)
                cmpi.l  #$20000,$1C(a5)
                ble.s   locret_2DE6E
                move.l  #$20000,$1C(a5)
locret_2DE6E:                                           ; CODE XREF: Enemy_BirdAITracking+82   j
                                        ; Enemy_BirdAITracking+98   j
                rts
; End of function Enemy_BirdAITracking
; Spawns bird projectile with direction
Enemy_BirdFireProjectile:                               ; CODE XREF: Enemy_BirdFireWrapper   p  ; was: sub_2DE70
                                        ; Enemy_BirdAttackState+4   p
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   locret_2DEC6
                jsr     (Projectile_UpdateTrajectory).l
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
loc_2DEB8:                                              ; CODE XREF: Enemy_BirdFireProjectile+36   j
                move.l  #$FFFFE000,$18(a0)
                addi.w  #-$10,$10(a0)
locret_2DEC6:                                           ; CODE XREF: Enemy_BirdFireProjectile+8   j
                rts
; End of function Enemy_BirdFireProjectile
; Bird enemy bounces off with reversed velocity after hit
Enemy_BirdBounceOff:                                    ; CODE XREF: Enemy_BirdMain+A   j  ; was: sub_2DEC8
                                        ; Enemy_BirdMain+12   j
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
                bra.w   Enemy_UpdateBirdAnimation
; End of function Enemy_BirdBounceOff
; Bird spawns projectiles with gravity and explosion effect
Enemy_BirdProjectileSpawn:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2DEFE
                bsr.w   Enemy_ToggleSpriteVisibility
                addi.l  #$2000,$1C(a5)
                tst.w   4(a5)
                bne.s   loc_2DF1A
                tst.w   $1C(a5)
                bmi.s   loc_2DF1A
                addq.w  #2,4(a5)
loc_2DF1A:                                              ; CODE XREF: Enemy_BirdProjectileSpawn+10   j
                                        ; Enemy_BirdProjectileSpawn+16   j
                move.w  (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   locret_2DF7C
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_2DF7C
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E953C,8(a0)
                jsr     (Sprite_InitType160).l
                subq.w  #1,$4A(a5)
                bne.s   locret_2DF7C
                moveq   #2,d0
                moveq   #4,d1
                movea.l #off_E953C,a1
                jsr     (Projectile_SpawnMultiPattern).l
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                cmpi.w  #$1B8,(word_FFDB20).w
                beq.s   loc_2DF76
                moveq   #7,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2DF76:                                              ; CODE XREF: Enemy_BirdProjectileSpawn+6E   j
                bset    #4,2(a5)
locret_2DF7C:                                           ; CODE XREF: Enemy_BirdProjectileSpawn+24   j
                                        ; Enemy_BirdProjectileSpawn+2C   j
                rts
; End of function Enemy_BirdProjectileSpawn
; Main dispatcher for Stage 10 fly enemy
