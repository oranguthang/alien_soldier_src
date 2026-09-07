Boss_ShiperInit:                                        ; DATA XREF: ROM:0003649C   o  ; was: sub_36504
                jsr     (Gfx_RenderScrollingBackground).l
                bpl.s   locret_36530
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                movea.l #stru_36532,a0
                jsr     (Data_ProcessPointer).l
                movem.l (sp)+,a5
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$10,d0
                jmp     Math_CalculateSineCosineTable
; ---------------------------------------------------------------------------
locret_36530:                                           ; CODE XREF: Boss_ShiperInit+6   j
                rts
; End of function Boss_ShiperInit
; ---------------------------------------------------------------------------
stru_36532:     dc.w    7                               ; field_0
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
                bmi.s   locret_36560
                addq.w  #2,4(a5)
                movea.l #word_36562,a0
                jsr     (Gfx_DMATransferTiles).l
                move.w  #$80,(dword_FFA908).w
locret_36560:                                           ; CODE XREF: Boss_ShiperLoadGraphics+4   j
                rts
; End of function Boss_ShiperLoadGraphics
; ---------------------------------------------------------------------------
word_36562:     dc.w    $6100, $2000, $204, $708, $90A, $B0C, $D0E, $150F, $1011, $1213, $1400
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
                move.l  #word_366E4,8(a5)
                move.b  #$30,$20(a5)                    ; '0'
                move.w  #$10,$60(a5)
                move.w  #$CD80,$62(a5)
                move.w  #$CB00,$6E(a5)
                move.l  #word_366F0,$68(a5)
                move.b  #$30,$80(a5)                    ; '0'
                movea.l #word_366BC,a0
                moveq   #4,d7
loc_3660A:                                              ; CODE XREF: Boss_ShiperSetupState+B0   j
                movea.w (a0)+,a1
                move.w  #$10,(a1)
                move.w  #$8080,2(a1)
                move.b  #$80,$20(a1)
                move.w  (a0)+,$E(a1)
                move.w  (a0)+,8(a1)
                move.w  (a0)+,$A(a1)
                dbf     d7,loc_3660A
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
loc_36664:                                              ; CODE XREF: Boss_ShiperSetupState+112   j
                move.w  #$10,(a0)
                move.w  #$8080,2(a0)
                move.b  d0,$20(a0)
                move.w  #$639E,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                lea     $60(a0),a0
                subq.w  #4,d0
                dbf     d7,loc_36664
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
word_366BC:     dc.w    $C6E0, $63B7, $500, $F8F8, $C7A0, $63BB, $900, $F4F8, $C740, $63C1
                                        ; DATA XREF: Boss_ShiperSetupState+8A   o
                dc.w    $400, $F8FC, $C860, $E3E7, 0, $FCFC, $C920, $E3E3, $500, $F6FA
word_366E4:     dc.w    $2892, $500, $E8, $A88A, $D00, $F8
                                        ; DATA XREF: Boss_ShiperSetupState+5C   o
word_366F0:     dc.w    $2898, $900, $C1E2, $A896, $400, $C900
                                        ; DATA XREF: Boss_ShiperSetupState+7C   o

; Boss attack decision logic choosing between dive and ranged attacks
Boss_ShiperAttackDecision:                              ; DATA XREF: ROM:000364A2   o  ; was: sub_366FC
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperAttackDecision_UpdateAndSpawn
                addq.w  #2,4(a5)
                move.w  #$E,$174(a5)
                cmpi.w  #$13C,(word_FF8234).w
                bpl.s   loc_3671A
                clr.w   $174(a5)
loc_3671A:                                              ; CODE XREF: Boss_ShiperAttackDecision+18   j
                clr.l   $78(a5)
; Updates boss state and spawns projectiles during attack phase
Boss_ShiperAttackDecision_UpdateAndSpawn:               ; CODE XREF: Boss_ShiperAttackDecision+6   j  ; was: loc_3671E
                                        ; DATA XREF: ROM:000364A4   o
                bsr.w   Boss_ShiperUpdateMain
                bsr.w   Boss_ShiperSpawnProjectile
                cmpi.w  #2,$174(a5)
                bne.s   locret_3677C
                subq.w  #1,$5A(a5)
                bpl.s   locret_3677C
                btst    #0,$5E(a5)
                beq.s   locret_3677C
loc_3673C:                                              ; CODE XREF: Boss_ShiperCheckHealthTransition+34   j
                jsr     (Physics_GetPlayerDelta).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                addq.w  #1,d0
                move.w  d0,$5A(a5)
                move.w  #4,$174(a5)
                tst.w   d1
                bpl.s   loc_3677E
                cmpi.w  #$1C08,$58(a5)
                bmi.s   loc_3677E
                move.w  #$C,4(a5)
                move.w  #2,$5C(a5)
                move.l  #$FFFE4000,$78(a5)
                bset    #1,$5E(a5)
locret_3677C:                                           ; CODE XREF: Boss_ShiperAttackDecision+30   j
                                        ; Boss_ShiperAttackDecision+36   j
                rts
; ---------------------------------------------------------------------------
loc_3677E:                                              ; CODE XREF: Boss_ShiperAttackDecision+5C   j
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
                bmi.s   locret_367EE
                subq.w  #1,$5A(a5)
                bpl.s   locret_367EE
                btst    #0,$5E(a5)
                bne.w   loc_3673C
locret_367EE:                                           ; CODE XREF: Boss_ShiperCheckHealthTransition+26   j
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
                bmi.s   loc_36816
                clr.l   $78(a5)
loc_36816:                                              ; CODE XREF: Boss_ShiperRiseState+C   j
                tst.w   $54(a5)
                bmi.s   locret_36824
                addq.w  #2,4(a5)
                clr.l   $78(a5)
locret_36824:                                           ; CODE XREF: Boss_ShiperRiseState+16   j
                rts
; End of function Boss_ShiperRiseState
; Boss hovering state with conditional movement based on timer and flags
Boss_ShiperHoverState:                                  ; DATA XREF: ROM:000364A8   o  ; was: sub_36826
                                        ; ROM:000364B0   o
                bsr.w   Boss_ShiperUpdateMain
                btst    #0,$5E(a5)
                beq.s   locret_36872
                cmpi.w  #$E,4(a5)
                beq.s   loc_3684A
                subq.w  #1,$5A(a5)
                bpl.s   loc_36866
                addq.w  #2,4(a5)
                clr.w   $5C(a5)
                rts
; ---------------------------------------------------------------------------
loc_3684A:                                              ; CODE XREF: Boss_ShiperHoverState+12   j
                subi.w  #$28,(word_FF8234).w            ; '('
                bmi.w   Boss_ShiperInitHoverState
                cmpi.w  #$1BC8,$58(a5)
                bmi.w   Boss_ShiperRetreatState
                subq.w  #1,$5A(a5)
                bmi.w   Boss_ShiperRetreatState
loc_36866:                                              ; CODE XREF: Boss_ShiperHoverState+18   j
                subq.w  #2,4(a5)
                move.l  #$FFFDA000,$78(a5)
locret_36872:                                           ; CODE XREF: Boss_ShiperHoverState+A   j
                rts
; End of function Boss_ShiperHoverState
; Decreases vertical velocity and transitions when Y position negative
Boss_ShiperDecelerateVertical:                          ; DATA XREF: ROM:000364AA   o  ; was: sub_36874
                bsr.w   Boss_ShiperUpdateMain
                subi.l  #$2000,$78(a5)
                bpl.s   loc_36886
                clr.l   $78(a5)
loc_36886:                                              ; CODE XREF: Boss_ShiperDecelerateVertical+C   j
                tst.w   $54(a5)
                bmi.s   locret_36894
                addq.w  #2,4(a5)
                clr.l   $78(a5)
locret_36894:                                           ; CODE XREF: Boss_ShiperDecelerateVertical+16   j
                rts
; End of function Boss_ShiperDecelerateVertical
; Handles retreat logic with timer checks and position validation
Boss_ShiperRetreatLogic:                                ; DATA XREF: ROM:000364AC   o  ; was: sub_36896
                bsr.w   Boss_ShiperUpdateMain
                btst    #0,$5E(a5)
                beq.s   locret_368CA
                subi.w  #$28,(word_FF8234).w            ; '('
                bmi.w   Boss_ShiperInitHoverState
                cmpi.w  #$1C98,$58(a5)
                bpl.w   Boss_ShiperRetreatState
                subq.w  #1,$5A(a5)
                bmi.w   Boss_ShiperRetreatState
                subq.w  #2,4(a5)
                move.l  #$24000,$78(a5)
locret_368CA:                                           ; CODE XREF: Boss_ShiperRetreatLogic+A   j
                rts
; End of function Boss_ShiperRetreatLogic
; Boss state waiting for descent condition then transitioning to next state
Boss_ShiperWaitDescend:                                 ; DATA XREF: ROM:000364B2   o  ; was: sub_368CC
                bsr.w   Boss_ShiperUpdateMain
                cmpi.w  #6,$16C(a5)
                bpl.s   locret_368E6
                addq.w  #2,4(a5)
                clr.w   $174(a5)
                move.w  #$30,$5A(a5)                    ; '0'
locret_368E6:                                           ; CODE XREF: Boss_ShiperWaitDescend+A   j
                rts
; End of function Boss_ShiperWaitDescend
; Boss defeat state with timer counting down to victory check
Boss_ShiperDefeatWait:                                  ; DATA XREF: ROM:000364B4   o  ; was: sub_368E8
                bsr.w   Boss_ShiperUpdateMain
                subq.w  #1,$5A(a5)
                bpl.s   locret_368FE
                addq.w  #2,4(a5)
                moveq   #2,d0
                jmp     UI_CheckVictoryCondition
; ---------------------------------------------------------------------------
locret_368FE:                                           ; CODE XREF: Boss_ShiperDefeatWait+8   j
                rts
; End of function Boss_ShiperDefeatWait
; Boss death handler checking multiple conditions before triggering defeat sequence
Boss_ShiperDeathHandler:                                ; DATA XREF: ROM:000364B6   o  ; was: sub_36900
                bsr.w   Boss_ShiperUpdateMain
                tst.w   (word_FF80C2).w
                bne.s   locret_3692E
                btst    #0,$5E(a5)
                bne.s   locret_3692E
                cmpi.w  #2,$174(a5)
                bne.s   locret_3692E
                subi.w  #$A0,(word_FFA970).w
                clr.b   (byte_FF80EC).w
                move.w  #$104,(word_FFDB20).w
                bra.w   Boss_ShiperRetreatState
; ---------------------------------------------------------------------------
locret_3692E:                                           ; CODE XREF: Boss_ShiperDeathHandler+8   j
                                        ; Boss_ShiperDeathHandler+10   j
                rts
; End of function Boss_ShiperDeathHandler
; Sets boss defeat flags clears state and increments stage counter
Boss_ShiperInitDefeat:                                  ; CODE XREF: Boss_CalculatePlayerDistance+2E   j  ; was: sub_36930
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                clr.l   $78(a5)
                move.w  #4,(word_FF808C).w
; End of function Boss_ShiperInitDefeat
; Checks boss phase transition conditions based on altitude and flags
Boss_ShiperPhaseCheck:                                  ; DATA XREF: ROM:000364B8   o  ; was: sub_3694C
                cmpi.w  #$C,$174(a5)
                beq.s   loc_36962
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperUpdateWithFade
                move.w  #$A,$174(a5)
loc_36962:                                              ; CODE XREF: Boss_ShiperPhaseCheck+6   j
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
                bmi.s   loc_369B0
                cmpi.w  #$1C,$5A(a5)
                bpl.w   locret_36A18
                moveq   #$1C,d0
                sub.w   $5A(a5),d0
                jmp     (Gfx_SetFadeParams).l
; ---------------------------------------------------------------------------
loc_369B0:                                              ; CODE XREF: Boss_ShiperDefeatSequence+8   j
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
                bmi.s   loc_36A06
                jsr     (Gfx_SetFadeParams).l
loc_36A06:                                              ; CODE XREF: Boss_ShiperDefeatFadeOut+8   j
                subq.w  #1,$5A(a5)
                bpl.s   locret_36A18
                subq.w  #1,$4A(a5)
                bpl.s   locret_36A18
                bset    #4,2(a5)
locret_36A18:                                           ; CODE XREF: Boss_ShiperDefeatSequence+10   j
                                        ; Boss_ShiperDefeatFadeOut+14   j
                rts
; End of function Boss_ShiperDefeatFadeOut
; Main boss update wrapper calling position collision animation and physics subsystems
