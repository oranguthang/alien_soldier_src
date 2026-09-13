; Handles the airborne recovery phase after the special attack
Player_SpecialMoveRecoveryState:                        ; CODE XREF: Player_HandleSpecialAttack+18   j  ; was: sub_1609A
                                        ; DATA XREF: ROM:000150A8   o
                bset    #0,(byte_FF8244).w
                bset    #6,(byte_FF8244).w
                jsr     Physics_ExtendedWallCheckWrapper(pc)  ; (pc)
                nop
                clr.b   6(a5)
                bsr.w   Physics_DescendingTerrainCheckWrapper
                btst    #0,6(a5)
                bne.w   Player_InitLandingState
                clr.b   6(a5)
                bsr.w   Physics_RisingTerrainCheckWrapper
                btst    #1,6(a5)
                bne.w   Player_InitCeilingLandingState
                bsr.w   Player_CheckRecoveryWeaponSelectInput
                bne.w   Player_SpecialMoveRecoveryState_Return
                btst    #0,(CounterForceTriggerFlag).w
                bne.w   Player_StartAirCounterForce
                btst    #5,$6A(a5)
                beq.s   Player_RenderSpecialMoveRecovery
                tst.b   (PlayerAirDashUsedFlag).w
                bne.s   Player_SpecialMoveRecoveryState_SetFastVerticalVelocity
                btst    #1,$69(a5)
                bne.w   Player_InitiateDashAttack_UseGroundState
Player_SpecialMoveRecoveryState_SetFastVerticalVelocity:  ; CODE XREF: Player_SpecialMoveRecoveryState+54   j  ; was: loc_160FA
                move.l  #$FFF80000,$1C(a5)
                bra.s   Player_InitAirRecovery_Finish
; End of function Player_SpecialMoveRecoveryState
; Sets upward velocity for air recovery
Player_InitAirRecovery:
                move.l  #$FFFD8000,$1C(a5)              ; was: sub_16104
Player_InitAirRecovery_Finish:                          ; CODE XREF: Player_SpecialMoveRecoveryState+68   j  ; was: loc_1610C
                move.w  #$FFE0,$52(a5)
                bra.w   Player_InitFallState_Finish
; End of function Player_InitAirRecovery
; Renders the recovery pose with or without the weapon overlay
Player_RenderSpecialMoveRecovery:                       ; CODE XREF: Player_SpecialMoveRecoveryState+4E   j  ; was: sub_16116
                movea.l #Player_SpecialAttackSecondarySpriteMappingA,a2
                btst    #0,(FrameCounter+1).w
                bne.s   Player_RenderSpecialMoveRecovery_SelectVariant
                movea.l #Player_SpecialAttackSecondarySpriteMappingB,a2
Player_RenderSpecialMoveRecovery_SelectVariant:         ; CODE XREF: Player_RenderSpecialMoveRecovery+C   j  ; was: loc_1612A
                btst    #4,$69(a5)
                bne.w   Player_RenderSpecialMoveRecovery_WithWeapon
                bsr.w   Player_UpdateHorizontalFacing
                movea.l #Player_CommonPrimarySpriteMapping,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                bra.w   Player_BuildSpritePieces
; ---------------------------------------------------------------------------
Player_RenderSpecialMoveRecovery_WithWeapon:            ; CODE XREF: Player_RenderSpecialMoveRecovery+1A   j  ; was: loc_16146
                lea     (Player_AlternateLayoutMuzzleOffsets0).l,a4
                moveq   #0,d5
                moveq   #$FFFFFFFF,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                bra.w   Player_PrepareSpriteRendering_WithTables
; End of function Player_RenderSpecialMoveRecovery
Player_SpecialMoveRecoveryState_Return:                 ; CODE XREF: Player_SpecialMoveRecoveryState+3A   j  ; was: nullsub_40
                rts
; End of function Player_SpecialMoveRecoveryState_Return

; Checks A-button input for weapon selection during special-attack recovery
Player_CheckRecoveryWeaponSelectInput:                  ; CODE XREF: Player_SpecialMoveRecoveryState+36   p  ; was: sub_1615C
                btst    #6,$6A(a5)
                beq.s   Player_CheckRecoveryWeaponSelectInput_NotActivated
                btst    #1,$69(a5)
                beq.s   Player_CheckRecoveryWeaponSelectInput_CheckAvailable
                bsr.w   Player_ToggleShootingModeWithInputMask
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
Player_CheckRecoveryWeaponSelectInput_CheckAvailable:   ; CODE XREF: Player_CheckRecoveryWeaponSelectInput+E   j  ; was: loc_16174
                tst.w   (WeaponStateCooldown).w
                bmi.s   Player_StartRecoveryWeaponSelect
Player_CheckRecoveryWeaponSelectInput_NotActivated:     ; CODE XREF: Player_CheckRecoveryWeaponSelectInput+6   j  ; was: loc_1617A
                moveq   #0,d0
                rts
; End of function Player_CheckRecoveryWeaponSelectInput
; ---------------------------------------------------------------------------
; Starts the recovery-specific weapon-select state
Player_StartRecoveryWeaponSelect:                       ; CODE XREF: Player_CheckRecoveryWeaponSelectInput+1C   j  ; was: loc_1617E
                move.w  (WeaponSlotOffset).w,(WeaponSavedSlotOffset).w
                move.w  #$12,(WeaponStateIndex).w
                move.b  #$7F,(PlayerInputMask).w
                move.w  #0,(WeaponMenuSpawnXOffset).w
                move.w  #$FFEE,(WeaponMenuSpawnYOffset).w
                move.w  #$54,4(a5)                      ; 'T'
                moveq   #1,d0
                rts
; End of function Player_StartRecoveryWeaponSelect
; Holds recovery state 0x54 while the weapon selector is active
Player_RecoveryWeaponSelectState:                       ; DATA XREF: ROM:000150B6   o  ; was: sub_161A6
                bset    #0,(byte_FF8244).w
                bset    #6,(byte_FF8244).w
                jsr     Physics_ExtendedWallCheckWrapper(pc)  ; (pc)
                nop
                clr.b   6(a5)
                bsr.w   Physics_DescendingTerrainCheckWrapper
                btst    #0,6(a5)
                bne.w   Player_InitLandingState
                clr.b   6(a5)
                bsr.w   Physics_RisingTerrainCheckWrapper
                btst    #1,6(a5)
                bne.w   Player_InitCeilingLandingState
                cmpi.w  #$12,(WeaponStateIndex).w
                bpl.s   Player_RecoveryWeaponSelectState_Render
                move.w  #$46,4(a5)                      ; 'F'
                bsr.w   Player_AutoFlipDirection
Player_RecoveryWeaponSelectState_Render:                ; CODE XREF: Player_RecoveryWeaponSelectState+3C   j  ; was: loc_161EE
                movea.l #Player_SpecialAttackSecondarySpriteMappingA,a2
                btst    #0,(FrameCounter+1).w
                bne.s   Player_RecoveryWeaponSelectState_SelectFrame
                movea.l #Player_SpecialAttackSecondarySpriteMappingB,a2
Player_RecoveryWeaponSelectState_SelectFrame:           ; CODE XREF: Player_RecoveryWeaponSelectState+54   j  ; was: loc_16202
                movea.l #Player_CommonPrimarySpriteMapping,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                bra.w   Player_BuildSpritePieces
; End of function Player_RecoveryWeaponSelectState
; Enters the forced-position state and clears player motion
Player_InitForcedPositionState:                         ; CODE XREF: Player_Update+72   p  ; was: sub_16210
                move.b  #$7F,(PlayerInputMask).w
                move.w  #$8000,(PlayerDefeatPhase).w
                move.w  #$32,4(a5)                      ; '2'
                move.b  #$80,$21(a5)
                move.w  #4,$5C(a5)
                clr.w   $48(a5)
                clr.w   $4A(a5)
                clr.w   $52(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                bset    #1,(ForcedPositionFlags).w
                rts
; End of function Player_InitForcedPositionState
; Applies a published forced position until its request or timer expires
Player_HandleForcedPositionState:                       ; DATA XREF: ROM:00015094   o  ; was: sub_1624A
                                        ; ROM:00015096   o
                bset    #3,(byte_FF8244).w
                bclr    #0,(ForcedPositionFlags).w
                bne.s   Player_HandleForcedPosition_ProcessActive
                bra.w   Player_HandleForcedPosition_Finish
; ---------------------------------------------------------------------------
Player_HandleForcedPosition_ProcessActive:              ; CODE XREF: Player_HandleForcedPositionState+C   j  ; was: loc_1625C
                bclr    #2,(ForcedPositionFlags).w
                bne.s   Player_HandleForcedPosition_ApplyPosition
                move.b  $6A(a5),d0
                andi.b  #$2C,d0                         ; ','
                beq.s   Player_HandleForcedPosition_CheckTimer
                addq.w  #1,$4A(a5)
Player_HandleForcedPosition_CheckTimer:                 ; CODE XREF: Player_HandleForcedPositionState+22   j  ; was: loc_16272
                move.w  (ForcedPositionTimer).w,d0
                cmp.w   $4A(a5),d0
                bpl.s   Player_HandleForcedPosition_ApplyPosition
                bclr    #1,(ForcedPositionFlags).w
                bra.w   Player_HandleForcedPosition_Finish
; ---------------------------------------------------------------------------
Player_HandleForcedPosition_ApplyPosition:              ; CODE XREF: Player_HandleForcedPositionState+18   j  ; was: loc_16286
                                        ; Player_HandleForcedPositionState+30   j
                bset    #1,(ForcedPositionFlags).w
                move.w  (ForcedPositionX).w,$10(a5)
                move.w  (ForcedPositionY).w,$14(a5)
                moveq   #$FFFFFFFE,d1
                bra.w   Player_AdvanceAnimationFrame
; ---------------------------------------------------------------------------
Player_HandleForcedPosition_Finish:                     ; CODE XREF: Player_HandleForcedPositionState+E   j  ; was: loc_1629E
                                        ; Player_HandleForcedPositionState+38   j
                move.b  #$30,(ContactDamageCooldown).w  ; '0'
                bra.w   *+4
; End of function Player_HandleForcedPositionState
; Initializes player knockback/damaged state with sound and velocity
Player_InitKnockbackState:                              ; CODE XREF: Player_Update+64   p  ; was: sub_162A8
                                        ; Player_HandleForcedPositionState+5A   j
                move.b  #$7F,(PlayerInputMask).w
                bclr    #4,$E(a5)
                move.w  #$8000,(PlayerDefeatPhase).w
                jsr     (Sys_ClearObjectBlocks17).l
                move.w  #$2A,4(a5)                      ; '*'
                move.w  #$C,$48(a5)
                tst.w   $5E(a5)
                bpl.s   Player_InitKnockbackState_SetAlternateVerticalVelocity
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.s   Player_InitKnockbackState_SetDefaultVelocity
                move.b  #$19,d0
                jsr     (Sound_PlaySFX).l
Player_InitKnockbackState_SetDefaultVelocity:           ; CODE XREF: Player_InitKnockbackState+32   j  ; was: loc_162E6
                move.l  #$FFFEA000,$1C(a5)
                tst.l   (PlayerKnockbackXVel).w
                beq.s   Player_InitKnockbackState_SetFacingVelocity
Player_InitKnockbackState_UseStoredHorizontalVelocity:  ; CODE XREF: Player_InitKnockbackState+80   j  ; was: loc_162F4
                move.l  (PlayerKnockbackXVel).w,$18(a5)
                rts
; ---------------------------------------------------------------------------
Player_InitKnockbackState_SetFacingVelocity:            ; CODE XREF: Player_InitKnockbackState+4A   j  ; was: loc_162FC
                move.l  #$FFFF7000,$18(a5)
                btst    #3,$E(a5)
                bne.s   Player_InitKnockbackState_Return
                neg.l   $18(a5)
Player_InitKnockbackState_Return:                       ; CODE XREF: Player_InitKnockbackState+62   j  ; was: locret_16310
                rts
; ---------------------------------------------------------------------------
Player_InitKnockbackState_SetAlternateVerticalVelocity:  ; CODE XREF: Player_InitKnockbackState+28   j  ; was: loc_16312
                move.b  #$19,d0
                jsr     (Sound_PlaySFX).l
                move.l  #$FFFE8000,$1C(a5)
                tst.w   (PlayerKnockbackXVel).w
                bne.w   Player_InitKnockbackState_UseStoredHorizontalVelocity
                bra.s   Player_SetKnockbackVelocity
; End of function Player_InitKnockbackState
; Sets horizontal knockback velocity
Player_SetHorizontalKnockback:
                bmi.s   Player_SetHorizontalKnockback_Negative  ; was: sub_1632E
                move.l  #$38000,$18(a5)
                rts
; ---------------------------------------------------------------------------
Player_SetHorizontalKnockback_Negative:                 ; CODE XREF: Player_SetHorizontalKnockback   j  ; was: loc_1633A
                move.l  #$FFFC8000,$18(a5)
                rts
; End of function Player_SetHorizontalKnockback
; Sets player horizontal knockback velocity based on facing direction
Player_SetKnockbackVelocity:                            ; CODE XREF: Player_InitKnockbackState+84   j  ; was: sub_16344
                move.l  #$FFFC8000,$18(a5)
                btst    #3,$E(a5)
                bne.s   Player_SetKnockbackVelocity_Return
                neg.l   $18(a5)
Player_SetKnockbackVelocity_Return:                     ; CODE XREF: Player_SetKnockbackVelocity+E   j  ; was: locret_16358
                rts
; End of function Player_SetKnockbackVelocity
; Handles player knockback gravity and terrain contacts
Player_KnockbackState:                                  ; DATA XREF: ROM:0001508C   o  ; was: sub_1635A
                movea.l #Player_KnockbackPrimarySpriteMapping,a1
                movea.l #Player_CommonMovementSecondarySpriteMapping,a2
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFF,d6
                bsr.w   Player_BuildSpritePieces
                subq.w  #1,$48(a5)
                bpl.s   Player_KnockbackState_ApplyPhysics
                bsr.w   Player_ClearKnockbackState
                bsr.w   Player_InitFallState
                move.b  #1,(PlayerAirDashUsedFlag).w
                move.b  #1,(PlayerAirShotUsedFlag).w
                bra.w   Player_HandleFallingState
; ---------------------------------------------------------------------------
Player_KnockbackState_ApplyPhysics:                     ; CODE XREF: Player_KnockbackState+18   j  ; was: loc_1638C
                addi.l  #$6000,$1C(a5)
                bsr.w   Physics_ExtendedWallCheckWrapper
                tst.w   $1C(a5)
                bmi.s   Player_KnockbackState_CheckUpperTerrain
                bsr.w   Physics_DescendingTerrainCheckWrapper
                btst    #0,6(a5)
                beq.s   Player_StateNoOp_Return
                bsr.w   Player_ClearKnockbackState
                bra.w   Player_InitLandingState
; ---------------------------------------------------------------------------
Player_KnockbackState_CheckUpperTerrain:                ; CODE XREF: Player_KnockbackState+42   j  ; was: loc_163B2
                clr.b   6(a5)
                jmp     Physics_RisingTerrainCheckWrapper(pc)  ; (pc)
; End of function Player_KnockbackState
; Empty function that returns
Player_NoOp:
                nop                                     ; was: sub_163BA
Player_StateNoOp_Return:                                ; CODE XREF: Player_KnockbackState+4E   j  ; was: locret_163BC
                rts
; End of function Player_NoOp
; Clears player knockback flag and resets sprite state after hit
Player_ClearKnockbackState:                             ; CODE XREF: Player_KnockbackState+1A   p  ; was: sub_163BE
                                        ; Player_KnockbackState+50   p
                clr.w   (PlayerDefeatPhase).w
                move.w  #$CD00,2(a5)
                move.b  #$81,$21(a5)
                rts
; End of function Player_ClearKnockbackState
Player_UnusedStateReturn:                               ; was: nullsub_41
                rts
; End of function Player_UnusedStateReturn

; Initializes the idle state used while attached to upper terrain
Player_InitCeilingIdleState:                            ; CODE XREF: Player_CeilingCounterForceState+1A   j  ; was: sub_163D2
                                        ; Player_CeilingDashState+66   j
                move.b  #$7F,(PlayerInputMask).w
                bclr    #0,(CounterForceTriggerFlag).w
                clr.w   (PlayerAirMoveUsedFlags).w
                move.w  #$18,4(a5)
                clr.l   $18(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_InitCeilingIdleState
Player_CeilingIdleState_Return:                         ; CODE XREF: Player_CeilingIdleState+1E   j  ; was: nullsub_42
                                        ; Player_CeilingIdleState+24   j
                rts
; End of function Player_CeilingIdleState_Return

; Handles idle input while the player remains attached to upper terrain
Player_CeilingIdleState:                                ; DATA XREF: ROM:0001507A   o  ; was: sub_16402
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                jsr     Physics_UpperTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Effect_SpawnParticle
                bsr.w   Player_CheckCeilingWeaponSelectInput
                bne.s   Player_CeilingIdleState_Return
                bsr.w   Player_CheckDashInput
                bne.s   Player_CeilingIdleState_Return
                btst    #0,(CounterForceTriggerFlag).w
                bne.w   Player_StartCeilingCounterForce
                btst    #4,$69(a5)
                beq.s   Player_CeilingIdleState_CheckDashInput
                tst.w   (ShootingMode).w
                bne.s   Player_CeilingIdleState_Render
Player_CeilingIdleState_CheckDashInput:                 ; CODE XREF: Player_CeilingIdleState+36   j  ; was: loc_16440
                btst    #0,$69(a5)
                bne.w   Player_InitDashState
                btst    #2,$69(a5)
                bne.w   Player_InitWallKickState
                btst    #3,$69(a5)
                bne.w   Player_InitWallKickState
Player_CeilingIdleState_Render:                         ; CODE XREF: Player_CeilingIdleState+3C   j  ; was: loc_1645E
                btst    #4,$69(a5)
                beq.w   Player_RenderIdleFrame
                bra.w   Player_UpdateDashSprite
; ---------------------------------------------------------------------------
; Starts ceiling Counter Force recoil, effect, and animation timing
Player_StartCeilingCounterForce:                        ; CODE XREF: Player_CeilingIdleState+2C   j  ; was: loc_1646C
                                        ; Player_CeilingDashState+3E   j
                bsr.w   Player_SpawnCounterForceEffect
                move.b  #$7F,(PlayerInputMask).w
                jsr     (Sys_ClearObjectBlocks16).l
                move.w  #$3E,4(a5)                      ; '>'
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   Player_StartCeilingCounterForce_Return
                neg.l   $18(a5)
Player_StartCeilingCounterForce_Return:                 ; CODE XREF: Player_CeilingIdleState+A6   j  ; was: locret_164AE
                rts
; End of function Player_StartCeilingCounterForce
; Updates the ceiling Counter Force recoil and animation
Player_CeilingCounterForceState:                        ; DATA XREF: ROM:000150A0   o  ; was: sub_164B0
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                jsr     Physics_UpperTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_SetAirCounterForceState
                subq.w  #1,$4A(a5)
                bmi.w   Player_InitCeilingIdleState
                move.l  #$2000,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                bra.w   Player_UpdateCounterForceAnimation
; End of function Player_CeilingCounterForceState
