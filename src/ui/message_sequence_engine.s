MessageSequence_Dispatch:                               ; CODE XREF: Sys_GameplayMainLoop+15E   p  ; was: sub_A970
                tst.b   (FrameControlFlags).w
                bpl.s   MessageSequence_CheckActiveState
MessageSequence_DispatchReturn:                         ; CODE XREF: MessageSequence_Dispatch+C   j  ; was: locret_A976
                rts
; ---------------------------------------------------------------------------
MessageSequence_CheckActiveState:                       ; CODE XREF: MessageSequence_Dispatch+4   j  ; was: loc_A978
                tst.w   (MessageSequenceState).w
                beq.s   MessageSequence_DispatchReturn
                btst    #0,(MessageSequenceFlags).w
                bne.s   MessageSequence_DispatchActiveState
                move.b  (word_FFF708).w,d0
                andi.b  #$70,d0                         ; 'p'
                move.b  d0,(MessageAdvanceButtons).w
MessageSequence_DispatchActiveState:                    ; CODE XREF: MessageSequence_Dispatch+14   j  ; was: loc_A992
                move.w  (MessageSequenceState).w,d0
                movea.w MessageSequence_HandlerTable(pc,d0.w),a0
                adda.l  #MessageSequence_AdvanceState,a0
                jmp     (a0)
; End of function MessageSequence_Dispatch
; ---------------------------------------------------------------------------
MessageSequence_HandlerTable:   dc.w    MessageSequence_Idle-MessageSequence_AdvanceState  ; was: off_A9A2
                dc.w    MessageSequence_AdvanceToScriptSetup-MessageSequence_AdvanceState
                dc.w    MessageScript_Begin-MessageSequence_AdvanceState
                dc.w    MessageScript_DispatchCommand-MessageSequence_AdvanceState
                dc.w    MessageScript_RenderGlyph-MessageSequence_AdvanceState
                dc.w    MessageScript_WaitAndRefreshGlyph-MessageSequence_AdvanceState
                dc.w    MessageScript_RenderTilemapChunk-MessageSequence_AdvanceState
                dc.w    MessageSequence_FinishScript-MessageSequence_AdvanceState
                dc.w    MessageSequence_AdvanceToScriptSetup-MessageSequence_AdvanceState
                dc.w    MessageScript_Begin-MessageSequence_AdvanceState
                dc.w    MessageScript_DispatchCommand-MessageSequence_AdvanceState
                dc.w    MessageScript_RenderGlyph-MessageSequence_AdvanceState
                dc.w    MessageScript_WaitAndRefreshGlyph-MessageSequence_AdvanceState
                dc.w    MessageScript_RenderTilemapChunk-MessageSequence_AdvanceState
                dc.w    BattleBanner_PrepareGlyphs-MessageSequence_AdvanceState
                dc.w    BattleBanner_LoadGlyphs-MessageSequence_AdvanceState
                dc.w    BattleBanner_HoldReadyLine-MessageSequence_AdvanceState
                dc.w    BattleBanner_StartFightLine-MessageSequence_AdvanceState
                dc.w    BattleBanner_AnimateFightLine-MessageSequence_AdvanceState
                dc.w    MessageSequence_AdvanceState-MessageSequence_AdvanceState
                dc.w    MessageScript_DispatchCommand-MessageSequence_AdvanceState
                dc.w    MessageScript_RenderGlyph-MessageSequence_AdvanceState
                dc.w    MessageSequence_End-MessageSequence_AdvanceState
                dc.w    Results_InitializeTimeBonus-MessageSequence_AdvanceState
                dc.w    Results_LoadTimeBonusGlyphs-MessageSequence_AdvanceState
                dc.w    Results_SpinInTimeBonus-MessageSequence_AdvanceState
                dc.w    Results_SlowTimeBonusSpin-MessageSequence_AdvanceState
                dc.w    Results_FinishTimeBonusSpin-MessageSequence_AdvanceState
                dc.w    Results_AnimateTimeBonusEntry-MessageSequence_AdvanceState
                dc.w    Results_HoldTimeBonus-MessageSequence_AdvanceState
                dc.w    Results_AnimateTimeBonusExit-MessageSequence_AdvanceState
                dc.w    Results_ApplyRemainingTimeBonus-MessageSequence_AdvanceState
                dc.w    Results_ApplyRemainingTimeBonus-MessageSequence_AdvanceState
                dc.w    Message_FadeInRadialText-MessageSequence_AdvanceState
                dc.w    Message_FadeInRadialText-MessageSequence_AdvanceState
                dc.w    Message_FadeInRadialText-MessageSequence_AdvanceState
                dc.w    Message_FadeOutRadialText-MessageSequence_AdvanceState
                dc.w    Message_UpdateWaitTimer-MessageSequence_AdvanceState
                dc.w    MessageSequence_Idle-MessageSequence_AdvanceState
                dc.w    MessageSequence_Idle-MessageSequence_AdvanceState
                dc.w    StageIntro_InitializeBanner-MessageSequence_AdvanceState
                dc.w    StageIntro_LoadStageNumberGlyph-MessageSequence_AdvanceState
                dc.w    StageIntro_UpdateStageNumberBanner-MessageSequence_AdvanceState
                dc.w    StageIntro_InitializeEmergencyBanner-MessageSequence_AdvanceState
                dc.w    StageIntro_LoadEmergencyGlyph-MessageSequence_AdvanceState
                dc.w    StageIntro_UpdateEmergencyFlash-MessageSequence_AdvanceState
                dc.w    StageIntro_InitializePostBannerDelay-MessageSequence_AdvanceState
                dc.w    StageIntro_UpdatePostBannerDelay-MessageSequence_AdvanceState

; Advances the shared message sequence by one state-table entry
MessageSequence_AdvanceState:                           ; DATA XREF: MessageSequence_Dispatch+2A   o  ; was: sub_AA02
                                        ; ROM:MessageSequence_HandlerTable   o
                addq.w  #2,(MessageSequenceState).w
                rts
; End of function MessageSequence_AdvanceState
; Ends the shared message sequence
MessageSequence_End:                                    ; DATA XREF: ROM:0000A9CE   o  ; was: sub_AA08
                clr.w   (MessageSequenceState).w
                rts
; End of function MessageSequence_End
; Advances either script-entry path to its setup state
MessageSequence_AdvanceToScriptSetup:                   ; DATA XREF: ROM:0000A9A4   o  ; was: sub_AA0E
                                        ; ROM:0000A9B2   o
                addq.w  #2,(MessageSequenceState).w
                rts
; End of function MessageSequence_AdvanceToScriptSetup
; Ends an encoded message script and restores its graphics state
MessageSequence_FinishScript:                           ; DATA XREF: ROM:0000A9B0   o  ; was: sub_AA14
                clr.w   (MessageSequenceState).w
MessageSequence_FinalizeScriptGraphics:                 ; CODE XREF: BattleBanner_PrepareGlyphs   p  ; was: loc_AA18
                bclr    #7,(MessageDisplayFlags).w
                bsr.s   Message_QueueFontBasePatternDMAs
                jmp     UI_QueueAllWeaponIconTransfers
; End of function MessageSequence_FinishScript
; Queues the three fixed six-word font-base pattern transfers
Message_QueueFontBasePatternDMAs:                       ; CODE XREF: MessageSequence_FinishScript+A   p  ; was: sub_AA26
                movea.w (VDPCommandQueueHead).w,a1
                move.l  #MessageDisplay_FontBasePattern0,d0
                move.w  #$5080,d7
                bsr.s   Message_QueueFontBasePatternDMA
                move.l  #MessageDisplay_FontBasePattern1,d0
                move.w  #$5100,d7
                bsr.s   Message_QueueFontBasePatternDMA
                move.l  #MessageDisplay_FontBasePattern2,d0
                move.w  #$5180,d7
                bsr.s   Message_QueueFontBasePatternDMA
                move.w  a1,(VDPCommandQueueHead).w
                rts
; End of function Message_QueueFontBasePatternDMAs
; Queues one six-word font-base pattern transfer to the supplied VDP destination
Message_QueueFontBasePatternDMA:                        ; CODE XREF: Message_QueueFontBasePatternDMAs+E   p  ; was: sub_AA54
                                        ; Message_QueueFontBasePatternDMAs+1A   p
                move.w  #$83,-(a1)
                move.w  d7,-(a1)
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.b  d2,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  #$94009306,-(a1)
                rts
; End of function Message_QueueFontBasePatternDMA
; Finalizes prior script graphics, then prepares the READY/FIGHT glyph list
BattleBanner_PrepareGlyphs:                             ; DATA XREF: ROM:0000A9BE   o  ; was: sub_AA86
                bsr.s   MessageSequence_FinalizeScriptGraphics
                subq.w  #1,(dword_FF80CE).w
                bpl.s   BattleBanner_PrepareGlyphsReturn
                addq.w  #2,(MessageSequenceState).w
                move.l  #BattleBanner_GlyphSourceList,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
BattleBanner_PrepareGlyphsReturn:                       ; CODE XREF: BattleBanner_PrepareGlyphs+6   j  ; was: locret_AAA0
                rts
; End of function BattleBanner_PrepareGlyphs
; Streams the unique READY/FIGHT glyphs and initializes the banner delay
BattleBanner_LoadGlyphs:                                ; DATA XREF: ROM:0000A9C0   o  ; was: sub_AAA2
                bsr.w   Message_LoadNextGlyphTile
                cmpi.w  #$1E,(MessageSequenceState).w
                beq.s   BattleBanner_LoadGlyphsReturn
                move.b  #$16,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$60,(word_FF80C6).w            ; '`'
                move.w  #$64,(dword_FF80CE).w           ; 'd'
BattleBanner_LoadGlyphsReturn:                          ; CODE XREF: BattleBanner_LoadGlyphs+A   j  ; was: locret_AAC4
                rts
; End of function BattleBanner_LoadGlyphs
; Holds the READY sprite line until its countdown expires
BattleBanner_HoldReadyLine:                             ; DATA XREF: ROM:0000A9C2   o  ; was: sub_AAC6
                movea.l #BattleBanner_StaticSpriteLine,a0
                bsr.w   Message_RenderLine
                subq.w  #1,(word_FF80C6).w
                bpl.s   BattleBanner_HoldReadyLineReturn
                addq.w  #2,(MessageSequenceState).w
BattleBanner_HoldReadyLineReturn:                       ; CODE XREF: BattleBanner_HoldReadyLine+E   j  ; was: locret_AADA
                rts
; End of function BattleBanner_HoldReadyLine
; Starts the moving FIGHT line and stores the current phase split time
BattleBanner_StartFightLine:                            ; DATA XREF: ROM:0000A9C4   o  ; was: sub_AADC
                movea.l #BattleBanner_StaticSpriteLine,a0
                bsr.w   Message_RenderLine
                move.b  #$17,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,(MessageSequenceState).w
                move.w  #$34,(word_FF80C6).w            ; '4'
                clr.l   (dword_FF80CE).w
                move.l  #$20000,(dword_FF80C8).w
                bclr    #0,(byte_FFA272).w
                jsr     (Results_StorePhaseSplitTime).l
                rts
; End of function BattleBanner_StartFightLine
; Animates the FIGHT line with a decreasing fixed-point velocity
BattleBanner_AnimateFightLine:                          ; DATA XREF: ROM:0000A9C6   o  ; was: sub_AB14
                subq.w  #1,(word_FF80C6).w
                bpl.s   BattleBanner_UpdateFightLineMotion
                clr.w   (MessageSequenceState).w
                rts
; ---------------------------------------------------------------------------
BattleBanner_UpdateFightLineMotion:                     ; CODE XREF: BattleBanner_AnimateFightLine+4   j  ; was: loc_AB20
                move.l  (dword_FF80C8).w,d0
                add.l   d0,(dword_FF80CE).w
                subi.l  #$2000,d0
                movem.l d0,-(sp)
                movea.l #BattleBanner_MovingSpriteLine,a0
                clr.l   (dword_FF80C8).w
                bsr.w   Message_RenderLineWithOffsets
                movem.l (sp)+,d0
                move.l  d0,(dword_FF80C8).w
                rts
; End of function BattleBanner_AnimateFightLine
; Starts either encoded message-script entry path and queues its font tiles
MessageScript_Begin:                                    ; DATA XREF: ROM:0000A9A6   o  ; was: sub_AB4A
                                        ; ROM:0000A9B4   o
                addq.w  #2,(MessageSequenceState).w
                bset    #7,(MessageDisplayFlags).w
                bsr.w   Message_QueueFontPatternFillDMAs
; End of function MessageScript_Begin
; Dispatches an encoded message command, terminator, or glyph record
MessageScript_DispatchCommand:                          ; DATA XREF: ROM:0000A9A8   o  ; was: sub_AB58
                                        ; ROM:0000A9B6   o
                movea.l (dword_FF80C8).w,a0
                move.w  (a0),d0
                cmpi.w  #$FFFE,d0
                beq.w   MessageScript_QueueTilemapDMA
                cmpi.w  #$FFFF,d0
                bne.w   MessageScript_SetupGlyph
                addq.w  #8,(MessageSequenceState).w
                move.w  #$40,(dword_FF80CE).w           ; '@'
                rts
; End of function MessageScript_DispatchCommand
; Decodes one message glyph record and initializes its render attributes
MessageScript_SetupGlyph:                               ; CODE XREF: MessageScript_DispatchCommand+12   j  ; was: sub_AB7A
                addq.w  #2,(MessageSequenceState).w
                move.w  #$D0,(word_FF80C6).w
                addq.l  #2,(dword_FF80C8).w
                ext.l   d0
                adda.l  d0,a0
                moveq   #0,d4
                moveq   #0,d3
                move.b  (a0)+,d4
                move.b  (a0)+,d3
                asl.w   #8,d4
                add.w   d3,d4
                move.w  d4,d3
                andi.w  #$7FFE,d4
                move.l  a0,(dword_FF80CE).w
                move.w  d4,(word_FF80CC).w
                move.w  #$C,(word_FF80D6).w
                move.w  #$5400,(word_FF80C4).w
                move.w  #$86A0,(word_FF80D2).w
                moveq   #0,d2
                btst    #0,d3
                beq.s   MessageScript_CheckGlyphPriority
                addi.w  #$2000,d2
MessageScript_CheckGlyphPriority:                       ; CODE XREF: MessageScript_SetupGlyph+44   j  ; was: loc_ABC4
                tst.w   d3
                bpl.s   MessageScript_StoreGlyphAttributes
                addi.w  #$4000,d2
MessageScript_StoreGlyphAttributes:                     ; CODE XREF: MessageScript_SetupGlyph+4C   j  ; was: loc_ABCC
                add.w   d2,(word_FF80D2).w
; End of function MessageScript_SetupGlyph
; Idle message-sequence state
MessageSequence_Idle:                                   ; DATA XREF: ROM:MessageSequence_HandlerTable   o  ; was: nullsub_22
                                        ; ROM:0000A9EE   o
                rts
; End of function MessageSequence_Idle
; Queues two fixed 32-word pattern-fill transfers
Message_QueueTwoPatternFillDMAs:                        ; was: sub_ABD2
                movea.w (VDPCommandQueueHead).w,a1
                move.w  #$5290,d0
                bsr.s   Message_QueuePatternFillDMA
                move.w  #$5310,d0
                bsr.s   Message_QueuePatternFillDMA
                move.w  a1,(VDPCommandQueueHead).w
                rts
; End of function Message_QueueTwoPatternFillDMAs
; Queues one 32-word pattern-fill transfer to the supplied VDP destination
Message_QueuePatternFillDMA:                            ; CODE XREF: Message_QueueTwoPatternFillDMAs+8   p  ; was: sub_ABE8
                                        ; Message_QueueTwoPatternFillDMAs+E   p
                move.w  #$83,-(a1)
                move.w  d0,-(a1)
                move.l  #MessageDisplay_FontPatternFillSource,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.b  d2,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  #$94009320,-(a1)
                rts
; End of function Message_QueuePatternFillDMA
; Queues the three fixed 40-word font-pattern fill transfers used by message scripts
Message_QueueFontPatternFillDMAs:                       ; CODE XREF: MessageScript_Begin+A   p  ; was: sub_AC20
                                        ; MessageScript_WaitAndRefreshGlyph+10   p
                movea.w (VDPCommandQueueHead).w,a1
                move.w  #$5080,d0
                bsr.s   Message_QueueFontPatternFillDMA
                move.w  #$5100,d0
                bsr.s   Message_QueueFontPatternFillDMA
                move.w  #$5180,d0
                bsr.s   Message_QueueFontPatternFillDMA
                move.w  a1,(VDPCommandQueueHead).w
                rts
; End of function Message_QueueFontPatternFillDMAs
; Queues one 40-word font-pattern fill transfer to the supplied VDP destination
Message_QueueFontPatternFillDMA:                        ; CODE XREF: Message_QueueFontPatternFillDMAs+8   p  ; was: sub_AC3C
                                        ; Message_QueueFontPatternFillDMAs+E   p
                move.w  #$83,-(a1)
                move.w  d0,-(a1)
                move.l  #MessageDisplay_FontPatternFillSource,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.b  d2,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  #$94009328,-(a1)
                rts
; End of function Message_QueueFontPatternFillDMA
; Builds one transparent glyph tile, queues its DMA, and writes tilemap words
MessageScript_RenderGlyph:                              ; DATA XREF: ROM:0000A9AA   o  ; was: sub_AC74
                                        ; ROM:0000A9B8   o
                movea.l (dword_FF80CE).w,a0
                moveq   #0,d0
                move.b  (a0),d0
                cmpi.b  #$FF,d0
                bne.s   MessageScript_DrawGlyph
                addq.w  #2,(MessageSequenceState).w
                rts
; ---------------------------------------------------------------------------
MessageScript_DrawGlyph:                                ; CODE XREF: MessageScript_RenderGlyph+C   j  ; was: loc_AC88
                asl.w   #6,d0
                addi.l  #tiles_font,d0
                movea.l d0,a0
                movea.w #(byte_FFA300-M68K_RAM),a1
                moveq   #$F,d7
MessageScript_CopyGlyphRowLoop:                         ; CODE XREF: MessageScript_RenderGlyph+90   j  ; was: loc_AC98
                move.l  (a0)+,d2
                move.l  d2,(dword_FF8040).w
                move.l  d2,(dword_FF8044).w
                andi.b  #$F0,(dword_FF8040).w
                bne.s   MessageScript_CheckGlyphNibble2
                bset    #$1C,d2
MessageScript_CheckGlyphNibble2:                        ; CODE XREF: MessageScript_RenderGlyph+34   j  ; was: loc_ACAE
                andi.b  #$F,(dword_FF8044).w
                bne.s   MessageScript_CheckGlyphNibble3
                bset    #$18,d2
MessageScript_CheckGlyphNibble3:                        ; CODE XREF: MessageScript_RenderGlyph+40   j  ; was: loc_ACBA
                andi.b  #$F0,(dword_FF8040+1).w
                bne.s   MessageScript_CheckGlyphNibble4
                bset    #$14,d2
MessageScript_CheckGlyphNibble4:                        ; CODE XREF: MessageScript_RenderGlyph+4C   j  ; was: loc_ACC6
                andi.b  #$F,(dword_FF8044+1).w
                bne.s   MessageScript_CheckGlyphNibble5
                bset    #$10,d2
MessageScript_CheckGlyphNibble5:                        ; CODE XREF: MessageScript_RenderGlyph+58   j  ; was: loc_ACD2
                andi.b  #$F0,(dword_FF8040+2).w
                bne.s   MessageScript_CheckGlyphNibble6
                bset    #$C,d2
MessageScript_CheckGlyphNibble6:                        ; CODE XREF: MessageScript_RenderGlyph+64   j  ; was: loc_ACDE
                andi.b  #$F,(dword_FF8044+2).w
                bne.s   MessageScript_CheckGlyphNibble7
                bset    #8,d2
MessageScript_CheckGlyphNibble7:                        ; CODE XREF: MessageScript_RenderGlyph+70   j  ; was: loc_ACEA
                andi.b  #$F0,(dword_FF8040+3).w
                bne.s   MessageScript_CheckGlyphNibble8
                bset    #4,d2
MessageScript_CheckGlyphNibble8:                        ; CODE XREF: MessageScript_RenderGlyph+7C   j  ; was: loc_ACF6
                andi.b  #$F,(dword_FF8044+3).w
                bne.s   MessageScript_StoreGlyphRow
                bset    #0,d2
MessageScript_StoreGlyphRow:                            ; CODE XREF: MessageScript_RenderGlyph+88   j  ; was: loc_AD02
                move.l  d2,(a1)+
                dbf     d7,MessageScript_CopyGlyphRowLoop
                movea.w (VDPCommandQueueHead).w,a5
                move.w  #$83,-(a5)
                move.w  (word_FF80C4).w,-(a5)
                move.w  #$9580,-(a5)
                move.w  #$96D1,-(a5)
                move.l  #$8F02977F,-(a5)
                move.l  #$94009320,-(a5)
                movea.w (VDPStagingDataCursor).w,a0
                move.w  (word_FF80D2).w,d0
                move.w  d0,(a0)+
                addq.w  #1,d0
                move.w  d0,(a0)+
                move.w  #$83,-(a5)
                move.w  (word_FF80CC).w,-(a5)
                move.b  (VDPStagingDataCursor).w,d1
                move.b  (VDPStagingDataCursor+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a5)
                move.b  #$95,-(a5)
                move.b  d1,-(a5)
                move.b  #$96,-(a5)
                move.l  #$8F80977F,-(a5)
                move.l  #$94009302,-(a5)
                move.w  a5,(VDPCommandQueueHead).w
                addq.w  #4,(VDPStagingDataCursor).w
                addi.w  #$40,(word_FF80C4).w            ; '@'
                addq.l  #1,(dword_FF80CE).w
                addq.w  #2,(word_FF80CC).w
                addq.w  #2,(word_FF80D2).w
                subq.w  #1,(word_FF80C6).w
                move.b  (dword_FF80CE+3).w,d0
                andi.b  #3,d0
                bne.s   MessageScript_RenderGlyphReturn
                move.b  #$AD,d0
                jsr     (Sound_PlaySFX).l
MessageScript_RenderGlyphReturn:                        ; CODE XREF: MessageScript_RenderGlyph+114   j  ; was: locret_AD94
                rts
; End of function MessageScript_RenderGlyph
; Waits for the glyph delay or input, then refreshes the font-tile transfers
MessageScript_WaitAndRefreshGlyph:                      ; DATA XREF: ROM:0000A9AC   o  ; was: sub_AD96
                                        ; ROM:0000A9BA   o
                tst.b   (MessageAdvanceButtons).w
                bne.s   MessageScript_RefreshGlyphTiles
                subq.w  #1,(word_FF80C6).w
                bpl.s   MessageScript_WaitAndRefreshGlyphReturn
MessageScript_RefreshGlyphTiles:                        ; CODE XREF: MessageScript_WaitAndRefreshGlyph+4   j  ; was: loc_ADA2
                subq.w  #4,(MessageSequenceState).w
                bsr.w   Message_QueueFontPatternFillDMAs
MessageScript_WaitAndRefreshGlyphReturn:                ; CODE XREF: MessageScript_WaitAndRefreshGlyph+A   j  ; was: locret_ADAA
                rts
; End of function MessageScript_WaitAndRefreshGlyph
; Decodes a script DMA command and queues its ROM-to-VRAM tilemap transfer
MessageScript_QueueTilemapDMA:                          ; CODE XREF: MessageScript_DispatchCommand+A   j  ; was: sub_ADAC
                addq.w  #6,(MessageSequenceState).w
                clr.w   (word_FF80C6).w
                addq.l  #6,(dword_FF80C8).w
                movea.l (dword_FF80C8).w,a0
                move.l  -4(a0),d0
                andi.l  #$3FFFFF,d0
                move.w  -4(a0),d1
                andi.w  #$E000,d1
                move.w  d1,(word_FF80D4).w
                movea.w (VDPCommandQueueHead).w,a5
                move.w  #$83,-(a5)
                move.w  #$5E00,-(a5)
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a5)
                move.b  #$95,-(a5)
                move.b  d1,-(a5)
                move.b  #$96,-(a5)
                move.b  d2,-(a5)
                move.b  #$97,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94019300,-(a5)
                move.w  a5,(VDPCommandQueueHead).w
                rts
; End of function MessageScript_QueueTilemapDMA
; Writes one four-word chunk of the script-provided tilemap
MessageScript_RenderTilemapChunk:                       ; DATA XREF: ROM:0000A9AE   o  ; was: sub_AE0E
                                        ; ROM:0000A9BC   o
                move.w  (word_FF80C6).w,d0
                move.w  d0,d3
                addq.w  #2,(word_FF80C6).w
                cmpi.w  #8,(word_FF80C6).w
                bmi.s   MessageScript_SelectTilemapHalf
                subq.w  #6,(MessageSequenceState).w
MessageScript_SelectTilemapHalf:                        ; CODE XREF: MessageScript_RenderTilemapChunk+10   j  ; was: loc_AE24
                move.w  (word_FF80D4).w,d2
                bclr    #$F,d2
                beq.s   MessageScript_WriteTilemapChunk
                addq.w  #8,d0
MessageScript_WriteTilemapChunk:                        ; CODE XREF: MessageScript_RenderTilemapChunk+1E   j  ; was: loc_AE30
                movea.w (VDPStagingDataCursor).w,a1
                move.w  MessageScript_TileIndexGroups(pc,d0.w),d1
                add.w   d2,d1
                move.w  d1,(a1)+
                addq.w  #1,d1
                move.w  d1,(a1)+
                addq.w  #1,d1
                move.w  d1,(a1)+
                addq.w  #1,d1
                move.w  d1,(a1)+
                movea.w (VDPCommandQueueHead).w,a1
                move.w  #$83,-(a1)
                move.w  MessageScript_TilemapVRAMDestinations(pc,d3.w),-(a1)
                move.b  (VDPStagingDataCursor).w,d1
                move.b  (VDPStagingDataCursor+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F80977F,-(a1)
                move.l  #$94009304,-(a1)
                move.w  a1,(VDPCommandQueueHead).w
                addq.w  #8,(VDPStagingDataCursor).w
                rts
; End of function MessageScript_RenderTilemapChunk
; ---------------------------------------------------------------------------
MessageScript_TilemapVRAMDestinations:  dc.w    $5004, $5006, $5008, $500A  ; was: word_AE82
MessageScript_TileIndexGroups:          dc.w    $6F0, $6F4, $6F8, $6FC, $6F0, $6F4, $EF4, $EF0  ; was: word_AE8A
