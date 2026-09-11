UI_RenderHUDElement2:                                   ; CODE XREF: UI_RenderHUDElement1+108   p  ; was: sub_12E50
                movea.w #(byte_FF8510-M68K_RAM),a0
                movea.w a0,a3
                move.w  (WeaponSlotOffset).w,d0
                addi.w  #-$5DA0,d0
                movea.w d0,a2
                btst    #5,(ControlLayoutFlags).w
                beq.s   loc_12E7A
                move.w  #$C7E2,d0
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                bra.w   loc_12F2C
; ---------------------------------------------------------------------------
loc_12E7A:                                              ; CODE XREF: UI_RenderHUDElement2+16   j
                btst    #1,(ControlLayoutFlags).w
                beq.s   loc_12EB6
                move.w  #$C7B4,d5
                move.w  (a2),d0
                asl.w   #1,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w   Scroll_ShipScrollPattern
                move.w  #$C7E0,(a0)+
                move.w  8(a2),d0
                asl.w   #1,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w   Scroll_ShipScrollPattern
                bra.s   loc_12EEE
; ---------------------------------------------------------------------------
loc_12EB6:                                              ; CODE XREF: UI_RenderHUDElement2+30   j
                move.w  #$FA,d1
                move.w  8(a2),d0
                lea     word_12F86(pc),a1
                nop
loc_12EC4:                                              ; CODE XREF: UI_RenderHUDElement2+7A   j
                sub.w   d1,d0
                bmi.s   loc_12ECC
                move.w  (a1)+,(a0)+
                bra.s   loc_12EC4
; ---------------------------------------------------------------------------
loc_12ECC:                                              ; CODE XREF: UI_RenderHUDElement2+76   j
                move.w  (a2),d0
                beq.s   loc_12EEE
                addi.w  #$7C,d0                         ; '|'
                lea     word_12F66(pc),a1
                nop
loc_12EDA:                                              ; CODE XREF: UI_RenderHUDElement2+90   j
                sub.w   d1,d0
                bmi.s   loc_12EE2
                move.w  (a1)+,(a3)+
                bra.s   loc_12EDA
; ---------------------------------------------------------------------------
loc_12EE2:                                              ; CODE XREF: UI_RenderHUDElement2+8C   j
                cmpi.w  #$FF83,d0
                bmi.s   loc_12EEE
                move.w  (a1)+,d1
                addq.w  #1,d1
                move.w  d1,(a3)+
loc_12EEE:                                              ; CODE XREF: UI_RenderHUDElement2+64   j
                                        ; UI_RenderHUDElement2+7E   j
                subq.w  #1,(word_FF809A).w
                bpl.s   loc_12EFC
                move.w  #$FFFF,(word_FF809A).w
                bra.s   loc_12F2C
; ---------------------------------------------------------------------------
loc_12EFC:                                              ; CODE XREF: UI_RenderHUDElement2+A2   j
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
loc_12F2C:                                              ; CODE XREF: UI_RenderHUDElement2+26   j
                                        ; UI_RenderHUDElement2+AA   j
                move.w  #$8538,d7
                sub.w   a0,d7
                lsr.w   #1,d7
                subq.w  #1,d7
                bmi.s   UI_QueueHUDVRAMCommand
                move.w  #$C7F8,d0
loc_12F3C:                                              ; CODE XREF: UI_RenderHUDElement2+EE   j
                move.w  d0,(a0)+
                dbf     d7,loc_12F3C
; Queues VRAM command for HUD element rendering
UI_QueueHUDVRAMCommand:                                 ; CODE XREF: UI_RenderHUDElement2+E6   j  ; was: loc_12F42
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
word_12F66:     dc.w    $C7D4, $C7D4, $C7D4, $C7D4, $C7D6, $C7D6, $C7D6, $C7D6
                                        ; DATA XREF: UI_RenderHUDElement2+84   o
                dc.w    $C7D6, $C7D6, $C7D6, $C7D6, $C7D6, $C7D6, $C7D6, $C7D6
word_12F86:     dc.w    $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2
                                        ; DATA XREF: UI_RenderHUDElement2+6E   o
                dc.w    $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2, $C7C2
word_12FA6:     dc.w    5, $1015, $2025, $3035, $4045, $5055, $6065, $7075, $8085, $9095, $9900
                                        ; DATA XREF: UI_RenderHUDElement2+B6   o

; Renders HUD element variant 3
UI_RenderHUDElement3:                                   ; CODE XREF: UI_RenderHUDElement1+104   j  ; was: sub_12FBC
                movea.w #(byte_FF85A8-M68K_RAM),a0
                bra.s   loc_12FD2
; ---------------------------------------------------------------------------
loc_12FC2:                                              ; CODE XREF: UI_RenderHUDElement3+42   j
                move.w  #$C7F8,d0
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                bra.s   loc_13032
; ---------------------------------------------------------------------------
loc_12FD2:                                              ; CODE XREF: UI_RenderHUDElement3+4   j
                tst.b   (StageTimeRemaining).w
                bne.s   loc_13000
                cmpi.b  #$30,(StageTimeRemaining+1).w   ; '0'
                bpl.s   loc_13000
                btst    #0,(byte_FFA272).w
                bne.s   loc_13000
                subq.w  #1,(word_FF8306).w
                bpl.s   loc_13000
                move.w  #$26,(word_FF8306).w            ; '&'
                move.b  #$40,d0                         ; '@'
                jsr     (Sound_PlaySFX).l
                bra.s   loc_12FC2
; ---------------------------------------------------------------------------
loc_13000:                                              ; CODE XREF: UI_RenderHUDElement3+1A   j
                                        ; UI_RenderHUDElement3+22   j
                move.w  #$C7F8,(a0)+
                move.b  (StageTimeRemaining).w,d0
                andi.w  #$F,d0
                addi.w  #-$384C,d0
                move.w  d0,(a0)+
                move.w  #$C7C1,(a0)+
                move.b  (StageTimeRemaining+1).w,d0
                move.b  d0,d1
                lsr.b   #4,d0
                andi.w  #$F,d0
                addi.w  #-$384C,d0
                move.w  d0,(a0)+
                andi.w  #$F,d1
                addi.w  #-$384C,d1
                move.w  d1,(a0)+
loc_13032:                                              ; CODE XREF: UI_RenderHUDElement3+14   j
                movea.w #(byte_FF8570-M68K_RAM),a0
                btst    #3,(ControlLayoutFlags).w
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
loc_13056:                                              ; CODE XREF: UI_RenderHUDElement3+80   j
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
loc_13074:                                              ; CODE XREF: UI_RenderHUDElement3+A8   j
                cmpi.w  #$100,d0
                bpl.s   loc_13082
loc_1307A:                                              ; CODE XREF: UI_RenderHUDElement3+AE   j
                move.w  (word_FF8200).w,(word_FF8206).w
                bra.s   loc_13088
; ---------------------------------------------------------------------------
loc_13082:                                              ; CODE XREF: UI_RenderHUDElement3+BC   j
                subi.w  #$100,(word_FF8206).w
loc_13088:                                              ; CODE XREF: UI_RenderHUDElement3+9E   j
                                        ; UI_RenderHUDElement3+B6   j
                tst.w   (word_FF829E).w
                bne.w   Scroll_UpdateShipScroll
                btst    #2,(ControlLayoutFlags).w
                beq.s   loc_130E2
                move.w  #$C7B4,d5
                move.w  (word_FF8206).w,d0
                asr.w   #2,d0
                andi.w  #$FFFE,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w   Scroll_ShipScrollPattern
                move.w  #$C7E0,(a0)+
                move.w  (word_FF8202).w,d0
                asr.w   #2,d0
                andi.w  #$FFFE,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w   Scroll_ShipScrollPattern
                moveq   #$12,d7
                move.w  #$C7F8,d0
loc_130DA:                                              ; CODE XREF: UI_RenderHUDElement3+120   j
                move.w  d0,(a0)+
                dbf     d7,loc_130DA
                bra.s   loc_1311E
; ---------------------------------------------------------------------------
loc_130E2:                                              ; CODE XREF: UI_RenderHUDElement3+DA   j
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
loc_13106:                                              ; CODE XREF: UI_RenderHUDElement3+14C   j
                move.w  d2,(a0)+
                dbf     d0,loc_13106
loc_1310C:                                              ; CODE XREF: UI_RenderHUDElement3+144   j
                move.w  d1,(a0)+
                subq.w  #1,d7
loc_13110:                                              ; CODE XREF: UI_RenderHUDElement3+12E   j
                subq.w  #1,d7
                bmi.s   loc_1311E
                move.w  #$C7C3,d0
loc_13118:                                              ; CODE XREF: UI_RenderHUDElement3+96   j
                                        ; UI_RenderHUDElement3+15E   j
                move.w  d0,(a0)+
                dbf     d7,loc_13118
loc_1311E:                                              ; CODE XREF: UI_RenderHUDElement3+124   j
                                        ; UI_RenderHUDElement3+156   j
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
Scroll_UpdateShipScroll:                                ; CODE XREF: UI_RenderHUDElement3+D0   j  ; was: sub_13142
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
                bsr.w   Scroll_ShipScrollPattern
                moveq   #$16,d7
loc_1316C:                                              ; CODE XREF: Scroll_UpdateShipScroll+8   j
                move.w  #$C7F8,d0
loc_13170:                                              ; CODE XREF: Scroll_UpdateShipScroll+30   j
                move.w  d0,(a0)+
                dbf     d7,loc_13170
                bra.s   loc_1311E
; End of function Scroll_UpdateShipScroll
; Processes multiple palette slots
Gfx_ProcessPaletteSlots:                                ; CODE XREF: MessageSequence_FinishScript+C   j  ; was: sub_13178
                                        ; Stage_LoadXiTigerGraphics+34   p
                move.w  (WeaponSlotOffset).w,(dword_FF8040).w
                clr.w   (WeaponSlotOffset).w
                moveq   #3,d7
; Processes each of 4 palette slots in sequence
Gfx_ProcessPaletteSlotsLoop:                            ; CODE XREF: Gfx_ProcessPaletteSlots+12   j  ; was: loc_13184
                bsr.s   Gfx_LoadPaletteData
                addq.w  #2,(WeaponSlotOffset).w
                dbf     d7,Gfx_ProcessPaletteSlotsLoop
                move.w  (dword_FF8040).w,(WeaponSlotOffset).w
                rts
; End of function Gfx_ProcessPaletteSlots
; ---------------------------------------------------------------------------
word_13196:     dc.w    $50B8, $50BE, $50C4, $50CA
                                        ; DATA XREF: Gfx_LoadPaletteData+4   r

; Loads palette data from offset table
Gfx_LoadPaletteData:                                    ; CODE XREF: Gfx_ProcessPaletteSlots:loc_13184   p  ; was: sub_1319E
                                        ; UI_InitializeStageStart+EC   p
                move.w  (WeaponSlotOffset).w,d0
                move.w  word_13196(pc,d0.w),d3
                movea.w d0,a0
                adda.w  #$A250,a0
                move.w  (a0),d0
; End of function Gfx_LoadPaletteData
; Sets up VDP registers for sprite tiles
Sprite_SetupTileVDP:                                    ; CODE XREF: WeaponSetup_InitializeTextAndTiles+20   p  ; was: sub_131AE
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
                bsr.s   Gfx_SetupTileDMA
                addq.w  #2,d3
                bsr.s   Gfx_SetupTileDMA
                move.w  a1,(word_FFF70C).w
                rts
; End of function Sprite_SetupTileVDP
; Sets up DMA for tile transfer
Gfx_SetupTileDMA:                                       ; CODE XREF: Sprite_SetupTileVDP+1C   p  ; was: sub_131D6
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
                asl.w   #1,d0                           ; was: sub_13206
                move.w  (a4,d0.w),(a1)
; End of function Data_CopyIndexedWord
; Ship scroll movement pattern
Scroll_ShipScrollPattern:                               ; CODE XREF: UI_RenderHUDElement1+1E4   p  ; was: sub_1320C
                                        ; UI_RenderHUDElement1+202   p
                moveq   #0,d1
loc_1320E:                                              ; CODE XREF: Scroll_ShipScrollPattern+34   j
                move.b  (a1),d0
                lsr.b   #4,d0
                andi.w  #$F,d0
                bne.s   loc_13222
                tst.w   d1
                bne.s   loc_13222
                move.w  #$C7BE,d0
                bra.s   loc_13226
; ---------------------------------------------------------------------------
loc_13222:                                              ; CODE XREF: Scroll_ShipScrollPattern+A   j
                                        ; Scroll_ShipScrollPattern+E   j
                addq.w  #1,d1
                add.w   d5,d0
loc_13226:                                              ; CODE XREF: Scroll_ShipScrollPattern+14   j
                move.w  d0,(a0)+
                move.b  (a1)+,d0
                andi.w  #$F,d0
                bne.s   loc_1323A
                tst.w   d1
                bne.s   loc_1323A
                move.w  #$C7BE,d0
                bra.s   loc_1323E
; ---------------------------------------------------------------------------
loc_1323A:                                              ; CODE XREF: Scroll_ShipScrollPattern+22   j
                                        ; Scroll_ShipScrollPattern+26   j
                addq.w  #1,d1
                add.w   d5,d0
loc_1323E:                                              ; CODE XREF: Scroll_ShipScrollPattern+2C   j
                move.w  d0,(a0)+
                dbf     d7,loc_1320E
                rts
; End of function Scroll_ShipScrollPattern
; Renders ship health display with scroll pattern
UI_RenderShipHealthDisplay:                             ; CODE XREF: UI_RenderHUDElement1+122   j  ; was: sub_13246
                movea.w #(byte_FF84B0-M68K_RAM),a0
                move.w  #$C7F4,(a0)+
                move.w  #$C7F5,(a0)+
                move.w  #$C7F6,(a0)+
                move.w  #$C7F7,(a0)+
                move.w  #$C7BF,(a0)+
                move.w  #$C7B4,d5
                movea.w #(dword_FFA212-M68K_RAM),a1
                moveq   #3,d7
                bsr.w   Scroll_ShipScrollPattern
                move.w  #$C7D2,(a0)+
                move.w  #$C7D3,(a0)+
                bra.w   loc_12E16
; End of function UI_RenderShipHealthDisplay
; Applies friction to velocity reducing speed
