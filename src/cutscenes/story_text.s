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
