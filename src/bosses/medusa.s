Boss_MedusaAttackState1:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_5699C
                tst.w   4(a5)
                beq.w   loc_569E0
                tst.w   8(a5)
                beq.s   loc_569E0
                btst    #2,(byte_FF80EC).w
                bne.s   loc_569C8
                btst    #1,(byte_FF80EC).w
                bne.s   loc_569C8
                tst.w   (word_FF8200).w
                bne.s   loc_569C8
                moveq   #4,d0
                jmp     Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_569C8:                                              ; CODE XREF: Boss_MedusaAttackState1+14   j
                                        ; Boss_MedusaAttackState1+1C   j
                lea     (word_3E4C).l,a2
                jsr     (Gfx_ProcessColorFade).l
                moveq   #6,d0
                jsr     (Boss_ValkirieUpdatePalette).l
                bsr.w   Boss_MedusaFlashDamage
loc_569E0:                                              ; CODE XREF: Boss_MedusaAttackState1+4   j
                                        ; Boss_MedusaAttackState1+C   j
                move.w  4(a5),d0
                movea.w off_569F0(pc,d0.w),a0
                adda.l  #Boss_MedusaAttackState2,a0
                jmp     (a0)
; End of function Boss_MedusaAttackState1
; ---------------------------------------------------------------------------
off_569F0:      dc.w    Boss_MedusaAttackState2-Boss_MedusaAttackState2
                                        ; DATA XREF: Boss_MedusaAttackState1+48   r
                dc.w    Boss_MedusaPlayerInputControl-Boss_MedusaAttackState2
                dc.w    Boss_MedusaMovePattern2-Boss_MedusaAttackState2
                dc.w    Boss_MedusaAnimationScript-Boss_MedusaAttackState2
                dc.w    Boss_Valkirie_Behavior_State4-Boss_MedusaAttackState2
                dc.w    Boss_Valkirie_Behavior_State5-Boss_MedusaAttackState2
                dc.w    Boss_Valkirie_Behavior_State6-Boss_MedusaAttackState2
                dc.w    Boss_Valkirie_Behavior_State7-Boss_MedusaAttackState2
                dc.w    Boss_Valkirie_Behavior_State8-Boss_MedusaAttackState2
                dc.w    Boss_Valkirie_Behavior_State9-Boss_MedusaAttackState2
                dc.w    Boss_Valkirie_Behavior_State10-Boss_MedusaAttackState2

; Attack state 2 handler
Boss_MedusaAttackState2:                                ; DATA XREF: Boss_MedusaAttackState1+4C   o  ; was: sub_56A06
                                        ; ROM:off_569F0   o
                move.w  #1,8(a5)
                move.w  #$7000,(word_FF8200).w
                move.w  #$7000,(word_FF8202).w
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$14,d7
                movea.l #off_59F88,a0
                movea.l #word_59FDC,a1
                movea.l #word_59FF2,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A01C,$2FC(a5)
                move.l  #word_57132,$35C(a5)
                move.w  #$430,(a5)
                move.w  #$CC00,2(a5)
                clr.w   (word_FF9804).w
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  #$450,(a0)
                clr.w   4(a0)
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  $14(a0),$14(a5)
                move.l  $18(a0),$18(a5)
                move.l  $1C(a0),$1C(a5)
                move.w  #2,$1DE(a5)
                bra.w   Boss_MedusaMovePattern1
; End of function Boss_MedusaAttackState2
; Initializes Medusa boss position and state parameters
Boss_MedusaInitPositionState:
                move.w  #2,4(a5)                        ; was: sub_56A8A
                clr.w   (word_FFA02A).w
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; End of function Boss_MedusaInitPositionState
; Processes player directional input to control Medusa during fight
Boss_MedusaPlayerInputControl:                          ; DATA XREF: ROM:000569F2   o  ; was: sub_56ABA
                move.w  (dword_FFDB34).w,d0
                move.w  d0,$14(a5)
                btst    #2,(word_FFF706).w
                beq.s   loc_56ACE
                subq.w  #4,$10(a5)
loc_56ACE:                                              ; CODE XREF: Boss_MedusaPlayerInputControl+E   j
                btst    #3,(word_FFF706).w
                beq.s   loc_56ADA
                addq.w  #4,$10(a5)
loc_56ADA:                                              ; CODE XREF: Boss_MedusaPlayerInputControl+1A   j
                lea     word_570F8(pc),a1
                nop
                bra.w   Boss_MedusaShootPattern1
; End of function Boss_MedusaPlayerInputControl
; Movement pattern 1
Boss_MedusaMovePattern1:                                ; CODE XREF: Boss_MedusaAttackState2+80   j  ; was: sub_56AE4
                move.w  #4,4(a5)
                bclr    #3,2(a5)
                bclr    #2,2(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$100,$50(a5)
                move.w  #$100,$47C(a5)
                lea     word_57172(pc),a0
                nop
                bsr.w   Boss_MedusaSpawnProjectile4
; End of function Boss_MedusaMovePattern1
; Movement pattern 2
Boss_MedusaMovePattern2:                                ; DATA XREF: ROM:000569F4   o  ; was: sub_56B16
                tst.w   $58(a5)
                bmi.s   loc_56B32
                lea     word_570FE(pc),a1
                nop
                bsr.w   Boss_MedusaShootPattern1
                move.b  (dword_FF9410).w,d0
                ext.w   d0
                move.w  d0,$50(a5)
                rts
; ---------------------------------------------------------------------------
loc_56B32:                                              ; CODE XREF: Boss_MedusaMovePattern2+4   j
                addq.w  #2,4(a5)
                clr.w   $50(a5)
                bset    #3,2(a5)
                bset    #2,2(a5)
                bset    #0,2(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$F0,d0
                jsr     (Sound_PlaySFX).l
                movea.l #Boss_MedusaObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
; End of function Boss_MedusaMovePattern2
; Animation script interpreter
Boss_MedusaAnimationScript:                             ; DATA XREF: ROM:000569F6   o  ; was: sub_56B6C
                addi.l  #$2000,$1C(a5)
                bmi.s   loc_56B80
                move.w  (dword_FFDB34).w,d0
                cmp.w   $14(a5),d0
                bmi.s   loc_56B8A
loc_56B80:                                              ; CODE XREF: Boss_MedusaAnimationScript+8   j
                lea     word_57114(pc),a1
                nop
                bra.w   Boss_MedusaShootPattern1
; ---------------------------------------------------------------------------
loc_56B8A:                                              ; CODE XREF: Boss_MedusaAnimationScript+12   j
                addq.w  #2,4(a5)
                move.l  $18(a5),d0
                asr.l   #3,d0
                move.l  d0,$18(a5)
                move.l  #$FFFE0000,$1C(a5)
                move.w  #1,$4DC(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Valkirie AI state 4 attack pattern
Boss_Valkirie_Behavior_State4:                          ; DATA XREF: ROM:000569F8   o  ; was: loc_56BB0
                tst.w   $4DC(a5)
                beq.s   loc_56BD6
                addi.l  #$2000,$1C(a5)
                bmi.s   loc_56BE6
                move.w  (dword_FFDB34).w,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_56BE6
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   $4DC(a5)
loc_56BD6:                                              ; CODE XREF: Boss_MedusaAnimationScript+48   j
                move.w  (dword_FFDB34).w,d0
                move.w  d0,$14(a5)
                cmpi.w  #$1C0,$10(a5)
                bpl.s   loc_56BF0
loc_56BE6:                                              ; CODE XREF: Boss_MedusaAnimationScript+52   j
                                        ; Boss_MedusaAnimationScript+5C   j
                lea     word_57120(pc),a1
                nop
                bra.w   Boss_MedusaShootPattern1
; ---------------------------------------------------------------------------
loc_56BF0:                                              ; CODE XREF: Boss_MedusaAnimationScript+78   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$11C(a5)                   ; '@'
; Valkirie AI state 5 movement pattern
Boss_Valkirie_Behavior_State5:                          ; DATA XREF: ROM:000569FA   o  ; was: loc_56C04
                subq.w  #1,$11C(a5)
                bpl.s   loc_56C36
                clr.b   (byte_FF80EC).w
                bclr    #0,(byte_FFA272).w
                move.w  #1,(word_FF9804).w
                move.l  #word_573E6,$59C(a5)
                move.w  #$10,(word_FF9800).w
                move.w  #$18C,$11E(a5)
                clr.w   $4DC(a5)
                bra.w   loc_56C56
; ---------------------------------------------------------------------------
loc_56C36:                                              ; CODE XREF: Boss_MedusaAnimationScript+9C   j
                move.w  #$180,d0
                bsr.w   Boss_MedusaAnimationUpdate
                lea     word_57108(pc),a1
                nop
                bra.w   Boss_MedusaCollisionCheck
; ---------------------------------------------------------------------------
loc_56C48:                                              ; CODE XREF: Boss_MedusaAnimationScript+206   j
                                        ; Boss_MedusaAnimationScript+288   j
                clr.w   $47E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_56C56:                                              ; CODE XREF: Boss_MedusaAnimationScript+C6   j
                                        ; Boss_MedusaAnimationScript+1D8   j
                move.w  #$C,4(a5)
; Valkirie AI state 6 combo attack
Boss_Valkirie_Behavior_State6:                          ; DATA XREF: ROM:000569FC   o  ; was: loc_56C5C
                move.l  #word_57108,$53C(a5)
                tst.b   (byte_FFDB76).w
                beq.w   loc_56CE4
                tst.w   $4DC(a5)
                beq.s   loc_56C94
                addi.l  #$2000,$1C(a5)
                bmi.s   loc_56C9C
                move.w  (dword_FFDB34).w,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_56C9C
                move.w  #1,(word_FFA010).w
                clr.w   $4DC(a5)
                clr.l   $1C(a5)
loc_56C94:                                              ; CODE XREF: Boss_MedusaAnimationScript+104   j
                move.w  (dword_FFDB34).w,d0
                move.w  d0,$14(a5)
loc_56C9C:                                              ; CODE XREF: Boss_MedusaAnimationScript+10E   j
                                        ; Boss_MedusaAnimationScript+118   j
                cmpi.w  #4,$47E(a5)
                bne.s   loc_56CB0
                clr.w   $47E(a5)
                move.w  $5E(a5),$11E(a5)
                bra.s   loc_56CCE
; ---------------------------------------------------------------------------
loc_56CB0:                                              ; CODE XREF: Boss_MedusaAnimationScript+136   j
                cmpi.w  #2,$47E(a5)
                beq.w   loc_56DC0
                cmpi.w  #6,$47E(a5)
                beq.w   loc_56D50
                cmpi.w  #8,$47E(a5)
                beq.w   loc_56E22
loc_56CCE:                                              ; CODE XREF: Boss_MedusaAnimationScript+142   j
                bsr.w   Boss_MedusaAnimationLoop
                move.b  #$D8,d0
                bsr.w   Boss_MedusaPlaySFXEvery8Frames
                lea     word_57108(pc),a1
                nop
                bra.w   Boss_MedusaShootPattern1
; ---------------------------------------------------------------------------
loc_56CE4:                                              ; CODE XREF: Boss_MedusaAnimationScript+FC   j
                                        ; Boss_MedusaAnimationScript+270   j
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Valkirie AI state 7 special behavior
Boss_Valkirie_Behavior_State7:                          ; DATA XREF: ROM:000569FE   o  ; was: loc_56CF4
                cmpi.l  #$68000,$1C(a5)
                bpl.s   loc_56D08
                addi.l  #$2000,$1C(a5)
                bmi.s   loc_56D48
loc_56D08:                                              ; CODE XREF: Boss_MedusaAnimationScript+190   j
                tst.b   (byte_FFDB76).w
                beq.s   loc_56D48
                move.w  (dword_FFDB34).w,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_56D48
                addq.w  #2,4(a5)
                move.l  #$FFFE8000,$1C(a5)
                move.w  #1,$4DC(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$48,d0                         ; 'H'
                jsr     (Sound_PlaySFX).l
                move.w  #2,(word_FFA010).w
                bra.w   loc_56C56
; ---------------------------------------------------------------------------
loc_56D48:                                              ; CODE XREF: Boss_MedusaAnimationScript+19A   j
                                        ; Boss_MedusaAnimationScript+1A0   j
                movea.l $53C(a5),a1
                bra.w   Boss_MedusaShootPattern1
; ---------------------------------------------------------------------------
loc_56D50:                                              ; CODE XREF: Boss_MedusaAnimationScript+154   j
                move.w  #$12,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Valkirie AI state 9 advanced pattern
Boss_Valkirie_Behavior_State9:                          ; DATA XREF: ROM:00056A02   o  ; was: loc_56D60
                cmpi.w  #4,$47E(a5)
                bne.s   loc_56D76
                clr.w   $47E(a5)
                move.w  $5E(a5),$11E(a5)
                bra.w   loc_56C48
; ---------------------------------------------------------------------------
loc_56D76:                                              ; CODE XREF: Boss_MedusaAnimationScript+1FA   j
                cmpi.w  #2,$47E(a5)
                beq.w   loc_56DC0
                cmpi.w  #8,$47E(a5)
                beq.w   loc_56E22
                tst.l   $18(a5)
                beq.s   loc_56DB6
                bmi.s   loc_56D9E
                subi.l  #$2000,$18(a5)
                bmi.s   loc_56DA8
                bra.s   loc_56DAC
; ---------------------------------------------------------------------------
loc_56D9E:                                              ; CODE XREF: Boss_MedusaAnimationScript+224   j
                addi.l  #$2000,$18(a5)
                bmi.s   loc_56DAC
loc_56DA8:                                              ; CODE XREF: Boss_MedusaAnimationScript+22E   j
                clr.l   $18(a5)
loc_56DAC:                                              ; CODE XREF: Boss_MedusaAnimationScript+230   j
                                        ; Boss_MedusaAnimationScript+23A   j
                lea     word_57114(pc),a1
                nop
                bra.w   Boss_MedusaCollisionCheck
; ---------------------------------------------------------------------------
loc_56DB6:                                              ; CODE XREF: Boss_MedusaAnimationScript+222   j
                lea     word_57120(pc),a1
                nop
                bra.w   Boss_MedusaCollisionCheck
; ---------------------------------------------------------------------------
loc_56DC0:                                              ; CODE XREF: Boss_MedusaAnimationScript+14A   j
                                        ; Boss_MedusaAnimationScript+210   j
                move.w  #$10,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Valkirie AI state 8 transition phase
Boss_Valkirie_Behavior_State8:                          ; DATA XREF: ROM:00056A00   o  ; was: loc_56DD0
                move.l  #word_5711A,$53C(a5)
                tst.b   (byte_FFDB76).w
                beq.w   loc_56CE4
                move.w  #1,(word_FFA010).w
                cmpi.w  #$D0,$10(a5)
                bpl.s   loc_56DF8
                move.w  #$B0,$11E(a5)
                bra.w   loc_56C48
; ---------------------------------------------------------------------------
loc_56DF8:                                              ; CODE XREF: Boss_MedusaAnimationScript+280   j
                tst.l   $18(a5)
                bpl.s   loc_56E08
                cmpi.l  #$FFFB0000,$18(a5)
                bmi.s   loc_56E10
loc_56E08:                                              ; CODE XREF: Boss_MedusaAnimationScript+290   j
                subi.l  #$800,$18(a5)
loc_56E10:                                              ; CODE XREF: Boss_MedusaAnimationScript+29A   j
                move.b  #$F2,d0
                bsr.w   Boss_MedusaPlaySFXEvery4Frames
                lea     word_5711A(pc),a1
                nop
                bra.w   Boss_MedusaCollisionCheck
; ---------------------------------------------------------------------------
loc_56E22:                                              ; CODE XREF: Boss_MedusaAnimationScript+15E   j
                                        ; Boss_MedusaAnimationScript+21A   j
                move.w  #$14,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Valkirie AI state 10 final pattern
Boss_Valkirie_Behavior_State10:                         ; DATA XREF: ROM:00056A04   o  ; was: loc_56E32
                cmpi.w  #$180,$10(a5)
                bmi.s   loc_56E44
                move.w  #$18C,$11E(a5)
                bra.w   loc_56C48
; ---------------------------------------------------------------------------
loc_56E44:                                              ; CODE XREF: Boss_MedusaAnimationScript+2CC   j
                tst.l   $18(a5)
                bpl.s   loc_56E54
                cmpi.l  #$24000,$18(a5)
                bpl.s   loc_56E5C
loc_56E54:                                              ; CODE XREF: Boss_MedusaAnimationScript+2DC   j
                addi.l  #$800,$18(a5)
loc_56E5C:                                              ; CODE XREF: Boss_MedusaAnimationScript+2E6   j
                move.b  #$F3,d0
                bsr.w   Boss_MedusaPlaySFXEvery4Frames
                lea     word_5710E(pc),a1
                nop
                bra.w   Boss_MedusaCollisionCheck
; End of function Boss_MedusaAnimationScript
; Animation loop handler
Boss_MedusaAnimationLoop:                               ; CODE XREF: Boss_MedusaAnimationScript:loc_56CCE   p  ; was: sub_56E6E
                move.w  $11E(a5),d0
; End of function Boss_MedusaAnimationLoop
; Animation frame update
Boss_MedusaAnimationUpdate:                             ; CODE XREF: Boss_MedusaAnimationScript+CE   p  ; was: sub_56E72
                cmp.w   $10(a5),d0
                bpl.s   loc_56E92
                tst.l   $18(a5)
                bpl.s   loc_56E88
                cmpi.l  #$FFFDC000,$18(a5)
                bmi.s   locret_56E90
loc_56E88:                                              ; CODE XREF: Boss_MedusaAnimationUpdate+A   j
                subi.l  #$2000,$18(a5)
locret_56E90:                                           ; CODE XREF: Boss_MedusaAnimationUpdate+14   j
                                        ; Boss_MedusaAnimationUpdate+2E   j
                rts
; ---------------------------------------------------------------------------
loc_56E92:                                              ; CODE XREF: Boss_MedusaAnimationUpdate+4   j
                tst.l   $18(a5)
                bmi.s   loc_56EA2
                cmpi.l  #$12000,$18(a5)
                bpl.s   locret_56E90
loc_56EA2:                                              ; CODE XREF: Boss_MedusaAnimationUpdate+24   j
                addi.l  #$2000,$18(a5)
                rts
; End of function Boss_MedusaAnimationUpdate
; Collision detection with player
Boss_MedusaCollisionCheck:                              ; CODE XREF: Boss_MedusaAnimationScript+D8   j  ; was: sub_56EAC
                                        ; Boss_MedusaAnimationScript+246   j
                move.w  (dword_FFDB34).w,d0
                move.w  d0,$14(a5)
; End of function Boss_MedusaCollisionCheck
; Shooting pattern 1
Boss_MedusaShootPattern1:                               ; CODE XREF: Boss_MedusaPlayerInputControl+26   j  ; was: sub_56EB4
                                        ; Boss_MedusaMovePattern2+C   p
                bsr.w   Boss_MedusaSpawnProjectile1
                bsr.w   Boss_MedusaShootPattern2
                moveq   #$13,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_MedusaShootPattern1
; Shooting pattern 2
Boss_MedusaShootPattern2:                               ; CODE XREF: Boss_MedusaShootPattern1+4   p  ; was: sub_56EC4
                move.w  #$80,d6
                move.w  #0,$B6(a5)
                move.w  #$80,$296(a5)
                move.w  #$100,$476(a5)
                move.w  #$180,$656(a5)
                move.b  (a0),d0
                asl.w   #1,d0
                move.w  d0,d2
                and.w   d7,d0
                move.w  d0,$116(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$6B6(a5)
                move.b  4(a0),d0
                asl.w   #1,d0
                add.w   d2,d0
                move.w  d0,d2
                and.w   d7,d0
                move.w  d0,$176(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$536(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                add.w   d2,d0
                move.w  d0,d2
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                add.w   d2,d0
                move.w  d0,d2
                and.w   d7,d0
                move.w  d0,$236(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$5F6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.b  $10(a0),d1
                ext.w   d1
                move.w  d1,d2
                asr.w   #1,d2
                move.w  $B2(a5),d0
                add.w   d2,d0
                move.w  d0,$B4(a5)
                move.w  $292(a5),d0
                add.w   d2,d0
                move.w  d0,$294(a5)
                move.w  $472(a5),d0
                add.w   d2,d0
                move.w  d0,$474(a5)
                move.w  $652(a5),d0
                add.w   d2,d0
                move.w  d0,$654(a5)
                movea.w #(word_FFC680-M68K_RAM),a1
                bsr.w   Boss_MedusaShootPattern3
                movea.w #(word_FFC860-M68K_RAM),a1
                bsr.w   Boss_MedusaShootPattern3
                movea.w #(word_FFCA40-M68K_RAM),a1
                bsr.w   Boss_MedusaShootPattern3
                movea.w #(byte_FFCC20-M68K_RAM),a1
                bsr.w   Boss_MedusaShootPattern3
                move.b  $14(a0),d1
                ext.w   d1
                ext.l   d1
                swap    d1
                asr.l   #2,d1
                add.l   d1,$3BC(a5)
                move.w  $3BC(a5),$56(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                add.w   $47C(a5),d1
                and.w   d7,d1
                move.w  d1,$54(a5)
                rts
; End of function Boss_MedusaShootPattern2
; Shooting pattern 3
Boss_MedusaShootPattern3:                               ; CODE XREF: Boss_MedusaShootPattern2+EE   p  ; was: sub_56FF6
                                        ; Boss_MedusaShootPattern2+F6   p
                move.w  $B2(a1),d0
                add.w   d1,d0
                move.w  d0,$B4(a1)
                move.w  $112(a1),d0
                add.w   d1,d0
                move.w  d0,$114(a1)
                move.w  $172(a1),d0
                add.w   d1,d0
                move.w  d0,$174(a1)
                move.w  $1D2(a1),d0
                add.w   d1,d0
                move.w  d0,$1D4(a1)
                rts
; End of function Boss_MedusaShootPattern3
; Plays sound effect every 4th frame during animation
Boss_MedusaPlaySFXEvery4Frames:                         ; CODE XREF: Boss_MedusaAnimationScript+2A8   p  ; was: sub_57020
                                        ; Boss_MedusaAnimationScript+2F4   p
                move.w  (word_FFA000).w,d1
                andi.w  #3,d1
                bne.s   locret_57030
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_57030:                                           ; CODE XREF: Boss_MedusaPlaySFXEvery4Frames+8   j
                rts
; End of function Boss_MedusaPlaySFXEvery4Frames
; Plays sound effect every 8th frame during animation
Boss_MedusaPlaySFXEvery8Frames:                         ; CODE XREF: Boss_MedusaAnimationScript+16A   p  ; was: sub_57032
                move.w  (word_FFA000).w,d1
                andi.w  #7,d1
                bne.s   locret_57042
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_57042:                                           ; CODE XREF: Boss_MedusaPlaySFXEvery8Frames+8   j
                rts
; End of function Boss_MedusaPlaySFXEvery8Frames
; Spawns projectile type 1
Boss_MedusaSpawnProjectile1:                            ; CODE XREF: Boss_MedusaShootPattern1   p  ; was: sub_57044
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_570BE
loc_5704E:                                              ; CODE XREF: Boss_MedusaSpawnProjectile1+24   j
                                        ; Boss_MedusaSpawnProjectile2+E   j
                move.w  $58(a5),d0
                bmi.w   loc_570CE
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_5706A
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_5704E
; ---------------------------------------------------------------------------
loc_5706A:                                              ; CODE XREF: Boss_MedusaSpawnProjectile1+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Boss_MedusaSpawnProjectile2
                move.w  d3,$58(a5)
                bra.w   loc_570CE
; End of function Boss_MedusaSpawnProjectile1
nullsub_129:
                rts
; End of function nullsub_129

; Spawns projectile type 2
Boss_MedusaSpawnProjectile2:                            ; CODE XREF: Boss_MedusaSpawnProjectile1+2E   j  ; was: sub_5707E
                cmpi.w  #$FFFF,d3
                bne.s   loc_5708E
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_5704E
; ---------------------------------------------------------------------------
loc_5708E:                                              ; CODE XREF: Boss_MedusaSpawnProjectile2+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w   Boss_MedusaSpawnProjectile3
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_570CE
loc_570BE:                                              ; CODE XREF: Boss_MedusaSpawnProjectile1+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #7,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_570CE:                                              ; CODE XREF: Boss_MedusaSpawnProjectile1+E   j
                                        ; Boss_MedusaSpawnProjectile1+34   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_MedusaSpawnProjectile2
; Spawns projectile type 3
Boss_MedusaSpawnProjectile3:                            ; CODE XREF: Boss_MedusaSpawnProjectile2+24   p  ; was: sub_570D8
                movea.l $2FC(a5),a1
                moveq   #7,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_MedusaSpawnProjectile3
; Spawns projectile type 4
Boss_MedusaSpawnProjectile4:                            ; CODE XREF: Boss_MedusaMovePattern1+2E   p  ; was: sub_570EC
                moveq   #7,d7
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_MedusaSpawnProjectile4
; ---------------------------------------------------------------------------
word_570F8:     dc.w    $2020, 0, $FFFF                 ; DATA XREF: Boss_MedusaPlayerInputControl:loc_56ADA   o
word_570FE:     dc.w    $3060, 0, $2020, 0, $FFFE
                                        ; DATA XREF: Boss_MedusaMovePattern2+6   o
word_57108:     dc.w    $2020, 0, $FFFF                 ; DATA XREF: Boss_MedusaAnimationScript+D2   o
                                        ; sub_56B6C:loc_56C5C   o
word_5710E:     dc.w    $1818, $10, $FFFF               ; DATA XREF: Boss_MedusaAnimationScript+2F8   o
word_57114:     dc.w    $1010, $28, $FFFF               ; DATA XREF: Boss_MedusaAnimationScript:loc_56B80   o
                                        ; sub_56B6C:loc_56DAC   o
word_5711A:     dc.w    $1010, $18, $FFFF               ; DATA XREF: Boss_MedusaAnimationScript:loc_56DD0   o
                                        ; Boss_MedusaAnimationScript+2AC   o
word_57120:     dc.w    $308, $30, $E0E, $30, $408, $28, $1010
                                        ; DATA XREF: Boss_MedusaAnimationScript:loc_56BE6   o
                                        ; sub_56B6C:loc_56DB6   o
                dc.w    $28, $FFFF
word_57132:     dc.w    $401C, $1402, $14, 0, $C01C, $1402, $10
                                        ; DATA XREF: Boss_MedusaAttackState2+3C   o
                dc.w    0, $C0E4, $E4FE, $D0, 0, $401C, $1402
                dc.w    $28, $1000, 0, 0, $FC00, 0, $401C
                dc.w    $1402, 0, 0, $5018, $8F0, $1E0, 0
                dc.w    $4018, $20F0, $238, $1800
word_57172:     dc.w    0, 0, $7090, 0                  ; DATA XREF: Boss_MedusaMovePattern1+28   o

; Checks if boss takes damage
Boss_MedusaDamageCheck:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_5717A
                move.w  (dword_FFC630).w,$10(a5)
                clr.w   6(a5)
                move.w  4(a5),d0
                movea.w off_57194(pc,d0.w),a0
                adda.l  #Boss_MedusaUpdateHealth,a0
                jmp     (a0)
; End of function Boss_MedusaDamageCheck
; ---------------------------------------------------------------------------
off_57194:      dc.w    Boss_MedusaUpdateHealth-Boss_MedusaUpdateHealth
                                        ; DATA XREF: Boss_MedusaDamageCheck+E   r
                dc.w    Projectile_MedusaMain-Boss_MedusaUpdateHealth
                dc.w    Boss_MedusaDefeatInit-Boss_MedusaUpdateHealth

; Updates boss health
Boss_MedusaUpdateHealth:                                ; DATA XREF: Boss_MedusaDamageCheck+12   o  ; was: sub_5719A
                                        ; ROM:off_57194   o
                addq.w  #2,4(a5)
                move.w  #$400,2(a5)
                move.w  #$C480,$E(a5)
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                move.w  #$128,$14(a5)
loc_571BC:                                              ; CODE XREF: Boss_MedusaDefeatInit+1C   j
                move.w  #2,4(a5)
                clr.l   $1C(a5)
                move.b  #1,$56(a5)
                rts
; End of function Boss_MedusaUpdateHealth
; Projectile main handler
Projectile_MedusaMain:                                  ; DATA XREF: ROM:00057196   o  ; was: sub_571CE
                jsr     (Player_ActionDispatcher).l
                btst    #0,6(a5)
                beq.s   loc_571DE
                rts
; ---------------------------------------------------------------------------
loc_571DE:                                              ; CODE XREF: Projectile_MedusaMain+C   j
                move.w  #4,4(a5)
                clr.b   $56(a5)
                rts
; End of function Projectile_MedusaMain
; Defeat sequence initialization
Boss_MedusaDefeatInit:                                  ; DATA XREF: ROM:00057198   o  ; was: sub_571EA
                cmpi.w  #7,$1C(a5)
                bpl.s   loc_571FA
                addi.l  #$4000,$1C(a5)
loc_571FA:                                              ; CODE XREF: Boss_MedusaDefeatInit+6   j
                jsr     (Player_CheckTerrainCollision).l
                btst    #0,6(a5)
                bne.w   loc_571BC
                rts
; End of function Boss_MedusaDefeatInit
; Flash effect on damage
Boss_MedusaFlashDamage:                                 ; CODE XREF: Boss_MedusaAttackState1+40   p  ; was: sub_5720C
                tst.w   (word_FF9804).w
                beq.w   locret_572A0
                movea.l $59C(a5),a4
                moveq   #0,d1
                move.w  (word_FF9800).w,d1
                move.w  (a4,d1.w),d2
                bpl.s   loc_57244
                clr.w   (word_FF9800).w
                clr.w   (word_FF9804).w
                cmpi.w  #$FFFE,d2
                bne.s   loc_5723C
                move.l  #word_572B0,$59C(a5)
                rts
; ---------------------------------------------------------------------------
loc_5723C:                                              ; CODE XREF: Boss_MedusaFlashDamage+24   j
                addq.w  #2,d1
                adda.l  d1,a4
                move.l  a4,$59C(a5)
loc_57244:                                              ; CODE XREF: Boss_MedusaFlashDamage+16   j
                move.w  (dword_FFA900).w,d4
                cmp.w   d2,d4
                beq.s   loc_5724E
                bpl.s   locret_572A0
loc_5724E:                                              ; CODE XREF: Boss_MedusaFlashDamage+3E   j
                addq.w  #8,(word_FF9800).w
                move.w  2(a4,d1.w),d5
                beq.w   loc_572A2
                tst.w   (word_FFFF0E).w
                bne.s   loc_57264
                tst.w   d5
                bmi.s   locret_572A0
loc_57264:                                              ; CODE XREF: Boss_MedusaFlashDamage+52   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_572A0
                move.w  (a4,d1.w),d2
                sub.w   d4,d2
                addi.w  #$80,d2
                move.w  d2,$10(a0)
                andi.w  #$7FFF,d5
                move.w  d5,$14(a0)
                move.w  4(a4,d1.w),$5E(a0)
                move.w  6(a4,d1.w),(a0)
                bpl.s   locret_572A0
                cmpi.w  #$8000,(a0)
                bne.s   loc_5729A
                jmp     loc_2BD00
; ---------------------------------------------------------------------------
loc_5729A:                                              ; CODE XREF: Boss_MedusaFlashDamage+86   j
                jmp     Effect_SpawnDestructionBlast
; ---------------------------------------------------------------------------
locret_572A0:                                           ; CODE XREF: Boss_MedusaFlashDamage+4   j
                                        ; Boss_MedusaFlashDamage+40   j
                rts
; ---------------------------------------------------------------------------
loc_572A2:                                              ; CODE XREF: Boss_MedusaFlashDamage+4A   j
                move.w  6(a4,d1.w),$47E(a5)
                move.w  4(a4,d1.w),$5E(a5)
                rts
; End of function Boss_MedusaFlashDamage
; ---------------------------------------------------------------------------
word_572B0:     binclude "data/other/word_572B0.bin"
word_572B0_End:
word_573E6:     dc.w    $698, 0, 0, 8, $5D4, $11A, 0, $24C
                                        ; DATA XREF: Boss_MedusaAnimationScript+AE   o
                dc.w    $4C4, 0, $120, 4, $4C0, $D0, 0, $8000
                dc.w    $480, $130, 0, $8000, $408, $D0, 0, $8000
                dc.w    $480, $130, 0, $8000, $3E8, $148, 0, $8001
                dc.w    $360, $D0, 0, $8000, $340, $B0, 0, $8000
                dc.w    $300, $D0, 0, $8000, $2C0, $B0, 0, $8000
                dc.w    $280, $D0, 0, $8000, $240, $B0, 0, $8000
                dc.w    $1D8, 0, $B0, 4, $1D0, $DC, 0, $24C
                dc.w    $120, $8150, 0, $2B4, $E0, $150, 0, $8000
                dc.w    $A0, $150, 0, $8000, $80, 0, 0, 2
                dc.w    $60, $150, 0, $8000, $20, $150, 0, $8001
                dc.w    $FFFE

; Intro animation init
