Boss_MissirayAttackDispatcher:                          ; CODE XREF: Boss_MissirayUpdatePalette   p  ; was: sub_53E68
                move.w  (dword_FF9400).w,d0
                lea     off_53E74(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttackDispatcher
; ---------------------------------------------------------------------------
off_53E74:      dc.w    Boss_MissirayWaitSegmentsReady-*  ; DATA XREF: Boss_MissirayAttackDispatcher+4   o
                dc.w    Boss_MissirayShootPattern1-*
                dc.w    Boss_MissirayShootPattern2-*
                dc.w    Boss_MissirayAttackDelay-*

; Wait for segments ready
Boss_MissirayWaitSegmentsReady:                         ; DATA XREF: ROM:off_53E74   o  ; was: sub_53E7C
                move.w  #7,d7
                lea     $60(a5),a0
                movea.w #(dword_FF9414-M68K_RAM),a1
loc_53E88:                                              ; CODE XREF: Boss_MissirayWaitSegmentsReady+16   j
                tst.b   $52(a0)
                bne.s   locret_53EBC
                lea     $60(a0),a0
                dbf     d7,loc_53E88
                addq.w  #2,(dword_FF9400).w
                tst.w   (dword_FF9404).w
                bne.s   loc_53EA8
                move.w  #8,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_53EA8:                                              ; CODE XREF: Boss_MissirayWaitSegmentsReady+22   j
                tst.w   (word_FFFF0E).w
                bne.s   loc_53EB6
                move.w  #4,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_53EB6:                                              ; CODE XREF: Boss_MissirayWaitSegmentsReady+30   j
                move.w  #8,$4A(a5)
locret_53EBC:                                           ; CODE XREF: Boss_MissirayWaitSegmentsReady+10   j
                rts
; End of function Boss_MissirayWaitSegmentsReady
; Shooting pattern 1
Boss_MissirayShootPattern1:                             ; DATA XREF: ROM:00053E76   o  ; was: sub_53EBE
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_53ED4
                move.w  #$10,(a0)
                move.w  a0,(dword_FF9414).w
                addq.w  #2,(dword_FF9400).w
                rts
; ---------------------------------------------------------------------------
loc_53ED4:                                              ; CODE XREF: Boss_MissirayShootPattern1+6   j
                addq.w  #4,(dword_FF9400).w
                move.w  #8,$48(a5)
                rts
; End of function Boss_MissirayShootPattern1
; Shooting pattern 2
Boss_MissirayShootPattern2:                             ; DATA XREF: ROM:00053E78   o  ; was: sub_53EE0
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                add.w   d0,d0
                lea     word_537A8(pc),a2
                movea.w (a2,d0.w),a0
                tst.b   $52(a0)
                bne.s   locret_53F42
                tst.w   (dword_FF9404).w
                bne.s   loc_53F10
                move.b  #0,$51(a0)
                clr.w   $48(a0)
                move.w  #$20,$48(a5)                    ; ' '
                bra.s   loc_53F2E
; ---------------------------------------------------------------------------
loc_53F10:                                              ; CODE XREF: Boss_MissirayShootPattern2+1C   j
                move.b  #1,$51(a0)
                clr.w   $48(a0)
                tst.w   (word_FFFF0E).w
                bne.s   loc_53F28
                move.w  #$60,$48(a5)                    ; '`'
                bra.s   loc_53F2E
; ---------------------------------------------------------------------------
loc_53F28:                                              ; CODE XREF: Boss_MissirayShootPattern2+3E   j
                move.w  #$30,$48(a5)                    ; '0'
loc_53F2E:                                              ; CODE XREF: Boss_MissirayShootPattern2+2E   j
                                        ; Boss_MissirayShootPattern2+46   j
                move.b  #0,$50(a0)
                move.w  (dword_FF9414).w,$54(a0)
                addq.w  #2,4(a0)
                addq.w  #2,(dword_FF9400).w
locret_53F42:                                           ; CODE XREF: Boss_MissirayShootPattern2+16   j
                rts
; End of function Boss_MissirayShootPattern2
; Attack delay timer
Boss_MissirayAttackDelay:                               ; DATA XREF: ROM:00053E7A   o  ; was: sub_53F44
                subq.w  #1,$48(a5)
                bne.s   locret_53F56
                subq.w  #1,$4A(a5)
                beq.w   loc_53F58
                subq.w  #4,(dword_FF9400).w
locret_53F56:                                           ; CODE XREF: Boss_MissirayAttackDelay+4   j
                rts
; ---------------------------------------------------------------------------
loc_53F58:                                              ; CODE XREF: Boss_MissirayAttackDelay+A   j
                bra.w   Boss_MissirayResetAttackState
; End of function Boss_MissirayAttackDelay
; Attack pattern 3 dispatcher
Boss_MissirayAttackPattern3:                            ; DATA XREF: ROM:00053CBC   o  ; was: sub_53F5C
                move.w  (dword_FF9400).w,d0
                lea     off_53F68(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttackPattern3
; ---------------------------------------------------------------------------
off_53F68:      dc.w    Boss_MissirayAttackPattern3Init-*  ; DATA XREF: Boss_MissirayAttackPattern3+4   o
                dc.w    Boss_MissirayAttackPattern3Init_SpawnRing-*
                dc.w    Boss_MissirayAttackPattern3Fire-*
                dc.w    Boss_MissirayAttackPattern3Delay-*

; Attack pattern 3 init
Boss_MissirayAttackPattern3Init:                        ; DATA XREF: ROM:off_53F68   o  ; was: sub_53F70
                move.w  #3,$4A(a5)
                addq.w  #2,(dword_FF9400).w
; Spawn bullet ring and advance attack state
Boss_MissirayAttackPattern3Init_SpawnRing:              ; DATA XREF: ROM:00053F6A   o  ; was: loc_53F7A
                bsr.w   Boss_MissiraySpawnBulletRing
                bne.s   loc_53F86
                addq.w  #2,(dword_FF9400).w
                rts
; ---------------------------------------------------------------------------
loc_53F86:                                              ; CODE XREF: Boss_MissirayAttackPattern3Init+E   j
                bra.w   Boss_MissirayResetAttackState
; End of function Boss_MissirayAttackPattern3Init
nullsub_123:
                rts
; End of function nullsub_123

; Attack pattern 3 fire
Boss_MissirayAttackPattern3Fire:                        ; DATA XREF: ROM:00053F6C   o  ; was: sub_53F8C
                move.w  $4A(a5),d5
                lsl.w   #2,d5
                move.w  word_53FF6(pc,d5.w),d0
                move.w  word_53FF6+2(pc,d5.w),d1
                lea     word_537A8(pc),a1
                movea.w (a1,d0.w),a2
                tst.b   $52(a2)
                bne.s   locret_53FF4
                movea.w (a1,d1.w),a3
                tst.b   $52(a3)
                bne.s   locret_53FF4
                lea     (dword_FF9414).w,a0
                move.b  #0,$50(a2)
                move.b  #0,$51(a2)
                clr.w   $48(a2)
                move.w  (a0,d5.w),$54(a2)
                addq.w  #2,4(a2)
                move.b  #0,$50(a3)
                move.b  #0,$51(a3)
                clr.w   $48(a3)
                move.w  2(a0,d5.w),$54(a3)
                addq.w  #2,4(a3)
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,(dword_FF9400).w
locret_53FF4:                                           ; CODE XREF: Boss_MissirayAttackPattern3Fire+1A   j
                                        ; Boss_MissirayAttackPattern3Fire+24   j
                rts
; End of function Boss_MissirayAttackPattern3Fire
; ---------------------------------------------------------------------------
word_53FF6:     dc.w    0, 4, $A, $E, 2, 6, 8, $C
                                        ; DATA XREF: Boss_MissirayAttackPattern3Fire+6   r
                                        ; Boss_MissirayAttackPattern3Fire+A   r

; Attack pattern 3 delay
Boss_MissirayAttackPattern3Delay:                       ; DATA XREF: ROM:00053F6E   o  ; was: sub_54006
                subq.w  #1,$48(a5)
                bne.s   locret_54016
                subq.w  #1,$4A(a5)
                bmi.s   loc_54018
                subq.w  #2,(dword_FF9400).w
locret_54016:                                           ; CODE XREF: Boss_MissirayAttackPattern3Delay+4   j
                rts
; ---------------------------------------------------------------------------
loc_54018:                                              ; CODE XREF: Boss_MissirayAttackPattern3Delay+A   j
                bra.w   Boss_MissirayResetAttackState
; End of function Boss_MissirayAttackPattern3Delay
nullsub_124:
                rts
; End of function nullsub_124

; Dispatcher for Missiray bullet ring attack pattern state machine
Boss_MissirayAttack1Dispatcher:                         ; DATA XREF: ROM:00053CBE   o  ; was: sub_5401E
                move.w  (dword_FF9400).w,d0
                lea     off_5402A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttack1Dispatcher
; ---------------------------------------------------------------------------
off_5402A:      dc.w    Boss_MissirayAttack1Init-*      ; DATA XREF: Boss_MissirayAttack1Dispatcher+4   o
                dc.w    Boss_MissirayAttack1Init_SpawnBullets-*
                dc.w    Boss_MissirayAttack1WaitBullets-*
                dc.w    Boss_MissirayAttack1SetupDelays-*
                dc.w    Boss_MissirayAttack1SetWaitTimer-*
                dc.w    Boss_MissirayAttack1WaitTimer-*
                dc.w    Boss_MissirayAttack1Loop-*

; Initializes bullet ring attack and spawns first ring of projectiles
Boss_MissirayAttack1Init:                               ; DATA XREF: ROM:off_5402A   o  ; was: sub_54038
                move.w  #1,$4A(a5)
                addq.w  #2,(dword_FF9400).w
; Spawn bullet ring for attack pattern 1
Boss_MissirayAttack1Init_SpawnBullets:                  ; DATA XREF: ROM:0005402C   o  ; was: loc_54042
                bsr.w   Boss_MissiraySpawnBulletRing
                bne.s   loc_5404E
                addq.w  #2,(dword_FF9400).w
                rts
; ---------------------------------------------------------------------------
loc_5404E:                                              ; CODE XREF: Boss_MissirayAttack1Init+E   j
                addi.w  #$A,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttack1Init
; Waits for all 8 bullet segments to become inactive before proceeding
Boss_MissirayAttack1WaitBullets:                        ; DATA XREF: ROM:0005402E   o  ; was: sub_54056
                move.w  #7,d7
                lea     $60(a5),a0
                movea.w #(dword_FF9414-M68K_RAM),a1
loc_54062:                                              ; CODE XREF: Boss_MissirayAttack1WaitBullets+16   j
                tst.b   $52(a0)
                bne.s   locret_54074
                lea     $60(a0),a0
                dbf     d7,loc_54062
                addq.w  #2,(dword_FF9400).w
locret_54074:                                           ; CODE XREF: Boss_MissirayAttack1WaitBullets+10   j
                rts
; End of function Boss_MissirayAttack1WaitBullets
; Sets up randomized delay timers for 8 bullet segments to fire
Boss_MissirayAttack1SetupDelays:                        ; DATA XREF: ROM:00054030   o  ; was: sub_54076
                movea.w #(dword_FF9414-M68K_RAM),a1
                lea     word_540C2(pc),a2
                nop
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                lsl.w   #4,d0
                lea     (a2,d0.w),a2
                move.w  #7,d7
                moveq   #0,d6
                lea     $60(a5),a0
loc_54098:                                              ; CODE XREF: Boss_MissirayAttack1SetupDelays+42   j
                move.b  #0,$50(a0)
                move.b  #0,$51(a0)
                move.w  (a2,d6.w),$48(a0)
                move.w  (a1)+,$54(a0)
                addq.w  #2,4(a0)
                addq.w  #2,d6
                lea     $60(a0),a0
                dbf     d7,loc_54098
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttack1SetupDelays
; ---------------------------------------------------------------------------
word_540C2:     dc.w    0, $10, $20, $30, $40, $50, $60, $70, $70, $60, $50, $40, $30, $20, $10, 0
                                        ; DATA XREF: Boss_MissirayAttack1SetupDelays+4   o
                dc.w    0, $20, $40, $60, $60, $40, $20, 0, $60, $40, $20, 0, 0, $20, $40, $60

; Sets wait timer to $80 frames before bullet firing sequence
Boss_MissirayAttack1SetWaitTimer:                       ; DATA XREF: ROM:00054032   o  ; was: sub_54102
                move.w  #$80,$48(a5)
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttack1SetWaitTimer
; Waits for timer countdown then advances to next attack state
Boss_MissirayAttack1WaitTimer:                          ; DATA XREF: ROM:00054034   o  ; was: sub_5410E
                subq.w  #1,$48(a5)
                bne.s   locret_54118
                addq.w  #2,(dword_FF9400).w
locret_54118:                                           ; CODE XREF: Boss_MissirayAttack1WaitTimer+4   j
                rts
; End of function Boss_MissirayAttack1WaitTimer
; Decrements attack repetition counter and loops or resets attack state
Boss_MissirayAttack1Loop:                               ; DATA XREF: ROM:00054036   o  ; was: sub_5411A
                subq.w  #1,$4A(a5)
                beq.w   Boss_MissirayResetAttackState
                move.w  #2,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttack1Loop
; Dispatcher for Missiray wave attack pattern state machine
Boss_MissirayAttack2Dispatcher:                         ; DATA XREF: ROM:00053CC0   o  ; was: sub_5412A
                                        ; ROM:00053CC8   o
                move.w  (dword_FF9400).w,d0
                lea     off_54136(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttack2Dispatcher
; ---------------------------------------------------------------------------
off_54136:      dc.w    Boss_MissirayAttack2Init-*      ; DATA XREF: Boss_MissirayAttack2Dispatcher+4   o
                dc.w    Boss_MissirayAttack2Init_FadeLoop-*
                dc.w    Boss_MissirayShuffleSegmentOrder-*
                dc.w    Boss_MissirayActivateNextSegment-*
                dc.w    Boss_MissiraySegmentActivationDelay-*
                dc.w    Boss_MissirayMoveHorizontal-*
                dc.w    Boss_MissirayFinishSegmentPattern-*

; Initializes wave attack with rotating segment setup and angle initialization
Boss_MissirayAttack2Init:                               ; DATA XREF: ROM:off_54136   o  ; was: sub_54144
                bset    #4,$23(a5)
                clr.w   (dword_FF940C+2).w
                move.w  #$8000,(dword_FF9410+2).w
                addq.w  #2,(dword_FF9400).w
; Execute palette fade during attack 2 initialization
Boss_MissirayAttack2Init_FadeLoop:                      ; DATA XREF: ROM:00054138   o  ; was: loc_54158
                bsr.w   Gfx_ApplyPaletteFadeWrapper
                addq.w  #1,(dword_FF940C+2).w
                cmpi.w  #$E,(dword_FF940C+2).w
                bne.w   locret_54192
                lea     (dword_FF9414).w,a1
                move.w  #$C680,(a1)+
                move.w  #$C6E0,(a1)+
                move.w  #$C740,(a1)+
                move.w  #$C7A0,(a1)+
                move.w  #$C800,(a1)+
                move.w  #$C860,(a1)+
                move.w  #$C8C0,(a1)+
                move.w  #$C920,(a1)+
                addq.w  #2,(dword_FF9400).w
locret_54192:                                           ; CODE XREF: Boss_MissirayAttack2Init+22   j
                rts
; End of function Boss_MissirayAttack2Init
; Randomizes order of 8 segment pointers in array for attack sequence
Boss_MissirayShuffleSegmentOrder:                       ; DATA XREF: ROM:0005413A   o  ; was: sub_54194
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                lea     (dword_FF9414).w,a1
                move.w  #7,d6
loc_541A0:                                              ; CODE XREF: Boss_MissirayShuffleSegmentOrder+3C   j
                move.w  #7,d7
loc_541A4:                                              ; CODE XREF: Boss_MissirayShuffleSegmentOrder+38   j
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                add.w   d0,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #7,d1
                add.w   d1,d1
                move.w  (a1,d0.w),d2
                move.w  (a1,d1.w),(a1,d0.w)
                move.w  d2,(a1,d1.w)
                dbf     d7,loc_541A4
                dbf     d6,loc_541A0
                addq.w  #2,(dword_FF9400).w
                clr.w   $4A(a5)
                tst.w   (dword_FF9404).w
                beq.s   loc_541F6
                move.w  #$B8,(dword_FF9408).w
                addi.w  #-$10,$4E(a5)
                move.w  #$B8,$50(a5)
                rts
; ---------------------------------------------------------------------------
loc_541F6:                                              ; CODE XREF: Boss_MissirayShuffleSegmentOrder+4C   j
                move.w  #$C8,(dword_FF9408).w
                addi.w  #$10,$4E(a5)
                move.w  #$FF48,$50(a5)
                rts
; End of function Boss_MissirayShuffleSegmentOrder
; Activates next segment from shuffled array for attack pattern
Boss_MissirayActivateNextSegment:                       ; DATA XREF: ROM:0005413C   o  ; was: sub_5420A
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                lea     (dword_FF9414).w,a1
                move.w  $4A(a5),d0
                movea.w (a1,d0.w),a0
                tst.b   $52(a0)
                bne.s   locret_5423A
                addq.w  #2,4(a0)
                move.b  #1,$50(a0)
                move.w  $50(a5),$4E(a0)
                move.w  #$18,$48(a5)
                addq.w  #2,(dword_FF9400).w
locret_5423A:                                           ; CODE XREF: Boss_MissirayActivateNextSegment+14   j
                rts
; End of function Boss_MissirayActivateNextSegment
; Delays between segment activations, plays sound when all ready
Boss_MissiraySegmentActivationDelay:                    ; DATA XREF: ROM:0005413E   o  ; was: sub_5423C
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                subq.w  #1,$48(a5)
                bne.s   locret_54256
                addq.w  #2,$4A(a5)
                cmpi.w  #$10,$4A(a5)
                beq.s   loc_54258
                subq.w  #2,(dword_FF9400).w
locret_54256:                                           ; CODE XREF: Boss_MissiraySegmentActivationDelay+8   j
                rts
; ---------------------------------------------------------------------------
loc_54258:                                              ; CODE XREF: Boss_MissiraySegmentActivationDelay+14   j
                move.w  #$50,$48(a5)                    ; 'P'
                addq.w  #2,(dword_FF9400).w
                move.b  #$57,d0                         ; 'W'
                jsr     (Sound_PlaySFX).l
                btst    #7,$50(a5)
                bne.s   loc_5427C
                move.w  #2,(dword_FF9408+2).w
                rts
; ---------------------------------------------------------------------------
loc_5427C:                                              ; CODE XREF: Boss_MissiraySegmentActivationDelay+36   j
                move.w  #$FFFE,(dword_FF9408+2).w
                rts
; End of function Boss_MissiraySegmentActivationDelay
; Moves boss horizontally and initializes segment positions
Boss_MissirayMoveHorizontal:                            ; DATA XREF: ROM:00054140   o  ; was: sub_54284
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                move.w  (dword_FF9408+2).w,d0
                add.w   d0,$14(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_542BE
                clr.w   (dword_FF9408+2).w
                addq.w  #2,(dword_FF9400).w
                move.w  $14(a5),$4E(a5)
                moveq   #0,d0
                move.w  #7,d7
                lea     $60(a5),a0
loc_542AE:                                              ; CODE XREF: Boss_MissirayMoveHorizontal+36   j
                move.w  d0,$4C(a0)
                move.w  d0,$4E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_542AE
locret_542BE:                                           ; CODE XREF: Boss_MissirayMoveHorizontal+10   j
                rts
; End of function Boss_MissirayMoveHorizontal
; Clears attack flag and resets to idle state after pattern
Boss_MissirayFinishSegmentPattern:                      ; DATA XREF: ROM:00054142   o  ; was: sub_542C0
                bclr    #4,$23(a5)
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                bra.w   Boss_MissirayResetAttackState
; End of function Boss_MissirayFinishSegmentPattern
; Dispatcher for attack pattern 4 (facing right attack)
Boss_MissirayAttackPattern4Dispatcher:                  ; DATA XREF: ROM:00053CCA   o  ; was: sub_542CE
                move.w  (dword_FF9400).w,d0
                lea     off_542DA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttackPattern4Dispatcher
; ---------------------------------------------------------------------------
off_542DA:      dc.w    Boss_MissirayAttackPattern4Init-*  ; DATA XREF: Boss_MissirayAttackPattern4Dispatcher+4   o
                dc.w    Boss_MissirayAttackPattern4Wait1-*
                dc.w    Boss_MissirayAttackPattern4Wait2-*
                dc.w    Boss_MissirayAttackPattern4Wait3-*
                dc.w    Boss_MissirayAttackPattern4Loop-*

; Initializes attack pattern 4 with graphics and direction
Boss_MissirayAttackPattern4Init:                        ; DATA XREF: ROM:off_542DA   o  ; was: sub_542E4
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                move.w  #0,(dword_FF9404).w
                move.w  #$A0,(dword_FF9404+2).w
                move.l  #$F40CE41C,$2C(a5)
                move.l  #$F010E41C,$28(a5)
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttackPattern4Init
; Waits for screen fade completion before continuing pattern
Boss_MissirayAttackPattern4Wait1:                       ; DATA XREF: ROM:000542DC   o  ; was: sub_5430A
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_5431C
                addq.w  #2,(dword_FF9400).w
                bra.w   Gfx_MissirayLoadTilesSet1
; ---------------------------------------------------------------------------
locret_5431C:                                           ; CODE XREF: Boss_MissirayAttackPattern4Wait1+8   j
                rts
; End of function Boss_MissirayAttackPattern4Wait1
; Waits for fade and triggers battle start for pattern 4
Boss_MissirayAttackPattern4Wait2:                       ; DATA XREF: ROM:000542DE   o  ; was: sub_5431E
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_54330
                addq.w  #2,(dword_FF9400).w
                bra.w   Boss_MissirayBattleStart
; ---------------------------------------------------------------------------
locret_54330:                                           ; CODE XREF: Boss_MissirayAttackPattern4Wait2+8   j
                rts
; End of function Boss_MissirayAttackPattern4Wait2
; Waits for fade, sets idle state and timer for pattern 4
Boss_MissirayAttackPattern4Wait3:                       ; DATA XREF: ROM:000542E0   o  ; was: sub_54332
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_5434A
                addq.w  #2,(dword_FF9400).w
                bsr.w   Boss_MissirayIdleState
                move.w  #$E,(dword_FF940C+2).w
locret_5434A:                                           ; CODE XREF: Boss_MissirayAttackPattern4Wait3+8   j
                rts
; End of function Boss_MissirayAttackPattern4Wait3
; Updates graphics animation during attack pattern 4
Boss_MissirayAttackPattern4Loop:                        ; DATA XREF: ROM:000542E2   o  ; was: sub_5434C
                bsr.w   Gfx_ApplyPaletteFadeWrapper
                subq.w  #1,(dword_FF940C+2).w
                bpl.s   locret_5435A
                bra.w   Boss_MissirayResetAttackState
; ---------------------------------------------------------------------------
locret_5435A:                                           ; CODE XREF: Boss_MissirayAttackPattern4Loop+8   j
                rts
; End of function Boss_MissirayAttackPattern4Loop
; Dispatcher for attack pattern 5 (facing left attack)
Boss_MissirayAttackPattern5Dispatcher:                  ; DATA XREF: ROM:00053CC2   o  ; was: sub_5435C
                move.w  (dword_FF9400).w,d0
                lea     off_54368(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttackPattern5Dispatcher
; ---------------------------------------------------------------------------
off_54368:      dc.w    Boss_MissirayAttackPattern5Init-*  ; DATA XREF: Boss_MissirayAttackPattern5Dispatcher+4   o
                dc.w    Boss_MissirayAttackPattern5Wait1-*
                dc.w    Boss_MissirayAttackPattern5Wait2-*
                dc.w    Boss_MissirayAttackPattern5Wait3-*
                dc.w    Boss_MissirayAttackPattern5Loop-*

; Initializes attack pattern 5 with graphics and direction
Boss_MissirayAttackPattern5Init:                        ; DATA XREF: ROM:off_54368   o  ; was: sub_54372
                move.w  #1,(dword_FF9404).w
                move.l  #$F40CE41C,$2C(a5)
                move.l  #$F010E41C,$28(a5)
                move.w  #$C0,(dword_FF9404+2).w
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttackPattern5Init
; Waits for screen fade completion before continuing pattern
Boss_MissirayAttackPattern5Wait1:                       ; DATA XREF: ROM:0005436A   o  ; was: sub_54394
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_543A6
                addq.w  #2,(dword_FF9400).w
                bra.w   Gfx_MissirayLoadTilesSet2
; ---------------------------------------------------------------------------
locret_543A6:                                           ; CODE XREF: Boss_MissirayAttackPattern5Wait1+8   j
                rts
; End of function Boss_MissirayAttackPattern5Wait1
; Waits for fade before next phase of pattern 5
Boss_MissirayAttackPattern5Wait2:                       ; DATA XREF: ROM:0005436C   o  ; was: sub_543A8
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_543BA
                addq.w  #2,(dword_FF9400).w
                bra.w   Gfx_MissirayLoadCompressedSet1
; ---------------------------------------------------------------------------
locret_543BA:                                           ; CODE XREF: Boss_MissirayAttackPattern5Wait2+8   j
                rts
; End of function Boss_MissirayAttackPattern5Wait2
; Waits for fade, sets up idle state and timer for pattern 5
Boss_MissirayAttackPattern5Wait3:                       ; DATA XREF: ROM:0005436E   o  ; was: sub_543BC
                bsr.w   Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_543D4
                addq.w  #2,(dword_FF9400).w
                bsr.w   Gfx_MissirayLoadCompressedSet2
                move.w  #$E,(dword_FF940C+2).w
locret_543D4:                                           ; CODE XREF: Boss_MissirayAttackPattern5Wait3+8   j
                rts
; End of function Boss_MissirayAttackPattern5Wait3
; Updates graphics animation during attack pattern 5
Boss_MissirayAttackPattern5Loop:                        ; DATA XREF: ROM:00054370   o  ; was: sub_543D6
                bsr.w   Gfx_ApplyPaletteFadeWrapper
                subq.w  #1,(dword_FF940C+2).w
                bpl.s   locret_543E4
                bra.w   Boss_MissirayResetAttackState
; ---------------------------------------------------------------------------
locret_543E4:                                           ; CODE XREF: Boss_MissirayAttackPattern5Loop+8   j
                rts
; End of function Boss_MissirayAttackPattern5Loop
; Dispatcher for idle delay state between attacks
Boss_MissirayIdleDelayDispatcher:
                move.w  (dword_FF9400).w,d0             ; was: sub_543E6
                lea     off_543F2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayIdleDelayDispatcher
; ---------------------------------------------------------------------------
off_543F2:      dc.w    Boss_MissirayIdleDelayCountdown-*  ; DATA XREF: Boss_MissirayIdleDelayDispatcher+4   o
                dc.w    Boss_MissirayIdleDelayCountdown_WaitLoop-*

; Counts down idle timer and returns to attack state
Boss_MissirayIdleDelayCountdown:                        ; DATA XREF: ROM:off_543F2   o  ; was: sub_543F6
                move.w  #$80,$48(a5)
                addq.w  #2,(dword_FF9400).w
; Countdown timer during idle delay before reset
Boss_MissirayIdleDelayCountdown_WaitLoop:               ; DATA XREF: ROM:000543F4   o  ; was: loc_54400
                subq.w  #1,$48(a5)
                bne.s   locret_5440A
                bra.w   Boss_MissirayResetAttackState
; ---------------------------------------------------------------------------
locret_5440A:                                           ; CODE XREF: Boss_MissirayIdleDelayCountdown+E   j
                rts
; End of function Boss_MissirayIdleDelayCountdown
; Spawn ring of bullets
Boss_MissiraySpawnBulletRing:                           ; CODE XREF: Boss_MissirayAttackPattern3Init:loc_53F7A   p  ; was: sub_5440C
                                        ; sub_54038:loc_54042   p
                move.w  #7,d7
                lea     (dword_FF9414).w,a3
                moveq   #0,d0
loc_54416:                                              ; CODE XREF: Boss_MissiraySpawnBulletRing+C   j
                move.w  d0,(a3)+
                dbf     d7,loc_54416
                move.w  #7,d7
                lea     (dword_FF9414).w,a3
loc_54424:                                              ; CODE XREF: Boss_MissiraySpawnBulletRing+26   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_5443C
                move.w  #$10,(a0)
                move.w  a0,(a3)+
                dbf     d7,loc_54424
                move.w  #0,d0
                rts
; ---------------------------------------------------------------------------
loc_5443C:                                              ; CODE XREF: Boss_MissiraySpawnBulletRing+1E   j
                move.w  #7,d7
                lea     (dword_FF9414).w,a3
loc_54444:                                              ; CODE XREF: Boss_MissiraySpawnBulletRing+42   j
                movea.w (a3)+,a0
                beq.s   locret_54456
                move.w  #$1000,2(a0)
                dbf     d7,loc_54444
                move.w  #1,d0
locret_54456:                                           ; CODE XREF: Boss_MissiraySpawnBulletRing+3A   j
                rts
; End of function Boss_MissiraySpawnBulletRing
; Segment part main handler
