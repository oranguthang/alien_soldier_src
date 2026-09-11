; Initializes the STAGE-number entry banner and its stage time limit
StageIntro_InitializeBanner:                            ; DATA XREF: ROM:0000A9F2   o  ; was: sub_AE9A
                addq.w  #2,(MessageSequenceState).w
                jsr     (Stage_LoadTimeLimit).l
                bclr    #0,(byte_FFA272).w
                move.l  #StageIntro_GlyphSourceList,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
; Streams the glyph set used by the stage-number banner
StageIntro_LoadStageNumberGlyph:                        ; DATA XREF: ROM:0000A9F4   o  ; was: loc_AEB8
                bsr.w   Message_LoadNextGlyphTile
                cmpi.w  #$52,(MessageSequenceState).w   ; 'R'
                beq.s   StageIntro_LoadStageNumberGlyphReturn
                move.w  #$EC,(word_FF80C6).w
                move.w  #$80,(word_FF80D4).w
                move.w  #$E0,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #2,(byte_FF8143).w
StageIntro_LoadStageNumberGlyphReturn:                  ; CODE XREF: StageIntro_InitializeBanner+28   j  ; was: locret_AEE2
                rts
; End of function StageIntro_InitializeBanner
; Slides in the STAGE label and its two packed-BCD number digits
StageIntro_UpdateStageNumberBanner:                     ; DATA XREF: ROM:0000A9F6   o  ; was: sub_AEE4
                addq.w  #1,(word_FF80C6).w
                cmpi.w  #$FC,(word_FF80C6).w
                bmi.s   StageIntro_ClampStageNumberX
                move.w  #$FC,(word_FF80C6).w
StageIntro_ClampStageNumberX:                           ; CODE XREF: StageIntro_UpdateStageNumberBanner+A   j  ; was: loc_AEF6
                cmpi.w  #$40,(word_FF80D4).w            ; '@'
                bne.s   StageIntro_UpdateStageNumberDelay
                move.b  (dword_FF80C8).w,d0
                beq.s   StageIntro_UpdateStageNumberDelay
                clr.b   (dword_FF80C8).w
                jsr     (Sound_PlaySFX).l
StageIntro_UpdateStageNumberDelay:                      ; CODE XREF: StageIntro_UpdateStageNumberBanner+18   j  ; was: loc_AF0E
                                        ; StageIntro_UpdateStageNumberBanner+1E   j
                subq.w  #1,(word_FF80D4).w
                bpl.s   StageIntro_RenderStageNumberBanner
                clr.w   (MessageSequenceState).w
StageIntro_RenderStageNumberBanner:                     ; CODE XREF: StageIntro_UpdateStageNumberBanner+2E   j  ; was: loc_AF18
                lea     StageIntro_StageNumberSpriteTileLayout(pc),a0
                nop
                bsr.w   Message_LoadSpriteTileIndices
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  #$EC,d0
                move.b  (byte_FF8232).w,d2
                move.w  d2,d3
                asr.w   #4,d3
                andi.w  #$F,d2
                andi.w  #$F,d3
                asl.w   #1,d2
                asl.w   #1,d3
                addi.w  #-$3960,d2
                addi.w  #-$3960,d3
                move.w  (word_FF80C6).w,d1
                moveq   #4,d7
; Writes the five fixed STAGE-label sprite entries before the two number digits
StageIntro_WriteStageLabelSprites:                      ; CODE XREF: StageIntro_UpdateStageNumberBanner+74   j  ; was: loc_AF4C
                move.w  d0,(a0)
                move.w  d1,6(a0)
                addi.w  #$C,d1
                addq.w  #8,a0
                dbf     d7,StageIntro_WriteStageLabelSprites
                addq.w  #6,d1
                move.w  d0,(a0)
                move.w  d1,6(a0)
                move.w  d3,4(a0)
                addi.w  #$C,d1
                addq.w  #8,a0
                move.w  d0,(a0)
                move.w  d1,6(a0)
                move.w  d2,4(a0)
                lea     (dword_FFA100).w,a0
                jmp     (Sprite_AppendOAMEntries).l
; End of function StageIntro_UpdateStageNumberBanner
; Initializes the flashing EMERGENCY banner
StageIntro_InitializeEmergencyBanner:                   ; DATA XREF: ROM:0000A9F8   o  ; was: sub_AF82
                addq.w  #2,(MessageSequenceState).w
                move.l  #StageIntro_EmergencyGlyphSourceList,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
; Streams the unique glyphs used by the EMERGENCY banner
StageIntro_LoadEmergencyGlyph:                          ; DATA XREF: ROM:0000A9FA   o  ; was: loc_AF94
                bsr.w   Message_LoadNextGlyphTile
                cmpi.w  #$58,(MessageSequenceState).w   ; 'X'
                beq.s   StageIntro_EmergencyGlyphReturn
                move.w  #$F0,(word_FF80C6).w
                move.w  #$100,(word_FF80D4).w
                move.b  #$D2,d0
                jsr     (Sound_PlaySFX).l
StageIntro_EmergencyGlyphReturn:                        ; CODE XREF: StageIntro_InitializeEmergencyBanner+1C   j  ; was: locret_AFB6
                                        ; StageIntro_UpdateEmergencyFlash+22   j
                rts
; End of function StageIntro_InitializeEmergencyBanner
; Updates the flashing EMERGENCY banner and its delay
StageIntro_UpdateEmergencyFlash:                        ; DATA XREF: ROM:0000A9FC   o  ; was: sub_AFB8
                cmpi.w  #$5C,(word_FF80D4).w            ; '\'
                bne.s   StageIntro_UpdateEmergencyDelay
                move.b  #$15,d0
                jsr     (Sound_PlaySFX).l
StageIntro_UpdateEmergencyDelay:                        ; CODE XREF: StageIntro_UpdateEmergencyFlash+6   j  ; was: loc_AFCA
                subq.w  #1,(word_FF80D4).w
                bpl.s   StageIntro_CheckEmergencyFlashFrame
                clr.w   (MessageSequenceState).w
StageIntro_CheckEmergencyFlashFrame:                    ; CODE XREF: StageIntro_UpdateEmergencyFlash+16   j  ; was: loc_AFD4
                btst    #4,(word_FF80D4+1).w
                bne.s   StageIntro_EmergencyGlyphReturn
                lea     StageIntro_EmergencySpriteTileLayout(pc),a0
                nop
                bsr.w   Message_LoadSpriteTileIndices
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  #$EC,d0
                move.w  (word_FF80C6).w,d1
                moveq   #8,d7
; Writes the nine EMERGENCY sprite entries with horizontal spacing
StageIntro_WriteEmergencySprites:                       ; CODE XREF: StageIntro_UpdateEmergencyFlash+48   j  ; was: loc_AFF4
                move.w  d0,(a0)
                move.w  d1,6(a0)
                addi.w  #$C,d1
                addq.w  #8,a0
                dbf     d7,StageIntro_WriteEmergencySprites
                lea     (dword_FFA100).w,a0
                jmp     (Sprite_AppendOAMEntries).l
; End of function StageIntro_UpdateEmergencyFlash
; Initializes pause timer before text exit
StageIntro_InitializePostBannerDelay:                   ; DATA XREF: ROM:0000A9FE   o  ; was: sub_B00E
                addq.w  #2,(MessageSequenceState).w
                move.w  #$50,(dword_FF80CE).w           ; 'P'
; Decrements pause timer each frame before text transition
StageIntro_UpdatePostBannerDelay:                       ; DATA XREF: ROM:0000AA00   o  ; was: loc_B018
                subq.w  #1,(dword_FF80CE).w
                bpl.s   StageIntro_PostBannerDelayReturn
                move.w  #$2E,(MessageSequenceState).w   ; '.'
StageIntro_PostBannerDelayReturn:                       ; CODE XREF: StageIntro_InitializePostBannerDelay+E   j  ; was: locret_B024
                rts
; End of function StageIntro_InitializePostBannerDelay
; Initializes the post-boss remaining-time bonus sequence
Results_InitializeTimeBonus:                            ; DATA XREF: ROM:0000A9D0   o  ; was: sub_B026
                addq.w  #2,(MessageSequenceState).w
                move.l  #Results_TimeBonusGlyphSourceList,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
                rts
; End of function Results_InitializeTimeBonus
; Streams the unique glyphs used by the time-bonus display
Results_LoadTimeBonusGlyphs:                            ; DATA XREF: ROM:0000A9D2   o  ; was: sub_B03A
                bsr.w   Message_LoadNextGlyphTile
                cmpi.w  #$30,(MessageSequenceState).w   ; '0'
                beq.s   Results_LoadTimeBonusGlyphsReturn
                move.w  #$E0,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #2,(byte_FF8143).w
                move.w  #$80,(word_FF80C6).w
                move.w  #$40,(dword_FF80CE).w           ; '@'
                move.w  #$E8,(word_FF80CC).w
                move.w  #$200,(word_FF80D4).w
                move.w  #$108,(word_FF80C4).w
                move.w  #$200,(word_FF80D6).w
                move.b  #$BE,d0
                jsr     (Sound_PlaySFX).l
Results_LoadTimeBonusGlyphsReturn:                      ; CODE XREF: Results_LoadTimeBonusGlyphs+A   j  ; was: locret_B086
                rts
; End of function Results_LoadTimeBonusGlyphs
; Spins the time-bonus sprites inward while reducing their radial distance
Results_SpinInTimeBonus:                                ; DATA XREF: ROM:0000A9D4   o  ; was: sub_B088
                bsr.w   Results_RenderSpinningTimeBonus
                move.w  (word_FF80C6).w,d0
                addq.w  #8,d0
                andi.w  #$1FE,d0
                move.w  d0,(word_FF80C6).w
                subq.w  #4,(dword_FF80CE).w
                bpl.s   Results_SpinInTimeBonusReturn
                cmpi.w  #4,(dword_FF80CE).w
                bpl.s   Results_SpinInTimeBonusReturn
                addq.w  #2,(MessageSequenceState).w
                clr.w   (word_FF80C6).w
                clr.w   (dword_FF80CE).w
Results_SpinInTimeBonusReturn:                          ; CODE XREF: Results_SpinInTimeBonus+16   j  ; was: locret_B0B4
                                        ; Results_SpinInTimeBonus+1E   j
                rts
; End of function Results_SpinInTimeBonus
; Slows the time-bonus spin to its fixed terminal angle
Results_SlowTimeBonusSpin:                              ; DATA XREF: ROM:0000A9D6   o  ; was: sub_B0B6
                bsr.w   Results_RenderSpinningTimeBonus
                subq.w  #1,(dword_FF80CE).w
                cmpi.w  #$FFF4,(dword_FF80CE).w
                bne.s   Results_SlowTimeBonusSpinReturn
                addq.w  #2,(MessageSequenceState).w
                move.w  #$FFF4,(dword_FF80CE).w
                move.w  #$20,(dword_FF80C8).w           ; ' '
Results_SlowTimeBonusSpinReturn:                        ; CODE XREF: Results_SlowTimeBonusSpin+E   j  ; was: locret_B0D6
                rts
; End of function Results_SlowTimeBonusSpin
; Finishes the spin, records the stage time, and selects the zero/nonzero path
Results_FinishTimeBonusSpin:                            ; DATA XREF: ROM:0000A9D8   o  ; was: sub_B0D8
                bsr.w   Results_RenderSpinningTimeBonus
                subq.w  #1,(dword_FF80C8).w
                bpl.s   Results_FinishTimeBonusSpinReturn
                tst.b   (byte_FF80FA).w
                beq.s   Results_RequestTimeBonusSound
                move.b  #$83,d0
                jsr     (Sound_QueueBGMRequest).l
                bra.s   Results_StoreTimeBonus
; ---------------------------------------------------------------------------
Results_RequestTimeBonusSound:                          ; CODE XREF: Results_FinishTimeBonusSpin+E   j  ; was: loc_B0F4
                move.b  #$C4,d0
                jsr     (Sound_PlaySFX).l
Results_StoreTimeBonus:                                 ; CODE XREF: Results_FinishTimeBonusSpin+1A   j  ; was: loc_B0FE
                jsr     (Results_StoreStageCompletionTime).l
                tst.w   (StageTimeRemaining).w
                beq.s   Results_SkipZeroTimeBonus
                addq.w  #2,(MessageSequenceState).w
                move.w  #$F0,(word_FF80D4).w
                move.w  (StageTimeRemaining).w,(word_FF822C).w
                andi.w  #$FFF0,(word_FF822C).w
                rts
; ---------------------------------------------------------------------------
Results_SkipZeroTimeBonus:                              ; CODE XREF: Results_FinishTimeBonusSpin+30   j  ; was: loc_B122
                move.w  #$46,(MessageSequenceState).w   ; 'F'
                move.w  #$F0,(word_FF80D4).w
                move.w  #$11A,(word_FF80C4).w
Results_FinishTimeBonusSpinReturn:                      ; CODE XREF: Results_FinishTimeBonusSpin+8   j  ; was: locret_B134
                rts
; End of function Results_FinishTimeBonusSpin
; Moves the linear time-bonus display into its held position
Results_AnimateTimeBonusEntry:                          ; DATA XREF: ROM:0000A9DA   o  ; was: sub_B136
                bsr.w   Results_RenderLinearTimeBonus
                subq.w  #1,(word_FF80CC).w
                addq.w  #1,(word_FF80D4).w
                cmpi.w  #$E0,(word_FF80CC).w
                bne.s   Results_AnimateTimeBonusEntryReturn
                addq.w  #2,(MessageSequenceState).w
                move.w  #4,(dword_FF80C8).w
Results_AnimateTimeBonusEntryReturn:                    ; CODE XREF: Results_AnimateTimeBonusEntry+12   j  ; was: locret_B154
                rts
; End of function Results_AnimateTimeBonusEntry
; Holds the linear time-bonus display before its exit
Results_HoldTimeBonus:                                  ; DATA XREF: ROM:0000A9DC   o  ; was: sub_B156
                bsr.w   Results_RenderLinearTimeBonus
                subq.w  #1,(dword_FF80C8).w
                bpl.s   Results_HoldTimeBonusReturn
                addq.w  #2,(MessageSequenceState).w
                move.w  #$114,(word_FF80D6).w
Results_HoldTimeBonusReturn:                            ; CODE XREF: Results_HoldTimeBonus+8   j  ; was: locret_B16A
                rts
; End of function Results_HoldTimeBonus
; Moves the linear time-bonus display out and advances the sequence
Results_AnimateTimeBonusExit:                           ; DATA XREF: ROM:0000A9DE   o  ; was: sub_B16C
                bsr.w   Results_RenderLinearTimeBonus
                subq.w  #2,(word_FF80C4).w
                addq.w  #2,(word_FF80D6).w
                cmpi.w  #$EC,(word_FF80C4).w
                bne.s   Results_AnimateTimeBonusExitReturn
                addq.w  #4,(MessageSequenceState).w
                move.w  #$40,(dword_FF80C8).w           ; '@'
Results_AnimateTimeBonusExitReturn:                     ; CODE XREF: Results_AnimateTimeBonusExit+12   j  ; was: locret_B18A
                rts
; End of function Results_AnimateTimeBonusExit
; Adds the packed-BCD remaining stage time to the score and ends the sequence
Results_ApplyRemainingTimeBonus:                        ; DATA XREF: ROM:0000A9E0   o  ; was: sub_B18C
                                        ; ROM:0000A9E2   o
                bsr.w   Results_RenderLinearTimeBonus
                subq.w  #1,(dword_FF80C8).w
                bpl.s   Results_ApplyRemainingTimeBonusReturn
                clr.w   (MessageSequenceState).w
                moveq   #0,d0
                move.w  (StageTimeRemaining).w,d0
                jsr     (Score_AddPackedBCD).l
Results_ApplyRemainingTimeBonusReturn:                  ; CODE XREF: Results_ApplyRemainingTimeBonus+8   j  ; was: locret_B1A6
                rts
; End of function Results_ApplyRemainingTimeBonus
; Moves radial text sprites into their fixed display position
Message_FadeInRadialText:                               ; DATA XREF: ROM:0000A9E4   o  ; was: sub_B1A8
                                        ; ROM:0000A9E6   o
                bsr.w   Message_RenderRadialText
                addq.w  #1,(word_FF80D4).w
                cmpi.w  #$FC,(word_FF80D4).w
                bne.s   Message_FadeInRadialTextReturn
                addq.w  #2,(MessageSequenceState).w
                move.w  #$80,(dword_FF80C8).w
Message_FadeInRadialTextReturn:                         ; CODE XREF: Message_FadeInRadialText+E   j  ; was: locret_B1C2
                rts
; End of function Message_FadeInRadialText
; Holds radial text sprites until the sequence timer expires
Message_FadeOutRadialText:                              ; DATA XREF: ROM:0000A9EA   o  ; was: sub_B1C4
                bsr.w   Message_RenderRadialText
                subq.w  #1,(dword_FF80C8).w
                bpl.s   Message_FadeOutRadialTextReturn
                clr.w   (MessageSequenceState).w
Message_FadeOutRadialTextReturn:                        ; CODE XREF: Message_FadeOutRadialText+8   j  ; was: locret_B1D2
                rts
; End of function Message_FadeOutRadialText
; Waits for frame timer countdown before clearing state
Message_UpdateWaitTimer:                                ; DATA XREF: ROM:0000A9EC   o  ; was: sub_B1D4
                subq.w  #1,(word_FF80C4).w
                bpl.s   Message_UpdateWaitTimerReturn
                clr.w   (MessageSequenceState).w
Message_UpdateWaitTimerReturn:                          ; CODE XREF: Message_UpdateWaitTimer+4   j  ; was: locret_B1DE
                rts
; End of function Message_UpdateWaitTimer
; Renders the spinning form of the remaining-time bonus
Results_RenderSpinningTimeBonus:                        ; CODE XREF: Results_SpinInTimeBonus   p  ; was: sub_B1E0
                                        ; sub_B0B6   p
                lea     Results_TimeBonusSpriteTileLayout(pc),a0
                nop
                bsr.w   Message_LoadSpriteTileIndices
                bsr.w   Results_PositionTimeBonusSprites
                lea     (dword_FFA100).w,a0
                jmp     (Sprite_AppendOAMEntries).l
; End of function Results_RenderSpinningTimeBonus
; Renders the linear form of the remaining-time bonus
Results_RenderLinearTimeBonus:                          ; CODE XREF: Results_AnimateTimeBonusEntry   p  ; was: sub_B1F8
                                        ; sub_B156   p
                lea     Results_TimeBonusSpriteTileLayout(pc),a0
                nop
                bsr.w   Message_LoadSpriteTileIndices
                bsr.w   Results_ApplyTimeDigitTileOffsets
                bsr.w   Results_PositionTimeBonusSprites
                lea     (dword_FFA100).w,a0
                jmp     (Sprite_AppendOAMEntries).l
; End of function Results_RenderLinearTimeBonus
; Renders the generic radial-text sprite arrangement
Message_RenderRadialText:                               ; CODE XREF: Message_FadeInRadialText   p  ; was: sub_B214
                                        ; sub_B1C4   p
                lea     Message_RadialTextSpriteTileLayout(pc),a0
                nop
                bsr.w   Message_LoadSpriteTileIndices
                bsr.w   Message_PositionRadialTextSprites
                lea     (dword_FFA100).w,a0
                jmp     (Sprite_AppendOAMEntries).l
; End of function Message_RenderRadialText
; Writes the remaining-time bonus sprite positions
Results_PositionTimeBonusSprites:                       ; CODE XREF: Results_RenderSpinningTimeBonus+A   p  ; was: sub_B22C
                                        ; Results_RenderLinearTimeBonus+E   p
                bsr.w   Message_CalculateRadialSpriteCoords
                move.w  (word_FF80D6).w,d1
                moveq   #3,d7
Results_WriteTimeBonusSpritePositions:                  ; CODE XREF: Results_PositionTimeBonusSprites+18   j  ; was: loc_B236
                move.w  (word_FF80D4).w,(a0)
                move.w  d1,(a1)
                addq.w  #8,a0
                addq.w  #8,a1
                addi.w  #$C,d1
                dbf     d7,Results_WriteTimeBonusSpritePositions
                rts
; End of function Results_PositionTimeBonusSprites
; Writes the two central radial-text sprite positions
Message_PositionRadialTextSprites:                      ; CODE XREF: Message_RenderRadialText+A   p  ; was: sub_B24A
                bsr.w   Message_CalculateRadialSpriteCoords
                subi.w  #$60,d1                         ; '`'
                moveq   #1,d7
Message_WriteRadialTextSpritePositions:                 ; CODE XREF: Message_PositionRadialTextSprites+18   j  ; was: loc_B254
                move.w  (word_FF80D4).w,(a0)
                move.w  d1,(a1)
                addq.w  #8,a0
                addq.w  #8,a1
                addi.w  #$C,d1
                dbf     d7,Message_WriteRadialTextSpritePositions
                rts
; End of function Message_PositionRadialTextSprites
; Calculates symmetric sine/cosine coordinates and the linear sprite row
Message_CalculateRadialSpriteCoords:                    ; CODE XREF: Results_PositionTimeBonusSprites   p  ; was: sub_B268
                                        ; sub_B24A   p
                movea.w #(byte_FFA120-M68K_RAM),a0
                movea.w #(byte_FFA126-M68K_RAM),a1
                movea.w #(byte_FFA128-M68K_RAM),a2
                movea.w #(byte_FFA12E-M68K_RAM),a3
                movea.l #Math_SineTable,a4
                move.w  (word_FF80C6).w,d0
                move.w  (dword_FF80CE).w,d1
                move.w  d1,d4
                move.w  (word_FF80CC).w,d6
                moveq   #4,d7
Message_CalculateRadialSpritePairLoop:                  ; CODE XREF: Message_CalculateRadialSpriteCoords+5C   j  ; was: loc_B28E
                move.w  -$80(a4,d0.w),d2
                move.w  (a4,d0.w),d3
                muls.w  d4,d2
                muls.w  d4,d3
                asl.l   #2,d2
                asl.l   #2,d3
                swap    d2
                swap    d3
                move.w  d2,(a0)
                move.w  d3,(a1)
                add.w   d6,(a0)
                addi.w  #$120,(a1)
                neg.w   d2
                neg.w   d3
                add.w   d6,d2
                addi.w  #$120,d3
                move.w  d2,(a2)
                move.w  d3,(a3)
                subq.w  #8,a0
                subq.w  #8,a1
                addq.w  #8,a2
                addq.w  #8,a3
                add.w   d1,d4
                dbf     d7,Message_CalculateRadialSpritePairLoop
                movea.w #(byte_FFA150-M68K_RAM),a0
                movea.w #(byte_FFA156-M68K_RAM),a1
                move.w  (word_FF80C4).w,d1
                moveq   #4,d7
Message_WriteLinearSpritePositions:                     ; CODE XREF: Message_CalculateRadialSpriteCoords+7C   j  ; was: loc_B2D6
                move.w  (word_FF80D4).w,(a0)
                move.w  d1,(a1)
                addq.w  #8,a0
                addq.w  #8,a1
                addi.w  #$C,d1
                dbf     d7,Message_WriteLinearSpritePositions
                rts
; End of function Message_CalculateRadialSpriteCoords
; Applies four packed-BCD timer digits to the bonus sprite tile words
Results_ApplyTimeDigitTileOffsets:                      ; CODE XREF: Results_RenderLinearTimeBonus+A   p  ; was: sub_B2EA
                movea.w #(byte_FFA17C-M68K_RAM),a0
                move.b  (word_FF822C).w,d0
                move.b  d0,d1
                asr.w   #4,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                add.w   d0,d0
                add.w   d1,d1
                add.w   d1,(a0)
                add.w   d0,8(a0)
                move.b  (word_FF822C+1).w,d0
                move.b  d0,d1
                asr.w   #4,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                add.w   d0,d0
                add.w   d1,d1
                add.w   d1,$10(a0)
                add.w   d0,$18(a0)
                rts
; End of function Results_ApplyTimeDigitTileOffsets
; Expands byte tile indices into sprite tile words
Message_LoadSpriteTileIndices:                          ; CODE XREF: StageIntro_UpdateStageNumberBanner+3A   p  ; was: sub_B326
                                        ; StageIntro_UpdateEmergencyFlash+2A   p
                movea.w #(byte_FFA104-M68K_RAM),a1
                move.w  #$100,d1
Message_LoadNextSpriteTileIndex:                        ; CODE XREF: Message_LoadSpriteTileIndices+24   j  ; was: loc_B32E
                moveq   #0,d0
                move.b  (a0)+,d0
                bmi.s   Message_TerminateSpriteTileList
                addi.w  #-$1960,d0
                bclr    #0,d0
                bne.s   Message_StoreSpriteTileIndex
                subi.w  #$2000,d0
Message_StoreSpriteTileIndex:                           ; CODE XREF: Message_LoadSpriteTileIndices+16   j  ; was: loc_B342
                move.w  d0,(a1)
                move.w  d1,-2(a1)
                addq.w  #8,a1
                bra.s   Message_LoadNextSpriteTileIndex
; ---------------------------------------------------------------------------
; Writes the terminator after the expanded sprite tile list
Message_TerminateSpriteTileList:                        ; CODE XREF: Message_LoadSpriteTileIndices+C   j  ; was: loc_B34C
                move.w  #$FFFF,-4(a1)
                rts
; End of function Message_LoadSpriteTileIndices
; ---------------------------------------------------------------------------
Results_TimeBonusSpriteTileLayout:  dc.w    $1416, $181A, $1C1E, $201C, $1822, $2426, $282A, $1400, 0, $FF  ; was: word_B354
                                        ; DATA XREF: Results_RenderSpinningTimeBonus   o
                                        ; sub_B1F8   o
Message_RadialTextSpriteTileLayout: dc.w    $1416, $181A, $1C1E, $201C, $1822, $2426, $282A, $1428, $26FF  ; was: word_B368
                                        ; DATA XREF: Message_RenderRadialText   o
StageIntro_StageNumberSpriteTileLayout: dc.w    $1416, $181A, $1C00, $FF  ; was: word_B37A
                                        ; DATA XREF: StageIntro_UpdateStageNumberBanner:StageIntro_RenderStageNumberBanner   o
StageIntro_EmergencySpriteTileLayout:   dc.w    2, 4, $600, $80A, $CFF  ; was: word_B382
                                        ; DATA XREF: StageIntro_UpdateEmergencyFlash+24   o

; Copies one unique font glyph and queues its VRAM transfer
Message_LoadNextGlyphTile:                              ; CODE XREF: BattleBanner_LoadGlyphs   p  ; was: sub_B38C
                                        ; sub_AE9A:loc_AEB8   p
                movea.l (dword_FF80CE).w,a0
                moveq   #0,d0
                move.b  (a0)+,d0
                cmpi.b  #$FF,d0
                bne.s   Message_CopyGlyphTile
                addq.w  #2,(MessageSequenceState).w
                rts
; ---------------------------------------------------------------------------
Message_CopyGlyphTile:                                  ; CODE XREF: Message_LoadNextGlyphTile+C   j  ; was: loc_B3A0
                move.l  a0,(dword_FF80CE).w
                asl.w   #6,d0
                addi.l  #tiles_font,d0
                movea.l d0,a0
                movea.w #(byte_FFA300-M68K_RAM),a1
                moveq   #$F,d7
Message_CopyGlyphTileLoop:                              ; CODE XREF: Message_LoadNextGlyphTile+2A   j  ; was: loc_B3B4
                move.l  (a0)+,(a1)+
                dbf     d7,Message_CopyGlyphTileLoop
                movea.w (VDPCommandQueueHead).w,a5
                move.w  #$83,-(a5)
                move.w  (word_FF80C4).w,-(a5)
                move.w  #$9580,-(a5)
                move.w  #$96D1,-(a5)
                move.l  #$8F02977F,-(a5)
                move.l  #$94009320,-(a5)
                move.w  a5,(VDPCommandQueueHead).w
                addi.w  #$40,(word_FF80C4).w            ; '@'
                rts
; End of function Message_LoadNextGlyphTile
; Renders a message sprite line with caller-provided position offsets
Message_RenderLineWithOffsets:                          ; CODE XREF: BattleBanner_AnimateFightLine+28   p  ; was: sub_B3E6
                move.w  (dword_FF80C8).w,d5
                move.w  (dword_FF80CE).w,d6
                bra.s   Message_RenderLineWithCurrentOffsets
; End of function Message_RenderLineWithOffsets
; Renders a message sprite line without position offsets
Message_RenderLine:                                     ; CODE XREF: BattleBanner_HoldReadyLine+6   p  ; was: sub_B3F0
                                        ; BattleBanner_StartFightLine+6   p
                btst    #3,(FrameCounter+1).w
                bne.s   Message_RenderLineReturn
                moveq   #0,d5
                moveq   #0,d6
Message_RenderLineWithCurrentOffsets:                   ; CODE XREF: Message_RenderLineWithOffsets+8   j  ; was: loc_B3FC
                bsr.s   Message_WriteSpriteLine
                lea     (dword_FFA100).w,a0
                jsr     (Sprite_AppendOAMEntries).l
Message_RenderLineReturn:                               ; CODE XREF: Message_RenderLine+6   j  ; was: locret_B408
                rts
; End of function Message_RenderLine
; Expands one compact message-line descriptor into sprite entries
Message_WriteSpriteLine:                                ; CODE XREF: Message_RenderLine:Message_RenderLineWithCurrentOffsets   p  ; was: sub_B40A
                move.w  (a0)+,d0
                move.w  (a0)+,d1
                moveq   #0,d2
                move.b  (a0)+,d2
                addi.w  #$80,d2
                add.w   d6,d2
                moveq   #0,d3
                move.b  (a0)+,d3
                add.w   d5,d3
                move.w  #$100,d4
                movea.w #(dword_FFA100-M68K_RAM),a1
                move.w  (a0)+,d7
; Writes each sprite entry in the compact message line
Message_WriteSpriteLineLoop:                            ; CODE XREF: Message_WriteSpriteLine+2A   j  ; was: loc_B428
                move.w  d2,(a1)+
                move.w  d4,(a1)+
                move.w  d0,(a1)+
                move.w  d1,(a1)+
                addq.w  #2,d0
                add.w   d3,d1
                dbf     d7,Message_WriteSpriteLineLoop
                move.w  #$FFFF,(a1)
                rts
; End of function Message_WriteSpriteLine
; ---------------------------------------------------------------------------
BattleBanner_StaticSpriteLine:  dc.l    $C6A0010A       ; DATA XREF: BattleBanner_HoldReadyLine   o  ; was: dword_B43E
                                        ; sub_AADC   o
                dc.l    $680B0004
BattleBanner_MovingSpriteLine:  dc.l    $C6AA00FF       ; DATA XREF: BattleBanner_AnimateFightLine+1E   o  ; was: dword_B446
                dc.l    $680B0006

; Start the boss-message sequence and publish its wait gate
BossMessage_Start:                                      ; CODE XREF: Boss_DestroyerProtoIntroMove+28   p  ; was: sub_B44E
                                        ; Boss_VictorFlyIn+1E   p
                bclr    #1,(byte_FFA209).w
                bne.s   BossMessage_StartReadyFightBanner
                bclr    #0,(MessageSequenceFlags).w
                cmpi.w  #4,(MessageMode).w
                bmi.s   BossMessage_SelectScript
BossMessage_StartReadyFightBanner:                      ; CODE XREF: BossMessage_Start+6   j  ; was: loc_B464
                move.w  #$1E,(MessageSequenceState).w
                move.l  #BattleBanner_GlyphSourceList,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
                move.b  #4,(VDPReg18Shadow+1).w
                rts
; ---------------------------------------------------------------------------
BossMessage_SelectScript:                               ; CODE XREF: BossMessage_Start+14   j  ; was: loc_B480
                asl.w   #3,d0
                cmpi.w  #2,(MessageMode).w
                bne.s   BossMessage_StartScript
                addi.w  #4,d0
BossMessage_StartScript:                                ; CODE XREF: BossMessage_Start+3A   j  ; was: loc_B48E
                move.w  #$10,(MessageSequenceState).w
                move.l  BossMessageScriptPointerTable(pc,d0.w),(dword_FF80C8).w
                rts
; End of function BossMessage_Start
; ---------------------------------------------------------------------------
BossMessageScriptPointerTable:  dc.l    BossMessageScript_DeepStriderGroup  ; was: off_B49C
                dc.l    BossMessageScript_DeepStriderGroup
                dc.l    BossMessageScript_AntroidGroup
                dc.l    BossMessageScript_AntroidGroup
                dc.l    BossMessageScript_UnusedSlot2
                dc.l    BossMessageScript_UnusedSlot2
                dc.l    BossMessageScript_CommonGroup   ; text?
                dc.l    BossMessageScript_CommonGroup   ; text?
                dc.l    BossMessageScript_ShellshogunGroup
                dc.l    BossMessageScript_ShellshogunGroup
                dc.l    BossMessageScript_JokerGroup
                dc.l    BossMessageScript_JokerGroup
                dc.l    BossMessageScript_MadamBarbar
                dc.l    BossMessageScript_MadamBarbar
                dc.l    BossMessageScript_FlyingNeo
                dc.l    BossMessageScript_FlyingNeo
                dc.l    ShipAndValkirieMessageScript
                dc.l    ShipAndValkirieMessageScript

; Starts the ship-name script, selecting the configured message-mode entry
ShipName_StartScript:                                   ; CODE XREF: ShipSequence_ShowName+4   p  ; was: sub_B4E4
                                        ; ShipSequence_WaitForVerticalPosition+10   p
                bset    #0,(MessageSequenceFlags).w
                asl.w   #3,d0
                cmpi.w  #2,(MessageMode).w
                bne.s   ShipName_SelectScript
                addi.w  #4,d0
ShipName_SelectScript:                                  ; CODE XREF: ShipName_StartScript+E   j  ; was: loc_B4F8
                move.w  #2,(MessageSequenceState).w
                move.l  ShipNameScriptPointerTable(pc,d0.w),(dword_FF80C8).w
                rts
; End of function ShipName_StartScript
; ---------------------------------------------------------------------------
ShipNameScriptPointerTable: dc.w    0, $B8E8, 0, $B8E8, 4, $FFFF, $D08A, $1D1E, $B11, $F02, 0  ; was: word_B506
                dc.w    $2113, $1811, $19, $1000, $1E12, $F00, $1619, $1D0B, $1811, $F16, $F1D
                dc.w    $FF00
StageIntro_GlyphSourceList: dc.w    $102, $304, $506, $708, $90A, $1D1E, $B11, $FFF  ; was: word_B534
                                        ; DATA XREF: StageIntro_InitializeBanner+10   o
BattleBanner_GlyphSourceList:   dc.w    $1C0F, $B0E, $2310, $1311, $121E, $2929, $29FF  ; was: word_B544
                                        ; DATA XREF: BattleBanner_PrepareGlyphs+C   o
                                        ; BossMessage_Start+1C   o
Results_TimeBonusGlyphSourceList:   dc.w    $102, $304, $506, $708, $90A, $1D1E, $B11, $F0D  ; was: word_B552
                                        ; DATA XREF: Results_InitializeTimeBonus+4   o
                dc.w    $161C, $C19, $181F, $FF00
StageIntro_EmergencyGlyphSourceList:    dc.w    $F17, $1C11, $180D, $23FF  ; was: word_B56A
                                        ; DATA XREF: StageIntro_InitializeEmergencyBanner+4   o
BossMessageScript_CommonGroup:  dc.b    0, 6, 0, $1E, $FF, $FF, $D0, $90  ; was: byte_B572
                                        ; DATA XREF: ROM:0000B4B4   o
                                        ; ROM:0000B4B8   o
                dc.b    $5A, $32, $39, $3E, $D8, $82, $80, $A3  ; text?
                dc.b    $7F, $AB, $8D, $A4, $B2, $C5, $DA, $D9
                dc.b    $4E, $40, $5B, $6D, $3F, $5A, $D9, $FF
                dc.b    $D0, $90, $4E, $64, $49, $39, $48, $B2
                dc.b    $CC, $C8, $92, $A3, $C8, $C0, $DA, $43
                dc.b    0, $42, $30, $5B, $3D, $47, $5D, $34
                dc.b    $32, $D9, $FF, 0, $D0, $90, $9F, $8A
                dc.b    $87, $A2, $5D, 0, $31, $79, $42, $37
                dc.b    $56, $55, $63, $76, $47, $33, $35, $5A
                dc.b    $D8, $83, $80, $D9, $FF, 0, $D0, $90
                dc.b    $3A, $30, $D8, $35, $35, $79, $42, $36
                dc.b    $58, $5D, $56, $DB, $89, $8A, $9E, $45
                dc.b    $3B, $42, $58, $55, $65, $DB, $FF, 0
BossMessageScript_ShellshogunGroup: dc.b    0, 6, 0, $1E, $FF, $FF, $D0, $90  ; was: byte_B5E2
                                        ; DATA XREF: ROM:0000B4BC   o
                                        ; ROM:0000B4C0   o
                dc.b    $32, $46, $79, $DB, 0, $86, $8C, $52
                dc.b    $48, $51, $DB, 0, $93, $94, $58, $41
                dc.b    $DB, $93, $94, $58, $41, $DB, $DB, $FF
                dc.b    $D0, $90, $3D, $79, $3B, $76, $D8, $8A
                dc.b    $CC, $A4, $8A, $C7, $DA, $AE, $AB, $45
                dc.b    $42, $8D, $DA, $A6, $DA, $DB, $DB, $FF
                dc.b    $D0, $90, $34, $32, $79, $D8, $83, $A5
                dc.b    $49, $82, $80, $A3, $7F, $AB, $8D, $A4
                dc.b    $B2, $C5, $DA, $DB, $DB, $FF, $D0, $90
                dc.b    $81, $BA, $48, $B9, $86, $48, $70, $32
                dc.b    $51, $DB, 0, $83, $A5, $48, $32, $61
                dc.b    $36, $45, $41, $31, $42, $39, $56, $55
                dc.b    $35, $DB, $FF, 0
BossMessageScript_UnusedSlot2:  dc.b    0, 6, 0, $16, $FF, $FF, $D0, $90  ; was: byte_B64E
                                        ; DATA XREF: ROM:0000B4AC   o
                                        ; ROM:0000B4B0   o
                dc.b    $83, $A5, $48, $44, $49, $D8, $98, $94
                dc.b    $CA, $BB, $80, $C0, $DA, $D9, $FF, 0
                dc.b    $D0, $90, $3C, $4E, $44, $31, $D9, $85
                dc.b    $89, $9D, $48, 0, $63, $5C, $3D, $31
                dc.b    $49, $D8, $39, $39, $6A, 0, $34, $5B
                dc.b    $55, $D9, $FF, 0, $D0, $90, $32, $55
                dc.b    $3D, $33, $D9, $83, $A5, $49, 0, $83
                dc.b    $80, $BF, $A5, $45, $44, $55, $4E, $6A
                dc.b    0, $31, $36, $42, $58, $55, $D9, $FF
                dc.b    $D0, $90, $98, $84, $45, 0, $49, $31
                dc.b    $55, $48, $49, $D8, $83, $9D, $82, $3A
                dc.b    $5C, $48, $4D, $32, $3A, $D9, $FF, 0
BossMessageScript_AntroidGroup: dc.b    0, 6, 0, $18, $FF, $FF, $D0, $90  ; was: byte_B6B6
                                        ; DATA XREF: ROM:0000B4A4   o
                                        ; ROM:0000B4A8   o
                dc.b    $34, $49, $5A, $32, $D9, $34, $48, $56
                dc.b    $49, $D8, $93, $94, $A1, $97, $67, $DC
                dc.b    $FF, 0, $D0, $90, $8B, $84, $A4, $BF
                dc.b    $8B, $48, 0, $96, $9F, $A3, $E2, 0
                dc.b    $B2, $C5, $9D, $3C, $55, $5C, $63, $76
                dc.b    $44, $31, $D9, $FF, $D0, $90, $5A, $37
                dc.b    $47, $3F, $35, $31, $D8, $BE, $80, $BC
                dc.b    $CA, $DA, $DC, $DC, $FF, 0, $D0, $90
                dc.b    $32, $5C, $6B, $32, $48, 0, $63, $35
                dc.b    $5C, $67, $D9, $90, $85, $30, $32, $65
                dc.b    $D9, $FF
BossMessageScript_DeepStriderGroup: dc.b    0, 6, 0, $1C, $FF, $FF, $D0, $90  ; was: byte_B710
                                        ; DATA XREF: ROM:BossMessageScriptPointerTable   o
                                        ; ROM:0000B4A0   o
                dc.b    $87, $80, $88, $86, $DB, $87, $80, $88
                dc.b    $86, $DB, $BD, $8D, $81, $9C, $81, $85
                dc.b    $3D, $5A, $DB, $DB, $FF, 0, $D0, $90
                dc.b    $AA, $A5, $AA, $A5, $49, $D8, $BD, $A3
                dc.b    $C7, $86, $39, $32, $3B, $E2, 0, $3F
                dc.b    $51, $53, $5B, $44, $31, $DB, $FF, 0
                dc.b    $D0, $90, $58, $56, $55, $52, $48, $44
                dc.b    $53, 0, $58, $79, $42, $4F, $57, $31
                dc.b    $D8, $BB, $DA, $A6, $DA, $D9, $FF, 0
                dc.b    $D0, $90, $80, $AB, $8E, $DA, $8C, $C2
                dc.b    $8E, $DA, $D8, $8B, $8E, $AB, $BB, $80
                dc.b    $3D, $5A, $DB, $DB, $FF, 0
BossMessageScript_MadamBarbar:  dc.b    0, 6, 0, $22, $FF, $FF, $D0, $90  ; was: byte_B776
                                        ; DATA XREF: ROM:0000B4CC   o
                                        ; ROM:0000B4D0   o
                dc.b    $5B, $3F, $3B, $49, 0, $86, $A2, $BD
                dc.b    $BB, $DA, $BB, $DA, $43, $52, $32, $3B
                dc.b    $4E, $3C, $D9, $6B, $66, $A9, $A6, $8A
                dc.b    $86, $D9, $FF, 0, $D0, $90, $67, $31
                dc.b    $63, $44, $92, $88, $A6, $E2, 0, $8F
                dc.b    $C7, $85, $C8, $43, $31, $36, $4E, $3C
                dc.b    $5A, $D9, $9A, $9A, $9A, $D8, $D8, $D8
                dc.b    $FF, 0, $D0, $90, $58, $56, $55, $52
                dc.b    $5C, $44, $53, 0, $58, $79, $42, $4F
                dc.b    $57, $31, $D8, $BB, $DA, $A6, $DA, $D9
                dc.b    $FF, 0, $D0, $90, $6B, $32, $6A, $52
                dc.b    $31, $31, $38, $6B, 0, $32, $4E, $3E
                dc.b    $32, $67, $44, $D8, $83, $9D, $82, $D9
                dc.b    $FF, 0
BossMessageScript_FlyingNeo:    dc.b    0, 6, 0, $22, $FF, $FF, $D0, $90  ; was: byte_B7E8
                                        ; DATA XREF: ROM:0000B4D4   o
                                        ; ROM:0000B4D8   o
                dc.b    $61, $6E, $3A, $3F, $67, $44, $D9, $39
                dc.b    $48, $7F, $89, $A4, $92, $8E, $80, $AC
                dc.b    $DA, $48, $90, $A2, $E2, $5B, $3C, $56
                dc.b    $3F, $35, $DC, $FF, $D0, $90, $50, $35
                dc.b    $3B, $48, $5A, $3B, $4F, $67, $D8, $93
                dc.b    $84, $9D, $45, $44, $56, $D9, $40, $36
                dc.b    $77, $32, $49, $52, $32, $34, $5B, $54
                dc.b    $67, $D9, $FF, 0, $D0, $90, $91, $A6
                dc.b    $A3, $8B, $92, $48, $80, $95, $45, $44
                dc.b    $54, $3A, $5D, $54, $58, $5D, $79, $3F
                dc.b    $35, $DB, $DB, $7F, $89, $A4, $92, $DB
                dc.b    $DB, $FF, $D0, $90, $82, $80, $A3, $7F
                dc.b    $AB, $8D, $A4, $B2, $C5, $DA, $43, $3B
                dc.b    $42, $48, $4D, $39, $54, $49, $6B, $39
                dc.b    $4C, $58, $79, $3F, $DB, $DB, $FF, 0
BossMessageScript_JokerGroup:   dc.b    0, 6, 0, $22, $FF, $FF, $D0, $90  ; was: byte_B868
                                        ; DATA XREF: ROM:0000B4C4   o
                                        ; ROM:0000B4C8   o
                dc.b    $61, $6E, $3A, $3F, $67, $44, $D9, $39
                dc.b    $48, $7F, $89, $A4, $92, $8E, $80, $AC
                dc.b    $DA, $48, $90, $A2, $E2, $5B, $3C, $56
                dc.b    $3F, $35, $DC, $FF, $D0, $90, $50, $35
                dc.b    $3B, $48, $5A, $3B, $4F, $67, $D8, $93
                dc.b    $84, $9D, $45, $44, $56, $D9, $40, $36
                dc.b    $77, $32, $49, $52, $32, $34, $5B, $54
                dc.b    $67, $D9, $FF, 0, $D0, $90, $91, $A6
                dc.b    $A3, $8B, $92, $48, $80, $95, $45, $44
                dc.b    $54, $3A, $5D, $54, $58, $5D, $79, $3F
                dc.b    $35, $DB, $DB, $7F, $89, $A4, $92, $DB
                dc.b    $DB, $FF, $D0, $90, $82, $80, $A3, $7F
                dc.b    $AB, $8D, $A4, $B2, $C5, $DA, $43, $3B
                dc.b    $42, $48, $4D, $39, $54, $49, $6B, $39
                dc.b    $4C, $58, $79, $3F, $DB, $DB, $FF, 0
ShipAndValkirieMessageScript:   dc.b    0, 4, $FF, $FF, $D0, $90, $35, $79  ; was: byte_B8E8
                                        ; DATA XREF: ROM:0000B4DC   o
                                        ; ROM:0000B4E0   o
                dc.b    $D8, $D8, $D8, 0, $35, $33, $6A, $40
                dc.b    $76, $5C, $D8, $D8, $D8, $DC, $DC, $FF
