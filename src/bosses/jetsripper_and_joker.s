Boss_JetsripperIdle:                                    ; CODE XREF: Enemy_ProcessAltProjectile+E   j  ; was: sub_2CB86
                move.w  #$1D8,(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #off_EA69C,8(a5)
                clr.w   $C(a5)
                move.w  #$10,$48(a5)
                move.l  #$FFFB2000,$1C(a5)
                move.l  #$FFFEA000,$18(a5)
                btst    #3,$E(a5)
                beq.s   locret_2CBC4
                neg.l   $18(a5)
locret_2CBC4:                                           ; CODE XREF: Boss_JetsripperIdle+38   j
                rts
; End of function Boss_JetsripperIdle
; Falling projectile handler
Projectile_JetsripperFalling:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2CBC6
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_2CBE2
                jsr     (Projectile_ExplodeWithSound).l
                moveq   #7,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2CBE2:                                              ; CODE XREF: Projectile_JetsripperFalling+C   j
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2CBF6
                bclr    #7,2(a5)
locret_2CBF6:                                           ; CODE XREF: Projectile_JetsripperFalling+28   j
                rts
; End of function Projectile_JetsripperFalling
; Main processing routine for projectile object
Enemy_ProcessProjectile:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2CBF8
                tst.w   4(a5)
                beq.s   Enemy_ProcessProjectileState
                clr.w   6(a5)
                tst.w   $24(a5)
                bpl.s   Enemy_ProcessProjectileState
                bsr.w   Boss_JokerRecoilAttack
; Processes projectile-type enemy state with recoil attack check
Enemy_ProcessProjectileState:                           ; CODE XREF: Enemy_ProcessProjectile+4   j  ; was: loc_2CC0C
                                        ; Enemy_ProcessProjectile+E   j
                bsr.s   Enemy_ProjectileStateHandler
                bra.w   Anim_UpdateProjectileAnimation
; End of function Enemy_ProcessProjectile
; Dispatches projectile to state handler
Enemy_ProjectileStateHandler:                           ; CODE XREF: Enemy_ProcessProjectile:loc_2CC0C   p  ; was: sub_2CC12
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2CC26(pc,d0.w),a0
                adda.l  #Enemy_ProjectileStateMachine,a0
                jmp     (a0)
; End of function Enemy_ProjectileStateHandler
; ---------------------------------------------------------------------------
off_2CC26:      dc.w    Enemy_ProjectileStateMachine-Enemy_ProjectileStateMachine
                                        ; DATA XREF: Enemy_ProjectileStateHandler+8   r
                dc.w    Enemy_ProjectileStateMachine_CheckWallBounce-Enemy_ProjectileStateMachine
                dc.w    Enemy_ProjectileStateMachine_TrackPlayer-Enemy_ProjectileStateMachine
                dc.w    Physics_BossGravityAndCollision-Enemy_ProjectileStateMachine
                dc.w    Physics_BossGravityAndCollision-Enemy_ProjectileStateMachine
                dc.w    Boss_RecoilFallPattern-Enemy_ProjectileStateMachine
                dc.w    Enemy_GroundWalkWithProjectile-Enemy_ProjectileStateMachine

; State machine for projectile movement and collision
Enemy_ProjectileStateMachine:                           ; DATA XREF: Enemy_ProjectileStateHandler+C   o  ; was: sub_2CC34
                                        ; ROM:off_2CC26   o
                move.w  #$1E,$24(a5)
                bsr.w   Sprite_InitializeProjectileSprite
loc_2CC3E:                                              ; CODE XREF: Enemy_ProjectileStateMachine+86   j
                                        ; Physics_BossGravityAndCollision+30   j
                move.w  #2,4(a5)
                move.w  #4,$5C(a5)
                move.w  #$60,$48(a5)                    ; '`'
                clr.l   $18(a5)
; Checks for wall collision and sets bounce state
Enemy_ProjectileStateMachine_CheckWallBounce:           ; DATA XREF: ROM:0002CC28   o  ; was: loc_2CC54
                jsr     (Physics_EntityWallCheck).l
                jsr     (Player_ActionDispatcher).l
                btst    #0,6(a5)
                beq.w   Enemy_ProjectileBounceState
                subq.w  #1,$48(a5)
                bpl.s   loc_2CC8C
                move.w  #$FFFF,$48(a5)
                bsr.w   Enemy_FacePlayer
                cmpi.w  #$60,d0                         ; '`'
                bpl.s   loc_2CC84
                bra.w   Enemy_SetWaitState
; ---------------------------------------------------------------------------
loc_2CC84:                                              ; CODE XREF: Enemy_ProjectileStateMachine+4A   j
                tst.w   $48(a5)
                bmi.w   loc_2CC90
loc_2CC8C:                                              ; CODE XREF: Enemy_ProjectileStateMachine+3A   j
                bra.w   Physics_ApplyHorizontalFriction
; ---------------------------------------------------------------------------
loc_2CC90:                                              ; CODE XREF: Enemy_ProjectileStateMachine+54   j
                move.w  #4,4(a5)
                move.w  #8,$5C(a5)
; Tracks player position and adjusts projectile direction
Enemy_ProjectileStateMachine_TrackPlayer:               ; DATA XREF: ROM:0002CC2A   o  ; was: loc_2CC9C
                jsr     (Physics_EntityWallCheck).l
                jsr     (Player_ActionDispatcher).l
                btst    #0,6(a5)
                beq.w   Enemy_ProjectileBounceState
                bsr.w   Enemy_FacePlayer
                cmpi.w  #$50,d0                         ; 'P'
                bmi.w   loc_2CC3E
                btst    #1,7(a5)
                bne.w   loc_2CCD6
                btst    #0,7(a5)
                bne.w   loc_2CCD6
                bra.w   Physics_SetHorizontalVelocityByFlip
; ---------------------------------------------------------------------------
loc_2CCD6:                                              ; CODE XREF: Enemy_ProjectileStateMachine+90   j
                                        ; Enemy_ProjectileStateMachine+9A   j
                move.w  #8,4(a5)
                move.w  #$24,$5C(a5)                    ; '$'
                move.l  #$FFFA4000,$1C(a5)
                bsr.w   Physics_SetHorizontalVelocityByFlip
; End of function Enemy_ProjectileStateMachine
; Applies gravity with max falling speed $7C000, checks terrain and player collision
Physics_BossGravityAndCollision:                        ; CODE XREF: Enemy_ProjectileBounceState+16   j  ; was: sub_2CCEE
                                        ; DATA XREF: ROM:0002CC2C   o
                jsr     (Physics_BossTerrainCheck).l
                cmpi.l  #$7C000,$1C(a5)
                bmi.s   loc_2CD08
                move.l  #$7C000,$1C(a5)
                bra.s   loc_2CD12
; ---------------------------------------------------------------------------
loc_2CD08:                                              ; CODE XREF: Physics_BossGravityAndCollision+E   j
                addi.l  #$6000,$1C(a5)
                bmi.s   loc_2CD22
loc_2CD12:                                              ; CODE XREF: Physics_BossGravityAndCollision+18   j
                jsr     (Player_CheckTerrainCollision).l
                btst    #0,6(a5)
                bne.w   loc_2CC3E
loc_2CD22:                                              ; CODE XREF: Physics_BossGravityAndCollision+22   j
                jmp     Physics_TerrainCheckWithVelocity
; End of function Physics_BossGravityAndCollision
; Sets state 6, halves horizontal velocity, branches to gravity/collision routine
Enemy_ProjectileBounceState:                            ; CODE XREF: Enemy_ProjectileStateMachine+32   j  ; was: sub_2CD28
                                        ; Enemy_ProjectileStateMachine+7A   j
                move.w  #6,4(a5)
                move.w  #$28,$5C(a5)                    ; '('
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                bra.w   Physics_BossGravityAndCollision
; End of function Enemy_ProjectileBounceState
; Sets enemy to waiting state with specific timer and animation values
Enemy_SetWaitState:                                     ; CODE XREF: Enemy_ProjectileStateMachine+4C   j  ; was: sub_2CD42
                move.w  #$C,4(a5)
                move.w  #$10,$5C(a5)
                move.w  #$36,$48(a5)                    ; '6'
; End of function Enemy_SetWaitState
; Ground-based enemy movement with projectile spawning at specific timing
Enemy_GroundWalkWithProjectile:                         ; DATA XREF: ROM:0002CC32   o  ; was: sub_2CD54
                jsr     (Physics_EntityWallCheck).l
                jsr     (Player_ActionDispatcher).l
                btst    #0,6(a5)
                beq.w   Enemy_ProjectileBounceState
                subq.w  #1,$48(a5)
                bmi.w   loc_2CC3E
                cmpi.w  #$1E,$48(a5)
                bne.s   loc_2CD96
                moveq   #$18,d5
                moveq   #$FFFFFFFA,d6
                move.l  #$38000,d7
                btst    #3,$E(a5)
                beq.s   loc_2CD90
                neg.w   d5
                neg.l   d7
loc_2CD90:                                              ; CODE XREF: Enemy_GroundWalkWithProjectile+36   j
                jsr     (Projectile_SpawnFallingDebris).l
loc_2CD96:                                              ; CODE XREF: Enemy_GroundWalkWithProjectile+24   j
                bsr.w   Physics_ApplyHorizontalFriction
                cmpi.w  #$10,$48(a5)
                bmi.s   locret_2CDA6
                bsr.w   Enemy_FacePlayer
locret_2CDA6:                                           ; CODE XREF: Enemy_GroundWalkWithProjectile+4C   j
                rts
; End of function Enemy_GroundWalkWithProjectile
; Boss recoil attack launching upward then spawning projectile
Boss_JokerRecoilAttack:                                 ; CODE XREF: Enemy_ProcessProjectile+10   p  ; was: sub_2CDA8
                move.w  #$A,4(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.w  #$24,$5C(a5)                    ; '$'
                move.w  #$10,$48(a5)
                move.l  #$FFFB2000,$1C(a5)
                move.l  #$FFFEA000,$18(a5)
                btst    #3,$E(a5)
                beq.s   Boss_RecoilFallPattern
                neg.l   $18(a5)
; Boss recoil and fall pattern with gravity and velocity changes
Boss_RecoilFallPattern:                                 ; CODE XREF: Boss_JokerRecoilAttack+34   j  ; was: loc_2CDE2
                                        ; DATA XREF: ROM:0002CC30   o
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_2CDFE
                jsr     (Projectile_ExplodeWithSound).l
                moveq   #7,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2CDFE:                                              ; CODE XREF: Boss_JokerRecoilAttack+46   j
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2CE12
                bclr    #7,2(a5)
locret_2CE12:                                           ; CODE XREF: Boss_JokerRecoilAttack+62   j
                rts
; End of function Boss_JokerRecoilAttack
; ---------------------------------------------------------------------------
word_2CE14:     dc.w    $98, $60                        ; DATA XREF: Enemy_AltProjectileStateMachine+16   o
word_2CE18:     dc.w    1, 4                            ; DATA XREF: Enemy_AltProjectileStateMachine+3A   o

; Processing routine for alternative projectile type
Enemy_ProcessAltProjectile:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2CE1C
                tst.w   4(a5)
                beq.s   Enemy_ProcessAltState
                clr.w   6(a5)
                tst.w   $24(a5)
                bmi.w   Boss_JetsripperIdle
; Processes alternative enemy/projectile state handler
Enemy_ProcessAltState:                                  ; CODE XREF: Enemy_ProcessAltProjectile+4   j  ; was: loc_2CE2E
                bsr.s   Enemy_AltProjectileStateHandler
                bra.w   Anim_UpdateProjectileAnimation
; End of function Enemy_ProcessAltProjectile
; Dispatches alternative projectile to state handler
Enemy_AltProjectileStateHandler:                        ; CODE XREF: Enemy_ProcessAltProjectile:loc_2CE2E   p  ; was: sub_2CE34
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2CE48(pc,d0.w),a0
                adda.l  #Enemy_AltProjectileStateMachine,a0
                jmp     (a0)
; End of function Enemy_AltProjectileStateHandler
; ---------------------------------------------------------------------------
off_2CE48:      dc.w    Enemy_AltProjectileStateMachine-Enemy_AltProjectileStateMachine
                                        ; DATA XREF: Enemy_AltProjectileStateHandler+8   r
                dc.w    Enemy_AltProjectileStateMachine_WaitTimer-Enemy_AltProjectileStateMachine
                dc.w    Enemy_HomingProjectileLoop-Enemy_AltProjectileStateMachine

; State machine for alternative projectile with difficulty scaling
Enemy_AltProjectileStateMachine:                        ; DATA XREF: Enemy_AltProjectileStateHandler+C   o  ; was: sub_2CE4E
                                        ; ROM:off_2CE48   o
                move.w  #$A,$24(a5)
                bsr.w   Sprite_InitializeProjectileSprite
loc_2CE58:                                              ; CODE XREF: Enemy_AltProjectileStateMachine+54   j
                move.w  #2,4(a5)
                move.w  #4,$5C(a5)
                lea     word_2CE14(pc),a0
                move.w  (word_FFFF0E).w,d0
                move.w  (a0,d0.w),$48(a5)
; Waits for timer countdown before transitioning
Enemy_AltProjectileStateMachine_WaitTimer:              ; DATA XREF: ROM:0002CE4A   o  ; was: loc_2CE72
                subq.w  #1,$48(a5)
                bmi.s   loc_2CE7A
                rts
; ---------------------------------------------------------------------------
loc_2CE7A:                                              ; CODE XREF: Enemy_AltProjectileStateMachine+28   j
                addq.w  #2,4(a5)
                move.w  #$80,$C(a5)
                clr.w   $48(a5)
                lea     word_2CE18(pc),a0
                move.w  (word_FFFF0E).w,d0
                move.w  (a0,d0.w),$4A(a5)
; Main loop for homing projectile with angle updates and spawning
Enemy_HomingProjectileLoop:                             ; DATA XREF: ROM:0002CE4C   o  ; was: loc_2CE96
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_2CEC8
                subq.w  #1,$4A(a5)
                bmi.w   loc_2CE58
                bsr.w   Enemy_CalculateDirectionalSprite
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2CEC8
                move.w  d3,d0
                move.w  d4,d1
                move.w  d2,d6
                move.w  (word_FF808A).w,d2
                addi.w  #$40,d2                         ; '@'
                moveq   #$A,d7
                jmp     Enemy_SetProjectileDifficulty
; ---------------------------------------------------------------------------
locret_2CEC8:                                           ; CODE XREF: Enemy_AltProjectileStateMachine+4E   j
                                        ; Enemy_AltProjectileStateMachine+62   j
                rts
; End of function Enemy_AltProjectileStateMachine
; State handler for ship boss
