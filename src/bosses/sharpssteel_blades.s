Boss_SharpssteelComplexPhase:                           ; DATA XREF: ROM:00047C88   o  ; was: sub_484E4
                move.w  $314(a5),d0
                sub.w   (dword_FFDB34).w,d0
                cmpi.w  #$38,d0                         ; '8'
                bmi.s   loc_484FA
                bsr.w   loc_48A78
                bra.w   loc_48694
; ---------------------------------------------------------------------------
loc_484FA:                                              ; CODE XREF: Boss_SharpssteelComplexPhase+C   j
                addq.w  #2,4(a5)
                move.w  #8,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                bset    #0,(byte_FFDB7A).w
                clr.l   (dword_FFDB3C).w
                move.l  #$8000,(dword_FFDB38).w
                move.l  #$A000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   Boss_Sharpssteel_AccelerateDown
                neg.l   $18(a5)
                neg.l   (dword_FFDB38).w
; Accelerates blade downward during complex phase
Boss_Sharpssteel_AccelerateDown:                        ; CODE XREF: Boss_SharpssteelComplexPhase+46   j  ; was: loc_48534
                                        ; DATA XREF: ROM:00047C8A   o
                addi.l  #$1200,$1C(a5)
                btst    #0,$23E(a5)
                bne.s   loc_4855A
                move.w  $314(a5),d0
                subi.w  #$30,d0                         ; '0'
                move.w  d0,(dword_FFDB34).w
                lea     byte_48C9E(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_4855A:                                              ; CODE XREF: Boss_SharpssteelComplexPhase+5E   j
                addq.w  #2,4(a5)
                bset    #1,(byte_FFDB7A).w
                clr.w   $11E(a5)
                addi.l  #$A000,$1C(a5)
                move.l  #$15000,d0
                tst.w   $18(a5)
                bpl.s   loc_4857E
                neg.l   d0
loc_4857E:                                              ; CODE XREF: Boss_SharpssteelComplexPhase+96   j
                move.l  d0,$18(a5)
; Sharpssteel boss ultimate attack
Boss_Sharpssteel_State27:                               ; DATA XREF: ROM:00047C8C   o  ; was: loc_48582
                tst.w   $58(a5)
                bmi.s   loc_48596
                bsr.w   Boss_SharpssteelVerticalOscillate
                lea     byte_48C9E(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_48596:                                              ; CODE XREF: Boss_SharpssteelComplexPhase+A2   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $23E(a5)
                move.w  #3,$11C(a5)
; Sharpssteel boss closing pattern
Boss_Sharpssteel_State28:                               ; DATA XREF: ROM:00047C8E   o  ; was: loc_485AE
                btst    #1,$23E(a5)
                beq.s   loc_485BA
                bsr.w   Boss_SharpssteelSpawnSixRadialShots
loc_485BA:                                              ; CODE XREF: Boss_SharpssteelComplexPhase+D0   j
                btst    #0,$23E(a5)
                beq.s   loc_485D2
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                subq.w  #1,$11C(a5)
                bmi.s   loc_485E4
loc_485D2:                                              ; CODE XREF: Boss_SharpssteelComplexPhase+DC   j
                bsr.w   Boss_SharpssteelVerticalMovementClamp
                bsr.w   Boss_SharpssteelVerticalOscillate
                lea     byte_48CBA(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_485E4:                                              ; CODE XREF: Boss_SharpssteelComplexPhase+EC   j
                addq.w  #2,4(a5)
; Sharpssteel boss last stand
Boss_Sharpssteel_State29:                               ; DATA XREF: ROM:00047C90   o  ; was: loc_485E8
                addi.l  #$2000,$1C(a5)
                cmpi.w  #$200,$14(a5)
                bpl.w   loc_482CA
                lea     byte_48CBA(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; End of function Boss_SharpssteelComplexPhase
; Controls vertical oscillation movement
Boss_SharpssteelVerticalOscillate:                      ; CODE XREF: Boss_SharpssteelComplexPhase+A4   p  ; was: sub_48604
                                        ; Boss_SharpssteelComplexPhase+F2   p
                tst.w   $11E(a5)
                bne.s   loc_4862A
                move.l  $1C(a5),d0
                bpl.s   loc_48620
                cmpi.w  #$170,$14(a5)
                bmi.s   loc_4864A
                cmpi.l  #$FFFE8000,d0
                bmi.s   locret_48650
loc_48620:                                              ; CODE XREF: Boss_SharpssteelVerticalOscillate+A   j
                subi.l  #$E00,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_4862A:                                              ; CODE XREF: Boss_SharpssteelVerticalOscillate+4   j
                move.l  $1C(a5),d0
                bmi.s   loc_48640
                cmpi.w  #$172,$14(a5)
                bpl.s   loc_4864A
                cmpi.l  #$18000,d0
                bpl.s   locret_48650
loc_48640:                                              ; CODE XREF: Boss_SharpssteelVerticalOscillate+2A   j
                addi.l  #$E00,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_4864A:                                              ; CODE XREF: Boss_SharpssteelVerticalOscillate+12   j
                                        ; Boss_SharpssteelVerticalOscillate+32   j
                eori.w  #2,$11E(a5)
locret_48650:                                           ; CODE XREF: Boss_SharpssteelVerticalOscillate+1A   j
                                        ; Boss_SharpssteelVerticalOscillate+3A   j
                rts
; End of function Boss_SharpssteelVerticalOscillate
; Clamps vertical movement velocity between limits
Boss_SharpssteelVerticalMovementClamp:                  ; CODE XREF: Boss_SharpssteelComplexPhase:loc_485D2   p  ; was: sub_48652
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_48676
                move.l  $18(a5),d0
                bpl.s   loc_4866C
                cmpi.l  #$FFFD8000,$18(a5)
                bmi.s   locret_48674
loc_4866C:                                              ; CODE XREF: Boss_SharpssteelVerticalMovementClamp+E   j
                subi.l  #$3000,$18(a5)
locret_48674:                                           ; CODE XREF: Boss_SharpssteelVerticalMovementClamp+18   j
                                        ; Boss_SharpssteelVerticalMovementClamp+32   j
                rts
; ---------------------------------------------------------------------------
loc_48676:                                              ; CODE XREF: Boss_SharpssteelVerticalMovementClamp+8   j
                move.l  $18(a5),d0
                bmi.s   loc_48686
                cmpi.l  #$28000,$18(a5)
                bpl.s   locret_48674
loc_48686:                                              ; CODE XREF: Boss_SharpssteelVerticalMovementClamp+28   j
                addi.l  #$3000,$18(a5)
                rts
; End of function Boss_SharpssteelVerticalMovementClamp
; Main handler for blade part
Boss_SharpssteelBladeMain:                              ; CODE XREF: Boss_SharpssteelUpdateBlades+A   j  ; was: sub_48690
                                        ; Boss_SharpssteelSpawnBlades+A   j
                bsr.w   Boss_SharpssteelCoreInit
loc_48694:                                              ; CODE XREF: Boss_SharpssteelInputHandler+40   j
                                        ; Boss_SharpssteelComplexPhase+12   j
                bsr.w   Boss_SharpssteelBackgroundFadeControl
                bsr.w   Boss_SharpssteelCoreMain
                moveq   #$11,d7
                jmp     Sprite_BeginMetaspritePartTraversal
; End of function Boss_SharpssteelBladeMain
; Initializes single blade
Boss_SharpssteelBladeInit:                              ; CODE XREF: Boss_SharpssteelUpdateRotation+4E   p  ; was: sub_486A4
                                        ; Boss_SharpssteelAttackPattern1Alt+82   p
                movea.w a5,a0
                moveq   #7,d0
                moveq   #$11,d7
loc_486AA:                                              ; CODE XREF: Boss_SharpssteelBladeInit+E   j
                bclr    d0,$E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_486AA
                rts
; End of function Boss_SharpssteelBladeInit
; Sets bit 7 on offset $E for 18 objects
Boss_SharpssteelEnableMultipleHitboxes:                 ; CODE XREF: Boss_SharpssteelBattleActive+4A   p  ; was: sub_486B8
                                        ; Boss_SharpssteelMultiPhaseAttack+2C   p
                movea.w a5,a0
                moveq   #7,d0
                moveq   #$11,d7
loc_486BE:                                              ; CODE XREF: Boss_SharpssteelEnableMultipleHitboxes+E   j
                bset    d0,$E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_486BE
                rts
; End of function Boss_SharpssteelEnableMultipleHitboxes
; Clears bit 7 on first hitbox group
Boss_SharpssteelDisableHitboxGroup1:                    ; CODE XREF: Boss_SharpssteelAttackPattern3+46   p  ; was: sub_486CC
                bclr    #7,$24E(a5)
                bclr    #7,$2AE(a5)
                bclr    #7,$30E(a5)
                bclr    #7,$36E(a5)
                rts
; End of function Boss_SharpssteelDisableHitboxGroup1
; Updates blade position
Boss_SharpssteelBladeUpdate:                            ; CODE XREF: Boss_SharpssteelInitBattle+5E   p  ; was: sub_486E6
                                        ; Boss_SharpssteelAttackPattern2Alt+10   p
                bset    #7,$24E(a5)
                bset    #7,$2AE(a5)
                bset    #7,$30E(a5)
                bset    #7,$36E(a5)
                rts
; End of function Boss_SharpssteelBladeUpdate
; Clears bit 7 on second hitbox group
Boss_SharpssteelDisableHitboxGroup2:                    ; CODE XREF: Boss_SharpssteelAttackPattern3+4A   p  ; was: sub_48700
                bclr    #7,$3CE(a5)
                bclr    #7,$42E(a5)
                bclr    #7,$48E(a5)
                bclr    #7,$4EE(a5)
                rts
; End of function Boss_SharpssteelDisableHitboxGroup2
; Checks blade collision
Boss_SharpssteelBladeCheckHit:                          ; CODE XREF: Boss_SharpssteelInitBattle+5A   p  ; was: sub_4871A
                bset    #7,$3CE(a5)
                bset    #7,$42E(a5)
                bset    #7,$48E(a5)
                bset    #7,$4EE(a5)
                rts
; End of function Boss_SharpssteelBladeCheckHit
; Enables bit 6 on multiple hitbox offsets
Boss_SharpssteelEnableHitboxSet1:
                bset    #6,$5C1(a5)                     ; was: sub_48734
                bset    #6,$681(a5)
                move.w  d1,$5C6(a5)
                move.w  d1,$686(a5)
                movea.w #(word_FFC9E0-M68K_RAM),a0
                bra.s   loc_48766
; End of function Boss_SharpssteelEnableHitboxSet1
; Enables bit 6 on blade hitbox offsets
Boss_SharpssteelEnableHitboxSet2:                       ; CODE XREF: Boss_SharpssteelAttackPattern2Alt+18   p  ; was: sub_4874E
                                        ; Boss_SharpssteelBladeDefeat+18   p
                bset    #6,$561(a5)
                bset    #6,$621(a5)
                move.w  d1,$566(a5)
                move.w  d1,$626(a5)
                movea.w #(word_FFC860-M68K_RAM),a0
loc_48766:                                              ; CODE XREF: Boss_SharpssteelEnableHitboxSet1+18   j
                moveq   #6,d0
                bset    d0,$21(a0)
                bset    d0,$81(a0)
                bset    d0,$E1(a0)
                bset    d0,$141(a0)
                move.w  d1,$26(a0)
                move.w  d1,$86(a0)
                move.w  d1,$E6(a0)
                move.w  d1,$146(a0)
                rts
; End of function Boss_SharpssteelEnableHitboxSet2
; Clears bit 6 on offsets for hitbox control
Boss_SharpssteelDisableHitboxFlags:
                bclr    #6,$5C1(a5)                     ; was: sub_4878A
                bclr    #6,$681(a5)
                movea.w #(word_FFC9E0-M68K_RAM),a0
                bra.s   loc_487AC
; End of function Boss_SharpssteelDisableHitboxFlags
; Core damage flash effect
Boss_SharpssteelCoreFlash:                              ; CODE XREF: Boss_SharpssteelAttackPattern2Alt+2E   p  ; was: sub_4879C
                                        ; Boss_SharpssteelBladeDefeat+2E   p
                bclr    #6,$561(a5)
                bclr    #6,$621(a5)
                movea.w #(word_FFC860-M68K_RAM),a0
loc_487AC:                                              ; CODE XREF: Boss_SharpssteelDisableHitboxFlags+10   j
                moveq   #6,d0
                bclr    d0,$21(a0)
                bclr    d0,$81(a0)
                bclr    d0,$E1(a0)
                bclr    d0,$141(a0)
                rts
; End of function Boss_SharpssteelCoreFlash
; Writes palette index to four animation offsets
Boss_SharpssteelSetPaletteIndices1:
                move.w  d0,$686(a5)                     ; was: sub_487C0
                move.w  d0,$566(a5)
                move.w  d0,$386(a5)
                move.w  d0,$326(a5)
                rts
; End of function Boss_SharpssteelSetPaletteIndices1
; Writes palette index to different offsets
Boss_SharpssteelSetPaletteIndices2:
                move.w  d0,$626(a5)                     ; was: sub_487D2
                move.w  d0,$5C6(a5)
                move.w  d0,$506(a5)
                move.w  d0,$4A6(a5)
                rts
; End of function Boss_SharpssteelSetPaletteIndices2
; Sets bits 4 and 6 on byte offset for six objects
Boss_SharpssteelEnableObjectFlags:                      ; CODE XREF: Boss_SharpssteelMultiPhaseAttack+30   p  ; was: sub_487E4
                move.w  #$50,d0                         ; 'P'
                or.b    d0,$21(a5)
                or.b    d0,$81(a5)
                or.b    d0,$E1(a5)
                or.b    d0,$141(a5)
                or.b    d0,$1A1(a5)
                or.b    d0,$201(a5)
                rts
; End of function Boss_SharpssteelEnableObjectFlags
; Core damage state
Boss_SharpssteelCoreDamage:                             ; CODE XREF: Boss_SharpssteelUpdateRotation+30   p  ; was: sub_48802
                                        ; Boss_SharpssteelAttackPattern3+42   p
                move.w  #$FFAF,d0
                and.b   d0,$21(a5)
                and.b   d0,$81(a5)
                and.b   d0,$E1(a5)
                and.b   d0,$141(a5)
                and.b   d0,$1A1(a5)
                and.b   d0,$201(a5)
                rts
; End of function Boss_SharpssteelCoreDamage
; Main handler for boss core
Boss_SharpssteelCoreMain:                               ; CODE XREF: Boss_SharpssteelBladeMain+8   p  ; was: sub_48820
                lea     off_48846(pc),a1
                nop
                movea.w #(word_FFC980-M68K_RAM),a0
                andi.w  #$E7FF,$E(a0)
                jsr     (Sprite_UpdateFourDirectionFrame).l
                movea.w #(byte_FFCB00-M68K_RAM),a0
                andi.w  #$E7FF,$E(a0)
                jmp     Sprite_UpdateFourDirectionFrame
; End of function Boss_SharpssteelCoreMain
; ---------------------------------------------------------------------------
off_48846:      dc.l    word_EC196                      ; DATA XREF: Boss_SharpssteelCoreMain   o
                dc.l    word_EC21A
                dc.l    word_EC1BA
                dc.l    word_EC1DE

; State dispatcher for core
Boss_SharpssteelCoreDispatcher:                         ; CODE XREF: Boss_SharpssteelInit+46   p  ; was: sub_48856
                                        ; Boss_SharpssteelInputHandler+8   p
                move.w  #$EB9C,$24E(a5)
                move.w  #$B00,$248(a5)
                move.w  #$F4F0,$24A(a5)
                move.w  #$FB9C,$3CE(a5)
                move.w  #$B00,$3C8(a5)
                move.w  #$F4F0,$3CA(a5)
                moveq   #0,d1
                move.w  #$F7FF,d2
                cmpi.w  #$100,$56(a5)
                bpl.s   loc_48898
                move.w  #$800,d1
                eori.w  #$1800,$24E(a5)
                eori.w  #$1800,$3CE(a5)
loc_48898:                                              ; CODE XREF: Boss_SharpssteelCoreDispatcher+30   j
                lea     off_48922(pc),a0
                nop
                bra.s   loc_488F0
; End of function Boss_SharpssteelCoreDispatcher
; Core active state
Boss_SharpssteelCoreActive:                             ; CODE XREF: Boss_SharpssteelInputHandler+14   p  ; was: sub_488A0
                                        ; Boss_SharpssteelUpdateRotation+4A   p
                move.w  #$EB90,$24E(a5)
                move.w  #$E00,$248(a5)
                move.w  #$F0F4,$24A(a5)
                move.w  #$E390,$3CE(a5)
                move.w  #$E00,$3C8(a5)
                move.w  #$F0F4,$3CA(a5)
                moveq   #0,d1
                move.w  #$EFFF,d2
                cmpi.w  #$80,$56(a5)
                bmi.s   loc_488EA
                cmpi.w  #$180,$56(a5)
                bpl.s   loc_488EA
                move.w  #$1000,d1
                eori.w  #$1800,$24E(a5)
                eori.w  #$1800,$3CE(a5)
loc_488EA:                                              ; CODE XREF: Boss_SharpssteelCoreActive+30   j
                                        ; Boss_SharpssteelCoreActive+38   j
                lea     off_4890A(pc),a0
                nop
loc_488F0:                                              ; CODE XREF: Boss_SharpssteelCoreDispatcher+48   j
                movea.w a5,a1
                moveq   #5,d7
loc_488F4:                                              ; CODE XREF: Boss_SharpssteelCoreActive+64   j
                and.w   d2,$E(a1)
                or.w    d1,$E(a1)
                move.l  (a0)+,8(a1)
                lea     $60(a1),a1
                dbf     d7,loc_488F4
                rts
; End of function Boss_SharpssteelCoreActive
; ---------------------------------------------------------------------------
off_4890A:      dc.l    word_EC0BE                      ; DATA XREF: Boss_SharpssteelCoreActive:loc_488EA   o
                dc.l    word_EC0A6
                dc.l    word_EC08E
                dc.l    word_EC0D6
                dc.l    word_EC0E2
                dc.l    word_EC0EE
off_48922:      dc.l    word_EC142                      ; DATA XREF: Boss_SharpssteelCoreDispatcher:loc_48898   o
                dc.l    word_EC12A
                dc.l    word_EC112
                dc.l    word_EC15A
                dc.l    word_EC166
                dc.l    word_EC172

; Sets up palette fade operation
Boss_SharpssteelPaletteFadeSetup:                       ; CODE XREF: Boss_SharpssteelBladeDefeat+32   p  ; was: sub_4893A
                                        ; Boss_SharpssteelAttackPattern3+52   p
                moveq   #$18,d0
                bsr.s   loc_48946
                moveq   #$18,d0
; End of function Boss_SharpssteelPaletteFadeSetup
; Core idle state
Boss_SharpssteelCoreIdle:                               ; CODE XREF: Boss_SharpssteelInitState+32   p  ; was: sub_48940
                                        ; Boss_SharpssteelBattleActive+50   p
                movea.w #(word_FFC860-M68K_RAM),a0
                bra.s   loc_4894A
; ---------------------------------------------------------------------------
loc_48946:                                              ; CODE XREF: Boss_SharpssteelUpdateRotation+5A   j
                                        ; Boss_SharpssteelPaletteFadeSetup+2   p
                movea.w #(word_FFC9E0-M68K_RAM),a0
loc_4894A:                                              ; CODE XREF: Boss_SharpssteelCoreIdle+4   j
                move.b  d0,$20(a0)
                move.b  d0,$80(a0)
                move.b  d0,$E0(a0)
                subq.w  #8,d0
                move.b  d0,$140(a0)
                rts
; End of function Boss_SharpssteelCoreIdle
; Loads 3 palette colors based on frame counter
Boss_SharpssteelLoadPaletteColors:
                moveq   #6,d0                           ; was: sub_4895E
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4896A
                moveq   #0,d0
loc_4896A:                                              ; CODE XREF: Boss_SharpssteelLoadPaletteColors+8   j
                movea.w #(word_FFE366-M68K_RAM),a0
                move.w  word_4897C(pc,d0.w),(a0)+
                move.w  word_4897C+2(pc,d0.w),(a0)+
                move.w  word_4897C+4(pc,d0.w),(a0)+
                rts
; End of function Boss_SharpssteelLoadPaletteColors
; ---------------------------------------------------------------------------
word_4897C:     dc.w    $8C8, $664, $220, $EEE, $AAA, $888
                                        ; DATA XREF: Boss_SharpssteelLoadPaletteColors+10   r
                                        ; Boss_SharpssteelLoadPaletteColors+14   r

; Controls background palette fade with limits
Boss_SharpssteelBackgroundFadeControl:                  ; CODE XREF: Boss_SharpssteelBladeMain:loc_48694   p  ; was: sub_48988
                move.w  $3BE(a5),d0
                bne.s   loc_48990
                rts
; ---------------------------------------------------------------------------
loc_48990:                                              ; CODE XREF: Boss_SharpssteelBackgroundFadeControl+4   j
                move.w  $3BC(a5),d7
                bne.s   loc_489A0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_489A0
                moveq   #1,d7
loc_489A0:                                              ; CODE XREF: Boss_SharpssteelBackgroundFadeControl+C   j
                                        ; Boss_SharpssteelBackgroundFadeControl+14   j
                cmpi.w  #2,d0
                beq.s   loc_489C2
                move.w  $35E(a5),d0
                add.w   d7,d0
                move.w  d0,$35E(a5)
                bmi.s   loc_489B6
                moveq   #0,d0
                bra.s   loc_489DC
; ---------------------------------------------------------------------------
loc_489B6:                                              ; CODE XREF: Boss_SharpssteelBackgroundFadeControl+28   j
                cmpi.w  #$FFF8,d0
                bpl.s   loc_489E0
                move.w  #$FFF8,d0
                bra.s   loc_489E0
; ---------------------------------------------------------------------------
loc_489C2:                                              ; CODE XREF: Boss_SharpssteelBackgroundFadeControl+1C   j
                move.w  $35E(a5),d0
                sub.w   d7,d0
                move.w  d0,$35E(a5)
                bmi.s   loc_489D2
                moveq   #0,d0
                bra.s   loc_489E0
; ---------------------------------------------------------------------------
loc_489D2:                                              ; CODE XREF: Boss_SharpssteelBackgroundFadeControl+44   j
                cmpi.w  #$FFF8,d0
                bpl.s   loc_489E0
                move.w  #$FFF8,d0
loc_489DC:                                              ; CODE XREF: Boss_SharpssteelBackgroundFadeControl+2C   j
                clr.w   $3BE(a5)
loc_489E0:                                              ; CODE XREF: Boss_SharpssteelBackgroundFadeControl+32   j
                                        ; Boss_SharpssteelBackgroundFadeControl+38   j
                movea.w #(word_FFE364-M68K_RAM),a0
                moveq   #$D,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_SharpssteelBackgroundFadeControl
; Initializes boss core
Boss_SharpssteelCoreInit:                               ; CODE XREF: Boss_SharpssteelInputHandler+3C   p  ; was: sub_489F0
                                        ; sub_48690   p
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_48A68
loc_489FA:                                              ; CODE XREF: Boss_SharpssteelCoreInit+24   j
                                        ; Boss_SharpssteelCoreInit+44   j
                move.w  $58(a5),d0
                bmi.w   loc_48A78
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_48A16
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_489FA
; ---------------------------------------------------------------------------
loc_48A16:                                              ; CODE XREF: Boss_SharpssteelCoreInit+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_48A26
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_48A26:                                              ; CODE XREF: Boss_SharpssteelCoreInit+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_48A36
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_489FA
; ---------------------------------------------------------------------------
loc_48A36:                                              ; CODE XREF: Boss_SharpssteelCoreInit+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #byte_48CD8,d0
                movea.l d0,a0
                bsr.w   Boss_SharpssteelCoreDefeat
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_48A78
loc_48A68:                                              ; CODE XREF: Boss_SharpssteelCoreInit+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #7,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_48A78:                                              ; CODE XREF: Boss_SharpssteelComplexPhase+E   p
                                        ; Boss_SharpssteelCoreInit+E   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  #$180,d1
                move.w  #$80,d2
                sub.w   d0,d1
                and.w   d7,d1
                move.w  d1,$B6(a5)
                and.w   d7,d1
                move.w  d1,$116(a5)
                add.w   d0,d2
                and.w   d7,d2
                move.w  d2,$176(a5)
                add.w   d0,d2
                and.w   d7,d2
                move.w  d2,$1D6(a5)
                and.w   d7,d2
                move.w  d2,$236(a5)
                move.w  $B6(a5),d1
                move.b  4(a0),d2
                asl.w   #1,d2
                subi.w  #$80,d2
                add.w   d1,d2
                and.w   d7,d2
                move.w  d2,$296(a5)
                move.b  8(a0),d3
                asl.w   #1,d3
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$2F6(a5)
                move.b  $C(a0),d2
                asl.w   #1,d2
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$356(a5)
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$3B6(a5)
                move.w  d3,$596(a5)
                move.w  d3,$656(a5)
                move.b  $10(a0),d2
                asl.w   #1,d2
                addi.w  #$80,d2
                add.w   d1,d2
                and.w   d7,d2
                move.w  d2,$416(a5)
                move.b  $14(a0),d3
                asl.w   #1,d3
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$476(a5)
                move.b  $18(a0),d2
                asl.w   #1,d2
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$4D6(a5)
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$536(a5)
                move.w  d3,$5F6(a5)
                move.w  d3,$6B6(a5)
                moveq   #0,d0
                moveq   #0,d1
                moveq   #0,d2
                moveq   #0,d4
                move.b  $1C(a0),d0
                beq.s   loc_48B50
                ext.w   d0
                ext.l   d0
                move.w  d0,d1
                asr.w   #1,d1
                move.l  d0,d2
                divs.w  #3,d2
                asr.w   #2,d4
loc_48B50:                                              ; CODE XREF: Boss_SharpssteelCoreInit+14E   j
                move.w  $B2(a5),d3
                sub.w   d4,d3
                move.w  d3,$B4(a5)
                move.w  $112(a5),d3
                sub.w   d2,d3
                move.w  d3,$114(a5)
                move.w  $172(a5),d3
                sub.w   d2,d3
                move.w  d3,$174(a5)
                move.w  $1D2(a5),d3
                sub.w   d1,d3
                move.w  d3,$1D4(a5)
                move.w  $232(a5),d3
                sub.w   d0,d3
                move.w  d3,$234(a5)
                rts
; End of function Boss_SharpssteelCoreInit
; Core defeat sequence
Boss_SharpssteelCoreDefeat:                             ; CODE XREF: Boss_SharpssteelCoreInit+5C   p  ; was: sub_48B84
                movea.l #Boss_SharpssteelNeutralPose,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #7,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_SharpssteelCoreDefeat
; Loads animation frame delays for 8 frames
Boss_SharpssteelLoadAnimDelays:                         ; CODE XREF: Boss_SharpssteelResetPosition+48   p  ; was: sub_48B9A
                movea.w #(dword_FF9400-M68K_RAM),a1
                moveq   #7,d7
                jmp     Anim_LoadFrameDelays
; End of function Boss_SharpssteelLoadAnimDelays
; ---------------------------------------------------------------------------
byte_48BA6:     dc.b    $20, $20, 0, $10, $20, $20, 0, $18, $FF, $FF
                                        ; DATA XREF: Boss_SharpssteelInputHandler+36   o
byte_48BB0:     dc.b    $C, $C, 0, $38, 7, $C, 0, $40, 7, 7, 0, $40, $C, $C, 0, $48
                                        ; DATA XREF: Boss_SharpssteelHorizontalMovement:loc_48092   o
                dc.b    7, $C, 0, $50, $80, 1, 7, 7, 0, $50, $FF, $FF
byte_48BCC:     dc.b    $A, $A, 0, $38, 5, $A, 0, $40, 5, 5, 0, $40, $A, $A, 0, $48
                                        ; DATA XREF: Boss_SharpssteelHorizontalMovement+64   o
                dc.b    5, $A, 0, $50, $80, 1, 5, 5, 0, $50, $FF, $FF
byte_48BE8:     dc.b    $10, $18, 0, $58, 8, 8, 0, $58, $10, $14, 0, $60, $2C, $2C, 0, $60
                                        ; DATA XREF: Boss_SharpssteelSetRotation+12   o
                dc.b    $C, $14, 0, $68, $14, $14, 0, $68, $10, $12, 0, $70, $12, $12, 0, $70
                dc.b    $FF, $FE
byte_48C0A:     dc.b    5, $A, 0, 0, 8, 8, 0, 0, 5, $A, 0, 8, 8, 8, 0, 8
                                        ; DATA XREF: Boss_SharpssteelInitBattle+14   o
                                        ; Boss_SharpssteelInitBattle+3E   o
                dc.b    $80, 1, $FF, $FF
byte_48C1E:     dc.b    $A, $A, 0, $10, $10, $18, 0, $18, $C, $C, 0, $18, $FF, $FE
                                        ; DATA XREF: Boss_SharpssteelMultiPhaseAttack+A   o
byte_48C2C:     dc.b    $32, $32, 0, $20, 8, $A, 0, $28, 8, 8, 0, $28, $FF, $FE
                                        ; DATA XREF: Boss_SharpssteelMultiPhaseAttack+4A   o
byte_48C3A:     dc.b    5, 9, 0, $30, $12, $12, 0, $30, 6, $20, 0, $28, $11, $11, 0, $28
                                        ; DATA XREF: Boss_SharpssteelMultiPhaseAttack+E0   o
                dc.b    $FF, $FE
byte_48C4C:     dc.b    $13, $1C, 0, $80, $C, $C, 0, $80, $C, $40, 0, $88, $80, 1, 9, $D
                                        ; DATA XREF: Boss_SharpssteelAttackPattern2Alt+36   o
                dc.b    0, $88, $A, $A, 0, $88, $80, 2, $18, $1C, 0, $78, 6, 6, 0, $78
                dc.b    $FF, $FE
byte_48C6E:     dc.b    $13, $1C, 0, $90, $C, $C, 0, $90, $C, $40, 0, $98, $80, 1, 9, $D
                                        ; DATA XREF: Boss_SharpssteelBladeDefeat+3A   o
                dc.b    0, $98, $A, $A, 0, $98, $80, 2, $16, $1A, 0, $78, 6, 6, 0, $78
                dc.b    $FF, $FE
byte_48C90:     dc.b    6, $20, 0, 0, $A, $A, 0, 0, $10, $10, 0, $18, $FF, $FE
                                        ; DATA XREF: Boss_SharpssteelRisingAttack:loc_4828E   o
byte_48C9E:     dc.b    8, $10, 0, $A8, $20, $20, 0, $A8, $A, $30, 0, $B0, 4, 8, 0, $B0
                                        ; DATA XREF: Boss_SharpssteelComplexPhase+6C   o
                                        ; Boss_SharpssteelComplexPhase+A8   o
                dc.b    $80, 1, 2, 4, 0, $B0, $18, $18, 0, $B0, $FF, $FE
byte_48CBA:     dc.b    8, $10, 0, $B8, $20, $20, 0, $B8, $80, 2, $A, $30, 0, $C0, 4, 8
                                        ; DATA XREF: Boss_SharpssteelComplexPhase+F6   o
                                        ; Boss_SharpssteelComplexPhase+116   o
                dc.b    0, $C0, $80, 1, 2, 4, 0, $B8, $18, $18, 0, $B8, $FF, $FE
byte_48CD8:     dc.b    0, $18, $C0, $30, $E8, $40, $D0, 3, 0, 8, $D8, $2C, $F8, $28, $D4, $18
                                        ; DATA XREF: Boss_SharpssteelCoreInit+54   o
                dc.b    0, $10, $C0, $C8, $F0, $40, $38, $60, 0, 8, 4, 8, $F8, $FC, $F8, 0
                dc.b    0, $20, $E0, 0, $E0, $20, 0, $23, 0, $18, $B4, 0, $E8, $4C, 0, $F8
                dc.b    0, $20, 0, $D0, $E0, 0, $30, $48, $FC, 0, $7F, 8, $F0, $40, $C0, 3
                dc.b    $18, 8, $10, $D8, $D8, $E8, $F8, 3, 0, $10, $C0, $28, $F8, 0, $18, 3
                dc.b    $EC, $38, $30, 2, $20, $40, $C0, 3, $EC, $10, $D0, $CC, $F0, $30, $34, $30
                dc.b    0, $10, $E0, $C8, $F0, $20, $38, 8, $20, $10, $E0, $C8, $F0, $20, $38, 8
                dc.b    $F6, $20, $E0, $F8, $10, $60, $FC, $14, 0, $18, 0, $E0, $E8, 0, $20, $38
                dc.b    $F6, $30, $10, $28, $F0, $24, $20, $F8, $18, $10, $E0, $EA, $E0, $10, $14, $24
                dc.b    $18, $10, $A0, $E0, $E0, $34, $38, $20, $F0, $20, $F0, 8, $E8, 8, $17, $FC
byte_48D78:     dc.b    0, $20, $10, $20, $E0, $20, 0, 3, $F0, $1C, $24, $1C, $20, $38, $B0, $50
                                        ; DATA XREF: Boss_SharpssteelResetPosition+42   o
                dc.b    $12, $30, 0, $28, $E8, $30, $E0, $30, 0, $18, $C0, $30, $E8, $40, $D0, 3
                dc.b    0, $18, $C0, $30, $E8, $40, $D0, 3

; Spawns wave of 6 projectiles
