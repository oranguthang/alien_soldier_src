; Clears player input, runs the selected scripted-state handler, merges its
; generated held/pressed buttons, and expires the scripted-input interval
Player_UpdateScriptedInput:                             ; CODE XREF: Player_Update+14   p  ; was: sub_199F4
                bsr.s   Player_ClearInputAndDispatchScript
                move.b  $6A(a5),d0
                or.b    d0,$69(a5)
                subq.w  #1,(word_FF813A).w
                bpl.s   Player_UpdateScriptedInput_Return
                move.w  #$FFFF,(word_FF813A).w
                clr.w   (word_FF8138).w
Player_UpdateScriptedInput_Return:                      ; CODE XREF: Player_UpdateScriptedInput+E   j  ; was: locret_19A0E
                rts
; End of function Player_UpdateScriptedInput

; Dispatches the even byte offset in word_FFA02A through the shared player
; script table after rebuilding the player's world-space X coordinate
Player_ClearInputAndDispatchScript:                     ; CODE XREF: Player_UpdateScriptedInput   p  ; was: sub_19A10
                clr.b   $69(a5)
                clr.b   $6A(a5)
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,(word_FF8652).w
                move.w  (word_FFA02A).w,d0
                movea.w Player_ScriptHandlerOffsets(pc,d0.w),a0
                adda.l  #Stage_InitCutscene,a0
                jmp     (a0)
; End of function Player_ClearInputAndDispatchScript
; ---------------------------------------------------------------------------
Player_ScriptHandlerOffsets:    dc.w    Stage_CutsceneWaitStart_Return-Stage_InitCutscene  ; was: off_19A34
                                        ; DATA XREF: Player_ClearInputAndDispatchScript+18   r
                dc.w    Stage_InitCutscene-Stage_InitCutscene
                dc.w    Cutscene_InitializeParams-Stage_InitCutscene
                dc.w    Stage_CutsceneWaitStart-Stage_InitCutscene
                dc.w    Stage_CutsceneTimerWait-Stage_InitCutscene
                dc.w    Stage_CutsceneCheckPosition-Stage_InitCutscene
                dc.w    Stage_CutscenePlayAnim-Stage_InitCutscene
                dc.w    Stage_CutsceneReachPosition-Stage_InitCutscene
                dc.w    Cutscene_InitStagePause-Stage_InitCutscene
                dc.w    Input_SetButtonFlag-Stage_InitCutscene
                dc.w    Stage_CutsceneWaitStart_Return-Stage_InitCutscene
                dc.w    Player_FlyingNeoIntro-Stage_InitCutscene
                dc.w    Player_CheckBossIntroCondition-Stage_InitCutscene
                dc.w    Cutscene_FlyingNeoIntro-Stage_InitCutscene
                dc.w    Cutscene_FlyingNeoIntro_ScrollDown-Stage_InitCutscene
                dc.w    Cutscene_ScrollCameraLeft-Stage_InitCutscene
                dc.w    Player_XiTigerBossIntro-Stage_InitCutscene
                dc.w    Enemy_Stage14DebrisMain-Stage_InitCutscene
                dc.w    Stage_CutsceneWaitStart-Stage_InitCutscene
                dc.w    Stage_CutsceneTimerWait-Stage_InitCutscene
                dc.w    Enemy_Stage14DebrisInit-Stage_InitCutscene
                dc.w    Enemy_Stage14DebrisAnimate-Stage_InitCutscene
                dc.w    Cutscene_InitFastPause-Stage_InitCutscene
                dc.w    Cutscene_CheckBossFlag-Stage_InitCutscene
                dc.w    Player_ViblackIntro-Stage_InitCutscene
                dc.w    Cutscene_JampanInitParams-Stage_InitCutscene
                dc.w    Boss_SireneShootPattern2-Stage_InitCutscene
                dc.w    Cutscene_Stage20ClearFlag-Stage_InitCutscene

; Initializes stage cutscene setting player position and state
Stage_InitCutscene:                                     ; DATA XREF: Player_ClearInputAndDispatchScript+1C   o  ; was: sub_19A6C
                                        ; ROM:Player_ScriptHandlerOffsets   o
                move.w  #$1BF8,(word_FF8646).w
                move.w  #$16,(word_FF8648).w
                move.w  #6,(word_FFA02A).w
                clr.b   (byte_FFF705).w
                move.w  #2,(word_FF8138).w
                move.w  #$100,(word_FF813A).w
                rts
; End of function Stage_InitCutscene
; Initializes cutscene parameters for transition
Cutscene_InitializeParams:                              ; DATA XREF: ROM:00019A38   o  ; was: sub_19A90
                move.w  #$12C0,(word_FF8646).w
                move.w  #$16,(word_FF8648).w
                move.w  #6,(word_FFA02A).w
                clr.b   (byte_FFF705).w
                move.w  #2,(word_FF8138).w
                move.w  #$100,(word_FF813A).w
                rts
; End of function Cutscene_InitializeParams
; Cutscene parameter initialization
Cutscene_JampanInitParams:                              ; DATA XREF: ROM:00019A66   o  ; was: sub_19AB4
                move.w  #$1640,(word_FF8646).w
                move.w  #$16,(word_FF8648).w
                move.w  #6,(word_FFA02A).w
                clr.b   (byte_FFF705).w
                move.w  #2,(word_FF8138).w
                move.w  #$100,(word_FF813A).w
                bset    #1,(byte_FF8245).w
                bset    #0,(byte_FF8245).w
                rts
; End of function Cutscene_JampanInitParams
; Stage 14 debris handler
Enemy_Stage14DebrisMain:                                ; DATA XREF: ROM:00019A56   o  ; was: sub_19AE4
                move.w  #$690,(word_FF8646).w
                addq.w  #2,(word_FFA02A).w
                clr.b   (byte_FFF705).w
                move.w  #2,(word_FF8138).w
                move.w  #$100,(word_FF813A).w
                bset    #1,(byte_FF8245).w
                bset    #0,(byte_FF8245).w
                rts
; End of function Enemy_Stage14DebrisMain
; Sets player state timer to 32
Player_SetStateTimer:                                   ; CODE XREF: Stage_CutsceneWaitStart+6   j  ; was: sub_19B0C
                                        ; Player_FlyingNeoIntro+2A   j
                move.b  #$20,$6A(a5)                    ; ' '
                rts
; End of function Player_SetStateTimer
; Waits for button press then advances cutscene state
Stage_CutsceneWaitStart:                                ; DATA XREF: ROM:00019A3A   o  ; was: sub_19B14
                                        ; ROM:00019A58   o
                btst    #6,(byte_FF8244).w
                bne.s   Player_SetStateTimer
                tst.b   (byte_FF8244).w
                bne.s   Stage_CutsceneWaitStart_Return
                addq.w  #2,(word_FFA02A).w
                move.w  #$20,(word_FF8644).w            ; ' '
                bset    #3,$E(a5)
; Return from cutscene wait start
Stage_CutsceneWaitStart_Return:                         ; CODE XREF: Stage_CutsceneWaitStart+C   j  ; was: locret_19B32
                                        ; Player_FlyingNeoIntro+36   j
                rts
; End of function Stage_CutsceneWaitStart
; Waits for timer countdown before cutscene continuation
Stage_CutsceneTimerWait:                                ; DATA XREF: ROM:00019A3C   o  ; was: sub_19B34
                                        ; ROM:00019A5A   o
                subq.w  #1,(word_FF8644).w
                bpl.s   locret_19B3E
                addq.w  #2,(word_FFA02A).w
locret_19B3E:                                           ; CODE XREF: Stage_CutsceneTimerWait+4   j
                rts
; End of function Stage_CutsceneTimerWait
; Checks player position against scroll target for cutscene advance
Stage_CutsceneCheckPosition:                            ; DATA XREF: ROM:00019A3E   o  ; was: sub_19B40
                btst    #1,(byte_FFA407).w
                beq.s   loc_19B56
                move.w  #$10,(word_FFA02A).w
                move.b  #$20,$6A(a5)                    ; ' '
                rts
; ---------------------------------------------------------------------------
loc_19B56:                                              ; CODE XREF: Stage_CutsceneCheckPosition+6   j
                move.b  #8,$69(a5)
                btst    #0,(byte_FF8244).w
                bne.s   locret_19B7E
                move.w  (word_FF8646).w,d0
                cmp.w   (word_FF8652).w,d0
                bpl.s   locret_19B7E
                addq.w  #2,(word_FFA02A).w
                move.b  #$20,$6A(a5)                    ; ' '
                move.w  (word_FF8648).w,(word_FF8644).w
locret_19B7E:                                           ; CODE XREF: Stage_CutsceneCheckPosition+22   j
                                        ; Stage_CutsceneCheckPosition+2C   j
                rts
; End of function Stage_CutsceneCheckPosition
; Plays cutscene animation setting sprite states and flags
Stage_CutscenePlayAnim:                                 ; DATA XREF: ROM:00019A40   o  ; was: sub_19B80
                move.b  #$28,$69(a5)                    ; '('
                subq.w  #1,(word_FF8644).w
                bpl.s   locret_19BAE
                addq.w  #2,(word_FFA02A).w
                move.b  #$2A,$69(a5)                    ; '*'
                move.b  #$20,$6A(a5)                    ; ' '
                bset    #1,(byte_FF8245).w
                bset    #0,(byte_FF8245).w
                bset    #7,(byte_FF8245).w
locret_19BAE:                                           ; CODE XREF: Stage_CutscenePlayAnim+A   j
                rts
; End of function Stage_CutscenePlayAnim
; Handles player reaching target position in cutscene
Stage_CutsceneReachPosition:                            ; DATA XREF: ROM:00019A42   o  ; was: sub_19BB0
                bclr    #5,$6A(a5)
                move.b  #$28,$69(a5)                    ; '('
                cmpi.w  #$200,$10(a5)
                bmi.s   locret_19BD2
                move.w  #$200,$10(a5)
                clr.w   2(a5)
                clr.w   (word_FF8138).w
locret_19BD2:                                           ; CODE XREF: Stage_CutsceneReachPosition+12   j
                rts
; End of function Stage_CutsceneReachPosition
; Initializes cutscene timers
Cutscene_InitStagePause:                                ; DATA XREF: ROM:00019A44   o  ; was: sub_19BD4
                move.b  #$28,$69(a5)                    ; '('
                btst    #6,(byte_FF8244).w
                beq.s   loc_19BE8
                move.b  #$28,$6A(a5)                    ; '('
loc_19BE8:                                              ; CODE XREF: Cutscene_InitStagePause+C   j
                tst.b   (byte_FF8244).w
                bne.s   locret_19BF4
                move.w  #$A,(word_FFA02A).w
locret_19BF4:                                           ; CODE XREF: Cutscene_InitStagePause+18   j
                rts
; End of function Cutscene_InitStagePause
; Initializes debris
Enemy_Stage14DebrisInit:                                ; DATA XREF: ROM:00019A5C   o  ; was: sub_19BF6
                btst    #1,(byte_FFA407).w
                beq.s   loc_19C0C
                move.w  #$2C,(word_FFA02A).w            ; ','
                move.b  #$20,$6A(a5)                    ; ' '
                rts
; ---------------------------------------------------------------------------
loc_19C0C:                                              ; CODE XREF: Enemy_Stage14DebrisInit+6   j
                move.b  #8,$69(a5)
                btst    #0,(byte_FF8244).w
                bne.s   locret_19C2E
                move.w  (word_FF8646).w,d0
                cmp.w   (word_FF8652).w,d0
                bpl.s   locret_19C2E
                addq.w  #2,(word_FFA02A).w
                move.b  #$22,$6A(a5)                    ; '"'
locret_19C2E:                                           ; CODE XREF: Enemy_Stage14DebrisInit+22   j
                                        ; Enemy_Stage14DebrisInit+2C   j
                rts
; End of function Enemy_Stage14DebrisInit
; Animates debris
Enemy_Stage14DebrisAnimate:                             ; DATA XREF: ROM:00019A5E   o  ; was: sub_19C30
                cmpi.w  #$200,$10(a5)
                bmi.s   locret_19C46
                move.w  #$200,$10(a5)
                clr.w   2(a5)
                clr.w   (word_FF8138).w
locret_19C46:                                           ; CODE XREF: Enemy_Stage14DebrisAnimate+6   j
                rts
; End of function Enemy_Stage14DebrisAnimate
; Sets short timer for fast transition
Cutscene_InitFastPause:                                 ; DATA XREF: ROM:00019A60   o  ; was: sub_19C48
                move.b  #$28,$69(a5)                    ; '('
                btst    #0,(byte_FF8244).w
                bne.s   locret_19C5C
                move.w  #$28,(word_FFA02A).w            ; '('
locret_19C5C:                                           ; CODE XREF: Cutscene_InitFastPause+C   j
                rts
; End of function Cutscene_InitFastPause
; Player intro state for Flying-Neo boss battle
Player_FlyingNeoIntro:                                  ; DATA XREF: ROM:00019A4A   o  ; was: sub_19C5E
                addq.w  #2,(word_FFA02A).w
                move.w  #2,(word_FF8138).w
                move.w  #$100,(word_FF813A).w
                bset    #4,(byte_FF8245).w
                btst    #4,$E(a5)
                beq.s   Player_CheckBossIntroCondition
                move.b  #$20,$6A(a5)                    ; ' '
; Checks boss intro cutscene trigger conditions
Player_CheckBossIntroCondition:                         ; CODE XREF: Player_FlyingNeoIntro+1C   j  ; was: loc_19C82
                                        ; DATA XREF: ROM:00019A4C   o
                btst    #6,(byte_FF8244).w
                bne.w   Player_SetStateTimer
                move.w  #$1040,d0
                bsr.w   Player_CheckHorizontalDistance
                bne.w   Stage_CutsceneWaitStart_Return
                tst.b   (byte_FF8244).w
                bne.w   Stage_CutsceneWaitStart_Return
                clr.w   (word_FF8138).w
                rts
; End of function Player_FlyingNeoIntro
; Cutscene parameters for Flying-Neo boss intro
Cutscene_FlyingNeoIntro:                                ; DATA XREF: ROM:00019A4E   o  ; was: sub_19CA6
                addq.w  #2,(word_FFA02A).w
                move.w  #2,(word_FF8138).w
                move.w  #$200,(word_FF813A).w
                bset    #0,(byte_FF8245).w
                bset    #5,(byte_FF8245).w
                move.w  #$148,$10(a5)
                bclr    #3,$E(a5)
                move.w  #$8000,(word_FF808A).w
                bset    #3,$E(a5)
                move.b  #$20,$6A(a5)                    ; ' '
                bclr    #0,2(a5)
                move.w  #$E,(word_FF8648).w
; Scrolls camera down during Flying Neo intro cutscene
Cutscene_FlyingNeoIntro_ScrollDown:                     ; DATA XREF: ROM:00019A50   o  ; was: loc_19CEC
                subi.l  #$28000,$10(a5)
                move.b  #$20,$69(a5)                    ; ' '
                subq.w  #1,(word_FF8648).w
                bmi.s   loc_19D0A
                move.l  #$FFF90000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_19D0A:                                              ; CODE XREF: Cutscene_FlyingNeoIntro+58   j
                tst.l   $1C(a5)
                bmi.w   Stage_CutsceneWaitStart_Return
                bset    #0,2(a5)
                addq.w  #2,(word_FFA02A).w
                clr.b   (byte_FF8245).w
; Scrolls camera horizontally during boss intro cutscene
Cutscene_ScrollCameraLeft:                              ; DATA XREF: ROM:00019A52   o  ; was: loc_19D20
                subi.l  #$28000,$10(a5)
                tst.b   (byte_FF8244).w
                bne.w   Stage_CutsceneWaitStart_Return
                clr.w   (word_FFA02A).w
                clr.w   (word_FF8138).w
                move.l  #$FFFEE000,(dword_FF8240).w
                rts
; End of function Cutscene_FlyingNeoIntro
; Player intro state for Xi-Tiger boss
Player_XiTigerBossIntro:                                ; DATA XREF: ROM:00019A54   o  ; was: sub_19D42
                subq.w  #1,(word_FF8644).w
                bpl.s   locret_19D4C
                clr.w   (word_FFA02A).w
locret_19D4C:                                           ; CODE XREF: Player_XiTigerBossIntro+4   j
                rts
; End of function Player_XiTigerBossIntro
; Player setup for Viblack intro
Player_ViblackIntro:                                    ; DATA XREF: ROM:00019A64   o  ; was: sub_19D4E
                tst.w   (word_FF80E6).w
                bne.s   locret_19D5A
                move.w  #$48,(word_FFA404).w            ; 'H'
locret_19D5A:                                           ; CODE XREF: Player_ViblackIntro+4   j
                rts
; End of function Player_ViblackIntro
; Sets specific button flag in state register
Input_SetButtonFlag:                                    ; DATA XREF: ROM:00019A46   o  ; was: sub_19D5C
                move.b  #$10,$69(a5)
                rts
; End of function Input_SetButtonFlag
; Shooting pattern 2
Boss_SireneShootPattern2:                               ; DATA XREF: ROM:00019A68   o  ; was: sub_19D64
                bset    #3,$E(a5)
                bra.s   Cutscene_CheckBossFlag
; End of function Boss_SireneShootPattern2
; Clears cutscene flag
Cutscene_Stage20ClearFlag:                              ; DATA XREF: ROM:00019A6A   o  ; was: sub_19D6C
                bclr    #3,$E(a5)
; End of function Cutscene_Stage20ClearFlag
; Checks boss flag and sets timer
Cutscene_CheckBossFlag:                                 ; CODE XREF: Boss_SireneShootPattern2+6   j  ; was: sub_19D72
                                        ; DATA XREF: ROM:00019A62   o
                btst    #6,(byte_FF8244).w
                beq.s   locret_19D80
                move.b  #$21,$6A(a5)                    ; '!'
locret_19D80:                                           ; CODE XREF: Cutscene_CheckBossFlag+6   j
                rts
; End of function Cutscene_CheckBossFlag
; Checks horizontal distance setting movement direction
Player_CheckHorizontalDistance:                         ; CODE XREF: Player_FlyingNeoIntro+32   p  ; was: sub_19D82
                sub.w   (word_FF8652).w,d0
                move.w  d0,d1
                bpl.s   loc_19D8C
                neg.w   d0
loc_19D8C:                                              ; CODE XREF: Player_CheckHorizontalDistance+6   j
                cmpi.w  #6,d0
                bpl.s   loc_19D96
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_19D96:                                              ; CODE XREF: Player_CheckHorizontalDistance+E   j
                move.w  d1,d1
                bmi.s   loc_19DA4
                bset    #3,$69(a5)
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
loc_19DA4:                                              ; CODE XREF: Player_CheckHorizontalDistance+16   j
                bset    #2,$69(a5)
                moveq   #1,d0
                rts
; End of function Player_CheckHorizontalDistance
