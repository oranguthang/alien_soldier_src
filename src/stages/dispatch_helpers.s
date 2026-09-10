Stage_ClearScrollAnimTimer:
                clr.w   (dword_FFA960).w                ; was: sub_FF10
                rts
; End of function Stage_ClearScrollAnimTimer
; Processes stage handler entry point
Stage_ProcessHandler:                                   ; CODE XREF: Stage_LoadBackgroundGraphics:loc_1C530   j  ; was: sub_FF16
                                        ; Stage_XiTigerHandler+110   j
                tst.b   (byte_FF813E).w
                bpl.s   loc_FF1E
                rts
; ---------------------------------------------------------------------------
loc_FF1E:                                               ; CODE XREF: Stage_ProcessHandler+4   j
                jsr     Gfx_SetupScrollPlanes(pc)       ; (pc)
                nop
                movea.w #(word_FFA400-M68K_RAM),a5
                move.w  (word_FFA950).w,d0
                move.w  (word_FFA206).w,d1
                movea.l off_FF36(pc,d1.w),a0
                jmp     (a0)
; End of function Stage_ProcessHandler
; ---------------------------------------------------------------------------
off_FF36:       dc.l    Stage_Dispatcher
                dc.l    Stage_InitStage10
                dc.l    Stage_Stage18Scroll
                dc.l    Stage_TransitionInit
                dc.l    Stage_Dispatcher

; Transitions stage to next phase or section
Stage_TransitionToNextPhase:                            ; CODE XREF: Stage_UpdateLogic+14   j  ; was: sub_FF4A
                                        ; Camera_AutoScrollCheck+10   j
                addq.w  #2,(word_FFA950).w
                move.w  #$56,(MessageSequenceState).w   ; 'V'
; Sets palette transition values when entering boss battle phase
Stage_SetBossTransitionPalette:                         ; CODE XREF: Stage_InitXiTigerBoss   p  ; was: loc_FF54
                move.w  (StageTableIndex).w,d0
                lea     word_FF7E(pc),a0
                nop
                lea     word_FFD2(pc),a1
                nop
                move.w  (a0,d0.w),(word_FF8202).w
                move.w  (a0,d0.w),(word_FF8200).w
                move.w  (a1,d0.w),(word_FF8236).w
                move.w  (a1,d0.w),(word_FF8234).w
                rts
; End of function Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
word_FF7E:      dc.w    $7000, $7000                    ; DATA XREF: Stage_TransitionToNextPhase+E   o
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
word_FFD2:      dc.w    $1E0, $1E0                      ; DATA XREF: Stage_TransitionToNextPhase+14   o
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, 0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0

; Loads Stage 18 tiles
