; Updates enemy facing direction to track player
Enemy_FacePlayer:                                       ; CODE XREF: Enemy_MainStateMachine+78   p  ; was: sub_2CF18
                                        ; Enemy_MainStateMachine+1C0   j
                jsr     (Physics_GetPlayerDelta).l
                tst.w   d1
                bpl.s   Enemy_FacePlayer_FaceRight
                bset    #3,$E(a5)
                rts
; ---------------------------------------------------------------------------
Enemy_FacePlayer_FaceRight:                             ; CODE XREF: Enemy_FacePlayer+8   j  ; was: loc_2CF2A
                bclr    #3,$E(a5)
                rts
; End of function Enemy_FacePlayer
; Applies the stored facing direction to a signed horizontal velocity
Enemy_ApplyFacingToHorizontalVelocity:                  ; CODE XREF: Enemy_MainStateMachine+122   p  ; was: sub_2CF32
                btst    #3,$E(a5)
                bne.s   Enemy_ApplyFacingToHorizontalVelocity_Return
                neg.l   $18(a5)
Enemy_ApplyFacingToHorizontalVelocity_Return:           ; CODE XREF: Enemy_ApplyFacingToHorizontalVelocity+6   j  ; was: locret_2CF3E
                rts
; End of function Enemy_ApplyFacingToHorizontalVelocity
; Applies gravity acceleration to vertical velocity with terminal velocity
Enemy_ApplyCappedGravity:                               ; CODE XREF: Enemy_MainStateMachine+138   p  ; was: sub_2CF40
                tst.l   $1C(a5)
                bmi.s   Enemy_ApplyCappedGravity_Accelerate
                cmpi.l  #$7C000,$1C(a5)
                bmi.s   Enemy_ApplyCappedGravity_Accelerate
                move.l  #$7C000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
Enemy_ApplyCappedGravity_Accelerate:                    ; CODE XREF: Enemy_ApplyCappedGravity+4   j  ; was: loc_2CF5A
                                        ; Enemy_ApplyCappedGravity+E   j
                addi.l  #$6000,$1C(a5)
                rts
; End of function Enemy_ApplyCappedGravity
; Updates wall and lower-terrain collision for the current enemy
Enemy_UpdateGroundCollision:                            ; CODE XREF: Enemy_MainStateMachine+34   p  ; was: sub_2CF64
                                        ; sub_2C71E:Enemy_MainStateMachine_UpdateMovement   p
                jsr     (Physics_EntityWallCheck).l
                jmp     Physics_CheckLowerTerrain
; End of function Enemy_UpdateGroundCollision
; Toggles sprite visibility flag
Enemy_ToggleSpriteVisibility:                           ; CODE XREF: Enemy_UpdateBouncingDebrisSpawner   p  ; was: sub_2CF70
                                        ; sub_2DEFE   p
                move.w  (FrameCounter).w,d0
                andi.w  #1,d0
                beq.s   Enemy_ToggleSpriteVisibility_Set
                andi.w  #$7FFF,2(a5)
                rts
; ---------------------------------------------------------------------------
Enemy_ToggleSpriteVisibility_Set:                       ; CODE XREF: Enemy_ToggleSpriteVisibility+8   j  ; was: loc_2CF82
                ori.w   #$8000,2(a5)
                rts
; End of function Enemy_ToggleSpriteVisibility
; Initializes sprite and collision parameters for the phase enemy
Enemy_SetupPhasePatternSprite:                          ; CODE XREF: Enemy_PhasePatternInit+2   p  ; was: sub_2CF8A
                move.w  #$EF00,2(a5)
                move.w  (word_FF8276).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                btst    #7,$5F(a5)
                beq.s   Enemy_SetupPhasePatternSprite_ApplyAttributes
                bclr    #4,$E(a5)
Enemy_SetupPhasePatternSprite_ApplyAttributes:          ; CODE XREF: Enemy_SetupPhasePatternSprite+18   j  ; was: loc_2CFAA
                move.b  #$48,$20(a5)                    ; 'H'
                move.b  #$C0,$21(a5)
                move.b  #5,$23(a5)
                move.l  #$E020E818,$2C(a5)
                move.l  #$E020E818,$28(a5)
                lea     Enemy_PhasePatternSpriteParameters(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_SetupPhasePatternSprite
; ---------------------------------------------------------------------------
Enemy_PhasePatternSpriteParameters: dc.w    $1864, $1100  ; DATA XREF: Enemy_SetupPhasePatternSprite+42   o  ; was: word_2CFEC

; Sets animation pointer from table based on $5C value, clears animation frame counter
Enemy_UpdatePhasePatternAnimation:                      ; CODE XREF: Enemy_PhasePatternController+22   j  ; was: sub_2CFF0
                move.w  $5C(a5),d0
                beq.s   Enemy_UpdatePhasePatternAnimation_Return
                subq.w  #4,d0
                move.l  Enemy_PhasePatternAnimationMappings(pc,d0.w),8(a5)
                clr.w   $C(a5)
Enemy_UpdatePhasePatternAnimation_Return:               ; CODE XREF: Enemy_UpdatePhasePatternAnimation+4   j  ; was: locret_2D002
                rts
; End of function Enemy_UpdatePhasePatternAnimation
; ---------------------------------------------------------------------------
Enemy_PhasePatternAnimationMappings:    dc.l    Enemy_PhasePatternSelector04Animation  ; DATA XREF: Enemy_UpdatePhasePatternAnimation+8   r  ; was: off_2D004
                dc.l    Enemy_PhasePatternSelector08Animation
                dc.l    Enemy_PhasePatternSelector0CAnimation
                dc.l    Enemy_PhasePatternSelector10Animation
                dc.l    Enemy_PhasePatternSelector14Animation
                dc.l    Enemy_PhasePatternSelector18Animation
                dc.l    Enemy_PhasePatternSelector1CAnimation
