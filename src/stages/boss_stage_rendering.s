Boss_ShieldViperScrollSetup:                            ; CODE XREF: Boss_ShieldViperInit+4   p  ; was: sub_FC74
                                        ; Boss_ShieldViperGraphicsInit+4   p
                bsr.w   Stage22_GraphicsUpdate1
                movea.w #(byte_FFE580-M68K_RAM),a1
                movea.w #(word_FF9E00-M68K_RAM),a0
                moveq   #$7F,d7
loc_FC82:                                               ; CODE XREF: Boss_ShieldViperScrollSetup+12   j
                move.w  (a0)+,(a1)
                addq.w  #4,a1
                dbf     d7,loc_FC82
                rts
; End of function Boss_ShieldViperScrollSetup
; Graphics update 1
Stage22_GraphicsUpdate1:                                ; CODE XREF: Boss_ShieldViperScrollSetup   p  ; was: sub_FC8C
                                        ; sub_FD32   p
                move.l  #$FFF88000,(dword_FF8062).w
                move.l  (dword_FF8062).w,d0
                add.l   d0,(dword_FF8066).w
                move.w  (dword_FF8066).w,d0
                bpl.s   loc_FCAA
                addi.w  #$40,d0                         ; '@'
                bmi.s   loc_FCB0
                bra.s   loc_FCB4
; ---------------------------------------------------------------------------
loc_FCAA:                                               ; CODE XREF: Stage22_GraphicsUpdate1+14   j
                subi.w  #$40,d0                         ; '@'
                bmi.s   loc_FCB4
loc_FCB0:                                               ; CODE XREF: Stage22_GraphicsUpdate1+1A   j
                move.w  d0,(dword_FF8066).w
loc_FCB4:                                               ; CODE XREF: Stage22_GraphicsUpdate1+1C   j
                                        ; Stage22_GraphicsUpdate1+22   j
                move.l  (dword_FF8066).w,d0
                divs.w  #$7000,d0
                ext.l   d0
                asl.l   #8,d0
                movea.w #(byte_FF9F00-M68K_RAM),a0
                move.l  (dword_FF8066).w,d1
                moveq   #$5F,d7                         ; '_'
loc_FCCA:                                               ; CODE XREF: Stage22_GraphicsUpdate1+46   j
                swap    d1
                move.w  d1,-(a0)
                swap    d1
                sub.l   d0,d1
                dbf     d7,loc_FCCA
                move.l  (dword_FF8062).w,d0
                add.l   d0,(dword_FF806A).w
                move.w  (dword_FF806A).w,d1
                asr.w   #4,d1
                moveq   #$17,d7
loc_FCE6:                                               ; CODE XREF: Stage22_GraphicsUpdate1+5C   j
                move.w  d1,-(a0)
                dbf     d7,loc_FCE6
                move.w  (dword_FF9D96).w,d1
                move.w  d1,-(a0)
                rts
; End of function Stage22_GraphicsUpdate1
; Palette initialization
Boss_DestroyerProtoPaletteInit:                         ; CODE XREF: Boss_DestroyerProtoInit+12   p  ; was: sub_FCF4
                                        ; Boss_DestroyerProtoAnimationScript+8   p
                tst.w   (word_FF9DAE).w
                bne.s   loc_FCFC
                rts
; ---------------------------------------------------------------------------
loc_FCFC:                                               ; CODE XREF: Boss_DestroyerProtoPaletteInit+4   j
                btst    #0,(FrameCounter+1).w
                bne.s   loc_FD08
                subq.w  #1,(word_FF9DAE).w
loc_FD08:                                               ; CODE XREF: Boss_ShieldViperPaletteSetup+38   j
                                        ; sub_F484   p
                movea.w #(PaletteActiveBuffer-M68K_RAM),a0
                move.w  #$E000,d7
                move.w  (word_FF9DAE).w,d0
                moveq   #$3F,d5                         ; '?'
                jsr     (Gfx_SetFadeParams).l
                moveq   #0,d0
                sub.w   (word_FF9DAE).w,d0
                movea.w #(word_FFE340-M68K_RAM),a0
                move.w  #$C000,d7
                moveq   #$F,d5
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_DestroyerProtoPaletteInit
; Renders boss segments
Boss_DestroyerProtoRenderSegments:                      ; CODE XREF: Boss_DestroyerProtoAnimationScript+10   p  ; was: sub_FD32
                                        ; Boss_DestroyerProtoGraphicsCleanup+8   p
                bsr.w   Stage22_GraphicsUpdate1
                movea.w #(dword_FF9A00-M68K_RAM),a0
                movea.w #(byte_FF9B00-M68K_RAM),a1
                moveq   #6,d7
loc_FD40:                                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+1E   j
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                dbf     d7,loc_FD40
                move.w  (dword_FF9DAA).w,d0
                subi.w  #$20,d0                         ; ' '
                move.w  d0,(word_FF9D94).w
                moveq   #$20,d0                         ; ' '
                move.w  (dword_FF9DAA).w,d1
                asr.w   #1,d1
                sub.w   d1,d0
                move.w  d0,d2
                move.w  d0,d3
                addi.w  #$20,d2                         ; ' '
                move.w  #$80,d5
                moveq   #$60,d6                         ; '`'
                move.l  (dword_FF9D9E).w,d0
                asr.l   #1,d0
                move.l  (dword_FF9D96).w,d1
                add.l   d0,d1
                move.l  d1,(dword_FF9D96).w
                swap    d1
                movea.w #(byte_FF9B1E-M68K_RAM),a0
                movea.w #(byte_FF981E-M68K_RAM),a1
                moveq   #$17,d7
loc_FD94:                                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+82   j
                move.w  d3,d0
                move.w  d2,d2
                bmi.s   loc_FD9E
                cmp.w   d5,d2
                bmi.s   loc_FDA0
loc_FD9E:                                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+66   j
                move.w  d6,d0
loc_FDA0:                                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+6A   j
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a1)+
                move.w  d1,(a1)+
                move.w  d1,(a1)+
                addq.w  #8,d2
                subq.w  #8,d6
                dbf     d7,loc_FD94
                cmpi.w  #$60,(dword_FF9D90).w           ; '`'
                bpl.s   loc_FDE2
                move.w  (dword_FF9D90).w,d1
                bne.s   loc_FDCE
                move.l  #$FFFE0000,d0
                bra.s   loc_FDF4
; ---------------------------------------------------------------------------
loc_FDCE:                                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+92   j
                move.l  #$6000,d0
                divu.w  d1,d0
                subi.w  #$100,d0
                ext.l   d0
                asl.l   #8,d0
                asl.l   #1,d0
                bra.s   loc_FDF4
; ---------------------------------------------------------------------------
loc_FDE2:                                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+8C   j
                move.l  (dword_FF9D90).w,d0
                divu.w  #$3000,d0
                subi.w  #$200,d0
                neg.w   d0
                ext.l   d0
                asl.l   #7,d0
loc_FDF4:                                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+9A   j
                                        ; Boss_DestroyerProtoRenderSegments+AE   j
                moveq   #0,d1
                move.w  (word_FF9D94).w,d1
                neg.w   d1
                swap    d1
                move.w  (word_FF9D94).w,d2
                andi.w  #$FFFE,d2
                addi.w  #$8E,d2
                addi.w  #-$6500,d2
                movea.w d2,a0
                move.w  (word_FF9D94).w,d2
                andi.w  #$FFFE,d2
                addi.w  #$8E,d2
                addi.w  #-$6800,d2
                movea.w d2,a2
                movea.w #(byte_FF9E0E-M68K_RAM),a1
                move.w  (word_FF9D94).w,d3
                neg.w   d3
                moveq   #8,d7
loc_FE2E:                                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+108   j
                cmpa.w  #$9C00,a0
                bpl.s   locret_FE66
                move.w  d3,(a0)+
                move.w  (a1)+,d4
                move.w  d4,(a2)+
                dbf     d7,loc_FE2E
                movea.w #(word_FF9E40-M68K_RAM),a1
                move.w  (word_FF9D94).w,d2
                neg.w   d2
                move.w  #$9C00,d6
loc_FE4C:                                               ; CODE XREF: Boss_DestroyerProtoRenderSegments+132   j
                cmpa.w  d6,a0
                bpl.s   locret_FE66
                swap    d1
                move.w  d1,(a0)+
                move.w  d1,d3
                swap    d1
                add.l   d0,d1
                sub.w   d2,d3
                asl.w   #1,d3
                move.w  (a1,d3.w),(a2)+
                subq.w  #2,d2
                bra.s   loc_FE4C
; ---------------------------------------------------------------------------
locret_FE66:                                            ; CODE XREF: Boss_DestroyerProtoRenderSegments+100   j
                                        ; Boss_DestroyerProtoRenderSegments+11C   j
                rts
; End of function Boss_DestroyerProtoRenderSegments
; Renders background
Boss_ShieldViperRenderBackground:                       ; CODE XREF: Boss_ShieldViperGraphicsInit+8   p  ; was: sub_FE68
                movea.w #(byte_FF9B80-M68K_RAM),a0
                movea.w a0,a1
                moveq   #$3F,d7                         ; '?'
                move.w  (word_FF9DFE).w,d0
                addi.w  #-$7E2C,d0
loc_FE78:                                               ; CODE XREF: Boss_ShieldViperRenderBackground+12   j
                move.w  d0,(a1)+
                dbf     d7,loc_FE78
                move.w  (word_FF9DFC).w,d0
                addi.w  #-$1800,d0
                addi.w  #$80,(word_FF9DFC).w
                addq.w  #1,(word_FF9DFE).w
                move.w  #$8F02,d3
                move.l  #$94009340,d4
                jmp     VDP_QueueCommand_Build
; End of function Boss_ShieldViperRenderBackground
; Attack state 3 handler
Boss_WolfGaropaAttackState3:                            ; CODE XREF: Boss_WolfGaropaTransition+28   p  ; was: sub_FEA0
                                        ; Boss_WolfGaropaPhaseInit+E   p
                movea.w #(byte_FFDB80-M68K_RAM),a0
                clr.w   $48(a0)
                move.w  #$D0,$10(a0)
                bsr.s   Boss_WolfGaropaAttackState4
                movea.w #(word_FFDBE0-M68K_RAM),a0
                move.w  #1,$48(a0)
                move.w  #$170,$10(a0)
; End of function Boss_WolfGaropaAttackState3
; Attack state 4 handler
Boss_WolfGaropaAttackState4:                            ; CODE XREF: Boss_WolfGaropaAttackState3+E   p  ; was: sub_FEC0
                move.w  #$41C,(a0)
                clr.w   2(a0)
                move.b  #$80,$21(a0)
                move.b  #$10,$23(a0)
                move.l  #$40827E,$28(a0)
                rts
; End of function Boss_WolfGaropaAttackState4
; Palette update handler
Boss_WolfGaropaPaletteUpdate:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_FEDE
                move.b  #$80,$21(a5)
                move.w  #$F3E0,d0
                sub.w   (dword_FFA904).w,d0
                move.w  #$150,d1
                sub.w   d0,d1
                move.w  d1,$14(a5)
                tst.w   $48(a5)
                bne.s   locret_FF0E
                subi.w  #$20,d1                         ; ' '
                cmp.w   (dword_FFA414).w,d1
                bpl.s   locret_FF0E
                move.w  d1,(dword_FFA414).w
                subq.w  #1,(dword_FFA414).w
locret_FF0E:                                            ; CODE XREF: Boss_WolfGaropaPaletteUpdate+1C   j
                                        ; Boss_WolfGaropaPaletteUpdate+26   j
                rts
; End of function Boss_WolfGaropaPaletteUpdate
; Clears scroll animation timer at FFA960
