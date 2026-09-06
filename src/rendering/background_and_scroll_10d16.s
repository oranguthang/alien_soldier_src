Gfx_RenderLayeredBackground:                              ; CODE XREF: Stage_LoadBackgroundGraphics+82   p  ; was: sub_10D16
                                        ; Stage_LoadBackgroundGraphics+88   p
                movea.l (dword_FFA940).w,a0
                move.w  (word_FFA946).w,d0
                move.w  (word_FFA948).w,d1
                subi.w  #$1000,d1
                neg.w   d1
                moveq   #$F,d7
loc_10D2A:                              ; CODE XREF: Gfx_RenderLayeredBackground+94   j
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
                andi.w  #$38,d3 ; '8'
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #$78,d2 ; 'x'
                movea.l (a0)+,a1
                move.w  d1,d3
                andi.w  #$18,d3
                add.w   d4,d3
                cmpi.w  #$FF,d5
                bne.s   loc_10D7C
                moveq   #0,d3
loc_10D7C:                              ; CODE XREF: Gfx_RenderLayeredBackground+62   j
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
                addi.w  #$20,d0 ; ' '
                dbf     d7,loc_10D2A
                bra.w Gfx_RenderScrollingBackground
; End of function Gfx_RenderLayeredBackground
; Sets up VDP DMA for sprite data
Sprite_SetupDMA:                              ; CODE XREF: Stage_InitTerobusterBoss+10   p  ; was: sub_10DB2
                                        ; Stage_CaterpillarScrollHandler+4   p ...
                tst.w   (word_FFA944).w
                bmi.w   locret_10E12
                movea.w (word_FFF70E).w,a0
                move.w  (word_FFA946).w,d0
                moveq   #$3F,d7 ; '?'
loc_10DC4:                              ; CODE XREF: Sprite_SetupDMA+14   j
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
locret_10E12:                           ; CODE XREF: Sprite_SetupDMA+4   j
                rts
; End of function Sprite_SetupDMA
; Sets up VDP DMA for VRAM transfer
VDP_SetupDMA:                              ; CODE XREF: Gfx_SetupTitleScreenLetters+3E   p  ; was: sub_10E14
                                        ; Gfx_SetupTitleScreenLetters+50   p ...
                move    sr,-(sp)
                move    #$2700,sr
loc_10E1A:                              ; CODE XREF: VDP_SetupDMA+E   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_10E1A
                lea     (VDP_CTRL).l,a4
                move.w  (word_FFF7D2).w,d2
                bset    #4,d2
                move.w  d2,(a4)
                movea.l #$FFFF2000,a0
                move.w  (word_FFA946).w,d0
                move.w  #$7FF,d7
loc_10E42:                              ; CODE XREF: VDP_SetupDMA+30   j
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
                move.w  (word_FFF7D2).w,d0
                bclr    #4,d0
                move.w  d0,(a4)
loc_10E76:                              ; CODE XREF: VDP_SetupDMA+6A   j
                bclr    #0,(IO_Z80BUS).l
                beq.s   loc_10E76
                move    (sp)+,sr
                rts
; End of function VDP_SetupDMA
; Copies 8x8 block of tile data to VRAM
Gfx_CopyTileBlock8x8:
                move.l  d0,d1  ; was: sub_10E84
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
Scroll_UpdateStage14Scroll:                              ; CODE XREF: Stage_ShipDestructionCheckInput+16   p  ; was: sub_10EC6
                                        ; Stage_ShipDestructionCheckInput+24   p ...
                move.l  d0,d1
                swap    d1
loc_10ECA:                              ; CODE XREF: Gfx_CopyTileBlock8x8+40   j
                movea.w (word_FFF70C).w,a0
                moveq   #3,d7
loc_10ED0:                              ; CODE XREF: Scroll_UpdateStage14Scroll+36   j
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
                movea.w (word_FFF70C).w,a0  ; was: sub_10F06
                moveq   #3,d7
loc_10F0C:                              ; CODE XREF: VDP_SetupDMATransferQuad+3E   j
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
Gfx_LoadCompressedTiles:                              ; CODE XREF: Cutscene_FadeOutCredits+3C   p  ; was: sub_10F4E
                                        ; Cutscene_LoadShipTiles1+6   p ...
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
loc_10F8E:                              ; CODE XREF: Gfx_LoadCompressedTiles+AE   j
                moveq   #0,d1
                moveq   #3,d6
loc_10F92:                              ; CODE XREF: Gfx_LoadCompressedTiles+A6   j
                moveq   #0,d5
                move.b  4(a0),d5
                moveq   #$FFFFFFFF,d0
                moveq   #0,d2
loc_10F9C:                              ; CODE XREF: Gfx_LoadCompressedTiles+68   j
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
loc_1102E:                              ; CODE XREF: Gfx_LoadCompressedTiles+F2   j
                moveq   #0,d0
                move.w  d5,d7
loc_11032:                              ; CODE XREF: Gfx_LoadCompressedTiles+EA   j
                move.w  (a1)+,(a2,d0.w)
                addq.w  #2,d0
                dbf     d7,loc_11032
                adda.w  #$80,a2
                dbf     d6,loc_1102E
locret_11044:                           ; CODE XREF: Gfx_LoadCompressedTiles+BC   j
                rts
; End of function Gfx_LoadCompressedTiles
; Sets sprite pattern index
Gfx_SetSpritePattern:                              ; CODE XREF: Stage_InitStage17Boss+98   p  ; was: sub_11046
                                        ; Boss_ZLeoGraphicsInit3+12   j
                movea.w (word_FFF70C).w,a0
loc_1104A:                              ; CODE XREF: Gfx_SetSpritePattern+C   j
                move.w  d0,$E(a0)
                lea     $10(a0),a0
                dbf     d7,loc_1104A
                rts
; End of function Gfx_SetSpritePattern
; DMA transfers tile data to VRAM with VDP commands
Gfx_DMATransferTiles:                              ; CODE XREF: Stage_FlyingNeoSpawn+24   j  ; was: sub_11058
                                        ; Gfx_LoadWolfGaropaTiles+6   p ...
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
loc_11096:                              ; CODE XREF: Gfx_DMATransferTiles+B8   j
                moveq   #0,d1
                moveq   #3,d6
loc_1109A:                              ; CODE XREF: Gfx_DMATransferTiles+B2   j
                moveq   #0,d5
                move.b  5(a0),d5
                moveq   #$FFFFFFFF,d0
                moveq   #0,d2
                moveq   #0,d3
                move.b  4(a0),d3
                addq.w  #1,d3
loc_110AC:                              ; CODE XREF: Gfx_DMATransferTiles+76   j
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
loc_11142:                              ; CODE XREF: Gfx_DMATransferTiles+FC   j
                moveq   #0,d0
                move.w  d5,d7
loc_11146:                              ; CODE XREF: Gfx_DMATransferTiles+F6   j
                move.w  (a1)+,(a2,d0.w)
                addi.w  #$80,d0
                dbf     d7,loc_11146
                addq.w  #2,a2
                dbf     d6,loc_11142
locret_11158:                           ; CODE XREF: Gfx_DMATransferTiles+C6   j
                rts
; End of function Gfx_DMATransferTiles
; ---------------------------------------------------------------------------
unused_3:	binclude	"data/other/unused_3.bin"


; Loads ship tile graphics
Stage_LoadShipGraphics:                              ; CODE XREF: Stage_LoadStage10Enemies+1C   j  ; was: sub_11170
                                        ; Boss_ViblackInit+BC   p
                moveq   #$FFFFFFFF,d1
                move.w  (a0)+,d1
                movea.l d1,a1
                moveq   #5,d3
                bra.s   loc_11192
; ---------------------------------------------------------------------------
loc_1117A:                              ; CODE XREF: Stage_LoadShipGraphics+2A   j
                asl.w   d3,d1
                moveq   #$F,d7
loc_1117E:                              ; CODE XREF: Stage_LoadShipGraphics+1E   j
                move.w  (a1,d1.w),d2
                andi.w  #$1FFF,d2
                add.w   d0,d2
                move.w  d2,(a1,d1.w)
                addq.w  #2,d1
                dbf     d7,loc_1117E
loc_11192:                              ; CODE XREF: Stage_LoadShipGraphics+8   j
                moveq   #0,d1
                move.b  (a0)+,d1
                cmpi.w  #$FF,d1
                bne.s   loc_1117A
                rts
; End of function Stage_LoadShipGraphics
; Adjusts tile pattern indices
Gfx_AdjustTileIndices:                              ; CODE XREF: UI_InitTitleScreen+60   p  ; was: sub_1119E
                                        ; Boss_WolfGaropaGraphicsInit+8   j ...
                moveq   #$F,d6
loc_111A0:                              ; CODE XREF: Gfx_AdjustTileIndices+C   j
                move.w  (a0),d2
                andi.w  #$1FFF,d2
                add.w   d0,d2
                move.w  d2,(a0)+
                dbf     d6,loc_111A0
                dbf d7,Gfx_AdjustTileIndices
                rts
; End of function Gfx_AdjustTileIndices
; Updates tilemap tile indices and palette bits with offset
Gfx_UpdateTilemapIndices:                              ; CODE XREF: UI_InitTitleScreen+78   p  ; was: sub_111B4
                                        ; Boss_SireneSpawnProjectile2+2C   p ...
                moveq   #$F,d6
loc_111B6:                              ; CODE XREF: Gfx_UpdateTilemapIndices+1C   j
                move.w  (a0),d2
                move.w  d2,d3
                andi.w  #$1800,d3
                andi.w  #$7FF,d2
                beq.s   loc_111CA
                add.w   d1,d2
                andi.w  #$7FF,d2
loc_111CA:                              ; CODE XREF: Gfx_UpdateTilemapIndices+E   j
                or.w    d3,d2
                add.w   d0,d2
                move.w  d2,(a0)+
                dbf     d6,loc_111B6
                dbf d7,Gfx_UpdateTilemapIndices
                rts
; End of function Gfx_UpdateTilemapIndices
; Transfers a single font tile to VRAM
VDP_TransferFontTile:                              ; CODE XREF: UI_WeaponSelectTransition+10   p  ; was: sub_111DA
                tst.w   (word_FF8148).w
                bmi.w   locret_11254
                movea.w (word_FFF70C).w,a1
                move.w  (word_FF8146).w,d0
                move.w  d0,d1
                andi.w  #$3FFE,d0
                addi.w  #$4000,d0
                andi.w  #$C000,d1
                moveq   #$E,d2
                lsr.w   d2,d1
                addi.w  #$80,d1
                move.w  d1,-(a1)
                move.w  d0,-(a1)
                move.l  #$94029300,d4
                moveq   #0,d0
                move.w  (word_FF814A).w,d0
                addi.l  #tiles_font,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d2
                move.b  (dword_FF8040+1).w,d3
                andi.w  #$7F,d3
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d2,-(a1)
                move.b  #$96,-(a1)
                move.b  d3,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  d4,-(a1)
                move.w  a1,(word_FFF70C).w
                addi.w  #$400,(word_FF8146).w
                addi.w  #$400,(word_FF814A).w
                subq.w  #1,(word_FF8148).w
locret_11254:                           ; CODE XREF: VDP_TransferFontTile+4   j
                rts
; End of function VDP_TransferFontTile
; Writes VDP command registers
Gfx_WriteVDPCommand:                              ; CODE XREF: Sys_TransitionToStageInit+36   j  ; was: sub_11256
                                        ; UI_InitializeStageStart+46   j
                movea.w (word_FFF70C).w,a1
                move.w  #$80,-(a1)
                move.w  #$6000,-(a1)
                move.l  #$94209000,d4
                bra.s   loc_112A4
; End of function Gfx_WriteVDPCommand
; Sets up VDP command to transfer to palette RAM
VDP_SetupPaletteTransfer:                              ; CODE XREF: Stage_InitializeStageSelect+3E   j  ; was: sub_1126A
                movea.w (word_FFF70C).w,a1
                move.w  #$80,-(a1)
                move.w  #$6000,-(a1)
                move.l  #$94069300,d4
                bra.s   loc_112A4
; End of function VDP_SetupPaletteTransfer
; Queues VRAM write command for plane A at address 0x6000
Gfx_QueueVRAMCommand:                              ; CODE XREF: RegionRestricted+1E   p  ; was: sub_1127E
                                        ; UI_InitTitleScreen+44   j ...
                movea.w (word_FFF70C).w,a1
                move.w  #$81,-(a1)
                move.w  #$6000,-(a1)
                move.l  #$94209000,d4
                bra.s   loc_112A4
; End of function Gfx_QueueVRAMCommand
; Queues DMA transfer for font tiles to VRAM with Z80 sync
Gfx_QueueFontDMATransfer:                              ; CODE XREF: UI_InitializePasswordScreen+10   p  ; was: sub_11292
                                        ; UI_InitializePasswordScreen+32   p
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                move.w  #$5400,-(a1)
                move.l  #$94059300,d4
loc_112A4:                              ; CODE XREF: Gfx_WriteVDPCommand+12   j
                                        ; VDP_SetupPaletteTransfer+12   j ...
                move.l  #tiles_font,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d2
                move.b  (dword_FF8040+1).w,d3
                andi.w  #$7F,d3
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d2,-(a1)
                move.b  #$96,-(a1)
                move.b  d3,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  d4,-(a1)
                move    sr,-(sp)
                move    #$2700,sr
loc_112DA:                              ; CODE XREF: Gfx_QueueFontDMATransfer+50   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_112DA
                lea     (VDP_CTRL).l,a0
                move.w  (word_FFF7D2).w,d0
                bset    #4,d0
                move.w  d0,(a0)
                move.l  (a1)+,(a0)
                move.l  (a1)+,(a0)
                move.l  (a1)+,(a0)
                move.w  (a1)+,(a0)
                move.w  (a1)+,(a0)
                move.w  (word_FFF7D2).w,d0
                bclr    #4,d0
                move.w  d0,(a0)
; Releases Z80 bus control and restores status register
Gfx_ReleaseZ80Bus:                              ; CODE XREF: Gfx_QueueFontDMATransfer+7E   j  ; was: loc_11308
                bclr    #0,(IO_Z80BUS).l
                beq.s Gfx_ReleaseZ80Bus
                move    (sp)+,sr
                rts
; End of function Gfx_QueueFontDMATransfer
; ---------------------------------------------------------------------------
dword_11316:    dc.l $FFFF7000, $FFFF6000, $FFFF4000, $14000
                                        ; DATA XREF: UI_InitTitleScreen+7E   o
                                        ; sub_106FE   o ...
dword_11326:    dc.l $FFFF7000, $FFFF6000, $FFFF4000, $4000
                                        ; DATA XREF: Cutscene_InitCreditsScreen+4A   o
                                        ; Cutscene_SegaScreenFadeOut+4A   o ...
dword_11336:    dc.l $FFFF7000, $FFFF6800, $FFFF2000, $6000
                                        ; DATA XREF: UI_InitTitleScreen+96   o
                                        ; UI_InitOptionsScreen+56   o ...
dword_11346:    dc.l $FFFF7000, $FFFF6000, $FFFF4000, $6000
                                        ; DATA XREF: Gfx_FadeToTargetAndSetupScroll+1E   o
                                        ; Cutscene_ShipInitScene+8C   o ...
                dc.l $FFFF7400, $FFFF6800, $FFFF4000, $14000
stru_11366:     dc.w $E4                ; field_0
                                        ; DATA XREF: Stage_InitBossIntro+28   o
                dc.l stru_11370         ; field_2
                dc.l byte_C252          ; field_6
stru_11370:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11366   o
                dc.l tiles_1067C2       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF
stru_1137A:     dc.w $30                ; field_0
                                        ; DATA XREF: Camera_TransitionToBossArena+28   o
                dc.l stru_11384         ; field_2
                dc.l byte_C272          ; field_6
stru_11384:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_1137A   o
                dc.l tiles_1081AA       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF
stru_1138E:     dc.w $F4                ; field_0
                                        ; DATA XREF: Camera_LockToBossArena+28   o
                dc.l stru_11398         ; field_2
                dc.l byte_C292          ; field_6
stru_11398:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_1138E   o
                dc.l tiles_10B9FE       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_113AA:     dc.w $24                ; field_0
                                        ; DATA XREF: Camera_FollowTarget+34   o
                dc.l dword_0            ; field_2
                dc.l byte_C2B2          ; field_6
stru_113B4:     dc.w $118               ; field_0
                                        ; DATA XREF: Boss_MadamBarbarScrollInit+2A   o
                dc.l stru_113BE         ; field_2
                dc.l byte_C2D2          ; field_6
stru_113BE:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_113B4   o
                dc.l tiles_112288       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_113D0:     dc.w $15C               ; field_0
                                        ; DATA XREF: Stage_InitJokerBoss+2A   o
                dc.l stru_113DA         ; field_2
                dc.l byte_C2F2          ; field_6
stru_113DA:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_113D0   o
                dc.l tiles_113934       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_113EC:     dc.w $B4                ; field_0
                                        ; DATA XREF: Stage_InitTerobusterBoss+50   o
                dc.l stru_113F6         ; field_2
                dc.l byte_C312          ; field_6
stru_113F6:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_113EC   o
                dc.l tiles_109546       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_11408:     dc.w $154               ; field_0
                                        ; DATA XREF: Stage_FlyingNeoBattleStart+A   o
                dc.l stru_11412         ; field_2
                dc.l dword_0            ; field_6
stru_11412:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11408   o
                dc.l tiles_114DF8       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_11424:     dc.w $114               ; field_0
                                        ; DATA XREF: Stage_InitXiTigerBoss+3A   o
                dc.l stru_1142E         ; field_2
                dc.l byte_C370          ; field_6
stru_1142E:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11424   o
                dc.l tiles_116C9C       ; field_2
                dc.w $5000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_11440:     dc.w $19C               ; field_0
                                        ; DATA XREF: Stage_DeepStriderTransition+26   o
                dc.l stru_1144A         ; field_2
                dc.l byte_C390          ; field_6
stru_1144A:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11440   o
                dc.l tiles_11B542       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF
stru_11454:     dc.w $1B0               ; field_0
                                        ; DATA XREF: Stage_GustheadTransition+26   o
                dc.l stru_1145E         ; field_2
                dc.l byte_C3B0          ; field_6
stru_1145E:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11454   o
                dc.l tiles_11E5E0       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF
stru_11468:     dc.w $21C               ; field_0
                                        ; DATA XREF: Stage_SharpssteelTransition+12   o
                dc.l stru_11472         ; field_2
                dc.l byte_C3D0          ; field_6
stru_11472:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11468   o
                dc.l tiles_11F310       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF
stru_1147C:     dc.w $300               ; field_0
                                        ; DATA XREF: Stage_BugmaxWaitDMA+38   o
                dc.l stru_11486         ; field_2
                dc.l byte_C59E          ; field_6
stru_11486:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_1147C   o
                dc.l tiles_12AB8C       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_11498:     dc.w $3C0               ; field_0
                                        ; DATA XREF: Stage_InitBossPaletteScroll+24   o
                dc.l stru_114A2         ; field_2
                dc.l byte_C424          ; field_6
stru_114A2:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11498   o
                dc.l tiles_120FF8       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_114B4:     dc.w $1EC               ; field_0
                                        ; DATA XREF: Stage_SunsetStingTransition+2E   o
                dc.l stru_114BE         ; field_2
                dc.l byte_C444          ; field_6
stru_114BE:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_114B4   o
                dc.l tiles_11D002       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_114D0:     dc.w $314               ; field_0
                                        ; DATA XREF: Boss_BackStringerTimerState+14   o
                dc.l stru_114DA         ; field_2
                dc.l byte_C4BE          ; field_6
stru_114DA:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_114D0   o
                dc.l tiles_121932       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF
stru_114E4:     dc.w $218               ; field_0
                                        ; DATA XREF: Stage_JampanPostBattle+28   o
                                        ; Stage_InitBossPhase1+1A   o
                dc.l stru_114EE         ; field_2
                dc.l byte_C55E          ; field_6
stru_114EE:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_114E4   o
                dc.l tiles_12453E       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_11500:     dc.w $264               ; field_0
                                        ; DATA XREF: Stage_Epsilon1BattleStart+8   o
                dc.l stru_1150A         ; field_2
                dc.l byte_C4DE          ; field_6
stru_1150A:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11500   o
                dc.l tiles_1233B4       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_1151C:     dc.w $240               ; field_0
                                        ; DATA XREF: Stage_DestroyerMK2Init+30   o
                dc.l stru_11526         ; field_2
                dc.l byte_C57E          ; field_6
stru_11526:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_1151C   o
                dc.l tiles_124CCE       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
; UNUSED BOSS: "Love Penguin" ($01C0) - Hand-shaped boss
; Source: TCRF https://tcrf.net/Alien_Soldier
; Graphics: tiles_11A8FC (stru_11542), Palette: byte_C404
; Never referenced by stage dispatcher
; Activation: ROM 0x00036C: 4E71 4E71, ROM 0x01147C: 01C0 00 01 15 42 00 00 C4 04
; (YouTube: Zetaman, 28 Oct 2021)
                dc.w $1C0               ; Boss ID: Love Penguin (UNUSED)
                dc.l stru_11542         ; Graphics structure pointer
                dc.l byte_C404          ; Palette data pointer
stru_11542:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:00011538   o
                dc.l tiles_11A8FC       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_11554:     dc.w $34C               ; field_0
                                        ; DATA XREF: Boss_ShieldViperInit+14   o
                dc.l stru_1155E         ; field_2
                dc.l byte_C77E          ; field_6
stru_1155E:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11554   o
                dc.l tiles_1338F2       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF
stru_11568:     dc.w $3B8               ; field_0
                                        ; DATA XREF: Boss_DestroyerProtoTransition+10   o
                dc.l stru_11572         ; field_2
                dc.l byte_C75E          ; field_6
stru_11572:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11568   o
                dc.l tiles_13963E       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1402E2        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_11584:     dc.w $3E8               ; field_0
                                        ; DATA XREF: Boss_WolfGaropaIntroMove+14   o
                dc.l stru_1158E         ; field_2
                dc.l byte_C79E          ; field_6
stru_1158E:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11584   o
                dc.l tiles_1355D6       ; field_2
                dc.w $3C00              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_136512       ; field_2
                dc.w $5100              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_140F00        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
; ===============================================================================
; UNUSED BOSS STRUCTURE: Lambda Bunny ($03EC)
; Source: TCRF https://tcrf.net/Alien_Soldier
; Description: Cowboy rabbit boss, fully defined but never used in any stage
; Loader Function: sub_E6D6 (line 16524)
; Graphics Data: tiles_125902 (7 chunks to VRAM $6000)
; Palette Data: byte_C5BE
; Status: Complete structure, never referenced by stage dispatcher
; Activation: ROM 0x00036C: 4E71 4E71, ROM 0x0113B4: 03EC 00 01 15 B2 00 00 C5 BE
; (YouTube: Zetaman, 2 Nov 2021 - shows unused gun firing animation)
; ===============================================================================
stru_115A8:     dc.w $3EC               ; Boss ID: Lambda Bunny (UNUSED)
                                        ; DATA XREF: Stage_InitBossPhase2+1A   o
                dc.l stru_115B2         ; Graphics structure pointer
                dc.l byte_C5BE          ; Palette data pointer
stru_115B2:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_115A8   o
                dc.l tiles_125902       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1402E2        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
; ===============================================================================
; UNUSED BOSS STRUCTURE: Unknown Boss ($3F0)
; Source: TCRF research
; Description: Unknown boss type, fully defined but never used
; Loader Function: sub_E72C (line 16555)
; Graphics Data: tiles_12772E (7 chunks to VRAM $6000)
; Palette Data: byte_C5DE
; Status: Complete structure, identity unknown, never referenced
; ===============================================================================
stru_115C4:     dc.w $3F0               ; Boss ID: Unknown (UNUSED)
                                        ; DATA XREF: Stage_InitBossPhase3+1A   o
                dc.l stru_115CE         ; Graphics structure pointer
                dc.l byte_C5DE          ; Palette data pointer
stru_115CE:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_115C4   o
                dc.l tiles_12772E       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1402E2        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
; ===============================================================================
; UNUSED BOSS STRUCTURE: Unknown Boss ($3F4)
; Source: TCRF research / YouTube (Zetaman)
; Description: Unknown boss type, possibly Praying Mantis or Sigma Fox
; Loader Function: sub_E782 (line 16639)
; Graphics Data: tiles_12E96C (7 chunks to VRAM $6000)
; Palette Data: byte_C5FE
; Status: Complete structure, identity unknown, never referenced
; Note: May be related to unused Jampan Area stages
; ===============================================================================
stru_115E0:     dc.w $3F4               ; Boss ID: Unknown (UNUSED)
                                        ; DATA XREF: Stage_InitBossPhase4+1A   o
                dc.l stru_115EA         ; Graphics structure pointer
                dc.l byte_C5FE          ; Palette data pointer
stru_115EA:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_115E0   o
                dc.l tiles_12E96C       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1402E2        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
; UNUSED BOSS: "Dragon" ($03FC)
; Source: TCRF https://tcrf.net/Alien_Soldier
; Graphics: tiles_12D012 (stru_11606), Palette: byte_C63E
; Never referenced by stage dispatcher
                dc.w $3FC               ; Boss ID: Dragon (UNUSED)
                dc.l stru_11606         ; Graphics structure pointer
                dc.l byte_C63E          ; Palette data pointer
stru_11606:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:000115FC   o
                dc.l tiles_12D012       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1402E2        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_11618:     dc.w $3F8               ; field_0
                                        ; DATA XREF: Boss_ZLeoTransition+2A   o
                dc.l stru_11622         ; field_2
                dc.l byte_C7DE          ; field_6
stru_11622:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11618   o
                dc.l tiles_13A92A       ; field_2
                dc.w $5000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_13C166       ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_141018        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_1163C:     dc.w $3D0               ; field_0
                                        ; DATA XREF: Boss_MissirayTransition+10   o
                dc.l stru_11646         ; field_2
                dc.l byte_C7BE          ; field_6
stru_11646:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_1163C   o
                dc.l tiles_134F02       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1402E2        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
stru_11658:     dc.w $42C               ; field_0
                                        ; DATA XREF: Boss_ValkirieMain+36   o
                dc.l stru_11662         ; field_2
                dc.l byte_C67E          ; field_6
stru_11662:     dc.w 7                  ; field_0
                                        ; DATA XREF: ROM:stru_11658   o
                                        ; ROM:stru_11694   o
                dc.l tiles_130B4E       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF
stru_1166C:     dc.w $430               ; field_0
                                        ; DATA XREF: Boss_MedusaMain+4A   o
                dc.l dword_0            ; field_2
                dc.l byte_C69E          ; field_6
stru_11676:     dc.w $434               ; field_0
                                        ; DATA XREF: Boss_SireneMain+1A   o
                dc.l dword_0            ; field_2
                dc.l byte_C6FE          ; field_6
stru_11680:     dc.w $438               ; field_0
                                        ; DATA XREF: Boss_ArtemisMain+78   o
                dc.l dword_0            ; field_2
                dc.l byte_C6DE          ; field_6
stru_1168A:     dc.w $43C               ; field_0
                                        ; DATA XREF: Boss_SireneDeathFlash2+1C   o
                dc.l dword_0            ; field_2
                dc.l byte_C73E          ; field_6
stru_11694:     dc.w $440               ; field_0
                                        ; DATA XREF: Boss_SireneDeathFlash1+1C   o
                dc.l stru_11662         ; field_2
                dc.l byte_C71E          ; field_6
stru_1169E:     dc.w $444               ; field_0
                                        ; DATA XREF: Boss_SylpheedMain+50   o
                dc.l dword_0            ; field_2
                dc.l byte_C6BE          ; field_6


; Updates boss palette with fade or flash effect
Gfx_UpdateBossPalette:                              ; CODE XREF: Stage_InitBossIntro+2E   j  ; was: sub_116A8
                                        ; Camera_TransitionToBossArena+2E   j ...
                movea.w #(word_FFC620-M68K_RAM),a0
loc_116AC:                              ; CODE XREF: Boss_BackStringerTimerState+1A   p
                moveq   #0,d0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.w  (a1)+,-$60(a0)
                movea.l (a1)+,a0
                move.l  (a1)+,(dword_FF8040).w
                move.b  #6,(byte_FF80EC).w
                bset    #7,(dword_FFA20E).w
                clr.w   (word_FF8114).w
                bset    #0,(byte_FFA272).w
                move.l  a0,d0
                beq.s   loc_11708
                jsr (Data_ProcessPointer).l
loc_11708:                              ; CODE XREF: Gfx_UpdateBossPalette+58   j
                move.l  (dword_FF8040).w,(dword_FF8040).w
                beq.s   locret_11720
                movea.l (dword_FF8040).w,a0
                jsr (Gfx_SyncPaletteBuffers).l
                jmp (Data_LoadPaletteTable).l
; ---------------------------------------------------------------------------
locret_11720:                           ; CODE XREF: Gfx_UpdateBossPalette+66   j
                rts
; End of function Gfx_UpdateBossPalette
; Dispatches to stage-specific object data loader
Stage_DispatchObjectLoader:                              ; CODE XREF: UI_InitializePasswordScreen+16   p  ; was: sub_11722
                                        ; Password_InitializeScreen+10   p ...
                bsr.w Stage_LoadObjectData
                move.w  (word_FFA204).w,d0
                movea.w off_11736(pc,d0.w),a0
                adda.l  #Stage_LoadObjectData,a0
                jmp     (a0)
; End of function Stage_DispatchObjectLoader
; ---------------------------------------------------------------------------
off_11736:      dc.w Stage_LoadStage1Objects-Stage_LoadObjectData
                                        ; DATA XREF: Stage_DispatchObjectLoader+8   r
                dc.w Stage_LoadStage1Objects-Stage_LoadObjectData
                dc.w Stage_LoadStage1Objects-Stage_LoadObjectData
                dc.w Stage_LoadStage1Phase1-Stage_LoadObjectData
                dc.w Stage_LoadStage1Phase2-Stage_LoadObjectData
                dc.w Stage_LoadStage1Phase2-Stage_LoadObjectData
                dc.w Stage_LoadStage1Phase2-Stage_LoadObjectData
                dc.w Stage_LoadStage8Objects-Stage_LoadObjectData
                dc.w Stage_LoadStage1Phase3-Stage_LoadObjectData
                dc.w Stage_LoadStage10Enemies-Stage_LoadObjectData
                dc.w Stage_LoadStage10Enemies-Stage_LoadObjectData
                dc.w Stage_LoadStage10Enemies-Stage_LoadObjectData
                dc.w Stage_LoadTeleportGraphics-Stage_LoadObjectData
                dc.w Stage_LoadStage16Objects-Stage_LoadObjectData
                dc.w Stage_LoadStage16Objects-Stage_LoadObjectData
                dc.w Stage_LoadStage16Objects-Stage_LoadObjectData
                dc.w Stage_LoadStage2Phase1-Stage_LoadObjectData
                dc.w Gfx_LoadStage18Palette-Stage_LoadObjectData
                dc.w Gfx_LoadStage18Palette-Stage_LoadObjectData
                dc.w Gfx_LoadStage20Tiles-Stage_LoadObjectData
                dc.w Stage_LoadStage3Phase2-Stage_LoadObjectData
                dc.w Stage_LoadStage3Phase2-Stage_LoadObjectData
                dc.w Stage_LoadStage3Phase1-Stage_LoadObjectData
                dc.w Stage_LoadStage3Phase3-Stage_LoadObjectData
                dc.w Stage_LoadStage3Phase6-Stage_LoadObjectData
                dc.w Stage_LoadStage3Phase7-Stage_LoadObjectData


; Loads stage object spawn data from table pointer
Stage_LoadObjectData:                              ; CODE XREF: Stage_DispatchObjectLoader   p  ; was: sub_1176A
                                        ; DATA XREF: Stage_DispatchObjectLoader+C   o ...
                lea     stru_11776(pc),a0
                nop
                jmp     (LoadObjData).l
; End of function Stage_LoadObjectData
; ---------------------------------------------------------------------------
stru_11776:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadObjectData   o
                dc.l byte_18DF92        ; field_2
                dc.w $D000              ; field_6
                dc.w $FFFF


; Loads object data for stage 1 (Xi-Tiger)
Stage_LoadStage1Objects:                              ; CODE XREF: Stage_LoadStage1Phase1+4   p  ; was: sub_11780
                                        ; DATA XREF: ROM:off_11736   o ...
                clr.w   (word_FFA206).w
                lea     stru_11790(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Objects
; ---------------------------------------------------------------------------
stru_11790:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage1Objects+4   o
                dc.l tiles_18E5D2       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_19051C       ; field_2
                dc.w $2B80              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_19BAB4       ; field_2
                dc.w $5AC0              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_192C38        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_193010        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_192F7C        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19382C        ; field_2
                dc.w $2000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19C724        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads initial object set for Stage 1 phase 1
Stage_LoadStage1Phase1:                              ; DATA XREF: ROM:0001173C   o  ; was: sub_117E2
                clr.w   (word_FFA206).w
                bsr.w Stage_LoadStage1Objects
                lea     stru_117F6(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Phase1
; ---------------------------------------------------------------------------
stru_117F6:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage1Phase1+8   o
                dc.l tiles_1912EC       ; field_2
                dc.w $2B80              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_19BAB4       ; field_2
                dc.w $5AC0              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_192FC6        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_193DBE        ; field_2
                dc.w $2000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF
stru_11820:     dc.w 7                  ; field_0
                                        ; DATA XREF: Camera_ShellshogunBossInit+26   o
                dc.l tiles_1912EC       ; field_2
                dc.w $2B80              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_19BAB4       ; field_2
                dc.w $5AC0              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_192FC6        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_193DBE        ; field_2
                dc.w $2000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 1 phase 2
Stage_LoadStage1Phase2:                              ; DATA XREF: ROM:0001173E   o  ; was: sub_11842
                                        ; ROM:00011740   o ...
                clr.w   (word_FFA206).w
                lea     stru_11852(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Phase2
; ---------------------------------------------------------------------------
stru_11852:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage1Phase2+4   o
                dc.l tiles_1942B8       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_19BC68       ; field_2
                dc.w $5BE0              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19794C        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_197C28        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19C754        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object data for stage 8 (train/Flying-Neo)
Stage_LoadStage8Objects:                              ; DATA XREF: ROM:00011744   o  ; was: sub_1188C
                clr.w   (word_FFA206).w
                lea     stru_1189C(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage8Objects
; ---------------------------------------------------------------------------
stru_1189C:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage8Objects+4   o
                dc.l tiles_198E2C       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_19AEA6       ; field_2
                dc.w $3AC0              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_19BF9E       ; field_2
                dc.w $3D00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19AF40        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19B0F6        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 1 phase 3
Stage_LoadStage1Phase3:                              ; DATA XREF: ROM:00011746   o  ; was: sub_118D6
                clr.w   (word_FFA206).w
                lea     stru_118E6(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Phase3
; ---------------------------------------------------------------------------
stru_118E6:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage1Phase3+4   o
                dc.l tiles_198E2C       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_19AEA6       ; field_2
                dc.w $3AC0              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_19BF9E       ; field_2
                dc.w $3D00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19AF40        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19B0F6        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_140B0C        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_140B98        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l tiles_19AEA6       ; field_2
                dc.w $9600              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads Stage 10 enemy configuration
Stage_LoadStage10Enemies:                              ; DATA XREF: ROM:00011748   o  ; was: sub_11938
                                        ; ROM:0001174A   o ...
                move.w  #4,(word_FFA206).w
                lea     stru_1195A(pc),a0
                nop
                jsr     CheckFlagsLoadObjData(pc) ; (pc)
                nop
                lea     byte_119BC(pc),a0
                nop
                move.w  #$A000,d0
                jmp Stage_LoadShipGraphics
; End of function Stage_LoadStage10Enemies
; ---------------------------------------------------------------------------
stru_1195A:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage10Enemies+6   o
                dc.l tiles_19C77E       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1A1026       ; field_2
                dc.w $4000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_104310       ; field_2
                dc.w $3720              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_104784       ; field_2
                dc.w $1840              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19FACA        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19FF2E        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A2840        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A2878        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7400              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A0FDA        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF
byte_119BC:     dc.b $40, 0, $D1, $D2, $D3, $D5, $D6, $D7, $DC, $E4
                                        ; DATA XREF: Stage_LoadStage10Enemies+12   o
                dc.b $FF, 0


; Loads graphics for teleport scene
Stage_LoadTeleportGraphics:                              ; CODE XREF: Stage_TeleportFadeIn+64   p  ; was: sub_119C8
                                        ; DATA XREF: ROM:0001174E   o
                move.w  #4,(word_FFA206).w
                lea     stru_119FA(pc),a0
                nop
                jsr     (LoadObjData).l
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9600-M68K_RAM),a1
                move.w  #$6000,(word_FF8048).w
                move.w  #$F,(word_FF804A).w
                move.w  #1,(dword_FF8044+2).w
                jmp Gfx_LoadTilesLoop
; End of function Stage_LoadTeleportGraphics
; ---------------------------------------------------------------------------
stru_119FA:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadTeleportGraphics+6   o
                dc.l tiles_19C77E       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_19E8A8       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1A1026       ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19FE62        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A08DA        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A2840        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A2878        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7400              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A0FDA        ; field_2
                dc.w $7800              ; field_6
                dc.w 6                  ; field_0
                dc.l tiles_120E1C       ; field_2
                dc.w $9600              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object data for stage 16/17 (Sylpheed)
Stage_LoadStage16Objects:                              ; DATA XREF: ROM:00011750   o  ; was: sub_11A5C
                                        ; ROM:00011752   o ...
                move.w  #4,(word_FFA206).w
                lea     stru_11A6E(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage16Objects
; ---------------------------------------------------------------------------
stru_11A6E:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage16Objects+6   o
                dc.l tiles_1A2C46       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F2816        ; field_2
                dc.w $5F00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A6276        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A648A        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_13F4B0        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A74F6        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads initial object set for Stage 2 phase 1
Stage_LoadStage2Phase1:                              ; DATA XREF: ROM:00011756   o  ; was: sub_11AB0
                move.w  #4,(word_FFA206).w
                lea     stru_11AC2(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage2Phase1
; ---------------------------------------------------------------------------
stru_11AC2:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage2Phase1+6   o
                dc.l tiles_1A752A       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1A8F0E       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A8B30        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A8B88        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads Stage 18 palette
Gfx_LoadStage18Palette:                              ; DATA XREF: ROM:00011758   o  ; was: sub_11AF4
                                        ; ROM:0001175A   o
                move.w  #8,(word_FFA206).w
                lea     stru_11B06(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Gfx_LoadStage18Palette
; ---------------------------------------------------------------------------
stru_11B06:     dc.w 7                  ; field_0
                                        ; DATA XREF: Gfx_LoadStage18Palette+6   o
                dc.l tiles_1A9CC4       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1ACB68       ; field_2
                dc.w $2A00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1ABB28        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1ABC72        ; field_2
                dc.w $6400              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1ABCFC        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1AF030        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1AF09C        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B3A26        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B109C        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1B0F08       ; field_2
                dc.w $8E00              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 2 phase 2
Stage_LoadStage2Phase2:
                move.w  #8,(word_FFA206).w  ; was: sub_11B60
                lea     stru_11B72(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage2Phase2
; ---------------------------------------------------------------------------
stru_11B72:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage2Phase2+6   o
                dc.l tiles_1B10FA       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B33E8        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B3458        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B3A26        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads Stage 20 tiles
Gfx_LoadStage20Tiles:                              ; DATA XREF: ROM:0001175C   o  ; was: sub_11B9C
                move.w  #8,(word_FFA206).w
                lea     stru_11BAE(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Gfx_LoadStage20Tiles
; ---------------------------------------------------------------------------
stru_11BAE:     dc.w 7                  ; field_0
                                        ; DATA XREF: Gfx_LoadStage20Tiles+6   o
                dc.l tiles_1B5466       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1B3A9E       ; field_2
                dc.w $3000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B6C40        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B6C82        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B3EDE        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B401E        ; field_2
                dc.w $6200              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B412A        ; field_2
                dc.w $6400              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B41DA        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1B3A26        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 1
Stage_LoadStage3Phase1:                              ; DATA XREF: ROM:00011762   o  ; was: sub_11C00
                move.w  #$C,(word_FFA206).w
                bset    #0,(byte_FF8144).w
                bset    #7,(byte_FFA959).w
                bra.s   loc_11C2A
; End of function Stage_LoadStage3Phase1
; Loads object set for Stage 3 phase 2
Stage_LoadStage3Phase2:                              ; DATA XREF: ROM:0001175E   o  ; was: sub_11C14
                                        ; ROM:00011760   o
                move.w  #$C,(word_FFA206).w
                bset    #0,(byte_FF8144).w
                bset    #7,(byte_FFA959).w
                bsr.w Stage_LoadTiles2
loc_11C2A:                              ; CODE XREF: Stage_LoadStage3Phase1+12   j
                lea     stru_11C36(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase2
; ---------------------------------------------------------------------------
stru_11C36:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase2:loc_11C2A   o
                dc.l tiles_1BE762       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C0FB2        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1108        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C17AC        ; field_2
                dc.w $5A00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CF798        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 3
Stage_LoadStage3Phase3:                              ; DATA XREF: ROM:00011764   o  ; was: sub_11C70
                move.w  #$C,(word_FFA206).w
                lea     stru_11C82(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase3
; ---------------------------------------------------------------------------
stru_11C82:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase3+6   o
                dc.l tiles_1C1A94       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1CECB4       ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C2934        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C2968        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 4
Stage_LoadStage3Phase4:
                move.w  #$C,(word_FFA206).w  ; was: sub_11CB4
                lea     stru_11CC6(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase4
; ---------------------------------------------------------------------------
stru_11CC6:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase4+6   o
                dc.l tiles_1C2B90       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1CE2E0       ; field_2
                dc.w $5800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C5506        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C55CE        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 5
Stage_LoadStage3Phase5:
                move.w  #$C,(word_FFA206).w  ; was: sub_11CF8
                lea     stru_11D0A(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase5
; ---------------------------------------------------------------------------
stru_11D0A:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase5+6   o
                dc.l tiles_1C5DE4       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C65FA        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C6620        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 6
Stage_LoadStage3Phase6:                              ; DATA XREF: ROM:00011766   o  ; was: sub_11D34
                move.w  #$C,(word_FFA206).w
                lea     stru_11D46(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase6
; ---------------------------------------------------------------------------
stru_11D46:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase6+6   o
                dc.l tiles_1C92B0       ; field_2
                dc.w 0                  ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1C67BE       ; field_2
                dc.w $1800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C9FDC        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CA046        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C8C34        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C8CB4        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CF7BE        ; field_2
                dc.w $7800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Loads object set for Stage 3 phase 7
Stage_LoadStage3Phase7:                              ; DATA XREF: ROM:00011768   o  ; was: sub_11D90
                move.w  #$C,(word_FFA206).w
                bset    #0,(byte_FF8144).w
                lea     stru_11DA8(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc) ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase7
; ---------------------------------------------------------------------------
stru_11DA8:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage3Phase7+C   o
                dc.l tiles_1CA32E       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CD746        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CD7EC        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Stage state machine dispatcher
Stage_StateDispatcher:                              ; CODE XREF: Camera_UpdateSmooth+E   p  ; was: sub_11DD2
                                        ; Stage_TriggerPhaseTransition+12   p ...
                clr.b   (byte_FFA230).w
                move.w  (word_FFA204).w,d0
                movea.w off_11DE6(pc,d0.w),a0
                adda.l  #Gfx_LoadTileData,a0
                jmp     (a0)
; End of function Stage_StateDispatcher
; ---------------------------------------------------------------------------
off_11DE6:      dc.w Gfx_LoadStagePalette-Gfx_LoadTileData
                                        ; DATA XREF: Stage_StateDispatcher+8   r
                dc.w Stage_LoadVisualAssets-Gfx_LoadTileData
                dc.w Stage_LoadStage3Assets-Gfx_LoadTileData
                dc.w Stage_LoadPaletteAndTilesA-Gfx_LoadTileData
                dc.w Stage_LoadPaletteAndTilesB-Gfx_LoadTileData
                dc.w Stage_LoadStage6Graphics-Gfx_LoadTileData
                dc.w Stage_LoadStage7Graphics-Gfx_LoadTileData
                dc.w Stage_LoadTrainGraphics-Gfx_LoadTileData
                dc.w Stage_LoadFliesGraphics-Gfx_LoadTileData
                dc.w Stage_LoadStage10Assets-Gfx_LoadTileData
                dc.w Stage_LoadStage11Assets-Gfx_LoadTileData
                dc.w Stage_LoadStage12Assets-Gfx_LoadTileData
                dc.w Gfx_LoadSnakePalette-Gfx_LoadTileData
                dc.w Stage_LoadStage14Graphics-Gfx_LoadTileData
                dc.w Stage_LoadStage5Graphics-Gfx_LoadTileData
                dc.w Stage_LoadStage17Graphics-Gfx_LoadTileData
                dc.w Gfx_LoadStage17Palettes-Gfx_LoadTileData
                dc.w Gfx_Stage18Background-Gfx_LoadTileData
                dc.w Gfx_LoadStage19Graphics-Gfx_LoadTileData
                dc.w Gfx_LoadStage20Graphics-Gfx_LoadTileData
                dc.w Stage_LoadTiles1-Gfx_LoadTileData
                dc.w Stage22_LoadGraphics-Gfx_LoadTileData
                dc.w Weapon_EmptyState0-Gfx_LoadTileData
                dc.w Stage24_LoadGraphics-Gfx_LoadTileData
                dc.w Weapon_EmptyState1-Gfx_LoadTileData
                dc.w Weapon_EmptyState2-Gfx_LoadTileData


; Loads tile data into tables
Gfx_LoadTileData:                              ; CODE XREF: Gfx_LoadStagePalette+12   j  ; was: sub_11E1A
                                        ; Stage_LoadVisualAssets+12   j ...
                movea.w #(byte_FF82A0-M68K_RAM),a1
                movea.w #(word_FF826E-M68K_RAM),a2
                lea     off_11E6A(pc),a3
                nop
loc_11E28:                              ; CODE XREF: Gfx_LoadTileData+1E   j
                                        ; Gfx_LoadTileData+3E   j
                move.w  (a0)+,d0
                bmi.s Gfx_ProcessTileDataEnd
                btst    #0,d0
                beq.s   loc_11E3C
                move.w  d0,(a1)+
                move.l  (a0)+,(a1)+
                move.w  (a0)+,(a1)+
                bra.w   loc_11E28
; ---------------------------------------------------------------------------
loc_11E3C:                              ; CODE XREF: Gfx_LoadTileData+16   j
                move.w  d0,d1
                asl.w   #1,d1
                move.w  (a0)+,d2
                move.w  #7,(a1)+
                move.l  (a3,d1.w),(a1)+
                move.w  d2,(a1)+
                lsr.w   #5,d2
                move.w  d2,(a2,d0.w)
                ori.w   #$800,(a2,d0.w)
                bra.w   loc_11E28
; ---------------------------------------------------------------------------
; Finalizes tile data loading and processes pointer queue
Gfx_ProcessTileDataEnd:                              ; CODE XREF: Gfx_LoadTileData+10   j  ; was: loc_11E5C
                move.w  #$FFFF,(a1)
                movea.w #(byte_FF82A0-M68K_RAM),a0
                jmp (Data_ProcessPointer).l
; End of function Gfx_LoadTileData
; ---------------------------------------------------------------------------
off_11E6A:      dc.l tiles_1001D6       ; DATA XREF: Gfx_LoadTileData+8   o
                dc.l tiles_100DA2
                dc.l tiles_1018F0
                dc.l tiles_10213C
                dc.l tiles_102AE0
                dc.l tiles_103124
                dc.l tiles_103A26


; Loads stage palette data
Gfx_LoadStagePalette:                              ; DATA XREF: ROM:off_11DE6   o  ; was: sub_11E86
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11E9C(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Gfx_LoadStagePalette
; ---------------------------------------------------------------------------
word_11E9C:     dc.w 0, $6000, 2, $7000, 4, $8000, $FFFF
                                        ; DATA XREF: Gfx_LoadStagePalette+C   o


; Loads stage palette and tile data
Stage_LoadVisualAssets:                              ; DATA XREF: ROM:00011DE8   o  ; was: sub_11EAA
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11EC0(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadVisualAssets
; ---------------------------------------------------------------------------
word_11EC0:     dc.w 0, $6000, 2, $7000, $C, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadVisualAssets+C   o


; Loads Stage 3 palette and tile graphics
Stage_LoadStage3Assets:                              ; DATA XREF: ROM:00011DEA   o  ; was: sub_11ECE
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11EE4(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadStage3Assets
; ---------------------------------------------------------------------------
word_11EE4:     dc.w 0, $7000, 8, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage3Assets+C   o


; Loads stage 5 palette and first tileset via DMA
Stage_LoadPaletteAndTilesA:                              ; DATA XREF: ROM:00011DEC   o  ; was: sub_11EEE
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11F04(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadPaletteAndTilesA
; ---------------------------------------------------------------------------
word_11F04:     dc.w 0, $7000, 8, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadPaletteAndTilesA+C   o


; Loads stage 5 palette and second tileset via DMA
Stage_LoadPaletteAndTilesB:                              ; DATA XREF: ROM:00011DEE   o  ; was: sub_11F0E
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11F24(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadPaletteAndTilesB
; ---------------------------------------------------------------------------
word_11F24:     dc.w 0, $6000, 2, $7000, 6, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadPaletteAndTilesB+C   o


; Loads Stage 6 palette and tile graphics data to VRAM
Stage_LoadStage6Graphics:                              ; DATA XREF: ROM:00011DF0   o  ; was: sub_11F32
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11F48(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadStage6Graphics
; ---------------------------------------------------------------------------
word_11F48:     dc.w 0, $6000, 2, $7000, 4, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage6Graphics+C   o


; Loads Stage 7 palette and tile graphics data to VRAM
Stage_LoadStage7Graphics:                              ; DATA XREF: ROM:00011DF2   o  ; was: sub_11F56
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11F6C(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadStage7Graphics
; ---------------------------------------------------------------------------
word_11F6C:     dc.w 0, $6000, 4, $7000, 7, $10, $4F32, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage7Graphics+C   o


; Loads train stage tile graphics to VRAM
Stage_LoadTrainGraphics:                              ; DATA XREF: ROM:00011DF4   o  ; was: sub_11F7E
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11F94(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadTrainGraphics
; ---------------------------------------------------------------------------
word_11F94:     dc.w 0, $6000, 7, $11, $63AE, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadTrainGraphics+C   o


; Loads palette and tile graphics for flies stage
Stage_LoadFliesGraphics:                              ; DATA XREF: ROM:00011DF6   o  ; was: sub_11FA2
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11FB8(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadFliesGraphics
; ---------------------------------------------------------------------------
word_11FB8:     dc.w $C, $8000, $FFFF   ; DATA XREF: Stage_LoadFliesGraphics+C   o


; Loads palette and tile graphics for Stage 10
Stage_LoadStage10Assets:                              ; DATA XREF: ROM:00011DF8   o  ; was: sub_11FBE
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11FD4(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadStage10Assets
; ---------------------------------------------------------------------------
word_11FD4:     dc.w 0, $6000, 6, $7000, $A, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage10Assets+C   o


; Loads palette and tile assets
Stage_LoadStage11Assets:                              ; DATA XREF: ROM:00011DFA   o  ; was: sub_11FE2
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_11FF8(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadStage11Assets
; ---------------------------------------------------------------------------
word_11FF8:     dc.w 0, $6000, 6, $7000, 4, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage11Assets+C   o


; Loads Stage 12 palette and tiles
Stage_LoadStage12Assets:                              ; DATA XREF: ROM:00011DFC   o  ; was: sub_12006
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_1201C(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadStage12Assets
; ---------------------------------------------------------------------------
word_1201C:     dc.w 0, $6000, 6, $7000, $A, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage12Assets+C   o


; Loads Snake boss palette
Gfx_LoadSnakePalette:                              ; DATA XREF: ROM:00011DFE   o  ; was: sub_1202A
                lea     (byte_C3F0).l,a0
                jmp     LoadPalette
; End of function Gfx_LoadSnakePalette
; Loads tile data for Stage 4 at VRAM $6000
Gfx_LoadStage4Tiles:
                lea     word_12040(pc),a0  ; was: sub_12036
                nop
                bra.w Gfx_LoadTileData
; End of function Gfx_LoadStage4Tiles
; ---------------------------------------------------------------------------
word_12040:     dc.w 0, $6000, $FFFF    ; DATA XREF: Gfx_LoadStage4Tiles   o


; Loads Stage 14 graphics
Stage_LoadStage14Graphics:                              ; DATA XREF: ROM:00011E00   o  ; was: sub_12046
                bset    #0,(byte_FF80F8).w
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_12062(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadStage14Graphics
; ---------------------------------------------------------------------------
word_12062:     dc.w 0, $6000, $FFFF    ; DATA XREF: Stage_LoadStage14Graphics+12   o


; Loads Stage 5 palette and graphics data
Stage_LoadStage5Graphics:                              ; DATA XREF: ROM:00011E02   o  ; was: sub_12068
                bset    #0,(byte_FF80F8).w
                lea     (byte_C1E2).l,a0
                jsr     (LoadPalette).l
                lea     stru_12086(pc),a0
                nop
                jmp (Data_ProcessPointer).l
; End of function Stage_LoadStage5Graphics
; ---------------------------------------------------------------------------
stru_12086:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadStage5Graphics+12   o
                dc.l tiles_104B22       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF


; Loads Stage 17 graphics
Stage_LoadStage17Graphics:                              ; DATA XREF: ROM:00011E04   o  ; was: sub_12090
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_120A6(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Stage_LoadStage17Graphics
; ---------------------------------------------------------------------------
word_120A6:     dc.w $C, $6000, 7, $12, $3172, $7000, $FFFF
                                        ; DATA XREF: Stage_LoadStage17Graphics+C   o


; Loads palettes for stage 17
Gfx_LoadStage17Palettes:                              ; DATA XREF: ROM:00011E06   o  ; was: sub_120B4
                lea     (byte_BF2C).l,a0
                jsr     (LoadPalette).l
                lea     (byte_C4DE).l,a0
                jmp Gfx_SyncPaletteBuffers
; End of function Gfx_LoadStage17Palettes
; Background graphics setup
Gfx_Stage18Background:                              ; DATA XREF: ROM:00011E08   o  ; was: sub_120CC
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_120E2(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Gfx_Stage18Background
; ---------------------------------------------------------------------------
word_120E2:     dc.w $C, $6000, 7, $10, $5B9E, $7000, $FFFF
                                        ; DATA XREF: Gfx_Stage18Background+C   o


; Loads Stage 19 graphics
Gfx_LoadStage19Graphics:                              ; DATA XREF: ROM:00011E0A   o  ; was: sub_120F0
                lea     (byte_C1A2).l,a0
                jsr     (LoadPalette).l
                lea     word_12106(pc),a0
                nop
                bra.w Gfx_LoadTileData
; End of function Gfx_LoadStage19Graphics
; ---------------------------------------------------------------------------
word_12106:     dc.w 6, $6000, $C, $7000, $FFFF
                                        ; DATA XREF: Gfx_LoadStage19Graphics+C   o


nullsub_138:
                rts
; End of function nullsub_138


; Loads Stage 20 graphics
Gfx_LoadStage20Graphics:                              ; DATA XREF: ROM:00011E0C   o  ; was: sub_12112
                lea     stru_1211E(pc),a0
                nop
                jmp (Data_ProcessPointer).l
; End of function Gfx_LoadStage20Graphics
; ---------------------------------------------------------------------------
stru_1211E:     dc.w 7                  ; field_0
                                        ; DATA XREF: Gfx_LoadStage20Graphics   o
                dc.l tiles_132E9A       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF


; Loads stage tiles 1
Stage_LoadTiles1:                              ; DATA XREF: ROM:00011E0E   o  ; was: sub_12128
                lea     stru_12134(pc),a0
                nop
                jmp (Data_ProcessPointer).l
; End of function Stage_LoadTiles1
; ---------------------------------------------------------------------------
stru_12134:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_LoadTiles1   o
                dc.l tiles_1CE516       ; field_2
                dc.w $8000              ; field_6
                dc.w $FFFF


; Loads stage graphics
Stage22_LoadGraphics:                              ; DATA XREF: ROM:00011E10   o  ; was: sub_1213E
                lea     stru_1214A(pc),a0
                nop
                jmp (Data_ProcessPointer).l
; End of function Stage22_LoadGraphics
; ---------------------------------------------------------------------------
stru_1214A:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage22_LoadGraphics   o
                dc.l tiles_105196       ; field_2
                dc.w $8000              ; field_6
                dc.w $FFFF


; Empty weapon system state handler
Weapon_EmptyState0:                             ; DATA XREF: ROM:00011E12   o  ; was: nullsub_30
                rts
; End of function Weapon_EmptyState0
; Loads stage graphics
Stage24_LoadGraphics:                              ; DATA XREF: ROM:00011E14   o  ; was: sub_12156
                lea     stru_12162(pc),a0
                nop
                jmp (Data_ProcessPointer).l
; End of function Stage24_LoadGraphics
; ---------------------------------------------------------------------------
stru_12162:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage24_LoadGraphics   o
                dc.l tiles_105196       ; field_2
                dc.w $8000              ; field_6
                dc.w $FFFF


; Initializes graphics data structure pointer 1
Data_InitGraphicsStruct1:
                lea     stru_12178(pc),a0  ; was: sub_1216C
                nop
                jmp (Data_ProcessPointer).l
; End of function Data_InitGraphicsStruct1
; ---------------------------------------------------------------------------
stru_12178:     dc.w 7                  ; field_0
                                        ; DATA XREF: Data_InitGraphicsStruct1   o
                dc.l tiles_132E9A       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF


nullsub_33:
                rts
; End of function nullsub_33


; Empty weapon system state handler
Weapon_EmptyState1:                             ; DATA XREF: ROM:00011E16   o  ; was: nullsub_31
                rts
; End of function Weapon_EmptyState1
; Empty weapon system state handler
Weapon_EmptyState2:                             ; DATA XREF: ROM:00011E18   o  ; was: nullsub_32
                rts
; End of function Weapon_EmptyState2
; Initializes graphics data structure pointer 2
Data_InitGraphicsStruct2:
                lea     stru_12194(pc),a0  ; was: sub_12188
                nop
                jmp (Data_ProcessPointer).l
; End of function Data_InitGraphicsStruct2
; ---------------------------------------------------------------------------
stru_12194:     dc.w 7                  ; field_0
                                        ; DATA XREF: Data_InitGraphicsStruct2   o
                dc.l tiles_FEB6E        ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF


; Loads Xi-Tiger boss tile graphics
Stage_LoadXiTigerGraphics:                              ; CODE XREF: Stage_XiTigerHandler+22   p  ; was: sub_1219E
                clr.w   (word_FF807A).w
                jsr     (nullsub_1).l
                bsr.w Sys_ClearRAMBuffer
                clr.w   (word_FFFF3E).w
                move.w  (word_FFA21C).w,d0
                beq.s   loc_121C4
                cmpi.w  #$10,d0
                bpl.s   loc_121C4
                asl.w   #1,d0
                move.w  d0,(word_FFA21E).w
                bra.s   loc_121D0
; ---------------------------------------------------------------------------
loc_121C4:                              ; CODE XREF: Stage_LoadXiTigerGraphics+16   j
                                        ; Stage_LoadXiTigerGraphics+1C   j
                move.w  #2,(word_FFA21C).w
                move.w  #4,(word_FFA21E).w
loc_121D0:                              ; CODE XREF: Stage_LoadXiTigerGraphics+24   j
                bsr.s Stage_LoadXiTigerPalette
                jsr (Gfx_ProcessPaletteSlots).l
                jmp Player_InitializeStats
; End of function Stage_LoadXiTigerGraphics
; Loads Xi-Tiger boss palette
Stage_LoadXiTigerPalette:                              ; CODE XREF: Stage_LoadXiTigerGraphics:loc_121D0   p  ; was: sub_121DE
                move.w  (word_FF814C).w,d0
                movea.w off_121EE(pc,d0.w),a0
                adda.l  #Stage_LoadXiTigerSprites,a0
                jmp     (a0)
; End of function Stage_LoadXiTigerPalette
; ---------------------------------------------------------------------------
off_121EE:      dc.w Stage_LoadXiTigerSprites-Stage_LoadXiTigerSprites
                                        ; DATA XREF: Stage_LoadXiTigerPalette+4   r


; Loads Xi-Tiger sprite data to VRAM
Stage_LoadXiTigerSprites:                              ; DATA XREF: Stage_LoadXiTigerPalette+8   o  ; was: sub_121F0
                                        ; ROM:off_121EE   o
                lea     stru_121FE(pc),a0
                nop
                bsr.w Stage_LoadConfigData
                bra.w   loc_1233A
; End of function Stage_LoadXiTigerSprites
; ---------------------------------------------------------------------------
stru_121FE:     dc.w $76                ; field_0
                                        ; DATA XREF: Stage_LoadXiTigerSprites   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $800               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 0                  ; field_16
                dc.b $F0                ; field_18
                dc.b $A8                ; field_19
                dc.l word_B99A          ; field_1A


; Initializes stage state including RAM clear and player stats
Sys_InitStageState:                              ; CODE XREF: Stage_LoadBackgroundGraphics+32   p  ; was: sub_1221C
                clr.w   (word_FF807A).w
                jsr     (nullsub_1).l
                bsr.w Sys_ClearRAMBuffer
                clr.w   (word_FFFF3E).w
                move.w  (word_FFA21C).w,d0
                beq.s   loc_12242
                cmpi.w  #$10,d0
                bpl.s   loc_12242
                asl.w   #1,d0
                move.w  d0,(word_FFA21E).w
                bra.s   loc_1224E
; ---------------------------------------------------------------------------
loc_12242:                              ; CODE XREF: Sys_InitStageState+16   j
                                        ; Sys_InitStageState+1C   j
                move.w  #2,(word_FFA21C).w
                move.w  #4,(word_FFA21E).w
loc_1224E:                              ; CODE XREF: Sys_InitStageState+24   j
                bsr.s Stage_DispatchInitializer
                jsr (Gfx_ProcessPaletteSlots).l
                jmp Player_InitializeStats
; End of function Sys_InitStageState
; Dispatches to stage-specific initialization routine
Stage_DispatchInitializer:                              ; CODE XREF: Sys_InitStageState:loc_1224E   p  ; was: sub_1225C
                move.w  (word_FFA204).w,d0
                movea.w off_1226C(pc,d0.w),a0
                adda.l  #Sys_ClearRAMBuffer,a0
                jmp     (a0)
; End of function Stage_DispatchInitializer
; ---------------------------------------------------------------------------
off_1226C:      dc.w Stage_InitStage1Data-Sys_ClearRAMBuffer
                                        ; DATA XREF: Stage_DispatchInitializer+4   r
                dc.w Stage_InitStage2Data-Sys_ClearRAMBuffer
                dc.w Stage_LoadStage2ConfigAlt-Sys_ClearRAMBuffer
                dc.w Stage_LoadStage2Config2-Sys_ClearRAMBuffer
                dc.w Stage_LoadStage2Config3-Sys_ClearRAMBuffer
                dc.w Stage_LoadStage2Config4-Sys_ClearRAMBuffer
                dc.w Stage_LoadStage2Config5-Sys_ClearRAMBuffer
                dc.w Stage_InitStage8Data-Sys_ClearRAMBuffer
                dc.w Stage_InitStage8Palettes-Sys_ClearRAMBuffer
                dc.w Stage_InitStage10Data-Sys_ClearRAMBuffer
                dc.w Stage_LoadStage10ConfigAlt-Sys_ClearRAMBuffer
                dc.w Stage_LoadStage11Config-Sys_ClearRAMBuffer
                dc.w Stage_InitCutsceneData-Sys_ClearRAMBuffer
                dc.w Stage_LoadStage13ConfigAlt-Sys_ClearRAMBuffer
                dc.w Stage_LoadStage14Config-Sys_ClearRAMBuffer
                dc.w Stage_InitStage16Data-Sys_ClearRAMBuffer
                dc.w Stage_InitStage17Boss-Sys_ClearRAMBuffer
                dc.w Gfx_Stage18Foreground-Sys_ClearRAMBuffer
                dc.w Stage_LoadStage18ConfigAlt-Sys_ClearRAMBuffer
                dc.w Stage_InitStage25Tilemap-Sys_ClearRAMBuffer
                dc.w Stage_InitStage26Config-Sys_ClearRAMBuffer
                dc.w Stage_InitStage27Config-Sys_ClearRAMBuffer
                dc.w Stage_InitStage28Config-Sys_ClearRAMBuffer
                dc.w Stage_InitStage29Config-Sys_ClearRAMBuffer
                dc.w Stage_InitStage32Config-Sys_ClearRAMBuffer
                dc.w Stage_InitStage33Config-Sys_ClearRAMBuffer


; Clears 4-word RAM buffer used for temporary data storage
Sys_ClearRAMBuffer:                              ; CODE XREF: Stage_LoadXiTigerGraphics+A   p  ; was: sub_122A0
                                        ; Sys_InitStageState+A   p
                                        ; DATA XREF: ...
                movea.w #(byte_FFA258-M68K_RAM),a0
                moveq   #3,d7
loc_122A6:                              ; CODE XREF: Sys_ClearRAMBuffer+8   j
                clr.w   (a0)+
                dbf     d7,loc_122A6
                rts
; End of function Sys_ClearRAMBuffer
; Initializes stage 1 data structure and palette
Stage_InitStage1Data:                              ; DATA XREF: ROM:off_1226C   o  ; was: sub_122AE
                lea     stru_127A8(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage1Data
; Initializes stage 2 data structure and palette
Stage_InitStage2Data:                              ; DATA XREF: ROM:0001226E   o  ; was: sub_122B8
                lea     stru_127C6(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage2Data
; Loads alternate configuration for stage 2
Stage_LoadStage2ConfigAlt:                              ; DATA XREF: ROM:00012270   o  ; was: sub_122C2
                lea     stru_127E4(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_LoadStage2ConfigAlt
; Loads second configuration for stage 2
Stage_LoadStage2Config2:                              ; DATA XREF: ROM:00012272   o  ; was: sub_122CC
                lea     stru_12802(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_LoadStage2Config2
; Loads third configuration for stage 2
Stage_LoadStage2Config3:                              ; DATA XREF: ROM:00012274   o  ; was: sub_122D6
                lea     stru_12820(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_LoadStage2Config3
; Loads fourth configuration for stage 2
Stage_LoadStage2Config4:                              ; DATA XREF: ROM:00012276   o  ; was: sub_122E0
                lea     stru_1283E(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_LoadStage2Config4
; Loads fifth configuration for stage 2
Stage_LoadStage2Config5:                              ; DATA XREF: ROM:00012278   o  ; was: sub_122EA
                lea     stru_1285C(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_LoadStage2Config5
; Initializes stage 8 data with special scroll buffer setup
Stage_InitStage8Data:                              ; DATA XREF: ROM:0001227A   o  ; was: sub_122F4
                lea     stru_1287A(pc),a0
                nop
                bsr.w Stage_LoadConfigData
                move.w  #$81E0,(word_FF5000).l
                lea     (word_FF0480).l,a0
                lea     (word_FF0500).l,a1
                lea     (word_FF0C00).l,a2
                moveq   #$C,d1
                moveq   #$3F,d7 ; '?'
loc_1231C:                              ; CODE XREF: Stage_InitStage8Data+2E   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                dbf     d7,loc_1231C
                move.b  #$82,(byte_FF780C).l
                rts
; End of function Stage_InitStage8Data
; Initializes stage 8 with palette clearing
Stage_InitStage8Palettes:                              ; DATA XREF: ROM:0001227C   o  ; was: sub_12330
                lea     stru_12898(pc),a0
                nop
                bsr.w Stage_LoadConfigData
loc_1233A:                              ; CODE XREF: Stage_LoadXiTigerSprites+A   j
                jsr (Boss_FlyingNeoClearPalettes).l
loc_12340:                              ; CODE XREF: Stage_InitStage9Flies+86   j
                lea     (word_FF0C80).l,a0
                lea     (word_FF0D00).l,a1
                lea     (word_FF0D80).l,a2
                lea     (word_FF0E00).l,a3
                moveq   #$D,d1
                moveq   #$3F,d7 ; '?'
loc_1235C:                              ; CODE XREF: Stage_InitStage8Palettes+34   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                move.w  d1,(a3)+
                dbf     d7,loc_1235C
                move.b  #$82,(byte_FF780D).l
                rts
; End of function Stage_InitStage8Palettes
; Initializes stage 10 data structure and palette
Stage_InitStage10Data:                              ; DATA XREF: ROM:0001227E   o  ; was: sub_12372
                lea     stru_128B6(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage10Data
; Loads alternate configuration for stage 10
Stage_LoadStage10ConfigAlt:                              ; DATA XREF: ROM:00012280   o  ; was: sub_1237C
                lea     stru_128D4(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_LoadStage10ConfigAlt
; Loads configuration data for stage 11
Stage_LoadStage11Config:                              ; DATA XREF: ROM:00012282   o  ; was: sub_12386
                lea     stru_128F2(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_LoadStage11Config
; ===============================================================================
; UNUSED GRAPHICS LOADER: Intro Sprite Loader
; Description: Would have loaded cut intro cutscene sprites
; Target Structure: stru_12910 (line 23283)
; Graphics Source: word_1A3E6 (line 34368)
; Status: Loader exists but never called in final game
; ===============================================================================
; Initializes unused intro cutscene sprite data
Stage_InitCutsceneData:                              ; DATA XREF: ROM:00012284   o  ; was: sub_12390
                lea     stru_12910(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitCutsceneData
; Loads Stage 13 tile graphics
Stage_LoadStage13Graphics:                              ; CODE XREF: Stage_Stage13Init+1A   p  ; was: sub_1239A
                                        ; Stage_InitStage13+1A   p
                lea     (dword_FF7800).l,a0
                moveq   #0,d0
                moveq   #$37,d7 ; '7'
loc_123A4:                              ; CODE XREF: Stage_LoadStage13Graphics+C   j
                move.l  d0,(a0)+
                dbf     d7,loc_123A4
                rts
; End of function Stage_LoadStage13Graphics
; Loads alternate configuration for stage 13
Stage_LoadStage13ConfigAlt:                              ; DATA XREF: ROM:00012286   o  ; was: sub_123AC
                lea     stru_1292E(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_LoadStage13ConfigAlt
; Loads configuration data for stage 14
Stage_LoadStage14Config:                              ; DATA XREF: ROM:00012288   o  ; was: sub_123B6
                lea     stru_1294C(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_LoadStage14Config
; Initializes stage 16 data with camera bounds setup
Stage_InitStage16Data:                              ; DATA XREF: ROM:0001228A   o  ; was: sub_123C0
                lea     stru_1296A(pc),a0
                nop
                bsr.w Stage_LoadConfigData
                move.w  #$620,(word_FFA970).w
                move.w  #$6A0,(word_FFA974).w
                bset    #6,(byte_FF8245).w
                rts
; End of function Stage_InitStage16Data
; Initializes stage 17 boss with sprites
Stage_InitStage17Boss:                              ; DATA XREF: ROM:0001228C   o  ; was: sub_123DE
                move.w  #4,(word_FFA206).w
                lea     stru_12988(pc),a0
                nop
                bsr.w Stage_LoadConfigData
                lea     (word_FF0C00).l,a0
                lea     (word_FF0C80).l,a1
                lea     (word_FF0D00).l,a2
                lea     (word_FF0D80).l,a3
                move.w  #$2FF,d1
                moveq   #$3F,d7 ; '?'
loc_1240C:                              ; CODE XREF: Stage_InitStage17Boss+36   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                move.w  d1,(a3)+
                dbf     d7,loc_1240C
                move.b  #$82,(byte_FF7AFF).l
                move.b  #4,(word_FFF7E6+1).w
                move.b  #3,(byte_FFA95B).w
                clr.w   (word_FFA970).w
                clr.w   (word_FFA974).w
                move.w  #$A,(word_FF8220).w
                move.w  #$50,(word_FF80C2).w ; 'P'
                move.w  #$40,(word_FFF74A).w ; '@'
                clr.w   (word_FFF74E).w
                movea.w #(byte_FFEC12-M68K_RAM),a0
                moveq   #$FFFFFFF0,d0
                moveq   #$B,d7
loc_12452:                              ; CODE XREF: Stage_InitStage17Boss+78   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_12452
                move.w  #$484,(word_FFC620).w
                clr.w   (word_FFC624).w
                lea     word_1249A(pc),a0
                nop
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #$81,d0
                moveq   #3,d7
                jsr (Gfx_SetSpritePattern).l
                lea     stru_12488(pc),a0
                nop
                jmp (Data_ProcessPointer).l
; End of function Stage_InitStage17Boss
; ---------------------------------------------------------------------------
stru_12488:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_InitStage17Boss+9E   o
                dc.l tiles_1233B4       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1A9AD8        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
word_1249A:     dc.w $4E00, $4000, $900, $292A, $2B2C, $2D2E, $2F30, $3132
                                        ; DATA XREF: Stage_InitStage17Boss+86   o


; Foreground graphics setup
Gfx_Stage18Foreground:                              ; DATA XREF: ROM:0001228E   o  ; was: sub_124AA
                lea     stru_129A6(pc),a0
                nop
                bsr.w Stage_LoadConfigData
loc_124B4:                              ; CODE XREF: Stage_LoadStage18ConfigAlt+10   j
                movea.l #$FFFF2000,a0
                move.w  #0,d0
                move.w  #$150,d1
                move.w  #$7F,d7
                jmp Gfx_UpdateTilemapIndices
; End of function Gfx_Stage18Foreground
; Loads alternate configuration for stage 18
Stage_LoadStage18ConfigAlt:                              ; DATA XREF: ROM:00012290   o  ; was: sub_124CC
                lea     stru_129C4(pc),a0
                nop
                bsr.w Stage_LoadConfigData
                jsr     (locret_E4FA).l
                bra.s   loc_124B4
; End of function Stage_LoadStage18ConfigAlt
; Loads first configuration for stage 20
Stage_LoadStage20Config1:
                lea     stru_129E2(pc),a0  ; was: sub_124DE
                nop
                bra.s   loc_124EC
; End of function Stage_LoadStage20Config1
; Loads second configuration for stage 20
Stage_LoadStage20Config2:
                lea     stru_12A00(pc),a0  ; was: sub_124E6
                nop
loc_124EC:                              ; CODE XREF: Stage_LoadStage20Config1+6   j
                                        ; Stage_LoadStage20Config3+6   j ...
                bsr.w Stage_LoadConfigData
                lea     (word_FF0D00).l,a0
                lea     (word_FF0D80).l,a1
                lea     (word_FF0E00).l,a2
                lea     (word_FF0E80).l,a3
                move.w  #$300,d1
                moveq   #$3F,d7 ; '?'
loc_1250E:                              ; CODE XREF: Stage_LoadStage20Config2+30   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                move.w  d1,(a3)+
                dbf     d7,loc_1250E
                move.b  #$82,(byte_FF7B00).l
                rts
; End of function Stage_LoadStage20Config2
; Loads third configuration for stage 20
Stage_LoadStage20Config3:
                lea     stru_12A1E(pc),a0  ; was: sub_12524
                nop
                bra.w   loc_124EC
; End of function Stage_LoadStage20Config3
; Loads fourth configuration for stage 20
Stage_LoadStage20Config4:
                lea     stru_12A3C(pc),a0  ; was: sub_1252E
                nop
                bra.w   loc_124EC
; End of function Stage_LoadStage20Config4
; Initializes stage 25 tilemap and camera
Stage_InitStage25Tilemap:                              ; DATA XREF: ROM:00012292   o  ; was: sub_12538
                lea     (dword_FF4000).l,a0
                move.w  #$8000,d0
                move.w  #$180,d1
                move.w  #$BF,d7
                jsr (Gfx_UpdateTilemapIndices).l
                lea     stru_12A5A(pc),a0
                nop
                bsr.w Stage_LoadConfigData
                move.w  #$180,(dword_FFA410).w
                addi.w  #$20,(dword_FFA900).w ; ' '
                move.w  (dword_FFA900).w,(word_FFA928).w
                rts
; End of function Stage_InitStage25Tilemap
; Initializes stage 26 configuration with flags
Stage_InitStage26Config:                              ; DATA XREF: ROM:00012294   o  ; was: sub_1256E
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                lea     stru_12A78(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage26Config
; Initializes stage 27 configuration with flags
Stage_InitStage27Config:                              ; DATA XREF: ROM:00012296   o  ; was: sub_12584
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                lea     stru_12A96(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage27Config
; Initializes stage 28 configuration with flags
Stage_InitStage28Config:                              ; DATA XREF: ROM:00012298   o  ; was: sub_1259A
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                lea     stru_12AB4(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage28Config
; Initializes stage 29 configuration
Stage_InitStage29Config:                              ; DATA XREF: ROM:0001229A   o  ; was: sub_125B0
                lea     stru_12AD2(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage29Config
; Sets system flag and initializes stage 30
Stage_InitStage30Config:
                bset    #1,(byte_FF8144).w  ; was: sub_125BA
                lea     stru_12AF0(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage30Config
; Sets system flag and initializes stage 31
Stage_InitStage31Config:
                bset    #1,(byte_FF8144).w  ; was: sub_125CA
                lea     stru_12B0E(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage31Config
; Initializes stage 32 configuration
Stage_InitStage32Config:                              ; DATA XREF: ROM:0001229C   o  ; was: sub_125DA
                lea     stru_12B2C(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage32Config
; Initializes stage 33 configuration
Stage_InitStage33Config:                              ; DATA XREF: ROM:0001229E   o  ; was: sub_125E4
                lea     stru_12B4A(pc),a0
                nop
                bra.w Stage_LoadConfigData
; End of function Stage_InitStage33Config
; Loads stage tiles 2
Stage_LoadTiles2:                              ; CODE XREF: Stage_LoadStage3Phase2+12   p  ; was: sub_125EE
                movea.w #(word_FF9800-M68K_RAM),a0
                move.l  #$600000,d0
                move.w  #$2000,d1
                move.w  #$1A0,d3
                moveq   #$5F,d7 ; '_'
loc_12602:                              ; CODE XREF: Stage_LoadTiles2+20   j
                move.l  d0,d2
                divu.w  d1,d2
                ext.l   d2
                asl.l   #8,d2
                move.l  d2,(a0)+
                add.w   d3,d1
                dbf     d7,loc_12602
                move.l  #byte_1C09B2,(dword_FF8040).w
                move.l  #$FFFF9800,(dword_FF8058).w
                move.w  #$5F,(word_FF8048).w ; '_'
                move.w  #3,(word_FF804A).w
                bsr.w Stage_LoadPalette
                movea.l #$FFFF0000,a0
                move.w  #$3C00,d5
                move.l  #$93009412,d4
                jmp Stage22_GraphicsUpdate2
; End of function Stage_LoadTiles2
; Loads stage palette
Stage_LoadPalette:                              ; CODE XREF: Stage_LoadTiles2+40   p  ; was: sub_12648
                movea.l (dword_FF8058).w,a4
                movea.l (dword_FF8040).w,a0
                movea.l #$FFFF6000,a2
                moveq   #0,d6
                move.w  (word_FF8048).w,d7
loc_1265C:                              ; CODE XREF: Stage_LoadPalette+5E   j
                move.w  (word_FF804A).w,d5
                move.w  d5,d4
                addq.w  #1,d4
                asl.w   #5,d4
loc_12666:                              ; CODE XREF: Stage_LoadPalette+26   j
                move.l  (a0,d6.w),(a2)+
                addi.w  #$20,d6 ; ' '
                dbf     d5,loc_12666
                movea.l a2,a3
                move.w  (word_FF804A).w,d5
                addq.w  #1,d5
                asl.w   #2,d5
                subq.w  #1,d5
loc_1267E:                              ; CODE XREF: Stage_LoadPalette+44   j
                moveq   #0,d0
                move.b  -(a3),d0
                move.b  d0,d1
                asr.w   #4,d0
                asl.w   #4,d1
                add.b   d1,d0
                move.b  d0,(a2)+
                dbf     d5,loc_1267E
                sub.w   d4,d6
                addq.w  #4,d6
                move.w  d6,d0
                andi.w  #$1C,d0
                bne.s   loc_126A2
                add.w   d4,d6
                subi.w  #$20,d6 ; ' '
loc_126A2:                              ; CODE XREF: Stage_LoadPalette+52   j
                move.w  (word_FF804A).w,d5
                dbf     d7,loc_1265C
                movea.l #$FFFF6000,a2
                movea.l #$FFFF0000,a0
                move.w  (word_FF8048).w,d7
                asr.w   #3,d7
                moveq   #0,d5
                move.w  (word_FF804A).w,d5
                addq.w  #1,d5
                asl.w   #3,d5
                swap    d5
loc_126C8:                              ; CODE XREF: Stage_LoadPalette+E6   j
                moveq   #7,d1
loc_126CA:                              ; CODE XREF: Stage_LoadPalette+DE   j
                move.l  (a4)+,d3
                move.w  #$17,d2
                moveq   #0,d4
loc_126D2:                              ; CODE XREF: Stage_LoadPalette+D0   j
                moveq   #3,d6
loc_126D4:                              ; CODE XREF: Stage_LoadPalette+C8   j
                move.b  (a2,d4.w),d0
                btst    #$1F,d4
                beq.s   loc_126E0
                asl.b   #4,d0
loc_126E0:                              ; CODE XREF: Stage_LoadPalette+94   j
                andi.b  #$F0,d0
                swap    d4
                add.l   d3,d4
                cmp.l   d5,d4
                bmi.s   loc_126EE
                sub.l   d5,d4
loc_126EE:                              ; CODE XREF: Stage_LoadPalette+A2   j
                move.b  d0,(a0)
                swap    d4
                move.b  (a2,d4.w),d0
                btst    #$1F,d4
                bne.s   loc_126FE
                asr.b   #4,d0
loc_126FE:                              ; CODE XREF: Stage_LoadPalette+B2   j
                andi.b  #$F,d0
                swap    d4
                add.l   d3,d4
                cmp.l   d5,d4
                bmi.s   loc_1270C
                sub.l   d5,d4
loc_1270C:                              ; CODE XREF: Stage_LoadPalette+C0   j
                or.b    d0,(a0)+
                swap    d4
                dbf     d6,loc_126D4
                adda.w  #$1C,a0
                dbf     d2,loc_126D2
                adda.w  #$FD04,a0
                swap    d5
                adda.w  d5,a2
                swap    d5
                dbf     d1,loc_126CA
                adda.w  #$2E0,a0
                dbf     d7,loc_126C8
                rts
; End of function Stage_LoadPalette
CheckFlagsLoadObjData:                  ; CODE XREF: Stage_LoadStage1Objects+A   j
                                        ; Stage_LoadStage1Phase1+E   j ...
                cmpi.w  #$3C,(word_FFA284).w ; '<'
                beq.s   loc_12752
                cmpi.w  #$C,(word_FFA284).w
                beq.s   loc_12752
                cmpi.w  #$10,(word_FFA284).w
                beq.s   loc_12752
                jmp (Data_ProcessPointer).l
; ---------------------------------------------------------------------------
loc_12752:                              ; CODE XREF: CheckFlagsLoadObjData+6   j
                                        ; CheckFlagsLoadObjData+E   j ...
                jmp     (LoadObjData).l
; End of function CheckFlagsLoadObjData


; Loads stage configuration data including positions and palettes
Stage_LoadConfigData:                              ; CODE XREF: Stage_LoadXiTigerSprites+6   p  ; was: sub_12758
                                        ; Stage_InitStage1Data+6   j ...
                move.w  (a0)+,(word_FFA950).w
                move.l  (a0)+,(dword_FFA20E).w
                move.w  (a0)+,(word_FF8114).w
                move.b  (a0)+,(word_FF8220+1).w
                move.b  (a0)+,(word_FF8222+1).w
                move.w  (a0)+,(word_FF808A).w
                move.w  (a0)+,(dword_FFA900).w
                move.w  (a0)+,(dword_FFA904).w
                move.w  (a0)+,(dword_FFA908).w
                move.w  (a0)+,(dword_FFA90C).w
                move.w  (a0)+,(word_FF80AA).w
                move.w  (a0)+,(word_FF80AC).w
                moveq   #0,d0
                move.b  (a0)+,d0
                addi.w  #$80,d0
                move.w  d0,(dword_FFA410).w
                moveq   #0,d0
                move.b  (a0)+,d0
                addi.w  #$80,d0
                move.w  d0,(dword_FFA414).w
                movea.l (a0)+,a4
                jmp Gfx_LoadMultiplePalettes
; End of function Stage_LoadConfigData
; ---------------------------------------------------------------------------
stru_127A8:     dc.w 0                  ; field_0
                                        ; DATA XREF: Stage_InitStage1Data   o
                dc.l word_1A3E8         ; field_2
                dc.w 2                  ; field_6
                dc.b 2                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B988          ; field_1A
stru_127C6:     dc.w $A                 ; field_0
                                        ; DATA XREF: Stage_InitStage2Data   o
                dc.l word_1A4D8         ; field_2
                dc.w 0                  ; field_6
                dc.b 2                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $700               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B988          ; field_1A
stru_127E4:     dc.w $12                ; field_0
                                        ; DATA XREF: Stage_LoadStage2ConfigAlt   o
                dc.l word_1A6B8         ; field_2
                dc.w 0                  ; field_6
                dc.b 2                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $BC0               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B988          ; field_1A
stru_12802:     dc.w $22                ; field_0
                                        ; DATA XREF: Stage_LoadStage2Config2   o
                dc.l word_1A754         ; field_2
                dc.w 0                  ; field_6
                dc.b 4                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $1200              ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B98C          ; field_1A
stru_12820:     dc.w $2E                ; field_0
                                        ; DATA XREF: Stage_LoadStage2Config3   o
                dc.l word_1A882         ; field_2
                dc.w 0                  ; field_6
                dc.b 6                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B992          ; field_1A
stru_1283E:     dc.w $38                ; field_0
                                        ; DATA XREF: Stage_LoadStage2Config4   o
                dc.l word_1A9B0         ; field_2
                dc.w 0                  ; field_6
                dc.b 6                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $480               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B992          ; field_1A
stru_1285C:     dc.w $40                ; field_0
                                        ; DATA XREF: Stage_LoadStage2Config5   o
                dc.l word_1AB24         ; field_2
                dc.w 0                  ; field_6
                dc.b 6                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $AA0               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $B0                ; field_19
                dc.l word_B992          ; field_1A
stru_1287A:     dc.w $50                ; field_0
                                        ; DATA XREF: Stage_InitStage8Data   o
                dc.l word_1ABC2         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $C00               ; field_C
                dc.w 0                  ; field_E
                dc.w $730               ; field_10
                dc.w $F700              ; field_12
                dc.w 8                  ; field_14
                dc.w 8                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B996          ; field_1A
stru_12898:     dc.w $62                ; field_0
                                        ; DATA XREF: Stage_InitStage8Palettes   o
                dc.l word_1AC60         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $800               ; field_C
                dc.w 0                  ; field_E
                dc.w $C00               ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 8                  ; field_16
                dc.b $60                ; field_18
                dc.b $A8                ; field_19
                dc.l word_B99A          ; field_1A
stru_128B6:     dc.w 0                  ; field_0
                                        ; DATA XREF: Stage_InitStage10Data   o
                dc.l word_1AC62         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w $FC00              ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $78                ; field_19
                dc.l word_B9A4          ; field_1A
stru_128D4:     dc.w $A                 ; field_0
                                        ; DATA XREF: Stage_LoadStage10ConfigAlt   o
                dc.l word_1AD8E         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $7B0               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w $FC00              ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $A0                ; field_18
                dc.b $78                ; field_19
                dc.l word_B9A4          ; field_1A
; ===============================================================================
; UNUSED GRAPHICS: Unknown Purpose
; Source: TCRF research (ROM offset 0x1291DE)
; Description: 314 bytes of unknown graphics data
; Binary File: word_1AE96.bin
; Referenced by: stru_128F2
; Loader Function: sub_12386
; Status: Purpose unknown, possibly test graphics or scrapped UI element
; ===============================================================================
stru_128F2:     dc.w $14                ; Structure size/ID
                                        ; DATA XREF: Stage_LoadStage11Config   o
                dc.l word_1AE96         ; Unknown graphics data pointer (line 34452)
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $10C0              ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w $FC00              ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $5C                ; field_18
                dc.b $70                ; field_19
                dc.l word_B9A4          ; field_1A
; ===============================================================================
; UNUSED INTRO SPRITES: Kaede and Unknown Man
; Source: TCRF https://tcrf.net/Alien_Soldier (ROM offset 0x188A16)
; Description: Cut intro cutscene featuring Kaede and unidentified character
; Graphics Data: word_1A3E6 (line 34368)
; Loader Function: sub_12390 (line 22614)
; Sprite Size: 4x4 tiles (32x32 pixels)
; Palette: Bank $40, Index $80
; Status: Complete sprite structure, never displayed in final game
; ===============================================================================
stru_12910:     dc.w $34                ; Structure size/ID
                                        ; DATA XREF: Stage_InitCutsceneData   o
                dc.l word_1A3E6         ; Sprite graphics data pointer
                dc.w 0                  ; X position
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; Flags
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w $FC00              ; field_12
                dc.w 4                  ; Sprite width (tiles)
                dc.w 4                  ; Sprite height (tiles)
                dc.b $40                ; Palette bank
                dc.b $80                ; Palette index
                dc.l word_B9A4          ; Animation/mapping data
stru_1292E:     dc.w $40                ; field_0
                                        ; DATA XREF: Stage_LoadStage13ConfigAlt   o
                dc.l word_1AFD0         ; field_2
                dc.w 0                  ; field_6
                dc.b $C                 ; field_8
                dc.b 4                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w $E100              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $58                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9A8          ; field_1A
stru_1294C:     dc.w $4A                ; field_0
                                        ; DATA XREF: Stage_LoadStage14Config   o
                dc.l word_1B00C         ; field_2
                dc.w 0                  ; field_6
                dc.b $C                 ; field_8
                dc.b 4                  ; field_9
                dc.w $8000              ; field_A
                dc.w $480               ; field_C
                dc.w $E100              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9A8          ; field_1A
stru_1296A:     dc.w $56                ; field_0
                                        ; DATA XREF: Stage_InitStage16Data   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b $C                 ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $620               ; field_C
                dc.w $E440              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $A0                ; field_18
                dc.b $C0                ; field_19
                dc.l word_B9A8          ; field_1A
stru_12988:     dc.w $6C                ; field_0
                                        ; DATA XREF: Stage_InitStage17Boss+6   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 0                  ; field_14
                dc.w 8                  ; field_16
                dc.b $40                ; field_18
                dc.b $80                ; field_19
                dc.l word_B9AC          ; field_1A
stru_129A6:     dc.w 0                  ; field_0
                                        ; DATA XREF: Gfx_Stage18Foreground   o
                dc.l word_1B03E         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w $8008              ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B0          ; field_1A
stru_129C4:     dc.w $A                 ; field_0
                                        ; DATA XREF: Stage_LoadStage18ConfigAlt   o
                dc.l word_1B2BA         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w $D50               ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w $8008              ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B0          ; field_1A
stru_129E2:     dc.w $28                ; field_0
                                        ; DATA XREF: Stage_LoadStage20Config1   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b $10                ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B4          ; field_1A
stru_12A00:     dc.w $30                ; field_0
                                        ; DATA XREF: Stage_LoadStage20Config2   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b $10                ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B4          ; field_1A
stru_12A1E:     dc.w $38                ; field_0
                                        ; DATA XREF: Stage_LoadStage20Config3   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b $10                ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B4          ; field_1A
stru_12A3C:     dc.w $40                ; field_0
                                        ; DATA XREF: Stage_LoadStage20Config4   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b $10                ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $90                ; field_19
                dc.l word_B9B4          ; field_1A
stru_12A5A:     dc.w $70                ; field_0
                                        ; DATA XREF: Stage_InitStage25Tilemap+18   o
                dc.l $80000000          ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w $600               ; field_C
                dc.w $F800              ; field_E
                dc.w 0                  ; field_10
                dc.w $F500              ; field_12
                dc.w 8                  ; field_14
                dc.w 4                  ; field_16
                dc.b $80                ; field_18
                dc.b 0                  ; field_19
                dc.l word_B9B8          ; field_1A
stru_12A78:     dc.w 0                  ; field_0
                                        ; DATA XREF: Stage_InitStage26Config+C   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b $E                 ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w $F800              ; field_E
                dc.w 0                  ; field_10
                dc.w $F100              ; field_12
                dc.w 8                  ; field_14
                dc.w 8                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9C6          ; field_1A
stru_12A96:     dc.w $2C                ; field_0
                                        ; DATA XREF: Stage_InitStage27Config+C   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b $E                 ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w $F600              ; field_E
                dc.w 0                  ; field_10
                dc.w $F100              ; field_12
                dc.w 8                  ; field_14
                dc.w 8                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9CC          ; field_1A
stru_12AB4:     dc.w $2E                ; field_0
                                        ; DATA XREF: Stage_InitStage28Config+C   o
                dc.l word_1B3F4         ; field_2
                dc.w 0                  ; field_6
                dc.b $12                ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w $F3E0              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 8                  ; field_14
                dc.w 0                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9C6          ; field_1A
stru_12AD2:     dc.w $40                ; field_0
                                        ; DATA XREF: Stage_InitStage29Config   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9D2          ; field_1A
stru_12AF0:     dc.w $4E                ; field_0
                                        ; DATA XREF: Stage_InitStage30Config+6   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9D8          ; field_1A
stru_12B0E:     dc.w $62                ; field_0
                                        ; DATA XREF: Stage_InitStage31Config+6   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w 0                  ; field_A
                dc.w 0                  ; field_C
                dc.w $FF00              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9DE          ; field_1A
stru_12B2C:     dc.w $76                ; field_0
                                        ; DATA XREF: Stage_InitStage32Config   o
                dc.l word_1B3F6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w $FE00              ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $60                ; field_19
                dc.l word_B9E2          ; field_1A
stru_12B4A:     dc.w $8A                ; field_0
                                        ; DATA XREF: Stage_InitStage33Config   o
                dc.l word_1A3E6         ; field_2
                dc.w 0                  ; field_6
                dc.b 0                  ; field_8
                dc.b 0                  ; field_9
                dc.w $8000              ; field_A
                dc.w 0                  ; field_C
                dc.w 0                  ; field_E
                dc.w 0                  ; field_10
                dc.w 0                  ; field_12
                dc.w 4                  ; field_14
                dc.w 4                  ; field_16
                dc.b $40                ; field_18
                dc.b $A0                ; field_19
                dc.l word_B9E6          ; field_1A


nullsub_1:                              ; CODE XREF: Stage_LoadXiTigerGraphics+4   p
                                        ; Sys_InitStageState+4   p ...
                rts
; End of function nullsub_1


; Renders HUD element health or ammo
UI_RenderHUDElement1:                              ; CODE XREF: Sys_GameplayMainLoop+164   p  ; was: sub_12B6A
                                        ; Cutscene_UpdatePhysicsAndHUD+6   p ...
                clr.l   (dword_FF84A0).w
                clr.l   (dword_FF8500).w
                clr.l   (dword_FF8560).w
                bra.s   loc_12BDA
; ===============================================================================
; DEAD CODE: Unused Debug Input Handler (UNREFERENCED)
; ===============================================================================
; Status: This code is completely unreachable due to unconditional branch at
;         line 23695 (bra.s loc_12BDA) which skips this entire block.
;
; Description: Debug input handling routine that was disabled during development.
;              Tests word_FF8228 flag and processes controller button inputs
;              by checking specific bits in word_FFF708 (controller state):
;                - Bit 6: Calls Input_ProcessButtons with value from word_FF8228
;                - Bit 4: Calls Input_ProcessButtons with parameter 1
;                - Bit 5: Calls Input_ProcessButtons with parameter 4
;
; Purpose: Likely a developer testing/debug feature that allowed manual control
;          or parameter manipulation during UI/HUD rendering. The code was
;          disabled but not removed, suggesting it might have been kept for
;          potential future use or debugging.
;
; Controller Input Tested:
;   word_FFF708 bit 6 - Unknown button (uses word_FF8228 value)
;   word_FFF708 bit 4 - Button maps to parameter 1
;   word_FFF708 bit 5 - Button maps to parameter 4
;
; Reason for Removal: Unknown - possibly:
;   - Debug feature not needed in release build
;   - Alternative input handling implemented
;   - Functionality moved to different system
;
; Research Note: Found via unreferenced labels analysis (scripts/find_unreferenced_labels.py)
;                This is the ONLY truly unreferenced function in the entire disassembly
;                (out of 136 initially flagged labels, 135 were false positives)
; ===============================================================================
; Debug menu for testing input buttons
Debug_InputTestMenu:                              ; UNREFERENCED DEBUG CODE (DEAD)  ; was: sub_12B78
                tst.w   (word_FF8228).w
                beq.s   loc_12BB8
                btst    #6,(word_FFF708+1).w
                beq.s   loc_12B92
                move.b  (word_FF8228).w,d0
                jsr (Input_ProcessButtons).l
                bra.s   loc_12BB8
; ---------------------------------------------------------------------------
loc_12B92:                              ; CODE XREF: UI_RenderHUDElement1+1A   j
                btst    #4,(word_FFF708+1).w
                beq.s   loc_12BA6
                move.b  #1,d0
                jsr (Input_ProcessButtons).l
                bra.s   loc_12BB8
; ---------------------------------------------------------------------------
loc_12BA6:                              ; CODE XREF: UI_RenderHUDElement1+2E   j
                btst    #5,(word_FFF708+1).w
                beq.s   loc_12BB8
                move.b  #4,d0
                jsr (Input_ProcessButtons).l
loc_12BB8:                              ; CODE XREF: UI_RenderHUDElement1+12   j
                                        ; UI_RenderHUDElement1+26   j ...
                tst.w   (word_FF8226).w
                bne.w UI_RenderDebugMenu
                tst.b   (byte_FFF705).w
                bpl.s   loc_12BDA
                btst    #0,(byte_FFF705).w
                beq.s   loc_12BDA
                btst    #6,(word_FFF708).w
                beq.s   loc_12BDA
                addq.w  #2,(word_FF8226).w
loc_12BDA:                              ; CODE XREF: UI_RenderHUDElement1+C   j
                                        ; UI_RenderHUDElement1+5A   j ...
                tst.b   (byte_FFF705).w
                bmi.s   loc_12C30
                btst    #0,(byte_FFA272).w
                bne.s   loc_12C30
                tst.w   (word_FFA270).w
                beq.s   loc_12C30
                tst.w   (word_FF813C).w
                bpl.s   loc_12C30
                subq.b  #1,(byte_FF8204).w
                bpl.s   loc_12C30
                move.b  #$3B,(byte_FF8204).w ; ';'
                moveq   #1,d0
                move.b  (word_FFA270+1).w,d2
                sub.w   d4,d4
                sbcd    d0,d2
                cmpi.b  #$99,d2
                bne.s   loc_12C2C
                move.b  (word_FFA270).w,d2
                sub.w   d4,d4
                sbcd    d0,d2
                cmpi.b  #$99,d2
                bne.s   loc_12C24
                clr.w   (word_FFA270).w
                bra.s   loc_12C30
; ---------------------------------------------------------------------------
loc_12C24:                              ; CODE XREF: UI_RenderHUDElement1+B2   j
                move.b  d2,(word_FFA270).w
                move.b  #$59,d2 ; 'Y'
loc_12C2C:                              ; CODE XREF: UI_RenderHUDElement1+A4   j
                move.b  d2,(word_FFA270+1).w
loc_12C30:                              ; CODE XREF: UI_RenderHUDElement1+74   j
                                        ; UI_RenderHUDElement1+7C   j ...
                bclr    #0,(byte_FF8260).w
                move.w  (word_FF8234).w,d0
                beq.s   loc_12C56
                bpl.s   loc_12C44
                clr.w   (word_FF8234).w
                bra.s   loc_12C56
; ---------------------------------------------------------------------------
loc_12C44:                              ; CODE XREF: UI_RenderHUDElement1+D2   j
                cmp.w   (word_FF8236).w,d0
                bmi.s   loc_12C56
                move.w  (word_FF8236).w,(word_FF8234).w
                bset    #0,(byte_FF8260).w
loc_12C56:                              ; CODE XREF: UI_RenderHUDElement1+D0   j
                                        ; UI_RenderHUDElement1+D8   j ...
                bsr.w UI_SetupScoreDMA
                tst.b   (byte_FFFF31).w
                bpl.s   loc_12C62
                rts
; ---------------------------------------------------------------------------
loc_12C62:                              ; CODE XREF: UI_RenderHUDElement1+F4   j
                lea     (word_5A43E).l,a4
                btst    #0,(word_FFA280+1).w
                bne.w UI_RenderHUDElement3
                bsr.w UI_RenderHUDElement2
                tst.b   (byte_FFF705).w
                bpl.s   loc_12C90
                btst    #0,(byte_FFF705).w
                beq.s   loc_12C90
                btst    #4,(word_FFF706).w
                bne.s   loc_12C90
                bra.w UI_RenderShipHealthDisplay
; ---------------------------------------------------------------------------
loc_12C90:                              ; CODE XREF: UI_RenderHUDElement1+110   j
                                        ; UI_RenderHUDElement1+118   j ...
                movea.w #(byte_FF84B0-M68K_RAM),a0
                btst    #4,(byte_FFFF30).w
                beq.s   loc_12CAE
                move.w  #$C7E2,d0
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                bra.w   loc_12E16
; ---------------------------------------------------------------------------
loc_12CAE:                              ; CODE XREF: UI_RenderHUDElement1+130   j
                subq.w  #1,(word_FF8268).w
                bpl.s   loc_12CBA
                move.w  #$FFFF,(word_FF8268).w
loc_12CBA:                              ; CODE XREF: UI_RenderHUDElement1+148   j
                move.w  (word_FF820A).w,d0
                move.w  d0,d1
                sub.w   (word_FFA216).w,d0
                bpl.s   loc_12CD4
                cmpi.w  #$FFF0,d0
                bpl.s   loc_12CDA
                addi.w  #$10,(word_FF820A).w
                bra.s   loc_12CE8
; ---------------------------------------------------------------------------
loc_12CD4:                              ; CODE XREF: UI_RenderHUDElement1+15A   j
                cmpi.w  #8,d0
                bpl.s   loc_12CE2
loc_12CDA:                              ; CODE XREF: UI_RenderHUDElement1+160   j
                move.w  (word_FFA216).w,(word_FF820A).w
                bra.s   loc_12CE8
; ---------------------------------------------------------------------------
loc_12CE2:                              ; CODE XREF: UI_RenderHUDElement1+16E   j
                subi.w  #8,(word_FF820A).w
loc_12CE8:                              ; CODE XREF: UI_RenderHUDElement1+168   j
                                        ; UI_RenderHUDElement1+176   j
                moveq   #$13,d7
                cmpi.w  #2,(word_FFA216).w
                bpl.s   loc_12D10
                move.w  (word_FFA280).w,d1
                btst    #4,d1
                bne.s   loc_12D10
                andi.w  #3,d1
                bne.s   loc_12D10
                move.w  #$C7D1,d0
loc_12D06:                              ; CODE XREF: UI_RenderHUDElement1+19E   j
                move.w  d0,(a0)+
                dbf     d7,loc_12D06
                bra.w   loc_12E2C
; ---------------------------------------------------------------------------
loc_12D10:                              ; CODE XREF: UI_RenderHUDElement1+186   j
                                        ; UI_RenderHUDElement1+190   j ...
                tst.w   (word_FF8304).w
                bne.s   loc_12D2C
                btst    #1,(word_FFA280+1).w
                bne.s   loc_12D2C
                move.w  #$C551,d0
loc_12D22:                              ; CODE XREF: UI_RenderHUDElement1+1BA   j
                move.w  d0,(a0)+
                dbf     d7,loc_12D22
                bra.w   loc_12E2C
; ---------------------------------------------------------------------------
loc_12D2C:                              ; CODE XREF: UI_RenderHUDElement1+1AA   j
                                        ; UI_RenderHUDElement1+1B2   j
                btst    #0,(byte_FFFF30).w
                beq.s   loc_12D76
                move.w  #$C7B4,d5
                move.w  (word_FF820A).w,d0
                asl.w   #1,d0
                andi.w  #$FFFE,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w Scroll_ShipScrollPattern
                move.w  #$C7E0,(a0)+
                move.w  (word_FFA218).w,d0
                asl.w   #1,d0
                andi.w  #$FFFE,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w Scroll_ShipScrollPattern
                move.w  #$C7F8,(a0)+
                bra.s   loc_12DB4
; ---------------------------------------------------------------------------
loc_12D76:                              ; CODE XREF: UI_RenderHUDElement1+1C8   j
                move.w  (word_FFA218).w,d7
                asr.w   #6,d7
                move.w  (word_FF820A).w,d0
                subq.w  #1,d0
                bmi.s   loc_12DA6
                move.w  d0,d1
                asr.w   #6,d0
                sub.w   d0,d7
                asr.w   #3,d1
                andi.w  #7,d1
                addi.w  #-$383C,d1
                subq.w  #1,d0
                bmi.s   loc_12DA2
                move.w  #$C7CB,d2
loc_12D9C:                              ; CODE XREF: UI_RenderHUDElement1+234   j
                move.w  d2,(a0)+
                dbf     d0,loc_12D9C
loc_12DA2:                              ; CODE XREF: UI_RenderHUDElement1+22C   j
                move.w  d1,(a0)+
                subq.w  #1,d7
loc_12DA6:                              ; CODE XREF: UI_RenderHUDElement1+218   j
                subq.w  #1,d7
                bmi.s   loc_12DB4
                move.w  #$C7C3,d0
loc_12DAE:                              ; CODE XREF: UI_RenderHUDElement1+246   j
                move.w  d0,(a0)+
                dbf     d7,loc_12DAE
loc_12DB4:                              ; CODE XREF: UI_RenderHUDElement1+20A   j
                                        ; UI_RenderHUDElement1+23E   j
                tst.w   (word_FF8268).w
                bmi.s   loc_12E16
                move.w  (word_FF8268).w,d0
                cmpi.w  #$12,d0
                bmi.s   loc_12DCC
                btst    #2,(word_FFA280+1).w
                bne.s   loc_12E16
loc_12DCC:                              ; CODE XREF: UI_RenderHUDElement1+258   j
                move.w  #$C7BF,d2
                move.w  (word_FF8262).w,d0
                bclr    #$F,d0
                bne.s   loc_12DDE
                move.w  #$C7E1,d2
loc_12DDE:                              ; CODE XREF: UI_RenderHUDElement1+26E   j
                move.w  d2,(a0)+
                move.w  #$C7B4,d2
                asl.w   #1,d0
                move.b  (a4,d0.w),d1
                andi.w  #$F,d1
                beq.s   loc_12DF4
                add.w   d2,d1
                move.w  d1,(a0)+
loc_12DF4:                              ; CODE XREF: UI_RenderHUDElement1+284   j
                move.w  (a4,d0.w),d3
                lsr.w   #4,d3
                andi.w  #$F,d3
                tst.w   d1
                bne.s   loc_12E06
                tst.w   d3
                beq.s   loc_12E0A
loc_12E06:                              ; CODE XREF: UI_RenderHUDElement1+296   j
                add.w   d2,d3
                move.w  d3,(a0)+
loc_12E0A:                              ; CODE XREF: UI_RenderHUDElement1+29A   j
                move.w  (a4,d0.w),d1
                andi.w  #$F,d1
                add.w   d2,d1
                move.w  d1,(a0)+
loc_12E16:                              ; CODE XREF: UI_RenderHUDElement1+140   j
                                        ; UI_RenderHUDElement1+24E   j ...
                move.w  #$84D8,d7
                sub.w   a0,d7
                lsr.w   #1,d7
                subq.w  #1,d7
                bmi.s   loc_12E2C
                move.w  #$C7F8,d0
loc_12E26:                              ; CODE XREF: UI_RenderHUDElement1+2BE   j
                move.w  d0,(a0)+
                dbf     d7,loc_12E26
loc_12E2C:                              ; CODE XREF: UI_RenderHUDElement1+1A2   j
                                        ; UI_RenderHUDElement1+1BE   j ...
                movea.w #(byte_FF84B0-M68K_RAM),a5
                move.w  #$83,-(a5)
                move.w  #$508C,-(a5)
                move.w  #$9558,-(a5)
                move.w  #$96C2,-(a5)
                move.w  #$977F,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94009314,-(a5)
                rts
; End of function UI_RenderHUDElement1
; Renders HUD element variant 2
UI_RenderHUDElement2:                              ; CODE XREF: UI_RenderHUDElement1+108   p  ; was: sub_12E50
                movea.w #(byte_FF8510-M68K_RAM),a0
                movea.w a0,a3
                move.w  (word_FFA24E).w,d0
                addi.w  #-$5DA0,d0
                movea.w d0,a2
                btst    #5,(byte_FFFF30).w
                beq.s   loc_12E7A
                move.w  #$C7E2,d0
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                bra.w   loc_12F2C
; ---------------------------------------------------------------------------
loc_12E7A:                              ; CODE XREF: UI_RenderHUDElement2+16   j
                btst    #1,(byte_FFFF30).w
                beq.s   loc_12EB6
                move.w  #$C7B4,d5
                move.w  (a2),d0
                asl.w   #1,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w Scroll_ShipScrollPattern
                move.w  #$C7E0,(a0)+
                move.w  8(a2),d0
                asl.w   #1,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w Scroll_ShipScrollPattern
                bra.s   loc_12EEE
; ---------------------------------------------------------------------------
loc_12EB6:                              ; CODE XREF: UI_RenderHUDElement2+30   j
                move.w  #$FA,d1
                move.w  8(a2),d0
                lea     word_12F86(pc),a1
                nop
loc_12EC4:                              ; CODE XREF: UI_RenderHUDElement2+7A   j
                sub.w   d1,d0
                bmi.s   loc_12ECC
                move.w  (a1)+,(a0)+
                bra.s   loc_12EC4
; ---------------------------------------------------------------------------
loc_12ECC:                              ; CODE XREF: UI_RenderHUDElement2+76   j
                move.w  (a2),d0
                beq.s   loc_12EEE
                addi.w  #$7C,d0 ; '|'
                lea     word_12F66(pc),a1
                nop
loc_12EDA:                              ; CODE XREF: UI_RenderHUDElement2+90   j
                sub.w   d1,d0
                bmi.s   loc_12EE2
                move.w  (a1)+,(a3)+
                bra.s   loc_12EDA
; ---------------------------------------------------------------------------
loc_12EE2:                              ; CODE XREF: UI_RenderHUDElement2+8C   j
                cmpi.w  #$FF83,d0
                bmi.s   loc_12EEE
                move.w  (a1)+,d1
                addq.w  #1,d1
                move.w  d1,(a3)+
loc_12EEE:                              ; CODE XREF: UI_RenderHUDElement2+64   j
                                        ; UI_RenderHUDElement2+7E   j ...
                subq.w  #1,(word_FF809A).w
                bpl.s   loc_12EFC
                move.w  #$FFFF,(word_FF809A).w
                bra.s   loc_12F2C
; ---------------------------------------------------------------------------
loc_12EFC:                              ; CODE XREF: UI_RenderHUDElement2+A2   j
                move.w  (word_FF8210).w,d0
                move.w  #$C7BF,(a0)+
                asr.w   #1,d0
                lea     word_12FA6(pc),a3
                nop
                move.b  (a3,d0.w),d0
                move.w  d0,d2
                lsr.w   #4,d0
                andi.w  #$F,d0
                addi.w  #-$384C,d0
                move.w  d0,(a0)+
                andi.w  #$F,d2
                addi.w  #-$384C,d2
                move.w  d2,(a0)+
                move.w  #$C7C0,(a0)+
loc_12F2C:                              ; CODE XREF: UI_RenderHUDElement2+26   j
                                        ; UI_RenderHUDElement2+AA   j
                move.w  #$8538,d7
                sub.w   a0,d7
                lsr.w   #1,d7
                subq.w  #1,d7
                bmi.s UI_QueueHUDVRAMCommand
                move.w  #$C7F8,d0
loc_12F3C:                              ; CODE XREF: UI_RenderHUDElement2+EE   j
                move.w  d0,(a0)+
                dbf     d7,loc_12F3C
; Queues VRAM command for HUD element rendering
UI_QueueHUDVRAMCommand:                              ; CODE XREF: UI_RenderHUDElement2+E6   j  ; was: loc_12F42
                movea.w #(byte_FF8510-M68K_RAM),a5
                move.w  #$83,-(a5)
                move.w  #$510C,-(a5)
                move.w  #$9588,-(a5)
                move.w  #$96C2,-(a5)
                move.w  #$977F,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94009314,-(a5)
                rts
; End of function UI_RenderHUDElement2
; ---------------------------------------------------------------------------
word_12F66:     dc.w $C7D4, $C7D4, $C7D4, $C7D4, $C7D6, $C7D6, $C7D6, $C7D6
                                        ; DATA XREF: UI_RenderHUDElement2+84   o
                dc.w $C7D6, $C7D6, $C7D6, $C7D6, $C7D6, $C7D6, $C7D6, $C7D6
word_12F86:     dc.w $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2
                                        ; DATA XREF: UI_RenderHUDElement2+6E   o
                dc.w $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2
word_12FA6:     dc.w 5, $1015, $2025, $3035, $4045, $5055, $6065, $7075, $8085, $9095, $9900
                                        ; DATA XREF: UI_RenderHUDElement2+B6   o


; Renders HUD element variant 3
UI_RenderHUDElement3:                              ; CODE XREF: UI_RenderHUDElement1+104   j  ; was: sub_12FBC
                movea.w #(byte_FF85A8-M68K_RAM),a0
                bra.s   loc_12FD2
; ---------------------------------------------------------------------------
loc_12FC2:                              ; CODE XREF: UI_RenderHUDElement3+42   j
                move.w  #$C7F8,d0
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                bra.s   loc_13032
; ---------------------------------------------------------------------------
loc_12FD2:                              ; CODE XREF: UI_RenderHUDElement3+4   j
                tst.b   (word_FFA270).w
                bne.s   loc_13000
                cmpi.b  #$30,(word_FFA270+1).w ; '0'
                bpl.s   loc_13000
                btst    #0,(byte_FFA272).w
                bne.s   loc_13000
                subq.w  #1,(word_FF8306).w
                bpl.s   loc_13000
                move.w  #$26,(word_FF8306).w ; '&'
                move.b  #$40,d0 ; '@'
                jsr (Sound_PlaySFX).l
                bra.s   loc_12FC2
; ---------------------------------------------------------------------------
loc_13000:                              ; CODE XREF: UI_RenderHUDElement3+1A   j
                                        ; UI_RenderHUDElement3+22   j ...
                move.w  #$C7F8,(a0)+
                move.b  (word_FFA270).w,d0
                andi.w  #$F,d0
                addi.w  #-$384C,d0
                move.w  d0,(a0)+
                move.w  #$C7C1,(a0)+
                move.b  (word_FFA270+1).w,d0
                move.b  d0,d1
                lsr.b   #4,d0
                andi.w  #$F,d0
                addi.w  #-$384C,d0
                move.w  d0,(a0)+
                andi.w  #$F,d1
                addi.w  #-$384C,d1
                move.w  d1,(a0)+
loc_13032:                              ; CODE XREF: UI_RenderHUDElement3+14   j
                movea.w #(byte_FF8570-M68K_RAM),a0
                btst    #3,(byte_FFFF30).w
                beq.s   loc_13056
                move.w  #$C7E2,d0
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  #$C7F8,d0
                moveq   #$16,d7
                bra.w   loc_13118
; ---------------------------------------------------------------------------
loc_13056:                              ; CODE XREF: UI_RenderHUDElement3+80   j
                tst.b   (byte_FFF705).w
                bmi.s   loc_13088
                move.w  (word_FF8206).w,d0
                sub.w   (word_FF8200).w,d0
                bpl.s   loc_13074
                cmpi.w  #$FF00,d0
                bpl.s   loc_1307A
                addi.w  #$100,(word_FF8206).w
                bra.s   loc_13088
; ---------------------------------------------------------------------------
loc_13074:                              ; CODE XREF: UI_RenderHUDElement3+A8   j
                cmpi.w  #$100,d0
                bpl.s   loc_13082
loc_1307A:                              ; CODE XREF: UI_RenderHUDElement3+AE   j
                move.w  (word_FF8200).w,(word_FF8206).w
                bra.s   loc_13088
; ---------------------------------------------------------------------------
loc_13082:                              ; CODE XREF: UI_RenderHUDElement3+BC   j
                subi.w  #$100,(word_FF8206).w
loc_13088:                              ; CODE XREF: UI_RenderHUDElement3+9E   j
                                        ; UI_RenderHUDElement3+B6   j ...
                tst.w   (word_FF829E).w
                bne.w Scroll_UpdateShipScroll
                btst    #2,(byte_FFFF30).w
                beq.s   loc_130E2
                move.w  #$C7B4,d5
                move.w  (word_FF8206).w,d0
                asr.w   #2,d0
                andi.w  #$FFFE,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w Scroll_ShipScrollPattern
                move.w  #$C7E0,(a0)+
                move.w  (word_FF8202).w,d0
                asr.w   #2,d0
                andi.w  #$FFFE,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w Scroll_ShipScrollPattern
                moveq   #$12,d7
                move.w  #$C7F8,d0
loc_130DA:                              ; CODE XREF: UI_RenderHUDElement3+120   j
                move.w  d0,(a0)+
                dbf     d7,loc_130DA
                bra.s   loc_1311E
; ---------------------------------------------------------------------------
loc_130E2:                              ; CODE XREF: UI_RenderHUDElement3+DA   j
                moveq   #$1C,d7
                move.w  (word_FF8206).w,d0
                subq.w  #1,d0
                bmi.s   loc_13110
                move.w  d0,d1
                asr.w   #8,d0
                asr.w   #2,d0
                sub.w   d0,d7
                asr.w   #7,d1
                andi.w  #7,d1
                addi.w  #-$381C,d1
                subq.w  #1,d0
                bmi.s   loc_1310C
                move.w  #$C7EB,d2
loc_13106:                              ; CODE XREF: UI_RenderHUDElement3+14C   j
                move.w  d2,(a0)+
                dbf     d0,loc_13106
loc_1310C:                              ; CODE XREF: UI_RenderHUDElement3+144   j
                move.w  d1,(a0)+
                subq.w  #1,d7
loc_13110:                              ; CODE XREF: UI_RenderHUDElement3+12E   j
                subq.w  #1,d7
                bmi.s   loc_1311E
                move.w  #$C7C3,d0
loc_13118:                              ; CODE XREF: UI_RenderHUDElement3+96   j
                                        ; UI_RenderHUDElement3+15E   j
                move.w  d0,(a0)+
                dbf     d7,loc_13118
loc_1311E:                              ; CODE XREF: UI_RenderHUDElement3+124   j
                                        ; UI_RenderHUDElement3+156   j ...
                movea.w #(byte_FF8570-M68K_RAM),a5
                move.w  #$83,-(a5)
                move.w  #$518C,-(a5)
                move.w  #$95B8,-(a5)
                move.w  #$96C2,-(a5)
                move.w  #$977F,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94009321,-(a5)
                rts
; End of function UI_RenderHUDElement3
; Updates scroll for ship section
Scroll_UpdateShipScroll:                              ; CODE XREF: UI_RenderHUDElement3+D0   j  ; was: sub_13142
                moveq   #$1A,d7
                btst    #1,(word_FFA280+1).w
                bne.s   loc_1316C
                move.w  #$C7F8,(a0)+
                move.w  #$C7B4,d5
                move.w  (word_FF829E).w,d0
                asl.w   #1,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w Scroll_ShipScrollPattern
                moveq   #$16,d7
loc_1316C:                              ; CODE XREF: Scroll_UpdateShipScroll+8   j
                move.w  #$C7F8,d0
loc_13170:                              ; CODE XREF: Scroll_UpdateShipScroll+30   j
                move.w  d0,(a0)+
                dbf     d7,loc_13170
                bra.s   loc_1311E
; End of function Scroll_UpdateShipScroll
; Processes multiple palette slots
Gfx_ProcessPaletteSlots:                              ; CODE XREF: Player_ResetBehaviorPalette+C   j  ; was: sub_13178
                                        ; Stage_LoadXiTigerGraphics+34   p ...
                move.w  (word_FFA24E).w,(dword_FF8040).w
                clr.w   (word_FFA24E).w
                moveq   #3,d7
; Processes each of 4 palette slots in sequence
Gfx_ProcessPaletteSlotsLoop:                              ; CODE XREF: Gfx_ProcessPaletteSlots+12   j  ; was: loc_13184
                bsr.s Gfx_LoadPaletteData
                addq.w  #2,(word_FFA24E).w
                dbf d7,Gfx_ProcessPaletteSlotsLoop
                move.w  (dword_FF8040).w,(word_FFA24E).w
                rts
; End of function Gfx_ProcessPaletteSlots
; ---------------------------------------------------------------------------
word_13196:     dc.w $50B8, $50BE, $50C4, $50CA
                                        ; DATA XREF: Gfx_LoadPaletteData+4   r


; Loads palette data from offset table
Gfx_LoadPaletteData:                              ; CODE XREF: Gfx_ProcessPaletteSlots:loc_13184   p  ; was: sub_1319E
                                        ; UI_InitializeStageStart+EC   p ...
                move.w  (word_FFA24E).w,d0
                move.w  word_13196(pc,d0.w),d3
                movea.w d0,a0
                adda.w  #$A250,a0
                move.w  (a0),d0
; End of function Gfx_LoadPaletteData
; Sets up VDP registers for sprite tiles
Sprite_SetupTileVDP:                              ; CODE XREF: Gfx_SetupWeaponSprites+20   p  ; was: sub_131AE
                asl.w   #1,d0
                addi.w  #-$3A7C,d0
                movea.w (word_FFF70E).w,a1
                move.w  d0,(a1)+
                addq.w  #1,d0
                move.w  d0,(a1)+
                addq.w  #1,d0
                move.w  d0,(a1)+
                addq.w  #1,d0
                move.w  d0,(a1)+
                movea.w (word_FFF70C).w,a1
                bsr.s Gfx_SetupTileDMA
                addq.w  #2,d3
                bsr.s Gfx_SetupTileDMA
                move.w  a1,(word_FFF70C).w
                rts
; End of function Sprite_SetupTileVDP
; Sets up DMA for tile transfer
Gfx_SetupTileDMA:                              ; CODE XREF: Sprite_SetupTileVDP+1C   p  ; was: sub_131D6
                                        ; Sprite_SetupTileVDP+20   p
                move.w  #$83,-(a1)
                move.w  d3,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F80977F,-(a1)
                move.l  #$94009302,-(a1)
                addq.w  #4,(word_FFF70E).w
                rts
; End of function Gfx_SetupTileDMA
; Copies indexed word from lookup table
Data_CopyIndexedWord:
                asl.w   #1,d0  ; was: sub_13206
                move.w  (a4,d0.w),(a1)
; End of function Data_CopyIndexedWord
; Ship scroll movement pattern
Scroll_ShipScrollPattern:                              ; CODE XREF: UI_RenderHUDElement1+1E4   p  ; was: sub_1320C
                                        ; UI_RenderHUDElement1+202   p ...
                moveq   #0,d1
loc_1320E:                              ; CODE XREF: Scroll_ShipScrollPattern+34   j
                move.b  (a1),d0
                lsr.b   #4,d0
                andi.w  #$F,d0
                bne.s   loc_13222
                tst.w   d1
                bne.s   loc_13222
                move.w  #$C7BE,d0
                bra.s   loc_13226
; ---------------------------------------------------------------------------
loc_13222:                              ; CODE XREF: Scroll_ShipScrollPattern+A   j
                                        ; Scroll_ShipScrollPattern+E   j
                addq.w  #1,d1
                add.w   d5,d0
loc_13226:                              ; CODE XREF: Scroll_ShipScrollPattern+14   j
                move.w  d0,(a0)+
                move.b  (a1)+,d0
                andi.w  #$F,d0
                bne.s   loc_1323A
                tst.w   d1
                bne.s   loc_1323A
                move.w  #$C7BE,d0
                bra.s   loc_1323E
; ---------------------------------------------------------------------------
loc_1323A:                              ; CODE XREF: Scroll_ShipScrollPattern+22   j
                                        ; Scroll_ShipScrollPattern+26   j
                addq.w  #1,d1
                add.w   d5,d0
loc_1323E:                              ; CODE XREF: Scroll_ShipScrollPattern+2C   j
                move.w  d0,(a0)+
                dbf     d7,loc_1320E
                rts
; End of function Scroll_ShipScrollPattern
; Renders ship health display with scroll pattern
UI_RenderShipHealthDisplay:                              ; CODE XREF: UI_RenderHUDElement1+122   j  ; was: sub_13246
                movea.w #(byte_FF84B0-M68K_RAM),a0
                move.w  #$C7F4,(a0)+
                move.w  #$C7F5,(a0)+
                move.w  #$C7F6,(a0)+
                move.w  #$C7F7,(a0)+
                move.w  #$C7BF,(a0)+
                move.w  #$C7B4,d5
                movea.w #(dword_FFA212-M68K_RAM),a1
                moveq   #3,d7
                bsr.w Scroll_ShipScrollPattern
                move.w  #$C7D2,(a0)+
                move.w  #$C7D3,(a0)+
                bra.w   loc_12E16
; End of function UI_RenderShipHealthDisplay
; Applies friction to velocity reducing speed
Physics_ApplyFriction:                              ; CODE XREF: Sys_GameplayMainLoop:loc_1C6F0   p  ; was: sub_13278
                                        ; sub_1E8F6   p ...
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
loc_13280:                              ; CODE XREF: UI_RenderDebugMenu+C   p
                tst.b   (byte_FFF705).w
                bpl.w   loc_13350
                btst    #0,(byte_FFF705).w
                beq.w   loc_13350
                btst    #4,(word_FFF706).w
                bne.w   loc_13350
                tst.w   (word_FFFF0E).w
                bne.s   loc_132CE
                btst    #2,(word_FFF708).w
                beq.s   loc_132B4
                subq.w  #1,(word_FFFF3E).w
                bpl.s   loc_132CE
                clr.w   (word_FFFF3E).w
loc_132B4:                              ; CODE XREF: Physics_ApplyFriction+30   j
                btst    #3,(word_FFF708).w
                beq.s   loc_132CE
                addq.w  #1,(word_FFFF3E).w
                cmpi.w  #4,(word_FFFF3E).w
                bmi.s   loc_132CE
                move.w  #3,(word_FFFF3E).w
loc_132CE:                              ; CODE XREF: Physics_ApplyFriction+28   j
                                        ; Physics_ApplyFriction+36   j ...
                btst    #1,(word_FFA280+1).w
                bne.w   loc_132FA
                move.w  #$A2,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C7F9,(a1)+
                move.w  #$194,(a1)+
                move.w  #$A2,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7FD,(a1)+
                move.w  #$1B4,(a1)+
                bra.s   loc_13350
; ---------------------------------------------------------------------------
loc_132FA:                              ; CODE XREF: Physics_ApplyFriction+5C   j
                tst.w   (word_FFFF0E).w
                bne.s   loc_13350
                move.w  #$150,d0
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C7D8,(a1)+
                move.w  #$10C,(a1)+
                move.w  (word_FFFF3E).w,d1
                andi.w  #3,d1
                subq.w  #1,d1
                bmi.s   loc_13350
                move.w  d0,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7DB,(a1)+
                move.w  #$12C,(a1)+
                subq.w  #1,d1
                bmi.s   loc_13350
                move.w  d0,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7DB,(a1)+
                move.w  #$134,(a1)+
                subq.w  #1,d1
                bmi.s   loc_13350
                move.w  d0,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7DB,(a1)+
                move.w  #$13C,(a1)+
loc_13350:                              ; CODE XREF: Physics_ApplyFriction+C   j
                                        ; Physics_ApplyFriction+16   j ...
                move.w  #$80,(a1)+
                move.w  #$B00,(a1)+
                move.w  #$C6F0,(a1)+
                btst    #0,(word_FFA280+1).w
                bne.s   loc_1336A
                tst.b   (byte_FFFF31).w
                beq.s   loc_13370
loc_1336A:                              ; CODE XREF: Physics_ApplyFriction+EA   j
                move.w  #1,(a1)+
                bra.s   loc_1337E
; ---------------------------------------------------------------------------
loc_13370:                              ; CODE XREF: Physics_ApplyFriction+F0   j
                lea     word_133CC(pc),a2
                nop
                move.w  (word_FFA24E).w,d1
                move.w  (a2,d1.w),(a1)+
loc_1337E:                              ; CODE XREF: Physics_ApplyFriction+F6   j
                move.w  #$80,(a1)+
                move.w  #$300,(a1)+
                move.w  d0,(a1)+
                clr.w   (a1)+
                move.w  (word_FF8110).w,d2
                beq.s Sprite_FinalizeOAMBuffer
                tst.w   (word_FF8112).w
                bpl.s   loc_133A0
                clr.w   (word_FF8110).w
                clr.w   (word_FF8112).w
                bra.s Sprite_FinalizeOAMBuffer
; ---------------------------------------------------------------------------
loc_133A0:                              ; CODE XREF: Physics_ApplyFriction+11C   j
                move.w  #$A0,d0
                move.w  #$700,d1
                move.w  #$60,d3 ; '`'
                add.w   (word_FF8112).w,d3
                moveq   #5,d7
loc_133B2:                              ; CODE XREF: Physics_ApplyFriction+146   j
                move.w  d0,(a1)+
                move.w  d1,(a1)+
                move.w  d2,(a1)+
                move.w  d3,(a1)+
                addi.w  #$20,d0 ; ' '
                dbf     d7,loc_133B2
; Finalizes OAM buffer with end marker and adds to sprite list
Sprite_FinalizeOAMBuffer:                              ; CODE XREF: Physics_ApplyFriction+116   j  ; was: loc_133C2
                                        ; Physics_ApplyFriction+126   j
                move.w  #$FFFF,(a1)
                jmp (Sprite_AddToOAMBuffer).l
; End of function Physics_ApplyFriction
; ---------------------------------------------------------------------------
word_133CC:     dc.w $160, $178, $190, $1A8
                                        ; DATA XREF: Physics_ApplyFriction:loc_13370   o


; Sets up DMA transfer for score display rendering to VDP
UI_SetupScoreDMA:                              ; CODE XREF: UI_RenderHUDElement1:loc_12C56   p  ; was: sub_133D4
                                        ; sub_134E2   p ...
                move.w  (word_FFA21E).w,d0
                beq.s   locret_13428
                cmpi.w  #1,d0
                beq.s   locret_13428
                move.w  #1,(word_FFA21E).w
                movea.w #(byte_FF8488-M68K_RAM),a5
                move.w  #$82,-(a5)
                move.w  #$7400,-(a5)
                lea     off_1342A(pc),a0
                nop
                subq.w  #4,d0
                move.l  (a0,d0.w),d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a5)
                move.b  #$95,-(a5)
                move.b  d1,-(a5)
                move.b  #$96,-(a5)
                move.b  d2,-(a5)
                move.b  #$97,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94029300,-(a5)
locret_13428:                           ; CODE XREF: UI_SetupScoreDMA+4   j
                                        ; UI_SetupScoreDMA+A   j
                rts
; End of function UI_SetupScoreDMA
; ---------------------------------------------------------------------------
off_1342A:      dc.l sprite_FD30E         ; DATA XREF: UI_SetupScoreDMA+1E   o
                dc.l sprite_FD62E
                dc.l sprite_FE78E
                dc.l sprite_FE78E
                dc.l sprite_FD86E
                dc.l sprite_FD86E
                dc.l sprite_FD86E
                dc.l sprite_FD86E


; Sets up VDP DMA transfer registers
Gfx_SetupVDPDMA:                              ; CODE XREF: Gfx_LoadWeaponIcon+4C   j  ; was: sub_1344A
                move.w  #1,(word_FFA21E).w
                movea.w #(byte_FF8488-M68K_RAM),a0
                move.w  #$82,-(a0)
                move.w  #$7400,-(a0)
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d2
                move.b  (dword_FF8040+1).w,d3
                andi.w  #$7F,d3
                move.b  d0,-(a0)
                move.b  #$95,-(a0)
                move.b  d2,-(a0)
                move.b  #$96,-(a0)
                move.b  d3,-(a0)
                move.b  #$97,-(a0)
                move.w  #$8F02,-(a0)
                move.l  d1,-(a0)
                rts
; End of function Gfx_SetupVDPDMA
; Updates status display based on current mode
UI_UpdateStatusDisplay:
                move.w  #$5200,d2  ; was: sub_13488
                move.w  (word_FF820C).w,d0
                movea.w off_1349C(pc,d0.w),a0
                adda.l  #UI_StatusEmptyHandler,a0
                jmp     (a0)
; End of function UI_UpdateStatusDisplay
; ---------------------------------------------------------------------------
off_1349C:      dc.w UI_StatusEmptyHandler-UI_StatusEmptyHandler
                                        ; DATA XREF: UI_UpdateStatusDisplay+8   r
                dc.w UI_StatusEmptyHandler-UI_StatusEmptyHandler
                dc.w UI_StatusEmptyHandler-UI_StatusEmptyHandler
                dc.w UI_StatusEmptyHandler-UI_StatusEmptyHandler
                dc.w UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w UI_CycleDisplayMode-UI_StatusEmptyHandler


; Empty UI status display handler
UI_StatusEmptyHandler:                             ; DATA XREF: UI_UpdateStatusDisplay+C   o  ; was: nullsub_34
                                        ; ROM:off_1349C   o ...
                rts
; End of function UI_StatusEmptyHandler
; ---------------------------------------------------------------------------
word_134B6:     dc.w $5200, $5280, $5300, $5380, $5210, $5290, $5310, $5390
                                        ; DATA XREF: UI_CycleDisplayMode+2   r


; Cycles through display modes and updates VDP
UI_CycleDisplayMode:                              ; DATA XREF: ROM:000134A4   o  ; was: sub_134C6
                                        ; ROM:000134A6   o ...
                subq.w  #8,d0
                move.w  word_134B6(pc,d0.w),d2
                addq.w  #2,(word_FF820C).w
                andi.w  #6,d0
                addq.w  #2,d0
                cmpi.w  #8,d0
                bmi.s   locret_134E0
                clr.w   (word_FF820C).w
locret_134E0:                           ; CODE XREF: UI_CycleDisplayMode+14   j
                rts
; End of function UI_CycleDisplayMode
; Renders debug menu with score display
UI_RenderDebugMenu:                              ; CODE XREF: UI_RenderHUDElement1+52   j  ; was: sub_134E2
                bsr.w UI_SetupScoreDMA
                movea.w #(byte_FFA108-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
                bsr.w   loc_13280
                move.b  (word_FFF708).w,d0
                andi.b  #$4F,d0 ; 'O'
                cmp.b   (byte_FF866A).w,d0
                beq.s   loc_1350A
                move.b  d0,(byte_FF866A).w
                move.w  #$C,(word_FF866C).w
loc_1350A:                              ; CODE XREF: UI_RenderDebugMenu+1C   j
                subq.w  #1,(word_FF866C).w
                bpl.s   loc_13514
                clr.w   (word_FF866C).w
loc_13514:                              ; CODE XREF: UI_RenderDebugMenu+2C   j
                move.w  (word_FF8226).w,d0
                movea.w off_13524(pc,d0.w),a0
                adda.l  #UI_InitDebugMenuState,a0
                jmp     (a0)
; End of function UI_RenderDebugMenu
; ---------------------------------------------------------------------------
off_13524:      dc.w locret_1356C-UI_InitDebugMenuState
                                        ; DATA XREF: UI_RenderDebugMenu+36   r
                dc.w UI_InitDebugMenuState-UI_InitDebugMenuState
                dc.w UI_UpdateDebugMenu-UI_InitDebugMenuState


; Initializes debug menu state and loads data
UI_InitDebugMenuState:                              ; DATA XREF: UI_RenderDebugMenu+3A   o  ; was: sub_1352A
                                        ; ROM:off_13524   o ...
                tst.w   (word_FFF720).w
                bmi.s   locret_1356C
                clr.w   (word_FF8660).w
                clr.w   (word_FF8664).w
                clr.w   (word_FF8666).w
                clr.w   (word_FF8668).w
                move.w  #4,(word_FF8662).w
                move.w  (word_FFA216).w,d0
                asr.w   #4,d0
                move.b  d0,(byte_FF866B).w
                tst.w   (word_FF822A).w
                beq.s   loc_1355C
                move.b  #$FF,(byte_FF866B).w
loc_1355C:                              ; CODE XREF: UI_InitDebugMenuState+2A   j
                addq.w  #2,(word_FF8226).w
                movea.l #stru_1356E,a0
                jmp     (LoadObjData).l
; ---------------------------------------------------------------------------
locret_1356C:                           ; CODE XREF: UI_InitDebugMenuState+4   j
                                        ; DATA XREF: ROM:off_13524   o
                rts
; End of function UI_InitDebugMenuState
; ---------------------------------------------------------------------------
stru_1356E:     dc.w 3                  ; field_0
                                        ; DATA XREF: UI_InitDebugMenuState+36   o
                dc.l byte_18E36C        ; field_2
                dc.w $F680              ; field_6
                dc.w $FFFF
stru_13578:     dc.w 3                  ; field_0
                                        ; DATA XREF: UI_UpdateDebugMenu:loc_135B6   o
                dc.l byte_18DA38        ; field_2
                dc.w $F680              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18DF92        ; field_2
                dc.w $D000              ; field_6
                dc.w $FFFF


; Updates debug menu state based on mode
UI_UpdateDebugMenu:                              ; DATA XREF: ROM:00013528   o  ; was: sub_1358A
                tst.b   (byte_FFF705).w
                bmi.s   loc_135C6
                clr.w   (word_FF8226).w
                move.b  (byte_FF866B).w,d0
                cmpi.b  #$FF,d0
                bne.s   loc_135AC
                move.w  #$400,(word_FFA218).w
                move.w  #$400,(word_FFA216).w
                bra.s   loc_135B6
; ---------------------------------------------------------------------------
loc_135AC:                              ; CODE XREF: UI_UpdateDebugMenu+12   j
                asl.w   #4,d0
                move.w  d0,(word_FFA216).w
                move.w  d0,(word_FFA218).w
loc_135B6:                              ; CODE XREF: UI_UpdateDebugMenu+20   j
                movea.l #stru_13578,a0
                jsr     (LoadObjData).l
                jmp Gfx_ProcessPaletteSlots(pc)   ; (pc)
; ---------------------------------------------------------------------------
loc_135C6:                              ; CODE XREF: UI_UpdateDebugMenu+4   j
                btst    #6,(word_FFF708).w
                beq.s   loc_135DE
                addq.w  #2,(word_FF8660).w
                cmpi.w  #$A,(word_FF8660).w
                bmi.s   loc_135DE
                clr.w   (word_FF8660).w
loc_135DE:                              ; CODE XREF: UI_UpdateDebugMenu+42   j
                                        ; UI_UpdateDebugMenu+4E   j
                btst    #0,(word_FFA280+1).w
                bne.s   loc_135FE
                bsr.w UI_LoadStatusTileMap1
                bsr.w UI_DispatchStatusUpdate
                bsr.w UI_RenderStageNumber
                bsr.w UI_LoadWeaponTiles
                bsr.w UI_RenderColorCursor
                bra.w UI_SetupStatusVDP1
; ---------------------------------------------------------------------------
loc_135FE:                              ; CODE XREF: UI_UpdateDebugMenu+5A   j
                bsr.w UI_LoadStatusTileMap2
                bsr.w UI_DispatchStatusUpdate
                bsr.w UI_RenderWeaponType
                bsr.w UI_RenderMenuSelection1
                bsr.w UI_DecodeColorValue
                bsr.w UI_RenderWeaponNumber
                bra.w UI_SetupStatusVDP2
; End of function UI_UpdateDebugMenu
; Loads status display tilemap for mode 1
UI_LoadStatusTileMap1:                              ; CODE XREF: UI_UpdateDebugMenu+5C   p  ; was: sub_1361A
                movea.l #word_13652,a0
                movea.w #(byte_FF8510-M68K_RAM),a1
                moveq   #$13,d7
loc_13626:                              ; CODE XREF: UI_LoadStatusTileMap1+E   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_13626
                rts
; End of function UI_LoadStatusTileMap1
; Sets up VDP registers for status mode 1
UI_SetupStatusVDP1:                              ; CODE XREF: UI_UpdateDebugMenu+70   j  ; was: sub_1362E
                movea.w #(byte_FF8510-M68K_RAM),a5
                move.w  #$83,-(a5)
                move.w  #$5080,-(a5)
                move.w  #$9588,-(a5)
                move.w  #$96C2,-(a5)
                move.w  #$977F,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94009328,-(a5)
                rts
; End of function UI_SetupStatusVDP1
; ---------------------------------------------------------------------------
word_13652:     dc.w $C7B5, $C7B5, $C7D4, $C7D5, $C7D6, $C7D7, $C7D8, $C7B5, $C7B5, $C7B5
                                        ; DATA XREF: UI_LoadStatusTileMap1   o
                dc.w $C7DE, $C7DF, $C7E0, $C7E1, $C7B5, $C7B5, $C7B5, $C7B5, $C7B4, $C7B5
                dc.w $C7B6, $C7B7, $C7B8, $C7B9, $C7BA, $C7BB, $C7BC, $C7BD, $C7BE, $C7BF
                dc.w $C7C0, $C7C1, $C7C2, $C7C3, $C7B5, $C7EB, $C7EA, $C7E9, $C7B5, $C7B5


; Loads status display tilemap for mode 2
UI_LoadStatusTileMap2:                              ; CODE XREF: UI_UpdateDebugMenu:loc_135FE   p  ; was: sub_136A2
                movea.l #word_136DA,a0
                movea.w #(byte_FF8570-M68K_RAM),a1
                moveq   #$13,d7
loc_136AE:                              ; CODE XREF: UI_LoadStatusTileMap2+E   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_136AE
                rts
; End of function UI_LoadStatusTileMap2
; Sets up VDP registers for status mode 2
UI_SetupStatusVDP2:                              ; CODE XREF: UI_UpdateDebugMenu+8C   j  ; was: sub_136B6
                movea.w #(byte_FF8570-M68K_RAM),a5
                move.w  #$83,-(a5)
                move.w  #$5100,-(a5)
                move.w  #$95B8,-(a5)
                move.w  #$96C2,-(a5)
                move.w  #$977F,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94009328,-(a5)
                rts
; End of function UI_SetupStatusVDP2
; ---------------------------------------------------------------------------
word_136DA:     dc.w $C7B5, $C7B5, $C7D9, $C7DA, $C7DB, $C7DC, $C7DD, $C7B5, $C7B5, $C7B5
                                        ; DATA XREF: UI_LoadStatusTileMap2   o
                dc.w $C7E6, $C7E7, $C7E8, $C7B5, $C7B5, $C7B5, $C7B5, $C7B5, $C7C4, $C7C5
                dc.w $C7C6, $C7C7, $C7C8, $C7C9, $C7CA, $C7CB, $C7CC, $C7CD, $C7CE, $C7CF
                dc.w $C7D0, $C7D1, $C7D2, $C7D3, $C7B5, $C7B5, $C7B5, $C7B5, $C7B5, $C7B5


; Dispatches status update based on mode
UI_DispatchStatusUpdate:                              ; CODE XREF: UI_UpdateDebugMenu+60   p  ; was: sub_1372A
                                        ; UI_UpdateDebugMenu+78   p
                bsr.w UI_SetupScoreDMA
                move.w  (word_FF8660).w,d0
                movea.w off_1373E(pc,d0.w),a0
                adda.l  #UI_MenuSelectStage,a0
                jmp     (a0)
; End of function UI_DispatchStatusUpdate
; ---------------------------------------------------------------------------
off_1373E:      dc.w UI_MenuSelectStage-UI_MenuSelectStage
                                        ; DATA XREF: UI_DispatchStatusUpdate+8   r
                dc.w UI_MenuSelectWeapon-UI_MenuSelectStage
                dc.w UI_MenuResetOption-UI_MenuSelectStage
                dc.w UI_MenuNavigateVertical-UI_MenuSelectStage
                dc.w UI_MenuColorPicker-UI_MenuSelectStage


; Handles stage selection menu navigation
UI_MenuSelectStage:                              ; DATA XREF: UI_DispatchStatusUpdate+C   o  ; was: sub_13748
                                        ; ROM:off_1373E   o ...
                clr.w   (word_FF8666).w
                btst    #3,(word_FFA280+1).w
                bne.s   loc_1375A
                move.w  #$C7E5,(word_FF8512).w
loc_1375A:                              ; CODE XREF: UI_MenuSelectStage+A   j
                move.b  (byte_FF866B).w,d0
                moveq   #1,d1
                movea.w #(word_FFF706-M68K_RAM),a0
                tst.w   (word_FF866C).w
                beq.s   loc_1376E
                movea.w #(word_FFF708-M68K_RAM),a0
loc_1376E:                              ; CODE XREF: UI_MenuSelectStage+20   j
                btst    #2,(a0)
                beq.s   loc_1378C
                cmpi.b  #0,d0
                beq.s   loc_13786
                cmpi.b  #$FF,d0
                beq.s   loc_137AC
                sub.w   d2,d2
                sbcd    d1,d0
                bra.s   loc_137AC
; ---------------------------------------------------------------------------
loc_13786:                              ; CODE XREF: UI_MenuSelectStage+30   j
                move.b  #$FF,d0
                bra.s   loc_137AC
; ---------------------------------------------------------------------------
loc_1378C:                              ; CODE XREF: UI_MenuSelectStage+2A   j
                btst    #3,(a0)
                beq.s   loc_137AC
                cmpi.b  #$FF,d0
                bne.s   loc_1379C
                moveq   #0,d0
                bra.s   loc_137AC
; ---------------------------------------------------------------------------
loc_1379C:                              ; CODE XREF: UI_MenuSelectStage+4E   j
                sub.w   d2,d2
                abcd    d1,d0
                move.w  #$400,d1
                asr.w   #4,d1
                cmp.b   d1,d0
                bmi.s   loc_137AC
                move.b  d1,d0
loc_137AC:                              ; CODE XREF: UI_MenuSelectStage+36   j
                                        ; UI_MenuSelectStage+3C   j ...
                clr.w   (word_FF822A).w
                move.b  d0,(byte_FF866B).w
                cmpi.b  #$FF,d0
                bne.s   locret_137BE
                addq.w  #2,(word_FF822A).w
locret_137BE:                           ; CODE XREF: UI_MenuSelectStage+70   j
                rts
; End of function UI_MenuSelectStage
; Handles weapon selection menu navigation
UI_MenuSelectWeapon:                              ; DATA XREF: ROM:00013740   o  ; was: sub_137C0
                btst    #3,(word_FFA280+1).w
                bne.s   loc_137CE
                move.w  #$C7E5,(word_FF8572).w
loc_137CE:                              ; CODE XREF: UI_MenuSelectWeapon+6   j
                move.b  (word_FF8228).w,d0
                movea.w #(word_FFF706-M68K_RAM),a0
                tst.w   (word_FF866C).w
                beq.s   loc_137E0
                movea.w #(word_FFF708-M68K_RAM),a0
loc_137E0:                              ; CODE XREF: UI_MenuSelectWeapon+1A   j
                btst    #2,(a0)
                beq.s   loc_137EE
                subq.b  #1,d0
                move.b  d0,(word_FF8228).w
                rts
; ---------------------------------------------------------------------------
loc_137EE:                              ; CODE XREF: UI_MenuSelectWeapon+24   j
                btst    #3,(a0)
                beq.s   locret_137FA
                addq.w  #1,d0
                move.b  d0,(word_FF8228).w
locret_137FA:                           ; CODE XREF: UI_MenuSelectWeapon+32   j
                rts
; End of function UI_MenuSelectWeapon
; Handles B button press to reset option
UI_MenuResetOption:                              ; DATA XREF: ROM:00013742   o  ; was: sub_137FC
                btst    #4,(word_FFF708).w
                beq.s   loc_13808
                clr.w   (word_FF8200).w
loc_13808:                              ; CODE XREF: UI_MenuResetOption+6   j
                btst    #3,(word_FFA280+1).w
                bne.s   locret_13816
                move.w  #$C7E5,(word_FF8522).w
locret_13816:                           ; CODE XREF: UI_MenuResetOption+12   j
                rts
; End of function UI_MenuResetOption
; Handles up/down menu navigation
UI_MenuNavigateVertical:                              ; DATA XREF: ROM:00013744   o  ; was: sub_13818
                btst    #3,(word_FFA280+1).w
                bne.s   loc_13826
                move.w  #$C7E5,(word_FF8582).w
loc_13826:                              ; CODE XREF: UI_MenuNavigateVertical+6   j
                move.b  (word_FFF708).w,d0
                andi.b  #$C,d0
                beq.s   locret_1383A
                addq.w  #2,(word_FF8662).w
                andi.w  #6,(word_FF8662).w
locret_1383A:                           ; CODE XREF: UI_MenuNavigateVertical+16   j
                rts
; End of function UI_MenuNavigateVertical
; Handles RGB color picker navigation
UI_MenuColorPicker:                              ; DATA XREF: ROM:00013746   o  ; was: sub_1383C
                btst    #3,(word_FFA280+1).w
                bne.s   loc_13858
                tst.w   (word_FF8666).w
                beq.s   loc_13852
                move.w  #$C7E5,(word_FF8554).w
                bra.s   loc_13858
; ---------------------------------------------------------------------------
loc_13852:                              ; CODE XREF: UI_MenuColorPicker+C   j
                move.w  #$C7E5,(word_FF8532).w
loc_13858:                              ; CODE XREF: UI_MenuColorPicker+6   j
                                        ; UI_MenuColorPicker+14   j
                tst.w   (word_FF8666).w
                beq.w   loc_138A2
                bsr.w UI_UpdateColorValue
                btst    #4,(word_FFF708).w
                beq.s   loc_13872
                clr.w   (word_FF8666).w
                rts
; ---------------------------------------------------------------------------
loc_13872:                              ; CODE XREF: UI_MenuColorPicker+2E   j
                btst    #2,(word_FFF708).w
                beq.s   loc_13888
                subq.w  #2,(word_FF8668).w
                bpl.s   locret_138A0
                move.w  #4,(word_FF8668).w
                rts
; ---------------------------------------------------------------------------
loc_13888:                              ; CODE XREF: UI_MenuColorPicker+3C   j
                btst    #3,(word_FFF708).w
                beq.s   locret_138A0
                addq.w  #2,(word_FF8668).w
                cmpi.w  #6,(word_FF8668).w
                bmi.s   locret_138A0
                clr.w   (word_FF8668).w
locret_138A0:                           ; CODE XREF: UI_MenuColorPicker+42   j
                                        ; UI_MenuColorPicker+52   j ...
                rts
; ---------------------------------------------------------------------------
loc_138A2:                              ; CODE XREF: UI_MenuColorPicker+20   j
                btst    #4,(word_FFF708).w
                beq.s   loc_138B4
                addq.w  #1,(word_FF8666).w
                clr.w   (word_FF8668).w
                rts
; ---------------------------------------------------------------------------
loc_138B4:                              ; CODE XREF: UI_MenuColorPicker+6C   j
                btst    #2,(word_FFF708).w
                beq.s   loc_138C2
                subq.w  #2,(word_FF8664).w
                bra.s   loc_138CE
; ---------------------------------------------------------------------------
loc_138C2:                              ; CODE XREF: UI_MenuColorPicker+7E   j
                btst    #3,(word_FFF708).w
                beq.s   loc_138CE
                addq.w  #2,(word_FF8664).w
loc_138CE:                              ; CODE XREF: UI_MenuColorPicker+84   j
                                        ; UI_MenuColorPicker+8C   j
                andi.w  #$1E,(word_FF8664).w
                rts
; End of function UI_MenuColorPicker
; Renders menu selection cursor
UI_RenderMenuSelection1:                              ; CODE XREF: UI_UpdateDebugMenu+80   p  ; was: sub_138D6
                btst    #2,(word_FFA280+1).w
                bne.s   locret_138EC
                move.w  (word_FF8664).w,d0
                addi.w  #-$7A6C,d0
                movea.w d0,a0
                move.w  #$D7E4,(a0)
locret_138EC:                           ; CODE XREF: UI_RenderMenuSelection1+6   j
                rts
; End of function UI_RenderMenuSelection1
; Renders color picker cursor
UI_RenderColorCursor:                              ; CODE XREF: UI_UpdateDebugMenu+6C   p  ; was: sub_138EE
                tst.w   (word_FF8666).w
                beq.s   locret_1390A
                btst    #2,(word_FFA280+1).w
                bne.s   locret_1390A
                move.w  (word_FF8668).w,d0
                addi.w  #-$7AAA,d0
                movea.w d0,a0
                move.w  #$C7E4,(a0)
locret_1390A:                           ; CODE XREF: UI_RenderColorCursor+4   j
                                        ; UI_RenderColorCursor+C   j
                rts
; End of function UI_RenderColorCursor
; Converts stage number to tilemap digits
UI_RenderStageNumber:                              ; CODE XREF: UI_UpdateDebugMenu+64   p  ; was: sub_1390C
                move.b  (byte_FF866B).w,d0
                cmpi.b  #$FF,d0
                bne.s   loc_13924
                move.w  #$C7E2,(word_FF851E).w
                move.w  #$C7DE,(word_FF8520).w
                rts
; ---------------------------------------------------------------------------
loc_13924:                              ; CODE XREF: UI_RenderStageNumber+8   j
                move.b  d0,d1
                andi.w  #$F,d0
                addi.w  #-$383C,d0
                move.w  d0,(word_FF8520).w
                asr.w   #4,d1
                andi.w  #$F,d1
                addi.w  #-$383C,d1
                move.w  d1,(word_FF851E).w
                rts
; End of function UI_RenderStageNumber
; Converts weapon number to tilemap digits
UI_RenderWeaponNumber:                              ; CODE XREF: UI_UpdateDebugMenu+88   p  ; was: sub_13942
                move.b  (word_FF8228).w,d0
                move.b  d0,d1
                andi.w  #$F,d0
                addi.w  #-$383C,d0
                move.w  d0,(word_FF8580).w
                asr.w   #4,d1
                andi.w  #$F,d1
                addi.w  #-$383C,d1
                move.w  d1,(word_FF857E).w
                rts
; End of function UI_RenderWeaponNumber
; Loads weapon icon tiles
UI_LoadWeaponTiles:                              ; CODE XREF: UI_UpdateDebugMenu+68   p  ; was: sub_13964
                moveq   #0,d0
                move.w  (word_FF8662).w,d0
                asl.w   #4,d0
                addi.l  #word_13992,d0
                movea.l d0,a0
                movea.w #(byte_FF8534-M68K_RAM),a1
                moveq   #$F,d7
loc_1397A:                              ; CODE XREF: UI_LoadWeaponTiles+18   j
                move.w  (a0)+,(a1)+
                dbf     d7,loc_1397A
                rts
; End of function UI_LoadWeaponTiles
; Renders weapon type number as digit
UI_RenderWeaponType:                              ; CODE XREF: UI_UpdateDebugMenu+7C   p  ; was: sub_13982
                move.w  (word_FF8662).w,d0
                asr.w   #1,d0
                addi.w  #-$383C,d0
                move.w  d0,(word_FF858A).w
                rts
; End of function UI_RenderWeaponType
; ---------------------------------------------------------------------------
word_13992:     dc.w $87B4, $87B5, $87B6, $87B7, $87B8, $87B9, $87BA, $87BB
                                        ; DATA XREF: UI_LoadWeaponTiles+8   o
                dc.w $87BC, $87BD, $87BE, $87BF, $87C0, $87C1, $87C2, $87C3
                dc.w $A7B4, $A7B5, $A7B6, $A7B7, $A7B8, $A7B9, $A7BA, $A7BB
                dc.w $A7BC, $A7BD, $A7BE, $A7BF, $A7C0, $A7C1, $A7C2, $A7C3
                dc.w $C7B4, $C7B5, $C7B6, $C7B7, $C7B8, $C7B9, $C7BA, $C7BB
                dc.w $C7BC, $C7BD, $C7BE, $C7BF, $C7C0, $C7C1, $C7C2, $C7C3
                dc.w $E7B4, $E7B5, $E7B6, $E7B7, $E7B8, $E7B9, $E7BA, $E7BB
                dc.w $E7BC, $E7BD, $E7BE, $E7BF, $E7C0, $E7C1, $E7C2, $E7C3


; Decodes and displays RGB color value
UI_DecodeColorValue:                              ; CODE XREF: UI_UpdateDebugMenu+84   p  ; was: sub_13A12
                move.w  (word_FF8662).w,d0
                asl.w   #4,d0
                add.w   (word_FF8664).w,d0
                addi.w  #-$1C80,d0
                movea.w d0,a0
                move.w  (a0),d0
                move.w  d0,d1
                move.w  d1,d2
                andi.w  #$E00,d0
                asr.w   #8,d0
                addi.w  #-$383C,d0
                move.w  d0,(word_FF85B6).w
                andi.w  #$E0,d1
                asr.w   #4,d1
                addi.w  #-$383C,d1
                move.w  d1,(word_FF85B8).w
                andi.w  #$E,d2
                addi.w  #-$383C,d2
                move.w  d2,(word_FF85BA).w
                rts
; End of function UI_DecodeColorValue
; Updates RGB color value from input
UI_UpdateColorValue:                              ; CODE XREF: UI_MenuColorPicker+24   p  ; was: sub_13A52
                move.w  (word_FF8662).w,d0
                asl.w   #4,d0
                add.w   (word_FF8664).w,d0
                addi.w  #-$1C80,d0
                movea.w d0,a0
                move.b  (word_FFF708).w,d1
                move.w  (a0),d0
                move.w  d0,d2
                move.w  (word_FF8668).w,d3
                beq.s   loc_13AB6
                cmpi.w  #2,d3
                beq.s   loc_13A96
                andi.w  #$EE0,d0
                btst    #0,d1
                beq.s   loc_13A86
                subi.w  #2,d2
                bra.s   loc_13A90
; ---------------------------------------------------------------------------
loc_13A86:                              ; CODE XREF: UI_UpdateColorValue+2C   j
                btst    #1,d1
                beq.s   loc_13A90
                addi.w  #2,d2
loc_13A90:                              ; CODE XREF: UI_UpdateColorValue+32   j
                                        ; UI_UpdateColorValue+38   j
                andi.w  #$E,d2
                bra.s   loc_13AD4
; ---------------------------------------------------------------------------
loc_13A96:                              ; CODE XREF: UI_UpdateColorValue+22   j
                andi.w  #$E0E,d0
                btst    #0,d1
                beq.s   loc_13AA6
                subi.w  #$20,d2 ; ' '
                bra.s   loc_13AB0
; ---------------------------------------------------------------------------
loc_13AA6:                              ; CODE XREF: UI_UpdateColorValue+4C   j
                btst    #1,d1
                beq.s   loc_13AB0
                addi.w  #$20,d2 ; ' '
loc_13AB0:                              ; CODE XREF: UI_UpdateColorValue+52   j
                                        ; UI_UpdateColorValue+58   j
                andi.w  #$E0,d2
                bra.s   loc_13AD4
; ---------------------------------------------------------------------------
loc_13AB6:                              ; CODE XREF: UI_UpdateColorValue+1C   j
                andi.w  #$EE,d0
                btst    #0,d1
                beq.s   loc_13AC6
                subi.w  #$200,d2
                bra.s   loc_13AD0
; ---------------------------------------------------------------------------
loc_13AC6:                              ; CODE XREF: UI_UpdateColorValue+6C   j
                btst    #1,d1
                beq.s   loc_13AD0
                addi.w  #$200,d2
loc_13AD0:                              ; CODE XREF: UI_UpdateColorValue+72   j
                                        ; UI_UpdateColorValue+78   j
                andi.w  #$E00,d2
loc_13AD4:                              ; CODE XREF: UI_UpdateColorValue+42   j
                                        ; UI_UpdateColorValue+62   j
                add.w   d2,d0
                move.w  d0,-$80(a0)
                move.w  d0,(a0)
                rts
; End of function UI_UpdateColorValue
; Updates all boss collision detection systems including terrain and projectiles
Boss_UpdateCollisionSystem:                              ; CODE XREF: Sys_GameplayMainLoop:loc_1C6A6   p  ; was: sub_13ADE
                                        ; Sys_UpdateGameplayLoop+6   p
                tst.b   (byte_FF813E).w
                bmi.s   locret_13B28
                bsr.w Enemy_BuildCollisionLists
                movea.w #(dword_FFBFC0-M68K_RAM),a5
                btst    #0,(word_FFA000+1).w
                bne.s   loc_13AF8
                movea.w #(byte_FFC020-M68K_RAM),a5
loc_13AF8:                              ; CODE XREF: Boss_UpdateCollisionSystem+14   j
                bsr.w Enemy_DetectPlayerCollision
                bsr.w Collision_CheckTerrainTiles
                bsr.w Player_DetectProjectileHit
                bsr.w Sprite_SetBossOAMEntry
                bsr.w Collision_PlayerWeaponVsEnemy
                tst.w   (word_FFA216).w
                bpl.s   loc_13B16
                clr.w   (word_FFA216).w
loc_13B16:                              ; CODE XREF: Boss_UpdateCollisionSystem+32   j
                tst.w   (word_FF822A).w
                beq.s   locret_13B28
                move.w  (word_FFA218).w,(word_FFA216).w
                move.w  #$5000,(word_FFA270).w
locret_13B28:                           ; CODE XREF: Boss_UpdateCollisionSystem+4   j
                                        ; Boss_UpdateCollisionSystem+3C   j
                rts
; End of function Boss_UpdateCollisionSystem
; Builds collision lists for all active enemy entities by type
