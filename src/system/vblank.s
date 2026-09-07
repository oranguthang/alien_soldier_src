VBLANK:                                                 ; DATA XREF: ROM:00000078   o
                move    #$2700,sr
loc_A7E:                                                ; CODE XREF: VBLANK+C   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_A7E
                move.b  #1,(byte_A01FFF).l
loc_A90:                                                ; CODE XREF: VBLANK+1E   j
                bclr    #0,(IO_Z80BUS).l
                beq.s   loc_A90
                movem.l d0-d7/a0-a5,-(sp)
loc_A9E:                                                ; CODE XREF: VBLANK+2E   j
                move.w  (VDP_CTRL).l,d0
                andi.w  #8,d0
                beq.s   loc_A9E
                btst    #6,(byte_FFFF26).w
                beq.w   loc_ABC
                move.w  #$300,d0
loc_AB8:                                                ; CODE XREF: VBLANK:loc_AB8   j
                dbf     d0,loc_AB8
loc_ABC:                                                ; CODE XREF: VBLANK+36   j
                jsr     (VBlank_EffectDispatcher).l
                bsr.w   Gfx_UpdateVDPDisplay
                tst.b   (byte_FF830E).w
                beq.s   loc_AD8
                subq.b  #1,(byte_FF830E).w
                bne.s   loc_AD8
                move.b  #1,(dword_FFF80A+3).w
loc_AD8:                                                ; CODE XREF: VBLANK+50   j
                                        ; VBLANK+56   j
                subq.w  #1,(word_FF8096).w
                bpl.s   loc_AEA
                move.w  #4,d0
                sub.w   (word_FFFF3E).w,d0
                move.w  d0,(word_FF8096).w
loc_AEA:                                                ; CODE XREF: VBLANK+62   j
                tst.b   (byte_FFF704).w
                bne.s   Sys_VBlankHandler
loc_AF0:                                                ; CODE XREF: VBLANK+7E   j
                                        ; Sys_VBlankHandler+12   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_AF0
                move.b  #0,(byte_A01FFF).l
loc_B02:                                                ; CODE XREF: VBLANK+90   j
                bclr    #0,(IO_Z80BUS).l
                beq.s   loc_B02
                move    #$2300,sr
                bsr.w   Sys_VBlankEventHandler
                movem.l (sp)+,d0-d7/a0-a5
                rte
; End of function VBLANK

; Extended VBlank interrupt handler that manages sound Z80 bus acquisition VDP updates and input processing
Sys_VBlankHandler:                                      ; CODE XREF: VBLANK+74   j  ; was: sub_B1A
                tst.w   (word_FFFF3E).w
                beq.s   loc_B2E
                tst.b   (byte_FF813E).w
                bmi.s   loc_B2E
                cmpi.w  #1,(word_FF8096).w
                beq.s   loc_AF0
loc_B2E:                                                ; CODE XREF: Sys_VBlankHandler+4   j
                                        ; Sys_VBlankHandler+A   j
                clr.b   (byte_FFF704).w
                bsr.w   Sound_AcquireZ80Bus
                bsr.w   Gfx_VBlankDMATransfer
                bsr.w   Gfx_ApplyVDPSettings
                jsr     (Sys_InitVDPRegisters).l
loc_B44:                                                ; CODE XREF: Sys_VBlankHandler+32   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_B44
                move.b  #0,(byte_A01FFF).l
loc_B56:                                                ; CODE XREF: Sys_VBlankHandler+44   j
                bclr    #0,(IO_Z80BUS).l
                beq.s   loc_B56
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
                beq.w   locret_BD2
                clr.b   d1
                btst    #0,d0
                beq.w   loc_B9C
                or.b    (word_FFF708).w,d1
loc_B9C:                                                ; CODE XREF: Input_HandleControllerState+12   j
                btst    #1,d0
                beq.w   loc_BA8
                or.b    (word_FFF708+1).w,d1
loc_BA8:                                                ; CODE XREF: Input_HandleControllerState+1E   j
                tst.b   d1
                bpl.w   locret_BD2
                tst.b   d0
                bmi.w   loc_BC4
                bset    #7,d0
                move.b  d0,(byte_FFF705).w
                move.b  #1,(byte_FFF807).w
                rts
; ---------------------------------------------------------------------------
loc_BC4:                                                ; CODE XREF: Input_HandleControllerState+2E   j
                bclr    #7,d0
                move.b  d0,(byte_FFF705).w
                move.b  #$80,(byte_FFF807).w
locret_BD2:                                             ; CODE XREF: Input_HandleControllerState+8   j
                                        ; Input_HandleControllerState+28   j
                rts
; End of function Input_HandleControllerState
; Handles timed events and callbacks during VBlank
Sys_VBlankEventHandler:                                 ; CODE XREF: VBLANK+96   p  ; was: sub_BD4
                                        ; Sys_VBlankHandler+4A   p
                move.w  (word_FFF762).w,d0
                beq.w   loc_BE6
                subq.w  #1,d0
                move.w  d0,(word_FFF762).w
                bra.w   loc_BFC
; ---------------------------------------------------------------------------
loc_BE6:                                                ; CODE XREF: Sys_VBlankEventHandler+4   j
                move.b  (byte_FFF764).w,d0
                beq.w   loc_BFC
                jsr     (Input_ProcessButtons).l
                beq.w   loc_BFC
                clr.b   (byte_FFF764).w
loc_BFC:                                                ; CODE XREF: Sys_VBlankEventHandler+E   j
                                        ; Sys_VBlankEventHandler+16   j
                tst.b   (byte_FFF745).w
                bne.w   locret_C14
                move.b  #1,(byte_FFF745).w
                jsr     (Sound_UpdateThunk).l
                clr.b   (byte_FFF745).w
locret_C14:                                             ; CODE XREF: Sys_VBlankEventHandler+2C   j
                rts
; End of function Sys_VBlankEventHandler
; Updates global game timers including word_FFA282 countdown and word_FFA280 frame counter
Sys_UpdateTimers:                                       ; CODE XREF: Sys_VBlankHandler+58   p  ; was: sub_C16
                tst.w   (word_FFA282).w
                beq.s   loc_C20
                subq.w  #1,(word_FFA282).w
loc_C20:                                                ; CODE XREF: Sys_UpdateTimers+4   j
                addq.w  #1,(word_FFA280).w
                bra.s   loc_C6C
; End of function Sys_UpdateTimers
; Checks game flags and dispatches to current game state handler via jump table
Sys_DispatchGameState:
                move.b  (byte_FFF705).w,d0              ; was: sub_C26
                bpl.w   loc_C6C
                btst    #6,d0
                beq.w   loc_C6C
                move.b  (word_FFF706).w,d0
                or.b    (word_FFF706+1).w,d0
                andi.b  #$70,d0                         ; 'p'
                cmpi.b  #$70,d0                         ; 'p'
                bne.w   loc_C6C
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.b  #4,(dword_FFF80A).w
                clr.b   (byte_FFF807).w
                clr.w   (word_FFF720).w
                clr.w   (GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_C6C:                                                ; CODE XREF: Sys_UpdateTimers+E   j
                                        ; Sys_DispatchGameState+4   j
                jsr     (Demo_PlaybackSystem).l
                move.w  (GameModeIndex).w,d0
                movea.l off_C7C(pc,d0.w),a0
                jmp     (a0)
; ---------------------------------------------------------------------------
off_C7C:        dc.l    Sys_CheckRegionLock
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
                dc.l    Sys_InitOptionsMenuState
                dc.l    Sys_RunOptionsMenuLoop
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
