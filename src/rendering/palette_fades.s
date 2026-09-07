Effect_UpdatePaletteFade:
                tst.b   (byte_FFF705).w  ; was: sub_EF4
                bpl.w   loc_EFE
                rts
; ---------------------------------------------------------------------------
loc_EFE:                                ; CODE XREF: Effect_UpdatePaletteFade+4   j
                tst.w   (word_FFFF28).w
                bne.w   loc_1094
                move.w  (word_FFF75C).w,d0
                bmi.w   loc_F14
                bne.w   loc_F8A
                rts
; ---------------------------------------------------------------------------
loc_F14:                                ; CODE XREF: Effect_UpdatePaletteFade+16   j
                add.w   d0,(word_FFF75E).w
                bpl.w   loc_F20
                clr.w   (word_FFF75E).w
loc_F20:                                ; CODE XREF: Effect_UpdatePaletteFade+24   j
                lea     (word_FFE300).w,a0
                lea     (word_FFE380).w,a1
                move.b  (word_FFF75E).w,d5
                andi.w  #$FF,d5
                move.w  d5,d6
                lsl.w   #4,d6
                move.w  d6,d7
                lsl.w   #4,d7
                move.w  #$3F,d1 ; '?'
loc_F3C:                                ; CODE XREF: Effect_UpdatePaletteFade+84   j
                move.w  (a1)+,d2
                move.w  d2,d3
                move.w  d2,d4
                andi.w  #$F,d2
                beq.w   loc_F52
                sub.w   d5,d2
                bpl.w   loc_F52
                clr.w   d2
loc_F52:                                ; CODE XREF: Effect_UpdatePaletteFade+52   j
                                        ; Effect_UpdatePaletteFade+58   j
                andi.w  #$F0,d3
                beq.w   loc_F62
                sub.w   d6,d3
                bpl.w   loc_F62
                clr.w   d3
loc_F62:                                ; CODE XREF: Effect_UpdatePaletteFade+62   j
                                        ; Effect_UpdatePaletteFade+68   j
                andi.w  #$F00,d4
                beq.w   loc_F72
                sub.w   d7,d4
                bpl.w   loc_F72
                clr.w   d4
loc_F72:                                ; CODE XREF: Effect_UpdatePaletteFade+72   j
                                        ; Effect_UpdatePaletteFade+78   j
                or.w    d3,d2
                or.w    d4,d2
                move.w  d2,(a0)+
                dbf     d1,loc_F3C
                tst.w   (word_FFF75E).w
                bne.w   locret_F88
                clr.w   (word_FFF75C).w
locret_F88:                             ; CODE XREF: Effect_UpdatePaletteFade+8C   j
                rts
; ---------------------------------------------------------------------------
loc_F8A:                                ; CODE XREF: Effect_UpdatePaletteFade+1A   j
                tst.w   (word_FFF75E).w
                bne.w   loc_1014
                add.w   d0,(word_FFF75E).w
                lea     (word_FFE300).w,a0
                lea     (word_FFE380).w,a1
                move.b  (word_FFF75E).w,d5
                andi.w  #$FF,d5
                move.w  d5,d6
                lsl.w   #4,d6
                move.w  d6,d7
                lsl.w   #4,d7
                move.w  #$3F,d1 ; '?'
loc_FB2:                                ; CODE XREF: Effect_UpdatePaletteFade+FC   j
                move.w  (a0),d2
                move.w  d2,d3
                move.w  d2,d4
                andi.w  #$F,d2
                beq.w   loc_FC8
                sub.w   d5,d2
                bpl.w   loc_FC8
                clr.w   d2
loc_FC8:                                ; CODE XREF: Effect_UpdatePaletteFade+C8   j
                                        ; Effect_UpdatePaletteFade+CE   j
                andi.w  #$F0,d3
                beq.w   loc_FD8
                sub.w   d6,d3
                bpl.w   loc_FD8
                clr.w   d3
loc_FD8:                                ; CODE XREF: Effect_UpdatePaletteFade+D8   j
                                        ; Effect_UpdatePaletteFade+DE   j
                andi.w  #$F00,d4
                beq.w   loc_FE8
                sub.w   d7,d4
                bpl.w   loc_FE8
                clr.w   d4
loc_FE8:                                ; CODE XREF: Effect_UpdatePaletteFade+E8   j
                                        ; Effect_UpdatePaletteFade+EE   j
                or.w    d3,d2
                or.w    d4,d2
                move.w  d2,(a0)+
                move.w  d2,(a1)+
                dbf     d1,loc_FB2
                cmpi.w  #$1000,(word_FFF75E).w
                blt.w   locret_1012
                move.w  #$1000,(word_FFF75E).w
                clr.w   (word_FFF75C).w
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
locret_1012:                            ; CODE XREF: Effect_UpdatePaletteFade+106   j
                rts
; ---------------------------------------------------------------------------
loc_1014:                               ; CODE XREF: Effect_UpdatePaletteFade+9A   j
                add.w   d0,(word_FFF75E).w
                lea     (word_FFE300).w,a0
                lea     (word_FFE380).w,a1
                move.b  (word_FFF75E).w,d5
                andi.w  #$FF,d5
                move.w  d5,d6
                lsl.w   #4,d6
                move.w  d6,d7
                lsl.w   #4,d7
                move.w  #$3F,d1 ; '?'
loc_1034:                               ; CODE XREF: Effect_UpdatePaletteFade+17C   j
                move.w  (a1)+,d2
                move.w  d2,d3
                move.w  d2,d4
                andi.w  #$F,d2
                beq.w   loc_104A
                sub.w   d5,d2
                bpl.w   loc_104A
                clr.w   d2
loc_104A:                               ; CODE XREF: Effect_UpdatePaletteFade+14A   j
                                        ; Effect_UpdatePaletteFade+150   j
                andi.w  #$F0,d3
                beq.w   loc_105A
                sub.w   d6,d3
                bpl.w   loc_105A
                clr.w   d3
loc_105A:                               ; CODE XREF: Effect_UpdatePaletteFade+15A   j
                                        ; Effect_UpdatePaletteFade+160   j
                andi.w  #$F00,d4
                beq.w   loc_106A
                sub.w   d7,d4
                bpl.w   loc_106A
                clr.w   d4
loc_106A:                               ; CODE XREF: Effect_UpdatePaletteFade+16A   j
                                        ; Effect_UpdatePaletteFade+170   j
                or.w    d3,d2
                or.w    d4,d2
                move.w  d2,(a0)+
                dbf     d1,loc_1034
                cmpi.w  #$1000,(word_FFF75E).w
                blt.w   locret_1092
                move.w  #$1000,(word_FFF75E).w
                clr.w   (word_FFF75C).w
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
locret_1092:                            ; CODE XREF: Effect_UpdatePaletteFade+186   j
                rts
; ---------------------------------------------------------------------------
loc_1094:                               ; CODE XREF: Effect_UpdatePaletteFade+E   j
                move.w  (word_FFF75C).w,d0
                bmi.w   loc_10A2
                bne.w   loc_111E
                rts
; ---------------------------------------------------------------------------
loc_10A2:                               ; CODE XREF: Effect_UpdatePaletteFade+1A4   j
                add.w   d0,(word_FFF75E).w
                bpl.w   loc_10AE
                clr.w   (word_FFF75E).w
loc_10AE:                               ; CODE XREF: Effect_UpdatePaletteFade+1B2   j
                lea     (word_FFE300).w,a0
                lea     (word_FFE380).w,a1
                move.b  (word_FFF75E).w,d5
                andi.w  #$FF,d5
                move.w  d5,d6
                lsl.w   #4,d6
                move.w  d6,d7
                lsl.w   #4,d7
                move.w  #$3F,d1 ; '?'
loc_10CA:                               ; CODE XREF: Effect_UpdatePaletteFade+218   j
                move.w  (a1)+,d2
                move.w  d2,d3
                move.w  d2,d4
                andi.w  #$F,d2
                andi.w  #$F0,d3
                andi.w  #$F00,d4
                add.w   d5,d2
                cmpi.w  #$F,d2
                bls.w   loc_10EA
                move.w  #$F,d2
loc_10EA:                               ; CODE XREF: Effect_UpdatePaletteFade+1EE   j
                add.w   d6,d3
                cmpi.w  #$F0,d3
                bls.w   loc_10F8
                move.w  #$F0,d3
loc_10F8:                               ; CODE XREF: Effect_UpdatePaletteFade+1FC   j
                add.w   d7,d4
                cmpi.w  #$F00,d4
                bls.w   loc_1106
                move.w  #$F00,d4
loc_1106:                               ; CODE XREF: Effect_UpdatePaletteFade+20A   j
                or.w    d3,d2
                or.w    d4,d2
                move.w  d2,(a0)+
                dbf     d1,loc_10CA
                tst.w   (word_FFF75E).w
                bne.w   locret_111C
                clr.w   (word_FFF75C).w
locret_111C:                            ; CODE XREF: Effect_UpdatePaletteFade+220   j
                rts
; ---------------------------------------------------------------------------
loc_111E:                               ; CODE XREF: Effect_UpdatePaletteFade+1A8   j
                tst.w   (word_FFF75E).w
                bne.w   loc_11AE
                add.w   d0,(word_FFF75E).w
                lea     (word_FFE300).w,a0
                lea     (word_FFE380).w,a1
                move.b  (word_FFF75E).w,d5
                andi.w  #$FF,d5
                move.w  d5,d6
                lsl.w   #4,d6
                move.w  d6,d7
                lsl.w   #4,d7
                move.w  #$3F,d1 ; '?'
loc_1146:                               ; CODE XREF: Effect_UpdatePaletteFade+296   j
                move.w  (a0),d2
                move.w  d2,d3
                move.w  d2,d4
                andi.w  #$F,d2
                andi.w  #$F0,d3
                andi.w  #$F00,d4
                add.w   d5,d2
                cmpi.w  #$F,d2
                bls.w   loc_1166
                move.w  #$F,d2
loc_1166:                               ; CODE XREF: Effect_UpdatePaletteFade+26A   j
                add.w   d6,d3
                cmpi.w  #$F0,d3
                bls.w   loc_1174
                move.w  #$F0,d3
loc_1174:                               ; CODE XREF: Effect_UpdatePaletteFade+278   j
                add.w   d7,d4
                cmpi.w  #$F00,d4
                bls.w   loc_1182
                move.w  #$F00,d4
loc_1182:                               ; CODE XREF: Effect_UpdatePaletteFade+286   j
                or.w    d3,d2
                or.w    d4,d2
                move.w  d2,(a0)+
                move.w  d2,(a1)+
                dbf     d1,loc_1146
                cmpi.w  #$1000,(word_FFF75E).w
                blt.w   locret_11AC
                move.w  #$1000,(word_FFF75E).w
                clr.w   (word_FFF75C).w
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
locret_11AC:                            ; CODE XREF: Effect_UpdatePaletteFade+2A0   j
                rts
; ---------------------------------------------------------------------------
loc_11AE:                               ; CODE XREF: Effect_UpdatePaletteFade+22E   j
                add.w   d0,(word_FFF75E).w
                lea     (word_FFE300).w,a0
                lea     (word_FFE380).w,a1
                move.b  (word_FFF75E).w,d5
                andi.w  #$FF,d5
                move.w  d5,d6
                lsl.w   #4,d6
                move.w  d6,d7
                lsl.w   #4,d7
                move.w  #$3F,d1 ; '?'
loc_11CE:                               ; CODE XREF: Effect_UpdatePaletteFade+31C   j
                move.w  (a1)+,d2
                move.w  d2,d3
                move.w  d2,d4
                andi.w  #$F,d2
                andi.w  #$F0,d3
                andi.w  #$F00,d4
                add.w   d5,d2
                cmpi.w  #$F,d2
                bls.w   loc_11EE
                move.w  #$F,d2
loc_11EE:                               ; CODE XREF: Effect_UpdatePaletteFade+2F2   j
                add.w   d6,d3
                cmpi.w  #$F0,d3
                bls.w   loc_11FC
                move.w  #$F0,d3
loc_11FC:                               ; CODE XREF: Effect_UpdatePaletteFade+300   j
                add.w   d7,d4
                cmpi.w  #$F00,d4
                bls.w   loc_120A
                move.w  #$F00,d4
loc_120A:                               ; CODE XREF: Effect_UpdatePaletteFade+30E   j
                or.w    d3,d2
                or.w    d4,d2
                move.w  d2,(a0)+
                dbf     d1,loc_11CE
                cmpi.w  #$1000,(word_FFF75E).w
                blt.w   locret_1232
                move.w  #$1000,(word_FFF75E).w
                clr.w   (word_FFF75C).w
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
locret_1232:                            ; CODE XREF: Effect_UpdatePaletteFade+326   j
                rts
; End of function Effect_UpdatePaletteFade
; Queues DMA transfer command for Plane B VRAM update
Gfx_QueueDMAPlaneBTransfer:
                movea.w (word_FFF70C).w,a0  ; was: sub_1234
                move.l  #$70000083,-(a0)
                move.l  (dword_FFF710).w,d0
                andi.l  #$FFFFFF,d0
                lsr.l   #1,d0
                move.w  #$9500,d1
                move.b  d0,d1
                move.w  d1,-(a0)
                lsr.l   #8,d0
                move.w  #$9600,d1
                move.b  d0,d1
                move.w  d1,-(a0)
                lsr.l   #8,d0
                move.w  #$9700,d1
                move.b  d0,d1
                move.w  d1,-(a0)
                move.w  #$8F02,-(a0)
                btst    #1,(word_FFF7E6+1).w
                bne.w   loc_127E
                move.l  #$94009302,-(a0)
                bra.w   loc_1284
; ---------------------------------------------------------------------------
loc_127E:                               ; CODE XREF: Gfx_QueueDMAPlaneBTransfer+3C   j
                move.l  #$940193C0,-(a0)
loc_1284:                               ; CODE XREF: Gfx_QueueDMAPlaneBTransfer+46   j
                move.w  a0,(word_FFF70C).w
                rts
; End of function Gfx_QueueDMAPlaneBTransfer
; Queues DMA transfer command for Plane A VRAM update
Gfx_QueueDMAPlaneATransfer:
                movea.w (word_FFF70C).w,a0  ; was: sub_128A
                move.l  #$40000090,-(a0)
                move.l  (dword_FFF714).w,d0
                andi.l  #$FFFFFF,d0
                lsr.l   #1,d0
                move.w  #$9500,d1
                move.b  d0,d1
                move.w  d1,-(a0)
                lsr.l   #8,d0
                move.w  #$9600,d1
                move.b  d0,d1
                move.w  d1,-(a0)
                lsr.l   #8,d0
                move.w  #$9700,d1
                move.b  d0,d1
                move.w  d1,-(a0)
                move.w  #$8F02,-(a0)
                btst    #2,(word_FFF7E6+1).w
                bne.w   loc_12D4
                move.l  #$94009302,-(a0)
                bra.w   loc_12DA
; ---------------------------------------------------------------------------
loc_12D4:                               ; CODE XREF: Gfx_QueueDMAPlaneATransfer+3C   j
                move.l  #$94009328,-(a0)
loc_12DA:                               ; CODE XREF: Gfx_QueueDMAPlaneATransfer+46   j
                move.w  a0,(word_FFF70C).w
                rts
; End of function Gfx_QueueDMAPlaneATransfer
; Clears VDP background color registers to black
Gfx_ClearBackgroundColor:                               ; CODE XREF: Sys_GameplayMainLoop+230   j  ; was: sub_12E0
                tst.b   (byte_FFF746).w
                bpl.w   locret_131A
                move.w  (word_FFF7D2).w,d0
                bclr    #6,d0
                move.w  d0,(VDP_CTRL).l
                move.w  #$F,d0
loc_12FA:                               ; CODE XREF: Gfx_ClearBackgroundColor+26   j
                move.w  d0,d1
                ori.w   #$8700,d1
                move.w  d1,(VDP_CTRL).l
                dbf     d0,loc_12FA
                move.w  (word_FFF7D2).w,(VDP_CTRL).l
                move.w  (word_FFF7DE).w,(VDP_CTRL).l
locret_131A:                            ; CODE XREF: Gfx_ClearBackgroundColor+4   j
                rts
; End of function Gfx_ClearBackgroundColor
; Disables display and clears background color during blanking
Gfx_DisableDisplayLayer:
                tst.b   (byte_FFF746).w  ; was: sub_131C
                bpl.w   locret_133A
                move.w  (word_FFF7D2).w,d0
                bclr    #6,d0
                move.w  d0,(VDP_CTRL).l
                move.w  #$8700,(VDP_CTRL).l
locret_133A:                            ; CODE XREF: Gfx_DisableDisplayLayer+4   j
                rts
; End of function Gfx_DisableDisplayLayer
; Re-enables display and restores background color after blanking
Gfx_EnableDisplayLayer:
                tst.b   (byte_FFF746).w  ; was: sub_133C
                bpl.w   locret_1354
                move.w  (word_FFF7D2).w,(VDP_CTRL).l
                move.w  (word_FFF7DE).w,(VDP_CTRL).l
locret_1354:                            ; CODE XREF: Gfx_EnableDisplayLayer+4   j
                rts
; End of function Gfx_EnableDisplayLayer
; VBlank effect dispatcher routing to effect handlers
