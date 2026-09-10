VBLANK:                                                 ; DATA XREF: ROM:00000078   o
                move    #$2700,sr
Int_VBlank_AcquireZ80Bus:                               ; CODE XREF: VBLANK+C   j  ; was: loc_A7E
                bset    #0,(IO_Z80BUS).l
                bne.s   Int_VBlank_AcquireZ80Bus
                move.b  #1,(byte_A01FFF).l
Int_VBlank_ReleaseZ80Bus:                               ; CODE XREF: VBLANK+1E   j  ; was: loc_A90
                bclr    #0,(IO_Z80BUS).l
                beq.s   Int_VBlank_ReleaseZ80Bus
                movem.l d0-d7/a0-a5,-(sp)
Int_VBlank_WaitForBlanking:                             ; CODE XREF: VBLANK+2E   j  ; was: loc_A9E
                move.w  (VDP_CTRL).l,d0
                andi.w  #8,d0
                beq.s   Int_VBlank_WaitForBlanking
                btst    #6,(byte_FFFF26).w
                beq.w   Int_VBlank_RunEffects
                move.w  #$300,d0
Int_VBlank_DebugDelayLoop:                              ; CODE XREF: VBLANK:Int_VBlank_DebugDelayLoop   j  ; was: loc_AB8
                dbf     d0,Int_VBlank_DebugDelayLoop
Int_VBlank_RunEffects:                                  ; CODE XREF: VBLANK+36   j  ; was: loc_ABC
                jsr     (VBlank_EffectDispatcher).l
                bsr.w   Gfx_UpdateVDPDisplay
                tst.b   (byte_FF830E).w
                beq.s   Int_VBlank_UpdateFrameDivider
                subq.b  #1,(byte_FF830E).w
                bne.s   Int_VBlank_UpdateFrameDivider
                move.b  #1,(dword_FFF80A+3).w
Int_VBlank_UpdateFrameDivider:                          ; CODE XREF: VBLANK+50   j  ; was: loc_AD8
                                        ; VBLANK+56   j
                subq.w  #1,(word_FF8096).w
                bpl.s   Int_VBlank_CheckExtendedHandler
                move.w  #4,d0
                sub.w   (word_FFFF3E).w,d0
                move.w  d0,(word_FF8096).w
Int_VBlank_CheckExtendedHandler:                        ; CODE XREF: VBLANK+62   j  ; was: loc_AEA
                tst.b   (byte_FFF704).w
                bne.s   Sys_VBlankHandler
Int_VBlank_AcquireZ80BusForExit:                        ; CODE XREF: VBLANK+7E   j  ; was: loc_AF0
                                        ; Sys_VBlankHandler+12   j
                bset    #0,(IO_Z80BUS).l
                bne.s   Int_VBlank_AcquireZ80BusForExit
                move.b  #0,(byte_A01FFF).l
Int_VBlank_ReleaseZ80BusForExit:                        ; CODE XREF: VBLANK+90   j  ; was: loc_B02
                bclr    #0,(IO_Z80BUS).l
                beq.s   Int_VBlank_ReleaseZ80BusForExit
                move    #$2300,sr
                bsr.w   Sys_VBlankEventHandler
                movem.l (sp)+,d0-d7/a0-a5
                rte
; End of function VBLANK

; Extended VBlank interrupt handler that manages sound Z80 bus acquisition VDP updates and input processing
Sys_VBlankHandler:                                      ; CODE XREF: VBLANK+74   j  ; was: sub_B1A
                tst.w   (word_FFFF3E).w
                beq.s   Sys_VBlankHandler_RunUpdate
                tst.b   (byte_FF813E).w
                bmi.s   Sys_VBlankHandler_RunUpdate
                cmpi.w  #1,(word_FF8096).w
                beq.s   Int_VBlank_AcquireZ80BusForExit
Sys_VBlankHandler_RunUpdate:                            ; CODE XREF: Sys_VBlankHandler+4   j  ; was: loc_B2E
                                        ; Sys_VBlankHandler+A   j
                clr.b   (byte_FFF704).w
                bsr.w   Sound_AcquireZ80Bus
                bsr.w   Gfx_VBlankDMATransfer
                bsr.w   Gfx_ApplyVDPSettings
                jsr     (Sys_InitVDPRegisters).l
Sys_VBlankHandler_AcquireZ80BusForExit:                 ; CODE XREF: Sys_VBlankHandler+32   j  ; was: loc_B44
                bset    #0,(IO_Z80BUS).l
                bne.s   Sys_VBlankHandler_AcquireZ80BusForExit
                move.b  #0,(byte_A01FFF).l
Sys_VBlankHandler_ReleaseZ80BusForExit:                 ; CODE XREF: Sys_VBlankHandler+44   j  ; was: loc_B56
                bclr    #0,(IO_Z80BUS).l
                beq.s   Sys_VBlankHandler_ReleaseZ80BusForExit
                move    #$2300,sr
                bsr.w   Sys_VBlankEventHandler
                bsr.w   Input_HandleControllerState
                jsr     (RandomNumber).l
                bsr.w   Sys_UpdateTimers
                move.b  #1,(byte_FFF704).w
                movem.l (sp)+,d0-d7/a0-a5
                rte
; End of function Sys_VBlankHandler
; Handles controller port state changes and button press detection
Input_HandleControllerState:                            ; CODE XREF: Sys_VBlankHandler+4E   p  ; was: sub_B82
                move.b  (byte_FFF705).w,d0
                btst    #6,d0
                beq.w   Input_HandleControllerState_Return
                clr.b   d1
                btst    #0,d0
                beq.w   Input_HandleControllerState_CheckPort2
                or.b    (word_FFF708).w,d1
Input_HandleControllerState_CheckPort2:                 ; CODE XREF: Input_HandleControllerState+12   j  ; was: loc_B9C
                btst    #1,d0
                beq.w   Input_HandleControllerState_CheckTransition
                or.b    (word_FFF708+1).w,d1
Input_HandleControllerState_CheckTransition:            ; CODE XREF: Input_HandleControllerState+1E   j  ; was: loc_BA8
                tst.b   d1
                bpl.w   Input_HandleControllerState_Return
                tst.b   d0
                bmi.w   Input_HandleControllerState_ClearActiveFlag
                bset    #7,d0
                move.b  d0,(byte_FFF705).w
                move.b  #1,(byte_FFF807).w
                rts
; ---------------------------------------------------------------------------
Input_HandleControllerState_ClearActiveFlag:            ; CODE XREF: Input_HandleControllerState+2E   j  ; was: loc_BC4
                bclr    #7,d0
                move.b  d0,(byte_FFF705).w
                move.b  #$80,(byte_FFF807).w
Input_HandleControllerState_Return:                     ; CODE XREF: Input_HandleControllerState+8   j  ; was: locret_BD2
                                        ; Input_HandleControllerState+28   j
                rts
; End of function Input_HandleControllerState
; Handles timed events and callbacks during VBlank
Sys_VBlankEventHandler:                                 ; CODE XREF: VBLANK+96   p  ; was: sub_BD4
                                        ; Sys_VBlankHandler+4A   p
                move.w  (word_FFF762).w,d0
                beq.w   Sys_VBlankEventHandler_CheckInput
                subq.w  #1,d0
                move.w  d0,(word_FFF762).w
                bra.w   Sys_VBlankEventHandler_UpdateSound
; ---------------------------------------------------------------------------
Sys_VBlankEventHandler_CheckInput:                      ; CODE XREF: Sys_VBlankEventHandler+4   j  ; was: loc_BE6
                move.b  (byte_FFF764).w,d0
                beq.w   Sys_VBlankEventHandler_UpdateSound
                jsr     (Sound_QueueRequest).l
                beq.w   Sys_VBlankEventHandler_UpdateSound
                clr.b   (byte_FFF764).w
Sys_VBlankEventHandler_UpdateSound:                     ; CODE XREF: Sys_VBlankEventHandler+E   j  ; was: loc_BFC
                                        ; Sys_VBlankEventHandler+16   j
                tst.b   (byte_FFF745).w
                bne.w   Sys_VBlankEventHandler_Return
                move.b  #1,(byte_FFF745).w
                jsr     (Sound_UpdateThunk).l
                clr.b   (byte_FFF745).w
Sys_VBlankEventHandler_Return:                          ; CODE XREF: Sys_VBlankEventHandler+2C   j  ; was: locret_C14
                rts
; End of function Sys_VBlankEventHandler
; Updates global game timers including word_FFA282 countdown and word_FFA280 frame counter
Sys_UpdateTimers:                                       ; CODE XREF: Sys_VBlankHandler+58   p  ; was: sub_C16
                tst.w   (word_FFA282).w
                beq.s   Sys_UpdateTimers_AdvanceFrame
                subq.w  #1,(word_FFA282).w
Sys_UpdateTimers_AdvanceFrame:                          ; CODE XREF: Sys_UpdateTimers+4   j  ; was: loc_C20
                addq.w  #1,(word_FFA280).w
                bra.s   Sys_DispatchGameState_Run
; End of function Sys_UpdateTimers
; Checks game flags and dispatches to current game state handler via jump table
Sys_DispatchGameState:
                move.b  (byte_FFF705).w,d0              ; was: sub_C26
                bpl.w   Sys_DispatchGameState_Run
                btst    #6,d0
                beq.w   Sys_DispatchGameState_Run
                move.b  (word_FFF706).w,d0
                or.b    (word_FFF706+1).w,d0
                andi.b  #$70,d0                         ; 'p'
                cmpi.b  #$70,d0                         ; 'p'
                bne.w   Sys_DispatchGameState_Run
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.b  #4,(dword_FFF80A).w
                clr.b   (byte_FFF807).w
                clr.w   (word_FFF720).w
                clr.w   (GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
Sys_DispatchGameState_Run:                              ; CODE XREF: Sys_UpdateTimers+E   j  ; was: loc_C6C
                                        ; Sys_DispatchGameState+4   j
                jsr     (Demo_PlaybackSystem).l
                move.w  (GameModeIndex).w,d0
                movea.l Sys_GameStateHandlers(pc,d0.w),a0
                jmp     (a0)
; ---------------------------------------------------------------------------
Sys_GameStateHandlers:  dc.l    Sys_CheckRegionLock     ; was: off_C7C
                dc.l    UI_InitializeResultsScreen
                dc.l    Sys_UpdateGameLoop
                dc.l    Stage_LoadBackgroundGraphics
                dc.l    Sys_GameplayMainLoop
                dc.l    UI_InitTitleScreen
                dc.l    UI_HandleTitleInput
                dc.l    UI_InitOptionsScreen
                dc.l    UI_UpdateOptionsScreen
                dc.l    Gfx_ClearPlanesAndInit
                dc.l    Sys_StoryScreenMainLoop
                dc.l    UI_InitializeStageSelect
                dc.l    UI_DispatchStageState
                dc.l    UI_InitializeWeaponSelect
                dc.l    UI_HandleMenuTextTransition
                dc.l    UI_InitializePasswordScreen
                dc.l    UI_UpdatePasswordDisplay
                dc.l    UI_InitPasswordScreen
                dc.l    UI_UpdatePasswordScreen
                dc.l    UI_InitSecondaryOptionsMenu
                dc.l    UI_UpdateSecondaryOptionsMenu
                dc.l    Stage_InitializeStageSelect
                dc.l    Password_InitializeScreen
                dc.l    Password_HandleInput
                dc.l    Credits_InitializeScreen
                dc.l    Credits_UpdateEffects
                dc.l    Sys_TransitionToStageInit
                dc.l    Sys_StageTransitionUpdate
                dc.l    UI_InitializeStageStart
                dc.l    Sys_UpdateGameplayLoop
                dc.l    Stage_InitGameOver
                dc.l    Effect_CopyGameOverPalette
                dc.l    Stage_XiTigerHandler
                dc.l    Results_InitializeScreen
                dc.l    Results_MainLoop
                dc.l    Credits_InitXiTiger
                dc.l    Credits_MainLoop
; ---------------------------------------------------------------------------
                rts
; End of function Sys_DispatchGameState
; Performs VBlank DMA transfers for VRAM CRAM and VSRAM including sprite and scroll plane updates
