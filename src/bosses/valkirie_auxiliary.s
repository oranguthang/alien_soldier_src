Boss_ValkiriePart3Handler:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_51842
                tst.w   4(a5)
                beq.w   loc_51856
                tst.w   8(a5)
                beq.s   loc_51856
                jsr     (Gfx_InitPaletteFade).l
loc_51856:                                              ; CODE XREF: Boss_ValkiriePart3Handler+4   j
                                        ; Boss_ValkiriePart3Handler+C   j
                move.w  4(a5),d0
                movea.w off_51866(pc,d0.w),a0
                adda.l  #Boss_ValkiriePart3Init,a0
                jmp     (a0)
; End of function Boss_ValkiriePart3Handler
; ---------------------------------------------------------------------------
off_51866:      dc.w    Boss_ValkiriePart3Init-Boss_ValkiriePart3Init
                                        ; DATA XREF: Boss_ValkiriePart3Handler+18   r
                dc.w    Boss_ValkirieForce_State34-Boss_ValkiriePart3Init

; Initializes third Valkirie boss component with basic entity parameters and screen position
Boss_ValkiriePart3Init:                                 ; DATA XREF: Boss_ValkiriePart3Handler+1C   o  ; was: sub_5186A
                                        ; ROM:off_51866   o
                move.w  #1,8(a5)
                move.w  #$3F4,(a5)
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
; Valkirie Force advanced pattern
Boss_ValkirieForce_State34:                             ; DATA XREF: ROM:00051868   o  ; was: loc_518AA
                tst.w   (word_FF80C2).w
                bne.s   locret_518B6
                move.b  #1,(byte_FFA958).w
locret_518B6:                                           ; CODE XREF: Boss_ValkiriePart3Init+44   j
                rts
; End of function Boss_ValkiriePart3Init
; Debug mode handler for Valkirie boss - allows manual angle control using controller inputs (buttons 2/3)
Boss_ValkirieDebugAngleControl:
                btst    #2,(word_FFF706).w              ; was: sub_518B8
                beq.s   loc_518C4
                addq.w  #2,$56(a5)
loc_518C4:                                              ; CODE XREF: Boss_ValkirieDebugAngleControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_518D0
                subq.w  #2,$56(a5)
loc_518D0:                                              ; CODE XREF: Boss_ValkirieDebugAngleControl+12   j
                andi.w  #$1FE,$56(a5)
                lea     byte_51AA8(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_518E0:                                              ; CODE XREF: Boss_ValkirieDebugAngleControl+24   j
                bsr.w   Boss_ValkirieAnimationSequencer
                moveq   #$19,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_ValkirieDebugAngleControl
; Processes animation sequence data from table, handles frame interpolation, and updates multiple sprite angles ($B6-$9B6 offsets)
Boss_ValkirieAnimationSequencer:                        ; CODE XREF: Boss_ValkirieDebugAngleControl:loc_518E0   p  ; was: sub_518EC
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_51964
loc_518F6:                                              ; CODE XREF: Boss_ValkirieAnimationSequencer+24   j
                                        ; Boss_ValkirieAnimationSequencer+44   j
                move.w  $58(a5),d0
                bmi.w   loc_51974
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_51912
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_518F6
; ---------------------------------------------------------------------------
loc_51912:                                              ; CODE XREF: Boss_ValkirieAnimationSequencer+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_51922
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_51922:                                              ; CODE XREF: Boss_ValkirieAnimationSequencer+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_51932
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_518F6
; ---------------------------------------------------------------------------
loc_51932:                                              ; CODE XREF: Boss_ValkirieAnimationSequencer+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #byte_51AB2,d0
                movea.l d0,a0
                bsr.w   Boss_ValkirieAnimationCalc
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_51974
loc_51964:                                              ; CODE XREF: Boss_ValkirieAnimationSequencer+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$12,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_51974:                                              ; CODE XREF: Boss_ValkirieAnimationSequencer+E   j
                                        ; Boss_ValkirieAnimationSequencer+76   j
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
; End of function Boss_ValkirieAnimationSequencer
; Calculates animation interpolation deltas for 18 animation channels using frame data
Boss_ValkirieAnimationCalc:                             ; CODE XREF: Boss_ValkirieAnimationSequencer+5C   p  ; was: sub_51A86
                lea     (off_354B0).l,a1
                moveq   #$12,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieAnimationCalc
; Loads animation frame delay data into RAM buffer for 18 animation channels
Boss_ValkirieAnimationLoadDelays:
                moveq   #$12,d7                         ; was: sub_51A9C
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_ValkirieAnimationLoadDelays
; ---------------------------------------------------------------------------
byte_51AA8:     dc.b    $20, $20, 0, 0, $20, $20, 0, $12, $FF, $FF
                                        ; DATA XREF: Boss_ValkirieDebugAngleControl+1E   o
byte_51AB2:     dc.b    $40, 0, $C0, $94, $C0, $10, $EC, $40, $F0, $60, $F0, $20, $20, $20, $10, $E0
                                        ; DATA XREF: Boss_ValkirieAnimationSequencer+54   o
                dc.b    $E0, 0, $40, 0, $C0, $94, $C0, $10, $EC, $40, $F0, $60, $F0, $20, $20, $20
                dc.b    $10, $E0, $E0, 0

; Main boss handler
