Sys_TransitionToStageInit:                              ; DATA XREF: Sys_DispatchGameState+BE   o  ; was: sub_1E76C
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1E7A8
                jsr     (Sys_InitGameMode).l
                jsr     (Sys_ClearEntityObjectPool).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                clr.b   (word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                addq.w  #2,(GameSubstateIndex).w
                jmp     Gfx_QueueLargeFontDMA
; ---------------------------------------------------------------------------
loc_1E7A8:                                              ; CODE XREF: Sys_TransitionToStageInit+4   j
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                bset    #0,(byte_FFA209).w
                moveq   #0,d0
                move.l  d0,(dword_FF8128).w
                move.l  d0,(dword_FF812C).w
                move.l  d0,(dword_FF8130).w
                move.l  d0,(dword_FF8134).w
                bsr.w   Cutscene_DispatchInit
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                jmp     (Gfx_FadePaletteTransition).l
; End of function Sys_TransitionToStageInit
; Updates stage transition
Sys_StageTransitionUpdate:                              ; DATA XREF: Sys_DispatchGameState+C2   o  ; was: sub_1E7DE
                jsr     (Object_ApplyCameraMotion).l
                jsr     (Sprite_InitializePriorityBuckets).l
                jsr     (Sys_BeginVisibleObjectList).l
                jsr     (Sys_ProcessVisibleObjects).l
                bsr.w   Cutscene_DispatchUpdate
                jsr     (Sys_UpdateObjectCount).l
                jsr     (Sprite_RenderObjectList).l
                jsr     (Gfx_FadePaletteTransition).l
                jsr     (Gfx_SetupScrollPlanes).l
                addq.w  #1,(word_FFA000).w
                bclr    #0,(word_FF80F4).w
                beq.s   loc_1E824
                addq.w  #2,(GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1E824:                                              ; CODE XREF: Sys_StageTransitionUpdate+3E   j
                bclr    #1,(word_FF80F4).w
                beq.s   locret_1E83C
                move.w  #$C,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jmp     Stage_DispatchObjectLoader
; ---------------------------------------------------------------------------
locret_1E83C:                                           ; CODE XREF: Sys_StageTransitionUpdate+4C   j
                rts
; End of function Sys_StageTransitionUpdate
; Dispatcher for cutscene init
