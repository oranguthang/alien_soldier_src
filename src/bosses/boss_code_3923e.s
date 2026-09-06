Boss_TerobusterApplyAngles:                              ; CODE XREF: Boss_TerobusterMainAI:loc_3876C   p  ; was: sub_3923E
                                        ; sub_389CA:loc_389D4   p ...
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(dword_FF940C-M68K_RAM),a1
                tst.w   $A(a5)
                beq.s   loc_39252
                exg     a0,a1
loc_39252:                              ; CODE XREF: Boss_TerobusterApplyAngles+10   j
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.w  d0,$116(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.w  d1,$1D6(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.b  (a1),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$296(a5)
                move.w  d0,$2F6(a5)
                move.b  4(a1),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$356(a5)
                move.w  d1,$3B6(a5)
                move.b  8(a1),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                rts
; End of function Boss_TerobusterApplyAngles
; Calculates interpolation deltas for smooth animation
Boss_TerobusterCalculateDeltas:                              ; CODE XREF: Boss_TerobusterInterpolateAnimation+4E   p  ; was: sub_392B0
                movea.l #word_34ADA,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #5,d7
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_TerobusterCalculateDeltas
; Loads animation frame delays for timing system
Boss_TerobusterLoadFrameDelays:                              ; CODE XREF: Boss_TerobusterSetup+120   p  ; was: sub_392C6
                                        ; Boss_TerobusterIntro+20   p ...
                movea.w #(dword_FF9400-M68K_RAM),a1
                moveq   #5,d7
                jmp Anim_LoadFrameDelays
; End of function Boss_TerobusterLoadFrameDelays
; ---------------------------------------------------------------------------
word_392D2:     dc.w 4, 0, $FFFF        ; DATA XREF: Boss_TerobusterMainAI:loc_3895E   o
word_392D8:     dc.w 3, 0, 1, $36, $FFFF
                                        ; DATA XREF: Boss_TerobusterMainAI+28A   o
word_392E2:     dc.w $10, $2A, $20, $30, $FFFE
                                        ; DATA XREF: Boss_TerobusterDescend+28   o
word_392EC:     dc.w $FD12, $30, $34, $30, $F040, $24, $20, $24, $FFFE
                                        ; DATA XREF: Boss_TerobusterDescend:loc_38A54   o
word_392FE:     dc.w $1C, 0, $FFFE      ; DATA XREF: Boss_TerobusterDescend+4E   o
word_39304:     dc.w 5, 0, $FA0E, 0, $E, 6, $14, $C, 5, $12, $FA0E, $12, $E, $18, $14, $1E
                                        ; DATA XREF: Boss_TerobusterMainAI+FA   o
                dc.w $FFFF
word_39326:     dc.w $14, $1E, $E, $18, 5, $12, $FA0E, $12, $14, $C, $E, 6, 5, 0, $FA0E, 0
                                        ; DATA XREF: Boss_TerobusterMainAI+1BA   o
                dc.w $FFFF
word_39348:     dc.w 6, $1E, 8, $18, 3, $12, $FA08, $12, 6, $C, 8, 6, 3, 0, $FA08, 0
                                        ; DATA XREF: Boss_TerobusterMainAI+1B4   o
                dc.w $FFFF
word_3936A:     dc.w $1330, $F840, $30D0, $F460, $C030, $44C8, $3060, $9024
                                        ; DATA XREF: Boss_TerobusterSetup+11A   o
                                        ; Boss_TerobusterDescend+A6   o ...
                dc.w $24F8, $4030, $D013, $30F8, $3044, $C8F4, $60C0, $2424
                dc.w $F830, $6090, $2040, $E020, $40E0, $4000, $CC40, $CC
word_3939A:     dc.w $70, $D400, $70D4, $1431, $F842, $2ED0
                                        ; DATA XREF: Boss_TerobusterIntro+1A   o


; Sets up palette color sequence for visual effect with repeated values
Gfx_SetPaletteSequence:                              ; CODE XREF: Boss_TerobusterIntro+24   p  ; was: sub_393A6
                movea.l #(M68K_RAM_PHYSICAL+(byte_FF644A-M68K_RAM)),a0
                move.b  #$CE,d0
                move.b  #$C5,(a0)+
                move.b  d0,(a0)+
                move.b  d0,(a0)+
                move.b  d0,(a0)+
                move.b  d0,(a0)+
                rts
; End of function Gfx_SetPaletteSequence
; Loads compressed tiles by index with bounds checking
Boss_TerobusterLoadTilesByIndex:                              ; CODE XREF: Boss_TerobusterDescend+E   p  ; was: sub_393BE
                asl.w   #2,d0
                bmi.s   locret_393D2
                cmpi.w  #$4C,d0 ; 'L'
                bpl.s   locret_393D2
                movea.l off_393D4(pc,d0.w),a0
                jmp Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
locret_393D2:                           ; CODE XREF: Boss_TerobusterLoadTilesByIndex+2   j
                                        ; Boss_TerobusterLoadTilesByIndex+8   j
                rts
; End of function Boss_TerobusterLoadTilesByIndex
; ---------------------------------------------------------------------------
off_393D4:      dc.l byte_394D0         ; DATA XREF: Boss_TerobusterLoadTilesByIndex+A   r
                dc.l byte_394C8
                dc.l byte_394C0
                dc.l byte_394B8
                dc.l byte_394B0
                dc.l byte_394A8
                dc.l byte_394A0
                dc.l byte_39496
                dc.l byte_3948C
                dc.l byte_39482
                dc.l byte_39478
                dc.l byte_3946E
                dc.l byte_39464
                dc.l byte_3945A
                dc.l byte_39450
                dc.l byte_39444
                dc.l byte_39438
                dc.l byte_3942C
                dc.l byte_39420
byte_39420:     dc.b $42, $51, $40, 0, 4, 0, $C2, $C7, $C6, $C6, $C6, 0
                                        ; DATA XREF: ROM:0003941C   o
byte_3942C:     dc.b $42, $51, $40, 0, 4, 0, $C3, $C8, $B9, $B9, $B9, 0
                                        ; DATA XREF: ROM:00039418   o
byte_39438:     dc.b $42, $51, $40, 0, 4, 0, $C4, $C9, $C6, $C6, $C6, 0
                                        ; DATA XREF: ROM:00039414   o
byte_39444:     dc.b $42, $51, $40, 0, 4, 0, $C5, $CA, $B9, $B9, $B9, 0
                                        ; DATA XREF: ROM:00039410   o
byte_39450:     dc.b $42, $59, $40, 0, 3, 0, $CB, $C7, $C6, $C6
                                        ; DATA XREF: ROM:0003940C   o
byte_3945A:     dc.b $42, $59, $40, 0, 3, 0, $CC, $C8, $B9, $B9
                                        ; DATA XREF: ROM:00039408   o
byte_39464:     dc.b $42, $59, $40, 0, 3, 0, $CD, $C9, $C6, $C6
                                        ; DATA XREF: ROM:00039404   o
byte_3946E:     dc.b $42, $59, $40, 0, 3, 0, $CE, $CA, $B9, $B9
                                        ; DATA XREF: ROM:00039400   o
byte_39478:     dc.b $42, $61, $40, 0, 2, 0, $CB, $C7, $C6, 0
                                        ; DATA XREF: ROM:000393FC   o
byte_39482:     dc.b $42, $61, $40, 0, 2, 0, $CC, $C8, $B9, 0
                                        ; DATA XREF: ROM:000393F8   o
byte_3948C:     dc.b $42, $61, $40, 0, 2, 0, $CD, $C9, $C6, 0
                                        ; DATA XREF: ROM:000393F4   o
byte_39496:     dc.b $42, $61, $40, 0, 2, 0, $CE, $CA, $B9, 0
                                        ; DATA XREF: ROM:000393F0   o
byte_394A0:     dc.b $42, $69, $40, 0, 1, 0, $CB, $C7
                                        ; DATA XREF: ROM:000393EC   o
byte_394A8:     dc.b $42, $69, $40, 0, 1, 0, $CC, $C8
                                        ; DATA XREF: ROM:000393E8   o
byte_394B0:     dc.b $42, $69, $40, 0, 1, 0, $CD, $C9
                                        ; DATA XREF: ROM:000393E4   o
byte_394B8:     dc.b $42, $69, $40, 0, 1, 0, $CE, $CA
                                        ; DATA XREF: ROM:000393E0   o
byte_394C0:     dc.b $42, $71, $40, 0, 1, 0, $CE, $CB
                                        ; DATA XREF: ROM:000393DC   o
byte_394C8:     dc.b $42, $71, $40, 0, 1, 0, $CE, $CD
                                        ; DATA XREF: ROM:000393D8   o
byte_394D0:     dc.b $42, $71, $40, 0, 1, 0, $CE, $CE
                                        ; DATA XREF: ROM:off_393D4   o


; Main Shellshogun boss handler with state dispatch
Boss_ShellshogunMainHandler:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_394D8
                tst.w   4(a5)
                beq.w   loc_39512
                tst.w   $26(a5)
                beq.w   loc_39512
                btst    #2,(byte_FF80EC).w
                bne.s   loc_39500
                btst    #1,(byte_FF80EC).w
                bne.s   loc_39500
                tst.w   (word_FF8200).w
                beq.w Boss_ShellshogunIdleState
loc_39500:                              ; CODE XREF: Boss_ShellshogunMainHandler+16   j
                                        ; Boss_ShellshogunMainHandler+1E   j
                jsr (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$17E(a5)
loc_39512:                              ; CODE XREF: Boss_ShellshogunMainHandler+4   j
                                        ; Boss_ShellshogunMainHandler+C   j
                move.w  4(a5),d0
                movea.w off_39522(pc,d0.w),a0
                adda.l  #Boss_ShellshogunInitState,a0
                jmp     (a0)
; End of function Boss_ShellshogunMainHandler
; ---------------------------------------------------------------------------
off_39522:      dc.w Boss_ShellshogunInitState-Boss_ShellshogunInitState
                                        ; DATA XREF: Boss_ShellshogunMainHandler+3E   r
                dc.w Boss_ShellshogunSetupPhase-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunPhaseCheck-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunMoveLeft-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunMoveRight-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunAttackPattern-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunSpawnShells-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunSlamAttack_PrepareSlam-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunSlamAttackUpdate-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunChargeAttack-Boss_ShellshogunInitState
                dc.w Boss_InitPositionTracking-Boss_ShellshogunInitState
                dc.w Boss_UpdatePositionDelta-Boss_ShellshogunInitState
                dc.w Boss_TrackPlayerPosition-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunTransitionState-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunVerticalMovement-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunJumpAttackUpdate-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunJumpAttack_AirPhase-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunDescendUpdate-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunLandingSequence-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunDecelerateHorizontal-Boss_ShellshogunInitState
                dc.w Boss_ShellshogunAttack_ShellProjectile-Boss_ShellshogunInitState


; Initializes Shellshogun boss state and clears objects
Boss_ShellshogunInitState:                              ; DATA XREF: Boss_ShellshogunMainHandler+42   o  ; was: sub_3954C
                                        ; ROM:off_39522   o ...
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5) ; '@'
                move.w  #$F4,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                clr.w   8(a5)
                clr.w   $A(a5)
                move.b  #1,(byte_FF830E).w
locret_39570:                           ; CODE XREF: Boss_ShellshogunSetupPhase+4   j
                                        ; Boss_ShellshogunSetupPhase+C   j
                rts
; End of function Boss_ShellshogunInitState
; Sets up boss phase with metasprite initialization
Boss_ShellshogunSetupPhase:                              ; DATA XREF: ROM:00039524   o  ; was: sub_39572
                subq.w  #1,$48(a5)
                bmi.w   locret_39570
                tst.w   (word_FFF720).w
                bmi.s   locret_39570
                clr.w   $48(a5)
                addq.w  #2,4(a5)
                move.w  #$20,$BC(a5) ; ' '
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
                clr.w   $23C(a5)
                clr.w   $29C(a5)
                addq.w  #1,$26(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$15,d7
                moveq   #$17,d7
                movea.l #dword_34BAC,a0
                movea.l #word_34C0C,a1
                movea.l #word_34C24,a2
                jsr (Sprite_InitMetaspriteComplex).l
                bset    #7,$6E(a5)
                bset    #7,$CE(a5)
                bset    #7,$4EE(a5)
                bsr.w Boss_ShellshogunInitPalette
                bset    #0,2(a5)
                bset    #0,$482(a5)
                bset    #0,$8A2(a5)
                move.w  #$F4,(a5)
                move.w  #$100,$54(a5)
                clr.w   $56(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                movea.w #(byte_FFCF20-M68K_RAM),a0
                move.w  #$6464,d0
                moveq   #2,d7
loc_39610:                              ; CODE XREF: Boss_ShellshogunSetupPhase+C4   j
                move.w  #$10,(a0)
                move.w  #$8000,2(a0)
                move.w  d0,$E(a0)
                move.b  #$80,$20(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                addq.w  #4,d0
                lea     $60(a0),a0
                dbf     d7,loc_39610
                move.w  #0,$9C8(a5)
                move.w  #$FCFC,$9CA(a5)
                movea.w #(byte_FFD040-M68K_RAM),a0
                moveq   #2,d7
loc_3964C:                              ; CODE XREF: Boss_ShellshogunSetupPhase+10A   j
                move.w  #$10,(a0)
                clr.w   2(a0)
                clr.w   $10(a0)
                clr.b   $21(a0)
                move.b  #$10,$23(a0)
                move.l  #$FA06FA06,$2C(a0)
                move.l  #$FA06FA06,$28(a0)
                move.w  #$63,$26(a0) ; 'c'
                lea     $60(a0),a0
                dbf     d7,loc_3964C
                move.w  #$8300,$A2E(a5)
                move.w  #$C000,$A22(a5)
                move.l  #word_EB98A,$A28(a5)
                move.b  #$C,$A40(a5)
                movea.l #word_1BA48,a1
                jsr (Sprite_InitFromPointerTable).l
                movea.l #byte_396C6,a0
                jsr (Gfx_LoadCompressedTiles).l
                bsr.w Boss_ShellshogunInitSprites
                move.w  #$2E0,$490(a5)
                move.w  #$2E0,$8B0(a5)
                bra.w Boss_ShellshogunSetParams
; End of function Boss_ShellshogunSetupPhase
; ---------------------------------------------------------------------------
byte_396C6:     dc.b $61, 0, $20, 0, 2, 1, 3, 1, 2, 4, 5, 6
                                        ; DATA XREF: Boss_ShellshogunSetupPhase+134   o


; Checks phase conditions and advances state
Boss_ShellshogunPhaseCheck:                              ; DATA XREF: ROM:00039526   o  ; was: sub_396D2
                bsr.w Boss_ShellshogunSetParams
                tst.w   $17C(a5)
                beq.s   locret_3971E
                cmpi.w  #$C,$58(a5)
                beq.s   loc_39708
                cmpi.w  #4,$58(a5)
                bne.s   locret_3971E
                cmpi.w  #$13A8,$17E(a5)
                bpl.s   loc_39708
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$BE(a5) ; '@'
loc_39708:                              ; CODE XREF: Boss_ShellshogunPhaseCheck+10   j
                                        ; Boss_ShellshogunPhaseCheck+20   j
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #$A1,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_3971E:                           ; CODE XREF: Boss_ShellshogunPhaseCheck+8   j
                                        ; Boss_ShellshogunPhaseCheck+18   j
                rts
; End of function Boss_ShellshogunPhaseCheck
; Boss movement left with velocity update
Boss_ShellshogunMoveLeft:                              ; DATA XREF: ROM:00039528   o  ; was: sub_39720
                move.w  #$10,$BC(a5)
                move.w  a5,$48(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$148,$8B4(a5)
                bsr.w Boss_ShellshogunAttackPattern
                subq.w  #1,$BE(a5)
                bpl.s   locret_39756
                addq.w  #2,4(a5)
                moveq   #4,d0
                jsr (UI_CheckVictoryCondition).l
                move.b  #$8A,d0
                jsr (Input_CheckButtonMode).l
locret_39756:                           ; CODE XREF: Boss_ShellshogunMoveLeft+1E   j
                rts
; End of function Boss_ShellshogunMoveLeft
; Boss movement right with velocity update
Boss_ShellshogunMoveRight:                              ; DATA XREF: ROM:0003952A   o  ; was: sub_39758
                move.w  #$10,$BC(a5)
                bsr.w Boss_ShellshogunAttackPattern
                tst.w   (word_FF80C2).w
                bne.s   locret_39776
                addq.w  #2,4(a5)
                clr.b   (byte_FF80EC).w
                subi.w  #$40,(word_FFA970).w ; '@'
locret_39776:                           ; CODE XREF: Boss_ShellshogunMoveRight+E   j
                rts
; End of function Boss_ShellshogunMoveRight
; Boss idle state with position tracking
Boss_ShellshogunIdleState:                              ; CODE XREF: Boss_ShellshogunMainHandler+24   j  ; was: sub_39778
                move.b  #1,(byte_FF830E).w
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr (Sprite_ClearObjectFlags).l
                move.w  #$48,(word_FF809E).w ; 'H'
                move.w  #$12,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.b  #$C,$A40(a5)
                clr.b   $A41(a5)
                move.w  #$13F,$BC(a5)
                clr.w   6(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bra.s   loc_3982A
; End of function Boss_ShellshogunIdleState
; Boss charge attack with velocity buildup
Boss_ShellshogunChargeAttack:                              ; DATA XREF: ROM:00039534   o  ; was: sub_397C4
                jsr (Gfx_UpdatePaletteFade).l
                tst.w   $BC(a5)
                bpl.s   loc_39802
                jsr (Gfx_QueueDMATransfer).l
                addq.w  #4,6(a5)
                cmpi.w  #$20,6(a5) ; ' '
                bmi.s   loc_39802
                addq.w  #2,4(a5)
                move.w  #$60,$BC(a5) ; '`'
                clr.w   $26(a5)
                move.w  #$FEB0,(dword_FFA908).w
                move.w  #$F4,d0
                moveq   #0,d1
                jmp Sprite_ClearAllExcept
; ---------------------------------------------------------------------------
loc_39802:                              ; CODE XREF: Boss_ShellshogunChargeAttack+A   j
                                        ; Boss_ShellshogunChargeAttack+1C   j
                subq.w  #1,$BC(a5)
                addi.w  #$C,$56(a5)
                andi.w  #$1FE,$56(a5)
                addi.l  #$4000,$1C(a5)
                bmi.s   loc_3986A
                cmpi.w  #$120,$14(a5)
                bmi.s   loc_3986A
                move.w  #$120,$14(a5)
loc_3982A:                              ; CODE XREF: Boss_ShellshogunIdleState+4A   j
                move.l  #$FFFBA000,$1C(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  (dword_FFFF08).w,$1A(a5)
                cmpi.w  #$12A8,$17E(a5)
                bmi.s   loc_3985C
                cmpi.w  #$1328,$17E(a5)
                bpl.s   loc_39864
                btst    #3,(dword_FFFF08+1).w
                bne.s   loc_39864
loc_3985C:                              ; CODE XREF: Boss_ShellshogunChargeAttack+86   j
                move.w  #2,$18(a5)
                bra.s   loc_3986A
; ---------------------------------------------------------------------------
loc_39864:                              ; CODE XREF: Boss_ShellshogunChargeAttack+8E   j
                                        ; Boss_ShellshogunChargeAttack+96   j
                move.w  #$FFFD,$18(a5)
loc_3986A:                              ; CODE XREF: Boss_ShellshogunChargeAttack+56   j
                                        ; Boss_ShellshogunChargeAttack+5E   j ...
                bsr.w Boss_ShellshogunFlashOnHit
                lea     word_3A380(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bra.w Boss_ShellshogunUpdateWrapper
; End of function Boss_ShellshogunChargeAttack
; Initializes boss position tracking
Boss_InitPositionTracking:                              ; DATA XREF: ROM:00039536   o  ; was: sub_3987C
                jsr (Gfx_UpdatePaletteFade).l
                subq.w  #1,$BC(a5)
                bpl.s   loc_39898
                addq.w  #2,4(a5)
                jsr (Effect_InitPlayerSpawn).l
                move.b  #4,(byte_FFA95A).w
loc_39898:                              ; CODE XREF: Boss_InitPositionTracking+A   j
                jmp Gfx_QueueDMATransfer
; End of function Boss_InitPositionTracking
; Updates boss position delta for tracking
Boss_UpdatePositionDelta:                              ; DATA XREF: ROM:00039538   o  ; was: sub_3989E
                subq.w  #2,6(a5)
                bne.s   loc_398AE
                addq.w  #2,4(a5)
                move.w  #$E0,$BC(a5)
loc_398AE:                              ; CODE XREF: Boss_UpdatePositionDelta+4   j
                jmp Gfx_QueueDMATransfer
; End of function Boss_UpdatePositionDelta
; Tracks player position for boss AI
Boss_TrackPlayerPosition:                              ; DATA XREF: ROM:0003953A   o  ; was: sub_398B4
                subq.w  #1,$BC(a5)
                bpl.s   locret_398C0
                bset    #4,2(a5)
locret_398C0:                           ; CODE XREF: Boss_TrackPlayerPosition+4   j
                rts
; End of function Boss_TrackPlayerPosition
; Resets Shellshogun boss to idle state with cleared velocities and animations
Boss_ShellshogunResetToIdle:                              ; CODE XREF: Boss_ShellshogunSpawnShells+2A   j  ; was: sub_398C2
                                        ; Boss_ShellshogunSlamAttackUpdate+2E   j ...
                move.w  #$1E0,d0
                sub.w   (word_FF8234).w,d0
                asr.w   #4,d0
                addq.w  #2,d0
                move.w  d0,$BC(a5)
loc_398D2:                              ; CODE XREF: Boss_ShellshogunAttackPattern+B6   j
                                        ; Boss_ShellshogunSpawnShells+52   j
                move.w  #$A,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.w   $29C(a5)
                clr.b   $A41(a5)
                move.w  a5,$48(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$148,$8B4(a5)
; End of function Boss_ShellshogunResetToIdle
; Boss attack pattern with projectile spawn
Boss_ShellshogunAttackPattern:                              ; CODE XREF: Boss_ShellshogunMoveLeft+16   p  ; was: sub_398FE
                                        ; Boss_ShellshogunMoveRight+6   p
                                        ; DATA XREF: ...
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_3990C
                bsr.w Boss_ShellshogunCheckDefeat
loc_3990C:                              ; CODE XREF: Boss_ShellshogunAttackPattern+8   j
                subq.w  #1,$BC(a5)
                bpl.s   loc_39972
                move.w  (word_FF8234).w,d0
                beq.w   loc_39988
                cmpi.w  #$6000,(word_FF8200).w
                bpl.s   loc_3992A
                cmpi.w  #$1D8,d0
                bpl.w Boss_ShellshogunInitJumpAttack
loc_3992A:                              ; CODE XREF: Boss_ShellshogunAttackPattern+22   j
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$D0,d0
                bpl.s   loc_39954
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                beq.s   loc_3995E
                btst    #1,d0
                beq.w Boss_ShellshogunInitAttackState
                btst    #0,d0
                beq.w Boss_ShellshogunSlamAttackInit
                bra.w Boss_ShellshogunInitDescendState
; ---------------------------------------------------------------------------
loc_39954:                              ; CODE XREF: Boss_ShellshogunAttackPattern+36   j
                btst    #3,(dword_FFFF08).w
                bne.w Boss_ShellshogunInitAttackState
loc_3995E:                              ; CODE XREF: Boss_ShellshogunAttackPattern+40   j
                move.w  #$C,4(a5)
                move.w  #4,$58(a5)
                move.w  #$FFFF,$C(a5)
                rts
; ---------------------------------------------------------------------------
loc_39972:                              ; CODE XREF: Boss_ShellshogunAttackPattern+12   j
                lea     word_3A2E6(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bsr.w Boss_ShellshogunUpdateWrapper
                move.w  #$148,$494(a5)
                rts
; ---------------------------------------------------------------------------
loc_39988:                              ; CODE XREF: Boss_ShellshogunAttackPattern+18   j
                move.b  #$42,d0 ; 'B'
                jsr (Sound_PlaySFX).l
                move.w  #$28,4(a5) ; '('
                move.w  #$BA,$BC(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Shellshogun shell projectile attack with scroll
Boss_ShellshogunAttack_ShellProjectile:                              ; DATA XREF: ROM:0003954A   o  ; was: loc_399A8
                subq.w  #1,$BC(a5)
                bpl.s   loc_399B8
                move.w  #$50,$BC(a5) ; 'P'
                bra.w   loc_398D2
; ---------------------------------------------------------------------------
loc_399B8:                              ; CODE XREF: Boss_ShellshogunAttackPattern+AE   j
                addi.w  #3,(word_FF8234).w
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                lea     word_3A2F0(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bsr.w Boss_ShellshogunUpdateWrapper
                move.w  #$148,$494(a5)
                move.l  #word_EB888,$68(a5)
                rts
; End of function Boss_ShellshogunAttackPattern
; Spawns shell projectiles in pattern
Boss_ShellshogunSpawnShells:                              ; DATA XREF: ROM:0003952E   o  ; was: sub_399E8
                bsr.w Boss_ShellshogunSetParams
                tst.w   $17C(a5)
                beq.s   locret_39A54
                cmpi.w  #$C,$58(a5)
                beq.s   loc_39A3E
                cmpi.w  #4,$58(a5)
                bne.s   locret_39A54
                tst.w   (word_FF8234).w
                bne.s   loc_39A16
                clr.w   $58(a5)
                move.w  #4,$BC(a5)
                bra.w Boss_ShellshogunResetToIdle
; ---------------------------------------------------------------------------
loc_39A16:                              ; CODE XREF: Boss_ShellshogunSpawnShells+1E   j
                move.w  $17E(a5),d0
                tst.w   $54(a5)
                beq.s   loc_39A28
                cmpi.w  #$1288,d0
                bpl.s   loc_39A56
                bra.s   loc_39A2E
; ---------------------------------------------------------------------------
loc_39A28:                              ; CODE XREF: Boss_ShellshogunSpawnShells+36   j
                cmpi.w  #$1348,d0
                bmi.s   loc_39A56
loc_39A2E:                              ; CODE XREF: Boss_ShellshogunSpawnShells+3E   j
                move.w  #4,$58(a5)
                move.w  #$60,$BC(a5) ; '`'
                bra.w   loc_398D2
; ---------------------------------------------------------------------------
loc_39A3E:                              ; CODE XREF: Boss_ShellshogunSpawnShells+10   j
                                        ; Boss_ShellshogunSpawnShells+74   j ...
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #$A1,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_39A54:                           ; CODE XREF: Boss_ShellshogunSpawnShells+8   j
                                        ; Boss_ShellshogunSpawnShells+18   j
                rts
; ---------------------------------------------------------------------------
loc_39A56:                              ; CODE XREF: Boss_ShellshogunSpawnShells+3C   j
                                        ; Boss_ShellshogunSpawnShells+44   j
                jsr (Physics_CalculateDistanceTo).l
                beq.s   loc_39A3E
                cmpi.w  #$88,d0
                bpl.s   loc_39A3E
                bsr.w Boss_ShellshogunSlamAttackInit
                bra.s   loc_39A3E
; End of function Boss_ShellshogunSpawnShells
; Initiates Shellshogun slam attack sequence with physics and sound effects
Boss_ShellshogunSlamAttackInit:                              ; CODE XREF: Boss_ShellshogunAttackPattern+4E   j  ; was: sub_39A6A
                                        ; Boss_ShellshogunSpawnShells+7C   p
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$148,$8B4(a5)
; Shellshogun slam attack preparation
Boss_ShellshogunSlamAttack_PrepareSlam:                              ; DATA XREF: ROM:00039530   o  ; was: loc_39A8A
                bsr.w Boss_ShellshogunPhysicsUpdate
                cmpi.w  #$14,$58(a5)
                bmi.s Boss_ShellshogunUpdateAnimation
                addq.w  #2,4(a5)
                move.w  #$CEC0,$48(a5)
                move.w  $296(a5),$29C(a5)
                move.b  #$C0,$A41(a5)
                subi.w  #$50,(word_FF8234).w ; 'P'
                move.b  #$D1,d0
                jsr (Sound_PlaySFX).l
                bra.s Boss_ShellshogunUpdateAnimation
; End of function Boss_ShellshogunSlamAttackInit
; Updates slam attack state with timing checks and rotation animation
Boss_ShellshogunSlamAttackUpdate:                              ; DATA XREF: ROM:00039532   o  ; was: sub_39ABE
                bsr.s Boss_ShellshogunUpdateAnimation
                tst.w   $17C(a5)
                beq.s   loc_39AE8
                cmpi.w  #$18,$58(a5)
                bne.s   loc_39AE8
                move.b  #$A1,d0
                jsr (Sound_PlaySFX).l
                move.w  #8,(word_FFA010).w
                move.w  #8,(word_FFA014).w
                clr.b   $A41(a5)
loc_39AE8:                              ; CODE XREF: Boss_ShellshogunSlamAttackUpdate+6   j
                                        ; Boss_ShellshogunSlamAttackUpdate+E   j
                tst.w   $58(a5)
                bmi.w Boss_ShellshogunResetToIdle
                move.w  $29C(a5),d0
                beq.s   loc_39AFE
                addi.w  #$10,d0
                andi.w  #$1F0,d0
loc_39AFE:                              ; CODE XREF: Boss_ShellshogunSlamAttackUpdate+36   j
                move.w  d0,$29C(a5)
                rts
; End of function Boss_ShellshogunSlamAttackUpdate
; Updates Shellshogun animation and sprite rendering with metasprite data
Boss_ShellshogunUpdateAnimation:                              ; CODE XREF: Boss_ShellshogunSlamAttackInit+2A   j  ; was: sub_39B04
                                        ; Boss_ShellshogunSlamAttackInit+52   j ...
                lea     word_3A2FA(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bsr.w Boss_ShellshogunRenderSprites
                move.l  #word_EB888,$68(a5)
                rts
; End of function Boss_ShellshogunUpdateAnimation
; Initialize Shellshogun boss attack state with timers and flags
Boss_ShellshogunInitAttackState:                              ; CODE XREF: Boss_ShellshogunAttackPattern+46   j  ; was: sub_39B1C
                                        ; Boss_ShellshogunAttackPattern+5C   j
                move.w  #$1A,4(a5)
                move.w  #1,$11E(a5)
                move.w  #0,$29C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; End of function Boss_ShellshogunInitAttackState
; Handle Shellshogun state transition with animation and sprite updates
Boss_ShellshogunTransitionState:                              ; DATA XREF: ROM:0003953C   o  ; was: sub_39B38
                tst.w   $11E(a5)
                bpl.s   loc_39B58
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                move.b  #$C0,$A41(a5)
                subi.w  #$20,$29C(a5) ; ' '
                andi.w  #$1E0,$29C(a5)
loc_39B58:                              ; CODE XREF: Boss_ShellshogunTransitionState+4   j
                lea     word_3A33E(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bsr.w Boss_ShellshogunRenderSprites
                move.l  #word_EB876,$68(a5)
                rts
; End of function Boss_ShellshogunTransitionState
; Manage Shellshogun vertical movement and collision with screen shake effects
Boss_ShellshogunVerticalMovement:                              ; DATA XREF: ROM:0003953E   o  ; was: sub_39B70
                tst.w   $58(a5)
                bpl.s   loc_39B7E
                clr.l   $18(a5)
                bra.w Boss_ShellshogunResetToIdle
; ---------------------------------------------------------------------------
loc_39B7E:                              ; CODE XREF: Boss_ShellshogunVerticalMovement+4   j
                tst.w   $29C(a5)
                beq.s   loc_39B90
                subi.w  #$10,$29C(a5)
                andi.w  #$1E0,$29C(a5)
loc_39B90:                              ; CODE XREF: Boss_ShellshogunVerticalMovement+12   j
                tst.w   $17C(a5)
                beq.s   loc_39BD0
                cmpi.w  #$FFFD,$11E(a5)
                bne.s   loc_39BD0
                move.b  #$D0,d0
                jsr (Sound_PlaySFX).l
                subi.w  #$62,(word_FF8234).w ; 'b'
                move.w  #3,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                addq.w  #1,$11C(a5)
                move.l  #$FFFA4000,$18(a5)
                tst.w   $54(a5)
                bne.s   loc_39BD0
                neg.l   $18(a5)
loc_39BD0:                              ; CODE XREF: Boss_ShellshogunVerticalMovement+24   j
                                        ; Boss_ShellshogunVerticalMovement+2C   j ...
                tst.w   $54(a5)
                beq.s   loc_39BF0
                addi.l  #$4000,$18(a5)
                bmi.s   loc_39BFA
loc_39BE0:                              ; CODE XREF: Boss_ShellshogunVerticalMovement+88   j
                clr.l   $18(a5)
                tst.w   $11C(a5)
                beq.s   loc_39BFA
                clr.b   $A41(a5)
                bra.s   loc_39BFA
; ---------------------------------------------------------------------------
loc_39BF0:                              ; CODE XREF: Boss_ShellshogunVerticalMovement+64   j
                subi.l  #$4000,$18(a5)
                bmi.s   loc_39BE0
loc_39BFA:                              ; CODE XREF: Boss_ShellshogunVerticalMovement+6E   j
                                        ; Boss_ShellshogunVerticalMovement+78   j ...
                lea     word_3A33E(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bsr.w Boss_ShellshogunRenderSprites
                move.l  #word_EB888,$68(a5)
                bra.w Boss_ShellshogunUpdateSpriteFlip
; End of function Boss_ShellshogunVerticalMovement
; Initialize Shellshogun jump attack with position and animation setup
Boss_ShellshogunInitJumpAttack:                              ; CODE XREF: Boss_ShellshogunAttackPattern+28   j  ; was: sub_39C14
                move.w  #$1E,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$148,$8B4(a5)
                move.w  #$C,$11E(a5)
                move.b  #$C0,$A41(a5)
                move.b  #8,$A40(a5)
                move.w  #0,$29C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; End of function Boss_ShellshogunInitJumpAttack
; Update Shellshogun during jump attack with sound effects and defeat checks
Boss_ShellshogunJumpAttackUpdate:                              ; DATA XREF: ROM:00039540   o  ; was: sub_39C4C
                tst.w   $11E(a5)
                bmi.s   loc_39C9A
                bsr.w Boss_ShellshogunCheckDefeat
                subi.w  #$10,$29C(a5)
                andi.w  #$1E0,$29C(a5)
                bne.s   loc_39C6E
                move.b  #$D1,d0
                jsr (Sound_PlaySFX).l
loc_39C6E:                              ; CODE XREF: Boss_ShellshogunJumpAttackUpdate+16   j
                move.w  #$C860,$23E(a5)
                cmpi.w  #9,$58(a5)
                bmi.s   loc_39C82
                move.w  #$CC80,$23E(a5)
loc_39C82:                              ; CODE XREF: Boss_ShellshogunJumpAttackUpdate+2E   j
                lea     word_3A326(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bsr.w Boss_ShellshogunRenderSprites
                move.l  #word_EB888,$68(a5)
                rts
; ---------------------------------------------------------------------------
loc_39C9A:                              ; CODE XREF: Boss_ShellshogunJumpAttackUpdate+4   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$C860,$23E(a5)
; Shellshogun jump attack air phase with rotation
Boss_ShellshogunJumpAttack_AirPhase:                              ; DATA XREF: ROM:00039542   o  ; was: loc_39CAE
                subq.w  #1,(word_FF8234).w
                tst.w   $58(a5)
                bpl.s   loc_39CC6
                move.b  #$C,$A40(a5)
                clr.b   $A41(a5)
                bra.w Boss_ShellshogunResetToIdle
; ---------------------------------------------------------------------------
loc_39CC6:                              ; CODE XREF: Boss_ShellshogunJumpAttackUpdate+6A   j
                subi.w  #$10,$29C(a5)
                andi.w  #$1E0,$29C(a5)
                bne.s   loc_39CDE
                move.b  #$D1,d0
                jsr (Sound_PlaySFX).l
loc_39CDE:                              ; CODE XREF: Boss_ShellshogunJumpAttackUpdate+86   j
                lea     word_3A338(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bra.w Boss_ShellshogunRenderSprites
; End of function Boss_ShellshogunJumpAttackUpdate
; Initialize Shellshogun descending state with timer values
Boss_ShellshogunInitDescendState:                              ; CODE XREF: Boss_ShellshogunAttackPattern+52   j  ; was: sub_39CEC
                move.w  #$22,4(a5) ; '"'
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #2,$11E(a5)
; End of function Boss_ShellshogunInitDescendState
; Update Shellshogun descending animation and prepare for impact
Boss_ShellshogunDescendUpdate:                              ; DATA XREF: ROM:00039544   o  ; was: sub_39D02
                tst.w   $11E(a5)
                bmi.s   loc_39D20
                lea     word_3A358(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bsr.w Boss_ShellshogunUpdateWrapper
                move.l  #word_EB876,$68(a5)
                rts
; ---------------------------------------------------------------------------
loc_39D20:                              ; CODE XREF: Boss_ShellshogunDescendUpdate+4   j
                addq.w  #2,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFA4000,$1C(a5)
                move.w  #$18,$BE(a5)
                move.w  #3,$11C(a5)
                bsr.w Boss_ShellshogunCheckDefeat
; End of function Boss_ShellshogunDescendUpdate
; Handle Shellshogun landing with screen shake and vertical velocity
Boss_ShellshogunLandingSequence:                              ; DATA XREF: ROM:00039546   o  ; was: sub_39D44
                subq.w  #1,$11C(a5)
                bne.s   loc_39D78
                move.w  #3,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                subi.w  #$7D,(word_FF8234).w ; '}'
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                asl.l   #1,d0
                addi.l  #$13000,d0
                move.l  d0,$18(a5)
                tst.w   $54(a5)
                beq.s   loc_39D78
                neg.l   $18(a5)
loc_39D78:                              ; CODE XREF: Boss_ShellshogunLandingSequence+4   j
                                        ; Boss_ShellshogunLandingSequence+2E   j
                subq.w  #1,$BE(a5)
                bpl.s   loc_39D92
                cmpi.w  #$FFE0,$BE(a5)
                bmi.s   loc_39D92
                addi.w  #$10,$56(a5)
                andi.w  #$1F0,$56(a5)
loc_39D92:                              ; CODE XREF: Boss_ShellshogunLandingSequence+38   j
                                        ; Boss_ShellshogunLandingSequence+40   j
                addi.l  #$3000,$1C(a5)
                bmi.s   loc_39DA4
                cmpi.w  #$148,$8B4(a5)
                bpl.s   loc_39DB2
loc_39DA4:                              ; CODE XREF: Boss_ShellshogunLandingSequence+56   j
                lea     word_3A358(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bra.w Boss_ShellshogunUpdateWrapper
; ---------------------------------------------------------------------------
loc_39DB2:                              ; CODE XREF: Boss_ShellshogunLandingSequence+5E   j
                addq.w  #2,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$148,$8B4(a5)
                clr.l   $1C(a5)
                move.w  #5,(word_FFA010).w
                move.w  #5,(word_FFA014).w
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$A1,d0
                jsr (Sound_PlaySFX).l
; End of function Boss_ShellshogunLandingSequence
; Decelerate Shellshogun horizontal velocity to zero
Boss_ShellshogunDecelerateHorizontal:                              ; DATA XREF: ROM:00039548   o  ; was: sub_39DEA
                tst.w   $18(a5)
                bpl.s   loc_39E00
                addi.l  #$1000,$18(a5)
                bmi.s   loc_39E0A
loc_39DFA:                              ; CODE XREF: Boss_ShellshogunDecelerateHorizontal+1E   j
                clr.l   $18(a5)
                bra.s   loc_39E0A
; ---------------------------------------------------------------------------
loc_39E00:                              ; CODE XREF: Boss_ShellshogunDecelerateHorizontal+4   j
                subi.l  #$1000,$18(a5)
                bmi.s   loc_39DFA
loc_39E0A:                              ; CODE XREF: Boss_ShellshogunDecelerateHorizontal+E   j
                                        ; Boss_ShellshogunDecelerateHorizontal+14   j
                tst.w   $58(a5)
                bmi.w Boss_ShellshogunResetToIdle
                lea     word_3A372(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                bra.w Boss_ShellshogunUpdateWrapper
; End of function Boss_ShellshogunDecelerateHorizontal
; Sets boss parameters and sprite properties
Boss_ShellshogunSetParams:                              ; CODE XREF: Boss_ShellshogunSetupPhase+150   j  ; was: sub_39E20
                                        ; sub_396D2   p ...
                lea     word_3A314(pc),a1
                nop
                bsr.w Boss_ShellshogunAnimUpdate
                move.w  #$148,$494(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CAA0,$4A(a5)
                cmpi.w  #9,$58(a5)
                bpl.s   loc_39E56
                move.w  #$148,$8B4(a5)
                move.w  #$CEC0,$48(a5)
                move.w  #$CEC0,$4A(a5)
loc_39E56:                              ; CODE XREF: Boss_ShellshogunSetParams+22   j
                bra.w   *+4
; End of function Boss_ShellshogunSetParams
; Wrapper calling boss update routine
Boss_ShellshogunUpdateWrapper:                              ; CODE XREF: Boss_ShellshogunChargeAttack+B4   j  ; was: sub_39E5A
                                        ; Boss_ShellshogunAttackPattern+7E   p ...
                bsr.w Boss_ShellshogunPhysicsUpdate
; End of function Boss_ShellshogunUpdateWrapper
; Renders boss metasprites and updates display
Boss_ShellshogunRenderSprites:                              ; CODE XREF: Boss_ShellshogunUpdateAnimation+A   p  ; was: sub_39E5E
                                        ; Boss_ShellshogunTransitionState+2A   p ...
                moveq   #$16,d7
                jsr (Sprite_InitMetaspriteSimple).l
                bsr.w Boss_ShellshogunBoundsCheck
                bsr.w Boss_ShellshogunSetTileData
                bsr.w Boss_ShellshogunUpdateSprite
                bra.w Boss_ShellshogunUpdatePosition
; End of function Boss_ShellshogunRenderSprites
; Checks boss defeat condition and triggers end
Boss_ShellshogunCheckDefeat:                              ; CODE XREF: Boss_ShellshogunAttackPattern+A   p  ; was: sub_39E76
                                        ; Boss_ShellshogunJumpAttackUpdate+6   p ...
                jsr (Physics_CalculateDistanceTo).l
                clr.w   $54(a5)
                tst.w   d1
                bpl.s   loc_39E8A
                move.w  #$100,$54(a5)
loc_39E8A:                              ; CODE XREF: Boss_ShellshogunCheckDefeat+C   j
                tst.w   $54(a5)
                beq.s Boss_ShellshogunDeathSequence
; End of function Boss_ShellshogunCheckDefeat
; Initializes boss sprite objects
Boss_ShellshogunInitSprites:                              ; CODE XREF: Boss_ShellshogunSetupPhase+140   p  ; was: sub_39E90
                moveq   #3,d7
                bset    d7,$6E(a5)
                bset    d7,$CE(a5)
                bclr    d7,$4EE(a5)
                bset    d7,$36E(a5)
                bclr    d7,$78E(a5)
                rts
; End of function Boss_ShellshogunInitSprites
; Boss death sequence with explosion effects
Boss_ShellshogunDeathSequence:                              ; CODE XREF: Boss_ShellshogunCheckDefeat+18   j  ; was: sub_39EA8
                moveq   #3,d7
                bclr    d7,$6E(a5)
                bclr    d7,$CE(a5)
                bset    d7,$4EE(a5)
                bclr    d7,$36E(a5)
                bset    d7,$78E(a5)
                rts
; End of function Boss_ShellshogunDeathSequence
; Initializes boss palette colors
Boss_ShellshogunInitPalette:                              ; CODE XREF: Boss_ShellshogunSetupPhase+66   p  ; was: sub_39EC0
                moveq   #7,d0
                bset    d0,$12E(a5)
                bset    d0,$18E(a5)
                bset    d0,$1EE(a5)
                bset    d0,$24E(a5)
                bset    d0,$54E(a5)
                bset    d0,$5AE(a5)
                bset    d0,$60E(a5)
                bset    d0,$66E(a5)
                rts
; End of function Boss_ShellshogunInitPalette
; Update Shellshogun sprite flipping based on rotation angle
Boss_ShellshogunUpdateSpriteFlip:                              ; CODE XREF: Boss_ShellshogunVerticalMovement+A0   j  ; was: sub_39EE4
                lea     (off_34B80).l,a0
                move.w  $29C(a5),d0
                subi.w  #$110,d0
                move.w  d0,d1
                asr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a0,d0.w),$248(a5)
                andi.w  #$E7FF,$E(a5)
                add.w   $54(a5),d1
                add.w   $56(a5),d1
                andi.w  #$1FE,d1
                cmpi.w  #$100,d1
                bmi.s   locret_39F1E
                ori.w   #$1800,$E(a5)
locret_39F1E:                           ; CODE XREF: Boss_ShellshogunUpdateSpriteFlip+32   j
                rts
; End of function Boss_ShellshogunUpdateSpriteFlip
; Updates boss sprite graphics and palette
Boss_ShellshogunUpdateSprite:                              ; CODE XREF: Boss_ShellshogunRenderSprites+10   p  ; was: sub_39F20
                move.l  #word_EB876,$68(a5)
                btst    #3,(word_FFA000+1).w
                bne.s   locret_39F38
                move.l  #word_EB888,$68(a5)
locret_39F38:                           ; CODE XREF: Boss_ShellshogunUpdateSprite+E   j
                rts
; End of function Boss_ShellshogunUpdateSprite
; Boss screen bounds validation before rendering
Boss_ShellshogunBoundsCheck:                              ; CODE XREF: Boss_ShellshogunRenderSprites+8   p  ; was: sub_39F3A
                move.w  #$BC,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$50,d0 ; 'P'
                move.w  d0,(dword_FFA90C).w
                jmp Boss_CheckScreenBounds
; End of function Boss_ShellshogunBoundsCheck
; Updates boss position from velocity
Boss_ShellshogunUpdatePosition:                              ; CODE XREF: Boss_ShellshogunRenderSprites+14   j  ; was: sub_39F58
                move.w  $1DE(a5),d0
                move.w  $23C(a5),d1
                tst.w   $1DC(a5)
                bne.s   loc_39F7A
                addq.w  #4,d0
                addq.w  #1,d1
                andi.w  #$1FC,d0
                cmpi.w  #$50,d0 ; 'P'
                bne.s   loc_39F8C
                addq.w  #1,$1DC(a5)
                bra.s   loc_39F8C
; ---------------------------------------------------------------------------
loc_39F7A:                              ; CODE XREF: Boss_ShellshogunUpdatePosition+C   j
                subq.w  #4,d0
                subq.w  #1,d1
                andi.w  #$1FC,d0
                cmpi.w  #$1B0,d0
                bne.s   loc_39F8C
                clr.w   $1DC(a5)
loc_39F8C:                              ; CODE XREF: Boss_ShellshogunUpdatePosition+1A   j
                                        ; Boss_ShellshogunUpdatePosition+20   j ...
                move.w  d0,$1DE(a5)
                move.w  d1,$23C(a5)
                movea.w #(byte_FFCF20-M68K_RAM),a0
                movea.l #word_1B514,a1
                movea.l #word_39FEA,a2
                move.w  $56(a5),d0
                addi.w  #$80,d0
                add.w   $23C(a5),d0
                move.w  $1DE(a5),d2
                move.w  #$1FE,d1
                moveq   #2,d7
loc_39FBA:                              ; CODE XREF: Boss_ShellshogunUpdatePosition+8C   j
                and.w   d1,d0
                movea.w (a2)+,a3
                move.w  -$80(a1,d0.w),d4
                move.w  (a1,d0.w),d5
                muls.w  (a2),d4
                muls.w  (a2)+,d5
                asl.l   #2,d4
                asl.l   #2,d5
                add.l   $14(a3),d4
                add.l   $10(a3),d5
                move.l  d4,$14(a0)
                move.l  d5,$10(a0)
                add.w   d2,d0
                lea     $60(a0),a0
                dbf     d7,loc_39FBA
                rts
; End of function Boss_ShellshogunUpdatePosition
; ---------------------------------------------------------------------------
word_39FEA:     dc.w $C620, $20, $CF20, 8, $CF80, 6
                                        ; DATA XREF: Boss_ShellshogunUpdatePosition+46   o


; Updates boss physics and collision
Boss_ShellshogunPhysicsUpdate:                              ; CODE XREF: Boss_ShellshogunSlamAttackInit:loc_39A8A   p  ; was: sub_39FF6
                                        ; sub_39E5A   p
                move.w  #$C860,$23E(a5)
                move.w  $296(a5),d0
                subi.w  #$80,d0
                move.w  d0,$29C(a5)
                andi.w  #$1FE,$29C(a5)
                rts
; End of function Boss_ShellshogunPhysicsUpdate
; Sets boss tile data and graphics
Boss_ShellshogunSetTileData:                              ; CODE XREF: Boss_ShellshogunRenderSprites+C   p  ; was: sub_3A010
                move.w  $29C(a5),d0
                add.w   $56(a5),d0
                addi.w  #$20,d0 ; ' '
                andi.w  #$1FE,d0
                bclr    #4,$A2E(a5)
                cmpi.w  #$100,d0
                bpl.s   loc_3A032
                bset    #4,$A2E(a5)
loc_3A032:                              ; CODE XREF: Boss_ShellshogunSetTileData+1A   j
                bset    #3,$A2E(a5)
                cmpi.w  #$180,d0
                bpl.s   loc_3A04A
                cmpi.w  #$80,d0
                bmi.s   loc_3A04A
                bclr    #3,$A2E(a5)
loc_3A04A:                              ; CODE XREF: Boss_ShellshogunSetTileData+2C   j
                                        ; Boss_ShellshogunSetTileData+32   j
                tst.w   $54(a5)
                beq.s   loc_3A056
                eori.w  #$800,$A2E(a5)
loc_3A056:                              ; CODE XREF: Boss_ShellshogunSetTileData+3E   j
                asr.w   #4,d0
                andi.w  #$C,d0
                move.l  off_3A0DA(pc,d0.w),$A28(a5)
                movea.w $23E(a5),a0
                move.w  $10(a0),$A30(a5)
                move.w  $14(a0),$A34(a5)
                tst.b   $A41(a5)
                bne.s   loc_3A082
                clr.b   $AA1(a5)
                clr.b   $B01(a5)
                rts
; ---------------------------------------------------------------------------
loc_3A082:                              ; CODE XREF: Boss_ShellshogunSetTileData+66   j
                move.b  #$C0,$AA1(a5)
                move.b  #$C0,$B01(a5)
                lea     (word_1B514).l,a1
                move.w  $29C(a5),d0
                addi.w  #$80,d0
                tst.w   $54(a5)
                bne.s   loc_3A0A4
                neg.w   d0
loc_3A0A4:                              ; CODE XREF: Boss_ShellshogunSetTileData+90   j
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #7,d1
                asl.l   #7,d2
                move.l  $10(a0),d3
                move.l  $14(a0),d4
                sub.l   d1,d3
                sub.l   d2,d4
                move.l  d3,$A90(a5)
                move.l  d4,$A94(a5)
                sub.l   d1,d3
                sub.l   d2,d4
                move.l  d3,$AF0(a5)
                move.l  d4,$AF4(a5)
                rts
; End of function Boss_ShellshogunSetTileData
; ---------------------------------------------------------------------------
off_3A0DA:      dc.l word_EB9BA         ; DATA XREF: Boss_ShellshogunSetTileData+4C   r
                dc.l word_EB9A2
                dc.l word_EB98A
                dc.l word_EB9A2


; Cycle palette fade values for Madam Barbar boss
Boss_MadamBarbarPaletteCycle:
                move.w  8(a5),d0  ; was: sub_3A0EA
                tst.w   $A(a5)
                beq.s   loc_3A102
                addq.w  #1,d0
                cmpi.w  #$E,d0
                bne.s   loc_3A10E
                clr.w   $A(a5)
                bra.s   loc_3A10E
; ---------------------------------------------------------------------------
loc_3A102:                              ; CODE XREF: Boss_MadamBarbarPaletteCycle+8   j
                subq.w  #1,d0
                cmpi.w  #$FFF2,d0
                bne.s   loc_3A10E
                addq.w  #1,$A(a5)
loc_3A10E:                              ; CODE XREF: Boss_MadamBarbarPaletteCycle+10   j
                                        ; Boss_MadamBarbarPaletteCycle+16   j ...
                move.w  d0,8(a5)
                movea.w #(word_FFE318-M68K_RAM),a0
                moveq   #3,d5
                move.w  #$E000,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Boss_MadamBarbarPaletteCycle
; Flash boss sprite when taking damage
Boss_ShellshogunFlashOnHit:                              ; CODE XREF: Boss_ShellshogunChargeAttack:loc_3986A   p  ; was: sub_3A122
                jsr (Projectile_SpawnAtPosition).l
                bne.s   locret_3A170
                jsr (Projectile_FindFreeSlotComplex).l
                clr.b   $20(a0)
                move.l  $18(a5),$18(a0)
                move.l  $1C(a5),$1C(a0)
                neg.l   $18(a0)
                neg.l   $1C(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0 ; '?'
                andi.w  #$3F,d1 ; '?'
                subi.w  #$20,d0 ; ' '
                subi.w  #$20,d1 ; ' '
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_3A170:                           ; CODE XREF: Boss_ShellshogunFlashOnHit+6   j
                rts
; End of function Boss_ShellshogunFlashOnHit
; Updates boss animation frame and interpolation
Boss_ShellshogunAnimUpdate:                              ; CODE XREF: Boss_ShellshogunChargeAttack+B0   p  ; was: sub_3A172
                                        ; Boss_ShellshogunAttackPattern+7A   p ...
                clr.w   $17C(a5)
                tst.w   $C(a5)
                bpl.s   loc_3A1D4
loc_3A17C:                              ; CODE XREF: Boss_ShellshogunAnimUpdate+2A   j
                move.w  $58(a5),d0
                bmi.s   loc_3A1E4
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_3A192
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_3A192:                              ; CODE XREF: Boss_ShellshogunAnimUpdate+18   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_3A19E
                clr.w   $58(a5)
                bra.s   loc_3A17C
; ---------------------------------------------------------------------------
loc_3A19E:                              ; CODE XREF: Boss_ShellshogunAnimUpdate+24   j
                addq.w  #4,$58(a5)
                subq.w  #1,$11E(a5)
                addq.w  #1,$17C(a5)
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3A38A,d0
                movea.l d0,a0
                bsr.w Boss_ShellshogunCollisionCheck
                move.b  (dword_FF8040).w,d1
                ext.w   d1
                add.w   d1,$C(a5)
                tst.w   $C(a5)
                bmi.s   loc_3A1E4
loc_3A1D4:                              ; CODE XREF: Boss_ShellshogunAnimUpdate+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$E,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_3A1E4:                              ; CODE XREF: Boss_ShellshogunAnimUpdate+E   j
                                        ; Boss_ShellshogunAnimUpdate+60   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$176(a5)
                move.w  d0,$1D6(a5)
                move.b  $C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$236(a5)
                move.w  d1,$296(a5)
                move.b  $10(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.b  $14(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                move.w  d0,$3B6(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$416(a5)
                move.w  d1,$476(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.b  $20(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$536(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.b  $30(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.w  d0,$7D6(a5)
                move.b  $34(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$836(a5)
                move.w  d1,$896(a5)
                move.b  $38(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$8F6(a5)
                rts
; End of function Boss_ShellshogunAnimUpdate
; Checks collision with player projectiles
Boss_ShellshogunCollisionCheck:                              ; CODE XREF: Boss_ShellshogunAnimUpdate+4E   p  ; was: sub_3A2CC
                movea.l #word_34C54,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                subq.w  #1,$C(a5)
                moveq   #$E,d7
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_ShellshogunCollisionCheck
; ---------------------------------------------------------------------------
word_3A2E6:     dc.w $10, $F, $18, 0, $FFFF
                                        ; DATA XREF: ROM:off_5DC   o
                                        ; sub_398FE:loc_39972   o
word_3A2F0:     dc.w $F030, $1E, $70, $1E, $FFFE
                                        ; DATA XREF: Boss_ShellshogunAttackPattern+CC   o
word_3A2FA:     dc.w $EF11, $5A, $E830, $87, $E, $87, $9080, $96, $12, $96, $9080, $87, $FFFE
                                        ; DATA XREF: Boss_ShellshogunUpdateAnimation   o
word_3A314:     dc.w $17, $2D, $10, $3C, $1B, $4B, $21, $5A, $FFFF
                                        ; DATA XREF: Boss_ShellshogunSetParams   o
word_3A326:     dc.w $FE14, $69, 6, $69, $FE12, $78, 6, $78, $FFFF
                                        ; DATA XREF: Boss_ShellshogunJumpAttackUpdate:loc_39C82   o
word_3A338:     dc.w $FE28, $F, $FFFE   ; DATA XREF: Boss_ShellshogunJumpAttackUpdate:loc_39CDE   o
word_3A33E:     dc.w $FC18, $A6, $FD18, $A6, $13, $A6, $FF0E, $B5, $A, $B5, $D840, $A6, $FFFE
                                        ; DATA XREF: Boss_ShellshogunTransitionState:loc_39B58   o
                                        ; sub_39B70:loc_39BFA   o
word_3A358:     dc.w $FC18, $E2, $FD18, $E2, $FE0E, $D3, $FF0E, $C4, $18, $C4, $16, $E2, $FFFE
                                        ; DATA XREF: Boss_ShellshogunDescendUpdate+6   o
                                        ; sub_39D44:loc_39DA4   o
word_3A372:     dc.w $FC0C, $E2, $18, $E2, $FC0C, $F, $FFFE
                                        ; DATA XREF: Boss_ShellshogunDecelerateHorizontal+28   o
word_3A380:     dc.w $C, $C4, $C, $E2, $FFFF
                                        ; DATA XREF: Boss_ShellshogunChargeAttack+AA   o
word_3A38A:     dc.w $CCE8, $20E8, $2013, $FE2, $A870, $3060, $78B8, $4CC0, $E010, $F020, $1400, $F0A0, $7844, $6080, $BC40, $C0D0
                                        ; DATA XREF: Boss_ShellshogunAnimUpdate+46   o
                dc.w $F0E0, $2020, $20C0, $B090, $2060, $60E0, $40CC, $E810, $F020, $F870, $F0A8, $7030, $5060, $F030, $D0E0, $20F8
                dc.w $2010, $28C0, $B090, $5860, $70E8, $30CE, $E418, $FC20, $2840, $A0B8, $8018, $5090, $9010, $BCD4, $D0, $3030
                dc.w $4090, $9C50, $1050, $50C0, $70C4, $D8C0, $C020, $848, $B4B8, $C040, $6078, $B84C, $BCE8, $5020, $3000, $44C0
                dc.w $9828, $E050, $80BC, $40B0, $C0D0, $C000, $E070, $F090, $8020, $5050, $A090, $D800, $4000, $3010, $20C0, $B8A0
                dc.w $6060, $6808, $1040, $B4D2, $5040, $2014, $F0, $9848, $A460, $78A8, $5CD8, $F000, $20, $1050, $A0B8, $A0D0
                dc.w $6068, $810, $C0E0, $4040, $2020, $60C0, $A040, $C060, $60A0, $40C0, $D0D0, $F030, $3010, $C0B0, $B010, $5050
                dc.w $F040, $C0E0, $20C0, $1000, $609C, $A060, $4070, $80A0, $64FF


; Main Madam Barbar boss handler checking defeat and state dispatch
Boss_MadamBarbarMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3A47C
                tst.w   4(a5)
                beq.w   loc_3A4D4
                tst.w   8(a5)
                beq.s   loc_3A4D4
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3A4C2
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3A4C2
                tst.w   (word_FF8200).w
                bne.s   loc_3A4C2
                move.b  #1,(byte_FF830E).w
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr (Sprite_ClearObjectFlags).l
                move.w  #4,(word_FF808C).w
                bra.w   loc_3A682
; ---------------------------------------------------------------------------
loc_3A4C2:                              ; CODE XREF: Boss_MadamBarbarMain+14   j
                                        ; Boss_MadamBarbarMain+1C   j ...
                jsr (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
loc_3A4D4:                              ; CODE XREF: Boss_MadamBarbarMain+4   j
                                        ; Boss_MadamBarbarMain+C   j
                move.w  4(a5),d0
                movea.w off_3A4E4(pc,d0.w),a0
                adda.l  #Boss_MadamBarbarInit,a0
                jmp     (a0)
; End of function Boss_MadamBarbarMain
; ---------------------------------------------------------------------------
off_3A4E4:      dc.w Boss_MadamBarbarInit-Boss_MadamBarbarInit
                                        ; DATA XREF: Boss_MadamBarbarMain+5C   r
                dc.w Boss_MadamBarbarSetup-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarIntro-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarIntro_Sequence-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarAttackPhase-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarAttack_MainPhase-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarDefeatSequence-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarAIState-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarAI_RightSideAttack-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarAI_LeftSideAttack-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarAI_CenterSpinAttack-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarAI_DropProjectileAttack-Boss_MadamBarbarInit
                dc.w Boss_MadamBarbarIdleUpdate-Boss_MadamBarbarInit


; Initializes Madam Barbar boss clearing sprites and setting flags
Boss_MadamBarbarInit:                              ; DATA XREF: Boss_MadamBarbarMain+60   o  ; was: sub_3A4FE
                                        ; ROM:off_3A4E4   o ...
                addq.w  #2,4(a5)
                clr.w   8(a5)
                move.w  #$118,d0
                move.w  #$12C,d1
                jsr (Sprite_ClearAllExcept).l
                move.b  #1,(byte_FF830E).w
locret_3A51A:                           ; CODE XREF: Boss_MadamBarbarSetup+4   j
                rts
; End of function Boss_MadamBarbarInit
; Sets up Madam Barbar boss metasprites tiles and animation
Boss_MadamBarbarSetup:                              ; DATA XREF: ROM:0003A4E6   o  ; was: sub_3A51C
                tst.w   (word_FFF720).w
                bmi.s   locret_3A51A
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$1C,d7
                movea.l #dword_34E48,a0
                movea.l #word_34EBC,a1
                movea.l #word_34EDA,a2
                jsr (Sprite_InitMetaspriteComplex).l
                bset    #0,$962(a5)
                bset    #0,$9C2(a5)
                bset    #0,$A22(a5)
                bset    #0,$A82(a5)
                moveq   #7,d0
                bset    d0,$18E(a5)
                bset    d0,$1EE(a5)
                bset    d0,$24E(a5)
                bset    d0,$3CE(a5)
                bset    d0,$42E(a5)
                bset    d0,$48E(a5)
                addq.w  #2,4(a5)
                move.w  #$118,(a5)
                move.w  #$CD00,2(a5)
                movea.w #(word_FF9800-M68K_RAM),a0
                move.l  a0,8(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$20,$20(a5) ; ' '
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  #$3A9,(a0)
                move.w  #$100,2(a0)
                move.w  #$8BA9,6(a0)
                move.w  #$100,8(a0)
                move.w  #1,$17E(a5)
                move.w  #$248,$9D0(a5)
                movea.l #word_1BAF4,a1
                jsr (Sprite_InitFromPointerTable).l
                movea.l #word_3A5F2,a0
                jsr (Gfx_LoadCompressedTiles).l
                bsr.w Boss_MadamBarbarSetCollision
                bsr.w Boss_MadamBarbarWobble
                lea     word_3B20E(pc),a0
                nop
                bsr.w Boss_MadamBarbarLoadFrameDelays
                bra.s Boss_MadamBarbarIntro
; End of function Boss_MadamBarbarSetup
; ---------------------------------------------------------------------------
word_3A5F2:     dc.w $6100, $2000, $302, $2021, $2223, $2425, $2627, $28, $2900
                                        ; DATA XREF: Boss_MadamBarbarSetup+B6   o


; Boss introduction sequence checking position for battle start
Boss_MadamBarbarIntro:                              ; CODE XREF: Boss_MadamBarbarSetup+D4   j  ; was: sub_3A604
                                        ; DATA XREF: ROM:0003A4E8   o
                tst.w   $17E(a5)
                bpl.w   loc_3A830
                move.w  #3,$17E(a5)
                cmpi.w  #$5C0,$BC(a5)
                bpl.w   loc_3A830
                addq.w  #2,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #7,$17E(a5)
; Madam Barbar intro sequence with victory check
Boss_MadamBarbarIntro_Sequence:                              ; DATA XREF: ROM:0003A4EA   o  ; was: loc_3A640
                tst.w   $17E(a5)
                bpl.s   loc_3A65C
                addq.w  #2,4(a5)
                moveq   #6,d0
                jsr (UI_CheckVictoryCondition).l
                move.b  #$8A,d0
                jsr (Input_CheckButtonMode).l
loc_3A65C:                              ; CODE XREF: Boss_MadamBarbarIntro+40   j
                                        ; Boss_MadamBarbarAttackPhase+8   j
                lea     dword_3B1B2(pc),a1
                nop
                bsr.w Boss_MadamBarbarUpdateAnimation
                bra.w Boss_MadamBarbarUpdateParts
; End of function Boss_MadamBarbarIntro
; Boss attack phase with timer countdown and collision enabling
Boss_MadamBarbarAttackPhase:                              ; DATA XREF: ROM:0003A4EC   o  ; was: sub_3A66A
                bsr.w Boss_MadamBarbarSpawnProjectile
                tst.w   (word_FF80C2).w
                bne.s   loc_3A65C
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
                bra.w   loc_3A780
; ---------------------------------------------------------------------------
loc_3A682:                              ; CODE XREF: Boss_MadamBarbarMain+42   j
                move.w  #$A,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$11F,$11C(a5)
                move.w  #$48,(word_FF809E).w ; 'H'
; Madam Barbar main attack with bullet spawning
Boss_MadamBarbarAttack_MainPhase:                              ; DATA XREF: ROM:0003A4EE   o  ; was: loc_3A6AE
                subq.w  #1,$11C(a5)
                bpl.s   loc_3A6BE
                addq.w  #2,4(a5)
                move.w  #$30,$11C(a5) ; '0'
loc_3A6BE:                              ; CODE XREF: Boss_MadamBarbarAttackPhase+48   j
                bsr.w Boss_MadamBarbarSpawnBullet
                lea     dword_3B1C6(pc),a1
                nop
                bsr.w Boss_MadamBarbarUpdateAnimation
                bsr.w Boss_MadamBarbarUpdateParts
                cmpi.w  #$38,$11C(a5) ; '8'
                bpl.s   locret_3A6F4
                btst    #0,(word_FFA000+1).w
                bne.w   loc_3A70C
                moveq   #7,d0
                moveq   #$1C,d7
                movea.w a5,a0
loc_3A6E8:                              ; CODE XREF: Boss_MadamBarbarAttackPhase+86   j
                bset    d0,2(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3A6E8
locret_3A6F4:                           ; CODE XREF: Boss_MadamBarbarAttackPhase+6C   j
                rts
; End of function Boss_MadamBarbarAttackPhase
; Boss defeat sequence clearing sprites and disabling collision
Boss_MadamBarbarDefeatSequence:                              ; DATA XREF: ROM:0003A4F0   o  ; was: sub_3A6F6
                subq.w  #1,$11C(a5)
                bpl.s   loc_3A708
                moveq   #0,d0
                move.w  #$12C,d1
                jmp Sprite_ClearAllExcept
; ---------------------------------------------------------------------------
loc_3A708:                              ; CODE XREF: Boss_MadamBarbarDefeatSequence+4   j
                bsr.w Boss_MadamBarbarUpdateParts
loc_3A70C:                              ; CODE XREF: Boss_MadamBarbarAttackPhase+74   j
                move.w  #$FEB0,(dword_FFA908).w
                moveq   #7,d0
                moveq   #$1C,d7
                movea.w a5,a0
loc_3A718:                              ; CODE XREF: Boss_MadamBarbarDefeatSequence+2A   j
                bclr    d0,2(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3A718
                rts
; End of function Boss_MadamBarbarDefeatSequence
; Initialize Madam Barbar idle state with position and timers
Boss_MadamBarbarInitIdleState:                              ; CODE XREF: Boss_MadamBarbarAIState+7A   j  ; was: sub_3A726
                                        ; Boss_MadamBarbarAIState+F6   j ...
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$18,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                clr.w   $17E(a5)
; End of function Boss_MadamBarbarInitIdleState
; Update Madam Barbar idle state with projectile spawning
Boss_MadamBarbarIdleUpdate:                              ; DATA XREF: ROM:0003A4FC   o  ; was: sub_3A74A
                tst.w   $17E(a5)
                bpl.s   loc_3A75E
                clr.w   $17E(a5)
                cmpi.w  #$1E0,(word_FF8234).w
                bpl.w   loc_3A776
loc_3A75E:                              ; CODE XREF: Boss_MadamBarbarIdleUpdate+4   j
                addi.w  #2,(word_FF8234).w
                bsr.w Boss_MadamBarbarSpawnProjectile
                lea     dword_3B1B2(pc),a1
                nop
                bsr.w Boss_MadamBarbarUpdateAnimation
                bra.w Boss_MadamBarbarUpdateParts
; ---------------------------------------------------------------------------
loc_3A776:                              ; CODE XREF: Boss_MadamBarbarIdleUpdate+10   j
                                        ; Boss_MadamBarbarAIState+8A   j ...
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_3A780:                              ; CODE XREF: Boss_MadamBarbarAttackPhase+14   j
                move.w  #$E,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                move.w  #1,$17E(a5)
; End of function Boss_MadamBarbarIdleUpdate
; Boss AI state machine tracking player position and attack patterns
Boss_MadamBarbarAIState:                              ; DATA XREF: ROM:0003A4F2   o  ; was: sub_3A79C
                tst.w   $17E(a5)
                bpl.s   loc_3A7DE
                move.w  (dword_FFFF08).w,d7
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                move.w  d0,d1
                bpl.s   loc_3A7B4
                neg.w   d1
loc_3A7B4:                              ; CODE XREF: Boss_MadamBarbarAIState+14   j
                cmpi.w  #$70,d1 ; 'p'
                bpl.s   loc_3A7C6
                andi.w  #$3000,d7
                bne.w   loc_3A8E4
                bra.w   loc_3A9A0
; ---------------------------------------------------------------------------
loc_3A7C6:                              ; CODE XREF: Boss_MadamBarbarAIState+1C   j
                cmpi.w  #$100,d1
                bpl.s   loc_3A7D4
                andi.w  #$7000,d7
                beq.w   loc_3A9A0
loc_3A7D4:                              ; CODE XREF: Boss_MadamBarbarAIState+2E   j
                tst.w   d0
                bpl.w   loc_3A868
                bra.w   loc_3A7EC
; ---------------------------------------------------------------------------
loc_3A7DE:                              ; CODE XREF: Boss_MadamBarbarAIState+4   j
                lea     dword_3B1B2(pc),a1
                nop
                bsr.w Boss_MadamBarbarUpdateAnimation
                bra.w Boss_MadamBarbarUpdateParts
; ---------------------------------------------------------------------------
loc_3A7EC:                              ; CODE XREF: Boss_MadamBarbarAIState+3E   j
                move.w  #$10,4(a5)
                clr.w   $58(a5)
                clr.w   6(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #1,$17E(a5)
; Madam Barbar right side attack with debris
Boss_MadamBarbarAI_RightSideAttack:                              ; DATA XREF: ROM:0003A4F4   o  ; was: loc_3A806
                bsr.w Boss_MadamBarbarSpawnDebris
                tst.w   $17E(a5)
                bpl.s   loc_3A830
                subi.w  #0,(word_FF8234).w
                bmi.w Boss_MadamBarbarInitIdleState
                move.w  (dword_FFA410).w,d0
                addi.w  #$60,d0 ; '`'
                cmp.w   $10(a5),d0
                bpl.w   loc_3A776
                move.w  #3,$17E(a5)
loc_3A830:                              ; CODE XREF: Boss_MadamBarbarIntro+4   j
                                        ; Boss_MadamBarbarIntro+14   j ...
                lea     dword_3B1EA(pc),a1
                nop
                bsr.w Boss_MadamBarbarUpdateAnimation
                bsr.w Boss_MadamBarbarPlayRotationSound
                movea.w #(word_FFCF80-M68K_RAM),a0
                cmpi.w  #8,$58(a5)
                beq.s   loc_3A856
                cmpi.w  #$C,$58(a5)
                beq.s   loc_3A856
                movea.w #(byte_FFCFE0-M68K_RAM),a0
loc_3A856:                              ; CODE XREF: Boss_MadamBarbarAIState+AC   j
                                        ; Boss_MadamBarbarAIState+B4   j
                move.w  #$C8,$14(a0)
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                bra.w Boss_MadamBarbarUpdateParts
; ---------------------------------------------------------------------------
loc_3A868:                              ; CODE XREF: Boss_MadamBarbarAIState+3A   j
                move.w  #$12,4(a5)
                clr.w   $58(a5)
                clr.w   6(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #1,$17E(a5)
; Madam Barbar left side attack with rotation
Boss_MadamBarbarAI_LeftSideAttack:                              ; DATA XREF: ROM:0003A4F6   o  ; was: loc_3A882
                bsr.w Boss_MadamBarbarSpawnDebris
                tst.w   $17E(a5)
                bpl.s   loc_3A8AC
                subi.w  #0,(word_FF8234).w
                bmi.w Boss_MadamBarbarInitIdleState
                move.w  (dword_FFA410).w,d0
                subi.w  #$60,d0 ; '`'
                cmp.w   $10(a5),d0
                bmi.w   loc_3A776
                move.w  #3,$17E(a5)
loc_3A8AC:                              ; CODE XREF: Boss_MadamBarbarAIState+EE   j
                lea     dword_3B1FC(pc),a1
                nop
                bsr.w Boss_MadamBarbarUpdateAnimation
                bsr.w Boss_MadamBarbarPlayRotationSound
                movea.w #(byte_FFD040-M68K_RAM),a0
                cmpi.w  #4,$58(a5)
                beq.s   loc_3A8D2
                cmpi.w  #$10,$58(a5)
                beq.s   loc_3A8D2
                movea.w #(byte_FFD0A0-M68K_RAM),a0
loc_3A8D2:                              ; CODE XREF: Boss_MadamBarbarAIState+128   j
                                        ; Boss_MadamBarbarAIState+130   j
                move.w  #$C8,$14(a0)
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                bra.w Boss_MadamBarbarUpdateParts
; ---------------------------------------------------------------------------
loc_3A8E4:                              ; CODE XREF: Boss_MadamBarbarAIState+22   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$14,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                clr.w   $11E(a5)
; Madam Barbar center spin attack
Boss_MadamBarbarAI_CenterSpinAttack:                              ; DATA XREF: ROM:0003A4F8   o  ; was: loc_3A908
                bsr.w Boss_MadamBarbarSpawnDebris
                move.w  $58(a5),d0
                bpl.s   loc_3A91E
                tst.w   (word_FF8234).w
                bmi.w Boss_MadamBarbarInitIdleState
                bra.w   loc_3A776
; ---------------------------------------------------------------------------
loc_3A91E:                              ; CODE XREF: Boss_MadamBarbarAIState+174   j
                tst.w   $11E(a5)
                bne.s   loc_3A942
                cmpi.w  #$C,d0
                bne.s   loc_3A942
                subi.w  #$52,(word_FF8234).w ; 'R'
                addq.w  #1,$11E(a5)
                move.b  #$B2,d0
                jsr (Sound_PlaySFX).l
                move.w  $58(a5),d0
loc_3A942:                              ; CODE XREF: Boss_MadamBarbarAIState+186   j
                                        ; Boss_MadamBarbarAIState+18C   j
                move.w  #$86,d1
                cmpi.w  #$C,d0
                bmi.s   loc_3A956
                cmpi.w  #$14,d0
                bpl.s   loc_3A956
                move.w  #$FF,d1
loc_3A956:                              ; CODE XREF: Boss_MadamBarbarAIState+1AE   j
                                        ; Boss_MadamBarbarAIState+1B4   j
                move.w  d1,$1A6(a5)
                move.w  d1,$3E6(a5)
                move.w  $1DC(a5),d1
                move.w  $1DE(a5),d2
                cmpi.w  #$C,d0
                bmi.s   loc_3A978
                cmpi.w  #$10,d1
                bmi.s   loc_3A982
                subq.w  #4,d1
                subq.w  #4,d2
                bra.s   loc_3A982
; ---------------------------------------------------------------------------
loc_3A978:                              ; CODE XREF: Boss_MadamBarbarAIState+1CE   j
                cmpi.w  #$60,d1 ; '`'
                bpl.s   loc_3A982
                addq.w  #4,d1
                addq.w  #4,d2
loc_3A982:                              ; CODE XREF: Boss_MadamBarbarAIState+1D4   j
                                        ; Boss_MadamBarbarAIState+1DA   j ...
                andi.w  #$1FE,d1
                andi.w  #$1FE,d2
                move.w  d1,$1DC(a5)
                move.w  d2,$1DE(a5)
                lea     dword_3B1D0(pc),a1
                nop
                bsr.w Boss_MadamBarbarUpdateAnimation
                bra.w   loc_3A9F6
; ---------------------------------------------------------------------------
loc_3A9A0:                              ; CODE XREF: Boss_MadamBarbarAIState+26   j
                                        ; Boss_MadamBarbarAIState+34   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$16,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1E,d0
                addq.w  #7,d0
                move.w  d0,$17E(a5)
; Madam Barbar dropping projectile attack
Boss_MadamBarbarAI_DropProjectileAttack:                              ; DATA XREF: ROM:0003A4FA   o  ; was: loc_3A9CE
                subi.w  #1,(word_FF8234).w
                bmi.w Boss_MadamBarbarInitIdleState
                tst.w   $17E(a5)
                bmi.w   loc_3A776
                bsr.w Boss_MadamBarbarSpawnDropProjectile
                lea     dword_3B1BC(pc),a1
                nop
                bsr.w Boss_MadamBarbarUpdateAnimation
                bra.w   *+4
; End of function Boss_MadamBarbarAIState
; Updates all boss body parts positions with offset calculations
Boss_MadamBarbarUpdateParts:                              ; CODE XREF: Boss_MadamBarbarIntro+62   j  ; was: sub_3A9F2
                                        ; Boss_MadamBarbarAttackPhase+62   p ...
                bsr.w Boss_MadamBarbarRotateInit
loc_3A9F6:                              ; CODE XREF: Boss_MadamBarbarAIState+200   j
                moveq   #$1B,d7
                jsr (Sprite_InitMetaspritePointers).l
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #$24,d0 ; '$'
                moveq   #$A,d1
                moveq   #5,d7
loc_3AA08:                              ; CODE XREF: Boss_MadamBarbarUpdateParts+22   j
                add.w   d0,$40(a0)
                add.w   d1,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA08
                moveq   #5,d7
loc_3AA1A:                              ; CODE XREF: Boss_MadamBarbarUpdateParts+34   j
                sub.w   d0,$40(a0)
                add.w   d1,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA1A
                moveq   #$28,d0 ; '('
                moveq   #$28,d1 ; '('
                moveq   #$14,d2
                moveq   #2,d7
loc_3AA32:                              ; CODE XREF: Boss_MadamBarbarUpdateParts+4C   j
                sub.w   d0,$40(a0)
                sub.w   d2,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA32
                moveq   #2,d7
loc_3AA44:                              ; CODE XREF: Boss_MadamBarbarUpdateParts+5E   j
                sub.w   d1,$40(a0)
                sub.w   d2,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA44
                moveq   #2,d7
loc_3AA56:                              ; CODE XREF: Boss_MadamBarbarUpdateParts+70   j
                add.w   d0,$40(a0)
                sub.w   d2,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA56
                moveq   #2,d7
loc_3AA68:                              ; CODE XREF: Boss_MadamBarbarUpdateParts+82   j
                add.w   d1,$40(a0)
                sub.w   d2,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA68
                movea.w a5,a3
                moveq   #$1C,d7
                jsr (Sprite_UpdateLinkedPositions).l
                bsr.w Boss_MadamBarbarCheckBounds
; End of function Boss_MadamBarbarUpdateParts
; Applies wobble effect to boss sprite using sine wave
Boss_MadamBarbarWobble:                              ; CODE XREF: Boss_MadamBarbarSetup+C6   p  ; was: sub_3AA86
                move.w  (word_FFA000).w,d7
                andi.w  #$F,d7
                move.b  byte_3AACE(pc,d7.w),d0
                addq.w  #8,d7
                andi.w  #$F,d7
                move.b  byte_3AACE(pc,d7.w),d1
                move.w  #$24EA,(dword_FF8040).w
                move.w  #$240E,(dword_FF8040+2).w
                sub.b   d0,(dword_FF8040).w
                sub.b   d1,(dword_FF8040+2).w
                asr.b   #1,d0
                asr.b   #1,d1
                add.b   d0,(dword_FF8040+1).w
                sub.b   d1,(dword_FF8040+3).w
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  (dword_FF8040).w,4(a0)
                move.w  (dword_FF8040+2).w,$A(a0)
                rts
; End of function Boss_MadamBarbarWobble
; ---------------------------------------------------------------------------
byte_3AACE:     dc.b 0, 1, 2, 3, 4, 4, 4, 4, 3, 2, 1, 0, 0, 1, 1, 0
                                        ; DATA XREF: Boss_MadamBarbarWobble+8   r
                                        ; Boss_MadamBarbarWobble+12   r


; Calculate direction to player and set Madam Barbar facing
Boss_MadamBarbarFacePlayer:
                clr.w   $54(a5)  ; was: sub_3AADE
                jsr (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s Boss_MadamBarbarSetCollision
                move.w  #$100,$54(a5)
; End of function Boss_MadamBarbarFacePlayer
; Sets collision flags on specific boss body segments
Boss_MadamBarbarSetCollision:                              ; CODE XREF: Boss_MadamBarbarSetup+C2   p  ; was: sub_3AAF2
                                        ; Boss_MadamBarbarFacePlayer+C   j
                moveq   #3,d5
                bclr    d5,$6E(a5)
                bclr    d5,$CE(a5)
                bclr    d5,$12E(a5)
                bclr    d5,$18E(a5)
                bset    d5,$2AE(a5)
                bset    d5,$30E(a5)
                bset    d5,$36E(a5)
                bset    d5,$3CE(a5)
                rts
; End of function Boss_MadamBarbarSetCollision
; Initializes boss rotation animation pointer updates
Boss_MadamBarbarRotateInit:                              ; CODE XREF: Boss_MadamBarbarUpdateParts   p  ; was: sub_3AB16
                movea.w #(byte_FFC7FC-M68K_RAM),a0
                bsr.s Boss_MadamBarbarRotateUpdate
                movea.w #(word_FFC7FE-M68K_RAM),a0
; End of function Boss_MadamBarbarRotateInit
; Updates boss rotation angle based on frame counter
Boss_MadamBarbarRotateUpdate:                              ; CODE XREF: Boss_MadamBarbarRotateInit+4   p  ; was: sub_3AB20
                btst    #2,(word_FFA000+1).w
                bne.s   loc_3AB3A
                subq.w  #8,(a0)
                cmpi.w  #8,(a0)
                bpl.s   loc_3AB34
                move.w  #8,(a0)
loc_3AB34:                              ; CODE XREF: Boss_MadamBarbarRotateUpdate+E   j
                                        ; Boss_MadamBarbarRotateUpdate+20   j
                andi.w  #$1FC,(a0)
                rts
; ---------------------------------------------------------------------------
loc_3AB3A:                              ; CODE XREF: Boss_MadamBarbarRotateUpdate+6   j
                addq.w  #8,(a0)
                cmpi.w  #$20,(a0) ; ' '
                bmi.s   loc_3AB34
                move.w  #$20,(a0) ; ' '
                andi.w  #$1FC,(a0)
locret_3AB4A:                           ; CODE XREF: Boss_MadamBarbarPlayRotationSound+4   j
                                        ; Boss_MadamBarbarPlayRotationSound+C   j
                rts
; End of function Boss_MadamBarbarRotateUpdate
; Play rotation sound effect for Madam Barbar based on animation frame
Boss_MadamBarbarPlayRotationSound:                              ; CODE XREF: Boss_MadamBarbarAIState+9E   p  ; was: sub_3AB4C
                                        ; Boss_MadamBarbarAIState+11A   p
                tst.w   $29C(a5)
                beq.s   locret_3AB4A
                btst    #0,7(a5)
                bne.s   locret_3AB4A
                move.b  #$AF,d0
                jmp (Sound_PlaySFX).l
; End of function Boss_MadamBarbarPlayRotationSound
; Calculates boss screen bounds with camera offset for boundary checking
Boss_MadamBarbarCheckBounds:                              ; CODE XREF: Boss_MadamBarbarUpdateParts+90   p  ; was: sub_3AB64
                move.w  #$BC,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$50,d0 ; 'P'
                move.w  d0,(dword_FFA90C).w
                jmp Boss_CheckScreenBounds
; End of function Boss_MadamBarbarCheckBounds
; Spawns boss bullet projectile with random velocity calculation
Boss_MadamBarbarSpawnBullet:                              ; CODE XREF: Boss_MadamBarbarAttackPhase:loc_3A6BE   p  ; was: sub_3AB82
                move.w  #6,(word_FFA010).w
                move.w  #6,(word_FFA014).w
                jsr (Projectile_SpawnAtPosition).l
                bne.s   locret_3ABE2
                jsr (Projectile_FindFreeSlotComplex).l
                move.b  #0,$20(a0)
                move.w  #1,$1C(a0)
                move.w  (dword_FFFF08+2).w,$1E(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$7F,d0
                andi.w  #$3F,d1 ; '?'
                subi.w  #$40,d0 ; '@'
                subi.w  #$1D,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
locret_3ABE2:                           ; CODE XREF: Boss_MadamBarbarSpawnBullet+12   j
                rts
; End of function Boss_MadamBarbarSpawnBullet
; Updates boss animation sequence with interpolation and body part rotation
Boss_MadamBarbarUpdateAnimation:                              ; CODE XREF: Boss_MadamBarbarIntro+5E   p  ; was: sub_3ABE4
                                        ; Boss_MadamBarbarAttackPhase+5E   p ...
                clr.w   $29C(a5)
                tst.w   $C(a5)
                bpl.s   loc_3AC6A
loc_3ABEE:                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_3AC7A
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_3AC10
                move.b  1(a1,d0.w),d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_3AC10:                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_3AC20
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_3AC20:                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_3AC30
                clr.w   $58(a5)
                clr.w   6(a5)
                bra.s   loc_3ABEE
; ---------------------------------------------------------------------------
loc_3AC30:                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3B20E,d0
                movea.l d0,a0
                bsr.w Boss_MadamBarbarCalcDeltas
                move.b  (dword_FF8040).w,d1
                ext.w   d1
                add.w   d1,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,6(a5)
                addq.w  #1,$29C(a5)
                subq.w  #1,$17E(a5)
                tst.w   $C(a5)
                bmi.s   loc_3AC7A
loc_3AC6A:                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$B,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_3AC7A:                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+E   j
                                        ; Boss_MadamBarbarUpdateAnimation+84   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$176(a5)
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.w  $1DC(a5),d2
                move.w  d2,d1
                neg.w   d1
                add.w   d0,d2
                add.w   d0,d1
                and.w   d7,d1
                and.w   d7,d1
                move.w  d2,$236(a5)
                move.w  d1,$296(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.b  $C(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  $1DE(a5),d2
                move.w  d2,d1
                neg.w   d1
                add.w   d0,d2
                add.w   d0,d1
                and.w   d7,d1
                and.w   d7,d1
                move.w  d2,$476(a5)
                move.w  d1,$4D6(a5)
                move.b  $10(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$536(a5)
                move.w  d1,$596(a5)
                move.b  $14(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$5F6(a5)
                move.w  d0,$9B6(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.w  d0,$A16(a5)
                move.b  $20(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$776(a5)
                move.w  d1,$7D6(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$836(a5)
                move.w  d0,$A76(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                move.w  d0,$AD6(a5)
                rts
; End of function Boss_MadamBarbarUpdateAnimation
; Calculates interpolation deltas for smooth boss animation transitions
Boss_MadamBarbarCalcDeltas:                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+62   p  ; was: sub_3AD8E
                lea     (word_34F14).l,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #$B,d7
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_MadamBarbarCalcDeltas
; Loads frame delay values for boss animation timing
Boss_MadamBarbarLoadFrameDelays:                              ; CODE XREF: Boss_MadamBarbarSetup+D0   p  ; was: sub_3ADA4
                movea.w #(dword_FF9400-M68K_RAM),a1
                moveq   #$B,d7
                jmp Anim_LoadFrameDelays
; End of function Boss_MadamBarbarLoadFrameDelays
; Spawns debris projectiles with random velocity and trajectory
Boss_MadamBarbarSpawnDebris:                              ; CODE XREF: Boss_MadamBarbarAIState:loc_3A806   p  ; was: sub_3ADB0
                                        ; sub_3A79C:loc_3A882   p ...
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0 ; '?'
                bne.s   locret_3AE34
                movea.w #(byte_FFD700-M68K_RAM),a0
                jsr     (loc_1C11C).l
                bne.s   locret_3AE34
                move.w  #$120,(a0)
                clr.w   4(a0)
                move.w  #$8D00,2(a0)
                move.w  #$F3B3,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.b  #4,$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                subq.w  #1,$14(a0)
                move.b  #$80,$21(a0)
                move.l  #$F40CF40C,$28(a0)
                move.w  #$20,$48(a0) ; ' '
                clr.w   $4A(a0)
                moveq   #3,d0
                swap    d0
                btst    #4,(dword_FFFF08).w
                beq.s   loc_3AE22
                neg.l   d0
loc_3AE22:                              ; CODE XREF: Boss_MadamBarbarSpawnDebris+6E   j
                move.l  d0,$4C(a0)
                asr.l   #1,d0
                move.l  d0,$18(a0)
                move.l  #$18000,$1C(a0)
locret_3AE34:                           ; CODE XREF: Boss_MadamBarbarSpawnDebris+8   j
                                        ; Boss_MadamBarbarSpawnDebris+14   j
                rts
; End of function Boss_MadamBarbarSpawnDebris
; Debris projectile physics with gravity bounce and screen bounds
Projectile_MadamBarbarDebris:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3AE36
                tst.w   (word_FF808C).w
                bpl.s   loc_3AE42
                tst.w   $24(a5)
                bpl.s   loc_3AE78
loc_3AE42:                              ; CODE XREF: Projectile_MadamBarbarDebris+4   j
                clr.l   $18(a5)
                move.l  #$FFFEE000,$1C(a5)
                btst    #4,$E(a5)
                beq.s   loc_3AE5A
                neg.l   $1C(a5)
loc_3AE5A:                              ; CODE XREF: Projectile_MadamBarbarDebris+1E   j
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                move.w  #2,(word_FFA010).w
                move.l  #off_E953C,8(a5)
                jmp Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
loc_3AE78:                              ; CODE XREF: Projectile_MadamBarbarDebris+A   j
                bclr    #3,$E(a5)
                btst    #2,(word_FFA000+1).w
                bne.s   loc_3AE8C
                bset    #3,$E(a5)
loc_3AE8C:                              ; CODE XREF: Projectile_MadamBarbarDebris+4E   j
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$5E(a5)
                move.w  4(a5),d0
                bne.w   loc_3AF32
                tst.w   $4A(a5)
                beq.s   loc_3AF0A
                subq.w  #1,$48(a5)
                bmi.s   loc_3AED6
                cmpi.w  #$600,$5E(a5)
                bpl.s   loc_3AEBC
                cmpi.w  #$4A0,$5E(a5)
                bpl.s   locret_3AF30
loc_3AEBC:                              ; CODE XREF: Projectile_MadamBarbarDebris+7C   j
                addq.w  #1,4(a5)
                move.l  $4C(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                neg.l   $4C(a5)
                bclr    #4,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_3AED6:                              ; CODE XREF: Projectile_MadamBarbarDebris+74   j
                                        ; Projectile_MadamBarbarDebris+18C   j
                clr.l   $18(a5)
                cmpi.w  #$FFD0,$48(a5)
                bmi.s   loc_3AEF4
                cmpi.w  #$FFE0,$48(a5)
                bpl.s   locret_3AF08
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   locret_3AF08
loc_3AEF4:                              ; CODE XREF: Projectile_MadamBarbarDebris+AA   j
                move.l  $4C(a5),$18(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                addq.w  #8,d0
                move.w  d0,$48(a5)
locret_3AF08:                           ; CODE XREF: Projectile_MadamBarbarDebris+B2   j
                                        ; Projectile_MadamBarbarDebris+BC   j
                rts
; ---------------------------------------------------------------------------
loc_3AF0A:                              ; CODE XREF: Projectile_MadamBarbarDebris+6E   j
                subi.l  #$3000,$1C(a5)
                bpl.s   locret_3AF30
                cmpi.w  #$B8,$14(a5)
                bpl.s   locret_3AF30
                move.w  #$B8,$14(a5)
                clr.l   $1C(a5)
                move.l  $4C(a5),$18(a5)
                addq.w  #1,$4A(a5)
locret_3AF30:                           ; CODE XREF: Projectile_MadamBarbarDebris+84   j
                                        ; Projectile_MadamBarbarDebris+DC   j ...
                rts
; ---------------------------------------------------------------------------
loc_3AF32:                              ; CODE XREF: Projectile_MadamBarbarDebris+66   j
                cmpi.w  #1,d0
                bne.s   loc_3AF64
                cmpi.w  #7,$1C(a5)
                bpl.s   loc_3AF4A
                addi.l  #$3000,$1C(a5)
                bmi.s   locret_3AF30
loc_3AF4A:                              ; CODE XREF: Projectile_MadamBarbarDebris+108   j
                bsr.w Boss_MadamBarbarCheckCollision
                beq.s   locret_3AF30
                addq.w  #1,4(a5)
                move.b  #$82,$21(a5)
                clr.w   $48(a5)
                jmp Physics_AlignToTerrain
; ---------------------------------------------------------------------------
loc_3AF64:                              ; CODE XREF: Projectile_MadamBarbarDebris+100   j
                cmpi.w  #3,d0
                bne.s   loc_3AFA8
loc_3AF6A:                              ; CODE XREF: Projectile_MadamBarbarDebris+180   j
                move.w  #3,4(a5)
                clr.l   $18(a5)
                bclr    #1,(byte_FF825C).w
                bne.s   loc_3AF86
                subq.w  #1,4(a5)
                clr.w   $48(a5)
                rts
; ---------------------------------------------------------------------------
loc_3AF86:                              ; CODE XREF: Projectile_MadamBarbarDebris+144   j
                move.w  #7,(word_FF824E).w
                bset    #0,(byte_FF825C).w
                move.w  $10(a5),d0
                move.w  d0,(word_FF8250).w
                move.w  $14(a5),d0
                addi.w  #-$14,d0
                move.w  d0,(word_FF8252).w
                rts
; ---------------------------------------------------------------------------
loc_3AFA8:                              ; CODE XREF: Projectile_MadamBarbarDebris+132   j
                bclr    #1,$22(a5)
                beq.s   loc_3AFB8
                bset    #1,(byte_FF825C).w
                bra.s   loc_3AF6A
; ---------------------------------------------------------------------------
loc_3AFB8:                              ; CODE XREF: Projectile_MadamBarbarDebris+178   j
                move.b  #$82,$21(a5)
                subq.w  #1,$48(a5)
                bmi.w   loc_3AED6
                cmpi.w  #$650,$5E(a5)
                bpl.s   loc_3AFD6
                cmpi.w  #$450,$5E(a5)
                bpl.s   loc_3AFDE
loc_3AFD6:                              ; CODE XREF: Projectile_MadamBarbarDebris+196   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_3AFDE:                              ; CODE XREF: Projectile_MadamBarbarDebris+19E   j
                bsr.s Boss_MadamBarbarCheckCollision
                beq.s   loc_3B004
                moveq   #8,d0
                tst.w   $18(a5)
                bpl.s   loc_3AFEC
                moveq   #$FFFFFFF8,d0
loc_3AFEC:                              ; CODE XREF: Projectile_MadamBarbarDebris+1B2   j
                moveq   #0,d1
                jsr (Physics_AddEntityOffset).l
                beq.s   locret_3B012
                move.b  #$80,$21(a5)
                move.l  #$FFFC0000,$1C(a5)
loc_3B004:                              ; CODE XREF: Projectile_MadamBarbarDebris+1AA   j
                subq.w  #1,4(a5)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
locret_3B012:                           ; CODE XREF: Projectile_MadamBarbarDebris+1BE   j
                rts
; End of function Projectile_MadamBarbarDebris
; Checks collision at boss center position for projectile spawning
Boss_MadamBarbarCheckCollision:                              ; CODE XREF: Projectile_MadamBarbarDebris:loc_3AF4A   p  ; was: sub_3B014
                                        ; sub_3AE36:loc_3AFDE   p
                moveq   #0,d0
                moveq   #$C,d1
                jmp Physics_AddEntityOffset
; End of function Boss_MadamBarbarCheckCollision
; Spawns boss projectiles with random position offset calculations
Boss_MadamBarbarSpawnProjectile:                              ; CODE XREF: Boss_MadamBarbarAttackPhase   p  ; was: sub_3B01E
                                        ; Boss_MadamBarbarIdleUpdate+1A   p
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_3B066
                movea.l #dword_3B178,a1
                jsr (Sprite_InitFromTable).l
                move.w  #$8100,2(a0)
                move.b  #$20,$20(a0) ; ' '
loc_3B03E:                              ; CODE XREF: Boss_MadamBarbarSpawnDropProjectile+54   j
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                addi.w  #8,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
locret_3B066:                           ; CODE XREF: Boss_MadamBarbarSpawnProjectile+6   j
                                        ; Boss_MadamBarbarSpawnDropProjectile+8   j ...
                rts
; End of function Boss_MadamBarbarSpawnProjectile
; Spawn falling projectile from Madam Barbar boss
Boss_MadamBarbarSpawnDropProjectile:                              ; CODE XREF: Boss_MadamBarbarAIState+244   p  ; was: sub_3B068
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   locret_3B066
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_3B066
                move.w  #$11C,(a0)
                clr.w   4(a0)
                move.w  #$8D00,2(a0)
                move.w  #$C3C3,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.w  #$B3,$26(a0)
                move.b  #4,$20(a0)
                move.w  #$F,$48(a0)
                move.w  #2,$4A(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                move.l  d0,$18(a0)
                bra.w   loc_3B03E
; End of function Boss_MadamBarbarSpawnDropProjectile
; Handle Madam Barbar dropped projectile animation and bouncing behavior
Projectile_MadamBarbarDropBehavior:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3B0C0
                tst.w   (word_FF808C).w
                bmi.s   loc_3B0CE
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_3B0CE:                              ; CODE XREF: Projectile_MadamBarbarDropBehavior+4   j
                tst.w   4(a5)
                bne.s   loc_3B0FC
                subq.w  #1,$48(a5)
                bpl.s   locret_3B0FA
                move.w  #$F,$48(a5)
                addq.w  #1,$E(a5)
                cmpi.b  #$C5,$F(a5)
                bne.s   locret_3B0FA
                addq.w  #2,4(a5)
                move.l  $18(a5),d0
                asl.l   #3,d0
                move.l  d0,$18(a5)
locret_3B0FA:                           ; CODE XREF: Projectile_MadamBarbarDropBehavior+18   j
                                        ; Projectile_MadamBarbarDropBehavior+2A   j
                rts
; ---------------------------------------------------------------------------
loc_3B0FC:                              ; CODE XREF: Projectile_MadamBarbarDropBehavior+12   j
                move.w  #$C3C5,$E(a5)
                cmpi.w  #7,$1C(a5)
                bpl.s   loc_3B114
                addi.l  #$6000,$1C(a5)
                bmi.s   locret_3B134
loc_3B114:                              ; CODE XREF: Projectile_MadamBarbarDropBehavior+48   j
                moveq   #0,d0
                moveq   #0,d1
                jsr (Physics_AddEntityOffset).l
                beq.s   locret_3B134
                subq.w  #1,$4A(a5)
                bmi.s   loc_3B136
                move.l  #$FFFC4000,$1C(a5)
                move.w  #$C3D2,$E(a5)
locret_3B134:                           ; CODE XREF: Projectile_MadamBarbarDropBehavior+52   j
                                        ; Projectile_MadamBarbarDropBehavior+5E   j
                rts
; ---------------------------------------------------------------------------
loc_3B136:                              ; CODE XREF: Projectile_MadamBarbarDropBehavior+64   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                bne.s   loc_3B168
                jsr (Projectile_FindFreeSlot).l
                bne.s   loc_3B168
                jsr (Effect_SpawnDestructionBlast).l
                bset    #2,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$FFFF6000,$1C(a0)
loc_3B168:                              ; CODE XREF: Projectile_MadamBarbarDropBehavior+7E   j
                                        ; Projectile_MadamBarbarDropBehavior+86   j
                clr.l   $18(a5)
                move.w  #$FFFE,$1C(a5)
                jmp Projectile_CheckLifetime
; End of function Projectile_MadamBarbarDropBehavior
; ---------------------------------------------------------------------------
dword_3B178:    dc.l $163BC, $FCFC, $163BD, $FCFC, $163BE, $FCFC, $263BF
                                        ; DATA XREF: Boss_MadamBarbarSpawnProjectile+8   o
                dc.l $500F8F8, $163BE, $FCFC, $163BD, $FCFC, $163BC, $FCFC
                dc.w $FFFF
dword_3B1B2:    dc.l $100000, $10000C   ; DATA XREF: Boss_MadamBarbarIntro:loc_3A65C   o
                                        ; Boss_MadamBarbarIdleUpdate+1E   o ...
                dc.w $FFFF
dword_3B1BC:    dc.l $70000, $7000C     ; DATA XREF: Boss_MadamBarbarAIState+248   o
                dc.w $FFFF
dword_3B1C6:    dc.l $40018, $4000C     ; DATA XREF: Boss_MadamBarbarAttackPhase+58   o
                dc.w $FFFF
dword_3B1D0:    dc.l $F70D0018, $220018, $E3200024, $FE0E0024, $180024, $F0200018
                                        ; DATA XREF: Boss_MadamBarbarAIState+1F6   o
                dc.w $FFFE
dword_3B1EA:    dc.l $100030, $10003C, $100048, $100054
                                        ; DATA XREF: Boss_MadamBarbarAIState:loc_3A830   o
                dc.w $FFFF
dword_3B1FC:    dc.l $100060, $10006C, $100078, $100084
                                        ; DATA XREF: Boss_MadamBarbarAIState:loc_3A8AC   o
                dc.w $FFFF
word_3B20E:     dc.w $D828, $A8D8, $8818, $D820, $A8E0, $F8E8, $E028, $A0D8
                                        ; DATA XREF: Boss_MadamBarbarSetup+CA   o
                                        ; Boss_MadamBarbarUpdateAnimation+5A   o
                dc.w $9020, $D020, $B0E0, $F0E0, $A028, $E0D8, $8010, $E028
                dc.w $A0D8, $F0, $4408, $3CF8, $B404, $CC04, $B4FC, $CCFC
                dc.w $C030, $A0D0, $9020, $D020, $B0E0, $F0E0, $E030, $C0D0
                dc.w $C018, $8870, $C0E8, $F890, $C030, $A0D0, $D020, $9020
                dc.w $F0E0, $B0E0, $E030, $C0D0, $8870, $C018, $F890, $C0E8
                dc.w $E030, $C0D0, $9020, $D020, $B0E0, $F0E0, $C030, $A0D0
                dc.w $8870, $C018, $F890, $C0E8, $E030, $C0D0, $D020, $9020
                dc.w $F0E0, $B0E0, $C030, $A0D0, $C018, $8870, $C0E8, $F890


; Main Joker boss update handler with state dispatching and fade
Boss_JokerMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3B29E
                tst.w   4(a5)
                beq.w   loc_3B2D6
                tst.w   8(a5)
                beq.s   loc_3B2D6
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3B2C4
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3B2C4
                tst.w   (word_FF8200).w
                beq.w Boss_JokerFallingInit
loc_3B2C4:                              ; CODE XREF: Boss_JokerMain+14   j
                                        ; Boss_JokerMain+1C   j
                jsr (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
loc_3B2D6:                              ; CODE XREF: Boss_JokerMain+4   j
                                        ; Boss_JokerMain+C   j
                move.w  4(a5),d0
                movea.w off_3B2E6(pc,d0.w),a0
                adda.l  #Boss_JokerInit,a0
                jmp     (a0)
; End of function Boss_JokerMain
; ---------------------------------------------------------------------------
off_3B2E6:      dc.w Boss_JokerInit-Boss_JokerInit
                                        ; DATA XREF: Boss_JokerMain+3C   r
                dc.w Boss_JokerSetup-Boss_JokerInit
                dc.w Boss_JokerInitTauntState-Boss_JokerInit
                dc.w Boss_JokerDivePrep-Boss_JokerInit
                dc.w Boss_JokerDive_ApplyGravity-Boss_JokerInit
                dc.w Boss_JokerSpinDive-Boss_JokerInit
                dc.w Boss_JokerStretchState-Boss_JokerInit
                dc.w Boss_JokerLandingState-Boss_JokerInit
                dc.w Boss_JokerLandingImpact-Boss_JokerInit
                dc.w Boss_JokerLandingImpact_FallingPhase-Boss_JokerInit
                dc.w Boss_JokerLandingImpact_GroundBounce-Boss_JokerInit
                dc.w Boss_JokerGroundBounceAttack-Boss_JokerInit
                dc.w Boss_JokerDefeatWait-Boss_JokerInit
                dc.w Boss_JokerDefeatAnim-Boss_JokerInit
                dc.w Boss_JokerDefeatAnim_TimerCountdown-Boss_JokerInit
                dc.w Boss_JokerFallingPhase1-Boss_JokerInit
                dc.w Boss_JokerFadeOut-Boss_JokerInit
                dc.w Boss_JokerFadeComplete-Boss_JokerInit
                dc.w Boss_JokerCleanup-Boss_JokerInit
                dc.w Boss_JokerTaunt_WaitInterrupt-Boss_JokerInit


; Initializes Joker boss clearing sprites and setting scroll position
Boss_JokerInit:                              ; DATA XREF: Boss_JokerMain+40   o  ; was: sub_3B30E
                                        ; ROM:off_3B2E6   o ...
                addq.w  #2,4(a5)
                clr.w   8(a5)
                move.w  (dword_FFA900).w,$48(a5)
                move.w  #4,$4A(a5)
                move.w  #$15C,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
locret_3B32E:                           ; CODE XREF: Boss_JokerSetup+4   j
                rts
; End of function Boss_JokerInit
; Sets up Joker boss with metasprites tiles animation and music
Boss_JokerSetup:                              ; DATA XREF: ROM:0003B2E8   o  ; was: sub_3B330
                tst.w   (word_FFF720).w
                bmi.s   locret_3B32E
                subq.w  #1,$4A(a5)
                bmi.s   loc_3B354
                addi.w  #8,$48(a5)
                move.w  $48(a5),d0
                addi.w  #$158,d0
                move.w  (dword_FFA904).w,d1
                jmp Gfx_RenderTilemap
; ---------------------------------------------------------------------------
loc_3B354:                              ; CODE XREF: Boss_JokerSetup+A   j
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$12,d7
                movea.l #dword_35056,a0
                movea.l #word_350A2,a1
                movea.l #word_350B6,a2
                jsr (Sprite_InitMetaspriteComplex).l
                movea.w #(word_FFCD40-M68K_RAM),a0
                moveq   #0,d0
                moveq   #3,d7
loc_3B382:                              ; CODE XREF: Boss_JokerSetup+5A   j
                move.w  #$10,(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3B382
                move.w  #$15C,(a5)
                moveq   #0,d0
                bset    d0,2(a5)
                bset    d0,$362(a5)
                bset    d0,$6C2(a5)
                movea.l #word_1BB3C,a1
                jsr (Sprite_InitFromPointerTable).l
                lea     byte_3B3F8(pc),a0
                nop
                jsr (Gfx_LoadCompressedTiles).l
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #7,d0
                moveq   #$11,d7
loc_3B3C0:                              ; CODE XREF: Boss_JokerSetup+98   j
                bset    d0,3(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3B3C0
                move.w  #2,$35C(a5)
                move.w  #$238,$10(a5)
                move.w  #$40,$1DC(a5) ; '@'
                move.w  #$10,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.w  #$E,(word_FF8090).w
                move.b  #2,(byte_FFA95B).w
                bra.w Boss_JokerAttackState
; End of function Boss_JokerSetup
; ---------------------------------------------------------------------------
byte_3B3F8:     dc.b $61, 0, $20, 0, 3, 2, 0, $40, $41
                                        ; DATA XREF: Boss_JokerSetup+7C   o
                dc.b 0, $45, $44, $42, $43, $48, $3C, $46, $47


; Initializes boss defeat sequence with state and timer setup
Boss_JokerDefeatInit:                              ; CODE XREF: Boss_JokerStretchState+48   j  ; was: sub_3B40A
                move.w  #$18,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$11C(a5) ; '@'
; End of function Boss_JokerDefeatInit
; Defeat sequence timer countdown checking victory condition
Boss_JokerDefeatWait:                              ; DATA XREF: ROM:0003B2FE   o  ; was: sub_3B420
                subq.w  #1,$11C(a5)
                bpl.w   loc_3B464
                addq.w  #2,4(a5)
                moveq   #5,d0
                jsr (UI_CheckVictoryCondition).l
; End of function Boss_JokerDefeatWait
; Defeat animation with hitbox adjustment and metasprite flipping
Boss_JokerDefeatAnim:                              ; DATA XREF: ROM:0003B300   o  ; was: sub_3B434
                tst.w   (word_FF80C2).w
                bne.w   loc_3B464
                addq.w  #2,4(a5)
                move.w  #$40,$11C(a5) ; '@'
; Xi-Tiger Joker defeat animation timer
Boss_JokerDefeatAnim_TimerCountdown:                              ; DATA XREF: ROM:0003B302   o  ; was: loc_3B446
                subq.w  #1,$11C(a5)
                bpl.s   loc_3B464
                clr.b   (byte_FF80EC).w
                clr.w   $35C(a5)
                subi.w  #$60,(word_FFA970).w ; '`'
                addi.w  #$40,(word_FFA974).w ; '@'
                bra.w Boss_JokerSelectAttack
; ---------------------------------------------------------------------------
loc_3B464:                              ; CODE XREF: Boss_JokerDefeatWait+4   j
                                        ; Boss_JokerDefeatAnim+4   j ...
                lea     word_3BF14(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                move.w  $58(a5),d7
                cmpi.w  #$10,d7
                beq.s   loc_3B47E
                cmpi.w  #4,d7
                bne.s   loc_3B48C
loc_3B47E:                              ; CODE XREF: Boss_JokerDefeatAnim+42   j
                cmpi.w  #$56,$1DC(a5) ; 'V'
                bpl.s   loc_3B498
                addq.w  #2,$1DC(a5)
                bra.s   loc_3B498
; ---------------------------------------------------------------------------
loc_3B48C:                              ; CODE XREF: Boss_JokerDefeatAnim+48   j
                cmpi.w  #$32,$1DC(a5) ; '2'
                bmi.s   loc_3B498
                subq.w  #1,$1DC(a5)
loc_3B498:                              ; CODE XREF: Boss_JokerDefeatAnim+50   j
                                        ; Boss_JokerDefeatAnim+56   j ...
                tst.w   $3BC(a5)
                beq.s   loc_3B4BA
                cmpi.w  #8,$58(a5)
                beq.s   loc_3B4AE
                cmpi.w  #$14,$58(a5)
                bne.s   loc_3B4BA
loc_3B4AE:                              ; CODE XREF: Boss_JokerDefeatAnim+70   j
                eori.w  #$100,$54(a5)
                move.w  $370(a5),$6D0(a5)
loc_3B4BA:                              ; CODE XREF: Boss_JokerDefeatAnim+68   j
                                        ; Boss_JokerDefeatAnim+78   j
                move.w  #$CCE0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  #$144,$6D4(a5)
                bsr.w Boss_JokerRenderBody
                move.w  #$144,$374(a5)
                rts
; End of function Boss_JokerDefeatAnim
; Initializes Joker boss falling state after defeat
Boss_JokerFallingInit:                              ; CODE XREF: Boss_JokerMain+22   j  ; was: sub_3B4D8
                move.w  #4,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                bset    #0,(byte_FFA272).w
                jsr (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                clr.w   $29E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $54(a5)
                move.w  #$40,$1DC(a5) ; '@'
                clr.l   $18(a5)
                move.l  #$FFFEE000,$1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$80,$11C(a5)
                clr.w   $A(a5)
                bra.s Boss_JokerFallingPhase1
; End of function Boss_JokerFallingInit
; Boss fade out effect clearing sprites and spawning player
Boss_JokerFadeOut:                              ; DATA XREF: ROM:0003B306   o  ; was: sub_3B52E
                bsr.w Gfx_SetFadeLevel
                addq.w  #1,$A(a5)
                cmpi.w  #$20,$A(a5) ; ' '
                bmi.s   loc_3B57A
                addq.w  #2,4(a5)
                clr.w   2(a5)
                clr.w   8(a5)
                move.w  #$15C,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                move.b  #4,(byte_FFA95A).w
                jsr (Effect_InitPlayerSpawn).l
                addi.w  #$10,$14(a0)
                rts
; End of function Boss_JokerFadeOut
; First falling phase with palette fade and projectile spawn
Boss_JokerFallingPhase1:                              ; CODE XREF: Boss_JokerFallingInit+54   j  ; was: sub_3B56A
                                        ; DATA XREF: ROM:0003B304   o
                subq.w  #1,$11C(a5)
                bpl.s   loc_3B574
                addq.w  #2,4(a5)
loc_3B574:                              ; CODE XREF: Boss_JokerFallingPhase1+4   j
                jsr (Gfx_UpdatePaletteFade).l
loc_3B57A:                              ; CODE XREF: Boss_JokerFadeOut+E   j
                bsr.w Boss_JokerSpawnDebris
                move.w  #4,(word_FFA010).w
                addi.l  #$3000,$1C(a5)
                bpl.s Boss_JokerFallingPhase2
                cmpi.w  #$48,$1DC(a5) ; 'H'
                bpl.s   loc_3B5C6
                addi.l  #$18000,$1DC(a5)
                bra.s   loc_3B5C6
; End of function Boss_JokerFallingPhase1
; Second falling phase adjusting descent speed to ground
Boss_JokerFallingPhase2:                              ; CODE XREF: Boss_JokerFallingPhase1+22   j  ; was: sub_3B5A0
                cmpi.w  #$34,$1DC(a5) ; '4'
                bmi.s   loc_3B5B0
                subi.l  #$18000,$1DC(a5)
loc_3B5B0:                              ; CODE XREF: Boss_JokerFallingPhase2+6   j
                cmpi.w  #$120,$14(a5)
                bmi.s   loc_3B5C6
                move.w  #$120,$14(a5)
                move.l  #$FFFCC000,$1C(a5)
loc_3B5C6:                              ; CODE XREF: Boss_JokerFallingPhase1+2A   j
                                        ; Boss_JokerFallingPhase1+34   j ...
                lea     word_3BF7E(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w Boss_JokerRenderBody
; End of function Boss_JokerFallingPhase2
; Completes fade out and transitions to final state
Boss_JokerFadeComplete:                              ; DATA XREF: ROM:0003B308   o  ; was: sub_3B5D4
                subq.w  #2,$A(a5)
                bne.s   loc_3B5E4
                addq.w  #2,4(a5)
                move.w  #$70,$11C(a5) ; 'p'
loc_3B5E4:                              ; CODE XREF: Boss_JokerFadeComplete+4   j
                bra.w Gfx_SetFadeLevel
; End of function Boss_JokerFadeComplete
; Cleans up Joker boss removing entity and clearing flags
Boss_JokerCleanup:                              ; DATA XREF: ROM:0003B30A   o  ; was: sub_3B5E8
                subq.w  #1,$11C(a5)
                bpl.s   locret_3B600
                bset    #4,2(a5)
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                clr.b   (word_FFF7E6+1).w
locret_3B600:                           ; CODE XREF: Boss_JokerCleanup+4   j
                rts
; End of function Boss_JokerCleanup
; Spawns falling debris and explosion sprites during defeat
Boss_JokerSpawnDebris:                              ; CODE XREF: Boss_JokerFallingPhase1:loc_3B57A   p  ; was: sub_3B602
                jsr (Effect_PlayRandomExplosionSound).l
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_3B68C
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                bne.s   loc_3B624
                jsr (Effect_InitDebrisSprite).l
                bra.w   loc_3B65E
; ---------------------------------------------------------------------------
loc_3B624:                              ; CODE XREF: Boss_JokerSpawnDebris+16   j
                jsr (Sprite_InitializeProperties).l
                bset    #7,3(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
                move.l  #off_E953C,8(a0)
                move.w  #$FFFE,$1C(a0)
                btst    #0,(dword_FFFF08).w
                beq.s   loc_3B65E
                move.l  #off_E9604,8(a0)
                clr.w   $1C(a0)
loc_3B65E:                              ; CODE XREF: Boss_JokerSpawnDebris+1E   j
                                        ; Boss_JokerSpawnDebris+4E   j
                move.b  #0,$20(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0 ; '?'
                andi.w  #$3F,d1 ; '?'
                subi.w  #$20,d0 ; ' '
                subi.w  #$12,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_3B68C:                           ; CODE XREF: Boss_JokerSpawnDebris+C   j
                rts
; End of function Boss_JokerSpawnDebris
; Sets graphics fade level based on counter value
Gfx_SetFadeLevel:                              ; CODE XREF: Boss_JokerFadeOut   p  ; was: sub_3B68E
                                        ; sub_3B5D4:loc_3B5E4   j
                move.w  $A(a5),d0
                asr.w   #1,d0
                jmp (Gfx_SetFadeParams).l
; End of function Gfx_SetFadeLevel
; Selects boss attack pattern based on health and RNG value
Boss_JokerSelectAttack:                              ; CODE XREF: Boss_JokerDefeatAnim+2C   j  ; was: sub_3B69A
                                        ; Boss_JokerInitTauntState+12   j ...
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  #$C980,$4A(a5)
                move.w  #$144,$374(a5)
                clr.l   $18(a5)
                move.w  #$40,$1DC(a5) ; '@'
                tst.w   (word_FF8234).w
                bmi.s Boss_JokerInitTauntState
                beq.s Boss_JokerInitTauntState
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$6A,d0 ; 'j'
                bpl.s   loc_3B6E8
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.w Boss_JokerAttackState
                bra.w Boss_JokerLandingPrep
; ---------------------------------------------------------------------------
loc_3B6E8:                              ; CODE XREF: Boss_JokerSelectAttack+3C   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                beq.w Boss_JokerLandingPrep
                bra.w Boss_JokerAttackState
; End of function Boss_JokerSelectAttack
; Initialize Xi-Tiger Joker boss taunt state with animation
Boss_JokerInitTauntState:                              ; CODE XREF: Boss_JokerSelectAttack+2E   j  ; was: sub_3B6F8
                                        ; Boss_JokerSelectAttack+30   j
                                        ; DATA XREF: ...
                move.w  #$26,4(a5) ; '&'
                move.w  #$30,$11C(a5) ; '0'
; Waits for interrupt flag before selecting next attack
Boss_JokerTaunt_WaitInterrupt:                              ; DATA XREF: ROM:0003B30C   o  ; was: loc_3B704
                bclr    #0,(byte_FF8260).w
                bne.w Boss_JokerSelectAttack
                addi.w  #2,(word_FF8234).w
                lea     word_3BF2E(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w Boss_JokerRenderBody
; End of function Boss_JokerInitTauntState
; Sets Joker boss attack state with collision and animation params
Boss_JokerAttackState:                              ; CODE XREF: Boss_JokerSetup+C4   j  ; was: sub_3B722
                                        ; Boss_JokerSelectAttack+46   j ...
                move.w  #$16,$26(a5)
                move.w  #6,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  #$C980,$4A(a5)
                move.w  #$144,$374(a5)
; End of function Boss_JokerAttackState
; Joker boss dive preparation with sound and velocity initialization
Boss_JokerDivePrep:                              ; DATA XREF: ROM:0003B2EC   o  ; was: sub_3B748
                tst.w   $58(a5)
                bmi.s   loc_3B75C
                lea     word_3BF38(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B75C:                              ; CODE XREF: Boss_JokerDivePrep+4   j
                move.b  #$44,d0 ; 'D'
                jsr (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFEC000,$23C(a5)
                move.l  #$FFFB0000,$1C(a5)
                move.w  #2,(word_FFA010).w
                move.b  #$44,d0 ; 'D'
                jsr (Sound_PlaySFX).l
                tst.w   $35C(a5)
                bne.s   loc_3B7A4
                subi.w  #$C,(word_FF8234).w
loc_3B7A4:                              ; CODE XREF: Boss_JokerDivePrep+54   j
                tst.w   $35C(a5)
                beq.s   loc_3B7B4
                move.l  #$FFFEC000,$18(a5)
                bra.s Boss_JokerDive_ApplyGravity
; ---------------------------------------------------------------------------
loc_3B7B4:                              ; CODE XREF: Boss_JokerDivePrep+60   j
                jsr (Physics_CalculateDistanceTo).l
                move.l  #$10000,d0
                move.w  (dword_FFFF08).w,d0
                tst.w   d1
                bpl.s   loc_3B7CA
                neg.l   d0
loc_3B7CA:                              ; CODE XREF: Boss_JokerDivePrep+7E   j
                move.l  d0,$18(a5)
; Applies spinning gravity during dive attack sequence
Boss_JokerDive_ApplyGravity:                              ; CODE XREF: Boss_JokerDivePrep+6A   j  ; was: loc_3B7CE
                                        ; DATA XREF: ROM:0003B2EE   o
                bsr.s Boss_JokerApplySpinGravity
                bpl.s Boss_JokerDiveComplete
                lea     word_3BF42(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w Boss_JokerRenderBody
; End of function Boss_JokerDivePrep
; Applies spinning gravity acceleration and rotation to boss
Boss_JokerApplySpinGravity:                              ; CODE XREF: Boss_JokerDivePrep:loc_3B7CE   p  ; was: sub_3B7E0
                                        ; sub_3B808   p
                addi.l  #$A00,$23C(a5)
                move.l  $23C(a5),d0
                add.l   d0,$1DC(a5)
                addi.l  #$2000,$1C(a5)
                rts
; End of function Boss_JokerApplySpinGravity
; Completes dive attack transitioning to next phase
Boss_JokerDiveComplete:                              ; CODE XREF: Boss_JokerDivePrep+88   j  ; was: sub_3B7FA
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; End of function Boss_JokerDiveComplete
; Joker boss spinning dive attack with gravity and projectile spawn
Boss_JokerSpinDive:                              ; DATA XREF: ROM:0003B2F0   o  ; was: sub_3B808
                bsr.s Boss_JokerApplySpinGravity
                cmpi.w  #$144,$374(a5)
                bpl.s   loc_3B820
                lea     word_3BF4C(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B820:                              ; CODE XREF: Boss_JokerSpinDive+8   j
                                        ; Boss_JokerGroundBounceAttack+18   j
                move.w  #$C,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$C980,$4A(a5)
                move.w  #$144,$374(a5)
                clr.l   $1C(a5)
                move.b  #$53,d0 ; 'S'
                jsr (Sound_PlaySFX).l
                bsr.w Boss_JokerSpawnBomb
; End of function Boss_JokerSpinDive
; Joker boss stretch state adjusting hitbox size dynamically
Boss_JokerStretchState:                              ; DATA XREF: ROM:0003B2F2   o  ; was: sub_3B84E
                move.w  $58(a5),d0
                bmi.s   loc_3B886
                cmpi.w  #$C,d0
                bmi.s   loc_3B868
                cmpi.w  #$40,$1DC(a5) ; '@'
                bpl.s   loc_3B874
                addq.w  #1,$1DC(a5)
                bra.s   loc_3B874
; ---------------------------------------------------------------------------
loc_3B868:                              ; CODE XREF: Boss_JokerStretchState+A   j
                cmpi.w  #$30,$1DC(a5) ; '0'
                bmi.s   loc_3B874
                subq.w  #2,$1DC(a5)
loc_3B874:                              ; CODE XREF: Boss_JokerStretchState+12   j
                                        ; Boss_JokerStretchState+18   j ...
                bsr.w Boss_JokerSlowHorizontal
                lea     word_3BF6C(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B886:                              ; CODE XREF: Boss_JokerStretchState+4   j
                tst.w   $35C(a5)
                beq.s   loc_3B89A
                cmpi.w  #$190,$10(a5)
                bpl.w Boss_JokerAttackState
                bra.w Boss_JokerDefeatInit
; ---------------------------------------------------------------------------
loc_3B89A:                              ; CODE XREF: Boss_JokerStretchState+3C   j
                bra.w Boss_JokerSelectAttack
; End of function Boss_JokerStretchState
; Prepares boss landing state after fall setting params
Boss_JokerLandingPrep:                              ; CODE XREF: Boss_JokerSelectAttack+4A   j  ; was: sub_3B89E
                                        ; Boss_JokerSelectAttack+56   j
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  #$C980,$4A(a5)
                move.w  #$144,$374(a5)
; End of function Boss_JokerLandingPrep
; Boss landing state with screen shake and velocity adjustment
Boss_JokerLandingState:                              ; DATA XREF: ROM:0003B2F4   o  ; was: sub_3B8BE
                tst.w   $58(a5)
                bmi.s   loc_3B8DA
                subi.l  #$8000,$1DC(a5)
                lea     word_3BF38(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B8DA:                              ; CODE XREF: Boss_JokerLandingState+4   j
                move.b  #$44,d0 ; 'D'
                jsr (Sound_PlaySFX).l
                move.w  #$56,$26(a5) ; 'V'
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFF80000,$1C(a5)
                subi.w  #$3E,(word_FF8234).w ; '>'
                move.w  #2,(word_FFA010).w
                move.b  #$44,d0 ; 'D'
                jsr (Sound_PlaySFX).l
; End of function Boss_JokerLandingState
; Handle Xi-Tiger Joker landing impact with ground bounce physics
Boss_JokerLandingImpact:                              ; DATA XREF: ROM:0003B2F6   o  ; was: sub_3B91A
                addi.l  #$2000,$1C(a5)
                addq.w  #2,$1DC(a5)
                move.w  $1DC(a5),d0
                subi.w  #$40,d0 ; '@'
                asr.w   #1,d0
                add.w   $14(a5),d0
                cmpi.w  #$C8,d0
                bmi.s   loc_3B948
                lea     word_3BF56(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B948:                              ; CODE XREF: Boss_JokerLandingImpact+1E   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$FFFE0000,$23C(a5)
                clr.l   $1C(a5)
                move.w  #5,(word_FFA010).w
                move.b  #$A1,d0
                jsr (Sound_PlaySFX).l
                move.w  #$16,$26(a5)
; Xi-Tiger Joker falling phase with gravity
Boss_JokerLandingImpact_FallingPhase:                              ; DATA XREF: ROM:0003B2F8   o  ; was: loc_3B978
                addi.l  #$1000,$23C(a5)
                bpl.s   loc_3B98A
                move.l  $23C(a5),d0
                add.l   d0,$1DC(a5)
loc_3B98A:                              ; CODE XREF: Boss_JokerLandingImpact+66   j
                bsr.w Boss_JokerCalculateYPosition
                tst.w   $58(a5)
                bmi.s   loc_3B9A2
                lea     word_3BF5C(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w Boss_JokerRenderBody
; ---------------------------------------------------------------------------
loc_3B9A2:                              ; CODE XREF: Boss_JokerLandingImpact+78   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $23C(a5)
; Xi-Tiger Joker ground bounce after landing
Boss_JokerLandingImpact_GroundBounce:                              ; DATA XREF: ROM:0003B2FA   o  ; was: loc_3B9B4
                bsr.s Boss_JokerUpdateGroundBounce
                cmpi.w  #$40,$1DC(a5) ; '@'
                bpl.s Boss_JokerLandingTransition
                bsr.w Boss_JokerCalculateYPosition
                lea     word_3BF66(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w Boss_JokerRenderBody
; End of function Boss_JokerLandingImpact
; Update Xi-Tiger Joker vertical position during ground bounce
Boss_JokerUpdateGroundBounce:                              ; CODE XREF: Boss_JokerLandingImpact:loc_3B9B4   p  ; was: sub_3B9D0
                                        ; Boss_JokerGroundBounceAttack+8   p
                addi.l  #$180,$23C(a5)
                move.l  $23C(a5),d0
                add.l   d0,$1DC(a5)
                rts
; End of function Boss_JokerUpdateGroundBounce
; Transition state after Joker boss landing
Boss_JokerLandingTransition:                              ; CODE XREF: Boss_JokerLandingImpact+A2   j  ; was: sub_3B9E2
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; End of function Boss_JokerLandingTransition
; Joker boss ground bounce attack with gravity and rotation
Boss_JokerGroundBounceAttack:                              ; DATA XREF: ROM:0003B2FC   o  ; was: sub_3B9F0
                addi.l  #$280,$23C(a5)
                bsr.s Boss_JokerUpdateGroundBounce
                addi.l  #$2000,$1C(a5)
                cmpi.w  #$140,$374(a5)
                bpl.w   loc_3B820
                lea     word_3BF4C(pc),a1
                nop
                bsr.w Boss_JokerUpdateAnimation
                bra.w   *+4
; End of function Boss_JokerGroundBounceAttack
; Renders Joker boss body parts with complex metasprite positioning
Boss_JokerRenderBody:                              ; CODE XREF: Boss_JokerDefeatAnim+98   p  ; was: sub_3BA1A
                                        ; Boss_JokerFallingPhase2+30   j ...
                movea.w #(word_FFCD40-M68K_RAM),a0
                movea.w #(byte_FFCE00-M68K_RAM),a1
                movea.w #(word_FFCDA0-M68K_RAM),a2
                movea.w #(byte_FFCE60-M68K_RAM),a3
                tst.w   $54(a5)
                beq.s   loc_3BA34
                exg     a0,a1
                exg     a2,a3
loc_3BA34:                              ; CODE XREF: Boss_JokerRenderBody+14   j
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                move.w  #$FFE4,$40(a0)
                move.w  #$10,$44(a0)
                move.w  #$1C,$40(a1)
                move.w  #$10,$44(a1)
                move.w  $1DC(a5),d5
                subi.w  #$40,d5 ; '@'
                asr.w   #1,d5
                addi.w  #$24,d5 ; '$'
                move.w  #$FFE3,$40(a2)
                move.w  d5,$44(a2)
                move.w  #$1D,$40(a3)
                move.w  d5,$44(a3)
                moveq   #$15,d7
                jsr (Sprite_InitMetaspriteSimple).l
                cmpi.w  #$60,$10(a5) ; '`'
                bmi.s   loc_3BA8E
                cmpi.w  #$1E0,$10(a5)
                bmi.s   loc_3BA96
loc_3BA8E:                              ; CODE XREF: Boss_JokerRenderBody+6A   j
                move.w  #$FE72,(dword_FFA908).w
                bra.s   loc_3BAA2
; ---------------------------------------------------------------------------
loc_3BA96:                              ; CODE XREF: Boss_JokerRenderBody+72   j
                move.w  #$C0,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
loc_3BAA2:                              ; CODE XREF: Boss_JokerRenderBody+7A   j
                move.w  #$80,d0
                move.w  #$5F,d7 ; '_'
                movea.w #(byte_FF9520-M68K_RAM),a0
loc_3BAAE:                              ; CODE XREF: Boss_JokerRenderBody+98   j
                move.w  d0,(a0)+
                subq.w  #2,d0
                dbf     d7,loc_3BAAE
                moveq   #0,d5
                move.w  $1DC(a5),d5
                subi.w  #$40,d5 ; '@'
                beq.s   loc_3BAD4
                ext.l   d5
                asl.l   #8,d5
                divs.w  $1DC(a5),d5
                swap    d5
                move.w  #0,d5
                asr.l   #8,d5
                asl.l   #1,d5
loc_3BAD4:                              ; CODE XREF: Boss_JokerRenderBody+A6   j
                moveq   #0,d3
                move.w  #$1B0,d3
                sub.w   $14(a5),d3
                move.l  d3,d4
                move.w  $14(a5),d0
                subi.w  #$98,d0
                addi.w  #-$6AE0,d0
                bclr    #0,d0
                movea.w d0,a0
                movea.w d0,a1
                moveq   #$1E,d7
loc_3BAF6:                              ; CODE XREF: Boss_JokerRenderBody+EC   j
                move.w  d3,-(a0)
                move.w  d4,(a1)+
                swap    d3
                add.l   d5,d3
                swap    d3
                swap    d4
                sub.l   d5,d4
                swap    d4
                dbf     d7,loc_3BAF6
                movea.w #(word_FF9600-M68K_RAM),a0
                movea.w #(dword_FF9610-M68K_RAM),a1
                lea     word_3BC1A(pc),a2
                nop
                move.w  (word_FFA000).w,d0
                andi.w  #$1C,d0
                move.w  (a2,d0.w),d1
                move.w  2(a2,d0.w),d2
                move.w  $20(a2,d0.w),d3
                move.w  $22(a2,d0.w),d4
                move.w  d1,8(a0)
                move.w  d2,$A(a0)
                addi.w  #$800,d1
                addi.w  #$800,d2
                move.w  d2,4(a0)
                move.w  d1,6(a0)
                move.w  d3,8(a1)
                move.w  d4,$A(a1)
                addi.w  #$800,d3
                addi.w  #$800,d4
                move.w  d4,4(a1)
                move.w  d3,6(a1)
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_3BB70
                eori.w  #1,$29E(a5)
loc_3BB70:                              ; CODE XREF: Boss_JokerRenderBody+14E   j
                move.w  $29C(a5),d0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_3BB96
                tst.w   $29E(a5)
                bne.w   loc_3BB8C
                subq.w  #4,d0
                bpl.s   loc_3BB96
                moveq   #0,d0
                bra.s   loc_3BB96
; ---------------------------------------------------------------------------
loc_3BB8C:                              ; CODE XREF: Boss_JokerRenderBody+166   j
                addq.w  #4,d0
                cmpi.w  #$10,d0
                bmi.s   loc_3BB96
                moveq   #$C,d0
loc_3BB96:                              ; CODE XREF: Boss_JokerRenderBody+160   j
                                        ; Boss_JokerRenderBody+16C   j ...
                move.w  d0,$29C(a5)
                lea     word_3BC5A(pc),a2
                nop
                move.w  (a2,d0.w),d1
                move.w  2(a2,d0.w),d2
                move.w  $10(a2,d0.w),d3
                move.w  $12(a2,d0.w),d4
                move.w  d1,$C(a0)
                move.w  d2,$E(a0)
                addi.w  #$800,d1
                addi.w  #$800,d2
                move.w  d2,(a0)
                move.w  d1,2(a0)
                move.w  d3,$C(a1)
                move.w  d4,$E(a1)
                addi.w  #$800,d3
                addi.w  #$800,d4
                move.w  d4,(a1)
                move.w  d3,2(a1)
                move.l  #$8F02977F,d0
                move.l  #$94009308,d1
                movea.w (word_FFF70C).w,a4
                move.w  #$83,-(a4)
                move.w  #$6188,-(a4)
                move.w  #$9500,-(a4)
                move.w  #$96CB,-(a4)
                move.l  d0,-(a4)
                move.l  d1,-(a4)
                move.w  #$83,-(a4)
                move.w  #$6208,-(a4)
                move.w  #$9508,-(a4)
                move.w  #$96CB,-(a4)
                move.l  d0,-(a4)
                move.l  d1,-(a4)
                move.w  a4,(word_FFF70C).w
                rts
; End of function Boss_JokerRenderBody
; ---------------------------------------------------------------------------
word_3BC1A:     dc.w $E302, $E303, $E32E, $E330, $E332, $E334, $E336, $E338
                                        ; DATA XREF: Boss_JokerRenderBody+F8   o
                dc.w $E336, $E338, $E332, $E334, $E32E, $E330, $E302, $E303
                dc.w $E306, $E307, $E32F, $E331, $E333, $E335, $E337, $E339
                dc.w $E337, $E339, $E333, $E335, $E32F, $E331, $E306, $E307
word_3BC5A:     dc.w $E342, $E344, $E33E, $E340, $E33A, $E33C, $E304, $E305
                                        ; DATA XREF: Boss_JokerRenderBody+180   o
                dc.w $E343, $E345, $E33F, $E341, $E33B, $E33D, $E308, $E309


; Calculate Joker boss Y position based on horizontal offset
Boss_JokerCalculateYPosition:                              ; CODE XREF: Boss_JokerLandingImpact:loc_3B98A   p  ; was: sub_3BC7A
                                        ; Boss_JokerLandingImpact+A4   p
                move.w  $1DC(a5),d0
                subi.w  #$40,d0 ; '@'
                asr.w   #1,d0
                addi.w  #$C8,d0
                move.w  d0,$14(a5)
                rts
; End of function Boss_JokerCalculateYPosition
; Slows Joker boss horizontal velocity towards zero with fixed rate
Boss_JokerSlowHorizontal:                              ; CODE XREF: Boss_JokerStretchState:loc_3B874   p  ; was: sub_3BC8E
                move.l  $18(a5),d0
                beq.s   locret_3BCA4
                bmi.s   loc_3BCA6
                subi.l  #$2000,d0
                bpl.s   loc_3BCA0
loc_3BC9E:                              ; CODE XREF: Boss_JokerSlowHorizontal+1E   j
                moveq   #0,d0
loc_3BCA0:                              ; CODE XREF: Boss_JokerSlowHorizontal+E   j
                move.l  d0,$18(a5)
locret_3BCA4:                           ; CODE XREF: Boss_JokerSlowHorizontal+4   j
                rts
; ---------------------------------------------------------------------------
loc_3BCA6:                              ; CODE XREF: Boss_JokerSlowHorizontal+6   j
                addi.l  #$2000,d0
                bpl.s   loc_3BC9E
                move.l  d0,$18(a5)
                rts
; End of function Boss_JokerSlowHorizontal
; Updates Joker boss animation with interpolation for body parts
Boss_JokerUpdateAnimation:                              ; CODE XREF: Boss_JokerDefeatAnim+36   p  ; was: sub_3BCB4
                                        ; Boss_JokerFallingPhase2+2C   p ...
                clr.w   $3BC(a5)
                tst.w   $C(a5)
                bpl.s   loc_3BD36
loc_3BCBE:                              ; CODE XREF: Boss_JokerUpdateAnimation+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_3BD46
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_3BCE0
                move.b  1(a1,d0.w),d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_3BCE0:                              ; CODE XREF: Boss_JokerUpdateAnimation+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_3BCF0
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_3BCF0:                              ; CODE XREF: Boss_JokerUpdateAnimation+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_3BD00
                clr.w   $58(a5)
                clr.w   $35E(a5)
                bra.s   loc_3BCBE
; ---------------------------------------------------------------------------
loc_3BD00:                              ; CODE XREF: Boss_JokerUpdateAnimation+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3BF88,d0
                movea.l d0,a0
                bsr.w Boss_JokerCalcDeltas
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$35E(a5)
                addq.w  #1,$3BC(a5)
                tst.w   $C(a5)
                bmi.s   loc_3BD46
loc_3BD36:                              ; CODE XREF: Boss_JokerUpdateAnimation+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #9,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_3BD46:                              ; CODE XREF: Boss_JokerUpdateAnimation+E   j
                                        ; Boss_JokerUpdateAnimation+80   j
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #1,d6
                move.w  #$1FE,d7
                move.b  (a0),d0
                asl.w   d6,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.w  d0,$116(a5)
                move.b  4(a0),d1
                asl.w   d6,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.w  d1,$1D6(a5)
                move.b  8(a0),d0
                asl.w   d6,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  $C(a0),d1
                asl.w   d6,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$4D6(a5)
                move.w  d1,$536(a5)
                move.b  $10(a0),d0
                asl.w   d6,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d0,$296(a5)
                move.b  $14(a0),d1
                asl.w   d6,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$2F6(a5)
                move.w  d1,$356(a5)
                move.b  $18(a0),d0
                asl.w   d6,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.b  $1C(a0),d0
                asl.w   d6,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $20(a0),d1
                asl.w   d6,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $24(a0),d0
                asl.w   d6,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                rts
; End of function Boss_JokerUpdateAnimation
; Calculates interpolation deltas for smooth boss animation transitions
Boss_JokerCalcDeltas:                              ; CODE XREF: Boss_JokerUpdateAnimation+62   p  ; was: sub_3BDF4
                movea.l #word_350DC,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #9,d7
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_JokerCalcDeltas
; Load animation frame delays for Joker boss
Boss_JokerLoadFrameDelays:
                movea.w #(dword_FF9400-M68K_RAM),a1  ; was: sub_3BE0A
                moveq   #9,d7
                jmp Anim_LoadFrameDelays
; End of function Boss_JokerLoadFrameDelays
; Spawns bomb projectile during special attack with damage value
Boss_JokerSpawnBomb:                              ; CODE XREF: Boss_JokerSpinDive+42   p  ; was: sub_3BE16
                tst.w   $35C(a5)
                bne.s   locret_3BE82
                movea.w #(byte_FFD700-M68K_RAM),a0
                jsr     (loc_1C144).l
                bne.s   locret_3BE82
                subi.w  #$14,(word_FF8234).w
                move.w  #$198,(a0)
                move.w  #$8100,2(a0)
                move.w  #$436A,$E(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                move.b  #$20,$20(a0) ; ' '
                move.w  #$50,$24(a0) ; 'P'
                move.b  #$80,$21(a0)
                move.l  #$F808F808,$28(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addi.w  #$26,$14(a0) ; '&'
                move.w  #$C0,$48(a0)
                move.w  #4,$4A(a0)
locret_3BE82:                           ; CODE XREF: Boss_JokerSpawnBomb+4   j
                                        ; Boss_JokerSpawnBomb+10   j
                rts
; End of function Boss_JokerSpawnBomb
; Joker bomb projectile descending then firing directional shots
Projectile_JokerBomb:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3BE84
                tst.w   (word_FF808C).w
                bmi.s   loc_3BE92
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_3BE92:                              ; CODE XREF: Projectile_JokerBomb+4   j
                tst.w   $24(a5)
                bpl.s   loc_3BE9E
loc_3BE98:                              ; CODE XREF: Projectile_JokerBomb+68   j
                jmp Enemy_SpawnQuadProjectiles
; ---------------------------------------------------------------------------
loc_3BE9E:                              ; CODE XREF: Projectile_JokerBomb+12   j
                cmpi.w  #$148,$14(a5)
                bpl.s   loc_3BEB0
                addq.w  #2,$14(a5)
                move.w  (dword_FFC630).w,$10(a5)
loc_3BEB0:                              ; CODE XREF: Projectile_JokerBomb+20   j
                subq.w  #1,$48(a5)
                bpl.s   loc_3BEF0
                movea.w #(byte_FFD400-M68K_RAM),a0
                jsr     (loc_1C144).l
                bne.s   loc_3BEE8
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$8004,d2
                jsr (Enemy_InitDirectionalProjectile).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$50,d0 ; 'P'
                move.w  d0,$48(a5)
loc_3BEE8:                              ; CODE XREF: Projectile_JokerBomb+3C   j
                subq.w  #1,$4A(a5)
                bmi.s   loc_3BE98
locret_3BEEE:                           ; CODE XREF: Projectile_JokerBomb+78   j
                                        ; Projectile_JokerBomb+86   j
                rts
; ---------------------------------------------------------------------------
loc_3BEF0:                              ; CODE XREF: Projectile_JokerBomb+30   j
                move.w  #$F8F8,$A(a5)
                cmpi.w  #$30,$48(a5) ; '0'
                bpl.s   locret_3BEEE
                move.w  #$F7F8,$A(a5)
                btst    #1,(word_FFA000+1).w
                bne.s   locret_3BEEE
                move.w  #$F9F8,$A(a5)
                rts
; End of function Projectile_JokerBomb
; ---------------------------------------------------------------------------
word_3BF14:     dc.w $1818, 0, $814, $A, $1919, $A, $1818, 0, $814, $A, $1919, $A, $FFFF
                                        ; DATA XREF: Boss_JokerDefeatAnim:loc_3B464   o
word_3BF2E:     dc.w $2020, $14, $2020, $1E, $FFFF
                                        ; DATA XREF: Boss_JokerInitTauntState+1C   o
word_3BF38:     dc.w $1018, $28, $2424, $28, $FFFE
                                        ; DATA XREF: Boss_JokerDivePrep+6   o
                                        ; Boss_JokerLandingState+E   o
word_3BF42:     dc.w $E12, $32, $1C1C, $32, $FFFE
                                        ; DATA XREF: Boss_JokerDivePrep+8A   o
word_3BF4C:     dc.w $E38, $3C, $E0E, $3C, $FFFE
                                        ; DATA XREF: Boss_JokerSpinDive+A   o
                                        ; Boss_JokerGroundBounceAttack+1C   o
word_3BF56:     dc.w $F0F, $32, $FFFE   ; DATA XREF: Boss_JokerLandingImpact+20   o
word_3BF5C:     dc.w $80C, $3C, $2424, $3C, $FFFE
                                        ; DATA XREF: Boss_JokerLandingImpact+7A   o
word_3BF66:     dc.w $6868, $32, $FFFE  ; DATA XREF: Boss_JokerLandingImpact+A8   o
word_3BF6C:     dc.w $508, $28, $1616, $28, $810, $1E, $2020, $1E, $FFFE
                                        ; DATA XREF: Boss_JokerStretchState+2A   o
word_3BF7E:     dc.w $E0E, $5A, $E0E, $64, $FFFF
                                        ; DATA XREF: Boss_JokerFallingPhase2:loc_3B5C6   o
word_3BF88:     dc.w $40D8, $4028, $64F0, $301C, $10D0, $7000, $C060, $78FA
                                        ; DATA XREF: Boss_JokerUpdateAnimation+5A   o
                dc.w $3CF0, $68A8, $40F0, $4010, $9098, $58F0, $68A8, $80B0
                dc.w $50, $78B4, $5808, $4CA8, $9020, $F0E0, $A890, $48D8
                dc.w $70B8, $2000, $6000, $30F8, $2050, $8E0, $9010, $F0F0
                dc.w $70E0, $5810, $20A8, $40F0, $4010, $30F8, $5050, $8B0
                dc.w $6810, $18F0, $8010, $2000, $F0E0, $A020, $2020, $9090
                dc.w $58D0, $20A0, $60E0, $E0E0, $B0E0, $60F0, $7098


; Main Flying-Neo boss handler with state dispatch
Boss_FlyingNeoMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3BFF6
                tst.w   4(a5)
                beq.w Boss_FlyingNeoStateDispatch
                tst.w   $23C(a5)
                bmi.s   loc_3C00C
                beq.s   loc_3C00C
                bclr    #0,(byte_FF80EC).w
loc_3C00C:                              ; CODE XREF: Boss_FlyingNeoMain+C   j
                                        ; Boss_FlyingNeoMain+E   j
                lea     (word_3E12).l,a2
                jsr (Gfx_ProcessColorFade).l
                tst.w   8(a5)
                beq.s Boss_FlyingNeoStateDispatch
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3C08C
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3C08C
                tst.w   $23C(a5)
                bmi.s   loc_3C084
                beq.s   loc_3C05A
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_3C084
                move.w  #$620,d0
                lea     (word_3E12).l,a2
                jsr (Gfx_FadeToTargetColor).l
                bne.s   loc_3C084
                move.w  #$FFFF,$23C(a5)
                bra.s   loc_3C084
; ---------------------------------------------------------------------------
loc_3C05A:                              ; CODE XREF: Boss_FlyingNeoMain+3E   j
                move.w  #$2580,d0
                tst.w   (word_FFFF0E).w
                beq.s   loc_3C068
                move.w  #$3880,d0
loc_3C068:                              ; CODE XREF: Boss_FlyingNeoMain+6C   j
                cmp.w   (word_FF8200).w,d0
                bmi.s   loc_3C084
                cmpi.w  #$2380,(word_FF8200).w
                bpl.s   loc_3C07E
                move.w  #1,$23C(a5)
                bra.s   loc_3C084
; ---------------------------------------------------------------------------
loc_3C07E:                              ; CODE XREF: Boss_FlyingNeoMain+7E   j
                move.w  #2,(word_FF8246).w
loc_3C084:                              ; CODE XREF: Boss_FlyingNeoMain+3C   j
                                        ; Boss_FlyingNeoMain+48   j ...
                tst.w   (word_FF8200).w
                beq.w Boss_FlyingNeoDefeatInit
loc_3C08C:                              ; CODE XREF: Boss_FlyingNeoMain+2E   j
                                        ; Boss_FlyingNeoMain+36   j
                move.w  (dword_FFA900).w,d0
                add.w   $430(a5),d0
                move.w  d0,$BC(a5)
; State dispatcher for Flying Neo boss using jump table
Boss_FlyingNeoStateDispatch:                              ; CODE XREF: Boss_FlyingNeoMain+4   j  ; was: loc_3C098
                                        ; Boss_FlyingNeoMain+26   j
                move.w  4(a5),d0
                movea.w off_3C0A8(pc,d0.w),a0
                adda.l  #Boss_FlyingNeoInit,a0
                jmp     (a0)
; End of function Boss_FlyingNeoMain
; ---------------------------------------------------------------------------
off_3C0A8:      dc.w Boss_FlyingNeoInit-Boss_FlyingNeoInit
                                        ; DATA XREF: Boss_FlyingNeoMain+A6   r
                dc.w Boss_FlyingNeoWaitStart-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoSetup-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoIntroWait-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoBattleActive-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoBattleDelay-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoDefeatState1-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoDefeatState2-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoDefeatState3-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoDefeatState4-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoDefeatFinal-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoDefeat_UpdateScroll-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoPlayerControlled-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoAttackPatternUpdate-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoSwoopAttack-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoHoverDecision-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoHover_HorizontalMovement-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoDivePhase-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoDive_DiveInitiated-Boss_FlyingNeoInit
                dc.w Boss_FlyingNeoHover_WingAnimation-Boss_FlyingNeoInit


; Initializes Flying-Neo boss clearing sprites
Boss_FlyingNeoInit:                              ; DATA XREF: Boss_FlyingNeoMain+AA   o  ; was: sub_3C0D0
                                        ; ROM:off_3C0A8   o ...
                addq.w  #2,4(a5)
                move.w  #1,8(a5)
                move.w  #$154,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                movea.w #(word_FF9900-M68K_RAM),a0
                moveq   #$C,d0
                jsr (Math_CalculateSineCosineTable).l
                bsr.s Boss_FlyingNeoClearPalettes
                move.l  #dword_11346,(dword_FFA940).w
                move.w  #$F00,(word_FFA946).w
                move.w  #$F760,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
locret_3C10E:                           ; CODE XREF: Boss_FlyingNeoWaitStart+6   j
                rts
; End of function Boss_FlyingNeoInit
; Clears boss palette entries for initialization
Boss_FlyingNeoClearPalettes:                              ; CODE XREF: Stage_InitStage8Palettes:loc_1233A   p  ; was: sub_3C110
                                        ; Boss_FlyingNeoInit+22   p
                lea     (word_FF4020).l,a0
                move.w  #$7FFF,d0
                move.w  #$EF,d7
loc_3C11E:                              ; CODE XREF: Boss_FlyingNeoClearPalettes+10   j
                and.w   d0,(a0)+
                dbf     d7,loc_3C11E
                lea     (word_FF4AC0).l,a0
                move.w  #$F,d7
loc_3C12E:                              ; CODE XREF: Boss_FlyingNeoClearPalettes+20   j
                and.w   d0,(a0)+
                dbf     d7,loc_3C12E
                lea     (word_FF4360).l,a0
                move.w  #$2F,d7 ; '/'
loc_3C13E:                              ; CODE XREF: Boss_FlyingNeoClearPalettes+30   j
                and.w   d0,(a0)+
                dbf     d7,loc_3C13E
                lea     (word_FF4400).l,a0
                move.w  #$2F,d7 ; '/'
loc_3C14E:                              ; CODE XREF: Boss_FlyingNeoClearPalettes+40   j
                and.w   d0,(a0)+
                dbf     d7,loc_3C14E
                rts
; End of function Boss_FlyingNeoClearPalettes
; Waits for battle start checking player ready
Boss_FlyingNeoWaitStart:                              ; DATA XREF: ROM:0003C0AA   o  ; was: sub_3C156
                jsr (Gfx_RenderScrollingBackground).l
                bpl.s   locret_3C10E
                addq.w  #2,4(a5)
                clr.w   (word_FF808A).w
                rts
; End of function Boss_FlyingNeoWaitStart
; Complex setup with metasprite and palette initialization
Boss_FlyingNeoSetup:                              ; DATA XREF: ROM:0003C0AC   o  ; was: sub_3C168
                movea.w #(word_FFC680-M68K_RAM),a4
                move.w  #$300,(dword_FF8040).w
                moveq   #8,d7
                movea.l #dword_34F46,a0
                movea.l #word_34F6A,a1
                movea.l #word_34F74,a2
                jsr (Sprite_InitMetaspriteComplex).l
                clr.w   $54(a5)
                clr.w   $56(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$D00,2(a5)
                bset    #0,$1E2(a5)
                bset    #0,$362(a5)
                move.w  #$10,d0
                moveq   #8,d1
                move.w  #$8080,d2
                movea.w #(word_FFC9E0-M68K_RAM),a0
                move.w  d0,(a0)
                move.w  #$C080,2(a0)
                move.w  #$4300,$E(a0)
                move.l  #word_EBBB8,8(a0)
                move.b  #$18,$20(a0)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  d0,(a0)
                move.w  #$8080,2(a0)
                move.w  #$6398,$E(a0)
                move.w  #$D00,8(a0)
                move.b  #$18,$20(a0)
                movea.w #(word_FFCA40-M68K_RAM),a0
                lea     word_3CEF0(pc),a1
                nop
                moveq   #2,d7
                bsr.w Boss_FlyingNeoInitSprites
                lea     word_3CEF6(pc),a1
                nop
                moveq   #1,d7
                bsr.w Boss_FlyingNeoInitSprites
                lea     word_3CEFC(pc),a1
                nop
                moveq   #1,d7
                bsr.w Boss_FlyingNeoInitSprites
                lea     word_3CF02(pc),a1
                nop
                moveq   #1,d7
                bsr.w Boss_FlyingNeoInitSprites
                movea.l #word_1BB94,a1
                jsr (Sprite_InitFromPointerTable).l
                lea     (byte_C330).l,a0
                jsr (Gfx_SyncPaletteBuffers).l
                lea     (word_3E12).l,a2
                jsr (Gfx_ClearColorFadeState).l
                move.w  #$28,(word_FFF74A).w ; '('
                clr.w   (word_FFF74E).w
                move.w  #$C,(word_FF8090).w
                move.b  #3,(byte_FFA95B).w
                move.w  #6,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #2,$17E(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$80,$1DE(a5)
                clr.w   $54(a5)
                move.w  #$138,$10(a5)
                move.w  #$20,$14(a5) ; ' '
                bsr.w Boss_FlyingNeoFlipDirection
; End of function Boss_FlyingNeoSetup
; Intro wait state decrementing timer
Boss_FlyingNeoIntroWait:                              ; DATA XREF: ROM:0003C0AE   o  ; was: sub_3C29C
                subq.w  #1,$1DE(a5)
                bmi.s Boss_FlyingNeoStartBattle
loc_3C2A2:                              ; CODE XREF: Boss_FlyingNeoBattleActive+4   j
                                        ; Boss_FlyingNeoBattleActive+1E   j
                bsr.w Boss_FlyingNeoMovementAI
                lea     word_3D00A(pc),a1
                nop
                bsr.w Boss_FlyingNeoProcessAnimation
                bra.w Boss_FlyingNeoUpdateSprites
; ---------------------------------------------------------------------------
; Starts battle mode checking victory condition
Boss_FlyingNeoStartBattle:                              ; CODE XREF: Boss_FlyingNeoIntroWait+4   j  ; was: loc_3C2B4
                addq.w  #2,4(a5)
                moveq   #7,d0
                jsr (UI_CheckVictoryCondition).l
; End of function Boss_FlyingNeoIntroWait
; Active battle state with attack pattern dispatch
Boss_FlyingNeoBattleActive:                              ; DATA XREF: ROM:0003C0B0   o  ; was: sub_3C2C0
                tst.w   (word_FF80C2).w
                bne.s   loc_3C2A2
                addq.w  #2,4(a5)
                move.w  #$30,$1DE(a5) ; '0'
                subi.w  #$A0,(word_FFA970).w
                clr.b   (byte_FF80EC).w
; Battle delay timer before transitioning to attack pattern
Boss_FlyingNeoBattleDelay:                              ; DATA XREF: ROM:0003C0B2   o  ; was: loc_3C2DA
                subq.w  #1,$1DE(a5)
                bpl.s   loc_3C2A2
                bra.w Boss_FlyingNeoInitAttackPattern
; End of function Boss_FlyingNeoBattleActive
; Initializes boss defeat sequence clearing flags
Boss_FlyingNeoDefeatInit:                              ; CODE XREF: Boss_FlyingNeoMain+92   j  ; was: sub_3C2E4
                move.w  #$C,4(a5)
                clr.w   8(a5)
                clr.w   $48(a5)
                move.w  #$C6E0,$4A(a5)
                bsr.w Boss_FlyingNeoSetEntityFlags
                clr.l   $18(a5)
                clr.l   $1C(a5)
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr (Sprite_ClearObjectFlags).l
                move.w  #4,(word_FF808C).w
; End of function Boss_FlyingNeoDefeatInit
; Defeat state spawning parts upward with timer
Boss_FlyingNeoDefeatState1:                              ; DATA XREF: ROM:0003C0B4   o  ; was: sub_3C31C
                bsr.w Boss_FlyingNeoUpdatePaletteFade
                bsr.w Boss_FlyingNeoCalculateCenter
                bsr.w Boss_FlyingNeoUpdateScroll
                subq.w  #1,$48(a5)
                bpl.s   locret_3C354
                move.w  #5,$48(a5)
                movea.w $4A(a5),a0
                addi.w  #$60,$4A(a5) ; '`'
                cmpi.w  #$C9E0,$4A(a5)
                bmi.s   loc_3C350
                addq.w  #2,4(a5)
                move.w  #$CD40,$4A(a5)
loc_3C350:                              ; CODE XREF: Boss_FlyingNeoDefeatState1+28   j
                bsr.w Boss_FlyingNeoSpawnDefeatParticle
locret_3C354:                           ; CODE XREF: Boss_FlyingNeoDefeatState1+10   j
                rts
; End of function Boss_FlyingNeoDefeatState1
; Set entity flags across multiple Flying-Neo entities
Boss_FlyingNeoSetEntityFlags:                              ; CODE XREF: Boss_FlyingNeoDefeatInit+14   p  ; was: sub_3C356
                moveq   #0,d0
                movea.w #(word_FFC682-M68K_RAM),a0
                moveq   #$12,d7
loc_3C35E:                              ; CODE XREF: Boss_FlyingNeoSetEntityFlags+E   j
                bset    d0,(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3C35E
                rts
; End of function Boss_FlyingNeoSetEntityFlags
; Spawns defeat particle with velocity and sound
Boss_FlyingNeoSpawnDefeatParticle:                              ; CODE XREF: Boss_FlyingNeoDefeatState1:loc_3C350   p  ; was: sub_3C36A
                                        ; sub_3C3AE:loc_3C3DC   p
                movea.l #dword_2ABF0,a1 ; make offsets?
                jsr (Sprite_InitFromTable).l
                clr.l   $18(a0)
                move.l  #$FFFEE000,$1C(a0)
                clr.b   $20(a0)
                move.b  #$BC,d0
                jmp (Sound_PlaySFX).l
; End of function Boss_FlyingNeoSpawnDefeatParticle
; Calculates boss center position for collision
Boss_FlyingNeoCalculateCenter:                              ; CODE XREF: Boss_FlyingNeoDefeatState1+4   p  ; was: sub_3C390
                                        ; Boss_FlyingNeoDefeatState2+4   p ...
                moveq   #$E,d0
                moveq   #$1C,d1
                tst.w   $54(a5)
                beq.s   loc_3C39C
                moveq   #$10,d0
loc_3C39C:                              ; CODE XREF: Boss_FlyingNeoCalculateCenter+8   j
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$70(a5)
                move.w  d1,$74(a5)
                rts
; End of function Boss_FlyingNeoCalculateCenter
; Defeat state spawning parts downward
Boss_FlyingNeoDefeatState2:                              ; DATA XREF: ROM:0003C0B6   o  ; was: sub_3C3AE
                bsr.w Boss_FlyingNeoUpdatePaletteFade
                bsr.w Boss_FlyingNeoCalculateCenter
                bsr.w Boss_FlyingNeoUpdateScroll
                subq.w  #1,$48(a5)
                bpl.s   locret_3C3E0
                move.w  #4,$48(a5)
                movea.w $4A(a5),a0
                subi.w  #$60,$4A(a5) ; '`'
                cmpi.w  #$C9E0,$4A(a5)
                bne.s   loc_3C3DC
                addq.w  #2,4(a5)
loc_3C3DC:                              ; CODE XREF: Boss_FlyingNeoDefeatState2+28   j
                bsr.w Boss_FlyingNeoSpawnDefeatParticle
locret_3C3E0:                           ; CODE XREF: Boss_FlyingNeoDefeatState2+10   j
                rts
; End of function Boss_FlyingNeoDefeatState2
; Defeat state preparing final explosion effects
Boss_FlyingNeoDefeatState3:                              ; DATA XREF: ROM:0003C0B8   o  ; was: sub_3C3E2
                bsr.w Boss_FlyingNeoUpdatePaletteFade
                bsr.w Boss_FlyingNeoCalculateCenter
                bsr.w Boss_FlyingNeoUpdateScroll
                subq.w  #1,$48(a5)
                bpl.s   locret_3C426
                addq.w  #2,4(a5)
                move.w  #$70,$48(a5) ; 'p'
                bsr.w Boss_FlyingNeoDMAScrollWrite
                movea.w #(word_FFC9E0-M68K_RAM),a0
                move.l  #off_E953C,8(a0)
                move.l  #$FFFEE000,$18(a0)
                tst.w   $54(a5)
                beq.s   loc_3C420
                neg.l   $18(a0)
loc_3C420:                              ; CODE XREF: Boss_FlyingNeoDefeatState3+38   j
                jmp Projectile_InitType88
; ---------------------------------------------------------------------------
locret_3C426:                           ; CODE XREF: Boss_FlyingNeoDefeatState3+10   j
                rts
; End of function Boss_FlyingNeoDefeatState3
; Defeat state firing particle rain with sound
Boss_FlyingNeoDefeatState4:                              ; DATA XREF: ROM:0003C0BA   o  ; was: sub_3C428
                bsr.w Boss_FlyingNeoUpdatePaletteFade
                bsr.w Boss_FlyingNeoCalculateCenter
                bsr.w Boss_FlyingNeoUpdateScroll
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3C4A6
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_3C4A6
                move.l  #off_E953C,8(a0)
                move.l  #$FFFF1000,$1C(a0)
                jsr (Projectile_InitType88).l
                clr.b   $20(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0 ; '?'
                andi.w  #$1F,d1
                subi.w  #$20,d0 ; ' '
                subi.w  #$10,d1
                add.w   $10(a5),d0
                tst.w   $54(a5)
                beq.s   loc_3C486
                addi.w  #$20,d0 ; ' '
loc_3C486:                              ; CODE XREF: Boss_FlyingNeoDefeatState4+58   j
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_3C4A6
                move.b  #$BC,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
loc_3C4A6:                              ; CODE XREF: Boss_FlyingNeoDefeatState4+14   j
                                        ; Boss_FlyingNeoDefeatState4+1C   j ...
                subq.w  #1,$48(a5)
                bpl.s   locret_3C4C8
                addq.w  #2,4(a5)
                move.w  #$10,$48(a5)
                move.w  #$1000,$62(a5)
                lea     word_3CEA0(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
locret_3C4C8:                           ; CODE XREF: Boss_FlyingNeoDefeatState4+82   j
                rts
; End of function Boss_FlyingNeoDefeatState4
; Final defeat state advancing to next stage
Boss_FlyingNeoDefeatFinal:                              ; DATA XREF: ROM:0003C0BC   o  ; was: sub_3C4CA
                subq.w  #1,$48(a5)
                bpl.s Boss_FlyingNeoDefeat_UpdateScroll
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
                move.w  #$5C,(word_FF80C2).w ; '\'
; Updates scroll during final defeat sequence
Boss_FlyingNeoDefeat_UpdateScroll:                              ; CODE XREF: Boss_FlyingNeoDefeatFinal+4   j  ; was: loc_3C4DE
                                        ; DATA XREF: ROM:0003C0BE   o
                bra.w Boss_FlyingNeoUpdateScroll
; End of function Boss_FlyingNeoDefeatFinal
; Flying-Neo boss player control input handler
Boss_FlyingNeoPlayerControlled:                              ; DATA XREF: ROM:0003C0C0   o  ; was: sub_3C4E2
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $23E(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                btst    #0,(word_FFF706).w
                beq.s   loc_3C50A
                move.w  #$FFFF,$1C(a5)
                move.w  #$FFE0,$23E(a5)
loc_3C50A:                              ; CODE XREF: Boss_FlyingNeoPlayerControlled+1A   j
                btst    #1,(word_FFF706).w
                beq.s   loc_3C51E
                move.w  #1,$1C(a5)
                move.w  #$20,$23E(a5) ; ' '
loc_3C51E:                              ; CODE XREF: Boss_FlyingNeoPlayerControlled+2E   j
                btst    #3,(word_FFF706).w
                beq.s   loc_3C536
                move.w  #2,$18(a5)
                move.w  #$100,$54(a5)
                bsr.w Boss_FlyingNeoFlipDirection
loc_3C536:                              ; CODE XREF: Boss_FlyingNeoPlayerControlled+42   j
                btst    #2,(word_FFF706).w
                beq.s   loc_3C54E
                move.w  #$FFFE,$18(a5)
                move.w  #0,$54(a5)
                bsr.w Boss_FlyingNeoFlipDirection
loc_3C54E:                              ; CODE XREF: Boss_FlyingNeoPlayerControlled+5A   j
                lea     word_3D00A(pc),a1
                nop
                bsr.w Boss_FlyingNeoProcessAnimation
                bra.w Boss_FlyingNeoUpdateSprites
; End of function Boss_FlyingNeoPlayerControlled
; Initializes attack pattern state with timer
Boss_FlyingNeoInitAttackPattern:                              ; CODE XREF: Boss_FlyingNeoBattleActive+20   j  ; was: sub_3C55C
                                        ; Boss_FlyingNeoHoverDecision+12   j
                move.w  #$1A,4(a5)
                clr.w   $17E(a5)
                clr.w   $1DC(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3FF,d0
                addi.w  #$40,d0 ; '@'
                move.w  d0,$1DE(a5)
; Sets up attack slot pointers and sprite data
Boss_FlyingNeoSetupAttackSlots:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+152   j  ; was: loc_3C57A
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #word_EBC18,$1E8(a5)
                move.l  #word_EBC18,$368(a5)
; End of function Boss_FlyingNeoInitAttackPattern
; Updates attack pattern with movement and animations
Boss_FlyingNeoAttackPatternUpdate:                              ; DATA XREF: ROM:0003C0C2   o  ; was: sub_3C592
                subq.w  #1,$1DE(a5)
                bmi.w Boss_FlyingNeoResetAttack
                bsr.w Boss_FlyingNeoMovementAI
                bsr.w Boss_FlyingNeoCalculateDistance
                bsr.s Boss_FlyingNeoAttackMovement
                cmpi.w  #$1A,4(a5)
                beq.s   loc_3C5AE
                rts
; ---------------------------------------------------------------------------
loc_3C5AE:                              ; CODE XREF: Boss_FlyingNeoAttackPatternUpdate+18   j
                lea     word_3D00A(pc),a1
                nop
                bsr.w Boss_FlyingNeoProcessAnimation
                bra.w Boss_FlyingNeoUpdateSprites
; End of function Boss_FlyingNeoAttackPatternUpdate
; Handles attack movement with horizontal acceleration
Boss_FlyingNeoAttackMovement:                              ; CODE XREF: Boss_FlyingNeoAttackPatternUpdate+10   p  ; was: sub_3C5BC
                move.b  (dword_FFFF08+1).w,d5
                move.b  (dword_FFFF08).w,d6
                move.w  (word_FFA000).w,d7
                asr.w   #2,d7
                andi.w  #$40,d7 ; '@'
                add.w   d7,d0
                tst.w   $54(a5)
                beq.w   loc_3C61C
                tst.w   d1
                bmi.w Boss_FlyingNeoResetAttack
                tst.w   $1DC(a5)
                bne.s   loc_3C5FC
                cmpi.l  #$2C000,$18(a5)
                bpl.s   loc_3C5F6
                addi.l  #$3200,$18(a5)
loc_3C5F6:                              ; CODE XREF: Boss_FlyingNeoAttackMovement+30   j
                bsr.w Boss_FlyingNeoCheckAttackCondition
                rts
; ---------------------------------------------------------------------------
loc_3C5FC:                              ; CODE XREF: Boss_FlyingNeoAttackMovement+26   j
                subq.w  #1,$11C(a5)
                bpl.s   loc_3C608
loc_3C602:                              ; CODE XREF: Boss_FlyingNeoAttackMovement+8E   j
                clr.w   $1DC(a5)
                rts
; ---------------------------------------------------------------------------
loc_3C608:                              ; CODE XREF: Boss_FlyingNeoAttackMovement+44   j
                cmpi.l  #$FFFC2000,$18(a5)
                bmi.s   locret_3C61A
                addi.l  #-$4200,$18(a5)
locret_3C61A:                           ; CODE XREF: Boss_FlyingNeoAttackMovement+54   j
                rts
; ---------------------------------------------------------------------------
loc_3C61C:                              ; CODE XREF: Boss_FlyingNeoAttackMovement+18   j
                tst.w   d1
                bpl.w Boss_FlyingNeoResetAttack
                tst.w   $1DC(a5)
                bne.s   loc_3C646
                cmpi.l  #$FFFD4000,$18(a5)
                bmi.s   loc_3C63A
                addi.l  #-$3200,$18(a5)
loc_3C63A:                              ; CODE XREF: Boss_FlyingNeoAttackMovement+74   j
                cmpi.w  #$E4,d0
                bpl.s   locret_3C644
                bsr.w Boss_FlyingNeoCheckAttackCondition
locret_3C644:                           ; CODE XREF: Boss_FlyingNeoAttackMovement+82   j
                rts
; ---------------------------------------------------------------------------
loc_3C646:                              ; CODE XREF: Boss_FlyingNeoAttackMovement+6A   j
                subq.w  #1,$11C(a5)
                bmi.s   loc_3C602
                cmpi.l  #$3E000,$18(a5)
                bpl.s   locret_3C65E
                addi.l  #$4200,$18(a5)
locret_3C65E:                           ; CODE XREF: Boss_FlyingNeoAttackMovement+98   j
                rts
; End of function Boss_FlyingNeoAttackMovement
; Checks conditions to trigger attack state
Boss_FlyingNeoCheckAttackCondition:                              ; CODE XREF: Boss_FlyingNeoAttackMovement:loc_3C5F6   p  ; was: sub_3C660
                                        ; Boss_FlyingNeoAttackMovement+84   p
                cmpi.w  #$D4,d0
                bpl.s   locret_3C686
                move.w  (word_FFA000).w,d0
                btst    #9,d0
                beq.s   loc_3C678
                andi.w  #1,d0
                beq.w   loc_3C7D6
loc_3C678:                              ; CODE XREF: Boss_FlyingNeoCheckAttackCondition+E   j
                addq.w  #2,$1DC(a5)
                andi.w  #$F,d6
                addq.w  #3,d6
                move.w  d6,$11C(a5)
locret_3C686:                           ; CODE XREF: Boss_FlyingNeoCheckAttackCondition+4   j
                rts
; End of function Boss_FlyingNeoCheckAttackCondition
; Movement AI with position tracking and boundaries
Boss_FlyingNeoMovementAI:                              ; CODE XREF: Boss_FlyingNeoIntroWait:loc_3C2A2   p  ; was: sub_3C688
                                        ; Boss_FlyingNeoAttackPatternUpdate+8   p
                move.w  $14(a5),d7
                move.l  $1C(a5),d6
                move.w  (dword_FFFF08).w,d0
                tst.w   $17E(a5)
                bne.w   loc_3C6C6
loc_3C69C:                              ; CODE XREF: Boss_FlyingNeoMovementAI+48   j
                                        ; Boss_FlyingNeoMovementAI+54   j
                clr.w   $17E(a5)
                cmpi.w  #$B0,d7
                bmi.s   loc_3C6C6
                cmpi.w  #$C6,d7
                bpl.s   loc_3C6B2
                andi.w  #7,d0
                beq.s   loc_3C6C6
loc_3C6B2:                              ; CODE XREF: Boss_FlyingNeoMovementAI+22   j
                cmpi.l  #$FFFEE000,d6
                bmi.s   locret_3C6C4
                addi.l  #-$1E00,d6
                move.l  d6,$1C(a5)
locret_3C6C4:                           ; CODE XREF: Boss_FlyingNeoMovementAI+30   j
                                        ; Boss_FlyingNeoMovementAI+5C   j
                rts
; ---------------------------------------------------------------------------
loc_3C6C6:                              ; CODE XREF: Boss_FlyingNeoMovementAI+10   j
                                        ; Boss_FlyingNeoMovementAI+1C   j ...
                move.w  #2,$17E(a5)
                cmpi.w  #$DC,d7
                bpl.s   loc_3C69C
                cmpi.w  #$C6,d7
                bmi.s   loc_3C6DE
                andi.w  #7,d0
                beq.s   loc_3C69C
loc_3C6DE:                              ; CODE XREF: Boss_FlyingNeoMovementAI+4E   j
                cmpi.l  #$12000,d6
                bpl.s   locret_3C6C4
                addi.l  #$1E00,d6
                move.l  d6,$1C(a5)
                rts
; End of function Boss_FlyingNeoMovementAI
; Resets attack state clearing velocity and animation
Boss_FlyingNeoResetAttack:                              ; CODE XREF: Boss_FlyingNeoAttackPatternUpdate+4   j  ; was: sub_3C6F2
                                        ; Boss_FlyingNeoAttackMovement+1E   j ...
                move.w  #$1C,4(a5)
                move.l  #word_EBC18,$1E8(a5)
                move.l  #word_EBC18,$368(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; End of function Boss_FlyingNeoResetAttack
; Swoop attack with horizontal velocity and position check
Boss_FlyingNeoSwoopAttack:                              ; DATA XREF: ROM:0003C0C4   o  ; was: sub_3C71A
                subi.l  #$E00,$1C(a5)
                tst.w   $54(a5)
                bne.s   loc_3C746
                cmpi.w  #$E80,$BC(a5)
                bmi.w   loc_3C770
                cmpi.l  #$FFFAA000,$18(a5)
                bmi.s   loc_3C762
                addi.l  #-$4200,$18(a5)
                bra.s   loc_3C762
; ---------------------------------------------------------------------------
loc_3C746:                              ; CODE XREF: Boss_FlyingNeoSwoopAttack+C   j
                cmpi.w  #$1120,$BC(a5)
                bpl.w   loc_3C770
                cmpi.l  #$56000,$18(a5)
                bpl.s   loc_3C762
                addi.l  #$4200,$18(a5)
loc_3C762:                              ; CODE XREF: Boss_FlyingNeoSwoopAttack+20   j
                                        ; Boss_FlyingNeoSwoopAttack+2A   j ...
                lea     word_3D01C(pc),a1
                nop
                bsr.w Boss_FlyingNeoProcessAnimation
                bra.w Boss_FlyingNeoUpdateSprites
; ---------------------------------------------------------------------------
loc_3C770:                              ; CODE XREF: Boss_FlyingNeoSwoopAttack+14   j
                                        ; Boss_FlyingNeoSwoopAttack+32   j
                move.w  #$1E,4(a5)
                move.w  #$C0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                addi.w  #$20,d0 ; ' '
                move.w  d0,$1DE(a5)
                clr.w   $54(a5)
                cmpi.w  #$FD0,$BC(a5)
                bpl.s   loc_3C7AE
                move.w  #$100,$54(a5)
loc_3C7AE:                              ; CODE XREF: Boss_FlyingNeoSwoopAttack+8C   j
                bsr.w Boss_FlyingNeoFlipDirection
; End of function Boss_FlyingNeoSwoopAttack
; Hover decision state choosing next attack pattern
Boss_FlyingNeoHoverDecision:                              ; DATA XREF: ROM:0003C0C6   o  ; was: sub_3C7B2
                subq.w  #1,$1DE(a5)
                bpl.s   loc_3C7C8
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                beq.w   loc_3C92E
                bra.w Boss_FlyingNeoInitAttackPattern
; ---------------------------------------------------------------------------
loc_3C7C8:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+4   j
                lea     word_3D00A(pc),a1
                nop
                bsr.w Boss_FlyingNeoProcessAnimation
                bra.w Boss_FlyingNeoUpdateSprites
; ---------------------------------------------------------------------------
loc_3C7D6:                              ; CODE XREF: Boss_FlyingNeoCheckAttackCondition+14   j
                move.w  #$20,4(a5) ; ' '
                move.l  #$FFFD0000,$1C(a5)
                clr.w   6(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Flying Neo hover state with horizontal velocity
Boss_FlyingNeoHover_HorizontalMovement:                              ; DATA XREF: ROM:0003C0C8   o  ; was: loc_3C7F2
                cmpi.w  #$A0,$14(a5)
                bmi.s   loc_3C84E
                tst.w   $54(a5)
                beq.s   loc_3C81C
                cmpi.l  #$FFFDE000,$18(a5)
                bmi.s   loc_3C812
                addi.l  #-$2200,$18(a5)
loc_3C812:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+56   j
                move.l  #$FFFDE000,$18(a5)
                bra.s   loc_3C836
; ---------------------------------------------------------------------------
loc_3C81C:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+4C   j
                cmpi.l  #$22000,$18(a5)
                bpl.s   loc_3C82E
                addi.l  #$2200,$18(a5)
loc_3C82E:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+72   j
                move.l  #$22000,$18(a5)
loc_3C836:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+68   j
                lea     word_3D054(pc),a1
                nop
                bsr.w Boss_FlyingNeoProcessAnimation
                bsr.w Boss_FlyingNeoUpdateSprites
                move.l  #word_EBBCA,$3C8(a5)
                rts
; ---------------------------------------------------------------------------
loc_3C84E:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+46   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                move.w  #$E000,$11C(a5)
                tst.w   $54(a5)
                beq.s Boss_FlyingNeoDivePhase
                neg.w   $11C(a5)
; Dive phase with velocity accumulation and sound effects
Boss_FlyingNeoDivePhase:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+B8   j  ; was: loc_3C870
                                        ; DATA XREF: ROM:0003C0CA   o
                cmpi.w  #$D8,$14(a5)
                bpl.s   loc_3C8DE
                move.w  $11C(a5),d0
                ext.l   d0
                add.l   d0,$18(a5)
                cmpi.l  #$40000,$1C(a5)
                bpl.s   loc_3C894
                addi.l  #$4800,$1C(a5)
loc_3C894:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+D8   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_3C8A8
                move.b  #$D1,d0
                jsr (Sound_PlaySFX).l
loc_3C8A8:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+EA   j
                lea     word_3D05E(pc),a1
                nop
loc_3C8AE:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+178   j
                bsr.w Boss_FlyingNeoProcessAnimation
                bsr.w Boss_FlyingNeoUpdateSprites
                move.l  #word_EBBB8,$3C8(a5)
                move.l  #word_EBC0C,d0
                move.l  #word_EBC18,d1
                cmpi.w  #2,6(a5)
                bpl.s   loc_3C8D4
                exg     d0,d1
loc_3C8D4:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+11E   j
                move.l  d0,$1E8(a5)
                move.l  d1,$368(a5)
                rts
; ---------------------------------------------------------------------------
loc_3C8DE:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+C4   j
                addq.w  #2,4(a5)
                move.w  $11C(a5),d0
                asl.w   #1,d0
                move.w  d0,$11C(a5)
; Flying Neo dive phase with velocity
Boss_FlyingNeoDive_DiveInitiated:                              ; DATA XREF: ROM:0003C0CC   o  ; was: loc_3C8EC
                cmpi.w  #$B8,$14(a5)
                bpl.s   loc_3C908
                move.w  #$1A,4(a5)
                move.w  #2,$17E(a5)
                clr.w   $1DC(a5)
                bra.w Boss_FlyingNeoSetupAttackSlots
; ---------------------------------------------------------------------------
loc_3C908:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+140   j
                move.w  $11C(a5),d0
                ext.l   d0
                sub.l   d0,$18(a5)
                cmpi.l  #$FFFD8000,$1C(a5)
                bmi.s   loc_3C924
                subi.l  #$4800,$1C(a5)
loc_3C924:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+168   j
                lea     word_3D070(pc),a1
                nop
                bra.w   loc_3C8AE
; ---------------------------------------------------------------------------
loc_3C92E:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+E   j
                move.w  #$26,4(a5) ; '&'
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   6(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
; Flying Neo wing animation state
Boss_FlyingNeoHover_WingAnimation:                              ; DATA XREF: ROM:0003C0CE   o  ; was: loc_3C94A
                tst.w   $54(a5)
                bne.s   loc_3C978
                cmpi.w  #$FA0,$BC(a5)
                bpl.s   loc_3C982
loc_3C958:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+1CC   j
                move.l  #$12000,$1C(a5)
                move.l  #$12000,$18(a5)
                tst.w   $54(a5)
                beq.w Boss_FlyingNeoResetAttack
                neg.l   $18(a5)
                bra.w Boss_FlyingNeoResetAttack
; ---------------------------------------------------------------------------
loc_3C978:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+19C   j
                cmpi.w  #$1000,$BC(a5)
                bpl.w   loc_3C958
loc_3C982:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+1A4   j
                movea.w #(word_FFC800-M68K_RAM),a0
                movea.w #(word_FFC980-M68K_RAM),a1
                cmpi.w  #5,6(a5)
                bmi.s   loc_3C994
                exg     a0,a1
loc_3C994:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+1DE   j
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                move.w  (dword_FFA904).w,d0
                addi.w  #$BC,d0
                move.w  d0,$14(a0)
                lea     word_3D02E(pc),a1
                nop
                bsr.w Boss_FlyingNeoProcessAnimation
                bsr.w Boss_FlyingNeoUpdateSprites
                movea.w #(word_FFC800-M68K_RAM),a0
                bsr.s Boss_FlyingNeoUpdateWingSprite
                movea.w #(word_FFC980-M68K_RAM),a0
; End of function Boss_FlyingNeoHoverDecision
; Updates wing sprite frame based on Y position
Boss_FlyingNeoUpdateWingSprite:                              ; CODE XREF: Boss_FlyingNeoHoverDecision+208   p  ; was: sub_3C9C0
                move.l  #word_EBC0C,8(a0)
                move.w  (dword_FFA904).w,d0
                addi.w  #$B2,d0
                cmp.w   $14(a0),d0
                bmi.s   locret_3C9DE
                move.l  #word_EBC18,8(a0)
locret_3C9DE:                           ; CODE XREF: Boss_FlyingNeoUpdateWingSprite+14   j
                rts
; End of function Boss_FlyingNeoUpdateWingSprite
; Calculates distance to enemy entity
Boss_FlyingNeoCalculateDistance:                              ; CODE XREF: Boss_FlyingNeoAttackPatternUpdate+C   p  ; was: sub_3C9E0
                movea.w #(word_FFCA40-M68K_RAM),a5
                jsr (Physics_CalculateDistanceTo).l
                movea.w #(word_FFC620-M68K_RAM),a5
                rts
; End of function Boss_FlyingNeoCalculateDistance
; Updates boss sprite positions and rendering
Boss_FlyingNeoUpdateSprites:                              ; CODE XREF: Boss_FlyingNeoIntroWait+14   j  ; was: sub_3C9F0
                                        ; Boss_FlyingNeoPlayerControlled+76   j ...
                move.w  #$E,$A0(a5)
                move.w  #$1C,$A4(a5)
                tst.w   $54(a5)
                beq.s Boss_FlyingNeoUpdateMetasprite
                move.w  #$10,$A0(a5)
; Updates metasprite angles and linked positions
Boss_FlyingNeoUpdateMetasprite:                              ; CODE XREF: Boss_FlyingNeoUpdateSprites+10   j  ; was: loc_3CA08
                clr.w   $40(a5)
                clr.w   $44(a5)
                movea.w #(word_FFC6E0-M68K_RAM),a4
                movea.w a5,a3
                moveq   #7,d7
                move.w  #8,(dword_FF8040).w
                jsr (Sprite_UpdateMetaspriteAngles).l
                bsr.w Boss_FlyingNeoUpdateScroll
                bsr.w Boss_FlyingNeoCollisionCheck
                bsr.w Boss_FlyingNeoAnimationUpdate
                bra.w   loc_3CC66
; End of function Boss_FlyingNeoUpdateSprites
; ---------------------------------------------------------------------------
byte_3CA34:     dc.b 4, $FE, 3, $FF, 2, 0, 3, 0
                                        ; DATA XREF: Boss_FlyingNeoAnimationUpdate:loc_3CA5C   o


; Updates boss animation frame with interpolation
Boss_FlyingNeoAnimationUpdate:                              ; CODE XREF: Boss_FlyingNeoUpdateSprites+3C   p  ; was: sub_3CA3C
                move.l  #word_EBBB8,$3C8(a5)
                move.w  (word_FFA000).w,d0
                btst    #7,d0
                beq.s   loc_3CA5C
                btst    #3,d0
                beq.s   loc_3CA5C
                move.l  #word_EBBCA,$3C8(a5)
loc_3CA5C:                              ; CODE XREF: Boss_FlyingNeoAnimationUpdate+10   j
                                        ; Boss_FlyingNeoAnimationUpdate+16   j
                lea     byte_3CA34(pc),a0
                move.w  (word_FFA000).w,d0
                andi.w  #6,d0
                move.b  (a0,d0.w),d4
                move.b  1(a0,d0.w),d5
                ext.w   d4
                ext.w   d5
                movea.w #(word_FFC9E0-M68K_RAM),a0
                moveq   #$FFFFFFD2,d0
                moveq   #$16,d1
                tst.w   $54(a5)
                beq.s   loc_3CA86
                moveq   #$4C,d0 ; 'L'
                neg.w   d4
loc_3CA86:                              ; CODE XREF: Boss_FlyingNeoAnimationUpdate+44   j
                add.w   d4,d0
                add.w   d5,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                movea.w #(word_FFCA40-M68K_RAM),a0
                moveq   #$32,d0 ; '2'
                moveq   #$A,d1
                tst.w   $54(a5)
                beq.s   loc_3CAAA
                moveq   #$FFFFFFEE,d0
loc_3CAAA:                              ; CODE XREF: Boss_FlyingNeoAnimationUpdate+6A   j
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                movea.w #(word_FF9800-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a1
                moveq   #$23,d7 ; '#'
                move.w  $23E(a5),d0
loc_3CAC8:                              ; CODE XREF: Boss_FlyingNeoAnimationUpdate+92   j
                move.w  (a1),d1
                move.w  d0,(a1)+
                move.w  d1,d0
                dbf     d7,loc_3CAC8
                movea.w #(word_FFCA40-M68K_RAM),a0
                movea.w #(byte_FFCAA0-M68K_RAM),a1
                movea.w #(byte_FF9806-M68K_RAM),a2
                movea.w #(word_FF9900-M68K_RAM),a3
                movea.w #(dword_FF9A00-M68K_RAM),a4
                move.w  $54(a5),d4
                asl.w   #1,d4
                move.w  #$3FC,d5
                moveq   #$1C,d6
                moveq   #7,d7
loc_3CAF4:                              ; CODE XREF: Boss_FlyingNeoAnimationUpdate+FE   j
                move.w  (a2),d0
                beq.s   loc_3CB00
                bpl.s   loc_3CAFE
                add.w   d6,d0
                bra.s   loc_3CB00
; ---------------------------------------------------------------------------
loc_3CAFE:                              ; CODE XREF: Boss_FlyingNeoAnimationUpdate+BC   j
                sub.w   d6,d0
loc_3CB00:                              ; CODE XREF: Boss_FlyingNeoAnimationUpdate+BA   j
                                        ; Boss_FlyingNeoAnimationUpdate+C0   j
                add.w   d0,$56(a1)
                move.w  $56(a1),d0
                move.w  d0,d1
                add.w   d4,d0
                and.w   d5,d0
                and.w   d5,d1
                move.l  (a3,d1.w),d3
                move.l  (a4,d0.w),d2
                add.l   $10(a0),d2
                add.l   $14(a0),d3
                move.l  d2,$10(a1)
                move.l  d3,$14(a1)
                tst.w   d6
                beq.s Boss_FlyingNeoAdvanceAnimation
                subq.w  #4,d6
; Advances animation frame pointers in loop
Boss_FlyingNeoAdvanceAnimation:                              ; CODE XREF: Boss_FlyingNeoAnimationUpdate+EE   j  ; was: loc_3CB2E
                lea     $60(a0),a0
                lea     $60(a1),a1
                adda.w  #8,a2
                dbf     d7,loc_3CAF4
locret_3CB3E:                           ; CODE XREF: Boss_FlyingNeoUpdatePaletteFade+8   j
                rts
; End of function Boss_FlyingNeoAnimationUpdate
; Updates palette fade effect for boss
Boss_FlyingNeoUpdatePaletteFade:                              ; CODE XREF: Boss_FlyingNeoDefeatState1   p  ; was: sub_3CB40
                                        ; sub_3C3AE   p ...
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   locret_3CB3E
                lea     (word_3E12).l,a2
                lea     word_3CB5C(pc),a3
                nop
                jmp (Palette_ProcessFadeEffect).l
; End of function Boss_FlyingNeoUpdatePaletteFade
; ---------------------------------------------------------------------------
word_3CB5C:     dc.w 2, $CEE, 0, 0, $866, $200, $422, 6, $2A, $26E
                                        ; DATA XREF: Boss_FlyingNeoUpdatePaletteFade+10   o
                dc.w $24, $268, $6AC


; Clear entity sprite IDs and array data
Boss_FlyingNeoClearEntityData:
                movea.w #(byte_FFCAA0-M68K_RAM),a0  ; was: sub_3CB76
                moveq   #7,d7
loc_3CB7C:                              ; CODE XREF: Boss_FlyingNeoClearEntityData+E   j
                move.w  d0,$56(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3CB7C
                movea.w #(word_FF9800-M68K_RAM),a0
                moveq   #$23,d7 ; '#'
                moveq   #0,d1
loc_3CB90:                              ; CODE XREF: Boss_FlyingNeoClearEntityData+1C   j
                move.w  d1,(a0)+
                dbf     d7,loc_3CB90
                rts
; End of function Boss_FlyingNeoClearEntityData
; Updates scroll offsets for boss parallax
Boss_FlyingNeoUpdateScroll:                              ; CODE XREF: Boss_FlyingNeoDefeatState1+8   p  ; was: sub_3CB98
                                        ; Boss_FlyingNeoDefeatState2+8   p ...
                cmpi.w  #$FE,$14(a5)
                bmi.s   loc_3CBA6
                move.w  #$FE,$14(a5)
loc_3CBA6:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+6   j
                movea.w #(byte_FF9506-M68K_RAM),a0
                moveq   #0,d0
                move.w  (dword_FFA904).w,d7
                subi.w  #$60,d7 ; '`'
                asr.w   #3,d7
                moveq   #7,d6
                sub.w   d7,d6
                addi.w  #$F,d7
loc_3CBBE:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+2A   j
                move.w  d0,(a0)+
                subq.w  #8,d0
                dbf     d7,loc_3CBBE
                move.w  (dword_FFA904).w,d0
                neg.w   d0
loc_3CBCC:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+36   j
                move.w  d0,(a0)+
                dbf     d6,loc_3CBCC
                moveq   #8,d7
                move.w  $14(a5),d0
                subi.w  #$C0,d0
                andi.w  #$FFF8,d0
                asr.w   #2,d0
                bpl.s   loc_3CBF0
                asr.w   #1,d0
                add.w   d0,d7
                bmi.s   loc_3CC02
                move.w  #$9506,d0
                bra.s   loc_3CBF4
; ---------------------------------------------------------------------------
loc_3CBF0:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+4A   j
                addi.w  #-$6AFA,d0
loc_3CBF4:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+56   j
                movea.w d0,a0
                moveq   #$58,d0 ; 'X'
                sub.w   $14(a5),d0
loc_3CBFC:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+66   j
                move.w  d0,(a0)+
                dbf     d7,loc_3CBFC
loc_3CC02:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+50   j
                movea.w #(byte_FFE40A-M68K_RAM),a0
                move.w  (dword_FFA904).w,d7
                subi.w  #$60,d7 ; '`'
                bpl.s   loc_3CC12
                moveq   #0,d7
loc_3CC12:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+76   j
                addi.w  #$9C,d7
                move.w  #$120,d0
                add.w   $10(a5),d0
                cmpi.w  #$200,$10(a5)
                bpl.s   loc_3CC2E
                cmpi.w  #$28,$10(a5) ; '('
                bpl.s   loc_3CC3C
loc_3CC2E:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+8C   j
                move.w  #$148,d0
                tst.w   $54(a5)
                beq.s   loc_3CC3C
                move.w  #$118,d0
loc_3CC3C:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+94   j
                                        ; Boss_FlyingNeoUpdateScroll+9E   j ...
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_3CC3C
                move.w  (dword_FFA900).w,d0
                neg.w   d0
loc_3CC4A:                              ; CODE XREF: Boss_FlyingNeoUpdateScroll+BA   j
                move.w  d0,(a0)
                addq.w  #4,a0
                cmpa.w  #$E78A,a0
                bmi.s   loc_3CC4A
                rts
; End of function Boss_FlyingNeoUpdateScroll
; Writes scroll values to VDP via DMA
Boss_FlyingNeoDMAScrollWrite:                              ; CODE XREF: Boss_FlyingNeoDefeatState3+1C   p  ; was: sub_3CC56
                movea.w (word_FFF70E).w,a0
                moveq   #$1B,d7
loc_3CC5C:                              ; CODE XREF: Boss_FlyingNeoDMAScrollWrite+A   j
                move.w  #$193,(a0)+
                dbf     d7,loc_3CC5C
                bra.s Boss_FlyingNeoDMAScrollSetup
; ---------------------------------------------------------------------------
loc_3CC66:                              ; CODE XREF: Boss_FlyingNeoUpdateSprites+40   j
                movea.w (word_FFF70E).w,a0
                moveq   #$1B,d7
                lea     word_3CCCE(pc),a1
                nop
                btst    #1,(word_FFA000+1).w
                bne.s   loc_3CC80
                lea     word_3CD3E(pc),a1
                nop
loc_3CC80:                              ; CODE XREF: Boss_FlyingNeoDMAScrollWrite+22   j
                tst.w   $54(a5)
                beq.s   loc_3CC8C
                adda.l  #$38,a1 ; '8'
loc_3CC8C:                              ; CODE XREF: Boss_FlyingNeoDMAScrollWrite+2E   j
                                        ; Boss_FlyingNeoDMAScrollWrite+38   j
                move.w  (a1)+,(a0)+
                dbf     d7,loc_3CC8C
; Sets up DMA scroll write registers for background
Boss_FlyingNeoDMAScrollSetup:                              ; CODE XREF: Boss_FlyingNeoDMAScrollWrite+E   j  ; was: loc_3CC92
                movea.w (word_FFF70C).w,a4
                move.w  #$83,-(a4)
                move.w  #$6B80,-(a4)
                move.b  (word_FFF70E).w,d2
                move.b  (word_FFF70E+1).w,d3
                asr.b   #1,d2
                roxr.b  #1,d3
                move.b  d3,-(a4)
                move.b  #$95,-(a4)
                move.b  d2,-(a4)
                move.b  #$96,-(a4)
                move.l  #$8F02977F,-(a4)
                move.l  #$9400931C,-(a4)
                move.w  a4,(word_FFF70C).w
                addi.w  #$38,(word_FFF70E).w ; '8'
                rts
; End of function Boss_FlyingNeoDMAScrollWrite
; ---------------------------------------------------------------------------
word_3CCCE:     dc.w $6343, $6344, $6345, $6346, $6347, $6348, $6349, $634A
                                        ; DATA XREF: Boss_FlyingNeoDMAScrollWrite+16   o
                dc.w $634B, $634C, $634D, $634E, $634F, $6350, $6351, $6352
                dc.w $6353, $63CD, $63CD, $63CD, $63CD, $63CD, $63CD, $63CD
                dc.w $63CD, $63CD, $63CD, $63CD, $63CD, $63CD, $63CD, $63CD
                dc.w $63CD, $63CD, $63CD, $63CD, $63CD, $63CD, $63CD, $6B53
                dc.w $6B52, $6B51, $6B50, $6B4F, $6B4E, $6B4D, $6B4C, $6B4B
                dc.w $6B4A, $6B49, $6B48, $6B47, $6B46, $6B45, $6B44, $6B43
word_3CD3E:     dc.w $63CD, $63CD, $63CD, $63CD, $63CD, $6B53, $6B52, $6354
                                        ; DATA XREF: Boss_FlyingNeoDMAScrollWrite+24   o
                dc.w $6355, $6356, $6357, $6358, $6359, $635A, $635B, $6B49
                dc.w $6B48, $6B47, $6B46, $6B45, $6B44, $6B43, $63CD, $63CD
                dc.w $63CD, $63CD, $63CD, $63CD, $63CD, $63CD, $63CD, $63CD
                dc.w $63CD, $63CD, $6343, $6344, $6345, $6346, $6347, $6348
                dc.w $6349, $635B, $6B5A, $6B59, $6B58, $6B57, $6B56, $6B55
                dc.w $6B54, $6352, $6353, $63CD, $63CD, $63CD, $63CD, $63CD


; Checks collision between boss and player attacks
Boss_FlyingNeoCollisionCheck:                              ; CODE XREF: Boss_FlyingNeoUpdateSprites+38   p  ; was: sub_3CDAE
                clr.w   $23E(a5)
                move.w  $536(a5),d0
                andi.w  #$3FC,d0
                move.w  (dword_FFFF08).w,d1
                andi.w  #$F,d1
                beq.s   locret_3CDE8
                tst.w   $17C(a5)
                bne.s   loc_3CDEA
                cmpi.w  #$200,d0
                bmi.s   loc_3CDE2
                cmpi.w  #$340,d0
                bpl.s   loc_3CDDC
loc_3CDD6:                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+32   j
                addq.w  #2,$17C(a5)
                rts
; ---------------------------------------------------------------------------
loc_3CDDC:                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+26   j
                andi.w  #3,d1
                beq.s   loc_3CDD6
loc_3CDE2:                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+20   j
                move.w  #$FFE0,$23E(a5)
locret_3CDE8:                           ; CODE XREF: Boss_FlyingNeoCollisionCheck+14   j
                rts
; ---------------------------------------------------------------------------
loc_3CDEA:                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+1A   j
                cmpi.w  #$200,d0
                bpl.s   loc_3CE0C
                cmpi.w  #$C0,d0
                bmi.s   loc_3CDFC
loc_3CDF6:                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+5C   j
                clr.w   $17C(a5)
                rts
; ---------------------------------------------------------------------------
loc_3CDFC:                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+46   j
                moveq   #3,d2
                btst    #0,(word_FFA000).w
                beq.s   loc_3CE08
                moveq   #7,d2
loc_3CE08:                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+56   j
                and.w   d2,d1
                beq.s   loc_3CDF6
loc_3CE0C:                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+40   j
                move.w  #$20,$23E(a5) ; ' '
                rts
; End of function Boss_FlyingNeoCollisionCheck
; Flips boss direction loading corresponding tile graphics
Boss_FlyingNeoFlipDirection:                              ; CODE XREF: Boss_FlyingNeoSetup+130   p  ; was: sub_3CE14
                                        ; Boss_FlyingNeoPlayerControlled+50   p ...
                moveq   #3,d0
                movea.w #(word_FFCA40-M68K_RAM),a0
                moveq   #8,d7
                tst.w   $54(a5)
                bne.w   loc_3CE62
                move.l  #$E01CD42E,$28(a5)
                bset    d0,$3CE(a5)
                bclr    d0,$6E(a5)
                move.w  #$E2F4,$6A(a5)
                bset    d0,$12E(a5)
                bset    d0,$2AE(a5)
                bset    d0,$1EE(a5)
                bset    d0,$36E(a5)
loc_3CE4A:                              ; CODE XREF: Boss_FlyingNeoFlipDirection+3E   j
                bclr    d0,$E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3CE4A
                lea     word_3CEAE(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
loc_3CE62:                              ; CODE XREF: Boss_FlyingNeoFlipDirection+C   j
                move.l  #$E01CF040,$28(a5)
                bclr    d0,$3CE(a5)
                bset    d0,$6E(a5)
                move.w  #$F4,$6A(a5)
                bclr    d0,$12E(a5)
                bclr    d0,$2AE(a5)
                bclr    d0,$1EE(a5)
                bclr    d0,$36E(a5)
; Sets flip bits on all body segments and loads tiles
Boss_FlyingNeoSetFlipBits:                              ; CODE XREF: Boss_FlyingNeoFlipDirection+7C   j  ; was: loc_3CE88
                bset    d0,$E(a0)
                lea     $60(a0),a0
                dbf d7,Boss_FlyingNeoSetFlipBits
                lea     word_3CEBC(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_FlyingNeoFlipDirection
; ---------------------------------------------------------------------------
word_3CEA0:     dc.w $6C0C, $4000, $301, $5656, $5656, $5656, $5656
                                        ; DATA XREF: Boss_FlyingNeoDefeatState4+94   o
word_3CEAE:     dc.w $6C0C, $2000, $301, $3031, $3233, $3435, $3637
                                        ; DATA XREF: Boss_FlyingNeoFlipDirection+42   o
word_3CEBC:     dc.w $6C0C, $2000, $301, $3839, $3A3B, $373D, $3E3F
                                        ; DATA XREF: Boss_FlyingNeoFlipDirection+80   o


; Initializes enemy sprite parameters from table
Boss_FlyingNeoInitSprites:                              ; CODE XREF: Boss_FlyingNeoSetup+9C   p  ; was: sub_3CECA
                                        ; Boss_FlyingNeoSetup+A8   p ...
                move.w  d0,(a0)
                move.b  #$18,$20(a0)
                move.w  d2,2(a0)
                move.w  (a1),$E(a0)
                move.w  2(a1),8(a0)
                move.w  4(a1),$A(a0)
                lea     $60(a0),a0
                dbf d7,Boss_FlyingNeoInitSprites
                rts
; End of function Boss_FlyingNeoInitSprites
; ---------------------------------------------------------------------------
word_3CEF0:     dc.w $6386, $A00, $F4F4 ; DATA XREF: Boss_FlyingNeoSetup+94   o
word_3CEF6:     dc.w $638F, $500, $F8F8 ; DATA XREF: Boss_FlyingNeoSetup+A0   o
word_3CEFC:     dc.w $6393, $500, $F8F8 ; DATA XREF: Boss_FlyingNeoSetup+AC   o
word_3CF02:     dc.w $6397, 0, $FCFC    ; DATA XREF: Boss_FlyingNeoSetup+B8   o


nullsub_78:
                rts
; End of function nullsub_78


; Processes animation with interpolation and angle updates
Boss_FlyingNeoProcessAnimation:                              ; CODE XREF: Boss_FlyingNeoIntroWait+10   p  ; was: sub_3CF0A
                                        ; Boss_FlyingNeoPlayerControlled+72   p ...
                clr.w   $A(a5)
                tst.w   $C(a5)
                bpl.s   loc_3CF8C
loc_3CF14:                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_3CF9C
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_3CF36
                move.b  1(a1,d0.w),d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_3CF36:                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_3CF46
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_3CF46:                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_3CF56
                clr.w   $58(a5)
                clr.w   6(a5)
                bra.s   loc_3CF14
; ---------------------------------------------------------------------------
loc_3CF56:                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3D082,d0
                movea.l d0,a0
                bsr.w Boss_FlyingNeoCalculateDeltas
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,6(a5)
                addq.w  #1,$A(a5)
                tst.w   $C(a5)
                bmi.s   loc_3CF9C
loc_3CF8C:                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #3,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_3CF9C:                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+E   j
                                        ; Boss_FlyingNeoProcessAnimation+80   j
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.w  #$1FE,d7
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                move.w  d0,$176(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$1D6(a5)
                move.w  d1,$236(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$296(a5)
                move.w  d0,$2F6(a5)
                move.b  $C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$356(a5)
                move.w  d1,$3B6(a5)
                rts
; End of function Boss_FlyingNeoProcessAnimation
; Calculates interpolation deltas for animation system
Boss_FlyingNeoCalculateDeltas:                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+62   p  ; was: sub_3CFE8
                movea.l #word_34F86,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #3,d7
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_FlyingNeoCalculateDeltas
; Load animation frame delays for Flying-Neo boss
Boss_FlyingNeoLoadFrameDelays:
                movea.w #(dword_FF9400-M68K_RAM),a1  ; was: sub_3CFFE
                moveq   #3,d7
                jmp Anim_LoadFrameDelays
; End of function Boss_FlyingNeoLoadFrameDelays
; ---------------------------------------------------------------------------
word_3D00A:     dc.w $408, 0, $808, 0, $408, 4, $808, 4
                                        ; DATA XREF: Boss_FlyingNeoIntroWait+A   o
                                        ; sub_3C4E2:loc_3C54E   o ...
                dc.w $FFFF
word_3D01C:     dc.w $612, 0, $1212, 0, $612, 4, $1212, 4
                                        ; DATA XREF: Boss_FlyingNeoSwoopAttack:loc_3C762   o
                dc.w $FFFF
word_3D02E:     dc.w $828, 8, $E0E, 8, $A10, $C, $A0A, $C
                                        ; DATA XREF: Boss_FlyingNeoHoverDecision+1F6   o
                dc.w $80AF, $828, $10, $E0E, $10, $A10, $14, $A0A
                dc.w $14, $80AF, $FFFF
word_3D054:     dc.w $70C, $18, $4040, $18, $FFFE
                                        ; DATA XREF: Boss_FlyingNeoHoverDecision:loc_3C836   o
word_3D05E:     dc.w $210, $1C, $606, $1C, $220, $20, $808, $20
                                        ; DATA XREF: Boss_FlyingNeoHoverDecision:loc_3C8A8   o
                dc.w $FFFF
word_3D070:     dc.w $820, $1C, $1216, $1C, $820, $20, $1216, $20
                                        ; DATA XREF: Boss_FlyingNeoHoverDecision:loc_3C924   o
                dc.w $FFFF
word_3D082:     dc.w $868, $1C70, $1C70, $868, $3010, $470, $1020, $501B
                                        ; DATA XREF: Boss_FlyingNeoProcessAnimation+5A   o
                dc.w $470, $3010, $5020, $1020, $6850, $6850, $7800, $870
                dc.w $1860, $7008, $6C24, $878, $F860, $6024


; Main caterpillar boss handler with state dispatch
Boss_CaterpillarMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D0AE
                move.w  4(a5),d0
                movea.w off_3D0BE(pc,d0.w),a0
                adda.l  #Boss_CaterpillarInit,a0
                jmp     (a0)
; End of function Boss_CaterpillarMain
; ---------------------------------------------------------------------------
off_3D0BE:      dc.w Boss_CaterpillarInit-Boss_CaterpillarInit
                                        ; DATA XREF: Boss_CaterpillarMain+4   r
                dc.w Boss_CaterpillarAnimateWave-Boss_CaterpillarInit


; Initializes caterpillar boss entity
Boss_CaterpillarInit:                              ; DATA XREF: Boss_CaterpillarMain+8   o  ; was: sub_3D0C2
                                        ; ROM:off_3D0BE   o ...
                addq.w  #2,4(a5)
                bra.w Boss_CaterpillarInitSegments
; End of function Boss_CaterpillarInit
; Animates wave pattern for caterpillar movement
Boss_CaterpillarAnimateWave:                              ; DATA XREF: ROM:0003D0C0   o  ; was: sub_3D0CA
                addq.w  #4,$56(a5)
                andi.w  #$1FE,$56(a5)
                move.w  $56(a5),d0
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  #$FFDA,d1
                moveq   #$A,d7
loc_3D0E2:                              ; CODE XREF: Boss_CaterpillarAnimateWave+1C   j
                move.w  d0,(a0)+
                subq.w  #6,d0
                dbf     d7,loc_3D0E2
                subi.w  #$10,d0
                moveq   #3,d7
loc_3D0F0:                              ; CODE XREF: Boss_CaterpillarAnimateWave+28   j
                move.w  d0,(a0)+
                dbf     d7,loc_3D0F0
                add.w   d1,d0
                moveq   #$17,d7
loc_3D0FA:                              ; CODE XREF: Boss_CaterpillarAnimateWave+40   j
                move.w  d0,(a0)+
                subq.w  #6,d0
                move.w  d0,(a0)+
                subq.w  #6,d0
                move.w  d0,(a0)+
                add.w   d1,d0
                move.w  d0,(a0)+
                add.w   d1,d0
                dbf     d7,loc_3D0FA
                moveq   #9,d7
loc_3D110:                              ; CODE XREF: Boss_CaterpillarAnimateWave+4A   j
                move.w  d0,(a0)+
                addq.w  #6,d0
                dbf     d7,loc_3D110
                move.w  (dword_FFA908).w,d0
                subi.w  #$200,d0
                subq.w  #1,d0
                andi.w  #$FFF0,d0
                asr.w   #3,d0
                addi.w  #-$6800,d0
                movea.w d0,a0
                movea.w #(dword_FF8A00-M68K_RAM),a1
                lea     (word_1B514).l,a2
                move.w  #$1FE,d2
                move.w  #$10,d3
                moveq   #$13,d7
loc_3D142:                              ; CODE XREF: Boss_CaterpillarAnimateWave+8A   j
                move.w  (a0)+,d0
                and.w   d2,d0
                move.w  (a2,d0.w),d1
                ext.l   d1
                asl.l   #6,d1
                swap    d1
                sub.w   d3,d1
                move.w  d1,(a1)+
                dbf     d7,loc_3D142
                rts
; End of function Boss_CaterpillarAnimateWave
; Initializes caterpillar body segments from table
