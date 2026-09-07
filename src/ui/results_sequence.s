Player_Initialize:                               ; DATA XREF: ROM:0000A9F2   o  ; was: sub_AE9A
                addq.w  #2,(word_FF80C2).w
                jsr (Enemy_UpdateBehavior).l
                bclr    #0,(byte_FFA272).w
                move.l  #word_B534,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
; Displays stage title text with character animation
Text_DisplayStageTitle:                               ; DATA XREF: ROM:0000A9F4   o  ; was: loc_AEB8
                bsr.w Text_DisplayCharacter
                cmpi.w  #$52,(word_FF80C2).w ; 'R'
                beq.s   locret_AEE2
                move.w  #$EC,(word_FF80C6).w
                move.w  #$80,(word_FF80D4).w
                move.w  #$E0,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #2,(byte_FF8143).w
locret_AEE2:                            ; CODE XREF: Player_Initialize+28   j
                rts
; End of function Player_Initialize
; Displays score counter with animation
UI_DisplayScoreAnimation:                               ; DATA XREF: ROM:0000A9F6   o  ; was: sub_AEE4
                addq.w  #1,(word_FF80C6).w
                cmpi.w  #$FC,(word_FF80C6).w
                bmi.s   loc_AEF6
                move.w  #$FC,(word_FF80C6).w
loc_AEF6:                               ; CODE XREF: UI_DisplayScoreAnimation+A   j
                cmpi.w  #$40,(word_FF80D4).w ; '@'
                bne.s   loc_AF0E
                move.b  (dword_FF80C8).w,d0
                beq.s   loc_AF0E
                clr.b   (dword_FF80C8).w
                jsr (Sound_PlaySFX).l
loc_AF0E:                               ; CODE XREF: UI_DisplayScoreAnimation+18   j
                                        ; UI_DisplayScoreAnimation+1E   j
                subq.w  #1,(word_FF80D4).w
                bpl.s   loc_AF18
                clr.w   (word_FF80C2).w
loc_AF18:                               ; CODE XREF: UI_DisplayScoreAnimation+2E   j
                lea     word_B37A(pc),a0
                nop
                bsr.w Gfx_LoadTileIndices
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
; Renders score digits as sprites in results screen
UI_RenderScoreDigits:                               ; CODE XREF: UI_DisplayScoreAnimation+74   j  ; was: loc_AF4C
                move.w  d0,(a0)
                move.w  d1,6(a0)
                addi.w  #$C,d1
                addq.w  #8,a0
                dbf d7,UI_RenderScoreDigits
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
                jmp (Sprite_AddToOAMBuffer).l
; End of function UI_DisplayScoreAnimation
; Initializes grade text display with position and sound
Text_InitGradeDisplay:                               ; DATA XREF: ROM:0000A9F8   o  ; was: sub_AF82
                addq.w  #2,(word_FF80C2).w
                move.l  #word_B56A,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
; Displays grade text (S/A/B/C) with position and sound
Text_DisplayGradeText:                               ; DATA XREF: ROM:0000A9FA   o  ; was: loc_AF94
                bsr.w Text_DisplayCharacter
                cmpi.w  #$58,(word_FF80C2).w ; 'X'
                beq.s   locret_AFB6
                move.w  #$F0,(word_FF80C6).w
                move.w  #$100,(word_FF80D4).w
                move.b  #$D2,d0
                jsr (Sound_PlaySFX).l
locret_AFB6:                            ; CODE XREF: Text_InitGradeDisplay+1C   j
                                        ; Text_AnimateGradeFlash+22   j
                rts
; End of function Text_InitGradeDisplay
; Animates flashing grade text with sprite rendering
Text_AnimateGradeFlash:                               ; DATA XREF: ROM:0000A9FC   o  ; was: sub_AFB8
                cmpi.w  #$5C,(word_FF80D4).w ; '\'
                bne.s   loc_AFCA
                move.b  #$15,d0
                jsr (Sound_PlaySFX).l
loc_AFCA:                               ; CODE XREF: Text_AnimateGradeFlash+6   j
                subq.w  #1,(word_FF80D4).w
                bpl.s   loc_AFD4
                clr.w   (word_FF80C2).w
loc_AFD4:                               ; CODE XREF: Text_AnimateGradeFlash+16   j
                btst    #4,(word_FF80D4+1).w
                bne.s   locret_AFB6
                lea     word_B382(pc),a0
                nop
                bsr.w Gfx_LoadTileIndices
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  #$EC,d0
                move.w  (word_FF80C6).w,d1
                moveq   #8,d7
; Renders grade letter sprites with horizontal spacing
UI_RenderGradeSprites:                               ; CODE XREF: Text_AnimateGradeFlash+48   j  ; was: loc_AFF4
                move.w  d0,(a0)
                move.w  d1,6(a0)
                addi.w  #$C,d1
                addq.w  #8,a0
                dbf d7,UI_RenderGradeSprites
                lea     (dword_FFA100).w,a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function Text_AnimateGradeFlash
; Initializes pause timer before text exit
Text_InitPauseTimer:                               ; DATA XREF: ROM:0000A9FE   o  ; was: sub_B00E
                addq.w  #2,(word_FF80C2).w
                move.w  #$50,(dword_FF80CE).w ; 'P'
; Decrements pause timer each frame before text transition
Text_PauseTimer_CountdownLoop:                               ; DATA XREF: ROM:0000AA00   o  ; was: loc_B018
                subq.w  #1,(dword_FF80CE).w
                bpl.s   locret_B024
                move.w  #$2E,(word_FF80C2).w ; '.'
locret_B024:                            ; CODE XREF: Text_InitPauseTimer+E   j
                rts
; End of function Text_InitPauseTimer
; Initializes victory text display sequence
Text_InitVictoryMessage:                               ; DATA XREF: ROM:0000A9D0   o  ; was: sub_B026
                addq.w  #2,(word_FF80C2).w
                move.l  #word_B552,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
                rts
; End of function Text_InitVictoryMessage
; Starts weapon acquired animation sequence
Text_StartWeaponAcquired:                               ; DATA XREF: ROM:0000A9D2   o  ; was: sub_B03A
                bsr.w Text_DisplayCharacter
                cmpi.w  #$30,(word_FF80C2).w ; '0'
                beq.s   locret_B086
                move.w  #$E0,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #2,(byte_FF8143).w
                move.w  #$80,(word_FF80C6).w
                move.w  #$40,(dword_FF80CE).w ; '@'
                move.w  #$E8,(word_FF80CC).w
                move.w  #$200,(word_FF80D4).w
                move.w  #$108,(word_FF80C4).w
                move.w  #$200,(word_FF80D6).w
                move.b  #$BE,d0
                jsr (Sound_PlaySFX).l
locret_B086:                            ; CODE XREF: Text_StartWeaponAcquired+A   j
                rts
; End of function Text_StartWeaponAcquired
; Animates rotating text with fade effect
Text_AnimateRotationFade:                               ; DATA XREF: ROM:0000A9D4   o  ; was: sub_B088
                bsr.w Text_RenderRotatingSprites
                move.w  (word_FF80C6).w,d0
                addq.w  #8,d0
                andi.w  #$1FE,d0
                move.w  d0,(word_FF80C6).w
                subq.w  #4,(dword_FF80CE).w
                bpl.s   locret_B0B4
                cmpi.w  #4,(dword_FF80CE).w
                bpl.s   locret_B0B4
                addq.w  #2,(word_FF80C2).w
                clr.w   (word_FF80C6).w
                clr.w   (dword_FF80CE).w
locret_B0B4:                            ; CODE XREF: Text_AnimateRotationFade+16   j
                                        ; Text_AnimateRotationFade+1E   j
                rts
; End of function Text_AnimateRotationFade
; Animates rotation stopping sequence
Text_AnimateRotationStop:                               ; DATA XREF: ROM:0000A9D6   o  ; was: sub_B0B6
                bsr.w Text_RenderRotatingSprites
                subq.w  #1,(dword_FF80CE).w
                cmpi.w  #$FFF4,(dword_FF80CE).w
                bne.s   locret_B0D6
                addq.w  #2,(word_FF80C2).w
                move.w  #$FFF4,(dword_FF80CE).w
                move.w  #$20,(dword_FF80C8).w ; ' '
locret_B0D6:                            ; CODE XREF: Text_AnimateRotationStop+E   j
                rts
; End of function Text_AnimateRotationStop
; Completes animation and plays appropriate sound
Text_CompleteWithSound:                               ; DATA XREF: ROM:0000A9D8   o  ; was: sub_B0D8
                bsr.w Text_RenderRotatingSprites
                subq.w  #1,(dword_FF80C8).w
                bpl.s   locret_B134
                tst.b   (byte_FF80FA).w
                beq.s   loc_B0F4
                move.b  #$83,d0
                jsr (Sys_WaitVBlank).l
                bra.s   loc_B0FE
; ---------------------------------------------------------------------------
loc_B0F4:                               ; CODE XREF: Text_CompleteWithSound+E   j
                move.b  #$C4,d0
                jsr (Sound_PlaySFX).l
loc_B0FE:                               ; CODE XREF: Text_CompleteWithSound+1A   j
                jsr (UI_StoreWeaponToBuffer).l
                tst.w   (word_FFA270).w
                beq.s   loc_B122
                addq.w  #2,(word_FF80C2).w
                move.w  #$F0,(word_FF80D4).w
                move.w  (word_FFA270).w,(word_FF822C).w
                andi.w  #$FFF0,(word_FF822C).w
                rts
; ---------------------------------------------------------------------------
loc_B122:                               ; CODE XREF: Text_CompleteWithSound+30   j
                move.w  #$46,(word_FF80C2).w ; 'F'
                move.w  #$F0,(word_FF80D4).w
                move.w  #$11A,(word_FF80C4).w
locret_B134:                            ; CODE XREF: Text_CompleteWithSound+8   j
                rts
; End of function Text_CompleteWithSound
; Animates text rising upward
Text_AnimateRiseUp:                               ; DATA XREF: ROM:0000A9DA   o  ; was: sub_B136
                bsr.w Text_RenderVerticalText
                subq.w  #1,(word_FF80CC).w
                addq.w  #1,(word_FF80D4).w
                cmpi.w  #$E0,(word_FF80CC).w
                bne.s   locret_B154
                addq.w  #2,(word_FF80C2).w
                move.w  #4,(dword_FF80C8).w
locret_B154:                            ; CODE XREF: Text_AnimateRiseUp+12   j
                rts
; End of function Text_AnimateRiseUp
; Pauses before final exit animation
Text_PauseBeforeExit:                               ; DATA XREF: ROM:0000A9DC   o  ; was: sub_B156
                bsr.w Text_RenderVerticalText
                subq.w  #1,(dword_FF80C8).w
                bpl.s   locret_B16A
                addq.w  #2,(word_FF80C2).w
                move.w  #$114,(word_FF80D6).w
locret_B16A:                            ; CODE XREF: Text_PauseBeforeExit+8   j
                rts
; End of function Text_PauseBeforeExit
; Animates text exiting upward
Text_AnimateExitUp:                               ; DATA XREF: ROM:0000A9DE   o  ; was: sub_B16C
                bsr.w Text_RenderVerticalText
                subq.w  #2,(word_FF80C4).w
                addq.w  #2,(word_FF80D6).w
                cmpi.w  #$EC,(word_FF80C4).w
                bne.s   locret_B18A
                addq.w  #4,(word_FF80C2).w
                move.w  #$40,(dword_FF80C8).w ; '@'
locret_B18A:                            ; CODE XREF: Text_AnimateExitUp+12   j
                rts
; End of function Text_AnimateExitUp
; Finalizes animation and saves weapon score
Text_FinalizeAndSaveScore:                               ; DATA XREF: ROM:0000A9E0   o  ; was: sub_B18C
                                        ; ROM:0000A9E2   o
                bsr.w Text_RenderVerticalText
                subq.w  #1,(dword_FF80C8).w
                bpl.s   locret_B1A6
                clr.w   (word_FF80C2).w
                moveq   #0,d0
                move.w  (word_FFA270).w,d0
                jsr (UI_AddScoreBCD).l
locret_B1A6:                            ; CODE XREF: Text_FinalizeAndSaveScore+8   j
                rts
; End of function Text_FinalizeAndSaveScore
; Fades in ship name display during cutscene
Cutscene_FadeInShipNameAlt:                               ; DATA XREF: ROM:0000A9E4   o  ; was: sub_B1A8
                                        ; ROM:0000A9E6   o ...
                bsr.w Gfx_RenderRotatedSprites
                addq.w  #1,(word_FF80D4).w
                cmpi.w  #$FC,(word_FF80D4).w
                bne.s   locret_B1C2
                addq.w  #2,(word_FF80C2).w
                move.w  #$80,(dword_FF80C8).w
locret_B1C2:                            ; CODE XREF: Cutscene_FadeInShipNameAlt+E   j
                rts
; End of function Cutscene_FadeInShipNameAlt
; Fades out ship name display during cutscene
Cutscene_FadeOutShipNameAlt:                               ; DATA XREF: ROM:0000A9EA   o  ; was: sub_B1C4
                bsr.w Gfx_RenderRotatedSprites
                subq.w  #1,(dword_FF80C8).w
                bpl.s   locret_B1D2
                clr.w   (word_FF80C2).w
locret_B1D2:                            ; CODE XREF: Cutscene_FadeOutShipNameAlt+8   j
                rts
; End of function Cutscene_FadeOutShipNameAlt
; Waits for frame timer countdown before clearing state
Cutscene_WaitFrameTimer:                               ; DATA XREF: ROM:0000A9EC   o  ; was: sub_B1D4
                subq.w  #1,(word_FF80C4).w
                bpl.s   locret_B1DE
                clr.w   (word_FF80C2).w
locret_B1DE:                            ; CODE XREF: Cutscene_WaitFrameTimer+4   j
                rts
; End of function Cutscene_WaitFrameTimer
; Renders text sprites with tile loading
Text_RenderRotatingSprites:                               ; CODE XREF: Text_AnimateRotationFade   p  ; was: sub_B1E0
                                        ; sub_B0B6   p ...
                lea     word_B354(pc),a0
                nop
                bsr.w Gfx_LoadTileIndices
                bsr.w Text_PositionVerticalSprites
                lea     (dword_FFA100).w,a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function Text_RenderRotatingSprites
; Renders vertical text sprites with positioning
Text_RenderVerticalText:                               ; CODE XREF: Text_AnimateRiseUp   p  ; was: sub_B1F8
                                        ; sub_B156   p ...
                lea     word_B354(pc),a0
                nop
                bsr.w Gfx_LoadTileIndices
                bsr.w Text_ApplyDigitOffsets
                bsr.w Text_PositionVerticalSprites
                lea     (dword_FFA100).w,a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function Text_RenderVerticalText
; Renders rotated sprites with tile indices and OAM
Gfx_RenderRotatedSprites:                               ; CODE XREF: Cutscene_FadeInShipNameAlt   p  ; was: sub_B214
                                        ; sub_B1C4   p
                lea     word_B368(pc),a0
                nop
                bsr.w Gfx_LoadTileIndices
                bsr.w Gfx_PositionRotatedText
                lea     (dword_FFA100).w,a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function Gfx_RenderRotatedSprites
; Positions vertical text sprite column
Text_PositionVerticalSprites:                               ; CODE XREF: Text_RenderRotatingSprites+A   p  ; was: sub_B22C
                                        ; Text_RenderVerticalText+E   p
                bsr.w Text_CalculateRotationCoords
                move.w  (word_FF80D6).w,d1
                moveq   #3,d7
loc_B236:                               ; CODE XREF: Text_PositionVerticalSprites+18   j
                move.w  (word_FF80D4).w,(a0)
                move.w  d1,(a1)
                addq.w  #8,a0
                addq.w  #8,a1
                addi.w  #$C,d1
                dbf     d7,loc_B236
                rts
; End of function Text_PositionVerticalSprites
; Positions rotated text sprites with coordinates
Gfx_PositionRotatedText:                               ; CODE XREF: Gfx_RenderRotatedSprites+A   p  ; was: sub_B24A
                bsr.w Text_CalculateRotationCoords
                subi.w  #$60,d1 ; '`'
                moveq   #1,d7
loc_B254:                               ; CODE XREF: Gfx_PositionRotatedText+18   j
                move.w  (word_FF80D4).w,(a0)
                move.w  d1,(a1)
                addq.w  #8,a0
                addq.w  #8,a1
                addi.w  #$C,d1
                dbf     d7,loc_B254
                rts
; End of function Gfx_PositionRotatedText
; Calculates coordinates for rotating text effect
Text_CalculateRotationCoords:                               ; CODE XREF: Text_PositionVerticalSprites   p  ; was: sub_B268
                                        ; sub_B24A   p
                movea.w #(byte_FFA120-M68K_RAM),a0
                movea.w #(byte_FFA126-M68K_RAM),a1
                movea.w #(byte_FFA128-M68K_RAM),a2
                movea.w #(byte_FFA12E-M68K_RAM),a3
                movea.l #word_1B514,a4
                move.w  (word_FF80C6).w,d0
                move.w  (dword_FF80CE).w,d1
                move.w  d1,d4
                move.w  (word_FF80CC).w,d6
                moveq   #4,d7
loc_B28E:                               ; CODE XREF: Text_CalculateRotationCoords+5C   j
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
                dbf     d7,loc_B28E
                movea.w #(byte_FFA150-M68K_RAM),a0
                movea.w #(byte_FFA156-M68K_RAM),a1
                move.w  (word_FF80C4).w,d1
                moveq   #4,d7
loc_B2D6:                               ; CODE XREF: Text_CalculateRotationCoords+7C   j
                move.w  (word_FF80D4).w,(a0)
                move.w  d1,(a1)
                addq.w  #8,a0
                addq.w  #8,a1
                addi.w  #$C,d1
                dbf     d7,loc_B2D6
                rts
; End of function Text_CalculateRotationCoords
; Applies position offsets from two-digit value
Text_ApplyDigitOffsets:                               ; CODE XREF: Text_RenderVerticalText+A   p  ; was: sub_B2EA
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
; End of function Text_ApplyDigitOffsets
; Loads tile indices from data table
Gfx_LoadTileIndices:                               ; CODE XREF: UI_DisplayScoreAnimation+3A   p  ; was: sub_B326
                                        ; Text_AnimateGradeFlash+2A   p ...
                movea.w #(byte_FFA104-M68K_RAM),a1
                move.w  #$100,d1
loc_B32E:                               ; CODE XREF: Gfx_LoadTileIndices+24   j
                moveq   #0,d0
                move.b  (a0)+,d0
                bmi.s Gfx_TerminateSpriteList
                addi.w  #-$1960,d0
                bclr    #0,d0
                bne.s   loc_B342
                subi.w  #$2000,d0
loc_B342:                               ; CODE XREF: Gfx_LoadTileIndices+16   j
                move.w  d0,(a1)
                move.w  d1,-2(a1)
                addq.w  #8,a1
                bra.s   loc_B32E
; ---------------------------------------------------------------------------
; Writes terminator marker to end of sprite list in VRAM queue
Gfx_TerminateSpriteList:                               ; CODE XREF: Gfx_LoadTileIndices+C   j  ; was: loc_B34C
                move.w  #$FFFF,-4(a1)
                rts
; End of function Gfx_LoadTileIndices
; ---------------------------------------------------------------------------
word_B354:      dc.w $1416, $181A, $1C1E, $201C, $1822, $2426, $282A, $1400, 0, $FF
                                        ; DATA XREF: Text_RenderRotatingSprites   o
                                        ; sub_B1F8   o
word_B368:      dc.w $1416, $181A, $1C1E, $201C, $1822, $2426, $282A, $1428, $26FF
                                        ; DATA XREF: Gfx_RenderRotatedSprites   o
word_B37A:      dc.w $1416, $181A, $1C00, $FF
                                        ; DATA XREF: UI_DisplayScoreAnimation:loc_AF18   o
word_B382:      dc.w 2, 4, $600, $80A, $CFF
                                        ; DATA XREF: Text_AnimateGradeFlash+24   o


; Loads font tile and queues DMA transfer
Text_DisplayCharacter:                               ; CODE XREF: Text_BeginVictorySequence   p  ; was: sub_B38C
                                        ; sub_AE9A:loc_AEB8   p ...
                movea.l (dword_FF80CE).w,a0
                moveq   #0,d0
                move.b  (a0)+,d0
                cmpi.b  #$FF,d0
                bne.s   loc_B3A0
                addq.w  #2,(word_FF80C2).w
                rts
; ---------------------------------------------------------------------------
loc_B3A0:                               ; CODE XREF: Text_DisplayCharacter+C   j
                move.l  a0,(dword_FF80CE).w
                asl.w   #6,d0
                addi.l  #tiles_font,d0
                movea.l d0,a0
                movea.w #(byte_FFA300-M68K_RAM),a1
                moveq   #$F,d7
loc_B3B4:                               ; CODE XREF: Text_DisplayCharacter+2A   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_B3B4
                movea.w (word_FFF70C).w,a5
                move.w  #$83,-(a5)
                move.w  (word_FF80C4).w,-(a5)
                move.w  #$9580,-(a5)
                move.w  #$96D1,-(a5)
                move.l  #$8F02977F,-(a5)
                move.l  #$94009320,-(a5)
                move.w  a5,(word_FFF70C).w
                addi.w  #$40,(word_FF80C4).w ; '@'
                rts
; End of function Text_DisplayCharacter
; Prepares position parameters for text rendering
Text_PrepareRenderParams:                               ; CODE XREF: Text_AnimateMovement+28   p  ; was: sub_B3E6
                move.w  (dword_FF80C8).w,d5
                move.w  (dword_FF80CE).w,d6
                bra.s   loc_B3FC
; End of function Text_PrepareRenderParams
; Renders text line with sprite buffer and OAM update
Text_RenderLine:                               ; CODE XREF: Text_UpdateAnimation+6   p  ; was: sub_B3F0
                                        ; Text_AdvancePhase+6   p
                btst    #3,(word_FFA000+1).w
                bne.s   locret_B408
                moveq   #0,d5
                moveq   #0,d6
loc_B3FC:                               ; CODE XREF: Text_PrepareRenderParams+8   j
                bsr.s Sprite_RenderTextLine
                lea     (dword_FFA100).w,a0
                jsr (Sprite_AddToOAMBuffer).l
locret_B408:                            ; CODE XREF: Text_RenderLine+6   j
                rts
; End of function Text_RenderLine
; Renders line of sprites for text display
Sprite_RenderTextLine:                               ; CODE XREF: Text_RenderLine:loc_B3FC   p  ; was: sub_B40A
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
; Renders text line character-by-character as sprites in loop
Sprite_RenderTextLoop:                               ; CODE XREF: Sprite_RenderTextLine+2A   j  ; was: loc_B428
                move.w  d2,(a1)+
                move.w  d4,(a1)+
                move.w  d0,(a1)+
                move.w  d1,(a1)+
                addq.w  #2,d0
                add.w   d3,d1
                dbf d7,Sprite_RenderTextLoop
                move.w  #$FFFF,(a1)
                rts
; End of function Sprite_RenderTextLine
; ---------------------------------------------------------------------------
dword_B43E:     dc.l $C6A0010A          ; DATA XREF: Text_UpdateAnimation   o
                                        ; sub_AADC   o
                dc.l $680B0004
dword_B446:     dc.l $C6AA00FF          ; DATA XREF: Text_AnimateMovement+1E   o
                dc.l $680B0006


; Checks conditions for victory message display
UI_CheckVictoryCondition:                               ; CODE XREF: Boss_DestroyerProtoIntroMove+28   p  ; was: sub_B44E
                                        ; Boss_JetsripperFlyIn+1E   p ...
                bclr    #1,(byte_FFA209).w
                bne.s   loc_B464
                bclr    #0,(byte_FF80A8).w
                cmpi.w  #4,(word_FFFF2A).w
                bmi.s   loc_B480
loc_B464:                               ; CODE XREF: UI_CheckVictoryCondition+6   j
                move.w  #$1E,(word_FF80C2).w
                move.l  #word_B544,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
                move.b  #4,(word_FFF7F4+1).w
                rts
; ---------------------------------------------------------------------------
loc_B480:                               ; CODE XREF: UI_CheckVictoryCondition+14   j
                asl.w   #3,d0
                cmpi.w  #2,(word_FFFF2A).w
                bne.s   loc_B48E
                addi.w  #4,d0
loc_B48E:                               ; CODE XREF: UI_CheckVictoryCondition+3A   j
                move.w  #$10,(word_FF80C2).w
                move.l  off_B49C(pc,d0.w),(dword_FF80C8).w
                rts
; End of function UI_CheckVictoryCondition
; ---------------------------------------------------------------------------
off_B49C:       dc.l byte_B710
                dc.l byte_B710
                dc.l byte_B6B6
                dc.l byte_B6B6
                dc.l byte_B64E
                dc.l byte_B64E
                dc.l byte_B572          ; text?
                dc.l byte_B572          ; text?
                dc.l byte_B5E2
                dc.l byte_B5E2
                dc.l byte_B868
                dc.l byte_B868
                dc.l byte_B776
                dc.l byte_B776
                dc.l byte_B7E8
                dc.l byte_B7E8
                dc.l byte_B8E8
                dc.l byte_B8E8


; Initializes ship name display based on difficulty
Cutscene_InitShipNameByDiff:                               ; CODE XREF: Cutscene_ShowShipName+4   p  ; was: sub_B4E4
                                        ; Cutscene_WaitShipPosition+10   p
                bset    #0,(byte_FF80A8).w
                asl.w   #3,d0
                cmpi.w  #2,(word_FFFF2A).w
                bne.s   loc_B4F8
                addi.w  #4,d0
loc_B4F8:                               ; CODE XREF: Cutscene_InitShipNameByDiff+E   j
                move.w  #2,(word_FF80C2).w
                move.l  word_B506(pc,d0.w),(dword_FF80C8).w
                rts
; End of function Cutscene_InitShipNameByDiff
; ---------------------------------------------------------------------------
word_B506:      dc.w 0, $B8E8, 0, $B8E8, 4, $FFFF, $D08A, $1D1E, $B11, $F02, 0
                dc.w $2113, $1811, $19, $1000, $1E12, $F00, $1619, $1D0B, $1811, $F16, $F1D
                dc.w $FF00
word_B534:      dc.w $102, $304, $506, $708, $90A, $1D1E, $B11, $FFF
                                        ; DATA XREF: Player_Initialize+10   o
word_B544:      dc.w $1C0F, $B0E, $2310, $1311, $121E, $2929, $29FF
                                        ; DATA XREF: Player_ProcessBehaviorTimer+C   o
                                        ; UI_CheckVictoryCondition+1C   o
word_B552:      dc.w $102, $304, $506, $708, $90A, $1D1E, $B11, $F0D
                                        ; DATA XREF: Text_InitVictoryMessage+4   o
                dc.w $161C, $C19, $181F, $FF00
word_B56A:      dc.w $F17, $1C11, $180D, $23FF
                                        ; DATA XREF: Text_InitGradeDisplay+4   o
byte_B572:      dc.b 0, 6, 0, $1E, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4B4   o
                                        ; ROM:0000B4B8   o
                dc.b $5A, $32, $39, $3E, $D8, $82, $80, $A3 ; text?
                dc.b $7F, $AB, $8D, $A4, $B2, $C5, $DA, $D9
                dc.b $4E, $40, $5B, $6D, $3F, $5A, $D9, $FF
                dc.b $D0, $90, $4E, $64, $49, $39, $48, $B2
                dc.b $CC, $C8, $92, $A3, $C8, $C0, $DA, $43
                dc.b 0, $42, $30, $5B, $3D, $47, $5D, $34
                dc.b $32, $D9, $FF, 0, $D0, $90, $9F, $8A
                dc.b $87, $A2, $5D, 0, $31, $79, $42, $37
                dc.b $56, $55, $63, $76, $47, $33, $35, $5A
                dc.b $D8, $83, $80, $D9, $FF, 0, $D0, $90
                dc.b $3A, $30, $D8, $35, $35, $79, $42, $36
                dc.b $58, $5D, $56, $DB, $89, $8A, $9E, $45
                dc.b $3B, $42, $58, $55, $65, $DB, $FF, 0
byte_B5E2:      dc.b 0, 6, 0, $1E, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4BC   o
                                        ; ROM:0000B4C0   o
                dc.b $32, $46, $79, $DB, 0, $86, $8C, $52
                dc.b $48, $51, $DB, 0, $93, $94, $58, $41
                dc.b $DB, $93, $94, $58, $41, $DB, $DB, $FF
                dc.b $D0, $90, $3D, $79, $3B, $76, $D8, $8A
                dc.b $CC, $A4, $8A, $C7, $DA, $AE, $AB, $45
                dc.b $42, $8D, $DA, $A6, $DA, $DB, $DB, $FF
                dc.b $D0, $90, $34, $32, $79, $D8, $83, $A5
                dc.b $49, $82, $80, $A3, $7F, $AB, $8D, $A4
                dc.b $B2, $C5, $DA, $DB, $DB, $FF, $D0, $90
                dc.b $81, $BA, $48, $B9, $86, $48, $70, $32
                dc.b $51, $DB, 0, $83, $A5, $48, $32, $61
                dc.b $36, $45, $41, $31, $42, $39, $56, $55
                dc.b $35, $DB, $FF, 0
byte_B64E:      dc.b 0, 6, 0, $16, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4AC   o
                                        ; ROM:0000B4B0   o
                dc.b $83, $A5, $48, $44, $49, $D8, $98, $94
                dc.b $CA, $BB, $80, $C0, $DA, $D9, $FF, 0
                dc.b $D0, $90, $3C, $4E, $44, $31, $D9, $85
                dc.b $89, $9D, $48, 0, $63, $5C, $3D, $31
                dc.b $49, $D8, $39, $39, $6A, 0, $34, $5B
                dc.b $55, $D9, $FF, 0, $D0, $90, $32, $55
                dc.b $3D, $33, $D9, $83, $A5, $49, 0, $83
                dc.b $80, $BF, $A5, $45, $44, $55, $4E, $6A
                dc.b 0, $31, $36, $42, $58, $55, $D9, $FF
                dc.b $D0, $90, $98, $84, $45, 0, $49, $31
                dc.b $55, $48, $49, $D8, $83, $9D, $82, $3A
                dc.b $5C, $48, $4D, $32, $3A, $D9, $FF, 0
byte_B6B6:      dc.b 0, 6, 0, $18, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4A4   o
                                        ; ROM:0000B4A8   o
                dc.b $34, $49, $5A, $32, $D9, $34, $48, $56
                dc.b $49, $D8, $93, $94, $A1, $97, $67, $DC
                dc.b $FF, 0, $D0, $90, $8B, $84, $A4, $BF
                dc.b $8B, $48, 0, $96, $9F, $A3, $E2, 0
                dc.b $B2, $C5, $9D, $3C, $55, $5C, $63, $76
                dc.b $44, $31, $D9, $FF, $D0, $90, $5A, $37
                dc.b $47, $3F, $35, $31, $D8, $BE, $80, $BC
                dc.b $CA, $DA, $DC, $DC, $FF, 0, $D0, $90
                dc.b $32, $5C, $6B, $32, $48, 0, $63, $35
                dc.b $5C, $67, $D9, $90, $85, $30, $32, $65
                dc.b $D9, $FF
byte_B710:      dc.b 0, 6, 0, $1C, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:off_B49C   o
                                        ; ROM:0000B4A0   o
                dc.b $87, $80, $88, $86, $DB, $87, $80, $88
                dc.b $86, $DB, $BD, $8D, $81, $9C, $81, $85
                dc.b $3D, $5A, $DB, $DB, $FF, 0, $D0, $90
                dc.b $AA, $A5, $AA, $A5, $49, $D8, $BD, $A3
                dc.b $C7, $86, $39, $32, $3B, $E2, 0, $3F
                dc.b $51, $53, $5B, $44, $31, $DB, $FF, 0
                dc.b $D0, $90, $58, $56, $55, $52, $48, $44
                dc.b $53, 0, $58, $79, $42, $4F, $57, $31
                dc.b $D8, $BB, $DA, $A6, $DA, $D9, $FF, 0
                dc.b $D0, $90, $80, $AB, $8E, $DA, $8C, $C2
                dc.b $8E, $DA, $D8, $8B, $8E, $AB, $BB, $80
                dc.b $3D, $5A, $DB, $DB, $FF, 0
byte_B776:      dc.b 0, 6, 0, $22, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4CC   o
                                        ; ROM:0000B4D0   o
                dc.b $5B, $3F, $3B, $49, 0, $86, $A2, $BD
                dc.b $BB, $DA, $BB, $DA, $43, $52, $32, $3B
                dc.b $4E, $3C, $D9, $6B, $66, $A9, $A6, $8A
                dc.b $86, $D9, $FF, 0, $D0, $90, $67, $31
                dc.b $63, $44, $92, $88, $A6, $E2, 0, $8F
                dc.b $C7, $85, $C8, $43, $31, $36, $4E, $3C
                dc.b $5A, $D9, $9A, $9A, $9A, $D8, $D8, $D8
                dc.b $FF, 0, $D0, $90, $58, $56, $55, $52
                dc.b $5C, $44, $53, 0, $58, $79, $42, $4F
                dc.b $57, $31, $D8, $BB, $DA, $A6, $DA, $D9
                dc.b $FF, 0, $D0, $90, $6B, $32, $6A, $52
                dc.b $31, $31, $38, $6B, 0, $32, $4E, $3E
                dc.b $32, $67, $44, $D8, $83, $9D, $82, $D9
                dc.b $FF, 0
byte_B7E8:      dc.b 0, 6, 0, $22, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4D4   o
                                        ; ROM:0000B4D8   o
                dc.b $61, $6E, $3A, $3F, $67, $44, $D9, $39
                dc.b $48, $7F, $89, $A4, $92, $8E, $80, $AC
                dc.b $DA, $48, $90, $A2, $E2, $5B, $3C, $56
                dc.b $3F, $35, $DC, $FF, $D0, $90, $50, $35
                dc.b $3B, $48, $5A, $3B, $4F, $67, $D8, $93
                dc.b $84, $9D, $45, $44, $56, $D9, $40, $36
                dc.b $77, $32, $49, $52, $32, $34, $5B, $54
                dc.b $67, $D9, $FF, 0, $D0, $90, $91, $A6
                dc.b $A3, $8B, $92, $48, $80, $95, $45, $44
                dc.b $54, $3A, $5D, $54, $58, $5D, $79, $3F
                dc.b $35, $DB, $DB, $7F, $89, $A4, $92, $DB
                dc.b $DB, $FF, $D0, $90, $82, $80, $A3, $7F
                dc.b $AB, $8D, $A4, $B2, $C5, $DA, $43, $3B
                dc.b $42, $48, $4D, $39, $54, $49, $6B, $39
                dc.b $4C, $58, $79, $3F, $DB, $DB, $FF, 0
byte_B868:      dc.b 0, 6, 0, $22, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4C4   o
                                        ; ROM:0000B4C8   o
                dc.b $61, $6E, $3A, $3F, $67, $44, $D9, $39
                dc.b $48, $7F, $89, $A4, $92, $8E, $80, $AC
                dc.b $DA, $48, $90, $A2, $E2, $5B, $3C, $56
                dc.b $3F, $35, $DC, $FF, $D0, $90, $50, $35
                dc.b $3B, $48, $5A, $3B, $4F, $67, $D8, $93
                dc.b $84, $9D, $45, $44, $56, $D9, $40, $36
                dc.b $77, $32, $49, $52, $32, $34, $5B, $54
                dc.b $67, $D9, $FF, 0, $D0, $90, $91, $A6
                dc.b $A3, $8B, $92, $48, $80, $95, $45, $44
                dc.b $54, $3A, $5D, $54, $58, $5D, $79, $3F
                dc.b $35, $DB, $DB, $7F, $89, $A4, $92, $DB
                dc.b $DB, $FF, $D0, $90, $82, $80, $A3, $7F
                dc.b $AB, $8D, $A4, $B2, $C5, $DA, $43, $3B
                dc.b $42, $48, $4D, $39, $54, $49, $6B, $39
                dc.b $4C, $58, $79, $3F, $DB, $DB, $FF, 0
byte_B8E8:      dc.b 0, 4, $FF, $FF, $D0, $90, $35, $79
                                        ; DATA XREF: ROM:0000B4DC   o
                                        ; ROM:0000B4E0   o
                dc.b $D8, $D8, $D8, 0, $35, $33, $6A, $40
                dc.b $76, $5C, $D8, $D8, $D8, $DC, $DC, $FF


; Loads multiple palettes from pointer table sequentially
