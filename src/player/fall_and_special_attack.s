Sprite_PositionBossParts:                               ; CODE XREF: Player_CheckDashInput+12   j  ; was: sub_15C66
                bsr.s   Player_EndDashState
                move.l  #$20000,$1C(a5)
                rts
; End of function Sprite_PositionBossParts
; Ends dash attack and transitions to air state
Player_EndDashState:                                    ; CODE XREF: Sprite_PositionBossParts   p  ; was: sub_15C72
                                        ; Player_HandleDashState+12   j
                clr.w   (word_FF8224).w
                clr.w   $52(a5)
; Initializes end of air dash with gravity and velocity setup
Player_InitAirDashEnd:                                  ; CODE XREF: Player_HandleDashCancel+62   j  ; was: loc_15C7A
                bclr    #0,(byte_FF826C).w
                move.w  #$28,4(a5)                      ; '('
                bclr    #4,$E(a5)
                move.w  #$C,$5C(a5)
                move.l  #$12000,$1C(a5)
                move.w  #$FFFF,$48(a5)
                clr.w   $4A(a5)
                move.b  #$7F,(byte_FF830F).w
                rts
; End of function Player_EndDashState
; Player intro state for Gusthead
Player_GustheadBossIntro:                               ; CODE XREF: Player_CheckSpecialMoveActivation+32   p  ; was: sub_15CAC
                bclr    #0,(byte_FF826C).w
                move.w  #$FFE0,$52(a5)
                move.w  #$14,4(a5)
                move.l  #$3A000,$1C(a5)
                move.w  #$C,$5C(a5)
                move.w  #$FFFF,$48(a5)
                move.w  #4,$4A(a5)
                clr.w   (word_FF8224).w
                move.b  #$7F,(byte_FF830F).w
                rts
; End of function Player_GustheadBossIntro
; Handles player falling state with gravity
Player_HandleFallingState:                              ; CODE XREF: Player_DefeatState+2E   j  ; was: sub_15CE4
                                        ; DATA XREF: ROM:00015068   o
                bset    #0,(byte_FF8244).w
                btst    #5,$69(a5)
                bne.s   loc_15CF8
                move.w  #$FFFF,$48(a5)
loc_15CF8:                                              ; CODE XREF: Player_HandleFallingState+C   j
                tst.w   $48(a5)
                bmi.s   loc_15D0A
                subq.w  #1,$48(a5)
                tst.l   $1C(a5)
                bmi.s   loc_15D3A
                bpl.s   loc_15D1E
loc_15D0A:                                              ; CODE XREF: Player_HandleFallingState+18   j
                addi.l  #$8800,$1C(a5)
loc_15D12:                                              ; CODE XREF: Player_HandleDeathSequence+11C   j
                                        ; Player_HandleDeathSequence+128   j
                jsr     Physics_BossTerrainWrapper(pc)  ; (pc)
                nop
                tst.w   $1C(a5)
                bmi.s   loc_15D3A
loc_15D1E:                                              ; CODE XREF: Player_HandleFallingState+24   j
                tst.w   $4A(a5)
                bmi.s   loc_15D2A
                subq.w  #1,$4A(a5)
                bra.s   loc_15D60
; ---------------------------------------------------------------------------
loc_15D2A:                                              ; CODE XREF: Player_HandleFallingState+3E   j
                bsr.w   Player_UpdateTerrainCheck
                btst    #0,6(a5)
                bne.w   Player_InitLandingState
                bra.s   loc_15D60
; ---------------------------------------------------------------------------
loc_15D3A:                                              ; CODE XREF: Player_HandleFallingState+22   j
                                        ; Player_HandleFallingState+38   j
                clr.b   6(a5)
                jsr     Player_TerrainCheckAlternate(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                bne.w   Player_InitiateLanding
                btst    #2,6(a5)
                beq.s   loc_15D60
                btst    #0,$69(a5)
                bne.w   Player_InitHardLanding
loc_15D60:                                              ; CODE XREF: Player_HandleFallingState+44   j
                                        ; Player_HandleFallingState+54   j
                btst    #0,(byte_FF826C).w
                bne.w   Player_InitDeathKnockback
                btst    #5,$6A(a5)
                beq.s   loc_15D8E
                btst    #1,$69(a5)
                bne.s   loc_15D84
                tst.b   (word_FF8224+1).w
                bne.s   loc_15D8E
                bra.w   Player_InitSpecialAttack
; ---------------------------------------------------------------------------
loc_15D84:                                              ; CODE XREF: Player_HandleFallingState+94   j
                tst.b   (word_FF8224).w
                bne.s   loc_15D8E
                bra.w   loc_15936
; ---------------------------------------------------------------------------
loc_15D8E:                                              ; CODE XREF: Player_HandleFallingState+8C   j
                                        ; Player_HandleFallingState+9A   j
                tst.w   $52(a5)
                bne.s   loc_15D9E
                btst    #4,$69(a5)
                bne.w   loc_15DBE
loc_15D9E:                                              ; CODE XREF: Player_HandleFallingState+AE   j
                bsr.w   Player_ApplyAirControl
                move.w  #2,d1
                tst.w   $52(a5)
                bne.w   Player_UpdateAnimationState
                bsr.w   Gfx_DrawBossHealthUI
                bsr.w   Player_SelectFallAnimation
                moveq   #0,d5
                moveq   #0,d6
                bra.w   Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
loc_15DBE:                                              ; CODE XREF: Player_HandleFallingState+B6   j
                btst    #2,$69(a5)
                beq.s   loc_15DF0
loc_15DC6:                                              ; CODE XREF: Player_HandleFallingState+144   j
                move.l  #$FFFC8000,d1
                btst    #3,$E(a5)
                beq.s   loc_15DDA
                move.l  #$FFFD4000,d1
loc_15DDA:                                              ; CODE XREF: Player_HandleFallingState+EE   j
                move.l  $18(a5),d0
                bpl.s   loc_15DE8
                cmp.l   d1,d0
                bpl.s   loc_15DE8
                move.l  d1,d0
                bra.s   loc_15E2A
; ---------------------------------------------------------------------------
loc_15DE8:                                              ; CODE XREF: Player_HandleFallingState+FA   j
                                        ; Player_HandleFallingState+FE   j
                subi.l  #$7777,d0
                bra.s   loc_15E2A
; ---------------------------------------------------------------------------
loc_15DF0:                                              ; CODE XREF: Player_HandleFallingState+E0   j
                btst    #3,$69(a5)
                beq.s   loc_15E22
loc_15DF8:                                              ; CODE XREF: Player_HandleFallingState+142   j
                move.l  #$38000,d1
                btst    #3,$E(a5)
                bne.s   loc_15E0C
                move.l  #$2C000,d1
loc_15E0C:                                              ; CODE XREF: Player_HandleFallingState+120   j
                move.l  $18(a5),d0
                bmi.s   loc_15E1A
                cmp.l   d1,d0
                bmi.s   loc_15E1A
                move.l  d1,d0
                bra.s   loc_15E2A
; ---------------------------------------------------------------------------
loc_15E1A:                                              ; CODE XREF: Player_HandleFallingState+12C   j
                                        ; Player_HandleFallingState+130   j
                addi.l  #$7777,d0
                bra.s   loc_15E2A
; ---------------------------------------------------------------------------
loc_15E22:                                              ; CODE XREF: Player_HandleFallingState+112   j
                move.l  $18(a5),d0
                bmi.s   loc_15DF8
                bne.s   loc_15DC6
loc_15E2A:                                              ; CODE XREF: Player_HandleFallingState+102   j
                                        ; Player_HandleFallingState+10A   j
                move.l  d0,$18(a5)
                bsr.w   Player_SelectFallAnimation
                lea     (word_198D2).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #3,d6
                bra.w   Sprite_PrepareRendering
; End of function Player_HandleFallingState
; Draws boss health UI elements
Gfx_DrawBossHealthUI:                                   ; CODE XREF: Player_HandleFallingState+CA   p  ; was: sub_15E40
                tst.w   $1C(a5)
                bmi.s   loc_15E56
                cmpi.w  #3,$1C(a5)
                bmi.s   loc_15E56
                movea.l #word_E8C9A,a1
                rts
; ---------------------------------------------------------------------------
loc_15E56:                                              ; CODE XREF: Gfx_DrawBossHealthUI+4   j
                                        ; Gfx_DrawBossHealthUI+C   j
                movea.l #word_E8C82,a1
                rts
; End of function Gfx_DrawBossHealthUI
; Selects animation based on falling velocity
Player_SelectFallAnimation:                             ; CODE XREF: Player_HandleFallingState+CE   p  ; was: sub_15E5E
                                        ; Player_HandleFallingState+14A   p
                move.w  $1C(a5),d0
                bpl.s   loc_15E66
                neg.w   d0
loc_15E66:                                              ; CODE XREF: Player_SelectFallAnimation+4   j
                cmpi.w  #7,d0
                bpl.s   loc_15E80
                cmpi.w  #2,d0
                bmi.s   loc_15E80
                tst.w   $1C(a5)
                bmi.s   loc_15E88
                movea.l #word_E8C6A,a2
                rts
; ---------------------------------------------------------------------------
loc_15E80:                                              ; CODE XREF: Player_SelectFallAnimation+C   j
                                        ; Player_SelectFallAnimation+12   j
                movea.l #word_E8C2A,a2
                rts
; ---------------------------------------------------------------------------
loc_15E88:                                              ; CODE XREF: Player_SelectFallAnimation+18   j
                movea.l #word_E8C52,a2
                rts
; End of function Player_SelectFallAnimation
; Initializes hard landing state with terrain alignment and downward velocity
Player_InitHardLanding:                                 ; CODE XREF: Player_HandleFallingState+78   j  ; was: sub_15E90
                jsr     (Physics_AlignToTerrain).l
                move.w  #$12,4(a5)
                move.l  #$FFF86000,$1C(a5)
                clr.l   $18(a5)
                move.w  #6,$52(a5)
                move.b  #$7F,(byte_FF830F).w
                rts
; End of function Player_InitHardLanding
; Handles bounce state with gravity and terrain collision checks
Player_HandleBounceState:                               ; DATA XREF: ROM:00015074   o  ; was: sub_15EB6
                bset    #0,(byte_FF8244).w
                addi.l  #$8800,$1C(a5)
                jsr     Physics_BossTerrainWrapper(pc)  ; (pc)
                nop
                tst.w   $1C(a5)
                bmi.s   loc_15EE0
                bsr.w   Player_UpdateTerrainCheck
                btst    #0,6(a5)
                bne.w   Player_InitLandingState
                bra.s   loc_15EF4
; ---------------------------------------------------------------------------
loc_15EE0:                                              ; CODE XREF: Player_HandleBounceState+18   j
                clr.b   6(a5)
                jsr     Player_TerrainCheckAlternate(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                bne.w   Player_InitiateLanding
loc_15EF4:                                              ; CODE XREF: Player_HandleBounceState+28   j
                cmpi.w  #$38,$52(a5)                    ; '8'
                bpl.w   Player_InitFallState
                moveq   #2,d1
                bra.w   Anim_SelectFrameData
; End of function Player_HandleBounceState
; Applies horizontal air control input
Player_ApplyAirControl:                                 ; CODE XREF: Player_HandleFallingState:loc_15D9E   p  ; was: sub_15F04
                btst    #2,$69(a5)
                beq.s   loc_15F30
                bclr    #3,$E(a5)
                move.l  $18(a5),d0
                bpl.s   loc_15F28
                cmpi.l  #$FFFC8000,d0
                bpl.s   loc_15F28
                move.l  #$FFFC8000,d0
                bra.s   Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
loc_15F28:                                              ; CODE XREF: Player_ApplyAirControl+12   j
                                        ; Player_ApplyAirControl+1A   j
                subi.l  #$7777,d0
                bra.s   Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
loc_15F30:                                              ; CODE XREF: Player_ApplyAirControl+6   j
                btst    #3,$69(a5)
                beq.s   loc_15F5C
                bset    #3,$E(a5)
                move.l  $18(a5),d0
                bmi.s   loc_15F54
                cmpi.l  #$38000,d0
                bmi.s   loc_15F54
                move.l  #$38000,d0
                bra.s   Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
loc_15F54:                                              ; CODE XREF: Player_ApplyAirControl+3E   j
                                        ; Player_ApplyAirControl+46   j
                addi.l  #$7777,d0
                bra.s   Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
loc_15F5C:                                              ; CODE XREF: Player_ApplyAirControl+32   j
                move.l  $18(a5),d0
                bmi.s   loc_15F54
                bne.s   loc_15F28
; Applies calculated horizontal velocity to player position
Player_ApplyHorizontalVelocity:                         ; CODE XREF: Player_ApplyAirControl+22   j  ; was: loc_15F64
                                        ; Player_ApplyAirControl+2A   j
                move.l  d0,$18(a5)
                rts
; End of function Player_ApplyAirControl
; Initializes special attack state
Player_InitSpecialAttack:                               ; CODE XREF: Player_HandleFallingState+9C   j  ; was: sub_15F6A
                bclr    #0,(byte_FF826C).w
                move.b  #$7F,(byte_FF830F).w
                move.w  #$4E,4(a5)                      ; 'N'
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
                move.l  #$FFFE8000,$1C(a5)
                move.w  #$C,$5C(a5)
                move.w  #$FFFF,$48(a5)
                clr.w   $4A(a5)
                move.w  #5,$4C(a5)
                move.b  #1,(word_FF8224+1).w
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                moveq   #7,d7
                jsr     (Sys_ClearObjectBlocks96).l
                move.b  #$B0,d0
                jsr     (Sound_PlaySFX).l
                bra.w   Player_SpawnTripleShot
; End of function Player_InitSpecialAttack
; Handles special attack state logic
Player_HandleSpecialAttack:                             ; DATA XREF: ROM:000150B0   o  ; was: sub_15FC4
                subq.w  #1,$4C(a5)
                bpl.s   loc_15FE0
                move.w  #$46,4(a5)                      ; 'F'
                clr.l   $18(a5)
                clr.l   $1C(a5)
                bsr.w   Player_AutoFlipDirection
                bra.w   Effect_UpdateParticles
; ---------------------------------------------------------------------------
loc_15FE0:                                              ; CODE XREF: Player_HandleSpecialAttack+4   j
                bset    #0,(byte_FF8244).w
                bset    #6,(byte_FF8244).w
                jsr     Physics_BossTerrainWrapper(pc)  ; (pc)
                nop
                addi.l  #$C000,$1C(a5)
                bmi.s   loc_16010
                clr.b   6(a5)
                bsr.w   Player_UpdateTerrainCheck
                btst    #0,6(a5)
                bne.w   Player_InitLandingState
                bra.s   loc_16022
; ---------------------------------------------------------------------------
loc_16010:                                              ; CODE XREF: Player_HandleSpecialAttack+36   j
                clr.b   6(a5)
                bsr.w   Player_TerrainCheckAlternate
                btst    #1,6(a5)
                bne.w   Player_InitiateLanding
loc_16022:                                              ; CODE XREF: Player_HandleSpecialAttack+4A   j
                btst    #0,(byte_FF826C).w
                bne.w   Player_InitDeathKnockback
                btst    #5,$6A(a5)
                beq.s   loc_16056
                tst.b   (word_FF8224).w
                bne.s   loc_16044
                btst    #1,$69(a5)
                bne.w   loc_15936
loc_16044:                                              ; CODE XREF: Player_HandleSpecialAttack+74   j
                move.l  #$FFF80000,$1C(a5)
                move.w  #$FFE0,$52(a5)
                bra.w   loc_15C3C
; ---------------------------------------------------------------------------
loc_16056:                                              ; CODE XREF: Player_HandleSpecialAttack+6E   j
                movea.l #word_E8F3A,a2
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1606A
                movea.l #word_E8F6A,a2
loc_1606A:                                              ; CODE XREF: Player_HandleSpecialAttack+9E   j
                btst    #4,$69(a5)
                bne.w   Player_RenderDeathEffect
                bsr.w   Player_UpdateHorizontalFacing
                movea.l #word_E8972,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                bra.w   Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
; Renders death effect particles using animation data
Player_RenderDeathEffect:                               ; CODE XREF: Player_HandleSpecialAttack+AC   j  ; was: loc_16086
                lea     (word_198B2).l,a4
                moveq   #0,d5
                moveq   #$FFFFFFFF,d6
                lea     off_172F8(pc),a0
                nop
                bra.w   loc_1727A
; End of function Player_HandleSpecialAttack
; Updates particle effects for explosions
