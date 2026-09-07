Boss_ValkirieForceMain:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_53500
                tst.w   4(a5)
                beq.w   loc_53514
                tst.w   8(a5)
                beq.s   loc_53514
                jsr     (Gfx_InitPaletteFade).l
loc_53514:                                              ; CODE XREF: Boss_ValkirieForceMain+4   j
                                        ; Boss_ValkirieForceMain+C   j
                move.w  4(a5),d0
                movea.w off_53524(pc,d0.w),a0
                adda.l  #Boss_ValkirieForceInit,a0
                jmp     (a0)
; End of function Boss_ValkirieForceMain
; ---------------------------------------------------------------------------
off_53524:      dc.w    Boss_ValkirieForceInit-Boss_ValkirieForceInit
                                        ; DATA XREF: Boss_ValkirieForceMain+18   r
                dc.w    Boss_Sirene_State2-Boss_ValkirieForceInit

; Initializes Valkirie Force boss with metasprite setup and handles player rotation input
Boss_ValkirieForceInit:                                 ; DATA XREF: Boss_ValkirieForceMain+1C   o  ; was: sub_53528
                                        ; ROM:off_53524   o
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$19,d7
                movea.l #dword_355A4,a0
                movea.l #dword_355A4,a1
                movea.l #dword_355A4,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$3FC,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                move.w  #2,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; Sirene boss aiming phase
Boss_Sirene_State2:                                     ; DATA XREF: ROM:00053526   o  ; was: loc_5358A
                btst    #2,(word_FFF706).w
                beq.s   loc_53596
                addq.w  #2,$56(a5)
loc_53596:                                              ; CODE XREF: Boss_ValkirieForceInit+68   j
                btst    #3,(word_FFF706).w
                beq.s   loc_535A2
                subq.w  #2,$56(a5)
loc_535A2:                                              ; CODE XREF: Boss_ValkirieForceInit+74   j
                andi.w  #$1FE,$56(a5)
                lea     word_5377A(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_535B2:                                              ; CODE XREF: Boss_ValkirieForceInit+86   j
                bsr.w   Boss_ValkirieForceAnimUpdate
                moveq   #$19,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_ValkirieForceInit
; Updates boss animation sequence with interpolation and applies rotation angles to all segments
Boss_ValkirieForceAnimUpdate:                           ; CODE XREF: Boss_ValkirieForceInit:loc_535B2   p  ; was: sub_535BE
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_53636
loc_535C8:                                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+24   j
                                        ; Boss_ValkirieForceAnimUpdate+44   j
                move.w  $58(a5),d0
                bmi.w   loc_53646
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_535E4
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_535C8
; ---------------------------------------------------------------------------
loc_535E4:                                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_535F4
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_535F4:                                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_53604
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_535C8
; ---------------------------------------------------------------------------
loc_53604:                                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_53784,d0
                movea.l d0,a0
                bsr.w   Anim_ValkirieForceCalculateDeltas
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_53646
loc_53636:                                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$12,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_53646:                                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+E   j
                                        ; Boss_ValkirieForceAnimUpdate+76   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
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
                rts
; End of function Boss_ValkirieForceAnimUpdate
; Calculates animation interpolation deltas for Valkirie Force transformations
Anim_ValkirieForceCalculateDeltas:                      ; CODE XREF: Boss_ValkirieForceAnimUpdate+5C   p  ; was: sub_53758
                lea     (dword_355A4).l,a1
                moveq   #$12,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Anim_ValkirieForceCalculateDeltas
; Loads frame delay data for Valkirie Force animations
Anim_ValkirieForceLoadDelays:
                moveq   #$12,d7                         ; was: sub_5376E
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Anim_ValkirieForceLoadDelays
; ---------------------------------------------------------------------------
word_5377A:     dc.w    $2020, 0, $2020, $12, $FFFF
                                        ; DATA XREF: Boss_ValkirieForceInit+80   o
word_53784:     dc.w    $4000, $C094, $C010, $EC40, $F060, $F020, $2020, $10E0, $E000, $4000, $C094, $C010, $EC40, $F060, $F020, $2020
                                        ; DATA XREF: Boss_ValkirieForceAnimUpdate+54   o
                dc.w    $10E0, $E000
word_537A8:     dc.w    $C680, $C6E0, $C740, $C7A0, $C800, $C860, $C8C0, $C920
                                        ; DATA XREF: Boss_MissiraySegmentsSeparate+1A   o
                                        ; Boss_MissirayShootPattern2+A   o

; Main boss handler
