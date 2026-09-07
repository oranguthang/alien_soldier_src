Enemy_BehaviorController:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C6A8
                tst.w   4(a5)
                beq.s   Enemy_DispatchBehaviorState
                tst.w   $24(a5)
                bmi.w   Boss_FireProjectilePattern
                tst.w   (word_FF808C).w
                bpl.w   Boss_FireProjectilePattern
                btst    #7,$22(a5)
                beq.s   loc_2C6D8
                btst    #4,$22(a5)
                bne.s   loc_2C6D8
                bsr.w   Boss_FireProjectilePattern
                addq.w  #1,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C6D8:                                              ; CODE XREF: Enemy_BehaviorController+1C   j
                                        ; Enemy_BehaviorController+24   j
                cmpi.w  #$FF00,$5A(a5)
                bmi.w   Boss_FireProjectilePattern
                subq.w  #1,$5A(a5)
                bpl.s   loc_2C6EE
                move.w  #$13,$5E(a5)
loc_2C6EE:                                              ; CODE XREF: Enemy_BehaviorController+3E   j
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Dispatches enemy to behavior state handler and updates animation
Enemy_DispatchBehaviorState:                            ; CODE XREF: Enemy_BehaviorController+4   j  ; was: loc_2C6F8
                bsr.s   Enemy_StateDispatcher
                bra.w   Anim_UpdateAnimationState
; End of function Enemy_BehaviorController
; Dispatches enemy to appropriate state handler
Enemy_StateDispatcher:                                  ; CODE XREF: Enemy_BehaviorController:loc_2C6F8   p  ; was: sub_2C6FE
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2C712(pc,d0.w),a0
                adda.l  #Enemy_MainStateMachine,a0
                jmp     (a0)
; End of function Enemy_StateDispatcher
; ---------------------------------------------------------------------------
off_2C712:      dc.w    Enemy_MainStateMachine-Enemy_MainStateMachine
                                        ; DATA XREF: Enemy_StateDispatcher+8   r
                dc.w    Enemy_MainStateMachine_UpdateState-Enemy_MainStateMachine
                dc.w    Enemy_ExecuteMovementPattern-Enemy_MainStateMachine
                dc.w    Enemy_MainStateMachine_TerrainCheck-Enemy_MainStateMachine
                dc.w    Enemy_MainStateMachine_GroundedTimer-Enemy_MainStateMachine
                dc.w    Enemy_MainStateMachine_AttackCooldown-Enemy_MainStateMachine

; Main enemy state machine with movement and attack patterns
Enemy_MainStateMachine:                                 ; DATA XREF: Enemy_StateDispatcher+C   o  ; was: sub_2C71E
                                        ; ROM:off_2C712   o
                moveq   #0,d0
                bsr.w   Sprite_SetupBossSprite
loc_2C724:                                              ; CODE XREF: Enemy_MainStateMachine+B6   j
                                        ; Enemy_MainStateMachine+198   j
                btst    #0,$5F(a5)
                bne.w   loc_2C78C
                move.w  #2,4(a5)
                move.w  #4,$5C(a5)
                move.w  (dword_FFFF08).w,d1
                andi.w  #$3F,d1                         ; '?'
                addi.w  #8,d1
                move.w  d1,$48(a5)
; Main enemy AI state machine update loop
Enemy_MainStateMachine_UpdateState:                     ; DATA XREF: ROM:0002C714   o  ; was: loc_2C74A
                subq.w  #1,$48(a5)
                bmi.w   loc_2C78C
                bsr.w   Player_UpdatePhysics
                btst    #0,6(a5)
                beq.w   loc_2C81C
                bsr.w   Physics_DecelerateHorizontal
loc_2C764:                                              ; CODE XREF: Enemy_MainStateMachine+FA   j
                jsr     (Physics_CalculateDistanceTo).l
                cmpi.w  #$78,d0                         ; 'x'
                bpl.s   loc_2C77A
                btst    #2,$5F(a5)
                bne.w   loc_2C8A0
loc_2C77A:                                              ; CODE XREF: Enemy_MainStateMachine+50   j
                cmpi.w  #$50,d0                         ; 'P'
                bpl.s   locret_2C78A
                btst    #3,$5F(a5)
                bne.w   loc_2C830
locret_2C78A:                                           ; CODE XREF: Enemy_MainStateMachine+60   j
                rts
; ---------------------------------------------------------------------------
loc_2C78C:                                              ; CODE XREF: Enemy_MainStateMachine+C   j
                                        ; Enemy_MainStateMachine+30   j
                btst    #4,$5F(a5)
                bne.w   loc_2C79E
                bsr.w   Enemy_FacePlayer
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_2C79E:                                              ; CODE XREF: Enemy_MainStateMachine+74   j
                                        ; Enemy_MainStateMachine+7C   j
                move.w  #4,4(a5)
                move.w  #8,$5C(a5)
                move.w  (dword_FFFF08).w,d1
                andi.w  #$7F,d1
                addi.w  #$80,d1
                move.w  d1,$48(a5)
                tst.w   $5A(a5)
                bpl.s   Enemy_ExecuteMovementPattern
                bset    #3,$E(a5)
; Executes enemy movement pattern with terrain collision checks
Enemy_ExecuteMovementPattern:                           ; CODE XREF: Enemy_MainStateMachine+A0   j  ; was: loc_2C7C6
                                        ; DATA XREF: ROM:0002C716   o
                btst    #0,$5F(a5)
                bne.w   loc_2C7D8
                subq.w  #1,$48(a5)
                bmi.w   loc_2C724
loc_2C7D8:                                              ; CODE XREF: Enemy_MainStateMachine+AE   j
                bsr.w   Player_UpdatePhysics
                btst    #0,6(a5)
                beq.w   loc_2C81C
                btst    #3,$E(a5)
                bne.s   loc_2C7F8
                btst    #1,7(a5)
                beq.s   loc_2C814
                bra.s   loc_2C800
; ---------------------------------------------------------------------------
loc_2C7F8:                                              ; CODE XREF: Enemy_MainStateMachine+CE   j
                btst    #0,7(a5)
                beq.s   loc_2C814
loc_2C800:                                              ; CODE XREF: Enemy_MainStateMachine+D8   j
                btst    #1,$5F(a5)
                bne.w   loc_2C830
                eori.w  #$800,$E(a5)
                clr.l   $18(a5)
loc_2C814:                                              ; CODE XREF: Enemy_MainStateMachine+D6   j
                                        ; Enemy_MainStateMachine+E0   j
                bsr.w   Physics_AccelerateHorizontal
                bra.w   loc_2C764
; ---------------------------------------------------------------------------
loc_2C81C:                                              ; CODE XREF: Enemy_MainStateMachine+3E   j
                                        ; Enemy_MainStateMachine+C4   j
                move.l  #$FFFEE000,$1C(a5)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                bra.s   loc_2C844
; ---------------------------------------------------------------------------
loc_2C830:                                              ; CODE XREF: Enemy_MainStateMachine+68   j
                                        ; Enemy_MainStateMachine+E8   j
                move.l  #$FFFA8000,$1C(a5)
                move.l  #$FFFE8000,$18(a5)
                bsr.w   Physics_NegateVelocityIfFacingLeft
loc_2C844:                                              ; CODE XREF: Enemy_MainStateMachine+110   j
                move.w  #6,4(a5)
                move.w  #$14,$5C(a5)
; Performs terrain collision check in enemy state machine
Enemy_MainStateMachine_TerrainCheck:                    ; DATA XREF: ROM:0002C718   o  ; was: loc_2C850
                jsr     (Physics_BossTerrainCheck).l
                bsr.w   Physics_AccelerateGravity
                bmi.s   loc_2C86E
                jsr     (Player_CheckTerrainCollision).l
                btst    #0,6(a5)
                bne.w   loc_2C874
                rts
; ---------------------------------------------------------------------------
loc_2C86E:                                              ; CODE XREF: Enemy_MainStateMachine+13C   j
                jmp     Physics_TerrainCheckWithVelocity
; ---------------------------------------------------------------------------
loc_2C874:                                              ; CODE XREF: Enemy_MainStateMachine+14A   j
                move.w  #8,4(a5)
                move.w  #$C,$5C(a5)
                move.w  #$14,$48(a5)
; Handles grounded state timer for enemy
Enemy_MainStateMachine_GroundedTimer:                   ; DATA XREF: ROM:0002C71A   o  ; was: loc_2C886
                subq.w  #1,$48(a5)
                bmi.w   loc_2C78C
                bsr.w   Player_UpdatePhysics
                btst    #0,6(a5)
                beq.w   loc_2C81C
                bra.w   Physics_DecelerateHorizontal
; ---------------------------------------------------------------------------
loc_2C8A0:                                              ; CODE XREF: Enemy_MainStateMachine+58   j
                move.w  #$A,4(a5)
                move.w  #$10,$5C(a5)
                move.w  #$36,$48(a5)                    ; '6'
; Decrements attack timer and branches to attack init or face player timing
Enemy_MainStateMachine_AttackCooldown:                  ; DATA XREF: ROM:0002C71C   o  ; was: loc_2C8B2
                subq.w  #1,$48(a5)
                bmi.w   loc_2C724
                bsr.w   Player_UpdatePhysics
                btst    #0,6(a5)
                beq.w   loc_2C81C
                bsr.w   Physics_DecelerateHorizontal
                cmpi.w  #$1E,$48(a5)
                bne.s   Enemy_CheckFacePlayerTiming
                bra.w   Enemy_InitTrackedProjectile
; ---------------------------------------------------------------------------
; Checks if it's time to face player direction during movement
Enemy_CheckFacePlayerTiming:                            ; CODE XREF: Enemy_MainStateMachine+1B4   j  ; was: loc_2C8D8
                cmpi.w  #$10,$48(a5)
                bpl.w   Enemy_FacePlayer
                rts
; End of function Enemy_MainStateMachine
; Wrapper calling visibility check and animation update
Enemy_AnimationWrapper:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C8E4
                bsr.s   Enemy_CheckBoundsVisibility
                bra.w   Anim_UpdateAnimationState
; End of function Enemy_AnimationWrapper
; Checks if enemy is within visible screen bounds
Enemy_CheckBoundsVisibility:                            ; CODE XREF: Enemy_AnimationWrapper   p  ; was: sub_2C8EA
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2C8FE(pc,d0.w),a0
                adda.l  #Enemy_DestroyIfOffscreen,a0
                jmp     (a0)
; End of function Enemy_CheckBoundsVisibility
; ---------------------------------------------------------------------------
off_2C8FE:      dc.w    Enemy_DestroyIfOffscreen-Enemy_DestroyIfOffscreen
                                        ; DATA XREF: Enemy_CheckBoundsVisibility+8   r
                dc.w    Boss_SetupDestructionState-Enemy_DestroyIfOffscreen

; Marks enemy for destruction if beyond screen bounds
Enemy_DestroyIfOffscreen:                               ; DATA XREF: Enemy_CheckBoundsVisibility+C   o  ; was: sub_2C902
                                        ; ROM:off_2C8FE   o
                addq.w  #2,4(a5)
                moveq   #0,d0
                bsr.w   Sprite_SetupBossSprite
                move.w  #$24,$48(a5)                    ; '$'
                clr.b   $21(a5)
                move.b  #$7C,$20(a5)                    ; '|'
                move.w  #4,$5C(a5)
                bclr    #7,$E(a5)
; Sets up boss destruction state with timer and animation
Boss_SetupDestructionState:                             ; DATA XREF: ROM:0002C900   o  ; was: loc_2C928
                subq.w  #1,$48(a5)
                bpl.s   locret_2C938
                move.w  #$1C,(a5)
                moveq   #0,d0
                bsr.w   Sprite_SetupBossSprite
locret_2C938:                                           ; CODE XREF: Enemy_DestroyIfOffscreen+2A   j
                rts
; End of function Enemy_DestroyIfOffscreen
; Initializes sprite properties for enemy object
Sprite_InitializeEnemySprite:                           ; CODE XREF: Enemy_InitializeWithHealth+6   p  ; was: sub_2C93A
                move.w  #$E300,2(a5)
                move.w  (word_FF8270).w,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.b  #$48,$20(a5)                    ; 'H'
                move.b  #$C0,$21(a5)
                move.w  #$2A,$26(a5)                    ; '*'
                move.l  #$E818F010,$2C(a5)
                move.l  #$E21EE818,$28(a5)
                rts
; End of function Sprite_InitializeEnemySprite
; Updates enemy animation frame based on state
Anim_UpdateEnemyAnimation:                              ; CODE XREF: Enemy_ProcessObject+20   j  ; was: sub_2C970
                move.w  $5C(a5),d0
                beq.s   locret_2C982
                subq.w  #4,d0
                move.l  off_2C984(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2C982:                                           ; CODE XREF: Anim_UpdateEnemyAnimation+4   j
                rts
; End of function Anim_UpdateEnemyAnimation
; ---------------------------------------------------------------------------
off_2C984:      dc.l    off_EA00E                       ; DATA XREF: Anim_UpdateEnemyAnimation+8   r
                dc.l    off_EA04A
                dc.l    off_EA036

; Main processing routine for enemy object
Enemy_ProcessObject:                                    ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C990
                tst.b   $21(a5)
                beq.s   Enemy_RunBehaviorHandler
                clr.w   6(a5)
                tst.w   $24(a5)
                bpl.s   Enemy_RunBehaviorHandler
                jsr     (Projectile_ExplodeOnImpact).l
                moveq   #3,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
; Runs enemy behavior state handler and updates animation
Enemy_RunBehaviorHandler:                               ; CODE XREF: Enemy_ProcessObject+4   j  ; was: loc_2C9AE
                                        ; Enemy_ProcessObject+E   j
                bsr.s   Enemy_RunStateHandler
                bra.w   Anim_UpdateEnemyAnimation
; End of function Enemy_ProcessObject
; Executes current enemy state handler
Enemy_RunStateHandler:                                  ; CODE XREF: Enemy_ProcessObject:loc_2C9AE   p  ; was: sub_2C9B4
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2C9C8(pc,d0.w),a0
                adda.l  #Enemy_InitializeWithHealth,a0
                jmp     (a0)
; End of function Enemy_RunStateHandler
; ---------------------------------------------------------------------------
off_2C9C8:      dc.w    Enemy_InitializeWithHealth-Enemy_InitializeWithHealth
                                        ; DATA XREF: Enemy_RunStateHandler+8   r
                dc.w    Enemy_InitializeWaitState-Enemy_InitializeWithHealth
                dc.w    Boss_DeathSequence-Enemy_InitializeWithHealth
                dc.w    Boss_SpawnPeriodicShots-Enemy_InitializeWithHealth

; Initializes enemy with health value and sprite setup
Enemy_InitializeWithHealth:                             ; DATA XREF: Enemy_RunStateHandler+C   o  ; was: sub_2C9D0
                                        ; ROM:off_2C9C8   o
                move.w  #$62,$24(a5)                    ; 'b'
                bsr.w   Sprite_InitializeEnemySprite
                clr.w   $48(a5)
loc_2C9DE:                                              ; CODE XREF: Boss_SpawnPeriodicShots+C   j
                move.w  #2,4(a5)
                move.w  #4,$5C(a5)
; Initializes enemy waiting state with timer values
Enemy_InitializeWaitState:                              ; DATA XREF: ROM:0002C9CA   o  ; was: loc_2C9EA
                subq.w  #1,$48(a5)
                bpl.s   locret_2CA00
                addq.w  #2,4(a5)
                move.w  #$28,$48(a5)                    ; '('
                move.w  #8,$5C(a5)
locret_2CA00:                                           ; CODE XREF: Enemy_InitializeWithHealth+1E   j
                rts
; End of function Enemy_InitializeWithHealth
; Handles Jetsripper boss death animation and cleanup
Boss_DeathSequence:                                     ; DATA XREF: ROM:0002C9CC   o  ; was: sub_2CA02
                subq.w  #1,$48(a5)
                bpl.s   locret_2CA18
                addq.w  #2,4(a5)
                move.w  #$180,$48(a5)
                move.w  #$C,$5C(a5)
locret_2CA18:                                           ; CODE XREF: Boss_DeathSequence+4   j
                rts
; End of function Boss_DeathSequence
; Boss spawns periodic projectiles based on timer countdown
Boss_SpawnPeriodicShots:                                ; DATA XREF: ROM:0002C9CE   o  ; was: sub_2CA1A
                subq.w  #1,$48(a5)
                bpl.s   Boss_SpawnPeriodicShot
                move.w  #$120,$48(a5)
                bra.w   loc_2C9DE
; ---------------------------------------------------------------------------
; Spawns periodic shot at regular intervals during boss pattern
Boss_SpawnPeriodicShot:                                 ; CODE XREF: Boss_SpawnPeriodicShots+4   j  ; was: loc_2CA2A
                move.w  $48(a5),d0
                andi.w  #$1F,d0
                bne.s   locret_2CA3E
                moveq   #0,d5
                moveq   #$FFFFFFF0,d6
                jsr     (Boss_SpawnTargetedProjectile).l
locret_2CA3E:                                           ; CODE XREF: Boss_SpawnPeriodicShots+18   j
                rts
; End of function Boss_SpawnPeriodicShots
; Initializes sprite properties for projectile object
Sprite_InitializeProjectileSprite:                      ; CODE XREF: Enemy_ProjectileStateMachine+6   p  ; was: sub_2CA40
                                        ; Enemy_AltProjectileStateMachine+6   p
                move.w  #$EF00,2(a5)
                move.w  (word_FF8272).w,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.b  #$48,$20(a5)                    ; 'H'
                move.b  #$C0,$21(a5)
                move.b  #8,$23(a5)
                move.w  #$F,$26(a5)
                move.l  #$F010F808,$2C(a5)
                move.l  #$E420F010,$28(a5)
                rts
; End of function Sprite_InitializeProjectileSprite
; Updates projectile animation frame
Anim_UpdateProjectileAnimation:                         ; CODE XREF: Enemy_ProcessProjectile+16   j  ; was: sub_2CA7C
                                        ; Enemy_ProcessAltProjectile+14   j
                move.w  $5C(a5),d0
                beq.s   locret_2CA8E
                subq.w  #4,d0
                move.l  off_2CA90(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2CA8E:                                           ; CODE XREF: Anim_UpdateProjectileAnimation+4   j
                rts
; End of function Anim_UpdateProjectileAnimation
; ---------------------------------------------------------------------------
off_2CA90:      dc.l    off_EA5DC                       ; DATA XREF: Anim_UpdateProjectileAnimation+8   r
                dc.l    off_EA5B8
                dc.l    off_EA5F8
                dc.l    off_EA61C
                dc.l    off_EA634
                dc.l    off_EA64C
                dc.l    off_EA664
                dc.l    off_EA67C
                dc.l    off_EA69C
                dc.l    off_EA6A8

; Sets horizontal velocity based on entity flip direction
Physics_SetHorizontalVelocityByFlip:                    ; CODE XREF: Enemy_ProjectileStateMachine+9E   j  ; was: sub_2CAB8
                                        ; Enemy_ProjectileStateMachine+B6   p
                btst    #3,$E(a5)
                bne.s   loc_2CACA
                move.l  #$30000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2CACA:                                              ; CODE XREF: Physics_SetHorizontalVelocityByFlip+6   j
                move.l  #$FFFD0000,$18(a5)
                rts
; End of function Physics_SetHorizontalVelocityByFlip
; Applies friction to horizontal velocity by decrementing/incrementing by $4000 toward zero
Physics_ApplyHorizontalFriction:                        ; CODE XREF: Enemy_ProjectileStateMachine:loc_2CC8C   j  ; was: sub_2CAD4
                                        ; sub_2CD54:loc_2CD96   p
                move.l  $18(a5),d0
                beq.s   locret_2CAEE
                bmi.s   loc_2CAF0
                cmpi.l  #$4000,d0
                bmi.s   loc_2CB04
                subi.l  #$4000,d0
                move.l  d0,$18(a5)
locret_2CAEE:                                           ; CODE XREF: Physics_ApplyHorizontalFriction+4   j
                rts
; ---------------------------------------------------------------------------
loc_2CAF0:                                              ; CODE XREF: Physics_ApplyHorizontalFriction+6   j
                cmpi.l  #$FFFFC000,d0
                bpl.s   loc_2CB04
                addi.l  #$4000,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2CB04:                                              ; CODE XREF: Physics_ApplyHorizontalFriction+E   j
                                        ; Physics_ApplyHorizontalFriction+22   j
                clr.l   $18(a5)
                rts
; End of function Physics_ApplyHorizontalFriction
; Calculates appropriate sprite and offsets based on angle to player
Enemy_CalculateDirectionalSprite:                       ; CODE XREF: Enemy_AltProjectileStateMachine+58   p  ; was: sub_2CB0A
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  d2,d5
                addi.w  #$20,d5                         ; ' '
                lsr.w   #4,d5
                andi.w  #$1C,d5
                lea     off_2CB56(pc),a0
                nop
                move.l  (a0,d5.w),d0
                bclr    #3,$E(a5)
                bclr    #0,d0
                beq.s   Sprite_SetDirectionalAnimation
                bset    #3,$E(a5)
; Sets directional animation sprite based on calculated angle
Sprite_SetDirectionalAnimation:                         ; CODE XREF: Enemy_CalculateDirectionalSprite+26   j  ; was: loc_2CB38
                move.l  d0,8(a5)
                clr.w   $C(a5)
                lea     word_2CB76(pc),a1
                nop
                lsr.w   #1,d5
                move.b  (a1,d5.w),d3
                move.b  1(a1,d5.w),d4
                ext.w   d3
                ext.w   d4
                rts
; End of function Enemy_CalculateDirectionalSprite
; ---------------------------------------------------------------------------
off_2CB56:      dc.l    off_EA61C                       ; DATA XREF: Enemy_CalculateDirectionalSprite+12   o
                dc.l    off_EA664
                dc.l    off_EA634
                dc.l    off_EA664+1
                dc.l    off_EA61C+1
                dc.l    off_EA634+1
                dc.l    off_EA64C
                dc.l    off_EA634
word_2CB76:     dc.w    $12F8, $C06, 0, $F406, $EEF8, $F4E8, $E4, $CE8
                                        ; DATA XREF: Enemy_CalculateDirectionalSprite+36   o

; Jetsripper idle state with hovering animation
