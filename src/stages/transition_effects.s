Gfx_PaletteFadeClamp:
                move.w  (word_FF9620).w,d0              ; was: sub_F064
                bpl.s   loc_F074
                cmpi.w  #$FFE4,d0
                bpl.s   loc_F078
                moveq   #$FFFFFFE4,d0
                bra.s   loc_F078
; ---------------------------------------------------------------------------
loc_F074:                                               ; CODE XREF: Gfx_PaletteFadeClamp+4   j
                beq.s   loc_F078
                moveq   #0,d0
loc_F078:                                               ; CODE XREF: Gfx_PaletteFadeClamp+A   j
                                        ; Gfx_PaletteFadeClamp+E   j
                move.w  d0,(word_FF9620).w
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #$1F,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Gfx_PaletteFadeClamp
; Spawns projectile type 1
Boss_ArtemisSpawnProjectile1:                           ; CODE XREF: Stage_ArtemisTransition+4   p  ; was: sub_F08C
                tst.l   (dword_FF8240).w
                beq.s   locret_F0B2
                bpl.s   loc_F0A4
                addi.l  #$800,(dword_FF8240).w
                bmi.s   locret_F0B2
                clr.l   (dword_FF8240).w
                rts
; ---------------------------------------------------------------------------
loc_F0A4:                                               ; CODE XREF: Boss_ArtemisSpawnProjectile1+6   j
                subi.l  #$800,(dword_FF8240).w
                bpl.s   locret_F0B2
                clr.l   (dword_FF8240).w
locret_F0B2:                                            ; CODE XREF: Boss_ArtemisSpawnProjectile1+4   j
                                        ; Boss_ArtemisSpawnProjectile1+10   j
                rts
; End of function Boss_ArtemisSpawnProjectile1
; Foreground graphics setup
Gfx_SylpheedForeground:                                 ; CODE XREF: Stage_SylpheedGraphicsInit:loc_E8BC   j  ; was: sub_F0B4
                btst    #3,(word_FFA40E).w
                bne.s   loc_F0CC
                subi.l  #$1000,(dword_FF8240).w
                bpl.s   loc_F0E4
                clr.l   (dword_FF8240).w
                bra.s   loc_F0E4
; ---------------------------------------------------------------------------
loc_F0CC:                                               ; CODE XREF: Gfx_SylpheedForeground+6   j
                addi.l  #$2000,(dword_FF8240).w
                cmpi.w  #4,(dword_FF8240).w
                bmi.s   loc_F0E4
                move.l  #$40000,(dword_FF8240).w
loc_F0E4:                                               ; CODE XREF: Gfx_SylpheedForeground+10   j
                                        ; Gfx_SylpheedForeground+16   j
                move.l  (dword_FF8240).w,d0
                asl.l   #1,d0
                add.l   d0,(dword_FFA908).w
                rts
; End of function Gfx_SylpheedForeground
; Stage transition initialization
Stage_TransitionInit:                                   ; DATA XREF: ROM:0000FF42   o  ; was: sub_F0F0
                movea.w off_F0FC(pc,d0.w),a0
                adda.l  #Stage_TransitionGraphics,a0
                jmp     (a0)
; End of function Stage_TransitionInit
; ---------------------------------------------------------------------------
off_F0FC:       dc.w    Stage_TransitionGraphics-Stage_TransitionGraphics
                dc.w    Stage_Graphics_TransitionLoop-Stage_TransitionGraphics
                dc.w    Stage_AsteroidsTransition-Stage_TransitionGraphics
                dc.w    Stage_AsteroidsScrollHandler-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoInit-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoAnimationScript-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoGraphicsCleanup-Stage_TransitionGraphics
                dc.w    Boss_ShieldViperTransition-Stage_TransitionGraphics
                dc.w    Boss_ShieldViperInit-Stage_TransitionGraphics
                dc.w    Boss_ShieldViperGraphicsInit-Stage_TransitionGraphics
                dc.w    Boss_ShieldViperPaletteSetup-Stage_TransitionGraphics
                dc.w    Boss_ShieldViperGraphicsCleanup-Stage_TransitionGraphics
                dc.w    Boss_ShieldViperPaletteRestore-Stage_TransitionGraphics
                dc.w    Boss_ShieldViperFinalCleanup-Stage_TransitionGraphics
                dc.w    Boss_WolfGaropaTransition-Stage_TransitionGraphics
                dc.w    Boss_WolfGaropaPaletteSetup-Stage_TransitionGraphics
                dc.w    Boss_WolfGaropaMain-Stage_TransitionGraphics
                dc.w    Boss_WolfGaropaDispatcher-Stage_TransitionGraphics
                dc.w    Boss_WolfGaropaIntroInit-Stage_TransitionGraphics
                dc.w    Boss_WolfGaropaIntroMove-Stage_TransitionGraphics
                dc.w    Boss_WolfGaropaSpawnProjectile2-Stage_TransitionGraphics
                dc.w    Boss_DestroyerPhaseInit-Stage_TransitionGraphics
                dc.w    Boss_WolfGaropaPhaseInit-Stage_TransitionGraphics
                dc.w    Boss_WolfGaropaTransitionOut-Stage_TransitionGraphics
                dc.w    Boss_WolfGaropaBattleWrapper-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Stage24_Init-Stage_TransitionGraphics
                dc.w    Stage24_InitLoop-Stage_TransitionGraphics
                dc.w    Boss_MissirayTransition-Stage_TransitionGraphics
                dc.w    Boss_MissirayInit-Stage_TransitionGraphics
                dc.w    Boss_MissirayPaletteUpdate-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Stage24_InitCutscene-Stage_TransitionGraphics
                dc.w    Camera_ScrollAccelerate-Stage_TransitionGraphics
                dc.w    Scroll_ClampVerticalPos-Stage_TransitionGraphics
                dc.w    Stage_CheckPhaseComplete-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Stage_IncrementPhase-Stage_TransitionGraphics
                dc.w    Stage_IncrementPhase_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Stage25_TransitionInit-Stage_TransitionGraphics
                dc.w    Stage25_TransitionLoop-Stage_TransitionGraphics
                dc.w    Boss_ZLeoTransition-Stage_TransitionGraphics
                dc.w    Stage_CheckTransitionTrigger-Stage_TransitionGraphics
                dc.w    Stage_Stage25CameraUpdate-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Stage_SetStage25ScrollTimer-Stage_TransitionGraphics
                dc.w    Gfx_UpdateScrollWrapper-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w    Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics

; Transition graphics handler
