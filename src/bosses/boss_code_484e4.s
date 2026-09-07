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
                jmp     Sprite_InitMetaspriteSimple
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
                jsr     (Sprite_UpdateBossBladeSprite).l
                movea.w #(byte_FFCB00-M68K_RAM),a0
                andi.w  #$E7FF,$E(a0)
                jmp     Sprite_UpdateBossBladeSprite
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
                movea.l #word_3529E,a1
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
Boss_SharpssteelSpawnProjectileWave:                    ; CODE XREF: Boss_SharpssteelTimerCountdown+76   p  ; was: sub_48DA0
                lea     (word_1B514).l,a4
                moveq   #0,d5
                moveq   #0,d6
                moveq   #$12,d4
                moveq   #5,d7
                bsr.s   Projectile_SpawnRadialPattern
                moveq   #$10,d4
                moveq   #3,d7
; End of function Boss_SharpssteelSpawnProjectileWave
; Spawns projectiles in radial pattern using sine table
Projectile_SpawnRadialPattern:                          ; CODE XREF: Boss_SharpssteelSpawnProjectileWave+E   p  ; was: sub_48DB4
                                        ; Projectile_SpawnRadialPattern+70   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_48E28
                move.w  #$364,(a0)
                move.w  #$EC00,2(a0)
                move.w  #0,$E(a0)
                move.l  #off_1A0F1A,8(a0)
                move.b  #$20,$20(a0)                    ; ' '
                moveq   #0,d0
                move.b  byte_48E2A(pc,d5.w),d0
                asl.w   #1,d0
                move.w  -$80(a4,d0.w),d1
                move.w  (a4,d0.w),d2
                ext.l   d1
                ext.l   d2
                muls.w  d4,d1
                muls.w  d4,d2
                move.l  d1,$1C(a0)
                asr.l   #1,d2
                move.l  d2,$18(a0)
                move.b  byte_48E34(pc,d6.w),d0
                ext.w   d0
                bpl.s   loc_48E0A
                ori.w   #$800,$E(a0)
loc_48E0A:                                              ; CODE XREF: Projectile_SpawnRadialPattern+4E   j
                addi.w  #$120,d0
                move.w  d0,$10(a0)
                move.b  byte_48E34+1(pc,d6.w),d0
                ext.w   d0
                addi.w  #$160,d0
                move.w  d0,$14(a0)
                addq.w  #1,d5
                addq.w  #2,d6
                dbf     d7,Projectile_SpawnRadialPattern
locret_48E28:                                           ; CODE XREF: Projectile_SpawnRadialPattern+6   j
                rts
; End of function Projectile_SpawnRadialPattern
; ---------------------------------------------------------------------------
byte_48E2A:     dc.b    $B4, $B8, $BC, $C4, $C8, $CC, $B6, $BA, $C6, $CA
                                        ; DATA XREF: Projectile_SpawnRadialPattern+28   r
byte_48E34:     dc.b    $D0, 0, $E0, $F8, $F0, $F0, $10, $F0, $20, $F8
                                        ; DATA XREF: Projectile_SpawnRadialPattern+48   r
                                        ; Projectile_SpawnRadialPattern+5E   r
                dc.b    $30, 0, $C0, $24, $D0, $20, $30, $20, $40, $24

; Handles falling bomb with gravity and explosion
Enemy_FallingBombLogic:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_48E48
                tst.w   (word_FF808C).w
                bpl.w   loc_48EDA
                addi.l  #$B00,$1C(a5)
                tst.w   4(a5)
                bne.s   loc_48E98
                tst.w   $1C(a5)
                bmi.s   locret_48E96
                addq.w  #2,4(a5)
                bset    #4,$E(a5)
                bset    #7,$E(a5)
                move.b  #$C0,$21(a5)
                move.w  #1,$24(a5)
                move.w  #$64,$26(a5)                    ; 'd'
                move.l  #$F60AF60A,$28(a5)
                move.l  #$FC04FC04,$2C(a5)
locret_48E96:                                           ; CODE XREF: Enemy_FallingBombLogic+1A   j
                                        ; Enemy_FallingBombLogic+D4   j
                rts
; ---------------------------------------------------------------------------
loc_48E98:                                              ; CODE XREF: Enemy_FallingBombLogic+14   j
                bclr    #7,$22(a5)
                beq.s   loc_48EAA
                bclr    #4,$22(a5)
                beq.s   loc_48EDA
                bra.s   loc_48EB0
; ---------------------------------------------------------------------------
loc_48EAA:                                              ; CODE XREF: Enemy_FallingBombLogic+56   j
                tst.w   $24(a5)
                bpl.s   loc_48EEC
loc_48EB0:                                              ; CODE XREF: Enemy_FallingBombLogic+60   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_48EDA
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                moveq   #$15,d0
                jsr     (loc_2BD20).l
                move.w  #$E440,2(a0)
                move.l  #$2000,$1C(a0)
loc_48EDA:                                              ; CODE XREF: Enemy_FallingBombLogic+4   j
                                        ; Enemy_FallingBombLogic+5E   j
                clr.l   $1C(a5)
                move.l  #off_E95A4,8(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_48EEC:                                              ; CODE XREF: Enemy_FallingBombLogic+66   j
                cmpi.w  #$150,$14(a5)
                bmi.s   loc_48F18
                move.w  $E(a5),d0
                andi.w  #$8000,d0
                movem.l d0,-(sp)
                move.l  #$FFFC8000,$1C(a5)
                jsr     (loc_3F182).l
                movem.l (sp)+,d0
                or.w    d0,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_48F18:                                              ; CODE XREF: Enemy_FallingBombLogic+AA   j
                tst.w   $48(a5)
                bne.w   locret_48E96
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  $10(a0),d0
                cmp.w   $10(a5),d0
                bpl.s   locret_48F60
                addi.w  #$F0,d0
                cmp.w   $10(a5),d0
                bmi.s   locret_48F60
                move.w  $14(a0),d0
                subi.w  #$A,d0
                cmp.w   $14(a5),d0
                bpl.s   locret_48F60
                addi.w  #$10,d0
                cmp.w   $14(a5),d0
                bmi.s   locret_48F60
                addq.w  #1,$48(a5)
                bclr    #4,$E(a5)
                move.w  #$FFFE,$1C(a5)
locret_48F60:                                           ; CODE XREF: Enemy_FallingBombLogic+E4   j
                                        ; Enemy_FallingBombLogic+EE   j
                rts
; End of function Enemy_FallingBombLogic
; Spawns 14 debris particles during defeat
Boss_SharpssteelSpawnDebris:                            ; CODE XREF: Boss_SharpssteelMain+22   j  ; was: sub_48F62
                move.b  #1,(byte_FF830E).w
                clr.w   8(a5)
                bset    #0,(byte_FFA272).w
                move.w  #8,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                clr.w   2(a5)
                move.w  #$80,$48(a5)
                movea.w a5,a0
                moveq   #0,d5
                moveq   #0,d6
                moveq   #$D,d7
loc_48F9C:                                              ; CODE XREF: Boss_SharpssteelSpawnDebris+98   j
                movem.l d6-d7/a0,-(sp)
                jsr     (RandomNumber).l
                movem.l (sp)+,d6-d7/a0
                lea     $60(a0),a0
                move.w  #$3BC,(a0)
                bset    #1,2(a0)
                bset    #3,2(a0)
                bset    #2,2(a0)
                move.w  d5,$48(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                swap    d0
                asr.l   #1,d0
                addi.l  #$12000,d0
                move.l  d0,$18(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                addq.w  #1,d6
                btst    #0,d6
                bne.s   loc_48FF0
                neg.w   d0
loc_48FF0:                                              ; CODE XREF: Boss_SharpssteelSpawnDebris+8A   j
                swap    d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                addq.w  #1,d5
                dbf     d7,loc_48F9C
                rts
; End of function Boss_SharpssteelSpawnDebris
; Creates screen shake and debris during destruction
Effect_ShipDestructionDebris:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_49000
                move.w  #4,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                addq.w  #1,$48(a5)
                move.w  $48(a5),d0
                bset    #7,2(a5)
                btst    #0,d0
                beq.s   loc_49026
                bclr    #7,2(a5)
loc_49026:                                              ; CODE XREF: Effect_ShipDestructionDebris+1E   j
                andi.w  #7,d0
                bne.s   loc_4906E
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_49040
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
loc_49040:                                              ; CODE XREF: Effect_ShipDestructionDebris+34   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_4906E
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                neg.l   d0
                asr.l   #3,d0
                move.l  d0,$18(a0)
                move.l  #off_E95DC,8(a0)
                jsr     (Projectile_InitType88).l
loc_4906E:                                              ; CODE XREF: Effect_ShipDestructionDebris+2A   j
                                        ; Effect_ShipDestructionDebris+46   j
                subi.l  #$4000,$18(a5)
                tst.w   $18(a5)
                bpl.s   loc_49086
                addi.l  #$1000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_49086:                                              ; CODE XREF: Effect_ShipDestructionDebris+7A   j
                subi.l  #$1000,$1C(a5)
                rts
; End of function Effect_ShipDestructionDebris
; Spawns 6 radial projectiles with angle offsets
Boss_SharpssteelSpawnSixRadialShots:                    ; CODE XREF: Boss_SharpssteelComplexPhase+D2   p  ; was: sub_49090
                move.l  #$FFFA0000,d6
                moveq   #5,d7
loc_49098:                                              ; CODE XREF: Boss_SharpssteelSpawnSixRadialShots+10   j
                bsr.s   Projectile_InitSharpssteelShot
                addi.l  #$8000,d6
                dbf     d7,loc_49098
                rts
; End of function Boss_SharpssteelSpawnSixRadialShots
; Initializes projectile with position and trajectory
Projectile_InitSharpssteelShot:                         ; CODE XREF: Boss_SharpssteelSpawnSixRadialShots:loc_49098   p  ; was: sub_490A6
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_490FE
                move.w  #$414,(a0)
                move.w  #$C480,2(a0)
                move.b  #0,$20(a0)
                move.w  $4F0(a5),$10(a0)
                move.w  $4F4(a5),$14(a0)
                move.l  $4E8(a5),8(a0)
                move.w  $4EE(a5),$E(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$F010FA06,$2C(a0)
                move.w  #$56,$26(a0)                    ; 'V'
                move.l  d6,$1C(a0)
                move.w  d7,$48(a0)
                andi.w  #1,$48(a0)
                move.w  #$F,$4A(a0)
locret_490FE:                                           ; CODE XREF: Projectile_InitSharpssteelShot+6   j
                rts
; End of function Projectile_InitSharpssteelShot
; Toggles sprite flash bit based on timer
Boss_JampanFlashToggle:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_49100
                tst.w   (word_FF808C).w
                bpl.s   loc_49126
                bset    #7,2(a5)
                move.w  $4A(a5),d0
                andi.w  #1,d0
                cmp.w   $48(a5),d0
                beq.s   loc_49120
                bclr    #7,2(a5)
loc_49120:                                              ; CODE XREF: Boss_JampanFlashToggle+18   j
                subq.w  #1,$4A(a5)
                bpl.s   locret_4912C
loc_49126:                                              ; CODE XREF: Boss_JampanFlashToggle+4   j
                bset    #4,2(a5)
locret_4912C:                                           ; CODE XREF: Boss_JampanFlashToggle+24   j
                rts
; End of function Boss_JampanFlashToggle
; Main boss handler
Boss_JampanMain:                                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_4912E
                bsr.w   Boss_JampanDispatcher
                bsr.w   Boss_JampanCheckHealth
                rts
; End of function Boss_JampanMain
; Boss state dispatcher
Boss_JampanDispatcher:                                  ; CODE XREF: Boss_JampanMain   p  ; was: sub_49138
                tst.w   4(a5)
                beq.w   loc_491CA
                btst    #1,$4C(a5)
                bne.s   loc_4915C
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_4915C
                move.w  $4E(a5),d0
                beq.s   loc_4915C
                sub.w   d0,(word_FF8234).w
loc_4915C:                                              ; CODE XREF: Boss_JampanDispatcher+E   j
                                        ; Boss_JampanDispatcher+18   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_4918E
                btst    #1,(byte_FF80EC).w
                bne.s   loc_4918E
                tst.w   (word_FF8200).w
                bne.s   loc_4918E
                move.b  #2,(byte_FF80EC).w
                bset    #0,$4C(a5)
                clr.l   (dword_FF8240).w
                move.w  #$52,4(a5)                      ; 'R'
                bset    #0,(byte_FFA272).w
loc_4918E:                                              ; CODE XREF: Boss_JampanDispatcher+2A   j
                                        ; Boss_JampanDispatcher+32   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$58(a5)
                btst    #2,$4C(a5)
                beq.s   loc_491CA
                tst.l   $54(a5)
                beq.s   loc_491CA
                move.l  $54(a5),d0
                add.l   d0,$1C(a5)
                move.l  $1C(a5),d0
                bpl.s   loc_491BE
                neg.l   d0
loc_491BE:                                              ; CODE XREF: Boss_JampanDispatcher+82   j
                cmpi.l  #$10000,d0
                bne.s   loc_491CA
                neg.l   $54(a5)
loc_491CA:                                              ; CODE XREF: Boss_JampanDispatcher+4   j
                                        ; Boss_JampanDispatcher+6E   j
                move.w  4(a5),d0
                lea     off_491D6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanDispatcher
; ---------------------------------------------------------------------------
off_491D6:      dc.w    Boss_JampanIdleState-*          ; DATA XREF: Boss_JampanDispatcher+96   o
                dc.w    Boss_JampanMoveState-*
                dc.w    Boss_JampanDefendState-*
                dc.w    Boss_JampanJumpState-*
                dc.w    Boss_JampanDashState-*
                dc.w    Boss_JampanShootProjectile-*
                dc.w    Boss_JampanSpawnMinion-*
                dc.w    Projectile_JampanBullet-*
                dc.w    Projectile_JampanWave-*
                dc.w    Projectile_JampanHoming-*
                dc.w    Enemy_JampanMinion-*
                dc.w    Boss_JampanReturnToIdle-*
                dc.w    Boss_JampanBounceAttack-*
                dc.w    Boss_JampanHorizontalDrift-*
                dc.w    Boss_JampanWaitScreenShake-*
                dc.w    Boss_JampanCenterHorizontal-*
                dc.w    Boss_JampanDescendToHeight-*
                dc.w    Boss_JampanDefeatInit-*
                dc.w    Boss_JampanDefeatTeleport-*
                dc.w    Boss_JampanDefeatFade-*
                dc.w    Boss_JampanTeleportAttempt-*
                dc.w    nullsub_98-*
                dc.w    nullsub_99-*
                dc.w    Boss_JampanWaitVelocityStop-*
                dc.w    Boss_JampanPreAttackDelay-*
                dc.w    Boss_JampanAttackWarmup-*
                dc.w    Boss_JampanAttackPrepare-*
                dc.w    Boss_JampanAttackRiseUp-*
                dc.w    Boss_JampanAttackDescend-*
                dc.w    Boss_JampanAttackFinish-*
                dc.w    Boss_JampanPostAttackDelay-*
                dc.w    Boss_JampanResetFromAttack-*
                dc.w    Boss_JampanDefeatTransition-*
                dc.w    Boss_JampanDefeatFadeout-*
                dc.w    Boss_JampanDefeatInitAlt-*
                dc.w    Boss_JampanDefeatWait-*
                dc.w    Boss_JampanReturnToCenter-*
                dc.w    Boss_JampanWaitRotation-*
                dc.w    Boss_JampanDebrisFadeout-*
                dc.w    Boss_JampanRotateToCenter-*
                dc.w    nullsub_100-*
                dc.w    Boss_JampanDefeatFlash-*
                dc.w    Boss_JampanDefeatShake-*
                dc.w    Boss_JampanDefeatBreakup-*
                dc.w    Boss_JampanDefeatSparkInit-*
                dc.w    Boss_JampanDefeatSparkMove-*
                dc.w    Boss_JampanDefeatSparkFade-*
                dc.w    Boss_JampanDefeatSparkWait-*
                dc.w    Boss_JampanDefeatEndInit-*
                dc.w    Boss_JampanDefeatEndFade-*
                dc.w    Boss_JampanDefeatCleanupInit-*
                dc.w    Boss_JampanDefeatCleanupWait-*
                dc.w    nullsub_101-*

; Idle state handler
Boss_JampanIdleState:                                   ; DATA XREF: ROM:off_491D6   o  ; was: sub_49240
                tst.w   (word_FFF720).w
                bmi.s   locret_49256
                addq.w  #2,4(a5)
                move.w  #$218,d0
                moveq   #0,d1
                jmp     Sprite_ClearAllExcept
; ---------------------------------------------------------------------------
locret_49256:                                           ; CODE XREF: Boss_JampanIdleState+4   j
                rts
; End of function Boss_JampanIdleState
; Movement state handler
Boss_JampanMoveState:                                   ; DATA XREF: ROM:000491D8   o  ; was: sub_49258
                move.b  #1,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
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
                clr.w   (dword_FF9424+2).w
                clr.w   (dword_FF9428).w
                clr.w   (dword_FF9428+2).w
                clr.w   (dword_FF942C).w
                bsr.w   Boss_JampanAttackState
                move.b  #4,(byte_FFA420).w
                move.w  #$1E8,$10(a5)
                move.w  #$F0,$14(a5)
                move.w  #$100,(dword_FF9404).w
                move.w  #$100,(dword_FF9408).w
                move.b  #$40,$20(a5)                    ; '@'
                move.w  #$D00,2(a5)
                move.b  #$10,$21(a5)
                move.b  #$80,$23(a5)
                move.l  #$F010F010,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$20,$24(a5)                    ; ' '
loc_492F4:                                              ; CODE XREF: Boss_JampanDefeatEndFade+12   p
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                lea     $60(a0),a0
                move.w  #$224,(a0)
                move.w  #$4D00,2(a0)
                move.l  #word_EC25C,8(a0)
                move.w  #$6B00,$E(a0)
                move.b  #4,$20(a0)
                move.w  #$C8C0,$50(a0)
                lea     $60(a0),a0
                move.w  #$220,(a0)
                move.w  #$CD00,2(a0)
                move.l  #word_EC244,8(a0)
                move.w  #$6B00,$E(a0)
                move.b  #4,$20(a0)
                move.w  #$C8C0,$50(a0)
                lea     $60(a0),a0
                move.w  #$224,(a0)
                move.w  #$4D00,2(a0)
                move.l  #word_EC25C,8(a0)
                move.w  #$6B00,$E(a0)
                move.b  #4,$20(a0)
                move.w  #$C920,$50(a0)
                lea     $60(a0),a0
                move.w  #$220,(a0)
                move.w  #$CD00,2(a0)
                move.l  #word_EC244,8(a0)
                move.w  #$6B00,$E(a0)
                move.b  #4,$20(a0)
                move.w  #$C920,$50(a0)
                lea     $60(a0),a0
                move.w  #$228,(a0)
                move.w  #$100,2(a0)
                lea     $60(a0),a0
                move.w  #$F,d7
                clr.w   d1
loc_493B0:                                              ; CODE XREF: Boss_JampanMoveState+1B8   j
                move.w  #$CD00,2(a0)
                move.w  #$6B00,$E(a0)
                move.w  d1,d0
                add.w   d0,d0
                lea     word_4945E(pc),a1
                nop
                move.w  (a1,d0.w),(a0)
                lea     word_4949E(pc),a1
                nop
                move.w  (a1,d0.w),$48(a0)
                lea     word_4947E(pc),a1
                nop
                move.w  (a1,d0.w),d2
                or.w    d2,$E(a0)
                lea     word_494BE(pc),a1
                nop
                move.w  (a1,d0.w),$4A(a0)
                lea     word_494DE(pc),a1
                nop
                move.w  (a1,d0.w),$4C(a0)
                add.w   d0,d0
                lea     off_494FE(pc),a1
                nop
                move.l  (a1,d0.w),8(a0)
                addq.w  #1,d1
                lea     $60(a0),a0
                dbf     d7,loc_493B0
                move.w  #5,d7
                clr.w   d1
loc_4941A:                                              ; CODE XREF: Boss_JampanMoveState+1DE   j
                move.w  #$10,(a0)
                move.w  #$4D00,2(a0)
                move.w  #$6B00,$E(a0)
                move.l  #word_EC238,8(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4941A
                bsr.w   Boss_JampanDamageHandler
                rts
; End of function Boss_JampanMoveState
; Attack state handler
Boss_JampanAttackState:                                 ; CODE XREF: Boss_JampanMoveState+4C   p  ; was: sub_49440
                lea     word_4944E(pc),a0
                nop
                jsr     (Gfx_LoadCompressedTiles).l
                rts
; End of function Boss_JampanAttackState
; ---------------------------------------------------------------------------
word_4944E:     dc.w    $6100, $2000, $202, $7879, $7A7C, $7D7E, $8081, 0
                                        ; DATA XREF: Boss_JampanAttackState   o
word_4945E:     dc.w    $234, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
                                        ; DATA XREF: Boss_JampanMoveState+168   o
word_4947E:     dc.w    0, 0, 0, $1000, $1000, $1000, $1000, $1000, $1000, $1000, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: Boss_JampanMoveState+17E   o
word_4949E:     dc.w    $24, $30, $30, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24
                                        ; DATA XREF: Boss_JampanMoveState+172   o
word_494BE:     dc.w    $80, $A8, $58, $20, $40, $60, $80, $A0, $C0, $E0, $30, $50, $70, $90, $B0, $D0
                                        ; DATA XREF: Boss_JampanMoveState+18C   o
word_494DE:     dc.w    $FFE0, $FF80, $FF80, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40
                                        ; DATA XREF: Boss_JampanMoveState+198   o
off_494FE:      dc.l    word_EC238                      ; DATA XREF: Boss_JampanMoveState+1A6   o
                dc.l    word_EC250
                dc.l    word_EC250
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C

; Defense state handler
Boss_JampanDefendState:                                 ; DATA XREF: ROM:000491DA   o  ; was: sub_4953E
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$48(a5)
                bne.s   locret_4956E
                bsr.w   Boss_JampanDamageHandler
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                move.w  #4,(dword_FF9410).w
                move.w  #4,(dword_FF9414).w
                move.w  #3,$48(a5)
                addq.w  #2,4(a5)
locret_4956E:                                           ; CODE XREF: Boss_JampanDefendState+8   j
                rts
; End of function Boss_JampanDefendState
; Jump state handler
Boss_JampanJumpState:                                   ; DATA XREF: ROM:000491DC   o  ; was: sub_49570
                addi.l  #$2000,$1C(a5)
                addi.l  #-$10000,$10(a5)
                bsr.w   Boss_JampanDamageHandler
                cmpi.w  #$110,$14(a5)
                bcs.s   locret_495C4
                move.w  #$110,$14(a5)
                andi.l  #$FFFF0000,$14(a5)
                move.l  $1C(a5),d0
                neg.l   d0
                addi.l  #$2000,d0
                move.l  d0,$1C(a5)
                addq.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #$A1,d0
                jsr     (Sound_PlaySFX).l
locret_495C4:                                           ; CODE XREF: Boss_JampanJumpState+1A   j
                rts
; End of function Boss_JampanJumpState
; Dash attack state
Boss_JampanDashState:                                   ; DATA XREF: ROM:000491DE   o  ; was: sub_495C6
                addi.l  #$2000,$1C(a5)
                addi.l  #-$10000,$10(a5)
                bsr.w   Boss_JampanDamageHandler
                tst.l   $1C(a5)
                bne.s   locret_4960E
                subq.w  #1,$48(a5)
                beq.s   loc_495EC
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_495EC:                                              ; CODE XREF: Boss_JampanDashState+1E   j
                bset    #2,$4C(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$54(a5)
                clr.w   (dword_FF9410).w
                clr.w   (dword_FF9414).w
                addq.w  #2,4(a5)
locret_4960E:                                           ; CODE XREF: Boss_JampanDashState+18   j
                rts
; End of function Boss_JampanDashState
; Shoots projectile
Boss_JampanShootProjectile:                             ; DATA XREF: ROM:000491E0   o  ; was: sub_49610
                bsr.w   Boss_JampanDamageHandler
                cmpi.w  #$100,(dword_FF9404).w
                beq.s   loc_49638
                cmpi.w  #$100,(dword_FF9404).w
                bcs.s   loc_4962E
                subq.w  #4,(dword_FF9404).w
                subq.w  #4,(dword_FF9408).w
                rts
; ---------------------------------------------------------------------------
loc_4962E:                                              ; CODE XREF: Boss_JampanShootProjectile+12   j
                addq.w  #4,(dword_FF9404).w
                addq.w  #4,(dword_FF9408).w
                rts
; ---------------------------------------------------------------------------
loc_49638:                                              ; CODE XREF: Boss_JampanShootProjectile+A   j
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanShootProjectile
; Spawns minion enemy
Boss_JampanSpawnMinion:                                 ; DATA XREF: ROM:000491E2   o  ; was: sub_4964A
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                tst.w   (word_FFC6D2).w
                bne.s   locret_49664
                clr.w   (word_FFC732).w
                clr.w   (word_FFC7F2).w
                addq.w  #2,4(a5)
locret_49664:                                           ; CODE XREF: Boss_JampanSpawnMinion+C   j
                rts
; End of function Boss_JampanSpawnMinion
; Bullet projectile handler
Projectile_JampanBullet:                                ; DATA XREF: ROM:000491E4   o  ; was: sub_49666
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                move.w  (dword_FF9424+2).w,d0
                beq.s   loc_49684
                tst.w   d0
                bmi.s   loc_4967E
                subq.w  #1,(dword_FF9424+2).w
                rts
; ---------------------------------------------------------------------------
loc_4967E:                                              ; CODE XREF: Projectile_JampanBullet+10   j
                addq.w  #1,(dword_FF9424+2).w
                rts
; ---------------------------------------------------------------------------
loc_49684:                                              ; CODE XREF: Projectile_JampanBullet+C   j
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                addq.w  #2,4(a5)
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                move.b  #$8A,d0
                jsr     (Input_CheckButtonMode).l
                rts
; End of function Projectile_JampanBullet
; Wave projectile handler
Projectile_JampanWave:                                  ; DATA XREF: ROM:000491E6   o  ; was: sub_496AA
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                tst.w   (word_FF80C2).w
                bne.s   locret_496CC
                clr.b   (byte_FF80EC).w
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                addq.w  #2,4(a5)
locret_496CC:                                           ; CODE XREF: Projectile_JampanWave+C   j
                rts
; End of function Projectile_JampanWave
; Homing projectile handler
Projectile_JampanHoming:                                ; DATA XREF: ROM:000491E8   o  ; was: sub_496CE
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                tst.w   (word_FFC6D2).w
                bne.s   locret_496EC
                move.w  #1,(word_FFC852).w
                move.w  #1,(word_FFC8B2).w
                addq.w  #2,4(a5)
locret_496EC:                                           ; CODE XREF: Projectile_JampanHoming+C   j
                rts
; End of function Projectile_JampanHoming
; Minion enemy handler
Enemy_JampanMinion:                                     ; DATA XREF: ROM:000491EA   o  ; was: sub_496EE
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanTeleportInit
                bsr.w   nullsub_97
                bsr.w   Boss_JampanDamageHandler
                tst.w   (word_FF8234).w
                ble.w   loc_49790
                move.w  (word_FFA000).w,d0
                tst.w   (word_FFFF0E).w
                bne.s   loc_4971E
                andi.w  #$3F,d0                         ; '?'
                bne.w   locret_497A8
                bra.s   loc_49726
; ---------------------------------------------------------------------------
loc_4971E:                                              ; CODE XREF: Enemy_JampanMinion+24   j
                andi.w  #$1F,d0
                bne.w   locret_497A8
loc_49726:                                              ; CODE XREF: Enemy_JampanMinion+2E   j
                move.b  (dword_FFFF08).w,d0
                andi.b  #7,d0
                beq.s   loc_4975E
                cmpi.w  #1,d0
                beq.s   loc_49750
                cmpi.w  #2,d0
                beq.s   loc_49782
                bset    #1,$4C(a5)
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                rts
; ---------------------------------------------------------------------------
loc_49750:                                              ; CODE XREF: Enemy_JampanMinion+46   j
                move.w  #2,$4E(a5)
                move.w  #$22,4(a5)                      ; '"'
                rts
; ---------------------------------------------------------------------------
loc_4975E:                                              ; CODE XREF: Enemy_JampanMinion+40   j
                clr.w   (word_FFC8B2).w
                move.w  #$FFFF,(word_FFC6D2).w
                move.w  #$FFFF,(word_FFC792).w
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #8,$4E(a5)
                move.w  #$2E,4(a5)                      ; '.'
                rts
; ---------------------------------------------------------------------------
loc_49782:                                              ; CODE XREF: Enemy_JampanMinion+4C   j
                move.w  #$A,$4E(a5)
                move.w  #$3E,4(a5)                      ; '>'
                rts
; ---------------------------------------------------------------------------
loc_49790:                                              ; CODE XREF: Enemy_JampanMinion+18   j
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                bset    #1,$4C(a5)
                move.w  #$16,4(a5)
locret_497A8:                                           ; CODE XREF: Enemy_JampanMinion+2A   j
                                        ; Enemy_JampanMinion+34   j
                rts
; End of function Enemy_JampanMinion
; Returns boss to idle after velocity dampening
Boss_JampanReturnToIdle:                                ; DATA XREF: ROM:000491EC   o  ; was: sub_497AA
                bsr.w   Boss_JampanDamageHandler
                tst.w   (dword_FF9424+2).w
                beq.s   loc_497C4
                tst.w   (dword_FF9424+2).w
                bpl.s   loc_497C0
                addq.w  #1,(dword_FF9424+2).w
                bra.s   loc_497C4
; ---------------------------------------------------------------------------
loc_497C0:                                              ; CODE XREF: Boss_JampanReturnToIdle+E   j
                subq.w  #1,(dword_FF9424+2).w
loc_497C4:                                              ; CODE XREF: Boss_JampanReturnToIdle+8   j
                                        ; Boss_JampanReturnToIdle+14   j
                tst.w   (dword_FF9428).w
                beq.s   loc_497DC
                tst.w   (dword_FF9428).w
                bpl.s   loc_497D6
                addq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_497D6:                                              ; CODE XREF: Boss_JampanReturnToIdle+24   j
                subq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_497DC:                                              ; CODE XREF: Boss_JampanReturnToIdle+1E   j
                tst.w   (dword_FF9424+2).w
                bne.s   locret_497FC
                bclr    #2,$4C(a5)
                clr.l   $54(a5)
                move.w  #1,$1C(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_497FC:                                           ; CODE XREF: Boss_JampanReturnToIdle+36   j
                rts
; End of function Boss_JampanReturnToIdle
; Handles bounce attack with gravity and collision
Boss_JampanBounceAttack:                                ; DATA XREF: ROM:000491EE   o  ; was: sub_497FE
                bsr.w   Boss_JampanDamageHandler
                addi.l  #$2000,$1C(a5)
                cmpi.w  #$110,$14(a5)
                bcs.s   locret_49860
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #$A1,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$110,$14(a5)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                tst.w   $1C(a5)
                beq.s   loc_49846
                subq.w  #1,$48(a5)
                bne.s   locret_49860
loc_49846:                                              ; CODE XREF: Boss_JampanBounceAttack+40   j
                clr.l   $1C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #$FFFE,(word_FFC6D2).w
                move.w  #$FFFE,(word_FFC792).w
                addq.w  #2,4(a5)
locret_49860:                                           ; CODE XREF: Boss_JampanBounceAttack+12   j
                                        ; Boss_JampanBounceAttack+46   j
                rts
; End of function Boss_JampanBounceAttack
; Adjusts horizontal position based on player
Boss_JampanHorizontalDrift:                             ; DATA XREF: ROM:000491F0   o  ; was: sub_49862
                cmpi.w  #$13A0,$58(a5)
                bcs.s   loc_49878
                subq.w  #2,(dword_FF9408).w
                subi.l  #$8000,$10(a5)
                bra.s   loc_49884
; ---------------------------------------------------------------------------
loc_49878:                                              ; CODE XREF: Boss_JampanHorizontalDrift+6   j
                addq.w  #2,(dword_FF9408).w
                addi.l  #$8000,$10(a5)
loc_49884:                                              ; CODE XREF: Boss_JampanHorizontalDrift+14   j
                bsr.w   Boss_JampanDamageHandler
                addq.w  #8,(word_FF8234).w
                subq.w  #1,$48(a5)
                bne.s   locret_49896
                addq.w  #2,4(a5)
locret_49896:                                           ; CODE XREF: Boss_JampanHorizontalDrift+2E   j
                rts
; End of function Boss_JampanHorizontalDrift
; Waits for screen shake to complete
Boss_JampanWaitScreenShake:                             ; DATA XREF: ROM:000491F2   o  ; was: sub_49898
                bsr.w   Boss_JampanDamageHandler
                addq.w  #8,(word_FF8234).w
                btst    #0,(byte_FF8260).w
                beq.s   locret_498BE
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                addq.w  #2,4(a5)
locret_498BE:                                           ; CODE XREF: Boss_JampanWaitScreenShake+E   j
                rts
; End of function Boss_JampanWaitScreenShake
; Centers boss horizontally with oscillation
Boss_JampanCenterHorizontal:                            ; DATA XREF: ROM:000491F4   o  ; was: sub_498C0
                cmpi.w  #$100,(dword_FF9408).w
                bcc.s   loc_498D6
                addq.w  #2,(dword_FF9408).w
                addi.l  #$8000,$10(a5)
                bra.s   loc_498E2
; ---------------------------------------------------------------------------
loc_498D6:                                              ; CODE XREF: Boss_JampanCenterHorizontal+6   j
                subq.w  #2,(dword_FF9408).w
                subi.l  #$8000,$10(a5)
loc_498E2:                                              ; CODE XREF: Boss_JampanCenterHorizontal+14   j
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$48(a5)
                bne.s   locret_498F0
                addq.w  #2,4(a5)
locret_498F0:                                           ; CODE XREF: Boss_JampanCenterHorizontal+2A   j
                rts
; End of function Boss_JampanCenterHorizontal
; Descends boss to Y position $F0
Boss_JampanDescendToHeight:                             ; DATA XREF: ROM:000491F6   o  ; was: sub_498F2
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$14(a5)
                cmpi.w  #$F0,$14(a5)
                bhi.s   locret_4992E
                move.w  #$F0,$14(a5)
                bset    #2,$4C(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$54(a5)
                bclr    #1,$4C(a5)
                move.w  #$12,4(a5)
locret_4992E:                                           ; CODE XREF: Boss_JampanDescendToHeight+12   j
                rts
; End of function Boss_JampanDescendToHeight
; Defeat sequence initialization
Boss_JampanDefeatInit:                                  ; DATA XREF: ROM:000491F8   o  ; was: sub_49930
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                clr.w   (word_FFC732).w
                clr.w   (word_FFC7F2).w
                clr.w   (word_FFC852).w
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanDefeatInit
; Defeat teleport effect
Boss_JampanDefeatTeleport:                              ; DATA XREF: ROM:000491FA   o  ; was: sub_49950
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$48(a5)
                bne.s   locret_49990
                addq.w  #2,4(a5)
                bclr    #1,$4C(a5)
                clr.w   (word_FFC8B2).w
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_49984
                move.w  #2,(word_FFC792).w
                move.w  #$FFFE,$5A(a5)
                rts
; ---------------------------------------------------------------------------
loc_49984:                                              ; CODE XREF: Boss_JampanDefeatTeleport+24   j
                move.w  #2,(word_FFC6D2).w
                move.w  #2,$5A(a5)
locret_49990:                                           ; CODE XREF: Boss_JampanDefeatTeleport+C   j
                rts
; End of function Boss_JampanDefeatTeleport
; Defeat fade out animation
Boss_JampanDefeatFade:                                  ; DATA XREF: ROM:000491FC   o  ; was: sub_49992
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                tst.w   (word_FFC6D2).w
                bne.s   locret_49A12
                tst.w   (word_FFC792).w
                bne.s   locret_49A12
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_49A12
                andi.w  #$7FFF,(word_FFC862).w
                move.w  #$238,(a0)
                move.w  #$CD00,2(a0)
                move.l  #word_EC238,8(a0)
                move.w  #$EB00,$E(a0)
                move.l  (dword_FFC870).w,$10(a0)
                move.l  (dword_FFC874).w,$14(a0)
                move.b  #4,$20(a0)
                move.w  #$80,$26(a0)
                andi.w  #$7FFF,(word_FFC862).w
                addq.w  #2,4(a5)
                tst.w   (word_FFFF0E).w
                bne.s   loc_49A0C
                move.w  #$40,$48(a5)                    ; '@'
                rts
; ---------------------------------------------------------------------------
loc_49A0C:                                              ; CODE XREF: Boss_JampanDefeatFade+70   j
                move.w  #$10,$48(a5)
locret_49A12:                                           ; CODE XREF: Boss_JampanDefeatFade+10   j
                                        ; Boss_JampanDefeatFade+16   j
                rts
; End of function Boss_JampanDefeatFade
; Attempts teleport with position checks
Boss_JampanTeleportAttempt:                             ; DATA XREF: ROM:000491FE   o  ; was: sub_49A14
                eori.w  #$8000,(word_FFC862).w
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                move.w  $5A(a5),d0
                move.w  d0,d1
                add.w   $58(a5),d0
                cmpi.w  #$1440,d0
                bhi.s   loc_49A66
                cmpi.w  #$1300,d0
                bcs.s   loc_49A66
                add.w   d1,$10(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_49A78
                ori.w   #$8000,(word_FFC862).w
                move.w  #1,(word_FFC8B2).w
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                tst.w   (word_FF8234).w
                ble.s   loc_49A66
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_49A66:                                              ; CODE XREF: Boss_JampanTeleportAttempt+1C   j
                                        ; Boss_JampanTeleportAttempt+22   j
                ori.w   #$8000,(word_FFC862).w
                bset    #1,$4C(a5)
                move.w  #$12,4(a5)
locret_49A78:                                           ; CODE XREF: Boss_JampanTeleportAttempt+2C   j
                rts
; End of function Boss_JampanTeleportAttempt
nullsub_98:                                             ; DATA XREF: ROM:00049200   o
                rts
; End of function nullsub_98

nullsub_99:                                             ; DATA XREF: ROM:00049202   o
                rts
; End of function nullsub_99

; Waits for velocity dampening to complete
Boss_JampanWaitVelocityStop:                            ; DATA XREF: ROM:00049204   o  ; was: sub_49A7E
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanDamageHandler
                tst.w   (dword_FF9428).w
                beq.s   loc_49AA2
                tst.w   (dword_FF9428).w
                bmi.s   loc_49A9C
                subq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49A9C:                                              ; CODE XREF: Boss_JampanWaitVelocityStop+16   j
                addq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49AA2:                                              ; CODE XREF: Boss_JampanWaitVelocityStop+10   j
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanWaitVelocityStop
; Delays before attack while spawning debris
Boss_JampanPreAttackDelay:                              ; DATA XREF: ROM:00049206   o  ; was: sub_49AAE
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$48(a5)
                bne.s   locret_49ACC
                bsr.w   Boss_JampanEnableShields
                bsr.w   Boss_JampanDefeatDebris
                addq.w  #2,4(a5)
locret_49ACC:                                           ; CODE XREF: Boss_JampanPreAttackDelay+10   j
                rts
; End of function Boss_JampanPreAttackDelay
; Warms up attack by incrementing counter
Boss_JampanAttackWarmup:                                ; DATA XREF: ROM:00049208   o  ; was: sub_49ACE
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                addq.w  #1,(dword_FF942C).w
                cmpi.w  #$18,(dword_FF942C).w
                bne.s   locret_49AF4
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_49AF4:                                           ; CODE XREF: Boss_JampanAttackWarmup+1A   j
                rts
; End of function Boss_JampanAttackWarmup
; Prepares attack with delay and sound
Boss_JampanAttackPrepare:                               ; DATA XREF: ROM:0004920A   o  ; was: sub_49AF6
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                subq.w  #1,$48(a5)
                bne.w   locret_49B28
                move.w  #$14,$48(a5)
                addq.w  #2,4(a5)
                bclr    #1,$4C(a5)
                move.w  #$D1,d0
                jsr     (Sound_PlaySFX).l
locret_49B28:                                           ; CODE XREF: Boss_JampanAttackPrepare+14   j
                rts
; End of function Boss_JampanAttackPrepare
; Moves boss upward during attack
Boss_JampanAttackRiseUp:                                ; DATA XREF: ROM:0004920C   o  ; was: sub_49B2A
                addq.w  #4,(dword_FF9404).w
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                subq.w  #1,$48(a5)
                bne.w   locret_49B62
                move.w  #$14,$48(a5)
                addq.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #$A1,d0
                jsr     (Sound_PlaySFX).l
locret_49B62:                                           ; CODE XREF: Boss_JampanAttackRiseUp+14   j
                rts
; End of function Boss_JampanAttackRiseUp
; Moves boss downward with player alignment
Boss_JampanAttackDescend:                               ; DATA XREF: ROM:0004920E   o  ; was: sub_49B64
                subq.w  #4,(dword_FF9404).w
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                subq.w  #1,$48(a5)
                bne.w   locret_49BBA
                bset    #1,$4C(a5)
                tst.w   (word_FF8234).w
                ble.s   loc_49BA6
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_49B94
                neg.w   d0
loc_49B94:                                              ; CODE XREF: Boss_JampanAttackDescend+2C   j
                cmpi.w  #$80,d0
                bcc.s   loc_49BA6
                move.w  #$10,$48(a5)
                subq.w  #4,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_49BA6:                                              ; CODE XREF: Boss_JampanAttackDescend+22   j
                                        ; Boss_JampanAttackDescend+34   j
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                clr.b   (byte_FFCE81).w
                addq.w  #2,4(a5)
locret_49BBA:                                           ; CODE XREF: Boss_JampanAttackDescend+14   j
                rts
; End of function Boss_JampanAttackDescend
; Finishes attack by hiding minions
Boss_JampanAttackFinish:                                ; DATA XREF: ROM:00049210   o  ; was: sub_49BBC
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                subq.w  #1,(dword_FF942C).w
                bne.s   locret_49BE4
                clr.w   (word_FFC732).w
                clr.w   (word_FFC7F2).w
                bsr.w   Boss_JampanDisableShields
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_49BE4:                                           ; CODE XREF: Boss_JampanAttackFinish+10   j
                rts
; End of function Boss_JampanAttackFinish
; Delays after attack before returning to idle
Boss_JampanPostAttackDelay:                             ; DATA XREF: ROM:00049212   o  ; was: sub_49BE6
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$48(a5)
                bne.s   locret_49C02
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                move.w  #$12,4(a5)
locret_49C02:                                           ; CODE XREF: Boss_JampanPostAttackDelay+8   j
                rts
; End of function Boss_JampanPostAttackDelay
; Resets velocities and minion states
Boss_JampanResetFromAttack:                             ; DATA XREF: ROM:00049214   o  ; was: sub_49C04
                bsr.w   Boss_JampanDamageHandler
                tst.w   (dword_FF9424+2).w
                beq.s   loc_49C1E
                tst.w   (dword_FF9424+2).w
                bmi.s   loc_49C1A
                subq.w  #1,(dword_FF9424+2).w
                bra.s   loc_49C1E
; ---------------------------------------------------------------------------
loc_49C1A:                                              ; CODE XREF: Boss_JampanResetFromAttack+E   j
                addq.w  #1,(dword_FF9424+2).w
loc_49C1E:                                              ; CODE XREF: Boss_JampanResetFromAttack+8   j
                                        ; Boss_JampanResetFromAttack+14   j
                tst.w   (dword_FF9428).w
                beq.s   loc_49C36
                tst.w   (dword_FF9428).w
                bmi.s   loc_49C30
                subq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49C30:                                              ; CODE XREF: Boss_JampanResetFromAttack+24   j
                addq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49C36:                                              ; CODE XREF: Boss_JampanResetFromAttack+1E   j
                tst.w   (dword_FF9424+2).w
                bne.s   locret_49C70
                bclr    #2,$4C(a5)
                clr.l   $1C(a5)
                clr.l   $54(a5)
                clr.w   (word_FFC8B2).w
                move.w  #3,(word_FFC6D2).w
                move.w  #3,(word_FFC792).w
                andi.w  #$1FC,(dword_FF9408).w
                move.w  #4,(dword_FF9414).w
                move.w  #4,(dword_FF9410).w
                addq.w  #2,4(a5)
locret_49C70:                                           ; CODE XREF: Boss_JampanResetFromAttack+36   j
                rts
; End of function Boss_JampanResetFromAttack
; Handles defeat transition at rotation $180
Boss_JampanDefeatTransition:                            ; DATA XREF: ROM:00049216   o  ; was: sub_49C72
                bsr.w   Boss_JampanDamageHandler
                cmpi.w  #$180,(dword_FF9408).w
                bne.s   locret_49C8E
                clr.w   (dword_FF9414).w
                bsr.w   Boss_JampanEnableShields
                bsr.w   Boss_JampanDefeatDebris
                addq.w  #2,4(a5)
locret_49C8E:                                           ; CODE XREF: Boss_JampanDefeatTransition+A   j
                rts
; End of function Boss_JampanDefeatTransition
; Increments counter during defeat fade
Boss_JampanDefeatFadeout:                               ; DATA XREF: ROM:00049218   o  ; was: sub_49C90
                cmpi.l  #$80000,(dword_FF9410).w
                beq.s   loc_49CA2
                addi.l  #$4000,(dword_FF9410).w
loc_49CA2:                                              ; CODE XREF: Boss_JampanDefeatFadeout+8   j
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                addq.w  #1,(dword_FF942C).w
                cmpi.w  #$18,(dword_FF942C).w
                bcs.s   locret_49CC6
                move.w  #$18,(dword_FF942C).w
                move.w  #$A0,(word_FFCE86).w
                addq.w  #2,4(a5)
locret_49CC6:                                           ; CODE XREF: Boss_JampanDefeatFadeout+24   j
                rts
; End of function Boss_JampanDefeatFadeout
; Initializes defeat sequence with timer
Boss_JampanDefeatInitAlt:                               ; DATA XREF: ROM:0004921A   o  ; was: sub_49CC8
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
                bclr    #1,$4C(a5)
                rts
; End of function Boss_JampanDefeatInitAlt
; Waits during defeat, decrements timer
Boss_JampanDefeatWait:                                  ; DATA XREF: ROM:0004921C   o  ; was: sub_49CE2
                cmpi.w  #$C0,$48(a5)
                bcs.s   loc_49CEE
                bsr.w   Boss_JampanTrackPlayerY
loc_49CEE:                                              ; CODE XREF: Boss_JampanDefeatWait+6   j
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                tst.w   (word_FF8234).w
                ble.s   loc_49D06
                subq.w  #1,$48(a5)
                bne.s   locret_49D10
loc_49D06:                                              ; CODE XREF: Boss_JampanDefeatWait+1C   j
                bset    #1,$4C(a5)
                addq.w  #2,4(a5)
locret_49D10:                                           ; CODE XREF: Boss_JampanDefeatWait+22   j
                rts
; End of function Boss_JampanDefeatWait
; Returns boss Y position to center
Boss_JampanReturnToCenter:                              ; DATA XREF: ROM:0004921E   o  ; was: sub_49D12
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                move.w  $14(a5),d0
                subi.w  #$F0,d0
                beq.s   loc_49D34
                tst.w   d0
                bpl.s   loc_49D2E
                addq.w  #1,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_49D2E:                                              ; CODE XREF: Boss_JampanReturnToCenter+14   j
                subq.w  #1,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_49D34:                                              ; CODE XREF: Boss_JampanReturnToCenter+10   j
                bset    #2,$4C(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$54(a5)
                andi.w  #$1F8,(dword_FF9404).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanReturnToCenter
; Waits for rotation angle to reach $100
Boss_JampanWaitRotation:                                ; DATA XREF: ROM:00049220   o  ; was: sub_49D56
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                cmpi.w  #$100,(dword_FF9404).w
                bne.s   locret_49D6E
                clr.w   (dword_FF9410).w
                addq.w  #2,4(a5)
locret_49D6E:                                           ; CODE XREF: Boss_JampanWaitRotation+E   j
                rts
; End of function Boss_JampanWaitRotation
; Decrements debris counter during fadeout
Boss_JampanDebrisFadeout:                               ; DATA XREF: ROM:00049222   o  ; was: sub_49D70
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                subq.w  #4,(dword_FF942C).w
                bhi.s   locret_49D90
                clr.w   (dword_FF942C).w
                bsr.w   Boss_JampanDisableShields
                andi.w  #$1F8,(dword_FF9408).w
                addq.w  #2,4(a5)
locret_49D90:                                           ; CODE XREF: Boss_JampanDebrisFadeout+C   j
                rts
; End of function Boss_JampanDebrisFadeout
; Rotates angle by 8 per frame until $100
Boss_JampanRotateToCenter:                              ; DATA XREF: ROM:00049224   o  ; was: sub_49D92
                bsr.w   Boss_JampanDamageHandler
                addq.w  #8,(dword_FF9408).w
                andi.w  #$1F8,(dword_FF9408).w
                cmpi.w  #$100,(dword_FF9408).w
                bne.s   locret_49DAE
                move.w  #$12,4(a5)
locret_49DAE:                                           ; CODE XREF: Boss_JampanRotateToCenter+14   j
                rts
; End of function Boss_JampanRotateToCenter
nullsub_100:                                            ; DATA XREF: ROM:00049226   o
                rts
; End of function nullsub_100

; Flash effect during defeat
Boss_JampanDefeatFlash:                                 ; DATA XREF: ROM:00049228   o  ; was: sub_49DB2
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                tst.w   (dword_FF942C).w
                beq.s   loc_49DC6
                subq.w  #1,(dword_FF942C).w
                rts
; ---------------------------------------------------------------------------
loc_49DC6:                                              ; CODE XREF: Boss_JampanDefeatFlash+C   j
                tst.w   (dword_FF9424+2).w
                beq.s   loc_49DDC
                tst.w   (dword_FF9424+2).w
                bmi.s   loc_49DD8
                subq.w  #1,(dword_FF9424+2).w
                bra.s   loc_49DDC
; ---------------------------------------------------------------------------
loc_49DD8:                                              ; CODE XREF: Boss_JampanDefeatFlash+1E   j
                addq.w  #1,(dword_FF9424+2).w
loc_49DDC:                                              ; CODE XREF: Boss_JampanDefeatFlash+18   j
                                        ; Boss_JampanDefeatFlash+24   j
                tst.w   (dword_FF9424+2).w
                beq.s   loc_49DF4
                tst.w   (dword_FF9428).w
                bmi.s   loc_49DEE
                subq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49DEE:                                              ; CODE XREF: Boss_JampanDefeatFlash+34   j
                addq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49DF4:                                              ; CODE XREF: Boss_JampanDefeatFlash+2E   j
                tst.w   (dword_FF9424+2).w
                bne.s   locret_49E24
                bclr    #2,$4C(a5)
                clr.l   $1C(a5)
                clr.l   $54(a5)
                clr.l   (dword_FF9410).w
                clr.l   (dword_FF9414).w
                ori.w   #$8000,(word_FFC862).w
                clr.b   $21(a5)
                move.b  #1,(byte_FF830E).w
                addq.w  #2,4(a5)
locret_49E24:                                           ; CODE XREF: Boss_JampanDefeatFlash+46   j
                rts
; End of function Boss_JampanDefeatFlash
; Screen shake during defeat
Boss_JampanDefeatShake:                                 ; DATA XREF: ROM:0004922A   o  ; was: sub_49E26
                addi.l  #$200,$1C(a5)
                bsr.w   Boss_JampanDefeatDebris
                bsr.w   Boss_JampanDamageHandler
                jsr     (Boss_SpawnExplosionDebris).l
                cmpi.w  #$110,$14(a5)
                bcs.s   locret_49E62
                bsr.w   Boss_JampanDisableShields
                clr.l   $1C(a5)
                move.w  #$110,$14(a5)
                andi.w  #$1FE,(dword_FF9408).w
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_49E62:                                           ; CODE XREF: Boss_JampanDefeatShake+1C   j
                rts
; End of function Boss_JampanDefeatShake
; Boss breaking up animation
Boss_JampanDefeatBreakup:                               ; DATA XREF: ROM:0004922C   o  ; was: sub_49E64
                bsr.w   Boss_JampanDamageHandler
                jsr     (Boss_SpawnExplosionDebris).l
                subq.w  #1,$48(a5)
                bne.s   locret_49E98
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                movea.w #(byte_FFD0A0-M68K_RAM),a0
                move.w  #$23C,(a0)
                move.w  #$D00,2(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
locret_49E98:                                           ; CODE XREF: Boss_JampanDefeatBreakup+E   j
                rts
; End of function Boss_JampanDefeatBreakup
; Defeat spark initialization
Boss_JampanDefeatSparkInit:                             ; DATA XREF: ROM:0004922E   o  ; was: sub_49E9A
                jsr     (Boss_SpawnExplosionDebris).l
                cmpi.w  #$60,(word_FFD0B4).w            ; '`'
                bcc.s   locret_49EB0
                clr.l   (dword_FFD0BC).w
                addq.w  #2,4(a5)
locret_49EB0:                                           ; CODE XREF: Boss_JampanDefeatSparkInit+C   j
                rts
; End of function Boss_JampanDefeatSparkInit
; Defeat spark movement
Boss_JampanDefeatSparkMove:                             ; DATA XREF: ROM:00049230   o  ; was: sub_49EB2
                bsr.s   Boss_JampanDefeatSparkUpdate
                addq.w  #1,$5C(a5)
                cmpi.w  #$F,$5C(a5)
                bne.s   locret_49ED0
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                clr.b   (word_FFF7E6+1).w
                addq.w  #2,4(a5)
locret_49ED0:                                           ; CODE XREF: Boss_JampanDefeatSparkMove+C   j
                rts
; End of function Boss_JampanDefeatSparkMove
; Defeat spark update
Boss_JampanDefeatSparkUpdate:                           ; CODE XREF: Boss_JampanDefeatSparkMove   p  ; was: sub_49ED2
                                        ; sub_49EEC   p
                move.w  $5C(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_JampanDefeatSparkUpdate
; Defeat spark fade effect
Boss_JampanDefeatSparkFade:                             ; DATA XREF: ROM:00049232   o  ; was: sub_49EEC
                bsr.s   Boss_JampanDefeatSparkUpdate
                move.w  #$218,d0
                move.w  #$23C,d1
                jsr     (Sprite_ClearAllExcept).l
                jsr     (Effect_InitPlayerSpawn).l
                move.b  #4,(byte_FFA95A).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanDefeatSparkFade
; Defeat spark wait timer
Boss_JampanDefeatSparkWait:                             ; DATA XREF: ROM:00049234   o  ; was: sub_49F0E
                bsr.s   Boss_JampanDefeatSparkUpdate
                subq.w  #1,$5C(a5)
                cmpi.w  #0,$5C(a5)
                bne.s   locret_49F20
                addq.w  #2,4(a5)
locret_49F20:                                           ; CODE XREF: Boss_JampanDefeatSparkWait+C   j
                rts
; End of function Boss_JampanDefeatSparkWait
; End of defeat initialization
Boss_JampanDefeatEndInit:                               ; DATA XREF: ROM:00049236   o  ; was: sub_49F22
                move.w  (word_FFD0B0).w,$10(a5)
                move.w  (word_FFD0B4).w,$14(a5)
                bset    #4,(byte_FFD0A2).w
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanDefeatEndInit
; End fade to white
Boss_JampanDefeatEndFade:                               ; DATA XREF: ROM:00049238   o  ; was: sub_49F40
                subq.w  #1,$48(a5)
                bne.s   locret_49F86
                lea     (byte_C55E).l,a0
                jsr     (Gfx_SyncPaletteBuffers).l
                bsr.w   loc_492F4
                bsr.w   Boss_JampanDamageHandler
                move.w  #$FFF8,(dword_FF9424).w
                move.w  #$100,(dword_FF9404).w
                move.w  #$100,(dword_FF9408).w
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                move.w  #1,(word_FFC852).w
                addq.w  #2,4(a5)
                bsr.w   Boss_JampanDefeatEndWait
locret_49F86:                                           ; CODE XREF: Boss_JampanDefeatEndFade+4   j
                rts
; End of function Boss_JampanDefeatEndFade
; Cleanup initialization
Boss_JampanDefeatCleanupInit:                           ; DATA XREF: ROM:0004923A   o  ; was: sub_49F88
                bsr.w   Boss_JampanDefeatTimerCheck
                move.w  #1,(word_FFC6D2).w
                move.w  #1,(word_FFC792).w
                bsr.w   Boss_JampanDebugController
                bsr.w   Boss_JampanDamageHandler
                addq.w  #2,4(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                addi.w  #$40,d0                         ; '@'
                move.w  d0,$48(a5)
                jsr     (Math_CalculateAngleToPlayer).l
                lea     (word_1B514).l,a1
                move.w  (a1,d2.w),d0
                move.w  -$80(a1,d2.w),d1
                ext.l   d0
                ext.l   d1
                move.l  d0,d2
                move.l  d1,d3
                neg.l   d2
                neg.l   d3
                asr.l   #4,d2
                asr.l   #4,d3
                move.l  d2,$50(a5)
                move.l  d3,$54(a5)
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                rts
; End of function Boss_JampanDefeatCleanupInit
; Cleanup wait timer
Boss_JampanDefeatCleanupWait:                           ; DATA XREF: ROM:0004923C   o  ; was: sub_49FEE
                bsr.w   Boss_JampanDefeatTimerCheck
                bsr.w   Boss_JampanDebugController
                bsr.w   Boss_JampanDamageHandler
                move.l  $50(a5),d0
                add.l   d0,$18(a5)
                move.l  $54(a5),d0
                add.l   d0,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_4A014
                subq.w  #2,4(a5)
locret_4A014:                                           ; CODE XREF: Boss_JampanDefeatCleanupWait+20   j
                rts
; End of function Boss_JampanDefeatCleanupWait
nullsub_101:                                            ; DATA XREF: ROM:0004923E   o
                rts
; End of function nullsub_101

; Wait before transition
Boss_JampanDefeatEndWait:                               ; CODE XREF: Boss_JampanDefeatEndFade+42   p  ; was: sub_4A018
                move.w  #$100,(dword_FF942C+2).w
                move.w  #$2E,(word_FF80C2).w            ; '.'
                rts
; End of function Boss_JampanDefeatEndWait
; Defeat timer countdown check
Boss_JampanDefeatTimerCheck:                            ; CODE XREF: Boss_JampanDefeatCleanupInit   p  ; was: sub_4A026
                                        ; sub_49FEE   p
                subq.w  #1,(dword_FF942C+2).w
                bne.s   locret_4A032
                move.b  #1,(byte_FFA958).w
locret_4A032:                                           ; CODE XREF: Boss_JampanDefeatTimerCheck+4   j
                rts
; End of function Boss_JampanDefeatTimerCheck
; Final defeat phase main
Boss_JampanDefeatFinalMain:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_4A034
                move.w  4(a5),d0
                lea     off_4A040(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanDefeatFinalMain
; ---------------------------------------------------------------------------
off_4A040:      dc.w    Boss_JampanDefeatFinalInit-*    ; DATA XREF: Boss_JampanDefeatFinalMain+4   o
                dc.w    Boss_JampanDefeatFinalLoop-*

; Final defeat phase init
Boss_JampanDefeatFinalInit:                             ; DATA XREF: ROM:off_4A040   o  ; was: sub_4A044
                move.b  #$40,$20(a5)                    ; '@'
                move.w  #1,(word_FFC6D2).w
                move.w  #1,(word_FFC792).w
                clr.w   (word_FFC732).w
                clr.w   (word_FFC7F2).w
                clr.w   (word_FFC8B2).w
                clr.w   (word_FFC852).w
                bsr.w   Boss_JampanDamageHandler
                move.l  #$FFFE0000,$1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanDefeatFinalInit
; Final defeat phase loop
Boss_JampanDefeatFinalLoop:                             ; DATA XREF: ROM:0004A042   o  ; was: sub_4A078
                bsr.w   Boss_JampanDamageHandler
                rts
; End of function Boss_JampanDefeatFinalLoop
; Boss AI controller
Boss_JampanAIController:                                ; CODE XREF: Enemy_JampanMinion   p  ; was: sub_4A07E
                                        ; sub_498F2   p
                bsr.s   Boss_JampanUpdateFacing
                tst.w   (word_FFFF0E).w
                beq.s   locret_4A088
                bsr.s   Boss_JampanUpdateFacing
locret_4A088:                                           ; CODE XREF: Boss_JampanAIController+6   j
                rts
; End of function Boss_JampanAIController
; Updates boss facing direction
Boss_JampanUpdateFacing:                                ; CODE XREF: Boss_JampanAIController   p  ; was: sub_4A08A
                                        ; Boss_JampanAIController+8   p
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                beq.s   locret_4A0A6
                tst.w   d0
                bmi.s   loc_4A09E
                move.w  #1,d1
                bra.s   loc_4A0A2
; ---------------------------------------------------------------------------
loc_4A09E:                                              ; CODE XREF: Boss_JampanUpdateFacing+C   j
                move.w  #$FFFF,d1
loc_4A0A2:                                              ; CODE XREF: Boss_JampanUpdateFacing+12   j
                add.w   d1,$10(a5)
locret_4A0A6:                                           ; CODE XREF: Boss_JampanUpdateFacing+8   j
                rts
; End of function Boss_JampanUpdateFacing
; Adjusts Y position to track player
Boss_JampanTrackPlayerY:                                ; CODE XREF: Boss_JampanDefeatWait+8   p  ; was: sub_4A0A8
                move.w  (dword_FFA414).w,d0
                sub.w   $14(a5),d0
                beq.s   locret_4A0C4
                tst.w   d0
                bmi.s   loc_4A0BC
                move.w  #1,d1
                bra.s   loc_4A0C0
; ---------------------------------------------------------------------------
loc_4A0BC:                                              ; CODE XREF: Boss_JampanTrackPlayerY+C   j
                move.w  #$FFFF,d1
loc_4A0C0:                                              ; CODE XREF: Boss_JampanTrackPlayerY+12   j
                add.w   d1,$14(a5)
locret_4A0C4:                                           ; CODE XREF: Boss_JampanTrackPlayerY+8   j
                rts
; End of function Boss_JampanTrackPlayerY
; Calculates angle and aims at player
Boss_JampanAimAtPlayer:                                 ; CODE XREF: Enemy_JampanMinion+4   p  ; was: sub_4A0C6
                                        ; sub_49992   p
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  d2,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                asr.w   #2,d0
                cmpi.w  #$100,d2
                bcc.s   loc_4A0E0
                neg.w   d0
loc_4A0E0:                                              ; CODE XREF: Boss_JampanAimAtPlayer+16   j
                move.w  (dword_FF9424+2).w,d1
                sub.w   d1,d0
                beq.s   locret_4A0F6
                tst.w   d0
                bmi.s   loc_4A0F2
                addq.w  #1,(dword_FF9424+2).w
                bra.s   locret_4A0F6
; ---------------------------------------------------------------------------
loc_4A0F2:                                              ; CODE XREF: Boss_JampanAimAtPlayer+24   j
                subq.w  #1,(dword_FF9424+2).w
locret_4A0F6:                                           ; CODE XREF: Boss_JampanAimAtPlayer+20   j
                                        ; Boss_JampanAimAtPlayer+2A   j
                rts
; End of function Boss_JampanAimAtPlayer
; Teleport attack init
Boss_JampanTeleportInit:                                ; CODE XREF: Boss_JampanSpawnMinion   p  ; was: sub_4A0F8
                                        ; sub_49666   p
                move.w  $14(a5),d0
                subi.w  #$F0,d0
                sub.w   (dword_FF9428).w,d0
                beq.s   locret_4A114
                tst.w   d0
                bmi.s   loc_4A110
                addq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_4A110:                                              ; CODE XREF: Boss_JampanTeleportInit+10   j
                subq.w  #1,(dword_FF9428).w
locret_4A114:                                           ; CODE XREF: Boss_JampanTeleportInit+C   j
                rts
; End of function Boss_JampanTeleportInit
nullsub_97:                                             ; CODE XREF: Enemy_JampanMinion+C   p
                rts
; End of function nullsub_97

; Enables all 6 shield entities
Boss_JampanEnableShields:                               ; CODE XREF: Boss_JampanPreAttackDelay+12   p  ; was: sub_4A118
                                        ; Boss_JampanDefeatTransition+10   p
                move.w  #5,d7
                movea.w #(byte_FFCE60-M68K_RAM),a0
loc_4A120:                                              ; CODE XREF: Boss_JampanEnableShields+12   j
                ori.w   #$8000,2(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4A120
                move.b  #$40,(byte_FFCE81).w            ; '@'
                move.w  #$A0,(word_FFCE86).w
                move.l  #$F808F808,(dword_FFCE8C).w
                rts
; End of function Boss_JampanEnableShields
; Disables all 6 shield entities
Boss_JampanDisableShields:                              ; CODE XREF: Boss_JampanAttackFinish+1A   p  ; was: sub_4A144
                                        ; Boss_JampanDebrisFadeout+12   p
                move.w  #5,d7
                movea.w #(byte_FFCE60-M68K_RAM),a0
loc_4A14C:                                              ; CODE XREF: Boss_JampanDisableShields+12   j
                andi.w  #$7FFF,2(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4A14C
                clr.b   (byte_FFCE81).w
                rts
; End of function Boss_JampanDisableShields
; Spawns defeat debris
Boss_JampanDefeatDebris:                                ; CODE XREF: Boss_JampanPreAttackDelay+16   p  ; was: sub_4A160
                                        ; Boss_JampanAttackWarmup+C   p
                move.w  (dword_FF942C).w,d4
                move.w  (word_FFC8AA).w,d5
                move.w  (word_FFC8AC).w,d6
                move.w  (word_FFC8AE).w,d7
                add.w   (dword_FF9400).w,d5
                add.w   (dword_FF9404).w,d6
                add.w   (dword_FF9408).w,d7
                add.w   (dword_FF9424+2).w,d5
                add.w   (dword_FF9428).w,d6
                add.w   (dword_FF9428+2).w,d7
                andi.w  #$1FE,d5
                andi.w  #$1FE,d6
                andi.w  #$1FE,d7
                movea.w #(word_FFC860-M68K_RAM),a1
                movea.w #(byte_FFD040-M68K_RAM),a0
                bsr.w   Boss_JampanFlashOnDamage
                movea.w a0,a1
                lea     -$60(a0),a0
                move.w  #4,d0
loc_4A1AA:                                              ; CODE XREF: Boss_JampanDefeatDebris+60   j
                bsr.w   Boss_JampanFlashOnDamage
                move.w  (word_FFD04E).w,$E(a0)
                move.b  (byte_FFD060).w,$20(a0)
                movea.w a0,a1
                lea     -$60(a0),a0
                dbf     d0,loc_4A1AA
                cmpi.w  #$52,4(a5)                      ; 'R'
                bcc.s   loc_4A1D6
                move.w  (word_FFCE6E).w,d0
                andi.w  #$8000,d0
                bne.s   loc_4A1DC
loc_4A1D6:                                              ; CODE XREF: Boss_JampanDefeatDebris+6A   j
                clr.b   (byte_FFCE81).w
                rts
; ---------------------------------------------------------------------------
loc_4A1DC:                                              ; CODE XREF: Boss_JampanDefeatDebris+74   j
                move.b  #$40,(byte_FFCE81).w            ; '@'
                rts
; End of function Boss_JampanDefeatDebris
; Main AI for Jampan shield entity
Enemy_JampanShieldMain:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_4A1E4
                cmpi.w  #$52,(word_FFC624).w            ; 'R'
                bcc.w   loc_4A2F0
                cmpi.w  #$180,$14(a5)
                bcs.s   loc_4A1FE
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_4A1FE:                                              ; CODE XREF: Enemy_JampanShieldMain+10   j
                tst.l   $4C(a5)
                beq.s   loc_4A20C
                move.l  $4C(a5),d0
                add.l   d0,$1C(a5)
loc_4A20C:                                              ; CODE XREF: Enemy_JampanShieldMain+1E   j
                move.w  4(a5),d0
                lea     off_4A218(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_JampanShieldMain
; ---------------------------------------------------------------------------
off_4A218:      dc.w    Enemy_JampanShieldInit-*        ; DATA XREF: Enemy_JampanShieldMain+2C   o
                dc.w    Enemy_JampanShieldBounce-*
                dc.w    Enemy_JampanShieldAttack-*
                dc.w    Enemy_JampanShieldFire-*
                dc.w    nullsub_102-*

; Initializes shield with fall speed
Enemy_JampanShieldInit:                                 ; DATA XREF: ROM:off_4A218   o  ; was: sub_4A222
                move.l  #$2000,$4C(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_JampanShieldInit
; Handles shield bouncing at Y=$128
Enemy_JampanShieldBounce:                               ; DATA XREF: ROM:0004A21A   o  ; was: sub_4A236
                cmpi.w  #$128,$14(a5)
                bcs.s   locret_4A26E
                move.w  #$128,$14(a5)
                subq.w  #1,$48(a5)
                beq.s   loc_4A25C
                move.l  $1C(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                tst.w   $1C(a5)
                bne.s   locret_4A26E
loc_4A25C:                                              ; CODE XREF: Enemy_JampanShieldBounce+12   j
                clr.l   $1C(a5)
                clr.l   $4C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4A26E:                                           ; CODE XREF: Enemy_JampanShieldBounce+6   j
                                        ; Enemy_JampanShieldBounce+24   j
                rts
; End of function Enemy_JampanShieldBounce
; Initiates shield attack with SFX
Enemy_JampanShieldAttack:                               ; DATA XREF: ROM:0004A21C   o  ; was: sub_4A270
                subq.w  #1,$48(a5)
                bne.s   locret_4A2B0
                move.w  #$BB,d0
                jsr     (Sound_PlaySFX).l
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #$40,$21(a5)                    ; '@'
                move.l  #$E020E020,$2C(a5)
                move.w  #$FFFA,$1C(a5)
                move.w  #2,$48(a5)
                move.w  #4,$4A(a5)
                addq.w  #2,4(a5)
locret_4A2B0:                                           ; CODE XREF: Enemy_JampanShieldAttack+4   j
                rts
; End of function Enemy_JampanShieldAttack
; Spawns projectile from shield
Enemy_JampanShieldFire:                                 ; DATA XREF: ROM:0004A21E   o  ; was: sub_4A2B2
                subq.w  #1,$48(a5)
                bne.s   locret_4A2EE
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_4A2E8
                move.l  #off_E95A4,8(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.l  #$4000,$1C(a0)
                jsr     (Projectile_InitType88).l
                subq.w  #1,$4A(a5)
                beq.s   loc_4A2F0
loc_4A2E8:                                              ; CODE XREF: Enemy_JampanShieldFire+C   j
                move.w  #2,$48(a5)
locret_4A2EE:                                           ; CODE XREF: Enemy_JampanShieldFire+4   j
                rts
; ---------------------------------------------------------------------------
loc_4A2F0:                                              ; CODE XREF: Enemy_JampanShieldMain+6   j
                                        ; Enemy_JampanShieldFire+34   j
                move.l  #off_E953C,8(a5)
                jmp     Enemy_GetEntityAddress
; End of function Enemy_JampanShieldFire
nullsub_102:                                            ; DATA XREF: ROM:0004A220   o
                rts
; End of function nullsub_102

; Shadow effect main handler
Boss_JampanShadowMain:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_4A300
                bsr.s   Boss_JampanShadowDispatcher
                tst.w   $54(a5)
                beq.s   locret_4A314
                move.w  $54(a5),d0
                addi.w  #-$20,d0
                move.w  d0,$4C(a5)
locret_4A314:                                           ; CODE XREF: Boss_JampanShadowMain+6   j
                rts
; End of function Boss_JampanShadowMain
; Shadow effect dispatcher
Boss_JampanShadowDispatcher:                            ; CODE XREF: Boss_JampanShadowMain   p  ; was: sub_4A316
                move.w  4(a5),d0
                lea     off_4A322(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanShadowDispatcher
; ---------------------------------------------------------------------------
off_4A322:      dc.w    Boss_JampanShadowInit-*         ; DATA XREF: Boss_JampanShadowDispatcher+4   o
                dc.w    Boss_JampanShadowAnimate-*
                dc.w    nullsub_103-*

; Shadow effect initialization
Boss_JampanShadowInit:                                  ; DATA XREF: ROM:off_4A322   o  ; was: sub_4A328
                tst.w   $52(a5)
                beq.s   locret_4A33E
                move.w  #8,$50(a5)
                addq.w  #2,4(a5)
                move.w  #4,$56(a5)
locret_4A33E:                                           ; CODE XREF: Boss_JampanShadowInit+4   j
                rts
; End of function Boss_JampanShadowInit
; Shadow animation handler
Boss_JampanShadowAnimate:                               ; DATA XREF: ROM:0004A324   o  ; was: sub_4A340
                move.w  $56(a5),d0
                add.w   d0,$54(a5)
                tst.w   $54(a5)
                beq.s   loc_4A360
                subq.w  #1,$50(a5)
                bne.s   locret_4A35E
                move.w  #$10,$50(a5)
                neg.w   $56(a5)
locret_4A35E:                                           ; CODE XREF: Boss_JampanShadowAnimate+12   j
                rts
; ---------------------------------------------------------------------------
loc_4A360:                                              ; CODE XREF: Boss_JampanShadowAnimate+C   j
                subq.w  #2,4(a5)
                rts
; End of function Boss_JampanShadowAnimate
nullsub_103:                                            ; DATA XREF: ROM:0004A326   o
                rts
; End of function nullsub_103

; Updates boss position
Boss_JampanUpdatePosition:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4A368
                bsr.s   Boss_JampanUpdateAnimation
                movea.w $50(a5),a1
                move.b  $20(a1),$20(a5)
                lea     (word_1B514).l,a2
                move.w  $4A(a5),d2
                move.w  $48(a5),d3
                move.w  (a2,d2.w),d0
                move.w  -$80(a2,d2.w),d1
                muls.w  d3,d0
                muls.w  d3,d1
                add.l   $10(a1),d0
                add.l   $14(a1),d1
                move.l  d0,$10(a5)
                move.l  d1,$14(a5)
                move.b  $20(a5),d0
                cmp.b   (byte_FFC640).w,d0
                bhi.s   loc_4A3B0
                ori.w   #$8000,$E(a5)
                bra.s   locret_4A3B6
; ---------------------------------------------------------------------------
loc_4A3B0:                                              ; CODE XREF: Boss_JampanUpdatePosition+3E   j
                andi.w  #$7FFF,$E(a5)
locret_4A3B6:                                           ; CODE XREF: Boss_JampanUpdatePosition+46   j
                rts
; End of function Boss_JampanUpdatePosition
; Updates boss animation
Boss_JampanUpdateAnimation:                             ; CODE XREF: Boss_JampanUpdatePosition   p  ; was: sub_4A3B8
                move.w  4(a5),d0
                lea     off_4A3C4(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanUpdateAnimation
; ---------------------------------------------------------------------------
off_4A3C4:      dc.w    Boss_JampanUpdateSprite-*       ; DATA XREF: Boss_JampanUpdateAnimation+4   o
                dc.w    Boss_JampanUpdatePalette-*
                dc.w    Boss_JampanAimTracking-*

; Updates boss sprite
Boss_JampanUpdateSprite:                                ; DATA XREF: ROM:off_4A3C4   o  ; was: sub_4A3CA
                tst.w   $52(a5)
                beq.w   locret_4A3D6
                addq.w  #2,4(a5)
locret_4A3D6:                                           ; CODE XREF: Boss_JampanUpdateSprite+4   j
                rts
; End of function Boss_JampanUpdateSprite
; Updates boss palette
Boss_JampanUpdatePalette:                               ; DATA XREF: ROM:0004A3C6   o  ; was: sub_4A3D8
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  d2,d0
                sub.w   $4A(a5),d0
                bpl.s   loc_4A3E8
                neg.w   d0
loc_4A3E8:                                              ; CODE XREF: Boss_JampanUpdatePalette+C   j
                cmpi.w  #4,d0
                bls.s   loc_4A3F2
                move.w  d2,$4A(a5)
loc_4A3F2:                                              ; CODE XREF: Boss_JampanUpdatePalette+14   j
                cmpi.w  #$1C,$48(a5)
                beq.s   loc_4A3FE
                addq.w  #2,$48(a5)
loc_4A3FE:                                              ; CODE XREF: Boss_JampanUpdatePalette+20   j
                tst.w   $52(a5)
                bne.w   locret_4A40A
                addq.w  #2,4(a5)
locret_4A40A:                                           ; CODE XREF: Boss_JampanUpdatePalette+2A   j
                rts
; End of function Boss_JampanUpdatePalette
; Smooth aim tracking at player
Boss_JampanAimTracking:                                 ; DATA XREF: ROM:0004A3C8   o  ; was: sub_4A40C
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  d2,d0
                sub.w   $4A(a5),d0
                bpl.s   loc_4A41C
                neg.w   d0
loc_4A41C:                                              ; CODE XREF: Boss_JampanAimTracking+C   j
                cmpi.w  #4,d0
                bls.s   loc_4A426
                move.w  d2,$4A(a5)
loc_4A426:                                              ; CODE XREF: Boss_JampanAimTracking+14   j
                subq.w  #2,$48(a5)
                bne.s   locret_4A430
                clr.w   4(a5)
locret_4A430:                                           ; CODE XREF: Boss_JampanAimTracking+1E   j
                rts
; End of function Boss_JampanAimTracking
; Teleport fade out
Boss_JampanTeleportFadeOut:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_4A432
                bsr.s   Boss_JampanTeleportMove
                movea.w $50(a5),a1
                move.b  $20(a1),$20(a5)
                move.l  $10(a1),$10(a5)
                move.l  $14(a1),$14(a5)
                move.b  $20(a5),d0
                cmp.b   (byte_FFC640).w,d0
                bhi.s   loc_4A45C
                ori.w   #$8000,$E(a5)
                bra.s   locret_4A462
; ---------------------------------------------------------------------------
loc_4A45C:                                              ; CODE XREF: Boss_JampanTeleportFadeOut+20   j
                andi.w  #$7FFF,$E(a5)
locret_4A462:                                           ; CODE XREF: Boss_JampanTeleportFadeOut+28   j
                rts
; End of function Boss_JampanTeleportFadeOut
; Teleport movement
Boss_JampanTeleportMove:                                ; CODE XREF: Boss_JampanTeleportFadeOut   p  ; was: sub_4A464
                move.w  4(a5),d0
                lea     off_4A470(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanTeleportMove
; ---------------------------------------------------------------------------
off_4A470:      dc.w    Boss_JampanTeleportFadeIn-*     ; DATA XREF: Boss_JampanTeleportMove+4   o
                dc.w    Boss_JampanTeleportComplete-*
                dc.w    Boss_JampanComboAttack-*
                dc.w    Boss_JampanSpecialAttack-*

; Teleport fade in
Boss_JampanTeleportFadeIn:                              ; DATA XREF: ROM:off_4A470   o  ; was: sub_4A478
                tst.w   $52(a5)
                beq.s   locret_4A488
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4A488:                                           ; CODE XREF: Boss_JampanTeleportFadeIn+4   j
                rts
; End of function Boss_JampanTeleportFadeIn
; Teleport completion
Boss_JampanTeleportComplete:                            ; DATA XREF: ROM:0004A472   o  ; was: sub_4A48A
                subq.w  #1,$48(a5)
                bne.s   locret_4A4A0
                ori.w   #$8000,2(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_4A4A0:                                           ; CODE XREF: Boss_JampanTeleportComplete+4   j
                rts
; End of function Boss_JampanTeleportComplete
; Combo attack sequence
Boss_JampanComboAttack:                                 ; DATA XREF: ROM:0004A474   o  ; was: sub_4A4A2
                subq.w  #1,$48(a5)
                bne.s   locret_4A4F2
                move.w  #4,$48(a5)
                move.w  $4A(a5),d0
                move.l  off_4A4F4(pc,d0.w),8(a5)
                addq.w  #4,$4A(a5)
                tst.w   $52(a5)
                bpl.s   loc_4A4E6
                cmpi.w  #$FFFE,$52(a5)
                bne.s   loc_4A4D4
                cmpi.w  #$C,$4A(a5)
                beq.s   loc_4A4DC
                bra.s   loc_4A4E6
; ---------------------------------------------------------------------------
loc_4A4D4:                                              ; CODE XREF: Boss_JampanComboAttack+26   j
                cmpi.w  #8,$4A(a5)
                bne.s   loc_4A4E6
loc_4A4DC:                                              ; CODE XREF: Boss_JampanComboAttack+2E   j
                clr.w   $52(a5)
                clr.w   4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4A4E6:                                              ; CODE XREF: Boss_JampanComboAttack+1E   j
                                        ; Boss_JampanComboAttack+30   j
                cmpi.w  #$18,$4A(a5)
                bne.s   locret_4A4F2
                addq.w  #2,4(a5)
locret_4A4F2:                                           ; CODE XREF: Boss_JampanComboAttack+4   j
                                        ; Boss_JampanComboAttack+4A   j
                rts
; End of function Boss_JampanComboAttack
; ---------------------------------------------------------------------------
off_4A4F4:      dc.l    word_EC268                      ; DATA XREF: Boss_JampanComboAttack+10   r
                dc.l    word_EC274
                dc.l    word_EC280
                dc.l    word_EC274
                dc.l    word_EC268
                dc.l    word_EC25C

; Special attack pattern
Boss_JampanSpecialAttack:                               ; DATA XREF: ROM:0004A476   o  ; was: sub_4A50C
                subq.w  #1,$48(a5)
                beq.s   locret_4A538
                clr.w   $4A(a5)
                andi.w  #$7FFF,2(a5)
                tst.w   $52(a5)
                bmi.s   loc_4A528
                subq.w  #1,$52(a5)
                beq.s   loc_4A534
loc_4A528:                                              ; CODE XREF: Boss_JampanSpecialAttack+14   j
                move.w  #4,$48(a5)
                subq.w  #4,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4A534:                                              ; CODE XREF: Boss_JampanSpecialAttack+1A   j
                clr.w   4(a5)
locret_4A538:                                           ; CODE XREF: Boss_JampanSpecialAttack+4   j
                rts
; End of function Boss_JampanSpecialAttack
; Formation attack main handler
Boss_JampanFormationMain:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_4A53A
                move.w  4(a5),d0
                lea     off_4A546(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanFormationMain
; ---------------------------------------------------------------------------
off_4A546:      dc.w    Boss_JampanFormationInit-*      ; DATA XREF: Boss_JampanFormationMain+4   o
                dc.w    Boss_JampanFormationWait-*
                dc.w    Boss_JampanFormationUpdate-*
                dc.w    Boss_JampanDefeatExplosion-*

; Formation attack initialization
Boss_JampanFormationInit:                               ; DATA XREF: ROM:off_4A546   o  ; was: sub_4A54E
                move.w  #$C,d7
                movea.w #(word_FFC980-M68K_RAM),a0
loc_4A556:                                              ; CODE XREF: Boss_JampanFormationInit+14   j
                move.l  #$200000,$54(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4A556
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanFormationInit
; Formation wait for trigger
Boss_JampanFormationWait:                               ; DATA XREF: ROM:0004A548   o  ; was: sub_4A56C
                tst.w   $52(a5)
                beq.s   locret_4A57C
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_4A57C:                                           ; CODE XREF: Boss_JampanFormationWait+4   j
                rts
; End of function Boss_JampanFormationWait
; Updates formation positions
Boss_JampanFormationUpdate:                             ; DATA XREF: ROM:0004A54A   o  ; was: sub_4A57E
                move.w  #$C,d7
                movea.w #(word_FFC980-M68K_RAM),a0
                clr.w   d6
loc_4A588:                                              ; CODE XREF: Boss_JampanFormationUpdate+28   j
                move.l  dword_4A5BC(pc,d6.w),d0
                add.l   d0,$54(a0)
                add.l   d0,$54(a0)
                move.w  $54(a0),$4C(a0)
                andi.w  #$1FF,$4C(a0)
                addq.w  #4,d6
                lea     $60(a0),a0
                dbf     d7,loc_4A588
                subq.w  #1,$48(a5)
                bne.s   locret_4A5BA
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_4A5BA:                                           ; CODE XREF: Boss_JampanFormationUpdate+30   j
                rts
; End of function Boss_JampanFormationUpdate
; ---------------------------------------------------------------------------
dword_4A5BC:    dc.l    $FFFFF800, $FFFFF000, $FFFFE000, $FFFFE000, $FFFFE000, $FFFFF000, $FFFFF800
                                        ; DATA XREF: Boss_JampanFormationUpdate:loc_4A588   r
                dc.l    $4000, $8000, $C000, $C000, $8000, $4000

; Defeat explosion effect
Boss_JampanDefeatExplosion:                             ; DATA XREF: ROM:0004A54C   o  ; was: sub_4A5F0
                move.w  #$C,d7
                movea.w #(word_FFC980-M68K_RAM),a0
                clr.w   d6
loc_4A5FA:                                              ; CODE XREF: Boss_JampanDefeatExplosion+28   j
                move.l  dword_4A62A(pc,d6.w),d0
                add.l   d0,$54(a0)
                add.l   d0,$54(a0)
                move.w  $54(a0),$4C(a0)
                andi.w  #$1FF,$4C(a0)
                addq.w  #4,d6
                lea     $60(a0),a0
                dbf     d7,loc_4A5FA
                subq.w  #1,$48(a5)
                bne.s   locret_4A628
                move.w  #2,4(a5)
locret_4A628:                                           ; CODE XREF: Boss_JampanDefeatExplosion+30   j
                rts
; End of function Boss_JampanDefeatExplosion
; ---------------------------------------------------------------------------
dword_4A62A:    dc.l    $800, $1000, $2000, $2000, $2000, $1000, $800
                                        ; DATA XREF: Boss_JampanDefeatExplosion:loc_4A5FA   r
                dc.l    $FFFFC000, $FFFF8000, $FFFF4000, $FFFF4000, $FFFF8000, $FFFFC000

; ===============================================================================
; DEBUG FUNCTION: Jampan Boss Debug Controller
; Source: Developer test code left in final ROM
; Description: Allows manual parameter manipulation during Jampan boss fight
; Status: Still called in final game but has no visible effect
;
; Controller Input Mapping (word_FFF706 = Controller 1 input):
; UP + A      : Decrease dword_FF9400 by 2
; UP + B      : Decrease dword_FF9404 by 2
; UP + C      : Decrease dword_FF9408 by 2
; DOWN + A    : Increase dword_FF9400 by 2
; DOWN + B    : Increase dword_FF9404 by 2
; DOWN + C    : Increase dword_FF9408 by 2
; LEFT + START : Increase dword_FF9424 by 2
; RIGHT + START: Decrease dword_FF9424 by 2
;
; Button bit mapping:
; Bit 0 = LEFT, Bit 1 = RIGHT, Bit 2 = UP, Bit 3 = DOWN
; Bit 4 = B, Bit 5 = C, Bit 6 = A, Bit 7 = START
;
; Note: This function is called from:
; - Boss_JampanDefeatCleanupInit+10 (line 88428)
; - Boss_JampanDefeatCleanupWait+4 (line 88449)
; ===============================================================================
Boss_JampanDebugController:                             ; CODE XREF: Boss_JampanDefeatCleanupInit+10   p  ; was: sub_4A65E
                                        ; Boss_JampanDefeatCleanupWait+4   p
                btst    #2,(word_FFF706).w              ; Test UP button on controller 1
                beq.s   loc_4A68A
                btst    #6,(word_FFF706).w
                beq.s   loc_4A672
                subq.w  #2,(dword_FF9400).w
loc_4A672:                                              ; CODE XREF: Boss_JampanDebugController+E   j
                btst    #4,(word_FFF706).w
                beq.s   loc_4A67E
                subq.w  #2,(dword_FF9404).w
loc_4A67E:                                              ; CODE XREF: Boss_JampanDebugController+1A   j
                btst    #5,(word_FFF706).w
                beq.s   loc_4A68A
                subq.w  #2,(dword_FF9408).w
loc_4A68A:                                              ; CODE XREF: Boss_JampanDebugController+6   j
                                        ; Boss_JampanDebugController+26   j
                btst    #3,(word_FFF706).w
                beq.s   loc_4A6B6
                btst    #6,(word_FFF706).w
                beq.s   loc_4A69E
                addq.w  #2,(dword_FF9400).w
loc_4A69E:                                              ; CODE XREF: Boss_JampanDebugController+3A   j
                btst    #4,(word_FFF706).w
                beq.s   loc_4A6AA
                addq.w  #2,(dword_FF9404).w
loc_4A6AA:                                              ; CODE XREF: Boss_JampanDebugController+46   j
                btst    #5,(word_FFF706).w
                beq.s   loc_4A6B6
                addq.w  #2,(dword_FF9408).w
loc_4A6B6:                                              ; CODE XREF: Boss_JampanDebugController+32   j
                                        ; Boss_JampanDebugController+52   j
                btst    #0,(word_FFF706).w
                beq.s   loc_4A6CA
                btst    #7,(word_FFF706).w
                beq.s   loc_4A6CA
                addq.w  #2,(dword_FF9424).w
loc_4A6CA:                                              ; CODE XREF: Boss_JampanDebugController+5E   j
                                        ; Boss_JampanDebugController+66   j
                btst    #1,(word_FFF706).w
                beq.s   locret_4A6DE
                btst    #7,(word_FFF706).w
                beq.s   locret_4A6DE
                subq.w  #2,(dword_FF9424).w
locret_4A6DE:                                           ; CODE XREF: Boss_JampanDebugController+72   j
                                        ; Boss_JampanDebugController+7A   j
                rts
; End of function Boss_JampanDebugController
; Checks boss health
Boss_JampanCheckHealth:                                 ; CODE XREF: Boss_JampanMain+4   p  ; was: sub_4A6E0
                move.w  #$A4,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$4C,d0                         ; 'L'
                move.w  d0,(dword_FFA90C).w
                rts
; End of function Boss_JampanCheckHealth
; Handles damage taken
Boss_JampanDamageHandler:                               ; CODE XREF: Boss_JampanMoveState+1E2   p  ; was: sub_4A6FA
                                        ; sub_4953E   p
                tst.l   (dword_FF940C).w
                beq.s   loc_4A708
                move.l  (dword_FF940C).w,d0
                add.l   d0,(dword_FF9400).w
loc_4A708:                                              ; CODE XREF: Boss_JampanDamageHandler+4   j
                tst.l   (dword_FF9410).w
                beq.s   loc_4A716
                move.l  (dword_FF9410).w,d0
                add.l   d0,(dword_FF9404).w
loc_4A716:                                              ; CODE XREF: Boss_JampanDamageHandler+12   j
                tst.l   (dword_FF9414).w
                beq.s   loc_4A724
                move.l  (dword_FF9414).w,d0
                add.l   d0,(dword_FF9408).w
loc_4A724:                                              ; CODE XREF: Boss_JampanDamageHandler+20   j
                andi.w  #$1FF,(dword_FF9400).w
                andi.w  #$1FF,(dword_FF9404).w
                andi.w  #$1FF,(dword_FF9408).w
                movea.w a5,a1
                lea     (word_FFC860).w,a0
                move.w  #$F,d0
loc_4A740:                                              ; CODE XREF: Boss_JampanDamageHandler+8A   j
                lea     (word_1B514).l,a2
                move.w  $48(a0),d4
                add.w   (dword_FF9424).w,d4
                move.w  $4A(a0),d5
                move.w  $4C(a0),d6
                move.w  $4E(a0),d7
                add.w   (dword_FF9400).w,d5
                add.w   (dword_FF9424+2).w,d5
                add.w   (dword_FF9404).w,d6
                add.w   (dword_FF9428).w,d6
                add.w   (dword_FF9408).w,d7
                add.w   (dword_FF9428+2).w,d6
                andi.w  #$1FE,d5
                andi.w  #$1FE,d6
                andi.w  #$1FE,d7
                bsr.s   Boss_JampanFlashOnDamage
                lea     $60(a0),a0
                dbf     d0,loc_4A740
                rts
; End of function Boss_JampanDamageHandler
; Flash effect on damage
Boss_JampanFlashOnDamage:                               ; CODE XREF: Boss_JampanDefeatDebris+3C   p  ; was: sub_4A78A
                                        ; sub_4A160:loc_4A1AA   p
                move.w  -$80(a2,d5.w),d1
                muls.w  d4,d1
                swap    d1
                add.w   d1,d1
                add.w   d1,d1
                move.w  (a2,d6.w),d2
                muls.w  d2,d1
                swap    d1
                cmpi.w  #$3F,d1                         ; '?'
                blt.s   loc_4A7AA
                move.w  #$3F,d1                         ; '?'
                bra.s   loc_4A7B4
; ---------------------------------------------------------------------------
loc_4A7AA:                                              ; CODE XREF: Boss_JampanFlashOnDamage+18   j
                cmpi.w  #$FFC1,d1
                bgt.s   loc_4A7B4
                move.w  #$FFC1,d1
loc_4A7B4:                                              ; CODE XREF: Boss_JampanFlashOnDamage+1E   j
                                        ; Boss_JampanFlashOnDamage+24   j
                clr.w   d2
                move.b  $20(a1),d2
                add.w   d2,d1
                move.b  d1,$20(a0)
                cmp.b   $20(a1),d1
                bhi.s   loc_4A7CE
                ori.w   #$8000,$E(a0)
                bra.s   loc_4A7D4
; ---------------------------------------------------------------------------
loc_4A7CE:                                              ; CODE XREF: Boss_JampanFlashOnDamage+3A   j
                andi.w  #$7FFF,$E(a0)
loc_4A7D4:                                              ; CODE XREF: Boss_JampanFlashOnDamage+42   j
                move.w  (a2,d5.w),d1
                move.w  (a2,d7.w),d2
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                move.l  d2,d3
                move.w  -$80(a2,d5.w),d1
                move.w  -$80(a2,d6.w),d2
                muls.w  d1,d2
                swap    d2
                add.w   d2,d2
                add.w   d2,d2
                move.w  -$80(a2,d7.w),d1
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                sub.l   d2,d3
                swap    d3
                muls.w  d4,d3
                add.l   d3,d3
                add.l   d3,d3
                add.l   $10(a1),d3
                move.l  d3,$10(a0)
                move.w  (a2,d5.w),d1
                move.w  -$80(a2,d7.w),d2
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                move.l  d2,d3
                move.w  -$80(a2,d5.w),d1
                move.w  -$80(a2,d6.w),d2
                muls.w  d1,d2
                swap    d2
                add.w   d2,d2
                add.w   d2,d2
                move.w  (a2,d7.w),d1
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                add.l   d2,d3
                swap    d3
                muls.w  d4,d3
                add.l   d3,d3
                add.l   d3,d3
                add.l   $14(a1),d3
                move.l  d3,$14(a0)
                rts
; End of function Boss_JampanFlashOnDamage
; Main boss handler
Boss_DestroyerMK2Main:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_4A84E
                tst.w   4(a5)
                beq.w   loc_4A8F4
                bsr.w   Boss_DestroyerMK2IntroRoar
                btst    #1,$4C(a5)
                bne.s   loc_4A876
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_4A876
                move.w  $50(a5),d0
                beq.s   loc_4A876
                sub.w   d0,(word_FF8234).w
loc_4A876:                                              ; CODE XREF: Boss_DestroyerMK2Main+12   j
                                        ; Boss_DestroyerMK2Main+1C   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_4A8A4
                btst    #1,(byte_FF80EC).w
                bne.s   loc_4A8A4
                tst.w   (word_FF8200).w
                bne.s   loc_4A8A4
                move.b  #2,(byte_FF80EC).w
                bset    #0,$4C(a5)
                move.w  #$2A,4(a5)                      ; '*'
                bset    #0,(byte_FFA272).w
loc_4A8A4:                                              ; CODE XREF: Boss_DestroyerMK2Main+2E   j
                                        ; Boss_DestroyerMK2Main+36   j
                jsr     (Gfx_InitPaletteFade).l
                bsr.w   Boss_DestroyerMK2ShootPattern2
                btst    #3,$4C(a5)
                beq.s   loc_4A8DA
                move.w  #$C70,d0
                sub.w   (dword_FFA900).w,d0
                addi.w  #-$80,d0
                lea     (word_FFE520).w,a0
                lea     (word_FF98B0).w,a1
                move.w  #$B6,d7
loc_4A8CE:                                              ; CODE XREF: Boss_DestroyerMK2Main+88   j
                move.w  d0,(a0)
                move.w  (a1)+,d1
                add.w   d1,(a0)
                addq.w  #4,a0
                dbf     d7,loc_4A8CE
loc_4A8DA:                                              ; CODE XREF: Boss_DestroyerMK2Main+66   j
                lea     (word_FFE6E0).w,a0
                move.w  (a0),d0
                addi.w  #$C0,d0
                move.w  d0,$10(a5)
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$4E(a5)
loc_4A8F4:                                              ; CODE XREF: Boss_DestroyerMK2Main+4   j
                move.w  4(a5),d0
                lea     off_4A900(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2Main
; ---------------------------------------------------------------------------
off_4A900:      dc.w    Boss_DestroyerMK2Dispatcher-*   ; DATA XREF: Boss_DestroyerMK2Main+AA   o
                dc.w    Boss_DestroyerMK2IdleState-*
                dc.w    Boss_DestroyerMK2AttackState1-*
                dc.w    Boss_DestroyerMK2AttackState2-*
                dc.w    Boss_DestroyerMK2MoveLeft-*
                dc.w    Boss_DestroyerMK2MoveRight-*
                dc.w    Boss_DestroyerMK2Jump-*
                dc.w    Boss_DestroyerMK2SpawnMissile-*
                dc.w    Boss_DestroyerMK2SpawnLaser-*
                dc.w    Projectile_DestroyerMK2Spread-*
                dc.w    Projectile_DestroyerMK2Spread_DescendLoop-*
                dc.w    Boss_DestroyerMK2DamageCheck-*
                dc.w    Boss_DestroyerMK2RecoverFromStun-*
                dc.w    Boss_DestroyerMK2Enrage-*
                dc.w    Boss_DestroyerMK2AnimIdle-*
                dc.w    Boss_DestroyerMK2AnimAttack-*
                dc.w    Boss_DestroyerMK2AnimJump-*
                dc.w    Boss_DestroyerMK2AnimLand-*
                dc.w    Boss_DestroyerMK2AnimDamage-*
                dc.w    Boss_DestroyerMK2DefeatFall-*
                dc.w    Boss_DestroyerMK2DefeatExplosion1-*
                dc.w    Effect_DestroyerMK2Explosion1-*
                dc.w    Effect_DestroyerMK2Explosion2-*
                dc.w    Boss_DestroyerMK2BerserkAttack1-*
                dc.w    Boss_DestroyerMK2BerserkRush-*
                dc.w    Boss_DestroyerMK2BerserkSpin-*
                dc.w    Boss_DestroyerMK2BerserkJump-*
                dc.w    Boss_DestroyerMK2BerserkRoar-*

; Boss state dispatcher
Boss_DestroyerMK2Dispatcher:                            ; DATA XREF: ROM:off_4A900   o  ; was: sub_4A938
                tst.w   (word_FFF720).w
                bmi.w   locret_4AB16
                addq.w  #2,4(a5)
                moveq   #0,d0
                move.l  d0,(dword_FF9404).w
                move.l  d0,(dword_FF9408).w
                move.l  d0,(dword_FF940C).w
                clr.w   (dword_FF9418).w
                lea     (word_FF9820).w,a0
                lea     (word_FF9620).w,a1
                move.w  #$7F,d7
loc_4A962:                                              ; CODE XREF: Boss_DestroyerMK2Dispatcher+2E   j
                move.l  d0,(a0)+
                move.l  d0,(a1)+
                dbf     d7,loc_4A962
                move.b  #4,(byte_FFA420).w
                bset    #3,$4C(a5)
                move.w  #$240,d0
                move.w  #$3DC,d1
                jsr     (Sprite_ClearAllExcept).l
                move.w  #$C0,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  #$118,$14(a5)
                move.b  #4,(byte_FFA95B).w
                move.b  #1,(byte_FFA95A).w
                lea     (word_FFE520).w,a0
                move.w  #$FF80,d0
                move.w  #$B7,d7
loc_4A9AE:                                              ; CODE XREF: Boss_DestroyerMK2Dispatcher+7A   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_4A9AE
                move.b  #$40,$20(a5)                    ; '@'
                move.w  #$100,2(a5)
                move.b  #$88,$23(a5)
                move.w  #$96,$26(a5)
                move.l  #$F808E818,$2C(a5)
                move.l  #$F40CE020,$28(a5)
                move.w  #$1C,$24(a5)
                move.w  #8,(dword_FF9410).w
                movea.w #(word_FFC740-M68K_RAM),a0
                move.w  #$25C,(a0)
                move.b  #$10,$23(a0)
                move.w  #$D00,2(a0)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$D00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$96,$26(a0)
                move.b  #$10,$23(a0)
                move.l  #$28E020,$2C(a0)
                move.l  #$34D030,$28(a0)
                move.w  #$FFC0,$4C(a0)
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$D00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$96,$26(a0)
                move.b  #$10,$23(a0)
                move.l  #$D800E020,$2C(a0)
                move.l  #$CC00D030,$28(a0)
                move.w  #$40,$4C(a0)                    ; '@'
                move.b  $20(a5),d1
                move.w  #3,d7
                clr.w   d6
                movea.w #(word_FFC7A0-M68K_RAM),a0
                lea     word_4AB18(pc),a1
                nop
loc_4AA7E:                                              ; CODE XREF: Boss_DestroyerMK2Dispatcher+17C   j
                move.w  #$244,(a0)
                move.w  #$4D00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$96,$26(a0)
                move.b  d1,$20(a0)
                move.l  #word_EC2AA,8(a0)
                move.w  (a1)+,$4E(a0)
                move.w  (a1)+,$4A(a0)
                move.w  (a1)+,$4C(a0)
                move.w  (a1)+,$E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AA7E
                move.w  #$D0,(dword_FF9404).w
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
                clr.w   d6
loc_4AAC8:                                              ; CODE XREF: Boss_DestroyerMK2Dispatcher+1DA   j
                move.w  #$258,(a0)
                move.w  #$CD00,2(a0)
                move.b  #$18,$23(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.l  #$F808F808,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$30,$24(a0)                    ; '0'
                move.b  d1,$20(a0)
                move.l  #word_EC2D4,8(a0)
                move.w  #$EB00,$E(a0)
                move.w  d6,$4C(a0)
                addi.w  #$40,d6                         ; '@'
                lea     $60(a0),a0
                dbf     d7,loc_4AAC8
locret_4AB16:                                           ; CODE XREF: Boss_DestroyerMK2Dispatcher+4   j
                rts
; End of function Boss_DestroyerMK2Dispatcher
; ---------------------------------------------------------------------------
word_4AB18:     dc.w    0, $FFD4, $FFC4, $F300
                                        ; DATA XREF: Boss_DestroyerMK2Dispatcher+140   o
                dc.w    2, $2C, $FFC4, $FB00
                dc.w    4, $FFD4, $3C, $E300
                dc.w    6, $2C, $3C, $EB00

; Idle state handler
Boss_DestroyerMK2IdleState:                             ; DATA XREF: ROM:0004A902   o  ; was: sub_4AB38
                move.b  #3,(word_FFF7E6+1).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2IdleState
; Attack state 1 handler
Boss_DestroyerMK2AttackState1:                          ; DATA XREF: ROM:0004A904   o  ; was: sub_4AB44
                addq.w  #2,4(a5)
                lea     word_4AB56(pc),a0
                nop
                jsr     (Gfx_DMATransferTiles).l
                rts
; End of function Boss_DestroyerMK2AttackState1
; ---------------------------------------------------------------------------
word_4AB56:     dc.w    $4480, $2000, $304, $9697, $9495, $9293, $9091, $8687, $8485, $8A8B, $8889, $8E8F, $8C8D
                                        ; DATA XREF: Boss_DestroyerMK2AttackState1+4   o

; Attack state 2 handler
Boss_DestroyerMK2AttackState2:                          ; DATA XREF: ROM:0004A906   o  ; was: sub_4AB70
                tst.b   (word_FFF720).w
                bmi.s   locret_4AB8E
                move.w  #8,(dword_FF940C).w
                bsr.w   Boss_DestroyerMK2ShootPattern3
                bsr.w   Boss_DestroyerMK2Land
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4AB8E:                                           ; CODE XREF: Boss_DestroyerMK2AttackState2+4   j
                rts
; End of function Boss_DestroyerMK2AttackState2
; Move left state
Boss_DestroyerMK2MoveLeft:                              ; DATA XREF: ROM:0004A908   o  ; was: sub_4AB90
                bsr.w   Boss_DestroyerMK2CollisionCheck
                bsr.w   Boss_DestroyerMK2CollisionCheck
                bsr.w   Boss_DestroyerMK2CollisionCheck
                bsr.w   Boss_DestroyerMK2CollisionCheck
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                subq.w  #1,$48(a5)
                bne.s   locret_4ABC4
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
                move.b  #$5B,d0                         ; '['
                jsr     (Sound_PlaySFX).l
locret_4ABC4:                                           ; CODE XREF: Boss_DestroyerMK2MoveLeft+20   j
                rts
; End of function Boss_DestroyerMK2MoveLeft
; Move right state
Boss_DestroyerMK2MoveRight:                             ; DATA XREF: ROM:0004A90A   o  ; was: sub_4ABC6
                bsr.w   Boss_DestroyerMK2ShootPattern3
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                move.w  #$E0,d0
                bsr.w   Boss_DestroyerMK2ShootPattern1
                addq.w  #4,$4A(a5)
                cmpi.w  #$100,$4A(a5)
                bne.s   locret_4ABFA
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                moveq   #0,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
locret_4ABFA:                                           ; CODE XREF: Boss_DestroyerMK2MoveRight+22   j
                rts
; End of function Boss_DestroyerMK2MoveRight
; Jump attack state
Boss_DestroyerMK2Jump:                                  ; DATA XREF: ROM:0004A90C   o  ; was: sub_4ABFC
                bsr.w   Boss_DestroyerMK2ShootPattern3
                subq.w  #1,$48(a5)
                bne.s   locret_4AC10
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4AC10:                                           ; CODE XREF: Boss_DestroyerMK2Jump+8   j
                rts
; End of function Boss_DestroyerMK2Jump
; Spawns missile projectile
Boss_DestroyerMK2SpawnMissile:                          ; DATA XREF: ROM:0004A90E   o  ; was: sub_4AC12
                bsr.w   Boss_DestroyerMK2ShootPattern3
                subq.w  #1,$48(a5)
                bne.s   locret_4AC2E
                bsr.w   Projectile_DestroyerMK2Missile
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
locret_4AC2E:                                           ; CODE XREF: Boss_DestroyerMK2SpawnMissile+8   j
                rts
; End of function Boss_DestroyerMK2SpawnMissile
; Missile projectile handler
Projectile_DestroyerMK2Missile:                         ; CODE XREF: Boss_DestroyerMK2SpawnMissile+A   p  ; was: sub_4AC30
                                        ; Boss_DestroyerMK2AnimAttack+2A   p
                move.b  #$D0,$21(a5)
                move.b  #$C0,(byte_FFC6A1).w
                move.b  #$C0,(byte_FFC701).w
                movea.w #(word_FFC7A0-M68K_RAM),a0
                move.w  #$B,d7
loc_4AC4A:                                              ; CODE XREF: Projectile_DestroyerMK2Missile+24   j
                move.b  #$C0,$21(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AC4A
                rts
; End of function Projectile_DestroyerMK2Missile
; Laser projectile handler
Projectile_DestroyerMK2Laser:                           ; CODE XREF: Projectile_DestroyerMK2Spread+2E   p  ; was: sub_4AC5A
                                        ; Effect_DestroyerMK2Explosion1+22   p
                clr.b   $21(a5)
                clr.b   (byte_FFC6A1).w
                clr.b   (byte_FFC701).w
                movea.w #(word_FFC7A0-M68K_RAM),a0
                move.w  #$B,d7
loc_4AC6E:                                              ; CODE XREF: Projectile_DestroyerMK2Laser+1C   j
                clr.b   $21(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AC6E
                rts
; End of function Projectile_DestroyerMK2Laser
; Spawns laser projectile
Boss_DestroyerMK2SpawnLaser:                            ; DATA XREF: ROM:0004A910   o  ; was: sub_4AC7C
                bsr.w   Boss_DestroyerMK2ShootPattern3
                tst.w   (word_FF80C2).w
                bne.s   locret_4ACAA
                addq.w  #2,4(a5)
                subi.w  #$A0,(word_FFA970).w
                clr.b   (byte_FF80EC).w
                movea.w #(word_FFC920-M68K_RAM),a0
                move.w  #8,d7
loc_4AC9C:                                              ; CODE XREF: Boss_DestroyerMK2SpawnLaser+2A   j
                move.b  #8,$23(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AC9C
locret_4ACAA:                                           ; CODE XREF: Boss_DestroyerMK2SpawnLaser+8   j
                rts
; End of function Boss_DestroyerMK2SpawnLaser
; Spread shot projectile
Projectile_DestroyerMK2Spread:                          ; DATA XREF: ROM:0004A912   o  ; was: sub_4ACAC
                bsr.w   Boss_DestroyerMK2ShootPattern3
                eori.w  #1,$54(a5)
                bne.s   loc_4ACC0
                move.w  #$20,4(a5)                      ; ' '
                rts
; ---------------------------------------------------------------------------
loc_4ACC0:                                              ; CODE XREF: Projectile_DestroyerMK2Spread+A   j
                addq.w  #2,4(a5)
; Execute spread attack while descending to landing
Projectile_DestroyerMK2Spread_DescendLoop:              ; DATA XREF: ROM:0004A914   o  ; was: loc_4ACC4
                bsr.w   Boss_DestroyerMK2ShootPattern3
                bsr.s   Boss_DestroyerMK2ToggleShields
                subq.w  #4,(dword_FF9404).w
                cmpi.w  #$60,(dword_FF9404).w           ; '`'
                bcc.s   locret_4ACE8
                bsr.s   Boss_DestroyerMK2DisableShields
                bsr.s   Boss_DestroyerMK2Land
                bsr.w   Projectile_DestroyerMK2Laser
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4ACE8:                                           ; CODE XREF: Projectile_DestroyerMK2Spread+28   j
                rts
; End of function Projectile_DestroyerMK2Spread
; Landing after jump
Boss_DestroyerMK2Land:                                  ; CODE XREF: Boss_DestroyerMK2AttackState2+10   p  ; was: sub_4ACEA
                                        ; Projectile_DestroyerMK2Spread+2C   p
                move.w  #$FF,d7
                lea     (dword_FF9420).w,a0
loc_4ACF2:                                              ; CODE XREF: Boss_DestroyerMK2Land+A   j
                move.w  d7,(a0)+
                dbf     d7,loc_4ACF2
                rts
; End of function Boss_DestroyerMK2Land
; Toggles 8 shield sprite priority bits
Boss_DestroyerMK2ToggleShields:                         ; CODE XREF: Projectile_DestroyerMK2Spread+1C   p  ; was: sub_4ACFA
                                        ; Boss_DestroyerMK2AnimAttack+10   p
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
loc_4AD02:                                              ; CODE XREF: Boss_DestroyerMK2ToggleShields+12   j
                eori.w  #$8000,2(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AD02
                rts
; End of function Boss_DestroyerMK2ToggleShields
; Disables all 8 shields
Boss_DestroyerMK2DisableShields:                        ; CODE XREF: Projectile_DestroyerMK2Spread+2A   p  ; was: sub_4AD12
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
loc_4AD1A:                                              ; CODE XREF: Boss_DestroyerMK2DisableShields+16   j
                andi.w  #$7FFF,2(a0)
                clr.b   $21(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AD1A
                rts
; End of function Boss_DestroyerMK2DisableShields
; Enables all 8 shields with palette
Boss_DestroyerMK2EnableShields:                         ; CODE XREF: Boss_DestroyerMK2AnimAttack+20   p  ; was: sub_4AD2E
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
loc_4AD36:                                              ; CODE XREF: Boss_DestroyerMK2EnableShields+18   j
                ori.w   #$8000,2(a0)
                move.b  #$80,$21(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AD36
                rts
; End of function Boss_DestroyerMK2EnableShields
; Checks if boss takes damage
Boss_DestroyerMK2DamageCheck:                           ; DATA XREF: ROM:0004A916   o  ; was: sub_4AD4C
                bsr.w   Boss_DestroyerMK2ShootPattern3
                tst.w   (word_FFC7A4).w
                bne.s   locret_4AD9C
                tst.w   (word_FFC804).w
                bne.s   locret_4AD9C
                tst.w   (word_FFC864).w
                bne.s   locret_4AD9C
                tst.w   (word_FFC8C4).w
                bne.s   locret_4AD9C
                bsr.s   Boss_DestroyerMK2CollisionCheck
                bsr.s   Boss_DestroyerMK2CollisionCheck
                bsr.s   Boss_DestroyerMK2CollisionCheck
                bsr.s   Boss_DestroyerMK2CollisionCheck
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                cmpi.w  #$40,$48(a5)                    ; '@'
                bne.s   loc_4AD8E
                move.b  #$E6,d0
                jsr     (Sound_PlaySFX).l
loc_4AD8E:                                              ; CODE XREF: Boss_DestroyerMK2DamageCheck+36   j
                subq.w  #1,$48(a5)
                bne.s   locret_4AD9C
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
locret_4AD9C:                                           ; CODE XREF: Boss_DestroyerMK2DamageCheck+8   j
                                        ; Boss_DestroyerMK2DamageCheck+E   j
                rts
; End of function Boss_DestroyerMK2DamageCheck
; Collision detection with player
Boss_DestroyerMK2CollisionCheck:                        ; CODE XREF: Boss_DestroyerMK2MoveLeft   p  ; was: sub_4AD9E
                                        ; Boss_DestroyerMK2MoveLeft+4   p
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                move.w  (dword_FFFF08+2).w,d1
                andi.w  #$FF,d1
                add.w   d0,d0
                add.w   d1,d1
                lea     (dword_FF9420).w,a0
                move.w  (a0,d0.w),d2
                move.w  (a0,d1.w),(a0,d0.w)
                move.w  d2,(a0,d1.w)
                rts
; End of function Boss_DestroyerMK2CollisionCheck
; Applies palette fade to DestroyerMK2
Gfx_DestroyerMK2ApplyPaletteFade:                       ; CODE XREF: Boss_DestroyerMK2MoveLeft+18   p  ; was: sub_4ADCC
                                        ; Boss_DestroyerMK2MoveRight+C   p
                move.w  #$7000,d7
loc_4ADD0:                                              ; CODE XREF: Boss_DestroyerMK2Enrage+14   p
                                        ; Boss_DestroyerMK2AnimIdle+14   p
                movea.w #(word_FFE360-M68K_RAM),a0
                move.w  #$F,d5
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Gfx_DestroyerMK2ApplyPaletteFade
; Shooting pattern 1
Boss_DestroyerMK2ShootPattern1:                         ; CODE XREF: Boss_DestroyerMK2MoveRight+14   p  ; was: sub_4ADE0
                                        ; sub_4AEFA   p
                lea     (dword_FF9420).w,a0
                lea     (word_FF9820).w,a1
                lea     (word_FF9620).w,a2
                move.w  $4A(a5),d1
                add.w   d1,d1
                move.w  #3,d7
loc_4ADF6:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern1+26   j
                move.w  (a0,d1.w),d2
                add.w   d2,d2
                move.w  d0,(a1,d2.w)
                clr.w   (a2,d2.w)
                addq.w  #2,d1
                dbf     d7,loc_4ADF6
                rts
; End of function Boss_DestroyerMK2ShootPattern1
; Boss hit reaction animation
Boss_DestroyerMK2HitReaction:                           ; CODE XREF: Boss_DestroyerMK2Enrage+18   p  ; was: sub_4AE0C
                lea     (dword_FF9420).w,a0
                lea     (word_FF9620).w,a1
                move.w  $4A(a5),d1
                add.w   d1,d1
                move.w  #3,d7
loc_4AE1E:                                              ; CODE XREF: Boss_DestroyerMK2HitReaction+30   j
                move.w  (a0,d1.w),d2
                add.w   d2,d2
                move.w  d7,d0
                andi.w  #1,d0
                beq.s   loc_4AE34
                move.w  #$FFFF,(a1,d2.w)
                bra.s   loc_4AE3A
; ---------------------------------------------------------------------------
loc_4AE34:                                              ; CODE XREF: Boss_DestroyerMK2HitReaction+1E   j
                move.w  #1,(a1,d2.w)
loc_4AE3A:                                              ; CODE XREF: Boss_DestroyerMK2HitReaction+26   j
                addq.w  #2,d1
                dbf     d7,loc_4AE1E
                rts
; End of function Boss_DestroyerMK2HitReaction
; Stun state after heavy damage
Boss_DestroyerMK2StunState:                             ; CODE XREF: Boss_DestroyerMK2Enrage+4   p  ; was: sub_4AE42
                                        ; Boss_DestroyerMK2AnimIdle+4   p
                move.w  #$FE,d7
                lea     (word_FF9820).w,a0
                lea     (word_FF9620).w,a1
loc_4AE4E:                                              ; CODE XREF: Boss_DestroyerMK2StunState+20   j
                tst.w   (a1)
                beq.s   loc_4AE5E
                move.w  (a1),d0
                add.w   d0,(a0)
                tst.w   (a1)
                bmi.s   loc_4AE5C
                addq.w  #1,(a1)
loc_4AE5C:                                              ; CODE XREF: Boss_DestroyerMK2StunState+16   j
                subq.w  #1,(a1)
loc_4AE5E:                                              ; CODE XREF: Boss_DestroyerMK2StunState+E   j
                addq.w  #2,a0
                addq.w  #2,a1
                dbf     d7,loc_4AE4E
                rts
; End of function Boss_DestroyerMK2StunState
; Recovery from stun state
Boss_DestroyerMK2RecoverFromStun:                       ; DATA XREF: ROM:0004A918   o  ; was: sub_4AE68
                bsr.w   Boss_DestroyerMK2ShootPattern3
                move.w  $56(a5),d0
                move.w  #$FFE0,(dword_FF9414).w
                move.w  word_4AE9C(pc,d0.w),$48(a5)
                addq.w  #2,$56(a5)
                andi.w  #$E,$56(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2RecoverFromStun
; ---------------------------------------------------------------------------
                dc.w    $130, $FFF0, $130, $FFF0, $90, $FFF0, $130, $90
word_4AE9C:     dc.w    $2000, $8000, $2000, $8000, $4000, $8000, $2000, $4000
                                        ; DATA XREF: Boss_DestroyerMK2RecoverFromStun+E   r

; Enrage mode at low health
Boss_DestroyerMK2Enrage:                                ; DATA XREF: ROM:0004A91A   o  ; was: sub_4AEAC
                bsr.w   Boss_DestroyerMK2ShootPattern3
                bsr.w   Boss_DestroyerMK2StunState
                move.w  (word_FFA000).w,d0
                andi.w  #$E,d0
                move.w  $48(a5),d7
                bsr.w   loc_4ADD0
                bsr.w   Boss_DestroyerMK2HitReaction
                addq.w  #4,$4A(a5)
                cmpi.w  #$100,$4A(a5)
                bne.s   locret_4AEDC
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
locret_4AEDC:                                           ; CODE XREF: Boss_DestroyerMK2Enrage+26   j
                rts
; End of function Boss_DestroyerMK2Enrage
; Idle animation state
Boss_DestroyerMK2AnimIdle:                              ; DATA XREF: ROM:0004A91C   o  ; was: sub_4AEDE
                bsr.w   Boss_DestroyerMK2ShootPattern3
                bsr.w   Boss_DestroyerMK2StunState
                move.w  (word_FFA000).w,d0
                andi.w  #$E,d0
                move.w  $48(a5),d7
                bsr.w   loc_4ADD0
                move.w  (dword_FF9414).w,d0
; End of function Boss_DestroyerMK2AnimIdle
; Walk animation state
Boss_DestroyerMK2AnimWalk:
                bsr.w   Boss_DestroyerMK2ShootPattern1  ; was: sub_4AEFA
                addq.w  #4,$4A(a5)
                cmpi.w  #$100,$4A(a5)
                bne.s   locret_4AF12
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
locret_4AF12:                                           ; CODE XREF: Boss_DestroyerMK2AnimWalk+E   j
                rts
; End of function Boss_DestroyerMK2AnimWalk
; Attack animation state
Boss_DestroyerMK2AnimAttack:                            ; DATA XREF: ROM:0004A91E   o  ; was: sub_4AF14
                bsr.w   Boss_DestroyerMK2ShootPattern3
                move.w  (word_FFA000).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                bsr.w   Boss_DestroyerMK2ToggleShields
                addq.w  #4,(dword_FF9404).w
                cmpi.w  #$D0,(dword_FF9404).w
                bne.s   locret_4AF48
                bsr.w   Boss_DestroyerMK2EnableShields
                moveq   #0,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                bsr.w   Projectile_DestroyerMK2Missile
                move.w  #$12,4(a5)
locret_4AF48:                                           ; CODE XREF: Boss_DestroyerMK2AnimAttack+1E   j
                rts
; End of function Boss_DestroyerMK2AnimAttack
; Jump animation state
Boss_DestroyerMK2AnimJump:                              ; DATA XREF: ROM:0004A920   o  ; was: sub_4AF4A
                clr.w   $1C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2AnimJump
; Landing animation state
Boss_DestroyerMK2AnimLand:                              ; DATA XREF: ROM:0004A922   o  ; was: sub_4AF5A
                bsr.w   Boss_DestroyerMK2ShootPattern3
                addi.w  #-$10,$1C(a5)
                move.w  $1C(a5),d1
                andi.w  #$1FE,d1
                beq.s   loc_4AF9E
                move.w  (dword_FF9410).w,d6
                add.w   d6,d6
                move.w  word_4AFBE(pc,d6.w),d0
                lea     (word_1B514).l,a3
                move.w  word_1B494-word_1B514(a3,d1.w),d1
                bpl.s   loc_4AF90
                ext.l   d1
                move.w  word_4AFD0(pc,d6.w),d2
                asl.l   d2,d1
                swap    d1
                add.w   d1,d0
loc_4AF90:                                              ; CODE XREF: Boss_DestroyerMK2AnimLand+28   j
                bsr.w   Boss_DestroyerMK2PlayFootstep
                beq.s   locret_4AFBC
                move.w  #$12,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4AF9E:                                              ; CODE XREF: Boss_DestroyerMK2AnimLand+12   j
                addq.w  #2,4(a5)
                clr.w   (dword_FF941C).w
                addq.w  #2,(dword_FF9418+2).w
                andi.w  #$1E,(dword_FF9418+2).w
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                move.w  d0,$48(a5)
locret_4AFBC:                                           ; CODE XREF: Boss_DestroyerMK2AnimLand+3A   j
                rts
; End of function Boss_DestroyerMK2AnimLand
; ---------------------------------------------------------------------------
word_4AFBE:     dc.w    5, 5, 5, 4, 4, 4, 3, 3, 2
                                        ; DATA XREF: Boss_DestroyerMK2AnimLand+1A   r
word_4AFD0:     dc.w    5, 5, 5, 5, 4, 4, 4, 3, 3
                                        ; DATA XREF: Boss_DestroyerMK2AnimLand+2C   r

; Damage animation state
Boss_DestroyerMK2AnimDamage:                            ; DATA XREF: ROM:0004A924   o  ; was: sub_4AFE2
                bsr.w   Boss_DestroyerMK2ShootPattern3
                move.w  (dword_FF9418+2).w,d0
                tst.w   $48(a5)
                bmi.w   loc_4B01C
                move.w  d0,d0
                lea     off_4AFFC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; ---------------------------------------------------------------------------
off_4AFFC:      dc.w    Boss_DestroyerMK2DefeatStateMachine-*  ; DATA XREF: Boss_DestroyerMK2AnimDamage+12   o
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2StateDispatcher1-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2DefeatStateMachine-*
                dc.w    Boss_DestroyerMK2StateDispatcher2-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2StateDispatcher1-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2StateDispatcher2-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2StateDispatcher2-*
                dc.w    Boss_DestroyerMK2StateDispatcher1-*
; ---------------------------------------------------------------------------
loc_4B01C:                                              ; CODE XREF: Boss_DestroyerMK2AnimDamage+C   j
                move.w  d0,d0
                lea     off_4B026(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2AnimDamage
; ---------------------------------------------------------------------------
off_4B026:      dc.w    Boss_DestroyerMK2DefeatStateMachine-*  ; DATA XREF: Boss_DestroyerMK2AnimDamage+3C   o
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2DefeatInit-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2DefeatStateMachine-*
                dc.w    Boss_DestroyerMK2DefeatInit-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2DefeatInit-*
                dc.w    Boss_DestroyerMK2DefeatInit-*
                dc.w    Boss_DestroyerMK2StateDispatcher2-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2StateDispatcher2-*
                dc.w    Boss_DestroyerMK2DefeatInit-*

; Updates boss palette
Boss_DestroyerMK2UpdatePalette:                         ; CODE XREF: Boss_DestroyerMK2PlaySFX+44   j  ; was: sub_4B046
                                        ; Boss_DestroyerMK2ProjectileDelayLoop+A   j
                                        ; DATA XREF:
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2UpdatePalette
; State machine for defeat sequence
Boss_DestroyerMK2DefeatStateMachine:                    ; DATA XREF: Boss_DestroyerMK2AnimDamage:off_4AFFC   o  ; was: sub_4B04C
                                        ; Boss_DestroyerMK2AnimDamage+24   o
                move.w  (dword_FF941C).w,d0
                lea     off_4B058(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2DefeatStateMachine
; ---------------------------------------------------------------------------
off_4B058:      dc.w    Boss_DestroyerMK2DefeatExplosion1Alt-*  ; DATA XREF: Boss_DestroyerMK2DefeatStateMachine+4   o
                dc.w    Boss_DestroyerMK2DefeatExplosion2Alt-*
                dc.w    Boss_DestroyerMK2DefeatSpawnExplosions-*
                dc.w    Boss_DestroyerMK2UpdatePalette-*

; First defeat explosion phase
Boss_DestroyerMK2DefeatExplosion1Alt:                   ; DATA XREF: ROM:off_4B058   o  ; was: sub_4B060
                addq.w  #2,(dword_FF941C).w
                move.w  (word_FF8248).w,d0
                cmp.w   $10(a5),d0
                bgt.s   loc_4B074
                movea.w #(word_FFC7A0-M68K_RAM),a0
                bra.s   loc_4B078
; ---------------------------------------------------------------------------
loc_4B074:                                              ; CODE XREF: Boss_DestroyerMK2DefeatExplosion1Alt+C   j
                movea.w #(word_FFC800-M68K_RAM),a0
loc_4B078:                                              ; CODE XREF: Boss_DestroyerMK2DefeatExplosion1Alt+12   j
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
                move.w  #$20,$48(a5)                    ; ' '
                rts
; End of function Boss_DestroyerMK2DefeatExplosion1Alt
; Second defeat explosion phase
Boss_DestroyerMK2DefeatExplosion2Alt:                   ; DATA XREF: ROM:0004B05A   o  ; was: sub_4B084
                subq.w  #1,$48(a5)
                bne.s   locret_4B0AC
                addq.w  #2,(dword_FF941C).w
                move.w  (word_FF8248).w,d0
                cmp.w   $10(a5),d0
                bgt.s   loc_4B09E
                movea.w #(word_FFC860-M68K_RAM),a0
                bra.s   loc_4B0A2
; ---------------------------------------------------------------------------
loc_4B09E:                                              ; CODE XREF: Boss_DestroyerMK2DefeatExplosion2Alt+12   j
                movea.w #(word_FFC8C0-M68K_RAM),a0
loc_4B0A2:                                              ; CODE XREF: Boss_DestroyerMK2DefeatExplosion2Alt+18   j
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
                move.w  #$40,$48(a5)                    ; '@'
locret_4B0AC:                                           ; CODE XREF: Boss_DestroyerMK2DefeatExplosion2Alt+4   j
                rts
; End of function Boss_DestroyerMK2DefeatExplosion2Alt
; Spawns multiple defeat explosions at different positions
Boss_DestroyerMK2DefeatSpawnExplosions:                 ; DATA XREF: ROM:0004B05C   o  ; was: sub_4B0AE
                subq.w  #1,$48(a5)
                bne.s   locret_4B0E4
                addq.w  #2,(dword_FF941C).w
                move.w  (word_FF8248).w,d0
                cmp.w   $10(a5),d0
                bgt.s   loc_4B0D4
                movea.w #(word_FFC7A0-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
                movea.w #(word_FFC860-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
                rts
; ---------------------------------------------------------------------------
loc_4B0D4:                                              ; CODE XREF: Boss_DestroyerMK2DefeatSpawnExplosions+12   j
                movea.w #(word_FFC800-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
                movea.w #(word_FFC8C0-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
locret_4B0E4:                                           ; CODE XREF: Boss_DestroyerMK2DefeatSpawnExplosions+4   j
                rts
; End of function Boss_DestroyerMK2DefeatSpawnExplosions
; Defeat sequence initialization
Boss_DestroyerMK2DefeatInit:                            ; DATA XREF: ROM:0004B02A   o  ; was: sub_4B0E6
                                        ; ROM:0004B032   o
                move.w  (dword_FF941C).w,d0
                lea     off_4B0F2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2DefeatInit
; ---------------------------------------------------------------------------
off_4B0F2:      dc.w    Boss_DestroyerMK2DefeatStagger-*  ; DATA XREF: Boss_DestroyerMK2DefeatInit+4   o
                dc.w    Boss_DestroyerMK2AdvanceDefeatState-*
                dc.w    Boss_DestroyerMK2UpdatePalette-*

; Staggering during defeat
Boss_DestroyerMK2DefeatStagger:                         ; DATA XREF: ROM:off_4B0F2   o  ; was: sub_4B0F8
                bsr.w   Boss_DestroyerMK2DefeatExplosion2
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2DefeatStagger
; Advances the boss defeat state machine
Boss_DestroyerMK2AdvanceDefeatState:                    ; DATA XREF: ROM:0004B0F4   o  ; was: sub_4B102
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2AdvanceDefeatState
; Flash effect on damage
Boss_DestroyerMK2FlashDamage:                           ; DATA XREF: Boss_DestroyerMK2AnimDamage+1C   o  ; was: sub_4B108
                                        ; Boss_DestroyerMK2AnimDamage+1E   o
                move.w  (dword_FF941C).w,d0
                lea     off_4B114(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2FlashDamage
; ---------------------------------------------------------------------------
off_4B114:      dc.w    Boss_DestroyerMK2ShakeOnLand-*  ; DATA XREF: Boss_DestroyerMK2FlashDamage+4   o
                dc.w    Boss_DestroyerMK2PlaySFX-*

; Screen shake on landing
Boss_DestroyerMK2ShakeOnLand:                           ; DATA XREF: ROM:off_4B114   o  ; was: sub_4B118
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                bmi.s   loc_4B130
                move.w  #$30,$58(a5)                    ; '0'
                move.w  #$1E0,$5A(a5)
                bra.s   loc_4B13C
; ---------------------------------------------------------------------------
loc_4B130:                                              ; CODE XREF: Boss_DestroyerMK2ShakeOnLand+8   j
                move.w  #$FFD0,$58(a5)
                move.w  #$120,$5A(a5)
loc_4B13C:                                              ; CODE XREF: Boss_DestroyerMK2ShakeOnLand+16   j
                move.w  $10(a5),d0
                add.w   d0,$58(a5)
                move.w  #5,$5C(a5)
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2ShakeOnLand
; Plays boss sound effects
Boss_DestroyerMK2PlaySFX:                               ; DATA XREF: ROM:0004B116   o  ; was: sub_4B150
                move.w  #4,d1
                move.w  #$8004,d2
                move.w  $58(a5),d3
                move.w  $14(a5),d4
                move.w  $5A(a5),d6
                andi.w  #$1FE,d6
                jsr     (Boss_DestroyerMK2UpdateSprite).l
                btst    #7,$58(a5)
                bmi.s   loc_4B17E
                addi.w  #$10,$5A(a5)
                bra.s   loc_4B184
; ---------------------------------------------------------------------------
loc_4B17E:                                              ; CODE XREF: Boss_DestroyerMK2PlaySFX+24   j
                addi.w  #-$10,$5A(a5)
loc_4B184:                                              ; CODE XREF: Boss_DestroyerMK2PlaySFX+2C   j
                subq.w  #1,$5C(a5)
                bne.s   locret_4B198
                move.b  #$E9,d0
                jsr     (Sound_PlaySFX).l
                bra.w   Boss_DestroyerMK2UpdatePalette
; ---------------------------------------------------------------------------
locret_4B198:                                           ; CODE XREF: Boss_DestroyerMK2PlaySFX+38   j
                rts
; End of function Boss_DestroyerMK2PlaySFX
; Dispatches to boss state handlers using jump table
Boss_DestroyerMK2StateDispatcher1:                      ; DATA XREF: Boss_DestroyerMK2AnimDamage+20   o  ; was: sub_4B19A
                                        ; Boss_DestroyerMK2AnimDamage+2C   o
                move.w  (dword_FF941C).w,d0
                lea     off_4B1A6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2StateDispatcher1
; ---------------------------------------------------------------------------
off_4B1A6:      dc.w    Boss_DestroyerMK2SpawnThreeProjectiles-*  ; DATA XREF: Boss_DestroyerMK2StateDispatcher1+4   o
                dc.w    Boss_DestroyerMK2SpawnThreeProjectiles_Loop-*
                dc.w    Boss_DestroyerMK2ProjectileDelayLoop-*

; Spawns three projectiles with sequential delay
Boss_DestroyerMK2SpawnThreeProjectiles:                 ; DATA XREF: ROM:off_4B1A6   o  ; was: sub_4B1AC
                move.w  #3,$4A(a5)
                addq.w  #2,(dword_FF941C).w
; Spawn projectile slot and initialize parameters
Boss_DestroyerMK2SpawnThreeProjectiles_Loop:            ; DATA XREF: ROM:0004B1A8   o  ; was: loc_4B1B6
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_4B21E
                move.w  #$258,(a0)
                move.w  #$CD00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.b  #$C0,$21(a0)
                move.l  #$F808FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$30,$24(a0)                    ; '0'
                move.b  d1,$20(a0)
                move.l  #word_EC2D4,8(a0)
                move.w  #$EB00,$E(a0)
                clr.w   $4C(a0)
                move.w  #2,$46(a0)
                move.w  $4A(a5),$44(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
loc_4B21E:                                              ; CODE XREF: Boss_DestroyerMK2SpawnThreeProjectiles+10   j
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2SpawnThreeProjectiles
; Waits for projectile spawn delay and loops
Boss_DestroyerMK2ProjectileDelayLoop:                   ; DATA XREF: ROM:0004B1AA   o  ; was: sub_4B22A
                subq.w  #1,$48(a5)
                bne.s   locret_4B23C
                subq.w  #1,$4A(a5)
                beq.w   Boss_DestroyerMK2UpdatePalette
                subq.w  #2,(dword_FF941C).w
locret_4B23C:                                           ; CODE XREF: Boss_DestroyerMK2ProjectileDelayLoop+4   j
                rts
; End of function Boss_DestroyerMK2ProjectileDelayLoop
; Dispatches to alternate state machine
Boss_DestroyerMK2StateDispatcher2:                      ; DATA XREF: Boss_DestroyerMK2AnimDamage+26   o  ; was: sub_4B23E
                                        ; Boss_DestroyerMK2AnimDamage+30   o
                move.w  (dword_FF941C).w,d0
                lea     off_4B24A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2StateDispatcher2
; ---------------------------------------------------------------------------
off_4B24A:      dc.w    Boss_DestroyerMK2SpawnProjectileSpread-*  ; DATA XREF: Boss_DestroyerMK2StateDispatcher2+4   o
                dc.w    Boss_DestroyerMK2UpdatePalette-*

; Spawns spread pattern of 10 projectiles
Boss_DestroyerMK2SpawnProjectileSpread:                 ; DATA XREF: ROM:off_4B24A   o  ; was: sub_4B24E
                move.w  #(loc_4B252-*),d7
loc_4B252:                                              ; DATA XREF: Boss_DestroyerMK2SpawnProjectileSpread   o
                moveq   #0,d6
loc_4B254:                                              ; CODE XREF: Boss_DestroyerMK2SpawnProjectileSpread:loc_4B2C0   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_4B2C0
                move.w  #$258,(a0)
                move.w  #$CD00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.b  #$C0,$21(a0)
                move.l  #$F808FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$30,$24(a0)                    ; '0'
                move.b  d1,$20(a0)
                move.l  #word_EC2D4,8(a0)
                move.w  #$EB00,$E(a0)
                clr.w   $4C(a0)
                move.w  #4,$46(a0)
                move.w  word_4B2CE(pc,d6.w),$44(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),d0
                move.w  d0,$14(a0)
                addq.w  #2,d6
loc_4B2C0:                                              ; CODE XREF: Boss_DestroyerMK2SpawnProjectileSpread+C   j
                dbf     d7,loc_4B254
                clr.w   (dword_FF941C+2).w
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2SpawnProjectileSpread
; ---------------------------------------------------------------------------
word_4B2CE:     dc.w    0, $FFFE, 2, $FFFC, 4, 0, $FFE0, $20, $FFC0, $40
                                        ; DATA XREF: Boss_DestroyerMK2SpawnProjectileSpread+5C   r

; Falling during defeat
Boss_DestroyerMK2DefeatFall:                            ; DATA XREF: ROM:0004A926   o  ; was: sub_4B2E2
                bsr.w   Boss_DestroyerMK2ShootPattern3
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2DefeatFall
; First explosion in defeat
Boss_DestroyerMK2DefeatExplosion1:                      ; DATA XREF: ROM:0004A928   o  ; was: sub_4B2F2
                bsr.w   Boss_DestroyerMK2ShootPattern3
                subq.w  #1,$48(a5)
                bne.s   locret_4B302
                move.w  #$22,4(a5)                      ; '"'
locret_4B302:                                           ; CODE XREF: Boss_DestroyerMK2DefeatExplosion1+8   j
                rts
; End of function Boss_DestroyerMK2DefeatExplosion1
; Explosion effect 1
Effect_DestroyerMK2Explosion1:                          ; DATA XREF: ROM:0004A92A   o  ; was: sub_4B304
                bsr.w   Boss_DestroyerMK2ShootPattern3
                tst.w   (word_FFC7A4).w
                bne.s   locret_4B334
                tst.w   (word_FFC804).w
                bne.s   locret_4B334
                tst.w   (word_FFC864).w
                bne.s   locret_4B334
                tst.w   (word_FFC8C4).w
                bne.s   locret_4B334
                tst.w   (word_FFC744).w
                bne.s   locret_4B334
                bsr.w   Projectile_DestroyerMK2Laser
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
locret_4B334:                                           ; CODE XREF: Effect_DestroyerMK2Explosion1+8   j
                                        ; Effect_DestroyerMK2Explosion1+E   j
                rts
; End of function Effect_DestroyerMK2Explosion1
; Explosion effect 2
Effect_DestroyerMK2Explosion2:                          ; DATA XREF: ROM:0004A92C   o  ; was: sub_4B336
                jsr     Projectile_DestroyerMK2DebrisMain(pc)  ; (pc)
                nop
                subq.w  #1,$48(a5)
                bne.s   locret_4B346
                addq.w  #2,4(a5)
locret_4B346:                                           ; CODE XREF: Effect_DestroyerMK2Explosion2+A   j
                rts
; End of function Effect_DestroyerMK2Explosion2
; Berserk attack pattern 1
Boss_DestroyerMK2BerserkAttack1:                        ; DATA XREF: ROM:0004A92E   o  ; was: sub_4B348
                bsr.s   Boss_DestroyerMK2BerserkAttack2
                addq.w  #1,$48(a5)
                cmpi.w  #$F,$48(a5)
                bne.s   locret_4B376
                addq.w  #2,4(a5)
                lea     word_4B366(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; ---------------------------------------------------------------------------
word_4B366:     dc.w    $4480, $4000, $104, 0, 0, 0, 0, 0
                                        ; DATA XREF: Boss_DestroyerMK2BerserkAttack1+12   o
; ---------------------------------------------------------------------------
locret_4B376:                                           ; CODE XREF: Boss_DestroyerMK2BerserkAttack1+C   j
                rts
; End of function Boss_DestroyerMK2BerserkAttack1
; Berserk attack pattern 2
Boss_DestroyerMK2BerserkAttack2:                        ; CODE XREF: Boss_DestroyerMK2BerserkAttack1   p  ; was: sub_4B378
                                        ; sub_4B394   p
                move.w  $48(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Boss_DestroyerMK2BerserkAttack2
; Berserk rush attack
Boss_DestroyerMK2BerserkRush:                           ; DATA XREF: ROM:0004A930   o  ; was: sub_4B394
                bsr.s   Boss_DestroyerMK2BerserkAttack2
                addq.w  #2,4(a5)
                lea     word_4B3A6(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_DestroyerMK2BerserkRush
; ---------------------------------------------------------------------------
word_4B3A6:     dc.w    $4490, $4000, $104, 0, 0, 0, 0, 0
                                        ; DATA XREF: Boss_DestroyerMK2BerserkRush+6   o

; Berserk spin attack
Boss_DestroyerMK2BerserkSpin:                           ; DATA XREF: ROM:0004A932   o  ; was: sub_4B3B6
                bsr.s   Boss_DestroyerMK2BerserkAttack2
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                bclr    #3,$4C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2BerserkSpin
; Berserk jump attack
Boss_DestroyerMK2BerserkJump:                           ; DATA XREF: ROM:0004A934   o  ; was: sub_4B3D0
                bsr.s   Boss_DestroyerMK2BerserkAttack2
                move.w  #$240,d0
                move.w  #$3DC,d1
                jsr     (Sprite_ClearAllExcept).l
                move.b  #4,(byte_FFA95A).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2BerserkJump
; Berserk roar attack
Boss_DestroyerMK2BerserkRoar:                           ; DATA XREF: ROM:0004A936   o  ; was: sub_4B3EC
                bsr.s   Boss_DestroyerMK2BerserkAttack2
                subq.w  #1,$48(a5)
                bne.s   locret_4B3FA
                clr.w   (a5)
                addq.w  #2,4(a5)
locret_4B3FA:                                           ; CODE XREF: Boss_DestroyerMK2BerserkRoar+6   j
                rts
; End of function Boss_DestroyerMK2BerserkRoar
; Second explosion in defeat
Boss_DestroyerMK2DefeatExplosion2:                      ; CODE XREF: Boss_DestroyerMK2DefeatStagger   p  ; was: sub_4B3FC
                movea.w #(word_FFC740-M68K_RAM),a0
; End of function Boss_DestroyerMK2DefeatExplosion2
; Third explosion in defeat
Boss_DestroyerMK2DefeatExplosion3:                      ; CODE XREF: Boss_DestroyerMK2DefeatExplosion1Alt:loc_4B078   p  ; was: sub_4B400
                                        ; sub_4B084:loc_4B0A2   p
                tst.w   4(a0)
                bne.s   locret_4B40A
                addq.w  #2,4(a0)
locret_4B40A:                                           ; CODE XREF: Boss_DestroyerMK2DefeatExplosion3+4   j
                rts
; End of function Boss_DestroyerMK2DefeatExplosion3
; Creates horizontal laser beam during defeat
Boss_DestroyerMK2DefeatLaserEffect:
                move.w  (word_FF8248).w,d0              ; was: sub_4B40C
                sub.w   $10(a5),d0
                bmi.s   loc_4B424
                move.w  #$30,$58(a5)                    ; '0'
                move.w  #$1D0,$5A(a5)
                bra.s   loc_4B430
; ---------------------------------------------------------------------------
loc_4B424:                                              ; CODE XREF: Boss_DestroyerMK2DefeatLaserEffect+8   j
                move.w  #$FFD0,$58(a5)
                move.w  #$D0,$5A(a5)
loc_4B430:                                              ; CODE XREF: Boss_DestroyerMK2DefeatLaserEffect+16   j
                move.w  $10(a5),d0
                add.w   d0,$58(a5)
                move.w  #4,$5C(a5)
loc_4B43E:                                              ; CODE XREF: Boss_DestroyerMK2DefeatLaserEffect+56   j
                move.w  #4,d1
                move.w  #$8004,d2
                move.w  $58(a5),d3
                move.w  $14(a5),d4
                move.w  $5A(a5),d6
                jsr     (Boss_DestroyerMK2UpdateSprite).l
                addi.w  #$20,$5A(a5)                    ; ' '
                subq.w  #1,$5C(a5)
                bne.s   loc_4B43E
                move.b  #$E9,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Boss_DestroyerMK2DefeatLaserEffect
; Plays footstep sound
Boss_DestroyerMK2PlayFootstep:                          ; CODE XREF: Boss_DestroyerMK2AnimLand:loc_4AF90   p  ; was: sub_4B470
                cmpi.w  #$110,(word_FF9820).w
                bge.s   loc_4B48A
                move.w  #$FE,d7
                lea     (word_FF9820).w,a0
loc_4B480:                                              ; CODE XREF: Boss_DestroyerMK2PlayFootstep+12   j
                add.w   d0,(a0)+
                dbf     d7,loc_4B480
                clr.w   d0
                rts
; ---------------------------------------------------------------------------
loc_4B48A:                                              ; CODE XREF: Boss_DestroyerMK2PlayFootstep+6   j
                move.w  #1,d0
                rts
; End of function Boss_DestroyerMK2PlayFootstep
; Main state dispatcher for boss component
Boss_DestroyerMK2ComponentStateDispatch:                ; DATA XREF: ROM:off_5DC   o  ; was: sub_4B490
                move.w  4(a5),d0
                lea     off_4B49C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2ComponentStateDispatch
; ---------------------------------------------------------------------------
off_4B49C:      dc.w    nullsub_105-*                   ; DATA XREF: Boss_DestroyerMK2ComponentStateDispatch+4   o
                dc.w    Boss_DestroyerMK2ComponentCheckDefeat-*
                dc.w    Boss_DestroyerMK2ComponentInitProjectile-*
                dc.w    Boss_DestroyerMK2ComponentSpawnProjectile-*
                dc.w    Boss_DestroyerMK2ComponentInitMovement-*
                dc.w    Boss_DestroyerMK2ComponentUpdateMovement-*
                dc.w    Boss_DestroyerMK2ComponentSwitchAnimation-*
                dc.w    Enemy_DecrementTimerAndAdvanceState-*
                dc.w    Enemy_CheckScrollFlagAndDispatch-*
                dc.w    Enemy_ResetStateOnScrollCheck-*

nullsub_105:                                            ; DATA XREF: ROM:off_4B49C   o
                rts
; End of function nullsub_105

; Checks if component is defeated
Boss_DestroyerMK2ComponentCheckDefeat:                  ; DATA XREF: ROM:0004B49E   o  ; was: sub_4B4B2
                tst.w   (word_FFF720).w
                bmi.w   nullsub_108
                move.w  $4E(a5),d0
                movea.w word_4B51C(pc,d0.w),a0
                tst.w   4(a0)
                bne.w   nullsub_108
                addq.w  #2,4(a5)
                ori.w   #$8000,2(a5)
                lea     off_4B4DC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2ComponentCheckDefeat
; ---------------------------------------------------------------------------
off_4B4DC:      dc.w    Boss_DestroyerMK2ScrollUpdate1-*  ; DATA XREF: Boss_DestroyerMK2ComponentCheckDefeat+22   o
                dc.w    Boss_DestroyerMK2ScrollUpdate2-*
                dc.w    Boss_DestroyerMK2ScrollUpdate3-*
                dc.w    Boss_DestroyerMK2ScrollUpdate4-*

; Updates stage 14 scroll position set 1
Boss_DestroyerMK2ScrollUpdate1:                         ; DATA XREF: ROM:off_4B4DC   o  ; was: sub_4B4E4
                move.l  #$44804001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Boss_DestroyerMK2ScrollUpdate1
; Updates stage 14 scroll position set 2
Boss_DestroyerMK2ScrollUpdate2:                         ; DATA XREF: ROM:0004B4DE   o  ; was: sub_4B4F2
                move.l  #$44984001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Boss_DestroyerMK2ScrollUpdate2
; Updates stage 14 scroll position set 3
Boss_DestroyerMK2ScrollUpdate3:                         ; DATA XREF: ROM:0004B4E0   o  ; was: sub_4B500
                move.l  #$4C804001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Boss_DestroyerMK2ScrollUpdate3
; Updates stage 14 scroll position set 4
Boss_DestroyerMK2ScrollUpdate4:                         ; DATA XREF: ROM:0004B4E2   o  ; was: sub_4B50E
                move.l  #$4C984001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Boss_DestroyerMK2ScrollUpdate4
; ---------------------------------------------------------------------------
word_4B51C:     dc.w    $C800, $C7A0, $C8C0, $C860
                                        ; DATA XREF: Boss_DestroyerMK2ComponentCheckDefeat+C   r

; Initializes component for projectile spawning
Boss_DestroyerMK2ComponentInitProjectile:               ; DATA XREF: ROM:0004B4A0   o  ; was: sub_4B524
                tst.w   (word_FFF720).w
                bmi.w   nullsub_108
                move.l  #word_EC2B6,8(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2ComponentInitProjectile
; Spawns projectile from component with offset
Boss_DestroyerMK2ComponentSpawnProjectile:              ; DATA XREF: ROM:0004B4A2   o  ; was: sub_4B540
                subq.w  #1,$48(a5)
                bpl.w   locret_4B5DC
                addq.w  #2,4(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   locret_4B5DC
                move.w  #$248,(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.b  #$10,$23(a0)
                move.l  #$FC04D42C,$2C(a0)
                move.w  #$100,$26(a0)
                move.w  #$CD00,2(a0)
                move.l  #word_EC292,8(a0)
                move.w  #$4300,$E(a0)
                move.b  $20(a5),$20(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  $4E(a5),d0
                move.w  word_4B5DE(pc,d0.w),d1
                add.w   d1,$10(a0)
                move.w  word_4B5E6(pc,d0.w),d1
                add.w   d1,$14(a0)
                move.w  word_4B5EE(pc,d0.w),$4C(a0)
                add.w   d0,d0
                move.l  dword_4B5F6(pc,d0.w),$50(a0)
                tst.w   (word_FFFF0E).w
                beq.s   loc_4B5D0
                move.w  #$C,$48(a5)
                move.w  #$C,$48(a0)
                rts
; ---------------------------------------------------------------------------
loc_4B5D0:                                              ; CODE XREF: Boss_DestroyerMK2ComponentSpawnProjectile+80   j
                move.w  #$18,$48(a5)
                move.w  #$18,$48(a0)
locret_4B5DC:                                           ; CODE XREF: Boss_DestroyerMK2ComponentSpawnProjectile+4   j
                                        ; Boss_DestroyerMK2ComponentSpawnProjectile+12   j
                rts
; End of function Boss_DestroyerMK2ComponentSpawnProjectile
; ---------------------------------------------------------------------------
word_4B5DE:     dc.w    $18, $FFE8                      ; DATA XREF: Boss_DestroyerMK2ComponentSpawnProjectile+5E   r
                dc.w    $18, $FFE8
word_4B5E6:     dc.w    1, 1                            ; DATA XREF: Boss_DestroyerMK2ComponentSpawnProjectile+66   r
                dc.w    $FFFF, $FFFF
word_4B5EE:     dc.w    $FFFF, 1                        ; DATA XREF: Boss_DestroyerMK2ComponentSpawnProjectile+6E   r
                dc.w    $FFFF, 1
dword_4B5F6:    dc.l    $FFFFE000, $2000                ; DATA XREF: Boss_DestroyerMK2ComponentSpawnProjectile+76   r
                dc.l    $FFFFE000, $2000

; Initializes component movement vectors
Boss_DestroyerMK2ComponentInitMovement:                 ; DATA XREF: ROM:0004B4A4   o  ; was: sub_4B606
                subq.w  #1,$48(a5)
                bne.s   locret_4B630
                move.w  $4E(a5),d0
                clr.l   $58(a5)
                add.w   d0,d0
                move.l  dword_4B632(pc,d0.w),$50(a5)
                move.l  dword_4B642(pc,d0.w),$54(a5)
                addq.w  #2,4(a5)
                move.b  #$E7,d0
                jsr     (Sound_PlaySFX).l
locret_4B630:                                           ; CODE XREF: Boss_DestroyerMK2ComponentInitMovement+4   j
                rts
; End of function Boss_DestroyerMK2ComponentInitMovement
; ---------------------------------------------------------------------------
dword_4B632:    dc.l    $20000, $FFFE0000               ; DATA XREF: Boss_DestroyerMK2ComponentInitMovement+10   r
                dc.l    $20000, $FFFE0000
dword_4B642:    dc.l    $FFFFE000, $2000                ; DATA XREF: Boss_DestroyerMK2ComponentInitMovement+16   r
                dc.l    $FFFFE000, $2000

; Updates component physics and scroll layers
Boss_DestroyerMK2ComponentUpdateMovement:               ; DATA XREF: ROM:0004B4A6   o  ; was: sub_4B652
                move.l  $54(a5),d0
                add.l   d0,$50(a5)
                move.l  $50(a5),d0
                add.l   d0,$58(a5)
                move.w  $58(a5),d0
                cmpi.w  #4,$4E(a5)
                bcc.s   loc_4B674
                lea     (word_FFE52C).w,a0
                bra.s   loc_4B678
; ---------------------------------------------------------------------------
loc_4B674:                                              ; CODE XREF: Boss_DestroyerMK2ComponentUpdateMovement+1A   j
                lea     (word_FFE720).w,a0
loc_4B678:                                              ; CODE XREF: Boss_DestroyerMK2ComponentUpdateMovement+20   j
                bsr.s   Gfx_UpdateMultipleScrollLayers
                tst.l   $58(a5)
                bne.s   locret_4B68A
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
locret_4B68A:                                           ; CODE XREF: Boss_DestroyerMK2ComponentUpdateMovement+2C   j
                rts
; End of function Boss_DestroyerMK2ComponentUpdateMovement
; Updates 7 consecutive scroll layer values
Gfx_UpdateMultipleScrollLayers:                         ; CODE XREF: Boss_DestroyerMK2ComponentUpdateMovement:loc_4B678   p  ; was: sub_4B68C
                add.w   (word_FFE6E0).w,d0
                move.w  #6,d7
loc_4B694:                                              ; CODE XREF: Gfx_UpdateMultipleScrollLayers+1A   j
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                lea     $10(a0),a0
                dbf     d7,loc_4B694
                rts
; End of function Gfx_UpdateMultipleScrollLayers
; Changes component animation after delay
Boss_DestroyerMK2ComponentSwitchAnimation:              ; DATA XREF: ROM:0004B4A8   o  ; was: sub_4B6AC
                subq.w  #1,$48(a5)
                bne.s   locret_4B6C4
                move.l  #word_EC2AA,8(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_4B6C4:                                           ; CODE XREF: Boss_DestroyerMK2ComponentSwitchAnimation+4   j
                rts
; End of function Boss_DestroyerMK2ComponentSwitchAnimation
; Decrements timer and advances state when expired
Enemy_DecrementTimerAndAdvanceState:                    ; DATA XREF: ROM:0004B4AA   o  ; was: sub_4B6C6
                subq.w  #1,$48(a5)
                bne.s   locret_4B6D0
                addq.w  #2,4(a5)
locret_4B6D0:                                           ; CODE XREF: Enemy_DecrementTimerAndAdvanceState+4   j
                rts
; End of function Enemy_DecrementTimerAndAdvanceState
; Checks scroll flag and dispatches to handler
Enemy_CheckScrollFlagAndDispatch:                       ; DATA XREF: ROM:0004B4AC   o  ; was: sub_4B6D2
                tst.w   (word_FFF720).w
                bmi.w   nullsub_108
                addq.w  #2,4(a5)
                andi.w  #$7FFF,2(a5)
                move.w  $4E(a5),d0
                lea     off_4B6F0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_CheckScrollFlagAndDispatch
; ---------------------------------------------------------------------------
off_4B6F0:      dc.w    Gfx_UpdateStage14ScrollType1-*  ; DATA XREF: Enemy_CheckScrollFlagAndDispatch+16   o
                dc.w    Gfx_UpdateStage14ScrollType2-*
                dc.w    Gfx_UpdateStage14ScrollType3-*
                dc.w    Gfx_UpdateStage14ScrollType4-*

; Updates stage 14 scrolling type 1
Gfx_UpdateStage14ScrollType1:                           ; DATA XREF: ROM:off_4B6F0   o  ; was: sub_4B6F8
                move.l  #$448032C1,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Gfx_UpdateStage14ScrollType1
; Updates stage 14 scrolling type 2
Gfx_UpdateStage14ScrollType2:                           ; DATA XREF: ROM:0004B6F2   o  ; was: sub_4B706
                move.l  #$449832A1,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Gfx_UpdateStage14ScrollType2
; Updates stage 14 scrolling type 3
Gfx_UpdateStage14ScrollType3:                           ; DATA XREF: ROM:0004B6F4   o  ; was: sub_4B714
                move.l  #$4C8031C1,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Gfx_UpdateStage14ScrollType3
; Updates stage 14 scrolling type 4
Gfx_UpdateStage14ScrollType4:                           ; DATA XREF: ROM:0004B6F6   o  ; was: sub_4B722
                move.l  #$4C9831A1,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Gfx_UpdateStage14ScrollType4
; Resets state when scroll flag is valid
Enemy_ResetStateOnScrollCheck:                          ; DATA XREF: ROM:0004B4AE   o  ; was: sub_4B730
                tst.w   (word_FFF720).w
                bmi.s   locret_4B73A
                clr.w   4(a5)
locret_4B73A:                                           ; CODE XREF: Enemy_ResetStateOnScrollCheck+4   j
                rts
; End of function Enemy_ResetStateOnScrollCheck
; Plays roar sound
Boss_DestroyerMK2PlayRoar:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4B73C
                move.w  $46(a5),d0
                lea     off_4B748(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2PlayRoar
; ---------------------------------------------------------------------------
off_4B748:      dc.w    Boss_DestroyerMK2PlayJump-*     ; DATA XREF: Boss_DestroyerMK2PlayRoar+4   o
                dc.w    Enemy_HandleWallCollisionDispatch-*
                dc.w    Enemy_HandleWallBounceWithFlag-*

; Plays jump sound
Boss_DestroyerMK2PlayJump:                              ; DATA XREF: ROM:off_4B748   o  ; was: sub_4B74E
                move.w  4(a5),d0
                lea     off_4B75A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2PlayJump
; ---------------------------------------------------------------------------
off_4B75A:      dc.w    Boss_DestroyerMK2PlayLand-*     ; DATA XREF: Boss_DestroyerMK2PlayJump+4   o
                dc.w    Boss_DestroyerMK2DefeatShake-*
                dc.w    nullsub_106-*

; Plays landing sound
Boss_DestroyerMK2PlayLand:                              ; DATA XREF: ROM:off_4B75A   o  ; was: sub_4B760
                cmpi.w  #$2A,(word_FFC624).w            ; '*'
                bcc.s   loc_4B76E
                tst.w   $24(a5)
                bpl.s   locret_4B79E
loc_4B76E:                                              ; CODE XREF: Boss_DestroyerMK2PlayLand+6   j
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                subq.w  #1,(dword_FF9410).w
                addq.w  #2,4(a5)
                move.w  #$FFFC,$1C(a5)
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bmi.s   loc_4B798
                move.w  #$FFFE,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_4B798:                                              ; CODE XREF: Boss_DestroyerMK2PlayLand+2E   j
                move.w  #2,$18(a5)
locret_4B79E:                                           ; CODE XREF: Boss_DestroyerMK2PlayLand+C   j
                rts
; End of function Boss_DestroyerMK2PlayLand
; Screen shake during defeat
Boss_DestroyerMK2DefeatShake:                           ; DATA XREF: ROM:0004B75C   o  ; was: sub_4B7A0
                addi.l  #$4000,$1C(a5)
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1C0,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                ori.w   #$8000,$E(a5)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_4B7FC
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_4B7FC
                move.l  #off_E95DC,8(a0)
                move.b  $20(a5),$20(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                jsr     (Projectile_InitType88).l
                subq.b  #4,$20(a0)
                ori.w   #$8000,$E(a0)
loc_4B7FC:                                              ; CODE XREF: Boss_DestroyerMK2DefeatShake+28   j
                                        ; Boss_DestroyerMK2DefeatShake+30   j
                cmpi.w  #$180,$14(a5)
                bcs.s   locret_4B80A
                move.w  #$1000,2(a5)
locret_4B80A:                                           ; CODE XREF: Boss_DestroyerMK2DefeatShake+62   j
                rts
; End of function Boss_DestroyerMK2DefeatShake
nullsub_106:                                            ; DATA XREF: ROM:0004B75E   o
                rts
; End of function nullsub_106

; Handles wall collision and dispatches
Enemy_HandleWallCollisionDispatch:                      ; DATA XREF: ROM:0004B74A   o  ; was: sub_4B80E
                cmpi.w  #8,4(a5)
                bcc.s   loc_4B83C
                bclr    #7,$22(a5)
                beq.s   loc_4B83C
                bclr    #4,$22(a5)
                beq.s   loc_4B82E
                move.l  #$FFFC0000,$1C(a5)
loc_4B82E:                                              ; CODE XREF: Enemy_HandleWallCollisionDispatch+16   j
                neg.l   $18(a5)
                clr.b   $21(a5)
                move.w  #8,4(a5)
loc_4B83C:                                              ; CODE XREF: Enemy_HandleWallCollisionDispatch+6   j
                                        ; Enemy_HandleWallCollisionDispatch+E   j
                move.w  4(a5),d0
                lea     off_4B848(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_HandleWallCollisionDispatch
; ---------------------------------------------------------------------------
off_4B848:      dc.w    Enemy_InitHorizontalMovement-*  ; DATA XREF: Enemy_HandleWallCollisionDispatch+32   o
                dc.w    Enemy_StopMovementAfterTimer-*
                dc.w    Enemy_RotateAndMoveWithAccel-*
                dc.w    Enemy_RotateUntilYThreshold-*
                dc.w    Enemy_RotateWithGravityUntilY-*

; Initializes horizontal movement with timer
Enemy_InitHorizontalMovement:                           ; DATA XREF: ROM:off_4B848   o  ; was: sub_4B852
                addq.w  #2,4(a5)
                move.w  #$14,$48(a5)
                move.w  #4,$18(a5)
                btst    #0,$45(a5)
                bne.s   loc_4B872
                move.w  #$FFFF,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_4B872:                                              ; CODE XREF: Enemy_InitHorizontalMovement+16   j
                move.w  #1,$1C(a5)
                rts
; End of function Enemy_InitHorizontalMovement
; Stops movement after timer expires
Enemy_StopMovementAfterTimer:                           ; DATA XREF: ROM:0004B84A   o  ; was: sub_4B87A
                subq.w  #1,$48(a5)
                bne.s   locret_4B892
                clr.w   $18(a5)
                clr.w   $1C(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4B892:                                           ; CODE XREF: Enemy_StopMovementAfterTimer+4   j
                rts
; End of function Enemy_StopMovementAfterTimer
; Rotates and moves with acceleration
Enemy_RotateAndMoveWithAccel:                           ; DATA XREF: ROM:0004B84C   o  ; was: sub_4B894
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                subq.w  #1,$48(a5)
                bne.s   locret_4B8B6
                move.w  #2,$18(a5)
                addq.w  #2,4(a5)
locret_4B8B6:                                           ; CODE XREF: Enemy_RotateAndMoveWithAccel+16   j
                rts
; End of function Enemy_RotateAndMoveWithAccel
; Rotates until Y position reaches threshold
Enemy_RotateUntilYThreshold:                            ; DATA XREF: ROM:0004B84E   o  ; was: sub_4B8B8
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                cmpi.w  #$1E0,$10(a5)
                bcs.s   locret_4B8D8
                move.w  #$1000,2(a5)
locret_4B8D8:                                           ; CODE XREF: Enemy_RotateUntilYThreshold+18   j
                rts
; End of function Enemy_RotateUntilYThreshold
; Rotates with gravity until Y position reached
Enemy_RotateWithGravityUntilY:                          ; DATA XREF: ROM:0004B850   o  ; was: sub_4B8DA
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                addi.l  #$4000,$1C(a5)
                cmpi.w  #$180,$14(a5)
                blt.s   locret_4B902
                move.w  #$1000,2(a5)
locret_4B902:                                           ; CODE XREF: Enemy_RotateWithGravityUntilY+20   j
                rts
; End of function Enemy_RotateWithGravityUntilY
; Handles wall bounce with special flag check
Enemy_HandleWallBounceWithFlag:                         ; DATA XREF: ROM:0004B74C   o  ; was: sub_4B904
                cmpi.w  #8,4(a5)
                bcc.s   loc_4B946
                tst.w   (dword_FF941C+2).w
                beq.s   loc_4B91A
                move.w  $44(a5),$1C(a5)
                bra.s   loc_4B932
; ---------------------------------------------------------------------------
loc_4B91A:                                              ; CODE XREF: Enemy_HandleWallBounceWithFlag+C   j
                bclr    #7,$22(a5)
                beq.s   loc_4B946
                bclr    #4,$22(a5)
                beq.s   loc_4B932
                move.l  #$FFFC0000,$1C(a5)
loc_4B932:                                              ; CODE XREF: Enemy_HandleWallBounceWithFlag+14   j
                                        ; Enemy_HandleWallBounceWithFlag+24   j
                move.w  #1,(dword_FF941C+2).w
                neg.l   $18(a5)
                clr.b   $21(a5)
                move.w  #8,4(a5)
loc_4B946:                                              ; CODE XREF: Enemy_HandleWallBounceWithFlag+6   j
                                        ; Enemy_HandleWallBounceWithFlag+1C   j
                move.w  4(a5),d0
                lea     off_4B952(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_HandleWallBounceWithFlag
; ---------------------------------------------------------------------------
off_4B952:      dc.w    Enemy_InitMovementState-*       ; DATA XREF: Enemy_HandleWallBounceWithFlag+46   o
                dc.w    Enemy_WaitTimerThenStop-*
                dc.w    Enemy_RotateAndMoveVertical-*
                dc.w    Enemy_RotateUntilYBound-*
                dc.w    Enemy_RotateWithGravityFall-*

; Initializes movement state with timer
Enemy_InitMovementState:                                ; DATA XREF: ROM:off_4B952   o  ; was: sub_4B95C
                addq.w  #2,4(a5)
                move.w  #$14,$48(a5)
                move.w  #4,$18(a5)
                rts
; End of function Enemy_InitMovementState
; Waits for timer then clears speed
Enemy_WaitTimerThenStop:                                ; DATA XREF: ROM:0004B954   o  ; was: sub_4B96E
                subq.w  #1,$48(a5)
                bne.s   locret_4B982
                clr.w   $18(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4B982:                                           ; CODE XREF: Enemy_WaitTimerThenStop+4   j
                rts
; End of function Enemy_WaitTimerThenStop
; Rotates and moves vertically until timer
Enemy_RotateAndMoveVertical:                            ; DATA XREF: ROM:0004B956   o  ; was: sub_4B984
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                move.w  $44(a5),d0
                add.w   d0,$14(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_4B9AE
                move.w  #2,$18(a5)
                addq.w  #2,4(a5)
locret_4B9AE:                                           ; CODE XREF: Enemy_RotateAndMoveVertical+1E   j
                rts
; End of function Enemy_RotateAndMoveVertical
; Rotates until Y position exceeds boundary
Enemy_RotateUntilYBound:                                ; DATA XREF: ROM:0004B958   o  ; was: sub_4B9B0
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                cmpi.w  #$1E0,$10(a5)
                bcs.s   locret_4B9D0
                move.w  #$1000,2(a5)
locret_4B9D0:                                           ; CODE XREF: Enemy_RotateUntilYBound+18   j
                rts
; End of function Enemy_RotateUntilYBound
; Rotates with gravity until falling threshold
Enemy_RotateWithGravityFall:                            ; DATA XREF: ROM:0004B95A   o  ; was: sub_4B9D2
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                addi.l  #$4000,$1C(a5)
                cmpi.w  #$180,$14(a5)
                blt.s   locret_4B9FA
                move.w  #$1000,2(a5)
locret_4B9FA:                                           ; CODE XREF: Enemy_RotateWithGravityFall+20   j
                rts
; End of function Enemy_RotateWithGravityFall
; Checks X position bounds before dispatching
Enemy_CheckBoundsAndDispatch:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_4B9FC
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                cmpi.w  #$C10,d0
                bcs.s   Boss_DestroyerMK2SetEntityFlag
                cmpi.w  #$E70,d0
                bhi.s   Boss_DestroyerMK2SetEntityFlag
                move.w  4(a5),d0
                lea     off_4BA1C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_CheckBoundsAndDispatch
; ---------------------------------------------------------------------------
off_4BA1C:      dc.w    Enemy_FlickerAndPrepareMove-*   ; DATA XREF: Enemy_CheckBoundsAndDispatch+18   o
                dc.w    Enemy_AccelerateHorizontally-*

; Toggles visibility then sets movement speed
Enemy_FlickerAndPrepareMove:                            ; DATA XREF: ROM:off_4BA1C   o  ; was: sub_4BA20
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_4BA3C
                ori.w   #$8000,2(a5)
                move.w  $4C(a5),$18(a5)
                addq.w  #2,4(a5)
locret_4BA3C:                                           ; CODE XREF: Enemy_FlickerAndPrepareMove+A   j
                rts
; End of function Enemy_FlickerAndPrepareMove
; Applies continuous horizontal acceleration
Enemy_AccelerateHorizontally:                           ; DATA XREF: ROM:0004BA1E   o  ; was: sub_4BA3E
                move.l  $50(a5),d0
                add.l   d0,$18(a5)
                rts
; End of function Enemy_AccelerateHorizontally
; Sets bit 4 in entity flags
Boss_DestroyerMK2SetEntityFlag:                         ; CODE XREF: Enemy_CheckBoundsAndDispatch+C   j  ; was: sub_4BA48
                                        ; Enemy_CheckBoundsAndDispatch+12   j
                bset    #4,2(a5)
                rts
; End of function Boss_DestroyerMK2SetEntityFlag
; Flash effect during defeat
Boss_DestroyerMK2DefeatFlash:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_4BA50
                move.w  4(a5),d0
                lea     off_4BA5C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2DefeatFlash
; ---------------------------------------------------------------------------
off_4BA5C:      dc.w    nullsub_107-*                   ; DATA XREF: Boss_DestroyerMK2DefeatFlash+4   o
                dc.w    Boss_DestroyerMK2DefeatBreakup-*
                dc.w    Effect_DestroyerMK2Spark-*
                dc.w    Effect_DestroyerMK2Debris-*

nullsub_107:                                            ; DATA XREF: ROM:off_4BA5C   o
                rts
; End of function nullsub_107

; Boss breaking up
Boss_DestroyerMK2DefeatBreakup:                         ; DATA XREF: ROM:0004BA5E   o  ; was: sub_4BA66
                addq.w  #2,4(a5)
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bmi.s   loc_4BA7E
                move.w  #$30,d1                         ; '0'
                move.w  #4,d2
                bra.s   loc_4BA86
; ---------------------------------------------------------------------------
loc_4BA7E:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+C   j
                move.w  #$FFD0,d1
                move.w  #$FFFC,d2
loc_4BA86:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+16   j
                sub.w   d1,d0
                bpl.s   loc_4BA8C
                neg.w   d0
loc_4BA8C:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+22   j
                lsr.w   #2,d0
                cmpi.w  #$110,(dword_FFA414).w
                bcs.s   loc_4BA9C
                move.w  #4,d3
                bra.s   loc_4BAA0
; ---------------------------------------------------------------------------
loc_4BA9C:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+2E   j
                move.w  #$FFFC,d3
loc_4BAA0:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+34   j
                movea.w #(byte_FFCC20-M68K_RAM),a0
                move.w  #7,d7
                clr.w   d6
loc_4BAAA:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+9A   j
                move.w  #$260,(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FF02FF02,$2C(a0)
                move.w  #$80,$26(a0)
                move.w  #$6D00,2(a0)
                move.l  #off_E9680,8(a0)
                move.w  #$8480,$E(a0)
                clr.w   $C(a0)
                move.l  $10(a5),$10(a0)
                add.w   d1,$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  d6,$48(a0)
                move.w  d0,$4A(a0)
                move.w  d2,$4C(a0)
                move.w  d3,$50(a0)
                addq.w  #4,d6
                lea     $60(a0),a0
                dbf     d7,loc_4BAAA
                move.w  #8,$52(a5)
                rts
; End of function Boss_DestroyerMK2DefeatBreakup
; Spark effect
Effect_DestroyerMK2Spark:                               ; DATA XREF: ROM:0004BA60   o  ; was: sub_4BB0C
                tst.w   $52(a5)
                bne.s   locret_4BB1C
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_4BB1C:                                           ; CODE XREF: Effect_DestroyerMK2Spark+4   j
                rts
; End of function Effect_DestroyerMK2Spark
; Debris effect
Effect_DestroyerMK2Debris:                              ; DATA XREF: ROM:0004BA62   o  ; was: sub_4BB1E
                subq.w  #1,$48(a5)
                bne.s   locret_4BB28
                clr.w   4(a5)
locret_4BB28:                                           ; CODE XREF: Effect_DestroyerMK2Debris+4   j
                rts
; End of function Effect_DestroyerMK2Debris
; Spawns defeat debris
Boss_DestroyerMK2DefeatDebris:                          ; DATA XREF: ROM:off_5DC   o  ; was: sub_4BB2A
                move.w  4(a5),d0
                lea     off_4BB36(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2DefeatDebris
; ---------------------------------------------------------------------------
off_4BB36:      dc.w    Boss_DestroyerMK2DefeatSparks-*  ; DATA XREF: Boss_DestroyerMK2DefeatDebris+4   o
                dc.w    Boss_DestroyerMK2DefeatSmoke-*
                dc.w    Boss_DestroyerMK2DefeatCleanup-*
                dc.w    Effect_DestroyerMK2Smoke-*

; Spawns defeat sparks
Boss_DestroyerMK2DefeatSparks:                          ; DATA XREF: ROM:off_4BB36   o  ; was: sub_4BB3E
                subq.w  #1,$48(a5)
                bpl.s   locret_4BB54
                move.w  #$10,$48(a5)
                ori.w   #$8000,2(a5)
                addq.w  #2,4(a5)
locret_4BB54:                                           ; CODE XREF: Boss_DestroyerMK2DefeatSparks+4   j
                rts
; End of function Boss_DestroyerMK2DefeatSparks
; Spawns defeat smoke
Boss_DestroyerMK2DefeatSmoke:                           ; DATA XREF: ROM:0004BB38   o  ; was: sub_4BB56
                subq.w  #1,$48(a5)
                bpl.s   locret_4BB70
                move.l  $4C(a5),$18(a5)
                addq.w  #2,4(a5)
                move.b  #$E8,d0
                jsr     (Sound_PlaySFX).l
locret_4BB70:                                           ; CODE XREF: Boss_DestroyerMK2DefeatSmoke+4   j
                rts
; End of function Boss_DestroyerMK2DefeatSmoke
; Cleanup after defeat
Boss_DestroyerMK2DefeatCleanup:                         ; DATA XREF: ROM:0004BB3A   o  ; was: sub_4BB72
                subq.w  #1,$4A(a5)
                bpl.s   locret_4BB86
                clr.w   $18(a5)
                move.l  $50(a5),$1C(a5)
                addq.w  #2,4(a5)
locret_4BB86:                                           ; CODE XREF: Boss_DestroyerMK2DefeatCleanup+4   j
                rts
; End of function Boss_DestroyerMK2DefeatCleanup
; Smoke effect
Effect_DestroyerMK2Smoke:                               ; DATA XREF: ROM:0004BB3C   o  ; was: sub_4BB88
                cmpi.w  #$180,$14(a5)
                bcc.s   loc_4BBA8
                cmpi.w  #$80,$14(a5)
                bls.s   loc_4BBA8
                moveq   #0,d0
                move.w  d0,d1
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                bne.s   loc_4BBB4
                rts
; ---------------------------------------------------------------------------
loc_4BBA8:                                              ; CODE XREF: Effect_DestroyerMK2Smoke+6   j
                                        ; Effect_DestroyerMK2Smoke+E   j
                subq.w  #1,(word_FFC792).w
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_4BBB4:                                              ; CODE XREF: Effect_DestroyerMK2Smoke+1C   j
                move.w  #$BC,d0
                jsr     (Sound_PlaySFX).l
                subq.w  #1,(word_FFC792).w
                clr.b   $21(a5)
                move.l  #off_E95DC,8(a5)
                jsr     (Enemy_GetEntityAddress).l
                move.w  $1C(a5),d0
                neg.w   d0
                asr.w   #1,d0
                move.w  d0,$1C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                move.w  d0,$18(a5)
                rts
; End of function Effect_DestroyerMK2Smoke
; Shooting pattern 2
Boss_DestroyerMK2ShootPattern2:                         ; CODE XREF: Boss_DestroyerMK2Main+5C   p  ; was: sub_4BBF0
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_4BC1A
                move.w  (dword_FF9418).w,d0
                move.w  word_4BC1C(pc,d0.w),(word_FFE366).w
                move.w  word_4BC30(pc,d0.w),(word_FFE368).w
                addq.w  #2,(dword_FF9418).w
                cmpi.w  #$14,(dword_FF9418).w
                bne.s   locret_4BC1A
                clr.w   (dword_FF9418).w
locret_4BC1A:                                           ; CODE XREF: Boss_DestroyerMK2ShootPattern2+8   j
                                        ; Boss_DestroyerMK2ShootPattern2+24   j
                rts
; End of function Boss_DestroyerMK2ShootPattern2
; ---------------------------------------------------------------------------
word_4BC1C:     dc.w    $2C8, $A6, $84, $62, $40, $20, $40, $62, $84, $A6
                                        ; DATA XREF: Boss_DestroyerMK2ShootPattern2+E   r
word_4BC30:     dc.w    $64, $44, $42, $22, $20, 0, $20, $22, $42, $44
                                        ; DATA XREF: Boss_DestroyerMK2ShootPattern2+14   r

; Shooting pattern 3
Boss_DestroyerMK2ShootPattern3:                         ; CODE XREF: Boss_DestroyerMK2AttackState2+C   p  ; was: sub_4BC44
                                        ; sub_4ABC6   p
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  $4C(a0),d0
                add.w   d0,$14(a0)
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  $4C(a0),d0
                add.w   d0,$14(a0)
                movea.w #(word_FFC740-M68K_RAM),a0
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  #3,d7
                movea.w #(word_FFC7A0-M68K_RAM),a0
loc_4BC8C:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+7E   j
                cmpi.w  #4,$4E(a0)
                bcc.s   loc_4BC9A
                lea     (word_FFE52C).w,a1
                bra.s   loc_4BC9E
; ---------------------------------------------------------------------------
loc_4BC9A:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+4E   j
                lea     (word_FFE720).w,a1
loc_4BC9E:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+54   j
                move.w  (a1),d0
                addi.w  #$C0,d0
                add.w   $4A(a0),d0
                add.w   $58(a0),d0
                move.w  d0,$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  $4C(a0),d0
                add.w   d0,$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4BC8C
                move.l  (dword_FF940C).w,d0
                add.l   d0,(dword_FF9408).w
                andi.w  #$1FF,(dword_FF9408).w
                clr.w   d3
                move.b  $20(a5),d3
                movea.w #(word_FFC920-M68K_RAM),a0
                move.w  (dword_FF9404).w,d5
                move.w  (dword_FF9408).w,d6
                lea     (word_1B514).l,a1
                move.w  #7,d7
loc_4BCF0:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+106   j
                tst.w   4(a0)
                bne.w   loc_4BD46
                move.w  $4C(a0),d0
                add.w   d6,d0
                andi.w  #$1FE,d0
                move.w  (a1,d0.w),d1
                move.w  $4A(a0),d2
                add.w   d5,d2
                muls.w  d2,d1
                add.l   $10(a5),d1
                move.l  d1,$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  d0,d2
                bsr.w   Boss_DestroyerMK2PlayIntroSFX
                move.w  -$80(a1,d0.w),d1
                muls.w  #$40,d1                         ; '@'
                swap    d1
                neg.w   d1
                tst.w   d1
                bpl.s   loc_4BD3A
                ori.w   #$8000,$E(a0)
                bra.s   loc_4BD40
; ---------------------------------------------------------------------------
loc_4BD3A:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+EC   j
                andi.w  #$7FFF,$E(a0)
loc_4BD40:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+F4   j
                add.w   d3,d1
                move.b  d1,$20(a0)
loc_4BD46:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+B0   j
                lea     $60(a0),a0
                dbf     d7,loc_4BCF0
                rts
; End of function Boss_DestroyerMK2ShootPattern3
; Copies entity address from a5 to a0
