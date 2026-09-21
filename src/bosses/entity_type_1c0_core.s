; Dispatches the dormant type-$1C0 controller; identity is externally attributed
; REVIEWED VIS-003: role-only name; this is not the live Sunset Sting; see docs/unknowns.md
EntityType1C0_InitDispatcher:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_40CEE
                moveq   #4,d7
                jsr     (Gfx_ProcessDefaultColorFade).l
                move.w  4(a5),d0
                lea     EntityType1C0_EarlyFormStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function EntityType1C0_InitDispatcher
; ---------------------------------------------------------------------------
EntityType1C0_EarlyFormStates:
                dc.w    EntityType1C0_SetupArena-*      ; DATA XREF: EntityType1C0_InitDispatcher+C   o  ; was: off_40D02
                dc.w    EntityType1C0_LoadGraphics-*
                dc.w    EntityType1C0_QueueIntroMessageState-*
                dc.w    EntityType1C0_WaitForIntroMessageState-*
                dc.w    EntityType1C0_IdleState-*
                dc.w    EntityType1C0_IncreaseSharedCounterState-*
                dc.w    EntityType1C0_DashAttack-*
                dc.w    EntityType1C0_DashAttack_MoveToward-*
                dc.w    EntityType1C0_DashAttack_MoveAway-*
                dc.w    EntityType1C0_DashAttack_MoveToward-*
                dc.w    EntityType1C0_DashAttack_MoveAway-*
                dc.w    EntityType1C0_ResetForAttack-*
                dc.w    EntityType1C0_PrepareDive-*
                dc.w    EntityType1C0_TimerWait-*
                dc.w    EntityType1C0_SerpentineAttack-*
                dc.w    EntityType1C0_SerpentineAttack_MoveIn-*
                dc.w    EntityType1C0_SerpentineAttack_MoveOut-*
                dc.w    EntityType1C0_RotationDecelerate-*
                dc.w    EntityType1C0_WobbleRotation-*
                dc.w    EntityType1C0_ScatterBodyPartsState-*
                dc.w    EntityType1C0_RiseAndSpawnProjectilesState-*
                dc.w    EntityType1C0_DefeatCleanupState-*
; REVIEWED DATA-001: five flagged pointers in the body-part table select this mapping
EntityType1C0_EarlyFormPartMapping:
                binclude "data/other/entity_type_1c0_early_form_part_mapping.bin"  ; was: unused_8

; Sets up battle arena parameters and clears sprite slots
EntityType1C0_SetupArena:                               ; DATA XREF: ROM:EntityType1C0_EarlyFormStates   o  ; was: sub_40D34
                move.b  #6,(BossColorEffectFlags).w
                move.w  #$1C0,d0
                moveq   #0,d1
                jsr     (Object_ClearEntityRecordsExceptTwoTypes).l
                addq.w  #2,4(a5)
                move.b  #$80,$4B(a5)
                clr.w   (PrimaryEntityWork5E).w
                rts
; End of function EntityType1C0_SetupArena
; Loads boss sprites, palette, tiles and initializes position/velocity
EntityType1C0_LoadGraphics:                             ; DATA XREF: ROM:00040D04   o  ; was: sub_40D56
                tst.w   (DataLoaderControl).w
                bmi.w   EntityType1C0_LoadGraphicsReturn
                addq.w  #2,4(a5)
                movea.l #EntityType1C0_ObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                moveq   #6,d7
                jsr     (Gfx_ResetDefaultColorFadeState).l
                move.w  (a5),-(sp)
                move.w  #$4300,$E(a5)
                lea     EntityType1C0_BodyPartInitTable(pc),a1
                lea     (a5),a4
                jsr     EntityType1C0_InitBodyParts(pc)  ; (pc)
                nop
                move.w  (sp)+,(a5)
                ori.w   #$D00,2(a5)
                move.l  #$2000000,$10(a5)
                move.l  #$1000000,$14(a5)
                move.l  #$FFFF0000,$18(a5)
                move.b  #0,$4A(a5)
                ori.w   #$800,$E(a5)
                movea.l #EntityType1C0_EarlyFormTileLoadCommands,a0
                jsr     (Tilemap_QueueIndexedRows).l
EntityType1C0_LoadGraphicsReturn:                       ; CODE XREF: EntityType1C0_LoadGraphics+4   j  ; was: locret_40DC2
                rts
; End of function EntityType1C0_LoadGraphics
; ---------------------------------------------------------------------------
EntityType1C0_PrimaryTileAnimationOffsets:
                dc.w    $E, $20, $1E, $26, $1A, $22, $16, $14, $12  ; was: word_40DC4
                                        ; DATA XREF: EntityType1C0_UpdateGraphics+2A   o
EntityType1C0_EarlyFormTileLoadCommands:
                dc.w    $6100, $2000, $202, $494A, $4B4D, $4E4F, $5152, $FF, $6300, $2000, $101, $4D4E, $5152, $6300, $2000, $101  ; was: word_40DD6
                                        ; DATA XREF: EntityType1C0_LoadGraphics+60   o
                dc.w    $5455, $5658, $E, $10, $16, $1C, $12, 8, 6, 4, 2, $6100, $2000, $100, $494A, $6100
                dc.w    $2000, $100, $4C53, $6100, $2000, $100, $5057

; Queues the phase-intro message and advances to its movement state
EntityType1C0_QueueIntroMessageState:                   ; DATA XREF: ROM:00040D06   o  ; was: sub_40E24
                moveq   #5,d0
                jsr     (BossMessage_Start).l
                addq.w  #2,4(a5)
                bra.w   EntityType1C0_IntroUpdateMotion
; End of function EntityType1C0_QueueIntroMessageState
; Holds the intro flight pattern until the shared message timer expires
EntityType1C0_WaitForIntroMessageState:                 ; DATA XREF: ROM:00040D08   o  ; was: sub_40E34
                tst.w   (MessageSequenceState).w
                bne.s   EntityType1C0_IntroUpdateMotion
                clr.b   (BossColorEffectFlags).w
                subi.w  #$A0,(CameraXLowerBound).w
                addq.w  #2,4(a5)
EntityType1C0_IntroUpdateMotion:                        ; CODE XREF: EntityType1C0_QueueIntroMessageState+C   j  ; was: loc_40E48
                                        ; EntityType1C0_WaitForIntroMessageState+4   j
                subq.b  #1,$4B(a5)
                bsr.w   EntityType1C0_CalculateVerticalVelocity
                cmpi.l  #$1600000,$10(a5)
                bhi.s   EntityType1C0_IntroRender
                clr.l   $18(a5)
EntityType1C0_IntroRender:                              ; CODE XREF: EntityType1C0_WaitForIntroMessageState+24   j  ; was: loc_40E5E
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_WaitForIntroMessageState
; Resets attack state and adjusts based on boss health
EntityType1C0_ResetForAttack:                           ; CODE XREF: EntityType1C0_DashAttack+72   j  ; was: sub_40E62
                                        ; EntityType1C0_DashAttack+82   j
                move.w  #8,4(a5)
                move.b  #$40,$4B(a5)                    ; '@'
                clr.l   $18(a5)
                cmpi.w  #$100,(BossCombatCounter).w
                bgt.s   EntityType1C0_ResetDisableCollision
                move.b  #$C0,$4B(a5)
                move.w  #$A,4(a5)
EntityType1C0_ResetDisableCollision:                    ; CODE XREF: EntityType1C0_ResetForAttack+16   j  ; was: loc_40E86
                bsr.w   EntityType1C0_DisableCollision
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_ResetForAttack
; Increments the shared battle counter before the idle update
EntityType1C0_IncreaseSharedCounterState:               ; DATA XREF: ROM:00040D0C   o  ; was: sub_40E8E
                addi.w  #2,(BossCombatCounter).w
                clr.w   d3
                bsr.w   EntityType1C0_CalculateAngleAndFlip
; End of function EntityType1C0_IncreaseSharedCounterState
; Handles idle behavior with animation and distance-based attack selection
EntityType1C0_IdleState:                                ; DATA XREF: ROM:00040D0A   o  ; was: sub_40E9A
                subq.b  #1,$4B(a5)
                beq.w   EntityType1C0_ChooseAttack
                bsr.w   EntityType1C0_CalculateVerticalVelocity
                move.b  #0,6(a5)
                bsr.w   EntityType1C0_InterpolateRotation
                move.b  #0,$4A(a5)
                btst    #4,$4B(a5)
                beq.w   EntityType1C0_UpdateGraphics
                move.b  #4,$4A(a5)
                bra.w   EntityType1C0_UpdateGraphics
; ---------------------------------------------------------------------------
EntityType1C0_ChooseAttack:                             ; CODE XREF: EntityType1C0_IdleState+4   j  ; was: loc_40ECA
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$80,d0
                bcs.s   EntityType1C0_CloseRangeAttack
                lea     EntityType1C0_DistantAttackChoices(pc),a0
                jmp     Math_JumpToWeightedChoice
; End of function EntityType1C0_IdleState
; ---------------------------------------------------------------------------
EntityType1C0_DistantAttackChoices:
                dc.w    $7800                           ; DATA XREF: EntityType1C0_IdleState+3C   o  ; was: word_40EE0
                dc.w    EntityType1C0_BeginSerpentineCycle-*
                dc.w    $7000
                dc.w    EntityType1C0_BeginDashCycle-*
                dc.w    $1000
                dc.w    EntityType1C0_BeginWobble-*
                dc.w    $800
                dc.w    EntityType1C0_BeginRotationRecovery-*

; Selects random attack pattern when player is close
EntityType1C0_CloseRangeAttack:                         ; CODE XREF: EntityType1C0_IdleState+3A   j  ; was: sub_40EF0
                lea     EntityType1C0_CloseAttackChoices(pc),a0
                jmp     Math_JumpToWeightedChoice
; End of function EntityType1C0_CloseRangeAttack
; ---------------------------------------------------------------------------
EntityType1C0_CloseAttackChoices:
                dc.w    $A000                           ; DATA XREF: EntityType1C0_CloseRangeAttack   o  ; was: word_40EFA
                dc.w    EntityType1C0_BeginRotationRecovery-*
                dc.w    $8000
                dc.w    EntityType1C0_BeginDiveWindup-*

; Calculates horizontal screen offset based on boss position and velocity direction
EntityType1C0_CalculateScreenOffset:                    ; CODE XREF: EntityType1C0_DashAttack+6E   p  ; was: sub_40F02
                                        ; EntityType1C0_DashAttack+7E   p
                move.w  (PrimaryCameraXPosition).w,d0
                add.w   $10(a5),d0
                tst.w   $18(a5)
                bpl.s   EntityType1C0_MeasureRightBoundary
                subi.w  #$400,d0
                rts
; ---------------------------------------------------------------------------
EntityType1C0_MeasureRightBoundary:                     ; CODE XREF: EntityType1C0_CalculateScreenOffset+C   j  ; was: loc_40F16
                move.w  #$600,d1
                sub.w   d0,d1
                rts
; End of function EntityType1C0_CalculateScreenOffset
; Disables collision flag for all 5 boss body segments
EntityType1C0_DisableCollision:                         ; CODE XREF: EntityType1C0_ResetForAttack:EntityType1C0_ResetDisableCollision   p  ; was: sub_40F1E
                andi.b  #$BF,$201(a5)
                andi.b  #$BF,$3E1(a5)
                andi.b  #$BF,$5C1(a5)
                andi.b  #$BF,$7A1(a5)
                andi.b  #$BF,$921(a5)
                rts
; End of function EntityType1C0_DisableCollision
; Enables collision flag for all 5 boss body segments
EntityType1C0_EnableCollision:                          ; CODE XREF: EntityType1C0_BeginDashCycle+12   p  ; was: sub_40F3E
                                        ; EntityType1C0_BeginDiveWindup+12   p
                ori.b   #$40,$201(a5)                   ; '@'
                ori.b   #$40,$3E1(a5)                   ; '@'
                ori.b   #$40,$5C1(a5)                   ; '@'
                ori.b   #$40,$7A1(a5)                   ; '@'
                ori.b   #$40,$921(a5)                   ; '@'
                rts
; End of function EntityType1C0_EnableCollision
; Starts the repeated dash cycle
EntityType1C0_BeginDashCycle:                           ; DATA XREF: ROM:00040EE6   o  ; was: sub_40F5E
                move.w  #$C,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                move.b  #4,$4A(a5)
                bsr.s   EntityType1C0_EnableCollision
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_BeginDashCycle
; Executes dashing movement pattern with trajectory calculations
EntityType1C0_DashAttack:                               ; DATA XREF: ROM:00040D0E   o  ; was: sub_40F76
                move.w  #0,d3
                bsr.w   EntityType1C0_CalculateAngleAndFlip
                bsr.w   EntityType1C0_InterpolateRotation
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_UpdateGraphics
                move.b  #0,$4A(a5)
                addq.w  #2,4(a5)
                move.b  #$C,$4B(a5)
                clr.w   d0
                btst    #3,$E(a5)
                bne.s   EntityType1C0_DashStoreInitialAngle
                move.w  #$100,d0
EntityType1C0_DashStoreInitialAngle:                    ; CODE XREF: EntityType1C0_DashAttack+2C   j  ; was: loc_40FA8
                move.w  d0,6(a5)
; Move toward target using calculated trajectory
EntityType1C0_DashAttack_MoveToward:                    ; DATA XREF: ROM:00040D10   o  ; was: loc_40FAC
                                        ; ROM:00040D14   o
                move.w  #2,d2
                bsr.w   EntityType1C0_CalculateTrajectory
                add.l   d1,$18(a5)
                add.l   d0,$1C(a5)
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_UpdateGraphics
                move.b  #$C,$4B(a5)
                addq.w  #2,4(a5)
                move.b  #4,$4A(a5)
; Move away from target with screen boundary check
EntityType1C0_DashAttack_MoveAway:                      ; DATA XREF: ROM:00040D12   o  ; was: loc_40FD4
                                        ; ROM:00040D16   o
                move.w  #2,d2
                bsr.w   EntityType1C0_CalculateTrajectory
                sub.l   d1,$18(a5)
                sub.l   d0,$1C(a5)
                bsr.w   EntityType1C0_CalculateScreenOffset
                bcs.w   EntityType1C0_ResetForAttack
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_UpdateGraphics
                bsr.w   EntityType1C0_CalculateScreenOffset
                bcs.w   EntityType1C0_ResetForAttack
                move.b  #$C,$4B(a5)
                addq.w  #2,4(a5)
                move.b  #0,$4A(a5)
                subi.w  #$40,(BossCombatCounter).w      ; '@'
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_DashAttack
; Starts the dive windup state
EntityType1C0_BeginDiveWindup:                          ; DATA XREF: ROM:00040F00   o  ; was: sub_41016
                move.w  #$18,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                move.b  #4,$4A(a5)
                bsr.w   EntityType1C0_EnableCollision
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_BeginDiveWindup
; Prepares boss dive attack by setting timer and adjusting screen offset
EntityType1C0_PrepareDive:                              ; DATA XREF: ROM:00040D1A   o  ; was: sub_41030
                move.w  #$20,d3                         ; ' '
                bsr.w   EntityType1C0_CalculateAngleAndFlip
                bsr.w   EntityType1C0_InterpolateRotation
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_UpdateGraphics
                move.b  #6,$4A(a5)
                addq.w  #2,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                subi.w  #$50,(BossCombatCounter).w      ; 'P'
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_PrepareDive
; Waits for timer countdown before resetting attack state
EntityType1C0_TimerWait:                                ; DATA XREF: ROM:00040D1C   o  ; was: sub_4105E
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_UpdateGraphics
                bra.w   EntityType1C0_ResetForAttack
; End of function EntityType1C0_TimerWait
; Starts the serpentine movement cycle
EntityType1C0_BeginSerpentineCycle:                     ; DATA XREF: ROM:00040EE2   o  ; was: sub_4106A
                move.w  #$1C,4(a5)
                move.b  #$30,$4B(a5)                    ; '0'
                move.b  #8,$4A(a5)
                clr.l   $1C(a5)
                bsr.w   EntityType1C0_EnableCollision
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_BeginSerpentineCycle
; Performs serpentine movement pattern with trajectory reversals
EntityType1C0_SerpentineAttack:                         ; DATA XREF: ROM:00040D1E   o  ; was: sub_41088
                move.w  #2,d2
                bsr.w   EntityType1C0_CalculateTrajectory
                neg.l   d1
                neg.l   d0
                move.l  d1,$18(a5)
                move.l  #$C00000,d0
                sub.l   $14(a5),d0
                asr.l   #2,d0
                move.l  d0,$1C(a5)
                move.w  #$40,d3                         ; '@'
                bsr.w   EntityType1C0_CalculateAngleAndFlip
                bsr.w   EntityType1C0_InterpolateRotation
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_UpdateGraphics
                addq.w  #2,4(a5)
                move.b  #$10,$4B(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
; Serpentine pattern movement toward target
EntityType1C0_SerpentineAttack_MoveIn:                  ; DATA XREF: ROM:00040D20   o  ; was: loc_410CE
                move.w  #2,d2
                bsr.w   EntityType1C0_CalculateTrajectory
                add.l   d1,$18(a5)
                add.l   d0,$1C(a5)
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_SerpentineCheckBounds
                addq.w  #2,4(a5)
                move.b  #$10,$4B(a5)
                subi.w  #$140,(BossCombatCounter).w
; Serpentine pattern movement away from target
EntityType1C0_SerpentineAttack_MoveOut:                 ; DATA XREF: ROM:00040D22   o  ; was: loc_410F6
                move.w  #2,d2
                bsr.w   EntityType1C0_CalculateTrajectory
                sub.l   d1,$18(a5)
                sub.l   d0,$1C(a5)
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_SerpentineCheckBounds
                bra.w   EntityType1C0_ResetForAttack
; ---------------------------------------------------------------------------
EntityType1C0_SerpentineCheckBounds:                    ; CODE XREF: EntityType1C0_SerpentineAttack+5A   j  ; was: loc_41112
                                        ; EntityType1C0_SerpentineAttack+82   j
                bsr.w   EntityType1C0_CalculateScreenOffset
                bcs.w   EntityType1C0_ResetForAttack
                cmpi.w  #$110,$14(a5)
                bcs.w   EntityType1C0_UpdateGraphics
                move.w  #4,(PlaneAShakeLevel).w
                move.w  #4,(PlaneBShakeLevel).w
                neg.l   $1C(a5)
                bra.w   *+4
; End of function EntityType1C0_SerpentineAttack
; Recovers from attack by setting state timer and enabling collision
EntityType1C0_BeginRotationRecovery:                    ; CODE XREF: EntityType1C0_SerpentineAttack+AC   j  ; was: sub_41138
                                        ; EntityType1C0_WobbleRotation+1C   j
                                        ; DATA XREF:
                move.w  #$22,4(a5)                      ; '"'
                move.b  #$38,$4B(a5)                    ; '8'
                move.b  #$A,$4A(a5)
                subi.w  #$148,(BossCombatCounter).w
                bsr.w   EntityType1C0_EnableCollision
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_BeginRotationRecovery
; Decelerates rotation angle and resets attack when timer expires
EntityType1C0_RotationDecelerate:                       ; DATA XREF: ROM:00040D24   o  ; was: sub_41158
                addi.w  #$C,$56(a5)
                subq.b  #1,$4B(a5)
                beq.w   EntityType1C0_ResetForAttack
                move.l  $18(a5),d0
                asr.l   #4,d0
                sub.l   d0,$18(a5)
                bsr.w   EntityType1C0_CalculateVerticalVelocity
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_RotationDecelerate
; Starts the timed wobble state
EntityType1C0_BeginWobble:                              ; DATA XREF: ROM:00040EEA   o  ; was: sub_41178
                move.w  #$24,4(a5)                      ; '$'
                move.b  #$60,$4B(a5)                    ; '`'
                move.b  #6,$4A(a5)
                clr.l   $1C(a5)
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_BeginWobble
; Applies wobbling rotation effect using sine wave pattern
EntityType1C0_WobbleRotation:                           ; DATA XREF: ROM:00040D26   o  ; was: sub_41192
                move.b  $4B(a5),d4
                lsr.w   #2,d4
                andi.w  #7,d4
                move.b  EntityType1C0_WobbleAngleDeltas(pc,d4.w),d4
                ext.w   d4
                add.w   d4,$56(a5)
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_UpdateGraphics
                bra.s   EntityType1C0_BeginRotationRecovery
; End of function EntityType1C0_WobbleRotation
; ---------------------------------------------------------------------------
EntityType1C0_WobbleAngleDeltas:
                dc.w    $FFFD, $FCFF, $103, $401, $49ED, $60, $363C, 4  ; was: word_411B0
                                        ; DATA XREF: EntityType1C0_WobbleRotation+A   r

; Spawns multiple projectile debris with randomized trajectories
EntityType1C0_SpawnDebris:                              ; CODE XREF: EntityType1C0_SpawnDebris+5E   j  ; was: sub_411C0
                jsr     (Projectile_FindFreeSlotForward).l
                bne.s   EntityType1C0_FinishDebrisSpawn
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
                dbf     d3,EntityType1C0_SpawnDebris
EntityType1C0_FinishDebrisSpawn:                        ; CODE XREF: EntityType1C0_SpawnDebris+6   j  ; was: loc_41222
                bra.w   EntityType1C0_ResetForAttack
; End of function EntityType1C0_SpawnDebris
; Calculates movement trajectory using sine/cosine lookup table
EntityType1C0_CalculateTrajectory:                      ; CODE XREF: EntityType1C0_DashAttack+3A   p  ; was: sub_41226
                                        ; EntityType1C0_DashAttack+62   p
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
                beq.s   EntityType1C0_ScaleTrajectory
                neg.w   d1
EntityType1C0_ScaleTrajectory:                          ; CODE XREF: EntityType1C0_CalculateTrajectory+26   j  ; was: loc_41250
                ext.l   d0
                ext.l   d1
                asl.l   d2,d0
                asl.l   d2,d1
                rts
; End of function EntityType1C0_CalculateTrajectory
; Checks distance to player and sets horizontal flip bit
EntityType1C0_CheckFlipDirection:
                andi.w  #$F7FF,$E(a5)                   ; was: sub_4125A
                jsr     (Physics_GetPlayerDelta).l
                tst.w   d1
                bpl.s   EntityType1C0_CheckFlipReturn
                ori.w   #$800,$E(a5)
EntityType1C0_CheckFlipReturn:                          ; CODE XREF: EntityType1C0_CheckFlipDirection+E   j  ; was: locret_41270
                rts
; End of function EntityType1C0_CheckFlipDirection
; Calculates angle to player with flip flag
EntityType1C0_CalculateAngleAndFlip:                    ; CODE XREF: EntityType1C0_IncreaseSharedCounterState+8   p  ; was: sub_41272
                                        ; EntityType1C0_DashAttack+4   p
                andi.w  #$F7FF,$E(a5)
                movem.l d3,-(sp)
                lea     (PlayerObjectType).w,a4
                jsr     (Physics_CalculateAngleToTarget).l
                movem.l (sp)+,d3
                move.b  d0,d2
                bpl.s   EntityType1C0_StoreAimOffset
                ori.w   #$800,$E(a5)
                neg.b   d2
EntityType1C0_StoreAimOffset:                           ; CODE XREF: EntityType1C0_CalculateAngleAndFlip+1A   j  ; was: loc_41296
                move.w  d3,$5A(a5)
; End of function EntityType1C0_CalculateAngleAndFlip
; Applies angle offset to boss orientation register
EntityType1C0_ApplyAngleOffset:
                add.w   $5A(a5),d2                      ; was: sub_4129A
                move.w  d2,6(a5)
                rts
; End of function EntityType1C0_ApplyAngleOffset
; Interpolates rotation angle towards target smoothly
EntityType1C0_InterpolateRotation:                      ; CODE XREF: EntityType1C0_IdleState+12   p  ; was: sub_412A4
                                        ; EntityType1C0_DashAttack+8   p
                move.w  $56(a5),d1
                lsr.w   #1,d1
                move.w  6(a5),d0
                sub.b   d1,d0
                asr.b   #2,d0
                ext.w   d0
                add.w   d0,$56(a5)
                rts
; End of function EntityType1C0_InterpolateRotation
; Calculates vertical velocity using sine wave for hovering
EntityType1C0_CalculateVerticalVelocity:                ; CODE XREF: EntityType1C0_WaitForIntroMessageState+18   p  ; was: sub_412BA
                                        ; EntityType1C0_IdleState+8   p
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
; End of function EntityType1C0_CalculateVerticalVelocity
; Updates boss sprite graphics based on animation frame counter
EntityType1C0_UpdateGraphics:                           ; CODE XREF: EntityType1C0_WaitForIntroMessageState:EntityType1C0_IntroRender   j  ; was: sub_412E6
                                        ; EntityType1C0_ResetForAttack+28   j
                bsr.w   EntityType1C0_UpdatePartAngles
                btst    #2,(BossColorEffectFlags).w
                bne.s   EntityType1C0_UpdateBodyGraphics
                btst    #1,(BossColorEffectFlags).w
                bne.s   EntityType1C0_UpdateBodyGraphics
                tst.w   (BossHealth).w
                beq.w   EntityType1C0_BeginEarlyFormDefeatState
EntityType1C0_UpdateBodyGraphics:                       ; CODE XREF: EntityType1C0_UpdateGraphics+A   j  ; was: loc_41302
                                        ; EntityType1C0_UpdateGraphics+12   j
                lea     EntityType1C0_BodyPartInitTable(pc),a1
                jsr     EntityType1C0_UpdateBodyPartPositions(pc)  ; (pc)
                nop
                bsr.w   EntityType1C0_UpdateCameraOffset
                lea     EntityType1C0_PrimaryTileAnimationOffsets(pc),a0
                move.w  (PrimaryEntityWork5E).w,d0
                lsr.w   #3,d0
                bsr.w   EntityType1C0_LoadTileTableEntry
                lea     EntityType1C0_EarlyFormTileLoadCommands+$24(pc),a0
                move.w  (PrimaryEntityWork5E).w,d0
                lsr.w   #2,d0
                bsr.w   EntityType1C0_LoadTileTableEntry
                addq.w  #1,(PrimaryEntityWork5E).w
                rts
; End of function EntityType1C0_UpdateGraphics
; Loads compressed tile data from indexed table entry
EntityType1C0_LoadTileTableEntry:                       ; CODE XREF: EntityType1C0_UpdateGraphics+34   p  ; was: sub_41332
                                        ; EntityType1C0_UpdateGraphics+42   p
                and.w   (a0)+,d0
                adda.w  d0,a0
                adda.w  (a0),a0
                jmp     Tilemap_QueueIndexedRows
; End of function EntityType1C0_LoadTileTableEntry
; Starts the early form's defeat transition when shared health reaches zero
EntityType1C0_BeginEarlyFormDefeatState:                ; CODE XREF: EntityType1C0_UpdateGraphics+18   j  ; was: sub_4133E
                move.b  #1,(SoundFadeOutDelay).w
                bset    #0,(StageTimerPauseFlag).w
                move.b  #2,(BossColorEffectFlags).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #4,(PlaneAShakeLevel).w
                move.w  #4,(PlaneBShakeLevel).w
                move.b  #0,$4A(a5)
                move.w  #$26,4(a5)                      ; '&'
                move.b  #8,$4B(a5)
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                bra.w   EntityType1C0_UpdateGraphics
; End of function EntityType1C0_BeginEarlyFormDefeatState
; Converts the body parts to debris with randomized velocities
EntityType1C0_ScatterBodyPartsState:                    ; DATA XREF: ROM:00040D28   o  ; was: sub_41384
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_UpdateGraphics
                addq.w  #2,4(a5)
                clr.b   $21(a5)
                move.w  (PrimaryEntityWork5C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
                lea     (Math_SineTable).l,a2
EntityType1C0_InitializeDebrisPart:                     ; CODE XREF: EntityType1C0_ScatterBodyPartsState+6E   j  ; was: loc_413A4
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
                dbf     d4,EntityType1C0_InitializeDebrisPart
; Spawn projectiles while rising until screen threshold
EntityType1C0_RiseAndSpawnProjectilesState:             ; DATA XREF: ROM:00040D2A   o  ; was: loc_413F6
                addi.l  #$800,$1C(a5)
                cmpi.w  #$1C0,$14(a5)
                bhi.s   EntityType1C0_BeginStaggeredDebrisCleanup
                move.l  #$200020,d1
                bsr.w   EntityType1C0_SpawnRandomOffsetProjectile
                bsr.w   EntityType1C0_UpdateCameraOffset
                rts
; ---------------------------------------------------------------------------
EntityType1C0_BeginStaggeredDebrisCleanup:              ; CODE XREF: EntityType1C0_ScatterBodyPartsState+80   j  ; was: loc_41416
                move.b  #$40,$4B(a5)                    ; '@'
                addq.w  #2,4(a5)
                move.w  #1,d5
                move.w  (PrimaryEntityWork5C).w,d4
                subq.w  #2,d4
                lea     $60(a5),a4
EntityType1C0_SeedDebrisCleanupDelay:                   ; CODE XREF: EntityType1C0_ScatterBodyPartsState+B4   j  ; was: loc_4142E
                move.b  d5,$4B(a4)
                addq.w  #1,d5
                lea     $60(a4),a4
                dbf     d4,EntityType1C0_SeedDebrisCleanupDelay
                rts
; End of function EntityType1C0_ScatterBodyPartsState
; Retires the controller after its defeat cleanup timer expires
EntityType1C0_DefeatCleanupState:                       ; DATA XREF: ROM:00040D2C   o  ; was: sub_4143E
                move.w  #4,(PlaneAShakeLevel).w
                move.w  #4,(PlaneBShakeLevel).w
                subq.b  #1,$4B(a5)
                bne.w   EntityType1C0_FadeOutReturn
                clr.w   (a5)
EntityType1C0_FadeOutReturn:                            ; CODE XREF: EntityType1C0_DefeatCleanupState+10   j  ; was: locret_41454
                rts
; End of function EntityType1C0_DefeatCleanupState
; Updates one body-part debris object and retires it after its delay
EntityType1C0_DebrisPartMain:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_41456
                tst.b   $4B(a5)
                beq.s   EntityType1C0_DebrisPartUpdateAnimation
                subq.b  #1,$4B(a5)
                beq.s   EntityType1C0_DebrisPartRemove
EntityType1C0_DebrisPartUpdateAnimation:                ; CODE XREF: EntityType1C0_DebrisPartMain+4   j  ; was: loc_41462
                move.w  $5C(a5),d0
                add.w   d0,$56(a5)
                move.l  $50(a5),d0
                beq.s   EntityType1C0_DebrisPartReturn
                movea.l d0,a1
                move.w  $56(a5),d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a5)
EntityType1C0_DebrisPartReturn:                         ; CODE XREF: EntityType1C0_DebrisPartMain+18   j  ; was: locret_41482
                rts
; ---------------------------------------------------------------------------
EntityType1C0_DebrisPartRemove:                         ; CODE XREF: EntityType1C0_DebrisPartMain+A   j  ; was: loc_41484
                lea     (a5),a0
                jsr     (Effect_InitSharedExplosion).l
                clr.b   $21(a5)
                rts
; End of function EntityType1C0_DebrisPartMain
; Spawns projectile with randomized position offset
EntityType1C0_SpawnRandomOffsetProjectile:              ; CODE XREF: EntityType1C0_RiseAndSpawnProjectilesState+E   p  ; was: sub_41492
                                        ; EntityType1C0_DescendAndActivateChainsState+E   p
                move.l  d1,-(sp)
                jsr     (Projectile_PrepareImpactSpawn).l
                bne.s   EntityType1C0_SpawnRandomOffsetProjectileReturn
                jsr     (Sprite_InitFromTable).l
                clr.b   $20(a0)
                move.l  $18(a5),$18(a0)
                move.l  $1C(a5),$1C(a0)
                neg.l   $18(a0)
                neg.l   $1C(a0)
                move.b  (RandomNumberState).w,d0
                move.b  (RandomNumberState+1).w,d1
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
EntityType1C0_SpawnRandomOffsetProjectileReturn:        ; CODE XREF: EntityType1C0_SpawnRandomOffsetProjectile+8   j  ; was: loc_414EA
                move.l  (sp)+,d1
                rts
; End of function EntityType1C0_SpawnRandomOffsetProjectile
; Calculates camera offset relative to boss position
EntityType1C0_UpdateCameraOffset:                       ; CODE XREF: EntityType1C0_UpdateGraphics+26   p  ; was: sub_414EE
                                        ; EntityType1C0_RiseAndSpawnProjectilesState+12   p
                move.w  #$A4,d0
                sub.w   $10(a5),d0
                move.w  d0,(SecondaryCameraXPos).w
                move.w  $14(a5),d0
                addi.w  #$4C,d0                         ; 'L'
                move.w  d0,(SecondaryCameraYPos).w
                jmp     Boss_ClampSharedScreenPosition
; End of function EntityType1C0_UpdateCameraOffset
; Updates animation angles for boss body parts
EntityType1C0_UpdatePartAngles:                         ; CODE XREF: EntityType1C0_UpdateGraphics   p  ; was: sub_4150C
                move.b  $4A(a5),d0
                andi.w  #$E,d0
                lea     EntityType1C0_BodyPartAngleSequences(pc),a1
                adda.w  d0,a1
                adda.w  (a1),a1
                lea     $60(a5),a4
EntityType1C0_ReadAngleSequence:                        ; CODE XREF: EntityType1C0_UpdatePartAngles+38   j  ; was: loc_41520
                move.w  (a1)+,d0
                beq.s   EntityType1C0_UpdatePartAnglesReturn
                lea     -2(a1,d0.w),a0
                move.w  (a0)+,d3
EntityType1C0_InterpolatePartAngle:                     ; CODE XREF: EntityType1C0_UpdatePartAngles+34   j  ; was: loc_4152A
                move.w  (a0)+,d0
                bmi.s   EntityType1C0_AdvancePartAngleSlot
                ext.w   d0
                add.w   d0,d0
                sub.w   $56(a4),d0
                asr.w   #3,d0
                add.w   d0,$56(a4)
EntityType1C0_AdvancePartAngleSlot:                     ; CODE XREF: EntityType1C0_UpdatePartAngles+20   j  ; was: loc_4153C
                lea     $60(a4),a4
                dbf     d3,EntityType1C0_InterpolatePartAngle
                bra.s   EntityType1C0_ReadAngleSequence
; ---------------------------------------------------------------------------
EntityType1C0_UpdatePartAnglesReturn:                   ; CODE XREF: EntityType1C0_UpdatePartAngles+16   j  ; was: locret_41546
                rts
; End of function EntityType1C0_UpdatePartAngles
; ---------------------------------------------------------------------------
EntityType1C0_PartAnimationMappings:
                dc.l    EntityType1C0_PartAnimationMapping0
                dc.l    EntityType1C0_PartAnimationMapping1
                dc.l    EntityType1C0_PartAnimationMapping2
                dc.l    EntityType1C0_PartAnimationMapping3
                dc.l    EntityType1C0_PartAnimationMapping4
                dc.l    EntityType1C0_PartAnimationMapping5
                dc.l    EntityType1C0_PartAnimationMapping6
                dc.l    EntityType1C0_PartAnimationMapping7
EntityType1C0_BodyPartInitTable:                        ; was: word_41568
                                        ; DATA XREF: EntityType1C0_LoadGraphics+28   o
                                        ; EntityType1C0_UpdateGraphics:EntityType1C0_UpdateBodyGraphics   o
; The constructor consumes longwords. High bits carry control flags; pointer
; payloads must remain symbolic so relocation adjusts the low 24 bits
                dc.l    EntityType1C0_PartAnimationMapping6
                dc.l    $800000
                dc.l    $80000001
                dc.l    $20000000+EntityType1C0_EarlyFormPartMapping
                dc.l    $830140
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $4300A0
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $4A0000
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $610060
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $600060
                dc.l    $80000000
                dc.l    $80000001
                dc.l    $20000000+EntityType1C0_EarlyFormPartMapping
                dc.l    $830160
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $430070
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $4A0000
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $610050
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $600050
                dc.l    $80000000
                dc.l    $80000001
                dc.l    $20000000+EntityType1C0_EarlyFormPartMapping
                dc.l    $830180
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $430060
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $4A0000
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $610060
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $600060
                dc.l    $80000000
                dc.l    $80000001
                dc.l    $20000000+EntityType1C0_EarlyFormPartMapping
                dc.l    $8301A0
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $430030
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $4A0000
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $610050
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $600050
                dc.l    $80000000
                dc.l    $80000001
                dc.l    $20000000+EntityType1C0_EarlyFormPartMapping
                dc.l    $A30020
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $43FFB0
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $4A0000
                dc.l    $60000000+EntityType1C0_PartAnimationMappings
                dc.l    $49FFA0
                dc.l    $80000000
                dc.l    $80000000
EntityType1C0_BodyPartAngleSequences:
                binclude "data/other/entity_type_1c0_body_part_angle_sequences.bin"  ; was: word_4165C
EntityType1C0_BodyPartAngleSequences_End:               ; was: word_4165C_End

; Initializes boss body part sprites from pointer table
EntityType1C0_InitBodyParts:                            ; CODE XREF: EntityType1C0_LoadGraphics+2E   p  ; was: sub_417D8
                                        ; EntityType1C0_SecondFormLoadGraphicsState+2E   p
                clr.w   d7
                movea.l a5,a3
                clr.l   -(sp)
                move.w  $E(a5),d5
EntityType1C0_ReadBodyPartDescriptor:                   ; CODE XREF: EntityType1C0_InitBodyParts+18   j  ; was: loc_417E2
                                        ; EntityType1C0_InitBodyParts+20   j
                move.l  (a1)+,d4
                bpl.s   EntityType1C0_InitializeBodyPart
                andi.l  #$7FFFFFFF,d4
                beq.s   EntityType1C0_FinishBodyPartChain
                move.l  a5,-(sp)
                bra.s   EntityType1C0_ReadBodyPartDescriptor
; ---------------------------------------------------------------------------
EntityType1C0_FinishBodyPartChain:                      ; CODE XREF: EntityType1C0_InitBodyParts+14   j  ; was: loc_417F2
                move.l  (sp)+,d0
                beq.s   EntityType1C0_FinishBodyPartInitialization
                movea.l d0,a5
                bra.s   EntityType1C0_ReadBodyPartDescriptor
; ---------------------------------------------------------------------------
EntityType1C0_InitializeBodyPart:                       ; CODE XREF: EntityType1C0_InitBodyParts+C   j  ; was: loc_417FA
                move.w  d5,$E(a4)
                move.b  #$C0,$20(a4)
                bclr    #$1E,d4
                bne.s   EntityType1C0_StorePartAnimationMappings
                move.l  d4,8(a4)
                clr.l   $50(a4)
                bra.s   EntityType1C0_ConfigureBodyPart
; ---------------------------------------------------------------------------
EntityType1C0_StorePartAnimationMappings:               ; CODE XREF: EntityType1C0_InitBodyParts+30   j  ; was: loc_41814
                move.l  d4,$50(a4)
EntityType1C0_ConfigureBodyPart:                        ; CODE XREF: EntityType1C0_InitBodyParts+3A   j  ; was: loc_41818
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
                bra.s   EntityType1C0_ReadBodyPartDescriptor
; ---------------------------------------------------------------------------
EntityType1C0_FinishBodyPartInitialization:             ; CODE XREF: EntityType1C0_InitBodyParts+1C   j  ; was: loc_41852
                move.w  d7,(PrimaryEntityWork5C).w
                lea     (a3),a5
                clr.w   $4E(a5)
                rts
; End of function EntityType1C0_InitBodyParts
; Updates positions of all boss body parts using sine/cosine
EntityType1C0_UpdateBodyPartPositions:                  ; CODE XREF: EntityType1C0_UpdateGraphics+20   p  ; was: sub_4185E
                                        ; EntityType1C0_SecondFormUpdate+78   p
                move.w  (PrimaryEntityWork5C).w,d7
                subq.w  #1,d7
                lea     $60(a5),a4
                movea.l #Math_SineTable,a2
                movem.l a5,-(sp)
                btst    #3,$E(a5)
                lea     EntityType1C0_ApplyParentOffset(pc),a5
                beq.s   EntityType1C0_UpdateBodyPart
                lea     EntityType1C0_FlipHorizontal(pc),a5
EntityType1C0_UpdateBodyPart:                           ; CODE XREF: EntityType1C0_UpdateBodyPartPositions+1E   j  ; was: loc_41882
                                        ; EntityType1C0_ApplyParentOffset+18   j
                andi.w  #$F7FF,$E(a4)
                move.w  $56(a4),d6
                lea     (a4),a0
EntityType1C0_AccumulateParentAngles:                   ; CODE XREF: EntityType1C0_UpdateBodyPartPositions+3C   j  ; was: loc_4188E
                move.w  $4E(a0),d0
                beq.s   EntityType1C0_SelectPartMapping
                movea.w d0,a0
                add.w   $56(a0),d6
                bra.s   EntityType1C0_AccumulateParentAngles
; ---------------------------------------------------------------------------
EntityType1C0_SelectPartMapping:                        ; CODE XREF: EntityType1C0_UpdateBodyPartPositions+34   j  ; was: loc_4189C
                move.l  $50(a4),d0
                beq.s   EntityType1C0_CalculatePartPosition
                movea.l d0,a1
                move.w  d6,d1
                move.w  #$F8,d0
                sub.w   d1,d0
                lsr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a1,d0.w),8(a4)
EntityType1C0_CalculatePartPosition:                    ; CODE XREF: EntityType1C0_UpdateBodyPartPositions+42   j  ; was: loc_418B8
                move.w  d6,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  $4C(a4),d0
                muls.w  $4C(a4),d1
                jmp     (a5)
; End of function EntityType1C0_UpdateBodyPartPositions
; Negates values and flips horizontal sprite flag
EntityType1C0_FlipHorizontal:                           ; DATA XREF: EntityType1C0_UpdateBodyPartPositions+20   o  ; was: sub_418D2
                neg.l   d1
                eori.w  #$800,$E(a4)
; End of function EntityType1C0_FlipHorizontal
; Adds parent part position offsets to child body part
EntityType1C0_ApplyParentOffset:                        ; DATA XREF: EntityType1C0_UpdateBodyPartPositions+1A   o  ; was: sub_418DA
                movea.w $4E(a4),a3
                add.l   $10(a3),d1
                move.l  d1,$10(a4)
                add.l   $14(a3),d0
                move.l  d0,$14(a4)
                lea     $60(a4),a4
                dbf     d7,EntityType1C0_UpdateBodyPart
                movem.l (sp)+,a5
                rts
; End of function EntityType1C0_ApplyParentOffset
