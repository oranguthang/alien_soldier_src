Effect_SetupScrollPointers:
                bra.s   TransitionEffect_SetOutputBufferPointers  ; was: sub_26C58
; End of function Effect_SetupScrollPointers
; Sets d5 to alternate sine table address FFFF9B00 and branches to common scroll processing
Effect_ScrollSineTable1:
                move.l  #$FFFF9B00,d5                   ; was: sub_26C5A
                bra.s   Effect_BuildSineScrollBuffer
; End of function Effect_ScrollSineTable1
; Processes scroll effect using sine table at Effect_TransitionSineTable, interpolating 63 values based on word_FF807C
Effect_ScrollSineTable2:
                move.l  #Effect_TransitionSineTable,d5  ; was: sub_26C62
Effect_BuildSineScrollBuffer:                           ; CODE XREF: Effect_ScrollSineTable1+6   j  ; was: loc_26C68
                movea.w #(word_FF9480-M68K_RAM),a0
                movea.w #(word_FF9480-M68K_RAM),a2
                moveq   #$FFFFFFFE,d6
                moveq   #$3E,d7                         ; '>'
                move.w  (word_FF807C).w,d1
                asl.w   #8,d1
                moveq   #0,d3
                move.w  (word_FF807C).w,d2
                beq.s   Effect_BuildSineScrollBuffer_BeginLoop
                move.l  #$8000,d3
                divu.w  d2,d3
                andi.l  #$FFFF,d3
                asl.l   #1,d3
                asl.l   #8,d3
Effect_BuildSineScrollBuffer_BeginLoop:                 ; CODE XREF: Effect_ScrollSineTable2+1E   j  ; was: loc_26C94
                moveq   #0,d2
Effect_BuildSineScrollBuffer_Loop:                      ; CODE XREF: Effect_ScrollSineTable2+56   j  ; was: loc_26C96
                cmpi.l  #$FE0000,d2
                bpl.s   Effect_BuildSineScrollBuffer_StoreSample
                add.l   d3,d2
                move.l  d2,d4
                swap    d4
                ext.l   d4
                move.l  d5,d0
                sub.l   d4,d0
                and.l   d6,d0
                movea.l d0,a1
Effect_BuildSineScrollBuffer_StoreSample:               ; CODE XREF: Effect_ScrollSineTable2+3A   j  ; was: loc_26CAE
                move.w  (a1),d0
                muls.w  d1,d0
                swap    d0
                move.w  d0,-(a0)
                move.w  d0,(a2)+
                dbf     d7,Effect_BuildSineScrollBuffer_Loop
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                rts
; End of function Effect_ScrollSineTable2
; Fills scroll buffer starting at offset -6C00 with value from dword_FF807E+2, repeating word_FF8082 times
Effect_FillScrollBuffer:                                ; CODE XREF: TransitionEffect_UpdateMode3Buffers+12   p  ; was: sub_26CCA
                move.w  (word_FF807C).w,d0
                andi.w  #$1FE,d0
                addi.w  #-$6C00,d0
                movea.w d0,a0
                move.w  (dword_FF807E+2).w,d1
                move.w  (word_FF8082).w,d7
Effect_FillScrollBuffer_Loop:                           ; CODE XREF: Effect_FillScrollBuffer+18   j  ; was: loc_26CE0
                move.w  d1,(a0)+
                dbf     d7,Effect_FillScrollBuffer_Loop
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
Effect_ProcessVerticalScroll_Loop:                      ; CODE XREF: Effect_ProcessVerticalScroll+56   j  ; was: loc_26D04
                move.w  (a0)+,d0
                asl.w   #1,d0
                move.w  d4,d5
                sub.w   d0,d5
                and.w   d3,d5
                bpl.s   Effect_ProcessVerticalScroll_CheckUpperBound
                asr.w   #1,d5
                add.w   d5,d0
                bpl.s   Effect_ProcessVerticalScroll_ClampLow
                moveq   #0,d0
Effect_ProcessVerticalScroll_ClampLow:                  ; CODE XREF: Effect_ProcessVerticalScroll+20   j  ; was: loc_26D18
                moveq   #0,d5
                bra.s   Effect_ProcessVerticalScroll_Store
; ---------------------------------------------------------------------------
Effect_ProcessVerticalScroll_CheckUpperBound:           ; CODE XREF: Effect_ProcessVerticalScroll+1A   j  ; was: loc_26D1C
                cmpi.w  #$140,d5
                bmi.s   Effect_ProcessVerticalScroll_AdjustCenter
                moveq   #0,d5
                moveq   #0,d0
                bra.s   Effect_ProcessVerticalScroll_Store
; ---------------------------------------------------------------------------
Effect_ProcessVerticalScroll_AdjustCenter:              ; CODE XREF: Effect_ProcessVerticalScroll+2C   j  ; was: loc_26D28
                move.w  d0,d6
                add.w   d5,d6
                cmpi.w  #$A0,d6
                bmi.s   Effect_ProcessVerticalScroll_Store
                subi.w  #$A0,d0
                add.w   d5,d0
                bpl.s   Effect_ProcessVerticalScroll_Store
                moveq   #0,d5
                moveq   #0,d0
Effect_ProcessVerticalScroll_Store:                     ; CODE XREF: Effect_ProcessVerticalScroll+26   j  ; was: loc_26D3E
                                        ; Effect_ProcessVerticalScroll+32   j
                move.w  d5,(a3)+
                move.w  d5,(a3)+
                sub.w   d1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                addq.w  #2,d1
                dbf     d7,Effect_ProcessVerticalScroll_Loop
                rts
; End of function Effect_ProcessVerticalScroll
; Processes horizontal scroll data for 127 scanlines, calculating doubled scroll offsets with 160-pixel wraparound
Effect_ProcessHorizontalScroll:
                moveq   #1,d1                           ; was: sub_26D50
                move.w  #$FE,d2
                move.w  #$FFFE,d3
                move.w  #$A0,d4
                moveq   #$7E,d7                         ; '~'
Effect_ProcessHorizontalScroll_Loop:                    ; CODE XREF: Effect_ProcessHorizontalScroll+2A   j  ; was: loc_26D60
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
                dbf     d7,Effect_ProcessHorizontalScroll_Loop
                rts
; End of function Effect_ProcessHorizontalScroll
; Processes scroll with conditional vertical calculation based on dword_FF807E flag, quadruples values if enabled
Effect_ProcessConditionalScroll:                        ; CODE XREF: TransitionEffect_UpdateMode2Buffers+8   p  ; was: sub_26D80
                moveq   #1,d1
                move.w  #$FE,d2
                move.w  #$A0,d4
                moveq   #$7E,d7                         ; '~'
Effect_ProcessConditionalScroll_Loop:                   ; CODE XREF: Effect_ProcessConditionalScroll+2E   j  ; was: loc_26D8C
                move.w  (a0)+,d0
                sub.w   d1,d0
                asl.w   #1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                tst.w   (dword_FF807E).w
                beq.s   Effect_ProcessConditionalScroll_Next
                move.w  -2(a0),d0
                asl.w   #2,d0
                move.w  #$140,d3
                sub.w   d0,d3
                move.w  d3,(a3)+
                move.w  d3,(a3)+
Effect_ProcessConditionalScroll_Next:                   ; CODE XREF: Effect_ProcessConditionalScroll+1A   j  ; was: loc_26DAC
                addq.w  #1,d1
                dbf     d7,Effect_ProcessConditionalScroll_Loop
                rts
; End of function Effect_ProcessConditionalScroll
; Simple scroll processor that applies constant vertical offset from dword_FF807E to 127 horizontal scroll entries
Effect_ProcessSimpleScroll:                             ; CODE XREF: TransitionEffect_UpdateMode3Buffers+16   j  ; was: sub_26DB4
                moveq   #1,d1
                move.w  #$FE,d2
                moveq   #$7E,d7                         ; '~'
                move.w  (dword_FF807E).w,d6
Effect_ProcessSimpleScroll_Loop:                        ; CODE XREF: Effect_ProcessSimpleScroll+1C   j  ; was: loc_26DC0
                move.w  (a0)+,d0
                sub.w   d1,d0
                asl.w   #1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                move.w  d6,(a3)+
                move.w  d6,(a3)+
                addq.w  #1,d1
                dbf     d7,Effect_ProcessSimpleScroll_Loop
                rts
; End of function Effect_ProcessSimpleScroll
; Copies seven 32-byte blocks from the active output buffer into its working copy
TransitionEffect_CopyWorkingBuffer:                     ; CODE XREF: TransitionEffect_UpdateMode1Buffers   p  ; was: sub_26DD6
                                        ; TransitionEffect_UpdateMode2Buffers   p
                movea.w #(word_FF9500-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a1
                moveq   #6,d7
; End of function TransitionEffect_CopyWorkingBuffer
; Copies d7+1 blocks of 32 bytes from a1 to a0
Effect_Copy32ByteBlocks:                                ; CODE XREF: Effect_Copy32ByteBlocks+10   j  ; was: sub_26DE0
                                        ; TransitionEffect_UpdateMode4Buffers+A   p
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                move.l  (a1)+,(a0)+
                dbf     d7,Effect_Copy32ByteBlocks
                rts
; End of function Effect_Copy32ByteBlocks
; Applies sine wave modulation to scroll buffer using Effect_LinearScrollBaseTable table and Math_QuarterSineTable multiplier data
Effect_ApplySineWaveScroll:
                movea.l #Effect_LinearScrollBaseTable,a0  ; was: sub_26DF6
                movea.w #(dword_FF9A00-M68K_RAM),a1
                movea.l #Math_QuarterSineTable,a2
                moveq   #$7F,d7
                move.w  (dword_FF807E).w,d1
                andi.w  #$1FE,d1
Effect_ApplySineWaveScroll_Loop:                        ; CODE XREF: Effect_ApplySineWaveScroll+2C   j  ; was: loc_26E10
                move.w  (a0)+,d2
                mulu.w  (a2,d1.w),d2
                asl.l   #3,d2
                swap    d2
                move.w  d2,(a1)+
                addq.w  #1,d1
                andi.w  #$FE,d1
                dbf     d7,Effect_ApplySineWaveScroll_Loop
                rts
; End of function Effect_ApplySineWaveScroll
; Applies linear interpolation to scroll buffer using accumulator from dword_FF807E added to Effect_LinearScrollBaseTable base values
Effect_ApplyLinearScroll:
                movea.l #Effect_LinearScrollBaseTable,a0  ; was: sub_26E28
                movea.w #(dword_FF9A00-M68K_RAM),a1
                moveq   #$7F,d7
                moveq   #0,d0
                move.l  (dword_FF807E).w,d1
Effect_ApplyLinearScroll_Loop:                          ; CODE XREF: Effect_ApplyLinearScroll+1E   j  ; was: loc_26E3A
                add.l   d1,d0
                swap    d0
                move.w  (a0)+,d2
                add.w   d0,d2
                swap    d0
                move.w  d2,(a1)+
                dbf     d7,Effect_ApplyLinearScroll_Loop
                rts
; End of function Effect_ApplyLinearScroll
; Updates scroll position for effect
Effect_UpdateScrollPosition:                            ; CODE XREF: AlternateTransition_Update   p  ; was: sub_26E4C
                                        ; TransitionEffect_Update   p
                movea.w #(word_FFE37C-M68K_RAM),a1
                move.w  (word_FF807C).w,d0
                subi.w  #$40,d0                         ; '@'
                bpl.s   Effect_UpdateScrollPosition_SelectPattern
                move.w  #$EEE,d0
                btst    #0,(FrameCounter+1).w
                bne.s   Effect_UpdateScrollPosition_StoreInitialPattern
                btst    #0,(RandomNumberState).w
                bne.s   Effect_UpdateScrollPosition_StoreInitialPattern
                move.w  #$8CE,d0
Effect_UpdateScrollPosition_StoreInitialPattern:        ; CODE XREF: Effect_UpdateScrollPosition+18   j  ; was: loc_26E72
                                        ; Effect_UpdateScrollPosition+20   j
                move.w  d0,$80(a1)
                move.w  d0,(a1)
                rts
; ---------------------------------------------------------------------------
Effect_UpdateScrollPosition_SelectPattern:              ; CODE XREF: Effect_UpdateScrollPosition+C   j  ; was: loc_26E7A
                asr.w   #1,d0
                andi.w  #$1E,d0
                move.w  Effect_TransitionPatternRamp(pc,d0.w),$80(a1)
                move.w  Effect_TransitionPatternRamp(pc,d0.w),(a1)
                rts
; End of function Effect_UpdateScrollPosition
; ---------------------------------------------------------------------------
Effect_TransitionPatternRamp:   dc.w    $EEE, $CEE, $AEE, $8EE, $6EE, $4CE, $2AE, $8E, $6E, $4E, $2E, $E, $C, $A, 8, 6  ; was: word_26E8C
                                        ; DATA XREF: Effect_UpdateScrollPosition+34   r
                                        ; Effect_UpdateScrollPosition+3A   r

; Clears 64 longwords of scroll buffer starting at dword_FF9400 to zero
Effect_ClearScrollBuffer:                               ; CODE XREF: TransitionEffect_UpdateMode3Buffers:TransitionEffect_UpdateMode3Buffers_Prepare   p  ; was: sub_26EAC
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #0,d0
                moveq   #$3F,d7                         ; '?'
Effect_ClearScrollBuffer_Loop:                          ; CODE XREF: Effect_ClearScrollBuffer+A   j  ; was: loc_26EB4
                move.l  d0,(a0)+
                dbf     d7,Effect_ClearScrollBuffer_Loop
                rts
; End of function Effect_ClearScrollBuffer
; ---------------------------------------------------------------------------
Effect_LinearScrollBaseTable:   binclude "data/other/word_26EBC.bin"  ; was: word_26EBC
Effect_LinearScrollBaseTable_End:                       ; was: word_26EBC_End
Effect_TransitionSineTable:     binclude "data/other/word_26FBC.bin"  ; was: word_26FBC
Effect_TransitionSineTable_End:                         ; was: word_26FBC_End

; Generates the transition edge and scroll output buffers in RAM
Effect_GenerateTransitionBuffers:                       ; CODE XREF: TransitionEffect_UpdateMode1Buffers+4   j  ; was: sub_271BC
                movea.w #(byte_FF9B00-M68K_RAM),a0
                movea.w #(byte_FF9B00-M68K_RAM),a2
                movea.l #Effect_TransitionSineTable,a1
                move.w  #$FF00,d5
                moveq   #$FFFFFFFE,d6
                move.w  #$7E,d7                         ; '~'
                move.w  (word_FF807C).w,d1
                asl.w   #8,d1
                asl.w   #1,d1
                moveq   #0,d3
                move.w  (word_FF807C).w,d2
                beq.s   Effect_GenerateTransitionBuffers_BeginEdgeLoop
                move.l  (dword_FF80A0).w,d3
                divu.w  d2,d3
                andi.l  #$FFFF,d3
                asl.l   #1,d3
                asl.l   #8,d3
Effect_GenerateTransitionBuffers_BeginEdgeLoop:         ; CODE XREF: Effect_GenerateTransitionBuffers+26   j  ; was: loc_271F4
                moveq   #0,d2
Effect_GenerateTransitionBuffers_EdgeLoop:              ; CODE XREF: Effect_GenerateTransitionBuffers+5A   j  ; was: loc_271F6
                sub.l   d3,d2
                move.l  d2,d4
                swap    d4
                and.l   d6,d4
                cmp.w   d5,d4
                bpl.s   Effect_GenerateTransitionBuffers_ReadSample
                moveq   #0,d0
                bra.s   Effect_GenerateTransitionBuffers_StoreSample
; ---------------------------------------------------------------------------
Effect_GenerateTransitionBuffers_ReadSample:            ; CODE XREF: Effect_GenerateTransitionBuffers+44   j  ; was: loc_27206
                move.w  (a1,d4.w),d0
                mulu.w  d1,d0
                swap    d0
                andi.w  #$FFFE,d0
Effect_GenerateTransitionBuffers_StoreSample:           ; CODE XREF: Effect_GenerateTransitionBuffers+48   j  ; was: loc_27212
                move.w  d0,-(a0)
                move.w  d0,(a2)+
                dbf     d7,Effect_GenerateTransitionBuffers_EdgeLoop
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
Effect_GenerateTransitionBuffers_OutputLoop:            ; CODE XREF: Effect_GenerateTransitionBuffers+E6   j  ; was: loc_27246
                move.w  (a0)+,d0
                cmpa.w  #$9A02,a0
                bmi.s   Effect_GenerateTransitionBuffers_ClearOutsideRange
                cmpa.w  #$9C00,a0
                bmi.s   Effect_GenerateTransitionBuffers_CheckOffset
Effect_GenerateTransitionBuffers_ClearOutsideRange:     ; CODE XREF: Effect_GenerateTransitionBuffers+90   j  ; was: loc_27254
                moveq   #0,d0
Effect_GenerateTransitionBuffers_CheckOffset:           ; CODE XREF: Effect_GenerateTransitionBuffers+96   j  ; was: loc_27256
                move.w  d4,d5
                sub.w   d0,d5
                move.w  d5,d6
                bmi.s   Effect_GenerateTransitionBuffers_AdjustOffset
                cmpi.w  #4,d5
                bpl.s   Effect_GenerateTransitionBuffers_ClampSample
Effect_GenerateTransitionBuffers_AdjustOffset:          ; CODE XREF: Effect_GenerateTransitionBuffers+A0   j  ; was: loc_27264
                asr.w   #1,d5
                add.w   d5,d0
                bpl.s   Effect_GenerateTransitionBuffers_ZeroOffset
Effect_GenerateTransitionBuffers_ClearSample:           ; CODE XREF: Effect_GenerateTransitionBuffers+C8   j  ; was: loc_2726A
                moveq   #0,d0
Effect_GenerateTransitionBuffers_ZeroOffset:            ; CODE XREF: Effect_GenerateTransitionBuffers+AC   j  ; was: loc_2726C
                moveq   #0,d5
                andi.w  #2,d6
                add.w   d6,d5
                bra.s   Effect_GenerateTransitionBuffers_StoreOutput
; ---------------------------------------------------------------------------
Effect_GenerateTransitionBuffers_ClampSample:           ; CODE XREF: Effect_GenerateTransitionBuffers+A6   j  ; was: loc_27276
                cmpi.w  #$9E,d0
                bmi.s   Effect_GenerateTransitionBuffers_CheckUpperBound
                move.w  #$9E,d0
Effect_GenerateTransitionBuffers_CheckUpperBound:       ; CODE XREF: Effect_GenerateTransitionBuffers+BE   j  ; was: loc_27280
                cmpi.w  #$140,d5
                bpl.s   Effect_GenerateTransitionBuffers_ClearSample
                move.w  d5,d3
                asr.w   #1,d3
                add.w   d0,d3
                cmpi.w  #$100,d3
                bmi.s   Effect_GenerateTransitionBuffers_StoreOutput
                move.w  #$140,d0
                sub.w   d5,d0
Effect_GenerateTransitionBuffers_StoreOutput:           ; CODE XREF: Effect_GenerateTransitionBuffers+B8   j  ; was: loc_27298
                                        ; Effect_GenerateTransitionBuffers+D4   j
                move.w  d5,(a3)+
                sub.w   d1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                addq.w  #2,d1
                dbf     d7,Effect_GenerateTransitionBuffers_OutputLoop
                rts
; End of function Effect_GenerateTransitionBuffers
; Clears the transition pattern buffer and resets its progress counter
Effect_ClearTransitionPatternBuffer:                    ; CODE XREF: AlternateTransition_InitializeObject+16   j  ; was: sub_272A8
                                        ; TransitionEffect_InitializeObject+16   j
                clr.w   (word_FF8082).w
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #0,d0
                moveq   #$17,d7
Effect_ClearTransitionPatternBuffer_Loop:               ; CODE XREF: Effect_ClearTransitionPatternBuffer+E   j  ; was: loc_272B4
                move.l  d0,(a0)+
                dbf     d7,Effect_ClearTransitionPatternBuffer_Loop
                bra.w   Effect_QueueTransitionVdpRegisters
; End of function Effect_ClearTransitionPatternBuffer
; Builds the base transition pattern in the shared effect buffer
Effect_BuildTransitionPattern:                          ; CODE XREF: TransitionEffect_BuildInitialPattern+C   p  ; was: sub_272BE
                                        ; TunnelTransition_BuildInitialPattern+C   p
                moveq   #0,d0
                move.l  #$EEEE0000,d1
                move.l  #$EEEEEEEE,d2
                move.l  d0,d3
                move.l  d1,d4
                move.l  d2,d5
Effect_BuildTransitionPattern_Write:                    ; CODE XREF: Effect_ScrollMaskPattern1+38   j  ; was: loc_272D2
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #3,d7
Effect_BuildTransitionPattern_PrefixLoop:               ; CODE XREF: Effect_BuildTransitionPattern+1E   j  ; was: loc_272D8
                move.l  d2,(a0)+
                move.l  d5,(a0)+
                dbf     d7,Effect_BuildTransitionPattern_PrefixLoop
                move.l  d0,(a0)+
                move.l  d3,(a0)+
                move.l  d1,(a0)+
                move.l  d4,(a0)+
                move.l  d2,(a0)+
                move.l  d5,(a0)+
                move.l  d2,(a0)+
                move.l  d5,(a0)+
                moveq   #2,d7
Effect_BuildTransitionPattern_SuffixLoop:               ; CODE XREF: Effect_BuildTransitionPattern+38   j  ; was: loc_272F2
                move.l  d0,(a0)+
                move.l  d3,(a0)+
                dbf     d7,Effect_BuildTransitionPattern_SuffixLoop
                move.l  d1,(a0)+
                move.l  d4,(a0)+
                bra.w   Effect_QueueTransitionVdpRegisters
; End of function Effect_BuildTransitionPattern
; Initializes special scroll pattern with EEEEEEEE values for boss defeat effect, sets up 40 bytes of pattern
Effect_InitDefeatScroll:                                ; CODE XREF: AlternateTransition_BuildInitialPattern+C   p  ; was: sub_27302
                moveq   #0,d0
                move.l  #$EEEEEEEE,d2
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #7,d7
Effect_InitDefeatScroll_PrefixLoop:                     ; CODE XREF: Effect_InitDefeatScroll+10   j  ; was: loc_27310
                move.l  d2,(a0)+
                dbf     d7,Effect_InitDefeatScroll_PrefixLoop
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                moveq   #7,d7
Effect_InitDefeatScroll_SuffixLoop:                     ; CODE XREF: Effect_InitDefeatScroll+28   j  ; was: loc_27328
                move.l  d0,(a0)+
                dbf     d7,Effect_InitDefeatScroll_SuffixLoop
                bra.w   Effect_QueueTransitionVdpRegisters
; End of function Effect_InitDefeatScroll
; Masks individual scroll buffer byte based on word_FF8082 timer, using lookup table to select byte offset
Effect_MaskScrollByte:
                movea.w #(dword_FF9400-M68K_RAM),a0     ; was: sub_27332
                lea     Effect_TransitionMaskByteOffsets(pc),a1
                nop
                move.b  #$F,d3
                move.w  (word_FF8082).w,d0
                cmpi.w  #$20,d0                         ; ' '
                bmi.s   Effect_MaskScrollByte_SelectNibble
                move.b  #$F0,d3
Effect_MaskScrollByte_SelectNibble:                     ; CODE XREF: Effect_MaskScrollByte+16   j  ; was: loc_2734E
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
Effect_QueueTransitionVdpRegisters:                     ; CODE XREF: Effect_ClearTransitionPatternBuffer+12   j  ; was: loc_27376
                                        ; Effect_BuildTransitionPattern+40   j
                movea.w (VDPCommandQueueHead).w,a1
                move.w  #$82,-(a1)
                move.w  #$73A0,-(a1)
                move.w  #$9500,-(a1)
                move.w  #$96CA,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009330,-(a1)
                move.w  a1,(VDPCommandQueueHead).w
                rts
; End of function Effect_MaskScrollByte
; ---------------------------------------------------------------------------
Effect_TransitionMaskByteOffsets:   dc.w    $10, $111, $212, $313, $414, $515, $616, $717, $818, $919, $A1A, $B1B, $C1C, $D1D, $E1E, $F1F  ; was: word_2739C
                                        ; DATA XREF: Effect_MaskScrollByte+4   o

; Applies the current transition mask to three pattern-buffer rows
Effect_ApplyTransitionMask:                             ; CODE XREF: AlternateTransition_Update+1A   j  ; was: sub_273BC
                                        ; TransitionEffect_Update+2C   j
                lea     Effect_TransitionMaskPatternsA(pc),a1
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
Effect_ApplyTransitionMask_Loop:                        ; CODE XREF: Effect_ApplyTransitionMask+4A   j  ; was: loc_273E2
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
                dbf     d7,Effect_ApplyTransitionMask_Loop
                bra.w   Effect_QueueTransitionVdpRegisters
; End of function Effect_ApplyTransitionMask
; ---------------------------------------------------------------------------
Effect_TransitionMaskPatternsA: dc.l    $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFF0FFF  ; was: dword_2740E
                                        ; DATA XREF: Effect_ApplyTransitionMask   o
                dc.l    $F0F0F0F, $F0F0F0F, $F0F0F0F, $F000F
                dc.l    $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFF0FFF0
                dc.l    $F0F0F0F0, $F0F0F0F0, $F0F0F0F0, $F000F000

; Applies masked scroll pattern using time-based lookup from Effect_TransitionMaskPatternsB table, creates layered effect masks
Effect_ScrollMaskPattern1:
                lea     Effect_TransitionMaskPatternsB(pc),a1  ; was: sub_2744E
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
                bra.w   Effect_BuildTransitionPattern_Write
; End of function Effect_ScrollMaskPattern1
; ---------------------------------------------------------------------------
Effect_TransitionMaskPatternsB: dc.l    $FFFFFFFF, $FFFFFFF, $FFF0FFF, $F0F0FFF  ; was: dword_2748A
                                        ; DATA XREF: Effect_ScrollMaskPattern1   o
                dc.l    $F0F0F0F, $F0F0F, $F000F, $F
                dc.l    $FFFFFFFF, $FFFFFFF0, $FFF0FFF0, $FFF0F0F0
                dc.l    $F0F0F0F0, $F0F0F000, $F000F000, $F0000000

; Builds the denser transition output used by buffer mode four
TransitionEffect_UpdateMode4Buffers:                    ; DATA XREF: ROM:00026BA4   o  ; was: sub_274CA
                movea.w #(word_FF9500-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a1
                moveq   #3,d7
                bsr.w   Effect_Copy32ByteBlocks
                movea.w #(byte_FF9A80-M68K_RAM),a0
                movea.w #(byte_FF9A80-M68K_RAM),a2
                movea.l #Effect_TransitionSineTable,a1
                move.w  #$FF00,d5
                moveq   #$FFFFFFFE,d6
                move.w  #$3E,d7                         ; '>'
                move.w  (word_FF807C).w,d1
                asl.w   #8,d1
                asl.w   #1,d1
                moveq   #0,d3
                move.w  (word_FF807C).w,d2
                beq.s   TransitionEffect_UpdateMode4Buffers_BeginEdgeLoop
                move.l  (dword_FF80A0).w,d3
                divu.w  d2,d3
                andi.l  #$FFFF,d3
                asl.l   #1,d3
                asl.l   #8,d3
TransitionEffect_UpdateMode4Buffers_BeginEdgeLoop:      ; CODE XREF: TransitionEffect_UpdateMode4Buffers+34   j  ; was: loc_27510
                moveq   #0,d2
TransitionEffect_UpdateMode4Buffers_EdgeLoop:           ; CODE XREF: TransitionEffect_UpdateMode4Buffers+68   j  ; was: loc_27512
                sub.l   d3,d2
                move.l  d2,d4
                swap    d4
                and.w   d6,d4
                cmp.w   d5,d4
                bpl.s   TransitionEffect_UpdateMode4Buffers_ReadSample
                moveq   #0,d0
                bra.s   TransitionEffect_UpdateMode4Buffers_StoreSample
; ---------------------------------------------------------------------------
TransitionEffect_UpdateMode4Buffers_ReadSample:         ; CODE XREF: TransitionEffect_UpdateMode4Buffers+52   j  ; was: loc_27522
                move.w  (a1,d4.w),d0
                mulu.w  d1,d0
                swap    d0
                andi.w  #$FFFC,d0
TransitionEffect_UpdateMode4Buffers_StoreSample:        ; CODE XREF: TransitionEffect_UpdateMode4Buffers+56   j  ; was: loc_2752E
                move.w  d0,-(a0)
                move.w  d0,(a2)+
                dbf     d7,TransitionEffect_UpdateMode4Buffers_EdgeLoop
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
TransitionEffect_UpdateMode4Buffers_OutputLoop:         ; CODE XREF: TransitionEffect_UpdateMode4Buffers+F6   j  ; was: loc_27564
                move.w  (a0)+,d0
                cmpa.w  #$9A02,a0
                bmi.s   TransitionEffect_UpdateMode4Buffers_ClearOutsideRange
                cmpa.w  #$9B00,a0
                bmi.s   TransitionEffect_UpdateMode4Buffers_CheckOffset
TransitionEffect_UpdateMode4Buffers_ClearOutsideRange:  ; CODE XREF: TransitionEffect_UpdateMode4Buffers+A0   j  ; was: loc_27572
                moveq   #0,d0
TransitionEffect_UpdateMode4Buffers_CheckOffset:        ; CODE XREF: TransitionEffect_UpdateMode4Buffers+A6   j  ; was: loc_27574
                move.w  d4,d5
                sub.w   d0,d5
                move.w  d5,d6
                bmi.s   TransitionEffect_UpdateMode4Buffers_AdjustOffset
                cmpi.w  #8,d5
                bpl.s   TransitionEffect_UpdateMode4Buffers_ClampSample
TransitionEffect_UpdateMode4Buffers_AdjustOffset:       ; CODE XREF: TransitionEffect_UpdateMode4Buffers+B0   j  ; was: loc_27582
                asr.w   #1,d5
                add.w   d5,d0
                bpl.s   TransitionEffect_UpdateMode4Buffers_ZeroOffset
TransitionEffect_UpdateMode4Buffers_ClearSample:        ; CODE XREF: TransitionEffect_UpdateMode4Buffers+D8   j  ; was: loc_27588
                moveq   #0,d0
TransitionEffect_UpdateMode4Buffers_ZeroOffset:         ; CODE XREF: TransitionEffect_UpdateMode4Buffers+BC   j  ; was: loc_2758A
                moveq   #0,d5
                andi.w  #4,d6
                add.w   d6,d5
                bra.s   TransitionEffect_UpdateMode4Buffers_StoreOutput
; ---------------------------------------------------------------------------
TransitionEffect_UpdateMode4Buffers_ClampSample:        ; CODE XREF: TransitionEffect_UpdateMode4Buffers+B6   j  ; was: loc_27594
                cmpi.w  #$9E,d0
                bmi.s   TransitionEffect_UpdateMode4Buffers_CheckUpperBound
                move.w  #$9E,d0
TransitionEffect_UpdateMode4Buffers_CheckUpperBound:    ; CODE XREF: TransitionEffect_UpdateMode4Buffers+CE   j  ; was: loc_2759E
                cmpi.w  #$140,d5
                bpl.s   TransitionEffect_UpdateMode4Buffers_ClearSample
                move.w  d5,d3
                asr.w   #1,d3
                add.w   d0,d3
                cmpi.w  #$100,d3
                bmi.s   TransitionEffect_UpdateMode4Buffers_StoreOutput
                move.w  #$140,d0
                sub.w   d5,d0
TransitionEffect_UpdateMode4Buffers_StoreOutput:        ; CODE XREF: TransitionEffect_UpdateMode4Buffers+C8   j  ; was: loc_275B6
                                        ; TransitionEffect_UpdateMode4Buffers+E4   j
                move.w  d5,(a3)+
                sub.w   d1,d0
                and.w   d2,d0
                move.w  d0,(a2)+
                addq.w  #4,d1
                dbf     d7,TransitionEffect_UpdateMode4Buffers_OutputLoop
                rts
; End of function TransitionEffect_UpdateMode4Buffers
