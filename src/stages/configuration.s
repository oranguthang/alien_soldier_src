Sys_InitStageState:                                     ; CODE XREF: Stage_LoadBackgroundGraphics+32   p  ; was: sub_1221C
                clr.w   (word_FF807A).w
                jsr     (Stage_InitializationNoOpHook).l
                bsr.w   Sys_ClearRAMBuffer
                clr.w   (word_FFFF3E).w
                move.w  (WeaponStateIndex).w,d0
                beq.s   loc_12242
                cmpi.w  #$10,d0
                bpl.s   loc_12242
                asl.w   #1,d0
                move.w  d0,(word_FFA21E).w
                bra.s   loc_1224E
; ---------------------------------------------------------------------------
loc_12242:                                              ; CODE XREF: Sys_InitStageState+16   j
                                        ; Sys_InitStageState+1C   j
                move.w  #2,(WeaponStateIndex).w
                move.w  #4,(word_FFA21E).w
loc_1224E:                                              ; CODE XREF: Sys_InitStageState+24   j
                bsr.s   Stage_DispatchInitializer
                jsr     (Gfx_ProcessPaletteSlots).l
                jmp     Player_InitializeStats
; End of function Sys_InitStageState
; Dispatches to stage-specific initialization routine
Stage_DispatchInitializer:                              ; CODE XREF: Sys_InitStageState:loc_1224E   p  ; was: sub_1225C
                move.w  (StageTableIndex).w,d0
                movea.w off_1226C(pc,d0.w),a0
                adda.l  #Sys_ClearRAMBuffer,a0
                jmp     (a0)
; End of function Stage_DispatchInitializer
; ---------------------------------------------------------------------------
off_1226C:      dc.w    Stage_InitStage1Data-Sys_ClearRAMBuffer
                                        ; DATA XREF: Stage_DispatchInitializer+4   r
                dc.w    Stage_InitStage2Data-Sys_ClearRAMBuffer
                dc.w    Stage_LoadStage2ConfigAlt-Sys_ClearRAMBuffer
                dc.w    Stage_LoadStage2Config2-Sys_ClearRAMBuffer
                dc.w    Stage_LoadStage2Config3-Sys_ClearRAMBuffer
                dc.w    Stage_LoadStage2Config4-Sys_ClearRAMBuffer
                dc.w    Stage_LoadStage2Config5-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage8Data-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage8Palettes-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage10Data-Sys_ClearRAMBuffer
                dc.w    Stage_LoadStage10ConfigAlt-Sys_ClearRAMBuffer
                dc.w    Stage_LoadStage11Config-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage12Data-Sys_ClearRAMBuffer
                dc.w    Stage_LoadStage13ConfigAlt-Sys_ClearRAMBuffer
                dc.w    Stage_LoadStage14Config-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage16Data-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage17Boss-Sys_ClearRAMBuffer
                dc.w    Gfx_Stage18Foreground-Sys_ClearRAMBuffer
                dc.w    Stage_LoadStage18ConfigAlt-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage25Tilemap-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage26Config-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage27Config-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage28Config-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage29Config-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage32Config-Sys_ClearRAMBuffer
                dc.w    Stage_InitStage33Config-Sys_ClearRAMBuffer

; Clears 4-word RAM buffer used for temporary data storage
Sys_ClearRAMBuffer:                                     ; CODE XREF: Stage_InitializeXiTigerState+A   p  ; was: sub_122A0
                                        ; Sys_InitStageState+A   p
                                        ; DATA XREF:
                movea.w #(byte_FFA258-M68K_RAM),a0
                moveq   #3,d7
loc_122A6:                                              ; CODE XREF: Sys_ClearRAMBuffer+8   j
                clr.w   (a0)+
                dbf     d7,loc_122A6
                rts
; End of function Sys_ClearRAMBuffer
; Initializes stage 1 data structure and palette
Stage_InitStage1Data:                                   ; DATA XREF: ROM:off_1226C   o  ; was: sub_122AE
                lea     Stage1ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage1Data
; Initializes stage 2 data structure and palette
Stage_InitStage2Data:                                   ; DATA XREF: ROM:0001226E   o  ; was: sub_122B8
                lea     Stage2ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage2Data
; Loads alternate configuration for stage 2
Stage_LoadStage2ConfigAlt:                              ; DATA XREF: ROM:00012270   o  ; was: sub_122C2
                lea     Stage2AlternateConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_LoadStage2ConfigAlt
; Loads second configuration for stage 2
Stage_LoadStage2Config2:                                ; DATA XREF: ROM:00012272   o  ; was: sub_122CC
                lea     Stage2SecondConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_LoadStage2Config2
; Loads third configuration for stage 2
Stage_LoadStage2Config3:                                ; DATA XREF: ROM:00012274   o  ; was: sub_122D6
                lea     Stage2ThirdConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_LoadStage2Config3
; Loads fourth configuration for stage 2
Stage_LoadStage2Config4:                                ; DATA XREF: ROM:00012276   o  ; was: sub_122E0
                lea     Stage2FourthConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_LoadStage2Config4
; Loads fifth configuration for stage 2
Stage_LoadStage2Config5:                                ; DATA XREF: ROM:00012278   o  ; was: sub_122EA
                lea     Stage2FifthConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_LoadStage2Config5
; Initializes stage 8 data with special scroll buffer setup
Stage_InitStage8Data:                                   ; DATA XREF: ROM:0001227A   o  ; was: sub_122F4
                lea     Stage8ConfigRecord(pc),a0
                nop
                bsr.w   Stage_ApplyConfigurationRecord
                move.w  #$81E0,(word_FF5000).l
                lea     (word_FF0480).l,a0
                lea     (word_FF0500).l,a1
                lea     (word_FF0C00).l,a2
                moveq   #$C,d1
                moveq   #$3F,d7                         ; '?'
loc_1231C:                                              ; CODE XREF: Stage_InitStage8Data+2E   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                dbf     d7,loc_1231C
                move.b  #$82,(byte_FF780C).l
                rts
; End of function Stage_InitStage8Data
; Initializes stage 8 with palette clearing
Stage_InitStage8Palettes:                               ; DATA XREF: ROM:0001227C   o  ; was: sub_12330
                lea     Stage8AlternatePaletteConfigRecord(pc),a0
                nop
                bsr.w   Stage_ApplyConfigurationRecord
loc_1233A:                                              ; CODE XREF: Stage_ApplyXiTigerConfiguration+A   j
                jsr     (Boss_FlyingNeoClearPaletteHighBits).l
loc_12340:                                              ; CODE XREF: Stage_InitStage9Flies+86   j
                lea     (word_FF0C80).l,a0
                lea     (word_FF0D00).l,a1
                lea     (word_FF0D80).l,a2
                lea     (word_FF0E00).l,a3
                moveq   #$D,d1
                moveq   #$3F,d7                         ; '?'
loc_1235C:                                              ; CODE XREF: Stage_InitStage8Palettes+34   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                move.w  d1,(a3)+
                dbf     d7,loc_1235C
                move.b  #$82,(byte_FF780D).l
                rts
; End of function Stage_InitStage8Palettes
; Initializes stage 10 data structure and palette
Stage_InitStage10Data:                                  ; DATA XREF: ROM:0001227E   o  ; was: sub_12372
                lea     Stage10ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage10Data
; Loads alternate configuration for stage 10
Stage_LoadStage10ConfigAlt:                             ; DATA XREF: ROM:00012280   o  ; was: sub_1237C
                lea     Stage10AlternateConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_LoadStage10ConfigAlt
; Loads configuration data for stage 11
Stage_LoadStage11Config:                                ; DATA XREF: ROM:00012282   o  ; was: sub_12386
                lea     Stage11ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_LoadStage11Config
; Applies the Stage 12 configuration selected by StageTableIndex $18
Stage_InitStage12Data:                                  ; DATA XREF: ROM:00012284   o  ; was: sub_12390
                lea     Stage12ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage12Data
; Loads Stage 13 tile graphics
Stage_LoadStage13Graphics:                              ; CODE XREF: Stage_Stage13Init+1A   p  ; was: sub_1239A
                                        ; Stage_InitStage13+1A   p
                lea     (dword_FF7800).l,a0
                moveq   #0,d0
                moveq   #$37,d7                         ; '7'
loc_123A4:                                              ; CODE XREF: Stage_LoadStage13Graphics+C   j
                move.l  d0,(a0)+
                dbf     d7,loc_123A4
                rts
; End of function Stage_LoadStage13Graphics
; Loads alternate configuration for stage 13
Stage_LoadStage13ConfigAlt:                             ; DATA XREF: ROM:00012286   o  ; was: sub_123AC
                lea     Stage13AlternateConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_LoadStage13ConfigAlt
; Loads configuration data for stage 14
Stage_LoadStage14Config:                                ; DATA XREF: ROM:00012288   o  ; was: sub_123B6
                lea     Stage14ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_LoadStage14Config
; Initializes stage 16 data with camera bounds setup
Stage_InitStage16Data:                                  ; DATA XREF: ROM:0001228A   o  ; was: sub_123C0
                lea     Stage16ConfigRecord(pc),a0
                nop
                bsr.w   Stage_ApplyConfigurationRecord
                move.w  #$620,(word_FFA970).w
                move.w  #$6A0,(word_FFA974).w
                bset    #6,(byte_FF8245).w
                rts
; End of function Stage_InitStage16Data
; Initializes stage 17 boss with sprites
Stage_InitStage17Boss:                                  ; DATA XREF: ROM:0001228C   o  ; was: sub_123DE
                move.w  #4,(word_FFA206).w
                lea     Stage17BossConfigRecord(pc),a0
                nop
                bsr.w   Stage_ApplyConfigurationRecord
                lea     (word_FF0C00).l,a0
                lea     (word_FF0C80).l,a1
                lea     (word_FF0D00).l,a2
                lea     (word_FF0D80).l,a3
                move.w  #$2FF,d1
                moveq   #$3F,d7                         ; '?'
loc_1240C:                                              ; CODE XREF: Stage_InitStage17Boss+36   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                move.w  d1,(a3)+
                dbf     d7,loc_1240C
                move.b  #$82,(byte_FF7AFF).l
                move.b  #4,(VDPReg11Shadow+1).w
                move.b  #3,(byte_FFA95B).w
                clr.w   (word_FFA970).w
                clr.w   (word_FFA974).w
                move.w  #$A,(PalettePrimaryIndex).w
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                move.w  #$40,(RasterEffectIndex).w      ; '@'
                clr.w   (RasterEffectInitState).w
                movea.w #(byte_FFEC12-M68K_RAM),a0
                moveq   #$FFFFFFF0,d0
                moveq   #$B,d7
loc_12452:                                              ; CODE XREF: Stage_InitStage17Boss+78   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_12452
                move.w  #$484,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
                lea     word_1249A(pc),a0
                nop
                jsr     (Tilemap_QueueIndexedRows).l
                move.w  #$81,d0
                moveq   #3,d7
                jsr     (VDPQueue_SetCommandHighWord).l
                lea     stru_12488(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_InitStage17Boss
; ---------------------------------------------------------------------------
stru_12488:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_InitStage17Boss+9E   o
                dc.l    tiles_1233B4                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A9AD8                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
word_1249A:     dc.w    $4E00, $4000, $900, $292A, $2B2C, $2D2E, $2F30, $3132
                                        ; DATA XREF: Stage_InitStage17Boss+86   o

; Foreground graphics setup
Gfx_Stage18Foreground:                                  ; DATA XREF: ROM:0001228E   o  ; was: sub_124AA
                lea     Stage18ForegroundConfigRecord(pc),a0
                nop
                bsr.w   Stage_ApplyConfigurationRecord
loc_124B4:                                              ; CODE XREF: Stage_LoadStage18ConfigAlt+10   j
                movea.l #$FFFF2000,a0
                move.w  #0,d0
                move.w  #$150,d1
                move.w  #$7F,d7
                jmp     Gfx_UpdateTilemapIndices
; End of function Gfx_Stage18Foreground
; Loads alternate configuration for stage 18
Stage_LoadStage18ConfigAlt:                             ; DATA XREF: ROM:00012290   o  ; was: sub_124CC
                lea     Stage18AlternateConfigRecord(pc),a0
                nop
                bsr.w   Stage_ApplyConfigurationRecord
                jsr     (locret_E4FA).l
                bra.s   loc_124B4
; End of function Stage_LoadStage18ConfigAlt
; Loads first configuration for stage 20
Stage_LoadStage20Config1:
                lea     Stage20FirstConfigRecord(pc),a0  ; was: sub_124DE
                nop
                bra.s   loc_124EC
; End of function Stage_LoadStage20Config1
; Loads second configuration for stage 20
Stage_LoadStage20Config2:
                lea     Stage20SecondConfigRecord(pc),a0  ; was: sub_124E6
                nop
loc_124EC:                                              ; CODE XREF: Stage_LoadStage20Config1+6   j
                                        ; Stage_LoadStage20Config3+6   j
                bsr.w   Stage_ApplyConfigurationRecord
                lea     (word_FF0D00).l,a0
                lea     (word_FF0D80).l,a1
                lea     (word_FF0E00).l,a2
                lea     (word_FF0E80).l,a3
                move.w  #$300,d1
                moveq   #$3F,d7                         ; '?'
loc_1250E:                                              ; CODE XREF: Stage_LoadStage20Config2+30   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                move.w  d1,(a3)+
                dbf     d7,loc_1250E
                move.b  #$82,(byte_FF7B00).l
                rts
; End of function Stage_LoadStage20Config2
; Loads third configuration for stage 20
Stage_LoadStage20Config3:
                lea     Stage20ThirdConfigRecord(pc),a0  ; was: sub_12524
                nop
                bra.w   loc_124EC
; End of function Stage_LoadStage20Config3
; Loads fourth configuration for stage 20
Stage_LoadStage20Config4:
                lea     Stage20FourthConfigRecord(pc),a0  ; was: sub_1252E
                nop
                bra.w   loc_124EC
; End of function Stage_LoadStage20Config4
; Initializes stage 25 tilemap and camera
Stage_InitStage25Tilemap:                               ; DATA XREF: ROM:00012292   o  ; was: sub_12538
                lea     (dword_FF4000).l,a0
                move.w  #$8000,d0
                move.w  #$180,d1
                move.w  #$BF,d7
                jsr     (Gfx_UpdateTilemapIndices).l
                lea     Stage25ConfigRecord(pc),a0
                nop
                bsr.w   Stage_ApplyConfigurationRecord
                move.w  #$180,(dword_FFA410).w
                addi.w  #$20,(dword_FFA900).w           ; ' '
                move.w  (dword_FFA900).w,(word_FFA928).w
                rts
; End of function Stage_InitStage25Tilemap
; Initializes stage 26 configuration with flags
Stage_InitStage26Config:                                ; DATA XREF: ROM:00012294   o  ; was: sub_1256E
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                lea     Stage26ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage26Config
; Initializes stage 27 configuration with flags
Stage_InitStage27Config:                                ; DATA XREF: ROM:00012296   o  ; was: sub_12584
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                lea     Stage27ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage27Config
; Initializes stage 28 configuration with flags
Stage_InitStage28Config:                                ; DATA XREF: ROM:00012298   o  ; was: sub_1259A
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                lea     Stage28ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage28Config
; Initializes stage 29 configuration
Stage_InitStage29Config:                                ; DATA XREF: ROM:0001229A   o  ; was: sub_125B0
                lea     Stage29ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage29Config
; Sets system flag and initializes stage 30
Stage_InitStage30Config:
                bset    #1,(byte_FF8144).w              ; was: sub_125BA
                lea     Stage30ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage30Config
; Sets system flag and initializes stage 31
Stage_InitStage31Config:
                bset    #1,(byte_FF8144).w              ; was: sub_125CA
                lea     Stage31ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage31Config
; Initializes stage 32 configuration
Stage_InitStage32Config:                                ; DATA XREF: ROM:0001229C   o  ; was: sub_125DA
                lea     Stage32ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage32Config
; Initializes stage 33 configuration
Stage_InitStage33Config:                                ; DATA XREF: ROM:0001229E   o  ; was: sub_125E4
                lea     Stage33ConfigRecord(pc),a0
                nop
                bra.w   Stage_ApplyConfigurationRecord
; End of function Stage_InitStage33Config
; Builds the Stage 3 phase-2 resampling steps, transforms its tiles, and uploads them
Gfx_PrepareStage3Phase2ResampledTiles:                  ; CODE XREF: Stage_LoadStage3Phase2Assets+12   p  ; was: sub_125EE
                movea.w #(word_FF9800-M68K_RAM),a0
                move.l  #$600000,d0
                move.w  #$2000,d1
                move.w  #$1A0,d3
                moveq   #$5F,d7                         ; '_'
Gfx_BuildStage3Phase2ScaleStepTable:                    ; CODE XREF: Gfx_PrepareStage3Phase2ResampledTiles+20   j  ; was: loc_12602
                move.l  d0,d2
                divu.w  d1,d2
                ext.l   d2
                asl.l   #8,d2
                move.l  d2,(a0)+
                add.w   d3,d1
                dbf     d7,Gfx_BuildStage3Phase2ScaleStepTable
                move.l  #byte_1C09B2,(dword_FF8040).w
                move.l  #$FFFF9800,(dword_FF8058).w
                move.w  #$5F,(word_FF8048).w            ; '_'
                move.w  #3,(word_FF804A).w
                bsr.w   Gfx_ResampleStage3Phase2Tiles
                movea.l #$FFFF0000,a0
                move.w  #$3C00,d5
                move.l  #$93009412,d4
                jmp     Stage22_GraphicsUpdate2
; End of function Gfx_PrepareStage3Phase2ResampledTiles
