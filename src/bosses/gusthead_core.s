Boss_GustheadMainWrapper:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3F1A0
                bsr.s   Boss_GustheadMain
                rts
; End of function Boss_GustheadMainWrapper
; Main Gusthead boss handler
Boss_GustheadMain:                                      ; CODE XREF: Boss_GustheadMainWrapper   p  ; was: sub_3F1A4
                tst.w   4(a5)
                beq.w   loc_3F240
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_3F1D2
                addq.w  #4,$58(a5)
                andi.w  #4,$58(a5)
                move.w  $58(a5),d0
                lea     off_3F198(pc),a1
                move.l  (a1,d0.w),8(a5)
                clr.w   $C(a5)
loc_3F1D2:                                              ; CODE XREF: Boss_GustheadMain+10   j
                tst.w   (word_FFA968).w
                beq.s   loc_3F1E0
                move.l  (dword_FFA960).w,d0
                add.l   d0,$10(a5)
loc_3F1E0:                                              ; CODE XREF: Boss_GustheadMain+32   j
                cmpi.w  #$50,4(a5)                      ; 'P'
                bcc.s   loc_3F1F0
                move.l  (dword_FF8240).w,(dword_FF9428).w
                bra.s   loc_3F1FC
; ---------------------------------------------------------------------------
loc_3F1F0:                                              ; CODE XREF: Boss_GustheadMain+42   j
                move.l  (dword_FFA960).w,d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,(dword_FF9428).w
loc_3F1FC:                                              ; CODE XREF: Boss_GustheadMain+4A   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3F22E
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3F22E
                tst.w   (word_FF8200).w
                bne.s   loc_3F22E
                move.b  #2,(byte_FF80EC).w
                bset    #7,$4A(a5)
                clr.l   (dword_FF8240).w
                move.w  #$5C,4(a5)                      ; '\'
                bset    #0,(byte_FFA272).w
loc_3F22E:                                              ; CODE XREF: Boss_GustheadMain+5E   j
                                        ; Boss_GustheadMain+66   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$5C(a5)
loc_3F240:                                              ; CODE XREF: Boss_GustheadMain+4   j
                move.w  4(a5),d0
                lea     off_3F24C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_GustheadMain
; ---------------------------------------------------------------------------
off_3F24C:      dc.w    Boss_GustheadInitBattle-*       ; DATA XREF: Boss_GustheadMain+A0   o
                dc.w    Boss_GustheadSetupParts-*
                dc.w    Boss_GustheadStartIntro-*
                dc.w    Boss_GustheadIntroFlicker-*
                dc.w    Boss_GustheadIntroReveal-*
                dc.w    Boss_GustheadBattleStart-*
                dc.w    Boss_GustheadDefeatSequence-*
                dc.w    Boss_GustheadTentacleMain-*
                dc.w    Boss_GustheadTentacleUpdate-*
                dc.w    Boss_GustheadTentacleDamage-*
                dc.w    Boss_GustheadTentacleDamage_RetractLoop-*
                dc.w    Boss_GustheadTentacleDefeat-*
                dc.w    Boss_GustheadDefeatPhase1-*
                dc.w    Boss_GustheadDefeatPhase2-*
                dc.w    Boss_GustheadDefeatPhase3-*
                dc.w    Boss_GustheadDefeatPhase4-*
                dc.w    Boss_GustheadInitBounceMovement-*
                dc.w    Boss_GustheadInitBounceMovement_UpdateLoop-*
                dc.w    Boss_GustheadBounceAttackLogic-*
                dc.w    Boss_GustheadInitFallMovement-*
                dc.w    Boss_GustheadFallBounceLogic-*
                dc.w    Boss_GustheadInitDefeatBounce-*
                dc.w    Boss_GustheadInitDefeatBounce_RiseLoop-*
                dc.w    Boss_GustheadAttackSequence1-*
                dc.w    Boss_GustheadRepositionAttack-*
                dc.w    Boss_GustheadScrollUp-*
                dc.w    Boss_GustheadFlipSprite-*
                dc.w    Boss_GustheadReturnToIdle-*
                dc.w    Boss_GustheadDefeatStart-*
                dc.w    Boss_GustheadDefeatStart_UpdateLoop-*
                dc.w    Boss_GustheadDefeatStart_UpdateLoop-*
                dc.w    Boss_GustheadDefeatStart_UpdateLoop-*
                dc.w    Boss_GustheadRiseAttack-*
                dc.w    Boss_GustheadRiseAttack_UpdateLoop-*
                dc.w    Boss_GustheadAttackSequence2-*
                dc.w    Boss_GustheadMoveToPosition-*
                dc.w    Boss_GustheadScrollDown-*
                dc.w    Boss_GustheadFlipSprite2-*
                dc.w    Boss_GustheadPrepareDefeat-*
                dc.w    Boss_GustheadDefeatScrollReset-*
                dc.w    Boss_GustheadDefeat_ResetPhysics-*
                dc.w    Boss_GustheadDefeatScrollReset_TentacleLoop-*
                dc.w    Boss_GustheadDefeatSink-*
                dc.w    Boss_GustheadDefeatWaitCamera-*
                dc.w    Boss_GustheadRotateAttack-*
                dc.w    Boss_GustheadRotateWait-*
                dc.w    Boss_GustheadDefeatInitPhase-*
                dc.w    Boss_GustheadDefeatSlowScroll-*
                dc.w    Boss_GustheadDefeatFall-*
                dc.w    Boss_GustheadDefeatStopScroll-*
                dc.w    Boss_GustheadDefeatCheck-*
                dc.w    Boss_GustheadDefeatExit-*
                dc.w    Boss_GustheadDefeatWait-*
                dc.w    Boss_GustheadDefeatFinalize-*

; Initializes Gusthead battle
Boss_GustheadInitBattle:                                ; DATA XREF: ROM:off_3F24C   o  ; was: sub_3F2B8
                tst.w   (word_FFF720).w
                bmi.w   locret_4076C
                addq.w  #2,4(a5)
                move.w  #$1B0,d0
                moveq   #0,d1
                jmp     Object_ClearAllExceptTypes
; End of function Boss_GustheadInitBattle
; Sets up boss parts and tentacles
Boss_GustheadSetupParts:                                ; DATA XREF: ROM:0003F24E   o  ; was: sub_3F2D0
                addq.w  #2,4(a5)
                clr.l   (dword_FF9400).w
                clr.l   (dword_FF9404).w
                clr.l   (dword_FF9408).w
                clr.l   (dword_FF940C).w
                clr.l   (dword_FF9410).w
                clr.l   (dword_FF9414).w
                clr.l   (dword_FF9418).w
                clr.l   (dword_FF941C).w
                clr.l   (dword_FF9420).w
                clr.w   (dword_FF9424).w
                move.b  #4,(byte_FFA420).w
                move.w  #$120,$10(a5)
                move.w  #$F0,$14(a5)
                move.b  #$40,$20(a5)                    ; '@'
                move.w  #$4C00,2(a5)
                move.b  #$10,$21(a5)
                move.b  #$88,$23(a5)
                move.l  #$F808F808,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$16,$24(a5)
                move.w  #$50,$26(a5)                    ; 'P'
                move.w  #$300,$E(a5)
                move.l  #word_EBFF8,8(a5)
                move.w  #3,d7
                movea.w a5,a0
                lea     $60(a0),a0
                clr.b   d5
loc_3F35C:                                              ; CODE XREF: Boss_GustheadSetupParts+DA   j
                move.w  #3,d6
                clr.b   d0
loc_3F362:                                              ; CODE XREF: Boss_GustheadSetupParts+D2   j
                move.w  #$1BC,(a0)
                move.w  #$4C00,2(a0)
                move.w  #$B00,$E(a0)
                move.l  #word_EC022,8(a0)
                tst.b   d0
                bne.s   loc_3F386
                move.w  #$28,$48(a0)                    ; '('
                bra.s   loc_3F38C
; ---------------------------------------------------------------------------
loc_3F386:                                              ; CODE XREF: Boss_GustheadSetupParts+AC   j
                move.w  #$18,$48(a0)
loc_3F38C:                                              ; CODE XREF: Boss_GustheadSetupParts+B4   j
                move.w  #$80,d1
                add.w   d1,$48(a0)
                move.b  d5,$4B(a0)
                move.b  d0,$4A(a0)
                lea     $60(a0),a0
                addq.b  #1,d0
                dbf     d6,loc_3F362
                addi.b  #$40,d5                         ; '@'
                dbf     d7,loc_3F35C
                move.w  #$10,(a0)
                move.w  #$6100,2(a0)
                move.l  #off_E9680,8(a0)
                move.w  #$480,$E(a0)
                rts
; End of function Boss_GustheadSetupParts
; Starts boss intro sequence
Boss_GustheadStartIntro:                                ; DATA XREF: ROM:0003F250   o  ; was: sub_3F3C8
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5)                    ; ' '
                rts
; End of function Boss_GustheadStartIntro
; Intro flicker animation
Boss_GustheadIntroFlicker:                              ; DATA XREF: ROM:0003F252   o  ; was: sub_3F3D4
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3F3E4
                eori.w  #$8000,2(a5)
loc_3F3E4:                                              ; CODE XREF: Boss_GustheadIntroFlicker+8   j
                subq.w  #1,$48(a5)
                bne.s   locret_3F3F4
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5)                    ; ' '
locret_3F3F4:                                           ; CODE XREF: Boss_GustheadIntroFlicker+14   j
                rts
; End of function Boss_GustheadIntroFlicker
; Reveals boss with tentacle setup
Boss_GustheadIntroReveal:                               ; DATA XREF: ROM:0003F254   o  ; was: sub_3F3F6
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                bne.s   loc_3F406
                eori.w  #$8000,2(a5)
loc_3F406:                                              ; CODE XREF: Boss_GustheadIntroReveal+8   j
                subq.w  #1,$48(a5)
                bne.s   locret_3F44A
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #$10,(dword_FF940C).w
                move.w  #$40,(dword_FF9400).w           ; '@'
                move.w  #$80,(dword_FF9404).w
                move.w  #$180,(dword_FF9408).w
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateBounce
locret_3F44A:                                           ; CODE XREF: Boss_GustheadIntroReveal+14   j
                rts
; End of function Boss_GustheadIntroReveal
; Starts active battle phase
Boss_GustheadBattleStart:                               ; DATA XREF: ROM:0003F256   o  ; was: sub_3F44C
                move.w  #3,d7
                movea.w a5,a0
                lea     $60(a0),a0
loc_3F456:                                              ; CODE XREF: Boss_GustheadBattleStart+1C   j
                move.w  #3,d6
loc_3F45A:                                              ; CODE XREF: Boss_GustheadBattleStart+18   j
                subi.w  #2,$48(a0)
                lea     $60(a0),a0
                dbf     d6,loc_3F45A
                dbf     d7,loc_3F456
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_3F488
                addq.w  #2,4(a5)
locret_3F488:                                           ; CODE XREF: Boss_GustheadBattleStart+36   j
                rts
; End of function Boss_GustheadBattleStart
; Boss defeat animation sequence
Boss_GustheadDefeatSequence:                            ; DATA XREF: ROM:0003F258   o  ; was: sub_3F48A
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                subi.l  #$2000,(dword_FF940C).w
                bne.s   locret_3F4C0
                ori.w   #$8000,2(a5)
                move.b  #$50,$21(a5)                    ; 'P'
                addq.w  #2,4(a5)
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
locret_3F4C0:                                           ; CODE XREF: Boss_GustheadDefeatSequence+1A   j
                rts
; End of function Boss_GustheadDefeatSequence
; Main handler for tentacle part
Boss_GustheadTentacleMain:                              ; DATA XREF: ROM:0003F25A   o  ; was: sub_3F4C2
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateBounce
                tst.w   (word_FF80C2).w
                bne.s   locret_3F4E8
                clr.b   (byte_FF80EC).w
                ori.w   #$100,2(a5)
                subi.w  #$A0,(word_FFA970).w
                addq.w  #2,4(a5)
locret_3F4E8:                                           ; CODE XREF: Boss_GustheadTentacleMain+10   j
                rts
; End of function Boss_GustheadTentacleMain
; Updates single tentacle position
Boss_GustheadTentacleUpdate:                            ; DATA XREF: ROM:0003F25C   o  ; was: sub_3F4EA
                cmpi.w  #$3200,(word_FF8200).w
                bcs.s   Boss_GustheadTentacleExtendStart
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                tst.w   d0
                beq.s   loc_3F50A
                cmpi.w  #1,d0
                beq.s   loc_3F51A
                cmpi.w  #2,d0
                beq.s   loc_3F52A
loc_3F50A:                                              ; CODE XREF: Boss_GustheadTentacleUpdate+12   j
                move.w  #1,$5A(a5)
                move.w  #$12,4(a5)
                bra.w   Boss_GustheadTentacleDamage
; ---------------------------------------------------------------------------
loc_3F51A:                                              ; CODE XREF: Boss_GustheadTentacleUpdate+18   j
                move.w  #3,$5A(a5)
                move.w  #$20,4(a5)                      ; ' '
                bra.w   Boss_GustheadInitBounceMovement
; ---------------------------------------------------------------------------
loc_3F52A:                                              ; CODE XREF: Boss_GustheadTentacleUpdate+1E   j
                move.w  #2,$5A(a5)
                move.w  #$2A,4(a5)                      ; '*'
                bra.w   Boss_GustheadInitDefeatBounce
; End of function Boss_GustheadTentacleUpdate
; Alternative tentacle retraction routine for Gusthead boss
Boss_GustheadTentacleRetractAlt:
                bset    #6,$4A(a5)                      ; was: sub_3F53A
                move.w  #$38,4(a5)                      ; '8'
                bra.w   Boss_GustheadDefeatStart
; End of function Boss_GustheadTentacleRetractAlt
; Initializes tentacle extension state for Gusthead boss
Boss_GustheadTentacleExtendStart:                       ; CODE XREF: Boss_GustheadTentacleUpdate+6   j  ; was: sub_3F54A
                bset    #6,$4A(a5)
                move.w  #1,(word_FFA968).w
                clr.l   (dword_FFA960).w
                move.w  #$40,4(a5)                      ; '@'
                bra.w   Boss_GustheadRiseAttack
; End of function Boss_GustheadTentacleExtendStart
; Handles tentacle damage
Boss_GustheadTentacleDamage:                            ; CODE XREF: Boss_GustheadTentacleUpdate+2C   j  ; was: sub_3F564
                                        ; DATA XREF: ROM:0003F25E   o
                addq.w  #2,4(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                clr.l   (dword_FF940C).w
                clr.l   (dword_FF9410).w
                clr.l   (dword_FF9414).w
                andi.l  #$1F80000,(dword_FF9400).w
                andi.l  #$1F80000,(dword_FF9404).w
                andi.l  #$1F80000,(dword_FF9408).w
                move.w  #$F0,$52(a5)
; Update tentacles during retract phase after damage
Boss_GustheadTentacleDamage_RetractLoop:                ; DATA XREF: ROM:0003F260   o  ; was: loc_3F5A2
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadTentacleRetract
                subi.w  #8,(dword_FF9404).w
                andi.w  #$1F8,(dword_FF9404).w
                bne.w   locret_4076C
                addq.w  #2,4(a5)
                move.l  #$FFFE0000,(dword_FF9410).w
                move.l  #$1000,(dword_FF941C).w
                cmpi.w  #$120,(dword_FFA410).w
                bcc.s   loc_3F5E4
                move.l  #$FFFFF000,(dword_FF9418).w
                bra.s   locret_3F5EC
; ---------------------------------------------------------------------------
loc_3F5E4:                                              ; CODE XREF: Boss_GustheadTentacleDamage+74   j
                move.l  #$1000,(dword_FF9418).w
locret_3F5EC:                                           ; CODE XREF: Boss_GustheadTentacleDamage+7E   j
                rts
; End of function Boss_GustheadTentacleDamage
; Tentacle defeat sequence
Boss_GustheadTentacleDefeat:                            ; DATA XREF: ROM:0003F262   o  ; was: sub_3F5EE
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadCoreMain
                bsr.s   Boss_GustheadTentacleRetract
                move.l  (dword_FF9418).w,d0
                add.l   d0,(dword_FF940C).w
                cmpi.l  #$C0000,(dword_FF940C).w
                beq.s   loc_3F620
                cmpi.l  #$FFF40000,(dword_FF940C).w
                bne.s   locret_3F62A
loc_3F620:                                              ; CODE XREF: Boss_GustheadTentacleDefeat+26   j
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_3F62A:                                           ; CODE XREF: Boss_GustheadTentacleDefeat+30   j
                rts
; End of function Boss_GustheadTentacleDefeat
; Retracts defeated tentacle
Boss_GustheadTentacleRetract:                           ; CODE XREF: Boss_GustheadTentacleDamage+46   p  ; was: sub_3F62C
                                        ; Boss_GustheadTentacleDefeat+14   p
                move.w  $10(a5),d0
                sub.w   (dword_FFA410).w,d0
                bpl.s   loc_3F638
                neg.w   d0
loc_3F638:                                              ; CODE XREF: Boss_GustheadTentacleRetract+8   j
                cmpi.w  #$10,d0
                bhi.s   loc_3F644
                clr.w   $50(a5)
                bra.s   loc_3F65A
; ---------------------------------------------------------------------------
loc_3F644:                                              ; CODE XREF: Boss_GustheadTentacleRetract+10   j
                cmpi.w  #$120,(dword_FFA410).w
                bcc.s   loc_3F654
                move.w  #$160,$50(a5)
                bra.s   loc_3F65A
; ---------------------------------------------------------------------------
loc_3F654:                                              ; CODE XREF: Boss_GustheadTentacleRetract+1E   j
                move.w  #$E0,$50(a5)
loc_3F65A:                                              ; CODE XREF: Boss_GustheadTentacleRetract+16   j
                                        ; Boss_GustheadTentacleRetract+26   j
                tst.w   $50(a5)
                beq.s   loc_3F686
                move.w  $50(a5),d0
                sub.w   $10(a5),d0
                bne.s   loc_3F670
                clr.w   $50(a5)
                bra.s   loc_3F686
; ---------------------------------------------------------------------------
loc_3F670:                                              ; CODE XREF: Boss_GustheadTentacleRetract+3C   j
                tst.w   d0
                bmi.s   loc_3F67E
                addi.l  #$8000,$10(a5)
                bra.s   loc_3F686
; ---------------------------------------------------------------------------
loc_3F67E:                                              ; CODE XREF: Boss_GustheadTentacleRetract+46   j
                subi.l  #$8000,$10(a5)
loc_3F686:                                              ; CODE XREF: Boss_GustheadTentacleRetract+32   j
                                        ; Boss_GustheadTentacleRetract+42   j
                tst.w   $52(a5)
                beq.s   Boss_GustheadUpdateBounce
                move.w  $52(a5),d0
                sub.w   $14(a5),d0
                bne.s   loc_3F69C
                clr.w   $52(a5)
                bra.s   Boss_GustheadUpdateBounce
; ---------------------------------------------------------------------------
loc_3F69C:                                              ; CODE XREF: Boss_GustheadTentacleRetract+68   j
                tst.w   d0
                bmi.s   loc_3F6A8
                addi.w  #1,$14(a5)
                bra.s   Boss_GustheadUpdateBounce
; ---------------------------------------------------------------------------
loc_3F6A8:                                              ; CODE XREF: Boss_GustheadTentacleRetract+72   j
                subi.w  #1,$14(a5)
; End of function Boss_GustheadTentacleRetract
; Updates boss vertical bounce
Boss_GustheadUpdateBounce:                              ; CODE XREF: Boss_GustheadIntroReveal+50   p  ; was: sub_3F6AE
                                        ; Boss_GustheadBattleStart+28   p
                tst.l   $4C(a5)
                beq.s   locret_3F6D0
                move.l  $4C(a5),d0
                add.l   d0,$1C(a5)
                move.l  $1C(a5),d0
                bpl.s   loc_3F6C4
                neg.l   d0
loc_3F6C4:                                              ; CODE XREF: Boss_GustheadUpdateBounce+12   j
                cmpi.l  #$10000,d0
                bne.s   locret_3F6D0
                neg.l   $4C(a5)
locret_3F6D0:                                           ; CODE XREF: Boss_GustheadUpdateBounce+4   j
                                        ; Boss_GustheadUpdateBounce+1C   j
                rts
; End of function Boss_GustheadUpdateBounce
; Main handler for boss core
Boss_GustheadCoreMain:                                  ; CODE XREF: Boss_GustheadTentacleDefeat+10   p  ; was: sub_3F6D2
                                        ; Boss_GustheadDefeatPhase1+10   p
                move.l  (dword_FF941C).w,d0
                add.l   d0,(dword_FF9410).w
                move.l  (dword_FF9410).w,d0
                bpl.s   loc_3F6E2
                neg.l   d0
loc_3F6E2:                                              ; CODE XREF: Boss_GustheadCoreMain+C   j
                cmpi.l  #$20000,d0
                bne.s   locret_3F6EE
                neg.l   (dword_FF941C).w
locret_3F6EE:                                           ; CODE XREF: Boss_GustheadCoreMain+16   j
                rts
; End of function Boss_GustheadCoreMain
; Defeat phase 1 with tentacles
Boss_GustheadDefeatPhase1:                              ; DATA XREF: ROM:0003F264   o  ; was: sub_3F6F0
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadCoreMain
                bsr.w   Boss_GustheadTentacleRetract
                bsr.w   Boss_GustheadSpawnDebris
                tst.w   (dword_FF9404).w
                bne.s   locret_3F716
                addq.w  #2,4(a5)
locret_3F716:                                           ; CODE XREF: Boss_GustheadDefeatPhase1+20   j
                rts
; End of function Boss_GustheadDefeatPhase1
; Defeat phase 2 delay loop
Boss_GustheadDefeatPhase2:                              ; DATA XREF: ROM:0003F266   o  ; was: sub_3F718
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadCoreMain
                bsr.w   Boss_GustheadTentacleRetract
                tst.w   (dword_FF9404).w
                beq.s   locret_3F740
                subq.w  #1,$48(a5)
                beq.s   loc_3F742
                subq.w  #2,4(a5)
locret_3F740:                                           ; CODE XREF: Boss_GustheadDefeatPhase2+1C   j
                rts
; ---------------------------------------------------------------------------
loc_3F742:                                              ; CODE XREF: Boss_GustheadDefeatPhase2+22   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadDefeatPhase2
; Handles Gusthead boss defeat phase 3 with tentacle updates
Boss_GustheadDefeatPhase3:                              ; DATA XREF: ROM:0003F268   o  ; was: sub_3F748
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadCoreMain
                bsr.w   Boss_GustheadTentacleRetract
                move.l  (dword_FF9418).w,d0
                sub.l   d0,(dword_FF940C).w
                bne.s   locret_3F77C
                addq.w  #2,4(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #1,d0
                beq.s   locret_3F77C
                neg.l   (dword_FF9418).w
locret_3F77C:                                           ; CODE XREF: Boss_GustheadDefeatPhase3+20   j
                                        ; Boss_GustheadDefeatPhase3+2E   j
                rts
; End of function Boss_GustheadDefeatPhase3
; Handles Gusthead boss defeat phase 4 final state
Boss_GustheadDefeatPhase4:                              ; DATA XREF: ROM:0003F26A   o  ; was: sub_3F77E
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadTentacleRetract
                move.w  #$10,4(a5)
                rts
; End of function Boss_GustheadDefeatPhase4
; Initializes bouncing movement parameters for Gusthead boss
Boss_GustheadInitBounceMovement:                        ; CODE XREF: Boss_GustheadTentacleUpdate+3C   j  ; was: sub_3F79A
                                        ; DATA XREF: ROM:0003F26C   o
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                clr.l   (dword_FF8240).w
                andi.l  #$1F80000,(dword_FF9400).w
                andi.l  #$1F80000,(dword_FF9404).w
                andi.l  #$1F80000,(dword_FF9408).w
                move.l  #$80000,(dword_FF940C).w
                move.l  #$80000,(dword_FF9410).w
                move.l  #$80000,(dword_FF9414).w
                addq.w  #2,4(a5)
; Update tentacles and scroll during bounce initialization
Boss_GustheadInitBounceMovement_UpdateLoop:             ; DATA XREF: ROM:0003F26E   o  ; was: loc_3F7E2
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                cmpi.w  #$40,(dword_FF9400).w           ; '@'
                bne.s   loc_3F802
                clr.l   (dword_FF940C).w
loc_3F802:                                              ; CODE XREF: Boss_GustheadInitBounceMovement+62   j
                cmpi.w  #0,(dword_FF9404).w
                bne.s   loc_3F80E
                clr.l   (dword_FF9410).w
loc_3F80E:                                              ; CODE XREF: Boss_GustheadInitBounceMovement+6E   j
                cmpi.w  #$180,(dword_FF9408).w
                bne.s   locret_3F852
                clr.l   (dword_FF9414).w
                tst.l   (dword_FF9410).w
                bne.s   locret_3F852
                tst.l   (dword_FF940C).w
                bne.s   locret_3F852
                addq.w  #2,4(a5)
                clr.l   $1C(a5)
                clr.l   $4C(a5)
                move.l  #0,(dword_FF940C).w
                move.l  #$100000,(dword_FF9410).w
                move.l  #$40000,(dword_FF9414).w
                clr.w   $56(a5)
                bsr.w   Boss_GustheadUpdateTargetAngle
locret_3F852:                                           ; CODE XREF: Boss_GustheadInitBounceMovement+7A   j
                                        ; Boss_GustheadInitBounceMovement+84   j
                rts
; End of function Boss_GustheadInitBounceMovement
; Main logic for Gusthead boss bouncing attack pattern
Boss_GustheadBounceAttackLogic:                         ; DATA XREF: ROM:0003F270   o  ; was: sub_3F854
                ori.b   #3,$4B(a5)
                bsr.w   Boss_GustheadCalculateVelocity
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                cmpi.w  #$100,(dword_FF9408).w
                bne.s   loc_3F886
                cmpi.w  #$120,$14(a5)
                blt.s   loc_3F886
                bsr.w   Boss_GustheadSpawnDebris4Way
                bsr.w   Boss_GustheadFireRadialProjectiles
loc_3F886:                                              ; CODE XREF: Boss_GustheadBounceAttackLogic+20   j
                                        ; Boss_GustheadBounceAttackLogic+28   j
                move.w  $54(a5),d0
                cmp.w   (dword_FF9408).w,d0
                bne.s   locret_3F896
                neg.l   (dword_FF9414).w
                bsr.s   Boss_GustheadUpdateTargetAngle
locret_3F896:                                           ; CODE XREF: Boss_GustheadBounceAttackLogic+3A   j
                rts
; End of function Boss_GustheadBounceAttackLogic
; Updates target angle sequence for Gusthead boss movement
Boss_GustheadUpdateTargetAngle:                         ; CODE XREF: Boss_GustheadInitBounceMovement+B4   p  ; was: sub_3F898
                                        ; Boss_GustheadBounceAttackLogic+40   p
                move.w  $56(a5),d0
                move.w  word_3F8B4(pc,d0.w),$54(a5)
                addq.w  #2,$56(a5)
                cmpi.w  #6,$56(a5)
                bls.s   locret_3F8B2
                addq.w  #2,4(a5)
locret_3F8B2:                                           ; CODE XREF: Boss_GustheadUpdateTargetAngle+14   j
                rts
; End of function Boss_GustheadUpdateTargetAngle
; ---------------------------------------------------------------------------
word_3F8B4:     dc.w    $180, $80, $80, $180
                                        ; DATA XREF: Boss_GustheadUpdateTargetAngle+4   r

; Fires radial projectile pattern from Gusthead boss
Boss_GustheadFireRadialProjectiles:                     ; CODE XREF: Boss_GustheadBounceAttackLogic+2E   p  ; was: sub_3F8BC
                move.w  #3,d7
                move.w  #$150,d6
loc_3F8C4:                                              ; CODE XREF: Boss_GustheadFireRadialProjectiles+66   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_3F930
                move.w  #$10,(a0)
                jsr     (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addi.w  #$10,$14(a0)
                move.l  #off_1A0E96,8(a0)
                move.w  #$4000,$E(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                lea     (Math_SineTable).l,a1
                move.w  (a1,d6.w),d0
                move.w  -$80(a1,d6.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #4,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                addi.w  #$20,d6                         ; ' '
                dbf     d7,loc_3F8C4
                move.b  #$4C,d0                         ; 'L'
                jsr     (Sound_PlaySFX).l
locret_3F930:                                           ; CODE XREF: Boss_GustheadFireRadialProjectiles+E   j
                rts
; End of function Boss_GustheadFireRadialProjectiles
; Retrieves first tentacle angle value for Gusthead boss
Boss_GustheadGetTentacleAngle1:
                move.w  (dword_FF9400).w,d0             ; was: sub_3F932
                bra.s   loc_3F942
; End of function Boss_GustheadGetTentacleAngle1
; Retrieves second tentacle angle value for Gusthead boss
Boss_GustheadGetTentacleAngle2:
                move.w  (dword_FF9404).w,d0             ; was: sub_3F938
                bra.s   loc_3F942
; End of function Boss_GustheadGetTentacleAngle2
; Calculates velocity components from angle for Gusthead boss
Boss_GustheadCalculateVelocity:                         ; CODE XREF: Boss_GustheadBounceAttackLogic+6   p  ; was: sub_3F93E
                move.w  (dword_FF9408).w,d0
loc_3F942:                                              ; CODE XREF: Boss_GustheadGetTentacleAngle1+4   j
                                        ; Boss_GustheadGetTentacleAngle2+4   j
                andi.w  #$1FE,d0
                lea     (Math_SineTable).l,a1
                moveq   #0,d1
                btst    #0,$4B(a5)
                beq.s   loc_3F95E
                move.w  (a1,d0.w),d1
                ext.l   d1
                add.l   d1,d1
loc_3F95E:                                              ; CODE XREF: Boss_GustheadCalculateVelocity+16   j
                moveq   #0,d2
                btst    #1,$4B(a5)
                beq.s   loc_3F970
                move.w  -$80(a1,d0.w),d2
                ext.l   d2
                asl.l   #4,d2
loc_3F970:                                              ; CODE XREF: Boss_GustheadCalculateVelocity+28   j
                move.l  d1,$18(a5)
                move.l  d2,$1C(a5)
                rts
; End of function Boss_GustheadCalculateVelocity
; Initializes falling movement parameters for Gusthead boss
Boss_GustheadInitFallMovement:                          ; DATA XREF: ROM:0003F272   o  ; was: sub_3F97A
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                cmpi.w  #$F0,$14(a5)
                bcs.s   locret_3F9DC
                move.l  #$F00000,$14(a5)
                clr.l   $18(a5)
                move.l  #$10000,$1C(a5)
                move.l  #$FFFFE000,$4C(a5)
                andi.l  #$1F80000,(dword_FF9400).w
                andi.l  #$1F80000,(dword_FF9404).w
                andi.l  #$1F80000,(dword_FF9408).w
                move.w  #8,(dword_FF940C).w
                move.w  #8,(dword_FF9410).w
                move.w  #8,(dword_FF9414).w
                addq.w  #2,4(a5)
locret_3F9DC:                                           ; CODE XREF: Boss_GustheadInitFallMovement+16   j
                rts
; End of function Boss_GustheadInitFallMovement
; Handles Gusthead boss falling and bouncing behavior
Boss_GustheadFallBounceLogic:                           ; DATA XREF: ROM:0003F274   o  ; was: sub_3F9DE
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                cmpi.w  #$40,(dword_FF9400).w           ; '@'
                bne.s   loc_3F9FE
                clr.l   (dword_FF940C).w
loc_3F9FE:                                              ; CODE XREF: Boss_GustheadFallBounceLogic+1A   j
                cmpi.w  #$80,(dword_FF9404).w
                bne.s   loc_3FA0A
                clr.l   (dword_FF9410).w
loc_3FA0A:                                              ; CODE XREF: Boss_GustheadFallBounceLogic+26   j
                cmpi.w  #$180,(dword_FF9408).w
                bne.s   locret_3FA28
                clr.w   (dword_FF9414).w
                tst.l   (dword_FF940C).w
                bne.s   locret_3FA28
                tst.l   (dword_FF9410).w
                bne.s   locret_3FA28
                move.w  #$10,4(a5)
locret_3FA28:                                           ; CODE XREF: Boss_GustheadFallBounceLogic+32   j
                                        ; Boss_GustheadFallBounceLogic+3C   j
                rts
; End of function Boss_GustheadFallBounceLogic
; Initializes defeat bounce sequence for Gusthead boss
Boss_GustheadInitDefeatBounce:                          ; CODE XREF: Boss_GustheadTentacleUpdate+4C   j  ; was: sub_3FA2A
                                        ; DATA XREF: ROM:0003F276   o
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
; Execute rising bounce movement during defeat sequence
Boss_GustheadInitDefeatBounce_RiseLoop:                 ; DATA XREF: ROM:0003F278   o  ; was: loc_3FA42
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                addi.l  #$2000,(dword_FF940C).w
                cmpi.l  #$100000,(dword_FF940C).w
                bne.s   locret_3FA7A
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5)                    ; ' '
                bra.s   Boss_JetsripperFireProjectile
; ---------------------------------------------------------------------------
locret_3FA7A:                                           ; CODE XREF: Boss_GustheadInitDefeatBounce+42   j
                rts
; End of function Boss_GustheadInitDefeatBounce
; Fires projectile from Jetstripper boss based on position relative to player
