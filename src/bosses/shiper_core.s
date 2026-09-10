; Runs Shiper's encounter state machine and shared visual state
Boss_ShiperMainHandler:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3641A
                move.w  (word_FFEC02).w,(word_FFEC04).w
                tst.w   4(a5)
                beq.s   Boss_ShiperDispatchState
                tst.w   6(a5)
                beq.s   Boss_ShiperDispatchState
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_ShiperUpdateActiveState
                btst    #1,(byte_FF80EC).w
                bne.s   Boss_ShiperUpdateActiveState
                tst.w   (word_FF8200).w
                bne.s   Boss_ShiperUpdateActiveState
                bset    #0,(byte_FFA272).w
                bra.w   Boss_ShiperInitDefeat
; ---------------------------------------------------------------------------
Boss_ShiperUpdateActiveState:                           ; CODE XREF: Boss_ShiperMainHandler+18   j  ; was: loc_3644C
                                        ; Boss_ShiperMainHandler+20   j
                jsr     (Gfx_ProcessDefaultColorFade).l
                clr.b   $49(a5)
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$58(a5)
                addi.l  #$6000,$7C(a5)
                bmi.s   Boss_ShiperDispatchState
                cmpi.w  #$150,$74(a5)
                bmi.s   Boss_ShiperDispatchState
                clr.l   $7C(a5)
                move.w  #$150,$74(a5)
                tst.w   (word_FFA010).w
                bne.s   Boss_ShiperDispatchState
                move.w  #1,(word_FFA010).w
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
                dc.w    Boss_ShiperInit-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperLoadGraphics-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperSetupState-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperAttackDecision-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperUpdateAttackAndSpawnProjectile-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperRiseState-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperHoverState-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperDecelerateVertical-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperRetreatLogic-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperRiseState-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperHoverState-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperWaitForMotionThreshold-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperBossMessageDelayState-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperWaitForBossMessageState-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperPhaseCheck-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperDefeatSequence-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperDefeatFadeOut-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperCheckHealthTransition-Boss_ShiperBeginEncounter
                dc.w    Boss_ShiperCheckHealthTransition_WaitFade-Boss_ShiperBeginEncounter

; Starts the encounter's background transition and removes unrelated objects
Boss_ShiperBeginEncounter:                              ; DATA XREF: Boss_ShiperStates   o  ; was: sub_364C2
                addq.w  #2,4(a5)
                addq.w  #1,6(a5)
                move.l  #Boss_ShiperBackgroundConfig,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                move.w  #0,(word_FFA948).w
                move.w  #$13,(word_FFA944).w
                move.w  #$24,d0                         ; '$'
                move.w  #$134,d1
                jmp     Object_ClearAllExceptTypes
; End of function Boss_ShiperBeginEncounter
Boss_ShiperNoOp:
                rts                                     ; was: nullsub_77
; End of function Boss_ShiperNoOp
; ---------------------------------------------------------------------------
Boss_ShiperBackgroundConfig:    dc.w    $FFFF, $7000, $FFFF, $6800, $FFFF, $2000, 0, $4000  ; was: word_364F4
                                        ; DATA XREF: Boss_ShiperBeginEncounter+8   o

; Initializes Shiper Honeyviper boss by processing pointer data and setting up trigonometric tables
Boss_ShiperInit:                                        ; DATA XREF: ROM:0003649C   o  ; was: sub_36504
                jsr     (Gfx_RenderScrollingBackground).l
                bpl.s   Boss_ShiperInitReturn
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                movea.l #Boss_ShiperInitialAssetDescriptors,a0
                jsr     (Data_ProcessPointer).l
                movem.l (sp)+,a5
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$10,d0
                jmp     Math_CalculateSineCosineTable
; ---------------------------------------------------------------------------
Boss_ShiperInitReturn:                                  ; CODE XREF: Boss_ShiperInit+6   j  ; was: locret_36530
                rts
; End of function Boss_ShiperInit
; ---------------------------------------------------------------------------
Boss_ShiperInitialAssetDescriptors: dc.w    7           ; field_0  ; was: stru_36532
                                        ; DATA XREF: Boss_ShiperInit+10   o
                dc.l    tiles_10DA6C                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF

; Waits for system ready then loads boss graphics via DMA transfer
Boss_ShiperLoadGraphics:                                ; DATA XREF: ROM:0003649E   o  ; was: sub_36544
                tst.w   (word_FFF720).w
                bmi.s   Boss_ShiperLoadGraphicsReturn
                addq.w  #2,4(a5)
                movea.l #Boss_ShiperTileDmaDescriptor,a0
                jsr     (Gfx_DMATransferTiles).l
                move.w  #$80,(dword_FFA908).w
Boss_ShiperLoadGraphicsReturn:                          ; CODE XREF: Boss_ShiperLoadGraphics+4   j  ; was: locret_36560
                rts
; End of function Boss_ShiperLoadGraphics
; ---------------------------------------------------------------------------
Boss_ShiperTileDmaDescriptor:   dc.w    $6100, $2000, $204, $708, $90A, $B0C, $D0E, $150F, $1011, $1213, $1400  ; was: word_36562
                                        ; DATA XREF: Boss_ShiperLoadGraphics+A   o

; Sets up complete boss state machine with positions sprites and collision data
Boss_ShiperSetupState:                                  ; DATA XREF: ROM:000364A0   o  ; was: sub_36578
                move.w  #$14,4(a5)
                move.w  #4,$174(a5)
                addq.w  #2,(word_FFA950).w
                move.w  #$24,(word_FFF74A).w            ; '$'
                clr.w   (word_FFF74E).w
                move.w  #$A,(word_FF8090).w
                move.b  #3,(byte_FFA95B).w
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
Boss_ShiperSetupNextAuxiliaryPart:                      ; CODE XREF: Boss_ShiperSetupState+B0   j  ; was: loc_3660A
                movea.w (a0)+,a1
                move.w  #$10,(a1)
                move.w  #$8080,2(a1)
                move.b  #$80,$20(a1)
                move.w  (a0)+,$E(a1)
                move.w  (a0)+,8(a1)
                move.w  (a0)+,$A(a1)
                dbf     d7,Boss_ShiperSetupNextAuxiliaryPart
                move.b  #$20,$260(a5)                   ; ' '
                move.b  #$20,$320(a5)                   ; ' '
                move.w  #$10,$1E0(a5)
                move.w  #$C080,$1E2(a5)
                move.b  #$28,$200(a5)                   ; '('
                move.w  #$10,$2A0(a5)
                move.w  #$C080,$2A2(a5)
                move.b  #$24,$2C0(a5)                   ; '$'
                movea.w #(word_FFC980-M68K_RAM),a0
                moveq   #$30,d0                         ; '0'
                moveq   #5,d7
Boss_ShiperSetupNextChainPart:                          ; CODE XREF: Boss_ShiperSetupState+112   j  ; was: loc_36664
                move.w  #$10,(a0)
                move.w  #$8080,2(a0)
                move.b  d0,$20(a0)
                move.w  #$639E,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                lea     $60(a0),a0
                subq.w  #4,d0
                dbf     d7,Boss_ShiperSetupNextChainPart
                move.w  #$63A7,$54E(a5)
                move.w  #$F00,$548(a5)
                move.w  #$F0F0,$54A(a5)
                movea.w #(byte_FFCBC0-M68K_RAM),a0
                move.w  #$10,(a0)
                movea.l #Boss_ShiperObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                bsr.w   Boss_ShiperTentaclePosition
                bra.w   Boss_ShiperScrollUpdate
; End of function Boss_ShiperSetupState
; ---------------------------------------------------------------------------
Boss_ShiperAuxiliaryPartDescriptors:    dc.w    $C6E0, $63B7, $500, $F8F8, $C7A0, $63BB, $900, $F4F8, $C740, $63C1  ; was: word_366BC
                                        ; DATA XREF: Boss_ShiperSetupState+8A   o
                dc.w    $400, $F8FC, $C860, $E3E7, 0, $FCFC, $C920, $E3E3, $500, $F6FA
Boss_ShiperPrimarySpriteDescriptor: dc.w    $2892, $500, $E8, $A88A, $D00, $F8  ; was: word_366E4
                                        ; DATA XREF: Boss_ShiperSetupState+5C   o
Boss_ShiperSecondarySpriteDescriptor:   dc.w    $2898, $900, $C1E2, $A896, $400, $C900  ; was: word_366F0
                                        ; DATA XREF: Boss_ShiperSetupState+7C   o

; Boss attack decision logic choosing between dive and ranged attacks
Boss_ShiperAttackDecision:                              ; DATA XREF: ROM:000364A2   o  ; was: sub_366FC
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperUpdateAttackAndSpawnProjectile
                addq.w  #2,4(a5)
                move.w  #$E,$174(a5)
                cmpi.w  #$13C,(word_FF8234).w
                bpl.s   Boss_ShiperAttackDecisionResetMotion
                clr.w   $174(a5)
Boss_ShiperAttackDecisionResetMotion:                   ; CODE XREF: Boss_ShiperAttackDecision+18   j  ; was: loc_3671A
                clr.l   $78(a5)
; Updates boss state and spawns projectiles during attack phase
Boss_ShiperUpdateAttackAndSpawnProjectile:              ; CODE XREF: Boss_ShiperAttackDecision+6   j  ; was: loc_3671E
                                        ; DATA XREF: ROM:000364A4   o
                bsr.w   Boss_ShiperUpdateMain
                bsr.w   Boss_ShiperSpawnOscillatingShot
                cmpi.w  #2,$174(a5)
                bne.s   Boss_ShiperAttackDecisionReturn
                subq.w  #1,$5A(a5)
                bpl.s   Boss_ShiperAttackDecisionReturn
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperAttackDecisionReturn
Boss_ShiperSelectAttackDirection:                       ; CODE XREF: Boss_ShiperCheckHealthTransition+34   j  ; was: loc_3673C
                jsr     (Physics_GetPlayerDelta).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                addq.w  #1,d0
                move.w  d0,$5A(a5)
                move.w  #4,$174(a5)
                tst.w   d1
                bpl.s   Boss_ShiperSelectPositiveAttackMotion
                cmpi.w  #$1C08,$58(a5)
                bmi.s   Boss_ShiperSelectPositiveAttackMotion
                move.w  #$C,4(a5)
                move.w  #2,$5C(a5)
                move.l  #$FFFE4000,$78(a5)
                bset    #1,$5E(a5)
Boss_ShiperAttackDecisionReturn:                        ; CODE XREF: Boss_ShiperAttackDecision+30   j  ; was: locret_3677C
                                        ; Boss_ShiperAttackDecision+36   j
                rts
; ---------------------------------------------------------------------------
Boss_ShiperSelectPositiveAttackMotion:                  ; CODE XREF: Boss_ShiperAttackDecision+5C   j  ; was: loc_3677E
                                        ; Boss_ShiperAttackDecision+64   j
                move.w  #$10,4(a5)
                move.w  #4,$5C(a5)
                move.l  #$18000,$78(a5)
                bclr    #1,$5E(a5)
                rts
; End of function Boss_ShiperAttackDecision
; Boss retreat state transition with timer based on remaining health
Boss_ShiperRetreatState:                                ; CODE XREF: Boss_ShiperHoverState+34   j  ; was: sub_3679A
                                        ; Boss_ShiperHoverState+3C   j
                move.w  #8,4(a5)
                clr.w   $5C(a5)
                move.w  #$1E0,d0
                sub.w   (word_FF8234).w,d0
                asr.w   #4,d0
                addq.w  #1,d0
                move.w  d0,$5A(a5)
                rts
; End of function Boss_ShiperRetreatState
; Checks health counter and transitions state when conditions met
Boss_ShiperCheckHealthTransition:                       ; DATA XREF: ROM:000364BE   o  ; was: sub_367B6
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperCheckHealthTransition_WaitFade
                addq.w  #2,4(a5)
                move.w  #$A,$174(a5)
                clr.l   $78(a5)
; Waits for palette fade to reach threshold before transitioning
Boss_ShiperCheckHealthTransition_WaitFade:              ; CODE XREF: Boss_ShiperCheckHealthTransition+6   j  ; was: loc_367CC
                                        ; DATA XREF: ROM:000364C0   o
                bsr.w   Boss_ShiperUpdateMain
                addi.w  #4,(word_FF8234).w
                cmpi.w  #$1E0,(word_FF8234).w
                bmi.s   Boss_ShiperCheckHealthTransitionReturn
                subq.w  #1,$5A(a5)
                bpl.s   Boss_ShiperCheckHealthTransitionReturn
                btst    #0,$5E(a5)
                bne.w   Boss_ShiperSelectAttackDirection
Boss_ShiperCheckHealthTransitionReturn:                 ; CODE XREF: Boss_ShiperCheckHealthTransition+26   j  ; was: locret_367EE
                                        ; Boss_ShiperCheckHealthTransition+2C   j
                rts
; End of function Boss_ShiperCheckHealthTransition
; Initializes hover state parameters including timers and counters
Boss_ShiperInitHoverState:                              ; CODE XREF: Boss_ShiperHoverState+2A   j  ; was: sub_367F0
                                        ; Boss_ShiperRetreatLogic+12   j
                move.w  #$24,4(a5)                      ; '$'
                move.w  #8,$5C(a5)
                move.w  #$40,$5A(a5)                    ; '@'
                rts
; End of function Boss_ShiperInitHoverState
; Boss rising movement state with upward velocity accumulation
Boss_ShiperRiseState:                                   ; DATA XREF: ROM:000364A6   o  ; was: sub_36804
                                        ; ROM:000364AE   o
                bsr.w   Boss_ShiperUpdateMain
                addi.l  #$1E00,$78(a5)
                bmi.s   Boss_ShiperRiseStateCheckPosition
                clr.l   $78(a5)
Boss_ShiperRiseStateCheckPosition:                      ; CODE XREF: Boss_ShiperRiseState+C   j  ; was: loc_36816
                tst.w   $54(a5)
                bmi.s   Boss_ShiperRiseStateReturn
                addq.w  #2,4(a5)
                clr.l   $78(a5)
Boss_ShiperRiseStateReturn:                             ; CODE XREF: Boss_ShiperRiseState+16   j  ; was: locret_36824
                rts
; End of function Boss_ShiperRiseState
; Boss hovering state with conditional movement based on timer and flags
Boss_ShiperHoverState:                                  ; DATA XREF: ROM:000364A8   o  ; was: sub_36826
                                        ; ROM:000364B0   o
                bsr.w   Boss_ShiperUpdateMain
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperHoverStateReturn
                cmpi.w  #$E,4(a5)
                beq.s   Boss_ShiperHoverStateUpdateRetreat
                subq.w  #1,$5A(a5)
                bpl.s   Boss_ShiperHoverStateResumePrevious
                addq.w  #2,4(a5)
                clr.w   $5C(a5)
                rts
; ---------------------------------------------------------------------------
Boss_ShiperHoverStateUpdateRetreat:                     ; CODE XREF: Boss_ShiperHoverState+12   j  ; was: loc_3684A
                subi.w  #$28,(word_FF8234).w            ; '('
                bmi.w   Boss_ShiperInitHoverState
                cmpi.w  #$1BC8,$58(a5)
                bmi.w   Boss_ShiperRetreatState
                subq.w  #1,$5A(a5)
                bmi.w   Boss_ShiperRetreatState
Boss_ShiperHoverStateResumePrevious:                    ; CODE XREF: Boss_ShiperHoverState+18   j  ; was: loc_36866
                subq.w  #2,4(a5)
                move.l  #$FFFDA000,$78(a5)
Boss_ShiperHoverStateReturn:                            ; CODE XREF: Boss_ShiperHoverState+A   j  ; was: locret_36872
                rts
; End of function Boss_ShiperHoverState
; Decreases vertical velocity and transitions when Y position negative
Boss_ShiperDecelerateVertical:                          ; DATA XREF: ROM:000364AA   o  ; was: sub_36874
                bsr.w   Boss_ShiperUpdateMain
                subi.l  #$2000,$78(a5)
                bpl.s   Boss_ShiperDecelerateVerticalCheckPosition
                clr.l   $78(a5)
Boss_ShiperDecelerateVerticalCheckPosition:             ; CODE XREF: Boss_ShiperDecelerateVertical+C   j  ; was: loc_36886
                tst.w   $54(a5)
                bmi.s   Boss_ShiperDecelerateVerticalReturn
                addq.w  #2,4(a5)
                clr.l   $78(a5)
Boss_ShiperDecelerateVerticalReturn:                    ; CODE XREF: Boss_ShiperDecelerateVertical+16   j  ; was: locret_36894
                rts
; End of function Boss_ShiperDecelerateVertical
; Handles retreat logic with timer checks and position validation
Boss_ShiperRetreatLogic:                                ; DATA XREF: ROM:000364AC   o  ; was: sub_36896
                bsr.w   Boss_ShiperUpdateMain
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperRetreatLogicReturn
                subi.w  #$28,(word_FF8234).w            ; '('
                bmi.w   Boss_ShiperInitHoverState
                cmpi.w  #$1C98,$58(a5)
                bpl.w   Boss_ShiperRetreatState
                subq.w  #1,$5A(a5)
                bmi.w   Boss_ShiperRetreatState
                subq.w  #2,4(a5)
                move.l  #$24000,$78(a5)
Boss_ShiperRetreatLogicReturn:                          ; CODE XREF: Boss_ShiperRetreatLogic+A   j  ; was: locret_368CA
                rts
; End of function Boss_ShiperRetreatLogic
; Waits until the accumulated motion coordinate drops below six
Boss_ShiperWaitForMotionThreshold:                      ; DATA XREF: ROM:000364B2   o  ; was: sub_368CC
                bsr.w   Boss_ShiperUpdateMain
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
                bsr.w   Boss_ShiperUpdateMain
                subq.w  #1,$5A(a5)
                bpl.s   Boss_ShiperBossMessageDelayReturn
                addq.w  #2,4(a5)
                moveq   #2,d0
                jmp     UI_StartBossMessage
; ---------------------------------------------------------------------------
Boss_ShiperBossMessageDelayReturn:                      ; CODE XREF: Boss_ShiperBossMessageDelayState+8   j  ; was: locret_368FE
                rts
; End of function Boss_ShiperBossMessageDelayState
; Wait for the boss message and motion flags before returning to retreat
Boss_ShiperWaitForBossMessageState:                     ; DATA XREF: ROM:000364B6   o  ; was: sub_36900
                bsr.w   Boss_ShiperUpdateMain
                tst.w   (word_FF80C2).w
                bne.s   Boss_ShiperWaitForBossMessageReturn
                btst    #0,$5E(a5)
                bne.s   Boss_ShiperWaitForBossMessageReturn
                cmpi.w  #2,$174(a5)
                bne.s   Boss_ShiperWaitForBossMessageReturn
                subi.w  #$A0,(word_FFA970).w
                clr.b   (byte_FF80EC).w
                move.w  #$104,(word_FFDB20).w
                bra.w   Boss_ShiperRetreatState
; ---------------------------------------------------------------------------
Boss_ShiperWaitForBossMessageReturn:                    ; CODE XREF: Boss_ShiperWaitForBossMessageState+8   j  ; was: locret_3692E
                                        ; Boss_ShiperWaitForBossMessageState+10   j
                rts
; End of function Boss_ShiperWaitForBossMessageState
; Sets boss defeat flags clears state and increments stage counter
Boss_ShiperInitDefeat:                                  ; CODE XREF: Boss_ShiperMainHandler+2E   j  ; was: sub_36930
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                clr.l   $78(a5)
                move.w  #4,(word_FF808C).w
; End of function Boss_ShiperInitDefeat
; Checks boss phase transition conditions based on altitude and flags
Boss_ShiperPhaseCheck:                                  ; DATA XREF: ROM:000364B8   o  ; was: sub_3694C
                cmpi.w  #$C,$174(a5)
                beq.s   Boss_ShiperPhaseCheckActiveFlag
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperUpdateWithFade
                move.w  #$A,$174(a5)
Boss_ShiperPhaseCheckActiveFlag:                        ; CODE XREF: Boss_ShiperPhaseCheck+6   j  ; was: loc_36962
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperUpdateWithFade
                cmpi.w  #$C,$174(a5)
                bne.s   Boss_ShiperUpdateWithFade
                move.w  #6,$5C(a5)
                addq.w  #2,4(a5)
                move.w  #$C0,$5A(a5)
; End of function Boss_ShiperPhaseCheck
; Updates boss with palette fade effect during phase transitions
Boss_ShiperUpdateWithFade:                              ; CODE XREF: Boss_ShiperPhaseCheck+E   j  ; was: sub_36982
                                        ; Boss_ShiperPhaseCheck+1C   j
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Boss_ShiperSpawnDebris
                bra.w   Boss_ShiperUpdateMain
; End of function Boss_ShiperUpdateWithFade
; Handles boss defeat sequence with sprite cleanup and screen effects
Boss_ShiperDefeatSequence:                              ; DATA XREF: ROM:000364BA   o  ; was: sub_36990
                bsr.w   Boss_ShiperUpdateWithFade
                subq.w  #1,$5A(a5)
                bmi.s   Boss_ShiperDefeatSequenceBeginCleanup
                cmpi.w  #$1C,$5A(a5)
                bpl.w   Boss_ShiperDefeatFlowReturn
                moveq   #$1C,d0
                sub.w   $5A(a5),d0
                jmp     (Gfx_SetFadeParams).l
; ---------------------------------------------------------------------------
Boss_ShiperDefeatSequenceBeginCleanup:                  ; CODE XREF: Boss_ShiperDefeatSequence+8   j  ; was: loc_369B0
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$40,$5A(a5)                    ; '@'
                clr.w   6(a5)
                move.w  #$30,$4A(a5)                    ; '0'
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                clr.w   (word_FF8090).w
                move.b  #4,(byte_FFA95B).w
                move.w  #$24,d0                         ; '$'
                move.w  #$134,d1
                jsr     (Object_ClearAllExceptTypes).l
                jsr     (Boss_InitDefeatExplosion).l
                moveq   #$1C,d0
                jmp     (Gfx_SetFadeParams).l
; End of function Boss_ShiperDefeatSequence
; Handles boss defeat fade out countdown before final transition
Boss_ShiperDefeatFadeOut:                               ; DATA XREF: ROM:000364BC   o  ; was: sub_369F6
                move.w  $5A(a5),d0
                subi.w  #$30,d0                         ; '0'
                bmi.s   Boss_ShiperDefeatFadeOutTick
                jsr     (Gfx_SetFadeParams).l
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
; Main boss update wrapper calling position collision animation and physics subsystems
