; Destroyer Proto main dispatcher, intro, and six-part polar geometry
; Dispatches type $3B8 through the subtype index stored at entity offset $48
Entity_DispatchStoredSubtype:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_314C2
                move.w  $48(a5),d0
                lea     Entity_StoredSubtypeHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Entity_DispatchStoredSubtype
; ---------------------------------------------------------------------------
Entity_StoredSubtypeHandlers:   dc.w    Boss_DestroyerProtoMain-*  ; DATA XREF: Entity_DispatchStoredSubtype+4   o  ; was: off_314CE
                dc.w    Boss_DestroyerProtoPartMain-*
                dc.w    Boss_DestroyerProtoAnimatedPartMain-*
                dc.w    Projectile_DestroyerProtoMain-*
                dc.w    Projectile_HitReactiveShotMain-*

; Main boss handler
Boss_DestroyerProtoMain:                                ; DATA XREF: ROM:Entity_StoredSubtypeHandlers   o  ; was: sub_314D8
                jsr     (Gfx_ProcessDefaultColorFade).l
                bsr.w   Boss_DestroyerProtoCycleArenaEffect
                cmpi.w  #$2E,4(a5)                      ; '.'
                bcc.s   Boss_DestroyerProtoDispatchState
                tst.w   (word_FF8200).w
                bne.s   Boss_DestroyerProtoDispatchState
                bset    #0,(byte_FFA272).w
                move.w  #1,(dword_FF9414+2).w
                move.w  #$2E,4(a5)                      ; '.'
Boss_DestroyerProtoDispatchState:                       ; CODE XREF: Boss_DestroyerProtoMain+10   j  ; was: loc_31502
                                        ; Boss_DestroyerProtoMain+16   j
                move.w  4(a5),d0
                lea     Boss_DestroyerProtoStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerProtoMain
; ---------------------------------------------------------------------------
Boss_DestroyerProtoStates:  dc.w    Boss_DestroyerProtoIntroInit-*  ; DATA XREF: Boss_DestroyerProtoMain+2E   o  ; was: off_3150E
                dc.w    Boss_DestroyerProtoIntroMove-*
                dc.w    Boss_DestroyerProtoWaitForBattleStart-*
                dc.w    Boss_DestroyerProtoChooseMovementTarget-*
                dc.w    Boss_DestroyerProtoMoveToTarget-*
                dc.w    Boss_DestroyerProtoChooseAttack-*
                dc.w    Boss_DestroyerProtoOpenPartsForTwinShot-*
                dc.w    Boss_DestroyerProtoLaunchTwinShots-*
                dc.w    Boss_DestroyerProtoFadeTwinShots-*
                dc.w    Boss_DestroyerProtoWaitAfterTwinShots-*
                dc.w    Boss_DestroyerProtoRetreatAfterTwinShots-*
                dc.w    Boss_DestroyerProtoOpenPartsForSpread-*
                dc.w    Boss_DestroyerProtoChargeSpread-*
                dc.w    Boss_DestroyerProtoFireSpread-*
                dc.w    Boss_DestroyerProtoRecoverSpread-*
                dc.w    Boss_DestroyerProtoRetreatAfterSpread-*
                dc.w    Boss_DestroyerProtoOpenPartsForStream-*
                dc.w    Boss_DestroyerProtoChargeStream-*
                dc.w    Boss_DestroyerProtoWaitBeforeStream-*
                dc.w    Boss_DestroyerProtoFireStream-*
                dc.w    Boss_DestroyerProtoFadeStream-*
                dc.w    Boss_DestroyerProtoWaitAfterStream-*
                dc.w    Boss_DestroyerProtoRetreatAfterStream-*
                dc.w    Boss_DestroyerProtoBeginDefeatScatter-*
                dc.w    Boss_DestroyerProtoUpdateDefeatExplosion-*

; Cycles two arena-effect words every fourth tick
Boss_DestroyerProtoCycleArenaEffect:                    ; CODE XREF: Boss_DestroyerProtoMain+6   p  ; was: sub_31540
                move.w  (FrameCounter).w,d0
                andi.w  #3,d0
                bne.w   Entity_UpdateReturn
                move.w  (dword_FF9400).w,d0
                addq.w  #2,d0
                cmpi.w  #$14,d0
                bcs.s   Boss_DestroyerProtoStoreArenaEffectPhase
                clr.w   d0
Boss_DestroyerProtoStoreArenaEffectPhase:               ; CODE XREF: Boss_DestroyerProtoCycleArenaEffect+16   j  ; was: loc_3155A
                move.w  d0,(dword_FF9400).w
                move.w  Boss_DestroyerProtoArenaEffectValueATable(pc,d0.w),(word_FFE366).w
                move.w  Boss_DestroyerProtoArenaEffectValueBTable(pc,d0.w),(word_FFE368).w
                rts
; End of function Boss_DestroyerProtoCycleArenaEffect
; ---------------------------------------------------------------------------
Boss_DestroyerProtoArenaEffectValueATable:  dc.w    $2C8, $A6, $84, $62, $40, $20, $40, $62, $84, $A6  ; was: word_3156C
                                        ; DATA XREF: Boss_DestroyerProtoCycleArenaEffect+1E   r
Boss_DestroyerProtoArenaEffectValueBTable:  dc.w    $64, $44, $42, $22, $20, 0, $20, $22, $42, $44  ; was: word_31580
                                        ; DATA XREF: Boss_DestroyerProtoCycleArenaEffect+24   r

; Intro animation init
Boss_DestroyerProtoIntroInit:                           ; DATA XREF: ROM:Boss_DestroyerProtoStates   o  ; was: sub_31594
                clr.w   (dword_FF9414+2).w
                move.w  #$E0,$14(a5)
                move.w  #$200,$10(a5)
                bsr.w   Boss_DestroyerProtoUpdateViewportOffset
                tst.w   (word_FFF720).w
                bmi.w   Entity_UpdateReturn
                move.b  #4,(byte_FFA95A).w
                move.b  #$50,$21(a5)                    ; 'P'
                move.b  #$98,$23(a5)
                move.w  #$18,$24(a5)
                move.w  #$4C00,2(a5)
                move.l  #$E020E020,$2C(a5)
                move.l  #$D030D030,$28(a5)
                move.w  #$8C,$26(a5)
                movea.l #Boss_DestroyerProtoGraphicsLoadDescriptor,a0
                jsr     (Tilemap_QueueIndexedRows).l
                addq.w  #2,4(a5)
                movea.w a5,a4
                move.w  #5,d6
Boss_DestroyerProtoInitNextPart:                        ; CODE XREF: Boss_DestroyerProtoIntroInit+DC   j  ; was: loc_315FA
                adda.w  #$60,a4                         ; '`'
                move.w  $10(a5),$10(a4)
                move.w  $14(a5),$14(a4)
                move.w  #$CC00,2(a4)
                move.w  #$3B8,(a4)
                move.w  #$6300,$E(a4)
                move.b  #$30,$20(a4)                    ; '0'
                move.b  #$C0,$21(a4)
                move.b  #$10,$23(a4)
                move.l  #$FC04FC04,$2C(a4)
                move.l  #$F010F010,$28(a4)
                move.w  #$3C,$26(a4)                    ; '<'
                move.w  d6,d0
                lsl.w   #1,d0
                move.w  Boss_DestroyerProtoPartAngleTable(pc,d0.w),$40(a4)
                move.w  $40(a4),$46(a4)
                move.w  Boss_DestroyerProtoPartRadiusTable(pc,d0.w),$42(a4)
                move.w  Boss_DestroyerProtoPartParentSlotTable(pc,d0.w),$44(a4)
                move.w  Boss_DestroyerProtoPartSubtypeTable(pc,d0.w),d0
                move.w  d0,$48(a4)
                subq.w  #2,d0
                lsl.w   #1,d0
                move.l  Boss_DestroyerProtoPartMappingTable(pc,d0.w),8(a4)
                dbf     d6,Boss_DestroyerProtoInitNextPart
                rts
; End of function Boss_DestroyerProtoIntroInit
; ---------------------------------------------------------------------------
Boss_DestroyerProtoPartAngleTable:  dc.w    $40, $40, $40, $140, $140, $140  ; was: word_31676
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+B2   r
Boss_DestroyerProtoPartRadiusTable: dc.w    $A0, $40, $E0, $A0, $40, $E0  ; was: word_31682
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+BE   r
                                        ; Boss_DestroyerProtoOpenParts+4   o
Boss_DestroyerProtoPartParentSlotTable: dc.w    $C800, $C7A0, $C620, $C6E0, $C680, $C620  ; was: word_3168E
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+C4   r
Boss_DestroyerProtoPartSubtypeTable:    dc.w    4, 2, 2, 4, 2, 2  ; DATA XREF: Boss_DestroyerProtoIntroInit+CA   r  ; was: word_3169A
Boss_DestroyerProtoPartMappingTable:    dc.l    Boss_DestroyerProtoSpriteFrame10  ; DATA XREF: Boss_DestroyerProtoIntroInit+D6   r  ; was: off_316A6
                dc.l    Boss_DestroyerProtoSpriteFrame01
Boss_DestroyerProtoGraphicsLoadDescriptor:  dc.w    $4000, $2000, $303, $5051, $5253, $5455, $5657, $5859, $5A5B, $5C5D, $5E5F  ; was: word_316AE
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+50   o

; Intro movement
Boss_DestroyerProtoIntroMove:                           ; DATA XREF: ROM:00031510   o  ; was: sub_316C4
                bsr.w   Boss_DestroyerProtoUpdateCircularVelocity
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w   Boss_DestroyerProtoUpdatePartAngles
                subi.w  #2,$18(a5)
                bsr.w   Boss_DestroyerProtoUpdateViewportOffset
                cmpi.w  #$160,$10(a5)
                bcc.w   Entity_UpdateReturn
                move.w  #3,d0
                jsr     (BossMessage_Start).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoIntroMove
; Advances the core angle and derives circular X/Y velocity
Boss_DestroyerProtoUpdateCircularVelocity:              ; CODE XREF: Boss_DestroyerProtoIntroMove   p  ; was: sub_316F8
                                        ; sub_317FE   p
                addq.w  #8,$40(a5)
                andi.w  #$1FE,$40(a5)
                move.w  $40(a5),d0
                bsr.w   Math_LookupSineCosinePairDuplicate
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a5)
                ext.l   d1
                asl.l   #2,d1
                move.l  d1,$1C(a5)
                rts
; End of function Boss_DestroyerProtoUpdateCircularVelocity
; Publishes position deltas from the arena's right and upper reference points
Boss_DestroyerProtoUpdateViewportOffset:                ; CODE XREF: Boss_DestroyerProtoIntroInit+10   p  ; was: sub_3171C
                                        ; Boss_DestroyerProtoIntroMove+16   p
                move.w  #$2C0,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA900).w
                move.w  $14(a5),d0
                subi.w  #$C0,d0
                move.w  d0,(dword_FFA904).w
                rts
; End of function Boss_DestroyerProtoUpdateViewportOffset
; Advances the polar angles of all six linked parts
Boss_DestroyerProtoUpdatePartAngles:                    ; CODE XREF: Boss_DestroyerProtoIntroMove+C   p  ; was: sub_31736
                                        ; Boss_DestroyerProtoWaitForBattleStart+C   p
                lea     (word_FFC680).w,a4
                bsr.w   Boss_DestroyerProtoAddOuterPartAngle
                lea     (word_FFC6E0).w,a4
                bsr.w   Boss_DestroyerProtoAddOuterPartAngle
                lea     (word_FFC7A0).w,a4
                bsr.w   Boss_DestroyerProtoAddOuterPartAngle
                lea     (word_FFC800).w,a4
                bsr.w   Boss_DestroyerProtoAddOuterPartAngle
                lea     (word_FFC740).w,a4
                bsr.w   Boss_DestroyerProtoAddInnerPartAngles
                lea     (word_FFC860).w,a4
                bsr.w   Boss_DestroyerProtoAddInnerPartAngles
                rts
; End of function Boss_DestroyerProtoUpdatePartAngles
; Advances one outer part angle by d0.w
Boss_DestroyerProtoAddOuterPartAngle:                   ; CODE XREF: Boss_DestroyerProtoUpdatePartAngles+4   p  ; was: sub_31768
                                        ; Boss_DestroyerProtoUpdatePartAngles+C   p
                add.w   d0,$40(a4)
                andi.w  #$1FE,$40(a4)
                rts
; End of function Boss_DestroyerProtoAddOuterPartAngle
; Advances both angle fields of one inner part by d1.w
Boss_DestroyerProtoAddInnerPartAngles:                  ; CODE XREF: Boss_DestroyerProtoUpdatePartAngles+24   p  ; was: sub_31774
                                        ; Boss_DestroyerProtoUpdatePartAngles+2C   p
                add.w   d1,$40(a4)
                andi.w  #$1FE,$40(a4)
                add.w   d1,$46(a4)
                andi.w  #$1FE,$46(a4)
                rts
; End of function Boss_DestroyerProtoAddInnerPartAngles
; Contracts the radii of all six parts toward zero
Boss_DestroyerProtoCloseParts:                          ; CODE XREF: Boss_DestroyerProtoChooseAttack+4   p  ; was: sub_3178A
                                        ; Boss_DestroyerProtoRetreatAfterTwinShots+4   p
                lea     (word_FFC680).w,a4
                move.w  #5,d0
Boss_DestroyerProtoCloseNextPart:                       ; CODE XREF: Boss_DestroyerProtoCloseParts+18   j  ; was: loc_31792
                tst.w   $42(a4)
                beq.s   Boss_DestroyerProtoContinueCloseParts
                subi.w  #8,$42(a4)
Boss_DestroyerProtoContinueCloseParts:                  ; CODE XREF: Boss_DestroyerProtoCloseParts+C   j  ; was: loc_3179E
                adda.w  #$60,a4                         ; '`'
                dbf     d0,Boss_DestroyerProtoCloseNextPart
                rts
; End of function Boss_DestroyerProtoCloseParts
; Expands all six part radii to their configured values
Boss_DestroyerProtoOpenParts:                           ; CODE XREF: Boss_DestroyerProtoMoveToTarget   p  ; was: sub_317A8
                                        ; sub_3198C   p
                lea     (word_FFC680).w,a4
                lea     Boss_DestroyerProtoPartRadiusTable(pc),a0
                move.w  #5,d0
Boss_DestroyerProtoOpenNextPart:                        ; CODE XREF: Boss_DestroyerProtoOpenParts+24   j  ; was: loc_317B4
                move.w  d0,d1
                lsl.w   #1,d1
                move.w  (a0,d1.w),d2
                cmp.w   $42(a4),d2
                beq.s   Boss_DestroyerProtoContinueOpenParts
                addi.w  #8,$42(a4)
Boss_DestroyerProtoContinueOpenParts:                   ; CODE XREF: Boss_DestroyerProtoOpenParts+18   j  ; was: loc_317C8
                adda.w  #$60,a4                         ; '`'
                dbf     d0,Boss_DestroyerProtoOpenNextPart
                rts
; End of function Boss_DestroyerProtoOpenParts
; Synchronizes rotation angles across multiple Destroyer Proto boss parts using base angle and offset
Boss_DestroyerSyncPartAngles:                           ; CODE XREF: Boss_DestroyerProtoRetreatAfterTwinShots+20   p  ; was: sub_317D2
                                        ; Boss_DestroyerProtoRetreatAfterSpread+20   p
                move.w  (word_FFC6C0).w,d2
                move.w  d2,d3
                addi.w  #$100,d3
                andi.w  #$1FE,d3
                move.w  d2,(word_FFC720).w
                move.w  d2,(word_FFC780).w
                move.w  d2,(word_FFC786).w
                move.w  d3,(word_FFC7E0).w
                move.w  d3,(word_FFC840).w
                move.w  d3,(word_FFC8A0).w
                move.w  d3,(word_FFC8A6).w
                rts
; End of function Boss_DestroyerSyncPartAngles
; Maintains intro motion until the battle-start transition completes
Boss_DestroyerProtoWaitForBattleStart:                  ; DATA XREF: ROM:00031512   o  ; was: sub_317FE
                bsr.w   Boss_DestroyerProtoUpdateCircularVelocity
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w   Boss_DestroyerProtoUpdatePartAngles
                bsr.w   Boss_DestroyerProtoUpdateViewportOffset
                tst.w   (MessageSequenceState).w
                bne.w   Entity_UpdateReturn
                clr.b   (byte_FF80EC).w
                andi.b  #$EF,$23(a5)
                move.w  #$20,$4A(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoWaitForBattleStart
