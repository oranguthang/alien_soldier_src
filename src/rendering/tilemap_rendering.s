Gfx_InitScrollBuffer:
                lea     (word_FFA400).w,a5              ; was: sub_106C6
                move.w  #8,(a5)
                rts
; End of function Gfx_InitScrollBuffer
; Calculates scroll offsets using camera position
Scroll_CalculateOffsets1:
                move.w  (dword_FFA908).w,d0             ; was: sub_106D0
                addi.w  #$180,d0
                move.w  (dword_FFA90C).w,d1
                lea     Gfx_FrontendAlternateVRAMTransferParameters(pc),a0
                nop
                bra.s   loc_10704
; End of function Scroll_CalculateOffsets1
; Renders tilemap with adjusted camera position
Scroll_RenderTilemapAdjusted:
                move.w  (dword_FFA900).w,d0             ; was: sub_106E4
                subi.w  #$58,d0                         ; 'X'
                move.w  (dword_FFA904).w,d1
                bra.s   Gfx_RenderTilemap
; End of function Scroll_RenderTilemapAdjusted
; Gets camera position for rendering
Gfx_GetCameraPosition:                                  ; CODE XREF: Stage_InitTerobusterBoss+1E   p  ; was: sub_106F2
                                        ; Gfx_UpdateScroll+4   j
                move.w  (dword_FFA900).w,d0
                addi.w  #$158,d0
                move.w  (dword_FFA904).w,d1
; End of function Gfx_GetCameraPosition
; Renders tilemap tiles to VRAM planes
Gfx_RenderTilemap:                                      ; CODE XREF: Stage_TeleportFadeSequence+4A   j  ; was: sub_106FE
                                        ; Stage_MedusaCamera+46   p
                lea     Gfx_TitleAndZLeoVRAMTransferParameters(pc),a0
                nop
loc_10704:                                              ; CODE XREF: Stage_CaterpillarShipMovement+52   p
                                        ; Gfx_LoadStage18Tiles+1A   j
                neg.w   d1
                moveq   #8,d7
                move.w  d0,d2
                lsr.w   #8,d2
                move.w  d2,(dword_FF8058).w
                move.w  d0,d2
                lsr.w   #5,d2
                andi.w  #7,d2
                move.w  d2,(dword_FF8058+2).w
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #6,d2
                move.w  d2,(word_FF805C).w
                moveq   #$FFFFFFFF,d2
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #$7E,d2                         ; '~'
                move.l  d2,(dword_FF805E).w
loc_10736:                                              ; CODE XREF: Gfx_RenderTilemap+17E   j
                movea.l (a0)+,a1
                move.w  (dword_FF8058).w,d2
                move.w  d1,d3
                lsr.w   #3,d3
                andi.w  #$3E0,d3
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  (dword_FF8058+2).w,d2
                move.w  d1,d3
                lsr.w   #2,d3
                andi.w  #$38,d3                         ; '8'
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                tst.w   d7
                bne.w   loc_1081E
                subi.w  #$100,d1
                move.w  d1,d2
                move.w  (word_FFF70E).w,d3
                lsr.w   #2,d2
                andi.w  #$38,d2                         ; '8'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  (word_FF805C).w,d3
                add.w   d4,d3
                move.w  d1,d2
                andi.w  #$18,d2
                move.w  d2,d5
                subq.w  #8,d2
                bmi.s   loc_107AA
                move.w  (a1,d3.w),(a2)+
                subq.w  #8,d2
                bmi.s   loc_107AA
                move.w  8(a1,d3.w),(a2)+
                subq.w  #8,d2
                bmi.s   loc_107AA
                move.w  $10(a1,d3.w),(a2)+
loc_107AA:                                              ; CODE XREF: Gfx_RenderTilemap+96   j
                                        ; Gfx_RenderTilemap+9E   j
                tst.w   (a0)+
                beq.s   loc_107DA
                move.l  (dword_FF805E).w,d2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1E00,d4
                add.w   d4,d2
                movea.l d2,a2
                subq.w  #8,d5
                bmi.s   loc_107DA
                move.w  (a1,d3.w),(a2)
                subq.w  #8,d5
                bmi.s   loc_107DA
                move.w  8(a1,d3.w),$80(a2)
                subq.w  #8,d5
                bmi.s   loc_107DA
                move.w  $10(a1,d3.w),$100(a2)
loc_107DA:                                              ; CODE XREF: Gfx_RenderTilemap+AE   j
                                        ; Gfx_RenderTilemap+C2   j
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #$7E,d2                         ; '~'
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                add.w   (a0),d2
                move.w  d2,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F80977F,-(a1)
                move.l  #$94009320,-(a1)
                move.w  a1,(word_FFF70C).w
                addi.w  #$40,(word_FFF70E).w            ; '@'
                rts
; ---------------------------------------------------------------------------
loc_1081E:                                              ; CODE XREF: Gfx_RenderTilemap+6C   j
                move.w  d1,d2
                move.w  (word_FFF70E).w,d3
                lsr.w   #2,d2
                andi.w  #$38,d2                         ; '8'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  (word_FF805C).w,d3
                add.w   d4,d3
                move.w  (a1,d3.w),(a2)+
                move.w  8(a1,d3.w),(a2)+
                move.w  $10(a1,d3.w),(a2)+
                move.w  $18(a1,d3.w),(a2)+
                tst.w   (a0)+
                beq.w   loc_10872
                move.l  (dword_FF805E).w,d2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1E00,d4
                add.w   d4,d2
                movea.l d2,a2
                move.w  (a1,d3.w),(a2)
                move.w  8(a1,d3.w),$80(a2)
                move.w  $10(a1,d3.w),$100(a2)
                move.w  $18(a1,d3.w),$180(a2)
loc_10872:                                              ; CODE XREF: Gfx_RenderTilemap+14A   j
                suba.l  #$E,a0
                addi.w  #$20,d1                         ; ' '
                dbf     d7,loc_10736
                rts
; End of function Gfx_RenderTilemap
; Renders tilemap with vertical offset adjustment
Scroll_RenderTilemapVertOffset:
                move.w  (dword_FFA900).w,d0             ; was: sub_10882
                subi.w  #$58,d0                         ; 'X'
                move.w  (dword_FFA904).w,d1
                subi.w  #$1000,d1
                bra.s   loc_108A4
; End of function Scroll_RenderTilemapVertOffset
; Camera lock for boss battle
Camera_Stage18Lock:                                     ; CODE XREF: Gfx_LoadStage18Tiles:loc_1002A   p  ; was: sub_10894
                move.w  (dword_FFA900).w,d0
                addi.w  #$158,d0
                move.w  (dword_FFA904).w,d1
                subi.w  #$1000,d1
loc_108A4:                                              ; CODE XREF: Stage_MedusaCamera+62   p
                                        ; Scroll_RenderTilemapVertOffset+10   j
                lea     Gfx_DefaultVRAMTransferParameters(pc),a0
                nop
                neg.w   d1
                moveq   #8,d7
                move.w  d0,d2
                lsr.w   #8,d2
                move.w  d2,(dword_FF8058).w
                move.w  d0,d2
                lsr.w   #5,d2
                andi.w  #7,d2
                move.w  d2,(dword_FF8058+2).w
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #6,d2
                move.w  d2,(word_FF805C).w
                moveq   #$FFFFFFFF,d2
                move.w  d0,d2
                lsr.w   #2,d2
                andi.w  #$7E,d2                         ; '~'
                move.l  d2,(dword_FF805E).w
loc_108DC:                                              ; CODE XREF: Camera_Stage18Lock+10E   j
                movea.l (a0)+,a1
                move.w  (dword_FF8058).w,d2
                move.w  d1,d3
                lsr.w   #3,d3
                andi.w  #$3E0,d3
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  (dword_FF8058+2).w,d2
                move.w  d1,d3
                lsr.w   #2,d3
                andi.w  #$38,d3                         ; '8'
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                tst.w   d7
                bne.w   loc_10968
                subi.w  #$100,d1
                move.w  d1,d2
                move.w  (word_FFF70E).w,d3
                lsr.w   #2,d2
                andi.w  #$38,d2                         ; '8'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  (word_FF805C).w,d3
                add.w   d4,d3
                move.w  d1,d2
                andi.w  #$18,d2
                move.w  d2,d5
                tst.w   (a0)+
                move.l  (dword_FF805E).w,d2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1E00,d4
                add.w   d4,d2
                movea.l d2,a2
                subq.w  #8,d5
                bmi.s   locret_10966
                move.w  (a1,d3.w),(a2)
                subq.w  #8,d5
                bmi.s   locret_10966
                move.w  8(a1,d3.w),$80(a2)
                subq.w  #8,d5
                bmi.s   locret_10966
                move.w  $10(a1,d3.w),$100(a2)
locret_10966:                                           ; CODE XREF: Camera_Stage18Lock+B8   j
                                        ; Camera_Stage18Lock+C0   j
                rts
; ---------------------------------------------------------------------------
loc_10968:                                              ; CODE XREF: Camera_Stage18Lock+7C   j
                movea.l (a0)+,a1
                move.w  (word_FF805C).w,d3
                add.w   d4,d3
                tst.w   (a0)+
                move.l  (dword_FF805E).w,d2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1E00,d4
                add.w   d4,d2
                movea.l d2,a2
                move.w  (a1,d3.w),(a2)
                move.w  8(a1,d3.w),$80(a2)
                move.w  $10(a1,d3.w),$100(a2)
                move.w  $18(a1,d3.w),$180(a2)
                suba.l  #$E,a0
                addi.w  #$20,d1                         ; ' '
                dbf     d7,loc_108DC
                rts
; End of function Camera_Stage18Lock
; Calculates scroll offsets with different camera
