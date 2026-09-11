Gfx_RenderLayeredBackground:                            ; CODE XREF: Stage_LoadBackgroundGraphics+82   p  ; was: sub_10D16
                                        ; Stage_LoadBackgroundGraphics+88   p
                movea.l (dword_FFA940).w,a0
                move.w  (word_FFA946).w,d0
                move.w  (word_FFA948).w,d1
                subi.w  #$1000,d1
                neg.w   d1
                moveq   #$F,d7
loc_10D2A:                                              ; CODE XREF: Gfx_RenderLayeredBackground+94   j
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  d1,d3
                lsr.w   #8,d2
                lsr.w   #3,d3
                andi.w  #$3E0,d3
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                move.w  d4,d5
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  d1,d3
                lsr.w   #5,d2
                lsr.w   #2,d3
                andi.w  #7,d2
                andi.w  #$38,d3                         ; '8'
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #$78,d2                         ; 'x'
                movea.l (a0)+,a1
                move.w  d1,d3
                andi.w  #$18,d3
                add.w   d4,d3
                cmpi.w  #$FF,d5
                bne.s   loc_10D7C
                moveq   #0,d3
loc_10D7C:                                              ; CODE XREF: Gfx_RenderLayeredBackground+62   j
                tst.w   (a0)+
                movea.l #$FFFF0000,a2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1F80,d4
                add.w   d4,d2
                adda.w  d2,a2
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
                suba.l  #$E,a0
                addi.w  #$20,d0                         ; ' '
                dbf     d7,loc_10D2A
                bra.w   Gfx_RenderScrollingBackground
; End of function Gfx_RenderLayeredBackground
; Sets up VDP DMA for sprite data
Sprite_SetupDMA:                                        ; CODE XREF: Stage_InitTerobusterBoss+10   p  ; was: sub_10DB2
                                        ; Stage_CaterpillarScrollHandler+4   p
                tst.w   (word_FFA944).w
                bmi.w   locret_10E12
                movea.w (word_FFF70E).w,a0
                move.w  (word_FFA946).w,d0
                moveq   #$3F,d7                         ; '?'
loc_10DC4:                                              ; CODE XREF: Sprite_SetupDMA+14   j
                move.w  d0,(a0)+
                dbf     d7,loc_10DC4
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                moveq   #$1F,d0
                sub.w   (word_FFA944).w,d0
                asl.w   #7,d0
                add.w   (dword_FFA940).w,d0
                move.w  d0,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009340,-(a1)
                move.w  a1,(word_FFF70C).w
                addi.w  #$80,(word_FFF70E).w
                subq.w  #1,(word_FFA944).w
locret_10E12:                                           ; CODE XREF: Sprite_SetupDMA+4   j
                rts
; End of function Sprite_SetupDMA
; Sets up VDP DMA for VRAM transfer
VDP_SetupDMA:                                           ; CODE XREF: Gfx_SetupTitleScreenLetters+3E   p  ; was: sub_10E14
                                        ; Gfx_SetupTitleScreenLetters+50   p
                move    sr,-(sp)
                move    #$2700,sr
loc_10E1A:                                              ; CODE XREF: VDP_SetupDMA+E   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_10E1A
                lea     (VDP_CTRL).l,a4
                move.w  (VDPReg1Shadow).w,d2
                bset    #4,d2
                move.w  d2,(a4)
                movea.l #$FFFF2000,a0
                move.w  (word_FFA946).w,d0
                move.w  #$7FF,d7
loc_10E42:                                              ; CODE XREF: VDP_SetupDMA+30   j
                move.w  d0,(a0)+
                dbf     d7,loc_10E42
                move.w  #$8F02,(a4)
                move.l  #$93009408,(a4)
                move.w  #$9500,(a4)
                move.w  #$9690,(a4)
                move.w  #$977F,(a4)
                move.w  #$83,(VDPCommand).w
                move.w  (dword_FFA940).w,(a4)
                move.w  (VDPCommand).w,(a4)
                move.w  (VDPReg1Shadow).w,d0
                bclr    #4,d0
                move.w  d0,(a4)
loc_10E76:                                              ; CODE XREF: VDP_SetupDMA+6A   j
                bclr    #0,(IO_Z80BUS).l
                beq.s   loc_10E76
                move    (sp)+,sr
                rts
; End of function VDP_SetupDMA
; Copies 8x8 block of tile data to VRAM
Gfx_CopyTileBlock8x8:
                move.l  d0,d1                           ; was: sub_10E84
                swap    d1
                ori.l   #$FFFF0000,d0
                ori.l   #$FFFF0000,d1
                movea.l d0,a0
                move.l  d1,d2
                andi.w  #$1FFF,d2
                movea.l d2,a1
                move.l  (a0)+,(a1)
                move.l  (a0)+,4(a1)
                move.l  (a0)+,$80(a1)
                move.l  (a0)+,$84(a1)
                move.l  (a0)+,$100(a1)
                move.l  (a0)+,$104(a1)
                move.l  (a0)+,$180(a1)
                move.l  (a0)+,$184(a1)
                bset    #0,d0
                andi.w  #$EFFE,d1
                bra.s   loc_10ECA
; End of function Gfx_CopyTileBlock8x8
; Updates Stage 14 scroll
Scroll_UpdateStage14Scroll:                             ; CODE XREF: Stage_ShipDestructionCheckInput+16   p  ; was: sub_10EC6
                                        ; Stage_ShipDestructionCheckInput+24   p
                move.l  d0,d1
                swap    d1
loc_10ECA:                                              ; CODE XREF: Gfx_CopyTileBlock8x8+40   j
                movea.w (word_FFF70C).w,a0
                moveq   #3,d7
loc_10ED0:                                              ; CODE XREF: Scroll_UpdateStage14Scroll+36   j
                move.w  #$83,-(a0)
                move.w  d1,-(a0)
                move.w  d0,d2
                ror.w   #1,d2
                move.b  d2,d3
                asr.w   #8,d2
                move.b  d3,-(a0)
                move.b  #$95,-(a0)
                move.b  d2,-(a0)
                move.b  #$96,-(a0)
                move.l  #$8F02977F,-(a0)
                move.l  #$94009304,-(a0)
                addq.w  #8,d0
                addi.w  #$80,d1
                dbf     d7,loc_10ED0
                move.w  a0,(word_FFF70C).w
                rts
; End of function Scroll_UpdateStage14Scroll
; Sets up 4 VDP DMA commands for tile transfers
VDP_SetupDMATransferQuad:
                movea.w (word_FFF70C).w,a0              ; was: sub_10F06
                moveq   #3,d7
loc_10F0C:                                              ; CODE XREF: VDP_SetupDMATransferQuad+3E   j
                move.w  #$83,-(a0)
                move.w  d1,-(a0)
                move.l  d0,d2
                lsr.l   #1,d2
                move.l  d2,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d3
                move.b  (dword_FF8040+1).w,d4
                move.b  d2,-(a0)
                move.b  #$95,-(a0)
                move.b  d3,-(a0)
                move.b  #$96,-(a0)
                move.b  d4,-(a0)
                move.b  #$97,-(a0)
                move.w  #$8F02,-(a0)
                move.l  #$94009304,-(a0)
                addq.w  #8,d0
                addi.w  #$80,d1
                dbf     d7,loc_10F0C
                move.w  a0,(word_FFF70C).w
                rts
; End of function VDP_SetupDMATransferQuad
; Loads compressed tile data to VRAM
Gfx_LoadCompressedTiles:                                ; CODE XREF: Cutscene_FadeOutCredits+3C   p  ; was: sub_10F4E
                                        ; Cutscene_LoadShipTiles1+6   p
                move.w  (word_FFF70E).w,(word_FF805C).w
                move.l  #$94009300,(dword_FF8058).w
                moveq   #0,d0
                move.b  4(a0),d0
                addq.w  #1,d0
                lsl.w   #2,d0
                move.b  d0,(dword_FF8058+3).w
                moveq   #0,d0
                move.b  4(a0),d0
                addq.w  #1,d0
                move.w  d0,(dword_FF805E).w
                movea.l a0,a1
                adda.l  #6,a1
                movea.w (word_FFF70E).w,a3
                movea.w (word_FFF70C).w,a4
                moveq   #0,d4
                moveq   #0,d7
                move.b  5(a0),d7
loc_10F8E:                                              ; CODE XREF: Gfx_LoadCompressedTiles+AE   j
                moveq   #0,d1
                moveq   #3,d6
loc_10F92:                                              ; CODE XREF: Gfx_LoadCompressedTiles+A6   j
                moveq   #0,d5
                move.b  4(a0),d5
                moveq   #$FFFFFFFF,d0
                moveq   #0,d2
loc_10F9C:                                              ; CODE XREF: Gfx_LoadCompressedTiles+68   j
                move.w  #0,d0
                move.b  (a1,d2.w),d0
                lsl.w   #5,d0
                add.w   2(a0),d0
                movea.l d0,a2
                move.l  (a2,d1.w),(a3)+
                move.l  4(a2,d1.w),(a3)+
                addq.w  #1,d2
                dbf     d5,loc_10F9C
                move.w  #$83,-(a4)
                move.w  (a0),d2
                andi.w  #$EFFE,d2
                add.w   d4,d2
                move.w  d2,-(a4)
                move.b  (word_FFF70E).w,d2
                move.b  (word_FFF70E+1).w,d3
                asr.b   #1,d2
                roxr.b  #1,d3
                move.b  d3,-(a4)
                move.b  #$95,-(a4)
                move.b  d2,-(a4)
                move.b  #$96,-(a4)
                move.l  #$8F02977F,-(a4)
                move.l  (dword_FF8058).w,-(a4)
                move.w  a3,(word_FFF70E).w
                addq.w  #8,d1
                addi.w  #$80,d4
                dbf     d6,loc_10F92
                adda.w  (dword_FF805E).w,a1
                dbf     d7,loc_10F8E
                move.w  a4,(word_FFF70C).w
                btst    #0,1(a0)
                beq.s   locret_11044
                movea.w (word_FF805C).w,a1
                moveq   #0,d6
                move.b  5(a0),d6
                addq.w  #1,d6
                lsl.w   #2,d6
                subq.w  #1,d6
                moveq   #$FFFFFFFF,d0
                move.w  (a0),d0
                andi.w  #$1FFE,d0
                movea.l d0,a2
                moveq   #0,d5
                move.b  (dword_FF8058+3).w,d5
                subq.w  #1,d5
loc_1102E:                                              ; CODE XREF: Gfx_LoadCompressedTiles+F2   j
                moveq   #0,d0
                move.w  d5,d7
loc_11032:                                              ; CODE XREF: Gfx_LoadCompressedTiles+EA   j
                move.w  (a1)+,(a2,d0.w)
                addq.w  #2,d0
                dbf     d7,loc_11032
                adda.w  #$80,a2
                dbf     d6,loc_1102E
locret_11044:                                           ; CODE XREF: Gfx_LoadCompressedTiles+BC   j
                rts
; End of function Gfx_LoadCompressedTiles
; Sets sprite pattern index
Gfx_SetSpritePattern:                                   ; CODE XREF: Stage_InitStage17Boss+98   p  ; was: sub_11046
                                        ; Boss_ZLeoLoadInitialTilesAndPatterns+12   j
                movea.w (word_FFF70C).w,a0
loc_1104A:                                              ; CODE XREF: Gfx_SetSpritePattern+C   j
                move.w  d0,$E(a0)
                lea     $10(a0),a0
                dbf     d7,loc_1104A
                rts
; End of function Gfx_SetSpritePattern
; DMA transfers tile data to VRAM with VDP commands
Gfx_DMATransferTiles:                                   ; CODE XREF: Stage_FlyingNeoSpawn+24   j  ; was: sub_11058
                                        ; Gfx_LoadWolfGaropaTiles+6   p
                move.w  (word_FFF70E).w,(word_FF805C).w
                move.l  #$94009300,(dword_FF8058).w
                moveq   #0,d0
                move.b  5(a0),d0
                addq.w  #1,d0
                lsl.w   #2,d0
                move.b  d0,(dword_FF8058+3).w
                moveq   #0,d0
                move.b  4(a0),d0
                move.w  d0,(dword_FF805E).w
                movea.l a0,a1
                adda.l  #6,a1
                movea.w (word_FFF70E).w,a3
                movea.w (word_FFF70C).w,a4
                moveq   #0,d4
                moveq   #0,d7
                move.b  4(a0),d7
loc_11096:                                              ; CODE XREF: Gfx_DMATransferTiles+B8   j
                moveq   #0,d1
                moveq   #3,d6
loc_1109A:                                              ; CODE XREF: Gfx_DMATransferTiles+B2   j
                moveq   #0,d5
                move.b  5(a0),d5
                moveq   #$FFFFFFFF,d0
                moveq   #0,d2
                moveq   #0,d3
                move.b  4(a0),d3
                addq.w  #1,d3
loc_110AC:                                              ; CODE XREF: Gfx_DMATransferTiles+76   j
                move.w  #0,d0
                move.b  (a1,d2.w),d0
                lsl.w   #5,d0
                add.w   2(a0),d0
                movea.l d0,a2
                move.w  (a2,d1.w),(a3)+
                move.w  8(a2,d1.w),(a3)+
                move.w  $10(a2,d1.w),(a3)+
                move.w  $18(a2,d1.w),(a3)+
                add.w   d3,d2
                dbf     d5,loc_110AC
                move.w  #$83,-(a4)
                move.w  (a0),d2
                andi.w  #$EFFE,d2
                add.w   d4,d2
                move.w  d2,-(a4)
                move.b  (word_FFF70E).w,d2
                move.b  (word_FFF70E+1).w,d3
                asr.b   #1,d2
                roxr.b  #1,d3
                move.b  d3,-(a4)
                move.b  #$95,-(a4)
                move.b  d2,-(a4)
                move.b  #$96,-(a4)
                move.l  #$8F80977F,-(a4)
                move.l  (dword_FF8058).w,-(a4)
                move.w  a3,(word_FFF70E).w
                addq.w  #2,d1
                addq.w  #2,d4
                dbf     d6,loc_1109A
                addq.w  #1,a1
                dbf     d7,loc_11096
                move.w  a4,(word_FFF70C).w
                btst    #0,1(a0)
                beq.s   locret_11158
                movea.w (word_FF805C).w,a1
                moveq   #0,d6
                move.b  4(a0),d6
                addq.w  #1,d6
                lsl.w   #2,d6
                subq.w  #1,d6
                moveq   #$FFFFFFFF,d0
                move.w  (a0),d0
                andi.w  #$1FFE,d0
                movea.l d0,a2
                moveq   #0,d5
                move.b  (dword_FF8058+3).w,d5
                subq.w  #1,d5
loc_11142:                                              ; CODE XREF: Gfx_DMATransferTiles+FC   j
                moveq   #0,d0
                move.w  d5,d7
loc_11146:                                              ; CODE XREF: Gfx_DMATransferTiles+F6   j
                move.w  (a1)+,(a2,d0.w)
                addi.w  #$80,d0
                dbf     d7,loc_11146
                addq.w  #2,a2
                dbf     d6,loc_11142
locret_11158:                                           ; CODE XREF: Gfx_DMATransferTiles+C6   j
                rts
; End of function Gfx_DMATransferTiles
; ---------------------------------------------------------------------------
unused_3:       binclude "data/other/unused_3.bin"

; Loads ship tile graphics
