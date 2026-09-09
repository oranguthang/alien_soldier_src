; Initializes the shared boss table pointer and dispatches the setup state
Boss_SunsetStingInitDispatcher:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_40CEE
                moveq   #4,d7
                jsr     (Gfx_InitPaletteFade).l
                move.w  4(a5),d0
                lea     off_40D02(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingInitDispatcher
; ---------------------------------------------------------------------------
off_40D02:      dc.w    Boss_SunsetStingSetupArena-*    ; DATA XREF: Boss_SunsetStingInitDispatcher+C   o
                dc.w    Boss_SunsetStingLoadGraphics-*
                dc.w    Boss_SunsetStingCheckVictory-*
                dc.w    Boss_SunsetStingIntroMovement-*
                dc.w    Boss_SunsetStingIdleState-*
                dc.w    Boss_SunsetStingIncrementCounter-*
                dc.w    Boss_SunsetStingDashAttack-*
                dc.w    Boss_SunsetStingDashAttack_MoveToward-*
                dc.w    Boss_SunsetStingDashAttack_MoveAway-*
                dc.w    Boss_SunsetStingDashAttack_MoveToward-*
                dc.w    Boss_SunsetStingDashAttack_MoveAway-*
                dc.w    Boss_SunsetStingResetForAttack-*
                dc.w    Boss_SunsetStingPrepareDive-*
                dc.w    Boss_SunsetStingTimerWait-*
                dc.w    Boss_SunsetStingSerpentineAttack-*
                dc.w    Boss_SunsetStingSerpentineAttack_MoveIn-*
                dc.w    Boss_SunsetStingSerpentineAttack_MoveOut-*
                dc.w    Boss_SunsetStingRotationDecelerate-*
                dc.w    Boss_SunsetStingWobbleRotation-*
                dc.w    Boss_SunsetStingSpawnDebrisField-*
                dc.w    Boss_SunsetStingSpawnDebrisField_RiseLoop-*
                dc.w    Boss_SunsetStingFadeOutAndDestroy-*
unused_8:       binclude "data/other/unused_8.bin"

; Sets up battle arena parameters and clears sprite slots
Boss_SunsetStingSetupArena:                             ; DATA XREF: ROM:off_40D02   o  ; was: sub_40D34
                move.b  #6,(byte_FF80EC).w
                move.w  #$1C0,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                addq.w  #2,4(a5)
                move.b  #$80,$4B(a5)
                clr.w   (word_FFC67E).w
                rts
; End of function Boss_SunsetStingSetupArena
; Loads boss sprites, palette, tiles and initializes position/velocity
Boss_SunsetStingLoadGraphics:                           ; DATA XREF: ROM:00040D04   o  ; was: sub_40D56
                tst.w   (word_FFF720).w
                bmi.w   locret_40DC2
                addq.w  #2,4(a5)
                movea.l #Boss_SunsetStingObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                moveq   #6,d7
                jsr     (Data_LoadPaletteTable).l
                move.w  (a5),-(sp)
                move.w  #$4300,$E(a5)
                lea     word_41568(pc),a1
                lea     (a5),a4
                jsr     Boss_SunsetStingInitBodyParts(pc)  ; (pc)
                nop
                move.w  (sp)+,(a5)
                ori.w   #$D00,2(a5)
                move.l  #$2000000,$10(a5)
                move.l  #$1000000,$14(a5)
                move.l  #$FFFF0000,$18(a5)
                move.b  #0,$4A(a5)
                ori.w   #$800,$E(a5)
                movea.l #word_40DD6,a0
                jsr     (Gfx_LoadCompressedTiles).l
locret_40DC2:                                           ; CODE XREF: Boss_SunsetStingLoadGraphics+4   j
                rts
; End of function Boss_SunsetStingLoadGraphics
; ---------------------------------------------------------------------------
word_40DC4:     dc.w    $E, $20, $1E, $26, $1A, $22, $16, $14, $12
                                        ; DATA XREF: Boss_SunsetStingUpdateGraphics+2A   o
word_40DD6:     dc.w    $6100, $2000, $202, $494A, $4B4D, $4E4F, $5152, $FF, $6300, $2000, $101, $4D4E, $5152, $6300, $2000, $101
                                        ; DATA XREF: Boss_SunsetStingLoadGraphics+60   o
                dc.w    $5455, $5658, $E, $10, $16, $1C, $12, 8, 6, 4, 2, $6100, $2000, $100, $494A, $6100
                dc.w    $2000, $100, $4C53, $6100, $2000, $100, $5057

; Checks victory condition and advances to next state
Boss_SunsetStingCheckVictory:                           ; DATA XREF: ROM:00040D06   o  ; was: sub_40E24
                moveq   #5,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                bra.w   loc_40E48
; End of function Boss_SunsetStingCheckVictory
; Handles boss intro flight pattern until timer expires
Boss_SunsetStingIntroMovement:                          ; DATA XREF: ROM:00040D08   o  ; was: sub_40E34
                tst.w   (word_FF80C2).w
                bne.s   loc_40E48
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
                addq.w  #2,4(a5)
loc_40E48:                                              ; CODE XREF: Boss_SunsetStingCheckVictory+C   j
                                        ; Boss_SunsetStingIntroMovement+4   j
                subq.b  #1,$4B(a5)
                bsr.w   Boss_SunsetStingCalculateVerticalVelocity
                cmpi.l  #$1600000,$10(a5)
                bhi.s   loc_40E5E
                clr.l   $18(a5)
loc_40E5E:                                              ; CODE XREF: Boss_SunsetStingIntroMovement+24   j
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingIntroMovement
; Resets attack state and adjusts based on boss health
Boss_SunsetStingResetForAttack:                         ; CODE XREF: Boss_SunsetStingDashAttack+72   j  ; was: sub_40E62
                                        ; Boss_SunsetStingDashAttack+82   j
                move.w  #8,4(a5)
                move.b  #$40,$4B(a5)                    ; '@'
                clr.l   $18(a5)
                cmpi.w  #$100,(word_FF8234).w
                bgt.s   loc_40E86
                move.b  #$C0,$4B(a5)
                move.w  #$A,4(a5)
loc_40E86:                                              ; CODE XREF: Boss_SunsetStingResetForAttack+16   j
                bsr.w   Boss_SunsetStingDisableCollision
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingResetForAttack
; Increments global counter and calls angle calculation routine
Boss_SunsetStingIncrementCounter:                       ; DATA XREF: ROM:00040D0C   o  ; was: sub_40E8E
                addi.w  #2,(word_FF8234).w
                clr.w   d3
                bsr.w   Boss_SunsetStingCalculateAngleAndFlip
; End of function Boss_SunsetStingIncrementCounter
; Handles idle behavior with animation and distance-based attack selection
Boss_SunsetStingIdleState:                              ; DATA XREF: ROM:00040D0A   o  ; was: sub_40E9A
                subq.b  #1,$4B(a5)
                beq.w   loc_40ECA
                bsr.w   Boss_SunsetStingCalculateVerticalVelocity
                move.b  #0,6(a5)
                bsr.w   Boss_SunsetStingInterpolateRotation
                move.b  #0,$4A(a5)
                btst    #4,$4B(a5)
                beq.w   Boss_SunsetStingUpdateGraphics
                move.b  #4,$4A(a5)
                bra.w   Boss_SunsetStingUpdateGraphics
; ---------------------------------------------------------------------------
loc_40ECA:                                              ; CODE XREF: Boss_SunsetStingIdleState+4   j
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$80,d0
                bcs.s   Boss_SunsetStingCloseRangeAttack
                lea     word_40EE0(pc),a0
                jmp     JumpRandomFunc
; End of function Boss_SunsetStingIdleState
; ---------------------------------------------------------------------------
word_40EE0:     dc.w    $7800                           ; DATA XREF: Boss_SunsetStingIdleState+3C   o
                dc.w    Boss_SunsetStingAttackSetup3-*
                dc.w    $7000
                dc.w    Boss_SunsetStingAttackSetup1-*
                dc.w    $1000
                dc.w    Boss_SunsetStingIdleSetup-*
                dc.w    $800
                dc.w    Boss_SunsetStingAttackRecover-*

; Selects random attack pattern when player is close
Boss_SunsetStingCloseRangeAttack:                       ; CODE XREF: Boss_SunsetStingIdleState+3A   j  ; was: sub_40EF0
                lea     word_40EFA(pc),a0
                jmp     JumpRandomFunc
; End of function Boss_SunsetStingCloseRangeAttack
; ---------------------------------------------------------------------------
word_40EFA:     dc.w    $A000                           ; DATA XREF: Boss_SunsetStingCloseRangeAttack   o
                dc.w    Boss_SunsetStingAttackRecover-*
                dc.w    $8000
                dc.w    Boss_SunsetStingAttackSetup2-*

; Calculates horizontal screen offset based on boss position and velocity direction
Boss_SunsetStingCalculateScreenOffset:                  ; CODE XREF: Boss_SunsetStingDashAttack+6E   p  ; was: sub_40F02
                                        ; Boss_SunsetStingDashAttack+7E   p
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                tst.w   $18(a5)
                bpl.s   loc_40F16
                subi.w  #$400,d0
                rts
; ---------------------------------------------------------------------------
loc_40F16:                                              ; CODE XREF: Boss_SunsetStingCalculateScreenOffset+C   j
                move.w  #$600,d1
                sub.w   d0,d1
                rts
; End of function Boss_SunsetStingCalculateScreenOffset
; Disables collision flag for all 5 boss body segments
Boss_SunsetStingDisableCollision:                       ; CODE XREF: Boss_SunsetStingResetForAttack:loc_40E86   p  ; was: sub_40F1E
                andi.b  #$BF,$201(a5)
                andi.b  #$BF,$3E1(a5)
                andi.b  #$BF,$5C1(a5)
                andi.b  #$BF,$7A1(a5)
                andi.b  #$BF,$921(a5)
                rts
; End of function Boss_SunsetStingDisableCollision
; Enables collision flag for all 5 boss body segments
Boss_SunsetStingEnableCollision:                        ; CODE XREF: Boss_SunsetStingAttackSetup1+12   p  ; was: sub_40F3E
                                        ; Boss_SunsetStingAttackSetup2+12   p
                ori.b   #$40,$201(a5)                   ; '@'
                ori.b   #$40,$3E1(a5)                   ; '@'
                ori.b   #$40,$5C1(a5)                   ; '@'
                ori.b   #$40,$7A1(a5)                   ; '@'
                ori.b   #$40,$921(a5)                   ; '@'
                rts
; End of function Boss_SunsetStingEnableCollision
; Sets up boss attack state with counter values and enables collision
Boss_SunsetStingAttackSetup1:                           ; DATA XREF: ROM:00040EE6   o  ; was: sub_40F5E
                move.w  #$C,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                move.b  #4,$4A(a5)
                bsr.s   Boss_SunsetStingEnableCollision
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingAttackSetup1
; Executes dashing movement pattern with trajectory calculations
Boss_SunsetStingDashAttack:                             ; DATA XREF: ROM:00040D0E   o  ; was: sub_40F76
                move.w  #0,d3
                bsr.w   Boss_SunsetStingCalculateAngleAndFlip
                bsr.w   Boss_SunsetStingInterpolateRotation
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingUpdateGraphics
                move.b  #0,$4A(a5)
                addq.w  #2,4(a5)
                move.b  #$C,$4B(a5)
                clr.w   d0
                btst    #3,$E(a5)
                bne.s   loc_40FA8
                move.w  #$100,d0
loc_40FA8:                                              ; CODE XREF: Boss_SunsetStingDashAttack+2C   j
                move.w  d0,6(a5)
; Move toward target using calculated trajectory
Boss_SunsetStingDashAttack_MoveToward:                  ; DATA XREF: ROM:00040D10   o  ; was: loc_40FAC
                                        ; ROM:00040D14   o
                move.w  #2,d2
                bsr.w   Boss_SunsetStingCalculateTrajectory
                add.l   d1,$18(a5)
                add.l   d0,$1C(a5)
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingUpdateGraphics
                move.b  #$C,$4B(a5)
                addq.w  #2,4(a5)
                move.b  #4,$4A(a5)
; Move away from target with screen boundary check
Boss_SunsetStingDashAttack_MoveAway:                    ; DATA XREF: ROM:00040D12   o  ; was: loc_40FD4
                                        ; ROM:00040D16   o
                move.w  #2,d2
                bsr.w   Boss_SunsetStingCalculateTrajectory
                sub.l   d1,$18(a5)
                sub.l   d0,$1C(a5)
                bsr.w   Boss_SunsetStingCalculateScreenOffset
                bcs.w   Boss_SunsetStingResetForAttack
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingUpdateGraphics
                bsr.w   Boss_SunsetStingCalculateScreenOffset
                bcs.w   Boss_SunsetStingResetForAttack
                move.b  #$C,$4B(a5)
                addq.w  #2,4(a5)
                move.b  #0,$4A(a5)
                subi.w  #$40,(word_FF8234).w            ; '@'
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingDashAttack
; Initializes boss attack state with timer and collision detection
Boss_SunsetStingAttackSetup2:                           ; DATA XREF: ROM:00040F00   o  ; was: sub_41016
                move.w  #$18,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                move.b  #4,$4A(a5)
                bsr.w   Boss_SunsetStingEnableCollision
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingAttackSetup2
; Prepares boss dive attack by setting timer and adjusting screen offset
Boss_SunsetStingPrepareDive:                            ; DATA XREF: ROM:00040D1A   o  ; was: sub_41030
                move.w  #$20,d3                         ; ' '
                bsr.w   Boss_SunsetStingCalculateAngleAndFlip
                bsr.w   Boss_SunsetStingInterpolateRotation
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingUpdateGraphics
                move.b  #6,$4A(a5)
                addq.w  #2,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                subi.w  #$50,(word_FF8234).w            ; 'P'
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingPrepareDive
; Waits for timer countdown before resetting attack state
Boss_SunsetStingTimerWait:                              ; DATA XREF: ROM:00040D1C   o  ; was: sub_4105E
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingUpdateGraphics
                bra.w   Boss_SunsetStingResetForAttack
; End of function Boss_SunsetStingTimerWait
; Sets up boss attack with vertical velocity cleared
Boss_SunsetStingAttackSetup3:                           ; DATA XREF: ROM:00040EE2   o  ; was: sub_4106A
                move.w  #$1C,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                move.b  #8,$4A(a5)
                clr.l   $1C(a5)
                bsr.w   Boss_SunsetStingEnableCollision
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingAttackSetup3
; Performs serpentine movement pattern with trajectory reversals
Boss_SunsetStingSerpentineAttack:                       ; DATA XREF: ROM:00040D1E   o  ; was: sub_41088
                move.w  #2,d2
                bsr.w   Boss_SunsetStingCalculateTrajectory
                neg.l   d1
                neg.l   d0
                move.l  d1,$18(a5)
                move.l  #$C00000,d0
                sub.l   $14(a5),d0
                asr.l   #2,d0
                move.l  d0,$1C(a5)
                move.w  #$40,d3                         ; '@'
                bsr.w   Boss_SunsetStingCalculateAngleAndFlip
                bsr.w   Boss_SunsetStingInterpolateRotation
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingUpdateGraphics
                addq.w  #2,4(a5)
                move.b  #$10,$4B(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
; Serpentine pattern movement toward target
Boss_SunsetStingSerpentineAttack_MoveIn:                ; DATA XREF: ROM:00040D20   o  ; was: loc_410CE
                move.w  #2,d2
                bsr.w   Boss_SunsetStingCalculateTrajectory
                add.l   d1,$18(a5)
                add.l   d0,$1C(a5)
                subq.b  #1,$4B(a5)
                bne.w   loc_41112
                addq.w  #2,4(a5)
                move.b  #$10,$4B(a5)
                subi.w  #$140,(word_FF8234).w
; Serpentine pattern movement away from target
Boss_SunsetStingSerpentineAttack_MoveOut:               ; DATA XREF: ROM:00040D22   o  ; was: loc_410F6
                move.w  #2,d2
                bsr.w   Boss_SunsetStingCalculateTrajectory
                sub.l   d1,$18(a5)
                sub.l   d0,$1C(a5)
                subq.b  #1,$4B(a5)
                bne.w   loc_41112
                bra.w   Boss_SunsetStingResetForAttack
; ---------------------------------------------------------------------------
loc_41112:                                              ; CODE XREF: Boss_SunsetStingSerpentineAttack+5A   j
                                        ; Boss_SunsetStingSerpentineAttack+82   j
                bsr.w   Boss_SunsetStingCalculateScreenOffset
                bcs.w   Boss_SunsetStingResetForAttack
                cmpi.w  #$110,$14(a5)
                bcs.w   Boss_SunsetStingUpdateGraphics
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                neg.l   $1C(a5)
                bra.w   *+4
; End of function Boss_SunsetStingSerpentineAttack
; Recovers from attack by setting state timer and enabling collision
Boss_SunsetStingAttackRecover:                          ; CODE XREF: Boss_SunsetStingSerpentineAttack+AC   j  ; was: sub_41138
                                        ; Boss_SunsetStingWobbleRotation+1C   j
                                        ; DATA XREF:
                move.w  #$22,4(a5)                      ; '"'
                move.b  #$38,$4B(a5)                    ; '8'
                move.b  #$A,$4A(a5)
                subi.w  #$148,(word_FF8234).w
                bsr.w   Boss_SunsetStingEnableCollision
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingAttackRecover
; Decelerates rotation angle and resets attack when timer expires
Boss_SunsetStingRotationDecelerate:                     ; DATA XREF: ROM:00040D24   o  ; was: sub_41158
                addi.w  #$C,$56(a5)
                subq.b  #1,$4B(a5)
                beq.w   Boss_SunsetStingResetForAttack
                move.l  $18(a5),d0
                asr.l   #4,d0
                sub.l   d0,$18(a5)
                bsr.w   Boss_SunsetStingCalculateVerticalVelocity
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingRotationDecelerate
; Initializes idle state with long timer and cleared velocity
Boss_SunsetStingIdleSetup:                              ; DATA XREF: ROM:00040EEA   o  ; was: sub_41178
                move.w  #$24,4(a5)                      ; '$'
                move.b  #$60,$4B(a5)                    ; '`'
                move.b  #6,$4A(a5)
                clr.l   $1C(a5)
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingIdleSetup
; Applies wobbling rotation effect using sine wave pattern
Boss_SunsetStingWobbleRotation:                         ; DATA XREF: ROM:00040D26   o  ; was: sub_41192
                move.b  $4B(a5),d4
                lsr.w   #2,d4
                andi.w  #7,d4
                move.b  word_411B0(pc,d4.w),d4
                ext.w   d4
                add.w   d4,$56(a5)
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingUpdateGraphics
                bra.s   Boss_SunsetStingAttackRecover
; End of function Boss_SunsetStingWobbleRotation
; ---------------------------------------------------------------------------
word_411B0:     dc.w    $FFFD, $FCFF, $103, $401, $49ED, $60, $363C, 4
                                        ; DATA XREF: Boss_SunsetStingWobbleRotation+A   r

; Spawns multiple projectile debris with randomized trajectories
Boss_SunsetStingSpawnDebris:                            ; CODE XREF: Boss_SunsetStingSpawnDebris+5E   j  ; was: sub_411C0
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_41222
                move.w  #$1C4,(a0)
                ori.w   #$CD00,2(a0)
                jsr     (RandomNumber).l
                rol.l   #8,d0
                move.w  d0,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  #4,d1
                muls.w  #4,d0
                move.l  d1,$18(a0)
                move.l  d0,$1C(a0)
                jsr     (RandomNumber).l
                rol.l   #8,d0
                ext.w   d0
                asr.w   #3,d0
                move.w  d0,$5C(a0)
                clr.b   $21(a0)
                move.l  $10(a4),$10(a0)
                move.l  $14(a4),$14(a0)
                lea     $60(a4),a4
                dbf     d3,Boss_SunsetStingSpawnDebris
loc_41222:                                              ; CODE XREF: Boss_SunsetStingSpawnDebris+6   j
                bra.w   Boss_SunsetStingResetForAttack
; End of function Boss_SunsetStingSpawnDebris
; Calculates movement trajectory using sine/cosine lookup table
Boss_SunsetStingCalculateTrajectory:                    ; CODE XREF: Boss_SunsetStingDashAttack+3A   p  ; was: sub_41226
                                        ; Boss_SunsetStingDashAttack+62   p
                move.w  $56(a5),d1
                asr.w   #1,d1
                sub.w   $5A(a5),d1
                add.w   d1,d1
                andi.w  #$1FE,d1
                lea     (Math_SineTable).l,a2
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                btst    #3,$E(a5)
                beq.s   loc_41250
                neg.w   d1
loc_41250:                                              ; CODE XREF: Boss_SunsetStingCalculateTrajectory+26   j
                ext.l   d0
                ext.l   d1
                asl.l   d2,d0
                asl.l   d2,d1
                rts
; End of function Boss_SunsetStingCalculateTrajectory
; Checks distance to player and sets horizontal flip bit
Boss_SunsetStingCheckFlipDirection:
                andi.w  #$F7FF,$E(a5)                   ; was: sub_4125A
                jsr     (Physics_GetPlayerDelta).l
                tst.w   d1
                bpl.s   locret_41270
                ori.w   #$800,$E(a5)
locret_41270:                                           ; CODE XREF: Boss_SunsetStingCheckFlipDirection+E   j
                rts
; End of function Boss_SunsetStingCheckFlipDirection
; Calculates angle to player with flip flag
Boss_SunsetStingCalculateAngleAndFlip:                  ; CODE XREF: Boss_SunsetStingIncrementCounter+8   p  ; was: sub_41272
                                        ; Boss_SunsetStingDashAttack+4   p
                andi.w  #$F7FF,$E(a5)
                movem.l d3,-(sp)
                lea     (word_FFA400).w,a4
                jsr     (loc_427EC).l
                movem.l (sp)+,d3
                move.b  d0,d2
                bpl.s   loc_41296
                ori.w   #$800,$E(a5)
                neg.b   d2
loc_41296:                                              ; CODE XREF: Boss_SunsetStingCalculateAngleAndFlip+1A   j
                move.w  d3,$5A(a5)
; End of function Boss_SunsetStingCalculateAngleAndFlip
; Applies angle offset to boss orientation register
Boss_SunsetStingApplyAngleOffset:
                add.w   $5A(a5),d2                      ; was: sub_4129A
                move.w  d2,6(a5)
                rts
; End of function Boss_SunsetStingApplyAngleOffset
; Interpolates rotation angle towards target smoothly
Boss_SunsetStingInterpolateRotation:                    ; CODE XREF: Boss_SunsetStingIdleState+12   p  ; was: sub_412A4
                                        ; Boss_SunsetStingDashAttack+8   p
                move.w  $56(a5),d1
                lsr.w   #1,d1
                move.w  6(a5),d0
                sub.b   d1,d0
                asr.b   #2,d0
                ext.w   d0
                add.w   d0,$56(a5)
                rts
; End of function Boss_SunsetStingInterpolateRotation
; Calculates vertical velocity using sine wave for hovering
Boss_SunsetStingCalculateVerticalVelocity:              ; CODE XREF: Boss_SunsetStingIntroMovement+18   p  ; was: sub_412BA
                                        ; Boss_SunsetStingIdleState+8   p
                clr.w   d0
                move.b  $4B(a5),d0
                asl.w   #2,d0
                andi.w  #$1FE,d0
                lea     (Math_SineTable).l,a0
                move.w  (a0,d0.w),d0
                ext.l   d0
                asl.l   #6,d0
                addi.l  #$1000000,d0
                sub.l   $14(a5),d0
                asr.l   #2,d0
                move.l  d0,$1C(a5)
                rts
; End of function Boss_SunsetStingCalculateVerticalVelocity
; Updates boss sprite graphics based on animation frame counter
Boss_SunsetStingUpdateGraphics:                         ; CODE XREF: Boss_SunsetStingIntroMovement:loc_40E5E   j  ; was: sub_412E6
                                        ; Boss_SunsetStingResetForAttack+28   j
                bsr.w   Boss_SunsetStingUpdatePartAngles
                btst    #2,(byte_FF80EC).w
                bne.s   loc_41302
                btst    #1,(byte_FF80EC).w
                bne.s   loc_41302
                tst.w   (word_FF8200).w
                beq.w   Boss_SunsetStingInitializeAttackPhase
loc_41302:                                              ; CODE XREF: Boss_SunsetStingUpdateGraphics+A   j
                                        ; Boss_SunsetStingUpdateGraphics+12   j
                lea     word_41568(pc),a1
                jsr     Boss_SunsetStingUpdateBodyPartPositions(pc)  ; (pc)
                nop
                bsr.w   Boss_SunsetStingUpdateCameraOffset
                lea     word_40DC4(pc),a0
                move.w  (word_FFC67E).w,d0
                lsr.w   #3,d0
                bsr.w   Boss_SunsetStingLoadTileTableEntry
                lea     word_40DD6+$24(pc),a0
                move.w  (word_FFC67E).w,d0
                lsr.w   #2,d0
                bsr.w   Boss_SunsetStingLoadTileTableEntry
                addq.w  #1,(word_FFC67E).w
                rts
; End of function Boss_SunsetStingUpdateGraphics
; Loads compressed tile data from indexed table entry
Boss_SunsetStingLoadTileTableEntry:                     ; CODE XREF: Boss_SunsetStingUpdateGraphics+34   p  ; was: sub_41332
                                        ; Boss_SunsetStingUpdateGraphics+42   p
                and.w   (a0)+,d0
                adda.w  d0,a0
                adda.w  (a0),a0
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_SunsetStingLoadTileTableEntry
; Initializes boss attack phase with state flags and movement
Boss_SunsetStingInitializeAttackPhase:                  ; CODE XREF: Boss_SunsetStingUpdateGraphics+18   j  ; was: sub_4133E
                move.b  #1,(byte_FF830E).w
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #0,$4A(a5)
                move.w  #$26,4(a5)                      ; '&'
                move.b  #8,$4B(a5)
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingInitializeAttackPhase
; Spawns debris objects with random velocities in circular pattern
Boss_SunsetStingSpawnDebrisField:                       ; DATA XREF: ROM:00040D28   o  ; was: sub_41384
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingUpdateGraphics
                addq.w  #2,4(a5)
                clr.b   $21(a5)
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
                lea     (Math_SineTable).l,a2
loc_413A4:                                              ; CODE XREF: Boss_SunsetStingSpawnDebrisField+6E   j
                move.w  #$1C4,(a4)
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
                dbf     d4,loc_413A4
; Spawn projectiles while rising until screen threshold
Boss_SunsetStingSpawnDebrisField_RiseLoop:              ; DATA XREF: ROM:00040D2A   o  ; was: loc_413F6
                addi.l  #$800,$1C(a5)
                cmpi.w  #$1C0,$14(a5)
                bhi.s   loc_41416
                move.l  #$200020,d1
                bsr.w   Projectile_SpawnWithRandomOffset
                bsr.w   Boss_SunsetStingUpdateCameraOffset
                rts
; ---------------------------------------------------------------------------
loc_41416:                                              ; CODE XREF: Boss_SunsetStingSpawnDebrisField+80   j
                move.b  #$40,$4B(a5)                    ; '@'
                addq.w  #2,4(a5)
                move.w  #1,d5
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
loc_4142E:                                              ; CODE XREF: Boss_SunsetStingSpawnDebrisField+B4   j
                move.b  d5,$4B(a4)
                addq.w  #1,d5
                lea     $60(a4),a4
                dbf     d4,loc_4142E
                rts
; End of function Boss_SunsetStingSpawnDebrisField
; Fades out screen and destroys boss object when timer expires
Boss_SunsetStingFadeOutAndDestroy:                      ; DATA XREF: ROM:00040D2C   o  ; was: sub_4143E
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                subq.b  #1,$4B(a5)
                bne.w   locret_41454
                clr.w   (a5)
locret_41454:                                           ; CODE XREF: Boss_SunsetStingFadeOutAndDestroy+10   j
                rts
; End of function Boss_SunsetStingFadeOutAndDestroy
; Updates debris particle rotation and animation frame
Effect_DebrisParticleAnimate:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_41456
                tst.b   $4B(a5)
                beq.s   loc_41462
                subq.b  #1,$4B(a5)
                beq.s   loc_41484
loc_41462:                                              ; CODE XREF: Effect_DebrisParticleAnimate+4   j
                move.w  $5C(a5),d0
                add.w   d0,$56(a5)
                move.l  $50(a5),d0
                beq.s   locret_41482
                movea.l d0,a1
                move.w  $56(a5),d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a5)
locret_41482:                                           ; CODE XREF: Effect_DebrisParticleAnimate+18   j
                rts
; ---------------------------------------------------------------------------
loc_41484:                                              ; CODE XREF: Effect_DebrisParticleAnimate+A   j
                lea     (a5),a0
                jsr     (loc_2A2A4).l
                clr.b   $21(a5)
                rts
; End of function Effect_DebrisParticleAnimate
; Spawns projectile with randomized position offset
Projectile_SpawnWithRandomOffset:                       ; CODE XREF: Boss_SunsetStingSpawnDebrisField+88   p  ; was: sub_41492
                                        ; Boss_SunsetStingDescendAndActivate+E   p
                move.l  d1,-(sp)
                jsr     (Projectile_UpdateWithImpactFrames).l
                bne.s   loc_414EA
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
loc_414EA:                                              ; CODE XREF: Projectile_SpawnWithRandomOffset+8   j
                move.l  (sp)+,d1
                rts
; End of function Projectile_SpawnWithRandomOffset
; Calculates camera offset relative to boss position
Boss_SunsetStingUpdateCameraOffset:                     ; CODE XREF: Boss_SunsetStingUpdateGraphics+26   p  ; was: sub_414EE
                                        ; Boss_SunsetStingSpawnDebrisField+8C   p
                move.w  #$A4,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$4C,d0                         ; 'L'
                move.w  d0,(dword_FFA90C).w
                jmp     Boss_ClampSharedScreenPosition
; End of function Boss_SunsetStingUpdateCameraOffset
; Updates animation angles for boss body parts
Boss_SunsetStingUpdatePartAngles:                       ; CODE XREF: Boss_SunsetStingUpdateGraphics   p  ; was: sub_4150C
                move.b  $4A(a5),d0
                andi.w  #$E,d0
                lea     word_4165C(pc),a1
                adda.w  d0,a1
                adda.w  (a1),a1
                lea     $60(a5),a4
loc_41520:                                              ; CODE XREF: Boss_SunsetStingUpdatePartAngles+38   j
                move.w  (a1)+,d0
                beq.s   locret_41546
                lea     -2(a1,d0.w),a0
                move.w  (a0)+,d3
loc_4152A:                                              ; CODE XREF: Boss_SunsetStingUpdatePartAngles+34   j
                move.w  (a0)+,d0
                bmi.s   loc_4153C
                ext.w   d0
                add.w   d0,d0
                sub.w   $56(a4),d0
                asr.w   #3,d0
                add.w   d0,$56(a4)
loc_4153C:                                              ; CODE XREF: Boss_SunsetStingUpdatePartAngles+20   j
                lea     $60(a4),a4
                dbf     d3,loc_4152A
                bra.s   loc_41520
; ---------------------------------------------------------------------------
locret_41546:                                           ; CODE XREF: Boss_SunsetStingUpdatePartAngles+16   j
                rts
; End of function Boss_SunsetStingUpdatePartAngles
; ---------------------------------------------------------------------------
                dc.l    word_EBDBC
                dc.l    word_EBDC2
                dc.l    word_EBDC8
                dc.l    word_EBD9E
                dc.l    word_EBDA4
                dc.l    word_EBDAA
                dc.l    word_EBDB0
                dc.l    word_EBDB6
word_41568:     dc.w    $E, $BDB0, $80, 0, $8000, 1, $2004, $D2E, $83, $140, $6004, $1548
                                        ; DATA XREF: Boss_SunsetStingLoadGraphics+28   o
                                        ; sub_412E6:loc_41302   o
                dc.w    $43, $A0, $6004, $1548, $4A, 0, $6004, $1548, $61, $60, $6004, $1548
                dc.w    $60, $60, $8000, 0, $8000, 1, $2004, $D2E, $83, $160, $6004, $1548
                dc.w    $43, $70, $6004, $1548, $4A, 0, $6004, $1548, $61, $50, $6004, $1548
                dc.w    $60, $50, $8000, 0, $8000, 1, $2004, $D2E, $83, $180, $6004, $1548
                dc.w    $43, $60, $6004, $1548, $4A, 0, $6004, $1548, $61, $60, $6004, $1548
                dc.w    $60, $60, $8000, 0, $8000, 1, $2004, $D2E, $83, $1A0, $6004, $1548
                dc.w    $43, $30, $6004, $1548, $4A, 0, $6004, $1548, $61, $50, $6004, $1548
                dc.w    $60, $50, $8000, 0, $8000, 1, $2004, $D2E, $A3, $20, $6004, $1548
                dc.w    $43, $FFB0, $6004, $1548, $4A, 0, $6004, $1548, $49, $FFA0, $8000, 0
                dc.w    $8000, 0
word_4165C:     binclude "data/other/word_4165C.bin"
word_4165C_End:

; Initializes boss body part sprites from pointer table
Boss_SunsetStingInitBodyParts:                          ; CODE XREF: Boss_SunsetStingLoadGraphics+2E   p  ; was: sub_417D8
                                        ; Boss_SunsetStingLoadGraphicsAlt+2E   p
                clr.w   d7
                movea.l a5,a3
                clr.l   -(sp)
                move.w  $E(a5),d5
loc_417E2:                                              ; CODE XREF: Boss_SunsetStingInitBodyParts+18   j
                                        ; Boss_SunsetStingInitBodyParts+20   j
                move.l  (a1)+,d4
                bpl.s   loc_417FA
                andi.l  #$7FFFFFFF,d4
                beq.s   loc_417F2
                move.l  a5,-(sp)
                bra.s   loc_417E2
; ---------------------------------------------------------------------------
loc_417F2:                                              ; CODE XREF: Boss_SunsetStingInitBodyParts+14   j
                move.l  (sp)+,d0
                beq.s   loc_41852
                movea.l d0,a5
                bra.s   loc_417E2
; ---------------------------------------------------------------------------
loc_417FA:                                              ; CODE XREF: Boss_SunsetStingInitBodyParts+C   j
                move.w  d5,$E(a4)
                move.b  #$C0,$20(a4)
                bclr    #$1E,d4
                bne.s   loc_41814
                move.l  d4,8(a4)
                clr.l   $50(a4)
                bra.s   loc_41818
; ---------------------------------------------------------------------------
loc_41814:                                              ; CODE XREF: Boss_SunsetStingInitBodyParts+30   j
                move.l  d4,$50(a4)
loc_41818:                                              ; CODE XREF: Boss_SunsetStingInitBodyParts+3A   j
                swap    d4
                andi.w  #$FF00,d4
                asl.w   #2,d4
                or.w    d4,$E(a4)
                move.w  #$C000,2(a4)
                move.w  (a1)+,$4C(a4)
                move.b  $4D(a4),d0
                andi.b  #3,d0
                asl.b   #2,d0
                add.b   d0,$20(a4)
                move.w  (a1)+,$56(a4)
                move.w  a5,$4E(a4)
                addq.w  #1,d7
                move.w  #$10,(a4)
                lea     (a4),a5
                lea     $60(a4),a4
                bra.s   loc_417E2
; ---------------------------------------------------------------------------
loc_41852:                                              ; CODE XREF: Boss_SunsetStingInitBodyParts+1C   j
                move.w  d7,(word_FFC67C).w
                lea     (a3),a5
                clr.w   $4E(a5)
                rts
; End of function Boss_SunsetStingInitBodyParts
; Updates positions of all boss body parts using sine/cosine
Boss_SunsetStingUpdateBodyPartPositions:                ; CODE XREF: Boss_SunsetStingUpdateGraphics+20   p  ; was: sub_4185E
                                        ; Boss_SunsetStingMainUpdate+78   p
                move.w  (word_FFC67C).w,d7
                subq.w  #1,d7
                lea     $60(a5),a4
                movea.l #Math_SineTable,a2
                movem.l a5,-(sp)
                btst    #3,$E(a5)
                lea     Boss_SunsetStingApplyParentOffset(pc),a5
                beq.s   loc_41882
                lea     Boss_SunsetStingFlipHorizontal(pc),a5
loc_41882:                                              ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+1E   j
                                        ; Boss_SunsetStingApplyParentOffset+18   j
                andi.w  #$F7FF,$E(a4)
                move.w  $56(a4),d6
                lea     (a4),a0
loc_4188E:                                              ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+3C   j
                move.w  $4E(a0),d0
                beq.s   loc_4189C
                movea.w d0,a0
                add.w   $56(a0),d6
                bra.s   loc_4188E
; ---------------------------------------------------------------------------
loc_4189C:                                              ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+34   j
                move.l  $50(a4),d0
                beq.s   loc_418B8
                movea.l d0,a1
                move.w  d6,d1
                move.w  #$F8,d0
                sub.w   d1,d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a4)
loc_418B8:                                              ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+42   j
                move.w  d6,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  $4C(a4),d0
                muls.w  $4C(a4),d1
                jmp     (a5)
; End of function Boss_SunsetStingUpdateBodyPartPositions
; Negates values and flips horizontal sprite flag
Boss_SunsetStingFlipHorizontal:                         ; DATA XREF: Boss_SunsetStingUpdateBodyPartPositions+20   o  ; was: sub_418D2
                neg.l   d1
                eori.w  #$800,$E(a4)
; End of function Boss_SunsetStingFlipHorizontal
; Adds parent part position offsets to child body part
Boss_SunsetStingApplyParentOffset:                      ; DATA XREF: Boss_SunsetStingUpdateBodyPartPositions+1A   o  ; was: sub_418DA
                movea.w $4E(a4),a3
                add.l   $10(a3),d1
                move.l  d1,$10(a4)
                add.l   $14(a3),d0
                move.l  d0,$14(a4)
                lea     $60(a4),a4
                dbf     d7,loc_41882
                movem.l (sp)+,a5
                rts
; End of function Boss_SunsetStingApplyParentOffset
