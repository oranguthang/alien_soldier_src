Boss_ShieldViperUpdateSpriteFlip:                       ; CODE XREF: Boss_ShieldViperInitSpinAttack+C   p  ; was: sub_4E5C0
                                        ; Boss_ShieldViperSpinAttackTimer+6   p
                moveq   #0,d0
                btst    #1,(word_FFA000+1).w
                bne.s   loc_4E5CE
                move.w  #$2000,d0
loc_4E5CE:                                              ; CODE XREF: Boss_ShieldViperUpdateSpriteFlip+8   j
                move.w  #$18,d7
                movea.w a5,a0
loc_4E5D4:                                              ; CODE XREF: Boss_ShieldViperUpdateSpriteFlip+3C   j
                andi.w  #$DFFF,$E(a0)
                or.w    d0,$E(a0)
                cmpi.w  #$370,(a0)
                bne.s   loc_4E5F8
                tst.w   $5C(a0)
                beq.s   loc_4E5F8
                movea.w $5C(a0),a1
                andi.w  #$DFFF,$E(a1)
                or.w    d0,$E(a1)
loc_4E5F8:                                              ; CODE XREF: Boss_ShieldViperUpdateSpriteFlip+22   j
                                        ; Boss_ShieldViperUpdateSpriteFlip+28   j
                lea     $60(a0),a0
                dbf     d7,loc_4E5D4
                rts
; End of function Boss_ShieldViperUpdateSpriteFlip
; Movement pattern 1
Boss_WolfGaropaMovement1:                               ; CODE XREF: Boss_ShieldViperSpinAttackUpdate+84   p  ; was: sub_4E602
                                        ; Boss_ShieldViperWaitTransition+A   p
                move.w  #$18,d7
                movea.w a5,a0
loc_4E608:                                              ; CODE XREF: Boss_WolfGaropaMovement1+32   j
                andi.w  #$DFFF,$E(a0)
                ori.w   #$2000,$E(a0)
                cmpi.w  #$370,(a0)
                bne.s   loc_4E630
                tst.w   $5C(a0)
                beq.s   loc_4E630
                movea.w $5C(a0),a1
                andi.w  #$DFFF,$E(a1)
                ori.w   #$2000,$E(a1)
loc_4E630:                                              ; CODE XREF: Boss_WolfGaropaMovement1+16   j
                                        ; Boss_WolfGaropaMovement1+1C   j
                lea     $60(a0),a0
                dbf     d7,loc_4E608
                rts
; End of function Boss_WolfGaropaMovement1
; Triggers state transition and advances pointer
Boss_ShieldViperTransitionState:                        ; DATA XREF: ROM:0004E014   o  ; was: sub_4E63A
                bsr.w   Boss_ShieldViperCalculateTrailPositions
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperTransitionState
; Advances state machine to next state
Boss_ShieldViperAdvanceState:                           ; DATA XREF: ROM:0004E016   o  ; was: sub_4E644
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperAdvanceState
; Spawns projectile type 1
Boss_ShieldViperSpawnProjectile1:                       ; DATA XREF: ROM:0004E018   o  ; was: sub_4E64A
                move.w  #2,$4C(a5)
                clr.w   $4E(a5)
                addq.w  #2,4(a5)
; Initialize attack timers before projectile spawn
Boss_ShieldViperSpawnProjectile1_InitTimers:            ; DATA XREF: ROM:0004E01A   o  ; was: loc_4E658
                move.w  #1,$48(a5)
                move.w  #8,$4A(a5)
                addq.w  #2,4(a5)
; Execute attack state and check for damage application
Boss_ShieldViperSpawnProjectile1_AttackLoop:            ; DATA XREF: ROM:0004E01C   o  ; was: loc_4E668
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4E68A
                subq.w  #1,$4A(a5)
                beq.s   loc_4E68C
                move.w  (word_FF8248).w,d0
                move.w  (word_FF824A).w,d1
                move.w  #$10,$48(a5)
                bsr.w   Boss_ShieldViperDamage
locret_4E68A:                                           ; CODE XREF: Boss_ShieldViperSpawnProjectile1+26   j
                rts
; ---------------------------------------------------------------------------
loc_4E68C:                                              ; CODE XREF: Boss_ShieldViperSpawnProjectile1+2C   j
                subq.w  #1,$4C(a5)
                beq.s   loc_4E69A
                move.w  #$34,4(a5)                      ; '4'
                rts
; ---------------------------------------------------------------------------
loc_4E69A:                                              ; CODE XREF: Boss_ShieldViperSpawnProjectile1+46   j
                addq.w  #1,(word_FF9440).w
                andi.w  #1,(word_FF9440).w
                beq.s   loc_4E6CE
                cmpi.w  #$88,$10(a5)
                bcs.s   loc_4E6CE
                cmpi.w  #$1B8,$10(a5)
                bhi.s   loc_4E6CE
                cmpi.w  #$A8,$14(a5)
                bcs.s   loc_4E6CE
                cmpi.w  #$158,$14(a5)
                bhi.s   loc_4E6CE
                move.w  #$4E,4(a5)                      ; 'N'
                rts
; ---------------------------------------------------------------------------
loc_4E6CE:                                              ; CODE XREF: Boss_ShieldViperSpawnProjectile1+5A   j
                                        ; Boss_ShieldViperSpawnProjectile1+62   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperSpawnProjectile1
; Initializes based on difficulty flags
Boss_ShieldViperDifficultySetup:                        ; DATA XREF: ROM:0004E01E   o  ; was: sub_4E6D4
                bsr.w   Boss_ShieldViperAttackState1
                addq.w  #2,4(a5)
                move.w  #$120,d0
                btst    #0,(dword_FFFF08).w
                bne.s   loc_4E6F8
                move.w  #$80,$4A(a5)
                move.w  #$80,d1
                bsr.w   Boss_ShieldViperDamage
                rts
; ---------------------------------------------------------------------------
loc_4E6F8:                                              ; CODE XREF: Boss_ShieldViperDifficultySetup+12   j
                move.w  #$180,$4A(a5)
                move.w  #$180,d1
                bsr.w   Boss_ShieldViperDamage
                rts
; End of function Boss_ShieldViperDifficultySetup
; Waits until rotation angle matches target
Boss_ShieldViperWaitAngleMatch:                         ; DATA XREF: ROM:0004E020   o  ; was: sub_4E708
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $56(a5),d0
                andi.w  #$1FC,d0
                cmp.w   $4A(a5),d0
                bne.s   locret_4E71E
                addq.w  #2,4(a5)
locret_4E71E:                                           ; CODE XREF: Boss_ShieldViperWaitAngleMatch+10   j
                rts
; End of function Boss_ShieldViperWaitAngleMatch
; Monitors vertical position for phase transition
Boss_ShieldViperCheckVerticalPosition:                  ; DATA XREF: ROM:0004E022   o  ; was: sub_4E720
                bsr.w   Boss_ShieldViperAttackState2
                cmpi.w  #$180,$4A(a5)
                beq.s   loc_4E73C
                cmpi.w  #$60,$14(a5)                    ; '`'
                bgt.s   locret_4E74A
                move.w  #$3E,4(a5)                      ; '>'
                rts
; ---------------------------------------------------------------------------
loc_4E73C:                                              ; CODE XREF: Boss_ShieldViperCheckVerticalPosition+A   j
                cmpi.w  #$180,$14(a5)
                blt.s   locret_4E74A
                move.w  #$32,4(a5)                      ; '2'
locret_4E74A:                                           ; CODE XREF: Boss_ShieldViperCheckVerticalPosition+12   j
                                        ; Boss_ShieldViperCheckVerticalPosition+22   j
                rts
; End of function Boss_ShieldViperCheckVerticalPosition
; Sets position and rotation based on difficulty
Boss_ShieldViperRepositionSetup:                        ; DATA XREF: ROM:0004E024   o  ; was: sub_4E74C
                addq.w  #2,4(a5)
                move.w  #$60,$14(a5)                    ; '`'
                move.w  #$180,$56(a5)
                addq.b  #1,(dword_FF9414+2).w
                btst    #1,(dword_FF9414+2).w
                beq.s   loc_4E776
                move.w  #$A0,$10(a5)
                move.w  #$FFFE,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_4E776:                                              ; CODE XREF: Boss_ShieldViperRepositionSetup+1A   j
                move.w  #$1A0,$10(a5)
                move.w  #2,$4A(a5)
                rts
; End of function Boss_ShieldViperRepositionSetup
; Waits until position reaches threshold
Boss_ShieldViperWaitVerticalThreshold:                  ; DATA XREF: ROM:0004E026   o  ; was: sub_4E784
                bsr.w   Boss_ShieldViperAttackState2
                cmpi.w  #$D0,$14(a5)
                blt.s   locret_4E7A0
                move.w  $4A(a5),(dword_FF9400).w
                move.w  #2,$48(a5)
                addq.w  #2,4(a5)
locret_4E7A0:                                           ; CODE XREF: Boss_ShieldViperWaitVerticalThreshold+A   j
                rts
; End of function Boss_ShieldViperWaitVerticalThreshold
; Increases rotation speed each cycle
Boss_ShieldViperAccelerateRotation:                     ; DATA XREF: ROM:0004E028   o  ; was: sub_4E7A2
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $56(a5),d0
                andi.w  #$FE,d0
                bne.s   locret_4E7C8
                move.w  (dword_FF9400).w,d0
                add.w   d0,(dword_FF9400).w
                subq.w  #1,$48(a5)
                bne.s   locret_4E7C8
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4E7C8:                                           ; CODE XREF: Boss_ShieldViperAccelerateRotation+C   j
                                        ; Boss_ShieldViperAccelerateRotation+1A   j
                rts
; End of function Boss_ShieldViperAccelerateRotation
; Wait timer then trigger sprite flip
Boss_ShieldViperDelayBeforeFlip:                        ; DATA XREF: ROM:0004E02A   o  ; was: sub_4E7CA
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4E7E2
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4E7E2:                                           ; CODE XREF: Boss_ShieldViperDelayBeforeFlip+8   j
                rts
; End of function Boss_ShieldViperDelayBeforeFlip
; Apply sprite flip and wait timer
Boss_ShieldViperFlipDelay:                              ; DATA XREF: ROM:0004E02C   o  ; was: sub_4E7E4
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bne.s   locret_4E7FC
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4E7FC:                                           ; CODE XREF: Boss_ShieldViperFlipDelay+C   j
                rts
; End of function Boss_ShieldViperFlipDelay
; Prepares for multi-projectile attack
Boss_ShieldViperPrepareMultiShot:                       ; DATA XREF: ROM:0004E02E   o  ; was: sub_4E7FE
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                bsr.w   Boss_ShieldViperSpawnProjectileWithAngle
                subq.w  #1,$48(a5)
                bne.s   locret_4E818
                bsr.w   Debug_DisableProjectilesAndMove
                addq.w  #2,4(a5)
locret_4E818:                                           ; CODE XREF: Boss_ShieldViperPrepareMultiShot+10   j
                rts
; End of function Boss_ShieldViperPrepareMultiShot
; Waits for rotation to reach 180 degrees
Boss_ShieldViperWaitRotation180:                        ; DATA XREF: ROM:0004E030   o  ; was: sub_4E81A
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $56(a5),d0
                andi.w  #$1FC,d0
                cmpi.w  #$180,d0
                bne.s   locret_4E830
                addq.w  #2,4(a5)
locret_4E830:                                           ; CODE XREF: Boss_ShieldViperWaitRotation180+10   j
                rts
; End of function Boss_ShieldViperWaitRotation180
; Monitors vertical position during ascent
Boss_ShieldViperAscendCheck:                            ; DATA XREF: ROM:0004E032   o  ; was: sub_4E832
                bsr.w   Boss_ShieldViperAttackState2
                cmpi.w  #$180,$14(a5)
                blt.s   locret_4E844
                move.w  #$32,4(a5)                      ; '2'
locret_4E844:                                           ; CODE XREF: Boss_ShieldViperAscendCheck+A   j
                rts
; End of function Boss_ShieldViperAscendCheck
; Initializes rotation speed doubling
Boss_ShieldViperDelayRotateUpdate:                      ; DATA XREF: ROM:0004E034   o  ; was: sub_4E846
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                move.w  (dword_FF9400).w,d0
                add.w   d0,(dword_FF9400).w
; Wait for delay timer before advancing rotation
Boss_ShieldViperDelayRotateUpdate_WaitLoop:             ; DATA XREF: ROM:0004E036   o  ; was: loc_4E858
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4E86C
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4E86C:                                           ; CODE XREF: Boss_ShieldViperDelayRotateUpdate+1A   j
                rts
; End of function Boss_ShieldViperDelayRotateUpdate
; Update sprite flip and wait countdown
Boss_ShieldViperFlipWaitDelay:                          ; DATA XREF: ROM:0004E038   o  ; was: sub_4E86E
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4E880
                addq.w  #2,4(a5)
locret_4E880:                                           ; CODE XREF: Boss_ShieldViperFlipWaitDelay+C   j
                rts
; End of function Boss_ShieldViperFlipWaitDelay
; Spawns linked projectiles with sequential delay
Boss_ShieldViperSpawnLinkedProjectiles:                 ; DATA XREF: ROM:0004E03A   o  ; was: sub_4E882
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                lea     $60(a5),a1
                move.w  #2,d6
                move.w  #$17,d7
loc_4E892:                                              ; CODE XREF: Boss_ShieldViperSpawnLinkedProjectiles+2E   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_4E8B4
                move.w  #$10,(a0)
                move.w  a0,$5C(a1)
                move.w  d6,$48(a1)
                addq.w  #2,4(a1)
                addq.w  #2,d6
                lea     $60(a1),a1
                dbf     d7,loc_4E892
loc_4E8B4:                                              ; CODE XREF: Boss_ShieldViperSpawnLinkedProjectiles+16   j
                move.w  d6,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperSpawnLinkedProjectiles
; Waits for timer then transitions pattern
Boss_ShieldViperWaitTransition:                         ; DATA XREF: ROM:0004E03C   o  ; was: sub_4E8BE
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bne.s   locret_4E8D0
                bsr.w   Boss_WolfGaropaMovement1
                addq.w  #2,4(a5)
locret_4E8D0:                                           ; CODE XREF: Boss_ShieldViperWaitTransition+8   j
                rts
; End of function Boss_ShieldViperWaitTransition
; Spawns randomized projectile array
Boss_ShieldViperSpawnScatteredProjectiles:              ; DATA XREF: ROM:0004E03E   o  ; was: sub_4E8D2
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperGenerateProjectilePattern
                lea     (dword_FF9420).w,a1
                lea     word_4E944(pc),a2
                nop
                move.w  #$B,d7
                move.w  #$20,d6                         ; ' '
                moveq   #0,d5
loc_4E8EE:                                              ; CODE XREF: Boss_ShieldViperSpawnScatteredProjectiles+64   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_4E93A
                move.w  #$378,(a0)
                move.w  #$4C80,2(a0)
                move.w  $6E(a5),$E(a0)
                move.l  $68(a5),8(a0)
                move.w  (a1)+,d0
                move.w  d0,d1
                lsl.w   #3,d1
                lsl.w   #2,d0
                add.w   d0,d1
                move.w  (a2,d1.w),$10(a0)
                move.w  2(a2,d1.w),$14(a0)
                move.w  4(a2,d1.w),$4C(a0)
                move.w  8(a2,d1.w),$50(a0)
                move.w  d6,$4A(a0)
                addi.w  #$20,d6                         ; ' '
                dbf     d7,loc_4E8EE
loc_4E93A:                                              ; CODE XREF: Boss_ShieldViperSpawnScatteredProjectiles+22   j
                move.w  d6,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperSpawnScatteredProjectiles
; ---------------------------------------------------------------------------
word_4E944:     binclude "data/other/word_4E944.bin"
word_4E944_End:

; Generates randomized spawn pattern indices
Boss_ShieldViperGenerateProjectilePattern:              ; CODE XREF: Boss_ShieldViperSpawnScatteredProjectiles+4   p  ; was: sub_4EAC4
                lea     (dword_FF9420).w,a0
                move.w  #9,d7
                moveq   #0,d6
loc_4EACE:                                              ; CODE XREF: Boss_ShieldViperGenerateProjectilePattern+22   j
                jsr     (RandomNumber).l
                move.w  d6,d0
                btst    #0,(dword_FFFF08).w
                beq.s   loc_4EAE2
                addi.w  #$A,d0
loc_4EAE2:                                              ; CODE XREF: Boss_ShieldViperGenerateProjectilePattern+18   j
                move.w  d0,(a0)+
                addq.w  #1,d6
                dbf     d7,loc_4EACE
                move.w  #5,d7
                move.w  #$14,d6
loc_4EAF2:                                              ; CODE XREF: Boss_ShieldViperGenerateProjectilePattern+46   j
                jsr     (RandomNumber).l
                move.w  d6,d0
                btst    #0,(dword_FFFF08).w
                beq.s   loc_4EB06
                addi.w  #6,d0
loc_4EB06:                                              ; CODE XREF: Boss_ShieldViperGenerateProjectilePattern+3C   j
                move.w  d0,(a0)+
                addq.w  #1,d6
                dbf     d7,loc_4EAF2
                lea     (dword_FF9420).w,a0
                move.w  #7,d7
                moveq   #0,d6
loc_4EB18:                                              ; CODE XREF: Boss_ShieldViperGenerateProjectilePattern+74   j
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d1
                andi.w  #$F,d1
                add.w   d1,d1
                move.w  (a0,d6.w),d2
                move.w  (a0,d1.w),(a0,d6.w)
                move.w  d2,(a0,d1.w)
                addq.w  #2,d6
                dbf     d7,loc_4EB18
                rts
; End of function Boss_ShieldViperGenerateProjectilePattern
; Waits for countdown timer to expire
Boss_ShieldViperWaitTimer:                              ; DATA XREF: ROM:0004E040   o  ; was: sub_4EB3E
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4EB4C
                addq.w  #2,4(a5)
locret_4EB4C:                                           ; CODE XREF: Boss_ShieldViperWaitTimer+8   j
                rts
; End of function Boss_ShieldViperWaitTimer
; Immediately advances to next state
Boss_ShieldViperQuickTransition:                        ; DATA XREF: ROM:0004E042   o  ; was: sub_4EB4E
                bsr.w   Boss_ShieldViperAttackState1
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperQuickTransition
; Rotates then doubles rotation speed
Boss_ShieldViperRotateAndAccelerate:                    ; DATA XREF: ROM:0004E044   o  ; was: sub_4EB58
                bsr.w   Boss_ShieldViperDamageCenterPoint
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $56(a5),d0
                andi.w  #$1FC,d0
                cmpi.w  #$80,d0
                bne.s   locret_4EB7A
                move.w  (dword_FF9400).w,d0
                add.w   d0,(dword_FF9400).w
                addq.w  #2,4(a5)
locret_4EB7A:                                           ; CODE XREF: Boss_ShieldViperRotateAndAccelerate+14   j
                rts
; End of function Boss_ShieldViperRotateAndAccelerate
; Advances state twice in sequence
Boss_ShieldViperDoubleStateAdvance:                     ; DATA XREF: ROM:0004E046   o  ; was: sub_4EB7C
                bsr.w   Boss_ShieldViperAttackState1
                addq.w  #2,4(a5)
; Execute second state advance in double advance
Boss_ShieldViperDoubleStateAdvance_Second:              ; DATA XREF: ROM:0004E048   o  ; was: loc_4EB84
                bsr.w   Boss_ShieldViperAttackState1
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperDoubleStateAdvance
; Advances state once for next phase
Boss_ShieldViperSingleStateAdvance:                     ; DATA XREF: ROM:0004E04A   o  ; was: sub_4EB8E
                bsr.w   Boss_ShieldViperAttackState1
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperSingleStateAdvance
; Initializes child entity spawn with timer
Boss_ShieldViperInitChildEntityTimer:                   ; DATA XREF: ROM:0004E04C   o  ; was: sub_4EB98
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperInitChildEntityTimer
; Spawns array of 24 child entities
Boss_ShieldViperSpawnChildEntityArray:                  ; DATA XREF: ROM:0004E04E   o  ; was: sub_4EBAC
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bne.s   locret_4EBD2
                lea     $60(a5),a0
                move.w  a0,$4A(a5)
                move.w  #$18,$4C(a5)
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
locret_4EBD2:                                           ; CODE XREF: Boss_ShieldViperSpawnChildEntityArray+C   j
                rts
; End of function Boss_ShieldViperSpawnChildEntityArray
; Spawns child entities in sequence
Boss_ShieldViperSpawnChildSequentially:                 ; DATA XREF: ROM:0004E050   o  ; was: sub_4EBD4
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bpl.s   locret_4EC1A
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4EC1A
                move.w  #$10,(a0)
                movea.w $4A(a5),a1
                move.w  a0,$5C(a1)
                addq.w  #2,4(a1)
                subq.w  #1,$4C(a5)
                beq.s   loc_4EC10
                lea     $60(a1),a1
                move.w  a1,$4A(a5)
                move.w  #8,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_4EC10:                                              ; CODE XREF: Boss_ShieldViperSpawnChildSequentially+2A   j
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4EC1A:                                           ; CODE XREF: Boss_ShieldViperSpawnChildSequentially+C   j
                                        ; Boss_ShieldViperSpawnChildSequentially+14   j
                rts
; End of function Boss_ShieldViperSpawnChildSequentially
; Initializes child circular movement
Boss_ShieldViperChildMovementInit:                      ; DATA XREF: ROM:0004E052   o  ; was: sub_4EC1C
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bne.s   locret_4EC40
                bsr.w   Boss_WolfGaropaMovement1
                move.w  (dword_FF9400).w,d0
                add.w   d0,(dword_FF9400).w
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4EC40:                                           ; CODE XREF: Boss_ShieldViperChildMovementInit+C   j
                rts
; End of function Boss_ShieldViperChildMovementInit
; Halves speed and resets state
Boss_ShieldViperHalveSpeedAndReset:                     ; DATA XREF: ROM:0004E054   o  ; was: sub_4EC42
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4EC5C
                move.w  (dword_FF9400).w,d0
                asr.w   #1,d0
                move.w  d0,(dword_FF9400).w
                move.w  #$32,4(a5)                      ; '2'
locret_4EC5C:                                           ; CODE XREF: Boss_ShieldViperHalveSpeedAndReset+8   j
                rts
; End of function Boss_ShieldViperHalveSpeedAndReset
; Defeat sequence init
