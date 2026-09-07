Boss_JetsripperMoveLeft:                                ; CODE XREF: Sys_GameplayMainLoop:loc_1C76E   p  ; was: sub_2C33A
                tst.b   (byte_FFF705).w
                bmi.s   locret_2C35E
                movea.w #(word_FFA400-M68K_RAM),a5
                move.w  (word_FF8114).w,d0
                movea.w off_2C354(pc,d0.w),a0
                adda.l  #Boss_ClearFlag,a0
                jmp     (a0)
; End of function Boss_JetsripperMoveLeft
; ---------------------------------------------------------------------------
off_2C354:      dc.w    locret_2C35E-Boss_ClearFlag
                                        ; DATA XREF: Boss_JetsripperMoveLeft+E   r
                dc.w    Boss_JetsripperMoveRight-Boss_ClearFlag
                dc.w    Boss_JetsripperMoveRight_UpdateTimer-Boss_ClearFlag

; Clears word at FF8114 RAM address, used by Jetsripper boss movement
Boss_ClearFlag:                                         ; DATA XREF: Boss_JetsripperMoveLeft+12   o  ; was: sub_2C35A
                                        ; ROM:off_2C354   o
                clr.w   (word_FF8114).w
locret_2C35E:                                           ; CODE XREF: Boss_JetsripperMoveLeft+4   j
                                        ; Boss_JetsripperMoveRight+E   j
                rts
; End of function Boss_ClearFlag
; Moves Jetsripper boss right with animation
Boss_JetsripperMoveRight:                               ; DATA XREF: ROM:0002C356   o  ; was: sub_2C360
                addq.w  #2,(word_FF8114).w
                move.w  #$A0,(dword_FF8116).w
; Updates movement timer for Jetstripper boss moving right
Boss_JetsripperMoveRight_UpdateTimer:                   ; DATA XREF: ROM:0002C358   o  ; was: loc_2C36A
                subq.w  #1,(dword_FF8116).w
                bpl.w   locret_2C35E
                bsr.w   Boss_UpdateMovementPhase
                bsr.w   Boss_SetAnimationFrame
                bne.w   locret_2C35E
                bsr.w   Boss_InitAttackSequence
                move.w  #$158,d1
                move.w  (dword_FFFF08).w,(dword_FF8040).w
                andi.w  #1,(dword_FF8040).w
                bsr.w   Boss_UpdateAttackTimer
                bne.w   locret_2C35E
                move.w  #$1C,(a0)
                move.b  #$B,$5F(a0)
                bra.w   Boss_AdjustPositionToPlayer
; End of function Boss_JetsripperMoveRight
; Clears four consecutive longwords starting at FF8116, likely movement/state buffers
Boss_ClearMovementBuffers:
                moveq   #0,d0                           ; was: sub_2C3A8
                move.l  d0,(dword_FF8116).w
                move.l  d0,(dword_FF811A).w
                move.l  d0,(dword_FF811E).w
                move.l  d0,(dword_FF8122).w
                rts
; End of function Boss_ClearMovementBuffers
; Updates boss movement phase and direction
Boss_UpdateMovementPhase:                               ; CODE XREF: Boss_JetsripperMoveRight+12   p  ; was: sub_2C3BC
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$20,d0                         ; ' '
                move.w  d0,(dword_FF8116).w
                rts
; End of function Boss_UpdateMovementPhase
; Initializes boss attack sequence with timers
Boss_InitAttackSequence:                                ; CODE XREF: Boss_JetsripperMoveRight+1E   p  ; was: sub_2C3CE
                move.w  #$1D0,d0
                tst.w   (word_FFFF0E).w
                beq.s   locret_2C3F6
                cmpi.w  #2,(dword_FFA910).w
                bpl.s   locret_2C3F6
                cmpi.w  #$C0,(dword_FFA410).w
                bmi.s   locret_2C3F6
                move.b  (dword_FFFF08).w,d1
                andi.w  #3,d1
                bne.s   locret_2C3F6
                move.w  #$70,d0                         ; 'p'
locret_2C3F6:                                           ; CODE XREF: Boss_InitAttackSequence+8   j
                                        ; Boss_InitAttackSequence+10   j
                rts
; End of function Boss_InitAttackSequence
; Sets boss animation frame from lookup table
Boss_SetAnimationFrame:                                 ; CODE XREF: Boss_JetsripperMoveRight+16   p  ; was: sub_2C3F8
                movea.w #(byte_FFCE00-M68K_RAM),a0
                moveq   #3,d7
loc_2C3FE:                                              ; CODE XREF: Boss_SetAnimationFrame+E   j
                tst.w   (a0)
                beq.s   loc_2C40E
                lea     $60(a0),a0
                dbf     d7,loc_2C3FE
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
loc_2C40E:                                              ; CODE XREF: Boss_SetAnimationFrame+8   j
                jsr     (Sys_Clear96ByteBlock).l
                suba.w  #$60,a0                         ; '`'
                moveq   #0,d0
                rts
; End of function Boss_SetAnimationFrame
; Updates attack timer and transitions states
Boss_UpdateAttackTimer:                                 ; CODE XREF: Boss_JetsripperMoveRight+32   p  ; was: sub_2C41C
                lea     (M68K_RAM).l,a2
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFFF,d6
                move.w  d0,d2
                addi.w  #$10,d2
                bsr.w   Boss_CheckPlayerPosition
                move.w  d2,d3
                move.w  d0,d2
                subi.w  #$10,d2
                bsr.w   Boss_CheckPlayerPosition
                moveq   #$17,d7
loc_2C446:                                              ; CODE XREF: Boss_UpdateAttackTimer+7A   j
                move.w  (a2,d2.w),d4
                andi.w  #$7FF,d4
                move.b  (a1,d4.w),d4
                andi.b  #$FE,d4
                beq.s   loc_2C470
                move.w  (a2,d3.w),d4
                andi.w  #$7FF,d4
                move.b  (a1,d4.w),d4
                andi.b  #$FE,d4
                beq.s   loc_2C470
                moveq   #0,d6
                move.w  d1,d5
                bra.s   loc_2C484
; ---------------------------------------------------------------------------
loc_2C470:                                              ; CODE XREF: Boss_UpdateAttackTimer+3A   j
                                        ; Boss_UpdateAttackTimer+4C   j
                tst.w   d6
                bmi.s   loc_2C484
                addq.w  #1,d6
                cmpi.w  #7,d6
                bmi.s   loc_2C484
                subq.w  #1,(dword_FF8040).w
                bmi.s   loc_2C49E
                moveq   #$FFFFFFFF,d6
loc_2C484:                                              ; CODE XREF: Boss_UpdateAttackTimer+52   j
                                        ; Boss_UpdateAttackTimer+56   j
                subq.w  #8,d1
                subi.w  #$80,d2
                andi.w  #$1FFE,d2
                subi.w  #$80,d3
                andi.w  #$1FFE,d3
                dbf     d7,loc_2C446
                moveq   #1,d7
                rts
; ---------------------------------------------------------------------------
loc_2C49E:                                              ; CODE XREF: Boss_UpdateAttackTimer+64   j
                moveq   #0,d7
                rts
; End of function Boss_UpdateAttackTimer
; Checks player position relative to boss
Boss_CheckPlayerPosition:                               ; CODE XREF: Boss_UpdateAttackTimer+18   p  ; was: sub_2C4A2
                                        ; Boss_UpdateAttackTimer+24   p
                sub.w   d7,d2
                add.w   (dword_FFA900).w,d2
                asr.w   #2,d2
                andi.w  #$7E,d2                         ; '~'
                move.w  d1,d4
                sub.w   d7,d4
                sub.w   (dword_FFA904).w,d4
                asl.w   #4,d4
                andi.w  #$1F80,d4
                add.w   d4,d2
                rts
; End of function Boss_CheckPlayerPosition
; Adjusts boss position based on player location
Boss_AdjustPositionToPlayer:                            ; CODE XREF: Boss_JetsripperMoveRight+44   j  ; was: sub_2C4C0
                move.w  d0,$10(a0)
                subi.w  #$20,d5                         ; ' '
                move.w  d5,$14(a0)
                cmpi.w  #$120,$10(a0)
                bpl.s   locret_2C4DA
                bset    #7,$5F(a0)
locret_2C4DA:                                           ; CODE XREF: Boss_AdjustPositionToPlayer+12   j
                rts
; End of function Boss_AdjustPositionToPlayer
; Sets up boss sprite properties and palette
Sprite_SetupBossSprite:                                 ; CODE XREF: Enemy_MainStateMachine+2   p  ; was: sub_2C4DC
                                        ; Enemy_BeginDestructionDelay+6   p
                move.w  #$EF00,2(a5)
                move.w  (word_FF826E).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                btst    #7,$5F(a5)
                beq.s   Sprite_SetupBossAttributes
                bclr    #3,$E(a5)
; Sets up boss sprite attributes including palette and size
Sprite_SetupBossAttributes:                             ; CODE XREF: Sprite_SetupBossSprite+18   j  ; was: loc_2C4FC
                move.b  #$48,$20(a5)                    ; 'H'
                move.b  #$C0,$21(a5)
                move.l  #$F010F808,$2C(a5)
                move.l  #$E420E818,$28(a5)
                lea     byte_2C538(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Sprite_SetupBossSprite
; ---------------------------------------------------------------------------
byte_2C538:     dc.b    $18, 4, $11, 0                  ; DATA XREF: Sprite_SetupBossSprite+3C   o

; Updates animation pointer based on current state index
Anim_UpdateAnimationState:                              ; CODE XREF: Enemy_BehaviorController+52   j  ; was: sub_2C53C
                                        ; Enemy_AnimationWrapper+2   j
                move.w  $5C(a5),d0
                beq.s   locret_2C54E
                subq.w  #4,d0
                move.l  off_2C550(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2C54E:                                           ; CODE XREF: Anim_UpdateAnimationState+4   j
                rts
; End of function Anim_UpdateAnimationState
; ---------------------------------------------------------------------------
off_2C550:      dc.l    off_E9E1C                       ; DATA XREF: Anim_UpdateAnimationState+8   r
                dc.l    off_E9E08
                dc.l    off_E9E40
                dc.l    off_E9E68
                dc.l    off_E9E80

; Applies horizontal acceleration with speed limits
Physics_AccelerateHorizontal:                           ; CODE XREF: Enemy_MainStateMachine:Enemy_MainStateMachine_Accelerate   p  ; was: sub_2C564
                btst    #3,$E(a5)
                bne.s   loc_2C590
                move.l  $18(a5),d0
                bmi.s   loc_2C584
                cmpi.l  #$20000,d0
                bmi.s   loc_2C584
                move.l  #$20000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C584:                                              ; CODE XREF: Physics_AccelerateHorizontal+C   j
                                        ; Physics_AccelerateHorizontal+14   j
                addi.l  #$2000,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C590:                                              ; CODE XREF: Physics_AccelerateHorizontal+6   j
                move.l  $18(a5),d0
                bpl.s   loc_2C5A8
                cmpi.l  #$FFFE0000,d0
                bpl.s   loc_2C5A8
                move.l  #$FFFE0000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C5A8:                                              ; CODE XREF: Physics_AccelerateHorizontal+30   j
                                        ; Physics_AccelerateHorizontal+38   j
                subi.l  #$2000,d0
                move.l  d0,$18(a5)
                rts
; End of function Physics_AccelerateHorizontal
; Applies horizontal deceleration and stops at threshold
Physics_DecelerateHorizontal:                           ; CODE XREF: Enemy_MainStateMachine+42   p  ; was: sub_2C5B4
                                        ; Enemy_MainStateMachine+17E   j
                move.l  $18(a5),d0
                beq.s   locret_2C5CE
                bmi.s   loc_2C5D0
                cmpi.l  #$3800,d0
                bmi.s   loc_2C5E4
                subi.l  #$3800,d0
                move.l  d0,$18(a5)
locret_2C5CE:                                           ; CODE XREF: Physics_DecelerateHorizontal+4   j
                rts
; ---------------------------------------------------------------------------
loc_2C5D0:                                              ; CODE XREF: Physics_DecelerateHorizontal+6   j
                cmpi.l  #$FFFFC800,d0
                bpl.s   loc_2C5E4
                addi.l  #$3800,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C5E4:                                              ; CODE XREF: Physics_DecelerateHorizontal+E   j
                                        ; Physics_DecelerateHorizontal+22   j
                clr.l   $18(a5)
                rts
; End of function Physics_DecelerateHorizontal
; Initializes homing projectile that tracks player with angle calculation
Enemy_InitTrackedProjectile:                            ; CODE XREF: Enemy_MainStateMachine+1B6   j  ; was: sub_2C5EA
                jsr     (Projectile_UpdateTrajectory).l
                beq.s   loc_2C5F4
                rts
; ---------------------------------------------------------------------------
loc_2C5F4:                                              ; CODE XREF: Enemy_InitTrackedProjectile+6   j
                moveq   #$FFFFFFE8,d0
                moveq   #$FFFFFFFA,d1
                move.w  (word_FF808A).w,d2
                move.b  $20(a5),d2
                subq.w  #4,d2
                move.w  #$100,d6
                btst    #3,$E(a5)
                bne.s   Enemy_CalculateHomingAngle
                moveq   #0,d6
                neg.w   d0
; Calculates homing angle for projectile targeting player
Enemy_CalculateHomingAngle:                             ; CODE XREF: Enemy_InitTrackedProjectile+22   j  ; was: loc_2C612
                move.w  (word_FFFF0E).w,d7
                asr.w   #1,d7
                addi.w  #9,d7
                jmp     Enemy_SetProjectileDifficulty
; End of function Enemy_InitTrackedProjectile
; Fires projectiles in pattern based on attack state
Boss_FireProjectilePattern:                             ; CODE XREF: Enemy_BehaviorController+A   j  ; was: sub_2C622
                                        ; Enemy_BehaviorController+12   j
                move.w  #$1D4,(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #off_E9E80,8(a5)
                clr.w   $C(a5)
                move.w  #$10,$48(a5)
                clr.w   $4A(a5)
                move.l  #$FFFB2000,$1C(a5)
                move.l  #$FFFEA000,$18(a5)
                btst    #3,$E(a5)
                beq.s   locret_2C664
                neg.l   $18(a5)
locret_2C664:                                           ; CODE XREF: Boss_FireProjectilePattern+3C   j
                rts
; End of function Boss_FireProjectilePattern
; Spawns multiple projectiles in sequence
Boss_SpawnMultipleShots:                                ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C666
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   Boss_ToggleVisibilityBit
                jsr     (Projectile_ExplodeWithSound).l
                tst.w   $4A(a5)
                beq.w   loc_2C68A
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C68A:                                              ; CODE XREF: Boss_SpawnMultipleShots+18   j
                moveq   #7,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
; Toggles boss visibility bit based on animation frame
Boss_ToggleVisibilityBit:                               ; CODE XREF: Boss_SpawnMultipleShots+C   j  ; was: loc_2C692
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2C6A6
                bclr    #7,2(a5)
locret_2C6A6:                                           ; CODE XREF: Boss_SpawnMultipleShots+38   j
                rts
; End of function Boss_SpawnMultipleShots
; Main AI controller for enemy behavior and state management
