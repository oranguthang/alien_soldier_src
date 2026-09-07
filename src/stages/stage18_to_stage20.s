Stage_Stage18EmptyHandler:                             ; CODE XREF: Stage_Stage18StartBattle+16   j  ; was: nullsub_26
                                        ; Stage_Stage18PreBoss+10   j ...
                rts
; End of function Stage_Stage18EmptyHandler
; Starts boss battle
Stage_Stage18StartBattle:                               ; DATA XREF: ROM:off_E438   o  ; was: sub_E4DE
                bset    #6,(byte_FF8245).w
                jsr (Gfx_LoadStage18Tiles).l
                bsr.w Stage_Stage18Transition
                cmpi.w  #$820,(dword_FFA900).w
                bmi.s Stage_Stage18EmptyHandler
                addq.w  #2,(word_FFA950).w
locret_E4FA:                            ; CODE XREF: Stage_LoadStage18ConfigAlt+A   p
                rts
; End of function Stage_Stage18StartBattle
; Pre-boss battle setup
Stage_Stage18PreBoss:                               ; DATA XREF: ROM:0000E43A   o  ; was: sub_E4FC
                jsr (Gfx_LoadStage18Tiles).l
                bsr.w Stage_Stage18Transition
                cmpi.w  #$BF0,(dword_FFA900).w
                bmi.s Stage_Stage18EmptyHandler
                bra.w Stage_TransitionToNextPhase
; End of function Stage_Stage18PreBoss
; Destroyer-MK2 boss initialization
Stage_DestroyerMK2Init:                               ; DATA XREF: ROM:0000E43C   o  ; was: sub_E512
                jsr (Gfx_LoadDestroyerMK2Tiles).l
                bsr.w Stage_Stage18Transition
                cmpi.w  #$C70,(dword_FFA900).w
                bmi.s Stage_Stage18EmptyHandler
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$C70,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                move.w  #$8000,(word_FF808A).w
                lea     (stru_1151C).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Stage_DestroyerMK2Init
; Updates boss health
Boss_DestroyerMK2UpdateHealth:                               ; DATA XREF: ROM:0000E43E   o  ; was: sub_E54E
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_E558
                bsr.w Stage_TriggerPhaseTransition
loc_E558:                               ; CODE XREF: Boss_DestroyerMK2UpdateHealth+4   j
                jsr (Camera_UpdateTowardsPlayer).l
                bra.w Stage_Stage18Transition
; End of function Boss_DestroyerMK2UpdateHealth
; Stage 19 initialization
Stage_Stage19Init:                               ; DATA XREF: ROM:0000E440   o  ; was: sub_E562
                bsr.w Stage_InitSectionChange
                jsr (Camera_UpdateTowardsPlayer).l
                bra.w Stage_Stage18Transition
; End of function Stage_Stage19Init
; Stage 19 scroll handler
Stage_Stage19Scroll:                               ; DATA XREF: ROM:0000E442   o  ; was: sub_E570
                jsr (Gfx_LoadStage18Tiles).l
                bsr.w Stage_Stage18Transition
                cmpi.w  #$D80,(dword_FFA900).w
                bmi.w Stage_Stage18EmptyHandler
                addq.w  #2,(word_FFA950).w
                lea     stru_E594(pc),a0
                nop
                jmp (Data_ProcessPointer).l
; End of function Stage_Stage19Scroll
; ---------------------------------------------------------------------------
stru_E594:      dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_Stage19Scroll+18   o
                dc.l tiles_1AF666       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B0BE8        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B0C64        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B10CC        ; field_2
                dc.w $7800              ; field_6
                dc.w $FFFF


; Stage transition to boss
Stage_Stage19Transition:                               ; DATA XREF: ROM:0000E444   o  ; was: sub_E5B6
                jsr (Gfx_UpdateScroll).l
                bsr.w Stage_Stage18Transition
                cmpi.w  #$1120,(dword_FFA900).w
                bmi.w Stage_Stage18EmptyHandler
                addq.w  #2,(word_FFA950).w
                rts
; End of function Stage_Stage19Transition
; Jampan boss initialization
Stage_JampanInit:                               ; DATA XREF: ROM:0000E446   o  ; was: sub_E5D0
                jsr (Gfx_UpdateScroll).l
                bsr.w Stage_Stage18Transition
                cmpi.w  #$1200,(dword_FFA900).w
                bmi.w Stage_Stage18EmptyHandler
                addq.w  #2,(word_FFA950).w
                rts
; End of function Stage_JampanInit
; Jampan battle start
Stage_JampanBattleStart:                               ; DATA XREF: ROM:0000E448   o  ; was: sub_E5EA
                jsr (Gfx_UpdateScroll).l
                bsr.w Stage_Stage18Transition
                cmpi.w  #$1200,(dword_FFA900).w
                bmi.w Stage_Stage18EmptyHandler
                bra.w Stage_TransitionToNextPhase
; End of function Stage_JampanBattleStart
; Post-battle cleanup
Stage_JampanPostBattle:                               ; DATA XREF: ROM:0000E44A   o  ; was: sub_E602
                jsr (Gfx_LoadBossTiles).l
                cmpi.w  #$1280,(dword_FFA900).w
                bmi.w Stage_Stage18EmptyHandler
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$1280,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (stru_114E4).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Stage_JampanPostBattle
; Camera during defeat sequence
Stage_JampanDefeatCamera:                               ; DATA XREF: ROM:0000E44C   o  ; was: sub_E636
                tst.b   (byte_FFA958).w
                beq.s   loc_E640
                addq.w  #2,(word_FFA950).w
loc_E640:                               ; CODE XREF: Stage_JampanDefeatCamera+4   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_JampanDefeatCamera
; Post-defeat stage init
Stage_JampanPostDefeatInit:                               ; DATA XREF: ROM:0000E44E   o  ; was: sub_E644
                tst.w   (word_FF80C2).w
                bne.s   locret_E654
                addq.w  #2,(word_FFA950).w
                move.w  #$32,(word_FFA02A).w ; '2'
locret_E654:                            ; CODE XREF: Stage_JampanPostDefeatInit+4   j
                rts
; End of function Stage_JampanPostDefeatInit
; Post-defeat checks and transition
Stage_JampanPostDefeatCheck:                               ; DATA XREF: ROM:0000E450   o  ; was: sub_E656
                bsr.w Camera_UpdateTowardsPlayer
                tst.w   (word_FF8230).w
                bne.s   locret_E678
                tst.w   (word_FF8138).w
                bne.s   locret_E678
                move.b  #0,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; ---------------------------------------------------------------------------
locret_E678:                            ; CODE XREF: Stage_JampanPostDefeatCheck+8   j
                                        ; Stage_JampanPostDefeatCheck+E   j
                rts
; End of function Stage_JampanPostDefeatCheck
; Stage transition logic
Stage_Stage18Transition:                               ; CODE XREF: Stage_Stage18StartBattle+C   p  ; was: sub_E67A
                                        ; Stage_Stage18PreBoss+6   p ...
                move.w  (dword_FFA900).w,d0
                asr.w   #3,d0
                move.w  d0,(dword_FFA908).w
                rts
; End of function Stage_Stage18Transition
; Initialize boss phase with palette update 1
Stage_InitBossPhase1:                               ; DATA XREF: ROM:0000E460   o  ; was: sub_E686
                bsr.w Stage_TransitionToNextPhase
                clr.b   (byte_FFA958).w
                move.w  #$40,(word_FFA970).w ; '@'
                move.w  #$80,(word_FFA974).w
                move.b  #1,(byte_FF830E).w
                lea     (stru_114E4).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Stage_InitBossPhase1
; Wait for flag clear then advance and update camera
Stage_WaitFlagUpdateCamera1:                               ; DATA XREF: ROM:0000E462   o  ; was: sub_E6AC
                tst.b   (byte_FFA958).w
                beq.s   loc_E6B6
                addq.w  #2,(word_FFA950).w
loc_E6B6:                               ; CODE XREF: Stage_WaitFlagUpdateCamera1+4   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_WaitFlagUpdateCamera1
; Check for active enemies then init transition
Stage_CheckEnemiesTransit1:                               ; DATA XREF: ROM:0000E464   o  ; was: sub_E6BA
                tst.w   (word_FF8230).w
                bne.w Stage_Stage18EmptyHandler
                tst.w   (word_FF8138).w
                bne.w Stage_Stage18EmptyHandler
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; End of function Stage_CheckEnemiesTransit1
; ===============================================================================
; UNUSED BOSS LOADER: Lambda Bunny Palette Loader
; Description: Loads palette data for unused Lambda Bunny boss ($03EC)
; Target Structure: stru_115A8 (line 21055)
; Palette Source: byte_C5BE (line 13697)
; Status: Complete loader function, never called by stage dispatcher
; ===============================================================================
; Initialize boss phase with palette update 2
Stage_InitBossPhase2:                               ; DATA XREF: ROM:0000E468   o  ; was: sub_E6D6
                bsr.w Stage_TransitionToNextPhase
                clr.b   (byte_FFA958).w
                move.w  #$40,(word_FFA970).w ; '@'
                move.w  #$80,(word_FFA974).w
                move.b  #1,(byte_FF830E).w
                lea     (stru_115A8).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Stage_InitBossPhase2
; Wait for flag clear then advance and update camera
Stage_WaitFlagUpdateCamera2:                               ; DATA XREF: ROM:0000E46A   o  ; was: sub_E6FC
                tst.b   (byte_FFA958).w
                beq.s   loc_E706
                addq.w  #2,(word_FFA950).w
loc_E706:                               ; CODE XREF: Stage_WaitFlagUpdateCamera2+4   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_WaitFlagUpdateCamera2
; Check for enemies then init transition with sound
Stage_CheckEnemiesTransit2:                               ; DATA XREF: ROM:0000E46C   o  ; was: sub_E70A
                tst.w   (word_FF8230).w
                bne.w Stage_Stage18EmptyHandler
                tst.w   (word_FF8138).w
                bne.w Stage_Stage18EmptyHandler
                move.b  #$8F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; End of function Stage_CheckEnemiesTransit2
; ===============================================================================
; UNUSED BOSS LOADER: Unknown Boss $3F0 Palette Loader
; Description: Loads palette data for unknown unused boss ($3F0)
; Target Structure: stru_115C4 (line 21076)
; Palette Source: byte_C5DE (line 13700)
; Status: Complete loader function, never called by stage dispatcher
; ===============================================================================
; Initialize boss phase with palette update 3
Stage_InitBossPhase3:                               ; DATA XREF: ROM:0000E470   o  ; was: sub_E72C
                bsr.w Stage_TransitionToNextPhase
                clr.b   (byte_FFA958).w
                move.w  #$40,(word_FFA970).w ; '@'
                move.w  #$80,(word_FFA974).w
                move.b  #1,(byte_FF830E).w
                lea     (stru_115C4).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Stage_InitBossPhase3
; Wait for flag clear then advance and update camera
Stage_WaitFlagUpdateCamera3:                               ; DATA XREF: ROM:0000E472   o  ; was: sub_E752
                tst.b   (byte_FFA958).w
                beq.s   loc_E75C
                addq.w  #2,(word_FFA950).w
loc_E75C:                               ; CODE XREF: Stage_WaitFlagUpdateCamera3+4   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_WaitFlagUpdateCamera3
; Check for enemies then init transition with sound
Stage_CheckEnemiesTransit3:                               ; DATA XREF: ROM:0000E474   o  ; was: sub_E760
                tst.w   (word_FF8230).w
                bne.w Stage_Stage18EmptyHandler
                tst.w   (word_FF8138).w
                bne.w Stage_Stage18EmptyHandler
                move.b  #$8F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; End of function Stage_CheckEnemiesTransit3
; ===============================================================================
; UNUSED BOSS LOADER: Unknown Boss $3F4 Palette Loader
; Description: Loads palette data for unknown unused boss ($3F4)
; Target Structure: stru_115E0 (line 21120)
; Palette Source: byte_C5FE (line 13742)
; Status: Complete loader function, never called by stage dispatcher
; Note: Possibly for Praying Mantis or Sigma Fox from Jampan Area
; ===============================================================================
; Initialize boss phase with palette update 4
Stage_InitBossPhase4:                               ; DATA XREF: ROM:0000E478   o  ; was: sub_E782
                bsr.w Stage_TransitionToNextPhase
                clr.b   (byte_FFA958).w
                move.w  #$40,(word_FFA970).w ; '@'
                move.w  #$80,(word_FFA974).w
                move.b  #1,(byte_FF830E).w
                lea     (stru_115E0).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Stage_InitBossPhase4
; Wait for flag clear then advance and update camera
Stage_WaitFlagUpdateCamera4:                               ; DATA XREF: ROM:0000E47A   o  ; was: sub_E7A8
                tst.b   (byte_FFA958).w
                beq.s   loc_E7B2
                addq.w  #2,(word_FFA950).w
loc_E7B2:                               ; CODE XREF: Stage_WaitFlagUpdateCamera4+4   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_WaitFlagUpdateCamera4
; Check for enemies then init transition alt sound
Stage_CheckEnemiesTransit4:                               ; DATA XREF: ROM:0000E47C   o  ; was: sub_E7B6
                tst.w   (word_FF8230).w
                bne.w Stage_Stage18EmptyHandler
                tst.w   (word_FF8138).w
                bne.w Stage_Stage18EmptyHandler
                move.b  #$96,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; End of function Stage_CheckEnemiesTransit4
; Stage 20 initialization
