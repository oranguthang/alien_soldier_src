Player_SpawnProjectile:                                 ; CODE XREF: Player_PhoenixAttackUpdate+56   p  ; was: sub_173FA
                                        ; Player_InitiateDashAttack+80   p
                move.b  #$41,d0                         ; 'A'
                jsr     (Sound_PlaySFX).l
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w            ; ' '
                move.b  #2,(byte_FF8143).w
                movea.w #(word_FFC5C0-M68K_RAM),a0
                move.w  #$230,(a0)
                move.b  #$54,$21(a0)                    ; 'T'
                move.w  #$4000,2(a0)
                move.l  #word_E8F22,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                eori.w  #$1000,$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                tst.w   (word_FFFF0E).w
                bne.s   loc_17476
                move.w  #$26,$26(a0)                    ; '&'
                subi.w  #$1E,(word_FFA216).w
                move.w  #$801E,(word_FF8262).w
                move.w  #$30,(word_FF8268).w            ; '0'
                rts
; ---------------------------------------------------------------------------
loc_17476:                                              ; CODE XREF: Player_SpawnProjectile+60   j
                move.w  #$23,$26(a0)                    ; '#'
                subi.w  #$32,(word_FFA216).w            ; '2'
                move.w  #$8032,(word_FF8262).w
                move.w  #$30,(word_FF8268).w            ; '0'
                rts
; End of function Player_SpawnProjectile
; Calculates weapon data table offset
Player_GetWeaponTableOffset:
                bne.s   loc_17498                       ; was: sub_17490
                bset    #1,(byte_FF8244).w
loc_17498:                                              ; CODE XREF: Player_GetWeaponTableOffset   j
                movea.l $48(a5),a0
                move.w  (word_FFA000).w,d0
                asr.w   #1,d0
                andi.w  #$C,d0
                rts
; End of function Player_GetWeaponTableOffset
; Handles stage progression after boss defeat
Stage_HandleBossDefeat:                                 ; CODE XREF: Player_HandleAirMovement+70   j  ; was: sub_174A8
                                        ; Player_HandleFallingState+D6   j
                movea.w #(byte_FF8780-M68K_RAM),a3
                move.l  a3,8(a5)
                clr.l   $DC(a5)
                moveq   #$F,d4
                ext.w   d5
                asl.w   #8,d6
loc_174BA:                                              ; CODE XREF: Stage_HandleBossDefeat+2C   j
                move.w  (a1)+,d0
                bclr    d4,d0
                bne.s   loc_174D6
                move.w  d0,(a3)+
                move.l  (a1)+,(a3)+
                move.w  (a1)+,d1
                move.w  d1,d2
                andi.w  #$FF00,d2
                add.w   d6,d2
                add.b   d5,d1
                move.b  d1,d2
                move.w  d2,(a3)+
                bra.s   loc_174BA
; ---------------------------------------------------------------------------
loc_174D6:                                              ; CODE XREF: Stage_HandleBossDefeat+16   j
                move.w  d0,(a3)+
                andi.w  #$3FF,d0
                moveq   #0,d1
                move.b  (a1),d1
                move.w  d1,d2
                andi.w  #3,d2
                addq.w  #1,d2
                lsr.w   #2,d1
                addq.w  #1,d1
                muls.w  d2,d1
                add.w   d1,d0
                move.l  (a1)+,(a3)+
                move.w  (a1)+,d1
                move.w  d1,d2
                andi.w  #$FF00,d2
                add.w   d6,d2
                add.b   d5,d1
                move.b  d1,d2
                move.w  d2,(a3)+
loc_17502:                                              ; CODE XREF: Stage_HandleBossDefeat+68   j
                move.w  (a2)+,d1
                move.w  d1,d2
                add.w   d0,d2
                move.w  d2,(a3)+
                move.l  (a2)+,(a3)+
                move.w  (a2)+,(a3)+
                btst    d4,d1
                beq.s   loc_17502
                rts
; End of function Stage_HandleBossDefeat
; Spawns particle effect with random velocity
Effect_SpawnParticle:                                   ; CODE XREF: Player_HandleJump+14   p  ; was: sub_17514
                                        ; Player_HandleDashState+16   p
                btst    #4,$69(a5)
                bne.w   locret_175B6
                move.w  (dword_FFFF08+2).w,d0
                andi.w  #$E000,d0
                bne.w   locret_175B6
                bsr.w   Sprite_AllocateSlot
                bne.w   locret_175B6
                lea     (Effect_SharedParticleSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                lea     (word_1B514).l,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                asl.l   d0,d1
                move.w  (dword_FFFF08).w,d0
                asr.w   #1,d0
                andi.w  #3,d0
                asl.l   d0,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                movem.l a0,-(sp)
                jsr     (RandomNumber).l
                movem.l (sp)+,a0
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                moveq   #$10,d1
                btst    #4,$E(a5)
                beq.s   loc_175A4
                moveq   #$10,d1
loc_175A4:                                              ; CODE XREF: Effect_SpawnParticle+8C   j
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$1F,d0
                sub.w   d1,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
locret_175B6:                                           ; CODE XREF: Effect_SpawnParticle+6   j
                                        ; Effect_SpawnParticle+12   j
                rts
; End of function Effect_SpawnParticle
; Spawns Phoenix particle effects
Player_SpawnPhoenixParticles:
                subq.w  #1,$4A(a5)                      ; was: sub_175B8
                bpl.w   locret_17640
                move.w  #$FFFF,$4A(a5)
                btst    #4,$69(a5)
                bne.w   locret_17640
                subq.w  #2,(word_FF8304).w
                bpl.s   loc_175DA
                clr.w   (word_FF8304).w
loc_175DA:                                              ; CODE XREF: Player_SpawnPhoenixParticles+1C   j
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_175EE
                move.b  #$AC,d0
                jsr     (Sound_PlaySFX).l
loc_175EE:                                              ; CODE XREF: Player_SpawnPhoenixParticles+2A   j
                bsr.w   Sprite_AllocateSlot
                bne.w   locret_17640
                lea     (Effect_SharedParticleSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                lea     (word_1B514).l,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #4,d1
                asl.l   #4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                asl.l   #3,d1
                asl.l   #3,d2
                move.w  $14(a5),$14(a0)
                sub.l   d1,$14(a0)
                move.w  $10(a5),$10(a0)
                sub.l   d2,$10(a0)
locret_17640:                                           ; CODE XREF: Player_SpawnPhoenixParticles+4   j
                                        ; Player_SpawnPhoenixParticles+14   j
                rts
; End of function Player_SpawnPhoenixParticles
; Spawns three projectiles in spread pattern for special attack
Player_SpawnTripleShot:                                 ; CODE XREF: Player_InitSpecialAttack+56   j  ; was: sub_17642
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                move.w  $10(a5),d4
                moveq   #3,d5
                moveq   #2,d7
                btst    #3,$E(a5)
                beq.s   loc_1765E
                move.w  #$C0,d6
                subq.w  #8,d4
                bra.s   loc_17664
; ---------------------------------------------------------------------------
loc_1765E:                                              ; CODE XREF: Player_SpawnTripleShot+12   j
                addq.w  #8,d4
                move.w  #$1E0,d6
loc_17664:                                              ; CODE XREF: Player_SpawnTripleShot+1A   j
                                        ; Player_SpawnTripleShot+30   j
                move.l  #off_E9560,8(a0)
                bsr.s   Player_InitShotProjectile
                addi.w  #$40,d6                         ; '@'
                dbf     d7,loc_17664
                rts
; End of function Player_SpawnTripleShot
; Spawns 5 projectiles in radial spread
Player_SpawnRadialShot:
                moveq   #4,d5                           ; was: sub_17678
                move.w  #$FFC0,d6
                moveq   #4,d7
                btst    #3,$E(a5)
                beq.s   loc_1768C
                addi.w  #$80,d6
loc_1768C:                                              ; CODE XREF: Player_SpawnRadialShot+E   j
                                        ; Player_SpawnRadialShot+22   j
                move.l  #off_E9560,8(a0)
                bsr.s   Player_InitShotProjectile
                addi.w  #$40,d6                         ; '@'
                dbf     d7,loc_1768C
                rts
; End of function Player_SpawnRadialShot
; Initializes shot projectile with angle and velocity
Player_InitShotProjectile:                              ; CODE XREF: Player_SpawnTripleShot+2A   p  ; was: sub_176A0
                                        ; Player_SpawnRadialShot+1C   p
                jsr     (Projectile_InitType88).l
                move.b  $20(a5),$20(a0)
                lea     (word_1B514).l,a1
                andi.w  #$1FE,d6
                move.w  -$80(a1,d6.w),d1
                move.w  (a1,d6.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d5,d1
                asl.l   d5,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                move.w  $14(a5),$14(a0)
                subq.w  #8,$14(a0)
                move.w  d4,$10(a0)
                lea     $60(a0),a0
                rts
; End of function Player_InitShotProjectile
; ---------------------------------------------------------------------------
word_176E2:     dc.w    0, 8, 4, 8, 0, $C, $10, $C
                                        ; DATA XREF: Sprite_PrepareRendering:loc_1727A   o
word_176F2:     dc.w    0, $C, $10, $C, 0, 8, 4, 8
                                        ; DATA XREF: Sprite_PrepareRendering+14   o

; Updates screen pulse/shake effect
Effect_UpdateScreenPulse:
                tst.w   (word_FF8262).w                 ; was: sub_17702
                beq.w   locret_1771A
                tst.b   (byte_FF813E).w
                bmi.s   loc_17728
                subq.w  #1,(word_FF8268).w
                bpl.s   loc_1771C
                clr.w   (word_FF8262).w
locret_1771A:                                           ; CODE XREF: Effect_UpdateScreenPulse+4   j
                rts
; ---------------------------------------------------------------------------
loc_1771C:                                              ; CODE XREF: Effect_UpdateScreenPulse+12   j
                btst    #0,(word_FFA000+1).w
                bne.s   loc_17728
                subq.w  #1,(word_FF8266).w
loc_17728:                                              ; CODE XREF: Effect_UpdateScreenPulse+C   j
                                        ; Effect_UpdateScreenPulse+20   j
                move.b  (word_FF8262).w,d0
                andi.w  #$10,d0
                addi.w  #-$3841,d0
                lea     (word_5A43E).l,a0
                move.w  (word_FF8262).w,d4
                andi.w  #$FFF,d4
                asl.w   #1,d4
                move.b  (a0,d4.w),d1
                andi.w  #$F,d1
                move.b  1(a0,d4.w),d2
                move.b  d2,d3
                asr.w   #4,d2
                andi.w  #$F,d2
                andi.w  #$F,d3
                addi.w  #-$383C,d1
                addi.w  #-$383C,d2
                addi.w  #-$383C,d3
                move.w  #0,d4
                move.w  (word_FF8264).w,d5
                move.w  (word_FF8266).w,d6
                cmpi.w  #$A0,d6
                bpl.s   loc_1777E
                move.w  #$A0,d6
loc_1777E:                                              ; CODE XREF: Effect_UpdateScreenPulse+76   j
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d0,(a0)+
                move.w  d5,(a0)+
                addq.w  #8,d5
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d1,(a0)+
                move.w  d5,(a0)+
                addq.w  #8,d5
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d2,(a0)+
                move.w  d5,(a0)+
                addq.w  #8,d5
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d3,(a0)+
                move.w  d5,(a0)+
                move.w  #$FFFF,(a0)
                movea.w #(dword_FFA100-M68K_RAM),a0
                jmp     (Sprite_AddToOAMBuffer).l
; End of function Effect_UpdateScreenPulse
; Creates visual dash trail effect behind player
Effect_CreateDashTrail:                                 ; CODE XREF: Player_HandleDashCancel+B8   j  ; was: sub_177B6
                                        ; Player_TeleportDash+C8   j
                tst.w   (word_FFC5C0).w
                beq.s   loc_177D8
                move.l  #word_E8EBA,8(a5)
                btst    #0,(word_FFA000+1).w
                bne.w   locret_17882
                move.l  #word_E8E6A,8(a5)
                rts
; ---------------------------------------------------------------------------
loc_177D8:                                              ; CODE XREF: Effect_CreateDashTrail+4   j
                bsr.w   Effect_FindDashTrailSlot
                bne.w   locret_17882
                move.w  #$250,(a0)
                clr.b   $21(a0)
                move.w  #$C880,2(a0)
                move.l  #word_E8680,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.w  #3,$48(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $48(a5),d0
                neg.l   d0
                move.l  d0,$18(a0)
                add.l   d0,$10(a0)
                move.l  d0,$4C(a0)
                bsr.w   Effect_FindDashTrailSlot
                bne.s   locret_17882
                lea     (Effect_DashTrailPrimarySpriteFrames).l,a1
                move.w  #$FFF4,$18(a0)
                tst.w   $48(a5)
                bpl.s   Effect_SetDashTrailProperties
                lea     (Effect_DashTrailSecondarySpriteFrames).l,a1
                neg.w   $18(a0)
; Sets sprite properties for dash trail effect including position and velocity
Effect_SetDashTrailProperties:                          ; CODE XREF: Effect_CreateDashTrail+90   j  ; was: loc_17852
                jsr     (Sprite_InitFromTable).l
                move.w  #$8880,2(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  $10(a5),$10(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
locret_17882:                                           ; CODE XREF: Effect_CreateDashTrail+14   j
                                        ; Effect_CreateDashTrail+26   j
                rts
; End of function Effect_CreateDashTrail
; Updates dash trail position with acceleration
Effect_UpdateDashTrail:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_17884
                btst    #4,(byte_FF8244).w
                bne.s   loc_17894
loc_1788C:                                              ; CODE XREF: Effect_UpdateDashTrail+14   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_17894:                                              ; CODE XREF: Effect_UpdateDashTrail+6   j
                subq.w  #1,$48(a5)
                bmi.s   loc_1788C
                move.l  $18(a5),d0
                add.l   $4C(a5),d0
                move.l  d0,$18(a5)
                bset    #7,2(a5)
                btst    #0,$49(a5)
                beq.s   locret_178BA
                bclr    #7,2(a5)
locret_178BA:                                           ; CODE XREF: Effect_UpdateDashTrail+2E   j
                rts
; End of function Effect_UpdateDashTrail
; Updates sprite facing flags
Effect_UpdateFacingFlags:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_178BC
                andi.w  #$E7FF,$E(a5)
                move.w  (word_FF8092).w,d0
                or.w    d0,$E(a5)
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_178D8
                move.w  #$1000,2(a5)
locret_178D8:                                           ; CODE XREF: Effect_UpdateFacingFlags+14   j
                rts
; End of function Effect_UpdateFacingFlags
; ---------------------------------------------------------------------------
word_178DA:     dc.w    0, 1, 3, 3, $12, 5              ; DATA XREF: UI_UpdateWeaponDisplay+1E   o
off_178E6:      dc.l    word_E9964                      ; DATA XREF: UI_InitWeaponSelectScreen+8A   o
                                        ; sub_2BBC0:loc_2BC18   o
                dc.l    word_E9976
                dc.l    word_E9988
                dc.l    word_E999A
                dc.l    word_E99AC
                dc.l    word_E99BE

; Updates weapon selection display counters
