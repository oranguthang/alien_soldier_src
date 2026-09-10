Cutscene_SevenForcesWinInit:                            ; DATA XREF: ROM:0000E4CC   o  ; was: sub_EA76
                bsr.w   Cutscene_SevenForcesCamera2
                bsr.w   Cutscene_SevenForcesCamera1
                tst.b   (byte_FFA958).w
                beq.s   loc_EA8C
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_EA8C:                                               ; CODE XREF: Cutscene_SevenForcesWinInit+C   j
                                        ; sub_EAA4:loc_EAB6   j
                tst.w   (dword_FFA960+2).w
                beq.s   loc_EA9E
                subq.w  #8,(dword_FFA960+2).w
                addq.w  #8,(word_FFA970).w
                subq.w  #8,(word_FFA974).w
loc_EA9E:                                               ; CODE XREF: Cutscene_SevenForcesWinInit+1A   j
                bsr.w   Camera_UpdateTowardsPlayer
                rts
; End of function Cutscene_SevenForcesWinInit
; Cutscene state handler 1
Cutscene_SevenForcesState1:                             ; DATA XREF: ROM:0000E4CE   o  ; was: sub_EAA4
                bsr.w   Cutscene_SevenForcesCamera2
                tst.b   (byte_FFA958).w
                beq.s   loc_EAB6
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_EAB6:                                               ; CODE XREF: Cutscene_SevenForcesState1+8   j
                bra.w   loc_EA8C
; End of function Cutscene_SevenForcesState1
; Cutscene state handler 2
Cutscene_SevenForcesState2:                             ; DATA XREF: ROM:0000E4D0   o  ; was: sub_EABA
                addi.l  #$78000,(dword_FFA90C).w
                bsr.w   loc_EA8C
                tst.b   (byte_FFA958).w
                beq.s   locret_EAD8
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                bsr.w   Cutscene_SevenForcesLoadGraphics
locret_EAD8:                                            ; CODE XREF: Cutscene_SevenForcesState2+10   j
                rts
; End of function Cutscene_SevenForcesState2
; Cutscene state handler 3
Cutscene_SevenForcesState3:                             ; DATA XREF: ROM:0000E4D2   o  ; was: sub_EADA
                addi.l  #$78000,(dword_FFA90C).w
                bsr.w   loc_EA8C
                bsr.w   Gfx_InitTilemapUpdate
                bmi.s   locret_EAF0
                addq.w  #2,(word_FFA950).w
locret_EAF0:                                            ; CODE XREF: Cutscene_SevenForcesState3+10   j
                rts
; End of function Cutscene_SevenForcesState3
; Cutscene state handler 4
Cutscene_SevenForcesState4:                             ; DATA XREF: ROM:0000E4D4   o  ; was: sub_EAF2
                addi.l  #$78000,(dword_FFA90C).w
                bsr.w   loc_EA8C
                bsr.w   Cutscene_SevenForcesCheckComplete
                bpl.s   locret_EB18
                addq.w  #2,(word_FFA950).w
                clr.w   (dword_FFA900).w
                clr.w   (word_FFA928).w
                clr.w   (dword_FFA904).w
                clr.w   (word_FFA92C).w
locret_EB18:                                            ; CODE XREF: Cutscene_SevenForcesState4+10   j
                rts
; End of function Cutscene_SevenForcesState4
; Cutscene state handler 5
Cutscene_SevenForcesState5:                             ; DATA XREF: ROM:0000E4D6   o  ; was: sub_EB1A
                andi.w  #$1FF,(dword_FFA90C).w
                addi.l  #$78000,(dword_FFA90C).w
                cmpi.w  #$200,(dword_FFA90C).w
                bmi.s   loc_EB44
                andi.w  #$1FF,(dword_FFA90C).w
                addi.w  #-$1C00,(dword_FFA90C).w
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_EB44:                                               ; CODE XREF: Cutscene_SevenForcesState5+14   j
                bra.w   Cutscene_SevenForcesEmptyState
; End of function Cutscene_SevenForcesState5
; Cutscene state handler 6
Cutscene_SevenForcesState6:                             ; DATA XREF: ROM:0000E4D8   o  ; was: sub_EB48
                bsr.w   Cutscene_SevenForcesEmptyState
                bsr.w   Cutscene_SevenForcesCamera3
                tst.b   (byte_FFA958).w
                beq.s   locret_EB5A
                addq.w  #2,(word_FFA950).w
locret_EB5A:                                            ; CODE XREF: Cutscene_SevenForcesState6+C   j
                rts
; End of function Cutscene_SevenForcesState6
; Empty cutscene state for Seven Forces sequence
Cutscene_SevenForcesEmptyState:                         ; CODE XREF: Cutscene_SevenForcesState5:loc_EB44   j  ; was: nullsub_27
                                        ; sub_EB48   p
                                        ; DATA XREF:
                rts
; End of function Cutscene_SevenForcesEmptyState
; Updates camera position and calculates scroll
Camera_UpdateScrollPosition:
                bsr.w   Camera_UpdateTowardsPlayer      ; was: sub_EB5E
                bsr.w   Gfx_CalculateScrollPosition
                move.w  (dword_FFA908).w,d0
                addi.w  #$40,d0                         ; '@'
                neg.w   d0
                move.w  d0,(word_FFE400).w
                move.w  (dword_FFA900).w,(dword_FFA908).w
                rts
; End of function Camera_UpdateScrollPosition
; Checks boss defeat and triggers stage transition
Stage_CheckBossTransition:
                tst.w   (word_FF8230).w                 ; was: sub_EB7C
                bne.w   Stage_Stage18EmptyHandler
                tst.w   (word_FF8138).w
                bne.w   Stage_Stage18EmptyHandler
                move.b  #$93,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w   Stage_InitTransitionState
; End of function Stage_CheckBossTransition
; Camera control for Medusa
Stage_MedusaCamera:                                     ; CODE XREF: Stage_MedusaTransition:loc_E854   j  ; was: sub_EB9E
                addi.l  #$200,(dword_FF9610).w
                cmpi.w  #2,(dword_FF9610).w
                bmi.s   loc_EBB6
                move.l  #$20000,(dword_FF9610).w
loc_EBB6:                                               ; CODE XREF: Stage_MedusaCamera+E   j
                move.l  (dword_FF9610).w,d0
                sub.l   d0,(dword_FFA900).w
loc_EBBE:                                               ; CODE XREF: Stage_SylpheedTransition+1A   j
                bpl.s   loc_EBD2
                addi.w  #$800,(dword_FFA900).w
                addi.w  #$800,(word_FFA928).w
                move.w  #1,(word_FF9804).w
loc_EBD2:                                               ; CODE XREF: Stage_MedusaCamera:loc_EBBE   j
                move.w  (dword_FFA900).w,d0
                subi.w  #$10,d0
                bpl.s   loc_EBE0
                addi.w  #$800,d0
loc_EBE0:                                               ; CODE XREF: Stage_MedusaCamera+3C   j
                move.w  (dword_FFA904).w,d1
                jsr     (Gfx_RenderTilemap).l
                move.w  (dword_FFA900).w,d0
                subi.w  #$10,d0
                bpl.s   loc_EBF8
                addi.w  #$800,d0
loc_EBF8:                                               ; CODE XREF: Stage_MedusaCamera+54   j
                move.w  (dword_FFA904).w,d1
                subi.w  #$C00,d1
                jsr     (loc_108A4).l
loc_EC06:                                               ; CODE XREF: Stage_Stage20Scroll+12   j
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                asr.w   #1,d0
                move.w  d0,d1
                asr.w   #1,d1
                movea.w #(byte_FFE482-M68K_RAM),a0
                moveq   #$20,d6                         ; ' '
                moveq   #6,d7
loc_EC1A:                                               ; CODE XREF: Stage_MedusaCamera+80   j
                move.w  d0,(a0)
                adda.w  d6,a0
                dbf     d7,loc_EC1A
                moveq   #7,d7
loc_EC24:                                               ; CODE XREF: Stage_MedusaCamera+8A   j
                move.w  d1,(a0)
                adda.w  d6,a0
                dbf     d7,loc_EC24
                moveq   #8,d7
loc_EC2E:                                               ; CODE XREF: Stage_MedusaCamera+94   j
                move.w  d0,(a0)
                adda.w  d6,a0
                dbf     d7,loc_EC2E
                rts
; End of function Stage_MedusaCamera
; Camera lock handler
Stage_SylpheedCameraLock:                               ; CODE XREF: Stage_SylpheedCameraUpdate   p  ; was: sub_EC38
                move.l  (dword_FF9614).w,d0
                subi.l  #$2000,d0
                cmpi.l  #$FFF88000,d0
                bpl.s   loc_EC50
                move.l  #$FFF88000,d0
loc_EC50:                                               ; CODE XREF: Stage_SylpheedCameraLock+10   j
                move.l  d0,(dword_FF9614).w
                add.l   d0,(dword_FFA904).w
                cmpi.w  #$F600,(dword_FFA904).w
                bpl.s   loc_EC66
                move.b  #1,(byte_FFA958).w
loc_EC66:                                               ; CODE XREF: Stage_SylpheedCameraLock+26   j
                move.w  (dword_FFA900).w,d0
                subi.w  #$60,d0                         ; '`'
                bpl.s   loc_EC74
                addi.w  #$800,d0
loc_EC74:                                               ; CODE XREF: Stage_SylpheedCameraLock+36   j
                move.w  (dword_FFA904).w,d1
                subi.w  #$F8,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Stage_SylpheedCameraLock
; Loads Sylpheed tiles
Gfx_LoadSylpheedTiles:                                  ; CODE XREF: Stage_SylpheedCameraUpdate+4   p  ; was: sub_EC86
                                        ; sub_E8AA   p
                bsr.s   Gfx_LoadSylpheedPalette
                cmpi.w  #$F400,(dword_FFA90C).w
                bpl.s   loc_EC96
                move.b  #1,(byte_FFA958).w
loc_EC96:                                               ; CODE XREF: Gfx_LoadSylpheedTiles+8   j
                moveq   #0,d0
                move.w  (dword_FFA90C).w,d1
                subi.w  #$F8,d1
                lea     (dword_11336).l,a0
                bra.w   loc_109E0
; End of function Gfx_LoadSylpheedTiles
; Loads Sylpheed palette
Gfx_LoadSylpheedPalette:                                ; CODE XREF: Stage_SylpheedGraphicsUpdate:loc_E8D4   p  ; was: sub_ECAA
                                        ; sub_EC86   p
                move.l  (dword_FF961C).w,d0
                subi.l  #$1000,d0
                cmpi.l  #$FFF88000,d0
                bpl.s   loc_ECC2
                move.l  #$FFF88000,d0
loc_ECC2:                                               ; CODE XREF: Gfx_LoadSylpheedPalette+10   j
                move.l  d0,(dword_FF961C).w
                add.l   d0,(dword_FFA90C).w
                rts
; End of function Gfx_LoadSylpheedPalette
; Plane update handler
Gfx_ArtemisPlaneUpdate:                                 ; CODE XREF: Gfx_ArtemisBackground   p  ; was: sub_ECCC
                subi.w  #6,(dword_FFA904).w
                cmpi.w  #$E200,(dword_FFA904).w
                bpl.s   loc_ECE0
                move.w  #$E200,(dword_FFA904).w
loc_ECE0:                                               ; CODE XREF: Gfx_ArtemisPlaneUpdate+C   j
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                addi.w  #$100,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Gfx_ArtemisPlaneUpdate
; Tile update handler
Gfx_ArtemisTileUpdate:                                  ; CODE XREF: Gfx_ArtemisForeground   p  ; was: sub_ECF4
                tst.w   (dword_FF8066).w
                bne.s   loc_ED12
                subi.l  #$E00,(dword_FFA904).w
                cmpi.w  #$E1F8,(dword_FFA904).w
                bpl.s   locret_ED10
                move.w  #2,(dword_FF8066).w
locret_ED10:                                            ; CODE XREF: Gfx_ArtemisTileUpdate+14   j
                                        ; Gfx_ArtemisTileUpdate+36   j
                rts
; ---------------------------------------------------------------------------
loc_ED12:                                               ; CODE XREF: Gfx_ArtemisTileUpdate+4   j
                bpl.s   loc_ED1C
                addi.l  #$12000,(dword_FFA904).w
loc_ED1C:                                               ; CODE XREF: Gfx_ArtemisTileUpdate:loc_ED12   j
                addi.l  #$E00,(dword_FFA904).w
                cmpi.w  #$E206,(dword_FFA904).w
                bmi.s   locret_ED10
                clr.w   (dword_FF8066).w
                rts
; End of function Gfx_ArtemisTileUpdate
; Graphics initialization
Stage_SireneGraphicsInit:                               ; CODE XREF: Stage_SireneUpdate1+6   p  ; was: sub_ED32
                move.l  (dword_FF9614).w,d0
                addi.l  #$200,d0
                cmpi.l  #$8000,d0
                bmi.s   loc_ED4A
                move.l  #$8000,d0
loc_ED4A:                                               ; CODE XREF: Stage_SireneGraphicsInit+10   j
                move.l  d0,(dword_FF9614).w
                add.l   d0,(dword_FFA904).w
                cmpi.w  #$E4C0,(dword_FFA904).w
                bmi.s   loc_ED6A
                move.b  #1,(byte_FFA958).w
                move.w  #8,(word_FFA010).w
                bsr.w   Stage_ClearRAMFlag
loc_ED6A:                                               ; CODE XREF: Stage_SireneGraphicsInit+26   j
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                addi.w  #$100,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Stage_SireneGraphicsInit
; Loads Sirene palette
Gfx_LoadSirenePalette:                                  ; CODE XREF: Stage_SireneUpdate2+6   p  ; was: sub_ED7E
                move.l  (dword_FF961C).w,d0
                add.l   d0,(dword_FFA904).w
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                subi.w  #$100,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Gfx_LoadSirenePalette
; Loads Sirene tiles
Gfx_LoadSireneTiles:                                    ; CODE XREF: Stage_SireneUpdate1+2   p  ; was: sub_ED9A
                                        ; Stage_SireneUpdate2+2   p
                move.l  (dword_FF961C).w,d0
                subi.l  #$100,d0
                cmpi.l  #$FFFFC000,d0
                bpl.s   loc_EDB2
                move.l  #$FFFFC000,d0
loc_EDB2:                                               ; CODE XREF: Gfx_LoadSireneTiles+10   j
                move.l  d0,(dword_FF961C).w
                add.l   d0,(dword_FFA90C).w
                cmpi.w  #$E340,(dword_FFA90C).w
                bpl.s   loc_EDC8
                move.b  #1,(byte_FFA958).w
loc_EDC8:                                               ; CODE XREF: Gfx_LoadSireneTiles+26   j
                move.w  #$200,d0
                move.w  (dword_FFA90C).w,d1
                subi.w  #$100,d1
                lea     (dword_11336).l,a0
                bra.w   loc_109E0
; End of function Gfx_LoadSireneTiles
nullsub_28:
                rts
; End of function nullsub_28

; Camera scroll handler 1
Cutscene_SevenForcesCamera1:                            ; CODE XREF: Cutscene_SevenForcesWinInit+4   p  ; was: sub_EDE0
                addi.l  #$78000,(dword_FFA904).w
                cmpi.w  #$E520,(dword_FFA904).w
                bmi.s   loc_EDF6
                move.b  #1,(byte_FFA958).w
loc_EDF6:                                               ; CODE XREF: Cutscene_SevenForcesCamera1+E   j
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                addi.w  #$F8,d1
                lea     (dword_11326).l,a0
                bra.w   loc_109E0
; End of function Cutscene_SevenForcesCamera1
; Camera scroll handler 2
Cutscene_SevenForcesCamera2:                            ; CODE XREF: Cutscene_SevenForcesWinInit   p  ; was: sub_EE0A
                                        ; sub_EAA4   p
                addi.l  #$78000,(dword_FFA90C).w
                cmpi.w  #$E4F8,(dword_FFA90C).w
                bmi.s   loc_EE20
                move.b  #1,(byte_FFA958).w
loc_EE20:                                               ; CODE XREF: Cutscene_SevenForcesCamera2+E   j
                move.w  #$200,d0
                move.w  (dword_FFA90C).w,d1
                addi.w  #$F8,d1
                lea     (dword_11336).l,a0
                bra.w   loc_109E0
; End of function Cutscene_SevenForcesCamera2
; Camera scroll handler 3
Cutscene_SevenForcesCamera3:                            ; CODE XREF: Cutscene_SevenForcesState6+4   p  ; was: sub_EE36
                addi.l  #$78000,(dword_FFA90C).w
                cmpi.w  #$E700,(dword_FFA90C).w
                bmi.s   loc_EE4C
                move.b  #1,(byte_FFA958).w
loc_EE4C:                                               ; CODE XREF: Cutscene_SevenForcesCamera3+E   j
                move.w  #$200,d0
                move.w  (dword_FFA90C).w,d1
                addi.w  #$F8,d1
                lea     (dword_11336).l,a0
                bra.w   loc_109E0
; End of function Cutscene_SevenForcesCamera3
; Camera position update
Stage_ArtemisCameraUpdate:                              ; CODE XREF: Stage_SylpheedGraphicsUpdate+10   j  ; was: sub_EE62
                bsr.w   Boss_ArtemisShootPattern1
                bset    #6,(byte_FF8245).w
                move.w  #$60,(dword_FFA900).w           ; '`'
                move.w  #$60,(word_FFA928).w            ; '`'
                move.w  #$E300,(dword_FFA904).w
                move.w  #$E300,(word_FFA92C).w
                clr.w   (dword_FFA908).w
                move.w  #$E400,(dword_FFA90C).w
                move.w  (dword_FFA900).w,(word_FFA970).w
                move.w  (dword_FFA900).w,(word_FFA974).w
                lea     stru_EEA6(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_ArtemisCameraUpdate
; ---------------------------------------------------------------------------
stru_EEA6:      dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_ArtemisCameraUpdate+38   o
                dc.l    tiles_1B6F86                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_1B8CBC                    ; field_2
                dc.w    $1F00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1BB632                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1BB6A4                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B82E8                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B83A8                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF

; Camera lock handler
Stage_ArtemisCameraLock:                                ; CODE XREF: Stage_ArtemisTransition   p  ; was: sub_EED8
                tst.w   (word_FFF720).w
                bmi.s   locret_EF26
                movea.l #$FFFF4020,a0
                move.w  #0,d0
                move.w  #$F8,d1
                moveq   #$47,d7                         ; 'G'
                jsr     (Gfx_UpdateTilemapIndices).l
                movea.l #$FFFF4920,a0
                move.w  #$A000,d0
                move.w  #$F8,d1
                moveq   #1,d7
                jsr     (Gfx_UpdateTilemapIndices).l
                move.l  #dword_11336,(dword_FFA940).w
                move.w  #$200,(word_FFA946).w
                move.w  #$E400,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                moveq   #1,d0
locret_EF26:                                            ; CODE XREF: Stage_ArtemisCameraLock+4   j
                rts
; End of function Stage_ArtemisCameraLock
; Graphics initialization
Stage_ArtemisGraphicsInit:                              ; CODE XREF: Stage_ArtemisCamera   p  ; was: sub_EF28
                jsr     (Gfx_RenderScrollingBackground).l
                bpl.s   locret_EF4A
                move.l  #dword_11326,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$E400,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                moveq   #$FFFFFFFF,d0
locret_EF4A:                                            ; CODE XREF: Stage_ArtemisGraphicsInit+6   j
                rts
; End of function Stage_ArtemisGraphicsInit
; Palette update handler
Gfx_ArtemisPaletteUpdate:                               ; CODE XREF: Entity_SevenForcesArtemisFadeOutState28+20   p  ; was: sub_EF4C
                lea     word_EF58(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_ArtemisPaletteUpdate
; ---------------------------------------------------------------------------
word_EF58:      dc.w    $6C00, $4000, $F00, $494A, $494A, $494A, $494A, $494A, $494A, $494A, $494A
                                        ; DATA XREF: Gfx_ArtemisPaletteUpdate   o

; Wrapper for scrolling background render
Gfx_RenderBackgroundWrapper:
                jsr     (Gfx_RenderScrollingBackground).l  ; was: sub_EF6E
                bpl.s   locret_EF78
                moveq   #$FFFFFFFF,d0
locret_EF78:                                            ; CODE XREF: Gfx_RenderBackgroundWrapper+6   j
                rts
; End of function Gfx_RenderBackgroundWrapper
; Loads cutscene graphics
Cutscene_SevenForcesLoadGraphics:                       ; CODE XREF: Cutscene_SevenForcesState2+1A   p  ; was: sub_EF7A
                lea     (word_B9C0).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                lea     stru_EF92(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Cutscene_SevenForcesLoadGraphics
; ---------------------------------------------------------------------------
stru_EF92:      dc.w    7                               ; field_0
                                        ; DATA XREF: Cutscene_SevenForcesLoadGraphics+C   o
                dc.l    tiles_1BBC4E                    ; field_2
                dc.w    $1F00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1BCFFE                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1BD048                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    $FFFF

; Initializes tilemap update with scroll parameters
Gfx_InitTilemapUpdate:                                  ; CODE XREF: Cutscene_SevenForcesState3+C   p  ; was: sub_EFAC
                tst.w   (word_FFF720).w
                bmi.s   locret_EFE0
                movea.l #$FFFF4020,a0
                move.w  #0,d0
                move.w  #$F8,d1
                moveq   #$7E,d7                         ; '~'
                jsr     (Gfx_UpdateTilemapIndices).l
                move.l  #dword_11326,(dword_FFA940).w
                clr.w   (word_FFA946).w
                clr.w   (word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                moveq   #1,d0
locret_EFE0:                                            ; CODE XREF: Gfx_InitTilemapUpdate+4   j
                rts
; End of function Gfx_InitTilemapUpdate
; Attributes: thunk
; Checks cutscene completion
Cutscene_SevenForcesCheckComplete:                      ; CODE XREF: Cutscene_SevenForcesState4+C   p  ; was: sub_EFE2
                jmp     Gfx_RenderScrollingBackground
; End of function Cutscene_SevenForcesCheckComplete
; Initializes Stage 20 planes
Gfx_Stage20InitPlanes:                                  ; CODE XREF: Stage_Stage20Init+1A   p  ; was: sub_EFE8
                move.b  #$82,(byte_FF7981).l
                move.b  #$90,(byte_FF7982).l
                move.b  #$92,(byte_FF7983).l
                lea     (word_FF0C80).l,a0
                lea     (word_FF0D00).l,a1
                lea     (word_FF0D80).l,a2
                lea     (word_FF0E00).l,a3
                move.w  #$181,d1
                moveq   #$3F,d7                         ; '?'
loc_F01E:                                               ; CODE XREF: Gfx_Stage20InitPlanes+3E   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                move.w  d1,(a3)+
                dbf     d7,loc_F01E
                rts
; End of function Gfx_Stage20InitPlanes
; Background graphics setup
Gfx_SylpheedBackground:                                 ; CODE XREF: Stage_SylpheedCamera+16   p  ; was: sub_F02C
                clr.b   (byte_FF7981).l
                clr.b   (byte_FF7982).l
                clr.b   (byte_FF7983).l
                rts
; End of function Gfx_SylpheedBackground
; Shooting pattern 1
Boss_ArtemisShootPattern1:                              ; CODE XREF: Stage_ArtemisCameraUpdate   p  ; was: sub_F040
                move.b  #2,(byte_FF7B00).l
                lea     (word_FF0B00).l,a0
                move.w  #$300,d1
                moveq   #$3F,d7                         ; '?'
loc_F054:                                               ; CODE XREF: Boss_ArtemisShootPattern1+16   j
                move.w  d1,(a0)+
                dbf     d7,loc_F054
                rts
; End of function Boss_ArtemisShootPattern1
; Clears byte flag at FF7B00
Stage_ClearRAMFlag:                                     ; CODE XREF: Stage_SireneGraphicsInit+34   p  ; was: sub_F05C
                clr.b   (byte_FF7B00).l
                rts
; End of function Stage_ClearRAMFlag
; Clamps palette fade value and applies fade
