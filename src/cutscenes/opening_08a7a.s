Cutscene_InitShipEffect:                               ; DATA XREF: ROM:off_8A74   o  ; was: sub_8A7A
                move.w  #1,(word_FF0170).l
                addq.w  #2,(word_FF016E).l
                rts
; End of function Cutscene_InitShipEffect
; Decrements timer and advances cutscene state when timer expires
Cutscene_ShipTimerCheck:                               ; DATA XREF: ROM:00008A76   o  ; was: sub_8A8A
                subq.w  #1,(word_FF0170).l
                bne.w   locret_514E
                move.w  #$20,(word_FF0170).l ; ' '
                addq.w  #2,(word_FF016E).l
                rts
; End of function Cutscene_ShipTimerCheck
; Toggles flicker effect and adjusts ship vertical position
Cutscene_ShipFlickerControl:                               ; DATA XREF: ROM:00008A78   o  ; was: sub_8AA4
                eori.w  #2,(dword_FFA900).w
                tst.w   (dword_FFA900).w
                bne.s Cutscene_ShipMoveUp
                subi.w  #1,(dword_FF0134).l
                bra.s   loc_8AC2
; End of function Cutscene_ShipFlickerControl
; Increments ship position and manages timer for upward movement
Cutscene_ShipMoveUp:                               ; CODE XREF: Cutscene_ShipFlickerControl+A   j  ; was: sub_8ABA
                addi.w  #1,(dword_FF0134).l
loc_8AC2:                               ; CODE XREF: Cutscene_ShipFlickerControl+14   j
                subq.w  #1,(word_FF0170).l
                bne.w   locret_514E
                move.w  #$88,(word_FF0170).l
                subq.w  #2,(word_FF016E).l
                rts
; End of function Cutscene_ShipMoveUp
; Initializes Sega screen ship scene with sprites and effects
Cutscene_ShipInitScene:                               ; DATA XREF: ROM:0000881C   o  ; was: sub_8ADC
                move.w  #$A400,d0
                move.w  #$6022,d4
                movea.l #word_8EFE,a0
                move.w  #$11,d7
loc_8AEE:                               ; CODE XREF: Cutscene_ShipInitScene+1C   j
                jsr Gfx_BuildDMATransfer(pc)    ; (pc)
                nop
                addi.w  #$80,d4
                dbf     d7,loc_8AEE
                lea     (word_FF0140).l,a0
                move.w  #$11,d1
loc_8B06:                               ; CODE XREF: Cutscene_ShipInitScene+2C   j
                clr.w   (a0)+
                dbf     d1,loc_8B06
                clr.w   (word_FF0164).l
                move.b  #$30,d0 ; '0'
                jsr (Input_ProcessButtons).l
                move.l  #$8000,(dword_FF0138).l
                move.w  #$8000,(word_FF808A).w
                bsr.w Gfx_ClearPlaneBuffer
                addq.w  #2,(word_FF0132).l
; Renders SEGA logo animation and loads ship tiles
Cutscene_ShipInitScene_RenderLoop:                               ; DATA XREF: ROM:0000881E   o  ; was: loc_8B36
                bset    #0,(byte_FFA958).w
                bsr.w Gfx_SetupSegaPalette
                bsr.w Gfx_RenderAnimatedText
                bsr.w Gfx_WriteVDPCommands
                bsr.w Effect_SpawnStarParticle
                cmpi.w  #$668,(word_FF0130).l
                bcs.w   locret_514E
                movea.l #word_8DE4,a0
                jsr (Gfx_LoadCompressedTiles).l
                clr.w   (word_FF808A).w
                move.l  #dword_11346,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                move.w  #0,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                bclr    #0,(byte_FFA958).w
                move.w  #$10,(dword_FF0134).l
                clr.l   (dword_FF0138).l
                bsr.w Cutscene_ShipUpdateScroll
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipInitScene
; Renders scrolling background multiple times per frame
Cutscene_ShipRenderLoop:                               ; DATA XREF: ROM:00008820   o  ; was: sub_8BA2
                bsr.w Gfx_SetupSegaPalette
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   locret_514E
                move.w  #$FFF2,(word_FF0166).l
                move.w  #$E,(word_FF0168).l
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipRenderLoop
; Applies palette fade transition effects to ship scene
Cutscene_ShipFadeTransition:                               ; DATA XREF: ROM:00008822   o  ; was: sub_8BDE
                lea     (word_FFE300).w,a0
                move.w  (word_FF0166).l,d0
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                lea     (word_FFE320).w,a0
                move.w  (word_FF0168).l,d0
                move.w  #$F,d5
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF0168).l
                addq.w  #2,(word_FF0166).l
                cmpi.w  #2,(word_FF0166).l
                bne.w   locret_514E
                move.w  #$1000,2(a5)
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipFadeTransition
nullsub_20:                             ; DATA XREF: ROM:00008824   o
                rts
; End of function nullsub_20


; Spawns star particles with random trajectory calculations
Effect_SpawnStarParticle:                               ; CODE XREF: Cutscene_ShipInitScene+6C   p  ; was: sub_8C42
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_514E
                lea     (dword_2AF48).l,a1
                jsr (Sprite_InitFromTable).l
                jsr     (RandomNumber).l
                move.w  d0,d2
                andi.w  #$3F,d2 ; '?'
                jsr     (RandomNumber).l
                andi.w  #$FE,d0
                addi.w  #$100,d0
                movem.l a0,-(sp)
                bsr.w Math_LookupSineTable
                movem.l (sp)+,a0
                muls.w  d2,d0
                move.l  d0,d3
                swap    d0
                addi.w  #$128,d0
                move.w  d0,$10(a0)
                asr.l   #4,d3
                move.l  d3,$18(a0)
                muls.w  d2,d1
                move.l  d1,d3
                swap    d1
                addi.w  #$180,d1
                add.w   (dword_FF0134).l,d1
                move.w  (word_FF0130).l,d0
                subi.w  #$5C0,d0
                lsr.w   #1,d0
                add.w   d0,d1
                lsr.w   #2,d0
                add.w   d0,d1
                move.w  d1,$14(a0)
                asr.l   #4,d3
                move.l  d3,$1C(a0)
                rts
; End of function Effect_SpawnStarParticle
; Sets up palette fade for Sega screen with gradient colors
Gfx_SetupSegaPalette:                               ; CODE XREF: Cutscene_ShipInitScene+60   p  ; was: sub_8CC0
                                        ; sub_8BA2   p
                lea     (word_FFE300).w,a0
                move.w  #$FFF2,d0
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                lea     (word_FFE320).w,a0
                move.w  #$E,d0
                move.w  #$F,d5
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.w  #$222,(word_FFE376).w
                move.w  #$444,(word_FFE378).w
                move.w  #$666,(word_FFE37A).w
                move.w  #$888,(word_FFE37C).w
                move.w  #$AAA,(word_FFE37E).w
                rts
; End of function Gfx_SetupSegaPalette
; Updates horizontal scrolling values for ship parallax effect
Cutscene_ShipUpdateScroll:                               ; CODE XREF: Cutscene_ShipUpdateDispatcher+4   j  ; was: sub_8D0C
                                        ; Cutscene_ShipInitScene+BA   p
                cmpi.w  #$1A,(word_FF0132).l
                bcc.w   locret_514E
                move.l  (dword_FF0138).l,d0
                add.l   (dword_FF0134).l,d0
                move.l  d0,(dword_FF0134).l
                lea     (word_FFEC00).w,a0
                move.w  (dword_FF0134).l,d0
                neg.w   d0
                move.w  #$F,d7
loc_8D3A:                               ; CODE XREF: Cutscene_ShipUpdateScroll+32   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_8D3A
                cmpi.w  #$18,(word_FF0132).l
                bcs.w   locret_514E
                lea     (word_FFEC22).w,a0
                move.w  #4,d7
loc_8D56:                               ; CODE XREF: Cutscene_ShipUpdateScroll+4E   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_8D56
                rts
; End of function Cutscene_ShipUpdateScroll
; Sets priority bit on plane tiles and loads compressed graphics
Gfx_EnablePriorityPlane:                               ; CODE XREF: Cutscene_ShipFadeInAlt+14   p  ; was: sub_8D60
                lea     (word_FF2020).l,a0
                move.w  #$15F,d1
loc_8D6A:                               ; CODE XREF: Gfx_EnablePriorityPlane+12   j
                move.w  (a0),d0
                ori.w   #$8000,d0
                move.w  d0,(a0)+
                dbf     d1,loc_8D6A
                movea.l #word_8DCE,a0
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_EnablePriorityPlane
; Clears priority bit on plane tiles and loads compressed graphics
Gfx_DisablePriorityPlane:                               ; CODE XREF: Cutscene_ShipExitPrepare+16   p  ; was: sub_8D82
                lea     (word_FF2020).l,a0
                move.w  #$15F,d1
loc_8D8C:                               ; CODE XREF: Gfx_DisablePriorityPlane+12   j
                move.w  (a0),d0
                andi.w  #$7FFF,d0
                move.w  d0,(a0)+
                dbf     d1,loc_8D8C
                movea.l #word_8DCE,a0
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_DisablePriorityPlane
; ---------------------------------------------------------------------------
word_8DA4:      dc.w $4020, $2000, $100, $102
                                        ; DATA XREF: Cutscene_LoadShipTiles1   o
word_8DAC:      dc.w $4220, $2000, $100, $304
                                        ; DATA XREF: Cutscene_LoadShipTiles2+A   o
word_8DB4:      dc.w $4420, $2000, $100, $506
                                        ; DATA XREF: Cutscene_LoadShipTiles3+A   o
word_8DBC:      dc.w $4620, $2000, $100, $708
                                        ; DATA XREF: Cutscene_LoadShipTiles4+A   o
word_8DC4:      dc.w $4820, $2000, $200, $90A, $BFF
                                        ; DATA XREF: Cutscene_LoadShipTiles5+A   o
word_8DCE:      dc.w $4020, $2000, $204, $102, 3, $400, $506, 7, $800, $90A, $BFF
                                        ; DATA XREF: Gfx_EnablePriorityPlane+16   o
                                        ; Gfx_DisablePriorityPlane+16   o
word_8DE4:      dc.w $4020, $2000, $204, 0, 0, 0, 0, 0, 0, 0, $FF
                                        ; DATA XREF: Cutscene_ShipInitScene+7C   o


; Renders animated text reveal effect character by character
Gfx_RenderAnimatedText:                               ; CODE XREF: Cutscene_ShipInitScene+64   p  ; was: sub_8DFA
                move.w  (word_FF0164).l,d1
                addq.w  #1,(word_FF0164).l
                lsr.w   #3,d1
                cmpi.w  #$11,d1
                bcs.s   loc_8E12
                move.w  #$11,d1
loc_8E12:                               ; CODE XREF: Gfx_RenderAnimatedText+12   j
                lea     (word_FF0140).l,a0
                lea     (word_FF1000).l,a2
loc_8E1E:                               ; CODE XREF: Gfx_RenderAnimatedText+36   j
                movem.l a2,-(sp)
                bsr.w Gfx_UpdateTextPixel
                movem.l (sp)+,a2
                addq.w  #2,a0
                adda.w  #$20,a2 ; ' '
                dbf     d1,loc_8E1E
                rts
; End of function Gfx_RenderAnimatedText
; Updates individual pixel/tile data for text animation
Gfx_UpdateTextPixel:                               ; CODE XREF: Gfx_RenderAnimatedText+28   p  ; was: sub_8E36
                move.w  (a0),d0
                cmpi.w  #$40,d0 ; '@'
                beq.w   locret_514E
                addq.w  #1,(a0)
                lea     byte_79BA(pc),a3
                lea     (a3,d0.w),a3
                moveq   #0,d2
                move.b  (a3),d2
                move.l  d2,d3
                andi.b  #3,d2
                lsl.b   #1,d2
                lea     word_8E6C(pc,d2.w),a4
                move.w  (a4),d2
                andi.b  #$3C,d3 ; '<'
                lsr.b   #1,d3
                adda.l  d3,a2
                move.w  (a2),d4
                or.w    d2,d4
                move.w  d4,(a2)
                rts
; End of function Gfx_UpdateTextPixel
; ---------------------------------------------------------------------------
word_8E6C:      dc.w $F000, $F00, $F0, $F


; Clears plane buffer memory with zeros
Gfx_ClearPlaneBuffer:                               ; CODE XREF: Cutscene_ShipInitScene+50   p  ; was: sub_8E74
                lea     (word_FF1000).l,a1
                moveq   #0,d0
                move.w  #$8F,d1
loc_8E80:                               ; CODE XREF: Gfx_ClearPlaneBuffer+E   j
                move.l  d0,(a1)+
                dbf     d1,loc_8E80
; End of function Gfx_ClearPlaneBuffer
; Writes VDP command sequence to command buffer
Gfx_WriteVDPCommands:                               ; CODE XREF: Cutscene_ShipInitScene+68   p  ; was: sub_8E86
                movea.w (word_FFF70C).w,a0
                suba.w  #$10,a0
                move.w  a0,(word_FFF70C).w
                move.l  #$94019320,(a0)+
                move.l  #$8F02977F,(a0)+
                move.l  #$96889500,(a0)+
                move.l  #$4D800082,(a0)+
                rts
; End of function Gfx_WriteVDPCommands
; Builds DMA transfer command list for VDP operations
Gfx_BuildDMATransfer:                               ; CODE XREF: Cutscene_ShipInitScene:loc_8AEE   p  ; was: sub_8EAC
                movea.w (word_FFF70E).w,a1
                moveq   #0,d3
loc_8EB2:                               ; CODE XREF: Gfx_BuildDMATransfer+12   j
                move.b  (a0)+,d0
                cmpi.b  #$FF,d0
                beq.s   loc_8EC0
                move.w  d0,(a1)+
                addq.w  #1,d3
                bra.s   loc_8EB2
; ---------------------------------------------------------------------------
loc_8EC0:                               ; CODE XREF: Gfx_BuildDMATransfer+C   j
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                move.w  d4,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009300,-(a1)
                move.b  d3,3(a1)
                move.w  a1,(word_FFF70C).w
                asl.w   #1,d3
                add.w   d3,(word_FFF70E).w
                rts
; End of function Gfx_BuildDMATransfer
; ---------------------------------------------------------------------------
word_8EFE:      dc.w $6C6C, $6C6C, $6C6C, $6CFF
                                        ; DATA XREF: Cutscene_ShipInitScene+8   o
                dc.w $6D6D, $6D6D, $6D6D, $6DFF
                dc.w $6E6E, $6E6E, $6E6E, $6EFF
                dc.w $6F6F, $6F6F, $6F6F, $6FFF
                dc.w $7070, $7070, $7070, $70FF
                dc.w $7171, $7171, $7171, $71FF
                dc.w $7272, $7272, $7272, $72FF
                dc.w $7373, $7373, $7373, $73FF
                dc.w $7474, $7474, $7474, $74FF
                dc.w $7575, $7575, $7575, $75FF
                dc.w $7676, $7676, $7676, $76FF
                dc.w $7777, $7777, $7777, $77FF
                dc.w $7878, $7878, $7878, $78FF
                dc.w $7979, $7979, $7979, $79FF
                dc.w $7A7A, $7A7A, $7A7A, $7AFF
                dc.w $7B7B, $7B7B, $7B7B, $7BFF
                dc.w $7C7C, $7C7C, $7C7C, $7C7C
                dc.w $FF7D, $7D7D, $7D7D, $7D7D
                dc.w $7DFF


; Spawns ship sprite at specific frame with animation data
Cutscene_SpawnShipSprite:                               ; CODE XREF: Cutscene_ShipAnimationLoop+6   p  ; was: sub_8F90
                movea.l (dword_FF0128).l,a0
                move.w  (word_FF0130).l,d0
                cmp.w   (a0)+,d0
                bne.w   locret_514E
                movea.l #$FFFFC620,a4
                adda.w  (a0)+,a4
                move.w  #$CC00,2(a4)
                move.w  #$30C,(a4)
                move.w  #$4300,$E(a4)
                move.b  #$78,$20(a4) ; 'x'
                clr.l   $18(a4)
                move.w  (a0)+,d0
                move.l  off_8FEE(pc,d0.w),8(a4)
                move.l  word_8FFE(pc,d0.w),$1C(a4)
                move.w  (a0)+,$10(a4)
                move.w  (a0)+,$14(a4)
                move.w  (a0)+,$40(a4)
                move.w  (a0)+,d0
                ext.l   d0
                move.l  d0,$18(a4)
                move.l  a0,(dword_FF0128).l
                rts
; End of function Cutscene_SpawnShipSprite
; ---------------------------------------------------------------------------
off_8FEE:       dc.l word_1A9B9E
                dc.l word_1A9BA4
                dc.l word_1A9BAA
                dc.l word_1A9BC2
word_8FFE:      dc.w $FFFF, $E800, $FFFF, $E000, $FFFF, $D000, $FFFF, $D800
word_900E:      dc.w 1, $11A0, 0, $100, $148, $490, 0, $28
                                        ; DATA XREF: Cutscene_InitShipData   o
                dc.w $1140, 0, $F8, $148, $490, $FE00, $29, $10E0
                dc.w 0, $108, $148, $4D0, $200, $68, $1080, 0
                dc.w $F0, $148, $490, $FC80, $B0, $1020, 0, $E8
                dc.w $148, $410, $FB80, $140, $BA0, 4, $148, $150
                dc.w $3A0, $FE00, $158, $B40, 4, $150, $150, $3B0
                dc.w 0, $170, $AE0, 4, $158, $150, $380, $200
                dc.w $190, $A80, 4, $160, $150, $350, $400, $1A0
                dc.w $5A0, 8, $100, $158, $378, 0, $1B0, $540
                dc.w $C, $160, $158, $378, 0, 0


; Spawns debris sprite with velocity and plays sound effect
Cutscene_SpawnDebrisSprite:                               ; CODE XREF: Cutscene_ShipAnimationLoop+A   p  ; was: sub_90AA
                movea.l (dword_FF012C).l,a0
                move.w  (word_FF0130).l,d0
                cmp.w   (a0)+,d0
                bne.w   locret_514E
                movea.l #$FFFFC620,a4
                adda.w  (a0)+,a4
                move.w  #$CC00,2(a4)
                clr.w   4(a4)
                move.w  #$310,(a4)
                move.w  #$4300,$E(a4)
                move.b  #$70,$20(a4) ; 'p'
                move.w  #$50,$14(a4) ; 'P'
                move.w  (a0)+,d0
                move.l  off_911A(pc,d0.w),8(a4)
                move.l  dword_913A(pc,d0.w),$18(a4)
                move.l  word_915A(pc,d0.w),$1C(a4)
                move.w  (a0)+,$10(a4)
                tst.l   $18(a4)
                bpl.s   loc_9108
                ori.w   #$800,$E(a4)
loc_9108:                               ; CODE XREF: Cutscene_SpawnDebrisSprite+56   j
                move.l  a0,(dword_FF012C).l
                move.b  #$59,d0 ; 'Y'
                jsr (Sound_PlaySFX).l
                rts
; End of function Cutscene_SpawnDebrisSprite
; ---------------------------------------------------------------------------
off_911A:       dc.l word_1A9BC8
                dc.l word_1A9BE6
                dc.l word_1A9BE6
                dc.l word_1A9C04
                dc.l word_1A9C2E
                dc.l word_1A9C2E
                dc.l word_1A9C58
                dc.l word_1A9C82
dword_913A:     dc.l 0, $FFFF8000, $8000
                dc.l 0, $FFFE0000, $20000
                dc.l 0, 0
word_915A:      dc.w 4, 0, 4, 0, 4, 0, $10, 0
                dc.w $10, 0, $10, 0, $20, 0, $20, 0
word_917A:      dc.w $480, $FC0, 0, $120, $488, $F60, 4, $110
                                        ; DATA XREF: Cutscene_InitShipData+A   o
                dc.w $490, $F00, 8, $D0, $498, $EA0, 0, $F0
                dc.w $4A0, $E40, 8, $150, $4A8, $DE0, 4, $E0
                dc.w $4B0, $D80, 0, $170, $4B8, $D20, 8, $130
                dc.w $4C0, $CC0, 0, $160, $4C8, $C60, 4, $100
                dc.w $4D0, $C00, 8, $140, $4D8, $A20, $14, $130
                dc.w $4DE, $9C0, $10, $170, $4E4, $960, $14, $150
                dc.w $4EA, $900, $C, $100, $4F0, $8A0, $10, $F0
                dc.w $4F6, $840, $10, $140, $4FC, $7E0, $C, $110
                dc.w $502, $780, $14, $D0, $508, $720, $C, $160
                dc.w $50E, $6C0, $14, $100, $514, $660, $10, $E0
                dc.w $51A, $600, $14, $120, $520, $360, $18, $100
                dc.w $528, $300, $18, $160, $530, $2A0, $18, $D0
                dc.w $538, $240, $18, $178, $53C, $1E0, $18, $110
                dc.w $540, $180, $18, $148, $544, $120, $18, $F0
                dc.w $548, $C0, $1C, $128, 0


; Updates ship debris sprite countdown and transitions state
Sprite_ShipDebrisUpdate:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_9274
                subq.w  #1,$40(a5)
                beq.s   loc_928C
                cmpi.w  #$60,$14(a5) ; '`'
                bcc.w   locret_514E
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_928C:                               ; CODE XREF: Sprite_ShipDebrisUpdate+4   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E953C,8(a5)
                jsr (Enemy_GetEntityAddress).l
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
                rts
; End of function Sprite_ShipDebrisUpdate
; Dispatches debris sprite update to appropriate handler
Sprite_DebrisDispatcher:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_92AE
                move.w  4(a5),d0
                lea     off_92BA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Sprite_DebrisDispatcher
; ---------------------------------------------------------------------------
off_92BA:       dc.w Object_CheckYPosAndPause-*         ; DATA XREF: Sprite_DebrisDispatcher+4   o
                dc.w Object_RestoreAfterTimer-*
                dc.w Object_SetDestroyFlag-*
                dc.w nullsub_21-*


; Checks if Y position >= 240 then pauses object movement
Object_CheckYPosAndPause:                               ; DATA XREF: ROM:off_92BA   o  ; was: sub_92C2
                cmpi.w  #$F0,$14(a5)
                bcs.w   locret_514E
                move.w  #$60,$48(a5) ; '`'
                move.l  $1C(a5),$40(a5)
                move.l  $18(a5),$44(a5)
                clr.l   $1C(a5)
                clr.l   $18(a5)
                addq.w  #2,4(a5)
                cmpa.w  #$C6E0,a5
                bne.w   locret_514E
                addq.w  #4,4(a5)
                rts
; End of function Object_CheckYPosAndPause
; Counts down timer and restores velocity when done
Object_RestoreAfterTimer:                               ; DATA XREF: ROM:000092BC   o  ; was: sub_92F8
                subq.w  #1,$48(a5)
                bne.w   locret_514E
                move.l  $40(a5),$1C(a5)
                move.l  $44(a5),$18(a5)
                rts
; End of function Object_RestoreAfterTimer
; Sets destroy flag when Y position >= 400
Object_SetDestroyFlag:                               ; DATA XREF: ROM:000092BE   o  ; was: sub_930E
                cmpi.w  #$190,$14(a5)
                bcs.w   locret_514E
                move.w  #$1000,2(a5)
                rts
; End of function Object_SetDestroyFlag
nullsub_21:                             ; DATA XREF: ROM:000092C0   o
                rts
; End of function nullsub_21


; Initializes title screen mode with graphics data and text rendering
UI_InitTitleScreen:                               ; DATA XREF: Sys_DispatchGameState+6A   o  ; was: sub_9322
                tst.w   (GameSubstateIndex).w
                bne.s   loc_936C
                jsr (Sys_InitGameMode).l
                jsr (Sys_ClearBossDataBuffer).l
                lea     stru_A1B6(pc),a0
                nop
                jsr     (LoadObjData).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
loc_936C:                               ; CODE XREF: UI_InitTitleScreen+4   j
                move.w  #$18,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                movea.l #$FFFF4020,a0
                move.w  #$C180,d0
                moveq   #$26,d7 ; '&'
                jsr (Gfx_AdjustTileIndices).l
                movea.l #$FFFF2020,a0
                move.w  #$6000,d0
                move.w  #$FF00,d1
                move.w  #$BF,d7
                jsr (Gfx_UpdateTilemapIndices).l
                lea     (dword_11316).l,a0
                moveq   #0,d0
                moveq   #0,d1
                move.w  d0,(dword_FFA900).w
                move.w  d1,(dword_FFA904).w
                jsr (Gfx_DirectVRAMTransfer).l
                lea     (dword_11336).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                move.w  d0,(dword_FFA908).w
                move.w  d1,(dword_FFA90C).w
                jsr (Gfx_DirectVRAMTransfer).l
                move.b  #0,(word_FFF7F4+1).w
                move.w  #2,(dword_FF8066+2).w
                move.b  #$91,d0
                jsr (Input_ProcessButtons).l
                jsr (Gfx_SetupScrollPlanes).l
                lea     (byte_46B4).l,a0
                move.w  #$A300,d0
                move.w  #$4086,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_46D9).l,a0
                move.w  #$A300,d0
                move.w  #$4202,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4701).l,a0
                move.w  #$8300,d0
                move.w  #$4892,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4718).l,a0
                move.w  #$A300,d0
                move.w  #$4C0C,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_BA4A).l,a0
                jsr     (LoadPalette).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                jmp (Gfx_FadePaletteTransition).l
; End of function UI_InitTitleScreen
; ---------------------------------------------------------------------------
unused_1:	binclude	"data/other/unused_1.bin"


; Handles title screen navigation and button input for menu selection
UI_HandleTitleInput:                               ; DATA XREF: Sys_DispatchGameState+6E   o  ; was: sub_9478
                tst.w   (word_FF80F0).w
                bne.w   loc_9538
                move.b  (word_FFF708).w,d0
                andi.b  #$C,d0
                beq.s   loc_9494
                move.b  #$DB,d0
                jsr (Input_ProcessButtons).l
loc_9494:                               ; CODE XREF: UI_HandleTitleInput+10   j
                move.w  (dword_FF8066+2).w,d0
                btst    #2,(word_FFF708).w
                beq.s   loc_94A6
                subq.w  #2,d0
                bpl.s   loc_94B8
                moveq   #0,d0
loc_94A6:                               ; CODE XREF: UI_HandleTitleInput+26   j
                btst    #3,(word_FFF708).w
                beq.s   loc_94B8
                addq.w  #2,d0
                cmpi.w  #6,d0
                bmi.s   loc_94B8
                moveq   #4,d0
loc_94B8:                               ; CODE XREF: UI_HandleTitleInput+2A   j
                                        ; UI_HandleTitleInput+34   j ...
                andi.w  #6,d0
                move.w  d0,(dword_FF8066+2).w
                cmpi.w  #$780,(word_FFA000).w
                cmpi.w  #$700,(word_FFA000).w
                bne.s   loc_94DA
                move.w  #1,(word_FFFF5A).w
                clr.w   (word_FFFF5C).w
                rts
; ---------------------------------------------------------------------------
loc_94DA:                               ; CODE XREF: UI_HandleTitleInput+54   j
                btst    #7,(word_FFF708).w
                beq.s   loc_9538
                move.b  #2,(byte_FF830E).w
                move.b  #$C4,d0
                jsr (Input_ProcessButtons).l
                clr.w   (GameSubstateIndex).w
                tst.w   (word_FFFF5A).w
                beq.s   loc_9510
                move.w  #$70,(GameModeIndex).w ; 'p'
                jsr (UI_InitializeGameVariables).l
                move.w  (word_FFFF64).w,(StageTableIndex).w
                rts
; ---------------------------------------------------------------------------
loc_9510:                               ; CODE XREF: UI_HandleTitleInput+82   j
                move.w  (dword_FF8066+2).w,d0
                beq.s   loc_9524
                beq.s   loc_9538
                subq.w  #2,d0
                beq.s   loc_952C
                move.w  #$1C,(GameModeIndex).w
                rts
; ---------------------------------------------------------------------------
loc_9524:                               ; CODE XREF: UI_HandleTitleInput+9C   j
                move.w  #$44,(GameModeIndex).w ; 'D'
                rts
; ---------------------------------------------------------------------------
loc_952C:                               ; CODE XREF: UI_HandleTitleInput+A2   j
                move.w  #$70,(GameModeIndex).w ; 'p'
                jmp UI_InitializeGameVariables
; ---------------------------------------------------------------------------
loc_9538:                               ; CODE XREF: UI_HandleTitleInput+4   j
                                        ; UI_HandleTitleInput+68   j ...
                addq.w  #1,(word_FFA000).w
                cmpi.w  #$200,(word_FFA000).w
                bne.s   loc_954E
                move.b  #$10,d0
                jsr (Input_ProcessButtons).l
loc_954E:                               ; CODE XREF: UI_HandleTitleInput+CA   j
                move.w  #$A300,d0
                cmpi.w  #2,(dword_FF8066+2).w
                beq.s   loc_955E
                move.w  #$C300,d0
loc_955E:                               ; CODE XREF: UI_HandleTitleInput+E0   j
                bsr.w UI_RenderTitleOption1
                move.w  #$A300,d0
                cmpi.w  #4,(dword_FF8066+2).w
                beq.s   loc_9572
                move.w  #$C300,d0
loc_9572:                               ; CODE XREF: UI_HandleTitleInput+F4   j
                bsr.w UI_RenderTitleOption2
                move.w  #$A300,d0
                tst.w   (dword_FF8066+2).w
                beq.s   loc_9584
                move.w  #$C300,d0
loc_9584:                               ; CODE XREF: UI_HandleTitleInput+106   j
                bsr.w UI_RenderTitleOption3
                jsr Gfx_UpdateMenuPalette(pc)    ; (pc)
                nop
                jsr (Gfx_FadePaletteTransition).l
                jmp Gfx_SetupScrollPlanes
; End of function UI_HandleTitleInput
; Renders first menu option text on title screen
UI_RenderTitleOption1:                               ; CODE XREF: UI_HandleTitleInput:loc_955E   p  ; was: sub_959A
                movea.l #byte_4698,a0
                move.w  #$4A9E,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderTitleOption1
; Renders second menu option text on title screen
UI_RenderTitleOption2:                               ; CODE XREF: UI_HandleTitleInput:loc_9572   p  ; was: sub_95AA
                movea.l #byte_46A3,a0
                move.w  #$4ABA,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderTitleOption2
; Renders third menu option text on title screen
UI_RenderTitleOption3:                               ; CODE XREF: UI_HandleTitleInput:loc_9584   p  ; was: sub_95BA
                movea.l #byte_46AB,a0
                move.w  #$4A86,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderTitleOption3
; Initializes options screen with objects and text elements
UI_InitOptionsScreen:                               ; DATA XREF: Sys_DispatchGameState+72   o  ; was: sub_95CA
                tst.w   (GameSubstateIndex).w
                bne.s   loc_9612
                jsr (Sys_InitGameMode).l
                movea.l #stru_A1F8,a0
                jsr     (LoadObjData).l
                jsr (Sys_ClearBossDataBuffer).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                clr.b   (word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
loc_9612:                               ; CODE XREF: UI_InitOptionsScreen+4   j
                cmpi.w  #4,(GameSubstateIndex).w
                beq.w   loc_9728
                addq.w  #2,(GameSubstateIndex).w
                lea     (dword_11336).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                move.w  d0,(dword_FFA908).w
                move.w  d1,(dword_FFA90C).w
                jsr (Gfx_DirectVRAMTransfer).l
                lea     (word_B948).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                jsr (Gfx_FadePaletteTransition).l
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                jsr (Gfx_SetupScrollPlanes).l
                clr.w   (dword_FF8062+2).w
                clr.w   (dword_FF8062).w
                clr.b   (dword_FF805E+3).w
                clr.b   (dword_FF8066).w
                clr.b   (dword_FF806A+2).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                lea     (byte_46A3).l,a0
                move.w  #$8300,d0
                move.w  #$4122,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4734).l,a0
                move.w  #$8300,d0
                move.w  #$4290,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4749).l,a0
                move.w  #$8300,d0
                move.w  #$4490,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4754).l,a0
                move.w  #$8300,d0
                move.w  #$4590,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_475F).l,a0
                move.w  #$8300,d0
                move.w  #$4710,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4768).l,a0
                move.w  #$8300,d0
                move.w  #$4810,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4771).l,a0
                move.w  #$8300,d0
                move.w  #$4910,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_477C).l,a0
                move.w  #$A300,d0
                move.w  #$4B14,d4
                jmp (UI_RenderTextStringWrapped).l
; ---------------------------------------------------------------------------
loc_9728:                               ; CODE XREF: UI_InitOptionsScreen+4E   j
                move.w  #$20,(GameModeIndex).w ; ' '
                clr.w   (GameSubstateIndex).w
                move.w  #$118,d0
                move.w  #$B3,d1
                move.l  #word_A36A,d2
                jsr (UI_InitCursorSprite).l
                clr.b   (dword_FF806A).w
                clr.b   (dword_FF806A+1).w
                clr.b   d5
                bsr.w UI_OptionsRenderRow1
                clr.b   d5
                bsr.w UI_OptionsRenderRow2
                clr.b   d5
                bsr.w UI_OptionsRenderRow3
                clr.b   d5
                bsr.w UI_OptionsUpdateButtons
                clr.b   d5
                bsr.w UI_OptionsSelectCharacter
                clr.b   d5
                bsr.w UI_OptionsSelectCharacter2
                rts
; End of function UI_InitOptionsScreen
; Updates options screen with input handling and object processing
UI_UpdateOptionsScreen:                               ; DATA XREF: Sys_DispatchGameState+76   o  ; was: sub_9774
                bclr    #1,(word_FF80F4).w
                beq.s   loc_978C
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jmp     loc_1CDB8
; ---------------------------------------------------------------------------
loc_978C:                               ; CODE XREF: UI_UpdateOptionsScreen+6   j
                tst.w   (word_FF80F2).w
                bne.s   loc_97B4
                btst    #7,(word_FFF708).w
                beq.s   loc_97B4
                move.b  #2,(byte_FF830E).w
                move.b  #$C4,d0
                jsr (Input_ProcessButtons).l
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
loc_97B4:                               ; CODE XREF: UI_UpdateOptionsScreen+1C   j
                                        ; UI_UpdateOptionsScreen+24   j
                jsr Gfx_UpdateMenuPalette(pc)    ; (pc)
                nop
                jsr (Gfx_UpdateScrollPosition).l
                jsr (Sys_InitObjectPointers).l
                jsr (UI_CheckVBlankFlag).l
                jsr (Sys_ProcessVisibleObjects).l
                bsr.w UI_HandleOptionsInput
                jsr (Sys_UpdateObjectCount).l
                jsr (Sys_ProcessObjectList).l
                jsr (Gfx_FadePaletteTransition).l
                jmp Gfx_SetupScrollPlanes
; End of function UI_UpdateOptionsScreen
; Processes directional input and button presses in options menu
UI_HandleOptionsInput:                               ; CODE XREF: UI_UpdateOptionsScreen+5E   p  ; was: sub_97EE
                bsr.w Gfx_UpdateCursorFlash
                btst    #0,(dword_FF805E+2).w
                bne.w UI_AnimateCursorToTarget
                btst    #0,(word_FFF708).w
                beq.s   loc_982C
                move.b  #$DB,d0
                jsr (Input_ProcessButtons).l
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                subq.w  #2,(dword_FF8062).w
                bpl.s   loc_982C
                move.w  #$A,(dword_FF8062).w
loc_982C:                               ; CODE XREF: UI_HandleOptionsInput+14   j
                                        ; UI_HandleOptionsInput+36   j
                btst    #1,(word_FFF708).w
                beq.w   loc_9864
                move.b  #$DB,d0
                jsr (Input_ProcessButtons).l
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                addq.w  #2,(dword_FF8062).w
                cmpi.w  #$C,(dword_FF8062).w
                bmi.s   locret_9862
                clr.w   (dword_FF8062).w
locret_9862:                            ; CODE XREF: UI_HandleOptionsInput+6E   j
                rts
; ---------------------------------------------------------------------------
loc_9864:                               ; CODE XREF: UI_HandleOptionsInput+44   j
                move.b  (word_FFF708).w,(dword_FF806A).w
                move.b  (word_FFF706).w,(dword_FF806A+1).w
                move.b  (word_FFF708).w,d5
                btst    #4,d5
                beq.s   loc_988A
                move.w  #$20,(dword_FF8066+2).w ; ' '
                move.b  #4,d0
                jmp (Input_ProcessButtons).l
; ---------------------------------------------------------------------------
loc_988A:                               ; CODE XREF: UI_HandleOptionsInput+8A   j
                andi.b  #$60,d5 ; '`'
loc_988E:                               ; CODE XREF: UI_HandleOptionsNavigation+8A   j
                move.b  (word_FFF708).w,d0
                andi.b  #$C,d0
                beq.s   loc_98A2
                move.b  #$AD,d0
                jsr (Input_ProcessButtons).l
loc_98A2:                               ; CODE XREF: UI_HandleOptionsInput+A8   j
                btst    #2,(word_FFF706).w
                bne.s   loc_98BA
                btst    #3,(word_FFF706).w
                bne.s   loc_98BA
                move.w  #$20,(dword_FF8066+2).w ; ' '
                bra.s   loc_98C4
; ---------------------------------------------------------------------------
loc_98BA:                               ; CODE XREF: UI_HandleOptionsInput+BA   j
                                        ; UI_HandleOptionsInput+C2   j
                tst.w   (dword_FF8066+2).w
                beq.s   loc_98C4
                subq.w  #1,(dword_FF8066+2).w
loc_98C4:                               ; CODE XREF: UI_HandleOptionsInput+CA   j
                                        ; UI_HandleOptionsInput+D0   j
                move.w  (dword_FF8062).w,d0
                movea.w off_98D4(pc,d0.w),a0
                adda.l  #UI_OptionsRenderRow1,a0
                jmp     (a0)
; End of function UI_HandleOptionsInput
; ---------------------------------------------------------------------------
off_98D4:       dc.w UI_OptionsRenderRow1-UI_OptionsRenderRow1
                dc.w UI_OptionsRenderRow2-UI_OptionsRenderRow1
                dc.w UI_OptionsRenderRow3-UI_OptionsRenderRow1
                dc.w UI_OptionsUpdateButtons-UI_OptionsRenderRow1
                dc.w UI_OptionsSelectCharacter-UI_OptionsRenderRow1
                dc.w UI_OptionsSelectCharacter2-UI_OptionsRenderRow1


; Renders first row of options with tile graphics
UI_OptionsRenderRow1:                               ; CODE XREF: UI_InitOptionsScreen+186   p  ; was: sub_98E0
                                        ; DATA XREF: UI_HandleOptionsInput+DE   o ...
                lea     word_A232(pc),a1
                nop
                lea     word_A248(pc),a2
                nop
                movea.w #(word_FFFF0E-M68K_RAM),a4
                move.w  #$429E,d6
                bra.w   loc_A050
; End of function UI_OptionsRenderRow1
; Updates button configuration display with input cycling
UI_OptionsUpdateButtons:                               ; CODE XREF: UI_InitOptionsScreen+198   p  ; was: sub_98F8
                                        ; DATA XREF: ROM:000098DA   o
                movea.l #word_998C,a1
                moveq   #0,d0
                move.b  (dword_FF805E+3).w,d0
                asl.w   #5,d0
                adda.l  d0,a1
                tst.b   d5
                beq.s   loc_991A
                move.w  #$20,(dword_FF8066+2).w ; ' '
                move.b  (a1),d0
                jmp (Input_ProcessButtons).l
; ---------------------------------------------------------------------------
loc_991A:                               ; CODE XREF: UI_OptionsUpdateButtons+12   j
                movea.w (word_FFF70E).w,a0
                adda.l  #2,a1
                movea.l a1,a2
                moveq   #$E,d7
loc_9928:                               ; CODE XREF: UI_OptionsUpdateButtons+32   j
                move.w  (a1)+,(a0)+
                dbf     d7,loc_9928
                moveq   #$E,d7
loc_9930:                               ; CODE XREF: UI_OptionsUpdateButtons+3E   j
                move.w  (a2)+,d0
                addq.w  #1,d0
                move.w  d0,(a0)+
                dbf     d7,loc_9930
                move.b  (dword_FF805E+3).w,d0
                btst    #2,(dword_FF806A).w
                beq.s   loc_995A
                move.w  #$A,(dword_FF8062+2).w
                tst.b   d0
                bne.s   loc_9956
                move.b  #$14,d0
                bra.s   loc_9974
; ---------------------------------------------------------------------------
loc_9956:                               ; CODE XREF: UI_OptionsUpdateButtons+56   j
                subq.b  #1,d0
                bra.s   loc_9974
; ---------------------------------------------------------------------------
loc_995A:                               ; CODE XREF: UI_OptionsUpdateButtons+4C   j
                btst    #3,(dword_FF806A).w
                beq.s   loc_9974
                move.w  #$A,(dword_FF8062+2).w
                cmpi.b  #$14,d0
                bne.s   loc_9972
                clr.b   d0
                bra.s   loc_9974
; ---------------------------------------------------------------------------
loc_9972:                               ; CODE XREF: UI_OptionsUpdateButtons+74   j
                addq.b  #1,d0
loc_9974:                               ; CODE XREF: UI_OptionsUpdateButtons+5C   j
                                        ; UI_OptionsUpdateButtons+60   j ...
                move.b  d0,(dword_FF805E+3).w
                move.w  #$4726,d0
                moveq   #$F,d3
                bsr.w Gfx_QueueVRAMWrite
                move.w  #$47A6,d0
                moveq   #$F,d3
                bra.w Gfx_QueueVRAMWrite
; End of function UI_OptionsUpdateButtons
; ---------------------------------------------------------------------------
word_998C:	binclude	"data/other/word_998C.bin"
word_998C_End:


; Handles character selection in button configuration interface
UI_OptionsSelectCharacter:                               ; CODE XREF: UI_InitOptionsScreen+19E   p  ; was: sub_9C4C
                                        ; DATA XREF: ROM:000098DC   o
                move.b  (dword_FF8066).w,d0
                tst.b   d5
                beq.s   loc_9C64
                lea     LatinAlphabet(pc),a0
                nop
                move.b  (a0,d0.w),d0
                jmp (Input_ProcessButtons).l
; ---------------------------------------------------------------------------
loc_9C64:                               ; CODE XREF: UI_OptionsSelectCharacter+6   j
                moveq   #1,d1
                tst.w   (dword_FF8066+2).w
                bne.s   loc_9C86
                btst    #0,(word_FFA280+1).w
                bne.s   loc_9CE0
                btst    #2,(dword_FF806A+1).w
                bne.s   loc_9C94
                btst    #3,(dword_FF806A+1).w
                bne.s   loc_9CC2
                bra.s   loc_9CE0
; ---------------------------------------------------------------------------
loc_9C86:                               ; CODE XREF: UI_OptionsSelectCharacter+1E   j
                btst    #2,(dword_FF806A).w
                beq.s   loc_9CB4
                move.w  #6,(dword_FF8062+2).w
loc_9C94:                               ; CODE XREF: UI_OptionsSelectCharacter+2E   j
                movem.l d0,-(sp)
                move.b  #4,d0
                jsr (Input_ProcessButtons).l
                movem.l (sp)+,d0
                tst.b   d0
                bne.s   loc_9CB0
                move.b  #$98,d0
                bra.s   loc_9CE0
; ---------------------------------------------------------------------------
loc_9CB0:                               ; CODE XREF: UI_OptionsSelectCharacter+5C   j
                subq.b  #1,d0
                bra.s   loc_9CE0
; ---------------------------------------------------------------------------
loc_9CB4:                               ; CODE XREF: UI_OptionsSelectCharacter+40   j
                btst    #3,(dword_FF806A).w
                beq.s   loc_9CE0
                move.w  #6,(dword_FF8062+2).w
loc_9CC2:                               ; CODE XREF: UI_OptionsSelectCharacter+36   j
                movem.l d0,-(sp)
                move.b  #4,d0
                jsr (Input_ProcessButtons).l
                movem.l (sp)+,d0
                cmpi.b  #$98,d0
                bne.s   loc_9CDE
                clr.b   d0
                bra.s   loc_9CE0
; ---------------------------------------------------------------------------
loc_9CDE:                               ; CODE XREF: UI_OptionsSelectCharacter+8C   j
                addq.b  #1,d0
loc_9CE0:                               ; CODE XREF: UI_OptionsSelectCharacter+26   j
                                        ; UI_OptionsSelectCharacter+38   j ...
                move.b  d0,(dword_FF8066).w
                lea     (word_5A43E).l,a0
                asl.w   #1,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d1
                move.w  #$483C,d0
                bra.w Gfx_RenderDecimalDigits3
; End of function UI_OptionsSelectCharacter
; Handles secondary character selection in options menu
UI_OptionsSelectCharacter2:                               ; CODE XREF: UI_InitOptionsScreen+1A4   p  ; was: sub_9CFC
                                        ; DATA XREF: ROM:000098DE   o
                move.b  (dword_FF806A+2).w,d0
                tst.b   d5
                beq.s   loc_9D14
                lea     word_A284(pc),a0
                nop
                move.b  (a0,d0.w),d0
                jmp (Input_ProcessButtons).l
; ---------------------------------------------------------------------------
loc_9D14:                               ; CODE XREF: UI_OptionsSelectCharacter2+6   j
                moveq   #1,d1
                tst.w   (dword_FF8066+2).w
                bne.s   loc_9D36
                btst    #0,(word_FFA280+1).w
                bne.s   loc_9D6C
                btst    #2,(dword_FF806A+1).w
                bne.s   loc_9D44
                btst    #3,(dword_FF806A+1).w
                bne.s   loc_9D60
                bra.s   loc_9D6C
; ---------------------------------------------------------------------------
loc_9D36:                               ; CODE XREF: UI_OptionsSelectCharacter2+1E   j
                btst    #2,(dword_FF806A).w
                beq.s   loc_9D52
                move.w  #6,(dword_FF8062+2).w
loc_9D44:                               ; CODE XREF: UI_OptionsSelectCharacter2+2E   j
                tst.b   d0
                bne.s   loc_9D4E
                move.b  #$25,d0 ; '%'
                bra.s   loc_9D6C
; ---------------------------------------------------------------------------
loc_9D4E:                               ; CODE XREF: UI_OptionsSelectCharacter2+4A   j
                subq.w  #1,d0
                bra.s   loc_9D6C
; ---------------------------------------------------------------------------
loc_9D52:                               ; CODE XREF: UI_OptionsSelectCharacter2+40   j
                btst    #3,(dword_FF806A).w
                beq.s   loc_9D6C
                move.w  #6,(dword_FF8062+2).w
loc_9D60:                               ; CODE XREF: UI_OptionsSelectCharacter2+36   j
                cmpi.b  #$25,d0 ; '%'
                bne.s   loc_9D6A
                clr.b   d0
                bra.s   loc_9D6C
; ---------------------------------------------------------------------------
loc_9D6A:                               ; CODE XREF: UI_OptionsSelectCharacter2+68   j
                addq.w  #1,d0
loc_9D6C:                               ; CODE XREF: UI_OptionsSelectCharacter2+26   j
                                        ; UI_OptionsSelectCharacter2+38   j ...
                move.b  d0,(dword_FF806A+2).w
                lea     (word_5A43E).l,a0
                asl.w   #1,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d1
                move.w  #$493E,d0
                bra.w Gfx_RenderDecimalDigits2
; End of function UI_OptionsSelectCharacter2
; Renders toggle tiles for options menu row
UI_RenderOptionsToggleRow:
                lea     word_A220(pc),a1  ; was: sub_9D88
                nop
                lea     word_A22A(pc),a2
                nop
                movea.w #(word_FFFF2A-M68K_RAM),a4
                move.w  #$43B6,d6
                bra.w Gfx_RenderToggleTiles
; End of function UI_RenderOptionsToggleRow
; Renders second row of options with tile graphics
UI_OptionsRenderRow2:                               ; CODE XREF: UI_InitOptionsScreen+18C   p  ; was: sub_9DA0
                                        ; DATA XREF: ROM:000098D6   o
                lea     word_A220(pc),a1
                nop
                lea     word_A22A(pc),a2
                nop
                movea.w #(word_FFFF38-M68K_RAM),a4
                move.w  #$44B6,d6
                bra.w   loc_A050
; End of function UI_OptionsRenderRow2
; Renders third row of options with tile graphics
UI_OptionsRenderRow3:                               ; CODE XREF: UI_InitOptionsScreen+192   p  ; was: sub_9DB8
                                        ; DATA XREF: ROM:000098D8   o
                lea     word_A220(pc),a1
                nop
                lea     word_A22A(pc),a2
                nop
                movea.w #(word_FFFF38-M68K_RAM),a4
                move.w  #$45B6,d6
                bra.w Gfx_RenderToggleTiles
; End of function UI_OptionsRenderRow3
; Initializes options menu with objects palettes and cursor
Sys_InitOptionsMenuState:                               ; DATA XREF: Sys_DispatchGameState+A2   o  ; was: sub_9DD0
                tst.w   (GameSubstateIndex).w
                bne.s   loc_9E12
                jsr (Sys_InitGameMode).l
                movea.l #stru_A1F8,a0
                jsr     (LoadObjData).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                clr.b   (word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
loc_9E12:                               ; CODE XREF: Sys_InitOptionsMenuState+4   j
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                move.w  #$800,d0
                moveq   #0,d1
                jsr (Data_LoadPointerTable2).l
                lea     (byte_BA4A).l,a0
                jsr     (LoadPalette).l
                jsr (Gfx_FadePaletteTransition).l
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                move.w  #$FFF0,(dword_FFA904).w
                clr.w   (dword_FFA900).w
                jsr (Gfx_SetupScrollPlanes).l
                clr.w   (dword_FF8062+2).w
                clr.w   (dword_FF8062).w
                clr.w   (dword_FF805E).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                move.w  #$118,d0
                move.w  #$CA,d1
                move.l  #word_A36A,d2
                jsr (UI_InitCursorSprite).l
                clr.b   (dword_FF806A).w
                clr.b   (dword_FF806A+1).w
; End of function Sys_InitOptionsMenuState
; Main options menu loop handling input and updates
Sys_RunOptionsMenuLoop:                               ; DATA XREF: Sys_DispatchGameState+A6   o  ; was: sub_9E88
                bclr    #1,(word_FF80F4).w
                beq.s   loc_9EA0
                move.w  #$54,(GameModeIndex).w ; 'T'
                clr.w   (GameSubstateIndex).w
                jmp     loc_1CDB8
; ---------------------------------------------------------------------------
loc_9EA0:                               ; CODE XREF: Sys_RunOptionsMenuLoop+6   j
                tst.w   (word_FF80F2).w
                bne.s   loc_9EC2
                btst    #7,(word_FFF708).w
                beq.s   loc_9EC2
                move.b  #$C4,d0
                jsr (Input_ProcessButtons).l
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
loc_9EC2:                               ; CODE XREF: Sys_RunOptionsMenuLoop+1C   j
                                        ; Sys_RunOptionsMenuLoop+24   j
                jsr (Gfx_UpdateScrollPosition).l
                jsr (Sys_InitObjectPointers).l
                jsr (UI_CheckVBlankFlag).l
                jsr (Sys_ProcessVisibleObjects).l
                bsr.w UI_HandleOptionsNavigation
                jsr (Sys_UpdateObjectCount).l
                jsr (Sys_ProcessObjectList).l
                jsr (Gfx_FadePaletteTransition).l
                jmp Gfx_SetupScrollPlanes
; End of function Sys_RunOptionsMenuLoop
; Processes D-pad input for options menu cursor
UI_HandleOptionsNavigation:                               ; CODE XREF: Sys_RunOptionsMenuLoop+52   p  ; was: sub_9EF6
                bsr.w Gfx_UpdateCursorFlash
                btst    #0,(dword_FF805E+2).w
                bne.w UI_AnimateOptionsCursor
                move.w  (dword_FF805E).w,d0
                btst    #0,(word_FFF708).w
                beq.s   loc_9F28
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                subq.w  #2,d0
                bpl.s   loc_9F50
                moveq   #0,d0
loc_9F28:                               ; CODE XREF: UI_HandleOptionsNavigation+18   j
                btst    #1,(word_FFF708).w
                beq.w   loc_9F62
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                addq.w  #2,d0
                cmpi.w  #6,d0
                bmi.s   loc_9F50
                moveq   #6,d0
                bra.s   loc_9F62
; ---------------------------------------------------------------------------
loc_9F50:                               ; CODE XREF: UI_HandleOptionsNavigation+2E   j
                                        ; UI_HandleOptionsNavigation+54   j
                movem.l d0,-(sp)
                move.b  #$DB,d0
                jsr (Input_ProcessButtons).l
                movem.l (sp)+,d0
loc_9F62:                               ; CODE XREF: UI_HandleOptionsNavigation+38   j
                                        ; UI_HandleOptionsNavigation+58   j
                move.w  d0,(dword_FF805E).w
                move.w  word_9F84(pc,d0.w),(dword_FF8062).w
                move.b  (word_FFF708).w,(dword_FF806A).w
                move.b  (word_FFF706).w,(dword_FF806A+1).w
                move.b  (word_FFF708).w,d5
                andi.b  #$60,d5 ; '`'
                bra.w   loc_988E
; End of function UI_HandleOptionsNavigation
; ---------------------------------------------------------------------------
word_9F84:      dc.w 6, 8, $A, $C, $E


; Renders three decimal digits to VRAM for numeric display
Gfx_RenderDecimalDigits3:                               ; CODE XREF: UI_OptionsSelectCharacter+AC   j  ; was: sub_9F8E
                movea.w (word_FFF70E).w,a0
                move.b  d1,d2
                move.w  d1,d3
                asr.b   #4,d1
                asr.w   #8,d3
                andi.w  #$F,d1
                andi.w  #$F,d2
                andi.w  #1,d3
                asl.w   #1,d1
                asl.w   #1,d2
                asl.w   #1,d3
                addi.w  #-$5CFE,d1
                addi.w  #-$5CFE,d2
                addi.w  #-$5CFE,d3
                move.w  d3,(a0)+
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                addq.w  #1,d1
                addq.w  #1,d2
                addq.w  #1,d3
                move.w  d3,(a0)+
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                moveq   #3,d3
                bsr.w Gfx_QueueVRAMWrite
                addi.w  #$80,d0
                moveq   #3,d3
                bra.w Gfx_QueueVRAMWrite
; End of function Gfx_RenderDecimalDigits3
; Renders two decimal digits to VRAM for numeric display
Gfx_RenderDecimalDigits2:                               ; CODE XREF: UI_OptionsSelectCharacter2+88   j  ; was: sub_9FDA
                movea.w (word_FFF70E).w,a0
                move.b  d1,d2
                asr.b   #4,d1
                andi.w  #$F,d1
                andi.w  #$F,d2
                asl.w   #1,d1
                asl.w   #1,d2
                addi.w  #-$5CFE,d1
                addi.w  #-$5CFE,d2
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                addq.w  #1,d1
                addq.w  #1,d2
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                moveq   #2,d3
                bsr.w Gfx_QueueVRAMWrite
                addi.w  #$80,d0
                moveq   #2,d3
; End of function Gfx_RenderDecimalDigits2
; Queues VRAM write command with auto-increment for DMA transfer
Gfx_QueueVRAMWrite:                               ; CODE XREF: UI_OptionsUpdateButtons+86   p  ; was: sub_A00E
                                        ; UI_OptionsUpdateButtons+90   j ...
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                move.w  d0,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009300,-(a1)
                move.b  d3,3(a1)
                move.w  a1,(word_FFF70C).w
                asl.w   #1,d3
                add.w   d3,(word_FFF70E).w
                rts
; End of function Gfx_QueueVRAMWrite
; Renders toggle option tiles with on/off state highlighting
Gfx_RenderToggleTiles:                               ; CODE XREF: UI_RenderOptionsToggleRow+14   j  ; was: sub_A04C
                                        ; UI_OptionsRenderRow3+14   j
                moveq   #2,d5
                bra.s   loc_A052
; ---------------------------------------------------------------------------
loc_A050:                               ; CODE XREF: UI_OptionsRenderRow1+14   j
                                        ; UI_OptionsRenderRow2+14   j
                moveq   #1,d5
loc_A052:                               ; CODE XREF: Gfx_RenderToggleTiles+2   j
                btst    #2,(dword_FF806A).w
                beq.s   loc_A060
                bclr    d5,1(a4)
                bra.s   loc_A06C
; ---------------------------------------------------------------------------
loc_A060:                               ; CODE XREF: Gfx_RenderToggleTiles+C   j
                btst    #3,(dword_FF806A).w
                beq.s   loc_A072
                bset    d5,1(a4)
loc_A06C:                               ; CODE XREF: Gfx_RenderToggleTiles+12   j
                move.w  #$A,(dword_FF8062+2).w
loc_A072:                               ; CODE XREF: Gfx_RenderToggleTiles+1A   j
                move.w  #$2000,d1
                move.w  #$4000,d2
                btst    d5,1(a4)
                beq.s   loc_A088
                move.w  #$2000,d2
                move.w  #$4000,d1
loc_A088:                               ; CODE XREF: Gfx_RenderToggleTiles+32   j
                movea.w (word_FFF70E).w,a0
                moveq   #0,d7
loc_A08E:                               ; CODE XREF: Gfx_RenderToggleTiles+50   j
                move.w  (a1)+,d0
                cmpi.w  #$FFFF,d0
                beq.s   loc_A09E
                add.w   d1,d0
                move.w  d0,(a0)+
                addq.w  #1,d7
                bra.s   loc_A08E
; ---------------------------------------------------------------------------
loc_A09E:                               ; CODE XREF: Gfx_RenderToggleTiles+48   j
                                        ; Gfx_RenderToggleTiles+60   j
                move.w  (a2)+,d0
                cmpi.w  #$FFFF,d0
                beq.s   loc_A0AE
                add.w   d2,d0
                move.w  d0,(a0)+
                addq.w  #1,d7
                bra.s   loc_A09E
; ---------------------------------------------------------------------------
loc_A0AE:                               ; CODE XREF: Gfx_RenderToggleTiles+58   j
                movea.w (word_FFF70E).w,a1
                move.w  d7,d3
loc_A0B4:                               ; CODE XREF: Gfx_RenderToggleTiles+6E   j
                move.w  (a1)+,d0
                addq.w  #1,d0
                move.w  d0,(a0)+
                dbf     d3,loc_A0B4
                move.w  d6,d0
                move.w  d7,d3
                bsr.w Gfx_QueueVRAMWrite
                addi.w  #$80,d6
                move.w  d6,d0
                move.w  d7,d3
                bra.w Gfx_QueueVRAMWrite
; End of function Gfx_RenderToggleTiles
; Animates cursor movement to target position with smooth scrolling
UI_AnimateCursorToTarget:                               ; CODE XREF: UI_HandleOptionsInput+A   j  ; was: sub_A0D2
                movea.l #word_A112,a0
                movea.w #(Entity_ObjectPool-M68K_RAM),a1
                move.w  (dword_FF8062).w,d0
                clr.w   d2
                move.w  (a0,d0.w),d1
                sub.w   $14(a1),d1
                bmi.s   loc_A0F8
                cmpi.w  #2,d1
                bmi.s   loc_A0FE
                addq.w  #2,$14(a1)
                rts
; ---------------------------------------------------------------------------
loc_A0F8:                               ; CODE XREF: UI_AnimateCursorToTarget+18   j
                cmpi.w  #$FFFE,d1
                bmi.s UI_DecrementCursorY
loc_A0FE:                               ; CODE XREF: UI_AnimateCursorToTarget+1E   j
                move.w  (a0,d0.w),$14(a1)
                bclr    #0,(dword_FF805E+2).w
                rts
; ---------------------------------------------------------------------------
; Decrements cursor Y position by 2 pixels for upward navigation
UI_DecrementCursorY:                               ; CODE XREF: UI_AnimateCursorToTarget+2A   j  ; was: loc_A10C
                subq.w  #2,$14(a1)
                rts
; End of function UI_AnimateCursorToTarget
; ---------------------------------------------------------------------------
word_A112:      dc.w $B3, $D3, $E3, $FB, $10B, $11B
                                        ; DATA XREF: UI_AnimateCursorToTarget   o


; Smoothly animates cursor to selected menu option
UI_AnimateOptionsCursor:                               ; CODE XREF: UI_HandleOptionsNavigation+A   j  ; was: sub_A11E
                lea     word_A15E(pc),a0
                nop
                movea.w #(Entity_ObjectPool-M68K_RAM),a1
                move.w  (dword_FF805E).w,d0
                clr.w   d2
                move.w  (a0,d0.w),d1
                sub.w   $14(a1),d1
                bmi.s   loc_A144
                cmpi.w  #2,d1
                bmi.s   loc_A14A
                addq.w  #2,$14(a1)
                rts
; ---------------------------------------------------------------------------
loc_A144:                               ; CODE XREF: UI_AnimateOptionsCursor+18   j
                cmpi.w  #$FFFE,d1
                bmi.s   loc_A158
loc_A14A:                               ; CODE XREF: UI_AnimateOptionsCursor+1E   j
                move.w  (a0,d0.w),$14(a1)
                bclr    #0,(dword_FF805E+2).w
                rts
; ---------------------------------------------------------------------------
loc_A158:                               ; CODE XREF: UI_AnimateOptionsCursor+2A   j
                subq.w  #2,$14(a1)
                rts
; End of function UI_AnimateOptionsCursor
; ---------------------------------------------------------------------------
word_A15E:      dc.w $CA, $DA, $EA, $FA, $10A
                                        ; DATA XREF: UI_AnimateOptionsCursor   o


; Updates cursor flash animation timer and palette
Gfx_UpdateCursorFlash:                               ; CODE XREF: UI_HandleOptionsInput   p  ; was: sub_A168
                                        ; sub_9EF6   p ...
                move.w  (dword_FF8062+2).w,d0
                beq.s   loc_A174
                subq.w  #2,d0
                move.w  d0,(dword_FF8062+2).w
loc_A174:                               ; CODE XREF: Gfx_UpdateCursorFlash+4   j
                andi.w  #$E,d0
                move.w  word_A180(pc,d0.w),(word_FFE35C).w
                rts
; End of function Gfx_UpdateCursorFlash
; ---------------------------------------------------------------------------
word_A180:      dc.w $200, $400, $620, $840, $A60, $C82, $EA4, $EC6


; Updates menu palette based on frame counter for color cycling
Gfx_UpdateMenuPalette:                               ; CODE XREF: UI_HandleTitleInput+110   p  ; was: sub_A190
                                        ; sub_9774:loc_97B4   p ...
                move.w  (word_FFA280).w,d1
                asl.w   #1,d1
                andi.w  #2,d1
                move.w  word_A1AE(pc,d1.w),d0
                move.w  d0,(word_FFE376).w
                addq.w  #4,d1
                move.w  word_A1AE(pc,d1.w),d0
                move.w  d0,(word_FFE37E).w
                rts
; End of function Gfx_UpdateMenuPalette
; ---------------------------------------------------------------------------
word_A1AE:      dc.w $E00, $E44, $4C4, $40
stru_A1B6:      dc.w 3                  ; field_0
                                        ; DATA XREF: UI_InitTitleScreen+12   o
                                        ; UI_InitializeSEGAScreen+1C   o
                dc.l byte_182F24        ; field_2
                dc.w 0                  ; field_6
                dc.w 3                  ; field_0
                dc.l byte_184378        ; field_2
                dc.w $2000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1814D4       ; field_2
                dc.w $3000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_182C9C        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_182CE2        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_184590        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_184688        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18454C        ; field_2
                dc.w $7000              ; field_6
                dc.w $FFFF
stru_A1F8:      dc.w 3                  ; field_0
                                        ; DATA XREF: UI_InitOptionsScreen+C   o
                                        ; Sys_InitOptionsMenuState+C   o ...
                dc.l byte_182F24        ; field_2
                dc.w $2000              ; field_6
                dc.w 3                  ; field_0
                dc.l byte_184378        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_184590        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_184688        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18454C        ; field_2
                dc.w $7000              ; field_6
word_A220:      dc.w $8332, $8330, $8300, $8300, $FFFF
                                        ; DATA XREF: UI_RenderOptionsToggleRow   o
                                        ; sub_9DA0   o ...
word_A22A:      dc.w $8332, $8320, $8320, $FFFF
                                        ; DATA XREF: UI_RenderOptionsToggleRow+6   o
                                        ; UI_OptionsRenderRow2+6   o ...
word_A232:      dc.w $833A, $833E, $8334, $831E, $8338, $831E, $8316, $833A, $8346, $8300, $FFFF
                                        ; DATA XREF: UI_OptionsRenderRow1   o
word_A248:      dc.w $833A, $833E, $8334, $831E, $8338, $8324, $8316, $8338, $831C, $FFFF
                                        ; DATA XREF: UI_OptionsRenderRow1+6   o
                dc.w $8330, $8332, $8338, $832E, $8316, $832C, $8300, $FFFF, $831C, $8326
                dc.w $8338, $831E, $831A, $833C, $831E, $8338, $831A, $833E, $833C, $FFFF
word_A284:      dc.w $1011, $1213, $1415, $1617, $1819, $1A1B, $1C1D, $1E1F, $2023, $2425
                                        ; DATA XREF: UI_OptionsSelectCharacter2+8   o
                dc.w $2628, $2A2B, $2C2D, $2E2F, $3031, $3233, $3536, $3738, $393A
LatinAlphabet:  dc.b $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
                                        ; DATA XREF: UI_OptionsSelectCharacter+8   o
                dc.b $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
                dc.b $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
                dc.b $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
byte_A2EA:      dc.b $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF
                dc.b $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
                dc.b $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
                dc.b $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
                dc.b $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7, $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
                dc.b $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $FB, $FC, $FF


; Initializes cursor sprite with position and graphics pointer
UI_InitCursorSprite:                               ; CODE XREF: UI_InitOptionsScreen+176   p  ; was: sub_A346
                                        ; Sys_InitOptionsMenuState+AA   p ...
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$F8,(a0)
                move.w  #$CC00,2(a0)
                move.w  #0,$E(a0)
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,8(a0)
                rts
; End of function UI_InitCursorSprite
; Empty entity state handler in main dispatch table
Entity_EmptyState5:                              ; DATA XREF: ROM:off_5DC   o  ; was: nullsub_5
                rts
; End of function Entity_EmptyState5
; ---------------------------------------------------------------------------
word_A36A:      dc.w $4101, $E00, $F400 ; DATA XREF: UI_InitOptionsScreen+170   o
                                        ; Sys_InitOptionsMenuState+A4   o
                dc.w $4101, $E00, $F420
                dc.w $4101, $E00, $F440
                dc.w $4101, $E00, $F460
                dc.w $4101, $E00, $F4E0
                dc.w $4101, $E00, $F4C0
                dc.w $C101, $E00, $F4A0
word_A394:      dc.w $C101, $600, $F4F8 ; DATA XREF: UI_HandlePasswordInput+5C   o
word_A39A:      dc.w $C101, $E00, $F4F0 ; DATA XREF: UI_HandlePasswordInput:loc_A716   o


; Initializes password entry screen with input fields
UI_InitPasswordScreen:                               ; DATA XREF: Sys_DispatchGameState+9A   o  ; was: sub_A3A0
                tst.w   (GameSubstateIndex).w
                bne.s UI_InitPasswordDisplay
                jsr (Sys_InitGameMode).l
                movea.l #stru_A1F8,a0
                jsr     (LoadObjData).l
                jsr (Sys_ClearBossDataBuffer).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
; Initializes password screen display with graphics data and palette loading
UI_InitPasswordDisplay:                               ; CODE XREF: UI_InitPasswordScreen+4   j  ; was: loc_A3EA
                move.w  #$48,(GameModeIndex).w ; 'H'
                clr.w   (GameSubstateIndex).w
                move.w  #$400,d0
                moveq   #0,d1
                jsr (Data_LoadPointerTable2).l
                lea     (dword_11336).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                move.w  d0,(dword_FFA908).w
                move.w  d1,(dword_FFA90C).w
                jsr (Gfx_DirectVRAMTransfer).l
                lea     (byte_BA4A).l,a0
                jsr     (LoadPalette).l
                lea     word_A4AC(pc),a0
                nop
                movea.w #(byte_FFE322-M68K_RAM),a1
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                jsr (Gfx_FadePaletteTransition).l
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                jsr (Gfx_SetupScrollPlanes).l
                move.w  #$F4,d0
                move.w  #$DA,d1
                move.l  #$A394,d2
                bsr.w UI_InitCursorSprite
                clr.w   (dword_FF8062+2).w
                clr.w   (dword_FF8066+2).w
                move.b  #$F,(dword_FF806A).w
                move.w  #$18,(dword_FF806A+2).w
                clr.w   (word_FF806E).w
                lea     (byte_477C).l,a0
                move.w  #$A300,d0
                move.w  #$4A14,d4
                jsr (UI_RenderTextStringWrapped).l
                rts
; End of function UI_InitPasswordScreen
; ---------------------------------------------------------------------------
word_A4AC:      dc.w $20, $AEC, $8CA, $6A8, $486
                                        ; DATA XREF: UI_InitPasswordScreen+88   o


; Updates password screen with input processing and text rendering
UI_UpdatePasswordScreen:                               ; DATA XREF: Sys_DispatchGameState+9E   o  ; was: sub_A4B6
                bclr    #1,(word_FF80F4).w
                beq.s   loc_A4CE
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jmp     loc_1CDB8
; ---------------------------------------------------------------------------
loc_A4CE:                               ; CODE XREF: UI_UpdatePasswordScreen+6   j
                tst.w   (word_FF80F2).w
                bne.s   loc_A4EC
                btst    #7,(word_FFF708).w
                beq.s   loc_A4EC
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
loc_A4EC:                               ; CODE XREF: UI_UpdatePasswordScreen+1C   j
                                        ; UI_UpdatePasswordScreen+24   j
                jsr (Gfx_UpdateCursorFlash).l
                jsr (Gfx_UpdateMenuPalette).l
                jsr (Gfx_UpdateScrollPosition).l
                jsr (Sys_InitObjectPointers).l
                jsr (UI_CheckVBlankFlag).l
                bsr.w UI_HandlePasswordInput
                movea.w #(word_FF9900-M68K_RAM),a0
                move.w  #$8300,d0
                move.w  #$4714,d4
                jsr (UI_RenderTextStringWrapped).l
                movea.w #(byte_FF9980-M68K_RAM),a0
                move.w  #$8300,d0
                move.w  #$4814,d4
                jsr (UI_RenderTextStringWrapped).l
                jsr (Sys_ProcessVisibleObjects).l
                jsr (Sys_UpdateObjectCount).l
                jsr (Sys_ProcessObjectList).l
                jsr (Gfx_FadePaletteTransition).l
                jmp Gfx_SetupScrollPlanes
; End of function UI_UpdatePasswordScreen
; Handles password digit input and validation logic
UI_HandlePasswordInput:                               ; CODE XREF: UI_UpdatePasswordScreen+54   p  ; was: sub_A550
                tst.w   (word_FF806E).w
                bne.w   loc_A6CE
                move.w  (dword_FF8066+2).w,d0
                moveq   #0,d1
                btst    #2,(word_FFF708).w
                beq.s   loc_A576
                moveq   #2,d1
                move.w  #$10,(dword_FF8062+2).w
                subq.w  #2,d0
                bpl.s   loc_A592
                moveq   #0,d0
                bra.s   loc_A5A4
; ---------------------------------------------------------------------------
loc_A576:                               ; CODE XREF: UI_HandlePasswordInput+14   j
                btst    #3,(word_FFF708).w
                beq.s   loc_A5A4
                moveq   #2,d1
                move.w  #$10,(dword_FF8062+2).w
                addq.w  #2,d0
                cmpi.w  #$A,d0
                bmi.s   loc_A592
                moveq   #8,d0
                bra.s   loc_A5A4
; ---------------------------------------------------------------------------
loc_A592:                               ; CODE XREF: UI_HandlePasswordInput+20   j
                                        ; UI_HandlePasswordInput+3C   j
                movem.l d0-d1,-(sp)
                move.b  #$DB,d0
                jsr (Input_ProcessButtons).l
                movem.l (sp)+,d0-d1
loc_A5A4:                               ; CODE XREF: UI_HandlePasswordInput+24   j
                                        ; UI_HandlePasswordInput+2C   j ...
                move.w  d0,(dword_FF8066+2).w
                move.w  d1,(word_FF806E).w
                move.l  #word_A394,(dword_FFC628).w
                cmpi.w  #8,d0
                beq.w   loc_A716
                lea     byte_A8F6(pc),a0
                nop
                bsr.w UI_SetPasswordRow1Buffer
                bsr.w UI_RenderPasswordText
                move.b  (word_FFF706).w,d0
                andi.b  #$F,d0
                cmp.b   (dword_FF806A).w,d0
                bne.s   loc_A5DE
                subq.w  #1,(dword_FF806A+2).w
                bra.s   loc_A5E8
; ---------------------------------------------------------------------------
loc_A5DE:                               ; CODE XREF: UI_HandlePasswordInput+86   j
                move.b  d0,(dword_FF806A).w
                move.w  #$18,(dword_FF806A+2).w
loc_A5E8:                               ; CODE XREF: UI_HandlePasswordInput+8C   j
                moveq   #0,d0
                movea.w #(word_FFF708-M68K_RAM),a1
                tst.w   (dword_FF806A+2).w
                bpl.s   loc_A606
                move.w  #$FFFF,(dword_FF806A+2).w
                movea.w #(word_FFF706-M68K_RAM),a1
                btst    #0,(word_FFA280+1).w
                beq.s   loc_A630
loc_A606:                               ; CODE XREF: UI_HandlePasswordInput+A2   j
                btst    #0,(a1)
                beq.s   loc_A61C
                moveq   #$FFFFFFFF,d0
                cmpa.w  #$F708,a1
                bne.s   loc_A630
                move.w  #$A,(dword_FF8062+2).w
                bra.s   loc_A630
; ---------------------------------------------------------------------------
loc_A61C:                               ; CODE XREF: UI_HandlePasswordInput+BA   j
                btst    #1,(a1)
                beq.s   loc_A630
                moveq   #1,d0
                cmpa.w  #$F708,a1
                bne.s   loc_A630
                move.w  #$A,(dword_FF8062+2).w
loc_A630:                               ; CODE XREF: UI_HandlePasswordInput+B4   j
                                        ; UI_HandlePasswordInput+C2   j ...
                move.w  (dword_FF8066+2).w,d4
                movea.w #(word_FFFF38+1-M68K_RAM),a0
loc_A638:                               ; CODE XREF: UI_HandlePasswordInput+EC   j
                addq.w  #1,a0
                subq.w  #2,d4
                bpl.s   loc_A638
                move.b  (a0),d1
                add.w   d0,d1
                move.b  d1,(a0)
                movea.w #(dword_FFFF3A-M68K_RAM),a0
                move.b  (a0),d0
                bne.s   loc_A64E
                moveq   #1,d0
loc_A64E:                               ; CODE XREF: UI_HandlePasswordInput+FA   j
                cmpi.b  #$A,d0
                bmi.s   loc_A656
                moveq   #$A,d0
loc_A656:                               ; CODE XREF: UI_HandlePasswordInput+102   j
                move.b  d0,(a0)+
                move.b  (a0),d1
                bne.s   loc_A65E
                moveq   #1,d1
loc_A65E:                               ; CODE XREF: UI_HandlePasswordInput+10A   j
                cmpi.b  #$A,d1
                bmi.s   loc_A666
                moveq   #$A,d1
loc_A666:                               ; CODE XREF: UI_HandlePasswordInput+112   j
                move.b  d1,(a0)+
                move.b  (a0),d2
                bne.s   loc_A66E
                moveq   #1,d2
loc_A66E:                               ; CODE XREF: UI_HandlePasswordInput+11A   j
                cmpi.b  #$A,d2
                bmi.s   loc_A676
                moveq   #$A,d2
loc_A676:                               ; CODE XREF: UI_HandlePasswordInput+122   j
                move.b  d2,(a0)+
                move.b  (a0),d3
                bne.s   loc_A67E
                moveq   #1,d3
loc_A67E:                               ; CODE XREF: UI_HandlePasswordInput+12A   j
                cmpi.b  #$A,d3
                bmi.s   loc_A686
                moveq   #$A,d3
loc_A686:                               ; CODE XREF: UI_HandlePasswordInput+132   j
                move.b  d3,(a0)+
                movea.w #(word_FF9800-M68K_RAM),a0
                move.b  d0,(a0)+
                move.b  #0,(a0)+
                move.b  d1,(a0)+
                move.b  #0,(a0)+
                move.b  d2,(a0)+
                move.b  #0,(a0)+
                move.b  d3,(a0)+
                move.b  #0,(a0)+
                move.b  #$2E,(a0)+ ; '.'
                move.b  #0,(a0)+
                move.b  #$1D,(a0)+
                move.b  #$F,(a0)+
                move.b  #$1E,(a0)+
                move.b  #$FF,(a0)+
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  #$A300,d0
                move.w  #$451C,d4
                jmp (UI_RenderTextStringWrapped).l
; ---------------------------------------------------------------------------
loc_A6CE:                               ; CODE XREF: UI_HandlePasswordInput+4   j
                movea.l #word_A70C,a0
                movea.w #(Entity_ObjectPool-M68K_RAM),a1
                move.w  (dword_FF8066+2).w,d0
                clr.w   d2
                move.w  (a0,d0.w),d1
                sub.w   $10(a1),d1
                bmi.s   loc_A6F4
                cmpi.w  #4,d1
                bmi.s   loc_A6FA
                addq.w  #4,$10(a1)
                rts
; ---------------------------------------------------------------------------
loc_A6F4:                               ; CODE XREF: UI_HandlePasswordInput+196   j
                cmpi.w  #$FFFC,d1
                bmi.s   loc_A706
loc_A6FA:                               ; CODE XREF: UI_HandlePasswordInput+19C   j
                move.w  (a0,d0.w),$10(a1)
                clr.w   (word_FF806E).w
                rts
; ---------------------------------------------------------------------------
loc_A706:                               ; CODE XREF: UI_HandlePasswordInput+1A8   j
                subq.w  #4,$10(a1)
locret_A70A:                            ; CODE XREF: UI_HandlePasswordInput+1DE   j
                rts
; ---------------------------------------------------------------------------
word_A70C:      dc.w $F4, $104, $114, $124, $14C
                                        ; DATA XREF: UI_HandlePasswordInput:loc_A6CE   o
; ---------------------------------------------------------------------------
loc_A716:                               ; CODE XREF: UI_HandlePasswordInput+68   j
                move.l  #word_A39A,(dword_FFC628).w
                move.b  #$F,(dword_FF806A).w
                move.w  #$18,(dword_FF806A+2).w
                tst.w   (word_FF806E).w
                bne.s   locret_A70A
                move.l  (dword_FFFF3A).w,d0
                moveq   #0,d4
                moveq   #1,d5
                lea     word_A82A(pc),a0
                nop
loc_A73E:                               ; CODE XREF: UI_HandlePasswordInput+204   j
                addq.b  #1,d4
                cmpi.w  #$FFFF,(a0)
                beq.w   loc_A7DC
                moveq   #0,d3
                cmp.l   (a0)+,d0
                beq.s   loc_A756
                moveq   #2,d3
                cmp.l   (a0)+,d0
                beq.s   loc_A756
                bne.s   loc_A73E
loc_A756:                               ; CODE XREF: UI_HandlePasswordInput+1FC   j
                                        ; UI_HandlePasswordInput+202   j
                move.w  d3,(word_FF805C).w
                move.w  d4,(dword_FF805E).w
                lea     byte_A91C(pc),a0
                nop
                move.w  (word_FF805C).w,d0
                beq.s   loc_A770
                lea     byte_A95A(pc),a0
                nop
loc_A770:                               ; CODE XREF: UI_HandlePasswordInput+218   j
                bsr.w UI_SetPasswordRow1Buffer
                lea     byte_A932(pc),a0
                nop
                bsr.w UI_RenderPasswordText
                move.w  (dword_FF805E).w,d0
                lea     (word_5A43E).l,a0
                asl.w   #1,d0
                move.w  (a0,d0.w),d0
                move.b  d0,d1
                asr.b   #4,d1
                addq.w  #1,d0
                addq.w  #1,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                move.b  d0,(byte_FF9907).w
                move.b  d1,(byte_FF9906).w
                btst    #5,(word_FFF708).w
                beq.s   locret_A7DA
                move.w  (dword_FF805E).w,d0
                subq.w  #1,d0
                asl.w   #1,d0
                move.w  d0,(StageTableIndex).w
                move.w  (word_FF805C).w,(word_FFFF0E).w
                move.b  #$AD,d0
                jsr (Input_ProcessButtons).l
                move.w  #$70,(GameModeIndex).w ; 'p'
                clr.w   (GameSubstateIndex).w
                jmp UI_SetPasswordConfirmFlag
; ---------------------------------------------------------------------------
locret_A7DA:                            ; CODE XREF: UI_HandlePasswordInput+25C   j
                                        ; UI_HandlePasswordInput+2A0   j
                rts
; ---------------------------------------------------------------------------
loc_A7DC:                               ; CODE XREF: UI_HandlePasswordInput+1F4   j
                lea     byte_A909(pc),a0
                nop
                bsr.w UI_SetPasswordRow1Buffer
                bsr.w UI_RenderPasswordText
                btst    #5,(word_FFF708).w
                beq.s   locret_A7DA
                move.b  #$BB,d0
                jmp (Input_ProcessButtons).l
; End of function UI_HandlePasswordInput
; Sets text buffer pointer to first password display row
UI_SetPasswordRow1Buffer:                               ; CODE XREF: UI_HandlePasswordInput+72   p  ; was: sub_A7FC
                                        ; sub_A550:loc_A770   p ...
                movea.w #(word_FF9900-M68K_RAM),a1
                bra.s   loc_A806
; End of function UI_SetPasswordRow1Buffer
; Renders password text string to specified buffer
UI_RenderPasswordText:                               ; CODE XREF: UI_HandlePasswordInput+76   p  ; was: sub_A802
                                        ; UI_HandlePasswordInput+22A   p ...
                movea.w #(byte_FF9980-M68K_RAM),a1
loc_A806:                               ; CODE XREF: UI_SetPasswordRow1Buffer+4   j
                movea.w a1,a2
                moveq   #0,d0
                moveq   #$17,d7
loc_A80C:                               ; CODE XREF: UI_RenderPasswordText+C   j
                move.b  d0,(a2)+
                dbf     d7,loc_A80C
                move.b  #$FF,(a2)
                moveq   #0,d0
                move.b  (a0)+,d0
                adda.w  d0,a1
; Parses next character from password string until FF terminator
UI_ParsePasswordChar:                               ; CODE XREF: UI_RenderPasswordText+24   j  ; was: loc_A81C
                move.b  (a0)+,d0
                cmpi.b  #$FF,d0
                beq.s   locret_A828
                move.b  d0,(a1)+
                bra.s UI_ParsePasswordChar
; ---------------------------------------------------------------------------
locret_A828:                            ; CODE XREF: UI_RenderPasswordText+20   j
                rts
; End of function UI_RenderPasswordText
; ---------------------------------------------------------------------------
word_A82A:      dc.w $20A, $906, $20A, $906, $407, $A09, $407, $A09, $103, $608
                                        ; DATA XREF: UI_HandlePasswordInput+1E8   o
                                        ; UI_RenderContinueText+1A   o
                dc.w $103, $608, $408, $506, $408, $506, $806, $602, $806, $602
                dc.w $908, $A01, $908, $A01, $602, $A07, $602, $A07, $506, $70A
                dc.w $506, $70A, $901, $A02, $901, $A02, $904, $207, $904, $207
                dc.w $705, $103, $705, $103, $A09, $805, $A09, $805, $20A, $401
                dc.w $20A, $401, $307, $304, $307, $304, $704, $906, $704, $906
                dc.w $808, $50A, $808, $50A, $403, $809, $403, $809, $201, $40A
                dc.w $201, $40A, $A01, $103, $A01, $103, $309, $809, $309, $809
                dc.w $409, $A05, $409, $A05, $50A, $204, $50A, $204, $309, $603
                dc.w $309, $603, $805, $107, $805, $107, $603, $90A, $603, $90A
                dc.w $FFFF, $FFFF
byte_A8F6:      dc.b 3, $13, $18, $1A, $1F, $1E, 0, $1A, $B
                                        ; DATA XREF: UI_HandlePasswordInput+6C   o
                dc.b $1D, $1D, $21, $19, $1C, $E, $FF, 3, 0
                dc.b $FF
byte_A909:      dc.b 3, $1A, $B, $1D, $1D, $21, $19, $1C, $E
                                        ; DATA XREF: UI_HandlePasswordInput:loc_A7DC   o
                dc.b 0, $F, $1C, $1C, $19, $1C, $FF, 0, 0
                dc.b $FF
byte_A91C:      dc.b 0, $1D, $1E, $B, $11, $F, $2E, 0, 0
                                        ; DATA XREF: UI_HandlePasswordInput+20E   o
                dc.b 0, 0, $16, $F, $20, $F, $16, $2E, $F
                dc.b $B, $1D, $23, $FF
byte_A932:      dc.b 3, $1A, $1C, $F, $1D, $1D, 0, $D, 0, $C
                                        ; DATA XREF: UI_HandlePasswordInput+224   o
                dc.b $1F, $1E, $1E, $19, $18, $FF, 0, $1D, $1E, $B
                dc.b $11, $F, $2E, 0, 0, 0, 0, $16, $F, $20
                dc.b $F, $16, $2E, $18, $19, $1C, $17, $B, $16, $FF
byte_A95A:      dc.b 0, $1D, $1E, $B, $11, $F, $2E, 0, 0
                                        ; DATA XREF: UI_HandlePasswordInput+21A   o
                dc.b 0, 0, $16, $F, $20, $F, $16, $2E, $12
                dc.b $B, $1C, $E, $FF


; Player behavior state dispatcher
Player_BehaviorDispatcher:                               ; CODE XREF: Sys_GameplayMainLoop+15E   p  ; was: sub_A970
                tst.b   (byte_FF813E).w
                bpl.s   loc_A978
locret_A976:                            ; CODE XREF: Player_BehaviorDispatcher+C   j
                rts
; ---------------------------------------------------------------------------
loc_A978:                               ; CODE XREF: Player_BehaviorDispatcher+4   j
                tst.w   (word_FF80C2).w
                beq.s   locret_A976
                btst    #0,(byte_FF80A8).w
                bne.s   loc_A992
                move.b  (word_FFF708).w,d0
                andi.b  #$70,d0 ; 'p'
                move.b  d0,(byte_FF8310).w
loc_A992:                               ; CODE XREF: Player_BehaviorDispatcher+14   j
                move.w  (word_FF80C2).w,d0
                movea.w off_A9A2(pc,d0.w),a0
                adda.l  #Player_AdvanceBehaviorState,a0
                jmp     (a0)
; End of function Player_BehaviorDispatcher
; ---------------------------------------------------------------------------
off_A9A2:       dc.w Text_EmptyDisplayState-Player_AdvanceBehaviorState
                dc.w Player_AdvanceBehaviorAlt-Player_AdvanceBehaviorState
                dc.w Text_StartDisplaySequence-Player_AdvanceBehaviorState
                dc.w Text_ParseScriptCommand-Player_AdvanceBehaviorState
                dc.w Gfx_RenderTextCharacter-Player_AdvanceBehaviorState
                dc.w Gfx_FlushTextBuffer-Player_AdvanceBehaviorState
                dc.w Gfx_RenderTextGlyph-Player_AdvanceBehaviorState
                dc.w Player_ResetBehaviorPalette-Player_AdvanceBehaviorState
                dc.w Player_AdvanceBehaviorAlt-Player_AdvanceBehaviorState
                dc.w Text_StartDisplaySequence-Player_AdvanceBehaviorState
                dc.w Text_ParseScriptCommand-Player_AdvanceBehaviorState
                dc.w Gfx_RenderTextCharacter-Player_AdvanceBehaviorState
                dc.w Gfx_FlushTextBuffer-Player_AdvanceBehaviorState
                dc.w Gfx_RenderTextGlyph-Player_AdvanceBehaviorState
                dc.w Player_ProcessBehaviorTimer-Player_AdvanceBehaviorState
                dc.w Text_BeginVictorySequence-Player_AdvanceBehaviorState
                dc.w Text_UpdateAnimation-Player_AdvanceBehaviorState
                dc.w Text_AdvancePhase-Player_AdvanceBehaviorState
                dc.w Text_AnimateMovement-Player_AdvanceBehaviorState
                dc.w Player_AdvanceBehaviorState-Player_AdvanceBehaviorState
                dc.w Text_ParseScriptCommand-Player_AdvanceBehaviorState
                dc.w Gfx_RenderTextCharacter-Player_AdvanceBehaviorState
                dc.w Player_ResetBehaviorState-Player_AdvanceBehaviorState
                dc.w Text_InitVictoryMessage-Player_AdvanceBehaviorState
                dc.w Text_StartWeaponAcquired-Player_AdvanceBehaviorState
                dc.w Text_AnimateRotationFade-Player_AdvanceBehaviorState
                dc.w Text_AnimateRotationStop-Player_AdvanceBehaviorState
                dc.w Text_CompleteWithSound-Player_AdvanceBehaviorState
                dc.w Text_AnimateRiseUp-Player_AdvanceBehaviorState
                dc.w Text_PauseBeforeExit-Player_AdvanceBehaviorState
                dc.w Text_AnimateExitUp-Player_AdvanceBehaviorState
                dc.w Text_FinalizeAndSaveScore-Player_AdvanceBehaviorState
                dc.w Text_FinalizeAndSaveScore-Player_AdvanceBehaviorState
                dc.w Cutscene_FadeInShipNameAlt-Player_AdvanceBehaviorState
                dc.w Cutscene_FadeInShipNameAlt-Player_AdvanceBehaviorState
                dc.w Cutscene_FadeInShipNameAlt-Player_AdvanceBehaviorState
                dc.w Cutscene_FadeOutShipNameAlt-Player_AdvanceBehaviorState
                dc.w Cutscene_WaitFrameTimer-Player_AdvanceBehaviorState
                dc.w Text_EmptyDisplayState-Player_AdvanceBehaviorState
                dc.w Text_EmptyDisplayState-Player_AdvanceBehaviorState
                dc.w Player_Initialize-Player_AdvanceBehaviorState
                dc.w Text_DisplayStageTitle-Player_AdvanceBehaviorState
                dc.w UI_DisplayScoreAnimation-Player_AdvanceBehaviorState
                dc.w Text_InitGradeDisplay-Player_AdvanceBehaviorState
                dc.w Text_DisplayGradeText-Player_AdvanceBehaviorState
                dc.w Text_AnimateGradeFlash-Player_AdvanceBehaviorState
                dc.w Text_InitPauseTimer-Player_AdvanceBehaviorState
                dc.w Text_PauseTimer_CountdownLoop-Player_AdvanceBehaviorState


; Increments player behavior state counter by 2
Player_AdvanceBehaviorState:                               ; DATA XREF: Player_BehaviorDispatcher+2A   o  ; was: sub_AA02
                                        ; ROM:off_A9A2   o ...
                addq.w  #2,(word_FF80C2).w
                rts
; End of function Player_AdvanceBehaviorState
; Clears player behavior state counter to 0
Player_ResetBehaviorState:                               ; DATA XREF: ROM:0000A9CE   o  ; was: sub_AA08
                clr.w   (word_FF80C2).w
                rts
; End of function Player_ResetBehaviorState
; Increments player behavior state counter by 2
Player_AdvanceBehaviorAlt:                               ; DATA XREF: ROM:0000A9A4   o  ; was: sub_AA0E
                                        ; ROM:0000A9B2   o
                addq.w  #2,(word_FF80C2).w
                rts
; End of function Player_AdvanceBehaviorAlt
; Resets behavior state and processes palette slots
Player_ResetBehaviorPalette:                               ; DATA XREF: ROM:0000A9B0   o  ; was: sub_AA14
                clr.w   (word_FF80C2).w
loc_AA18:                               ; CODE XREF: Player_ProcessBehaviorTimer   p
                bclr    #7,(byte_FFFF31).w
                bsr.s Gfx_QueueThreeHScrollDMAs
                jmp Gfx_ProcessPaletteSlots
; End of function Player_ResetBehaviorPalette
; Queues three DMA transfers for horizontal scroll data
Gfx_QueueThreeHScrollDMAs:                               ; CODE XREF: Player_ResetBehaviorPalette+A   p  ; was: sub_AA26
                movea.w (word_FFF70C).w,a1
                move.l  #$180060,d0
                move.w  #$5080,d7
                bsr.s Gfx_QueueSingleHScrollDMA
                move.l  #$18006C,d0
                move.w  #$5100,d7
                bsr.s Gfx_QueueSingleHScrollDMA
                move.l  #$180078,d0
                move.w  #$5180,d7
                bsr.s Gfx_QueueSingleHScrollDMA
                move.w  a1,(word_FFF70C).w
                rts
; End of function Gfx_QueueThreeHScrollDMAs
; Configures and queues single DMA for horizontal scroll
Gfx_QueueSingleHScrollDMA:                               ; CODE XREF: Gfx_QueueThreeHScrollDMAs+E   p  ; was: sub_AA54
                                        ; Gfx_QueueThreeHScrollDMAs+1A   p ...
                move.w  #$83,-(a1)
                move.w  d7,-(a1)
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.b  d2,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  #$94009306,-(a1)
                rts
; End of function Gfx_QueueSingleHScrollDMA
; Handles behavior timer countdown and state advancement
Player_ProcessBehaviorTimer:                               ; DATA XREF: ROM:0000A9BE   o  ; was: sub_AA86
                bsr.s   loc_AA18
                subq.w  #1,(dword_FF80CE).w
                bpl.s   locret_AAA0
                addq.w  #2,(word_FF80C2).w
                move.l  #word_B544,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
locret_AAA0:                            ; CODE XREF: Player_ProcessBehaviorTimer+6   j
                rts
; End of function Player_ProcessBehaviorTimer
; Starts victory text display sequence with sound
Text_BeginVictorySequence:                               ; DATA XREF: ROM:0000A9C0   o  ; was: sub_AAA2
                bsr.w Text_DisplayCharacter
                cmpi.w  #$1E,(word_FF80C2).w
                beq.s   locret_AAC4
                move.b  #$16,d0
                jsr (Sound_PlaySFX).l
                move.w  #$60,(word_FF80C6).w ; '`'
                move.w  #$64,(dword_FF80CE).w ; 'd'
locret_AAC4:                            ; CODE XREF: Text_BeginVictorySequence+A   j
                rts
; End of function Text_BeginVictorySequence
; Updates text animation with countdown timer
Text_UpdateAnimation:                               ; DATA XREF: ROM:0000A9C2   o  ; was: sub_AAC6
                movea.l #dword_B43E,a0
                bsr.w Text_RenderLine
                subq.w  #1,(word_FF80C6).w
                bpl.s   locret_AADA
                addq.w  #2,(word_FF80C2).w
locret_AADA:                            ; CODE XREF: Text_UpdateAnimation+E   j
                rts
; End of function Text_UpdateAnimation
; Advances to next text phase with sound effect
Text_AdvancePhase:                               ; DATA XREF: ROM:0000A9C4   o  ; was: sub_AADC
                movea.l #dword_B43E,a0
                bsr.w Text_RenderLine
                move.b  #$17,d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,(word_FF80C2).w
                move.w  #$34,(word_FF80C6).w ; '4'
                clr.l   (dword_FF80CE).w
                move.l  #$20000,(dword_FF80C8).w
                bclr    #0,(byte_FFA272).w
                jsr (UI_StoreWeaponSelection).l
                rts
; End of function Text_AdvancePhase
; Animates text movement with deceleration
Text_AnimateMovement:                               ; DATA XREF: ROM:0000A9C6   o  ; was: sub_AB14
                subq.w  #1,(word_FF80C6).w
                bpl.s   loc_AB20
                clr.w   (word_FF80C2).w
                rts
; ---------------------------------------------------------------------------
loc_AB20:                               ; CODE XREF: Text_AnimateMovement+4   j
                move.l  (dword_FF80C8).w,d0
                add.l   d0,(dword_FF80CE).w
                subi.l  #$2000,d0
                movem.l d0,-(sp)
                movea.l #dword_B446,a0
                clr.l   (dword_FF80C8).w
                bsr.w Text_PrepareRenderParams
                movem.l (sp)+,d0
                move.l  d0,(dword_FF80C8).w
                rts
; End of function Text_AnimateMovement
; Advances state and initializes text display
Text_StartDisplaySequence:                               ; DATA XREF: ROM:0000A9A6   o  ; was: sub_AB4A
                                        ; ROM:0000A9B4   o
                addq.w  #2,(word_FF80C2).w
                bset    #7,(byte_FFFF31).w
                bsr.w Gfx_LoadVDPTileData
; End of function Text_StartDisplaySequence
; Reads script command and branches to handler
Text_ParseScriptCommand:                               ; DATA XREF: ROM:0000A9A8   o  ; was: sub_AB58
                                        ; ROM:0000A9B6   o ...
                movea.l (dword_FF80C8).w,a0
                move.w  (a0),d0
                cmpi.w  #$FFFE,d0
                beq.w Gfx_LoadCompressedTilemap
                cmpi.w  #$FFFF,d0
                bne.w Text_SetupCharacterDisplay
                addq.w  #8,(word_FF80C2).w
                move.w  #$40,(dword_FF80CE).w ; '@'
                rts
; End of function Text_ParseScriptCommand
; Parses text parameters position palette and character
Text_SetupCharacterDisplay:                               ; CODE XREF: Text_ParseScriptCommand+12   j  ; was: sub_AB7A
                addq.w  #2,(word_FF80C2).w
                move.w  #$D0,(word_FF80C6).w
                addq.l  #2,(dword_FF80C8).w
                ext.l   d0
                adda.l  d0,a0
                moveq   #0,d4
                moveq   #0,d3
                move.b  (a0)+,d4
                move.b  (a0)+,d3
                asl.w   #8,d4
                add.w   d3,d4
                move.w  d4,d3
                andi.w  #$7FFE,d4
                move.l  a0,(dword_FF80CE).w
                move.w  d4,(word_FF80CC).w
                move.w  #$C,(word_FF80D6).w
                move.w  #$5400,(word_FF80C4).w
                move.w  #$86A0,(word_FF80D2).w
                moveq   #0,d2
                btst    #0,d3
                beq.s   loc_ABC4
                addi.w  #$2000,d2
loc_ABC4:                               ; CODE XREF: Text_SetupCharacterDisplay+44   j
                tst.w   d3
                bpl.s   loc_ABCC
                addi.w  #$4000,d2
loc_ABCC:                               ; CODE XREF: Text_SetupCharacterDisplay+4C   j
                add.w   d2,(word_FF80D2).w
; End of function Text_SetupCharacterDisplay
; Empty text display state handler
Text_EmptyDisplayState:                             ; DATA XREF: ROM:off_A9A2   o  ; was: nullsub_22
                                        ; ROM:0000A9EE   o ...
                rts
; End of function Text_EmptyDisplayState
; Queues two DMA transfers to VRAM nametable
Gfx_QueueTwoNameTableDMAs:
                movea.w (word_FFF70C).w,a1  ; was: sub_ABD2
                move.w  #$5290,d0
                bsr.s Gfx_QueueNameTableDMA
                move.w  #$5310,d0
                bsr.s Gfx_QueueNameTableDMA
                move.w  a1,(word_FFF70C).w
                rts
; End of function Gfx_QueueTwoNameTableDMAs
; Configures DMA transfer to VRAM nametable address
Gfx_QueueNameTableDMA:                               ; CODE XREF: Gfx_QueueTwoNameTableDMAs+8   p  ; was: sub_ABE8
                                        ; Gfx_QueueTwoNameTableDMAs+E   p
                move.w  #$83,-(a1)
                move.w  d0,-(a1)
                move.l  #$180000,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.b  d2,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  #$94009320,-(a1)
                rts
; End of function Gfx_QueueNameTableDMA
; Loads tile data to VDP using three VRAM addresses
Gfx_LoadVDPTileData:                               ; CODE XREF: Text_StartDisplaySequence+A   p  ; was: sub_AC20
                                        ; Gfx_FlushTextBuffer+10   p
                movea.w (word_FFF70C).w,a1
                move.w  #$5080,d0
                bsr.s Gfx_WriteVDPDMACommand
                move.w  #$5100,d0
                bsr.s Gfx_WriteVDPDMACommand
                move.w  #$5180,d0
                bsr.s Gfx_WriteVDPDMACommand
                move.w  a1,(word_FFF70C).w
                rts
; End of function Gfx_LoadVDPTileData
; Writes VDP DMA command with address calculation
Gfx_WriteVDPDMACommand:                               ; CODE XREF: Gfx_LoadVDPTileData+8   p  ; was: sub_AC3C
                                        ; Gfx_LoadVDPTileData+E   p ...
                move.w  #$83,-(a1)
                move.w  d0,-(a1)
                move.l  #$180000,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.b  d2,-(a1)
                move.b  #$97,-(a1)
                move.w  #$8F02,-(a1)
                move.l  #$94009328,-(a1)
                rts
; End of function Gfx_WriteVDPDMACommand
; Renders single text character with transparency
Gfx_RenderTextCharacter:                               ; DATA XREF: ROM:0000A9AA   o  ; was: sub_AC74
                                        ; ROM:0000A9B8   o ...
                movea.l (dword_FF80CE).w,a0
                moveq   #0,d0
                move.b  (a0),d0
                cmpi.b  #$FF,d0
                bne.s   loc_AC88
                addq.w  #2,(word_FF80C2).w
                rts
; ---------------------------------------------------------------------------
loc_AC88:                               ; CODE XREF: Gfx_RenderTextCharacter+C   j
                asl.w   #6,d0
                addi.l  #tiles_font,d0
                movea.l d0,a0
                movea.w #(byte_FFA300-M68K_RAM),a1
                moveq   #$F,d7
loc_AC98:                               ; CODE XREF: Gfx_RenderTextCharacter+90   j
                move.l  (a0)+,d2
                move.l  d2,(dword_FF8040).w
                move.l  d2,(dword_FF8044).w
                andi.b  #$F0,(dword_FF8040).w
                bne.s   loc_ACAE
                bset    #$1C,d2
loc_ACAE:                               ; CODE XREF: Gfx_RenderTextCharacter+34   j
                andi.b  #$F,(dword_FF8044).w
                bne.s   loc_ACBA
                bset    #$18,d2
loc_ACBA:                               ; CODE XREF: Gfx_RenderTextCharacter+40   j
                andi.b  #$F0,(dword_FF8040+1).w
                bne.s   loc_ACC6
                bset    #$14,d2
loc_ACC6:                               ; CODE XREF: Gfx_RenderTextCharacter+4C   j
                andi.b  #$F,(dword_FF8044+1).w
                bne.s   loc_ACD2
                bset    #$10,d2
loc_ACD2:                               ; CODE XREF: Gfx_RenderTextCharacter+58   j
                andi.b  #$F0,(dword_FF8040+2).w
                bne.s   loc_ACDE
                bset    #$C,d2
loc_ACDE:                               ; CODE XREF: Gfx_RenderTextCharacter+64   j
                andi.b  #$F,(dword_FF8044+2).w
                bne.s   loc_ACEA
                bset    #8,d2
loc_ACEA:                               ; CODE XREF: Gfx_RenderTextCharacter+70   j
                andi.b  #$F0,(dword_FF8040+3).w
                bne.s   loc_ACF6
                bset    #4,d2
loc_ACF6:                               ; CODE XREF: Gfx_RenderTextCharacter+7C   j
                andi.b  #$F,(dword_FF8044+3).w
                bne.s   loc_AD02
                bset    #0,d2
loc_AD02:                               ; CODE XREF: Gfx_RenderTextCharacter+88   j
                move.l  d2,(a1)+
                dbf     d7,loc_AC98
                movea.w (word_FFF70C).w,a5
                move.w  #$83,-(a5)
                move.w  (word_FF80C4).w,-(a5)
                move.w  #$9580,-(a5)
                move.w  #$96D1,-(a5)
                move.l  #$8F02977F,-(a5)
                move.l  #$94009320,-(a5)
                movea.w (word_FFF70E).w,a0
                move.w  (word_FF80D2).w,d0
                move.w  d0,(a0)+
                addq.w  #1,d0
                move.w  d0,(a0)+
                move.w  #$83,-(a5)
                move.w  (word_FF80CC).w,-(a5)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a5)
                move.b  #$95,-(a5)
                move.b  d1,-(a5)
                move.b  #$96,-(a5)
                move.l  #$8F80977F,-(a5)
                move.l  #$94009302,-(a5)
                move.w  a5,(word_FFF70C).w
                addq.w  #4,(word_FFF70E).w
                addi.w  #$40,(word_FF80C4).w ; '@'
                addq.l  #1,(dword_FF80CE).w
                addq.w  #2,(word_FF80CC).w
                addq.w  #2,(word_FF80D2).w
                subq.w  #1,(word_FF80C6).w
                move.b  (dword_FF80CE+3).w,d0
                andi.b  #3,d0
                bne.s   locret_AD94
                move.b  #$AD,d0
                jsr (Sound_PlaySFX).l
locret_AD94:                            ; CODE XREF: Gfx_RenderTextCharacter+114   j
                rts
; End of function Gfx_RenderTextCharacter
; Completes text rendering and clears VDP buffer
Gfx_FlushTextBuffer:                               ; DATA XREF: ROM:0000A9AC   o  ; was: sub_AD96
                                        ; ROM:0000A9BA   o
                tst.b   (byte_FF8310).w
                bne.s   loc_ADA2
                subq.w  #1,(word_FF80C6).w
                bpl.s   locret_ADAA
loc_ADA2:                               ; CODE XREF: Gfx_FlushTextBuffer+4   j
                subq.w  #4,(word_FF80C2).w
                bsr.w Gfx_LoadVDPTileData
locret_ADAA:                            ; CODE XREF: Gfx_FlushTextBuffer+A   j
                rts
; End of function Gfx_FlushTextBuffer
; Loads compressed tilemap data with address masking
Gfx_LoadCompressedTilemap:                               ; CODE XREF: Text_ParseScriptCommand+A   j  ; was: sub_ADAC
                addq.w  #6,(word_FF80C2).w
                clr.w   (word_FF80C6).w
                addq.l  #6,(dword_FF80C8).w
                movea.l (dword_FF80C8).w,a0
                move.l  -4(a0),d0
                andi.l  #$3FFFFF,d0
                move.w  -4(a0),d1
                andi.w  #$E000,d1
                move.w  d1,(word_FF80D4).w
                movea.w (word_FFF70C).w,a5
                move.w  #$83,-(a5)
                move.w  #$5E00,-(a5)
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a5)
                move.b  #$95,-(a5)
                move.b  d1,-(a5)
                move.b  #$96,-(a5)
                move.b  d2,-(a5)
                move.b  #$97,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94019300,-(a5)
                move.w  a5,(word_FFF70C).w
                rts
; End of function Gfx_LoadCompressedTilemap
; Renders multi-tile text glyph with palette priority
Gfx_RenderTextGlyph:                               ; DATA XREF: ROM:0000A9AE   o  ; was: sub_AE0E
                                        ; ROM:0000A9BC   o
                move.w  (word_FF80C6).w,d0
                move.w  d0,d3
                addq.w  #2,(word_FF80C6).w
                cmpi.w  #8,(word_FF80C6).w
                bmi.s   loc_AE24
                subq.w  #6,(word_FF80C2).w
loc_AE24:                               ; CODE XREF: Gfx_RenderTextGlyph+10   j
                move.w  (word_FF80D4).w,d2
                bclr    #$F,d2
                beq.s   loc_AE30
                addq.w  #8,d0
loc_AE30:                               ; CODE XREF: Gfx_RenderTextGlyph+1E   j
                movea.w (word_FFF70E).w,a1
                move.w  word_AE8A(pc,d0.w),d1
                add.w   d2,d1
                move.w  d1,(a1)+
                addq.w  #1,d1
                move.w  d1,(a1)+
                addq.w  #1,d1
                move.w  d1,(a1)+
                addq.w  #1,d1
                move.w  d1,(a1)+
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                move.w  word_AE82(pc,d3.w),-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F80977F,-(a1)
                move.l  #$94009304,-(a1)
                move.w  a1,(word_FFF70C).w
                addq.w  #8,(word_FFF70E).w
                rts
; End of function Gfx_RenderTextGlyph
; ---------------------------------------------------------------------------
word_AE82:      dc.w $5004, $5006, $5008, $500A
word_AE8A:      dc.w $6F0, $6F4, $6F8, $6FC, $6F0, $6F4, $EF4, $EF0


; Initializes player object with default values
Player_Initialize:                               ; DATA XREF: ROM:0000A9F2   o  ; was: sub_AE9A
                addq.w  #2,(word_FF80C2).w
                jsr (Enemy_UpdateBehavior).l
                bclr    #0,(byte_FFA272).w
                move.l  #word_B534,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
; Displays stage title text with character animation
Text_DisplayStageTitle:                               ; DATA XREF: ROM:0000A9F4   o  ; was: loc_AEB8
                bsr.w Text_DisplayCharacter
                cmpi.w  #$52,(word_FF80C2).w ; 'R'
                beq.s   locret_AEE2
                move.w  #$EC,(word_FF80C6).w
                move.w  #$80,(word_FF80D4).w
                move.w  #$E0,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #2,(byte_FF8143).w
locret_AEE2:                            ; CODE XREF: Player_Initialize+28   j
                rts
; End of function Player_Initialize
; Displays score counter with animation
UI_DisplayScoreAnimation:                               ; DATA XREF: ROM:0000A9F6   o  ; was: sub_AEE4
                addq.w  #1,(word_FF80C6).w
                cmpi.w  #$FC,(word_FF80C6).w
                bmi.s   loc_AEF6
                move.w  #$FC,(word_FF80C6).w
loc_AEF6:                               ; CODE XREF: UI_DisplayScoreAnimation+A   j
                cmpi.w  #$40,(word_FF80D4).w ; '@'
                bne.s   loc_AF0E
                move.b  (dword_FF80C8).w,d0
                beq.s   loc_AF0E
                clr.b   (dword_FF80C8).w
                jsr (Sound_PlaySFX).l
loc_AF0E:                               ; CODE XREF: UI_DisplayScoreAnimation+18   j
                                        ; UI_DisplayScoreAnimation+1E   j
                subq.w  #1,(word_FF80D4).w
                bpl.s   loc_AF18
                clr.w   (word_FF80C2).w
loc_AF18:                               ; CODE XREF: UI_DisplayScoreAnimation+2E   j
                lea     word_B37A(pc),a0
                nop
                bsr.w Gfx_LoadTileIndices
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  #$EC,d0
                move.b  (byte_FF8232).w,d2
                move.w  d2,d3
                asr.w   #4,d3
                andi.w  #$F,d2
                andi.w  #$F,d3
                asl.w   #1,d2
                asl.w   #1,d3
                addi.w  #-$3960,d2
                addi.w  #-$3960,d3
                move.w  (word_FF80C6).w,d1
                moveq   #4,d7
; Renders score digits as sprites in results screen
UI_RenderScoreDigits:                               ; CODE XREF: UI_DisplayScoreAnimation+74   j  ; was: loc_AF4C
                move.w  d0,(a0)
                move.w  d1,6(a0)
                addi.w  #$C,d1
                addq.w  #8,a0
                dbf d7,UI_RenderScoreDigits
                addq.w  #6,d1
                move.w  d0,(a0)
                move.w  d1,6(a0)
                move.w  d3,4(a0)
                addi.w  #$C,d1
                addq.w  #8,a0
                move.w  d0,(a0)
                move.w  d1,6(a0)
                move.w  d2,4(a0)
                lea     (dword_FFA100).w,a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function UI_DisplayScoreAnimation
; Initializes grade text display with position and sound
Text_InitGradeDisplay:                               ; DATA XREF: ROM:0000A9F8   o  ; was: sub_AF82
                addq.w  #2,(word_FF80C2).w
                move.l  #word_B56A,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
; Displays grade text (S/A/B/C) with position and sound
Text_DisplayGradeText:                               ; DATA XREF: ROM:0000A9FA   o  ; was: loc_AF94
                bsr.w Text_DisplayCharacter
                cmpi.w  #$58,(word_FF80C2).w ; 'X'
                beq.s   locret_AFB6
                move.w  #$F0,(word_FF80C6).w
                move.w  #$100,(word_FF80D4).w
                move.b  #$D2,d0
                jsr (Sound_PlaySFX).l
locret_AFB6:                            ; CODE XREF: Text_InitGradeDisplay+1C   j
                                        ; Text_AnimateGradeFlash+22   j
                rts
; End of function Text_InitGradeDisplay
; Animates flashing grade text with sprite rendering
Text_AnimateGradeFlash:                               ; DATA XREF: ROM:0000A9FC   o  ; was: sub_AFB8
                cmpi.w  #$5C,(word_FF80D4).w ; '\'
                bne.s   loc_AFCA
                move.b  #$15,d0
                jsr (Sound_PlaySFX).l
loc_AFCA:                               ; CODE XREF: Text_AnimateGradeFlash+6   j
                subq.w  #1,(word_FF80D4).w
                bpl.s   loc_AFD4
                clr.w   (word_FF80C2).w
loc_AFD4:                               ; CODE XREF: Text_AnimateGradeFlash+16   j
                btst    #4,(word_FF80D4+1).w
                bne.s   locret_AFB6
                lea     word_B382(pc),a0
                nop
                bsr.w Gfx_LoadTileIndices
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  #$EC,d0
                move.w  (word_FF80C6).w,d1
                moveq   #8,d7
; Renders grade letter sprites with horizontal spacing
UI_RenderGradeSprites:                               ; CODE XREF: Text_AnimateGradeFlash+48   j  ; was: loc_AFF4
                move.w  d0,(a0)
                move.w  d1,6(a0)
                addi.w  #$C,d1
                addq.w  #8,a0
                dbf d7,UI_RenderGradeSprites
                lea     (dword_FFA100).w,a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function Text_AnimateGradeFlash
; Initializes pause timer before text exit
Text_InitPauseTimer:                               ; DATA XREF: ROM:0000A9FE   o  ; was: sub_B00E
                addq.w  #2,(word_FF80C2).w
                move.w  #$50,(dword_FF80CE).w ; 'P'
; Decrements pause timer each frame before text transition
Text_PauseTimer_CountdownLoop:                               ; DATA XREF: ROM:0000AA00   o  ; was: loc_B018
                subq.w  #1,(dword_FF80CE).w
                bpl.s   locret_B024
                move.w  #$2E,(word_FF80C2).w ; '.'
locret_B024:                            ; CODE XREF: Text_InitPauseTimer+E   j
                rts
; End of function Text_InitPauseTimer
; Initializes victory text display sequence
Text_InitVictoryMessage:                               ; DATA XREF: ROM:0000A9D0   o  ; was: sub_B026
                addq.w  #2,(word_FF80C2).w
                move.l  #word_B552,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
                rts
; End of function Text_InitVictoryMessage
; Starts weapon acquired animation sequence
Text_StartWeaponAcquired:                               ; DATA XREF: ROM:0000A9D2   o  ; was: sub_B03A
                bsr.w Text_DisplayCharacter
                cmpi.w  #$30,(word_FF80C2).w ; '0'
                beq.s   locret_B086
                move.w  #$E0,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #2,(byte_FF8143).w
                move.w  #$80,(word_FF80C6).w
                move.w  #$40,(dword_FF80CE).w ; '@'
                move.w  #$E8,(word_FF80CC).w
                move.w  #$200,(word_FF80D4).w
                move.w  #$108,(word_FF80C4).w
                move.w  #$200,(word_FF80D6).w
                move.b  #$BE,d0
                jsr (Sound_PlaySFX).l
locret_B086:                            ; CODE XREF: Text_StartWeaponAcquired+A   j
                rts
; End of function Text_StartWeaponAcquired
; Animates rotating text with fade effect
Text_AnimateRotationFade:                               ; DATA XREF: ROM:0000A9D4   o  ; was: sub_B088
                bsr.w Text_RenderRotatingSprites
                move.w  (word_FF80C6).w,d0
                addq.w  #8,d0
                andi.w  #$1FE,d0
                move.w  d0,(word_FF80C6).w
                subq.w  #4,(dword_FF80CE).w
                bpl.s   locret_B0B4
                cmpi.w  #4,(dword_FF80CE).w
                bpl.s   locret_B0B4
                addq.w  #2,(word_FF80C2).w
                clr.w   (word_FF80C6).w
                clr.w   (dword_FF80CE).w
locret_B0B4:                            ; CODE XREF: Text_AnimateRotationFade+16   j
                                        ; Text_AnimateRotationFade+1E   j
                rts
; End of function Text_AnimateRotationFade
; Animates rotation stopping sequence
Text_AnimateRotationStop:                               ; DATA XREF: ROM:0000A9D6   o  ; was: sub_B0B6
                bsr.w Text_RenderRotatingSprites
                subq.w  #1,(dword_FF80CE).w
                cmpi.w  #$FFF4,(dword_FF80CE).w
                bne.s   locret_B0D6
                addq.w  #2,(word_FF80C2).w
                move.w  #$FFF4,(dword_FF80CE).w
                move.w  #$20,(dword_FF80C8).w ; ' '
locret_B0D6:                            ; CODE XREF: Text_AnimateRotationStop+E   j
                rts
; End of function Text_AnimateRotationStop
; Completes animation and plays appropriate sound
Text_CompleteWithSound:                               ; DATA XREF: ROM:0000A9D8   o  ; was: sub_B0D8
                bsr.w Text_RenderRotatingSprites
                subq.w  #1,(dword_FF80C8).w
                bpl.s   locret_B134
                tst.b   (byte_FF80FA).w
                beq.s   loc_B0F4
                move.b  #$83,d0
                jsr (Sys_WaitVBlank).l
                bra.s   loc_B0FE
; ---------------------------------------------------------------------------
loc_B0F4:                               ; CODE XREF: Text_CompleteWithSound+E   j
                move.b  #$C4,d0
                jsr (Sound_PlaySFX).l
loc_B0FE:                               ; CODE XREF: Text_CompleteWithSound+1A   j
                jsr (UI_StoreWeaponToBuffer).l
                tst.w   (word_FFA270).w
                beq.s   loc_B122
                addq.w  #2,(word_FF80C2).w
                move.w  #$F0,(word_FF80D4).w
                move.w  (word_FFA270).w,(word_FF822C).w
                andi.w  #$FFF0,(word_FF822C).w
                rts
; ---------------------------------------------------------------------------
loc_B122:                               ; CODE XREF: Text_CompleteWithSound+30   j
                move.w  #$46,(word_FF80C2).w ; 'F'
                move.w  #$F0,(word_FF80D4).w
                move.w  #$11A,(word_FF80C4).w
locret_B134:                            ; CODE XREF: Text_CompleteWithSound+8   j
                rts
; End of function Text_CompleteWithSound
; Animates text rising upward
Text_AnimateRiseUp:                               ; DATA XREF: ROM:0000A9DA   o  ; was: sub_B136
                bsr.w Text_RenderVerticalText
                subq.w  #1,(word_FF80CC).w
                addq.w  #1,(word_FF80D4).w
                cmpi.w  #$E0,(word_FF80CC).w
                bne.s   locret_B154
                addq.w  #2,(word_FF80C2).w
                move.w  #4,(dword_FF80C8).w
locret_B154:                            ; CODE XREF: Text_AnimateRiseUp+12   j
                rts
; End of function Text_AnimateRiseUp
; Pauses before final exit animation
Text_PauseBeforeExit:                               ; DATA XREF: ROM:0000A9DC   o  ; was: sub_B156
                bsr.w Text_RenderVerticalText
                subq.w  #1,(dword_FF80C8).w
                bpl.s   locret_B16A
                addq.w  #2,(word_FF80C2).w
                move.w  #$114,(word_FF80D6).w
locret_B16A:                            ; CODE XREF: Text_PauseBeforeExit+8   j
                rts
; End of function Text_PauseBeforeExit
; Animates text exiting upward
Text_AnimateExitUp:                               ; DATA XREF: ROM:0000A9DE   o  ; was: sub_B16C
                bsr.w Text_RenderVerticalText
                subq.w  #2,(word_FF80C4).w
                addq.w  #2,(word_FF80D6).w
                cmpi.w  #$EC,(word_FF80C4).w
                bne.s   locret_B18A
                addq.w  #4,(word_FF80C2).w
                move.w  #$40,(dword_FF80C8).w ; '@'
locret_B18A:                            ; CODE XREF: Text_AnimateExitUp+12   j
                rts
; End of function Text_AnimateExitUp
; Finalizes animation and saves weapon score
Text_FinalizeAndSaveScore:                               ; DATA XREF: ROM:0000A9E0   o  ; was: sub_B18C
                                        ; ROM:0000A9E2   o
                bsr.w Text_RenderVerticalText
                subq.w  #1,(dword_FF80C8).w
                bpl.s   locret_B1A6
                clr.w   (word_FF80C2).w
                moveq   #0,d0
                move.w  (word_FFA270).w,d0
                jsr (UI_AddScoreBCD).l
locret_B1A6:                            ; CODE XREF: Text_FinalizeAndSaveScore+8   j
                rts
; End of function Text_FinalizeAndSaveScore
; Fades in ship name display during cutscene
Cutscene_FadeInShipNameAlt:                               ; DATA XREF: ROM:0000A9E4   o  ; was: sub_B1A8
                                        ; ROM:0000A9E6   o ...
                bsr.w Gfx_RenderRotatedSprites
                addq.w  #1,(word_FF80D4).w
                cmpi.w  #$FC,(word_FF80D4).w
                bne.s   locret_B1C2
                addq.w  #2,(word_FF80C2).w
                move.w  #$80,(dword_FF80C8).w
locret_B1C2:                            ; CODE XREF: Cutscene_FadeInShipNameAlt+E   j
                rts
; End of function Cutscene_FadeInShipNameAlt
; Fades out ship name display during cutscene
Cutscene_FadeOutShipNameAlt:                               ; DATA XREF: ROM:0000A9EA   o  ; was: sub_B1C4
                bsr.w Gfx_RenderRotatedSprites
                subq.w  #1,(dword_FF80C8).w
                bpl.s   locret_B1D2
                clr.w   (word_FF80C2).w
locret_B1D2:                            ; CODE XREF: Cutscene_FadeOutShipNameAlt+8   j
                rts
; End of function Cutscene_FadeOutShipNameAlt
; Waits for frame timer countdown before clearing state
Cutscene_WaitFrameTimer:                               ; DATA XREF: ROM:0000A9EC   o  ; was: sub_B1D4
                subq.w  #1,(word_FF80C4).w
                bpl.s   locret_B1DE
                clr.w   (word_FF80C2).w
locret_B1DE:                            ; CODE XREF: Cutscene_WaitFrameTimer+4   j
                rts
; End of function Cutscene_WaitFrameTimer
; Renders text sprites with tile loading
Text_RenderRotatingSprites:                               ; CODE XREF: Text_AnimateRotationFade   p  ; was: sub_B1E0
                                        ; sub_B0B6   p ...
                lea     word_B354(pc),a0
                nop
                bsr.w Gfx_LoadTileIndices
                bsr.w Text_PositionVerticalSprites
                lea     (dword_FFA100).w,a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function Text_RenderRotatingSprites
; Renders vertical text sprites with positioning
Text_RenderVerticalText:                               ; CODE XREF: Text_AnimateRiseUp   p  ; was: sub_B1F8
                                        ; sub_B156   p ...
                lea     word_B354(pc),a0
                nop
                bsr.w Gfx_LoadTileIndices
                bsr.w Text_ApplyDigitOffsets
                bsr.w Text_PositionVerticalSprites
                lea     (dword_FFA100).w,a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function Text_RenderVerticalText
; Renders rotated sprites with tile indices and OAM
Gfx_RenderRotatedSprites:                               ; CODE XREF: Cutscene_FadeInShipNameAlt   p  ; was: sub_B214
                                        ; sub_B1C4   p
                lea     word_B368(pc),a0
                nop
                bsr.w Gfx_LoadTileIndices
                bsr.w Gfx_PositionRotatedText
                lea     (dword_FFA100).w,a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function Gfx_RenderRotatedSprites
; Positions vertical text sprite column
Text_PositionVerticalSprites:                               ; CODE XREF: Text_RenderRotatingSprites+A   p  ; was: sub_B22C
                                        ; Text_RenderVerticalText+E   p
                bsr.w Text_CalculateRotationCoords
                move.w  (word_FF80D6).w,d1
                moveq   #3,d7
loc_B236:                               ; CODE XREF: Text_PositionVerticalSprites+18   j
                move.w  (word_FF80D4).w,(a0)
                move.w  d1,(a1)
                addq.w  #8,a0
                addq.w  #8,a1
                addi.w  #$C,d1
                dbf     d7,loc_B236
                rts
; End of function Text_PositionVerticalSprites
; Positions rotated text sprites with coordinates
Gfx_PositionRotatedText:                               ; CODE XREF: Gfx_RenderRotatedSprites+A   p  ; was: sub_B24A
                bsr.w Text_CalculateRotationCoords
                subi.w  #$60,d1 ; '`'
                moveq   #1,d7
loc_B254:                               ; CODE XREF: Gfx_PositionRotatedText+18   j
                move.w  (word_FF80D4).w,(a0)
                move.w  d1,(a1)
                addq.w  #8,a0
                addq.w  #8,a1
                addi.w  #$C,d1
                dbf     d7,loc_B254
                rts
; End of function Gfx_PositionRotatedText
; Calculates coordinates for rotating text effect
Text_CalculateRotationCoords:                               ; CODE XREF: Text_PositionVerticalSprites   p  ; was: sub_B268
                                        ; sub_B24A   p
                movea.w #(byte_FFA120-M68K_RAM),a0
                movea.w #(byte_FFA126-M68K_RAM),a1
                movea.w #(byte_FFA128-M68K_RAM),a2
                movea.w #(byte_FFA12E-M68K_RAM),a3
                movea.l #word_1B514,a4
                move.w  (word_FF80C6).w,d0
                move.w  (dword_FF80CE).w,d1
                move.w  d1,d4
                move.w  (word_FF80CC).w,d6
                moveq   #4,d7
loc_B28E:                               ; CODE XREF: Text_CalculateRotationCoords+5C   j
                move.w  -$80(a4,d0.w),d2
                move.w  (a4,d0.w),d3
                muls.w  d4,d2
                muls.w  d4,d3
                asl.l   #2,d2
                asl.l   #2,d3
                swap    d2
                swap    d3
                move.w  d2,(a0)
                move.w  d3,(a1)
                add.w   d6,(a0)
                addi.w  #$120,(a1)
                neg.w   d2
                neg.w   d3
                add.w   d6,d2
                addi.w  #$120,d3
                move.w  d2,(a2)
                move.w  d3,(a3)
                subq.w  #8,a0
                subq.w  #8,a1
                addq.w  #8,a2
                addq.w  #8,a3
                add.w   d1,d4
                dbf     d7,loc_B28E
                movea.w #(byte_FFA150-M68K_RAM),a0
                movea.w #(byte_FFA156-M68K_RAM),a1
                move.w  (word_FF80C4).w,d1
                moveq   #4,d7
loc_B2D6:                               ; CODE XREF: Text_CalculateRotationCoords+7C   j
                move.w  (word_FF80D4).w,(a0)
                move.w  d1,(a1)
                addq.w  #8,a0
                addq.w  #8,a1
                addi.w  #$C,d1
                dbf     d7,loc_B2D6
                rts
; End of function Text_CalculateRotationCoords
; Applies position offsets from two-digit value
Text_ApplyDigitOffsets:                               ; CODE XREF: Text_RenderVerticalText+A   p  ; was: sub_B2EA
                movea.w #(byte_FFA17C-M68K_RAM),a0
                move.b  (word_FF822C).w,d0
                move.b  d0,d1
                asr.w   #4,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                add.w   d0,d0
                add.w   d1,d1
                add.w   d1,(a0)
                add.w   d0,8(a0)
                move.b  (word_FF822C+1).w,d0
                move.b  d0,d1
                asr.w   #4,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                add.w   d0,d0
                add.w   d1,d1
                add.w   d1,$10(a0)
                add.w   d0,$18(a0)
                rts
; End of function Text_ApplyDigitOffsets
; Loads tile indices from data table
Gfx_LoadTileIndices:                               ; CODE XREF: UI_DisplayScoreAnimation+3A   p  ; was: sub_B326
                                        ; Text_AnimateGradeFlash+2A   p ...
                movea.w #(byte_FFA104-M68K_RAM),a1
                move.w  #$100,d1
loc_B32E:                               ; CODE XREF: Gfx_LoadTileIndices+24   j
                moveq   #0,d0
                move.b  (a0)+,d0
                bmi.s Gfx_TerminateSpriteList
                addi.w  #-$1960,d0
                bclr    #0,d0
                bne.s   loc_B342
                subi.w  #$2000,d0
loc_B342:                               ; CODE XREF: Gfx_LoadTileIndices+16   j
                move.w  d0,(a1)
                move.w  d1,-2(a1)
                addq.w  #8,a1
                bra.s   loc_B32E
; ---------------------------------------------------------------------------
; Writes terminator marker to end of sprite list in VRAM queue
Gfx_TerminateSpriteList:                               ; CODE XREF: Gfx_LoadTileIndices+C   j  ; was: loc_B34C
                move.w  #$FFFF,-4(a1)
                rts
; End of function Gfx_LoadTileIndices
; ---------------------------------------------------------------------------
word_B354:      dc.w $1416, $181A, $1C1E, $201C, $1822, $2426, $282A, $1400, 0, $FF
                                        ; DATA XREF: Text_RenderRotatingSprites   o
                                        ; sub_B1F8   o
word_B368:      dc.w $1416, $181A, $1C1E, $201C, $1822, $2426, $282A, $1428, $26FF
                                        ; DATA XREF: Gfx_RenderRotatedSprites   o
word_B37A:      dc.w $1416, $181A, $1C00, $FF
                                        ; DATA XREF: UI_DisplayScoreAnimation:loc_AF18   o
word_B382:      dc.w 2, 4, $600, $80A, $CFF
                                        ; DATA XREF: Text_AnimateGradeFlash+24   o


; Loads font tile and queues DMA transfer
Text_DisplayCharacter:                               ; CODE XREF: Text_BeginVictorySequence   p  ; was: sub_B38C
                                        ; sub_AE9A:loc_AEB8   p ...
                movea.l (dword_FF80CE).w,a0
                moveq   #0,d0
                move.b  (a0)+,d0
                cmpi.b  #$FF,d0
                bne.s   loc_B3A0
                addq.w  #2,(word_FF80C2).w
                rts
; ---------------------------------------------------------------------------
loc_B3A0:                               ; CODE XREF: Text_DisplayCharacter+C   j
                move.l  a0,(dword_FF80CE).w
                asl.w   #6,d0
                addi.l  #tiles_font,d0
                movea.l d0,a0
                movea.w #(byte_FFA300-M68K_RAM),a1
                moveq   #$F,d7
loc_B3B4:                               ; CODE XREF: Text_DisplayCharacter+2A   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_B3B4
                movea.w (word_FFF70C).w,a5
                move.w  #$83,-(a5)
                move.w  (word_FF80C4).w,-(a5)
                move.w  #$9580,-(a5)
                move.w  #$96D1,-(a5)
                move.l  #$8F02977F,-(a5)
                move.l  #$94009320,-(a5)
                move.w  a5,(word_FFF70C).w
                addi.w  #$40,(word_FF80C4).w ; '@'
                rts
; End of function Text_DisplayCharacter
; Prepares position parameters for text rendering
Text_PrepareRenderParams:                               ; CODE XREF: Text_AnimateMovement+28   p  ; was: sub_B3E6
                move.w  (dword_FF80C8).w,d5
                move.w  (dword_FF80CE).w,d6
                bra.s   loc_B3FC
; End of function Text_PrepareRenderParams
; Renders text line with sprite buffer and OAM update
Text_RenderLine:                               ; CODE XREF: Text_UpdateAnimation+6   p  ; was: sub_B3F0
                                        ; Text_AdvancePhase+6   p
                btst    #3,(word_FFA000+1).w
                bne.s   locret_B408
                moveq   #0,d5
                moveq   #0,d6
loc_B3FC:                               ; CODE XREF: Text_PrepareRenderParams+8   j
                bsr.s Sprite_RenderTextLine
                lea     (dword_FFA100).w,a0
                jsr (Sprite_AddToOAMBuffer).l
locret_B408:                            ; CODE XREF: Text_RenderLine+6   j
                rts
; End of function Text_RenderLine
; Renders line of sprites for text display
Sprite_RenderTextLine:                               ; CODE XREF: Text_RenderLine:loc_B3FC   p  ; was: sub_B40A
                move.w  (a0)+,d0
                move.w  (a0)+,d1
                moveq   #0,d2
                move.b  (a0)+,d2
                addi.w  #$80,d2
                add.w   d6,d2
                moveq   #0,d3
                move.b  (a0)+,d3
                add.w   d5,d3
                move.w  #$100,d4
                movea.w #(dword_FFA100-M68K_RAM),a1
                move.w  (a0)+,d7
; Renders text line character-by-character as sprites in loop
Sprite_RenderTextLoop:                               ; CODE XREF: Sprite_RenderTextLine+2A   j  ; was: loc_B428
                move.w  d2,(a1)+
                move.w  d4,(a1)+
                move.w  d0,(a1)+
                move.w  d1,(a1)+
                addq.w  #2,d0
                add.w   d3,d1
                dbf d7,Sprite_RenderTextLoop
                move.w  #$FFFF,(a1)
                rts
; End of function Sprite_RenderTextLine
; ---------------------------------------------------------------------------
dword_B43E:     dc.l $C6A0010A          ; DATA XREF: Text_UpdateAnimation   o
                                        ; sub_AADC   o
                dc.l $680B0004
dword_B446:     dc.l $C6AA00FF          ; DATA XREF: Text_AnimateMovement+1E   o
                dc.l $680B0006


; Checks conditions for victory message display
UI_CheckVictoryCondition:                               ; CODE XREF: Boss_DestroyerProtoIntroMove+28   p  ; was: sub_B44E
                                        ; Boss_JetsripperFlyIn+1E   p ...
                bclr    #1,(byte_FFA209).w
                bne.s   loc_B464
                bclr    #0,(byte_FF80A8).w
                cmpi.w  #4,(word_FFFF2A).w
                bmi.s   loc_B480
loc_B464:                               ; CODE XREF: UI_CheckVictoryCondition+6   j
                move.w  #$1E,(word_FF80C2).w
                move.l  #word_B544,(dword_FF80CE).w
                move.w  #$5400,(word_FF80C4).w
                move.b  #4,(word_FFF7F4+1).w
                rts
; ---------------------------------------------------------------------------
loc_B480:                               ; CODE XREF: UI_CheckVictoryCondition+14   j
                asl.w   #3,d0
                cmpi.w  #2,(word_FFFF2A).w
                bne.s   loc_B48E
                addi.w  #4,d0
loc_B48E:                               ; CODE XREF: UI_CheckVictoryCondition+3A   j
                move.w  #$10,(word_FF80C2).w
                move.l  off_B49C(pc,d0.w),(dword_FF80C8).w
                rts
; End of function UI_CheckVictoryCondition
; ---------------------------------------------------------------------------
off_B49C:       dc.l byte_B710
                dc.l byte_B710
                dc.l byte_B6B6
                dc.l byte_B6B6
                dc.l byte_B64E
                dc.l byte_B64E
                dc.l byte_B572          ; text?
                dc.l byte_B572          ; text?
                dc.l byte_B5E2
                dc.l byte_B5E2
                dc.l byte_B868
                dc.l byte_B868
                dc.l byte_B776
                dc.l byte_B776
                dc.l byte_B7E8
                dc.l byte_B7E8
                dc.l byte_B8E8
                dc.l byte_B8E8


; Initializes ship name display based on difficulty
Cutscene_InitShipNameByDiff:                               ; CODE XREF: Cutscene_ShowShipName+4   p  ; was: sub_B4E4
                                        ; Cutscene_WaitShipPosition+10   p
                bset    #0,(byte_FF80A8).w
                asl.w   #3,d0
                cmpi.w  #2,(word_FFFF2A).w
                bne.s   loc_B4F8
                addi.w  #4,d0
loc_B4F8:                               ; CODE XREF: Cutscene_InitShipNameByDiff+E   j
                move.w  #2,(word_FF80C2).w
                move.l  word_B506(pc,d0.w),(dword_FF80C8).w
                rts
; End of function Cutscene_InitShipNameByDiff
; ---------------------------------------------------------------------------
word_B506:      dc.w 0, $B8E8, 0, $B8E8, 4, $FFFF, $D08A, $1D1E, $B11, $F02, 0
                dc.w $2113, $1811, $19, $1000, $1E12, $F00, $1619, $1D0B, $1811, $F16, $F1D
                dc.w $FF00
word_B534:      dc.w $102, $304, $506, $708, $90A, $1D1E, $B11, $FFF
                                        ; DATA XREF: Player_Initialize+10   o
word_B544:      dc.w $1C0F, $B0E, $2310, $1311, $121E, $2929, $29FF
                                        ; DATA XREF: Player_ProcessBehaviorTimer+C   o
                                        ; UI_CheckVictoryCondition+1C   o
word_B552:      dc.w $102, $304, $506, $708, $90A, $1D1E, $B11, $F0D
                                        ; DATA XREF: Text_InitVictoryMessage+4   o
                dc.w $161C, $C19, $181F, $FF00
word_B56A:      dc.w $F17, $1C11, $180D, $23FF
                                        ; DATA XREF: Text_InitGradeDisplay+4   o
byte_B572:      dc.b 0, 6, 0, $1E, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4B4   o
                                        ; ROM:0000B4B8   o
                dc.b $5A, $32, $39, $3E, $D8, $82, $80, $A3 ; text?
                dc.b $7F, $AB, $8D, $A4, $B2, $C5, $DA, $D9
                dc.b $4E, $40, $5B, $6D, $3F, $5A, $D9, $FF
                dc.b $D0, $90, $4E, $64, $49, $39, $48, $B2
                dc.b $CC, $C8, $92, $A3, $C8, $C0, $DA, $43
                dc.b 0, $42, $30, $5B, $3D, $47, $5D, $34
                dc.b $32, $D9, $FF, 0, $D0, $90, $9F, $8A
                dc.b $87, $A2, $5D, 0, $31, $79, $42, $37
                dc.b $56, $55, $63, $76, $47, $33, $35, $5A
                dc.b $D8, $83, $80, $D9, $FF, 0, $D0, $90
                dc.b $3A, $30, $D8, $35, $35, $79, $42, $36
                dc.b $58, $5D, $56, $DB, $89, $8A, $9E, $45
                dc.b $3B, $42, $58, $55, $65, $DB, $FF, 0
byte_B5E2:      dc.b 0, 6, 0, $1E, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4BC   o
                                        ; ROM:0000B4C0   o
                dc.b $32, $46, $79, $DB, 0, $86, $8C, $52
                dc.b $48, $51, $DB, 0, $93, $94, $58, $41
                dc.b $DB, $93, $94, $58, $41, $DB, $DB, $FF
                dc.b $D0, $90, $3D, $79, $3B, $76, $D8, $8A
                dc.b $CC, $A4, $8A, $C7, $DA, $AE, $AB, $45
                dc.b $42, $8D, $DA, $A6, $DA, $DB, $DB, $FF
                dc.b $D0, $90, $34, $32, $79, $D8, $83, $A5
                dc.b $49, $82, $80, $A3, $7F, $AB, $8D, $A4
                dc.b $B2, $C5, $DA, $DB, $DB, $FF, $D0, $90
                dc.b $81, $BA, $48, $B9, $86, $48, $70, $32
                dc.b $51, $DB, 0, $83, $A5, $48, $32, $61
                dc.b $36, $45, $41, $31, $42, $39, $56, $55
                dc.b $35, $DB, $FF, 0
byte_B64E:      dc.b 0, 6, 0, $16, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4AC   o
                                        ; ROM:0000B4B0   o
                dc.b $83, $A5, $48, $44, $49, $D8, $98, $94
                dc.b $CA, $BB, $80, $C0, $DA, $D9, $FF, 0
                dc.b $D0, $90, $3C, $4E, $44, $31, $D9, $85
                dc.b $89, $9D, $48, 0, $63, $5C, $3D, $31
                dc.b $49, $D8, $39, $39, $6A, 0, $34, $5B
                dc.b $55, $D9, $FF, 0, $D0, $90, $32, $55
                dc.b $3D, $33, $D9, $83, $A5, $49, 0, $83
                dc.b $80, $BF, $A5, $45, $44, $55, $4E, $6A
                dc.b 0, $31, $36, $42, $58, $55, $D9, $FF
                dc.b $D0, $90, $98, $84, $45, 0, $49, $31
                dc.b $55, $48, $49, $D8, $83, $9D, $82, $3A
                dc.b $5C, $48, $4D, $32, $3A, $D9, $FF, 0
byte_B6B6:      dc.b 0, 6, 0, $18, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4A4   o
                                        ; ROM:0000B4A8   o
                dc.b $34, $49, $5A, $32, $D9, $34, $48, $56
                dc.b $49, $D8, $93, $94, $A1, $97, $67, $DC
                dc.b $FF, 0, $D0, $90, $8B, $84, $A4, $BF
                dc.b $8B, $48, 0, $96, $9F, $A3, $E2, 0
                dc.b $B2, $C5, $9D, $3C, $55, $5C, $63, $76
                dc.b $44, $31, $D9, $FF, $D0, $90, $5A, $37
                dc.b $47, $3F, $35, $31, $D8, $BE, $80, $BC
                dc.b $CA, $DA, $DC, $DC, $FF, 0, $D0, $90
                dc.b $32, $5C, $6B, $32, $48, 0, $63, $35
                dc.b $5C, $67, $D9, $90, $85, $30, $32, $65
                dc.b $D9, $FF
byte_B710:      dc.b 0, 6, 0, $1C, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:off_B49C   o
                                        ; ROM:0000B4A0   o
                dc.b $87, $80, $88, $86, $DB, $87, $80, $88
                dc.b $86, $DB, $BD, $8D, $81, $9C, $81, $85
                dc.b $3D, $5A, $DB, $DB, $FF, 0, $D0, $90
                dc.b $AA, $A5, $AA, $A5, $49, $D8, $BD, $A3
                dc.b $C7, $86, $39, $32, $3B, $E2, 0, $3F
                dc.b $51, $53, $5B, $44, $31, $DB, $FF, 0
                dc.b $D0, $90, $58, $56, $55, $52, $48, $44
                dc.b $53, 0, $58, $79, $42, $4F, $57, $31
                dc.b $D8, $BB, $DA, $A6, $DA, $D9, $FF, 0
                dc.b $D0, $90, $80, $AB, $8E, $DA, $8C, $C2
                dc.b $8E, $DA, $D8, $8B, $8E, $AB, $BB, $80
                dc.b $3D, $5A, $DB, $DB, $FF, 0
byte_B776:      dc.b 0, 6, 0, $22, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4CC   o
                                        ; ROM:0000B4D0   o
                dc.b $5B, $3F, $3B, $49, 0, $86, $A2, $BD
                dc.b $BB, $DA, $BB, $DA, $43, $52, $32, $3B
                dc.b $4E, $3C, $D9, $6B, $66, $A9, $A6, $8A
                dc.b $86, $D9, $FF, 0, $D0, $90, $67, $31
                dc.b $63, $44, $92, $88, $A6, $E2, 0, $8F
                dc.b $C7, $85, $C8, $43, $31, $36, $4E, $3C
                dc.b $5A, $D9, $9A, $9A, $9A, $D8, $D8, $D8
                dc.b $FF, 0, $D0, $90, $58, $56, $55, $52
                dc.b $5C, $44, $53, 0, $58, $79, $42, $4F
                dc.b $57, $31, $D8, $BB, $DA, $A6, $DA, $D9
                dc.b $FF, 0, $D0, $90, $6B, $32, $6A, $52
                dc.b $31, $31, $38, $6B, 0, $32, $4E, $3E
                dc.b $32, $67, $44, $D8, $83, $9D, $82, $D9
                dc.b $FF, 0
byte_B7E8:      dc.b 0, 6, 0, $22, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4D4   o
                                        ; ROM:0000B4D8   o
                dc.b $61, $6E, $3A, $3F, $67, $44, $D9, $39
                dc.b $48, $7F, $89, $A4, $92, $8E, $80, $AC
                dc.b $DA, $48, $90, $A2, $E2, $5B, $3C, $56
                dc.b $3F, $35, $DC, $FF, $D0, $90, $50, $35
                dc.b $3B, $48, $5A, $3B, $4F, $67, $D8, $93
                dc.b $84, $9D, $45, $44, $56, $D9, $40, $36
                dc.b $77, $32, $49, $52, $32, $34, $5B, $54
                dc.b $67, $D9, $FF, 0, $D0, $90, $91, $A6
                dc.b $A3, $8B, $92, $48, $80, $95, $45, $44
                dc.b $54, $3A, $5D, $54, $58, $5D, $79, $3F
                dc.b $35, $DB, $DB, $7F, $89, $A4, $92, $DB
                dc.b $DB, $FF, $D0, $90, $82, $80, $A3, $7F
                dc.b $AB, $8D, $A4, $B2, $C5, $DA, $43, $3B
                dc.b $42, $48, $4D, $39, $54, $49, $6B, $39
                dc.b $4C, $58, $79, $3F, $DB, $DB, $FF, 0
byte_B868:      dc.b 0, 6, 0, $22, $FF, $FF, $D0, $90
                                        ; DATA XREF: ROM:0000B4C4   o
                                        ; ROM:0000B4C8   o
                dc.b $61, $6E, $3A, $3F, $67, $44, $D9, $39
                dc.b $48, $7F, $89, $A4, $92, $8E, $80, $AC
                dc.b $DA, $48, $90, $A2, $E2, $5B, $3C, $56
                dc.b $3F, $35, $DC, $FF, $D0, $90, $50, $35
                dc.b $3B, $48, $5A, $3B, $4F, $67, $D8, $93
                dc.b $84, $9D, $45, $44, $56, $D9, $40, $36
                dc.b $77, $32, $49, $52, $32, $34, $5B, $54
                dc.b $67, $D9, $FF, 0, $D0, $90, $91, $A6
                dc.b $A3, $8B, $92, $48, $80, $95, $45, $44
                dc.b $54, $3A, $5D, $54, $58, $5D, $79, $3F
                dc.b $35, $DB, $DB, $7F, $89, $A4, $92, $DB
                dc.b $DB, $FF, $D0, $90, $82, $80, $A3, $7F
                dc.b $AB, $8D, $A4, $B2, $C5, $DA, $43, $3B
                dc.b $42, $48, $4D, $39, $54, $49, $6B, $39
                dc.b $4C, $58, $79, $3F, $DB, $DB, $FF, 0
byte_B8E8:      dc.b 0, 4, $FF, $FF, $D0, $90, $35, $79
                                        ; DATA XREF: ROM:0000B4DC   o
                                        ; ROM:0000B4E0   o
                dc.b $D8, $D8, $D8, 0, $35, $33, $6A, $40
                dc.b $76, $5C, $D8, $D8, $D8, $DC, $DC, $FF


; Loads multiple palettes from pointer table sequentially
Gfx_LoadMultiplePalettes:                               ; CODE XREF: Gfx_WaitForFadeAndLoadTiles+3C   p  ; was: sub_B900
                                        ; Cutscene_InitCreditsScreen+64   p ...
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
loc_B92E:                               ; CODE XREF: Gfx_LoadMultiplePalettes+42   j
                move.w  (a4)+,d0
                bne.s Gfx_LoadPaletteEntry
                rts
; ---------------------------------------------------------------------------
; Loads a single palette entry from palette buffer data
Gfx_LoadPaletteEntry:                               ; CODE XREF: Gfx_LoadMultiplePalettes+30   j  ; was: loc_B934
                ext.l   d0
                addi.l  #Gfx_SyncPaletteBuffers,d0
                movea.l d0,a0
                bsr.w   LoadPalette
                bra.s   loc_B92E
; End of function Gfx_LoadMultiplePalettes
; ---------------------------------------------------------------------------
word_B944:      dc.w $20A, 0            ; DATA XREF: Gfx_WaitForFadeAndLoadTiles+36   o
word_B948:      dc.w $60, $E2, 0        ; DATA XREF: UI_InitOptionsScreen+72   o
word_B94E:      dc.w $28A, $2B0, 0      ; DATA XREF: UI_InitializeStageStart+DC   o
word_B954:      dc.w $2D0, $2D6, 0      ; DATA XREF: Gfx_LoadMenuGraphics+32   o
word_B95A:      dc.w $EE, $F4, $FA, $100, 0, $EE, $F4, $FA, $100, 0
                                        ; DATA XREF: UI_InitializeContinueScreen+40   o
word_B96E:      dc.w $EE, $F4, $FA, $100, 0
                                        ; DATA XREF: Results_InitializeScreen+6C   o
word_B978:      dc.w $26A, 0, $2F6, $336, 0
                                        ; DATA XREF: Stage_InitializeTransition+16   o
word_B982:      dc.w $B14, $B54, 0      ; DATA XREF: Cutscene_InitCreditsScreen+5E   o
                                        ; Cutscene_InitPlanetScene+20   o ...
word_B988:      dc.w $34C, 0            ; DATA XREF: ROM:stru_127A8   o
                                        ; ROM:stru_127C6   o ...
word_B98C:      dc.w $34C, $38E, 0      ; DATA XREF: Camera_ShellshogunBossInit+38   o
                                        ; ROM:stru_12802   o
word_B992:      dc.w $3B0, 0            ; DATA XREF: ROM:stru_12820   o
                                        ; ROM:stru_1283E   o ...
word_B996:      dc.w $3F2, 0            ; DATA XREF: ROM:stru_1287A   o
word_B99A:      dc.w $3F2, $966, 0      ; DATA XREF: ROM:stru_121FE   o
                                        ; ROM:stru_12898   o
word_B9A0:      dc.w $442, 0            ; DATA XREF: Cutscene_LoadInitialAssets+C   o
word_B9A4:      dc.w $482, 0            ; DATA XREF: ROM:stru_128B6   o
                                        ; ROM:stru_128D4   o ...
word_B9A8:      dc.w $4C2, 0            ; DATA XREF: ROM:stru_1292E   o
                                        ; ROM:stru_1294C   o ...
word_B9AC:      dc.w $502, 0            ; DATA XREF: ROM:stru_12988   o
word_B9B0:      dc.w $562, 0            ; DATA XREF: ROM:stru_129A6   o
                                        ; ROM:stru_129C4   o
word_B9B4:      dc.w $5A2, 0            ; DATA XREF: ROM:stru_129E2   o
                                        ; ROM:stru_12A00   o ...
word_B9B8:      dc.w $5E2, 0, $632, 0   ; DATA XREF: ROM:stru_12A5A   o
word_B9C0:      dc.w $690, $6B0, 0      ; DATA XREF: Cutscene_SevenForcesLoadGraphics   o
word_B9C6:      dc.w $6B8, $818, 0      ; DATA XREF: ROM:stru_12A78   o
                                        ; ROM:stru_12AB4   o
word_B9CC:      dc.w $6B8, $828, 0      ; DATA XREF: ROM:stru_12A96   o
word_B9D2:      dc.w $6F8, $848, 0      ; DATA XREF: ROM:stru_12AD2   o
word_B9D8:      dc.w $718, $E34, 0      ; DATA XREF: ROM:stru_12AF0   o
word_B9DE:      dc.w $738, 0            ; DATA XREF: ROM:stru_12B0E   o
word_B9E2:      dc.w $758, 0            ; DATA XREF: ROM:stru_12B2C   o
word_B9E6:      dc.w $798, 0            ; DATA XREF: ROM:stru_12B4A   o
                                        ; Stage_InitPlayerAndScroll+24   o


; Synchronizes palette data across multiple RAM buffers
Gfx_SyncPaletteBuffers:                               ; CODE XREF: Gfx_UpdateBossPalette+6C   p  ; was: sub_B9EA
                                        ; Gfx_LoadStage17Palettes+12   j ...
                move.w  (word_FFE3EC).w,(dword_FF8040).w
                bsr.s   LoadPalette
                move.w  (dword_FF8040).w,(word_FFE36C).w
                move.w  (dword_FF8040).w,(word_FFE3EC).w
                rts
; End of function Gfx_SyncPaletteBuffers
LoadPalette:                            ; CODE XREF: RegionRestricted+2A   p
                                        ; Gfx_SetupTitleScreenLetters+7E   p ...
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
Gfx_CopyPaletteLoop:                               ; CODE XREF: LoadPalette+24   j  ; was: loc_BA20
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                dbf d7,Gfx_CopyPaletteLoop
                rts
; End of function LoadPalette
; ---------------------------------------------------------------------------
byte_BA2A:      dc.b $42, $E, 0, 0, $E, $EE, 0, $EE, 0, $AE, 0, $6E, 0, $E, 0, 4
                                        ; DATA XREF: Gfx_LoadMultiplePalettes+24   o
                dc.b 0, $48, 2, $20, 4, $42, 8, $86, $C, $CA, 6, 0, 8, $40, $C, $84
byte_BA4A:      dc.b 0, $3F, 0, 0, 0, $60, $C, $EA, 0, 0, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: RegionRestricted+24   o
                                        ; Gfx_SetupTitleScreenLetters+78   o ...
                dc.b 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b 0, 0, 0, 0, 6, 0, $E, $EC, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b 0, 0, 0, 0, 2, 0, 2, $22, $C, $22, $E, $42, 0, $E0, 0, 0
                dc.b $E, $22, $E, $EE, 0, $6E, $A, $EE, 0, $28, 0, 4, $C, $EE, 0, 0
                dc.b 0, $CE, 0, 0, 0, 0, 2, 0, 0, 2, 0, 4, 0, 6, 0, 8
                dc.b 0, $A, 0, $C, 0, $2E, 0, $4E, 0, 0, 8, 0, $E, $62, $E, $CA
                dc.b 0, 0, 2, 1, 0, 4, 0, $8E
byte_BAD2:      dc.b $42, 1, 0, 2, 0, $6E, 2, 1, 6, 0, $E, $80, $22, 1, 4, 0
                                        ; DATA XREF: UI_InitializePasswordScreen+38   o
                dc.b 8, $40, $42, 1, 6, 0, $E, $EC, $62, 1, 0, 6, 0, $AE
byte_BAF0:      dc.b 0, $3F, 0, 0, 0, $20, 2, $E6, 0, $2E, 0, $E, 0, 8, 0, 4
                                        ; DATA XREF: UI_InitializeStageSelect+7E   o
                                        ; Stage_InitializeStageSelect+50   o ...
                dc.b 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b 0, 0, 0, 0, 0, 0, 4, $22, 0, $4C, 0, $2A, 0, 8, 0, 0
                dc.b 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b 0, 0, 0, 0, 6, 0, $E, $EC, $C, $AA, $A, $88, 8, $66, 6, $44
                dc.b 4, $22, 0, $A, 0, 0, $A, $AA, 6, $66, 2, $22, 0, 0, 0, 0
                dc.b 0, 0, 0, 0, 0, 6, 0, $AE, 0, $26, 0, 4, 0, 2, 0, 0
                dc.b 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b 0, 0
byte_BB72:	binclude	"data/mappings/byte_BB72.bin"
byte_BB72_End:
byte_BE1E:	binclude	"data/other/byte_BE1E.bin"
byte_BE1E_End:
byte_BF2C:      dc.b $62, $E, 2, 0, $E, $EE, 0, $6E, 6, $EE, 2, $84, 8, $EA, $C, $EE
                                        ; DATA XREF: Gfx_LoadStage17Palettes   o
                dc.b 4, 0, 6, $20, 8, $42, $A, $64, $C, $86, $E, $A8, $E, $CA, $E, $EE
                dc.b 2, $1E, $E, $EE, $E, $AA, $A, $68, $A, $44, 8, $22, 4, $22, $E, $86
                dc.b $E, $64, $E, $42, $A, $86, 6, $42, 2, $20, 2, 0, 0, 0, 0, $24
                dc.b 0, 0, $E, $EE, $E, $CC, $E, $AA, $C, $66, 8, $44, 4, $22, 6, $88
                dc.b 4, $66, 2, $44, 0, $22, 0, 0, 2, $68, 0, $46, 0, $24, $E, $EE
                dc.b 2, $1E, 0, $20, $E, $EC, 2, $62, $E, $EC, $E, $CA, $A, $84, 8, $62
                dc.b 4, $40, 2, $20, 0, $22, 2, $46, 2, $8A, 4, $CC, 6, $40, $E, $84
                dc.b 0, 0, $C, $CC, $A, $88, 2, 0, 2, 2, 4, $24, 0, 2, 0, $20
                dc.b 4, $64, 2, $48, 4, $8C, 0, $24, 4, $20, 6, $42, 8, $66, 0, $2A
                dc.b 2, $1E, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, 8, $86, $E, $EC, $C, $CA
                dc.b $E, $EC, $E, $EE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                dc.b 2, $22, $E, $CC, 2, $24, 2, $66, 4, $88, $C, $CC, 0, $44, 8, $AA
                dc.b 4, $46, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, 2, $44, 2, $42
byte_C00C:      dc.b $22, 6, 8, $CC, 2, $44, 4, $66, 6, $88, 8, $AA, 4, $66, 6, $88
                                        ; DATA XREF: Boss_SylpheedIntroMove+16   o
byte_C01C:      dc.b 2, $1E, 0, 0, 0, $22, 2, $42, 6, $64, 0, $22, 2, $44, 4, $66
                                        ; DATA XREF: Boss_ArtemisIntroMove+1C   o
                dc.b 6, $88, $FF, $FF, 0, $22, 2, $44, 2, $66, 4, $AC, $A, $CE, $FF, $FF
                dc.b 0, 0, 0, 0, 2, 0, 2, $22, 6, $44, 2, 0, 4, 0, 6, 0
                dc.b 6, $20, 8, $42, $A, $64, $C, $86, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
byte_C05C:	binclude	"data/other/byte_C05C.bin"
byte_C05C_End:
byte_C1A2:      dc.b $62, $E, 0, 0, $E, $EE, $E, $A8, 0, 6, 0, $2A, 0, 0, 4, $6E
                                        ; DATA XREF: Gfx_LoadStagePalette   o
                                        ; sub_11EAA   o ...
                dc.b 0, $46, 2, $8A, 6, $CC, 2, $24, 4, $6A, 8, $AE, 6, $22, $A, $62
byte_C1C2:      dc.b $62, $E, 0, 0, $E, $EE, 0, $EE, 0, $AE, 0, $6E, 0, $E, 0, 4
                                        ; DATA XREF: Entity_TrainEndLoadPalette   o
                dc.b 0, $48, 2, $20, 4, $42, 8, $86, $C, $CA, 6, 0, 8, $40, $C, $84
byte_C1E2:      dc.b $62, $E, $E, $EE, $F, $FF, $A, $26, $A, $AA, 8, $88, $F, $FF, 6, $66
                                        ; DATA XREF: Stage_LoadStage5Graphics+6   o
                dc.b 4, $44, 2, $22, $C, $AA, $A, $88, 8, $66, 6, $44, 4, $22, 0, 0
                dc.b $62, 6, 0, 0, 2, $22, 2, $44, 4, $68, 8, $AC, 0, 0, $A, $CC
byte_C212:      dc.b $62, $E, $E, $EE, $E, $AA, $A, $66, 6, $22, 4, 0, 0, 0, 0, $AE
                                        ; DATA XREF: Boss_DestroyerProtoInit+1C   o
                dc.b 0, $6C, 0, $28, 0, 0, 0, 4, 8, $CC, 6, $88, 4, $46, 2, $22
                dc.b $22, $E, $E, $EE, $E, $AA, $A, $66, 6, $22, 4, 0, 0, 0, 0, $AE
                dc.b 0, $6C, 0, $28, 0, 0, 0, 4, 8, $CC, 6, $88, 4, $46, 2, $22
byte_C252:      dc.b $62, $E, 0, 0, $E, $EE, $E, $CC, $C, $AA, $A, $88, 0, 0, 2, 2
                                        ; DATA XREF: ROM:stru_11366   o
                dc.b 6, 4, $C, $48, 2, $24, 4, $46, 4, $AA, 0, $A, 0, 6, 0, 2
byte_C272:      dc.b $62, $E, 0, 0, $E, $EE, $E, $CC, $C, $AA, $A, $88, 0, 0, 0, 4
                                        ; DATA XREF: ROM:stru_1137A   o
                dc.b 0, $26, 0, $4A, 0, $6C, 2, $AE, 2, $22, 4, $44, 0, $2A, 4, $6E
byte_C292:      dc.b $62, $E, 0, 0, $E, $EE, $E, $CC, $C, $AA, $A, $88, 0, 0, 2, 4
                                        ; DATA XREF: ROM:stru_1138E   o
                dc.b 0, $2A, 2, $6E, 4, $40, 0, $88, 8, $CC, 2, $24, 0, $48, 6, $8C
byte_C2B2:      dc.b $62, $E, 0, 0, $C, $EE, $C, $CC, $A, $AA, 6, $66, 0, 0, 4, $8C
                                        ; DATA XREF: ROM:stru_113AA   o
                dc.b 2, $6A, 0, $48, 0, $26, 4, $6A, 2, $2A, 0, 4, 8, $88, 4, $44
byte_C2D2:      dc.b $62, $E, 2, 2, $C, $EE, $A, $AA, 8, $88, 6, $66, 0, 0, 2, 4
                                        ; DATA XREF: ROM:stru_113B4   o
                dc.b 0, 8, 0, $C, 0, $4E, 8, $8E, 0, 6, 0, $48, 2, $8A, 4, $CC
byte_C2F2:      dc.b $62, $E, 0, 0, $E, $EE, $E, $CC, $E, $AA, $E, $88, 0, 0, 4, $22
                                        ; DATA XREF: ROM:stru_113D0   o
                dc.b 6, $44, $C, $68, 2, 6, 4, $2C, 8, $8E, 0, $42, 2, $84, 2, $CA
byte_C312:      dc.b $62, $D, 2, 2, $E, $EE, $A, $AA, 8, $88, 6, $66, 0, 0, 2, $22
                                        ; DATA XREF: ROM:stru_113EC   o
                dc.b 4, $24, 8, $42, $C, $60, $E, $C0, 0, $CE, 0, $6A, 0, $26
byte_C330:      dc.b $62, $E, 0, 2, $C, $EE, 0, 0, 0, 0, 8, $66, 0, 0, 6, $20
                                        ; DATA XREF: Boss_FlyingNeoSetup+D0   o
                dc.b 2, 0, 4, $22, 0, 6, 0, $2A, 2, $6E, 0, $24, 2, $68, 6, $AC
                dc.b $62, $E, 2, 0, $C, $CC, 0, 0, 0, 0, $A, $88, 0, 0, 8, $46
                dc.b 4, $24, 2, 2, 4, 2, $A, 6, 8, $6A, 4, $88, 2, $44, 0, $22
byte_C370:      dc.b $62, $E, 2, 0, $E, $EE, 0, 0, 0, 0, 0, 0, 0, 0, $C, $CA
                                        ; DATA XREF: ROM:stru_11424   o
                dc.b $A, $A6, $A, $64, 6, $42, 4, $8C, 0, $48, 0, 4, 2, $AC, 0, $46
byte_C390:      dc.b $62, $E, 0, 0, $E, $EE, 8, $88, $E, $AA, $E, $88, $F, $FF, 4, 0
                                        ; DATA XREF: ROM:stru_11440   o
                dc.b 6, $20, 8, $40, $A, $62, $C, $A4, 2, 4, 2, 8, 2, $C, 4, $4E
byte_C3B0:      dc.b $62, $E, 0, 0, $E, $EE, $C, $AA, $A, $88, 8, $66, $F, $FF, 6, $44
                                        ; DATA XREF: ROM:stru_11454   o
                dc.b 4, $22, 4, 0, $A, $22, $E, $66, 0, $24, 0, $46, 0, $8A, 0, $CE
byte_C3D0:      dc.b $62, $E, 0, 0, $C, $EC, 8, $C8, 6, $64, 2, $20, $F, $FF, 8, $EE
                                        ; DATA XREF: ROM:stru_11468   o
                dc.b 4, $AA, 0, $66, 0, $22, 0, 4, 0, $28, 0, $4C, 4, $8E, 8, $CE
byte_C3F0:      dc.b $62, 8, 0, 0, $E, $EE, 8, $CE, 6, $8C, 6, $6C, $F, $FF, 4, $26
                                        ; DATA XREF: Gfx_LoadSnakePalette   o
                dc.b 2, 2, 4, $4A
byte_C404:      dc.b $62, $E, 0, 2, $E, $EE, $A, $AA, 6, $66, 2, $22, $F, $FF, $A, $EE
                                        ; DATA XREF: ROM:00011538   o
                                        ; UNUSED: Love Penguin boss palette
                                        ; Referenced by: Boss ID $01C0 (line 20999)
                dc.b 8, $CE, 6, $8C, 4, $6A, 2, $48, 0, $26, 0, 4, 0, 0, 0, $A
byte_C424:      dc.b $62, $E, 0, 0, $E, $EE, $E, $CC, $E, $AA, $E, $88, $FF, $FF, $A, $46
                                        ; DATA XREF: ROM:stru_11498   o
                dc.b 6, 2, 6, $6E, 4, $2C, 2, 8, 2, 4, 2, $26, 0, $48, 0, $8C
byte_C444:      dc.b $62, $E, 0, 0, $E, $EE, $E, $CC, $E, $AA, $E, $88, $F, $FF, 0, 6
                                        ; DATA XREF: ROM:stru_114B4   o
                dc.b 0, $2A, 4, $6E, 0, $22, 2, $44, 2, $88, 0, $26, 0, $48, 0, $8C
byte_C464:      dc.b 2, $E, 0, 2, 0, $26, 0, $6A, 0, 0, 0, 0, 0, 0, 2, $AE
                                        ; DATA XREF: Boss_ViblackInit+9A   o
                dc.b 4, $20, 6, $42, $A, $64, $C, $A8, $E, $CA, $E, $EC, 0, 0, $E, $EE
byte_C484:      dc.b 2, $E, 0, 2, 4, 6, 6, $28, 0, 0, 0, 0, 2, 0, 8, $4A
                                        ; DATA XREF: Boss_BackStringerTransitionFinish+3C   o
                dc.b 2, $20, 4, $42, 6, $66, 8, $88, $A, $AA, $A, $CC, 0, 0, $A, $AA
byte_C4A4:      dc.b $22, $B, $E, $CA, $E, $C8, $E, $A6, $E, $84, $C, $62, $A, $40, 8, $20
                                        ; DATA XREF: Stage_ViblackPostBattleScroll2+3E   o
                dc.b 6, 0, 4, 0, 2, 0, 2, 0, 2, 0
byte_C4BE:      dc.b $62, $E, 2, 0, $C, $EE, 2, $26, 8, $8A, 0, $24, $F, $FF, 0, $46
                                        ; DATA XREF: ROM:stru_114D0   o
                dc.b 2, $8A, 6, $CE, 0, $6E, 0, $2C, 0, 6, $F, $FF, 6, $68, $A, $AC
byte_C4DE:      dc.b $62, $E, 2, 0, 4, 4, 6, $26, 8, $4A, $A, $6C, $F, $FF, $C, $AE
                                        ; DATA XREF: ROM:stru_11500   o
                                        ; Gfx_LoadStage17Palettes+C   o
                dc.b $C, $CE, 0, $22, $E, $EE, 0, $46, 4, $8A, 6, $EE, 0, 0, 0, 0
                dc.b 2, $1E, 0, 0, 0, $22, 2, $44, $E, $EE, $A, $EA, 6, $E6, 2, $C2
                dc.b 0, $80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.b 0, 0, 0, 0, 0, $24, 0, $46, 0, $68, 2, $8A, 4, $42, 6, $64
                dc.b 8, $86, $A, $AA, $E, $EE, 4, 0, 8, $22, $C, $66, $E, $88, 2, $20
                dc.b $62, $E, 0, 0, $E, $EE, $E, $EC, $E, $A8, $E, $86, $E, $64, $E, $EC
                dc.b $E, $CA, $E, $A8, $E, $86, $E, $64, $C, $42, $A, $20, 6, $20, 4, 0
byte_C55E:      dc.b $62, $E, 0, 0, $E, $EE, $C, $CC, $A, $AA, 8, $88, $F, $FF, 6, $66
                                        ; DATA XREF: ROM:stru_114E4   o
                                        ; Boss_JampanDefeatEndFade+6   o
                dc.b 0, $A, 0, $E, 2, 4, 2, $26, 2, $48, 4, $6A, 6, $8C, 8, $AE
byte_C57E:      dc.b $62, $E, 0, 0, $E, $EE, 6, $E4, 0, $80, 0, $28, $F, $FF, 0, $6C
                                        ; DATA XREF: ROM:stru_1151C   o
                dc.b 0, $EA, 4, $22, 4, $46, 4, $88, 8, $CC, 0, 6, 2, $C, 6, $6E
byte_C59E:      dc.b $62, $E, 0, 0, $E, $EE, 6, $AC, 4, $8A, 2, $68, $F, $FF, 2, $46
                                        ; DATA XREF: ROM:stru_1147C   o
                dc.b 0, $24, 2, 6, 2, $2A, 2, $6C, 0, 0, 2, 2, 6, $24, 8, $68
byte_C5BE:      dc.b $62, $E, 0, 0, $E, $EE, $A, $AC, 2, $AC, 8, $EE, $F, $FF, 0, $48
                                        ; DATA XREF: ROM:stru_115A8   o
                                        ; UNUSED: Lambda Bunny boss palette
                                        ; Referenced by: stru_115A8 (Boss ID $03EC)
                                        ; See sub_E6D6 for loader function (line 16561)
                dc.b 0, 4, 2, 4, 2, $A, $C, $8E, 2, 2, 6, $44, $A, $A8, $E, $CA
byte_C5DE:      dc.b $62, $E, 0, 0, $E, $EE, 0, 6, 0, $48, 0, $8C, $F, $FF, 4, 0
                                        ; DATA XREF: ROM:stru_115C4   o
                                        ; UNUSED: Unknown boss $3F0 palette
                                        ; Referenced by: stru_115C4 (Boss ID $3F0)
                                        ; See sub_E72C for loader function (line 16598)
                dc.b $A, 0, $E, $20, $E, $60, $C, $AA, 8, $66, 6, $44, 4, $22, 0, $2E
byte_C5FE:      dc.b $62, $E, 0, 0, $E, $EE, $E, $CA, $C, $86, $A, $42, $F, $FF, 4, 0
                                        ; DATA XREF: ROM:stru_115E0   o
                                        ; UNUSED: Unknown boss $3F4 palette
                                        ; Referenced by: stru_115E0 (Boss ID $3F4)
                                        ; See sub_E782 for loader function (line 16646)
                                        ; Possibly Praying Mantis or Sigma Fox
                dc.b 2, 2, 2, 6, 4, $2A, $A, $6E, 6, $CC, 2, $8A, 0, $46, 8, $20
                dc.b $62, $E, 0, 0, $E, $EE, 2, 2, 4, $24, 6, $46, $F, $FF, 8, $68
                dc.b $A, $8A, $C, $AC, $E, $CE, 0, 4, 0, 8, 0, $C, 2, $4E, 6, $8E
byte_C63E:      dc.b $62, $E, 0, 0, $E, $EE, 2, $20, 4, $42, 4, $64, $F, $FF, 6, $AA
                                        ; DATA XREF: ROM:000115FC   o
                                        ; UNUSED: Dragon boss palette
                                        ; Referenced by: Boss ID $03FC (line 21104)
                dc.b 4, $CE, 2, $8C, 2, $6A, 2, $46, 4, $24, 4, $44, 6, $66, $A, $AA
                dc.b $62, $E, 0, 0, $E, $EE, 8, $6E, 4, $2C, 2, 8, $F, $FF, 2, $24
                dc.b 0, $46, 2, $8A, 6, $CC, 0, $6E, 0, $2C, 0, 6, 2, 4, $A, $86
byte_C67E:      dc.b $62, $E, 2, 4, $E, $EE, $A, $CA, 4, $66, 0, $44, $F, $FF, 2, $CE
                                        ; DATA XREF: ROM:stru_11658   o
                dc.b 0, $8C, 0, $8E, 0, $4C, 0, $2A, 2, 8, 0, $68, 6, $AE, $A, $EE
byte_C69E:      dc.b $62, $E, 6, 0, $E, $EE, 6, $66, 4, $44, 4, $42, $F, $FF, $A, $AA
                                        ; DATA XREF: ROM:stru_1166C   o
                dc.b 8, $66, $E, $48, $C, $26, $A, $24, 8, 2, 0, $26, 0, $8C, $E, $AC
byte_C6BE:      dc.b $62, $E, 2, $20, $E, $EE, 2, $8C, 0, $46, 2, $42, $F, $FF, 0, $C8
                                        ; DATA XREF: ROM:stru_1169E   o
                dc.b 0, $84, 4, $C6, 2, $84, 0, $62, 0, $42, 0, $40, 0, $6C, 4, $EA
byte_C6DE:      dc.b $62, $E, 4, 2, $E, $EE, 6, $6C, 4, $48, 2, $24, $F, $FF, $A, $8A
                                        ; DATA XREF: ROM:stru_11680   o
                dc.b 6, $68, $C, $CA, $A, $88, 8, $66, 2, $22, 0, $28, 0, $6E, $C, $CC
byte_C6FE:      dc.b $62, $E, 2, 2, $E, $EE, 6, $EE, 2, $8A, 2, $22, $F, $FF, $E, $A8
                                        ; DATA XREF: ROM:stru_11676   o
                dc.b $A, $64, $E, $A8, $E, $62, $C, $22, 8, 2, 4, 2, 4, $84, $E, $EC
byte_C71E:      dc.b $62, $E, 0, 2, $E, $EE, $E, $A4, 8, $62, 4, $22, $F, $FF, 0, $AC
                                        ; DATA XREF: ROM:stru_11694   o
                dc.b 0, $46, 4, $8E, 0, $4E, 0, $A, 0, 6, 0, 2, 0, $6C, 4, $EE
byte_C73E:      dc.b $62, $E, 2, $22, $E, $EC, 0, $6C, 0, $26, 2, $22, $F, $FF, 4, $86
                                        ; DATA XREF: ROM:stru_1168A   o
                dc.b 2, $44, $A, $44, 4, $20, 2, 2, 2, 0, 0, 2, 0, $AE, 8, $AA
byte_C75E:      dc.b $62, $E, 0, 0, $E, $EE, 6, $E4, 0, $80, 0, $28, $F, $FF, 0, $6C
                                        ; DATA XREF: ROM:stru_11568   o
                dc.b 0, $AE, 4, $22, 4, $46, 4, $88, 8, $CC, 0, 6, $C, $60, $E, $A6
byte_C77E:      dc.b $62, $E, 0, 0, $A, $EE, 4, $CE, 0, $6C, 0, $2A, $F, $FF, 0, 6
                                        ; DATA XREF: ROM:stru_11554   o
                dc.b 2, $8E, 0, $4E, 0, $E, 0, $A, 2, 6, $E, $EE, $A, $24, $E, $A4
byte_C79E:      dc.b $62, $E, 2, 0, $E, $EE, $E, $EC, $C, $AA, 8, $88, $F, $FF, 4, $44
                                        ; DATA XREF: ROM:stru_11584   o
                dc.b 2, $22, 0, $24, 0, $48, 2, $8E, 4, 2, 8, $24, $C, $6A, 0, $E
byte_C7BE:      dc.b $62, $E, $E, $EE, $C, $AA, $A, $64, 8, $22, 4, 0, $F, $FF, 8, $CC
                                        ; DATA XREF: ROM:stru_1163C   o
                dc.b 4, $88, 2, $44, 2, $22, 8, $6E, 2, $E, 0, 6, 0, 0, $F, $FF
byte_C7DE:      dc.b $62, $E, 0, 0, $E, $EE, $E, $88, 8, $44, 4, $22, $F, $FF, 2, 0
                                        ; DATA XREF: ROM:stru_11618   o
                dc.b 0, 2, 0, 4, 0, $24, 0, $46, 2, $68, 4, $AC, 6, $CE, 0, $AE
                dc.b $62, $E, 0, 0, $E, $EE, $F, $FF, $F, $FF, 0, $28, 0, 8, 0, $6C
                dc.b 0, $AE, 4, 2, 6, $24, 8, $46, $C, $8A, 0, 6, 2, $C, 6, $6E
byte_C81E:      dc.b $62, $E, 0, 0, $E, $EE, $A, $CE, 4, $8C, 2, $68, $FF, $FF, $A, $AA
                                        ; DATA XREF: Entity_SevenForcesIntro+36   o
                dc.b 6, $66, $E, $CC, $C, $AA, 8, $66, 6, $42, 4, $22, $E, $CC, $FF, $FF


; Main stage dispatcher jump table
Stage_Dispatcher:                               ; DATA XREF: ROM:off_FF36   o  ; was: sub_C83E
                                        ; ROM:0000FF46   o
                movea.w off_C84A(pc,d0.w),a0
                adda.l  #Stage_UpdateLogic,a0
                jmp     (a0)
; End of function Stage_Dispatcher
; ---------------------------------------------------------------------------
off_C84A:       dc.w Stage_UpdateLogic-Stage_UpdateLogic
                dc.w Stage_UpdateScrollAndCheck-Stage_UpdateLogic
                dc.w Stage_InitBossIntro-Stage_UpdateLogic
                dc.w Camera_BossPhaseHandler-Stage_UpdateLogic
                dc.w Camera_Stage2PhaseHandler-Stage_UpdateLogic
                dc.w Camera_AutoScrollCheck-Stage_UpdateLogic
                dc.w Camera_TransitionToBossArena-Stage_UpdateLogic
                dc.w Camera_AntroidBossInit-Stage_UpdateLogic
                dc.w Camera_Stage3Transition-Stage_UpdateLogic
                dc.w Camera_Stage3ScrollLimit-Stage_UpdateLogic
                dc.w Camera_Stage3_ScrollLimitCheck-Stage_UpdateLogic
                dc.w Camera_Stage3BossSetup-Stage_UpdateLogic
                dc.w Camera_UpdateBossPosition-Stage_UpdateLogic
                dc.w Camera_LockToBossArena-Stage_UpdateLogic
                dc.w Camera_ShellshogunBossInit-Stage_UpdateLogic
                dc.w Camera_LockPosition-Stage_UpdateLogic
                dc.w Camera_UpdateSmooth-Stage_UpdateLogic
                dc.w Camera_Smooth_ScrollLimitCheck-Stage_UpdateLogic
                dc.w Camera_FollowTarget-Stage_UpdateLogic
                dc.w Camera_SetBounds-Stage_UpdateLogic
                dc.w Stage_CameraTransitionCheck-Stage_UpdateLogic
                dc.w Stage_ScrollWaitTransition-Stage_UpdateLogic
                dc.w Stage_CheckTransitionReady-Stage_UpdateLogic
                dc.w Stage_AutoScrollUpdate-Stage_UpdateLogic
                dc.w Stage_AutoScroll_UpdateLoop-Stage_UpdateLogic
                dc.w Boss_MadamBarbarScrollInit-Stage_UpdateLogic
                dc.w Stage_InitPostBoss-Stage_UpdateLogic
                dc.w Stage_TransitionWithVBlank-Stage_UpdateLogic
                dc.w Stage_CheckScrollTransition-Stage_UpdateLogic
                dc.w Stage_InitJokerBoss-Stage_UpdateLogic
                dc.w Stage_PostJokerBoss-Stage_UpdateLogic
                dc.w Stage_PostJokerTransition-Stage_UpdateLogic
                dc.w Stage_InitStage7-Stage_UpdateLogic
                dc.w Stage_Stage7ScrollUpdate-Stage_UpdateLogic
                dc.w Stage_InitTerobusterBoss-Stage_UpdateLogic
                dc.w Stage_PostTerobusterIntro-Stage_UpdateLogic
                dc.w Stage_PostTerobusterTransition-Stage_UpdateLogic
                dc.w Stage_Stage7To8Transition-Stage_UpdateLogic
                dc.w Stage_CheckPlayerPosTrigger-Stage_UpdateLogic
                dc.w Stage_WaitAndTransition-Stage_UpdateLogic
                dc.w Stage_InitStage8Train-Stage_UpdateLogic
                dc.w Stage_InitStage8Train_ScrollCheck-Stage_UpdateLogic
                dc.w Stage_TrainToFlyingNeoTransition-Stage_UpdateLogic
                dc.w Stage_FlyingNeoScrollUpdate-Stage_UpdateLogic
                dc.w Stage_FlyingNeoVerticalScroll-Stage_UpdateLogic
                dc.w Stage_FlyingNeoScrollDecel-Stage_UpdateLogic
                dc.w Stage_FlyingNeoBattleStart-Stage_UpdateLogic
                dc.w Stage_FlyingNeoBattleUpdate-Stage_UpdateLogic
                dc.w Stage_PostFlyingNeoTransition-Stage_UpdateLogic
                dc.w Stage_InitStage9Flies-Stage_UpdateLogic
                dc.w Stage_FliesCheckTransition-Stage_UpdateLogic
                dc.w Stage_InitCaterpillarShip-Stage_UpdateLogic
                dc.w Stage_CaterpillarShipUpdate-Stage_UpdateLogic
                dc.w Stage_CaterpillarShipMovement-Stage_UpdateLogic
                dc.w Stage_CaterpillarScrollHandler-Stage_UpdateLogic
                dc.w Stage_XiTigerEmptyHandler-Stage_UpdateLogic
                dc.w Stage_XiTigerBossWait-Stage_UpdateLogic
                dc.w Stage_XiTigerBossWait_CheckEntity-Stage_UpdateLogic
                dc.w Stage_PostXiTigerTransition-Stage_UpdateLogic
                dc.w Stage_InitXiTigerBoss-Stage_UpdateLogic


; Updates stage logic and scroll
Stage_UpdateLogic:                               ; DATA XREF: Stage_Dispatcher+4   o  ; was: sub_C8C2
                                        ; ROM:off_C84A   o ...
                addq.w  #2,(word_FFA950).w
; Updates stage scroll position and checks for phase transition at specific coordinate
Stage_UpdateScrollAndCheck:                               ; DATA XREF: ROM:0000C84C   o  ; was: loc_C8C6
                bsr.w Gfx_UpdateScroll
                bsr.w Gfx_CalculateScrollPosition
                cmpi.w  #$668,(dword_FFA900).w
                bmi.s   locret_C8DA
                bra.w Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_C8DA:                            ; CODE XREF: Stage_UpdateLogic+12   j
                                        ; Stage_InitBossIntro+E   j
                rts
; End of function Stage_UpdateLogic
; Initializes boss introduction sequence
Stage_InitBossIntro:                               ; DATA XREF: ROM:0000C84E   o  ; was: sub_C8DC
                bsr.w Gfx_LoadBossTiles
                bsr.w Gfx_CalculateScrollPosition
                cmpi.w  #$6E8,(dword_FFA900).w
                bmi.s   locret_C8DA
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$6E8,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (stru_11366).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Stage_InitBossIntro
; Camera handler checking boss presence
Camera_BossPhaseHandler:                               ; DATA XREF: ROM:0000C850   o  ; was: sub_C910
                tst.w   (Entity_ObjectPool).w
                bne.s Camera_UpdateBossPhase
                bsr.w Stage_TriggerPhaseTransition
; Updates camera position during boss battle phase
Camera_UpdateBossPhase:                               ; CODE XREF: Camera_BossPhaseHandler+4   j  ; was: loc_C91A
                bsr.w Camera_UpdateTowardsPlayer
                bra.w Gfx_CalculateScrollPosition
; End of function Camera_BossPhaseHandler
; Stage 2 camera with transition check
Camera_Stage2PhaseHandler:                               ; DATA XREF: ROM:0000C852   o  ; was: sub_C922
                bsr.w Stage_InitSectionChange
                bsr.w Camera_UpdateTowardsPlayer
                bra.w Gfx_CalculateScrollPosition
; End of function Camera_Stage2PhaseHandler
; Camera with auto-scroll and phase transition
Camera_AutoScrollCheck:                               ; DATA XREF: ROM:0000C854   o  ; was: sub_C92E
                bsr.w Gfx_UpdateScroll
                bsr.w Gfx_CalculateScrollPosition
                cmpi.w  #$B40,(dword_FFA900).w
                bmi.s   locret_C942
                bra.w Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_C942:                            ; CODE XREF: Camera_AutoScrollCheck+E   j
                                        ; Camera_TransitionToBossArena+E   j
                rts
; End of function Camera_AutoScrollCheck
; Transitions camera to boss arena with position lock
Camera_TransitionToBossArena:                               ; DATA XREF: ROM:0000C856   o  ; was: sub_C944
                bsr.w Gfx_LoadBossTiles
                bsr.w Gfx_CalculateScrollPosition
                cmpi.w  #$BC0,(dword_FFA900).w
                bmi.s   locret_C942
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$BC0,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (stru_1137A).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Camera_TransitionToBossArena
; Initializes camera for Antroid boss fight
Camera_AntroidBossInit:                               ; DATA XREF: ROM:0000C858   o  ; was: sub_C978
                tst.w   (Entity_ObjectPool).w
                bne.s Camera_UpdateAntroidBoss
                clr.w   (dword_FFA90C).w
                bsr.w UI_InitScoreTimer
; Updates camera for Antroid boss with score timer initialization
Camera_UpdateAntroidBoss:                               ; CODE XREF: Camera_AntroidBossInit+4   j  ; was: loc_C986
                bsr.w Camera_UpdateTowardsPlayer
                bra.w Gfx_CalculateScrollPosition
; End of function Camera_AntroidBossInit
; Stage 3 camera with section transition
Camera_Stage3Transition:                               ; DATA XREF: ROM:0000C85A   o  ; was: sub_C98E
                bsr.w Stage_InitSectionChange
                bsr.w Camera_UpdateTowardsPlayer
                bra.w Gfx_CalculateScrollPosition
; End of function Camera_Stage3Transition
; Stage 3 camera with scroll update and position limit
Camera_Stage3ScrollLimit:                               ; DATA XREF: ROM:0000C85C   o  ; was: sub_C99A
                addq.w  #2,(word_FFA950).w
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #7,d7
loc_C9A4:                               ; CODE XREF: Camera_Stage3ScrollLimit+12   j
                move.w  #$10,(a0)
                lea     $60(a0),a0
                dbf     d7,loc_C9A4
; Updates scroll and camera transitions at position $FC0
Camera_Stage3_ScrollLimitCheck:                               ; DATA XREF: ROM:0000C85E   o  ; was: loc_C9B0
                bsr.w Gfx_UpdateScroll
                bsr.w Gfx_CalculateScrollPosition
                cmpi.w  #$FC0,(dword_FFA900).w
                bmi.w   locret_C9D2
                addq.w  #2,(word_FFA950).w
                move.w  #$FC0,(dword_FFA900).w
                move.w  #$190,(Entity_ObjectPool).w
locret_C9D2:                            ; CODE XREF: Camera_Stage3ScrollLimit+24   j
                rts
; End of function Camera_Stage3ScrollLimit
; Sets up camera for Stage 3 boss encounter
Camera_Stage3BossSetup:                               ; DATA XREF: ROM:0000C860   o  ; was: sub_C9D4
                tst.w   (Entity_ObjectPool).w
                bne.s   locret_C9DE
                addq.w  #2,(word_FFA950).w
locret_C9DE:                            ; CODE XREF: Camera_Stage3BossSetup+4   j
                rts
; End of function Camera_Stage3BossSetup
; Updates camera position during boss fight
Camera_UpdateBossPosition:                               ; DATA XREF: ROM:0000C862   o  ; was: sub_C9E0
                bsr.w Gfx_UpdateScroll
                bsr.w Gfx_CalculateScrollPosition
                cmpi.w  #$1168,(dword_FFA900).w
                bmi.w   locret_C9F6
                bra.w Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_C9F6:                            ; CODE XREF: Camera_UpdateBossPosition+E   j
                                        ; Camera_LockToBossArena+E   j
                rts
; End of function Camera_UpdateBossPosition
; Locks camera to boss arena boundaries
Camera_LockToBossArena:                               ; DATA XREF: ROM:0000C864   o  ; was: sub_C9F8
                bsr.w Gfx_LoadBossTiles
                bsr.w Gfx_CalculateScrollPosition
                cmpi.w  #$11E8,(dword_FFA900).w
                bmi.s   locret_C9F6
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$11E8,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (stru_1138E).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Camera_LockToBossArena
; Initializes camera for Shellshogun boss fight
Camera_ShellshogunBossInit:                               ; DATA XREF: ROM:0000C866   o  ; was: sub_CA2C
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_CA86
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.w  #$8000,(word_FF808A).w
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(word_FF80C2).w ; '.'
                clr.w   (dword_FFA90C).w
                lea     (stru_11820).l,a0
                jsr (Data_ProcessPointer).l
                move.w  #4,(word_FF8220).w
                lea     (word_B98C).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                move.l  #dword_CA8A,(dword_FFA940).w
                clr.w   (word_FFA946).w
                clr.w   (word_FFA948).w
                move.w  #$1F,(word_FFA944).w
loc_CA86:                               ; CODE XREF: Camera_ShellshogunBossInit+4   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Camera_ShellshogunBossInit
; ---------------------------------------------------------------------------
dword_CA8A:     dc.l $FFFF7000, $FFFF6800, $FFFF2000, $6000
                                        ; DATA XREF: Camera_ShellshogunBossInit+44   o


; Locks camera to fixed position
Camera_LockPosition:                               ; DATA XREF: ROM:0000C868   o  ; was: sub_CA9A
                tst.w   (word_FFF720).w
                bmi.s   loc_CAB0
                tst.w   (word_FFA944).w
                bmi.s   loc_CAAC
                bsr.w Gfx_RenderScrollingBackground
                bra.s   loc_CAB0
; ---------------------------------------------------------------------------
loc_CAAC:                               ; CODE XREF: Camera_LockPosition+A   j
                bsr.w Stage_InitSectionChange
loc_CAB0:                               ; CODE XREF: Camera_LockPosition+4   j
                                        ; Camera_LockPosition+10   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Camera_LockPosition
; Updates camera with smooth interpolation
Camera_UpdateSmooth:                               ; DATA XREF: ROM:0000C86A   o  ; was: sub_CAB4
                move.b  #$81,d0
                jsr (Sys_WaitVBlank).l
                addq.w  #2,(word_FFA950).w
                jsr (Stage_StateDispatcher).l
                bra.w   *+4
; ---------------------------------------------------------------------------
; Updates smooth scrolling camera transitions at $1A78
Camera_Smooth_ScrollLimitCheck:                               ; CODE XREF: Camera_UpdateSmooth+14   j  ; was: loc_CACC
                                        ; DATA XREF: ROM:0000C86C   o
                bsr.w Gfx_UpdateScroll
                bsr.w Gfx_CalculateScrollPosition
                cmpi.w  #$1A78,(dword_FFA900).w
                bmi.s   locret_CAE0
                bra.w Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_CAE0:                            ; CODE XREF: Camera_UpdateSmooth+26   j
                rts
; End of function Camera_UpdateSmooth
; Camera following target with offset
Camera_FollowTarget:                               ; DATA XREF: ROM:0000C86E   o  ; was: sub_CAE2
                bsr.w Gfx_LoadBossTiles
                bsr.w Gfx_CalculateScrollPosition
                cmpi.w  #$1AF8,(dword_FFA900).w
                bmi.s   locret_CB24
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$1AF8,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                move.b  #$10,(byte_FFA95A).w
                move.b  #4,(byte_FFA95B).w
                lea     (stru_113AA).l,a1
                jsr (Gfx_UpdateBossPalette).l
                bsr.s Camera_ClampToBounds
locret_CB24:                            ; CODE XREF: Camera_FollowTarget+E   j
                rts
; End of function Camera_FollowTarget
; Sets camera boundary limits
Camera_SetBounds:                               ; DATA XREF: ROM:0000C870   o  ; was: sub_CB26
                move.b  #3,(word_FFF7E6+1).w
                bsr.w Gfx_CalculateScrollPosition
                bra.s Camera_ClampToBounds
; End of function Camera_SetBounds
; Handles camera logic during stage transition checking boss state
Stage_CameraTransitionCheck:                               ; DATA XREF: ROM:0000C872   o  ; was: sub_CB32
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_CB44
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(word_FF80C2).w ; '.'
                bra.s Stage_ScrollWaitTransition
; ---------------------------------------------------------------------------
loc_CB44:                               ; CODE XREF: Stage_CameraTransitionCheck+4   j
                bsr.w Camera_UpdateTowardsPlayer
                bsr.w Gfx_CalculateScrollPosition
                bsr.s Camera_ClampToBounds
                move.w  #$C0,(dword_FFA908).w
                rts
; End of function Stage_CameraTransitionCheck
; Clamps camera position to boundaries
Camera_ClampToBounds:                               ; CODE XREF: Camera_FollowTarget+40   p  ; was: sub_CB56
                                        ; Camera_SetBounds+A   j ...
                movea.w #(byte_FF8800-M68K_RAM),a0
                move.w  (dword_FFA908).w,d0
                neg.w   d0
                moveq   #$7F,d7
loc_CB62:                               ; CODE XREF: Camera_ClampToBounds+E   j
                move.w  d0,(a0)+
                dbf     d7,loc_CB62
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                moveq   #$47,d7 ; 'G'
loc_CB70:                               ; CODE XREF: Camera_ClampToBounds+1C   j
                move.w  d0,(a0)+
                dbf     d7,loc_CB70
                rts
; End of function Camera_ClampToBounds
; Waits for scroll position then advances stage phase
Stage_ScrollWaitTransition:                               ; CODE XREF: Stage_CameraTransitionCheck+10   j  ; was: sub_CB78
                                        ; DATA XREF: ROM:0000C874   o
                bsr.s Camera_UpdateWithScroll
                tst.w   (word_FF80C2).w
                bne.s   locret_CB8A
                addq.w  #2,(word_FFA950).w
                move.w  #2,(word_FFA02A).w
locret_CB8A:                            ; CODE XREF: Stage_ScrollWaitTransition+6   j
                rts
; End of function Stage_ScrollWaitTransition
; Updates camera position and calculates scroll registers
Camera_UpdateWithScroll:                               ; CODE XREF: Stage_ScrollWaitTransition   p  ; was: sub_CB8C
                                        ; sub_CB9E   p
                bsr.w Camera_UpdateTowardsPlayer
                bsr.w Gfx_CalculateScrollPosition
                bsr.s Camera_ClampToBounds
                move.w  #$C0,(dword_FFA908).w
                rts
; End of function Camera_UpdateWithScroll
; Checks if stage transition is ready based on enemy and boss state
Stage_CheckTransitionReady:                               ; DATA XREF: ROM:0000C876   o  ; was: sub_CB9E
                bsr.s Camera_UpdateWithScroll
                tst.w   (word_FF8230).w
                bne.s   locret_CBB8
                tst.w   (word_FF8138).w
                bne.s   locret_CBB8
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; ---------------------------------------------------------------------------
locret_CBB8:                            ; CODE XREF: Stage_CheckTransitionReady+6   j
                                        ; Stage_CheckTransitionReady+C   j
                rts
; End of function Stage_CheckTransitionReady
; Updates automatic stage scrolling and checks for phase transition
Stage_AutoScrollUpdate:                               ; DATA XREF: ROM:0000C878   o  ; was: sub_CBBA
                addq.w  #2,(word_FFA950).w
; Updates automatic scrolling and checks for transition
Stage_AutoScroll_UpdateLoop:                               ; DATA XREF: ROM:0000C87A   o  ; was: loc_CBBE
                bsr.w Gfx_UpdateScroll
                cmpi.w  #$400,(dword_FFA900).w
                bmi.s   locret_CBCE
                bra.w Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_CBCE:                            ; CODE XREF: Stage_AutoScrollUpdate+E   j
                                        ; Boss_MadamBarbarScrollInit+A   j
                rts
; End of function Stage_AutoScrollUpdate
; Initializes Madam Barbar boss scroll position and palette
Boss_MadamBarbarScrollInit:                               ; DATA XREF: ROM:0000C87C   o  ; was: sub_CBD0
                bsr.w Gfx_LoadBossTiles
                cmpi.w  #$480,(dword_FFA900).w
                bmi.s   locret_CBCE
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$480,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                move.w  #$8000,(word_FF808A).w
                lea     (stru_113B4).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Boss_MadamBarbarScrollInit
; Initializes stage after boss defeat with score timer and camera
Stage_InitPostBoss:                               ; DATA XREF: ROM:0000C87E   o  ; was: sub_CC06
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_CC1C
                clr.w   (dword_FFA90C).w
                move.l  #word_1A9D4,(dword_FFA20E).w
                bsr.w UI_InitScoreTimer
loc_CC1C:                               ; CODE XREF: Stage_InitPostBoss+4   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_InitPostBoss
; Stage section transition waiting for VBlank and updating camera
Stage_TransitionWithVBlank:                               ; DATA XREF: ROM:0000C880   o  ; was: sub_CC20
                tst.w   (word_FF80C2).w
                bne.s   loc_CC30
                move.b  #$81,d0
                jsr (Sys_WaitVBlank).l
loc_CC30:                               ; CODE XREF: Stage_TransitionWithVBlank+4   j
                clr.w   (word_FF808A).w
                bsr.w Stage_InitSectionChange
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_TransitionWithVBlank
; Checks scroll position for stage phase transition trigger
Stage_CheckScrollTransition:                               ; DATA XREF: ROM:0000C882   o  ; was: sub_CC3C
                bsr.w Gfx_UpdateScroll
                cmpi.w  #$9E0,(dword_FFA900).w
                bmi.s   locret_CC4C
                bra.w Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_CC4C:                            ; CODE XREF: Stage_CheckScrollTransition+A   j
                                        ; Stage_InitJokerBoss+A   j
                rts
; End of function Stage_CheckScrollTransition
; Initializes Joker boss fight with scroll check and palette update
Stage_InitJokerBoss:                               ; DATA XREF: ROM:0000C884   o  ; was: sub_CC4E
                bsr.w Gfx_LoadBossTiles
                cmpi.w  #$A60,(dword_FFA900).w
                bmi.s   locret_CC4C
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA910).w
                move.w  #$A60,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                move.w  #$8000,(word_FF808A).w
                lea     (stru_113D0).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Stage_InitJokerBoss
; Post-boss initialization triggering stage phase transition
Stage_PostJokerBoss:                               ; DATA XREF: ROM:0000C886   o  ; was: sub_CC84
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_CC92
                clr.w   (dword_FFA90C).w
                bsr.w Stage_TriggerPhaseTransition
loc_CC92:                               ; CODE XREF: Stage_PostJokerBoss+4   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_PostJokerBoss
; Post-Joker transition clearing flags and updating camera
Stage_PostJokerTransition:                               ; DATA XREF: ROM:0000C888   o  ; was: sub_CC96
                clr.w   (word_FF808A).w
                bsr.w Stage_InitSectionChange
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_PostJokerTransition
; Initializes Stage 7 with scroll setup and palette loading
Stage_InitStage7:                               ; DATA XREF: ROM:0000C88A   o  ; was: sub_CCA2
                tst.w   (word_FFF720).w
                bmi.s Stage_Stage7ScrollUpdate
                bsr.w Stage_InitProjectileSpawn
                addq.w  #2,(word_FFA950).w
                lea     stru_CCBE(pc),a0
                nop
                jsr (Data_ProcessPointer).l
                bra.s Stage_Stage7ScrollUpdate
; End of function Stage_InitStage7
; ---------------------------------------------------------------------------
stru_CCBE:      dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_InitStage7+E   o
                dc.l tiles_19BE86       ; field_2
                dc.w $5BE0              ; field_6
                dc.w $FFFF


; Updates Stage 7 scroll checking transition boundaries
Stage_Stage7ScrollUpdate:                               ; CODE XREF: Stage_InitStage7+4   j  ; was: sub_CCC8
                                        ; Stage_InitStage7+1A   j
                                        ; DATA XREF: ...
                bsr.w Gfx_UpdateScroll
                move.w  (dword_FFA900).w,d0
                add.w   (dword_FFA410).w,d0
                cmpi.w  #$1098,(dword_FFA900).w
                bpl.s   loc_CCE2
                cmpi.w  #$1116,d0
                bmi.s   loc_CD00
loc_CCE2:                               ; CODE XREF: Stage_Stage7ScrollUpdate+12   j
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                move.w  #0,(word_FFA946).w
                move.w  #$C0,(dword_FF8062).w
                bra.w Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
locret_CCFE:                            ; CODE XREF: Stage_Stage7ScrollUpdate+3C   j
                                        ; Stage_InitTerobusterBoss+2A   j ...
                rts
; ---------------------------------------------------------------------------
loc_CD00:                               ; CODE XREF: Stage_Stage7ScrollUpdate+18   j
                cmpi.w  #$10B6,d0
                bmi.s   locret_CCFE
                bra.w Stage_SpawnIntroProjectile
; End of function Stage_Stage7ScrollUpdate
; Initializes Terobuster boss with scroll and graphics loading
Stage_InitTerobusterBoss:                               ; DATA XREF: ROM:0000C88E   o  ; was: sub_CD0A
                bsr.w Stage_SpawnIntroProjectile
                subq.w  #1,(dword_FF8062).w
                bsr.w Stage_UpdateScrollOffset
                bsr.w Stage_LoadTerobusterTiles
                jsr (Sprite_SetupDMA).l
                addi.l  #$C000,(dword_FFA900).w
                jsr (Gfx_GetCameraPosition).l
                cmpi.w  #$10A0,(dword_FFA900).w
                bmi.s   locret_CCFE
                clr.l   (dword_FFA910).w
                move.w  #$10A0,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                tst.w   (dword_FF8062).w
                bpl.s   locret_CCFE
                addq.w  #2,(word_FFA950).w
                move.w  #$8000,(word_FF808A).w
                lea     (stru_113EC).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Stage_InitTerobusterBoss
; Updates stage scroll offset with directional calculation
Stage_UpdateScrollOffset:                               ; CODE XREF: Stage_InitTerobusterBoss+8   p  ; was: sub_CD66
                move.w  (dword_FF8062).w,d0
                bmi.s   locret_CCFE
                bne.s   loc_CD72
                moveq   #0,d2
                bra.s   loc_CD7C
; ---------------------------------------------------------------------------
loc_CD72:                               ; CODE XREF: Stage_UpdateScrollOffset+6   j
                moveq   #2,d2
                asr.w   #1,d0
                andi.w  #$E,d0
                sub.w   d0,d2
loc_CD7C:                               ; CODE XREF: Stage_UpdateScrollOffset+A   j
                move.w  d2,d3
                lea     (word_3EC6).l,a2
                moveq   #0,d1
                asl.w   #4,d2
                asl.w   #8,d3
                jmp     (loc_3E5E).l
; End of function Stage_UpdateScrollOffset
; Post-intro transition clearing flags and advancing phase
Stage_PostTerobusterIntro:                               ; DATA XREF: ROM:0000C890   o  ; was: sub_CD90
                bsr.w Stage_SpawnIntroProjectile
                bsr.w Stage_LoadTerobusterTiles
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_CDB8
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(word_FF80C2).w ; '.'
                clr.w   (dword_FFA90C).w
loc_CDB8:                               ; CODE XREF: Stage_PostTerobusterIntro+C   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_PostTerobusterIntro
; Post-Terobuster transition clearing flags and advancing
Stage_PostTerobusterTransition:                               ; DATA XREF: ROM:0000C892   o  ; was: sub_CDBC
                tst.w   (word_FF80C2).w
                bne.s   loc_CDDE
                move.b  #1,(byte_FF830E).w
                move.w  #4,(word_FFA02A).w
                addq.w  #2,(word_FFA950).w
                lea     byte_D6A6(pc),a0
                nop
                jsr (Gfx_LoadCompressedTiles).l
loc_CDDE:                               ; CODE XREF: Stage_PostTerobusterTransition+4   j
                bra.w Camera_UpdateTowardsPlayer
; End of function Stage_PostTerobusterTransition
; Stage 7 to 8 transition with scroll boundary check
Stage_Stage7To8Transition:                               ; DATA XREF: ROM:0000C894   o  ; was: sub_CDE2
                bsr.w Gfx_UpdateScroll
                cmpi.w  #$1200,(dword_FFA900).w
                bmi.s   locret_CDF8
                addq.w  #2,(word_FFA950).w
                move.w  #$1200,(dword_FFA900).w
locret_CDF8:                            ; CODE XREF: Stage_Stage7To8Transition+A   j
                rts
; End of function Stage_Stage7To8Transition
; Checks player X position to trigger stage transition
Stage_CheckPlayerPosTrigger:                               ; DATA XREF: ROM:0000C896   o  ; was: sub_CDFA
                cmpi.w  #$140,(dword_FFA410).w
                bmi.s   locret_CE0C
                addq.w  #2,(word_FFA950).w
                move.w  #$40,(dword_FF8058).w ; '@'
locret_CE0C:                            ; CODE XREF: Stage_CheckPlayerPosTrigger+6   j
                rts
; End of function Stage_CheckPlayerPosTrigger
; Waits for timer then initiates stage transition
Stage_WaitAndTransition:                               ; DATA XREF: ROM:0000C898   o  ; was: sub_CE0E
                subq.w  #1,(dword_FF8058).w
                bmi.s   loc_CE16
locret_CE14:                            ; CODE XREF: Stage_WaitAndTransition+C   j
                rts
; ---------------------------------------------------------------------------
loc_CE16:                               ; CODE XREF: Stage_WaitAndTransition+4   j
                tst.w   (word_FF8230).w
                bne.s   locret_CE14
                move.b  #$89,(byte_FFA230).w
                move.l  #byte_1E587,(dword_FFA22C).w
                bra.w Stage_InitTransitionState
; End of function Stage_WaitAndTransition
; Writes boss parameter bytes to RAM structure
Stage_WriteBossParams:                               ; CODE XREF: Stage_InitStage8Train+38   p  ; was: sub_CE2E
                                        ; Stage_FlyingNeoBattleStart+1A   p
                lea     (M68K_RAM_PHYSICAL+(byte_FF615D-M68K_RAM)).l,a0
                move.b  (a1)+,(a0)
                move.b  (a1)+,1(a0)
                move.b  (a1)+,8(a0)
                move.b  (a1)+,9(a0)
                move.b  (a1)+,$10(a0)
                move.b  (a1)+,$11(a0)
                rts
; End of function Stage_WriteBossParams
; ---------------------------------------------------------------------------
byte_CE4C:      dc.b $19, $1A, $1E, $1F, $23, $24
                                        ; DATA XREF: Stage_InitStage8Train+34   o
byte_CE52:      dc.b $1C, $1D, $21, $22, $26, $27
                                        ; DATA XREF: Stage_FlyingNeoBattleStart+16   o


; Initializes Stage 8 train with scroll and graphics
Stage_InitStage8Train:                               ; DATA XREF: ROM:0000C89A   o  ; was: sub_CE58
                move.w  #1,(word_FF821E).w
                addq.w  #2,(word_FFA950).w
                move.w  #$730,(dword_FFA900).w
                move.w  #0,(dword_FFA904).w
                move.w  (dword_FFA900).w,(word_FFA928).w
                move.w  (dword_FFA904).w,(word_FFA92C).w
                move.b  #3,(word_FFF7E6+1).w
                move.b  #$30,(byte_FFA95A).w ; '0'
                move.b  #4,(byte_FFA95B).w
                lea     byte_CE4C(pc),a1
                bsr.s Stage_WriteBossParams
                bsr.w Stage_InitFlyingNeoEntity
                move.w  #$34,(word_FFA02A).w ; '4'
                move.w  #$45C,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
; Checks scroll position during train stage initialization
Stage_InitStage8Train_ScrollCheck:                               ; DATA XREF: ROM:0000C89C   o  ; was: loc_CEA6
                cmpi.w  #$EC0,(dword_FFA900).w
                bmi.s   loc_CEB8
                move.w  #$16,(word_FFA02A).w
                bsr.w Stage_TransitionToNextPhase
loc_CEB8:                               ; CODE XREF: Stage_InitStage8Train+54   j
                bsr.w Scroll_ApplyAcceleration
; End of function Stage_InitStage8Train
; Train scroll physics with velocity updates
Stage_TrainScrollPhysics:                               ; CODE XREF: Stage_TrainToFlyingNeoTransition+4   p  ; was: sub_CEBC
                                        ; Stage_FlyingNeoScrollUpdate+24   j
                move.l  #word_D84A,(dword_FF821A).w
                bsr.w Effect_SpawnRandomLightning
                bsr.w Stage_TrainParallaxCalc
                tst.w   (dword_FFA960).w
                bmi.s   locret_CEF8
                bne.s   loc_CEE4
                subi.l  #$1400,(dword_FFA904).w
                bpl.s   locret_CEF8
                addq.w  #1,(dword_FFA960).w
                bra.s   locret_CEF8
; ---------------------------------------------------------------------------
loc_CEE4:                               ; CODE XREF: Stage_TrainScrollPhysics+16   j
                addi.l  #$1400,(dword_FFA904).w
                cmpi.w  #$18,(dword_FFA904).w
                bmi.s   locret_CEF8
                clr.w   (dword_FFA960).w
locret_CEF8:                            ; CODE XREF: Stage_TrainScrollPhysics+14   j
                                        ; Stage_TrainScrollPhysics+20   j ...
                rts
; End of function Stage_TrainScrollPhysics
; Train background parallax calculation for depth effect
Stage_TrainParallaxCalc:                               ; CODE XREF: Stage_TrainScrollPhysics+C   p  ; was: sub_CEFA
                                        ; Stage_FlyingNeoVerticalScroll+2E   p ...
                movea.w #(byte_FF8800-M68K_RAM),a5
                subi.l  #$28000,(dword_FF8A00).w
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                addq.w  #8,d0
                subi.w  #$41,(word_FF8A04).w ; 'A'
                sub.w   d0,(word_FF8A08).w
                subi.w  #$10,(word_FF8A0C).w
                subi.w  #$13,(word_FF8A10).w
                move.w  #$C,d6
                move.w  (word_FFA000).w,d0
                asl.w   #2,d0
                movea.w #(word_FF8A04-M68K_RAM),a0
                and.w   d6,d0
                move.w  (a0,d0.w),d1
                addq.w  #4,d0
                and.w   d6,d0
                move.w  (a0,d0.w),d2
                addq.w  #4,d0
                and.w   d6,d0
                move.w  (a0,d0.w),d3
                addq.w  #4,d0
                and.w   d6,d0
                move.w  (a0,d0.w),d4
                addq.w  #4,d0
                movea.w #(byte_FF8800-M68K_RAM),a5
                move.w  #$2F,d7 ; '/'
; Fills VRAM buffer with parallax scroll data for train stage
Gfx_FillParallaxBuffer:                               ; CODE XREF: Stage_TrainParallaxCalc+6A   j  ; was: loc_CF5C
                move.w  d1,(a5)+
                move.w  d2,(a5)+
                move.w  d3,(a5)+
                move.w  d4,(a5)+
                dbf d7,Gfx_FillParallaxBuffer
                rts
; End of function Stage_TrainParallaxCalc
; Transitions from train to Flying-Neo boss battle
Stage_TrainToFlyingNeoTransition:                               ; DATA XREF: ROM:0000C89E   o  ; was: sub_CF6A
                bsr.w Scroll_IncrementHorizontalFast
                bsr.w Stage_TrainScrollPhysics
                cmpi.w  #$F00,(dword_FFA900).w
                bmi.s   locret_CF98
                addq.w  #2,(word_FFA950).w
                move.w  #$80,(dword_FFA960+2).w
                clr.l   (dword_FFA910).w
                move.w  #$F00,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
locret_CF98:                            ; CODE XREF: Stage_TrainToFlyingNeoTransition+E   j
                rts
; End of function Stage_TrainToFlyingNeoTransition
; Updates scroll positions for Flying-Neo battle
Stage_FlyingNeoScrollUpdate:                               ; DATA XREF: ROM:0000C8A0   o  ; was: sub_CF9A
                subq.w  #1,(dword_FFA960+2).w
                bpl.s Stage_SyncScrollPositions
                tst.w   (word_FF8138).w
                bne.s Stage_SyncScrollPositions
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA964).w
                bsr.w Stage_FlyingNeoSpawn
; Synchronizes scroll positions between camera and stage buffers
Stage_SyncScrollPositions:                               ; CODE XREF: Stage_FlyingNeoScrollUpdate+4   j  ; was: loc_CFB2
                                        ; Stage_FlyingNeoScrollUpdate+A   j
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                bra.w Stage_TrainScrollPhysics
; End of function Stage_FlyingNeoScrollUpdate
; Decelerates vertical scroll to zero
Stage_FlyingNeoScrollDecel:                               ; DATA XREF: ROM:0000C8A4   o  ; was: sub_CFC2
                subi.l  #$1000,(dword_FFA964).w
                bpl.s Stage_UpdateVerticalScroll
                addq.w  #2,(word_FFA950).w
                move.w  #1,(dword_FFA960).w
                move.w  #$40,(dword_FFA960+2).w ; '@'
                bra.s Stage_UpdateVerticalScroll
; End of function Stage_FlyingNeoScrollDecel
; Handles vertical scroll acceleration with boundaries
Stage_FlyingNeoVerticalScroll:                               ; DATA XREF: ROM:0000C8A2   o  ; was: sub_CFDE
                cmpi.w  #5,(dword_FFA964).w
                bpl.s   loc_CFEE
                addi.l  #$1000,(dword_FFA964).w
loc_CFEE:                               ; CODE XREF: Stage_FlyingNeoVerticalScroll+6   j
                cmpi.w  #$40,(dword_FFA904).w ; '@'
                bmi.s Stage_UpdateVerticalScroll
                addq.w  #2,(word_FFA950).w
                move.w  #$1A,(word_FFA02A).w
; Updates vertical scroll with parallax and lightning effects for Flying-Neo stage
Stage_UpdateVerticalScroll:                               ; CODE XREF: Stage_FlyingNeoScrollDecel+8   j  ; was: loc_D000
                                        ; Stage_FlyingNeoScrollDecel+1A   j ...
                move.l  (dword_FFA964).w,d0
                add.l   d0,(dword_FFA904).w
                bsr.w Scroll_UpdateCameraPositions
                bsr.w Stage_TrainParallaxCalc
                move.l  #word_D864,(dword_FF821A).w
                bsr.w Effect_SpawnRandomLightning
                rts
; End of function Stage_FlyingNeoVerticalScroll
; Starts Flying-Neo battle with palette and params
Stage_FlyingNeoBattleStart:                               ; DATA XREF: ROM:0000C8A6   o  ; was: sub_D01E
                subq.w  #1,(dword_FFA960+2).w
                bpl.s   loc_D040
                addq.w  #2,(word_FFA950).w
                lea     (stru_11408).l,a1
                jsr (Gfx_UpdateBossPalette).l
                lea     byte_CE52(pc),a1
                bsr.w Stage_WriteBossParams
                bsr.w Stage_FlyingNeoInitBoss
loc_D040:                               ; CODE XREF: Stage_FlyingNeoBattleStart+4   j
                                        ; Stage_FlyingNeoBattleUpdate+4   j
                move.l  #word_D864,(dword_FF821A).w
                bsr.w Effect_SpawnRandomLightning
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                bsr.w Stage_TrainParallaxCalc
                tst.w   (dword_FFA960).w
                bne.s Stage_IncrementVerticalPosition
                subi.l  #$4000,(dword_FFA904).w
                cmpi.w  #$60,(dword_FFA904).w ; '`'
                bpl.s   locret_D076
                addq.w  #1,(dword_FFA960).w
locret_D076:                            ; CODE XREF: Stage_FlyingNeoBattleStart+52   j
                                        ; Stage_FlyingNeoBattleStart+68   j
                rts
; ---------------------------------------------------------------------------
; Increments vertical scroll position until reaching threshold value
Stage_IncrementVerticalPosition:                               ; CODE XREF: Stage_FlyingNeoBattleStart+42   j  ; was: loc_D078
                addi.l  #$4000,(dword_FFA904).w
                cmpi.w  #$80,(dword_FFA904).w
                bmi.s   locret_D076
                clr.w   (dword_FFA960).w
                rts
; End of function Stage_FlyingNeoBattleStart
; Transitions to next stage after Flying-Neo defeat
Stage_PostFlyingNeoTransition:                               ; DATA XREF: ROM:0000C8AA   o  ; was: sub_D08E
                tst.w   (word_FF80C2).w
                bne.w Stage_FlyingNeoBattleUpdate
                tst.w   (word_FF8230).w
                bne.s Stage_FlyingNeoBattleUpdate
                move.l  #byte_1E6C6,(dword_FFA22C).w
                tst.w   (word_FF80C2).w
                beq.w Stage_InitTransitionState
; End of function Stage_PostFlyingNeoTransition
; Updates Flying-Neo battle with vertical oscillation
Stage_FlyingNeoBattleUpdate:                               ; CODE XREF: Stage_PostFlyingNeoTransition+4   j  ; was: sub_D0AC
                                        ; Stage_PostFlyingNeoTransition+C   j
                                        ; DATA XREF: ...
                bsr.w Camera_UpdateTowardsPlayer
                bra.w   loc_D040
; End of function Stage_FlyingNeoBattleUpdate
; Initializes Stage 9 with scroll and parameters
Stage_InitStage9Flies:                               ; DATA XREF: ROM:0000C8AC   o  ; was: sub_D0B4
                move.w  #0,(dword_FFA900).w
                move.w  #0,(dword_FFA904).w
                move.w  #0,(dword_FFA908).w
                move.w  #0,(dword_FFA90C).w
                move.w  (dword_FFA900).w,(word_FFA928).w
                move.w  (dword_FFA904).w,(word_FFA92C).w
                bsr.w Stage_FlyingNeoInitBoss
                move.w  #$2AC,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
                move.l  #$FFFEE000,(dword_FF8240).w
                addq.w  #2,(word_FFA950).w
                move.w  #1,(word_FF821E).w
                clr.w   (dword_FF8058).w
                clr.w   (dword_FFA960).w
                move.l  #$180000,(dword_FFA960+2).w
                clr.w   (word_FFA970).w
                move.w  #$A0,(word_FFA974).w
                move.b  #3,(word_FFF7E6+1).w
                move.b  #4,(byte_FFA95A).w
                move.b  #$30,(byte_FFA95B).w ; '0'
                move.w  #$2C,(word_FFF74A).w ; ','
                clr.w   (word_FFF74E).w
                move.w  #8,(word_FF8090).w
                clr.b   (byte_FF780C).l
                jmp     loc_12340
; End of function Stage_InitStage9Flies
; Checks transition condition to next stage segment
Stage_FliesCheckTransition:                               ; DATA XREF: ROM:0000C8AE   o  ; was: sub_D140
                cmpi.w  #$B0,(dword_FFA960+2).w
                bmi.s Stage_FliesScrollUpdate
                lea     stru_D1D0(pc),a0
                nop
                jsr (Data_ProcessPointer).l
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                clr.w   (word_FF8090).w
                bra.s Stage_InitCaterpillarShip
; End of function Stage_FliesCheckTransition
; Updates Stage 9 scroll with parallax and lightning
Stage_FliesScrollUpdate:                               ; CODE XREF: Stage_FliesCheckTransition+6   j  ; was: sub_D166
                move.l  #word_D8B2,(dword_FF821A).w
                bsr.w Effect_SpawnRandomLightning
                bsr.w Camera_UpdateTowardsPlayer
                bsr.w Gfx_CalculateScrollPosition
                bsr.w Stage_FliesVerticalScroll
                bsr.w Stage_TrainParallaxCalc
                cmpi.w  #$60,(dword_FFA960+2).w ; '`'
                bmi.s   loc_D18E
                bsr.w Stage_FliesSpawnEnemies
loc_D18E:                               ; CODE XREF: Stage_FliesScrollUpdate+22   j
                addi.l  #$4000,(dword_FFA960+2).w
                movea.w #(word_FF9C00-M68K_RAM),a0
                moveq   #$60,d0 ; '`'
                moveq   #$16,d7
loc_D19E:                               ; CODE XREF: Stage_FliesScrollUpdate+40   j
                neg.w   d0
                move.w  d0,(a0)+
                neg.w   d0
                addq.w  #8,d0
                dbf     d7,loc_D19E
                moveq   #3,d7
loc_D1AC:                               ; CODE XREF: Stage_FliesScrollUpdate+4A   j
                move.w  #0,(a0)+
                dbf     d7,loc_D1AC
                movea.w #(word_FF9C00-M68K_RAM),a0
                move.w  (dword_FFA960+2).w,d0
                move.w  d0,d1
                addi.w  #$50,d0 ; 'P'
loc_D1C2:                               ; CODE XREF: Stage_FliesScrollUpdate+68   j
                subq.w  #8,d1
                bpl.s   loc_D1C8
                rts
; ---------------------------------------------------------------------------
loc_D1C8:                               ; CODE XREF: Stage_FliesScrollUpdate+5E   j
                neg.w   d0
                move.w  d0,(a0)+
                neg.w   d0
                bra.s   loc_D1C2
; End of function Stage_FliesScrollUpdate
; ---------------------------------------------------------------------------
stru_D1D0:      dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_FliesCheckTransition+8   o
                dc.l tiles_10F840       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF


; Initializes caterpillar ship entity
Stage_InitCaterpillarShip:                               ; CODE XREF: Stage_FliesCheckTransition+24   j  ; was: sub_D1DA
                                        ; DATA XREF: ROM:0000C8B0   o
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  #$F900,(dword_FFA90C).w
                bra.w Stage_CaterpillarShipUpdate
; End of function Stage_InitCaterpillarShip
; Sets up caterpillar boss with lightning and camera
Stage_CaterpillarBossSetup:
                move.l  #word_D8B2,(dword_FF821A).w  ; was: sub_D1EA
                bsr.w Effect_SpawnRandomLightning
                bsr.w Camera_UpdateTowardsPlayer
                bra.w   loc_D4BA
; End of function Stage_CaterpillarBossSetup
; Spawns fly enemies with formation pattern
Stage_FliesSpawnEnemies:                               ; CODE XREF: Stage_FliesScrollUpdate+24   p  ; was: sub_D1FE
                cmpi.w  #$20,(dword_FF8058).w ; ' '
                bne.s   loc_D20C
                clr.l   (dword_FF8240).w
                rts
; ---------------------------------------------------------------------------
loc_D20C:                               ; CODE XREF: Stage_FliesSpawnEnemies+6   j
                movea.w #(word_FF9600-M68K_RAM),a0
                move.w  (dword_FF8058).w,d0
                moveq   #$16,d7
loc_D216:                               ; CODE XREF: Stage_FliesSpawnEnemies+22   j
                move.b  #0,(a0,d0.w)
                adda.w  #$20,a0 ; ' '
                dbf     d7,loc_D216
                movea.w (word_FFF70C).w,a4
                move.w  #$80,-(a4)
                move.w  #$7AC0,-(a4)
                move.w  #$9500,-(a4)
                move.w  #$96CB,-(a4)
                move.l  #$8F02977F,-(a4)
                move.l  #$94019310,-(a4)
                move.w  a4,(word_FFF70C).w
                addi.l  #$200,(dword_FF8240).w
                bmi.s   loc_D256
                clr.l   (dword_FF8240).w
loc_D256:                               ; CODE XREF: Stage_FliesSpawnEnemies+52   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_D264
                addq.w  #1,(dword_FF8058).w
locret_D264:                            ; CODE XREF: Stage_FliesSpawnEnemies+60   j
                rts
; End of function Stage_FliesSpawnEnemies
; ---------------------------------------------------------------------------
unused_2:	binclude	"data/other/unused_2.bin"


; Updates caterpillar ship scroll and position
Stage_CaterpillarShipUpdate:                               ; CODE XREF: Stage_InitCaterpillarShip+C   j  ; was: sub_D286
                                        ; DATA XREF: ROM:0000C8B2   o
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FF821E).w
                clr.l   (dword_FFA91C).w
                move.w  #$8000,(word_FF808A).w
                move.w  #$128,(Entity_ObjectPool).w
                move.w  #$C470,(word_FF8110).w
                clr.w   (word_FF8112).w
                move.b  #9,(byte_FFA95A).w
                move.b  #$24,(byte_FFA95B).w ; '$'
                bra.s   loc_D2BC
; End of function Stage_CaterpillarShipUpdate
; Handles caterpillar ship movement physics
Stage_CaterpillarShipMovement:                               ; DATA XREF: ROM:0000C8B4   o  ; was: sub_D2B6
                move.b  #6,(word_FFF7E6+1).w
loc_D2BC:                               ; CODE XREF: Stage_CaterpillarShipUpdate+2E   j
                tst.b   (word_FFF720).w
                bmi.s   loc_D2CE
                cmpi.w  #$20,(word_FF8112).w ; ' '
                bpl.s   loc_D2CE
                addq.w  #2,(word_FF8112).w
loc_D2CE:                               ; CODE XREF: Stage_CaterpillarShipMovement+A   j
                                        ; Stage_CaterpillarShipMovement+12   j
                move.l  (dword_FFA900).w,(dword_FF8040).w
                bsr.w Camera_UpdateTowardsPlayer
                move.l  (dword_FFA900).w,d7
                sub.l   (dword_FF8040).w,d7
                addi.l  #$12000,d7
                add.l   d7,(dword_FFA908).w
                move.w  (dword_FFA908).w,d0
                addi.w  #$158,d0
                tst.l   d7
                bpl.s   loc_D2FE
                move.w  (dword_FFA908).w,d0
                subi.w  #$58,d0 ; 'X'
loc_D2FE:                               ; CODE XREF: Stage_CaterpillarShipMovement+3E   j
                move.w  (dword_FFA90C).w,d1
                lea     word_D38C(pc),a0
                nop
                jsr     (loc_10704).l
                move.w  (dword_FFA908).w,(word_FF8048).w
                bsr.w Stage_CaterpillarScrollUpdate
                move.w  (word_FF8048).w,(dword_FFA908).w
                move.w  (dword_FFA908).w,d5
                add.w   (dword_FFA900).w,d5
                cmpi.w  #$9F0,d5
                bmi.s   loc_D332
                move.b  #1,(byte_FF830E).w
loc_D332:                               ; CODE XREF: Stage_CaterpillarShipMovement+74   j
                cmpi.w  #$A00,d5
                bmi.s   locret_D38A
                bsr.w Stage_TransitionToNextPhase
                move.b  #2,(word_FFF7E6+1).w
                move.b  #$10,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                clr.w   (dword_FFA90C).w
                moveq   #0,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                move.w  #0,(word_FFA946).w
                lea     stru_D39C(pc),a0
                nop
                jsr (Data_ProcessPointer).l
                move.w  #$460,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
                move.w  #$60,(dword_FF8128).w ; '`'
locret_D38A:                            ; CODE XREF: Stage_CaterpillarShipMovement+80   j
                rts
; End of function Stage_CaterpillarShipMovement
; ---------------------------------------------------------------------------
word_D38C:      dc.w $FFFF, $7000, $FFFF, $6800, $FFFF, $2000, 0, $6000
                                        ; DATA XREF: Stage_CaterpillarShipMovement+4C   o
stru_D39C:      dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_CaterpillarShipMovement+B8   o
                dc.l tiles_1163AE       ; field_2
                dc.w $8000              ; field_6
                dc.w $FFFF


; Caterpillar scroll handler
Stage_CaterpillarScrollHandler:                               ; DATA XREF: ROM:0000C8B6   o  ; was: sub_D3A6
                subq.w  #1,(word_FF8112).w
                jsr (Sprite_SetupDMA).l
                addi.l  #-$10000,(dword_FFA900).w
                bsr.w Stage_CaterpillarScrollUpdate
                tst.w   (dword_FFA900).w
                bpl.s   locret_D41E
                clr.w   (dword_FFA900).w
                clr.l   (dword_FFA910).w
                tst.w   (word_FF80C2).w
                bne.s   locret_D41E
                tst.w   (word_FFA944).w
                bpl.s   locret_D41E
                subq.w  #1,(dword_FF8128).w
                bpl.s   locret_D41E
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FFA970).w
                clr.w   (word_FFA974).w
                move.w  #$8002,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                tst.b   (byte_FFA209).w
                beq.s   loc_D412
                move.b  #$82,d0
                jsr (Sys_WaitVBlank).l
                bra.w   loc_D450
; ---------------------------------------------------------------------------
loc_D412:                               ; CODE XREF: Stage_CaterpillarScrollHandler+5C   j
                move.w  #0,(word_FFA29C).w
                move.w  #4,(word_FF8230).w
locret_D41E:                            ; CODE XREF: Stage_CaterpillarScrollHandler+1A   j
                                        ; Stage_CaterpillarScrollHandler+28   j ...
                rts
; End of function Stage_CaterpillarScrollHandler
; Empty handler called from Xi-Tiger boss wait
Stage_XiTigerEmptyHandler:                             ; CODE XREF: Stage_XiTigerBossWait+16   j  ; was: nullsub_23
                                        ; DATA XREF: ROM:0000C8B8   o
                rts
; End of function Stage_XiTigerEmptyHandler
; Initializes Xi-Tiger boss stage parameters
Stage_InitXiTigerBoss:                               ; DATA XREF: ROM:0000C8C0   o  ; was: sub_D422
                bsr.w Stage_SetBossTransitionPalette
                move.w  (word_FF8200).w,(word_FF8206).w
                move.w  (word_FFA216).w,(word_FF820A).w
                move.b  #$10,(byte_FFA95A).w
                move.b  #$40,(byte_FFF705).w ; '@'
                move.w  #$8000,(word_FF808A).w
                move.w  #$20,(word_FFA02A).w ; ' '
                move.w  #$40,(word_FF8644).w ; '@'
loc_D450:                               ; CODE XREF: Stage_CaterpillarScrollHandler+68   j
                move.w  #$70,(word_FFA950).w ; 'p'
                move.w  #$10,(dword_FF8062).w
                lea     (stru_11424).l,a1
                jmp Gfx_UpdateBossPalette
; End of function Stage_InitXiTigerBoss
; Waits for boss spawn with palette setup
Stage_XiTigerBossWait:                               ; DATA XREF: ROM:0000C8BA   o  ; was: sub_D468
                move.w  #$8004,(word_FF80F2).w
                move.w  #$10,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                subq.w  #1,(dword_FF8062).w
                bpl.w Stage_XiTigerEmptyHandler
                move.b  #$41,(byte_FFF705).w ; 'A'
                addq.w  #2,(word_FFA950).w
                move.b  #2,(word_FFF7E6+1).w
                move.b  #1,(byte_FFA95A).w
                move.b  #4,(byte_FFA95B).w
; Waits for entity to clear before boss transition
Stage_XiTigerBossWait_CheckEntity:                               ; DATA XREF: ROM:0000C8BC   o  ; was: loc_D49E
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_D4BA
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(word_FF80C2).w ; '.'
                move.b  #1,(byte_FF80FA).w
                move.w  #$1C0,(word_FF806E).w
loc_D4BA:                               ; CODE XREF: Stage_CaterpillarBossSetup+10   j
                                        ; Stage_XiTigerBossWait+3A   j ...
                bsr.w Camera_UpdateTowardsPlayer
; End of function Stage_XiTigerBossWait
; Updates caterpillar stage scroll with oscillation
Stage_CaterpillarScrollUpdate:                               ; CODE XREF: Stage_CaterpillarShipMovement+5E   p  ; was: sub_D4BE
                                        ; Stage_CaterpillarScrollHandler+12   p
                bsr.w Gfx_CalculateScrollPosition
                move.l  #word_D8B2,(dword_FF821A).w
                bsr.w Effect_SpawnRandomLightning
                tst.w   (dword_FFA960).w
                bmi.s   loc_D4FA
                bne.s   loc_D4E6
                subi.l  #$1000,(dword_FFA904).w
                bpl.s   loc_D4FA
                addq.w  #1,(dword_FFA960).w
                bra.s   loc_D4FA
; ---------------------------------------------------------------------------
loc_D4E6:                               ; CODE XREF: Stage_CaterpillarScrollUpdate+16   j
                addi.l  #$1000,(dword_FFA904).w
                cmpi.w  #$10,(dword_FFA904).w
                bmi.s   loc_D4FA
                clr.w   (dword_FFA960).w
loc_D4FA:                               ; CODE XREF: Stage_CaterpillarScrollUpdate+14   j
                                        ; Stage_CaterpillarScrollUpdate+20   j ...
                tst.w   (dword_FFA960).w
                bpl.s Stage_FliesVerticalScroll
                move.l  (dword_FFA91C).w,d0
                bpl.s   loc_D50E
                cmpi.l  #$FFFF8000,d0
                bmi.s   loc_D514
loc_D50E:                               ; CODE XREF: Stage_CaterpillarScrollUpdate+46   j
                subi.l  #$800,d0
loc_D514:                               ; CODE XREF: Stage_CaterpillarScrollUpdate+4E   j
                move.l  d0,(dword_FFA91C).w
                add.l   d0,(dword_FFA904).w
                bpl.s   loc_D52A
                clr.l   (dword_FFA91C).w
                clr.l   (dword_FFA904).w
                clr.w   (dword_FFA960).w
loc_D52A:                               ; CODE XREF: Stage_CaterpillarScrollUpdate+5E   j
                cmpi.w  #$18,(dword_FFA904).w
                bmi.s Stage_FliesVerticalScroll
                move.w  #$18,(dword_FFA904).w
; End of function Stage_CaterpillarScrollUpdate
; Updates vertical scroll positions for parallax
Stage_FliesVerticalScroll:                               ; CODE XREF: Stage_FliesScrollUpdate+14   p  ; was: sub_D538
                                        ; Stage_CaterpillarScrollUpdate+40   j ...
                movea.w #(word_FFE480-M68K_RAM),a0
                addi.l  #$8000,(dword_FFA918).w
                move.l  (dword_FFA908).w,d0
                add.l   (dword_FFA918).w,d0
                swap    d0
                neg.w   d0
                cmpi.b  #3,(word_FFF7E6+1).w
                beq.s   loc_D576
                moveq   #$20,d1 ; ' '
                moveq   #$12,d7
loc_D55C:                               ; CODE XREF: Stage_FliesVerticalScroll+28   j
                move.w  d0,(a0)
                adda.w  d1,a0
                dbf     d7,loc_D55C
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                moveq   #4,d7
loc_D56C:                               ; CODE XREF: Stage_FliesVerticalScroll+38   j
                move.w  d0,(a0)
                adda.w  d1,a0
                dbf     d7,loc_D56C
                rts
; ---------------------------------------------------------------------------
loc_D576:                               ; CODE XREF: Stage_FliesVerticalScroll+1E   j
                move.w  #$97,d7
loc_D57A:                               ; CODE XREF: Stage_FliesVerticalScroll+46   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_D57A
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                moveq   #$27,d7 ; '''
loc_D58A:                               ; CODE XREF: Stage_FliesVerticalScroll+56   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_D58A
                rts
; End of function Stage_FliesVerticalScroll
; Transitions to next stage after defeat
Stage_PostXiTigerTransition:                               ; DATA XREF: ROM:0000C8BE   o  ; was: sub_D594
                bsr.w   loc_D4BA
                subq.w  #1,(word_FF806E).w
                bpl.s   locret_D5BA
                tst.w   (word_FF8230).w
                bne.s   locret_D5BA
                move.b  #$86,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                tst.w   (word_FF80C2).w
                beq.w Stage_InitTransitionState
locret_D5BA:                            ; CODE XREF: Stage_PostXiTigerTransition+8   j
                                        ; Stage_PostXiTigerTransition+E   j
                rts
; End of function Stage_PostXiTigerTransition
; Initializes projectile spawn position for Terobuster intro
Stage_InitProjectileSpawn:                               ; CODE XREF: Stage_InitStage7+6   p  ; was: sub_D5BC
                move.w  #$CC,(dword_FF8062+2).w
                clr.w   (dword_FF8066).w
                rts
; End of function Stage_InitProjectileSpawn
; Spawns intro projectiles with timing and position
Stage_SpawnIntroProjectile:                               ; CODE XREF: Stage_Stage7ScrollUpdate+3E   j  ; was: sub_D5C8
                                        ; sub_CD0A   p ...
                btst    #0,(word_FFA000+1).w
                bne.s   locret_D622
                movea.w #(byte_FFD700-M68K_RAM),a0
                jsr     (loc_1C11C).l
                bne.s   locret_D622
                move.w  #$178,(a0)
                move.w  #$8100,2(a0)
                move.w  #$2240,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.w  #8,$48(a0)
                move.b  #$60,$20(a0) ; '`'
                clr.w   $10(a0)
                move.w  (dword_FF8062+2).w,$14(a0)
                addi.w  #$11,(dword_FF8062+2).w
                cmpi.w  #$13C,(dword_FF8062+2).w
                bmi.s   locret_D622
                move.w  #$CC,(dword_FF8062+2).w
locret_D622:                            ; CODE XREF: Stage_SpawnIntroProjectile+6   j
                                        ; Stage_SpawnIntroProjectile+12   j ...
                rts
; End of function Stage_SpawnIntroProjectile
; Intro falling projectile with screen position and flicker
Projectile_IntroFalling:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_D624
                subq.w  #1,$48(a5)
                bpl.s   loc_D632
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_D632:                               ; CODE XREF: Projectile_IntroFalling+4   j
                move.w  #$1114,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                bset    #7,2(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   locret_D652
                bclr    #7,2(a5)
locret_D652:                            ; CODE XREF: Projectile_IntroFalling+26   j
                rts
; End of function Projectile_IntroFalling
; Loads Terobuster boss tile graphics progressively
Stage_LoadTerobusterTiles:                               ; CODE XREF: Stage_InitTerobusterBoss+C   p  ; was: sub_D654
                                        ; Stage_PostTerobusterIntro+4   p
                move.w  (dword_FF8066).w,d0
                cmpi.w  #$14,d0
                bmi.s   loc_D67A
                lea     byte_D6C6(pc),a0
                nop
                btst    #3,(word_FFA000+1).w
                bne.s   loc_D672
                lea     byte_D6CE(pc),a0
                nop
loc_D672:                               ; CODE XREF: Stage_LoadTerobusterTiles+16   j
                jmp Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
locret_D678:                            ; CODE XREF: Stage_LoadTerobusterTiles+2E   j
                rts
; ---------------------------------------------------------------------------
loc_D67A:                               ; CODE XREF: Stage_LoadTerobusterTiles+8   j
                move.w  (word_FFA000).w,d1
                andi.w  #7,d1
                bne.s   locret_D678
                movea.l off_D692(pc,d0.w),a0
                addq.w  #4,(dword_FF8066).w
                jmp Gfx_LoadCompressedTiles
; End of function Stage_LoadTerobusterTiles
; ---------------------------------------------------------------------------
off_D692:       dc.l byte_D6A6
                dc.l byte_D6AE
                dc.l byte_D6B6
                dc.l byte_D6BE
                dc.l byte_D6C6
byte_D6A6:      dc.b $44, $B4, $40, 0, 1, 0, $F0, $F1
                                        ; DATA XREF: Stage_PostTerobusterTransition+16   o
                                        ; ROM:off_D692   o
byte_D6AE:      dc.b $44, $B4, $40, 0, 1, 0, $F2, $F3
                                        ; DATA XREF: ROM:0000D696   o
byte_D6B6:      dc.b $44, $B4, $40, 0, 1, 0, $F4, $F5
                                        ; DATA XREF: ROM:0000D69A   o
byte_D6BE:      dc.b $44, $B4, $40, 0, 1, 0, $F6, $F7
                                        ; DATA XREF: ROM:0000D69E   o
byte_D6C6:      dc.b $44, $B4, $40, 0, 1, 0, $F8, $F9
                                        ; DATA XREF: Stage_LoadTerobusterTiles+A   o
                                        ; ROM:0000D6A2   o
byte_D6CE:      dc.b $44, $B4, $40, 0, 1, 0, $FA, $FB
                                        ; DATA XREF: Stage_LoadTerobusterTiles+18   o


; Initializes Flying-Neo entity with sprite and position
Stage_InitFlyingNeoEntity:                               ; CODE XREF: Stage_InitStage8Train+3A   p  ; was: sub_D6D6
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  #$170,(a0)
                move.w  #$D00,2(a0)
                clr.w   4(a0)
                move.l  #off_19C720,8(a0)
                clr.w   $C(a0)
                move.w  #$81E8,$E(a0)
                clr.b   $20(a0)
                move.w  #$910,$10(a0)
                move.w  #$110,$14(a0)
                clr.l   $18(a0)
                clr.l   $1C(a0)
                rts
; End of function Stage_InitFlyingNeoEntity
; Spawns Flying-Neo boss with DMA tile transfer
