; Update the player through the Seven Forces battle state machine
Player_UpdateSevenForcesBattle:                         ; CODE XREF: Player_Update+46   j  ; was: sub_19DAE
                                        ; Player_UpdateSevenForcesBattleVisible   p
                jsr     (Gfx_LoadPlayerPaletteData).l
                jsr     (Input_ProcessDirectionInput).l
                bclr    #6,$22(a5)
                beq.s   Player_UpdateSevenForcesBattleDispatchState
                bsr.w   Player_EnterSevenForcesDefeatStateA
                bra.s   Player_UpdateSevenForcesBattleClampFallVelocity
; ---------------------------------------------------------------------------
Player_UpdateSevenForcesBattleDispatchState:            ; CODE XREF: Player_UpdateSevenForcesBattle+12   j  ; was: loc_19DC8
                jsr     (Player_UpdateWeaponSwitchTimer).l
                bsr.w   Player_DispatchSevenForcesBattleState
Player_UpdateSevenForcesBattleClampFallVelocity:        ; CODE XREF: Player_UpdateSevenForcesBattle+18   j  ; was: loc_19DD2
                tst.w   $1C(a5)
                bmi.s   Player_UpdateSevenForcesBattleFinalizeFrame
                cmpi.w  #$158,$14(a5)
                bmi.s   Player_UpdateSevenForcesBattleFinalizeFrame
                clr.l   $1C(a5)
Player_UpdateSevenForcesBattleFinalizeFrame:            ; CODE XREF: Player_UpdateSevenForcesBattle+28   j  ; was: loc_19DE4
                                        ; Player_UpdateSevenForcesBattle+30   j
                jsr     (Player_UpdateDirectionBit).l
                move.b  $69(a5),$6B(a5)
                jsr     (Player_UpdateInvulnerabilityTimer).l
                jsr     (Player_SetHitbox).l
                clr.b   (byte_FF8311).w
                jmp     Player_CalculateCenterPosition
; End of function Player_UpdateSevenForcesBattle
; Dispatch the Seven Forces player battle state
Player_DispatchSevenForcesBattleState:                  ; CODE XREF: Player_UpdateSevenForcesBattle+20   p  ; was: sub_19E06
                move.w  4(a5),d0
                movea.w Player_SevenForcesBattleStateOffsets(pc,d0.w),a0
                adda.l  #Player_ResetSevenForcesBattleState,a0
                jmp     (a0)
; End of function Player_DispatchSevenForcesBattleState
; ---------------------------------------------------------------------------
Player_SevenForcesBattleStateOffsets:   dc.w    Player_SevenForcesState0-Player_ResetSevenForcesBattleState  ; was: off_19E16
                                        ; DATA XREF: Player_DispatchSevenForcesBattleState+4   r
                dc.w    Player_SevenForcesState2-Player_ResetSevenForcesBattleState
                dc.w    Player_SevenForcesState4-Player_ResetSevenForcesBattleState
                dc.w    Player_SevenForcesDashState6-Player_ResetSevenForcesBattleState
                dc.w    Player_SevenForcesDamageState8-Player_ResetSevenForcesBattleState
                dc.w    Player_SevenForcesDefeatStateA-Player_ResetSevenForcesBattleState
                dc.w    Player_ResetSevenForcesBattleState-Player_ResetSevenForcesBattleState

; Restore the base Seven Forces player state
Player_ResetSevenForcesBattleState:                     ; CODE XREF: Player_SevenForcesState4+6   j  ; was: sub_19E24
                                        ; Player_SevenForcesState2+22   j
                move.b  #$7F,(PlayerInputMask).w
                bclr    #0,(byte_FF826C).w
                clr.w   (word_FF8224).w
                move.w  #0,4(a5)
                clr.l   $18(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$1C,$5C(a5)
                jmp     Player_AutoFlipDirection
; End of function Player_ResetSevenForcesBattleState
Player_SevenForcesState0Return:                         ; CODE XREF: Player_SevenForcesState0+14   j  ; was: nullsub_51
                                        ; Player_SevenForcesState0+1A   j
                rts
; End of function Player_SevenForcesState0Return

; Base Seven Forces player movement and action state
Player_SevenForcesState0:                               ; DATA XREF: ROM:Player_SevenForcesBattleStateOffsets   o  ; was: sub_19E56
                move.w  #$1C,$5C(a5)
                bsr.w   Player_DampenSevenForcesVelocity
                jsr     (Effect_SpawnParticle).l
                bsr.w   Player_CheckSevenForcesSpecialActivation
                bne.s   Player_SevenForcesState0Return
                bsr.w   Player_TryStartSevenForcesDash
                bne.s   Player_SevenForcesState0Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_EnterSevenForcesDamageState8
                btst    #4,$69(a5)
                beq.s   Player_SevenForcesState0CheckDirectionalInput
                tst.w   (ShootingMode).w
                bne.s   Player_SevenForcesState0Render
Player_SevenForcesState0CheckDirectionalInput:          ; CODE XREF: Player_SevenForcesState0+2C   j  ; was: loc_19E8A
                move.b  $69(a5),d0
                andi.b  #$F,d0
                bne.w   Player_EnterSevenForcesState2
Player_SevenForcesState0Render:                         ; CODE XREF: Player_SevenForcesState0+32   j  ; was: loc_19E96
                bra.w   Player_RenderSevenForcesBattleFrame
; End of function Player_SevenForcesState0
; Check weapon-toggle and state-4 activation input
Player_CheckSevenForcesSpecialActivation:               ; CODE XREF: Player_SevenForcesState0+10   p  ; was: sub_19E9A
                                        ; Player_SevenForcesState2   p
                btst    #6,$6A(a5)
                beq.s   Player_CheckSevenForcesSpecialActivationNotActivated
                btst    #1,$69(a5)
                bne.w   Player_ToggleSevenForcesWeaponMode
                tst.w   (WeaponStateCooldown).w
                bmi.s   Player_ActivateSevenForcesSpecialState4
Player_CheckSevenForcesSpecialActivationNotActivated:   ; CODE XREF: Player_CheckSevenForcesSpecialActivation+6   j  ; was: loc_19EB2
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
Player_ActivateSevenForcesSpecialState4:                ; CODE XREF: Player_CheckSevenForcesSpecialActivation+16   j  ; was: loc_19EB6
                move.w  (WeaponSlotOffset).w,(WeaponSavedSlotOffset).w
                move.w  #$12,(WeaponStateIndex).w
                move.b  #$7F,(PlayerInputMask).w
                move.w  #0,(SpecialMoveSpawnXOffset).w
                move.w  #$FFEE,(SpecialMoveSpawnYOffset).w
                move.w  #4,4(a5)
                move.w  #$1C,$5C(a5)
                moveq   #1,d0
                rts
; End of function Player_CheckSevenForcesSpecialActivation
; State 4: damp movement until the weapon transition completes
Player_SevenForcesState4:                               ; DATA XREF: ROM:00019E1A   o  ; was: sub_19EE4
                cmpi.w  #$12,(WeaponStateIndex).w
                bmi.w   Player_ResetSevenForcesBattleState
                bsr.w   Player_DampenSevenForcesVelocity
                bra.w   Player_RenderSevenForcesTransitionFrame
; End of function Player_SevenForcesState4
; Toggle the selected weapon mode and play its feedback sound
Player_ToggleSevenForcesWeaponMode:                     ; CODE XREF: Player_CheckSevenForcesSpecialActivation+E   j  ; was: sub_19EF6
                move.b  #$7F,(PlayerInputMask).w
                eori.w  #2,(ShootingMode).w
                move.b  #$A3,d0
                jsr     (Sound_PlaySFX).l
                moveq   #0,d0
                rts
; End of function Player_ToggleSevenForcesWeaponMode
; Enter directional-movement state 2
Player_EnterSevenForcesState2:                          ; CODE XREF: Player_SevenForcesState0+3C   j  ; was: sub_19F10
                move.b  #$7F,(PlayerInputMask).w
                move.w  #2,4(a5)
                move.w  #4,$48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$1C,$5C(a5)
                jmp     Player_AutoFlipDirection
; End of function Player_EnterSevenForcesState2
Player_SevenForcesState2Return:                         ; CODE XREF: Player_SevenForcesState2+4   j  ; was: nullsub_52
                                        ; Player_SevenForcesState2+A   j
                rts
; End of function Player_SevenForcesState2Return

; Directional Seven Forces player movement state
Player_SevenForcesState2:                               ; DATA XREF: ROM:00019E18   o  ; was: sub_19F36
                bsr.w   Player_CheckSevenForcesSpecialActivation
                bne.s   Player_SevenForcesState2Return
                bsr.w   Player_TryStartSevenForcesDash
                bne.s   Player_SevenForcesState2Return
                btst    #0,(byte_FF826C).w
                bne.w   Player_EnterSevenForcesDamageState8
                btst    #4,$69(a5)
                beq.s   Player_SevenForcesState2CheckDirectionalInput
                tst.w   (ShootingMode).w
                bne.w   Player_ResetSevenForcesBattleState
Player_SevenForcesState2CheckDirectionalInput:          ; CODE XREF: Player_SevenForcesState2+1C   j  ; was: loc_19F5C
                move.b  $69(a5),d0
                andi.b  #$F,d0
                beq.w   Player_ResetSevenForcesBattleState
                bsr.w   Player_AdjustSevenForcesDirectionalVelocity
                bra.w   Player_RenderSevenForcesBattleFrame
; End of function Player_SevenForcesState2
; Try to start the Seven Forces player dash
Player_TryStartSevenForcesDash:                         ; CODE XREF: Player_SevenForcesState0+16   p  ; was: sub_19F70
                                        ; Player_SevenForcesState2+6   p
                btst    #5,$6A(a5)
                beq.w   Player_TryStartSevenForcesDashReturn
                move.w  #6,4(a5)
                move.b  #$73,(PlayerInputMask).w        ; 's'
                jsr     (Sys_ClearObjectBlocks16).l
                move.b  #$A6,d0
                jsr     (Sound_PlaySFX).l
                move.b  #1,(word_FF8224).w
                move.w  #$C,$50(a5)
                clr.w   $12(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                btst    #2,$69(a5)
                bne.s   Player_StartSevenForcesDashLeft
                btst    #3,$69(a5)
                bne.s   Player_StartSevenForcesDashRight
                btst    #3,$E(a5)
                bne.s   Player_StartSevenForcesDashRight
Player_StartSevenForcesDashLeft:                        ; CODE XREF: Player_TryStartSevenForcesDash+44   j  ; was: loc_19FC6
                move.l  #$FFF88000,$48(a5)
                bclr    #3,$E(a5)
                bra.s   Player_StartSevenForcesDashProjectile
; ---------------------------------------------------------------------------
Player_StartSevenForcesDashRight:                       ; CODE XREF: Player_TryStartSevenForcesDash+4C   j  ; was: loc_19FD6
                                        ; Player_TryStartSevenForcesDash+54   j
                move.l  #$78000,$48(a5)
                bset    #3,$E(a5)
Player_StartSevenForcesDashProjectile:                  ; CODE XREF: Player_TryStartSevenForcesDash+64   j  ; was: loc_19FE4
                tst.w   (word_FF8304).w
                bne.s   Player_StartSevenForcesDashAlternateProjectile
                btst    #7,(byte_FF8245).w
                bne.s   Player_StartSevenForcesDashAlternateProjectile
                jsr     (Player_SpawnProjectile).l
                move.l  #Player_PhoenixAndTeleportDashSpriteMapping,8(a5)
                move.w  #$78,(word_FF8304).w            ; 'x'
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
Player_StartSevenForcesDashAlternateProjectile:         ; CODE XREF: Player_TryStartSevenForcesDash+78   j  ; was: loc_1A00A
                                        ; Player_TryStartSevenForcesDash+80   j
                move.l  #Player_PhoenixDashAttackSpriteMapping,8(a5)
                move.w  #$78,(word_FF8304).w            ; 'x'
                moveq   #1,d0
Player_TryStartSevenForcesDashReturn:                   ; CODE XREF: Player_TryStartSevenForcesDash+6   j  ; was: locret_1A01A
                rts
; End of function Player_TryStartSevenForcesDash
; State 6: update or finish the active dash
Player_SevenForcesDashState6:                           ; DATA XREF: ROM:00019E1C   o  ; was: sub_1A01C
                tst.b   (byte_FF8311).w
                bne.s   Player_EndSevenForcesDash
                subq.w  #1,$50(a5)
                bpl.s   Player_UpdateSevenForcesDash
Player_EndSevenForcesDash:                              ; CODE XREF: Player_SevenForcesDashState6+4   j  ; was: loc_1A028
                clr.w   (PlayerSpecialObjectSlot).w
                bclr    #0,(byte_FF826C).w
                bclr    #6,$21(a5)
                bclr    #4,$23(a5)
                clr.w   (word_FF8224).w
                bra.w   Player_ResetSevenForcesBattleState
; ---------------------------------------------------------------------------
Player_UpdateSevenForcesDash:                           ; CODE XREF: Player_SevenForcesDashState6+A   j  ; was: loc_1A046
                move.w  #1,(word_FF809C).w
                bset    #6,$21(a5)
                bset    #4,$23(a5)
                bsr.s   Player_ApplySevenForcesDashVelocity
                bsr.s   Player_ApplySevenForcesDashVelocity
                bsr.s   Player_ApplySevenForcesDashVelocity
                bset    #4,(byte_FF8244).w
                jmp     Effect_CreateDashTrail
; End of function Player_SevenForcesDashState6
; Apply one horizontal dash-velocity step
Player_ApplySevenForcesDashVelocity:                    ; CODE XREF: Player_SevenForcesDashState6+3C   p  ; was: sub_1A06A
                                        ; Player_SevenForcesDashState6+3E   p
                move.l  $48(a5),d0
                add.l   d0,$10(a5)
                rts
; End of function Player_ApplySevenForcesDashVelocity
; Enter the player damage state with facing-dependent knockback
Player_EnterSevenForcesDamageState8:                    ; CODE XREF: Player_SevenForcesState0+22   j  ; was: sub_1A074
                                        ; Player_SevenForcesState2+12   j
                jsr     (Player_SpawnDamageImpactEffect).l
                move.b  #$7F,(PlayerInputMask).w
                jsr     (Sys_ClearObjectBlocks16).l
                move.w  #8,4(a5)
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$1C,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   Player_EnterSevenForcesDamageStateReturn
                neg.l   $18(a5)
Player_EnterSevenForcesDamageStateReturn:               ; CODE XREF: Player_EnterSevenForcesDamageState8+3E   j  ; was: locret_1A0B8
                rts
; End of function Player_EnterSevenForcesDamageState8
; State 8: animate damage until its timer expires
Player_SevenForcesDamageState8:                         ; DATA XREF: ROM:00019E1E   o  ; was: sub_1A0BA
                subq.w  #1,$4A(a5)
                bmi.w   Player_ResetSevenForcesBattleState
                jmp     Player_AnimateDefeatSprite
; End of function Player_SevenForcesDamageState8
; Enter the player defeat state with encounter-dependent knockback
Player_EnterSevenForcesDefeatStateA:                    ; CODE XREF: Player_UpdateSevenForcesBattle+14   p  ; was: sub_1A0C8
                move.b  #$19,d0
                jsr     (Sound_PlaySFX).l
                move.b  #$7F,(PlayerInputMask).w
                move.w  #$8000,(word_FF80E6).w
                jsr     (Sys_ClearObjectBlocks17).l
                move.w  #$A,4(a5)
                move.w  #$10,$48(a5)
                tst.w   (dword_FF8300).w
                beq.s   Player_SetSevenForcesDefeatVelocityByFacing
                bmi.s   Player_SetSevenForcesDefeatVelocityLeft
                move.l  #$38000,$18(a5)
                rts
; ---------------------------------------------------------------------------
Player_SetSevenForcesDefeatVelocityLeft:                ; CODE XREF: Player_EnterSevenForcesDefeatStateA+2E   j  ; was: loc_1A102
                move.l  #$FFFC8000,$18(a5)
                rts
; ---------------------------------------------------------------------------
Player_SetSevenForcesDefeatVelocityByFacing:            ; CODE XREF: Player_EnterSevenForcesDefeatStateA+2C   j  ; was: loc_1A10C
                move.l  #$FFFC8000,$18(a5)
                btst    #3,$E(a5)
                bne.s   Player_SevenForcesDefeatStateReturn
                neg.l   $18(a5)
Player_SevenForcesDefeatStateReturn:                    ; CODE XREF: Player_EnterSevenForcesDefeatStateA+52   j  ; was: locret_1A120
                                        ; Player_SevenForcesDefeatStateA+1A   j
                rts
; End of function Player_EnterSevenForcesDefeatStateA
; State A: render and time the player defeat animation
Player_SevenForcesDefeatStateA:                         ; DATA XREF: ROM:00019E20   o  ; was: sub_1A122
                movea.l #Player_KnockbackPrimarySpriteMapping,a1
                movea.l #Player_CommonMovementSecondarySpriteMapping,a2
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFF,d6
                jsr     (Player_BuildSpritePieces).l
                subq.w  #1,$48(a5)
                bpl.s   Player_SevenForcesDefeatStateReturn
                clr.w   (word_FF80E6).w
                move.w  #$CC00,2(a5)
                move.b  #$80,$21(a5)
                bra.w   Player_ResetSevenForcesBattleState
; End of function Player_SevenForcesDefeatStateA
; Accelerate the player toward the current directional velocity target
Player_AdjustSevenForcesDirectionalVelocity:            ; CODE XREF: Player_SevenForcesState2+32   p  ; was: sub_1A152
                lea     Player_SevenForcesDirectionalVelocityAngles(pc),a0
                nop
                move.b  $69(a5),d0
                andi.w  #$F,d0
                move.b  (a0,d0.w),d0
                asl.w   #1,d0
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                move.w  d1,d3
                move.w  d2,d4
                muls.w  #$E,d3
                muls.w  #$12,d4
                ext.l   d1
                ext.l   d2
                asl.l   #1,d1
                asl.l   #1,d2
                add.l   $1C(a5),d1
                bpl.s   Player_AdjustSevenForcesPositiveVerticalVelocity
                tst.l   d3
                beq.s   Player_ClampSevenForcesVerticalVelocity
                bpl.s   Player_DampenSevenForcesVerticalVelocity
                cmp.l   d1,d3
                bpl.s   Player_ClampSevenForcesVerticalVelocity
                bra.s   Player_StoreSevenForcesVerticalVelocity
; ---------------------------------------------------------------------------
Player_DampenSevenForcesVerticalVelocity:               ; CODE XREF: Player_AdjustSevenForcesDirectionalVelocity+40   j  ; was: loc_1A19A
                                        ; Player_AdjustSevenForcesDirectionalVelocity+56   j
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$1C(a5)
                bra.s   Player_AdjustSevenForcesHorizontalVelocity
; ---------------------------------------------------------------------------
Player_AdjustSevenForcesPositiveVerticalVelocity:       ; CODE XREF: Player_AdjustSevenForcesDirectionalVelocity+3A   j  ; was: loc_1A1A6
                tst.l   d3
                bmi.s   Player_DampenSevenForcesVerticalVelocity
                cmp.l   d1,d3
                bpl.s   Player_StoreSevenForcesVerticalVelocity
Player_ClampSevenForcesVerticalVelocity:                ; CODE XREF: Player_AdjustSevenForcesDirectionalVelocity+3E   j  ; was: loc_1A1AE
                                        ; Player_AdjustSevenForcesDirectionalVelocity+44   j
                move.l  d3,d1
Player_StoreSevenForcesVerticalVelocity:                ; CODE XREF: Player_AdjustSevenForcesDirectionalVelocity+46   j  ; was: loc_1A1B0
                                        ; Player_AdjustSevenForcesDirectionalVelocity+5A   j
                move.l  d1,$1C(a5)
Player_AdjustSevenForcesHorizontalVelocity:             ; CODE XREF: Player_AdjustSevenForcesDirectionalVelocity+52   j  ; was: loc_1A1B4
                add.l   $18(a5),d2
                bpl.s   Player_AdjustSevenForcesPositiveHorizontalVelocity
                tst.l   d4
                beq.s   Player_ClampSevenForcesHorizontalVelocity
                bpl.s   Player_DampenSevenForcesHorizontalVelocity
                cmp.l   d2,d4
                bpl.s   Player_ClampSevenForcesHorizontalVelocity
                bra.s   Player_StoreSevenForcesHorizontalVelocity
; ---------------------------------------------------------------------------
Player_DampenSevenForcesHorizontalVelocity:             ; CODE XREF: Player_AdjustSevenForcesDirectionalVelocity+6C   j  ; was: loc_1A1C6
                                        ; Player_AdjustSevenForcesDirectionalVelocity+82   j
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
Player_AdjustSevenForcesPositiveHorizontalVelocity:     ; CODE XREF: Player_AdjustSevenForcesDirectionalVelocity+66   j  ; was: loc_1A1D2
                tst.l   d4
                bmi.s   Player_DampenSevenForcesHorizontalVelocity
                cmp.l   d2,d4
                bpl.s   Player_StoreSevenForcesHorizontalVelocity
Player_ClampSevenForcesHorizontalVelocity:              ; CODE XREF: Player_AdjustSevenForcesDirectionalVelocity+6A   j  ; was: loc_1A1DA
                                        ; Player_AdjustSevenForcesDirectionalVelocity+70   j
                move.l  d4,d2
Player_StoreSevenForcesHorizontalVelocity:              ; CODE XREF: Player_AdjustSevenForcesDirectionalVelocity+72   j  ; was: loc_1A1DC
                                        ; Player_AdjustSevenForcesDirectionalVelocity+86   j
                move.l  d2,$18(a5)
                rts
; End of function Player_AdjustSevenForcesDirectionalVelocity
; ---------------------------------------------------------------------------
Player_SevenForcesDirectionalVelocityAngles:    dc.w    $C0, $4000, $80A0, $6000, $E0, $2000, 0, 0  ; was: word_1A1E2
                                        ; DATA XREF: Player_AdjustSevenForcesDirectionalVelocity   o

; Halve both player velocity components
Player_DampenSevenForcesVelocity:                       ; CODE XREF: Player_SevenForcesState0+6   p  ; was: sub_1A1F2
                                        ; Player_SevenForcesState4+A   p
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$1C(a5)
                rts
; End of function Player_DampenSevenForcesVelocity
; Render the ordinary Seven Forces battle frame with an optional weapon overlay
Player_RenderSevenForcesBattleFrame:                    ; CODE XREF: Player_SevenForcesState0Render   j  ; was: sub_1A208
                                        ; Player_SevenForcesState2+36   j
                movea.l #Player_SpecialAttackSecondarySpriteMappingA,a2
                btst    #0,(FrameCounter+1).w
                bne.s   Player_RenderSevenForcesBattleSelectOverlay
                movea.l #Player_SpecialAttackSecondarySpriteMappingB,a2
Player_RenderSevenForcesBattleSelectOverlay:            ; CODE XREF: Player_RenderSevenForcesBattleFrame+C   j  ; was: loc_1A21C
                btst    #4,$69(a5)
                bne.s   Player_RenderSevenForcesBattleWithWeapon
                jsr     (Player_UpdateHorizontalFacing).l
                movea.l #Player_CommonPrimarySpriteMapping,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                jmp     Player_BuildSpritePieces
; ---------------------------------------------------------------------------
Player_RenderSevenForcesBattleWithWeapon:               ; CODE XREF: Player_RenderSevenForcesBattleFrame+1A   j  ; was: loc_1A23A
                lea     (Player_AlternateLayoutMuzzleOffsets0).l,a4
                moveq   #0,d5
                moveq   #$FFFFFFFF,d6
                lea     (Player_AlternateAnimationLayoutTable).l,a0
                jmp     Player_PrepareSpriteRendering_WithTables
; End of function Player_RenderSevenForcesBattleFrame
; Render the fixed player frame used during state-4 transition
Player_RenderSevenForcesTransitionFrame:                ; CODE XREF: Player_SevenForcesState4+E   j  ; was: sub_1A250
                movea.l #Player_SpecialAttackSecondarySpriteMappingA,a2
                btst    #0,(FrameCounter+1).w
                bne.s   Player_RenderSevenForcesTransitionSelectFrame
                movea.l #Player_SpecialAttackSecondarySpriteMappingB,a2
Player_RenderSevenForcesTransitionSelectFrame:          ; CODE XREF: Player_RenderSevenForcesTransitionFrame+C   j  ; was: loc_1A264
                movea.l #Player_CommonPrimarySpriteMapping,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                jmp     Player_BuildSpritePieces
; End of function Player_RenderSevenForcesTransitionFrame
; Update the Seven Forces battle mode and force the display flag
Player_UpdateSevenForcesBattleVisible:                  ; CODE XREF: Player_Update+50   j  ; was: sub_1A274
                bsr.w   Player_UpdateSevenForcesBattle
                bset    #0,2(a5)
                rts
; End of function Player_UpdateSevenForcesBattleVisible
