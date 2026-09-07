Effect_SetupScrollPointers:
                bra.s   loc_26C3C                       ; was: sub_26C58
; End of function Effect_SetupScrollPointers
; Sets d5 to alternate sine table address FFFF9B00 and branches to common scroll processing
Effect_ScrollSineTable1:
                move.l  #$FFFF9B00,d5                   ; was: sub_26C5A
                bra.s   loc_26C68
; End of function Effect_ScrollSineTable1
; Processes scroll effect using sine table at word_26FBC, interpolating 63 values based on word_FF807C
Effect_ScrollSineTable2:
                move.l  #word_26FBC,d5                  ; was: sub_26C62
loc_26C68:                                              ; CODE XREF: Effect_ScrollSineTable1+6   j
                movea.w #(word_FF9480-M68K_RAM),a0
                movea.w #(word_FF9480-M68K_RAM),a2
                moveq   #$FFFFFFFE,d6
                moveq   #$3E,d7                         ; '>'
                move.w  (word_FF807C).w,d1
                asl.w   #8,d1
                moveq   #0,d3
                move.w  (word_FF807C).w,d2
                beq.s   loc_26C94
                move.l  #$8000,d3
                divu.w  d2,d3
                andi.l  #$FFFF,d3
                asl.l   #1,d3
                asl.l   #8,d3
loc_26C94:                                              ; CODE XREF: Effect_ScrollSineTable2+1E   j
                moveq   #0,d2
loc_26C96:                                              ; CODE XREF: Effect_ScrollSineTable2+56   j
                cmpi.l  #$FE0000,d2
                bpl.s   loc_26CAE
                add.l   d3,d2
                move.l  d2,d4
                swap    d4
                ext.l   d4
                move.l  d5,d0
                sub.l   d4,d0
                and.l   d6,d0
                movea.l d0,a1
loc_26CAE:                                              ; CODE XREF: Effect_ScrollSineTable2+3A   j
                move.w  (a1),d0
                muls.w  d1,d0
                swap    d0
                move.w  d0,-(a0)
                move.w  d0,(a2)+
                dbf     d7,loc_26C96
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                rts
; End of function Effect_ScrollSineTable2
; Fills scroll buffer starting at offset -6C00 with value from dword_FF807E+2, repeating word_FF8082 times
Effect_FillScrollBuffer:                                ; CODE XREF: Effect_InitPaletteEffect+12   p  ; was: sub_26CCA
                move.w  (word_FF807C).w,d0
                andi.w  #$1FE,d0
                addi.w  #-$6C00,d0
                movea.w d0,a0
                move.w  (dword_FF807E+2).w,d1
                move.w  (word_FF8082).w,d7
loc_26CE0:                                              ; CODE XREF: Effect_FillScrollBuffer+18   j
                move.w  d1,(a0)+
                dbf     d7,loc_26CE0
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                rts
; End of function Effect_FillScrollBuffer
; Processes vertical scroll values for 127 entries, clamping to 0-160 range and computing scroll offsets
Effect_ProcessVerticalScroll:
                moveq   #1,d1                           ; was: sub_26CF4
                move.w  #$FE,d2
                move.w  #$FFFE,d3
                move.w  #$120,d4
                moveq   #$7E,d7                         ; '~'
loc_26D04:                                              ; CODE XREF: Effect_ProcessVerticalScroll+56   j
                move.w  (a0)+,d0
                asl.w   #1,d0
                move.w  d4,d5
                sub.w   d0,d5
                and.w   d3,d5
                bpl.s   loc_26D1C
                asr.w   #1,d5
                add.w   d5,d0
                bpl.s   loc_26D18
                moveq   #0,d0
loc_26D18:                                              ; CODE XREF: Effect_ProcessVerticalScroll+20   j
                moveq   #0,d5
                bra.s   loc_26D3E
; ---------------------------------------------------------------------------
loc_26D1C:                                              ; CODE XREF: Effect_ProcessVerticalScroll+1A   j
                cmpi.w  #$140,d5
                bmi.s   loc_26D28
                moveq   #0,d5
                moveq   #0,d0
                bra.s   loc_26D3E
; ---------------------------------------------------------------------------
loc_26D28:                                              ; CODE XREF: Effect_ProcessVerticalScroll+2C   j
                move.w  d0,d6
                add.w   d5,d6
                cmpi.w  #$A0,d6
                bmi.s   loc_26D3E
                subi.w  #$A0,d0
                add.w   d5,d0
                bpl.s   loc_26D3E
                moveq   #0,d5
                moveq   #0,d0
loc_26D3E:                                              ; CODE XREF: Effect_ProcessVerticalScroll+26   j
                                        ; Effect_ProcessVerticalScroll+32   j
                move.w  d5,(a3)+
                move.w  d5,(a3)+
                sub.w   d1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                addq.w  #2,d1
                dbf     d7,loc_26D04
                rts
; End of function Effect_ProcessVerticalScroll
; Processes horizontal scroll data for 127 scanlines, calculating doubled scroll offsets with 160-pixel wraparound
Effect_ProcessHorizontalScroll:
                moveq   #1,d1                           ; was: sub_26D50
                move.w  #$FE,d2
                move.w  #$FFFE,d3
                move.w  #$A0,d4
                moveq   #$7E,d7                         ; '~'
loc_26D60:                                              ; CODE XREF: Effect_ProcessHorizontalScroll+2A   j
                move.w  (a0),d0
                sub.w   d1,d0
                asl.w   #1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                move.w  (a0)+,d0
                asl.w   #1,d0
                move.w  d4,d5
                sub.w   d0,d5
                and.w   d3,d5
                move.w  d5,(a3)+
                move.w  d5,(a3)+
                addq.w  #1,d1
                dbf     d7,loc_26D60
                rts
; End of function Effect_ProcessHorizontalScroll
; Processes scroll with conditional vertical calculation based on dword_FF807E flag, quadruples values if enabled
Effect_ProcessConditionalScroll:                        ; CODE XREF: Effect_InitializePaletteEffects+8   p  ; was: sub_26D80
                moveq   #1,d1
                move.w  #$FE,d2
                move.w  #$A0,d4
                moveq   #$7E,d7                         ; '~'
loc_26D8C:                                              ; CODE XREF: Effect_ProcessConditionalScroll+2E   j
                move.w  (a0)+,d0
                sub.w   d1,d0
                asl.w   #1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                tst.w   (dword_FF807E).w
                beq.s   loc_26DAC
                move.w  -2(a0),d0
                asl.w   #2,d0
                move.w  #$140,d3
                sub.w   d0,d3
                move.w  d3,(a3)+
                move.w  d3,(a3)+
loc_26DAC:                                              ; CODE XREF: Effect_ProcessConditionalScroll+1A   j
                addq.w  #1,d1
                dbf     d7,loc_26D8C
                rts
; End of function Effect_ProcessConditionalScroll
; Simple scroll processor that applies constant vertical offset from dword_FF807E to 127 horizontal scroll entries
Effect_ProcessSimpleScroll:                             ; CODE XREF: Effect_InitPaletteEffect+16   j  ; was: sub_26DB4
                moveq   #1,d1
                move.w  #$FE,d2
                moveq   #$7E,d7                         ; '~'
                move.w  (dword_FF807E).w,d6
loc_26DC0:                                              ; CODE XREF: Effect_ProcessSimpleScroll+1C   j
                move.w  (a0)+,d0
                sub.w   d1,d0
                asl.w   #1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                move.w  d6,(a3)+
                move.w  d6,(a3)+
                addq.w  #1,d1
                dbf     d7,loc_26DC0
                rts
; End of function Effect_ProcessSimpleScroll
; Initializes palette buffer pointers
Effect_InitPaletteBuffers:                              ; CODE XREF: Effect_PaletteUpdateMain   p  ; was: sub_26DD6
                                        ; sub_26BAE   p
                movea.w #(word_FF9500-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a1
                moveq   #6,d7
; End of function Effect_InitPaletteBuffers
; Copies palette data between buffers
Effect_CopyPaletteData:                                 ; CODE XREF: Effect_CopyPaletteData+10   j  ; was: sub_26DE0
                                        ; Effect_ComplexScrollWave+A   p
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                dbf     d7,Effect_CopyPaletteData
                rts
; End of function Effect_CopyPaletteData
; Applies sine wave modulation to scroll buffer using word_26EBC table and word_1B494 multiplier data
Effect_ApplySineWaveScroll:
                movea.l #word_26EBC,a0                  ; was: sub_26DF6
                movea.w #(dword_FF9A00-M68K_RAM),a1
                movea.l #word_1B494,a2
                moveq   #$7F,d7
                move.w  (dword_FF807E).w,d1
                andi.w  #$1FE,d1
loc_26E10:                                              ; CODE XREF: Effect_ApplySineWaveScroll+2C   j
                move.w  (a0)+,d2
                mulu.w  (a2,d1.w),d2
                asl.l   #3,d2
                swap    d2
                move.w  d2,(a1)+
                addq.w  #1,d1
                andi.w  #$FE,d1
                dbf     d7,loc_26E10
                rts
; End of function Effect_ApplySineWaveScroll
; Applies linear interpolation to scroll buffer using accumulator from dword_FF807E added to word_26EBC base values
Effect_ApplyLinearScroll:
                movea.l #word_26EBC,a0                  ; was: sub_26E28
                movea.w #(dword_FF9A00-M68K_RAM),a1
                moveq   #$7F,d7
                moveq   #0,d0
                move.l  (dword_FF807E).w,d1
loc_26E3A:                                              ; CODE XREF: Effect_ApplyLinearScroll+1E   j
                add.l   d1,d0
                swap    d0
                move.w  (a0)+,d2
                add.w   d0,d2
                swap    d0
                move.w  d2,(a1)+
                dbf     d7,loc_26E3A
                rts
; End of function Effect_ApplyLinearScroll
; Updates scroll position for effect
Effect_UpdateScrollPosition:                            ; CODE XREF: Boss_DefeatScrollUpdate   p  ; was: sub_26E4C
                                        ; sub_26A9E   p
                movea.w #(word_FFE37C-M68K_RAM),a1
                move.w  (word_FF807C).w,d0
                subi.w  #$40,d0                         ; '@'
                bpl.s   loc_26E7A
                move.w  #$EEE,d0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_26E72
                btst    #0,(dword_FFFF08).w
                bne.s   loc_26E72
                move.w  #$8CE,d0
loc_26E72:                                              ; CODE XREF: Effect_UpdateScrollPosition+18   j
                                        ; Effect_UpdateScrollPosition+20   j
                move.w  d0,$80(a1)
                move.w  d0,(a1)
                rts
; ---------------------------------------------------------------------------
loc_26E7A:                                              ; CODE XREF: Effect_UpdateScrollPosition+C   j
                asr.w   #1,d0
                andi.w  #$1E,d0
                move.w  word_26E8C(pc,d0.w),$80(a1)
                move.w  word_26E8C(pc,d0.w),(a1)
                rts
; End of function Effect_UpdateScrollPosition
; ---------------------------------------------------------------------------
word_26E8C:     dc.w    $EEE, $CEE, $AEE, $8EE, $6EE, $4CE, $2AE, $8E, $6E, $4E, $2E, $E, $C, $A, 8, 6
                                        ; DATA XREF: Effect_UpdateScrollPosition+34   r
                                        ; Effect_UpdateScrollPosition+3A   r

; Clears 64 longwords of scroll buffer starting at dword_FF9400 to zero
Effect_ClearScrollBuffer:                               ; CODE XREF: Effect_InitPaletteEffect:loc_26BC6   p  ; was: sub_26EAC
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #0,d0
                moveq   #$3F,d7                         ; '?'
loc_26EB4:                                              ; CODE XREF: Effect_ClearScrollBuffer+A   j
                move.l  d0,(a0)+
                dbf     d7,loc_26EB4
                rts
; End of function Effect_ClearScrollBuffer
; ---------------------------------------------------------------------------
word_26EBC:     binclude "data/other/word_26EBC.bin"
word_26EBC_End:
word_26FBC:     binclude "data/other/word_26FBC.bin"
word_26FBC_End:

; Applies palette data to VDP during VBlank
Effect_ApplyPaletteToVDP:                               ; CODE XREF: Effect_PaletteUpdateMain+4   j  ; was: sub_271BC
                movea.w #(byte_FF9B00-M68K_RAM),a0
                movea.w #(byte_FF9B00-M68K_RAM),a2
                movea.l #word_26FBC,a1
                move.w  #$FF00,d5
                moveq   #$FFFFFFFE,d6
                move.w  #$7E,d7                         ; '~'
                move.w  (word_FF807C).w,d1
                asl.w   #8,d1
                asl.w   #1,d1
                moveq   #0,d3
                move.w  (word_FF807C).w,d2
                beq.s   loc_271F4
                move.l  (dword_FF80A0).w,d3
                divu.w  d2,d3
                andi.l  #$FFFF,d3
                asl.l   #1,d3
                asl.l   #8,d3
loc_271F4:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+26   j
                moveq   #0,d2
loc_271F6:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+5A   j
                sub.l   d3,d2
                move.l  d2,d4
                swap    d4
                and.l   d6,d4
                cmp.w   d5,d4
                bpl.s   loc_27206
                moveq   #0,d0
                bra.s   loc_27212
; ---------------------------------------------------------------------------
loc_27206:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+44   j
                move.w  (a1,d4.w),d0
                mulu.w  d1,d0
                swap    d0
                andi.w  #$FFFE,d0
loc_27212:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+48   j
                move.w  d0,-(a0)
                move.w  d0,(a2)+
                dbf     d7,loc_271F6
                movea.w #(dword_FF9A00-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                move.w  (dword_FF807E).w,d4
                subi.w  #$80,d4
                move.w  (dword_FF807E+2).w,d0
                subi.w  #$180,d0
                neg.w   d0
                andi.w  #$FFFE,d0
                adda.w  d0,a0
                moveq   #2,d1
                move.w  #$FE,d2
                moveq   #$7E,d7                         ; '~'
loc_27246:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+E6   j
                move.w  (a0)+,d0
                cmpa.w  #$9A02,a0
                bmi.s   loc_27254
                cmpa.w  #$9C00,a0
                bmi.s   loc_27256
loc_27254:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+90   j
                moveq   #0,d0
loc_27256:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+96   j
                move.w  d4,d5
                sub.w   d0,d5
                move.w  d5,d6
                bmi.s   loc_27264
                cmpi.w  #4,d5
                bpl.s   loc_27276
loc_27264:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+A0   j
                asr.w   #1,d5
                add.w   d5,d0
                bpl.s   loc_2726C
loc_2726A:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+C8   j
                moveq   #0,d0
loc_2726C:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+AC   j
                moveq   #0,d5
                andi.w  #2,d6
                add.w   d6,d5
                bra.s   loc_27298
; ---------------------------------------------------------------------------
loc_27276:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+A6   j
                cmpi.w  #$9E,d0
                bmi.s   loc_27280
                move.w  #$9E,d0
loc_27280:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+BE   j
                cmpi.w  #$140,d5
                bpl.s   loc_2726A
                move.w  d5,d3
                asr.w   #1,d3
                add.w   d0,d3
                cmpi.w  #$100,d3
                bmi.s   loc_27298
                move.w  #$140,d0
                sub.w   d5,d0
loc_27298:                                              ; CODE XREF: Effect_ApplyPaletteToVDP+B8   j
                                        ; Effect_ApplyPaletteToVDP+D4   j
                move.w  d5,(a3)+
                sub.w   d1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                addq.w  #2,d1
                dbf     d7,loc_27246
                rts
; End of function Effect_ApplyPaletteToVDP
; Clears palette effect buffer and resets state counters
Effect_ClearPaletteBuffer:                              ; CODE XREF: Boss_DefeatInitAnimation+16   j  ; was: sub_272A8
                                        ; Effect_TransitionInit+16   j
                clr.w   (word_FF8082).w
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #0,d0
                moveq   #$17,d7
loc_272B4:                                              ; CODE XREF: Effect_ClearPaletteBuffer+E   j
                move.l  d0,(a0)+
                dbf     d7,loc_272B4
                bra.w   loc_27376
; End of function Effect_ClearPaletteBuffer
; Updates scroll values for transition
Effect_ScrollUpdate:                                    ; CODE XREF: Effect_SetupScroll+C   p  ; was: sub_272BE
                                        ; Stage_TunnelSetScroll+C   p
                moveq   #0,d0
                move.l  #$EEEE0000,d1
                move.l  #$EEEEEEEE,d2
                move.l  d0,d3
                move.l  d1,d4
                move.l  d2,d5
loc_272D2:                                              ; CODE XREF: Effect_ScrollMaskPattern1+38   j
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #3,d7
loc_272D8:                                              ; CODE XREF: Effect_ScrollUpdate+1E   j
                move.l  d2,(a0)+
                move.l  d5,(a0)+
                dbf     d7,loc_272D8
                move.l  d0,(a0)+
                move.l  d3,(a0)+
                move.l  d1,(a0)+
                move.l  d4,(a0)+
                move.l  d2,(a0)+
                move.l  d5,(a0)+
                move.l  d2,(a0)+
                move.l  d5,(a0)+
                moveq   #2,d7
loc_272F2:                                              ; CODE XREF: Effect_ScrollUpdate+38   j
                move.l  d0,(a0)+
                move.l  d3,(a0)+
                dbf     d7,loc_272F2
                move.l  d1,(a0)+
                move.l  d4,(a0)+
                bra.w   loc_27376
; End of function Effect_ScrollUpdate
; Initializes special scroll pattern with EEEEEEEE values for boss defeat effect, sets up 40 bytes of pattern
Effect_InitDefeatScroll:                                ; CODE XREF: Boss_DefeatScrollInit+C   p  ; was: sub_27302
                moveq   #0,d0
                move.l  #$EEEEEEEE,d2
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #7,d7
loc_27310:                                              ; CODE XREF: Effect_InitDefeatScroll+10   j
                move.l  d2,(a0)+
                dbf     d7,loc_27310
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                moveq   #7,d7
loc_27328:                                              ; CODE XREF: Effect_InitDefeatScroll+28   j
                move.l  d0,(a0)+
                dbf     d7,loc_27328
                bra.w   loc_27376
; End of function Effect_InitDefeatScroll
; Masks individual scroll buffer byte based on word_FF8082 timer, using lookup table to select byte offset
Effect_MaskScrollByte:
                movea.w #(dword_FF9400-M68K_RAM),a0     ; was: sub_27332
                lea     word_2739C(pc),a1
                nop
                move.b  #$F,d3
                move.w  (word_FF8082).w,d0
                cmpi.w  #$20,d0                         ; ' '
                bmi.s   loc_2734E
                move.b  #$F0,d3
loc_2734E:                                              ; CODE XREF: Effect_MaskScrollByte+16   j
                andi.w  #$1F,d0
                moveq   #0,d2
                move.b  (a1,d0.w),d2
                move.b  (a0,d2.w),d1
                and.b   d3,d1
                move.b  d1,(a0,d2.w)
                move.b  $20(a0,d2.w),d1
                and.b   d3,d1
                move.b  d1,$20(a0,d2.w)
                move.b  $40(a0,d2.w),d1
                and.b   d3,d1
                move.b  d1,$40(a0,d2.w)
loc_27376:                                              ; CODE XREF: Effect_ClearPaletteBuffer+12   j
                                        ; Effect_ScrollUpdate+40   j
                movea.w (word_FFF70C).w,a1
                move.w  #$82,-(a1)
                move.w  #$73A0,-(a1)
                move.w  #$9500,-(a1)
                move.w  #$96CA,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009330,-(a1)
                move.w  a1,(word_FFF70C).w
                rts
; End of function Effect_MaskScrollByte
; ---------------------------------------------------------------------------
word_2739C:     dc.w    $10, $111, $212, $313, $414, $515, $616, $717, $818, $919, $A1A, $B1B, $C1C, $D1D, $E1E, $F1F
                                        ; DATA XREF: Effect_MaskScrollByte+4   o

; Resets transition effect state
Effect_ResetTransitionState:                            ; CODE XREF: Boss_DefeatScrollUpdate+1A   j  ; was: sub_273BC
                                        ; Effect_UpdateTransition+2C   j
                lea     dword_2740E(pc),a1
                nop
                move.w  (word_FF807C).w,d2
                asr.w   #2,d2
                andi.w  #$1C,d2
                move.l  (a1,d2.w),d0
                move.l  $20(a1,d2.w),d1
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(dword_FF9420-M68K_RAM),a1
                movea.w #(word_FF9440-M68K_RAM),a2
                moveq   #3,d7
loc_273E2:                                              ; CODE XREF: Effect_ResetTransitionState+4A   j
                move.l  (a0),d2
                move.l  (a1),d3
                move.l  (a2),d4
                and.l   d0,d2
                and.l   d0,d3
                and.l   d0,d4
                move.l  d2,(a0)+
                move.l  d3,(a1)+
                move.l  d4,(a2)+
                move.l  (a0),d2
                move.l  (a1),d3
                move.l  (a2),d4
                and.l   d1,d2
                and.l   d1,d3
                and.l   d1,d4
                move.l  d2,(a0)+
                move.l  d3,(a1)+
                move.l  d4,(a2)+
                dbf     d7,loc_273E2
                bra.w   loc_27376
; End of function Effect_ResetTransitionState
; ---------------------------------------------------------------------------
dword_2740E:    dc.l    $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFF0FFF
                                        ; DATA XREF: Effect_ResetTransitionState   o
                dc.l    $F0F0F0F, $F0F0F0F, $F0F0F0F, $F000F
                dc.l    $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFF0FFF0
                dc.l    $F0F0F0F0, $F0F0F0F0, $F0F0F0F0, $F000F000

; Applies masked scroll pattern using time-based lookup from dword_2748A table, creates layered effect masks
Effect_ScrollMaskPattern1:
                lea     dword_2748A(pc),a1              ; was: sub_2744E
                nop
                move.w  (word_FF807C).w,d2
                asr.w   #2,d2
                andi.w  #$1C,d2
                move.l  (a1,d2.w),d6
                move.l  $20(a1,d2.w),d7
                moveq   #0,d0
                move.l  #$EEEE0000,d1
                move.l  #$EEEEEEEE,d2
                move.l  d0,d3
                move.l  d1,d4
                move.l  d2,d5
                and.l   d6,d0
                and.l   d6,d1
                and.l   d6,d2
                and.l   d7,d3
                and.l   d7,d4
                and.l   d7,d5
                bra.w   loc_272D2
; End of function Effect_ScrollMaskPattern1
; ---------------------------------------------------------------------------
dword_2748A:    dc.l    $FFFFFFFF, $FFFFFFF, $FFF0FFF, $F0F0FFF
                                        ; DATA XREF: Effect_ScrollMaskPattern1   o
                dc.l    $F0F0F0F, $F0F0F, $F000F, $F
                dc.l    $FFFFFFFF, $FFFFFFF0, $FFF0FFF0, $FFF0F0F0
                dc.l    $F0F0F0F0, $F0F0F000, $F000F000, $F0000000

; Complex scroll wave effect combining palette copy, sine table scrolling, and clamped vertical offset calculations
Effect_ComplexScrollWave:                               ; DATA XREF: ROM:00026BA4   o  ; was: sub_274CA
                movea.w #(word_FF9500-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a1
                moveq   #3,d7
                bsr.w   Effect_CopyPaletteData
                movea.w #(byte_FF9A80-M68K_RAM),a0
                movea.w #(byte_FF9A80-M68K_RAM),a2
                movea.l #word_26FBC,a1
                move.w  #$FF00,d5
                moveq   #$FFFFFFFE,d6
                move.w  #$3E,d7                         ; '>'
                move.w  (word_FF807C).w,d1
                asl.w   #8,d1
                asl.w   #1,d1
                moveq   #0,d3
                move.w  (word_FF807C).w,d2
                beq.s   loc_27510
                move.l  (dword_FF80A0).w,d3
                divu.w  d2,d3
                andi.l  #$FFFF,d3
                asl.l   #1,d3
                asl.l   #8,d3
loc_27510:                                              ; CODE XREF: Effect_ComplexScrollWave+34   j
                moveq   #0,d2
loc_27512:                                              ; CODE XREF: Effect_ComplexScrollWave+68   j
                sub.l   d3,d2
                move.l  d2,d4
                swap    d4
                and.w   d6,d4
                cmp.w   d5,d4
                bpl.s   loc_27522
                moveq   #0,d0
                bra.s   loc_2752E
; ---------------------------------------------------------------------------
loc_27522:                                              ; CODE XREF: Effect_ComplexScrollWave+52   j
                move.w  (a1,d4.w),d0
                mulu.w  d1,d0
                swap    d0
                andi.w  #$FFFC,d0
loc_2752E:                                              ; CODE XREF: Effect_ComplexScrollWave+56   j
                move.w  d0,-(a0)
                move.w  d0,(a2)+
                dbf     d7,loc_27512
                movea.w #(dword_FF9A00-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                move.w  (dword_FF807E).w,d4
                subi.w  #$80,d4
                move.w  (dword_FF807E+2).w,d0
                subi.w  #$180,d0
                asr.w   #1,d0
                neg.w   d0
                andi.w  #$FFFE,d0
                adda.w  d0,a0
                moveq   #4,d1
                move.w  #$FC,d2
                moveq   #$3E,d7                         ; '>'
loc_27564:                                              ; CODE XREF: Effect_ComplexScrollWave+F6   j
                move.w  (a0)+,d0
                cmpa.w  #$9A02,a0
                bmi.s   loc_27572
                cmpa.w  #$9B00,a0
                bmi.s   loc_27574
loc_27572:                                              ; CODE XREF: Effect_ComplexScrollWave+A0   j
                moveq   #0,d0
loc_27574:                                              ; CODE XREF: Effect_ComplexScrollWave+A6   j
                move.w  d4,d5
                sub.w   d0,d5
                move.w  d5,d6
                bmi.s   loc_27582
                cmpi.w  #8,d5
                bpl.s   loc_27594
loc_27582:                                              ; CODE XREF: Effect_ComplexScrollWave+B0   j
                asr.w   #1,d5
                add.w   d5,d0
                bpl.s   loc_2758A
loc_27588:                                              ; CODE XREF: Effect_ComplexScrollWave+D8   j
                moveq   #0,d0
loc_2758A:                                              ; CODE XREF: Effect_ComplexScrollWave+BC   j
                moveq   #0,d5
                andi.w  #4,d6
                add.w   d6,d5
                bra.s   loc_275B6
; ---------------------------------------------------------------------------
loc_27594:                                              ; CODE XREF: Effect_ComplexScrollWave+B6   j
                cmpi.w  #$9E,d0
                bmi.s   loc_2759E
                move.w  #$9E,d0
loc_2759E:                                              ; CODE XREF: Effect_ComplexScrollWave+CE   j
                cmpi.w  #$140,d5
                bpl.s   loc_27588
                move.w  d5,d3
                asr.w   #1,d3
                add.w   d0,d3
                cmpi.w  #$100,d3
                bmi.s   loc_275B6
                move.w  #$140,d0
                sub.w   d5,d0
loc_275B6:                                              ; CODE XREF: Effect_ComplexScrollWave+C8   j
                                        ; Effect_ComplexScrollWave+E4   j
                move.w  d5,(a3)+
                sub.w   d1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                addq.w  #4,d1
                dbf     d7,loc_27564
                rts
; End of function Effect_ComplexScrollWave
; Initializes game over state, loads objects, sets up VDP registers, initializes various game state flags
