Projectile_ArtemisMain:                                 ; CODE XREF: Boss_ArtemisAttackState2+28   p  ; was: sub_584DC
                                        ; Boss_ArtemisAttackState2+36   p
                move.w  $14(a0),d0
                move.w  d6,$14(a0)
                sub.w   d6,d0
                sub.w   d0,$74(a0)
                rts
; End of function Projectile_ArtemisMain
; Attack state 3 handler
Boss_ArtemisAttackState3:                               ; CODE XREF: Boss_ArtemisAttackState2+4   p  ; was: sub_584EC
                moveq   #7,d6
                move.b  (a0),d3
                asl.w   #1,d3
                and.w   d7,d3
                move.w  d3,$B6(a5)
                move.b  4(a0),d4
                asl.w   #1,d4
                and.w   d7,d4
                move.w  d4,$116(a5)
                move.b  8(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.w  d1,$1D6(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                moveq   #0,d0
                move.w  $10(a0),d0
                swap    d0
                asr.l   d6,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$296(a5)
                move.w  d0,$2F6(a5)
                swap    d0
                moveq   #0,d1
                move.w  $14(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$356(a5)
                move.w  d1,$3B6(a5)
                swap    d1
                moveq   #0,d0
                move.w  $18(a0),d0
                swap    d0
                asr.l   d6,d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$476(a5)
                moveq   #0,d0
                move.w  $20(a0),d0
                swap    d0
                asr.l   d6,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.w  d0,$536(a5)
                swap    d0
                moveq   #0,d1
                move.w  $24(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$596(a5)
                move.w  d1,$5F6(a5)
                swap    d1
                moveq   #0,d0
                move.w  $28(a0),d0
                swap    d0
                asr.l   d6,d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$656(a5)
                moveq   #0,d0
                move.w  $2C(a0),d0
                swap    d0
                asr.l   d6,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$6B6(a5)
                move.w  d0,d2
                subi.w  #$40,d2                         ; '@'
                and.w   d7,d2
                move.w  d2,$716(a5)
                swap    d0
                moveq   #0,d1
                move.w  $30(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$776(a5)
                move.w  d1,$7D6(a5)
                swap    d1
                moveq   #0,d0
                move.w  $34(a0),d0
                swap    d0
                asr.l   d6,d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$836(a5)
                moveq   #0,d0
                move.w  $38(a0),d0
                swap    d0
                asr.l   d6,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$896(a5)
                move.w  d0,d2
                subi.w  #$40,d2                         ; '@'
                and.w   d7,d2
                move.w  d2,$8F6(a5)
                swap    d0
                moveq   #0,d1
                move.w  $3C(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$956(a5)
                move.w  d1,$9B6(a5)
                swap    d1
                moveq   #0,d0
                move.w  $40(a0),d0
                swap    d0
                asr.l   d6,d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$A16(a5)
                moveq   #0,d0
                move.w  $44(a0),d0
                swap    d0
                asr.l   d6,d0
                move.l  #$1E00000,d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$A76(a5)
                swap    d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$AD6(a5)
                swap    d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$B36(a5)
                move.b  $48(a0),d1
                ext.w   d1
                move.w  $B2(a5),d0
                add.w   d1,d0
                move.w  d0,$B4(a5)
                move.w  $112(a5),d0
                add.w   d1,d0
                move.w  d0,$114(a5)
                tst.b   $3BD(a5)
                bne.s   loc_586AC
                clr.w   $4C(a0)
                rts
; ---------------------------------------------------------------------------
loc_586AC:                                              ; CODE XREF: Boss_ArtemisAttackState3+1B8   j
                move.w  $4C(a0),d1
                asr.w   #6,d1
                and.w   d7,d1
                move.w  d1,$56(a5)
                rts
; End of function Boss_ArtemisAttackState3
; Movement pattern 1
Boss_ArtemisMovePattern1:                               ; CODE XREF: Boss_ArtemisAttackState2   p  ; was: sub_586BA
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_58734
loc_586C4:                                              ; CODE XREF: Boss_ArtemisMovePattern1+24   j
                                        ; Boss_ArtemisMovePattern2+E   j
                move.w  $58(a5),d0
                bmi.w   loc_5874C
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_586E0
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_586C4
; ---------------------------------------------------------------------------
loc_586E0:                                              ; CODE XREF: Boss_ArtemisMovePattern1+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Boss_ArtemisMovePattern2
                move.w  d3,$58(a5)
                bra.w   loc_5874C
; End of function Boss_ArtemisMovePattern1
nullsub_131:
                rts
; End of function nullsub_131

; Movement pattern 2
Boss_ArtemisMovePattern2:                               ; CODE XREF: Boss_ArtemisMovePattern1+2E   j  ; was: sub_586F4
                cmpi.w  #$FFFF,d3
                bne.s   loc_58704
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_586C4
; ---------------------------------------------------------------------------
loc_58704:                                              ; CODE XREF: Boss_ArtemisMovePattern2+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w   Boss_ArtemisMovePattern3
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_5874C
loc_58734:                                              ; CODE XREF: Boss_ArtemisMovePattern1+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$13,d7
                tst.b   $3BD(a5)
                beq.s   loc_58746
                addq.w  #1,d7
loc_58746:                                              ; CODE XREF: Boss_ArtemisMovePattern2+4E   j
                jsr     (Anim_ApplyInterpolationStep).l
loc_5874C:                                              ; CODE XREF: Boss_ArtemisMovePattern1+E   j
                                        ; Boss_ArtemisMovePattern1+34   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_ArtemisMovePattern2
; Movement pattern 3
Boss_ArtemisMovePattern3:                               ; CODE XREF: Boss_ArtemisMovePattern2+24   p  ; was: sub_58756
                movea.l $2FC(a5),a1
                moveq   #$13,d7
                tst.b   $3BD(a5)
                beq.s   loc_58764
                addq.w  #1,d7
loc_58764:                                              ; CODE XREF: Boss_ArtemisMovePattern3+A   j
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_ArtemisMovePattern3
; Loads animation frame delays based on boss state
Boss_ArtemisLoadAnimationFrames:
                moveq   #$13,d7                         ; was: sub_58772
                tst.b   $3BD(a5)
                beq.s   loc_5877C
                addq.w  #1,d7
loc_5877C:                                              ; CODE XREF: Boss_ArtemisLoadAnimationFrames+6   j
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_ArtemisLoadAnimationFrames
; ---------------------------------------------------------------------------
word_58786:     dc.w    $1010, $50, $4040, $64, $FFFE
                                        ; DATA XREF: Boss_ArtemisPlayerInputControl+1E   o
                                        ; Boss_ArtemisAttackState1+20   o
word_58790:     dc.w    $808, $50, $E10, $64, $4040, $64, $FFFE
                                        ; DATA XREF: Boss_ArtemisAttackState1+8C   o
word_5879E:     dc.w    $C0C, $78, $1212, $8C, $840, $A0, $1818, $A0
                                        ; DATA XREF: Boss_ArtemisShootPattern2+6   o
                dc.w    $FFFE
word_587B0:     dc.w    $C14, 0, $40E, 0, $208, 0, $20B, $3C
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile3:loc_58158   o
                                        ; sub_5818C:off_5820C   o
                dc.w    $208, 0, $20B, $3C, $208, 0, $20B, $3C
                dc.w    $1010, 0, $80E, $28, $909, $28, $A0A, $3C
                dc.w    $FFFE
word_587E2:     dc.w    $810, 0, $80E, $28, $909, $28, $A0A, $3C
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile6+98   o
                                        ; Boss_ArtemisSpawnProjectile6+9C   o
                dc.w    $FFFE
word_587F4:     dc.w    $40A, 0, $60C, $28, $505, $28, $606, $3C
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile6+90   o
                                        ; Boss_ArtemisSpawnProjectile6+94   o
                dc.w    $FFFE
word_58806:     dc.w    $1034, 0, $30C, $28, $1010, $28, $410, $3C
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile6+88   o
                                        ; Boss_ArtemisSpawnProjectile6+8C   o
                dc.w    $FFFE
word_58818:     dc.w    $818, $28, $2020, $28, $1818, $3C, $FFFE
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile6+84   o
word_58826:     dc.w    $A0A, $B4, $808, $C8, $1515, $DC, $8001, $A0E
                                        ; DATA XREF: Projectile_ArtemisBullet1+10   o
                                        ; Boss_ArtemisAnimationUpdate+C   o
                dc.w    $F0, $505, $F0, $800F, $818, $104, $A0A, $104
                dc.w    $FFFE
word_58848:     dc.w    $820, $118, $1A1A, $118, $8001, $E0E, $12C, $8002
                                        ; DATA XREF: Projectile_ArtemisHoming+44   o
                                        ; Projectile_ArtemisSpread+14   o
                dc.w    $1111, $140, $1212, $154, $8080, $80E, $168, $C0C
                dc.w    $168, $FFFE
word_5886C:     binclude "data/other/word_5886C.bin"
word_5886C_End:

; Updates boss sprites
Boss_ArtemisUpdateSprites:                              ; CODE XREF: Projectile_ArtemisLaser+4E   p  ; was: sub_589E8
                tst.w   $54(a5)
                beq.s   loc_589FC
                move.w  #$100,d1
                sub.w   d7,d1
                move.w  d1,d7
                andi.w  #$1FE,d7
                neg.l   d5
loc_589FC:                                              ; CODE XREF: Boss_ArtemisUpdateSprites+4   j
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_58A5C
                move.w  #$488,(a0)
                move.w  #$C100,2(a0)
                move.w  #$480,$E(a0)
                move.l  #word_E90C2,8(a0)
                move.b  $B00(a5),$20(a0)
                subq.b  #4,$20(a0)
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d7.w),d0
                move.w  (a1,d7.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #5,d0
                asl.l   #5,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                move.w  d6,$48(a0)
                tst.w   (word_FFFF0E).w
                bne.s   loc_58A54
                moveq   #0,d4
                moveq   #0,d5
loc_58A54:                                              ; CODE XREF: Boss_ArtemisUpdateSprites+66   j
                move.l  d5,$4C(a0)
                move.l  d4,$50(a0)
locret_58A5C:                                           ; CODE XREF: Boss_ArtemisUpdateSprites+1A   j
                rts
; End of function Boss_ArtemisUpdateSprites
; Animation script interpreter
Boss_ArtemisAnimationScript:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_58A5E
                tst.w   $48(a5)
                bmi.s   loc_58ADA
                subq.w  #1,$48(a5)
                bpl.s   loc_58A9C
                move.b  #$CB,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$8D00,2(a5)
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                move.b  #$40,$21(a5)                    ; '@'
                move.l  #$FA06FA06,$2C(a5)
                move.w  #$C7,$26(a5)
                bra.s   loc_58ADA
; ---------------------------------------------------------------------------
loc_58A9C:                                              ; CODE XREF: Boss_ArtemisAnimationScript+A   j
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   (word_FFD110).w,d0
                move.w  d0,$10(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   (word_FFD114).w,d0
                move.w  d0,$14(a5)
                bset    #7,2(a5)
                btst    #0,(word_FFA000+1).w
                bne.w   Boss_ArtemisSpawnRadialProjectile
                bclr    #7,2(a5)
                bra.w   Boss_ArtemisSpawnRadialProjectile
; ---------------------------------------------------------------------------
loc_58ADA:                                              ; CODE XREF: Boss_ArtemisAnimationScript+4   j
                                        ; Boss_ArtemisAnimationScript+3C   j
                move.w  (dword_FFA904).w,d0
                subi.w  #$E200,d0
                addi.w  #$12A,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_58AFC
                clr.l   $18(a5)
                move.l  #$FFFC0000,$1C(a5)
                bra.w   loc_58B68
; ---------------------------------------------------------------------------
loc_58AFC:                                              ; CODE XREF: Boss_ArtemisAnimationScript+8C   j
                cmpi.w  #$80,$14(a5)
                bmi.s   loc_58B18
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$26C,d0
                bpl.s   loc_58B18
                cmpi.w  #$94,d0
                bpl.s   loc_58B20
loc_58B18:                                              ; CODE XREF: Boss_ArtemisAnimationScript+A4   j
                                        ; Boss_ArtemisAnimationScript+B2   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_58B20:                                              ; CODE XREF: Boss_ArtemisAnimationScript+B8   j
                tst.w   (word_FF808C).w
                bpl.s   loc_58B50
                bclr    #7,$22(a5)
                beq.s   loc_58B7C
                bclr    #4,$22(a5)
                beq.s   loc_58B50
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_58B50
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                jsr     (Pickup_SelectLargeSize).l
loc_58B50:                                              ; CODE XREF: Boss_ArtemisAnimationScript+C6   j
                                        ; Boss_ArtemisAnimationScript+D6   j
                move.l  $18(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
loc_58B68:                                              ; CODE XREF: Boss_ArtemisAnimationScript+9A   j
                move.w  #3,(word_FFA010).w
                move.l  #off_E953C,8(a5)
                jmp     Sprite_InitType160FromCurrent
; ---------------------------------------------------------------------------
loc_58B7C:                                              ; CODE XREF: Boss_ArtemisAnimationScript+CE   j
                move.w  (word_FFA000).w,d0
                asl.w   #1,d0
                andi.w  #6,d0
                move.w  word_58BA2(pc,d0.w),$E(a5)
                move.l  $4C(a5),d0
                add.l   d0,$18(a5)
                move.l  $50(a5),d0
                add.l   d0,$1C(a5)
                bra.w   Boss_ArtemisSpawnReflectedProjectile
; End of function Boss_ArtemisAnimationScript
nullsub_132:
                rts
; End of function nullsub_132
; ---------------------------------------------------------------------------
word_58BA2:     dc.w    $4489, $4492, $449B, $4492
                                        ; DATA XREF: Boss_ArtemisAnimationScript+128   r

; Spawns projectile in random radial direction from Artemis
Boss_ArtemisSpawnRadialProjectile:                      ; CODE XREF: Boss_ArtemisAnimationScript+6E   j  ; was: sub_58BAA
                                        ; Boss_ArtemisAnimationScript+78   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_58C00
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_58C00
                lea     (Projectile_BombAndRadialSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                move.w  (dword_FFFF08).w,d5
                andi.w  #$1FE,d5
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d5.w),d0
                move.w  (a1,d5.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #5,d0
                asl.l   #5,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
locret_58C00:                                           ; CODE XREF: Boss_ArtemisSpawnRadialProjectile+8   j
                                        ; Boss_ArtemisSpawnRadialProjectile+10   j
                rts
; End of function Boss_ArtemisSpawnRadialProjectile
; Spawns projectile with reversed velocity every other frame
Boss_ArtemisSpawnReflectedProjectile:                   ; CODE XREF: Boss_ArtemisAnimationScript+13E   j  ; was: sub_58C02
                btst    #0,(word_FFA000+1).w
                bne.s   locret_58C60
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_58C60
                lea     (Boss_ArtemisReflectedProjectileSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subi.w  #8,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subi.w  #8,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.b  $20(a5),$20(a0)
                move.l  $18(a5),d0
                neg.l   d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                neg.l   d0
                move.l  d0,$1C(a0)
locret_58C60:                                           ; CODE XREF: Boss_ArtemisSpawnReflectedProjectile+6   j
                                        ; Boss_ArtemisSpawnReflectedProjectile+E   j
                rts
; End of function Boss_ArtemisSpawnReflectedProjectile
; Main loop handler for unknown boss or entity type 1
