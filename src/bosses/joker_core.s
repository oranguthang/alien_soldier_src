Boss_JokerMain:                                         ; DATA XREF: ROM:off_5DC   o  ; was: sub_3B29E
                tst.w   4(a5)
                beq.w   loc_3B2D6
                tst.w   8(a5)
                beq.s   loc_3B2D6
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3B2C4
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3B2C4
                tst.w   (word_FF8200).w
                beq.w   Boss_JokerFallingInit
loc_3B2C4:                                              ; CODE XREF: Boss_JokerMain+14   j
                                        ; Boss_JokerMain+1C   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
loc_3B2D6:                                              ; CODE XREF: Boss_JokerMain+4   j
                                        ; Boss_JokerMain+C   j
                move.w  4(a5),d0
                movea.w off_3B2E6(pc,d0.w),a0
                adda.l  #Boss_JokerInit,a0
                jmp     (a0)
; End of function Boss_JokerMain
; ---------------------------------------------------------------------------
off_3B2E6:      dc.w    Boss_JokerInit-Boss_JokerInit
                                        ; DATA XREF: Boss_JokerMain+3C   r
                dc.w    Boss_JokerSetup-Boss_JokerInit
                dc.w    Boss_JokerInitTauntState-Boss_JokerInit
                dc.w    Boss_JokerDivePrep-Boss_JokerInit
                dc.w    Boss_JokerDive_ApplyGravity-Boss_JokerInit
                dc.w    Boss_JokerSpinDive-Boss_JokerInit
                dc.w    Boss_JokerStretchState-Boss_JokerInit
                dc.w    Boss_JokerLandingState-Boss_JokerInit
                dc.w    Boss_JokerLandingImpact-Boss_JokerInit
                dc.w    Boss_JokerLandingImpact_FallingPhase-Boss_JokerInit
                dc.w    Boss_JokerLandingImpact_GroundBounce-Boss_JokerInit
                dc.w    Boss_JokerGroundBounceAttack-Boss_JokerInit
                dc.w    Boss_JokerDefeatWait-Boss_JokerInit
                dc.w    Boss_JokerDefeatAnim-Boss_JokerInit
                dc.w    Boss_JokerDefeatAnim_TimerCountdown-Boss_JokerInit
                dc.w    Boss_JokerFallingPhase1-Boss_JokerInit
                dc.w    Boss_JokerFadeOut-Boss_JokerInit
                dc.w    Boss_JokerFadeComplete-Boss_JokerInit
                dc.w    Boss_JokerCleanup-Boss_JokerInit
                dc.w    Boss_JokerTaunt_WaitInterrupt-Boss_JokerInit

; Initializes Joker boss clearing sprites and setting scroll position
Boss_JokerInit:                                         ; DATA XREF: Boss_JokerMain+40   o  ; was: sub_3B30E
                                        ; ROM:off_3B2E6   o
                addq.w  #2,4(a5)
                clr.w   8(a5)
                move.w  (dword_FFA900).w,$48(a5)
                move.w  #4,$4A(a5)
                move.w  #$15C,d0
                moveq   #0,d1
                jsr     (Sprite_ClearAllExcept).l
locret_3B32E:                                           ; CODE XREF: Boss_JokerSetup+4   j
                rts
; End of function Boss_JokerInit
; Sets up Joker boss with metasprites tiles animation and music
Boss_JokerSetup:                                        ; DATA XREF: ROM:0003B2E8   o  ; was: sub_3B330
                tst.w   (word_FFF720).w
                bmi.s   locret_3B32E
                subq.w  #1,$4A(a5)
                bmi.s   loc_3B354
                addi.w  #8,$48(a5)
                move.w  $48(a5),d0
                addi.w  #$158,d0
                move.w  (dword_FFA904).w,d1
                jmp     Gfx_RenderTilemap
; ---------------------------------------------------------------------------
loc_3B354:                                              ; CODE XREF: Boss_JokerSetup+A   j
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$12,d7
                movea.l #dword_35056,a0
                movea.l #word_350A2,a1
                movea.l #word_350B6,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                movea.w #(word_FFCD40-M68K_RAM),a0
                moveq   #0,d0
                moveq   #3,d7
loc_3B382:                                              ; CODE XREF: Boss_JokerSetup+5A   j
                move.w  #$10,(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3B382
                move.w  #$15C,(a5)
                moveq   #0,d0
                bset    d0,2(a5)
                bset    d0,$362(a5)
                bset    d0,$6C2(a5)
                movea.l #word_1BB3C,a1
                jsr     (Sprite_InitFromPointerTable).l
                lea     byte_3B3F8(pc),a0
                nop
                jsr     (Gfx_LoadCompressedTiles).l
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #7,d0
                moveq   #$11,d7
loc_3B3C0:                                              ; CODE XREF: Boss_JokerSetup+98   j
                bset    d0,3(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3B3C0
                move.w  #2,$35C(a5)
                move.w  #$238,$10(a5)
                move.w  #$40,$1DC(a5)                   ; '@'
                move.w  #$10,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.w  #$E,(word_FF8090).w
                move.b  #2,(byte_FFA95B).w
                bra.w   Boss_JokerAttackState
; End of function Boss_JokerSetup
; ---------------------------------------------------------------------------
byte_3B3F8:     dc.b    $61, 0, $20, 0, 3, 2, 0, $40, $41
                                        ; DATA XREF: Boss_JokerSetup+7C   o
                dc.b    0, $45, $44, $42, $43, $48, $3C, $46, $47

; Initializes boss defeat sequence with state and timer setup
Boss_JokerDefeatInit:                                   ; CODE XREF: Boss_JokerStretchState+48   j  ; was: sub_3B40A
                move.w  #$18,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$11C(a5)                   ; '@'
; End of function Boss_JokerDefeatInit
; Defeat sequence timer countdown checking victory condition
Boss_JokerDefeatWait:                                   ; DATA XREF: ROM:0003B2FE   o  ; was: sub_3B420
                subq.w  #1,$11C(a5)
                bpl.w   loc_3B464
                addq.w  #2,4(a5)
                moveq   #5,d0
                jsr     (UI_CheckVictoryCondition).l
; End of function Boss_JokerDefeatWait
; Defeat animation with hitbox adjustment and metasprite flipping
Boss_JokerDefeatAnim:                                   ; DATA XREF: ROM:0003B300   o  ; was: sub_3B434
                tst.w   (word_FF80C2).w
                bne.w   loc_3B464
                addq.w  #2,4(a5)
                move.w  #$40,$11C(a5)                   ; '@'
; Xi-Tiger Joker defeat animation timer
Boss_JokerDefeatAnim_TimerCountdown:                    ; DATA XREF: ROM:0003B302   o  ; was: loc_3B446
                subq.w  #1,$11C(a5)
                bpl.s   loc_3B464
                clr.b   (byte_FF80EC).w
                clr.w   $35C(a5)
                subi.w  #$60,(word_FFA970).w            ; '`'
                addi.w  #$40,(word_FFA974).w            ; '@'
                bra.w   Boss_JokerSelectAttack
; ---------------------------------------------------------------------------
loc_3B464:                                              ; CODE XREF: Boss_JokerDefeatWait+4   j
                                        ; Boss_JokerDefeatAnim+4   j
                lea     word_3BF14(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                move.w  $58(a5),d7
                cmpi.w  #$10,d7
                beq.s   loc_3B47E
                cmpi.w  #4,d7
                bne.s   loc_3B48C
loc_3B47E:                                              ; CODE XREF: Boss_JokerDefeatAnim+42   j
                cmpi.w  #$56,$1DC(a5)                   ; 'V'
                bpl.s   loc_3B498
                addq.w  #2,$1DC(a5)
                bra.s   loc_3B498
; ---------------------------------------------------------------------------
loc_3B48C:                                              ; CODE XREF: Boss_JokerDefeatAnim+48   j
                cmpi.w  #$32,$1DC(a5)                   ; '2'
                bmi.s   loc_3B498
                subq.w  #1,$1DC(a5)
loc_3B498:                                              ; CODE XREF: Boss_JokerDefeatAnim+50   j
                                        ; Boss_JokerDefeatAnim+56   j
                tst.w   $3BC(a5)
                beq.s   loc_3B4BA
                cmpi.w  #8,$58(a5)
                beq.s   loc_3B4AE
                cmpi.w  #$14,$58(a5)
                bne.s   loc_3B4BA
loc_3B4AE:                                              ; CODE XREF: Boss_JokerDefeatAnim+70   j
                eori.w  #$100,$54(a5)
                move.w  $370(a5),$6D0(a5)
loc_3B4BA:                                              ; CODE XREF: Boss_JokerDefeatAnim+68   j
                                        ; Boss_JokerDefeatAnim+78   j
                move.w  #$CCE0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  #$144,$6D4(a5)
                bsr.w   Boss_JokerRenderBody
                move.w  #$144,$374(a5)
                rts
; End of function Boss_JokerDefeatAnim
; Initializes Joker boss falling state after defeat
Boss_JokerFallingInit:                                  ; CODE XREF: Boss_JokerMain+22   j  ; was: sub_3B4D8
                move.w  #4,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                bset    #0,(byte_FFA272).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                clr.w   $29E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $54(a5)
                move.w  #$40,$1DC(a5)                   ; '@'
                clr.l   $18(a5)
                move.l  #$FFFEE000,$1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$80,$11C(a5)
                clr.w   $A(a5)
                bra.s   Boss_JokerFallingPhase1
; End of function Boss_JokerFallingInit
; Boss fade out effect clearing sprites and spawning player
Boss_JokerFadeOut:                                      ; DATA XREF: ROM:0003B306   o  ; was: sub_3B52E
                bsr.w   Gfx_SetFadeLevel
                addq.w  #1,$A(a5)
                cmpi.w  #$20,$A(a5)                     ; ' '
                bmi.s   loc_3B57A
                addq.w  #2,4(a5)
                clr.w   2(a5)
                clr.w   8(a5)
                move.w  #$15C,d0
                moveq   #0,d1
                jsr     (Sprite_ClearAllExcept).l
                move.b  #4,(byte_FFA95A).w
                jsr     (Effect_InitPlayerSpawn).l
                addi.w  #$10,$14(a0)
                rts
; End of function Boss_JokerFadeOut
; First falling phase with palette fade and projectile spawn
Boss_JokerFallingPhase1:                                ; CODE XREF: Boss_JokerFallingInit+54   j  ; was: sub_3B56A
                                        ; DATA XREF: ROM:0003B304   o
                subq.w  #1,$11C(a5)
                bpl.s   loc_3B574
                addq.w  #2,4(a5)
loc_3B574:                                              ; CODE XREF: Boss_JokerFallingPhase1+4   j
                jsr     (Gfx_UpdatePaletteFade).l
loc_3B57A:                                              ; CODE XREF: Boss_JokerFadeOut+E   j
                bsr.w   Boss_JokerSpawnDebris
                move.w  #4,(word_FFA010).w
                addi.l  #$3000,$1C(a5)
                bpl.s   Boss_JokerFallingPhase2
                cmpi.w  #$48,$1DC(a5)                   ; 'H'
                bpl.s   loc_3B5C6
                addi.l  #$18000,$1DC(a5)
                bra.s   loc_3B5C6
; End of function Boss_JokerFallingPhase1
; Second falling phase adjusting descent speed to ground
Boss_JokerFallingPhase2:                                ; CODE XREF: Boss_JokerFallingPhase1+22   j  ; was: sub_3B5A0
                cmpi.w  #$34,$1DC(a5)                   ; '4'
                bmi.s   loc_3B5B0
                subi.l  #$18000,$1DC(a5)
loc_3B5B0:                                              ; CODE XREF: Boss_JokerFallingPhase2+6   j
                cmpi.w  #$120,$14(a5)
                bmi.s   loc_3B5C6
                move.w  #$120,$14(a5)
                move.l  #$FFFCC000,$1C(a5)
loc_3B5C6:                                              ; CODE XREF: Boss_JokerFallingPhase1+2A   j
                                        ; Boss_JokerFallingPhase1+34   j
                lea     word_3BF7E(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   Boss_JokerRenderBody
; End of function Boss_JokerFallingPhase2
; Completes fade out and transitions to final state
Boss_JokerFadeComplete:                                 ; DATA XREF: ROM:0003B308   o  ; was: sub_3B5D4
                subq.w  #2,$A(a5)
                bne.s   loc_3B5E4
                addq.w  #2,4(a5)
                move.w  #$70,$11C(a5)                   ; 'p'
loc_3B5E4:                                              ; CODE XREF: Boss_JokerFadeComplete+4   j
                bra.w   Gfx_SetFadeLevel
; End of function Boss_JokerFadeComplete
; Cleans up Joker boss removing entity and clearing flags
Boss_JokerCleanup:                                      ; DATA XREF: ROM:0003B30A   o  ; was: sub_3B5E8
                subq.w  #1,$11C(a5)
                bpl.s   locret_3B600
                bset    #4,2(a5)
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                clr.b   (word_FFF7E6+1).w
locret_3B600:                                           ; CODE XREF: Boss_JokerCleanup+4   j
                rts
; End of function Boss_JokerCleanup
; Spawns falling debris and explosion sprites during defeat
Boss_JokerSpawnDebris:                                  ; CODE XREF: Boss_JokerFallingPhase1:loc_3B57A   p  ; was: sub_3B602
                jsr     (Projectile_UpdateWithExplosionSound).l
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_3B68C
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                bne.s   loc_3B624
                jsr     (Effect_InitDebrisSprite).l
                bra.w   loc_3B65E
; ---------------------------------------------------------------------------
loc_3B624:                                              ; CODE XREF: Boss_JokerSpawnDebris+16   j
                jsr     (Sprite_InitType160).l
                bset    #7,3(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
                move.l  #off_E953C,8(a0)
                move.w  #$FFFE,$1C(a0)
                btst    #0,(dword_FFFF08).w
                beq.s   loc_3B65E
                move.l  #off_E9604,8(a0)
                clr.w   $1C(a0)
loc_3B65E:                                              ; CODE XREF: Boss_JokerSpawnDebris+1E   j
                                        ; Boss_JokerSpawnDebris+4E   j
                move.b  #0,$20(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$20,d0                         ; ' '
                subi.w  #$12,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_3B68C:                                           ; CODE XREF: Boss_JokerSpawnDebris+C   j
                rts
; End of function Boss_JokerSpawnDebris
; Sets graphics fade level based on counter value
Gfx_SetFadeLevel:                                       ; CODE XREF: Boss_JokerFadeOut   p  ; was: sub_3B68E
                                        ; sub_3B5D4:loc_3B5E4   j
                move.w  $A(a5),d0
                asr.w   #1,d0
                jmp     (Gfx_SetFadeParams).l
; End of function Gfx_SetFadeLevel
; Selects boss attack pattern based on health and RNG value
Boss_JokerSelectAttack:                                 ; CODE XREF: Boss_JokerDefeatAnim+2C   j  ; was: sub_3B69A
                                        ; Boss_JokerInitTauntState+12   j
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  #$C980,$4A(a5)
                move.w  #$144,$374(a5)
                clr.l   $18(a5)
                move.w  #$40,$1DC(a5)                   ; '@'
                tst.w   (word_FF8234).w
                bmi.s   Boss_JokerInitTauntState
                beq.s   Boss_JokerInitTauntState
                jsr     (Physics_CalculateDistanceTo).l
                cmpi.w  #$6A,d0                         ; 'j'
                bpl.s   loc_3B6E8
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.w   Boss_JokerAttackState
                bra.w   Boss_JokerLandingPrep
; ---------------------------------------------------------------------------
loc_3B6E8:                                              ; CODE XREF: Boss_JokerSelectAttack+3C   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                beq.w   Boss_JokerLandingPrep
                bra.w   Boss_JokerAttackState
; End of function Boss_JokerSelectAttack
; Initialize Xi-Tiger Joker boss taunt state with animation
Boss_JokerInitTauntState:                               ; CODE XREF: Boss_JokerSelectAttack+2E   j  ; was: sub_3B6F8
                                        ; Boss_JokerSelectAttack+30   j
                                        ; DATA XREF:
                move.w  #$26,4(a5)                      ; '&'
                move.w  #$30,$11C(a5)                   ; '0'
; Waits for interrupt flag before selecting next attack
Boss_JokerTaunt_WaitInterrupt:                          ; DATA XREF: ROM:0003B30C   o  ; was: loc_3B704
                bclr    #0,(byte_FF8260).w
                bne.w   Boss_JokerSelectAttack
                addi.w  #2,(word_FF8234).w
                lea     word_3BF2E(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   Boss_JokerRenderBody
; End of function Boss_JokerInitTauntState
; Sets Joker boss attack state with collision and animation params
Boss_JokerAttackState:                                  ; CODE XREF: Boss_JokerSetup+C4   j  ; was: sub_3B722
                                        ; Boss_JokerSelectAttack+46   j
                move.w  #$16,$26(a5)
                move.w  #6,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  #$C980,$4A(a5)
                move.w  #$144,$374(a5)
; End of function Boss_JokerAttackState
; Joker boss dive preparation with sound and velocity initialization
Boss_JokerDivePrep:                                     ; DATA XREF: ROM:0003B2EC   o  ; was: sub_3B748
                tst.w   $58(a5)
                bmi.s   loc_3B75C
                lea     word_3BF38(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B75C:                                              ; CODE XREF: Boss_JokerDivePrep+4   j
                move.b  #$44,d0                         ; 'D'
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFEC000,$23C(a5)
                move.l  #$FFFB0000,$1C(a5)
                move.w  #2,(word_FFA010).w
                move.b  #$44,d0                         ; 'D'
                jsr     (Sound_PlaySFX).l
                tst.w   $35C(a5)
                bne.s   loc_3B7A4
                subi.w  #$C,(word_FF8234).w
loc_3B7A4:                                              ; CODE XREF: Boss_JokerDivePrep+54   j
                tst.w   $35C(a5)
                beq.s   loc_3B7B4
                move.l  #$FFFEC000,$18(a5)
                bra.s   Boss_JokerDive_ApplyGravity
; ---------------------------------------------------------------------------
loc_3B7B4:                                              ; CODE XREF: Boss_JokerDivePrep+60   j
                jsr     (Physics_CalculateDistanceTo).l
                move.l  #$10000,d0
                move.w  (dword_FFFF08).w,d0
                tst.w   d1
                bpl.s   loc_3B7CA
                neg.l   d0
loc_3B7CA:                                              ; CODE XREF: Boss_JokerDivePrep+7E   j
                move.l  d0,$18(a5)
; Applies spinning gravity during dive attack sequence
Boss_JokerDive_ApplyGravity:                            ; CODE XREF: Boss_JokerDivePrep+6A   j  ; was: loc_3B7CE
                                        ; DATA XREF: ROM:0003B2EE   o
                bsr.s   Boss_JokerApplySpinGravity
                bpl.s   Boss_JokerDiveComplete
                lea     word_3BF42(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   Boss_JokerRenderBody
; End of function Boss_JokerDivePrep
; Applies spinning gravity acceleration and rotation to boss
Boss_JokerApplySpinGravity:                             ; CODE XREF: Boss_JokerDivePrep:loc_3B7CE   p  ; was: sub_3B7E0
                                        ; sub_3B808   p
                addi.l  #$A00,$23C(a5)
                move.l  $23C(a5),d0
                add.l   d0,$1DC(a5)
                addi.l  #$2000,$1C(a5)
                rts
; End of function Boss_JokerApplySpinGravity
; Completes dive attack transitioning to next phase
Boss_JokerDiveComplete:                                 ; CODE XREF: Boss_JokerDivePrep+88   j  ; was: sub_3B7FA
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; End of function Boss_JokerDiveComplete
; Joker boss spinning dive attack with gravity and projectile spawn
Boss_JokerSpinDive:                                     ; DATA XREF: ROM:0003B2F0   o  ; was: sub_3B808
                bsr.s   Boss_JokerApplySpinGravity
                cmpi.w  #$144,$374(a5)
                bpl.s   loc_3B820
                lea     word_3BF4C(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B820:                                              ; CODE XREF: Boss_JokerSpinDive+8   j
                                        ; Boss_JokerGroundBounceAttack+18   j
                move.w  #$C,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$C980,$4A(a5)
                move.w  #$144,$374(a5)
                clr.l   $1C(a5)
                move.b  #$53,d0                         ; 'S'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_JokerSpawnBomb
; End of function Boss_JokerSpinDive
; Joker boss stretch state adjusting hitbox size dynamically
Boss_JokerStretchState:                                 ; DATA XREF: ROM:0003B2F2   o  ; was: sub_3B84E
                move.w  $58(a5),d0
                bmi.s   loc_3B886
                cmpi.w  #$C,d0
                bmi.s   loc_3B868
                cmpi.w  #$40,$1DC(a5)                   ; '@'
                bpl.s   loc_3B874
                addq.w  #1,$1DC(a5)
                bra.s   loc_3B874
; ---------------------------------------------------------------------------
loc_3B868:                                              ; CODE XREF: Boss_JokerStretchState+A   j
                cmpi.w  #$30,$1DC(a5)                   ; '0'
                bmi.s   loc_3B874
                subq.w  #2,$1DC(a5)
loc_3B874:                                              ; CODE XREF: Boss_JokerStretchState+12   j
                                        ; Boss_JokerStretchState+18   j
                bsr.w   Boss_JokerSlowHorizontal
                lea     word_3BF6C(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B886:                                              ; CODE XREF: Boss_JokerStretchState+4   j
                tst.w   $35C(a5)
                beq.s   loc_3B89A
                cmpi.w  #$190,$10(a5)
                bpl.w   Boss_JokerAttackState
                bra.w   Boss_JokerDefeatInit
; ---------------------------------------------------------------------------
loc_3B89A:                                              ; CODE XREF: Boss_JokerStretchState+3C   j
                bra.w   Boss_JokerSelectAttack
; End of function Boss_JokerStretchState
; Prepares boss landing state after fall setting params
Boss_JokerLandingPrep:                                  ; CODE XREF: Boss_JokerSelectAttack+4A   j  ; was: sub_3B89E
                                        ; Boss_JokerSelectAttack+56   j
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  #$C980,$4A(a5)
                move.w  #$144,$374(a5)
; End of function Boss_JokerLandingPrep
; Boss landing state with screen shake and velocity adjustment
Boss_JokerLandingState:                                 ; DATA XREF: ROM:0003B2F4   o  ; was: sub_3B8BE
                tst.w   $58(a5)
                bmi.s   loc_3B8DA
                subi.l  #$8000,$1DC(a5)
                lea     word_3BF38(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B8DA:                                              ; CODE XREF: Boss_JokerLandingState+4   j
                move.b  #$44,d0                         ; 'D'
                jsr     (Sound_PlaySFX).l
                move.w  #$56,$26(a5)                    ; 'V'
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFF80000,$1C(a5)
                subi.w  #$3E,(word_FF8234).w            ; '>'
                move.w  #2,(word_FFA010).w
                move.b  #$44,d0                         ; 'D'
                jsr     (Sound_PlaySFX).l
; End of function Boss_JokerLandingState
; Handle Xi-Tiger Joker landing impact with ground bounce physics
Boss_JokerLandingImpact:                                ; DATA XREF: ROM:0003B2F6   o  ; was: sub_3B91A
                addi.l  #$2000,$1C(a5)
                addq.w  #2,$1DC(a5)
                move.w  $1DC(a5),d0
                subi.w  #$40,d0                         ; '@'
                asr.w   #1,d0
                add.w   $14(a5),d0
                cmpi.w  #$C8,d0
                bmi.s   loc_3B948
                lea     word_3BF56(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B948:                                              ; CODE XREF: Boss_JokerLandingImpact+1E   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$FFFE0000,$23C(a5)
                clr.l   $1C(a5)
                move.w  #5,(word_FFA010).w
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$16,$26(a5)
; Xi-Tiger Joker falling phase with gravity
Boss_JokerLandingImpact_FallingPhase:                   ; DATA XREF: ROM:0003B2F8   o  ; was: loc_3B978
                addi.l  #$1000,$23C(a5)
                bpl.s   loc_3B98A
                move.l  $23C(a5),d0
                add.l   d0,$1DC(a5)
loc_3B98A:                                              ; CODE XREF: Boss_JokerLandingImpact+66   j
                bsr.w   Boss_JokerCalculateYPosition
                tst.w   $58(a5)
                bmi.s   loc_3B9A2
                lea     word_3BF5C(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B9A2:                                              ; CODE XREF: Boss_JokerLandingImpact+78   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $23C(a5)
; Xi-Tiger Joker ground bounce after landing
Boss_JokerLandingImpact_GroundBounce:                   ; DATA XREF: ROM:0003B2FA   o  ; was: loc_3B9B4
                bsr.s   Boss_JokerUpdateGroundBounce
                cmpi.w  #$40,$1DC(a5)                   ; '@'
                bpl.s   Boss_JokerLandingTransition
                bsr.w   Boss_JokerCalculateYPosition
                lea     word_3BF66(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   Boss_JokerRenderBody
; End of function Boss_JokerLandingImpact
; Update Xi-Tiger Joker vertical position during ground bounce
Boss_JokerUpdateGroundBounce:                           ; CODE XREF: Boss_JokerLandingImpact:loc_3B9B4   p  ; was: sub_3B9D0
                                        ; Boss_JokerGroundBounceAttack+8   p
                addi.l  #$180,$23C(a5)
                move.l  $23C(a5),d0
                add.l   d0,$1DC(a5)
                rts
; End of function Boss_JokerUpdateGroundBounce
; Transition state after Joker boss landing
Boss_JokerLandingTransition:                            ; CODE XREF: Boss_JokerLandingImpact+A2   j  ; was: sub_3B9E2
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; End of function Boss_JokerLandingTransition
; Joker boss ground bounce attack with gravity and rotation
Boss_JokerGroundBounceAttack:                           ; DATA XREF: ROM:0003B2FC   o  ; was: sub_3B9F0
                addi.l  #$280,$23C(a5)
                bsr.s   Boss_JokerUpdateGroundBounce
                addi.l  #$2000,$1C(a5)
                cmpi.w  #$140,$374(a5)
                bpl.w   loc_3B820
                lea     word_3BF4C(pc),a1
                nop
                bsr.w   Boss_JokerUpdateAnimation
                bra.w   *+4
; End of function Boss_JokerGroundBounceAttack
; Renders Joker boss body parts with complex metasprite positioning
