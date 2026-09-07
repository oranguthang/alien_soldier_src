Boss_SunsetStingSegmentMain:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4333A
                lea     (Entity_ObjectPool).w,a3
                lea     (word_FF9800).w,a4
                bsr.s   Boss_SunsetStingSegmentDispatcher
                cmpi.w  #$C,4(a5)
                beq.w   locret_432CE
                btst    #7,(a4)
                beq.s   loc_4335E
                clr.b   $21(a5)
                move.w  #$C,4(a5)
loc_4335E:                                              ; CODE XREF: Boss_SunsetStingSegmentMain+18   j
                move.w  4(a4),d0
                add.w   d0,6(a5)
                rts
; End of function Boss_SunsetStingSegmentMain
; Segment state dispatcher
Boss_SunsetStingSegmentDispatcher:                      ; CODE XREF: Boss_SunsetStingSegmentMain+8   p  ; was: sub_43368
                movea.w 4(a5),a0
                lea     off_43374(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingSegmentDispatcher
; ---------------------------------------------------------------------------
off_43374:      dc.w    Boss_SunsetStingSegmentInit-*   ; DATA XREF: Boss_SunsetStingSegmentDispatcher+4   o
                dc.w    Boss_SunsetStingSegmentInit_AdvanceState-*
                dc.w    Boss_SunsetStingSegmentInit_UpdateLoop-*
                dc.w    Boss_SunsetStingSegmentMove-*
                dc.w    Boss_SunsetStingSegmentFallInit-*
                dc.w    Boss_SunsetStingSegmentWobble-*
                dc.w    Boss_SunsetStingSegmentConvertToProjectile-*

; Initializes segment
Boss_SunsetStingSegmentInit:                            ; DATA XREF: ROM:off_43374   o  ; was: sub_43382
                move.w  #$CD00,2(a5)
                move.b  #$40,$20(a5)                    ; '@'
                addq.w  #2,4(a5)
; Advance to next state for segment initialization
Boss_SunsetStingSegmentInit_AdvanceState:               ; DATA XREF: ROM:00043376   o  ; was: loc_43392
                addq.w  #2,4(a5)
; Calculate segment position and check for damage
Boss_SunsetStingSegmentInit_UpdateLoop:                 ; DATA XREF: ROM:00043378   o  ; was: loc_43396
                move.w  6(a5),d0
                move.w  $44(a5),d2
                cmpi.w  #$80,d2
                beq.s   loc_433A8
                addq.w  #2,$44(a5)
loc_433A8:                                              ; CODE XREF: Boss_SunsetStingSegmentInit+20   j
                bsr.w   Math_GetScaledSinCos
                add.l   $10(a3),d0
                add.l   $14(a3),d1
                move.l  d0,$10(a5)
                move.l  d1,$14(a5)
                move.w  6(a5),d0
                lea     off_432FA(pc),a0
                bsr.w   Boss_SunsetStingUpdateSegmentSprite
                move.w  $46(a5),d0
                move.w  2(a4),d1
                btst    d0,d1
                beq.w   locret_432CE
                cmpi.w  #$FFFF,2(a4)
                beq.s   loc_433E4
                subi.w  #$F,(word_FF8234).w
loc_433E4:                                              ; CODE XREF: Boss_SunsetStingSegmentInit+5A   j
                move.w  6(a5),d0
                moveq   #8,d2
                bsr.w   Math_GetScaledSinCos
                move.l  d0,$18(a5)
                asr.l   #1,d0
                move.l  d1,$1C(a5)
                move.l  #$1800,$58(a5)
                move.w  (word_FFFF0E).w,d0
                lsr.w   #1,d0
                addq.w  #1,d0
                move.w  d0,$48(a5)
                move.b  #$C0,$21(a5)
                move.w  6(a5),$44(a5)
                clr.w   $4A(a5)
                move.w  #$10,$24(a5)
                addq.w  #2,4(a5)
                move.b  #$CC,d0
                jmp     (Sound_PlaySFX).l
; End of function Boss_SunsetStingSegmentInit
; Segment movement logic
Boss_SunsetStingSegmentMove:                            ; DATA XREF: ROM:0004337A   o  ; was: sub_43430
                tst.w   $24(a5)
                bpl.s   loc_4346E
                bsr.w   Physics_ClearVelocity
                move.b  d0,$21(a5)
                move.w  #8,4(a5)
                jsr     (Projectile_ExplodeWithSound).l
                bclr    #4,$22(a5)
                beq.s   locret_4346C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_4346C
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                jsr     (Effect_SpawnDestructionBlast).l
locret_4346C:                                           ; CODE XREF: Boss_SunsetStingSegmentMove+20   j
                                        ; Boss_SunsetStingSegmentMove+28   j
                rts
; ---------------------------------------------------------------------------
loc_4346E:                                              ; CODE XREF: Boss_SunsetStingSegmentMove+4   j
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                move.w  $4A(a5),d0
                add.w   d0,$44(a5)
                move.w  $44(a5),d0
                lea     off_432FA(pc),a0
                bsr.w   Boss_SunsetStingUpdateSegmentSprite
                tst.w   $48(a5)
                beq.s   loc_434C8
                move.l  $1C(a5),d0
                bmi.s   loc_434C8
                add.l   $14(a5),d0
                swap    d0
                addq.w  #8,d0
                cmpi.w  #$148,d0
                bcs.w   locret_432CE
                moveq   #$30,d0                         ; '0'
                tst.w   $18(a5)
                bpl.s   loc_434B0
                neg.w   d0
loc_434B0:                                              ; CODE XREF: Boss_SunsetStingSegmentMove+7C   j
                move.w  d0,$4A(a5)
                move.l  $1C(a5),d0
                move.l  d0,d1
                asr.l   #3,d1
                sub.l   d1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                subq.w  #1,$48(a5)
loc_434C8:                                              ; CODE XREF: Boss_SunsetStingSegmentMove+5E   j
                                        ; Boss_SunsetStingSegmentMove+64   j
                bsr.w   Boss_SunsetStingUpdateCore
                bne.w   locret_432CE
                move.w  #$A,4(a5)
                rts
; End of function Boss_SunsetStingSegmentMove
; Initializes falling segment
Boss_SunsetStingSegmentFallInit:                        ; DATA XREF: ROM:0004337C   o  ; was: sub_434D8
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                bra.s   loc_434C8
; End of function Boss_SunsetStingSegmentFallInit
; Segment wobble before fall
Boss_SunsetStingSegmentWobble:                          ; DATA XREF: ROM:0004337E   o  ; was: sub_434E2
                bsr.w   Physics_ClearVelocity
                move.w  d0,$44(a5)
                move.b  d0,$21(a5)
                move.w  #4,4(a5)
                rts
; End of function Boss_SunsetStingSegmentWobble
; Converts segment to projectile
Boss_SunsetStingSegmentConvertToProjectile:             ; DATA XREF: ROM:00043380   o  ; was: sub_434F6
                jsr     (Projectile_InitType88FromCurrent).l
                move.l  #off_E95DC,8(a5)
                rts
; End of function Boss_SunsetStingSegmentConvertToProjectile
; Destroyed segment handler
Boss_SunsetStingSegmentDestroyed:                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_43506
                lea     (Entity_ObjectPool).w,a3
                lea     (word_FF9800).w,a4
                bsr.s   Boss_SunsetStingSegmentStateDispatch
                cmpi.w  #$E,4(a5)
                beq.w   locret_432CE
                btst    #7,(a4)
                beq.s   loc_4355C
                move.w  6(a5),d0
                moveq   #8,d2
                bsr.w   Math_GetScaledSinCos
                move.l  d0,$18(a5)
                subq.w  #2,$1C(a5)
                move.l  #$1800,$58(a5)
                move.w  #$80,d1
                bpl.s   loc_43542
                neg.w   d1
loc_43542:                                              ; CODE XREF: Boss_SunsetStingSegmentDestroyed+38   j
                move.w  6(a5),$48(a5)
                move.w  d1,$4A(a5)
                clr.b   $21(a5)
                move.w  #$CD00,2(a5)
                move.w  #$E,4(a5)
loc_4355C:                                              ; CODE XREF: Boss_SunsetStingSegmentDestroyed+18   j
                move.w  4(a4),d0
                add.w   d0,6(a5)
                rts
; End of function Boss_SunsetStingSegmentDestroyed
; Segment state dispatch wrapper
Boss_SunsetStingSegmentStateDispatch:                   ; CODE XREF: Boss_SunsetStingSegmentDestroyed+8   p  ; was: sub_43566
                movea.w 4(a5),a0
                lea     off_43572(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingSegmentStateDispatch
; ---------------------------------------------------------------------------
off_43572:      dc.w    Boss_SunsetStingSegmentFall-*   ; DATA XREF: Boss_SunsetStingSegmentStateDispatch+4   o
                dc.w    Boss_SunsetStingSegmentFall_AdvanceState-*
                dc.w    Boss_SunsetStingSegmentFall_UpdateLoop-*
                dc.w    Boss_SunsetStingSegmentHit-*
                dc.w    Boss_SunsetStingDefeatStart-*
                dc.w    Boss_ViblackAttachedToPlayer-*
                dc.w    Boss_SunsetStingSegmentDestroyInit-*
                dc.w    Boss_SunsetStingSegmentFalling-*

; Segment falls after destruction
Boss_SunsetStingSegmentFall:                            ; DATA XREF: ROM:off_43572   o  ; was: sub_43582
                move.w  #$C100,2(a5)
                move.b  #$40,$20(a5)                    ; '@'
                addq.w  #2,4(a5)
; Advance to next state for segment falling
Boss_SunsetStingSegmentFall_AdvanceState:               ; DATA XREF: ROM:00043574   o  ; was: loc_43592
                addq.w  #2,4(a5)
; Calculate falling segment position and collision
Boss_SunsetStingSegmentFall_UpdateLoop:                 ; DATA XREF: ROM:00043576   o  ; was: loc_43596
                move.w  6(a5),d0
                move.w  $44(a5),d2
                cmpi.w  #$98,d2
                beq.s   loc_435A8
                addq.w  #2,$44(a5)
loc_435A8:                                              ; CODE XREF: Boss_SunsetStingSegmentFall+20   j
                bsr.w   Math_GetScaledSinCos
                add.l   $10(a3),d0
                add.l   $14(a3),d1
                move.l  d0,$10(a5)
                move.l  d1,$14(a5)
                move.w  6(a5),d0
                lea     off_4331A(pc),a0
                bsr.w   Boss_SunsetStingUpdateSegmentSprite
                move.w  $46(a5),d0
                move.w  2(a4),d1
                btst    d0,d1
                beq.w   locret_432CE
                cmpi.w  #$FFFF,2(a4)
                beq.s   loc_435F8
                move.w  6(a5),d0
                addi.w  #$20,d0                         ; ' '
                andi.w  #$3FF,d0
                cmpi.w  #$240,d0
                bcc.w   locret_432CE
                subi.w  #$A,(word_FF8234).w
loc_435F8:                                              ; CODE XREF: Boss_SunsetStingSegmentFall+5A   j
                move.w  6(a5),$44(a5)
                move.w  #$230,$48(a5)
                move.b  #$40,$21(a5)                    ; '@'
                bclr    #7,$22(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_SunsetStingSegmentFall
; ---------------------------------------------------------------------------
word_43616:     dc.w    3, 1                            ; DATA XREF: Boss_SunsetStingSegmentHit+4   r

; Segment hit reaction
Boss_SunsetStingSegmentHit:                             ; DATA XREF: ROM:00043578   o  ; was: sub_4361A
                move.w  (word_FFFF0E).w,d2
                move.w  word_43616(pc,d2.w),d1
                move.b  $48(a5),d2
                ext.w   d2
                tst.b   $49(a5)
                beq.s   loc_43642
                subq.b  #1,$49(a5)
                bne.s   loc_4364E
                moveq   #$FFFFFFFC,d0
                tst.w   (word_FFFF0E).w
                beq.s   loc_4363E
                add.b   d0,d0
loc_4363E:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+20   j
                move.b  d0,$48(a5)
loc_43642:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+12   j
                move.w  (word_FFA000).w,d0
                and.w   d1,d0
                bne.s   loc_4364E
                addq.b  #1,$48(a5)
loc_4364E:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+18   j
                                        ; Boss_SunsetStingSegmentHit+2E   j
                move.w  $44(a5),d0
                bsr.w   Math_GetScaledSinCos
                add.l   d0,$10(a5)
                add.l   d1,$14(a5)
                move.b  $2D(a5),d2
                ext.w   d2
                add.w   $14(a5),d2
                cmpi.w  #$148,d2
                bcs.s   loc_436B0
loc_4366E:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+C0   j
                move.w  6(a5),$48(a5)
                asr.l   #1,d0
                tst.w   (word_FFFF0E).w
                beq.s   loc_43682
                move.l  d1,d2
                asr.l   #2,d2
                sub.l   d2,d1
loc_43682:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+60   j
                neg.l   d1
                move.l  d1,$1C(a5)
                move.l  #$1400,$58(a5)
                moveq   #$40,d1                         ; '@'
                move.l  d0,$18(a5)
                bpl.s   loc_4369A
                neg.w   d1
loc_4369A:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+7C   j
                move.w  d1,$4A(a5)
                clr.b   $21(a5)
                move.w  #$CD00,2(a5)
                move.w  #8,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_436B0:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+52   j
                lea     (word_FFA400).w,a0
                bclr    #7,$22(a5)
                beq.w   loc_43754
                bclr    #4,$22(a5)
                beq.s   loc_436DC
                tst.l   d0
                bpl.s   loc_436CC
                neg.l   d0
loc_436CC:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+AE   j
                btst    #3,$E(a0)
                bne.s   loc_436D6
                neg.l   d0
loc_436D6:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+B8   j
                move.l  d0,$18(a5)
                bra.s   loc_4366E
; ---------------------------------------------------------------------------
loc_436DC:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+AA   j
                move.w  $14(a5),d0
                sub.w   $14(a0),d0
                cmpi.w  #$18,d0
                bgt.s   loc_43754
                btst    #1,(byte_FF8244).w
                beq.s   loc_43702
                subi.b  #$14,d0
                bmi.s   loc_43702
                addi.b  #$14,d0
                add.w   d0,d0
                subi.w  #$18,d0
loc_43702:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+D6   j
                                        ; Boss_SunsetStingSegmentHit+DC   j
                move.b  d0,$49(a5)
                move.w  $10(a5),d0
                sub.w   $10(a0),d0
                btst    #3,$E(a0)
                bne.s   loc_43718
                neg.w   d0
loc_43718:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+FA   j
                move.b  d0,$48(a5)
                move.b  $E(a0),d0
                andi.w  #8,d0
                move.b  d0,$4A(a5)
                bsr.w   Physics_ClearVelocity
                move.b  d0,$21(a5)
                move.w  #$A,4(a5)
                rts
; End of function Boss_SunsetStingSegmentHit
; Starts defeat sequence
Boss_SunsetStingDefeatStart:                            ; DATA XREF: ROM:0004357A   o  ; was: sub_43738
                addi.l  #$4000,$1C(a5)
                move.w  $4A(a5),d0
                add.w   d0,$48(a5)
                move.w  $48(a5),d0
                lea     off_4331A(pc),a0
                bsr.w   Boss_SunsetStingUpdateSegmentSprite
loc_43754:                                              ; CODE XREF: Boss_SunsetStingSegmentHit+A0   j
                                        ; Boss_SunsetStingSegmentHit+CE   j
                bsr.w   Boss_SunsetStingUpdateCore
                bne.w   locret_432CE
                move.w  #$C,4(a5)
                rts
; End of function Boss_SunsetStingDefeatStart
; Updates position when attached to player
Boss_ViblackAttachedToPlayer:                           ; DATA XREF: ROM:0004357C   o  ; was: sub_43764
                addq.b  #1,$4B(a5)
                andi.b  #$F,$4B(a5)
                bne.s   loc_43774
                bsr.w   Projectile_SpawnViblackBullet
loc_43774:                                              ; CODE XREF: Boss_ViblackAttachedToPlayer+A   j
                move.w  $4A(a5),d0
                andi.w  #7,d0
                bne.s   loc_43786
                clr.b   $21(a5)
                subq.w  #1,(word_FFA216).w
loc_43786:                                              ; CODE XREF: Boss_ViblackAttachedToPlayer+18   j
                lea     (word_FFA400).w,a0
                move.b  $48(a5),d0
                ext.w   d0
                move.b  $E(a0),d1
                andi.w  #8,d1
                bne.s   loc_4379C
                neg.w   d0
loc_4379C:                                              ; CODE XREF: Boss_ViblackAttachedToPlayer+34   j
                cmp.b   $4A(a5),d1
                beq.s   loc_437AC
                bchg    #3,$E(a5)
                move.b  d1,$4A(a5)
loc_437AC:                                              ; CODE XREF: Boss_ViblackAttachedToPlayer+3C   j
                add.w   $10(a0),d0
                move.w  d0,$10(a5)
                move.w  $48(a5),d0
                ext.w   d0
                btst    #1,(byte_FF8244).w
                beq.s   loc_437D6
                cmpi.w  #$FFF8,d0
                bpl.s   loc_437CE
                addi.w  #$18,d0
                bra.s   loc_437D6
; ---------------------------------------------------------------------------
loc_437CE:                                              ; CODE XREF: Boss_ViblackAttachedToPlayer+62   j
                moveq   #$18,d1
                sub.w   d0,d1
                lsr.w   #1,d1
                add.w   d1,d0
loc_437D6:                                              ; CODE XREF: Boss_ViblackAttachedToPlayer+5C   j
                                        ; Boss_ViblackAttachedToPlayer+68   j
                add.w   $14(a0),d0
                move.w  d0,$14(a5)
                btst    #4,(byte_FF8244).w
                beq.w   locret_432CE
                subq.w  #2,$1C(a5)
                move.l  #$1800,$58(a5)
                moveq   #$20,d0                         ; ' '
                btst    #3,$E(a0)
                beq.s   loc_43800
                neg.w   d0
loc_43800:                                              ; CODE XREF: Boss_ViblackAttachedToPlayer+98   j
                move.w  d0,$4A(a5)
                clr.b   $21(a5)
                move.w  #$CD00,2(a5)
                move.w  #8,4(a5)
                rts
; End of function Boss_ViblackAttachedToPlayer
; Initializes segment destruction
Boss_SunsetStingSegmentDestroyInit:                     ; DATA XREF: ROM:0004357E   o  ; was: sub_43816
                bsr.w   Physics_ClearVelocity
                move.w  d0,$44(a5)
                move.b  d0,$21(a5)
                move.w  #$C100,2(a5)
                move.w  #4,4(a5)
                rts
; End of function Boss_SunsetStingSegmentDestroyInit
; Segment falling state
Boss_SunsetStingSegmentFalling:                         ; DATA XREF: ROM:00043580   o  ; was: sub_43830
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                move.w  $4A(a5),d0
                add.w   d0,$48(a5)
                move.w  $48(a5),d0
                lea     off_4331A(pc),a0
                bsr.w   Boss_SunsetStingUpdateSegmentSprite
                bsr.w   Boss_SunsetStingUpdateCore
                bne.w   locret_432CE
                clr.w   (a5)
                rts
; End of function Boss_SunsetStingSegmentFalling
; Boss falls during defeat
Boss_SunsetStingDefeatFall:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_43858
                lea     (Entity_ObjectPool).w,a3
                lea     (word_FF9800).w,a4
                bsr.s   Boss_SunsetStingDefeatExplode
                btst    #7,(a4)
                beq.s   loc_4386C
                clr.b   $21(a5)
loc_4386C:                                              ; CODE XREF: Boss_SunsetStingDefeatFall+E   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_43890
                addq.w  #4,6(a5)
                cmpi.w  #$C,6(a5)
                bne.s   loc_43886
                clr.w   6(a5)
loc_43886:                                              ; CODE XREF: Boss_SunsetStingDefeatFall+28   j
                move.w  6(a5),d0
                move.l  off_43892(pc,d0.w),8(a5)
locret_43890:                                           ; CODE XREF: Boss_SunsetStingDefeatFall+1C   j
                                        ; DATA XREF: ROM:000438AC   o
                rts
; End of function Boss_SunsetStingDefeatFall
; ---------------------------------------------------------------------------
off_43892:      dc.l    word_EBF6C                      ; DATA XREF: Boss_SunsetStingDefeatFall+32   r
                dc.l    word_EBF78
                dc.l    word_EBF84

; Boss explosion during defeat
Boss_SunsetStingDefeatExplode:                          ; CODE XREF: Boss_SunsetStingDefeatFall+8   p  ; was: sub_4389E
                movea.w 4(a5),a0
                lea     off_438AA(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingDefeatExplode
; ---------------------------------------------------------------------------
off_438AA:      dc.w    Boss_SunsetStingDefeatEnd-*     ; DATA XREF: Boss_SunsetStingDefeatExplode+4   o
                dc.w    locret_43890-*

; Ends defeat sequence
Boss_SunsetStingDefeatEnd:                              ; DATA XREF: ROM:off_438AA   o  ; was: sub_438AE
                move.w  #$CD00,2(a5)
                move.l  #word_EBF84,8(a5)
                move.b  #$40,$20(a5)                    ; '@'
                move.l  #$E008F010,$2C(a5)
                bra.w   loc_432CA
; End of function Boss_SunsetStingDefeatEnd
; Applies gravity and disables after timer expires
Projectile_ViblackFallAndDisable:                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_438CE
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                subq.w  #1,$48(a5)
                bne.w   locret_432CE
                bset    #4,2(a5)
                rts
; End of function Projectile_ViblackFallAndDisable
; Spawns projectile at boss position with upward velocity
Projectile_SpawnViblackBullet:                          ; CODE XREF: Boss_ViblackAttachedToPlayer+C   p  ; was: sub_438E6
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_432CE
                move.w  #$1F8,(a0)
                move.w  #$CD00,2(a0)
                move.w  #$8480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                move.l  #word_E91FA,8(a0)
                move.b  #4,$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$3000,$58(a0)
                move.w  #$18,$48(a0)
                rts
; End of function Projectile_SpawnViblackBullet
; Sets up entity pointers and calls projectile dispatcher
Boss_ViblackProjectileDispatcher:                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_43930
                lea     (Entity_ObjectPool).w,a3
                lea     (word_FF9800).w,a4
                bsr.s   nullsub_7
                rts
; End of function Boss_ViblackProjectileDispatcher
; ---------------------------------------------------------------------------
                dc.l    off_EBFC0
                dc.l    off_EBFCC

nullsub_7:                                              ; CODE XREF: Boss_ViblackProjectileDispatcher+8   p
                rts
; End of function nullsub_7

; Executes jump table based dispatcher for Viblack states
Boss_ViblackJumpTableDispatcher:
                movea.w 4(a5),a0                        ; was: sub_43946
                lea     off_43952(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ViblackJumpTableDispatcher
; ---------------------------------------------------------------------------
off_43952:      dc.w    Projectile_SpawnViblackMissile-*  ; DATA XREF: Boss_ViblackJumpTableDispatcher+4   o
                dc.w    Projectile_SpawnViblackMissile-*

; Spawns missile projectile at entity position
Projectile_SpawnViblackMissile:                         ; DATA XREF: ROM:off_43952   o  ; was: sub_43956
                                        ; ROM:00043954   o
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_432CE
                move.w  #$210,(a0)
                move.w  #$ED00,2(a0)
                move.w  #$6300,$E(a0)
                move.l  #off_EBFCC,8(a0)
                move.b  #$3C,$20(a0)                    ; '<'
                move.w  $10(a3),$10(a0)
                move.w  $14(a3),$14(a0)
                rts
; End of function Projectile_SpawnViblackMissile
; Main Viblack mini-boss handler
