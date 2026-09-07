Boss_ZLeoMainController:                                ; CODE XREF: Stage_UpdateGameplay+6   p  ; was: sub_220D0
                tst.w   (dword_FF9400).w
                beq.w   loc_220E0
                bsr.w   Boss_ZLeoPaletteUpdate
                bsr.w   Boss_ZLeoPaletteEffect1
loc_220E0:                                              ; CODE XREF: Boss_ZLeoMainController+4   j
                move.w  (dword_FF9400).w,d0
                lea     off_220EC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ZLeoMainController
; ---------------------------------------------------------------------------
off_220EC:      dc.w    Boss_ZLeoIntroSequence-*        ; DATA XREF: Boss_ZLeoMainController+14   o
                dc.w    Boss_ZLeoIntroSequence_PaletteWait-*
                dc.w    Boss_ZLeoWaitCameraPosition-*
                dc.w    Boss_ZLeoWaitTimer-*
                dc.w    Boss_ZLeoCameraScroll-*
                dc.w    Credits_PaletteInit-*
                dc.w    Credits_ScrollUpdate1-*
                dc.w    Credits_ScrollUpdate2-*
                dc.w    Credits_ScrollUpdate3-*
                dc.w    Credits_ScrollUpdate4-*
                dc.w    Credits_ScrollUpdate5-*
                dc.w    Credits_UpdateGraphics1-*
                dc.w    Credits_UpdateGraphics2-*
                dc.w    Credits_UpdateGraphics3-*
                dc.w    Credits_UpdateGraphics4-*
                dc.w    Credits_LoadTiles-*
                dc.w    Credits_FadeOutPrepare-*
                dc.w    Credits_FadeOutWaitInput-*
                dc.w    nullsub_56-*

; Initializes Z-Leo boss intro with palette effects, camera setup and credits
Boss_ZLeoIntroSequence:                                 ; DATA XREF: ROM:off_220EC   o  ; was: sub_22112
                addq.w  #2,(dword_FF9400).w
                clr.w   (word_FFA45E).w
                lea     (Entity_ObjectPool).w,a0
                move.w  #$10,(a0)
                move.w  #$C00,2(a0)
                clr.w   $C(a0)
                move.w  #$40,$10(a0)                    ; '@'
                move.w  #$F0,$14(a0)
                move.w  #1,(dword_FF9410).w
                move.w  #$A0,(dword_FF9410+2).w
                move.w  #$F0,(dword_FF9414).w
                move.w  #$1F,(dword_FF9414+2).w
                move.w  #$7F,(dword_FF9418).w
                move.w  #7,(dword_FF941C).w
                bsr.w   Boss_ZLeoPaletteEffect2
                move.w  #$40,(dword_FF9400+2).w         ; '@'
; Wait for palette effect countdown during Z-Leo intro
Boss_ZLeoIntroSequence_PaletteWait:                     ; DATA XREF: ROM:000220EE   o  ; was: loc_22166
                bsr.w   Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_2217E
                move.w  #4,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
                bsr.w   Credits_UpdateTilemap
locret_2217E:                                           ; CODE XREF: Boss_ZLeoIntroSequence+5C   j
                rts
; End of function Boss_ZLeoIntroSequence
; Waits for camera Y position to reach 0x1E0 before advancing state
Boss_ZLeoWaitCameraPosition:                            ; DATA XREF: ROM:000220F0   o  ; was: sub_22180
                bsr.w   Boss_ZLeoPaletteEffect2
                cmpi.w  #$1E0,(dword_FFC630).w
                bcs.s   locret_2219A
                clr.w   (dword_FFC638).w
                move.w  #$40,(dword_FF9400+2).w         ; '@'
                addq.w  #2,(dword_FF9400).w
locret_2219A:                                           ; CODE XREF: Boss_ZLeoWaitCameraPosition+A   j
                rts
; End of function Boss_ZLeoWaitCameraPosition
; Waits for timer countdown with palette effects before advancing state
Boss_ZLeoWaitTimer:                                     ; DATA XREF: ROM:000220F2   o  ; was: sub_2219C
                bsr.w   Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_221AA
                addq.w  #2,(dword_FF9400).w
locret_221AA:                                           ; CODE XREF: Boss_ZLeoWaitTimer+8   j
                rts
; End of function Boss_ZLeoWaitTimer
; Scrolls camera upward with acceleration until reaching final position
Boss_ZLeoCameraScroll:                                  ; DATA XREF: ROM:000220F4   o  ; was: sub_221AC
                cmpi.w  #$60,(dword_FF9410+2).w         ; '`'
                blt.s   loc_221C2
                move.w  (dword_FF9408+2).w,d0
                sub.w   d0,(dword_FF9410+2).w
                bsr.w   Boss_ZLeoPaletteEffect2
                bra.s   loc_221EA
; ---------------------------------------------------------------------------
loc_221C2:                                              ; CODE XREF: Boss_ZLeoCameraScroll+6   j
                move.w  #1,(dword_FF9410).w
                move.w  #$160,(dword_FF9410+2).w
                move.w  #$F0,(dword_FF9414).w
                move.w  #$FF,(dword_FF9414+2).w
                move.w  #$7F,(dword_FF9418).w
                move.w  #7,(dword_FF941C).w
                bsr.w   Boss_ZLeoPaletteEffect2
loc_221EA:                                              ; CODE XREF: Boss_ZLeoCameraScroll+14   j
                addi.l  #$800,(dword_FF9408+2).w
                cmpi.l  #$80000,(dword_FF9408+2).w
                bne.s   locret_22214
                bset    #0,(word_FFC622).w
                move.l  #$78000,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
                move.w  #$160,(dword_FF9410+2).w
locret_22214:                                           ; CODE XREF: Boss_ZLeoCameraScroll+4E   j
                rts
; End of function Boss_ZLeoCameraScroll
; Initialize credits palette
Credits_PaletteInit:                                    ; DATA XREF: ROM:000220F6   o  ; was: sub_22216
                bsr.w   Boss_ZLeoPaletteEffect2
                cmpi.w  #$120,(dword_FFC630).w
                bgt.s   locret_2222C
                move.l  (dword_FF9408+2).w,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
locret_2222C:                                           ; CODE XREF: Credits_PaletteInit+A   j
                rts
; End of function Credits_PaletteInit
; Credits scroll update 1
Credits_ScrollUpdate1:                                  ; DATA XREF: ROM:000220F8   o  ; was: sub_2222E
                move.w  #2,(dword_FF9410).w
                move.w  #$160,(dword_FF9410+2).w
                move.w  #$F0,(dword_FF9414).w
                move.w  #$FF,(dword_FF9414+2).w
                move.w  #$7F,(dword_FF9418).w
                move.w  #7,(dword_FF941C).w
                bsr.w   Boss_ZLeoPaletteEffect2
                addq.w  #2,(dword_FF9400).w
                move.w  #$80,(dword_FF9400+2).w
                rts
; End of function Credits_ScrollUpdate1
; Credits scroll update 2
Credits_ScrollUpdate2:                                  ; DATA XREF: ROM:000220FA   o  ; was: sub_22262
                bsr.w   Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_22276
                move.w  #$80,(dword_FF9400+2).w
                addq.w  #2,(dword_FF9400).w
locret_22276:                                           ; CODE XREF: Credits_ScrollUpdate2+8   j
                rts
; End of function Credits_ScrollUpdate2
; Credits scroll update 3
Credits_ScrollUpdate3:                                  ; DATA XREF: ROM:000220FC   o  ; was: sub_22278
                bsr.w   Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_22294
                bclr    #0,(word_FFC622).w
                move.l  #$FFFE0000,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
locret_22294:                                           ; CODE XREF: Credits_ScrollUpdate3+8   j
                rts
; End of function Credits_ScrollUpdate3
; Credits scroll update 4
Credits_ScrollUpdate4:                                  ; DATA XREF: ROM:000220FE   o  ; was: sub_22296
                bsr.w   Boss_ZLeoPaletteEffect2
                addi.l  #$1000,(dword_FFC638).w
                btst    #7,(dword_FFC638).w
                bne.s   locret_222B8
                move.b  #$D5,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,(dword_FF9400).w
locret_222B8:                                           ; CODE XREF: Credits_ScrollUpdate4+12   j
                rts
; End of function Credits_ScrollUpdate4
; Credits scroll update 5
Credits_ScrollUpdate5:                                  ; DATA XREF: ROM:00022100   o  ; was: sub_222BA
                bsr.w   Boss_ZLeoPaletteEffect2
                addi.l  #$1000,(dword_FFC638).w
                cmpi.w  #$1E0,(dword_FFC630).w
                blt.s   locret_222DC
                addq.w  #1,(dword_FF9410).w
                addq.w  #2,(dword_FF9400).w
                move.w  #$80,(dword_FF9400+2).w
locret_222DC:                                           ; CODE XREF: Credits_ScrollUpdate5+12   j
                rts
; End of function Credits_ScrollUpdate5
; Credits graphics update 1
Credits_UpdateGraphics1:                                ; DATA XREF: ROM:00022102   o  ; was: sub_222DE
                bsr.w   Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_222F8
                move.w  #$80,(dword_FF9400+2).w
                move.w  #4,(dword_FF9410).w
                addq.w  #2,(dword_FF9400).w
locret_222F8:                                           ; CODE XREF: Credits_UpdateGraphics1+8   j
                rts
; End of function Credits_UpdateGraphics1
; Credits graphics update 2
Credits_UpdateGraphics2:                                ; DATA XREF: ROM:00022104   o  ; was: sub_222FA
                bsr.w   Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_22308
                addq.w  #2,(dword_FF9400).w
locret_22308:                                           ; CODE XREF: Credits_UpdateGraphics2+8   j
                rts
; End of function Credits_UpdateGraphics2
; Credits graphics update 3
Credits_UpdateGraphics3:                                ; DATA XREF: ROM:00022106   o  ; was: sub_2230A
                bsr.w   Boss_ZLeoPaletteEffect2
                move.w  #$40,(dword_FF9400+2).w         ; '@'
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Credits_UpdateGraphics3
; Credits graphics update 4
Credits_UpdateGraphics4:                                ; DATA XREF: ROM:00022108   o  ; was: sub_2231A
                bsr.w   Boss_ZLeoPaletteEffect2
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_2232C
                clr.w   (dword_FF9400+2).w
                addq.w  #2,(dword_FF9400).w
locret_2232C:                                           ; CODE XREF: Credits_UpdateGraphics4+8   j
                rts
; End of function Credits_UpdateGraphics4
; Load credits tiles
Credits_LoadTiles:                                      ; DATA XREF: ROM:0002210A   o  ; was: sub_2232E
                move.w  (dword_FF9400+2).w,d0
                bsr.w   Credits_FadeOut
                btst    #0,(word_FFA280+1).w
                bne.s   loc_22378
                btst    #1,(word_FFA280+1).w
                bne.s   loc_22378
                addq.w  #1,(dword_FF9400+2).w
                cmpi.w  #$E,(dword_FF9400+2).w
                bls.s   locret_22376
                addq.w  #2,(dword_FF9400).w
                lea     (word_FFE380).w,a0
                move.w  #$1F,d7
                moveq   #0,d0
loc_22360:                                              ; CODE XREF: Credits_LoadTiles+34   j
                move.l  d0,(a0)+
                dbf     d7,loc_22360
                move.w  #$80,(dword_FF9400+2).w
                move.b  #$C1,d0
                jsr     (Sound_PlaySFX).l
locret_22376:                                           ; CODE XREF: Credits_LoadTiles+22   j
                rts
; ---------------------------------------------------------------------------
loc_22378:                                              ; CODE XREF: Credits_LoadTiles+E   j
                                        ; Credits_LoadTiles+16   j
                bsr.w   Boss_ZLeoPaletteEffect2
                rts
; End of function Credits_LoadTiles
; Prepares fade out effect for credits sequence with timer countdown
Credits_FadeOutPrepare:                                 ; DATA XREF: ROM:0002210C   o  ; was: sub_2237E
                move.w  #$E,d0
                bsr.w   Credits_FadeOut
                subq.w  #1,(dword_FF9400+2).w
                bne.s   locret_2239E
                move.w  #$E,(dword_FF9400+2).w
                clr.l   (dword_FF9408+2).w
                clr.w   (dword_FF9410).w
                addq.w  #2,(dword_FF9400).w
locret_2239E:                                           ; CODE XREF: Credits_FadeOutPrepare+C   j
                rts
; End of function Credits_FadeOutPrepare
; Continues fade out while checking for player input to skip
Credits_FadeOutWaitInput:                               ; DATA XREF: ROM:0002210E   o  ; was: sub_223A0
                move.w  (dword_FF9400+2).w,d0
                bsr.w   Credits_FadeOut
                btst    #0,(word_FFA280+1).w
                bne.s   locret_223C8
                btst    #1,(word_FFA280+1).w
                bne.s   locret_223C8
                subq.w  #1,(dword_FF9400+2).w
                bpl.s   locret_223C8
                move.w  #$8C,(GameModeIndex).w
                addq.w  #2,(dword_FF9400).w
locret_223C8:                                           ; CODE XREF: Credits_FadeOutWaitInput+E   j
                                        ; Credits_FadeOutWaitInput+16   j
                rts
; End of function Credits_FadeOutWaitInput
nullsub_56:                                             ; DATA XREF: ROM:00022110   o
                rts
; End of function nullsub_56

; Credits fade out effect
Credits_FadeOut:                                        ; CODE XREF: Credits_LoadTiles+4   p  ; was: sub_223CC
                                        ; Credits_FadeOutPrepare+4   p
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Credits_FadeOut
; Palette update handler
Boss_ZLeoPaletteUpdate:                                 ; CODE XREF: Boss_ZLeoMainController+8   p  ; was: sub_223E2
                move.l  (dword_FF9408+2).w,d0
                add.l   d0,(dword_FFA900).w
                rts
; End of function Boss_ZLeoPaletteUpdate
; Debug function for manual camera control using directional inputs
Debug_CameraManualControl:
                btst    #2,(word_FFF706).w              ; was: sub_223EC
                beq.s   loc_223F8
                subq.w  #4,(dword_FFA410).w
loc_223F8:                                              ; CODE XREF: Debug_CameraManualControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_22404
                addq.w  #4,(dword_FFA410).w
loc_22404:                                              ; CODE XREF: Debug_CameraManualControl+12   j
                btst    #0,(word_FFF706).w
                beq.s   loc_22410
                subq.w  #4,(dword_FFA414).w
loc_22410:                                              ; CODE XREF: Debug_CameraManualControl+1E   j
                btst    #1,(word_FFF706).w
                beq.s   locret_2241C
                addq.w  #4,(dword_FFA414).w
locret_2241C:                                           ; CODE XREF: Debug_CameraManualControl+2A   j
                rts
; End of function Debug_CameraManualControl
; Updates camera position from sine/cosine table data for scrolling effects
Stage_UpdateCameraFromTable:
                lea     (word_1B514).l,a4               ; was: sub_2241E
                addi.w  #4,(dword_FF9404).w
                addi.w  #2,(dword_FF9404+2).w
                move.w  (dword_FF9404).w,d0
                addi.w  #$1FE,d0
                move.w  (a4,d0.w),d0
                muls.w  #$40,d0                         ; '@'
                addi.l  #$1200000,d0
                move.l  d0,(dword_FFA410).w
                move.w  (dword_FF9404+2).w,d0
                addi.w  #$1FE,d0
                move.w  (a4,d0.w),d0
                muls.w  #$20,d0                         ; ' '
                addi.l  #$F00000,d0
                move.l  d0,(dword_FFA414).w
                rts
; End of function Stage_UpdateCameraFromTable
; Palette effect handler 1
Boss_ZLeoPaletteEffect1:                                ; CODE XREF: Boss_ZLeoMainController+C   p  ; was: sub_22466
                cmpi.w  #$80,(dword_FFC630).w
                blt.s   loc_2248A
                cmpi.w  #$1C0,(dword_FFC630).w
                bgt.s   loc_2248A
                bset    #7,(word_FFA402).w
                move.l  (dword_FFC630).w,(dword_FFA410).w
                move.l  (dword_FFC634).w,(dword_FFA414).w
                rts
; ---------------------------------------------------------------------------
loc_2248A:                                              ; CODE XREF: Boss_ZLeoPaletteEffect1+6   j
                                        ; Boss_ZLeoPaletteEffect1+E   j
                move.l  #$60,(dword_FFA410).w           ; '`'
                bclr    #7,(word_FFA402).w
                rts
; End of function Boss_ZLeoPaletteEffect1
; Palette effect handler 2
Boss_ZLeoPaletteEffect2:                                ; CODE XREF: Boss_ZLeoIntroSequence+4A   p  ; was: sub_2249A
                                        ; sub_22112:loc_22166   p
                move.w  (dword_FF9410).w,d7
                subq.w  #1,d7
                bmi.w   locret_2254A
loc_224A4:                                              ; CODE XREF: Boss_ZLeoPaletteEffect2+84   j
                jsr     (RandomNumber).l
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   locret_2254A
                jsr     (Sprite_InitializeProperties).l
                move.b  #$60,$20(a0)                    ; '`'
                move.b  (dword_FFFF08+2).w,d6
                andi.w  #3,d6
                add.w   d6,d6
                move.b  (dword_FFFF08).w,d0
                move.w  (dword_FF9414+2).w,d1
                and.w   d1,d0
                and.w   d1,d0
                addq.w  #1,d1
                lsr.w   #1,d1
                sub.w   d1,d0
                add.w   (dword_FF9410+2).w,d0
                add.w   word_2254C(pc,d6.w),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                move.w  (dword_FF9418).w,d1
                and.w   d1,d0
                addq.w  #1,d1
                lsr.w   #1,d1
                sub.w   d1,d0
                add.w   (dword_FF9414).w,d0
                add.w   word_22554(pc,d6.w),d0
                move.w  d0,$14(a0)
                move.l  (dword_FF9408+2).w,d0
                asr.l   #1,d0
                move.l  d0,$18(a0)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #7,d0
                lsl.w   #2,d0
                move.l  off_2255C(pc,d0.w),8(a0)
                dbf     d7,loc_224A4
                tst.w   (dword_FF941C).w
                beq.s   locret_2254A
                move.w  (dword_FFFF08).w,d0
                and.w   (dword_FF941C).w,d0
                bne.s   locret_2254A
                cmpi.w  #$18,(dword_FF9400).w
                bcc.s   loc_22540
                move.b  #$30,d0                         ; '0'
                bra.s   loc_22544
; ---------------------------------------------------------------------------
loc_22540:                                              ; CODE XREF: Boss_ZLeoPaletteEffect2+9E   j
                move.b  #$2F,d0                         ; '/'
loc_22544:                                              ; CODE XREF: Boss_ZLeoPaletteEffect2+A4   j
                jsr     (Sound_PlaySFX).l
locret_2254A:                                           ; CODE XREF: Boss_ZLeoPaletteEffect2+6   j
                                        ; Boss_ZLeoPaletteEffect2+16   j
                rts
; End of function Boss_ZLeoPaletteEffect2
; ---------------------------------------------------------------------------
word_2254C:     dc.w    $20, 0, $FFE0, 0                ; DATA XREF: Boss_ZLeoPaletteEffect2+46   r
word_22554:     dc.w    0, $A, $FFF0, 0                 ; DATA XREF: Boss_ZLeoPaletteEffect2+62   r
off_2255C:      dc.l    off_E953C                       ; DATA XREF: Boss_ZLeoPaletteEffect2+7E   r
                dc.l    off_E9560
                dc.l    off_E9584
                dc.l    off_E95A4
                dc.l    off_E95A4
                dc.l    off_E95DC
                dc.l    off_E9584
                dc.l    off_E953C

; Update credits tilemap
Credits_UpdateTilemap:                                  ; CODE XREF: Boss_ZLeoIntroSequence+68   p  ; was: sub_2257C
                lea     (word_FFA400).w,a5
                move.b  #$41,d0                         ; 'A'
                jsr     (Sound_PlaySFX).l
                movea.w #(word_FFC5C0-M68K_RAM),a0
                move.w  #$230,(a0)
                move.b  #$54,$21(a0)                    ; 'T'
                move.w  #$4000,2(a0)
                move.l  #word_E8F22,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                eori.w  #$1000,$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                rts
; End of function Credits_UpdateTilemap
; ---------------------------------------------------------------------------
unused_5:       binclude "data/other/unused_5.bin"
unused_5_End:

; Demo playback system with input recording and VDP state management
