Gfx_QueueDMAClear:
                clr.b   d3                              ; was: sub_1D32
                bra.s   loc_1D3A
; End of function Gfx_QueueDMAClear
; Queues DMA commands with tile data processing and transfer
Gfx_QueueDMATileData:
                move.b  #1,d3                           ; was: sub_1D36
loc_1D3A:                                               ; CODE XREF: Gfx_QueueDMAClear+2   j
                movea.w (word_FFF70C).w,a1
                movea.w (word_FFF70E).w,a2
loc_1D42:                                               ; CODE XREF: Gfx_QueueDMATileData+66   j
                                        ; Gfx_QueueDMATileData+6A   j
                move.w  (a0)+,d0
                move.l  (a0)+,-(a1)
                move.l  a2,d1
                andi.l  #$FFFFFF,d1
                lsr.l   #1,d1
                move.w  #$9500,d2
                move.b  d1,d2
                move.w  d2,-(a1)
                lsr.l   #8,d1
                move.w  #$9600,d2
                move.b  d1,d2
                move.w  d2,-(a1)
                lsr.l   #8,d1
                move.w  #$9700,d2
                move.b  d1,d2
                move.w  d2,-(a1)
                move.w  #$8F02,-(a1)
                move.l  #$94009300,d1
loc_1D76:                                               ; CODE XREF: Gfx_QueueDMATileData+56   j
                                        ; Gfx_QueueDMATileData+5C   j
                move.b  (a0)+,d0
                cmpi.b  #$FE,d0
                beq.s   loc_1D94
                cmpi.b  #$FF,d0
                beq.s   loc_1DA2
                tst.b   d3
                beq.s   loc_1D8E
                move.w  d0,(a2)+
                addq.b  #1,d1
                bra.s   loc_1D76
; ---------------------------------------------------------------------------
loc_1D8E:                                               ; CODE XREF: Gfx_QueueDMATileData+50   j
                clr.w   (a2)+
                addq.b  #1,d1
                bra.s   loc_1D76
; ---------------------------------------------------------------------------
loc_1D94:                                               ; CODE XREF: Gfx_QueueDMATileData+46   j
                move.l  d1,-(a1)
                move.w  a0,d2
                btst    #0,d2
                beq.s   loc_1D42
                addq.l  #1,a0
                bra.s   loc_1D42
; ---------------------------------------------------------------------------
loc_1DA2:                                               ; CODE XREF: Gfx_QueueDMATileData+4C   j
                move.l  d1,-(a1)
                move.w  a1,(word_FFF70C).w
                move.w  a2,(word_FFF70E).w
                rts
; End of function Gfx_QueueDMATileData
; Queues DMA commands for pattern/tile data with alternate format
Gfx_QueueDMAPattern:
                clr.b   d3                              ; was: sub_1DAE
                bra.s   loc_1DB6
; ---------------------------------------------------------------------------
                move.b  #1,d3
loc_1DB6:                                               ; CODE XREF: Gfx_QueueDMAPattern+2   j
                movea.w (word_FFF70C).w,a1
                movea.w (word_FFF70E).w,a2
loc_1DBE:                                               ; CODE XREF: Gfx_QueueDMAPattern+68   j
                                        ; Gfx_QueueDMAPattern+6C   j
                move.l  (a0)+,-(a1)
                move.l  a2,d1
                andi.l  #$FFFFFF,d1
                lsr.l   #1,d1
                move.w  #$9500,d2
                move.b  d1,d2
                move.w  d2,-(a1)
                lsr.l   #8,d1
                move.w  #$9600,d2
                move.b  d1,d2
                move.w  d2,-(a1)
                lsr.l   #8,d1
                move.w  #$9700,d2
                move.b  d1,d2
                move.w  d2,-(a1)
                move.w  #$8F02,-(a1)
                move.l  #$94009300,d1
loc_1DF0:                                               ; CODE XREF: Gfx_QueueDMAPattern+58   j
                                        ; Gfx_QueueDMAPattern+5E   j
                move.b  (a0)+,d0
                cmpi.b  #$FE,d0
                beq.s   loc_1E0E
                cmpi.b  #$FF,d0
                beq.s   loc_1E1C
                tst.b   d3
                beq.s   loc_1E08
                move.w  d0,(a2)+
                addq.b  #1,d1
                bra.s   loc_1DF0
; ---------------------------------------------------------------------------
loc_1E08:                                               ; CODE XREF: Gfx_QueueDMAPattern+52   j
                clr.w   (a2)+
                addq.b  #1,d1
                bra.s   loc_1DF0
; ---------------------------------------------------------------------------
loc_1E0E:                                               ; CODE XREF: Gfx_QueueDMAPattern+48   j
                move.l  d1,-(a1)
                move.w  a0,d2
                btst    #0,d2
                beq.s   loc_1DBE
                addq.l  #1,a0
                bra.s   loc_1DBE
; ---------------------------------------------------------------------------
loc_1E1C:                                               ; CODE XREF: Gfx_QueueDMAPattern+4E   j
                move.l  d1,-(a1)
                move.w  a1,(word_FFF70C).w
                move.w  a2,(word_FFF70E).w
                rts
; End of function Gfx_QueueDMAPattern
; Converts number to ASCII digits and queues DMA for text display
Gfx_QueueNumberDisplay:
                movea.w (word_FFF70C).w,a1              ; was: sub_1E28
                movea.w (word_FFF70E).w,a2
                move.l  d2,-(a1)
                move.l  a2,d4
                andi.l  #$FFFFFF,d4
                lsr.l   #1,d4
                move.w  #$9500,d2
                move.b  d4,d2
                move.w  d2,-(a1)
                lsr.l   #8,d4
                move.w  #$9600,d2
                move.b  d4,d2
                move.w  d2,-(a1)
                lsr.l   #8,d4
                move.w  #$9700,d2
                move.b  d4,d2
                move.w  d2,-(a1)
                move.w  d3,d2
                bne.w   loc_1E6E
                moveq   #5,d3
                move.w  #8,d2
                andi.l  #$FFFF,d1
                bra.w   loc_1E7C
; ---------------------------------------------------------------------------
loc_1E6E:                                               ; CODE XREF: Gfx_QueueNumberDisplay+32   j
                subq.w  #1,d2
                asl.w   #1,d2
                andi.l  #$FFFF,d1
                bra.w   loc_1E94
; ---------------------------------------------------------------------------
loc_1E7C:                                               ; CODE XREF: Gfx_QueueNumberDisplay+42   j
                                        ; Gfx_QueueNumberDisplay+66   j
                divu.w  Gfx_QueueBCDDisplay(pc,d2.w),d1
                bne.w   loc_1E98
                move.b  #$B4,d0
                move.w  d0,(a2)+
                swap    d1
                subq.w  #2,d2
                bpl.s   loc_1E7C
                bra.w   loc_1EA8
; ---------------------------------------------------------------------------
loc_1E94:                                               ; CODE XREF: Gfx_QueueNumberDisplay+50   j
                                        ; Gfx_QueueNumberDisplay+7E   j
                divu.w  Gfx_QueueBCDDisplay(pc,d2.w),d1
loc_1E98:                                               ; CODE XREF: Gfx_QueueNumberDisplay+58   j
                addi.b  #-$4B,d1
                move.b  d1,d0
                move.w  d0,(a2)+
                clr.w   d1
                swap    d1
                subq.w  #2,d2
                bpl.s   loc_1E94
loc_1EA8:                                               ; CODE XREF: Gfx_QueueNumberDisplay+68   j
                move.w  #$8F02,-(a1)
                move.l  #$94009300,d2
                add.b   d3,d2
                move.l  d2,-(a1)
                move.w  a1,(word_FFF70C).w
                move.w  a2,(word_FFF70E).w
                rts
; End of function Gfx_QueueNumberDisplay
; Converts number to BCD/ASCII with leading zeros for score display
Gfx_QueueBCDDisplay:
                ori.b   #$A,d1                          ; was: sub_1EC0
                ori.w   #$3E8,-(a4)
                move.l  (a0),-(a3)
                movea.w (word_FFF70C).w,a1
                movea.w (word_FFF70E).w,a2
                move.l  d2,-(a1)
                move.l  a2,d4
                andi.l  #$FFFFFF,d4
                lsr.l   #1,d4
                move.w  #$9500,d2
                move.b  d4,d2
                move.w  d2,-(a1)
                lsr.l   #8,d4
                move.w  #$9600,d2
                move.b  d4,d2
                move.w  d2,-(a1)
                lsr.l   #8,d4
                move.w  #$9700,d2
                move.b  d4,d2
                move.w  d2,-(a1)
                move.w  d3,d2
                bne.w   loc_1F10
                moveq   #5,d3
                move.w  #8,d2
                andi.l  #$FFFF,d1
                bra.w   loc_1F1E
; ---------------------------------------------------------------------------
loc_1F10:                                               ; CODE XREF: Gfx_QueueBCDDisplay+3C   j
                subq.w  #1,d2
                asl.w   #1,d2
                andi.l  #$FFFF,d1
                bra.w   loc_1F36
; ---------------------------------------------------------------------------
loc_1F1E:                                               ; CODE XREF: Gfx_QueueBCDDisplay+4C   j
                                        ; Gfx_QueueBCDDisplay+70   j
                divu.w  word_1F62(pc,d2.w),d1
                bne.w   loc_1F3A
                move.b  #$B4,d0
                move.w  d0,(a2)+
                swap    d1
                subq.w  #2,d2
                bpl.s   loc_1F1E
                bra.w   loc_1F4A
; ---------------------------------------------------------------------------
loc_1F36:                                               ; CODE XREF: Gfx_QueueBCDDisplay+5A   j
                                        ; Gfx_QueueBCDDisplay+88   j
                divu.w  word_1F62(pc,d2.w),d1
loc_1F3A:                                               ; CODE XREF: Gfx_QueueBCDDisplay+62   j
                addi.b  #-$4B,d1
                move.b  d1,d0
                move.w  d0,(a2)+
                clr.w   d1
                swap    d1
                subq.w  #2,d2
                bpl.s   loc_1F36
loc_1F4A:                                               ; CODE XREF: Gfx_QueueBCDDisplay+72   j
                move.w  #$8F02,-(a1)
                move.l  #$94009300,d2
                add.b   d3,d2
                move.l  d2,-(a1)
                move.w  a1,(word_FFF70C).w
                move.w  a2,(word_FFF70E).w
                rts
; End of function Gfx_QueueBCDDisplay
; ---------------------------------------------------------------------------
word_1F62:      dc.w    1, $10, $100, $1000

; Configures VDP DMA registers for data transfer
Gfx_SetupDMATransfer:                                   ; CODE XREF: Sprite_RenderDynamicObject+50   p  ; was: sub_1F6A
                                        ; Sprite_RenderDynamicObjectWithEntryAttributes+62   p
                move.w  (a1)+,d1
                move.w  d0,d7
                rol.w   #2,d7
                andi.w  #3,d7
                ori.w   #$80,d7
                move.w  d7,-(a0)
                move.w  d0,d7
                andi.w  #$3FFF,d7
                ori.w   #$4000,d7
                move.w  d7,-(a0)
                add.w   d1,d0
                lsr.w   #1,d1
                move.w  #$9300,d7
                move.b  d1,d7
                move.w  d7,-(a0)
                lsr.w   #8,d1
                move.w  #$9400,d7
                move.b  d1,d7
                move.w  d7,-(a0)
                move.w  #$8F02,-(a0)
                move.l  a1,d1
                andi.l  #$FFFFFF,d1
                lsr.l   #1,d1
                move.w  #$9500,d7
                move.b  d1,d7
                move.w  d7,-(a0)
                lsr.l   #8,d1
                move.w  #$9600,d7
                move.b  d1,d7
                move.w  d7,-(a0)
                lsr.l   #8,d1
                move.w  #$9700,d7
                move.b  d1,d7
                move.w  d7,-(a0)
                rts
; End of function Gfx_SetupDMATransfer
; Loads four palette blocks from pointers into the active and shadow buffers
Gfx_LoadFourPalettes:                                   ; CODE XREF: UI_WeaponSelectTransition+3C   p  ; was: sub_1FC8
                lea     (PaletteActiveBuffer).w,a2
                lea     (PaletteShadowBuffer).w,a3
                bsr.w   Gfx_CopyPaletteBlock
                bsr.w   Gfx_CopyPaletteBlock
                bsr.w   Gfx_CopyPaletteBlock
                bsr.w   Gfx_CopyPaletteBlock
                rts
; End of function Gfx_LoadFourPalettes
; Copies 32-byte palette block from pointer to dual buffers
Gfx_CopyPaletteBlock:                                   ; CODE XREF: Gfx_LoadFourPalettes+8   p  ; was: sub_1FE2
                                        ; Gfx_LoadFourPalettes+C   p
                move.l  (a0)+,d0
                beq.w   loc_200C
                movea.l d0,a1
                move.l  (a1),(a2)+
                move.l  (a1)+,(a3)+
                move.l  (a1),(a2)+
                move.l  (a1)+,(a3)+
                move.l  (a1),(a2)+
                move.l  (a1)+,(a3)+
                move.l  (a1),(a2)+
                move.l  (a1)+,(a3)+
                move.l  (a1),(a2)+
                move.l  (a1)+,(a3)+
                move.l  (a1),(a2)+
                move.l  (a1)+,(a3)+
                move.l  (a1),(a2)+
                move.l  (a1)+,(a3)+
                move.l  (a1),(a2)+
                move.l  (a1)+,(a3)+
                rts
; ---------------------------------------------------------------------------
loc_200C:                                               ; CODE XREF: Gfx_CopyPaletteBlock+2   j
                lea     $20(a2),a2
                lea     $20(a3),a3
                rts
; End of function Gfx_CopyPaletteBlock
; Main object processing loop - iterates through active objects
