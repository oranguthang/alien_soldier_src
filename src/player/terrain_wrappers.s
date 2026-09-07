Physics_EntityTerrainWrapper:                           ; CODE XREF: Player_HandleJump   p  ; was: sub_16CC8
                                        ; sub_152CA   p
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jmp     Physics_EntityWallCheck
; End of function Physics_EntityTerrainWrapper
; Boss terrain collision wrapper checking flag before testing terrain
Physics_BossTerrainWrapper:                             ; CODE XREF: Physics_BossCollisionCheck+8   p  ; was: sub_16CD8
                                        ; sub_15B8C   p
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jmp     Physics_BossTerrainCheck
; End of function Physics_BossTerrainWrapper
; Processes player action through dispatcher
Player_ProcessAction:                                   ; CODE XREF: Player_HandleJump+6   p  ; was: sub_16CE8
                                        ; Physics_ApplyBossVelocity+6   p
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jsr     (Collision_CheckPlayerPlatforms).l
                jmp     Player_ActionDispatcher
; End of function Player_ProcessAction
; Updates player state and checks terrain collision
Player_UpdateTerrainCheck:                              ; CODE XREF: Physics_BossCollisionCheck+14   p  ; was: sub_16CFE
                                        ; Player_DashKickState+E   p
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jsr     (Collision_CheckPlayerPlatforms).l
                jmp     Player_CheckTerrainCollision
; End of function Player_UpdateTerrainCheck
; Standard terrain collision check for player
Player_TerrainCheckStandard:                            ; CODE XREF: Player_HandleDashState+6   p  ; was: sub_16D14
                                        ; Player_HandleAirDashState+6   p
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jsr     (Collision_CheckPlayerPlatforms).l
                jmp     Physics_MultiPointTerrainCheck
; End of function Player_TerrainCheckStandard
; Alternative terrain collision check with velocity
Player_TerrainCheckAlternate:                           ; CODE XREF: Physics_BossCollisionCheck+28   p  ; was: sub_16D2A
                                        ; Player_HandleFallingState+5A   p
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jsr     (Collision_CheckPlayerPlatforms).l
                jmp     Physics_TerrainCheckWithVelocity
; End of function Player_TerrainCheckAlternate
; Dispatches player action based on facing direction
Player_DirectionDispatcher:                             ; CODE XREF: Player_PhoenixAttackUpdate+86   p  ; was: sub_16D40
                                        ; sub_159E0:loc_159F0   p
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jsr     (Collision_CheckPlayerPlatforms).l
                btst    #4,$E(a5)
                beq.w   Player_ActionDispatcher
                jmp     Physics_MultiPointTerrainCheck
; End of function Player_DirectionDispatcher
; Player terrain collision check with flipped hitbox offset direction
Player_TerrainCheckFlipped:                             ; CODE XREF: Player_PhoenixAttackUpdate+82   p  ; was: sub_16D60
                                        ; Player_ApplyHorizontalMovement+4   p
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                moveq   #$FFFFFFE8,d6
                btst    #4,$E(a5)
                beq.w   Physics_BossTerrainCheck_Begin
                moveq   #$18,d6
                jmp     Physics_BossTerrainCheck_Begin
; ---------------------------------------------------------------------------
locret_16D7E:                                           ; CODE XREF: Physics_EntityTerrainWrapper+6   j
                                        ; Physics_BossTerrainWrapper+6   j
                rts
; End of function Player_TerrainCheckFlipped
; Processes D-pad input for character facing direction
Input_ProcessDirectionInput:                            ; CODE XREF: Player_Update+58   p  ; was: sub_16D80
                                        ; Boss_SylpheedSpawnProjectile1+6   p
                tst.w   (word_FFA02A).w
                bne.w   locret_16DE4
                move.b  $69(a5),d1
                move.w  (word_FFA22A).w,d0
                beq.s   loc_16D9C
                btst    #4,$69(a5)
                bne.s   loc_16DA6
                rts
; ---------------------------------------------------------------------------
loc_16D9C:                                              ; CODE XREF: Input_ProcessDirectionInput+10   j
                btst    #4,$6A(a5)
                bne.s   loc_16DA6
                rts
; ---------------------------------------------------------------------------
loc_16DA6:                                              ; CODE XREF: Input_ProcessDirectionInput+18   j
                                        ; Input_ProcessDirectionInput+22   j
                btst    #2,d1
                beq.s   loc_16DB8
                bclr    #3,$E(a5)
                bclr    #3,d1
                bra.s   loc_16DC8
; ---------------------------------------------------------------------------
loc_16DB8:                                              ; CODE XREF: Input_ProcessDirectionInput+2A   j
                btst    #3,d1
                beq.s   loc_16DC8
                bset    #3,$E(a5)
                bclr    #2,d1
loc_16DC8:                                              ; CODE XREF: Input_ProcessDirectionInput+36   j
                                        ; Input_ProcessDirectionInput+3C   j
                andi.w  #$F,d1
                bne.s   loc_16DDC
                moveq   #4,d0
                btst    #3,$E(a5)
                beq.s   Input_StoreDirectionByte
                moveq   #0,d0
                bra.s   Input_StoreDirectionByte
; ---------------------------------------------------------------------------
loc_16DDC:                                              ; CODE XREF: Input_ProcessDirectionInput+4C   j
                move.b  byte_16DE6(pc,d1.w),d0
; Stores processed direction input byte to player entity
Input_StoreDirectionByte:                               ; CODE XREF: Input_ProcessDirectionInput+56   j  ; was: loc_16DE0
                                        ; Input_ProcessDirectionInput+5A   j
                move.b  d0,$9E(a5)
locret_16DE4:                                           ; CODE XREF: Input_ProcessDirectionInput+4   j
                rts
; End of function Input_ProcessDirectionInput
; ---------------------------------------------------------------------------
byte_16DE6:     dc.b    0, 6, 2, 0, 4, 5, 3, 0, 0, 7, 1, 0, 0, 0, 0, 0
                                        ; DATA XREF: Input_ProcessDirectionInput:loc_16DDC   r

; Auto-flips player direction based on weapon aim angle constraints
Player_AutoFlipDirection:                               ; CODE XREF: Player_InitAirState+2A   j  ; was: sub_16DF6
                                        ; Player_InitJumpCancelState+2E   j
                tst.w   (word_FFA22A).w
                bne.s   locret_16E32
                btst    #4,$69(a5)
                beq.s   locret_16E32
                move.b  $9E(a5),d0
                btst    #3,$E(a5)
                beq.s   loc_16E1E
                cmpi.b  #3,d0
                bmi.s   locret_16E32
                cmpi.b  #6,d0
                bmi.s   loc_16E2C
                rts
; ---------------------------------------------------------------------------
loc_16E1E:                                              ; CODE XREF: Player_AutoFlipDirection+18   j
                cmpi.b  #2,d0
                bmi.s   loc_16E2C
                cmpi.b  #7,d0
                bpl.s   loc_16E2C
                rts
; ---------------------------------------------------------------------------
loc_16E2C:                                              ; CODE XREF: Player_AutoFlipDirection+24   j
                                        ; Player_AutoFlipDirection+2C   j
                eori.w  #$800,$E(a5)
locret_16E32:                                           ; CODE XREF: Player_AutoFlipDirection+4   j
                                        ; Player_AutoFlipDirection+C   j
                rts
; End of function Player_AutoFlipDirection
; Applies vertical momentum deceleration based on direction flag
Physics_ApplyVerticalDecel:                             ; CODE XREF: Boss_UpdateHealthBar:loc_1570E   p  ; was: sub_16E34
                                        ; sub_167EE:loc_16846   p
                btst    #3,$E(a5)
                bne.s   loc_16E56
                move.l  $18(a5),d0
                bpl.s   loc_16E4A
                cmpi.l  #$FFFBE000,d0
                bmi.s   loc_16E6A
loc_16E4A:                                              ; CODE XREF: Physics_ApplyVerticalDecel+C   j
                subi.l  #$A800,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_16E56:                                              ; CODE XREF: Physics_ApplyVerticalDecel+6   j
                move.l  $18(a5),d0
                bmi.s   loc_16E64
                cmpi.l  #$42000,d0
                bpl.s   loc_16E6A
loc_16E64:                                              ; CODE XREF: Physics_ApplyVerticalDecel+26   j
                addi.l  #$A800,d0
loc_16E6A:                                              ; CODE XREF: Physics_ApplyVerticalDecel+14   j
                                        ; Physics_ApplyVerticalDecel+2E   j
                move.l  d0,$18(a5)
                rts
; End of function Physics_ApplyVerticalDecel
; Applies downward gravity acceleration with terminal velocity limit
Physics_ApplyDownwardGravity:                           ; CODE XREF: Player_AirAttackState+4A   j  ; was: sub_16E70
                                        ; Player_AirControlState+56   j
                move.l  $18(a5),d0
                bpl.s   loc_16E7E
                cmpi.l  #$FFFD6000,d0
                bmi.s   loc_16E84
loc_16E7E:                                              ; CODE XREF: Physics_ApplyDownwardGravity+4   j
                subi.l  #$A800,d0
loc_16E84:                                              ; CODE XREF: Physics_ApplyDownwardGravity+C   j
                move.l  d0,$18(a5)
                rts
; End of function Physics_ApplyDownwardGravity
; Applies upward gravity acceleration with maximum upward velocity limit
Physics_ApplyUpwardGravity:                             ; CODE XREF: Player_AirAttackState+62   j  ; was: sub_16E8A
                                        ; Player_AirControlState+6E   j
                move.l  $18(a5),d0
                bmi.s   loc_16E98
                cmpi.l  #$2A000,d0
                bpl.s   loc_16E9E
loc_16E98:                                              ; CODE XREF: Physics_ApplyUpwardGravity+4   j
                addi.l  #$A800,d0
loc_16E9E:                                              ; CODE XREF: Physics_ApplyUpwardGravity+C   j
                move.l  d0,$18(a5)
                rts
; End of function Physics_ApplyUpwardGravity
; Applies knockback velocity with direction check
Player_ApplyKnockbackVelocity:                          ; CODE XREF: Player_HandleAirState+30   p  ; was: sub_16EA4
                                        ; Player_HandleAirMovement+34   p
                move.l  #$C000,d1
; End of function Player_ApplyKnockbackVelocity
; Decelerates horizontal velocity towards zero
Player_DecelerateHorizontalVelocity:                    ; CODE XREF: Physics_ApplyBossVelocity+2A   p  ; was: sub_16EAA
                                        ; Player_DefeatGroundedState+22   p
                move.l  $18(a5),d0
                bmi.s   loc_16EBC
                sub.l   d1,d0
                bpl.s   Physics_StoreHorizontalVelocity
                moveq   #0,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_16EBC:                                              ; CODE XREF: Player_DecelerateHorizontalVelocity+4   j
                add.l   d1,d0
                bmi.s   Physics_StoreHorizontalVelocity
                moveq   #0,d0
; Stores final horizontal velocity to player entity after deceleration
Physics_StoreHorizontalVelocity:                        ; CODE XREF: Player_DecelerateHorizontalVelocity+8   j  ; was: loc_16EC2
                                        ; Player_DecelerateHorizontalVelocity+14   j
                move.l  d0,$18(a5)
                rts
; End of function Player_DecelerateHorizontalVelocity
; Processes collision damage and knockback
Player_ProcessCollisionDamage:                          ; CODE XREF: Player_HandleJump+60   j  ; was: sub_16EC8
                                        ; Player_HandleGroundedState+1E   j
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #6,d0
                move.b  byte_16EEA(pc,d0.w),d5
                move.b  byte_16EEA+1(pc,d0.w),d6
                movea.l #word_E8972,a1
                movea.l #word_E8942,a2
                bra.w   Stage_HandleBossDefeat
; End of function Player_ProcessCollisionDamage
; ---------------------------------------------------------------------------
byte_16EEA:     dc.b    1, $FE, 0, $FF, 0, 0, 0, $FF
                                        ; DATA XREF: Player_ProcessCollisionDamage+A   r
                                        ; Player_ProcessCollisionDamage+E   r

; Handles player defeat state with direction check
Player_HandleDefeatByBoss:                              ; CODE XREF: Player_HandleAirState+5E   j  ; was: sub_16EF2
                                        ; Player_HandleLandingState+76   j
                tst.w   $48(a5)
                bpl.s   Player_SetupDefeatSequence1
loc_16EF8:                                              ; CODE XREF: Player_JumpApexState+12   j
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #6,d0
                move.b  byte_16F2E(pc,d0.w),d5
                move.b  byte_16F2E+1(pc,d0.w),d6
                movea.l #word_E8972,a1
                movea.l #word_E8F0A,a2
                bra.w   Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
; Sets up player defeat sequence animation data and parameters (variant 1)
Player_SetupDefeatSequence1:                            ; CODE XREF: Player_HandleDefeatByBoss+4   j  ; was: loc_16F1A
                moveq   #0,d5
                moveq   #8,d6
                movea.l #word_E8972,a1
                movea.l #word_E89C2,a2
                bra.w   Stage_HandleBossDefeat
; End of function Player_HandleDefeatByBoss
; ---------------------------------------------------------------------------
byte_16F2E:     dc.b    1, $F, 0, $10, 0, $11, 0, $10
                                        ; DATA XREF: Player_HandleDefeatByBoss+10   r
                                        ; Player_HandleDefeatByBoss+14   r

; Handles boss death animation frame transitions
