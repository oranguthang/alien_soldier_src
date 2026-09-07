Boss_SnakeMain:                                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4079E
                tst.w   4(a5)
                beq.w   Boss_SnakeStateDispatch
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$4E(a5)
                btst    #1,$4C(a5)
                bne.s   loc_407D4
                btst    #1,(byte_FF80EC).w
                bne.s   loc_407D4
                tst.w   (word_FF8200).w
                bne.s   loc_407D4
                move.b  #2,(byte_FF80EC).w
                move.w  #$A,4(a5)
loc_407D4:                                              ; CODE XREF: Boss_SnakeMain+1A   j
                                        ; Boss_SnakeMain+22   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                swap    d0
                move.w  $14(a5),d0
                lea     (dword_FF9420).w,a0
                move.w  #$16,d7
loc_407F0:                                              ; CODE XREF: Boss_SnakeMain+62   j
                move.w  (dword_FF940C+2).w,d6
                subq.w  #1,d6
loc_407F6:                                              ; CODE XREF: Boss_SnakeMain+5E   j
                move.l  (a0),d1
                move.l  d0,(a0)+
                move.l  d1,d0
                dbf     d6,loc_407F6
                dbf     d7,loc_407F0
                move.w  #$16,d7
                lea     $60(a5),a0
                lea     (dword_FF9420).w,a1
                move.w  (dword_FF940C+2).w,d6
                add.w   d6,d6
                add.w   d6,d6
loc_40818:                                              ; CODE XREF: Boss_SnakeMain+92   j
                lea     (a1,d6.w),a1
                move.w  (a1),d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a0)
                move.w  2(a1),$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_40818
                bsr.w   Boss_SnakeUpdateAnimation
; State machine dispatcher for Snake boss
Boss_SnakeStateDispatch:                                ; CODE XREF: Boss_SnakeMain+4   j  ; was: loc_40838
                move.w  4(a5),d0
                lea     off_40844(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SnakeMain
; ---------------------------------------------------------------------------
off_40844:      dc.w    Boss_SnakeInit-*                ; DATA XREF: Boss_SnakeMain+9E   o
                dc.w    Boss_SnakeStartBattle-*
                dc.w    Boss_SnakeBattleActive-*
                dc.w    Boss_SnakePhase1-*
                dc.w    Boss_SnakePhase2-*
                dc.w    Boss_SnakeSegmentDestroy-*
                dc.w    Boss_SnakeSegmentDestroyLoop-*
                dc.w    nullsub_83-*

; Initializes Snake boss with 23 segments
Boss_SnakeInit:                                         ; DATA XREF: ROM:off_40844   o  ; was: sub_40854
                tst.b   (word_FFF720).w
                bmi.w   locret_40940
                addq.w  #2,4(a5)
                move.b  #4,(byte_FFA420).w
                move.w  #4,(dword_FF940C+2).w
                move.w  #$10,(dword_FF9408+2).w
                move.w  #$10,(dword_FF940C).w
                move.w  #$4000,(word_FF8202).w
                move.w  #$4000,(word_FF8200).w
                move.w  #$E300,$E(a5)
                move.w  #$CD00,2(a5)
                move.l  #Sprite_SharedGraphicsFrameTable,8(a5)
                clr.w   $C(a5)
                clr.w   $54(a5)
                move.b  #$10,$20(a5)
                move.b  #$50,$21(a5)                    ; 'P'
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$24(a5)                    ; '('
                move.w  #$80,$26(a5)
                move.b  #6,(byte_FF80EC).w
                move.b  #$80,$23(a5)
                move.w  #$16,d7
                clr.w   d6
                lea     $60(a5),a0
loc_408DE:                                              ; CODE XREF: Boss_SnakeInit+E8   j
                move.w  #$29C,(a0)
                move.l  #Sprite_SharedGraphicsFrameTable,8(a0)
                clr.w   $C(a0)
                move.w  #$E300,$E(a0)
                move.w  #$CD00,2(a0)
                move.w  #$80,$26(a0)
                move.b  #$10,$20(a0)
                move.w  #$14,$24(a0)
                btst    #0,d7
                bne.s   Boss_SnakeSetSegmentAngle
                move.b  #$50,$21(a0)                    ; 'P'
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
                addi.w  #4,d6
                cmpi.w  #$1E,d6
                bls.s   Boss_SnakeSetSegmentAngle
                clr.w   d6
; Sets angle offset for snake segments
Boss_SnakeSetSegmentAngle:                              ; CODE XREF: Boss_SnakeInit+BC   j  ; was: loc_40934
                                        ; Boss_SnakeInit+DC   j
                move.w  d6,$54(a0)
                lea     $60(a0),a0
                dbf     d7,loc_408DE
locret_40940:                                           ; CODE XREF: Boss_SnakeInit+4   j
                rts
; End of function Boss_SnakeInit
; Starts Snake boss battle phase
Boss_SnakeStartBattle:                                  ; DATA XREF: ROM:00040846   o  ; was: sub_40942
                bsr.w   Boss_SnakeAI
                clr.b   (byte_FF80EC).w
                clr.w   $4A(a5)
                move.w  (dword_FFA900).w,(dword_FF9404+2).w
                addi.w  #$120,(dword_FF9404+2).w
                move.w  #$100,(dword_FF9408).w
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_SnakeStartBattle
; Active battle state for Snake boss
Boss_SnakeBattleActive:                                 ; DATA XREF: ROM:00040848   o  ; was: sub_4096C
                bsr.w   Boss_SnakeAI
                bsr.w   Boss_SnakeUpdateHeadPosition
                bsr.w   Boss_SnakeRandomizeSegments
                cmpi.w  #$56,(word_FF80C2).w            ; 'V'
                bcs.s   locret_4098A
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4098A:                                           ; CODE XREF: Boss_SnakeBattleActive+12   j
                rts
; End of function Boss_SnakeBattleActive
; Updates Snake head position with wave
Boss_SnakeUpdateHeadPosition:                           ; CODE XREF: Boss_SnakeBattleActive+4   p  ; was: sub_4098C
                move.w  (word_FFA000).w,d0
                andi.w  #$7F,d0
                bne.s   Boss_SnakeHeadPattern
                addq.w  #1,$52(a5)
; Calculates head position pattern offset
Boss_SnakeHeadPattern:                                  ; CODE XREF: Boss_SnakeUpdateHeadPosition+8   j  ; was: loc_4099A
                move.w  $52(a5),d0
                andi.w  #$F,d0
                add.w   d0,d0
                move.w  word_409BC(pc,d0.w),d1
                move.w  (dword_FFA900).w,d2
                add.w   word_409DC(pc,d1.w),d2
                move.w  d2,(dword_FF9404+2).w
                move.w  word_409E6(pc,d1.w),(dword_FF9408).w
                rts
; End of function Boss_SnakeUpdateHeadPosition
; ---------------------------------------------------------------------------
word_409BC:     dc.w    2, 4, 2, 4, 8, 2, 4, 2, 6, 4, 0, 8, 0, 2, 4, 2
                                        ; DATA XREF: Boss_SnakeUpdateHeadPosition+18   r
word_409DC:     dc.w    $C0, $120, $180, $C0, $180
                                        ; DATA XREF: Boss_SnakeUpdateHeadPosition+20   r
word_409E6:     dc.w    $150, $140, $150, $140, $F0
                                        ; DATA XREF: Boss_SnakeUpdateHeadPosition+28   r

; Randomizes segment sizes
Boss_SnakeRandomizeSegments:                            ; CODE XREF: Boss_SnakeBattleActive+8   p  ; was: sub_409F0
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0                         ; '?'
                bne.s   locret_40A1E
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                addi.w  #$10,d0
                move.w  d0,(dword_FF9408+2).w
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                addi.w  #$10,d0
                move.w  d0,(dword_FF940C).w
locret_40A1E:                                           ; CODE XREF: Boss_SnakeRandomizeSegments+8   j
                rts
; End of function Boss_SnakeRandomizeSegments
; Phase 1 behavior with countdown timer
Boss_SnakePhase1:                                       ; DATA XREF: ROM:0004084A   o  ; was: sub_40A20
                move.w  (dword_FFA900).w,(dword_FF9404+2).w
                addi.w  #$160,(dword_FF9404+2).w
                move.w  #$140,(dword_FF9408).w
                bsr.w   Boss_SnakeAI
                subq.w  #1,$48(a5)
                bne.s   locret_40A46
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
locret_40A46:                                           ; CODE XREF: Boss_SnakePhase1+1A   j
                rts
; End of function Boss_SnakePhase1
; Phase 2 behavior with final cleanup
Boss_SnakePhase2:                                       ; DATA XREF: ROM:0004084C   o  ; was: sub_40A48
                move.w  (dword_FFA900).w,(dword_FF9404+2).w
                addi.w  #$120,(dword_FF9404+2).w
                move.w  #$200,(dword_FF9408).w
                bsr.w   Boss_SnakeAI
                subq.w  #1,$48(a5)
                bne.s   locret_40A6C
                clr.w   (a5)
                move.w  #$1000,2(a5)
locret_40A6C:                                           ; CODE XREF: Boss_SnakePhase2+1A   j
                rts
; End of function Boss_SnakePhase2
; Segment destroyed with explosion
Boss_SnakeSegmentDestroy:                               ; DATA XREF: ROM:0004084E   o  ; was: sub_40A6E
                bsr.w   Boss_SnakeAI
                jsr     (Projectile_ExplodeOnImpact).l
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                andi.w  #$7FFF,2(a5)
                move.w  #$10,$48(a5)
                move.w  a5,$4A(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_40AB6
                moveq   #3,d0
                jsr     (loc_2BD20).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
locret_40AB6:                                           ; CODE XREF: Boss_SnakeSegmentDestroy+32   j
                rts
; End of function Boss_SnakeSegmentDestroy
; Destroys snake segments sequentially
Boss_SnakeSegmentDestroyLoop:                           ; DATA XREF: ROM:00040850   o  ; was: sub_40AB8
                bsr.w   Boss_SnakeAI
                subq.w  #1,$48(a5)
                bne.s   locret_40AE6
                movea.w $4A(a5),a0
                lea     $60(a0),a0
                clr.b   $21(a0)
                move.w  #1,$5E(a0)
                lea     $8A0(a5),a1
                cmpa.w  a1,a0
                bhi.s   loc_40AE8
                move.w  a0,$4A(a5)
                move.w  #8,$48(a5)
locret_40AE6:                                           ; CODE XREF: Boss_SnakeSegmentDestroyLoop+8   j
                rts
; ---------------------------------------------------------------------------
loc_40AE8:                                              ; CODE XREF: Boss_SnakeSegmentDestroyLoop+22   j
                move.w  #$1000,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_SnakeSegmentDestroyLoop
nullsub_83:                                             ; DATA XREF: ROM:00040852   o
                rts
; End of function nullsub_83

; Main handler for Snake segment
Boss_SnakeSegmentMain:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_40AF6
                bsr.w   Boss_SnakeUpdateAnimation
                tst.b   $21(a5)
                beq.s   loc_40B0A
                tst.w   (word_FF8200).w
                bne.s   loc_40B0A
                clr.b   $21(a5)
loc_40B0A:                                              ; CODE XREF: Boss_SnakeSegmentMain+8   j
                                        ; Boss_SnakeSegmentMain+E   j
                cmpi.w  #4,4(a5)
                bcc.s   Boss_SnakeSegmentDispatch
                tst.w   $5E(a5)
                beq.s   Boss_SnakeSegmentDispatch
                move.w  #4,4(a5)
                jsr     (Projectile_ExplodeOnImpact).l
                andi.w  #$7FFF,2(a5)
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Boss_SnakeSegmentDispatch
                moveq   #3,d0
                jsr     (loc_2BD20).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
; State dispatcher for snake segments
Boss_SnakeSegmentDispatch:                              ; CODE XREF: Boss_SnakeSegmentMain+1A   j  ; was: loc_40B46
                                        ; Boss_SnakeSegmentMain+20   j
                move.w  4(a5),d0
                lea     off_40B52(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SnakeSegmentMain
; ---------------------------------------------------------------------------
off_40B52:      dc.w    Boss_SnakeSegmentWait-*         ; DATA XREF: Boss_SnakeSegmentMain+54   o
                dc.w    Boss_SnakeSegmentAttackDelay-*
                dc.w    nullsub_84-*

; Segment waits to attack
Boss_SnakeSegmentWait:                                  ; DATA XREF: ROM:off_40B52   o  ; was: sub_40B58
                cmpi.w  #$140,$14(a5)
                blt.s   locret_40B9A
                cmpi.w  #$160,$14(a5)
                bgt.s   locret_40B9A
                lea     (word_FFCF80).w,a0
                jsr     (Projectile_FindFreePrimarySlot_CheckEnemyRange).l
                bne.s   locret_40B9A
                jsr     (Projectile_InitType88).l
                bsr.s   Boss_SnakeSetupProjectile
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
                move.w  (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   locret_40B9A
                move.b  #$4C,d0                         ; 'L'
                jsr     (Sound_PlaySFX).l
locret_40B9A:                                           ; CODE XREF: Boss_SnakeSegmentWait+6   j
                                        ; Boss_SnakeSegmentWait+E   j
                rts
; End of function Boss_SnakeSegmentWait
; Delay after segment attack
Boss_SnakeSegmentAttackDelay:                           ; DATA XREF: ROM:00040B54   o  ; was: sub_40B9C
                subq.w  #1,$48(a5)
                bne.s   locret_40BA6
                subq.w  #2,4(a5)
locret_40BA6:                                           ; CODE XREF: Boss_SnakeSegmentAttackDelay+4   j
                rts
; End of function Boss_SnakeSegmentAttackDelay
nullsub_84:                                             ; DATA XREF: ROM:00040B56   o
                rts
; End of function nullsub_84

; Sets up projectile from segment
Boss_SnakeSetupProjectile:                              ; CODE XREF: Boss_SnakeSegmentWait+22   p  ; was: sub_40BAA
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                subq.w  #4,d0
                move.w  d0,$18(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                neg.w   d0
                move.w  d0,$1C(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_40BEC(pc,d0.w),8(a0)
                move.w  #$C000,$E(a0)
                rts
; End of function Boss_SnakeSetupProjectile
; ---------------------------------------------------------------------------
off_40BEC:      dc.l    off_1A0E96                      ; DATA XREF: Boss_SnakeSetupProjectile+34   r
                dc.l    off_1A0E86
                dc.l    off_1A0E96
                dc.l    off_1A0EA6

; Snake boss AI and movement control
Boss_SnakeAI:                                           ; CODE XREF: Boss_SnakeStartBattle   p  ; was: sub_40BFC
                                        ; sub_4096C   p
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_40C48
                move.w  (dword_FF9404+2).w,d0
                sub.w   (dword_FFA900).w,d0
                move.w  (dword_FF9408).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_CalculateDirectionIndex).l
                move.w  (dword_FF9400).w,d1
                addi.w  #$100,d1
                sub.w   d2,d1
                andi.w  #$1FF,d1
                cmpi.w  #$100,d1
                beq.s   loc_40C48
                cmpi.w  #$100,d1
                bcs.s   loc_40C42
                move.w  #8,(dword_FF9400+2).w
                bra.s   loc_40C48
; ---------------------------------------------------------------------------
loc_40C42:                                              ; CODE XREF: Boss_SnakeAI+3C   j
                move.w  #$FFF8,(dword_FF9400+2).w
loc_40C48:                                              ; CODE XREF: Boss_SnakeAI+8   j
                                        ; Boss_SnakeAI+36   j
                move.w  (dword_FF9400+2).w,d0
                add.w   d0,(dword_FF9400).w
                andi.w  #$1FF,(dword_FF9400).w
                move.w  (dword_FF9400).w,d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d0.w),d1
                move.w  (a1,d0.w),d0
                muls.w  (dword_FF9408+2).w,d0
                muls.w  (dword_FF940C).w,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                rts
; End of function Boss_SnakeAI
; Updates Snake animation frame
Boss_SnakeUpdateAnimation:                              ; CODE XREF: Boss_SnakeMain+96   p  ; was: sub_40C82
                                        ; sub_40AF6   p
                move.w  (word_FFA000).w,d7
                andi.w  #1,d7
                bne.s   locret_40CAE
                addq.w  #1,$54(a5)
                cmpi.w  #$1E,$54(a5)
                bne.s   Boss_SnakeGetAnimFrame
                clr.w   $54(a5)
; Gets animation frame from table lookup
Boss_SnakeGetAnimFrame:                                 ; CODE XREF: Boss_SnakeUpdateAnimation+14   j  ; was: loc_40C9C
                move.w  $54(a5),d0
                add.w   d0,d0
                move.w  word_40CB0(pc,d0.w),d1
                add.w   d1,d1
                jsr     (Sprite_SetGraphicsPointer).l
locret_40CAE:                                           ; CODE XREF: Boss_SnakeUpdateAnimation+8   j
                rts
; End of function Boss_SnakeUpdateAnimation
; ---------------------------------------------------------------------------
word_40CB0:     dc.w    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, $A, $B, $C, $D, $E
                                        ; DATA XREF: Boss_SnakeUpdateAnimation+20   r
                dc.w    $F, $E, $D, $C, $B, $A, 9, 8, 7, 6, 5, 4, 3, 2, 1

nullsub_85:
                rts
; End of function nullsub_85

; Initializes palette fade and dispatches to state handler table
