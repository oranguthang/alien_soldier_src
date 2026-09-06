Stage_FlyingNeoSpawn:                               ; CODE XREF: Stage_FlyingNeoScrollUpdate+14   p  ; was: sub_D714
                movea.w #(word_FFDC40-M68K_RAM),a0
                addq.w  #2,4(a0)
                move.w  #$EF00,2(a0)
                move.l  #$FFFAE000,$18(a0)
                move.l  #$FFFE8000,$1C(a0)
                lea     byte_D74E(pc),a0
                nop
                jmp Gfx_DMATransferTiles
; End of function Stage_FlyingNeoSpawn
; Applies gravity acceleration to Flying-Neo entity
Entity_FlyingNeoGravityAccel:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_D73E
                tst.w   4(a5)
                beq.s   locret_D74C
                addi.l  #$2000,$1C(a5)
locret_D74C:                            ; CODE XREF: Entity_FlyingNeoGravityAccel+4   j
                rts
; End of function Entity_FlyingNeoGravityAccel
; ---------------------------------------------------------------------------
byte_D74E:      dc.b $66, $68, $40, 0, 1, 2, $1C, $1D, $21, $22, $26, $27
                                        ; DATA XREF: Stage_FlyingNeoSpawn+1E   o


; Initializes Flying-Neo boss entity for battle
Stage_FlyingNeoInitBoss:                               ; CODE XREF: Stage_FlyingNeoBattleStart+1E   p  ; was: sub_D75A
                                        ; Stage_InitStage9Flies+24   p
                lea     (byte_BE1E).l,a0
                jmp     LoadPalette
; End of function Stage_FlyingNeoInitBoss
; Spawns random lightning effects with position variation
Effect_SpawnRandomLightning:                               ; CODE XREF: Stage_TrainScrollPhysics+8   p  ; was: sub_D766
                                        ; Stage_FlyingNeoVerticalScroll+3A   p ...
                move.w  (word_FF821E).w,d7
                bmi.w   locret_D838
                tst.w   (word_FF8220).w
                bne.w   locret_D838
                tst.w   (word_FF8222).w
                bne.w   locret_D838
                addq.w  #1,(dword_FF8062).w
                cmpi.w  #$42,(dword_FF8062).w ; 'B'
                bne.w   locret_D838
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                addq.w  #1,d0
                move.w  d0,(dword_FF8062).w
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_D7BA
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                addq.w  #3,d0
                move.w  d0,(word_FF8218).w
                move.w  #8,(word_FF8220).w
                rts
; ---------------------------------------------------------------------------
loc_D7BA:                               ; CODE XREF: Effect_SpawnRandomLightning+3C   j
                move.w  #2,(word_FF8222).w
                move.b  (dword_FFFF08).w,d0
                andi.w  #6,d0
                addq.w  #8,d0
                move.w  d0,(word_FF8218).w
                cmpi.w  #2,d7
                beq.s Effect_CreateLightningSprite
                move.b  #$1A,d0
                jsr (Sound_PlaySFX).l
; Creates lightning sprite with randomized position for stage 8 effects
Effect_CreateLightningSprite:                               ; CODE XREF: Effect_SpawnRandomLightning+6C   j  ; was: loc_D7DE
                cmpi.w  #1,d7
                beq.s   locret_D838
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  #$160,(a0)
                move.w  #$E100,2(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$C,d0
                move.l  off_D83A(pc,d0.w),8(a0)
                clr.w   $C(a0)
                move.w  #$1E8,$E(a0)
                move.b  #$70,$20(a0) ; 'p'
                move.w  (dword_FFFF08).w,d0
                andi.w  #$800,d0
                or.w    d0,$E(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                addi.w  #$A0,d0
                move.w  d0,$10(a0)
                move.w  #$F8,d0
                add.w   (dword_FFA904).w,d0
                move.w  d0,$14(a0)
locret_D838:                            ; CODE XREF: Effect_SpawnRandomLightning+4   j
                                        ; Effect_SpawnRandomLightning+C   j ...
                rts
; End of function Effect_SpawnRandomLightning
; ---------------------------------------------------------------------------
off_D83A:       dc.l off_19C6A0
                dc.l off_19C6BC
                dc.l off_19C6F0
                dc.l off_19C708
word_D84A:      dc.w 0, $E308, 9, $E326, $E328, $E32A, $E32C, $E32E
                                        ; DATA XREF: Stage_TrainScrollPhysics   o
                dc.w $E330, $E332, $E334, $E336, $E324
word_D864:      dc.w 1, $E308, $E36E, $22, $E324, $E326, $E328, $E32A
                                        ; DATA XREF: Stage_FlyingNeoVerticalScroll+32   o
                                        ; sub_D01E:loc_D040   o
                dc.w $E32C, $E32E, $E330, $E332, $E344, $E346, $E348, $E34A
                dc.w $E34C, $E34E, $E350, $E352, $E354, $E356, $E358, $E35A
                dc.w $E35C, $E35E, $E362, $E364, $E366, $E368, $E36A, $E370
                dc.w $E372, $E374, $E376, $E378, $E37A, $E37C, $E37E
word_D8B2:      dc.w 7, $E308, $E30A, $E30C, $E30E, $E310, $E312, $E314
                                        ; DATA XREF: Stage_FliesScrollUpdate   o
                                        ; sub_D1EA   o ...
                dc.w $E316, $23, $E324, $E326, $E328, $E32A, $E32C, $E32E
                dc.w $E330, $E332, $E344, $E346, $E348, $E34A, $E34C, $E34E
                dc.w $E350, $E352, $E354, $E356, $E358, $E35A, $E35C, $E35E
                dc.w $E362, $E364, $E366, $E368, $E36A, $E36E, $E370, $E372
                dc.w $E374, $E376, $E378, $E37A, $E37C, $E37E


; Initializes Stage 10 with scroll and enemies
Stage_InitStage10:                               ; DATA XREF: ROM:0000FF3A   o  ; was: sub_D90E
                cmpi.w  #$40,(word_FFA950).w ; '@'
                bpl.s Stage_DispatchStage10Handler
                btst    #0,(word_FFA000+1).w
                bne.s Stage_DispatchStage10Handler
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
                jsr (Sprite_AddToOAMBuffer).l
; Dispatches to appropriate stage 10 scroll handler based on phase
Stage_DispatchStage10Handler:                               ; CODE XREF: Stage_InitStage10+6   j  ; was: loc_D94C
                                        ; Stage_InitStage10+E   j
                move.w  (word_FFA950).w,d0
                movea.w off_D95C(pc,d0.w),a0
                adda.l  #Stage_Stage10ScrollUpdate,a0
                jmp     (a0)
; End of function Stage_InitStage10
; ---------------------------------------------------------------------------
off_D95C:       dc.w Stage_Stage10ScrollUpdate-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage10CheckTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_DeepStriderTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_DeepStriderBattle-Stage_Stage10ScrollUpdate
                dc.w Stage_DeepStriderBattleInit-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage11Transition-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage11ScrollUpdate-Stage_Stage10ScrollUpdate
                dc.w Stage_GustheadTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_GustheadDefeatTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage12Init-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage12ScrollUpdate-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage12_ScrollLoop-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage13Init-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage13ScrollUpdate-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage13CheckTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage13EmptyHandler-Stage_Stage10ScrollUpdate
                dc.w Stage_SharpssteelTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage14Init-Stage_Stage10ScrollUpdate
                dc.w Stage_TeleportTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_TeleportFadeIn-Stage_Stage10ScrollUpdate
                dc.w Stage_TeleportFadeSequence-Stage_Stage10ScrollUpdate
                dc.w Stage_TeleportFadeSequence_Advance-Stage_Stage10ScrollUpdate
                dc.w Stage_SnakeTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage10CheckTransition_Return-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage10CheckTransition_Return-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage10CheckTransition_Return-Stage_Stage10ScrollUpdate
                dc.w Stage_InitStage13-Stage_Stage10ScrollUpdate
                dc.w Stage_SnakeWaitScroll-Stage_Stage10ScrollUpdate
                dc.w Stage_BugmaxTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_BugmaxWaitDMA-Stage_Stage10ScrollUpdate
                dc.w Stage_BugmaxStartBattle-Stage_Stage10ScrollUpdate
                dc.w Stage_BugmaxTransitionCheck-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage14Scroll-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage14Scroll_Update-Stage_Stage10ScrollUpdate
                dc.w Stage_InitBossPaletteScroll-Stage_Stage10ScrollUpdate
                dc.w Stage_InitScoreTimerClear-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage15Transition-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage15Scroll-Stage_Stage10ScrollUpdate
                dc.w Stage_ScrollCheckTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_SunsetStingTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_SunsetStingWaitBattle-Stage_Stage10ScrollUpdate
                dc.w Stage_PostSunsetStingTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_ViblackScroll-Stage_Stage10ScrollUpdate
                dc.w Stage_ViblackInit-Stage_Stage10ScrollUpdate
                dc.w Stage_ConstrainCameraBounds-Stage_Stage10ScrollUpdate
                dc.w Stage_Stage17Transition-Stage_Stage10ScrollUpdate
                dc.w Stage_ViblackPostBattleScroll1-Stage_Stage10ScrollUpdate
                dc.w Stage_ViblackPostBattleScroll2-Stage_Stage10ScrollUpdate
                dc.w Stage_PostViblackTransition-Stage_Stage10ScrollUpdate
                dc.w Stage_PostViblackTransition_Render-Stage_Stage10ScrollUpdate
                dc.w Stage_SetVerticalScrollOfs-Stage_Stage10ScrollUpdate
                dc.w Stage_PostViblackFade-Stage_Stage10ScrollUpdate
                dc.w Stage_PostViblackScrollDecel-Stage_Stage10ScrollUpdate
                dc.w Stage_Epsilon1Init-Stage_Stage10ScrollUpdate
                dc.w Stage_Epsilon1Scroll-Stage_Stage10ScrollUpdate
                dc.w Stage_Epsilon1Scroll-Stage_Stage10ScrollUpdate
                dc.w Stage_Epsilon1BattleStart-Stage_Stage10ScrollUpdate
                dc.w Stage_Epsilon1WaitIntroComplete-Stage_Stage10ScrollUpdate
                dc.w Cutscene_PlanetInit-Stage_Stage10ScrollUpdate


; Updates Stage 10 scroll positions
Stage_Stage10ScrollUpdate:                               ; DATA XREF: Stage_InitStage10+46   o  ; was: sub_D9D2
                                        ; ROM:off_D95C   o ...
                move.w  #$50,(word_FF80C2).w ; 'P'
                bsr.w Stage_LoadStage10Graphics
; End of function Stage_Stage10ScrollUpdate
; Checks transition to next segment
Stage_Stage10CheckTransition:                               ; DATA XREF: ROM:0000D95E   o  ; was: sub_D9DC
                bsr.w Gfx_UpdateScroll
                bsr.w Scroll_AddDeltaToScroll
                cmpi.w  #$730,(dword_FFA900).w
                bmi.s Stage_Stage10CheckTransition_Return
                bra.w Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
; Early return from stage 10 transition check
Stage_Stage10CheckTransition_Return:                            ; CODE XREF: Stage_Stage10CheckTransition+E   j  ; was: locret_D9F0
                                        ; Stage_DeepStriderTransition+10   j ...
                rts
; End of function Stage_Stage10CheckTransition
; Transitions to Deep Strider boss
Stage_DeepStriderTransition:                               ; DATA XREF: ROM:0000D960   o  ; was: sub_D9F2
                bsr.w Gfx_LoadBossTiles
                bsr.w Scroll_AddDeltaToScroll
                move.w  #$7B0,d0
                cmp.w   (dword_FFA900).w,d0
                bpl.s Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (stru_11440).l,a1
                bra.w Gfx_UpdateBossPalette
; End of function Stage_DeepStriderTransition
; Deep Strider battle stage handler
Stage_DeepStriderBattle:                               ; DATA XREF: ROM:0000D962   o  ; was: sub_DA22
                tst.w   (word_FFC620).w
                bne.s Camera_UpdateDeepStrider
                bsr.w Stage_TriggerPhaseTransition
; Updates camera for Deep Strider boss battle with phase transition check
Camera_UpdateDeepStrider:                               ; CODE XREF: Stage_DeepStriderBattle+4   j  ; was: loc_DA2C
                bsr.w Camera_UpdateTowardsPlayer
                bra.w Scroll_AddDeltaToScroll
; End of function Stage_DeepStriderBattle
; Initializes Deep Strider battle
Stage_DeepStriderBattleInit:                               ; DATA XREF: ROM:0000D964   o  ; was: sub_DA34
                bsr.w Stage_InitSectionChange
                bsr.w Camera_UpdateTowardsPlayer
                bra.w Scroll_AddDeltaToScroll
; End of function Stage_DeepStriderBattleInit
; Transitions to Stage 11
Stage_Stage11Transition:                               ; DATA XREF: ROM:0000D966   o  ; was: sub_DA40
                bsr.w Stage_LoadStage10Graphics
; End of function Stage_Stage11Transition
; Updates Stage 11 scroll and check
Stage_Stage11ScrollUpdate:                               ; DATA XREF: ROM:0000D968   o  ; was: sub_DA44
                bsr.w Gfx_UpdateScroll
                bsr.w Scroll_AddDeltaToScroll
                cmpi.w  #$1040,(dword_FFA900).w
                bmi.s   locret_DA58
                bra.w Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_DA58:                            ; CODE XREF: Stage_Stage11ScrollUpdate+E   j
                rts
; End of function Stage_Stage11ScrollUpdate
; Transitions to Gusthead boss
Stage_GustheadTransition:                               ; DATA XREF: ROM:0000D96A   o  ; was: sub_DA5A
                bsr.w Gfx_LoadBossTiles
                bsr.w Scroll_AddDeltaToScroll
                move.w  #$10C0,d0
                cmp.w   (dword_FFA900).w,d0
                bpl.s   locret_DA92
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (stru_11454).l,a1
                bsr.w Gfx_UpdateBossPalette
                clr.l   (dword_FFA960).w
                clr.w   (word_FFA968).w
locret_DA92:                            ; CODE XREF: Stage_GustheadTransition+10   j
                rts
; End of function Stage_GustheadTransition
; Transitions after Gusthead defeat
Stage_GustheadDefeatTransition:                               ; DATA XREF: ROM:0000D96C   o  ; was: sub_DA94
                tst.w   (word_FFC620).w
                bne.s   loc_DAA0
                jsr (Stage_TriggerPhaseTransition).l
loc_DAA0:                               ; CODE XREF: Stage_GustheadDefeatTransition+4   j
                bra.w   loc_DAA8
; End of function Stage_GustheadDefeatTransition
; Initializes Stage 12
Stage_Stage12Init:                               ; DATA XREF: ROM:0000D96E   o  ; was: sub_DAA4
                bsr.w Stage_InitSectionChange
loc_DAA8:                               ; CODE XREF: Stage_GustheadDefeatTransition:loc_DAA0   j
                tst.w   (word_FFA968).w
                beq.s   loc_DAE2
                bsr.w Scroll_ApplyVelocity
                bsr.w Scroll_AddDeltaToScroll
                cmpi.w  #$14,(word_FFA204).w
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
locret_DAE0:                            ; CODE XREF: Stage_Stage12Init+18   j
                                        ; Stage_Stage12Init+1E   j
                rts
; ---------------------------------------------------------------------------
loc_DAE2:                               ; CODE XREF: Stage_Stage12Init+8   j
                bsr.w Camera_UpdateTowardsPlayer
                bra.w Scroll_AddDeltaToScroll
; End of function Stage_Stage12Init
; Applies velocity value to horizontal scroll position
Scroll_ApplyVelocity:                               ; CODE XREF: Stage_Stage12Init+A   p  ; was: sub_DAEA
                move.l  (dword_FFA960).w,d0
                add.l   d0,(dword_FFA900).w
                rts
; End of function Scroll_ApplyVelocity
; Updates Stage 12 scroll
Stage_Stage12ScrollUpdate:                               ; DATA XREF: ROM:0000D970   o  ; was: sub_DAF4
                move.b  #$40,(byte_FFA420).w ; '@'
                move.w  #$30,(word_FFF74A).w ; '0'
                clr.w   (word_FFF74E).w
; Updates stage 12 scrolling with delta at position $1580
Stage_Stage12_ScrollLoop:                               ; DATA XREF: ROM:0000D972   o  ; was: loc_DB04
                bsr.w Gfx_UpdateScroll
                bsr.w Scroll_AddDeltaToScroll
                cmpi.w  #$1580,(dword_FFA900).w
                bmi.w Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                move.w  #$80,(word_FF806E).w
                move.w  #$8000,(word_FF808A).w
                move.b  #1,(byte_FF830E).w
                rts
; End of function Stage_Stage12ScrollUpdate
; Initializes Stage 13
Stage_Stage13Init:                               ; DATA XREF: ROM:0000D974   o  ; was: sub_DB2E
                bsr.w Gfx_UpdateScroll
                bsr.w Scroll_AddDeltaToScroll
                bsr.w Stage_WaitForTimerDecrement
                cmpi.w  #$15E0,(dword_FFA900).w
                bmi.w Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                jsr (Stage_LoadStage13Graphics).l
                lea     stru_DB5A(pc),a0
                nop
                jmp (Data_ProcessPointer).l
; End of function Stage_Stage13Init
; ---------------------------------------------------------------------------
stru_DB5A:      dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_Stage13Init+20   o
                dc.l tiles_19E8A8       ; field_2
                dc.w 0                  ; field_6
                dc.w $FFFF


; Updates Stage 13 scroll
Stage_Stage13ScrollUpdate:                               ; DATA XREF: ROM:0000D976   o  ; was: sub_DB64
                bsr.w Gfx_UpdateScroll
                bsr.w Scroll_AddDeltaToScroll
                bsr.w Stage_WaitForTimerDecrement
                cmpi.w  #$1760,(dword_FFA900).w
                bmi.s   locret_DB7C
                addq.w  #2,(word_FFA950).w
locret_DB7C:                            ; CODE XREF: Stage_Stage13ScrollUpdate+12   j
                rts
; End of function Stage_Stage13ScrollUpdate
; Checks transition to next segment
Stage_Stage13CheckTransition:                               ; DATA XREF: ROM:0000D978   o  ; was: sub_DB7E
                bsr.w Gfx_LoadBossTiles
                bsr.w Scroll_AddDeltaToScroll
                move.w  #$17A0,d0
                cmp.w   (dword_FFA900).w,d0
                bpl.s   locret_DB9C
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  d0,(dword_FFA900).w
locret_DB9C:                            ; CODE XREF: Stage_Stage13CheckTransition+10   j
                rts
; End of function Stage_Stage13CheckTransition
; Empty handler for stage 13 transition
Stage_Stage13EmptyHandler:                             ; DATA XREF: ROM:0000D97A   o  ; was: nullsub_24
                rts
; End of function Stage_Stage13EmptyHandler
; Transitions to Sharpsteel boss
Stage_SharpssteelTransition:                               ; DATA XREF: ROM:0000D97C   o  ; was: sub_DBA0
                tst.w   (word_FF829E).w
                bne.w Stage_Stage10CheckTransition_Return
                move.w  #9,(word_FF808C).w
                bsr.w Stage_TransitionToNextPhase
                lea     (stru_11468).l,a1
                bra.w Gfx_UpdateBossPalette
; End of function Stage_SharpssteelTransition
; Initializes Stage 14
Stage_Stage14Init:                               ; DATA XREF: ROM:0000D97E   o  ; was: sub_DBBC
                tst.w   (word_FFC620).w
                bne.w Stage_Stage10CheckTransition_Return
                move.w  #$FFFF,(word_FFDB44).w
                bra.w Stage_TriggerPhaseTransition
; End of function Stage_Stage14Init
; Transitions to teleport after ship destruction
Stage_TeleportTransition:                               ; DATA XREF: ROM:0000D980   o  ; was: sub_DBCE
                tst.w   (word_FF80C2).w
                bne.w Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FF820C).w
                addq.w  #2,(word_FFA204).w
                clr.b   (byte_FFA209).w
                clr.w   (dword_FF806A+2).w
                move.b  #$CA,d0
                jmp (Sound_PlaySFX).l
; End of function Stage_TeleportTransition
; Fade in and setup for teleport scene
Stage_TeleportFadeIn:                               ; DATA XREF: ROM:0000D982   o  ; was: sub_DBF4
                tst.w   (word_FF80E6).w
                beq.s   loc_DBFC
                bpl.s   loc_DC5E
loc_DBFC:                               ; CODE XREF: Stage_TeleportFadeIn+4   j
                addq.w  #1,(dword_FF806A+2).w
                cmpi.w  #$3C,(dword_FF806A+2).w ; '<'
                bne.s   loc_DC5E
                addq.w  #2,(word_FFA950).w
                move.w  #$FCE0,(dword_FFA900).w
                clr.w   (dword_FFA904).w
                move.w  #$1C,(dword_FF806A+2).w
                move.l  #$C0000,(dword_FF8066+2).w
                clr.b   (byte_FFA95A).w
                moveq   #0,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                bset    #6,(byte_FFA959).w
                move.w  #$50,(word_FFA404).w ; 'P'
                clr.l   (dword_FF8240).w
                clr.l   (dword_FF830A).w
                move.w  #$4000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr (VDP_SetupDMA).l
                jsr (Stage_LoadTeleportGraphics).l
loc_DC5E:                               ; CODE XREF: Stage_TeleportFadeIn+6   j
                                        ; Stage_TeleportFadeIn+12   j
                move.w  (dword_FF806A+2).w,d0
                cmpi.w  #$1C,d0
                bmi.s   loc_DC6A
                moveq   #$1C,d0
loc_DC6A:                               ; CODE XREF: Stage_TeleportFadeIn+72   j
                jmp (Gfx_SetFadeParams).l
; End of function Stage_TeleportFadeIn
; Handles teleport fade sequence with scroll
Stage_TeleportFadeSequence:                               ; DATA XREF: ROM:0000D984   o  ; was: sub_DC70
                move.w  (dword_FF806A+2).w,d0
                jsr (Gfx_SetFadeParams).l
                addq.w  #6,(dword_FFA900).w
                subq.w  #1,(dword_FF806A+2).w
                bpl.s   loc_DCA8
                addq.w  #2,(word_FFA950).w
; Advances scroll during teleport fade sequence
Stage_TeleportFadeSequence_Advance:                               ; DATA XREF: ROM:0000D986   o  ; was: loc_DC88
                addq.w  #6,(dword_FFA900).w
                bmi.s   loc_DCA8
                addq.w  #2,(word_FFA950).w
                move.w  #$60,(dword_FF806A+2).w ; '`'
                clr.w   (dword_FFA900).w
                bclr    #6,(byte_FFA959).w
                move.w  #1,(word_FFA448).w
loc_DCA8:                               ; CODE XREF: Stage_TeleportFadeSequence+12   j
                                        ; Stage_TeleportFadeSequence+1C   j
                bsr.w Stage_TeleportUpdateScroll
                move.w  (dword_FFA900).w,d0
                addi.w  #$158,d0
                bpl.s   loc_DCB8
                rts
; ---------------------------------------------------------------------------
loc_DCB8:                               ; CODE XREF: Stage_TeleportFadeSequence+44   j
                moveq   #0,d1
                jmp Gfx_RenderTilemap
; End of function Stage_TeleportFadeSequence
; Transitions to Snake boss stage
Stage_SnakeTransition:                               ; DATA XREF: ROM:0000D988   o  ; was: sub_DCC0
                subi.l  #$4000,(dword_FF8066+2).w
                bpl.s   loc_DCCE
                clr.l   (dword_FF8066+2).w
loc_DCCE:                               ; CODE XREF: Stage_SnakeTransition+8   j
                bsr.w Stage_TeleportUpdateScroll
                subq.w  #1,(dword_FF806A+2).w
                bpl.w Stage_Stage10CheckTransition_Return
                move.w  #$50,(word_FF80C2).w ; 'P'
                move.b  #$89,d0
                jsr (Input_CheckButtonMode).l
                bra.w Stage_InitStage13
; End of function Stage_SnakeTransition
; Updates scroll position during teleport
Stage_TeleportUpdateScroll:                               ; CODE XREF: Stage_TeleportFadeSequence:loc_DCA8   p  ; was: sub_DCEE
                                        ; sub_DCC0:loc_DCCE   p
                bsr.w Scroll_UpdateSnakeBackground
                move.l  (dword_FF8066+2).w,d0
                add.l   d0,(dword_FFA908).w
                rts
; End of function Stage_TeleportUpdateScroll
; Waits for timer to decrement before continuing
Stage_WaitForTimerDecrement:                               ; CODE XREF: Stage_Stage13Init+8   p  ; was: sub_DCFC
                                        ; Stage_Stage13ScrollUpdate+8   p
                tst.w   (word_FF806E).w
                bmi.w Stage_Stage10CheckTransition_Return
                subq.w  #1,(word_FF806E).w
                bne.w Stage_Stage10CheckTransition_Return
                rts
; End of function Stage_WaitForTimerDecrement
; Initializes Stage 13 (Snake boss)
Stage_InitStage13:                               ; CODE XREF: Stage_SnakeTransition+2A   j  ; was: sub_DD0E
                                        ; DATA XREF: ROM:0000D990   o
                move.w  #$36,(word_FFA950).w ; '6'
                move.w  #$298,(word_FFC620).w
                clr.w   (word_FFC624).w
                move.w  #$30,(word_FFF74A).w ; '0'
                clr.w   (word_FFF74E).w
                jsr (Stage_LoadStage13Graphics).l
; End of function Stage_InitStage13
; Waits for scroll position before boss
Stage_SnakeWaitScroll:                               ; DATA XREF: ROM:0000D992   o  ; was: sub_DD2E
                bsr.w Scroll_UpdateSnakeBackground
                bsr.w Gfx_LoadBossTiles
                cmpi.w  #$3E0,(dword_FFA900).w
                bmi.w Stage_Stage10CheckTransition_Return
                move.w  (word_FF8200).w,(dword_FF8040).w
                move.w  (word_FF8202).w,(dword_FF8040+2).w
                bsr.w Stage_TransitionToNextPhase
                move.w  (dword_FF8040).w,(word_FF8200).w
                move.w  (dword_FF8040+2).w,(word_FF8202).w
                rts
; End of function Stage_SnakeWaitScroll
; Transitions to Bugmax boss
Stage_BugmaxTransition:                               ; DATA XREF: ROM:0000D994   o  ; was: sub_DD5E
                bsr.w Scroll_UpdateSnakeBackground
                bsr.w Gfx_LoadBossTiles
                move.w  #$460,d0
                cmp.w   (dword_FFA900).w,d0
                bpl.w Stage_Stage10CheckTransition_Return
                move.w  #$100,(word_FF806E).w
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.w  #$1F,(word_FFA944).w
                clr.w   (word_FFA946).w
                move.w  #$6000,(dword_FFA940).w
                rts
; End of function Stage_BugmaxTransition
; Waits for DMA before boss intro
Stage_BugmaxWaitDMA:                               ; DATA XREF: ROM:0000D996   o  ; was: sub_DDA6
                bsr.w Scroll_UpdateSnakeBackground
                jsr (Sprite_SetupDMA).l
                bpl.w Stage_Stage10CheckTransition_Return
                subq.w  #1,(word_FF806E).w
                bmi.s Stage_InitBugmaxBattle
                tst.w   (word_FFC620).w
                bne.w Stage_Stage10CheckTransition_Return
; Initializes Bugmax boss battle with palette and DMA setup
Stage_InitBugmaxBattle:                               ; CODE XREF: Stage_BugmaxWaitDMA+12   j  ; was: loc_DDC2
                addq.w  #2,(word_FFA950).w
                move.w  #$7000,(word_FF8200).w
                move.w  #$7000,(word_FF8202).w
                move.w  #$1E0,(word_FF8234).w
                move.w  #$1E0,(word_FF8236).w
                lea     (stru_1147C).l,a1
                bra.w Gfx_UpdateBossPalette
; End of function Stage_BugmaxWaitDMA
; Starts Bugmax battle phase
Stage_BugmaxStartBattle:                               ; DATA XREF: ROM:0000D998   o  ; was: sub_DDE8
                bsr.w Scroll_UpdateSnakeBackground
                tst.w   (word_FFC620).w
                bne.s   loc_DDFC
                addq.w  #2,(word_FFA950).w
                move.w  #$22,(word_FFA02A).w ; '"'
loc_DDFC:                               ; CODE XREF: Stage_BugmaxStartBattle+8   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_BugmaxStartBattle
; Checks conditions and initiates Bugmax boss transition
Stage_BugmaxTransitionCheck:                               ; DATA XREF: ROM:0000D99A   o  ; was: sub_DE00
                bsr.w Scroll_UpdateSnakeBackground
                bsr.w Camera_UpdateTowardsPlayer
                tst.w   (word_FF8230).w
                bne.w Stage_Stage10CheckTransition_Return
                tst.w   (word_FF8138).w
                bne.w Stage_Stage10CheckTransition_Return
                move.b  #$92,d0
                jsr (Input_CheckButtonMode).l
                move.l  #byte_1E587,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; End of function Stage_BugmaxTransitionCheck
; Loads Stage 10 tile graphics and palette
Stage_LoadStage10Graphics:                               ; CODE XREF: Stage_Stage10ScrollUpdate+6   p  ; was: sub_DE2E
                                        ; sub_DA40   p
                move.w  #$30,(word_FFF74A).w ; '0'
                clr.w   (word_FFF74E).w
                jsr (Enemy_InitStage10Debris).l
                addq.w  #2,(word_FFA950).w
                rts
; End of function Stage_LoadStage10Graphics
; Stage 14 scroll handler
Stage_Stage14Scroll:                               ; DATA XREF: ROM:0000D99C   o  ; was: sub_DE44
                addq.w  #2,(word_FFA950).w
                move.w  #$50,(word_FF80C2).w ; 'P'
; Updates scroll for stage 14 progression
Stage_Stage14Scroll_Update:                               ; DATA XREF: ROM:0000D99E   o  ; was: loc_DE4E
                bsr.w Gfx_UpdateScroll
                cmpi.w  #$400,(dword_FFA900).w
                bmi.w Stage_Stage10CheckTransition_Return
                bra.w Stage_TransitionToNextPhase
; End of function Stage_Stage14Scroll
; Initialize boss tiles and palette with scroll check
Stage_InitBossPaletteScroll:                               ; DATA XREF: ROM:0000D9A0   o  ; was: sub_DE60
                bsr.w Gfx_LoadBossTiles
                move.w  #$480,d0
                cmp.w   (dword_FFA900).w,d0
                bpl.w Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (stru_11498).l,a1
                bra.w Gfx_UpdateBossPalette
; End of function Stage_InitBossPaletteScroll
; Initialize score timer and clear scroll variables
Stage_InitScoreTimerClear:                               ; DATA XREF: ROM:0000D9A2   o  ; was: sub_DE8E
                tst.w   (word_FFC620).w
                bne.s   locret_DEA0
                bsr.w UI_InitScoreTimer
                clr.w   (dword_FFA908).w
                clr.w   (dword_FFA90C).w
locret_DEA0:                            ; CODE XREF: Stage_InitScoreTimerClear+4   j
                rts
; End of function Stage_InitScoreTimerClear
; Transitions to Stage 15
Stage_Stage15Transition:                               ; DATA XREF: ROM:0000D9A4   o  ; was: sub_DEA2
                bsr.w Stage_InitSectionChange
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_Stage15Transition
; Stage 15 scroll handler
Stage_Stage15Scroll:                               ; DATA XREF: ROM:0000D9A6   o  ; was: sub_DEAA
                bsr.w Gfx_UpdateScroll
                cmpi.w  #$660,(dword_FFA900).w
                bmi.w Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                move.w  #$660,(dword_FFA900).w
                bset    #6,(byte_FF8245).w
                rts
; End of function Stage_Stage15Scroll
; Check scroll threshold and transition to next phase
Stage_ScrollCheckTransition:                               ; DATA XREF: ROM:0000D9A8   o  ; was: sub_DECA
                bsr.w Scroll_RenderSylpheedWithUpdate
                cmpi.w  #$E3E8,(dword_FFA904).w
                bmi.w Stage_Stage10CheckTransition_Return
                bclr    #0,(byte_FF80F8).w
                move.w  #$FFE4,(dword_FF8066+2).w
                move.w  #6,(word_FF8222).w
                bra.w Stage_TransitionToNextPhase
; End of function Stage_ScrollCheckTransition
; Transitions to Sunset Sting boss
Stage_SunsetStingTransition:                               ; DATA XREF: ROM:0000D9AA   o  ; was: sub_DEEE
                bsr.w Scroll_UpdateVerticalScroll
                move.w  #$E420,d0
                cmp.w   (dword_FFA904).w,d0
                bpl.w Stage_Stage10CheckTransition_Return
                addq.w  #2,(word_FFA950).w
                move.w  d0,(dword_FFA904).w
                move.w  #$660,(word_FFA970).w
                move.w  #$660,(word_FFA974).w
                moveq   #0,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                lea     (stru_114B4).l,a1
                bra.w Gfx_UpdateBossPalette
; End of function Stage_SunsetStingTransition
; Waits for battle to start
Stage_SunsetStingWaitBattle:                               ; DATA XREF: ROM:0000D9AC   o  ; was: sub_DF26
                tst.w   (word_FFC620).w
                bne.s   loc_DF30
                bsr.w Stage_TriggerPhaseTransition
loc_DF30:                               ; CODE XREF: Stage_SunsetStingWaitBattle+4   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_SunsetStingWaitBattle
; Transition after Sunset Sting
Stage_PostSunsetStingTransition:                               ; DATA XREF: ROM:0000D9AE   o  ; was: sub_DF34
                bsr.w Stage_InitSectionChange
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_PostSunsetStingTransition
; Viblack stage scroll handler
Stage_ViblackScroll:                               ; DATA XREF: ROM:0000D9B0   o  ; was: sub_DF3C
                cmpi.w  #$E440,(dword_FFA904).w
                bpl.s Stage_ViblackStartBattle
                move.l  (dword_FFA900).w,(dword_FF806A+2).w
                move.w  #$660,(dword_FFA900).w
                bsr.w Scroll_UpdateVerticalScroll
                move.l  (dword_FF806A+2).w,(dword_FFA900).w
                bra.w Camera_ConstrainToScreenBounds
; End of function Stage_ViblackScroll
; Starts Viblack battle
Stage_ViblackStartBattle:                               ; CODE XREF: Stage_ViblackScroll+6   j  ; was: sub_DF5E
                addq.w  #2,(word_FFA950).w
                move.b  #$8B,d0
                jsr (Input_CheckButtonMode).l
; End of function Stage_ViblackStartBattle
; Initializes Viblack mini-boss
Stage_ViblackInit:                               ; DATA XREF: ROM:0000D9B2   o  ; was: sub_DF6C
                addq.w  #2,(word_FFA950).w
                move.w  #$2B8,(word_FFC620).w
                clr.w   (word_FFC624).w
                clr.l   (dword_FF8062+2).w
                clr.w   (dword_FF806A).w
                move.b  #$80,(byte_FFA959).w
                move.w  #$2E,(word_FFA02A).w ; '.'
; End of function Stage_ViblackInit
; Attributes: thunk
; Constrain camera to screen bounds wrapper
Stage_ConstrainCameraBounds:                               ; DATA XREF: ROM:0000D9B4   o  ; was: sub_DF8E
                bra.w Camera_ConstrainToScreenBounds
; End of function Stage_ConstrainCameraBounds
; Transitions to Stage 17
Stage_Stage17Transition:                               ; DATA XREF: ROM:0000D9B6   o  ; was: sub_DF92
                cmpi.w  #5,(dword_FF8062+2).w
                bpl.s Stage_AccelerateVerticalScroll
                addi.l  #$C00,(dword_FF8062+2).w
; Accelerates vertical scroll velocity for stage 17 transition
Stage_AccelerateVerticalScroll:                               ; CODE XREF: Stage_Stage17Transition+6   j  ; was: loc_DFA2
                move.l  (dword_FF8062+2).w,d0
                add.l   d0,(dword_FFA904).w
                move.l  (dword_FFA900).w,(dword_FF806A+2).w
                move.w  #$660,(dword_FFA900).w
                bsr.w Gfx_RenderSylpheedBackground
                move.l  (dword_FF806A+2).w,(dword_FFA900).w
                bsr.w Camera_ConstrainToScreenBounds
                cmpi.w  #$E620,(dword_FFA904).w
                bmi.s   locret_DFD0
                addq.w  #2,(word_FFA950).w
locret_DFD0:                            ; CODE XREF: Stage_Stage17Transition+38   j
                rts
; End of function Stage_Stage17Transition
; Post-Viblack scroll handler
Stage_ViblackPostBattleScroll1:                               ; DATA XREF: ROM:0000D9B8   o  ; was: sub_DFD2
                move.l  (dword_FF8062+2).w,d0
                add.l   d0,(dword_FFA904).w
                bra.w Camera_ConstrainToScreenBounds
; End of function Stage_ViblackPostBattleScroll1
; Scroll with screen transition and palette fade
Stage_ViblackPostBattleScroll2:                               ; DATA XREF: ROM:0000D9BA   o  ; was: sub_DFDE
                bset    #1,(byte_FF80F8).w
                move.l  (dword_FF8062+2).w,d0
                add.l   d0,(dword_FFA904).w
                move.w  #5,(word_FF8218).w
                subq.w  #1,(dword_FF806A).w
                cmpi.w  #$FFF2,(dword_FF806A).w
                bpl.s   loc_E028
                move.w  #$FFF2,(dword_FF806A).w
                cmpi.w  #$660,(dword_FFA900).w
                bne.s   loc_E028
                addq.w  #2,(word_FFA950).w
                move.w  #$660,(word_FFA970).w
                move.w  #$660,(word_FFA974).w
                lea     (byte_C4A4).l,a0
                jsr     (LoadPalette).l
loc_E028:                               ; CODE XREF: Stage_ViblackPostBattleScroll2+1E   j
                                        ; Stage_ViblackPostBattleScroll2+2C   j
                move.w  (dword_FF806A).w,d0
                movea.w #(byte_FFE322-M68K_RAM),a0
                moveq   #$E,d5
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                clr.w   (dword_FFA900+2).w
                cmpi.w  #$660,(dword_FFA900).w
                beq.s   locret_E054
                bpl.s   loc_E050
                addq.w  #1,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_E050:                               ; CODE XREF: Stage_ViblackPostBattleScroll2+6A   j
                subq.w  #1,(dword_FFA900).w
locret_E054:                            ; CODE XREF: Stage_ViblackPostBattleScroll2+68   j
                rts
; End of function Stage_ViblackPostBattleScroll2
; Stage transition after Viblack
Stage_PostViblackTransition:                               ; DATA XREF: ROM:0000D9BC   o  ; was: sub_E056
                addq.w  #2,(word_FFA950).w
                move.w  #$FF80,d0
                move.w  d0,(dword_FFA904).w
                move.w  d0,(word_FFA92C).w
                clr.w   (word_FFA914).w
                move.l  #dword_11326,(dword_FFA940).w
                move.w  #$1000,(word_FFA946).w
                move.w  #0,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
; Renders scrolling background after Viblack transition
Stage_PostViblackTransition_Render:                               ; DATA XREF: ROM:0000D9BE   o  ; was: loc_E084
                jsr (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.s   locret_E098
                addq.w  #2,(word_FFA950).w
                clr.w   (dword_FF806A).w
locret_E098:                            ; CODE XREF: Stage_PostViblackTransition+38   j
                rts
; End of function Stage_PostViblackTransition
; Set vertical scroll offset to fixed value
Stage_SetVerticalScrollOfs:                               ; DATA XREF: ROM:0000D9C0   o  ; was: sub_E09A
                move.w  #$14,(dword_FF8066+2).w
                rts
; End of function Stage_SetVerticalScrollOfs
; Palette fade transition
Stage_PostViblackFade:                               ; DATA XREF: ROM:0000D9C2   o  ; was: sub_E0A2
                subq.w  #1,(dword_FF8066+2).w
                bmi.s   loc_E0AA
                rts
; ---------------------------------------------------------------------------
loc_E0AA:                               ; CODE XREF: Stage_PostViblackFade+4   j
                bsr.w Stage_PostViblackScrollDecel
                movea.w #(byte_FFE322-M68K_RAM),a0
                movea.w #(dword_FFE3A0+2-M68K_RAM),a1
                move.w  (dword_FF806A).w,d0
                asr.w   #1,d0
                andi.w  #$1E,d0
                cmpi.w  #$1E,d0
                beq.s   loc_E0D0
                addq.w  #2,(dword_FF806A).w
                move.w  #$4000,(a0,d0.w)
loc_E0D0:                               ; CODE XREF: Stage_PostViblackFade+22   j
                moveq   #0,d5
                moveq   #0,d6
                moveq   #$B,d7
loc_E0D6:                               ; CODE XREF: Stage_PostViblackFade+58   j
                move.w  (a0,d5.w),d0
                beq.s   loc_E0F8
                cmp.w   (a1,d5.w),d0
                beq.s   loc_E0F6
                subi.w  #$300,d0
                bpl.s   loc_E0F0
                move.w  (a1,d5.w),(a0,d5.w)
                bra.s   loc_E0F8
; ---------------------------------------------------------------------------
loc_E0F0:                               ; CODE XREF: Stage_PostViblackFade+44   j
                move.w  d0,(a0,d5.w)
                bra.s   loc_E0F8
; ---------------------------------------------------------------------------
loc_E0F6:                               ; CODE XREF: Stage_PostViblackFade+3E   j
                addq.w  #1,d6
loc_E0F8:                               ; CODE XREF: Stage_PostViblackFade+38   j
                                        ; Stage_PostViblackFade+4C   j ...
                addq.w  #2,d5
                dbf     d7,loc_E0D6
                cmpi.w  #$C,d6
                bmi.s   locret_E10E
                addq.w  #2,(word_FFA950).w
                move.b  #$18,(byte_FFA420).w
locret_E10E:                            ; CODE XREF: Stage_PostViblackFade+60   j
                rts
; End of function Stage_PostViblackFade
; Scroll speed deceleration
Stage_PostViblackScrollDecel:                               ; CODE XREF: Stage_PostViblackFade:loc_E0AA   p  ; was: sub_E110
                                        ; DATA XREF: ROM:0000D9C4   o
                tst.w   (dword_FFA904).w
                beq.s   locret_E11A
                addq.w  #8,(dword_FFA904).w
locret_E11A:                            ; CODE XREF: Stage_PostViblackScrollDecel+4   j
                rts
; End of function Stage_PostViblackScrollDecel
; Stage initialization and transition
Stage_Epsilon1Init:                               ; DATA XREF: ROM:0000D9C6   o  ; was: sub_E11C
                tst.w   (word_FF8230).w
                bne.s   locret_E14C
                move.l  #byte_1E4E5,(dword_FFA22C).w
                jsr (Stage_InitTransitionState).l
                move.w  #$8002,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                move.b  #$8B,(byte_FFA230).w
locret_E14C:                            ; CODE XREF: Stage_Epsilon1Init+4   j
                rts
; End of function Stage_Epsilon1Init
; Update wave distortion effect based on counter
Effect_UpdateWaveDistortion:
                btst    #0,(word_FFF706).w  ; was: sub_E14E
                beq.s   loc_E15A
                addq.w  #2,(word_FF806E).w
loc_E15A:                               ; CODE XREF: Effect_UpdateWaveDistortion+6   j
                btst    #1,(word_FFF706).w
                beq.s   loc_E166
                subq.w  #2,(word_FF806E).w
loc_E166:                               ; CODE XREF: Effect_UpdateWaveDistortion+12   j
                move.w  (word_FF806E).w,d0
                move.w  d0,d1
                asr.w   #2,d0
                andi.w  #$1E,d0
                beq.s   locret_E182
                addi.w  #-$1CE0,d0
                movea.w d0,a0
                andi.w  #6,d1
                move.w  word_E184(pc,d1.w),(a0)
locret_E182:                            ; CODE XREF: Effect_UpdateWaveDistortion+24   j
                rts
; End of function Effect_UpdateWaveDistortion
; ---------------------------------------------------------------------------
word_E184:      dc.w $200, $400, $622, $844, $5478, $A950


; Handle parallax scroll transition with countdown
Stage_ParallaxScrollTransit:
                move.w  #$2E,(word_FFA02A).w ; '.'  ; was: sub_E190
                move.w  #$20,(dword_FF8128).w ; ' '
                move.w  #$308,(word_FFC680).w
                clr.w   (word_FFC684).w
                bsr.w Stage_Epsilon1UpdateScrollParallax
                tst.w   (word_FFC680).w
                bne.s   locret_E1BE
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FFA02A).w
                bclr    #0,(byte_FFA958).w
locret_E1BE:                            ; CODE XREF: Stage_ParallaxScrollTransit+1E   j
                rts
; End of function Stage_ParallaxScrollTransit
; Stage scroll handler
Stage_Epsilon1Scroll:                               ; DATA XREF: ROM:0000D9C8   o  ; was: sub_E1C0
                                        ; ROM:0000D9CA   o
                move.w  #$18,(dword_FF8128).w
                bsr.w Stage_Epsilon1UpdateScrollParallax
                tst.w   (word_FFC620).w
                bne.s   locret_E1D4
                bra.w Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_E1D4:                            ; CODE XREF: Stage_Epsilon1Scroll+E   j
                rts
; End of function Stage_Epsilon1Scroll
; Battle start with palette update
Stage_Epsilon1BattleStart:                               ; DATA XREF: ROM:0000D9CC   o  ; was: sub_E1D6
                bsr.w Stage_Epsilon1UpdateScrollParallax
                addq.w  #2,(word_FFA950).w
                lea     (stru_11500).l,a1
                bra.w Gfx_UpdateBossPalette
; End of function Stage_Epsilon1BattleStart
; Waits for boss intro completion
Stage_Epsilon1WaitIntroComplete:                               ; DATA XREF: ROM:0000D9CE   o  ; was: sub_E1E8
                tst.w   (word_FFC620).w
                bne.s Stage_Epsilon1UpdateScrollParallax
                addq.w  #2,(word_FFA950).w
; End of function Stage_Epsilon1WaitIntroComplete
; Updates scroll position and parallax
Stage_Epsilon1UpdateScrollParallax:                               ; CODE XREF: Stage_ParallaxScrollTransit+16   p  ; was: sub_E1F2
                                        ; Stage_Epsilon1Scroll+6   p ...
                btst    #0,(byte_FFA958).w
                beq.s   loc_E1FC
                rts
; ---------------------------------------------------------------------------
loc_E1FC:                               ; CODE XREF: Stage_Epsilon1UpdateScrollParallax+6   j
                move.w  (dword_FF8128).w,d0
                subi.w  #$28,d0 ; '('
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
Cutscene_PlanetInit:                               ; DATA XREF: ROM:0000D9D0   o  ; was: sub_E256
                tst.w   (word_FF8230).w
                bne.w Stage_Epsilon1UpdateScrollParallax
                move.w  #$8002,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                bset    #2,(byte_FF80F8).w
                move.w  #4,(word_FFA29C).w
                move.w  #4,(word_FF8230).w
                rts
; End of function Cutscene_PlanetInit
; Spawns 4 projectiles in a pattern with velocity data
Projectile_SpawnQuadPattern:                               ; CODE XREF: Boss_DeepStriderSpawnProjectiles+8   j  ; was: sub_E288
                                        ; Boss_SharpssteelMultiPhaseAttack+C6   p
                moveq   #8,d3
loc_E28A:                               ; CODE XREF: Boss_SharpssteelRisingAttack+32   p
                moveq   #0,d4
                moveq   #3,d7
                lea     dword_E2D6(pc),a4
                nop
; Initializes projectile properties in a loop with animation and position
Projectile_InitializeLoop:                               ; CODE XREF: Projectile_SpawnQuadPattern+48   j  ; was: loc_E294
                jsr (Projectile_FindFreeSlotAndClear).l
                bne.s   locret_E2D4
                jsr (Projectile_InitType2A).l
                move.l  #off_1A0E96,8(a0)
                move.w  (word_FF808A).w,d0
                addi.w  #$4000,d0
                move.w  d0,$E(a0)
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                move.b  d3,$20(a0)
                move.l  (a4,d4.w),$18(a0)
                move.l  $10(a4,d4.w),$1C(a0)
                addq.w  #4,d4
                dbf d7,Projectile_InitializeLoop
locret_E2D4:                            ; CODE XREF: Projectile_SpawnQuadPattern+12   j
                rts
; End of function Projectile_SpawnQuadPattern
; ---------------------------------------------------------------------------
dword_E2D6:     dc.l $FFFDC000, $FFFF4000
                                        ; DATA XREF: Projectile_SpawnQuadPattern+6   o
                dc.l $C000, $24000
                dc.l $FFFD8000, $FFFC8000
                dc.l $FFFC8000, $FFFD8000


; Spawns projectile at calculated angle
Enemy_SpawnProjectileAtAngle:                               ; CODE XREF: Boss_JetsripperSpawnRandomAngleProjectile+26   p  ; was: sub_E2F6
                                        ; Enemy_GustheadSmallEyeWait+34   j ...
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_E34A
                jsr (Projectile_InitType2A).l
                clr.b   $21(a0)
                move.l  #off_1A0E96,8(a0)
                move.w  (word_FF808A).w,d0
                addi.w  #$4000,d0
                move.w  d0,$E(a0)
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                move.b  #8,$20(a0)
                lea     (word_1B514).l,a4
                move.w  word_1B494-word_1B514(a4,d4.w),d0
                move.w  (a4,d4.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                moveq   #0,d0
locret_E34A:                            ; CODE XREF: Enemy_SpawnProjectileAtAngle+6   j
                rts
; End of function Enemy_SpawnProjectileAtAngle
nullsub_25:
                rts
; End of function nullsub_25


; Updates background scroll for Snake stage
Scroll_UpdateSnakeBackground:                               ; CODE XREF: Stage_TeleportUpdateScroll   p  ; was: sub_E34E
                                        ; sub_DD2E   p ...
                movea.w #(byte_FFA3E0-M68K_RAM),a0
                lea     dword_E3CC(pc),a1
                nop
                lea     word_E3EC(pc),a2
                nop
                movea.w (word_FFF70E).w,a4
                moveq   #3,d7
loc_E364:                               ; CODE XREF: Scroll_UpdateSnakeBackground+56   j
                bsr.w Scroll_AccumulateOffset
loc_E368:                               ; CODE XREF: Scroll_UpdateSnakeBackground+26   j
                andi.w  #7,d0
                move.b  (a2,d0.w),(a4)
                addq.w  #1,d0
                addq.w  #4,a4
                dbf     d6,loc_E368
                adda.l  #8,a2
                suba.w  #$20,a4 ; ' '
                bsr.w Scroll_AccumulateOffset
loc_E386:                               ; CODE XREF: Scroll_UpdateSnakeBackground+48   j
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
                jsr (VDP_QueueCommand).l
                addi.w  #$20,(word_FFF70E).w ; ' '
                rts
; End of function Scroll_UpdateSnakeBackground
; Accumulates scroll offset from acceleration table for snake background
Scroll_AccumulateOffset:                               ; CODE XREF: Scroll_UpdateSnakeBackground:loc_E364   p  ; was: sub_E3C0
                                        ; Scroll_UpdateSnakeBackground+34   p
                move.l  (a0),d0
                add.l   (a1)+,d0
                move.l  d0,(a0)+
                swap    d0
                moveq   #7,d6
                rts
; End of function Scroll_AccumulateOffset
; ---------------------------------------------------------------------------
dword_E3CC:     dc.l $FFFF8000          ; DATA XREF: Scroll_UpdateSnakeBackground+4   o
                dc.l $FFFF4000
                dc.l $FFFF0000
                dc.l $FFFF6000
                dc.l $FFFEE000
                dc.l $FFFFA000
                dc.l $FFFF0000
                dc.l $FFFFC000
word_E3EC:      dc.w $C0D0, $D0D0, $E0E0, $E0E0, $C0D, $E0E, $D0D, $E0E
                                        ; DATA XREF: Scroll_UpdateSnakeBackground+A   o
                dc.w $C0D0, $D0E0, $C0E0, $E0E0, $C0D, $E0E, $E0E, $E0E
                dc.w $D0E0, $E0D0, $D0E0, $E0E0, $E0E, $C0D, $D0E, $C0E
                dc.w $E0E0, $E0E0, $E0E0, $E0E0, $D0D, $D0D, $C0E, $E0E


; Stage 18 scroll handler
Stage_Stage18Scroll:                               ; DATA XREF: ROM:0000FF3E   o  ; was: sub_E42C
                movea.w off_E438(pc,d0.w),a0
                adda.l  #Stage_Stage18EmptyHandler,a0
                jmp     (a0)
; End of function Stage_Stage18Scroll
; ---------------------------------------------------------------------------
off_E438:       dc.w Stage_Stage18StartBattle-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18PreBoss-Stage_Stage18EmptyHandler
                dc.w Stage_DestroyerMK2Init-Stage_Stage18EmptyHandler
                dc.w Boss_DestroyerMK2UpdateHealth-Stage_Stage18EmptyHandler
                dc.w Stage_Stage19Init-Stage_Stage18EmptyHandler
                dc.w Stage_Stage19Scroll-Stage_Stage18EmptyHandler
                dc.w Stage_Stage19Transition-Stage_Stage18EmptyHandler
                dc.w Stage_JampanInit-Stage_Stage18EmptyHandler
                dc.w Stage_JampanBattleStart-Stage_Stage18EmptyHandler
                dc.w Stage_JampanPostBattle-Stage_Stage18EmptyHandler
                dc.w Stage_JampanDefeatCamera-Stage_Stage18EmptyHandler
                dc.w Stage_JampanPostDefeatInit-Stage_Stage18EmptyHandler
                dc.w Stage_JampanPostDefeatCheck-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_InitBossPhase1-Stage_Stage18EmptyHandler
                dc.w Stage_WaitFlagUpdateCamera1-Stage_Stage18EmptyHandler
                dc.w Stage_CheckEnemiesTransit1-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_InitBossPhase2-Stage_Stage18EmptyHandler
                dc.w Stage_WaitFlagUpdateCamera2-Stage_Stage18EmptyHandler
                dc.w Stage_CheckEnemiesTransit2-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_InitBossPhase3-Stage_Stage18EmptyHandler
                dc.w Stage_WaitFlagUpdateCamera3-Stage_Stage18EmptyHandler
                dc.w Stage_CheckEnemiesTransit3-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_InitBossPhase4-Stage_Stage18EmptyHandler
                dc.w Stage_WaitFlagUpdateCamera4-Stage_Stage18EmptyHandler
                dc.w Stage_CheckEnemiesTransit4-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage18EmptyHandler-Stage_Stage18EmptyHandler
                dc.w Stage_Stage20Init-Stage_Stage18EmptyHandler
                dc.w Stage_Stage20Scroll-Stage_Stage18EmptyHandler
                dc.w Stage_MedusaTransition-Stage_Stage18EmptyHandler
                dc.w Stage_SylpheedTransition-Stage_Stage18EmptyHandler
                dc.w Stage_SylpheedCamera-Stage_Stage18EmptyHandler
                dc.w Stage_SylpheedCameraUpdate-Stage_Stage18EmptyHandler
                dc.w Stage_SylpheedGraphicsInit-Stage_Stage18EmptyHandler
                dc.w Stage_SylpheedGraphicsUpdate-Stage_Stage18EmptyHandler
                dc.w Stage_ArtemisTransition-Stage_Stage18EmptyHandler
                dc.w Stage_ArtemisCamera-Stage_Stage18EmptyHandler
                dc.w Stage_ArtemisGraphicsUpdate-Stage_Stage18EmptyHandler
                dc.w Gfx_ArtemisBackground-Stage_Stage18EmptyHandler
                dc.w Gfx_ArtemisForeground-Stage_Stage18EmptyHandler
                dc.w Stage_SireneIntroSequence-Stage_Stage18EmptyHandler
                dc.w Stage_SireneUpdate1-Stage_Stage18EmptyHandler
                dc.w Stage_SireneUpdate2-Stage_Stage18EmptyHandler
                dc.w Boss_SireneSpawnProjectile1-Stage_Stage18EmptyHandler
                dc.w Boss_SireneSpawnProjectile2-Stage_Stage18EmptyHandler
                dc.w Cutscene_SevenForcesWinInit-Stage_Stage18EmptyHandler
                dc.w Cutscene_SevenForcesState1-Stage_Stage18EmptyHandler
                dc.w Cutscene_SevenForcesState2-Stage_Stage18EmptyHandler
                dc.w Cutscene_SevenForcesState3-Stage_Stage18EmptyHandler
                dc.w Cutscene_SevenForcesState4-Stage_Stage18EmptyHandler
                dc.w Cutscene_SevenForcesState5-Stage_Stage18EmptyHandler
                dc.w Cutscene_SevenForcesState6-Stage_Stage18EmptyHandler
                dc.w Cutscene_SevenForcesEmptyState-Stage_Stage18EmptyHandler


; Empty handler called from stage 18 battle start
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
                tst.w   (word_FFC620).w
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
Stage_Stage20Init:                               ; DATA XREF: ROM:0000E4A8   o  ; was: sub_E7D8
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                move.w  #$50,(word_FF80C2).w ; 'P'
                bset    #1,(byte_FF80F8).w
                move.w  #$36,(word_FFA02A).w ; '6'
                bsr.w Gfx_Stage20InitPlanes
                move.w  #$6A0,(dword_FFA900).w
                move.w  (dword_FFA900).w,(word_FFA970).w
                move.w  (dword_FFA900).w,(word_FFA974).w
                move.w  (dword_FFA900).w,(word_FFA928).w
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  #$428,(a0)
                move.w  #2,4(a0)
                move.b  #2,(word_FFF7E6+1).w
                move.b  #4,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                rts
; End of function Stage_Stage20Init
; Stage 20 scroll handler
Stage_Stage20Scroll:                               ; DATA XREF: ROM:0000E4AA   o  ; was: sub_E830
                tst.b   (byte_FFA958).w
                beq.s   loc_E83E
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_E83E:                               ; CODE XREF: Stage_Stage20Scroll+4   j
                bsr.w Camera_UpdateTowardsPlayer
                bra.w   loc_EC06
; End of function Stage_Stage20Scroll
; Transition to Medusa form
Stage_MedusaTransition:                               ; DATA XREF: ROM:0000E4AC   o  ; was: sub_E846
                tst.b   (byte_FFA958).w
                beq.s   loc_E854
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_E854:                               ; CODE XREF: Stage_MedusaTransition+4   j
                bra.w Stage_MedusaCamera
; End of function Stage_MedusaTransition
; Transition to Sylpheed form
Stage_SylpheedTransition:                               ; DATA XREF: ROM:0000E4AE   o  ; was: sub_E858
                subi.l  #$1400,(dword_FF9610).w
                bpl.s   loc_E86A
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FF9610).w
loc_E86A:                               ; CODE XREF: Stage_SylpheedTransition+8   j
                move.l  (dword_FF9610).w,d0
                sub.l   d0,(dword_FFA900).w
                bra.w   loc_EBBE
; End of function Stage_SylpheedTransition
; Camera control for Sylpheed
Stage_SylpheedCamera:                               ; DATA XREF: ROM:0000E4B0   o  ; was: sub_E876
                tst.b   (byte_FFA958).w
                beq.s   locret_E890
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                clr.l   (dword_FF9614).w
                clr.l   (dword_FF961C).w
                bsr.w Gfx_SylpheedBackground
locret_E890:                            ; CODE XREF: Stage_SylpheedCamera+4   j
                rts
; End of function Stage_SylpheedCamera
; Camera position update
Stage_SylpheedCameraUpdate:                               ; DATA XREF: ROM:0000E4B2   o  ; was: sub_E892
                bsr.w Stage_SylpheedCameraLock
                bsr.w Gfx_LoadSylpheedTiles
                tst.b   (byte_FFA958).w
                beq.s   locret_E8A8
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
locret_E8A8:                            ; CODE XREF: Stage_SylpheedCameraUpdate+C   j
                rts
; End of function Stage_SylpheedCameraUpdate
; Graphics initialization
Stage_SylpheedGraphicsInit:                               ; DATA XREF: ROM:0000E4B4   o  ; was: sub_E8AA
                bsr.w Gfx_LoadSylpheedTiles
                tst.b   (byte_FFA958).w
                beq.s   loc_E8BC
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_E8BC:                               ; CODE XREF: Stage_SylpheedGraphicsInit+8   j
                                        ; Stage_SylpheedGraphicsUpdate+18   j
                bra.w Gfx_SylpheedForeground
; End of function Stage_SylpheedGraphicsInit
; Graphics update handler
Stage_SylpheedGraphicsUpdate:                               ; DATA XREF: ROM:0000E4B6   o  ; was: sub_E8C0
                tst.b   (byte_FFA958).w
                beq.s   loc_E8D4
                addq.w  #2,(word_FFA950).w
                move.w  #$20,(dword_FFA960).w ; ' '
                bra.w Stage_ArtemisCameraUpdate
; ---------------------------------------------------------------------------
loc_E8D4:                               ; CODE XREF: Stage_SylpheedGraphicsUpdate+4   j
                bsr.w Gfx_LoadSylpheedPalette
                bra.w   loc_E8BC
; End of function Stage_SylpheedGraphicsUpdate
; Transition to Artemis form
Stage_ArtemisTransition:                               ; DATA XREF: ROM:0000E4B8   o  ; was: sub_E8DC
                bsr.w Stage_ArtemisCameraLock
                bsr.w Boss_ArtemisSpawnProjectile1
                subq.w  #1,(dword_FFA960).w
                bpl.s   locret_E8F8
                tst.w   (word_FFF720).w
                bmi.s   locret_E8F8
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FF8240).w
locret_E8F8:                            ; CODE XREF: Stage_ArtemisTransition+C   j
                                        ; Stage_ArtemisTransition+12   j
                rts
; End of function Stage_ArtemisTransition
; Camera control for Artemis
Stage_ArtemisCamera:                               ; DATA XREF: ROM:0000E4BA   o  ; was: sub_E8FA
                bsr.w Stage_ArtemisGraphicsInit
                bpl.s   locret_E908
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
locret_E908:                            ; CODE XREF: Stage_ArtemisCamera+4   j
                rts
; End of function Stage_ArtemisCamera
; Graphics update handler
Stage_ArtemisGraphicsUpdate:                               ; DATA XREF: ROM:0000E4BC   o  ; was: sub_E90A
                tst.b   (byte_FFA958).w
                beq.s   locret_E914
                addq.w  #2,(word_FFA950).w
locret_E914:                            ; CODE XREF: Stage_ArtemisGraphicsUpdate+4   j
                rts
; End of function Stage_ArtemisGraphicsUpdate
; Background graphics setup
Gfx_ArtemisBackground:                               ; DATA XREF: ROM:0000E4BE   o  ; was: sub_E916
                bsr.w Gfx_ArtemisPlaneUpdate
                cmpi.w  #$E200,(dword_FFA904).w
                bne.s   locret_E92E
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                clr.w   (dword_FF8066).w
locret_E92E:                            ; CODE XREF: Gfx_ArtemisBackground+A   j
                rts
; End of function Gfx_ArtemisBackground
; Foreground graphics setup
Gfx_ArtemisForeground:                               ; DATA XREF: ROM:0000E4C0   o  ; was: sub_E930
                bsr.w Gfx_ArtemisTileUpdate
                bsr.w Camera_UpdateTowardsPlayer
                tst.b   (byte_FFA958).w
                beq.s   locret_E95A
                addq.w  #2,(word_FFA950).w
                move.w  #$40,(dword_FFA960).w ; '@'
                clr.l   (dword_FF9614).w
                clr.l   (dword_FF961C).w
                move.b  #$F4,d0
                jsr (Sound_PlaySFX).l
locret_E95A:                            ; CODE XREF: Gfx_ArtemisForeground+C   j
                rts
; End of function Gfx_ArtemisForeground
; Handle Sirene boss intro with countdown and shake
Stage_SireneIntroSequence:                               ; DATA XREF: ROM:0000E4C2   o  ; was: sub_E95C
                move.w  #2,(word_FFA010).w
                subq.w  #1,(dword_FFA960).w
                bpl.s   loc_E99E
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                clr.l   (dword_FF9614).w
                move.b  #$F5,d0
                jsr (Sound_PlaySFX).l
                move.w  #$E400,(dword_FFA904).w
                move.w  #$E400,(word_FFA92C).w
loc_E98A:                               ; CODE XREF: Stage_SireneUpdate1:loc_EA02   j
                                        ; sub_EA06:loc_EA20   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                addq.w  #4,d0
                move.w  d0,(word_FFA010).w
                move.w  #1,(word_FFA014).w
loc_E99E:                               ; CODE XREF: Stage_SireneIntroSequence+A   j
                                        ; Boss_SireneSpawnProjectile1+14   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_SireneIntroSequence
; Camera control for Sirene
Stage_SireneCamera:                               ; CODE XREF: Stage_SireneUpdate1   p  ; was: sub_E9A2
                                        ; sub_EA06   p
                move.w  #$60,d0 ; '`'
                cmp.w   (dword_FFA900).w,d0
                beq.s   loc_E9B8
                bpl.s   loc_E9B4
                subq.w  #1,(dword_FFA900).w
                bra.s   loc_E9B8
; ---------------------------------------------------------------------------
loc_E9B4:                               ; CODE XREF: Stage_SireneCamera+A   j
                addq.w  #1,(dword_FFA900).w
loc_E9B8:                               ; CODE XREF: Stage_SireneCamera+8   j
                                        ; Stage_SireneCamera+10   j
                addq.w  #1,(word_FFA970).w
                subq.w  #1,(word_FFA974).w
                cmp.w   (word_FFA970).w,d0
                bpl.s   locret_E9CE
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
locret_E9CE:                            ; CODE XREF: Stage_SireneCamera+22   j
                rts
; End of function Stage_SireneCamera
; Updates Sirene stage camera/graphics and plays SFX
Stage_SireneUpdate1:                               ; DATA XREF: ROM:0000E4C4   o  ; was: sub_E9D0
                bsr.s Stage_SireneCamera
                bsr.w Gfx_LoadSireneTiles
                bsr.w Stage_SireneGraphicsInit
                tst.b   (byte_FFA958).w
                beq.s   loc_EA02
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                move.b  #$F6,d0
                jsr (Sound_PlaySFX).l
                move.w  #$D0,(dword_FFA410).w
                move.w  #$188,(dword_FFA414).w
                addq.w  #2,(word_FFC624).w
loc_EA02:                               ; CODE XREF: Stage_SireneUpdate1+E   j
                bra.w   loc_E98A
; End of function Stage_SireneUpdate1
; Updates Sirene stage with camera/tiles/palette loading
Stage_SireneUpdate2:                               ; DATA XREF: ROM:0000E4C6   o  ; was: sub_EA06
                bsr.s Stage_SireneCamera
                bsr.w Gfx_LoadSireneTiles
                bsr.w Gfx_LoadSirenePalette
                tst.b   (byte_FFA958).w
                beq.s   loc_EA20
                addq.w  #2,(word_FFA950).w
                move.w  #$40,(dword_FFA960).w ; '@'
loc_EA20:                               ; CODE XREF: Stage_SireneUpdate2+E   j
                bra.w   loc_E98A
; End of function Stage_SireneUpdate2
; Spawns projectile type 1
Boss_SireneSpawnProjectile1:                               ; DATA XREF: ROM:0000E4C8   o  ; was: sub_EA24
                subq.w  #1,(dword_FFA960).w
                bpl.s   loc_EA32
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_EA32:                               ; CODE XREF: Boss_SireneSpawnProjectile1+4   j
                move.w  #2,(word_FFA010).w
                bra.w   loc_E99E
; End of function Boss_SireneSpawnProjectile1
; Spawns projectile type 2
Boss_SireneSpawnProjectile2:                               ; DATA XREF: ROM:0000E4CA   o  ; was: sub_EA3C
                bsr.w Camera_UpdateTowardsPlayer
                tst.b   (byte_FFA958).w
                beq.s   locret_EA74
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                move.w  #$40,(dword_FFA960+2).w ; '@'
                clr.w   (dword_FFA908).w
                movea.l #$FFFF2020,a0
                move.w  #$A000,d0
                move.w  #0,d1
                moveq   #$7E,d7 ; '~'
                jsr (Gfx_UpdateTilemapIndices).l
                move.w  #$8000,(word_FF808A).w
locret_EA74:                            ; CODE XREF: Boss_SireneSpawnProjectile2+8   j
                rts
; End of function Boss_SireneSpawnProjectile2
; Win cutscene initialization
Cutscene_SevenForcesWinInit:                               ; DATA XREF: ROM:0000E4CC   o  ; was: sub_EA76
                bsr.w Cutscene_SevenForcesCamera2
                bsr.w Cutscene_SevenForcesCamera1
                tst.b   (byte_FFA958).w
                beq.s   loc_EA8C
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_EA8C:                               ; CODE XREF: Cutscene_SevenForcesWinInit+C   j
                                        ; sub_EAA4:loc_EAB6   j ...
                tst.w   (dword_FFA960+2).w
                beq.s   loc_EA9E
                subq.w  #8,(dword_FFA960+2).w
                addq.w  #8,(word_FFA970).w
                subq.w  #8,(word_FFA974).w
loc_EA9E:                               ; CODE XREF: Cutscene_SevenForcesWinInit+1A   j
                bsr.w Camera_UpdateTowardsPlayer
                rts
; End of function Cutscene_SevenForcesWinInit
; Cutscene state handler 1
Cutscene_SevenForcesState1:                               ; DATA XREF: ROM:0000E4CE   o  ; was: sub_EAA4
                bsr.w Cutscene_SevenForcesCamera2
                tst.b   (byte_FFA958).w
                beq.s   loc_EAB6
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_EAB6:                               ; CODE XREF: Cutscene_SevenForcesState1+8   j
                bra.w   loc_EA8C
; End of function Cutscene_SevenForcesState1
; Cutscene state handler 2
Cutscene_SevenForcesState2:                               ; DATA XREF: ROM:0000E4D0   o  ; was: sub_EABA
                addi.l  #$78000,(dword_FFA90C).w
                bsr.w   loc_EA8C
                tst.b   (byte_FFA958).w
                beq.s   locret_EAD8
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                bsr.w Cutscene_SevenForcesLoadGraphics
locret_EAD8:                            ; CODE XREF: Cutscene_SevenForcesState2+10   j
                rts
; End of function Cutscene_SevenForcesState2
; Cutscene state handler 3
Cutscene_SevenForcesState3:                               ; DATA XREF: ROM:0000E4D2   o  ; was: sub_EADA
                addi.l  #$78000,(dword_FFA90C).w
                bsr.w   loc_EA8C
                bsr.w Gfx_InitTilemapUpdate
                bmi.s   locret_EAF0
                addq.w  #2,(word_FFA950).w
locret_EAF0:                            ; CODE XREF: Cutscene_SevenForcesState3+10   j
                rts
; End of function Cutscene_SevenForcesState3
; Cutscene state handler 4
Cutscene_SevenForcesState4:                               ; DATA XREF: ROM:0000E4D4   o  ; was: sub_EAF2
                addi.l  #$78000,(dword_FFA90C).w
                bsr.w   loc_EA8C
                bsr.w Cutscene_SevenForcesCheckComplete
                bpl.s   locret_EB18
                addq.w  #2,(word_FFA950).w
                clr.w   (dword_FFA900).w
                clr.w   (word_FFA928).w
                clr.w   (dword_FFA904).w
                clr.w   (word_FFA92C).w
locret_EB18:                            ; CODE XREF: Cutscene_SevenForcesState4+10   j
                rts
; End of function Cutscene_SevenForcesState4
; Cutscene state handler 5
Cutscene_SevenForcesState5:                               ; DATA XREF: ROM:0000E4D6   o  ; was: sub_EB1A
                andi.w  #$1FF,(dword_FFA90C).w
                addi.l  #$78000,(dword_FFA90C).w
                cmpi.w  #$200,(dword_FFA90C).w
                bmi.s   loc_EB44
                andi.w  #$1FF,(dword_FFA90C).w
                addi.w  #-$1C00,(dword_FFA90C).w
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_EB44:                               ; CODE XREF: Cutscene_SevenForcesState5+14   j
                bra.w Cutscene_SevenForcesEmptyState
; End of function Cutscene_SevenForcesState5
; Cutscene state handler 6
Cutscene_SevenForcesState6:                               ; DATA XREF: ROM:0000E4D8   o  ; was: sub_EB48
                bsr.w Cutscene_SevenForcesEmptyState
                bsr.w Cutscene_SevenForcesCamera3
                tst.b   (byte_FFA958).w
                beq.s   locret_EB5A
                addq.w  #2,(word_FFA950).w
locret_EB5A:                            ; CODE XREF: Cutscene_SevenForcesState6+C   j
                rts
; End of function Cutscene_SevenForcesState6
; Empty cutscene state for Seven Forces sequence
Cutscene_SevenForcesEmptyState:                             ; CODE XREF: Cutscene_SevenForcesState5:loc_EB44   j  ; was: nullsub_27
                                        ; sub_EB48   p
                                        ; DATA XREF: ...
                rts
; End of function Cutscene_SevenForcesEmptyState
; Updates camera position and calculates scroll
Camera_UpdateScrollPosition:
                bsr.w Camera_UpdateTowardsPlayer  ; was: sub_EB5E
                bsr.w Gfx_CalculateScrollPosition
                move.w  (dword_FFA908).w,d0
                addi.w  #$40,d0 ; '@'
                neg.w   d0
                move.w  d0,(word_FFE400).w
                move.w  (dword_FFA900).w,(dword_FFA908).w
                rts
; End of function Camera_UpdateScrollPosition
; Checks boss defeat and triggers stage transition
Stage_CheckBossTransition:
                tst.w   (word_FF8230).w  ; was: sub_EB7C
                bne.w Stage_Stage18EmptyHandler
                tst.w   (word_FF8138).w
                bne.w Stage_Stage18EmptyHandler
                move.b  #$93,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; End of function Stage_CheckBossTransition
; Camera control for Medusa
Stage_MedusaCamera:                               ; CODE XREF: Stage_MedusaTransition:loc_E854   j  ; was: sub_EB9E
                addi.l  #$200,(dword_FF9610).w
                cmpi.w  #2,(dword_FF9610).w
                bmi.s   loc_EBB6
                move.l  #$20000,(dword_FF9610).w
loc_EBB6:                               ; CODE XREF: Stage_MedusaCamera+E   j
                move.l  (dword_FF9610).w,d0
                sub.l   d0,(dword_FFA900).w
loc_EBBE:                               ; CODE XREF: Stage_SylpheedTransition+1A   j
                bpl.s   loc_EBD2
                addi.w  #$800,(dword_FFA900).w
                addi.w  #$800,(word_FFA928).w
                move.w  #1,(word_FF9804).w
loc_EBD2:                               ; CODE XREF: Stage_MedusaCamera:loc_EBBE   j
                move.w  (dword_FFA900).w,d0
                subi.w  #$10,d0
                bpl.s   loc_EBE0
                addi.w  #$800,d0
loc_EBE0:                               ; CODE XREF: Stage_MedusaCamera+3C   j
                move.w  (dword_FFA904).w,d1
                jsr (Gfx_RenderTilemap).l
                move.w  (dword_FFA900).w,d0
                subi.w  #$10,d0
                bpl.s   loc_EBF8
                addi.w  #$800,d0
loc_EBF8:                               ; CODE XREF: Stage_MedusaCamera+54   j
                move.w  (dword_FFA904).w,d1
                subi.w  #$C00,d1
                jsr     (loc_108A4).l
loc_EC06:                               ; CODE XREF: Stage_Stage20Scroll+12   j
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                asr.w   #1,d0
                move.w  d0,d1
                asr.w   #1,d1
                movea.w #(byte_FFE482-M68K_RAM),a0
                moveq   #$20,d6 ; ' '
                moveq   #6,d7
loc_EC1A:                               ; CODE XREF: Stage_MedusaCamera+80   j
                move.w  d0,(a0)
                adda.w  d6,a0
                dbf     d7,loc_EC1A
                moveq   #7,d7
loc_EC24:                               ; CODE XREF: Stage_MedusaCamera+8A   j
                move.w  d1,(a0)
                adda.w  d6,a0
                dbf     d7,loc_EC24
                moveq   #8,d7
loc_EC2E:                               ; CODE XREF: Stage_MedusaCamera+94   j
                move.w  d0,(a0)
                adda.w  d6,a0
                dbf     d7,loc_EC2E
                rts
; End of function Stage_MedusaCamera
; Camera lock handler
Stage_SylpheedCameraLock:                               ; CODE XREF: Stage_SylpheedCameraUpdate   p  ; was: sub_EC38
                move.l  (dword_FF9614).w,d0
                subi.l  #$2000,d0
                cmpi.l  #$FFF88000,d0
                bpl.s   loc_EC50
                move.l  #$FFF88000,d0
loc_EC50:                               ; CODE XREF: Stage_SylpheedCameraLock+10   j
                move.l  d0,(dword_FF9614).w
                add.l   d0,(dword_FFA904).w
                cmpi.w  #$F600,(dword_FFA904).w
                bpl.s   loc_EC66
                move.b  #1,(byte_FFA958).w
loc_EC66:                               ; CODE XREF: Stage_SylpheedCameraLock+26   j
                move.w  (dword_FFA900).w,d0
                subi.w  #$60,d0 ; '`'
                bpl.s   loc_EC74
                addi.w  #$800,d0
loc_EC74:                               ; CODE XREF: Stage_SylpheedCameraLock+36   j
                move.w  (dword_FFA904).w,d1
                subi.w  #$F8,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Stage_SylpheedCameraLock
; Loads Sylpheed tiles
Gfx_LoadSylpheedTiles:                               ; CODE XREF: Stage_SylpheedCameraUpdate+4   p  ; was: sub_EC86
                                        ; sub_E8AA   p
                bsr.s Gfx_LoadSylpheedPalette
                cmpi.w  #$F400,(dword_FFA90C).w
                bpl.s   loc_EC96
                move.b  #1,(byte_FFA958).w
loc_EC96:                               ; CODE XREF: Gfx_LoadSylpheedTiles+8   j
                moveq   #0,d0
                move.w  (dword_FFA90C).w,d1
                subi.w  #$F8,d1
                lea     (dword_11336).l,a0
                bra.w   loc_109E0
; End of function Gfx_LoadSylpheedTiles
; Loads Sylpheed palette
Gfx_LoadSylpheedPalette:                               ; CODE XREF: Stage_SylpheedGraphicsUpdate:loc_E8D4   p  ; was: sub_ECAA
                                        ; sub_EC86   p
                move.l  (dword_FF961C).w,d0
                subi.l  #$1000,d0
                cmpi.l  #$FFF88000,d0
                bpl.s   loc_ECC2
                move.l  #$FFF88000,d0
loc_ECC2:                               ; CODE XREF: Gfx_LoadSylpheedPalette+10   j
                move.l  d0,(dword_FF961C).w
                add.l   d0,(dword_FFA90C).w
                rts
; End of function Gfx_LoadSylpheedPalette
; Plane update handler
Gfx_ArtemisPlaneUpdate:                               ; CODE XREF: Gfx_ArtemisBackground   p  ; was: sub_ECCC
                subi.w  #6,(dword_FFA904).w
                cmpi.w  #$E200,(dword_FFA904).w
                bpl.s   loc_ECE0
                move.w  #$E200,(dword_FFA904).w
loc_ECE0:                               ; CODE XREF: Gfx_ArtemisPlaneUpdate+C   j
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                addi.w  #$100,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Gfx_ArtemisPlaneUpdate
; Tile update handler
Gfx_ArtemisTileUpdate:                               ; CODE XREF: Gfx_ArtemisForeground   p  ; was: sub_ECF4
                tst.w   (dword_FF8066).w
                bne.s   loc_ED12
                subi.l  #$E00,(dword_FFA904).w
                cmpi.w  #$E1F8,(dword_FFA904).w
                bpl.s   locret_ED10
                move.w  #2,(dword_FF8066).w
locret_ED10:                            ; CODE XREF: Gfx_ArtemisTileUpdate+14   j
                                        ; Gfx_ArtemisTileUpdate+36   j
                rts
; ---------------------------------------------------------------------------
loc_ED12:                               ; CODE XREF: Gfx_ArtemisTileUpdate+4   j
                bpl.s   loc_ED1C
                addi.l  #$12000,(dword_FFA904).w
loc_ED1C:                               ; CODE XREF: Gfx_ArtemisTileUpdate:loc_ED12   j
                addi.l  #$E00,(dword_FFA904).w
                cmpi.w  #$E206,(dword_FFA904).w
                bmi.s   locret_ED10
                clr.w   (dword_FF8066).w
                rts
; End of function Gfx_ArtemisTileUpdate
; Graphics initialization
Stage_SireneGraphicsInit:                               ; CODE XREF: Stage_SireneUpdate1+6   p  ; was: sub_ED32
                move.l  (dword_FF9614).w,d0
                addi.l  #$200,d0
                cmpi.l  #$8000,d0
                bmi.s   loc_ED4A
                move.l  #$8000,d0
loc_ED4A:                               ; CODE XREF: Stage_SireneGraphicsInit+10   j
                move.l  d0,(dword_FF9614).w
                add.l   d0,(dword_FFA904).w
                cmpi.w  #$E4C0,(dword_FFA904).w
                bmi.s   loc_ED6A
                move.b  #1,(byte_FFA958).w
                move.w  #8,(word_FFA010).w
                bsr.w Stage_ClearRAMFlag
loc_ED6A:                               ; CODE XREF: Stage_SireneGraphicsInit+26   j
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                addi.w  #$100,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Stage_SireneGraphicsInit
; Loads Sirene palette
Gfx_LoadSirenePalette:                               ; CODE XREF: Stage_SireneUpdate2+6   p  ; was: sub_ED7E
                move.l  (dword_FF961C).w,d0
                add.l   d0,(dword_FFA904).w
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                subi.w  #$100,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Gfx_LoadSirenePalette
; Loads Sirene tiles
Gfx_LoadSireneTiles:                               ; CODE XREF: Stage_SireneUpdate1+2   p  ; was: sub_ED9A
                                        ; Stage_SireneUpdate2+2   p
                move.l  (dword_FF961C).w,d0
                subi.l  #$100,d0
                cmpi.l  #$FFFFC000,d0
                bpl.s   loc_EDB2
                move.l  #$FFFFC000,d0
loc_EDB2:                               ; CODE XREF: Gfx_LoadSireneTiles+10   j
                move.l  d0,(dword_FF961C).w
                add.l   d0,(dword_FFA90C).w
                cmpi.w  #$E340,(dword_FFA90C).w
                bpl.s   loc_EDC8
                move.b  #1,(byte_FFA958).w
loc_EDC8:                               ; CODE XREF: Gfx_LoadSireneTiles+26   j
                move.w  #$200,d0
                move.w  (dword_FFA90C).w,d1
                subi.w  #$100,d1
                lea     (dword_11336).l,a0
                bra.w   loc_109E0
; End of function Gfx_LoadSireneTiles
nullsub_28:
                rts
; End of function nullsub_28


; Camera scroll handler 1
Cutscene_SevenForcesCamera1:                               ; CODE XREF: Cutscene_SevenForcesWinInit+4   p  ; was: sub_EDE0
                addi.l  #$78000,(dword_FFA904).w
                cmpi.w  #$E520,(dword_FFA904).w
                bmi.s   loc_EDF6
                move.b  #1,(byte_FFA958).w
loc_EDF6:                               ; CODE XREF: Cutscene_SevenForcesCamera1+E   j
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                addi.w  #$F8,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Cutscene_SevenForcesCamera1
; Camera scroll handler 2
Cutscene_SevenForcesCamera2:                               ; CODE XREF: Cutscene_SevenForcesWinInit   p  ; was: sub_EE0A
                                        ; sub_EAA4   p
                addi.l  #$78000,(dword_FFA90C).w
                cmpi.w  #$E4F8,(dword_FFA90C).w
                bmi.s   loc_EE20
                move.b  #1,(byte_FFA958).w
loc_EE20:                               ; CODE XREF: Cutscene_SevenForcesCamera2+E   j
                move.w  #$200,d0
                move.w  (dword_FFA90C).w,d1
                addi.w  #$F8,d1
                lea     (dword_11336).l,a0
                bra.w   loc_109E0
; End of function Cutscene_SevenForcesCamera2
; Camera scroll handler 3
Cutscene_SevenForcesCamera3:                               ; CODE XREF: Cutscene_SevenForcesState6+4   p  ; was: sub_EE36
                addi.l  #$78000,(dword_FFA90C).w
                cmpi.w  #$E700,(dword_FFA90C).w
                bmi.s   loc_EE4C
                move.b  #1,(byte_FFA958).w
loc_EE4C:                               ; CODE XREF: Cutscene_SevenForcesCamera3+E   j
                move.w  #$200,d0
                move.w  (dword_FFA90C).w,d1
                addi.w  #$F8,d1
                lea     (dword_11336).l,a0
                bra.w   loc_109E0
; End of function Cutscene_SevenForcesCamera3
; Camera position update
Stage_ArtemisCameraUpdate:                               ; CODE XREF: Stage_SylpheedGraphicsUpdate+10   j  ; was: sub_EE62
                bsr.w Boss_ArtemisShootPattern1
                bset    #6,(byte_FF8245).w
                move.w  #$60,(dword_FFA900).w ; '`'
                move.w  #$60,(word_FFA928).w ; '`'
                move.w  #$E300,(dword_FFA904).w
                move.w  #$E300,(word_FFA92C).w
                clr.w   (dword_FFA908).w
                move.w  #$E400,(dword_FFA90C).w
                move.w  (dword_FFA900).w,(word_FFA970).w
                move.w  (dword_FFA900).w,(word_FFA974).w
                lea     stru_EEA6(pc),a0
                nop
                jmp (Data_ProcessPointer).l
; End of function Stage_ArtemisCameraUpdate
; ---------------------------------------------------------------------------
stru_EEA6:      dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_ArtemisCameraUpdate+38   o
                dc.l tiles_1B6F86       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1B8CBC       ; field_2
                dc.w $1F00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1BB632        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1BB6A4        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B82E8        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B83A8        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF


; Camera lock handler
Stage_ArtemisCameraLock:                               ; CODE XREF: Stage_ArtemisTransition   p  ; was: sub_EED8
                tst.w   (word_FFF720).w
                bmi.s   locret_EF26
                movea.l #$FFFF4020,a0
                move.w  #0,d0
                move.w  #$F8,d1
                moveq   #$47,d7 ; 'G'
                jsr (Gfx_UpdateTilemapIndices).l
                movea.l #$FFFF4920,a0
                move.w  #$A000,d0
                move.w  #$F8,d1
                moveq   #1,d7
                jsr (Gfx_UpdateTilemapIndices).l
                move.l  #dword_11336,(dword_FFA940).w
                move.w  #$200,(word_FFA946).w
                move.w  #$E400,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                moveq   #1,d0
locret_EF26:                            ; CODE XREF: Stage_ArtemisCameraLock+4   j
                rts
; End of function Stage_ArtemisCameraLock
; Graphics initialization
Stage_ArtemisGraphicsInit:                               ; CODE XREF: Stage_ArtemisCamera   p  ; was: sub_EF28
                jsr (Gfx_RenderScrollingBackground).l
                bpl.s   locret_EF4A
                move.l  #dword_11326,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$E400,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                moveq   #$FFFFFFFF,d0
locret_EF4A:                            ; CODE XREF: Stage_ArtemisGraphicsInit+6   j
                rts
; End of function Stage_ArtemisGraphicsInit
; Palette update handler
Gfx_ArtemisPaletteUpdate:                               ; CODE XREF: Boss_ArtemisDispatcher+20   p  ; was: sub_EF4C
                lea     word_EF58(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_ArtemisPaletteUpdate
; ---------------------------------------------------------------------------
word_EF58:      dc.w $6C00, $4000, $F00, $494A, $494A, $494A, $494A, $494A, $494A, $494A, $494A
                                        ; DATA XREF: Gfx_ArtemisPaletteUpdate   o


; Wrapper for scrolling background render
Gfx_RenderBackgroundWrapper:
                jsr (Gfx_RenderScrollingBackground).l  ; was: sub_EF6E
                bpl.s   locret_EF78
                moveq   #$FFFFFFFF,d0
locret_EF78:                            ; CODE XREF: Gfx_RenderBackgroundWrapper+6   j
                rts
; End of function Gfx_RenderBackgroundWrapper
; Loads cutscene graphics
Cutscene_SevenForcesLoadGraphics:                               ; CODE XREF: Cutscene_SevenForcesState2+1A   p  ; was: sub_EF7A
                lea     (word_B9C0).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                lea     stru_EF92(pc),a0
                nop
                jmp (Data_ProcessPointer).l
; End of function Cutscene_SevenForcesLoadGraphics
; ---------------------------------------------------------------------------
stru_EF92:      dc.w 7                  ; field_0
                                        ; DATA XREF: Cutscene_SevenForcesLoadGraphics+C   o
                dc.l tiles_1BBC4E       ; field_2
                dc.w $1F00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1BCFFE        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1BD048        ; field_2
                dc.w $4020              ; field_6
                dc.w $FFFF


; Initializes tilemap update with scroll parameters
Gfx_InitTilemapUpdate:                               ; CODE XREF: Cutscene_SevenForcesState3+C   p  ; was: sub_EFAC
                tst.w   (word_FFF720).w
                bmi.s   locret_EFE0
                movea.l #$FFFF4020,a0
                move.w  #0,d0
                move.w  #$F8,d1
                moveq   #$7E,d7 ; '~'
                jsr (Gfx_UpdateTilemapIndices).l
                move.l  #dword_11326,(dword_FFA940).w
                clr.w   (word_FFA946).w
                clr.w   (word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                moveq   #1,d0
locret_EFE0:                            ; CODE XREF: Gfx_InitTilemapUpdate+4   j
                rts
; End of function Gfx_InitTilemapUpdate
; Attributes: thunk
; Checks cutscene completion
Cutscene_SevenForcesCheckComplete:                               ; CODE XREF: Cutscene_SevenForcesState4+C   p  ; was: sub_EFE2
                jmp Gfx_RenderScrollingBackground
; End of function Cutscene_SevenForcesCheckComplete
; Initializes Stage 20 planes
Gfx_Stage20InitPlanes:                               ; CODE XREF: Stage_Stage20Init+1A   p  ; was: sub_EFE8
                move.b  #$82,(byte_FF7981).l
                move.b  #$90,(byte_FF7982).l
                move.b  #$92,(byte_FF7983).l
                lea     (word_FF0C80).l,a0
                lea     (word_FF0D00).l,a1
                lea     (word_FF0D80).l,a2
                lea     (word_FF0E00).l,a3
                move.w  #$181,d1
                moveq   #$3F,d7 ; '?'
loc_F01E:                               ; CODE XREF: Gfx_Stage20InitPlanes+3E   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                move.w  d1,(a3)+
                dbf     d7,loc_F01E
                rts
; End of function Gfx_Stage20InitPlanes
; Background graphics setup
Gfx_SylpheedBackground:                               ; CODE XREF: Stage_SylpheedCamera+16   p  ; was: sub_F02C
                clr.b   (byte_FF7981).l
                clr.b   (byte_FF7982).l
                clr.b   (byte_FF7983).l
                rts
; End of function Gfx_SylpheedBackground
; Shooting pattern 1
Boss_ArtemisShootPattern1:                               ; CODE XREF: Stage_ArtemisCameraUpdate   p  ; was: sub_F040
                move.b  #2,(byte_FF7B00).l
                lea     (word_FF0B00).l,a0
                move.w  #$300,d1
                moveq   #$3F,d7 ; '?'
loc_F054:                               ; CODE XREF: Boss_ArtemisShootPattern1+16   j
                move.w  d1,(a0)+
                dbf     d7,loc_F054
                rts
; End of function Boss_ArtemisShootPattern1
; Clears byte flag at FF7B00
Stage_ClearRAMFlag:                               ; CODE XREF: Stage_SireneGraphicsInit+34   p  ; was: sub_F05C
                clr.b   (byte_FF7B00).l
                rts
; End of function Stage_ClearRAMFlag
; Clamps palette fade value and applies fade
Gfx_PaletteFadeClamp:
                move.w  (word_FF9620).w,d0  ; was: sub_F064
                bpl.s   loc_F074
                cmpi.w  #$FFE4,d0
                bpl.s   loc_F078
                moveq   #$FFFFFFE4,d0
                bra.s   loc_F078
; ---------------------------------------------------------------------------
loc_F074:                               ; CODE XREF: Gfx_PaletteFadeClamp+4   j
                beq.s   loc_F078
                moveq   #0,d0
loc_F078:                               ; CODE XREF: Gfx_PaletteFadeClamp+A   j
                                        ; Gfx_PaletteFadeClamp+E   j ...
                move.w  d0,(word_FF9620).w
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #$1F,d5
                move.w  #$E000,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Gfx_PaletteFadeClamp
; Spawns projectile type 1
Boss_ArtemisSpawnProjectile1:                               ; CODE XREF: Stage_ArtemisTransition+4   p  ; was: sub_F08C
                tst.l   (dword_FF8240).w
                beq.s   locret_F0B2
                bpl.s   loc_F0A4
                addi.l  #$800,(dword_FF8240).w
                bmi.s   locret_F0B2
                clr.l   (dword_FF8240).w
                rts
; ---------------------------------------------------------------------------
loc_F0A4:                               ; CODE XREF: Boss_ArtemisSpawnProjectile1+6   j
                subi.l  #$800,(dword_FF8240).w
                bpl.s   locret_F0B2
                clr.l   (dword_FF8240).w
locret_F0B2:                            ; CODE XREF: Boss_ArtemisSpawnProjectile1+4   j
                                        ; Boss_ArtemisSpawnProjectile1+10   j ...
                rts
; End of function Boss_ArtemisSpawnProjectile1
; Foreground graphics setup
Gfx_SylpheedForeground:                               ; CODE XREF: Stage_SylpheedGraphicsInit:loc_E8BC   j  ; was: sub_F0B4
                btst    #3,(word_FFA40E).w
                bne.s   loc_F0CC
                subi.l  #$1000,(dword_FF8240).w
                bpl.s   loc_F0E4
                clr.l   (dword_FF8240).w
                bra.s   loc_F0E4
; ---------------------------------------------------------------------------
loc_F0CC:                               ; CODE XREF: Gfx_SylpheedForeground+6   j
                addi.l  #$2000,(dword_FF8240).w
                cmpi.w  #4,(dword_FF8240).w
                bmi.s   loc_F0E4
                move.l  #$40000,(dword_FF8240).w
loc_F0E4:                               ; CODE XREF: Gfx_SylpheedForeground+10   j
                                        ; Gfx_SylpheedForeground+16   j ...
                move.l  (dword_FF8240).w,d0
                asl.l   #1,d0
                add.l   d0,(dword_FFA908).w
                rts
; End of function Gfx_SylpheedForeground
; Stage transition initialization
Stage_TransitionInit:                               ; DATA XREF: ROM:0000FF42   o  ; was: sub_F0F0
                movea.w off_F0FC(pc,d0.w),a0
                adda.l  #Stage_TransitionGraphics,a0
                jmp     (a0)
; End of function Stage_TransitionInit
; ---------------------------------------------------------------------------
off_F0FC:       dc.w Stage_TransitionGraphics-Stage_TransitionGraphics
                dc.w Stage_Graphics_TransitionLoop-Stage_TransitionGraphics
                dc.w Stage_AsteroidsTransition-Stage_TransitionGraphics
                dc.w Stage_AsteroidsScrollHandler-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoInit-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoAnimationScript-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoGraphicsCleanup-Stage_TransitionGraphics
                dc.w Boss_ShieldViperTransition-Stage_TransitionGraphics
                dc.w Boss_ShieldViperInit-Stage_TransitionGraphics
                dc.w Boss_ShieldViperGraphicsInit-Stage_TransitionGraphics
                dc.w Boss_ShieldViperPaletteSetup-Stage_TransitionGraphics
                dc.w Boss_ShieldViperGraphicsCleanup-Stage_TransitionGraphics
                dc.w Boss_ShieldViperPaletteRestore-Stage_TransitionGraphics
                dc.w Boss_ShieldViperFinalCleanup-Stage_TransitionGraphics
                dc.w Boss_WolfGaropaTransition-Stage_TransitionGraphics
                dc.w Boss_WolfGaropaPaletteSetup-Stage_TransitionGraphics
                dc.w Boss_WolfGaropaMain-Stage_TransitionGraphics
                dc.w Boss_WolfGaropaDispatcher-Stage_TransitionGraphics
                dc.w Boss_WolfGaropaIntroInit-Stage_TransitionGraphics
                dc.w Boss_WolfGaropaIntroMove-Stage_TransitionGraphics
                dc.w Boss_WolfGaropaSpawnProjectile2-Stage_TransitionGraphics
                dc.w Boss_DestroyerPhaseInit-Stage_TransitionGraphics
                dc.w Boss_WolfGaropaPhaseInit-Stage_TransitionGraphics
                dc.w Boss_WolfGaropaTransitionOut-Stage_TransitionGraphics
                dc.w Boss_WolfGaropaBattleWrapper-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Stage24_Init-Stage_TransitionGraphics
                dc.w Stage24_InitLoop-Stage_TransitionGraphics
                dc.w Boss_MissirayTransition-Stage_TransitionGraphics
                dc.w Boss_MissirayInit-Stage_TransitionGraphics
                dc.w Boss_MissirayPaletteUpdate-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Stage24_InitCutscene-Stage_TransitionGraphics
                dc.w Camera_ScrollAccelerate-Stage_TransitionGraphics
                dc.w Scroll_ClampVerticalPos-Stage_TransitionGraphics
                dc.w Stage_CheckPhaseComplete-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Stage_IncrementPhase-Stage_TransitionGraphics
                dc.w Stage_IncrementPhase_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Stage25_TransitionInit-Stage_TransitionGraphics
                dc.w Stage25_TransitionLoop-Stage_TransitionGraphics
                dc.w Boss_ZLeoTransition-Stage_TransitionGraphics
                dc.w Stage_CheckTransitionTrigger-Stage_TransitionGraphics
                dc.w Stage_Stage25CameraUpdate-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Stage_SetStage25ScrollTimer-Stage_TransitionGraphics
                dc.w Gfx_UpdateScrollWrapper-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics
                dc.w Boss_DestroyerProtoTransition_Return-Stage_TransitionGraphics


; Transition graphics handler
Stage_TransitionGraphics:                               ; DATA XREF: Stage_TransitionInit+4   o  ; was: sub_F19A
                                        ; ROM:off_F0FC   o ...
                addq.w  #2,(word_FFA950).w
                move.b  #$80,(byte_FFA958).w
                clr.l   (dword_FFA964).w
                clr.w   (word_FFA968).w
                clr.b   (byte_FFA96A).w
                move.l  #$10000,(dword_FF8062).w
                move.l  #$10000,(dword_FFA960).w
                move.l  #$7000,(dword_FF9D9E).w
                move.l  #$C000,(dword_FF9DA2).w
                move.b  #3,(word_FFF7E6+1).w
                move.b  #1,(byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.w  #$3AC,(word_FFC620).w
                clr.w   (word_FFC624).w
; Handles graphics transition with scroll updates
Stage_Graphics_TransitionLoop:                               ; DATA XREF: ROM:0000F0FE   o  ; was: loc_F1EC
                bsr.w Stage_ScrollUpdate2
                bsr.w Stage_ScrollUpdate3
                subi.l  #$100,(dword_FF8062).w
                subi.l  #$80,(dword_FFA960).w
                cmpi.w  #$FFFC,(dword_FFA960).w
                bpl.w Stage_ScrollUpdate1
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                rts
; End of function Stage_TransitionGraphics
; Transition to asteroids
Stage_AsteroidsTransition:                               ; DATA XREF: ROM:0000F100   o  ; was: sub_F218
                bsr.w Stage_ScrollUpdate2
                bsr.w Stage_ScrollUpdate3
                tst.b   (byte_FFA96A).w
                beq.w Stage_ScrollUpdate1
                addq.w  #2,(word_FFA950).w
                move.b  #$40,(byte_FFA958).w ; '@'
                andi.w  #$FF,(dword_FFA904).w
                addi.w  #-$900,(dword_FFA904).w
                bra.w Stage_AsteroidsGraphicsUpdate
; End of function Stage_AsteroidsTransition
; Asteroids scroll handler
Stage_AsteroidsScrollHandler:                               ; DATA XREF: ROM:0000F102   o  ; was: sub_F242
                bsr.w Stage_ScrollUpdate2
                bsr.w Stage_ScrollUpdate3
                cmpi.w  #$F600,(dword_FFA904).w
                bpl.w Stage_AsteroidsGraphicsUpdate
                move.w  #$8000,(word_FF808A).w
                move.b  #$80,(byte_FFA958).w
                move.w  #$80,(word_FF9DB0).w
                jmp Stage_TransitionToNextPhase
; End of function Stage_AsteroidsScrollHandler
; Transition to boss
Boss_DestroyerProtoTransition:                               ; DATA XREF: ROM:0000F104   o  ; was: sub_F26C
                bsr.w Stage_ScrollUpdate3
                subq.w  #1,(word_FF9DB0).w
                bpl.w Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                lea     (stru_11568).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Boss_DestroyerProtoTransition
; Boss initialization
Boss_DestroyerProtoInit:                               ; DATA XREF: ROM:0000F106   o  ; was: sub_F288
                bsr.w Stage_ScrollUpdate3
                tst.w   (word_FFC620).w
                bne.w Boss_DestroyerProtoTransition_Return
                move.w  #$1C,(word_FF9DAE).w
                bsr.w Boss_DestroyerProtoPaletteInit
                jsr (UI_InitScoreTimer).l
                lea     (byte_C212).l,a0
                jsr     (LoadPalette).l
loc_F2B0:                               ; CODE XREF: Boss_DestroyerPhaseInit+14   j
                clr.b   (byte_FFA958).w
                move.w  #$50,(word_FFF74A).w ; 'P'
                clr.w   (word_FFF74E).w
                move.w  #$16,(word_FF8090).w
                move.w  #$60,(word_FF9D94).w ; '`'
                move.l  #$4000,(dword_FF9D9E).w
                move.l  #$8000,(dword_FF9DA2).w
                move.l  #$2000000,(dword_FF9DAA).w
                move.l  #$1E80000,(dword_FF9DB2).w
                move.l  #dword_11326,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$F500,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                rts
; End of function Boss_DestroyerProtoInit
; Initializes destroyer proto boss phase state
Boss_DestroyerPhaseInit:                               ; DATA XREF: ROM:0000F128   o  ; was: sub_F304
                move.w  #$C,(word_FFA950).w
                clr.w   (word_FF80C2).w
                clr.w   (word_FF9DAE).w
                move.b  #3,(word_FFF7E6+1).w
                bra.w   loc_F2B0
; End of function Boss_DestroyerPhaseInit
; Animation script interpreter
Boss_DestroyerProtoAnimationScript:                               ; DATA XREF: ROM:0000F108   o  ; was: sub_F31C
                move.l  #$2000000,(dword_FF9DAA).w
                bsr.w Boss_DestroyerProtoPaletteInit
                bsr.w   loc_FBD8
                bsr.w Boss_DestroyerProtoRenderSegments
                tst.w   (word_FFA944).w
                bmi.s   loc_F33E
                jsr (Gfx_RenderScrollingBackground).l
                bra.s   locret_F34E
; ---------------------------------------------------------------------------
loc_F33E:                               ; CODE XREF: Boss_DestroyerProtoAnimationScript+18   j
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                clr.w   (word_FF820C).w
                clr.b   (byte_FFA209).w
locret_F34E:                            ; CODE XREF: Boss_DestroyerProtoAnimationScript+20   j
                rts
; End of function Boss_DestroyerProtoAnimationScript
; Graphics cleanup handler
Boss_DestroyerProtoGraphicsCleanup:                               ; DATA XREF: ROM:0000F10A   o  ; was: sub_F350
                bsr.w Boss_DestroyerProtoPaletteInit
                bsr.w   loc_FBD8
                bsr.w Boss_DestroyerProtoRenderSegments
                move.w  (dword_FF9DAA).w,d0
                addi.w  #$60,d0 ; '`'
                move.w  d0,(dword_FF9D90).w
                tst.b   (byte_FFA958).w
                bne.s   loc_F3C2
                moveq   #0,d7
                cmpi.l  #$FFFF8000,(dword_FF9D9E).w
                beq.s   loc_F384
                subi.l  #$80,(dword_FF9D9E).w
                addq.w  #1,d7
loc_F384:                               ; CODE XREF: Boss_DestroyerProtoGraphicsCleanup+28   j
                cmpi.l  #$FFFF8000,(dword_FF9DA2).w
                beq.s   loc_F398
                subi.l  #$80,(dword_FF9DA2).w
                addq.w  #1,d7
loc_F398:                               ; CODE XREF: Boss_DestroyerProtoGraphicsCleanup+3C   j
                tst.w   d7
                bne.s   locret_F3DE
                move.b  #1,(byte_FFA958).w
                move.w  #$50,(word_FF80C2).w ; 'P'
                move.w  #$2A,(word_FFA204).w ; '*'
                move.w  #$166,(dword_FF9D96).w
                move.l  #$2000000,(dword_FF9DAA).w
                move.w  #$3C8,(word_FFDB20).w
loc_F3C2:                               ; CODE XREF: Boss_DestroyerProtoGraphicsCleanup+1C   j
                addi.l  #$10,(dword_FF9DA2).w
                tst.w   (dword_FF9DAA).w
                bne.s   locret_F3DE
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FF9DA2).w
                move.w  #$E0,(dword_FFA904).w
locret_F3DE:                            ; CODE XREF: Boss_DestroyerProtoGraphicsCleanup+4A   j
                                        ; Boss_DestroyerProtoGraphicsCleanup+7E   j
                rts
; End of function Boss_DestroyerProtoGraphicsCleanup
; Transition to boss
Boss_ShieldViperTransition:                               ; DATA XREF: ROM:0000F10C   o  ; was: sub_F3E0
                bsr.w   loc_FBD8
                bsr.w Boss_DestroyerProtoRenderSegments
                cmpi.w  #$FF80,(dword_FF9D96).w
                bpl.s   locret_F400
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                clr.w   (word_FF8090).w
locret_F400:                            ; CODE XREF: Boss_ShieldViperTransition+E   j
                rts
; End of function Boss_ShieldViperTransition
; Boss initialization
Boss_ShieldViperInit:                               ; DATA XREF: ROM:0000F10E   o  ; was: sub_F402
                bsr.w   loc_FBD8
                bsr.w Boss_ShieldViperScrollSetup
                move.b  #0,(byte_FFA958).w
                jsr (Stage_TransitionToNextPhase).l
                lea     (stru_11554).l,a1
                jsr (Gfx_UpdateBossPalette).l
                clr.w   (word_FF9DFC).w
                clr.w   (word_FF9DFE).w
                rts
; End of function Boss_ShieldViperInit
; Graphics initialization
Boss_ShieldViperGraphicsInit:                               ; DATA XREF: ROM:0000F110   o  ; was: sub_F42C
                bsr.w   loc_FBD8
                bsr.w Boss_ShieldViperScrollSetup
                bsr.w Boss_ShieldViperRenderBackground
                cmpi.w  #$C,(word_FF9DFE).w
                bmi.w Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                rts
; End of function Boss_ShieldViperGraphicsInit
; Palette setup
Boss_ShieldViperPaletteSetup:                               ; DATA XREF: ROM:0000F112   o  ; was: sub_F448
                bsr.w   loc_FBD8
                bsr.w Boss_ShieldViperScrollSetup
                tst.w   (word_FFC620).w
                bne.w Boss_DestroyerProtoTransition_Return
                move.b  #1,(byte_FF830E).w
                addq.w  #2,(word_FFA950).w
                move.l  #dword_11326,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$F100,(word_FFA948).w
                move.w  #$10,(word_FFA944).w
                move.w  #$E,(word_FF9DAE).w
                bra.w   loc_FD08
; End of function Boss_ShieldViperPaletteSetup
; Graphics cleanup handler
Boss_ShieldViperGraphicsCleanup:                               ; DATA XREF: ROM:0000F114   o  ; was: sub_F484
                bsr.w   loc_FD08
                jsr (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                move.w  #$20,(dword_FF8128).w ; ' '
                move.l  #dword_11346,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$F400,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                move.b  #4,(byte_FFA95B).w
                move.w  #$A000,d0
                bra.w Boss_WolfGaropaGraphicsInit
; End of function Boss_ShieldViperGraphicsCleanup
; Restores palette
Boss_ShieldViperPaletteRestore:                               ; DATA XREF: ROM:0000F116   o  ; was: sub_F4C6
                bsr.w   loc_FD08
                subq.w  #1,(dword_FF8128).w
                bmi.s   loc_F4D2
                rts
; ---------------------------------------------------------------------------
loc_F4D2:                               ; CODE XREF: Boss_ShieldViperPaletteRestore+8   j
                cmpi.w  #$1B,(word_FFA944).w
                bmi.s Boss_ShieldViperVRAMCleanup
                jmp Gfx_RenderScrollingBackground
; End of function Boss_ShieldViperPaletteRestore
; VRAM cleanup
Boss_ShieldViperVRAMCleanup:                               ; CODE XREF: Boss_ShieldViperPaletteRestore+12   j  ; was: sub_F4E0
                move.w  #$6000,(dword_FFA940).w
                clr.w   (word_FFA946).w
                jsr (Sprite_SetupDMA).l
                tst.w   (word_FFA944).w
                bpl.w Boss_DestroyerProtoTransition_Return
                move.w  #$50,(word_FFF74A).w ; 'P'
                clr.w   (word_FFF74E).w
                move.w  #$16,(word_FF8090).w
                clr.l   (dword_FF8066).w
                move.l  #$600000,(dword_FF9D90).w
                clr.l   (dword_FF9DAA).w
                clr.w   (dword_FFA908).w
                move.w  #$F4E2,(dword_FFA90C).w
                jmp Stage_TriggerPhaseTransition
; End of function Boss_ShieldViperVRAMCleanup
; Final cleanup handler
Boss_ShieldViperFinalCleanup:                               ; DATA XREF: ROM:0000F118   o  ; was: sub_F528
                bsr.w   loc_FD08
                bsr.w Boss_DestroyerProtoRenderSegments
                tst.w   (word_FF9DAE).w
                bmi.s   loc_F53E
                beq.s   loc_F53E
                subq.w  #1,(word_FF9DAE).w
                rts
; ---------------------------------------------------------------------------
loc_F53E:                               ; CODE XREF: Boss_ShieldViperFinalCleanup+C   j
                                        ; Boss_ShieldViperFinalCleanup+E   j
                tst.w   (word_FF80C2).w
                bne.s   locret_F55E
                move.b  #$89,d0
                jsr (Input_CheckButtonMode).l
                addq.w  #2,(word_FFA950).w
                addq.w  #2,(word_FFA204).w
                move.l  #$10000,(dword_FF9DB6).w
locret_F55E:                            ; CODE XREF: Boss_ShieldViperFinalCleanup+1A   j
                rts
; End of function Boss_ShieldViperFinalCleanup
; Transition to boss
Boss_WolfGaropaTransition:                               ; DATA XREF: ROM:0000F11A   o  ; was: sub_F560
                bsr.w Boss_WolfGaropaInit
                bsr.w Boss_DestroyerProtoRenderSegments
                subi.l  #$8000,(dword_FF9DAA).w
                subi.l  #$8000,(dword_FF9D90).w
                bpl.s   locret_F58C
                addq.w  #2,(word_FFA950).w
                clr.w   (dword_FFA90C+2).w
                move.w  #$12,(word_FF8220).w
                bsr.w Boss_WolfGaropaAttackState3
locret_F58C:                            ; CODE XREF: Boss_WolfGaropaTransition+18   j
                rts
; End of function Boss_WolfGaropaTransition
; Palette setup
Boss_WolfGaropaPaletteSetup:                               ; DATA XREF: ROM:0000F11C   o  ; was: sub_F58E
                bsr.w Boss_WolfGaropaInit
                move.w  (dword_FFA90C).w,(dword_FFA904).w
                cmpi.w  #$F400,(dword_FFA90C).w
                bpl.s   loc_F5A8
                subi.l  #$400,(dword_FF9DB6).w
loc_F5A8:                               ; CODE XREF: Boss_WolfGaropaPaletteSetup+10   j
                cmpi.w  #$F3E0,(dword_FFA90C).w
                bpl.w Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                clr.w   (word_FF8090).w
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.l  #dword_11326,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                clr.w   (word_FFA946).w
                move.w  #$F400,(word_FFA948).w
                move.w  #$2000,d0
                bra.w Boss_WolfGaropaGraphicsInit
; End of function Boss_WolfGaropaPaletteSetup
; Main boss handler
Boss_WolfGaropaMain:                               ; DATA XREF: ROM:0000F11E   o  ; was: sub_F5EE
                move.l  (dword_FF8062).w,d0
                sub.l   d0,(dword_FFA908).w
                move.w  (dword_FFA908).w,(dword_FFA900).w
                move.w  (dword_FFA90C).w,(dword_FFA904).w
                jsr (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.s   locret_F622
                addq.w  #2,(word_FFA950).w
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                clr.w   (word_FFA946).w
locret_F622:                            ; CODE XREF: Boss_WolfGaropaMain+1E   j
                rts
; End of function Boss_WolfGaropaMain
; Boss state dispatcher
Boss_WolfGaropaDispatcher:                               ; DATA XREF: ROM:0000F120   o  ; was: sub_F624
                bsr.w Boss_WolfGaropaBattleStart
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                jsr (Sprite_SetupDMA).l
                tst.w   (word_FFA944).w
                bpl.s   locret_F660
                addq.w  #2,(word_FFA950).w
                move.w  #$50,(word_FF80C2).w ; 'P'
                clr.b   (byte_FFA209).w
                move.w  #$494,(word_FFDB20).w
                clr.w   (word_FFDB24).w
                clr.w   (word_FFDB22).w
                clr.b   (byte_FFDB41).w
locret_F660:                            ; CODE XREF: Boss_WolfGaropaDispatcher+1A   j
                rts
; End of function Boss_WolfGaropaDispatcher
; Initializes Wolf Garopa attack phase 3
Boss_WolfGaropaPhaseInit:                               ; DATA XREF: ROM:0000F12A   o  ; was: sub_F662
                move.w  #$24,(word_FFA950).w ; '$'
                move.l  #$FFF88000,(dword_FF8062).w
                bsr.w Boss_WolfGaropaAttackState3
                bset    #0,(byte_FFA209).w
                rts
; End of function Boss_WolfGaropaPhaseInit
; Intro animation init
Boss_WolfGaropaIntroInit:                               ; DATA XREF: ROM:0000F122   o  ; was: sub_F67C
                bsr.w Boss_WolfGaropaBattleStart
                jmp Stage_TransitionToNextPhase
; End of function Boss_WolfGaropaIntroInit
; Intro movement
Boss_WolfGaropaIntroMove:                               ; DATA XREF: ROM:0000F124   o  ; was: sub_F686
                bsr.w Boss_WolfGaropaIntroStop
                tst.w   (word_FF80C2).w
                bne.w Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FF9DBA).w
                lea     (stru_11584).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Boss_WolfGaropaIntroMove
; Spawns projectile type 2
Boss_WolfGaropaSpawnProjectile2:                               ; DATA XREF: ROM:0000F126   o  ; was: sub_F6A6
                bsr.w Boss_WolfGaropaBattleStart
                tst.w   (word_FFC620).w
                bne.s   locret_F6C2
                move.w  #$30,(word_FFA950).w ; '0'
                move.w  #$2E,(word_FF80C2).w ; '.'
                move.w  #$80,(dword_FF8128).w
locret_F6C2:                            ; CODE XREF: Boss_WolfGaropaSpawnProjectile2+8   j
                rts
; End of function Boss_WolfGaropaSpawnProjectile2
; Transition out of boss
Boss_WolfGaropaTransitionOut:                               ; DATA XREF: ROM:0000F12C   o  ; was: sub_F6C4
                bsr.w Boss_WolfGaropaBattleStart
                tst.w   (word_FF80C2).w
                bne.s   locret_F6F2
                subq.w  #1,(dword_FF8128).w
                bpl.s   locret_F6F2
                tst.w   (word_FF8230).w
                bne.s   locret_F6F2
                tst.w   (word_FF8138).w
                bne.s   locret_F6F2
                move.b  #$8F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; ---------------------------------------------------------------------------
locret_F6F2:                            ; CODE XREF: Boss_WolfGaropaTransitionOut+8   j
                                        ; Boss_WolfGaropaTransitionOut+E   j ...
                rts
; End of function Boss_WolfGaropaTransitionOut
; Wrapper to start Wolf Garopa battle
Boss_WolfGaropaBattleWrapper:                               ; DATA XREF: ROM:0000F12E   o  ; was: sub_F6F4
                bsr.w Boss_WolfGaropaBattleStart
                rts
; End of function Boss_WolfGaropaBattleWrapper
; Intro stop position
Boss_WolfGaropaIntroStop:                               ; CODE XREF: Boss_WolfGaropaIntroMove   p  ; was: sub_F6FA
                cmpi.l  #$FFFF0000,(dword_FF8240).w
                beq.s   loc_F70C
                subi.l  #$800,(dword_FF8240).w
loc_F70C:                               ; CODE XREF: Boss_WolfGaropaIntroStop+8   j
                move.l  (dword_FF8062).w,d0
                cmpi.l  #$FFF60000,d0
                bmi.s Boss_WolfGaropaBattleStart
                beq.s Boss_WolfGaropaBattleStart
                subi.l  #$800,d0
                move.l  d0,(dword_FF8062).w
; End of function Boss_WolfGaropaIntroStop
; Battle start initialization
Boss_WolfGaropaBattleStart:                               ; CODE XREF: Boss_WolfGaropaDispatcher   p  ; was: sub_F724
                                        ; sub_F67C   p ...
                move.l  (dword_FF8062).w,d0
                sub.l   d0,(dword_FFA900).w
                tst.b   (byte_FF9DBA).w
                beq.s   loc_F74A
                bmi.s   locret_F750
                tst.w   (dword_FFA900).w
                bmi.s   locret_F750
                cmpi.w  #$200,(dword_FFA900).w
                bmi.s   locret_F750
                clr.b   (byte_FF9DBA).w
                bsr.w Gfx_LoadWolfGaropaTiles
loc_F74A:                               ; CODE XREF: Boss_WolfGaropaBattleStart+C   j
                andi.w  #$3F,(dword_FFA900).w ; '?'
locret_F750:                            ; CODE XREF: Boss_WolfGaropaBattleStart+E   j
                                        ; Boss_WolfGaropaBattleStart+14   j ...
                rts
; End of function Boss_WolfGaropaBattleStart
; DMA transfers Wolf Garopa tile graphics
Gfx_LoadWolfGaropaTiles:                               ; CODE XREF: Boss_WolfGaropaBattleStart+22   p  ; was: sub_F752
                                        ; Boss_ValkirieForcePlayerToCeiling+28   p
                lea     byte_F76A(pc),a0
                nop
                jsr (Gfx_DMATransferTiles).l
                lea     byte_F778(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_LoadWolfGaropaTiles
; ---------------------------------------------------------------------------
byte_F76A:      dc.b $44, $58, $40, 0, 1, 3, $1F
                                        ; DATA XREF: Gfx_LoadWolfGaropaTiles   o
                dc.b $1E, $21, $20, $23, $22, $25, $24
byte_F778:      dc.b $4C, $50, $40, 0, 4, 1, $26, $27
                                        ; DATA XREF: Gfx_LoadWolfGaropaTiles+C   o
                dc.b $26, $27, $26, $28, $29, $28, $29, $28


; Boss initialization
Boss_WolfGaropaInit:                               ; CODE XREF: Boss_WolfGaropaTransition   p  ; was: sub_F788
                                        ; sub_F58E   p
                move.l  (dword_FF9DB6).w,d0
                sub.l   d0,(dword_FFA90C).w
                move.l  (dword_FF8062).w,d0
                sub.l   d0,(dword_FFA908).w
                moveq   #0,d0
                move.w  (dword_FFA90C).w,d1
                subi.w  #$F8,d1
                lea     (dword_11346).l,a0
                bra.w   loc_109E0
; End of function Boss_WolfGaropaInit
; Graphics initialization
Boss_WolfGaropaGraphicsInit:                               ; CODE XREF: Boss_ShieldViperGraphicsCleanup+3E   j  ; was: sub_F7AC
                                        ; Boss_WolfGaropaPaletteSetup+5C   j
                movea.l #$FFFF4300,a0
                moveq   #$30,d7 ; '0'
                jmp Gfx_AdjustTileIndices
; End of function Boss_WolfGaropaGraphicsInit
; Initializes stage scroll parameters and timers
Stage_InitScrollParams:
                addq.w  #2,(word_FFA950).w  ; was: sub_F7BA
                move.b  #$40,(byte_FFA958).w ; '@'
                move.w  #$FFFE,(dword_FFA960).w
                clr.b   (word_FFF7E6+1).w
                rts
; End of function Stage_InitScrollParams
; Updates asteroids scroll until position reached
Stage_AsteroidsScrollCheck:
                bsr.w Stage_ScrollUpdate3  ; was: sub_F7D0
                bsr.w Stage_AsteroidsGraphicsUpdate
                cmpi.w  #$F3E0,(dword_FFA904).w
                bpl.w Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                move.b  #0,(byte_FFA958).w
                move.w  #$F3E0,(dword_FFA904).w
                clr.l   (dword_FFA960).w
                rts
; End of function Stage_AsteroidsScrollCheck
nullsub_29:
                rts
; End of function nullsub_29


; Stage initialization
Stage24_Init:                               ; DATA XREF: ROM:0000F13C   o  ; was: sub_F7FA
                addq.w  #2,(word_FFA950).w
                move.l  #$FFFE0000,(dword_FFA960).w
                move.b  #4,(word_FFF7E6+1).w
                move.b  #2,(byte_FFA95A).w
                move.b  #8,(byte_FFA95B).w
                move.w  #$200,(word_FF9DB0).w
                movea.w #(word_FFDB20-M68K_RAM),a0
                movea.w #(byte_FFDB80-M68K_RAM),a1
                move.w  #$3E0,(a0)
                move.w  #$C400,2(a0)
                move.l  #word_1CF762,8(a0)
                move.w  #$8200,$E(a0)
                move.b  #$20,$21(a0) ; ' '
                move.w  #2,$46(a0)
                move.l  #$FF000100,$28(a0)
                move.w  #$150,d6
                move.w  #$120,d7
                move.w  d6,$10(a0)
                move.w  d7,$14(a0)
                move.w  d6,$4C(a0)
                move.w  d7,$4E(a0)
                clr.w   $56(a0)
                move.w  #$3E0,(a1)
                move.w  #1,$56(a1)
                move.w  #$C400,2(a1)
                move.l  #word_1CF780,8(a1)
                move.w  #$8200,$E(a1)
                move.w  #$D0,$10(a1)
                move.w  d7,$14(a1)
                move.w  #$3C8,(word_FFDBE0).w
; Stage 24 initialization loop with graphics and timer
Stage24_InitLoop:                               ; DATA XREF: ROM:0000F13E   o  ; was: loc_F89C
                bsr.w Stage24_GraphicsSetup
                subq.w  #1,(word_FF9DB0).w
                bpl.w Boss_DestroyerProtoTransition_Return
                move.w  #$80,(word_FF9DB0).w
                jmp Stage_TransitionToNextPhase
; End of function Stage24_Init
; Transition to boss
Boss_MissirayTransition:                               ; DATA XREF: ROM:0000F140   o  ; was: sub_F8B4
                bsr.w Stage24_GraphicsSetup
                subq.w  #1,(word_FF9DB0).w
                bpl.w Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                lea     (stru_1163C).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Boss_MissirayTransition
; Boss initialization
Boss_MissirayInit:                               ; DATA XREF: ROM:0000F142   o  ; was: sub_F8D0
                tst.w   (word_FFC620).w
                bne.s   loc_F8E6
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(word_FF80C2).w ; '.'
                move.b  #1,(byte_FF830E).w
loc_F8E6:                               ; CODE XREF: Boss_MissirayInit+4   j
                bra.w Stage24_GraphicsSetup
; End of function Boss_MissirayInit
; Palette update handler
Boss_MissirayPaletteUpdate:                               ; DATA XREF: ROM:0000F144   o  ; was: sub_F8EA
                bsr.w Stage24_GraphicsSetup
                tst.w   (word_FF80C2).w
                bne.s   locret_F912
                tst.w   (word_FF8230).w
                bne.s   locret_F912
                tst.w   (word_FF8138).w
                bne.s   locret_F912
                move.b  #$9F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; ---------------------------------------------------------------------------
locret_F912:                            ; CODE XREF: Boss_MissirayPaletteUpdate+8   j
                                        ; Boss_MissirayPaletteUpdate+E   j ...
                rts
; End of function Boss_MissirayPaletteUpdate
; Graphics setup
Stage24_GraphicsSetup:                               ; CODE XREF: Stage24_Init:loc_F89C   p  ; was: sub_F914
                                        ; sub_F8B4   p ...
                move.l  (dword_FFA960).w,d0
                sub.l   d0,(dword_FFA904).w
                move.w  (dword_FFA904).w,d0
                move.w  d0,d1
                move.w  d0,d2
                asr.w   #1,d1
                asr.w   #2,d2
                move.w  d0,(word_FFEC00).w
                move.w  d0,(word_FFEC04).w
                move.w  d0,(word_FFEC48).w
                move.w  d0,(word_FFEC4C).w
                move.w  d1,(word_FFEC08).w
                move.w  d1,(word_FFEC44).w
                movea.w #(word_FFEC0C-M68K_RAM),a0
                moveq   #$D,d7
loc_F946:                               ; CODE XREF: Stage24_GraphicsSetup+36   j
                move.w  d2,(a0)
                addq.w  #4,a0
                dbf     d7,loc_F946
                rts
; End of function Stage24_GraphicsSetup
; Scroll handler
Stage24_ScrollHandler:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_F950
                move.b  (byte_FFA420).w,$20(a5)
                subq.b  #4,$20(a5)
                tst.w   $56(a5)
                bne.s   locret_F9B4
                bclr    #0,6(a5)
                beq.s   loc_F9AA
                tst.w   (word_FFA22A).w
                beq.s   loc_F976
                btst    #2,(byte_FF8244).w
                bne.s   loc_F9AA
loc_F976:                               ; CODE XREF: Stage24_ScrollHandler+1C   j
                btst    #0,(word_FFF706).w
                beq.s   loc_F990
                subq.w  #1,$14(a5)
                cmpi.w  #$D0,$14(a5)
                bpl.s   loc_F9AA
                move.w  #$D0,$14(a5)
loc_F990:                               ; CODE XREF: Stage24_ScrollHandler+2C   j
                btst    #1,(word_FFF706).w
                beq.s   loc_F9AA
                addq.w  #1,$14(a5)
                cmpi.w  #$160,$14(a5)
                bmi.s   loc_F9AA
                move.w  #$160,$14(a5)
loc_F9AA:                               ; CODE XREF: Stage24_ScrollHandler+16   j
                                        ; Stage24_ScrollHandler+24   j ...
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.w  $14(a5),$14(a0)
locret_F9B4:                            ; CODE XREF: Stage24_ScrollHandler+E   j
                rts
; End of function Stage24_ScrollHandler
; Initializes stage 24 cutscene objects and sound
Stage24_InitCutscene:                               ; DATA XREF: ROM:0000F14A   o  ; was: sub_F9B6
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  #$410,(a0)
                move.w  #$256,$10(a0)
                move.w  #$60,$14(a0) ; '`'
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$C500,2(a0)
                move.w  #$AC0,$E(a0)
                move.b  #$10,$20(a0)
                move.l  #word_1CE4F8,8(a0)
                move.w  #0,(word_FFA970).w
                move.w  #$C0,(word_FFA974).w
                clr.l   (dword_FF8066+2).w
                move.b  #$C9,d0
                jsr (Sound_PlaySFX).l
; End of function Stage24_InitCutscene
; Accelerates vertical scroll until target reached
Camera_ScrollAccelerate:                               ; DATA XREF: ROM:0000F14C   o  ; was: sub_FA0E
                cmpi.w  #2,(dword_FF8066+2).w
                bpl.s   loc_FA1E
                addi.l  #$1000,(dword_FF8066+2).w
loc_FA1E:                               ; CODE XREF: Camera_ScrollAccelerate+6   j
                move.l  (dword_FF8066+2).w,d0
                add.l   d0,(dword_FFA900).w
                cmpi.w  #$C0,(dword_FFA900).w
                bmi.s   locret_FA38
                addq.w  #2,(word_FFA950).w
                move.w  #$C0,(dword_FFA900).w
locret_FA38:                            ; CODE XREF: Camera_ScrollAccelerate+1E   j
                rts
; End of function Camera_ScrollAccelerate
; Clamps vertical scroll position to bounds
Scroll_ClampVerticalPos:                               ; DATA XREF: ROM:0000F14E   o  ; was: sub_FA3A
                move.w  #$100,d0
                sub.w   (dword_FFDB34).w,d0
                bmi.s   loc_FA46
                moveq   #0,d0
loc_FA46:                               ; CODE XREF: Scroll_ClampVerticalPos+8   j
                cmpi.w  #$FFE0,d0
                bpl.s   loc_FA54
                addq.w  #2,(word_FFA950).w
                move.w  #$FFE0,d0
loc_FA54:                               ; CODE XREF: Scroll_ClampVerticalPos+10   j
                move.w  d0,(dword_FFA904).w
                rts
; End of function Scroll_ClampVerticalPos
; Checks if stage phase complete and transitions
Stage_CheckPhaseComplete:                               ; DATA XREF: ROM:0000F150   o  ; was: sub_FA5A
                tst.b   (byte_FFA958).w
                beq.s   locret_FA82
                tst.w   (word_FF8230).w
                bne.s   locret_FA82
                tst.w   (word_FF8138).w
                bne.s   locret_FA82
                addq.w  #2,(word_FFA204).w
                move.b  #$8F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; ---------------------------------------------------------------------------
locret_FA82:                            ; CODE XREF: Stage_CheckPhaseComplete+4   j
                                        ; Stage_CheckPhaseComplete+A   j ...
                rts
; End of function Stage_CheckPhaseComplete
; Increments stage phase counter
Stage_IncrementPhase:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_FA84
                                        ; ROM:0000F15E   o
                addq.w  #2,(word_FFA950).w
; Return after incrementing stage phase
Stage_IncrementPhase_Return:                            ; DATA XREF: ROM:0000F160   o  ; was: locret_FA88
                rts
; End of function Stage_IncrementPhase
; Stage transition init
Stage25_TransitionInit:                               ; DATA XREF: ROM:0000F172   o  ; was: sub_FA8A
                addq.w  #2,(word_FFA950).w
                move.w  #$20,(dword_FFA90C).w ; ' '
; Stage 25 transition scrolling loop at position $480
Stage25_TransitionLoop:                               ; DATA XREF: ROM:0000F174   o  ; was: loc_FA94
                bsr.w Gfx_UpdateScroll
                bsr.w Stage25_CameraUpdate
                cmpi.w  #$480,(dword_FFA900).w
                bmi.w Boss_DestroyerProtoTransition_Return
                bra.w Stage_TransitionToNextPhase
; End of function Stage25_TransitionInit
; Transition to Z-Leo boss
Boss_ZLeoTransition:                               ; DATA XREF: ROM:0000F176   o  ; was: sub_FAAA
                bsr.w Gfx_LoadBossTiles
                bsr.w Stage25_CameraUpdate
                cmpi.w  #$500,(dword_FFA900).w
                bmi.w Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$500,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (stru_11618).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Boss_ZLeoTransition
; Checks trigger flag and starts phase transition
Stage_CheckTransitionTrigger:                               ; DATA XREF: ROM:0000F178   o  ; was: sub_FAE0
                tst.w   (word_FFC620).w
                bne.s   locret_FAEA
                bsr.w Stage_TriggerPhaseTransition
locret_FAEA:                            ; CODE XREF: Stage_CheckTransitionTrigger+4   j
                rts
; End of function Stage_CheckTransitionTrigger
; Attributes: thunk
; Branches to Stage25 camera update routine
Stage_Stage25CameraUpdate:                               ; DATA XREF: ROM:0000F17A   o  ; was: sub_FAEC
                bra.w Stage25_CameraUpdate
; End of function Stage_Stage25CameraUpdate
; Initializes section change and updates camera
Stage_InitSectionCamera:
                bsr.w Stage_InitSectionChange  ; was: sub_FAF0
                bsr.w Camera_UpdateTowardsPlayer
; End of function Stage_InitSectionCamera
; Camera update handler
Stage25_CameraUpdate:                               ; CODE XREF: Stage25_TransitionInit+E   p  ; was: sub_FAF8
                                        ; Boss_ZLeoTransition+4   p ...
                move.w  (dword_FFA900).w,d0
                subi.w  #$300,d0
                asr.w   #4,d0
                move.w  d0,(dword_FFA908).w
                rts
; End of function Stage25_CameraUpdate
; Sets scroll timer and clears secondary timer
Stage_SetStage25ScrollTimer:                               ; DATA XREF: ROM:0000F186   o  ; was: sub_FB08
                move.w  #$8C,(word_FFA284).w
                clr.w   (word_FFA286).w
                rts
; End of function Stage_SetStage25ScrollTimer
; Advances state and sets vertical scroll
Stage_SetVerticalScrollBase:
                addq.w  #2,(word_FFA950).w  ; was: sub_FB14
                move.w  #$20,(dword_FFA904).w ; ' '
; End of function Stage_SetVerticalScrollBase
; Calls graphics scroll update routine
Gfx_UpdateScrollWrapper:                               ; DATA XREF: ROM:0000F188   o  ; was: sub_FB1E
                bsr.w Gfx_UpdateScroll
                rts
; End of function Gfx_UpdateScrollWrapper
; Graphics update handler
Stage_AsteroidsGraphicsUpdate:                               ; CODE XREF: Stage_AsteroidsTransition+26   j  ; was: sub_FB24
                                        ; Stage_AsteroidsScrollHandler+E   j ...
                bsr.s Stage_ScrollUpdate1
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                subi.w  #$F8,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Stage_AsteroidsGraphicsUpdate
; Scroll update handler 1
Stage_ScrollUpdate1:                               ; CODE XREF: Stage_TransitionGraphics+70   j  ; was: sub_FB3A
                                        ; Stage_AsteroidsTransition+C   j ...
                move.l  (dword_FFA960).w,d0
                add.l   d0,(dword_FFA904).w
                add.l   d0,(dword_FFA964).w
                clr.b   (byte_FFA96A).w
                move.w  (dword_FFA964).w,d0
                andi.w  #$100,d0
                cmp.w   (word_FFA968).w,d0
                beq.s Boss_DestroyerProtoTransition_Return
                addq.b  #1,(byte_FFA96A).w
                move.w  d0,(word_FFA968).w
; Return from Destroyer Proto transition
Boss_DestroyerProtoTransition_Return:                            ; CODE XREF: Boss_DestroyerProtoTransition+8   j  ; was: locret_FB60
                                        ; Boss_DestroyerProtoInit+8   j ...
                rts
; End of function Stage_ScrollUpdate1
; Checks button 6 input and sets trigger flag
Input_CheckButtonTrigger:
                btst    #6,(word_FFF706).w  ; was: sub_FB62
                beq.s   locret_FB70
                bset    #0,(byte_FFA958).w
locret_FB70:                            ; CODE XREF: Input_CheckButtonTrigger+6   j
                rts
; End of function Input_CheckButtonTrigger
; Scroll update handler 2
Stage_ScrollUpdate2:                               ; CODE XREF: Stage_TransitionGraphics:loc_F1EC   p  ; was: sub_FB72
                                        ; sub_F218   p ...
                move.l  (dword_FF8066).w,d0
                add.l   (dword_FF8062).w,d0
                move.l  d0,(dword_FF8066).w
                swap    d0
                movea.w #(word_FFE480-M68K_RAM),a0
                move.w  #$BF,d7
loc_FB88:                               ; CODE XREF: Stage_ScrollUpdate2+1A   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_FB88
                rts
; End of function Stage_ScrollUpdate2
; Updates vertical scroll and shifts scroll buffer
Stage_ScrollUpdate4:
                bsr.w Stage_ScrollUpdate3  ; was: sub_FB92
                movea.w #(word_FFE480-M68K_RAM),a0
                moveq   #$5F,d7 ; '_'
loc_FB9C:                               ; CODE XREF: Stage_ScrollUpdate4+10   j
                move.w  2(a0),(a0)
                addq.w  #4,a0
                dbf     d7,loc_FB9C
                rts
; End of function Stage_ScrollUpdate4
; Scroll update handler 3
Stage_ScrollUpdate3:                               ; CODE XREF: Stage_TransitionGraphics+56   p  ; was: sub_FBA8
                                        ; Stage_AsteroidsTransition+4   p ...
                tst.w   (dword_FF9DA2).w
                bpl.s   loc_FBB8
                cmpi.l  #$FFFF8080,(dword_FF9DA2).w
                bmi.s   loc_FBC0
loc_FBB8:                               ; CODE XREF: Stage_ScrollUpdate3+4   j
                subi.l  #$40,(dword_FF9DA2).w ; '@'
loc_FBC0:                               ; CODE XREF: Stage_ScrollUpdate3+E   j
                tst.w   (dword_FF9D9E).w
                bpl.s   loc_FBD0
                cmpi.l  #$FFFF8000,(dword_FF9D9E).w
                bmi.s   loc_FBD8
loc_FBD0:                               ; CODE XREF: Stage_ScrollUpdate3+1C   j
                subi.l  #$40,(dword_FF9D9E).w ; '@'
loc_FBD8:                               ; CODE XREF: Boss_DestroyerProtoAnimationScript+C   p
                                        ; Boss_DestroyerProtoGraphicsCleanup+4   p ...
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
loc_FC10:                               ; CODE XREF: Stage_ScrollUpdate3+70   j
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
loc_FC44:                               ; CODE XREF: Stage_ScrollUpdate3+92   j
                movea.w #(byte_FFE482-M68K_RAM),a0
                move.w  #$2F,d7 ; '/'
loc_FC4C:                               ; CODE XREF: Stage_ScrollUpdate3+B4   j
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
loc_FC6E:                               ; CODE XREF: Stage_ScrollUpdate3+C2   j
                move.l  d0,(dword_FFA90C).w
                rts
; End of function Stage_ScrollUpdate3
; Scroll setup handler
Boss_ShieldViperScrollSetup:                               ; CODE XREF: Boss_ShieldViperInit+4   p  ; was: sub_FC74
                                        ; Boss_ShieldViperGraphicsInit+4   p ...
                bsr.w Stage22_GraphicsUpdate1
                movea.w #(byte_FFE580-M68K_RAM),a1
                movea.w #(word_FF9E00-M68K_RAM),a0
                moveq   #$7F,d7
loc_FC82:                               ; CODE XREF: Boss_ShieldViperScrollSetup+12   j
                move.w  (a0)+,(a1)
                addq.w  #4,a1
                dbf     d7,loc_FC82
                rts
; End of function Boss_ShieldViperScrollSetup
; Graphics update 1
Stage22_GraphicsUpdate1:                               ; CODE XREF: Boss_ShieldViperScrollSetup   p  ; was: sub_FC8C
                                        ; sub_FD32   p
                move.l  #$FFF88000,(dword_FF8062).w
                move.l  (dword_FF8062).w,d0
                add.l   d0,(dword_FF8066).w
                move.w  (dword_FF8066).w,d0
                bpl.s   loc_FCAA
                addi.w  #$40,d0 ; '@'
                bmi.s   loc_FCB0
                bra.s   loc_FCB4
; ---------------------------------------------------------------------------
loc_FCAA:                               ; CODE XREF: Stage22_GraphicsUpdate1+14   j
                subi.w  #$40,d0 ; '@'
                bmi.s   loc_FCB4
loc_FCB0:                               ; CODE XREF: Stage22_GraphicsUpdate1+1A   j
                move.w  d0,(dword_FF8066).w
loc_FCB4:                               ; CODE XREF: Stage22_GraphicsUpdate1+1C   j
                                        ; Stage22_GraphicsUpdate1+22   j
                move.l  (dword_FF8066).w,d0
                divs.w  #$7000,d0
                ext.l   d0
                asl.l   #8,d0
                movea.w #(byte_FF9F00-M68K_RAM),a0
                move.l  (dword_FF8066).w,d1
                moveq   #$5F,d7 ; '_'
loc_FCCA:                               ; CODE XREF: Stage22_GraphicsUpdate1+46   j
                swap    d1
                move.w  d1,-(a0)
                swap    d1
                sub.l   d0,d1
                dbf     d7,loc_FCCA
                move.l  (dword_FF8062).w,d0
                add.l   d0,(dword_FF806A).w
                move.w  (dword_FF806A).w,d1
                asr.w   #4,d1
                moveq   #$17,d7
loc_FCE6:                               ; CODE XREF: Stage22_GraphicsUpdate1+5C   j
                move.w  d1,-(a0)
                dbf     d7,loc_FCE6
                move.w  (dword_FF9D96).w,d1
                move.w  d1,-(a0)
                rts
; End of function Stage22_GraphicsUpdate1
; Palette initialization
Boss_DestroyerProtoPaletteInit:                               ; CODE XREF: Boss_DestroyerProtoInit+12   p  ; was: sub_FCF4
                                        ; Boss_DestroyerProtoAnimationScript+8   p ...
                tst.w   (word_FF9DAE).w
                bne.s   loc_FCFC
                rts
; ---------------------------------------------------------------------------
loc_FCFC:                               ; CODE XREF: Boss_DestroyerProtoPaletteInit+4   j
                btst    #0,(word_FFA000+1).w
                bne.s   loc_FD08
                subq.w  #1,(word_FF9DAE).w
loc_FD08:                               ; CODE XREF: Boss_ShieldViperPaletteSetup+38   j
                                        ; sub_F484   p ...
                movea.w #(word_FFE300-M68K_RAM),a0
                move.w  #$E000,d7
                move.w  (word_FF9DAE).w,d0
                moveq   #$3F,d5 ; '?'
                jsr (Gfx_SetFadeParams).l
                moveq   #0,d0
                sub.w   (word_FF9DAE).w,d0
                movea.w #(word_FFE340-M68K_RAM),a0
                move.w  #$C000,d7
                moveq   #$F,d5
                jmp (Gfx_ApplyPaletteFade).l
; End of function Boss_DestroyerProtoPaletteInit
; Renders boss segments
Boss_DestroyerProtoRenderSegments:                               ; CODE XREF: Boss_DestroyerProtoAnimationScript+10   p  ; was: sub_FD32
                                        ; Boss_DestroyerProtoGraphicsCleanup+8   p ...
                bsr.w Stage22_GraphicsUpdate1
                movea.w #(dword_FF9A00-M68K_RAM),a0
                movea.w #(byte_FF9B00-M68K_RAM),a1
                moveq   #6,d7
loc_FD40:                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+1E   j
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                dbf     d7,loc_FD40
                move.w  (dword_FF9DAA).w,d0
                subi.w  #$20,d0 ; ' '
                move.w  d0,(word_FF9D94).w
                moveq   #$20,d0 ; ' '
                move.w  (dword_FF9DAA).w,d1
                asr.w   #1,d1
                sub.w   d1,d0
                move.w  d0,d2
                move.w  d0,d3
                addi.w  #$20,d2 ; ' '
                move.w  #$80,d5
                moveq   #$60,d6 ; '`'
                move.l  (dword_FF9D9E).w,d0
                asr.l   #1,d0
                move.l  (dword_FF9D96).w,d1
                add.l   d0,d1
                move.l  d1,(dword_FF9D96).w
                swap    d1
                movea.w #(byte_FF9B1E-M68K_RAM),a0
                movea.w #(byte_FF981E-M68K_RAM),a1
                moveq   #$17,d7
loc_FD94:                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+82   j
                move.w  d3,d0
                move.w  d2,d2
                bmi.s   loc_FD9E
                cmp.w   d5,d2
                bmi.s   loc_FDA0
loc_FD9E:                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+66   j
                move.w  d6,d0
loc_FDA0:                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+6A   j
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a1)+
                move.w  d1,(a1)+
                move.w  d1,(a1)+
                addq.w  #8,d2
                subq.w  #8,d6
                dbf     d7,loc_FD94
                cmpi.w  #$60,(dword_FF9D90).w ; '`'
                bpl.s   loc_FDE2
                move.w  (dword_FF9D90).w,d1
                bne.s   loc_FDCE
                move.l  #$FFFE0000,d0
                bra.s   loc_FDF4
; ---------------------------------------------------------------------------
loc_FDCE:                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+92   j
                move.l  #$6000,d0
                divu.w  d1,d0
                subi.w  #$100,d0
                ext.l   d0
                asl.l   #8,d0
                asl.l   #1,d0
                bra.s   loc_FDF4
; ---------------------------------------------------------------------------
loc_FDE2:                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+8C   j
                move.l  (dword_FF9D90).w,d0
                divu.w  #$3000,d0
                subi.w  #$200,d0
                neg.w   d0
                ext.l   d0
                asl.l   #7,d0
loc_FDF4:                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+9A   j
                                        ; Boss_DestroyerProtoRenderSegments+AE   j
                moveq   #0,d1
                move.w  (word_FF9D94).w,d1
                neg.w   d1
                swap    d1
                move.w  (word_FF9D94).w,d2
                andi.w  #$FFFE,d2
                addi.w  #$8E,d2
                addi.w  #-$6500,d2
                movea.w d2,a0
                move.w  (word_FF9D94).w,d2
                andi.w  #$FFFE,d2
                addi.w  #$8E,d2
                addi.w  #-$6800,d2
                movea.w d2,a2
                movea.w #(byte_FF9E0E-M68K_RAM),a1
                move.w  (word_FF9D94).w,d3
                neg.w   d3
                moveq   #8,d7
loc_FE2E:                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+108   j
                cmpa.w  #$9C00,a0
                bpl.s   locret_FE66
                move.w  d3,(a0)+
                move.w  (a1)+,d4
                move.w  d4,(a2)+
                dbf     d7,loc_FE2E
                movea.w #(word_FF9E40-M68K_RAM),a1
                move.w  (word_FF9D94).w,d2
                neg.w   d2
                move.w  #$9C00,d6
loc_FE4C:                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+132   j
                cmpa.w  d6,a0
                bpl.s   locret_FE66
                swap    d1
                move.w  d1,(a0)+
                move.w  d1,d3
                swap    d1
                add.l   d0,d1
                sub.w   d2,d3
                asl.w   #1,d3
                move.w  (a1,d3.w),(a2)+
                subq.w  #2,d2
                bra.s   loc_FE4C
; ---------------------------------------------------------------------------
locret_FE66:                            ; CODE XREF: Boss_DestroyerProtoRenderSegments+100   j
                                        ; Boss_DestroyerProtoRenderSegments+11C   j
                rts
; End of function Boss_DestroyerProtoRenderSegments
; Renders background
Boss_ShieldViperRenderBackground:                               ; CODE XREF: Boss_ShieldViperGraphicsInit+8   p  ; was: sub_FE68
                movea.w #(byte_FF9B80-M68K_RAM),a0
                movea.w a0,a1
                moveq   #$3F,d7 ; '?'
                move.w  (word_FF9DFE).w,d0
                addi.w  #-$7E2C,d0
loc_FE78:                               ; CODE XREF: Boss_ShieldViperRenderBackground+12   j
                move.w  d0,(a1)+
                dbf     d7,loc_FE78
                move.w  (word_FF9DFC).w,d0
                addi.w  #-$1800,d0
                addi.w  #$80,(word_FF9DFC).w
                addq.w  #1,(word_FF9DFE).w
                move.w  #$8F02,d3
                move.l  #$94009340,d4
                jmp     loc_1B78C
; End of function Boss_ShieldViperRenderBackground
; Attack state 3 handler
Boss_WolfGaropaAttackState3:                               ; CODE XREF: Boss_WolfGaropaTransition+28   p  ; was: sub_FEA0
                                        ; Boss_WolfGaropaPhaseInit+E   p
                movea.w #(byte_FFDB80-M68K_RAM),a0
                clr.w   $48(a0)
                move.w  #$D0,$10(a0)
                bsr.s Boss_WolfGaropaAttackState4
                movea.w #(word_FFDBE0-M68K_RAM),a0
                move.w  #1,$48(a0)
                move.w  #$170,$10(a0)
; End of function Boss_WolfGaropaAttackState3
; Attack state 4 handler
Boss_WolfGaropaAttackState4:                               ; CODE XREF: Boss_WolfGaropaAttackState3+E   p  ; was: sub_FEC0
                move.w  #$41C,(a0)
                clr.w   2(a0)
                move.b  #$80,$21(a0)
                move.b  #$10,$23(a0)
                move.l  #$40827E,$28(a0)
                rts
; End of function Boss_WolfGaropaAttackState4
; Palette update handler
Boss_WolfGaropaPaletteUpdate:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_FEDE
                move.b  #$80,$21(a5)
                move.w  #$F3E0,d0
                sub.w   (dword_FFA904).w,d0
                move.w  #$150,d1
                sub.w   d0,d1
                move.w  d1,$14(a5)
                tst.w   $48(a5)
                bne.s   locret_FF0E
                subi.w  #$20,d1 ; ' '
                cmp.w   (dword_FFA414).w,d1
                bpl.s   locret_FF0E
                move.w  d1,(dword_FFA414).w
                subq.w  #1,(dword_FFA414).w
locret_FF0E:                            ; CODE XREF: Boss_WolfGaropaPaletteUpdate+1C   j
                                        ; Boss_WolfGaropaPaletteUpdate+26   j
                rts
; End of function Boss_WolfGaropaPaletteUpdate
; Clears scroll animation timer at FFA960
Stage_ClearScrollAnimTimer:
                clr.w   (dword_FFA960).w  ; was: sub_FF10
                rts
; End of function Stage_ClearScrollAnimTimer
; Processes stage handler entry point
Stage_ProcessHandler:                               ; CODE XREF: Stage_LoadBackgroundGraphics:loc_1C530   j  ; was: sub_FF16
                                        ; Stage_XiTigerHandler+110   j ...
                tst.b   (byte_FF813E).w
                bpl.s   loc_FF1E
                rts
; ---------------------------------------------------------------------------
loc_FF1E:                               ; CODE XREF: Stage_ProcessHandler+4   j
                jsr Gfx_SetupScrollPlanes(pc)   ; (pc)
                nop
                movea.w #(word_FFA400-M68K_RAM),a5
                move.w  (word_FFA950).w,d0
                move.w  (word_FFA206).w,d1
                movea.l off_FF36(pc,d1.w),a0
                jmp     (a0)
; End of function Stage_ProcessHandler
; ---------------------------------------------------------------------------
off_FF36:       dc.l Stage_Dispatcher
                dc.l Stage_InitStage10
                dc.l Stage_Stage18Scroll
                dc.l Stage_TransitionInit
                dc.l Stage_Dispatcher


; Transitions stage to next phase or section
Stage_TransitionToNextPhase:                               ; CODE XREF: Stage_UpdateLogic+14   j  ; was: sub_FF4A
                                        ; Camera_AutoScrollCheck+10   j ...
                addq.w  #2,(word_FFA950).w
                move.w  #$56,(word_FF80C2).w ; 'V'
; Sets palette transition values when entering boss battle phase
Stage_SetBossTransitionPalette:                               ; CODE XREF: Stage_InitXiTigerBoss   p  ; was: loc_FF54
                move.w  (word_FFA204).w,d0
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
word_FF7E:      dc.w $7000, $7000       ; DATA XREF: Stage_TransitionToNextPhase+E   o
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
                dc.w $7000, $7000
word_FFD2:      dc.w $1E0, $1E0         ; DATA XREF: Stage_TransitionToNextPhase+14   o
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, 0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0
                dc.w $1E0, $1E0


; Loads Stage 18 tiles
Gfx_LoadStage18Tiles:                              ; CODE XREF: Stage_Stage18StartBattle+6   p  ; was: sub_10026
                                        ; sub_E4FC   p ...
                bsr.w Gfx_AccelerateScroll
loc_1002A:                              ; CODE XREF: Gfx_LoadDestroyerMK2Tiles+1A   j
                bsr.w Camera_Stage18Lock
                move.w  (dword_FFA900).w,d0
                addi.w  #$158,d0
                move.w  (dword_FFA904).w,d1
                lea     dword_11326(pc),a0
                nop
                bra.w   loc_10704
; End of function Gfx_LoadStage18Tiles
; Loads Destroyer-MK2 tiles
Gfx_LoadDestroyerMK2Tiles:                              ; CODE XREF: Stage_DestroyerMK2Init   p  ; was: sub_10044
                cmpi.w  #$91,(dword_FFA410).w
                bpl.s   loc_10056
                btst    #1,(byte_FFA407).w
                beq.s   loc_10056
                rts
; ---------------------------------------------------------------------------
loc_10056:                              ; CODE XREF: Gfx_LoadDestroyerMK2Tiles+6   j
                                        ; Gfx_LoadDestroyerMK2Tiles+E   j
                addi.l  #$10000,(dword_FFA900).w
                bra.s   loc_1002A
; End of function Gfx_LoadDestroyerMK2Tiles
; Updates scroll with player following
Gfx_UpdateScroll:                              ; CODE XREF: Stage_UpdateLogic:loc_C8C6   p  ; was: sub_10060
                                        ; sub_C92E   p ...
                bsr.w Gfx_AccelerateScroll
                bra.w Gfx_GetCameraPosition
; End of function Gfx_UpdateScroll
; Loads boss tile graphics into VRAM
Gfx_LoadBossTiles:                              ; CODE XREF: Stage_InitBossIntro   p  ; was: sub_10068
                                        ; sub_C944   p ...
                cmpi.w  #$91,(dword_FFA410).w
                bpl.s   loc_1007A
                btst    #1,(byte_FFA407).w
                beq.s   loc_1007A
                rts
; ---------------------------------------------------------------------------
loc_1007A:                              ; CODE XREF: Gfx_LoadBossTiles+6   j
                                        ; Gfx_LoadBossTiles+E   j
                addi.l  #$10000,(dword_FFA900).w
                bra.w Gfx_GetCameraPosition
; End of function Gfx_LoadBossTiles
; Updates camera position towards player
Camera_UpdateTowardsPlayer:                              ; CODE XREF: Camera_BossPhaseHandler:loc_C91A   p  ; was: sub_10086
                                        ; Camera_Stage2PhaseHandler+4   p ...
                btst    #5,(byte_FF8244).w
                bne.w   locret_1032C
                tst.w   (a5)
                beq.w   locret_1032C
                moveq   #0,d0
                move.l  (dword_FFA900).w,d6
                bra.w Camera_SmoothFollowPlayer
; End of function Camera_UpdateTowardsPlayer
; Smoothly follows player vertically with bounds
Camera_BoundedVerticalFollow:
                move.w  $10(a5),d0  ; was: sub_100A0
                subi.w  #$130,d0
                bmi.s   loc_100DA
                swap    d0
                asr.l   #4,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_100BC
                move.l  #$60000,d0
loc_100BC:                              ; CODE XREF: Camera_BoundedVerticalFollow+14   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA974).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_100D2
                bmi.s   loc_100D2
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_100D2:                              ; CODE XREF: Camera_BoundedVerticalFollow+28   j
                                        ; Camera_BoundedVerticalFollow+2A   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
locret_100D8:                           ; CODE XREF: Camera_BoundedVerticalFollow+42   j
                rts
; ---------------------------------------------------------------------------
loc_100DA:                              ; CODE XREF: Camera_BoundedVerticalFollow+8   j
                move.w  $10(a5),d0
                subi.w  #$110,d0
                bpl.s   locret_100D8
                swap    d0
                asr.l   #4,d0
                cmpi.l  #$FFFA0000,d0
                bpl.s   loc_100F6
                move.l  #$FFFA0000,d0
loc_100F6:                              ; CODE XREF: Camera_BoundedVerticalFollow+4E   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA970).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_1010C
                bpl.s   loc_1010C
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_1010C:                              ; CODE XREF: Camera_BoundedVerticalFollow+62   j
                                        ; Camera_BoundedVerticalFollow+64   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
                rts
; End of function Camera_BoundedVerticalFollow
; Smoothly follows player with speed limits
Camera_SmoothFollowPlayer:                              ; CODE XREF: Camera_UpdateTowardsPlayer+16   j  ; was: sub_10114
                moveq   #3,d1
                btst    #3,$E(a5)
                beq.s   loc_1015C
                move.w  #$C8,d0
                sub.w   $10(a5),d0
                bpl.s   loc_10168
                moveq   #4,d1
loc_1012A:                              ; CODE XREF: Camera_SmoothFollowPlayer+50   j
                neg.w   d0
                swap    d0
                asr.l   d1,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_1013E
                move.l  #$60000,d0
loc_1013E:                              ; CODE XREF: Camera_SmoothFollowPlayer+22   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA974).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_10154
                bmi.s   loc_10154
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_10154:                              ; CODE XREF: Camera_SmoothFollowPlayer+36   j
                                        ; Camera_SmoothFollowPlayer+38   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_1015C:                              ; CODE XREF: Camera_SmoothFollowPlayer+8   j
                move.w  #$178,d0
                sub.w   $10(a5),d0
                bmi.s   loc_1012A
                moveq   #4,d1
loc_10168:                              ; CODE XREF: Camera_SmoothFollowPlayer+12   j
                neg.w   d0
                swap    d0
                asr.l   d1,d0
                cmpi.l  #$FFFA0000,d0
                bpl.s   loc_1017C
                move.l  #$FFFA0000,d0
loc_1017C:                              ; CODE XREF: Camera_SmoothFollowPlayer+60   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA970).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_10192
                bpl.s   loc_10192
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_10192:                              ; CODE XREF: Camera_SmoothFollowPlayer+74   j
                                        ; Camera_SmoothFollowPlayer+76   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
                rts
; End of function Camera_SmoothFollowPlayer
; Constrains camera to screen bounds
Camera_ConstrainToScreenBounds:                              ; CODE XREF: Stage_ViblackScroll+1E   j  ; was: sub_1019A
                                        ; sub_DF8E   j ...
                btst    #5,(byte_FF8244).w
                bne.w   locret_1032C
                tst.w   (a5)
                beq.w   locret_1032C
                moveq   #0,d0
                move.l  (dword_FFA900).w,d6
                moveq   #3,d1
                btst    #3,$E(a5)
                beq.s   loc_101F8
                move.w  #$120,d0
                sub.w   $10(a5),d0
                bpl.s   loc_10204
                moveq   #4,d1
loc_101C6:                              ; CODE XREF: Camera_ConstrainToScreenBounds+66   j
                neg.w   d0
                swap    d0
                asr.l   d1,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_101DA
                move.l  #$60000,d0
loc_101DA:                              ; CODE XREF: Camera_ConstrainToScreenBounds+38   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA974).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_101F0
                bmi.s   loc_101F0
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_101F0:                              ; CODE XREF: Camera_ConstrainToScreenBounds+4C   j
                                        ; Camera_ConstrainToScreenBounds+4E   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_101F8:                              ; CODE XREF: Camera_ConstrainToScreenBounds+1E   j
                move.w  #$120,d0
                sub.w   $10(a5),d0
                bmi.s   loc_101C6
                moveq   #4,d1
loc_10204:                              ; CODE XREF: Camera_ConstrainToScreenBounds+28   j
                neg.w   d0
                swap    d0
                asr.l   d1,d0
                cmpi.l  #$FFFA0000,d0
                bpl.s   loc_10218
                move.l  #$FFFA0000,d0
loc_10218:                              ; CODE XREF: Camera_ConstrainToScreenBounds+76   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA970).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_1022E
                bpl.s   loc_1022E
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_1022E:                              ; CODE XREF: Camera_ConstrainToScreenBounds+8A   j
                                        ; Camera_ConstrainToScreenBounds+8C   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
                rts
; End of function Camera_ConstrainToScreenBounds
; Adjusts camera based on player state flags
Camera_AdjustForPlayerState:
                btst    #5,(byte_FF8244).w  ; was: sub_10236
                bne.w   locret_1032C
                tst.w   (a5)
                beq.s   locret_10272
                moveq   #0,d0
                move.b  $69(a5),d0
                btst    #2,d0
                beq.s   loc_10256
                btst    #4,d0
                bne.s   loc_10274
loc_10256:                              ; CODE XREF: Camera_AdjustForPlayerState+18   j
                move.w  $10(a5),d0
                subi.w  #$130,d0
                bpl.s   locret_10272
                swap    d0
                asr.l   #3,d0
loc_10264:                              ; CODE XREF: Camera_AdjustForPlayerState+4E   j
                cmp.l   (dword_FFA930).w,d0
                bpl.s   loc_1026E
                move.l  (dword_FFA930).w,d0
loc_1026E:                              ; CODE XREF: Camera_AdjustForPlayerState+32   j
                add.l   d0,(dword_FFA900).w
locret_10272:                           ; CODE XREF: Camera_AdjustForPlayerState+C   j
                                        ; Camera_AdjustForPlayerState+28   j ...
                rts
; ---------------------------------------------------------------------------
loc_10274:                              ; CODE XREF: Camera_AdjustForPlayerState+1E   j
                move.w  #$160,d0
                sub.w   $10(a5),d0
                bmi.s   locret_10272
                neg.w   d0
                swap    d0
                asr.l   #5,d0
                bra.s   loc_10264
; End of function Camera_AdjustForPlayerState
; Applies scroll acceleration with boundary checking
Scroll_ApplyAcceleration:                              ; CODE XREF: Stage_InitStage8Train:loc_CEB8   p  ; was: sub_10286
                bsr.w Gfx_AccelerateScroll
loc_1028A:                              ; CODE XREF: Scroll_IncrementHorizontalFast+8   j
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                move.w  (dword_FFA900).w,d0
                addi.w  #$158,d0
                move.w  #$F700,d1
                lea     dword_11346(pc),a0
                nop
                jmp     loc_10704(pc)   ; (pc)
; End of function Scroll_ApplyAcceleration
; No operation placeholder routine
Scroll_NoOp1:
                nop  ; was: sub_102AC
; End of function Scroll_NoOp1
; Increments horizontal scroll by 65536 fixed point
Scroll_IncrementHorizontalFast:                              ; CODE XREF: Stage_TrainToFlyingNeoTransition   p  ; was: sub_102AE
                addi.l  #$10000,(dword_FFA900).w
                bra.s   loc_1028A
; End of function Scroll_IncrementHorizontalFast
; Updates camera scroll positions with offset calculation
Scroll_UpdateCameraPositions:                              ; CODE XREF: Stage_FlyingNeoVerticalScroll+2A   p  ; was: sub_102B8
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                move.w  (dword_FFA900).w,d0
                subi.w  #$60,d0 ; '`'
                move.w  (dword_FFA904).w,d1
                addi.w  #-$910,d1
                lea     dword_11346(pc),a0
                nop
                jmp     loc_109E0(pc)   ; (pc)
; End of function Scroll_UpdateCameraPositions
; No operation placeholder routine
Scroll_NoOp2:
                nop  ; was: sub_102DE
; End of function Scroll_NoOp2
; Calculates scroll position from camera
Gfx_CalculateScrollPosition:                              ; CODE XREF: Stage_UpdateLogic+8   p  ; was: sub_102E0
                                        ; Stage_InitBossIntro+4   p ...
                move.w  (dword_FFA900).w,d0
                asr.w   #2,d0
                move.w  d0,(dword_FFA908).w
                rts
; End of function Gfx_CalculateScrollPosition
; Adds scroll delta to main scroll position
Scroll_AddDeltaToScroll:                              ; CODE XREF: Stage_Stage10CheckTransition+4   p  ; was: sub_102EC
                                        ; Stage_DeepStriderTransition+4   p ...
                moveq   #0,d0
                move.w  (dword_FFA910).w,d0
                swap    d0
                asr.l   #2,d0
                add.l   d0,(dword_FFA908).w
                rts
; End of function Scroll_AddDeltaToScroll
; Accelerates scroll based on player position
Gfx_AccelerateScroll:                              ; CODE XREF: Gfx_LoadStage18Tiles   p  ; was: sub_102FC
                                        ; sub_10060   p ...
                btst    #5,(byte_FF8244).w
                bne.w   locret_1032C
                tst.w   (a5)
                beq.s   locret_1032C
                moveq   #0,d0
                move.w  $10(a5),d0
                subi.w  #$F0,d0
                bmi.s   locret_1032C
                swap    d0
                asr.l   #3,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_10328
                move.l  #$60000,d0
loc_10328:                              ; CODE XREF: Gfx_AccelerateScroll+24   j
                add.l   d0,(dword_FFA900).w
locret_1032C:                           ; CODE XREF: Camera_UpdateTowardsPlayer+6   j
                                        ; Camera_UpdateTowardsPlayer+C   j ...
                rts
; End of function Gfx_AccelerateScroll
; Follows player when right of screen center
Camera_RightEdgeFollow:
                move.w  #$C0,d0  ; was: sub_1032E
                sub.w   $10(a5),d0
                bpl.s   locret_1032C
                neg.w   d0
                swap    d0
                asr.l   #5,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_1034C
                move.l  #$60000,d0
loc_1034C:                              ; CODE XREF: Camera_RightEdgeFollow+16   j
                add.l   d0,(dword_FFA900).w
                rts
; End of function Camera_RightEdgeFollow
; Updates scroll state and renders Sylpheed
Scroll_RenderSylpheedWithUpdate:                              ; CODE XREF: Stage_ScrollCheckTransition   p  ; was: sub_10352
                bsr.w Camera_VerticalBoundaryFollow
                bra.w Gfx_RenderSylpheedBackground
; End of function Scroll_RenderSylpheedWithUpdate
; Updates vertical scroll
Scroll_UpdateVerticalScroll:                              ; CODE XREF: Stage_SunsetStingTransition   p  ; was: sub_1035A
                                        ; Stage_ViblackScroll+14   p
                addi.l  #$8000,(dword_FFA904).w
                bra.w Gfx_RenderSylpheedBackground
; End of function Scroll_UpdateVerticalScroll
; Follows player vertically when below screen
Camera_VerticalBoundaryFollow:                              ; CODE XREF: Scroll_RenderSylpheedWithUpdate   p  ; was: sub_10366
                tst.w   (a5)
                beq.s   locret_1038E
                moveq   #0,d0
                move.w  $14(a5),d0
                subi.w  #$108,d0
                bpl.s   locret_1038E
                neg.w   d0
                swap    d0
                asr.l   #3,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_1038A
                move.l  #$60000,d0
loc_1038A:                              ; CODE XREF: Camera_VerticalBoundaryFollow+1C   j
                add.l   d0,(dword_FFA904).w
locret_1038E:                           ; CODE XREF: Camera_VerticalBoundaryFollow+2   j
                                        ; Camera_VerticalBoundaryFollow+E   j
                rts
; End of function Camera_VerticalBoundaryFollow
; Initializes stage transition state with cutscene parameters
Stage_InitTransitionState:                              ; CODE XREF: Stage_CheckTransitionReady+16   j  ; was: sub_10390
                                        ; Stage_WaitAndTransition+1C   j ...
                move.w  #3,(word_FF8230).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                bra.w   loc_103C0
; End of function Stage_InitTransitionState
; Initializes transition between stage sections
Stage_InitSectionChange:                              ; CODE XREF: Camera_Stage2PhaseHandler   p  ; was: sub_103B0
                                        ; sub_C98E   p ...
                tst.w   (word_FF80C2).w
                bne.s   locret_103D2
                addq.w  #2,(word_FFA950).w
                move.w  #$50,(word_FF80C2).w ; 'P'
loc_103C0:                              ; CODE XREF: Stage_InitTransitionState+1C   j
                clr.w   (word_FF820C).w
                addq.w  #2,(word_FFA204).w
                bclr    #7,(dword_FFA20E).w
                clr.b   (byte_FFA209).w
locret_103D2:                           ; CODE XREF: Stage_InitSectionChange+4   j
                rts
; End of function Stage_InitSectionChange
; Initializes score display timer to 0x5C
UI_InitScoreTimer:                              ; CODE XREF: Camera_AntroidBossInit+A   p  ; was: sub_103D4
                                        ; Stage_InitPostBoss+12   p ...
                move.w  #$5C,(word_FF80C2).w ; '\'
                bra.s   loc_103E2
; End of function UI_InitScoreTimer
; Triggers transition to next stage phase
Stage_TriggerPhaseTransition:                              ; CODE XREF: Camera_BossPhaseHandler+6   p  ; was: sub_103DC
                                        ; Stage_PostJokerBoss+A   p ...
                move.w  #$2E,(word_FF80C2).w ; '.'
loc_103E2:                              ; CODE XREF: UI_InitScoreTimer+6   j
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA209).w
                addq.w  #2,(word_FFA204).w
                jsr (Stage_StateDispatcher).l
                subq.w  #2,(word_FFA204).w
                rts
; End of function Stage_TriggerPhaseTransition
; Sets up VDP scroll plane registers
Gfx_SetupScrollPlanes:                              ; CODE XREF: Gfx_ClearPlanesAndInit+8A   p  ; was: sub_103FA
                                        ; Sys_StoryScreenMainLoop+56   p ...
                move.w  #$8230,(word_FFF7D4).w
                move.w  #$8407,(word_FFF7D8).w
                tst.w   (word_FF8640).w
                beq.s   loc_10418
                move.w  #$8238,(word_FFF7D4).w
                move.w  #$8406,(word_FFF7D8).w
loc_10418:                              ; CODE XREF: Gfx_SetupScrollPlanes+10   j
                move.b  (word_FFF7E6+1).w,d3
                move.b  d3,d4
                andi.w  #3,d3
                andi.w  #4,d4
                move.b  (byte_FFA95A).w,d5
                movea.w #(word_FFE400-M68K_RAM),a0
                movea.w #(word_FFE480-M68K_RAM),a1
                adda.w  (word_FF8640).w,a0
                adda.w  (word_FF8640).w,a1
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                move.w  (word_FFA012).w,d1
                bsr.w Gfx_WriteScrollValue
                movea.w #(word_FFEC00-M68K_RAM),a0
                adda.w  (word_FF8640).w,a0
                move.w  (dword_FFA904).w,d0
                neg.w   d0
                add.w   (word_FFA012).w,d0
                bsr.w Gfx_WriteScrollValues
                move.b  (byte_FFA95B).w,d5
                movea.w #(word_FFE402-M68K_RAM),a0
                movea.w #(byte_FFE482-M68K_RAM),a1
                suba.w  (word_FF8640).w,a0
                suba.w  (word_FF8640).w,a1
                move.w  (dword_FFA908).w,d0
                neg.w   d0
                move.w  (word_FFA016).w,d1
                bsr.w Gfx_WriteScrollValue
                movea.w #(word_FFEC02-M68K_RAM),a0
                suba.w  (word_FF8640).w,a0
                move.w  (dword_FFA90C).w,d0
                neg.w   d0
                add.w   (word_FFA016).w,d0
                bra.w Gfx_WriteScrollValues
; End of function Gfx_SetupScrollPlanes
; Writes scroll value with flag checks
Gfx_WriteScrollValue:                              ; CODE XREF: Gfx_SetupScrollPlanes+4A   p  ; was: sub_10496
                                        ; Gfx_SetupScrollPlanes+82   p
                btst    #2,d5
                bne.w   loc_104CA
                btst    #4,d5
                bne.w   loc_105CE
                btst    #0,d5
                bne.s   locret_104AE
                move.w  d0,(a0)
locret_104AE:                           ; CODE XREF: Gfx_WriteScrollValue+14   j
                rts
; End of function Gfx_WriteScrollValue
; Writes scroll values to VRAM with various modes
Gfx_WriteScrollValues:                              ; CODE XREF: Gfx_SetupScrollPlanes+60   p  ; was: sub_104B0
                                        ; Gfx_SetupScrollPlanes+98   j
                btst    #3,d5
                bne.w   loc_10664
                btst    #5,d5
                bne.w   loc_106B4
                btst    #1,d5
                bne.s   locret_104C8
                move.w  d0,(a0)
locret_104C8:                           ; CODE XREF: Gfx_WriteScrollValues+14   j
                rts
; ---------------------------------------------------------------------------
loc_104CA:                              ; CODE XREF: Gfx_WriteScrollValue+4   j
                cmpi.b  #2,d3
                beq.w   loc_1055E
                move.w  #6,d7
loc_104D6:                              ; CODE XREF: Gfx_WriteScrollValues+A8   j
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                move.w  d0,$10(a0)
                move.w  d0,$14(a0)
                move.w  d0,$18(a0)
                move.w  d0,$1C(a0)
                move.w  d0,$20(a0)
                move.w  d0,$24(a0)
                move.w  d0,$28(a0)
                move.w  d0,$2C(a0)
                move.w  d0,$30(a0)
                move.w  d0,$34(a0)
                move.w  d0,$38(a0)
                move.w  d0,$3C(a0)
                move.w  d0,$40(a0)
                move.w  d0,$44(a0)
                move.w  d0,$48(a0)
                move.w  d0,$4C(a0)
                move.w  d0,$50(a0)
                move.w  d0,$54(a0)
                move.w  d0,$58(a0)
                move.w  d0,$5C(a0)
                move.w  d0,$60(a0)
                move.w  d0,$64(a0)
                move.w  d0,$68(a0)
                move.w  d0,$6C(a0)
                move.w  d0,$70(a0)
                move.w  d0,$74(a0)
                move.w  d0,$78(a0)
                move.w  d0,$7C(a0)
                lea     $80(a0),a0
                dbf     d7,loc_104D6
                rts
; ---------------------------------------------------------------------------
loc_1055E:                              ; CODE XREF: Gfx_WriteScrollValues+1E   j
                move.w  d0,(a0)
                move.w  d0,$20(a0)
                move.w  d0,$40(a0)
                move.w  d0,$60(a0)
                move.w  d0,$80(a0)
                move.w  d0,$A0(a0)
                move.w  d0,$C0(a0)
                move.w  d0,$E0(a0)
                move.w  d0,$100(a0)
                move.w  d0,$120(a0)
                move.w  d0,$140(a0)
                move.w  d0,$160(a0)
                move.w  d0,$180(a0)
                move.w  d0,$1A0(a0)
                move.w  d0,$1C0(a0)
                move.w  d0,$1E0(a0)
                move.w  d0,$200(a0)
                move.w  d0,$220(a0)
                move.w  d0,$240(a0)
                move.w  d0,$260(a0)
                move.w  d0,$280(a0)
                move.w  d0,$2A0(a0)
                move.w  d0,$2C0(a0)
                move.w  d0,$2E0(a0)
                move.w  d0,$300(a0)
                move.w  d0,$320(a0)
                move.w  d0,$340(a0)
                move.w  d0,$360(a0)
                rts
; ---------------------------------------------------------------------------
loc_105CE:                              ; CODE XREF: Gfx_WriteScrollValue+C   j
                movea.w #(byte_FF8800-M68K_RAM),a2
                moveq   #0,d0
                cmpi.b  #2,d3
                beq.s   loc_10600
                move.w  d1,d0
                move.w  #$BF,d7
                move.w  d0,d6
                bmi.s   loc_105E6
                clr.w   d6
loc_105E6:                              ; CODE XREF: Gfx_WriteScrollValues+132   j
                asl.w   #1,d0
                adda.l  d0,a2
loc_105EA:                              ; CODE XREF: Gfx_WriteScrollValues+13E   j
                move.w  (a2)+,(a1)
                addq.w  #4,a1
                dbf     d7,loc_105EA
                move.w  -2(a2),d0
loc_105F6:                              ; CODE XREF: Gfx_WriteScrollValues+14A   j
                move.w  d0,(a1)
                addq.w  #4,a1
                dbf     d6,loc_105F6
                rts
; ---------------------------------------------------------------------------
loc_10600:                              ; CODE XREF: Gfx_WriteScrollValues+128   j
                moveq   #$20,d0 ; ' '
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                rts
; ---------------------------------------------------------------------------
loc_10664:                              ; CODE XREF: Gfx_WriteScrollValues+4   j
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                move.w  d0,$10(a0)
                move.w  d0,$14(a0)
                move.w  d0,$18(a0)
                move.w  d0,$1C(a0)
                move.w  d0,$20(a0)
                move.w  d0,$24(a0)
                move.w  d0,$28(a0)
                move.w  d0,$2C(a0)
                move.w  d0,$30(a0)
                move.w  d0,$34(a0)
                move.w  d0,$38(a0)
                move.w  d0,$3C(a0)
                move.w  d0,$40(a0)
                move.w  d0,$44(a0)
                move.w  d0,$48(a0)
                move.w  d0,$4C(a0)
                rts
; ---------------------------------------------------------------------------
loc_106B4:                              ; CODE XREF: Gfx_WriteScrollValues+C   j
                movea.w #(dword_FF8A00-M68K_RAM),a2
                move.w  #$13,d7
loc_106BC:                              ; CODE XREF: Gfx_WriteScrollValues+210   j
                move.w  (a2)+,(a0)
                addq.w  #4,a0
                dbf     d7,loc_106BC
                rts
; End of function Gfx_WriteScrollValues
; Initializes scroll buffer with value 8
Gfx_InitScrollBuffer:
                lea     (word_FFA400).w,a5  ; was: sub_106C6
                move.w  #8,(a5)
                rts
; End of function Gfx_InitScrollBuffer
; Calculates scroll offsets using camera position
Scroll_CalculateOffsets1:
                move.w  (dword_FFA908).w,d0  ; was: sub_106D0
                addi.w  #$180,d0
                move.w  (dword_FFA90C).w,d1
                lea     dword_11336(pc),a0
                nop
                bra.s   loc_10704
; End of function Scroll_CalculateOffsets1
; Renders tilemap with adjusted camera position
Scroll_RenderTilemapAdjusted:
                move.w  (dword_FFA900).w,d0  ; was: sub_106E4
                subi.w  #$58,d0 ; 'X'
                move.w  (dword_FFA904).w,d1
                bra.s Gfx_RenderTilemap
; End of function Scroll_RenderTilemapAdjusted
; Gets camera position for rendering
Gfx_GetCameraPosition:                              ; CODE XREF: Stage_InitTerobusterBoss+1E   p  ; was: sub_106F2
                                        ; Gfx_UpdateScroll+4   j ...
                move.w  (dword_FFA900).w,d0
                addi.w  #$158,d0
                move.w  (dword_FFA904).w,d1
; End of function Gfx_GetCameraPosition
; Renders tilemap tiles to VRAM planes
Gfx_RenderTilemap:                              ; CODE XREF: Stage_TeleportFadeSequence+4A   j  ; was: sub_106FE
                                        ; Stage_MedusaCamera+46   p ...
                lea     dword_11316(pc),a0
                nop
loc_10704:                              ; CODE XREF: Stage_CaterpillarShipMovement+52   p
                                        ; Gfx_LoadStage18Tiles+1A   j ...
                neg.w   d1
                moveq   #8,d7
                move.w  d0,d2
                lsr.w   #8,d2
                move.w  d2,(dword_FF8058).w
                move.w  d0,d2
                lsr.w   #5,d2
                andi.w  #7,d2
                move.w  d2,(dword_FF8058+2).w
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #6,d2
                move.w  d2,(word_FF805C).w
                moveq   #$FFFFFFFF,d2
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #$7E,d2 ; '~'
                move.l  d2,(dword_FF805E).w
loc_10736:                              ; CODE XREF: Gfx_RenderTilemap+17E   j
                movea.l (a0)+,a1
                move.w  (dword_FF8058).w,d2
                move.w  d1,d3
                lsr.w   #3,d3
                andi.w  #$3E0,d3
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  (dword_FF8058+2).w,d2
                move.w  d1,d3
                lsr.w   #2,d3
                andi.w  #$38,d3 ; '8'
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                tst.w   d7
                bne.w   loc_1081E
                subi.w  #$100,d1
                move.w  d1,d2
                move.w  (word_FFF70E).w,d3
                lsr.w   #2,d2
                andi.w  #$38,d2 ; '8'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  (word_FF805C).w,d3
                add.w   d4,d3
                move.w  d1,d2
                andi.w  #$18,d2
                move.w  d2,d5
                subq.w  #8,d2
                bmi.s   loc_107AA
                move.w  (a1,d3.w),(a2)+
                subq.w  #8,d2
                bmi.s   loc_107AA
                move.w  8(a1,d3.w),(a2)+
                subq.w  #8,d2
                bmi.s   loc_107AA
                move.w  $10(a1,d3.w),(a2)+
loc_107AA:                              ; CODE XREF: Gfx_RenderTilemap+96   j
                                        ; Gfx_RenderTilemap+9E   j ...
                tst.w   (a0)+
                beq.s   loc_107DA
                move.l  (dword_FF805E).w,d2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1E00,d4
                add.w   d4,d2
                movea.l d2,a2
                subq.w  #8,d5
                bmi.s   loc_107DA
                move.w  (a1,d3.w),(a2)
                subq.w  #8,d5
                bmi.s   loc_107DA
                move.w  8(a1,d3.w),$80(a2)
                subq.w  #8,d5
                bmi.s   loc_107DA
                move.w  $10(a1,d3.w),$100(a2)
loc_107DA:                              ; CODE XREF: Gfx_RenderTilemap+AE   j
                                        ; Gfx_RenderTilemap+C2   j ...
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #$7E,d2 ; '~'
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                add.w   (a0),d2
                move.w  d2,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F80977F,-(a1)
                move.l  #$94009320,-(a1)
                move.w  a1,(word_FFF70C).w
                addi.w  #$40,(word_FFF70E).w ; '@'
                rts
; ---------------------------------------------------------------------------
loc_1081E:                              ; CODE XREF: Gfx_RenderTilemap+6C   j
                move.w  d1,d2
                move.w  (word_FFF70E).w,d3
                lsr.w   #2,d2
                andi.w  #$38,d2 ; '8'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  (word_FF805C).w,d3
                add.w   d4,d3
                move.w  (a1,d3.w),(a2)+
                move.w  8(a1,d3.w),(a2)+
                move.w  $10(a1,d3.w),(a2)+
                move.w  $18(a1,d3.w),(a2)+
                tst.w   (a0)+
                beq.w   loc_10872
                move.l  (dword_FF805E).w,d2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1E00,d4
                add.w   d4,d2
                movea.l d2,a2
                move.w  (a1,d3.w),(a2)
                move.w  8(a1,d3.w),$80(a2)
                move.w  $10(a1,d3.w),$100(a2)
                move.w  $18(a1,d3.w),$180(a2)
loc_10872:                              ; CODE XREF: Gfx_RenderTilemap+14A   j
                suba.l  #$E,a0
                addi.w  #$20,d1 ; ' '
                dbf     d7,loc_10736
                rts
; End of function Gfx_RenderTilemap
; Renders tilemap with vertical offset adjustment
Scroll_RenderTilemapVertOffset:
                move.w  (dword_FFA900).w,d0  ; was: sub_10882
                subi.w  #$58,d0 ; 'X'
                move.w  (dword_FFA904).w,d1
                subi.w  #$1000,d1
                bra.s   loc_108A4
; End of function Scroll_RenderTilemapVertOffset
; Camera lock for boss battle
Camera_Stage18Lock:                              ; CODE XREF: Gfx_LoadStage18Tiles:loc_1002A   p  ; was: sub_10894
                move.w  (dword_FFA900).w,d0
                addi.w  #$158,d0
                move.w  (dword_FFA904).w,d1
                subi.w  #$1000,d1
loc_108A4:                              ; CODE XREF: Stage_MedusaCamera+62   p
                                        ; Scroll_RenderTilemapVertOffset+10   j
                lea     dword_11326(pc),a0
                nop
                neg.w   d1
                moveq   #8,d7
                move.w  d0,d2
                lsr.w   #8,d2
                move.w  d2,(dword_FF8058).w
                move.w  d0,d2
                lsr.w   #5,d2
                andi.w  #7,d2
                move.w  d2,(dword_FF8058+2).w
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #6,d2
                move.w  d2,(word_FF805C).w
                moveq   #$FFFFFFFF,d2
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #$7E,d2 ; '~'
                move.l  d2,(dword_FF805E).w
loc_108DC:                              ; CODE XREF: Camera_Stage18Lock+10E   j
                movea.l (a0)+,a1
                move.w  (dword_FF8058).w,d2
                move.w  d1,d3
                lsr.w   #3,d3
                andi.w  #$3E0,d3
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  (dword_FF8058+2).w,d2
                move.w  d1,d3
                lsr.w   #2,d3
                andi.w  #$38,d3 ; '8'
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                tst.w   d7
                bne.w   loc_10968
                subi.w  #$100,d1
                move.w  d1,d2
                move.w  (word_FFF70E).w,d3
                lsr.w   #2,d2
                andi.w  #$38,d2 ; '8'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  (word_FF805C).w,d3
                add.w   d4,d3
                move.w  d1,d2
                andi.w  #$18,d2
                move.w  d2,d5
                tst.w   (a0)+
                move.l  (dword_FF805E).w,d2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1E00,d4
                add.w   d4,d2
                movea.l d2,a2
                subq.w  #8,d5
                bmi.s   locret_10966
                move.w  (a1,d3.w),(a2)
                subq.w  #8,d5
                bmi.s   locret_10966
                move.w  8(a1,d3.w),$80(a2)
                subq.w  #8,d5
                bmi.s   locret_10966
                move.w  $10(a1,d3.w),$100(a2)
locret_10966:                           ; CODE XREF: Camera_Stage18Lock+B8   j
                                        ; Camera_Stage18Lock+C0   j ...
                rts
; ---------------------------------------------------------------------------
loc_10968:                              ; CODE XREF: Camera_Stage18Lock+7C   j
                movea.l (a0)+,a1
                move.w  (word_FF805C).w,d3
                add.w   d4,d3
                tst.w   (a0)+
                move.l  (dword_FF805E).w,d2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1E00,d4
                add.w   d4,d2
                movea.l d2,a2
                move.w  (a1,d3.w),(a2)
                move.w  8(a1,d3.w),$80(a2)
                move.w  $10(a1,d3.w),$100(a2)
                move.w  $18(a1,d3.w),$180(a2)
                suba.l  #$E,a0
                addi.w  #$20,d1 ; ' '
                dbf     d7,loc_108DC
                rts
; End of function Camera_Stage18Lock
; Calculates scroll offsets with different camera
Scroll_CalculateOffsets2:
                move.w  (dword_FFA908).w,d0  ; was: sub_109A8
                subi.w  #$60,d0 ; '`'
                move.w  (dword_FFA90C).w,d1
                lea     dword_11336(pc),a0
                nop
                bra.s   loc_109E0
; End of function Scroll_CalculateOffsets2
; Adjusts camera position for Stage 21
Scroll_Stage21CameraOffset:
                move.w  (dword_FFA900).w,d0  ; was: sub_109BC
                subi.w  #$60,d0 ; '`'
                move.w  (dword_FFA904).w,d1
                subi.w  #$F8,d1
                bra.s   loc_109DA
; End of function Scroll_Stage21CameraOffset
; Renders multi-layer Sylpheed stage background using tile lookups
Gfx_RenderSylpheedBackground:                              ; CODE XREF: Stage_Stage17Transition+24   p  ; was: sub_109CE
                                        ; Scroll_RenderSylpheedWithUpdate+4   j ...
                move.w  (dword_FFA900).w,d0
                subi.w  #$60,d0 ; '`'
                move.w  (dword_FFA904).w,d1
loc_109DA:                              ; CODE XREF: Scroll_Stage21CameraOffset+10   j
                lea     dword_11316(pc),a0
                nop
loc_109E0:                              ; CODE XREF: Stage_SylpheedCameraLock+4A   j
                                        ; Gfx_LoadSylpheedTiles+20   j ...
                neg.w   d1
                moveq   #$F,d7
                move.w  d1,d2
                lsr.w   #3,d2
                andi.w  #$3E0,d2
                move.w  d2,(dword_FF8058).w
                move.w  d1,d2
                lsr.w   #2,d2
                andi.w  #$38,d2 ; '8'
                move.w  d2,(dword_FF8058+2).w
                move.w  d1,d2
                andi.w  #$18,d2
                move.w  d2,(word_FF805C).w
                moveq   #$FFFFFFFF,d2
                move.w  d1,d2
                lsl.w   #4,d2
                andi.w  #$1F80,d2
                move.l  d2,(dword_FF805E).w
loc_10A14:                              ; CODE XREF: Gfx_RenderSylpheedBackground+C4   j
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  (dword_FF8058).w,d3
                lsr.w   #8,d2
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  (dword_FF8058+2).w,d3
                lsr.w   #5,d2
                andi.w  #7,d2
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                move.w  d0,d2
                move.w  (word_FFF70E).w,d3
                lsr.w   #2,d2
                andi.w  #$78,d2 ; 'x'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  (word_FF805C).w,d3
                add.w   d4,d3
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
                tst.w   (a0)+
                beq.w   loc_10A88
                move.l  (dword_FF805E).w,d4
                add.w   d4,d2
                movea.l d2,a2
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
loc_10A88:                              ; CODE XREF: Gfx_RenderSylpheedBackground+9E   j
                suba.l  #$E,a0
                addi.w  #$20,d0 ; ' '
                dbf     d7,loc_10A14
                move.w  d1,d2
                lsl.w   #4,d2
                andi.w  #$F80,d2
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                add.w   $E(a0),d2
                move.w  d2,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009340,-(a1)
                move.w  a1,(word_FFF70C).w
                addi.w  #$80,(word_FFF70E).w
                rts
; End of function Gfx_RenderSylpheedBackground
; Gets background scroll position
Scroll_GetBackgroundPosition:                              ; CODE XREF: Cutscene_XiTigerScrollSetup+72   j  ; was: sub_10ADC
                move.w  (dword_FFA908).w,d0
                move.w  (dword_FFA90C).w,d1
; End of function Scroll_GetBackgroundPosition
; Loads pointer to data table 1
Data_LoadPointerTable1:                              ; CODE XREF: UI_InitializeResultsScreen+50   p  ; was: sub_10AE4
                lea     dword_11336(pc),a0
                nop
                bra.s Gfx_DirectVRAMTransfer
; End of function Data_LoadPointerTable1
; Gets foreground scroll position
Scroll_GetForegroundPosition:                              ; CODE XREF: Cutscene_XiTigerScrollSetup+66   p  ; was: sub_10AEC
                                        ; Stage_InitPlayerAndScroll+3C   p
                move.w  (dword_FFA900).w,d0
                move.w  (dword_FFA904).w,d1
; End of function Scroll_GetForegroundPosition
; Loads pointer to data table 2
Data_LoadPointerTable2:                              ; CODE XREF: Sys_InitOptionsMenuState+50   p  ; was: sub_10AF4
                                        ; UI_InitPasswordScreen+5A   p ...
                lea     dword_11316(pc),a0
                nop
; End of function Data_LoadPointerTable2
; Performs direct VRAM transfer with Z80 bus control and DMA setup
Gfx_DirectVRAMTransfer:                              ; CODE XREF: Cutscene_InitCreditsScreen+58   p  ; was: sub_10AFA
                                        ; UI_InitTitleScreen+90   p ...
                move    sr,-(sp)
                move    #$2700,sr
loc_10B00:                              ; CODE XREF: Gfx_DirectVRAMTransfer+E   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_10B00
                lea     (VDP_CTRL).l,a4
                move.w  (word_FFF7D2).w,d2
                bset    #4,d2
                move.w  d2,(a4)
                neg.w   d1
                moveq   #$1F,d6
loc_10B1E:                              ; CODE XREF: Gfx_DirectVRAMTransfer+102   j
                moveq   #$F,d7
loc_10B20:                              ; CODE XREF: Gfx_DirectVRAMTransfer+C4   j
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  d1,d3
                lsr.w   #8,d2
                lsr.w   #3,d3
                andi.w  #$3E0,d3
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                move.w  d4,d5
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  d1,d3
                lsr.w   #5,d2
                lsr.w   #2,d3
                andi.w  #7,d2
                andi.w  #$38,d3 ; '8'
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                move.w  d0,d2
                move.l  #$FFFFA980,d3
                lsr.w   #2,d2
                andi.w  #$78,d2 ; 'x'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  d1,d3
                andi.w  #$18,d3
                add.w   d4,d3
                cmpi.w  #$FF,d5
                bne.s   loc_10B7C
                moveq   #0,d3
loc_10B7C:                              ; CODE XREF: Gfx_DirectVRAMTransfer+7E   j
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
                tst.w   (a0)+
                beq.w   loc_10BB4
                movea.l #$FFFF0000,a2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1F80,d4
                add.w   d4,d2
                adda.w  d2,a2
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
loc_10BB4:                              ; CODE XREF: Gfx_DirectVRAMTransfer+94   j
                suba.l  #$E,a0
                addi.w  #$20,d0 ; ' '
                dbf     d7,loc_10B20
                move.w  d1,d2
                lsl.w   #4,d2
                andi.w  #$F80,d2
                move.w  #$8F02,(a4)
                move.l  #$93409400,(a4)
                move.w  #$95C0,(a4)
                move.w  #$96D4,(a4)
                move.w  #$977F,(a4)
                add.w   $E(a0),d2
                move.w  d2,(VDPCommand+2).w
                move.w  #$83,(VDPCommand).w
                move.w  (VDPCommand+2).w,(a4)
                move.w  (VDPCommand).w,(a4)
                subi.w  #$200,d0
                addq.w  #8,d1
                dbf     d6,loc_10B1E
                move.w  (word_FFF7D2).w,d0
                bclr    #4,d0
                move.w  d0,(a4)
loc_10C0A:                              ; CODE XREF: Gfx_DirectVRAMTransfer+118   j
                bclr    #0,(IO_Z80BUS).l
                beq.s   loc_10C0A
                move    (sp)+,sr
                rts
; End of function Gfx_DirectVRAMTransfer
; Renders scrolling background tiles with double buffering
Gfx_RenderScrollingBackground:                              ; CODE XREF: Gfx_WaitForFadeAndLoadTiles+16   p  ; was: sub_10C18
                                        ; Gfx_WaitForFadeAndLoadTiles+1C   p ...
                movea.l (dword_FFA940).w,a0
                move.w  (word_FFA946).w,d0
                move.w  (word_FFA948).w,d1
                neg.w   d1
                moveq   #$F,d7
loc_10C28:                              ; CODE XREF: Gfx_RenderScrollingBackground+AC   j
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  d1,d3
                lsr.w   #8,d2
                lsr.w   #3,d3
                andi.w  #$3E0,d3
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                move.w  d4,d5
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  d1,d3
                lsr.w   #5,d2
                lsr.w   #2,d3
                andi.w  #7,d2
                andi.w  #$38,d3 ; '8'
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                move.w  d0,d2
                move.w  (word_FFF70E).w,d3
                lsr.w   #2,d2
                andi.w  #$78,d2 ; 'x'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  d1,d3
                andi.w  #$18,d3
                add.w   d4,d3
                cmpi.w  #$FF,d5
                bne.s   loc_10C82
                moveq   #0,d3
loc_10C82:                              ; CODE XREF: Gfx_RenderScrollingBackground+66   j
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
                tst.w   (a0)+
                beq.w   loc_10CBA
                movea.l #$FFFF0000,a2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1F80,d4
                add.w   d4,d2
                adda.w  d2,a2
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
loc_10CBA:                              ; CODE XREF: Gfx_RenderScrollingBackground+7C   j
                suba.l  #$E,a0
                addi.w  #$20,d0 ; ' '
                dbf     d7,loc_10C28
                move.w  d1,d2
                lsl.w   #4,d2
                andi.w  #$F80,d2
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                add.w   $E(a0),d2
                move.w  d2,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009340,-(a1)
                move.w  a1,(word_FFF70C).w
                addi.w  #$80,(word_FFF70E).w
                subq.w  #8,(word_FFA948).w
                subq.w  #1,(word_FFA944).w
                rts
; End of function Gfx_RenderScrollingBackground
; Renders multi-layer background using tilemaps
