Stage_InitGameOver:                                     ; DATA XREF: Sys_DispatchGameState+CE   o  ; was: sub_275C6
                tst.w   (GameSubstateIndex).w
                bne.s   loc_275E2
                jsr     (Sys_InitGameMode).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_275E2:                                              ; CODE XREF: Stage_InitGameOver+4   j
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                move.w  #$4C,(word_FFF74A).w            ; 'L'
                clr.w   (word_FFF74E).w
                move.b  #3,(word_FFF7E6+1).w
                move.w  #$12,(word_FF8090).w
                move.b  #$28,(word_FFF7D4+1).w          ; '('
                move.b  #5,(word_FFF7D8+1).w
                move.b  #0,(word_FFF7F4+1).w
                move.b  #$11,(word_FFF7F0+1).w
                lea     stru_27676(pc),a0
                nop
                jsr     (LoadObjData).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                move.w  #$2C,(word_FFE302).w            ; ','
                move.w  #0,(word_FFE304).w
                bsr.w   Gfx_InitDitherPatterns1
                movea.w (word_FFF70C).w,a1
                move.w  #$80,-(a1)
                move.w  #$4020,-(a1)
                move.w  #$9500,-(a1)
                move.w  #$96CA,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009340,-(a1)
                move.w  a1,(word_FFF70C).w
                move.w  #1,(dword_FF807E).w
                move.b  #4,d0
                jsr     (Sound_QueueRequest).l
                rts
; End of function Stage_InitGameOver
; ---------------------------------------------------------------------------
stru_27676:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_InitGameOver+52   o
                dc.l    tiles_18D650                    ; field_2
                dc.w    $A000                           ; field_6
                dc.w    $FFFF

; Copies 16 palette entries from dword_FF9A00 to word_FF9800 then calls sub_27692 dispatcher
Effect_CopyGameOverPalette:                             ; DATA XREF: Sys_DispatchGameState+D2   o  ; was: sub_27680
                movea.w #(dword_FF9A00-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a1
                moveq   #$F,d7
                bsr.w   Effect_CopyPaletteData
                bsr.s   Stage_GameOverDispatcher
                rts
; End of function Effect_CopyGameOverPalette
; Dispatcher that jumps to game over state handler based on GameSubstateIndex index via offset table
Stage_GameOverDispatcher:                               ; CODE XREF: Effect_CopyGameOverPalette+E   p  ; was: sub_27692
                move.w  (GameSubstateIndex).w,d0
                movea.w off_276A2(pc,d0.w),a0
                adda.l  #Stage_DemoInputHandler,a0
                jmp     (a0)
; End of function Stage_GameOverDispatcher
; ---------------------------------------------------------------------------
off_276A2:      dc.w    Stage_DemoInputHandler-Stage_DemoInputHandler
                                        ; DATA XREF: Stage_GameOverDispatcher+4   r
                dc.w    Stage_CameraAutoAdvance-Stage_DemoInputHandler
                dc.w    Gfx_RenderSceneThunk-Stage_DemoInputHandler

; Handles demo/debug input for rotating and adjusting 3D view parameters
Stage_DemoInputHandler:                                 ; DATA XREF: Stage_GameOverDispatcher+8   o  ; was: sub_276A8
                                        ; ROM:off_276A2   o
                btst    #6,(word_FFF708).w
                beq.s   loc_276C2
                addi.w  #$400,(word_FF807C).w
                cmpi.w  #$2000,(word_FF807C).w
                bmi.s   loc_276C2
                clr.w   (word_FF807C).w
loc_276C2:                                              ; CODE XREF: Stage_DemoInputHandler+6   j
                                        ; Stage_DemoInputHandler+14   j
                btst    #4,(word_FFF708).w
                beq.s   loc_276D8
                subi.w  #$400,(word_FF807C).w
                bpl.s   loc_276D8
                move.w  #$2000,(word_FF807C).w
loc_276D8:                                              ; CODE XREF: Stage_DemoInputHandler+20   j
                                        ; Stage_DemoInputHandler+28   j
                btst    #1,(word_FFF706).w
                beq.s   loc_276E6
                addi.w  #$10,(dword_FF807E).w
loc_276E6:                                              ; CODE XREF: Stage_DemoInputHandler+36   j
                btst    #0,(word_FFF706).w
                beq.s   loc_276FE
                subi.w  #$10,(dword_FF807E).w
                bmi.s   loc_276F8
                bne.s   loc_276FE
loc_276F8:                                              ; CODE XREF: Stage_DemoInputHandler+4C   j
                move.w  #$10,(dword_FF807E).w
loc_276FE:                                              ; CODE XREF: Stage_DemoInputHandler+44   j
                                        ; Stage_DemoInputHandler+4E   j
                btst    #6,(word_FFF708).w
                beq.s   loc_2771A
                addq.w  #2,(GameSubstateIndex).w
                clr.w   (dword_FF8128).w
                move.w  #$50,(dword_FF807E).w           ; 'P'
                move.w  #$20,(word_FF8082).w            ; ' '
loc_2771A:                                              ; CODE XREF: Stage_DemoInputHandler+5C   j
                bsr.w   Gfx_InitSpriteTable
                bra.w   Gfx_Render3DLandscape
; End of function Stage_DemoInputHandler
; Auto-advances camera through predefined positions using data table
Stage_CameraAutoAdvance:                                ; DATA XREF: ROM:000276A4   o  ; was: sub_27722
                addi.w  #$18,(dword_FF807E).w
                cmpi.w  #$450,(dword_FF807E).w
                bmi.s   loc_27740
                addq.w  #2,(dword_FF8128).w
                move.w  #$20,(dword_FF807E).w           ; ' '
                move.w  #$20,(word_FF8082).w            ; ' '
loc_27740:                                              ; CODE XREF: Stage_CameraAutoAdvance+C   j
                subq.w  #1,(word_FF8082).w
                move.w  (dword_FF8128).w,d0
                move.w  word_2775A(pc,d0.w),(word_FF807C).w
                bpl.s   loc_27756
                addq.w  #2,(GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_27756:                                              ; CODE XREF: Stage_CameraAutoAdvance+2C   j
                bra.w   Gfx_Render3DLandscape
; End of function Stage_CameraAutoAdvance
; ---------------------------------------------------------------------------
word_2775A:     dc.w    0, $400, $800, $C00, $1000, $1400, $1800, $400, $1C00, $800, $C00, $2000, $FFFF
                                        ; DATA XREF: Stage_CameraAutoAdvance+26   r

; Attributes: thunk
; Thunk to call 3D scene rendering routine
Gfx_RenderSceneThunk:                                   ; DATA XREF: ROM:000276A6   o  ; was: sub_27774
                bra.w   Gfx_InitSpriteTable
; End of function Gfx_RenderSceneThunk
; Initializes first set of dither patterns for 3D rendering
Gfx_InitDitherPatterns1:                                ; CODE XREF: Stage_InitGameOver+76   p  ; was: sub_27778
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.l  #$1010101,d4
                move.l  #$10101010,d5
                bsr.s   Gfx_FillPatternBlock
                move.l  #0,(a0)+
                move.l  #$10000000,(a0)+
                move.l  #$1000000,(a0)+
                move.l  #$10100000,(a0)+
                move.l  #$1010000,(a0)+
                move.l  #$10101000,(a0)+
                move.l  #$1010100,(a0)+
                move.l  #$10101010,(a0)+
                move.l  #$22222222,d4
                move.l  #$22222222,d5
                bsr.s   Gfx_FillPatternBlock
                move.l  #0,(a0)+
                move.l  #$20000000,(a0)+
                move.l  #$22000000,(a0)+
                move.l  #$22200000,(a0)+
                move.l  #$22220000,(a0)+
                move.l  #$22222000,(a0)+
                move.l  #$22222200,(a0)+
                move.l  #$22222220,(a0)+
                rts
; End of function Gfx_InitDitherPatterns1
; Fills 4 blocks with alternating pattern data
Gfx_FillPatternBlock:                                   ; CODE XREF: Gfx_InitDitherPatterns1+10   p  ; was: sub_277FA
                                        ; Gfx_InitDitherPatterns1+4E   p
                moveq   #3,d7
loc_277FC:                                              ; CODE XREF: Gfx_FillPatternBlock+6   j
                move.l  d4,(a0)+
                move.l  d5,(a0)+
                dbf     d7,loc_277FC
                rts
; End of function Gfx_FillPatternBlock
; Initializes second set of dither patterns for 3D rendering
Gfx_InitDitherPatterns2:
                movea.w #(dword_FF9400-M68K_RAM),a0     ; was: sub_27806
                moveq   #0,d0
                move.l  #$11000000,d1
                move.l  #$11110000,d2
                move.l  #$11111100,d3
                move.l  #$11111111,d4
                bsr.s   Gfx_WriteDitherSequence
                moveq   #0,d0
                move.l  #$22000000,d1
                move.l  #$22220000,d2
                move.l  #$22222200,d3
                move.l  #$22222222,d4
; End of function Gfx_InitDitherPatterns2
; Writes decreasing dither pattern sequence to buffer
Gfx_WriteDitherSequence:                                ; CODE XREF: Gfx_InitDitherPatterns2+1E   p  ; was: sub_27840
                moveq   #7,d7
loc_27842:                                              ; CODE XREF: Gfx_WriteDitherSequence+4   j
                move.l  d4,(a0)+
                dbf     d7,loc_27842
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d1,(a0)+
                move.l  d1,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d3,(a0)+
                move.l  d3,(a0)+
                rts
; End of function Gfx_WriteDitherSequence
; Initializes sprite table with descending values
Gfx_InitSpriteTable:                                    ; CODE XREF: Stage_DemoInputHandler:loc_2771A   p  ; was: sub_2785A
                                        ; sub_27774   j
                movea.w #(word_FF9800-M68K_RAM),a0
                moveq   #$FFFFFFFF,d5
                move.w  #$6F,d7                         ; 'o'
loc_27864:                                              ; CODE XREF: Gfx_InitSpriteTable+10   j
                move.w  d5,(a0)+
                move.w  d5,(a0)+
                subq.w  #2,d5
                dbf     d7,loc_27864
                rts
; End of function Gfx_InitSpriteTable
; Renders 3D landscape using perspective division and texture mapping
Gfx_Render3DLandscape:                                  ; CODE XREF: Stage_DemoInputHandler+76   j  ; was: sub_27870
                                        ; sub_27722:loc_27756   j
                tst.w   (dword_FF807E).w
                beq.w   locret_27916
                move.l  #$8000,d4
                divu.w  (dword_FF807E).w,d4
                subi.w  #$A0,d4
                moveq   #0,d0
                move.w  (word_FF807C).w,d0
                ext.l   d0
                addi.l  #dword_27A2E,d0
                movea.l d0,a0
                movea.w #(word_FF9800-M68K_RAM),a1
                movea.w #(byte_FF9000-M68K_RAM),a2
                move.w  d4,d1
                asl.w   #3,d1
                moveq   #0,d0
                move.w  (word_FF8082).w,d0
                asl.w   #3,d0
                add.w   d1,d0
                swap    d0
                moveq   #0,d1
                move.w  (dword_FF807E).w,d1
                swap    d1
                asr.l   #5,d1
                moveq   #$FFFFFFFF,d5
                move.w  (dword_FF807E).w,d6
                move.w  #$6F,d7                         ; 'o'
loc_278C2:                                              ; CODE XREF: Gfx_Render3DLandscape+A2   j
                                        ; Gfx_Render3DLandscape+B2   j
                move.l  d0,d2
                bmi.s   loc_27918
                swap    d2
                cmpi.w  #$400,d2
                bpl.s   loc_27928
                andi.w  #$3F8,d2
                moveq   #0,d3
                move.w  (a0,d2.w),d3
                divu.w  d6,d3
                add.w   d5,d3
                move.w  d3,(a1)+
                moveq   #0,d3
                move.w  4(a0,d2.w),d3
                divu.w  d6,d3
                add.w   d5,d3
                move.w  d3,(a1)+
                moveq   #0,d3
                move.w  2(a0,d2.w),d3
                divu.w  d6,d3
                sub.w   d4,d3
                move.w  d3,(a2)
                move.w  d3,4(a2)
                moveq   #0,d3
                move.w  6(a0,d2.w),d3
                divu.w  d6,d3
                sub.w   d4,d3
                move.w  d3,2(a2)
                move.w  d3,6(a2)
                subq.w  #2,d5
                addq.w  #8,a2
                add.l   d1,d0
                dbf     d7,loc_278C2
locret_27916:                                           ; CODE XREF: Gfx_Render3DLandscape+4   j
                rts
; ---------------------------------------------------------------------------
loc_27918:                                              ; CODE XREF: Gfx_Render3DLandscape+54   j
                move.w  d5,(a1)+
                move.w  d5,(a1)+
                subq.w  #2,d5
                addq.w  #8,a2
                add.l   d1,d0
                dbf     d7,loc_278C2
                rts
; ---------------------------------------------------------------------------
loc_27928:                                              ; CODE XREF: Gfx_Render3DLandscape+5C   j
                                        ; Gfx_Render3DLandscape+BE   j
                move.w  d5,(a1)+
                move.w  d5,(a1)+
                subq.w  #2,d5
                dbf     d7,loc_27928
                rts
; End of function Gfx_Render3DLandscape
; Main state machine for tunnel/3D sequence
Stage_TunnelSequencer:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_27934
                move.w  4(a5),d0
                movea.w off_27944(pc,d0.w),a0
                adda.l  #Stage_TunnelInit,a0
                jmp     (a0)
; ---------------------------------------------------------------------------
off_27944:      dc.w    Stage_TunnelInit-Stage_TunnelInit
                                        ; DATA XREF: Stage_TunnelSequencer+4   r
                dc.w    Stage_TunnelLoadObjects-Stage_TunnelInit
                dc.w    Stage_TunnelStartEffect-Stage_TunnelInit
                dc.w    Stage_TunnelSetScroll-Stage_TunnelInit
                dc.w    Stage_TunnelUpdate-Stage_TunnelInit
; End of function Stage_TunnelSequencer
; Initializes tunnel sequence state and palette
Stage_TunnelInit:                                       ; DATA XREF: Stage_TunnelSequencer+8   o  ; was: sub_2794E
                                        ; sub_27934:off_27944   o
                move.w  #2,4(a5)
                move.w  #$100,2(a5)
                move.b  #4,(byte_FFA95B).w
                clr.w   (word_FF808A).w
                bra.w   Effect_ClearTransitionPatternBuffer
; End of function Stage_TunnelInit
; Loads objects for tunnel sequence
Stage_TunnelLoadObjects:                                ; DATA XREF: Stage_TunnelSequencer+12   o  ; was: sub_27968
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                lea     stru_27982(pc),a0
                nop
                jsr     (LoadObjData).l
                movem.l (sp)+,a5
                rts
; End of function Stage_TunnelLoadObjects
; ---------------------------------------------------------------------------
stru_27982:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_TunnelLoadObjects+8   o
                dc.l    byte_18D562                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF

; Starts tunnel visual effect with sound and scroll setup
Stage_TunnelStartEffect:                                ; DATA XREF: Stage_TunnelSequencer+14   o  ; was: sub_2798C
                addq.w  #2,4(a5)
                move.b  #3,(byte_FFA95B).w
                move.w  #4,(word_FF8090).w
                move.w  #$10,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #3,(word_FFF7E6+1).w
                clr.w   (word_FF807C).w
                move.b  #$AA,d0
                jsr     (Sound_PlaySFX).l
                move.w  #2,(word_FF807A).w
                rts
; End of function Stage_TunnelStartEffect
; Sets scroll parameters for tunnel sequence
Stage_TunnelSetScroll:                                  ; DATA XREF: Stage_TunnelSequencer+16   o  ; was: sub_279C2
                addq.w  #2,4(a5)
                move.l  #$18000,(dword_FF80A0).w
                bsr.w   Effect_BuildTransitionPattern
; End of function Stage_TunnelSetScroll
; Updates tunnel sequence with scroll and fade effects
Stage_TunnelUpdate:                                     ; DATA XREF: Stage_TunnelSequencer+18   o  ; was: sub_279D2
                bsr.w   Effect_UpdateScrollPosition
                move.w  $10(a5),(dword_FF807E).w
                move.w  $14(a5),(dword_FF807E+2).w
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                addq.w  #1,d0
                add.w   d0,(word_FF807C).w
                cmpi.w  #$7F,(word_FF807C).w
                bmi.s   loc_27A1A
                clr.w   (word_FF807A).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                clr.w   (word_FF8090).w
                bset    #4,2(a5)
                move.b  #4,(byte_FFA95B).w
                bra.w   Effect_ClearTransitionPatternBuffer
; ---------------------------------------------------------------------------
locret_27A18:                                           ; CODE XREF: Stage_TunnelUpdate+50   j
                rts
; ---------------------------------------------------------------------------
loc_27A1A:                                              ; CODE XREF: Stage_TunnelUpdate+24   j
                move.w  (word_FF807C).w,d0
                subi.w  #$4E,d0                         ; 'N'
                bmi.s   locret_27A18
                asr.w   #4,d0
                move.w  d0,(word_FF8082).w
                bra.w   Effect_ApplyTransitionMask
; End of function Stage_TunnelUpdate
; ---------------------------------------------------------------------------
dword_27A2E:    binclude "data/other/dword_27A2E.bin"
dword_27A2E_End:

; Initializes VDP register settings
