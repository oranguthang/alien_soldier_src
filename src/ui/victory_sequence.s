Player_BehaviorDispatcher:                              ; CODE XREF: Sys_GameplayMainLoop+15E   p  ; was: sub_A970
                tst.b   (byte_FF813E).w
                bpl.s   loc_A978
locret_A976:                                            ; CODE XREF: Player_BehaviorDispatcher+C   j
                rts
; ---------------------------------------------------------------------------
loc_A978:                                               ; CODE XREF: Player_BehaviorDispatcher+4   j
                tst.w   (word_FF80C2).w
                beq.s   locret_A976
                btst    #0,(byte_FF80A8).w
                bne.s   loc_A992
                move.b  (word_FFF708).w,d0
                andi.b  #$70,d0                         ; 'p'
                move.b  d0,(byte_FF8310).w
loc_A992:                                               ; CODE XREF: Player_BehaviorDispatcher+14   j
                move.w  (word_FF80C2).w,d0
                movea.w off_A9A2(pc,d0.w),a0
                adda.l  #Player_AdvanceBehaviorState,a0
                jmp     (a0)
; End of function Player_BehaviorDispatcher
; ---------------------------------------------------------------------------
off_A9A2:       dc.w    Text_EmptyDisplayState-Player_AdvanceBehaviorState
                dc.w    Player_AdvanceBehaviorAlt-Player_AdvanceBehaviorState
                dc.w    Text_StartDisplaySequence-Player_AdvanceBehaviorState
                dc.w    Text_ParseScriptCommand-Player_AdvanceBehaviorState
                dc.w    Gfx_RenderTextCharacter-Player_AdvanceBehaviorState
                dc.w    Gfx_FlushTextBuffer-Player_AdvanceBehaviorState
                dc.w    Gfx_RenderTextGlyph-Player_AdvanceBehaviorState
                dc.w    Player_ResetBehaviorPalette-Player_AdvanceBehaviorState
                dc.w    Player_AdvanceBehaviorAlt-Player_AdvanceBehaviorState
                dc.w    Text_StartDisplaySequence-Player_AdvanceBehaviorState
                dc.w    Text_ParseScriptCommand-Player_AdvanceBehaviorState
                dc.w    Gfx_RenderTextCharacter-Player_AdvanceBehaviorState
                dc.w    Gfx_FlushTextBuffer-Player_AdvanceBehaviorState
                dc.w    Gfx_RenderTextGlyph-Player_AdvanceBehaviorState
                dc.w    Player_ProcessBehaviorTimer-Player_AdvanceBehaviorState
                dc.w    Text_BeginVictorySequence-Player_AdvanceBehaviorState
                dc.w    Text_UpdateAnimation-Player_AdvanceBehaviorState
                dc.w    Text_AdvancePhase-Player_AdvanceBehaviorState
                dc.w    Text_AnimateMovement-Player_AdvanceBehaviorState
                dc.w    Player_AdvanceBehaviorState-Player_AdvanceBehaviorState
                dc.w    Text_ParseScriptCommand-Player_AdvanceBehaviorState
                dc.w    Gfx_RenderTextCharacter-Player_AdvanceBehaviorState
                dc.w    Player_ResetBehaviorState-Player_AdvanceBehaviorState
                dc.w    Text_InitVictoryMessage-Player_AdvanceBehaviorState
                dc.w    Text_StartWeaponAcquired-Player_AdvanceBehaviorState
                dc.w    Text_AnimateRotationFade-Player_AdvanceBehaviorState
                dc.w    Text_AnimateRotationStop-Player_AdvanceBehaviorState
                dc.w    Text_CompleteWithSound-Player_AdvanceBehaviorState
                dc.w    Text_AnimateRiseUp-Player_AdvanceBehaviorState
                dc.w    Text_PauseBeforeExit-Player_AdvanceBehaviorState
                dc.w    Text_AnimateExitUp-Player_AdvanceBehaviorState
                dc.w    Text_FinalizeAndSaveScore-Player_AdvanceBehaviorState
                dc.w    Text_FinalizeAndSaveScore-Player_AdvanceBehaviorState
                dc.w    Cutscene_FadeInShipNameAlt-Player_AdvanceBehaviorState
                dc.w    Cutscene_FadeInShipNameAlt-Player_AdvanceBehaviorState
                dc.w    Cutscene_FadeInShipNameAlt-Player_AdvanceBehaviorState
                dc.w    Cutscene_FadeOutShipNameAlt-Player_AdvanceBehaviorState
                dc.w    Cutscene_WaitFrameTimer-Player_AdvanceBehaviorState
                dc.w    Text_EmptyDisplayState-Player_AdvanceBehaviorState
                dc.w    Text_EmptyDisplayState-Player_AdvanceBehaviorState
                dc.w    Player_Initialize-Player_AdvanceBehaviorState
                dc.w    Text_DisplayStageTitle-Player_AdvanceBehaviorState
                dc.w    UI_DisplayScoreAnimation-Player_AdvanceBehaviorState
                dc.w    Text_InitGradeDisplay-Player_AdvanceBehaviorState
                dc.w    Text_DisplayGradeText-Player_AdvanceBehaviorState
                dc.w    Text_AnimateGradeFlash-Player_AdvanceBehaviorState
                dc.w    Text_InitPauseTimer-Player_AdvanceBehaviorState
                dc.w    Text_PauseTimer_CountdownLoop-Player_AdvanceBehaviorState

; Increments player behavior state counter by 2
Player_AdvanceBehaviorState:                            ; DATA XREF: Player_BehaviorDispatcher+2A   o  ; was: sub_AA02
                                        ; ROM:off_A9A2   o
                addq.w  #2,(word_FF80C2).w
                rts
; End of function Player_AdvanceBehaviorState
; Clears player behavior state counter to 0
Player_ResetBehaviorState:                              ; DATA XREF: ROM:0000A9CE   o  ; was: sub_AA08
                clr.w   (word_FF80C2).w
                rts
; End of function Player_ResetBehaviorState
; Increments player behavior state counter by 2
Player_AdvanceBehaviorAlt:                              ; DATA XREF: ROM:0000A9A4   o  ; was: sub_AA0E
                                        ; ROM:0000A9B2   o
                addq.w  #2,(word_FF80C2).w
                rts
; End of function Player_AdvanceBehaviorAlt
; Resets behavior state and processes palette slots
Player_ResetBehaviorPalette:                            ; DATA XREF: ROM:0000A9B0   o  ; was: sub_AA14
                clr.w   (word_FF80C2).w
loc_AA18:                                               ; CODE XREF: Player_ProcessBehaviorTimer   p
                bclr    #7,(byte_FFFF31).w
                bsr.s   Gfx_QueueThreeHScrollDMAs
                jmp     Gfx_ProcessPaletteSlots
; End of function Player_ResetBehaviorPalette
; Queues three DMA transfers for horizontal scroll data
Gfx_QueueThreeHScrollDMAs:                              ; CODE XREF: Player_ResetBehaviorPalette+A   p  ; was: sub_AA26
                movea.w (word_FFF70C).w,a1
                move.l  #$180060,d0
                move.w  #$5080,d7
                bsr.s   Gfx_QueueSingleHScrollDMA
                move.l  #$18006C,d0
                move.w  #$5100,d7
                bsr.s   Gfx_QueueSingleHScrollDMA
                move.l  #$180078,d0
                move.w  #$5180,d7
                bsr.s   Gfx_QueueSingleHScrollDMA
                move.w  a1,(word_FFF70C).w
                rts
; End of function Gfx_QueueThreeHScrollDMAs
; Configures and queues single DMA for horizontal scroll
Gfx_QueueSingleHScrollDMA:                              ; CODE XREF: Gfx_QueueThreeHScrollDMAs+E   p  ; was: sub_AA54
                                        ; Gfx_QueueThreeHScrollDMAs+1A   p
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
; End of function Gfx_QueueSingleHScrollDMA
; Handles behavior timer countdown and state advancement
Player_ProcessBehaviorTimer:                            ; DATA XREF: ROM:0000A9BE   o  ; was: sub_AA86
                bsr.s   loc_AA18
                subq.w  #1,(dword_FF80CE).w
                bpl.s   locret_AAA0
                addq.w  #2,(word_FF80C2).w
                move.l  #word_B544,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
locret_AAA0:                                            ; CODE XREF: Player_ProcessBehaviorTimer+6   j
                rts
; End of function Player_ProcessBehaviorTimer
; Starts victory text display sequence with sound
Text_BeginVictorySequence:                              ; DATA XREF: ROM:0000A9C0   o  ; was: sub_AAA2
                bsr.w   Text_DisplayCharacter
                cmpi.w  #$1E,(word_FF80C2).w
                beq.s   locret_AAC4
                move.b  #$16,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$60,(word_FF80C6).w            ; '`'
                move.w  #$64,(dword_FF80CE).w           ; 'd'
locret_AAC4:                                            ; CODE XREF: Text_BeginVictorySequence+A   j
                rts
; End of function Text_BeginVictorySequence
; Updates text animation with countdown timer
Text_UpdateAnimation:                                   ; DATA XREF: ROM:0000A9C2   o  ; was: sub_AAC6
                movea.l #dword_B43E,a0
                bsr.w   Text_RenderLine
                subq.w  #1,(word_FF80C6).w
                bpl.s   locret_AADA
                addq.w  #2,(word_FF80C2).w
locret_AADA:                                            ; CODE XREF: Text_UpdateAnimation+E   j
                rts
; End of function Text_UpdateAnimation
; Advances to next text phase with sound effect
Text_AdvancePhase:                                      ; DATA XREF: ROM:0000A9C4   o  ; was: sub_AADC
                movea.l #dword_B43E,a0
                bsr.w   Text_RenderLine
                move.b  #$17,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,(word_FF80C2).w
                move.w  #$34,(word_FF80C6).w            ; '4'
                clr.l   (dword_FF80CE).w
                move.l  #$20000,(dword_FF80C8).w
                bclr    #0,(byte_FFA272).w
                jsr     (Results_StorePhaseSplitTime).l
                rts
; End of function Text_AdvancePhase
; Animates text movement with deceleration
Text_AnimateMovement:                                   ; DATA XREF: ROM:0000A9C6   o  ; was: sub_AB14
                subq.w  #1,(word_FF80C6).w
                bpl.s   loc_AB20
                clr.w   (word_FF80C2).w
                rts
; ---------------------------------------------------------------------------
loc_AB20:                                               ; CODE XREF: Text_AnimateMovement+4   j
                move.l  (dword_FF80C8).w,d0
                add.l   d0,(dword_FF80CE).w
                subi.l  #$2000,d0
                movem.l d0,-(sp)
                movea.l #dword_B446,a0
                clr.l   (dword_FF80C8).w
                bsr.w   Text_PrepareRenderParams
                movem.l (sp)+,d0
                move.l  d0,(dword_FF80C8).w
                rts
; End of function Text_AnimateMovement
; Advances state and initializes text display
Text_StartDisplaySequence:                              ; DATA XREF: ROM:0000A9A6   o  ; was: sub_AB4A
                                        ; ROM:0000A9B4   o
                addq.w  #2,(word_FF80C2).w
                bset    #7,(byte_FFFF31).w
                bsr.w   Gfx_LoadVDPTileData
; End of function Text_StartDisplaySequence
; Reads script command and branches to handler
Text_ParseScriptCommand:                                ; DATA XREF: ROM:0000A9A8   o  ; was: sub_AB58
                                        ; ROM:0000A9B6   o
                movea.l (dword_FF80C8).w,a0
                move.w  (a0),d0
                cmpi.w  #$FFFE,d0
                beq.w   Gfx_LoadCompressedTilemap
                cmpi.w  #$FFFF,d0
                bne.w   Text_SetupCharacterDisplay
                addq.w  #8,(word_FF80C2).w
                move.w  #$40,(dword_FF80CE).w           ; '@'
                rts
; End of function Text_ParseScriptCommand
; Parses text parameters position palette and character
Text_SetupCharacterDisplay:                             ; CODE XREF: Text_ParseScriptCommand+12   j  ; was: sub_AB7A
                addq.w  #2,(word_FF80C2).w
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
                beq.s   loc_ABC4
                addi.w  #$2000,d2
loc_ABC4:                                               ; CODE XREF: Text_SetupCharacterDisplay+44   j
                tst.w   d3
                bpl.s   loc_ABCC
                addi.w  #$4000,d2
loc_ABCC:                                               ; CODE XREF: Text_SetupCharacterDisplay+4C   j
                add.w   d2,(word_FF80D2).w
; End of function Text_SetupCharacterDisplay
; Empty text display state handler
Text_EmptyDisplayState:                                 ; DATA XREF: ROM:off_A9A2   o  ; was: nullsub_22
                                        ; ROM:0000A9EE   o
                rts
; End of function Text_EmptyDisplayState
; Queues two DMA transfers to VRAM nametable
Gfx_QueueTwoNameTableDMAs:
                movea.w (word_FFF70C).w,a1              ; was: sub_ABD2
                move.w  #$5290,d0
                bsr.s   Gfx_QueueNameTableDMA
                move.w  #$5310,d0
                bsr.s   Gfx_QueueNameTableDMA
                move.w  a1,(word_FFF70C).w
                rts
; End of function Gfx_QueueTwoNameTableDMAs
; Configures DMA transfer to VRAM nametable address
Gfx_QueueNameTableDMA:                                  ; CODE XREF: Gfx_QueueTwoNameTableDMAs+8   p  ; was: sub_ABE8
                                        ; Gfx_QueueTwoNameTableDMAs+E   p
                move.w  #$83,-(a1)
                move.w  d0,-(a1)
                move.l  #$180000,d0
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
; End of function Gfx_QueueNameTableDMA
; Loads tile data to VDP using three VRAM addresses
Gfx_LoadVDPTileData:                                    ; CODE XREF: Text_StartDisplaySequence+A   p  ; was: sub_AC20
                                        ; Gfx_FlushTextBuffer+10   p
                movea.w (word_FFF70C).w,a1
                move.w  #$5080,d0
                bsr.s   Gfx_WriteVDPDMACommand
                move.w  #$5100,d0
                bsr.s   Gfx_WriteVDPDMACommand
                move.w  #$5180,d0
                bsr.s   Gfx_WriteVDPDMACommand
                move.w  a1,(word_FFF70C).w
                rts
; End of function Gfx_LoadVDPTileData
; Writes VDP DMA command with address calculation
Gfx_WriteVDPDMACommand:                                 ; CODE XREF: Gfx_LoadVDPTileData+8   p  ; was: sub_AC3C
                                        ; Gfx_LoadVDPTileData+E   p
                move.w  #$83,-(a1)
                move.w  d0,-(a1)
                move.l  #$180000,d0
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
; End of function Gfx_WriteVDPDMACommand
; Renders single text character with transparency
Gfx_RenderTextCharacter:                                ; DATA XREF: ROM:0000A9AA   o  ; was: sub_AC74
                                        ; ROM:0000A9B8   o
                movea.l (dword_FF80CE).w,a0
                moveq   #0,d0
                move.b  (a0),d0
                cmpi.b  #$FF,d0
                bne.s   loc_AC88
                addq.w  #2,(word_FF80C2).w
                rts
; ---------------------------------------------------------------------------
loc_AC88:                                               ; CODE XREF: Gfx_RenderTextCharacter+C   j
                asl.w   #6,d0
                addi.l  #tiles_font,d0
                movea.l d0,a0
                movea.w #(byte_FFA300-M68K_RAM),a1
                moveq   #$F,d7
loc_AC98:                                               ; CODE XREF: Gfx_RenderTextCharacter+90   j
                move.l  (a0)+,d2
                move.l  d2,(dword_FF8040).w
                move.l  d2,(dword_FF8044).w
                andi.b  #$F0,(dword_FF8040).w
                bne.s   loc_ACAE
                bset    #$1C,d2
loc_ACAE:                                               ; CODE XREF: Gfx_RenderTextCharacter+34   j
                andi.b  #$F,(dword_FF8044).w
                bne.s   loc_ACBA
                bset    #$18,d2
loc_ACBA:                                               ; CODE XREF: Gfx_RenderTextCharacter+40   j
                andi.b  #$F0,(dword_FF8040+1).w
                bne.s   loc_ACC6
                bset    #$14,d2
loc_ACC6:                                               ; CODE XREF: Gfx_RenderTextCharacter+4C   j
                andi.b  #$F,(dword_FF8044+1).w
                bne.s   loc_ACD2
                bset    #$10,d2
loc_ACD2:                                               ; CODE XREF: Gfx_RenderTextCharacter+58   j
                andi.b  #$F0,(dword_FF8040+2).w
                bne.s   loc_ACDE
                bset    #$C,d2
loc_ACDE:                                               ; CODE XREF: Gfx_RenderTextCharacter+64   j
                andi.b  #$F,(dword_FF8044+2).w
                bne.s   loc_ACEA
                bset    #8,d2
loc_ACEA:                                               ; CODE XREF: Gfx_RenderTextCharacter+70   j
                andi.b  #$F0,(dword_FF8040+3).w
                bne.s   loc_ACF6
                bset    #4,d2
loc_ACF6:                                               ; CODE XREF: Gfx_RenderTextCharacter+7C   j
                andi.b  #$F,(dword_FF8044+3).w
                bne.s   loc_AD02
                bset    #0,d2
loc_AD02:                                               ; CODE XREF: Gfx_RenderTextCharacter+88   j
                move.l  d2,(a1)+
                dbf     d7,loc_AC98
                movea.w (word_FFF70C).w,a5
                move.w  #$83,-(a5)
                move.w  (word_FF80C4).w,-(a5)
                move.w  #$9580,-(a5)
                move.w  #$96D1,-(a5)
                move.l  #$8F02977F,-(a5)
                move.l  #$94009320,-(a5)
                movea.w (word_FFF70E).w,a0
                move.w  (word_FF80D2).w,d0
                move.w  d0,(a0)+
                addq.w  #1,d0
                move.w  d0,(a0)+
                move.w  #$83,-(a5)
                move.w  (word_FF80CC).w,-(a5)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a5)
                move.b  #$95,-(a5)
                move.b  d1,-(a5)
                move.b  #$96,-(a5)
                move.l  #$8F80977F,-(a5)
                move.l  #$94009302,-(a5)
                move.w  a5,(word_FFF70C).w
                addq.w  #4,(word_FFF70E).w
                addi.w  #$40,(word_FF80C4).w            ; '@'
                addq.l  #1,(dword_FF80CE).w
                addq.w  #2,(word_FF80CC).w
                addq.w  #2,(word_FF80D2).w
                subq.w  #1,(word_FF80C6).w
                move.b  (dword_FF80CE+3).w,d0
                andi.b  #3,d0
                bne.s   locret_AD94
                move.b  #$AD,d0
                jsr     (Sound_PlaySFX).l
locret_AD94:                                            ; CODE XREF: Gfx_RenderTextCharacter+114   j
                rts
; End of function Gfx_RenderTextCharacter
; Completes text rendering and clears VDP buffer
Gfx_FlushTextBuffer:                                    ; DATA XREF: ROM:0000A9AC   o  ; was: sub_AD96
                                        ; ROM:0000A9BA   o
                tst.b   (byte_FF8310).w
                bne.s   loc_ADA2
                subq.w  #1,(word_FF80C6).w
                bpl.s   locret_ADAA
loc_ADA2:                                               ; CODE XREF: Gfx_FlushTextBuffer+4   j
                subq.w  #4,(word_FF80C2).w
                bsr.w   Gfx_LoadVDPTileData
locret_ADAA:                                            ; CODE XREF: Gfx_FlushTextBuffer+A   j
                rts
; End of function Gfx_FlushTextBuffer
; Loads compressed tilemap data with address masking
Gfx_LoadCompressedTilemap:                              ; CODE XREF: Text_ParseScriptCommand+A   j  ; was: sub_ADAC
                addq.w  #6,(word_FF80C2).w
                clr.w   (word_FF80C6).w
                addq.l  #6,(dword_FF80C8).w
                movea.l (dword_FF80C8).w,a0
                move.l  -4(a0),d0
                andi.l  #$3FFFFF,d0
                move.w  -4(a0),d1
                andi.w  #$E000,d1
                move.w  d1,(word_FF80D4).w
                movea.w (word_FFF70C).w,a5
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
                move.w  a5,(word_FFF70C).w
                rts
; End of function Gfx_LoadCompressedTilemap
; Renders multi-tile text glyph with palette priority
Gfx_RenderTextGlyph:                                    ; DATA XREF: ROM:0000A9AE   o  ; was: sub_AE0E
                                        ; ROM:0000A9BC   o
                move.w  (word_FF80C6).w,d0
                move.w  d0,d3
                addq.w  #2,(word_FF80C6).w
                cmpi.w  #8,(word_FF80C6).w
                bmi.s   loc_AE24
                subq.w  #6,(word_FF80C2).w
loc_AE24:                                               ; CODE XREF: Gfx_RenderTextGlyph+10   j
                move.w  (word_FF80D4).w,d2
                bclr    #$F,d2
                beq.s   loc_AE30
                addq.w  #8,d0
loc_AE30:                                               ; CODE XREF: Gfx_RenderTextGlyph+1E   j
                movea.w (word_FFF70E).w,a1
                move.w  word_AE8A(pc,d0.w),d1
                add.w   d2,d1
                move.w  d1,(a1)+
                addq.w  #1,d1
                move.w  d1,(a1)+
                addq.w  #1,d1
                move.w  d1,(a1)+
                addq.w  #1,d1
                move.w  d1,(a1)+
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                move.w  word_AE82(pc,d3.w),-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F80977F,-(a1)
                move.l  #$94009304,-(a1)
                move.w  a1,(word_FFF70C).w
                addq.w  #8,(word_FFF70E).w
                rts
; End of function Gfx_RenderTextGlyph
; ---------------------------------------------------------------------------
word_AE82:      dc.w    $5004, $5006, $5008, $500A
word_AE8A:      dc.w    $6F0, $6F4, $6F8, $6FC, $6F0, $6F4, $EF4, $EF0

; Initializes player object with default values
