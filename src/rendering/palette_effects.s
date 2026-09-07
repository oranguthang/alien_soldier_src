Gfx_PrimaryEffectDispatcher:                            ; CODE XREF: Sys_GameplayMainLoop+76   p  ; was: sub_4094
                tst.b   (byte_FF813E).w
                bpl.s   Gfx_DispatchPrimaryEffect
                rts
; ---------------------------------------------------------------------------
; Dispatches the primary graphics effect selected by stage configuration
Gfx_DispatchPrimaryEffect:                              ; CODE XREF: Gfx_PrimaryEffectDispatcher+4   j  ; was: loc_409C
                move.w  (word_FF8220).w,d0
                movea.w Gfx_PrimaryEffectHandlers(pc,d0.w),a0
                adda.l  #Gfx_UpdatePaletteState,a0
                jmp     (a0)
; End of function Gfx_PrimaryEffectDispatcher
; ---------------------------------------------------------------------------
Gfx_PrimaryEffectHandlers:  dc.w    locret_410A-Gfx_UpdatePaletteState  ; was: off_40AC
                dc.w    Gfx_UpdatePaletteState-Gfx_UpdatePaletteState
                dc.w    Gfx_PaletteState_Calculate-Gfx_UpdatePaletteState
                dc.w    Stage_SetScrollOffset-Gfx_UpdatePaletteState
                dc.w    Scroll_AnimateOffset-Gfx_UpdatePaletteState
                dc.w    Gfx_Epsilon1UpdatePalette-Gfx_UpdatePaletteState
                dc.w    Gfx_UpdateStage14Palette-Gfx_UpdatePaletteState
                dc.w    Boss_ShieldViperLoadTiles-Gfx_UpdatePaletteState
                dc.w    Gfx_UpdateSega3Palette-Gfx_UpdatePaletteState
                dc.w    Boss_WolfGaropaLoadTiles-Gfx_UpdatePaletteState

; Updates palette state and positions
Gfx_UpdatePaletteState:                                 ; DATA XREF: Gfx_PrimaryEffectDispatcher+10   o  ; was: sub_40C0
                                        ; ROM:Gfx_PrimaryEffectHandlers   o
                move.w  #$8CE,d0
                move.w  #$6AE,d1
                btst    #0,(word_FFA000+1).w
                bne.s   loc_40D8
                move.w  #$8E,d0
                move.w  #$4E,d1                         ; 'N'
loc_40D8:                                               ; CODE XREF: Gfx_UpdatePaletteState+E   j
                movea.w #(word_FFE31C-M68K_RAM),a0
                move.w  d0,$80(a0)
                move.w  d0,(a0)+
                move.w  d1,$80(a0)
                move.w  d1,(a0)+
; Calculates palette index based on game state flags
Gfx_PaletteState_Calculate:                             ; DATA XREF: ROM:000040B0   o  ; was: loc_40E8
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #$E,d0
                move.w  word_410C(pc,d0.w),d0
                btst    #1,(word_FFA000+1).w
                bne.s   Gfx_SetPlayerPaletteIndex
                subq.w  #2,d0
; Sets player palette index based on game state flags and player direction bit
Gfx_SetPlayerPaletteIndex:                              ; CODE XREF: Gfx_UpdatePaletteState+3C   j  ; was: loc_4100
                movea.w #(word_FFE33E-M68K_RAM),a0
                move.w  d0,(a0)
                move.w  d0,$80(a0)
locret_410A:                                            ; DATA XREF: ROM:Gfx_PrimaryEffectHandlers   o
                                        ; ROM:Gfx_SecondaryEffectHandlers   o
                rts
; End of function Gfx_UpdatePaletteState
; ---------------------------------------------------------------------------
word_410C:      dc.w    2, 4, 6, 8, $A, $C, $2E, $26E

; Sets stage-specific scroll offset value based on frame counter
Stage_SetScrollOffset:                                  ; DATA XREF: ROM:000040B2   o  ; was: sub_411C
                move.w  #$480,d0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_412C
                move.w  #$4C0,d0
loc_412C:                                               ; CODE XREF: Stage_SetScrollOffset+A   j
                move.w  d0,(word_FFE30C).w
                rts
; End of function Stage_SetScrollOffset
; Animates scroll offset with timer countdown
Scroll_AnimateOffset:                                   ; DATA XREF: ROM:000040B4   o  ; was: sub_4132
                move.w  (word_FFA000).w,d0
                asl.w   #2,d0
                andi.w  #4,d0
                subq.w  #1,(word_FF8218).w
                bpl.s   loc_4148
                clr.w   (word_FF8220).w
                moveq   #0,d0
loc_4148:                                               ; CODE XREF: Scroll_AnimateOffset+E   j
                move.w  word_4156(pc,d0.w),(word_FFE314).w
                move.w  word_4156+2(pc,d0.w),(word_FFE316).w
                rts
; End of function Scroll_AnimateOffset
; ---------------------------------------------------------------------------
word_4156:      dc.w    $E60, $E80, $EA0, $EC0

; Updates palette colors
Gfx_Epsilon1UpdatePalette:                              ; DATA XREF: ROM:000040B6   o  ; was: sub_415E
                lea     word_4190(pc),a0
                nop
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4172
                lea     word_419C(pc),a0
                nop
loc_4172:                                               ; CODE XREF: Gfx_Epsilon1UpdatePalette+C   j
                movea.w #(word_FFE320-M68K_RAM),a1
                move.w  (a0)+,$A(a1)
                move.w  (a0)+,$C(a1)
                move.w  (a0)+,$E(a1)
                move.w  (a0)+,$10(a1)
                move.w  (a0)+,$14(a1)
                move.w  (a0)+,$16(a1)
                rts
; End of function Gfx_Epsilon1UpdatePalette
; ---------------------------------------------------------------------------
word_4190:      dc.w    $A22, $C44, $E86, $ECA, 0, $44
                                        ; DATA XREF: Gfx_Epsilon1UpdatePalette   o
word_419C:      dc.w    $C22, $E44, $EA6, $EEC, $46, 0
                                        ; DATA XREF: Gfx_Epsilon1UpdatePalette+E   o

; Updates Stage 14 palette effects
Gfx_UpdateStage14Palette:                               ; CODE XREF: Gfx_Stage14PaletteMain+4   j  ; was: sub_41A8
                                        ; Gfx_PaletteFadeEffect+1A   j
                                        ; DATA XREF:
                move.w  (word_FFA000).w,d0
                movea.w #(word_FFE300-M68K_RAM),a0
                movea.w #(word_FFE380-M68K_RAM),a1
                move.w  (word_FF8218).w,d3
                move.w  d0,d1
                asr.w   #1,d1
                andi.w  #$E,d1
                move.w  d0,d2
                asr.w   #2,d2
                andi.w  #$E,d2
                btst    #2,d3
                bne.s   loc_4204
                move.w  word_423C(pc,d2.w),$3C(a0)
                move.w  word_423C(pc,d2.w),$3C(a1)
                asl.w   #1,d0
                andi.w  #2,d0
                move.w  word_424C(pc,d0.w),$28(a0)
                move.w  word_424C(pc,d0.w),$28(a1)
                move.w  word_4250(pc,d0.w),$2A(a0)
                move.w  word_4250(pc,d0.w),$2A(a1)
                move.w  word_4254(pc,d0.w),$2C(a0)
                move.w  word_4254(pc,d0.w),$2C(a1)
loc_4204:                                               ; CODE XREF: Gfx_UpdateStage14Palette+24   j
                btst    #1,d3
                bne.s   locret_422A
                btst    #0,d3
                beq.s   loc_421E
                move.w  word_422C(pc,d1.w),$1C(a0)
                move.w  word_422C(pc,d1.w),$1C(a1)
                rts
; ---------------------------------------------------------------------------
loc_421E:                                               ; CODE XREF: Gfx_UpdateStage14Palette+66   j
                move.w  word_422C(pc,d1.w),$1A(a0)
                move.w  word_422C(pc,d1.w),$1A(a1)
locret_422A:                                            ; CODE XREF: Gfx_UpdateStage14Palette+60   j
                rts
; End of function Gfx_UpdateStage14Palette
; ---------------------------------------------------------------------------
word_422C:      dc.w    0, 4, 8, $C, $A, 8, 6, 2
word_423C:      dc.w    $28E, $4A, 6, 2, 4, 8, $C, $E
word_424C:      dc.w    $600, $C00
word_4250:      dc.w    $ECA, $EEC
word_4254:      dc.w    $202, $200

; Loads boss tiles
Boss_ShieldViperLoadTiles:                              ; DATA XREF: ROM:000040BA   o  ; was: sub_4258
                movea.w #(word_FFE302-M68K_RAM),a0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4284
                move.w  #$200,(a0)+
                addq.w  #8,a0
                move.w  #$CEE,(a0)+
                move.w  #$CCA,(a0)+
                move.w  #$C88,(a0)+
                move.w  #$A62,(a0)+
                move.w  #$820,(a0)+
                move.w  #$600,(a0)+
                rts
; ---------------------------------------------------------------------------
loc_4284:                                               ; CODE XREF: Boss_ShieldViperLoadTiles+A   j
                move.w  $80(a0),(a0)+
                addq.w  #8,a0
                move.w  $80(a0),(a0)+
                move.w  $80(a0),(a0)+
                move.w  $80(a0),(a0)+
                move.w  $80(a0),(a0)+
                move.w  $80(a0),(a0)+
                move.w  $80(a0),(a0)+
                rts
; End of function Boss_ShieldViperLoadTiles
; Loads boss tiles
Boss_WolfGaropaLoadTiles:                               ; DATA XREF: ROM:000040BE   o  ; was: sub_42A4
                addi.w  #$10,(word_FFE33E).w
                andi.w  #$F0,(word_FFE33E).w
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #$1E,d0
                move.w  word_42C2(pc,d0.w),(word_FFE33C).w
                rts
; End of function Boss_WolfGaropaLoadTiles
; ---------------------------------------------------------------------------
word_42C2:      dc.w    0, 2, $24, $46, $68, $8A, $AC, $CE
                dc.w    $EC, $CA, $A8, $86, $64, $42, $20, 0

; Updates Sega screen palette based on state bit
Gfx_UpdateSega3Palette:                                 ; DATA XREF: ROM:000040BC   o  ; was: sub_42E2
                movea.w #(word_FFE300-M68K_RAM),a0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4302
                move.w  #$EEE,4(a0)
                move.w  #$800,$1C(a0)
                move.w  #$E64,$1E(a0)
                rts
; ---------------------------------------------------------------------------
loc_4302:                                               ; CODE XREF: Gfx_UpdateSega3Palette+A   j
                move.w  $84(a0),4(a0)
                move.w  $9C(a0),$1C(a0)
                move.w  $9E(a0),$1E(a0)
                rts
; End of function Gfx_UpdateSega3Palette
; Dispatches effect system handler based on current effect mode
Gfx_SecondaryEffectDispatcher:                          ; CODE XREF: Sys_GameplayMainLoop:loc_1C7B0   p  ; was: sub_4316
                tst.b   (byte_FF813E).w
                bpl.s   Gfx_DispatchSecondaryEffect
                rts
; ---------------------------------------------------------------------------
; Dispatches palette fade effects based on system state
Gfx_DispatchSecondaryEffect:                            ; CODE XREF: Gfx_SecondaryEffectDispatcher+4   j  ; was: loc_431E
                move.w  (word_FF8222).w,d0
                movea.w Gfx_SecondaryEffectHandlers(pc,d0.w),a0
                adda.l  #Palette_FadeEffect,a0
                jmp     (a0)
; End of function Gfx_SecondaryEffectDispatcher
; ---------------------------------------------------------------------------
Gfx_SecondaryEffectHandlers:    dc.w    locret_410A-Palette_FadeEffect  ; was: off_432E
                dc.w    Palette_FadeEffect-Palette_FadeEffect
                dc.w    Gfx_Stage14PaletteMain-Palette_FadeEffect
                dc.w    Gfx_PaletteFadeEffect-Palette_FadeEffect

; Palette fade effect system with RGB interpolation
Palette_FadeEffect:                                     ; DATA XREF: Gfx_SecondaryEffectDispatcher+10   o  ; was: sub_4336
                                        ; ROM:Gfx_SecondaryEffectHandlers   o
                movea.l (dword_FF821A).w,a2
                move.w  (word_FF8218).w,d0
                bsr.w   Gfx_FadeRGBColor
                move.w  (word_FF8218).w,d0
                neg.w   d0
                bsr.w   Gfx_FadeRGBColor
                btst    #0,(word_FFA000+1).w
                bne.s   locret_435E
                subq.w  #1,(word_FF8218).w
                bpl.s   locret_435E
                clr.w   (word_FF8222).w
locret_435E:                                            ; CODE XREF: Palette_FadeEffect+1C   j
                                        ; Palette_FadeEffect+22   j
                rts
; End of function Palette_FadeEffect
; Main Stage 14 palette handler
Gfx_Stage14PaletteMain:                                 ; DATA XREF: ROM:00004332   o  ; was: sub_4360
                bsr.w   Gfx_ApplyRGBColorAdjust
                bra.w   Gfx_UpdateStage14Palette
; End of function Gfx_Stage14PaletteMain
; Palette fade effect handler
Gfx_PaletteFadeEffect:                                  ; DATA XREF: ROM:00004334   o  ; was: sub_4368
                btst    #0,(word_FFA000+1).w
                bne.s   loc_437A
                addq.w  #1,(dword_FF8066+2).w
                bne.s   loc_437A
                clr.w   (word_FF8222).w
loc_437A:                                               ; CODE XREF: Gfx_PaletteFadeEffect+6   j
                                        ; Gfx_PaletteFadeEffect+C   j
                move.w  (dword_FF8066+2).w,d0
                jsr     Gfx_SetFadeParams(pc)           ; (pc)
                bra.w   Gfx_UpdateStage14Palette
; End of function Gfx_PaletteFadeEffect
; Update result numbers
