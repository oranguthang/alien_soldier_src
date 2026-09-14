; Runs Shiper's encounter state machine and shared visual state
Boss_ShiperMainHandler:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3641A
                move.w  (VScrollPlaneBColumn0).w,(VScrollPlaneAColumn1).w
                tst.w   4(a5)
                beq.s   Boss_ShiperDispatchState
                tst.w   6(a5)
                beq.s   Boss_ShiperDispatchState
                btst    #2,(BossColorEffectFlags).w
                bne.s   Boss_ShiperUpdateActiveState
                btst    #1,(BossColorEffectFlags).w
                bne.s   Boss_ShiperUpdateActiveState
                tst.w   (BossHealth).w
                bne.s   Boss_ShiperUpdateActiveState
                bset    #0,(StageTimerPauseFlag).w
                bra.w   Boss_ShiperBeginDefeat
; ---------------------------------------------------------------------------
Boss_ShiperUpdateActiveState:                           ; CODE XREF: Boss_ShiperMainHandler+18   j  ; was: loc_3644C
                                        ; Boss_ShiperMainHandler+20   j
                jsr     (Gfx_ProcessDefaultColorFade).l
                clr.b   $49(a5)
                move.w  (PrimaryCameraXPosition).w,d0
                add.w   $10(a5),d0
                move.w  d0,$58(a5)
                addi.l  #$6000,$7C(a5)
                bmi.s   Boss_ShiperDispatchState
                cmpi.w  #$150,$74(a5)
                bmi.s   Boss_ShiperDispatchState
                clr.l   $7C(a5)
                move.w  #$150,$74(a5)
                tst.w   (PlaneAShakeLevel).w
                bne.s   Boss_ShiperDispatchState
                move.w  #1,(PlaneAShakeLevel).w
Boss_ShiperDispatchState:                               ; CODE XREF: Boss_ShiperMainHandler+A   j  ; was: loc_3648A
                                        ; Boss_ShiperMainHandler+10   j
                move.w  4(a5),d0
                movea.w Boss_ShiperStates(pc,d0.w),a0
                adda.l  #Boss_ShiperBeginEncounter,a0
                jmp     (a0)
; End of function Boss_ShiperMainHandler
; ---------------------------------------------------------------------------
Boss_ShiperStates:  dc.w    Boss_ShiperBeginEncounter-Boss_ShiperBeginEncounter  ; was: off_3649A
                                        ; DATA XREF: Boss_ShiperMainHandler+74   r
                dc.w    Boss_ShiperLoadInitialAssetsAfterBackgroundRows-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperQueueIndexedTileColumnsAfterAssets-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperInitializeEncounterEntities-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperSelectRotationPattern-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperUpdateAttackAndSpawnProjectile-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperBrakeNegativeSecondaryXVelocity-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperUpdateNegativeTravelCycle-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperBrakePositiveSecondaryXVelocity-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperUpdatePositiveTravelCycle-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperBrakeNegativeSecondaryXVelocity-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperUpdateNegativeTravelCycle-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperWaitForMotionThreshold-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperBossMessageDelayState-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperWaitForBossMessageState-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperWaitForDefeatMotionState-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperDefeatSequence-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperDefeatFadeOut-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperWaitForCounterRefillMotionThreshold-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperUpdateCombatCounterRefill-Boss_ShiperBeginEncounter

; Starts the encounter's background transition and removes unrelated objects
Boss_ShiperBeginEncounter:                              ; DATA XREF: Boss_ShiperStates   o  ; was: sub_364C2
                addq.w  #2,4(a5)
                addq.w  #1,6(a5)
                move.l  #Boss_ShiperBackgroundConfig,(TilemapTransferBase).w
                move.w  #0,(TilemapRowXOrFillWord).w
                move.w  #0,(TilemapRowYPosition).w
                move.w  #$13,(TilemapRowCountdown).w
                move.w  #$24,d0                         ; '$'
                move.w  #$134,d1
                jmp     Object_ClearEntityRecordsExceptTwoTypes
; End of function Boss_ShiperBeginEncounter
Boss_ShiperNoOp:
                rts                                     ; was: nullsub_77
; End of function Boss_ShiperNoOp
; ---------------------------------------------------------------------------
Boss_ShiperBackgroundConfig:    dc.w    $FFFF, $7000, $FFFF, $6800, $FFFF, $2000, 0, $4000  ; was: word_364F4
                                        ; DATA XREF: Boss_ShiperBeginEncounter+8   o

; Waits for the background-row stream, loads the initial asset descriptors, and
; builds the shared sine/cosine displacement tables
Boss_ShiperLoadInitialAssetsAfterBackgroundRows:        ; DATA XREF: ROM:0003649C   o  ; was: sub_36504
                jsr     (Tilemap_QueueNextScrollingRow).l
                bpl.s   Boss_ShiperLoadInitialAssetsAfterBackgroundRowsReturn
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                movea.l #Boss_ShiperInitialAssetDescriptors,a0
                jsr     (Data_ProcessPointer).l
                movem.l (sp)+,a5
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a0
                moveq   #$10,d0
                jmp     Math_CalculateSineCosineTable
; ---------------------------------------------------------------------------
Boss_ShiperLoadInitialAssetsAfterBackgroundRowsReturn:  ; CODE XREF: Boss_ShiperLoadInitialAssetsAfterBackgroundRows+6   j  ; was: locret_36530
                rts
; End of function Boss_ShiperLoadInitialAssetsAfterBackgroundRows
; ---------------------------------------------------------------------------
Boss_ShiperInitialAssetDescriptors: dc.w    7           ; field_0  ; was: stru_36532
                                        ; DATA XREF: Boss_ShiperLoadInitialAssetsAfterBackgroundRows+10   o
                dc.l    Boss_ShiperTileArt              ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedBossMappingData2020       ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF

; Waits for the asset loader, queues the indexed tile columns, and seeds the
; secondary camera X position
Boss_ShiperQueueIndexedTileColumnsAfterAssets:          ; DATA XREF: ROM:0003649E   o  ; was: sub_36544
                tst.w   (DataLoaderControl).w
                bmi.s   Boss_ShiperQueueIndexedTileColumnsAfterAssetsReturn
                addq.w  #2,4(a5)
                movea.l #Boss_ShiperTileDmaDescriptor,a0
                jsr     (Tilemap_QueueIndexedColumns).l
                move.w  #$80,(SecondaryCameraXPos).w
Boss_ShiperQueueIndexedTileColumnsAfterAssetsReturn:    ; CODE XREF: Boss_ShiperQueueIndexedTileColumnsAfterAssets+4   j  ; was: locret_36560
                rts
; End of function Boss_ShiperQueueIndexedTileColumnsAfterAssets
; ---------------------------------------------------------------------------
Boss_ShiperTileDmaDescriptor:   dc.w    $6100, $2000, $204, $708, $90A, $B0C, $D0E, $150F, $1011, $1213, $1400  ; was: word_36562
                                        ; DATA XREF: Boss_ShiperQueueIndexedTileColumnsAfterAssets+A   o

; Configures the encounter raster state and initializes Shiper's root,
; auxiliary, chain-part, and table-driven entity records
Boss_ShiperInitializeEncounterEntities:                 ; DATA XREF: ROM:000364A0   o  ; was: sub_36578
                move.w  #$14,4(a5)
                move.w  #4,$174(a5)
                addq.w  #2,(StageStateOffset).w
                move.w  #$24,(RasterEffectIndex).w      ; '$'
                clr.w   (RasterEffectInitState).w
                move.w  #$A,(RasterLayoutOffset).w
                move.b  #3,(PlaneBScrollModeFlags).w
                move.w  #8,$5A(a5)
                move.w  #2,$5C(a5)
                bset    #1,$5E(a5)
                move.w  #$258,$10(a5)
                move.w  #$258,$70(a5)
                move.w  #$150,$14(a5)
                move.w  #$150,$74(a5)
                move.w  #$C180,2(a5)
                move.w  #$CB00,$E(a5)
                move.l  #Boss_ShiperPrimarySpriteDescriptor,8(a5)
                move.b  #$30,$20(a5)                    ; '0'
                move.w  #$10,$60(a5)
                move.w  #$CD80,$62(a5)
                move.w  #$CB00,$6E(a5)
                move.l  #Boss_ShiperSecondarySpriteDescriptor,$68(a5)
                move.b  #$30,$80(a5)                    ; '0'
                movea.l #Boss_ShiperAuxiliaryPartDescriptors,a0
                moveq   #4,d7
Boss_ShiperInitializeNextAuxiliaryPart:                 ; CODE XREF: Boss_ShiperInitializeEncounterEntities+B0   j  ; was: loc_3660A
                movea.w (a0)+,a1
                move.w  #$10,(a1)
                move.w  #$8080,2(a1)
                move.b  #$80,$20(a1)
                move.w  (a0)+,$E(a1)
                move.w  (a0)+,8(a1)
                move.w  (a0)+,$A(a1)
                dbf     d7,Boss_ShiperInitializeNextAuxiliaryPart
                move.b  #$20,$260(a5)                   ; ' '
                move.b  #$20,$320(a5)                   ; ' '
                move.w  #$10,$1E0(a5)
                move.w  #$C080,$1E2(a5)
                move.b  #$28,$200(a5)                   ; '('
                move.w  #$10,$2A0(a5)
                move.w  #$C080,$2A2(a5)
                move.b  #$24,$2C0(a5)                   ; '$'
                movea.w #(TenthEntityType-M68K_RAM),a0
                moveq   #$30,d0                         ; '0'
                moveq   #5,d7
Boss_ShiperInitializeNextChainPart:                     ; CODE XREF: Boss_ShiperInitializeEncounterEntities+112   j  ; was: loc_36664
                move.w  #$10,(a0)
                move.w  #$8080,2(a0)
                move.b  d0,$20(a0)
                move.w  #$639E,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                lea     $60(a0),a0
                subq.w  #4,d0
                dbf     d7,Boss_ShiperInitializeNextChainPart
                move.w  #$63A7,$54E(a5)
                move.w  #$F00,$548(a5)
                move.w  #$F0F0,$54A(a5)
                movea.w #(SixteenthEntityType-M68K_RAM),a0
                move.w  #$10,(a0)
                movea.l #Boss_ShiperObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                bsr.w   Boss_ShiperUpdateTentaclesAndChainParts
                bra.w   Boss_ShiperUpdatePositionAndLineScroll
; End of function Boss_ShiperInitializeEncounterEntities
; ---------------------------------------------------------------------------
Boss_ShiperAuxiliaryPartDescriptors:    dc.w    $C6E0, $63B7, $500, $F8F8, $C7A0, $63BB, $900, $F4F8, $C740, $63C1  ; was: word_366BC
                                        ; DATA XREF: Boss_ShiperInitializeEncounterEntities+8A   o
                dc.w    $400, $F8FC, $C860, $E3E7, 0, $FCFC, $C920, $E3E3, $500, $F6FA
Boss_ShiperPrimarySpriteDescriptor: dc.w    $2892, $500, $E8, $A88A, $D00, $F8  ; was: word_366E4
                                        ; DATA XREF: Boss_ShiperInitializeEncounterEntities+5C   o
Boss_ShiperSecondarySpriteDescriptor:   dc.w    $2898, $900, $C1E2, $A896, $400, $C900  ; was: word_366F0
                                        ; DATA XREF: Boss_ShiperInitializeEncounterEntities+7C   o

; Selects rotation state $E when BossCombatCounter is at least $13C, otherwise
; selects state zero, then clears the secondary entity's X velocity
Boss_ShiperSelectRotationPattern:                       ; DATA XREF: ROM:000364A2   o  ; was: sub_366FC
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperUpdateAttackAndSpawnProjectile
                addq.w  #2,4(a5)
                move.w  #$E,$174(a5)
                cmpi.w  #$13C,(BossCombatCounter).w
                bpl.s   Boss_ShiperSelectRotationPatternClearSecondaryXVelocity
                clr.w   $174(a5)
Boss_ShiperSelectRotationPatternClearSecondaryXVelocity:  ; CODE XREF: Boss_ShiperSelectRotationPattern+18   j  ; was: loc_3671A
                clr.l   $78(a5)
; Runs Shiper's motion pipeline and oscillating-shot attempt until the rotation,
; delay, and bounce gates allow selection of the next travel direction
Boss_ShiperUpdateAttackAndSpawnProjectile:              ; CODE XREF: Boss_ShiperSelectRotationPattern+6   j  ; was: loc_3671E
                                        ; DATA XREF: ROM:000364A4   o
                bsr.w   Boss_ShiperUpdateMotionPipeline
                bsr.w   Boss_ShiperSpawnOscillatingShot
                cmpi.w  #2,$174(a5)
                bne.s   Boss_ShiperAttackUpdateReturn
                subq.w  #1,$5A(a5)
                bpl.s   Boss_ShiperAttackUpdateReturn
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperAttackUpdateReturn
Boss_ShiperSelectTravelDirection:                       ; CODE XREF: Boss_ShiperWaitForCounterRefillMotionThreshold+34   j  ; was: loc_3673C
                jsr     (Physics_GetPlayerDelta).l
                move.w  (RandomNumberState).w,d0
                andi.w  #7,d0
                addq.w  #1,d0
                move.w  d0,$5A(a5)
                move.w  #4,$174(a5)
                tst.w   d1
                bpl.s   Boss_ShiperSelectPositiveTravelMotion
                cmpi.w  #$1C08,$58(a5)
                bmi.s   Boss_ShiperSelectPositiveTravelMotion
                move.w  #$C,4(a5)
                move.w  #2,$5C(a5)
                move.l  #$FFFE4000,$78(a5)
                bset    #1,$5E(a5)
Boss_ShiperAttackUpdateReturn:                          ; CODE XREF: Boss_ShiperSelectRotationPattern+30   j  ; was: locret_3677C
                                        ; Boss_ShiperSelectRotationPattern+36   j
                rts
; ---------------------------------------------------------------------------
Boss_ShiperSelectPositiveTravelMotion:                  ; CODE XREF: Boss_ShiperSelectRotationPattern+5C   j  ; was: loc_3677E
                                        ; Boss_ShiperSelectRotationPattern+64   j
                move.w  #$10,4(a5)
                move.w  #4,$5C(a5)
                move.l  #$18000,$78(a5)
                bclr    #1,$5E(a5)
                rts
; End of function Boss_ShiperSelectRotationPattern
; Returns to attack-selection state eight and derives the next delay from
; $1E0 minus BossCombatCounter
Boss_ShiperPrepareNextAttackCycle:                      ; CODE XREF: Boss_ShiperUpdateNegativeTravelCycle+34   j  ; was: sub_3679A
                                        ; Boss_ShiperUpdateNegativeTravelCycle+3C   j
                move.w  #8,4(a5)
                clr.w   $5C(a5)
                move.w  #$1E0,d0
                sub.w   (BossCombatCounter).w,d0
                asr.w   #4,d0
                addq.w  #1,d0
                move.w  d0,$5A(a5)
                rts
; End of function Boss_ShiperPrepareNextAttackCycle
; Waits for motion phase $16C to fall below six, then starts the counter-refill
; rotation and clears the secondary entity's X velocity
Boss_ShiperWaitForCounterRefillMotionThreshold:         ; DATA XREF: ROM:000364BE   o  ; was: sub_367B6
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperUpdateCombatCounterRefill
                addq.w  #2,4(a5)
                move.w  #$A,$174(a5)
                clr.l   $78(a5)
; Refills BossCombatCounter toward $1E0 while updating motion, then waits for
; the configured delay and a bounce before selecting another travel direction
Boss_ShiperUpdateCombatCounterRefill:                   ; CODE XREF: Boss_ShiperWaitForCounterRefillMotionThreshold+6   j  ; was: loc_367CC
                                        ; DATA XREF: ROM:000364C0   o
                bsr.w   Boss_ShiperUpdateMotionPipeline
                addi.w  #4,(BossCombatCounter).w
                cmpi.w  #$1E0,(BossCombatCounter).w
                bmi.s   Boss_ShiperCombatCounterRefillReturn
                subq.w  #1,$5A(a5)
                bpl.s   Boss_ShiperCombatCounterRefillReturn
                btst    #0,$5E(a5)
                bne.w   Boss_ShiperSelectTravelDirection
Boss_ShiperCombatCounterRefillReturn:                   ; CODE XREF: Boss_ShiperWaitForCounterRefillMotionThreshold+26   j  ; was: locret_367EE
                                        ; Boss_ShiperWaitForCounterRefillMotionThreshold+2C   j
                rts
; End of function Boss_ShiperWaitForCounterRefillMotionThreshold
; Enters main state $24 with horizontal mode eight and a $40-frame refill delay
Boss_ShiperEnterCombatCounterRefill:                    ; CODE XREF: Boss_ShiperUpdateNegativeTravelCycle+2A   j  ; was: sub_367F0
                                        ; Boss_ShiperUpdatePositiveTravelCycle+12   j
                move.w  #$24,4(a5)                      ; '$'
                move.w  #8,$5C(a5)
                move.w  #$40,$5A(a5)                    ; '@'
                rts
; End of function Boss_ShiperEnterCombatCounterRefill
; Brakes a negative secondary-entity X velocity toward zero, then waits for the
; bounce velocity $54 to become nonnegative before advancing state
Boss_ShiperBrakeNegativeSecondaryXVelocity:             ; DATA XREF: ROM:000364A6   o  ; was: sub_36804
                                        ; ROM:000364AE   o
                bsr.w   Boss_ShiperUpdateMotionPipeline
                addi.l  #$1E00,$78(a5)
                bmi.s   Boss_ShiperBrakeNegativeSecondaryXVelocityCheckBounce
                clr.l   $78(a5)
Boss_ShiperBrakeNegativeSecondaryXVelocityCheckBounce:  ; CODE XREF: Boss_ShiperBrakeNegativeSecondaryXVelocity+C   j  ; was: loc_36816
                tst.w   $54(a5)
                bmi.s   Boss_ShiperBrakeNegativeSecondaryXVelocityReturn
                addq.w  #2,4(a5)
                clr.l   $78(a5)
Boss_ShiperBrakeNegativeSecondaryXVelocityReturn:       ; CODE XREF: Boss_ShiperBrakeNegativeSecondaryXVelocity+16   j  ; was: locret_36824
                rts
; End of function Boss_ShiperBrakeNegativeSecondaryXVelocity
; On each bounce in the negative-travel branch, consumes combat counter and
; checks the lower screen-X bound and travel delay before repeating or exiting
Boss_ShiperUpdateNegativeTravelCycle:                   ; DATA XREF: ROM:000364A8   o  ; was: sub_36826
                                        ; ROM:000364B0   o
                bsr.w   Boss_ShiperUpdateMotionPipeline
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperNegativeTravelCycleReturn
                cmpi.w  #$E,4(a5)
                beq.s   Boss_ShiperUpdateNegativeTravelCycleCheckLimits
                subq.w  #1,$5A(a5)
                bpl.s   Boss_ShiperResumeTravelBrakingState
                addq.w  #2,4(a5)
                clr.w   $5C(a5)
                rts
; ---------------------------------------------------------------------------
Boss_ShiperUpdateNegativeTravelCycleCheckLimits:        ; CODE XREF: Boss_ShiperUpdateNegativeTravelCycle+12   j  ; was: loc_3684A
                subi.w  #$28,(BossCombatCounter).w      ; '('
                bmi.w   Boss_ShiperEnterCombatCounterRefill
                cmpi.w  #$1BC8,$58(a5)
                bmi.w   Boss_ShiperPrepareNextAttackCycle
                subq.w  #1,$5A(a5)
                bmi.w   Boss_ShiperPrepareNextAttackCycle
Boss_ShiperResumeTravelBrakingState:                    ; CODE XREF: Boss_ShiperUpdateNegativeTravelCycle+18   j  ; was: loc_36866
                subq.w  #2,4(a5)
                move.l  #$FFFDA000,$78(a5)
Boss_ShiperNegativeTravelCycleReturn:                   ; CODE XREF: Boss_ShiperUpdateNegativeTravelCycle+A   j  ; was: locret_36872
                rts
; End of function Boss_ShiperUpdateNegativeTravelCycle
; Brakes a positive secondary-entity X velocity toward zero, then waits for the
; bounce velocity $54 to become nonnegative before advancing state
Boss_ShiperBrakePositiveSecondaryXVelocity:             ; DATA XREF: ROM:000364AA   o  ; was: sub_36874
                bsr.w   Boss_ShiperUpdateMotionPipeline
                subi.l  #$2000,$78(a5)
                bpl.s   Boss_ShiperBrakePositiveSecondaryXVelocityCheckBounce
                clr.l   $78(a5)
Boss_ShiperBrakePositiveSecondaryXVelocityCheckBounce:  ; CODE XREF: Boss_ShiperBrakePositiveSecondaryXVelocity+C   j  ; was: loc_36886
                tst.w   $54(a5)
                bmi.s   Boss_ShiperBrakePositiveSecondaryXVelocityReturn
                addq.w  #2,4(a5)
                clr.l   $78(a5)
Boss_ShiperBrakePositiveSecondaryXVelocityReturn:       ; CODE XREF: Boss_ShiperBrakePositiveSecondaryXVelocity+16   j  ; was: locret_36894
                rts
; End of function Boss_ShiperBrakePositiveSecondaryXVelocity
; On each bounce in the positive-travel branch, consumes combat counter and
; checks the upper screen-X bound and travel delay before repeating or exiting
Boss_ShiperUpdatePositiveTravelCycle:                   ; DATA XREF: ROM:000364AC   o  ; was: sub_36896
                bsr.w   Boss_ShiperUpdateMotionPipeline
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperPositiveTravelCycleReturn
                subi.w  #$28,(BossCombatCounter).w      ; '('
                bmi.w   Boss_ShiperEnterCombatCounterRefill
                cmpi.w  #$1C98,$58(a5)
                bpl.w   Boss_ShiperPrepareNextAttackCycle
                subq.w  #1,$5A(a5)
                bmi.w   Boss_ShiperPrepareNextAttackCycle
                subq.w  #2,4(a5)
                move.l  #$24000,$78(a5)
Boss_ShiperPositiveTravelCycleReturn:                   ; CODE XREF: Boss_ShiperUpdatePositiveTravelCycle+A   j  ; was: locret_368CA
                rts
; End of function Boss_ShiperUpdatePositiveTravelCycle
; Waits until the accumulated motion coordinate drops below six
Boss_ShiperWaitForMotionThreshold:                      ; DATA XREF: ROM:000364B2   o  ; was: sub_368CC
                bsr.w   Boss_ShiperUpdateMotionPipeline
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperWaitForMotionThresholdReturn
                addq.w  #2,4(a5)
                clr.w   $174(a5)
                move.w  #$30,$5A(a5)                    ; '0'
Boss_ShiperWaitForMotionThresholdReturn:                ; CODE XREF: Boss_ShiperWaitForMotionThreshold+A   j  ; was: locret_368E6
                rts
; End of function Boss_ShiperWaitForMotionThreshold
; Count down to the shared boss-message gate while updating Shiper
Boss_ShiperBossMessageDelayState:                       ; DATA XREF: ROM:000364B4   o  ; was: sub_368E8
                bsr.w   Boss_ShiperUpdateMotionPipeline
                subq.w  #1,$5A(a5)
                bpl.s   Boss_ShiperBossMessageDelayReturn
                addq.w  #2,4(a5)
                moveq   #2,d0
                jmp     BossMessage_Start
; ---------------------------------------------------------------------------
Boss_ShiperBossMessageDelayReturn:                      ; CODE XREF: Boss_ShiperBossMessageDelayState+8   j  ; was: locret_368FE
                rts
; End of function Boss_ShiperBossMessageDelayState
; Wait for the boss message and motion flags before returning to retreat
Boss_ShiperWaitForBossMessageState:                     ; DATA XREF: ROM:000364B6   o  ; was: sub_36900
                bsr.w   Boss_ShiperUpdateMotionPipeline
                tst.w   (MessageSequenceState).w
                bne.s   Boss_ShiperWaitForBossMessageReturn
                btst    #0,$5E(a5)
                bne.s   Boss_ShiperWaitForBossMessageReturn
                cmpi.w  #2,$174(a5)
                bne.s   Boss_ShiperWaitForBossMessageReturn
                subi.w  #$A0,(CameraXLowerBound).w
                clr.b   (BossColorEffectFlags).w
                move.w  #$104,(Entity57Type).w
                bra.w   Boss_ShiperPrepareNextAttackCycle
; ---------------------------------------------------------------------------
Boss_ShiperWaitForBossMessageReturn:                    ; CODE XREF: Boss_ShiperWaitForBossMessageState+8   j  ; was: locret_3692E
                                        ; Boss_ShiperWaitForBossMessageState+10   j
                rts
; End of function Boss_ShiperWaitForBossMessageState
; Starts defeat state $1E, clears sprite flags and secondary X velocity, and
; seeds the shared stage-spawn countdown to four
Boss_ShiperBeginDefeat:                                 ; CODE XREF: Boss_ShiperMainHandler+2E   j  ; was: sub_36930
                move.b  #2,(BossColorEffectFlags).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                clr.l   $78(a5)
                move.w  #4,(StageSpawnCountdown).w
; End of function Boss_ShiperBeginDefeat
; Waits for rotation state $C and the bounce gate, then selects horizontal mode
; six and starts the $C0-frame defeat countdown
Boss_ShiperWaitForDefeatMotionState:                    ; DATA XREF: ROM:000364B8   o  ; was: sub_3694C
                cmpi.w  #$C,$174(a5)
                beq.s   Boss_ShiperWaitForDefeatMotionStateCheckBounce
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperUpdateDefeatEffectsAndMotion
                move.w  #$A,$174(a5)
Boss_ShiperWaitForDefeatMotionStateCheckBounce:         ; CODE XREF: Boss_ShiperWaitForDefeatMotionState+6   j  ; was: loc_36962
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperUpdateDefeatEffectsAndMotion
                cmpi.w  #$C,$174(a5)
                bne.s   Boss_ShiperUpdateDefeatEffectsAndMotion
                move.w  #6,$5C(a5)
                addq.w  #2,4(a5)
                move.w  #$C0,$5A(a5)
; End of function Boss_ShiperWaitForDefeatMotionState
; Applies the randomized defeat palette, attempts debris, and runs the motion
; pipeline shared by the defeat states
Boss_ShiperUpdateDefeatEffectsAndMotion:                ; CODE XREF: Boss_ShiperWaitForDefeatMotionState+E   j  ; was: sub_36982
                                        ; Boss_ShiperWaitForDefeatMotionState+1C   j
                jsr     (Gfx_UpdateRandomizedPaletteRange).l
                bsr.w   Boss_ShiperSpawnDebris
                bra.w   Boss_ShiperUpdateMotionPipeline
; End of function Boss_ShiperUpdateDefeatEffectsAndMotion
; Handles boss defeat sequence with sprite cleanup and screen effects
Boss_ShiperDefeatSequence:                              ; DATA XREF: ROM:000364BA   o  ; was: sub_36990
                bsr.w   Boss_ShiperUpdateDefeatEffectsAndMotion
                subq.w  #1,$5A(a5)
                bmi.s   Boss_ShiperDefeatSequenceBeginCleanup
                cmpi.w  #$1C,$5A(a5)
                bpl.w   Boss_ShiperDefeatFlowReturn
                moveq   #$1C,d0
                sub.w   $5A(a5),d0
                jmp     (Gfx_ApplyFullActivePaletteFade).l
; ---------------------------------------------------------------------------
Boss_ShiperDefeatSequenceBeginCleanup:                  ; CODE XREF: Boss_ShiperDefeatSequence+8   j  ; was: loc_369B0
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$40,$5A(a5)                    ; '@'
                clr.w   6(a5)
                move.w  #$30,$4A(a5)                    ; '0'
                clr.w   (RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                clr.w   (RasterLayoutOffset).w
                move.b  #4,(PlaneBScrollModeFlags).w
                move.w  #$24,d0                         ; '$'
                move.w  #$134,d1
                jsr     (Object_ClearEntityRecordsExceptTwoTypes).l
                jsr     (AlternateTransition_SpawnAtOwner).l
                moveq   #$1C,d0
                jmp     (Gfx_ApplyFullActivePaletteFade).l
; End of function Boss_ShiperDefeatSequence
; Handles boss defeat fade out countdown before final transition
Boss_ShiperDefeatFadeOut:                               ; DATA XREF: ROM:000364BC   o  ; was: sub_369F6
                move.w  $5A(a5),d0
                subi.w  #$30,d0                         ; '0'
                bmi.s   Boss_ShiperDefeatFadeOutTick
                jsr     (Gfx_ApplyFullActivePaletteFade).l
Boss_ShiperDefeatFadeOutTick:                           ; CODE XREF: Boss_ShiperDefeatFadeOut+8   j  ; was: loc_36A06
                subq.w  #1,$5A(a5)
                bpl.s   Boss_ShiperDefeatFlowReturn
                subq.w  #1,$4A(a5)
                bpl.s   Boss_ShiperDefeatFlowReturn
                bset    #4,2(a5)
Boss_ShiperDefeatFlowReturn:                            ; CODE XREF: Boss_ShiperDefeatSequence+10   j  ; was: locret_36A18
                                        ; Boss_ShiperDefeatFadeOut+14   j
                rts
; End of function Boss_ShiperDefeatFadeOut
