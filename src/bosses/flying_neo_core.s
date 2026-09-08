Boss_FlyingNeoMain:                                     ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3BFF6
                tst.w   4(a5)
                beq.w   Boss_FlyingNeoStateDispatch
                tst.w   $23C(a5)
                bmi.s   loc_3C00C
                beq.s   loc_3C00C
                bclr    #0,(byte_FF80EC).w
loc_3C00C:                                              ; CODE XREF: Boss_FlyingNeoMain+C   j
                                        ; Boss_FlyingNeoMain+E   j
                lea     (word_3E12).l,a2
                jsr     (Gfx_ProcessColorFade).l
                tst.w   8(a5)
                beq.s   Boss_FlyingNeoStateDispatch
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3C08C
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3C08C
                tst.w   $23C(a5)
                bmi.s   loc_3C084
                beq.s   loc_3C05A
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_3C084
                move.w  #$620,d0
                lea     (word_3E12).l,a2
                jsr     (Gfx_FadeToTargetColor).l
                bne.s   loc_3C084
                move.w  #$FFFF,$23C(a5)
                bra.s   loc_3C084
; ---------------------------------------------------------------------------
loc_3C05A:                                              ; CODE XREF: Boss_FlyingNeoMain+3E   j
                move.w  #$2580,d0
                tst.w   (word_FFFF0E).w
                beq.s   loc_3C068
                move.w  #$3880,d0
loc_3C068:                                              ; CODE XREF: Boss_FlyingNeoMain+6C   j
                cmp.w   (word_FF8200).w,d0
                bmi.s   loc_3C084
                cmpi.w  #$2380,(word_FF8200).w
                bpl.s   loc_3C07E
                move.w  #1,$23C(a5)
                bra.s   loc_3C084
; ---------------------------------------------------------------------------
loc_3C07E:                                              ; CODE XREF: Boss_FlyingNeoMain+7E   j
                move.w  #2,(word_FF8246).w
loc_3C084:                                              ; CODE XREF: Boss_FlyingNeoMain+3C   j
                                        ; Boss_FlyingNeoMain+48   j
                tst.w   (word_FF8200).w
                beq.w   Boss_FlyingNeoDefeatInit
loc_3C08C:                                              ; CODE XREF: Boss_FlyingNeoMain+2E   j
                                        ; Boss_FlyingNeoMain+36   j
                move.w  (dword_FFA900).w,d0
                add.w   $430(a5),d0
                move.w  d0,$BC(a5)
; State dispatcher for Flying Neo boss using jump table
Boss_FlyingNeoStateDispatch:                            ; CODE XREF: Boss_FlyingNeoMain+4   j  ; was: loc_3C098
                                        ; Boss_FlyingNeoMain+26   j
                move.w  4(a5),d0
                movea.w off_3C0A8(pc,d0.w),a0
                adda.l  #Boss_FlyingNeoInit,a0
                jmp     (a0)
; End of function Boss_FlyingNeoMain
; ---------------------------------------------------------------------------
off_3C0A8:      dc.w    Boss_FlyingNeoInit-Boss_FlyingNeoInit
                                        ; DATA XREF: Boss_FlyingNeoMain+A6   r
                dc.w    Boss_FlyingNeoWaitStart-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoSetup-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoIntroWait-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoBattleActive-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoBattleDelay-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoDefeatState1-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoDefeatState2-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoDefeatState3-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoDefeatState4-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoDefeatFinal-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoDefeat_UpdateScroll-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoPlayerControlled-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoAttackPatternUpdate-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoSwoopAttack-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoHoverDecision-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoHover_HorizontalMovement-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoDivePhase-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoDive_DiveInitiated-Boss_FlyingNeoInit
                dc.w    Boss_FlyingNeoHover_WingAnimation-Boss_FlyingNeoInit

; Initializes Flying-Neo boss clearing sprites
Boss_FlyingNeoInit:                                     ; DATA XREF: Boss_FlyingNeoMain+AA   o  ; was: sub_3C0D0
                                        ; ROM:off_3C0A8   o
                addq.w  #2,4(a5)
                move.w  #1,8(a5)
                move.w  #$154,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                movea.w #(word_FF9900-M68K_RAM),a0
                moveq   #$C,d0
                jsr     (Math_CalculateSineCosineTable).l
                bsr.s   Boss_FlyingNeoClearPalettes
                move.l  #dword_11346,(dword_FFA940).w
                move.w  #$F00,(word_FFA946).w
                move.w  #$F760,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
locret_3C10E:                                           ; CODE XREF: Boss_FlyingNeoWaitStart+6   j
                rts
; End of function Boss_FlyingNeoInit
; Clears boss palette entries for initialization
Boss_FlyingNeoClearPalettes:                            ; CODE XREF: Stage_InitStage8Palettes:loc_1233A   p  ; was: sub_3C110
                                        ; Boss_FlyingNeoInit+22   p
                lea     (word_FF4020).l,a0
                move.w  #$7FFF,d0
                move.w  #$EF,d7
loc_3C11E:                                              ; CODE XREF: Boss_FlyingNeoClearPalettes+10   j
                and.w   d0,(a0)+
                dbf     d7,loc_3C11E
                lea     (word_FF4AC0).l,a0
                move.w  #$F,d7
loc_3C12E:                                              ; CODE XREF: Boss_FlyingNeoClearPalettes+20   j
                and.w   d0,(a0)+
                dbf     d7,loc_3C12E
                lea     (word_FF4360).l,a0
                move.w  #$2F,d7                         ; '/'
loc_3C13E:                                              ; CODE XREF: Boss_FlyingNeoClearPalettes+30   j
                and.w   d0,(a0)+
                dbf     d7,loc_3C13E
                lea     (word_FF4400).l,a0
                move.w  #$2F,d7                         ; '/'
loc_3C14E:                                              ; CODE XREF: Boss_FlyingNeoClearPalettes+40   j
                and.w   d0,(a0)+
                dbf     d7,loc_3C14E
                rts
; End of function Boss_FlyingNeoClearPalettes
; Waits for battle start checking player ready
Boss_FlyingNeoWaitStart:                                ; DATA XREF: ROM:0003C0AA   o  ; was: sub_3C156
                jsr     (Gfx_RenderScrollingBackground).l
                bpl.s   locret_3C10E
                addq.w  #2,4(a5)
                clr.w   (word_FF808A).w
                rts
; End of function Boss_FlyingNeoWaitStart
; Complex setup with metasprite and palette initialization
Boss_FlyingNeoSetup:                                    ; DATA XREF: ROM:0003C0AC   o  ; was: sub_3C168
                movea.w #(word_FFC680-M68K_RAM),a4
                move.w  #$300,(dword_FF8040).w
                moveq   #8,d7
                movea.l #Boss_FlyingNeoMetaspriteDescriptors,a0
                movea.l #Boss_FlyingNeoPartRadii,a1
                movea.l #Boss_FlyingNeoPartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                clr.w   $54(a5)
                clr.w   $56(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$D00,2(a5)
                bset    #0,$1E2(a5)
                bset    #0,$362(a5)
                move.w  #$10,d0
                moveq   #8,d1
                move.w  #$8080,d2
                movea.w #(word_FFC9E0-M68K_RAM),a0
                move.w  d0,(a0)
                move.w  #$C080,2(a0)
                move.w  #$4300,$E(a0)
                move.l  #word_EBBB8,8(a0)
                move.b  #$18,$20(a0)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  d0,(a0)
                move.w  #$8080,2(a0)
                move.w  #$6398,$E(a0)
                move.w  #$D00,8(a0)
                move.b  #$18,$20(a0)
                movea.w #(word_FFCA40-M68K_RAM),a0
                lea     word_3CEF0(pc),a1
                nop
                moveq   #2,d7
                bsr.w   Boss_FlyingNeoInitSprites
                lea     word_3CEF6(pc),a1
                nop
                moveq   #1,d7
                bsr.w   Boss_FlyingNeoInitSprites
                lea     word_3CEFC(pc),a1
                nop
                moveq   #1,d7
                bsr.w   Boss_FlyingNeoInitSprites
                lea     word_3CF02(pc),a1
                nop
                moveq   #1,d7
                bsr.w   Boss_FlyingNeoInitSprites
                movea.l #Boss_FlyingNeoObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                lea     (byte_C330).l,a0
                jsr     (Gfx_SyncPaletteBuffers).l
                lea     (word_3E12).l,a2
                jsr     (Gfx_ClearColorFadeState).l
                move.w  #$28,(word_FFF74A).w            ; '('
                clr.w   (word_FFF74E).w
                move.w  #$C,(word_FF8090).w
                move.b  #3,(byte_FFA95B).w
                move.w  #6,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #2,$17E(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$80,$1DE(a5)
                clr.w   $54(a5)
                move.w  #$138,$10(a5)
                move.w  #$20,$14(a5)                    ; ' '
                bsr.w   Boss_FlyingNeoFlipDirection
; End of function Boss_FlyingNeoSetup
; Intro wait state decrementing timer
Boss_FlyingNeoIntroWait:                                ; DATA XREF: ROM:0003C0AE   o  ; was: sub_3C29C
                subq.w  #1,$1DE(a5)
                bmi.s   Boss_FlyingNeoStartBattle
loc_3C2A2:                                              ; CODE XREF: Boss_FlyingNeoBattleActive+4   j
                                        ; Boss_FlyingNeoBattleActive+1E   j
                bsr.w   Boss_FlyingNeoMovementAI
                lea     word_3D00A(pc),a1
                nop
                bsr.w   Boss_FlyingNeoProcessAnimation
                bra.w   Boss_FlyingNeoUpdateSprites
; ---------------------------------------------------------------------------
; Starts battle mode checking victory condition
Boss_FlyingNeoStartBattle:                              ; CODE XREF: Boss_FlyingNeoIntroWait+4   j  ; was: loc_3C2B4
                addq.w  #2,4(a5)
                moveq   #7,d0
                jsr     (UI_CheckVictoryCondition).l
; End of function Boss_FlyingNeoIntroWait
; Active battle state with attack pattern dispatch
Boss_FlyingNeoBattleActive:                             ; DATA XREF: ROM:0003C0B0   o  ; was: sub_3C2C0
                tst.w   (word_FF80C2).w
                bne.s   loc_3C2A2
                addq.w  #2,4(a5)
                move.w  #$30,$1DE(a5)                   ; '0'
                subi.w  #$A0,(word_FFA970).w
                clr.b   (byte_FF80EC).w
; Battle delay timer before transitioning to attack pattern
Boss_FlyingNeoBattleDelay:                              ; DATA XREF: ROM:0003C0B2   o  ; was: loc_3C2DA
                subq.w  #1,$1DE(a5)
                bpl.s   loc_3C2A2
                bra.w   Boss_FlyingNeoInitAttackPattern
; End of function Boss_FlyingNeoBattleActive
; Initializes boss defeat sequence clearing flags
Boss_FlyingNeoDefeatInit:                               ; CODE XREF: Boss_FlyingNeoMain+92   j  ; was: sub_3C2E4
                move.w  #$C,4(a5)
                clr.w   8(a5)
                clr.w   $48(a5)
                move.w  #$C6E0,$4A(a5)
                bsr.w   Boss_FlyingNeoSetEntityFlags
                clr.l   $18(a5)
                clr.l   $1C(a5)
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #4,(word_FF808C).w
; End of function Boss_FlyingNeoDefeatInit
; Defeat state spawning parts upward with timer
Boss_FlyingNeoDefeatState1:                             ; DATA XREF: ROM:0003C0B4   o  ; was: sub_3C31C
                bsr.w   Boss_FlyingNeoUpdatePaletteFade
                bsr.w   Boss_FlyingNeoCalculateCenter
                bsr.w   Boss_FlyingNeoUpdateScroll
                subq.w  #1,$48(a5)
                bpl.s   locret_3C354
                move.w  #5,$48(a5)
                movea.w $4A(a5),a0
                addi.w  #$60,$4A(a5)                    ; '`'
                cmpi.w  #$C9E0,$4A(a5)
                bmi.s   loc_3C350
                addq.w  #2,4(a5)
                move.w  #$CD40,$4A(a5)
loc_3C350:                                              ; CODE XREF: Boss_FlyingNeoDefeatState1+28   j
                bsr.w   Boss_FlyingNeoSpawnDefeatParticle
locret_3C354:                                           ; CODE XREF: Boss_FlyingNeoDefeatState1+10   j
                rts
; End of function Boss_FlyingNeoDefeatState1
; Set entity flags across multiple Flying-Neo entities
Boss_FlyingNeoSetEntityFlags:                           ; CODE XREF: Boss_FlyingNeoDefeatInit+14   p  ; was: sub_3C356
                moveq   #0,d0
                movea.w #(word_FFC682-M68K_RAM),a0
                moveq   #$12,d7
loc_3C35E:                                              ; CODE XREF: Boss_FlyingNeoSetEntityFlags+E   j
                bset    d0,(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3C35E
                rts
; End of function Boss_FlyingNeoSetEntityFlags
; Spawns defeat particle with velocity and sound
Boss_FlyingNeoSpawnDefeatParticle:                      ; CODE XREF: Boss_FlyingNeoDefeatState1:loc_3C350   p  ; was: sub_3C36A
                                        ; sub_3C3AE:loc_3C3DC   p
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                jsr     (Sprite_InitFromTable).l
                clr.l   $18(a0)
                move.l  #$FFFEE000,$1C(a0)
                clr.b   $20(a0)
                move.b  #$BC,d0
                jmp     (Sound_PlaySFX).l
; End of function Boss_FlyingNeoSpawnDefeatParticle
; Calculates boss center position for collision
Boss_FlyingNeoCalculateCenter:                          ; CODE XREF: Boss_FlyingNeoDefeatState1+4   p  ; was: sub_3C390
                                        ; Boss_FlyingNeoDefeatState2+4   p
                moveq   #$E,d0
                moveq   #$1C,d1
                tst.w   $54(a5)
                beq.s   loc_3C39C
                moveq   #$10,d0
loc_3C39C:                                              ; CODE XREF: Boss_FlyingNeoCalculateCenter+8   j
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$70(a5)
                move.w  d1,$74(a5)
                rts
; End of function Boss_FlyingNeoCalculateCenter
; Defeat state spawning parts downward
Boss_FlyingNeoDefeatState2:                             ; DATA XREF: ROM:0003C0B6   o  ; was: sub_3C3AE
                bsr.w   Boss_FlyingNeoUpdatePaletteFade
                bsr.w   Boss_FlyingNeoCalculateCenter
                bsr.w   Boss_FlyingNeoUpdateScroll
                subq.w  #1,$48(a5)
                bpl.s   locret_3C3E0
                move.w  #4,$48(a5)
                movea.w $4A(a5),a0
                subi.w  #$60,$4A(a5)                    ; '`'
                cmpi.w  #$C9E0,$4A(a5)
                bne.s   loc_3C3DC
                addq.w  #2,4(a5)
loc_3C3DC:                                              ; CODE XREF: Boss_FlyingNeoDefeatState2+28   j
                bsr.w   Boss_FlyingNeoSpawnDefeatParticle
locret_3C3E0:                                           ; CODE XREF: Boss_FlyingNeoDefeatState2+10   j
                rts
; End of function Boss_FlyingNeoDefeatState2
; Defeat state preparing final explosion effects
Boss_FlyingNeoDefeatState3:                             ; DATA XREF: ROM:0003C0B8   o  ; was: sub_3C3E2
                bsr.w   Boss_FlyingNeoUpdatePaletteFade
                bsr.w   Boss_FlyingNeoCalculateCenter
                bsr.w   Boss_FlyingNeoUpdateScroll
                subq.w  #1,$48(a5)
                bpl.s   locret_3C426
                addq.w  #2,4(a5)
                move.w  #$70,$48(a5)                    ; 'p'
                bsr.w   Boss_FlyingNeoDMAScrollWrite
                movea.w #(word_FFC9E0-M68K_RAM),a0
                move.l  #off_E953C,8(a0)
                move.l  #$FFFEE000,$18(a0)
                tst.w   $54(a5)
                beq.s   loc_3C420
                neg.l   $18(a0)
loc_3C420:                                              ; CODE XREF: Boss_FlyingNeoDefeatState3+38   j
                jmp     Projectile_InitType88
; ---------------------------------------------------------------------------
locret_3C426:                                           ; CODE XREF: Boss_FlyingNeoDefeatState3+10   j
                rts
; End of function Boss_FlyingNeoDefeatState3
; Defeat state firing particle rain with sound
Boss_FlyingNeoDefeatState4:                             ; DATA XREF: ROM:0003C0BA   o  ; was: sub_3C428
                bsr.w   Boss_FlyingNeoUpdatePaletteFade
                bsr.w   Boss_FlyingNeoCalculateCenter
                bsr.w   Boss_FlyingNeoUpdateScroll
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3C4A6
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_3C4A6
                move.l  #off_E953C,8(a0)
                move.l  #$FFFF1000,$1C(a0)
                jsr     (Projectile_InitType88).l
                clr.b   $20(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$1F,d1
                subi.w  #$20,d0                         ; ' '
                subi.w  #$10,d1
                add.w   $10(a5),d0
                tst.w   $54(a5)
                beq.s   loc_3C486
                addi.w  #$20,d0                         ; ' '
loc_3C486:                                              ; CODE XREF: Boss_FlyingNeoDefeatState4+58   j
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_3C4A6
                move.b  #$BC,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
loc_3C4A6:                                              ; CODE XREF: Boss_FlyingNeoDefeatState4+14   j
                                        ; Boss_FlyingNeoDefeatState4+1C   j
                subq.w  #1,$48(a5)
                bpl.s   locret_3C4C8
                addq.w  #2,4(a5)
                move.w  #$10,$48(a5)
                move.w  #$1000,$62(a5)
                lea     word_3CEA0(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
locret_3C4C8:                                           ; CODE XREF: Boss_FlyingNeoDefeatState4+82   j
                rts
; End of function Boss_FlyingNeoDefeatState4
; Final defeat state advancing to next stage
Boss_FlyingNeoDefeatFinal:                              ; DATA XREF: ROM:0003C0BC   o  ; was: sub_3C4CA
                subq.w  #1,$48(a5)
                bpl.s   Boss_FlyingNeoDefeat_UpdateScroll
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
                move.w  #$5C,(word_FF80C2).w            ; '\'
; Updates scroll during final defeat sequence
Boss_FlyingNeoDefeat_UpdateScroll:                      ; CODE XREF: Boss_FlyingNeoDefeatFinal+4   j  ; was: loc_3C4DE
                                        ; DATA XREF: ROM:0003C0BE   o
                bra.w   Boss_FlyingNeoUpdateScroll
; End of function Boss_FlyingNeoDefeatFinal
; Flying-Neo boss player control input handler
Boss_FlyingNeoPlayerControlled:                         ; DATA XREF: ROM:0003C0C0   o  ; was: sub_3C4E2
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $23E(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                btst    #0,(word_FFF706).w
                beq.s   loc_3C50A
                move.w  #$FFFF,$1C(a5)
                move.w  #$FFE0,$23E(a5)
loc_3C50A:                                              ; CODE XREF: Boss_FlyingNeoPlayerControlled+1A   j
                btst    #1,(word_FFF706).w
                beq.s   loc_3C51E
                move.w  #1,$1C(a5)
                move.w  #$20,$23E(a5)                   ; ' '
loc_3C51E:                                              ; CODE XREF: Boss_FlyingNeoPlayerControlled+2E   j
                btst    #3,(word_FFF706).w
                beq.s   loc_3C536
                move.w  #2,$18(a5)
                move.w  #$100,$54(a5)
                bsr.w   Boss_FlyingNeoFlipDirection
loc_3C536:                                              ; CODE XREF: Boss_FlyingNeoPlayerControlled+42   j
                btst    #2,(word_FFF706).w
                beq.s   loc_3C54E
                move.w  #$FFFE,$18(a5)
                move.w  #0,$54(a5)
                bsr.w   Boss_FlyingNeoFlipDirection
loc_3C54E:                                              ; CODE XREF: Boss_FlyingNeoPlayerControlled+5A   j
                lea     word_3D00A(pc),a1
                nop
                bsr.w   Boss_FlyingNeoProcessAnimation
                bra.w   Boss_FlyingNeoUpdateSprites
; End of function Boss_FlyingNeoPlayerControlled
; Initializes attack pattern state with timer
Boss_FlyingNeoInitAttackPattern:                        ; CODE XREF: Boss_FlyingNeoBattleActive+20   j  ; was: sub_3C55C
                                        ; Boss_FlyingNeoHoverDecision+12   j
                move.w  #$1A,4(a5)
                clr.w   $17E(a5)
                clr.w   $1DC(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3FF,d0
                addi.w  #$40,d0                         ; '@'
                move.w  d0,$1DE(a5)
; Sets up attack slot pointers and sprite data
Boss_FlyingNeoSetupAttackSlots:                         ; CODE XREF: Boss_FlyingNeoHoverDecision+152   j  ; was: loc_3C57A
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #word_EBC18,$1E8(a5)
                move.l  #word_EBC18,$368(a5)
; End of function Boss_FlyingNeoInitAttackPattern
; Updates attack pattern with movement and animations
Boss_FlyingNeoAttackPatternUpdate:                      ; DATA XREF: ROM:0003C0C2   o  ; was: sub_3C592
                subq.w  #1,$1DE(a5)
                bmi.w   Boss_FlyingNeoResetAttack
                bsr.w   Boss_FlyingNeoMovementAI
                bsr.w   Boss_FlyingNeoCalculateDistance
                bsr.s   Boss_FlyingNeoAttackMovement
                cmpi.w  #$1A,4(a5)
                beq.s   loc_3C5AE
                rts
; ---------------------------------------------------------------------------
loc_3C5AE:                                              ; CODE XREF: Boss_FlyingNeoAttackPatternUpdate+18   j
                lea     word_3D00A(pc),a1
                nop
                bsr.w   Boss_FlyingNeoProcessAnimation
                bra.w   Boss_FlyingNeoUpdateSprites
; End of function Boss_FlyingNeoAttackPatternUpdate
; Handles attack movement with horizontal acceleration
Boss_FlyingNeoAttackMovement:                           ; CODE XREF: Boss_FlyingNeoAttackPatternUpdate+10   p  ; was: sub_3C5BC
                move.b  (dword_FFFF08+1).w,d5
                move.b  (dword_FFFF08).w,d6
                move.w  (word_FFA000).w,d7
                asr.w   #2,d7
                andi.w  #$40,d7                         ; '@'
                add.w   d7,d0
                tst.w   $54(a5)
                beq.w   loc_3C61C
                tst.w   d1
                bmi.w   Boss_FlyingNeoResetAttack
                tst.w   $1DC(a5)
                bne.s   loc_3C5FC
                cmpi.l  #$2C000,$18(a5)
                bpl.s   loc_3C5F6
                addi.l  #$3200,$18(a5)
loc_3C5F6:                                              ; CODE XREF: Boss_FlyingNeoAttackMovement+30   j
                bsr.w   Boss_FlyingNeoCheckAttackCondition
                rts
; ---------------------------------------------------------------------------
loc_3C5FC:                                              ; CODE XREF: Boss_FlyingNeoAttackMovement+26   j
                subq.w  #1,$11C(a5)
                bpl.s   loc_3C608
loc_3C602:                                              ; CODE XREF: Boss_FlyingNeoAttackMovement+8E   j
                clr.w   $1DC(a5)
                rts
; ---------------------------------------------------------------------------
loc_3C608:                                              ; CODE XREF: Boss_FlyingNeoAttackMovement+44   j
                cmpi.l  #$FFFC2000,$18(a5)
                bmi.s   locret_3C61A
                addi.l  #-$4200,$18(a5)
locret_3C61A:                                           ; CODE XREF: Boss_FlyingNeoAttackMovement+54   j
                rts
; ---------------------------------------------------------------------------
loc_3C61C:                                              ; CODE XREF: Boss_FlyingNeoAttackMovement+18   j
                tst.w   d1
                bpl.w   Boss_FlyingNeoResetAttack
                tst.w   $1DC(a5)
                bne.s   loc_3C646
                cmpi.l  #$FFFD4000,$18(a5)
                bmi.s   loc_3C63A
                addi.l  #-$3200,$18(a5)
loc_3C63A:                                              ; CODE XREF: Boss_FlyingNeoAttackMovement+74   j
                cmpi.w  #$E4,d0
                bpl.s   locret_3C644
                bsr.w   Boss_FlyingNeoCheckAttackCondition
locret_3C644:                                           ; CODE XREF: Boss_FlyingNeoAttackMovement+82   j
                rts
; ---------------------------------------------------------------------------
loc_3C646:                                              ; CODE XREF: Boss_FlyingNeoAttackMovement+6A   j
                subq.w  #1,$11C(a5)
                bmi.s   loc_3C602
                cmpi.l  #$3E000,$18(a5)
                bpl.s   locret_3C65E
                addi.l  #$4200,$18(a5)
locret_3C65E:                                           ; CODE XREF: Boss_FlyingNeoAttackMovement+98   j
                rts
; End of function Boss_FlyingNeoAttackMovement
; Checks conditions to trigger attack state
Boss_FlyingNeoCheckAttackCondition:                     ; CODE XREF: Boss_FlyingNeoAttackMovement:loc_3C5F6   p  ; was: sub_3C660
                                        ; Boss_FlyingNeoAttackMovement+84   p
                cmpi.w  #$D4,d0
                bpl.s   locret_3C686
                move.w  (word_FFA000).w,d0
                btst    #9,d0
                beq.s   loc_3C678
                andi.w  #1,d0
                beq.w   loc_3C7D6
loc_3C678:                                              ; CODE XREF: Boss_FlyingNeoCheckAttackCondition+E   j
                addq.w  #2,$1DC(a5)
                andi.w  #$F,d6
                addq.w  #3,d6
                move.w  d6,$11C(a5)
locret_3C686:                                           ; CODE XREF: Boss_FlyingNeoCheckAttackCondition+4   j
                rts
; End of function Boss_FlyingNeoCheckAttackCondition
; Movement AI with position tracking and boundaries
Boss_FlyingNeoMovementAI:                               ; CODE XREF: Boss_FlyingNeoIntroWait:loc_3C2A2   p  ; was: sub_3C688
                                        ; Boss_FlyingNeoAttackPatternUpdate+8   p
                move.w  $14(a5),d7
                move.l  $1C(a5),d6
                move.w  (dword_FFFF08).w,d0
                tst.w   $17E(a5)
                bne.w   loc_3C6C6
loc_3C69C:                                              ; CODE XREF: Boss_FlyingNeoMovementAI+48   j
                                        ; Boss_FlyingNeoMovementAI+54   j
                clr.w   $17E(a5)
                cmpi.w  #$B0,d7
                bmi.s   loc_3C6C6
                cmpi.w  #$C6,d7
                bpl.s   loc_3C6B2
                andi.w  #7,d0
                beq.s   loc_3C6C6
loc_3C6B2:                                              ; CODE XREF: Boss_FlyingNeoMovementAI+22   j
                cmpi.l  #$FFFEE000,d6
                bmi.s   locret_3C6C4
                addi.l  #-$1E00,d6
                move.l  d6,$1C(a5)
locret_3C6C4:                                           ; CODE XREF: Boss_FlyingNeoMovementAI+30   j
                                        ; Boss_FlyingNeoMovementAI+5C   j
                rts
; ---------------------------------------------------------------------------
loc_3C6C6:                                              ; CODE XREF: Boss_FlyingNeoMovementAI+10   j
                                        ; Boss_FlyingNeoMovementAI+1C   j
                move.w  #2,$17E(a5)
                cmpi.w  #$DC,d7
                bpl.s   loc_3C69C
                cmpi.w  #$C6,d7
                bmi.s   loc_3C6DE
                andi.w  #7,d0
                beq.s   loc_3C69C
loc_3C6DE:                                              ; CODE XREF: Boss_FlyingNeoMovementAI+4E   j
                cmpi.l  #$12000,d6
                bpl.s   locret_3C6C4
                addi.l  #$1E00,d6
                move.l  d6,$1C(a5)
                rts
; End of function Boss_FlyingNeoMovementAI
; Resets attack state clearing velocity and animation
Boss_FlyingNeoResetAttack:                              ; CODE XREF: Boss_FlyingNeoAttackPatternUpdate+4   j  ; was: sub_3C6F2
                                        ; Boss_FlyingNeoAttackMovement+1E   j
                move.w  #$1C,4(a5)
                move.l  #word_EBC18,$1E8(a5)
                move.l  #word_EBC18,$368(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; End of function Boss_FlyingNeoResetAttack
; Swoop attack with horizontal velocity and position check
Boss_FlyingNeoSwoopAttack:                              ; DATA XREF: ROM:0003C0C4   o  ; was: sub_3C71A
                subi.l  #$E00,$1C(a5)
                tst.w   $54(a5)
                bne.s   loc_3C746
                cmpi.w  #$E80,$BC(a5)
                bmi.w   loc_3C770
                cmpi.l  #$FFFAA000,$18(a5)
                bmi.s   loc_3C762
                addi.l  #-$4200,$18(a5)
                bra.s   loc_3C762
; ---------------------------------------------------------------------------
loc_3C746:                                              ; CODE XREF: Boss_FlyingNeoSwoopAttack+C   j
                cmpi.w  #$1120,$BC(a5)
                bpl.w   loc_3C770
                cmpi.l  #$56000,$18(a5)
                bpl.s   loc_3C762
                addi.l  #$4200,$18(a5)
loc_3C762:                                              ; CODE XREF: Boss_FlyingNeoSwoopAttack+20   j
                                        ; Boss_FlyingNeoSwoopAttack+2A   j
                lea     word_3D01C(pc),a1
                nop
                bsr.w   Boss_FlyingNeoProcessAnimation
                bra.w   Boss_FlyingNeoUpdateSprites
; ---------------------------------------------------------------------------
loc_3C770:                                              ; CODE XREF: Boss_FlyingNeoSwoopAttack+14   j
                                        ; Boss_FlyingNeoSwoopAttack+32   j
                move.w  #$1E,4(a5)
                move.w  #$C0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                addi.w  #$20,d0                         ; ' '
                move.w  d0,$1DE(a5)
                clr.w   $54(a5)
                cmpi.w  #$FD0,$BC(a5)
                bpl.s   loc_3C7AE
                move.w  #$100,$54(a5)
loc_3C7AE:                                              ; CODE XREF: Boss_FlyingNeoSwoopAttack+8C   j
                bsr.w   Boss_FlyingNeoFlipDirection
; End of function Boss_FlyingNeoSwoopAttack
; Hover decision state choosing next attack pattern
