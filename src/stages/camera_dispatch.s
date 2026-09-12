Stage_Dispatcher:                                       ; DATA XREF: ROM:Stage_ProcessHandlerTable   o  ; was: sub_C83E
                                        ; ROM:0000FF46   o
                movea.w off_C84A(pc,d0.w),a0
                adda.l  #Stage_UpdateLogic,a0
                jmp     (a0)
; End of function Stage_Dispatcher
; ---------------------------------------------------------------------------
off_C84A:       dc.w    Stage_UpdateLogic-Stage_UpdateLogic
                dc.w    Stage_UpdateScrollAndCheck-Stage_UpdateLogic
                dc.w    Stage_InitBossIntro-Stage_UpdateLogic
                dc.w    Camera_BossPhaseHandler-Stage_UpdateLogic
                dc.w    Camera_Stage2PhaseHandler-Stage_UpdateLogic
                dc.w    Camera_AutoScrollCheck-Stage_UpdateLogic
                dc.w    Camera_TransitionToBossArena-Stage_UpdateLogic
                dc.w    Camera_AntroidBossInit-Stage_UpdateLogic
                dc.w    Camera_Stage3Transition-Stage_UpdateLogic
                dc.w    Camera_Stage3ScrollLimit-Stage_UpdateLogic
                dc.w    Camera_Stage3_ScrollLimitCheck-Stage_UpdateLogic
                dc.w    Camera_Stage3BossSetup-Stage_UpdateLogic
                dc.w    Camera_UpdateBossPosition-Stage_UpdateLogic
                dc.w    Camera_LockToBossArena-Stage_UpdateLogic
                dc.w    Camera_ShellshogunBossInit-Stage_UpdateLogic
                dc.w    Camera_LockPosition-Stage_UpdateLogic
                dc.w    Camera_UpdateSmooth-Stage_UpdateLogic
                dc.w    Camera_Smooth_ScrollLimitCheck-Stage_UpdateLogic
                dc.w    Camera_FollowTarget-Stage_UpdateLogic
                dc.w    Camera_SetBounds-Stage_UpdateLogic
                dc.w    Stage_CameraTransitionCheck-Stage_UpdateLogic
                dc.w    Stage_ScrollWaitTransition-Stage_UpdateLogic
                dc.w    Stage_CheckTransitionReady-Stage_UpdateLogic
                dc.w    Stage_AutoScrollUpdate-Stage_UpdateLogic
                dc.w    Stage_AutoScroll_UpdateLoop-Stage_UpdateLogic
                dc.w    Boss_MadamBarbarScrollInit-Stage_UpdateLogic
                dc.w    Stage_InitPostBoss-Stage_UpdateLogic
                dc.w    Stage_StartNextPhaseBannerWithDefaultBGM-Stage_UpdateLogic
                dc.w    Stage_CheckScrollTransition-Stage_UpdateLogic
                dc.w    Stage_InitJokerBoss-Stage_UpdateLogic
                dc.w    Stage_PostJokerBoss-Stage_UpdateLogic
                dc.w    Stage_PostJokerTransition-Stage_UpdateLogic
                dc.w    Stage_InitStage7-Stage_UpdateLogic
                dc.w    Stage_Stage7ScrollUpdate-Stage_UpdateLogic
                dc.w    Stage_InitTerobusterBoss-Stage_UpdateLogic
                dc.w    Stage_PostTerobusterIntro-Stage_UpdateLogic
                dc.w    Stage_PostTerobusterTransition-Stage_UpdateLogic
                dc.w    Stage_Stage7To8Transition-Stage_UpdateLogic
                dc.w    Stage_CheckPlayerPosTrigger-Stage_UpdateLogic
                dc.w    Stage_WaitAndTransition-Stage_UpdateLogic
                dc.w    Stage_InitStage8Train-Stage_UpdateLogic
                dc.w    Stage_InitStage8Train_ScrollCheck-Stage_UpdateLogic
                dc.w    Stage_TrainToFlyingNeoTransition-Stage_UpdateLogic
                dc.w    Stage_FlyingNeoScrollUpdate-Stage_UpdateLogic
                dc.w    Stage_FlyingNeoVerticalScroll-Stage_UpdateLogic
                dc.w    Stage_FlyingNeoScrollDecel-Stage_UpdateLogic
                dc.w    Stage_FlyingNeoBattleStart-Stage_UpdateLogic
                dc.w    Stage_FlyingNeoBattleUpdate-Stage_UpdateLogic
                dc.w    Stage_PostFlyingNeoTransition-Stage_UpdateLogic
                dc.w    Stage_InitStage9Flies-Stage_UpdateLogic
                dc.w    Stage_FliesCheckTransition-Stage_UpdateLogic
                dc.w    Stage_InitCaterpillarShip-Stage_UpdateLogic
                dc.w    Stage_CaterpillarShipUpdate-Stage_UpdateLogic
                dc.w    Stage_CaterpillarShipMovement-Stage_UpdateLogic
                dc.w    Stage_CaterpillarScrollHandler-Stage_UpdateLogic
                dc.w    Stage_XiTigerEmptyHandler-Stage_UpdateLogic
                dc.w    Stage_XiTigerBossWait-Stage_UpdateLogic
                dc.w    Stage_XiTigerBossWait_CheckEntity-Stage_UpdateLogic
                dc.w    Stage_PostXiTigerTransition-Stage_UpdateLogic
                dc.w    Stage_InitXiTigerBoss-Stage_UpdateLogic

; Updates stage logic and scroll
Stage_UpdateLogic:                                      ; DATA XREF: Stage_Dispatcher+4   o  ; was: sub_C8C2
                                        ; ROM:off_C84A   o
                addq.w  #2,(word_FFA950).w
; Updates stage scroll position and checks for phase transition at specific coordinate
Stage_UpdateScrollAndCheck:                             ; DATA XREF: ROM:0000C84C   o  ; was: loc_C8C6
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$668,(dword_FFA900).w
                bmi.s   locret_C8DA
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_C8DA:                                            ; CODE XREF: Stage_UpdateLogic+12   j
                                        ; Stage_InitBossIntro+E   j
                rts
; End of function Stage_UpdateLogic
; Initializes boss introduction sequence
Stage_InitBossIntro:                                    ; DATA XREF: ROM:0000C84E   o  ; was: sub_C8DC
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$6E8,(dword_FFA900).w
                bmi.s   locret_C8DA
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$6E8,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (Boss_JetsripperAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage_InitBossIntro
; Camera handler checking boss presence
Camera_BossPhaseHandler:                                ; DATA XREF: ROM:0000C850   o  ; was: sub_C910
                tst.w   (Entity_ObjectPool).w
                bne.s   Camera_UpdateBossPhase
                bsr.w   Stage_StartTimeBonusAndPreloadNextPhase
; Updates camera position during boss battle phase
Camera_UpdateBossPhase:                                 ; CODE XREF: Camera_BossPhaseHandler+4   j  ; was: loc_C91A
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_UpdateQuarterHorizontalPosition
; End of function Camera_BossPhaseHandler
; Stage 2 camera with transition check
Camera_Stage2PhaseHandler:                              ; DATA XREF: ROM:0000C852   o  ; was: sub_C922
                bsr.w   Stage_StartNextPhaseBanner
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_UpdateQuarterHorizontalPosition
; End of function Camera_Stage2PhaseHandler
; Camera with auto-scroll and phase transition
Camera_AutoScrollCheck:                                 ; DATA XREF: ROM:0000C854   o  ; was: sub_C92E
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$B40,(dword_FFA900).w
                bmi.s   locret_C942
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_C942:                                            ; CODE XREF: Camera_AutoScrollCheck+E   j
                                        ; Camera_TransitionToBossArena+E   j
                rts
; End of function Camera_AutoScrollCheck
; Transitions camera to boss arena with position lock
Camera_TransitionToBossArena:                           ; DATA XREF: ROM:0000C856   o  ; was: sub_C944
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$BC0,(dword_FFA900).w
                bmi.s   locret_C942
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$BC0,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (Boss_AntroidAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Camera_TransitionToBossArena
; Initializes camera for Antroid boss fight
Camera_AntroidBossInit:                                 ; DATA XREF: ROM:0000C858   o  ; was: sub_C978
                tst.w   (Entity_ObjectPool).w
                bne.s   Camera_UpdateAntroidBoss
                clr.w   (dword_FFA90C).w
                bsr.w   Stage_StartPostBannerDelayAndPreloadNextPhase
; Updates camera for Antroid boss with score timer initialization
Camera_UpdateAntroidBoss:                               ; CODE XREF: Camera_AntroidBossInit+4   j  ; was: loc_C986
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_UpdateQuarterHorizontalPosition
; End of function Camera_AntroidBossInit
; Stage 3 camera with section transition
Camera_Stage3Transition:                                ; DATA XREF: ROM:0000C85A   o  ; was: sub_C98E
                bsr.w   Stage_StartNextPhaseBanner
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_UpdateQuarterHorizontalPosition
; End of function Camera_Stage3Transition
; Stage 3 camera with scroll update and position limit
Camera_Stage3ScrollLimit:                               ; DATA XREF: ROM:0000C85C   o  ; was: sub_C99A
                addq.w  #2,(word_FFA950).w
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #7,d7
loc_C9A4:                                               ; CODE XREF: Camera_Stage3ScrollLimit+12   j
                move.w  #$10,(a0)
                lea     $60(a0),a0
                dbf     d7,loc_C9A4
; Updates scroll and camera transitions at position $FC0
Camera_Stage3_ScrollLimitCheck:                         ; DATA XREF: ROM:0000C85E   o  ; was: loc_C9B0
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$FC0,(dword_FFA900).w
                bmi.w   locret_C9D2
                addq.w  #2,(word_FFA950).w
                move.w  #$FC0,(dword_FFA900).w
                move.w  #$190,(Entity_ObjectPool).w
locret_C9D2:                                            ; CODE XREF: Camera_Stage3ScrollLimit+24   j
                rts
; End of function Camera_Stage3ScrollLimit
; Sets up camera for Stage 3 boss encounter
Camera_Stage3BossSetup:                                 ; DATA XREF: ROM:0000C860   o  ; was: sub_C9D4
                tst.w   (Entity_ObjectPool).w
                bne.s   locret_C9DE
                addq.w  #2,(word_FFA950).w
locret_C9DE:                                            ; CODE XREF: Camera_Stage3BossSetup+4   j
                rts
; End of function Camera_Stage3BossSetup
; Updates camera position during boss fight
Camera_UpdateBossPosition:                              ; DATA XREF: ROM:0000C862   o  ; was: sub_C9E0
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$1168,(dword_FFA900).w
                bmi.w   locret_C9F6
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_C9F6:                                            ; CODE XREF: Camera_UpdateBossPosition+E   j
                                        ; Camera_LockToBossArena+E   j
                rts
; End of function Camera_UpdateBossPosition
; Locks camera to boss arena boundaries
Camera_LockToBossArena:                                 ; DATA XREF: ROM:0000C864   o  ; was: sub_C9F8
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$11E8,(dword_FFA900).w
                bmi.s   locret_C9F6
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$11E8,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (Boss_ShellshogunAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Camera_LockToBossArena
; Initializes camera for Shellshogun boss fight
Camera_ShellshogunBossInit:                             ; DATA XREF: ROM:0000C866   o  ; was: sub_CA2C
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_CA86
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.w  #$8000,(word_FF808A).w
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                clr.w   (dword_FFA90C).w
                lea     (Boss_ShellshogunAssetLoadList).l,a0
                jsr     (Data_ProcessPointer).l
                move.w  #4,(PalettePrimaryIndex).w
                lea     (ShellshogunStagePaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.l  #dword_CA8A,(dword_FFA940).w
                clr.w   (word_FFA946).w
                clr.w   (word_FFA948).w
                move.w  #$1F,(word_FFA944).w
loc_CA86:                                               ; CODE XREF: Camera_ShellshogunBossInit+4   j
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Camera_ShellshogunBossInit
; ---------------------------------------------------------------------------
dword_CA8A:     dc.l    $FFFF7000, $FFFF6800, $FFFF2000, $6000
                                        ; DATA XREF: Camera_ShellshogunBossInit+44   o

; Locks camera to fixed position
Camera_LockPosition:                                    ; DATA XREF: ROM:0000C868   o  ; was: sub_CA9A
                tst.w   (word_FFF720).w
                bmi.s   loc_CAB0
                tst.w   (word_FFA944).w
                bmi.s   loc_CAAC
                bsr.w   Tilemap_QueueNextScrollingRow
                bra.s   loc_CAB0
; ---------------------------------------------------------------------------
loc_CAAC:                                               ; CODE XREF: Camera_LockPosition+A   j
                bsr.w   Stage_StartNextPhaseBanner
loc_CAB0:                                               ; CODE XREF: Camera_LockPosition+4   j
                                        ; Camera_LockPosition+10   j
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Camera_LockPosition
; Updates camera with smooth interpolation
Camera_UpdateSmooth:                                    ; DATA XREF: ROM:0000C86A   o  ; was: sub_CAB4
                move.b  #$81,d0
                jsr     (Sound_QueueBGMRequest).l
                addq.w  #2,(word_FFA950).w
                jsr     (Stage_DispatchVisualAssetLoader).l
                bra.w   *+4
; ---------------------------------------------------------------------------
; Updates smooth scrolling camera transitions at $1A78
Camera_Smooth_ScrollLimitCheck:                         ; CODE XREF: Camera_UpdateSmooth+14   j  ; was: loc_CACC
                                        ; DATA XREF: ROM:0000C86C   o
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$1A78,(dword_FFA900).w
                bmi.s   locret_CAE0
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_CAE0:                                            ; CODE XREF: Camera_UpdateSmooth+26   j
                rts
; End of function Camera_UpdateSmooth
; Camera following target with offset
Camera_FollowTarget:                                    ; DATA XREF: ROM:0000C86E   o  ; was: sub_CAE2
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$1AF8,(dword_FFA900).w
                bmi.s   locret_CB24
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$1AF8,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                move.b  #$10,(byte_FFA95A).w
                move.b  #4,(byte_FFA95B).w
                lea     (Boss_ShiperAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
                bsr.s   Camera_ClampToBounds
locret_CB24:                                            ; CODE XREF: Camera_FollowTarget+E   j
                rts
; End of function Camera_FollowTarget
; Sets camera boundary limits
Camera_SetBounds:                                       ; DATA XREF: ROM:0000C870   o  ; was: sub_CB26
                move.b  #3,(VDPReg11Shadow+1).w
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                bra.s   Camera_ClampToBounds
; End of function Camera_SetBounds
; Handles camera logic during stage transition checking boss state
Stage_CameraTransitionCheck:                            ; DATA XREF: ROM:0000C872   o  ; was: sub_CB32
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_CB44
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                bra.s   Stage_ScrollWaitTransition
; ---------------------------------------------------------------------------
loc_CB44:                                               ; CODE XREF: Stage_CameraTransitionCheck+4   j
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                bsr.s   Camera_ClampToBounds
                move.w  #$C0,(dword_FFA908).w
                rts
; End of function Stage_CameraTransitionCheck
; Clamps camera position to boundaries
Camera_ClampToBounds:                                   ; CODE XREF: Camera_FollowTarget+40   p  ; was: sub_CB56
                                        ; Camera_SetBounds+A   j
                movea.w #(byte_FF8800-M68K_RAM),a0
                move.w  (dword_FFA908).w,d0
                neg.w   d0
                moveq   #$7F,d7
loc_CB62:                                               ; CODE XREF: Camera_ClampToBounds+E   j
                move.w  d0,(a0)+
                dbf     d7,loc_CB62
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                moveq   #$47,d7                         ; 'G'
loc_CB70:                                               ; CODE XREF: Camera_ClampToBounds+1C   j
                move.w  d0,(a0)+
                dbf     d7,loc_CB70
                rts
; End of function Camera_ClampToBounds
; Waits for scroll position then advances stage phase
Stage_ScrollWaitTransition:                             ; CODE XREF: Stage_CameraTransitionCheck+10   j  ; was: sub_CB78
                                        ; DATA XREF: ROM:0000C874   o
                bsr.s   Camera_UpdateWithScroll
                tst.w   (MessageSequenceState).w
                bne.s   locret_CB8A
                addq.w  #2,(word_FFA950).w
                move.w  #2,(word_FFA02A).w
locret_CB8A:                                            ; CODE XREF: Stage_ScrollWaitTransition+6   j
                rts
; End of function Stage_ScrollWaitTransition
; Updates camera position and calculates scroll registers
Camera_UpdateWithScroll:                                ; CODE XREF: Stage_ScrollWaitTransition   p  ; was: sub_CB8C
                                        ; sub_CB9E   p
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                bsr.s   Camera_ClampToBounds
                move.w  #$C0,(dword_FFA908).w
                rts
; End of function Camera_UpdateWithScroll
; Checks if stage transition is ready based on enemy and boss state
Stage_CheckTransitionReady:                             ; DATA XREF: ROM:0000C876   o  ; was: sub_CB9E
                bsr.s   Camera_UpdateWithScroll
                tst.w   (word_FF8230).w
                bne.s   locret_CBB8
                tst.w   (word_FF8138).w
                bne.s   locret_CBB8
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w   Stage_StartWeaponSelectTransition
; ---------------------------------------------------------------------------
locret_CBB8:                                            ; CODE XREF: Stage_CheckTransitionReady+6   j
                                        ; Stage_CheckTransitionReady+C   j
                rts
; End of function Stage_CheckTransitionReady
; Updates automatic stage scrolling and checks for phase transition
Stage_AutoScrollUpdate:                                 ; DATA XREF: ROM:0000C878   o  ; was: sub_CBBA
                addq.w  #2,(word_FFA950).w
; Updates automatic scrolling and checks for transition
Stage_AutoScroll_UpdateLoop:                            ; DATA XREF: ROM:0000C87A   o  ; was: loc_CBBE
                bsr.w   Camera_UpdateAndRenderStageTilemap
                cmpi.w  #$400,(dword_FFA900).w
                bmi.s   locret_CBCE
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_CBCE:                                            ; CODE XREF: Stage_AutoScrollUpdate+E   j
                                        ; Boss_MadamBarbarScrollInit+A   j
                rts
; End of function Stage_AutoScrollUpdate
; Initializes Madam Barbar boss scroll position and palette
Boss_MadamBarbarScrollInit:                             ; DATA XREF: ROM:0000C87C   o  ; was: sub_CBD0
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                cmpi.w  #$480,(dword_FFA900).w
                bmi.s   locret_CBCE
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$480,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                move.w  #$8000,(word_FF808A).w
                lea     (Boss_MadamBarbarAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Boss_MadamBarbarScrollInit
; Initializes stage after boss defeat with score timer and camera
Stage_InitPostBoss:                                     ; DATA XREF: ROM:0000C87E   o  ; was: sub_CC06
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_CC1C
                clr.w   (dword_FFA90C).w
                move.l  #PostBossRuntimeSpawnList,(dword_FFA20E).w
                bsr.w   Stage_StartPostBannerDelayAndPreloadNextPhase
loc_CC1C:                                               ; CODE XREF: Stage_InitPostBoss+4   j
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage_InitPostBoss
; Start a section change and request the default BGM when no delay is active
Stage_StartNextPhaseBannerWithDefaultBGM:               ; DATA XREF: ROM:0000C880   o  ; was: sub_CC20
                tst.w   (MessageSequenceState).w
                bne.s   Stage_StartNextPhaseBannerWithDefaultBGM_Continue
                move.b  #$81,d0
                jsr     (Sound_QueueBGMRequest).l
Stage_StartNextPhaseBannerWithDefaultBGM_Continue:      ; CODE XREF: Stage_StartNextPhaseBannerWithDefaultBGM+4   j  ; was: loc_CC30
                clr.w   (word_FF808A).w
                bsr.w   Stage_StartNextPhaseBanner
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage_StartNextPhaseBannerWithDefaultBGM
; Checks scroll position for stage phase transition trigger
Stage_CheckScrollTransition:                            ; DATA XREF: ROM:0000C882   o  ; was: sub_CC3C
                bsr.w   Camera_UpdateAndRenderStageTilemap
                cmpi.w  #$9E0,(dword_FFA900).w
                bmi.s   locret_CC4C
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_CC4C:                                            ; CODE XREF: Stage_CheckScrollTransition+A   j
                                        ; Stage_InitJokerBoss+A   j
                rts
; End of function Stage_CheckScrollTransition
; Initializes Joker boss fight with scroll check and palette update
Stage_InitJokerBoss:                                    ; DATA XREF: ROM:0000C884   o  ; was: sub_CC4E
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                cmpi.w  #$A60,(dword_FFA900).w
                bmi.s   locret_CC4C
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$A60,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                move.w  #$8000,(word_FF808A).w
                lea     (Boss_JokerAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage_InitJokerBoss
; Post-boss initialization triggering stage phase transition
Stage_PostJokerBoss:                                    ; DATA XREF: ROM:0000C886   o  ; was: sub_CC84
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_CC92
                clr.w   (dword_FFA90C).w
                bsr.w   Stage_StartTimeBonusAndPreloadNextPhase
loc_CC92:                                               ; CODE XREF: Stage_PostJokerBoss+4   j
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage_PostJokerBoss
; Post-Joker transition clearing flags and updating camera
Stage_PostJokerTransition:                              ; DATA XREF: ROM:0000C888   o  ; was: sub_CC96
                clr.w   (word_FF808A).w
                bsr.w   Stage_StartNextPhaseBanner
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage_PostJokerTransition
; Initializes Stage 7 with scroll setup and palette loading
Stage_InitStage7:                                       ; DATA XREF: ROM:0000C88A   o  ; was: sub_CCA2
                tst.w   (word_FFF720).w
                bmi.s   Stage_Stage7ScrollUpdate
                bsr.w   Stage_InitProjectileSpawn
                addq.w  #2,(word_FFA950).w
                lea     stru_CCBE(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                bra.s   Stage_Stage7ScrollUpdate
; End of function Stage_InitStage7
; ---------------------------------------------------------------------------
stru_CCBE:      dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_InitStage7+E   o
                dc.l    tiles_19BE86                    ; field_2
                dc.w    $5BE0                           ; field_6
                dc.w    $FFFF

; Updates Stage 7 scroll checking transition boundaries
Stage_Stage7ScrollUpdate:                               ; CODE XREF: Stage_InitStage7+4   j  ; was: sub_CCC8
                                        ; Stage_InitStage7+1A   j
                                        ; DATA XREF:
                bsr.w   Camera_UpdateAndRenderStageTilemap
                move.w  (dword_FFA900).w,d0
                add.w   (dword_FFA410).w,d0
                cmpi.w  #$1098,(dword_FFA900).w
                bpl.s   loc_CCE2
                cmpi.w  #$1116,d0
                bmi.s   loc_CD00
loc_CCE2:                                               ; CODE XREF: Stage_Stage7ScrollUpdate+12   j
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                move.w  #0,(word_FFA946).w
                move.w  #$C0,(dword_FF8062).w
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_CCFE:                                            ; CODE XREF: Stage_Stage7ScrollUpdate+3C   j
                                        ; Stage_InitTerobusterBoss+2A   j
                rts
; ---------------------------------------------------------------------------
loc_CD00:                                               ; CODE XREF: Stage_Stage7ScrollUpdate+18   j
                cmpi.w  #$10B6,d0
                bmi.s   locret_CCFE
                bra.w   Stage_SpawnIntroProjectile
; End of function Stage_Stage7ScrollUpdate
; Initializes Terobuster boss with scroll and graphics loading
Stage_InitTerobusterBoss:                               ; DATA XREF: ROM:0000C88E   o  ; was: sub_CD0A
                bsr.w   Stage_SpawnIntroProjectile
                subq.w  #1,(dword_FF8062).w
                bsr.w   Stage_UpdateScrollOffset
                bsr.w   Stage_LoadTerobusterTiles
                jsr     (Tilemap_QueueNextConstantRow).l
                addi.l  #$C000,(dword_FFA900).w
                jsr     (Tilemap_QueuePrimaryCameraColumnOffset158).l
                cmpi.w  #$10A0,(dword_FFA900).w
                bmi.s   locret_CCFE
                clr.l   (dword_FFA910).w
                move.w  #$10A0,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                tst.w   (dword_FF8062).w
                bpl.s   locret_CCFE
                addq.w  #2,(word_FFA950).w
                move.w  #$8000,(word_FF808A).w
                lea     (Boss_TerobusterAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage_InitTerobusterBoss
; Updates stage scroll offset with directional calculation
Stage_UpdateScrollOffset:                               ; CODE XREF: Stage_InitTerobusterBoss+8   p  ; was: sub_CD66
                move.w  (dword_FF8062).w,d0
                bmi.s   locret_CCFE
                bne.s   loc_CD72
                moveq   #0,d2
                bra.s   loc_CD7C
; ---------------------------------------------------------------------------
loc_CD72:                                               ; CODE XREF: Stage_UpdateScrollOffset+6   j
                moveq   #2,d2
                asr.w   #1,d0
                andi.w  #$E,d0
                sub.w   d0,d2
loc_CD7C:                                               ; CODE XREF: Stage_UpdateScrollOffset+A   j
                move.w  d2,d3
                lea     (PaletteFade_StageScrollEntryOffsets).l,a2
                moveq   #0,d1
                asl.w   #4,d2
                asl.w   #8,d3
                jmp     (Gfx_FadeRGBColor_LoadEntryCount).l
; End of function Stage_UpdateScrollOffset
; Post-intro transition clearing flags and advancing phase
Stage_PostTerobusterIntro:                              ; DATA XREF: ROM:0000C890   o  ; was: sub_CD90
                bsr.w   Stage_SpawnIntroProjectile
                bsr.w   Stage_LoadTerobusterTiles
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_CDB8
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                clr.w   (dword_FFA90C).w
loc_CDB8:                                               ; CODE XREF: Stage_PostTerobusterIntro+C   j
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage_PostTerobusterIntro
; Post-Terobuster transition clearing flags and advancing
Stage_PostTerobusterTransition:                         ; DATA XREF: ROM:0000C892   o  ; was: sub_CDBC
                tst.w   (MessageSequenceState).w
                bne.s   loc_CDDE
                move.b  #1,(byte_FF830E).w
                move.w  #4,(word_FFA02A).w
                addq.w  #2,(word_FFA950).w
                lea     byte_D6A6(pc),a0
                nop
                jsr     (Tilemap_QueueIndexedRows).l
loc_CDDE:                                               ; CODE XREF: Stage_PostTerobusterTransition+4   j
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage_PostTerobusterTransition
; Stage 7 to 8 transition with scroll boundary check
Stage_Stage7To8Transition:                              ; DATA XREF: ROM:0000C894   o  ; was: sub_CDE2
                bsr.w   Camera_UpdateAndRenderStageTilemap
                cmpi.w  #$1200,(dword_FFA900).w
                bmi.s   locret_CDF8
                addq.w  #2,(word_FFA950).w
                move.w  #$1200,(dword_FFA900).w
locret_CDF8:                                            ; CODE XREF: Stage_Stage7To8Transition+A   j
                rts
; End of function Stage_Stage7To8Transition
; Checks player X position to trigger stage transition
