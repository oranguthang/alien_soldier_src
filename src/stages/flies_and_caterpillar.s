Stage_InitStage9Flies:                                  ; DATA XREF: ROM:0000C8AC   o  ; was: sub_D0B4
                move.w  #0,(dword_FFA900).w
                move.w  #0,(dword_FFA904).w
                move.w  #0,(dword_FFA908).w
                move.w  #0,(dword_FFA90C).w
                move.w  (dword_FFA900).w,(word_FFA928).w
                move.w  (dword_FFA904).w,(word_FFA92C).w
                bsr.w   Stage_FlyingNeoInitBoss
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
                move.b  #$30,(byte_FFA95B).w            ; '0'
                move.w  #$2C,(word_FFF74A).w            ; ','
                clr.w   (word_FFF74E).w
                move.w  #8,(word_FF8090).w
                clr.b   (byte_FF780C).l
                jmp     loc_12340
; End of function Stage_InitStage9Flies
; Checks transition condition to next stage segment
Stage_FliesCheckTransition:                             ; DATA XREF: ROM:0000C8AE   o  ; was: sub_D140
                cmpi.w  #$B0,(dword_FFA960+2).w
                bmi.s   Stage_FliesScrollUpdate
                lea     stru_D1D0(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                clr.w   (word_FF8090).w
                bra.s   Stage_InitCaterpillarShip
; End of function Stage_FliesCheckTransition
; Updates Stage 9 scroll with parallax and lightning
Stage_FliesScrollUpdate:                                ; CODE XREF: Stage_FliesCheckTransition+6   j  ; was: sub_D166
                move.l  #word_D8B2,(dword_FF821A).w
                bsr.w   Effect_SpawnRandomLightning
                bsr.w   Camera_UpdateTowardsPlayer
                bsr.w   Gfx_CalculateScrollPosition
                bsr.w   Stage_FliesVerticalScroll
                bsr.w   Stage_TrainParallaxCalc
                cmpi.w  #$60,(dword_FFA960+2).w         ; '`'
                bmi.s   loc_D18E
                bsr.w   Stage_FliesSpawnEnemies
loc_D18E:                                               ; CODE XREF: Stage_FliesScrollUpdate+22   j
                addi.l  #$4000,(dword_FFA960+2).w
                movea.w #(word_FF9C00-M68K_RAM),a0
                moveq   #$60,d0                         ; '`'
                moveq   #$16,d7
loc_D19E:                                               ; CODE XREF: Stage_FliesScrollUpdate+40   j
                neg.w   d0
                move.w  d0,(a0)+
                neg.w   d0
                addq.w  #8,d0
                dbf     d7,loc_D19E
                moveq   #3,d7
loc_D1AC:                                               ; CODE XREF: Stage_FliesScrollUpdate+4A   j
                move.w  #0,(a0)+
                dbf     d7,loc_D1AC
                movea.w #(word_FF9C00-M68K_RAM),a0
                move.w  (dword_FFA960+2).w,d0
                move.w  d0,d1
                addi.w  #$50,d0                         ; 'P'
loc_D1C2:                                               ; CODE XREF: Stage_FliesScrollUpdate+68   j
                subq.w  #8,d1
                bpl.s   loc_D1C8
                rts
; ---------------------------------------------------------------------------
loc_D1C8:                                               ; CODE XREF: Stage_FliesScrollUpdate+5E   j
                neg.w   d0
                move.w  d0,(a0)+
                neg.w   d0
                bra.s   loc_D1C2
; End of function Stage_FliesScrollUpdate
; ---------------------------------------------------------------------------
stru_D1D0:      dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_FliesCheckTransition+8   o
                dc.l    tiles_10F840                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF

; Initializes caterpillar ship entity
Stage_InitCaterpillarShip:                              ; CODE XREF: Stage_FliesCheckTransition+24   j  ; was: sub_D1DA
                                        ; DATA XREF: ROM:0000C8B0   o
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  #$F900,(dword_FFA90C).w
                bra.w   Stage_CaterpillarShipUpdate
; End of function Stage_InitCaterpillarShip
; Sets up caterpillar boss with lightning and camera
Stage_CaterpillarBossSetup:
                move.l  #word_D8B2,(dword_FF821A).w     ; was: sub_D1EA
                bsr.w   Effect_SpawnRandomLightning
                bsr.w   Camera_UpdateTowardsPlayer
                bra.w   loc_D4BA
; End of function Stage_CaterpillarBossSetup
; Spawns fly enemies with formation pattern
Stage_FliesSpawnEnemies:                                ; CODE XREF: Stage_FliesScrollUpdate+24   p  ; was: sub_D1FE
                cmpi.w  #$20,(dword_FF8058).w           ; ' '
                bne.s   loc_D20C
                clr.l   (dword_FF8240).w
                rts
; ---------------------------------------------------------------------------
loc_D20C:                                               ; CODE XREF: Stage_FliesSpawnEnemies+6   j
                movea.w #(word_FF9600-M68K_RAM),a0
                move.w  (dword_FF8058).w,d0
                moveq   #$16,d7
loc_D216:                                               ; CODE XREF: Stage_FliesSpawnEnemies+22   j
                move.b  #0,(a0,d0.w)
                adda.w  #$20,a0                         ; ' '
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
loc_D256:                                               ; CODE XREF: Stage_FliesSpawnEnemies+52   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_D264
                addq.w  #1,(dword_FF8058).w
locret_D264:                                            ; CODE XREF: Stage_FliesSpawnEnemies+60   j
                rts
; End of function Stage_FliesSpawnEnemies
; ---------------------------------------------------------------------------
unused_2:       binclude "data/other/unused_2.bin"

; Updates caterpillar ship scroll and position
Stage_CaterpillarShipUpdate:                            ; CODE XREF: Stage_InitCaterpillarShip+C   j  ; was: sub_D286
                                        ; DATA XREF: ROM:0000C8B2   o
                addq.w  #2,(word_FFA950).w
                clr.w   (word_FF821E).w
                clr.l   (dword_FFA91C).w
                move.w  #$8000,(word_FF808A).w
                move.w  #$128,(Entity_ObjectPool).w
                move.w  #$C470,(word_FF8110).w
                clr.w   (word_FF8112).w
                move.b  #9,(byte_FFA95A).w
                move.b  #$24,(byte_FFA95B).w            ; '$'
                bra.s   loc_D2BC
; End of function Stage_CaterpillarShipUpdate
; Handles caterpillar ship movement physics
Stage_CaterpillarShipMovement:                          ; DATA XREF: ROM:0000C8B4   o  ; was: sub_D2B6
                move.b  #6,(word_FFF7E6+1).w
loc_D2BC:                                               ; CODE XREF: Stage_CaterpillarShipUpdate+2E   j
                tst.b   (word_FFF720).w
                bmi.s   loc_D2CE
                cmpi.w  #$20,(word_FF8112).w            ; ' '
                bpl.s   loc_D2CE
                addq.w  #2,(word_FF8112).w
loc_D2CE:                                               ; CODE XREF: Stage_CaterpillarShipMovement+A   j
                                        ; Stage_CaterpillarShipMovement+12   j
                move.l  (dword_FFA900).w,(dword_FF8040).w
                bsr.w   Camera_UpdateTowardsPlayer
                move.l  (dword_FFA900).w,d7
                sub.l   (dword_FF8040).w,d7
                addi.l  #$12000,d7
                add.l   d7,(dword_FFA908).w
                move.w  (dword_FFA908).w,d0
                addi.w  #$158,d0
                tst.l   d7
                bpl.s   loc_D2FE
                move.w  (dword_FFA908).w,d0
                subi.w  #$58,d0                         ; 'X'
loc_D2FE:                                               ; CODE XREF: Stage_CaterpillarShipMovement+3E   j
                move.w  (dword_FFA90C).w,d1
                lea     word_D38C(pc),a0
                nop
                jsr     (loc_10704).l
                move.w  (dword_FFA908).w,(word_FF8048).w
                bsr.w   Stage_CaterpillarScrollUpdate
                move.w  (word_FF8048).w,(dword_FFA908).w
                move.w  (dword_FFA908).w,d5
                add.w   (dword_FFA900).w,d5
                cmpi.w  #$9F0,d5
                bmi.s   loc_D332
                move.b  #1,(byte_FF830E).w
loc_D332:                                               ; CODE XREF: Stage_CaterpillarShipMovement+74   j
                cmpi.w  #$A00,d5
                bmi.s   locret_D38A
                bsr.w   Stage_TransitionToNextPhase
                move.b  #2,(word_FFF7E6+1).w
                move.b  #$10,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                clr.w   (dword_FFA90C).w
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                move.w  #0,(word_FFA946).w
                lea     stru_D39C(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                move.w  #$460,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
                move.w  #$60,(dword_FF8128).w           ; '`'
locret_D38A:                                            ; CODE XREF: Stage_CaterpillarShipMovement+80   j
                rts
; End of function Stage_CaterpillarShipMovement
; ---------------------------------------------------------------------------
word_D38C:      dc.w    $FFFF, $7000, $FFFF, $6800, $FFFF, $2000, 0, $6000
                                        ; DATA XREF: Stage_CaterpillarShipMovement+4C   o
stru_D39C:      dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_CaterpillarShipMovement+B8   o
                dc.l    tiles_1163AE                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    $FFFF

; Caterpillar scroll handler
Stage_CaterpillarScrollHandler:                         ; DATA XREF: ROM:0000C8B6   o  ; was: sub_D3A6
                subq.w  #1,(word_FF8112).w
                jsr     (Sprite_SetupDMA).l
                addi.l  #-$10000,(dword_FFA900).w
                bsr.w   Stage_CaterpillarScrollUpdate
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
                jsr     (Sound_QueueBGMRequest).l
                bra.w   loc_D450
; ---------------------------------------------------------------------------
loc_D412:                                               ; CODE XREF: Stage_CaterpillarScrollHandler+5C   j
                move.w  #0,(word_FFA29C).w
                move.w  #4,(word_FF8230).w
locret_D41E:                                            ; CODE XREF: Stage_CaterpillarScrollHandler+1A   j
                                        ; Stage_CaterpillarScrollHandler+28   j
                rts
; End of function Stage_CaterpillarScrollHandler
; Empty handler called from Xi-Tiger boss wait
Stage_XiTigerEmptyHandler:                              ; CODE XREF: Stage_XiTigerBossWait+16   j  ; was: nullsub_23
                                        ; DATA XREF: ROM:0000C8B8   o
                rts
; End of function Stage_XiTigerEmptyHandler
; Initializes Xi-Tiger boss stage parameters
Stage_InitXiTigerBoss:                                  ; DATA XREF: ROM:0000C8C0   o  ; was: sub_D422
                bsr.w   Stage_SetBossTransitionPalette
                move.w  (word_FF8200).w,(word_FF8206).w
                move.w  (word_FFA216).w,(word_FF820A).w
                move.b  #$10,(byte_FFA95A).w
                move.b  #$40,(byte_FFF705).w            ; '@'
                move.w  #$8000,(word_FF808A).w
                move.w  #$20,(word_FFA02A).w            ; ' '
                move.w  #$40,(word_FF8644).w            ; '@'
loc_D450:                                               ; CODE XREF: Stage_CaterpillarScrollHandler+68   j
                move.w  #$70,(word_FFA950).w            ; 'p'
                move.w  #$10,(dword_FF8062).w
                lea     (Boss_XiTigerAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage_InitXiTigerBoss
; Waits for boss spawn with palette setup
Stage_XiTigerBossWait:                                  ; DATA XREF: ROM:0000C8BA   o  ; was: sub_D468
                move.w  #$8004,(word_FF80F2).w
                move.w  #$10,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                subq.w  #1,(dword_FF8062).w
                bpl.w   Stage_XiTigerEmptyHandler
                move.b  #$41,(byte_FFF705).w            ; 'A'
                addq.w  #2,(word_FFA950).w
                move.b  #2,(word_FFF7E6+1).w
                move.b  #1,(byte_FFA95A).w
                move.b  #4,(byte_FFA95B).w
; Waits for entity to clear before boss transition
Stage_XiTigerBossWait_CheckEntity:                      ; DATA XREF: ROM:0000C8BC   o  ; was: loc_D49E
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_D4BA
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(word_FF80C2).w            ; '.'
                move.b  #1,(byte_FF80FA).w
                move.w  #$1C0,(word_FF806E).w
loc_D4BA:                                               ; CODE XREF: Stage_CaterpillarBossSetup+10   j
                                        ; Stage_XiTigerBossWait+3A   j
                bsr.w   Camera_UpdateTowardsPlayer
; End of function Stage_XiTigerBossWait
; Updates caterpillar stage scroll with oscillation
Stage_CaterpillarScrollUpdate:                          ; CODE XREF: Stage_CaterpillarShipMovement+5E   p  ; was: sub_D4BE
                                        ; Stage_CaterpillarScrollHandler+12   p
                bsr.w   Gfx_CalculateScrollPosition
                move.l  #word_D8B2,(dword_FF821A).w
                bsr.w   Effect_SpawnRandomLightning
                tst.w   (dword_FFA960).w
                bmi.s   loc_D4FA
                bne.s   loc_D4E6
                subi.l  #$1000,(dword_FFA904).w
                bpl.s   loc_D4FA
                addq.w  #1,(dword_FFA960).w
                bra.s   loc_D4FA
; ---------------------------------------------------------------------------
loc_D4E6:                                               ; CODE XREF: Stage_CaterpillarScrollUpdate+16   j
                addi.l  #$1000,(dword_FFA904).w
                cmpi.w  #$10,(dword_FFA904).w
                bmi.s   loc_D4FA
                clr.w   (dword_FFA960).w
loc_D4FA:                                               ; CODE XREF: Stage_CaterpillarScrollUpdate+14   j
                                        ; Stage_CaterpillarScrollUpdate+20   j
                tst.w   (dword_FFA960).w
                bpl.s   Stage_FliesVerticalScroll
                move.l  (dword_FFA91C).w,d0
                bpl.s   loc_D50E
                cmpi.l  #$FFFF8000,d0
                bmi.s   loc_D514
loc_D50E:                                               ; CODE XREF: Stage_CaterpillarScrollUpdate+46   j
                subi.l  #$800,d0
loc_D514:                                               ; CODE XREF: Stage_CaterpillarScrollUpdate+4E   j
                move.l  d0,(dword_FFA91C).w
                add.l   d0,(dword_FFA904).w
                bpl.s   loc_D52A
                clr.l   (dword_FFA91C).w
                clr.l   (dword_FFA904).w
                clr.w   (dword_FFA960).w
loc_D52A:                                               ; CODE XREF: Stage_CaterpillarScrollUpdate+5E   j
                cmpi.w  #$18,(dword_FFA904).w
                bmi.s   Stage_FliesVerticalScroll
                move.w  #$18,(dword_FFA904).w
; End of function Stage_CaterpillarScrollUpdate
; Updates vertical scroll positions for parallax
Stage_FliesVerticalScroll:                              ; CODE XREF: Stage_FliesScrollUpdate+14   p  ; was: sub_D538
                                        ; Stage_CaterpillarScrollUpdate+40   j
                movea.w #(word_FFE480-M68K_RAM),a0
                addi.l  #$8000,(dword_FFA918).w
                move.l  (dword_FFA908).w,d0
                add.l   (dword_FFA918).w,d0
                swap    d0
                neg.w   d0
                cmpi.b  #3,(word_FFF7E6+1).w
                beq.s   loc_D576
                moveq   #$20,d1                         ; ' '
                moveq   #$12,d7
loc_D55C:                                               ; CODE XREF: Stage_FliesVerticalScroll+28   j
                move.w  d0,(a0)
                adda.w  d1,a0
                dbf     d7,loc_D55C
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                moveq   #4,d7
loc_D56C:                                               ; CODE XREF: Stage_FliesVerticalScroll+38   j
                move.w  d0,(a0)
                adda.w  d1,a0
                dbf     d7,loc_D56C
                rts
; ---------------------------------------------------------------------------
loc_D576:                                               ; CODE XREF: Stage_FliesVerticalScroll+1E   j
                move.w  #$97,d7
loc_D57A:                                               ; CODE XREF: Stage_FliesVerticalScroll+46   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_D57A
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                moveq   #$27,d7                         ; '''
loc_D58A:                                               ; CODE XREF: Stage_FliesVerticalScroll+56   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_D58A
                rts
; End of function Stage_FliesVerticalScroll
; Transitions to next stage after defeat
Stage_PostXiTigerTransition:                            ; DATA XREF: ROM:0000C8BE   o  ; was: sub_D594
                bsr.w   loc_D4BA
                subq.w  #1,(word_FF806E).w
                bpl.s   locret_D5BA
                tst.w   (word_FF8230).w
                bne.s   locret_D5BA
                move.b  #$86,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                tst.w   (word_FF80C2).w
                beq.w   Stage_InitTransitionState
locret_D5BA:                                            ; CODE XREF: Stage_PostXiTigerTransition+8   j
                                        ; Stage_PostXiTigerTransition+E   j
                rts
; End of function Stage_PostXiTigerTransition
; Initializes projectile spawn position for Terobuster intro
