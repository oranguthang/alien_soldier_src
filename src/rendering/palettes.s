Gfx_LoadMultiplePalettes:                               ; CODE XREF: Gfx_WaitForFadeAndLoadTiles+3C   p  ; was: sub_B900
                                        ; Cutscene_InitCreditsScreen+64   p
                moveq   #0,d0
                movea.w #(word_FFE300-M68K_RAM),a0
                move.w  d0,(a0)
                move.w  d0,$80(a0)
                move.w  d0,$20(a0)
                move.w  d0,$A0(a0)
                move.w  d0,$40(a0)
                move.w  d0,$C0(a0)
                move.w  d0,$60(a0)
                move.w  d0,$E0(a0)
                lea     byte_BA2A(pc),a0
                nop
                bsr.w   LoadPalette
loc_B92E:                                               ; CODE XREF: Gfx_LoadMultiplePalettes+42   j
                move.w  (a4)+,d0
                bne.s   Gfx_LoadPaletteEntry
                rts
; ---------------------------------------------------------------------------
; Loads a single palette entry from palette buffer data
Gfx_LoadPaletteEntry:                                   ; CODE XREF: Gfx_LoadMultiplePalettes+30   j  ; was: loc_B934
                ext.l   d0
                addi.l  #Gfx_SyncPaletteBuffers,d0
                movea.l d0,a0
                bsr.w   LoadPalette
                bra.s   loc_B92E
; End of function Gfx_LoadMultiplePalettes
; ---------------------------------------------------------------------------
word_B944:      dc.w    $20A, 0                         ; DATA XREF: Gfx_WaitForFadeAndLoadTiles+36   o
word_B948:      dc.w    $60, $E2, 0                     ; DATA XREF: UI_InitOptionsScreen+72   o
word_B94E:      dc.w    $28A, $2B0, 0                   ; DATA XREF: UI_InitializeStageStart+DC   o
word_B954:      dc.w    $2D0, $2D6, 0                   ; DATA XREF: Gfx_LoadMenuGraphics+32   o
word_B95A:      dc.w    $EE, $F4, $FA, $100, 0, $EE, $F4, $FA, $100, 0
                                        ; DATA XREF: UI_InitializeContinueScreen+40   o
word_B96E:      dc.w    $EE, $F4, $FA, $100, 0
                                        ; DATA XREF: Results_InitializeScreen+6C   o
word_B978:      dc.w    $26A, 0, $2F6, $336, 0
                                        ; DATA XREF: Stage_InitializeTransition+16   o
word_B982:      dc.w    $B14, $B54, 0                   ; DATA XREF: Cutscene_InitCreditsScreen+5E   o
                                        ; Cutscene_InitPlanetScene+20   o
word_B988:      dc.w    $34C, 0                         ; DATA XREF: ROM:stru_127A8   o
                                        ; ROM:stru_127C6   o
word_B98C:      dc.w    $34C, $38E, 0                   ; DATA XREF: Camera_ShellshogunBossInit+38   o
                                        ; ROM:stru_12802   o
word_B992:      dc.w    $3B0, 0                         ; DATA XREF: ROM:stru_12820   o
                                        ; ROM:stru_1283E   o
word_B996:      dc.w    $3F2, 0                         ; DATA XREF: ROM:stru_1287A   o
word_B99A:      dc.w    $3F2, $966, 0                   ; DATA XREF: ROM:stru_121FE   o
                                        ; ROM:stru_12898   o
word_B9A0:      dc.w    $442, 0                         ; DATA XREF: Cutscene_LoadInitialAssets+C   o
word_B9A4:      dc.w    $482, 0                         ; DATA XREF: ROM:stru_128B6   o
                                        ; ROM:stru_128D4   o
word_B9A8:      dc.w    $4C2, 0                         ; DATA XREF: ROM:stru_1292E   o
                                        ; ROM:stru_1294C   o
word_B9AC:      dc.w    $502, 0                         ; DATA XREF: ROM:stru_12988   o
word_B9B0:      dc.w    $562, 0                         ; DATA XREF: ROM:stru_129A6   o
                                        ; ROM:stru_129C4   o
word_B9B4:      dc.w    $5A2, 0                         ; DATA XREF: ROM:stru_129E2   o
                                        ; ROM:stru_12A00   o
word_B9B8:      dc.w    $5E2, 0, $632, 0                ; DATA XREF: ROM:stru_12A5A   o
word_B9C0:      dc.w    $690, $6B0, 0                   ; DATA XREF: Cutscene_SevenForcesLoadGraphics   o
word_B9C6:      dc.w    $6B8, $818, 0                   ; DATA XREF: ROM:stru_12A78   o
                                        ; ROM:stru_12AB4   o
word_B9CC:      dc.w    $6B8, $828, 0                   ; DATA XREF: ROM:stru_12A96   o
word_B9D2:      dc.w    $6F8, $848, 0                   ; DATA XREF: ROM:stru_12AD2   o
word_B9D8:      dc.w    $718, $E34, 0                   ; DATA XREF: ROM:stru_12AF0   o
word_B9DE:      dc.w    $738, 0                         ; DATA XREF: ROM:stru_12B0E   o
word_B9E2:      dc.w    $758, 0                         ; DATA XREF: ROM:stru_12B2C   o
word_B9E6:      dc.w    $798, 0                         ; DATA XREF: ROM:stru_12B4A   o
                                        ; Stage_InitPlayerAndScroll+24   o

; Synchronizes palette data across multiple RAM buffers
Gfx_SyncPaletteBuffers:                                 ; CODE XREF: Gfx_UpdateBossPalette+6C   p  ; was: sub_B9EA
                                        ; Gfx_LoadStage17Palettes+12   j
                move.w  (word_FFE3EC).w,(dword_FF8040).w
                bsr.s   LoadPalette
                move.w  (dword_FF8040).w,(word_FFE36C).w
                move.w  (dword_FF8040).w,(word_FFE3EC).w
                rts
; End of function Gfx_SyncPaletteBuffers
LoadPalette:                                            ; CODE XREF: RegionRestricted+2A   p
                                        ; Gfx_SetupTitleScreenLetters+7E   p
                moveq   #0,d0
                move.b  (a0)+,d0
                addi.w  #-$1D00,d0
                move.w  d0,d1
                addi.w  #$80,d1
                movea.w d0,a1
                movea.w d1,a2
                moveq   #0,d0
                moveq   #0,d7
                move.b  (a0)+,d7
                move.w  d7,d1
                asl.w   #1,d1
                addq.w  #2,d1
                adda.l  d0,a0
; Copies palette data to both active and shadow palette buffers
Gfx_CopyPaletteLoop:                                    ; CODE XREF: LoadPalette+24   j  ; was: loc_BA20
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                dbf     d7,Gfx_CopyPaletteLoop
                rts
; End of function LoadPalette
; ---------------------------------------------------------------------------
byte_BA2A:      dc.b    $42, $E, 0, 0, $E, $EE, 0, $EE, 0, $AE, 0, $6E, 0, $E, 0, 4
                                        ; DATA XREF: Gfx_LoadMultiplePalettes+24   o
                dc.b    0, $48, 2, $20, 4, $42, 8, $86, $C, $CA, 6, 0, 8, $40, $C, $84
byte_BA4A:      dc.b    0, $3F, 0, 0, 0, $60, $C, $EA, 0, 0, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: RegionRestricted+24   o
                                        ; Gfx_SetupTitleScreenLetters+78   o
                dc.b    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b    0, 0, 0, 0, 6, 0, $E, $EC, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b    0, 0, 0, 0, 2, 0, 2, $22, $C, $22, $E, $42, 0, $E0, 0, 0
                dc.b    $E, $22, $E, $EE, 0, $6E, $A, $EE, 0, $28, 0, 4, $C, $EE, 0, 0
                dc.b    0, $CE, 0, 0, 0, 0, 2, 0, 0, 2, 0, 4, 0, 6, 0, 8
                dc.b    0, $A, 0, $C, 0, $2E, 0, $4E, 0, 0, 8, 0, $E, $62, $E, $CA
                dc.b    0, 0, 2, 1, 0, 4, 0, $8E
byte_BAD2:      dc.b    $42, 1, 0, 2, 0, $6E, 2, 1, 6, 0, $E, $80, $22, 1, 4, 0
                                        ; DATA XREF: UI_InitializePasswordScreen+38   o
                dc.b    8, $40, $42, 1, 6, 0, $E, $EC, $62, 1, 0, 6, 0, $AE
byte_BAF0:      dc.b    0, $3F, 0, 0, 0, $20, 2, $E6, 0, $2E, 0, $E, 0, 8, 0, 4
                                        ; DATA XREF: UI_InitializeStageSelect+7E   o
                                        ; Stage_InitializeStageSelect+50   o
                dc.b    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b    0, 0, 0, 0, 0, 0, 4, $22, 0, $4C, 0, $2A, 0, 8, 0, 0
                dc.b    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b    0, 0, 0, 0, 6, 0, $E, $EC, $C, $AA, $A, $88, 8, $66, 6, $44
                dc.b    4, $22, 0, $A, 0, 0, $A, $AA, 6, $66, 2, $22, 0, 0, 0, 0
                dc.b    0, 0, 0, 0, 0, 6, 0, $AE, 0, $26, 0, 4, 0, 2, 0, 0
                dc.b    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b    0, 0
byte_BB72:      binclude "data/mappings/byte_BB72.bin"
byte_BB72_End:
byte_BE1E:      binclude "data/other/byte_BE1E.bin"
byte_BE1E_End:
byte_BF2C:      dc.b    $62, $E, 2, 0, $E, $EE, 0, $6E, 6, $EE, 2, $84, 8, $EA, $C, $EE
                                        ; DATA XREF: Gfx_LoadStage17Palettes   o
                dc.b    4, 0, 6, $20, 8, $42, $A, $64, $C, $86, $E, $A8, $E, $CA, $E, $EE
                dc.b    2, $1E, $E, $EE, $E, $AA, $A, $68, $A, $44, 8, $22, 4, $22, $E, $86
                dc.b    $E, $64, $E, $42, $A, $86, 6, $42, 2, $20, 2, 0, 0, 0, 0, $24
                dc.b    0, 0, $E, $EE, $E, $CC, $E, $AA, $C, $66, 8, $44, 4, $22, 6, $88
                dc.b    4, $66, 2, $44, 0, $22, 0, 0, 2, $68, 0, $46, 0, $24, $E, $EE
                dc.b    2, $1E, 0, $20, $E, $EC, 2, $62, $E, $EC, $E, $CA, $A, $84, 8, $62
                dc.b    4, $40, 2, $20, 0, $22, 2, $46, 2, $8A, 4, $CC, 6, $40, $E, $84
                dc.b    0, 0, $C, $CC, $A, $88, 2, 0, 2, 2, 4, $24, 0, 2, 0, $20
                dc.b    4, $64, 2, $48, 4, $8C, 0, $24, 4, $20, 6, $42, 8, $66, 0, $2A
                dc.b    2, $1E, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, 8, $86, $E, $EC, $C, $CA
                dc.b    $E, $EC, $E, $EE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                dc.b    2, $22, $E, $CC, 2, $24, 2, $66, 4, $88, $C, $CC, 0, $44, 8, $AA
                dc.b    4, $46, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, 2, $44, 2, $42
byte_C00C:      dc.b    $22, 6, 8, $CC, 2, $44, 4, $66, 6, $88, 8, $AA, 4, $66, 6, $88
                                        ; DATA XREF: Boss_SylpheedIntroMove+16   o
byte_C01C:      dc.b    2, $1E, 0, 0, 0, $22, 2, $42, 6, $64, 0, $22, 2, $44, 4, $66
                                        ; DATA XREF: Boss_ArtemisIntroMove+1C   o
                dc.b    6, $88, $FF, $FF, 0, $22, 2, $44, 2, $66, 4, $AC, $A, $CE, $FF, $FF
                dc.b    0, 0, 0, 0, 2, 0, 2, $22, 6, $44, 2, 0, 4, 0, 6, 0
                dc.b    6, $20, 8, $42, $A, $64, $C, $86, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
byte_C05C:      binclude "data/other/byte_C05C.bin"
byte_C05C_End:
byte_C1A2:      dc.b    $62, $E, 0, 0, $E, $EE, $E, $A8, 0, 6, 0, $2A, 0, 0, 4, $6E
                                        ; DATA XREF: Gfx_LoadStagePalette   o
                                        ; sub_11EAA   o
                dc.b    0, $46, 2, $8A, 6, $CC, 2, $24, 4, $6A, 8, $AE, 6, $22, $A, $62
byte_C1C2:      dc.b    $62, $E, 0, 0, $E, $EE, 0, $EE, 0, $AE, 0, $6E, 0, $E, 0, 4
                                        ; DATA XREF: Cutscene_XiTigerActorSetup   o
                dc.b    0, $48, 2, $20, 4, $42, 8, $86, $C, $CA, 6, 0, 8, $40, $C, $84
byte_C1E2:      dc.b    $62, $E, $E, $EE, $F, $FF, $A, $26, $A, $AA, 8, $88, $F, $FF, 6, $66
                                        ; DATA XREF: Stage_LoadStage5Graphics+6   o
                dc.b    4, $44, 2, $22, $C, $AA, $A, $88, 8, $66, 6, $44, 4, $22, 0, 0
                dc.b    $62, 6, 0, 0, 2, $22, 2, $44, 4, $68, 8, $AC, 0, 0, $A, $CC
byte_C212:      dc.b    $62, $E, $E, $EE, $E, $AA, $A, $66, 6, $22, 4, 0, 0, 0, 0, $AE
                                        ; DATA XREF: Boss_DestroyerProtoInit+1C   o
                dc.b    0, $6C, 0, $28, 0, 0, 0, 4, 8, $CC, 6, $88, 4, $46, 2, $22
                dc.b    $22, $E, $E, $EE, $E, $AA, $A, $66, 6, $22, 4, 0, 0, 0, 0, $AE
                dc.b    0, $6C, 0, $28, 0, 0, 0, 4, 8, $CC, 6, $88, 4, $46, 2, $22
byte_C252:      dc.b    $62, $E, 0, 0, $E, $EE, $E, $CC, $C, $AA, $A, $88, 0, 0, 2, 2
                                        ; DATA XREF: ROM:stru_11366   o
                dc.b    6, 4, $C, $48, 2, $24, 4, $46, 4, $AA, 0, $A, 0, 6, 0, 2
byte_C272:      dc.b    $62, $E, 0, 0, $E, $EE, $E, $CC, $C, $AA, $A, $88, 0, 0, 0, 4
                                        ; DATA XREF: ROM:stru_1137A   o
                dc.b    0, $26, 0, $4A, 0, $6C, 2, $AE, 2, $22, 4, $44, 0, $2A, 4, $6E
byte_C292:      dc.b    $62, $E, 0, 0, $E, $EE, $E, $CC, $C, $AA, $A, $88, 0, 0, 2, 4
                                        ; DATA XREF: ROM:stru_1138E   o
                dc.b    0, $2A, 2, $6E, 4, $40, 0, $88, 8, $CC, 2, $24, 0, $48, 6, $8C
byte_C2B2:      dc.b    $62, $E, 0, 0, $C, $EE, $C, $CC, $A, $AA, 6, $66, 0, 0, 4, $8C
                                        ; DATA XREF: ROM:stru_113AA   o
                dc.b    2, $6A, 0, $48, 0, $26, 4, $6A, 2, $2A, 0, 4, 8, $88, 4, $44
byte_C2D2:      dc.b    $62, $E, 2, 2, $C, $EE, $A, $AA, 8, $88, 6, $66, 0, 0, 2, 4
                                        ; DATA XREF: ROM:stru_113B4   o
                dc.b    0, 8, 0, $C, 0, $4E, 8, $8E, 0, 6, 0, $48, 2, $8A, 4, $CC
byte_C2F2:      dc.b    $62, $E, 0, 0, $E, $EE, $E, $CC, $E, $AA, $E, $88, 0, 0, 4, $22
                                        ; DATA XREF: ROM:stru_113D0   o
                dc.b    6, $44, $C, $68, 2, 6, 4, $2C, 8, $8E, 0, $42, 2, $84, 2, $CA
byte_C312:      dc.b    $62, $D, 2, 2, $E, $EE, $A, $AA, 8, $88, 6, $66, 0, 0, 2, $22
                                        ; DATA XREF: ROM:stru_113EC   o
                dc.b    4, $24, 8, $42, $C, $60, $E, $C0, 0, $CE, 0, $6A, 0, $26
byte_C330:      dc.b    $62, $E, 0, 2, $C, $EE, 0, 0, 0, 0, 8, $66, 0, 0, 6, $20
                                        ; DATA XREF: Boss_FlyingNeoSetup+D0   o
                dc.b    2, 0, 4, $22, 0, 6, 0, $2A, 2, $6E, 0, $24, 2, $68, 6, $AC
                dc.b    $62, $E, 2, 0, $C, $CC, 0, 0, 0, 0, $A, $88, 0, 0, 8, $46
                dc.b    4, $24, 2, 2, 4, 2, $A, 6, 8, $6A, 4, $88, 2, $44, 0, $22
byte_C370:      dc.b    $62, $E, 2, 0, $E, $EE, 0, 0, 0, 0, 0, 0, 0, 0, $C, $CA
                                        ; DATA XREF: ROM:stru_11424   o
                dc.b    $A, $A6, $A, $64, 6, $42, 4, $8C, 0, $48, 0, 4, 2, $AC, 0, $46
byte_C390:      dc.b    $62, $E, 0, 0, $E, $EE, 8, $88, $E, $AA, $E, $88, $F, $FF, 4, 0
                                        ; DATA XREF: ROM:stru_11440   o
                dc.b    6, $20, 8, $40, $A, $62, $C, $A4, 2, 4, 2, 8, 2, $C, 4, $4E
byte_C3B0:      dc.b    $62, $E, 0, 0, $E, $EE, $C, $AA, $A, $88, 8, $66, $F, $FF, 6, $44
                                        ; DATA XREF: ROM:stru_11454   o
                dc.b    4, $22, 4, 0, $A, $22, $E, $66, 0, $24, 0, $46, 0, $8A, 0, $CE
byte_C3D0:      dc.b    $62, $E, 0, 0, $C, $EC, 8, $C8, 6, $64, 2, $20, $F, $FF, 8, $EE
                                        ; DATA XREF: ROM:stru_11468   o
                dc.b    4, $AA, 0, $66, 0, $22, 0, 4, 0, $28, 0, $4C, 4, $8E, 8, $CE
byte_C3F0:      dc.b    $62, 8, 0, 0, $E, $EE, 8, $CE, 6, $8C, 6, $6C, $F, $FF, 4, $26
                                        ; DATA XREF: Gfx_LoadSnakePalette   o
                dc.b    2, 2, 4, $4A
byte_C404:      dc.b    $62, $E, 0, 2, $E, $EE, $A, $AA, 6, $66, 2, $22, $F, $FF, $A, $EE
                                        ; DATA XREF: ROM:00011538   o
                                        ; UNUSED: Love Penguin boss palette
                                        ; Referenced by: Boss ID $01C0 (line 20999)
                dc.b    8, $CE, 6, $8C, 4, $6A, 2, $48, 0, $26, 0, 4, 0, 0, 0, $A
byte_C424:      dc.b    $62, $E, 0, 0, $E, $EE, $E, $CC, $E, $AA, $E, $88, $FF, $FF, $A, $46
                                        ; DATA XREF: ROM:stru_11498   o
                dc.b    6, 2, 6, $6E, 4, $2C, 2, 8, 2, 4, 2, $26, 0, $48, 0, $8C
byte_C444:      dc.b    $62, $E, 0, 0, $E, $EE, $E, $CC, $E, $AA, $E, $88, $F, $FF, 0, 6
                                        ; DATA XREF: ROM:stru_114B4   o
                dc.b    0, $2A, 4, $6E, 0, $22, 2, $44, 2, $88, 0, $26, 0, $48, 0, $8C
byte_C464:      dc.b    2, $E, 0, 2, 0, $26, 0, $6A, 0, 0, 0, 0, 0, 0, 2, $AE
                                        ; DATA XREF: Boss_ViblackInit+9A   o
                dc.b    4, $20, 6, $42, $A, $64, $C, $A8, $E, $CA, $E, $EC, 0, 0, $E, $EE
byte_C484:      dc.b    2, $E, 0, 2, 4, 6, 6, $28, 0, 0, 0, 0, 2, 0, 8, $4A
                                        ; DATA XREF: Boss_ViblackFinishTransitionState+3C   o
                dc.b    2, $20, 4, $42, 6, $66, 8, $88, $A, $AA, $A, $CC, 0, 0, $A, $AA
byte_C4A4:      dc.b    $22, $B, $E, $CA, $E, $C8, $E, $A6, $E, $84, $C, $62, $A, $40, 8, $20
                                        ; DATA XREF: Stage_ViblackPostBattleScroll2+3E   o
                dc.b    6, 0, 4, 0, 2, 0, 2, 0, 2, 0
byte_C4BE:      dc.b    $62, $E, 2, 0, $C, $EE, 2, $26, 8, $8A, 0, $24, $F, $FF, 0, $46
                                        ; DATA XREF: ROM:stru_114D0   o
                dc.b    2, $8A, 6, $CE, 0, $6E, 0, $2C, 0, 6, $F, $FF, 6, $68, $A, $AC
byte_C4DE:      dc.b    $62, $E, 2, 0, 4, 4, 6, $26, 8, $4A, $A, $6C, $F, $FF, $C, $AE
                                        ; DATA XREF: ROM:stru_11500   o
                                        ; Gfx_LoadStage17Palettes+C   o
                dc.b    $C, $CE, 0, $22, $E, $EE, 0, $46, 4, $8A, 6, $EE, 0, 0, 0, 0
                dc.b    2, $1E, 0, 0, 0, $22, 2, $44, $E, $EE, $A, $EA, 6, $E6, 2, $C2
                dc.b    0, $80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b    0, 0, 0, 0, 0, $24, 0, $46, 0, $68, 2, $8A, 4, $42, 6, $64
                dc.b    8, $86, $A, $AA, $E, $EE, 4, 0, 8, $22, $C, $66, $E, $88, 2, $20
                dc.b    $62, $E, 0, 0, $E, $EE, $E, $EC, $E, $A8, $E, $86, $E, $64, $E, $EC
                dc.b    $E, $CA, $E, $A8, $E, $86, $E, $64, $C, $42, $A, $20, 6, $20, 4, 0
byte_C55E:      dc.b    $62, $E, 0, 0, $E, $EE, $C, $CC, $A, $AA, 8, $88, $F, $FF, 6, $66
                                        ; DATA XREF: ROM:stru_114E4   o
                                        ; Boss_JampanReinitializePostDefeatObjectsState+6   o
                dc.b    0, $A, 0, $E, 2, 4, 2, $26, 2, $48, 4, $6A, 6, $8C, 8, $AE
byte_C57E:      dc.b    $62, $E, 0, 0, $E, $EE, 6, $E4, 0, $80, 0, $28, $F, $FF, 0, $6C
                                        ; DATA XREF: ROM:stru_1151C   o
                dc.b    0, $EA, 4, $22, 4, $46, 4, $88, 8, $CC, 0, 6, 2, $C, 6, $6E
byte_C59E:      dc.b    $62, $E, 0, 0, $E, $EE, 6, $AC, 4, $8A, 2, $68, $F, $FF, 2, $46
                                        ; DATA XREF: ROM:stru_1147C   o
                dc.b    0, $24, 2, 6, 2, $2A, 2, $6C, 0, 0, 2, 2, 6, $24, 8, $68
byte_C5BE:      dc.b    $62, $E, 0, 0, $E, $EE, $A, $AC, 2, $AC, 8, $EE, $F, $FF, 0, $48
                                        ; DATA XREF: ROM:stru_115A8   o
                                        ; UNUSED: Lambda Bunny boss palette
                                        ; Referenced by: stru_115A8 (Boss ID $03EC)
                                        ; See sub_E6D6 for loader function (line 16561)
                dc.b    0, 4, 2, 4, 2, $A, $C, $8E, 2, 2, 6, $44, $A, $A8, $E, $CA
byte_C5DE:      dc.b    $62, $E, 0, 0, $E, $EE, 0, 6, 0, $48, 0, $8C, $F, $FF, 4, 0
                                        ; DATA XREF: ROM:stru_115C4   o
                                        ; UNUSED: Unknown boss $3F0 palette
                                        ; Referenced by: stru_115C4 (Boss ID $3F0)
                                        ; See sub_E72C for loader function (line 16598)
                dc.b    $A, 0, $E, $20, $E, $60, $C, $AA, 8, $66, 6, $44, 4, $22, 0, $2E
byte_C5FE:      dc.b    $62, $E, 0, 0, $E, $EE, $E, $CA, $C, $86, $A, $42, $F, $FF, 4, 0
                                        ; DATA XREF: ROM:stru_115E0   o
                                        ; UNUSED: Unknown boss $3F4 palette
                                        ; Referenced by: stru_115E0 (Boss ID $3F4)
                                        ; See sub_E782 for loader function (line 16646)
                                        ; Possibly Praying Mantis or Sigma Fox
                dc.b    2, 2, 2, 6, 4, $2A, $A, $6E, 6, $CC, 2, $8A, 0, $46, 8, $20
                dc.b    $62, $E, 0, 0, $E, $EE, 2, 2, 4, $24, 6, $46, $F, $FF, 8, $68
                dc.b    $A, $8A, $C, $AC, $E, $CE, 0, 4, 0, 8, 0, $C, 2, $4E, 6, $8E
byte_C63E:      dc.b    $62, $E, 0, 0, $E, $EE, 2, $20, 4, $42, 4, $64, $F, $FF, 6, $AA
                                        ; DATA XREF: ROM:000115FC   o
                                        ; UNUSED: Dragon boss palette
                                        ; Referenced by: Boss ID $03FC (line 21104)
                dc.b    4, $CE, 2, $8C, 2, $6A, 2, $46, 4, $24, 4, $44, 6, $66, $A, $AA
                dc.b    $62, $E, 0, 0, $E, $EE, 8, $6E, 4, $2C, 2, 8, $F, $FF, 2, $24
                dc.b    0, $46, 2, $8A, 6, $CC, 0, $6E, 0, $2C, 0, 6, 2, 4, $A, $86
byte_C67E:      dc.b    $62, $E, 2, 4, $E, $EE, $A, $CA, 4, $66, 0, $44, $F, $FF, 2, $CE
                                        ; DATA XREF: ROM:stru_11658   o
                dc.b    0, $8C, 0, $8E, 0, $4C, 0, $2A, 2, 8, 0, $68, 6, $AE, $A, $EE
byte_C69E:      dc.b    $62, $E, 6, 0, $E, $EE, 6, $66, 4, $44, 4, $42, $F, $FF, $A, $AA
                                        ; DATA XREF: ROM:stru_1166C   o
                dc.b    8, $66, $E, $48, $C, $26, $A, $24, 8, 2, 0, $26, 0, $8C, $E, $AC
byte_C6BE:      dc.b    $62, $E, 2, $20, $E, $EE, 2, $8C, 0, $46, 2, $42, $F, $FF, 0, $C8
                                        ; DATA XREF: ROM:stru_1169E   o
                dc.b    0, $84, 4, $C6, 2, $84, 0, $62, 0, $42, 0, $40, 0, $6C, 4, $EA
byte_C6DE:      dc.b    $62, $E, 4, 2, $E, $EE, 6, $6C, 4, $48, 2, $24, $F, $FF, $A, $8A
                                        ; DATA XREF: ROM:stru_11680   o
                dc.b    6, $68, $C, $CA, $A, $88, 8, $66, 2, $22, 0, $28, 0, $6E, $C, $CC
byte_C6FE:      dc.b    $62, $E, 2, 2, $E, $EE, 6, $EE, 2, $8A, 2, $22, $F, $FF, $E, $A8
                                        ; DATA XREF: ROM:stru_11676   o
                dc.b    $A, $64, $E, $A8, $E, $62, $C, $22, 8, 2, 4, 2, 4, $84, $E, $EC
byte_C71E:      dc.b    $62, $E, 0, 2, $E, $EE, $E, $A4, 8, $62, 4, $22, $F, $FF, 0, $AC
                                        ; DATA XREF: ROM:stru_11694   o
                dc.b    0, $46, 4, $8E, 0, $4E, 0, $A, 0, 6, 0, 2, 0, $6C, 4, $EE
byte_C73E:      dc.b    $62, $E, 2, $22, $E, $EC, 0, $6C, 0, $26, 2, $22, $F, $FF, 4, $86
                                        ; DATA XREF: ROM:stru_1168A   o
                dc.b    2, $44, $A, $44, 4, $20, 2, 2, 2, 0, 0, 2, 0, $AE, 8, $AA
byte_C75E:      dc.b    $62, $E, 0, 0, $E, $EE, 6, $E4, 0, $80, 0, $28, $F, $FF, 0, $6C
                                        ; DATA XREF: ROM:stru_11568   o
                dc.b    0, $AE, 4, $22, 4, $46, 4, $88, 8, $CC, 0, 6, $C, $60, $E, $A6
byte_C77E:      dc.b    $62, $E, 0, 0, $A, $EE, 4, $CE, 0, $6C, 0, $2A, $F, $FF, 0, 6
                                        ; DATA XREF: ROM:stru_11554   o
                dc.b    2, $8E, 0, $4E, 0, $E, 0, $A, 2, 6, $E, $EE, $A, $24, $E, $A4
byte_C79E:      dc.b    $62, $E, 2, 0, $E, $EE, $E, $EC, $C, $AA, 8, $88, $F, $FF, 4, $44
                                        ; DATA XREF: ROM:stru_11584   o
                dc.b    2, $22, 0, $24, 0, $48, 2, $8E, 4, 2, 8, $24, $C, $6A, 0, $E
byte_C7BE:      dc.b    $62, $E, $E, $EE, $C, $AA, $A, $64, 8, $22, 4, 0, $F, $FF, 8, $CC
                                        ; DATA XREF: ROM:stru_1163C   o
                dc.b    4, $88, 2, $44, 2, $22, 8, $6E, 2, $E, 0, 6, 0, 0, $F, $FF
byte_C7DE:      dc.b    $62, $E, 0, 0, $E, $EE, $E, $88, 8, $44, 4, $22, $F, $FF, 2, 0
                                        ; DATA XREF: ROM:stru_11618   o
                dc.b    0, 2, 0, 4, 0, $24, 0, $46, 2, $68, 4, $AC, 6, $CE, 0, $AE
                dc.b    $62, $E, 0, 0, $E, $EE, $F, $FF, $F, $FF, 0, $28, 0, 8, 0, $6C
                dc.b    0, $AE, 4, 2, 6, $24, 8, $46, $C, $8A, 0, 6, 2, $C, 6, $6E
byte_C81E:      dc.b    $62, $E, 0, 0, $E, $EE, $A, $CE, 4, $8C, 2, $68, $FF, $FF, $A, $AA
                                        ; DATA XREF: Entity_SevenForcesIntro+36   o
                dc.b    6, $66, $E, $CC, $C, $AA, 8, $66, 6, $42, 4, $22, $E, $CC, $FF, $FF

; Main stage dispatcher jump table
