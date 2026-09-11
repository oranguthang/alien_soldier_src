Stage_LoadBackgroundGraphics:                           ; DATA XREF: Sys_DispatchGameState+62   o  ; was: sub_1C3FA
                tst.b   (word_FFF720).w
                bmi.s   locret_1C448
                cmpi.w  #4,(GameSubstateIndex).w
                beq.w   loc_1C4C2
                move.w  (GameSubstateIndex).w,d0
                bne.s   loc_1C44A
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                jsr     (Sys_InitGraphicsChain).l
                jsr     (Gfx_LoadVDPRegisters).l
                jsr     (Stage_StateDispatcher).l
                jsr     (Sys_InitStageState).l
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(word_FFA944).w
                move.w  (dword_FFA900).w,(word_FFA946).w
                move.w  (dword_FFA904).w,(word_FFA948).w
locret_1C448:                                           ; CODE XREF: Stage_LoadBackgroundGraphics+4   j
                                        ; Stage_LoadBackgroundGraphics+8E   j
                rts
; ---------------------------------------------------------------------------
loc_1C44A:                                              ; CODE XREF: Stage_LoadBackgroundGraphics+14   j
                move.w  (word_FF80AA).w,d0
                bne.s   loc_1C46A
                clr.w   (word_FFA946).w
                move.w  #$4000,(dword_FFA940).w
                jsr     (Sprite_SetupDMA).l
                jsr     (Sprite_SetupDMA).l
                bmi.s   loc_1C4AA
                rts
; ---------------------------------------------------------------------------
loc_1C46A:                                              ; CODE XREF: Stage_LoadBackgroundGraphics+54   j
                bpl.s   loc_1C48E
                andi.w  #$7FFF,d0
                lea     off_1C536(pc),a0
                nop
                move.l  -4(a0,d0.w),(dword_FFA940).w
                jsr     (Gfx_RenderLayeredBackground).l
                jsr     (Gfx_RenderLayeredBackground).l
                bpl.w   locret_1C448
                bra.s   loc_1C4AA
; ---------------------------------------------------------------------------
loc_1C48E:                                              ; CODE XREF: Stage_LoadBackgroundGraphics:loc_1C46A   j
                lea     off_1C536(pc),a0
                nop
                move.l  -4(a0,d0.w),(dword_FFA940).w
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                bpl.w   locret_1C448
loc_1C4AA:                                              ; CODE XREF: Stage_LoadBackgroundGraphics+6C   j
                                        ; Stage_LoadBackgroundGraphics+92   j
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(word_FFA944).w
                move.w  (dword_FFA908).w,(word_FFA946).w
                move.w  (dword_FFA90C).w,(word_FFA948).w
                rts
; ---------------------------------------------------------------------------
loc_1C4C2:                                              ; CODE XREF: Stage_LoadBackgroundGraphics+C   j
                move.w  (word_FF80AC).w,d0
                bne.s   loc_1C4E2
                clr.w   (word_FFA946).w
                move.w  #$6000,(dword_FFA940).w
                jsr     (Sprite_SetupDMA).l
                jsr     (Sprite_SetupDMA).l
                bmi.s   loc_1C4FE
                rts
; ---------------------------------------------------------------------------
loc_1C4E2:                                              ; CODE XREF: Stage_LoadBackgroundGraphics+CC   j
                lea     off_1C53E(pc),a0
                nop
                move.l  -4(a0,d0.w),(dword_FFA940).w
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                bpl.w   locret_1C448
loc_1C4FE:                                              ; CODE XREF: Stage_LoadBackgroundGraphics+E4   j
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                move.w  #$10,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                clr.b   (byte_FFF705).w
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
; Jumps to stage handler routine after setup completion
Stage_JumpToHandler:                                    ; DATA XREF: Stage_XiTigerHandler+88   r  ; was: loc_1C530
                jmp     Stage_DispatchSelectedProcess
; End of function Stage_LoadBackgroundGraphics
; ---------------------------------------------------------------------------
off_1C536:      dc.l    Gfx_TitleAndZLeoVRAMTransferParameters  ; DATA XREF: Stage_LoadBackgroundGraphics+76   o
                                        ; sub_1C3FA:loc_1C48E   o
off_1C53A:      dc.l    Gfx_DefaultVRAMTransferParameters  ; DATA XREF: Stage_XiTigerHandler+DA   r
off_1C53E:      dc.l    Gfx_FrontendAlternateVRAMTransferParameters  ; DATA XREF: Stage_LoadBackgroundGraphics:loc_1C4E2   o
                                        ; sub_1C546:loc_1C61C   o
                dc.l    Gfx_ScrollVRAMTransferParameters

; Xi Tiger stage initialization
Stage_XiTigerHandler:                                   ; DATA XREF: Sys_DispatchGameState+D6   o  ; was: sub_1C546
                tst.b   (word_FFF720).w
                bmi.s   locret_1C5A8
                cmpi.w  #4,(GameSubstateIndex).w
                beq.w   loc_1C5FC
                move.w  (GameSubstateIndex).w,d0
                bne.s   loc_1C5AA
                jsr     (Sys_InitGraphicsChain).l
                jsr     (Gfx_LoadVDPRegisters).l
                jsr     (Stage_LoadXiTigerGraphics).l
                move.w  #$8004,(word_FF80F2).w
                move.w  #$10,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(word_FFA944).w
                move.w  (dword_FFA900).w,(word_FFA946).w
                move.w  (dword_FFA904).w,(word_FFA948).w
locret_1C5A8:                                           ; CODE XREF: Stage_XiTigerHandler+4   j
                                        ; Stage_XiTigerHandler+9A   j
                rts
; ---------------------------------------------------------------------------
loc_1C5AA:                                              ; CODE XREF: Stage_XiTigerHandler+14   j
                move.w  (word_FF80AA).w,d0
                bne.s   loc_1C5CA
                clr.w   (word_FFA946).w
                move.w  #$4000,(dword_FFA940).w
                jsr     (Sprite_SetupDMA).l
                jsr     (Sprite_SetupDMA).l
                bmi.s   loc_1C5E4
                rts
; ---------------------------------------------------------------------------
loc_1C5CA:                                              ; CODE XREF: Stage_XiTigerHandler+68   j
                lea     off_1C536(pc),a0
                move.l  off_1C536-4-off_1C536(a0,d0.w),(dword_FFA940).w
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                bpl.w   locret_1C5A8
loc_1C5E4:                                              ; CODE XREF: Stage_XiTigerHandler+80   j
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(word_FFA944).w
                move.w  (dword_FFA908).w,(word_FFA946).w
                move.w  (dword_FFA90C).w,(word_FFA948).w
                rts
; ---------------------------------------------------------------------------
loc_1C5FC:                                              ; CODE XREF: Stage_XiTigerHandler+C   j
                move.w  (word_FF80AC).w,d0
                bne.s   loc_1C61C
                clr.w   (word_FFA946).w
                move.w  #$6000,(dword_FFA940).w
                jsr     (Sprite_SetupDMA).l
                jsr     (Sprite_SetupDMA).l
                bmi.s   loc_1C636
                rts
; ---------------------------------------------------------------------------
loc_1C61C:                                              ; CODE XREF: Stage_XiTigerHandler+BA   j
                lea     off_1C53E(pc),a0
                move.l  off_1C53A-off_1C53E(a0,d0.w),(dword_FFA940).w
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                bpl.w   locret_1C5A8
loc_1C636:                                              ; CODE XREF: Stage_XiTigerHandler+D2   j
                move.w  #$10,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                clr.b   (byte_FFF705).w
                move.w  #$8004,(word_FF80F2).w
                move.w  #$10,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jmp     Stage_DispatchSelectedProcess
; End of function Stage_XiTigerHandler
; Main gameplay loop processing player
