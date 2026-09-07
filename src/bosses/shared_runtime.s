Enemy_InitializeState:                                  ; CODE XREF: Enemy_InitializeBoss+6   p  ; was: sub_2BB86
                addq.w  #2,4(a5)
                move.w  #$C700,2(a5)
                move.w  (word_FF808A).w,$E(a5)
                move.b  #$C0,$21(a5)
                move.b  #$30,$23(a5)                    ; '0'
                move.l  #$F808F808,$2C(a5)
                move.l  #$FC04FC04,$28(a5)
                move.w  (word_FFA000).w,$48(a5)
                move.w  #$FFFF,$4C(a5)
                rts
; End of function Enemy_InitializeState
; Updates boss AI with weapon cycling logic
Enemy_UpdateBossAI:                                     ; CODE XREF: Enemy_InitializeBoss:loc_2BCF8   j  ; was: sub_2BBC0
                move.b  #$7C,$20(a5)                    ; '|'
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2BBD2
                clr.b   $20(a5)
loc_2BBD2:                                              ; CODE XREF: Enemy_UpdateBossAI+C   j
                tst.w   $4C(a5)
                bmi.s   loc_2BBFE
                subq.w  #1,$4C(a5)
                btst    #0,$4D(a5)
                bne.s   loc_2BC02
                btst    #7,$22(a5)
                beq.s   loc_2BBF4
                btst    #4,$22(a5)
                beq.s   loc_2BC02
loc_2BBF4:                                              ; CODE XREF: Enemy_UpdateBossAI+2A   j
                move.l  #word_E9952,8(a5)
                bra.s   loc_2BC24
; ---------------------------------------------------------------------------
loc_2BBFE:                                              ; CODE XREF: Enemy_UpdateBossAI+16   j
                addq.w  #1,$48(a5)
loc_2BC02:                                              ; CODE XREF: Enemy_UpdateBossAI+22   j
                                        ; Enemy_UpdateBossAI+32   j
                move.w  $48(a5),d1
                asr.w   #4,d1
                andi.w  #$1C,d1
                cmpi.w  #$18,d1
                bmi.s   loc_2BC18
                moveq   #0,d1
                move.w  d1,$48(a5)
loc_2BC18:                                              ; CODE XREF: Enemy_UpdateBossAI+50   j
                lea     (off_178E6).l,a0
                move.l  (a0,d1.w),8(a5)
loc_2BC24:                                              ; CODE XREF: Enemy_UpdateBossAI+3C   j
                bclr    #3,$22(a5)
                beq.s   loc_2BC54
                btst    #4,$22(a5)
                bne.w   loc_2BC54
                jsr     (UI_GetWeaponIconData).l
                beq.s   loc_2BC54
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  (a0),d0
                asl.w   #5,d0
                move.w  d0,$48(a5)
                move.w  #$18,$4C(a5)
loc_2BC54:                                              ; CODE XREF: Enemy_UpdateBossAI+6A   j
                                        ; Enemy_UpdateBossAI+72   j
                bclr    #7,$22(a5)
                beq.w   loc_2BCE0
                bclr    #4,$22(a5)
                bne.w   loc_2BCE0
                move.b  #$A7,d0
                jsr     (Sound_PlaySFX).l
                jsr     (UI_GetWeaponIconData).l
                beq.s   loc_2BCE6
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  $48(a5),d1
                asr.w   #5,d1
                andi.w  #$E,d1
                cmpi.w  #$C,d1
                bmi.s   loc_2BC94
                moveq   #0,d1
loc_2BC94:                                              ; CODE XREF: Enemy_UpdateBossAI+D0   j
                cmp.w   (a0),d1
                beq.s   loc_2BCBE
                move.w  d1,(a0)
                clr.w   8(a0)
                addq.w  #2,d1
                move.w  d1,(word_FFA21C).w
                asl.w   #1,d1
                move.w  d1,(word_FFA21E).w
                jsr     (UI_ClearWeaponCounters).l
                jsr     (Sys_ClearObjectBlocks16).l
                jsr     (Gfx_LoadPaletteData).l
                bra.s   loc_2BCD2
; ---------------------------------------------------------------------------
loc_2BCBE:                                              ; CODE XREF: Enemy_UpdateBossAI+D6   j
                addi.w  #$FA,$18(a0)
                cmpi.w  #$7D0,$18(a0)
                bmi.s   loc_2BCD2
                move.w  #$7D0,$18(a0)
loc_2BCD2:                                              ; CODE XREF: Enemy_UpdateBossAI+FC   j
                                        ; Enemy_UpdateBossAI+10A   j
                move.w  $18(a0),$10(a0)
                move.w  #$330,(a5)
                clr.b   $21(a5)
loc_2BCE0:                                              ; CODE XREF: Enemy_UpdateBossAI+9A   j
                                        ; Enemy_UpdateBossAI+A4   j
                clr.b   $22(a5)
                rts
; ---------------------------------------------------------------------------
loc_2BCE6:                                              ; CODE XREF: Enemy_UpdateBossAI+B8   j
                bset    #4,2(a5)
                rts
; End of function Enemy_UpdateBossAI
; Initializes boss object and state
Enemy_InitializeBoss:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2BCEE
                tst.w   4(a5)
                bne.s   Enemy_InitializeBossHandler
                bsr.w   Enemy_InitializeState
; Initializes boss enemy and branches to AI update
Enemy_InitializeBossHandler:                            ; CODE XREF: Enemy_InitializeBoss+4   j  ; was: loc_2BCF8
                bra.w   Enemy_UpdateBossAI
; End of function Enemy_InitializeBoss
; Empty entity state handler in main dispatch table
Entity_EmptyState6:                                     ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: nullsub_6
                rts
; End of function Entity_EmptyState6
; Sets sprite pointer a0 from a5 and clears d7
Sprite_SetPointerClearD7:                               ; CODE XREF: Projectile_ExplodeOnWall:loc_2B0FA   p  ; was: sub_2BCFE
                                        ; sub_2B298:loc_2B306   p
                movea.w a5,a0
loc_2BD00:                                              ; CODE XREF: Enemy_BounceOnFloorOrExplode+1E   p
                                        ; Boss_ValkirieInitScreenPair+64   p
                moveq   #0,d7
                bra.w   Sprite_SetFlagsAndReturn
; End of function Sprite_SetPointerClearD7
; Wrapper for Jetsripper boss attack pattern 2 with d7=0
Boss_JetsripperAttackWrapper0:
                movea.w a5,a0                           ; was: sub_2BD06
                moveq   #0,d7
                bra.w   Boss_JetsripperAttackPattern2
; End of function Boss_JetsripperAttackWrapper0
; Wrapper to copy a5 register to a0 for boss operations
Boss_WrapperA5ToA0:
                movea.w a5,a0                           ; was: sub_2BD0E
; End of function Boss_WrapperA5ToA0
; Spawns destruction explosion effect
Effect_SpawnDestructionBlast:                           ; CODE XREF: Boss_JetsripperMain+78   p  ; was: sub_2BD10
                                        ; Boss_JetsripperProjectileUpdate+46   p
                moveq   #1,d7
                bra.w   Sprite_SetFlagsAndReturn
; End of function Effect_SpawnDestructionBlast
; Wrapper for Jetsripper boss attack pattern 2 with d7=1
Boss_JetsripperAttackWrapper1:
                movea.w a5,a0                           ; was: sub_2BD16
loc_2BD18:                                              ; CODE XREF: Boss_JetsripperAttackPattern1+A   j
                                        ; Boss_ArtemisAnimationScript+EC   p
                moveq   #1,d7
                bra.w   Boss_JetsripperAttackPattern2
; End of function Boss_JetsripperAttackWrapper1
; Jetsripper attack pattern state handler
Boss_JetsripperAttackPattern1:                          ; CODE XREF: Boss_SpawnMultipleShots+26   j  ; was: sub_2BD1E
                                        ; Enemy_ProcessObject+18   j
                movea.w a5,a0
loc_2BD20:                                              ; CODE XREF: Boss_InitJetsripperSpread+36   p
                                        ; Boss_WolfGaropaAttackState2+2A   p
                moveq   #0,d7
                move.w  (dword_FFFF08).w,d1
                and.w   d0,d1
                beq.s   loc_2BD18
                bra.w   *+4
; End of function Boss_JetsripperAttackPattern1
; Attributes: thunk
; Jetsripper second attack pattern state
Boss_JetsripperAttackPattern2:                          ; CODE XREF: Boss_JetsripperAttackWrapper0+4   j  ; was: sub_2BD2E
                                        ; Boss_JetsripperAttackWrapper1+4   j
                bra.s   Sprite_SetFlagsAndReturn
; End of function Boss_JetsripperAttackPattern2
; Spawns destruction blast effect if under sprite limit, handles parameters
Effect_CreateDestructionBlast:
                move.w  (word_FFA216).w,d0              ; was: sub_2BD30
                cmp.w   (word_FFA218).w,d0
                bne.s   Sprite_SetFlagsAndReturn
loc_2BD3A:                                              ; CODE XREF: Effect_CreateDestructionBlast+1C   j
                move.w  #$10,(a0)
                bset    #4,2(a0)
                rts
; ---------------------------------------------------------------------------
; Spawns destruction blast effect with proper sprite setup
Sprite_SetFlagsAndReturn:                               ; CODE XREF: Sprite_SetPointerClearD7+4   j  ; was: loc_2BD46
                                        ; Effect_SpawnDestructionBlast+2   j
                cmpi.w  #6,(word_FF8126).w
                bpl.s   loc_2BD3A
                move.w  #$194,(a0)
                move.w  #$E140,2(a0)
                move.w  #$480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                clr.w   $C(a0)
                clr.b   $20(a0)
                move.b  #$40,$21(a0)                    ; '@'
                clr.b   $22(a0)
                move.b  #$20,$23(a0)                    ; ' '
                move.l  #$FA06FA06,$2C(a0)
                move.b  byte_2BDA2(pc,d7.w),$4C(a0)
                asl.w   #1,d7
                move.w  word_2BDA4(pc,d7.w),$48(a0)
                asl.w   #1,d7
                move.l  off_2BDA8(pc,d7.w),8(a0)
                move.w  #$A0,$4A(a0)
                rts
; End of function Effect_CreateDestructionBlast
; ---------------------------------------------------------------------------
byte_2BDA2:     dc.b    $46, $47                        ; DATA XREF: Effect_CreateDestructionBlast+54   r
word_2BDA4:     dc.w    $1E, $64                        ; DATA XREF: Effect_CreateDestructionBlast+5C   r
off_2BDA8:      dc.l    off_E97E0                       ; DATA XREF: Effect_CreateDestructionBlast+64   r
                dc.l    off_E97D4

; Dispatches to boss state handler based on state index
Boss_StateDispatcher:                                   ; CODE XREF: Boss_ValkirieScreenTimer:loc_50E36   j  ; was: sub_2BDB0
                                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o
                subq.w  #1,$4A(a5)
                bmi.s   loc_2BE1E
                cmpi.w  #$20,$4A(a5)                    ; ' '
                bpl.s   loc_2BDD2
                bset    #7,2(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2BDD2
                bclr    #7,2(a5)
loc_2BDD2:                                              ; CODE XREF: Boss_StateDispatcher+C   j
                                        ; Boss_StateDispatcher+1A   j
                bclr    #7,$22(a5)
                beq.s   loc_2BE26
                bclr    #4,$22(a5)
                bne.s   loc_2BE26
                move.b  $4C(a5),d0
                jsr     (Sound_PlaySFX).l
                move.l  #$500,d0
                jsr     (UI_AddScoreBCD).l
                move.w  (word_FFA216).w,d0
                beq.s   loc_2BE0E
                bmi.s   loc_2BE0E
                add.w   $48(a5),d0
                cmp.w   (word_FFA218).w,d0
                bmi.s   loc_2BE0E
                move.w  (word_FFA218).w,d0
loc_2BE0E:                                              ; CODE XREF: Boss_StateDispatcher+4C   j
                                        ; Boss_StateDispatcher+4E   j
                move.w  d0,(word_FFA216).w
                move.w  $48(a5),(word_FF8262).w
                move.w  #$30,(word_FF8268).w            ; '0'
loc_2BE1E:                                              ; CODE XREF: Boss_StateDispatcher+4   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2BE26:                                              ; CODE XREF: Boss_StateDispatcher+28   j
                                        ; Boss_StateDispatcher+30   j
                andi.w  #$E7FF,$E(a5)
                lea     (Object_CameraPriorityTable).l,a0
                move.w  (word_FFA000).w,d0
                asr.w   #1,d0
                andi.w  #6,d0
                move.w  (a0,d0.w),d0
                or.w    d0,$E(a5)
                move.l  (dword_FF8240).w,d0
                add.l   d0,$10(a5)
                move.l  (dword_FF830A).w,d0
                add.l   d0,$14(a5)
                rts
; End of function Boss_StateDispatcher
; Sets animation data pointer with d0=3 and pointer to off_E953C
Gfx_SetAnimationPointer:                                ; CODE XREF: Sprite_InitializeObject+78   p  ; was: sub_2BE56
                                        ; Sprite_InitializeObject+86   p
                move.w  #3,d0
                movea.l #off_E953C,a1
; End of function Gfx_SetAnimationPointer
; Spawns multiple projectiles in pattern
Projectile_SpawnMultiPattern:                           ; CODE XREF: Projectile_SnakeSpawn3Way+26   p  ; was: sub_2BE60
                                        ; Projectile_SnakeSpawn3Way+3C   p
                move.w  #1,d7
                lsl.w   d0,d7
                subq.w  #1,d7
                move.w  #$1FF,d6
                lsr.w   d0,d6
                andi.w  #$1FE,d6
loc_2BE72:                                              ; CODE XREF: Projectile_SpawnMultiPattern:loc_2BEB6   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   loc_2BEB6
                andi.w  #$1FE,d2
                lea     (Math_SineTable).l,a2
                move.w  (a2,d2.w),d4
                move.w  -$80(a2,d2.w),d5
                ext.l   d4
                ext.l   d5
                asl.l   d1,d4
                asl.l   d1,d5
                move.l  d4,$18(a0)
                move.l  d5,$1C(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.l  a1,8(a0)
                jsr     (Sprite_InitType160).l
                add.w   d6,d2
loc_2BEB6:                                              ; CODE XREF: Projectile_SpawnMultiPattern+18   j
                dbf     d7,loc_2BE72
                rts
; End of function Projectile_SpawnMultiPattern
; Projectile explosion creating sprite with sound effect playback
Projectile_ExplodeWithSound:                            ; CODE XREF: Boss_SpawnMultipleShots+E   p  ; was: sub_2BEBC
                                        ; Projectile_JetsripperFalling+E   p
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   nullsub_61
                move.l  #off_E953C,8(a0)
                move.w  #$1A0,(a0)
                move.w  #6,$4A(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                move.w  d0,$4C(a0)
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                bra.s   Effect_InitializeExplosionEffect
; End of function Projectile_ExplodeWithSound
; Explosion effect when projectile hits
Projectile_ExplodeOnImpact:                             ; CODE XREF: Enemy_ProcessObject+10   p  ; was: sub_2BEF0
                                        ; Projectile_BouncingDebrisMain+9A   p
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   nullsub_61
                move.w  #8,$4A(a0)
                move.w  #$1A4,(a0)
                move.l  #off_E9560,8(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                move.w  d0,$4C(a0)
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
; Initializes explosion effect at entity position with palette
Effect_InitializeExplosionEffect:                       ; CODE XREF: Projectile_ExplodeWithSound+32   j  ; was: loc_2BF22
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  #$ED40,2(a0)
                move.w  #$480,$E(a0)
                clr.w   $C(a0)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a0)
                clr.b   $21(a0)
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                rts
; End of function Projectile_ExplodeOnImpact
; Updates enemy phase pattern based on timer
Enemy_UpdatePhasePattern:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2BF58
                cmpi.w  #$80,$C(a5)
                bcc.w   Enemy_CheckHealthThreshold
                cmpi.w  #$80,$10(a5)
                bcs.w   Enemy_CheckHealthThreshold
                cmpi.w  #$1C0,$10(a5)
                bhi.w   Enemy_CheckHealthThreshold
                cmpi.w  #$80,$14(a5)
                bcs.w   Enemy_CheckHealthThreshold
                cmpi.w  #$160,$14(a5)
                bhi.w   Enemy_CheckHealthThreshold
                bsr.w   Enemy_PhaseHandler
                move.w  $4C(a5),d0
                add.w   d0,d0
                move.w  d0,d0
                lea     off_2BF9E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_UpdatePhasePattern
; ---------------------------------------------------------------------------
off_2BF9E:      dc.w    Projectile_SetFallVelocity-*    ; DATA XREF: Enemy_UpdatePhasePattern+3E   o
                dc.w    Enemy_PhaseStateDispatcher-*
                dc.w    Projectile_PhaseDispatcher-*
                dc.w    Projectile_PhaseDispatcher-*

; Sets falling velocity based on flag
Projectile_SetFallVelocity:                             ; DATA XREF: ROM:off_2BF9E   o  ; was: sub_2BFA6
                tst.w   $4E(a5)
                bne.s   loc_2BFB6
                move.l  #$FFFC0000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2BFB6:                                              ; CODE XREF: Projectile_SetFallVelocity+4   j
                subi.l  #$4000,$1C(a5)
                rts
; End of function Projectile_SetFallVelocity
; Enemy phase state dispatcher using jump table for substates
Enemy_PhaseStateDispatcher:                             ; DATA XREF: ROM:0002BFA0   o  ; was: sub_2BFC0
                move.w  $4E(a5),d0
                lea     off_2BFCC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_PhaseStateDispatcher
; ---------------------------------------------------------------------------
off_2BFCC:      dc.w    Enemy_TargetPlayer-*            ; DATA XREF: Enemy_PhaseStateDispatcher+4   o
                dc.w    Physics_ApplyPositiveGravity-*

; Calculates angle to player and sets velocity with upward trajectory
Enemy_TargetPlayer:                                     ; DATA XREF: ROM:off_2BFCC   o  ; was: sub_2BFD0
                jsr     (Math_CalculateAngleToPlayer).l
                addi.w  #$100,d2
                andi.w  #$1FE,d2
                lea     (Math_SineTable).l,a1
                move.w  (a1,d2.w),d0
                ext.l   d0
                asl.l   #4,d0
                move.l  d0,$18(a5)
                move.l  #$FFFE0000,$1C(a5)
                addq.w  #2,$4E(a5)
                rts
; End of function Enemy_TargetPlayer
; Applies positive gravity acceleration to vertical velocity
Physics_ApplyPositiveGravity:                           ; DATA XREF: ROM:0002BFCE   o  ; was: sub_2BFFE
                addi.l  #$4000,$1C(a5)
                rts
; End of function Physics_ApplyPositiveGravity
; Projectile phase state dispatcher using jump table pattern
Projectile_PhaseDispatcher:                             ; DATA XREF: ROM:0002BFA2   o  ; was: sub_2C008
                                        ; ROM:0002BFA4   o
                move.w  $4E(a5),d0
                lea     off_2C014(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_PhaseDispatcher
; ---------------------------------------------------------------------------
off_2C014:      dc.w    Projectile_RandomAngleInit-*    ; DATA XREF: Projectile_PhaseDispatcher+4   o
                dc.w    Projectile_InitRandomAngle-*
                dc.w    Projectile_SpiralMotion-*

; Initializes projectile with random angle from RNG table
Projectile_RandomAngleInit:                             ; DATA XREF: ROM:off_2C014   o  ; was: sub_2C01A
                move.w  (dword_FFFF08).w,$5E(a5)
                addq.w  #2,$4E(a5)
; Initializes projectile with random angle from RNG table
Projectile_InitRandomAngle:                             ; DATA XREF: ROM:0002C016   o  ; was: loc_2C024
                andi.w  #$1FE,$5E(a5)
                move.w  $5E(a5),d2
                lea     (Math_SineTable).l,a1
                move.w  (a1,d2.w),d0
                move.w  -$80(a1,d2.w),d1
                ext.l   d0
                asl.l   #4,d0
                ext.l   d1
                asl.l   #4,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                move.w  #4,$5A(a5)
                addq.w  #2,$4E(a5)
                rts
; End of function Projectile_RandomAngleInit
; Projectile spiral motion pattern decreasing angle each frame
Projectile_SpiralMotion:                                ; DATA XREF: ROM:0002C018   o  ; was: sub_2C058
                subq.w  #1,$5A(a5)
                bne.w   nullsub_61
                cmpi.w  #3,$4C(a5)
                beq.s   Projectile_ClearStateTimer
                addi.w  #-$40,$5E(a5)
                subq.w  #2,$4E(a5)
                rts
; ---------------------------------------------------------------------------
; Clears projectile state timer when condition met
Projectile_ClearStateTimer:                             ; CODE XREF: Projectile_SpiralMotion+E   j  ; was: loc_2C074
                clr.w   $4E(a5)
                rts
; End of function Projectile_SpiralMotion
; Enemy phase handler dispatcher for multi-phase attack patterns
Enemy_PhaseHandler:                                     ; CODE XREF: Enemy_UpdatePhasePattern+32   p  ; was: sub_2C07A
                move.w  4(a5),d0
                lea     off_2C086(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_PhaseHandler
; ---------------------------------------------------------------------------
off_2C086:      dc.w    Enemy_SpawnHelperSprite-*       ; DATA XREF: Enemy_PhaseHandler+4   o
                dc.w    Enemy_HelperTimer-*
                dc.w    Enemy_CheckHealthThreshold-*

; Spawns helper sprite for enemy with position and state init
Enemy_SpawnHelperSprite:                                ; DATA XREF: ROM:off_2C086   o  ; was: sub_2C08C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   nullsub_61
                move.l  #off_E9560,8(a0)
                jsr     (Sprite_InitType160).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_SpawnHelperSprite
; Helper sprite timer countdown looping or advancing phase
Enemy_HelperTimer:                                      ; DATA XREF: ROM:0002C088   o  ; was: sub_2C0BC
                subq.w  #1,$48(a5)
                bne.w   nullsub_61
                subq.w  #1,$4A(a5)
                beq.s   loc_2C0D0
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C0D0:                                              ; CODE XREF: Enemy_HelperTimer+C   j
                addq.w  #2,4(a5)
                rts
; End of function Enemy_HelperTimer
; Checks enemy health against threshold value
Enemy_CheckHealthThreshold:                             ; CODE XREF: Enemy_UpdatePhasePattern+6   j  ; was: sub_2C0D6
                                        ; Enemy_UpdatePhasePattern+10   j
                bset    #4,2(a5)
                rts
; End of function Enemy_CheckHealthThreshold
; Boss part state dispatcher using jump table
Enemy_BossPartDispatcher:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2C0DE
                cmpi.w  #$80,$C(a5)
                bcc.w   Enemy_CheckHealthThreshold
                move.w  $4C(a5),d0
                add.w   d0,d0
                move.w  d0,d0
                lea     off_2C0F8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_BossPartDispatcher
; ---------------------------------------------------------------------------
off_2C0F8:      dc.w    Projectile_SnakeDispatcher-*    ; DATA XREF: Enemy_BossPartDispatcher+12   o
                dc.w    Projectile_SnakeSpawn3Way-*
                dc.w    Projectile_SnakeSpawn6Way-*
                dc.w    Projectile_SnakeSpawn8Way-*

; State dispatcher for Snake projectile
