Sys_InitVDPRegisters:                                   ; CODE XREF: Sys_VBlankHandler+24   p  ; was: sub_29E2E
                move.w  (word_FF8090).w,d0
                movea.w off_29E3E(pc,d0.w),a0
                adda.l  #Sys_InitXiTigerVRAM,a0
                jmp     (a0)
; End of function Sys_InitVDPRegisters
; ---------------------------------------------------------------------------
off_29E3E:      dc.w    locret_29F5A-Sys_InitXiTigerVRAM
                                        ; DATA XREF: Sys_InitVDPRegisters+4   r
                dc.w    Sys_InitXiTigerVRAM-Sys_InitXiTigerVRAM
                dc.w    Sys_LoadInitialPalette-Sys_InitXiTigerVRAM
                dc.w    Sys_InitializeVRAMLayout3-Sys_InitXiTigerVRAM
                dc.w    Sys_InitFliesVRAM-Sys_InitXiTigerVRAM
                dc.w    Sys_CopyStateValue-Sys_InitXiTigerVRAM
                dc.w    Sys_InitFlyingNeoVRAM-Sys_InitXiTigerVRAM
                dc.w    Sys_SetupScrollVRAM-Sys_InitXiTigerVRAM
                dc.w    Sys_InitializeVRAMLayout7-Sys_InitXiTigerVRAM
                dc.w    Gfx_SetupVRAMLayout2-Sys_InitXiTigerVRAM
                dc.w    Gfx_SetupVRAMLayout1-Sys_InitXiTigerVRAM
                dc.w    Boss_DestroyerProtoVRAMSetup-Sys_InitXiTigerVRAM
                dc.w    Boss_ZLeoCopySprites-Sys_InitXiTigerVRAM

; Initializes VRAM layout for Xi-Tiger cutscene
Sys_InitXiTigerVRAM:                                    ; DATA XREF: Sys_InitVDPRegisters+8   o  ; was: sub_29E58
                                        ; ROM:off_29E3E   o
                movea.w #(CutsceneLineOffsetTable-M68K_RAM),a2
                movea.w #(word_FF9FC0-M68K_RAM),a3
                moveq   #0,d7
                bra.w   Sys_SetupVRAMLayout
; End of function Sys_InitXiTigerVRAM
; Loads initial palette from ROM
Sys_LoadInitialPalette:                                 ; DATA XREF: ROM:00029E42   o  ; was: sub_29E66
                movea.w #(word_FF9500-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #3,d7
                bsr.w   Sys_SetupVRAMLayout
                movea.w #(word_FF9600-M68K_RAM),a2
                movea.w #(byte_FFE40A-M68K_RAM),a3
                moveq   #$D,d7
                bra.w   Sys_ClearVRAMRange
; End of function Sys_LoadInitialPalette
; Sets up VRAM layout for first graphics configuration
Gfx_SetupVRAMLayout1:                                   ; DATA XREF: ROM:00029E52   o  ; was: sub_29E82
                movea.w #(word_FF9500-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #1,d7
                bsr.w   Sys_SetupVRAMLayout
                movea.w #(word_FF9600-M68K_RAM),a2
                movea.w #(byte_FFE412-M68K_RAM),a3
                moveq   #$D,d7
                bra.w   Gfx_CopyRowsRepeated
; End of function Gfx_SetupVRAMLayout1
; Initializes VRAM layout with mode 7 and plane addresses
Sys_InitializeVRAMLayout7:                              ; DATA XREF: ROM:00029E4E   o  ; was: sub_29E9E
                movea.w #(word_FF9C00-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #7,d7
                bra.w   Sys_SetupVRAMLayout
; End of function Sys_InitializeVRAMLayout7
; Initializes VRAM layout with mode 3 and plane addresses
Sys_InitializeVRAMLayout3:                              ; DATA XREF: ROM:00029E44   o  ; was: sub_29EAC
                movea.w #(word_FF9C00-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #3,d7
                bra.w   Sys_SetupVRAMLayout
; End of function Sys_InitializeVRAMLayout3
; Initializes VRAM layout for flies stage
Sys_InitFliesVRAM:                                      ; DATA XREF: ROM:00029E46   o  ; was: sub_29EBA
                movea.w #(word_FF9C00-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #1,d7
                bra.w   Sys_SetupVRAMLayout
; End of function Sys_InitFliesVRAM
; Copies system state value from backup to active register
Sys_CopyStateValue:                                     ; DATA XREF: ROM:00029E48   o  ; was: sub_29EC8
                move.w  (word_FF9E02).w,(word_FF9E00).w
                rts
; End of function Sys_CopyStateValue
; Initializes VRAM layout for Flying-Neo boss
Sys_InitFlyingNeoVRAM:                                  ; DATA XREF: ROM:00029E4A   o  ; was: sub_29ED0
                movea.w #(word_FF9500-M68K_RAM),a2
                movea.w #(word_FF9E00-M68K_RAM),a3
                moveq   #0,d7
                bra.w   Sys_SetupVRAMLayout
; End of function Sys_InitFlyingNeoVRAM
; Sets up VRAM layout with scroll buffer pointers for stage
Sys_SetupScrollVRAM:                                    ; DATA XREF: ROM:00029E4C   o  ; was: sub_29EDE
                movea.w #(byte_FF9520-M68K_RAM),a2
                movea.w #(byte_FF9E1E-M68K_RAM),a3
                moveq   #2,d7
                bra.w   Sys_SetupVRAMLayout
; End of function Sys_SetupScrollVRAM
; Sets up VRAM layout for second graphics configuration
Gfx_SetupVRAMLayout2:                                   ; DATA XREF: ROM:00029E50   o  ; was: sub_29EEC
                movea.w #(dword_FF9A00-M68K_RAM),a2
                movea.w #(word_FF9C00-M68K_RAM),a3
                moveq   #6,d7
                bsr.w   Sys_SetupVRAMLayout
                movea.w #(byte_FF9000-M68K_RAM),a2
                movea.w #(HScrollBuffer-M68K_RAM),a3
                moveq   #$D,d7
                bra.w   Sys_SetupVRAMLayout
; End of function Gfx_SetupVRAMLayout2
; VRAM setup handler
Boss_DestroyerProtoVRAMSetup:                           ; DATA XREF: ROM:00029E54   o  ; was: sub_29F08
                movea.w #(dword_FF9A00-M68K_RAM),a2
                movea.w #(word_FF9C00-M68K_RAM),a3
                moveq   #3,d7
                bsr.w   Sys_SetupVRAMLayout
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(HScrollBuffer-M68K_RAM),a3
                moveq   #$D,d7
                bra.w   Sys_ClearVRAMRange
; End of function Boss_DestroyerProtoVRAMSetup
; Copy sprite data
Boss_ZLeoCopySprites:                                   ; DATA XREF: ROM:00029E56   o  ; was: sub_29F24
                movea.w #(word_FF9E00-M68K_RAM),a0
                movea.w #(word_FF9E40-M68K_RAM),a1
                moveq   #7,d7
loc_29F2E:                                              ; CODE XREF: Boss_ZLeoCopySprites+C   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_29F2E
                rts
; End of function Boss_ZLeoCopySprites
; Sets up VRAM layout and plane mappings
Sys_SetupVRAMLayout:                                    ; CODE XREF: Sys_InitXiTigerVRAM+A   j  ; was: sub_29F36
                                        ; Sys_LoadInitialPalette+A   p
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                dbf     d7,Sys_SetupVRAMLayout
locret_29F5A:                                           ; DATA XREF: ROM:off_29E3E   o
                rts
; End of function Sys_SetupVRAMLayout
; Copies rows of data to interleaved destination offsets
Gfx_CopyRowsInterleaved:                                ; CODE XREF: Gfx_CopyRowsInterleaved+42   j  ; was: sub_29F5C
                move.w  (a2)+,(a3)
                move.w  (a2)+,4(a3)
                move.w  (a2)+,8(a3)
                move.w  (a2)+,$C(a3)
                move.w  (a2)+,$10(a3)
                move.w  (a2)+,$14(a3)
                move.w  (a2)+,$18(a3)
                move.w  (a2)+,$1C(a3)
                move.w  (a2)+,$20(a3)
                move.w  (a2)+,$24(a3)
                move.w  (a2)+,$28(a3)
                move.w  (a2)+,$2C(a3)
                move.w  (a2)+,$30(a3)
                move.w  (a2)+,$34(a3)
                move.w  (a2)+,$38(a3)
                move.w  (a2)+,$3C(a3)
                lea     $40(a3),a3
                dbf     d7,Gfx_CopyRowsInterleaved
                rts
; End of function Gfx_CopyRowsInterleaved
; Copies rows with each value repeated 4 times
Gfx_CopyRowsRepeated:                                   ; CODE XREF: Gfx_SetupVRAMLayout1+18   j  ; was: sub_29FA4
                                        ; Gfx_CopyRowsRepeated+4A   j
                move.w  (a2)+,d0
                move.w  d0,(a3)
                move.w  d0,4(a3)
                move.w  d0,8(a3)
                move.w  d0,$C(a3)
                move.w  (a2)+,d0
                move.w  d0,$10(a3)
                move.w  d0,$14(a3)
                move.w  d0,$18(a3)
                move.w  d0,$1C(a3)
                move.w  (a2)+,d0
                move.w  d0,$20(a3)
                move.w  d0,$24(a3)
                move.w  d0,$28(a3)
                move.w  d0,$2C(a3)
                move.w  (a2)+,d0
                move.w  d0,$30(a3)
                move.w  d0,$34(a3)
                move.w  d0,$38(a3)
                move.w  d0,$3C(a3)
                lea     $40(a3),a3
                dbf     d7,Gfx_CopyRowsRepeated
                rts
; End of function Gfx_CopyRowsRepeated
; Clears specified VRAM address range
Sys_ClearVRAMRange:                                     ; CODE XREF: Sys_LoadInitialPalette+18   j  ; was: sub_29FF4
                                        ; Boss_DestroyerProtoVRAMSetup+18   j
                move.w  (a2),(a3)
                move.w  (a2)+,4(a3)
                move.w  (a2),8(a3)
                move.w  (a2)+,$C(a3)
                move.w  (a2),$10(a3)
                move.w  (a2)+,$14(a3)
                move.w  (a2),$18(a3)
                move.w  (a2)+,$1C(a3)
                move.w  (a2),$20(a3)
                move.w  (a2)+,$24(a3)
                move.w  (a2),$28(a3)
                move.w  (a2)+,$2C(a3)
                move.w  (a2),$30(a3)
                move.w  (a2)+,$34(a3)
                move.w  (a2),$38(a3)
                move.w  (a2)+,$3C(a3)
                lea     $40(a3),a3
                dbf     d7,Sys_ClearVRAMRange
                rts
; End of function Sys_ClearVRAMRange
; Copies projectile data from source to Valkirie weapon object
