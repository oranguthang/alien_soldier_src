Player_InitializeStats:                                 ; CODE XREF: Stage_LoadXiTigerGraphics+3A   j  ; was: sub_14F06
                                        ; Sys_InitStageState+3A   j
                lea     (word_FFA400).w,a5
                move.b  #$7F,(byte_FF830F).w
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
                jmp     UI_IncrementWeaponSelection
; End of function Player_InitializeStats
; Clears player state flags
Player_ClearState:                                      ; CODE XREF: Player_Update+A   j  ; was: sub_14F82
                clr.w   (a5)
                clr.w   2(a5)
                rts
; End of function Player_ClearState
; Sets player invincibility flag bit based on game state
Player_SetInvincibilityFlag:                            ; CODE XREF: Player_Update+12   j  ; was: sub_14F8A
                tst.w   (word_FF813C).w
                bmi.s   Player_SetInvincibilityFlag_Return
                bset    #7,2(a5)
; Return after setting player invincibility
Player_SetInvincibilityFlag_Return:                     ; CODE XREF: Player_SetInvincibilityFlag+4   j  ; was: locret_14F96
                                        ; DATA XREF: ROM:0001508E   o
                rts
; End of function Player_SetInvincibilityFlag
; Main player update routine
Player_Update:                                          ; CODE XREF: Sys_GameplayMainLoop:Sys_GameplayMainLoop_UpdatePlayer   p  ; was: sub_14F98
                                        ; sub_1EE3C   p
                movea.w #(word_FFA400-M68K_RAM),a5
                btst    #1,(byte_FF8144).w
                bne.w   Player_ClearState
                tst.b   (byte_FF813E).w
                bmi.s   Player_SetInvincibilityFlag
                jsr     (Input_MergeButtonState).l
                bsr.w   Input_ReadPlayerInput
                clr.b   (byte_FF8244).w
                clr.w   6(a5)
                tst.w   (word_FF80E6).w
                beq.s   loc_14FC8
                bpl.w   Player_HandleInvulnerabilityTimer
loc_14FC8:                                              ; CODE XREF: Player_Update+2A   j
                tst.w   (word_FFA270).w
                beq.w   Player_InitInvulnerabilityState
                tst.w   (word_FFA216).w
                beq.w   Player_InitInvulnerabilityState
                btst    #0,(byte_FF8144).w
                bne.w   Boss_SylpheedSpawnProjectile1
                btst    #2,(byte_FF8144).w
                bne.w   Gfx_SireneBackground
                bsr.w   Gfx_LoadPlayerPaletteData
                bsr.w   Input_ProcessDirectionInput
                bclr    #6,$22(a5)
                beq.s   loc_15002
                bsr.w   Player_InitKnockbackState
                bra.s   Player_UpdateCoreAttributes
; ---------------------------------------------------------------------------
loc_15002:                                              ; CODE XREF: Player_Update+62   j
                bclr    #1,$22(a5)
                beq.s   loc_15010
                bsr.w   Player_InitCutsceneState
                bra.s   Player_UpdateCoreAttributes
; ---------------------------------------------------------------------------
loc_15010:                                              ; CODE XREF: Player_Update+70   j
                cmpi.w  #$36,4(a5)                      ; '6'
                beq.s   loc_15030
                tst.w   $1C(a5)
                bmi.s   loc_15030
                btst    #0,(byte_FF8245).w
                bne.s   loc_15030
                cmpi.w  #$171,$14(a5)
                bpl.w   Player_HandleDeathSequence
loc_15030:                                              ; CODE XREF: Player_Update+7E   j
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
                movea.w off_15062(pc,d0.w),a0
                adda.l  #Player_HandleDeathSequence,a0
                jmp     (a0)
; End of function Player_UpdateState
; ---------------------------------------------------------------------------
off_15062:      dc.w    Player_HandleJump-Player_HandleDeathSequence
                                        ; DATA XREF: Player_UpdateState+4   r
                dc.w    Boss_UpdateHealthBar-Player_HandleDeathSequence
                dc.w    Player_AirAttackState-Player_HandleDeathSequence
                dc.w    Player_HandleFallingState-Player_HandleDeathSequence
                dc.w    Player_HandleFallingState-Player_HandleDeathSequence
                dc.w    Player_HandleAirMovement-Player_HandleDeathSequence
                dc.w    Player_HandleGroundedState-Player_HandleDeathSequence
                dc.w    Player_HandleAirState-Player_HandleDeathSequence
                dc.w    Player_HandleDashCancel-Player_HandleDeathSequence
                dc.w    Player_HandleBounceState-Player_HandleDeathSequence
                dc.w    Player_HandleFallingState-Player_HandleDeathSequence
                dc.w    Player_HandleLandingState-Player_HandleDeathSequence
                dc.w    Player_HandleDashState-Player_HandleDeathSequence
                dc.w    Sound_PlayBossHitSound-Player_HandleDeathSequence
                dc.w    Player_AirControlState-Player_HandleDeathSequence
                dc.w    Player_HandleCrouchState-Player_HandleDeathSequence
                dc.w    Player_CheckDashCounter-Player_HandleDeathSequence
                dc.w    Player_ProcessAirState-Player_HandleDeathSequence
                dc.w    Player_HandleDashCancel-Player_HandleDeathSequence
                dc.w    Player_ProcessJumpState-Player_HandleDeathSequence
                dc.w    Player_HandleFallingState-Player_HandleDeathSequence
                dc.w    Player_DefeatState-Player_HandleDeathSequence
                dc.w    Player_SetInvincibilityFlag_Return-Player_HandleDeathSequence
                dc.w    Player_SetInvincibilityFlag_Return-Player_HandleDeathSequence
                dc.w    Player_SetInvincibilityFlag_Return-Player_HandleDeathSequence
                dc.w    Player_HandleCutsceneControl-Player_HandleDeathSequence
                dc.w    Player_HandleCutsceneControl-Player_HandleDeathSequence
                dc.w    Player_HandleDeathSequence_SetFlags-Player_HandleDeathSequence
                dc.w    Player_HandleRespawnGravity-Player_HandleDeathSequence
                dc.w    Physics_ApplyBossVelocity-Player_HandleDeathSequence
                dc.w    Physics_BossCollisionCheck-Player_HandleDeathSequence
                dc.w    Player_HandleAirDashState-Player_HandleDeathSequence
                dc.w    Player_HandleSlideState-Player_HandleDeathSequence
                dc.w    Player_HandleSlideState-Player_HandleDeathSequence
                dc.w    Player_DashKickState-Player_HandleDeathSequence
                dc.w    Effect_UpdateParticles-Player_HandleDeathSequence
                dc.w    Player_UpdateAimDirection-Player_HandleDeathSequence
                dc.w    Player_UpdateForceWeapon-Player_HandleDeathSequence
                dc.w    Player_JumpApexState-Player_HandleDeathSequence
                dc.w    Player_HandleSpecialAttack-Player_HandleDeathSequence
                dc.w    Player_TeleportDash-Player_HandleDeathSequence
                dc.w    Player_TeleportDash_ApplyVelocity-Player_HandleDeathSequence
                dc.w    Player_HandleBossVictory-Player_HandleDeathSequence
                dc.w    Player_PhoenixAttackUpdate-Player_HandleDeathSequence
                dc.w    Boss_ArtemisSpawnProjectile2-Player_HandleDeathSequence
                dc.w    Player_UpdateAnimStateMinus4-Player_HandleDeathSequence
                dc.w    Credits_VBlankHandler-Player_HandleDeathSequence
                dc.w    Player_TeleportDash_UpdateSprite-Player_HandleDeathSequence

; Handles player death sequence with knockback and respawn countdown
Player_HandleDeathSequence:                             ; CODE XREF: Player_Update+94   j  ; was: sub_150C2
                                        ; DATA XREF: Player_UpdateState+8   o
                move.b  #$2B,d0                         ; '+'
                jsr     (Sound_PlaySFX).l
                move.b  #$73,(byte_FF830F).w            ; 's'
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
                btst    #0,(word_FFA000+1).w
                bne.s   loc_15152
                subq.w  #1,(word_FFA216).w
loc_15152:                                              ; CODE XREF: Player_HandleDeathSequence+8A   j
                subq.w  #1,(word_FFA216).w
                bpl.s   loc_1515C
                clr.w   (word_FFA216).w
loc_1515C:                                              ; CODE XREF: Player_HandleDeathSequence+94   j
                move.w  #$10,$5E(a5)
                subq.w  #1,$4A(a5)
                bmi.s   loc_15186
                move.b  $6A(a5),d0
                andi.w  #$70,d0                         ; 'p'
                beq.s   loc_15182
                move.b  #$BD,d0
                jsr     (Sound_PlaySFX).l
                subq.w  #1,$48(a5)
                bmi.s   loc_15186
loc_15182:                                              ; CODE XREF: Player_HandleDeathSequence+AE   j
                bra.w   Player_RenderDeathParticles
; ---------------------------------------------------------------------------
loc_15186:                                              ; CODE XREF: Player_HandleDeathSequence+A4   j
                                        ; Player_HandleDeathSequence+BE   j
                clr.w   (word_FF80E6).w
                move.b  #$7F,(byte_FF830F).w
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
                bmi.w   loc_15D12
                clr.b   (word_FF8224).w
                clr.b   (word_FF8224+1).w
                bra.w   loc_15D12
; End of function Player_HandleDeathSequence
; Initializes player air movement state
Player_InitAirState:                                    ; CODE XREF: Physics_ApplyBossVelocity+18   j  ; was: sub_151EE
                                        ; Player_DefeatGroundedState+10   j
                move.b  #$7F,(byte_FF830F).w
                bclr    #0,(byte_FF826C).w
                clr.w   (word_FF8224).w
                move.w  #0,4(a5)
                clr.l   $18(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_InitAirState
nullsub_36:                                             ; CODE XREF: Player_HandleJump+1C   j
                                        ; Player_HandleJump+22   j
                rts
; End of function nullsub_36

; Handles player jump mechanics
Player_HandleJump:                                      ; DATA XREF: ROM:off_15062   o  ; was: sub_1521E
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                bsr.w   Player_ProcessAction
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                bsr.w   Effect_SpawnParticle
                bsr.w   Player_HandleSpecialMove
                bne.s   nullsub_36
                bsr.w   Player_CheckSpecialMoveActivation
                bne.s   nullsub_36
                btst    #0,(byte_FF826C).w
                bne.w   Player_HandleDamageKnockback
                btst    #4,$69(a5)
                beq.s   loc_1525A
                tst.w   (word_FFA22A).w
                bne.s   loc_15278
loc_1525A:                                              ; CODE XREF: Player_HandleJump+34   j
                btst    #1,$69(a5)
                bne.w   Player_InitJumpCancelState
                btst    #2,$69(a5)
                bne.w   Player_CheckWallCollisionJump
                btst    #3,$69(a5)
                bne.w   Player_CheckWallCollisionJump
loc_15278:                                              ; CODE XREF: Player_HandleJump+3A   j
                btst    #4,$69(a5)
                beq.w   Player_ProcessCollisionDamage
                bra.w   Player_RenderSpecialWeapon
; ---------------------------------------------------------------------------
; Handles damage knockback with velocity and timer setup
Player_HandleDamageKnockback:                           ; CODE XREF: Player_HandleJump+2A   j  ; was: loc_15286
                                        ; Player_HandleAirState+2C   j
                bsr.w   Boss_FlashOnHit
                move.b  #$7F,(byte_FF830F).w
                jsr     (Sys_ClearObjectBlocks16).l
                move.w  #$3A,4(a5)                      ; ':'
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_152C8
                neg.l   $18(a5)
locret_152C8:                                           ; CODE XREF: Player_HandleJump+A4   j
                rts
; End of function Player_HandleJump
; Applies velocity to boss position with bounds
Physics_ApplyBossVelocity:                              ; DATA XREF: ROM:0001509C   o  ; was: sub_152CA
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                bsr.w   Player_ProcessAction
                btst    #0,6(a5)
                beq.w   Player_SetDeathStateFlags
                subq.w  #1,$4A(a5)
                bmi.w   Player_InitAirState
                bsr.w   Boss_TakeDamage
                bne.w   loc_15936
                move.l  #$2000,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                bra.w   Player_AnimateDefeatSprite
; End of function Physics_ApplyBossVelocity
; Initializes player death knockback state and velocity
Player_InitDeathKnockback:                              ; CODE XREF: Player_HandleFallingState+82   j  ; was: sub_152FC
                                        ; Player_HandleSpecialAttack+64   j
                bsr.w   Boss_FlashOnHit
                move.b  #$7F,(byte_FF830F).w
                jsr     (Sys_ClearObjectBlocks16).l
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$FFFE0000,$1C(a5)
                move.l  #$FFFC0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   Player_SetDeathStateFlags
                neg.l   $18(a5)
; Sets player death state flags and animation timer
Player_SetDeathStateFlags:                              ; CODE XREF: Physics_ApplyBossVelocity+10   j  ; was: loc_1533A
                                        ; Player_InitDeathKnockback+38   j
                move.w  #$3C,4(a5)                      ; '<'
                rts
; End of function Player_InitDeathKnockback
; Checks collision between boss and player shots
Physics_BossCollisionCheck:                             ; DATA XREF: ROM:0001509E   o  ; was: sub_15342
                addi.l  #$5000,$1C(a5)
                jsr     Physics_BossTerrainWrapper(pc)  ; (pc)
                nop
                tst.w   $1C(a5)
                bmi.s   loc_15366
                bsr.w   Player_UpdateTerrainCheck
                btst    #0,6(a5)
                bne.w   Player_InitLandingState
                bra.s   loc_15386
; ---------------------------------------------------------------------------
loc_15366:                                              ; CODE XREF: Physics_BossCollisionCheck+12   j
                clr.b   6(a5)
                jsr     Player_TerrainCheckAlternate(pc)  ; (pc)
                nop
                bra.s   loc_15386
; End of function Physics_BossCollisionCheck
; Handles player defeat with terrain check
Player_DefeatGroundedState:
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)  ; was: sub_15372
                nop
                bsr.w   Player_ProcessAction
                btst    #0,6(a5)
                bne.w   Player_InitAirState
loc_15386:                                              ; CODE XREF: Physics_BossCollisionCheck+22   j
                                        ; Physics_BossCollisionCheck+2E   j
                subq.w  #1,$4A(a5)
                bmi.w   loc_15C3C
                move.l  #$1800,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                bra.w   Player_AnimateDefeatSprite
; End of function Player_DefeatGroundedState
; Processes damage to boss and updates health
Boss_TakeDamage:                                        ; CODE XREF: Physics_ApplyBossVelocity+1C   p  ; was: sub_1539C
                btst    #5,$6A(a5)
                beq.s   locret_153BA
                btst    #1,$69(a5)
                beq.s   locret_153BA
                move.w  (word_FFA216).w,d0
                sub.w   (word_FFA218).w,d0
                move.w  d0,(word_FF8304).w
                moveq   #1,d0
locret_153BA:                                           ; CODE XREF: Boss_TakeDamage+6   j
                                        ; Boss_TakeDamage+E   j
                rts
; End of function Boss_TakeDamage
; Flashes boss sprite when taking damage
Boss_FlashOnHit:                                        ; CODE XREF: Player_HandleJump:loc_15286   p  ; was: sub_153BC
                                        ; sub_152FC   p
                moveq   #$FFFFFFFC,d0
                move.l  #$FFFC0000,d2
                moveq   #$FFFFFFF6,d1
                btst    #4,$E(a5)
                beq.s   loc_153D0
                moveq   #$A,d1
loc_153D0:                                              ; CODE XREF: Boss_FlashOnHit+10   j
                bra.w   Boss_CheckDefeatCondition
; End of function Boss_FlashOnHit
; Initializes jump cancel state clearing flags and timers
Player_InitJumpCancelState:                             ; CODE XREF: Player_HandleJump+42   j  ; was: sub_153D4
                                        ; Player_HandleAirMovement+30   j
                move.w  #2,$48(a5)
; Initializes jump cancel state clearing flags and setting timers
Player_InitJumpCancelCleanup:                           ; CODE XREF: Player_HandleDashCancel+84   j  ; was: loc_153DA
                                        ; Player_HandleSlideState+34   j
                bclr    #0,(byte_FF826C).w
                clr.w   (word_FF8224).w
                move.w  #$E,4(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #8,$5C(a5)
                move.b  #$7F,(byte_FF830F).w
                bra.w   Player_AutoFlipDirection
; End of function Player_InitJumpCancelState
nullsub_37:                                             ; CODE XREF: Player_HandleAirState+1E   j
                                        ; Player_HandleAirState+24   j
                rts
; End of function nullsub_37

; Handles player airborne state logic
Player_HandleAirState:                                  ; DATA XREF: ROM:00015070   o  ; was: sub_15408
                bset    #1,(byte_FF8244).w
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                bsr.w   Player_ProcessAction
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                bsr.w   Player_HandleSpecialMove
                bne.s   nullsub_37
                bsr.w   Player_CheckSpecialMoveActivation
                bne.s   nullsub_37
                btst    #0,(byte_FF826C).w
                bne.w   Player_HandleDamageKnockback
                bsr.w   Player_ApplyKnockbackVelocity
                subq.w  #1,$48(a5)
                bpl.s   Player_CheckAirStateTransition
                move.w  #$FFFF,$48(a5)
                btst    #4,$69(a5)
                beq.s   loc_15456
                tst.w   (word_FFA22A).w
                bne.s   Player_CheckAirStateTransition
loc_15456:                                              ; CODE XREF: Player_HandleAirState+46   j
                btst    #1,$69(a5)
                beq.w   Player_InitAirState
; Checks conditions for transitioning between air states
Player_CheckAirStateTransition:                         ; CODE XREF: Player_HandleAirState+38   j  ; was: loc_15460
                                        ; Player_HandleAirState+4C   j
                btst    #4,$69(a5)
                beq.w   Player_HandleDefeatByBoss
                bra.w   loc_170F6
; End of function Player_HandleAirState
; Initializes player air state with parameters
Player_InitAirJumpState:                                ; CODE XREF: Player_HandleLandingState+6C   j  ; was: sub_1546E
                                        ; Player_CheckWallCollisionJump+3A   j
                move.b  #$7F,(byte_FF830F).w
                clr.w   (word_FF8224).w
                move.w  #$A,4(a5)
                clr.w   $48(a5)
                move.w  #4,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_InitAirJumpState
; Handles player movement while airborne
Player_HandleAirMovement:                               ; DATA XREF: ROM:0001506C   o  ; was: sub_1548C
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                bsr.w   Player_ProcessAction
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                bsr.w   Player_HandleSpecialMove
                bne.s   locret_15500
                bsr.w   Player_CheckSpecialMoveActivation
                bne.s   locret_15500
                btst    #0,(byte_FF826C).w
                bne.w   Player_HandleDamageKnockback
                btst    #1,$69(a5)
                bne.w   Player_InitJumpCancelState
                bsr.w   Player_ApplyKnockbackVelocity
                move.l  $18(a5),d0
                bne.s   Player_SelectDeathAnimation
                btst    #2,$69(a5)
                bne.w   loc_1565C
                btst    #3,$69(a5)
                bne.w   loc_1565C
                bra.w   Player_InitAirState
; ---------------------------------------------------------------------------
; Selects appropriate death animation based on player state
Player_SelectDeathAnimation:                            ; CODE XREF: Player_HandleAirMovement+3C   j  ; was: loc_154E2
                btst    #4,$69(a5)
                bne.w   Player_RenderFallingSprite
                movea.l #word_E8972,a1
                movea.l #word_E89C2,a2
                moveq   #0,d5
                moveq   #6,d6
                bra.w   Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
locret_15500:                                           ; CODE XREF: Player_HandleAirMovement+18   j
                                        ; Player_HandleAirMovement+1E   j
                rts
; End of function Player_HandleAirMovement
; Initializes player landing state
Player_InitLandingState:                                ; CODE XREF: Physics_BossCollisionCheck+1E   j  ; was: sub_15502
                                        ; Player_HandleFallingState+50   j
                move.b  #$7F,(byte_FF830F).w
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
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                bsr.w   Player_ProcessAction
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                bsr.w   Player_HandleSpecialMove
                bne.s   locret_15500
                bsr.w   Player_CheckSpecialMoveActivation
                bne.s   locret_15500
                btst    #0,(byte_FF826C).w
                bne.w   Player_HandleDamageKnockback
                move.l  #$4000,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                subq.w  #1,$4A(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_155A2
                btst    #1,$69(a5)
                beq.s   loc_1558A
                bsr.w   Player_InitJumpCancelState
                move.w  #$FFFF,$48(a5)
                bra.s   loc_155A2
; ---------------------------------------------------------------------------
loc_1558A:                                              ; CODE XREF: Player_HandleLandingState+4A   j
                btst    #2,$69(a5)
                bne.w   loc_1565C
                btst    #3,$69(a5)
                bne.w   loc_1565C
                bra.w   Player_InitAirJumpState
; ---------------------------------------------------------------------------
loc_155A2:                                              ; CODE XREF: Player_HandleLandingState+42   j
                                        ; Player_HandleLandingState+56   j
                btst    #4,$69(a5)
                beq.w   Player_HandleDefeatByBoss
                bra.w   loc_170F6
; End of function Player_HandleLandingState
; Handles player special move action
Player_HandleSpecialMove:                               ; CODE XREF: Player_HandleJump+18   p  ; was: sub_155B0
                                        ; Player_HandleAirState+1A   p
                btst    #6,$6A(a5)
                beq.s   loc_155C8
                btst    #1,$69(a5)
                bne.w   Player_ToggleDirectionFlag
                tst.w   (word_FF8038).w
                bmi.s   loc_155CC
loc_155C8:                                              ; CODE XREF: Player_HandleSpecialMove+6   j
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_155CC:                                              ; CODE XREF: Player_HandleSpecialMove+16   j
                move.w  (word_FFA24E).w,(word_FFA220).w
                move.w  #$12,(word_FFA21C).w
                move.b  #$7F,(byte_FF830F).w
                move.w  #0,(word_FF8032).w
                move.w  #$FFEE,(word_FF8034).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$C,4(a5)
                move.w  #4,$5C(a5)
                btst    #1,$69(a5)
                beq.s   Player_SetSpecialMoveDuration
                move.w  #8,$5C(a5)
; Sets duration timer for special move based on button state
Player_SetSpecialMoveDuration:                          ; CODE XREF: Player_HandleSpecialMove+54   j  ; was: loc_1560C
                moveq   #1,d0
                rts
; End of function Player_HandleSpecialMove
; Handles player grounded state with terrain and damage checks
Player_HandleGroundedState:                             ; DATA XREF: ROM:0001506E   o  ; was: sub_15610
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                bsr.w   Player_ProcessAction
                btst    #0,6(a5)
                beq.w   Player_InitFallState
                cmpi.w  #$12,(word_FFA21C).w
                bmi.w   Player_InitAirState
                bra.w   Player_ProcessCollisionDamage
; End of function Player_HandleGroundedState
; Toggles player direction flag with sound
Player_ToggleDirectionFlag:                             ; CODE XREF: Player_HandleSpecialMove+E   j  ; was: sub_15632
                                        ; Effect_SpawnDebris+10   p
                move.b  #$7F,(byte_FF830F).w
                eori.w  #2,(word_FFA22A).w
                move.b  #$A3,d0
                jsr     (Sound_PlaySFX).l
                moveq   #0,d0
                rts
; End of function Player_ToggleDirectionFlag
; Checks wall collision during jump and initiates wall states
Player_CheckWallCollisionJump:                          ; CODE XREF: Player_HandleJump+4C   j  ; was: sub_1564C
                                        ; Player_HandleJump+56   j
                btst    #4,$69(a5)
                beq.s   Player_InitWallBounceState
                tst.w   (word_FFA22A).w
                beq.s   loc_1566C
                rts
; ---------------------------------------------------------------------------
loc_1565C:                                              ; CODE XREF: Player_HandleAirMovement+44   j
                                        ; Player_HandleAirMovement+4E   j
                btst    #4,$69(a5)
                beq.s   Player_InitWallBounceState
                tst.w   (word_FFA22A).w
                bne.w   Player_InitAirState
loc_1566C:                                              ; CODE XREF: Player_CheckWallCollisionJump+C   j
                btst    #3,$69(a5)
                beq.s   loc_15680
                btst    #3,$E(a5)
                bne.w   Player_InitIdleWallState
                bra.s   Player_InitWallBounceState
; ---------------------------------------------------------------------------
loc_15680:                                              ; CODE XREF: Player_CheckWallCollisionJump+26   j
                btst    #2,$69(a5)
                beq.w   Player_InitAirJumpState
                btst    #3,$E(a5)
                beq.w   Player_InitIdleWallState
; Initializes wall bounce state with velocity and direction flip
Player_InitWallBounceState:                             ; CODE XREF: Player_CheckWallCollisionJump+6   j  ; was: loc_15694
                                        ; Player_CheckWallCollisionJump+16   j
                move.b  #$7F,(byte_FF830F).w
                move.w  #2,4(a5)
                move.w  #4,$48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_CheckWallCollisionJump
nullsub_38:                                             ; CODE XREF: Boss_UpdateHealthBar+18   j
                                        ; Boss_UpdateHealthBar+1E   j
                rts
; End of function nullsub_38

; Updates boss health bar display
