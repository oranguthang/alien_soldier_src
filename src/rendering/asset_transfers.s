Stage_LoadShipGraphics:                                 ; CODE XREF: Stage_LoadStage10Enemies+1C   j  ; was: sub_11170
                                        ; Boss_ViblackInit+BC   p
                moveq   #$FFFFFFFF,d1
                move.w  (a0)+,d1
                movea.l d1,a1
                moveq   #5,d3
                bra.s   loc_11192
; ---------------------------------------------------------------------------
loc_1117A:                                              ; CODE XREF: Stage_LoadShipGraphics+2A   j
                asl.w   d3,d1
                moveq   #$F,d7
loc_1117E:                                              ; CODE XREF: Stage_LoadShipGraphics+1E   j
                move.w  (a1,d1.w),d2
                andi.w  #$1FFF,d2
                add.w   d0,d2
                move.w  d2,(a1,d1.w)
                addq.w  #2,d1
                dbf     d7,loc_1117E
loc_11192:                                              ; CODE XREF: Stage_LoadShipGraphics+8   j
                moveq   #0,d1
                move.b  (a0)+,d1
                cmpi.w  #$FF,d1
                bne.s   loc_1117A
                rts
; End of function Stage_LoadShipGraphics
; Adjusts tile pattern indices
Gfx_AdjustTileIndices:                                  ; CODE XREF: UI_InitTitleScreen+60   p  ; was: sub_1119E
                                        ; Boss_WolfGaropaGraphicsInit+8   j
                moveq   #$F,d6
loc_111A0:                                              ; CODE XREF: Gfx_AdjustTileIndices+C   j
                move.w  (a0),d2
                andi.w  #$1FFF,d2
                add.w   d0,d2
                move.w  d2,(a0)+
                dbf     d6,loc_111A0
                dbf     d7,Gfx_AdjustTileIndices
                rts
; End of function Gfx_AdjustTileIndices
; Updates tilemap tile indices and palette bits with offset
Gfx_UpdateTilemapIndices:                               ; CODE XREF: UI_InitTitleScreen+78   p  ; was: sub_111B4
                                        ; Boss_SireneSpawnProjectile2+2C   p
                moveq   #$F,d6
loc_111B6:                                              ; CODE XREF: Gfx_UpdateTilemapIndices+1C   j
                move.w  (a0),d2
                move.w  d2,d3
                andi.w  #$1800,d3
                andi.w  #$7FF,d2
                beq.s   loc_111CA
                add.w   d1,d2
                andi.w  #$7FF,d2
loc_111CA:                                              ; CODE XREF: Gfx_UpdateTilemapIndices+E   j
                or.w    d3,d2
                add.w   d0,d2
                move.w  d2,(a0)+
                dbf     d6,loc_111B6
                dbf     d7,Gfx_UpdateTilemapIndices
                rts
; End of function Gfx_UpdateTilemapIndices
; Transfers a single font tile to VRAM
VDP_TransferFontTile:                                   ; CODE XREF: UI_WeaponSelectTransition+10   p  ; was: sub_111DA
                tst.w   (word_FF8148).w
                bmi.w   locret_11254
                movea.w (word_FFF70C).w,a1
                move.w  (word_FF8146).w,d0
                move.w  d0,d1
                andi.w  #$3FFE,d0
                addi.w  #$4000,d0
                andi.w  #$C000,d1
                moveq   #$E,d2
                lsr.w   d2,d1
                addi.w  #$80,d1
                move.w  d1,-(a1)
                move.w  d0,-(a1)
                move.l  #$94029300,d4
                moveq   #0,d0
                move.w  (word_FF814A).w,d0
                addi.l  #tiles_font,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d2
                move.b  (dword_FF8040+1).w,d3
                andi.w  #$7F,d3
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d2,-(a1)
                move.b  #$96,-(a1)
                move.b  d3,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  d4,-(a1)
                move.w  a1,(word_FFF70C).w
                addi.w  #$400,(word_FF8146).w
                addi.w  #$400,(word_FF814A).w
                subq.w  #1,(word_FF8148).w
locret_11254:                                           ; CODE XREF: VDP_TransferFontTile+4   j
                rts
; End of function VDP_TransferFontTile
; Writes VDP command registers
Gfx_WriteVDPCommand:                                    ; CODE XREF: Sys_TransitionToStageInit+36   j  ; was: sub_11256
                                        ; UI_InitializeStageStart+46   j
                movea.w (word_FFF70C).w,a1
                move.w  #$80,-(a1)
                move.w  #$6000,-(a1)
                move.l  #$94209000,d4
                bra.s   loc_112A4
; End of function Gfx_WriteVDPCommand
; Sets up VDP command to transfer to palette RAM
VDP_SetupPaletteTransfer:                               ; CODE XREF: Stage_InitializeStageSelect+3E   j  ; was: sub_1126A
                movea.w (word_FFF70C).w,a1
                move.w  #$80,-(a1)
                move.w  #$6000,-(a1)
                move.l  #$94069300,d4
                bra.s   loc_112A4
; End of function VDP_SetupPaletteTransfer
; Queues VRAM write command for plane A at address 0x6000
Gfx_QueueVRAMCommand:                                   ; CODE XREF: RegionRestricted+1E   p  ; was: sub_1127E
                                        ; UI_InitTitleScreen+44   j
                movea.w (word_FFF70C).w,a1
                move.w  #$81,-(a1)
                move.w  #$6000,-(a1)
                move.l  #$94209000,d4
                bra.s   loc_112A4
; End of function Gfx_QueueVRAMCommand
; Queues DMA transfer for font tiles to VRAM with Z80 sync
Gfx_QueueFontDMATransfer:                               ; CODE XREF: UI_InitializePasswordScreen+10   p  ; was: sub_11292
                                        ; UI_InitializePasswordScreen+32   p
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                move.w  #$5400,-(a1)
                move.l  #$94059300,d4
loc_112A4:                                              ; CODE XREF: Gfx_WriteVDPCommand+12   j
                                        ; VDP_SetupPaletteTransfer+12   j
                move.l  #tiles_font,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d2
                move.b  (dword_FF8040+1).w,d3
                andi.w  #$7F,d3
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d2,-(a1)
                move.b  #$96,-(a1)
                move.b  d3,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  d4,-(a1)
                move    sr,-(sp)
                move    #$2700,sr
loc_112DA:                                              ; CODE XREF: Gfx_QueueFontDMATransfer+50   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_112DA
                lea     (VDP_CTRL).l,a0
                move.w  (word_FFF7D2).w,d0
                bset    #4,d0
                move.w  d0,(a0)
                move.l  (a1)+,(a0)
                move.l  (a1)+,(a0)
                move.l  (a1)+,(a0)
                move.w  (a1)+,(a0)
                move.w  (a1)+,(a0)
                move.w  (word_FFF7D2).w,d0
                bclr    #4,d0
                move.w  d0,(a0)
; Releases Z80 bus control and restores status register
Gfx_ReleaseZ80Bus:                                      ; CODE XREF: Gfx_QueueFontDMATransfer+7E   j  ; was: loc_11308
                bclr    #0,(IO_Z80BUS).l
                beq.s   Gfx_ReleaseZ80Bus
                move    (sp)+,sr
                rts
; End of function Gfx_QueueFontDMATransfer
; ---------------------------------------------------------------------------
dword_11316:    dc.l    $FFFF7000, $FFFF6000, $FFFF4000, $14000
                                        ; DATA XREF: UI_InitTitleScreen+7E   o
                                        ; sub_106FE   o
dword_11326:    dc.l    $FFFF7000, $FFFF6000, $FFFF4000, $4000
                                        ; DATA XREF: Cutscene_InitCreditsScreen+4A   o
                                        ; Cutscene_SegaScreenFadeOut+4A   o
dword_11336:    dc.l    $FFFF7000, $FFFF6800, $FFFF2000, $6000
                                        ; DATA XREF: UI_InitTitleScreen+96   o
                                        ; UI_InitOptionsScreen+56   o
dword_11346:    dc.l    $FFFF7000, $FFFF6000, $FFFF4000, $6000
                                        ; DATA XREF: Gfx_FadeToTargetAndSetupScroll+1E   o
                                        ; Cutscene_ShipInitScene+8C   o
                dc.l    $FFFF7400, $FFFF6800, $FFFF4000, $14000
stru_11366:     dc.w    $E4                             ; field_0
                                        ; DATA XREF: Stage_InitBossIntro+28   o
                dc.l    stru_11370                      ; field_2
                dc.l    byte_C252                       ; field_6
stru_11370:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11366   o
                dc.l    tiles_1067C2                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF
stru_1137A:     dc.w    $30                             ; field_0
                                        ; DATA XREF: Camera_TransitionToBossArena+28   o
                dc.l    stru_11384                      ; field_2
                dc.l    byte_C272                       ; field_6
stru_11384:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_1137A   o
                dc.l    tiles_1081AA                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF
stru_1138E:     dc.w    $F4                             ; field_0
                                        ; DATA XREF: Camera_LockToBossArena+28   o
                dc.l    stru_11398                      ; field_2
                dc.l    byte_C292                       ; field_6
stru_11398:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_1138E   o
                dc.l    tiles_10B9FE                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_113AA:     dc.w    $24                             ; field_0
                                        ; DATA XREF: Camera_FollowTarget+34   o
                dc.l    0                               ; field_2
                dc.l    byte_C2B2                       ; field_6
stru_113B4:     dc.w    $118                            ; field_0
                                        ; DATA XREF: Boss_MadamBarbarScrollInit+2A   o
                dc.l    stru_113BE                      ; field_2
                dc.l    byte_C2D2                       ; field_6
stru_113BE:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_113B4   o
                dc.l    tiles_112288                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_113D0:     dc.w    $15C                            ; field_0
                                        ; DATA XREF: Stage_InitJokerBoss+2A   o
                dc.l    stru_113DA                      ; field_2
                dc.l    byte_C2F2                       ; field_6
stru_113DA:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_113D0   o
                dc.l    tiles_113934                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_113EC:     dc.w    $B4                             ; field_0
                                        ; DATA XREF: Stage_InitTerobusterBoss+50   o
                dc.l    stru_113F6                      ; field_2
                dc.l    byte_C312                       ; field_6
stru_113F6:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_113EC   o
                dc.l    tiles_109546                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_11408:     dc.w    $154                            ; field_0
                                        ; DATA XREF: Stage_FlyingNeoBattleStart+A   o
                dc.l    stru_11412                      ; field_2
                dc.l    0                               ; field_6
stru_11412:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11408   o
                dc.l    tiles_114DF8                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_11424:     dc.w    $114                            ; field_0
                                        ; DATA XREF: Stage_InitXiTigerBoss+3A   o
                dc.l    stru_1142E                      ; field_2
                dc.l    byte_C370                       ; field_6
stru_1142E:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11424   o
                dc.l    tiles_116C9C                    ; field_2
                dc.w    $5000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_11440:     dc.w    $19C                            ; field_0
                                        ; DATA XREF: Stage_DeepStriderTransition+26   o
                dc.l    stru_1144A                      ; field_2
                dc.l    byte_C390                       ; field_6
stru_1144A:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11440   o
                dc.l    tiles_11B542                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF
stru_11454:     dc.w    $1B0                            ; field_0
                                        ; DATA XREF: Stage_GustheadTransition+26   o
                dc.l    stru_1145E                      ; field_2
                dc.l    byte_C3B0                       ; field_6
stru_1145E:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11454   o
                dc.l    tiles_11E5E0                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF
stru_11468:     dc.w    $21C                            ; field_0
                                        ; DATA XREF: Stage_SharpssteelTransition+12   o
                dc.l    stru_11472                      ; field_2
                dc.l    byte_C3D0                       ; field_6
stru_11472:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11468   o
                dc.l    tiles_11F310                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF
stru_1147C:     dc.w    $300                            ; field_0
                                        ; DATA XREF: Stage_BugmaxWaitDMA+38   o
                dc.l    stru_11486                      ; field_2
                dc.l    byte_C59E                       ; field_6
stru_11486:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_1147C   o
                dc.l    tiles_12AB8C                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_11498:     dc.w    $3C0                            ; field_0
                                        ; DATA XREF: Stage_InitBossPaletteScroll+24   o
                dc.l    stru_114A2                      ; field_2
                dc.l    byte_C424                       ; field_6
stru_114A2:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11498   o
                dc.l    tiles_120FF8                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_114B4:     dc.w    $1EC                            ; field_0
                                        ; DATA XREF: Stage_SunsetStingTransition+2E   o
                dc.l    stru_114BE                      ; field_2
                dc.l    byte_C444                       ; field_6
stru_114BE:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_114B4   o
                dc.l    tiles_11D002                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_114D0:     dc.w    $314                            ; field_0
                                        ; DATA XREF: Boss_ViblackTransitionTimerState+14   o
                dc.l    stru_114DA                      ; field_2
                dc.l    byte_C4BE                       ; field_6
stru_114DA:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_114D0   o
                dc.l    tiles_121932                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF
stru_114E4:     dc.w    $218                            ; field_0
                                        ; DATA XREF: Stage_JampanPostBattle+28   o
                                        ; Stage_InitBossPhase1+1A   o
                dc.l    stru_114EE                      ; field_2
                dc.l    byte_C55E                       ; field_6
stru_114EE:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_114E4   o
                dc.l    tiles_12453E                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_11500:     dc.w    $264                            ; field_0
                                        ; DATA XREF: Stage_Epsilon1BattleStart+8   o
                dc.l    stru_1150A                      ; field_2
                dc.l    byte_C4DE                       ; field_6
stru_1150A:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11500   o
                dc.l    tiles_1233B4                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_1151C:     dc.w    $240                            ; field_0
                                        ; DATA XREF: Stage_DestroyerMK2Init+30   o
                dc.l    stru_11526                      ; field_2
                dc.l    byte_C57E                       ; field_6
stru_11526:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_1151C   o
                dc.l    tiles_124CCE                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
; UNUSED BOSS: "Love Penguin" ($01C0) - Hand-shaped boss
; Source: TCRF https://tcrf.net/Alien_Soldier
; Graphics: tiles_11A8FC (stru_11542), Palette: byte_C404
; Never referenced by stage dispatcher
; Activation: ROM 0x00036C: 4E71 4E71, ROM 0x01147C: 01C0 00 01 15 42 00 00 C4 04
; (YouTube: Zetaman, 28 Oct 2021)
                dc.w    $1C0                            ; Boss ID: Love Penguin (UNUSED)
                dc.l    stru_11542                      ; Graphics structure pointer
                dc.l    byte_C404                       ; Palette data pointer
stru_11542:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:00011538   o
                dc.l    tiles_11A8FC                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_11554:     dc.w    $34C                            ; field_0
                                        ; DATA XREF: Boss_ShieldViperInit+14   o
                dc.l    stru_1155E                      ; field_2
                dc.l    byte_C77E                       ; field_6
stru_1155E:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11554   o
                dc.l    tiles_1338F2                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF
stru_11568:     dc.w    $3B8                            ; field_0
                                        ; DATA XREF: Boss_DestroyerProtoTransition+10   o
                dc.l    stru_11572                      ; field_2
                dc.l    byte_C75E                       ; field_6
stru_11572:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11568   o
                dc.l    tiles_13963E                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1402E2                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_11584:     dc.w    $3E8                            ; field_0
                                        ; DATA XREF: Boss_WolfGaropaIntroMove+14   o
                dc.l    stru_1158E                      ; field_2
                dc.l    byte_C79E                       ; field_6
stru_1158E:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11584   o
                dc.l    tiles_1355D6                    ; field_2
                dc.w    $3C00                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_136512                    ; field_2
                dc.w    $5100                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_140F00                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
; ===============================================================================
; UNUSED BOSS STRUCTURE: Lambda Bunny ($03EC)
; Source: TCRF https://tcrf.net/Alien_Soldier
; Description: Cowboy rabbit boss, fully defined but never used in any stage
; Loader Function: sub_E6D6 (line 16524)
; Graphics Data: tiles_125902 (7 chunks to VRAM $6000)
; Palette Data: byte_C5BE
; Status: Complete structure, never referenced by stage dispatcher
; Activation: ROM 0x00036C: 4E71 4E71, ROM 0x0113B4: 03EC 00 01 15 B2 00 00 C5 BE
; (YouTube: Zetaman, 2 Nov 2021 - shows unused gun firing animation)
; ===============================================================================
stru_115A8:     dc.w    $3EC                            ; Boss ID: Lambda Bunny (UNUSED)
                                        ; DATA XREF: Stage_InitBossPhase2+1A   o
                dc.l    stru_115B2                      ; Graphics structure pointer
                dc.l    byte_C5BE                       ; Palette data pointer
stru_115B2:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_115A8   o
                dc.l    tiles_125902                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1402E2                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
; ===============================================================================
; UNUSED BOSS STRUCTURE: Unknown Boss ($3F0)
; Source: TCRF research
; Description: Unknown boss type, fully defined but never used
; Loader Function: sub_E72C (line 16555)
; Graphics Data: tiles_12772E (7 chunks to VRAM $6000)
; Palette Data: byte_C5DE
; Status: Complete structure, identity unknown, never referenced
; ===============================================================================
stru_115C4:     dc.w    $3F0                            ; Boss ID: Unknown (UNUSED)
                                        ; DATA XREF: Stage_InitBossPhase3+1A   o
                dc.l    stru_115CE                      ; Graphics structure pointer
                dc.l    byte_C5DE                       ; Palette data pointer
stru_115CE:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_115C4   o
                dc.l    tiles_12772E                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1402E2                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
; ===============================================================================
; UNUSED BOSS STRUCTURE: Unknown Boss ($3F4)
; Source: TCRF research / YouTube (Zetaman)
; Description: Unknown boss type, possibly Praying Mantis or Sigma Fox
; Loader Function: sub_E782 (line 16639)
; Graphics Data: tiles_12E96C (7 chunks to VRAM $6000)
; Palette Data: byte_C5FE
; Status: Complete structure, identity unknown, never referenced
; Note: May be related to unused Jampan Area stages
; ===============================================================================
stru_115E0:     dc.w    $3F4                            ; Boss ID: Unknown (UNUSED)
                                        ; DATA XREF: Stage_InitBossPhase4+1A   o
                dc.l    stru_115EA                      ; Graphics structure pointer
                dc.l    byte_C5FE                       ; Palette data pointer
stru_115EA:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_115E0   o
                dc.l    tiles_12E96C                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1402E2                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
; UNUSED BOSS: "Dragon" ($03FC)
; Source: TCRF https://tcrf.net/Alien_Soldier
; Graphics: tiles_12D012 (stru_11606), Palette: byte_C63E
; Never referenced by stage dispatcher
                dc.w    $3FC                            ; Boss ID: Dragon (UNUSED)
                dc.l    stru_11606                      ; Graphics structure pointer
                dc.l    byte_C63E                       ; Palette data pointer
stru_11606:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:000115FC   o
                dc.l    tiles_12D012                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1402E2                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_11618:     dc.w    $3F8                            ; field_0
                                        ; DATA XREF: Boss_ZLeoTransition+2A   o
                dc.l    stru_11622                      ; field_2
                dc.l    byte_C7DE                       ; field_6
stru_11622:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11618   o
                dc.l    tiles_13A92A                    ; field_2
                dc.w    $5000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_13C166                    ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_141018                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_1163C:     dc.w    $3D0                            ; field_0
                                        ; DATA XREF: Boss_MissirayTransition+10   o
                dc.l    stru_11646                      ; field_2
                dc.l    byte_C7BE                       ; field_6
stru_11646:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_1163C   o
                dc.l    tiles_134F02                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1402E2                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
stru_11658:     dc.w    $42C                            ; field_0
                                        ; DATA XREF: Entity_SevenForcesValkirieFadeInStateC+36   o
                dc.l    stru_11662                      ; field_2
                dc.l    byte_C67E                       ; field_6
stru_11662:     dc.w    7                               ; field_0
                                        ; DATA XREF: ROM:stru_11658   o
                                        ; ROM:stru_11694   o
                dc.l    tiles_130B4E                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF
stru_1166C:     dc.w    $430                            ; field_0
                                        ; DATA XREF: Entity_SevenForcesStartMedusaEntranceState10+4A   o
                dc.l    0                               ; field_2
                dc.l    byte_C69E                       ; field_6
stru_11676:     dc.w    $434                            ; field_0
                                        ; DATA XREF: Entity_SevenForcesSireneHoldState2E+1A   o
                dc.l    0                               ; field_2
                dc.l    byte_C6FE                       ; field_6
stru_11680:     dc.w    $438                            ; field_0
                                        ; DATA XREF: Entity_SevenForcesStartArtemisEntranceState22+78   o
                dc.l    0                               ; field_2
                dc.l    byte_C6DE                       ; field_6
stru_1168A:     dc.w    $43C                            ; field_0
                                        ; DATA XREF: Entity_SevenForcesSirenePaletteEventState34+1C   o
                dc.l    0                               ; field_2
                dc.l    byte_C73E                       ; field_6
stru_11694:     dc.w    $440                            ; field_0
                                        ; DATA XREF: Entity_SevenForcesSirenePaletteEventState32+1C   o
                dc.l    stru_11662                      ; field_2
                dc.l    byte_C71E                       ; field_6
stru_1169E:     dc.w    $444                            ; field_0
                                        ; DATA XREF: Entity_SevenForcesStartSylpheedEntranceState18+50   o
                dc.l    0                               ; field_2
                dc.l    byte_C6BE                       ; field_6

; Updates boss palette with fade or flash effect
Gfx_UpdateBossPalette:                                  ; CODE XREF: Stage_InitBossIntro+2E   j  ; was: sub_116A8
                                        ; Camera_TransitionToBossArena+2E   j
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
loc_116AC:                                              ; CODE XREF: Boss_ViblackTransitionTimerState+1A   p
                moveq   #0,d0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.w  (a1)+,-$60(a0)
                movea.l (a1)+,a0
                move.l  (a1)+,(dword_FF8040).w
                move.b  #6,(byte_FF80EC).w
                bset    #7,(dword_FFA20E).w
                clr.w   (word_FF8114).w
                bset    #0,(byte_FFA272).w
                move.l  a0,d0
                beq.s   loc_11708
                jsr     (Data_ProcessPointer).l
loc_11708:                                              ; CODE XREF: Gfx_UpdateBossPalette+58   j
                move.l  (dword_FF8040).w,(dword_FF8040).w
                beq.s   locret_11720
                movea.l (dword_FF8040).w,a0
                jsr     (Gfx_SyncPaletteBuffers).l
                jmp     (Data_LoadPaletteTable).l
; ---------------------------------------------------------------------------
locret_11720:                                           ; CODE XREF: Gfx_UpdateBossPalette+66   j
                rts
; End of function Gfx_UpdateBossPalette
; Dispatches to stage-specific object data loader
