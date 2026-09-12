; Initializes credits screen
Credits_InitializeScreen:                               ; DATA XREF: Sys_DispatchGameState+B6   o  ; was: sub_1E16C
                tst.w   (GameSubstateIndex).w
                bne.s   Credits_InitializeScreen_Activate
                addq.w  #2,(GameSubstateIndex).w
                jsr     (Sys_InitGameMode).l
                lea     Credits_IntroAssetLoadList(pc),a0
                nop
                jsr     (LoadObjData).l
                lea     (CreditsAndEarlyStagePaletteCommandBank).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                move.b  #0,(VDPReg18Shadow+1).w
                rts
; ---------------------------------------------------------------------------
Credits_InitializeScreen_Activate:                      ; CODE XREF: Credits_InitializeScreen+4   j  ; was: loc_1E1BE
                addq.w  #4,(GameModeIndex).w
                jsr     (Gfx_FadePaletteTransition).l
                movea.l #Credits_IntroVRAMTransferParameters,a0
                move.w  #$800,d0
                move.w  #$FF00,d1
                jsr     (Tilemap_TransferFullMapDirectToVRAM).l
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA904).w
                jsr     (Scroll_PreparePlaneBuffersAndRegisterShadows).l
                move.w  #0,(word_FF807A).w
                jsr     (Effect_TransitionDispatcher).l
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                rts
; End of function Credits_InitializeScreen
; ---------------------------------------------------------------------------
Credits_IntroAssetLoadList: dc.w    7                   ; field_0  ; was: stru_1E204
                                        ; DATA XREF: Credits_InitializeScreen+10   o
                dc.l    tiles_18B2FA                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18D562                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18CC50                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18CD7C                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18454C                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    $FFFF
Credits_IntroVRAMTransferParameters:    dc.l    $FFFF7000, $FFFF6000, $FFFF4000, $4000  ; was: dword_1E236
                                        ; DATA XREF: Credits_InitializeScreen+5C   o

; Updates credits palette effects
Credits_UpdateEffects:                                  ; DATA XREF: Sys_DispatchGameState+BA   o  ; was: sub_1E246
                jsr     (Gfx_FadePaletteTransition).l
                jsr     (Effect_PaletteDispatcher).l
                rts
; End of function Credits_UpdateEffects
