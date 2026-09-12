Player_UpdateWeaponCharge:
                btst    #5,$6A(a5)                      ; was: sub_164DC
                beq.s   Player_UpdateWeaponCharge_Return
                btst    #0,$69(a5)
                beq.s   Player_UpdateWeaponCharge_Return
                move.w  (PlayerHealth).w,d0
                sub.w   (PlayerMaxHealth).w,d0
                move.w  d0,(word_FF8304).w
                moveq   #1,d0
Player_UpdateWeaponCharge_Return:                       ; CODE XREF: Player_UpdateWeaponCharge+6   j  ; was: locret_164FA
                                        ; Player_UpdateWeaponCharge+E   j
                rts
; End of function Player_UpdateWeaponCharge
; Initializes player dash state with animation and counter setup
Player_InitDashState:                                   ; CODE XREF: Player_CeilingIdleState+44   j  ; was: sub_164FC
                                        ; Player_HandleCrouchState+32   j
                move.w  #2,$48(a5)
; Initializes dash animation with timer and direction flip
Player_InitDashAnimation:                               ; CODE XREF: Player_DashAttackState+88   j  ; was: loc_16502
                                        ; Player_HandleSlideState+38   j
                move.w  #$22,4(a5)                      ; '"'
                bset    #4,$E(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$14,$5C(a5)
                move.b  #$7F,(PlayerInputMask).w
                bra.w   Player_AutoFlipDirection
; End of function Player_InitDashState
Player_CeilingDashState_Return:                         ; CODE XREF: Player_CeilingDashState+20   j  ; was: nullsub_43
                rts
; End of function Player_CeilingDashState_Return

; Handles dash movement while the player remains attached to upper terrain
Player_CeilingDashState:                                ; DATA XREF: ROM:00015084   o  ; was: sub_1652C
                bset    #1,(byte_FF8244).w
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                jsr     Physics_UpperTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Player_CheckCounterInput
                bne.s   Player_CeilingDashState_Return
                btst    #5,$6A(a5)
                beq.s   Player_CeilingDashState_UpdateMovement
                btst    #0,$69(a5)
                beq.w   Player_EndDashState
                bra.w   Player_InitiateDashAttack
; ---------------------------------------------------------------------------
Player_CeilingDashState_UpdateMovement:                 ; CODE XREF: Player_CeilingDashState+28   j  ; was: loc_16564
                btst    #0,(byte_FF826C).w
                bne.w   Player_InitCeilingDamageKnockback
                bsr.w   Player_DecelerateHorizontalVelocityFast
                subq.w  #1,$48(a5)
                bpl.s   Player_CeilingDashState_Render
                move.w  #$FFFF,$48(a5)
                btst    #4,$69(a5)
                beq.s   Player_CeilingDashState_CheckDashInput
                tst.w   (ShootingMode).w
                bne.s   Player_CeilingDashState_Render
Player_CeilingDashState_CheckDashInput:                 ; CODE XREF: Player_CeilingDashState+58   j  ; was: loc_1658C
                btst    #0,$69(a5)
                beq.w   Player_InitCeilingIdleState
; Selects the armed or unarmed ceiling-dash rendering path
Player_CeilingDashState_Render:                         ; CODE XREF: Player_CeilingDashState+4A   j  ; was: loc_16596
                                        ; Player_CeilingDashState+5E   j
                btst    #4,$69(a5)
                beq.w   Player_RenderAirborneFrame
                bra.w   Player_RenderWithWeapon
; End of function Player_CeilingDashState
; Initializes player crouch state
Player_InitCrouchState:                                 ; CODE XREF: Player_CeilingLandingState+68   j  ; was: sub_165A4
                                        ; Player_InitWallKickState+3A   j
                move.b  #$7F,(PlayerInputMask).w
                clr.w   (word_FF8224).w
                move.w  #$1E,4(a5)
                clr.w   $48(a5)
                move.w  #$10,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_InitCrouchState
; Main crouch state handler with input checks
Player_HandleCrouchState:                               ; DATA XREF: ROM:00015080   o  ; was: sub_165C2
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                jsr     Physics_UpperTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Player_CheckCounterInput
                bne.s   Player_CeilingState_Return
                bsr.w   Player_CheckDashInput
                bne.s   Player_CeilingState_Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_InitCeilingDamageKnockback
                btst    #0,$69(a5)
                bne.w   Player_InitDashState
                bsr.w   Player_DecelerateHorizontalVelocityFast
                move.l  $18(a5),d0
                bne.s   Player_RenderCrouchMovement
                btst    #2,$69(a5)
                bne.w   Player_InitWallKickFromMovement
                btst    #3,$69(a5)
                bne.w   Player_InitWallKickFromMovement
                bra.w   Player_InitCeilingIdleState
; ---------------------------------------------------------------------------
; Selects the crouch-movement rendering path
Player_RenderCrouchMovement:                            ; CODE XREF: Player_HandleCrouchState+3E   j  ; was: loc_1661A
                btst    #4,$69(a5)
                bne.w   Player_RenderGroundedFrame
                movea.l #Player_CommonPrimarySpriteMapping,a1
                movea.l #Player_CommonMovementSecondarySpriteMapping,a2
                moveq   #0,d5
                moveq   #6,d6
                bra.w   Player_BuildSpritePieces
; ---------------------------------------------------------------------------
Player_CeilingState_Return:                             ; CODE XREF: Player_HandleCrouchState+1A   j  ; was: locret_16638
                                        ; Player_HandleCrouchState+20   j
                rts
; End of function Player_HandleCrouchState
; Initializes the landing state for contact with upper terrain
Player_InitCeilingLandingState:                         ; CODE XREF: Player_HandleFallingState+66   j  ; was: sub_1663A
                                        ; Player_HandleBounceState+3A   j
                move.b  #$7F,(PlayerInputMask).w
                clr.w   (word_FF8224).w
                move.w  #$26,4(a5)                      ; '&'
                bset    #4,$E(a5)
                move.w  #2,$48(a5)
                move.w  #6,$4A(a5)
                move.w  #$14,$5C(a5)
                move.b  #$B1,d0
                jsr     (Sound_PlaySFX).l
                bra.w   Player_AutoFlipDirection
; End of function Player_InitCeilingLandingState
; Handles the landing timer while attached to upper terrain
Player_CeilingLandingState:                             ; DATA XREF: ROM:00015088   o  ; was: sub_16670
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                jsr     Physics_UpperTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Player_CheckCounterInput
                bne.s   Player_CeilingState_Return
                bsr.w   Player_CheckDashInput
                bne.s   Player_CeilingState_Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_InitCeilingDamageKnockback
                move.l  #$4000,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                subq.w  #1,$4A(a5)
                subq.w  #1,$48(a5)
                bpl.s   Player_CeilingLandingState_Render
                btst    #0,$69(a5)
                beq.s   Player_CeilingLandingState_CheckMovementInput
                bsr.w   Player_InitDashState
                move.w  #$FFFF,$48(a5)
                bra.s   Player_CeilingLandingState_Render
; ---------------------------------------------------------------------------
Player_CeilingLandingState_CheckMovementInput:          ; CODE XREF: Player_CeilingLandingState+46   j  ; was: loc_166C4
                btst    #2,$69(a5)
                bne.w   Player_InitWallKickFromMovement
                btst    #3,$69(a5)
                bne.w   Player_InitWallKickFromMovement
                bra.w   Player_InitCrouchState
; ---------------------------------------------------------------------------
Player_CeilingLandingState_Render:                      ; CODE XREF: Player_CeilingLandingState+3E   j  ; was: loc_166DC
                                        ; Player_CeilingLandingState+52   j
                btst    #4,$69(a5)
                beq.w   Player_RenderAirborneFrame
                bra.w   Player_RenderWithWeapon
; End of function Player_CeilingLandingState
; Checks controller input for counter/parry activation
Player_CheckCounterInput:                               ; CODE XREF: Player_CeilingIdleState+1A   p  ; was: sub_166EA
                                        ; Player_CeilingDashState+1C   p
                btst    #6,$6A(a5)
                beq.s   Player_CheckCounterInput_NotActivated
                btst    #0,$69(a5)
                bne.w   Player_ToggleAlternateMode
                tst.w   (WeaponStateCooldown).w
                bmi.s   Player_CheckCounterInput_Activate
Player_CheckCounterInput_NotActivated:                  ; CODE XREF: Player_CheckCounterInput+6   j  ; was: loc_16702
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
Player_CheckCounterInput_Activate:                      ; CODE XREF: Player_CheckCounterInput+16   j  ; was: loc_16706
                move.w  (WeaponSlotOffset).w,(WeaponSavedSlotOffset).w
                move.w  #$12,(WeaponStateIndex).w
                move.b  #$7F,(PlayerInputMask).w
                move.w  #0,(word_FF8032).w
                move.w  #0,(word_FF8034).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$20,4(a5)                      ; ' '
                move.w  #$10,$5C(a5)
                btst    #0,$69(a5)
                beq.s   Player_CheckCounterInput_ReturnActivated
                move.w  #$14,$5C(a5)
Player_CheckCounterInput_ReturnActivated:               ; CODE XREF: Player_CheckCounterInput+54   j  ; was: loc_16746
                moveq   #1,d0
                rts
; End of function Player_CheckCounterInput
; Handles the counter state while upper-terrain contact remains valid
Player_CounterState:                                    ; DATA XREF: ROM:00015082   o  ; was: sub_1674A
                cmpi.w  #$12,(WeaponStateIndex).w
                bmi.w   Player_InitCeilingIdleState
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                jsr     Physics_UpperTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bra.w   Player_RenderIdleFrame
; End of function Player_CounterState
; Toggles the shared alternate-mode flag and plays its sound
Player_ToggleAlternateMode:                             ; CODE XREF: Player_CheckCounterInput+E   j  ; was: sub_1676E
                eori.w  #2,(ShootingMode).w
                move.b  #$A3,d0
                jsr     (Sound_PlaySFX).l
                moveq   #0,d0
                rts
; End of function Player_ToggleAlternateMode
; Initializes wall kick state from button input
Player_InitWallKickState:                               ; CODE XREF: Player_CeilingIdleState+4E   j  ; was: sub_16782
                                        ; Player_CeilingIdleState+58   j
                btst    #4,$69(a5)
                beq.s   Player_InitWallKickAnimation
                tst.w   (ShootingMode).w
                beq.s   Player_InitWallKickState_CheckFacing
                rts
; ---------------------------------------------------------------------------
Player_InitWallKickFromMovement:                        ; CODE XREF: Player_HandleCrouchState+46   j  ; was: loc_16792
                                        ; Player_HandleCrouchState+50   j
                btst    #4,$69(a5)
                beq.s   Player_InitWallKickAnimation
                tst.w   (ShootingMode).w
                bne.w   Player_InitCeilingIdleState
Player_InitWallKickState_CheckFacing:                   ; CODE XREF: Player_InitWallKickState+C   j  ; was: loc_167A2
                btst    #3,$69(a5)
                beq.s   Player_InitWallKickState_CheckLeft
                btst    #3,$E(a5)
                bne.w   Player_InitCeilingAirControlState
                bra.s   Player_InitWallKickAnimation
; ---------------------------------------------------------------------------
Player_InitWallKickState_CheckLeft:                     ; CODE XREF: Player_InitWallKickState+26   j  ; was: loc_167B6
                btst    #2,$69(a5)
                beq.w   Player_InitCrouchState
                btst    #3,$E(a5)
                beq.w   Player_InitCeilingAirControlState
; Initializes wall kick animation with timer and direction flip
Player_InitWallKickAnimation:                           ; CODE XREF: Player_InitWallKickState+6   j  ; was: loc_167CA
                                        ; Player_InitWallKickState+16   j
                move.b  #$7F,(PlayerInputMask).w
                move.w  #$1A,4(a5)
                move.w  #4,$48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_InitWallKickState
Player_CeilingMovementState_Return:                     ; CODE XREF: Player_CeilingMovementState+1A   j  ; was: nullsub_44
                                        ; Player_CeilingMovementState+20   j
                rts
; End of function Player_CeilingMovementState_Return

; Handles directional movement while the player is attached to upper terrain
Player_CeilingMovementState:                            ; DATA XREF: ROM:0001507C   o  ; was: sub_167EE
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                jsr     Physics_UpperTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Player_CheckCounterInput
                bne.s   Player_CeilingMovementState_Return
                bsr.w   Player_CheckDashInput
                bne.s   Player_CeilingMovementState_Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_InitCeilingDamageKnockback
                btst    #0,$69(a5)
                bne.w   Player_InitDashState
                btst    #4,$69(a5)
                beq.s   Player_CeilingMovementState_CheckHorizontalInput
                tst.w   (ShootingMode).w
                bne.w   Player_InitCrouchState
Player_CeilingMovementState_CheckHorizontalInput:       ; CODE XREF: Player_CeilingMovementState+3C   j  ; was: loc_16834
                btst    #2,$69(a5)
                bne.s   Player_CeilingMovementState_Accelerate
                btst    #3,$69(a5)
                beq.w   Player_InitCrouchState
Player_CeilingMovementState_Accelerate:                 ; CODE XREF: Player_CeilingMovementState+4C   j  ; was: loc_16846
                bsr.w   Physics_AccelerateHorizontalByFacing
                btst    #4,$69(a5)
                beq.w   Player_RenderDirectionalMovement
                btst    #3,$69(a5)
                beq.s   Player_CeilingMovementState_CheckRightFacing
                btst    #3,$E(a5)
                beq.w   Player_InitCeilingAirControlState
                bra.w   Player_RenderDashSprite
; ---------------------------------------------------------------------------
Player_CeilingMovementState_CheckRightFacing:           ; CODE XREF: Player_CeilingMovementState+6C   j  ; was: loc_1686A
                btst    #3,$E(a5)
                bne.w   Player_InitCeilingAirControlState
                bra.w   Player_RenderDashSprite
; ---------------------------------------------------------------------------
Player_InitCeilingAirControlState:                      ; CODE XREF: Player_InitWallKickState+2E   j  ; was: loc_16878
                                        ; Player_InitWallKickState+44   j
                move.w  #$1C,4(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
Player_CeilingAirControlState_Return:                   ; CODE XREF: Player_CeilingAirControlState+1A   j  ; was: locret_1688E
                                        ; Player_CeilingAirControlState+20   j
                rts
; End of function Player_CeilingMovementState
; Handles armed movement while the player remains attached to upper terrain
Player_CeilingAirControlState:                          ; DATA XREF: ROM:0001507E   o  ; was: sub_16890
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                jsr     Physics_UpperTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Player_CheckCounterInput
                bne.s   Player_CeilingAirControlState_Return
                bsr.w   Player_CheckDashInput
                bne.s   Player_CeilingAirControlState_Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_InitCeilingDamageKnockback
                btst    #0,$69(a5)
                bne.w   Player_InitDashState
                btst    #4,$69(a5)
                beq.w   Player_InitWallKickAnimation
                bsr.w   Player_RenderWeaponSprite
                btst    #2,$69(a5)
                beq.s   Player_CeilingAirControlState_CheckRightFacing
                btst    #3,$E(a5)
                beq.w   Player_InitWallKickAnimation
                bra.w   Physics_AccelerateHorizontalNegative
; ---------------------------------------------------------------------------
Player_CeilingAirControlState_CheckRightFacing:         ; CODE XREF: Player_CeilingAirControlState+4A   j  ; was: loc_168EA
                btst    #3,$69(a5)
                beq.w   Player_InitCrouchState
                btst    #3,$E(a5)
                bne.w   Player_InitWallKickAnimation
                bra.w   Physics_AccelerateHorizontalPositive
; End of function Player_CeilingAirControlState
; Updates aim direction from D-pad
Player_UpdateAimDirection:                              ; DATA XREF: ROM:000150AA   o  ; was: sub_16902
                bset    #4,$E(a5)
                btst    #2,(ControllerHeldState).w
                beq.s   Player_UpdateAimDirection_CheckRight
                bclr    #3,$E(a5)
                rts
; ---------------------------------------------------------------------------
Player_UpdateAimDirection_CheckRight:                   ; CODE XREF: Player_UpdateAimDirection+C   j  ; was: loc_16918
                btst    #3,(ControllerHeldState).w
                beq.s   Player_UpdateAimDirection_Return
                bset    #3,$E(a5)
Player_UpdateAimDirection_Return:                       ; CODE XREF: Player_UpdateAimDirection+1C   j  ; was: locret_16926
                rts
; End of function Player_UpdateAimDirection
; Attributes: thunk
; State-table thunk returning the player to upper-terrain idle
Player_ReturnToCeilingIdleState:                        ; DATA XREF: ROM:000150AC   o  ; was: sub_16928
                bra.w   Player_InitCeilingIdleState
; End of function Player_ReturnToCeilingIdleState
; Handles jump apex for fall transition
Player_JumpApexState:                                   ; DATA XREF: ROM:000150AE   o  ; was: sub_1692C
                addi.l  #$8800,$1C(a5)
                bpl.w   Player_InitFallState
                bclr    #4,$E(a5)
                bra.w   Player_RenderAirborneFrame_UseAnimatedOffsets
; End of function Player_JumpApexState
; Player dash effect during teleport
Player_TeleportDash:                                    ; DATA XREF: ROM:000150B2   o  ; was: sub_16942
                clr.w   (word_FF80E6).w
                move.b  #$70,(PlayerInputMask).w        ; 'p'
                bset    #0,(byte_FF8245).w
                move.w  #$CD00,2(a5)
                addq.w  #2,4(a5)
                clr.w   $48(a5)
                jsr     (Sys_ClearObjectBlocks17).l
                move.w  #$78,$10(a5)                    ; 'x'
                move.w  #$100,$14(a5)
                move.l  #$41000,$18(a5)
                move.l  #$18000,$1C(a5)
                bset    #3,$E(a5)
                bclr    #4,$E(a5)
                movea.w #(word_FFC5C0-M68K_RAM),a0
                move.w  #$230,(a0)
                move.b  #$54,$21(a0)                    ; 'T'
                move.w  #$4000,2(a0)
                move.l  #Player_TeleportDashProjectileSpriteMapping,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                eori.w  #$1000,$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  #$E0,d0
                jsr     (Sound_PlaySFX).l
                move.l  #Player_PhoenixAndTeleportDashSpriteMapping,8(a5)
; Applies velocity during player teleport dash
Player_TeleportDash_ApplyVelocity:                      ; DATA XREF: ROM:000150B4   o  ; was: loc_169E0
                tst.w   $48(a5)
                bne.w   Player_TeleportDash_Finish
                subi.l  #$620,$1C(a5)
                subi.l  #$C00,$18(a5)
                bset    #6,$21(a5)
                bset    #4,$23(a5)
                bset    #4,(byte_FF8244).w
                bra.w   Effect_CreateDashTrail
; ---------------------------------------------------------------------------
Player_TeleportDash_Finish:                             ; CODE XREF: Player_TeleportDash+A2   j  ; was: loc_16A0E
                bclr    #6,$21(a5)
                bclr    #4,$23(a5)
                jsr     (Sys_ClearObjectBlocks17).l
                bclr    #0,(byte_FF8245).w
                move.w  #$FFE0,$52(a5)
                move.l  #$68000,$18(a5)
                move.w  #$FFFF,$1C(a5)
                bra.w   Player_InitFallState_Finish
; End of function Player_TeleportDash
; Advances the common player animation state by four
Player_UpdateAnimStatePlus4:                            ; DATA XREF: ROM:000150BA   o  ; was: sub_16A3E
                moveq   #4,d1
                bra.w   Player_UpdateAnimationState
; End of function Player_UpdateAnimStatePlus4
; Updates animation state with -4 offset
Player_UpdateAnimStateMinus4:                           ; DATA XREF: ROM:000150BC   o  ; was: sub_16A44
                moveq   #$FFFFFFFC,d1
                bra.w   Player_UpdateAnimationState
; End of function Player_UpdateAnimStateMinus4
; Initializes the return half of the teleport-dash sequence
Player_InitTeleportDashReturnState:                     ; DATA XREF: ROM:000150BE   o  ; was: sub_16A4A
                addq.w  #2,4(a5)
                move.b  #$70,(PlayerInputMask).w        ; 'p'
                bset    #0,(byte_FF8245).w
                move.w  #$CD00,2(a5)
                jsr     (Sys_ClearObjectBlocks17).l
                move.w  #$120,$10(a5)
                move.w  #$100,$14(a5)
                bset    #3,$E(a5)
                bclr    #4,$E(a5)
                move.l  #Player_PhoenixAndTeleportDashSpriteMapping,8(a5)
; Alternates sprite frames during the teleport-dash return state
Player_TeleportDashReturnState:                         ; DATA XREF: ROM:000150C0   o  ; was: loc_16A86
                bset    #4,$23(a5)
                move.l  #Player_TeleportDashTrailSpriteMapping,8(a5)
                btst    #0,(FrameCounter+1).w
                bne.w   Player_TeleportDashReturnState_Return
                move.l  #Player_PhoenixAndTeleportDashSpriteMapping,8(a5)
Player_TeleportDashReturnState_Return:                  ; CODE XREF: Player_InitTeleportDashReturnState+50   j  ; was: locret_16AA6
                rts
; End of function Player_InitTeleportDashReturnState
; Initializes player invulnerability state with timer and sound effect
Player_InitInvulnerabilityState:                        ; CODE XREF: Player_Update+34   j  ; was: sub_16AA8
                                        ; Player_Update+3C   j
                move.w  #2,(word_FF80E6).w
                move.w  #$100,2(a5)
                clr.b   $21(a5)
                move.b  #$10,$23(a5)
                move.w  #$30,$48(a5)                    ; '0'
                move.b  #$1F,d0
                jmp     (Sound_PlaySFX).l
; End of function Player_InitInvulnerabilityState
; Manages invulnerability timer countdown and triggers palette fade effects when expired
Player_HandleInvulnerabilityTimer:                      ; CODE XREF: Player_Update+2C   j  ; was: sub_16ACE
                bclr    #7,2(a5)
                tst.w   $48(a5)
                bmi.s   Player_HandleInvulnerabilityTimer_Return
                subq.w  #1,$48(a5)
                bne.s   Player_HandleInvulnerabilityTimer_SpawnSpark
                move.w  #1,(word_FF8230).w
                move.w  #$8002,(PaletteFadeMode).w
                clr.w   (PaletteFadeColorOffset).w
                move.w  #$E000,(PaletteFadeMaskStatus).w
                move.b  #$80,(byte_FFF705).w
Player_HandleInvulnerabilityTimer_SpawnSpark:           ; CODE XREF: Player_HandleInvulnerabilityTimer+10   j  ; was: loc_16AFC
                jmp     Effect_SpawnPlayerDeathSpark
; ---------------------------------------------------------------------------
Player_HandleInvulnerabilityTimer_Return:               ; CODE XREF: Player_HandleInvulnerabilityTimer+A   j  ; was: locret_16B02
                rts
; End of function Player_HandleInvulnerabilityTimer
