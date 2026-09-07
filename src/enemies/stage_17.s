Enemy_FlyMain:                                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2D66C
                tst.w   4(a5)
                beq.s   loc_2D696
                tst.w   $24(a5)
                bmi.w   Enemy_ResetCirclingState
                bclr    #7,$22(a5)
                bne.w   Enemy_ResetCirclingState
                tst.w   (word_FF808C).w
                bpl.w   Enemy_ResetCirclingState
                jsr     (RandomNumber).l
                clr.w   6(a5)
loc_2D696:                                              ; CODE XREF: Enemy_FlyMain+4   j
                bsr.s   Enemy_FlyDispatcher
                bra.w   Enemy_UpdateCirclingAnimation
; End of function Enemy_FlyMain
; Fly enemy state dispatcher using jump table
Enemy_FlyDispatcher:                                    ; CODE XREF: Enemy_FlyMain:loc_2D696   p  ; was: sub_2D69C
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2D6AC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyDispatcher
; ---------------------------------------------------------------------------
off_2D6AC:      dc.w    Enemy_FlyInit-*                 ; DATA XREF: Enemy_FlyDispatcher+8   o
                dc.w    Enemy_FlyInit_RotateToTarget-*
                dc.w    nullsub_64-*

; Initializes fly enemy with position and animation
Enemy_FlyInit:                                          ; DATA XREF: ROM:off_2D6AC   o  ; was: sub_2D6B2
                moveq   #0,d0
                bsr.w   Enemy_InitCirclingSprite
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
                move.w  #$10,$50(a5)
                move.w  #$180,$4C(a5)
                move.w  #$80,$4E(a5)
                tst.w   $58(a5)
                bne.s   loc_2D6E2
                move.w  #8,$4A(a5)
                bra.s   Enemy_FlyInit_RotateToTarget
; ---------------------------------------------------------------------------
loc_2D6E2:                                              ; CODE XREF: Enemy_FlyInit+26   j
                move.w  #$FFF8,$4A(a5)
; Updates rotation angle and moves toward target angle using circular homing
Enemy_FlyInit_RotateToTarget:                           ; CODE XREF: Enemy_FlyInit+2E   j  ; was: loc_2D6E8
                                        ; DATA XREF: ROM:0002D6AE   o
                move.w  $4A(a5),d0
                add.w   d0,$4C(a5)
                andi.w  #$1FF,$4C(a5)
                bsr.w   Enemy_UpdateCirclingRotationSprite
                move.w  $50(a5),d2
                move.w  $50(a5),d3
                bsr.w   Enemy_UpdateCircularMotionAndFire
                move.w  $4E(a5),d0
                cmp.w   $4C(a5),d0
                bne.s   locret_2D756
                move.w  $48(a5),d0
                tst.w   $58(a5)
                bne.s   loc_2D72E
                move.w  word_2D758(pc,d0.w),$4A(a5)
                move.w  word_2D75E(pc,d0.w),$4E(a5)
                move.w  word_2D764(pc,d0.w),$50(a5)
                bra.s   loc_2D740
; ---------------------------------------------------------------------------
loc_2D72E:                                              ; CODE XREF: Enemy_FlyInit+66   j
                move.w  word_2D76A(pc,d0.w),$4A(a5)
                move.w  word_2D770(pc,d0.w),$4E(a5)
                move.w  word_2D776(pc,d0.w),$50(a5)
loc_2D740:                                              ; CODE XREF: Enemy_FlyInit+7A   j
                addq.w  #2,$48(a5)
                cmpi.w  #8,$48(a5)
                bne.s   locret_2D756
                move.w  #$CF00,2(a5)
                addq.w  #2,4(a5)
locret_2D756:                                           ; CODE XREF: Enemy_FlyInit+5C   j
                                        ; Enemy_FlyInit+98   j
                rts
; End of function Enemy_FlyInit
; ---------------------------------------------------------------------------
word_2D758:     dc.w    2, 4, 2                         ; DATA XREF: Enemy_FlyInit+68   r
word_2D75E:     dc.w    $100, $100, $160                ; DATA XREF: Enemy_FlyInit+6E   r
word_2D764:     dc.w    $10, 8, $10                     ; DATA XREF: Enemy_FlyInit+74   r
word_2D76A:     dc.w    $FFFE, $FFFC, $FFFE
                                        ; DATA XREF: Enemy_FlyInit:loc_2D72E   r
word_2D770:     dc.w    0, 0, $1A0                      ; DATA XREF: Enemy_FlyInit+82   r
word_2D776:     dc.w    $10, 8, $10                     ; DATA XREF: Enemy_FlyInit+88   r

nullsub_64:                                             ; DATA XREF: ROM:0002D6B0   o
                rts
; End of function nullsub_64

; Stage 17 walker enemy main handler
Enemy_Stage17WalkerMain:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2D77E
                tst.w   4(a5)
                beq.s   Enemy_Stage17WalkerUpdate
                tst.w   $24(a5)
                bmi.w   Enemy_ClearAndSpawnQuadProjectiles
                bclr    #7,$22(a5)
                bne.w   Enemy_ClearAndSpawnQuadProjectiles
                tst.w   (word_FF808C).w
                bpl.w   Enemy_ClearAndSpawnQuadProjectiles
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Updates Stage 17 walker enemy state and sprite
Enemy_Stage17WalkerUpdate:                              ; CODE XREF: Enemy_Stage17WalkerMain+4   j  ; was: loc_2D7A8
                bsr.s   Enemy_Stage17WalkerInit
                bra.w   Enemy_UpdateCirclingAnimation
; End of function Enemy_Stage17WalkerMain
; Initializes walker enemy
Enemy_Stage17WalkerInit:                                ; CODE XREF: Enemy_Stage17WalkerMain:loc_2D7A8   p  ; was: sub_2D7AE
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2D7BE(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage17WalkerInit
; ---------------------------------------------------------------------------
off_2D7BE:      dc.w    Enemy_Stage17WalkerWalk-*       ; DATA XREF: Enemy_Stage17WalkerInit+8   o
                dc.w    Enemy_Stage17WalkerTurn-*
                dc.w    Enemy_Stage17WalkerAttack-*
                dc.w    Enemy_Stage17WalkerCheckEdge-*
                dc.w    Enemy_Stage17WalkerDeath-*

; Walker walking state
Enemy_Stage17WalkerWalk:                                ; DATA XREF: ROM:off_2D7BE   o  ; was: sub_2D7C8
                moveq   #0,d0
                bsr.w   Enemy_InitCirclingSprite
                move.b  #2,$25(a5)
                move.w  #$80,$4C(a5)
                addq.w  #2,4(a5)
                bsr.w   Enemy_UpdateCirclingRotationSprite
                move.w  #2,$1C(a5)
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                bmi.s   loc_2D7FA
                move.w  #$FFF8,$4E(a5)
                rts
; ---------------------------------------------------------------------------
loc_2D7FA:                                              ; CODE XREF: Enemy_Stage17WalkerWalk+28   j
                move.w  #8,$4E(a5)
                rts
; End of function Enemy_Stage17WalkerWalk
; Walker turning state
Enemy_Stage17WalkerTurn:                                ; DATA XREF: ROM:0002D7C0   o  ; was: sub_2D802
                move.w  $14(a5),d0
                sub.w   (word_FF824A).w,d0
                tst.w   d0
                bmi.s   locret_2D832
                cmpi.w  #$20,d0                         ; ' '
                bcs.s   locret_2D832
                clr.w   $50(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage17WalkerTurn
; Waits for linked object (at $4A) to have state=0 and vertical velocity=0 before advancing
Enemy_WaitForLinkedObject:
                movea.w $4A(a5),a1                      ; was: sub_2D81E
                tst.w   4(a1)
                beq.s   locret_2D832
                tst.w   $1C(a1)
                bne.s   locret_2D832
                addq.w  #2,4(a5)
locret_2D832:                                           ; CODE XREF: Enemy_Stage17WalkerTurn+A   j
                                        ; Enemy_Stage17WalkerTurn+10   j
                rts
; End of function Enemy_WaitForLinkedObject
; Walker attack state
Enemy_Stage17WalkerAttack:                              ; DATA XREF: ROM:0002D7C2   o  ; was: sub_2D834
                clr.w   $1C(a5)
                addq.w  #2,4(a5)
                move.w  #$10,$48(a5)
                rts
; End of function Enemy_Stage17WalkerAttack
; Checks if at edge
Enemy_Stage17WalkerCheckEdge:                           ; DATA XREF: ROM:0002D7C4   o  ; was: sub_2D844
                move.w  $4E(a5),d0
                add.w   d0,$4C(a5)
                bsr.w   Enemy_UpdateCirclingRotationSprite
                subq.w  #1,$48(a5)
                bne.s   locret_2D872
                move.w  #$1C0,$48(a5)
                addq.w  #2,4(a5)
                move.w  #3,$18(a5)
                btst    #7,$4E(a5)
                bne.s   locret_2D872
                neg.w   $18(a5)
locret_2D872:                                           ; CODE XREF: Enemy_Stage17WalkerCheckEdge+10   j
                                        ; Enemy_Stage17WalkerCheckEdge+28   j
                rts
; End of function Enemy_Stage17WalkerCheckEdge
; Walker death state
Enemy_Stage17WalkerDeath:                               ; DATA XREF: ROM:0002D7C6   o  ; was: sub_2D874
                bsr.w   Enemy_Stage17WalkerUpdateSprite
                subq.w  #1,$48(a5)
                bne.s   locret_2D884
                bset    #4,2(a5)
locret_2D884:                                           ; CODE XREF: Enemy_Stage17WalkerDeath+8   j
                rts
; End of function Enemy_Stage17WalkerDeath
; Updates walker sprite
Enemy_Stage17WalkerUpdateSprite:                        ; CODE XREF: Enemy_Stage17WalkerDeath   p  ; was: sub_2D886
                move.w  (word_FF824A).w,d0
                sub.w   $14(a5),d0
                beq.s   locret_2D8CA
                tst.w   d0
                bpl.s   Physics_ClampVerticalVelocityDown
                subi.l  #$2000,$1C(a5)
                cmpi.l  #$FFFE0000,$1C(a5)
                bgt.s   locret_2D8CA
                move.l  #$FFFE0000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
; Clamps vertical velocity to maximum downward speed
Physics_ClampVerticalVelocityDown:                      ; CODE XREF: Enemy_Stage17WalkerUpdateSprite+C   j  ; was: loc_2D8B0
                addi.l  #$2000,$1C(a5)
                cmpi.l  #$20000,$1C(a5)
                blt.s   locret_2D8CA
                move.l  #$20000,$1C(a5)
locret_2D8CA:                                           ; CODE XREF: Enemy_Stage17WalkerUpdateSprite+8   j
                                        ; Enemy_Stage17WalkerUpdateSprite+1E   j
                rts
; End of function Enemy_Stage17WalkerUpdateSprite
; Clears state and spawns quad projectiles
Enemy_ClearAndSpawnQuadProjectiles:                     ; CODE XREF: Enemy_Stage17WalkerMain+A   j  ; was: sub_2D8CC
                                        ; Enemy_Stage17WalkerMain+14   j
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jmp     Enemy_SpawnQuadProjectiles
; End of function Enemy_ClearAndSpawnQuadProjectiles
nullsub_65:
                rts
; End of function nullsub_65

; Fly enemy movement with wave pattern
Enemy_FlyMovement:                                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2D8E8
                move.w  4(a5),d0
                lea     off_2D8F4(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyMovement
; ---------------------------------------------------------------------------
off_2D8F4:      dc.w    Enemy_FlyUpdateState-*          ; DATA XREF: Enemy_FlyMovement+4   o
                dc.w    Enemy_FlyAttack-*
                dc.w    Enemy_FlyReturnPattern-*
                dc.w    Enemy_FlyDeath-*

; Updates fly state with animation transitions
Enemy_FlyUpdateState:                                   ; DATA XREF: ROM:off_2D8F4   o  ; was: sub_2D8FC
                move.w  #$120,$10(a5)
                move.w  #$90,$14(a5)
                move.w  #$D00,2(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyUpdateState
; Fly attack behavior with velocity changes
Enemy_FlyAttack:                                        ; DATA XREF: ROM:0002D8F6   o  ; was: sub_2D91A
                subq.w  #1,$48(a5)
                bne.s   locret_2D928
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
locret_2D928:                                           ; CODE XREF: Enemy_FlyAttack+4   j
                rts
; End of function Enemy_FlyAttack
; Fly return pattern after attack
Enemy_FlyReturnPattern:                                 ; DATA XREF: ROM:0002D8F8   o  ; was: sub_2D92A
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2D952
                move.w  #$10,(a0)
                lea     $4C(a5),a1
                move.w  $48(a5),d0
                move.w  a0,(a1,d0.w)
                addq.w  #2,$48(a5)
                cmpi.w  #$10,$48(a5)
                bne.s   locret_2D952
                addq.w  #2,4(a5)
locret_2D952:                                           ; CODE XREF: Enemy_FlyReturnPattern+6   j
                                        ; Enemy_FlyReturnPattern+22   j
                rts
; End of function Enemy_FlyReturnPattern
; Fly death animation and cleanup
Enemy_FlyDeath:                                         ; DATA XREF: ROM:0002D8FA   o  ; was: sub_2D954
                move.w  (word_FFA000).w,d7
                andi.w  #$F,d7
                bne.s   locret_2D99A
                subq.w  #2,$48(a5)
                bmi.s   loc_2D99C
                lea     $4C(a5),a1
                move.w  $48(a5),d0
                movea.w (a1,d0.w),a0
                move.w  #$2A8,(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  $4A(a5),$58(a0)
                tst.w   $4A(a5)
                bne.s   loc_2D994
                addi.w  #$100,$10(a0)
                rts
; ---------------------------------------------------------------------------
loc_2D994:                                              ; CODE XREF: Enemy_FlyDeath+36   j
                subi.w  #$80,$10(a0)
locret_2D99A:                                           ; CODE XREF: Enemy_FlyDeath+8   j
                rts
; ---------------------------------------------------------------------------
loc_2D99C:                                              ; CODE XREF: Enemy_FlyDeath+E   j
                tst.w   $4A(a5)
                bne.s   loc_2D9B2
                addq.w  #1,$4A(a5)
                move.w  #4,4(a5)
                clr.w   $48(a5)
                rts
; ---------------------------------------------------------------------------
loc_2D9B2:                                              ; CODE XREF: Enemy_FlyDeath+4C   j
                bset    #4,2(a5)
                rts
; End of function Enemy_FlyDeath
; Walker projectile handler
Projectile_Stage17WalkerShot:                           ; CODE XREF: Boss_ViblackSpawnWalkerShot+36   j  ; was: sub_2D9BA
                                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o
                move.w  #$2F4,(a0)
                move.w  #$D80,2(a0)
                move.w  #$80,$14(a0)
                move.w  d0,$10(a0)
                rts
; End of function Projectile_Stage17WalkerShot
; State machine dispatcher using jump table indexed by state value in offset 4
Projectile_JumpTableDispatcher:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2D9D0
                move.w  4(a5),d0
                lea     off_2D9DC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_JumpTableDispatcher
; ---------------------------------------------------------------------------
off_2D9DC:      dc.w    Projectile_SpawnLinkedObject-*  ; DATA XREF: Projectile_JumpTableDispatcher+4   o
                dc.w    Projectile_CounterLoopState-*

; Spawns linked object ID $2F4, copies position and link values, advances state
Projectile_SpawnLinkedObject:                           ; DATA XREF: ROM:off_2D9DC   o  ; was: sub_2D9E0
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2DA18
                move.w  #$2F4,(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  $4A(a5),$4A(a0)
                move.w  $5E(a5),$5E(a0)
                move.w  #$10,$50(a0)
                move.w  a0,$4A(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_2DA18:                                           ; CODE XREF: Projectile_SpawnLinkedObject+6   j
                rts
; End of function Projectile_SpawnLinkedObject
; Decrements timer, increments counter $5E, loops back to state 0 until counter reaches 4
Projectile_CounterLoopState:                            ; DATA XREF: ROM:0002D9DE   o  ; was: sub_2DA1A
                subq.w  #1,$48(a5)
                bne.s   locret_2DA30
                addq.w  #1,$5E(a5)
                cmpi.w  #4,$5E(a5)
                beq.s   loc_2DA32
                subq.w  #2,4(a5)
locret_2DA30:                                           ; CODE XREF: Projectile_CounterLoopState+4   j
                rts
; ---------------------------------------------------------------------------
loc_2DA32:                                              ; CODE XREF: Projectile_CounterLoopState+10   j
                bset    #4,2(a5)
                rts
; End of function Projectile_CounterLoopState
; Initializes flying bird enemy sprite with graphics mode and collision parameters
