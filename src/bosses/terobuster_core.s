Boss_TerobusterMain:                                    ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_38518
                tst.w   4(a5)
                beq.w   loc_38566
                jsr     (Gfx_InitPaletteFade).l
                tst.w   8(a5)
                beq.s   loc_38566
                btst    #2,(byte_FF80EC).w
                bne.s   loc_38544
                btst    #1,(byte_FF80EC).w
                bne.s   loc_38544
                tst.w   (word_FF8200).w
                beq.w   Boss_TerobusterBattleState
loc_38544:                                              ; CODE XREF: Boss_TerobusterMain+1A   j
                                        ; Boss_TerobusterMain+22   j
                lea     word_3859C(pc),a0
                nop
                move.w  (word_FFA000).w,d0
                asr.w   #1,d0
                andi.w  #6,d0
                move.w  (a0,d0.w),$1DE(a5)
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
loc_38566:                                              ; CODE XREF: Boss_TerobusterMain+4   j
                                        ; Boss_TerobusterMain+12   j
                move.w  4(a5),d0
                movea.w off_38576(pc,d0.w),a0
                adda.l  #word_3859C,a0
                jmp     (a0)
; End of function Boss_TerobusterMain
; ---------------------------------------------------------------------------
off_38576:      dc.w    Boss_TerobusterInit-word_3859C
                                        ; DATA XREF: Boss_TerobusterMain+52   r
                dc.w    Boss_TerobusterSetup-word_3859C
                dc.w    Boss_TerobusterMainAI-word_3859C
                dc.w    Boss_TerobusterMainAI_AttackState3-word_3859C
                dc.w    Boss_TerobusterMainAI_AttackState4-word_3859C
                dc.w    Boss_TerobusterAttackPattern1-word_3859C
                dc.w    Boss_TerobusterAttackPattern3-word_3859C
                dc.w    Boss_TerobusterDefeatInit-word_3859C
                dc.w    Boss_TerobusterFadeIn-word_3859C
                dc.w    Boss_TerobusterDescend-word_3859C
                dc.w    Boss_TerobusterDescend_FallingState-word_3859C
                dc.w    Boss_TerobusterDescend_LandingState-word_3859C
                dc.w    Boss_TerobusterBattleEnd-word_3859C
                dc.w    Boss_TerobusterPostBattleCleanup-word_3859C
                dc.w    Boss_TerobusterMainAI_AttackState4-word_3859C
                dc.w    Boss_TerobusterMainAI_RockAttackLoop-word_3859C
                dc.w    Boss_TerobusterMainAI-word_3859C
                dc.w    Boss_TerobusterDefeatTimer-word_3859C
                dc.w    Boss_TerobusterDefeatComplete-word_3859C
word_3859C:     dc.w    0, 2, 4, 2                      ; DATA XREF: Boss_TerobusterMain:loc_38544   o
                                        ; Boss_TerobusterMain+56   o

; Initializes Terobuster boss clearing sprites and setting flags
Boss_TerobusterInit:                                    ; DATA XREF: ROM:off_38576   o  ; was: sub_385A4
                addq.w  #2,4(a5)
                move.b  #1,(byte_FF830E).w
                move.w  #1,8(a5)
                move.w  #$B4,d0
                move.w  #$12C,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$80,$48(a5)
locret_385C8:                                           ; CODE XREF: Boss_TerobusterSetup+4   j
                                        ; Boss_TerobusterSetup+A   j
                rts
; End of function Boss_TerobusterInit
; Sets up Terobuster boss with complex metasprite initialization
Boss_TerobusterSetup:                                   ; DATA XREF: ROM:00038578   o  ; was: sub_385CA
                tst.b   (word_FFF720).w
                bmi.s   locret_385C8
                subq.w  #1,$48(a5)
                bpl.s   locret_385C8
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$A,d7
                movea.l #dword_34A8C,a0
                movea.l #word_34AB8,a1
                movea.l #word_34AC4,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$B4,(a5)
                clr.w   $54(a5)
                clr.w   $56(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $A(a5)
                move.w  #$D00,2(a5)
                move.w  #$200,$10(a5)
                move.w  #$C100,$1E2(a5)
                move.w  #$C100,$3C2(a5)
                move.w  #$10,$420(a5)
                move.w  #$8000,$422(a5)
                move.w  #$6467,$42E(a5)
                move.w  #$800,$428(a5)
                move.w  #$F4FC,$42A(a5)
                move.b  #$10,$440(a5)
                move.w  #$10,$480(a5)
                move.w  #$C000,$482(a5)
                move.w  #$B00,$48E(a5)
                move.l  #word_EB86A,$488(a5)
                move.b  #$10,$4A0(a5)
                movea.l #Boss_TerobusterObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                lea     word_3868A(pc),a0
                nop
                jsr     (Gfx_LoadCompressedTiles).l
                bra.w   Boss_TerobusterIntro
; ---------------------------------------------------------------------------
word_3868A:     dc.w    $6100, $2000, $201, $2A2B, $2C2D, $2E2F
                                        ; DATA XREF: Boss_TerobusterSetup+B0   o
; ---------------------------------------------------------------------------
loc_38696:                                              ; CODE XREF: Boss_TerobusterMainAI+F2   j
                                        ; Boss_TerobusterMainAI+1AC   j
                move.w  #2,$A(a5)
                bra.s   loc_386A2
; ---------------------------------------------------------------------------
loc_3869E:                                              ; CODE XREF: Boss_TerobusterMainAI+EE   j
                                        ; Boss_TerobusterMainAI+1A8   j
                clr.w   $A(a5)
loc_386A2:                                              ; CODE XREF: Boss_TerobusterSetup+D2   j
                                        ; Boss_TerobusterMainAI+286   j
                move.w  #4,4(a5)
                tst.w   (word_FF8234).w
                beq.s   loc_386B0
                bpl.s   loc_386B6
loc_386B0:                                              ; CODE XREF: Boss_TerobusterSetup+E2   j
                move.w  #$20,4(a5)                      ; ' '
loc_386B6:                                              ; CODE XREF: Boss_TerobusterSetup+E4   j
                move.w  #$10,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                movea.w #(word_FFC800-M68K_RAM),a0
                movea.w #(word_FFC9E0-M68K_RAM),a1
                tst.w   $A(a5)
                beq.s   loc_386D6
                exg     a0,a1
loc_386D6:                                              ; CODE XREF: Boss_TerobusterSetup+108   j
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                move.w  #$14C,$14(a0)
                lea     word_3936A(pc),a0
                nop
                bsr.w   Boss_TerobusterLoadFrameDelays
; End of function Boss_TerobusterSetup
; Complex boss AI state machine with attack patterns
Boss_TerobusterMainAI:                                  ; DATA XREF: ROM:0003857A   o  ; was: sub_386EE
                                        ; ROM:00038596   o
                cmpi.w  #$20,4(a5)                      ; ' '
                bne.s   loc_3870A
                addi.w  #$C,(word_FF8234).w
                cmpi.w  #$1E0,(word_FF8234).w
                bmi.s   loc_3876C
                move.w  #$1E0,(word_FF8234).w
loc_3870A:                                              ; CODE XREF: Boss_TerobusterMainAI+6   j
                subq.w  #1,$11C(a5)
                bpl.s   loc_3876C
                jsr     (Physics_GetPlayerDelta).l
                addi.w  #$28,d1                         ; '('
                tst.w   d1
                bmi.s   loc_38732
                tst.w   (word_FFFF0E).w
                beq.s   loc_38744
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                bne.w   loc_38826
                bra.s   loc_38744
; ---------------------------------------------------------------------------
loc_38732:                                              ; CODE XREF: Boss_TerobusterMainAI+2E   j
                btst    #7,(word_FFA000+1).w
                beq.s   loc_38744
                cmpi.w  #$1180,$BC(a5)
                bmi.w   loc_388F0
loc_38744:                                              ; CODE XREF: Boss_TerobusterMainAI+34   j
                                        ; Boss_TerobusterMainAI+42   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                addq.w  #1,d0
                move.w  d0,$11C(a5)
                cmpi.w  #$1190,$BC(a5)
                bpl.w   loc_38774
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.w   loc_38826
                bra.w   loc_38834
; ---------------------------------------------------------------------------
loc_3876C:                                              ; CODE XREF: Boss_TerobusterMainAI+14   j
                                        ; Boss_TerobusterMainAI+20   j
                bsr.w   Boss_TerobusterApplyAngles
                bra.w   Boss_TerobusterInitMetasprite
; ---------------------------------------------------------------------------
loc_38774:                                              ; CODE XREF: Boss_TerobusterMainAI+6A   j
                move.w  #6,4(a5)
                move.w  #8,$58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $1DC(a5)
; Terobuster boss attack state with missile spawning
Boss_TerobusterMainAI_AttackState3:                     ; DATA XREF: ROM:0003857C   o  ; was: loc_3878A
                cmpi.w  #8,$58(a5)
                beq.s   loc_3879A
                cmpi.w  #$18,$58(a5)
                bne.s   loc_387E4
loc_3879A:                                              ; CODE XREF: Boss_TerobusterMainAI+A2   j
                tst.w   $1DC(a5)
                beq.s   loc_387E4
                move.w  #3,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                move.b  #$49,d0                         ; 'I'
                jsr     (Sound_PlaySFX).l
                subi.w  #$80,(word_FF8234).w
                bmi.s   loc_387CC
                subq.w  #1,$11C(a5)
                bmi.s   loc_387CC
                cmpi.w  #$11A0,$BC(a5)
                bpl.s   loc_387E4
loc_387CC:                                              ; CODE XREF: Boss_TerobusterMainAI+CE   j
                                        ; Boss_TerobusterMainAI+D4   j
                moveq   #8,d0
                moveq   #$18,d1
                tst.w   $A(a5)
                beq.s   loc_387D8
                exg     d0,d1
loc_387D8:                                              ; CODE XREF: Boss_TerobusterMainAI+E6   j
                cmp.w   $58(a5),d0
                beq.w   loc_3869E
                bra.w   loc_38696
; ---------------------------------------------------------------------------
loc_387E4:                                              ; CODE XREF: Boss_TerobusterMainAI+AA   j
                                        ; Boss_TerobusterMainAI+B0   j
                bsr.w   Boss_TerobusterSpawnHomingMissile
                lea     word_39304(pc),a1
                nop
                bsr.w   Boss_TerobusterInterpolateAnimation
                movea.w #(word_FFC800-M68K_RAM),a0
                movea.w #(word_FFC9E0-M68K_RAM),a1
                tst.w   $A(a5)
                beq.s   loc_38802
                exg     a0,a1
loc_38802:                                              ; CODE XREF: Boss_TerobusterMainAI+110   j
                cmpi.w  #5,$58(a5)
                bmi.s   loc_38814
                cmpi.w  #$18,$58(a5)
                bpl.s   loc_38814
                exg     a0,a1
loc_38814:                                              ; CODE XREF: Boss_TerobusterMainAI+11A   j
                                        ; Boss_TerobusterMainAI+122   j
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                move.w  #$14C,$14(a0)
                bra.w   Boss_TerobusterInitMetasprite
; ---------------------------------------------------------------------------
loc_38826:                                              ; CODE XREF: Boss_TerobusterMainAI+3E   j
                                        ; Boss_TerobusterMainAI+76   j
                move.w  #$1C,4(a5)
                move.w  #8,$11C(a5)
                bra.s   loc_3883A
; ---------------------------------------------------------------------------
loc_38834:                                              ; CODE XREF: Boss_TerobusterMainAI+7A   j
                move.w  #8,4(a5)
loc_3883A:                                              ; CODE XREF: Boss_TerobusterMainAI+144   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Terobuster boss screen shake attack phase
Boss_TerobusterMainAI_AttackState4:                     ; DATA XREF: ROM:0003857E   o  ; was: loc_38844
                                        ; ROM:00038592   o
                cmpi.w  #$10,$58(a5)
                beq.s   loc_38854
                cmpi.w  #$20,$58(a5)                    ; ' '
                bne.s   loc_3889E
loc_38854:                                              ; CODE XREF: Boss_TerobusterMainAI+15C   j
                tst.w   $1DC(a5)
                beq.s   loc_3889E
                move.w  #3,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                move.b  #$49,d0                         ; 'I'
                jsr     (Sound_PlaySFX).l
                subi.w  #$80,(word_FF8234).w
                bmi.s   loc_38886
                subq.w  #1,$11C(a5)
                bmi.s   loc_38886
                cmpi.w  #$1220,$BC(a5)
                bmi.s   loc_3889E
loc_38886:                                              ; CODE XREF: Boss_TerobusterMainAI+188   j
                                        ; Boss_TerobusterMainAI+18E   j
                moveq   #$10,d0
                moveq   #$20,d1                         ; ' '
                tst.w   $A(a5)
                beq.s   loc_38892
                exg     d0,d1
loc_38892:                                              ; CODE XREF: Boss_TerobusterMainAI+1A0   j
                cmp.w   $58(a5),d0
                bne.w   loc_3869E
                bra.w   loc_38696
; ---------------------------------------------------------------------------
loc_3889E:                                              ; CODE XREF: Boss_TerobusterMainAI+164   j
                                        ; Boss_TerobusterMainAI+16A   j
                bsr.w   Boss_TerobusterSpawnHomingMissile
                lea     word_39348(pc),a0
                nop
                lea     word_39326(pc),a1
                nop
                cmpi.w  #8,4(a5)
                beq.s   loc_388B8
                exg     a0,a1
loc_388B8:                                              ; CODE XREF: Boss_TerobusterMainAI+1C6   j
                bsr.w   Boss_TerobusterInterpolateAnimation
                movea.w #(word_FFC800-M68K_RAM),a0
                movea.w #(word_FFC9E0-M68K_RAM),a1
                tst.w   $A(a5)
                beq.s   loc_388CC
                exg     a0,a1
loc_388CC:                                              ; CODE XREF: Boss_TerobusterMainAI+1DA   j
                cmpi.w  #$10,$58(a5)
                bmi.s   loc_388DE
                cmpi.w  #$20,$58(a5)                    ; ' '
                bpl.s   loc_388DE
                exg     a0,a1
loc_388DE:                                              ; CODE XREF: Boss_TerobusterMainAI+1E4   j
                                        ; Boss_TerobusterMainAI+1EC   j
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                move.w  #$14C,$14(a0)
                bra.w   Boss_TerobusterInitMetasprite
; ---------------------------------------------------------------------------
loc_388F0:                                              ; CODE XREF: Boss_TerobusterMainAI+52   j
                move.w  #$1E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $1DC(a5)
                move.w  #$C800,d0
                move.w  #$C9E0,d1
                tst.w   $A(a5)
                beq.s   loc_38914
                exg     d0,d1
loc_38914:                                              ; CODE XREF: Boss_TerobusterMainAI+222   j
                move.w  d0,$48(a5)
                move.w  d0,$4A(a5)
                move.w  d1,$11E(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                move.w  d0,$11C(a5)
                move.w  #$38,$17C(a5)                   ; '8'
; Terobuster falling rock spawn phase
Boss_TerobusterMainAI_RockAttackLoop:                   ; DATA XREF: ROM:00038594   o  ; was: loc_38932
                lea     word_39086(pc),a4
                nop
                tst.w   $11C(a5)
                bne.s   loc_38944
                lea     word_39090(pc),a4
                nop
loc_38944:                                              ; CODE XREF: Boss_TerobusterMainAI+24E   j
                subq.w  #1,$17C(a5)
                bmi.s   loc_3896E
                addi.w  #6,(word_FF8234).w
                cmpi.w  #$1E0,(word_FF8234).w
                bmi.s   loc_3895E
                move.w  #$1E0,(word_FF8234).w
loc_3895E:                                              ; CODE XREF: Boss_TerobusterMainAI+268   j
                lea     word_392D2(pc),a1
                nop
                bsr.w   Boss_TerobusterInterpolateAnimation
                bsr.w   Boss_TerobusterSpawnFallingRock
                bra.s   loc_38986
; ---------------------------------------------------------------------------
loc_3896E:                                              ; CODE XREF: Boss_TerobusterMainAI+25A   j
                subi.w  #$E,(word_FF8234).w
                bmi.w   loc_386A2
                lea     word_392D8(pc),a1
                nop
                bsr.w   Boss_TerobusterInterpolateAnimation
                bsr.w   Boss_TerobusterSpawnMultiDirectional
loc_38986:                                              ; CODE XREF: Boss_TerobusterMainAI+27E   j
                bsr.w   Boss_TerobusterInitMetasprite
                movea.w $48(a5),a0
                move.l  #word_EB7FE,8(a0)
                movea.w $11E(a5),a0
                move.w  #$14C,$14(a0)
                rts
; End of function Boss_TerobusterMainAI
; Terobuster boss intro positioning and animation setup
Boss_TerobusterIntro:                                   ; CODE XREF: Boss_TerobusterSetup+BC   j  ; was: sub_389A2
                move.w  #$10,4(a5)
                move.w  #$196,$10(a5)
                move.w  #$60,$14(a5)                    ; '`'
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                lea     word_3939A(pc),a0
                nop
                bsr.w   Boss_TerobusterLoadFrameDelays
                bsr.w   Gfx_SetPaletteSequence
; End of function Boss_TerobusterIntro
; Boss fade in effect preparing for battle start
Boss_TerobusterFadeIn:                                  ; DATA XREF: ROM:00038586   o  ; was: sub_389CA
                addq.w  #2,4(a5)
                move.w  #$30,$11C(a5)                   ; '0'
loc_389D4:                                              ; CODE XREF: Boss_TerobusterDescend+12   j
                bsr.w   Boss_TerobusterApplyAngles
                bra.w   Boss_TerobusterInitMetasprite
; End of function Boss_TerobusterFadeIn
; Boss descending animation with position interpolation
Boss_TerobusterDescend:                                 ; DATA XREF: ROM:00038588   o  ; was: sub_389DC
                subq.w  #1,$11C(a5)
                bmi.s   loc_389F0
                move.w  $11C(a5),d0
                subi.w  #$10,d0
                bsr.w   Boss_TerobusterLoadTilesByIndex
                bra.s   loc_389D4
; ---------------------------------------------------------------------------
loc_389F0:                                              ; CODE XREF: Boss_TerobusterDescend+4   j
                addq.w  #2,4(a5)
; Terobuster descending with velocity accumulation
Boss_TerobusterDescend_FallingState:                    ; DATA XREF: ROM:0003858A   o  ; was: loc_389F4
                addi.l  #$4000,$1C(a5)
                cmpi.w  #$14C,$3D4(a5)
                bpl.s   loc_38A12
                lea     word_392E2(pc),a1
                nop
                bsr.w   Boss_TerobusterInterpolateAnimation
                bra.w   Boss_TerobusterInitMetasprite
; ---------------------------------------------------------------------------
loc_38A12:                                              ; CODE XREF: Boss_TerobusterDescend+26   j
                addq.w  #2,4(a5)
                bsr.w   Boss_TerobusterInitBattleState
                clr.w   $11C(a5)
; Terobuster landing state with animation checks
Boss_TerobusterDescend_LandingState:                    ; DATA XREF: ROM:0003858C   o  ; was: loc_38A1E
                tst.w   $11C(a5)
                beq.s   loc_38A32
loc_38A24:                                              ; CODE XREF: Boss_TerobusterDescend+74   j
                tst.w   $58(a5)
                bmi.s   loc_38A74
                lea     word_392FE(pc),a1
                nop
                bra.s   loc_38A5A
; ---------------------------------------------------------------------------
loc_38A32:                                              ; CODE XREF: Boss_TerobusterDescend+46   j
                tst.w   $58(a5)
                bpl.s   loc_38A54
                addq.w  #1,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$4E,d0                         ; 'N'
                jsr     (Sound_PlaySFX).l
                bra.w   loc_38A24
; ---------------------------------------------------------------------------
loc_38A54:                                              ; CODE XREF: Boss_TerobusterDescend+5A   j
                lea     word_392EC(pc),a1
                nop
loc_38A5A:                                              ; CODE XREF: Boss_TerobusterDescend+54   j
                bsr.w   Boss_TerobusterInterpolateAnimation
                bsr.w   Boss_TerobusterInitMetasprite
                move.l  #word_EB7FE,$1E8(a0)
                move.l  #word_EB7FE,$3C8(a0)
                rts
; ---------------------------------------------------------------------------
loc_38A74:                                              ; CODE XREF: Boss_TerobusterDescend+4C   j
                addq.w  #2,4(a5)
                move.w  a5,$4A(a5)
                move.w  #$30,$11C(a5)                   ; '0'
                lea     word_3936A(pc),a0
                nop
                bsr.w   Boss_TerobusterLoadFrameDelays
; End of function Boss_TerobusterDescend
; Boss battle end sequence with victory condition check
Boss_TerobusterBattleEnd:                               ; DATA XREF: ROM:0003858E   o  ; was: sub_38A8C
                subq.w  #1,$11C(a5)
                bmi.s   loc_38A9A
                bsr.w   Boss_TerobusterApplyAngles
                bra.w   Boss_TerobusterInitMetasprite
; ---------------------------------------------------------------------------
loc_38A9A:                                              ; CODE XREF: Boss_TerobusterBattleEnd+4   j
                addq.w  #2,4(a5)
                moveq   #0,d0
                jsr     (UI_CheckVictoryCondition).l
                move.b  #$8A,d0
                jsr     (Sys_WaitVBlank).l
; End of function Boss_TerobusterBattleEnd
; Post-battle cleanup clearing flags and updating camera
Boss_TerobusterPostBattleCleanup:                       ; DATA XREF: ROM:00038590   o  ; was: sub_38AB0
                tst.w   (word_FF80C2).w
                bne.s   loc_38AC4
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
                bra.w   loc_3869E
; ---------------------------------------------------------------------------
loc_38AC4:                                              ; CODE XREF: Boss_TerobusterPostBattleCleanup+4   j
                bsr.w   Boss_TerobusterApplyAngles
                bra.w   Boss_TerobusterInitMetasprite
; End of function Boss_TerobusterPostBattleCleanup
; Battle state management with phase transitions
Boss_TerobusterBattleState:                             ; CODE XREF: Boss_TerobusterMain+28   j  ; was: sub_38ACC
                move.b  #$AC,d0
                jsr     (Sound_PlaySFX).l
                bset    #0,(byte_FFA272).w
                move.w  #$A,4(a5)
                move.b  #2,(byte_FF80EC).w
                clr.w   8(a5)
                move.w  #4,(word_FF808C).w
                move.w  #8,(word_FFA010).w
                move.w  #8,(word_FFA014).w
                jsr     (Sprite_ClearObjectFlags).l
                move.l  #$20000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   loc_38B1C
                move.l  #$FFFE0000,$18(a5)
loc_38B1C:                                              ; CODE XREF: Boss_TerobusterBattleState+46   j
                move.l  #$FFFF0000,$1C(a5)
                move.w  #$FFFF,$48(a5)
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #9,d7
loc_38B30:                                              ; CODE XREF: Boss_TerobusterBattleState+80   j
                btst    #7,2(a0)
                bne.s   loc_38B40
                bset    #4,2(a0)
                bra.s   loc_38B48
; ---------------------------------------------------------------------------
loc_38B40:                                              ; CODE XREF: Boss_TerobusterBattleState+6A   j
                move.w  #$B8,(a0)
                clr.w   4(a0)
loc_38B48:                                              ; CODE XREF: Boss_TerobusterBattleState+72   j
                lea     $60(a0),a0
                dbf     d7,loc_38B30
                move.w  #4,$422(a5)
                move.w  #4,$482(a5)
; End of function Boss_TerobusterBattleState
; First attack pattern with projectile timing
