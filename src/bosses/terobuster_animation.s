Boss_TerobusterInterpolateAnimation:                    ; CODE XREF: Boss_TerobusterMainAI+100   p  ; was: sub_391CC
                                        ; sub_386EE:loc_388B8   p
                clr.w   $1DC(a5)
                tst.w   $C(a5)
                bpl.s   loc_3922E
loc_391D6:                                              ; CODE XREF: Boss_TerobusterInterpolateAnimation+2A   j
                move.w  $58(a5),d0
                bmi.s   Boss_TerobusterApplyAngles
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_391EC
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_391EC:                                              ; CODE XREF: Boss_TerobusterInterpolateAnimation+18   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_391F8
                clr.w   $58(a5)
                bra.s   loc_391D6
; ---------------------------------------------------------------------------
loc_391F8:                                              ; CODE XREF: Boss_TerobusterInterpolateAnimation+24   j
                addq.w  #4,$58(a5)
                subq.w  #1,$17E(a5)
                addq.w  #1,$1DC(a5)
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3936A,d0
                movea.l d0,a0
                bsr.w   Boss_TerobusterCalculateDeltas
                move.b  (dword_FF8040).w,d1
                ext.w   d1
                add.w   d1,$C(a5)
                tst.w   $C(a5)
                bmi.s   Boss_TerobusterApplyAngles
loc_3922E:                                              ; CODE XREF: Boss_TerobusterInterpolateAnimation+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #5,d7
                jsr     (Anim_ApplyInterpolationStep).l
; End of function Boss_TerobusterInterpolateAnimation
; Applies animation angles to 9 boss body parts
Boss_TerobusterApplyAngles:                             ; CODE XREF: Boss_TerobusterMainAI:loc_3876C   p  ; was: sub_3923E
                                        ; sub_389CA:loc_389D4   p
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(dword_FF940C-M68K_RAM),a1
                tst.w   $A(a5)
                beq.s   loc_39252
                exg     a0,a1
loc_39252:                                              ; CODE XREF: Boss_TerobusterApplyAngles+10   j
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.w  d0,$116(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.w  d1,$1D6(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.b  (a1),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$296(a5)
                move.w  d0,$2F6(a5)
                move.b  4(a1),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$356(a5)
                move.w  d1,$3B6(a5)
                move.b  8(a1),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                rts
; End of function Boss_TerobusterApplyAngles
; Calculates interpolation deltas for smooth animation
Boss_TerobusterCalculateDeltas:                         ; CODE XREF: Boss_TerobusterInterpolateAnimation+4E   p  ; was: sub_392B0
                movea.l #Boss_TerobusterNeutralPose,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #5,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_TerobusterCalculateDeltas
; Loads animation frame delays for timing system
Boss_TerobusterLoadFrameDelays:                         ; CODE XREF: Boss_TerobusterSetup+120   p  ; was: sub_392C6
                                        ; Boss_TerobusterIntro+20   p
                movea.w #(dword_FF9400-M68K_RAM),a1
                moveq   #5,d7
                jmp     Anim_LoadFrameDelays
; End of function Boss_TerobusterLoadFrameDelays
; ---------------------------------------------------------------------------
word_392D2:     dc.w    4, 0, $FFFF                     ; DATA XREF: Boss_TerobusterMainAI:loc_3895E   o
word_392D8:     dc.w    3, 0, 1, $36, $FFFF
                                        ; DATA XREF: Boss_TerobusterMainAI+28A   o
word_392E2:     dc.w    $10, $2A, $20, $30, $FFFE
                                        ; DATA XREF: Boss_TerobusterDescend+28   o
word_392EC:     dc.w    $FD12, $30, $34, $30, $F040, $24, $20, $24, $FFFE
                                        ; DATA XREF: Boss_TerobusterDescend:loc_38A54   o
word_392FE:     dc.w    $1C, 0, $FFFE                   ; DATA XREF: Boss_TerobusterDescend+4E   o
word_39304:     dc.w    5, 0, $FA0E, 0, $E, 6, $14, $C, 5, $12, $FA0E, $12, $E, $18, $14, $1E
                                        ; DATA XREF: Boss_TerobusterMainAI+FA   o
                dc.w    $FFFF
word_39326:     dc.w    $14, $1E, $E, $18, 5, $12, $FA0E, $12, $14, $C, $E, 6, 5, 0, $FA0E, 0
                                        ; DATA XREF: Boss_TerobusterMainAI+1BA   o
                dc.w    $FFFF
word_39348:     dc.w    6, $1E, 8, $18, 3, $12, $FA08, $12, 6, $C, 8, 6, 3, 0, $FA08, 0
                                        ; DATA XREF: Boss_TerobusterMainAI+1B4   o
                dc.w    $FFFF
word_3936A:     dc.w    $1330, $F840, $30D0, $F460, $C030, $44C8, $3060, $9024
                                        ; DATA XREF: Boss_TerobusterSetup+11A   o
                                        ; Boss_TerobusterDescend+A6   o
                dc.w    $24F8, $4030, $D013, $30F8, $3044, $C8F4, $60C0, $2424
                dc.w    $F830, $6090, $2040, $E020, $40E0, $4000, $CC40, $CC
word_3939A:     dc.w    $70, $D400, $70D4, $1431, $F842, $2ED0
                                        ; DATA XREF: Boss_TerobusterIntro+1A   o

; Sets up palette color sequence for visual effect with repeated values
Gfx_SetPaletteSequence:                                 ; CODE XREF: Boss_TerobusterIntro+24   p  ; was: sub_393A6
                movea.l #(M68K_RAM_PHYSICAL+(byte_FF644A-M68K_RAM)),a0
                move.b  #$CE,d0
                move.b  #$C5,(a0)+
                move.b  d0,(a0)+
                move.b  d0,(a0)+
                move.b  d0,(a0)+
                move.b  d0,(a0)+
                rts
; End of function Gfx_SetPaletteSequence
; Loads compressed tiles by index with bounds checking
Boss_TerobusterLoadTilesByIndex:                        ; CODE XREF: Boss_TerobusterDescend+E   p  ; was: sub_393BE
                asl.w   #2,d0
                bmi.s   locret_393D2
                cmpi.w  #$4C,d0                         ; 'L'
                bpl.s   locret_393D2
                movea.l off_393D4(pc,d0.w),a0
                jmp     Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
locret_393D2:                                           ; CODE XREF: Boss_TerobusterLoadTilesByIndex+2   j
                                        ; Boss_TerobusterLoadTilesByIndex+8   j
                rts
; End of function Boss_TerobusterLoadTilesByIndex
; ---------------------------------------------------------------------------
off_393D4:      dc.l    byte_394D0                      ; DATA XREF: Boss_TerobusterLoadTilesByIndex+A   r
                dc.l    byte_394C8
                dc.l    byte_394C0
                dc.l    byte_394B8
                dc.l    byte_394B0
                dc.l    byte_394A8
                dc.l    byte_394A0
                dc.l    byte_39496
                dc.l    byte_3948C
                dc.l    byte_39482
                dc.l    byte_39478
                dc.l    byte_3946E
                dc.l    byte_39464
                dc.l    byte_3945A
                dc.l    byte_39450
                dc.l    byte_39444
                dc.l    byte_39438
                dc.l    byte_3942C
                dc.l    byte_39420
byte_39420:     dc.b    $42, $51, $40, 0, 4, 0, $C2, $C7, $C6, $C6, $C6, 0
                                        ; DATA XREF: ROM:0003941C   o
byte_3942C:     dc.b    $42, $51, $40, 0, 4, 0, $C3, $C8, $B9, $B9, $B9, 0
                                        ; DATA XREF: ROM:00039418   o
byte_39438:     dc.b    $42, $51, $40, 0, 4, 0, $C4, $C9, $C6, $C6, $C6, 0
                                        ; DATA XREF: ROM:00039414   o
byte_39444:     dc.b    $42, $51, $40, 0, 4, 0, $C5, $CA, $B9, $B9, $B9, 0
                                        ; DATA XREF: ROM:00039410   o
byte_39450:     dc.b    $42, $59, $40, 0, 3, 0, $CB, $C7, $C6, $C6
                                        ; DATA XREF: ROM:0003940C   o
byte_3945A:     dc.b    $42, $59, $40, 0, 3, 0, $CC, $C8, $B9, $B9
                                        ; DATA XREF: ROM:00039408   o
byte_39464:     dc.b    $42, $59, $40, 0, 3, 0, $CD, $C9, $C6, $C6
                                        ; DATA XREF: ROM:00039404   o
byte_3946E:     dc.b    $42, $59, $40, 0, 3, 0, $CE, $CA, $B9, $B9
                                        ; DATA XREF: ROM:00039400   o
byte_39478:     dc.b    $42, $61, $40, 0, 2, 0, $CB, $C7, $C6, 0
                                        ; DATA XREF: ROM:000393FC   o
byte_39482:     dc.b    $42, $61, $40, 0, 2, 0, $CC, $C8, $B9, 0
                                        ; DATA XREF: ROM:000393F8   o
byte_3948C:     dc.b    $42, $61, $40, 0, 2, 0, $CD, $C9, $C6, 0
                                        ; DATA XREF: ROM:000393F4   o
byte_39496:     dc.b    $42, $61, $40, 0, 2, 0, $CE, $CA, $B9, 0
                                        ; DATA XREF: ROM:000393F0   o
byte_394A0:     dc.b    $42, $69, $40, 0, 1, 0, $CB, $C7
                                        ; DATA XREF: ROM:000393EC   o
byte_394A8:     dc.b    $42, $69, $40, 0, 1, 0, $CC, $C8
                                        ; DATA XREF: ROM:000393E8   o
byte_394B0:     dc.b    $42, $69, $40, 0, 1, 0, $CD, $C9
                                        ; DATA XREF: ROM:000393E4   o
byte_394B8:     dc.b    $42, $69, $40, 0, 1, 0, $CE, $CA
                                        ; DATA XREF: ROM:000393E0   o
byte_394C0:     dc.b    $42, $71, $40, 0, 1, 0, $CE, $CB
                                        ; DATA XREF: ROM:000393DC   o
byte_394C8:     dc.b    $42, $71, $40, 0, 1, 0, $CE, $CD
                                        ; DATA XREF: ROM:000393D8   o
byte_394D0:     dc.b    $42, $71, $40, 0, 1, 0, $CE, $CE
                                        ; DATA XREF: ROM:off_393D4   o

; Main Shellshogun boss handler with state dispatch
