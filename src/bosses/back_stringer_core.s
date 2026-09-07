Boss_BackStringerMain:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_446AE
                tst.w   4(a5)
                beq.w   loc_44702
                tst.w   8(a5)
                beq.s   loc_44702
                btst    #2,(byte_FF80EC).w
                bne.s   loc_446D4
                btst    #1,(byte_FF80EC).w
                bne.s   loc_446D4
                tst.w   (word_FF8200).w
                beq.w   Boss_BackStringerDefeatInit
loc_446D4:                                              ; CODE XREF: Boss_BackStringerMain+14   j
                                        ; Boss_BackStringerMain+1C   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
                btst    #7,2(a5)
                beq.s   loc_44702
                move.w  #$F4F4,$A(a5)
                cmpi.w  #$100,$56(a5)
                bne.s   loc_44702
                move.w  #$F6F4,$A(a5)
loc_44702:                                              ; CODE XREF: Boss_BackStringerMain+4   j
                                        ; Boss_BackStringerMain+C   j
                move.w  4(a5),d0
                movea.w off_44712(pc,d0.w),a0
                adda.l  #Boss_BackStringerInit,a0
                jmp     (a0)
; End of function Boss_BackStringerMain
; ---------------------------------------------------------------------------
off_44712:      dc.w    Boss_BackStringerInit-Boss_BackStringerInit
                                        ; DATA XREF: Boss_BackStringerMain+58   r
                dc.w    Boss_BackStringerSpawn-Boss_BackStringerInit
                dc.w    Boss_Epsilon1PlayerControl-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State0-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State1-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State2-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State3-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State4-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State5-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State6-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State7-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State9-Boss_BackStringerInit
                dc.w    Boss_BackStringer_SpawnDrops-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State13-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State15-Boss_BackStringerInit
                dc.w    Boss_BackStringerDiveAttack-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State19-Boss_BackStringerInit
                dc.w    Boss_BackStringerDiveDelay-Boss_BackStringerInit
                dc.w    Boss_BackStringerCheckRotationComplete-Boss_BackStringerInit
                dc.w    Boss_BackStringerCheckRotationStart-Boss_BackStringerInit
                dc.w    Boss_BackStringerDefeatFadeOut-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State23-Boss_BackStringerInit
                dc.w    Boss_BackStringer_State24-Boss_BackStringerInit

; Initial state waiting for start
Boss_BackStringerInit:                                  ; DATA XREF: Boss_BackStringerMain+5C   o  ; was: sub_44740
                                        ; ROM:off_44712   o
                clr.w   8(a5)
                tst.w   (word_FFF720).w
                bmi.s   locret_44758
                addq.w  #2,4(a5)
                move.b  #$8C,d0
                jsr     (Input_CheckButtonMode).l
locret_44758:                                           ; CODE XREF: Boss_BackStringerInit+8   j
                rts
; End of function Boss_BackStringerInit
; Boss initialization with metasprite setup
Boss_BackStringerSpawn:                                 ; DATA XREF: ROM:00044714   o  ; was: sub_4475A
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$8300,(dword_FF8040).w
                moveq   #$14,d7
                movea.l #off_3516C,a0
                movea.l #word_351C0,a1
                movea.l #word_351D6,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$314,(a5)
                move.w  #$8D00,2(a5)
                clr.w   6(a5)
                move.w  #$C000,$62(a5)
                move.w  #$C000,$C2(a5)
                move.b  #1,d0
                move.b  #3,d1
                move.b  #2,d2
                movea.w a5,a0
                moveq   #5,d7
loc_447AA:                                              ; CODE XREF: Boss_BackStringerSpawn+60   j
                or.b    d0,$140(a0)
                or.b    d1,$1A0(a0)
                or.b    d2,$200(a0)
                lea     $120(a0),a0
                dbf     d7,loc_447AA
                bsr.w   Boss_BackStringerInitProjectileSlots
                movea.l #Boss_BackStringerObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                move.w  #2,$1DE(a5)
                bra.w   Boss_BackStringerAttackStateMachine
; End of function Boss_BackStringerSpawn
; Initializes Epsilon1 boss position state
Boss_Epsilon1Initialize:                                ; CODE XREF: Boss_Epsilon1PlayerControl+8   j  ; was: sub_447D8
                move.w  #4,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$110,$14(a5)
                clr.b   (byte_FF80EC).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                bra.w   Boss_BackStringerResetBodySegments
; End of function Boss_Epsilon1Initialize
; Handles player input for Epsilon1 boss movement
Boss_Epsilon1PlayerControl:                             ; DATA XREF: ROM:00044716   o  ; was: sub_447FA
                btst    #6,(word_FFF708).w
                beq.s   loc_44806
                bra.w   Boss_Epsilon1Initialize
; ---------------------------------------------------------------------------
loc_44806:                                              ; CODE XREF: Boss_Epsilon1PlayerControl+6   j
                btst    #5,(word_FFF708).w
                beq.s   loc_44812
                bsr.w   Boss_BackStringerRetractSegments
loc_44812:                                              ; CODE XREF: Boss_Epsilon1PlayerControl+12   j
                btst    #0,(word_FFF706).w
                beq.s   loc_44822
                subi.l  #$10000,$2FC(a5)
loc_44822:                                              ; CODE XREF: Boss_Epsilon1PlayerControl+1E   j
                btst    #1,(word_FFF706).w
                beq.s   loc_44832
                addi.l  #$10000,$2FC(a5)
loc_44832:                                              ; CODE XREF: Boss_Epsilon1PlayerControl+2E   j
                bsr.w   Boss_BackStringerUpdateSegmentPositions
                lea     word_45432(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                move.w  #0,$56(a5)
                bra.w   Boss_BackStringerUpdateRender
; End of function Boss_Epsilon1PlayerControl
; Complex multi-phase attack state machine
Boss_BackStringerAttackStateMachine:                    ; CODE XREF: Boss_BackStringerSpawn+7A   j  ; was: sub_4484A
                move.w  #6,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$120,$10(a5)
                move.w  #$1C0,$14(a5)
; Back Stringer boss state 0 initialization
Boss_BackStringer_State0:                               ; DATA XREF: ROM:00044718   o  ; was: loc_44864
                cmpi.w  #$EA,$14(a5)
                bmi.s   loc_4487E
loc_4486C:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+EC   j
                lea     word_4544E(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                bsr.w   Boss_BackStringerApplyCircularMotion
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_4487E:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+20   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$140,$11C(a5)
                move.b  #$E5,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$1E,(word_FFC624).w
; Back Stringer boss attack pattern 1
Boss_BackStringer_State1:                               ; DATA XREF: ROM:0004471A   o  ; was: loc_448A2
                move.w  #2,(word_FFA010).w
                subq.w  #1,$11C(a5)
                bmi.s   loc_448CC
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                addi.w  #8,d0
                move.w  d0,$B4(a5)
                lea     word_45484(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_448CC:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+62   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$18,$B4(a5)
                move.w  #$30,$11C(a5)                   ; '0'
; Back Stringer boss missile launch state
Boss_BackStringer_State2:                               ; DATA XREF: ROM:0004471C   o  ; was: loc_448E6
                subq.w  #1,$11C(a5)
                bmi.s   loc_448FA
                lea     word_4549E(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_448FA:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+A0   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Back Stringer boss movement phase
Boss_BackStringer_State3:                               ; DATA XREF: ROM:0004471E   o  ; was: loc_44908
                addq.w  #8,$56(a5)
                andi.w  #$1F8,$56(a5)
                cmpi.w  #$100,$56(a5)
                beq.s   loc_4492C
loc_4491A:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+FE   j
                lea     word_45460(pc),a1
                nop
loc_44920:                                              ; CODE XREF: Boss_BackStringerTrackingAttack+12E   j
                bsr.w   Boss_BackStringerAnimatePose
                bsr.w   Boss_BackStringerApplyCircularMotion
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_4492C:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+CE   j
                addq.w  #2,4(a5)
; Back Stringer boss combo attack
Boss_BackStringer_State4:                               ; DATA XREF: ROM:00044720   o  ; was: loc_44930
                cmpi.w  #$140,$14(a5)
                bmi.w   loc_4486C
                addq.w  #2,4(a5)
; Back Stringer boss rapid fire
Boss_BackStringer_State5:                               ; DATA XREF: ROM:00044722   o  ; was: loc_4493E
                addq.w  #8,$56(a5)
                andi.w  #$1F8,$56(a5)
                bne.w   loc_4491A
                addq.w  #2,4(a5)
                move.w  #$40,$11C(a5)                   ; '@'
; Back Stringer boss tracking attack
Boss_BackStringer_State6:                               ; DATA XREF: ROM:00044724   o  ; was: loc_44956
                subq.w  #1,$11C(a5)
                bpl.w   loc_449FE
                addq.w  #2,4(a5)
                moveq   #1,d0
                jsr     (UI_CheckVictoryCondition).l
; Back Stringer boss special move
Boss_BackStringer_State7:                               ; DATA XREF: ROM:00044726   o  ; was: loc_4496A
                tst.w   (word_FF80C2).w
                bne.w   loc_449FE
                clr.b   (byte_FF80EC).w
                move.w  #7,$41C(a5)
                move.w  #$FFFF,$47C(a5)
                move.w  #4,$47E(a5)
loc_44988:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+324   j
                                        ; Boss_BackStringerDiveDelay+4   j
                subq.w  #1,$41C(a5)
                bpl.s   loc_449A8
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                addq.w  #2,d0
                move.w  d0,$41C(a5)
                tst.w   $56(a5)
                bne.w   Boss_BackStringerRotateLeft
                bra.w   Boss_BackStringerRotateRight
; ---------------------------------------------------------------------------
loc_449A8:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+142   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                addi.w  #$C,d0
                move.w  d0,$11C(a5)
                move.w  #$16,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Back Stringer boss advanced pattern
Boss_BackStringer_State9:                               ; DATA XREF: ROM:00044728   o  ; was: loc_449D0
                bsr.w   Projectile_BackStringerSpawnDrops
                subq.w  #1,$11C(a5)
                bpl.s   loc_449F0
                cmpi.w  #$140,(dword_FFC694).w
                bpl.w   Boss_BackStringerTrackingAttack
                cmpi.w  #$1600,(word_FF8200).w
                bmi.w   Boss_BackStringerTrackingAttack
                bra.s   loc_44A0C
; ---------------------------------------------------------------------------
loc_449F0:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+18E   j
                                        ; Boss_BackStringerDiveDelay+8   j
                lea     word_4549E(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_449FE:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+110   j
                                        ; Boss_BackStringerAttackStateMachine+124   j
                lea     word_4543C(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44A0C:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+1A4   j
                move.w  #$18,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $23E(a5)
                clr.w   $58(a5)
                clr.w   $29C(a5)
                move.w  #$FFFF,$C(a5)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #7,d0
                addq.w  #1,d0
                move.w  d0,$17C(a5)
                cmpi.w  #$90,$10(a5)
                bmi.s   loc_44A54
                cmpi.w  #$1B0,$10(a5)
                bpl.s   loc_44A54
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_44A64
loc_44A54:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+1F6   j
                                        ; Boss_BackStringerAttackStateMachine+1FE   j
                move.w  (word_FF8248).w,d1
                sub.w   $10(a5),d1
                beq.s   loc_44A64
                move.w  d1,$17E(a5)
                bra.s   loc_44A76
; ---------------------------------------------------------------------------
loc_44A64:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+208   j
                                        ; Boss_BackStringerAttackStateMachine+212   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$8000,d0
                move.w  d0,$17E(a5)
                move.w  #0,$17C(a5)
loc_44A76:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+218   j
                tst.w   $56(a5)
                beq.s   Boss_BackStringer_SpawnDrops
                neg.w   $17E(a5)
; Spawns projectile drops during attack pattern
Boss_BackStringer_SpawnDrops:                           ; CODE XREF: Boss_BackStringerAttackStateMachine+230   j  ; was: loc_44A80
                                        ; DATA XREF: ROM:0004472A   o
                bsr.w   Projectile_BackStringerSpawnDrops
                tst.w   $23E(a5)
                beq.w   loc_44B22
                move.w  #$C9E0,d0
                move.w  #$C8C0,d1
                move.w  $29C(a5),d7
                move.w  (word_FF8248).w,d2
                sub.w   $10(a5),d2
                tst.w   $56(a5)
                beq.s   loc_44AA8
                neg.w   d2
loc_44AA8:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+25A   j
                tst.w   $17E(a5)
                bmi.s   loc_44AB8
                tst.w   d2
                bpl.s   loc_44ABC
loc_44AB2:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+270   j
                neg.w   $17E(a5)
                bra.s   loc_44ABC
; ---------------------------------------------------------------------------
loc_44AB8:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+262   j
                tst.w   d2
                bpl.s   loc_44AB2
loc_44ABC:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+266   j
                                        ; Boss_BackStringerAttackStateMachine+26C   j
                cmpi.w  #1,d7
                bne.s   loc_44AD0
                tst.w   $17E(a5)
                bpl.s   loc_44ACA
                exg     d0,d1
loc_44ACA:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+27C   j
                move.w  d0,$48(a5)
                bra.s   loc_44AE2
; ---------------------------------------------------------------------------
loc_44AD0:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+276   j
                cmpi.w  #3,d7
                bne.s   loc_44AE2
                tst.w   $17E(a5)
                bpl.s   loc_44ADE
                exg     d0,d1
loc_44ADE:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+290   j
                move.w  d1,$48(a5)
loc_44AE2:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+284   j
                                        ; Boss_BackStringerAttackStateMachine+28A   j
                cmpi.w  #1,d7
                bne.s   loc_44B22
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_44AF4
                neg.w   d0
loc_44AF4:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+2A6   j
                tst.w   $56(a5)
                bne.s   loc_44B12
                subq.w  #1,$17C(a5)
                bmi.s   loc_44B30
                cmpi.w  #$30,d0                         ; '0'
                bpl.s   loc_44B22
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                beq.s   loc_44B22
                bra.s   loc_44B30
; ---------------------------------------------------------------------------
loc_44B12:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+2AE   j
                subq.w  #2,$17C(a5)
                bmi.w   loc_44BC4
                cmpi.w  #$20,d0                         ; ' '
                bmi.w   loc_44BC4
loc_44B22:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+23E   j
                                        ; Boss_BackStringerAttackStateMachine+29C   j
                lea     word_454C4(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44B30:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+2B4   j
                                        ; Boss_BackStringerAttackStateMachine+2C6   j
                move.w  #$1A,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CD40,$4A(a5)
                clr.w   $58(a5)
                clr.w   $29C(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$18,$4DC(a5)
; Back Stringer boss transformation
Boss_BackStringer_State13:                              ; DATA XREF: ROM:0004472C   o  ; was: loc_44B54
                bsr.w   Gfx_BackStringerUpdatePalette
                tst.w   $4DC(a5)
                bmi.s   loc_44B62
                subq.w  #1,$4DC(a5)
loc_44B62:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+312   j
                tst.w   $58(a5)
                bpl.s   loc_44B72
                move.w  #$13E,$14(a5)
                bra.w   loc_44988
; ---------------------------------------------------------------------------
loc_44B72:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+31C   j
                cmpi.w  #4,$29C(a5)
                bne.s   loc_44B9E
                cmpi.w  #$18,$B4(a5)
                bpl.s   loc_44B86
                addq.w  #1,$B4(a5)
loc_44B86:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+336   j
                cmpi.w  #$1F,$114(a5)
                bpl.s   loc_44B92
                addq.w  #1,$114(a5)
loc_44B92:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+342   j
                tst.w   $23E(a5)
                beq.s   loc_44B9E
                bsr.w   Boss_Epsilon1SpawnDualProjectiles
                bra.s   loc_44BB6
; ---------------------------------------------------------------------------
loc_44B9E:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+32E   j
                                        ; Boss_BackStringerAttackStateMachine+34C   j
                cmpi.w  #2,$29C(a5)
                bne.s   loc_44BB6
                btst    #0,(word_FFA000+1).w
                bne.s   loc_44BB6
                subq.w  #1,$B4(a5)
                subq.w  #1,$114(a5)
loc_44BB6:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+352   j
                                        ; Boss_BackStringerAttackStateMachine+35A   j
                lea     word_454D6(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44BC4:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+2CC   j
                                        ; Boss_BackStringerAttackStateMachine+2D4   j
                move.w  #$1C,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                clr.w   $29C(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$17C(a5)
; Back Stringer boss final phase
Boss_BackStringer_State15:                              ; DATA XREF: ROM:0004472E   o  ; was: loc_44BE6
                bsr.w   Projectile_BackStringerSpawnDrops
                subq.w  #1,$17C(a5)
                bmi.s   loc_44C1A
                move.w  #$18,$B4(a5)
                move.w  #$1F,$114(a5)
                btst    #1,$17D(a5)
                beq.s   loc_44C0C
                subq.w  #2,$B4(a5)
                subq.w  #4,$114(a5)
loc_44C0C:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+3B8   j
                lea     word_454A8(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44C1A:                                              ; CODE XREF: Boss_BackStringerAttackStateMachine+3A4   j
                addq.w  #2,4(a5)
                move.w  #$CD40,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$B7,d0
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_BackStringerResetBodySegments
; End of function Boss_BackStringerAttackStateMachine
; Executes BackStringer dive attack with vertical movement
Boss_BackStringerDiveAttack:                            ; DATA XREF: ROM:00044730   o  ; was: sub_44C3C
                bsr.w   Projectile_BackStringerSpawnDrops
                subi.l  #$16000,$2FC(a5)
                cmpi.w  #$FFE0,$2FC(a5)
                bpl.s   loc_44C5A
                tst.w   $29E(a5)
                bne.s   loc_44C6C
                bra.w   loc_44C96
; ---------------------------------------------------------------------------
loc_44C5A:                                              ; CODE XREF: Boss_BackStringerDiveAttack+12   j
                                        ; Boss_BackStringerDiveAttack+50   j
                bsr.w   Boss_BackStringerUpdateSegmentPositions
                lea     word_454B2(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44C6C:                                              ; CODE XREF: Boss_BackStringerDiveAttack+18   j
                addq.w  #2,4(a5)
                move.w  #$13E,$14(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Back Stringer boss ultimate attack
Boss_BackStringer_State19:                              ; DATA XREF: ROM:00044732   o  ; was: loc_44C84
                addi.l  #$10000,$2FC(a5)
                bmi.s   loc_44C5A
                cmpi.w  #$12,$2FC(a5)
                bmi.s   loc_44C5A
loc_44C96:                                              ; CODE XREF: Boss_BackStringerDiveAttack+1A   j
                move.w  #$22,4(a5)                      ; '"'
                move.w  #$13E,$14(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #2,$17C(a5)
                bsr.w   Boss_BackStringerRetractSegments
; End of function Boss_BackStringerDiveAttack
; Timer-based delay for BackStringer dive sequence
Boss_BackStringerDiveDelay:                             ; DATA XREF: ROM:00044734   o  ; was: sub_44CBA
                subq.w  #1,$17C(a5)
                bmi.w   loc_44988
                bra.w   loc_449F0
; End of function Boss_BackStringerDiveDelay
; Initiates BackStringer left rotation attack
Boss_BackStringerRotateLeft:                            ; CODE XREF: Boss_BackStringerAttackStateMachine+156   j  ; was: sub_44CC6
                move.w  #$26,4(a5)                      ; '&'
                bsr.s   Boss_BackStringerSetRotationDirection
                bra.s   Boss_BackStringerCheckRotationStart
; End of function Boss_BackStringerRotateLeft
; Initiates BackStringer right rotation attack
Boss_BackStringerRotateRight:                           ; CODE XREF: Boss_BackStringerAttackStateMachine+15A   j  ; was: sub_44CD0
                move.w  #$24,4(a5)                      ; '$'
                bsr.s   Boss_BackStringerSetRotationDirection
                bra.s   Boss_BackStringerCheckRotationComplete
; End of function Boss_BackStringerRotateRight
; Determines rotation direction based on position
Boss_BackStringerSetRotationDirection:                  ; CODE XREF: Boss_BackStringerRotateLeft+6   p  ; was: sub_44CDA
                                        ; Boss_BackStringerRotateRight+6   p
                moveq   #8,d0
                cmpi.w  #$120,$10(a5)
                bpl.s   loc_44CE6
                moveq   #$FFFFFFF8,d0
loc_44CE6:                                              ; CODE XREF: Boss_BackStringerSetRotationDirection+8   j
                move.w  d0,$11C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                rts
; End of function Boss_BackStringerSetRotationDirection
; Checks if rotation reached 256 degrees
Boss_BackStringerCheckRotationComplete:                 ; CODE XREF: Boss_BackStringerRotateRight+8   j  ; was: sub_44CFE
                                        ; DATA XREF: ROM:00044736   o
                cmpi.w  #$100,$56(a5)
                beq.w   loc_44988
                bra.s   loc_44D12
; End of function Boss_BackStringerCheckRotationComplete
; Checks if rotation returned to zero
Boss_BackStringerCheckRotationStart:                    ; CODE XREF: Boss_BackStringerRotateLeft+8   j  ; was: sub_44D0A
                                        ; DATA XREF: ROM:00044738   o
                tst.w   $56(a5)
                beq.w   loc_44988
loc_44D12:                                              ; CODE XREF: Boss_BackStringerCheckRotationComplete+A   j
                bsr.w   Projectile_BackStringerSpawnDrops
                move.w  $11C(a5),d1
                add.w   d1,$56(a5)
                andi.w  #$1F8,$56(a5)
                lea     word_45460(pc),a1
                nop
                tst.w   d1
                bpl.s   loc_44D34
                lea     word_45472(pc),a1
                nop
loc_44D34:                                              ; CODE XREF: Boss_BackStringerCheckRotationStart+22   j
                bsr.w   Boss_BackStringerAnimatePose
                bra.w   Boss_BackStringerUpdateRender
; End of function Boss_BackStringerCheckRotationStart
; Complex tracking attack aiming at player position
Boss_BackStringerTrackingAttack:                        ; CODE XREF: Boss_BackStringerAttackStateMachine+196   j  ; was: sub_44D3C
                                        ; Boss_BackStringerAttackStateMachine+1A0   j
                move.w  #$2A,4(a5)                      ; '*'
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                clr.w   $29C(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$180,$11C(a5)
                move.w  #$10,$11E(a5)
                move.w  #$40,$17C(a5)                   ; '@'
; Back Stringer boss closing pattern
Boss_BackStringer_State23:                              ; DATA XREF: ROM:0004473C   o  ; was: loc_44D6A
                subq.w  #1,$17C(a5)
                bmi.s   loc_44D8A
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                lea     word_4544E(pc),a1
                nop
                bsr.w   Boss_BackStringerAnimatePose
                bra.w   Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44D8A:                                              ; CODE XREF: Boss_BackStringerTrackingAttack+32   j
                addq.w  #2,4(a5)
                move.b  #$50,$81(a5)                    ; 'P'
                move.b  #$50,$E1(a5)                    ; 'P'
; Back Stringer boss final stand
Boss_BackStringer_State24:                              ; DATA XREF: ROM:0004473E   o  ; was: loc_44D9A
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.w  $11C(a5),d2
                sub.w   $56(a5),d2
                bmi.w   loc_44E52
                bne.w   loc_44E3E
                lea     word_4544E(pc),a1
                nop
                move.w  #$180,d1
                cmpi.w  #$1A0,$10(a5)
                bpl.s   loc_44DEC
                move.w  #$80,d1
                cmpi.w  #$A0,$10(a5)
                bmi.s   loc_44DEC
                move.w  #0,d1
                cmpi.w  #$140,$14(a5)
                bpl.s   loc_44DEC
                move.w  #$100,d1
                cmpi.w  #$B0,$14(a5)
                bpl.s   loc_44DF8
loc_44DEC:                                              ; CODE XREF: Boss_BackStringerTrackingAttack+8A   j
                                        ; Boss_BackStringerTrackingAttack+96   j
                move.w  #$FFFF,$11E(a5)
                move.w  d1,$11C(a5)
                bra.s   loc_44E64
; ---------------------------------------------------------------------------
loc_44DF8:                                              ; CODE XREF: Boss_BackStringerTrackingAttack+AE   j
                subq.w  #1,$11E(a5)
                bpl.w   loc_44E64
                btst    #0,(dword_FFFF08+1).w
                beq.s   loc_44E22
                jsr     (Math_CalculateAngleToPlayer).l
                addi.w  #$80,d2
                andi.w  #$1F8,d2
                move.w  d2,$11C(a5)
                move.w  #$80,$11E(a5)
                bra.s   loc_44E64
; ---------------------------------------------------------------------------
loc_44E22:                                              ; CODE XREF: Boss_BackStringerTrackingAttack+CA   j
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F8,d0
                move.w  d0,$11C(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                addq.w  #8,d0
                move.w  d0,$11E(a5)
                bra.s   loc_44E64
; ---------------------------------------------------------------------------
loc_44E3E:                                              ; CODE XREF: Boss_BackStringerTrackingAttack+76   j
                cmpi.w  #$100,d2
                bpl.w   loc_44E5A
loc_44E46:                                              ; CODE XREF: Boss_BackStringerTrackingAttack+11A   j
                addq.w  #8,$56(a5)
                lea     word_45460(pc),a1
                nop
                bra.s   loc_44E64
; ---------------------------------------------------------------------------
loc_44E52:                                              ; CODE XREF: Boss_BackStringerTrackingAttack+72   j
                cmpi.w  #$FF00,d2
                bmi.w   loc_44E46
loc_44E5A:                                              ; CODE XREF: Boss_BackStringerTrackingAttack+106   j
                subq.w  #8,$56(a5)
                lea     word_45472(pc),a1
                nop
loc_44E64:                                              ; CODE XREF: Boss_BackStringerTrackingAttack+BA   j
                                        ; Boss_BackStringerTrackingAttack+C0   j
                andi.w  #$1F8,$56(a5)
                bra.w   loc_44920
; End of function Boss_BackStringerTrackingAttack
; Defeat sequence initialization
Boss_BackStringerDefeatInit:                            ; CODE XREF: Boss_BackStringerMain+22   j  ; was: sub_44E6E
                move.b  #1,(byte_FF830E).w
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                move.w  #8,(word_FF808C).w
                clr.w   8(a5)
                move.w  #6,(word_FFA010).w
                move.w  #6,(word_FFA014).w
                move.w  #$28,4(a5)                      ; '('
                clr.w   2(a5)
                clr.b   $21(a5)
                move.w  #$280,$48(a5)
                move.w  #0,$AA(a5)
                move.w  #$10,$10A(a5)
                movea.w #(word_FFC740-M68K_RAM),a0
                lea     (Math_SineTable).l,a1
                moveq   #$20,d4                         ; ' '
                moveq   #0,d0
                moveq   #1,d7
                bsr.s   Boss_BackStringerInitChainSegments
                moveq   #2,d0
                moveq   #$11,d7
; End of function Boss_BackStringerDefeatInit
; Initializes chain segments with velocity
Boss_BackStringerInitChainSegments:                     ; CODE XREF: Boss_BackStringerDefeatInit+58   p  ; was: sub_44ECC
                                        ; Boss_BackStringerInitChainSegments+40   j
                move.w  #$358,(a0)
                move.w  #$CC00,2(a0)
                clr.b   $21(a0)
                move.w  d0,$48(a0)
                move.w  $56(a0),d1
                move.w  -$80(a1,d1.w),d2
                move.w  (a1,d1.w),d3
                ext.l   d2
                ext.l   d3
                asl.l   #3,d2
                asl.l   #4,d3
                move.l  d2,$1C(a0)
                move.l  d3,$18(a0)
                addi.l  #-$30000,$1C(a0)
                neg.w   d4
                move.w  d4,$5C(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_BackStringerInitChainSegments
                rts
; End of function Boss_BackStringerInitChainSegments
; Defeat fade out with timer
Boss_BackStringerDefeatFadeOut:                         ; DATA XREF: ROM:0004473A   o  ; was: sub_44F12
                subq.w  #1,$48(a5)
                cmpi.w  #$100,$48(a5)
                bmi.s   loc_44F44
                cmpi.w  #$27E,$48(a5)
                bne.s   loc_44F30
                move.b  #$B8,d0
                jsr     (Sound_PlaySFX).l
loc_44F30:                                              ; CODE XREF: Boss_BackStringerDefeatFadeOut+12   j
                cmpi.w  #$1E0,$48(a5)
                bne.s   loc_44F3E
                move.w  #$2E,(word_FF80C2).w            ; '.'
loc_44F3E:                                              ; CODE XREF: Boss_BackStringerDefeatFadeOut+24   j
                jmp     (Gfx_UpdatePaletteFade).l
; ---------------------------------------------------------------------------
loc_44F44:                                              ; CODE XREF: Boss_BackStringerDefeatFadeOut+A   j
                bset    #4,2(a5)
                addq.w  #2,(word_FFA950).w
                rts
; End of function Boss_BackStringerDefeatFadeOut
; Updates boss rendering
