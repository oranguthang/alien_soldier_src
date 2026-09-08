Boss_ValkirieStateHandler:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_50FA6
                tst.w   4(a5)
                beq.w   loc_50FBA
                tst.w   8(a5)
                beq.s   loc_50FBA
                jsr     (Gfx_InitPaletteFade).l
loc_50FBA:                                              ; CODE XREF: Boss_ValkirieStateHandler+4   j
                                        ; Boss_ValkirieStateHandler+C   j
                move.w  4(a5),d0
                movea.w off_50FCA(pc,d0.w),a0
                adda.l  #nullsub_119,a0
                jmp     (a0)
; End of function Boss_ValkirieStateHandler
; ---------------------------------------------------------------------------
off_50FCA:      dc.w    Boss_ValkirieInit-nullsub_119
                                        ; DATA XREF: Boss_ValkirieStateHandler+18   r
                dc.w    Boss_ValkirieForce_StateInit-nullsub_119

nullsub_119:                                            ; CODE XREF: Boss_ValkirieInit+4   j
                                        ; Boss_ValkirieFlipLeft+4   j
                rts
; End of function nullsub_119

; Initializes Valkirie boss entity with metasprites, animation data, positions, and multiple sprite components
Boss_ValkirieInit:                                      ; DATA XREF: ROM:off_50FCA   o  ; was: sub_50FD0
                tst.w   (word_FFF720).w
                bmi.w   nullsub_119
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$14,d7
                movea.l #Boss_ValkirieMetaspriteDescriptors,a0
                movea.l #Boss_ValkiriePartRadii,a1
                movea.l #Boss_ValkiriePartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$3EC,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                move.w  #0,$176(a5)
                move.w  #$100,$356(a5)
                move.w  #$10,d0
                move.w  #$4300,d1
                move.w  #$C000,d2
                move.w  d0,$7E0(a5)
                move.w  d2,$7E2(a5)
                move.w  d1,$7EE(a5)
                move.b  #$20,$800(a5)                   ; ' '
                move.l  #word_EC7C2,$7E8(a5)
                move.w  d0,$840(a5)
                move.w  d2,$842(a5)
                move.w  d1,$84E(a5)
                move.b  #$1C,$860(a5)
                move.l  #word_EC7CE,$848(a5)
                move.w  d0,$8A0(a5)
                move.w  d2,$8A2(a5)
                move.w  d1,$8AE(a5)
                move.b  #$28,$8C0(a5)                   ; '('
                move.l  #word_EC7C2,$8A8(a5)
                move.w  d0,$900(a5)
                move.w  d2,$902(a5)
                move.w  d1,$90E(a5)
                move.b  #$24,$920(a5)                   ; '$'
                move.l  #word_EC7CE,$908(a5)
                move.w  #$C300,d1
                move.w  d0,$960(a5)
                move.w  d2,$962(a5)
                move.w  d1,$96E(a5)
                move.b  #$18,$980(a5)
                move.l  #word_EC6F0,$968(a5)
                move.w  d0,$9C0(a5)
                move.w  d2,$9C2(a5)
                move.w  d1,$9CE(a5)
                move.b  #$18,$9E0(a5)
                move.l  #word_EC792,$9C8(a5)
                movea.l #Boss_ValkirieObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                bsr.w   Boss_ValkirieDMALeftTiles
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_510DA:                                              ; CODE XREF: Boss_ValkirieInit+106   j
                move.w  #2,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$CD40,$48(a5)
                move.w  #$120,$730(a5)
                move.w  #$CF20,$4A(a5)
                move.w  #$148,$914(a5)
; Valkirie Force boss initialization
Boss_ValkirieForce_StateInit:                           ; DATA XREF: ROM:00050FCC   o  ; was: loc_51116
                tst.w   (word_FF80C2).w
                bne.s   loc_51122
                move.b  #1,(byte_FFA958).w
loc_51122:                                              ; CODE XREF: Boss_ValkirieInit+14A   j
                btst    #6,(word_FFF706).w
                beq.s   loc_5112E
                bsr.w   Boss_ValkirieFlipLeft
loc_5112E:                                              ; CODE XREF: Boss_ValkirieInit+158   j
                btst    #5,(word_FFF706).w
                beq.s   loc_5113A
                bsr.w   Boss_ValkirieFlipRight
loc_5113A:                                              ; CODE XREF: Boss_ValkirieInit+164   j
                btst    #2,(word_FFF706).w
                beq.s   loc_51146
                addq.b  #1,$29F(a5)
loc_51146:                                              ; CODE XREF: Boss_ValkirieInit+170   j
                btst    #3,(word_FFF706).w
                beq.s   loc_51152
                subq.b  #1,$29F(a5)
loc_51152:                                              ; CODE XREF: Boss_ValkirieInit+17C   j
                andi.w  #$1FE,$56(a5)
                lea     byte_51546(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_51162:                                              ; CODE XREF: Boss_ValkirieInit+18E   j
                bsr.w   Boss_ValkirieAnimationController
                moveq   #$14,d7
                jsr     (Sprite_SetMetaspriteTraversalPointers).l
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.w  #$FFF3,d7
                tst.w   $54(a5)
                beq.s   loc_5117E
                neg.w   d7
loc_5117E:                                              ; CODE XREF: Boss_ValkirieInit+1AA   j
                move.w  d7,d0
                add.w   $640(a5),d0
                move.w  d0,$820(a5)
                move.w  d0,$880(a5)
                move.l  #word_EC7C2,$7E8(a5)
                move.b  $38(a0),d0
                ext.w   d0
                cmpi.w  #4,d0
                bmi.s   loc_511A8
                move.l  #word_EC7C8,$7E8(a5)
loc_511A8:                                              ; CODE XREF: Boss_ValkirieInit+1CE   j
                add.w   $644(a5),d0
                addi.w  #$28,d0                         ; '('
                move.w  d0,$824(a5)
                move.w  d0,$884(a5)
                move.w  d7,d0
                add.w   $7C0(a5),d0
                move.w  d0,$8E0(a5)
                move.w  d0,$940(a5)
                move.l  #word_EC7C2,$8A8(a5)
                move.b  $3C(a0),d0
                ext.w   d0
                cmpi.w  #4,d0
                bmi.s   loc_511E2
                move.l  #word_EC7C8,$8A8(a5)
loc_511E2:                                              ; CODE XREF: Boss_ValkirieInit+208   j
                add.w   $7C4(a5),d0
                addi.w  #$28,d0                         ; '('
                move.w  d0,$8E4(a5)
                move.w  d0,$944(a5)
                moveq   #$18,d7
                jsr     (Sprite_UpdateLinkedPositions).l
                bclr    #4,$54E(a5)
                bclr    #4,$6CE(a5)
                moveq   #6,d5
                tst.w   $54(a5)
                beq.s   loc_51210
                neg.w   d5
loc_51210:                                              ; CODE XREF: Boss_ValkirieInit+23C   j
                add.w   $D0(a5),d5
                move.w  $D4(a5),d6
                addi.w  #-8,d6
                move.b  $29F(a5),d3
                cmpi.b  #$70,d3                         ; 'p'
                bmi.s   loc_5123E
                addi.w  #2,d5
                addi.w  #-6,d6
                move.w  d5,$970(a5)
                move.w  d6,$974(a5)
                bsr.w   Boss_ValkirieUpdateGunSprite
                bra.w   loc_5129E
; ---------------------------------------------------------------------------
loc_5123E:                                              ; CODE XREF: Boss_ValkirieInit+254   j
                lea     (Math_SineTable).l,a0
                move.l  #word_EC792,$9C8(a5)
                bset    #3,$9CE(a5)
                move.w  #$1A0,d7
                tst.w   $54(a5)
                beq.s   loc_51266
                bclr    #3,$9CE(a5)
                move.w  #$160,d7
loc_51266:                                              ; CODE XREF: Boss_ValkirieInit+28A   j
                move.w  -$80(a0,d7.w),d1
                move.w  (a0,d7.w),d2
                ext.w   d3
                muls.w  d3,d1
                muls.w  d3,d2
                move.l  d1,$9D4(a5)
                move.l  d2,$9D0(a5)
                asr.l   #2,d1
                asr.l   #2,d2
                move.l  d1,$974(a5)
                move.l  d2,$970(a5)
                add.w   d5,$970(a5)
                add.w   d6,$974(a5)
                addq.w  #4,d5
                addi.w  #-$C,d6
                add.w   d5,$9D0(a5)
                add.w   d6,$9D4(a5)
loc_5129E:                                              ; CODE XREF: Boss_ValkirieInit+26A   j
                move.w  #$A7,d0
                tst.w   $54(a5)
                beq.s   loc_512AC
                move.w  #$97,d0
loc_512AC:                                              ; CODE XREF: Boss_ValkirieInit+2D6   j
                sub.w   $70(a5),d0
                move.w  $74(a5),d1
                addi.w  #$3C,d1                         ; '<'
                move.w  d0,(dword_FFA908).w
                move.w  d1,(dword_FFA90C).w
                jsr     (Boss_ClampSharedScreenPosition).l
                rts
; End of function Boss_ValkirieInit
; Flips Valkirie boss to face left by clearing horizontal flip bits on all sprite components and loading left-facing tiles
Boss_ValkirieFlipLeft:                                  ; CODE XREF: Boss_ValkirieInit+15A   p  ; was: sub_512C8
                tst.w   $54(a5)
                beq.w   nullsub_119
                clr.w   $54(a5)
                moveq   #3,d0
                bclr    d0,$E(a5)
                bclr    d0,$CE(a5)
                bclr    d0,$60E(a5)
                bclr    d0,$78E(a5)
                bclr    d0,$5AE(a5)
                bclr    d0,$72E(a5)
                bclr    d0,$7EE(a5)
                bclr    d0,$84E(a5)
                bclr    d0,$8AE(a5)
                bclr    d0,$90E(a5)
                bclr    d0,$96E(a5)
                bra.w   Boss_ValkirieDMALeftTiles
; End of function Boss_ValkirieFlipLeft
; Flips Valkirie boss to face right by setting horizontal flip bits on all sprite components and loading right-facing tiles
Boss_ValkirieFlipRight:                                 ; CODE XREF: Boss_ValkirieInit+166   p  ; was: sub_51306
                tst.w   $54(a5)
                bne.w   nullsub_119
                move.w  #$100,$54(a5)
                moveq   #3,d0
                bset    d0,$E(a5)
                bset    d0,$CE(a5)
                bset    d0,$60E(a5)
                bset    d0,$78E(a5)
                bset    d0,$5AE(a5)
                bset    d0,$72E(a5)
                bset    d0,$7EE(a5)
                bset    d0,$84E(a5)
                bset    d0,$8AE(a5)
                bset    d0,$90E(a5)
                bset    d0,$96E(a5)
                lea     word_5135A(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_ValkirieFlipRight
; Performs DMA transfer to load left-facing tile graphics for Valkirie boss
Boss_ValkirieDMALeftTiles:                              ; CODE XREF: Boss_ValkirieInit+102   p  ; was: sub_5134E
                                        ; Boss_ValkirieFlipLeft+3A   j
                lea     word_51366(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_ValkirieDMALeftTiles
; ---------------------------------------------------------------------------
word_5135A:     dc.w    $6100, $2000, $102, $2829, $2A2B, $2C2D
                                        ; DATA XREF: Boss_ValkirieFlipRight+3C   o
word_51366:     dc.w    $6100, $2000, $102, $8A89, $8C8B, $8E8D
                                        ; DATA XREF: Boss_ValkirieDMALeftTiles   o

; Updates gun sprite animation frame and position for Valkirie boss based on aiming angle
Boss_ValkirieUpdateGunSprite:                           ; CODE XREF: Boss_ValkirieInit+266   p  ; was: sub_51372
                move.w  $2B0(a5),$9D0(a5)
                move.w  $2B4(a5),$9D4(a5)
                move.w  $2AE(a5),$9CE(a5)
                move.w  $2F6(a5),d0
                addi.w  #$10,d0
                asr.w   #3,d0
                andi.w  #$1C,d0
                move.l  off_5139A(pc,d0.w),$9C8(a5)
                rts
; End of function Boss_ValkirieUpdateGunSprite
; ---------------------------------------------------------------------------
off_5139A:      dc.l    word_EC7E6                      ; DATA XREF: Boss_ValkirieUpdateGunSprite+20   r
                dc.l    word_EC7EC
                dc.l    word_EC7F2
                dc.l    word_EC7FE
                dc.l    word_EC80A
                dc.l    word_EC810
                dc.l    word_EC816
                dc.l    word_EC822

; Main animation controller that processes animation frames, interpolation, and updates sprite tile indices for all Valkirie body parts
Boss_ValkirieAnimationController:                       ; CODE XREF: Boss_ValkirieInit:loc_51162   p  ; was: sub_513BA
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_51432
loc_513C4:                                              ; CODE XREF: Boss_ValkirieAnimationController+24   j
                                        ; Boss_ValkirieAnimationController+44   j
                move.w  $58(a5),d0
                bmi.w   loc_51442
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_513E0
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_513C4
; ---------------------------------------------------------------------------
loc_513E0:                                              ; CODE XREF: Boss_ValkirieAnimationController+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_513F0
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_513F0:                                              ; CODE XREF: Boss_ValkirieAnimationController+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_51400
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_513C4
; ---------------------------------------------------------------------------
loc_51400:                                              ; CODE XREF: Boss_ValkirieAnimationController+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #byte_5156E,d0
                movea.l d0,a0
                bsr.w   Boss_ValkirieSetupInterpolation
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_51442
loc_51432:                                              ; CODE XREF: Boss_ValkirieAnimationController+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$10,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_51442:                                              ; CODE XREF: Boss_ValkirieAnimationController+E   j
                                        ; Boss_ValkirieAnimationController+76   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                move.b  8(a0),d0
                ext.w   d0
                addq.w  #6,d0
                move.w  d0,$B4(a5)
                move.b  $C(a0),d0
                ext.w   d0
                addi.w  #8,d0
                move.w  d0,$114(a5)
                move.b  $10(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.w  d0,$236(a5)
                move.b  $14(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$296(a5)
                move.w  d1,$2F6(a5)
                move.b  $18(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.w  d0,$416(a5)
                move.b  $1C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$476(a5)
                move.w  d1,$4D6(a5)
                move.b  $20(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$536(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.w  d0,$656(a5)
                move.b  $28(a0),d0
                ext.w   d0
                move.w  d0,$654(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$6B6(a5)
                move.b  $30(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.w  d0,$776(a5)
                move.w  d0,$7D6(a5)
                move.b  $34(a0),d0
                ext.w   d0
                move.w  d0,$7D4(a5)
                rts
; End of function Boss_ValkirieAnimationController
; Sets up animation interpolation parameters for smooth transitions between Valkirie animation frames
Boss_ValkirieSetupInterpolation:                        ; CODE XREF: Boss_ValkirieAnimationController+5C   p  ; was: sub_51514
                lea     byte_51536(pc),a1
                nop
                moveq   #$10,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieSetupInterpolation
; Loads frame timing delays for Valkirie boss animation sequences
Boss_ValkirieLoadFrameTiming:
                moveq   #$10,d7                         ; was: sub_5152A
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_ValkirieLoadFrameTiming
; ---------------------------------------------------------------------------
byte_51536:     dc.b    $40, $C0, $80, $80, $A0, $80, $A0, $80, $80, $A0, $80, 0, $A0, $80, $80, $80
                                        ; DATA XREF: Boss_ValkirieSetupInterpolation   o
byte_51546:     dc.b    $10, $18, 0, 0, $10, $10, 0, 0, $10, $18, 0, $10, $20, $20, 0, $10
                                        ; DATA XREF: Boss_ValkirieInit+188   o
                dc.b    $FF, $FF, 8, $C, 0, $20, $12, $12, 0, $20, 2, 4, 0, $30, 9, 9
                dc.b    0, $30, $10, $30, 0, $20, $FF, $FE
byte_5156E:     dc.b    $BC, $4A, $11, $F, $2C, $98, $78, $A8, $E8, $36, 3, $90, $54, 4, 2, 3
                                        ; DATA XREF: Boss_ValkirieAnimationController+54   o
                dc.b    $CA, $41, $E, $12, $30, $96, $78, $AC, $D8, $1A, $FC, $A0, $3A, $FC, $A, 0
                dc.b    $C0, $46, $10, $12, 8, $F8, $50, $18, $E0, $50, 4, $A0, $20, 4, 0, 4
                dc.b    $B8, $3C, $11, $F, $F8, $C8, $48, 8, $C0, $40, $FC, $A0, $14, 4, 0, 6

; State handler for Valkirie miniboss variant with palette fade support
