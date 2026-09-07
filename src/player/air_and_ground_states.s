Player_UpdateWeaponCharge:
                btst    #5,$6A(a5)                      ; was: sub_164DC
                beq.s   locret_164FA
                btst    #0,$69(a5)
                beq.s   locret_164FA
                move.w  (word_FFA216).w,d0
                sub.w   (word_FFA218).w,d0
                move.w  d0,(word_FF8304).w
                moveq   #1,d0
locret_164FA:                                           ; CODE XREF: Player_UpdateWeaponCharge+6   j
                                        ; Player_UpdateWeaponCharge+E   j
                rts
; End of function Player_UpdateWeaponCharge
; Initializes player dash state with animation and counter setup
Player_InitDashState:                                   ; CODE XREF: Player_HandleDashState+44   j  ; was: sub_164FC
                                        ; Player_HandleCrouchState+32   j
                move.w  #2,$48(a5)
; Initializes dash animation with timer and direction flip
Player_InitDashAnimation:                               ; CODE XREF: Player_HandleDashCancel+88   j  ; was: loc_16502
                                        ; Player_HandleSlideState+38   j
                move.w  #$22,4(a5)                      ; '"'
                bset    #4,$E(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$14,$5C(a5)
                move.b  #$7F,(byte_FF830F).w
                bra.w   Player_AutoFlipDirection
; End of function Player_InitDashState
nullsub_43:                                             ; CODE XREF: Player_ProcessAirState+20   j
                rts
; End of function nullsub_43

; Processes player state while airborne
Player_ProcessAirState:                                 ; DATA XREF: ROM:00015084   o  ; was: sub_1652C
                bset    #1,(byte_FF8244).w
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                jsr     Player_TerrainCheckStandard(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Player_CheckCounterInput
                bne.s   nullsub_43
                btst    #5,$6A(a5)
                beq.s   loc_16564
                btst    #0,$69(a5)
                beq.w   Player_EndDashState
                bra.w   Player_InitiateDashAttack
; ---------------------------------------------------------------------------
loc_16564:                                              ; CODE XREF: Player_ProcessAirState+28   j
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                bsr.w   Player_ApplyKnockbackVelocity
                subq.w  #1,$48(a5)
                bpl.s   Player_CheckGroundTransition
                move.w  #$FFFF,$48(a5)
                btst    #4,$69(a5)
                beq.s   loc_1658C
                tst.w   (word_FFA22A).w
                bne.s   Player_CheckGroundTransition
loc_1658C:                                              ; CODE XREF: Player_ProcessAirState+58   j
                btst    #0,$69(a5)
                beq.w   Player_InitGroundedState
; Checks conditions for transitioning to grounded state
Player_CheckGroundTransition:                           ; CODE XREF: Player_ProcessAirState+4A   j  ; was: loc_16596
                                        ; Player_ProcessAirState+5E   j
                btst    #4,$69(a5)
                beq.w   Player_HandleDefeatByBoss
                bra.w   Player_RenderWithWeapon
; End of function Player_ProcessAirState
; Initializes player crouch state
Player_InitCrouchState:                                 ; CODE XREF: Player_ProcessJumpState+68   j  ; was: sub_165A4
                                        ; Player_InitWallKickState+3A   j
                move.b  #$7F,(byte_FF830F).w
                clr.w   (word_FF8224).w
                move.w  #$1E,4(a5)
                clr.w   $48(a5)
                move.w  #$10,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_InitCrouchState
; Main crouch state handler with input checks
Player_HandleCrouchState:                               ; DATA XREF: ROM:00015080   o  ; was: sub_165C2
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                jsr     Player_TerrainCheckStandard(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Player_CheckCounterInput
                bne.s   locret_16638
                bsr.w   Player_CheckDashInput
                bne.s   locret_16638
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                btst    #0,$69(a5)
                bne.w   Player_InitDashState
                bsr.w   Player_ApplyKnockbackVelocity
                move.l  $18(a5),d0
                bne.s   Player_SelectCrouchAnimation
                btst    #2,$69(a5)
                bne.w   loc_16792
                btst    #3,$69(a5)
                bne.w   loc_16792
                bra.w   Player_InitGroundedState
; ---------------------------------------------------------------------------
; Selects appropriate crouch/defeat animation based on state
Player_SelectCrouchAnimation:                           ; CODE XREF: Player_HandleCrouchState+3E   j  ; was: loc_1661A
                btst    #4,$69(a5)
                bne.w   loc_17132
                movea.l #word_E8972,a1
                movea.l #word_E89C2,a2
                moveq   #0,d5
                moveq   #6,d6
                bra.w   Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
locret_16638:                                           ; CODE XREF: Player_HandleCrouchState+1A   j
                                        ; Player_HandleCrouchState+20   j
                rts
; End of function Player_HandleCrouchState
; Initializes player landing recovery state
Player_InitiateLanding:                                 ; CODE XREF: Player_HandleFallingState+66   j  ; was: sub_1663A
                                        ; Player_HandleBounceState+3A   j
                move.b  #$7F,(byte_FF830F).w
                clr.w   (word_FF8224).w
                move.w  #$26,4(a5)                      ; '&'
                bset    #4,$E(a5)
                move.w  #2,$48(a5)
                move.w  #6,$4A(a5)
                move.w  #$14,$5C(a5)
                move.b  #$B1,d0
                jsr     (Sound_PlaySFX).l
                bra.w   Player_AutoFlipDirection
; End of function Player_InitiateLanding
; Processes player state during jump
Player_ProcessJumpState:                                ; DATA XREF: ROM:00015088   o  ; was: sub_16670
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                jsr     Player_TerrainCheckStandard(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Player_CheckCounterInput
                bne.s   locret_16638
                bsr.w   Player_CheckDashInput
                bne.s   locret_16638
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                move.l  #$4000,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                subq.w  #1,$4A(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_166DC
                btst    #0,$69(a5)
                beq.s   loc_166C4
                bsr.w   Player_InitDashState
                move.w  #$FFFF,$48(a5)
                bra.s   loc_166DC
; ---------------------------------------------------------------------------
loc_166C4:                                              ; CODE XREF: Player_ProcessJumpState+46   j
                btst    #2,$69(a5)
                bne.w   loc_16792
                btst    #3,$69(a5)
                bne.w   loc_16792
                bra.w   Player_InitCrouchState
; ---------------------------------------------------------------------------
loc_166DC:                                              ; CODE XREF: Player_ProcessJumpState+3E   j
                                        ; Player_ProcessJumpState+52   j
                btst    #4,$69(a5)
                beq.w   Player_HandleDefeatByBoss
                bra.w   Player_RenderWithWeapon
; End of function Player_ProcessJumpState
; Checks controller input for counter/parry activation
Player_CheckCounterInput:                               ; CODE XREF: Player_HandleDashState+1A   p  ; was: sub_166EA
                                        ; Player_ProcessAirState+1C   p
                btst    #6,$6A(a5)
                beq.s   loc_16702
                btst    #0,$69(a5)
                bne.w   Player_ToggleScreenSide
                tst.w   (word_FF8038).w
                bmi.s   loc_16706
loc_16702:                                              ; CODE XREF: Player_CheckCounterInput+6   j
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_16706:                                              ; CODE XREF: Player_CheckCounterInput+16   j
                move.w  (word_FFA24E).w,(word_FFA220).w
                move.w  #$12,(word_FFA21C).w
                move.b  #$7F,(byte_FF830F).w
                move.w  #0,(word_FF8032).w
                move.w  #0,(word_FF8034).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$20,4(a5)                      ; ' '
                move.w  #$10,$5C(a5)
                btst    #0,$69(a5)
                beq.s   loc_16746
                move.w  #$14,$5C(a5)
loc_16746:                                              ; CODE XREF: Player_CheckCounterInput+54   j
                moveq   #1,d0
                rts
; End of function Player_CheckCounterInput
; Checks dash counter and transitions to grounded or damage state
Player_CheckDashCounter:                                ; DATA XREF: ROM:00015082   o  ; was: sub_1674A
                cmpi.w  #$12,(word_FFA21C).w
                bmi.w   Player_InitGroundedState
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                jsr     Player_TerrainCheckStandard(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bra.w   Player_ProcessCollisionDamage
; End of function Player_CheckDashCounter
; Toggles player screen side flag with sound effect
Player_ToggleScreenSide:                                ; CODE XREF: Player_CheckCounterInput+E   j  ; was: sub_1676E
                eori.w  #2,(word_FFA22A).w
                move.b  #$A3,d0
                jsr     (Sound_PlaySFX).l
                moveq   #0,d0
                rts
; End of function Player_ToggleScreenSide
; Initializes wall kick state from button input
Player_InitWallKickState:                               ; CODE XREF: Player_HandleDashState+4E   j  ; was: sub_16782
                                        ; Player_HandleDashState+58   j
                btst    #4,$69(a5)
                beq.s   Player_InitWallKickAnimation
                tst.w   (word_FFA22A).w
                beq.s   loc_167A2
                rts
; ---------------------------------------------------------------------------
loc_16792:                                              ; CODE XREF: Player_HandleCrouchState+46   j
                                        ; Player_HandleCrouchState+50   j
                btst    #4,$69(a5)
                beq.s   Player_InitWallKickAnimation
                tst.w   (word_FFA22A).w
                bne.w   Player_InitGroundedState
loc_167A2:                                              ; CODE XREF: Player_InitWallKickState+C   j
                btst    #3,$69(a5)
                beq.s   loc_167B6
                btst    #3,$E(a5)
                bne.w   loc_16878
                bra.s   Player_InitWallKickAnimation
; ---------------------------------------------------------------------------
loc_167B6:                                              ; CODE XREF: Player_InitWallKickState+26   j
                btst    #2,$69(a5)
                beq.w   Player_InitCrouchState
                btst    #3,$E(a5)
                beq.w   loc_16878
; Initializes wall kick animation with timer and direction flip
Player_InitWallKickAnimation:                           ; CODE XREF: Player_InitWallKickState+6   j  ; was: loc_167CA
                                        ; Player_InitWallKickState+16   j
                move.b  #$7F,(byte_FF830F).w
                move.w  #$1A,4(a5)
                move.w  #4,$48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_InitWallKickState
nullsub_44:                                             ; CODE XREF: Sound_PlayBossHitSound+1A   j
                                        ; Sound_PlayBossHitSound+20   j
                rts
; End of function nullsub_44

; Plays sound effect for boss taking damage
Sound_PlayBossHitSound:                                 ; DATA XREF: ROM:0001507C   o  ; was: sub_167EE
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                jsr     Player_TerrainCheckStandard(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Player_CheckCounterInput
                bne.s   nullsub_44
                bsr.w   Player_CheckDashInput
                bne.s   nullsub_44
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                btst    #0,$69(a5)
                bne.w   Player_InitDashState
                btst    #4,$69(a5)
                beq.s   loc_16834
                tst.w   (word_FFA22A).w
                bne.w   Player_InitCrouchState
loc_16834:                                              ; CODE XREF: Sound_PlayBossHitSound+3C   j
                btst    #2,$69(a5)
                bne.s   loc_16846
                btst    #3,$69(a5)
                beq.w   Player_InitCrouchState
loc_16846:                                              ; CODE XREF: Sound_PlayBossHitSound+4C   j
                bsr.w   Physics_ApplyVerticalDecel
                btst    #4,$69(a5)
                beq.w   Boss_AnimateDeathSequence
                btst    #3,$69(a5)
                beq.s   loc_1686A
                btst    #3,$E(a5)
                beq.w   loc_16878
                bra.w   Player_RenderDashSprite
; ---------------------------------------------------------------------------
loc_1686A:                                              ; CODE XREF: Sound_PlayBossHitSound+6C   j
                btst    #3,$E(a5)
                bne.w   loc_16878
                bra.w   Player_RenderDashSprite
; ---------------------------------------------------------------------------
loc_16878:                                              ; CODE XREF: Player_InitWallKickState+2E   j
                                        ; Player_InitWallKickState+44   j
                move.w  #$1C,4(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
locret_1688E:                                           ; CODE XREF: Player_AirControlState+1A   j
                                        ; Player_AirControlState+20   j
                rts
; End of function Sound_PlayBossHitSound
; Handles player air control state with terrain checks and dash/counter inputs during aerial movement
Player_AirControlState:                                 ; DATA XREF: ROM:0001507E   o  ; was: sub_16890
                jsr     Physics_EntityTerrainWrapper(pc)  ; (pc)
                nop
                jsr     Player_TerrainCheckStandard(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Player_CheckCounterInput
                bne.s   locret_1688E
                bsr.w   Player_CheckDashInput
                bne.s   locret_1688E
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                btst    #0,$69(a5)
                bne.w   Player_InitDashState
                btst    #4,$69(a5)
                beq.w   Player_InitWallKickAnimation
                bsr.w   Player_RenderWeaponSprite
                btst    #2,$69(a5)
                beq.s   loc_168EA
                btst    #3,$E(a5)
                beq.w   Player_InitWallKickAnimation
                bra.w   Physics_ApplyDownwardGravity
; ---------------------------------------------------------------------------
loc_168EA:                                              ; CODE XREF: Player_AirControlState+4A   j
                btst    #3,$69(a5)
                beq.w   Player_InitCrouchState
                btst    #3,$E(a5)
                bne.w   Player_InitWallKickAnimation
                bra.w   Physics_ApplyUpwardGravity
; End of function Player_AirControlState
; Updates aim direction from D-pad
Player_UpdateAimDirection:                              ; DATA XREF: ROM:000150AA   o  ; was: sub_16902
                bset    #4,$E(a5)
                btst    #2,(word_FFF706).w
                beq.s   loc_16918
                bclr    #3,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_16918:                                              ; CODE XREF: Player_UpdateAimDirection+C   j
                btst    #3,(word_FFF706).w
                beq.s   locret_16926
                bset    #3,$E(a5)
locret_16926:                                           ; CODE XREF: Player_UpdateAimDirection+1C   j
                rts
; End of function Player_UpdateAimDirection
; Attributes: thunk
; Updates force weapon sprite
Player_UpdateForceWeapon:                               ; DATA XREF: ROM:000150AC   o  ; was: sub_16928
                bra.w   Player_InitGroundedState
; End of function Player_UpdateForceWeapon
; Handles jump apex for fall transition
Player_JumpApexState:                                   ; DATA XREF: ROM:000150AE   o  ; was: sub_1692C
                addi.l  #$8800,$1C(a5)
                bpl.w   Player_InitFallState
                bclr    #4,$E(a5)
                bra.w   loc_16EF8
; End of function Player_JumpApexState
; Player dash effect during teleport
Player_TeleportDash:                                    ; DATA XREF: ROM:000150B2   o  ; was: sub_16942
                clr.w   (word_FF80E6).w
                move.b  #$70,(byte_FF830F).w            ; 'p'
                bset    #0,(byte_FF8245).w
                move.w  #$CD00,2(a5)
                addq.w  #2,4(a5)
                clr.w   $48(a5)
                jsr     (Memory_ClearBlock).l
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
                move.l  #word_E8F22,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                eori.w  #$1000,$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  #$E0,d0
                jsr     (Sound_PlaySFX).l
                move.l  #word_E8E6A,8(a5)
; Applies velocity during player teleport dash
Player_TeleportDash_ApplyVelocity:                      ; DATA XREF: ROM:000150B4   o  ; was: loc_169E0
                tst.w   $48(a5)
                bne.w   loc_16A0E
                subi.l  #$620,$1C(a5)
                subi.l  #$C00,$18(a5)
                bset    #6,$21(a5)
                bset    #4,$23(a5)
                bset    #4,(byte_FF8244).w
                bra.w   Effect_CreateDashTrail
; ---------------------------------------------------------------------------
loc_16A0E:                                              ; CODE XREF: Player_TeleportDash+A2   j
                bclr    #6,$21(a5)
                bclr    #4,$23(a5)
                jsr     (Memory_ClearBlock).l
                bclr    #0,(byte_FF8245).w
                move.w  #$FFE0,$52(a5)
                move.l  #$68000,$18(a5)
                move.w  #$FFFF,$1C(a5)
                bra.w   loc_15C3C
; End of function Player_TeleportDash
; Spawns projectile type 2
Boss_ArtemisSpawnProjectile2:                           ; DATA XREF: ROM:000150BA   o  ; was: sub_16A3E
                moveq   #4,d1
                bra.w   Player_UpdateAnimationState
; End of function Boss_ArtemisSpawnProjectile2
; Updates animation state with -4 offset
Player_UpdateAnimStateMinus4:                           ; DATA XREF: ROM:000150BC   o  ; was: sub_16A44
                moveq   #$FFFFFFFC,d1
                bra.w   Player_UpdateAnimationState
; End of function Player_UpdateAnimStateMinus4
; VBlank handler for credits
Credits_VBlankHandler:                                  ; DATA XREF: ROM:000150BE   o  ; was: sub_16A4A
                addq.w  #2,4(a5)
                move.b  #$70,(byte_FF830F).w            ; 'p'
                bset    #0,(byte_FF8245).w
                move.w  #$CD00,2(a5)
                jsr     (Memory_ClearBlock).l
                move.w  #$120,$10(a5)
                move.w  #$100,$14(a5)
                bset    #3,$E(a5)
                bclr    #4,$E(a5)
                move.l  #word_E8E6A,8(a5)
; Updates sprite graphics during teleport dash
Player_TeleportDash_UpdateSprite:                       ; DATA XREF: ROM:000150C0   o  ; was: loc_16A86
                bset    #4,$23(a5)
                move.l  #word_E8EBA,8(a5)
                btst    #0,(word_FFA000+1).w
                bne.w   locret_16AA6
                move.l  #word_E8E6A,8(a5)
locret_16AA6:                                           ; CODE XREF: Credits_VBlankHandler+50   j
                rts
; End of function Credits_VBlankHandler
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
                bmi.s   locret_16B02
                subq.w  #1,$48(a5)
                bne.s   loc_16AFC
                move.w  #1,(word_FF8230).w
                move.w  #$8002,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
loc_16AFC:                                              ; CODE XREF: Player_HandleInvulnerabilityTimer+10   j
                jmp     Effect_SpawnPlayerDeathSpark
; ---------------------------------------------------------------------------
locret_16B02:                                           ; CODE XREF: Player_HandleInvulnerabilityTimer+A   j
                rts
; End of function Player_HandleInvulnerabilityTimer
; Reads controller input into player state bytes
