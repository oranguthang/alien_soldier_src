Credits_InitXiTiger:                                    ; DATA XREF: Sys_DispatchGameState+E2   o  ; was: sub_20956
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr     (Sys_InitGameMode).l
                jsr     (Gfx_QueueVRAMCommand).l
                movea.l #stru_20B4A,a0
                jsr     (LoadObjData).l
                lea     (word_FF5000).l,a0
                move.w  #$FF,d7
loc_20982:                                              ; CODE XREF: Credits_InitXiTiger+34   j
                move.w  (a0),d0
                andi.w  #$FEFF,d0
                move.w  d0,(a0)+
                dbf     d7,loc_20982
                jsr     (Sys_ClearBossDataBuffer).l
                lea     (dword_FF5180).l,a0
                move.w  #$A000,d0
                move.w  #0,d1
                move.w  #2,d7
                jsr     (Gfx_UpdateTilemapIndices).l
                lea     (dword_FF6180).l,a0
                moveq   #0,d0
                move.w  #$1F,d1
loc_209B8:                                              ; CODE XREF: Credits_InitXiTiger+64   j
                move.l  d0,(a0)+
                dbf     d1,loc_209B8
                move.l  #$81828300,(dword_FF6194).l
                move.l  #$85868700,(dword_FF619C).l
                move.l  #$898A8B00,(dword_FF61A4).l
                lea     (dword_11326).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                jsr     (Gfx_DirectVRAMTransfer).l
                lea     (dword_11346).l,a0
                move.w  #$800,d0
                move.w  #0,d1
                jsr     (Gfx_DirectVRAMTransfer).l
                lea     (word_B982).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.w  #$EA8,(word_FFE3A8).w
                move.w  #$E86,(word_FFE3AA).w
                move.w  #$E64,(word_FFE3AC).w
                move.b  #6,(word_FFF7E6+1).w
                move.b  #3,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                clr.l   (dword_FF0110).l
                move.l  #$1000,(dword_FF0114).l
                move.l  #$FFF80000,d0
                lea     (word_FFE400).w,a0
                move.w  #$1B,d7
loc_20A52:                                              ; CODE XREF: Credits_InitXiTiger+102   j
                move.l  d0,(a0)
                adda.w  #$20,a0                         ; ' '
                dbf     d7,loc_20A52
                lea     (word_FFEC00).w,a0
                move.w  #$13,d7
loc_20A64:                                              ; CODE XREF: Credits_InitXiTiger+110   j
                move.l  d0,(a0)+
                dbf     d7,loc_20A64
                lea     (word_FFC680).w,a5
                move.w  #$CC00,word_FFC682-word_FFC680(a5)
                move.w  #$10,(a5)
                move.l  #word_21A32,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$90,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5)                    ; '`'
                lea     (word_FFC6E0).w,a5
                move.w  #$CC00,word_FFC6E2-word_FFC6E0(a5)
                move.w  #$10,(a5)
                move.l  #word_21A32,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$1B0,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5)                    ; '`'
                clr.w   (word_FFE306).w
                clr.w   (word_FFE386).w
                move.w  #$FFF2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE300).w,a0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.b  #0,(word_FFF7F4+1).w
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA90C).w
                clr.w   (dword_FFA908).w
                jsr     (Gfx_SetupScrollPlanes).l
                move.w  (word_FFFF38).w,(word_FFFF60).w
                move.w  #0,(word_FFFF38).w
                move.b  #$90,d0
                jsr     (Sys_WaitVBlank).l
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                clr.w   (word_FFA000).w
                rts
; End of function Credits_InitXiTiger
; ---------------------------------------------------------------------------
stru_20B4A:     dc.w    7                               ; field_0
                                        ; DATA XREF: Credits_InitXiTiger+16   o
                dc.l    tiles_18B2FA                    ; field_2
                dc.w    $4000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_14ADEE                     ; field_2
                dc.w    $B000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18CD7C                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18CC50                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    $FFFF

; Main loop for credits sequence processing objects and graphics
Credits_MainLoop:                                       ; DATA XREF: Sys_DispatchGameState+E6   o  ; was: sub_20B74
                jsr     (Gfx_UpdateScrollPosition).l
                jsr     (Sys_InitObjectPointers).l
                jsr     (UI_CheckVBlankFlag).l
                jsr     (Sys_ProcessVisibleObjects).l
                bsr.w   Credits_StateDispatcher
                jsr     (Sys_UpdateObjectCount).l
                jsr     (Sys_ProcessObjectList).l
                jsr     (Gfx_FadePaletteTransition).l
                jsr     (Gfx_SetupScrollPlanes).l
                addq.w  #1,(word_FFA000).w
                rts
; End of function Credits_MainLoop
; Dispatches to current credits state handler based on state index
Credits_StateDispatcher:                                ; CODE XREF: Credits_MainLoop+18   p  ; was: sub_20BAE
                subq.w  #1,(word_FF0188).l
                move.w  (GameSubstateIndex).w,d0
                lea     off_20BC0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Credits_StateDispatcher
; ---------------------------------------------------------------------------
off_20BC0:      dc.w    Credits_FadeInState-*           ; DATA XREF: Credits_StateDispatcher+A   o
                dc.w    Credits_ScrollWithColorCycle-*
                dc.w    Credits_WaitForTimerEnd-*
                dc.w    Credits_FadeOutAndClearVRAM-*
                dc.w    Credits_FadeInFromBlack-*
                dc.w    Credits_WaitForScrollEnd-*
                dc.w    Credits_FadeOutAndExit-*

; Handles fade-in transition at start of credits sequence
Credits_FadeInState:                                    ; DATA XREF: ROM:off_20BC0   o  ; was: sub_20BCE
                jsr     Credits_UpdateScrollTables(pc)  ; (pc)
                nop
                move.w  (word_FFA000).w,d0
                cmpi.w  #$80,d0
                bcs.w   locret_20C30
                andi.w  #$F,d0
                bne.w   locret_20C30
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE300).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   locret_20C30
                move.w  #$FFF0,(word_FF0176).l
                clr.w   (word_FF00EC).l
                clr.w   (word_FF017C).l
                move.w  #$4D80,(word_FF0188).l
                addq.w  #2,(GameSubstateIndex).w
locret_20C30:                                           ; CODE XREF: Credits_FadeInState+E   j
                                        ; Credits_FadeInState+16   j
                rts
; End of function Credits_FadeInState
; Scrolls credits text with color cycling palette effect
Credits_ScrollWithColorCycle:                           ; DATA XREF: ROM:00020BC2   o  ; was: sub_20C32
                jsr     (UI_SelectionMenuDispatcher).l
                bsr.w   Credits_XiTigerVBlankSync
                jsr     Credits_UpdateScrollTables(pc)  ; (pc)
                nop
                bsr.w   Credits_CyclePaletteColors
                move.w  (word_FFA000).w,d0
                cmpi.w  #$11C0,d0
                bcs.w   locret_20C30
                andi.w  #$F,d0
                bne.w   locret_20C30
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE360).w,a0
                move.w  #$F,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   locret_20C30
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_ScrollWithColorCycle
; Waits for timer to reach specific value before advancing state
Credits_WaitForTimerEnd:                                ; DATA XREF: ROM:00020BC4   o  ; was: sub_20C88
                jsr     (UI_SelectionMenuDispatcher).l
                bsr.w   Credits_XiTigerVBlankSync
                jsr     Credits_UpdateScrollTables(pc)  ; (pc)
                nop
                bsr.w   Credits_CyclePaletteColors
                cmpi.w  #$3000,(word_FF0188).l
                bne.w   locret_20C30
                move.w  #0,(word_FF0176).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_WaitForTimerEnd
; Cycles RGB color values in palette entries with XOR operation
Credits_CyclePaletteColors:                             ; CODE XREF: Credits_ScrollWithColorCycle+10   p  ; was: sub_20CB6
                                        ; Credits_WaitForTimerEnd+10   p
                eori.w  #$22E,(word_FFE328).w
                eori.w  #$2E2,(word_FFE32A).w
                eori.w  #$226,(word_FFE32C).w
                rts
; End of function Credits_CyclePaletteColors
; Updates horizontal scroll tables with 3D rotation effect
Credits_UpdateScrollTables:                             ; CODE XREF: Credits_FadeInState   p  ; was: sub_20CCA
                                        ; Credits_ScrollWithColorCycle+A   p
                move.l  (dword_FF0114).l,d0
                add.l   d0,(dword_FF0110).l
                move.l  (dword_FF0110).l,d1
                move.l  d1,d3
                asr.l   #2,d3
                move.l  d1,d0
                asr.l   #1,d0
                neg.l   d0
                lea     (word_FFE5C2).w,a0
                move.w  #$D,d7
loc_20CEE:                                              ; CODE XREF: Credits_UpdateScrollTables+32   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #$20,a0                         ; ' '
                dbf     d7,loc_20CEE
                move.l  (dword_FF0110).l,d1
                move.l  d1,d0
                asr.l   #1,d0
                lea     (word_FFE5A2).w,a0
                move.w  #$D,d7
loc_20D12:                                              ; CODE XREF: Credits_UpdateScrollTables+56   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #$20,a0                         ; ' '
                dbf     d7,loc_20D12
                move.l  (dword_FF0110).l,d1
                move.l  d1,d3
                asr.l   #1,d3
                move.l  d1,d0
                neg.l   d0
                asl.l   #1,d1
                lea     (word_FFEC2A).w,a0
                move.w  #9,d7
loc_20D3C:                                              ; CODE XREF: Credits_UpdateScrollTables+80   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #4,a0
                dbf     d7,loc_20D3C
                move.l  (dword_FF0110).l,d1
                move.l  d1,d0
                asl.l   #1,d1
                lea     (word_FFEC26).w,a0
                move.w  #9,d7
loc_20D60:                                              ; CODE XREF: Credits_UpdateScrollTables+A4   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #4,a0
                dbf     d7,loc_20D60
                rts
; End of function Credits_UpdateScrollTables
; Fades out palette and clears VRAM plane data
Credits_FadeOutAndClearVRAM:                            ; DATA XREF: ROM:00020BC6   o  ; was: sub_20D74
                jsr     (UI_SelectionMenuDispatcher).l
                bsr.w   Credits_XiTigerVBlankSync
                jsr     Credits_UpdateScrollTables(pc)  ; (pc)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_20C30
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   locret_20C30
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_20DDE:                                              ; CODE XREF: Credits_FadeOutAndClearVRAM+6C   j
                move.w  d1,(a0)
                dbf     d0,loc_20DDE
                move    (sp)+,sr
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$60000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_20E0C:                                              ; CODE XREF: Credits_FadeOutAndClearVRAM+9A   j
                move.w  d1,(a0)
                dbf     d0,loc_20E0C
                move    (sp)+,sr
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_FadeOutAndClearVRAM
; Fades palette from black to normal colors
Credits_FadeInFromBlack:                                ; DATA XREF: ROM:00020BC8   o  ; was: sub_20E1A
                jsr     (UI_SelectionMenuDispatcher).l
                bsr.w   Credits_XiTigerVBlankSync
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_20C30
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   locret_20C30
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_FadeInFromBlack
; Waits for scroll sequence to complete before advancing
Credits_WaitForScrollEnd:                               ; DATA XREF: ROM:00020BCA   o  ; was: sub_20E5E
                jsr     (UI_SelectionMenuDispatcher).l
                bsr.w   Credits_XiTigerVBlankSync
                bsr.w   Credits_ScrollStateDispatcher
                tst.w   (word_FF0188).l
                bne.w   locret_20C30
                move.w  #0,(word_FF0176).l
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Credits_WaitForScrollEnd
; Fades out and returns to title screen mode
Credits_FadeOutAndExit:                                 ; DATA XREF: ROM:00020BCC   o  ; was: sub_20E84
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE300).w,a0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   locret_20C30
                move.w  #1,(word_FFFF46).w
                move.w  (word_FFFF60).w,(word_FFFF38).w
                jsr     (Sys_ClearBossDataBuffer).l
                move.w  #$84,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; End of function Credits_FadeOutAndExit
; Xi-Tiger VBlank sync
Credits_XiTigerVBlankSync:                              ; CODE XREF: Credits_ScrollWithColorCycle+6   p  ; was: sub_20ECC
                                        ; Credits_WaitForTimerEnd+6   p
                cmpi.w  #$1F40,(word_FF0188).l
                beq.s   loc_20EEC
                cmpi.w  #$1EC0,(word_FF0188).l
                beq.s   loc_20EF6
                cmpi.w  #$A0,(word_FF0188).l
                beq.s   loc_20EEC
                rts
; ---------------------------------------------------------------------------
loc_20EEC:                                              ; CODE XREF: Credits_XiTigerVBlankSync+8   j
                                        ; Credits_XiTigerVBlankSync+1C   j
                move.b  #1,d0
                jmp     (Sys_WaitVBlank).l
; ---------------------------------------------------------------------------
loc_20EF6:                                              ; CODE XREF: Credits_XiTigerVBlankSync+12   j
                move.b  #$94,d0
                jmp     (Sys_WaitVBlank).l
; End of function Credits_XiTigerVBlankSync
; Dispatches to scroll sequence state handler
Credits_ScrollStateDispatcher:                          ; CODE XREF: Credits_WaitForScrollEnd+A   p  ; was: sub_20F00
                move.w  (word_FF017C).l,d0
                lea     off_20F0E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Credits_ScrollStateDispatcher
; ---------------------------------------------------------------------------
off_20F0E:      dc.w    Stage_InitializeCreditsScreen-*  ; DATA XREF: Credits_ScrollStateDispatcher+6   o
                dc.w    Stage_LoadCreditsDataPhase-*
                dc.w    Stage_WaitForPlayerInput-*
                dc.w    Stage_UpdateCreditsLoop-*
                dc.w    Credits_TreasureScreen1-*
                dc.w    Credits_TreasureScreen2-*
                dc.w    Stage_WaitTimerAndInput-*
                dc.w    Gfx_FadeOutPaletteCredits-*
                dc.w    Credits_TreasureScreen1-*
                dc.w    Credits_SegaScreen-*
                dc.w    Stage_WaitTimerAndInput-*
                dc.w    Gfx_FadeOutPaletteCredits-*
                dc.w    nullsub_54-*

; Initialize credits screen with sprite objects and palette data
Stage_InitializeCreditsScreen:                          ; DATA XREF: ROM:off_20F0E   o  ; was: sub_20F28
                clr.w   (word_FF017E).l
                lea     stru_2158C(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                lea     word_2156C(pc),a0
                nop
                lea     (word_FFE340).w,a1
                bsr.w   Data_Copy32Bytes
                lea     (word_FFC680).w,a5
                move.w  #$CC00,word_FFC682-word_FFC680(a5)
                move.w  #$10,(a5)
                move.l  #word_21A32,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$90,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5)                    ; '`'
                lea     (word_FFC6E0).w,a5
                move.w  #$CC00,word_FFC6E2-word_FFC6E0(a5)
                move.w  #$10,(a5)
                move.l  #word_21A32,8(a5)
                move.w  #$8000,$E(a5)
                move.w  #$1B0,$10(a5)
                move.w  #$E0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$60,$20(a5)                    ; '`'
                clr.w   (word_FFE306).w
                move.b  #3,(word_FFF7E6+1).w
                move.b  #1,(byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                lea     (word_FFE400).w,a0
                move.l  #$7F008000,d1
                move.w  #$EF,d0
loc_20FD8:                                              ; CODE XREF: Stage_InitializeCreditsScreen+B2   j
                move.l  d1,(a0)+
                dbf     d0,loc_20FD8
                move.w  #$AA,(word_FF018E).l
                move.l  #off_214C8,(dword_FF018A).l
                move.l  #$FFFFE320,(dword_FF0190).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Stage_InitializeCreditsScreen
; Load next phase of credits data and process pointer
Stage_LoadCreditsDataPhase:                             ; DATA XREF: ROM:00020F10   o  ; was: sub_21002
                subq.w  #1,(word_FF018E).l
                bne.w   locret_20C30
                movea.l (dword_FF018A).l,a2
                movea.l (a2)+,a0
                movea.l (dword_FF0190).l,a1
                bsr.w   Data_Copy32Bytes
                movea.l (a2)+,a0
                jsr     (Data_ProcessPointer).l
                move.w  #$160,(word_FF018E).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Stage_LoadCreditsDataPhase
; Wait for timer and check player input to advance
Stage_WaitForPlayerInput:                               ; DATA XREF: ROM:00020F12   o  ; was: sub_21036
                subq.w  #1,(word_FF018E).l
                tst.w   (word_FFF720).w
                bmi.w   locret_20C30
                clr.w   (word_FF0194).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Stage_WaitForPlayerInput
; Main credits update loop with data cycling
Stage_UpdateCreditsLoop:                                ; DATA XREF: ROM:00020F14   o  ; was: sub_21052
                bsr.w   Gfx_FadeInPaletteEntry
                bsr.w   Gfx_FadeAllPaletteEntries
                subq.w  #1,(word_FF018E).l
                bne.w   locret_20C30
                move.w  #$AA,(word_FF018E).l
                move.w  #2,(word_FF017C).l
                addq.l  #8,(dword_FF018A).l
                eori.l  #$40,(dword_FF0190).l           ; '@'
                movea.l (dword_FF018A).l,a2
                tst.l   (a2)
                bpl.w   locret_20C30
                move.w  #$1A0,(word_FF018E).l
                move.w  #8,(word_FF017C).l
                rts
; End of function Stage_UpdateCreditsLoop
; Fade in single palette entry by modifying color value
Gfx_FadeInPaletteEntry:                                 ; CODE XREF: Stage_UpdateCreditsLoop   p  ; was: sub_210A2
                move.w  (word_FF0194).l,d0
                cmpi.w  #$1E0,d0
                bcc.w   locret_20C30
                addq.w  #2,(word_FF0194).l
                move.w  word_210CE(pc,d0.w),d1
                lea     (word_FFE400).w,a0
                move.l  (a0,d1.w),d2
                subi.l  #$7FFF8,d2
                move.l  d2,(a0,d1.w)
                rts
; End of function Gfx_FadeInPaletteEntry
; ---------------------------------------------------------------------------
word_210CE:     binclude "data/other/word_210CE.bin"
word_210CE_End:

; Fade all palette entries in buffer
Gfx_FadeAllPaletteEntries:                              ; CODE XREF: Stage_UpdateCreditsLoop+4   p  ; was: sub_212AE
                lea     (word_FFE400).w,a0
                move.l  #$7FFF8,d1
                move.w  #$EF,d0
loc_212BC:                                              ; CODE XREF: Gfx_FadeAllPaletteEntries+20   j
                move.l  (a0),d2
                andi.l  #$FF00FF,d2
                beq.s   loc_212CC
                move.l  (a0),d2
                sub.l   d1,d2
                move.l  d2,(a0)
loc_212CC:                                              ; CODE XREF: Gfx_FadeAllPaletteEntries+16   j
                addq.l  #4,a0
                dbf     d0,loc_212BC
                rts
; End of function Gfx_FadeAllPaletteEntries
; Treasure screen handler 1
Credits_TreasureScreen1:                                ; DATA XREF: ROM:00020F16   o  ; was: sub_212D4
                                        ; ROM:00020F1E   o
                subq.w  #1,(word_FF018E).l
                bne.w   locret_20C30
                move.w  #$160,(word_FF018E).l
                move.w  #0,(word_FF0176).l
                lea     (word_FFE320).w,a0
                lea     (dword_FFE3A0).w,a1
                bsr.w   Data_Copy32Bytes
                bsr.w   Data_Copy32Bytes
                bsr.w   Data_Copy32Bytes
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_TreasureScreen1
; Treasure screen handler 2
Credits_TreasureScreen2:                                ; DATA XREF: ROM:00020F18   o  ; was: sub_2130A
                subq.w  #1,(word_FF018E).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_20C30
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   locret_20C30
                clr.w   (word_FFC680).w
                clr.w   (word_FFC6E0).w
                move.b  #0,(word_FFF7E6+1).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA908).w
                move.b  #4,(byte_FFA95A).w
                move.b  #4,(byte_FFA95B).w
                lea     word_2197E(pc),a0
                nop
                lea     (dword_FFE3A0).w,a1
                bsr.w   Data_Copy32Bytes
                bsr.w   Data_Copy32Bytes
                bsr.w   Data_Copy32Bytes
                lea     stru_219DE(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                move.w  #$220,(word_FF018E).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_TreasureScreen2
; Wait for timer countdown and check for player skip
Stage_WaitTimerAndInput:                                ; DATA XREF: ROM:00020F1A   o  ; was: sub_2139A
                                        ; ROM:00020F22   o
                subq.w  #1,(word_FF018E).l
                tst.w   (word_FFF720).w
                bmi.w   locret_20C30
                addq.w  #2,(word_FF017C).l
                rts
; End of function Stage_WaitTimerAndInput
; Fade out palette to black for credits
Gfx_FadeOutPaletteCredits:                              ; DATA XREF: ROM:00020F1C   o  ; was: sub_213B0
                                        ; ROM:00020F24   o
                subq.w  #1,(word_FF018E).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_20C30
                addq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF0176).l
                bne.w   locret_20C30
                addq.w  #2,(word_FF017C).l
                rts
; End of function Gfx_FadeOutPaletteCredits
; Sega presentation screen
Credits_SegaScreen:                                     ; DATA XREF: ROM:00020F20   o  ; was: sub_213F2
                subq.w  #1,(word_FF018E).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_20C30
                subq.w  #2,(word_FF0176).l
                move.w  (word_FF0176).l,d0
                lea     (word_FFE320).w,a0
                move.w  #$2F,d5                         ; '/'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF0176).l
                bne.w   locret_20C30
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_21454:                                              ; CODE XREF: Credits_SegaScreen+64   j
                move.w  d1,(a0)
                dbf     d0,loc_21454
                move    (sp)+,sr
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$60000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_21482:                                              ; CODE XREF: Credits_SegaScreen+92   j
                move.w  d1,(a0)
                dbf     d0,loc_21482
                move    (sp)+,sr
                lea     word_21A00(pc),a0
                nop
                lea     ((dword_FFE3DE+2)).w,a1
                bsr.w   Data_Copy32Bytes
                lea     stru_21A20(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                move.w  #$1E0,(word_FF018E).l
                addq.w  #2,(word_FF017C).l
                rts
; End of function Credits_SegaScreen
nullsub_54:                                             ; DATA XREF: ROM:00020F26   o
                rts
; End of function nullsub_54

; Copy 32 bytes (8 longwords) from source to destination
