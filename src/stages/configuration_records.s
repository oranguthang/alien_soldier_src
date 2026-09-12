; Dispatches stage asset lists and applies the fixed-layout stage records
Stage_DispatchAssetListLoaderByGameMode:                ; CODE XREF: Stage_LoadStage1BaseAssets+A   j  ; was: CheckFlagsLoadObjData
                                        ; Stage_LoadStage1Phase1Assets+E   j
                cmpi.w  #$3C,(GameModeIndex).w          ; '<'
                beq.s   Stage_ProcessAssetListImmediately
                cmpi.w  #$C,(GameModeIndex).w
                beq.s   Stage_ProcessAssetListImmediately
                cmpi.w  #$10,(GameModeIndex).w
                beq.s   Stage_ProcessAssetListImmediately
                jmp     (Data_ProcessPointer).l
; ---------------------------------------------------------------------------
Stage_ProcessAssetListImmediately:                      ; CODE XREF: Stage_DispatchAssetListLoaderByGameMode+6   j  ; was: loc_12752
                                        ; Stage_DispatchAssetListLoaderByGameMode+E   j
                jmp     (LoadObjData).l
; End of function Stage_DispatchAssetListLoaderByGameMode

; Applies one 30-byte stage configuration record and loads its palette list
Stage_ApplyConfigurationRecord:                         ; CODE XREF: Stage_ApplyXiTigerConfiguration+6   p  ; was: sub_12758
                                        ; Stage_ApplyStage1Configuration+6   j
                move.w  (a0)+,(word_FFA950).w
                move.l  (a0)+,(StageObjectSpawnCursor).w
                move.w  (a0)+,(EnemySpawnDirectorState).w
                move.b  (a0)+,(PalettePrimaryIndex+1).w
                move.b  (a0)+,(PaletteSecondaryIndex+1).w
                move.w  (a0)+,(word_FF808A).w
                move.w  (a0)+,(dword_FFA900).w
                move.w  (a0)+,(dword_FFA904).w
                move.w  (a0)+,(dword_FFA908).w
                move.w  (a0)+,(dword_FFA90C).w
                move.w  (a0)+,(word_FF80AA).w
                move.w  (a0)+,(word_FF80AC).w
                moveq   #0,d0
                move.b  (a0)+,d0
                addi.w  #$80,d0
                move.w  d0,(dword_FFA410).w
                moveq   #0,d0
                move.b  (a0)+,d0
                addi.w  #$80,d0
                move.w  d0,(dword_FFA414).w
                movea.l (a0)+,a4
                jmp     Gfx_LoadMultiplePalettes
; End of function Stage_ApplyConfigurationRecord
; ---------------------------------------------------------------------------
; Stage configuration record layout:
; +$00 word -> word_FFA950
; +$02 long -> StageObjectSpawnCursor
; +$06 word -> EnemySpawnDirectorState
; +$08 byte -> PalettePrimaryIndex+1
; +$09 byte -> PaletteSecondaryIndex+1
; +$0A word -> word_FF808A
; +$0C/+0E/+10/+12 words -> dword_FFA900/904/908/90C
; +$14/+16 words -> word_FF80AA/AC
; +$18/+19 bytes, each biased by $80 -> words at dword_FFA410/414
; +$1A long -> palette offset list passed to Gfx_LoadMultiplePalettes
Stage1ConfigRecord: dc.w    0                           ; word_FFA950  ; was: stru_127A8
                                        ; DATA XREF: Stage_ApplyStage1Configuration   o
                dc.l    Stage1_ObjectSpawnList          ; StageObjectSpawnCursor
                dc.w    2                               ; EnemySpawnDirectorState
                dc.b    2                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $B0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    EarlyStagePaletteOffsetList     ; palette offset list pointer
Stage2ConfigRecord: dc.w    $A                          ; word_FFA950  ; was: stru_127C6
                                        ; DATA XREF: Stage_ApplyStage2Configuration   o
                dc.l    Stage2_ObjectSpawnList          ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    2                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    $700                            ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $B0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    EarlyStagePaletteOffsetList     ; palette offset list pointer
Stage3ConfigRecord: dc.w    $12                         ; word_FFA950  ; was: stru_127E4
                                        ; DATA XREF: Stage_ApplyStage3Configuration   o
                dc.l    Stage3_ObjectSpawnList          ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    2                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    $BC0                            ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $B0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    EarlyStagePaletteOffsetList     ; palette offset list pointer
Stage4ConfigRecord: dc.w    $22                         ; word_FFA950  ; was: stru_12802
                                        ; DATA XREF: Stage_ApplyStage4Configuration   o
                dc.l    Stage4_ObjectSpawnList          ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    4                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    $1200                           ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $B0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    ShellshogunStagePaletteOffsetList  ; palette offset list pointer
Stage5ConfigRecord: dc.w    $2E                         ; word_FFA950  ; was: stru_12820
                                        ; DATA XREF: Stage_ApplyStage5Configuration   o
                dc.l    Stage5_ObjectSpawnList          ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    6                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $B0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage5To7PaletteOffsetList      ; palette offset list pointer
Stage6ConfigRecord: dc.w    $38                         ; word_FFA950  ; was: stru_1283E
                                        ; DATA XREF: Stage_ApplyStage6Configuration   o
                dc.l    Stage6_ObjectSpawnList          ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    6                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    $480                            ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $B0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage5To7PaletteOffsetList      ; palette offset list pointer
Stage7ConfigRecord: dc.w    $40                         ; word_FFA950  ; was: stru_1285C
                                        ; DATA XREF: Stage_ApplyStage7Configuration   o
                dc.l    Stage7_ObjectSpawnList          ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    6                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    $AA0                            ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $B0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage5To7PaletteOffsetList      ; palette offset list pointer
Stage8ConfigRecord: dc.w    $50                         ; word_FFA950  ; was: stru_1287A
                                        ; DATA XREF: Stage_InitializeStage8   o
                dc.l    Stage8_ObjectSpawnList          ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    $C00                            ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    $730                            ; word at dword_FFA908
                dc.w    $F700                           ; word at dword_FFA90C
                dc.w    8                               ; word_FF80AA
                dc.w    8                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $A0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage8InitialPaletteOffsetList  ; palette offset list pointer
Stage9ConfigRecord: dc.w    $62                         ; word_FFA950  ; was: stru_12898
                                        ; DATA XREF: Stage_InitializeStage9   o
                dc.l    Stage9_EmptyObjectSpawnList     ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    $800                            ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    $C00                            ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    8                               ; word_FF80AA
                dc.w    8                               ; word_FF80AC
                dc.b    $60                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $A8                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    XiTigerAndStage9PaletteOffsetList  ; palette offset list pointer
Stage10ConfigRecord:    dc.w    0                       ; word_FFA950  ; was: stru_128B6
                                        ; DATA XREF: Stage_ApplyStage10Configuration   o
                dc.l    Stage10_ObjectSpawnList         ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    $FC00                           ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $78                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage10To13PaletteOffsetList    ; palette offset list pointer
Stage11ConfigRecord:    dc.w    $A                      ; word_FFA950  ; was: stru_128D4
                                        ; DATA XREF: Stage_ApplyStage11Configuration   o
                dc.l    Stage11_ObjectSpawnList         ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    $7B0                            ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    $FC00                           ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $A0                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $78                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage10To13PaletteOffsetList    ; palette offset list pointer
Stage12ConfigRecord:    dc.w    $14                     ; word_FFA950  ; was: stru_128F2
                                        ; DATA XREF: Stage_ApplyStage12Configuration   o
                dc.l    Stage12_ObjectSpawnList         ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    $10C0                           ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    $FC00                           ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $5C                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $70                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage10To13PaletteOffsetList    ; palette offset list pointer
Stage13ConfigRecord:    dc.w    $34                     ; word_FFA950  ; was: stru_12910
                                        ; DATA XREF: Stage_ApplyStage13Configuration   o
                dc.l    Stage_EmptyObjectSpawnList      ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    $FC00                           ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $80                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage10To13PaletteOffsetList    ; palette offset list pointer
Stage14ConfigRecord:    dc.w    $40                     ; word_FFA950  ; was: stru_1292E
                                        ; DATA XREF: Stage_ApplyStage14Configuration   o
                dc.l    Stage14_ObjectSpawnList         ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    $C                              ; PalettePrimaryIndex+1
                dc.b    4                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    $E100                           ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $58                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $90                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage14To16PaletteOffsetList    ; palette offset list pointer
Stage15ConfigRecord:    dc.w    $4A                     ; word_FFA950  ; was: stru_1294C
                                        ; DATA XREF: Stage_ApplyStage15Configuration   o
                dc.l    Stage15_ObjectSpawnList         ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    $C                              ; PalettePrimaryIndex+1
                dc.b    4                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    $480                            ; word at dword_FFA900
                dc.w    $E100                           ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $90                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage14To16PaletteOffsetList    ; palette offset list pointer
Stage16ConfigRecord:    dc.w    $56                     ; word_FFA950  ; was: stru_1296A
                                        ; DATA XREF: Stage_InitializeStage16   o
                dc.l    Stage_EmptyObjectSpawnList      ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    $C                              ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    $620                            ; word at dword_FFA900
                dc.w    $E440                           ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $A0                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $C0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage14To16PaletteOffsetList    ; palette offset list pointer
Stage17BossConfigRecord:    dc.w    $6C                 ; word_FFA950  ; was: stru_12988
                                        ; DATA XREF: Stage_InitializeStage17Boss+6   o
                dc.l    Stage_EmptyObjectSpawnList      ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    0                               ; word_FF80AA
                dc.w    8                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $80                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage17PaletteOffsetList        ; palette offset list pointer
Stage18ConfigRecord:    dc.w    0                       ; word_FFA950  ; was: stru_129A6
                                        ; DATA XREF: Stage_InitializeStage18   o
                dc.l    Stage18_ObjectSpawnList         ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    $8008                           ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $90                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage18And19PaletteOffsetList   ; palette offset list pointer
Stage19ConfigRecord:    dc.w    $A                      ; word_FFA950  ; was: stru_129C4
                                        ; DATA XREF: Stage_InitializeStage19   o
                dc.l    Stage19_ObjectSpawnList         ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    $D50                            ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    $8008                           ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $90                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage18And19PaletteOffsetList   ; palette offset list pointer
UnreferencedStage20Variant1ConfigRecord:    dc.w    $28  ; word_FFA950  ; was: stru_129E2
                                        ; DATA XREF: UnreferencedApplyStage20Variant1Configuration   o
                dc.l    $80000000                       ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    $10                             ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    8                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $90                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    UnreferencedStage20VariantPaletteOffsetList  ; palette offset list pointer
UnreferencedStage20Variant2ConfigRecord:    dc.w    $30  ; word_FFA950  ; was: stru_12A00
                                        ; DATA XREF: UnreferencedApplyStage20Variant2Configuration   o
                dc.l    $80000000                       ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    $10                             ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    8                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $90                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    UnreferencedStage20VariantPaletteOffsetList  ; palette offset list pointer
UnreferencedStage20Variant3ConfigRecord:    dc.w    $38  ; word_FFA950  ; was: stru_12A1E
                                        ; DATA XREF: UnreferencedApplyStage20Variant3Configuration   o
                dc.l    $80000000                       ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    $10                             ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    8                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $90                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    UnreferencedStage20VariantPaletteOffsetList  ; palette offset list pointer
UnreferencedStage20Variant4ConfigRecord:    dc.w    $40  ; word_FFA950  ; was: stru_12A3C
                                        ; DATA XREF: UnreferencedApplyStage20Variant4Configuration   o
                dc.l    $80000000                       ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    $10                             ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    8                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $90                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    UnreferencedStage20VariantPaletteOffsetList  ; palette offset list pointer
Stage20ConfigRecord:    dc.w    $70                     ; word_FFA950  ; was: stru_12A5A
                                        ; DATA XREF: Stage_InitializeStage20+18   o
                dc.l    $80000000                       ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    $600                            ; word at dword_FFA900
                dc.w    $F800                           ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    $F500                           ; word at dword_FFA90C
                dc.w    8                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $80                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    0                               ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage20PaletteOffsetLists       ; palette offset list pointer
Stage21ConfigRecord:    dc.w    0                       ; word_FFA950  ; was: stru_12A78
                                        ; DATA XREF: Stage_InitializeStage21+C   o
                dc.l    Stage_EmptyObjectSpawnList      ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    $E                              ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    $F800                           ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    $F100                           ; word at dword_FFA90C
                dc.w    8                               ; word_FF80AA
                dc.w    8                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $A0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage21And23PaletteOffsetList   ; palette offset list pointer
Stage22ConfigRecord:    dc.w    $2C                     ; word_FFA950  ; was: stru_12A96
                                        ; DATA XREF: Stage_InitializeStage22+C   o
                dc.l    Stage_EmptyObjectSpawnList      ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    $E                              ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    $F600                           ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    $F100                           ; word at dword_FFA90C
                dc.w    8                               ; word_FF80AA
                dc.w    8                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $A0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage22PaletteOffsetList        ; palette offset list pointer
Stage23ConfigRecord:    dc.w    $2E                     ; word_FFA950  ; was: stru_12AB4
                                        ; DATA XREF: Stage_InitializeStage23+C   o
                dc.l    Stage23_EmptyObjectSpawnList    ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    $12                             ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    $F3E0                           ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    8                               ; word_FF80AA
                dc.w    0                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $A0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage21And23PaletteOffsetList   ; palette offset list pointer
Stage24ConfigRecord:    dc.w    $40                     ; word_FFA950  ; was: stru_12AD2
                                        ; DATA XREF: Stage_ApplyStage24Configuration   o
                dc.l    Stage_EmptyObjectSpawnList      ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $A0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage24PaletteOffsetList        ; palette offset list pointer
UnreferencedFlaggedConfigRecordA:   dc.w    $4E         ; word_FFA950  ; was: stru_12AF0
                                        ; DATA XREF: UnreferencedApplyFlaggedConfigurationA+6   o
                dc.l    Stage_EmptyObjectSpawnList      ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $A0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    UnreferencedFlaggedPaletteOffsetListA  ; palette offset list pointer
UnreferencedFlaggedConfigRecordB:   dc.w    $62         ; word_FFA950  ; was: stru_12B0E
                                        ; DATA XREF: UnreferencedApplyFlaggedConfigurationB+6   o
                dc.l    Stage_EmptyObjectSpawnList      ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    0                               ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    $FF00                           ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $A0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    UnreferencedFlaggedPaletteOffsetListB  ; palette offset list pointer
Stage25ConfigRecord:    dc.w    $76                     ; word_FFA950  ; was: stru_12B2C
                                        ; DATA XREF: Stage_ApplyStage25Configuration   o
                dc.l    Stage25_ObjectSpawnList         ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    $FE00                           ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $60                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage25PaletteOffsetList        ; palette offset list pointer
Stage26ConfigRecord:    dc.w    $8A                     ; word_FFA950  ; was: stru_12B4A
                                        ; DATA XREF: Stage_ApplyStage26Configuration   o
                dc.l    Stage_EmptyObjectSpawnList      ; StageObjectSpawnCursor
                dc.w    0                               ; EnemySpawnDirectorState
                dc.b    0                               ; PalettePrimaryIndex+1
                dc.b    0                               ; PaletteSecondaryIndex+1
                dc.w    $8000                           ; word_FF808A
                dc.w    0                               ; word at dword_FFA900
                dc.w    0                               ; word at dword_FFA904
                dc.w    0                               ; word at dword_FFA908
                dc.w    0                               ; word at dword_FFA90C
                dc.w    4                               ; word_FF80AA
                dc.w    4                               ; word_FF80AC
                dc.b    $40                             ; byte biased by $80 -> word at dword_FFA410
                dc.b    $A0                             ; byte biased by $80 -> word at dword_FFA414
                dc.l    Stage26PaletteOffsetList        ; palette offset list pointer

Stage_InitializationNoOpHook:                           ; CODE XREF: Stage_InitializeXiTigerState+4   p  ; was: nullsub_1
                                        ; Sys_InitStageState+4   p
                rts
; End of function Stage_InitializationNoOpHook

; Renders HUD element health or ammo
