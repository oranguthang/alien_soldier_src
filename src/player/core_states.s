Player_InitializeStats:                                 ; CODE XREF: Stage_InitializeXiTigerState+3A   j  ; was: sub_14F06
                                        ; Sys_InitStageState+3A   j
                lea     (word_FFA400).w,a5
                move.b  #$7F,(PlayerInputMask).w
                move.w  (dword_FFA900).w,(word_FFA928).w
                move.w  (dword_FFA904).w,(word_FFA92C).w
                move.w  #8,(a5)
                move.w  #$4D00,2(a5)
                clr.w   4(a5)
                move.w  #$4DC0,$E(a5)
                move.w  #$B800,$DA(a5)
                move.b  #8,$20(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$81,$21(a5)
                move.b  #$10,$23(a5)
                move.l  #$EC24F60A,$28(a5)
                move.w  #$78,(word_FF8304).w            ; 'x'
                clr.b   $6B(a5)
                clr.w   $9E(a5)
                move.w  #$40,$5E(a5)                    ; '@'
                move.l  #$74000,(dword_FFA938).w
                move.l  #$74000,(dword_FFA93C).w
                jmp     Weapon_AdvanceCurrentState
; End of function Player_InitializeStats
; Clears the player's object identifier and display flags
Player_ClearObjectHeader:                               ; CODE XREF: Player_Update+A   j  ; was: sub_14F82
                clr.w   (a5)
                clr.w   2(a5)
                rts
; End of function Player_ClearObjectHeader
; Sets the player's display-enable bit when gameplay permits rendering
Player_SetDisplayFlag:                                  ; CODE XREF: Player_Update+12   j  ; was: sub_14F8A
                tst.w   (FrameFreezeTimer).w
                bmi.s   Player_Update_Return
                bset    #7,2(a5)
; Shared no-op player state and update return
Player_Update_Return:                                   ; CODE XREF: Player_SetDisplayFlag+4   j  ; was: locret_14F96
                                        ; DATA XREF: ROM:0001508E   o
                rts
; End of function Player_SetDisplayFlag
; Main player update routine
Player_Update:                                          ; CODE XREF: Sys_GameplayMainLoop:Sys_GameplayMainLoop_UpdatePlayer   p  ; was: sub_14F98
                                        ; sub_1EE3C   p
                movea.w #(word_FFA400-M68K_RAM),a5
                btst    #1,(PlayerModeFlags).w
                bne.w   Player_ClearObjectHeader
                tst.b   (FrameControlFlags).w
                bmi.s   Player_SetDisplayFlag
                jsr     (Player_UpdateScriptedInput).l
                bsr.w   Input_ReadPlayerInput
                clr.b   (byte_FF8244).w
                clr.w   6(a5)
                tst.w   (word_FF80E6).w
                beq.s   Player_Update_CheckGameplayReady
                bpl.w   Player_HandleInvulnerabilityTimer
Player_Update_CheckGameplayReady:                       ; CODE XREF: Player_Update+2A   j  ; was: loc_14FC8
                tst.w   (StageTimeRemaining).w
                beq.w   Player_InitInvulnerabilityState
                tst.w   (PlayerHealth).w
                beq.w   Player_InitInvulnerabilityState
                btst    #0,(PlayerModeFlags).w
                bne.w   Player_UpdateSevenForcesBattle
                btst    #2,(PlayerModeFlags).w
                bne.w   Player_UpdateSevenForcesBattleVisible
                bsr.w   Gfx_LoadPlayerPaletteData
                bsr.w   Input_ProcessDirectionInput
                bclr    #6,$22(a5)
                beq.s   Player_Update_CheckCutsceneTrigger
                bsr.w   Player_InitKnockbackState
                bra.s   Player_UpdateCoreAttributes
; ---------------------------------------------------------------------------
Player_Update_CheckCutsceneTrigger:                     ; CODE XREF: Player_Update+62   j  ; was: loc_15002
                bclr    #1,$22(a5)
                beq.s   Player_Update_CheckFallBoundary
                bsr.w   Player_InitCutsceneState
                bra.s   Player_UpdateCoreAttributes
; ---------------------------------------------------------------------------
Player_Update_CheckFallBoundary:                        ; CODE XREF: Player_Update+70   j  ; was: loc_15010
                cmpi.w  #$36,4(a5)                      ; '6'
                beq.s   Player_Update_RunState
                tst.w   $1C(a5)
                bmi.s   Player_Update_RunState
                btst    #0,(byte_FF8245).w
                bne.s   Player_Update_RunState
                cmpi.w  #$171,$14(a5)
                bpl.w   Player_HandleDeathSequence
Player_Update_RunState:                                 ; CODE XREF: Player_Update+7E   j  ; was: loc_15030
                                        ; Player_Update+84   j
                bsr.w   Player_UpdateWeaponSwitchTimer
                bsr.w   Player_UpdateState
; Updates core player attributes including direction invulnerability hitbox and center position
Player_UpdateCoreAttributes:                            ; CODE XREF: Player_Update+68   j  ; was: loc_15038
                                        ; Player_Update+76   j
                bsr.w   Player_UpdateDirectionBit
                move.b  $69(a5),$6B(a5)
                bsr.w   Player_UpdateInvulnerabilityTimer
                bsr.w   Player_SetHitbox
                clr.b   (byte_FF8311).w
                bra.w   Player_CalculateCenterPosition
; End of function Player_Update
; Updates player state machine
Player_UpdateState:                                     ; CODE XREF: Player_Update+9C   p  ; was: sub_15052
                move.w  4(a5),d0
                movea.w Player_StateHandlerOffsets(pc,d0.w),a0
                adda.l  #Player_HandleDeathSequence,a0
                jmp     (a0)
; End of function Player_UpdateState
; ---------------------------------------------------------------------------
Player_StateHandlerOffsets: dc.w    Player_HandleJump-Player_HandleDeathSequence  ; was: off_15062
                                        ; DATA XREF: Player_UpdateState+4   r
                dc.w    Player_GroundedMovementState-Player_HandleDeathSequence
                dc.w    Player_GroundWeaponState-Player_HandleDeathSequence
                dc.w    Player_HandleFallingState-Player_HandleDeathSequence
                dc.w    Player_HandleFallingState-Player_HandleDeathSequence
                dc.w    Player_HandleAirMovement-Player_HandleDeathSequence
                dc.w    Player_HandleGroundedState-Player_HandleDeathSequence
                dc.w    Player_HandleAirState-Player_HandleDeathSequence
                dc.w    Player_DashAttackState-Player_HandleDeathSequence
                dc.w    Player_HandleBounceState-Player_HandleDeathSequence
                dc.w    Player_HandleFallingState-Player_HandleDeathSequence
                dc.w    Player_HandleLandingState-Player_HandleDeathSequence
                dc.w    Player_CeilingIdleState-Player_HandleDeathSequence
                dc.w    Player_CeilingMovementState-Player_HandleDeathSequence
                dc.w    Player_CeilingAirControlState-Player_HandleDeathSequence
                dc.w    Player_HandleCrouchState-Player_HandleDeathSequence
                dc.w    Player_CounterState-Player_HandleDeathSequence
                dc.w    Player_CeilingDashState-Player_HandleDeathSequence
                dc.w    Player_DashAttackState-Player_HandleDeathSequence
                dc.w    Player_CeilingLandingState-Player_HandleDeathSequence
                dc.w    Player_HandleFallingState-Player_HandleDeathSequence
                dc.w    Player_KnockbackState-Player_HandleDeathSequence
                dc.w    Player_Update_Return-Player_HandleDeathSequence
                dc.w    Player_Update_Return-Player_HandleDeathSequence
                dc.w    Player_Update_Return-Player_HandleDeathSequence
                dc.w    Player_HandleCutsceneControl-Player_HandleDeathSequence
                dc.w    Player_HandleCutsceneControl-Player_HandleDeathSequence
                dc.w    Player_HandleDeathSequence_SetFlags-Player_HandleDeathSequence
                dc.w    Player_HandleRespawnGravity-Player_HandleDeathSequence
                dc.w    Player_GroundedDamageState-Player_HandleDeathSequence
                dc.w    Player_AirborneDamageState-Player_HandleDeathSequence
                dc.w    Player_CeilingDamageState-Player_HandleDeathSequence
                dc.w    Player_HandleSlideState-Player_HandleDeathSequence
                dc.w    Player_HandleSlideState-Player_HandleDeathSequence
                dc.w    Player_DashKickState-Player_HandleDeathSequence
                dc.w    Player_SpecialMoveRecoveryState-Player_HandleDeathSequence
                dc.w    Player_UpdateAimDirection-Player_HandleDeathSequence
                dc.w    Player_ReturnToCeilingIdleState-Player_HandleDeathSequence
                dc.w    Player_JumpApexState-Player_HandleDeathSequence
                dc.w    Player_HandleSpecialAttack-Player_HandleDeathSequence
                dc.w    Player_TeleportDash-Player_HandleDeathSequence
                dc.w    Player_TeleportDash_ApplyVelocity-Player_HandleDeathSequence
                dc.w    Player_AlternateSpecialState-Player_HandleDeathSequence
                dc.w    Player_PhoenixAttackUpdate-Player_HandleDeathSequence
                dc.w    Player_UpdateAnimStatePlus4-Player_HandleDeathSequence
                dc.w    Player_UpdateAnimStateMinus4-Player_HandleDeathSequence
                dc.w    Player_InitTeleportDashReturnState-Player_HandleDeathSequence
                dc.w    Player_TeleportDashReturnState-Player_HandleDeathSequence

; Handles player death sequence with knockback and respawn countdown
Player_HandleDeathSequence:                             ; CODE XREF: Player_Update+94   j  ; was: sub_150C2
                                        ; DATA XREF: Player_UpdateState+8   o
                move.b  #$2B,d0                         ; '+'
                jsr     (Sound_PlaySFX).l
                move.b  #$73,(PlayerInputMask).w        ; 's'
                move.w  #$8000,(word_FF80E6).w
                jsr     (Sys_ClearObjectBlocks17).l
                move.b  #1,(word_FF8224).w
                move.b  #1,(word_FF8224+1).w
                move.w  #$36,4(a5)                      ; '6'
                move.w  #$C100,2(a5)
                bclr    #4,$E(a5)
                move.b  $E(a5),$4C(a5)
                move.b  $20(a5),$4D(a5)
                bset    #3,$E(a5)
                bset    #7,$E(a5)
                move.b  #$81,$21(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$120,$14(a5)
                move.w  #3,$48(a5)
                move.w  #$A0,$4A(a5)
; Sets player death animation flags and counters
Player_HandleDeathSequence_SetFlags:                    ; DATA XREF: ROM:00015098   o  ; was: loc_15134
                bset    #5,(byte_FF8244).w
                bset    #0,(byte_FF8244).w
                move.b  #8,$20(a5)
                btst    #0,(FrameCounter+1).w
                bne.s   Player_HandleDeathSequence_ClampEnergy
                subq.w  #1,(PlayerHealth).w
Player_HandleDeathSequence_ClampEnergy:                 ; CODE XREF: Player_HandleDeathSequence+8A   j  ; was: loc_15152
                subq.w  #1,(PlayerHealth).w
                bpl.s   Player_HandleDeathSequence_UpdateTimer
                clr.w   (PlayerHealth).w
Player_HandleDeathSequence_UpdateTimer:                 ; CODE XREF: Player_HandleDeathSequence+94   j  ; was: loc_1515C
                move.w  #$10,$5E(a5)
                subq.w  #1,$4A(a5)
                bmi.s   Player_HandleDeathSequence_BeginRespawn
                move.b  $6A(a5),d0
                andi.w  #$70,d0                         ; 'p'
                beq.s   Player_HandleDeathSequence_RenderParticles
                move.b  #$BD,d0
                jsr     (Sound_PlaySFX).l
                subq.w  #1,$48(a5)
                bmi.s   Player_HandleDeathSequence_BeginRespawn
Player_HandleDeathSequence_RenderParticles:             ; CODE XREF: Player_HandleDeathSequence+AE   j  ; was: loc_15182
                bra.w   Player_RenderDeathParticles
; ---------------------------------------------------------------------------
Player_HandleDeathSequence_BeginRespawn:                ; CODE XREF: Player_HandleDeathSequence+A4   j  ; was: loc_15186
                                        ; Player_HandleDeathSequence+BE   j
                clr.w   (word_FF80E6).w
                move.b  #$7F,(PlayerInputMask).w
                move.w  #$38,4(a5)                      ; '8'
                move.w  #$CD00,2(a5)
                move.w  #$C,$5C(a5)
                move.l  #$FFF70000,$1C(a5)
                move.w  #$50,$5E(a5)                    ; 'P'
                clr.w   $48(a5)
                clr.w   $4A(a5)
                move.b  $4C(a5),$E(a5)
                move.b  $4D(a5),$20(a5)
                move.w  #$170,$14(a5)
                move.w  #$FF80,$52(a5)
; Handles respawn gravity accumulation until landing
Player_HandleRespawnGravity:                            ; DATA XREF: ROM:0001509A   o  ; was: loc_151D0
                bclr    #0,(byte_FF826C).w
                addi.l  #$3000,$1C(a5)
                bmi.w   Player_HandleFallingState_UpdateTerrain
                clr.b   (word_FF8224).w
                clr.b   (word_FF8224+1).w
                bra.w   Player_HandleFallingState_UpdateTerrain
; End of function Player_HandleDeathSequence
; Initializes player air movement state
Player_InitAirState:                                    ; CODE XREF: Player_GroundedDamageState+18   j  ; was: sub_151EE
                                        ; Player_DamageLandingRecoveryState+10   j
                move.b  #$7F,(PlayerInputMask).w
                bclr    #0,(byte_FF826C).w
                clr.w   (word_FF8224).w
                move.w  #0,4(a5)
                clr.l   $18(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_InitAirState
Player_HandleJump_Return:                               ; CODE XREF: Player_HandleJump+1C   j  ; was: nullsub_36
                                        ; Player_HandleJump+22   j
                rts
; End of function Player_HandleJump_Return

; Handles player jump mechanics
Player_HandleJump:                                      ; DATA XREF: ROM:Player_StateHandlerOffsets   o  ; was: sub_1521E
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                bsr.w   Physics_LowerTerrainCheckWrapper
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                bsr.w   Effect_SpawnParticle
                bsr.w   Player_HandleSpecialMove
                bne.s   Player_HandleJump_Return
                bsr.w   Player_CheckSpecialMoveActivation
                bne.s   Player_HandleJump_Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_HandleDamageKnockback
                btst    #4,$69(a5)
                beq.s   Player_HandleJump_CheckMovementInput
                tst.w   (ShootingMode).w
                bne.s   Player_HandleJump_Render
Player_HandleJump_CheckMovementInput:                   ; CODE XREF: Player_HandleJump+34   j  ; was: loc_1525A
                btst    #1,$69(a5)
                bne.w   Player_InitJumpCancelState
                btst    #2,$69(a5)
                bne.w   Player_CheckWallCollisionJump
                btst    #3,$69(a5)
                bne.w   Player_CheckWallCollisionJump
Player_HandleJump_Render:                               ; CODE XREF: Player_HandleJump+3A   j  ; was: loc_15278
                btst    #4,$69(a5)
                beq.w   Player_RenderIdleFrame
                bra.w   Player_RenderSpecialWeapon
; ---------------------------------------------------------------------------
; Handles damage knockback with velocity and timer setup
Player_HandleDamageKnockback:                           ; CODE XREF: Player_HandleJump+2A   j  ; was: loc_15286
                                        ; Player_HandleAirState+2C   j
                bsr.w   Player_SpawnDamageImpactEffect
                move.b  #$7F,(PlayerInputMask).w
                jsr     (Sys_ClearObjectBlocks16).l
                move.w  #$3A,4(a5)                      ; ':'
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   Player_HandleDamageKnockback_Return
                neg.l   $18(a5)
Player_HandleDamageKnockback_Return:                    ; CODE XREF: Player_HandleJump+A4   j  ; was: locret_152C8
                rts
; End of function Player_HandleJump
; Handles the grounded phase of player damage knockback
Player_GroundedDamageState:                             ; DATA XREF: ROM:0001509C   o  ; was: sub_152CA
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                bsr.w   Physics_LowerTerrainCheckWrapper
                btst    #0,6(a5)
                beq.w   Player_SetAirborneDamageState
                subq.w  #1,$4A(a5)
                bmi.w   Player_InitAirState
                bsr.w   Player_CheckDamageRecoveryInput
                bne.w   Player_InitiateDashAttack_UseGroundState
                move.l  #$2000,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                bra.w   Player_AnimateDefeatSprite
; End of function Player_GroundedDamageState
; Initializes airborne player damage knockback and velocity
Player_InitAirborneDamageKnockback:                     ; CODE XREF: Player_HandleFallingState+82   j  ; was: sub_152FC
                                        ; Player_HandleSpecialAttack+64   j
                bsr.w   Player_SpawnDamageImpactEffect
                move.b  #$7F,(PlayerInputMask).w
                jsr     (Sys_ClearObjectBlocks16).l
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$FFFE0000,$1C(a5)
                move.l  #$FFFC0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   Player_SetAirborneDamageState
                neg.l   $18(a5)
; Selects the airborne damage state
Player_SetAirborneDamageState:                          ; CODE XREF: Player_GroundedDamageState+10   j  ; was: loc_1533A
                                        ; Player_InitAirborneDamageKnockback+38   j
                move.w  #$3C,4(a5)                      ; '<'
                rts
; End of function Player_InitAirborneDamageKnockback
; Applies gravity and terrain collision during airborne player damage
Player_AirborneDamageState:                             ; DATA XREF: ROM:0001509E   o  ; was: sub_15342
                addi.l  #$5000,$1C(a5)
                jsr     Physics_ExtendedWallCheckWrapper(pc)  ; (pc)
                nop
                tst.w   $1C(a5)
                bmi.s   Player_AirborneDamageState_CheckUpperTerrain
                bsr.w   Physics_DescendingTerrainCheckWrapper
                btst    #0,6(a5)
                bne.w   Player_InitLandingState
                bra.s   Player_DamageState_UpdateTimer
; ---------------------------------------------------------------------------
Player_AirborneDamageState_CheckUpperTerrain:           ; CODE XREF: Player_AirborneDamageState+12   j  ; was: loc_15366
                clr.b   6(a5)
                jsr     Physics_RisingTerrainCheckWrapper(pc)  ; (pc)
                nop
                bra.s   Player_DamageState_UpdateTimer
; End of function Player_AirborneDamageState
; Recovers from the alternate damage state when lower terrain is reached
Player_DamageLandingRecoveryState:
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)  ; was: sub_15372
                nop
                bsr.w   Physics_LowerTerrainCheckWrapper
                btst    #0,6(a5)
                bne.w   Player_InitAirState
Player_DamageState_UpdateTimer:                         ; CODE XREF: Player_AirborneDamageState+22   j  ; was: loc_15386
                                        ; Player_AirborneDamageState+2E   j
                subq.w  #1,$4A(a5)
                bmi.w   Player_InitFallState_Finish
                move.l  #$1800,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                bra.w   Player_AnimateDefeatSprite
; End of function Player_DamageLandingRecoveryState
; Detects the input chord that cancels the grounded damage state
Player_CheckDamageRecoveryInput:                        ; CODE XREF: Player_GroundedDamageState+1C   p  ; was: sub_1539C
                btst    #5,$6A(a5)
                beq.s   Player_CheckDamageRecoveryInput_Return
                btst    #1,$69(a5)
                beq.s   Player_CheckDamageRecoveryInput_Return
                move.w  (PlayerHealth).w,d0
                sub.w   (PlayerMaxHealth).w,d0
                move.w  d0,(word_FF8304).w
                moveq   #1,d0
Player_CheckDamageRecoveryInput_Return:                 ; CODE XREF: Player_CheckDamageRecoveryInput+6   j  ; was: locret_153BA
                                        ; Player_CheckDamageRecoveryInput+E   j
                rts
; End of function Player_CheckDamageRecoveryInput
; Supplies facing-dependent position and velocity for the player damage impact
Player_SpawnDamageImpactEffect:                         ; CODE XREF: Player_HandleJump:loc_15286   p  ; was: sub_153BC
                                        ; sub_152FC   p
                moveq   #$FFFFFFFC,d0
                move.l  #$FFFC0000,d2
                moveq   #$FFFFFFF6,d1
                btst    #4,$E(a5)
                beq.s   Player_SpawnDamageImpactEffect_Create
                moveq   #$A,d1
Player_SpawnDamageImpactEffect_Create:                  ; CODE XREF: Player_SpawnDamageImpactEffect+10   j  ; was: loc_153D0
                bra.w   Player_CreateDamageImpactObject
; End of function Player_SpawnDamageImpactEffect
; Initializes jump cancel state clearing flags and timers
Player_InitJumpCancelState:                             ; CODE XREF: Player_HandleJump+42   j  ; was: sub_153D4
                                        ; Player_HandleAirMovement+30   j
                move.w  #2,$48(a5)
; Initializes jump cancel state clearing flags and setting timers
Player_InitJumpCancelCleanup:                           ; CODE XREF: Player_DashAttackState+84   j  ; was: loc_153DA
                                        ; Player_HandleSlideState+34   j
                bclr    #0,(byte_FF826C).w
                clr.w   (word_FF8224).w
                move.w  #$E,4(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #8,$5C(a5)
                move.b  #$7F,(PlayerInputMask).w
                bra.w   Player_AutoFlipDirection
; End of function Player_InitJumpCancelState
Player_HandleAirState_Return:                           ; CODE XREF: Player_HandleAirState+1E   j  ; was: nullsub_37
                                        ; Player_HandleAirState+24   j
                rts
; End of function Player_HandleAirState_Return

; Handles player airborne state logic
Player_HandleAirState:                                  ; DATA XREF: ROM:00015070   o  ; was: sub_15408
                bset    #1,(byte_FF8244).w
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                bsr.w   Physics_LowerTerrainCheckWrapper
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                bsr.w   Player_HandleSpecialMove
                bne.s   Player_HandleAirState_Return
                bsr.w   Player_CheckSpecialMoveActivation
                bne.s   Player_HandleAirState_Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_HandleDamageKnockback
                bsr.w   Player_DecelerateHorizontalVelocityFast
                subq.w  #1,$48(a5)
                bpl.s   Player_CheckAirStateTransition
                move.w  #$FFFF,$48(a5)
                btst    #4,$69(a5)
                beq.s   Player_HandleAirState_CheckJumpInput
                tst.w   (ShootingMode).w
                bne.s   Player_CheckAirStateTransition
Player_HandleAirState_CheckJumpInput:                   ; CODE XREF: Player_HandleAirState+46   j  ; was: loc_15456
                btst    #1,$69(a5)
                beq.w   Player_InitAirState
; Checks conditions for transitioning between air states
Player_CheckAirStateTransition:                         ; CODE XREF: Player_HandleAirState+38   j  ; was: loc_15460
                                        ; Player_HandleAirState+4C   j
                btst    #4,$69(a5)
                beq.w   Player_RenderAirborneFrame
                bra.w   Player_RenderAirborneWithWeapon
; End of function Player_HandleAirState
; Initializes player air state with parameters
Player_InitAirJumpState:                                ; CODE XREF: Player_HandleLandingState+6C   j  ; was: sub_1546E
                                        ; Player_CheckWallCollisionJump+3A   j
                move.b  #$7F,(PlayerInputMask).w
                clr.w   (word_FF8224).w
                move.w  #$A,4(a5)
                clr.w   $48(a5)
                move.w  #4,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_InitAirJumpState
; Handles player movement while airborne
Player_HandleAirMovement:                               ; DATA XREF: ROM:0001506C   o  ; was: sub_1548C
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                bsr.w   Physics_LowerTerrainCheckWrapper
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                bsr.w   Player_HandleSpecialMove
                bne.s   Player_AirMovement_Return
                bsr.w   Player_CheckSpecialMoveActivation
                bne.s   Player_AirMovement_Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_HandleDamageKnockback
                btst    #1,$69(a5)
                bne.w   Player_InitJumpCancelState
                bsr.w   Player_DecelerateHorizontalVelocityFast
                move.l  $18(a5),d0
                bne.s   Player_RenderAirMovementFrame
                btst    #2,$69(a5)
                bne.w   Player_CheckWallCollisionFromMovement
                btst    #3,$69(a5)
                bne.w   Player_CheckWallCollisionFromMovement
                bra.w   Player_InitAirState
; ---------------------------------------------------------------------------
; Selects the unarmed air-movement rendering path
Player_RenderAirMovementFrame:                          ; CODE XREF: Player_HandleAirMovement+3C   j  ; was: loc_154E2
                btst    #4,$69(a5)
                bne.w   Player_RenderFallingSprite
                movea.l #Player_CommonPrimarySpriteMapping,a1
                movea.l #Player_CommonMovementSecondarySpriteMapping,a2
                moveq   #0,d5
                moveq   #6,d6
                bra.w   Player_BuildSpritePieces
; ---------------------------------------------------------------------------
Player_AirMovement_Return:                              ; CODE XREF: Player_HandleAirMovement+18   j  ; was: locret_15500
                                        ; Player_HandleAirMovement+1E   j
                rts
; End of function Player_HandleAirMovement
; Initializes player landing state
Player_InitLandingState:                                ; CODE XREF: Player_AirborneDamageState+1E   j  ; was: sub_15502
                                        ; Player_HandleFallingState+50   j
                move.b  #$7F,(PlayerInputMask).w
                clr.w   (word_FF8224).w
                move.w  #$16,4(a5)
                move.w  #2,$48(a5)
                move.w  #6,$4A(a5)
                move.w  #8,$5C(a5)
                move.b  #$B1,d0
                jsr     (Sound_PlaySFX).l
                bra.w   Player_AutoFlipDirection
; End of function Player_InitLandingState
; Handles player landing state logic
Player_HandleLandingState:                              ; DATA XREF: ROM:00015078   o  ; was: sub_15532
                bset    #1,(byte_FF8244).w
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                bsr.w   Physics_LowerTerrainCheckWrapper
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                bsr.w   Player_HandleSpecialMove
                bne.s   Player_AirMovement_Return
                bsr.w   Player_CheckSpecialMoveActivation
                bne.s   Player_AirMovement_Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_HandleDamageKnockback
                move.l  #$4000,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                subq.w  #1,$4A(a5)
                subq.w  #1,$48(a5)
                bpl.s   Player_HandleLandingState_Render
                btst    #1,$69(a5)
                beq.s   Player_HandleLandingState_CheckMovementInput
                bsr.w   Player_InitJumpCancelState
                move.w  #$FFFF,$48(a5)
                bra.s   Player_HandleLandingState_Render
; ---------------------------------------------------------------------------
Player_HandleLandingState_CheckMovementInput:           ; CODE XREF: Player_HandleLandingState+4A   j  ; was: loc_1558A
                btst    #2,$69(a5)
                bne.w   Player_CheckWallCollisionFromMovement
                btst    #3,$69(a5)
                bne.w   Player_CheckWallCollisionFromMovement
                bra.w   Player_InitAirJumpState
; ---------------------------------------------------------------------------
Player_HandleLandingState_Render:                       ; CODE XREF: Player_HandleLandingState+42   j  ; was: loc_155A2
                                        ; Player_HandleLandingState+56   j
                btst    #4,$69(a5)
                beq.w   Player_RenderAirborneFrame
                bra.w   Player_RenderAirborneWithWeapon
; End of function Player_HandleLandingState
; Handles player special move action
Player_HandleSpecialMove:                               ; CODE XREF: Player_HandleJump+18   p  ; was: sub_155B0
                                        ; Player_HandleAirState+1A   p
                btst    #6,$6A(a5)
                beq.s   Player_HandleSpecialMove_NotActivated
                btst    #1,$69(a5)
                bne.w   Player_ToggleAlternateModeWithInputMask
                tst.w   (WeaponStateCooldown).w
                bmi.s   Player_HandleSpecialMove_Activate
Player_HandleSpecialMove_NotActivated:                  ; CODE XREF: Player_HandleSpecialMove+6   j  ; was: loc_155C8
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
Player_HandleSpecialMove_Activate:                      ; CODE XREF: Player_HandleSpecialMove+16   j  ; was: loc_155CC
                move.w  (WeaponSlotOffset).w,(WeaponSavedSlotOffset).w
                move.w  #$12,(WeaponStateIndex).w
                move.b  #$7F,(PlayerInputMask).w
                move.w  #0,(word_FF8032).w
                move.w  #$FFEE,(word_FF8034).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$C,4(a5)
                move.w  #4,$5C(a5)
                btst    #1,$69(a5)
                beq.s   Player_HandleSpecialMove_ReturnActivated
                move.w  #8,$5C(a5)
; Reports successful special-move activation
Player_HandleSpecialMove_ReturnActivated:               ; CODE XREF: Player_HandleSpecialMove+54   j  ; was: loc_1560C
                moveq   #1,d0
                rts
; End of function Player_HandleSpecialMove
; Handles player grounded state with terrain and damage checks
Player_HandleGroundedState:                             ; DATA XREF: ROM:0001506E   o  ; was: sub_15610
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                bsr.w   Physics_LowerTerrainCheckWrapper
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                cmpi.w  #$12,(WeaponStateIndex).w
                bmi.w   Player_InitAirState
                bra.w   Player_RenderIdleFrame
; End of function Player_HandleGroundedState
; Masks input, toggles the shared alternate-mode flag, and plays its sound
Player_ToggleAlternateModeWithInputMask:                ; CODE XREF: Player_HandleSpecialMove+E   j  ; was: sub_15632
                                        ; Player_CheckAlternateSpecialActivation+10   p
                move.b  #$7F,(PlayerInputMask).w
                eori.w  #2,(ShootingMode).w
                move.b  #$A3,d0
                jsr     (Sound_PlaySFX).l
                moveq   #0,d0
                rts
; End of function Player_ToggleAlternateModeWithInputMask
; Checks wall collision during jump and initiates wall states
Player_CheckWallCollisionJump:                          ; CODE XREF: Player_HandleJump+4C   j  ; was: sub_1564C
                                        ; Player_HandleJump+56   j
                btst    #4,$69(a5)
                beq.s   Player_InitWallBounceState
                tst.w   (ShootingMode).w
                beq.s   Player_CheckWallCollisionJump_CheckFacing
                rts
; ---------------------------------------------------------------------------
Player_CheckWallCollisionFromMovement:                  ; CODE XREF: Player_HandleAirMovement+44   j  ; was: loc_1565C
                                        ; Player_HandleAirMovement+4E   j
                btst    #4,$69(a5)
                beq.s   Player_InitWallBounceState
                tst.w   (ShootingMode).w
                bne.w   Player_InitAirState
Player_CheckWallCollisionJump_CheckFacing:              ; CODE XREF: Player_CheckWallCollisionJump+C   j  ; was: loc_1566C
                btst    #3,$69(a5)
                beq.s   Player_CheckWallCollisionJump_CheckLeft
                btst    #3,$E(a5)
                bne.w   Player_InitGroundWeaponState
                bra.s   Player_InitWallBounceState
; ---------------------------------------------------------------------------
Player_CheckWallCollisionJump_CheckLeft:                ; CODE XREF: Player_CheckWallCollisionJump+26   j  ; was: loc_15680
                btst    #2,$69(a5)
                beq.w   Player_InitAirJumpState
                btst    #3,$E(a5)
                beq.w   Player_InitGroundWeaponState
; Initializes wall bounce state with velocity and direction flip
Player_InitWallBounceState:                             ; CODE XREF: Player_CheckWallCollisionJump+6   j  ; was: loc_15694
                                        ; Player_CheckWallCollisionJump+16   j
                move.b  #$7F,(PlayerInputMask).w
                move.w  #2,4(a5)
                move.w  #4,$48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_CheckWallCollisionJump
Player_GroundedMovementState_Return:                    ; CODE XREF: Player_GroundedMovementState+18   j  ; was: nullsub_38
                                        ; Player_GroundedMovementState+1E   j
                rts
; End of function Player_GroundedMovementState_Return
