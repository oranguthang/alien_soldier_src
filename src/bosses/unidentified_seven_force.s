Boss_Unknown1MainLoop:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_58C62
                tst.w   4(a5)
                beq.w   loc_58C84
                tst.w   8(a5)
                beq.s   loc_58C84
                lea     (word_3E4C).l,a2
                jsr     (Gfx_ProcessColorFade).l
                moveq   #$18,d0
                jsr     (Boss_ValkirieUpdatePalette).l
loc_58C84:                                              ; CODE XREF: Boss_Unknown1MainLoop+4   j
                                        ; Boss_Unknown1MainLoop+C   j
                move.w  4(a5),d0
                movea.w off_58C94(pc,d0.w),a0
                adda.l  #Boss_Unknown1InitMetasprite,a0
                jmp     (a0)
; End of function Boss_Unknown1MainLoop
; ---------------------------------------------------------------------------
off_58C94:      dc.w    Boss_Unknown1InitMetasprite-Boss_Unknown1InitMetasprite
                                        ; DATA XREF: Boss_Unknown1MainLoop+26   r
                dc.w    Boss_Unknown1PlayerInputControl-Boss_Unknown1InitMetasprite
                dc.w    Boss_Sylpheed_AltState1-Boss_Unknown1InitMetasprite

; Initializes metasprite and graphics for unknown boss 1
Boss_Unknown1InitMetasprite:                            ; DATA XREF: Boss_Unknown1MainLoop+2A   o  ; was: sub_58C9A
                                        ; ROM:off_58C94   o
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$19,d7
                movea.l #off_5A356,a0
                movea.l #word_5A3CE,a1
                movea.l #word_5A3EC,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A428,$2FC(a5)
                move.l  #word_58FCA,$35C(a5)
                move.w  #$43C,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                movea.l #word_1BF90,a1
                jsr     (Sprite_InitFromPointerTable).l
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  #2,$1DE(a5)
                bra.w   loc_58DAA
; End of function Boss_Unknown1InitMetasprite
; Initializes position state 2 for unknown boss 1
Boss_Unknown1InitPositionState2:
                move.w  #2,4(a5)                        ; was: sub_58D00
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; End of function Boss_Unknown1InitPositionState2
; Processes player directional input for unknown boss 1
Boss_Unknown1PlayerInputControl:                        ; DATA XREF: ROM:00058C96   o  ; was: sub_58D2C
                btst    #2,(word_FFF706).w
                beq.s   loc_58D38
                addq.w  #2,$56(a5)
loc_58D38:                                              ; CODE XREF: Boss_Unknown1PlayerInputControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_58D44
                subq.w  #2,$56(a5)
loc_58D44:                                              ; CODE XREF: Boss_Unknown1PlayerInputControl+12   j
                andi.w  #$1FE,$56(a5)
                lea     word_58FC0(pc),a1
                nop
                bra.w   loc_58DD8
; End of function Boss_Unknown1PlayerInputControl
; Initializes position state 4 with timer for unknown boss 1
Boss_Unknown1InitPositionState4:
                move.w  #4,4(a5)                        ; was: sub_58D54
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$1B58,(word_FF8200).w
                move.w  #$1B58,(word_FF8202).w
                move.w  #$80,$11C(a5)
                subq.w  #1,$11C(a5)
                bpl.s   loc_58DA0
                moveq   #8,d0
                jmp     Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_58DA0:                                              ; CODE XREF: Boss_Unknown1InitPositionState4+42   j
                lea     word_58FC0(pc),a1
                nop
                bra.w   loc_58DD8
; ---------------------------------------------------------------------------
loc_58DAA:                                              ; CODE XREF: Boss_Unknown1InitMetasprite+62   j
                move.w  #4,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; Sylpheed boss alternate state 1
Boss_Sylpheed_AltState1:                                ; DATA XREF: ROM:00058C98   o  ; was: loc_58DCE
                lea     word_58FC0(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_58DD8:                                              ; CODE XREF: Boss_Unknown1PlayerInputControl+24   j
                                        ; Boss_Unknown1InitPositionState4+52   j
                bsr.w   Boss_ValkirieAnimationScriptBase
                bsr.w   Boss_ValkirieSetAnimationAngles
                moveq   #$18,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_Unknown1InitPositionState4
; Sets animation angle values for multiple sprite parts based on source data
Boss_ValkirieSetAnimationAngles:                        ; CODE XREF: Boss_Unknown1InitPositionState4+88   p  ; was: sub_58DE8
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$116(a5)
                move.b  8(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.b  $10(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d0,$296(a5)
                move.b  $14(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.w  d0,$356(a5)
                move.b  $18(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.b  $1C(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  $20(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.w  d0,$536(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                addi.w  #$100,d0
                move.b  $30(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.b  $34(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.b  $38(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $3C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                addi.w  #$100,d0
                move.b  $40(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$9B6(a5)
                move.b  $44(a0),d1
                ext.w   d1
                move.w  $B2(a5),d0
                add.w   d1,d0
                move.w  d0,$B4(a5)
                move.w  $112(a5),d0
                add.w   d1,d0
                move.w  d0,$114(a5)
                rts
; End of function Boss_ValkirieSetAnimationAngles
; Processes animation script commands, handles frame delays and script control flow
Boss_ValkirieAnimationScriptBase:                       ; CODE XREF: Boss_Unknown1InitPositionState4:loc_58DD8   p  ; was: sub_58F0C
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_58F86
loc_58F16:                                              ; CODE XREF: Boss_ValkirieAnimationScriptBase+24   j
                                        ; Boss_ValkirieAnimationScriptContinue+E   j
                move.w  $58(a5),d0
                bmi.w   loc_58F96
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_58F32
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_58F16
; ---------------------------------------------------------------------------
loc_58F32:                                              ; CODE XREF: Boss_ValkirieAnimationScriptBase+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Boss_ValkirieAnimationScriptContinue
                move.w  d3,$58(a5)
                bra.w   loc_58F96
; End of function Boss_ValkirieAnimationScriptBase
nullsub_133:
                rts
; End of function nullsub_133

; Continues animation script processing, handles loop and end commands
Boss_ValkirieAnimationScriptContinue:                   ; CODE XREF: Boss_ValkirieAnimationScriptBase+2E   j  ; was: sub_58F46
                cmpi.w  #$FFFF,d3
                bne.s   loc_58F56
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_58F16
; ---------------------------------------------------------------------------
loc_58F56:                                              ; CODE XREF: Boss_ValkirieAnimationScriptContinue+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w   Boss_ValkirieSetupInterpolationBase
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_58F96
loc_58F86:                                              ; CODE XREF: Boss_ValkirieAnimationScriptBase+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$11,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_58F96:                                              ; CODE XREF: Boss_ValkirieAnimationScriptBase+E   j
                                        ; Boss_ValkirieAnimationScriptBase+34   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_ValkirieAnimationScriptContinue
; Sets up animation interpolation for 18 sprite parts, calculates deltas
Boss_ValkirieSetupInterpolationBase:                    ; CODE XREF: Boss_ValkirieAnimationScriptContinue+24   p  ; was: sub_58FA0
                movea.l $2FC(a5),a1
                moveq   #$11,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieSetupInterpolationBase
; Loads frame delay values for animation system with 18 sprite parts
Boss_ValkirieLoadFrameDelaysBase:
                moveq   #$11,d7                         ; was: sub_58FB4
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_ValkirieLoadFrameDelaysBase
; ---------------------------------------------------------------------------
word_58FC0:     dc.w    $2020, 0, $2020, $12, $FFFF
                                        ; DATA XREF: Boss_Unknown1PlayerInputControl+1E   o
                                        ; sub_58D54:loc_58DA0   o
word_58FCA:     dc.w    $40F8, $C49A, $B80A, $E654, $E05E, $EE20, $2022, $12E0
                                        ; DATA XREF: Boss_Unknown1InitMetasprite+30   o
                dc.w    $E000, $3E04, $C092, $C412, $F058, $D062, $E91C, $201E
                dc.w    $17E4, $E002

; Main update routine for Valkyrie boss, handles state dispatch and palette updates
