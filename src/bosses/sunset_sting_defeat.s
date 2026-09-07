Boss_SunsetStingStartDeathSequence:                     ; CODE XREF: Boss_SunsetStingCheckPhaseTransition+4   j  ; was: sub_4200A
                move.w  #$1A,4(a5)
                move.b  #0,$4B(a5)
                move.w  #4,(dword_FFC6D8).w
                bra.w   Boss_SunsetStingMainUpdate
; End of function Boss_SunsetStingStartDeathSequence
; Updates scale factor of body segments
Boss_SunsetStingUpdateSegmentScale:                     ; CODE XREF: Boss_SunsetStingUpdateAllSegments+4   p  ; was: sub_42020
                                        ; Boss_SunsetStingUpdateAllSegments+A   p
                lea     $60(a4),a3
                move.w  #4,d4
loc_42028:                                              ; CODE XREF: Boss_SunsetStingUpdateSegmentScale+1E   j
                move.w  #1,d0
                cmp.w   $4C(a3),d2
                beq.s   loc_4203A
                bpl.s   loc_42036
                neg.w   d0
loc_42036:                                              ; CODE XREF: Boss_SunsetStingUpdateSegmentScale+12   j
                add.w   d0,$4C(a3)
loc_4203A:                                              ; CODE XREF: Boss_SunsetStingUpdateSegmentScale+10   j
                adda.w  #$60,a3                         ; '`'
                dbf     d4,loc_42028
                rts
; End of function Boss_SunsetStingUpdateSegmentScale
; Updates all four boss body segments
Boss_SunsetStingUpdateAllSegments:                      ; CODE XREF: Boss_SunsetStingRotateAndMove+96   p  ; was: sub_42044
                lea     $2A0(a5),a4
                bsr.s   Boss_SunsetStingUpdateSegmentScale
                lea     $4E0(a5),a4
                bsr.s   Boss_SunsetStingUpdateSegmentScale
                lea     $720(a5),a4
                bsr.s   Boss_SunsetStingUpdateSegmentScale
                lea     $960(a5),a4
                bsr.s   Boss_SunsetStingUpdateSegmentScale
                rts
; End of function Boss_SunsetStingUpdateAllSegments
; Rotates boss body and updates vertical movement
Boss_SunsetStingRotateAndMove:                          ; DATA XREF: ROM:00041960   o  ; was: sub_4205E
                move.w  #1,d1
                btst    #0,(word_FFA000).w
                bne.s   loc_4206C
                neg.w   d1
loc_4206C:                                              ; CODE XREF: Boss_SunsetStingRotateAndMove+A   j
                add.w   d1,(dword_FFC6D8).w
                move.w  #$70,d1                         ; 'p'
                move.w  d1,d2
                move.w  (dword_FFC6D8).w,d0
                bpl.s   loc_42080
                neg.w   d0
                neg.w   d1
loc_42080:                                              ; CODE XREF: Boss_SunsetStingRotateAndMove+1C   j
                cmp.w   d2,d0
                bcs.s   loc_42088
                move.w  d1,(dword_FFC6D8).w
loc_42088:                                              ; CODE XREF: Boss_SunsetStingRotateAndMove+24   j
                movea.l #word_1B514,a2
                move.b  (dword_FFC6DC+1).w,d1
                add.w   d1,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                move.w  #2,d2
                ext.l   d1
                asl.l   d2,d1
                move.l  d1,$18(a5)
                move.w  $14(a5),d1
                tst.l   $1C(a5)
                beq.s   loc_420D2
                bpl.s   loc_420CC
                cmpi.w  #$C0,d1
                bhi.s   loc_420DE
                move.l  #$10000,$1C(a5)
                bra.w   loc_420DE
; ---------------------------------------------------------------------------
loc_420CC:                                              ; CODE XREF: Boss_SunsetStingRotateAndMove+5A   j
                cmpi.w  #$160,d1
                bcs.s   loc_420DE
loc_420D2:                                              ; CODE XREF: Boss_SunsetStingRotateAndMove+58   j
                move.l  #$FFFF0000,$1C(a5)
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_420DE:                                              ; CODE XREF: Boss_SunsetStingRotateAndMove+60   j
                                        ; Boss_SunsetStingRotateAndMove+6A   j
                move.w  (dword_FFC6D8).w,d0
                bsr.w   Boss_SunsetStingUpdateSegmentPositions
                move.w  (dword_FFC6D8).w,d2
                bpl.s   loc_420EE
                neg.w   d2
loc_420EE:                                              ; CODE XREF: Boss_SunsetStingRotateAndMove+8C   j
                lsr.w   #2,d2
                addi.w  #$20,d2                         ; ' '
                bsr.w   Boss_SunsetStingUpdateAllSegments
                move.w  (dword_FFC6D8).w,d1
                asr.w   #3,d1
                add.w   d1,$56(a5)
                bra.w   Boss_SunsetStingMainUpdate
; End of function Boss_SunsetStingRotateAndMove
; Updates X positions of all segments based on rotation
Boss_SunsetStingUpdateSegmentPositions:                 ; CODE XREF: Boss_SunsetStingRotateAndMove+84   p  ; was: sub_42106
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                move.w  d0,-(sp)
                lea     (sp),a3
                bsr.w   Boss_SunsetStingSmoothSegmentTracking
                addq.w  #8,sp
                rts
; End of function Boss_SunsetStingUpdateSegmentPositions
; Smoothly interpolates segment positions
Boss_SunsetStingSmoothSegmentTracking:                  ; CODE XREF: Boss_SunsetStingUpdateSegmentPositions+A   p  ; was: sub_42118
                lea     word_41FA0(pc),a2
                move.w  #3,d4
loc_42120:                                              ; CODE XREF: Boss_SunsetStingSmoothSegmentTracking+1C   j
                movea.w (a2)+,a4
                adda.w  a5,a4
                move.w  (word_FFC67A).w,d2
                add.w   (a3)+,d2
                sub.w   $58(a4),d2
                asr.w   #3,d2
                add.w   d2,$58(a4)
                dbf     d4,loc_42120
                rts
; End of function Boss_SunsetStingSmoothSegmentTracking
; Calculates horizontal direction to player
Boss_SunsetStingGetDirectionToPlayer:
                move.w  #1,d1                           ; was: sub_4213A
                lea     (word_FFA400).w,a0
                move.w  dword_FFA410-word_FFA400(a0),d0
                sub.w   $10(a5),d0
                bhi.s   locret_4214E
                neg.w   d1
locret_4214E:                                           ; CODE XREF: Boss_SunsetStingGetDirectionToPlayer+10   j
                rts
; End of function Boss_SunsetStingGetDirectionToPlayer
; Moves boss downward and activates body segments
Boss_SunsetStingDescendAndActivate:                     ; DATA XREF: ROM:00041964   o  ; was: sub_42150
                addi.l  #$400,$1C(a5)
                move.l  #$200020,d1
                jsr     (Projectile_SpawnWithRandomOffset).l
                cmpi.w  #$1C0,$14(a5)
                bcs.w   loc_422C0
                addq.w  #2,4(a5)
                move.b  #$20,$4B(a5)                    ; ' '
                clr.l   $1C(a5)
                ori.b   #$40,$4A1(a5)                   ; '@'
                ori.b   #$10,$4A3(a5)
                ori.b   #$40,$6E1(a5)                   ; '@'
                ori.b   #$10,$6E3(a5)
                ori.b   #$40,$921(a5)                   ; '@'
                ori.b   #$10,$923(a5)
                ori.b   #$40,$B61(a5)                   ; '@'
                ori.b   #$10,$B63(a5)
                bra.w   loc_422C0
; End of function Boss_SunsetStingDescendAndActivate
; Waits for timer then initializes body segments
Boss_SunsetStingWaitAndInitSegments:                    ; DATA XREF: ROM:00041966   o  ; was: sub_421B0
                move.l  #$400040,d1
                jsr     (Projectile_SpawnWithRandomOffset).l
                subq.b  #1,$4B(a5)
                bne.w   loc_422C0
                addq.w  #2,4(a5)
                move.w  $14(a5),(word_FFC738).w
                clr.w   (word_FFC73C).w
                lea     $BA0(a5),a4
                move.w  #7,d4
loc_421DA:                                              ; CODE XREF: Boss_SunsetStingWaitAndInitSegments+3A   j
                move.w  $14(a5),$14(a4)
                ori.w   #$8000,2(a4)
                lea     $60(a4),a4
                dbf     d4,loc_421DA
                bra.w   loc_422C0
; End of function Boss_SunsetStingWaitAndInitSegments
; Descends boss to specific Y position
Boss_SunsetStingDescendToPosition:                      ; DATA XREF: ROM:00041968   o  ; was: sub_421F2
                move.l  #$400040,d1
                jsr     (Projectile_SpawnWithRandomOffset).l
                addq.w  #1,(word_FFC73C).w
                move.w  (word_FFC73C).w,d0
                lsr.w   #2,d0
                sub.w   d0,(word_FFC738).w
                cmpi.w  #$80,(word_FFC738).w
                bhi.w   loc_422C0
                addq.w  #2,4(a5)
                move.b  #$20,$4B(a5)                    ; ' '
                bra.w   loc_422C0
; End of function Boss_SunsetStingDescendToPosition
; Ends invulnerability period
Boss_SunsetStingEndInvulnerability:                     ; DATA XREF: ROM:0004196A   o  ; was: sub_42224
                subq.b  #1,$4B(a5)
                bne.w   loc_422C0
                clr.b   (byte_FF80EC).w
                bra.w   Boss_SunsetStingCheckHealthThreshold
; End of function Boss_SunsetStingEndInvulnerability
; Calculates alternate screen offset based on boss position
Boss_SunsetStingCalculateScreenOffsetAlt:
                move.w  (dword_FFA900).w,d0             ; was: sub_42234
                add.w   $10(a5),d0
                tst.w   $18(a5)
                bpl.s   loc_42248
                subi.w  #$12C0,d0
                rts
; ---------------------------------------------------------------------------
loc_42248:                                              ; CODE XREF: Boss_SunsetStingCalculateScreenOffsetAlt+C   j
                move.w  #$1400,d1
                sub.w   d0,d1
                rts
; End of function Boss_SunsetStingCalculateScreenOffsetAlt
; Updates sprite orientation and animation frame
Boss_SunsetStingUpdateSpriteOrientation:
                andi.w  #$F7FF,$E(a5)                   ; was: sub_42250
                movem.l d3,-(sp)
                lea     (word_FFA400).w,a4
                jsr     (loc_427EC).l
                movem.l (sp)+,d3
                move.b  d0,d2
                bpl.s   loc_42274
                ori.w   #$800,$E(a5)
                neg.b   d2
loc_42274:                                              ; CODE XREF: Boss_SunsetStingUpdateSpriteOrientation+1A   j
                move.w  d3,$5A(a5)
                add.w   $5A(a5),d2
                move.w  d2,6(a5)
                rts
; End of function Boss_SunsetStingUpdateSpriteOrientation
; Updates boss rotation angle using animation frame
Boss_SunsetStingUpdateRotation:
                move.w  $56(a5),d1                      ; was: sub_42282
                lsr.w   #1,d1
                move.w  6(a5),d0
                sub.b   d1,d0
                asr.b   #2,d0
                ext.w   d0
                add.w   d0,$56(a5)
                rts
; End of function Boss_SunsetStingUpdateRotation
; Main update routine for segments, animations, collision
Boss_SunsetStingMainUpdate:                             ; CODE XREF: Boss_SunsetStingStartDeathSequence+12   j  ; was: sub_42298
                                        ; Boss_SunsetStingRotateAndMove+A4   j
                lea     $960(a5),a4
                jsr     Boss_SunsetStingUpdateSegmentPhysics(pc)  ; (pc)
                nop
                lea     $2A0(a5),a4
                jsr     Boss_SunsetStingUpdateSegmentPhysics(pc)  ; (pc)
                nop
                lea     $4E0(a5),a4
                jsr     Boss_SunsetStingUpdateSegmentPhysics(pc)  ; (pc)
                nop
                lea     $720(a5),a4
                jsr     Boss_SunsetStingUpdateSegmentPhysics(pc)  ; (pc)
                nop
loc_422C0:                                              ; CODE XREF: Boss_SunsetStingUpdateMovement+138   j
                                        ; Boss_SunsetStingDescendAndActivate+1A   j
                move.b  (byte_FFC73E).w,d0
                add.w   d0,d0
                sub.w   $56(a5),d0
                move.w  d0,$B6(a5)
                btst    #2,(byte_FF80EC).w
                bne.s   loc_4230C
                btst    #1,(byte_FF80EC).w
                bne.s   loc_4230C
                move.w  (word_FF8200).w,d0
                beq.w   Boss_SunsetStingResetToIdle
                tst.b   (dword_FFC6DC).w
                bne.s   loc_4230C
                cmpi.w  #$3000,d0
                bhi.s   loc_4230C
                move.b  #1,(dword_FFC6DC).w
                move.w  #$1E,4(a5)
                move.b  #6,(byte_FF80EC).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
loc_4230C:                                              ; CODE XREF: Boss_SunsetStingMainUpdate+3C   j
                                        ; Boss_SunsetStingMainUpdate+44   j
                lea     off_4258E(pc),a1                ; debug this
                jsr     (Boss_SunsetStingUpdateBodyPartPositions).l
                bsr.w   Boss_SunsetStingUpdateScreenBounds
                lea     word_41A88(pc),a0
                move.w  (word_FFC67E).w,d0
                lsr.w   #2,d0
                bsr.w   Gfx_LoadAnimationFrame
                addq.w  #1,(word_FFC67E).w
                ori.w   #$1800,$48E(a5)
                andi.w  #$E7FF,$6CE(a5)
                andi.w  #$E7FF,$90E(a5)
                ori.w   #$1800,$B4E(a5)
                bsr.w   Boss_SunsetStingUpdateTrail
                rts
; End of function Boss_SunsetStingMainUpdate
; Updates individual segment physics
Boss_SunsetStingUpdateSegmentPhysics:                   ; CODE XREF: Boss_SunsetStingMainUpdate+4   p  ; was: sub_4234A
                                        ; Boss_SunsetStingMainUpdate+E   p
                move.w  $58(a4),d2
                tst.b   d2
                bpl.s   loc_42356
                neg.b   d2
                subq.b  #1,d2
loc_42356:                                              ; CODE XREF: Boss_SunsetStingUpdateSegmentPhysics+6   j
                andi.w  #$7F,d2
                subi.w  #$40,d2                         ; '@'
                lea     $60(a4),a3
                move.w  d2,$56(a3)
                move.w  #4,d4
loc_4236A:                                              ; CODE XREF: Boss_SunsetStingUpdateSegmentPhysics+2A   j
                move.w  $B6(a4),$56(a3)
                adda.w  #$60,a3                         ; '`'
                dbf     d4,loc_4236A
                movea.l #word_1B514,a2
                move.w  $56(a5),d1
                add.w   $56(a4),d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  $4C(a4),d0
                muls.w  $4C(a4),d1
                add.l   -$4C(a3),d0
                sub.l   $14(a4),d0
                move.l  -4(a3),d2
                move.l  d0,-4(a3)
                sub.l   d2,d0
                neg.l   d0
                move.l  d0,-$44(a3)
                add.l   -$50(a3),d1
                sub.l   $10(a4),d1
                move.l  -8(a3),d0
                move.l  d1,-8(a3)
                sub.l   d0,d1
                neg.l   d1
                move.l  d1,-$48(a3)
                rts
; End of function Boss_SunsetStingUpdateSegmentPhysics
; Loads compressed tile data for animation frame
Gfx_LoadAnimationFrame:                                 ; CODE XREF: Boss_SunsetStingMainUpdate+8C   p  ; was: sub_423CE
                and.w   (a0)+,d0
                adda.w  d0,a0
                adda.w  (a0),a0
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadAnimationFrame
; Resets boss to idle state after defeat
Boss_SunsetStingResetToIdle:                            ; CODE XREF: Boss_SunsetStingMainUpdate+4A   j  ; was: sub_423DA
                bset    #0,(byte_FFA272).w
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #$7FFF,(word_FF8200).w
                clr.b   (dword_FFC6DC).w
                clr.w   4(a5)
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                bra.w   Boss_SunsetStingMainUpdate
; End of function Boss_SunsetStingResetToIdle
; Initializes fragment explosion with random velocities
Boss_SunsetStingInitFragmentExplosion:
                subq.b  #1,$4B(a5)                      ; was: sub_4240A
                bne.w   Boss_SunsetStingMainUpdate
                addq.w  #2,4(a5)
                clr.b   $21(a5)
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
                lea     (word_1B514).l,a2
loc_4242A:                                              ; CODE XREF: Boss_SunsetStingInitFragmentExplosion+6A   j
                move.w  #$CD40,2(a4)
                jsr     (RandomNumber).l
                rol.l   #8,d0
                move.w  d0,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  #4,d1
                muls.w  #4,d0
                move.l  d1,$18(a4)
                move.l  d0,$1C(a4)
                clr.b   $4B(a4)
                jsr     (RandomNumber).l
                rol.l   #8,d0
                ext.w   d0
                asr.w   #3,d0
                move.w  d0,$5C(a4)
                clr.b   $21(a4)
                lea     $60(a4),a4
                dbf     d4,loc_4242A
                addi.l  #$800,$1C(a5)
                cmpi.w  #$1C0,$14(a5)
                bhi.s   loc_42498
                move.l  #$200020,d1
                bsr.w   Boss_SunsetStingSpawnFragmentProjectile
                bsr.w   Boss_SunsetStingUpdateScreenBounds
                rts
; ---------------------------------------------------------------------------
loc_42498:                                              ; CODE XREF: Boss_SunsetStingInitFragmentExplosion+7C   j
                move.b  #$40,$4B(a5)                    ; '@'
                addq.w  #2,4(a5)
                move.w  #1,d5
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
loc_424B0:                                              ; CODE XREF: Boss_SunsetStingInitFragmentExplosion+B0   j
                move.b  d5,$4B(a4)
                addq.w  #1,d5
                lea     $60(a4),a4
                dbf     d4,loc_424B0
                rts
; End of function Boss_SunsetStingInitFragmentExplosion
; Handles boss death fade out effect
Boss_SunsetStingDeathFadeOut:
                move.w  #4,(word_FFA010).w              ; was: sub_424C0
                move.w  #4,(word_FFA014).w
                subq.b  #1,$4B(a5)
                bne.w   locret_424D6
                clr.w   (a5)
locret_424D6:                                           ; CODE XREF: Boss_SunsetStingDeathFadeOut+10   j
                rts
; End of function Boss_SunsetStingDeathFadeOut
; Updates individual fragment animation
Boss_SunsetStingUpdateFragment:
                tst.b   $4B(a5)                         ; was: sub_424D8
                beq.s   loc_424E4
                subq.b  #1,$4B(a5)
                beq.s   loc_42506
loc_424E4:                                              ; CODE XREF: Boss_SunsetStingUpdateFragment+4   j
                move.w  $5C(a5),d0
                add.w   d0,$56(a5)
                move.l  $50(a5),d0
                beq.s   locret_42504
                movea.l d0,a1
                move.w  $56(a5),d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a5)
locret_42504:                                           ; CODE XREF: Boss_SunsetStingUpdateFragment+18   j
                rts
; ---------------------------------------------------------------------------
loc_42506:                                              ; CODE XREF: Boss_SunsetStingUpdateFragment+A   j
                lea     (a5),a0
                jsr     (loc_2A2A4).l
                clr.b   $21(a5)
                rts
; End of function Boss_SunsetStingUpdateFragment
; Spawns projectile fragment with random offset
Boss_SunsetStingSpawnFragmentProjectile:                ; CODE XREF: Boss_SunsetStingInitFragmentExplosion+84   p  ; was: sub_42514
                move.l  d1,-(sp)
                jsr     (Projectile_UpdateWithImpactFrames).l
                bne.s   loc_4256C
                jsr     (Sprite_InitFromTable).l
                clr.b   $20(a0)
                move.l  $18(a5),$18(a0)
                move.l  $1C(a5),$1C(a0)
                neg.l   $18(a0)
                neg.l   $1C(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                move.w  (sp),d2
                add.w   d2,d2
                subq.w  #1,d2
                and.w   d2,d0
                sub.w   (sp),d0
                move.w  2(sp),d2
                add.w   d2,d2
                subq.w  #1,d2
                and.w   d2,d1
                sub.w   2(sp),d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
loc_4256C:                                              ; CODE XREF: Boss_SunsetStingSpawnFragmentProjectile+8   j
                move.l  (sp)+,d1
                rts
; End of function Boss_SunsetStingSpawnFragmentProjectile
; Updates boss screen boundary values
Boss_SunsetStingUpdateScreenBounds:                     ; CODE XREF: Boss_SunsetStingMainUpdate+7E   p  ; was: sub_42570
                                        ; Boss_SunsetStingInitFragmentExplosion+88   p
                move.w  #$A8,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$48,d0                         ; 'H'
                move.w  d0,(dword_FFA90C).w
                jmp     Boss_CheckScreenBounds
; End of function Boss_SunsetStingUpdateScreenBounds
; ---------------------------------------------------------------------------
off_4258E:      dc.l    word_4196C                      ; DATA XREF: Boss_SunsetStingLoadGraphicsAlt+28   o
                                        ; sub_42298:loc_4230C   o
                                        ; debug this
                dc.l    0
                dc.l    $80000001
                dc.l    word_4196C
                dc.l    $100140
                dc.l    $80000000
                dc.l    $80000001
                dc.l    word_EBE88
                dc.l    $A10000
                dc.l    $80000001
                dc.l    word_41978
                dc.l    $200190
                dc.l    $80000000
                dc.l    $80000001
                dc.l    word_41978
                dc.l    $200070
                dc.l    $80000000
                dc.l    $80000001
                dc.l    word_4197E
                dc.l    $3001D0
                dc.l    $80000000
                dc.l    $80000001
                dc.l    word_4197E
                dc.l    $300030
                dc.l    $80000000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    word_41972
                dc.l    $A10040
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_EBE94
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    word_41972
                dc.l    $A100C0
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_EBE94
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    word_41972
                dc.l    $A10140
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_EBE94
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000001
                dc.l    word_41972
                dc.l    $A101C0                         ; UNUSED: Love Penguin sprite table entry
                                        ; See line 20999 for boss structure ($01C0)
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_41972
                dc.l    $210000
                dc.l    word_EBE94
                dc.l    $210000
                dc.l    $80000000
                dc.l    $80000000
word_426DA:     dc.w    $C620, $1408, $E41C, $E41C, $10, $C6E0, $1078, $F010, $F010, $10, $CAA0, $1008, $F010, $F010, $10, $C980
                                        ; DATA XREF: Boss_SunsetStingLoadGraphicsAlt+C   o
                dc.w    $1008, $F010, $F010, $10, $CCE0, $1008, $F010, $F010, $10, $CBC0, $1008, $F010, $F010, $10, $CF20, $1008
                dc.w    $F010, $F010, $10, $CE00, $1008, $F010, $F010, $10, $D160, $1008, $F010, $F010, $10, $D040, $1008, $F010
                dc.w    $F010, $10, $FFFE

; Initializes 8 trail segments with graphics pointer and properties
Boss_SunsetStingInitTrail:                              ; CODE XREF: Boss_SunsetStingLoadGraphicsAlt+34   p  ; was: sub_42740
                lea     $BA0(a5),a4
                move.w  #7,d4
loc_42748:                                              ; CODE XREF: Boss_SunsetStingInitTrail+2A   j
                move.w  #$4000,2(a4)
                move.l  #word_41972,8(a4)
                move.w  #$10,(a4)
                move.w  $E(a5),$E(a4)
                move.b  #$C8,$20(a4)
                lea     $60(a4),a4
                dbf     d4,loc_42748
                rts
; End of function Boss_SunsetStingInitTrail
; Updates trail segment positions following boss movement
Boss_SunsetStingUpdateTrail:                            ; CODE XREF: Boss_SunsetStingMainUpdate+AC   p  ; was: sub_42770
                lea     $BA0(a5),a4
                btst    #7,2(a4)
                beq.s   locret_427AE
                move.w  $10(a5),d1
                move.l  $14(a5),d2
                subi.l  #$200000,d2
                move.l  d2,d3
                moveq   #0,d0
                move.w  (word_FFC738).w,d0
                swap    d0
                sub.l   d0,d3
                asr.l   #3,d3
                move.w  #7,d4
loc_4279C:                                              ; CODE XREF: Boss_SunsetStingUpdateTrail+3A   j
                move.w  d1,$10(a4)
                move.l  d2,$14(a4)
                sub.l   d3,d2
                lea     $60(a4),a4
                dbf     d4,loc_4279C
locret_427AE:                                           ; CODE XREF: Boss_SunsetStingUpdateTrail+A   j
                rts
; End of function Boss_SunsetStingUpdateTrail
; Calculates angle from X/Y velocity components
Physics_CalculateAngleFromVelocity:
                pea     Physics_AddAngleOffset(pc)      ; was: sub_427B0
                lea     byte_4285C(pc),a0
                ext.l   d0
                beq.s   loc_427D6
                bpl.s   loc_427C2
                neg.l   d0
                addq.l  #4,a0
loc_427C2:                                              ; CODE XREF: Physics_CalculateAngleFromVelocity+C   j
                ext.l   d1
                beq.s   Physics_CalculateAngleToTarget
                bpl.s   loc_427CC
                neg.l   d1
                addq.l  #2,a0
loc_427CC:                                              ; CODE XREF: Physics_CalculateAngleFromVelocity+16   j
                bra.s   loc_42818
; End of function Physics_CalculateAngleFromVelocity
; Computes angle offset from vertical position difference
Physics_GetVerticalAngleOffset:                         ; CODE XREF: Physics_CalculateAngleToTarget+1C   j  ; was: sub_427CE
                move.w  $14(a4),d1
                sub.w   $14(a5),d1
loc_427D6:                                              ; CODE XREF: Physics_CalculateAngleFromVelocity+A   j
                move.w  d1,d0
                lsr.w   #8,d0
                andi.w  #$80,d0
                addi.w  #$40,d0                         ; '@'
                rts
; End of function Physics_GetVerticalAngleOffset
; Calculates angle from current position to target using octant lookup
Physics_CalculateAngleToTarget:                         ; CODE XREF: Physics_CalculateAngleFromVelocity+14   j  ; was: sub_427E4
                                        ; Physics_CalculateAngleToTarget+2C   j
                move.b  (a0),d0
                andi.w  #$80,d0
                rts
; ---------------------------------------------------------------------------
loc_427EC:                                              ; CODE XREF: Boss_SunsetStingCalculateAngleAndFlip+E   p
                                        ; Boss_SunsetStingMainDispatcher+18   p
                pea     Physics_AddAngleOffset(pc)
                lea     byte_4285C(pc),a0
                moveq   #0,d0
                moveq   #0,d1
                move.w  $10(a4),d0
                sub.w   $10(a5),d0
                beq.s   Physics_GetVerticalAngleOffset
                bgt.s   loc_42808
                neg.w   d0
                addq.l  #4,a0
loc_42808:                                              ; CODE XREF: Physics_CalculateAngleToTarget+1E   j
                move.w  $14(a4),d1
                sub.w   $14(a5),d1
                beq.s   Physics_CalculateAngleToTarget
                bgt.s   loc_42818
                neg.w   d1
                addq.l  #2,a0
loc_42818:                                              ; CODE XREF: Physics_CalculateAngleFromVelocity:loc_427CC   j
                                        ; Physics_CalculateAngleToTarget+2E   j
                cmp.w   d0,d1
                bcs.s   loc_42820
                exg     d0,d1
                addq.l  #1,a0
loc_42820:                                              ; CODE XREF: Physics_CalculateAngleToTarget+36   j
                asl.l   #2,d0
                divu.w  d1,d0
                cmpi.w  #$23,d0                         ; '#'
                bcs.s   loc_4282C
                moveq   #$23,d0                         ; '#'
loc_4282C:                                              ; CODE XREF: Physics_CalculateAngleToTarget+44   j
                move.b  loc_42838(pc,d0.w),d0
                move.b  (a0),d1
                add.b   d1,d1
                bcc.s   loc_42838
                neg.b   d0
loc_42838:                                              ; CODE XREF: Physics_CalculateAngleToTarget+50   j
                                        ; DATA XREF: Physics_CalculateAngleToTarget:loc_4282C   r
                add.b   d1,d0
                rts
; End of function Physics_CalculateAngleToTarget
; ---------------------------------------------------------------------------
unused_9:       binclude "data/other/unused_9.bin"
byte_4285C:     dc.b    0, $A0, $80, $60, $C0, $20, $40, $E0
                                        ; DATA XREF: Physics_CalculateAngleFromVelocity+4   o
                                        ; Physics_CalculateAngleToTarget+C   o

; Adds 90 degrees offset to angle value
Physics_AddAngleOffset:                                 ; DATA XREF: Physics_CalculateAngleFromVelocity   o  ; was: sub_42864
                                        ; sub_427E4:loc_427EC   o
                addi.b  #$40,d0                         ; '@'
                rts
; End of function Physics_AddAngleOffset
; Selects weighted random value from table
Gfx_WeightedRandomSelect:                               ; CODE XREF: JumpRandomFunc   p  ; was: sub_4286A
                jsr     (RandomNumber).l
loc_42870:                                              ; CODE XREF: Gfx_WeightedRandomSelect+C   j
                sub.w   (a0)+,d0
                bls.s   loc_42878
                addq.w  #2,a0
                bra.s   loc_42870
; ---------------------------------------------------------------------------
loc_42878:                                              ; CODE XREF: Gfx_WeightedRandomSelect+8   j
                move.w  (a0),d0
                rts
; End of function Gfx_WeightedRandomSelect
JumpRandomFunc:                                         ; CODE XREF: Boss_SunsetStingIdleState+40   j
                                        ; Boss_SunsetStingCloseRangeAttack+4   j
                bsr.s   Gfx_WeightedRandomSelect
                adda.w  (a0),a0
                jmp     (a0)
; End of function JumpRandomFunc

; Gets sine and cosine values
Math_GetSinCos:                                         ; CODE XREF: Math_GetScaledSinCos   p  ; was: sub_42882
                lsr.w   #1,d0
                andi.w  #$1FE,d0
                lea     (word_1B494).l,a0
                move.w  (a0,d0.w),d1
                addi.w  #$80,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d0
                rts
; End of function Math_GetSinCos
; Gets scaled sine and cosine
Math_GetScaledSinCos:                                   ; CODE XREF: Boss_SunsetStingSegmentInit:loc_433A8   p  ; was: sub_428A0
                                        ; Boss_SunsetStingSegmentInit+68   p
                bsr.s   Math_GetSinCos
                muls.w  d2,d0
                muls.w  d2,d1
                rts
; End of function Math_GetScaledSinCos
; Clears X and Y velocity values
Physics_ClearVelocity:                                  ; CODE XREF: Boss_SunsetStingBattleActive   p  ; was: sub_428A8
                                        ; sub_43048   p
                moveq   #0,d0
                move.l  d0,$18(a5)
                move.l  d0,$1C(a5)
                rts
; End of function Physics_ClearVelocity
; Updates boss core position
