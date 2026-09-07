Enemy_GustheadEyeMain:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_310E6
                bsr.w   Enemy_GustheadEyeDestroy
                move.w  4(a5),d0
                lea     off_310F6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_GustheadEyeMain
; ---------------------------------------------------------------------------
off_310F6:      dc.w    Enemy_GustheadEyeInit-*         ; DATA XREF: Enemy_GustheadEyeMain+8   o
                dc.w    Enemy_GustheadEyeSpawnChain-*
                dc.w    nullsub_74-*

; Initializes Gusthead eye sprite
Enemy_GustheadEyeInit:                                  ; DATA XREF: ROM:off_310F6   o  ; was: sub_310FC
                move.w  #$D00,2(a5)
                move.b  #$50,$20(a5)                    ; 'P'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_GustheadEyeInit
; Spawns chain of 8 projectiles
Enemy_GustheadEyeSpawnChain:                            ; DATA XREF: ROM:000310F8   o  ; was: sub_3110E
                cmpi.w  #$180,$10(a5)
                bcc.w   locret_30BB8
                move.w  #7,d7
                move.w  a5,$44(a5)
loc_31120:                                              ; CODE XREF: Enemy_GustheadEyeSpawnChain+44   j
                jsr     (Projectile_FindFreeSlotAndClear).l
                bne.s   loc_31164
                movea.w $44(a5),a1
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                move.w  #$394,(a0)
                move.w  d7,d1
                lsl.w   #3,d1
                addq.w  #1,d1
                move.w  d1,$46(a0)
                clr.w   4(a0)
                move.w  a1,$44(a0)
                move.w  a0,$44(a5)
                dbf     d7,loc_31120
                move.w  #$398,(a0)
                move.w  a5,$48(a0)
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_31164:                                              ; CODE XREF: Enemy_GustheadEyeSpawnChain+18   j
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_GustheadEyeSpawnChain
nullsub_74:                                             ; DATA XREF: ROM:000310FA   o
                rts
; End of function nullsub_74

; Destroys eye and projectile chain
Enemy_GustheadEyeDestroy:                               ; CODE XREF: Enemy_GustheadEyeMain   p  ; was: sub_3116E
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcc.w   locret_30BB8
                movea.w a5,a4
                move.w  #7,d7
loc_3117E:                                              ; CODE XREF: Enemy_GustheadEyeDestroy:loc_3118E   j
                tst.w   $44(a4)
                beq.s   loc_3118E
                movea.w $44(a4),a4
                move.w  #$1000,2(a4)
loc_3118E:                                              ; CODE XREF: Enemy_GustheadEyeDestroy+14   j
                dbf     d7,loc_3117E
                rts
; End of function Enemy_GustheadEyeDestroy
; Main dispatcher for small eye
Enemy_GustheadSmallEyeMain:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_31194
                move.w  4(a5),d0
                lea     off_311A0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_GustheadSmallEyeMain
; ---------------------------------------------------------------------------
off_311A0:      dc.w    Enemy_GustheadSmallEyeInit-*    ; DATA XREF: Enemy_GustheadSmallEyeMain+4   o
                dc.w    Enemy_GustheadSmallEyeWait-*
                dc.w    Enemy_GustheadSmallEyeAttack-*
                dc.w    Enemy_GustheadSmallEyeUpdate-*
                dc.w    Boss_GustheadRotateAndRepeatAttack-*
                dc.w    Boss_GustheadRotateToHome-*
                dc.w    Boss_GustheadFallAndSpawnSlowProjectiles-*

; Initializes small eye enemy
Enemy_GustheadSmallEyeInit:                             ; DATA XREF: ROM:off_311A0   o  ; was: sub_311AE
                move.w  #$CD00,2(a5)
                move.w  #$1B9,$E(a5)
                move.l  #word_EB350,8(a5)
                move.b  #$60,$20(a5)                    ; '`'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_GustheadSmallEyeInit
; Wait state before spawning
Enemy_GustheadSmallEyeWait:                             ; DATA XREF: ROM:000311A2   o  ; was: sub_311CE
                bsr.w   Enemy_GustheadUpdatePosition
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.w  #$180,$40(a5)
                clr.w   $42(a5)
                move.w  #4,4(a5)
loc_311EA:                                              ; CODE XREF: Enemy_GustheadSmallEyeSpawn+26   j
                                        ; Enemy_GustheadSmallEyeCheckSpawn+8   j
                jsr     (RandomNumber).l
                andi.w  #$FE,d0
                addi.w  #$100,d0
                move.w  d0,d4
                move.w  $10(a5),d5
                move.w  #$148,d6
                jmp     Enemy_SpawnProjectileAtAngle
; End of function Enemy_GustheadSmallEyeWait
; Spawns projectile with sound
Enemy_GustheadSmallEyeSpawn:                            ; DATA XREF: ROM:000313B6   o  ; was: sub_31208
                bsr.w   Enemy_GustheadUpdatePosition
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.w  #$180,$40(a5)
                clr.w   $42(a5)
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
                move.w  #4,4(a5)
                bra.w   loc_311EA
; End of function Enemy_GustheadSmallEyeSpawn
; Attack state with projectile spawn
Enemy_GustheadSmallEyeAttack:                           ; DATA XREF: ROM:000311A4   o  ; was: sub_31232
                                        ; ROM:000313B8   o
                bsr.w   Enemy_GustheadUpdatePosition
                bsr.w   Enemy_GustheadSmallEyeCheckSpawn
                addq.w  #8,$42(a5)
                cmpi.w  #$40,$42(a5)                    ; '@'
                bne.w   locret_30BB8
                move.w  #3,$46(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_GustheadSmallEyeAttack
; Updates small eye position
Enemy_GustheadSmallEyeUpdate:                           ; DATA XREF: ROM:000311A6   o  ; was: sub_31254
                                        ; ROM:000313BA   o
                bsr.w   Enemy_GustheadUpdatePosition
                subq.w  #2,$40(a5)
                cmpi.w  #$140,$40(a5)
                bcc.w   locret_30BB8
                addq.w  #2,4(a5)
                rts
; End of function Enemy_GustheadSmallEyeUpdate
; Spawns projectile in direction of player when animation frame equals 19Eh
Boss_JetsripperSpawnDirectionalProjectileAtFrame:       ; CODE XREF: Boss_JetsripperSpawnDirectionalWrapper   p  ; was: sub_3126C
                cmpi.w  #$19E,$40(a5)
                bne.w   locret_30BB8
                move.w  $10(a5),d5
                move.w  $14(a5),d6
                move.w  #2,d3
                move.w  (dword_FFA410).w,d0
                cmp.w   $10(a5),d0
                bcs.s   loc_31292
                clr.w   d4
                bra.w   Boss_JetsripperSpawnDirectionalProjectile
; ---------------------------------------------------------------------------
loc_31292:                                              ; CODE XREF: Boss_JetsripperSpawnDirectionalProjectileAtFrame+1E   j
                move.w  #$10,d4
                bra.w   Boss_JetsripperSpawnDirectionalProjectile
; End of function Boss_JetsripperSpawnDirectionalProjectileAtFrame
; Wrapper function calling directional projectile spawn check
Boss_JetsripperSpawnDirectionalWrapper:                 ; DATA XREF: ROM:000313BC   o  ; was: sub_3129A
                bsr.w   Boss_JetsripperSpawnDirectionalProjectileAtFrame
; End of function Boss_JetsripperSpawnDirectionalWrapper
; Updates position and increments rotation counter, repeats attack pattern or advances state
Boss_GustheadRotateAndRepeatAttack:                     ; DATA XREF: ROM:000311A8   o  ; was: sub_3129E
                bsr.w   Enemy_GustheadUpdatePosition
                addq.w  #2,$40(a5)
                cmpi.w  #$1A0,$40(a5)
                bcs.w   locret_30BB8
                subq.w  #1,$46(a5)
                beq.s   loc_312BC
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_312BC:                                              ; CODE XREF: Boss_GustheadRotateAndRepeatAttack+16   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadRotateAndRepeatAttack
; Updates position and decrements rotation counter until reaching home angle FFF8h
Boss_GustheadRotateToHome:                              ; DATA XREF: ROM:000311AA   o  ; was: sub_312C2
                bsr.w   Enemy_GustheadUpdatePosition
                subq.w  #8,$42(a5)
                cmpi.w  #$FFF8,$42(a5)
                bne.w   locret_30BB8
                move.w  #$C0,$46(a5)
                move.w  #2,4(a5)
                rts
; End of function Boss_GustheadRotateToHome
; Updates position, spawns small eyes, rotates to home angle, plays sound effect 4Dh
Boss_GustheadRotateSpawnEyesAndSound:                   ; DATA XREF: ROM:000313BE   o  ; was: sub_312E2
                bsr.w   Enemy_GustheadUpdatePosition
                bsr.w   Enemy_GustheadSmallEyeCheckSpawn
                subq.w  #8,$42(a5)
                cmpi.w  #$FFF8,$42(a5)
                bne.w   locret_30BB8
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
                move.w  #$C0,$46(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadRotateSpawnEyesAndSound
; Checks if should spawn projectile
Enemy_GustheadSmallEyeCheckSpawn:                       ; CODE XREF: Enemy_GustheadSmallEyeAttack+4   p  ; was: sub_3130E
                                        ; Boss_GustheadRotateSpawnEyesAndSound+4   p
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                beq.w   loc_311EA
                rts
; End of function Enemy_GustheadSmallEyeCheckSpawn
; Updates position and spawns small eyes while waiting for timer to reach A0h
Boss_GustheadWaitAndSpawnEyes:                          ; DATA XREF: ROM:000313C0   o  ; was: sub_3131C
                bsr.w   Enemy_GustheadUpdatePosition
                bsr.w   Enemy_GustheadSmallEyeCheckSpawn
                subq.w  #1,$46(a5)
                cmpi.w  #$A0,$46(a5)
                bne.w   locret_30BB8
                move.w  #2,4(a5)
                rts
; End of function Boss_GustheadWaitAndSpawnEyes
; Calculates angle to player
Enemy_GustheadGetAngleToPlayer:                         ; CODE XREF: Enemy_Stage18FloaterDeath+42   p  ; was: sub_3133A
                                        ; Boss_CalcRandomAngle+E   p
                lea     (word_1B494).l,a0
                move.w  (a0,d0.w),d1
                addi.w  #$80,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d0
                rts
; End of function Enemy_GustheadGetAngleToPlayer
; Main handler for eye chain projectile
Enemy_GustheadEyeChainMain:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_31352
                cmpi.w  #$E,4(a5)
                bcc.w   loc_313A8
                tst.w   $24(a5)
                bpl.w   loc_313A8
                movea.w $48(a5),a4
                move.w  #7,d7
loc_3136C:                                              ; CODE XREF: Enemy_GustheadEyeChainMain+4A   j
                movea.w $44(a4),a4
                move.w  #$C,4(a4)
                jsr     (RandomNumber).l
                andi.w  #$7E,d0                         ; '~'
                addi.w  #$140,d0
                bsr.w   Enemy_GustheadGetAngleToPlayer
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a4)
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a4)
                clr.b   $21(a4)
                dbf     d7,loc_3136C
                move.w  #$E,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_313A8:                                              ; CODE XREF: Enemy_GustheadEyeChainMain+6   j
                                        ; Enemy_GustheadEyeChainMain+E   j
                move.w  4(a5),d0
                lea     off_313B4(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_GustheadEyeChainMain
; ---------------------------------------------------------------------------
off_313B4:      dc.w    Enemy_GustheadEyeChainInit-*    ; DATA XREF: Enemy_GustheadEyeChainMain+5A   o
                dc.w    Enemy_GustheadSmallEyeSpawn-*
                dc.w    Enemy_GustheadSmallEyeAttack-*
                dc.w    Enemy_GustheadSmallEyeUpdate-*
                dc.w    Boss_JetsripperSpawnDirectionalWrapper-*
                dc.w    Boss_GustheadRotateSpawnEyesAndSound-*
                dc.w    Boss_GustheadWaitAndSpawnEyes-*
                dc.w    Boss_GustheadFallAndSpawnProjectiles-*

; Initializes eye chain segment
Enemy_GustheadEyeChainInit:                             ; DATA XREF: ROM:off_313B4   o  ; was: sub_313C4
                move.w  #$CD00,2(a5)
                move.w  #$1B9,$E(a5)
                move.l  #word_EB338,8(a5)
                move.b  #$5C,$20(a5)                    ; '\'
                move.w  #$64,$24(a5)                    ; 'd'
                move.b  #$C0,$21(a5)
                move.l  #$F010F010,$2C(a5)
                move.l  #$E818E818,$28(a5)
                clr.b   $22(a5)
                move.b  #5,$23(a5)
                move.w  #$28,$26(a5)                    ; '('
                addq.w  #2,4(a5)
                rts
; End of function Enemy_GustheadEyeChainInit
; Accelerates downward and spawns doubled-velocity projectiles every 4 frames until Y >= 1A0h
Boss_GustheadFallAndSpawnProjectiles:                   ; DATA XREF: ROM:000313C2   o  ; was: sub_31410
                addi.l  #$1800,$1C(a5)
                cmpi.w  #$1A0,$14(a5)
                bcc.w   Boss_GustheadResetState
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                bne.w   locret_30BB8
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                bsr.w   Boss_GustheadSpawnAngleProjectile
                asl     $18(a4)
                asl     $1C(a4)
                rts
; End of function Boss_GustheadFallAndSpawnProjectiles
; Accelerates downward slowly and spawns projectiles every 8 frames until Y >= 180h
Boss_GustheadFallAndSpawnSlowProjectiles:               ; DATA XREF: ROM:000311AC   o  ; was: sub_31446
                addi.l  #$1000,$1C(a5)
                cmpi.w  #$180,$14(a5)
                bcc.s   Boss_GustheadResetState
                move.w  (word_FFA280).w,d0
                andi.w  #7,d0
                bne.w   locret_30BB8
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
; End of function Boss_GustheadFallAndSpawnSlowProjectiles
; Spawns projectile with sound BBh at calculated angle toward player with offset positioning
Boss_GustheadSpawnAngleProjectile:                      ; CODE XREF: Boss_JetsripperSpawnUpwardProjectile+16   p  ; was: sub_3146C
                                        ; Boss_GustheadFallAndSpawnProjectiles+28   p
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                move.l  #off_E95DC,8(a0)
                jsr     (Projectile_InitType88).l
                movea.w a0,a4
                jsr     (RandomNumber).l
                andi.w  #$1FE,d0
                bsr.w   Enemy_GustheadGetAngleToPlayer
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a4)
                asl.l   #2,d0
                add.l   $10(a5),d0
                move.l  d0,$10(a4)
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a4)
                asl.l   #2,d1
                add.l   $14(a5),d1
                move.l  d1,$14(a4)
                rts
; End of function Boss_GustheadSpawnAngleProjectile
; Resets boss state to 1000h value
Boss_GustheadResetState:                                ; CODE XREF: Boss_GustheadFallAndSpawnProjectiles+E   j  ; was: sub_314BA
                                        ; Boss_GustheadFallAndSpawnSlowProjectiles+E   j
                move.w  #$1000,2(a5)
                rts
; End of function Boss_GustheadResetState
; Updates entity slot
Enemy_UpdateEntitySlot:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_314C2
                move.w  $48(a5),d0
                lea     off_314CE(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_UpdateEntitySlot
; ---------------------------------------------------------------------------
off_314CE:      dc.w    Boss_DestroyerProtoMain-*       ; DATA XREF: Enemy_UpdateEntitySlot+4   o
                dc.w    Boss_DestroyerProtoState4-*
                dc.w    Boss_DestroyerProtoState5-*
                dc.w    Projectile_DestroyerProtoMain-*
                dc.w    Enemy_Stage14TurretInit-*

; Main boss handler
