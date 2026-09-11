Stage_Stage14Scroll:                                    ; DATA XREF: ROM:0000D99C   o  ; was: sub_DE44
                addq.w  #2,(word_FFA950).w
                move.w  #$50,(MessageSequenceState).w   ; 'P'
; Updates scroll for stage 14 progression
Stage_Stage14Scroll_Update:                             ; DATA XREF: ROM:0000D99E   o  ; was: loc_DE4E
                bsr.w   Gfx_UpdateScroll
                cmpi.w  #$400,(dword_FFA900).w
                bmi.w   Stage_Stage10CheckTransition_Return
                bra.w   Stage_TransitionToNextPhase
; End of function Stage_Stage14Scroll
; Initialize boss tiles and palette with scroll check
Stage_InitBossPaletteScroll:                            ; DATA XREF: ROM:0000D9A0   o  ; was: sub_DE60
                bsr.w   Gfx_LoadBossTiles
                move.w  #$480,d0
                cmp.w   (dword_FFA900).w,d0
                bpl.w   Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (Boss_VictorAssetSet).l,a1
                bra.w   Boss_LoadAssetSet
; End of function Stage_InitBossPaletteScroll
; Initialize score timer and clear scroll variables
Stage_InitScoreTimerClear:                              ; DATA XREF: ROM:0000D9A2   o  ; was: sub_DE8E
                tst.w   (Entity_ObjectPool).w
                bne.s   locret_DEA0
                bsr.w   UI_InitScoreTimer
                clr.w   (dword_FFA908).w
                clr.w   (dword_FFA90C).w
locret_DEA0:                                            ; CODE XREF: Stage_InitScoreTimerClear+4   j
                rts
; End of function Stage_InitScoreTimerClear
; Transitions to Stage 15
Stage_Stage15Transition:                                ; DATA XREF: ROM:0000D9A4   o  ; was: sub_DEA2
                bsr.w   Stage_InitSectionChange
                bra.w   Camera_UpdateTowardsPlayer
; End of function Stage_Stage15Transition
; Stage 15 scroll handler
Stage_Stage15Scroll:                                    ; DATA XREF: ROM:0000D9A6   o  ; was: sub_DEAA
                bsr.w   Gfx_UpdateScroll
                cmpi.w  #$660,(dword_FFA900).w
                bmi.w   Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                move.w  #$660,(dword_FFA900).w
                bset    #6,(byte_FF8245).w
                rts
; End of function Stage_Stage15Scroll
; Check scroll threshold and transition to next phase
Stage_ScrollCheckTransition:                            ; DATA XREF: ROM:0000D9A8   o  ; was: sub_DECA
                bsr.w   Scroll_RenderSylpheedWithUpdate
                cmpi.w  #$E3E8,(dword_FFA904).w
                bmi.w   Stage_Stage10CheckTransition_Return
                bclr    #0,(byte_FF80F8).w
                move.w  #$FFE4,(dword_FF8066+2).w
                move.w  #6,(PaletteSecondaryIndex).w
                bra.w   Stage_TransitionToNextPhase
; End of function Stage_ScrollCheckTransition
; Transitions to Sunset Sting boss
Stage_SunsetStingTransition:                            ; DATA XREF: ROM:0000D9AA   o  ; was: sub_DEEE
                bsr.w   Scroll_UpdateVerticalScroll
                move.w  #$E420,d0
                cmp.w   (dword_FFA904).w,d0
                bpl.w   Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                move.w  d0,(dword_FFA904).w
                move.w  #$660,(word_FFA970).w
                move.w  #$660,(word_FFA974).w
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                lea     (Boss_SunsetStingAssetSet).l,a1
                bra.w   Boss_LoadAssetSet
; End of function Stage_SunsetStingTransition
; Waits for battle to start
Stage_SunsetStingWaitBattle:                            ; DATA XREF: ROM:0000D9AC   o  ; was: sub_DF26
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_DF30
                bsr.w   Stage_TriggerPhaseTransition
loc_DF30:                                               ; CODE XREF: Stage_SunsetStingWaitBattle+4   j
                bra.w   Camera_UpdateTowardsPlayer
; End of function Stage_SunsetStingWaitBattle
; Transition after Sunset Sting
Stage_PostSunsetStingTransition:                        ; DATA XREF: ROM:0000D9AE   o  ; was: sub_DF34
                bsr.w   Stage_InitSectionChange
                bra.w   Camera_UpdateTowardsPlayer
; End of function Stage_PostSunsetStingTransition
; Viblack stage scroll handler
Stage_ViblackScroll:                                    ; DATA XREF: ROM:0000D9B0   o  ; was: sub_DF3C
                cmpi.w  #$E440,(dword_FFA904).w
                bpl.s   Stage_ViblackStartBattle
                move.l  (dword_FFA900).w,(dword_FF806A+2).w
                move.w  #$660,(dword_FFA900).w
                bsr.w   Scroll_UpdateVerticalScroll
                move.l  (dword_FF806A+2).w,(dword_FFA900).w
                bra.w   Camera_ConstrainToScreenBounds
; End of function Stage_ViblackScroll
; Starts Viblack battle
Stage_ViblackStartBattle:                               ; CODE XREF: Stage_ViblackScroll+6   j  ; was: sub_DF5E
                addq.w  #2,(word_FFA950).w
                move.b  #$8B,d0
                jsr     (Sound_QueueBGMOrStop).l
; End of function Stage_ViblackStartBattle
; Initializes Viblack mini-boss
Stage_ViblackInit:                                      ; DATA XREF: ROM:0000D9B2   o  ; was: sub_DF6C
                addq.w  #2,(word_FFA950).w
                move.w  #$2B8,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
                clr.l   (dword_FF8062+2).w
                clr.w   (dword_FF806A).w
                move.b  #$80,(byte_FFA959).w
                move.w  #$2E,(word_FFA02A).w            ; '.'
; End of function Stage_ViblackInit
; Attributes: thunk
; Constrain camera to screen bounds wrapper
Stage_ConstrainCameraBounds:                            ; DATA XREF: ROM:0000D9B4   o  ; was: sub_DF8E
                bra.w   Camera_ConstrainToScreenBounds
; End of function Stage_ConstrainCameraBounds
; Transitions to Stage 17
Stage_Stage17Transition:                                ; DATA XREF: ROM:0000D9B6   o  ; was: sub_DF92
                cmpi.w  #5,(dword_FF8062+2).w
                bpl.s   Stage_AccelerateVerticalScroll
                addi.l  #$C00,(dword_FF8062+2).w
; Accelerates vertical scroll velocity for stage 17 transition
Stage_AccelerateVerticalScroll:                         ; CODE XREF: Stage_Stage17Transition+6   j  ; was: loc_DFA2
                move.l  (dword_FF8062+2).w,d0
                add.l   d0,(dword_FFA904).w
                move.l  (dword_FFA900).w,(dword_FF806A+2).w
                move.w  #$660,(dword_FFA900).w
                bsr.w   Gfx_RenderSylpheedBackground
                move.l  (dword_FF806A+2).w,(dword_FFA900).w
                bsr.w   Camera_ConstrainToScreenBounds
                cmpi.w  #$E620,(dword_FFA904).w
                bmi.s   locret_DFD0
                addq.w  #2,(word_FFA950).w
locret_DFD0:                                            ; CODE XREF: Stage_Stage17Transition+38   j
                rts
; End of function Stage_Stage17Transition
; Post-Viblack scroll handler
Stage_ViblackPostBattleScroll1:                         ; DATA XREF: ROM:0000D9B8   o  ; was: sub_DFD2
                move.l  (dword_FF8062+2).w,d0
                add.l   d0,(dword_FFA904).w
                bra.w   Camera_ConstrainToScreenBounds
; End of function Stage_ViblackPostBattleScroll1
; Scroll with screen transition and palette fade
Stage_ViblackPostBattleScroll2:                         ; DATA XREF: ROM:0000D9BA   o  ; was: sub_DFDE
                bset    #1,(byte_FF80F8).w
                move.l  (dword_FF8062+2).w,d0
                add.l   d0,(dword_FFA904).w
                move.w  #5,(PaletteEffectControl).w
                subq.w  #1,(dword_FF806A).w
                cmpi.w  #$FFF2,(dword_FF806A).w
                bpl.s   loc_E028
                move.w  #$FFF2,(dword_FF806A).w
                cmpi.w  #$660,(dword_FFA900).w
                bne.s   loc_E028
                addq.w  #2,(word_FFA950).w
                move.w  #$660,(word_FFA970).w
                move.w  #$660,(word_FFA974).w
                lea     (ViblackPostBattleScrollPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
loc_E028:                                               ; CODE XREF: Stage_ViblackPostBattleScroll2+1E   j
                                        ; Stage_ViblackPostBattleScroll2+2C   j
                move.w  (dword_FF806A).w,d0
                movea.w #(byte_FFE322-M68K_RAM),a0
                moveq   #$E,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                clr.w   (dword_FFA900+2).w
                cmpi.w  #$660,(dword_FFA900).w
                beq.s   locret_E054
                bpl.s   loc_E050
                addq.w  #1,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_E050:                                               ; CODE XREF: Stage_ViblackPostBattleScroll2+6A   j
                subq.w  #1,(dword_FFA900).w
locret_E054:                                            ; CODE XREF: Stage_ViblackPostBattleScroll2+68   j
                rts
; End of function Stage_ViblackPostBattleScroll2
; Stage transition after Viblack
Stage_PostViblackTransition:                            ; DATA XREF: ROM:0000D9BC   o  ; was: sub_E056
                addq.w  #2,(word_FFA950).w
                move.w  #$FF80,d0
                move.w  d0,(dword_FFA904).w
                move.w  d0,(word_FFA92C).w
                clr.w   (word_FFA914).w
                move.l  #Gfx_DefaultVRAMTransferParameters,(dword_FFA940).w
                move.w  #$1000,(word_FFA946).w
                move.w  #0,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
; Renders scrolling background after Viblack transition
Stage_PostViblackTransition_Render:                     ; DATA XREF: ROM:0000D9BE   o  ; was: loc_E084
                jsr     (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.s   locret_E098
                addq.w  #2,(word_FFA950).w
                clr.w   (dword_FF806A).w
locret_E098:                                            ; CODE XREF: Stage_PostViblackTransition+38   j
                rts
; End of function Stage_PostViblackTransition
; Set vertical scroll offset to fixed value
Stage_SetVerticalScrollOfs:                             ; DATA XREF: ROM:0000D9C0   o  ; was: sub_E09A
                move.w  #$14,(dword_FF8066+2).w
                rts
; End of function Stage_SetVerticalScrollOfs
; Palette fade transition
Stage_PostViblackFade:                                  ; DATA XREF: ROM:0000D9C2   o  ; was: sub_E0A2
                subq.w  #1,(dword_FF8066+2).w
                bmi.s   loc_E0AA
                rts
; ---------------------------------------------------------------------------
loc_E0AA:                                               ; CODE XREF: Stage_PostViblackFade+4   j
                bsr.w   Stage_PostViblackScrollDecel
                movea.w #(byte_FFE322-M68K_RAM),a0
                movea.w #(dword_FFE3A0+2-M68K_RAM),a1
                move.w  (dword_FF806A).w,d0
                asr.w   #1,d0
                andi.w  #$1E,d0
                cmpi.w  #$1E,d0
                beq.s   loc_E0D0
                addq.w  #2,(dword_FF806A).w
                move.w  #$4000,(a0,d0.w)
loc_E0D0:                                               ; CODE XREF: Stage_PostViblackFade+22   j
                moveq   #0,d5
                moveq   #0,d6
                moveq   #$B,d7
loc_E0D6:                                               ; CODE XREF: Stage_PostViblackFade+58   j
                move.w  (a0,d5.w),d0
                beq.s   loc_E0F8
                cmp.w   (a1,d5.w),d0
                beq.s   loc_E0F6
                subi.w  #$300,d0
                bpl.s   loc_E0F0
                move.w  (a1,d5.w),(a0,d5.w)
                bra.s   loc_E0F8
; ---------------------------------------------------------------------------
loc_E0F0:                                               ; CODE XREF: Stage_PostViblackFade+44   j
                move.w  d0,(a0,d5.w)
                bra.s   loc_E0F8
; ---------------------------------------------------------------------------
loc_E0F6:                                               ; CODE XREF: Stage_PostViblackFade+3E   j
                addq.w  #1,d6
loc_E0F8:                                               ; CODE XREF: Stage_PostViblackFade+38   j
                                        ; Stage_PostViblackFade+4C   j
                addq.w  #2,d5
                dbf     d7,loc_E0D6
                cmpi.w  #$C,d6
                bmi.s   locret_E10E
                addq.w  #2,(word_FFA950).w
                move.b  #$18,(byte_FFA420).w
locret_E10E:                                            ; CODE XREF: Stage_PostViblackFade+60   j
                rts
; End of function Stage_PostViblackFade
; Scroll speed deceleration
Stage_PostViblackScrollDecel:                           ; CODE XREF: Stage_PostViblackFade:loc_E0AA   p  ; was: sub_E110
                                        ; DATA XREF: ROM:0000D9C4   o
                tst.w   (dword_FFA904).w
                beq.s   locret_E11A
                addq.w  #8,(dword_FFA904).w
locret_E11A:                                            ; CODE XREF: Stage_PostViblackScrollDecel+4   j
                rts
; End of function Stage_PostViblackScrollDecel
; Stage initialization and transition
