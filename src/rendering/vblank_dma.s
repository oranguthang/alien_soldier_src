; Runs the fixed sprite, palette, queued-command, and scroll transfers during VBlank
Gfx_RunVBlankTransfers:                                 ; CODE XREF: Sys_VBlankHandler+1C   p  ; was: sub_D12
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
                tst.b   (PaletteDMAHIntEnabled).w
                bne.w   Gfx_RunVBlankTransfers_UploadPalette
                move.w  #$8F02,(a0)
                move.l  #$C0000000,(a0)
                lea     (VDP_DATA).l,a1
                move.w  (PaletteFillColor).w,d1
                move.w  d1,d0
                swap    d1
                move.w  d0,d1
                move.w  #$1F,d0
Gfx_RunVBlankTransfers_FillCRAMLoop:                    ; CODE XREF: Gfx_RunVBlankTransfers+64   j  ; was: loc_D74
                move.l  d1,(a1)
                dbf     d0,Gfx_RunVBlankTransfers_FillCRAMLoop
                bra.w   Gfx_RunVBlankTransfers_FlushCommandQueue
; ---------------------------------------------------------------------------
Gfx_RunVBlankTransfers_UploadPalette:                   ; CODE XREF: Gfx_RunVBlankTransfers+40   j  ; was: loc_D7E
                move.w  #$8F02,(a0)
                move.l  #$93409400,(a0)
                move.w  #$9580,(a0)
                move.w  #$96F1,(a0)
                move.w  #$977F,(a0)
                move.l  #$C0000080,(VDPCommand).w       ; DO_WRITE_TO_CRAM_AT_$0000_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
Gfx_RunVBlankTransfers_FlushCommandQueue:               ; CODE XREF: Gfx_RunVBlankTransfers+68   j  ; was: loc_DA4
                lea     (word_FFF400).w,a2
                movea.w (VDPCommandQueueHead).w,a3
                cmpa.w  a2,a3
                beq.w   Gfx_RunVBlankTransfers_UploadHorizontalScroll
Gfx_RunVBlankTransfers_CommandLoop:                     ; CODE XREF: Gfx_RunVBlankTransfers+AC   j  ; was: loc_DB2
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.w  (a3)+,(a0)
                move.w  (a3)+,(a0)
                cmpa.w  a2,a3
                bne.s   Gfx_RunVBlankTransfers_CommandLoop
                move.w  a3,(VDPCommandQueueHead).w
                move.w  a3,(VDPStagingDataCursor).w
Gfx_RunVBlankTransfers_UploadHorizontalScroll:          ; CODE XREF: Gfx_RunVBlankTransfers+9C   j  ; was: loc_DC8
                move.w  #$8F02,(a0)
                btst    #1,(VDPReg11Shadow+1).w
                bne.s   Gfx_RunVBlankTransfers_UsePerLineHScrollLength
                move.l  #$93029400,(a0)
                bra.s   Gfx_RunVBlankTransfers_StartHorizontalScrollDMA
; ---------------------------------------------------------------------------
Gfx_RunVBlankTransfers_UsePerLineHScrollLength:         ; CODE XREF: Gfx_RunVBlankTransfers+C0   j  ; was: loc_DDC
                move.l  #$93C09401,(a0)
Gfx_RunVBlankTransfers_StartHorizontalScrollDMA:        ; CODE XREF: Gfx_RunVBlankTransfers+C8   j  ; was: loc_DE2
                move.w  #$9500,(a0)
                move.w  #$96F2,(a0)
                move.w  #$977F,(a0)
                move.l  #$70000083,(VDPCommand).w       ; DO_WRITE_TO_VRAM_AT_$F000_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
                move.w  #$8F02,(a0)
                btst    #2,(VDPReg11Shadow+1).w
                bne.s   Gfx_RunVBlankTransfers_UsePerColumnVScrollLength
                move.l  #$93029400,(a0)
                bra.s   Gfx_RunVBlankTransfers_StartVerticalScrollDMA
; ---------------------------------------------------------------------------
Gfx_RunVBlankTransfers_UsePerColumnVScrollLength:       ; CODE XREF: Gfx_RunVBlankTransfers+F6   j  ; was: loc_E12
                move.l  #$93289400,(a0)
Gfx_RunVBlankTransfers_StartVerticalScrollDMA:          ; CODE XREF: Gfx_RunVBlankTransfers+FE   j  ; was: loc_E18
                move.w  #$9500,(a0)
                move.w  #$96F6,(a0)
                move.w  #$977F,(a0)
                move.l  #$40000090,(VDPCommand).w       ; DO_WRITE_TO_VSRAM_AT_$0000_ADDR
                                        ; DO_OPERATION_USING_DMA
                move.w  (VDPCommand).w,(a0)
                move.w  (VDPCommand+2).w,(a0)
                movea.w #(dword_FF84A0-M68K_RAM),a3
                tst.w   (a3)
                beq.s   Gfx_RunVBlankTransfers_CheckOptionalCommandBlock2
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.w  (a3)+,(a0)
                move.w  (a3)+,(a0)
Gfx_RunVBlankTransfers_CheckOptionalCommandBlock2:      ; CODE XREF: Gfx_RunVBlankTransfers+128   j  ; was: loc_E46
                movea.w #(dword_FF8560-M68K_RAM),a3
                tst.w   (a3)
                beq.s   Gfx_RunVBlankTransfers_CheckOptionalCommandBlock3
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.w  (a3)+,(a0)
                move.w  (a3)+,(a0)
Gfx_RunVBlankTransfers_CheckOptionalCommandBlock3:      ; CODE XREF: Gfx_RunVBlankTransfers+13A   j  ; was: loc_E58
                movea.w #(dword_FF8500-M68K_RAM),a3
                tst.w   (a3)
                beq.s   Gfx_RunVBlankTransfers_CheckConditionalCommandBlock
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.w  (a3)+,(a0)
                move.w  (a3)+,(a0)
Gfx_RunVBlankTransfers_CheckConditionalCommandBlock:    ; CODE XREF: Gfx_RunVBlankTransfers+14C   j  ; was: loc_E6A
                move.w  (word_FFA21E).w,d0
                beq.s   Gfx_RunVBlankTransfers_Finish
                cmpi.w  #1,(word_FFA21E).w
                bne.s   Gfx_RunVBlankTransfers_Finish
                clr.w   (word_FFA21E).w
                movea.w #(byte_FF8478-M68K_RAM),a3
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.l  (a3)+,(a0)
                move.w  (a3)+,(a0)
                move.w  (a3)+,(a0)
Gfx_RunVBlankTransfers_Finish:                          ; CODE XREF: Gfx_RunVBlankTransfers+15C   j  ; was: loc_E8A
                                        ; Gfx_RunVBlankTransfers+164   j
                move.w  (VDPReg1Shadow).w,d0
                bclr    #4,d0
                move.w  d0,(a0)
                move    (sp)+,sr
                clr.b   (VDPTransferPending).w
                rts
; End of function Gfx_RunVBlankTransfers
; Writes the persistent register-command shadows used by the frame renderer
Gfx_ApplyVDPRegisterShadows:                            ; CODE XREF: Sys_VBlankHandler+20   p  ; was: sub_E9C
                lea     (VDP_CTRL).l,a0
                move.w  (VDPReg1Shadow).w,(a0)
                move.w  (VDPReg2Shadow).w,(a0)
                move.w  (VDPReg3Shadow).w,(a0)
                move.w  (VDPReg4Shadow).w,(a0)
                move.w  (VDPReg5Shadow).w,(a0)
                move.w  (VDPReg7Shadow).w,(a0)
                move.w  (VDPReg10Shadow).w,(a0)
                move.w  (VDPReg11Shadow).w,(a0)
                move.w  (VDPReg12Shadow).w,(a0)
                move.w  (VDPReg13Shadow).w,(a0)
                move.w  (VDPReg15Shadow).w,(a0)
                move.w  (VDPReg16Shadow).w,(a0)
                move.w  (VDPReg17Shadow).w,(a0)
                move.w  (VDPReg18Shadow).w,(a0)
                rts
; End of function Gfx_ApplyVDPRegisterShadows
; Applies the register 0 shadow, suppressing horizontal interrupts while palette DMA is disabled
Gfx_ApplyHInterruptState:                               ; CODE XREF: VBLANK+48   p  ; was: sub_EDC
                move.w  (VDPReg0Shadow).w,d0
                tst.b   (PaletteDMAHIntEnabled).w
                bne.w   Gfx_ApplyHInterruptState_WriteReg0
                bclr    #4,d0
Gfx_ApplyHInterruptState_WriteReg0:                     ; CODE XREF: Gfx_ApplyHInterruptState+8   j  ; was: loc_EEC
                move.w  d0,(VDP_CTRL).l
                rts
; End of function Gfx_ApplyHInterruptState
