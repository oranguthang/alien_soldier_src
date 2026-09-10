Boss_MissirayMain:                                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_537B8
                tst.w   4(a5)
                beq.w   loc_538AE
                jsr     (Gfx_InitPaletteFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$4C(a5)
                btst    #2,(byte_FF80EC).w
                bne.s   loc_537FC
                btst    #1,(byte_FF80EC).w
                bne.w   loc_53826
                tst.w   (word_FF8200).w
                bne.s   loc_537FC
                move.b  #2,(byte_FF80EC).w
                move.w  #$1A,4(a5)
                bset    #0,(byte_FFA272).w
loc_537FC:                                              ; CODE XREF: Boss_MissirayMain+20   j
                                        ; Boss_MissirayMain+30   j
                move.w  #7,d7
                lea     $60(a5),a0
                move.w  $4E(a5),d0
                tst.w   (dword_FF9404).w
                bne.s   loc_53812
                addq.w  #8,d0
                bra.s   loc_53814
; ---------------------------------------------------------------------------
loc_53812:                                              ; CODE XREF: Boss_MissirayMain+54   j
                subq.w  #8,d0
loc_53814:                                              ; CODE XREF: Boss_MissirayMain+58   j
                                        ; Boss_MissirayMain+6A   j
                move.w  $4C(a0),$14(a0)
                add.w   d0,$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_53814
loc_53826:                                              ; CODE XREF: Boss_MissirayMain+28   j
                movea.l #$FFFFEC02,a1
                move.w  $14(a5),d1
                move.w  #3,d7
                lea     $60(a5),a0
loc_53838:                                              ; CODE XREF: Boss_MissirayMain+A2   j
                move.w  (dword_FF9408).w,d0
                sub.w   $14(a0),d0
                cmpi.w  #$FF40,d0
                blt.s   loc_53852
                cmpi.w  #$30,d0                         ; '0'
                bgt.s   loc_53852
                move.w  d0,(a1)
                move.w  d0,4(a1)
loc_53852:                                              ; CODE XREF: Boss_MissirayMain+8C   j
                                        ; Boss_MissirayMain+92   j
                lea     8(a1),a1
                lea     $60(a0),a0
                dbf     d7,loc_53838
                move.w  (dword_FF9404+2).w,d0
                sub.w   $14(a5),d0
                cmpi.w  #$FF20,d0
                blt.s   loc_53880
                cmpi.w  #$30,d0                         ; '0'
                bgt.s   loc_53880
                move.w  d0,(a1)
                move.w  d0,4(a1)
                move.w  d0,8(a1)
                move.w  d0,$C(a1)
loc_53880:                                              ; CODE XREF: Boss_MissirayMain+B2   j
                                        ; Boss_MissirayMain+B8   j
                lea     $10(a1),a1
                move.w  #3,d7
loc_53888:                                              ; CODE XREF: Boss_MissirayMain+F2   j
                move.w  (dword_FF9408).w,d0
                sub.w   $14(a0),d0
                cmpi.w  #$FF40,d0
                blt.s   loc_538A2
                cmpi.w  #$30,d0                         ; '0'
                bgt.s   loc_538A2
                move.w  d0,(a1)
                move.w  d0,4(a1)
loc_538A2:                                              ; CODE XREF: Boss_MissirayMain+DC   j
                                        ; Boss_MissirayMain+E2   j
                lea     8(a1),a1
                lea     $60(a0),a0
                dbf     d7,loc_53888
loc_538AE:                                              ; CODE XREF: Boss_MissirayMain+4   j
                move.w  4(a5),d0
                lea     off_538BA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayMain
; ---------------------------------------------------------------------------
off_538BA:      dc.w    Boss_MissirayDispatcher-*       ; DATA XREF: Boss_MissirayMain+FA   o
                dc.w    Boss_MissirayIntroInit-*
                dc.w    Boss_MissirayIntroMove-*
                dc.w    Boss_MissirayIntroStop-*
                dc.w    Boss_MissirayAttackState1-*
                dc.w    Boss_MissirayAttackState2-*
                dc.w    Boss_MissiraySegmentsInit-*
                dc.w    Boss_MissiraySegmentsCheck-*
                dc.w    Boss_MissirayStartBossMessage-*
                dc.w    Boss_MissirayWaitForBossMessage-*
                dc.w    Boss_MissirayResetCounters-*
                dc.w    Boss_MissirayMainAttackLoop-*
                dc.w    Boss_MissirayLoopAttacks-*
                dc.w    Boss_MissirayDefeatInit-*
                dc.w    Boss_MissirayDefeatExplosions-*
                dc.w    Boss_MissirayGraphicsUpdate1-*
                dc.w    Boss_MissirayGraphicsUpdate2-*
                dc.w    Boss_MissirayGraphicsUpdate4-*
                dc.w    Boss_MissirayGraphicsUpdate5-*
                dc.w    Boss_MissirayGraphicsUpdate6-*
                dc.w    Boss_MissirayGraphicsUpdate7-*
                dc.w    Boss_MissirayCleanup-*

; Boss state dispatcher
Boss_MissirayDispatcher:                                ; DATA XREF: ROM:off_538BA   o  ; was: sub_538E6
                tst.b   (word_FFF720).w
                bmi.w   locret_53A18
                addq.w  #2,4(a5)
                move.b  #4,(byte_FFA420).w
                move.w  #$3D0,d0
                move.w  #$3E0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.b  #2,(byte_FFA95B).w
                clr.w   (dword_FF9404).w
                move.w  #$A0,(dword_FF9404+2).w
                move.w  #$B8,(dword_FF9408).w
                move.w  #$80,(dword_FF940C).w
                move.w  #$13,d7
                lea     (word_FFEC02).w,a0
                move.w  #$FF40,d0
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
                move.w  #$120,$10(a5)
                move.w  #$170,$14(a5)
                move.w  $14(a5),$4E(a5)
                move.w  #$C80,2(a5)
                move.b  #$D0,$21(a5)
                move.b  #$88,$23(a5)
                move.w  #$C8,$26(a5)
                move.l  #$F40CE41C,$2C(a5)
                move.l  #$F010E41C,$28(a5)
                move.w  #$14,$24(a5)
                move.w  #7,d7
                moveq   #0,d6
                lea     $60(a5),a0
                lea     (word_FFEC02).w,a1
loc_539CA:                                              ; CODE XREF: Boss_MissirayDispatcher+12E   j
                move.w  #$3D4,(a0)
                move.w  #$C80,2(a0)
                move.b  #$80,$21(a0)
                move.b  #$10,$23(a0)
                move.l  #$FE02F40C,$2C(a0)
                move.l  #$E818E818,$28(a0)
                move.w  #$64,$26(a0)                    ; 'd'
                move.w  $14(a5),$14(a0)
                move.w  $10(a5),d0
                add.w   word_53A1A(pc,d6.w),d0
                move.w  d0,$10(a0)
                move.w  word_53A2A(pc,d6.w),$4C(a0)
                addq.w  #2,d6
                lea     $60(a0),a0
                dbf     d7,loc_539CA
locret_53A18:                                           ; CODE XREF: Boss_MissirayDispatcher+4   j
                rts
; End of function Boss_MissirayDispatcher
; ---------------------------------------------------------------------------
word_53A1A:     dc.w    $FF70, $FF90, $FFB0, $FFD0, $30, $50, $70, $90
                                        ; DATA XREF: Boss_MissirayDispatcher+11A   r
word_53A2A:     dc.w    $40, $30, $20, $10, $10, $20, $30, $40
                                        ; DATA XREF: Boss_MissirayDispatcher+122   r

; Loads first tile set for Missiray boss via DMA transfer
Gfx_MissirayLoadTilesSet1:                              ; CODE XREF: Boss_MissirayAttackPattern4Wait1+E   j  ; was: sub_53A3A
                lea     word_53A46(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Gfx_MissirayLoadTilesSet1
; ---------------------------------------------------------------------------
word_53A46:     dc.w    $6020, $2000, $102, $6162, $6566, $696A
                                        ; DATA XREF: Gfx_MissirayLoadTilesSet1   o

; Loads second tile set for Missiray boss via DMA transfer
Gfx_MissirayLoadTilesSet2:                              ; CODE XREF: Boss_MissirayAttackPattern5Wait1+E   j  ; was: sub_53A52
                lea     word_53A5E(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Gfx_MissirayLoadTilesSet2
; ---------------------------------------------------------------------------
word_53A5E:     dc.w    $6020, $2000, $102, $6D6E, $7172, $7576
                                        ; DATA XREF: Gfx_MissirayLoadTilesSet2   o

; Load boss tiles 1
Boss_MissirayLoadTiles1:                                ; CODE XREF: Boss_MissirayGraphicsUpdate4+A   p  ; was: sub_53A6A
                lea     word_53A76(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_MissirayLoadTiles1
; ---------------------------------------------------------------------------
word_53A76:     dc.w    $6020, $2000, $102, 0, 0, 0
                                        ; DATA XREF: Boss_MissirayLoadTiles1   o

; Intro animation init
Boss_MissirayIntroInit:                                 ; DATA XREF: ROM:000538BC   o  ; was: sub_53A82
                tst.b   (word_FFF720).w
                bmi.s   locret_53A8E
                addq.w  #2,4(a5)
                bsr.s   Boss_MissirayBattleStart
locret_53A8E:                                           ; CODE XREF: Boss_MissirayIntroInit+4   j
                rts
; End of function Boss_MissirayIntroInit
; Battle start initialization
Boss_MissirayBattleStart:                               ; CODE XREF: Boss_MissirayIntroInit+A   p  ; was: sub_53A90
                                        ; Boss_MissirayAttackPattern4Wait2+E   j
                lea     word_53A9C(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_MissirayBattleStart
; ---------------------------------------------------------------------------
word_53A9C:     dc.w    $6200, $2000, $301, $6060, $6060, $6464, $6464
                                        ; DATA XREF: Boss_MissirayBattleStart   o

; Loads first compressed tile set for Missiray boss battle start
Gfx_MissirayLoadCompressedSet1:                         ; CODE XREF: Boss_MissirayAttackPattern5Wait2+E   j  ; was: sub_53AAA
                lea     word_53AB6(pc),a0
                nop
; End of function Gfx_MissirayLoadCompressedSet1
; Attributes: thunk
; Thunk function that jumps to compressed tile loader
Gfx_LoadCompressedTilesThunk:
                jmp     Gfx_LoadCompressedTiles         ; was: sub_53AB0
; End of function Gfx_LoadCompressedTilesThunk
; ---------------------------------------------------------------------------
word_53AB6:     dc.w    $6200, $2000, $301, $6868, $6868, $6C6C, $6C6C
                                        ; DATA XREF: Gfx_MissirayLoadCompressedSet1   o

; Load boss tiles 2
Boss_MissirayLoadTiles2:                                ; CODE XREF: Boss_MissirayGraphicsUpdate5+A   p  ; was: sub_53AC4
                lea     word_53AD0(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_MissirayLoadTiles2
; ---------------------------------------------------------------------------
word_53AD0:     dc.w    $6200, $2000, $301, 0, 0, 0, 0
                                        ; DATA XREF: Boss_MissirayLoadTiles2   o

; Intro movement
Boss_MissirayIntroMove:                                 ; DATA XREF: ROM:000538BE   o  ; was: sub_53ADE
                tst.b   (word_FFF720).w
                bmi.s   locret_53AEA
                addq.w  #2,4(a5)
                bsr.s   Boss_MissirayIdleState
locret_53AEA:                                           ; CODE XREF: Boss_MissirayIntroMove+4   j
                rts
; End of function Boss_MissirayIntroMove
; Idle state handler
Boss_MissirayIdleState:                                 ; CODE XREF: Boss_MissirayIntroMove+A   p  ; was: sub_53AEC
                                        ; Boss_MissirayAttackPattern4Wait3+E   p
                lea     word_53AF8(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_MissirayIdleState
; ---------------------------------------------------------------------------
word_53AF8:     dc.w    $6230, $2000, $301, $6363, $6363, $6767, $6767
                                        ; DATA XREF: Boss_MissirayIdleState   o

; Loads second compressed tile set for Missiray idle state
Gfx_MissirayLoadCompressedSet2:                         ; CODE XREF: Boss_MissirayAttackPattern5Wait3+E   p  ; was: sub_53B06
                lea     word_53B12(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_MissirayLoadCompressedSet2
; ---------------------------------------------------------------------------
word_53B12:     dc.w    $6230, $2000, $301, $6B6B, $6B6B, $6F6F, $6F6F
                                        ; DATA XREF: Gfx_MissirayLoadCompressedSet2   o

; Load boss tiles 3
Boss_MissirayLoadTiles3:                                ; CODE XREF: Boss_MissirayGraphicsUpdate6+A   p  ; was: sub_53B20
                lea     word_53B2C(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_MissirayLoadTiles3
; ---------------------------------------------------------------------------
word_53B2C:     dc.w    $6230, $2000, $301, 0, 0, 0, 0
                                        ; DATA XREF: Boss_MissirayLoadTiles3   o

; Intro stop position
Boss_MissirayIntroStop:                                 ; DATA XREF: ROM:000538C0   o  ; was: sub_53B3A
                tst.b   (word_FFF720).w
                bmi.s   locret_53B5A
                addq.w  #2,4(a5)
                lea     word_53B50(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; ---------------------------------------------------------------------------
word_53B50:     dc.w    $6020, $2000, $101, $6162, $6566
                                        ; DATA XREF: Boss_MissirayIntroStop+A   o
; ---------------------------------------------------------------------------
locret_53B5A:                                           ; CODE XREF: Boss_MissirayIntroStop+4   j
                rts
; End of function Boss_MissirayIntroStop
; Attack state 1 handler
Boss_MissirayAttackState1:                              ; DATA XREF: ROM:000538C2   o  ; was: sub_53B5C
                subq.w  #1,$14(a5)
                move.w  $14(a5),$4E(a5)
                cmpi.w  #$178,$14(a5)
                bgt.s   locret_53B86
                addq.w  #2,4(a5)
                lea     word_53B7E(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
word_53B7E:     dc.w    $6420, $2000, $100, $696A
                                        ; DATA XREF: Boss_MissirayAttackState1+16   o
; ---------------------------------------------------------------------------
locret_53B86:                                           ; CODE XREF: Boss_MissirayAttackState1+10   j
                rts
; End of function Boss_MissirayAttackState1
; Attack state 2 handler
Boss_MissirayAttackState2:                              ; DATA XREF: ROM:000538C4   o  ; was: sub_53B88
                subq.w  #1,$14(a5)
                move.w  $14(a5),$4E(a5)
                cmpi.w  #$150,$14(a5)
                bhi.s   locret_53BB0
                move.w  #$150,$14(a5)
                move.w  #4,$4A(a5)
                move.w  #1,$48(a5)
                addq.w  #2,4(a5)
locret_53BB0:                                           ; CODE XREF: Boss_MissirayAttackState2+10   j
                rts
; End of function Boss_MissirayAttackState2
; Initialize 8 segments
Boss_MissiraySegmentsInit:                              ; DATA XREF: ROM:000538C6   o  ; was: sub_53BB2
                move.w  #7,d7
                lea     $60(a5),a0
loc_53BBA:                                              ; CODE XREF: Boss_MissiraySegmentsInit+1A   j
                clr.w   $4E(a0)
                move.b  #1,$50(a0)
                addq.w  #2,4(a0)
                lea     $60(a0),a0
                dbf     d7,loc_53BBA
                addq.w  #2,4(a5)
                rts
; End of function Boss_MissiraySegmentsInit
; Separates Missiray boss segments with timed delays between each segment pair
Boss_MissiraySegmentsSeparate:
                subq.w  #1,$48(a5)                      ; was: sub_53BD6
                bne.s   locret_53C2E
                subq.w  #1,$4A(a5)
                bmi.s   loc_53C2A
                move.w  $4A(a5),d5
                lsl.w   #2,d5
                move.w  word_53C30(pc,d5.w),d0
                move.w  word_53C30+2(pc,d5.w),d1
                lea     Boss_MissiraySegmentObjectPointers(pc),a1
                movea.w (a1,d0.w),a2
                movea.w (a1,d1.w),a3
                move.w  $14(a5),d0
                move.w  $4E(a5),d1
                sub.w   d1,d0
                move.w  d0,$4E(a2)
                move.b  #1,$50(a2)
                addq.w  #2,4(a2)
                move.w  d0,$4E(a3)
                move.b  #1,$50(a3)
                addq.w  #2,4(a3)
                move.w  #8,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_53C2A:                                              ; CODE XREF: Boss_MissiraySegmentsSeparate+A   j
                addq.w  #2,4(a5)
locret_53C2E:                                           ; CODE XREF: Boss_MissiraySegmentsSeparate+4   j
                rts
; End of function Boss_MissiraySegmentsSeparate
; ---------------------------------------------------------------------------
word_53C30:     dc.w    0, $E, 2, $C, 4, $A, 6, 8
                                        ; DATA XREF: Boss_MissiraySegmentsSeparate+12   r
                                        ; Boss_MissiraySegmentsSeparate+16   r

; Check segments ready
Boss_MissiraySegmentsCheck:                             ; DATA XREF: ROM:000538C8   o  ; was: sub_53C40
                move.w  #7,d7
                lea     $60(a5),a0
loc_53C48:                                              ; CODE XREF: Boss_MissiraySegmentsCheck+12   j
                tst.b   $52(a0)
                bne.s   locret_53C78
                lea     $60(a0),a0
                dbf     d7,loc_53C48
                move.w  #7,d7
                lea     $60(a5),a0
loc_53C5E:                                              ; CODE XREF: Boss_MissiraySegmentsCheck+2A   j
                clr.w   $4C(a0)
                clr.w   $4E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_53C5E
                move.w  $14(a5),$4E(a5)
                addq.w  #2,4(a5)
locret_53C78:                                           ; CODE XREF: Boss_MissiraySegmentsCheck+C   j
                rts
; End of function Boss_MissiraySegmentsCheck
; Start the boss-message sequence
Boss_MissirayStartBossMessage:                          ; DATA XREF: ROM:000538CA   o  ; was: sub_53C7A
                move.w  #3,d0
                jsr     (UI_StartBossMessage).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_MissirayStartBossMessage
; Wait for the boss-message gate before advancing to attack setup
Boss_MissirayWaitForBossMessage:                        ; DATA XREF: ROM:000538CC   o  ; was: sub_53C8A
                tst.w   (word_FF80C2).w
                bne.s   Boss_MissirayWaitForBossMessageReturn
                clr.b   (byte_FF80EC).w
                addq.w  #2,4(a5)
Boss_MissirayWaitForBossMessageReturn:                  ; CODE XREF: Boss_MissirayWaitForBossMessage+4   j  ; was: locret_53C98
                rts
; End of function Boss_MissirayWaitForBossMessage
; Reset attack counters
Boss_MissirayResetCounters:                             ; DATA XREF: ROM:000538CE   o  ; was: sub_53C9A
                clr.w   (dword_FF9400).w
                addq.w  #2,4(a5)
                move.w  #0,(dword_FF9400+2).w
                rts
; End of function Boss_MissirayResetCounters
; Main attack loop handler
Boss_MissirayMainAttackLoop:                            ; DATA XREF: ROM:000538D0   o  ; was: sub_53CAA
                bsr.w   Boss_MissirayCheckPlayerProximity
                move.w  (dword_FF9400+2).w,d0
                lea     off_53CBA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayMainAttackLoop
; ---------------------------------------------------------------------------
off_53CBA:      dc.w    Boss_MissirayUpdatePalette-*    ; DATA XREF: Boss_MissirayMainAttackLoop+8   o
                dc.w    Boss_MissirayAttackPattern3-*
                dc.w    Boss_MissirayAttack1Dispatcher-*
                dc.w    Boss_MissirayAttack2Dispatcher-*
                dc.w    Boss_MissirayAttackPattern5Dispatcher-*
                dc.w    Boss_MissirayUpdatePalette-*
                dc.w    Boss_MissirayUpdatePalette-*
                dc.w    Boss_MissirayAttack2Dispatcher-*
                dc.w    Boss_MissirayAttackPattern4Dispatcher-*

; Loop through attacks
Boss_MissirayLoopAttacks:                               ; DATA XREF: ROM:000538D2   o  ; was: sub_53CCC
                subq.w  #2,4(a5)
                addq.w  #2,(dword_FF9400+2).w
                cmpi.w  #$12,(dword_FF9400+2).w
                bne.s   locret_53CE0
                clr.w   (dword_FF9400+2).w
locret_53CE0:                                           ; CODE XREF: Boss_MissirayLoopAttacks+E   j
                rts
; End of function Boss_MissirayLoopAttacks
; Defeat sequence init
Boss_MissirayDefeatInit:                                ; DATA XREF: ROM:000538D4   o  ; was: sub_53CE2
                clr.b   $21(a5)
                move.w  #7,d7
                moveq   #0,d6
                lea     $60(a5),a0
loc_53CF0:                                              ; CODE XREF: Boss_MissirayDefeatInit+28   j
                clr.b   $21(a0)
                clr.w   4(a0)
                move.b  #2,$50(a0)
                move.w  word_53D1A(pc,d6.w),$48(a0)
                addq.w  #2,d6
                lea     $60(a0),a0
                dbf     d7,loc_53CF0
                addq.w  #2,4(a5)
                move.w  #$50,$48(a5)                    ; 'P'
                rts
; End of function Boss_MissirayDefeatInit
; ---------------------------------------------------------------------------
word_53D1A:     dc.w    $40, $30, $20, $10, $10, $20, $30, $40
                                        ; DATA XREF: Boss_MissirayDefeatInit+1C   r

; Defeat explosion effects
Boss_MissirayDefeatExplosions:                          ; DATA XREF: ROM:000538D6   o  ; was: sub_53D2A
                jsr     (Boss_SpawnExplosionDebris).l
                subq.w  #1,$48(a5)
                bne.s   locret_53D4E
                addq.w  #2,4(a5)
                tst.w   (dword_FF9404).w
                bne.s   locret_53D4E
                tst.w   (dword_FF9408+2).w
                bne.s   locret_53D4E
                move.l  #$FFFE0000,$1C(a5)
locret_53D4E:                                           ; CODE XREF: Boss_MissirayDefeatExplosions+A   j
                                        ; Boss_MissirayDefeatExplosions+14   j
                rts
; End of function Boss_MissirayDefeatExplosions
; Graphics update handler 1
Boss_MissirayGraphicsUpdate1:                           ; DATA XREF: ROM:000538D8   o  ; was: sub_53D50
                jsr     (Boss_SpawnExplosionDebris).l
                addi.l  #$800,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_53D78
                cmpi.l  #$10000,$1C(a5)
                blt.s   locret_53D78
                clr.w   $48(a5)
                addq.w  #2,4(a5)
locret_53D78:                                           ; CODE XREF: Boss_MissirayGraphicsUpdate1+14   j
                                        ; Boss_MissirayGraphicsUpdate1+1E   j
                rts
; End of function Boss_MissirayGraphicsUpdate1
; Graphics update handler 2
Boss_MissirayGraphicsUpdate2:                           ; DATA XREF: ROM:000538DA   o  ; was: sub_53D7A
                jsr     (Boss_SpawnExplosionDebris).l
                bsr.s   Boss_MissirayGraphicsUpdate3
                btst    #0,(word_FFA000+1).w
                bne.s   locret_53DB6
                btst    #1,(word_FFA000+1).w
                bne.s   locret_53DB6
                addq.w  #1,$48(a5)
                cmpi.w  #$F,$48(a5)
                bne.s   locret_53DB6
                move.w  #$3D0,d0
                move.w  #$3E0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #4,$4A(a5)
                addq.w  #2,4(a5)
locret_53DB6:                                           ; CODE XREF: Boss_MissirayGraphicsUpdate2+E   j
                                        ; Boss_MissirayGraphicsUpdate2+16   j
                rts
; End of function Boss_MissirayGraphicsUpdate2
; Graphics update handler 3
Boss_MissirayGraphicsUpdate3:                           ; CODE XREF: Boss_MissirayGraphicsUpdate2+6   p  ; was: sub_53DB8
                                        ; sub_53DD4   p
                move.w  $48(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Boss_MissirayGraphicsUpdate3
; Graphics update handler 4
Boss_MissirayGraphicsUpdate4:                           ; DATA XREF: ROM:000538DC   o  ; was: sub_53DD4
                bsr.w   Boss_MissirayGraphicsUpdate3
                subq.w  #1,$4A(a5)
                bne.s   locret_53DE6
                bsr.w   Boss_MissirayLoadTiles1
                addq.w  #2,4(a5)
locret_53DE6:                                           ; CODE XREF: Boss_MissirayGraphicsUpdate4+8   j
                rts
; End of function Boss_MissirayGraphicsUpdate4
; Graphics update handler 5
Boss_MissirayGraphicsUpdate5:                           ; DATA XREF: ROM:000538DE   o  ; was: sub_53DE8
                bsr.w   Boss_MissirayGraphicsUpdate3
                tst.b   (word_FFF720).w
                bmi.s   locret_53DFA
                bsr.w   Boss_MissirayLoadTiles2
                addq.w  #2,4(a5)
locret_53DFA:                                           ; CODE XREF: Boss_MissirayGraphicsUpdate5+8   j
                rts
; End of function Boss_MissirayGraphicsUpdate5
; Graphics update handler 6
Boss_MissirayGraphicsUpdate6:                           ; DATA XREF: ROM:000538E0   o  ; was: sub_53DFC
                bsr.w   Boss_MissirayGraphicsUpdate3
                tst.b   (word_FFF720).w
                bmi.s   locret_53E0E
                bsr.w   Boss_MissirayLoadTiles3
                addq.w  #2,4(a5)
locret_53E0E:                                           ; CODE XREF: Boss_MissirayGraphicsUpdate6+8   j
                rts
; End of function Boss_MissirayGraphicsUpdate6
; Graphics update handler 7
Boss_MissirayGraphicsUpdate7:                           ; DATA XREF: ROM:000538E2   o  ; was: sub_53E10
                bsr.s   Boss_MissirayGraphicsUpdate3
                btst    #0,(word_FFA000+1).w
                bne.s   locret_53E30
                btst    #1,(word_FFA000+1).w
                bne.s   locret_53E30
                subq.w  #1,$48(a5)
                tst.w   $48(a5)
                bne.s   locret_53E30
                addq.w  #2,4(a5)
locret_53E30:                                           ; CODE XREF: Boss_MissirayGraphicsUpdate7+8   j
                                        ; Boss_MissirayGraphicsUpdate7+10   j
                rts
; End of function Boss_MissirayGraphicsUpdate7
; Cleanup after defeat
Boss_MissirayCleanup:                                   ; DATA XREF: ROM:000538E4   o  ; was: sub_53E32
                move.w  #$1000,2(a5)
                clr.w   (a5)
                rts
; End of function Boss_MissirayCleanup
; Reset attack state
Boss_MissirayResetAttackState:                          ; CODE XREF: Boss_MissirayAttackDelay:loc_53F58   j  ; was: sub_53E3C
                                        ; sub_53F70:loc_53F86   j
                clr.w   (dword_FF9400).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_MissirayResetAttackState
; Update boss palette
Boss_MissirayUpdatePalette:                             ; DATA XREF: ROM:off_53CBA   o  ; was: sub_53E46
                                        ; ROM:00053CC4   o
                bsr.s   Boss_MissirayAttackDispatcher
                tst.w   (dword_FF9404).w
                beq.s   locret_53E5E
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                move.w  word_53E60(pc,d0.w),(word_FFE37E).w
locret_53E5E:                                           ; CODE XREF: Boss_MissirayUpdatePalette+6   j
                rts
; End of function Boss_MissirayUpdatePalette
; ---------------------------------------------------------------------------
word_53E60:     dc.w    $EEE, $E0E, $EEE, $E0
                                        ; DATA XREF: Boss_MissirayUpdatePalette+12   r

; Attack pattern dispatcher
