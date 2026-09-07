Enemy_CircleMainHandler:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2D3E8
                tst.w   4(a5)
                beq.s   Enemy_ExecuteCirclePattern
                tst.w   $24(a5)
                bmi.w   Enemy_ResetToIdleState
                bclr    #7,$22(a5)
                bne.w   Enemy_ResetToIdleState
                tst.w   (word_FF808C).w
                bpl.w   Enemy_ResetToIdleState
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Executes circular movement pattern and updates sprite
Enemy_ExecuteCirclePattern:                             ; CODE XREF: Enemy_CircleMainHandler+4   j  ; was: loc_2D412
                bsr.s   Enemy_CircleStateDispatcher
                bra.w   Enemy_UpdateSpritePattern
; End of function Enemy_CircleMainHandler
; Dispatches to circle enemy state handlers
Enemy_CircleStateDispatcher:                            ; CODE XREF: Enemy_CircleMainHandler:loc_2D412   p  ; was: sub_2D418
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2D428(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_CircleStateDispatcher
; ---------------------------------------------------------------------------
off_2D428:      dc.w    Enemy_ApproachPlayerState-*     ; DATA XREF: Enemy_CircleStateDispatcher+8   o
                dc.w    Enemy_ApproachPlayerState_CheckDistance-*
                dc.w    Enemy_CircleAttackState-*
                dc.w    Enemy_DescendAttackState-*
                dc.w    nullsub_62-*

; Approach player until within distance threshold
Enemy_ApproachPlayerState:                              ; DATA XREF: ROM:off_2D428   o  ; was: sub_2D432
                moveq   #0,d0
                bsr.w   Enemy_InitSpriteParams
                move.w  #4,$5C(a5)
                bsr.w   Enemy_CalculateTrajectoryToPlayer
                addq.w  #2,4(a5)
; Calculate distance to player and determine next action
Enemy_ApproachPlayerState_CheckDistance:                ; DATA XREF: ROM:0002D42A   o  ; was: loc_2D446
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$60,d0                         ; '`'
                bcs.s   loc_2D456
                bra.w   Enemy_Stage18ClearAll
; ---------------------------------------------------------------------------
loc_2D456:                                              ; CODE XREF: Enemy_ApproachPlayerState+1E   j
                move.w  #$180,$4C(a5)
                move.w  #$10,$4A(a5)
                move.w  #$10,$48(a5)
                move.w  #$100,$50(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_ApproachPlayerState
; Calculates velocity vector from random angle toward player
Enemy_CalculateTrajectoryToPlayer:                      ; CODE XREF: Enemy_ApproachPlayerState+C   p  ; was: sub_2D474
                move.w  $10(a5),$52(a5)
                move.w  (dword_FFA900).w,d0
                add.w   d0,$52(a5)
                move.w  $14(a5),$54(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                add.w   d0,d0
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d0.w),d1
                move.w  (a1,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                rts
; End of function Enemy_CalculateTrajectoryToPlayer
; Clears all enemies before boss
Enemy_Stage18ClearAll:                                  ; CODE XREF: Enemy_ApproachPlayerState+20   j  ; was: sub_2D4B2
                move.w  $52(a5),d0
                move.b  (dword_FFFF08).w,d7
                andi.w  #$3F,d7                         ; '?'
                subi.w  #$20,d7                         ; ' '
                add.w   d7,d0
                move.w  $10(a5),d1
                add.w   (dword_FFA900).w,d1
                sub.w   d1,d0
                beq.s   loc_2D50A
                tst.w   d0
                bpl.s   loc_2D4F0
                subi.l  #$4000,$18(a5)
                cmpi.l  #$FFFE0000,$18(a5)
                bge.s   loc_2D50A
                move.l  #$FFFE0000,$18(a5)
                bra.s   loc_2D50A
; ---------------------------------------------------------------------------
loc_2D4F0:                                              ; CODE XREF: Enemy_Stage18ClearAll+20   j
                addi.l  #$4000,$18(a5)
                cmpi.l  #$20000,$18(a5)
                ble.s   loc_2D50A
                move.l  #$20000,$18(a5)
loc_2D50A:                                              ; CODE XREF: Enemy_Stage18ClearAll+1C   j
                                        ; Enemy_Stage18ClearAll+32   j
                move.w  $54(a5),d0
                move.b  (dword_FFFF08+1).w,d7
                andi.w  #$3F,d7                         ; '?'
                subi.w  #$20,d7                         ; ' '
                add.w   d7,d0
                sub.w   $14(a5),d0
                beq.s   locret_2D55C
                tst.w   d0
                bpl.s   Physics_ClampVerticalVelocityUp
                subi.l  #$4000,$1C(a5)
                cmpi.l  #$FFFE0000,$1C(a5)
                bge.s   locret_2D55C
                move.l  #$FFFE0000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
; Clamps vertical velocity to maximum upward speed
Physics_ClampVerticalVelocityUp:                        ; CODE XREF: Enemy_Stage18ClearAll+72   j  ; was: loc_2D542
                addi.l  #$4000,$1C(a5)
                cmpi.l  #$20000,$1C(a5)
                ble.s   locret_2D55C
                move.l  #$20000,$1C(a5)
locret_2D55C:                                           ; CODE XREF: Enemy_Stage18ClearAll+6E   j
                                        ; Enemy_Stage18ClearAll+84   j
                rts
; End of function Enemy_Stage18ClearAll
; Circles player with adaptive rotation speed
Enemy_CircleAttackState:                                ; DATA XREF: ROM:0002D42C   o  ; was: sub_2D55E
                move.w  $4A(a5),d0
                add.w   d0,$4C(a5)
                andi.w  #$1FF,$4C(a5)
                bsr.w   Enemy_UpdateRotationSprite
                move.w  #$10,d2
                move.w  #$10,d3
                bsr.w   Enemy_CircularHomingMotion
                subq.w  #1,$48(a5)
                bpl.s   loc_2D5CE
                addq.w  #1,$4E(a5)
                move.w  $4E(a5),d0
                andi.w  #3,d0
                bne.s   loc_2D59E
                move.w  #$10,$4A(a5)
                move.w  #$10,$48(a5)
                bra.s   loc_2D5CE
; ---------------------------------------------------------------------------
loc_2D59E:                                              ; CODE XREF: Enemy_CircleAttackState+30   j
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                move.w  d0,$48(a5)
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  $4C(a5),d0
                sub.w   d2,d0
                andi.w  #$1FF,d0
                cmpi.w  #$100,d0
                bcs.s   loc_2D5C8
                move.w  #8,$4A(a5)
                bra.s   loc_2D5CE
; ---------------------------------------------------------------------------
loc_2D5C8:                                              ; CODE XREF: Enemy_CircleAttackState+60   j
                move.w  #$FFF8,$4A(a5)
loc_2D5CE:                                              ; CODE XREF: Enemy_CircleAttackState+22   j
                                        ; Enemy_CircleAttackState+3E   j
                subq.w  #1,$50(a5)
                beq.s   loc_2D5DE
                cmpi.w  #$140,$14(a5)
                bcc.s   loc_2D5DE
                rts
; ---------------------------------------------------------------------------
loc_2D5DE:                                              ; CODE XREF: Enemy_CircleAttackState+74   j
                                        ; Enemy_CircleAttackState+7C   j
                move.w  #$CF00,2(a5)
                andi.w  #$1F0,$4C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_CircleAttackState
; Descending attack state with rotation sprite update
Enemy_DescendAttackState:                               ; DATA XREF: ROM:0002D42E   o  ; was: sub_2D5F0
                addi.w  #$10,$4C(a5)
                andi.w  #$1FF,$4C(a5)
                bsr.w   Enemy_UpdateRotationSprite
                move.w  #$10,d2
                move.w  #$10,d3
                bsr.w   Enemy_CircularHomingMotion
                cmpi.w  #$1C0,$4C(a5)
                bne.s   locret_2D618
                addq.w  #2,4(a5)
locret_2D618:                                           ; CODE XREF: Enemy_DescendAttackState+22   j
                rts
; End of function Enemy_DescendAttackState
nullsub_62:                                             ; DATA XREF: ROM:0002D430   o
                rts
; End of function nullsub_62

; Resets enemy to idle state clearing velocities
Enemy_ResetToIdleState:                                 ; CODE XREF: Enemy_CircleMainHandler+A   j  ; was: sub_2D61C
                                        ; Enemy_CircleMainHandler+14   j
                clr.w   4(a5)
                move.w  #$2A4,(a5)
                move.w  #$40,$48(a5)                    ; '@'
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; End of function Enemy_ResetToIdleState
; Spawns particle effect only on hard difficulty
Enemy_SpawnParticleHardMode:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2D640
                tst.w   (word_FFFF0E).w
                beq.s   Enemy_SpawnQuadProjectilesHard
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Enemy_SpawnQuadProjectilesHard
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$8004,d2
                jsr     (Enemy_InitDirectionalProjectile).l
; Spawns quad projectiles on hard difficulty mode
Enemy_SpawnQuadProjectilesHard:                         ; CODE XREF: Enemy_SpawnParticleHardMode+4   j  ; was: loc_2D664
                                        ; Enemy_SpawnParticleHardMode+C   j
                jmp     Enemy_SpawnQuadProjectiles
; End of function Enemy_SpawnParticleHardMode
nullsub_63:
                rts
; End of function nullsub_63

; Main fly enemy handler with spawn conditions
