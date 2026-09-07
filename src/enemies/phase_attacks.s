Enemy_Phase2StateHandler:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2D020
                tst.w   4(a5)
                beq.s   loc_2D040
                tst.w   $24(a5)
                bmi.w   Enemy_ResetToIdleState290
                tst.w   (word_FF808C).w
                bpl.w   Enemy_ResetToIdleState290
                jsr     (RandomNumber).l
                clr.w   6(a5)
loc_2D040:                                              ; CODE XREF: Enemy_Phase2StateHandler+4   j
                bsr.s   Enemy_InitPhase2Attack
                bra.w   Enemy_SetAnimationFromIndex
; End of function Enemy_Phase2StateHandler
; Initializes phase 2 attack state with parameters
Enemy_InitPhase2Attack:                                 ; CODE XREF: Enemy_Phase2StateHandler:loc_2D040   p  ; was: sub_2D046
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2D056(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_InitPhase2Attack
; ---------------------------------------------------------------------------
off_2D056:      dc.w    Enemy_Phase2Movement-*          ; DATA XREF: Enemy_InitPhase2Attack+8   o
                dc.w    Enemy_Phase2Movement_WaitAndMove-*
                dc.w    Enemy_UpdateTrajectory-*
                dc.w    Enemy_TimerWaitAndSetParams1-*
                dc.w    Enemy_TimerWaitAndSetParams2-*
                dc.w    Enemy_TimerWaitAndSetParams3-*
                dc.w    Enemy_TimerWaitAndSetParams4-*

; Phase 2 movement with velocity and gravity
Enemy_Phase2Movement:                                   ; DATA XREF: ROM:off_2D056   o  ; was: sub_2D064
                moveq   #0,d0
                bsr.w   Enemy_SetVDPFlagHigh
                move.w  #4,$5C(a5)
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
; Wait for timer countdown and check for movement trigger
Enemy_Phase2Movement_WaitAndMove:                       ; DATA XREF: ROM:0002D058   o  ; was: loc_2D07A
                subq.w  #1,$48(a5)
                beq.s   loc_2D09E
                btst    #5,(word_FFF708).w
                beq.s   locret_2D09C
                addq.w  #2,4(a5)
                btst    #4,$E(a5)
                bne.s   locret_2D09C
                move.l  #$FFFA0000,$1C(a5)
locret_2D09C:                                           ; CODE XREF: Enemy_Phase2Movement+22   j
                                        ; Enemy_Phase2Movement+2E   j
                rts
; ---------------------------------------------------------------------------
loc_2D09E:                                              ; CODE XREF: Enemy_Phase2Movement+1A   j
                move.w  #$20,$48(a5)                    ; ' '
                move.w  #6,4(a5)
                move.w  #$10,$5C(a5)
                rts
; End of function Enemy_Phase2Movement
; Updates enemy projectile trajectory
Enemy_UpdateTrajectory:                                 ; DATA XREF: ROM:0002D05A   o  ; was: sub_2D0B2
                cmpi.l  #$80000,$1C(a5)
                bge.s   loc_2D0C4
                addi.l  #$4000,$1C(a5)
loc_2D0C4:                                              ; CODE XREF: Enemy_UpdateTrajectory+8   j
                moveq   #0,d0
                tst.l   $1C(a5)
                bmi.s   loc_2D0D2
                move.w  #$20,d1                         ; ' '
                bra.s   loc_2D0D6
; ---------------------------------------------------------------------------
loc_2D0D2:                                              ; CODE XREF: Enemy_UpdateTrajectory+18   j
                move.w  #$FFE4,d1
loc_2D0D6:                                              ; CODE XREF: Enemy_UpdateTrajectory+1E   j
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                beq.s   locret_2D11E
                move.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                tst.l   $1C(a5)
                bmi.s   loc_2D10C
                bclr    #4,$E(a5)
                moveq   #0,d0
                move.w  #$20,d1                         ; ' '
                jsr     (Physics_AlignToTerrain).l
                rts
; ---------------------------------------------------------------------------
loc_2D10C:                                              ; CODE XREF: Enemy_UpdateTrajectory+44   j
                bset    #4,$E(a5)
                moveq   #0,d0
                move.w  #$FFE4,d1
                jsr     (Physics_AlignToTerrainTop).l
locret_2D11E:                                           ; CODE XREF: Enemy_UpdateTrajectory+2C   j
                rts
; End of function Enemy_UpdateTrajectory
; Decrements timer, when zero sets $5C=$14, resets timer=$20, advances state
Enemy_TimerWaitAndSetParams1:                           ; DATA XREF: ROM:0002D05C   o  ; was: sub_2D120
                subq.w  #1,$48(a5)
                bne.s   locret_2D136
                move.w  #$14,$5C(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_2D136:                                           ; CODE XREF: Enemy_TimerWaitAndSetParams1+4   j
                rts
; End of function Enemy_TimerWaitAndSetParams1
; Decrements timer, when zero sets $5C=$1C, velocity=$FFFF, timer=$20, advances state
Enemy_TimerWaitAndSetParams2:                           ; DATA XREF: ROM:0002D05E   o  ; was: sub_2D138
                subq.w  #1,$48(a5)
                bne.s   locret_2D154
                move.w  #$1C,$5C(a5)
                move.w  #$FFFF,$18(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_2D154:                                           ; CODE XREF: Enemy_TimerWaitAndSetParams2+4   j
                rts
; End of function Enemy_TimerWaitAndSetParams2
; Decrements timer, when zero clears velocity, sets $5C=$18, timer=$20, advances state
Enemy_TimerWaitAndSetParams3:                           ; DATA XREF: ROM:0002D060   o  ; was: sub_2D156
                subq.w  #1,$48(a5)
                bne.s   locret_2D170
                clr.w   $18(a5)
                move.w  #$18,$5C(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_2D170:                                           ; CODE XREF: Enemy_TimerWaitAndSetParams3+4   j
                rts
; End of function Enemy_TimerWaitAndSetParams3
; Decrements timer, when zero sets timer=$100, $5C=4, state=2
Enemy_TimerWaitAndSetParams4:                           ; DATA XREF: ROM:0002D062   o  ; was: sub_2D172
                subq.w  #1,$48(a5)
                bne.s   locret_2D18A
                move.w  #$100,$48(a5)
                move.w  #4,$5C(a5)
                move.w  #2,4(a5)
locret_2D18A:                                           ; CODE XREF: Enemy_TimerWaitAndSetParams4+4   j
                rts
; End of function Enemy_TimerWaitAndSetParams4
; Resets state to 0, sets ID $290, timer $40, clears velocity and flags
Enemy_ResetToIdleState290:                              ; CODE XREF: Enemy_Phase2StateHandler+A   j  ; was: sub_2D18C
                                        ; Enemy_Phase2StateHandler+12   j
                clr.w   4(a5)
                move.w  #$290,(a5)
                move.w  #$40,$48(a5)                    ; '@'
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                clr.l   $18(a5)
                rts
; End of function Enemy_ResetToIdleState290
; Handles bouncing debris projectile with gravity, collision, spawns particles, plays sound
Projectile_BouncingDebrisMain:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2D1AC
                bsr.w   Enemy_ToggleSpriteVisibility
                tst.l   $1C(a5)
                beq.s   loc_2D1EA
                cmpi.l  #$80000,$1C(a5)
                bge.s   loc_2D1C8
                addi.l  #$4000,$1C(a5)
loc_2D1C8:                                              ; CODE XREF: Projectile_BouncingDebrisMain+12   j
                moveq   #0,d0
                move.w  #$20,d1                         ; ' '
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                beq.s   loc_2D1EA
                bclr    #4,$E(a5)
                moveq   #0,d0
                move.w  #$20,d1                         ; ' '
                jsr     (Physics_AlignToTerrain).l
loc_2D1EA:                                              ; CODE XREF: Projectile_BouncingDebrisMain+8   j
                                        ; Projectile_BouncingDebrisMain+2A   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2D254
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_2D206
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
loc_2D206:                                              ; CODE XREF: Projectile_BouncingDebrisMain+4E   j
                bsr.s   Gfx_SetRandomAnimationPointer
                jsr     (Projectile_InitType88).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                subi.w  #$20,d0                         ; ' '
                move.w  $10(a5),$10(a0)
                add.w   d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0                         ; '?'
                subi.w  #$20,d0                         ; ' '
                move.w  $14(a5),$14(a0)
                add.w   d0,$14(a0)
                move.w  #$FFFE,$1C(a0)
                subq.w  #1,$48(a5)
                bne.s   locret_2D254
                jsr     (Projectile_ExplodeOnImpact).l
                moveq   #3,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
locret_2D254:                                           ; CODE XREF: Projectile_BouncingDebrisMain+44   j
                                        ; Projectile_BouncingDebrisMain+98   j
                rts
; End of function Projectile_BouncingDebrisMain
; Copies a5 register to a0, used for pointer manipulation
Sys_CopyA5ToA0:
                movea.w a5,a0                           ; was: sub_2D256
; End of function Sys_CopyA5ToA0
; Sets random animation pointer from 4-entry table based on random number bits 0-1
Gfx_SetRandomAnimationPointer:                          ; CODE XREF: Projectile_BouncingDebrisMain:loc_2D206   p  ; was: sub_2D258
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_2D26C(pc,d0.w),8(a0)
                rts
; End of function Gfx_SetRandomAnimationPointer
; ---------------------------------------------------------------------------
off_2D26C:      dc.l    off_E953C                       ; DATA XREF: Gfx_SetRandomAnimationPointer+C   r
                dc.l    off_E9560
                dc.l    off_E9584
                dc.l    off_E9560

; Initializes sprite VDP flags and hitbox from table
Enemy_InitSpriteParams:                                 ; CODE XREF: Enemy_ApproachPlayerState+2   p  ; was: sub_2D27C
                                        ; Enemy_FlyInit+2   p
                move.w  #$ED00,2(a5)
                move.w  (word_FF827A).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.b  #$48,$20(a5)                    ; 'H'
                move.b  #$C0,$21(a5)
                move.l  #$FF01FF01,$2C(a5)
                move.l  #$F808F808,$28(a5)
                lea     word_2D2CA(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_InitSpriteParams
; ---------------------------------------------------------------------------
word_2D2CA:     dc.w    $1802, $1100, $1802, $1100
                                        ; DATA XREF: Enemy_InitSpriteParams+2E   o

; Updates enemy sprite pattern based on state timer value
Enemy_UpdateSpritePattern:                              ; CODE XREF: Enemy_CircleMainHandler+2C   j  ; was: sub_2D2D2
                                        ; Enemy_FlyMain+2C   j
                move.w  $5C(a5),d0
                beq.s   locret_2D2EA
                move.w  #$ED00,2(a5)
                subq.w  #4,d0
                move.l  off_2D2EC(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2D2EA:                                           ; CODE XREF: Enemy_UpdateSpritePattern+4   j
                rts
; End of function Enemy_UpdateSpritePattern
; ---------------------------------------------------------------------------
off_2D2EC:      dc.l    off_EB320                       ; DATA XREF: Enemy_UpdateSpritePattern+E   r

; Updates sprite graphics based on rotation angle
Enemy_UpdateRotationSprite:                             ; CODE XREF: Enemy_CircleAttackState+E   p  ; was: sub_2D2F0
                                        ; Enemy_DescendAttackState+C   p
                move.w  $4C(a5),d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                lsr.w   #3,d0
                move.l  off_2D326(pc,d0.w),8(a5)
                clr.w   $C(a5)
                lsr.w   #1,d0
                move.w  (word_FF827A).w,d1
                andi.w  #$F7FF,d1
                or.w    (word_FF808A).w,d1
                or.w    word_2D366(pc,d0.w),d1
                move.w  d1,$E(a5)
                move.w  #$CD00,2(a5)
                rts
; End of function Enemy_UpdateRotationSprite
; ---------------------------------------------------------------------------
off_2D326:      dc.l    word_EB31A                      ; DATA XREF: Enemy_UpdateRotationSprite+E   r
                dc.l    word_EB314
                dc.l    word_EB30E
                dc.l    word_EB308
                dc.l    word_EB302
                dc.l    word_EB308
                dc.l    word_EB30E
                dc.l    word_EB314
                dc.l    word_EB31A
                dc.l    word_EB314
                dc.l    word_EB30E
                dc.l    word_EB308
                dc.l    word_EB302
                dc.l    word_EB308
                dc.l    word_EB30E
                dc.l    word_EB314
word_2D366:     dc.w    $800, $1800, $1800, $1800, $1800, $1000, $1000, $1000
                                        ; DATA XREF: Enemy_UpdateRotationSprite+26   r
                dc.w    0, 0, 0, 0, $800, $800, $800, $800

; Circular motion with periodic homing missile spawn
Enemy_CircularHomingMotion:                             ; CODE XREF: Enemy_CircleAttackState+1A   p  ; was: sub_2D386
                                        ; Enemy_DescendAttackState+18   p
                move.w  $4C(a5),d0
                andi.w  #$1FE,d0
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d0.w),d1
                move.w  (a1,d0.w),d0
                muls.w  d2,d0
                muls.w  d3,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                move.w  (word_FFA000).w,d0
                add.w   a5,d0
                andi.w  #$7F,d0
                bne.s   locret_2D3E6
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$20,d0                         ; ' '
                bcs.s   locret_2D3E6
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2D3E6
                move.w  a0,$56(a5)
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  d2,d6
                clr.w   d0
                clr.w   d1
                move.w  #$8004,d2
                movea.w $56(a5),a0
                jsr     (Enemy_InitHomingProjectile).l
locret_2D3E6:                                           ; CODE XREF: Enemy_CircularHomingMotion+2C   j
                                        ; Enemy_CircularHomingMotion+38   j
                rts
; End of function Enemy_CircularHomingMotion
; Main update handler for circling enemy type
