Stage_TransitionGraphics:                               ; DATA XREF: Stage_TransitionInit+4   o  ; was: sub_F19A
                                        ; ROM:off_F0FC   o
                addq.w  #2,(word_FFA950).w
                move.b  #$80,(byte_FFA958).w
                clr.l   (dword_FFA964).w
                clr.w   (word_FFA968).w
                clr.b   (byte_FFA96A).w
                move.l  #$10000,(dword_FF8062).w
                move.l  #$10000,(dword_FFA960).w
                move.l  #$7000,(dword_FF9D9E).w
                move.l  #$C000,(dword_FF9DA2).w
                move.b  #3,(VDPReg11Shadow+1).w
                move.b  #1,(byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.w  #$3AC,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
; Handles graphics transition with scroll updates
Stage_Graphics_TransitionLoop:                          ; DATA XREF: ROM:0000F0FE   o  ; was: loc_F1EC
                bsr.w   Stage_ScrollUpdate2
                bsr.w   Stage_ScrollUpdate3
                subi.l  #$100,(dword_FF8062).w
                subi.l  #$80,(dword_FFA960).w
                cmpi.w  #$FFFC,(dword_FFA960).w
                bpl.w   Stage_ScrollUpdate1
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                rts
; End of function Stage_TransitionGraphics
; Transition to asteroids
Stage_AsteroidsTransition:                              ; DATA XREF: ROM:0000F100   o  ; was: sub_F218
                bsr.w   Stage_ScrollUpdate2
                bsr.w   Stage_ScrollUpdate3
                tst.b   (byte_FFA96A).w
                beq.w   Stage_ScrollUpdate1
                addq.w  #2,(word_FFA950).w
                move.b  #$40,(byte_FFA958).w            ; '@'
                andi.w  #$FF,(dword_FFA904).w
                addi.w  #-$900,(dword_FFA904).w
                bra.w   Stage_AsteroidsGraphicsUpdate
; End of function Stage_AsteroidsTransition
; Asteroids scroll handler
Stage_AsteroidsScrollHandler:                           ; DATA XREF: ROM:0000F102   o  ; was: sub_F242
                bsr.w   Stage_ScrollUpdate2
                bsr.w   Stage_ScrollUpdate3
                cmpi.w  #$F600,(dword_FFA904).w
                bpl.w   Stage_AsteroidsGraphicsUpdate
                move.w  #$8000,(word_FF808A).w
                move.b  #$80,(byte_FFA958).w
                move.w  #$80,(word_FF9DB0).w
                jmp     Stage_TransitionToNextPhase
; End of function Stage_AsteroidsScrollHandler
; Transition to boss
Boss_DestroyerProtoTransition:                          ; DATA XREF: ROM:0000F104   o  ; was: sub_F26C
                bsr.w   Stage_ScrollUpdate3
                subq.w  #1,(word_FF9DB0).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                lea     (Boss_DestroyerProtoAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Boss_DestroyerProtoTransition
; Boss initialization
Boss_DestroyerProtoInit:                                ; DATA XREF: ROM:0000F106   o  ; was: sub_F288
                bsr.w   Stage_ScrollUpdate3
                tst.w   (Entity_ObjectPool).w
                bne.w   Boss_DestroyerProtoTransition_Return
                move.w  #$1C,(word_FF9DAE).w
                bsr.w   Boss_DestroyerProtoPaletteInit
                jsr     (UI_InitScoreTimer).l
                lea     (DestroyerProtoIntroPaletteCommands).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
loc_F2B0:                                               ; CODE XREF: Boss_DestroyerPhaseInit+14   j
                clr.b   (byte_FFA958).w
                move.w  #$50,(RasterEffectIndex).w      ; 'P'
                clr.w   (RasterEffectInitState).w
                move.w  #$16,(word_FF8090).w
                move.w  #$60,(word_FF9D94).w            ; '`'
                move.l  #$4000,(dword_FF9D9E).w
                move.l  #$8000,(dword_FF9DA2).w
                move.l  #$2000000,(dword_FF9DAA).w
                move.l  #$1E80000,(dword_FF9DB2).w
                move.l  #Gfx_DefaultVRAMTransferParameters,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$F500,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                rts
; End of function Boss_DestroyerProtoInit
; Initializes destroyer proto boss phase state
Boss_DestroyerPhaseInit:                                ; DATA XREF: ROM:0000F128   o  ; was: sub_F304
                move.w  #$C,(word_FFA950).w
                clr.w   (MessageSequenceState).w
                clr.w   (word_FF9DAE).w
                move.b  #3,(VDPReg11Shadow+1).w
                bra.w   loc_F2B0
; End of function Boss_DestroyerPhaseInit
; Animation script interpreter
Boss_DestroyerProtoAnimationScript:                     ; DATA XREF: ROM:0000F108   o  ; was: sub_F31C
                move.l  #$2000000,(dword_FF9DAA).w
                bsr.w   Boss_DestroyerProtoPaletteInit
                bsr.w   loc_FBD8
                bsr.w   Boss_DestroyerProtoRenderSegments
                tst.w   (word_FFA944).w
                bmi.s   loc_F33E
                jsr     (Gfx_RenderScrollingBackground).l
                bra.s   locret_F34E
; ---------------------------------------------------------------------------
loc_F33E:                                               ; CODE XREF: Boss_DestroyerProtoAnimationScript+18   j
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                clr.w   (word_FF820C).w
                clr.b   (byte_FFA209).w
locret_F34E:                                            ; CODE XREF: Boss_DestroyerProtoAnimationScript+20   j
                rts
; End of function Boss_DestroyerProtoAnimationScript
; Graphics cleanup handler
Boss_DestroyerProtoGraphicsCleanup:                     ; DATA XREF: ROM:0000F10A   o  ; was: sub_F350
                bsr.w   Boss_DestroyerProtoPaletteInit
                bsr.w   loc_FBD8
                bsr.w   Boss_DestroyerProtoRenderSegments
                move.w  (dword_FF9DAA).w,d0
                addi.w  #$60,d0                         ; '`'
                move.w  d0,(dword_FF9D90).w
                tst.b   (byte_FFA958).w
                bne.s   loc_F3C2
                moveq   #0,d7
                cmpi.l  #$FFFF8000,(dword_FF9D9E).w
                beq.s   loc_F384
                subi.l  #$80,(dword_FF9D9E).w
                addq.w  #1,d7
loc_F384:                                               ; CODE XREF: Boss_DestroyerProtoGraphicsCleanup+28   j
                cmpi.l  #$FFFF8000,(dword_FF9DA2).w
                beq.s   loc_F398
                subi.l  #$80,(dword_FF9DA2).w
                addq.w  #1,d7
loc_F398:                                               ; CODE XREF: Boss_DestroyerProtoGraphicsCleanup+3C   j
                tst.w   d7
                bne.s   locret_F3DE
                move.b  #1,(byte_FFA958).w
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                move.w  #$2A,(StageTableIndex).w        ; '*'
                move.w  #$166,(dword_FF9D96).w
                move.l  #$2000000,(dword_FF9DAA).w
                move.w  #$3C8,(word_FFDB20).w
loc_F3C2:                                               ; CODE XREF: Boss_DestroyerProtoGraphicsCleanup+1C   j
                addi.l  #$10,(dword_FF9DA2).w
                tst.w   (dword_FF9DAA).w
                bne.s   locret_F3DE
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FF9DA2).w
                move.w  #$E0,(dword_FFA904).w
locret_F3DE:                                            ; CODE XREF: Boss_DestroyerProtoGraphicsCleanup+4A   j
                                        ; Boss_DestroyerProtoGraphicsCleanup+7E   j
                rts
; End of function Boss_DestroyerProtoGraphicsCleanup
; Transition to boss
Boss_ShieldViperTransition:                             ; DATA XREF: ROM:0000F10C   o  ; was: sub_F3E0
                bsr.w   loc_FBD8
                bsr.w   Boss_DestroyerProtoRenderSegments
                cmpi.w  #$FF80,(dword_FF9D96).w
                bpl.s   locret_F400
                addq.w  #2,(word_FFA950).w
                clr.w   (RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                clr.w   (word_FF8090).w
locret_F400:                                            ; CODE XREF: Boss_ShieldViperTransition+E   j
                rts
; End of function Boss_ShieldViperTransition
; Boss initialization
Boss_ShieldViperInit:                                   ; DATA XREF: ROM:0000F10E   o  ; was: sub_F402
                bsr.w   loc_FBD8
                bsr.w   Boss_ShieldViperScrollSetup
                move.b  #0,(byte_FFA958).w
                jsr     (Stage_TransitionToNextPhase).l
                lea     (Boss_ShieldViperAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
                clr.w   (word_FF9DFC).w
                clr.w   (word_FF9DFE).w
                rts
; End of function Boss_ShieldViperInit
; Graphics initialization
Boss_ShieldViperGraphicsInit:                           ; DATA XREF: ROM:0000F110   o  ; was: sub_F42C
                bsr.w   loc_FBD8
                bsr.w   Boss_ShieldViperScrollSetup
                bsr.w   Boss_ShieldViperRenderBackground
                cmpi.w  #$C,(word_FF9DFE).w
                bmi.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                rts
; End of function Boss_ShieldViperGraphicsInit
; Palette setup
Boss_ShieldViperPaletteSetup:                           ; DATA XREF: ROM:0000F112   o  ; was: sub_F448
                bsr.w   loc_FBD8
                bsr.w   Boss_ShieldViperScrollSetup
                tst.w   (Entity_ObjectPool).w
                bne.w   Boss_DestroyerProtoTransition_Return
                move.b  #1,(byte_FF830E).w
                addq.w  #2,(word_FFA950).w
                move.l  #Gfx_DefaultVRAMTransferParameters,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$F100,(word_FFA948).w
                move.w  #$10,(word_FFA944).w
                move.w  #$E,(word_FF9DAE).w
                bra.w   loc_FD08
; End of function Boss_ShieldViperPaletteSetup
; Graphics cleanup handler
Boss_ShieldViperGraphicsCleanup:                        ; DATA XREF: ROM:0000F114   o  ; was: sub_F484
                bsr.w   loc_FD08
                jsr     (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                move.w  #$20,(dword_FF8128).w           ; ' '
                move.l  #Gfx_ScrollVRAMTransferParameters,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$F400,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                move.b  #4,(byte_FFA95B).w
                move.w  #$A000,d0
                bra.w   Boss_WolfGaropaGraphicsInit
; End of function Boss_ShieldViperGraphicsCleanup
; Restores palette
Boss_ShieldViperPaletteRestore:                         ; DATA XREF: ROM:0000F116   o  ; was: sub_F4C6
                bsr.w   loc_FD08
                subq.w  #1,(dword_FF8128).w
                bmi.s   loc_F4D2
                rts
; ---------------------------------------------------------------------------
loc_F4D2:                                               ; CODE XREF: Boss_ShieldViperPaletteRestore+8   j
                cmpi.w  #$1B,(word_FFA944).w
                bmi.s   Boss_ShieldViperVRAMCleanup
                jmp     Gfx_RenderScrollingBackground
; End of function Boss_ShieldViperPaletteRestore
; VRAM cleanup
Boss_ShieldViperVRAMCleanup:                            ; CODE XREF: Boss_ShieldViperPaletteRestore+12   j  ; was: sub_F4E0
                move.w  #$6000,(dword_FFA940).w
                clr.w   (word_FFA946).w
                jsr     (Sprite_SetupDMA).l
                tst.w   (word_FFA944).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                move.w  #$50,(RasterEffectIndex).w      ; 'P'
                clr.w   (RasterEffectInitState).w
                move.w  #$16,(word_FF8090).w
                clr.l   (dword_FF8066).w
                move.l  #$600000,(dword_FF9D90).w
                clr.l   (dword_FF9DAA).w
                clr.w   (dword_FFA908).w
                move.w  #$F4E2,(dword_FFA90C).w
                jmp     Stage_TriggerPhaseTransition
; End of function Boss_ShieldViperVRAMCleanup
; Final cleanup handler
Boss_ShieldViperFinalCleanup:                           ; DATA XREF: ROM:0000F118   o  ; was: sub_F528
                bsr.w   loc_FD08
                bsr.w   Boss_DestroyerProtoRenderSegments
                tst.w   (word_FF9DAE).w
                bmi.s   loc_F53E
                beq.s   loc_F53E
                subq.w  #1,(word_FF9DAE).w
                rts
; ---------------------------------------------------------------------------
loc_F53E:                                               ; CODE XREF: Boss_ShieldViperFinalCleanup+C   j
                                        ; Boss_ShieldViperFinalCleanup+E   j
                tst.w   (MessageSequenceState).w
                bne.s   locret_F55E
                move.b  #$89,d0
                jsr     (Sound_QueueBGMOrStop).l
                addq.w  #2,(word_FFA950).w
                addq.w  #2,(StageTableIndex).w
                move.l  #$10000,(dword_FF9DB6).w
locret_F55E:                                            ; CODE XREF: Boss_ShieldViperFinalCleanup+1A   j
                rts
; End of function Boss_ShieldViperFinalCleanup
; Transition to boss
Boss_WolfGaropaTransition:                              ; DATA XREF: ROM:0000F11A   o  ; was: sub_F560
                bsr.w   Boss_WolfGaropaInit
                bsr.w   Boss_DestroyerProtoRenderSegments
                subi.l  #$8000,(dword_FF9DAA).w
                subi.l  #$8000,(dword_FF9D90).w
                bpl.s   locret_F58C
                addq.w  #2,(word_FFA950).w
                clr.w   (dword_FFA90C+2).w
                move.w  #$12,(word_FF8220).w
                bsr.w   Boss_WolfGaropaAttackState3
locret_F58C:                                            ; CODE XREF: Boss_WolfGaropaTransition+18   j
                rts
; End of function Boss_WolfGaropaTransition
; Palette setup
Boss_WolfGaropaPaletteSetup:                            ; DATA XREF: ROM:0000F11C   o  ; was: sub_F58E
                bsr.w   Boss_WolfGaropaInit
                move.w  (dword_FFA90C).w,(dword_FFA904).w
                cmpi.w  #$F400,(dword_FFA90C).w
                bpl.s   loc_F5A8
                subi.l  #$400,(dword_FF9DB6).w
loc_F5A8:                                               ; CODE XREF: Boss_WolfGaropaPaletteSetup+10   j
                cmpi.w  #$F3E0,(dword_FFA90C).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.w   (RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                clr.w   (word_FF8090).w
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.l  #Gfx_DefaultVRAMTransferParameters,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                clr.w   (word_FFA946).w
                move.w  #$F400,(word_FFA948).w
                move.w  #$2000,d0
                bra.w   Boss_WolfGaropaGraphicsInit
; End of function Boss_WolfGaropaPaletteSetup
; Main boss handler
Boss_WolfGaropaMain:                                    ; DATA XREF: ROM:0000F11E   o  ; was: sub_F5EE
                move.l  (dword_FF8062).w,d0
                sub.l   d0,(dword_FFA908).w
                move.w  (dword_FFA908).w,(dword_FFA900).w
                move.w  (dword_FFA90C).w,(dword_FFA904).w
                jsr     (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.s   locret_F622
                addq.w  #2,(word_FFA950).w
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                clr.w   (word_FFA946).w
locret_F622:                                            ; CODE XREF: Boss_WolfGaropaMain+1E   j
                rts
; End of function Boss_WolfGaropaMain
; Boss state dispatcher
Boss_WolfGaropaDispatcher:                              ; DATA XREF: ROM:0000F120   o  ; was: sub_F624
                bsr.w   Boss_WolfGaropaBattleStart
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                jsr     (Sprite_SetupDMA).l
                tst.w   (word_FFA944).w
                bpl.s   locret_F660
                addq.w  #2,(word_FFA950).w
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                clr.b   (byte_FFA209).w
                move.w  #$494,(word_FFDB20).w
                clr.w   (word_FFDB24).w
                clr.w   (word_FFDB22).w
                clr.b   (byte_FFDB41).w
locret_F660:                                            ; CODE XREF: Boss_WolfGaropaDispatcher+1A   j
                rts
; End of function Boss_WolfGaropaDispatcher
; Initializes Wolf Garopa attack phase 3
Boss_WolfGaropaPhaseInit:                               ; DATA XREF: ROM:0000F12A   o  ; was: sub_F662
                move.w  #$24,(word_FFA950).w            ; '$'
                move.l  #$FFF88000,(dword_FF8062).w
                bsr.w   Boss_WolfGaropaAttackState3
                bset    #0,(byte_FFA209).w
                rts
; End of function Boss_WolfGaropaPhaseInit
; Intro animation init
Boss_WolfGaropaIntroInit:                               ; DATA XREF: ROM:0000F122   o  ; was: sub_F67C
                bsr.w   Boss_WolfGaropaBattleStart
                jmp     Stage_TransitionToNextPhase
; End of function Boss_WolfGaropaIntroInit
; Intro movement
Boss_WolfGaropaIntroMove:                               ; DATA XREF: ROM:0000F124   o  ; was: sub_F686
                bsr.w   Boss_WolfGaropaIntroStop
                tst.w   (MessageSequenceState).w
                bne.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FF9DBA).w
                lea     (Boss_WolfGaropaAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Boss_WolfGaropaIntroMove
; Spawns projectile type 2
Boss_WolfGaropaSpawnProjectile2:                        ; DATA XREF: ROM:0000F126   o  ; was: sub_F6A6
                bsr.w   Boss_WolfGaropaBattleStart
                tst.w   (Entity_ObjectPool).w
                bne.s   locret_F6C2
                move.w  #$30,(word_FFA950).w            ; '0'
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                move.w  #$80,(dword_FF8128).w
locret_F6C2:                                            ; CODE XREF: Boss_WolfGaropaSpawnProjectile2+8   j
                rts
; End of function Boss_WolfGaropaSpawnProjectile2
; Transition out of boss
Boss_WolfGaropaTransitionOut:                           ; DATA XREF: ROM:0000F12C   o  ; was: sub_F6C4
                bsr.w   Boss_WolfGaropaBattleStart
                tst.w   (MessageSequenceState).w
                bne.s   locret_F6F2
                subq.w  #1,(dword_FF8128).w
                bpl.s   locret_F6F2
                tst.w   (word_FF8230).w
                bne.s   locret_F6F2
                tst.w   (word_FF8138).w
                bne.s   locret_F6F2
                move.b  #$8F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w   Stage_InitTransitionState
; ---------------------------------------------------------------------------
locret_F6F2:                                            ; CODE XREF: Boss_WolfGaropaTransitionOut+8   j
                                        ; Boss_WolfGaropaTransitionOut+E   j
                rts
; End of function Boss_WolfGaropaTransitionOut
; Wrapper to start Wolf Garopa battle
Boss_WolfGaropaBattleWrapper:                           ; DATA XREF: ROM:0000F12E   o  ; was: sub_F6F4
                bsr.w   Boss_WolfGaropaBattleStart
                rts
; End of function Boss_WolfGaropaBattleWrapper
; Intro stop position
Boss_WolfGaropaIntroStop:                               ; CODE XREF: Boss_WolfGaropaIntroMove   p  ; was: sub_F6FA
                cmpi.l  #$FFFF0000,(dword_FF8240).w
                beq.s   loc_F70C
                subi.l  #$800,(dword_FF8240).w
loc_F70C:                                               ; CODE XREF: Boss_WolfGaropaIntroStop+8   j
                move.l  (dword_FF8062).w,d0
                cmpi.l  #$FFF60000,d0
                bmi.s   Boss_WolfGaropaBattleStart
                beq.s   Boss_WolfGaropaBattleStart
                subi.l  #$800,d0
                move.l  d0,(dword_FF8062).w
; End of function Boss_WolfGaropaIntroStop
; Battle start initialization
Boss_WolfGaropaBattleStart:                             ; CODE XREF: Boss_WolfGaropaDispatcher   p  ; was: sub_F724
                                        ; sub_F67C   p
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
                bsr.w   Gfx_LoadWolfGaropaTiles
loc_F74A:                                               ; CODE XREF: Boss_WolfGaropaBattleStart+C   j
                andi.w  #$3F,(dword_FFA900).w           ; '?'
locret_F750:                                            ; CODE XREF: Boss_WolfGaropaBattleStart+E   j
                                        ; Boss_WolfGaropaBattleStart+14   j
                rts
; End of function Boss_WolfGaropaBattleStart
; DMA transfers Wolf Garopa tile graphics
Gfx_LoadWolfGaropaTiles:                                ; CODE XREF: Boss_WolfGaropaBattleStart+22   p  ; was: sub_F752
                                        ; Effect_WolfGaropaBoundaryMain+28   p
                lea     byte_F76A(pc),a0
                nop
                jsr     (Gfx_DMATransferTiles).l
                lea     byte_F778(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadWolfGaropaTiles
; ---------------------------------------------------------------------------
byte_F76A:      dc.b    $44, $58, $40, 0, 1, 3, $1F
                                        ; DATA XREF: Gfx_LoadWolfGaropaTiles   o
                dc.b    $1E, $21, $20, $23, $22, $25, $24
byte_F778:      dc.b    $4C, $50, $40, 0, 4, 1, $26, $27
                                        ; DATA XREF: Gfx_LoadWolfGaropaTiles+C   o
                dc.b    $26, $27, $26, $28, $29, $28, $29, $28

; Boss initialization
Boss_WolfGaropaInit:                                    ; CODE XREF: Boss_WolfGaropaTransition   p  ; was: sub_F788
                                        ; sub_F58E   p
                move.l  (dword_FF9DB6).w,d0
                sub.l   d0,(dword_FFA90C).w
                move.l  (dword_FF8062).w,d0
                sub.l   d0,(dword_FFA908).w
                moveq   #0,d0
                move.w  (dword_FFA90C).w,d1
                subi.w  #$F8,d1
                lea     (Gfx_ScrollVRAMTransferParameters).l,a0
                bra.w   loc_109E0
; End of function Boss_WolfGaropaInit
; Graphics initialization
Boss_WolfGaropaGraphicsInit:                            ; CODE XREF: Boss_ShieldViperGraphicsCleanup+3E   j  ; was: sub_F7AC
                                        ; Boss_WolfGaropaPaletteSetup+5C   j
                movea.l #$FFFF4300,a0
                moveq   #$30,d7                         ; '0'
                jmp     Gfx_AdjustTileIndexRows
; End of function Boss_WolfGaropaGraphicsInit
; Initializes stage scroll parameters and timers
Stage_InitScrollParams:
                addq.w  #2,(word_FFA950).w              ; was: sub_F7BA
                move.b  #$40,(byte_FFA958).w            ; '@'
                move.w  #$FFFE,(dword_FFA960).w
                clr.b   (VDPReg11Shadow+1).w
                rts
; End of function Stage_InitScrollParams
; Updates asteroids scroll until position reached
Stage_AsteroidsScrollCheck:
                bsr.w   Stage_ScrollUpdate3             ; was: sub_F7D0
                bsr.w   Stage_AsteroidsGraphicsUpdate
                cmpi.w  #$F3E0,(dword_FFA904).w
                bpl.w   Boss_DestroyerProtoTransition_Return
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
