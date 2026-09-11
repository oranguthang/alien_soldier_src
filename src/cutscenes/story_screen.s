Gfx_ClearPlanesAndInit:                                 ; DATA XREF: Sys_DispatchGameState+7A   o  ; was: sub_4840
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000001,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_4866:                                               ; CODE XREF: Gfx_ClearPlanesAndInit+28   j
                move.w  d1,(a0)
                dbf     d0,loc_4866
                move    (sp)+,sr
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$60000002,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
; Clears scroll plane B and initializes game state variables
Gfx_ClearPlaneB:                                        ; CODE XREF: Gfx_ClearPlanesAndInit+56   j  ; was: loc_4894
                move.w  d1,(a0)
                dbf     d0,Gfx_ClearPlaneB
                move    (sp)+,sr
                clr.w   (word_FF00EC).l
                clr.w   (word_FF0178).l
                move.b  #4,(VDPReg18Shadow+1).w
                move.w  #$44,(word_FFF74A).w            ; 'D'
                clr.w   (word_FFF74E).w
                clr.w   (word_FF0176).l
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA90C).w
                jsr     (Gfx_SetupScrollPlanes).l
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; End of function Gfx_ClearPlanesAndInit
; ---------------------------------------------------------------------------
stru_48DA:      dc.w    7                               ; field_0
                                        ; DATA XREF: Gfx_FadeOutToDark+36   o
                dc.l    tiles_18530A                    ; field_2
                dc.w    0                               ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1885A4                     ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1889B0                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    $FFFF

; Main game loop for story screen mode
Sys_StoryScreenMainLoop:                                ; DATA XREF: Sys_DispatchGameState+7E   o  ; was: sub_48FC
                btst    #0,(word_FF80F4).w
                beq.s   loc_491C
                tst.w   (word_FF0176).l
                bne.s   loc_491C
                tst.w   (word_FFF720).w
                bmi.s   loc_491C
                btst    #7,(word_FFF708).w
                bne.w   loc_5102
loc_491C:                                               ; CODE XREF: Sys_StoryScreenMainLoop+6   j
                                        ; Sys_StoryScreenMainLoop+E   j
                jsr     (Object_ApplyCameraMotion).l
                jsr     (Sprite_InitializePriorityBuckets).l
                jsr     (Sys_BeginVisibleObjectList).l
                jsr     (Sys_ProcessVisibleObjects).l
                bsr.w   Sys_StoryScreenDispatcher
                bsr.w   UI_StoryTextDispatcher
                bsr.w   UI_JapaneseTextDispatcher
                jsr     (Sys_UpdateObjectCount).l
                jsr     (Sprite_RenderObjectList).l
                jsr     (Gfx_FadePaletteTransition).l
                jsr     (Gfx_SetupScrollPlanes).l
                addq.w  #1,(word_FFA000).w
                rts
; End of function Sys_StoryScreenMainLoop
; Dispatches story screen state machine based on timer
Sys_StoryScreenDispatcher:                              ; CODE XREF: Sys_StoryScreenMainLoop+38   p  ; was: sub_495E
                subq.w  #1,(word_FF0106).l
                move.w  (GameSubstateIndex).w,d0
                lea     off_4970(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Sys_StoryScreenDispatcher
; ---------------------------------------------------------------------------
off_4970:       dc.w    Sys_InitStoryScreenTimer-*      ; DATA XREF: Sys_StoryScreenDispatcher+A   o
                dc.w    UI_WaitForTimerAndButton-*
                dc.w    Gfx_WaitForTimerAndResetFade-*
                dc.w    Gfx_FadeOutToDark-*
                dc.w    Gfx_FadeToTargetAndSetupScroll-*
                dc.w    Gfx_WaitForFadeAndLoadTiles-*
                dc.w    Gfx_FadeInFromDark-*
                dc.w    UI_WaitForTimerShort-*
                dc.w    Gfx_SetupTitleScreenLetters-*
                dc.w    Gfx_AnimateLettersExpand-*
                dc.w    Gfx_AnimateLettersExpandLarge-*
                dc.w    Sys_TransitionToTitleScreen-*
                dc.w    Sys_ExitStoryScreen-*

; Initializes story screen state timer
Sys_InitStoryScreenTimer:                               ; DATA XREF: ROM:off_4970   o  ; was: sub_498A
                move.w  #$2900,(word_FF0106).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Sys_InitStoryScreenTimer
; Waits for specific timer value then processes button input
UI_WaitForTimerAndButton:                               ; DATA XREF: ROM:00004972   o  ; was: sub_4998
                cmpi.w  #$18C0,(word_FF0106).l
                bne.w   locret_514E
                move.b  #1,d0
                jsr     (Sound_QueueRequest).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function UI_WaitForTimerAndButton
; Waits for timer value then resets fade state
Gfx_WaitForTimerAndResetFade:                           ; DATA XREF: ROM:00004974   o  ; was: sub_49B4
                cmpi.w  #$1880,(word_FF0106).l
                bne.w   locret_514E
                move.w  #0,(word_FF0176).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_WaitForTimerAndResetFade
; Fades out palette to dark then loads new graphics data
Gfx_FadeOutToDark:                                      ; DATA XREF: ROM:00004976   o  ; was: sub_49CE
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   locret_514E
                movea.l #stru_48DA,a0
                jsr     (Data_ProcessPointer).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_FadeOutToDark
; Fades to target palette and sets up scrolling data
Gfx_FadeToTargetAndSetupScroll:                         ; DATA XREF: ROM:00004978   o  ; was: sub_4A16
                move.w  #$FFF2,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FFF720).w
                bmi.w   locret_514E
                move.l  #Gfx_ScrollVRAMTransferParameters,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                clr.w   (dword_FFA908).w
                clr.w   (dword_FFA90C).w
                move.w  #0,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_FadeToTargetAndSetupScroll
; Waits for fade completion then loads tile data via DMA
Gfx_WaitForFadeAndLoadTiles:                            ; DATA XREF: ROM:0000497A   o  ; was: sub_4A5C
                move.w  #$FFF2,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   locret_514E
                lea     (StoryScreenPaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.w  #$FFF2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.b  #$88,d0
                jsr     (Sound_QueueRequest).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_WaitForFadeAndLoadTiles
; Fades in palette from dark to normal brightness
Gfx_FadeInFromDark:                                     ; DATA XREF: ROM:0000497C   o  ; was: sub_4ACE
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_514E
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   locret_514E
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_FadeInFromDark
; Waits for short timer value then processes input
UI_WaitForTimerShort:                                   ; DATA XREF: ROM:0000497E   o  ; was: sub_4B08
                cmpi.w  #$80,(word_FF0106).l
                bne.w   locret_514E
                move.b  #1,d0
                jsr     (Sound_QueueRequest).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function UI_WaitForTimerShort
; Sets up VDP for title screen letter animation via DMA
