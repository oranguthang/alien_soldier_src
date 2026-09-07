VBlank_Epsilon1ScrollEffect:                            ; DATA XREF: VBlank_EffectDispatcher+4A   o  ; was: sub_195C
                move.w  (word_FFF74E).w,d0
                bne.w   loc_198A
                addq.w  #4,(word_FFF74E).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_19CC(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_198A:                                               ; CODE XREF: VBlank_Epsilon1ScrollEffect+4   j
                move.w  (dword_FF8128).w,d1
                neg.w   d1
                add.w   (word_FFA012).w,d1
                move.w  d1,d0
                neg.w   d0
                move.w  d0,(dword_FF8134).w
                addi.w  #$DF,d1
                cmpi.w  #$E2,d1
                bmi.s   loc_19AA
                move.w  #$E2,d1
loc_19AA:                                               ; CODE XREF: VBlank_Epsilon1ScrollEffect+48   j
                andi.w  #$FF,d1
                move.b  d1,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                move.w  (word_FFF7E6).w,(VDP_CTRL).l
                move.w  (word_FFF7D8).w,(VDP_CTRL).l
                rts
; End of function VBlank_Epsilon1ScrollEffect
; ---------------------------------------------------------------------------
stru_19CC:      dc.w    0                               ; field_0
                                        ; DATA XREF: VBlank_Epsilon1ScrollEffect+14   o
                dc.l    word_19D6                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_19D6:      dc.w    $200                            ; DATA XREF: ROM:stru_19CC   o

; HBlank handler with timing delay and VDP mode register setup
HBlank_SetModeWithDelay:
                move.l  #$40020010,(VDP_CTRL).l         ; was: sub_19D8
                move.w  (dword_FF8134).w,(VDP_DATA).l
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                move.w  #$8B00,(VDP_CTRL).l
                move.w  #$8402,(VDP_CTRL).l
                rte
; End of function HBlank_SetModeWithDelay
; Initializes VBlank effect for cutscene and story displays
VBlank_InitCutsceneEffect:                              ; DATA XREF: VBlank_EffectDispatcher+52   o  ; was: sub_1A8E
                move.w  (word_FFF74E).w,d0
                bne.w   loc_1AB2
                addq.w  #4,(word_FFF74E).w
                move.b  #3,(word_FFF7E4+1).w
                lea     stru_1AC8(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
loc_1AB2:                                               ; CODE XREF: VBlank_InitCutsceneEffect+4   j
                move.w  (word_FFF7DE).w,(VDP_CTRL).l
                move.w  (word_FFF7E8).w,(VDP_CTRL).l
                movea.w #(word_FF9C00-M68K_RAM),a6
                rts
; End of function VBlank_InitCutsceneEffect
; ---------------------------------------------------------------------------
stru_1AC8:      dc.w    0                               ; field_0
                                        ; DATA XREF: VBlank_InitCutsceneEffect+12   o
                dc.l    word_1AD2                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_1AD2:      dc.w    $20                             ; DATA XREF: ROM:stru_1AC8   o

; HBlank handler that writes VDP control register value
HBlank_WriteVDPControl:
                move.w  (a6)+,(VDP_CTRL).l              ; was: sub_1AD4
                rte
; End of function HBlank_WriteVDPControl
; Updates boss sprites
Boss_DestroyerProtoUpdateSprites:                       ; DATA XREF: VBlank_EffectDispatcher+5A   o  ; was: sub_1ADC
                move.w  (word_FFF74E).w,d0
                bne.w   loc_1B0E
                addq.w  #4,(word_FFF74E).w
                move.b  #1,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1418(pc),a0
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_1B0E:                                               ; CODE XREF: Boss_DestroyerProtoUpdateSprites+4   j
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     (word_FF9C00).w,a6
                rts
; End of function Boss_DestroyerProtoUpdateSprites
; VBlank effect handler
Boss_ZLeoVBlankEffect:                                  ; DATA XREF: VBlank_EffectDispatcher+5E   o  ; was: sub_1B24
                move.w  (word_FFF74E).w,d0
                bne.w   loc_1B50
                addq.w  #4,(word_FFF74E).w
                move.b  #0,(word_FFF7E4+1).w
                lea     stru_1B6E(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_1B50:                                               ; CODE XREF: Boss_ZLeoVBlankEffect+4   j
                move.w  (word_FFF7E6).w,(VDP_CTRL).l
                move.w  (word_FFF7D4).w,(VDP_CTRL).l
                lea     (word_FF9E40).w,a6
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                rts
; End of function Boss_ZLeoVBlankEffect
; ---------------------------------------------------------------------------
stru_1B6E:      dc.w    0                               ; field_0
                                        ; DATA XREF: Boss_ZLeoVBlankEffect+12   o
                dc.l    word_1B78                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_1B78:      dc.w    $200                            ; DATA XREF: ROM:stru_1B6E   o

; HBlank handler for Z-Leo boss parallax scroll with timing
HBlank_ZLeoScrollEffect:
                move.w  (a6)+,(VDP_CTRL).l              ; was: sub_1B7A
                move.l  #$40000010,(VDP_CTRL).l
                move.w  (a6)+,(VDP_DATA).l
                move.w  (a6)+,(VDP_CTRL).l
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                move.w  (a6)+,(VDP_CTRL).l
                rte
; End of function HBlank_ZLeoScrollEffect
; Initializes VBlank special stage effect with multiple layers
VBlank_InitStageEffect:                                 ; DATA XREF: VBlank_EffectDispatcher+62   o  ; was: sub_1C1E
                move.w  (word_FFF74E).w,d0
                bne.w   loc_1C4A
                addq.w  #4,(word_FFF74E).w
                move.b  #$80,(word_FFF7E4+1).w
                lea     stru_1C6C(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_1C4A:                                               ; CODE XREF: VBlank_InitStageEffect+4   j
                move.w  (word_FFF7D4).w,(VDP_CTRL).l
                move.w  (word_FFF7D8).w,(VDP_CTRL).l
                move.w  (word_FFF7F2).w,(VDP_CTRL).l
                move.w  (word_FFF7F4).w,(VDP_CTRL).l
                rts
; End of function VBlank_InitStageEffect
; ---------------------------------------------------------------------------
stru_1C6C:      dc.w    0                               ; field_0
                                        ; DATA XREF: VBlank_InitStageEffect+12   o
                dc.l    word_1C76                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_1C76:      dc.w    $200                            ; DATA XREF: ROM:stru_1C6C   o

; HBlank handler with timing delay and window register setup
HBlank_SetWindowWithDelay:
                nop                                     ; was: sub_1C78
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                move.w  #$910A,(VDP_CTRL).l
                move.w  #$9200,(VDP_CTRL).l
                rte
; End of function HBlank_SetWindowWithDelay
; HBlank handler that writes scroll and sprite position data
HBlank_WriteScrollSprite:
                ori.w   #$46FC,d0                       ; was: sub_1D0A
                move.l  d0,-(a3)
                move.l  #$70000083,(VDP_CTRL).l
                move.w  (a6)+,(VDP_DATA).l
                move.l  #$40000010,(VDP_CTRL).l
                move.w  (a6)+,(VDP_DATA).l
                rte
; End of function HBlank_WriteScrollSprite
; Queues DMA commands to clear VRAM tiles without data
