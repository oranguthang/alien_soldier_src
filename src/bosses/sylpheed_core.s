Boss_SylpheedIntroStop:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_593D4
                tst.w   4(a5)
                beq.w   loc_59432
                tst.w   8(a5)
                beq.s   loc_59432
                btst    #2,(byte_FF80EC).w
                bne.s   loc_59400
                btst    #1,(byte_FF80EC).w
                bne.s   loc_59400
                tst.w   (word_FF8200).w
                bne.s   loc_59400
                moveq   #6,d0
                jmp     Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_59400:                                              ; CODE XREF: Boss_SylpheedIntroStop+14   j
                                        ; Boss_SylpheedIntroStop+1C   j
                lea     (word_3E4C).l,a2
                jsr     (Gfx_ProcessColorFade).l
                moveq   #$24,d0                         ; '$'
                jsr     (Boss_ValkirieUpdatePalette).l
                cmpi.w  #$1E0,$10(a5)
                bmi.s   loc_59424
                move.w  #$1DF,$10(a5)
                bra.s   loc_59432
; ---------------------------------------------------------------------------
loc_59424:                                              ; CODE XREF: Boss_SylpheedIntroStop+46   j
                cmpi.w  #$A0,$10(a5)
                bpl.s   loc_59432
                move.w  #$A1,$10(a5)
loc_59432:                                              ; CODE XREF: Boss_SylpheedIntroStop+4   j
                                        ; Boss_SylpheedIntroStop+C   j
                move.w  4(a5),d0
                movea.w off_59442(pc,d0.w),a0
                adda.l  #Boss_SylpheedBattleStart,a0
                jmp     (a0)
; End of function Boss_SylpheedIntroStop
; ---------------------------------------------------------------------------
off_59442:      dc.w    Boss_SylpheedBattleStart-Boss_SylpheedBattleStart
                                        ; DATA XREF: Boss_SylpheedIntroStop+62   r
                dc.w    Boss_SylpheedState2-Boss_SylpheedBattleStart
                dc.w    Boss_Sirene_AltState9-Boss_SylpheedBattleStart
                dc.w    Boss_Sirene_AltState11-Boss_SylpheedBattleStart
                dc.w    Boss_SylpheedFlashDamage-Boss_SylpheedBattleStart
                dc.w    Boss_SylpheedJumpRising-Boss_SylpheedBattleStart
                dc.w    Boss_SylpheedJumpFalling-Boss_SylpheedBattleStart
                dc.w    Boss_SylpheedDiveRecovery-Boss_SylpheedBattleStart
                dc.w    Boss_SylpheedClimbPattern-Boss_SylpheedBattleStart
                dc.w    Boss_Artemis_AltState2-Boss_SylpheedBattleStart
                dc.w    Boss_Artemis_AltState3-Boss_SylpheedBattleStart
                dc.w    Boss_SylpheedShootPattern1-Boss_SylpheedBattleStart
                dc.w    Boss_SylpheedShootPattern2-Boss_SylpheedBattleStart
                dc.w    Boss_Sirene_AltState6-Boss_SylpheedBattleStart
                dc.w    Boss_Sirene_AltState7-Boss_SylpheedBattleStart

; Battle start initialization
Boss_SylpheedBattleStart:                               ; DATA XREF: Boss_SylpheedIntroStop+66   o  ; was: sub_59460
                                        ; ROM:off_59442   o
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$1A,d7
                movea.l #off_5A024,a0
                movea.l #word_5A090,a1
                movea.l #word_5A0AC,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A0E2,$2FC(a5)
                move.l  #word_59C9C,$35C(a5)
                move.w  #$444,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  $14(a0),$14(a5)
                move.l  $18(a0),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  $1C(a0),$1C(a5)
                move.w  #2,$1DE(a5)
                bra.w   Boss_SylpheedIdleState
; End of function Boss_SylpheedBattleStart
; Initializes Sylpheed boss state, sets position, timers, and health values
Boss_SylpheedStateInit:
                move.w  #2,4(a5)                        ; was: sub_594D0
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$1B58,(word_FF8200).w
                move.w  #$1B58,(word_FF8202).w
                clr.w   (word_FFA02A).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$80,$11C(a5)
; End of function Boss_SylpheedStateInit
; Sylpheed boss state 2 handler, loads animation script and branches to attack state
Boss_SylpheedState2:                                    ; DATA XREF: ROM:00059444   o  ; was: sub_59512
                lea     word_59C26(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; End of function Boss_SylpheedState2
; Idle state handler
Boss_SylpheedIdleState:                                 ; CODE XREF: Boss_SylpheedBattleStart+6C   j  ; was: sub_5951C
                move.w  #$12,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  (dword_FFDC58).w,$18(a5)
                move.l  (dword_FFDC5C).w,$1C(a5)
                move.w  #$FFE0,$50(a5)
                move.w  #$80,$56(a5)
                move.w  #$120,$3BC(a5)
                move.w  #$2E,(word_FFA02A).w            ; '.'
; Artemis boss alternate health bar update
Boss_Artemis_AltState2:                                 ; DATA XREF: ROM:00059454   o  ; was: loc_5954E
                cmpi.w  #$10,$14(a5)
                bmi.s   loc_59576
                addq.w  #1,$50(a5)
                bmi.s   loc_59560
                clr.w   $50(a5)
loc_59560:                                              ; CODE XREF: Boss_SylpheedIdleState+3E   j
                subi.l  #$1000,$1C(a5)
                bsr.w   Boss_SylpheedAttackState1
                lea     word_59C30(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_59576:                                              ; CODE XREF: Boss_SylpheedIdleState+38   j
                addq.w  #2,4(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #0,$14(a5)
                move.w  #$7000,(word_FF8200).w
                move.w  #$7000,(word_FF8202).w
                clr.w   $50(a5)
                move.w  #$180,$56(a5)
                move.w  #$40,$11C(a5)                   ; '@'
; Artemis boss alternate score rendering
Boss_Artemis_AltState3:                                 ; DATA XREF: ROM:00059456   o  ; was: loc_595A4
                subq.w  #1,$11C(a5)
                bmi.s   loc_595B4
                lea     word_59C30(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_595B4:                                              ; CODE XREF: Boss_SylpheedIdleState+8C   j
                addq.w  #2,4(a5)
                move.l  #$38000,$1C(a5)
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_SylpheedIdleState
; Shooting pattern 1
Boss_SylpheedShootPattern1:                             ; DATA XREF: ROM:00059458   o  ; was: sub_595CA
                move.w  (dword_FFA410).w,$10(a5)
                move.w  (dword_FFA414).w,d0
                subi.w  #$20,d0                         ; ' '
                cmp.w   $14(a5),d0
                bmi.w   loc_595EA
                lea     word_59C30(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_595EA:                                              ; CODE XREF: Boss_SylpheedShootPattern1+12   j
                addq.w  #2,4(a5)
                clr.l   $1C(a5)
                move.b  #1,(byte_FFA958).w
                bclr    #4,(word_FFA40E).w
                move.w  #$80,$11C(a5)
                move.b  #$2B,d0                         ; '+'
                jsr     (Sound_PlaySFX).l
; End of function Boss_SylpheedShootPattern1
; Shooting pattern 2
Boss_SylpheedShootPattern2:                             ; DATA XREF: ROM:0005945A   o  ; was: sub_5960E
                subq.w  #1,$11C(a5)
                bmi.w   Boss_SylpheedAnimationScript
                bsr.w   Boss_SylpheedShootPattern3
                bsr.w   Boss_SylpheedShootPattern4
                move.w  $10(a5),(dword_FFA410).w
                move.w  $14(a5),d0
                addi.w  #$20,d0                         ; ' '
                move.w  d0,(dword_FFA414).w
                clr.l   (dword_FFA41C).w
                lea     word_59C30(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; End of function Boss_SylpheedShootPattern2
; Shooting pattern 3
Boss_SylpheedShootPattern3:                             ; CODE XREF: Boss_SylpheedShootPattern2+8   p  ; was: sub_5963E
                cmpi.w  #$100,$10(a5)
                beq.s   locret_59668
                bpl.s   loc_59656
                addq.w  #4,$10(a5)
                cmpi.w  #$120,$10(a5)
                bpl.s   loc_59662
                rts
; ---------------------------------------------------------------------------
loc_59656:                                              ; CODE XREF: Boss_SylpheedShootPattern3+8   j
                subq.w  #4,$10(a5)
                cmpi.w  #$120,$10(a5)
                bpl.s   locret_59668
loc_59662:                                              ; CODE XREF: Boss_SylpheedShootPattern3+14   j
                move.w  #$120,$10(a5)
locret_59668:                                           ; CODE XREF: Boss_SylpheedShootPattern3+6   j
                                        ; Boss_SylpheedShootPattern3+22   j
                rts
; End of function Boss_SylpheedShootPattern3
; Shooting pattern 4
Boss_SylpheedShootPattern4:                             ; CODE XREF: Boss_SylpheedShootPattern2+C   p  ; was: sub_5966A
                cmpi.w  #$100,$14(a5)
                beq.s   locret_59694
                bpl.s   loc_59682
                addq.w  #2,$14(a5)
                cmpi.w  #$100,$14(a5)
                bpl.s   loc_5968E
                rts
; ---------------------------------------------------------------------------
loc_59682:                                              ; CODE XREF: Boss_SylpheedShootPattern4+8   j
                subq.w  #2,$14(a5)
                cmpi.w  #$100,$14(a5)
                bpl.s   locret_59694
loc_5968E:                                              ; CODE XREF: Boss_SylpheedShootPattern4+14   j
                move.w  #$100,$14(a5)
locret_59694:                                           ; CODE XREF: Boss_SylpheedShootPattern4+6   j
                                        ; Boss_SylpheedShootPattern4+22   j
                rts
; End of function Boss_SylpheedShootPattern4
; Animation script interpreter
Boss_SylpheedAnimationScript:                           ; CODE XREF: Boss_SylpheedShootPattern2+4   j  ; was: sub_59696
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   (word_FFA02A).w
                bset    #0,(byte_FF8144).w
                clr.w   (word_FFA404).w
                move.b  #$20,(byte_FFA420).w            ; ' '
                move.l  #$FFFF0000,$18(a5)
                move.l  #$28000,$1C(a5)
; Sirene boss alternate weapon display
Boss_Sirene_AltState6:                                  ; DATA XREF: ROM:0005945C   o  ; was: loc_596CC
                addi.l  #$1000,$18(a5)
                subi.l  #$1000,$1C(a5)
                subi.w  #8,$56(a5)
                bmi.s   loc_596EE
                lea     word_59C42(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_596EE:                                              ; CODE XREF: Boss_SylpheedAnimationScript+4C   j
                addq.w  #2,4(a5)
                move.w  #$160,$3BC(a5)
                move.w  #$F0,$3BE(a5)
                movea.l #word_1BFB0,a1
                jsr     (Sprite_InitFromPointerTable).l
                move.w  #$40,$11C(a5)                   ; '@'
; Sirene boss alternate counter update
Boss_Sirene_AltState7:                                  ; DATA XREF: ROM:0005945E   o  ; was: loc_59710
                subq.w  #1,$11C(a5)
                bpl.s   loc_5972A
                clr.b   (byte_FF80EC).w
                bclr    #0,(byte_FFA272).w
                move.w  #4,4(a5)
                bra.w   loc_5975E
; ---------------------------------------------------------------------------
loc_5972A:                                              ; CODE XREF: Boss_SylpheedAnimationScript+7E   j
                bsr.w   Boss_SylpheedAnimationUpdate
                lea     word_59C42(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; End of function Boss_SylpheedAnimationScript
; Sylpheed boss idle waiting state, counts down timer and checks player conditions
Boss_SylpheedIdleWait:                                  ; CODE XREF: Boss_SylpheedJumpFalling+4   j  ; was: sub_59738
                                        ; Boss_SylpheedClimbPattern+4   j
                move.w  #$60,$11E(a5)                   ; '`'
                tst.w   (word_FFFF0E).w
                beq.s   loc_5974A
                move.w  #$40,$11E(a5)                   ; '@'
loc_5974A:                                              ; CODE XREF: Boss_SylpheedIdleWait+A   j
                                        ; Boss_SylpheedFlashDamage+4   j
                move.w  #4,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_5975E:                                              ; CODE XREF: Boss_SylpheedAnimationScript+90   j
                move.w  #$160,$3BC(a5)
                move.w  #$F0,$3BE(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                addi.w  #$10,d0
                move.w  d0,$11C(a5)
; Sirene boss alternate health bar
Boss_Sirene_AltState9:                                  ; DATA XREF: ROM:00059446   o  ; was: loc_5977A
                subq.w  #1,$11E(a5)
                bpl.s   loc_597B4
                move.w  #$FFFF,$11E(a5)
                tst.w   (word_FFFF0E).w
                beq.s   loc_59794
                cmpi.w  #$2858,(word_FF8200).w
                bmi.s   loc_597A0
loc_59794:                                              ; CODE XREF: Boss_SylpheedIdleWait+52   j
                btst    #2,(byte_FF8244).w
                beq.s   loc_597A0
                bra.w   loc_597C2
; ---------------------------------------------------------------------------
loc_597A0:                                              ; CODE XREF: Boss_SylpheedIdleWait+5A   j
                                        ; Boss_SylpheedIdleWait+62   j
                subq.w  #1,$11C(a5)
                bpl.s   loc_597B4
                btst    #0,(dword_FFFF08).w
                beq.w   Boss_SylpheedJumpAttackInit
                bra.w   Boss_SylpheedDiveSetup
; ---------------------------------------------------------------------------
loc_597B4:                                              ; CODE XREF: Boss_SylpheedIdleWait+46   j
                                        ; Boss_SylpheedIdleWait+6C   j
                bsr.w   Boss_SylpheedDefeatInit
                lea     word_59C54(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_597C2:                                              ; CODE XREF: Boss_SylpheedIdleWait+64   j
                move.w  #6,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$2C000,$18(a5)
; Sirene boss alternate timer display
Boss_Sirene_AltState11:                                 ; DATA XREF: ROM:00059448   o  ; was: loc_597DA
                tst.w   $58(a5)
                bmi.w   loc_597F4
                subi.l  #$1800,$18(a5)
                lea     word_59C66(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_597F4:                                              ; CODE XREF: Boss_SylpheedIdleWait+A6   j
                addq.w  #2,4(a5)
                move.w  #$60,$11C(a5)                   ; '`'
                move.w  #$1D0,$3BC(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$F1,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_SylpheedIdleWait
; Flash effect on damage
Boss_SylpheedFlashDamage:                               ; DATA XREF: ROM:0005944A   o  ; was: sub_59818
                subq.w  #1,$11C(a5)
                bmi.w   loc_5974A
                btst    #2,(byte_FF8244).w
                beq.s   loc_5982E
                move.w  #$60,$11C(a5)                   ; '`'
loc_5982E:                                              ; CODE XREF: Boss_SylpheedFlashDamage+E   j
                bsr.w   Boss_SylpheedDefeatInit
                lea     word_59C42(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; End of function Boss_SylpheedFlashDamage
; Initializes Sylpheed jump attack, sets upward velocity and plays jump sound
Boss_SylpheedJumpAttackInit:                            ; CODE XREF: Boss_SylpheedIdleWait+74   j  ; was: sub_5983C
                move.w  #$A,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$18000,$18(a5)
                move.l  #$C000,$1C(a5)
                move.b  #$DC,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_SylpheedJumpAttackInit
; Handles Sylpheed rising jump movement with gravity deceleration
Boss_SylpheedJumpRising:                                ; DATA XREF: ROM:0005944C   o  ; was: sub_59866
                tst.w   $58(a5)
                bmi.w   loc_59888
                subi.l  #$1C00,$18(a5)
                subi.l  #$E00,$1C(a5)
                lea     word_59C6C(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_59888:                                              ; CODE XREF: Boss_SylpheedJumpRising+4   j
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_SylpheedJumpRising
; Handles Sylpheed falling after jump, accelerates downward until landing
Boss_SylpheedJumpFalling:                               ; DATA XREF: ROM:0005944E   o  ; was: sub_598A4
                tst.w   $58(a5)
                bmi.w   Boss_SylpheedIdleWait
                addi.l  #$1E00,$18(a5)
                addi.l  #$1600,$1C(a5)
                lea     word_59C76(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; End of function Boss_SylpheedJumpFalling
; Sets up dive attack parameters with velocity and plays dive sound effect
Boss_SylpheedDiveSetup:                                 ; CODE XREF: Boss_SylpheedIdleWait+78   j  ; was: sub_598C6
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$18000,$18(a5)
                move.l  #$FFFF4000,$1C(a5)
                move.b  #$DC,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_SylpheedDiveSetup
; Handles dive recovery phase with upward velocity adjustment
Boss_SylpheedDiveRecovery:                              ; DATA XREF: ROM:00059450   o  ; was: sub_598F0
                tst.w   $58(a5)
                bmi.w   loc_59912
                subi.l  #$1C00,$18(a5)
                addi.l  #$1200,$1C(a5)
                lea     word_59C84(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_59912:                                              ; CODE XREF: Boss_SylpheedDiveRecovery+4   j
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_SylpheedDiveRecovery
; Handles climbing pattern with velocity changes and attack state transitions
Boss_SylpheedClimbPattern:                              ; DATA XREF: ROM:00059452   o  ; was: sub_5992E
                tst.w   $58(a5)
                bmi.w   Boss_SylpheedIdleWait
                addi.l  #$1E00,$18(a5)
                subi.l  #$1600,$1C(a5)
                lea     word_59C8E(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; End of function Boss_SylpheedClimbPattern
; Defeat sequence initialization
Boss_SylpheedDefeatInit:                                ; CODE XREF: Boss_SylpheedIdleWait:loc_597B4   p  ; was: sub_59950
                                        ; sub_59818:loc_5982E   p
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   Boss_SylpheedAnimationUpdate
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                move.w  d0,$41E(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                move.w  d0,$41C(a5)
; End of function Boss_SylpheedDefeatInit
; Animation frame update
Boss_SylpheedAnimationUpdate:                           ; CODE XREF: Boss_SylpheedAnimationScript:loc_5972A   p  ; was: sub_5997A
                                        ; Boss_SylpheedDefeatInit+8   j
                move.w  $3BE(a5),d1
                add.w   $41E(a5),d1
                move.w  $14(a5),d0
                cmp.w   d1,d0
                bmi.s   loc_599A4
                tst.w   $1C(a5)
                bpl.s   loc_5999A
                cmpi.l  #$FFFF0000,$1C(a5)
                bmi.s   Boss_SylpheedAttackState1
loc_5999A:                                              ; CODE XREF: Boss_SylpheedAnimationUpdate+14   j
                subi.l  #$1000,$1C(a5)
                bra.s   Boss_SylpheedAttackState1
; ---------------------------------------------------------------------------
loc_599A4:                                              ; CODE XREF: Boss_SylpheedAnimationUpdate+E   j
                tst.w   $1C(a5)
                bmi.s   loc_599B4
                cmpi.l  #$10000,$1C(a5)
                bpl.s   Boss_SylpheedAttackState1
loc_599B4:                                              ; CODE XREF: Boss_SylpheedAnimationUpdate+2E   j
                addi.l  #$1000,$1C(a5)
; End of function Boss_SylpheedAnimationUpdate
; Attack state 1 handler
Boss_SylpheedAttackState1:                              ; CODE XREF: Boss_SylpheedIdleState+4C   p  ; was: sub_599BC
                                        ; Boss_SylpheedAnimationUpdate+1E   j
                move.w  $3BC(a5),d1
                add.w   $41C(a5),d1
                move.w  $10(a5),d0
                cmp.w   d1,d0
                bmi.s   loc_599E6
                tst.w   $18(a5)
                bpl.s   loc_599DC
                cmpi.l  #$FFFF0000,$18(a5)
                bmi.s   locret_599E4
loc_599DC:                                              ; CODE XREF: Boss_SylpheedAttackState1+14   j
                subi.l  #$800,$18(a5)
locret_599E4:                                           ; CODE XREF: Boss_SylpheedAttackState1+1E   j
                                        ; Boss_SylpheedAttackState1+38   j
                rts
; ---------------------------------------------------------------------------
loc_599E6:                                              ; CODE XREF: Boss_SylpheedAttackState1+E   j
                tst.w   $18(a5)
                bmi.s   loc_599F6
                cmpi.l  #$10000,$18(a5)
                bpl.s   locret_599E4
loc_599F6:                                              ; CODE XREF: Boss_SylpheedAttackState1+2E   j
                addi.l  #$800,$18(a5)
                rts
; End of function Boss_SylpheedAttackState1
; Attack state 2 handler
Boss_SylpheedAttackState2:                              ; CODE XREF: Boss_SylpheedState2+6   j  ; was: sub_59A00
                                        ; Boss_SylpheedIdleState+56   j
                bsr.w   Boss_SylpheedMovePattern1
                bsr.w   Boss_SylpheedAttackState3
                moveq   #$19,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_SylpheedAttackState2
; Attack state 3 handler
Boss_SylpheedAttackState3:                              ; CODE XREF: Boss_SylpheedAttackState2+4   p  ; was: sub_59A10
                move.w  #$100,$416(a5)
                moveq   #0,d0
                move.b  (a0),d0
                asl.w   #1,d0
                moveq   #0,d1
                move.w  $20(a0),d1
                asl.l   #8,d1
                asl.l   #1,d1
                and.w   d7,d0
                move.w  d0,$B6(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$176(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                moveq   #0,d0
                move.b  4(a0),d0
                asl.w   #1,d0
                moveq   #0,d1
                move.w  $24(a0),d1
                asl.l   #8,d1
                asl.l   #1,d1
                and.w   d7,d0
                move.w  d0,$236(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$296(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$476(a5)
                move.b  $C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$4D6(a5)
                move.w  d1,$536(a5)
                moveq   #0,d0
                move.b  $10(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                moveq   #0,d2
                move.w  $28(a0),d2
                asl.l   #8,d2
                asl.l   #1,d2
                and.w   d7,d0
                move.w  d0,$716(a5)
                addi.w  #$100,d0
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$5F6(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$656(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$6B6(a5)
                move.b  $14(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$7D6(a5)
                move.w  d1,$836(a5)
                moveq   #0,d0
                move.b  $1C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                moveq   #0,d2
                move.w  $2C(a0),d2
                asl.l   #8,d2
                asl.l   #1,d2
                and.w   d7,d0
                move.w  d0,$A16(a5)
                addi.w  #$100,d0
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$896(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$8F6(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$9B6(a5)
                rts
; End of function Boss_SylpheedAttackState3
; Movement pattern 1
Boss_SylpheedMovePattern1:                              ; CODE XREF: Boss_SylpheedAttackState2   p  ; was: sub_59B72
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_59BEC
loc_59B7C:                                              ; CODE XREF: Boss_SylpheedMovePattern1+24   j
                                        ; Boss_SylpheedMovePattern2+E   j
                move.w  $58(a5),d0
                bmi.w   loc_59BFC
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_59B98
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_59B7C
; ---------------------------------------------------------------------------
loc_59B98:                                              ; CODE XREF: Boss_SylpheedMovePattern1+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Boss_SylpheedMovePattern2
                move.w  d3,$58(a5)
                bra.w   loc_59BFC
; End of function Boss_SylpheedMovePattern1
nullsub_135:
                rts
; End of function nullsub_135

; Movement pattern 2
Boss_SylpheedMovePattern2:                              ; CODE XREF: Boss_SylpheedMovePattern1+2E   j  ; was: sub_59BAC
                cmpi.w  #$FFFF,d3
                bne.s   loc_59BBC
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_59B7C
; ---------------------------------------------------------------------------
loc_59BBC:                                              ; CODE XREF: Boss_SylpheedMovePattern2+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w   Boss_SylpheedMovePattern3
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_59BFC
loc_59BEC:                                              ; CODE XREF: Boss_SylpheedMovePattern1+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$B,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_59BFC:                                              ; CODE XREF: Boss_SylpheedMovePattern1+E   j
                                        ; Boss_SylpheedMovePattern1+34   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_SylpheedMovePattern2
; Movement pattern 3
Boss_SylpheedMovePattern3:                              ; CODE XREF: Boss_SylpheedMovePattern2+24   p  ; was: sub_59C06
                movea.l $2FC(a5),a1
                moveq   #$B,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_SylpheedMovePattern3
; Loads animation frame delays from RAM buffer for boss animation sequence
Boss_SylpheedLoadAnimDelays:
                moveq   #$B,d7                          ; was: sub_59C1A
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_SylpheedLoadAnimDelays
; ---------------------------------------------------------------------------
word_59C26:     dc.w    $2020, $18, $2020, $24, $FFFF
                                        ; DATA XREF: Boss_SylpheedState2   o
word_59C30:     dc.w    $810, 0, $808, 0, $810, $C, $808, $C
                                        ; DATA XREF: Boss_SylpheedIdleState+50   o
                                        ; Boss_SylpheedIdleState+8E   o
                dc.w    $FFFF
word_59C42:     dc.w    $1060, $18, $3030, $18, $1060, $24, $3030, $24
                                        ; DATA XREF: Boss_SylpheedAnimationScript+4E   o
                                        ; Boss_SylpheedAnimationScript+98   o
                dc.w    $FFFF
word_59C54:     dc.w    $1060, $30, $3030, $30, $1060, $3C, $3030, $3C
                                        ; DATA XREF: Boss_SylpheedIdleWait+80   o
                dc.w    $FFFF
word_59C66:     dc.w    $808, $18, $FFFE                ; DATA XREF: Boss_SylpheedIdleWait+B2   o
word_59C6C:     dc.w    $810, $48, $2020, $48, $FFFE
                                        ; DATA XREF: Boss_SylpheedJumpRising+18   o
word_59C76:     dc.w    $640, $54, $C0E, $54, $E0E, $54, $FFFE
                                        ; DATA XREF: Boss_SylpheedJumpFalling+18   o
word_59C84:     dc.w    $810, $60, $2020, $60, $FFFE
                                        ; DATA XREF: Boss_SylpheedDiveRecovery+18   o
word_59C8E:     dc.w    $640, $6C, $C0E, $6C, $E0E, $6C, $FFFE
                                        ; DATA XREF: Boss_SylpheedClimbPattern+18   o
word_59C9C:     dc.w    $70F0, $50F8, $C0D0, $F840, $1010, $8F8, $9010, $3008
                                        ; DATA XREF: Boss_SylpheedBattleStart+30   o
                dc.w    $C0B0, $840, $F0F0, $8F8, $B020, $60F8, $A0A0, $860
                dc.w    $E014, $14EC, $A034, $5010, $A0B0, $F060, $E010, $EF2
                dc.w    $9000, $3810, $A0C8, $F060, $F012, $10F0, $8010, $40F0
                dc.w    $C0C0, $1040, $FE04, $8F8, $A840, $60A0, $A0E0, $6060
                dc.w    $E0E8, $18E8, $58F0, $E0D0, $C060, $E050, $E00C, $10F8
                dc.w    $5000, $20C8, $A098, $4060, $10F0, $12E8, $E048, $A402
                dc.w    $C000, $3838, $E0EC, $8F2, $8010, $7030, $B890, $D048
                dc.w    $D008, $10F0, $9020, $20E0, $C0E0, $2040, $F820, $4FC

; Sets sprite graphics pointer based on difficulty flag
