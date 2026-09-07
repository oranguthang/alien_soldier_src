Enemy_ShipBossStateHandler:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2CECA
                tst.w   4(a5)
                beq.s   loc_2CED8
                tst.w   $24(a5)
                bmi.w   Boss_FireProjectilePattern
loc_2CED8:                                              ; CODE XREF: Enemy_ShipBossStateHandler+4   j
                bsr.s   Enemy_ShipBossDispatcher
                bra.w   Anim_UpdateAnimationState
; End of function Enemy_ShipBossStateHandler
; State dispatcher for ship boss
Enemy_ShipBossDispatcher:                               ; CODE XREF: Enemy_ShipBossStateHandler:loc_2CED8   p  ; was: sub_2CEDE
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2CEF2(pc,d0.w),a0
                adda.l  #Enemy_ShipBossInit,a0
                jmp     (a0)
; End of function Enemy_ShipBossDispatcher
; ---------------------------------------------------------------------------
off_2CEF2:      dc.w    Enemy_ShipBossInit-Enemy_ShipBossInit
                                        ; DATA XREF: Enemy_ShipBossDispatcher+8   r
                dc.w    Enemy_ShipBossInit_UpdateTimer-Enemy_ShipBossInit

; Initializes ship boss sprite
Enemy_ShipBossInit:                                     ; DATA XREF: Enemy_ShipBossDispatcher+C   o  ; was: sub_2CEF6
                                        ; ROM:off_2CEF2   o
                moveq   #0,d0
                bsr.w   Sprite_SetupBossSprite
                addq.w  #2,4(a5)
                clr.w   $48(a5)
; Updates timer for boss ship initialization phase
Enemy_ShipBossInit_UpdateTimer:                         ; DATA XREF: ROM:0002CEF4   o  ; was: loc_2CF04
                subq.w  #1,$48(a5)
                bpl.s   locret_2CF16
                move.w  #$38,$48(a5)                    ; '8'
                move.w  #$10,$5C(a5)
locret_2CF16:                                           ; CODE XREF: Enemy_ShipBossInit+12   j
                rts
; End of function Enemy_ShipBossInit
; Updates enemy facing direction to track player
Enemy_FacePlayer:                                       ; CODE XREF: Enemy_MainStateMachine+78   p  ; was: sub_2CF18
                                        ; Enemy_MainStateMachine+1C0   j
                jsr     (Physics_GetPlayerDelta).l
                tst.w   d1
                bpl.s   loc_2CF2A
                bset    #3,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_2CF2A:                                              ; CODE XREF: Enemy_FacePlayer+8   j
                bclr    #3,$E(a5)
                rts
; End of function Enemy_FacePlayer
; Negates horizontal velocity if entity is facing left
Physics_NegateVelocityIfFacingLeft:                     ; CODE XREF: Enemy_MainStateMachine+122   p  ; was: sub_2CF32
                btst    #3,$E(a5)
                bne.s   locret_2CF3E
                neg.l   $18(a5)
locret_2CF3E:                                           ; CODE XREF: Physics_NegateVelocityIfFacingLeft+6   j
                rts
; End of function Physics_NegateVelocityIfFacingLeft
; Applies gravity acceleration to vertical velocity with terminal velocity
Physics_AccelerateGravity:                              ; CODE XREF: Enemy_MainStateMachine+138   p  ; was: sub_2CF40
                tst.l   $1C(a5)
                bmi.s   loc_2CF5A
                cmpi.l  #$7C000,$1C(a5)
                bmi.s   loc_2CF5A
                move.l  #$7C000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2CF5A:                                              ; CODE XREF: Physics_AccelerateGravity+4   j
                                        ; Physics_AccelerateGravity+E   j
                addi.l  #$6000,$1C(a5)
                rts
; End of function Physics_AccelerateGravity
; Updates player physics and action state
Player_UpdatePhysics:                                   ; CODE XREF: Enemy_MainStateMachine+34   p  ; was: sub_2CF64
                                        ; sub_2C71E:Enemy_MainStateMachine_UpdateMovement   p
                jsr     (Physics_EntityWallCheck).l
                jmp     Player_ActionDispatcher
; End of function Player_UpdatePhysics
; Toggles sprite visibility flag
Enemy_ToggleSpriteVisibility:                           ; CODE XREF: Projectile_BouncingDebrisMain   p  ; was: sub_2CF70
                                        ; sub_2DEFE   p
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                beq.s   loc_2CF82
                andi.w  #$7FFF,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2CF82:                                              ; CODE XREF: Enemy_ToggleSpriteVisibility+8   j
                ori.w   #$8000,2(a5)
                rts
; End of function Enemy_ToggleSpriteVisibility
; Sets high bit in VDP control register
Enemy_SetVDPFlagHigh:                                   ; CODE XREF: Enemy_Phase2Movement+2   p  ; was: sub_2CF8A
                move.w  #$EF00,2(a5)
                move.w  (word_FF8276).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                btst    #7,$5F(a5)
                beq.s   loc_2CFAA
                bclr    #4,$E(a5)
loc_2CFAA:                                              ; CODE XREF: Enemy_SetVDPFlagHigh+18   j
                move.b  #$48,$20(a5)                    ; 'H'
                move.b  #$C0,$21(a5)
                move.b  #5,$23(a5)
                move.l  #$E020E818,$2C(a5)
                move.l  #$E020E818,$28(a5)
                lea     word_2CFEC(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_SetVDPFlagHigh
; ---------------------------------------------------------------------------
word_2CFEC:     dc.w    $1864, $1100                    ; DATA XREF: Enemy_SetVDPFlagHigh+42   o

; Sets animation pointer from table based on $5C value, clears animation frame counter
Enemy_SetAnimationFromIndex:                            ; CODE XREF: Enemy_Phase2StateHandler+22   j  ; was: sub_2CFF0
                move.w  $5C(a5),d0
                beq.s   locret_2D002
                subq.w  #4,d0
                move.l  off_2D004(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2D002:                                           ; CODE XREF: Enemy_SetAnimationFromIndex+4   j
                rts
; End of function Enemy_SetAnimationFromIndex
; ---------------------------------------------------------------------------
off_2D004:      dc.l    off_EADEA                       ; DATA XREF: Enemy_SetAnimationFromIndex+8   r
                dc.l    off_EADCA
                dc.l    off_EADDA
                dc.l    off_EAE06
                dc.l    off_EAE3A
                dc.l    off_EAE4A
                dc.l    off_EAE5A

; Enemy phase 2 state handler checking conditions
