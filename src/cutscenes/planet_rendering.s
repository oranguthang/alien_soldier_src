Cutscene_UpdateStarPositions:                           ; CODE XREF: Cutscene_AnimateStars+6   p  ; was: sub_7644
                                        ; Cutscene_FadeStarObjects+6   p
                lea     (dword_FFC634).w,a5
                move.w  #$9C,d0
                sub.w   (word_FF00E8).l,d0
                move.w  d0,(a5)
                adda.w  #$60,a5                         ; '`'
                move.w  d0,(a5)
                adda.w  #$60,a5                         ; '`'
                move.w  d0,(a5)
                adda.w  #$60,a5                         ; '`'
                move.w  d0,(a5)
                adda.w  #$60,a5                         ; '`'
                move.w  #$C4,d0
                add.w   (word_FF00E8).l,d0
                move.w  d0,(a5)
                adda.w  #$60,a5                         ; '`'
                move.w  d0,(a5)
                adda.w  #$60,a5                         ; '`'
                move.w  d0,(a5)
                adda.w  #$60,a5                         ; '`'
                move.w  d0,(a5)
                rts
; End of function Cutscene_UpdateStarPositions
; Copies planet sprite coordinates from buffer to global state
Cutscene_CopyPlanetCoords:                              ; CODE XREF: Cutscene_PlanetZoomIn+8   p  ; was: sub_768A
                                        ; sub_5244   p
                move.w  (word_FFC9F4).w,(word_FF00D4).l
                move.w  (word_FFC9F0).w,(word_FF00D6).l
; End of function Cutscene_CopyPlanetCoords
; Planet scrolling animation
Cutscene_PlanetScroll:                                  ; CODE XREF: Cutscene_PlanetSequenceCtrl+C   p  ; was: sub_769A
                                        ; Cutscene_PlanetTransition+8   p
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
                clr.w   d5
                move.w  (word_FF00D8).l,d3
loc_76AA:                                               ; CODE XREF: Cutscene_PlanetScroll+14   j
                subi.w  #$20,d5                         ; ' '
                dbf     d3,loc_76AA
                asr.w   #1,d5
                add.w   (word_FF00D4).l,d5
                clr.w   d6
                move.w  (word_FF00DA).l,d2
loc_76C2:                                               ; CODE XREF: Cutscene_PlanetScroll+2C   j
                subi.w  #$20,d6                         ; ' '
                dbf     d2,loc_76C2
                asr.w   #1,d6
                add.w   (word_FF00D6).l,d6
                move.w  (word_FF00DC).l,d4
                move.w  (word_FF00D8).l,d3
                move.w  d5,d0
loc_76E0:                                               ; CODE XREF: Cutscene_PlanetScroll+64   j
                move.w  (word_FF00DA).l,d2
                move.w  d6,d1
loc_76E8:                                               ; CODE XREF: Cutscene_PlanetScroll+5C   j
                move.w  d0,(a1)+
                move.w  #$F00,(a1)+
                move.w  d4,(a1)+
                move.w  d1,(a1)+
                addi.w  #$20,d1                         ; ' '
                dbf     d2,loc_76E8
                addi.w  #$20,d0                         ; ' '
                dbf     d3,loc_76E0
                move.w  #$FFFF,(a1)
                jmp     (Sprite_AppendOAMEntries).l
; End of function Cutscene_PlanetScroll
; Renders grid of sprites for cutscene with calculated centered positions
Cutscene_RenderSpriteGrid:                              ; CODE XREF: Cutscene_ShipFadeOut+8   p  ; was: sub_770C
                                        ; sub_549C   p
                move.w  (word_FFCA54).w,(word_FF00DE).l
                move.w  (word_FFCA50).w,(word_FF00E0).l
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
                clr.w   d5
                move.w  (word_FF00E2).l,d3
loc_772C:                                               ; CODE XREF: Cutscene_RenderSpriteGrid+24   j
                subi.w  #$20,d5                         ; ' '
                dbf     d3,loc_772C
                asr.w   #1,d5
                add.w   (word_FF00DE).l,d5
                clr.w   d6
                move.w  (word_FF00E4).l,d2
loc_7744:                                               ; CODE XREF: Cutscene_RenderSpriteGrid+3C   j
                subi.w  #$20,d6                         ; ' '
                dbf     d2,loc_7744
                asr.w   #1,d6
                add.w   (word_FF00E0).l,d6
                move.w  (word_FF00E6).l,d4
                move.w  (word_FF00E2).l,d3
                move.w  d5,d0
loc_7762:                                               ; CODE XREF: Cutscene_RenderSpriteGrid+74   j
                move.w  (word_FF00E4).l,d2
                move.w  d6,d1
loc_776A:                                               ; CODE XREF: Cutscene_RenderSpriteGrid+6C   j
                move.w  d0,(a1)+
                move.w  #$F00,(a1)+
                move.w  d4,(a1)+
                move.w  d1,(a1)+
                addi.w  #$20,d1                         ; ' '
                dbf     d2,loc_776A
                addi.w  #$20,d0                         ; ' '
                dbf     d3,loc_7762
                move.w  #$FFFF,(a1)
                jmp     (Sprite_AppendOAMEntries).l
; End of function Cutscene_RenderSpriteGrid
; Clears sprite buffer and initiates DMA transfer for cutscene graphics
Cutscene_ClearSpriteBuffer:                             ; CODE XREF: Cutscene_InitShipSprite+82   p  ; was: sub_778E
                                        ; Cutscene_InitShipSprite2+90   p
                lea     (dword_FF0020).l,a0
                moveq   #$FFFFFFFF,d0
                move.w  #7,d1
loc_779A:                                               ; CODE XREF: Cutscene_ClearSpriteBuffer+E   j
                move.l  d0,(a0)+
                dbf     d1,loc_779A
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(a0)
                move.l  (dword_FF00CA).l,(VDP_CTRL).l
                bra.s   loc_77E4
; End of function Cutscene_ClearSpriteBuffer
; Planet rotation effect
Cutscene_PlanetRotate:                                  ; CODE XREF: Cutscene_SetupPlanetRotate+82   p  ; was: sub_77BA
                                        ; Cutscene_InitPlanetZoomIn+90   p
                lea     (M68K_RAM).l,a0
                moveq   #$FFFFFFFF,d0
                move.w  #7,d1
loc_77C6:                                               ; CODE XREF: Cutscene_PlanetRotate+E   j
                move.l  d0,(a0)+
                dbf     d1,loc_77C6
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(a0)
                move.l  (dword_FF00C0).l,(VDP_CTRL).l
loc_77E4:                                               ; CODE XREF: Cutscene_ClearSpriteBuffer+2A   j
                move.w  #$FFFF,d0
                move.w  #$FF,d1
loc_77EC:                                               ; CODE XREF: Cutscene_PlanetRotate+34   j
                move.w  d0,(a0)
                dbf     d1,loc_77EC
                move    #$2300,sr
                rts
; End of function Cutscene_PlanetRotate
; Fades in ship sprite by manipulating palette mask based on input timer
Cutscene_FadeInShip:                                    ; CODE XREF: Cutscene_ShipFadeIn+C   p  ; was: sub_77F8
                                        ; Cutscene_ShipZoomOut+C   p
                move.w  (word_FFA280).w,d0
                and.w   (word_FF00D2).l,d0
                bne.w   locret_514E
                move.w  (word_FF00D0).l,d0
                bmi.w   locret_514E
                subq.w  #1,(word_FF00D0).l
                bsr.w   Gfx_CalculatePaletteMask
                eori.w  #$FFFF,d2
                move.w  (a2),d4
                or.w    d2,d4
                move.w  d4,(a2)
                lea     (word_FF0060).l,a2
                move.w  #$F,d7
loc_782E:                                               ; CODE XREF: Cutscene_FadeInShip+38   j
                move.w  d4,(a2)+
                dbf     d7,loc_782E
                movea.w (VDPCommandQueueHead).w,a0
                suba.w  #$10,a0
                move.w  a0,(VDPCommandQueueHead).w
                move.l  #$94009310,(a0)+
                move.l  #$8F20977F,(a0)+
                move.l  #$96809530,(a0)+
                ori.l   #$80,d6
                move.l  d6,(a0)+
                rts
; End of function Cutscene_FadeInShip
; Fades out ship sprite by manipulating palette mask based on input timer
Cutscene_FadeOutShip:                                   ; CODE XREF: Cutscene_ShipFadeOut+C   p  ; was: sub_785C
                                        ; Cutscene_ShipZoomIn+12   p
                move.w  (word_FFA280).w,d0
                and.w   (word_FF00D2).l,d0
                bne.w   locret_514E
                move.w  (word_FF00D0).l,d0
                cmpi.w  #$40,d0                         ; '@'
                beq.w   locret_514E
                addq.w  #1,(word_FF00D0).l
                bsr.w   Gfx_CalculatePaletteMask
                move.w  (a2),d4
                and.w   d2,d4
                move.w  d4,(a2)
                lea     (word_FF0060).l,a2
                move.w  #$F,d7
loc_7892:                                               ; CODE XREF: Cutscene_FadeOutShip+38   j
                move.w  d4,(a2)+
                dbf     d7,loc_7892
                movea.w (VDPCommandQueueHead).w,a0
                suba.w  #$10,a0
                move.w  a0,(VDPCommandQueueHead).w
                move.l  #$94009310,(a0)+
                move.l  #$8F20977F,(a0)+
                move.l  #$96809530,(a0)+
                ori.l   #$80,d6
                move.l  d6,(a0)+
                rts
; End of function Cutscene_FadeOutShip
; Updates VDP registers with bitwise mask operations
Gfx_UpdateVDPRegistersWithMask:                         ; CODE XREF: Cutscene_PlanetZoomOut+C   p  ; was: sub_78C0
                                        ; Cutscene_PlanetFadeInAlt+C   p
                move.w  (word_FFA280).w,d0
                and.w   (word_FF00C8).l,d0
                bne.w   locret_514E
                move.w  (word_FF00C6).l,d0
                bmi.w   locret_514E
                subq.w  #1,(word_FF00C6).l
                bsr.w   Gfx_CalculatePaletteOffset
                eori.w  #$FFFF,d2
                move.w  (a2),d4
                or.w    d2,d4
                move.w  d4,(a2)
                lea     (word_FF0040).l,a2
                move.w  #$F,d7
loc_78F6:                                               ; CODE XREF: Gfx_UpdateVDPRegistersWithMask+38   j
                move.w  d4,(a2)+
                dbf     d7,loc_78F6
                movea.w (VDPCommandQueueHead).w,a0
                suba.w  #$10,a0
                move.w  a0,(VDPCommandQueueHead).w
                move.l  #$94009310,(a0)+
                move.l  #$8F20977F,(a0)+
                move.l  #$96809520,(a0)+
                ori.l   #$80,d6
                move.l  d6,(a0)+
                rts
; End of function Gfx_UpdateVDPRegistersWithMask
; Fades out palette by updating mask and VDP registers with visual effect
Gfx_FadeOutPalette:                                     ; CODE XREF: Cutscene_PlanetZoomIn+C   p  ; was: sub_7924
                                        ; Cutscene_PlanetFadeOutAlt+12   p
                move.w  (word_FFA280).w,d0
                and.w   (word_FF00C8).l,d0
                bne.w   locret_514E
                move.w  (word_FF00C6).l,d0
                cmpi.w  #$40,d0                         ; '@'
                beq.w   locret_514E
                addq.w  #1,(word_FF00C6).l
                bsr.w   Gfx_CalculatePaletteOffset
                move.w  (a2),d4
                and.w   d2,d4
                move.w  d4,(a2)
                lea     (word_FF0040).l,a2
                move.w  #$F,d7
loc_795A:                                               ; CODE XREF: Gfx_FadeOutPalette+38   j
                move.w  d4,(a2)+
                dbf     d7,loc_795A
                movea.w (VDPCommandQueueHead).w,a0
                suba.w  #$10,a0
                move.w  a0,(VDPCommandQueueHead).w
                move.l  #$94009310,(a0)+
                move.l  #$8F20977F,(a0)+
                move.l  #$96809520,(a0)+
                ori.l   #$80,d6
                move.l  d6,(a0)+
                rts
; End of function Gfx_FadeOutPalette
; Calculates RAM offset and VRAM address for palette operations based on lookup table
Gfx_CalculatePaletteOffset:                             ; CODE XREF: Gfx_UpdateVDPRegistersWithMask+1E   p  ; was: sub_7988
                                        ; Gfx_FadeOutPalette+22   p
                lea     (M68K_RAM).l,a2
                lea     byte_79BA(pc,d0.w),a3
                moveq   #0,d2
                move.b  (a3),d2
                andi.b  #3,d2
                lsl.b   #1,d2
                lea     word_79FA(pc,d2.w),a4
                move.w  (a4),d2
                moveq   #0,d3
                move.b  (a3),d3
                andi.b  #$3C,d3                         ; '<'
                lsr.b   #1,d3
                adda.l  d3,a2
                swap    d3
                move.l  (dword_FF00C0).l,d6
                add.l   d3,d6
                rts
; End of function Gfx_CalculatePaletteOffset
; ---------------------------------------------------------------------------
byte_79BA:      dc.b    4, $2A, $24, 8, $18, $32, $27, $2D, $37, $13, $F, $1C, $36, 3, $12, $17
                                        ; DATA XREF: Gfx_CalculatePaletteOffset+6   o
                                        ; Gfx_CalculatePaletteMask+6   o
                dc.b    $C, $23, $20, $2E, $A, $3C, $21, $E, $1D, $38, 1, $19, $3A, $D, $2C, $35
                dc.b    $2F, $10, $29, 0, $15, $26, 6, $28, 5, $33, $30, 2, $11, $3F, $34, $1E
                dc.b    $3D, $1A, $14, $3E, 9, $31, $16, 7, $25, $B, $39, $1F, $2B, $1B, $3B, $22
word_79FA:      dc.w    $FFF, $F0FF, $FF0F, $FFF0

; Calculates palette RAM offset and VRAM address with color channel mask
Gfx_CalculatePaletteMask:                               ; CODE XREF: Cutscene_FadeInShip+1E   p  ; was: sub_7A02
                                        ; Cutscene_FadeOutShip+22   p
                lea     (dword_FF0020).l,a2
                lea     byte_79BA(pc,d0.w),a3
                moveq   #0,d2
                move.b  (a3),d2
                andi.b  #3,d2
                lsl.b   #1,d2
                lea     word_79FA(pc,d2.w),a4
                move.w  (a4),d2
                moveq   #0,d3
                move.b  (a3),d3
                andi.b  #$3C,d3                         ; '<'
                lsr.b   #1,d3
                adda.l  d3,a2
                swap    d3
                move.l  (dword_FF00CA).l,d6
                add.l   d3,d6
                rts
; End of function Gfx_CalculatePaletteMask
; Updates planet palette with alternating color masks and queues DMA
Gfx_UpdatePlanetPalette:                                ; CODE XREF: Cutscene_PlanetZoomIn+10   p  ; was: sub_7A34
                                        ; Cutscene_PlanetHold+4   p
                lea     (word_FF0080).l,a1
                lea     (M68K_RAM).l,a2
                lea     word_7B0C(pc),a3
                nop
                move.w  (word_FFA280).w,d0
                andi.w  #1,d0
                bne.s   loc_7A56
                adda.l  #4,a3
loc_7A56:                                               ; CODE XREF: Gfx_UpdatePlanetPalette+1A   j
                move.w  #$F,d6
loc_7A5A:                                               ; CODE XREF: Gfx_UpdatePlanetPalette+2C   j
                move.w  (a2)+,d0
                or.w    (a3)+,d0
                move.w  d0,(a1)+
                dbf     d6,loc_7A5A
                move.l  (dword_FF00C0).l,d6
                ori.l   #$80,d6
                movea.w (VDPCommandQueueHead).w,a0
                suba.w  #$100,a0
                move.w  a0,(VDPCommandQueueHead).w
                move.w  #$F,d0
loc_7A80:                                               ; CODE XREF: Gfx_UpdatePlanetPalette+66   j
                move.l  #$94009310,(a0)+
                move.l  #$8F02877F,(a0)+
                move.l  #$96809540,(a0)+
                move.l  d6,(a0)+
                addi.l  #$200000,d6
                dbf     d0,loc_7A80
                rts
; End of function Gfx_UpdatePlanetPalette
; Updates ship palette with alternating color masks and queues DMA
Gfx_UpdateShipPalette:                                  ; CODE XREF: Cutscene_ShipFadeOut+10   p  ; was: sub_7AA0
                                        ; Cutscene_WaitShipDelay+4   p
                lea     (word_FF00A0).l,a1
                lea     (dword_FF0020).l,a2
                lea     word_7B0C(pc),a3
                nop
                move.w  (word_FFA280).w,d0
                andi.w  #1,d0
                bne.s   loc_7AC2
                adda.l  #4,a3
loc_7AC2:                                               ; CODE XREF: Gfx_UpdateShipPalette+1A   j
                move.w  #$F,d6
loc_7AC6:                                               ; CODE XREF: Gfx_UpdateShipPalette+2C   j
                move.w  (a2)+,d0
                or.w    (a3)+,d0
                move.w  d0,(a1)+
                dbf     d6,loc_7AC6
                move.l  (dword_FF00CA).l,d6
                ori.l   #$80,d6
                movea.w (VDPCommandQueueHead).w,a0
                suba.w  #$100,a0
                move.w  a0,(VDPCommandQueueHead).w
                move.w  #$F,d0
loc_7AEC:                                               ; CODE XREF: Gfx_UpdateShipPalette+66   j
                move.l  #$94009310,(a0)+
                move.l  #$8F02877F,(a0)+
                move.l  #$96809550,(a0)+
                move.l  d6,(a0)+
                addi.l  #$200000,d6
                dbf     d0,loc_7AEC
                rts
; End of function Gfx_UpdateShipPalette
; ---------------------------------------------------------------------------
word_7B0C:      dc.w    $F0F, $F0F, $F0F0, $F0F0, $F0F, $F0F, $F0F0, $F0F0, $F0F
                                        ; DATA XREF: Gfx_UpdatePlanetPalette+C   o
                                        ; Gfx_UpdateShipPalette+C   o
                dc.w    $F0F, $F0F0, $F0F0, $F0F, $F0F, $F0F0, $F0F0, $F0F, $F0F

; Initializes credits screen with graphics loading and palette fade setup
