Enemy_InitStage12FloatingSprite:                        ; CODE XREF: Enemy_Stage12FloaterInitState+2   p  ; was: sub_2E2BE
                                        ; Enemy_Stage12LauncherInitState+2   p
                move.w  #$EF00,2(a5)
                moveq   #0,d1
                ori.w   #$8000,d1
                move.w  d1,$E(a5)
                move.b  #$10,$20(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F808F808,$28(a5)
                lea     Enemy_Stage12FloatingSpriteParameters(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_InitStage12FloatingSprite
; ---------------------------------------------------------------------------
Enemy_Stage12FloatingSpriteParameters:  dc.w    $1804, $1100, $1802, $1100  ; was: word_2E304
                                        ; DATA XREF: Enemy_InitStage12FloatingSprite+26   o

; Selects the current floating-enemy animation mapping
Enemy_UpdateStage12FloatingAnimation:                   ; CODE XREF: Enemy_Stage12FloaterController+2C   j  ; was: sub_2E30C
                                        ; Enemy_Stage12LauncherController+2C   j
                move.w  $5C(a5),d0
                beq.s   Enemy_UpdateStage12FloatingAnimation_Return
                subq.w  #4,d0
                move.l  Enemy_Stage12FloatingAnimationMappings(pc,d0.w),8(a5)
                clr.w   $C(a5)
Enemy_UpdateStage12FloatingAnimation_Return:            ; CODE XREF: Enemy_UpdateStage12FloatingAnimation+4   j  ; was: locret_2E31E
                rts
; End of function Enemy_UpdateStage12FloatingAnimation
; ---------------------------------------------------------------------------
Enemy_Stage12FloatingAnimationMappings: dc.l    SharedFloaterDebrisProjectileAlternating5And4Animation  ; DATA XREF: Enemy_UpdateStage12FloatingAnimation+8   r  ; was: off_2E320
                dc.l    SharedFloaterDebrisProjectileAlternating3And2Animation

; Updates the Stage 12 floater or converts it to shared defeat debris
Enemy_Stage12FloaterController:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E328
                tst.w   4(a5)
                beq.s   Enemy_Stage12FloaterController_UpdateState
                tst.w   $24(a5)
                bmi.w   Enemy_ConvertStage12ObjectToDefeatDebris
                tst.w   (StageSpawnCountdown).w
                bpl.w   Enemy_ConvertStage12ObjectToDefeatDebris
                bclr    #7,$22(a5)
                bne.w   Enemy_ConvertStage12ObjectToDefeatDebris
                jsr     (RandomNumber).l
                clr.w   6(a5)
Enemy_Stage12FloaterController_UpdateState:             ; CODE XREF: Enemy_Stage12FloaterController+4   j  ; was: loc_2E352
                bsr.s   Enemy_DispatchStage12FloaterState
                bra.w   Enemy_UpdateStage12FloatingAnimation
; End of function Enemy_Stage12FloaterController
; Dispatches the Stage 12 floater's current state
Enemy_DispatchStage12FloaterState:                      ; CODE XREF: Enemy_Stage12FloaterController:Enemy_Stage12FloaterController_UpdateState   p  ; was: sub_2E358
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     Enemy_Stage12FloaterStateOffsets(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_DispatchStage12FloaterState
; ---------------------------------------------------------------------------
Enemy_Stage12FloaterStateOffsets:   dc.w    Enemy_Stage12FloaterInitState-*  ; DATA XREF: Enemy_DispatchStage12FloaterState+8   o  ; was: off_2E368
                dc.w    Enemy_Stage12FloaterWaitForPlayerState-*
                dc.w    Enemy_Stage12FloaterRiseState-*
                dc.w    Enemy_Stage12FloaterReleaseState-*
                dc.w    Enemy_UpdateStage12FallingObject-*
                dc.w    Enemy_Stage12SharedNoOpState-*
                dc.w    Enemy_Stage12FloaterNoOpState-*

; Initializes the floater sprite and first player-distance wait state
Enemy_Stage12FloaterInitState:                          ; DATA XREF: ROM:Enemy_Stage12FloaterStateOffsets   o  ; was: sub_2E376
                moveq   #0,d0
                bsr.w   Enemy_InitStage12FloatingSprite
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
; Waits until the player is close enough to start upward motion
Enemy_Stage12FloaterWaitForPlayerState:                 ; DATA XREF: ROM:0002E36A   o  ; was: loc_2E386
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$60,d0                         ; '`'
                bcc.w   Enemy_Stage12FloaterWaitForPlayerState_Return
                move.l  #$FFFE0000,$1C(a5)
                addq.w  #2,4(a5)
Enemy_Stage12FloaterWaitForPlayerState_Return:          ; CODE XREF: Enemy_Stage12FloaterInitState+1A   j  ; was: locret_2E3A0
                rts
; End of function Enemy_Stage12FloaterInitState
; Advances after the floater rises above its Y boundary
Enemy_Stage12FloaterRiseState:                          ; DATA XREF: ROM:0002E36C   o  ; was: sub_2E3A2
                cmpi.w  #$150,$14(a5)
                bcc.s   Enemy_Stage12FloaterRiseState_Return
                addq.w  #2,4(a5)
Enemy_Stage12FloaterRiseState_Return:                   ; CODE XREF: Enemy_Stage12FloaterRiseState+6   j  ; was: locret_2E3AE
                rts
; End of function Enemy_Stage12FloaterRiseState
; Waits for open terrain, then releases the floater with randomized horizontal motion
Enemy_Stage12FloaterReleaseState:                       ; DATA XREF: ROM:0002E36E   o  ; was: sub_2E3B0
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Collision_InitBufferPointers).l
                tst.w   d2
                bne.s   Enemy_Stage12FloaterReleaseState_Return
                addq.w  #2,4(a5)
                move.b  #$C0,$21(a5)
                move.l  #$FFFB8000,$1C(a5)
                move.w  #8,$5C(a5)
                move.b  (RandomNumberState).w,d0
                andi.w  #$FF,d0
                add.w   d0,d0
                lea     (Math_SineTable).l,a1
                move.w  (a1,d0.w),d0
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a5)
Enemy_Stage12FloaterReleaseState_Return:                ; CODE XREF: Enemy_Stage12FloaterReleaseState+C   j  ; was: locret_2E3F2
                rts
; End of function Enemy_Stage12FloaterReleaseState
; Applies gravity and converts a Stage 12 falling object after it crosses the lower bound
Enemy_UpdateStage12FallingObject:                       ; DATA XREF: ROM:0002E370   o  ; was: sub_2E3F4
                                        ; ROM:0002E630   o
                addi.l  #$2000,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   Enemy_UpdateStage12FallingObject_Return
                ori.w   #$1000,$E(a5)
                cmpi.w  #$150,$14(a5)
                blt.s   Enemy_UpdateStage12FallingObject_Return
                bra.s   Enemy_ConvertStage12FallingObjectToEffect
; ---------------------------------------------------------------------------
Enemy_UpdateStage12FallingObject_Return:                ; CODE XREF: Enemy_UpdateStage12FallingObject+E   j  ; was: locret_2E414
                                        ; Enemy_UpdateStage12FallingObject+1C   j
                rts
; ---------------------------------------------------------------------------
Enemy_ConvertStage12FallingObjectToEffect:              ; CODE XREF: Projectile_FallingShotInit+92   j  ; was: loc_2E416
                                        ; Enemy_UpdateStage12FallingObject+1E   j
                movea.w a5,a0
                jsr     (Projectile_InitType88FromCurrent).l
                move.l  #SharedProjectileDuration4Animation,8(a5)
                move.w  #$C000,$E(a5)
                move.l  #$FFFD8000,$1C(a5)
                rts
; End of function Enemy_UpdateStage12FallingObject
Enemy_Stage12SharedNoOpState:                           ; DATA XREF: ROM:0002E372   o  ; was: nullsub_67
                                        ; ROM:0002E632   o
                rts
; End of function Enemy_Stage12SharedNoOpState

Enemy_Stage12FloaterNoOpState:                          ; DATA XREF: ROM:0002E374   o  ; was: nullsub_68
                rts
; End of function Enemy_Stage12FloaterNoOpState

; Converts an inactive Stage 12 floater or launcher to shared defeat debris
Enemy_ConvertStage12ObjectToDefeatDebris:               ; CODE XREF: Enemy_Stage12FloaterController+A   j  ; was: sub_2E43A
                                        ; Enemy_Stage12FloaterController+12   j
                tst.w   $24(a5)
                bmi.s   Enemy_ConvertStage12ObjectToDefeatDebris_Activate
                btst    #4,$22(a5)
                bne.s   Enemy_ConvertStage12ObjectToDefeatDebris_Activate
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                move.l  #SharedCombatSpriteAnimation00,8(a5)
                clr.w   $C(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
Enemy_ConvertStage12ObjectToDefeatDebris_Activate:      ; CODE XREF: Enemy_ConvertStage12ObjectToDefeatDebris+4   j  ; was: loc_2E46C
                                        ; Enemy_ConvertStage12ObjectToDefeatDebris+C   j
                clr.w   4(a5)
                move.w  #$2D0,(a5)
                move.w  #$10,$48(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #$FFFB8000,$1C(a5)
                rts
; End of function Enemy_ConvertStage12ObjectToDefeatDebris
; Updates shared Stage 12 defeat debris, then creates an explosion and pickup
Enemy_UpdateStage12DefeatDebris:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E490
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   Enemy_UpdateStage12DefeatDebris_Blink
                jsr     (Effect_SpawnExplosionA).l
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                cmpi.w  #$1B8,(Entity57Type).w
                beq.s   Enemy_UpdateStage12DefeatDebris_RemoveForSpecialStage
                moveq   #$F,d0
                jmp     Pickup_SpawnRandomFromCurrentObject
; ---------------------------------------------------------------------------
Enemy_UpdateStage12DefeatDebris_RemoveForSpecialStage:  ; CODE XREF: Enemy_UpdateStage12DefeatDebris+24   j  ; was: loc_2E4BE
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
Enemy_UpdateStage12DefeatDebris_Blink:                  ; CODE XREF: Enemy_UpdateStage12DefeatDebris+C   j  ; was: loc_2E4C6
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   Enemy_UpdateStage12DefeatDebris_Return
                bclr    #7,2(a5)
Enemy_UpdateStage12DefeatDebris_Return:                 ; CODE XREF: Enemy_UpdateStage12DefeatDebris+42   j  ; was: locret_2E4DA
                rts
; End of function Enemy_UpdateStage12DefeatDebris
; Updates the camera-attached Stage 12 turret and its periodic shot
Enemy_Stage12TurretController:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E4DC
                tst.w   (StageSpawnCountdown).w
                bpl.w   Enemy_Stage12TurretHide
                bsr.s   Enemy_DispatchStage12TurretState
                move.l  (Entity57XPos).w,$10(a5)
                move.l  (Entity57YPos).w,$14(a5)
                cmpi.w  #4,4(a5)
                bcc.w   Enemy_Stage12TurretSpawnPeriodicShot
                rts
; End of function Enemy_Stage12TurretController
; Dispatches the Stage 12 turret's current state
Enemy_DispatchStage12TurretState:                       ; CODE XREF: Enemy_Stage12TurretController+8   p  ; was: sub_2E4FE
                move.w  4(a5),d0
                lea     Enemy_Stage12TurretStateOffsets(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_DispatchStage12TurretState
; ---------------------------------------------------------------------------
Enemy_Stage12TurretStateOffsets:    dc.w    Enemy_Stage12TurretInit-*  ; DATA XREF: Enemy_DispatchStage12TurretState+4   o  ; was: off_2E50A
                dc.w    Enemy_Stage12TurretIdle-*
                dc.w    Enemy_Stage12TurretDelayState-*
                dc.w    Enemy_Stage12TurretAllocateLauncherState-*
                dc.w    Enemy_Stage12TurretActivateLauncherState-*
                dc.w    Enemy_Stage12TurretBeginResetState-*
                dc.w    Enemy_Stage12TurretResetDelayState-*

; Initializes turret sprite
Enemy_Stage12TurretInit:                                ; DATA XREF: ROM:Enemy_Stage12TurretStateOffsets   o  ; was: sub_2E518
                move.w  #$D00,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage12TurretInit
; Turret idle state
Enemy_Stage12TurretIdle:                                ; DATA XREF: ROM:0002E50C   o  ; was: sub_2E524
                cmpi.w  #$1B8,(Entity57Type).w
                bne.s   Enemy_Stage12TurretIdle_Return
                cmpi.w  #6,(Entity57State).w
                bcs.s   Enemy_Stage12TurretIdle_Return
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
Enemy_Stage12TurretIdle_Return:                         ; CODE XREF: Enemy_Stage12TurretIdle+6   j  ; was: locret_2E53E
                                        ; Enemy_Stage12TurretIdle+E   j
                rts
; End of function Enemy_Stage12TurretIdle
; Waits before allocating a launcher object
Enemy_Stage12TurretDelayState:                          ; DATA XREF: ROM:0002E50E   o  ; was: sub_2E540
                subq.w  #1,$48(a5)
                bne.s   Enemy_Stage12TurretDelayState_Return
                addq.w  #2,4(a5)
Enemy_Stage12TurretDelayState_Return:                   ; CODE XREF: Enemy_Stage12TurretDelayState+4   j  ; was: locret_2E54A
                rts
; End of function Enemy_Stage12TurretDelayState
; Allocates a dormant object slot for the next launcher
Enemy_Stage12TurretAllocateLauncherState:               ; DATA XREF: ROM:0002E510   o  ; was: sub_2E54C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Enemy_Stage12TurretAllocateLauncherState_Return
                move.w  #$10,(a0)
                move.w  a0,$4A(a5)
                addq.w  #2,4(a5)
Enemy_Stage12TurretAllocateLauncherState_Return:        ; CODE XREF: Enemy_Stage12TurretAllocateLauncherState+6   j  ; was: locret_2E560
                rts
; End of function Enemy_Stage12TurretAllocateLauncherState
; Activates the reserved launcher after the turret reaches its Y threshold
Enemy_Stage12TurretActivateLauncherState:               ; DATA XREF: ROM:0002E512   o  ; was: sub_2E562
                cmpi.w  #$140,$14(a5)
                bcs.s   Enemy_Stage12TurretActivateLauncherState_Return
                movea.w $4A(a5),a0
                move.w  #$2E4,(a0)
                addq.w  #2,4(a5)
                move.w  #$38,$4E(a0)                    ; '8'
                move.w  (RandomNumberState).w,d0
                andi.w  #$7F,d0
                addi.w  #$50,d0                         ; 'P'
                move.w  d0,$4C(a0)
Enemy_Stage12TurretActivateLauncherState_Return:        ; CODE XREF: Enemy_Stage12TurretActivateLauncherState+6   j  ; was: locret_2E58C
                rts
; End of function Enemy_Stage12TurretActivateLauncherState
; Starts the turret reset delay
Enemy_Stage12TurretBeginResetState:                     ; DATA XREF: ROM:0002E514   o  ; was: sub_2E58E
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage12TurretBeginResetState
; Returns the turret to its delay state when the reset timer expires
Enemy_Stage12TurretResetDelayState:                     ; DATA XREF: ROM:0002E516   o  ; was: sub_2E59A
                subq.w  #1,$48(a5)
                bne.s   Enemy_Stage12TurretResetDelayState_Return
                move.w  #6,4(a5)
Enemy_Stage12TurretResetDelayState_Return:              ; CODE XREF: Enemy_Stage12TurretResetDelayState+4   j  ; was: locret_2E5A6
                rts
; End of function Enemy_Stage12TurretResetDelayState
; Periodically spawns the turret's type-$90 shot
Enemy_Stage12TurretSpawnPeriodicShot:                   ; CODE XREF: Enemy_Stage12TurretController+1C   j  ; was: sub_2E5A8
                move.b  (RandomNumberState).w,d0
                andi.w  #3,d0
                bne.s   Enemy_Stage12TurretSpawnPeriodicShot_CheckSlowInterval
                move.w  (FrameCounter).w,d7
                andi.w  #$FF,d7
                bne.s   Enemy_Stage12TurretSpawnPeriodicShot_Return
                bra.s   Enemy_Stage12TurretSpawnPeriodicShot_Spawn
; ---------------------------------------------------------------------------
Enemy_Stage12TurretSpawnPeriodicShot_CheckSlowInterval:  ; CODE XREF: Enemy_Stage12TurretSpawnPeriodicShot+8   j  ; was: loc_2E5BE
                move.w  (FrameCounter).w,d7
                andi.w  #$1FF,d7
                bne.s   Enemy_Stage12TurretSpawnPeriodicShot_Return
Enemy_Stage12TurretSpawnPeriodicShot_Spawn:             ; CODE XREF: Enemy_Stage12TurretSpawnPeriodicShot+14   j  ; was: loc_2E5C8
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Enemy_Stage12TurretSpawnPeriodicShot_Return
                move.w  #$90,(a0)
                move.w  #1,$5E(a0)
                move.w  #$B0,$14(a0)
Enemy_Stage12TurretSpawnPeriodicShot_Return:            ; CODE XREF: Enemy_Stage12TurretSpawnPeriodicShot+12   j  ; was: locret_2E5E0
                                        ; Enemy_Stage12TurretSpawnPeriodicShot+1E   j
                rts
; End of function Enemy_Stage12TurretSpawnPeriodicShot
; Hides turret enemy
Enemy_Stage12TurretHide:                                ; CODE XREF: Enemy_Stage12TurretController+4   j  ; was: sub_2E5E2
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_Stage12TurretHide
; Updates the Stage 12 launcher or converts it to shared defeat debris
Enemy_Stage12LauncherController:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E5EA
                tst.w   4(a5)
                beq.s   Enemy_Stage12LauncherController_UpdateState
                tst.w   $24(a5)
                bmi.w   Enemy_ConvertStage12ObjectToDefeatDebris
                tst.w   (StageSpawnCountdown).w
                bpl.w   Enemy_ConvertStage12ObjectToDefeatDebris
                bclr    #7,$22(a5)
                bne.w   Enemy_ConvertStage12ObjectToDefeatDebris
                jsr     (RandomNumber).l
                clr.w   6(a5)
Enemy_Stage12LauncherController_UpdateState:            ; CODE XREF: Enemy_Stage12LauncherController+4   j  ; was: loc_2E614
                bsr.s   Enemy_DispatchStage12LauncherState
                bra.w   Enemy_UpdateStage12FloatingAnimation
; End of function Enemy_Stage12LauncherController
; Dispatches the Stage 12 launcher's current state
Enemy_DispatchStage12LauncherState:                     ; CODE XREF: Enemy_Stage12LauncherController:Enemy_Stage12LauncherController_UpdateState   p  ; was: sub_2E61A
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     Enemy_Stage12LauncherStateOffsets(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_DispatchStage12LauncherState
; ---------------------------------------------------------------------------
Enemy_Stage12LauncherStateOffsets:  dc.w    Enemy_Stage12LauncherInitState-*  ; DATA XREF: Enemy_DispatchStage12LauncherState+8   o  ; was: off_2E62A
                dc.w    Enemy_Stage12LauncherAttachedWaitState-*
                dc.w    Enemy_Stage12LauncherLaunchState-*
                dc.w    Enemy_UpdateStage12FallingObject-*
                dc.w    Enemy_Stage12SharedNoOpState-*

; Initializes the launcher and attaches it to the camera-relative anchor
Enemy_Stage12LauncherInitState:                         ; DATA XREF: ROM:Enemy_Stage12LauncherStateOffsets   o  ; was: sub_2E634
                moveq   #4,d0
                bsr.w   Enemy_InitStage12FloatingSprite
                move.b  #0,$20(a5)
                move.b  #$80,$21(a5)
                move.b  #$40,$23(a5)                    ; '@'
                move.w  #$ED00,2(a5)
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
; Follows the anchor until the launch delay expires
Enemy_Stage12LauncherAttachedWaitState:                 ; DATA XREF: ROM:0002E62C   o  ; was: loc_2E65C
                bsr.w   Enemy_Stage12LauncherUpdatePosition
                subq.w  #1,$4E(a5)
                bne.s   Enemy_Stage12LauncherAttachedWaitState_Return
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
Enemy_Stage12LauncherAttachedWaitState_Return:          ; CODE XREF: Enemy_Stage12LauncherInitState+30   j  ; was: locret_2E670
                rts
; End of function Enemy_Stage12LauncherInitState
; Updates launcher position relative to ship
Enemy_Stage12LauncherUpdatePosition:                    ; CODE XREF: Enemy_Stage12LauncherInitState:Enemy_Stage12LauncherAttachedWaitState   p  ; was: sub_2E672
                                        ; sub_2E690   p
                move.l  (Entity57XPos).w,$10(a5)
                move.l  (Entity57YPos).w,$14(a5)
                move.w  $4C(a5),d0
                add.w   d0,$10(a5)
                move.w  $4E(a5),d0
                add.w   d0,$14(a5)
                rts
; End of function Enemy_Stage12LauncherUpdatePosition
; Detaches and launches the Stage 12 launcher after its preparation timer
Enemy_Stage12LauncherLaunchState:                       ; DATA XREF: ROM:0002E62E   o  ; was: sub_2E690
                bsr.w   Enemy_Stage12LauncherUpdatePosition
                subq.w  #1,$48(a5)
                bne.s   Enemy_Stage12LauncherLaunchState_Return
                ori.b   #$40,$21(a5)                    ; '@'
                move.w  #$EF00,2(a5)
                move.l  #$FFFB8000,$1C(a5)
                move.w  #8,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                addq.w  #2,4(a5)
Enemy_Stage12LauncherLaunchState_Return:                ; CODE XREF: Enemy_Stage12LauncherLaunchState+8   j  ; was: locret_2E6C0
                rts
; End of function Enemy_Stage12LauncherLaunchState
