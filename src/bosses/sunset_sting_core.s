; Initializes the shared boss table pointer and dispatches the setup state
Boss_SunsetStingInitDispatcher:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_40CEE
                moveq   #4,d7
                jsr     (Gfx_ProcessDefaultColorFade).l
                move.w  4(a5),d0
                lea     Boss_SunsetStingEarlyFormStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingInitDispatcher
; ---------------------------------------------------------------------------
Boss_SunsetStingEarlyFormStates:
                dc.w    Boss_SunsetStingSetupArena-*    ; DATA XREF: Boss_SunsetStingInitDispatcher+C   o  ; was: off_40D02
                dc.w    Boss_SunsetStingLoadGraphics-*
                dc.w    Boss_SunsetStingQueueIntroMessageState-*
                dc.w    Boss_SunsetStingWaitForIntroMessageState-*
                dc.w    Boss_SunsetStingIdleState-*
                dc.w    Boss_SunsetStingIncreaseSharedCounterState-*
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
                dc.w    Boss_SunsetStingScatterBodyPartsState-*
                dc.w    Boss_SunsetStingRiseAndSpawnProjectilesState-*
                dc.w    Boss_SunsetStingDefeatCleanupState-*
Boss_SunsetStingEarlyFormUnusedTableTail:
                binclude "data/other/sunset_sting_early_form_unused_table_tail.bin"  ; was: unused_8

; Sets up battle arena parameters and clears sprite slots
Boss_SunsetStingSetupArena:                             ; DATA XREF: ROM:Boss_SunsetStingEarlyFormStates   o  ; was: sub_40D34
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
                bmi.w   Boss_SunsetStingLoadGraphicsReturn
                addq.w  #2,4(a5)
                movea.l #Boss_SunsetStingObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                moveq   #6,d7
                jsr     (Gfx_ResetDefaultColorFadeState).l
                move.w  (a5),-(sp)
                move.w  #$4300,$E(a5)
                lea     Boss_SunsetStingBodyPartInitTable(pc),a1
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
                movea.l #Boss_SunsetStingEarlyFormTileLoadCommands,a0
                jsr     (Gfx_LoadCompressedTiles).l
Boss_SunsetStingLoadGraphicsReturn:                     ; CODE XREF: Boss_SunsetStingLoadGraphics+4   j  ; was: locret_40DC2
                rts
; End of function Boss_SunsetStingLoadGraphics
; ---------------------------------------------------------------------------
Boss_SunsetStingPrimaryTileAnimationOffsets:
                dc.w    $E, $20, $1E, $26, $1A, $22, $16, $14, $12  ; was: word_40DC4
                                        ; DATA XREF: Boss_SunsetStingUpdateGraphics+2A   o
Boss_SunsetStingEarlyFormTileLoadCommands:
                dc.w    $6100, $2000, $202, $494A, $4B4D, $4E4F, $5152, $FF, $6300, $2000, $101, $4D4E, $5152, $6300, $2000, $101  ; was: word_40DD6
                                        ; DATA XREF: Boss_SunsetStingLoadGraphics+60   o
                dc.w    $5455, $5658, $E, $10, $16, $1C, $12, 8, 6, 4, 2, $6100, $2000, $100, $494A, $6100
                dc.w    $2000, $100, $4C53, $6100, $2000, $100, $5057

; Queues the phase-intro message and advances to its movement state
Boss_SunsetStingQueueIntroMessageState:                 ; DATA XREF: ROM:00040D06   o  ; was: sub_40E24
                moveq   #5,d0
                jsr     (BossMessage_Start).l
                addq.w  #2,4(a5)
                bra.w   Boss_SunsetStingIntroUpdateMotion
; End of function Boss_SunsetStingQueueIntroMessageState
; Holds the intro flight pattern until the shared message timer expires
Boss_SunsetStingWaitForIntroMessageState:               ; DATA XREF: ROM:00040D08   o  ; was: sub_40E34
                tst.w   (MessageSequenceState).w
                bne.s   Boss_SunsetStingIntroUpdateMotion
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
                addq.w  #2,4(a5)
Boss_SunsetStingIntroUpdateMotion:                      ; CODE XREF: Boss_SunsetStingQueueIntroMessageState+C   j  ; was: loc_40E48
                                        ; Boss_SunsetStingWaitForIntroMessageState+4   j
                subq.b  #1,$4B(a5)
                bsr.w   Boss_SunsetStingCalculateVerticalVelocity
                cmpi.l  #$1600000,$10(a5)
                bhi.s   Boss_SunsetStingIntroRender
                clr.l   $18(a5)
Boss_SunsetStingIntroRender:                            ; CODE XREF: Boss_SunsetStingWaitForIntroMessageState+24   j  ; was: loc_40E5E
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingWaitForIntroMessageState
; Resets attack state and adjusts based on boss health
Boss_SunsetStingResetForAttack:                         ; CODE XREF: Boss_SunsetStingDashAttack+72   j  ; was: sub_40E62
                                        ; Boss_SunsetStingDashAttack+82   j
                move.w  #8,4(a5)
                move.b  #$40,$4B(a5)                    ; '@'
                clr.l   $18(a5)
                cmpi.w  #$100,(word_FF8234).w
                bgt.s   Boss_SunsetStingResetDisableCollision
                move.b  #$C0,$4B(a5)
                move.w  #$A,4(a5)
Boss_SunsetStingResetDisableCollision:                  ; CODE XREF: Boss_SunsetStingResetForAttack+16   j  ; was: loc_40E86
                bsr.w   Boss_SunsetStingDisableCollision
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingResetForAttack
; Increments the shared battle counter before the idle update
Boss_SunsetStingIncreaseSharedCounterState:             ; DATA XREF: ROM:00040D0C   o  ; was: sub_40E8E
                addi.w  #2,(word_FF8234).w
                clr.w   d3
                bsr.w   Boss_SunsetStingCalculateAngleAndFlip
; End of function Boss_SunsetStingIncreaseSharedCounterState
; Handles idle behavior with animation and distance-based attack selection
Boss_SunsetStingIdleState:                              ; DATA XREF: ROM:00040D0A   o  ; was: sub_40E9A
                subq.b  #1,$4B(a5)
                beq.w   Boss_SunsetStingChooseAttack
                bsr.w   Boss_SunsetStingCalculateVerticalVelocity
                move.b  #0,6(a5)
                bsr.w   Boss_SunsetStingInterpolateRotation
                move.b  #0,$4A(a5)
                btst    #4,$4B(a5)
                beq.w   Boss_SunsetStingUpdateGraphics
                move.b  #4,$4A(a5)
                bra.w   Boss_SunsetStingUpdateGraphics
; ---------------------------------------------------------------------------
Boss_SunsetStingChooseAttack:                           ; CODE XREF: Boss_SunsetStingIdleState+4   j  ; was: loc_40ECA
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$80,d0
                bcs.s   Boss_SunsetStingCloseRangeAttack
                lea     Boss_SunsetStingDistantAttackChoices(pc),a0
                jmp     Math_JumpToWeightedChoice
; End of function Boss_SunsetStingIdleState
; ---------------------------------------------------------------------------
Boss_SunsetStingDistantAttackChoices:
                dc.w    $7800                           ; DATA XREF: Boss_SunsetStingIdleState+3C   o  ; was: word_40EE0
                dc.w    Boss_SunsetStingBeginSerpentineCycle-*
                dc.w    $7000
                dc.w    Boss_SunsetStingBeginDashCycle-*
                dc.w    $1000
                dc.w    Boss_SunsetStingBeginWobble-*
                dc.w    $800
                dc.w    Boss_SunsetStingBeginRotationRecovery-*

; Selects random attack pattern when player is close
Boss_SunsetStingCloseRangeAttack:                       ; CODE XREF: Boss_SunsetStingIdleState+3A   j  ; was: sub_40EF0
                lea     Boss_SunsetStingCloseAttackChoices(pc),a0
                jmp     Math_JumpToWeightedChoice
; End of function Boss_SunsetStingCloseRangeAttack
; ---------------------------------------------------------------------------
Boss_SunsetStingCloseAttackChoices:
                dc.w    $A000                           ; DATA XREF: Boss_SunsetStingCloseRangeAttack   o  ; was: word_40EFA
                dc.w    Boss_SunsetStingBeginRotationRecovery-*
                dc.w    $8000
                dc.w    Boss_SunsetStingBeginDiveWindup-*

; Calculates horizontal screen offset based on boss position and velocity direction
Boss_SunsetStingCalculateScreenOffset:                  ; CODE XREF: Boss_SunsetStingDashAttack+6E   p  ; was: sub_40F02
                                        ; Boss_SunsetStingDashAttack+7E   p
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                tst.w   $18(a5)
                bpl.s   Boss_SunsetStingMeasureRightBoundary
                subi.w  #$400,d0
                rts
; ---------------------------------------------------------------------------
Boss_SunsetStingMeasureRightBoundary:                   ; CODE XREF: Boss_SunsetStingCalculateScreenOffset+C   j  ; was: loc_40F16
                move.w  #$600,d1
                sub.w   d0,d1
                rts
; End of function Boss_SunsetStingCalculateScreenOffset
; Disables collision flag for all 5 boss body segments
Boss_SunsetStingDisableCollision:                       ; CODE XREF: Boss_SunsetStingResetForAttack:Boss_SunsetStingResetDisableCollision   p  ; was: sub_40F1E
                andi.b  #$BF,$201(a5)
                andi.b  #$BF,$3E1(a5)
                andi.b  #$BF,$5C1(a5)
                andi.b  #$BF,$7A1(a5)
                andi.b  #$BF,$921(a5)
                rts
; End of function Boss_SunsetStingDisableCollision
; Enables collision flag for all 5 boss body segments
Boss_SunsetStingEnableCollision:                        ; CODE XREF: Boss_SunsetStingBeginDashCycle+12   p  ; was: sub_40F3E
                                        ; Boss_SunsetStingBeginDiveWindup+12   p
                ori.b   #$40,$201(a5)                   ; '@'
                ori.b   #$40,$3E1(a5)                   ; '@'
                ori.b   #$40,$5C1(a5)                   ; '@'
                ori.b   #$40,$7A1(a5)                   ; '@'
                ori.b   #$40,$921(a5)                   ; '@'
                rts
; End of function Boss_SunsetStingEnableCollision
; Starts the repeated dash cycle
Boss_SunsetStingBeginDashCycle:                         ; DATA XREF: ROM:00040EE6   o  ; was: sub_40F5E
                move.w  #$C,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                move.b  #4,$4A(a5)
                bsr.s   Boss_SunsetStingEnableCollision
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingBeginDashCycle
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
                bne.s   Boss_SunsetStingDashStoreInitialAngle
                move.w  #$100,d0
Boss_SunsetStingDashStoreInitialAngle:                  ; CODE XREF: Boss_SunsetStingDashAttack+2C   j  ; was: loc_40FA8
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
; Starts the dive windup state
Boss_SunsetStingBeginDiveWindup:                        ; DATA XREF: ROM:00040F00   o  ; was: sub_41016
                move.w  #$18,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                move.b  #4,$4A(a5)
                bsr.w   Boss_SunsetStingEnableCollision
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingBeginDiveWindup
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
; Starts the serpentine movement cycle
Boss_SunsetStingBeginSerpentineCycle:                   ; DATA XREF: ROM:00040EE2   o  ; was: sub_4106A
                move.w  #$1C,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                move.b  #8,$4A(a5)
                clr.l   $1C(a5)
                bsr.w   Boss_SunsetStingEnableCollision
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingBeginSerpentineCycle
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
                bne.w   Boss_SunsetStingSerpentineCheckBounds
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
                bne.w   Boss_SunsetStingSerpentineCheckBounds
                bra.w   Boss_SunsetStingResetForAttack
; ---------------------------------------------------------------------------
Boss_SunsetStingSerpentineCheckBounds:                  ; CODE XREF: Boss_SunsetStingSerpentineAttack+5A   j  ; was: loc_41112
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
Boss_SunsetStingBeginRotationRecovery:                  ; CODE XREF: Boss_SunsetStingSerpentineAttack+AC   j  ; was: sub_41138
                                        ; Boss_SunsetStingWobbleRotation+1C   j
                                        ; DATA XREF:
                move.w  #$22,4(a5)                      ; '"'
                move.b  #$38,$4B(a5)                    ; '8'
                move.b  #$A,$4A(a5)
                subi.w  #$148,(word_FF8234).w
                bsr.w   Boss_SunsetStingEnableCollision
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingBeginRotationRecovery
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
; Starts the timed wobble state
Boss_SunsetStingBeginWobble:                            ; DATA XREF: ROM:00040EEA   o  ; was: sub_41178
                move.w  #$24,4(a5)                      ; '$'
                move.b  #$60,$4B(a5)                    ; '`'
                move.b  #6,$4A(a5)
                clr.l   $1C(a5)
                bra.w   Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingBeginWobble
; Applies wobbling rotation effect using sine wave pattern
Boss_SunsetStingWobbleRotation:                         ; DATA XREF: ROM:00040D26   o  ; was: sub_41192
                move.b  $4B(a5),d4
                lsr.w   #2,d4
                andi.w  #7,d4
                move.b  Boss_SunsetStingWobbleAngleDeltas(pc,d4.w),d4
                ext.w   d4
                add.w   d4,$56(a5)
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingUpdateGraphics
                bra.s   Boss_SunsetStingBeginRotationRecovery
; End of function Boss_SunsetStingWobbleRotation
; ---------------------------------------------------------------------------
Boss_SunsetStingWobbleAngleDeltas:
                dc.w    $FFFD, $FCFF, $103, $401, $49ED, $60, $363C, 4  ; was: word_411B0
                                        ; DATA XREF: Boss_SunsetStingWobbleRotation+A   r

; Spawns multiple projectile debris with randomized trajectories
Boss_SunsetStingSpawnDebris:                            ; CODE XREF: Boss_SunsetStingSpawnDebris+5E   j  ; was: sub_411C0
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Boss_SunsetStingFinishDebrisSpawn
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
Boss_SunsetStingFinishDebrisSpawn:                      ; CODE XREF: Boss_SunsetStingSpawnDebris+6   j  ; was: loc_41222
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
                beq.s   Boss_SunsetStingScaleTrajectory
                neg.w   d1
Boss_SunsetStingScaleTrajectory:                        ; CODE XREF: Boss_SunsetStingCalculateTrajectory+26   j  ; was: loc_41250
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
                bpl.s   Boss_SunsetStingCheckFlipReturn
                ori.w   #$800,$E(a5)
Boss_SunsetStingCheckFlipReturn:                        ; CODE XREF: Boss_SunsetStingCheckFlipDirection+E   j  ; was: locret_41270
                rts
; End of function Boss_SunsetStingCheckFlipDirection
; Calculates angle to player with flip flag
Boss_SunsetStingCalculateAngleAndFlip:                  ; CODE XREF: Boss_SunsetStingIncreaseSharedCounterState+8   p  ; was: sub_41272
                                        ; Boss_SunsetStingDashAttack+4   p
                andi.w  #$F7FF,$E(a5)
                movem.l d3,-(sp)
                lea     (word_FFA400).w,a4
                jsr     (Physics_CalculateAngleToTarget).l
                movem.l (sp)+,d3
                move.b  d0,d2
                bpl.s   Boss_SunsetStingStoreAimOffset
                ori.w   #$800,$E(a5)
                neg.b   d2
Boss_SunsetStingStoreAimOffset:                         ; CODE XREF: Boss_SunsetStingCalculateAngleAndFlip+1A   j  ; was: loc_41296
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
Boss_SunsetStingCalculateVerticalVelocity:              ; CODE XREF: Boss_SunsetStingWaitForIntroMessageState+18   p  ; was: sub_412BA
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
Boss_SunsetStingUpdateGraphics:                         ; CODE XREF: Boss_SunsetStingWaitForIntroMessageState:Boss_SunsetStingIntroRender   j  ; was: sub_412E6
                                        ; Boss_SunsetStingResetForAttack+28   j
                bsr.w   Boss_SunsetStingUpdatePartAngles
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_SunsetStingUpdateBodyGraphics
                btst    #1,(byte_FF80EC).w
                bne.s   Boss_SunsetStingUpdateBodyGraphics
                tst.w   (word_FF8200).w
                beq.w   Boss_SunsetStingBeginEarlyFormDefeatState
Boss_SunsetStingUpdateBodyGraphics:                     ; CODE XREF: Boss_SunsetStingUpdateGraphics+A   j  ; was: loc_41302
                                        ; Boss_SunsetStingUpdateGraphics+12   j
                lea     Boss_SunsetStingBodyPartInitTable(pc),a1
                jsr     Boss_SunsetStingUpdateBodyPartPositions(pc)  ; (pc)
                nop
                bsr.w   Boss_SunsetStingUpdateCameraOffset
                lea     Boss_SunsetStingPrimaryTileAnimationOffsets(pc),a0
                move.w  (word_FFC67E).w,d0
                lsr.w   #3,d0
                bsr.w   Boss_SunsetStingLoadTileTableEntry
                lea     Boss_SunsetStingEarlyFormTileLoadCommands+$24(pc),a0
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
; Starts the early form's defeat transition when shared health reaches zero
Boss_SunsetStingBeginEarlyFormDefeatState:              ; CODE XREF: Boss_SunsetStingUpdateGraphics+18   j  ; was: sub_4133E
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
; End of function Boss_SunsetStingBeginEarlyFormDefeatState
; Converts the body parts to debris with randomized velocities
Boss_SunsetStingScatterBodyPartsState:                  ; DATA XREF: ROM:00040D28   o  ; was: sub_41384
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingUpdateGraphics
                addq.w  #2,4(a5)
                clr.b   $21(a5)
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
                lea     (Math_SineTable).l,a2
Boss_SunsetStingInitializeDebrisPart:                   ; CODE XREF: Boss_SunsetStingScatterBodyPartsState+6E   j  ; was: loc_413A4
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
                dbf     d4,Boss_SunsetStingInitializeDebrisPart
; Spawn projectiles while rising until screen threshold
Boss_SunsetStingRiseAndSpawnProjectilesState:           ; DATA XREF: ROM:00040D2A   o  ; was: loc_413F6
                addi.l  #$800,$1C(a5)
                cmpi.w  #$1C0,$14(a5)
                bhi.s   Boss_SunsetStingBeginStaggeredDebrisCleanup
                move.l  #$200020,d1
                bsr.w   Boss_SunsetStingSpawnRandomOffsetProjectile
                bsr.w   Boss_SunsetStingUpdateCameraOffset
                rts
; ---------------------------------------------------------------------------
Boss_SunsetStingBeginStaggeredDebrisCleanup:            ; CODE XREF: Boss_SunsetStingScatterBodyPartsState+80   j  ; was: loc_41416
                move.b  #$40,$4B(a5)                    ; '@'
                addq.w  #2,4(a5)
                move.w  #1,d5
                move.w  (word_FFC67C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
Boss_SunsetStingSeedDebrisCleanupDelay:                 ; CODE XREF: Boss_SunsetStingScatterBodyPartsState+B4   j  ; was: loc_4142E
                move.b  d5,$4B(a4)
                addq.w  #1,d5
                lea     $60(a4),a4
                dbf     d4,Boss_SunsetStingSeedDebrisCleanupDelay
                rts
; End of function Boss_SunsetStingScatterBodyPartsState
; Retires the controller after its defeat cleanup timer expires
Boss_SunsetStingDefeatCleanupState:                     ; DATA XREF: ROM:00040D2C   o  ; was: sub_4143E
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                subq.b  #1,$4B(a5)
                bne.w   Boss_SunsetStingFadeOutReturn
                clr.w   (a5)
Boss_SunsetStingFadeOutReturn:                          ; CODE XREF: Boss_SunsetStingDefeatCleanupState+10   j  ; was: locret_41454
                rts
; End of function Boss_SunsetStingDefeatCleanupState
; Updates one body-part debris object and retires it after its delay
Boss_SunsetStingDebrisPartMain:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_41456
                tst.b   $4B(a5)
                beq.s   Boss_SunsetStingDebrisPartUpdateAnimation
                subq.b  #1,$4B(a5)
                beq.s   Boss_SunsetStingDebrisPartRemove
Boss_SunsetStingDebrisPartUpdateAnimation:              ; CODE XREF: Boss_SunsetStingDebrisPartMain+4   j  ; was: loc_41462
                move.w  $5C(a5),d0
                add.w   d0,$56(a5)
                move.l  $50(a5),d0
                beq.s   Boss_SunsetStingDebrisPartReturn
                movea.l d0,a1
                move.w  $56(a5),d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a5)
Boss_SunsetStingDebrisPartReturn:                       ; CODE XREF: Boss_SunsetStingDebrisPartMain+18   j  ; was: locret_41482
                rts
; ---------------------------------------------------------------------------
Boss_SunsetStingDebrisPartRemove:                       ; CODE XREF: Boss_SunsetStingDebrisPartMain+A   j  ; was: loc_41484
                lea     (a5),a0
                jsr     (Effect_InitSharedExplosion).l
                clr.b   $21(a5)
                rts
; End of function Boss_SunsetStingDebrisPartMain
; Spawns projectile with randomized position offset
Boss_SunsetStingSpawnRandomOffsetProjectile:            ; CODE XREF: Boss_SunsetStingRiseAndSpawnProjectilesState+E   p  ; was: sub_41492
                                        ; Boss_SunsetStingDescendAndActivateChainsState+E   p
                move.l  d1,-(sp)
                jsr     (Projectile_UpdateWithImpactFrames).l
                bne.s   Boss_SunsetStingSpawnRandomOffsetProjectileReturn
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
Boss_SunsetStingSpawnRandomOffsetProjectileReturn:      ; CODE XREF: Boss_SunsetStingSpawnRandomOffsetProjectile+8   j  ; was: loc_414EA
                move.l  (sp)+,d1
                rts
; End of function Boss_SunsetStingSpawnRandomOffsetProjectile
; Calculates camera offset relative to boss position
Boss_SunsetStingUpdateCameraOffset:                     ; CODE XREF: Boss_SunsetStingUpdateGraphics+26   p  ; was: sub_414EE
                                        ; Boss_SunsetStingRiseAndSpawnProjectilesState+12   p
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
                lea     Boss_SunsetStingBodyPartAngleSequences(pc),a1
                adda.w  d0,a1
                adda.w  (a1),a1
                lea     $60(a5),a4
Boss_SunsetStingReadAngleSequence:                      ; CODE XREF: Boss_SunsetStingUpdatePartAngles+38   j  ; was: loc_41520
                move.w  (a1)+,d0
                beq.s   Boss_SunsetStingUpdatePartAnglesReturn
                lea     -2(a1,d0.w),a0
                move.w  (a0)+,d3
Boss_SunsetStingInterpolatePartAngle:                   ; CODE XREF: Boss_SunsetStingUpdatePartAngles+34   j  ; was: loc_4152A
                move.w  (a0)+,d0
                bmi.s   Boss_SunsetStingAdvancePartAngleSlot
                ext.w   d0
                add.w   d0,d0
                sub.w   $56(a4),d0
                asr.w   #3,d0
                add.w   d0,$56(a4)
Boss_SunsetStingAdvancePartAngleSlot:                   ; CODE XREF: Boss_SunsetStingUpdatePartAngles+20   j  ; was: loc_4153C
                lea     $60(a4),a4
                dbf     d3,Boss_SunsetStingInterpolatePartAngle
                bra.s   Boss_SunsetStingReadAngleSequence
; ---------------------------------------------------------------------------
Boss_SunsetStingUpdatePartAnglesReturn:                 ; CODE XREF: Boss_SunsetStingUpdatePartAngles+16   j  ; was: locret_41546
                rts
; End of function Boss_SunsetStingUpdatePartAngles
; ---------------------------------------------------------------------------
Boss_SunsetStingPartAnimationMappings:
                dc.l    word_EBDBC
                dc.l    word_EBDC2
                dc.l    word_EBDC8
                dc.l    word_EBD9E
                dc.l    word_EBDA4
                dc.l    word_EBDAA
                dc.l    word_EBDB0
                dc.l    word_EBDB6
Boss_SunsetStingBodyPartInitTable:
                dc.w    $E, $BDB0, $80, 0, $8000, 1, $2004, $D2E, $83, $140, $6004, $1548  ; was: word_41568
                                        ; DATA XREF: Boss_SunsetStingLoadGraphics+28   o
                                        ; Boss_SunsetStingUpdateGraphics:Boss_SunsetStingUpdateBodyGraphics   o
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
Boss_SunsetStingBodyPartAngleSequences:
                binclude "data/other/sunset_sting_body_part_angle_sequences.bin"  ; was: word_4165C
Boss_SunsetStingBodyPartAngleSequences_End:             ; was: word_4165C_End

; Initializes boss body part sprites from pointer table
Boss_SunsetStingInitBodyParts:                          ; CODE XREF: Boss_SunsetStingLoadGraphics+2E   p  ; was: sub_417D8
                                        ; Boss_SunsetStingSecondFormLoadGraphicsState+2E   p
                clr.w   d7
                movea.l a5,a3
                clr.l   -(sp)
                move.w  $E(a5),d5
Boss_SunsetStingReadBodyPartDescriptor:                 ; CODE XREF: Boss_SunsetStingInitBodyParts+18   j  ; was: loc_417E2
                                        ; Boss_SunsetStingInitBodyParts+20   j
                move.l  (a1)+,d4
                bpl.s   Boss_SunsetStingInitializeBodyPart
                andi.l  #$7FFFFFFF,d4
                beq.s   Boss_SunsetStingFinishBodyPartChain
                move.l  a5,-(sp)
                bra.s   Boss_SunsetStingReadBodyPartDescriptor
; ---------------------------------------------------------------------------
Boss_SunsetStingFinishBodyPartChain:                    ; CODE XREF: Boss_SunsetStingInitBodyParts+14   j  ; was: loc_417F2
                move.l  (sp)+,d0
                beq.s   Boss_SunsetStingFinishBodyPartInitialization
                movea.l d0,a5
                bra.s   Boss_SunsetStingReadBodyPartDescriptor
; ---------------------------------------------------------------------------
Boss_SunsetStingInitializeBodyPart:                     ; CODE XREF: Boss_SunsetStingInitBodyParts+C   j  ; was: loc_417FA
                move.w  d5,$E(a4)
                move.b  #$C0,$20(a4)
                bclr    #$1E,d4
                bne.s   Boss_SunsetStingStorePartAnimationMappings
                move.l  d4,8(a4)
                clr.l   $50(a4)
                bra.s   Boss_SunsetStingConfigureBodyPart
; ---------------------------------------------------------------------------
Boss_SunsetStingStorePartAnimationMappings:             ; CODE XREF: Boss_SunsetStingInitBodyParts+30   j  ; was: loc_41814
                move.l  d4,$50(a4)
Boss_SunsetStingConfigureBodyPart:                      ; CODE XREF: Boss_SunsetStingInitBodyParts+3A   j  ; was: loc_41818
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
                bra.s   Boss_SunsetStingReadBodyPartDescriptor
; ---------------------------------------------------------------------------
Boss_SunsetStingFinishBodyPartInitialization:           ; CODE XREF: Boss_SunsetStingInitBodyParts+1C   j  ; was: loc_41852
                move.w  d7,(word_FFC67C).w
                lea     (a3),a5
                clr.w   $4E(a5)
                rts
; End of function Boss_SunsetStingInitBodyParts
; Updates positions of all boss body parts using sine/cosine
Boss_SunsetStingUpdateBodyPartPositions:                ; CODE XREF: Boss_SunsetStingUpdateGraphics+20   p  ; was: sub_4185E
                                        ; Boss_SunsetStingSecondFormUpdate+78   p
                move.w  (word_FFC67C).w,d7
                subq.w  #1,d7
                lea     $60(a5),a4
                movea.l #Math_SineTable,a2
                movem.l a5,-(sp)
                btst    #3,$E(a5)
                lea     Boss_SunsetStingApplyParentOffset(pc),a5
                beq.s   Boss_SunsetStingUpdateBodyPart
                lea     Boss_SunsetStingFlipHorizontal(pc),a5
Boss_SunsetStingUpdateBodyPart:                         ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+1E   j  ; was: loc_41882
                                        ; Boss_SunsetStingApplyParentOffset+18   j
                andi.w  #$F7FF,$E(a4)
                move.w  $56(a4),d6
                lea     (a4),a0
Boss_SunsetStingAccumulateParentAngles:                 ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+3C   j  ; was: loc_4188E
                move.w  $4E(a0),d0
                beq.s   Boss_SunsetStingSelectPartMapping
                movea.w d0,a0
                add.w   $56(a0),d6
                bra.s   Boss_SunsetStingAccumulateParentAngles
; ---------------------------------------------------------------------------
Boss_SunsetStingSelectPartMapping:                      ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+34   j  ; was: loc_4189C
                move.l  $50(a4),d0
                beq.s   Boss_SunsetStingCalculatePartPosition
                movea.l d0,a1
                move.w  d6,d1
                move.w  #$F8,d0
                sub.w   d1,d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a4)
Boss_SunsetStingCalculatePartPosition:                  ; CODE XREF: Boss_SunsetStingUpdateBodyPartPositions+42   j  ; was: loc_418B8
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
                dbf     d7,Boss_SunsetStingUpdateBodyPart
                movem.l (sp)+,a5
                rts
; End of function Boss_SunsetStingApplyParentOffset
