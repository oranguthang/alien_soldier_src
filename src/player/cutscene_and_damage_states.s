Effect_UpdateParticles:                                 ; CODE XREF: Player_HandleSpecialAttack+18   j  ; was: sub_1609A
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
                bne.w   Player_InitiateLanding
                bsr.w   Effect_SpawnDebris
                bne.w   nullsub_40
                btst    #0,(byte_FF826C).w
                bne.w   Player_InitDeathKnockback
                btst    #5,$6A(a5)
                beq.s   Player_CheckSpecialAttack
                tst.b   (word_FF8224).w
                bne.s   loc_160FA
                btst    #1,$69(a5)
                bne.w   loc_15936
loc_160FA:                                              ; CODE XREF: Effect_UpdateParticles+54   j
                move.l  #$FFF80000,$1C(a5)
                bra.s   loc_1610C
; End of function Effect_UpdateParticles
; Sets upward velocity for air recovery
Player_InitAirRecovery:
                move.l  #$FFFD8000,$1C(a5)              ; was: sub_16104
loc_1610C:                                              ; CODE XREF: Effect_UpdateParticles+68   j
                move.w  #$FFE0,$52(a5)
                bra.w   loc_15C3C
; End of function Player_InitAirRecovery
; Checks if player can use special attack
Player_CheckSpecialAttack:                              ; CODE XREF: Effect_UpdateParticles+4E   j  ; was: sub_16116
                movea.l #word_E8F3A,a2
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1612A
                movea.l #word_E8F6A,a2
loc_1612A:                                              ; CODE XREF: Player_CheckSpecialAttack+C   j
                btst    #4,$69(a5)
                bne.w   loc_16146
                bsr.w   Player_UpdateHorizontalFacing
                movea.l #word_E8972,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                bra.w   Player_BuildSpritePieces
; ---------------------------------------------------------------------------
loc_16146:                                              ; CODE XREF: Player_CheckSpecialAttack+1A   j
                lea     (word_198B2).l,a4
                moveq   #0,d5
                moveq   #$FFFFFFFF,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                bra.w   Player_PrepareSpriteRendering_WithTables
; End of function Player_CheckSpecialAttack
nullsub_40:                                             ; CODE XREF: Effect_UpdateParticles+3A   j
                rts
; End of function nullsub_40

; Spawns debris particles from boss damage
Effect_SpawnDebris:                                     ; CODE XREF: Effect_UpdateParticles+36   p  ; was: sub_1615C
                btst    #6,$6A(a5)
                beq.s   loc_1617A
                btst    #1,$69(a5)
                beq.s   loc_16174
                bsr.w   Player_ToggleDirectionFlag
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_16174:                                              ; CODE XREF: Effect_SpawnDebris+E   j
                tst.w   (word_FF8038).w
                bmi.s   Player_InitVictoryState
loc_1617A:                                              ; CODE XREF: Effect_SpawnDebris+6   j
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
; Initializes victory state with palette change and position setup
Player_InitVictoryState:                                ; CODE XREF: Effect_SpawnDebris+1C   j  ; was: loc_1617E
                move.w  (word_FFA24E).w,(word_FFA220).w
                move.w  #$12,(word_FFA21C).w
                move.b  #$7F,(byte_FF830F).w
                move.w  #0,(word_FF8032).w
                move.w  #$FFEE,(word_FF8034).w
                move.w  #$54,4(a5)                      ; 'T'
                moveq   #1,d0
                rts
; End of function Effect_SpawnDebris
; Handles player state during boss defeat sequence
Player_HandleBossVictory:                               ; DATA XREF: ROM:000150B6   o  ; was: sub_161A6
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
                bne.w   Player_InitiateLanding
                cmpi.w  #$12,(word_FFA21C).w
                bpl.s   loc_161EE
                move.w  #$46,4(a5)                      ; 'F'
                bsr.w   Player_AutoFlipDirection
loc_161EE:                                              ; CODE XREF: Player_HandleBossVictory+3C   j
                movea.l #word_E8F3A,a2
                btst    #0,(word_FFA000+1).w
                bne.s   loc_16202
                movea.l #word_E8F6A,a2
loc_16202:                                              ; CODE XREF: Player_HandleBossVictory+54   j
                movea.l #word_E8972,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                bra.w   Player_BuildSpritePieces
; End of function Player_HandleBossVictory
; Initializes player cutscene state clearing velocities and flags
Player_InitCutsceneState:                               ; CODE XREF: Player_Update+72   p  ; was: sub_16210
                move.b  #$7F,(byte_FF830F).w
                move.w  #$8000,(word_FF80E6).w
                move.w  #$32,4(a5)                      ; '2'
                move.b  #$80,$21(a5)
                move.w  #4,$5C(a5)
                clr.w   $48(a5)
                clr.w   $4A(a5)
                clr.w   $52(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                bset    #1,(byte_FF825C).w
                rts
; End of function Player_InitCutsceneState
; Handles cutscene player control with timer and position management
Player_HandleCutsceneControl:                           ; DATA XREF: ROM:00015094   o  ; was: sub_1624A
                                        ; ROM:00015096   o
                bset    #3,(byte_FF8244).w
                bclr    #0,(byte_FF825C).w
                bne.s   loc_1625C
                bra.w   loc_1629E
; ---------------------------------------------------------------------------
loc_1625C:                                              ; CODE XREF: Player_HandleCutsceneControl+C   j
                bclr    #2,(byte_FF825C).w
                bne.s   loc_16286
                move.b  $6A(a5),d0
                andi.b  #$2C,d0                         ; ','
                beq.s   loc_16272
                addq.w  #1,$4A(a5)
loc_16272:                                              ; CODE XREF: Player_HandleCutsceneControl+22   j
                move.w  (word_FF824E).w,d0
                cmp.w   $4A(a5),d0
                bpl.s   loc_16286
                bclr    #1,(byte_FF825C).w
                bra.w   loc_1629E
; ---------------------------------------------------------------------------
loc_16286:                                              ; CODE XREF: Player_HandleCutsceneControl+18   j
                                        ; Player_HandleCutsceneControl+30   j
                bset    #1,(byte_FF825C).w
                move.w  (word_FF8250).w,$10(a5)
                move.w  (word_FF8252).w,$14(a5)
                moveq   #$FFFFFFFE,d1
                bra.w   Player_AdvanceAnimationFrame
; ---------------------------------------------------------------------------
loc_1629E:                                              ; CODE XREF: Player_HandleCutsceneControl+E   j
                                        ; Player_HandleCutsceneControl+38   j
                move.b  #$30,(byte_FF825D).w            ; '0'
                bra.w   *+4
; End of function Player_HandleCutsceneControl
; Initializes player knockback/damaged state with sound and velocity
Player_InitKnockbackState:                              ; CODE XREF: Player_Update+64   p  ; was: sub_162A8
                                        ; Player_HandleCutsceneControl+5A   j
                move.b  #$7F,(byte_FF830F).w
                bclr    #4,$E(a5)
                move.w  #$8000,(word_FF80E6).w
                jsr     (Sys_ClearObjectBlocks17).l
                move.w  #$2A,4(a5)                      ; '*'
                move.w  #$C,$48(a5)
                tst.w   $5E(a5)
                bpl.s   loc_16312
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_162E6
                move.b  #$19,d0
                jsr     (Sound_PlaySFX).l
loc_162E6:                                              ; CODE XREF: Player_InitKnockbackState+32   j
                move.l  #$FFFEA000,$1C(a5)
                tst.l   (dword_FF8300).w
                beq.s   loc_162FC
loc_162F4:                                              ; CODE XREF: Player_InitKnockbackState+80   j
                move.l  (dword_FF8300).w,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_162FC:                                              ; CODE XREF: Player_InitKnockbackState+4A   j
                move.l  #$FFFF7000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_16310
                neg.l   $18(a5)
locret_16310:                                           ; CODE XREF: Player_InitKnockbackState+62   j
                rts
; ---------------------------------------------------------------------------
loc_16312:                                              ; CODE XREF: Player_InitKnockbackState+28   j
                move.b  #$19,d0
                jsr     (Sound_PlaySFX).l
                move.l  #$FFFE8000,$1C(a5)
                tst.w   (dword_FF8300).w
                bne.w   loc_162F4
                bra.s   Player_SetKnockbackVelocity
; End of function Player_InitKnockbackState
; Sets horizontal knockback velocity
Player_SetHorizontalKnockback:
                bmi.s   loc_1633A                       ; was: sub_1632E
                move.l  #$38000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_1633A:                                              ; CODE XREF: Player_SetHorizontalKnockback   j
                move.l  #$FFFC8000,$18(a5)
                rts
; End of function Player_SetHorizontalKnockback
; Sets player horizontal knockback velocity based on facing direction
Player_SetKnockbackVelocity:                            ; CODE XREF: Player_InitKnockbackState+84   j  ; was: sub_16344
                move.l  #$FFFC8000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_16358
                neg.l   $18(a5)
locret_16358:                                           ; CODE XREF: Player_SetKnockbackVelocity+E   j
                rts
; End of function Player_SetKnockbackVelocity
; Player death/defeat state handling gravity and landing detection
Player_DefeatState:                                     ; DATA XREF: ROM:0001508C   o  ; was: sub_1635A
                movea.l #word_E8BAA,a1
                movea.l #word_E89C2,a2
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFF,d6
                bsr.w   Player_BuildSpritePieces
                subq.w  #1,$48(a5)
                bpl.s   loc_1638C
                bsr.w   Player_ClearKnockbackState
                bsr.w   Player_InitFallState
                move.b  #1,(word_FF8224).w
                move.b  #1,(word_FF8224+1).w
                bra.w   Player_HandleFallingState
; ---------------------------------------------------------------------------
loc_1638C:                                              ; CODE XREF: Player_DefeatState+18   j
                addi.l  #$6000,$1C(a5)
                bsr.w   Physics_ExtendedWallCheckWrapper
                tst.w   $1C(a5)
                bmi.s   loc_163B2
                bsr.w   Physics_DescendingTerrainCheckWrapper
                btst    #0,6(a5)
                beq.s   locret_163BC
                bsr.w   Player_ClearKnockbackState
                bra.w   Player_InitLandingState
; ---------------------------------------------------------------------------
loc_163B2:                                              ; CODE XREF: Player_DefeatState+42   j
                clr.b   6(a5)
                jmp     Physics_RisingTerrainCheckWrapper(pc)  ; (pc)
; End of function Player_DefeatState
; Empty function that returns
Player_NoOp:
                nop                                     ; was: sub_163BA
locret_163BC:                                           ; CODE XREF: Player_DefeatState+4E   j
                rts
; End of function Player_NoOp
; Clears player knockback flag and resets sprite state after hit
Player_ClearKnockbackState:                             ; CODE XREF: Player_DefeatState+1A   p  ; was: sub_163BE
                                        ; Player_DefeatState+50   p
                clr.w   (word_FF80E6).w
                move.w  #$CD00,2(a5)
                move.b  #$81,$21(a5)
                rts
; End of function Player_ClearKnockbackState
nullsub_41:
                rts
; End of function nullsub_41

; Initializes player landing state after air
Player_InitGroundedState:                               ; CODE XREF: Player_HandleAirDashState+1A   j  ; was: sub_163D2
                                        ; Player_ProcessAirState+66   j
                move.b  #$7F,(byte_FF830F).w
                bclr    #0,(byte_FF826C).w
                clr.w   (word_FF8224).w
                move.w  #$18,4(a5)
                clr.l   $18(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
                bra.w   Player_AutoFlipDirection
; End of function Player_InitGroundedState
nullsub_42:                                             ; CODE XREF: Player_HandleDashState+1E   j
                                        ; Player_HandleDashState+24   j
                rts
; End of function nullsub_42

; Main handler for player dash state with counter and input checks
Player_HandleDashState:                                 ; DATA XREF: ROM:0001507A   o  ; was: sub_16402
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                jsr     Physics_UpperTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_EndDashState
                bsr.w   Effect_SpawnParticle
                bsr.w   Player_CheckCounterInput
                bne.s   nullsub_42
                bsr.w   Player_CheckDashInput
                bne.s   nullsub_42
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                btst    #4,$69(a5)
                beq.s   loc_16440
                tst.w   (word_FFA22A).w
                bne.s   loc_1645E
loc_16440:                                              ; CODE XREF: Player_HandleDashState+36   j
                btst    #0,$69(a5)
                bne.w   Player_InitDashState
                btst    #2,$69(a5)
                bne.w   Player_InitWallKickState
                btst    #3,$69(a5)
                bne.w   Player_InitWallKickState
loc_1645E:                                              ; CODE XREF: Player_HandleDashState+3C   j
                btst    #4,$69(a5)
                beq.w   Player_ProcessCollisionDamage
                bra.w   Player_UpdateDashSprite
; ---------------------------------------------------------------------------
loc_1646C:                                              ; CODE XREF: Player_HandleDashState+2C   j
                                        ; Player_ProcessAirState+3E   j
                bsr.w   Player_SpawnDamageImpactEffect
                move.b  #$7F,(byte_FF830F).w
                jsr     (Sys_ClearObjectBlocks16).l
                move.w  #$3E,4(a5)                      ; '>'
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_164AE
                neg.l   $18(a5)
locret_164AE:                                           ; CODE XREF: Player_HandleDashState+A6   j
                rts
; End of function Player_HandleDashState
; Handles player air dash state with terrain check
Player_HandleAirDashState:                              ; DATA XREF: ROM:000150A0   o  ; was: sub_164B0
                jsr     Physics_WallCheckWrapper(pc)    ; (pc)
                nop
                jsr     Physics_UpperTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                beq.w   Player_SetDeathStateFlags
                subq.w  #1,$4A(a5)
                bmi.w   Player_InitGroundedState
                move.l  #$2000,d1
                bsr.w   Player_DecelerateHorizontalVelocity
                bra.w   Player_AnimateDefeatSprite
; End of function Player_HandleAirDashState
; Updates weapon charge from input
