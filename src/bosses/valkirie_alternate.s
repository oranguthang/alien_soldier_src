Boss_ValkirieMainAlt:                                   ; DATA XREF: ROM:off_5DC   o  ; was: sub_58FEE
                tst.w   4(a5)
                beq.w   loc_5902E
                tst.w   8(a5)
                beq.s   loc_5902E
                btst    #2,(byte_FF80EC).w
                bne.s   loc_5901A
                btst    #1,(byte_FF80EC).w
                bne.s   loc_5901A
                tst.w   (word_FF8200).w
                bne.s   loc_5901A
                moveq   #$C,d0
                jmp     Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_5901A:                                              ; CODE XREF: Boss_ValkirieMainAlt+14   j
                                        ; Boss_ValkirieMainAlt+1C   j
                lea     (word_3E4C).l,a2
                jsr     (Gfx_ProcessColorFade).l
                moveq   #$1E,d0
                jsr     (Boss_ValkirieUpdatePalette).l
loc_5902E:                                              ; CODE XREF: Boss_ValkirieMainAlt+4   j
                                        ; Boss_ValkirieMainAlt+C   j
                move.w  4(a5),d0
                movea.w off_5903E(pc,d0.w),a0
                adda.l  #Boss_ValkirieInitAlt,a0
                jmp     (a0)
; End of function Boss_ValkirieMainAlt
; ---------------------------------------------------------------------------
off_5903E:      dc.w    Boss_ValkirieInitAlt-Boss_ValkirieInitAlt
                                        ; DATA XREF: Boss_ValkirieMainAlt+44   r
                dc.w    Boss_ValkirieState3Setup-Boss_ValkirieInitAlt
                dc.w    Boss_Valkirie_AltState2-Boss_ValkirieInitAlt

; Initializes Valkyrie boss entity, sets up metasprites, animation data
Boss_ValkirieInitAlt:                                   ; DATA XREF: Boss_ValkirieMainAlt+48   o  ; was: sub_59044
                                        ; ROM:off_5903E   o
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$8300,(dword_FF8040).w
                moveq   #$17,d7
                movea.l #off_5A2A2,a0
                movea.l #word_5A302,a1
                movea.l #word_5A31A,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A34A,$2FC(a5)
                move.l  #word_593BC,$35C(a5)
                move.w  #$440,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                movea.l #word_1BFA0,a1
                jsr     (Sprite_InitFromPointerTable).l
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  #2,$1DE(a5)
                bra.w   loc_590E4
; End of function Boss_ValkirieInitAlt
; Initializes boss state 2, sets position to ($120,$E0), clears animation script pointer
Boss_ValkirieState2Init:
                move.w  #2,4(a5)                        ; was: sub_590AA
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.b   (byte_FF80EC).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; End of function Boss_ValkirieState2Init
; Sets up boss state 3 animation, loads animation script and calls sprite rendering
Boss_ValkirieState3Setup:                               ; DATA XREF: ROM:00059040   o  ; was: sub_590DA
                lea     word_593B2(pc),a1
                nop
                bra.w   loc_59124
; ---------------------------------------------------------------------------
loc_590E4:                                              ; CODE XREF: Boss_ValkirieInitAlt+62   j
                move.w  #4,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.b   (byte_FF80EC).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$70,$11C(a5)                   ; 'p'
; Valkirie boss alternate attack state
Boss_Valkirie_AltState2:                                ; DATA XREF: ROM:00059042   o  ; was: loc_5911A
                lea     word_593B2(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_59124:                                              ; CODE XREF: Boss_ValkirieState3Setup+6   j
                                        ; Boss_ValkirieState3Setup+46   j
                bsr.w   Boss_ValkirieAnimationScriptAlt
                bsr.w   Boss_ValkirieSetSymmetricAngles
                moveq   #$16,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_ValkirieState3Setup
; Sets symmetric sprite angles for left/right mirrored parts
Boss_ValkirieSetSymmetricAngles:                        ; CODE XREF: Boss_ValkirieState3Setup+4E   p  ; was: sub_59134
                move.w  #$100,d6
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.w  d6,d5
                sub.w   d0,d5
                and.w   d7,d5
                move.w  d5,$3B6(a5)
                move.b  4(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d6,d5
                sub.w   d0,d5
                and.w   d7,d5
                move.w  d5,$416(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$296(a5)
                move.w  d6,d5
                sub.w   d0,d5
                and.w   d7,d5
                move.w  d5,$476(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.w  d6,d5
                sub.w   d0,d5
                and.w   d7,d5
                move.w  d5,$4D6(a5)
                move.b  $10(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                move.w  d6,d5
                sub.w   d0,d5
                and.w   d7,d5
                move.w  d5,$536(a5)
                move.w  #$80,$B6(a5)
                move.w  #$80,$176(a5)
                move.b  $18(a0),d3
                asl.w   #1,d3
                and.w   d7,d3
                move.w  d3,$596(a5)
                move.w  d6,d5
                sub.w   d3,d5
                and.w   d7,d5
                move.w  d5,$6B6(a5)
                move.b  $1C(a0),d3
                asl.w   #1,d3
                and.w   d7,d3
                move.w  d3,$5F6(a5)
                move.w  d3,$656(a5)
                move.w  d6,d5
                sub.w   d3,d5
                and.w   d7,d5
                move.w  d5,$716(a5)
                move.w  d5,$776(a5)
                move.b  $20(a0),d2
                asl.w   #1,d2
                and.w   d7,d2
                move.w  d2,$7D6(a5)
                move.w  d2,$836(a5)
                move.w  d6,d5
                sub.w   d2,d5
                and.w   d7,d5
                move.w  d5,$896(a5)
                move.w  d5,$8F6(a5)
                move.b  $24(a0),d2
                asl.w   #1,d2
                and.w   d7,d2
                move.w  d2,$116(a5)
                move.b  $28(a0),d1
                ext.w   d1
                move.w  d1,d2
                asr.w   #1,d2
                move.w  $112(a5),d0
                sub.w   d2,d0
                move.w  d0,$114(a5)
                move.w  $B2(a5),d0
                add.w   d2,d0
                move.w  d0,$B4(a5)
                move.w  $592(a5),d0
                add.w   d1,d0
                move.w  d0,$594(a5)
                move.w  $5F2(a5),d0
                add.w   d2,d0
                move.w  d0,$5F4(a5)
                move.w  $652(a5),d0
                add.w   d2,d0
                move.w  d0,$654(a5)
                move.w  $6B2(a5),d0
                add.w   d1,d0
                move.w  d0,$6B4(a5)
                move.w  $712(a5),d0
                add.w   d2,d0
                move.w  d0,$714(a5)
                move.w  $772(a5),d0
                add.w   d2,d0
                move.w  d0,$774(a5)
                move.w  $7D2(a5),d0
                sub.w   d1,d0
                move.w  d0,$7D4(a5)
                move.w  $832(a5),d0
                sub.w   d1,d0
                move.w  d0,$834(a5)
                move.w  $892(a5),d0
                sub.w   d2,d0
                move.w  d0,$894(a5)
                move.w  $8F2(a5),d0
                sub.w   d2,d0
                move.w  d0,$8F4(a5)
                move.b  $2C(a0),d1
                ext.w   d1
                move.w  d1,d2
                move.w  $1D2(a5),d0
                add.w   d2,d0
                move.w  d0,$1D4(a5)
                move.w  $232(a5),d0
                add.w   d2,d0
                move.w  d0,$234(a5)
                move.w  $292(a5),d0
                add.w   d2,d0
                move.w  d0,$294(a5)
                move.w  $2F2(a5),d0
                add.w   d2,d0
                move.w  d0,$2F4(a5)
                move.w  $352(a5),d0
                add.w   d2,d0
                move.w  d0,$354(a5)
                move.w  $3B2(a5),d0
                add.w   d2,d0
                move.w  d0,$3B4(a5)
                move.w  $412(a5),d0
                add.w   d2,d0
                move.w  d0,$414(a5)
                move.w  $472(a5),d0
                add.w   d2,d0
                move.w  d0,$474(a5)
                move.w  $4D2(a5),d0
                add.w   d2,d0
                move.w  d0,$4D4(a5)
                move.w  $532(a5),d0
                add.w   d2,d0
                move.w  d0,$534(a5)
                rts
; End of function Boss_ValkirieSetSymmetricAngles
; Alternative animation script processor with 12 sprite parts instead of 18
Boss_ValkirieAnimationScriptAlt:                        ; CODE XREF: Boss_ValkirieState3Setup:loc_59124   p  ; was: sub_592FE
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_59378
loc_59308:                                              ; CODE XREF: Boss_ValkirieAnimationScriptAlt+24   j
                                        ; Boss_ValkirieAnimationScriptAltContinue+E   j
                move.w  $58(a5),d0
                bmi.w   loc_59388
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_59324
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_59308
; ---------------------------------------------------------------------------
loc_59324:                                              ; CODE XREF: Boss_ValkirieAnimationScriptAlt+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Boss_ValkirieAnimationScriptAltContinue
                move.w  d3,$58(a5)
                bra.w   loc_59388
; End of function Boss_ValkirieAnimationScriptAlt
nullsub_134:
                rts
; End of function nullsub_134

; Continues alternative animation script processing for 12-part animations
Boss_ValkirieAnimationScriptAltContinue:                ; CODE XREF: Boss_ValkirieAnimationScriptAlt+2E   j  ; was: sub_59338
                cmpi.w  #$FFFF,d3
                bne.s   loc_59348
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_59308
; ---------------------------------------------------------------------------
loc_59348:                                              ; CODE XREF: Boss_ValkirieAnimationScriptAltContinue+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w   Boss_ValkirieSetupInterpolationAlt
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_59388
loc_59378:                                              ; CODE XREF: Boss_ValkirieAnimationScriptAlt+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$B,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_59388:                                              ; CODE XREF: Boss_ValkirieAnimationScriptAlt+E   j
                                        ; Boss_ValkirieAnimationScriptAlt+34   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_ValkirieAnimationScriptAltContinue
; Sets up animation interpolation for 12 sprite parts, alternative version
Boss_ValkirieSetupInterpolationAlt:                     ; CODE XREF: Boss_ValkirieAnimationScriptAltContinue+24   p  ; was: sub_59392
                movea.l $2FC(a5),a1
                moveq   #$B,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieSetupInterpolationAlt
; Loads frame delay values for 12-part animation system
Boss_ValkirieLoadFrameDelaysAlt:
                moveq   #$B,d7                          ; was: sub_593A6
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_ValkirieLoadFrameDelaysAlt
; ---------------------------------------------------------------------------
word_593B2:     dc.w    $2020, 0, $2020, $C, $FFFF
                                        ; DATA XREF: Boss_ValkirieState3Setup   o
                                        ; sub_590DA:loc_5911A   o
word_593BC:     dc.w    $8080, $8080, $8040, $6060, $A040, 0, $8080, $8080
                                        ; DATA XREF: Boss_ValkirieInitAlt+30   o
                dc.w    $8040, $6060, $A040, 0

; Intro stop position
