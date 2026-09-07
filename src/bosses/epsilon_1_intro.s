Boss_Epsilon1IntroMain:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_46D68
                btst    #0,(word_FFC66C).w
                bne.s   loc_46D78
                btst    #2,(word_FFC66C).w
                beq.s   loc_46D98
loc_46D78:                                              ; CODE XREF: Boss_Epsilon1IntroMain+6   j
                andi.w  #$7FFF,2(a5)
                clr.w   4(a5)
                tst.w   (dword_FF9420).w
                beq.s   loc_46D98
                movea.w (dword_FF9420).w,a0
                bset    #4,2(a0)
                clr.w   (dword_FF9420).w
                rts
; ---------------------------------------------------------------------------
loc_46D98:                                              ; CODE XREF: Boss_Epsilon1IntroMain+E   j
                                        ; Boss_Epsilon1IntroMain+1E   j
                tst.w   $5E(a5)
                bne.w   Boss_Epsilon1IntroDispatcher
                move.w  4(a5),d0
                lea     off_46DAC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1IntroMain
; ---------------------------------------------------------------------------
off_46DAC:      dc.w    nullsub_87-*                    ; DATA XREF: Boss_Epsilon1IntroMain+3C   o
                dc.w    Boss_Epsilon1MinibossInit-*
                dc.w    Boss_Epsilon1MinibossTrackPlayer-*
                dc.w    Boss_Epsilon1MinibossSpawnProjectile-*
                dc.w    Boss_Epsilon1MinibossSlowdown-*
                dc.w    nullsub_88-*
                dc.w    Boss_Epsilon1MinibossLoopOrEnd-*

nullsub_87:                                             ; DATA XREF: ROM:off_46DAC   o
                rts
; End of function nullsub_87

; Initializes Epsilon1 miniboss mirroring main boss
Boss_Epsilon1MinibossInit:                              ; DATA XREF: ROM:00046DAE   o  ; was: sub_46DBC
                addq.w  #2,4(a5)
                ori.w   #$8000,2(a5)
                move.w  (dword_FFC630).w,$10(a5)
                move.w  (dword_FFC634).w,$14(a5)
                move.w  #4,$4A(a5)
                move.w  #$FFFF,$4E(a5)
                move.w  #$40,$48(a5)                    ; '@'
                rts
; End of function Boss_Epsilon1MinibossInit
; Tracks player within distance thresholds
Boss_Epsilon1MinibossTrackPlayer:                       ; DATA XREF: ROM:00046DB0   o  ; was: sub_46DE6
                bsr.w   Physics_CalculateAngleAndVelocity
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_46DF6
                neg.w   d0
loc_46DF6:                                              ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer+C   j
                cmpi.w  #$10,d0
                bcc.s   loc_46E10
                move.w  (word_FF824A).w,d0
                sub.w   $14(a5),d0
                bpl.s   loc_46E08
                neg.w   d0
loc_46E08:                                              ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer+1E   j
                cmpi.w  #$18,d0
                bcc.s   loc_46E10
                bra.s   loc_46E16
; ---------------------------------------------------------------------------
loc_46E10:                                              ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer+14   j
                                        ; Boss_Epsilon1MinibossTrackPlayer+26   j
                subq.w  #1,$48(a5)
                bpl.s   locret_46E2E
loc_46E16:                                              ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer+28   j
                tst.w   (dword_FF9420).w
                bne.s   locret_46E2E
                move.w  #$10,$48(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
locret_46E2E:                                           ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer+2E   j
                                        ; Boss_Epsilon1MinibossTrackPlayer+34   j
                rts
; End of function Boss_Epsilon1MinibossTrackPlayer
; Calculates angle and sets velocity from sine/cosine
Physics_CalculateAngleAndVelocity:                      ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer   p  ; was: sub_46E30
                                        ; sub_46F1E   p
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_46E6C
                jsr     (Math_CalculateAngleToPlayer).l
                tst.w   $4E(a5)
                bpl.s   loc_46E4C
                move.w  d2,$4E(a5)
                bra.s   loc_46E6C
; ---------------------------------------------------------------------------
loc_46E4C:                                              ; CODE XREF: Physics_CalculateAngleAndVelocity+14   j
                move.w  $4E(a5),d1
                sub.w   d2,d1
                andi.w  #$1FF,d1
                beq.s   loc_46E6C
                cmpi.w  #$100,d1
                bcs.s   loc_46E66
                move.w  #$10,$4C(a5)
                bra.s   loc_46E6C
; ---------------------------------------------------------------------------
loc_46E66:                                              ; CODE XREF: Physics_CalculateAngleAndVelocity+2C   j
                move.w  #$FFF0,$4C(a5)
loc_46E6C:                                              ; CODE XREF: Physics_CalculateAngleAndVelocity+8   j
                                        ; Physics_CalculateAngleAndVelocity+1A   j
                move.w  $4C(a5),d0
                add.w   d0,$4E(a5)
                andi.w  #$1FF,$4E(a5)
                move.w  $4E(a5),d0
                andi.w  #$1FE,d0
                lea     (Math_SineTable).l,a2
                move.w  Math_QuarterSineTable-Math_SineTable(a2,d0.w),d1
                move.w  (a2,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #4,d0
                asl.l   #4,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                rts
; End of function Physics_CalculateAngleAndVelocity
; Flips sprite and spawns projectile on timer
Boss_Epsilon1MinibossSpawnProjectile:                   ; DATA XREF: ROM:00046DB2   o  ; was: sub_46EA2
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bpl.w   locret_46F1C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_46F1C
                move.w  a0,(dword_FF9420).w
                move.w  #$10,(a0)
                move.w  #$C3C9,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  #$8080,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addq.w  #2,4(a5)
                tst.w   (word_FF9474).w
                bne.s   loc_46F02
                subq.w  #1,$4A(a5)
                beq.w   loc_46F02
                clr.w   $4C(a5)
                ori.w   #$8000,2(a5)
                bra.s   loc_46F08
; ---------------------------------------------------------------------------
loc_46F02:                                              ; CODE XREF: Boss_Epsilon1MinibossSpawnProjectile+4A   j
                                        ; Boss_Epsilon1MinibossSpawnProjectile+50   j
                andi.w  #$7FFF,2(a5)
loc_46F08:                                              ; CODE XREF: Boss_Epsilon1MinibossSpawnProjectile+5E   j
                tst.w   (word_FFFF0E).w
                bne.s   loc_46F16
                move.w  #$10,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_46F16:                                              ; CODE XREF: Boss_Epsilon1MinibossSpawnProjectile+6A   j
                move.w  #8,$48(a5)
locret_46F1C:                                           ; CODE XREF: Boss_Epsilon1MinibossSpawnProjectile+A   j
                                        ; Boss_Epsilon1MinibossSpawnProjectile+14   j
                rts
; End of function Boss_Epsilon1MinibossSpawnProjectile
; Tracks player angle while decrementing timer
Boss_Epsilon1MinibossSlowdown:                          ; DATA XREF: ROM:00046DB4   o  ; was: sub_46F1E
                bsr.w   Physics_CalculateAngleAndVelocity
                subq.w  #1,$48(a5)
                bpl.w   locret_46F36
                clr.l   $18(a5)
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
locret_46F36:                                           ; CODE XREF: Boss_Epsilon1MinibossSlowdown+8   j
                rts
; End of function Boss_Epsilon1MinibossSlowdown
nullsub_88:                                             ; DATA XREF: ROM:00046DB6   o
                rts
; End of function nullsub_88

; Loops attack or clears sprite and terminates
Boss_Epsilon1MinibossLoopOrEnd:                         ; DATA XREF: ROM:00046DB8   o  ; was: sub_46F3A
                tst.w   (word_FF9474).w
                bne.s   loc_46F56
                tst.w   $4A(a5)
                beq.w   loc_46F56
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #4,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_46F56:                                              ; CODE XREF: Boss_Epsilon1MinibossLoopOrEnd+4   j
                                        ; Boss_Epsilon1MinibossLoopOrEnd+A   j
                bclr    #7,2(a5)
                clr.w   4(a5)
                rts
; End of function Boss_Epsilon1MinibossLoopOrEnd
; Boss intro state dispatcher
Boss_Epsilon1IntroDispatcher:                           ; CODE XREF: Boss_Epsilon1IntroMain+34   j  ; was: sub_46F62
                move.w  4(a5),d0
                lea     off_46F6E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1IntroDispatcher
; ---------------------------------------------------------------------------
off_46F6E:      dc.w    nullsub_89-*                    ; DATA XREF: Boss_Epsilon1IntroDispatcher+4   o
                dc.w    Boss_Epsilon1ShuffleArray-*
                dc.w    Boss_Epsilon1Intro_ShuffleArray-*
                dc.w    Boss_Epsilon1SpawnProjectile-*
                dc.w    Boss_Epsilon1Intro_SpawnDelay-*
                dc.w    Boss_Epsilon1InitProjectileSprite-*
                dc.w    nullsub_90-*
                dc.w    Boss_Epsilon1ResetIntro-*

nullsub_89:                                             ; DATA XREF: ROM:off_46F6E   o
                rts
; End of function nullsub_89

; Shuffles array elements
Boss_Epsilon1ShuffleArray:                              ; DATA XREF: ROM:00046F70   o  ; was: sub_46F80
                move.w  #8,$4A(a5)
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
                move.w  #7,d7
                moveq   #0,d0
                lea     $50(a5),a0
loc_46F9A:                                              ; CODE XREF: Boss_Epsilon1ShuffleArray+1E   j
                move.b  d0,(a0)+
                addq.b  #1,d0
                dbf     d7,loc_46F9A
; Shuffles attack pattern array during intro
Boss_Epsilon1Intro_ShuffleArray:                        ; DATA XREF: ROM:00046F72   o  ; was: loc_46FA2
                lea     $50(a5),a0
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #7,d0
                andi.w  #7,d1
                cmp.w   d0,d1
                beq.s   locret_46FDE
                move.b  (a0,d0.w),d2
                move.b  (a0,d1.w),(a0,d0.w)
                move.b  d2,(a0,d1.w)
                subq.w  #1,$48(a5)
                bne.s   locret_46FDE
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                move.w  d0,$4E(a5)
                addq.w  #2,4(a5)
locret_46FDE:                                           ; CODE XREF: Boss_Epsilon1ShuffleArray+38   j
                                        ; Boss_Epsilon1ShuffleArray+4C   j
                rts
; End of function Boss_Epsilon1ShuffleArray
; Spawns projectile and calculates position
Boss_Epsilon1SpawnProjectile:                           ; DATA XREF: ROM:00046F74   o  ; was: sub_46FE0
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_472A8
                move.w  #$10,(a0)
                move.w  a0,$4C(a5)
                addq.w  #2,4(a5)
                tst.w   (word_FFFF0E).w
                bne.s   loc_47004
                move.w  #$28,$48(a5)                    ; '('
                bra.s   Boss_Epsilon1Intro_SpawnDelay
; ---------------------------------------------------------------------------
loc_47004:                                              ; CODE XREF: Boss_Epsilon1SpawnProjectile+1A   j
                move.w  #$20,$48(a5)                    ; ' '
; Delay timer before spawning projectile
Boss_Epsilon1Intro_SpawnDelay:                          ; CODE XREF: Boss_Epsilon1SpawnProjectile+22   j  ; was: loc_4700A
                                        ; DATA XREF: ROM:00046F76   o
                subq.w  #1,$48(a5)
                bne.s   locret_4704E
                ori.w   #$8000,2(a5)
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
                move.w  $4A(a5),d0
                subq.w  #1,d0
                lea     $50(a5),a0
                move.b  (a0,d0.w),d0
                andi.w  #$F,d0
                add.w   d0,d0
                move.w  word_47050(pc,d0.w),d0
                addi.w  #$120,d0
                sub.w   (dword_FFA900).w,d0
                add.w   $4E(a5),d0
                move.w  d0,$10(a5)
                move.w  (word_FF824A).w,$14(a5)
locret_4704E:                                           ; CODE XREF: Boss_Epsilon1SpawnProjectile+2E   j
                rts
; End of function Boss_Epsilon1SpawnProjectile
; ---------------------------------------------------------------------------
word_47050:     dc.w    $FF80, $FFA0, $FFC0, $FFE0, 0, $20, $40, $60, $C0, $E0, $100, $120
                                        ; DATA XREF: Boss_Epsilon1SpawnProjectile+54   r

; Initializes projectile sprite
Boss_Epsilon1InitProjectileSprite:                      ; DATA XREF: ROM:00046F78   o  ; was: sub_47068
                subq.w  #1,$48(a5)
                bne.s   locret_470B8
                andi.w  #$7FFF,2(a5)
                movea.w $4C(a5),a0
                move.w  #$2E8,(a0)
                move.w  #$C3C9,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  #$8080,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                tst.w   (word_FF9474).w
                bne.s   loc_470B4
                subq.w  #1,$4A(a5)
                beq.s   loc_470B4
                move.w  #6,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_470B4:                                              ; CODE XREF: Boss_Epsilon1InitProjectileSprite+3C   j
                                        ; Boss_Epsilon1InitProjectileSprite+42   j
                addq.w  #2,4(a5)
locret_470B8:                                           ; CODE XREF: Boss_Epsilon1InitProjectileSprite+4   j
                rts
; End of function Boss_Epsilon1InitProjectileSprite
nullsub_90:                                             ; DATA XREF: ROM:00046F7A   o
                rts
; End of function nullsub_90

; Resets boss intro state
Boss_Epsilon1ResetIntro:                                ; DATA XREF: ROM:00046F7C   o  ; was: sub_470BC
                clr.w   4(a5)
                rts
; End of function Boss_Epsilon1ResetIntro
; Spread shot initialization
