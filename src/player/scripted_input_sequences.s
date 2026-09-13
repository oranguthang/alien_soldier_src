; Clears player input, runs the selected scripted-state handler, merges its
; generated held/pressed buttons, and expires the scripted-input interval
Player_UpdateScriptedInput:                             ; CODE XREF: Player_Update+14   p  ; was: sub_199F4
                bsr.s   Player_DispatchScriptedInputState
                move.b  $6A(a5),d0
                or.b    d0,$69(a5)
                subq.w  #1,(ScriptedInputTimeout).w
                bpl.s   Player_UpdateScriptedInput_Return
                move.w  #$FFFF,(ScriptedInputTimeout).w
                clr.w   (ScriptedInputActive).w
Player_UpdateScriptedInput_Return:                      ; CODE XREF: Player_UpdateScriptedInput+E   j  ; was: locret_19A0E
                rts
; End of function Player_UpdateScriptedInput

; Dispatches the even byte offset in PlayerScriptStateOffset through the shared player
; script table after rebuilding the player's world-space X coordinate
Player_DispatchScriptedInputState:                      ; CODE XREF: Player_UpdateScriptedInput   p  ; was: sub_19A10
                clr.b   $69(a5)
                clr.b   $6A(a5)
                move.w  (PrimaryCameraXPosition).w,d0
                add.w   $10(a5),d0
                move.w  d0,(ScriptedPlayerWorldX).w
                move.w  (PlayerScriptStateOffset).w,d0
                movea.w PlayerScript_StateHandlerOffsets(pc,d0.w),a0
                adda.l  #PlayerScript_InitializePostShiperRunState02,a0
                jmp     (a0)
; End of function Player_DispatchScriptedInputState
; ---------------------------------------------------------------------------
PlayerScript_StateHandlerOffsets:   dc.w    PlayerScript_NoOpAndSharedReturn-PlayerScript_InitializePostShiperRunState02  ; was: off_19A34
                                        ; DATA XREF: Player_DispatchScriptedInputState+18   r
                dc.w    PlayerScript_InitializePostShiperRunState02-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_InitializePostTerobusterRunState04-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_WaitForStatusClearState06-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_WaitForRunDelayState08-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_MoveRightPastTargetState0A-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_HoldRightCThenAdvanceState0C-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_FinishRunAtScreenX200State0E-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_WaitForStatusThenResumeRunState10-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_HoldBState12-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_NoOpAndSharedReturn-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_BeginFlyingNeoApproachState16-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_MoveToFlyingNeoTargetState18-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_InitializeFlyingNeoEntryState1A-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_UpdateFlyingNeoEntryState1C-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_FinishFlyingNeoEntryState1E-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_WaitForXiTigerIntroState20-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_InitializePostBugmaxRunState22-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_WaitForStatusClearState06-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_WaitForRunDelayState08-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_MoveRightPastPostBugmaxTargetState28-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_FinishPostBugmaxRunAtScreenX200State2A-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_WaitForPostBugmaxStatusState2C-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_EmitUpCWhenStatusBit6SetState2E-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_StartViblackPlayerState30-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_InitializePostJampanRunState32-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_FaceRightAndEmitUpCState34-PlayerScript_InitializePostShiperRunState02
                dc.w    PlayerScript_FaceLeftAndEmitUpCState36-PlayerScript_InitializePostShiperRunState02

; Initialize the post-Shiper scripted run toward world X $1BF8
PlayerScript_InitializePostShiperRunState02:            ; DATA XREF: Player_DispatchScriptedInputState+1C   o  ; was: sub_19A6C
                                        ; ROM:PlayerScript_StateHandlerOffsets   o
                move.w  #$1BF8,(ScriptedInputTargetX).w
                move.w  #$16,(ScriptedInputDelay).w
                move.w  #6,(PlayerScriptStateOffset).w
                clr.b   (GameplayControlFlags).w
                move.w  #2,(ScriptedInputActive).w
                move.w  #$100,(ScriptedInputTimeout).w
                rts
; End of function PlayerScript_InitializePostShiperRunState02
; Initialize the post-Terobuster scripted run toward world X $12C0
PlayerScript_InitializePostTerobusterRunState04:        ; DATA XREF: ROM:00019A38   o  ; was: sub_19A90
                move.w  #$12C0,(ScriptedInputTargetX).w
                move.w  #$16,(ScriptedInputDelay).w
                move.w  #6,(PlayerScriptStateOffset).w
                clr.b   (GameplayControlFlags).w
                move.w  #2,(ScriptedInputActive).w
                move.w  #$100,(ScriptedInputTimeout).w
                rts
; End of function PlayerScript_InitializePostTerobusterRunState04
; Initialize the post-Jampan scripted run toward world X $1640
PlayerScript_InitializePostJampanRunState32:            ; DATA XREF: ROM:00019A66   o  ; was: sub_19AB4
                move.w  #$1640,(ScriptedInputTargetX).w
                move.w  #$16,(ScriptedInputDelay).w
                move.w  #6,(PlayerScriptStateOffset).w
                clr.b   (GameplayControlFlags).w
                move.w  #2,(ScriptedInputActive).w
                move.w  #$100,(ScriptedInputTimeout).w
                bset    #1,(byte_FF8245).w
                bset    #0,(byte_FF8245).w
                rts
; End of function PlayerScript_InitializePostJampanRunState32
; Initialize the post-Bugmax scripted run toward world X $0690
PlayerScript_InitializePostBugmaxRunState22:            ; DATA XREF: ROM:00019A56   o  ; was: sub_19AE4
                move.w  #$690,(ScriptedInputTargetX).w
                addq.w  #2,(PlayerScriptStateOffset).w
                clr.b   (GameplayControlFlags).w
                move.w  #2,(ScriptedInputActive).w
                move.w  #$100,(ScriptedInputTimeout).w
                bset    #1,(byte_FF8245).w
                bset    #0,(byte_FF8245).w
                rts
; End of function PlayerScript_InitializePostBugmaxRunState22
; Emit a synthetic C-button press for the current scripted frame
PlayerScript_EmitCPress:                                ; CODE XREF: PlayerScript_WaitForStatusClearState06+6   j  ; was: sub_19B0C
                                        ; PlayerScript_MoveToFlyingNeoTargetState18+2A   j
                move.b  #$20,$6A(a5)                    ; ' '
                rts
; End of function PlayerScript_EmitCPress
; Wait for player status flags to clear, then face right and start the run delay
PlayerScript_WaitForStatusClearState06:                 ; DATA XREF: ROM:00019A3A   o  ; was: sub_19B14
                                        ; ROM:00019A58   o
                btst    #6,(byte_FF8244).w
                bne.s   PlayerScript_EmitCPress
                tst.b   (byte_FF8244).w
                bne.s   PlayerScript_NoOpAndSharedReturn
                addq.w  #2,(PlayerScriptStateOffset).w
                move.w  #$20,(ScriptedInputStepTimer).w  ; ' '
                bset    #3,$E(a5)
; Return from cutscene wait start
PlayerScript_NoOpAndSharedReturn:                       ; CODE XREF: PlayerScript_WaitForStatusClearState06+C   j  ; was: locret_19B32
                                        ; PlayerScript_MoveToFlyingNeoTargetState18+36   j
                rts
; End of function PlayerScript_WaitForStatusClearState06
; Wait for the scripted run delay, then advance to target movement
PlayerScript_WaitForRunDelayState08:                    ; DATA XREF: ROM:00019A3C   o  ; was: sub_19B34
                                        ; ROM:00019A5A   o
                subq.w  #1,(ScriptedInputStepTimer).w
                bpl.s   PlayerScript_WaitForRunDelayState08_Return
                addq.w  #2,(PlayerScriptStateOffset).w
PlayerScript_WaitForRunDelayState08_Return:             ; CODE XREF: PlayerScript_WaitForRunDelayState08+4   j  ; was: locret_19B3E
                rts
; End of function PlayerScript_WaitForRunDelayState08
; Hold Right until world-space player X passes the configured target
PlayerScript_MoveRightPastTargetState0A:                ; DATA XREF: ROM:00019A3E   o  ; was: sub_19B40
                btst    #1,(PlayerWallContactFlags).w
                beq.s   PlayerScript_MoveRightPastTargetState0A_MoveRight
                move.w  #$10,(PlayerScriptStateOffset).w
                move.b  #$20,$6A(a5)                    ; ' '
                rts
; ---------------------------------------------------------------------------
PlayerScript_MoveRightPastTargetState0A_MoveRight:      ; CODE XREF: PlayerScript_MoveRightPastTargetState0A+6   j  ; was: loc_19B56
                move.b  #8,$69(a5)
                btst    #0,(byte_FF8244).w
                bne.s   PlayerScript_MoveRightPastTargetState0A_Return
                move.w  (ScriptedInputTargetX).w,d0
                cmp.w   (ScriptedPlayerWorldX).w,d0
                bpl.s   PlayerScript_MoveRightPastTargetState0A_Return
                addq.w  #2,(PlayerScriptStateOffset).w
                move.b  #$20,$6A(a5)                    ; ' '
                move.w  (ScriptedInputDelay).w,(ScriptedInputStepTimer).w
PlayerScript_MoveRightPastTargetState0A_Return:         ; CODE XREF: PlayerScript_MoveRightPastTargetState0A+22   j  ; was: locret_19B7E
                                        ; PlayerScript_MoveRightPastTargetState0A+2C   j
                rts
; End of function PlayerScript_MoveRightPastTargetState0A
; Hold Right+C through the run delay, then emit Down+Right+C and advance
PlayerScript_HoldRightCThenAdvanceState0C:              ; DATA XREF: ROM:00019A40   o  ; was: sub_19B80
                move.b  #$28,$69(a5)                    ; '('
                subq.w  #1,(ScriptedInputStepTimer).w
                bpl.s   PlayerScript_HoldRightCThenAdvanceState0C_Return
                addq.w  #2,(PlayerScriptStateOffset).w
                move.b  #$2A,$69(a5)                    ; '*'
                move.b  #$20,$6A(a5)                    ; ' '
                bset    #1,(byte_FF8245).w
                bset    #0,(byte_FF8245).w
                bset    #7,(byte_FF8245).w
PlayerScript_HoldRightCThenAdvanceState0C_Return:       ; CODE XREF: PlayerScript_HoldRightCThenAdvanceState0C+A   j  ; was: locret_19BAE
                rts
; End of function PlayerScript_HoldRightCThenAdvanceState0C
; Hold Right+C until player screen X reaches $0200, then end scripted input
PlayerScript_FinishRunAtScreenX200State0E:              ; DATA XREF: ROM:00019A42   o  ; was: sub_19BB0
                bclr    #5,$6A(a5)
                move.b  #$28,$69(a5)                    ; '('
                cmpi.w  #$200,$10(a5)
                bmi.s   PlayerScript_FinishRunAtScreenX200State0E_Return
                move.w  #$200,$10(a5)
                clr.w   2(a5)
                clr.w   (ScriptedInputActive).w
PlayerScript_FinishRunAtScreenX200State0E_Return:       ; CODE XREF: PlayerScript_FinishRunAtScreenX200State0E+12   j  ; was: locret_19BD2
                rts
; End of function PlayerScript_FinishRunAtScreenX200State0E
; Hold Right+C until status clears, then resume the target run at state $0A
PlayerScript_WaitForStatusThenResumeRunState10:         ; DATA XREF: ROM:00019A44   o  ; was: sub_19BD4
                move.b  #$28,$69(a5)                    ; '('
                btst    #6,(byte_FF8244).w
                beq.s   PlayerScript_WaitForStatusThenResumeRunState10_CheckStatusClear
                move.b  #$28,$6A(a5)                    ; '('
PlayerScript_WaitForStatusThenResumeRunState10_CheckStatusClear:  ; CODE XREF: PlayerScript_WaitForStatusThenResumeRunState10+C   j  ; was: loc_19BE8
                tst.b   (byte_FF8244).w
                bne.s   PlayerScript_WaitForStatusThenResumeRunState10_Return
                move.w  #$A,(PlayerScriptStateOffset).w
PlayerScript_WaitForStatusThenResumeRunState10_Return:  ; CODE XREF: PlayerScript_WaitForStatusThenResumeRunState10+18   j  ; was: locret_19BF4
                rts
; End of function PlayerScript_WaitForStatusThenResumeRunState10
; Post-Bugmax variant: hold Right until world X passes $0690
PlayerScript_MoveRightPastPostBugmaxTargetState28:      ; DATA XREF: ROM:00019A5C   o  ; was: sub_19BF6
                btst    #1,(PlayerWallContactFlags).w
                beq.s   PlayerScript_MoveRightPastPostBugmaxTargetState28_MoveRight
                move.w  #$2C,(PlayerScriptStateOffset).w  ; ','
                move.b  #$20,$6A(a5)                    ; ' '
                rts
; ---------------------------------------------------------------------------
PlayerScript_MoveRightPastPostBugmaxTargetState28_MoveRight:  ; CODE XREF: PlayerScript_MoveRightPastPostBugmaxTargetState28+6   j  ; was: loc_19C0C
                move.b  #8,$69(a5)
                btst    #0,(byte_FF8244).w
                bne.s   PlayerScript_MoveRightPastPostBugmaxTargetState28_Return
                move.w  (ScriptedInputTargetX).w,d0
                cmp.w   (ScriptedPlayerWorldX).w,d0
                bpl.s   PlayerScript_MoveRightPastPostBugmaxTargetState28_Return
                addq.w  #2,(PlayerScriptStateOffset).w
                move.b  #$22,$6A(a5)                    ; '"'
PlayerScript_MoveRightPastPostBugmaxTargetState28_Return:  ; CODE XREF: PlayerScript_MoveRightPastPostBugmaxTargetState28+22   j  ; was: locret_19C2E
                                        ; PlayerScript_MoveRightPastPostBugmaxTargetState28+2C   j
                rts
; End of function PlayerScript_MoveRightPastPostBugmaxTargetState28
; Finish the post-Bugmax run when player screen X reaches $0200
PlayerScript_FinishPostBugmaxRunAtScreenX200State2A:    ; DATA XREF: ROM:00019A5E   o  ; was: sub_19C30
                cmpi.w  #$200,$10(a5)
                bmi.s   PlayerScript_FinishPostBugmaxRunAtScreenX200State2A_Return
                move.w  #$200,$10(a5)
                clr.w   2(a5)
                clr.w   (ScriptedInputActive).w
PlayerScript_FinishPostBugmaxRunAtScreenX200State2A_Return:  ; CODE XREF: PlayerScript_FinishPostBugmaxRunAtScreenX200State2A+6   j  ; was: locret_19C46
                rts
; End of function PlayerScript_FinishPostBugmaxRunAtScreenX200State2A
; Wait for post-Bugmax status to clear, then resume state $28
PlayerScript_WaitForPostBugmaxStatusState2C:            ; DATA XREF: ROM:00019A60   o  ; was: sub_19C48
                move.b  #$28,$69(a5)                    ; '('
                btst    #0,(byte_FF8244).w
                bne.s   PlayerScript_WaitForPostBugmaxStatusState2C_Return
                move.w  #$28,(PlayerScriptStateOffset).w  ; '('
PlayerScript_WaitForPostBugmaxStatusState2C_Return:     ; CODE XREF: PlayerScript_WaitForPostBugmaxStatusState2C+C   j  ; was: locret_19C5C
                rts
; End of function PlayerScript_WaitForPostBugmaxStatusState2C
; Start the scripted Flying Neo approach and enable its player-control flags
PlayerScript_BeginFlyingNeoApproachState16:             ; DATA XREF: ROM:00019A4A   o  ; was: sub_19C5E
                addq.w  #2,(PlayerScriptStateOffset).w
                move.w  #2,(ScriptedInputActive).w
                move.w  #$100,(ScriptedInputTimeout).w
                bset    #4,(byte_FF8245).w
                btst    #4,$E(a5)
                beq.s   PlayerScript_MoveToFlyingNeoTargetState18
                move.b  #$20,$6A(a5)                    ; ' '
; Move horizontally toward world X $1040 and end the script once status clears
PlayerScript_MoveToFlyingNeoTargetState18:              ; CODE XREF: PlayerScript_BeginFlyingNeoApproachState16+1C   j  ; was: loc_19C82
                                        ; DATA XREF: ROM:00019A4C   o
                btst    #6,(byte_FF8244).w
                bne.w   PlayerScript_EmitCPress
                move.w  #$1040,d0
                bsr.w   PlayerScript_SelectHorizontalInputTowardTarget
                bne.w   PlayerScript_NoOpAndSharedReturn
                tst.b   (byte_FF8244).w
                bne.w   PlayerScript_NoOpAndSharedReturn
                clr.w   (ScriptedInputActive).w
                rts
; End of function PlayerScript_BeginFlyingNeoApproachState16
; Initialize the Flying Neo player-entry motion and advance to state $1C
PlayerScript_InitializeFlyingNeoEntryState1A:           ; DATA XREF: ROM:00019A4E   o  ; was: sub_19CA6
                addq.w  #2,(PlayerScriptStateOffset).w
                move.w  #2,(ScriptedInputActive).w
                move.w  #$200,(ScriptedInputTimeout).w
                bset    #0,(byte_FF8245).w
                bset    #5,(byte_FF8245).w
                move.w  #$148,$10(a5)
                bclr    #3,$E(a5)
                move.w  #$8000,(word_FF808A).w
                bset    #3,$E(a5)
                move.b  #$20,$6A(a5)                    ; ' '
                bclr    #0,2(a5)
                move.w  #$E,(ScriptedInputDelay).w
; Move the player left while driving the timed vertical entry motion
PlayerScript_UpdateFlyingNeoEntryState1C:               ; DATA XREF: ROM:00019A50   o  ; was: loc_19CEC
                subi.l  #$28000,$10(a5)
                move.b  #$20,$69(a5)                    ; ' '
                subq.w  #1,(ScriptedInputDelay).w
                bmi.s   PlayerScript_UpdateFlyingNeoEntryState1C_WaitForVerticalMotionEnd
                move.l  #$FFF90000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
PlayerScript_UpdateFlyingNeoEntryState1C_WaitForVerticalMotionEnd:  ; CODE XREF: PlayerScript_UpdateFlyingNeoEntryState1C+1E   j  ; was: loc_19D0A
                tst.l   $1C(a5)
                bmi.w   PlayerScript_NoOpAndSharedReturn
                bset    #0,2(a5)
                addq.w  #2,(PlayerScriptStateOffset).w
                clr.b   (byte_FF8245).w
; Finish the Flying Neo player entry once the shared status byte clears
PlayerScript_FinishFlyingNeoEntryState1E:               ; DATA XREF: ROM:00019A52   o  ; was: loc_19D20
                subi.l  #$28000,$10(a5)
                tst.b   (byte_FF8244).w
                bne.w   PlayerScript_NoOpAndSharedReturn
                clr.w   (PlayerScriptStateOffset).w
                clr.w   (ScriptedInputActive).w
                move.l  #$FFFEE000,(dword_FF8240).w
                rts
; End of function PlayerScript_InitializeFlyingNeoEntryState1A
; Wait for the Xi-Tiger intro delay, then disable scripted input
PlayerScript_WaitForXiTigerIntroState20:                ; DATA XREF: ROM:00019A54   o  ; was: sub_19D42
                subq.w  #1,(ScriptedInputStepTimer).w
                bpl.s   PlayerScript_WaitForXiTigerIntroState20_Return
                clr.w   (PlayerScriptStateOffset).w
PlayerScript_WaitForXiTigerIntroState20_Return:         ; CODE XREF: PlayerScript_WaitForXiTigerIntroState20+4   j  ; was: locret_19D4C
                rts
; End of function PlayerScript_WaitForXiTigerIntroState20
; Start player state $48 once the Viblack readiness word clears
PlayerScript_StartViblackPlayerState30:                 ; DATA XREF: ROM:00019A64   o  ; was: sub_19D4E
                tst.w   (word_FF80E6).w
                bne.s   PlayerScript_StartViblackPlayerState30_Return
                move.w  #$48,(PlayerStateOffset).w      ; 'H'
PlayerScript_StartViblackPlayerState30_Return:          ; CODE XREF: PlayerScript_StartViblackPlayerState30+4   j  ; was: locret_19D5A
                rts
; End of function PlayerScript_StartViblackPlayerState30
; Hold the B button while scripted-input state $12 is active
PlayerScript_HoldBState12:                              ; DATA XREF: ROM:00019A46   o  ; was: sub_19D5C
                move.b  #$10,$69(a5)
                rts
; End of function PlayerScript_HoldBState12
; Face right, then share state $2E's conditional Up+C input
PlayerScript_FaceRightAndEmitUpCState34:                ; DATA XREF: ROM:00019A68   o  ; was: sub_19D64
                bset    #3,$E(a5)
                bra.s   PlayerScript_EmitUpCWhenStatusBit6SetState2E
; End of function PlayerScript_FaceRightAndEmitUpCState34
; Face left, then share state $2E's conditional Up+C input
PlayerScript_FaceLeftAndEmitUpCState36:                 ; DATA XREF: ROM:00019A6A   o  ; was: sub_19D6C
                bclr    #3,$E(a5)
; End of function PlayerScript_FaceLeftAndEmitUpCState36
; Emit Up+C while player-status bit six is set
PlayerScript_EmitUpCWhenStatusBit6SetState2E:           ; CODE XREF: PlayerScript_FaceRightAndEmitUpCState34+6   j  ; was: sub_19D72
                                        ; DATA XREF: ROM:00019A62   o
                btst    #6,(byte_FF8244).w
                beq.s   PlayerScript_EmitUpCWhenStatusBit6SetState2E_Return
                move.b  #$21,$6A(a5)                    ; '!'
PlayerScript_EmitUpCWhenStatusBit6SetState2E_Return:    ; CODE XREF: PlayerScript_EmitUpCWhenStatusBit6SetState2E+6   j  ; was: locret_19D80
                rts
; End of function PlayerScript_EmitUpCWhenStatusBit6SetState2E
; Select Left or Right until the world-X target is within six pixels
PlayerScript_SelectHorizontalInputTowardTarget:         ; CODE XREF: PlayerScript_MoveToFlyingNeoTargetState18+32   p  ; was: sub_19D82
                sub.w   (ScriptedPlayerWorldX).w,d0
                move.w  d0,d1
                bpl.s   PlayerScript_SelectHorizontalInputTowardTarget_CompareDistance
                neg.w   d0
PlayerScript_SelectHorizontalInputTowardTarget_CompareDistance:  ; CODE XREF: PlayerScript_SelectHorizontalInputTowardTarget+6   j  ; was: loc_19D8C
                cmpi.w  #6,d0
                bpl.s   PlayerScript_SelectHorizontalInputTowardTarget_Move
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
PlayerScript_SelectHorizontalInputTowardTarget_Move:    ; CODE XREF: PlayerScript_SelectHorizontalInputTowardTarget+E   j  ; was: loc_19D96
                move.w  d1,d1
                bmi.s   PlayerScript_SelectHorizontalInputTowardTarget_MoveLeft
                bset    #3,$69(a5)
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
PlayerScript_SelectHorizontalInputTowardTarget_MoveLeft:  ; CODE XREF: PlayerScript_SelectHorizontalInputTowardTarget+16   j  ; was: loc_19DA4
                bset    #2,$69(a5)
                moveq   #1,d0
                rts
; End of function PlayerScript_SelectHorizontalInputTowardTarget
