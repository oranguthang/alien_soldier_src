; Sets up VDP scroll plane registers
Gfx_SetupScrollPlanes:                                  ; CODE XREF: StoryScreen_Initialize+8A   p  ; was: sub_103FA
                                        ; StoryScreen_MainLoop+56   p
                move.w  #$8230,(VDPReg2Shadow).w
                move.w  #$8407,(VDPReg4Shadow).w
                tst.w   (word_FF8640).w
                beq.s   loc_10418
                move.w  #$8238,(VDPReg2Shadow).w
                move.w  #$8406,(VDPReg4Shadow).w
loc_10418:                                              ; CODE XREF: Gfx_SetupScrollPlanes+10   j
                move.b  (VDPReg11Shadow+1).w,d3
                move.b  d3,d4
                andi.w  #3,d3
                andi.w  #4,d4
                move.b  (byte_FFA95A).w,d5
                movea.w #(HScrollBuffer-M68K_RAM),a0
                movea.w #(word_FFE480-M68K_RAM),a1
                adda.w  (word_FF8640).w,a0
                adda.w  (word_FF8640).w,a1
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                move.w  (word_FFA012).w,d1
                bsr.w   Gfx_WriteScrollValue
                movea.w #(VScrollBuffer-M68K_RAM),a0
                adda.w  (word_FF8640).w,a0
                move.w  (dword_FFA904).w,d0
                neg.w   d0
                add.w   (word_FFA012).w,d0
                bsr.w   Gfx_WriteScrollValues
                move.b  (byte_FFA95B).w,d5
                movea.w #(word_FFE402-M68K_RAM),a0
                movea.w #(byte_FFE482-M68K_RAM),a1
                suba.w  (word_FF8640).w,a0
                suba.w  (word_FF8640).w,a1
                move.w  (dword_FFA908).w,d0
                neg.w   d0
                move.w  (word_FFA016).w,d1
                bsr.w   Gfx_WriteScrollValue
                movea.w #(word_FFEC02-M68K_RAM),a0
                suba.w  (word_FF8640).w,a0
                move.w  (dword_FFA90C).w,d0
                neg.w   d0
                add.w   (word_FFA016).w,d0
                bra.w   Gfx_WriteScrollValues
; End of function Gfx_SetupScrollPlanes
; Writes scroll value with flag checks
Gfx_WriteScrollValue:                                   ; CODE XREF: Gfx_SetupScrollPlanes+4A   p  ; was: sub_10496
                                        ; Gfx_SetupScrollPlanes+82   p
                btst    #2,d5
                bne.w   loc_104CA
                btst    #4,d5
                bne.w   loc_105CE
                btst    #0,d5
                bne.s   locret_104AE
                move.w  d0,(a0)
locret_104AE:                                           ; CODE XREF: Gfx_WriteScrollValue+14   j
                rts
; End of function Gfx_WriteScrollValue
; Writes scroll values to VRAM with various modes
Gfx_WriteScrollValues:                                  ; CODE XREF: Gfx_SetupScrollPlanes+60   p  ; was: sub_104B0
                                        ; Gfx_SetupScrollPlanes+98   j
                btst    #3,d5
                bne.w   loc_10664
                btst    #5,d5
                bne.w   loc_106B4
                btst    #1,d5
                bne.s   locret_104C8
                move.w  d0,(a0)
locret_104C8:                                           ; CODE XREF: Gfx_WriteScrollValues+14   j
                rts
; ---------------------------------------------------------------------------
loc_104CA:                                              ; CODE XREF: Gfx_WriteScrollValue+4   j
                cmpi.b  #2,d3
                beq.w   loc_1055E
                move.w  #6,d7
loc_104D6:                                              ; CODE XREF: Gfx_WriteScrollValues+A8   j
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                move.w  d0,$10(a0)
                move.w  d0,$14(a0)
                move.w  d0,$18(a0)
                move.w  d0,$1C(a0)
                move.w  d0,$20(a0)
                move.w  d0,$24(a0)
                move.w  d0,$28(a0)
                move.w  d0,$2C(a0)
                move.w  d0,$30(a0)
                move.w  d0,$34(a0)
                move.w  d0,$38(a0)
                move.w  d0,$3C(a0)
                move.w  d0,$40(a0)
                move.w  d0,$44(a0)
                move.w  d0,$48(a0)
                move.w  d0,$4C(a0)
                move.w  d0,$50(a0)
                move.w  d0,$54(a0)
                move.w  d0,$58(a0)
                move.w  d0,$5C(a0)
                move.w  d0,$60(a0)
                move.w  d0,$64(a0)
                move.w  d0,$68(a0)
                move.w  d0,$6C(a0)
                move.w  d0,$70(a0)
                move.w  d0,$74(a0)
                move.w  d0,$78(a0)
                move.w  d0,$7C(a0)
                lea     $80(a0),a0
                dbf     d7,loc_104D6
                rts
; ---------------------------------------------------------------------------
loc_1055E:                                              ; CODE XREF: Gfx_WriteScrollValues+1E   j
                move.w  d0,(a0)
                move.w  d0,$20(a0)
                move.w  d0,$40(a0)
                move.w  d0,$60(a0)
                move.w  d0,$80(a0)
                move.w  d0,$A0(a0)
                move.w  d0,$C0(a0)
                move.w  d0,$E0(a0)
                move.w  d0,$100(a0)
                move.w  d0,$120(a0)
                move.w  d0,$140(a0)
                move.w  d0,$160(a0)
                move.w  d0,$180(a0)
                move.w  d0,$1A0(a0)
                move.w  d0,$1C0(a0)
                move.w  d0,$1E0(a0)
                move.w  d0,$200(a0)
                move.w  d0,$220(a0)
                move.w  d0,$240(a0)
                move.w  d0,$260(a0)
                move.w  d0,$280(a0)
                move.w  d0,$2A0(a0)
                move.w  d0,$2C0(a0)
                move.w  d0,$2E0(a0)
                move.w  d0,$300(a0)
                move.w  d0,$320(a0)
                move.w  d0,$340(a0)
                move.w  d0,$360(a0)
                rts
; ---------------------------------------------------------------------------
loc_105CE:                                              ; CODE XREF: Gfx_WriteScrollValue+C   j
                movea.w #(byte_FF8800-M68K_RAM),a2
                moveq   #0,d0
                cmpi.b  #2,d3
                beq.s   loc_10600
                move.w  d1,d0
                move.w  #$BF,d7
                move.w  d0,d6
                bmi.s   loc_105E6
                clr.w   d6
loc_105E6:                                              ; CODE XREF: Gfx_WriteScrollValues+132   j
                asl.w   #1,d0
                adda.l  d0,a2
loc_105EA:                                              ; CODE XREF: Gfx_WriteScrollValues+13E   j
                move.w  (a2)+,(a1)
                addq.w  #4,a1
                dbf     d7,loc_105EA
                move.w  -2(a2),d0
loc_105F6:                                              ; CODE XREF: Gfx_WriteScrollValues+14A   j
                move.w  d0,(a1)
                addq.w  #4,a1
                dbf     d6,loc_105F6
                rts
; ---------------------------------------------------------------------------
loc_10600:                                              ; CODE XREF: Gfx_WriteScrollValues+128   j
                moveq   #$20,d0                         ; ' '
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                move.w  (a2)+,(a1)
                adda.w  d0,a1
                rts
; ---------------------------------------------------------------------------
loc_10664:                                              ; CODE XREF: Gfx_WriteScrollValues+4   j
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                move.w  d0,$10(a0)
                move.w  d0,$14(a0)
                move.w  d0,$18(a0)
                move.w  d0,$1C(a0)
                move.w  d0,$20(a0)
                move.w  d0,$24(a0)
                move.w  d0,$28(a0)
                move.w  d0,$2C(a0)
                move.w  d0,$30(a0)
                move.w  d0,$34(a0)
                move.w  d0,$38(a0)
                move.w  d0,$3C(a0)
                move.w  d0,$40(a0)
                move.w  d0,$44(a0)
                move.w  d0,$48(a0)
                move.w  d0,$4C(a0)
                rts
; ---------------------------------------------------------------------------
loc_106B4:                                              ; CODE XREF: Gfx_WriteScrollValues+C   j
                movea.w #(dword_FF8A00-M68K_RAM),a2
                move.w  #$13,d7
loc_106BC:                                              ; CODE XREF: Gfx_WriteScrollValues+210   j
                move.w  (a2)+,(a0)
                addq.w  #4,a0
                dbf     d7,loc_106BC
                rts
; End of function Gfx_WriteScrollValues
