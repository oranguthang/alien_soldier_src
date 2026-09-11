Stage_InitStage10:                                      ; DATA XREF: ROM:0000FF3A   o  ; was: sub_D90E
                cmpi.w  #$40,(word_FFA950).w            ; '@'
                bpl.s   Stage_DispatchStage10Handler
                btst    #0,(FrameCounter+1).w
                bne.s   Stage_DispatchStage10Handler
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w a0,a1
                move.w  #$148,(a1)+
                move.w  #$300,(a1)+
                move.w  #0,(a1)+
                move.w  #1,(a1)+
                move.w  #$148,(a1)+
                move.w  #$300,(a1)+
                move.w  #0,(a1)+
                clr.w   (a1)+
                move.w  #$FFFF,(a1)
                jsr     (Sprite_AppendOAMEntries).l
; Dispatches to appropriate stage 10 scroll handler based on phase
Stage_DispatchStage10Handler:                           ; CODE XREF: Stage_InitStage10+6   j  ; was: loc_D94C
                                        ; Stage_InitStage10+E   j
                move.w  (word_FFA950).w,d0
                movea.w off_D95C(pc,d0.w),a0
                adda.l  #Stage_Stage10ScrollUpdate,a0
                jmp     (a0)
; End of function Stage_InitStage10
; ---------------------------------------------------------------------------
off_D95C:       dc.w    Stage_Stage10ScrollUpdate-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage10CheckTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_DeepStriderTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_DeepStriderBattle-Stage_Stage10ScrollUpdate
                dc.w    Stage_DeepStriderBattleInit-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage11Transition-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage11ScrollUpdate-Stage_Stage10ScrollUpdate
                dc.w    Stage_GustheadTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_GustheadDefeatTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage12Init-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage12ScrollUpdate-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage12_ScrollLoop-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage13Init-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage13ScrollUpdate-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage13CheckTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage13EmptyHandler-Stage_Stage10ScrollUpdate
                dc.w    Stage_SharpssteelTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage14Init-Stage_Stage10ScrollUpdate
                dc.w    Stage_TeleportTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_TeleportFadeIn-Stage_Stage10ScrollUpdate
                dc.w    Stage_TeleportFadeSequence-Stage_Stage10ScrollUpdate
                dc.w    Stage_TeleportFadeSequence_Advance-Stage_Stage10ScrollUpdate
                dc.w    Stage_SnakeTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage10CheckTransition_Return-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage10CheckTransition_Return-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage10CheckTransition_Return-Stage_Stage10ScrollUpdate
                dc.w    Stage_InitStage13-Stage_Stage10ScrollUpdate
                dc.w    Stage_SnakeWaitScroll-Stage_Stage10ScrollUpdate
                dc.w    Stage_BugmaxTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_BugmaxWaitDMA-Stage_Stage10ScrollUpdate
                dc.w    Stage_BugmaxStartBattle-Stage_Stage10ScrollUpdate
                dc.w    Stage_BugmaxTransitionCheck-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage14Scroll-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage14Scroll_Update-Stage_Stage10ScrollUpdate
                dc.w    Stage_InitBossPaletteScroll-Stage_Stage10ScrollUpdate
                dc.w    Stage_InitScoreTimerClear-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage15Transition-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage15Scroll-Stage_Stage10ScrollUpdate
                dc.w    Stage_ScrollCheckTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_SunsetStingTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_SunsetStingWaitBattle-Stage_Stage10ScrollUpdate
                dc.w    Stage_PostSunsetStingTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_ViblackScroll-Stage_Stage10ScrollUpdate
                dc.w    Stage_ViblackInit-Stage_Stage10ScrollUpdate
                dc.w    Stage_ConstrainCameraBounds-Stage_Stage10ScrollUpdate
                dc.w    Stage_Stage17Transition-Stage_Stage10ScrollUpdate
                dc.w    Stage_ViblackPostBattleScroll1-Stage_Stage10ScrollUpdate
                dc.w    Stage_ViblackPostBattleScroll2-Stage_Stage10ScrollUpdate
                dc.w    Stage_PostViblackTransition-Stage_Stage10ScrollUpdate
                dc.w    Stage_PostViblackTransition_Render-Stage_Stage10ScrollUpdate
                dc.w    Stage_SetVerticalScrollOfs-Stage_Stage10ScrollUpdate
                dc.w    Stage_PostViblackFade-Stage_Stage10ScrollUpdate
                dc.w    Stage_PostViblackScrollDecel-Stage_Stage10ScrollUpdate
                dc.w    Stage_Epsilon1Init-Stage_Stage10ScrollUpdate
                dc.w    Stage_Epsilon1Scroll-Stage_Stage10ScrollUpdate
                dc.w    Stage_Epsilon1Scroll-Stage_Stage10ScrollUpdate
                dc.w    Stage_Epsilon1BattleStart-Stage_Stage10ScrollUpdate
                dc.w    Stage_Epsilon1WaitIntroComplete-Stage_Stage10ScrollUpdate
                dc.w    Cutscene_PlanetInit-Stage_Stage10ScrollUpdate

; Updates Stage 10 scroll positions
Stage_Stage10ScrollUpdate:                              ; DATA XREF: Stage_InitStage10+46   o  ; was: sub_D9D2
                                        ; ROM:off_D95C   o
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                bsr.w   Stage_LoadStage10Graphics
; End of function Stage_Stage10ScrollUpdate
; Checks transition to next segment
Stage_Stage10CheckTransition:                           ; DATA XREF: ROM:0000D95E   o  ; was: sub_D9DC
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_AccumulateQuarterHorizontalDelta
                cmpi.w  #$730,(dword_FFA900).w
                bmi.s   Stage_Stage10CheckTransition_Return
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
; Early return from stage 10 transition check
Stage_Stage10CheckTransition_Return:                    ; CODE XREF: Stage_Stage10CheckTransition+E   j  ; was: locret_D9F0
                                        ; Stage_DeepStriderTransition+10   j
                rts
; End of function Stage_Stage10CheckTransition
; Transitions to Deep Strider boss
Stage_DeepStriderTransition:                            ; DATA XREF: ROM:0000D960   o  ; was: sub_D9F2
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_AccumulateQuarterHorizontalDelta
                move.w  #$7B0,d0
                cmp.w   (dword_FFA900).w,d0
                bpl.s   Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (Boss_DeepStriderAssetSet).l,a1
                bra.w   Boss_LoadAssetSet
; End of function Stage_DeepStriderTransition
; Deep Strider battle stage handler
Stage_DeepStriderBattle:                                ; DATA XREF: ROM:0000D962   o  ; was: sub_DA22
                tst.w   (Entity_ObjectPool).w
                bne.s   Camera_UpdateDeepStrider
                bsr.w   Stage_StartTimeBonusAndPreloadNextPhase
; Updates camera for Deep Strider boss battle with phase transition check
Camera_UpdateDeepStrider:                               ; CODE XREF: Stage_DeepStriderBattle+4   j  ; was: loc_DA2C
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_AccumulateQuarterHorizontalDelta
; End of function Stage_DeepStriderBattle
; Initializes Deep Strider battle
Stage_DeepStriderBattleInit:                            ; DATA XREF: ROM:0000D964   o  ; was: sub_DA34
                bsr.w   Stage_StartNextPhaseBanner
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_AccumulateQuarterHorizontalDelta
; End of function Stage_DeepStriderBattleInit
; Transitions to Stage 11
Stage_Stage11Transition:                                ; DATA XREF: ROM:0000D966   o  ; was: sub_DA40
                bsr.w   Stage_LoadStage10Graphics
; End of function Stage_Stage11Transition
; Updates Stage 11 scroll and check
Stage_Stage11ScrollUpdate:                              ; DATA XREF: ROM:0000D968   o  ; was: sub_DA44
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_AccumulateQuarterHorizontalDelta
                cmpi.w  #$1040,(dword_FFA900).w
                bmi.s   locret_DA58
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_DA58:                                            ; CODE XREF: Stage_Stage11ScrollUpdate+E   j
                rts
; End of function Stage_Stage11ScrollUpdate
; Transitions to Gusthead boss
Stage_GustheadTransition:                               ; DATA XREF: ROM:0000D96A   o  ; was: sub_DA5A
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_AccumulateQuarterHorizontalDelta
                move.w  #$10C0,d0
                cmp.w   (dword_FFA900).w,d0
                bpl.s   locret_DA92
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (Boss_GustheadAssetSet).l,a1
                bsr.w   Boss_LoadAssetSet
                clr.l   (dword_FFA960).w
                clr.w   (word_FFA968).w
locret_DA92:                                            ; CODE XREF: Stage_GustheadTransition+10   j
                rts
; End of function Stage_GustheadTransition
; Transitions after Gusthead defeat
Stage_GustheadDefeatTransition:                         ; DATA XREF: ROM:0000D96C   o  ; was: sub_DA94
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_DAA0
                jsr     (Stage_StartTimeBonusAndPreloadNextPhase).l
loc_DAA0:                                               ; CODE XREF: Stage_GustheadDefeatTransition+4   j
                bra.w   loc_DAA8
; End of function Stage_GustheadDefeatTransition
; Initializes Stage 12
Stage_Stage12Init:                                      ; DATA XREF: ROM:0000D96E   o  ; was: sub_DAA4
                bsr.w   Stage_StartNextPhaseBanner
loc_DAA8:                                               ; CODE XREF: Stage_GustheadDefeatTransition:loc_DAA0   j
                tst.w   (word_FFA968).w
                beq.s   loc_DAE2
                bsr.w   Scroll_ApplyVelocity
                bsr.w   Scroll_AccumulateQuarterHorizontalDelta
                cmpi.w  #$14,(StageTableIndex).w
                beq.s   locret_DAE0
                tst.w   (word_FFA968).w
                beq.s   locret_DAE0
                move.w  (dword_FFA900).w,d0
                move.w  d0,d1
                andi.w  #$FF,d0
                andi.w  #$100,d1
                addi.w  #$1000,d0
                sub.w   d1,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA928).w
locret_DAE0:                                            ; CODE XREF: Stage_Stage12Init+18   j
                                        ; Stage_Stage12Init+1E   j
                rts
; ---------------------------------------------------------------------------
loc_DAE2:                                               ; CODE XREF: Stage_Stage12Init+8   j
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_AccumulateQuarterHorizontalDelta
; End of function Stage_Stage12Init
; Applies velocity value to horizontal scroll position
Scroll_ApplyVelocity:                                   ; CODE XREF: Stage_Stage12Init+A   p  ; was: sub_DAEA
                move.l  (dword_FFA960).w,d0
                add.l   d0,(dword_FFA900).w
                rts
; End of function Scroll_ApplyVelocity
; Updates Stage 12 scroll
Stage_Stage12ScrollUpdate:                              ; DATA XREF: ROM:0000D970   o  ; was: sub_DAF4
                move.b  #$40,(byte_FFA420).w            ; '@'
                move.w  #$30,(RasterEffectIndex).w      ; '0'
                clr.w   (RasterEffectInitState).w
; Updates stage 12 scrolling with delta at position $1580
Stage_Stage12_ScrollLoop:                               ; DATA XREF: ROM:0000D972   o  ; was: loc_DB04
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_AccumulateQuarterHorizontalDelta
                cmpi.w  #$1580,(dword_FFA900).w
                bmi.w   Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                move.w  #$80,(word_FF806E).w
                move.w  #$8000,(word_FF808A).w
                move.b  #1,(byte_FF830E).w
                rts
; End of function Stage_Stage12ScrollUpdate
; Initializes Stage 13
Stage_Stage13Init:                                      ; DATA XREF: ROM:0000D974   o  ; was: sub_DB2E
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_AccumulateQuarterHorizontalDelta
                bsr.w   Stage_WaitForTimerDecrement
                cmpi.w  #$15E0,(dword_FFA900).w
                bmi.w   Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                jsr     (Stage_LoadStage13Graphics).l
                lea     stru_DB5A(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_Stage13Init
; ---------------------------------------------------------------------------
stru_DB5A:      dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_Stage13Init+20   o
                dc.l    tiles_19E8A8                    ; field_2
                dc.w    0                               ; field_6
                dc.w    $FFFF

; Updates Stage 13 scroll
Stage_Stage13ScrollUpdate:                              ; DATA XREF: ROM:0000D976   o  ; was: sub_DB64
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_AccumulateQuarterHorizontalDelta
                bsr.w   Stage_WaitForTimerDecrement
                cmpi.w  #$1760,(dword_FFA900).w
                bmi.s   locret_DB7C
                addq.w  #2,(word_FFA950).w
locret_DB7C:                                            ; CODE XREF: Stage_Stage13ScrollUpdate+12   j
                rts
; End of function Stage_Stage13ScrollUpdate
; Checks transition to next segment
Stage_Stage13CheckTransition:                           ; DATA XREF: ROM:0000D978   o  ; was: sub_DB7E
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_AccumulateQuarterHorizontalDelta
                move.w  #$17A0,d0
                cmp.w   (dword_FFA900).w,d0
                bpl.s   locret_DB9C
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  d0,(dword_FFA900).w
locret_DB9C:                                            ; CODE XREF: Stage_Stage13CheckTransition+10   j
                rts
; End of function Stage_Stage13CheckTransition
; Empty handler for stage 13 transition
Stage_Stage13EmptyHandler:                              ; DATA XREF: ROM:0000D97A   o  ; was: nullsub_24
                rts
; End of function Stage_Stage13EmptyHandler
; Transitions to Sharpsteel boss
Stage_SharpssteelTransition:                            ; DATA XREF: ROM:0000D97C   o  ; was: sub_DBA0
                tst.w   (word_FF829E).w
                bne.w   Stage_Stage10CheckTransition_Return
                move.w  #9,(word_FF808C).w
                bsr.w   Stage_TransitionToNextPhase
                lea     (Boss_SharpssteelAssetSet).l,a1
                bra.w   Boss_LoadAssetSet
; End of function Stage_SharpssteelTransition
; Initializes Stage 14
Stage_Stage14Init:                                      ; DATA XREF: ROM:0000D97E   o  ; was: sub_DBBC
                tst.w   (Entity_ObjectPool).w
                bne.w   Stage_Stage10CheckTransition_Return
                move.w  #$FFFF,(word_FFDB44).w
                bra.w   Stage_StartTimeBonusAndPreloadNextPhase
; End of function Stage_Stage14Init
; Transitions to teleport after ship destruction
Stage_TeleportTransition:                               ; DATA XREF: ROM:0000D980   o  ; was: sub_DBCE
                tst.w   (MessageSequenceState).w
                bne.w   Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FF820C).w
                addq.w  #2,(StageTableIndex).w
                clr.b   (byte_FFA209).w
                clr.w   (dword_FF806A+2).w
                move.b  #$CA,d0
                jmp     (Sound_PlaySFX).l
; End of function Stage_TeleportTransition
; Fade in and setup for teleport scene
Stage_TeleportFadeIn:                                   ; DATA XREF: ROM:0000D982   o  ; was: sub_DBF4
                tst.w   (word_FF80E6).w
                beq.s   loc_DBFC
                bpl.s   loc_DC5E
loc_DBFC:                                               ; CODE XREF: Stage_TeleportFadeIn+4   j
                addq.w  #1,(dword_FF806A+2).w
                cmpi.w  #$3C,(dword_FF806A+2).w         ; '<'
                bne.s   loc_DC5E
                addq.w  #2,(word_FFA950).w
                move.w  #$FCE0,(dword_FFA900).w
                clr.w   (dword_FFA904).w
                move.w  #$1C,(dword_FF806A+2).w
                move.l  #$C0000,(dword_FF8066+2).w
                clr.b   (byte_FFA95A).w
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                bset    #6,(byte_FFA959).w
                move.w  #$50,(word_FFA404).w            ; 'P'
                clr.l   (dword_FF8240).w
                clr.l   (dword_FF830A).w
                move.w  #$4000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr     (VDP_SetupDMA).l
                jsr     (Stage_LoadTeleportGraphics).l
loc_DC5E:                                               ; CODE XREF: Stage_TeleportFadeIn+6   j
                                        ; Stage_TeleportFadeIn+12   j
                move.w  (dword_FF806A+2).w,d0
                cmpi.w  #$1C,d0
                bmi.s   loc_DC6A
                moveq   #$1C,d0
loc_DC6A:                                               ; CODE XREF: Stage_TeleportFadeIn+72   j
                jmp     (Gfx_SetFadeParams).l
; End of function Stage_TeleportFadeIn
; Handles teleport fade sequence with scroll
Stage_TeleportFadeSequence:                             ; DATA XREF: ROM:0000D984   o  ; was: sub_DC70
                move.w  (dword_FF806A+2).w,d0
                jsr     (Gfx_SetFadeParams).l
                addq.w  #6,(dword_FFA900).w
                subq.w  #1,(dword_FF806A+2).w
                bpl.s   loc_DCA8
                addq.w  #2,(word_FFA950).w
; Advances scroll during teleport fade sequence
Stage_TeleportFadeSequence_Advance:                     ; DATA XREF: ROM:0000D986   o  ; was: loc_DC88
                addq.w  #6,(dword_FFA900).w
                bmi.s   loc_DCA8
                addq.w  #2,(word_FFA950).w
                move.w  #$60,(dword_FF806A+2).w         ; '`'
                clr.w   (dword_FFA900).w
                bclr    #6,(byte_FFA959).w
                move.w  #1,(word_FFA448).w
loc_DCA8:                                               ; CODE XREF: Stage_TeleportFadeSequence+12   j
                                        ; Stage_TeleportFadeSequence+1C   j
                bsr.w   Stage_TeleportUpdateScroll
                move.w  (dword_FFA900).w,d0
                addi.w  #$158,d0
                bpl.s   loc_DCB8
                rts
; ---------------------------------------------------------------------------
loc_DCB8:                                               ; CODE XREF: Stage_TeleportFadeSequence+44   j
                moveq   #0,d1
                jmp     Gfx_RenderTilemap
; End of function Stage_TeleportFadeSequence
; Transitions to Snake boss stage
Stage_SnakeTransition:                                  ; DATA XREF: ROM:0000D988   o  ; was: sub_DCC0
                subi.l  #$4000,(dword_FF8066+2).w
                bpl.s   loc_DCCE
                clr.l   (dword_FF8066+2).w
loc_DCCE:                                               ; CODE XREF: Stage_SnakeTransition+8   j
                bsr.w   Stage_TeleportUpdateScroll
                subq.w  #1,(dword_FF806A+2).w
                bpl.w   Stage_Stage10CheckTransition_Return
Stage_SnakeTransitionBeginStage13:
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                move.b  #$89,d0
                jsr     (Sound_QueueBGMOrStop).l
                bra.w   Stage_InitStage13
; End of function Stage_SnakeTransition
; Updates scroll position during teleport
Stage_TeleportUpdateScroll:                             ; CODE XREF: Stage_TeleportFadeSequence:loc_DCA8   p  ; was: sub_DCEE
                                        ; sub_DCC0:loc_DCCE   p
                bsr.w   Scroll_UpdateSnakeBackground
                move.l  (dword_FF8066+2).w,d0
                add.l   d0,(dword_FFA908).w
                rts
; End of function Stage_TeleportUpdateScroll
; Waits for timer to decrement before continuing
Stage_WaitForTimerDecrement:                            ; CODE XREF: Stage_Stage13Init+8   p  ; was: sub_DCFC
                                        ; Stage_Stage13ScrollUpdate+8   p
                tst.w   (word_FF806E).w
                bmi.w   Stage_Stage10CheckTransition_Return
                subq.w  #1,(word_FF806E).w
                bne.w   Stage_Stage10CheckTransition_Return
                rts
; End of function Stage_WaitForTimerDecrement
; Initializes Stage 13 (Snake boss)
Stage_InitStage13:                                      ; CODE XREF: Stage_SnakeTransition+2A   j  ; was: sub_DD0E
                                        ; DATA XREF: ROM:0000D990   o
                move.w  #$36,(word_FFA950).w            ; '6'
                move.w  #$298,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
                move.w  #$30,(RasterEffectIndex).w      ; '0'
                clr.w   (RasterEffectInitState).w
                jsr     (Stage_LoadStage13Graphics).l
; End of function Stage_InitStage13
; Waits for scroll position before boss
Stage_SnakeWaitScroll:                                  ; DATA XREF: ROM:0000D992   o  ; was: sub_DD2E
                bsr.w   Scroll_UpdateSnakeBackground
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                cmpi.w  #$3E0,(dword_FFA900).w
                bmi.w   Stage_Stage10CheckTransition_Return
                move.w  (word_FF8200).w,(dword_FF8040).w
                move.w  (word_FF8202).w,(dword_FF8040+2).w
                bsr.w   Stage_TransitionToNextPhase
                move.w  (dword_FF8040).w,(word_FF8200).w
                move.w  (dword_FF8040+2).w,(word_FF8202).w
                rts
; End of function Stage_SnakeWaitScroll
; Transitions to Bugmax boss
Stage_BugmaxTransition:                                 ; DATA XREF: ROM:0000D994   o  ; was: sub_DD5E
                bsr.w   Scroll_UpdateSnakeBackground
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                move.w  #$460,d0
                cmp.w   (dword_FFA900).w,d0
                bpl.w   Stage_Stage10CheckTransition_Return
                move.w  #$100,(word_FF806E).w
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                clr.w   (RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                move.w  #$1F,(word_FFA944).w
                clr.w   (word_FFA946).w
                move.w  #$6000,(dword_FFA940).w
                rts
; End of function Stage_BugmaxTransition
; Waits for DMA before boss intro
Stage_BugmaxWaitDMA:                                    ; DATA XREF: ROM:0000D996   o  ; was: sub_DDA6
                bsr.w   Scroll_UpdateSnakeBackground
                jsr     (Sprite_SetupDMA).l
                bpl.w   Stage_Stage10CheckTransition_Return
                subq.w  #1,(word_FF806E).w
                bmi.s   Stage_InitBugmaxBattle
                tst.w   (Entity_ObjectPool).w
                bne.w   Stage_Stage10CheckTransition_Return
; Initializes Bugmax boss battle with palette and DMA setup
Stage_InitBugmaxBattle:                                 ; CODE XREF: Stage_BugmaxWaitDMA+12   j  ; was: loc_DDC2
                addq.w  #2,(word_FFA950).w
                move.w  #$7000,(word_FF8200).w
                move.w  #$7000,(word_FF8202).w
                move.w  #$1E0,(word_FF8234).w
                move.w  #$1E0,(word_FF8236).w
                lea     (Boss_BugmaxAssetSet).l,a1
                bra.w   Boss_LoadAssetSet
; End of function Stage_BugmaxWaitDMA
; Starts Bugmax battle phase
Stage_BugmaxStartBattle:                                ; DATA XREF: ROM:0000D998   o  ; was: sub_DDE8
                bsr.w   Scroll_UpdateSnakeBackground
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_DDFC
                addq.w  #2,(word_FFA950).w
                move.w  #$22,(word_FFA02A).w            ; '"'
loc_DDFC:                                               ; CODE XREF: Stage_BugmaxStartBattle+8   j
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage_BugmaxStartBattle
; Checks conditions and initiates Bugmax boss transition
Stage_BugmaxTransitionCheck:                            ; DATA XREF: ROM:0000D99A   o  ; was: sub_DE00
                bsr.w   Scroll_UpdateSnakeBackground
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                tst.w   (word_FF8230).w
                bne.w   Stage_Stage10CheckTransition_Return
                tst.w   (word_FF8138).w
                bne.w   Stage_Stage10CheckTransition_Return
                move.b  #$92,d0
                jsr     (Sound_QueueBGMOrStop).l
                move.l  #byte_1E587,(dword_FFA22C).w
                bra.w   Stage_StartWeaponSelectTransition
; End of function Stage_BugmaxTransitionCheck
; Loads Stage 10 tile graphics and palette
Stage_LoadStage10Graphics:                              ; CODE XREF: Stage_Stage10ScrollUpdate+6   p  ; was: sub_DE2E
                                        ; sub_DA40   p
                move.w  #$30,(RasterEffectIndex).w      ; '0'
                clr.w   (RasterEffectInitState).w
                jsr     (Stage10_InitAmbientParticles).l
                addq.w  #2,(word_FFA950).w
                rts
; End of function Stage_LoadStage10Graphics
; Stage 14 scroll handler
