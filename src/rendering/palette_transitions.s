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
