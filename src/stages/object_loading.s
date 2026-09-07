Stage_DispatchObjectLoader:                             ; CODE XREF: UI_InitializePasswordScreen+16   p  ; was: sub_11722
                                        ; Password_InitializeScreen+10   p
                bsr.w   Stage_LoadObjectData
                move.w  (StageTableIndex).w,d0
                movea.w off_11736(pc,d0.w),a0
                adda.l  #Stage_LoadObjectData,a0
                jmp     (a0)
; End of function Stage_DispatchObjectLoader
; ---------------------------------------------------------------------------
off_11736:      dc.w    Stage_LoadStage1Objects-Stage_LoadObjectData
                                        ; DATA XREF: Stage_DispatchObjectLoader+8   r
                dc.w    Stage_LoadStage1Objects-Stage_LoadObjectData
                dc.w    Stage_LoadStage1Objects-Stage_LoadObjectData
                dc.w    Stage_LoadStage1Phase1-Stage_LoadObjectData
                dc.w    Stage_LoadStage1Phase2-Stage_LoadObjectData
                dc.w    Stage_LoadStage1Phase2-Stage_LoadObjectData
                dc.w    Stage_LoadStage1Phase2-Stage_LoadObjectData
                dc.w    Stage_LoadStage8Objects-Stage_LoadObjectData
                dc.w    Stage_LoadStage1Phase3-Stage_LoadObjectData
                dc.w    Stage_LoadStage10Enemies-Stage_LoadObjectData
                dc.w    Stage_LoadStage10Enemies-Stage_LoadObjectData
                dc.w    Stage_LoadStage10Enemies-Stage_LoadObjectData
                dc.w    Stage_LoadTeleportGraphics-Stage_LoadObjectData
                dc.w    Stage_LoadStage16Objects-Stage_LoadObjectData
                dc.w    Stage_LoadStage16Objects-Stage_LoadObjectData
                dc.w    Stage_LoadStage16Objects-Stage_LoadObjectData
                dc.w    Stage_LoadStage2Phase1-Stage_LoadObjectData
                dc.w    Gfx_LoadStage18Palette-Stage_LoadObjectData
                dc.w    Gfx_LoadStage18Palette-Stage_LoadObjectData
                dc.w    Gfx_LoadStage20Tiles-Stage_LoadObjectData
                dc.w    Stage_LoadStage3Phase2-Stage_LoadObjectData
                dc.w    Stage_LoadStage3Phase2-Stage_LoadObjectData
                dc.w    Stage_LoadStage3Phase1-Stage_LoadObjectData
                dc.w    Stage_LoadStage3Phase3-Stage_LoadObjectData
                dc.w    Stage_LoadStage3Phase6-Stage_LoadObjectData
                dc.w    Stage_LoadStage3Phase7-Stage_LoadObjectData

; Loads stage object spawn data from table pointer
Stage_LoadObjectData:                                   ; CODE XREF: Stage_DispatchObjectLoader   p  ; was: sub_1176A
                                        ; DATA XREF: Stage_DispatchObjectLoader+C   o
                lea     stru_11776(pc),a0
                nop
                jmp     (LoadObjData).l
; End of function Stage_LoadObjectData
; ---------------------------------------------------------------------------
stru_11776:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_LoadObjectData   o
                dc.l    byte_18DF92                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    $FFFF

; Loads object data for stage 1 (Xi-Tiger)
Stage_LoadStage1Objects:                                ; CODE XREF: Stage_LoadStage1Phase1+4   p  ; was: sub_11780
                                        ; DATA XREF: ROM:off_11736   o
                clr.w   (word_FFA206).w
                lea     stru_11790(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc)       ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Objects
; ---------------------------------------------------------------------------
stru_11790:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_LoadStage1Objects+4   o
                dc.l    tiles_18E5D2                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_19051C                    ; field_2
                dc.w    $2B80                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_19BAB4                    ; field_2
                dc.w    $5AC0                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_192C38                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_193010                     ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_192F7C                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19382C                     ; field_2
                dc.w    $2000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19C724                     ; field_2
                dc.w    $7800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads initial object set for Stage 1 phase 1
Stage_LoadStage1Phase1:                                 ; DATA XREF: ROM:0001173C   o  ; was: sub_117E2
                clr.w   (word_FFA206).w
                bsr.w   Stage_LoadStage1Objects
                lea     stru_117F6(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc)       ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Phase1
; ---------------------------------------------------------------------------
stru_117F6:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_LoadStage1Phase1+8   o
                dc.l    tiles_1912EC                    ; field_2
                dc.w    $2B80                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_19BAB4                    ; field_2
                dc.w    $5AC0                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_192FC6                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_193DBE                     ; field_2
                dc.w    $2000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF
stru_11820:     dc.w    7                               ; field_0
                                        ; DATA XREF: Camera_ShellshogunBossInit+26   o
                dc.l    tiles_1912EC                    ; field_2
                dc.w    $2B80                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_19BAB4                    ; field_2
                dc.w    $5AC0                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_192FC6                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_193DBE                     ; field_2
                dc.w    $2000                           ; field_6
                dc.w    $FFFF

; Loads object set for Stage 1 phase 2
Stage_LoadStage1Phase2:                                 ; DATA XREF: ROM:0001173E   o  ; was: sub_11842
                                        ; ROM:00011740   o
                clr.w   (word_FFA206).w
                lea     stru_11852(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc)       ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Phase2
; ---------------------------------------------------------------------------
stru_11852:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_LoadStage1Phase2+4   o
                dc.l    tiles_1942B8                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_19BC68                    ; field_2
                dc.w    $5BE0                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19794C                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_197C28                     ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19C754                     ; field_2
                dc.w    $7800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads object data for stage 8 (train/Flying-Neo)
Stage_LoadStage8Objects:                                ; DATA XREF: ROM:00011744   o  ; was: sub_1188C
                clr.w   (word_FFA206).w
                lea     stru_1189C(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc)       ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage8Objects
; ---------------------------------------------------------------------------
stru_1189C:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_LoadStage8Objects+4   o
                dc.l    tiles_198E2C                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_19AEA6                    ; field_2
                dc.w    $3AC0                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_19BF9E                    ; field_2
                dc.w    $3D00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19AF40                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19B0F6                     ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads object set for Stage 1 phase 3
Stage_LoadStage1Phase3:                                 ; DATA XREF: ROM:00011746   o  ; was: sub_118D6
                clr.w   (word_FFA206).w
                lea     stru_118E6(pc),a0
                nop
                jmp     CheckFlagsLoadObjData(pc)       ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Phase3
; ---------------------------------------------------------------------------
stru_118E6:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_LoadStage1Phase3+4   o
                dc.l    tiles_198E2C                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_19AEA6                    ; field_2
                dc.w    $3AC0                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_19BF9E                    ; field_2
                dc.w    $3D00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19AF40                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19B0F6                     ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_140B0C                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_140B98                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    tiles_19AEA6                    ; field_2
                dc.w    $9600                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads Stage 10 enemy configuration
Stage_LoadStage10Enemies:                               ; DATA XREF: ROM:00011748   o  ; was: sub_11938
                                        ; ROM:0001174A   o
                move.w  #4,(word_FFA206).w
                lea     stru_1195A(pc),a0
                nop
                jsr     CheckFlagsLoadObjData(pc)       ; (pc)
                nop
                lea     byte_119BC(pc),a0
                nop
                move.w  #$A000,d0
                jmp     Stage_LoadShipGraphics
; End of function Stage_LoadStage10Enemies
; ---------------------------------------------------------------------------
stru_1195A:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_LoadStage10Enemies+6   o
                dc.l    tiles_19C77E                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_1A1026                    ; field_2
                dc.w    $4000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_104310                    ; field_2
                dc.w    $3720                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_104784                    ; field_2
                dc.w    $1840                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19FACA                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19FF2E                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A2840                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A2878                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7400                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A0FDA                     ; field_2
                dc.w    $7800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF
byte_119BC:     dc.b    $40, 0, $D1, $D2, $D3, $D5, $D6, $D7, $DC, $E4
                                        ; DATA XREF: Stage_LoadStage10Enemies+12   o
                dc.b    $FF, 0

; Loads graphics for teleport scene
Stage_LoadTeleportGraphics:                             ; CODE XREF: Stage_TeleportFadeIn+64   p  ; was: sub_119C8
                                        ; DATA XREF: ROM:0001174E   o
                move.w  #4,(word_FFA206).w
                lea     stru_119FA(pc),a0
                nop
                jsr     (LoadObjData).l
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9600-M68K_RAM),a1
                move.w  #$6000,(word_FF8048).w
                move.w  #$F,(word_FF804A).w
                move.w  #1,(dword_FF8044+2).w
                jmp     Gfx_LoadTilesLoop
; End of function Stage_LoadTeleportGraphics
; ---------------------------------------------------------------------------
stru_119FA:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_LoadTeleportGraphics+6   o
                dc.l    tiles_19C77E                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_19E8A8                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_1A1026                    ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19FE62                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A08DA                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A2840                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A2878                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7400                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A0FDA                     ; field_2
                dc.w    $7800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    tiles_120E1C                    ; field_2
                dc.w    $9600                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads object data for stage 16/17 (Sylpheed)
