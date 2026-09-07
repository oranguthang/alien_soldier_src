Boss_ValkirieMinibossHandler:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_515AE
                tst.w   4(a5)
                beq.w   loc_515C2
                tst.w   8(a5)
                beq.s   loc_515C2
                jsr     (Gfx_InitPaletteFade).l
loc_515C2:                                              ; CODE XREF: Boss_ValkirieMinibossHandler+4   j
                                        ; Boss_ValkirieMinibossHandler+C   j
                move.w  4(a5),d0
                movea.w off_515D2(pc,d0.w),a0
                adda.l  #Boss_ValkirieMinibossInit,a0
                jmp     (a0)
; End of function Boss_ValkirieMinibossHandler
; ---------------------------------------------------------------------------
off_515D2:      dc.w    Boss_ValkirieMinibossInit-Boss_ValkirieMinibossInit
                                        ; DATA XREF: Boss_ValkirieMinibossHandler+18   r
                dc.w    Boss_ValkirieForce_State20-Boss_ValkirieMinibossInit

; Initializes simplified Valkirie miniboss entity with basic parameters and position
Boss_ValkirieMinibossInit:                              ; DATA XREF: Boss_ValkirieMinibossHandler+1C   o  ; was: sub_515D6
                                        ; ROM:off_515D2   o
                move.w  #1,8(a5)
                move.w  #$3F0,(a5)
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
; Valkirie Force attack phase
Boss_ValkirieForce_State20:                             ; DATA XREF: ROM:000515D4   o  ; was: loc_51616
                tst.w   (word_FF80C2).w
                bne.s   locret_51622
                move.b  #1,(byte_FFA958).w
locret_51622:                                           ; CODE XREF: Boss_ValkirieMinibossInit+44   j
                rts
; End of function Boss_ValkirieMinibossInit
; Processes debug input for rotating Valkirie miniboss and updates metasprite display
Boss_ValkirieMinibossInput:
                btst    #2,(word_FFF706).w              ; was: sub_51624
                beq.s   loc_51630
                addq.w  #2,$56(a5)
loc_51630:                                              ; CODE XREF: Boss_ValkirieMinibossInput+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_5163C
                subq.w  #2,$56(a5)
loc_5163C:                                              ; CODE XREF: Boss_ValkirieMinibossInput+12   j
                andi.w  #$1FE,$56(a5)
                lea     byte_51814(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_5164C:                                              ; CODE XREF: Boss_ValkirieMinibossInput+24   j
                bsr.w   Boss_ValkirieMinibossAnimController
                moveq   #$19,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_ValkirieMinibossInput
; Animation controller for Valkirie miniboss that processes frames and updates all sprite component tile indices
Boss_ValkirieMinibossAnimController:                    ; CODE XREF: Boss_ValkirieMinibossInput:loc_5164C   p  ; was: sub_51658
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_516D0
loc_51662:                                              ; CODE XREF: Boss_ValkirieMinibossAnimController+24   j
                                        ; Boss_ValkirieMinibossAnimController+44   j
                move.w  $58(a5),d0
                bmi.w   loc_516E0
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_5167E
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_51662
; ---------------------------------------------------------------------------
loc_5167E:                                              ; CODE XREF: Boss_ValkirieMinibossAnimController+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_5168E
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_5168E:                                              ; CODE XREF: Boss_ValkirieMinibossAnimController+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_5169E
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_51662
; ---------------------------------------------------------------------------
loc_5169E:                                              ; CODE XREF: Boss_ValkirieMinibossAnimController+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_5181E,d0
                movea.l d0,a0
                bsr.w   Boss_ValkirieMinibossSetupInterp
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_516E0
loc_516D0:                                              ; CODE XREF: Boss_ValkirieMinibossAnimController+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$12,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_516E0:                                              ; CODE XREF: Boss_ValkirieMinibossAnimController+E   j
                                        ; Boss_ValkirieMinibossAnimController+76   j
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
; End of function Boss_ValkirieMinibossAnimController
; Sets up animation interpolation for Valkirie miniboss smooth frame transitions
Boss_ValkirieMinibossSetupInterp:                       ; CODE XREF: Boss_ValkirieMinibossAnimController+5C   p  ; was: sub_517F2
                lea     word_5181E(pc),a1
                nop
                moveq   #$12,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieMinibossSetupInterp
; Loads frame timing delays for Valkirie miniboss animations
Boss_ValkirieMinibossLoadTiming:
                moveq   #$12,d7                         ; was: sub_51808
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_ValkirieMinibossLoadTiming
; ---------------------------------------------------------------------------
byte_51814:     dc.b    $20, $20, 0, 0, $20, $20, 0, $12, $FF, $FF
                                        ; DATA XREF: Boss_ValkirieMinibossInput+1E   o
word_5181E:     dc.w    $4000, $C094, $C010, $EC40, $F060, $F020, $2020, $10E0, $E000
                                        ; DATA XREF: Boss_ValkirieMinibossAnimController+54   o
                                        ; sub_517F2   o
                dc.w    $4000, $C094, $C010, $EC40, $F060, $F020, $2020, $10E0, $E000

; State handler for third Valkirie boss part/component with palette fade initialization
