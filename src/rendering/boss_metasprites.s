Sprite_InitMetaspriteSimple:                            ; CODE XREF: Boss_AntroidSetupMetasprite+2   j  ; was: sub_343CE
                                        ; Boss_TerobusterInitMetasprite+2   p
                bsr.w   Sprite_InitMetaspritePointers
                bra.w   Sprite_IncrementMetaspriteCount
; End of function Sprite_InitMetaspriteSimple
; Updates metasprite part angles from table
Sprite_UpdateMetaspriteAngles:                          ; CODE XREF: Boss_FlyingNeoUpdateSprites+2E   p  ; was: sub_343D6
                bsr.w   Sprite_UpdateMetaspriteRotation
                bra.w   Sprite_IncrementMetaspriteCount
; End of function Sprite_UpdateMetaspriteAngles
; Updates metasprite part angles
Sprite_UpdateMetaspriteParts:                           ; CODE XREF: Boss_DeepStriderUpdateParts+D0   j  ; was: sub_343DE
                bsr.w   Sprite_CalculateRotationOffset
                bra.w   Sprite_IncrementMetaspriteCount
; End of function Sprite_UpdateMetaspriteParts
; Updates metasprite parts
Boss_BackStringerUpdateMetasprite:                      ; CODE XREF: Boss_BackStringerUpdateRender+A   j  ; was: sub_343E6
                bsr.w   Boss_CalculateSegmentChain
                bra.w   Sprite_IncrementMetaspriteCount
; End of function Boss_BackStringerUpdateMetasprite
; Complex metasprite initialization with flags and rotation
Sprite_InitMetaspriteComplex:                           ; CODE XREF: Boss_AntroidInitPhase+20   p  ; was: sub_343EE
                                        ; Boss_TerobusterSetup+28   p
                move.w  a5,(dword_FF8040+2).w
loc_343F2:                                              ; CODE XREF: Boss_AntroidInitPhase+3A   p
                moveq   #0,d0
                move.w  d0,d1
                move.w  d0,d2
                move.w  d0,d3
loc_343FA:                                              ; CODE XREF: Sprite_InitMetaspriteComplex+108   j
                move.l  (a0,d1.w),d4
                beq.w   loc_34486
                move.l  d4,d5
                move.l  d4,d6
                movea.l d4,a3
                andi.l  #$7FFFFFF,d4
                andi.l  #$F0000000,d5
                andi.l  #$8000000,d6
                bclr    #0,d4
                bne.s   loc_3445A
                bclr    #$16,d4
                beq.s   loc_3443C
                move.w  #$C000,2(a4)
                move.w  (dword_FF8040).w,$E(a4)
                move.l  d4,8(a4)
                clr.l   $4C(a4)
                bra.s   loc_34486
; ---------------------------------------------------------------------------
loc_3443C:                                              ; CODE XREF: Sprite_InitMetaspriteComplex+36   j
                move.w  #$C000,2(a4)
                move.w  (dword_FF8040).w,$E(a4)
                move.l  d4,$4C(a4)
                rol.l   #8,d5
                rol.w   #1,d5
                swap    d6
                or.w    d6,d5
                move.w  d5,$50(a4)
                bra.s   loc_34486
; ---------------------------------------------------------------------------
loc_3445A:                                              ; CODE XREF: Sprite_InitMetaspriteComplex+30   j
                move.w  #$8000,2(a4)
                movem.l a3,-(sp)
                movea.l d4,a3
                move.w  (a3)+,$E(a4)
                move.w  (a3)+,8(a4)
                move.w  (a3),$A(a4)
                movem.l (sp)+,a3
                clr.l   $4C(a4)
                move.w  (dword_FF8040).w,d4
                andi.w  #$8000,d4
                or.w    d4,$E(a4)
loc_34486:                                              ; CODE XREF: Sprite_InitMetaspriteComplex+10   j
                                        ; Sprite_InitMetaspriteComplex+4C   j
                move.w  d0,d4
                move.b  (a1,d3.w),d4
                move.w  d4,d5
                andi.w  #$7F,d4
                move.w  d4,$52(a4)
                move.w  d4,$54(a4)
                move.w  d0,$56(a4)
                andi.w  #$80,d5
                beq.s   loc_344AA
                ori.w   #$8000,$E(a4)
loc_344AA:                                              ; CODE XREF: Sprite_InitMetaspriteComplex+B4   j
                move.w  (a2,d2.w),d4
                move.w  d4,d5
                andi.w  #$3FE0,d4
                add.w   (dword_FF8040+2).w,d4
                move.w  d4,$4A(a4)
                move.w  (dword_FF8040+2).w,$48(a4)
                move.w  d5,d4
                andi.w  #$C000,d4
                andi.w  #$1F,d5
                asl.w   #2,d5
                move.b  d5,$20(a4)
                move.l  a3,d5
                andi.l  #$3000000,d5
                swap    d5
                asl.w   #5,d5
                lsr.w   #1,d4
                or.w    d4,$E(a4)
                or.w    d5,$E(a4)
                move.w  #$10,(a4)
                addq.w  #4,d1
                addq.w  #2,d2
                addq.w  #1,d3
                lea     $60(a4),a4
                dbf     d7,loc_343FA
                ori.w   #$C00,2(a5)
                rts
; End of function Sprite_InitMetaspriteComplex
; Initializes metasprite pointers and count for rendering
Sprite_InitMetaspritePointers:                          ; CODE XREF: Sprite_InitMetaspriteSimple   p  ; was: sub_34502
                                        ; Boss_MadamBarbarUpdateParts+6   p
                movea.w a5,a4
                movea.w a4,a3
                lea     $60(a4),a4
                move.w  d7,(dword_FF8040).w
; End of function Sprite_InitMetaspritePointers
; Updates metasprite rotation and sine-based positioning
Sprite_UpdateMetaspriteRotation:                        ; CODE XREF: Sprite_UpdateMetaspriteAngles   p  ; was: sub_3450E
                lea     (word_1B514).l,a2
                move.w  $54(a5),d3
                move.w  $56(a5),d4
                move.w  $50(a5),d5
                move.w  #$1FE,d6
loc_34524:                                              ; CODE XREF: Sprite_UpdateMetaspriteRotation+9E   j
                move.w  $56(a4),d0
                add.w   d4,d0
                move.l  $4C(a4),d1
                beq.s   loc_34574
                movea.l d1,a0
                move.w  $E(a4),d2
                move.w  d0,d1
                add.w   $50(a4),d1
                subi.w  #$10,d1
                and.w   d6,d1
                ori.w   #$1800,d2
                cmpi.w  #$100,d1
                bpl.s   loc_34550
                andi.w  #$E7FF,d2
loc_34550:                                              ; CODE XREF: Sprite_UpdateMetaspriteRotation+3C   j
                cmpi.w  #$100,d3
                bmi.s   loc_3455A
                eori.w  #$800,d2
loc_3455A:                                              ; CODE XREF: Sprite_UpdateMetaspriteRotation+46   j
                asr.w   #3,d1
                andi.w  #$1C,d1
                move.l  (a0,d1.w),8(a4)
                move.w  $50(a4),d1
                andi.w  #$800,d1
                eor.w   d1,d2
                move.w  d2,$E(a4)
loc_34574:                                              ; CODE XREF: Sprite_UpdateMetaspriteRotation+20   j
                move.w  $54(a4),d2
                add.w   d5,d2
                bpl.s   loc_3457E
                moveq   #0,d2
loc_3457E:                                              ; CODE XREF: Sprite_UpdateMetaspriteRotation+6C   j
                move.w  d0,d1
                add.w   d3,d1
                and.w   d6,d0
                and.w   d6,d1
                move.w  -$80(a2,d0.w),d0
                move.w  (a2,d1.w),d1
                asl.w   #2,d2
                muls.w  d2,d0
                muls.w  d2,d1
                movea.w $4A(a4),a0
                add.l   $44(a0),d0
                move.l  d0,$44(a4)
                add.l   $40(a0),d1
                move.l  d1,$40(a4)
                lea     $60(a4),a4
                dbf     d7,loc_34524
                rts
; End of function Sprite_UpdateMetaspriteRotation
; Plays intro sound effects
Boss_ValkiriePlayIntroSFX:                              ; CODE XREF: Boss_ValkirieMovePattern3+2   j  ; was: sub_345B2
                movea.w a5,a4
                move.w  d7,(dword_FF8040).w
                lea     $60(a4),a4
                lea     (word_1B514).l,a2
                move.w  $56(a5),d4
                move.w  $50(a5),d5
                move.w  #$1FE,d6
loc_345CE:                                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+A4   j
                move.w  $56(a4),d0
                add.w   d4,d0
                move.l  $4C(a4),d1
                beq.s   loc_3461E
                movea.l d1,a0
                move.w  $E(a4),d2
                move.w  d0,d1
                add.w   $50(a4),d1
                subi.w  #$10,d1
                and.w   d6,d1
                ori.w   #$1800,d2
                cmpi.w  #$100,d1
                bpl.s   loc_345FA
                andi.w  #$E7FF,d2
loc_345FA:                                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+42   j
                cmpi.w  #$100,d3
                bmi.s   loc_34604
                eori.w  #$800,d2
loc_34604:                                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+4C   j
                asr.w   #3,d1
                andi.w  #$1C,d1
                move.l  (a0,d1.w),8(a4)
                move.w  $50(a4),d1
                andi.w  #$800,d1
                eor.w   d1,d2
                move.w  d2,$E(a4)
loc_3461E:                                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+26   j
                move.w  $54(a4),d2
                add.w   d5,d2
                bpl.s   loc_34628
                moveq   #0,d2
loc_34628:                                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+72   j
                move.w  d0,d1
                add.w   d3,d1
                and.w   d6,d0
                and.w   d6,d1
                move.w  -$80(a2,d0.w),d0
                move.w  (a2,d1.w),d1
                asl.w   #2,d2
                muls.w  d2,d0
                muls.w  d2,d1
                movea.w $4A(a4),a0
                add.l   $44(a0),d0
                move.l  d0,$44(a4)
                add.l   $40(a0),d1
                move.l  d1,$40(a4)
                lea     $60(a4),a4
                dbf     d7,loc_345CE
                movea.w a5,a4
                move.w  (dword_FF8040).w,d7
                addq.w  #1,d7
                movea.w $48(a5),a0
                movea.w $4A(a5),a1
                move.w  $10(a0),d0
                sub.w   $40(a0),d0
                move.w  $14(a1),d1
                sub.w   $44(a1),d1
loc_3467A:                                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+E0   j
                move.w  d0,d2
                add.w   $40(a4),d2
                move.w  d2,$10(a4)
                move.w  d1,d2
                add.w   $44(a4),d2
                move.w  d2,$14(a4)
                lea     $60(a4),a4
                dbf     d7,loc_3467A
                rts
; End of function Boss_ValkiriePlayIntroSFX
; Updates metasprite parts with rotation and position calculations
Sprite_CalculateRotationOffset:                         ; CODE XREF: Sprite_UpdateMetaspriteParts   p  ; was: sub_34698
                movea.w a5,a4
                movea.w a4,a3
                lea     $60(a4),a4
                move.w  d7,(dword_FF8040).w
                lea     (word_1B514).l,a2
                move.w  $54(a5),d3
                move.w  $56(a5),d4
                move.w  $50(a5),d5
                move.w  #$1FE,d6
loc_346BA:                                              ; CODE XREF: Sprite_CalculateRotationOffset+AA   j
                move.w  $56(a4),d0
                add.w   d4,d0
                move.l  $4C(a4),d1
                beq.s   loc_3470A
                movea.l d1,a0
                move.w  $E(a4),d2
                move.w  d0,d1
                add.w   $50(a4),d1
                subi.w  #$20,d1                         ; ' '
                and.w   d6,d1
                ori.w   #$1800,d2
                cmpi.w  #$100,d1
                bpl.s   loc_346E6
                andi.w  #$E7FF,d2
loc_346E6:                                              ; CODE XREF: Sprite_CalculateRotationOffset+48   j
                cmpi.w  #$100,d3
                bmi.s   loc_346F0
                eori.w  #$800,d2
loc_346F0:                                              ; CODE XREF: Sprite_CalculateRotationOffset+52   j
                asr.w   #4,d1
                andi.w  #$C,d1
                move.l  (a0,d1.w),8(a4)
                move.w  $50(a4),d1
                andi.w  #$800,d1
                eor.w   d1,d2
                move.w  d2,$E(a4)
loc_3470A:                                              ; CODE XREF: Sprite_CalculateRotationOffset+2C   j
                move.w  $54(a4),d2
                add.w   d5,d2
                bpl.s   loc_34714
                moveq   #0,d2
loc_34714:                                              ; CODE XREF: Sprite_CalculateRotationOffset+78   j
                move.w  d0,d1
                add.w   d3,d1
                and.w   d6,d0
                and.w   d6,d1
                move.w  -$80(a2,d0.w),d0
                move.w  (a2,d1.w),d1
                asl.w   #2,d2
                muls.w  d2,d0
                muls.w  d2,d1
                movea.w $4A(a4),a0
                add.l   $44(a0),d0
                move.l  d0,$44(a4)
                add.l   $40(a0),d1
                move.l  d1,$40(a4)
                lea     $60(a4),a4
                dbf     d7,loc_346BA
                rts
; End of function Sprite_CalculateRotationOffset
; Calculates positions and rotations for chain of sprite segments
Boss_CalculateSegmentChain:                             ; CODE XREF: Boss_BackStringerUpdateMetasprite   p  ; was: sub_34748
                movea.w a5,a4
                movea.w a4,a3
                lea     $60(a4),a4
                move.w  d7,(dword_FF8040).w
                lea     (word_1B514).l,a2
                move.w  $54(a5),d3
                move.w  $56(a5),d4
                move.w  $50(a5),d5
                move.w  #$1FE,d6
loc_3476A:                                              ; CODE XREF: Boss_CalculateSegmentChain+EA   j
                move.w  $56(a4),d0
                add.w   d4,d0
                move.l  $4C(a4),d1
                beq.s   loc_347BA
                movea.l d1,a0
                move.w  $E(a4),d2
                move.w  d0,d1
                add.w   $50(a4),d1
                subi.w  #$10,d1
                and.w   d6,d1
                ori.w   #$1800,d2
                cmpi.w  #$100,d1
                bpl.s   loc_34796
                andi.w  #$E7FF,d2
loc_34796:                                              ; CODE XREF: Boss_CalculateSegmentChain+48   j
                cmpi.w  #$100,d3
                bmi.s   loc_347A0
                eori.w  #$800,d2
loc_347A0:                                              ; CODE XREF: Boss_CalculateSegmentChain+52   j
                asr.w   #3,d1
                andi.w  #$1C,d1
                move.l  (a0,d1.w),8(a4)
                move.w  $50(a4),d1
                andi.w  #$800,d1
                eor.w   d1,d2
                move.w  d2,$E(a4)
loc_347BA:                                              ; CODE XREF: Boss_CalculateSegmentChain+2C   j
                move.w  $54(a4),d2
                add.w   d5,d2
                bpl.s   loc_347C4
                moveq   #0,d2
loc_347C4:                                              ; CODE XREF: Boss_CalculateSegmentChain+78   j
                move.w  d0,d1
                add.w   d3,d1
                and.w   d6,d0
                and.w   d6,d1
                movea.w $4A(a4),a0
                btst    #1,$20(a4)
                bne.s   loc_347DA
                addq.w  #8,a0
loc_347DA:                                              ; CODE XREF: Boss_CalculateSegmentChain+8E   j
                move.w  -$80(a2,d0.w),(word_FF8048).w
                move.w  (a2,d1.w),(word_FF804A).w
                move.w  (word_FF8048).w,d0
                move.w  (word_FF804A).w,d1
                asl.w   #2,d2
                muls.w  d2,d0
                muls.w  d2,d1
                add.l   $3C(a0),d0
                move.l  d0,$44(a4)
                add.l   $38(a0),d1
                move.l  d1,$40(a4)
                btst    #0,$20(a4)
                beq.s   loc_3482E
                move.w  d2,d0
                asr.w   #1,d0
                add.w   d0,d2
                move.w  (word_FF8048).w,d0
                move.w  (word_FF804A).w,d1
                muls.w  d2,d0
                muls.w  d2,d1
                add.l   $3C(a0),d0
                move.l  d0,$3C(a4)
                add.l   $38(a0),d1
                move.l  d1,$38(a4)
loc_3482E:                                              ; CODE XREF: Boss_CalculateSegmentChain+C2   j
                lea     $60(a4),a4
                dbf     d7,loc_3476A
                rts
; End of function Boss_CalculateSegmentChain
; Increments metasprite object counter
Sprite_IncrementMetaspriteCount:                        ; CODE XREF: Sprite_InitMetaspriteSimple+4   j  ; was: sub_34838
                                        ; Sprite_UpdateMetaspriteAngles+4   j
                move.w  (dword_FF8040).w,d7
                addq.w  #1,d7
; End of function Sprite_IncrementMetaspriteCount
; Updates positions of linked child objects from parent
Sprite_UpdateLinkedPositions:                           ; CODE XREF: Boss_JetsripperRotateState+42   p  ; was: sub_3483E
                                        ; Boss_JetsripperUpdateMovement+A0   p
                movea.w $48(a5),a0
                movea.w $4A(a5),a1
                move.w  $10(a0),d0
                sub.w   $40(a0),d0
                move.w  $14(a1),d1
                sub.w   $44(a1),d1
loc_34856:                                              ; CODE XREF: Sprite_UpdateLinkedPositions+30   j
                move.w  d0,d2
                add.w   $40(a3),d2
                move.w  d2,$10(a3)
                move.w  d1,d2
                add.w   $44(a3),d2
                move.w  d2,$14(a3)
                lea     $60(a3),a3
                dbf     d7,loc_34856
                rts
; End of function Sprite_UpdateLinkedPositions
; Updates boss blade sprite and flip
Sprite_UpdateBossBladeSprite:                           ; CODE XREF: Boss_SharpssteelCoreMain+10   p  ; was: sub_34874
                                        ; Boss_SharpssteelCoreMain+20   j
                move.w  $56(a0),d0
                add.w   $56(a5),d0
                addi.w  #$20,d0                         ; ' '
                andi.w  #$1FE,d0
                cmpi.w  #$100,d0
                bmi.s   loc_34890
                eori.w  #$1800,$E(a0)
loc_34890:                                              ; CODE XREF: Sprite_UpdateBossBladeSprite+14   j
                tst.w   $54(a5)
                bne.s   loc_3489C
                eori.w  #$800,$E(a0)
loc_3489C:                                              ; CODE XREF: Sprite_UpdateBossBladeSprite+20   j
                asr.w   #4,d0
                andi.w  #$C,d0
                move.l  (a1,d0.w),8(a0)
                rts
; End of function Sprite_UpdateBossBladeSprite
; Calculates interpolation deltas for animation blending
Anim_CalculateInterpolationDeltas:                      ; CODE XREF: Boss_AntroidResetAnimation+10   j  ; was: sub_348AA
                                        ; Boss_TerobusterCalculateDeltas+10   j
                move.w  #$FF,d4
loc_348AE:                                              ; CODE XREF: Anim_CalculateInterpolationDeltas+1C   j
                move.b  (a0)+,d0
                move.w  (a2)+,d1
                asr.w   #8,d1
                sub.b   (a1),d0
                sub.b   (a1)+,d1
                and.w   d4,d0
                and.w   d4,d1
                sub.w   d1,d0
                ext.l   d0
                lsl.w   #8,d0
                divs.w  d3,d0
                move.w  d0,(a2)+
                dbf     d7,loc_348AE
                rts
; End of function Anim_CalculateInterpolationDeltas
; Loads animation frame delays converting bytes to words
Anim_LoadFrameDelays:                                   ; CODE XREF: Boss_AntroidLoadFrameDelays+6   j  ; was: sub_348CC
                                        ; Boss_TerobusterLoadFrameDelays+6   j
                moveq   #0,d1
loc_348CE:                                              ; CODE XREF: Anim_LoadFrameDelays+A   j
                move.b  (a0)+,d0
                asl.w   #8,d0
                move.w  d0,(a1)+
                move.w  d1,(a1)+
                dbf     d7,loc_348CE
                rts
; End of function Anim_LoadFrameDelays
; Applies single interpolation step to animation values
Anim_ApplyInterpolationStep:                            ; CODE XREF: Anim_InterpolateToTarget+8C   p  ; was: sub_348DC
                                        ; Boss_TerobusterInterpolateAnimation+6C   p
                movea.l a0,a1
loc_348DE:                                              ; CODE XREF: Anim_ApplyInterpolationStep+A   j
                move.w  (a0)+,d1
                add.w   (a0)+,d1
                move.w  d1,(a1)
                addq.w  #4,a1
                dbf     d7,loc_348DE
                rts
; End of function Anim_ApplyInterpolationStep
; Clears 0x11 longwords in RAM buffer starting at 0xFFFF9400
Data_ClearBuffer:
                move.w  #$10,d7                         ; was: sub_348EC
                moveq   #0,d0
                movea.l #$FFFF9400,a0
loc_348F8:                                              ; CODE XREF: Data_ClearBuffer+E   j
                move.l  d0,(a0)+
                dbf     d7,loc_348F8
                rts
; End of function Data_ClearBuffer
; Updates sprite tile mapping based on rotation angle with horizontal flip
Sprite_UpdateRotatedFrame:                              ; CODE XREF: Projectile_BackStringerChainFalling:loc_45ACA   j  ; was: sub_34900
                movea.l $4C(a5),a0
                move.w  $E(a5),d2
                move.w  $56(a5),d1
                add.w   $50(a5),d1
                subi.w  #$10,d1
                andi.w  #$1FE,d1
                ori.w   #$1800,d2
                cmpi.w  #$100,d1
                bpl.s   loc_34926
                andi.w  #$E7FF,d2
loc_34926:                                              ; CODE XREF: Sprite_UpdateRotatedFrame+20   j
                cmpi.w  #$100,d3
                bmi.s   loc_34930
                eori.w  #$800,d2
loc_34930:                                              ; CODE XREF: Sprite_UpdateRotatedFrame+2A   j
                asr.w   #3,d1
                andi.w  #$1C,d1
                move.l  (a0,d1.w),8(a5)
                move.w  $50(a5),d1
                andi.w  #$800,d1
                eor.w   d1,d2
                move.w  d2,$E(a5)
                rts
; End of function Sprite_UpdateRotatedFrame
; ---------------------------------------------------------------------------
