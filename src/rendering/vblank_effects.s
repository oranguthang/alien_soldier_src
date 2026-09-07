VBlank_EffectDispatcher:                                ; CODE XREF: VBLANK:Int_VBlank_RunEffects   p  ; was: sub_1356
                move.w  (word_FFF74A).w,d0
                movea.l off_1360(pc,d0.w),a0
                jmp     (a0)
; ---------------------------------------------------------------------------
off_1360:       dc.l    Effect_NullHandler
                dc.l    VBlank_InitFadeTransition
                dc.l    VBlank_InitXiTigerEffect
                dc.l    VBlank_InitCRAMEffect
                dc.l    Effect_InitTransitionFade
                dc.l    Effect_NullHandler
                dc.l    VBlank_InitScreenMode
                dc.l    Effect_NullHandler
                dc.l    Effect_InitStage2DemoEffect
                dc.l    VBlank_LoadSpriteData
                dc.l    VBlank_InitFlyingNeoEffect
                dc.l    VBlank_InitFliesEffect
                dc.l    VBlank_InitStage10Effect
                dc.l    VBlank_InitSunsetStingEffect
                dc.l    VBlank_InitStage10Effect
                dc.l    Effect_InitLettersEffect
                dc.l    VBlank_Epsilon1ScrollEffect
                dc.l    Effect_InitStoryEffect
                dc.l    VBlank_InitCutsceneEffect
                dc.l    VBlank_InitScrollEffect
                dc.l    Boss_DestroyerProtoUpdateSprites
                dc.l    Boss_ZLeoVBlankEffect
                dc.l    VBlank_InitStageEffect
; End of function VBlank_EffectDispatcher
; Null effect handler doing nothing
Effect_NullHandler:                                     ; DATA XREF: VBlank_EffectDispatcher:off_1360   o  ; was: sub_13BC
                                        ; VBlank_EffectDispatcher+1E   o
                move.w  (word_FFF74E).w,d0
                bne.w   locret_13DC
                addq.w  #4,(word_FFF74E).w
                andi.b  #$EF,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
                move.w  #$4E73,(word_FFEE00).w
locret_13DC:                                            ; CODE XREF: Effect_NullHandler+4   j
                rts
; End of function Effect_NullHandler
; Initializes VBlank effect for Alien Soldier letters screen by loading object data and setting VDP registers
Effect_InitLettersEffect:                               ; DATA XREF: VBlank_EffectDispatcher+46   o  ; was: sub_13DE
                move.w  (word_FFF74E).w,d0
                bne.w   Effect_PrepareLettersBuffer
                addq.w  #4,(word_FFF74E).w
                move.b  #0,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1418(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
; Branch target that loads buffer address for letters effect after initialization
Effect_PrepareLettersBuffer:                            ; CODE XREF: Effect_InitLettersEffect+4   j  ; was: loc_1412
                lea     (word_FF9E00).w,a6
                rts
; End of function Effect_InitLettersEffect
; ---------------------------------------------------------------------------
stru_1418:      dc.w    0                               ; field_0
                                        ; DATA XREF: Effect_InitLettersEffect+1A   o
                                        ; Effect_InitStage2DemoEffect+1A   o
                dc.l    word_1422                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_1422:      dc.w    $20                             ; DATA XREF: ROM:stru_1418   o

; Writes vertical scroll value to VSRAM at offset $10 via VDP during VBlank
Gfx_WriteVScrollValue:
                move.l  #$40000010,(VDP_CTRL).l         ; was: sub_1424
                move.w  (a6)+,(VDP_DATA).l
                rte
; End of function Gfx_WriteVScrollValue
; Initializes VBlank effect for Stage 2 demo playback with specific display mode settings
Effect_InitStage2DemoEffect:                            ; DATA XREF: VBlank_EffectDispatcher+2A   o  ; was: sub_1436
                move.w  (word_FFF74E).w,d0
                bne.w   Effect_SetStage2Registers
                addq.w  #4,(word_FFF74E).w
                move.b  #1,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1418(pc),a0
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
; Branch target that configures VDP registers for Stage 2 demo effect display
Effect_SetStage2Registers:                              ; CODE XREF: Effect_InitStage2DemoEffect+4   j  ; was: loc_1468
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     (word_FF9E00).w,a6
                rts
; End of function Effect_InitStage2DemoEffect
; Initializes VBlank effect for flies stage
VBlank_InitFliesEffect:                                 ; DATA XREF: VBlank_EffectDispatcher+36   o  ; was: sub_147E
                move.w  (word_FFF74E).w,d0
                bne.w   loc_14B0
                addq.w  #4,(word_FFF74E).w
                move.b  #7,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1418(pc),a0
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_14B0:                                               ; CODE XREF: VBlank_InitFliesEffect+4   j
                lea     (word_FF9E00).w,a6
                rts
; End of function VBlank_InitFliesEffect
; Initializes VBlank effect for Xi-Tiger cutscene
VBlank_InitXiTigerEffect:                               ; DATA XREF: VBlank_EffectDispatcher+12   o  ; was: sub_14B6
                move.w  (word_FFF74E).w,d0
                bne.w   loc_14E8
                addq.w  #4,(word_FFF74E).w
                move.b  #7,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1418(pc),a0
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_14E8:                                               ; CODE XREF: VBlank_InitXiTigerEffect+4   j
                lea     (word_FF9FC0).w,a6
                rts
; End of function VBlank_InitXiTigerEffect
; Initializes VBlank effect with CRAM base address and sprite loading
VBlank_InitCRAMEffect:                                  ; DATA XREF: VBlank_EffectDispatcher+16   o  ; was: sub_14EE
                move.w  (word_FFF74E).w,d0
                bne.w   loc_1522
                addq.w  #4,(word_FFF74E).w
                move.b  #0,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1528(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_1522:                                               ; CODE XREF: VBlank_InitCRAMEffect+4   j
                lea     (word_FF9E00).w,a6
                rts
; End of function VBlank_InitCRAMEffect
; ---------------------------------------------------------------------------
stru_1528:      dc.w    0                               ; field_0
                                        ; DATA XREF: VBlank_InitCRAMEffect+1A   o
                                        ; Effect_InitTransitionFade+1A   o
                dc.l    word_1532                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_1532:      dc.w    $20                             ; DATA XREF: ROM:stru_1528   o

; Writes vertical scroll value to VSRAM at offset $10 (alternate address) during VBlank
Gfx_WriteVScrollAlt:
                move.l  #$40020010,(VDP_CTRL).l         ; was: sub_1534
                move.w  (a6)+,(VDP_DATA).l
                rte
; End of function Gfx_WriteVScrollAlt
; VBlank handler that loads sprite object data and updates VDP registers
VBlank_LoadSpriteData:                                  ; DATA XREF: VBlank_EffectDispatcher+2E   o  ; was: sub_1546
                move.w  (word_FFF74E).w,d0
                bne.s   loc_1572
                addq.w  #4,(word_FFF74E).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1594(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_1572:                                               ; CODE XREF: VBlank_LoadSpriteData+4   j
                move.l  #$40020010,(VDP_CTRL).l
                move.w  (word_FFEC04).w,(VDP_DATA).l
                move.b  (byte_FFC66B).w,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                rts
; End of function VBlank_LoadSpriteData
; ---------------------------------------------------------------------------
stru_1594:      dc.w    0                               ; field_0
                                        ; DATA XREF: VBlank_LoadSpriteData+12   o
                dc.l    word_159E                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_159E:      dc.w    $20                             ; DATA XREF: ROM:stru_1594   o

; HBlank handler that updates sprite table and disables HScroll
HBlank_UpdateSpriteScroll:
                move.l  #$40020010,(VDP_CTRL).l         ; was: sub_15A0
                move.w  (word_FF9E00).w,(VDP_DATA).l
                move.w  #$8AFF,(VDP_CTRL).l
                rte
; End of function HBlank_UpdateSpriteScroll
; Initializes screen transition fade effect
Effect_InitTransitionFade:                              ; DATA XREF: VBlank_EffectDispatcher+1A   o  ; was: sub_15BC
                move.w  (word_FFF74E).w,d0
                bne.w   loc_15EE
                addq.w  #4,(word_FFF74E).w
                move.b  #1,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1528(pc),a0
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_15EE:                                               ; CODE XREF: Effect_InitTransitionFade+4   j
                lea     (word_FF9E00).w,a6
                rts
; End of function Effect_InitTransitionFade
; Initializes VBlank fade transition effect with CRAM setup
VBlank_InitFadeTransition:                              ; DATA XREF: VBlank_EffectDispatcher+E   o  ; was: sub_15F4
                move.w  (word_FFF74E).w,d0
                bne.w   loc_1626
                addq.w  #4,(word_FFF74E).w
                move.b  #3,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1528(pc),a0
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_1626:                                               ; CODE XREF: VBlank_InitFadeTransition+4   j
                lea     (word_FF9E00).w,a6
                rts
; End of function VBlank_InitFadeTransition
; Initializes VBlank effect for Flying-Neo battle
VBlank_InitFlyingNeoEffect:                             ; DATA XREF: VBlank_EffectDispatcher+32   o  ; was: sub_162C
                move.w  (word_FFF74E).w,d0
                bne.s   Effect_LoadFlyingNeoBuffer
                addq.w  #4,(word_FFF74E).w
                move.b  #7,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1528(pc),a0
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
; Loads buffer address for Flying Neo stage VBlank effect after initialization
Effect_LoadFlyingNeoBuffer:                             ; CODE XREF: VBlank_InitFlyingNeoEffect+4   j  ; was: loc_165C
                lea     (word_FF9E00).w,a6
                rts
; End of function VBlank_InitFlyingNeoEffect
; Initializes Sunset Sting VBlank effect
VBlank_InitSunsetStingEffect:                           ; DATA XREF: VBlank_EffectDispatcher+3E   o  ; was: sub_1662
                move.w  (word_FFF74E).w,d0
                bne.w   loc_1694
                addq.w  #4,(word_FFF74E).w
                move.b  #1,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1418(pc),a0
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_1694:                                               ; CODE XREF: VBlank_InitSunsetStingEffect+4   j
                lea     (word_FF9C00).w,a6
                rts
; End of function VBlank_InitSunsetStingEffect
; Initializes VBlank effect for story screen with CRAM base address $C0 and object data loading
Effect_InitStoryEffect:                                 ; DATA XREF: VBlank_EffectDispatcher+4E   o  ; was: sub_169A
                move.w  (word_FFF74E).w,d0
                bne.w   Effect_SetStoryRegisters
                addq.w  #4,(word_FFF74E).w
                move.b  #$C0,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_16E6(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
                move.w  (word_FFF7F4).w,(VDP_CTRL).l
; Branch target that sets VDP control register for story screen effect after initialization
Effect_SetStoryRegisters:                               ; CODE XREF: Effect_InitStoryEffect+4   j  ; was: loc_16D6
                move.w  (word_FFF7D4).w,(VDP_CTRL).l
                lea     (VDP_CTRL).l,a6
                rts
; End of function Effect_InitStoryEffect
; ---------------------------------------------------------------------------
stru_16E6:      dc.w    0                               ; field_0
                                        ; DATA XREF: Effect_InitStoryEffect+1A   o
                dc.l    word_16F0                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_16F0:      dc.w    $40                             ; DATA XREF: ROM:stru_16E6   o

; Complex VBlank routine that updates story screen display including plane switching and timed delays
Gfx_UpdateStoryDisplay:
                move.w  #$8210,(a6)                     ; was: sub_16F2
                move.l  #$40000010,(a6)
                move.w  #0,(VDP_DATA).l
                move.l  #$70000003,(a6)
                move.w  (word_FF0180).l,(VDP_DATA).l
                move.w  #$10,(word_FF0186).l
loc_171C:                                               ; CODE XREF: Gfx_UpdateStoryDisplay+30   j
                subq.w  #1,(word_FF0186).l
                bne.s   loc_171C
                move.w  #$8228,(a6)
                rte
; End of function Gfx_UpdateStoryDisplay
; Initializes VBlank scroll effect for scene transitions
VBlank_InitScrollEffect:                                ; DATA XREF: VBlank_EffectDispatcher+56   o  ; was: sub_172A
                move.w  (word_FFF74E).w,d0
                bne.w   loc_175E
                addq.w  #4,(word_FFF74E).w
                move.b  #1,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_1764(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_175E:                                               ; CODE XREF: VBlank_InitScrollEffect+4   j
                movea.w #(byte_FF9C04-M68K_RAM),a6
                rts
; End of function VBlank_InitScrollEffect
; ---------------------------------------------------------------------------
stru_1764:      dc.w    0                               ; field_0
                                        ; DATA XREF: VBlank_InitScrollEffect+1A   o
                dc.l    word_176E                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_176E:      dc.w    $40                             ; DATA XREF: ROM:stru_1764   o

; HBlank handler that writes scroll position data to VDP
HBlank_WriteScrollData:
                move.l  #$40000010,(VDP_CTRL).l         ; was: sub_1770
                move.l  (a6)+,(VDP_DATA).l
                rte
; End of function HBlank_WriteScrollData
; Initializes VBlank effect for Stage 10
VBlank_InitStage10Effect:                               ; DATA XREF: VBlank_EffectDispatcher+3A   o  ; was: sub_1782
                                        ; VBlank_EffectDispatcher+42   o
                move.w  (word_FFF74E).w,d0
                bne.w   loc_17B6
                addq.w  #4,(word_FFF74E).w
                move.b  #$C8,(word_FFF7E4+1).w
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                lea     stru_183C(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
loc_17B6:                                               ; CODE XREF: VBlank_InitStage10Effect+4   j
                move.w  (word_FFF7D4).w,(VDP_CTRL).l
                move.w  (word_FFF7D8).w,(VDP_CTRL).l
                move.w  (word_FFF7DE).w,(VDP_CTRL).l
                move.l  #$70020003,(VDP_CTRL).l
                move.w  (word_FFE402).w,(VDP_DATA).l
                move.l  #$70000003,(VDP_CTRL).l
                move.w  (word_FFE400).w,(VDP_DATA).l
                move.l  #$40020010,(VDP_CTRL).l
                move.w  (word_FFEC02).w,(VDP_DATA).l
                move.l  #$40000010,(VDP_CTRL).l
                move.w  (word_FFEC00).w,(VDP_DATA).l
                movea.w #(byte_FF9FF8-M68K_RAM),a0
                move.w  (word_FFEC00).w,(a0)+
                move.w  (word_FFEC02).w,(a0)+
                move.w  (word_FFA928).w,d0
                neg.w   d0
                cmpi.w  #$30,(word_FFF74A).w            ; '0'
                beq.s   Effect_SetStage10Scroll
                move.w  (word_FFE400).w,d0
; Branch target that sets scroll value for Stage 10 effect and prepares sprite buffer
Effect_SetStage10Scroll:                                ; CODE XREF: VBlank_InitStage10Effect+AC   j  ; was: loc_1834
                move.w  d0,(a0)+
                movea.w #(byte_FF9FF8-M68K_RAM),a6
                rts
; End of function VBlank_InitStage10Effect
; ---------------------------------------------------------------------------
stru_183C:      dc.w    0                               ; field_0
                                        ; DATA XREF: VBlank_InitStage10Effect+1A   o
                dc.l    word_1846                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_1846:      dc.w    $200                            ; DATA XREF: ROM:stru_183C   o

; Updates Stage 10 display during VBlank with multiple VSRAM writes and VDP register configuration including timing delays
Gfx_UpdateStage10Display:
                move.l  #$40020010,(VDP_CTRL).l         ; was: sub_1848
                move.w  (a6)+,(VDP_DATA).l
                move.l  #$40000010,(VDP_CTRL).l
                move.w  (a6)+,(VDP_DATA).l
                move.l  #$70020003,(VDP_CTRL).l
                move.w  (a6)+,(VDP_DATA).l
                move.l  #$70000003,(VDP_CTRL).l
                move.w  #0,(VDP_DATA).l
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
                move.w  #$8238,(VDP_CTRL).l
                move.w  #$8406,(VDP_CTRL).l
                move.w  #$8718,(VDP_CTRL).l
                rte
; End of function Gfx_UpdateStage10Display
; Initializes VBlank screen mode effect with object loading
VBlank_InitScreenMode:                                  ; DATA XREF: VBlank_EffectDispatcher+22   o  ; was: sub_1904
                move.w  (word_FFF74E).w,d0
                bne.w   loc_1928
                addq.w  #4,(word_FFF74E).w
                move.b  #3,(word_FFF7E4+1).w
                lea     stru_193E(pc),a0
                nop
                jsr     (LoadObjData).l
                ori.b   #$10,(word_FFF7D0+1).w
loc_1928:                                               ; CODE XREF: VBlank_InitScreenMode+4   j
                move.w  (word_FFF7E4).w,(VDP_CTRL).l
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
                lea     (word_FF9800).w,a6
                rts
; End of function VBlank_InitScreenMode
; ---------------------------------------------------------------------------
stru_193E:      dc.w    0                               ; field_0
                                        ; DATA XREF: VBlank_InitScreenMode+12   o
                dc.l    word_1948                       ; field_2
                dc.w    $EE00                           ; field_6
                dc.w    $FFFF
word_1948:      dc.w    $20                             ; DATA XREF: ROM:stru_193E   o

; HBlank handler that writes color data to CRAM
HBlank_WriteCRAMData:
                move.l  #$C00A0000,(VDP_CTRL).l         ; was: sub_194A
                move.w  (a6)+,(VDP_DATA).l
                rte
; End of function HBlank_WriteCRAMData
; VBlank effect handler for scroll
