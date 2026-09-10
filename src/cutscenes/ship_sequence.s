Cutscene_ShipObjectDispatcher:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_86F0
                cmpi.w  #$16,(word_FF0132).l
                bcc.s   loc_86FC
                bsr.s   Cutscene_UpdateShipPaletteAlt
loc_86FC:                                               ; CODE XREF: Cutscene_ShipObjectDispatcher+8   j
                move.w  4(a5),d0
                lea     off_8708(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_ShipObjectDispatcher
; ---------------------------------------------------------------------------
off_8708:       dc.w    Cutscene_InitShipData-*         ; DATA XREF: Cutscene_ShipObjectDispatcher+10   o
                dc.w    Cutscene_ShipAnimationLoop-*

; Updates ship palette based on game state flag
Cutscene_UpdateShipPaletteAlt:                          ; CODE XREF: Cutscene_ShipObjectDispatcher+A   p  ; was: sub_870C
                movea.w #(word_FFE300-M68K_RAM),a0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_8760
                movea.w #(word_FFE380-M68K_RAM),a1
                move.w  $64(a1),$64(a0)
                move.w  $66(a1),$66(a0)
                move.w  $68(a1),$68(a0)
                move.w  $6A(a1),$6A(a0)
                move.w  $6C(a1),$6C(a0)
                move.w  $6E(a1),$6E(a0)
                move.w  $74(a1),$74(a0)
                move.w  $76(a1),$76(a0)
                move.w  $78(a1),$78(a0)
                move.w  $7A(a1),$7A(a0)
                move.w  $7C(a1),$7C(a0)
                rts
; ---------------------------------------------------------------------------
loc_8760:                                               ; CODE XREF: Cutscene_UpdateShipPaletteAlt+A   j
                moveq   #$20,d0                         ; ' '
                move.w  #$CEE,$64(a0)
                move.w  #$2E,$66(a0)                    ; '.'
                move.w  #$CE,$68(a0)
                move.w  #$482,$6A(a0)
                move.w  #$AE8,$6C(a0)
                move.w  #$EEC,$6E(a0)
                add.w   d0,$74(a0)
                add.w   d0,$76(a0)
                add.w   d0,$78(a0)
                add.w   d0,$7A(a0)
                add.w   d0,$7C(a0)
                rts
; End of function Cutscene_UpdateShipPaletteAlt
; Initializes ship cutscene data pointers and state
Cutscene_InitShipData:                                  ; DATA XREF: ROM:off_8708   o  ; was: sub_879C
                move.l  #word_900E,(dword_FF0128).l
                move.l  #word_917A,(dword_FF012C).l
                clr.w   (word_FF0130).l
                clr.w   (word_FF0132).l
                addq.w  #2,4(a5)
                rts
; End of function Cutscene_InitShipData
; Main ship animation loop with frame counter and completion check
Cutscene_ShipAnimationLoop:                             ; DATA XREF: ROM:0000870A   o  ; was: sub_87C2
                addq.w  #1,(word_FF0130).l
                bsr.w   Cutscene_SpawnShipSprite
                bsr.w   Cutscene_SpawnDebrisSprite
                bsr.w   Cutscene_ShipUpdateDispatcher
                cmpi.w  #$6C0,(word_FF0130).l
                bmi.s   locret_87EE
                bclr    #0,(byte_FFA958).w
                moveq   #0,d0
                moveq   #0,d1
                jmp     Object_ClearAllExceptTypes
; ---------------------------------------------------------------------------
locret_87EE:                                            ; CODE XREF: Cutscene_ShipAnimationLoop+1A   j
                rts
; End of function Cutscene_ShipAnimationLoop
; Dispatches ship update and rendering subsystems
Cutscene_ShipUpdateDispatcher:                          ; CODE XREF: Cutscene_ShipAnimationLoop+E   p  ; was: sub_87F0
                bsr.w   Cutscene_ShipStateDispatcher
                bra.w   Cutscene_ShipUpdateScroll
; End of function Cutscene_ShipUpdateDispatcher
; Jumps to current ship cutscene state handler
Cutscene_ShipStateDispatcher:                           ; CODE XREF: Cutscene_ShipUpdateDispatcher   p  ; was: sub_87F8
                move.w  (word_FF0132).l,d0
                lea     off_8806(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_ShipStateDispatcher
; ---------------------------------------------------------------------------
off_8806:       dc.w    Cutscene_ShipInitWait-*         ; DATA XREF: Cutscene_ShipStateDispatcher+6   o
                dc.w    Cutscene_LoadShipTiles1-*
                dc.w    Cutscene_LoadShipTiles2-*
                dc.w    Cutscene_LoadShipTiles3-*
                dc.w    Cutscene_LoadShipTiles4-*
                dc.w    Cutscene_LoadShipTiles5-*
                dc.w    Cutscene_ShipTilesComplete-*
                dc.w    Cutscene_ShipFadeInAlt-*
                dc.w    Cutscene_ShipZoomInAlt-*
                dc.w    Cutscene_WaitShipPosition-*
                dc.w    Cutscene_ShipExitPrepare-*
                dc.w    Cutscene_ShipInitScene-*
                dc.w    Cutscene_ShipInitScene_RenderLoop-*
                dc.w    Cutscene_ShipRenderLoop-*
                dc.w    Cutscene_ShipFadeTransition-*
                dc.w    nullsub_20-*

; Waits for frame threshold then initializes ship sprite
Cutscene_ShipInitWait:                                  ; DATA XREF: ROM:off_8806   o  ; was: sub_8826
                cmpi.w  #$40,(word_FF0130).l            ; '@'
                beq.s   Cutscene_ShowShipName
                cmpi.w  #$200,(word_FF0130).l
                bcs.w   locret_514E
                move.b  #1,(byte_FFA95A).w
                move.l  #$FFC00000,(dword_FF0134).l
                clr.l   (dword_FF0138).l
                addq.w  #2,(word_FF0132).l
                move.b  #$D5,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Cutscene_ShipInitWait
; Displays ship name text using UI rendering system
Cutscene_ShowShipName:                                  ; CODE XREF: Cutscene_ShipInitWait+8   j  ; was: sub_8864
                move.w  #0,d0
                jsr     (Cutscene_InitShipNameByDiff).l
                rts
; End of function Cutscene_ShowShipName
; Loads first batch of compressed ship tiles
Cutscene_LoadShipTiles1:                                ; DATA XREF: ROM:00008808   o  ; was: sub_8870
                movea.l #word_8DA4,a0
                jsr     (Gfx_LoadCompressedTiles).l
                move.w  #$20,(word_FF013C).l            ; ' '
                move.w  #$FFFF,(dword_FF0138).l
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_LoadShipTiles1
; Loads second batch of compressed ship tiles
Cutscene_LoadShipTiles2:                                ; DATA XREF: ROM:0000880A   o  ; was: sub_8894
                subq.w  #1,(word_FF013C).l
                bne.w   locret_514E
                movea.l #word_8DAC,a0
                jsr     (Gfx_LoadCompressedTiles).l
                move.w  #$20,(word_FF013C).l            ; ' '
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_LoadShipTiles2
; Loads third batch of compressed ship tiles
Cutscene_LoadShipTiles3:                                ; DATA XREF: ROM:0000880C   o  ; was: sub_88BA
                subq.w  #1,(word_FF013C).l
                bne.w   locret_514E
                movea.l #word_8DB4,a0
                jsr     (Gfx_LoadCompressedTiles).l
                move.w  #$20,(word_FF013C).l            ; ' '
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_LoadShipTiles3
; Loads fourth batch of compressed ship tiles
Cutscene_LoadShipTiles4:                                ; DATA XREF: ROM:0000880E   o  ; was: sub_88E0
                subq.w  #1,(word_FF013C).l
                bne.w   locret_514E
                movea.l #word_8DBC,a0
                jsr     (Gfx_LoadCompressedTiles).l
                move.w  #$20,(word_FF013C).l            ; ' '
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_LoadShipTiles4
; Loads fifth batch of compressed ship tiles
Cutscene_LoadShipTiles5:                                ; DATA XREF: ROM:00008810   o  ; was: sub_8906
                subq.w  #1,(word_FF013C).l
                bne.w   locret_514E
                movea.l #word_8DC4,a0
                jsr     (Gfx_LoadCompressedTiles).l
                move.w  #$20,(word_FF013C).l            ; ' '
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_LoadShipTiles5
; Advances to next state after all ship tiles loaded
Cutscene_ShipTilesComplete:                             ; DATA XREF: ROM:00008812   o  ; was: sub_892C
                subq.w  #1,(word_FF013C).l
                bne.w   locret_514E
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipTilesComplete
; Gradually fades in ship sprite by incrementing alpha
Cutscene_ShipFadeInAlt:                                 ; DATA XREF: ROM:00008814   o  ; was: sub_893E
                addi.l  #$10000,(dword_FF0138).l
                tst.w   (dword_FF0138).l
                bmi.w   locret_514E
                bsr.w   Gfx_EnablePriorityPlane
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipFadeInAlt
; Zooms in ship sprite by incrementing scale factor
Cutscene_ShipZoomInAlt:                                 ; DATA XREF: ROM:00008816   o  ; was: sub_895E
                addi.l  #$2000,(dword_FF0138).l
                cmpi.l  #$8000,(dword_FF0138).l
                bcs.w   locret_514E
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipZoomInAlt
; Waits for ship to reach position before advancing state
Cutscene_WaitShipPosition:                              ; DATA XREF: ROM:00008818   o  ; was: sub_897E
                cmpi.w  #$FF20,(dword_FF0134).l
                bcs.w   locret_514E
                move.w  #0,d0
                jsr     (Cutscene_InitShipNameByDiff).l
                clr.w   (word_FF016A).l
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_WaitShipPosition
; Prepares ship exit animation by toggling sprite flag
Cutscene_ShipExitPrepare:                               ; DATA XREF: ROM:0000881A   o  ; was: sub_89A2
                bsr.w   Cutscene_ShipFlashDispatcher
                eori.w  #$8000,(word_FFC6EE).w
                cmpi.w  #$588,(word_FF0130).l
                bcs.w   locret_514E
                bsr.w   Gfx_DisablePriorityPlane
                lea     (word_FFC6E2).w,a0
                move.w  #$2D,d0                         ; '-'
loc_89C4:                                               ; CODE XREF: Cutscene_ShipExitPrepare+2A   j
                move.w  #$1000,(a0)
                adda.w  #$60,a0                         ; '`'
                dbf     d0,loc_89C4
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipExitPrepare
; Dispatches to ship flash animation state handlers
Cutscene_ShipFlashDispatcher:                           ; CODE XREF: Cutscene_ShipExitPrepare   p  ; was: sub_89D8
                move.w  (word_FF016A).l,d0
                lea     off_89E6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_ShipFlashDispatcher
; ---------------------------------------------------------------------------
off_89E6:       dc.w    Cutscene_InitShipFlash-*        ; DATA XREF: Cutscene_ShipFlashDispatcher+6   o
                dc.w    Cutscene_ShipFlashLoop-*
                dc.w    Cutscene_RestartShipFlash-*

; Initializes ship flash effect with sound and timer
Cutscene_InitShipFlash:                                 ; CODE XREF: Cutscene_RestartShipFlash+A   j  ; was: sub_89EC
                                        ; DATA XREF: ROM:off_89E6   o
                move.l  #$4000,(dword_FF0138).l
                move.w  #$40,(word_FF016C).l            ; '@'
                move.w  #2,(word_FF016A).l
                move.b  #$D8,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Cutscene_InitShipFlash
; Animates ship flash by toggling palette colors
Cutscene_ShipFlashLoop:                                 ; DATA XREF: ROM:000089E8   o  ; was: sub_8A12
                bsr.w   Cutscene_UpdateShipColor
                eori.w  #2,(word_FFE400).w
                subq.w  #1,(word_FF016C).l
                bne.w   locret_514E
                move.l  #$FFFFC000,(dword_FF0138).l
                move.w  #$60,(word_FF016C).l            ; '`'
                addq.w  #2,(word_FF016A).l
                rts
; End of function Cutscene_ShipFlashLoop
; Updates ship color palette index periodically
Cutscene_UpdateShipColor:                               ; CODE XREF: Cutscene_ShipFlashLoop   p  ; was: sub_8A40
                move.w  (word_FF016C).l,d0
                andi.w  #$1F,d0
                bne.w   locret_514E
                addi.w  #4,(dword_FF0134).l
                rts
; End of function Cutscene_UpdateShipColor
; Restarts ship flash animation after delay
Cutscene_RestartShipFlash:                              ; DATA XREF: ROM:000089EA   o  ; was: sub_8A58
                subq.w  #1,(word_FF016C).l
                bne.w   locret_514E
                bra.w   Cutscene_InitShipFlash
; End of function Cutscene_RestartShipFlash
; Dispatches to ship visual effect handlers
Cutscene_ShipEffectDispatcher:
                move.w  (word_FF016E).l,d0              ; was: sub_8A66
                lea     off_8A74(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_ShipEffectDispatcher
; ---------------------------------------------------------------------------
off_8A74:       dc.w    Cutscene_InitShipEffect-*       ; DATA XREF: Cutscene_ShipEffectDispatcher+6   o
                dc.w    Cutscene_ShipTimerCheck-*
                dc.w    Cutscene_ShipFlickerControl-*

; Initializes ship visual effect and advances state
Cutscene_InitShipEffect:                                ; DATA XREF: ROM:off_8A74   o  ; was: sub_8A7A
                move.w  #1,(word_FF0170).l
                addq.w  #2,(word_FF016E).l
                rts
; End of function Cutscene_InitShipEffect
; Decrements timer and advances cutscene state when timer expires
Cutscene_ShipTimerCheck:                                ; DATA XREF: ROM:00008A76   o  ; was: sub_8A8A
                subq.w  #1,(word_FF0170).l
                bne.w   locret_514E
                move.w  #$20,(word_FF0170).l            ; ' '
                addq.w  #2,(word_FF016E).l
                rts
; End of function Cutscene_ShipTimerCheck
; Toggles flicker effect and adjusts ship vertical position
Cutscene_ShipFlickerControl:                            ; DATA XREF: ROM:00008A78   o  ; was: sub_8AA4
                eori.w  #2,(dword_FFA900).w
                tst.w   (dword_FFA900).w
                bne.s   Cutscene_ShipMoveUp
                subi.w  #1,(dword_FF0134).l
                bra.s   loc_8AC2
; End of function Cutscene_ShipFlickerControl
; Increments ship position and manages timer for upward movement
Cutscene_ShipMoveUp:                                    ; CODE XREF: Cutscene_ShipFlickerControl+A   j  ; was: sub_8ABA
                addi.w  #1,(dword_FF0134).l
loc_8AC2:                                               ; CODE XREF: Cutscene_ShipFlickerControl+14   j
                subq.w  #1,(word_FF0170).l
                bne.w   locret_514E
                move.w  #$88,(word_FF0170).l
                subq.w  #2,(word_FF016E).l
                rts
; End of function Cutscene_ShipMoveUp
; Initializes Sega screen ship scene with sprites and effects
Cutscene_ShipInitScene:                                 ; DATA XREF: ROM:0000881C   o  ; was: sub_8ADC
                move.w  #$A400,d0
                move.w  #$6022,d4
                movea.l #word_8EFE,a0
                move.w  #$11,d7
loc_8AEE:                                               ; CODE XREF: Cutscene_ShipInitScene+1C   j
                jsr     Gfx_BuildDMATransfer(pc)        ; (pc)
                nop
                addi.w  #$80,d4
                dbf     d7,loc_8AEE
                lea     (word_FF0140).l,a0
                move.w  #$11,d1
loc_8B06:                                               ; CODE XREF: Cutscene_ShipInitScene+2C   j
                clr.w   (a0)+
                dbf     d1,loc_8B06
                clr.w   (word_FF0164).l
                move.b  #$30,d0                         ; '0'
                jsr     (Input_ProcessButtons).l
                move.l  #$8000,(dword_FF0138).l
                move.w  #$8000,(word_FF808A).w
                bsr.w   Gfx_ClearPlaneBuffer
                addq.w  #2,(word_FF0132).l
; Renders SEGA logo animation and loads ship tiles
Cutscene_ShipInitScene_RenderLoop:                      ; DATA XREF: ROM:0000881E   o  ; was: loc_8B36
                bset    #0,(byte_FFA958).w
                bsr.w   Gfx_SetupSegaPalette
                bsr.w   Gfx_RenderAnimatedText
                bsr.w   Gfx_WriteVDPCommands
                bsr.w   Effect_SpawnStarParticle
                cmpi.w  #$668,(word_FF0130).l
                bcs.w   locret_514E
                movea.l #word_8DE4,a0
                jsr     (Gfx_LoadCompressedTiles).l
                clr.w   (word_FF808A).w
                move.l  #Gfx_ScrollVRAMTransferParameters,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                move.w  #0,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                bclr    #0,(byte_FFA958).w
                move.w  #$10,(dword_FF0134).l
                clr.l   (dword_FF0138).l
                bsr.w   Cutscene_ShipUpdateScroll
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipInitScene
; Renders scrolling background multiple times per frame
Cutscene_ShipRenderLoop:                                ; DATA XREF: ROM:00008820   o  ; was: sub_8BA2
                bsr.w   Gfx_SetupSegaPalette
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   locret_514E
                move.w  #$FFF2,(word_FF0166).l
                move.w  #$E,(word_FF0168).l
                addq.w  #2,(word_FF0132).l
                rts
; End of function Cutscene_ShipRenderLoop
; Applies palette fade transition effects to ship scene
Cutscene_ShipFadeTransition:                            ; DATA XREF: ROM:00008822   o  ; was: sub_8BDE
                lea     (word_FFE300).w,a0
                move.w  (word_FF0166).l,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                lea     (word_FFE320).w,a0
                move.w  (word_FF0168).l,d0
                move.w  #$F,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
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
nullsub_20:                                             ; DATA XREF: ROM:00008824   o
                rts
; End of function nullsub_20

; Spawns star particles with random trajectory calculations
Effect_SpawnStarParticle:                               ; CODE XREF: Cutscene_ShipInitScene+6C   p  ; was: sub_8C42
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_514E
                lea     (Effect_StarParticleSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                jsr     (RandomNumber).l
                move.w  d0,d2
                andi.w  #$3F,d2                         ; '?'
                jsr     (RandomNumber).l
                andi.w  #$FE,d0
                addi.w  #$100,d0
                movem.l a0,-(sp)
                bsr.w   Math_LookupSineCosinePair
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
Gfx_SetupSegaPalette:                                   ; CODE XREF: Cutscene_ShipInitScene+60   p  ; was: sub_8CC0
                                        ; sub_8BA2   p
                lea     (word_FFE300).w,a0
                move.w  #$FFF2,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                lea     (word_FFE320).w,a0
                move.w  #$E,d0
                move.w  #$F,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  #$222,(word_FFE376).w
                move.w  #$444,(word_FFE378).w
                move.w  #$666,(word_FFE37A).w
                move.w  #$888,(word_FFE37C).w
                move.w  #$AAA,(word_FFE37E).w
                rts
; End of function Gfx_SetupSegaPalette
; Updates horizontal scrolling values for ship parallax effect
Cutscene_ShipUpdateScroll:                              ; CODE XREF: Cutscene_ShipUpdateDispatcher+4   j  ; was: sub_8D0C
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
loc_8D3A:                                               ; CODE XREF: Cutscene_ShipUpdateScroll+32   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_8D3A
                cmpi.w  #$18,(word_FF0132).l
                bcs.w   locret_514E
                lea     (word_FFEC22).w,a0
                move.w  #4,d7
loc_8D56:                                               ; CODE XREF: Cutscene_ShipUpdateScroll+4E   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_8D56
                rts
; End of function Cutscene_ShipUpdateScroll
; Sets priority bit on plane tiles and loads compressed graphics
Gfx_EnablePriorityPlane:                                ; CODE XREF: Cutscene_ShipFadeInAlt+14   p  ; was: sub_8D60
                lea     (word_FF2020).l,a0
                move.w  #$15F,d1
loc_8D6A:                                               ; CODE XREF: Gfx_EnablePriorityPlane+12   j
                move.w  (a0),d0
                ori.w   #$8000,d0
                move.w  d0,(a0)+
                dbf     d1,loc_8D6A
                movea.l #word_8DCE,a0
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_EnablePriorityPlane
; Clears priority bit on plane tiles and loads compressed graphics
Gfx_DisablePriorityPlane:                               ; CODE XREF: Cutscene_ShipExitPrepare+16   p  ; was: sub_8D82
                lea     (word_FF2020).l,a0
                move.w  #$15F,d1
loc_8D8C:                                               ; CODE XREF: Gfx_DisablePriorityPlane+12   j
                move.w  (a0),d0
                andi.w  #$7FFF,d0
                move.w  d0,(a0)+
                dbf     d1,loc_8D8C
                movea.l #word_8DCE,a0
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_DisablePriorityPlane
; ---------------------------------------------------------------------------
word_8DA4:      dc.w    $4020, $2000, $100, $102
                                        ; DATA XREF: Cutscene_LoadShipTiles1   o
word_8DAC:      dc.w    $4220, $2000, $100, $304
                                        ; DATA XREF: Cutscene_LoadShipTiles2+A   o
word_8DB4:      dc.w    $4420, $2000, $100, $506
                                        ; DATA XREF: Cutscene_LoadShipTiles3+A   o
word_8DBC:      dc.w    $4620, $2000, $100, $708
                                        ; DATA XREF: Cutscene_LoadShipTiles4+A   o
word_8DC4:      dc.w    $4820, $2000, $200, $90A, $BFF
                                        ; DATA XREF: Cutscene_LoadShipTiles5+A   o
word_8DCE:      dc.w    $4020, $2000, $204, $102, 3, $400, $506, 7, $800, $90A, $BFF
                                        ; DATA XREF: Gfx_EnablePriorityPlane+16   o
                                        ; Gfx_DisablePriorityPlane+16   o
word_8DE4:      dc.w    $4020, $2000, $204, 0, 0, 0, 0, 0, 0, 0, $FF
                                        ; DATA XREF: Cutscene_ShipInitScene+7C   o

; Renders animated text reveal effect character by character
Gfx_RenderAnimatedText:                                 ; CODE XREF: Cutscene_ShipInitScene+64   p  ; was: sub_8DFA
                move.w  (word_FF0164).l,d1
                addq.w  #1,(word_FF0164).l
                lsr.w   #3,d1
                cmpi.w  #$11,d1
                bcs.s   loc_8E12
                move.w  #$11,d1
loc_8E12:                                               ; CODE XREF: Gfx_RenderAnimatedText+12   j
                lea     (word_FF0140).l,a0
                lea     (word_FF1000).l,a2
loc_8E1E:                                               ; CODE XREF: Gfx_RenderAnimatedText+36   j
                movem.l a2,-(sp)
                bsr.w   Gfx_UpdateTextPixel
                movem.l (sp)+,a2
                addq.w  #2,a0
                adda.w  #$20,a2                         ; ' '
                dbf     d1,loc_8E1E
                rts
; End of function Gfx_RenderAnimatedText
; Updates individual pixel/tile data for text animation
Gfx_UpdateTextPixel:                                    ; CODE XREF: Gfx_RenderAnimatedText+28   p  ; was: sub_8E36
                move.w  (a0),d0
                cmpi.w  #$40,d0                         ; '@'
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
                andi.b  #$3C,d3                         ; '<'
                lsr.b   #1,d3
                adda.l  d3,a2
                move.w  (a2),d4
                or.w    d2,d4
                move.w  d4,(a2)
                rts
; End of function Gfx_UpdateTextPixel
; ---------------------------------------------------------------------------
word_8E6C:      dc.w    $F000, $F00, $F0, $F

; Clears plane buffer memory with zeros
Gfx_ClearPlaneBuffer:                                   ; CODE XREF: Cutscene_ShipInitScene+50   p  ; was: sub_8E74
                lea     (word_FF1000).l,a1
                moveq   #0,d0
                move.w  #$8F,d1
loc_8E80:                                               ; CODE XREF: Gfx_ClearPlaneBuffer+E   j
                move.l  d0,(a1)+
                dbf     d1,loc_8E80
; End of function Gfx_ClearPlaneBuffer
; Writes VDP command sequence to command buffer
Gfx_WriteVDPCommands:                                   ; CODE XREF: Cutscene_ShipInitScene+68   p  ; was: sub_8E86
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
Gfx_BuildDMATransfer:                                   ; CODE XREF: Cutscene_ShipInitScene:loc_8AEE   p  ; was: sub_8EAC
                movea.w (word_FFF70E).w,a1
                moveq   #0,d3
loc_8EB2:                                               ; CODE XREF: Gfx_BuildDMATransfer+12   j
                move.b  (a0)+,d0
                cmpi.b  #$FF,d0
                beq.s   loc_8EC0
                move.w  d0,(a1)+
                addq.w  #1,d3
                bra.s   loc_8EB2
; ---------------------------------------------------------------------------
loc_8EC0:                                               ; CODE XREF: Gfx_BuildDMATransfer+C   j
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
word_8EFE:      dc.w    $6C6C, $6C6C, $6C6C, $6CFF
                                        ; DATA XREF: Cutscene_ShipInitScene+8   o
                dc.w    $6D6D, $6D6D, $6D6D, $6DFF
                dc.w    $6E6E, $6E6E, $6E6E, $6EFF
                dc.w    $6F6F, $6F6F, $6F6F, $6FFF
                dc.w    $7070, $7070, $7070, $70FF
                dc.w    $7171, $7171, $7171, $71FF
                dc.w    $7272, $7272, $7272, $72FF
                dc.w    $7373, $7373, $7373, $73FF
                dc.w    $7474, $7474, $7474, $74FF
                dc.w    $7575, $7575, $7575, $75FF
                dc.w    $7676, $7676, $7676, $76FF
                dc.w    $7777, $7777, $7777, $77FF
                dc.w    $7878, $7878, $7878, $78FF
                dc.w    $7979, $7979, $7979, $79FF
                dc.w    $7A7A, $7A7A, $7A7A, $7AFF
                dc.w    $7B7B, $7B7B, $7B7B, $7BFF
                dc.w    $7C7C, $7C7C, $7C7C, $7C7C
                dc.w    $FF7D, $7D7D, $7D7D, $7D7D
                dc.w    $7DFF

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
                move.b  #$78,$20(a4)                    ; 'x'
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
off_8FEE:       dc.l    word_1A9B9E
                dc.l    word_1A9BA4
                dc.l    word_1A9BAA
                dc.l    word_1A9BC2
word_8FFE:      dc.w    $FFFF, $E800, $FFFF, $E000, $FFFF, $D000, $FFFF, $D800
word_900E:      dc.w    1, $11A0, 0, $100, $148, $490, 0, $28
                                        ; DATA XREF: Cutscene_InitShipData   o
                dc.w    $1140, 0, $F8, $148, $490, $FE00, $29, $10E0
                dc.w    0, $108, $148, $4D0, $200, $68, $1080, 0
                dc.w    $F0, $148, $490, $FC80, $B0, $1020, 0, $E8
                dc.w    $148, $410, $FB80, $140, $BA0, 4, $148, $150
                dc.w    $3A0, $FE00, $158, $B40, 4, $150, $150, $3B0
                dc.w    0, $170, $AE0, 4, $158, $150, $380, $200
                dc.w    $190, $A80, 4, $160, $150, $350, $400, $1A0
                dc.w    $5A0, 8, $100, $158, $378, 0, $1B0, $540
                dc.w    $C, $160, $158, $378, 0, 0

; Spawns debris sprite with velocity and plays sound effect
Cutscene_SpawnDebrisSprite:                             ; CODE XREF: Cutscene_ShipAnimationLoop+A   p  ; was: sub_90AA
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
                move.b  #$70,$20(a4)                    ; 'p'
                move.w  #$50,$14(a4)                    ; 'P'
                move.w  (a0)+,d0
                move.l  off_911A(pc,d0.w),8(a4)
                move.l  dword_913A(pc,d0.w),$18(a4)
                move.l  word_915A(pc,d0.w),$1C(a4)
                move.w  (a0)+,$10(a4)
                tst.l   $18(a4)
                bpl.s   loc_9108
                ori.w   #$800,$E(a4)
loc_9108:                                               ; CODE XREF: Cutscene_SpawnDebrisSprite+56   j
                move.l  a0,(dword_FF012C).l
                move.b  #$59,d0                         ; 'Y'
                jsr     (Sound_PlaySFX).l
                rts
; End of function Cutscene_SpawnDebrisSprite
; ---------------------------------------------------------------------------
off_911A:       dc.l    word_1A9BC8
                dc.l    word_1A9BE6
                dc.l    word_1A9BE6
                dc.l    word_1A9C04
                dc.l    word_1A9C2E
                dc.l    word_1A9C2E
                dc.l    word_1A9C58
                dc.l    word_1A9C82
dword_913A:     dc.l    0, $FFFF8000, $8000
                dc.l    0, $FFFE0000, $20000
                dc.l    0, 0
word_915A:      dc.w    4, 0, 4, 0, 4, 0, $10, 0
                dc.w    $10, 0, $10, 0, $20, 0, $20, 0
word_917A:      dc.w    $480, $FC0, 0, $120, $488, $F60, 4, $110
                                        ; DATA XREF: Cutscene_InitShipData+A   o
                dc.w    $490, $F00, 8, $D0, $498, $EA0, 0, $F0
                dc.w    $4A0, $E40, 8, $150, $4A8, $DE0, 4, $E0
                dc.w    $4B0, $D80, 0, $170, $4B8, $D20, 8, $130
                dc.w    $4C0, $CC0, 0, $160, $4C8, $C60, 4, $100
                dc.w    $4D0, $C00, 8, $140, $4D8, $A20, $14, $130
                dc.w    $4DE, $9C0, $10, $170, $4E4, $960, $14, $150
                dc.w    $4EA, $900, $C, $100, $4F0, $8A0, $10, $F0
                dc.w    $4F6, $840, $10, $140, $4FC, $7E0, $C, $110
                dc.w    $502, $780, $14, $D0, $508, $720, $C, $160
                dc.w    $50E, $6C0, $14, $100, $514, $660, $10, $E0
                dc.w    $51A, $600, $14, $120, $520, $360, $18, $100
                dc.w    $528, $300, $18, $160, $530, $2A0, $18, $D0
                dc.w    $538, $240, $18, $178, $53C, $1E0, $18, $110
                dc.w    $540, $180, $18, $148, $544, $120, $18, $F0
                dc.w    $548, $C0, $1C, $128, 0

; Updates ship debris sprite countdown and transitions state
Sprite_ShipDebrisUpdate:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_9274
                subq.w  #1,$40(a5)
                beq.s   loc_928C
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcc.w   locret_514E
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_928C:                                               ; CODE XREF: Sprite_ShipDebrisUpdate+4   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #SharedCombatSpriteAnimation00,8(a5)
                jsr     (Projectile_InitType88FromCurrent).l
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Sprite_ShipDebrisUpdate
; Dispatches debris sprite update to appropriate handler
Sprite_DebrisDispatcher:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_92AE
                move.w  4(a5),d0
                lea     off_92BA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Sprite_DebrisDispatcher
; ---------------------------------------------------------------------------
off_92BA:       dc.w    Object_CheckYPosAndPause-*      ; DATA XREF: Sprite_DebrisDispatcher+4   o
                dc.w    Object_RestoreAfterTimer-*
                dc.w    Object_SetDestroyFlag-*
                dc.w    nullsub_21-*

; Checks if Y position >= 240 then pauses object movement
Object_CheckYPosAndPause:                               ; DATA XREF: ROM:off_92BA   o  ; was: sub_92C2
                cmpi.w  #$F0,$14(a5)
                bcs.w   locret_514E
                move.w  #$60,$48(a5)                    ; '`'
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
Object_SetDestroyFlag:                                  ; DATA XREF: ROM:000092BE   o  ; was: sub_930E
                cmpi.w  #$190,$14(a5)
                bcs.w   locret_514E
                move.w  #$1000,2(a5)
                rts
; End of function Object_SetDestroyFlag
nullsub_21:                                             ; DATA XREF: ROM:000092C0   o
                rts
; End of function nullsub_21

; Initializes title screen mode with graphics data and text rendering
