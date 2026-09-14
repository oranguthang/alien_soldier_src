Enemy_PhasePatternController:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2D020
                tst.w   4(a5)
                beq.s   Enemy_PhasePatternController_UpdateState
                tst.w   $24(a5)
                bmi.w   Enemy_ResetPhasePattern
                tst.w   (StageSpawnCountdown).w
                bpl.w   Enemy_ResetPhasePattern
                jsr     (RandomNumber).l
                clr.w   6(a5)
Enemy_PhasePatternController_UpdateState:               ; CODE XREF: Enemy_PhasePatternController+4   j  ; was: loc_2D040
                bsr.s   Enemy_DispatchPhasePatternState
                bra.w   Enemy_ApplyPhasePatternAnimationSelector
; End of function Enemy_PhasePatternController
; Dispatches the phase-pattern enemy's current state
Enemy_DispatchPhasePatternState:                        ; CODE XREF: Enemy_PhasePatternController:Enemy_PhasePatternController_UpdateState   p  ; was: sub_2D046
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     Enemy_PhasePatternStateOffsets(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_DispatchPhasePatternState
; ---------------------------------------------------------------------------
Enemy_PhasePatternStateOffsets: dc.w    Enemy_PhasePatternInit-*  ; DATA XREF: Enemy_DispatchPhasePatternState+8   o  ; was: off_2D056
                dc.w    Enemy_PhasePatternWaitState-*
                dc.w    Enemy_PhasePatternAirborneState-*
                dc.w    Enemy_PhasePattern_WaitBeforeAttack-*
                dc.w    Enemy_PhasePattern_BeginHorizontalMotion-*
                dc.w    Enemy_PhasePattern_StopHorizontalMotion-*
                dc.w    Enemy_PhasePattern_Restart-*

; Initializes the phase-pattern sprite and first wait interval
Enemy_PhasePatternInit:                                 ; DATA XREF: ROM:Enemy_PhasePatternStateOffsets   o  ; was: sub_2D064
                moveq   #0,d0
                bsr.w   Enemy_SetupPhasePatternSprite
                move.w  #4,$5C(a5)
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
; Wait for timer countdown and check for movement trigger
Enemy_PhasePatternWaitState:                            ; DATA XREF: ROM:0002D058   o  ; was: loc_2D07A
                subq.w  #1,$48(a5)
                beq.s   Enemy_PhasePatternWaitState_Timeout
                btst    #5,(ControllerPressedState).w
                beq.s   Enemy_PhasePatternWaitState_Return
                addq.w  #2,4(a5)
                btst    #4,$E(a5)
                bne.s   Enemy_PhasePatternWaitState_Return
                move.l  #$FFFA0000,$1C(a5)
Enemy_PhasePatternWaitState_Return:                     ; CODE XREF: Enemy_PhasePatternInit+22   j  ; was: locret_2D09C
                                        ; Enemy_PhasePatternInit+2E   j
                rts
; ---------------------------------------------------------------------------
Enemy_PhasePatternWaitState_Timeout:                    ; CODE XREF: Enemy_PhasePatternInit+1A   j  ; was: loc_2D09E
                move.w  #$20,$48(a5)                    ; ' '
                move.w  #6,4(a5)
                move.w  #$10,$5C(a5)
                rts
; End of function Enemy_PhasePatternInit
; Applies gravity and returns the phase-pattern enemy to a surface on contact
Enemy_PhasePatternAirborneState:                        ; DATA XREF: ROM:0002D05A   o  ; was: sub_2D0B2
                cmpi.l  #$80000,$1C(a5)
                bge.s   Enemy_PhasePatternAirborneState_SelectProbe
                addi.l  #$4000,$1C(a5)
Enemy_PhasePatternAirborneState_SelectProbe:            ; CODE XREF: Enemy_PhasePatternAirborneState+8   j  ; was: loc_2D0C4
                moveq   #0,d0
                tst.l   $1C(a5)
                bmi.s   Enemy_PhasePatternAirborneState_ProbeCeiling
                move.w  #$20,d1                         ; ' '
                bra.s   Enemy_PhasePatternAirborneState_CheckTerrain
; ---------------------------------------------------------------------------
Enemy_PhasePatternAirborneState_ProbeCeiling:           ; CODE XREF: Enemy_PhasePatternAirborneState+18   j  ; was: loc_2D0D2
                move.w  #$FFE4,d1
Enemy_PhasePatternAirborneState_CheckTerrain:           ; CODE XREF: Enemy_PhasePatternAirborneState+1E   j  ; was: loc_2D0D6
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                beq.s   Enemy_PhasePatternAirborneState_Return
                move.w  #2,4(a5)
                move.w  #4,(PlaneAShakeLevel).w
                move.w  #4,(PlaneBShakeLevel).w
                tst.l   $1C(a5)
                bmi.s   Enemy_PhasePatternAirborneState_AlignCeiling
                bclr    #4,$E(a5)
                moveq   #0,d0
                move.w  #$20,d1                         ; ' '
                jsr     (Physics_AlignToTerrain).l
                rts
; ---------------------------------------------------------------------------
Enemy_PhasePatternAirborneState_AlignCeiling:           ; CODE XREF: Enemy_PhasePatternAirborneState+44   j  ; was: loc_2D10C
                bset    #4,$E(a5)
                moveq   #0,d0
                move.w  #$FFE4,d1
                jsr     (Physics_AlignToTerrainTop).l
Enemy_PhasePatternAirborneState_Return:                 ; CODE XREF: Enemy_PhasePatternAirborneState+2C   j  ; was: locret_2D11E
                rts
; End of function Enemy_PhasePatternAirborneState
; Decrements timer, when zero sets $5C=$14, resets timer=$20, advances state
Enemy_PhasePattern_WaitBeforeAttack:                    ; DATA XREF: ROM:0002D05C   o  ; was: sub_2D120
                subq.w  #1,$48(a5)
                bne.s   Enemy_PhasePattern_WaitBeforeAttack_Return
                move.w  #$14,$5C(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
Enemy_PhasePattern_WaitBeforeAttack_Return:             ; CODE XREF: Enemy_PhasePattern_WaitBeforeAttack+4   j  ; was: locret_2D136
                rts
; End of function Enemy_PhasePattern_WaitBeforeAttack
; Decrements timer, when zero sets $5C=$1C, velocity=$FFFF, timer=$20, advances state
Enemy_PhasePattern_BeginHorizontalMotion:               ; DATA XREF: ROM:0002D05E   o  ; was: sub_2D138
                subq.w  #1,$48(a5)
                bne.s   Enemy_PhasePattern_BeginHorizontalMotion_Return
                move.w  #$1C,$5C(a5)
                move.w  #$FFFF,$18(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
Enemy_PhasePattern_BeginHorizontalMotion_Return:        ; CODE XREF: Enemy_PhasePattern_BeginHorizontalMotion+4   j  ; was: locret_2D154
                rts
; End of function Enemy_PhasePattern_BeginHorizontalMotion
; Decrements timer, when zero clears velocity, sets $5C=$18, timer=$20, advances state
Enemy_PhasePattern_StopHorizontalMotion:                ; DATA XREF: ROM:0002D060   o  ; was: sub_2D156
                subq.w  #1,$48(a5)
                bne.s   Enemy_PhasePattern_StopHorizontalMotion_Return
                clr.w   $18(a5)
                move.w  #$18,$5C(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
Enemy_PhasePattern_StopHorizontalMotion_Return:         ; CODE XREF: Enemy_PhasePattern_StopHorizontalMotion+4   j  ; was: locret_2D170
                rts
; End of function Enemy_PhasePattern_StopHorizontalMotion
; Decrements timer, when zero sets timer=$100, $5C=4, state=2
Enemy_PhasePattern_Restart:                             ; DATA XREF: ROM:0002D062   o  ; was: sub_2D172
                subq.w  #1,$48(a5)
                bne.s   Enemy_PhasePattern_Restart_Return
                move.w  #$100,$48(a5)
                move.w  #4,$5C(a5)
                move.w  #2,4(a5)
Enemy_PhasePattern_Restart_Return:                      ; CODE XREF: Enemy_PhasePattern_Restart+4   j  ; was: locret_2D18A
                rts
; End of function Enemy_PhasePattern_Restart
; Resets state to 0, sets ID $290, timer $40, clears velocity and flags
Enemy_ResetPhasePattern:                                ; CODE XREF: Enemy_PhasePatternController+A   j  ; was: sub_2D18C
                                        ; Enemy_PhasePatternController+12   j
                clr.w   4(a5)
                move.w  #$290,(a5)
                move.w  #$40,$48(a5)                    ; '@'
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                clr.l   $18(a5)
                rts
; End of function Enemy_ResetPhasePattern
; Updates the bouncing defeat-debris object and emits randomized child particles
Enemy_UpdateBouncingDebrisSpawner:                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2D1AC
                bsr.w   Enemy_UpdateBlinkVisibility
                tst.l   $1C(a5)
                beq.s   Enemy_UpdateBouncingDebrisSpawner_SpawnParticle
                cmpi.l  #$80000,$1C(a5)
                bge.s   Enemy_UpdateBouncingDebrisSpawner_ApplyGravity
                addi.l  #$4000,$1C(a5)
Enemy_UpdateBouncingDebrisSpawner_ApplyGravity:         ; CODE XREF: Enemy_UpdateBouncingDebrisSpawner+12   j  ; was: loc_2D1C8
                moveq   #0,d0
                move.w  #$20,d1                         ; ' '
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                beq.s   Enemy_UpdateBouncingDebrisSpawner_SpawnParticle
                bclr    #4,$E(a5)
                moveq   #0,d0
                move.w  #$20,d1                         ; ' '
                jsr     (Physics_AlignToTerrain).l
Enemy_UpdateBouncingDebrisSpawner_SpawnParticle:        ; CODE XREF: Enemy_UpdateBouncingDebrisSpawner+8   j  ; was: loc_2D1EA
                                        ; Enemy_UpdateBouncingDebrisSpawner+2A   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Enemy_UpdateBouncingDebrisSpawner_Return
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.s   Enemy_UpdateBouncingDebrisSpawner_InitParticle
                move.b  #$BB,d0
                jsr     (Sound_QueueSFXRequest).l
Enemy_UpdateBouncingDebrisSpawner_InitParticle:         ; CODE XREF: Enemy_UpdateBouncingDebrisSpawner+4E   j  ; was: loc_2D206
                bsr.s   Effect_SetRandomParticleMapping
                jsr     (Projectile_InitType88).l
                move.b  (RandomNumberState).w,d0
                andi.w  #$3F,d0                         ; '?'
                subi.w  #$20,d0                         ; ' '
                move.w  $10(a5),$10(a0)
                add.w   d0,$10(a0)
                move.b  (RandomNumberState+1).w,d0
                andi.w  #$3F,d0                         ; '?'
                subi.w  #$20,d0                         ; ' '
                move.w  $14(a5),$14(a0)
                add.w   d0,$14(a0)
                move.w  #$FFFE,$1C(a0)
                subq.w  #1,$48(a5)
                bne.s   Enemy_UpdateBouncingDebrisSpawner_Return
                jsr     (Effect_SpawnExplosionB).l
                moveq   #3,d0
                jmp     Pickup_SpawnRandomFromCurrentObject
; ---------------------------------------------------------------------------
Enemy_UpdateBouncingDebrisSpawner_Return:               ; CODE XREF: Enemy_UpdateBouncingDebrisSpawner+44   j  ; was: locret_2D254
                                        ; Enemy_UpdateBouncingDebrisSpawner+98   j
                rts
; End of function Enemy_UpdateBouncingDebrisSpawner
; Selects a randomized particle mapping for the current object
Effect_SetRandomParticleMappingFromCurrentObject:
                movea.w a5,a0                           ; was: sub_2D256
; End of function Effect_SetRandomParticleMappingFromCurrentObject
; Sets random animation pointer from 4-entry table based on random number bits 0-1
Effect_SetRandomParticleMapping:                        ; CODE XREF: Enemy_UpdateBouncingDebrisSpawner:Enemy_UpdateBouncingDebrisSpawner_InitParticle   p  ; was: sub_2D258
                move.w  (RandomNumberState).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  Effect_RandomParticleMappings(pc,d0.w),8(a0)
                rts
; End of function Effect_SetRandomParticleMapping
; ---------------------------------------------------------------------------
Effect_RandomParticleMappings:  dc.l    SharedCombatSpriteAnimation00  ; DATA XREF: Effect_SetRandomParticleMapping+C   r  ; was: off_2D26C
                dc.l    SharedCombatSpriteAnimation01
                dc.l    SharedCombatSpriteAnimation02
                dc.l    SharedCombatSpriteAnimation01
