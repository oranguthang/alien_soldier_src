Input_ReadSecondaryController:                               ; CODE XREF: Sound_AcquireZ80Bus+E   p  ; was: sub_33FA
                lea     ((word_FFF706+1)).w,a1
                lea     ((IO_CT2_DATA+1)).l,a2
                lea     (byte_FFFF21).w,a3
                bsr.w Input_ReadControllerPort
                move.b  d0,(byte_FFFF07).w
                cmpi.b  #$D,d0
                beq.w   loc_3424
loc_3418:                               ; CODE XREF: Input_ReadController+1E   j
                clr.b   (a1)
                clr.b   2(a1)
                clr.b   4(a1)
                rts
; ---------------------------------------------------------------------------
loc_3424:                               ; CODE XREF: Input_ReadController+1A   j
                                        ; Input_ReadSecondaryController+1A   j
                move.b  #0,(a2)
                nop
                nop
                move.b  (a2),d0
                add.b   d0,d0
                add.b   d0,d0
                andi.b  #$C0,d0
                move.b  #$40,(a2) ; '@'
                nop
                nop
                move.b  (a2),d1
                andi.b  #$3F,d1 ; '?'
                or.b    d1,d0
                not.b   d0
                bsr.w Input_MapSecondaryButtons
                move.b  (a1),d1
                move.b  d1,d2
                eor.b   d0,d2
                move.b  d0,(a1)
                and.b   d2,d1
                move.b  d1,4(a1)
                and.b   d2,d0
                move.b  d0,2(a1)
                rts
; End of function Input_ReadSecondaryController
; Maps secondary controller button bits to standard input format
Input_MapSecondaryButtons:                               ; CODE XREF: Input_ReadSecondaryController+4E   p  ; was: sub_3462
                btst    #6,(byte_FFF705).w
                beq.w   locret_3498
                move.b  d0,d1
                move.b  #6,d2
                move.b  (a3),d3
                bsr.w Input_TestAndSetBit
                move.b  #4,d2
                move.b  2(a3),d3
                bsr.w Input_TestAndSetBit
                move.b  #5,d2
                move.b  4(a3),d3
; End of function Input_MapSecondaryButtons
; Tests input bit and sets or clears corresponding output bit
Input_TestAndSetBit:                               ; CODE XREF: Input_MapSecondaryButtons+12   p  ; was: sub_348C
                                        ; Input_MapSecondaryButtons+1E   p
                btst    d3,d1
                beq.w   loc_3496
                bset    d2,d0
                rts
; ---------------------------------------------------------------------------
loc_3496:                               ; CODE XREF: Input_TestAndSetBit+2   j
                bclr    d2,d0
locret_3498:                            ; CODE XREF: Input_MapSecondaryButtons+6   j
                rts
; End of function Input_TestAndSetBit
; Low-level controller port bit reading
Input_ReadControllerPort:                               ; CODE XREF: Input_ReadController+E   p  ; was: sub_349A
                                        ; Input_ReadSecondaryController+E   p
                move.b  #$40,(a2) ; '@'
                nop
                nop
                move.b  (a2),d0
                move.b  d0,d1
                lsl.b   #1,d1
                or.b    d1,d0
                move.b  d0,d1
                andi.b  #8,d0
                lsl.b   #1,d1
                andi.b  #4,d1
                move.b  #0,(a2)
                nop
                nop
                move.b  (a2),d2
                move.b  d2,d3
                lsr.b   #1,d3
                or.b    d3,d2
                move.b  d2,d3
                lsr.b   #1,d2
                andi.b  #2,d2
                andi.b  #1,d3
                or.b    d1,d0
                or.b    d2,d0
                or.b    d3,d0
                rts
; End of function Input_ReadControllerPort
; Waits for VBlank interrupt
Sys_WaitVBlank:                               ; CODE XREF: Cutscene_InitCreditsScreen+A0   p  ; was: sub_34DA
                                        ; Text_CompleteWithSound+14   p ...
                btst    #1,(word_FFFF38+1).w
                beq.s Input_ProcessButtons
                rts
; End of function Sys_WaitVBlank
; Plays sound effect with ID parameter
Sound_PlaySFX:                               ; CODE XREF: Gfx_AnimateLettersExpand+158   p  ; was: sub_34E4
                                        ; Gfx_AnimateLettersExpandLarge+10E   p ...
                btst    #2,(word_FFFF38+1).w
                beq.s Input_ProcessButtons
                rts
; End of function Sound_PlaySFX
; Processes joypad button state
Input_ProcessButtons:                               ; CODE XREF: RegionRestricted+E   p  ; was: sub_34EE
                                        ; Sys_VBlankEventHandler+1A   p ...
                tst.b   (dword_FFF80A).w
                bpl.w   loc_34FE
                cmp.b   (dword_FFF80A).w,d0
                bne.w   loc_3504
loc_34FE:                               ; CODE XREF: Input_ProcessButtons+4   j
                move.b  d0,(dword_FFF80A).w
                rts
; ---------------------------------------------------------------------------
loc_3504:                               ; CODE XREF: Input_ProcessButtons+C   j
                tst.b   (dword_FFF80A+1).w
                bpl.w   loc_3514
                cmp.b   (dword_FFF80A+1).w,d0
                bne.w   loc_351A
loc_3514:                               ; CODE XREF: Input_ProcessButtons+1A   j
                move.b  d0,(dword_FFF80A+1).w
                rts
; ---------------------------------------------------------------------------
loc_351A:                               ; CODE XREF: Input_ProcessButtons+22   j
                tst.b   (dword_FFF80A+2).w
                bpl.w   loc_352A
                cmp.b   (dword_FFF80A+2).w,d0
                bne.w   loc_3530
loc_352A:                               ; CODE XREF: Input_ProcessButtons+30   j
                move.b  d0,(dword_FFF80A+2).w
                rts
; ---------------------------------------------------------------------------
loc_3530:                               ; CODE XREF: Input_ProcessButtons+38   j
                tst.b   (dword_FFF80A+3).w
                bpl.w   loc_3540
                cmp.b   (dword_FFF80A+3).w,d0
                bne.w   loc_3546
loc_3540:                               ; CODE XREF: Input_ProcessButtons+46   j
                move.b  d0,(dword_FFF80A+3).w
                rts
; ---------------------------------------------------------------------------
loc_3546:                               ; CODE XREF: Input_ProcessButtons+4E   j
                clr.b   d0
                rts
; End of function Input_ProcessButtons
; Calculates angle from object to player center
Math_CalculateAngleToPlayer:                               ; CODE XREF: Math_CalculateAngleBetween+4   p  ; was: sub_354A
                                        ; sub_2BFD0   p ...
                move.w  (word_FF8248).w,d0
                move.w  (word_FF824A).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
loc_355A:                               ; CODE XREF: Boss_CaterpillarUpdateRotation+1E   p
                                        ; Boss_SnakeAI+1E   p ...
                bsr.s Math_Arctan2Lookup
                asr.w   #7,d2
                andi.w  #$1FE,d2
                rts
; End of function Math_CalculateAngleToPlayer
; Calculates angle between two entities using arctan lookup
Math_CalculateAngleBetween:                               ; CODE XREF: Enemy_InitDirectionalProjectile+44   p  ; was: sub_3564
                movea.w a5,a4
                movea.w a0,a5
                bsr.s Math_CalculateAngleToPlayer
                movea.w a5,a0
                movea.w a4,a5
                rts
; End of function Math_CalculateAngleBetween
; Wrapper for Math_Arctan2Lookup that preserves d0-d1/a0 registers
Math_Arctan2WithPreserve:
                movem.l d0-d1/a0,-(sp)  ; was: sub_3570
                jsr Math_Arctan2Lookup(pc)    ; (pc)
                nop
                movem.l (sp)+,d0-d1/a0
                rts
; End of function Math_Arctan2WithPreserve
; Arctangent2 function using lookup table
Math_Arctan2Lookup:                               ; CODE XREF: Math_CalculateAngleToPlayer:loc_355A   p  ; was: sub_3580
                                        ; Math_Arctan2WithPreserve+4   p ...
                lea     word_36A4(pc),a0
                nop
                tst.w   d0
                bmi.w   loc_3626
                bne.w   loc_35B0
                tst.w   d1
                bmi.w   loc_35A4
                bne.w   loc_359E
loc_359A:                               ; CODE XREF: Math_Arctan2Lookup+32   j
                clr.w   d2
                rts
; ---------------------------------------------------------------------------
loc_359E:                               ; CODE XREF: Math_Arctan2Lookup+16   j
                move.w  #$4000,d2
                rts
; ---------------------------------------------------------------------------
loc_35A4:                               ; CODE XREF: Math_Arctan2Lookup+12   j
                move.w  #$C000,d2
                rts
; ---------------------------------------------------------------------------
loc_35AA:                               ; CODE XREF: Math_Arctan2Lookup+AA   j
                move.w  #$8000,d2
                rts
; ---------------------------------------------------------------------------
loc_35B0:                               ; CODE XREF: Math_Arctan2Lookup+C   j
                tst.w   d1
                beq.s   loc_359A
                bmi.w   loc_35EE
                cmp.w   d0,d1
                bcs.w   loc_35C8
                bne.w   loc_35DA
                move.w  #$2000,d2
                rts
; ---------------------------------------------------------------------------
loc_35C8:                               ; CODE XREF: Math_Arctan2Lookup+3A   j
                clr.w   d2
                swap    d1
                clr.w   d1
                divu.w  d0,d1
                lsr.w   #8,d1
                add.w   d1,d1
                add.w   (a0,d1.w),d2
                rts
; ---------------------------------------------------------------------------
loc_35DA:                               ; CODE XREF: Math_Arctan2Lookup+3E   j
                move.w  #$4000,d2
                swap    d0
                clr.w   d0
                divu.w  d1,d0
                lsr.w   #8,d0
                add.w   d0,d0
                sub.w   (a0,d0.w),d2
                rts
; ---------------------------------------------------------------------------
loc_35EE:                               ; CODE XREF: Math_Arctan2Lookup+34   j
                neg.w   d1
                cmp.w   d0,d1
                bcs.w   loc_3600
                bne.w   loc_3612
                move.w  #$E000,d2
                rts
; ---------------------------------------------------------------------------
loc_3600:                               ; CODE XREF: Math_Arctan2Lookup+72   j
                clr.w   d2
                swap    d1
                clr.w   d1
                divu.w  d0,d1
                lsr.w   #8,d1
                add.w   d1,d1
                sub.w   (a0,d1.w),d2
                rts
; ---------------------------------------------------------------------------
loc_3612:                               ; CODE XREF: Math_Arctan2Lookup+76   j
                move.w  #$C000,d2
                swap    d0
                clr.w   d0
                divu.w  d1,d0
                lsr.w   #8,d0
                add.w   d0,d0
                add.w   (a0,d0.w),d2
                rts
; ---------------------------------------------------------------------------
loc_3626:                               ; CODE XREF: Math_Arctan2Lookup+8   j
                neg.w   d0
                tst.w   d1
                beq.w   loc_35AA
                bmi.w   loc_366A
                cmp.w   d0,d1
                bcs.w   loc_3642
                bne.w   loc_3656
                move.w  #$6000,d2
                rts
; ---------------------------------------------------------------------------
loc_3642:                               ; CODE XREF: Math_Arctan2Lookup+B4   j
                move.w  #$8000,d2
                swap    d1
                clr.w   d1
                divu.w  d0,d1
                lsr.w   #8,d1
                add.w   d1,d1
                sub.w   (a0,d1.w),d2
                rts
; ---------------------------------------------------------------------------
loc_3656:                               ; CODE XREF: Math_Arctan2Lookup+B8   j
                move.w  #$4000,d2
                swap    d0
                clr.w   d0
                divu.w  d1,d0
                lsr.w   #8,d0
                add.w   d0,d0
                add.w   (a0,d0.w),d2
                rts
; ---------------------------------------------------------------------------
loc_366A:                               ; CODE XREF: Math_Arctan2Lookup+AE   j
                neg.w   d1
                cmp.w   d0,d1
                bcs.w   loc_367C
                bne.w   loc_3690
                move.w  #$A000,d2
                rts
; ---------------------------------------------------------------------------
loc_367C:                               ; CODE XREF: Math_Arctan2Lookup+EE   j
                move.w  #$8000,d2
                swap    d1
                clr.w   d1
                divu.w  d0,d1
                lsr.w   #8,d1
                add.w   d1,d1
                add.w   (a0,d1.w),d2
                rts
; ---------------------------------------------------------------------------
loc_3690:                               ; CODE XREF: Math_Arctan2Lookup+F2   j
                move.w  #$C000,d2
                swap    d0
                clr.w   d0
                divu.w  d1,d0
                lsr.w   #8,d0
                add.w   d0,d0
                sub.w   (a0,d0.w),d2
                rts
; End of function Math_Arctan2Lookup
; ---------------------------------------------------------------------------
word_36A4:	binclude	"data/other/word_36A4.bin"
word_36A4_End:


; Calculates square root of d0 using Newton-Raphson method
Math_SquareRoot:
                tst.l   d0  ; was: sub_38A4
                beq.s   locret_38C8
                cmpi.l  #$10000,d0
                bcc.s   loc_38FA
                cmpi.w  #$271,d0
                bhi.s   loc_38CA
                move.w  d1,-(sp)
                move.w  #$FFFF,d1
loc_38BC:                               ; CODE XREF: Math_SquareRoot+1C   j
                addq.w  #2,d1
                sub.w   d1,d0
                bpl.s   loc_38BC
                asr.w   #1,d1
                move.w  d1,d0
                move.w  (sp)+,d1
locret_38C8:                            ; CODE XREF: Math_SquareRoot+2   j
                rts
; ---------------------------------------------------------------------------
loc_38CA:                               ; CODE XREF: Math_SquareRoot+10   j
                movem.w d1-d4,-(sp)
                move.w  #7,d4
                clr.w   d1
                clr.w   d2
loc_38D6:                               ; CODE XREF: Math_SquareRoot:loc_38EE   j
                add.w   d0,d0
                addx.w  d1,d1
                add.w   d0,d0
                addx.w  d1,d1
                add.w   d2,d2
                move.w  d2,d3
                add.w   d3,d3
                cmp.w   d3,d1
                bls.s   loc_38EE
                addq.w  #1,d2
                addq.w  #1,d3
                sub.w   d3,d1
loc_38EE:                               ; CODE XREF: Math_SquareRoot+42   j
                dbf     d4,loc_38D6
                move.w  d2,d0
                movem.w (sp)+,d1-d4
                rts
; ---------------------------------------------------------------------------
loc_38FA:                               ; CODE XREF: Math_SquareRoot+A   j
                movem.l d1-d4,-(sp)
                moveq   #$D,d4
                moveq   #0,d1
                moveq   #0,d2
loc_3904:                               ; CODE XREF: Math_SquareRoot:loc_391C   j
                add.l   d0,d0
                addx.w  d1,d1
                add.l   d0,d0
                addx.w  d1,d1
                add.w   d2,d2
                move.w  d2,d3
                add.w   d3,d3
                cmp.w   d3,d1
                bls.s   loc_391C
                addq.w  #1,d2
                addq.w  #1,d3
                sub.w   d3,d1
loc_391C:                               ; CODE XREF: Math_SquareRoot+70   j
                dbf     d4,loc_3904
                add.l   d0,d0
                addx.w  d1,d1
                add.l   d0,d0
                addx.l  d1,d1
                add.w   d2,d2
                move.l  d2,d3
                add.w   d3,d3
                cmp.l   d3,d1
                bls.s   loc_3938
                addq.w  #1,d2
                addq.w  #1,d3
                sub.l   d3,d1
loc_3938:                               ; CODE XREF: Math_SquareRoot+8C   j
                add.l   d0,d0
                addx.l  d1,d1
                add.l   d0,d0
                addx.l  d1,d1
                add.w   d2,d2
                move.l  d2,d3
                add.l   d3,d3
                cmp.l   d3,d1
                bls.s   loc_394C
                addq.w  #1,d2
loc_394C:                               ; CODE XREF: Math_SquareRoot+A4   j
                move.w  d2,d0
                movem.l (sp)+,d1-d4
                rts
; End of function Math_SquareRoot
; Adds BCD value to score with overflow check and clamping
UI_AddScoreBCD:                               ; CODE XREF: Text_FinalizeAndSaveScore+14   p  ; was: sub_3954
                                        ; Enemy_DetectPlayerCollision+E2   p ...
                tst.w   (word_FFA270).w
                beq.s   locret_397C
                lea     (word_FFA216).w,a0
                clr.b   (byte_FFA005).w
                move.l  d0,(dword_FFA006).w
                lea     (word_FFA00A).w,a1
                sub.w   d0,d0
                abcd    -(a1),-(a0)
                abcd    -(a1),-(a0)
                abcd    -(a1),-(a0)
                abcd    -(a1),-(a0)
                bcc.s   locret_397C
                move.l  #$99999999,(a0)
locret_397C:                            ; CODE XREF: UI_AddScoreBCD+4   j
                                        ; UI_AddScoreBCD+20   j
                rts
; End of function UI_AddScoreBCD
nullsub_14:
                rts
; End of function nullsub_14


RandomNumber:                           ; CODE XREF: Sys_VBlankHandler+52   p
                                        ; sub_7D68:loc_7DEA   p ...
                move.l  d1,-(sp)
                move.l  (dword_FFFF08).w,d1
                bne.s   loc_398E
                move.l  #'*m6Z',d1
loc_398E:                               ; CODE XREF: RandomNumber+6   j
                move.l  d1,d0
                asl.l   #2,d1
                add.l   d0,d1
                asl.l   #3,d1
                add.l   d0,d1
                move.w  d1,d0
                swap    d1
                add.w   d1,d0
                move.w  d0,d1
                swap    d1
                move.l  d1,(dword_FFFF08).w
                move.l  (sp)+,d1
                rts
; End of function RandomNumber


; Handles palette fade transition with bit adjustments and color blending for screen transitions
Gfx_FadePaletteTransition:                               ; CODE XREF: Sys_StoryScreenMainLoop+50   p  ; was: sub_39AA
                                        ; Sys_TransitionToTitleScreen+20   p ...
                move.w  (word_FF80F2).w,d0
                beq.w   locret_3A9A
                moveq   #0,d5
                move.w  (word_FFA280).w,d1
                andi.w  #3,d1
                btst    #1,d0
                bne.s   loc_39F2
                btst    #0,(byte_FF80F8).w
                bne.s   loc_39DE
                tst.w   d0
                bpl.s   loc_39D8
                tst.w   (word_FF80F0).w
                beq.s   loc_39DE
                moveq   #$FFFFFFFE,d5
                bra.s   loc_3A3E
; ---------------------------------------------------------------------------
loc_39D8:                               ; CODE XREF: Gfx_FadePaletteTransition+22   j
                tst.w   (word_FF80F0).w
                bmi.s   loc_39EE
loc_39DE:                               ; CODE XREF: Gfx_FadePaletteTransition+1E   j
                                        ; Gfx_FadePaletteTransition+28   j
                clr.w   (word_FF80F0).w
                clr.w   (word_FF80F2).w
                bset    #0,(word_FF80F4).w
                rts
; ---------------------------------------------------------------------------
loc_39EE:                               ; CODE XREF: Gfx_FadePaletteTransition+32   j
                moveq   #2,d5
                bra.s   loc_3A3E
; ---------------------------------------------------------------------------
loc_39F2:                               ; CODE XREF: Gfx_FadePaletteTransition+16   j
                btst    #1,(byte_FF80F8).w
                bne.s   loc_3A1E
                tst.w   d0
                bpl.s   loc_3A16
                cmpi.w  #$10,(word_FF80F0).w
                bpl.s   loc_3A1E
                btst    #2,(byte_FF80F8).w
                beq.s   loc_3A12
                tst.w   d1
                bne.s   loc_3A3E
loc_3A12:                               ; CODE XREF: Gfx_FadePaletteTransition+62   j
                moveq   #2,d5
                bra.s   loc_3A3E
; ---------------------------------------------------------------------------
loc_3A16:                               ; CODE XREF: Gfx_FadePaletteTransition+52   j
                cmpi.w  #$FFF0,(word_FF80F0).w
                bpl.s   loc_3A30
loc_3A1E:                               ; CODE XREF: Gfx_FadePaletteTransition+4E   j
                                        ; Gfx_FadePaletteTransition+5A   j
                move.w  #$FFF4,(word_FF80F0).w
                clr.w   (word_FF80F2).w
                bset    #1,(word_FF80F4).w
                rts
; ---------------------------------------------------------------------------
loc_3A30:                               ; CODE XREF: Gfx_FadePaletteTransition+72   j
                btst    #2,(byte_FF80F8).w
                beq.s   loc_3A3C
                tst.w   d1
                bne.s   loc_3A3E
loc_3A3C:                               ; CODE XREF: Gfx_FadePaletteTransition+8C   j
                moveq   #$FFFFFFFE,d5
loc_3A3E:                               ; CODE XREF: Gfx_FadePaletteTransition+2C   j
                                        ; Gfx_FadePaletteTransition+46   j ...
                movea.w #(word_FFE380-M68K_RAM),a0
                movea.w #(word_FFE300-M68K_RAM),a1
                move.w  (word_FF80F0).w,d0
                move.w  d0,d1
                move.w  d0,d2
                move.w  d0,d3
                move.w  (word_FF80F4).w,d0
                cmpi.w  #$E000,d0
                bne.s   loc_3A62
                move.w  #$8000,d0
                add.w   d5,d3
                bra.s   loc_3A80
; ---------------------------------------------------------------------------
loc_3A62:                               ; CODE XREF: Gfx_FadePaletteTransition+AE   j
                cmpi.w  #$8000,d0
                bne.s   loc_3A72
                move.w  #$C000,d0
                add.w   d5,d3
                add.w   d5,d2
                bra.s   loc_3A80
; ---------------------------------------------------------------------------
loc_3A72:                               ; CODE XREF: Gfx_FadePaletteTransition+BC   j
                move.w  #$E000,d0
                add.w   d5,d3
                add.w   d5,d2
                add.w   d5,d1
                add.w   d5,(word_FF80F0).w
loc_3A80:                               ; CODE XREF: Gfx_FadePaletteTransition+B6   j
                                        ; Gfx_FadePaletteTransition+C6   j
                move.w  d0,(word_FF80F4).w
                asl.w   #4,d2
                asl.w   #8,d3
                move.w  #$E000,d0
                moveq   #$3F,d5 ; '?'
loc_3A8E:                               ; CODE XREF: Gfx_FadePaletteTransition+EC   j
                move.w  (a0)+,d6
                bsr.w Gfx_AdjustPaletteBits
                move.w  d6,(a1)+
                dbf     d5,loc_3A8E
locret_3A9A:                            ; CODE XREF: Gfx_FadePaletteTransition+4   j
                rts
; End of function Gfx_FadePaletteTransition
; Processes palette entries by adjusting RGB components to dual locations
Gfx_ProcessPaletteDual:
                move.w  a0,d1  ; was: sub_3A9C
                addi.w  #$80,d1
                movea.w d1,a1
                bsr.w Gfx_PrepareRGBComponents
                move.w  d7,d0
loc_3AAA:                               ; CODE XREF: Gfx_ProcessPaletteDual+18   j
                move.w  (a0),d6
                bsr.w Gfx_AdjustPaletteBits
                move.w  d6,(a0)+
                move.w  d6,(a1)+
                dbf     d5,loc_3AAA
                rts
; End of function Gfx_ProcessPaletteDual
; Updates palette with fade effect using timer
Gfx_UpdatePaletteFade:                               ; CODE XREF: Boss_DestroyerProtoSpawnProjectile2   p  ; was: sub_3ABA
                                        ; sub_35DDC   p ...
                bsr.s Gfx_CalculateFadeParams
                move.w  (word_FFE3EC).w,(dword_FF8040).w
                move.w  (word_FFE36C).w,(dword_FF8040+2).w
                movea.w #(word_FFE362-M68K_RAM),a0
                moveq   #$E,d5
                bsr.s Gfx_ApplyPaletteFade
                move.w  (dword_FF8040).w,(word_FFE3EC).w
                move.w  (dword_FF8040+2).w,(word_FFE36C).w
                rts
; End of function Gfx_UpdatePaletteFade
; Updates Sharpsteel palette in VBlank
VBlank_UpdateSharpssteelPalette:                               ; CODE XREF: Enemy_ShipSpawnCannons+9A   p  ; was: sub_3ADE
                                        ; Boss_ViblackUpdateAll+6   p ...
                bsr.s Gfx_CalculateFadeParams
                bra.w VBlank_SharpssteelPaletteEffect
; End of function VBlank_UpdateSharpssteelPalette
; Calculates fade parameters from timer and random
Gfx_CalculateFadeParams:                               ; CODE XREF: Gfx_UpdatePaletteFade   p  ; was: sub_3AE4
                                        ; sub_3ADE   p
                moveq   #$E,d0
                move.w  #$E000,d7
                move.w  (word_FFA000).w,d1
                andi.w  #$7F,d1
                bne.s   loc_3AFC
                btst    #2,(dword_FFFF08+1).w
                beq.s   locret_3B26
loc_3AFC:                               ; CODE XREF: Gfx_CalculateFadeParams+E   j
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                addq.w  #6,d0
                move.w  #$8000,d7
                move.w  (word_FFA000).w,d1
                andi.w  #$1F,d1
                beq.s   locret_3B26
                move.b  (dword_FFFF08).w,d1
                andi.w  #3,d1
                beq.s   locret_3B26
                neg.w   d0
                subq.w  #2,d0
                move.w  #$6000,d7
locret_3B26:                            ; CODE XREF: Gfx_CalculateFadeParams+16   j
                                        ; Gfx_CalculateFadeParams+2E   j ...
                rts
; End of function Gfx_CalculateFadeParams
; Sets palette fade operation parameters for screen transitions
Gfx_SetFadeParams:                               ; CODE XREF: Gfx_PaletteFadeEffect+16   p  ; was: sub_3B28
                                        ; sub_DBF4:loc_DC6A   j ...
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #$3F,d5 ; '?'
                move.w  #$E000,d7
; End of function Gfx_SetFadeParams
; Applies fade to palette colors with RGB adjustment
Gfx_ApplyPaletteFade:                               ; CODE XREF: Gfx_UpdatePaletteFade+14   p  ; was: sub_3B32
                                        ; Gfx_FadeOutToDark+24   p ...
                movea.w a0,a1
                lea     $80(a1),a1
                bsr.w Gfx_PrepareRGBComponents
                move.w  d7,d0
loc_3B3E:                               ; CODE XREF: Gfx_ApplyPaletteFade+14   j
                move.w  (a1)+,d6
                bsr.w Gfx_AdjustPaletteBits
                move.w  d6,(a0)+
                dbf     d5,loc_3B3E
                rts
; End of function Gfx_ApplyPaletteFade
; Sharpsteel palette effect
VBlank_SharpssteelPaletteEffect:                               ; CODE XREF: VBlank_UpdateSharpssteelPalette+2   j  ; was: sub_3B4C
                                        ; Boss_BugmaxPerspectiveHelper+36   j
                move.w  (a4)+,d5
                bsr.w Gfx_PrepareRGBComponents
                move.w  d7,d0
loc_3B54:                               ; CODE XREF: VBlank_SharpssteelPaletteEffect+14   j
                movea.w (a4)+,a0
                move.w  $80(a0),d6
                bsr.w Gfx_AdjustPaletteBits
                move.w  d6,(a0)
                dbf     d5,loc_3B54
                rts
; End of function VBlank_SharpssteelPaletteEffect
; Prepares RGB shift components for palette operations
Gfx_PrepareRGBComponents:                               ; CODE XREF: Gfx_ProcessPaletteDual+8   p  ; was: sub_3B66
                                        ; Gfx_ApplyPaletteFade+6   p ...
                move.w  d0,d1
                move.w  d0,d2
                move.w  d0,d3
                asl.w   #4,d2
                asl.w   #8,d3
                rts
; End of function Gfx_PrepareRGBComponents
; Adds RGB deltas to palette word and stores result at offset
Gfx_AddRGBComponents:
                move.w  d0,d1  ; was: sub_3B72
                move.w  d0,d2
                move.w  d0,d3
                move.w  (a0),d4
                move.w  (a0),d5
                move.w  (a0),d6
                add.w   d1,d4
                add.w   d2,d5
                add.w   d3,d6
                andi.w  #$E,d4
                andi.w  #$E0,d5
                andi.w  #$E00,d6
                or.w    d4,d5
                or.w    d5,d6
                move.w  d6,-$80(a0)
                rts
; End of function Gfx_AddRGBComponents
; Adjusts palette selection bits in tile data
Gfx_AdjustPaletteBits:                               ; CODE XREF: Gfx_FadePaletteTransition+E6   p  ; was: sub_3B9A
                                        ; Gfx_ProcessPaletteDual+10   p ...
                move.w  d6,d7
                btst    #$F,d0
                beq.s   loc_3BBE
                move.w  d6,d7
                andi.w  #$E,d7
                add.w   d1,d7
                bpl.s   loc_3BB0
                clr.w   d7
                bra.s   loc_3BB8
; ---------------------------------------------------------------------------
loc_3BB0:                               ; CODE XREF: Gfx_AdjustPaletteBits+10   j
                cmpi.w  #$F,d7
                bmi.s   loc_3BB8
                moveq   #$E,d7
loc_3BB8:                               ; CODE XREF: Gfx_AdjustPaletteBits+14   j
                                        ; Gfx_AdjustPaletteBits+1A   j
                andi.w  #$FFF0,d6
                or.w    d7,d6
loc_3BBE:                               ; CODE XREF: Gfx_AdjustPaletteBits+6   j
                btst    #$E,d0
                beq.s   loc_3BE2
                move.w  d6,d7
                andi.w  #$E0,d7
                add.w   d2,d7
                bpl.s   loc_3BD2
                clr.w   d7
                bra.s   loc_3BDC
; ---------------------------------------------------------------------------
loc_3BD2:                               ; CODE XREF: Gfx_AdjustPaletteBits+32   j
                cmpi.w  #$E1,d7
                bmi.s   loc_3BDC
                move.w  #$E0,d7
loc_3BDC:                               ; CODE XREF: Gfx_AdjustPaletteBits+36   j
                                        ; Gfx_AdjustPaletteBits+3C   j
                andi.w  #$FF0F,d6
                or.w    d7,d6
loc_3BE2:                               ; CODE XREF: Gfx_AdjustPaletteBits+28   j
                btst    #$D,d0
                beq.s   locret_3C06
                move.w  d6,d7
                andi.w  #$E00,d7
                add.w   d3,d7
                bpl.s   loc_3BF6
                clr.w   d7
                bra.s   loc_3C00
; ---------------------------------------------------------------------------
loc_3BF6:                               ; CODE XREF: Gfx_AdjustPaletteBits+56   j
                cmpi.w  #$E01,d7
                bmi.s   loc_3C00
                move.w  #$E00,d7
loc_3C00:                               ; CODE XREF: Gfx_AdjustPaletteBits+5A   j
                                        ; Gfx_AdjustPaletteBits+60   j
                andi.w  #$F0FF,d6
                or.w    d7,d6
locret_3C06:                            ; CODE XREF: Gfx_AdjustPaletteBits+4C   j
                rts
; End of function Gfx_AdjustPaletteBits
; Loads address of palette table word_3DF4 into a2
Data_LoadPaletteTable:                               ; CODE XREF: Gfx_UpdateBossPalette+72   j  ; was: sub_3C08
                                        ; Boss_SunsetStingLoadGraphics+1A   p ...
                lea     word_3DF4(pc),a2
                nop
; End of function Data_LoadPaletteTable
; Clears color fade state variables and status flags
Gfx_ClearColorFadeState:                               ; CODE XREF: Boss_FlyingNeoSetup+E2   p  ; was: sub_3C0E
                                        ; Boss_ViblackInit+AC   p
                clr.w   (word_FF80EE).w
                bclr    #0,(byte_FF80EC).w
                bclr    #3,(byte_FF80EC).w
                rts
; End of function Gfx_ClearColorFadeState
; Initializes palette fade system loading fade table pointer
Gfx_InitPaletteFade:                               ; CODE XREF: Boss_DestroyerProtoMain   p  ; was: sub_3C20
                                        ; sub_323FA   p ...
                lea     word_3DF4(pc),a2
                nop
; End of function Gfx_InitPaletteFade
; Processes RGB color channel fading with clamping and interpolation
Gfx_ProcessColorFade:                               ; CODE XREF: Boss_FlyingNeoMain+1C   p  ; was: sub_3C26
                                        ; Boss_ViblackMain+12   p ...
                moveq   #0,d1
                moveq   #0,d2
                moveq   #0,d3
                tst.w   (word_FF80EE).w
                bne.s   loc_3C52
                bclr    #0,(byte_FF80EC).w
                beq.w   locret_3CCC
                move.w  #$A,(word_FF80EE).w
                bclr    #3,(byte_FF80EC).w
                beq.w   loc_3C52
                move.w  #$19,(word_FF80EE).w
loc_3C52:                               ; CODE XREF: Gfx_ProcessColorFade+A   j
                                        ; Gfx_ProcessColorFade+22   j
                moveq   #0,d2
                subq.w  #5,(word_FF80EE).w
                beq.s   loc_3C5E
                move.w  (word_FF80EE).w,d2
loc_3C5E:                               ; CODE XREF: Gfx_ProcessColorFade+32   j
                move.w  d2,d3
                asl.w   #4,d3
                andi.w  #$FFE0,d3
                move.w  d3,d4
                asl.w   #4,d4
                andi.w  #$FE00,d4
                move.w  (a2)+,d7
loc_3C70:                               ; CODE XREF: Gfx_ProcessColorFade+9C   j
                movea.w (a2)+,a1
                move.w  $80(a1),d0
                move.w  d0,d5
                andi.w  #$E,d5
                add.w   d2,d5
                bpl.s   loc_3C84
                moveq   #0,d5
                bra.s   loc_3C8C
; ---------------------------------------------------------------------------
loc_3C84:                               ; CODE XREF: Gfx_ProcessColorFade+58   j
                cmpi.w  #$F,d5
                bmi.s   loc_3C8C
                moveq   #$E,d5
loc_3C8C:                               ; CODE XREF: Gfx_ProcessColorFade+5C   j
                                        ; Gfx_ProcessColorFade+62   j
                move.w  d0,d1
                andi.w  #$E0,d1
                add.w   d3,d1
                bpl.s   loc_3C9A
                moveq   #0,d1
                bra.s   loc_3CA4
; ---------------------------------------------------------------------------
loc_3C9A:                               ; CODE XREF: Gfx_ProcessColorFade+6E   j
                cmpi.w  #$E1,d1
                bmi.s   loc_3CA4
                move.w  #$E0,d1
loc_3CA4:                               ; CODE XREF: Gfx_ProcessColorFade+72   j
                                        ; Gfx_ProcessColorFade+78   j
                or.w    d1,d5
                move.w  d0,d1
                andi.w  #$E00,d1
                add.w   d4,d1
                bpl.s   loc_3CB4
                moveq   #0,d1
                bra.s   loc_3CBE
; ---------------------------------------------------------------------------
loc_3CB4:                               ; CODE XREF: Gfx_ProcessColorFade+88   j
                cmpi.w  #$E01,d1
                bmi.s   loc_3CBE
                move.w  #$E00,d1
loc_3CBE:                               ; CODE XREF: Gfx_ProcessColorFade+8C   j
                                        ; Gfx_ProcessColorFade+92   j
                or.w    d1,d5
                move.w  d5,(a1)
                dbf     d7,loc_3C70
                bclr    #0,(byte_FF80EC).w
locret_3CCC:                            ; CODE XREF: Gfx_ProcessColorFade+12   j
                rts
; End of function Gfx_ProcessColorFade
; Initializes color fade state by loading palette table and clearing fade variables
Gfx_InitColorFadeState:
                lea     word_3DF4(pc),a2  ; was: sub_3CCE
                nop
                clr.w   (word_FF8246).w
                clr.w   (word_FF80EE).w
                bclr    #0,(byte_FF80EC).w
                rts
; End of function Gfx_InitColorFadeState
; Processes complex color fade effects with RGB component clamping
Gfx_ProcessColorFadeEffect:
                lea     word_3DF4(pc),a2  ; was: sub_3CE4
                nop
                moveq   #0,d1
                moveq   #0,d2
                moveq   #0,d3
                tst.w   (word_FF8246).w
                beq.w   loc_3D5E
                bpl.s   loc_3D02
                clr.w   (word_FF8246).w
                bra.w   loc_3E5E
; ---------------------------------------------------------------------------
loc_3D02:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+14   j
                move.w  #$FFFF,(word_FF8246).w
                clr.w   (word_FF80EE).w
                btst    #1,(byte_FF80EC).w
                bne.w   locret_3DF2
                move.w  (word_FFA000).w,d0
                move.w  d0,d4
                asr.w   #4,d4
                andi.w  #$E,d4
                move.w  word_3D4E(pc,d4.w),d4
                neg.w   d0
                andi.w  #$E,d0
                addq.w  #4,d0
                btst    #0,d4
                beq.s   loc_3D36
                move.w  d0,d1
loc_3D36:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+4E   j
                btst    #1,d4
                beq.s   loc_3D3E
                move.w  d0,d2
loc_3D3E:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+56   j
                btst    #2,d4
                beq.s   loc_3D46
                move.w  d0,d3
loc_3D46:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+5E   j
                asl.w   #4,d2
                asl.w   #8,d3
                bra.w   loc_3E5E
; ---------------------------------------------------------------------------
word_3D4E:      dc.w 1, 2, 4, 3, 6, 5, 3, 5
; ---------------------------------------------------------------------------
loc_3D5E:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+10   j
                tst.w   (word_FF80EE).w
                bne.s   loc_3D6E
                bclr    #0,(byte_FF80EC).w
                beq.w   locret_3DF2
loc_3D6E:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+7E   j
                move.w  (word_FF80EE).w,d2
                addq.w  #2,d2
                andi.w  #$E,d2
                move.w  d2,(word_FF80EE).w
                beq.s   loc_3D80
                subq.w  #6,d2
loc_3D80:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+98   j
                andi.w  #$FFFE,d2
                move.w  d2,d3
                asl.w   #4,d3
                andi.w  #$FFE0,d3
                move.w  d3,d4
                asl.w   #4,d4
                andi.w  #$FE00,d4
                move.w  (a2)+,d7
loc_3D96:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+104   j
                movea.w (a2)+,a1
                move.w  $80(a1),d0
                move.w  d0,d5
                andi.w  #$E,d5
                add.w   d2,d5
                bpl.s   loc_3DAA
                moveq   #0,d5
                bra.s   loc_3DB2
; ---------------------------------------------------------------------------
loc_3DAA:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+C0   j
                cmpi.w  #$F,d5
                bmi.s   loc_3DB2
                moveq   #$E,d5
loc_3DB2:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+C4   j
                                        ; Gfx_ProcessColorFadeEffect+CA   j
                move.w  d0,d1
                andi.w  #$E0,d1
                add.w   d3,d1
                bpl.s   loc_3DC0
                moveq   #0,d1
                bra.s   loc_3DCA
; ---------------------------------------------------------------------------
loc_3DC0:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+D6   j
                cmpi.w  #$E1,d1
                bmi.s   loc_3DCA
                move.w  #$E0,d1
loc_3DCA:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+DA   j
                                        ; Gfx_ProcessColorFadeEffect+E0   j
                or.w    d1,d5
                move.w  d0,d1
                andi.w  #$E00,d1
                add.w   d4,d1
                bpl.s   loc_3DDA
                moveq   #0,d1
                bra.s   loc_3DE4
; ---------------------------------------------------------------------------
loc_3DDA:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+F0   j
                cmpi.w  #$E01,d1
                bmi.s   loc_3DE4
                move.w  #$E00,d1
loc_3DE4:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+F4   j
                                        ; Gfx_ProcessColorFadeEffect+FA   j
                or.w    d1,d5
                move.w  d5,(a1)
                dbf     d7,loc_3D96
                bclr    #0,(byte_FF80EC).w
locret_3DF2:                            ; CODE XREF: Gfx_ProcessColorFadeEffect+2E   j
                                        ; Gfx_ProcessColorFadeEffect+86   j
                rts
; End of function Gfx_ProcessColorFadeEffect
; ---------------------------------------------------------------------------
word_3DF4:      dc.w $D                 ; DATA XREF: Data_LoadPaletteTable   o
                                        ; sub_3C20   o ...
                dc.w $E362, $E364, $E366, $E368, $E36A, $E36E, $E370, $E372
                dc.w $E374, $E376, $E378, $E37A, $E37C, $E37E
word_3E12:      dc.w $C                 ; DATA XREF: Boss_FlyingNeoMain:loc_3C00C   o
                                        ; Boss_FlyingNeoMain+4E   o ...
                dc.w $E362, $E364, $E366, $E368, $E36A, $E370, $E372, $E374
                dc.w $E376, $E378, $E37A, $E37C, $E37E
word_3E2E:      dc.w 5                  ; DATA XREF: Boss_BugmaxPerspectiveHelper+30   o
                dc.w $E366, $E368, $E36A, $E36E, $E370, $E378
word_3E3C:      dc.w 6                  ; DATA XREF: Boss_BugmaxMain+8   o
                dc.w $E362, $E372, $E374, $E376, $E37A, $E37C, $E37E
word_3E4C:      dc.w 5                  ; DATA XREF: Boss_ValkirieIntroMove:loc_5578A   o
                                        ; sub_5699C:loc_569C8   o ...
                dc.w $E362, $E36A, $E372, $E374, $E376, $E378


; RGB color fade processing with channel clamping
Gfx_FadeRGBColor:                               ; CODE XREF: Palette_FadeEffect+8   p  ; was: sub_3E5A
                                        ; Palette_FadeEffect+12   p
                bsr.w Gfx_PrepareRGBComponents
loc_3E5E:                               ; CODE XREF: Gfx_ProcessColorFadeEffect+1A   j
                                        ; Gfx_ProcessColorFadeEffect+66   j ...
                move.w  (a2)+,d5
loc_3E60:                               ; CODE XREF: Gfx_FadeRGBColor+66   j
                movea.w (a2)+,a1
                move.w  $80(a1),d6
                move.w  d6,d7
                andi.w  #$E,d7
                add.w   d1,d7
                bpl.s   loc_3E74
                clr.w   d7
                bra.s   loc_3E7C
; ---------------------------------------------------------------------------
loc_3E74:                               ; CODE XREF: Gfx_FadeRGBColor+14   j
                cmpi.w  #$F,d7
                bmi.s   loc_3E7C
                moveq   #$E,d7
loc_3E7C:                               ; CODE XREF: Gfx_FadeRGBColor+18   j
                                        ; Gfx_FadeRGBColor+1E   j
                andi.w  #$FFF0,d6
                or.w    d7,d6
                move.w  d6,d7
                andi.w  #$E0,d7
                add.w   d2,d7
                bpl.s   loc_3E90
                clr.w   d7
                bra.s   loc_3E9A
; ---------------------------------------------------------------------------
loc_3E90:                               ; CODE XREF: Gfx_FadeRGBColor+30   j
                cmpi.w  #$E1,d7
                bmi.s   loc_3E9A
                move.w  #$E0,d7
loc_3E9A:                               ; CODE XREF: Gfx_FadeRGBColor+34   j
                                        ; Gfx_FadeRGBColor+3A   j
                andi.w  #$FF0F,d6
                or.w    d7,d6
                move.w  d6,d7
                andi.w  #$E00,d7
                add.w   d3,d7
                bpl.s   loc_3EAE
                clr.w   d7
                bra.s Gfx_ClampGreenChannel
; ---------------------------------------------------------------------------
loc_3EAE:                               ; CODE XREF: Gfx_FadeRGBColor+4E   j
                cmpi.w  #$E01,d7
                bmi.s Gfx_ClampGreenChannel
                move.w  #$E00,d7
; Clamps green color channel to maximum value $E00 and updates palette word during fade operation.
Gfx_ClampGreenChannel:                               ; CODE XREF: Gfx_FadeRGBColor+52   j  ; was: loc_3EB8
                                        ; Gfx_FadeRGBColor+58   j
                andi.w  #$F0FF,d6
                or.w    d7,d6
                move.w  d6,(a1)
                dbf     d5,loc_3E60
                rts
; End of function Gfx_FadeRGBColor
; ---------------------------------------------------------------------------
word_3EC6:      dc.w $3A, $E302, $E304, $E306, $E308, $E30A, $E30C, $E30E, $E310, $E312
                                        ; DATA XREF: Stage_UpdateScrollOffset+18   o
                dc.w $E314, $E316, $E318, $E31A, $E31C, $E31E, $E322, $E324, $E326, $E328
                dc.w $E32A, $E32C, $E32E, $E330, $E332, $E334, $E336, $E338, $E33A, $E33C
                dc.w $E33E, $E342, $E344, $E346, $E348, $E34A, $E34C, $E34E, $E350, $E352
                dc.w $E354, $E356, $E358, $E35A, $E35C, $E35E, $E362, $E364, $E366, $E368
                dc.w $E36A, $E36E, $E370, $E372, $E374, $E376, $E378, $E37A, $E37C, $E37E


; Fades palette colors toward target RGB values by incrementing or decrementing each color channel separately.
Gfx_FadeToTargetColor:                               ; CODE XREF: Boss_FlyingNeoMain+54   p  ; was: sub_3F3E
                move.w  d0,d1
                move.w  d1,d2
                andi.w  #$E,d0
                andi.w  #$E0,d1
                andi.w  #$E00,d2
                moveq   #0,d4
                move.w  (a2)+,d5
loc_3F52:                               ; CODE XREF: Gfx_FadeToTargetColor+70   j
                movea.w (a2)+,a1
                move.w  $80(a1),d6
                move.w  d6,d7
                andi.w  #$E,d7
                cmp.w   d0,d7
                beq.s   loc_3F6E
                bset    #0,d4
                bpl.s   loc_3F6C
                addq.w  #2,d7
                bra.s   loc_3F6E
; ---------------------------------------------------------------------------
loc_3F6C:                               ; CODE XREF: Gfx_FadeToTargetColor+28   j
                subq.w  #2,d7
loc_3F6E:                               ; CODE XREF: Gfx_FadeToTargetColor+22   j
                                        ; Gfx_FadeToTargetColor+2C   j
                move.w  d7,d3
                move.w  d6,d7
                andi.w  #$E0,d7
                cmp.w   d1,d7
                beq.s   loc_3F8A
                bset    #0,d4
                bpl.s   loc_3F86
                addi.w  #$20,d7 ; ' '
                bra.s   loc_3F8A
; ---------------------------------------------------------------------------
loc_3F86:                               ; CODE XREF: Gfx_FadeToTargetColor+40   j
                subi.w  #$20,d7 ; ' '
loc_3F8A:                               ; CODE XREF: Gfx_FadeToTargetColor+3A   j
                                        ; Gfx_FadeToTargetColor+46   j
                or.w    d7,d3
                move.w  d6,d7
                andi.w  #$E00,d7
                cmp.w   d2,d7
                beq.s   loc_3FA6
                bset    #0,d4
                bpl.s   loc_3FA2
                addi.w  #$200,d7
                bra.s   loc_3FA6
; ---------------------------------------------------------------------------
loc_3FA2:                               ; CODE XREF: Gfx_FadeToTargetColor+5C   j
                subi.w  #$200,d7
loc_3FA6:                               ; CODE XREF: Gfx_FadeToTargetColor+56   j
                                        ; Gfx_FadeToTargetColor+62   j
                or.w    d7,d3
                move.w  d3,(a1)
                move.w  d3,$80(a1)
                dbf     d5,loc_3F52
                move.w  d4,d4
                rts
; End of function Gfx_FadeToTargetColor
; Processes palette fade effect with timing
Palette_ProcessFadeEffect:                               ; CODE XREF: Boss_FlyingNeoUpdatePaletteFade+16   j  ; was: sub_3FB6
                moveq   #0,d4
                move.w  (a2)+,d5
loc_3FBA:                               ; CODE XREF: Palette_ProcessFadeEffect+72   j
                movea.w (a2)+,a1
                move.w  $80(a1),d6
                move.w  (a3)+,d0
                move.w  d0,d1
                move.w  d1,d2
                andi.w  #$E,d0
                andi.w  #$E0,d1
                andi.w  #$E00,d2
                move.w  d6,d7
                andi.w  #$E,d7
                cmp.w   d0,d7
                beq.s   loc_3FE8
                bset    #0,d4
                bpl.s   loc_3FE6
                addq.w  #2,d7
                bra.s   loc_3FE8
; ---------------------------------------------------------------------------
loc_3FE6:                               ; CODE XREF: Palette_ProcessFadeEffect+2A   j
                subq.w  #2,d7
loc_3FE8:                               ; CODE XREF: Palette_ProcessFadeEffect+24   j
                                        ; Palette_ProcessFadeEffect+2E   j
                move.w  d7,d3
                move.w  d6,d7
                andi.w  #$E0,d7
                cmp.w   d1,d7
                beq.s   loc_4004
                bset    #0,d4
                bpl.s   loc_4000
                addi.w  #$20,d7 ; ' '
                bra.s   loc_4004
; ---------------------------------------------------------------------------
loc_4000:                               ; CODE XREF: Palette_ProcessFadeEffect+42   j
                subi.w  #$20,d7 ; ' '
loc_4004:                               ; CODE XREF: Palette_ProcessFadeEffect+3C   j
                                        ; Palette_ProcessFadeEffect+48   j
                or.w    d7,d3
                move.w  d6,d7
                andi.w  #$E00,d7
                cmp.w   d2,d7
                beq.s   loc_4020
                bset    #0,d4
                bpl.s   loc_401C
                addi.w  #$200,d7
                bra.s   loc_4020
; ---------------------------------------------------------------------------
loc_401C:                               ; CODE XREF: Palette_ProcessFadeEffect+5E   j
                subi.w  #$200,d7
loc_4020:                               ; CODE XREF: Palette_ProcessFadeEffect+58   j
                                        ; Palette_ProcessFadeEffect+64   j
                or.w    d7,d3
                move.w  d3,(a1)
                move.w  d3,$80(a1)
                dbf     d5,loc_3FBA
                move.w  d4,d4
                rts
; End of function Palette_ProcessFadeEffect
; Applies RGB color adjustment
Gfx_ApplyRGBColorAdjust:                               ; CODE XREF: Gfx_Stage14PaletteMain   p  ; was: sub_4030
                move.w  (word_FF8140).w,d0
                asr.w   #4,d0
                addi.w  #-$E,d0
                moveq   #$FFFFFFF2,d1
                move.w  #$FF20,d2
                move.w  #$F200,d3
                btst    #5,(byte_FF8142).w
                beq.s   loc_404E
                move.w  d0,d1
loc_404E:                               ; CODE XREF: Gfx_ApplyRGBColorAdjust+1A   j
                btst    #6,(byte_FF8142).w
                beq.s   loc_405A
                move.w  d0,d2
                asl.w   #4,d2
loc_405A:                               ; CODE XREF: Gfx_ApplyRGBColorAdjust+24   j
                btst    #7,(byte_FF8142).w
                beq.s   loc_4066
                move.w  d0,d3
                asl.w   #8,d3
loc_4066:                               ; CODE XREF: Gfx_ApplyRGBColorAdjust+30   j
                movea.w #(word_FFE300-M68K_RAM),a0
                movea.w #(word_FFE380-M68K_RAM),a1
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d0
loc_4076:                               ; CODE XREF: Gfx_ApplyRGBColorAdjust+4E   j
                move.w  (a1)+,d6
                jsr Gfx_AdjustPaletteBits(pc)    ; (pc)
                move.w  d6,(a0)+
                dbf     d5,loc_4076
                moveq   #0,d0
                move.b  (byte_FF8143).w,d0
                sub.w   d0,(word_FF8140).w
                bpl.s   locret_4092
                clr.w   (word_FF8140).w
locret_4092:                            ; CODE XREF: Gfx_ApplyRGBColorAdjust+5C   j
                rts
; End of function Gfx_ApplyRGBColorAdjust
; Main player state machine dispatcher
Player_StateDispatcher:                               ; CODE XREF: Sys_GameplayMainLoop+76   p  ; was: sub_4094
                tst.b   (byte_FF813E).w
                bpl.s Player_DispatchState
                rts
; ---------------------------------------------------------------------------
; Dispatches player state handler by looking up function pointer from state table and jumping to it.
Player_DispatchState:                               ; CODE XREF: Player_StateDispatcher+4   j  ; was: loc_409C
                move.w  (word_FF8220).w,d0
                movea.w off_40AC(pc,d0.w),a0
                adda.l  #Gfx_UpdatePaletteState,a0
                jmp     (a0)
; End of function Player_StateDispatcher
; ---------------------------------------------------------------------------
off_40AC:       dc.w locret_410A-Gfx_UpdatePaletteState
                dc.w Gfx_UpdatePaletteState-Gfx_UpdatePaletteState
                dc.w Gfx_PaletteState_Calculate-Gfx_UpdatePaletteState
                dc.w Stage_SetScrollOffset-Gfx_UpdatePaletteState
                dc.w Scroll_AnimateOffset-Gfx_UpdatePaletteState
                dc.w Gfx_Epsilon1UpdatePalette-Gfx_UpdatePaletteState
                dc.w Gfx_UpdateStage14Palette-Gfx_UpdatePaletteState
                dc.w Boss_ShieldViperLoadTiles-Gfx_UpdatePaletteState
                dc.w Gfx_UpdateSega3Palette-Gfx_UpdatePaletteState
                dc.w Boss_WolfGaropaLoadTiles-Gfx_UpdatePaletteState


; Updates palette state and positions
Gfx_UpdatePaletteState:                               ; DATA XREF: Player_StateDispatcher+10   o  ; was: sub_40C0
                                        ; ROM:off_40AC   o ...
                move.w  #$8CE,d0
                move.w  #$6AE,d1
                btst    #0,(word_FFA000+1).w
                bne.s   loc_40D8
                move.w  #$8E,d0
                move.w  #$4E,d1 ; 'N'
loc_40D8:                               ; CODE XREF: Gfx_UpdatePaletteState+E   j
                movea.w #(word_FFE31C-M68K_RAM),a0
                move.w  d0,$80(a0)
                move.w  d0,(a0)+
                move.w  d1,$80(a0)
                move.w  d1,(a0)+
; Calculates palette index based on game state flags
Gfx_PaletteState_Calculate:                               ; DATA XREF: ROM:000040B0   o  ; was: loc_40E8
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #$E,d0
                move.w  word_410C(pc,d0.w),d0
                btst    #1,(word_FFA000+1).w
                bne.s Gfx_SetPlayerPaletteIndex
                subq.w  #2,d0
; Sets player palette index based on game state flags and player direction bit.
Gfx_SetPlayerPaletteIndex:                               ; CODE XREF: Gfx_UpdatePaletteState+3C   j  ; was: loc_4100
                movea.w #(word_FFE33E-M68K_RAM),a0
                move.w  d0,(a0)
                move.w  d0,$80(a0)
locret_410A:                            ; DATA XREF: ROM:off_40AC   o
                                        ; ROM:off_432E   o
                rts
; End of function Gfx_UpdatePaletteState
; ---------------------------------------------------------------------------
word_410C:      dc.w 2, 4, 6, 8, $A, $C, $2E, $26E


; Sets stage-specific scroll offset value based on frame counter
Stage_SetScrollOffset:                               ; DATA XREF: ROM:000040B2   o  ; was: sub_411C
                move.w  #$480,d0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_412C
                move.w  #$4C0,d0
loc_412C:                               ; CODE XREF: Stage_SetScrollOffset+A   j
                move.w  d0,(word_FFE30C).w
                rts
; End of function Stage_SetScrollOffset
; Animates scroll offset with timer countdown
Scroll_AnimateOffset:                               ; DATA XREF: ROM:000040B4   o  ; was: sub_4132
                move.w  (word_FFA000).w,d0
                asl.w   #2,d0
                andi.w  #4,d0
                subq.w  #1,(word_FF8218).w
                bpl.s   loc_4148
                clr.w   (word_FF8220).w
                moveq   #0,d0
loc_4148:                               ; CODE XREF: Scroll_AnimateOffset+E   j
                move.w  word_4156(pc,d0.w),(word_FFE314).w
                move.w  word_4156+2(pc,d0.w),(word_FFE316).w
                rts
; End of function Scroll_AnimateOffset
; ---------------------------------------------------------------------------
word_4156:      dc.w $E60, $E80, $EA0, $EC0


; Updates palette colors
Gfx_Epsilon1UpdatePalette:                               ; DATA XREF: ROM:000040B6   o  ; was: sub_415E
                lea     word_4190(pc),a0
                nop
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4172
                lea     word_419C(pc),a0
                nop
loc_4172:                               ; CODE XREF: Gfx_Epsilon1UpdatePalette+C   j
                movea.w #(word_FFE320-M68K_RAM),a1
                move.w  (a0)+,$A(a1)
                move.w  (a0)+,$C(a1)
                move.w  (a0)+,$E(a1)
                move.w  (a0)+,$10(a1)
                move.w  (a0)+,$14(a1)
                move.w  (a0)+,$16(a1)
                rts
; End of function Gfx_Epsilon1UpdatePalette
; ---------------------------------------------------------------------------
word_4190:      dc.w $A22, $C44, $E86, $ECA, 0, $44
                                        ; DATA XREF: Gfx_Epsilon1UpdatePalette   o
word_419C:      dc.w $C22, $E44, $EA6, $EEC, $46, 0
                                        ; DATA XREF: Gfx_Epsilon1UpdatePalette+E   o


; Updates Stage 14 palette effects
Gfx_UpdateStage14Palette:                               ; CODE XREF: Gfx_Stage14PaletteMain+4   j  ; was: sub_41A8
                                        ; Gfx_PaletteFadeEffect+1A   j
                                        ; DATA XREF: ...
                move.w  (word_FFA000).w,d0
                movea.w #(word_FFE300-M68K_RAM),a0
                movea.w #(word_FFE380-M68K_RAM),a1
                move.w  (word_FF8218).w,d3
                move.w  d0,d1
                asr.w   #1,d1
                andi.w  #$E,d1
                move.w  d0,d2
                asr.w   #2,d2
                andi.w  #$E,d2
                btst    #2,d3
                bne.s   loc_4204
                move.w  word_423C(pc,d2.w),$3C(a0)
                move.w  word_423C(pc,d2.w),$3C(a1)
                asl.w   #1,d0
                andi.w  #2,d0
                move.w  word_424C(pc,d0.w),$28(a0)
                move.w  word_424C(pc,d0.w),$28(a1)
                move.w  word_4250(pc,d0.w),$2A(a0)
                move.w  word_4250(pc,d0.w),$2A(a1)
                move.w  word_4254(pc,d0.w),$2C(a0)
                move.w  word_4254(pc,d0.w),$2C(a1)
loc_4204:                               ; CODE XREF: Gfx_UpdateStage14Palette+24   j
                btst    #1,d3
                bne.s   locret_422A
                btst    #0,d3
                beq.s   loc_421E
                move.w  word_422C(pc,d1.w),$1C(a0)
                move.w  word_422C(pc,d1.w),$1C(a1)
                rts
; ---------------------------------------------------------------------------
loc_421E:                               ; CODE XREF: Gfx_UpdateStage14Palette+66   j
                move.w  word_422C(pc,d1.w),$1A(a0)
                move.w  word_422C(pc,d1.w),$1A(a1)
locret_422A:                            ; CODE XREF: Gfx_UpdateStage14Palette+60   j
                rts
; End of function Gfx_UpdateStage14Palette
; ---------------------------------------------------------------------------
word_422C:      dc.w 0, 4, 8, $C, $A, 8, 6, 2
word_423C:      dc.w $28E, $4A, 6, 2, 4, 8, $C, $E
word_424C:      dc.w $600, $C00
word_4250:      dc.w $ECA, $EEC
word_4254:      dc.w $202, $200


; Loads boss tiles
Boss_ShieldViperLoadTiles:                               ; DATA XREF: ROM:000040BA   o  ; was: sub_4258
                movea.w #(word_FFE302-M68K_RAM),a0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4284
                move.w  #$200,(a0)+
                addq.w  #8,a0
                move.w  #$CEE,(a0)+
                move.w  #$CCA,(a0)+
                move.w  #$C88,(a0)+
                move.w  #$A62,(a0)+
                move.w  #$820,(a0)+
                move.w  #$600,(a0)+
                rts
; ---------------------------------------------------------------------------
loc_4284:                               ; CODE XREF: Boss_ShieldViperLoadTiles+A   j
                move.w  $80(a0),(a0)+
                addq.w  #8,a0
                move.w  $80(a0),(a0)+
                move.w  $80(a0),(a0)+
                move.w  $80(a0),(a0)+
                move.w  $80(a0),(a0)+
                move.w  $80(a0),(a0)+
                move.w  $80(a0),(a0)+
                rts
; End of function Boss_ShieldViperLoadTiles
; Loads boss tiles
Boss_WolfGaropaLoadTiles:                               ; DATA XREF: ROM:000040BE   o  ; was: sub_42A4
                addi.w  #$10,(word_FFE33E).w
                andi.w  #$F0,(word_FFE33E).w
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #$1E,d0
                move.w  word_42C2(pc,d0.w),(word_FFE33C).w
                rts
; End of function Boss_WolfGaropaLoadTiles
; ---------------------------------------------------------------------------
word_42C2:      dc.w 0, 2, $24, $46, $68, $8A, $AC, $CE
                dc.w $EC, $CA, $A8, $86, $64, $42, $20, 0


; Updates Sega screen palette based on state bit
Gfx_UpdateSega3Palette:                               ; DATA XREF: ROM:000040BC   o  ; was: sub_42E2
                movea.w #(word_FFE300-M68K_RAM),a0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4302
                move.w  #$EEE,4(a0)
                move.w  #$800,$1C(a0)
                move.w  #$E64,$1E(a0)
                rts
; ---------------------------------------------------------------------------
loc_4302:                               ; CODE XREF: Gfx_UpdateSega3Palette+A   j
                move.w  $84(a0),4(a0)
                move.w  $9C(a0),$1C(a0)
                move.w  $9E(a0),$1E(a0)
                rts
; End of function Gfx_UpdateSega3Palette
; Dispatches effect system handler based on current effect mode
Effect_SystemDispatcher:                               ; CODE XREF: Sys_GameplayMainLoop:loc_1C7B0   p  ; was: sub_4316
                tst.b   (byte_FF813E).w
                bpl.s Gfx_PaletteFadeDispatch
                rts
; ---------------------------------------------------------------------------
; Dispatches palette fade effects based on system state
Gfx_PaletteFadeDispatch:                               ; CODE XREF: Effect_SystemDispatcher+4   j  ; was: loc_431E
                move.w  (word_FF8222).w,d0
                movea.w off_432E(pc,d0.w),a0
                adda.l  #Palette_FadeEffect,a0
                jmp     (a0)
; End of function Effect_SystemDispatcher
; ---------------------------------------------------------------------------
off_432E:       dc.w locret_410A-Palette_FadeEffect
                dc.w Palette_FadeEffect-Palette_FadeEffect
                dc.w Gfx_Stage14PaletteMain-Palette_FadeEffect
                dc.w Gfx_PaletteFadeEffect-Palette_FadeEffect


; Palette fade effect system with RGB interpolation
Palette_FadeEffect:                               ; DATA XREF: Effect_SystemDispatcher+10   o  ; was: sub_4336
                                        ; ROM:off_432E   o ...
                movea.l (dword_FF821A).w,a2
                move.w  (word_FF8218).w,d0
                bsr.w Gfx_FadeRGBColor
                move.w  (word_FF8218).w,d0
                neg.w   d0
                bsr.w Gfx_FadeRGBColor
                btst    #0,(word_FFA000+1).w
                bne.s   locret_435E
                subq.w  #1,(word_FF8218).w
                bpl.s   locret_435E
                clr.w   (word_FF8222).w
locret_435E:                            ; CODE XREF: Palette_FadeEffect+1C   j
                                        ; Palette_FadeEffect+22   j
                rts
; End of function Palette_FadeEffect
; Main Stage 14 palette handler
Gfx_Stage14PaletteMain:                               ; DATA XREF: ROM:00004332   o  ; was: sub_4360
                bsr.w Gfx_ApplyRGBColorAdjust
                bra.w Gfx_UpdateStage14Palette
; End of function Gfx_Stage14PaletteMain
; Palette fade effect handler
Gfx_PaletteFadeEffect:                               ; DATA XREF: ROM:00004334   o  ; was: sub_4368
                btst    #0,(word_FFA000+1).w
                bne.s   loc_437A
                addq.w  #1,(dword_FF8066+2).w
                bne.s   loc_437A
                clr.w   (word_FF8222).w
loc_437A:                               ; CODE XREF: Gfx_PaletteFadeEffect+6   j
                                        ; Gfx_PaletteFadeEffect+C   j
                move.w  (dword_FF8066+2).w,d0
                jsr Gfx_SetFadeParams(pc)    ; (pc)
                bra.w Gfx_UpdateStage14Palette
; End of function Gfx_PaletteFadeEffect
; Update result numbers
Results_UpdateNumbers:                               ; CODE XREF: Results_UpdateTimeDisplay+18   j  ; was: sub_4386
                                        ; Results_DisplayStageNumber+10   p ...
                movea.w (word_FFF70E).w,a0
                moveq   #0,d5
                move.l  d0,(dword_FF8040).w
                move.w  d7,d2
                subq.w  #1,d2
                beq.w   loc_4484
                subq.w  #1,d2
                beq.w   loc_4466
                subq.w  #1,d2
                beq.w   loc_444A
                subq.w  #1,d2
                beq.w   loc_442C
                subq.w  #1,d2
                beq.w   loc_4410
                subq.w  #1,d2
                beq.w   loc_43F2
                subq.w  #1,d2
                beq.w   loc_43D6
                move.b  (dword_FF8040).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                bne.s   loc_43CE
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_43D6
; ---------------------------------------------------------------------------
loc_43CE:                               ; CODE XREF: Results_UpdateNumbers+40   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_43D6:                               ; CODE XREF: Results_UpdateNumbers+32   j
                                        ; Results_UpdateNumbers+46   j
                move.b  (dword_FF8040).w,d2
                andi.w  #$F,d2
                bne.s   loc_43EA
                tst.w   d5
                bne.s   loc_43EA
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_43F2
; ---------------------------------------------------------------------------
loc_43EA:                               ; CODE XREF: Results_UpdateNumbers+58   j
                                        ; Results_UpdateNumbers+5C   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_43F2:                               ; CODE XREF: Results_UpdateNumbers+2C   j
                                        ; Results_UpdateNumbers+62   j
                move.b  (dword_FF8040+1).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                bne.s   loc_4408
                tst.w   d5
                bne.s   loc_4408
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_4410
; ---------------------------------------------------------------------------
loc_4408:                               ; CODE XREF: Results_UpdateNumbers+76   j
                                        ; Results_UpdateNumbers+7A   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_4410:                               ; CODE XREF: Results_UpdateNumbers+26   j
                                        ; Results_UpdateNumbers+80   j
                move.b  (dword_FF8040+1).w,d2
                andi.w  #$F,d2
                bne.s   loc_4424
                tst.w   d5
                bne.s   loc_4424
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_442C
; ---------------------------------------------------------------------------
loc_4424:                               ; CODE XREF: Results_UpdateNumbers+92   j
                                        ; Results_UpdateNumbers+96   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_442C:                               ; CODE XREF: Results_UpdateNumbers+20   j
                                        ; Results_UpdateNumbers+9C   j
                move.b  (dword_FF8040+2).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                bne.s   loc_4442
                tst.w   d5
                bne.s   loc_4442
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_444A
; ---------------------------------------------------------------------------
loc_4442:                               ; CODE XREF: Results_UpdateNumbers+B0   j
                                        ; Results_UpdateNumbers+B4   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_444A:                               ; CODE XREF: Results_UpdateNumbers+1A   j
                                        ; Results_UpdateNumbers+BA   j
                move.b  (dword_FF8040+2).w,d2
                andi.w  #$F,d2
                bne.s   loc_445E
                tst.w   d5
                bne.s   loc_445E
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_4466
; ---------------------------------------------------------------------------
loc_445E:                               ; CODE XREF: Results_UpdateNumbers+CC   j
                                        ; Results_UpdateNumbers+D0   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_4466:                               ; CODE XREF: Results_UpdateNumbers+14   j
                                        ; Results_UpdateNumbers+D6   j
                move.b  (dword_FF8040+3).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                bne.s   loc_447C
                tst.w   d5
                bne.s   loc_447C
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_4484
; ---------------------------------------------------------------------------
loc_447C:                               ; CODE XREF: Results_UpdateNumbers+EA   j
                                        ; Results_UpdateNumbers+EE   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_4484:                               ; CODE XREF: Results_UpdateNumbers+E   j
                                        ; Results_UpdateNumbers+F4   j
                move.b  (dword_FF8040+3).w,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                movea.w (word_FFF70E).w,a0
                movea.w a0,a1
                move.w  d7,d2
                asl.w   #1,d2
                adda.w  d2,a1
                move.w  d7,d2
                subq.w  #1,d2
loc_44A2:                               ; CODE XREF: Results_UpdateNumbers+122   j
                move.w  (a0)+,d0
                addq.w  #1,d0
                move.w  d0,(a1)+
                dbf     d2,loc_44A2
                move.w  d7,d3
                bsr.w Gfx_BuildVDPCommandList
                addi.w  #$80,d4
                move.w  d7,d3
                bra.w Gfx_BuildVDPCommandList
; End of function Results_UpdateNumbers
; Converts 32-bit number to individual digit tiles for display
UI_ConvertNumberToDigits:
                movea.w (word_FFF70E).w,a0  ; was: sub_44BC
                movea.w (word_FFF70E).w,a1
                move.w  d7,d2
                asl.w   #1,d2
                adda.w  d2,a1
                move.l  d0,(dword_FF8040).w
                move.w  d7,d2
                subq.w  #1,d2
                beq.w   loc_4576
                subq.w  #1,d2
                beq.w   loc_4562
                subq.w  #1,d2
                beq.s   loc_4550
                subq.w  #1,d2
                beq.s   loc_453C
                subq.w  #1,d2
                beq.s   loc_452A
                subq.w  #1,d2
                beq.s   loc_4516
                subq.w  #1,d2
                beq.s   loc_4504
                move.b  (dword_FF8040).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_4504:                               ; CODE XREF: UI_ConvertNumberToDigits+32   j
                move.b  (dword_FF8040).w,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_4516:                               ; CODE XREF: UI_ConvertNumberToDigits+2E   j
                move.b  (dword_FF8040+1).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_452A:                               ; CODE XREF: UI_ConvertNumberToDigits+2A   j
                move.b  (dword_FF8040+1).w,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_453C:                               ; CODE XREF: UI_ConvertNumberToDigits+26   j
                move.b  (dword_FF8040+2).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_4550:                               ; CODE XREF: UI_ConvertNumberToDigits+22   j
                move.b  (dword_FF8040+2).w,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_4562:                               ; CODE XREF: UI_ConvertNumberToDigits+1C   j
                move.b  (dword_FF8040+3).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_4576:                               ; CODE XREF: UI_ConvertNumberToDigits+16   j
                move.b  (dword_FF8040+3).w,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
                move.w  d7,d3
                bsr.w Gfx_BuildVDPCommandList
                addi.w  #$80,d4
                move.w  d7,d3
; End of function UI_ConvertNumberToDigits
; Builds VDP command list for DMA operations in VRAM
Gfx_BuildVDPCommandList:                               ; CODE XREF: Results_UpdateNumbers+128   p  ; was: sub_4594
                                        ; Results_UpdateNumbers+132   j ...
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                move.w  d4,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009300,-(a1)
                move.b  d3,3(a1)
                move.w  a1,(word_FFF70C).w
                asl.w   #1,d3
                add.w   d3,(word_FFF70E).w
                rts
; End of function Gfx_BuildVDPCommandList
; Renders text string to VRAM using tile indices
UI_RenderTextString:                               ; CODE XREF: Results_RenderAllStats+32   p  ; was: sub_45D2
                                        ; Results_RenderAllStats+46   p ...
                movea.w (word_FFF70E).w,a1
                moveq   #0,d7
loc_45D8:                               ; CODE XREF: UI_RenderTextString+18   j
                moveq   #0,d2
                move.b  (a0)+,d2
                cmpi.b  #$FF,d2
                beq.s   loc_45EC
                asl.w   #1,d2
                add.w   d0,d2
                move.w  d2,(a1)+
                addq.w  #1,d7
                bra.s   loc_45D8
; ---------------------------------------------------------------------------
loc_45EC:                               ; CODE XREF: UI_RenderTextString+E   j
                move.w  d7,d3
                subq.w  #1,d3
                movea.w (word_FFF70E).w,a0
loc_45F4:                               ; CODE XREF: UI_RenderTextString+28   j
                move.w  (a0)+,d0
                addq.w  #1,d0
                move.w  d0,(a1)+
                dbf     d3,loc_45F4
                move.w  d7,d3
                bsr.w Gfx_BuildVDPCommandList
                addi.w  #$80,d4
                move.w  d4,d5
                andi.w  #$DFFF,d5
                move.w  d7,d3
                bra.w Gfx_BuildVDPCommandList
; End of function UI_RenderTextString
; Renders text string with plane wrapping support
UI_RenderTextStringWrapped:                               ; CODE XREF: RegionRestricted+3E   p  ; was: sub_4614
                                        ; RegionRestricted+52   p ...
                movea.w (word_FFF70E).w,a1
                moveq   #0,d7
loc_461A:                               ; CODE XREF: UI_RenderTextStringWrapped+18   j
                moveq   #0,d2
                move.b  (a0)+,d2
                cmpi.b  #$FF,d2
                beq.s   loc_462E
                asl.w   #1,d2
                add.w   d0,d2
                move.w  d2,(a1)+
                addq.w  #1,d7
                bra.s   loc_461A
; ---------------------------------------------------------------------------
loc_462E:                               ; CODE XREF: UI_RenderTextStringWrapped+E   j
                move.w  d7,d3
                subq.w  #1,d3
                movea.w (word_FFF70E).w,a0
loc_4636:                               ; CODE XREF: UI_RenderTextStringWrapped+28   j
                move.w  (a0)+,d0
                addq.w  #1,d0
                move.w  d0,(a1)+
                dbf     d3,loc_4636
                move.w  d7,d3
                bsr.w Gfx_BuildVDPCommandList
                addi.w  #$80,d4
                move.w  d4,d5
                andi.w  #$DFFF,d5
                cmpi.w  #$5000,d5
                bmi.s UI_FinalizeTileRendering
                subi.w  #$1000,d4
; Finalizes tile rendering after text string display
UI_FinalizeTileRendering:                               ; CODE XREF: UI_RenderTextStringWrapped+40   j  ; was: loc_465A
                move.w  d7,d3
                bra.w Gfx_BuildVDPCommandList
; End of function UI_RenderTextStringWrapped
; ---------------------------------------------------------------------------
byte_4660:      dc.b 0, 0, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: UI_UpdatePasswordDisplay+22   o
                dc.b 0, 0, 0, 0, 0, 0, 0, 0
                dc.b $FF
byte_4671:      dc.b $1C, 0, $F, 0, $B, 0, $E, 0, $23, $FF
                                        ; DATA XREF: UI_UpdatePasswordDisplay:loc_1E05A   o
                dc.b 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
byte_4687:      dc.b 1, 1               ; DATA XREF: Results_RenderAllStats+9C   o
                                        ; Results_RenderAllStats+C4   o
byte_4689:      dc.b 1, 1, $FF          ; DATA XREF: UI_RenderResultsHeaders+14   o
                                        ; Results_RenderScoreValues+32   o
byte_468C:      dc.b 1, 1, 1, 1, 1, 1, 1, 1, $1A, $1E, $1D, $FF
                                        ; DATA XREF: Results_RenderAllStats+4C   o
                                        ; Results_RenderAllStats+74   o
byte_4698:      dc.b $11, $B, $17, $F, 0, $1D, $1E, $B
                                        ; DATA XREF: UI_RenderTitleOption1   o
                dc.b $1C, $1E, $FF
byte_46A3:      dc.b $19, $1A, $1E, $13, $19, $18, $1D, $FF
                                        ; DATA XREF: UI_RenderTitleOption2   o
                                        ; UI_InitOptionsScreen+BE   o
byte_46AB:      dc.b $1A, $B, $1D, $1D, $21, $19, $1C, $E, $FF
                                        ; DATA XREF: UI_RenderTitleOption3   o
byte_46B4:      dc.b $20, $13, $1D, $1F, $B, $16, $1D, $12
                                        ; DATA XREF: UI_InitTitleScreen+CE   o
                dc.b $19, $D, $15, $29, 0, $1D, $1A, $F
                dc.b $F, $E, $1D, $12, $19, $D, $15, $29
                dc.b 0, $1D, $19, $1F, $18, $E, $1D, $12
                dc.b $19, $D, $15, $29, $FF
byte_46D9:      dc.b $18, $19, $21, 0, $13, $1D, 0, $1E
                                        ; DATA XREF: UI_InitTitleScreen+E2   o
                dc.b $13, $17, $F, 0, $1E, $19, 0, $1E
                dc.b $12, $F, 0, 7, 9, 1, 1, 1
                dc.b 0, $12, $F, $B, $1C, $1E, 0, $19
                dc.b $18, 0, $10, $13, $1C, $F, $29, $FF
byte_4701:      dc.b $10, $19, $1C, 0, $17, $F, $11, $B
                                        ; DATA XREF: UI_InitTitleScreen+F6   o
                dc.b $E, $1C, $13, $20, $F, $1C, $1D, 0
                dc.b $D, $1F, $1D, $1E, $19, $17, $FF
byte_4718:      dc.b 0, $2F, $1D, $F, $11, $B, 0, $F
                                        ; DATA XREF: UI_InitTitleScreen+10A   o
                dc.b $18, $1E, $F, $1C, $1A, $1C, $13, $1D
                dc.b $F, $1D, $26, $16, $1E, $E, $25, 2
                dc.b $A, $A, 6, $FF
byte_4734:      dc.b $16, $F, $20, $F, $16, $FF, $17, $F
                                        ; DATA XREF: UI_InitOptionsScreen+D2   o
                dc.b $1D, $1D, $B, $11, $F, 0, $1D, $21
                dc.b $13, $1E, $D, $12, $FF
byte_4749:      dc.b $C, $11, $17, 0, $1D, $21, $13, $1E
                                        ; DATA XREF: UI_InitOptionsScreen+E6   o
                dc.b $D, $12, $FF
byte_4754:      dc.b $1D, $26, $F, 0, $1D, $21, $13, $1E
                                        ; DATA XREF: UI_InitOptionsScreen+FA   o
                dc.b $D, $12, $FF
byte_475F:      dc.b $C, $11, $17, 0, $1E, $F, $1D, $1E
                                        ; DATA XREF: UI_InitOptionsScreen+10E   o
                dc.b $FF
byte_4768:      dc.b $1D, $26, $F, 0, $1E, $F, $1D, $1E
                                        ; DATA XREF: UI_InitOptionsScreen+122   o
                dc.b $FF
byte_4771:      dc.b $20, $19, $13, $D, $F, 0, $1E, $F
                                        ; DATA XREF: UI_InitOptionsScreen+136   o
                dc.b $1D, $1E, $FF
byte_477C:      dc.b $1A, $1C, $F, $1D, $1D, 0, $1D, $1E, $B, $1C
                                        ; DATA XREF: UI_InitOptionsScreen+14A   o
                                        ; UI_InitPasswordScreen+F6   o
                dc.b $1E, 0, $1E, $19, 0, $F, $22, $13, $1E, $FF
byte_4790:      dc.b $D, $19, $18, $1E, $13, $18, $1F, $F, $FF, $11
                                        ; DATA XREF: UI_RenderContinuePrompt+4   o
                dc.b $B, $17, $F, $F, $18, $E, $FF
byte_47A1:      dc.b $1D, $1E, $B, $11, $F, $2E, $FF
                                        ; DATA XREF: Results_RenderScoreValues   o
byte_47A8:      dc.b $1A, $B, $1D, $1D, $21, $19, $1C, $E
                                        ; DATA XREF: UI_RenderContinueText   o
                dc.b $2E, $FF
byte_47B2:      dc.b $D, $1C, $F, $E, $13, $1E, $2E, $FF
                                        ; DATA XREF: UI_RenderResultsHeaders   o
byte_47BA:      dc.b $16, $F, $20, $F, $16, $2E, $FF
                                        ; DATA XREF: Results_RenderScoreValues+46   o
byte_47C1:      dc.b $F, $B, $1D, $23, $FF
                                        ; DATA XREF: Results_RenderScoreValues+5A   o
byte_47C6:      dc.b $12, $B, $1C, $E, $FF, $C9, $CA, $CB
                                        ; DATA XREF: Results_RenderScoreValues+66   o
                dc.b $CC, $CD, $FF
byte_47D1:      dc.b $23, $19, $1F, 0, $16, $19, $1D, $1E
                                        ; DATA XREF: Password_InitializeScreen+7A   o
                dc.b 0, 4, $D, $12, $B, $18, $D, $F
                dc.b $1D, $25, $25, $25, $FF
byte_47E6:      dc.b $1E, $1C, $23, 0, $B, $11, $B, $13
                                        ; DATA XREF: Password_InitializeScreen+8E   o
                dc.b $18, $29, $29, $FF
byte_47F2:      dc.b $1A, $1C, $F, $1D, $1D, 0, $1D, $1E
                                        ; DATA XREF: Password_InitializeScreen+A2   o
                                        ; sub_1E430   o
                dc.b $B, $1C, $1E, $FF
byte_47FE:      dc.b $1C, $F, $1D, $1F, $16, $1E, $1D, $FF
                                        ; DATA XREF: Results_RenderAllStats+24   o
byte_4806:      dc.b $12, $13, $11, $12, 0, $1D, $D, $19
                                        ; DATA XREF: Results_RenderAllStats+38   o
                dc.b $1C, $F, $FF
byte_4811:      dc.b $1D, $D, $19, $1C, $F, $FF, $D, $19
                                        ; DATA XREF: Results_RenderAllStats+60   o
                dc.b $18, $1E, $13, $18, $1F, $F, $FF
byte_4820:      dc.b $E, $F, $1D, $1E, $1C, $19, $23, $F
                                        ; DATA XREF: Results_RenderAllStats+88   o
                dc.b $E, 0, $F, $18, $F, $17, $13, $F
                dc.b $1D, $FF
byte_4832:      dc.b $1A, $16, $B, $23, $F, $1C, 0, $E
                                        ; DATA XREF: Results_RenderAllStats+B0   o
                dc.b $B, $17, $B, $11, $F, $FF


; Clears scroll planes A/B and initializes display state
Gfx_ClearPlanesAndInit:                               ; DATA XREF: Sys_DispatchGameState+7A   o  ; was: sub_4840
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000001,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_4866:                               ; CODE XREF: Gfx_ClearPlanesAndInit+28   j
                move.w  d1,(a0)
                dbf     d0,loc_4866
                move    (sp)+,sr
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$60000002,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
; Clears scroll plane B and initializes game state variables
Gfx_ClearPlaneB:                               ; CODE XREF: Gfx_ClearPlanesAndInit+56   j  ; was: loc_4894
                move.w  d1,(a0)
                dbf d0,Gfx_ClearPlaneB
                move    (sp)+,sr
                clr.w   (word_FF00EC).l
                clr.w   (word_FF0178).l
                move.b  #4,(word_FFF7F4+1).w
                move.w  #$44,(word_FFF74A).w ; 'D'
                clr.w   (word_FFF74E).w
                clr.w   (word_FF0176).l
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA90C).w
                jsr (Gfx_SetupScrollPlanes).l
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; End of function Gfx_ClearPlanesAndInit
; ---------------------------------------------------------------------------
stru_48DA:      dc.w 7                  ; field_0
                                        ; DATA XREF: Gfx_FadeOutToDark+36   o
                dc.l tiles_18530A       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1885A4        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1889B0        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w $FFFF


; Main game loop for story screen mode
Sys_StoryScreenMainLoop:                               ; DATA XREF: Sys_DispatchGameState+7E   o  ; was: sub_48FC
                btst    #0,(word_FF80F4).w
                beq.s   loc_491C
                tst.w   (word_FF0176).l
                bne.s   loc_491C
                tst.w   (word_FFF720).w
                bmi.s   loc_491C
                btst    #7,(word_FFF708).w
                bne.w   loc_5102
loc_491C:                               ; CODE XREF: Sys_StoryScreenMainLoop+6   j
                                        ; Sys_StoryScreenMainLoop+E   j ...
                jsr (Gfx_UpdateScrollPosition).l
                jsr (Sys_InitObjectPointers).l
                jsr (UI_CheckVBlankFlag).l
                jsr (Sys_ProcessVisibleObjects).l
                bsr.w Sys_StoryScreenDispatcher
                bsr.w UI_StoryTextDispatcher
                bsr.w UI_JapaneseTextDispatcher
                jsr (Sys_UpdateObjectCount).l
                jsr (Sys_ProcessObjectList).l
                jsr (Gfx_FadePaletteTransition).l
                jsr (Gfx_SetupScrollPlanes).l
                addq.w  #1,(word_FFA000).w
                rts
; End of function Sys_StoryScreenMainLoop
; Dispatches story screen state machine based on timer
Sys_StoryScreenDispatcher:                               ; CODE XREF: Sys_StoryScreenMainLoop+38   p  ; was: sub_495E
                subq.w  #1,(word_FF0106).l
                move.w  (GameSubstateIndex).w,d0
                lea     off_4970(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Sys_StoryScreenDispatcher
; ---------------------------------------------------------------------------
off_4970:       dc.w Sys_InitStoryScreenTimer-*         ; DATA XREF: Sys_StoryScreenDispatcher+A   o
                dc.w UI_WaitForTimerAndButton-*
                dc.w Gfx_WaitForTimerAndResetFade-*
                dc.w Gfx_FadeOutToDark-*
                dc.w Gfx_FadeToTargetAndSetupScroll-*
                dc.w Gfx_WaitForFadeAndLoadTiles-*
                dc.w Gfx_FadeInFromDark-*
                dc.w UI_WaitForTimerShort-*
                dc.w Gfx_SetupTitleScreenLetters-*
                dc.w Gfx_AnimateLettersExpand-*
                dc.w Gfx_AnimateLettersExpandLarge-*
                dc.w Sys_TransitionToTitleScreen-*
                dc.w Sys_ExitStoryScreen-*


; Initializes story screen state timer
Sys_InitStoryScreenTimer:                               ; DATA XREF: ROM:off_4970   o  ; was: sub_498A
                move.w  #$2900,(word_FF0106).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Sys_InitStoryScreenTimer
; Waits for specific timer value then processes button input
UI_WaitForTimerAndButton:                               ; DATA XREF: ROM:00004972   o  ; was: sub_4998
                cmpi.w  #$18C0,(word_FF0106).l
                bne.w   locret_514E
                move.b  #1,d0
                jsr (Input_ProcessButtons).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function UI_WaitForTimerAndButton
; Waits for timer value then resets fade state
Gfx_WaitForTimerAndResetFade:                               ; DATA XREF: ROM:00004974   o  ; was: sub_49B4
                cmpi.w  #$1880,(word_FF0106).l
                bne.w   locret_514E
                move.w  #0,(word_FF0176).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_WaitForTimerAndResetFade
; Fades out palette to dark then loads new graphics data
Gfx_FadeOutToDark:                               ; DATA XREF: ROM:00004976   o  ; was: sub_49CE
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   locret_514E
                movea.l #stru_48DA,a0
                jsr (Data_ProcessPointer).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_FadeOutToDark
; Fades to target palette and sets up scrolling data
Gfx_FadeToTargetAndSetupScroll:                               ; DATA XREF: ROM:00004978   o  ; was: sub_4A16
                move.w  #$FFF2,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                tst.w   (word_FFF720).w
                bmi.w   locret_514E
                move.l  #dword_11346,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                clr.w   (dword_FFA908).w
                clr.w   (dword_FFA90C).w
                move.w  #0,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_FadeToTargetAndSetupScroll
; Waits for fade completion then loads tile data via DMA
Gfx_WaitForFadeAndLoadTiles:                               ; DATA XREF: ROM:0000497A   o  ; was: sub_4A5C
                move.w  #$FFF2,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   locret_514E
                lea     (word_B944).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                move.w  #$FFF2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.b  #$88,d0
                jsr (Input_ProcessButtons).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_WaitForFadeAndLoadTiles
; Fades in palette from dark to normal brightness
Gfx_FadeInFromDark:                               ; DATA XREF: ROM:0000497C   o  ; was: sub_4ACE
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_514E
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   locret_514E
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_FadeInFromDark
; Waits for short timer value then processes input
UI_WaitForTimerShort:                               ; DATA XREF: ROM:0000497E   o  ; was: sub_4B08
                cmpi.w  #$80,(word_FF0106).l
                bne.w   locret_514E
                move.b  #1,d0
                jsr (Input_ProcessButtons).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function UI_WaitForTimerShort
; Sets up VDP for title screen letter animation via DMA
Gfx_SetupTitleScreenLetters:                               ; DATA XREF: ROM:00004980   o  ; was: sub_4B24
                tst.w   (word_FF0106).l
                bne.w   locret_514E
                move.b  #4,d0
                jsr (Input_ProcessButtons).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.b  #0,(word_FFF7F4+1).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #0,(word_FFF7E6+1).w
                move.w  #$4000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr (VDP_SetupDMA).l
                move.w  #$6000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr (VDP_SetupDMA).l
                lea     (VDP_CTRL).l,a0
                lea     (VDP_DATA).l,a1
                move.w  #$8F02,(a0)
                move.l  #$40000000,(a0)
                clr.w   d0
                move.w  #$1F,d1
loc_4B96:                               ; CODE XREF: Gfx_SetupTitleScreenLetters+74   j
                move.w  d0,(a1)
                dbf     d1,loc_4B96
                movea.l #byte_BA4A,a0
                jsr     (LoadPalette).l
                move.w  #$8300,d0
                move.w  #$4680,d4
                movea.l #byte_4CCC,a0
                jsr (UI_RenderTextStringWrapped).l
                move.w  #$3C,(word_FFF74A).w ; '<'
                clr.w   (word_FFF74E).w
                move.w  #$21,(word_FF0108).l ; '!'
                clr.w   (word_FF010C).l
                bsr.w Gfx_SetTitlePaletteColors
                move.w  #$10,(word_FF8090).w
                move.w  #$C,(word_FF010A).l
                lea     (word_FF1000).l,a0
                moveq   #0,d1
                move.w  #$77F,d0
loc_4BF2:                               ; CODE XREF: Gfx_SetupTitleScreenLetters+D0   j
                move.l  d1,(a0)+
                dbf     d0,loc_4BF2
                move.l  #byte_4CF5,(dword_FF0100).l
                movea.l (dword_FF0100).l,a0
                moveq   #0,d0
                move.b  (a0)+,d0
                move.l  a0,(dword_FF0100).l
                lsl.w   #6,d0
                addi.l  #tiles_font,d0
                movea.l d0,a0
                lea     (byte_FF2380).l,a1
                move.w  #$3F,d0 ; '?'
loc_4C26:                               ; CODE XREF: Gfx_SetupTitleScreenLetters+11E   j
                move.b  (a0),d1
                andi.b  #$F0,d1
                move.b  d1,d2
                lsr.b   #4,d1
                or.b    d2,d1
                move.b  d1,(a1)+
                move.b  (a0)+,d1
                andi.b  #$F,d1
                move.b  d1,d2
                lsl.b   #4,d1
                or.b    d2,d1
                move.b  d1,(a1)+
                dbf     d0,loc_4C26
                lea     (word_FFE382).w,a0
                move.w  #2,(a0)+
                move.w  #$A,d1
                move.w  d1,(a0)+
                move.w  d1,(a0)+
                move.w  d1,(a0)+
                move.w  d1,(a0)+
                move    sr,-(sp)
                move    #$2700,sr
loc_4C60:                               ; CODE XREF: Gfx_SetupTitleScreenLetters+144   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_4C60
                lea     (VDP_CTRL).l,a0
                move.w  (word_FFF7D2).w,d0
                bset    #4,d0
                move.w  d0,(a0)
                move.w  #$8F02,(a0)
                move.l  #$93009405,(a0)
                move.w  #$9500,(a0)
                move.w  #$9688,(a0)
                move.w  #$977F,(a0)
                move.l  #$60000081,(VDPCommand).w ; DO_WRITE_TO_VRAM_AT_$6000_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
                move.w  (word_FFF7D2).w,d0
                bclr    #4,d0
                move.w  d0,(a0)
; Releases Z80 bus control and advances state machine
Sys_ReleaseZ80BusAndAdvance:                               ; CODE XREF: Gfx_SetupTitleScreenLetters+18E   j  ; was: loc_4CAA
                bclr    #0,(IO_Z80BUS).l
                beq.s Sys_ReleaseZ80BusAndAdvance
                move    (sp)+,sr
                move    #$2300,sr
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_SetupTitleScreenLetters
; ---------------------------------------------------------------------------
byte_4CCC:      dc.b 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
                                        ; DATA XREF: Gfx_SetupTitleScreenLetters+8C   o
                dc.b $A, $B, $C, $D, $E, $F, $10, $11, $12, $13
                dc.b $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D
                dc.b $1E, $1F, $20, $21, $22, $23, $24, $25, $26, $27
                dc.b $FF
byte_4CF5:      dc.b $B, $16, $13, $F, $18, $1D, $19, $16, $E, $13
                                        ; DATA XREF: Gfx_SetupTitleScreenLetters+D4   o
                dc.b $F, $1C, $FF


; Sets palette colors for title screen based on state
Gfx_SetTitlePaletteColors:                               ; CODE XREF: Gfx_SetupTitleScreenLetters+B0   p  ; was: sub_4D02
                                        ; Gfx_AnimateLettersExpand+12   p ...
                lea     (word_FFE302).w,a0
                move.w  (word_FF010C).l,d0
                move.w  word_4D30(pc,d0.w),(a0)+
                move.w  word_4D1E(pc,d0.w),d1
                move.w  d1,(a0)+
                move.w  d1,(a0)+
                move.w  d1,(a0)+
                move.w  d1,(a0)+
                rts
; End of function Gfx_SetTitlePaletteColors
; ---------------------------------------------------------------------------
word_4D1E:      dc.w $EEE, $CCE, $AAE, $88C, $66C, $44C, $22A, $A, $A
word_4D30:      dc.w $666, $666, $666, $444, $444, $224, $222, 2, 2


; Animates expanding letter effect for title screen
Gfx_AnimateLettersExpand:                               ; DATA XREF: ROM:00004982   o  ; was: sub_4D42
                cmpi.w  #1,(word_FF0108).l
                beq.w   loc_4E96
                addq.w  #2,(word_FF010C).l
                bsr.w Gfx_SetTitlePaletteColors
                subq.w  #4,(word_FF0108).l
                lea     (word_FF1000).l,a0
                moveq   #0,d1
                move.w  #$27F,d0
loc_4D6A:                               ; CODE XREF: Gfx_AnimateLettersExpand+2A   j
                move.l  d1,(a0)+
                dbf     d0,loc_4D6A
                lea     (byte_FF2384).l,a0
                lea     (off_FF14C3).l,a1
                lea     (off_FF14C3).l,a2
                move.w  (word_FF0108).l,d4
                addq.w  #1,d4
                lsr.w   #1,d4
                subq.w  #1,d4
                move.w  #$F,d6
loc_4D92:                               ; CODE XREF: Gfx_AnimateLettersExpand+84   j
                move.w  #3,d5
loc_4D96:                               ; CODE XREF: Gfx_AnimateLettersExpand+76   j
                move.b  -(a0),d1
                move.w  d4,d3
loc_4D9A:                               ; CODE XREF: Gfx_AnimateLettersExpand+72   j
                move.b  d1,(a1)
                move.w  a1,d7
                andi.w  #3,d7
                bne.s   loc_4DB2
                suba.l  #$3C,a1 ; '<'
                cmpa.l  #$FFFF1000,a1
                bcs.s   loc_4DBC
loc_4DB2:                               ; CODE XREF: Gfx_AnimateLettersExpand+60   j
                subq.l  #1,a1
                dbf     d3,loc_4D9A
                dbf     d5,loc_4D96
loc_4DBC:                               ; CODE XREF: Gfx_AnimateLettersExpand+6E   j
                adda.l  #$C,a0
                addq.l  #4,a2
                movea.l a2,a1
                dbf     d6,loc_4D92
                lea     (byte_FF2384).l,a0
                lea     (word_FF1500).l,a1
                lea     (word_FF1500).l,a2
                move.w  (word_FF0108).l,d4
                addq.w  #1,d4
                lsr.w   #1,d4
                subq.w  #1,d4
                move.w  #$F,d6
loc_4DEC:                               ; CODE XREF: Gfx_AnimateLettersExpand+DA   j
                move.w  #3,d5
loc_4DF0:                               ; CODE XREF: Gfx_AnimateLettersExpand+D0   j
                move.b  (a0)+,d1
                move.b  d1,d2
                move.w  d4,d3
loc_4DF6:                               ; CODE XREF: Gfx_AnimateLettersExpand:loc_4E0E   j
                move.b  d1,(a1)+
                move.w  a1,d7
                andi.w  #3,d7
                bne.s   loc_4E0E
                adda.l  #$3C,a1 ; '<'
                cmpa.l  #$FFFF1A00,a1
                bcc.s   loc_4E16
loc_4E0E:                               ; CODE XREF: Gfx_AnimateLettersExpand+BC   j
                dbf     d3,loc_4DF6
                dbf     d5,loc_4DF0
loc_4E16:                               ; CODE XREF: Gfx_AnimateLettersExpand+CA   j
                addq.l  #4,a0
                addq.l  #4,a2
                movea.l a2,a1
                dbf     d6,loc_4DEC
loc_4E20:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+106   j
                lea     (word_FF9CE0).w,a0
                move.w  #$70,d0 ; 'p'
                move.w  #$70,d1 ; 'p'
loc_4E2C:                               ; CODE XREF: Gfx_AnimateLettersExpand+104   j
                move.w  (word_FF0108).l,d3
loc_4E32:                               ; CODE XREF: Gfx_AnimateLettersExpand+FE   j
                move.w  d0,d4
                sub.w   d1,d4
                move.w  d4,(a0)+
                addq.w  #1,d1
                cmpi.w  #$E0,d1
                beq.s   loc_4E4A
                dbf     d3,loc_4E32
                addq.w  #1,d0
                bra.w   loc_4E2C
; ---------------------------------------------------------------------------
loc_4E4A:                               ; CODE XREF: Gfx_AnimateLettersExpand+FC   j
                lea     (word_FF9CE0).w,a0
                move.w  #$6F,d0 ; 'o'
                move.w  #$6F,d1 ; 'o'
loc_4E56:                               ; CODE XREF: Gfx_AnimateLettersExpand+12A   j
                move.w  (word_FF0108).l,d3
loc_4E5C:                               ; CODE XREF: Gfx_AnimateLettersExpand+124   j
                move.w  d0,d4
                sub.w   d1,d4
                move.w  d4,-(a0)
                subq.w  #1,d1
                bmi.s   loc_4E70
                dbf     d3,loc_4E5C
                subq.w  #1,d0
                bra.w   loc_4E56
; ---------------------------------------------------------------------------
loc_4E70:                               ; CODE XREF: Gfx_AnimateLettersExpand+122   j
                movea.w (word_FFF70C).w,a0
                suba.w  #$10,a0
                move.w  a0,(word_FFF70C).w
                move.l  #$94059300,(a0)+
                move.l  #$8F02977F,(a0)+
                move.l  #$96889500,(a0)+
                move.l  #$60000081,(a0)+
                rts
; ---------------------------------------------------------------------------
loc_4E96:                               ; CODE XREF: Gfx_AnimateLettersExpand+8   j
                move.b  #$12,d0
                jsr (Sound_PlaySFX).l
                move.w  #$21,(word_FF0108).l ; '!'
                clr.w   (word_FF010C).l
                lea     (word_FF1000).l,a0
                moveq   #0,d1
                move.w  #$27F,d0
loc_4EBA:                               ; CODE XREF: Gfx_AnimateLettersExpand+17A   j
                move.l  d1,(a0)+
                dbf     d0,loc_4EBA
                subq.w  #1,(word_FF010A).l
                beq.w   loc_4F10
                movea.l (dword_FF0100).l,a0
                moveq   #0,d0
                move.b  (a0)+,d0
                move.l  a0,(dword_FF0100).l
                lsl.w   #6,d0
                addi.l  #tiles_font,d0
                movea.l d0,a0
                lea     (byte_FF2380).l,a1
                move.w  #$3F,d0 ; '?'
loc_4EEE:                               ; CODE XREF: Gfx_AnimateLettersExpand+1C8   j
                move.b  (a0),d1
                andi.b  #$F0,d1
                move.b  d1,d2
                lsr.b   #4,d1
                or.b    d2,d1
                move.b  d1,(a1)+
                move.b  (a0)+,d1
                andi.b  #$F,d1
                move.b  d1,d2
                lsl.b   #4,d1
                or.b    d2,d1
                move.b  d1,(a1)+
                dbf     d0,loc_4EEE
                rts
; ---------------------------------------------------------------------------
loc_4F10:                               ; CODE XREF: Gfx_AnimateLettersExpand+184   j
                lea     (byte_FF2080).l,a1
                movea.l #byte_4FC8,a2
                move.w  #$C,d3
loc_4F20:                               ; CODE XREF: Gfx_AnimateLettersExpand+210   j
                moveq   #0,d0
                move.b  (a2)+,d0
                lsl.w   #6,d0
                addi.l  #tiles_font,d0
                movea.l d0,a0
                move.w  #$3F,d0 ; '?'
loc_4F32:                               ; CODE XREF: Gfx_AnimateLettersExpand+20C   j
                move.b  (a0),d1
                andi.b  #$F0,d1
                move.b  d1,d2
                lsr.b   #4,d1
                or.b    d2,d1
                move.b  d1,(a1)+
                move.b  (a0)+,d1
                andi.b  #$F,d1
                move.b  d1,d2
                lsl.b   #4,d1
                or.b    d2,d1
                move.b  d1,(a1)+
                dbf     d0,loc_4F32
                dbf     d3,loc_4F20
                move    sr,-(sp)
                move    #$2700,sr
loc_4F5C:                               ; CODE XREF: Gfx_AnimateLettersExpand+222   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_4F5C
                lea     (VDP_CTRL).l,a0
                move.w  (word_FFF7D2).w,d0
                bset    #4,d0
                move.w  d0,(a0)
                move.w  #$8F02,(a0)
                move.l  #$93009405,(a0)
                move.w  #$9500,(a0)
                move.w  #$9688,(a0)
                move.w  #$977F,(a0)
                move.l  #$60000081,(VDPCommand).w ; DO_WRITE_TO_VRAM_AT_$6000_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
                move.w  (word_FFF7D2).w,d0
                bclr    #4,d0
                move.w  d0,(a0)
; Completes Z80 bus release and advances to next state
Sys_CompleteZ80BusReleaseAndAdvance:                               ; CODE XREF: Gfx_AnimateLettersExpand+26C   j  ; was: loc_4FA6
                bclr    #0,(IO_Z80BUS).l
                beq.s Sys_CompleteZ80BusReleaseAndAdvance
                move    (sp)+,sr
                move    #$2300,sr
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_AnimateLettersExpand
; ---------------------------------------------------------------------------
byte_4FC8:      dc.b $B, $16, $13, $F, $18, 0, $1D, $19, $16, $E, $13, $F, $1C, $FF
                                        ; DATA XREF: Gfx_AnimateLettersExpand+1D4   o


; Animates large expanding letter effect with scrolling
Gfx_AnimateLettersExpandLarge:                               ; DATA XREF: ROM:00004984   o  ; was: sub_4FD6
                cmpi.w  #1,(word_FF0108).l
                beq.w   loc_50E0
                addq.w  #2,(word_FF010C).l
                bsr.w Gfx_SetTitlePaletteColors
                subq.w  #4,(word_FF0108).l
                lea     (word_FF1000).l,a0
                moveq   #0,d1
                move.w  #$27F,d0
loc_4FFE:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+2A   j
                move.l  d1,(a0)+
                dbf     d0,loc_4FFE
                lea     (byte_FF2384).l,a0
                movea.l a0,a2
                lea     (off_FF14C3).l,a1
                movea.l a1,a3
                move.w  (word_FF0108).l,d4
                addq.w  #1,d4
                lsr.w   #1,d4
                subq.w  #1,d4
                move.w  #$F,d6
loc_5024:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+96   j
                move.w  #$33,d5 ; '3'
loc_5028:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge:loc_5060   j
                move.b  -(a0),d1
                move.w  d4,d3
loc_502C:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+70   j
                move.b  d1,(a1)
                move.w  a1,d7
                andi.w  #3,d7
                bne.s   loc_5044
                suba.l  #$3C,a1 ; '<'
                cmpa.l  #$FFFF1000,a1
                bcs.s   loc_5064
loc_5044:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+5E   j
                subq.l  #1,a1
                dbf     d3,loc_502C
                move.w  a0,d7
                andi.w  #7,d7
                bne.s   loc_5060
                suba.l  #$78,a0 ; 'x'
                cmpa.l  #$FFFF1A00,a0
                bcs.s   loc_5064
loc_5060:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+7A   j
                dbf     d5,loc_5028
loc_5064:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+6C   j
                                        ; Gfx_AnimateLettersExpandLarge+88   j
                addq.l  #8,a2
                movea.l a2,a0
                addq.l  #4,a3
                movea.l a3,a1
                dbf     d6,loc_5024
                lea     (byte_FF2384).l,a0
                movea.l a0,a2
                lea     (word_FF1500).l,a1
                movea.l a1,a3
                move.w  (word_FF0108).l,d4
                addq.w  #1,d4
                lsr.w   #1,d4
                subq.w  #1,d4
                move.w  #$F,d6
loc_5090:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+102   j
                move.w  #$33,d5 ; '3'
loc_5094:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge:loc_50CC   j
                move.b  (a0)+,d1
                move.b  d1,d2
                move.w  d4,d3
loc_509A:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge:loc_50B2   j
                move.b  d1,(a1)+
                move.w  a1,d7
                andi.w  #3,d7
                bne.s   loc_50B2
                adda.l  #$3C,a1 ; '<'
                cmpa.l  #$FFFF1A00,a1
                bcc.s   loc_50D0
loc_50B2:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+CC   j
                dbf     d3,loc_509A
                move.w  a0,d7
                andi.w  #7,d7
                bne.s   loc_50CC
                adda.l  #$78,a0 ; 'x'
                cmpa.l  #$FFFF2E00,a0
                bcc.s   loc_50D0
loc_50CC:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+E6   j
                dbf     d5,loc_5094
loc_50D0:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+DA   j
                                        ; Gfx_AnimateLettersExpandLarge+F4   j
                addq.l  #8,a2
                movea.l a2,a0
                addq.l  #4,a3
                movea.l a3,a1
                dbf     d6,loc_5090
                bra.w   loc_4E20
; ---------------------------------------------------------------------------
loc_50E0:                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+8   j
                move.b  #$38,d0 ; '8'
                jsr (Sound_PlaySFX).l
                move.w  #$1C0,(word_FF0106).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_AnimateLettersExpandLarge
; Transitions from story screen to title screen
Sys_TransitionToTitleScreen:                               ; DATA XREF: ROM:00004986   o  ; was: sub_50F8
                subq.w  #1,(word_FF0106).l
                bne.w   locret_514E
loc_5102:                               ; CODE XREF: Sys_StoryScreenMainLoop+1C   j
                                        ; Effect_UpdateGameRotation+44   j
                bclr    #0,(word_FF80F4).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                move.b  #1,d0
                jsr (Input_ProcessButtons).l
                move.w  #$18,(GameSubstateIndex).w
                rts
; End of function Sys_TransitionToTitleScreen
; Exits story screen and returns to mode select
Sys_ExitStoryScreen:                               ; DATA XREF: ROM:00004988   o  ; was: sub_5130
                bclr    #1,(word_FF80F4).w
                beq.w   locret_514E
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
locret_514E:                            ; CODE XREF: UI_WaitForTimerAndButton+8   j
                                        ; Gfx_WaitForTimerAndResetFade+8   j ...
                rts
; End of function Sys_ExitStoryScreen
; Dispatches planet rotation cutscene state machine using jump table
Cutscene_PlanetDispatcher:
                move.w  (word_FF00EE).l,d0  ; was: sub_5150
                lea     off_515E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_PlanetDispatcher
; ---------------------------------------------------------------------------
off_515E:       dc.w Cutscene_InitPlanetState-*         ; DATA XREF: Cutscene_PlanetDispatcher+6   o
                dc.w Cutscene_SetupPlanetRotate-*
                dc.w Cutscene_PlanetZoomIn-*
                dc.w Cutscene_PlanetHold-*
                dc.w Cutscene_PlanetZoomOut-*
                dc.w Cutscene_PlanetZoomOut-*
                dc.w Cutscene_InitPlanetZoomIn-*
                dc.w Cutscene_PlanetFadeOutAlt-*
                dc.w Cutscene_UpdatePlanetGraphics-*
                dc.w Cutscene_PlanetFadeInAlt-*
                dc.w nullsub_15-*


; Initializes planet cutscene state machine and advances state index
Cutscene_InitPlanetState:                               ; DATA XREF: ROM:off_515E   o  ; was: sub_5174
                move.w  #1,(word_FF00F2).l
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_InitPlanetState
; Sets up planet rotation cutscene with sprite parameters and VDP settings
Cutscene_SetupPlanetRotate:                               ; DATA XREF: ROM:00005160   o  ; was: sub_5184
                subq.w  #1,(word_FF00F2).l
                bne.w   locret_514E
                lea     (word_FFC9E0).w,a5
                move.w  #$CC00,word_FFC9E2-word_FFC9E0(a5)
                move.w  #$10,(a5)
                move.l  #word_189D38,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$C0,$10(a5)
                move.w  #$120,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$4E0,(word_FF00DC).l
                move.w  #$120,(word_FF00D4).l
                move.w  #$C0,(word_FF00D6).l
                move.w  #1,(word_FF00D8).l
                move.w  #3,(word_FF00DA).l
                move.l  #$5C000002,(dword_FF00C0).l
                move.w  #$F,(word_FF00C4).l
                move.w  #3,(word_FF00C8).l
                clr.w   (word_FF00C6).l
                jsr Cutscene_PlanetRotate(pc)    ; (pc)
                nop
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_SetupPlanetRotate
; Animates planet zooming in with rotation and palette fade out
Cutscene_PlanetZoomIn:                               ; DATA XREF: ROM:00005162   o  ; was: sub_5214
                addi.l  #$80,(dword_FFC9F8).w
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_FadeOutPalette
                bsr.w Gfx_UpdatePlanetPalette
                cmpi.w  #$40,(word_FF00C6).l ; '@'
                bne.w   locret_514E
                move.w  #$80,(word_FF00F2).l
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_PlanetZoomIn
; Holds planet rotation during cutscene while timer counts down
Cutscene_PlanetHold:                               ; DATA XREF: ROM:00005164   o  ; was: sub_5244
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_UpdatePlanetPalette
                subq.w  #1,(word_FF00F2).l
                bne.w   locret_514E
; End of function Cutscene_PlanetHold
; Advances planet cutscene to next state by incrementing state index
Cutscene_AdvancePlanetState:
                addq.w  #2,(word_FF00EE).l  ; was: sub_5256
                rts
; End of function Cutscene_AdvancePlanetState
; Animates planet zooming out with reverse rotation and palette fade in
Cutscene_PlanetZoomOut:                               ; DATA XREF: ROM:00005166   o  ; was: sub_525E
                                        ; ROM:00005168   o
                subi.l  #$80,(dword_FFC9F8).w
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_UpdateVDPRegistersWithMask
                bsr.w Gfx_UpdatePlanetPalette
                tst.w   (word_FF00C6).l
                bpl.w   locret_514E
                clr.l   (dword_FFC9F8).w
                move.w  #$100,(word_FF00F2).l
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_PlanetZoomOut
; Initializes planet zoom-in animation during Sega screen cutscene
Cutscene_InitPlanetZoomIn:                               ; DATA XREF: ROM:0000516A   o  ; was: sub_5290
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_UpdatePlanetPalette
                subq.w  #1,(word_FF00F2).l
                bne.w   locret_514E
                lea     (word_FFC9E0).w,a5
                move.w  #$CC00,word_FFC9E2-word_FFC9E0(a5)
                move.w  #$10,(a5)
                move.l  #word_189DBC,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$180,$10(a5)
                move.w  #$120,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                andi.w  #$7FFF,(word_FFC9E2).w
                move.w  #$4E0,(word_FF00DC).l
                move.w  #$120,(word_FF00D4).l
                move.w  #$180,(word_FF00D6).l
                move.w  #3,(word_FF00D8).l
                move.w  #1,(word_FF00DA).l
                move.l  #$5C000002,(dword_FF00C0).l
                move.w  #$F,(word_FF00C4).l
                move.w  #3,(word_FF00C8).l
                clr.w   (word_FF00C6).l
                jsr Cutscene_PlanetRotate(pc)    ; (pc)
                nop
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_InitPlanetZoomIn
; Fades out planet during Sega screen cutscene (alternate)
Cutscene_PlanetFadeOutAlt:                               ; DATA XREF: ROM:0000516C   o  ; was: sub_532E
                ori.w   #$8000,(word_FFC9E2).w
                subi.l  #$40,(dword_FFC9FC).w ; '@'
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_FadeOutPalette
                bsr.w Gfx_UpdatePlanetPalette
                cmpi.w  #$40,(word_FF00C6).l ; '@'
                bne.w   locret_514E
; End of function Cutscene_PlanetFadeOutAlt
; Sets delay timer to $80 frames and advances cutscene state
Cutscene_SetDelayAndAdvance:
                move.w  #$80,(word_FF00F2).l  ; was: sub_5354
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_SetDelayAndAdvance
; Updates planet graphics during cutscene
Cutscene_UpdatePlanetGraphics:                               ; DATA XREF: ROM:0000516E   o  ; was: sub_5364
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_UpdatePlanetPalette
; End of function Cutscene_UpdatePlanetGraphics
; Waits for delay timer to expire before advancing cutscene state
Cutscene_WaitDelayTimer:
                subq.w  #1,(word_FF00F2).l  ; was: sub_536C
                bne.w   locret_514E
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_WaitDelayTimer
; Fades in planet during Sega screen cutscene (alternate)
Cutscene_PlanetFadeInAlt:                               ; DATA XREF: ROM:00005170   o  ; was: sub_537E
                addi.l  #$40,(dword_FFC9FC).w ; '@'
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_UpdateVDPRegistersWithMask
                bsr.w Gfx_UpdatePlanetPalette
                tst.w   (word_FF00C6).l
                bpl.w   locret_514E
                clr.w   (word_FFC9E2).w
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_PlanetFadeInAlt
nullsub_15:                             ; DATA XREF: ROM:00005172   o
                rts
; End of function nullsub_15


; State machine dispatcher for second cutscene sequence
Cutscene_StateMachine2:
                move.w  (word_FF00F0).l,d0  ; was: sub_53AA
                lea     off_53B8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_StateMachine2
; ---------------------------------------------------------------------------
off_53B8:       dc.w Cutscene_InitShipDelay-*         ; DATA XREF: Cutscene_StateMachine2+6   o
                dc.w Cutscene_InitShipSprite-*
                dc.w Cutscene_ShipFadeOut-*
                dc.w Cutscene_WaitShipDelay-*
                dc.w Cutscene_ShipFadeIn-*
                dc.w Cutscene_InitShipSprite2-*
                dc.w Cutscene_ShipZoomIn-*
                dc.w Cutscene_WaitShipDelay2-*
                dc.w Cutscene_ShipZoomOut-*
                dc.w nullsub_16-*


; Initializes delay timer to $100 frames for ship animation
Cutscene_InitShipDelay:                               ; DATA XREF: ROM:off_53B8   o  ; was: sub_53CC
                move.w  #$100,(word_FF00F4).l
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_InitShipDelay
; Initializes ship sprite data during Sega screen cutscene
Cutscene_InitShipSprite:                               ; DATA XREF: ROM:000053BA   o  ; was: sub_53DC
                subq.w  #1,(word_FF00F4).l
                bne.w   locret_514E
                lea     (word_FFCA40).w,a5
                move.w  #$CC00,word_FFCA42-word_FFCA40(a5)
                move.w  #$10,(a5)
                move.l  #word_189D8C,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$180,$10(a5)
                move.w  #$C0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$4F0,(word_FF00E6).l
                move.w  #$C0,(word_FF00DE).l
                move.w  #$180,(word_FF00E0).l
                move.w  #1,(word_FF00E2).l
                move.w  #3,(word_FF00E4).l
                move.l  #$5E000002,(dword_FF00CA).l
                move.w  #$F,(word_FF00CE).l
                move.w  #3,(word_FF00D2).l
                clr.w   (word_FF00D0).l
                jsr Cutscene_ClearSpriteBuffer(pc)    ; (pc)
                nop
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_InitShipSprite
; Fades out ship sprite during cutscene
Cutscene_ShipFadeOut:                               ; DATA XREF: ROM:000053BC   o  ; was: sub_546C
                subi.l  #$80,(dword_FFCA58).w
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Cutscene_FadeOutShip
                bsr.w Gfx_UpdateShipPalette
                cmpi.w  #$40,(word_FF00D0).l ; '@'
                bne.w   locret_514E
                move.w  #$80,(word_FF00F4).l
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_ShipFadeOut
; Updates ship graphics and waits for delay timer
Cutscene_WaitShipDelay:                               ; DATA XREF: ROM:000053BE   o  ; was: sub_549C
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Gfx_UpdateShipPalette
                subq.w  #1,(word_FF00F4).l
                bne.w   locret_514E
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_WaitShipDelay
; Fades in ship sprite during cutscene
Cutscene_ShipFadeIn:                               ; DATA XREF: ROM:000053C0   o  ; was: sub_54B6
                addi.l  #$80,(dword_FFCA58).w
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Cutscene_FadeInShip
                bsr.w Gfx_UpdateShipPalette
                tst.w   (word_FF00D0).l
                bpl.w   locret_514E
                clr.l   (dword_FFCA58).w
                move.w  #$100,(word_FF00F4).l
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_ShipFadeIn
; Initializes second ship sprite configuration
Cutscene_InitShipSprite2:                               ; DATA XREF: ROM:000053C2   o  ; was: sub_54E8
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Gfx_UpdateShipPalette
                subq.w  #1,(word_FF00F4).l
                bne.w   locret_514E
                lea     (word_FFCA40).w,a5
                move.w  #$CC00,word_FFCA42-word_FFCA40(a5)
                move.w  #$10,(a5)
                move.l  #word_189DEC,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$C0,$10(a5)
                move.w  #$C0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                andi.w  #$7FFF,(word_FFCA42).w
                move.w  #$4F0,(word_FF00E6).l
                move.w  #$C0,(word_FF00DE).l
                move.w  #$C0,(word_FF00E0).l
                move.w  #3,(word_FF00E2).l
                move.w  #1,(word_FF00E4).l
                move.l  #$5E000002,(dword_FF00CA).l
                move.w  #$F,(word_FF00CE).l
                move.w  #3,(word_FF00D2).l
                clr.w   (word_FF00D0).l
                jsr Cutscene_ClearSpriteBuffer(pc)    ; (pc)
                nop
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_InitShipSprite2
; Zooms in ship sprite by increasing rotation value
Cutscene_ShipZoomIn:                               ; DATA XREF: ROM:000053C4   o  ; was: sub_5586
                ori.w   #$8000,(word_FFCA42).w
                addi.l  #$40,(dword_FFCA5C).w ; '@'
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Cutscene_FadeOutShip
                bsr.w Gfx_UpdateShipPalette
                cmpi.w  #$40,(word_FF00D0).l ; '@'
                bne.w   locret_514E
                move.w  #$80,(word_FF00F4).l
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_ShipZoomIn
; Updates ship graphics and waits for delay timer
Cutscene_WaitShipDelay2:                               ; DATA XREF: ROM:000053C6   o  ; was: sub_55BC
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Gfx_UpdateShipPalette
                subq.w  #1,(word_FF00F4).l
                bne.w   locret_514E
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_WaitShipDelay2
; Zooms out ship sprite by decreasing rotation value
Cutscene_ShipZoomOut:                               ; DATA XREF: ROM:000053C8   o  ; was: sub_55D6
                subi.l  #$40,(dword_FFCA5C).w ; '@'
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Cutscene_FadeInShip
                bsr.w Gfx_UpdateShipPalette
                tst.w   (word_FF00D0).l
                bpl.w   locret_514E
                clr.w   (word_FFCA42).w
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_ShipZoomOut
nullsub_16:                             ; DATA XREF: ROM:000053CA   o
                rts
; End of function nullsub_16


; State machine dispatcher for star field animation
Cutscene_StateMachine3:
                move.w  (word_FF00EA).l,d0  ; was: sub_5602
                lea     off_5610(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_StateMachine3
; ---------------------------------------------------------------------------
off_5610:       dc.w Cutscene_InitStarDelay-*         ; DATA XREF: Cutscene_StateMachine3+6   o
                dc.w Cutscene_InitStarSprites-*
                dc.w Cutscene_AnimateStars-*
                dc.w Cutscene_WaitTimerDelay-*
                dc.w Cutscene_FadeStarObjects-*
                dc.w nullsub_17-*


; Initializes long delay timer for star field sequence
Cutscene_InitStarDelay:                               ; DATA XREF: ROM:off_5610   o  ; was: sub_561C
                move.w  #$2480,(word_FF00FE).l
                addq.w  #2,(word_FF00EA).l
                rts
; End of function Cutscene_InitStarDelay
; Initializes multiple star sprite objects for parallax effect
Cutscene_InitStarSprites:                               ; DATA XREF: ROM:00005612   o  ; was: sub_562C
                subq.w  #1,(word_FF00FE).l
                bne.w   locret_514E
                lea     (Entity_ObjectPool).w,a5
                move.w  #$CC00,word_FFC622-Entity_ObjectPool(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$9C,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC680).w,a5
                move.w  #$CC00,word_FFC682-word_FFC680(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$9C,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC6E0).w,a5
                move.w  #$CC00,word_FFC6E2-word_FFC6E0(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$9C,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC740).w,a5
                move.w  #$CC00,word_FFC742-word_FFC740(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$9C,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC7A0).w,a5
                move.w  #$CC00,word_FFC7A2-word_FFC7A0(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$C4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC800).w,a5
                move.w  #$CC00,word_FFC802-word_FFC800(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$C4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC860).w,a5
                move.w  #$CC00,word_FFC862-word_FFC860(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$C4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC8C0).w,a5
                move.w  #$CC00,word_FFC8C2-word_FFC8C0(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$C4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC920).w,a5
                move.w  #$CC00,word_FFC922-word_FFC920(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$ED00,$E(a5)
                move.w  #$110,$10(a5)
                move.w  #$B0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC980).w,a5
                move.w  #$CC00,word_FFC982-word_FFC980(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$130,$10(a5)
                move.w  #$B0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   (word_FF00E8).l
                addq.w  #2,(word_FF00EA).l
                rts
; End of function Cutscene_InitStarSprites
; Animates star sprites and advances state after 20 cycles
Cutscene_AnimateStars:                               ; DATA XREF: ROM:00005614   o  ; was: sub_5824
                addq.w  #1,(word_FF00E8).l
                bsr.w Cutscene_UpdateStarPositions
                cmpi.w  #$14,(word_FF00E8).l
                bne.w   locret_514E
                move.w  #$40,(word_FF00FE).l ; '@'
                addq.w  #2,(word_FF00EA).l
                rts
; End of function Cutscene_AnimateStars
; Waits for timer countdown before advancing cutscene state
Cutscene_WaitTimerDelay:                               ; DATA XREF: ROM:00005616   o  ; was: sub_584A
                subq.w  #1,(word_FF00FE).l
                bne.w   locret_514E
                addq.w  #2,(word_FF00EA).l
                rts
; End of function Cutscene_WaitTimerDelay
; Fades out star objects by decrementing timer and clearing object slots
Cutscene_FadeStarObjects:                               ; DATA XREF: ROM:00005618   o  ; was: sub_585C
                subq.w  #1,(word_FF00E8).l
                bsr.w Cutscene_UpdateStarPositions
                tst.w   (word_FF00E8).l
                bpl.w   locret_514E
                lea     (word_FFC622).w,a0
                move.w  #9,d0
loc_5878:                               ; CODE XREF: Cutscene_FadeStarObjects+22   j
                clr.w   (a0)
                adda.w  #$60,a0 ; '`'
                dbf     d0,loc_5878
                addq.w  #2,(word_FF00EA).l
                rts
; End of function Cutscene_FadeStarObjects
nullsub_17:                             ; DATA XREF: ROM:0000561A   o
                rts
; End of function nullsub_17


; Dispatches story screen text rendering states
UI_StoryTextDispatcher:                               ; CODE XREF: Sys_StoryScreenMainLoop+3C   p  ; was: sub_588C
                cmpi.w  #$18,(GameSubstateIndex).w
                beq.w   locret_514E
                move.w  (word_FF0178).l,d0
                lea     off_58A4(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function UI_StoryTextDispatcher
; ---------------------------------------------------------------------------
off_58A4:       dc.w UI_InitStoryTextDisplay-*         ; DATA XREF: UI_StoryTextDispatcher+10   o
                dc.w UI_UpdateStoryTextScroll-*


; Initializes story text display with palette and data
UI_InitStoryTextDisplay:                               ; DATA XREF: ROM:off_58A4   o  ; was: sub_58A8
                move.w  #$200,(word_FFE342).w
                move.w  #2,(word_FFE362).w
                move.w  #$EEE,(word_FFE344).w
                move.w  #$EE,(word_FFE364).w
                move.w  #$200,(dword_FFE3C2).w
                move.w  #2,(word_FFE3E2).w
                move.w  #$EEE,(dword_FFE3C2+2).w
                move.w  #$EE,(word_FFE3E4).w
                move.l  #byte_5A36,(dword_FF00F8).l
                move.l  #byte_675D,(dword_FF0172).l
                move.w  #$4C88,(word_FF00F6).l
                move.w  #1,(word_FF00FC).l
                addq.w  #2,(word_FF0178).l
                rts
; End of function UI_InitStoryTextDisplay
; Blinks text colors between two palette values
Gfx_BlinkTextColors:                               ; CODE XREF: UI_UpdateStoryTextScroll   p  ; was: sub_5904
                move.w  #$200,(word_FFE342).w
                move.w  #2,(word_FFE362).w
                move.w  (word_FFA280).w,d0
                andi.w  #1,d0
                bne.s   loc_5928
                move.w  #$EEE,(word_FFE344).w
                move.w  #$EE,(word_FFE364).w
                rts
; ---------------------------------------------------------------------------
loc_5928:                               ; CODE XREF: Gfx_BlinkTextColors+14   j
                move.w  #$EEA,(word_FFE344).w
                move.w  #$EA,(word_FFE364).w
                rts
; End of function Gfx_BlinkTextColors
; Updates scrolling story text display frame by frame
UI_UpdateStoryTextScroll:                               ; DATA XREF: ROM:000058A6   o  ; was: sub_5936
                bsr.w Gfx_BlinkTextColors
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_514E
                subq.w  #1,(dword_FFA904).w
                subq.w  #1,(word_FF00FC).l
                bne.w   locret_514E
                move.w  #$18,(word_FF00FC).l
                move.w  #$C300,d0
                move.w  (word_FF00F6).l,d4
                movea.l (dword_FF00F8).l,a0
                cmpi.b  #$FE,(a0)
                bne.s   loc_5980
                movea.l #word_5A14,a0
                jsr (UI_RenderTextStringWrapped).l
                bra.s   loc_59D2
; ---------------------------------------------------------------------------
loc_5980:                               ; CODE XREF: UI_UpdateStoryTextScroll+3A   j
                move.w  #$E300,d0
                move.w  (word_FF00F6).l,d4
                movea.l (dword_FF0172).l,a0
                move.w  #$1F,d1
loc_5994:                               ; CODE XREF: UI_UpdateStoryTextScroll+66   j
                tst.b   (a0)
                bne.s   loc_59A2
                addq.w  #1,a0
                addq.w  #2,d4
                dbf     d1,loc_5994
                bra.s   loc_59A8
; ---------------------------------------------------------------------------
loc_59A2:                               ; CODE XREF: UI_UpdateStoryTextScroll+60   j
                jsr (UI_RenderTextStringWrapped).l
loc_59A8:                               ; CODE XREF: UI_UpdateStoryTextScroll+6A   j
                addi.l  #$22,(dword_FF0172).l ; '"'
                move.w  #$C300,d0
                move.w  (word_FF00F6).l,d4
                movea.l (dword_FF00F8).l,a0
                jsr (UI_RenderTextStringWrapped).l
                addi.l  #$22,(dword_FF00F8).l ; '"'
loc_59D2:                               ; CODE XREF: UI_UpdateStoryTextScroll+48   j
                move.w  #$C300,d0
                move.w  (word_FF00F6).l,d4
                addi.w  #$80,d4
                cmpi.w  #$5000,d4
                bcs.s UI_WrapTextVRAMAddress
                subi.w  #$1000,d4
; Wraps VRAM address for text rendering across plane boundary
UI_WrapTextVRAMAddress:                               ; CODE XREF: UI_UpdateStoryTextScroll+AE   j  ; was: loc_59EA
                movea.l #word_5A14,a0
                jsr (UI_RenderTextStringWrapped).l
                addi.w  #$180,(word_FF00F6).l
                cmpi.w  #$5000,(word_FF00F6).l
                bcs.w   locret_514E
                subi.w  #$1000,(word_FF00F6).l
                rts
; End of function UI_UpdateStoryTextScroll
; ---------------------------------------------------------------------------
word_5A14:      dc.w 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: UI_UpdateStoryTextScroll+3C   o
                                        ; sub_5936:loc_59EA   o
                dc.w $FF
byte_5A36:	binclude	"data/other/byte_5A36.bin"
byte_5A36_End:
byte_675D:	binclude	"data/other/byte_675D.bin"
byte_675D_End:


; Dispatches Japanese text rendering state machine
UI_JapaneseTextDispatcher:                               ; CODE XREF: Sys_StoryScreenMainLoop+40   p  ; was: sub_7484
                subq.w  #1,(word_FF0180).l
                btst    #0,(word_FFA000+1).w
                bne.s UI_JapaneseTextDispatchJump
                subq.w  #1,(word_FF0180).l
; Jump table dispatcher for Japanese text rendering
UI_JapaneseTextDispatchJump:                               ; CODE XREF: UI_JapaneseTextDispatcher+C   j  ; was: loc_7498
                move.w  (word_FF0126).l,d0
                lea     off_74A6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function UI_JapaneseTextDispatcher
; ---------------------------------------------------------------------------
off_74A6:       dc.w UI_InitJapaneseTextDisplay-*         ; DATA XREF: UI_JapaneseTextDispatcher+1A   o
                dc.w UI_RenderJapaneseFontChar-*
                dc.w nullsub_18-*


; Initializes Japanese text display with font mappings
UI_InitJapaneseTextDisplay:                               ; DATA XREF: ROM:off_74A6   o  ; was: sub_74AC
                move.w  #$C580,d0
                move.w  #$6C80,d4
                lea     byte_7602(pc),a0
                nop
                jsr UI_RenderTextTileList(pc)    ; (pc)
                nop
                move.l  #font_japanese_mappings,(dword_FF0120).l
                move.w  #$7C00,(word_FF0184).l
                clr.w   (word_FF0180).l
                clr.w   (word_FF0182).l
                addq.w  #2,(word_FF0126).l
                rts
; End of function UI_InitJapaneseTextDisplay
; Renders single Japanese font character to VRAM
UI_RenderJapaneseFontChar:                               ; DATA XREF: ROM:000074A8   o  ; was: sub_74E6
                move.w  (word_FF0182).l,d0
                sub.w   (word_FF0180).l,d0
                cmpi.w  #$10,d0
                bcs.w   locret_514E
                subi.w  #$10,(word_FF0182).l
                movea.l (dword_FF0120).l,a0
                move.w  (a0),d0
                subi.w  #$20,d0 ; ' '
                ext.l   d0
                lsl.l   #7,d0
                addi.l  #font_japanese_tiles,d0
                move.w  (word_FF0184).l,d4
                jsr Gfx_SetupFontDMATransfer(pc)    ; (pc)
                nop
                move.w  (word_FF0184).l,d0
                addi.w  #$80,d0
                cmpi.w  #$8000,d0
                bne.s UI_WrapJapaneseFontVRAM
                move.w  #$7000,d0
; Wraps VRAM address for Japanese font rendering
UI_WrapJapaneseFontVRAM:                               ; CODE XREF: UI_RenderJapaneseFontChar+4C   j  ; was: loc_7538
                move.w  d0,(word_FF0184).l
                addq.l  #2,(dword_FF0120).l
                movea.l (dword_FF0120).l,a0
                tst.w   (a0)
                bpl.w   locret_514E
                addq.w  #2,(word_FF0126).l
                rts
; End of function UI_RenderJapaneseFontChar
nullsub_18:                             ; DATA XREF: ROM:000074AA   o
                rts
; End of function nullsub_18


; Sets up DMA transfer for font tile data to VRAM
Gfx_SetupFontDMATransfer:                               ; CODE XREF: UI_RenderJapaneseFontChar+38   p  ; was: sub_755A
                                        ; DATA XREF: UI_RenderJapaneseFontChar+38   o
                movea.w (word_FFF70C).w,a1
                move.w  #$82,-(a1)
                move.w  d4,-(a1)
                lsr.l   #1,d0
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                lsr.l   #8,d0
                move.b  d0,-(a1)
                move.b  #$96,-(a1)
                lsr.l   #8,d0
                move.b  d0,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  #$94009340,-(a1)
                move.w  a1,(word_FFF70C).w
                rts
; End of function Gfx_SetupFontDMATransfer
; Renders list of text tiles with sequential indexing
UI_RenderTextTileList:                               ; CODE XREF: UI_InitJapaneseTextDisplay+E   p  ; was: sub_758C
                                        ; DATA XREF: UI_InitJapaneseTextDisplay+E   o
                movea.w (word_FFF70E).w,a1
                moveq   #0,d7
loc_7592:                               ; CODE XREF: UI_RenderTextTileList+18   j
                moveq   #0,d2
                move.b  (a0)+,d2
                cmpi.b  #$FF,d2
                beq.s   loc_75A6
                asl.w   #1,d2
                add.w   d0,d2
                move.w  d2,(a1)+
                addq.w  #1,d7
                bra.s   loc_7592
; ---------------------------------------------------------------------------
loc_75A6:                               ; CODE XREF: UI_RenderTextTileList+E   j
                move.w  d7,d3
                subq.w  #1,d3
                movea.w (word_FFF70E).w,a0
loc_75AE:                               ; CODE XREF: UI_RenderTextTileList+28   j
                move.w  (a0)+,d0
                addq.w  #1,d0
                move.w  d0,(a1)+
                dbf     d3,loc_75AE
                move.w  d7,d3
                bsr.w Gfx_QueueTileDMACommand
                addi.w  #$80,d4
                move.w  d7,d3
; End of function UI_RenderTextTileList
; Queues DMA command for tile data transfer to VRAM
Gfx_QueueTileDMACommand:                               ; CODE XREF: UI_RenderTextTileList+2E   p  ; was: sub_75C4
                movea.w (word_FFF70C).w,a1
                move.w  #$82,-(a1)
                move.w  d4,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009300,-(a1)
                move.b  d3,3(a1)
                move.w  a1,(word_FFF70C).w
                asl.w   #1,d3
                add.w   d3,(word_FFF70E).w
                rts
; End of function Gfx_QueueTileDMACommand
; ---------------------------------------------------------------------------
byte_7602:      dc.b 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, $A, $B, $C, $D, $E, $F
                                        ; DATA XREF: UI_InitJapaneseTextDisplay+8   o
                dc.b $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
                dc.b $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
                dc.b $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
                dc.b $FF, $FF


; Updates vertical positions for cutscene star sprite objects
Cutscene_UpdateStarPositions:                               ; CODE XREF: Cutscene_AnimateStars+6   p  ; was: sub_7644
                                        ; Cutscene_FadeStarObjects+6   p
                lea     (dword_FFC634).w,a5
                move.w  #$9C,d0
                sub.w   (word_FF00E8).l,d0
                move.w  d0,(a5)
                adda.w  #$60,a5 ; '`'
                move.w  d0,(a5)
                adda.w  #$60,a5 ; '`'
                move.w  d0,(a5)
                adda.w  #$60,a5 ; '`'
                move.w  d0,(a5)
                adda.w  #$60,a5 ; '`'
                move.w  #$C4,d0
                add.w   (word_FF00E8).l,d0
                move.w  d0,(a5)
                adda.w  #$60,a5 ; '`'
                move.w  d0,(a5)
                adda.w  #$60,a5 ; '`'
                move.w  d0,(a5)
                adda.w  #$60,a5 ; '`'
                move.w  d0,(a5)
                rts
; End of function Cutscene_UpdateStarPositions
; Copies planet sprite coordinates from buffer to global state
Cutscene_CopyPlanetCoords:                               ; CODE XREF: Cutscene_PlanetZoomIn+8   p  ; was: sub_768A
                                        ; sub_5244   p ...
                move.w  (word_FFC9F4).w,(word_FF00D4).l
                move.w  (word_FFC9F0).w,(word_FF00D6).l
; End of function Cutscene_CopyPlanetCoords
; Planet scrolling animation
Cutscene_PlanetScroll:                               ; CODE XREF: Cutscene_PlanetSequenceCtrl+C   p  ; was: sub_769A
                                        ; Cutscene_PlanetTransition+8   p ...
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
                clr.w   d5
                move.w  (word_FF00D8).l,d3
loc_76AA:                               ; CODE XREF: Cutscene_PlanetScroll+14   j
                subi.w  #$20,d5 ; ' '
                dbf     d3,loc_76AA
                asr.w   #1,d5
                add.w   (word_FF00D4).l,d5
                clr.w   d6
                move.w  (word_FF00DA).l,d2
loc_76C2:                               ; CODE XREF: Cutscene_PlanetScroll+2C   j
                subi.w  #$20,d6 ; ' '
                dbf     d2,loc_76C2
                asr.w   #1,d6
                add.w   (word_FF00D6).l,d6
                move.w  (word_FF00DC).l,d4
                move.w  (word_FF00D8).l,d3
                move.w  d5,d0
loc_76E0:                               ; CODE XREF: Cutscene_PlanetScroll+64   j
                move.w  (word_FF00DA).l,d2
                move.w  d6,d1
loc_76E8:                               ; CODE XREF: Cutscene_PlanetScroll+5C   j
                move.w  d0,(a1)+
                move.w  #$F00,(a1)+
                move.w  d4,(a1)+
                move.w  d1,(a1)+
                addi.w  #$20,d1 ; ' '
                dbf     d2,loc_76E8
                addi.w  #$20,d0 ; ' '
                dbf     d3,loc_76E0
                move.w  #$FFFF,(a1)
                jmp (Sprite_AddToOAMBuffer).l
; End of function Cutscene_PlanetScroll
; Renders grid of sprites for cutscene with calculated centered positions
Cutscene_RenderSpriteGrid:                               ; CODE XREF: Cutscene_ShipFadeOut+8   p  ; was: sub_770C
                                        ; sub_549C   p ...
                move.w  (word_FFCA54).w,(word_FF00DE).l
                move.w  (word_FFCA50).w,(word_FF00E0).l
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
                clr.w   d5
                move.w  (word_FF00E2).l,d3
loc_772C:                               ; CODE XREF: Cutscene_RenderSpriteGrid+24   j
                subi.w  #$20,d5 ; ' '
                dbf     d3,loc_772C
                asr.w   #1,d5
                add.w   (word_FF00DE).l,d5
                clr.w   d6
                move.w  (word_FF00E4).l,d2
loc_7744:                               ; CODE XREF: Cutscene_RenderSpriteGrid+3C   j
                subi.w  #$20,d6 ; ' '
                dbf     d2,loc_7744
                asr.w   #1,d6
                add.w   (word_FF00E0).l,d6
                move.w  (word_FF00E6).l,d4
                move.w  (word_FF00E2).l,d3
                move.w  d5,d0
loc_7762:                               ; CODE XREF: Cutscene_RenderSpriteGrid+74   j
                move.w  (word_FF00E4).l,d2
                move.w  d6,d1
loc_776A:                               ; CODE XREF: Cutscene_RenderSpriteGrid+6C   j
                move.w  d0,(a1)+
                move.w  #$F00,(a1)+
                move.w  d4,(a1)+
                move.w  d1,(a1)+
                addi.w  #$20,d1 ; ' '
                dbf     d2,loc_776A
                addi.w  #$20,d0 ; ' '
                dbf     d3,loc_7762
                move.w  #$FFFF,(a1)
                jmp (Sprite_AddToOAMBuffer).l
; End of function Cutscene_RenderSpriteGrid
; Clears sprite buffer and initiates DMA transfer for cutscene graphics
Cutscene_ClearSpriteBuffer:                               ; CODE XREF: Cutscene_InitShipSprite+82   p  ; was: sub_778E
                                        ; Cutscene_InitShipSprite2+90   p
                lea     (dword_FF0020).l,a0
                moveq   #$FFFFFFFF,d0
                move.w  #7,d1
loc_779A:                               ; CODE XREF: Cutscene_ClearSpriteBuffer+E   j
                move.l  d0,(a0)+
                dbf     d1,loc_779A
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(a0)
                move.l  (dword_FF00CA).l,(VDP_CTRL).l
                bra.s   loc_77E4
; End of function Cutscene_ClearSpriteBuffer
; Planet rotation effect
Cutscene_PlanetRotate:                               ; CODE XREF: Cutscene_SetupPlanetRotate+82   p  ; was: sub_77BA
                                        ; Cutscene_InitPlanetZoomIn+90   p ...
                lea     (M68K_RAM).l,a0
                moveq   #$FFFFFFFF,d0
                move.w  #7,d1
loc_77C6:                               ; CODE XREF: Cutscene_PlanetRotate+E   j
                move.l  d0,(a0)+
                dbf     d1,loc_77C6
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(a0)
                move.l  (dword_FF00C0).l,(VDP_CTRL).l
loc_77E4:                               ; CODE XREF: Cutscene_ClearSpriteBuffer+2A   j
                move.w  #$FFFF,d0
                move.w  #$FF,d1
loc_77EC:                               ; CODE XREF: Cutscene_PlanetRotate+34   j
                move.w  d0,(a0)
                dbf     d1,loc_77EC
                move    #$2300,sr
                rts
; End of function Cutscene_PlanetRotate
; Fades in ship sprite by manipulating palette mask based on input timer
Cutscene_FadeInShip:                               ; CODE XREF: Cutscene_ShipFadeIn+C   p  ; was: sub_77F8
                                        ; Cutscene_ShipZoomOut+C   p
                move.w  (word_FFA280).w,d0
                and.w   (word_FF00D2).l,d0
                bne.w   locret_514E
                move.w  (word_FF00D0).l,d0
                bmi.w   locret_514E
                subq.w  #1,(word_FF00D0).l
                bsr.w Gfx_CalculatePaletteMask
                eori.w  #$FFFF,d2
                move.w  (a2),d4
                or.w    d2,d4
                move.w  d4,(a2)
                lea     (word_FF0060).l,a2
                move.w  #$F,d7
loc_782E:                               ; CODE XREF: Cutscene_FadeInShip+38   j
                move.w  d4,(a2)+
                dbf     d7,loc_782E
                movea.w (word_FFF70C).w,a0
                suba.w  #$10,a0
                move.w  a0,(word_FFF70C).w
                move.l  #$94009310,(a0)+
                move.l  #$8F20977F,(a0)+
                move.l  #$96809530,(a0)+
                ori.l   #$80,d6
                move.l  d6,(a0)+
                rts
; End of function Cutscene_FadeInShip
; Fades out ship sprite by manipulating palette mask based on input timer
Cutscene_FadeOutShip:                               ; CODE XREF: Cutscene_ShipFadeOut+C   p  ; was: sub_785C
                                        ; Cutscene_ShipZoomIn+12   p
                move.w  (word_FFA280).w,d0
                and.w   (word_FF00D2).l,d0
                bne.w   locret_514E
                move.w  (word_FF00D0).l,d0
                cmpi.w  #$40,d0 ; '@'
                beq.w   locret_514E
                addq.w  #1,(word_FF00D0).l
                bsr.w Gfx_CalculatePaletteMask
                move.w  (a2),d4
                and.w   d2,d4
                move.w  d4,(a2)
                lea     (word_FF0060).l,a2
                move.w  #$F,d7
loc_7892:                               ; CODE XREF: Cutscene_FadeOutShip+38   j
                move.w  d4,(a2)+
                dbf     d7,loc_7892
                movea.w (word_FFF70C).w,a0
                suba.w  #$10,a0
                move.w  a0,(word_FFF70C).w
                move.l  #$94009310,(a0)+
                move.l  #$8F20977F,(a0)+
                move.l  #$96809530,(a0)+
                ori.l   #$80,d6
                move.l  d6,(a0)+
                rts
; End of function Cutscene_FadeOutShip
; Updates VDP registers with bitwise mask operations
Gfx_UpdateVDPRegistersWithMask:                               ; CODE XREF: Cutscene_PlanetZoomOut+C   p  ; was: sub_78C0
                                        ; Cutscene_PlanetFadeInAlt+C   p ...
                move.w  (word_FFA280).w,d0
                and.w   (word_FF00C8).l,d0
                bne.w   locret_514E
                move.w  (word_FF00C6).l,d0
                bmi.w   locret_514E
                subq.w  #1,(word_FF00C6).l
                bsr.w Gfx_CalculatePaletteOffset
                eori.w  #$FFFF,d2
                move.w  (a2),d4
                or.w    d2,d4
                move.w  d4,(a2)
                lea     (word_FF0040).l,a2
                move.w  #$F,d7
loc_78F6:                               ; CODE XREF: Gfx_UpdateVDPRegistersWithMask+38   j
                move.w  d4,(a2)+
                dbf     d7,loc_78F6
                movea.w (word_FFF70C).w,a0
                suba.w  #$10,a0
                move.w  a0,(word_FFF70C).w
                move.l  #$94009310,(a0)+
                move.l  #$8F20977F,(a0)+
                move.l  #$96809520,(a0)+
                ori.l   #$80,d6
                move.l  d6,(a0)+
                rts
; End of function Gfx_UpdateVDPRegistersWithMask
; Fades out palette by updating mask and VDP registers with visual effect
Gfx_FadeOutPalette:                               ; CODE XREF: Cutscene_PlanetZoomIn+C   p  ; was: sub_7924
                                        ; Cutscene_PlanetFadeOutAlt+12   p ...
                move.w  (word_FFA280).w,d0
                and.w   (word_FF00C8).l,d0
                bne.w   locret_514E
                move.w  (word_FF00C6).l,d0
                cmpi.w  #$40,d0 ; '@'
                beq.w   locret_514E
                addq.w  #1,(word_FF00C6).l
                bsr.w Gfx_CalculatePaletteOffset
                move.w  (a2),d4
                and.w   d2,d4
                move.w  d4,(a2)
                lea     (word_FF0040).l,a2
                move.w  #$F,d7
loc_795A:                               ; CODE XREF: Gfx_FadeOutPalette+38   j
                move.w  d4,(a2)+
                dbf     d7,loc_795A
                movea.w (word_FFF70C).w,a0
                suba.w  #$10,a0
                move.w  a0,(word_FFF70C).w
                move.l  #$94009310,(a0)+
                move.l  #$8F20977F,(a0)+
                move.l  #$96809520,(a0)+
                ori.l   #$80,d6
                move.l  d6,(a0)+
                rts
; End of function Gfx_FadeOutPalette
; Calculates RAM offset and VRAM address for palette operations based on lookup table
Gfx_CalculatePaletteOffset:                               ; CODE XREF: Gfx_UpdateVDPRegistersWithMask+1E   p  ; was: sub_7988
                                        ; Gfx_FadeOutPalette+22   p
                lea     (M68K_RAM).l,a2
                lea     byte_79BA(pc,d0.w),a3
                moveq   #0,d2
                move.b  (a3),d2
                andi.b  #3,d2
                lsl.b   #1,d2
                lea     word_79FA(pc,d2.w),a4
                move.w  (a4),d2
                moveq   #0,d3
                move.b  (a3),d3
                andi.b  #$3C,d3 ; '<'
                lsr.b   #1,d3
                adda.l  d3,a2
                swap    d3
                move.l  (dword_FF00C0).l,d6
                add.l   d3,d6
                rts
; End of function Gfx_CalculatePaletteOffset
; ---------------------------------------------------------------------------
byte_79BA:      dc.b 4, $2A, $24, 8, $18, $32, $27, $2D, $37, $13, $F, $1C, $36, 3, $12, $17
                                        ; DATA XREF: Gfx_CalculatePaletteOffset+6   o
                                        ; Gfx_CalculatePaletteMask+6   o ...
                dc.b $C, $23, $20, $2E, $A, $3C, $21, $E, $1D, $38, 1, $19, $3A, $D, $2C, $35
                dc.b $2F, $10, $29, 0, $15, $26, 6, $28, 5, $33, $30, 2, $11, $3F, $34, $1E
                dc.b $3D, $1A, $14, $3E, 9, $31, $16, 7, $25, $B, $39, $1F, $2B, $1B, $3B, $22
word_79FA:      dc.w $FFF, $F0FF, $FF0F, $FFF0


; Calculates palette RAM offset and VRAM address with color channel mask
Gfx_CalculatePaletteMask:                               ; CODE XREF: Cutscene_FadeInShip+1E   p  ; was: sub_7A02
                                        ; Cutscene_FadeOutShip+22   p
                lea     (dword_FF0020).l,a2
                lea     byte_79BA(pc,d0.w),a3
                moveq   #0,d2
                move.b  (a3),d2
                andi.b  #3,d2
                lsl.b   #1,d2
                lea     word_79FA(pc,d2.w),a4
                move.w  (a4),d2
                moveq   #0,d3
                move.b  (a3),d3
                andi.b  #$3C,d3 ; '<'
                lsr.b   #1,d3
                adda.l  d3,a2
                swap    d3
                move.l  (dword_FF00CA).l,d6
                add.l   d3,d6
                rts
; End of function Gfx_CalculatePaletteMask
; Updates planet palette with alternating color masks and queues DMA
Gfx_UpdatePlanetPalette:                               ; CODE XREF: Cutscene_PlanetZoomIn+10   p  ; was: sub_7A34
                                        ; Cutscene_PlanetHold+4   p ...
                lea     (word_FF0080).l,a1
                lea     (M68K_RAM).l,a2
                lea     word_7B0C(pc),a3
                nop
                move.w  (word_FFA280).w,d0
                andi.w  #1,d0
                bne.s   loc_7A56
                adda.l  #4,a3
loc_7A56:                               ; CODE XREF: Gfx_UpdatePlanetPalette+1A   j
                move.w  #$F,d6
loc_7A5A:                               ; CODE XREF: Gfx_UpdatePlanetPalette+2C   j
                move.w  (a2)+,d0
                or.w    (a3)+,d0
                move.w  d0,(a1)+
                dbf     d6,loc_7A5A
                move.l  (dword_FF00C0).l,d6
                ori.l   #$80,d6
                movea.w (word_FFF70C).w,a0
                suba.w  #$100,a0
                move.w  a0,(word_FFF70C).w
                move.w  #$F,d0
loc_7A80:                               ; CODE XREF: Gfx_UpdatePlanetPalette+66   j
                move.l  #$94009310,(a0)+
                move.l  #$8F02877F,(a0)+
                move.l  #$96809540,(a0)+
                move.l  d6,(a0)+
                addi.l  #$200000,d6
                dbf     d0,loc_7A80
                rts
; End of function Gfx_UpdatePlanetPalette
; Updates ship palette with alternating color masks and queues DMA
Gfx_UpdateShipPalette:                               ; CODE XREF: Cutscene_ShipFadeOut+10   p  ; was: sub_7AA0
                                        ; Cutscene_WaitShipDelay+4   p ...
                lea     (word_FF00A0).l,a1
                lea     (dword_FF0020).l,a2
                lea     word_7B0C(pc),a3
                nop
                move.w  (word_FFA280).w,d0
                andi.w  #1,d0
                bne.s   loc_7AC2
                adda.l  #4,a3
loc_7AC2:                               ; CODE XREF: Gfx_UpdateShipPalette+1A   j
                move.w  #$F,d6
loc_7AC6:                               ; CODE XREF: Gfx_UpdateShipPalette+2C   j
                move.w  (a2)+,d0
                or.w    (a3)+,d0
                move.w  d0,(a1)+
                dbf     d6,loc_7AC6
                move.l  (dword_FF00CA).l,d6
                ori.l   #$80,d6
                movea.w (word_FFF70C).w,a0
                suba.w  #$100,a0
                move.w  a0,(word_FFF70C).w
                move.w  #$F,d0
loc_7AEC:                               ; CODE XREF: Gfx_UpdateShipPalette+66   j
                move.l  #$94009310,(a0)+
                move.l  #$8F02877F,(a0)+
                move.l  #$96809550,(a0)+
                move.l  d6,(a0)+
                addi.l  #$200000,d6
                dbf     d0,loc_7AEC
                rts
; End of function Gfx_UpdateShipPalette
; ---------------------------------------------------------------------------
word_7B0C:      dc.w $F0F, $F0F, $F0F0, $F0F0, $F0F, $F0F, $F0F0, $F0F0, $F0F
                                        ; DATA XREF: Gfx_UpdatePlanetPalette+C   o
                                        ; Gfx_UpdateShipPalette+C   o
                dc.w $F0F, $F0F0, $F0F0, $F0F, $F0F, $F0F0, $F0F0, $F0F, $F0F


; Initializes credits screen with graphics loading and palette fade setup
Cutscene_InitCreditsScreen:                               ; CODE XREF: Stage_TransitionToCredits+6   j  ; was: sub_7B30
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr (Sys_InitGameMode).l
                move.w  #1,(word_FF010E).l
                movea.l #stru_7BF2,a0
                jsr     (LoadObjData).l
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9600-M68K_RAM),a1
                move.w  #$20,(word_FF8048).w ; ' '
                move.w  #$1F,(word_FF804A).w
                move.w  #1,(dword_FF8044+2).w
                jsr (Gfx_LoadTilesLoop).l
                jsr (Sys_ClearBossDataBuffer).l
                lea     (dword_11326).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                jsr (Gfx_DirectVRAMTransfer).l
                lea     (word_B982).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                move.w  #$FFF2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                move.b  #$88,d0
                jsr (Sys_WaitVBlank).l
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA90C).w
                clr.w   (dword_FFA908).w
                jsr (Gfx_SetupScrollPlanes).l
                clr.w   (dword_FF8128+2).w
                rts
; End of function Cutscene_InitCreditsScreen
; ---------------------------------------------------------------------------
stru_7BF2:      dc.w 7                  ; field_0
                                        ; DATA XREF: Cutscene_InitCreditsScreen+18   o
                dc.l tiles_189E4C       ; field_2
                dc.w $2000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_18B2FA       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18CD7C        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18CC50        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l tiles_18B14C       ; field_2
                dc.w $9600              ; field_6
                dc.w $FFFF


; Dispatches credits screen state machine based on current state offset
Cutscene_CreditsDispatcher:                               ; CODE XREF: Stage_HandleCreditsOrAdvance+8   j  ; was: sub_7C24
                jsr (Effect_PaletteDispatcher).l
                move.w  (dword_FF8128+2).w,d0
                lea     off_7C36(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_CreditsDispatcher
; ---------------------------------------------------------------------------
off_7C36:       dc.w Cutscene_FadeInCredits-*         ; DATA XREF: Cutscene_CreditsDispatcher+A   o
                dc.w Cutscene_WaitCreditsTimer-*
                dc.w Cutscene_FadeOutCredits-*
                dc.w Cutscene_WaitForTimer-*
                dc.w Effect_InitializeStarfield-*
                dc.w Effect_InitializeStarfield_WaitLoop-*
                dc.w Cutscene_SegaScreenFadeOut-*
                dc.w Cutscene_InitPlanetScene-*
                dc.w Cutscene_PlanetSequenceCtrl-*
                dc.w Cutscene_PlanetFadeOut-*
                dc.w Cutscene_PlanetTransition-*
                dc.w Cutscene_PlanetZoomMainLoop-*
                dc.w Cutscene_PlanetZoomFadeOut-*


; Fades in credits screen palette incrementally until fully visible
Cutscene_FadeInCredits:                               ; DATA XREF: ROM:off_7C36   o  ; was: sub_7C50
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_514E
                addq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF010C).l
                bne.w   locret_514E
                move.w  #$80,(word_FF0106).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_FadeInCredits
; Waits for credits display timer while animating palette colors
Cutscene_WaitCreditsTimer:                               ; DATA XREF: ROM:00007C38   o  ; was: sub_7C92
                bsr.w Gfx_AnimateCreditsColors
                subq.w  #1,(word_FF0106).l
                bne.w   locret_514E
                clr.w   (word_FF010C).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_WaitCreditsTimer
; Animates credits palette colors with alternating color schemes per frame
Gfx_AnimateCreditsColors:                               ; CODE XREF: Cutscene_WaitCreditsTimer   p  ; was: sub_7CAC
                                        ; sub_7D68:loc_7E48   p ...
                lea     (word_FFE366).w,a1
                move.w  (word_FFA280).w,d0
                andi.w  #1,d0
                bne.s   loc_7CC6
                lea     word_7CD2(pc),a0
                nop
                move.w  (a0)+,(a1)+
                move.l  (a0),(a1)
                rts
; ---------------------------------------------------------------------------
loc_7CC6:                               ; CODE XREF: Gfx_AnimateCreditsColors+C   j
                lea     word_7CD8(pc),a0
                nop
                move.w  (a0)+,(a1)+
                move.l  (a0),(a1)
                rts
; End of function Gfx_AnimateCreditsColors
; ---------------------------------------------------------------------------
word_7CD2:      dc.w $EA8, $E86, $E64   ; DATA XREF: Gfx_AnimateCreditsColors+E   o
word_7CD8:      dc.w $A2A, $828, $626   ; DATA XREF: Gfx_AnimateCreditsColors:loc_7CC6   o


; Fades out credits screen palette incrementally before transition
Cutscene_FadeOutCredits:                               ; DATA XREF: ROM:00007C3A   o  ; was: sub_7CDE
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_514E
                addq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                cmpi.w  #$E,(word_FF010C).l
                bne.w   locret_514E
                movea.l #byte_7D48,a0
                jsr (Gfx_LoadCompressedTiles).l
                lea     (Entity_ObjectPool).w,a5
                move.w  #$128,dword_FFC630-Entity_ObjectPool(a5)
                move.w  #$E8,$14(a5)
                jsr (Sprite_ClearForTransition).l
                move.w  #$2C8,(a5)
                move.w  #$10,(word_FF0106).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_FadeOutCredits
; ---------------------------------------------------------------------------
byte_7D48:      dc.b $44, $20, $40, 0, 2, 2, $80, $84, $88, $84, $88, $80, $84, $80, $88, $FF
                                        ; DATA XREF: Cutscene_FadeOutCredits+36   o


; Waits for timer countdown and advances to next state
Cutscene_WaitForTimer:                               ; DATA XREF: ROM:00007C3C   o  ; was: sub_7D58
                subq.w  #1,(word_FF0106).l
                bne.w   locret_514E
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_WaitForTimer
; Initializes starfield effect with 59 sprites and random positions
Effect_InitializeStarfield:                               ; DATA XREF: ROM:00007C3E   o  ; was: sub_7D68
                move.w  (word_FFA280).w,d0
                andi.w  #7,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF010C).l
                bne.w   locret_514E
                lea     (word_FFC680).w,a5
                move.w  #$3A,d7 ; ':'
loc_7DA4:                               ; CODE XREF: Effect_InitializeStarfield+5C   j
                move.w  #$8C00,2(a5)
                move.w  #0,8(a5)
                move.w  #$FCFC,$A(a5)
                move.w  #$10,(a5)
                move.w  #$6364,$E(a5)
                adda.w  #$60,a5 ; '`'
                dbf     d7,loc_7DA4
                lea     (word_FF1000).l,a2
                lea     (word_FF1400).l,a3
                lea     (dword_FF1800).l,a1
                lea     (dword_FF1C00).l,a4
                lea     (dword_FF2000).l,a5
                move.w  #$FF,d7
loc_7DEA:                               ; CODE XREF: Effect_InitializeStarfield+D0   j
                jsr     (RandomNumber).l
                move.w  d0,d2
                andi.w  #$7F,d2
                jsr     (RandomNumber).l
                andi.w  #$1FE,d0
                bsr.w Math_LookupSineTable
                muls.w  d2,d0
                move.l  d0,d3
                swap    d0
                addi.w  #$128,d0
                move.w  d0,(a2)+
                clr.w   (a2)+
                asr.l   #4,d3
                move.l  d3,(a4)+
                muls.w  d2,d1
                move.l  d1,d3
                swap    d1
                addi.w  #$E8,d1
                move.w  d1,(a3)+
                clr.w   (a3)+
                asr.l   #4,d3
                move.l  d3,(a5)+
                jsr     (RandomNumber).l
                clr.w   d0
                swap    d0
                move.l  d0,$C00(a1)
                clr.l   (a1)+
                dbf     d7,loc_7DEA
                move.w  #$1A0,(word_FF0106).l
                addq.w  #2,(dword_FF8128+2).w
; Animates credits colors and updates starfield
Effect_InitializeStarfield_WaitLoop:                               ; DATA XREF: ROM:00007C40   o  ; was: loc_7E48
                bsr.w Gfx_AnimateCreditsColors
                bsr.w Effect_UpdateStarfield
                subq.w  #1,(word_FF0106).l
                bne.w   locret_514E
                clr.w   (word_FF010C).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Effect_InitializeStarfield
; Updates starfield sprite positions using velocity buffers
Effect_UpdateStarfield:                               ; CODE XREF: Effect_InitializeStarfield+E4   p  ; was: sub_7E66
                                        ; sub_7F06   p
                lea     (word_FF1000).l,a2
                lea     (word_FF1400).l,a3
                lea     (dword_FF1800).l,a1
                lea     (dword_FF1C00).l,a4
                lea     (dword_FF2000).l,a5
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                lsl.w   #8,d0
                adda.w  d0,a2
                adda.w  d0,a3
                adda.w  d0,a1
                adda.w  d0,a4
                adda.w  d0,a5
                move.w  #$3A,d7 ; ':'
loc_7E9C:                               ; CODE XREF: Effect_UpdateStarfield+44   j
                move.l  (a4)+,d0
                add.l   d0,(a2)+
                move.l  (a5)+,d0
                add.l   d0,(a3)+
                move.l  $C00(a1),d0
                add.l   d0,(a1)+
                dbf     d7,loc_7E9C
                lea     (word_FF1000).l,a2
                lea     (word_FF1400).l,a3
                lea     (dword_FF1800).l,a1
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                lsl.w   #8,d0
                adda.w  d0,a2
                adda.w  d0,a3
                adda.w  d0,a1
                lea     (word_FFC680).w,a5
                move.w  #$3A,d7 ; ':'
loc_7ED8:                               ; CODE XREF: Effect_UpdateStarfield+9A   j
                move.l  (a2)+,$10(a5)
                move.l  (a3)+,$14(a5)
                move.w  (a1),d0
                addq.w  #4,a1
                andi.w  #$FFF0,d0
                lsr.w   #4,d0
                cmpi.w  #3,d0
                bcs.s   loc_7EF4
                move.w  #2,d0
loc_7EF4:                               ; CODE XREF: Effect_UpdateStarfield+88   j
                addi.w  #$6364,d0
                move.w  d0,$E(a5)
                adda.w  #$60,a5 ; '`'
                dbf     d7,loc_7ED8
                rts
; End of function Effect_UpdateStarfield
; Fades out Sega screen and initializes scrolling background system
Cutscene_SegaScreenFadeOut:                               ; DATA XREF: ROM:00007C42   o  ; was: sub_7F06
                bsr.w Effect_UpdateStarfield
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF010C).l
                bne.w   locret_514E
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr (Sys_ClearBossDataBuffer).l
                move.l  #dword_11326,(dword_FFA940).w
                move.w  #$800,(word_FFA946).w
                move.w  #0,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                lea     (dword_FF4000).l,a0
                move.l  #$80008000,d1
                move.w  #$7FF,d0
loc_7F7A:                               ; CODE XREF: Cutscene_SegaScreenFadeOut+76   j
                or.l    d1,(a0)+
                dbf     d0,loc_7F7A
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_SegaScreenFadeOut
; Initializes planet cutscene with scrolling background and palettes
Cutscene_InitPlanetScene:                               ; DATA XREF: ROM:00007C44   o  ; was: sub_7F86
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   locret_514E
                lea     (word_B982).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                move.w  #$FFF2,(word_FF010C).l
                move.b  #6,(word_FFF7E6+1).w
                move.b  #3,(byte_FFA95A).w
                clr.l   (dword_FF0110).l
                clr.l   (dword_FF0114).l
                moveq   #0,d0
                lea     (word_FFE400).w,a0
                move.w  #$1B,d7
loc_7FDC:                               ; CODE XREF: Cutscene_InitPlanetScene+5C   j
                move.l  d0,(a0)
                adda.w  #$20,a0 ; ' '
                dbf     d7,loc_7FDC
                lea     (word_FFEC00).w,a0
                move.w  #9,d7
loc_7FEE:                               ; CODE XREF: Cutscene_InitPlanetScene+6A   j
                move.l  d0,(a0)+
                dbf     d7,loc_7FEE
                lea     (Entity_ObjectPool).w,a5
                move.w  #$CC00,word_FFC622-Entity_ObjectPool(a5)
                move.w  #$10,(a5)
                move.l  #stru_8630,8(a5)
                move.w  #$8001,$E(a5)
                move.w  #$190,$10(a5)
                move.w  #$130,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                andi.w  #$7FFF,2(a5)
                clr.w   4(a5)
                lea     (word_FFC680).w,a5
                move.w  #$CC00,word_FFC682-word_FFC680(a5)
                move.w  #$10,(a5)
                move.l  #word_18B0CE,8(a5)
                move.w  #$8900,$E(a5)
                move.w  #$190,$10(a5)
                move.w  #$120,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   4(a5)
                lea     (word_FFC6E0).w,a5
                move.w  #$CC00,word_FFC6E2-word_FFC6E0(a5)
                move.w  #$10,(a5)
                move.l  #word_18B04A,8(a5)
                move.w  #$8900,$E(a5)
                move.w  #$110,$10(a5)
                move.w  #$D0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   4(a5)
                move.w  #$4E0,(word_FF00DC).l
                move.w  #$D0,(word_FF00D4).l
                move.w  #$118,(word_FF00D6).l
                move.w  #4,(word_FF00D8).l
                move.w  #4,(word_FF00DA).l
                move.l  #$5C000002,(dword_FF00C0).l
                move.w  #$F,(word_FF00C4).l
                move.w  #1,(word_FF00C8).l
                clr.w   (word_FF00C6).l
                jsr Cutscene_PlanetRotate(pc)    ; (pc)
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                bsr.w Cutscene_ResetPlanetFade
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_InitPlanetScene
; Main controller for planet cutscene sequence with fade and scroll
Cutscene_PlanetSequenceCtrl:                               ; DATA XREF: ROM:00007C46   o  ; was: sub_80F8
                bsr.w Cutscene_PlanetFadeInStep
                bsr.w Cutscene_PlanetPaletteUpdate
                bsr.w Gfx_AnimateCreditsColors
                bsr.w Cutscene_PlanetScroll
                tst.w   (word_FF010C).l
                bne.w   locret_514E
                bsr.w Gfx_FadeOutPalette
                cmpi.w  #$40,(word_FF00C6).l ; '@'
                bcs.w   locret_514E
                move.w  #$100,(word_FF0106).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_PlanetSequenceCtrl
; Resets planet fade value to -14 and continues fade logic
Cutscene_ResetPlanetFade:                               ; CODE XREF: Cutscene_InitPlanetScene+168   p  ; was: sub_8130
                move.w  #$FFF2,(word_FF010C).l
                bra.s   loc_8156
; End of function Cutscene_ResetPlanetFade
; Gradually fades in planet scene palette every 8 frames
Cutscene_PlanetFadeInStep:                               ; CODE XREF: Cutscene_PlanetSequenceCtrl   p  ; was: sub_813A
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_514E
                tst.w   (word_FF010C).l
                beq.w   locret_514E
                addq.w  #2,(word_FF010C).l
loc_8156:                               ; CODE XREF: Cutscene_ResetPlanetFade+8   j
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Cutscene_PlanetFadeInStep
; Planet fade out effect
Cutscene_PlanetFadeOut:                               ; DATA XREF: ROM:00007C48   o  ; was: sub_816E
                bsr.w Cutscene_PlanetPaletteUpdate
                subq.w  #1,(word_FF0106).l
                bne.w   locret_514E
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_PlanetFadeOut
; Transition to next stage
Cutscene_PlanetTransition:                               ; DATA XREF: ROM:00007C4A   o  ; was: sub_8182
                bsr.w Cutscene_PlanetPaletteUpdate
                bsr.w Gfx_AnimateCreditsColors
                bsr.w Cutscene_PlanetScroll
                bsr.w Gfx_UpdateVDPRegistersWithMask
                tst.w   (word_FF00C6).l
                bne.w   locret_514E
                clr.w   (word_FFC6E2).w
                clr.w   (word_FF0118).l
                move.w  #$140,(word_FF0106).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_PlanetTransition
; Sets sprite graphics pointer from table
Sprite_SetGraphicsPointer:                               ; CODE XREF: Cutscene_PlanetZoomMainLoop+1A   p  ; was: sub_81B4
                                        ; Boss_SnakeUpdateAnimation+26   p
                moveq   #0,d0
                move.w  d1,d0
                lsl.w   #1,d1
                add.w   d1,d0
                addi.l  #stru_8630,d0
                move.l  d0,8(a5)
                rts
; End of function Sprite_SetGraphicsPointer
; Updates planet palette
Cutscene_PlanetPaletteUpdate:                               ; CODE XREF: Cutscene_PlanetSequenceCtrl+4   p  ; was: sub_81C8
                                        ; sub_816E   p ...
                lea     (word_FFC680).w,a5
                move.w  word_FFC684-word_FFC680(a5),d0
                lea     off_81D8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_PlanetPaletteUpdate
; ---------------------------------------------------------------------------
off_81D8:       dc.w Cutscene_PlanetStarfield-*         ; DATA XREF: Cutscene_PlanetPaletteUpdate+8   o
                dc.w Cutscene_PlanetShipApproach-*
                dc.w Cutscene_PlanetTextDisplay-*


; Starfield background effect
Cutscene_PlanetStarfield:                               ; DATA XREF: ROM:off_81D8   o  ; was: sub_81DE
                move.l  #$FFFFC000,$1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Cutscene_PlanetStarfield
; Ship approaching planet
Cutscene_PlanetShipApproach:                               ; DATA XREF: ROM:000081DA   o  ; was: sub_81EC
                addi.l  #$200,$1C(a5)
                cmpi.l  #$4000,$1C(a5)
                bne.w   locret_514E
                addq.w  #2,4(a5)
                rts
; End of function Cutscene_PlanetShipApproach
; Text display handler
Cutscene_PlanetTextDisplay:                               ; DATA XREF: ROM:000081DC   o  ; was: sub_8206
                subi.l  #$200,$1C(a5)
                cmpi.l  #$FFFFC000,$1C(a5)
                bne.w   locret_514E
                subq.w  #2,4(a5)
                rts
; End of function Cutscene_PlanetTextDisplay
; Dispatches to planet sprite handler based on state value
Cutscene_PlanetSpriteHandler:                               ; CODE XREF: Cutscene_PlanetZoomMainLoop+8   p  ; was: sub_8220
                lea     (Entity_ObjectPool).w,a5
                move.w  word_FFC624-Entity_ObjectPool(a5),d0
                lea     off_8230(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_PlanetSpriteHandler
; ---------------------------------------------------------------------------
off_8230:       dc.w Cutscene_InitPlanetZoom-*         ; DATA XREF: Cutscene_PlanetSpriteHandler+8   o
                dc.w Cutscene_PlanetZoomInStep-*
                dc.w Cutscene_PlanetZoomPause-*
                dc.w Cutscene_PlanetZoomComplete-*
                dc.w nullsub_19-*


; Initializes planet zoom effect with sound and stage setup
Cutscene_InitPlanetZoom:                               ; DATA XREF: ROM:off_8230   o  ; was: sub_823A
                andi.w  #$7FFF,(word_FFC682).w
                ori.w   #$8000,2(a5)
                move.w  #$1A0,(word_FF011A).l
                move.l  #$200000,(dword_FF011C).l
                move.b  #$30,d0 ; '0'
                jsr (Sound_PlaySFX).l
                move.w  #$10,(word_FF010C).l
                addq.w  #2,4(a5)
                bra.w Stage_Stage18Init
; End of function Cutscene_InitPlanetZoom
; Zooms planet sprite toward center with scaling and velocity
Cutscene_PlanetZoomInStep:                               ; DATA XREF: ROM:00008232   o  ; was: sub_8272
                bsr.w Cutscene_AnimatePlanetSprite
                bsr.w Cutscene_PlanetZoomProgress
                bsr.w Cutscene_PlanetFadeOutStep
                subi.l  #$8000,(dword_FF011C).l
                subi.w  #4,(word_FF011A).l
                move.w  (word_FF011A).l,d0
                bsr.w Math_LookupSineTable
                move.l  (dword_FF011C).l,d2
                asl.l   #8,d2
                swap    d2
                muls.w  d2,d0
                asr.l   #7,d0
                move.l  d0,$18(a5)
                muls.w  d2,d1
                asr.l   #8,d1
                move.l  d1,$1C(a5)
                tst.l   (dword_FF011C).l
                bne.w   locret_514E
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$20,$40(a5) ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Cutscene_PlanetZoomInStep
; Pauses between zoom phases and plays sound effect
Cutscene_PlanetZoomPause:                               ; DATA XREF: ROM:00008234   o  ; was: sub_82D2
                bsr.w Cutscene_AnimatePlanetSprite
                subq.w  #1,$40(a5)
                bne.w   locret_514E
                move.b  #$31,d0 ; '1'
                jsr (Sound_PlaySFX).l
                move.w  #8,(word_FF010C).l
                move.l  #$74000,$18(a5)
                move.l  #$57000,$1C(a5)
                addq.w  #2,4(a5)
                bra.w Effect_CreatePlanetDebris
; End of function Cutscene_PlanetZoomPause
; Completes planet zoom by moving sprite off-screen
Cutscene_PlanetZoomComplete:                               ; DATA XREF: ROM:00008236   o  ; was: sub_8308
                bsr.w Cutscene_AnimatePlanetSprite
                bsr.w Cutscene_PlanetZoomProgress
                bsr.w Cutscene_PlanetFadeOutStep
                bsr.w Effect_UpdatePlanetDebris
                subi.l  #$4000,$18(a5)
                subi.l  #$3000,$1C(a5)
                cmpi.w  #$120,$10(a5)
                bcs.w   locret_514E
                clr.w   2(a5)
                addq.w  #2,4(a6)
                rts
; End of function Cutscene_PlanetZoomComplete
nullsub_19:                             ; DATA XREF: ROM:00008238   o
                rts
; End of function nullsub_19


; Creates debris sprite with velocity for planet explosion effect
Effect_CreatePlanetDebris:                               ; CODE XREF: Cutscene_PlanetZoomPause+32   j  ; was: sub_833E
                lea     (word_FFD820).w,a4
                move.w  #$EC00,word_FFD822-word_FFD820(a4)
                move.w  #$10,(a4)
                move.l  #off_18B13C,8(a4)
                move.w  #$8100,$E(a4)
                clr.w   $C(a4)
                clr.w   4(a4)
                move.w  $14(a5),$14(a4)
                move.w  $10(a5),$10(a4)
                move.l  #$FFFC0000,$18(a4)
                move.l  #$FFFD0000,$1C(a4)
                rts
; End of function Effect_CreatePlanetDebris
; Updates debris sprite position and clears when off-screen
Effect_UpdatePlanetDebris:                               ; CODE XREF: Cutscene_PlanetZoomComplete+C   p  ; was: sub_8380
                lea     (word_FFD820).w,a4
                addi.l  #$4000,dword_FFD838-word_FFD820(a4)
                addi.l  #$3000,$1C(a4)
                cmpi.w  #$80,$C(a4)
                bcs.w   locret_514E
                clr.w   2(a4)
                rts
; End of function Effect_UpdatePlanetDebris
; Stage 18 initialization
Stage_Stage18Init:                               ; CODE XREF: Cutscene_InitPlanetZoom+34   j  ; was: sub_83A4
                lea     (word_FFC740).w,a4
                move.w  #$1F,d7
loc_83AC:                               ; CODE XREF: Stage_Stage18Init+68   j
                move.w  #$EC00,2(a4)
                move.w  #$10,(a4)
                move.l  #off_18B11C,8(a4)
                move.w  #$8100,$E(a4)
                clr.w   $C(a4)
                clr.w   4(a4)
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                addi.w  #$178,d0
                move.w  d0,$10(a4)
                subi.w  #$188,d0
                swap    d0
                asr.l   #5,d0
                move.l  d0,$18(a4)
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                addi.w  #$118,d0
                move.w  d0,$14(a4)
                subi.w  #$128,d0
                swap    d0
                asr.l   #5,d0
                move.l  d0,$1C(a4)
                adda.w  #$60,a4 ; '`'
                dbf     d7,loc_83AC
                rts
; End of function Stage_Stage18Init
; Iterates through sprites and clears those beyond screen bounds
Effect_ClearOffscreenSprites:                               ; CODE XREF: Cutscene_PlanetZoomMainLoop+C   p  ; was: sub_8412
                lea     (word_FFC740).w,a5
                move.w  #$1F,d7
loc_841A:                               ; CODE XREF: Effect_ClearOffscreenSprites+10   j
                bsr.w Effect_CheckAndClearSprite
                adda.w  #$60,a5 ; '`'
                dbf     d7,loc_841A
                rts
; End of function Effect_ClearOffscreenSprites
; Checks if sprite animation counter exceeds threshold and clears
Effect_CheckAndClearSprite:                               ; CODE XREF: Effect_ClearOffscreenSprites:loc_841A   p  ; was: sub_8428
                cmpi.w  #$80,$C(a5)
                bcs.w   locret_514E
                clr.w   2(a5)
                rts
; End of function Effect_CheckAndClearSprite
; Fades out planet palette gradually with timing control
Cutscene_PlanetFadeOutStep:                               ; CODE XREF: Cutscene_PlanetZoomInStep+8   p  ; was: sub_8438
                                        ; Cutscene_PlanetZoomComplete+8   p
                tst.w   (word_FF010C).l
                beq.w   locret_514E
                move.w  (word_FFA280).w,d0
                andi.w  #1,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Cutscene_PlanetFadeOutStep
; Animates planet sprite attribute cycling through 4 values
Cutscene_AnimatePlanetSprite:                               ; CODE XREF: Cutscene_PlanetZoomInStep   p  ; was: sub_846C
                                        ; sub_82D2   p ...
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                lsl.w   #1,d0
                move.w  word_847E(pc,d0.w),(word_FFC62E).w
                rts
; End of function Cutscene_AnimatePlanetSprite
; ---------------------------------------------------------------------------
word_847E:      dc.w 1, $801, $1801, $1001


; Increments planet zoom level with variable speed
Cutscene_PlanetZoomProgress:                               ; CODE XREF: Cutscene_PlanetZoomInStep+4   p  ; was: sub_8486
                                        ; Cutscene_PlanetZoomComplete+4   p
                cmpi.w  #$3E,(word_FF0118).l ; '>'
                beq.w   locret_514E
                cmpi.w  #$20,(word_FF0118).l ; ' '
                bcc.s   loc_84B2
                move.w  (word_FF0106).l,d0
                andi.w  #3,d0
                bne.w   locret_514E
                addq.w  #2,(word_FF0118).l
                rts
; ---------------------------------------------------------------------------
loc_84B2:                               ; CODE XREF: Cutscene_PlanetZoomProgress+14   j
                move.w  (word_FF0106).l,d0
                andi.w  #1,d0
                bne.w   locret_514E
                addq.w  #2,(word_FF0118).l
                rts
; End of function Cutscene_PlanetZoomProgress
; Main loop for planet zoom cutscene with subsystem coordination
Cutscene_PlanetZoomMainLoop:                               ; DATA XREF: ROM:00007C4C   o  ; was: sub_84C8
                bsr.w Gfx_AnimateCreditsColors
                bsr.w Cutscene_PlanetPaletteUpdate
                bsr.w Cutscene_PlanetSpriteHandler
                bsr.w Effect_ClearOffscreenSprites
                lea     (Entity_ObjectPool).w,a5
                move.w  (word_FF0118).l,d1
                bsr.w Sprite_SetGraphicsPointer
                bsr.w Cutscene_Calculate3DRotation
                subq.w  #1,(word_FF0106).l
                beq.w Cutscene_FinalizePlanetZoom
                cmpi.w  #$80,(word_FF0106).l
                bne.w   locret_514E
                move.b  #1,d0
                jmp (Input_ProcessButtons).l
; End of function Cutscene_PlanetZoomMainLoop
; Calculates 3D rotation perspective and updates scroll buffers
Cutscene_Calculate3DRotation:                               ; CODE XREF: Cutscene_PlanetZoomMainLoop+1E   p  ; was: sub_850A
                                        ; sub_85CC   p
                addi.l  #$80,(dword_FF0114).l
                move.l  (dword_FF0114).l,d0
                add.l   d0,(dword_FF0110).l
                move.l  (dword_FF0110).l,d1
                move.l  d1,d3
                asr.l   #2,d3
                move.l  d1,d0
                asr.l   #1,d0
                neg.l   d0
                lea     (word_FFE5C0).w,a0
                move.w  #$D,d7
loc_8538:                               ; CODE XREF: Cutscene_Calculate3DRotation+3C   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #$20,a0 ; ' '
                dbf     d7,loc_8538
                move.l  (dword_FF0110).l,d1
                move.l  d1,d0
                asr.l   #1,d0
                lea     (word_FFE5A0).w,a0
                move.w  #$D,d7
loc_855C:                               ; CODE XREF: Cutscene_Calculate3DRotation+60   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #$20,a0 ; ' '
                dbf     d7,loc_855C
                move.l  (dword_FF0110).l,d1
                move.l  d1,d3
                asr.l   #1,d3
                move.l  d1,d0
                neg.l   d0
                asl.l   #1,d1
                lea     (word_FFEC28).w,a0
                move.w  #9,d7
loc_8586:                               ; CODE XREF: Cutscene_Calculate3DRotation+8A   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #4,a0
                dbf     d7,loc_8586
                move.l  (dword_FF0110).l,d1
                move.l  d1,d0
                asl.l   #1,d1
                lea     (word_FFEC24).w,a0
                move.w  #9,d7
loc_85AA:                               ; CODE XREF: Cutscene_Calculate3DRotation+AE   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #4,a0
                dbf     d7,loc_85AA
                rts
; End of function Cutscene_Calculate3DRotation
; Finalizes planet zoom cutscene and sets transition timer
Cutscene_FinalizePlanetZoom:                               ; CODE XREF: Cutscene_PlanetZoomMainLoop+28   j  ; was: sub_85BE
                clr.w   (word_FF010C).l
                move.w  #$18,(dword_FF8128+2).w
                rts
; End of function Cutscene_FinalizePlanetZoom
; Handles fade out during planet zoom with completion check
Cutscene_PlanetZoomFadeOut:                               ; DATA XREF: ROM:00007C4E   o  ; was: sub_85CC
                bsr.w Cutscene_Calculate3DRotation
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5 ; '>'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF010C).l
                bne.w   locret_514E
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.w  #1,(dword_FF8128).w
                rts
; End of function Cutscene_PlanetZoomFadeOut
; Looks up sine and cosine values from table with angle wrapping
Math_LookupSineTable:                               ; CODE XREF: Effect_InitializeStarfield+98   p  ; was: sub_8618
                                        ; Cutscene_PlanetZoomInStep+24   p ...
                lea     (word_1B494).l,a0
                move.w  (a0,d0.w),d1
                addi.w  #$80,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d0
                rts
; End of function Math_LookupSineTable
; ---------------------------------------------------------------------------
stru_8630:      dc.w $8000              ; field_0
                                        ; DATA XREF: Cutscene_InitPlanetScene+7C   o
                                        ; Sprite_SetGraphicsPointer+8   o ...
                dc.l $F00F0F0           ; field_2
                dc.w $8010              ; field_0
                dc.l $F00F0F0           ; field_2
                dc.w $8020              ; field_0
                dc.l $F00F1F1           ; field_2
                dc.w $8030              ; field_0
                dc.l $F00F1F1           ; field_2
                dc.w $8040              ; field_0
                dc.l $F00F2F2           ; field_2
                dc.w $8050              ; field_0
                dc.l $F00F2F2           ; field_2
                dc.w $8060              ; field_0
                dc.l $F00F3F3           ; field_2
                dc.w $8070              ; field_0
                dc.l $F00F3F3           ; field_2
                dc.w $8080              ; field_0
                dc.l $A00F4F4           ; field_2
                dc.w $8089              ; field_0
                dc.l $A00F4F4           ; field_2
                dc.w $8092              ; field_0
                dc.l $A00F5F5           ; field_2
                dc.w $809B              ; field_0
                dc.l $A00F5F5           ; field_2
                dc.w $80A4              ; field_0
                dc.l $A00F6F6           ; field_2
                dc.w $80AD              ; field_0
                dc.l $A00F6F6           ; field_2
                dc.w $80B6              ; field_0
                dc.l $A00F7F7           ; field_2
                dc.w $80BF              ; field_0
                dc.l $A00F7F7           ; field_2
                dc.w $80C8              ; field_0
                dc.l $500F8F8           ; field_2
                dc.w $80CC              ; field_0
                dc.l $500F8F8           ; field_2
                dc.w $80D0              ; field_0
                dc.l $500F9F9           ; field_2
                dc.w $80D4              ; field_0
                dc.l $500F9F9           ; field_2
                dc.w $80D8              ; field_0
                dc.l $500FAFA           ; field_2
                dc.w $80DC              ; field_0
                dc.l $500FAFA           ; field_2
                dc.w $80E0              ; field_0
                dc.l $500FBFB           ; field_2
                dc.w $80E4              ; field_0
                dc.l $500FBFB           ; field_2
                dc.w $80E8              ; field_0
                dc.l $FCFC              ; field_2
                dc.w $80E9              ; field_0
                dc.l $FCFC              ; field_2
                dc.w $80EA              ; field_0
                dc.l $FDFD              ; field_2
                dc.w $80EB              ; field_0
                dc.l $FDFD              ; field_2
                dc.w $80EC              ; field_0
                dc.l $FEFE              ; field_2
                dc.w $80ED              ; field_0
                dc.l $FEFE              ; field_2
                dc.w $80EE              ; field_0
                dc.l $FFFF              ; field_2
                dc.w $80EF              ; field_0
                dc.l $FFFF              ; field_2


; Dispatches ship cutscene object with palette update condition
Cutscene_ShipObjectDispatcher:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_86F0
                cmpi.w  #$16,(word_FF0132).l
                bcc.s   loc_86FC
                bsr.s Cutscene_UpdateShipPaletteAlt
loc_86FC:                               ; CODE XREF: Cutscene_ShipObjectDispatcher+8   j
                move.w  4(a5),d0
                lea     off_8708(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_ShipObjectDispatcher
; ---------------------------------------------------------------------------
off_8708:       dc.w Cutscene_InitShipData-*         ; DATA XREF: Cutscene_ShipObjectDispatcher+10   o
                dc.w Cutscene_ShipAnimationLoop-*


; Updates ship palette based on game state flag
Cutscene_UpdateShipPaletteAlt:                               ; CODE XREF: Cutscene_ShipObjectDispatcher+A   p  ; was: sub_870C
                movea.w #(word_FFE300-M68K_RAM),a0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_8760
                movea.w #(word_FFE380-M68K_RAM),a1
                move.w  $64(a1),$64(a0)
                move.w  $66(a1),$66(a0)
                move.w  $68(a1),$68(a0)
                move.w  $6A(a1),$6A(a0)
                move.w  $6C(a1),$6C(a0)
                move.w  $6E(a1),$6E(a0)
                move.w  $74(a1),$74(a0)
                move.w  $76(a1),$76(a0)
                move.w  $78(a1),$78(a0)
                move.w  $7A(a1),$7A(a0)
                move.w  $7C(a1),$7C(a0)
                rts
; ---------------------------------------------------------------------------
loc_8760:                               ; CODE XREF: Cutscene_UpdateShipPaletteAlt+A   j
                moveq   #$20,d0 ; ' '
                move.w  #$CEE,$64(a0)
                move.w  #$2E,$66(a0) ; '.'
                move.w  #$CE,$68(a0)
                move.w  #$482,$6A(a0)
                move.w  #$AE8,$6C(a0)
                move.w  #$EEC,$6E(a0)
                add.w   d0,$74(a0)
                add.w   d0,$76(a0)
                add.w   d0,$78(a0)
                add.w   d0,$7A(a0)
                add.w   d0,$7C(a0)
                rts
; End of function Cutscene_UpdateShipPaletteAlt
; Initializes ship cutscene data pointers and state
Cutscene_InitShipData:                               ; DATA XREF: ROM:off_8708   o  ; was: sub_879C
                move.l  #word_900E,(dword_FF0128).l
                move.l  #word_917A,(dword_FF012C).l
                clr.w   (word_FF0130).l
                clr.w   (word_FF0132).l
                addq.w  #2,4(a5)
                rts
; End of function Cutscene_InitShipData
; Main ship animation loop with frame counter and completion check
Cutscene_ShipAnimationLoop:                               ; DATA XREF: ROM:0000870A   o  ; was: sub_87C2
                addq.w  #1,(word_FF0130).l
                bsr.w Cutscene_SpawnShipSprite
                bsr.w Cutscene_SpawnDebrisSprite
                bsr.w Cutscene_ShipUpdateDispatcher
                cmpi.w  #$6C0,(word_FF0130).l
                bmi.s   locret_87EE
                bclr    #0,(byte_FFA958).w
                moveq   #0,d0
                moveq   #0,d1
                jmp Sprite_ClearAllExcept
; ---------------------------------------------------------------------------
locret_87EE:                            ; CODE XREF: Cutscene_ShipAnimationLoop+1A   j
                rts
; End of function Cutscene_ShipAnimationLoop
; Dispatches ship update and rendering subsystems
Cutscene_ShipUpdateDispatcher:                               ; CODE XREF: Cutscene_ShipAnimationLoop+E   p  ; was: sub_87F0
                bsr.w Cutscene_ShipStateDispatcher
                bra.w Cutscene_ShipUpdateScroll
; End of function Cutscene_ShipUpdateDispatcher
; Jumps to current ship cutscene state handler
Cutscene_ShipStateDispatcher:                               ; CODE XREF: Cutscene_ShipUpdateDispatcher   p  ; was: sub_87F8
                move.w  (word_FF0132).l,d0
                lea     off_8806(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_ShipStateDispatcher
; ---------------------------------------------------------------------------
off_8806:       dc.w Cutscene_ShipInitWait-*         ; DATA XREF: Cutscene_ShipStateDispatcher+6   o
                dc.w Cutscene_LoadShipTiles1-*
                dc.w Cutscene_LoadShipTiles2-*
                dc.w Cutscene_LoadShipTiles3-*
                dc.w Cutscene_LoadShipTiles4-*
                dc.w Cutscene_LoadShipTiles5-*
                dc.w Cutscene_ShipTilesComplete-*
                dc.w Cutscene_ShipFadeInAlt-*
                dc.w Cutscene_ShipZoomInAlt-*
                dc.w Cutscene_WaitShipPosition-*
                dc.w Cutscene_ShipExitPrepare-*
                dc.w Cutscene_ShipInitScene-*
                dc.w Cutscene_ShipInitScene_RenderLoop-*
                dc.w Cutscene_ShipRenderLoop-*
                dc.w Cutscene_ShipFadeTransition-*
                dc.w nullsub_20-*


; Waits for frame threshold then initializes ship sprite
Cutscene_ShipInitWait:                               ; DATA XREF: ROM:off_8806   o  ; was: sub_8826
                cmpi.w  #$40,(word_FF0130).l ; '@'
                beq.s Cutscene_ShowShipName
                cmpi.w  #$200,(word_FF0130).l
                bcs.w   locret_514E
                move.b  #1,(byte_FFA95A).w
                move.l  #$FFC00000,(dword_FF0134).l
                clr.l   (dword_FF0138).l
                addq.w  #2,(word_FF0132).l
                move.b  #$D5,d0
                jsr (Sound_PlaySFX).l
                rts
; End of function Cutscene_ShipInitWait
; Displays ship name text using UI rendering system
Cutscene_ShowShipName:                               ; CODE XREF: Cutscene_ShipInitWait+8   j  ; was: sub_8864
                move.w  #0,d0
                jsr (Cutscene_InitShipNameByDiff).l
                rts
; End of function Cutscene_ShowShipName
; Loads first batch of compressed ship tiles
Cutscene_LoadShipTiles1:                               ; DATA XREF: ROM:00008808   o  ; was: sub_8870
                movea.l #word_8DA4,a0
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #$20,(word_FF013C).l ; ' '
                move.w  #$FFFF,(dword_FF0138).l
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_LoadShipTiles1
; Loads second batch of compressed ship tiles
Cutscene_LoadShipTiles2:                               ; DATA XREF: ROM:0000880A   o  ; was: sub_8894
                subq.w  #1,(word_FF013C).l
                bne.w   locret_514E
                movea.l #word_8DAC,a0
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #$20,(word_FF013C).l ; ' '
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_LoadShipTiles2
; Loads third batch of compressed ship tiles
Cutscene_LoadShipTiles3:                               ; DATA XREF: ROM:0000880C   o  ; was: sub_88BA
                subq.w  #1,(word_FF013C).l
                bne.w   locret_514E
                movea.l #word_8DB4,a0
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #$20,(word_FF013C).l ; ' '
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_LoadShipTiles3
; Loads fourth batch of compressed ship tiles
Cutscene_LoadShipTiles4:                               ; DATA XREF: ROM:0000880E   o  ; was: sub_88E0
                subq.w  #1,(word_FF013C).l
                bne.w   locret_514E
                movea.l #word_8DBC,a0
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #$20,(word_FF013C).l ; ' '
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_LoadShipTiles4
; Loads fifth batch of compressed ship tiles
Cutscene_LoadShipTiles5:                               ; DATA XREF: ROM:00008810   o  ; was: sub_8906
                subq.w  #1,(word_FF013C).l
                bne.w   locret_514E
                movea.l #word_8DC4,a0
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #$20,(word_FF013C).l ; ' '
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_LoadShipTiles5
; Advances to next state after all ship tiles loaded
Cutscene_ShipTilesComplete:                               ; DATA XREF: ROM:00008812   o  ; was: sub_892C
                subq.w  #1,(word_FF013C).l
                bne.w   locret_514E
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipTilesComplete
; Gradually fades in ship sprite by incrementing alpha
Cutscene_ShipFadeInAlt:                               ; DATA XREF: ROM:00008814   o  ; was: sub_893E
                addi.l  #$10000,(dword_FF0138).l
                tst.w   (dword_FF0138).l
                bmi.w   locret_514E
                bsr.w Gfx_EnablePriorityPlane
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipFadeInAlt
; Zooms in ship sprite by incrementing scale factor
Cutscene_ShipZoomInAlt:                               ; DATA XREF: ROM:00008816   o  ; was: sub_895E
                addi.l  #$2000,(dword_FF0138).l
                cmpi.l  #$8000,(dword_FF0138).l
                bcs.w   locret_514E
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipZoomInAlt
; Waits for ship to reach position before advancing state
Cutscene_WaitShipPosition:                               ; DATA XREF: ROM:00008818   o  ; was: sub_897E
                cmpi.w  #$FF20,(dword_FF0134).l
                bcs.w   locret_514E
                move.w  #0,d0
                jsr (Cutscene_InitShipNameByDiff).l
                clr.w   (word_FF016A).l
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_WaitShipPosition
; Prepares ship exit animation by toggling sprite flag
Cutscene_ShipExitPrepare:                               ; DATA XREF: ROM:0000881A   o  ; was: sub_89A2
                bsr.w Cutscene_ShipFlashDispatcher
                eori.w  #$8000,(word_FFC6EE).w
                cmpi.w  #$588,(word_FF0130).l
                bcs.w   locret_514E
                bsr.w Gfx_DisablePriorityPlane
                lea     (word_FFC6E2).w,a0
                move.w  #$2D,d0 ; '-'
loc_89C4:                               ; CODE XREF: Cutscene_ShipExitPrepare+2A   j
                move.w  #$1000,(a0)
                adda.w  #$60,a0 ; '`'
                dbf     d0,loc_89C4
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipExitPrepare
; Dispatches to ship flash animation state handlers
Cutscene_ShipFlashDispatcher:                               ; CODE XREF: Cutscene_ShipExitPrepare   p  ; was: sub_89D8
                move.w  (word_FF016A).l,d0
                lea     off_89E6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_ShipFlashDispatcher
; ---------------------------------------------------------------------------
off_89E6:       dc.w Cutscene_InitShipFlash-*         ; DATA XREF: Cutscene_ShipFlashDispatcher+6   o
                dc.w Cutscene_ShipFlashLoop-*
                dc.w Cutscene_RestartShipFlash-*


; Initializes ship flash effect with sound and timer
Cutscene_InitShipFlash:                               ; CODE XREF: Cutscene_RestartShipFlash+A   j  ; was: sub_89EC
                                        ; DATA XREF: ROM:off_89E6   o
                move.l  #$4000,(dword_FF0138).l
                move.w  #$40,(word_FF016C).l ; '@'
                move.w  #2,(word_FF016A).l
                move.b  #$D8,d0
                jsr (Sound_PlaySFX).l
                rts
; End of function Cutscene_InitShipFlash
; Animates ship flash by toggling palette colors
Cutscene_ShipFlashLoop:                               ; DATA XREF: ROM:000089E8   o  ; was: sub_8A12
                bsr.w Cutscene_UpdateShipColor
                eori.w  #2,(word_FFE400).w
                subq.w  #1,(word_FF016C).l
                bne.w   locret_514E
                move.l  #$FFFFC000,(dword_FF0138).l
                move.w  #$60,(word_FF016C).l ; '`'
                addq.w  #2,(word_FF016A).l
                rts
; End of function Cutscene_ShipFlashLoop
; Updates ship color palette index periodically
Cutscene_UpdateShipColor:                               ; CODE XREF: Cutscene_ShipFlashLoop   p  ; was: sub_8A40
                move.w  (word_FF016C).l,d0
                andi.w  #$1F,d0
                bne.w   locret_514E
                addi.w  #4,(dword_FF0134).l
                rts
; End of function Cutscene_UpdateShipColor
; Restarts ship flash animation after delay
Cutscene_RestartShipFlash:                               ; DATA XREF: ROM:000089EA   o  ; was: sub_8A58
                subq.w  #1,(word_FF016C).l
                bne.w   locret_514E
                bra.w Cutscene_InitShipFlash
; End of function Cutscene_RestartShipFlash
; Dispatches to ship visual effect handlers
Cutscene_ShipEffectDispatcher:
                move.w  (word_FF016E).l,d0  ; was: sub_8A66
                lea     off_8A74(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_ShipEffectDispatcher
; ---------------------------------------------------------------------------
off_8A74:       dc.w Cutscene_InitShipEffect-*         ; DATA XREF: Cutscene_ShipEffectDispatcher+6   o
                dc.w Cutscene_ShipTimerCheck-*
                dc.w Cutscene_ShipFlickerControl-*


; Initializes ship visual effect and advances state
