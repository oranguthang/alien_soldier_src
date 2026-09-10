Cutscene_InitCreditsScreen:                             ; CODE XREF: Stage_TransitionToCredits+6   j  ; was: sub_7B30
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr     (Sys_InitGameMode).l
                move.w  #1,(word_FF010E).l
                movea.l #stru_7BF2,a0
                jsr     (LoadObjData).l
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9600-M68K_RAM),a1
                move.w  #$20,(word_FF8048).w            ; ' '
                move.w  #$1F,(word_FF804A).w
                move.w  #1,(dword_FF8044+2).w
                jsr     (Gfx_LoadTilesLoop).l
                jsr     (Sys_ClearEntityObjectPool).l
                lea     (Gfx_DefaultVRAMTransferParameters).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                jsr     (Gfx_DirectVRAMTransfer).l
                lea     (CreditsAndPlanetPaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.w  #$FFF2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                move.b  #$88,d0
                jsr     (Sys_WaitVBlank).l
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA90C).w
                clr.w   (dword_FFA908).w
                jsr     (Gfx_SetupScrollPlanes).l
                clr.w   (dword_FF8128+2).w
                rts
; End of function Cutscene_InitCreditsScreen
; ---------------------------------------------------------------------------
stru_7BF2:      dc.w    7                               ; field_0
                                        ; DATA XREF: Cutscene_InitCreditsScreen+18   o
                dc.l    tiles_189E4C                    ; field_2
                dc.w    $2000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_18B2FA                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18CD7C                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18CC50                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    tiles_18B14C                    ; field_2
                dc.w    $9600                           ; field_6
                dc.w    $FFFF

; Dispatches credits screen state machine based on current state offset
Cutscene_CreditsDispatcher:                             ; CODE XREF: Stage_HandleCreditsOrAdvance+8   j  ; was: sub_7C24
                jsr     (Effect_PaletteDispatcher).l
                move.w  (dword_FF8128+2).w,d0
                lea     off_7C36(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_CreditsDispatcher
; ---------------------------------------------------------------------------
off_7C36:       dc.w    Cutscene_FadeInCredits-*        ; DATA XREF: Cutscene_CreditsDispatcher+A   o
                dc.w    Cutscene_WaitCreditsTimer-*
                dc.w    Cutscene_FadeOutCredits-*
                dc.w    Cutscene_WaitForTimer-*
                dc.w    Effect_InitializeStarfield-*
                dc.w    Effect_InitializeStarfield_WaitLoop-*
                dc.w    Cutscene_SegaScreenFadeOut-*
                dc.w    Cutscene_InitPlanetScene-*
                dc.w    Cutscene_PlanetSequenceCtrl-*
                dc.w    Cutscene_PlanetFadeOut-*
                dc.w    Cutscene_PlanetTransition-*
                dc.w    Cutscene_PlanetZoomMainLoop-*
                dc.w    Cutscene_PlanetZoomFadeOut-*

; Fades in credits screen palette incrementally until fully visible
Cutscene_FadeInCredits:                                 ; DATA XREF: ROM:off_7C36   o  ; was: sub_7C50
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_514E
                addq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF010C).l
                bne.w   locret_514E
                move.w  #$80,(word_FF0106).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_FadeInCredits
; Waits for credits display timer while animating palette colors
Cutscene_WaitCreditsTimer:                              ; DATA XREF: ROM:00007C38   o  ; was: sub_7C92
                bsr.w   Gfx_AnimateCreditsColors
                subq.w  #1,(word_FF0106).l
                bne.w   locret_514E
                clr.w   (word_FF010C).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_WaitCreditsTimer
; Animates credits palette colors with alternating color schemes per frame
Gfx_AnimateCreditsColors:                               ; CODE XREF: Cutscene_WaitCreditsTimer   p  ; was: sub_7CAC
                                        ; sub_7D68:loc_7E48   p
                lea     (word_FFE366).w,a1
                move.w  (word_FFA280).w,d0
                andi.w  #1,d0
                bne.s   loc_7CC6
                lea     word_7CD2(pc),a0
                nop
                move.w  (a0)+,(a1)+
                move.l  (a0),(a1)
                rts
; ---------------------------------------------------------------------------
loc_7CC6:                                               ; CODE XREF: Gfx_AnimateCreditsColors+C   j
                lea     word_7CD8(pc),a0
                nop
                move.w  (a0)+,(a1)+
                move.l  (a0),(a1)
                rts
; End of function Gfx_AnimateCreditsColors
; ---------------------------------------------------------------------------
word_7CD2:      dc.w    $EA8, $E86, $E64                ; DATA XREF: Gfx_AnimateCreditsColors+E   o
word_7CD8:      dc.w    $A2A, $828, $626                ; DATA XREF: Gfx_AnimateCreditsColors:loc_7CC6   o

; Fades out credits screen palette incrementally before transition
Cutscene_FadeOutCredits:                                ; DATA XREF: ROM:00007C3A   o  ; was: sub_7CDE
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_514E
                addq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$E,(word_FF010C).l
                bne.w   locret_514E
                movea.l #byte_7D48,a0
                jsr     (Gfx_LoadCompressedTiles).l
                lea     (Entity_ObjectPool).w,a5
                move.w  #$128,dword_FFC630-Entity_ObjectPool(a5)
                move.w  #$E8,$14(a5)
                jsr     (Object_ClearForTransition).l
                move.w  #$2C8,(a5)
                move.w  #$10,(word_FF0106).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_FadeOutCredits
; ---------------------------------------------------------------------------
byte_7D48:      dc.b    $44, $20, $40, 0, 2, 2, $80, $84, $88, $84, $88, $80, $84, $80, $88, $FF
                                        ; DATA XREF: Cutscene_FadeOutCredits+36   o

; Waits for timer countdown and advances to next state
Cutscene_WaitForTimer:                                  ; DATA XREF: ROM:00007C3C   o  ; was: sub_7D58
                subq.w  #1,(word_FF0106).l
                bne.w   locret_514E
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_WaitForTimer
; Initializes starfield effect with 59 sprites and random positions
