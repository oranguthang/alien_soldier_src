Sys_ClearDMABuffer:                                     ; CODE XREF: Gfx_LoadAndDecompTiles+1A   p  ; was: sub_2A58
                                        ; Gfx_LoadCompressedGfx+1A   p
                lea     (dword_FFB400).w,a5
                moveq   #0,d6
                moveq   #$1F,d7
loc_2A60:                                               ; CODE XREF: Sys_ClearDMABuffer+A   j
                move.l  d6,(a5)+
                dbf     d7,loc_2A60
                rts
; End of function Sys_ClearDMABuffer
; Processes and converts compressed tile bitplane data extracting pixel patterns from packed format
Gfx_ProcessTileData:                                    ; CODE XREF: Gfx_LoadAndDecompTiles:Gfx_LoadAndDecompTiles_Loop   p  ; was: sub_2A68
                                        ; sub_2700:loc_271E   p
                movem.l d2-d7/a4-a5,-(sp)
                move.w  (dword_FFF730).w,d2
                move.w  (dword_FFF730+2).w,d3
                lea     (dword_FFB400).w,a5
                lea     dword_FFB480-dword_FFB400(a5),a4
loc_2A7C:                                               ; CODE XREF: Gfx_ProcessTileData+162   j
                subq.w  #5,d2
                bgt.w   loc_2AAA
                beq.w   loc_2A9E
                move.w  d2,d7
                addq.w  #5,d2
                lsl.l   d2,d3
                move.w  (a1)+,d3
                neg.w   d7
                lsl.l   d7,d3
                addi.w  #$B,d2
                move.l  d3,d7
                swap    d7
                bra.w   loc_2AAE
; ---------------------------------------------------------------------------
loc_2A9E:                                               ; CODE XREF: Gfx_ProcessTileData+1A   j
                moveq   #$10,d2
                rol.w   #5,d3
                move.w  d3,d7
                move.w  (a1)+,d3
                bra.w   loc_2AAE
; ---------------------------------------------------------------------------
loc_2AAA:                                               ; CODE XREF: Gfx_ProcessTileData+16   j
                rol.w   #5,d3
                move.w  d3,d7
loc_2AAE:                                               ; CODE XREF: Gfx_ProcessTileData+32   j
                                        ; Gfx_ProcessTileData+3E   j
                andi.w  #$1F,d7
                lsr.w   #1,d7
                bcs.w   loc_2AC6
                move.w  d7,d4
                move.w  d4,(a5)+
                move.w  d4,d5
                ori.w   #$8000,d5
                bra.w   loc_2B4C
; ---------------------------------------------------------------------------
loc_2AC6:                                               ; CODE XREF: Gfx_ProcessTileData+4C   j
                move.w  d7,d4
                move.w  d4,(a5)+
                move.w  d4,d5
                bset    #$F,d5
                moveq   #0,d6
loc_2AD2:                                               ; CODE XREF: Gfx_ProcessTileData+A6   j
                                        ; Gfx_ProcessTileData+D8   j
                subq.w  #2,d2
                bgt.w   loc_2AF8
                beq.w   loc_2AEC
                moveq   #$F,d2
                add.w   d3,d3
                move.w  (a1)+,d3
                addx.w  d3,d3
                move.w  d3,d7
                addx.w  d7,d7
                bra.w   loc_2AFC
; ---------------------------------------------------------------------------
loc_2AEC:                                               ; CODE XREF: Gfx_ProcessTileData+70   j
                moveq   #$10,d2
                rol.w   #2,d3
                move.w  d3,d7
                move.w  (a1)+,d3
                bra.w   loc_2AFC
; ---------------------------------------------------------------------------
loc_2AF8:                                               ; CODE XREF: Gfx_ProcessTileData+6C   j
                rol.w   #2,d3
                move.w  d3,d7
loc_2AFC:                                               ; CODE XREF: Gfx_ProcessTileData+80   j
                                        ; Gfx_ProcessTileData+8C   j
                andi.w  #3,d7
                beq.w   loc_2B10
                addq.w  #6,d7
                add.w   d7,d7
                add.w   d7,d6
                move.w  d5,-2(a5,d6.w)
                bra.s   loc_2AD2
; ---------------------------------------------------------------------------
loc_2B10:                                               ; CODE XREF: Gfx_ProcessTileData+98   j
                subq.w  #1,d2
                bne.w   loc_2B1E
                moveq   #$10,d2
                add.w   d3,d3
                move.w  (a1)+,d3
                roxr.w  #1,d3
loc_2B1E:                                               ; CODE XREF: Gfx_ProcessTileData+AA   j
                addx.w  d3,d3
                bcc.w   loc_2B4C
                subq.w  #1,d2
                bne.w   loc_2B32
                moveq   #$10,d2
                add.w   d3,d3
                move.w  (a1)+,d3
                roxr.w  #1,d3
loc_2B32:                                               ; CODE XREF: Gfx_ProcessTileData+BE   j
                addx.w  d3,d3
                bcs.w   loc_2B42
                addi.w  #$C,d6
                move.w  d5,-2(a5,d6.w)
                bra.s   loc_2AD2
; ---------------------------------------------------------------------------
loc_2B42:                                               ; CODE XREF: Gfx_ProcessTileData+CC   j
                addi.w  #$14,d6
                move.w  d5,-2(a5,d6.w)
                bra.s   loc_2AD2
; ---------------------------------------------------------------------------
loc_2B4C:                                               ; CODE XREF: Gfx_ProcessTileData+5A   j
                                        ; Gfx_ProcessTileData+B8   j
                moveq   #0,d7
                moveq   #1,d6
loc_2B50:                                               ; CODE XREF: Gfx_ProcessTileData+FC   j
                                        ; Gfx_ProcessTileData+106   j
                addq.w  #1,d7
                add.w   d6,d6
                subq.w  #1,d2
                bne.w   loc_2B6C
                moveq   #$10,d2
                add.w   d3,d3
                bcc.w   loc_2B66
                move.w  (a1)+,d3
                bra.s   loc_2B50
; ---------------------------------------------------------------------------
loc_2B66:                                               ; CODE XREF: Gfx_ProcessTileData+F6   j
                move.w  (a1)+,d3
                bra.w   loc_2B70
; ---------------------------------------------------------------------------
loc_2B6C:                                               ; CODE XREF: Gfx_ProcessTileData+EE   j
                add.w   d3,d3
                bcs.s   loc_2B50
loc_2B70:                                               ; CODE XREF: Gfx_ProcessTileData+100   j
                sub.w   d7,d2
                bgt.w   loc_2BA6
                beq.w   loc_2B96
                swap    d3
                clr.w   d3
                swap    d3
                add.w   d7,d2
                lsl.l   d2,d3
                move.w  (a1)+,d3
                sub.w   d2,d7
                lsl.l   d7,d3
                moveq   #$10,d2
                sub.w   d7,d2
                move.l  d3,d7
                swap    d7
                bra.w   loc_2BB0
; ---------------------------------------------------------------------------
loc_2B96:                                               ; CODE XREF: Gfx_ProcessTileData+10E   j
                moveq   #$10,d2
                swap    d3
                clr.w   d3
                rol.l   d7,d3
                move.w  d3,d7
                move.w  (a1)+,d3
                bra.w   loc_2BB0
; ---------------------------------------------------------------------------
loc_2BA6:                                               ; CODE XREF: Gfx_ProcessTileData+10A   j
                swap    d3
                clr.w   d3
                rol.l   d7,d3
                move.w  d3,d7
                swap    d3
loc_2BB0:                                               ; CODE XREF: Gfx_ProcessTileData+12A   j
                                        ; Gfx_ProcessTileData+13A   j
                add.w   d7,d6
                subq.w  #3,d6
                bcs.w   loc_2BC8
loc_2BB8:                                               ; CODE XREF: Gfx_ProcessTileData+15C   j
                move.w  (a5),d7
                bpl.w   loc_2BC2
                move.w  d7,d5
                move.b  d5,d4
loc_2BC2:                                               ; CODE XREF: Gfx_ProcessTileData+152   j
                move.w  d4,(a5)+
                dbf     d6,loc_2BB8
loc_2BC8:                                               ; CODE XREF: Gfx_ProcessTileData+14C   j
                cmpa.l  a4,a5
                bcs.w   loc_2A7C
                move.w  d2,(dword_FFF730).w
                move.w  d3,(dword_FFF730+2).w
                movem.l (sp)+,d2-d7/a4-a5
                rts
; End of function Gfx_ProcessTileData
; Packs 8 tile words into 4 longwords for output
Gfx_PackTileData:                                       ; CODE XREF: Gfx_LoadAndDecompTiles+22   p  ; was: sub_2BDC
                                        ; Gfx_DecompTilesToRAM+12   p
                lea     (dword_FFB400).w,a5
                moveq   #7,d6
loc_2BE2:                                               ; CODE XREF: Gfx_PackTileData+26   j
                move.w  (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                swap    d7
                move.w  (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                move.l  d7,(a2)+
                dbf     d6,loc_2BE2
                rts
; End of function Gfx_PackTileData
; Writes decoded tiles to VRAM via DMA by packing 8 tile words into longwords for VDP_DATA
Gfx_WriteTilesToVRAM:                                   ; CODE XREF: Gfx_LoadCompressedGfx+22   p  ; was: sub_2C08
                lea     (VDP_CTRL).l,a4
                move    sr,-(sp)
                move    #$2700,sr
                move.w  #$8F02,(a4)
                moveq   #0,d7
                move.l  a3,d6
                move.w  d6,d7
                lsl.l   #2,d7
                lsr.w   #2,d7
                ori.w   #$4000,d7
                swap    d7
                move.l  d7,(a4)
                lea     $20(a3),a3
                lea     (VDP_DATA).l,a4
                lea     (dword_FFB400).w,a5
                moveq   #7,d6
loc_2C3A:                                               ; CODE XREF: Gfx_WriteTilesToVRAM+52   j
                move.w  (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                swap    d7
                move.w  (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                lsl.w   #4,d7
                add.w   (a5)+,d7
                move.l  d7,(a4)
                dbf     d6,loc_2C3A
                move    (sp)+,sr
                rts
; End of function Gfx_WriteTilesToVRAM
; Executes DMA transfer with VDP register setup
Gfx_ExecuteDMATransfer:                                 ; CODE XREF: Gfx_DMATransferWithWait:Gfx_DMATransferWithWait_ExecuteBatch   p  ; was: sub_2C62
                                        ; Gfx_DecompTilesToVRAMBatched+3A   p
                move    sr,-(sp)
                move    #$2700,sr
                movea.w (word_FFF70C).w,a5
                move.w  a3,d7
                rol.w   #2,d7
                andi.w  #3,d7
                ori.w   #$80,d7
                move.w  d7,-(a5)
                move.w  a3,d7
                andi.w  #$3FFF,d7
                ori.w   #$4000,d7
                move.w  d7,-(a5)
                move.l  a2,d7
                andi.l  #$FFFFFF,d7
                lsr.l   #1,d7
                move.w  #$9500,d6
                move.b  d7,d6
                move.w  d6,-(a5)
                lsr.l   #8,d7
                move.w  #$9600,d6
                move.b  d7,d6
                move.w  d6,-(a5)
                lsr.l   #8,d7
                move.w  #$9700,d6
                move.b  d7,d6
                move.w  d6,-(a5)
                move.w  #$8F02,-(a5)
                move.w  d1,d7
                lsr.w   #1,d7
                move.w  #$9300,d6
                move.b  d7,d6
                move.w  d6,-(a5)
                lsr.w   #8,d7
                move.w  #$9400,d6
                move.b  d7,d6
                move.w  d6,-(a5)
                adda.w  d1,a2
                adda.w  d1,a3
                move.b  #1,(byte_FFF754).w
                move.w  a5,(word_FFF70C).w
                move    (sp)+,sr
                rts
; End of function Gfx_ExecuteDMATransfer
; Queues DMA transfer command from ROM data
Gfx_QueueDMAFromROM:
                movea.w (word_FFF70C).w,a1              ; was: sub_2CD8
                move.w  d0,-(sp)
                move.w  d0,d2
                rol.w   #2,d2
                andi.w  #3,d2
                ori.w   #$80,d2
                move.w  d2,-(a1)
                andi.w  #$3FFF,d0
                ori.w   #$4000,d0
                move.w  d0,-(a1)
                move.w  (a0)+,d1
                add.w   d1,(sp)
                move.l  a0,d0
                andi.l  #$FFFFFF,d0
                lsr.l   #1,d0
                move.w  #$9500,d2
                move.b  d0,d2
                move.w  d2,-(a1)
                lsr.l   #8,d0
                move.w  #$9600,d2
                move.b  d0,d2
                move.w  d2,-(a1)
                lsr.l   #8,d0
                move.w  #$9700,d2
                move.b  d0,d2
                move.w  d2,-(a1)
                move.w  #$8F02,-(a1)
                lsr.w   #1,d1
                move.w  #$9300,d2
                move.b  d1,d2
                move.w  d2,-(a1)
                lsr.w   #8,d1
                move.w  #$9400,d2
                move.b  d1,d2
                move.w  d2,-(a1)
                move.w  (sp)+,d0
                move.w  a1,(word_FFF70C).w
                rts
; End of function Gfx_QueueDMAFromROM
; Full game initialization with all subsystems
