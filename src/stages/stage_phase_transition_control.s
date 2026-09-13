; Starts the fade into the interstage transition
Stage_StartInterstageTransition:                        ; CODE XREF: Stage_CheckTransitionReady+16   j  ; was: sub_10390
                                        ; Stage7_StartTransitionToStage8+1C   j
                move.w  #3,(GameplayExitMode).w
                move.w  #2,(PaletteFadeMode).w
                clr.w   (PaletteFadeColorOffset).w
                move.w  #$E000,(PaletteFadeMaskStatus).w
                move.b  #$80,(GameplayControlFlags).w
                bra.w   Stage_AdvancePhaseForInterstageTransition
; End of function Stage_StartInterstageTransition
; Starts the next stage-number banner after the current banner has finished
Stage_StartNextPhaseBanner:                             ; CODE XREF: Camera_Stage2PhaseHandler   p  ; was: sub_103B0
                                        ; sub_C98E   p
                tst.w   (MessageSequenceState).w
                bne.s   Stage_NextPhaseBannerReturn
                addq.w  #2,(StageStateOffset).w
                move.w  #$50,(MessageSequenceState).w   ; 'P'
Stage_AdvancePhaseForInterstageTransition:              ; CODE XREF: Stage_StartInterstageTransition+1C   j  ; was: loc_103C0
                clr.w   (StatusDisplayModeOffset).w
                addq.w  #2,(StageTableIndex).w
                bclr    #7,(StageObjectSpawnCursor).w
                clr.b   (StageRouteFlags).w
Stage_NextPhaseBannerReturn:                            ; CODE XREF: Stage_StartNextPhaseBanner+4   j  ; was: locret_103D2
                rts
; Start the post-banner delay and preload the following phase's visual assets
Stage_StartPostBannerDelayAndPreloadNextPhase:          ; CODE XREF: Camera_AntroidBossInit+A   p  ; was: sub_103D4
                                        ; Stage_InitPostBoss+12   p
                move.w  #$5C,(MessageSequenceState).w   ; '\'
                bra.s   Stage_AdvanceControllerAndPreloadNextPhase
; End of function Stage_StartPostBannerDelayAndPreloadNextPhase
; Start the remaining-time bonus and preload the following phase's visual assets
Stage_StartTimeBonusAndPreloadNextPhase:                ; CODE XREF: Camera_BossPhaseHandler+6   p  ; was: sub_103DC
                                        ; Stage_PostJokerBoss+A   p
                move.w  #$2E,(MessageSequenceState).w   ; '.'
Stage_AdvanceControllerAndPreloadNextPhase:             ; CODE XREF: Stage_StartPostBannerDelayAndPreloadNextPhase+6   j  ; was: loc_103E2
                addq.w  #2,(StageStateOffset).w
                clr.b   (StageRouteFlags).w
                addq.w  #2,(StageTableIndex).w
                jsr     (Stage_DispatchVisualAssetLoader).l
                subq.w  #2,(StageTableIndex).w
                rts
; End of function Stage_StartTimeBonusAndPreloadNextPhase
