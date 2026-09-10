; Advance palette fades, run the selected state, and clear the per-frame projectile flag
Boss_ZLeoMain:                                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_51AD6
                tst.w   4(a5)
                beq.w   Boss_ZLeoDispatchStateAndClearProjectileFlag
                tst.w   8(a5)
                beq.w   Boss_ZLeoDispatchStateAndClearProjectileFlag
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_ZLeoUpdateFirstPaletteFade
                btst    #1,(byte_FF80EC).w
                bne.s   Boss_ZLeoUpdateFirstPaletteFade
                tst.w   (word_FF8200).w
                beq.w   Boss_ZLeoBeginDefeatSequence
Boss_ZLeoUpdateFirstPaletteFade:                        ; CODE XREF: Boss_ZLeoMain+16   j  ; was: loc_51AFE
                                        ; Boss_ZLeoMain+1E   j
                move.w  $4DC(a5),d0
                beq.s   Boss_ZLeoUpdateSecondPaletteFade
                bpl.s   Boss_ZLeoDecreaseFirstPaletteFade
                addq.w  #1,d0
                bra.s   Boss_ZLeoApplyFirstPaletteFade
; ---------------------------------------------------------------------------
Boss_ZLeoDecreaseFirstPaletteFade:                      ; CODE XREF: Boss_ZLeoMain+2E   j  ; was: loc_51B0A
                subq.w  #1,d0
Boss_ZLeoApplyFirstPaletteFade:                         ; CODE XREF: Boss_ZLeoMain+32   j  ; was: loc_51B0C
                move.w  d0,$4DC(a5)
                movea.w #(word_FFE302-M68K_RAM),a0
                moveq   #$E,d5
                move.w  $4DE(a5),d7
                jsr     (Gfx_ApplyPaletteFade).l
Boss_ZLeoUpdateSecondPaletteFade:                       ; CODE XREF: Boss_ZLeoMain+2C   j  ; was: loc_51B20
                move.w  $53C(a5),d0
                beq.s   Boss_ZLeoUpdateThirdPaletteFade
                bpl.s   Boss_ZLeoDecreaseSecondPaletteFade
                addq.w  #1,d0
                bra.s   Boss_ZLeoApplySecondPaletteFade
; ---------------------------------------------------------------------------
Boss_ZLeoDecreaseSecondPaletteFade:                     ; CODE XREF: Boss_ZLeoMain+50   j  ; was: loc_51B2C
                subq.w  #1,d0
Boss_ZLeoApplySecondPaletteFade:                        ; CODE XREF: Boss_ZLeoMain+54   j  ; was: loc_51B2E
                move.w  d0,$53C(a5)
                movea.w #(byte_FFE322-M68K_RAM),a0
                moveq   #$1E,d5
                move.w  $53E(a5),d7
                jsr     (Gfx_ApplyPaletteFade).l
Boss_ZLeoUpdateThirdPaletteFade:                        ; CODE XREF: Boss_ZLeoMain+4E   j  ; was: loc_51B42
                move.w  $59C(a5),d0
                beq.s   Boss_ZLeoFinalizePaletteFades
                bpl.s   Boss_ZLeoDecreaseThirdPaletteFade
                addq.w  #1,d0
                bra.s   Boss_ZLeoApplyThirdPaletteFade
; ---------------------------------------------------------------------------
Boss_ZLeoDecreaseThirdPaletteFade:                      ; CODE XREF: Boss_ZLeoMain+72   j  ; was: loc_51B4E
                subq.w  #1,d0
Boss_ZLeoApplyThirdPaletteFade:                         ; CODE XREF: Boss_ZLeoMain+76   j  ; was: loc_51B50
                move.w  d0,$59C(a5)
                movea.w #(word_FFE362-M68K_RAM),a0
                moveq   #$E,d5
                move.w  $59E(a5),d7
                jsr     (Gfx_ApplyPaletteFade).l
Boss_ZLeoFinalizePaletteFades:                          ; CODE XREF: Boss_ZLeoMain+70   j  ; was: loc_51B64
                jsr     (Gfx_InitPaletteFade).l
Boss_ZLeoDispatchStateAndClearProjectileFlag:           ; CODE XREF: Boss_ZLeoMain+4   j  ; was: loc_51B6A
                                        ; Boss_ZLeoMain+C   j
                bsr.s   Boss_ZLeoDispatcher
                clr.w   (word_FF9500).w
                rts
; End of function Boss_ZLeoMain
; Dispatch the even-valued state through the ROM-ordered state table
Boss_ZLeoDispatcher:                                    ; CODE XREF: Boss_ZLeoMain:Boss_ZLeoDispatchStateAndClearProjectileFlag   p  ; was: sub_51B72
                move.w  4(a5),d0
                movea.w Boss_ZLeoStateTable(pc,d0.w),a0
                adda.l  #Boss_ZLeoNoOp,a0
                jmp     (a0)
; End of function Boss_ZLeoDispatcher
; ---------------------------------------------------------------------------
Boss_ZLeoStateTable:    dc.w    Boss_ZLeoInit-Boss_ZLeoNoOp  ; was: off_51B82
                                        ; DATA XREF: Boss_ZLeoDispatcher+4   r
                dc.w    Boss_ZLeoIntroInit-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunIntroDescent-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunDefeatTransition-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunDefeatFade-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunDefeatWhiteout-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunPostDefeatDelay-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoPostDefeatNoOp-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunIntroCountdown-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunBattleEntry-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoWaitForBattlePose-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunBattlePose-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunBattleReadyPose-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunBossMessageDelay-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoWaitForBossMessage-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoSelectAttackState-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttackState1-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttack_State28-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttack_State30-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttack_State32-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttackSequence-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttack_State38-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttack_State40-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttack_State42-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttack_State44-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttack_State46-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttack_State48-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoAttack_State50-Boss_ZLeoNoOp
                dc.w    Boss_ZLeoRunLaserOpeningDelay-Boss_ZLeoNoOp

Boss_ZLeoNoOp:                                          ; CODE XREF: Boss_ZLeoIntroInit+E   j  ; was: nullsub_120
                                        ; Boss_ZLeoTileUpdate+16   j
                rts
; End of function Boss_ZLeoNoOp

; Wait for the stage gate, prepare graphics, and advance to composite-part initialization
Boss_ZLeoInit:                                          ; DATA XREF: ROM:Boss_ZLeoStateTable   o  ; was: sub_51BBE
                tst.w   (word_FF80C2).w
                bne.w   Boss_ZLeoInitReturn
                addq.w  #2,4(a5)
                bset    #0,(byte_FF8245).w
                move.w  #$3F8,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$54,(word_FFF74A).w            ; 'T'
                clr.w   (word_FFF74E).w
                move.w  #$18,(word_FF8090).w
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                movea.l #$FFFF4520,a0
                move.w  #$A000,d0
                moveq   #5,d7
                jsr     (Gfx_AdjustTileIndices).l
                bsr.w   Boss_ZLeoGraphicsInit1
                bsr.w   Boss_ZLeoGraphicsInit2
                bsr.w   Boss_ZLeoGraphicsInit3
                move.l  #dword_11316,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                move.w  #$F600,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
Boss_ZLeoInitReturn:                                    ; CODE XREF: Boss_ZLeoInit+4   j  ; was: locret_51C30
                rts
; End of function Boss_ZLeoInit
; Initialize the composite parts, mappings, and intro display state
Boss_ZLeoIntroInit:                                     ; DATA XREF: ROM:00051B84   o  ; was: sub_51C32
                bsr.w   Boss_ZLeoGraphicsInit2
                jsr     (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   Boss_ZLeoNoOp
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$380,(dword_FF8040).w
                moveq   #$F,d7
                movea.l #Boss_ZLeoValkirieForceSharedMetaspriteData,a0
                movea.l #Boss_ZLeoPartRadii,a1
                movea.l #Boss_ZLeoPartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$3F8,(a5)
                move.w  #$C00,2(a5)
                movea.l #$FFFF2020,a0
                move.w  #$6000,d0
                move.w  #$280,d1
                moveq   #$1F,d7
                jsr     (Gfx_UpdateTilemapIndices).l
                movea.l #$FFFF2080,a0
                move.w  #$E000,d0
                moveq   #3,d7
                jsr     (Gfx_AdjustTileIndices).l
                move.w  #$7FFF,d0
                lea     (byte_FF2080).l,a0
                and.w   d0,(a0)
                and.w   d0,2(a0)
                and.w   d0,8(a0)
                and.w   d0,$A(a0)
                and.w   d0,$10(a0)
                and.w   d0,$12(a0)
                and.w   d0,$18(a0)
                and.w   d0,$1A(a0)
                lea     (word_FF20E0).l,a0
                and.w   d0,word_FF20E4-word_FF20E0(a0)
                and.w   d0,6(a0)
                and.w   d0,$C(a0)
                and.w   d0,$E(a0)
                and.w   d0,$14(a0)
                and.w   d0,$16(a0)
                and.w   d0,$1C(a0)
                and.w   d0,$1E(a0)
                clr.w   (word_FF9600).w
                clr.w   (dword_FFA900).w
                move.w  #$100,(dword_FFA904).w
                move.w  #$100,(word_FF9602).w
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                move.w  #$10,d0
                move.w  #$C000,d1
                move.w  #$4B80,d2
                movea.w #(word_FFCDA0-M68K_RAM),a0
                moveq   #2,d7
Boss_ZLeoInitializeIntroPartRows:                       ; CODE XREF: Boss_ZLeoIntroInit+110   j  ; was: loc_51D1E
                moveq   #$10,d3
                moveq   #2,d6
Boss_ZLeoInitializeIntroPartRow:                        ; CODE XREF: Boss_ZLeoIntroInit+10C   j  ; was: loc_51D22
                move.w  d0,(a0)
                move.w  d1,2(a0)
                move.w  d2,$E(a0)
                move.b  d3,$20(a0)
                subq.w  #4,d3
                move.l  #word_ED3B8,8(a0)
                lea     $60(a0),a0
                dbf     d6,Boss_ZLeoInitializeIntroPartRow
                dbf     d7,Boss_ZLeoInitializeIntroPartRows
                move.l  #word_ED3BE,d4
                move.l  d4,$848(a5)
                move.l  d4,$968(a5)
                move.l  d4,$A88(a5)
                movea.w #(byte_FFD100-M68K_RAM),a0
                moveq   #$50,d3                         ; 'P'
                moveq   #5,d7
Boss_ZLeoInitializeLowerIntroParts:                     ; CODE XREF: Boss_ZLeoIntroInit+140   j  ; was: loc_51D60
                move.w  d0,(a0)
                move.w  d1,2(a0)
                move.w  d2,$E(a0)
                move.b  d3,$20(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_ZLeoInitializeLowerIntroParts
                move.l  #word_ED478,$AE8(a5)
                move.l  #word_ED39A,$B48(a5)
                move.l  #word_ED394,$BA8(a5)
                move.l  #word_ED478,$C08(a5)
                move.l  #word_ED39A,$C68(a5)
                move.l  #word_ED394,$CC8(a5)
                bclr    #3,$AEE(a5)
                bclr    #3,$B4E(a5)
                bclr    #3,$BAE(a5)
                move.b  #$4C,$B60(a5)                   ; 'L'
                move.b  #$4C,$C80(a5)                   ; 'L'
                movea.l #Boss_ZLeoObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                clr.l   $2FC(a5)
                clr.l   $35C(a5)
                move.w  #2,$1DE(a5)
                bra.w   Boss_ZLeoPrepareIntroMovement
; End of function Boss_ZLeoIntroInit
; Prepare the intro descent from $1A0 to $E8
Boss_ZLeoPrepareIntroDescent:                           ; was: sub_51DE2
                move.w  #$120,$2FC(a5)
                move.w  #$1A0,$35C(a5)
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; Lower the selected composite position until it reaches $E8
Boss_ZLeoRunIntroDescent:                               ; DATA XREF: ROM:00051B86   o  ; was: loc_51E0E
                subq.w  #1,$35C(a5)
                cmpi.w  #$E8,$35C(a5)
                bpl.s   Boss_ZLeoUpdateIntroDescentPose
                move.w  #$E8,$35C(a5)
                clr.b   (byte_FF80EC).w
Boss_ZLeoUpdateIntroDescentPose:                        ; CODE XREF: Boss_ZLeoPrepareIntroDescent+36   j  ; was: loc_51E24
                move.w  $5B4(a5),d0
                addi.w  #0,d0
                move.w  d0,(dword_FFDB34).w
                lea     word_52C56(pc),a1
                nop
                bra.w   loc_5262E
; End of function Boss_ZLeoPrepareIntroDescent
; Unreferenced controller entry for adjusting position and the shared scroll coordinate
Debug_ZLeoPositionAndStartIntro:                        ; was: sub_51E3A
                btst    #2,(word_FFF706).w
                beq.s   Debug_ZLeoCheckMoveRightInput
                subq.w  #3,$10(a5)
Debug_ZLeoCheckMoveRightInput:                          ; CODE XREF: Debug_ZLeoPositionAndStartIntro+6   j  ; was: loc_51E46
                btst    #3,(word_FFF706).w
                beq.s   Debug_ZLeoCheckMoveUpInput
                addq.w  #3,$10(a5)
Debug_ZLeoCheckMoveUpInput:                             ; CODE XREF: Debug_ZLeoPositionAndStartIntro+12   j  ; was: loc_51E52
                btst    #0,(word_FFF706).w
                beq.s   Debug_ZLeoCheckMoveDownInput
                subq.w  #2,$14(a5)
Debug_ZLeoCheckMoveDownInput:                           ; CODE XREF: Debug_ZLeoPositionAndStartIntro+1E   j  ; was: loc_51E5E
                btst    #1,(word_FFF706).w
                beq.s   Debug_ZLeoCheckIncreaseScrollInput
                addq.w  #2,$14(a5)
Debug_ZLeoCheckIncreaseScrollInput:                     ; CODE XREF: Debug_ZLeoPositionAndStartIntro+2A   j  ; was: loc_51E6A
                btst    #6,(word_FFF706).w
                beq.s   Debug_ZLeoCheckDecreaseScrollInput
                addq.w  #2,(dword_FFDB34).w
Debug_ZLeoCheckDecreaseScrollInput:                     ; CODE XREF: Debug_ZLeoPositionAndStartIntro+36   j  ; was: loc_51E76
                btst    #4,(word_FFF706).w
                beq.s   Boss_ZLeoPrepareIntroMovement
                subq.w  #2,(dword_FFDB34).w
Boss_ZLeoPrepareIntroMovement:                          ; CODE XREF: Boss_ZLeoIntroInit+1AC   j  ; was: loc_51E82
                                        ; Debug_ZLeoPositionAndStartIntro+42   j
                move.w  #$10,4(a5)
                move.w  #$1C0,$11C(a5)
                move.w  #$120,$2FC(a5)
                move.w  #$1E0,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.b  #$95,d0
                jsr     (Sys_WaitVBlank).l
; End of function Debug_ZLeoPositionAndStartIntro
; Count down the intro hold, play its cue, and hand off to battle entry
Boss_ZLeoRunIntroCountdown:                             ; DATA XREF: ROM:00051B92   o  ; was: sub_51EB6
                cmpi.w  #$1B8,$11C(a5)
                bne.s   Boss_ZLeoAdvanceIntroCountdown
                move.b  #$F7,d0
                jsr     (Sound_PlaySFX).l
Boss_ZLeoAdvanceIntroCountdown:                         ; CODE XREF: Boss_ZLeoRunIntroCountdown+6   j  ; was: loc_51EC8
                subq.w  #1,$11C(a5)
                bmi.s   Boss_ZLeoBeginBattleEntry
                move.w  #2,(word_FFA014).w
                lea     word_52C7A(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
Boss_ZLeoBeginBattleEntry:                              ; CODE XREF: Boss_ZLeoRunIntroCountdown+16   j  ; was: loc_51EDE
                addq.w  #2,4(a5)
                move.w  #$E000,$59E(a5)
                move.w  #$FFF6,$11C(a5)
                clr.w   $11E(a5)
                lea     Boss_ZLeoBattleEntryEffectDescriptor(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
; End of function Boss_ZLeoRunIntroCountdown
; Move the composite coordinate toward $F0 while pulsing the entry fade
Boss_ZLeoRunBattleEntry:                                ; DATA XREF: ROM:00051B94   o  ; was: sub_51EFE
                subi.l  #$8000,$35C(a5)
                cmpi.w  #$F0,$35C(a5)
                bmi.s   Boss_ZLeoFinishBattleEntry
                tst.w   $11E(a5)
                bne.s   Boss_ZLeoPulseBattleEntryFade
                cmpi.w  #$144,$35C(a5)
                bpl.s   Boss_ZLeoRenderBattleEntry
                addq.w  #1,$11E(a5)
Boss_ZLeoPulseBattleEntryFade:                          ; CODE XREF: Boss_ZLeoRunBattleEntry+14   j  ; was: loc_51F20
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   Boss_ZLeoRenderBattleEntry
                addq.w  #1,$11C(a5)
                bmi.s   Boss_ZLeoRenderBattleEntry
                clr.w   $11C(a5)
Boss_ZLeoRenderBattleEntry:                             ; CODE XREF: Boss_ZLeoRunBattleEntry+1C   j  ; was: loc_51F34
                                        ; Boss_ZLeoRunBattleEntry+2A   j
                move.w  $11C(a5),$59C(a5)
                move.w  #3,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                lea     word_52C7A(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
Boss_ZLeoBattleEntryEffectDescriptor:   dc.w    6       ; field_0  ; was: stru_51F50
                                        ; DATA XREF: Boss_ZLeoRunIntroCountdown+3C   o
                dc.l    byte_1C8CB4                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    $FFFF
; ---------------------------------------------------------------------------
Boss_ZLeoFinishBattleEntry:                             ; CODE XREF: Boss_ZLeoRunBattleEntry+E   j  ; was: loc_51F5A
                addq.w  #2,4(a5)
                move.w  #$F0,$35C(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                move.w  #4,(word_FFA010).w
                move.w  #3,(word_FFA014).w
; Hold the entry pose before enabling its animated parts
Boss_ZLeoWaitForBattlePose:                             ; DATA XREF: ROM:00051B96   o  ; was: loc_51F76
                subq.w  #1,$11C(a5)
                bmi.s   Boss_ZLeoBeginBattlePose
                lea     word_52C7A(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
Boss_ZLeoBeginBattlePose:                               ; CODE XREF: Boss_ZLeoRunBattleEntry+7C   j  ; was: loc_51F86
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                move.w  #4,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                bsr.w   Boss_ZLeoAnimationUpdate1
; End of function Boss_ZLeoRunBattleEntry
; Run the battle pose and respond to its part-enable event
Boss_ZLeoRunBattlePose:                                 ; DATA XREF: ROM:00051B98   o  ; was: sub_51FAA
                tst.w   $58(a5)
                bmi.s   Boss_ZLeoBeginBattleReadySequence
                bclr    #0,$23E(a5)
                beq.s   Boss_ZLeoRenderBattlePose
                bsr.w   Boss_ZLeoEnableParts
Boss_ZLeoRenderBattlePose:                              ; CODE XREF: Boss_ZLeoRunBattlePose+C   j  ; was: loc_51FBC
                lea     word_52C8C(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
Boss_ZLeoBeginBattleReadySequence:                      ; CODE XREF: Boss_ZLeoRunBattlePose+4   j  ; was: loc_51FC6
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$60,$11C(a5)                   ; '`'
                bsr.w   Boss_ZLeoLoadPhaseTiles
                move.b  #$EC,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ZLeoRunBattlePose
; Run the timed battle-ready pose
Boss_ZLeoRunBattleReadyPose:                            ; DATA XREF: ROM:00051B9A   o  ; was: sub_51FE8
                subq.w  #1,$11C(a5)
                bmi.s   Boss_ZLeoBeginBossMessageDelay
                lea     word_52C9C(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
Boss_ZLeoBeginBossMessageDelay:                         ; CODE XREF: Boss_ZLeoRunBattleReadyPose+4   j  ; was: loc_51FF8
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$11C(a5)                   ; '@'
; Hold the final pose before starting the boss message
Boss_ZLeoRunBossMessageDelay:                           ; DATA XREF: ROM:00051B9C   o  ; was: loc_5200C
                subq.w  #1,$11C(a5)
                bmi.s   Boss_ZLeoStartBossMessage
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
Boss_ZLeoStartBossMessage:                              ; CODE XREF: Boss_ZLeoRunBattleReadyPose+28   j  ; was: loc_5201C
                addq.w  #2,4(a5)
                moveq   #0,d0
                jsr     (UI_StartBossMessage).l
; End of function Boss_ZLeoRunBattleReadyPose
; Wait for the boss-message gate before entering the first attack-cycle state
Boss_ZLeoWaitForBossMessage:                            ; DATA XREF: ROM:00051B9E   o  ; was: sub_52028
                tst.w   (word_FF80C2).w
                bne.s   Boss_ZLeoRenderBossMessageWait
                move.w  #$1E,4(a5)
                clr.b   (byte_FF80EC).w
                bra.w   Boss_ZLeoSelectAttackState
; ---------------------------------------------------------------------------
Boss_ZLeoRenderBossMessageWait:                         ; CODE XREF: Boss_ZLeoWaitForBossMessage+4   j  ; was: loc_5203C
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; End of function Boss_ZLeoWaitForBossMessage
; Enter the health-zero defeat sequence and initialize its transition
Boss_ZLeoBeginDefeatSequence:                           ; CODE XREF: Boss_ZLeoMain+24   j  ; was: sub_52046
                move.w  #6,4(a5)
                move.b  #$40,(byte_FFF705).w            ; '@'
                move.w  #8,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                bset    #0,(byte_FFA272).w
                clr.b   $21(a5)
                move.w  #$34,(word_FFA02A).w            ; '4'
                bset    #2,(word_FFDB22).w
                move.l  #$FFFF0000,(dword_FFDB3C).w
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$C0,$11C(a5)
                bsr.w   Boss_ZLeoAnimationUpdate1
                move.b  #1,(byte_FF830E).w
; Run the initial defeat transition
Boss_ZLeoRunDefeatTransition:                           ; DATA XREF: ROM:00051B88   o  ; was: loc_52096
                subq.w  #1,$11C(a5)
                bmi.s   Boss_ZLeoBeginDefeatFade
                move.w  #4,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Boss_ZLeoAnimationUpdate2
                bsr.w   Boss_ZLeoAnimationUpdate3
                lea     word_52C68(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
Boss_ZLeoBeginDefeatFade:                               ; CODE XREF: Boss_ZLeoBeginDefeatSequence+54   j  ; was: loc_520C0
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
; Advance the defeat fade before whiteout
Boss_ZLeoRunDefeatFade:                                 ; DATA XREF: ROM:00051B8A   o  ; was: loc_520C8
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   Boss_ZLeoUpdateDefeatFade
                addq.w  #1,$11C(a5)
                cmpi.w  #8,$11C(a5)
                beq.s   Boss_ZLeoBeginDefeatWhiteout
Boss_ZLeoUpdateDefeatFade:                              ; CODE XREF: Boss_ZLeoBeginDefeatSequence+8A   j  ; was: loc_520DE
                bsr.w   Boss_ZLeoFadeoutPalette
                bsr.w   Boss_ZLeoAnimationUpdate2
                lea     word_52C68(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
Boss_ZLeoBeginDefeatWhiteout:                           ; CODE XREF: Boss_ZLeoBeginDefeatSequence+96   j  ; was: loc_520F0
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.w  #$354,(a0)
                clr.w   4(a0)
                move.w  #$120,$10(a0)
                move.w  #$F0,$14(a0)
                movea.l #$FFFF2080,a0
                move.w  #$6000,d0
                moveq   #3,d7
                jsr     (Gfx_AdjustTileIndices).l
                lea     Boss_ZLeoDefeatTileLoadDescriptor(pc),a0
                nop
                jsr     (Gfx_LoadCompressedTiles).l
                move.b  #$14,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ZLeoBeginDefeatSequence
; Advance defeat whiteout, clear objects, and fill both palette banks with white
Boss_ZLeoRunDefeatWhiteout:                             ; DATA XREF: ROM:00051B8C   o  ; was: sub_52138
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   Boss_ZLeoUpdateDefeatWhiteoutFade
                addq.w  #1,$11C(a5)
                cmpi.w  #$11,$11C(a5)
                beq.s   Boss_ZLeoFinishDefeatWhiteout
Boss_ZLeoUpdateDefeatWhiteoutFade:                      ; CODE XREF: Boss_ZLeoRunDefeatWhiteout+8   j  ; was: loc_5214E
                bsr.w   Boss_ZLeoFadeoutPalette
                rts
; ---------------------------------------------------------------------------
Boss_ZLeoDefeatTileLoadDescriptor:  dc.w    $4618, $2000, $300, $405, $607  ; was: word_52154
                                        ; DATA XREF: Boss_ZLeoBeginDefeatSequence+DC   o
; ---------------------------------------------------------------------------
Boss_ZLeoFinishDefeatWhiteout:                          ; CODE XREF: Boss_ZLeoRunDefeatWhiteout+14   j  ; was: loc_5215E
                addq.w  #2,4(a5)
                clr.w   8(a5)
                move.w  #$120,$48(a5)
                move.w  #$3F8,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                movea.w #(word_FFE380-M68K_RAM),a0
                move.w  #$EEE,d0
                moveq   #$3F,d7                         ; '?'
Boss_ZLeoFillDefeatWhitePalettes:                       ; CODE XREF: Boss_ZLeoRunDefeatWhiteout+50   j  ; was: loc_52182
                move.w  d0,-$80(a0)
                move.w  d0,(a0)+
                dbf     d7,Boss_ZLeoFillDefeatWhitePalettes
; End of function Boss_ZLeoRunDefeatWhiteout
; Wait after defeat, then restore the shared UI and weapon display state
Boss_ZLeoRunPostDefeatDelay:                            ; DATA XREF: ROM:00051B8E   o  ; was: sub_5218C
                subq.w  #1,$48(a5)
                bmi.s   Boss_ZLeoRestorePostDefeatUi
                rts
; ---------------------------------------------------------------------------
Boss_ZLeoRestorePostDefeatUi:                           ; CODE XREF: Boss_ZLeoRunPostDefeatDelay+4   j  ; was: loc_52194
                addq.w  #2,4(a5)
                move.w  #$8002,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                move.w  #2,(word_FFA29C).w
                move.w  #4,(word_FF8230).w
                jmp     UI_StoreWeaponToBuffer
; End of function Boss_ZLeoRunPostDefeatDelay
; Inert post-defeat state
Boss_ZLeoPostDefeatNoOp:                                ; DATA XREF: ROM:00051B90   o  ; was: nullsub_121
                rts
; End of function Boss_ZLeoPostDefeatNoOp
; Reset the shared pose state before returning to attack selection
Boss_ZLeoBeginAttackSelection:                          ; CODE XREF: Boss_ZLeoAttackState1+5E   j  ; was: sub_521C2
                                        ; Boss_ZLeoRisingAttack+C6   j
                move.w  #$1E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $47C(a5)
; Select an opening from health thresholds and frame-derived random bits
Boss_ZLeoSelectAttackState:                             ; CODE XREF: Boss_ZLeoWaitForBossMessage+10   j  ; was: loc_521D6
                                        ; DATA XREF: ROM:00051BA0   o
                subq.w  #1,$11C(a5)
                bpl.s   Boss_ZLeoRenderAttackSelectionWait
                cmpi.w  #$4200,(word_FF8200).w
                bpl.s   Boss_ZLeoSelectLaserOpening
                moveq   #3,d1
                cmpi.w  #$2500,(word_FF8200).w
                bpl.s   Boss_ZLeoApplyLowHealthRandomMask
                moveq   #1,d1
Boss_ZLeoApplyLowHealthRandomMask:                      ; CODE XREF: Boss_ZLeoBeginAttackSelection+2A   j  ; was: loc_521F0
                move.w  (dword_FFFF08).w,d0
                and.w   d1,d0
                beq.s   Boss_ZLeoSelectAlternateOpening
Boss_ZLeoSelectLaserOpening:                            ; CODE XREF: Boss_ZLeoBeginAttackSelection+20   j  ; was: loc_521F8
                bra.w   Boss_ZLeoBeginLaserOpening
; ---------------------------------------------------------------------------
Boss_ZLeoSelectAlternateOpening:                        ; CODE XREF: Boss_ZLeoBeginAttackSelection+34   j  ; was: loc_521FC
                bra.w   Boss_ZLeoAttackInit
; ---------------------------------------------------------------------------
Boss_ZLeoRenderAttackSelectionWait:                     ; CODE XREF: Boss_ZLeoBeginAttackSelection+18   j  ; was: loc_52200
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
Boss_ZLeoBeginLaserOpening:                             ; CODE XREF: Boss_ZLeoBeginAttackSelection:Boss_ZLeoSelectLaserOpening   j  ; was: loc_5220A
                move.w  #$38,4(a5)                      ; '8'
                bsr.w   Boss_ZLeoAnimationUpdate1
                move.w  #$80,$11C(a5)
                bsr.w   Boss_ZLeoSpawnLaser
                move.w  #4,$B28(a5)
                move.w  #4,$C48(a5)
; Hold the laser opening, swap phase tiles, and select its pose table
Boss_ZLeoRunLaserOpeningDelay:                          ; DATA XREF: ROM:00051BBA   o  ; was: loc_5222A
                cmpi.w  #$60,$11C(a5)                   ; '`'
                bne.s   Boss_ZLeoAdvanceLaserOpeningDelay
                bsr.w   Boss_ZLeoLoadPhaseTiles
Boss_ZLeoAdvanceLaserOpeningDelay:                      ; CODE XREF: Boss_ZLeoBeginAttackSelection+6E   j  ; was: loc_52236
                subq.w  #1,$11C(a5)
                bpl.s   Boss_ZLeoRenderLaserOpeningDelay
                move.w  (dword_FFFF08).w,d0
                andi.w  #$C,d0
                move.w  d0,$47E(a5)
                move.l  Boss_ZLeoOpeningPoseTable(pc,d0.w),$3BC(a5)
                bra.w   Boss_ZLeoBeginOrbAttackPose
; ---------------------------------------------------------------------------
Boss_ZLeoRenderLaserOpeningDelay:                       ; CODE XREF: Boss_ZLeoBeginAttackSelection+78   j  ; was: loc_52252
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
Boss_ZLeoOpeningPoseTable:  dc.l    word_52CCC          ; DATA XREF: Boss_ZLeoBeginAttackSelection+86   r  ; was: off_5225C
                dc.l    word_52CE0
                dc.l    word_52CF4
                dc.l    word_52D08
; ---------------------------------------------------------------------------
Boss_ZLeoBeginOrbAttackPose:                            ; CODE XREF: Boss_ZLeoBeginAttackSelection+8C   j  ; was: loc_5226C
                move.w  #$20,4(a5)                      ; ' '
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $23E(a5)
                move.b  #$D1,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ZLeoBeginAttackSelection
; Attack state 1 handler
Boss_ZLeoAttackState1:                                  ; DATA XREF: ROM:00051BA2   o  ; was: sub_5228A
                bclr    #0,$23E(a5)
                bne.s   loc_5229A
                movea.l $3BC(a5),a1
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_5229A:                                              ; CODE XREF: Boss_ZLeoAttackState1+6   j
                addq.w  #2,4(a5)
; Z-Leo boss mid phase
Boss_ZLeoAttack_State28:                                ; DATA XREF: ROM:00051BA4   o  ; was: loc_5229E
                tst.w   $58(a5)
                bmi.s   loc_522B0
                bsr.w   Boss_ZLeoSpawnOrb
                movea.l $3BC(a5),a1
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_522B0:                                              ; CODE XREF: Boss_ZLeoAttackState1+18   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$11C(a5)
; Z-Leo boss rapid attack
Boss_ZLeoAttack_State30:                                ; DATA XREF: ROM:00051BA6   o  ; was: loc_522C4
                subq.w  #1,$11C(a5)
                bne.s   loc_522DC
                cmpi.w  #8,$47E(a5)
                bne.s   loc_522DC
                move.b  #$3A,d0                         ; ':'
                jsr     (Sound_PlaySFX).l
loc_522DC:                                              ; CODE XREF: Boss_ZLeoAttackState1+3E   j
                                        ; Boss_ZLeoAttackState1+46   j
                tst.w   $58(a5)
                bpl.s   loc_522EC
                move.w  #$40,$11C(a5)                   ; '@'
                bra.w   Boss_ZLeoBeginAttackSelection
; ---------------------------------------------------------------------------
loc_522EC:                                              ; CODE XREF: Boss_ZLeoAttackState1+56   j
                lea     word_52CC2(pc),a1
                nop
                bra.w   loc_52624
; End of function Boss_ZLeoAttackState1
; Initializes Z-Leo attack state - sets state $26, clears animation, enables screen effects and attack flags
Boss_ZLeoAttackInit:                                    ; CODE XREF: Boss_ZLeoBeginAttackSelection:Boss_ZLeoSelectAlternateOpening   j  ; was: sub_522F6
                move.w  #$26,4(a5)                      ; '&'
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $23E(a5)
                bset    #1,(byte_FF80EC).w
                clr.b   $21(a5)
                bset    #0,(byte_FFA272).w
; Z-Leo boss ultimate move
Boss_ZLeoAttack_State32:                                ; DATA XREF: ROM:00051BA8   o  ; was: loc_5231A
                bclr    #0,$23E(a5)
                bne.s   loc_5232C
                lea     word_52D1C(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_5232C:                                              ; CODE XREF: Boss_ZLeoAttackInit+2A   j
                addq.w  #2,4(a5)
                bset    #2,(byte_FF8245).w
                bset    #2,(word_FFDB22).w
                move.l  #$FFF00000,(dword_FFDB3C).w
                move.b  #$4F,d0                         ; 'O'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_ZLeoAnimationUpdate1
                move.w  #$E000,$59E(a5)
                move.w  #$FFF8,$59C(a5)
                move.b  #$13,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ZLeoAttackInit
; Z-Leo main attack sequence - handles laser spawning, vertical movement phases, screen scrolling, and palette cycling
Boss_ZLeoAttackSequence:                                ; DATA XREF: ROM:00051BAA   o  ; was: sub_52368
                tst.w   $58(a5)
                bmi.s   loc_52396
                cmpi.w  #$40,(dword_FFDB34).w           ; '@'
                bpl.s   loc_5238C
                move.w  #$34,(word_FFA02A).w            ; '4'
                move.w  (dword_FFDB34).w,d0
                subi.w  #$20,d0                         ; ' '
                move.w  d0,(dword_FFA414).w
                clr.l   (dword_FFDB3C).w
loc_5238C:                                              ; CODE XREF: Boss_ZLeoAttackSequence+C   j
                lea     word_52D1C(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_52396:                                              ; CODE XREF: Boss_ZLeoAttackSequence+4   j
                addq.w  #2,4(a5)
                move.w  #3,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Z-Leo boss final phase entry
Boss_ZLeoAttack_State38:                                ; DATA XREF: ROM:00051BAC   o  ; was: loc_523AA
                bclr    #0,$23E(a5)
                beq.s   loc_523D2
                movea.w #(byte_FFD100-M68K_RAM),a4
                btst    #0,$11D(a5)
                bne.s   loc_523C2
                movea.w #(byte_FFD220-M68K_RAM),a4
loc_523C2:                                              ; CODE XREF: Boss_ZLeoAttackSequence+54   j
                move.w  #9,$48(a4)
                bsr.w   Projectile_ZLeoSpawnLasers
                subq.w  #1,$11C(a5)
                bmi.s   loc_523EC
loc_523D2:                                              ; CODE XREF: Boss_ZLeoAttackSequence+48   j
                tst.w   $58(a5)
                bpl.s   loc_523E2
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_523E2:                                              ; CODE XREF: Boss_ZLeoAttackSequence+6E   j
                lea     word_52D44(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_523EC:                                              ; CODE XREF: Boss_ZLeoAttackSequence+68   j
                addq.w  #2,4(a5)
                move.b  #1,$47C(a5)
                clr.l   $41C(a5)
                move.w  #$80,$11C(a5)
; Z-Leo boss final attack 1
Boss_ZLeoAttack_State40:                                ; DATA XREF: ROM:00051BAE   o  ; was: loc_52400
                subq.w  #1,$11C(a5)
                bmi.s   loc_52446
                addi.l  #$4000,$41C(a5)
                cmpi.l  #$78000,$41C(a5)
                bmi.s   loc_52420
                move.l  #$78000,$41C(a5)
loc_52420:                                              ; CODE XREF: Boss_ZLeoAttackSequence+AE   j
                move.l  $41C(a5),d0
                asl.l   #2,d0
                add.l   d0,$35C(a5)
                cmpi.w  #$180,$35C(a5)
                bmi.s   loc_52438
                move.w  #$180,$35C(a5)
loc_52438:                                              ; CODE XREF: Boss_ZLeoAttackSequence+C8   j
                bsr.w   Boss_ZLeoScrollUpdate
                lea     word_52D44(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_52446:                                              ; CODE XREF: Boss_ZLeoAttackSequence+9C   j
                addq.w  #2,4(a5)
                move.w  #$80,$11C(a5)
; Z-Leo boss final attack 2
Boss_ZLeoAttack_State42:                                ; DATA XREF: ROM:00051BB0   o  ; was: loc_52450
                subq.w  #1,$11C(a5)
                bmi.s   loc_52462
loc_52456:                                              ; CODE XREF: Boss_ZLeoAttackSequence:loc_5250E   j
                bsr.w   Boss_ZLeoScrollUpdate
                bsr.w   Boss_ZLeoTileUpdate
                bra.w   Boss_ZLeoGraphicsInit2
; ---------------------------------------------------------------------------
loc_52462:                                              ; CODE XREF: Boss_ZLeoAttackSequence+EC   j
                addq.w  #2,4(a5)
                move.l  #$FFC00000,(dword_FFDB34).w
                move.l  #$50000,(dword_FFDB3C).w
                move.w  #$120,(dword_FFA410).w
                move.w  (dword_FFDB34).w,d0
                subi.w  #$20,d0                         ; ' '
                move.w  d0,(dword_FFA414).w
                move.w  #$80,$11C(a5)
; Z-Leo boss final attack 3
Boss_ZLeoAttack_State44:                                ; DATA XREF: ROM:00051BB2   o  ; was: loc_5248E
                tst.w   (word_FFA02A).w
                beq.s   loc_524AC
                cmpi.w  #$C0,(dword_FFDB34).w
                bmi.s   loc_524AC
                clr.w   (word_FFA02A).w
                bclr    #2,(byte_FF8245).w
                bclr    #0,(byte_FFA272).w
loc_524AC:                                              ; CODE XREF: Boss_ZLeoAttackSequence+12A   j
                                        ; Boss_ZLeoAttackSequence+132   j
                btst    #2,(word_FFDB22).w
                beq.s   loc_524C8
                subi.l  #$880,(dword_FFDB3C).w
                bpl.s   loc_524CE
                bclr    #2,(word_FFDB22).w
                clr.l   (dword_FFDB3C).w
loc_524C8:                                              ; CODE XREF: Boss_ZLeoAttackSequence+14A   j
                subq.w  #1,$11C(a5)
                bmi.s   loc_524EA
loc_524CE:                                              ; CODE XREF: Boss_ZLeoAttackSequence+154   j
                subi.l  #$2000,$41C(a5)
                cmpi.l  #$FFF88000,$41C(a5)
                bpl.s   loc_524E8
                move.l  #$FFF88000,$41C(a5)
loc_524E8:                                              ; CODE XREF: Boss_ZLeoAttackSequence+176   j
                bra.s   loc_524F6
; ---------------------------------------------------------------------------
loc_524EA:                                              ; CODE XREF: Boss_ZLeoAttackSequence+164   j
                addq.w  #2,4(a5)
; Z-Leo boss final attack 4
Boss_ZLeoAttack_State46:                                ; DATA XREF: ROM:00051BB4   o  ; was: loc_524EE
                cmpi.w  #$240,(dword_FFA90C).w
                bmi.s   Boss_ZLeoRisingAttack
loc_524F6:                                              ; CODE XREF: Boss_ZLeoAttackSequence:loc_524E8   j
                bsr.w   Boss_ZLeoPaletteRotate
                tst.w   (word_FFA02A).w
                bne.s   loc_5250E
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_5250E
                bsr.w   Projectile_ZLeoSpawnDropProjectile
loc_5250E:                                              ; CODE XREF: Boss_ZLeoAttackSequence+196   j
                                        ; Boss_ZLeoAttackSequence+1A0   j
                bra.w   loc_52456
; End of function Boss_ZLeoAttackSequence
; Cycles Z-Leo palette colors based on frame counter - rotates 3 palette entries in 4 different patterns
