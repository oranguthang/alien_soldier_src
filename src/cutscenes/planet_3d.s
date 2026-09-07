Gfx_Update3DPlanetEffect:                               ; CODE XREF: Stage_LoadAssets   p  ; was: sub_1F82E
                cmpi.w  #$A,(word_FFA29C).w
                bpl.s   loc_1F852
                subi.l  #$18000,(dword_FF8130).w
                cmpi.l  #$B00000,(dword_FF8130).w
                bpl.s   loc_1F86C
                move.l  #$1500000,(dword_FF8130).w
                bra.s   loc_1F86C
; ---------------------------------------------------------------------------
loc_1F852:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+6   j
                addi.l  #$18000,(dword_FF8130).w
                cmpi.l  #$1500000,(dword_FF8130).w
                bmi.s   loc_1F86C
                move.l  #$B00000,(dword_FF8130).w
loc_1F86C:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+18   j
                                        ; Gfx_Update3DPlanetEffect+22   j
                move.w  (dword_FF8130).w,d0
                asr.w   #3,d0
                subi.w  #$16,d0
                andi.w  #$1E,d0
                move.w  word_1F81A(pc,d0.w),(word_FFE37C).w
                move.w  word_1F806(pc,d0.w),(word_FFE37E).w
                movea.w #(byte_FF9C1E-M68K_RAM),a0
                moveq   #1,d0
                move.w  #$60,d7                         ; '`'
loc_1F890:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+66   j
                move.w  d0,(a0)+
                subq.w  #2,d0
                dbf     d7,loc_1F890
                movea.w #(byte_FF9C80-M68K_RAM),a0
                move.l  (dword_FF8130).w,d0
                subi.l  #Z80_RAM,d0
                move.l  d0,d1
                move.l  d0,d2
                lsr.l   #1,d2
                sub.l   d2,d0
loc_1F8AE:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+AE   j
                swap    d0
                move.w  d0,d3
                addq.w  #6,d3
                neg.w   d3
                move.w  d0,d2
                andi.w  #$FFFE,d2
                move.w  d3,(a0,d2.w)
                move.w  d0,d3
                addq.w  #4,d3
                move.w  d0,d2
                addq.w  #2,d2
                neg.w   d2
                andi.w  #$FFFE,d2
                move.w  d3,(a0,d2.w)
                swap    d0
                add.l   d1,d0
                cmpi.l  #$600000,d0
                bmi.s   loc_1F8AE
                move.l  (dword_FF8130).w,d0
                move.l  d0,d1
                move.l  d0,d2
                lsr.l   #1,d2
                sub.l   d2,d0
loc_1F8EA:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+EA   j
                swap    d0
                move.w  d0,d3
                addq.w  #2,d3
                neg.w   d3
                move.w  d0,d2
                andi.w  #$FFFE,d2
                move.w  d3,(a0,d2.w)
                move.w  d0,d3
                subq.w  #8,d3
                move.w  d0,d2
                addq.w  #2,d2
                neg.w   d2
                andi.w  #$FFFE,d2
                move.w  d3,(a0,d2.w)
                swap    d0
                add.l   d1,d0
                cmpi.l  #$600000,d0
                bmi.s   loc_1F8EA
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.l  #$EEEEEEEE,d0
                moveq   #$FFFFFFFF,d1
                moveq   #0,d2
                moveq   #$13,d7
loc_1F92A:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+10C   j
                move.l  d0,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d1,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                dbf     d7,loc_1F92A
                move.l  (dword_FF8130).w,d0
                subi.l  #Z80_RAM,d0
                move.l  d0,d1
                move.l  d0,d2
                lsr.l   #1,d2
                sub.l   d2,d0
loc_1F950:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+148   j
                swap    d0
                btst    #0,d0
                beq.s   loc_1F962
                move.w  #$F,d1
                move.w  #$F,d2
                bra.s   loc_1F96A
; ---------------------------------------------------------------------------
loc_1F962:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+128   j
                move.w  #$F0,d1
                move.w  #$FF,d2
loc_1F96A:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+132   j
                bsr.s   Gfx_WritePixelData
                swap    d0
                add.l   d1,d0
                cmpi.l  #Z80_RAM,d0
                bmi.s   loc_1F950
                move.l  (dword_FF8130).w,d0
                move.l  d0,d1
                move.l  d0,d2
                lsr.l   #1,d2
                sub.l   d2,d0
loc_1F984:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+17C   j
                swap    d0
                btst    #0,d0
                beq.s   loc_1F996
                move.w  #$E,d1
                move.w  #$FE,d2
                bra.s   loc_1F99E
; ---------------------------------------------------------------------------
loc_1F996:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+15C   j
                move.w  #$E0,d1
                move.w  #$EF,d2
loc_1F99E:                                              ; CODE XREF: Gfx_Update3DPlanetEffect+166   j
                bsr.s   Gfx_WritePixelData
                swap    d0
                add.l   d1,d0
                cmpi.l  #Z80_RAM,d0
                bmi.s   loc_1F984
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.w  #$7000,d0
                move.w  #$8F02,d3
                move.l  #$94019340,d4
                jmp     loc_1B78C
; End of function Gfx_Update3DPlanetEffect
; Writes pixel data to graphics buffer
Gfx_WritePixelData:                                     ; CODE XREF: Gfx_Update3DPlanetEffect:loc_1F96A   p  ; was: sub_1F9C4
                                        ; sub_1F82E:loc_1F99E   p
                move.w  d0,d3
                move.w  d0,d4
                asr.w   #1,d3
                andi.w  #3,d3
                andi.w  #$FFF8,d4
                asl.w   #2,d4
                add.w   d3,d4
                addi.w  #-$6C00,d4
                movea.w d4,a0
                move.b  d1,4(a0)
                move.b  d1,8(a0)
                move.b  d1,$C(a0)
                move.b  d2,$10(a0)
                move.b  d1,$14(a0)
                move.b  d1,$18(a0)
                move.b  d1,$1C(a0)
                rts
; End of function Gfx_WritePixelData
; ---------------------------------------------------------------------------
byte_1F9FA:     dc.b    0, $1D, $F, $1E, $1F, $1A, 0, $23, $19, $1F, $1C, 0, $21, $F, $B, $1A
                                        ; DATA XREF: UI_RenderDifficultyText+4   o
                dc.b    $19, $18, $1D, 0, $FF
byte_1FA0F:     dc.b    $C, $1F, $1D, $1E, $F, $1C, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F5FA   o
byte_1FA1C:     dc.b    $1C, $B, $18, $11, $F, $1C, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F5FE   o
byte_1FA29:     dc.b    $10, $16, $B, $17, $F, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F602   o
byte_1FA35:     dc.b    $12, $19, $17, $13, $18, $11, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F606   o
byte_1FA42:     dc.b    $1D, $21, $19, $1C, $E, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F60A   o
byte_1FA4E:     dc.b    $16, $B, $18, $D, $F, $1C, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F60E   o
byte_1FA5B:     dc.b    $1D, $12, $19, $19, $1E, $13, $18, $11, 0, $17, $19, $E, $F, $FF
                                        ; DATA XREF: UI_RenderTitleMenuOptions:loc_1F63E   o
byte_1FA69:     dc.b    $17, $19, $20, $13, $18, $11, $FF
                                        ; DATA XREF: UI_RenderTitleMenuOptions:loc_1F65C   o
byte_1FA70:     dc.b    $10, $13, $22, $FF              ; DATA XREF: UI_RenderTitleMenuOptions:loc_1F67A   o
byte_1FA74:     dc.b    $1D, $1E, $B, $1E, $1F, $1D, 0, $21, $13, $18, $E, $19, $21, $FF
                                        ; DATA XREF: UI_RenderControlsText:loc_1F69A   o
byte_1FA82:     dc.b    $1E, $23, $1A, $F, $2E, 2, 0, $FF
                                        ; DATA XREF: ROM:off_1F2D2   o
byte_1FA8A:     dc.b    $1E, $23, $1A, $F, $2E, 3, 0, $FF
                                        ; DATA XREF: ROM:0001F2D6   o
byte_1FA92:     dc.b    $1E, $23, $1A, $F, $2E, 4, 0, $FF
                                        ; DATA XREF: ROM:0001F2DA   o
byte_1FA9A:     dc.b    $1E, $23, $1A, $F, $2E, 5, 0, $FF
                                        ; DATA XREF: ROM:0001F2DE   o
byte_1FAA2:     dc.b    $1E, $23, $1A, $F, $2E, 6, 0, $FF
                                        ; DATA XREF: ROM:0001F2E2   o
byte_1FAAA:     dc.b    $1E, $23, $1A, $F, $2E, 7, 0, $FF
                                        ; DATA XREF: ROM:0001F2E6   o
byte_1FAB2:     dc.b    $1E, $23, $1A, $F, $2E, 8, 0, $FF
                                        ; DATA XREF: ROM:0001F2EA   o
byte_1FABA:     dc.b    $1E, $23, $1A, $F, $2E, 9, 0, $FF
                                        ; DATA XREF: ROM:0001F2EE   o
byte_1FAC2:     dc.b    $1E, $23, $1A, $F, $2E, $A, 0, $FF
                                        ; DATA XREF: ROM:0001F2F2   o
byte_1FACA:     dc.b    $1E, $23, $1A, $F, $2E, 2, 1, $FF
                                        ; DATA XREF: ROM:0001F2F6   o
byte_1FAD2:     dc.b    $1E, $23, $1A, $F, $2E, 2, 2, $FF
                                        ; DATA XREF: ROM:0001F2FA   o
byte_1FADA:     dc.b    $1E, $23, $1A, $F, $2E, 2, 3, $FF
                                        ; DATA XREF: ROM:0001F2FE   o
byte_1FAE2:     dc.b    $1E, $23, $1A, $F, $2E, 2, 4, $FF
                                        ; DATA XREF: ROM:0001F302   o
byte_1FAEA:     dc.b    $1E, $23, $1A, $F, $2E, 2, 5, $FF
                                        ; DATA XREF: ROM:0001F306   o
byte_1FAF2:     dc.b    $1E, $23, $1A, $F, $2E, 2, 6, $FF
                                        ; DATA XREF: ROM:0001F30A   o
byte_1FAFA:     dc.b    $1E, $23, $1A, $F, $2E, 2, 7, $FF
                                        ; DATA XREF: ROM:0001F30E   o
byte_1FB02:     dc.b    $1E, $23, $1A, $F, $2E, 2, 8, $FF
                                        ; DATA XREF: ROM:0001F312   o
byte_1FB0A:     dc.b    $1E, $23, $1A, $F, $2E, 2, 9, $FF
                                        ; DATA XREF: ROM:0001F316   o
byte_1FB12:     dc.b    $1E, $23, $1A, $F, $2E, 2, $A, $FF
                                        ; DATA XREF: ROM:0001F31A   o
byte_1FB1A:     dc.b    $1E, $23, $1A, $F, $2E, 3, 1, $FF
                                        ; DATA XREF: ROM:0001F31E   o
byte_1FB22:     dc.b    $1E, $23, $1A, $F, $2E, 3, 2, $FF
                                        ; DATA XREF: ROM:0001F322   o
byte_1FB2A:     dc.b    $1E, $23, $1A, $F, $2E, 3, 3, $FF
                                        ; DATA XREF: ROM:0001F326   o
byte_1FB32:     dc.b    $1E, $23, $1A, $F, $2E, 3, 4, $FF
                                        ; DATA XREF: ROM:0001F32A   o
byte_1FB3A:     dc.b    $1E, $23, $1A, $F, $2E, 3, 5, $FF
                                        ; DATA XREF: ROM:0001F32E   o
byte_1FB42:     dc.b    $1E, $23, $1A, $F, $2E, 3, 6, $FF
                                        ; DATA XREF: ROM:0001F332   o
byte_1FB4A:     dc.b    $1E, $23, $1A, $F, $2E, 3, 7, $FF
                                        ; DATA XREF: ROM:0001F336   o
byte_1FB52:     dc.b    $F, $22, $13, $1E, $FF
                                        ; DATA XREF: UI_RenderSoundText:loc_1F710   o
byte_1FB57:     dc.b    $D, $19, $18, $1E, $1C, $19, $16, 0, $1E, $F, $1D, $1E, $FF
                                        ; DATA XREF: ROM:stru_1F424   o
byte_1FB64:     dc.b    $21, $F, $B, $1A, $19, $18, 0, $1D, $F, $16, $F, $D, $1E, 0, $2E, 0
                                        ; DATA XREF: ROM:0001F42C   o
                dc.b    $E0, $E1, $FF
byte_1FB77:     dc.b    $1D, $12, $19, $1E, 0, $2E, 0, $E2, $E3, $FF
                                        ; DATA XREF: ROM:0001F434   o
byte_1FB81:     dc.b    $14, $1F, $17, $1A, 0, $2E, 0, $E4, $E5, $FF
                                        ; DATA XREF: ROM:0001F43C   o
byte_1FB8B:     dc.b    $1D, $12, $19, $19, $1E, 0, $17, $19, $E, $F, 0, $D, $12, $B, $18, $11
                                        ; DATA XREF: ROM:0001F444   o
                dc.b    $F, 0, $2E, 0, $E6, $E7, 0, $E8, 0, $E0, $E1, $FF
byte_1FBA7:     dc.b    $24, $F, $1C, $19, 0, $1E, $F, $16, $F, $1A, $19, $1C, $1E, 0, $2E, 0
                                        ; DATA XREF: ROM:0001F44C   o
                dc.b    $E6, $E7, 0, $E8, 0, $E4, $E5, $FF
byte_1FBBF:     dc.b    $D, $19, $1F, $18, $1E, $F, $1C, 0, $10, $19, $1C, $D, $F, 0, $2E, 0
                                        ; DATA XREF: ROM:0001F454   o
                dc.b    $E2, $E3, 0, $E8, 0, $E2, $E3, $FF
byte_1FBD7:     dc.b    $12, $19, $20, $F, $1C, $13, $18, $11, 0, $2E, 0, $14, $1F, $17, $1A, 0
                                        ; DATA XREF: ROM:0001F45C   o
                dc.b    $E8, 0, $E4, $E5, $FF

; Checks if player pressed button to skip results
