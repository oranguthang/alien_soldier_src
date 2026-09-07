Stage25_TransitionInit:                                 ; DATA XREF: ROM:0000F172   o  ; was: sub_FA8A
                addq.w  #2,(word_FFA950).w
                move.w  #$20,(dword_FFA90C).w           ; ' '
; Stage 25 transition scrolling loop at position $480
Stage25_TransitionLoop:                                 ; DATA XREF: ROM:0000F174   o  ; was: loc_FA94
                bsr.w   Gfx_UpdateScroll
                bsr.w   Stage25_CameraUpdate
                cmpi.w  #$480,(dword_FFA900).w
                bmi.w   Boss_DestroyerProtoTransition_Return
                bra.w   Stage_TransitionToNextPhase
; End of function Stage25_TransitionInit
; Transition to Z-Leo boss
Boss_ZLeoTransition:                                    ; DATA XREF: ROM:0000F176   o  ; was: sub_FAAA
                bsr.w   Gfx_LoadBossTiles
                bsr.w   Stage25_CameraUpdate
                cmpi.w  #$500,(dword_FFA900).w
                bmi.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$500,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (stru_11618).l,a1
                jmp     Gfx_UpdateBossPalette
; End of function Boss_ZLeoTransition
; Checks trigger flag and starts phase transition
Stage_CheckTransitionTrigger:                           ; DATA XREF: ROM:0000F178   o  ; was: sub_FAE0
                tst.w   (Entity_ObjectPool).w
                bne.s   locret_FAEA
                bsr.w   Stage_TriggerPhaseTransition
locret_FAEA:                                            ; CODE XREF: Stage_CheckTransitionTrigger+4   j
                rts
; End of function Stage_CheckTransitionTrigger
; Attributes: thunk
; Branches to Stage25 camera update routine
Stage_Stage25CameraUpdate:                              ; DATA XREF: ROM:0000F17A   o  ; was: sub_FAEC
                bra.w   Stage25_CameraUpdate
; End of function Stage_Stage25CameraUpdate
; Initializes section change and updates camera
Stage_InitSectionCamera:
                bsr.w   Stage_InitSectionChange         ; was: sub_FAF0
                bsr.w   Camera_UpdateTowardsPlayer
; End of function Stage_InitSectionCamera
; Camera update handler
Stage25_CameraUpdate:                                   ; CODE XREF: Stage25_TransitionInit+E   p  ; was: sub_FAF8
                                        ; Boss_ZLeoTransition+4   p
                move.w  (dword_FFA900).w,d0
                subi.w  #$300,d0
                asr.w   #4,d0
                move.w  d0,(dword_FFA908).w
                rts
; End of function Stage25_CameraUpdate
; Sets scroll timer and clears secondary timer
Stage_SetStage25ScrollTimer:                            ; DATA XREF: ROM:0000F186   o  ; was: sub_FB08
                move.w  #$8C,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; End of function Stage_SetStage25ScrollTimer
; Advances state and sets vertical scroll
Stage_SetVerticalScrollBase:
                addq.w  #2,(word_FFA950).w              ; was: sub_FB14
                move.w  #$20,(dword_FFA904).w           ; ' '
; End of function Stage_SetVerticalScrollBase
; Calls graphics scroll update routine
Gfx_UpdateScrollWrapper:                                ; DATA XREF: ROM:0000F188   o  ; was: sub_FB1E
                bsr.w   Gfx_UpdateScroll
                rts
; End of function Gfx_UpdateScrollWrapper
; Graphics update handler
Stage_AsteroidsGraphicsUpdate:                          ; CODE XREF: Stage_AsteroidsTransition+26   j  ; was: sub_FB24
                                        ; Stage_AsteroidsScrollHandler+E   j
                bsr.s   Stage_ScrollUpdate1
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                subi.w  #$F8,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Stage_AsteroidsGraphicsUpdate
; Scroll update handler 1
Stage_ScrollUpdate1:                                    ; CODE XREF: Stage_TransitionGraphics+70   j  ; was: sub_FB3A
                                        ; Stage_AsteroidsTransition+C   j
                move.l  (dword_FFA960).w,d0
                add.l   d0,(dword_FFA904).w
                add.l   d0,(dword_FFA964).w
                clr.b   (byte_FFA96A).w
                move.w  (dword_FFA964).w,d0
                andi.w  #$100,d0
                cmp.w   (word_FFA968).w,d0
                beq.s   Boss_DestroyerProtoTransition_Return
                addq.b  #1,(byte_FFA96A).w
                move.w  d0,(word_FFA968).w
; Return from Destroyer Proto transition
Boss_DestroyerProtoTransition_Return:                   ; CODE XREF: Boss_DestroyerProtoTransition+8   j  ; was: locret_FB60
                                        ; Boss_DestroyerProtoInit+8   j
                rts
; End of function Stage_ScrollUpdate1
; Checks button 6 input and sets trigger flag
Input_CheckButtonTrigger:
                btst    #6,(word_FFF706).w              ; was: sub_FB62
                beq.s   locret_FB70
                bset    #0,(byte_FFA958).w
locret_FB70:                                            ; CODE XREF: Input_CheckButtonTrigger+6   j
                rts
; End of function Input_CheckButtonTrigger
; Scroll update handler 2
Stage_ScrollUpdate2:                                    ; CODE XREF: Stage_TransitionGraphics:loc_F1EC   p  ; was: sub_FB72
                                        ; sub_F218   p
                move.l  (dword_FF8066).w,d0
                add.l   (dword_FF8062).w,d0
                move.l  d0,(dword_FF8066).w
                swap    d0
                movea.w #(word_FFE480-M68K_RAM),a0
                move.w  #$BF,d7
loc_FB88:                                               ; CODE XREF: Stage_ScrollUpdate2+1A   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_FB88
                rts
; End of function Stage_ScrollUpdate2
; Updates vertical scroll and shifts scroll buffer
Stage_ScrollUpdate4:
                bsr.w   Stage_ScrollUpdate3             ; was: sub_FB92
                movea.w #(word_FFE480-M68K_RAM),a0
                moveq   #$5F,d7                         ; '_'
loc_FB9C:                                               ; CODE XREF: Stage_ScrollUpdate4+10   j
                move.w  2(a0),(a0)
                addq.w  #4,a0
                dbf     d7,loc_FB9C
                rts
; End of function Stage_ScrollUpdate4
; Scroll update handler 3
Stage_ScrollUpdate3:                                    ; CODE XREF: Stage_TransitionGraphics+56   p  ; was: sub_FBA8
                                        ; Stage_AsteroidsTransition+4   p
                tst.w   (dword_FF9DA2).w
                bpl.s   loc_FBB8
                cmpi.l  #$FFFF8080,(dword_FF9DA2).w
                bmi.s   loc_FBC0
loc_FBB8:                                               ; CODE XREF: Stage_ScrollUpdate3+4   j
                subi.l  #$40,(dword_FF9DA2).w           ; '@'
loc_FBC0:                                               ; CODE XREF: Stage_ScrollUpdate3+E   j
                tst.w   (dword_FF9D9E).w
                bpl.s   loc_FBD0
                cmpi.l  #$FFFF8000,(dword_FF9D9E).w
                bmi.s   loc_FBD8
loc_FBD0:                                               ; CODE XREF: Stage_ScrollUpdate3+1C   j
                subi.l  #$40,(dword_FF9D9E).w           ; '@'
loc_FBD8:                                               ; CODE XREF: Boss_DestroyerProtoAnimationScript+C   p
                                        ; Boss_DestroyerProtoGraphicsCleanup+4   p
                move.l  (dword_FF9DA2).w,d0
                add.l   d0,(dword_FF9DAA).w
                add.l   d0,(dword_FF9DB2).w
                move.l  (dword_FF9DA6).w,d0
                add.l   (dword_FF9D9E).w,d0
                move.l  d0,(dword_FF9DA6).w
                swap    d0
                move.w  d0,d1
                move.w  d0,d2
                move.w  d0,d3
                move.w  d0,d4
                move.w  d0,d5
                move.w  d0,d6
                asr.w   #1,d1
                asr.w   #2,d2
                asr.w   #3,d3
                asr.w   #4,d4
                asr.w   #5,d5
                asr.w   #6,d6
                movea.w #(byte_FF9D80-M68K_RAM),a0
                moveq   #1,d7
loc_FC10:                                               ; CODE XREF: Stage_ScrollUpdate3+70   j
                move.w  d0,(a0)+
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                move.w  d3,(a0)+
                dbf     d7,loc_FC10
                move.w  (word_FFEC02).w,d7
                andi.w  #3,d7
                asl.w   #1,d7
                movea.w #(byte_FF9D80-M68K_RAM),a0
                adda.w  d7,a0
                move.w  (a0)+,d0
                move.w  (a0)+,d1
                move.w  (a0)+,d2
                move.w  (a0)+,d3
                btst    #0,(word_FFA000+1).w
                beq.s   loc_FC44
                asr.w   #1,d0
                asr.w   #1,d1
                asr.w   #1,d2
                asr.w   #1,d3
loc_FC44:                                               ; CODE XREF: Stage_ScrollUpdate3+92   j
                movea.w #(byte_FFE482-M68K_RAM),a0
                move.w  #$2F,d7                         ; '/'
loc_FC4C:                                               ; CODE XREF: Stage_ScrollUpdate3+B4   j
                move.w  d0,(a0)
                addq.w  #4,a0
                move.w  d1,(a0)
                addq.w  #4,a0
                move.w  d2,(a0)
                addq.w  #4,a0
                move.w  d3,(a0)
                addq.w  #4,a0
                dbf     d7,loc_FC4C
                move.l  (dword_FF9DB2).w,d0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_FC6E
                asr.l   #1,d0
loc_FC6E:                                               ; CODE XREF: Stage_ScrollUpdate3+C2   j
                move.l  d0,(dword_FFA90C).w
                rts
; End of function Stage_ScrollUpdate3
; Scroll setup handler
