Stage_InitPlayerAndScroll:                              ; DATA XREF: ROM:0001E850   o  ; was: sub_1EDC2
                move.w  #$7FFF,(StageTimeRemaining).w
                jsr     (Player_InitializeStats).l
                move.w  #$5C,(word_FFA404).w            ; '\'
                move.b  #0,(word_FFF7F4+1).w
                lea     stru_1EE12(pc),a0
                nop
                jsr     (LoadObjData).l
                lea     (Stage33PaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.w  #$1000,(dword_FFA900).w
                move.w  #$EC00,(dword_FFA904).w
                jsr     (Scroll_GetForegroundPosition).l
                move.w  #$EC10,(dword_FFA904).w
                move.w  #$8000,(word_FF808A).w
                rts
; End of function Stage_InitPlayerAndScroll
; ---------------------------------------------------------------------------
stru_1EE12:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_InitPlayerAndScroll+18   o
                dc.l    tiles_1CA32E                    ; field_2
                dc.w    0                               ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1CD746                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1CD7EC                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1C1A36                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Main gameplay update loop
Stage_UpdateGameplay:                                   ; DATA XREF: ROM:0001E866   o  ; was: sub_1EE3C
                jsr     (Player_Update).l
                jsr     (Boss_ZLeoMainController).l
                jsr     (Sys_UpdateObjectSpawner).l
                jsr     (Sys_ProcessProjectiles).l
                jmp     Gfx_GetCameraPosition
; End of function Stage_UpdateGameplay
; Transitions to credits screen
Stage_TransitionToCredits:                              ; DATA XREF: ROM:0001E852   o  ; was: sub_1EE5A
                move.b  #0,(word_FFF7F4+1).w
                jmp     (Cutscene_InitCreditsScreen).l
; End of function Stage_TransitionToCredits
; Handles credits or advances stage
Stage_HandleCreditsOrAdvance:                           ; DATA XREF: ROM:0001E868   o  ; was: sub_1EE66
                tst.w   (dword_FF8128).w
                bne.w   loc_1EE74
                jmp     (Cutscene_CreditsDispatcher).l
; ---------------------------------------------------------------------------
loc_1EE74:                                              ; CODE XREF: Stage_HandleCreditsOrAdvance+4   j
                clr.w   (word_FF820C).w
                addq.w  #2,(StageTableIndex).w
                bclr    #7,(dword_FFA20E).w
                clr.b   (byte_FFA209).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.b  #$97,d0
                jsr     (Sound_QueueBGMRequest).l
                jmp     UI_TransitionToStageLoad
; End of function Stage_HandleCreditsOrAdvance
; Initializes stage start with full game setup
UI_InitializeStageStart:                                ; DATA XREF: Sys_DispatchGameState+C6   o  ; was: sub_1EE9E
                tst.w   (GameSubstateIndex).w
                bne.s   UI_LoadStageGraphics
                clr.w   (word_FFA29C).w
                clr.b   (byte_FFFF31).w
                move.w  #2,(ShootingMode).w
                jsr     (Sys_InitGameMode).l
                jsr     (Sys_ClearEntityObjectPool).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp     Gfx_QueueLargeFontDMA
; ---------------------------------------------------------------------------
; Loads stage graphics palettes and initializes systems
UI_LoadStageGraphics:                                   ; CODE XREF: UI_InitializeStageStart+4   j  ; was: loc_1EEEA
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                lea     stru_1EFB8(pc),a0
                nop
                jsr     (LoadObjData).l
                move.b  #1,(byte_FF7001).l
                clr.w   d0
                clr.w   d1
                lea     (Gfx_DefaultVRAMTransferParameters).l,a0
                jsr     (Gfx_DirectVRAMTransfer).l
                jsr     (nullsub_1).l
                bsr.w   WeaponSetup_ClearLoadoutAndRefillAmmo
                jsr     (Player_InitializeStats).l
                bsr.w   Gfx_InitColorTables
                move.w  #$20,(word_FFF74A).w            ; ' '
                clr.w   (word_FFF74E).w
                move.w  #6,(word_FF8090).w
                move.b  #2,(byte_FFA95A).w
                move.w  #$7000,d0
                move.w  d0,(word_FF8200).w
                move.w  d0,(word_FF8202).w
                move.w  d0,(word_FF8206).w
                move.w  (word_FFA216).w,(word_FF820A).w
                move.w  #$12,(word_FFA02A).w
                move.w  #$DA,(dword_FFA410).w
                move.w  #$130,(dword_FFA414).w
                move.w  #$330,(StageTimeRemaining).w
                bset    #0,(byte_FFA272).w
                move.w  #$8000,(word_FF808A).w
                lea     (StageStartPaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                bsr.w   WeaponSetup_InitializeTextAndTiles
                jsr     (Gfx_LoadPaletteData).l
                move.b  #$8E,d0
                jsr     (Sound_QueueBGMRequest).l
                move.l  #$1400000,(dword_FF8130).w
                clr.w   (dword_FF8134).w
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(byte_FFF755).w
                jmp     (Gfx_FadePaletteTransition).l
; End of function UI_InitializeStageStart
; ---------------------------------------------------------------------------
stru_1EFB8:     dc.w    3                               ; field_0
                                        ; DATA XREF: UI_InitializeStageStart+54   o
                dc.l    byte_18DFFA                     ; field_2
                dc.w    $5800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18140E                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18E24C                     ; field_2
                dc.w    $E300                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F276E                     ; field_2
                dc.w    $DE00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18E350                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18E2A2                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18DF92                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    3                               ; field_0 ; another compression type?
                dc.l    byte_18DA38                     ; field_2
                dc.w    $F680                           ; field_6
                dc.w    $FFFF

; Initializes color lookup tables in RAM
Gfx_InitColorTables:                                    ; CODE XREF: UI_InitializeStageStart+88   p  ; was: sub_1F002
                lea     (word_FF0D00).l,a0
                lea     (word_FF0D80).l,a1
                lea     (word_FF0E00).l,a2
                move.w  #$FF,d1
                moveq   #$3F,d7                         ; '?'
loc_1F01A:                                              ; CODE XREF: Gfx_InitColorTables+1E   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                dbf     d7,loc_1F01A
                move.b  #$82,(byte_FF78FF).l
                rts
; End of function Gfx_InitColorTables
; Initializes weapon-setup text and the six force-name tile regions
WeaponSetup_InitializeTextAndTiles:                     ; CODE XREF: UI_InitializeStageStart+E8   p  ; was: sub_1F02E
                bsr.w   WeaponSetup_RenderHeading
                bsr.w   WeaponSetup_FindControlTypeIndex
                bsr.w   WeaponSetup_RenderStatusWindowLabel
                bsr.w   WeaponSetup_RenderExitText
                lea     WeaponSetup_ForceTextLayout(pc),a2
                nop
                moveq   #0,d7
WeaponSetup_InitializeForceTileLoop:                    ; CODE XREF: WeaponSetup_InitializeTextAndTiles+2C   j  ; was: loc_1F046
                move.w  (a2,d7.w),d3
                subq.w  #6,d3
                move.w  d7,d0
                jsr     (Sprite_SetupTileVDP).l
                addq.w  #2,d7
                cmpi.w  #$C,d7
                bmi.s   WeaponSetup_InitializeForceTileLoop
WeaponSetup_StateWaitReturn:                            ; CODE XREF: WeaponSetup_HandleLoadoutState+C   j  ; was: locret_1F05C
                                        ; WeaponSetup_HandleControlTypeInput+C   j
                rts
; End of function WeaponSetup_InitializeTextAndTiles
; Clears all four loadout slots, then refills their runtime ammunition
WeaponSetup_ClearLoadoutAndRefillAmmo:                  ; CODE XREF: UI_InitializeStageStart+7E   p  ; was: sub_1F05E
                clr.w   (WeaponSlotOffset).w
                clr.w   (word_FFA250).w
                clr.w   (word_FFA252).w
                clr.w   (word_FFA254).w
                clr.w   (word_FFA256).w
; End of function WeaponSetup_ClearLoadoutAndRefillAmmo
; Refills the eight weapon-ammunition words used by the setup screen
WeaponSetup_RefillAmmo:                                 ; CODE XREF: WeaponSetup_HandleLoadoutState+16   p  ; was: sub_1F072
                                        ; WeaponSetup_HandleShootingModeInput+C   p
                movea.w #(word_FFA260-M68K_RAM),a0
                move.w  #$3E8,d0
                moveq   #7,d7
WeaponSetup_RefillAmmoLoop:                             ; CODE XREF: WeaponSetup_RefillAmmo+C   j  ; was: loc_1F07C
                move.w  d0,(a0)+
                dbf     d7,WeaponSetup_RefillAmmoLoop
                rts
; End of function WeaponSetup_RefillAmmo
; Main gameplay loop with player physics and rendering
Sys_UpdateGameplayLoop:                                 ; DATA XREF: Sys_DispatchGameState+CA   o  ; was: sub_1F084
                jsr     (Object_ApplyCameraMotion).l
                jsr     (Collision_UpdateSystem).l
                jsr     (Sprite_InitializePriorityBuckets).l
                jsr     (Sys_BeginVisibleObjectList).l
                jsr     (UI_BuildHUDSpriteList).l
                jsr     (UI_RenderHUDElement1).l
                jsr     (Player_Update).l
                jsr     (Weapon_UpdateStateAndSlotAnimations).l
                jsr     (Sys_ProcessProjectiles).l
                jsr     (Sys_ProcessVisibleObjects).l
                bsr.w   WeaponSetup_UpdateAndDispatchState
                jsr     (Sys_UpdateObjectCount).l
                jsr     (Sprite_RenderObjectList).l
                jsr     (Gfx_FadePaletteTransition).l
                jsr     (Gfx_SetupScrollPlanes).l
                addq.w  #1,(word_FFA000).w
                bclr    #0,(word_FF80F4).w
                beq.s   loc_1F0EE
                addq.w  #2,(GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1F0EE:                                              ; CODE XREF: Sys_UpdateGameplayLoop+62   j
                bclr    #1,(word_FF80F4).w
                bne.s   loc_1F0F8
                rts
; ---------------------------------------------------------------------------
loc_1F0F8:                                              ; CODE XREF: Sys_UpdateGameplayLoop+70   j
                tst.w   (StageTableIndex).w
                bne.s   UI_TransitionToContinueScreen
                move.l  #byte_1E444,(dword_FFA22C).w    ; text?
                move.w  #$34,(GameModeIndex).w          ; '4'
                clr.w   (GameSubstateIndex).w
                jsr     (Sound_QueueStageBGMOrStop).l
                jmp     UI_InitializeGameVariables
; ---------------------------------------------------------------------------
; Transitions to continue screen after stage end
UI_TransitionToContinueScreen:                          ; CODE XREF: Sys_UpdateGameplayLoop+78   j  ; was: loc_1F11C
                move.w  #$3C,(GameModeIndex).w          ; '<'
                clr.w   (GameSubstateIndex).w
                jmp     UI_ResetPaletteAndMessageMode_Clear
; End of function Sys_UpdateGameplayLoop
; Updates the setup background and dispatches the current setup-screen state
WeaponSetup_UpdateAndDispatchState:                     ; CODE XREF: Sys_UpdateGameplayLoop+3C   p  ; was: sub_1F12C
                bsr.w   WeaponSetup_UpdateBackgroundEffect
                move.w  (word_FFA29C).w,d0
                movea.w WeaponSetup_StateHandlerOffsets(pc,d0.w),a0
                adda.l  #WeaponSetup_HandleLoadoutState,a0
                jmp     (a0)
; End of function WeaponSetup_UpdateAndDispatchState
; ---------------------------------------------------------------------------
WeaponSetup_StateHandlerOffsets:    dc.w    WeaponSetup_HandleLoadoutState-WeaponSetup_HandleLoadoutState  ; was: off_1F140
                                        ; DATA XREF: WeaponSetup_UpdateAndDispatchState+8   r
                dc.w    WeaponSetup_HandleControlTypeInput-WeaponSetup_HandleLoadoutState
                dc.w    WeaponSetup_HandleExitInput-WeaponSetup_HandleLoadoutState
                dc.w    WeaponSetup_UpdateSlotFade-WeaponSetup_HandleLoadoutState
                dc.w    WeaponSetup_LoadControlTestText-WeaponSetup_HandleLoadoutState
                dc.w    WeaponSetup_WaitForConfirmInput-WeaponSetup_HandleLoadoutState
                dc.w    WeaponSetup_IdleState-WeaponSetup_HandleLoadoutState

; Handles the four-slot loadout-selection state
WeaponSetup_HandleLoadoutState:                         ; DATA XREF: WeaponSetup_UpdateAndDispatchState+C   o  ; was: sub_1F14E
                                        ; ROM:WeaponSetup_StateHandlerOffsets   o
                bsr.w   WeaponSetup_RenderSlotSprites
                bsr.w   WeaponSetup_UpdateHighlightPalette
                bsr.w   WeaponSetup_UpdateHorizontalScroll
                bne.w   WeaponSetup_StateWaitReturn
                move.w  #$12,(word_FFA02A).w
                bsr.w   WeaponSetup_RefillAmmo
                bsr.w   WeaponSetup_HandleLoadoutInput
                btst    #0,(word_FFA280+1).w
                bne.s   WeaponSetup_RenderSelectedSlotCursor
                rts
; ---------------------------------------------------------------------------
; Renders the cursor for the currently selected loadout slot
WeaponSetup_RenderSelectedSlotCursor:                   ; CODE XREF: WeaponSetup_HandleLoadoutState+24   j  ; was: loc_1F176
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w a0,a1
                move.w  (dword_FF8128).w,d0
                move.w  WeaponSetup_SlotCursorYPositions(pc,d0.w),(a1)+
                move.w  #$B00,(a1)+
                move.w  #$C6F0,(a1)+
                move.w  WeaponSetup_SlotCursorXPositions(pc,d0.w),(a1)+
                move.w  #$FFFF,(a1)+
                jmp     (Sprite_AppendOAMEntries).l
; End of function WeaponSetup_HandleLoadoutState
; ---------------------------------------------------------------------------
WeaponSetup_SlotCursorXPositions:   dc.w    $97, $127, $97, $127, $97, $127  ; was: word_1F19A
                                        ; DATA XREF: WeaponSetup_HandleLoadoutState+3E   r
WeaponSetup_SlotCursorYPositions:   dc.w    $B8, $B8, $C8, $C8, $D8, $D8  ; was: word_1F1A6
                                        ; DATA XREF: WeaponSetup_HandleLoadoutState+32   r
