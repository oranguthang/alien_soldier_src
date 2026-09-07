; Handles directional movement while the player is attached to lower terrain
Player_GroundedMovementState:                           ; DATA XREF: ROM:00015064   o  ; was: sub_156B8
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                bsr.w   Physics_LowerTerrainCheckWrapper
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                bsr.w   Player_HandleSpecialMove
                bne.s   Player_GroundedMovementState_Return
                bsr.w   Player_CheckSpecialMoveActivation
                bne.s   Player_GroundedMovementState_Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_HandleDamageKnockback
                btst    #1,$69(a5)
                bne.w   Player_InitJumpCancelState
                btst    #4,$69(a5)
                beq.s   loc_156FC
                tst.w   (word_FFA22A).w
                bne.w   Player_InitAirJumpState
loc_156FC:                                              ; CODE XREF: Player_GroundedMovementState+3A   j
                btst    #2,$69(a5)
                bne.s   loc_1570E
                btst    #3,$69(a5)
                beq.w   Player_InitAirJumpState
loc_1570E:                                              ; CODE XREF: Player_GroundedMovementState+4A   j
                bsr.w   Physics_AccelerateHorizontalByFacing
                btst    #4,$69(a5)
                beq.w   Player_RenderDirectionalMovement
                btst    #3,$69(a5)
                beq.s   loc_15732
                btst    #3,$E(a5)
                beq.w   Player_InitIdleWallState
                bra.w   Player_RenderDashEffect
; ---------------------------------------------------------------------------
loc_15732:                                              ; CODE XREF: Player_GroundedMovementState+6A   j
                btst    #3,$E(a5)
                bne.w   Player_InitIdleWallState
                bra.w   Player_RenderDashEffect
; ---------------------------------------------------------------------------
; Initializes idle wall cling state with cleared velocity
Player_InitIdleWallState:                               ; CODE XREF: Player_CheckWallCollisionJump+2E   j  ; was: loc_15740
                                        ; Player_CheckWallCollisionJump+44   j
                move.w  #4,4(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
locret_15756:                                           ; CODE XREF: Player_AirAttackState+18   j
                                        ; Player_AirAttackState+1E   j
                rts
; End of function Player_GroundedMovementState
; Player air attack state handler processing jump cancels and directional attacks
Player_AirAttackState:                                  ; DATA XREF: ROM:00015066   o  ; was: sub_15758
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                bsr.w   Physics_LowerTerrainCheckWrapper
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                bsr.w   Player_HandleSpecialMove
                bne.s   locret_15756
                bsr.w   Player_CheckSpecialMoveActivation
                bne.s   locret_15756
                btst    #1,$69(a5)
                bne.w   Player_InitJumpCancelState
                btst    #4,$69(a5)
                beq.w   Player_InitWallBounceState
                bsr.w   Player_PrepareWeaponSprite
                btst    #2,$69(a5)
                beq.s   loc_157A6
                btst    #3,$E(a5)
                beq.w   Player_InitWallBounceState
                bra.w   Physics_AccelerateHorizontalNegative
; ---------------------------------------------------------------------------
loc_157A6:                                              ; CODE XREF: Player_AirAttackState+3E   j
                btst    #3,$69(a5)
                beq.w   Player_InitAirJumpState
                btst    #3,$E(a5)
                bne.w   Player_InitWallBounceState
                bra.w   Physics_AccelerateHorizontalPositive
; End of function Player_AirAttackState
; Initializes Phoenix weapon attack
Player_InitPhoenixAttack:
                move.w  #$56,4(a5)                      ; 'V'  ; was: sub_157BE
                move.w  #8,$4E(a5)
                move.b  #$73,(byte_FF830F).w            ; 's'
                jsr     (Sys_ClearObjectBlocks16).l
                move.b  #1,(word_FF8224).w
                move.b  #1,(word_FF8224+1).w
                move.w  #$C,$50(a5)
                clr.w   $12(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                btst    #2,$69(a5)
                bne.s   loc_1580C
                btst    #3,$69(a5)
                bne.s   loc_1581C
                btst    #3,$E(a5)
                bne.s   loc_1581C
loc_1580C:                                              ; CODE XREF: Player_InitPhoenixAttack+3C   j
                move.l  #$FFF88000,$48(a5)
                bclr    #3,$E(a5)
                bra.s   loc_1582A
; ---------------------------------------------------------------------------
loc_1581C:                                              ; CODE XREF: Player_InitPhoenixAttack+44   j
                                        ; Player_InitPhoenixAttack+4C   j
                move.l  #$78000,$48(a5)
                bset    #3,$E(a5)
loc_1582A:                                              ; CODE XREF: Player_InitPhoenixAttack+5C   j
                move.l  #word_E86AA,8(a5)
                bsr.w   Player_SpawnPhoenixTrails
                moveq   #1,d0
                rts
; End of function Player_InitPhoenixAttack
; Updates Phoenix attack state
Player_PhoenixAttackUpdate:                             ; DATA XREF: ROM:000150B8   o  ; was: sub_1583A
                btst    #5,$6A(a5)
                beq.s   loc_15848
                move.w  #7,$50(a5)
loc_15848:                                              ; CODE XREF: Player_PhoenixAttackUpdate+6   j
                subq.w  #1,$4E(a5)
                bpl.w   loc_158A0
                jsr     (Sys_ClearObjectBlocks16).l
                clr.w   $4E(a5)
                cmpi.w  #7,$50(a5)
                beq.s   loc_15866
                addq.w  #2,$4E(a5)
loc_15866:                                              ; CODE XREF: Player_PhoenixAttackUpdate+26   j
                move.w  #$10,4(a5)
                btst    #4,$E(a5)
                beq.s   loc_1587A
                move.w  #$24,4(a5)                      ; '$'
loc_1587A:                                              ; CODE XREF: Player_PhoenixAttackUpdate+38   j
                tst.w   (word_FF8304).w
                bne.s   loc_15896
                btst    #7,(byte_FF8245).w
                bne.s   loc_15896
                move.l  #word_E8E6A,8(a5)
                bsr.w   Player_SpawnProjectile
                bra.s   loc_158A0
; ---------------------------------------------------------------------------
loc_15896:                                              ; CODE XREF: Player_PhoenixAttackUpdate+44   j
                                        ; Player_PhoenixAttackUpdate+4C   j
                move.b  #$A6,d0
                jsr     (Sound_PlaySFX).l
loc_158A0:                                              ; CODE XREF: Player_PhoenixAttackUpdate+12   j
                                        ; Player_PhoenixAttackUpdate+5A   j
                move.w  #1,(word_FF809C).w
                bset    #6,$21(a5)
                bset    #4,$23(a5)
                bset    #4,(byte_FF8244).w
                clr.w   6(a5)
                bsr.w   Physics_FacingExtendedWallCheckWrapper
                bsr.w   Physics_FacingTerrainCheckWrapper
                rts
; End of function Player_PhoenixAttackUpdate
; Spawns two Phoenix trail objects
Player_SpawnPhoenixTrails:                              ; CODE XREF: Player_InitPhoenixAttack+74   p  ; was: sub_158C6
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                moveq   #0,d7
                bsr.s   Player_InitPhoenixTrail
                lea     $60(a0),a0
                addq.w  #2,d7
; End of function Player_SpawnPhoenixTrails
; Initializes single Phoenix trail
Player_InitPhoenixTrail:                                ; CODE XREF: Player_SpawnPhoenixTrails+6   p  ; was: sub_158D4
                move.w  #$10,(a0)
                clr.b   $21(a0)
                move.w  #$C800,2(a0)
                move.l  #word_E8680,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                bpl.s   loc_15906
                clr.b   $20(a0)
loc_15906:                                              ; CODE XREF: Player_InitPhoenixTrail+2C   j
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                clr.w   $1A(a0)
                move.w  word_15926(pc,d7.w),d0
                add.w   d0,$10(a0)
                move.w  word_15926+4(pc,d7.w),$18(a0)
                rts
; End of function Player_InitPhoenixTrail
; ---------------------------------------------------------------------------
word_15926:     dc.w    $20, $FFE0, $FFF8, 8
                                        ; DATA XREF: Player_InitPhoenixTrail+42   r
                                        ; Player_InitPhoenixTrail+4A   r

; Initializes player dash attack with direction and projectile
Player_InitiateDashAttack:                              ; CODE XREF: Player_CheckDashInput+E   j  ; was: sub_1592E
                                        ; Player_CeilingDashState+34   j
                move.w  #$24,4(a5)                      ; '$'
                bra.s   loc_1593C
; ---------------------------------------------------------------------------
loc_15936:                                              ; CODE XREF: Player_GroundedDamageState+20   j
                                        ; Player_CheckSpecialMoveActivation+1A   j
                move.w  #$10,4(a5)
loc_1593C:                                              ; CODE XREF: Player_InitiateDashAttack+6   j
                move.b  #$73,(byte_FF830F).w            ; 's'
                jsr     (Sys_ClearObjectBlocks16).l
                move.b  #1,(word_FF8224).w
                move.b  #1,(word_FF8224+1).w
                clr.w   $4E(a5)
                move.w  #$C,$50(a5)
                clr.w   $12(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                btst    #2,$69(a5)
                bne.s   loc_15982
                btst    #3,$69(a5)
                bne.s   loc_15992
                btst    #3,$E(a5)
                bne.s   loc_15992
loc_15982:                                              ; CODE XREF: Player_InitiateDashAttack+42   j
                move.l  #$FFF88000,$48(a5)
                bclr    #3,$E(a5)
                bra.s   loc_159A0
; ---------------------------------------------------------------------------
loc_15992:                                              ; CODE XREF: Player_InitiateDashAttack+4A   j
                                        ; Player_InitiateDashAttack+52   j
                move.l  #$78000,$48(a5)
                bset    #3,$E(a5)
loc_159A0:                                              ; CODE XREF: Player_InitiateDashAttack+62   j
                tst.w   (word_FF8304).w
                bne.s   Player_PlayDashAttackSound
                btst    #7,(byte_FF8245).w
                bne.s   Player_PlayDashAttackSound
                bsr.w   Player_SpawnProjectile
                move.l  #word_E8E6A,8(a5)
                move.w  #$78,(word_FF8304).w            ; 'x'
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
; Plays dash attack sound effect and sets animation pointer
Player_PlayDashAttackSound:                             ; CODE XREF: Player_InitiateDashAttack+76   j  ; was: loc_159C4
                                        ; Player_InitiateDashAttack+7E   j
                move.b  #$A6,d0
                jsr     (Sound_PlaySFX).l
                move.l  #word_E86AA,8(a5)
                move.w  #$78,(word_FF8304).w            ; 'x'
                moveq   #1,d0
                rts
; End of function Player_InitiateDashAttack
; Handles dash cancel state and timer management
Player_HandleDashCancel:                                ; DATA XREF: ROM:00015072   o  ; was: sub_159E0
                                        ; ROM:00015086   o
                tst.b   (byte_FF8311).w
                bne.s   loc_159F0
                subq.w  #1,$50(a5)
                bmi.s   loc_159F0
                bra.w   loc_15A6E
; ---------------------------------------------------------------------------
loc_159F0:                                              ; CODE XREF: Player_HandleDashCancel+4   j
                                        ; Player_HandleDashCancel+A   j
                bsr.w   Physics_FacingTerrainCheckWrapper
loc_159F4:                                              ; CODE XREF: Player_HandleDashCancel:loc_15A6C   j
                clr.w   (word_FFC5C0).w
                bclr    #0,(byte_FF826C).w
                bclr    #6,$21(a5)
                bclr    #4,$23(a5)
                moveq   #0,d0
                btst    #4,$E(a5)
                beq.s   loc_15A16
                moveq   #1,d0
loc_15A16:                                              ; CODE XREF: Player_HandleDashCancel+32   j
                btst    d0,6(a5)
                bne.s   loc_15A46
                move.w  #$FFE0,$52(a5)
                move.l  $48(a5),$18(a5)
                tst.w   $4E(a5)
                beq.s   loc_15A38
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
loc_15A38:                                              ; CODE XREF: Player_HandleDashCancel+4C   j
                btst    #4,$E(a5)
                beq.w   loc_15C3C
                bra.w   Player_InitAirDashEnd
; ---------------------------------------------------------------------------
loc_15A46:                                              ; CODE XREF: Player_HandleDashCancel+3A   j
                clr.w   (word_FF8224).w
                tst.w   $4E(a5)
                bne.s   loc_15A5E
                btst    #4,$E(a5)
                beq.w   Player_InitSlideState
                bra.w   Player_InitSlideState
; ---------------------------------------------------------------------------
loc_15A5E:                                              ; CODE XREF: Player_HandleDashCancel+6E   j
                btst    #4,$E(a5)
                beq.w   Player_InitJumpCancelCleanup
                bra.w   Player_InitDashAnimation
; ---------------------------------------------------------------------------
loc_15A6C:                                              ; CODE XREF: Player_HandleDashCancel+A4   j
                                        ; Player_HandleDashCancel+AA   j
                bra.s   loc_159F4
; ---------------------------------------------------------------------------
loc_15A6E:                                              ; CODE XREF: Player_HandleDashCancel+C   j
                move.w  #1,(word_FF809C).w
                bset    #6,$21(a5)
                bset    #4,$23(a5)
                bsr.w   Player_ApplyHorizontalMovement
                bne.s   loc_15A6C
                bsr.w   Player_ApplyHorizontalMovement
                bne.s   loc_15A6C
                bsr.w   Player_ApplyHorizontalMovement
                bne.s   loc_15A6C
                bset    #4,(byte_FF8244).w
                bra.w   Effect_CreateDashTrail
; End of function Player_HandleDashCancel
; Applies horizontal movement with boundary checking
Player_ApplyHorizontalMovement:                         ; CODE XREF: Player_HandleDashCancel+A0   p  ; was: sub_15A9C
                                        ; Player_HandleDashCancel+A6   p
                clr.w   6(a5)
                bsr.w   Physics_FacingExtendedWallCheckWrapper
                bsr.w   Physics_FacingTerrainCheckWrapper
                tst.w   $48(a5)
                bmi.s   loc_15AB8
                btst    #1,7(a5)
                beq.s   loc_15AC0
                rts
; ---------------------------------------------------------------------------
loc_15AB8:                                              ; CODE XREF: Player_ApplyHorizontalMovement+10   j
                btst    #0,7(a5)
                bne.s   locret_15AF2
loc_15AC0:                                              ; CODE XREF: Player_ApplyHorizontalMovement+18   j
                move.l  $48(a5),d0
                add.l   d0,$10(a5)
                btst    #1,(byte_FF8245).w
                bne.s   loc_15AF0
                cmpi.w  #$1AF,$10(a5)
                bmi.s   loc_15AE2
                move.w  #$1AF,$10(a5)
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_15AE2:                                              ; CODE XREF: Player_ApplyHorizontalMovement+3A   j
                cmpi.w  #$90,$10(a5)
                bpl.s   loc_15AF0
                move.w  #$90,$10(a5)
loc_15AF0:                                              ; CODE XREF: Player_ApplyHorizontalMovement+32   j
                                        ; Player_ApplyHorizontalMovement+4C   j
                moveq   #0,d0
locret_15AF2:                                           ; CODE XREF: Player_ApplyHorizontalMovement+22   j
                rts
; End of function Player_ApplyHorizontalMovement
; Initializes player slide knockback state
Player_InitSlideState:                                  ; CODE XREF: Player_HandleDashCancel+76   j  ; was: sub_15AF4
                                        ; Player_HandleDashCancel+7A   j
                move.b  #$7F,(byte_FF830F).w
                move.w  #$40,4(a5)                      ; '@'
                move.w  #4,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                tst.w   $48(a5)
                bmi.s   loc_15B18
                neg.l   $18(a5)
loc_15B18:                                              ; CODE XREF: Player_InitSlideState+1E   j
                move.w  #2,$48(a5)
                rts
; End of function Player_InitSlideState
; Handles player slide knockback state
Player_HandleSlideState:                                ; DATA XREF: ROM:000150A2   o  ; was: sub_15B20
                                        ; ROM:000150A4   o
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                bsr.w   Physics_FacingTerrainCheckWrapper
                moveq   #0,d0
                btst    #4,$E(a5)
                beq.s   loc_15B36
                moveq   #1,d0
loc_15B36:                                              ; CODE XREF: Player_HandleSlideState+12   j
                btst    d0,6(a5)
                beq.w   Player_InitFallState
                move.l  #$4000,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                tst.l   $18(a5)
                bne.s   loc_15B5C
                btst    #4,$E(a5)
                beq.w   Player_InitJumpCancelCleanup
                bra.w   Player_InitDashAnimation
; ---------------------------------------------------------------------------
loc_15B5C:                                              ; CODE XREF: Player_HandleSlideState+2C   j
                subq.w  #1,$48(a5)
                bra.w   Player_RenderAirborneFrame
; End of function Player_HandleSlideState
nullsub_39:
                rts
; End of function nullsub_39

; Initializes dash kick with velocity
Player_InitDashKick:
                move.w  #$44,4(a5)                      ; 'D'  ; was: sub_15B66
                move.w  #4,$5C(a5)
                bclr    #4,$E(a5)
                move.l  #$FFFCE000,$18(a5)
                tst.w   $48(a5)
                bmi.s   locret_15B8A
                neg.l   $18(a5)
locret_15B8A:                                           ; CODE XREF: Player_InitDashKick+1E   j
                rts
; End of function Player_InitDashKick
; Handles dash kick with gravity
Player_DashKickState:                                   ; DATA XREF: ROM:000150A6   o  ; was: sub_15B8C
                jsr     Physics_ExtendedWallCheckWrapper(pc)  ; (pc)
                nop
                addi.l  #$8800,$1C(a5)
                bsr.w   Physics_DescendingTerrainCheckWrapper
                btst    #0,6(a5)
                beq.s   locret_15BB6
                bsr.w   Player_InitSlideState
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
locret_15BB6:                                           ; CODE XREF: Player_DashKickState+18   j
                rts
; End of function Player_DashKickState
; Checks and activates special move from state flags
Player_CheckSpecialMoveActivation:                      ; CODE XREF: Player_HandleJump+1E   p  ; was: sub_15BB8
                                        ; Player_HandleAirState+20   p
                btst    #5,$6A(a5)
                beq.s   locret_15C1E
                btst    #1,$69(a5)
                beq.w   loc_15BF2
                move.b  $69(a5),d0
                andi.b  #$C,d0
                bne.w   loc_15936
                btst    #6,(byte_FF8245).w
                bne.w   loc_15936
                btst    #2,6(a5)
                beq.w   loc_15936
                bsr.w   Player_InitFallingTransition
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
loc_15BF2:                                              ; CODE XREF: Player_CheckSpecialMoveActivation+E   j
                move.w  #8,4(a5)
                move.l  #$FFFA8000,$1C(a5)
                move.w  #$C,$5C(a5)
                move.w  #5,$48(a5)
                clr.w   $4A(a5)
                clr.w   (word_FF8224).w
                clr.w   $52(a5)
                move.b  #$7F,(byte_FF830F).w
locret_15C1E:                                           ; CODE XREF: Player_CheckSpecialMoveActivation+6   j
                                        ; Player_CheckDashInput+6   j
                rts
; End of function Player_CheckSpecialMoveActivation
; Checks controller input for dash attack activation
Player_CheckDashInput:                                  ; CODE XREF: Player_CeilingIdleState+20   p  ; was: sub_15C20
                                        ; Player_HandleCrouchState+1C   p
                btst    #5,$6A(a5)
                beq.s   locret_15C1E
                btst    #0,$69(a5)
                bne.w   Player_InitiateDashAttack
                bra.s   Player_EndDashWithVerticalVelocity
; End of function Player_CheckDashInput
; Initializes player falling state with parameters
Player_InitFallState:                                   ; CODE XREF: Player_HandleJump+10   j  ; was: sub_15C34
                                        ; Player_HandleAirState+16   j
                clr.w   (word_FF8224).w
                clr.w   $52(a5)
loc_15C3C:                                              ; CODE XREF: Player_DamageLandingRecoveryState+18   j
                                        ; Player_HandleDashCancel+5E   j
                bclr    #0,(byte_FF826C).w
                move.w  #6,4(a5)
                bclr    #4,$E(a5)
                move.w  #$C,$5C(a5)
                move.w  #$FFFF,$48(a5)
                clr.w   $4A(a5)
                move.b  #$7F,(byte_FF830F).w
                rts
; End of function Player_InitFallState
; Positions multiple boss sprite parts
