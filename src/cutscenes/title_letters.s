Gfx_SetupTitleScreenLetters:                            ; DATA XREF: ROM:00004980   o  ; was: sub_4B24
                tst.w   (word_FF0106).l
                bne.w   locret_514E
                move.b  #4,d0
                jsr     (Sound_QueueRequest).l
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (byte_FFF755).w
                move.b  #0,(word_FFF7F4+1).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #0,(word_FFF7E6+1).w
                move.w  #$4000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr     (VDP_SetupDMA).l
                move.w  #$6000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr     (VDP_SetupDMA).l
                lea     (VDP_CTRL).l,a0
                lea     (VDP_DATA).l,a1
                move.w  #$8F02,(a0)
                move.l  #$40000000,(a0)
                clr.w   d0
                move.w  #$1F,d1
loc_4B96:                                               ; CODE XREF: Gfx_SetupTitleScreenLetters+74   j
                move.w  d0,(a1)
                dbf     d1,loc_4B96
                movea.l #FrontendFullPaletteCommand,a0
                jsr     (Gfx_LoadPaletteCommand).l
                move.w  #$8300,d0
                move.w  #$4680,d4
                movea.l #byte_4CCC,a0
                jsr     (UI_RenderTextStringWrapped).l
                move.w  #$3C,(word_FFF74A).w            ; '<'
                clr.w   (word_FFF74E).w
                move.w  #$21,(word_FF0108).l            ; '!'
                clr.w   (word_FF010C).l
                bsr.w   Gfx_SetTitlePaletteColors
                move.w  #$10,(word_FF8090).w
                move.w  #$C,(word_FF010A).l
                lea     (word_FF1000).l,a0
                moveq   #0,d1
                move.w  #$77F,d0
loc_4BF2:                                               ; CODE XREF: Gfx_SetupTitleScreenLetters+D0   j
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
                move.w  #$3F,d0                         ; '?'
loc_4C26:                                               ; CODE XREF: Gfx_SetupTitleScreenLetters+11E   j
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
loc_4C60:                                               ; CODE XREF: Gfx_SetupTitleScreenLetters+144   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_4C60
                lea     (VDP_CTRL).l,a0
                move.w  (VDPReg1Shadow).w,d0
                bset    #4,d0
                move.w  d0,(a0)
                move.w  #$8F02,(a0)
                move.l  #$93009405,(a0)
                move.w  #$9500,(a0)
                move.w  #$9688,(a0)
                move.w  #$977F,(a0)
                move.l  #$60000081,(VDPCommand).w       ; DO_WRITE_TO_VRAM_AT_$6000_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
                move.w  (VDPReg1Shadow).w,d0
                bclr    #4,d0
                move.w  d0,(a0)
; Releases Z80 bus control and advances state machine
Sys_ReleaseZ80BusAndAdvance:                            ; CODE XREF: Gfx_SetupTitleScreenLetters+18E   j  ; was: loc_4CAA
                bclr    #0,(IO_Z80BUS).l
                beq.s   Sys_ReleaseZ80BusAndAdvance
                move    (sp)+,sr
                move    #$2300,sr
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_SetupTitleScreenLetters
; ---------------------------------------------------------------------------
byte_4CCC:      dc.b    0, 1, 2, 3, 4, 5, 6, 7, 8, 9
                                        ; DATA XREF: Gfx_SetupTitleScreenLetters+8C   o
                dc.b    $A, $B, $C, $D, $E, $F, $10, $11, $12, $13
                dc.b    $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D
                dc.b    $1E, $1F, $20, $21, $22, $23, $24, $25, $26, $27
                dc.b    $FF
byte_4CF5:      dc.b    $B, $16, $13, $F, $18, $1D, $19, $16, $E, $13
                                        ; DATA XREF: Gfx_SetupTitleScreenLetters+D4   o
                dc.b    $F, $1C, $FF

; Sets palette colors for title screen based on state
Gfx_SetTitlePaletteColors:                              ; CODE XREF: Gfx_SetupTitleScreenLetters+B0   p  ; was: sub_4D02
                                        ; Gfx_AnimateLettersExpand+12   p
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
word_4D1E:      dc.w    $EEE, $CCE, $AAE, $88C, $66C, $44C, $22A, $A, $A
word_4D30:      dc.w    $666, $666, $666, $444, $444, $224, $222, 2, 2

; Animates expanding letter effect for title screen
Gfx_AnimateLettersExpand:                               ; DATA XREF: ROM:00004982   o  ; was: sub_4D42
                cmpi.w  #1,(word_FF0108).l
                beq.w   loc_4E96
                addq.w  #2,(word_FF010C).l
                bsr.w   Gfx_SetTitlePaletteColors
                subq.w  #4,(word_FF0108).l
                lea     (word_FF1000).l,a0
                moveq   #0,d1
                move.w  #$27F,d0
loc_4D6A:                                               ; CODE XREF: Gfx_AnimateLettersExpand+2A   j
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
loc_4D92:                                               ; CODE XREF: Gfx_AnimateLettersExpand+84   j
                move.w  #3,d5
loc_4D96:                                               ; CODE XREF: Gfx_AnimateLettersExpand+76   j
                move.b  -(a0),d1
                move.w  d4,d3
loc_4D9A:                                               ; CODE XREF: Gfx_AnimateLettersExpand+72   j
                move.b  d1,(a1)
                move.w  a1,d7
                andi.w  #3,d7
                bne.s   loc_4DB2
                suba.l  #$3C,a1                         ; '<'
                cmpa.l  #$FFFF1000,a1
                bcs.s   loc_4DBC
loc_4DB2:                                               ; CODE XREF: Gfx_AnimateLettersExpand+60   j
                subq.l  #1,a1
                dbf     d3,loc_4D9A
                dbf     d5,loc_4D96
loc_4DBC:                                               ; CODE XREF: Gfx_AnimateLettersExpand+6E   j
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
loc_4DEC:                                               ; CODE XREF: Gfx_AnimateLettersExpand+DA   j
                move.w  #3,d5
loc_4DF0:                                               ; CODE XREF: Gfx_AnimateLettersExpand+D0   j
                move.b  (a0)+,d1
                move.b  d1,d2
                move.w  d4,d3
loc_4DF6:                                               ; CODE XREF: Gfx_AnimateLettersExpand:loc_4E0E   j
                move.b  d1,(a1)+
                move.w  a1,d7
                andi.w  #3,d7
                bne.s   loc_4E0E
                adda.l  #$3C,a1                         ; '<'
                cmpa.l  #$FFFF1A00,a1
                bcc.s   loc_4E16
loc_4E0E:                                               ; CODE XREF: Gfx_AnimateLettersExpand+BC   j
                dbf     d3,loc_4DF6
                dbf     d5,loc_4DF0
loc_4E16:                                               ; CODE XREF: Gfx_AnimateLettersExpand+CA   j
                addq.l  #4,a0
                addq.l  #4,a2
                movea.l a2,a1
                dbf     d6,loc_4DEC
loc_4E20:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+106   j
                lea     (word_FF9CE0).w,a0
                move.w  #$70,d0                         ; 'p'
                move.w  #$70,d1                         ; 'p'
loc_4E2C:                                               ; CODE XREF: Gfx_AnimateLettersExpand+104   j
                move.w  (word_FF0108).l,d3
loc_4E32:                                               ; CODE XREF: Gfx_AnimateLettersExpand+FE   j
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
loc_4E4A:                                               ; CODE XREF: Gfx_AnimateLettersExpand+FC   j
                lea     (word_FF9CE0).w,a0
                move.w  #$6F,d0                         ; 'o'
                move.w  #$6F,d1                         ; 'o'
loc_4E56:                                               ; CODE XREF: Gfx_AnimateLettersExpand+12A   j
                move.w  (word_FF0108).l,d3
loc_4E5C:                                               ; CODE XREF: Gfx_AnimateLettersExpand+124   j
                move.w  d0,d4
                sub.w   d1,d4
                move.w  d4,-(a0)
                subq.w  #1,d1
                bmi.s   loc_4E70
                dbf     d3,loc_4E5C
                subq.w  #1,d0
                bra.w   loc_4E56
; ---------------------------------------------------------------------------
loc_4E70:                                               ; CODE XREF: Gfx_AnimateLettersExpand+122   j
                movea.w (word_FFF70C).w,a0
                suba.w  #$10,a0
                move.w  a0,(word_FFF70C).w
                move.l  #$94059300,(a0)+
                move.l  #$8F02977F,(a0)+
                move.l  #$96889500,(a0)+
                move.l  #$60000081,(a0)+
                rts
; ---------------------------------------------------------------------------
loc_4E96:                                               ; CODE XREF: Gfx_AnimateLettersExpand+8   j
                move.b  #$12,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$21,(word_FF0108).l            ; '!'
                clr.w   (word_FF010C).l
                lea     (word_FF1000).l,a0
                moveq   #0,d1
                move.w  #$27F,d0
loc_4EBA:                                               ; CODE XREF: Gfx_AnimateLettersExpand+17A   j
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
                move.w  #$3F,d0                         ; '?'
loc_4EEE:                                               ; CODE XREF: Gfx_AnimateLettersExpand+1C8   j
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
loc_4F10:                                               ; CODE XREF: Gfx_AnimateLettersExpand+184   j
                lea     (byte_FF2080).l,a1
                movea.l #byte_4FC8,a2
                move.w  #$C,d3
loc_4F20:                                               ; CODE XREF: Gfx_AnimateLettersExpand+210   j
                moveq   #0,d0
                move.b  (a2)+,d0
                lsl.w   #6,d0
                addi.l  #tiles_font,d0
                movea.l d0,a0
                move.w  #$3F,d0                         ; '?'
loc_4F32:                                               ; CODE XREF: Gfx_AnimateLettersExpand+20C   j
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
loc_4F5C:                                               ; CODE XREF: Gfx_AnimateLettersExpand+222   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_4F5C
                lea     (VDP_CTRL).l,a0
                move.w  (VDPReg1Shadow).w,d0
                bset    #4,d0
                move.w  d0,(a0)
                move.w  #$8F02,(a0)
                move.l  #$93009405,(a0)
                move.w  #$9500,(a0)
                move.w  #$9688,(a0)
                move.w  #$977F,(a0)
                move.l  #$60000081,(VDPCommand).w       ; DO_WRITE_TO_VRAM_AT_$6000_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
                move.w  (VDPReg1Shadow).w,d0
                bclr    #4,d0
                move.w  d0,(a0)
; Completes Z80 bus release and advances to next state
Sys_CompleteZ80BusReleaseAndAdvance:                    ; CODE XREF: Gfx_AnimateLettersExpand+26C   j  ; was: loc_4FA6
                bclr    #0,(IO_Z80BUS).l
                beq.s   Sys_CompleteZ80BusReleaseAndAdvance
                move    (sp)+,sr
                move    #$2300,sr
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_AnimateLettersExpand
; ---------------------------------------------------------------------------
byte_4FC8:      dc.b    $B, $16, $13, $F, $18, 0, $1D, $19, $16, $E, $13, $F, $1C, $FF
                                        ; DATA XREF: Gfx_AnimateLettersExpand+1D4   o

; Animates large expanding letter effect with scrolling
Gfx_AnimateLettersExpandLarge:                          ; DATA XREF: ROM:00004984   o  ; was: sub_4FD6
                cmpi.w  #1,(word_FF0108).l
                beq.w   loc_50E0
                addq.w  #2,(word_FF010C).l
                bsr.w   Gfx_SetTitlePaletteColors
                subq.w  #4,(word_FF0108).l
                lea     (word_FF1000).l,a0
                moveq   #0,d1
                move.w  #$27F,d0
loc_4FFE:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+2A   j
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
loc_5024:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+96   j
                move.w  #$33,d5                         ; '3'
loc_5028:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge:loc_5060   j
                move.b  -(a0),d1
                move.w  d4,d3
loc_502C:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+70   j
                move.b  d1,(a1)
                move.w  a1,d7
                andi.w  #3,d7
                bne.s   loc_5044
                suba.l  #$3C,a1                         ; '<'
                cmpa.l  #$FFFF1000,a1
                bcs.s   loc_5064
loc_5044:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+5E   j
                subq.l  #1,a1
                dbf     d3,loc_502C
                move.w  a0,d7
                andi.w  #7,d7
                bne.s   loc_5060
                suba.l  #$78,a0                         ; 'x'
                cmpa.l  #$FFFF1A00,a0
                bcs.s   loc_5064
loc_5060:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+7A   j
                dbf     d5,loc_5028
loc_5064:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+6C   j
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
loc_5090:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+102   j
                move.w  #$33,d5                         ; '3'
loc_5094:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge:loc_50CC   j
                move.b  (a0)+,d1
                move.b  d1,d2
                move.w  d4,d3
loc_509A:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge:loc_50B2   j
                move.b  d1,(a1)+
                move.w  a1,d7
                andi.w  #3,d7
                bne.s   loc_50B2
                adda.l  #$3C,a1                         ; '<'
                cmpa.l  #$FFFF1A00,a1
                bcc.s   loc_50D0
loc_50B2:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+CC   j
                dbf     d3,loc_509A
                move.w  a0,d7
                andi.w  #7,d7
                bne.s   loc_50CC
                adda.l  #$78,a0                         ; 'x'
                cmpa.l  #$FFFF2E00,a0
                bcc.s   loc_50D0
loc_50CC:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+E6   j
                dbf     d5,loc_5094
loc_50D0:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+DA   j
                                        ; Gfx_AnimateLettersExpandLarge+F4   j
                addq.l  #8,a2
                movea.l a2,a0
                addq.l  #4,a3
                movea.l a3,a1
                dbf     d6,loc_5090
                bra.w   loc_4E20
; ---------------------------------------------------------------------------
loc_50E0:                                               ; CODE XREF: Gfx_AnimateLettersExpandLarge+8   j
                move.b  #$38,d0                         ; '8'
                jsr     (Sound_PlaySFX).l
                move.w  #$1C0,(word_FF0106).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Gfx_AnimateLettersExpandLarge
; Transitions from story screen to title screen
Sys_TransitionToTitleScreen:                            ; DATA XREF: ROM:00004986   o  ; was: sub_50F8
                subq.w  #1,(word_FF0106).l
                bne.w   locret_514E
loc_5102:                                               ; CODE XREF: Sys_StoryScreenMainLoop+1C   j
                                        ; Effect_UpdateGameRotation+44   j
                bclr    #0,(word_FF80F4).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                move.b  #1,d0
                jsr     (Sound_QueueRequest).l
                move.w  #$18,(GameSubstateIndex).w
                rts
; End of function Sys_TransitionToTitleScreen
; Exits story screen and returns to mode select
Sys_ExitStoryScreen:                                    ; DATA XREF: ROM:00004988   o  ; was: sub_5130
                bclr    #1,(word_FF80F4).w
                beq.w   locret_514E
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (byte_FFF755).w
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
locret_514E:                                            ; CODE XREF: UI_WaitForTimerAndButton+8   j
                                        ; Gfx_WaitForTimerAndResetFade+8   j
                rts
; End of function Sys_ExitStoryScreen
; Dispatches planet rotation cutscene state machine using jump table
