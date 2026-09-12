Stage_Epsilon1Init:                                     ; DATA XREF: ROM:0000D9C6   o  ; was: sub_E11C
                tst.w   (word_FF8230).w
                bne.s   locret_E14C
                move.l  #StageTransitionMessageSequence_Shared,(StageMessageCursor).w
                jsr     (Stage_StartInterstageTransition).l
                move.w  #$8002,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                move.b  #$8B,(PendingStageBGMRequest).w
locret_E14C:                                            ; CODE XREF: Stage_Epsilon1Init+4   j
                rts
; End of function Stage_Epsilon1Init
; Update wave distortion effect based on counter
Effect_UpdateWaveDistortion:
                btst    #0,(word_FFF706).w              ; was: sub_E14E
                beq.s   loc_E15A
                addq.w  #2,(word_FF806E).w
loc_E15A:                                               ; CODE XREF: Effect_UpdateWaveDistortion+6   j
                btst    #1,(word_FFF706).w
                beq.s   loc_E166
                subq.w  #2,(word_FF806E).w
loc_E166:                                               ; CODE XREF: Effect_UpdateWaveDistortion+12   j
                move.w  (word_FF806E).w,d0
                move.w  d0,d1
                asr.w   #2,d0
                andi.w  #$1E,d0
                beq.s   locret_E182
                addi.w  #-$1CE0,d0
                movea.w d0,a0
                andi.w  #6,d1
                move.w  word_E184(pc,d1.w),(a0)
locret_E182:                                            ; CODE XREF: Effect_UpdateWaveDistortion+24   j
                rts
; End of function Effect_UpdateWaveDistortion
; ---------------------------------------------------------------------------
word_E184:      dc.w    $200, $400, $622, $844, $5478, $A950

; Handle parallax scroll transition with countdown
Stage_ParallaxScrollTransit:
                move.w  #$2E,(word_FFA02A).w            ; '.'  ; was: sub_E190
                move.w  #$20,(dword_FF8128).w           ; ' '
                move.w  #$308,(word_FFC680).w
                clr.w   (word_FFC684).w
                bsr.w   Stage_Epsilon1UpdateScrollParallax
                tst.w   (word_FFC680).w
                bne.s   locret_E1BE
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FFA02A).w
                bclr    #0,(byte_FFA958).w
locret_E1BE:                                            ; CODE XREF: Stage_ParallaxScrollTransit+1E   j
                rts
; End of function Stage_ParallaxScrollTransit
; Stage scroll handler
Stage_Epsilon1Scroll:                                   ; DATA XREF: ROM:0000D9C8   o  ; was: sub_E1C0
                                        ; ROM:0000D9CA   o
                move.w  #$18,(dword_FF8128).w
                bsr.w   Stage_Epsilon1UpdateScrollParallax
                tst.w   (Entity_ObjectPool).w
                bne.s   locret_E1D4
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_E1D4:                                            ; CODE XREF: Stage_Epsilon1Scroll+E   j
                rts
; End of function Stage_Epsilon1Scroll
; Battle start with palette update
Stage_Epsilon1BattleStart:                              ; DATA XREF: ROM:0000D9CC   o  ; was: sub_E1D6
                bsr.w   Stage_Epsilon1UpdateScrollParallax
                addq.w  #2,(word_FFA950).w
                lea     (Boss_Epsilon1AssetSet).l,a1
                bra.w   Boss_LoadAssetSet
; End of function Stage_Epsilon1BattleStart
; Waits for boss intro completion
Stage_Epsilon1WaitIntroComplete:                        ; DATA XREF: ROM:0000D9CE   o  ; was: sub_E1E8
                tst.w   (Entity_ObjectPool).w
                bne.s   Stage_Epsilon1UpdateScrollParallax
                addq.w  #2,(word_FFA950).w
; End of function Stage_Epsilon1WaitIntroComplete
; Updates scroll position and parallax
Stage_Epsilon1UpdateScrollParallax:                     ; CODE XREF: Stage_ParallaxScrollTransit+16   p  ; was: sub_E1F2
                                        ; Stage_Epsilon1Scroll+6   p
                btst    #0,(byte_FFA958).w
                beq.s   loc_E1FC
                rts
; ---------------------------------------------------------------------------
loc_E1FC:                                               ; CODE XREF: Stage_Epsilon1UpdateScrollParallax+6   j
                move.w  (dword_FF8128).w,d0
                subi.w  #$28,d0                         ; '('
                neg.w   d0
                move.w  d0,(dword_FFA904).w
                move.l  #$FFFEA000,(dword_FF8130).w
                move.l  (dword_FF812C).w,d0
                add.l   (dword_FF8130).w,d0
                move.l  d0,(dword_FF812C).w
                asr.l   #8,d0
                move.l  d0,d1
                muls.w  #4,d0
                muls.w  #3,d1
                asl.l   #8,d0
                asl.l   #8,d1
                swap    d0
                swap    d1
                movea.w #(word_FFEC02-M68K_RAM),a0
                move.w  d0,(a0)
                move.w  d1,4(a0)
                move.w  d1,8(a0)
                move.w  d1,$C(a0)
                move.w  d1,$40(a0)
                move.w  d1,$44(a0)
                move.w  d1,$48(a0)
                move.w  d0,$4C(a0)
                rts
; End of function Stage_Epsilon1UpdateScrollParallax
; Planet cutscene initialization
Cutscene_PlanetInit:                                    ; DATA XREF: ROM:0000D9D0   o  ; was: sub_E256
                tst.w   (word_FF8230).w
                bne.w   Stage_Epsilon1UpdateScrollParallax
                move.w  #$8002,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                bset    #2,(byte_FF80F8).w
                move.w  #4,(SetupTransitionIndex).w
                move.w  #4,(word_FF8230).w
                rts
; End of function Cutscene_PlanetInit
; Spawns 4 projectiles in a pattern with velocity data
Projectile_SpawnQuadPattern:                            ; CODE XREF: Boss_DeepStriderSpawnQuadVolley+8   j  ; was: sub_E288
                                        ; Boss_SharpssteelOpeningVerticalTurnState+C6   p
                moveq   #8,d3
loc_E28A:                                               ; CODE XREF: Boss_SharpssteelDiveAttackState+32   p
                moveq   #0,d4
                moveq   #3,d7
                lea     dword_E2D6(pc),a4
                nop
; Initializes projectile properties in a loop with animation and position
Projectile_InitializeLoop:                              ; CODE XREF: Projectile_SpawnQuadPattern+48   j  ; was: loc_E294
                jsr     (Projectile_FindFreeOrRecycleSlot).l
                bne.s   locret_E2D4
                jsr     (Projectile_InitType1A8).l
                move.l  #SharedProjectileDuration4Animation,8(a0)
                move.w  (word_FF808A).w,d0
                addi.w  #$4000,d0
                move.w  d0,$E(a0)
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                move.b  d3,$20(a0)
                move.l  (a4,d4.w),$18(a0)
                move.l  $10(a4,d4.w),$1C(a0)
                addq.w  #4,d4
                dbf     d7,Projectile_InitializeLoop
locret_E2D4:                                            ; CODE XREF: Projectile_SpawnQuadPattern+12   j
                rts
; End of function Projectile_SpawnQuadPattern
; ---------------------------------------------------------------------------
dword_E2D6:     dc.l    $FFFDC000, $FFFF4000
                                        ; DATA XREF: Projectile_SpawnQuadPattern+6   o
                dc.l    $C000, $24000
                dc.l    $FFFD8000, $FFFC8000
                dc.l    $FFFC8000, $FFFD8000

; Spawns projectile at calculated angle
Enemy_SpawnProjectileAtAngle:                           ; CODE XREF: Stage11_RisingHazardReactToHit+26   p  ; was: sub_E2F6
                                        ; Boss_GustheadLinkedChainBeginAttackCycle+34   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_E34A
                jsr     (Projectile_InitType1A8).l
                clr.b   $21(a0)
                move.l  #SharedProjectileDuration4Animation,8(a0)
                move.w  (word_FF808A).w,d0
                addi.w  #$4000,d0
                move.w  d0,$E(a0)
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                move.b  #8,$20(a0)
                lea     (Math_SineTable).l,a4
                move.w  Math_QuarterSineTable-Math_SineTable(a4,d4.w),d0
                move.w  (a4,d4.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                moveq   #0,d0
locret_E34A:                                            ; CODE XREF: Enemy_SpawnProjectileAtAngle+6   j
                rts
; End of function Enemy_SpawnProjectileAtAngle
nullsub_25:
                rts
; End of function nullsub_25

; Updates background scroll for Snake stage
Scroll_UpdateSnakeBackground:                           ; CODE XREF: Stage_TeleportUpdateScroll   p  ; was: sub_E34E
                                        ; sub_DD2E   p
                movea.w #(byte_FFA3E0-M68K_RAM),a0
                lea     dword_E3CC(pc),a1
                nop
                lea     word_E3EC(pc),a2
                nop
                movea.w (VDPStagingDataCursor).w,a4
                moveq   #3,d7
loc_E364:                                               ; CODE XREF: Scroll_UpdateSnakeBackground+56   j
                bsr.w   Scroll_AccumulateOffset
loc_E368:                                               ; CODE XREF: Scroll_UpdateSnakeBackground+26   j
                andi.w  #7,d0
                move.b  (a2,d0.w),(a4)
                addq.w  #1,d0
                addq.w  #4,a4
                dbf     d6,loc_E368
                adda.l  #8,a2
                suba.w  #$20,a4                         ; ' '
                bsr.w   Scroll_AccumulateOffset
loc_E386:                                               ; CODE XREF: Scroll_UpdateSnakeBackground+48   j
                andi.w  #7,d0
                move.b  (a4),d1
                or.b    (a2,d0.w),d1
                move.b  d1,(a4)
                addq.w  #1,d0
                addq.w  #4,a4
                dbf     d6,loc_E386
                adda.l  #8,a2
                suba.w  #$1F,a4
                dbf     d7,loc_E364
                move.w  #$1BC0,d0
                move.l  #$94009310,d4
                jsr     (VDP_QueueCommand).l
                addi.w  #$20,(VDPStagingDataCursor).w   ; ' '
                rts
; End of function Scroll_UpdateSnakeBackground
; Accumulates scroll offset from acceleration table for snake background
Scroll_AccumulateOffset:                                ; CODE XREF: Scroll_UpdateSnakeBackground:loc_E364   p  ; was: sub_E3C0
                                        ; Scroll_UpdateSnakeBackground+34   p
                move.l  (a0),d0
                add.l   (a1)+,d0
                move.l  d0,(a0)+
                swap    d0
                moveq   #7,d6
                rts
; End of function Scroll_AccumulateOffset
; ---------------------------------------------------------------------------
dword_E3CC:     dc.l    $FFFF8000                       ; DATA XREF: Scroll_UpdateSnakeBackground+4   o
                dc.l    $FFFF4000
                dc.l    $FFFF0000
                dc.l    $FFFF6000
                dc.l    $FFFEE000
                dc.l    $FFFFA000
                dc.l    $FFFF0000
                dc.l    $FFFFC000
word_E3EC:      dc.w    $C0D0, $D0D0, $E0E0, $E0E0, $C0D, $E0E, $D0D, $E0E
                                        ; DATA XREF: Scroll_UpdateSnakeBackground+A   o
                dc.w    $C0D0, $D0E0, $C0E0, $E0E0, $C0D, $E0E, $E0E, $E0E
                dc.w    $D0E0, $E0D0, $D0E0, $E0E0, $E0E, $C0D, $D0E, $C0E
                dc.w    $E0E0, $E0E0, $E0E0, $E0E0, $D0D, $D0D, $C0E, $E0E

; Stage 18 scroll handler
Stage_Stage18Scroll:                                    ; DATA XREF: ROM:0000FF3E   o  ; was: sub_E42C
                movea.w off_E438(pc,d0.w),a0
                adda.l  #Stage_Stage18EmptyHandler,a0
                jmp     (a0)
; End of function Stage_Stage18Scroll
; ---------------------------------------------------------------------------
off_E438:       dc.w    Stage_Stage18StartBattle-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18PreBoss-Stage_Stage18EmptyHandler
                dc.w    Stage_DestroyerMK2Init-Stage_Stage18EmptyHandler
                dc.w    Boss_DestroyerMK2UpdateHealth-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage19Init-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage19Scroll-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage19Transition-Stage_Stage18EmptyHandler
                dc.w    Stage_JampanInit-Stage_Stage18EmptyHandler
                dc.w    Stage_JampanBattleStart-Stage_Stage18EmptyHandler
                dc.w    Stage_JampanPostBattle-Stage_Stage18EmptyHandler
                dc.w    Stage_JampanDefeatCamera-Stage_Stage18EmptyHandler
                dc.w    Stage_JampanPostDefeatInit-Stage_Stage18EmptyHandler
                dc.w    Stage_JampanPostDefeatCheck-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_InitBossPhase1-Stage_Stage18EmptyHandler
                dc.w    Stage_WaitFlagUpdateCamera1-Stage_Stage18EmptyHandler
                dc.w    Stage_CheckEnemiesTransit1-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_InitBossPhase2-Stage_Stage18EmptyHandler
                dc.w    Stage_WaitFlagUpdateCamera2-Stage_Stage18EmptyHandler
                dc.w    Stage_CheckEnemiesTransit2-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_InitBossPhase3-Stage_Stage18EmptyHandler
                dc.w    Stage_WaitFlagUpdateCamera3-Stage_Stage18EmptyHandler
                dc.w    Stage_CheckEnemiesTransit3-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_InitBossPhase4-Stage_Stage18EmptyHandler
                dc.w    Stage_WaitFlagUpdateCamera4-Stage_Stage18EmptyHandler
                dc.w    Stage_CheckEnemiesTransit4-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesInitializeStage20-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesUpdateStage20Scroll-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesAdvanceToMedusa-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesFinishMedusaScroll-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesInitializeSylpheedScroll-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesUpdateSylpheedScroll-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesAdvanceSylpheedForeground-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesFinishSylpheedForeground-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesBeginArtemisTransition-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesWaitForArtemisBackground-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesWaitForArtemisTrigger-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesScrollArtemisBackground-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesScrollArtemisForeground-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesBeginSireneTransition-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesAdvanceSireneTransition-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesFinishSireneTransition-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesWaitBeforeVictory-Stage_Stage18EmptyHandler
                dc.w    Stage_SevenForcesInitializeVictoryTransition-Stage_Stage18EmptyHandler
                dc.w    Cutscene_SevenForcesVictoryState0-Stage_Stage18EmptyHandler
                dc.w    Cutscene_SevenForcesVictoryState1-Stage_Stage18EmptyHandler
                dc.w    Cutscene_SevenForcesVictoryState2-Stage_Stage18EmptyHandler
                dc.w    Cutscene_SevenForcesVictoryState3-Stage_Stage18EmptyHandler
                dc.w    Cutscene_SevenForcesVictoryState4-Stage_Stage18EmptyHandler
                dc.w    Cutscene_SevenForcesVictoryState5-Stage_Stage18EmptyHandler
                dc.w    Cutscene_SevenForcesVictoryState6-Stage_Stage18EmptyHandler
                dc.w    Cutscene_SevenForcesVictoryIdleState-Stage_Stage18EmptyHandler

; Empty handler called from stage 18 battle start
