Stage_SpawnerDispatcher1:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_30B3A
                move.w  4(a5),d0
                lea     off_30B46(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Stage_SpawnerDispatcher1
; ---------------------------------------------------------------------------
off_30B46:      dc.w    Stage_SpawnerInit1-*            ; DATA XREF: Stage_SpawnerDispatcher1+4   o
                dc.w    Stage_SpawnerSpawnByTimer-*

; Initialize spawner entity properties and difficulty spawn table
Stage_SpawnerInit1:                                     ; DATA XREF: ROM:off_30B46   o  ; was: sub_30B4A
                move.w  #$6000,2(a5)
                move.w  #$8000,$E(a5)
                move.l  #off_1A0F76,8(a5)
                addq.w  #2,4(a5)
                tst.w   (word_FFFF0E).w
                bne.w   loc_30B74
                move.l  #word_30C54,$40(a5)
                rts
; ---------------------------------------------------------------------------
loc_30B74:                                              ; CODE XREF: Stage_SpawnerInit1+1C   j
                move.l  #word_30BC6,$40(a5)
                rts
; End of function Stage_SpawnerInit1
; Spawn entities at positions from table based on scroll timer
Stage_SpawnerSpawnByTimer:                              ; DATA XREF: ROM:00030B48   o  ; was: sub_30B7E
                tst.l   (dword_FFA41C).w
                bne.w   locret_30BB8
                move.w  (dword_FFA904).w,d0
                sub.w   (dword_FFA414).w,d0
                movea.l $40(a5),a4
                cmp.w   (a4)+,d0
                bcs.w   locret_30BB8
loc_30B98:                                              ; CODE XREF: Stage_SpawnerSpawnByTimer+34   j
                jsr     (Projectile_FindFreeOrRecycleSlot).l
                bne.s   loc_30BBA
                move.w  #$384,(a0)
                move.w  (a4)+,$10(a0)
                move.w  (a4)+,$14(a0)
                clr.w   4(a0)
                tst.w   (a4)
                bpl.s   loc_30B98
                move.l  a4,$40(a5)
locret_30BB8:                                           ; CODE XREF: Enemy_Stage18SpawnerMain+24   j
                                        ; Enemy_Stage18SpawnerMain+4C   j
                rts
; ---------------------------------------------------------------------------
loc_30BBA:                                              ; CODE XREF: Stage_SpawnerSpawnByTimer+20   j
                                        ; Stage_SpawnerSpawnByTimer+40   j
                addq.w  #4,a4
                tst.w   (a4)
                bpl.s   loc_30BBA
                move.l  a4,$40(a5)
                rts
; End of function Stage_SpawnerSpawnByTimer
; ---------------------------------------------------------------------------
word_30BC6:     dc.w    $E080, $90, $70, $1B0, $68
                                        ; DATA XREF: Stage_SpawnerInit1:loc_30B74   o
                dc.w    $E0D0, $C0, $68, $150, $70
                dc.w    $180, $60, $E120, $90, $60
                dc.w    $F0, $68, $150, $58, $E170
                dc.w    $F0, $68, $120, $50, $150
                dc.w    $58, $1B0, $70, $E1C0, $90
                dc.w    $70, $C0, $58, $150, $50
                dc.w    $180, $68, $E210, $C0, $48
                dc.w    $120, $60, $180, $70, $1B0
                dc.w    $58, $E260, $90, $70, $F0
                dc.w    $60, $120, $68, $150, $58
                dc.w    $1B0, $50, $E2B0, $90, $58
                dc.w    $C0, $40, $F0, $68, $150
                dc.w    $50, $180, $70, $1B0, $60
                dc.w    $FFFF
word_30C54:     dc.w    $E080, $90, $70, $1B0, $68
                                        ; DATA XREF: Stage_SpawnerInit1+20   o
                dc.w    $E0D0, $C0, $68, $180, $60
                dc.w    $E120, $C0, $68, $150, $58
                dc.w    $E170, $F0, $68, $180, $70
                dc.w    $E1C0, $90, $70, $180, $50
                dc.w    $1B0, $68, $E210, $90, $48
                dc.w    $C0, $60, $F0, $70, $1B0
                dc.w    $58, $E260, $F0, $60, $120
                dc.w    $68, $150, $58, $E2B0, $90
                dc.w    $58, $C0, $40, $180, $70
                dc.w    $1B0, $60, $FFFF

; Dispatch to spawner state handler via jump table
Stage_SpawnerDispatcher2:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_30CBE
                move.w  4(a5),d0
                lea     off_30CCA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Stage_SpawnerDispatcher2
; ---------------------------------------------------------------------------
off_30CCA:      dc.w    Boss_JetsripperDebrisInit-*     ; DATA XREF: Stage_SpawnerDispatcher2+4   o
                dc.w    Enemy_BounceOnGround-*

; Initialize falling debris entity properties and physics
Boss_JetsripperDebrisInit:                              ; DATA XREF: ROM:off_30CCA   o  ; was: sub_30CCE
                move.w  #$CD00,2(a5)
                move.w  #$A300,$E(a5)
                move.l  #word_EB36E,8(a5)
                move.b  #0,$20(a5)
                move.w  #$800,$24(a5)
                move.b  #$C0,$21(a5)
                move.l  #$F40CF40C,$2C(a5)
                move.l  #$E817E818,$28(a5)
                move.b  #$10,$23(a5)
                move.w  #$28,$26(a5)                    ; '('
                clr.w   $44(a5)
                move.w  #$FFFF,$46(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperDebrisInit
; Enemy bouncing on ground
Enemy_BounceOnGround:                                   ; DATA XREF: ROM:00030CCC   o  ; was: sub_30D20
                addi.l  #$4000,$1C(a5)
                tst.w   $44(a5)
                beq.s   loc_30D34
                subq.w  #1,$44(a5)
                rts
; ---------------------------------------------------------------------------
loc_30D34:                                              ; CODE XREF: Enemy_BounceOnGround+C   j
                clr.w   d0
                move.w  #$18,d1
                jsr     (Physics_AddEntityOffset).l
                bne.s   loc_30D54
                cmpi.w  #$180,$14(a5)
                bcs.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_30D54:                                              ; CODE XREF: Enemy_BounceOnGround+20   j
                move.w  #3,(word_FFA010).w
                move.b  #$53,d0                         ; 'S'
                jsr     (Sound_PlaySFX).l
                move.l  $1C(a5),$40(a5)
                jsr     (Physics_AlignToTerrain).l
                move.l  $40(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                tst.w   $46(a5)
                bmi.s   loc_30D8A
                move.w  #$18,$44(a5)
                rts
; ---------------------------------------------------------------------------
loc_30D8A:                                              ; CODE XREF: Enemy_BounceOnGround+60   j
                clr.w   $46(a5)
                rts
; End of function Enemy_BounceOnGround
; Main handler for Stage 11 boss part
Enemy_Stage11BossPartMain:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_30D90
                cmpi.w  #$14,4(a5)
                bcc.s   loc_30DA6
                tst.w   $24(a5)
                bpl.w   loc_30DA6
                move.w  #$14,4(a5)
loc_30DA6:                                              ; CODE XREF: Enemy_Stage11BossPartMain+6   j
                                        ; Enemy_Stage11BossPartMain+C   j
                move.w  4(a5),d0
                lea     off_30DB2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage11BossPartMain
; ---------------------------------------------------------------------------
off_30DB2:      dc.w    Enemy_Stage11BossPartInit-*     ; DATA XREF: Enemy_Stage11BossPartMain+1A   o
                dc.w    Enemy_Stage11BossPartFloat-*
                dc.w    Enemy_Stage11BossPartSpawn-*
                dc.w    Enemy_Stage11BossPartFallInit-*
                dc.w    Enemy_Stage11BossPartFallDelay-*
                dc.w    Boss_JetsripperPartSetVelocity-*
                dc.w    Boss_JetsripperPartDecelerateStop-*
                dc.w    Boss_JetsripperDecelerateUp-*
                dc.w    Boss_JetsripperAccelerateDown-*
                dc.w    Boss_JetsripperDecelerateAndReset-*
                dc.w    Boss_JetsripperInitFallVelocity-*
                dc.w    Boss_JetsripperSpawnProjectilesUntilLowY-*

; Initializes Stage 11 boss part
Enemy_Stage11BossPartInit:                              ; DATA XREF: ROM:off_30DB2   o  ; was: sub_30DCA
                move.w  #$CF00,2(a5)
                move.w  #$8C2,$E(a5)
                move.l  #word_EB356,8(a5)
                move.b  #$3C,$20(a5)                    ; '<'
                move.w  #$64,$24(a5)                    ; 'd'
                move.b  #$C0,$21(a5)
                move.l  #$FC04FC04,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$26(a5)                    ; '('
                move.l  #$FFFD0000,$1C(a5)
                move.l  #$FFFE8000,$18(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartInit
; Boss part floating state
Enemy_Stage11BossPartFloat:                             ; DATA XREF: ROM:00030DB4   o  ; was: sub_30E1C
                addi.l  #$4000,$1C(a5)
                bne.w   locret_30BB8
                clr.l   $1C(a5)
                clr.l   $18(a5)
                move.w  #$20,$46(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartFloat
; Boss part spawns projectile
Enemy_Stage11BossPartSpawn:                             ; DATA XREF: ROM:00030DB6   o  ; was: sub_30E3C
                jsr     (Projectile_FindFreeOrRecycleSlot).l
                bne.s   loc_30E70
                move.w  #$8F00,2(a0)
                move.w  #$38C,(a0)
                move.w  $10(a5),$10(a0)
                subi.w  #$18,$10(a0)
                move.w  $14(a5),$14(a0)
                subi.w  #$14,$14(a0)
                move.w  $5E(a5),$5E(a0)
                clr.w   4(a0)
loc_30E70:                                              ; CODE XREF: Enemy_Stage11BossPartSpawn+6   j
                move.l  #$40000,$1C(a5)
                move.l  #$30000,$18(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartSpawn
; Initializes falling state
Enemy_Stage11BossPartFallInit:                          ; DATA XREF: ROM:00030DB8   o  ; was: sub_30E86
                move.l  #$FFFC0000,$1C(a5)
                move.l  #$FFFD0000,$18(a5)
                move.w  #4,$44(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartFallInit
; Delays before next fall iteration
Enemy_Stage11BossPartFallDelay:                         ; DATA XREF: ROM:00030DBA   o  ; was: sub_30EA2
                clr.l   $1C(a5)
                clr.l   $18(a5)
                subq.w  #1,$44(a5)
                bne.w   locret_30BB8
                subq.w  #1,$46(a5)
                beq.s   loc_30EBE
                subq.w  #4,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_30EBE:                                              ; CODE XREF: Enemy_Stage11BossPartFallDelay+14   j
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartFallDelay
; Set vertical and horizontal velocity for boss part
Boss_JetsripperPartSetVelocity:                         ; DATA XREF: ROM:00030DBC   o  ; was: sub_30EC4
                move.l  #$30000,$1C(a5)
                move.l  #$18000,$18(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperPartSetVelocity
; Decelerate vertical velocity until stopped then wait
Boss_JetsripperPartDecelerateStop:                      ; DATA XREF: ROM:00030DBE   o  ; was: sub_30EDA
                subi.l  #$4000,$1C(a5)
                bne.w   locret_30BB8
                clr.l   $18(a5)
                move.w  #$20,$46(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperPartDecelerateStop
; Decelerates upward movement with timer countdown for Jetsripper boss part
Boss_JetsripperDecelerateUp:                            ; DATA XREF: ROM:00030DC0   o  ; was: sub_30EF6
                subi.l  #$A00,$18(a5)
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.w  #$40,$46(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperDecelerateUp
; Accelerates downward movement with timer countdown for Jetsripper boss part
Boss_JetsripperAccelerateDown:                          ; DATA XREF: ROM:00030DC2   o  ; was: sub_30F12
                addi.l  #$A00,$18(a5)
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.w  #$20,$46(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperAccelerateDown
; Decelerates upward and resets to initial movement state with specific velocities
Boss_JetsripperDecelerateAndReset:                      ; DATA XREF: ROM:00030DC4   o  ; was: sub_30F2E
                subi.l  #$A00,$18(a5)
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.l  #$FFFD0000,$1C(a5)
                move.l  #$FFFE8000,$18(a5)
                move.w  #2,4(a5)
                rts
; End of function Boss_JetsripperDecelerateAndReset
; Initializes downward velocity for Jetsripper boss part movement
Boss_JetsripperInitFallVelocity:                        ; DATA XREF: ROM:00030DC6   o  ; was: sub_30F56
                clr.l   $18(a5)
                move.l  #$8000,$1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperInitFallVelocity
; Spawns projectiles periodically until Y position falls below 180h
Boss_JetsripperSpawnProjectilesUntilLowY:               ; DATA XREF: ROM:00030DC8   o  ; was: sub_30F68
                bsr.w   Boss_JetsripperSpawnUpwardProjectile
                cmpi.w  #$180,$14(a5)
                bcs.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperSpawnProjectilesUntilLowY
; Creates projectile every 4 frames and negates vertical velocity for upward firing
Boss_JetsripperSpawnUpwardProjectile:                   ; CODE XREF: Boss_JetsripperSpawnProjectilesUntilLowY   p  ; was: sub_30F7E
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_30BB8
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                bsr.w   Boss_GustheadSpawnAngleProjectile
                tst.l   $1C(a4)
                bmi.w   locret_30BB8
                neg.l   $1C(a4)
                rts
; End of function Boss_JetsripperSpawnUpwardProjectile
; State dispatcher for boss part
Enemy_Stage11BossPartDispatcher:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_30FA6
                move.w  4(a5),d0
                lea     off_30FB2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage11BossPartDispatcher
; ---------------------------------------------------------------------------
off_30FB2:      dc.w    Enemy_Stage11BossPartState1-*   ; DATA XREF: Enemy_Stage11BossPartDispatcher+4   o
                dc.w    Boss_JetsripperFallAndFirePattern-*

; Boss part state 1 initialization
Enemy_Stage11BossPartState1:                            ; DATA XREF: ROM:off_30FB2   o  ; was: sub_30FB6
                jsr     (RandomNumber).l
                andi.w  #6,d0
                move.w  d0,$40(a5)
                bsr.w   Enemy_Stage11BossPartUpdatePalette
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                move.b  #$40,$20(a5)                    ; '@'
                move.w  #$800,$24(a5)
                move.b  #$C0,$21(a5)
                move.l  #$FC04FC04,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$26(a5)                    ; '('
                move.w  $5E(a5),d0
                move.l  dword_31018(pc,d0.w),$1C(a5)
                move.l  dword_31018+$10(pc,d0.w),$18(a5)
                move.l  dword_31018+$20(pc,d0.w),$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage11BossPartState1
; ---------------------------------------------------------------------------
dword_31018:    dc.l    $FFFB0000, $FFFC0000
                                        ; DATA XREF: Enemy_Stage11BossPartState1+4A   r
                dc.l    $FFFD0000, $FFFE0000
                dc.l    $FFFD0000, $FFFD8000
                dc.l    $FFFE0000, $FFFE8000
                dc.l    $1800, $1400
                dc.l    $1000, $C00

; Falls with applied velocity while firing projectiles until Y position reaches 180h
Boss_JetsripperFallAndFirePattern:                      ; DATA XREF: ROM:00030FB4   o  ; was: sub_31048
                bsr.w   Boss_JetsripperFrameCheck
                bsr.w   Boss_JetsripperSpawnRandomAngleProjectile
                move.l  $48(a5),d0
                add.l   d0,$1C(a5)
                cmpi.w  #$180,$14(a5)
                bcs.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperFallAndFirePattern
; Checks frame counter mod 4 for timing projectile spawn
Boss_JetsripperFrameCheck:                              ; CODE XREF: Boss_JetsripperFallAndFirePattern   p  ; was: sub_3106A
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_30BB8
; End of function Boss_JetsripperFrameCheck
; Updates boss part palette cycle
Enemy_Stage11BossPartUpdatePalette:                     ; CODE XREF: Enemy_Stage11BossPartState1+E   p  ; was: sub_31076
                move.w  $40(a5),d0
                addq.w  #2,d0
                cmpi.w  #6,d0
                bcs.s   loc_31084
                clr.w   d0
loc_31084:                                              ; CODE XREF: Enemy_Stage11BossPartUpdatePalette+A   j
                move.w  d0,$40(a5)
                move.w  word_31090(pc,d0.w),$E(a5)
                rts
; End of function Enemy_Stage11BossPartUpdatePalette
; ---------------------------------------------------------------------------
word_31090:     dc.w    $2109, $2112, $211B
                                        ; DATA XREF: Enemy_Stage11BossPartUpdatePalette+12   r

; Spawns projectile at random angle after taking damage from specific hit flags
Boss_JetsripperSpawnRandomAngleProjectile:              ; CODE XREF: Boss_JetsripperFallAndFirePattern+4   p  ; was: sub_31096
                bclr    #6,$22(a5)
                bne.s   loc_310A8
                bclr    #7,$22(a5)
                bne.s   loc_310A8
                rts
; ---------------------------------------------------------------------------
loc_310A8:                                              ; CODE XREF: Boss_JetsripperSpawnRandomAngleProjectile+6   j
                                        ; Boss_JetsripperSpawnRandomAngleProjectile+E   j
                jsr     (RandomNumber).l
                andi.w  #$1FE,d0
                move.w  d0,d4
                move.w  $10(a5),d5
                move.w  $14(a5),d6
                jsr     (Enemy_SpawnProjectileAtAngle).l
                jsr     (RandomNumber).l
                andi.w  #$F,d0
                bne.s   loc_310DE
                jsr     (RandomNumber).l
                move.w  #$F,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_310DE:                                              ; CODE XREF: Boss_JetsripperSpawnRandomAngleProjectile+36   j
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperSpawnRandomAngleProjectile
; Main handler for Gusthead eye enemy
