Gfx_VBlankDMATransfer:                                  ; CODE XREF: Sys_VBlankHandler+1C   p  ; was: sub_D12
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_CTRL).l,a0
                move.w  (VDPReg1Shadow).w,d0
                bset    #4,d0
                move.w  d0,(a0)
                move.w  #$8F02,(a0)
                move.l  #$93409401,(a0)
                move.w  #$9500,(a0)
                move.w  #$96F0,(a0)
                move.w  #$977F,(a0)
                move.l  #$74000083,(VDPCommand).w       ; DO_WRITE_TO_VRAM_AT_$F400_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
                tst.b   (byte_FFF755).w
                bne.w   loc_D7E
                move.w  #$8F02,(a0)
                move.l  #$C0000000,(a0)
                lea     (VDP_DATA).l,a1
                move.w  (PaletteFillColor).w,d1
                move.w  d1,d0
                swap    d1
                move.w  d0,d1
                move.w  #$1F,d0
loc_D74:                                                ; CODE XREF: Gfx_VBlankDMATransfer+64   j
                move.l  d1,(a1)
                dbf     d0,loc_D74
                bra.w   loc_DA4
; ---------------------------------------------------------------------------
loc_D7E:                                                ; CODE XREF: Gfx_VBlankDMATransfer+40   j
                move.w  #$8F02,(a0)
                move.l  #$93409400,(a0)
                move.w  #$9580,(a0)
                move.w  #$96F1,(a0)
                move.w  #$977F,(a0)
                move.l  #$C0000080,(VDPCommand).w       ; DO_WRITE_TO_CRAM_AT_$0000_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
loc_DA4:                                                ; CODE XREF: Gfx_VBlankDMATransfer+68   j
                lea     (word_FFF400).w,a2
                movea.w (word_FFF70C).w,a3
                cmpa.w  a2,a3
                beq.w   loc_DC8
loc_DB2:                                                ; CODE XREF: Gfx_VBlankDMATransfer+AC   j
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.w  (a3)+,(a0)
                move.w  (a3)+,(a0)
                cmpa.w  a2,a3
                bne.s   loc_DB2
                move.w  a3,(word_FFF70C).w
                move.w  a3,(word_FFF70E).w
loc_DC8:                                                ; CODE XREF: Gfx_VBlankDMATransfer+9C   j
                move.w  #$8F02,(a0)
                btst    #1,(word_FFF7E6+1).w
                bne.s   loc_DDC
                move.l  #$93029400,(a0)
                bra.s   loc_DE2
; ---------------------------------------------------------------------------
loc_DDC:                                                ; CODE XREF: Gfx_VBlankDMATransfer+C0   j
                move.l  #$93C09401,(a0)
loc_DE2:                                                ; CODE XREF: Gfx_VBlankDMATransfer+C8   j
                move.w  #$9500,(a0)
                move.w  #$96F2,(a0)
                move.w  #$977F,(a0)
                move.l  #$70000083,(VDPCommand).w       ; DO_WRITE_TO_VRAM_AT_$F000_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
                move.w  #$8F02,(a0)
                btst    #2,(word_FFF7E6+1).w
                bne.s   loc_E12
                move.l  #$93029400,(a0)
                bra.s   loc_E18
; ---------------------------------------------------------------------------
loc_E12:                                                ; CODE XREF: Gfx_VBlankDMATransfer+F6   j
                move.l  #$93289400,(a0)
loc_E18:                                                ; CODE XREF: Gfx_VBlankDMATransfer+FE   j
                move.w  #$9500,(a0)
                move.w  #$96F6,(a0)
                move.w  #$977F,(a0)
                move.l  #$40000090,(VDPCommand).w       ; DO_WRITE_TO_VSRAM_AT_$0000_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
                movea.w #(dword_FF84A0-M68K_RAM),a3
                tst.w   (a3)
                beq.s   loc_E46
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.w  (a3)+,(a0)
                move.w  (a3)+,(a0)
loc_E46:                                                ; CODE XREF: Gfx_VBlankDMATransfer+128   j
                movea.w #(dword_FF8560-M68K_RAM),a3
                tst.w   (a3)
                beq.s   loc_E58
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.w  (a3)+,(a0)
                move.w  (a3)+,(a0)
loc_E58:                                                ; CODE XREF: Gfx_VBlankDMATransfer+13A   j
                movea.w #(dword_FF8500-M68K_RAM),a3
                tst.w   (a3)
                beq.s   loc_E6A
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.w  (a3)+,(a0)
                move.w  (a3)+,(a0)
loc_E6A:                                                ; CODE XREF: Gfx_VBlankDMATransfer+14C   j
                move.w  (word_FFA21E).w,d0
                beq.s   loc_E8A
                cmpi.w  #1,(word_FFA21E).w
                bne.s   loc_E8A
                clr.w   (word_FFA21E).w
                movea.w #(byte_FF8478-M68K_RAM),a3
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.w  (a3)+,(a0)
                move.w  (a3)+,(a0)
loc_E8A:                                                ; CODE XREF: Gfx_VBlankDMATransfer+15C   j
                                        ; Gfx_VBlankDMATransfer+164   j
                move.w  (VDPReg1Shadow).w,d0
                bclr    #4,d0
                move.w  d0,(a0)
                move    (sp)+,sr
                clr.b   (byte_FFF754).w
                rts
; End of function Gfx_VBlankDMATransfer
; Writes VDP register values from RAM buffer to hardware
Gfx_ApplyVDPSettings:                                   ; CODE XREF: Sys_VBlankHandler+20   p  ; was: sub_E9C
                lea     (VDP_CTRL).l,a0
                move.w  (VDPReg1Shadow).w,(a0)
                move.w  (word_FFF7D4).w,(a0)
                move.w  (word_FFF7D6).w,(a0)
                move.w  (word_FFF7D8).w,(a0)
                move.w  (word_FFF7DA).w,(a0)
                move.w  (VDPReg7Shadow).w,(a0)
                move.w  (word_FFF7E4).w,(a0)
                move.w  (word_FFF7E6).w,(a0)
                move.w  (word_FFF7E8).w,(a0)
                move.w  (word_FFF7EA).w,(a0)
                move.w  (word_FFF7EE).w,(a0)
                move.w  (word_FFF7F0).w,(a0)
                move.w  (word_FFF7F2).w,(a0)
                move.w  (word_FFF7F4).w,(a0)
                rts
; End of function Gfx_ApplyVDPSettings
; Updates VDP display register handling display enable flag
Gfx_UpdateVDPDisplay:                                   ; CODE XREF: VBLANK+48   p  ; was: sub_EDC
                move.w  (word_FFF7D0).w,d0
                tst.b   (byte_FFF755).w
                bne.w   loc_EEC
                bclr    #4,d0
loc_EEC:                                                ; CODE XREF: Gfx_UpdateVDPDisplay+8   j
                move.w  d0,(VDP_CTRL).l
                rts
; End of function Gfx_UpdateVDPDisplay
; Updates palette fade effect by adjusting RGB color components
