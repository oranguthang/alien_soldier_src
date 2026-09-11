UI_DispatchCutsceneState:                               ; DATA XREF: ROM:0001CF74   o  ; was: sub_1D13E
                move.w  (word_FF00EC).l,d0
                lea     off_1D14C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function UI_DispatchCutsceneState
; ---------------------------------------------------------------------------
off_1D14C:      dc.w    Effect_FadeOutPlanet-*          ; DATA XREF: UI_DispatchCutsceneState+6   o
                dc.w    Sys_WaitForFrameDelay-*
                dc.w    Effect_RevealPlanetPattern-*

; Fades out planet graphic and transitions state
Effect_FadeOutPlanet:                                   ; DATA XREF: ROM:off_1D14C   o  ; was: sub_1D152
                jsr     (Cutscene_RenderPlanetSpriteGrid).l
                jsr     (Cutscene_ErasePlanetPatternStep).l
                cmpi.w  #$40,(PatternDissolveStep).l    ; '@'
                bne.w   locret_1D3D8
                move.w  #$40,(word_FF8100).w            ; '@'
                addq.w  #2,(word_FF00EC).l
                rts
; End of function Effect_FadeOutPlanet
; Waits for frame delay timer to expire
Sys_WaitForFrameDelay:                                  ; DATA XREF: ROM:0001D14E   o  ; was: sub_1D178
                subq.w  #1,(word_FF8100).w
                bne.w   locret_1D3D8
                addq.w  #2,(word_FF00EC).l
                rts
; End of function Sys_WaitForFrameDelay
; Restores the planet-pattern dissolve and checks for completion
Effect_RevealPlanetPattern:                             ; DATA XREF: ROM:0001D150   o  ; was: sub_1D188
                jsr     (Cutscene_RenderPlanetSpriteGrid).l
                jsr     (Cutscene_RevealPlanetPatternStep).l
                tst.w   (PatternDissolveStep).l
                bpl.w   locret_1D3D8
                move.w  #$80,(word_FF8100).w
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Effect_RevealPlanetPattern
; Sets up title screen with palettes and graphics
UI_InitializeTitleScreen:                               ; DATA XREF: ROM:0001CF76   o  ; was: sub_1D1AA
                addq.w  #2,(GameSubstateIndex).w
                movea.l #dword_1D25E,a0
                movea.w #(word_FFE340-M68K_RAM),a1
                moveq   #7,d7
; Loads title screen data structures in loop
UI_LoadTitleData:                                       ; CODE XREF: UI_InitializeTitleScreen+12   j  ; was: loc_1D1BA
                move.l  (a0)+,(a1)+
                dbf     d7,UI_LoadTitleData
                movea.l #stru_1D254,a0
                jsr     (Data_ProcessPointer).l
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$C000,2(a0)
                move.w  #$C200,$E(a0)
                clr.b   $20(a0)
                move.l  #word_E98C2,8(a0)
                move.w  #$120,$10(a0)
                move.w  #$E4,$14(a0)
                move.w  #$400,(SpriteGridFirstTile).l
                move.w  #$E8,(SpriteGridCenterY).l
                move.w  #$120,(SpriteGridCenterX).l
                move.w  #2,(SpriteGridRowLimit).l
                move.w  #1,(SpriteGridColumnLimit).l
                move.l  #$40000002,(PatternVDPCommand).l
                move.w  #$F,(word_FF00C4).l
                move.w  #0,(PatternFrameMask).l
                clr.w   (PatternDissolveStep).l
                jsr     (Cutscene_FillPlanetPattern).l
                jsr     (Cutscene_RenderPlanetSpriteGrid).l
                clr.w   (word_FF00EC).l
                rts
; End of function UI_InitializeTitleScreen
; ---------------------------------------------------------------------------
stru_1D254:     dc.w    7                               ; field_0
                                        ; DATA XREF: UI_InitializeTitleScreen+16   o
                dc.l    tiles_ED4B4                     ; field_2
                dc.w    $A000                           ; field_6
                dc.w    $FFFF
dword_1D25E:    dc.l    0, $EEE0F00                     ; DATA XREF: UI_InitializeTitleScreen+4   o
                dc.l    2, $E240602
                dc.l    $AE0000, 0
                dc.l    0, 0

; Dispatches story screen state handler
UI_DispatchStoryState:                                  ; DATA XREF: ROM:0001CF78   o  ; was: sub_1D27E
                move.w  (word_FF00EC).l,d0
                lea     off_1D28C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function UI_DispatchStoryState
; ---------------------------------------------------------------------------
off_1D28C:      dc.w    Effect_FadeOutStoryScreen-*     ; DATA XREF: UI_DispatchStoryState+6   o
                dc.w    Sys_WaitForStoryDelay-*
                dc.w    UI_InitializeGameScreen-*
                dc.w    Effect_FadeOutStoryScreen-*
                dc.w    Sys_WaitForGameDelay-*
                dc.w    Effect_RevealGamePattern-*
                dc.w    Sys_TransitionToStoryScreen-*

; Fades out story screen and transitions
Effect_FadeOutStoryScreen:                              ; DATA XREF: ROM:off_1D28C   o  ; was: sub_1D29A
                                        ; ROM:0001D292   o
                jsr     (Cutscene_RenderPlanetSpriteGrid).l
                jsr     (Cutscene_ErasePlanetPatternStep).l
                cmpi.w  #$40,(PatternDissolveStep).l    ; '@'
                bne.w   locret_1D3D8
                move.w  #$40,(word_FF8100).w            ; '@'
                addq.w  #2,(word_FF00EC).l
                rts
; End of function Effect_FadeOutStoryScreen
; Waits for story screen delay timer
Sys_WaitForStoryDelay:                                  ; DATA XREF: ROM:0001D28E   o  ; was: sub_1D2C0
                subq.w  #1,(word_FF8100).w
                bne.w   locret_1D3D8
                addq.w  #2,(word_FF00EC).l
                rts
; End of function Sys_WaitForStoryDelay
; Restores the game-transition pattern, then configures the next sprite grid
UI_InitializeGameScreen:                                ; DATA XREF: ROM:0001D290   o  ; was: sub_1D2D0
                jsr     (Cutscene_RenderPlanetSpriteGrid).l
                jsr     (Cutscene_RevealPlanetPatternStep).l
                tst.w   (PatternDissolveStep).l
                bpl.w   locret_1D3D8
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$C000,2(a0)
                move.w  #$A000,$E(a0)
                clr.b   $20(a0)
                move.l  #word_1D5E0,8(a0)
                move.w  #$120,$10(a0)
                move.w  #$E8,$14(a0)
                move.w  #$400,(SpriteGridFirstTile).l
                move.w  #$E8,(SpriteGridCenterY).l
                move.w  #$120,(SpriteGridCenterX).l
                move.w  #1,(SpriteGridRowLimit).l
                move.w  #5,(SpriteGridColumnLimit).l
                move.l  #$40000002,(PatternVDPCommand).l
                move.w  #$F,(word_FF00C4).l
                move.w  #0,(PatternFrameMask).l
                clr.w   (PatternDissolveStep).l
                jsr     (Cutscene_FillPlanetPattern).l
                jsr     (Cutscene_RenderPlanetSpriteGrid).l
                addq.w  #2,(word_FF00EC).l
                rts
; End of function UI_InitializeGameScreen
; Waits for game screen delay timer
Sys_WaitForGameDelay:                                   ; DATA XREF: ROM:0001D294   o  ; was: sub_1D36E
                subq.w  #1,(word_FF8100).w
                bne.w   locret_1D3D8
                addq.w  #2,(word_FF00EC).l
                rts
; End of function Sys_WaitForGameDelay
; Restores the game-transition pattern and advances to gameplay setup
Effect_RevealGamePattern:                               ; DATA XREF: ROM:0001D296   o  ; was: sub_1D37E
                jsr     (Cutscene_RenderPlanetSpriteGrid).l
                jsr     (Cutscene_RevealPlanetPatternStep).l
                tst.w   (PatternDissolveStep).l
                bpl.w   locret_1D3D8
                clr.w   (word_FFC622).w
                move.w  #6,(GameSubstateIndex).w
                move.w  #$C,(word_FF00EC).l
                rts
; ---------------------------------------------------------------------------
loc_1D3A8:                                              ; CODE XREF: Sys_UpdateGameLoop+14   j
                cmpi.w  #6,(GameSubstateIndex).w
                bne.s   loc_1D3BC
                cmpi.w  #$C,(word_FF00EC).l
                beq.w   locret_1D3D8
loc_1D3BC:                                              ; CODE XREF: Effect_RevealGamePattern+30   j
                move.w  #$28,(GameModeIndex).w          ; '('
                jmp     (StoryScreen_StartExitFade).l
; End of function Effect_RevealGamePattern
; Clears boss data and transitions to story screen
