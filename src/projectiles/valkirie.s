Projectile_CopyValkirieData:                            ; CODE XREF: Projectile_ValkirieBullet+1A   j  ; was: sub_2A03C
                move.b  $20(a1),d2
                move.w  #$100,d0
                move.w  #$480,(a0)
                move.w  2(a1),d1
                andi.w  #$C080,d1
                or.w    d0,d1
                move.w  d1,2(a0)
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                move.w  $E(a1),$E(a0)
                move.b  d2,$20(a0)
                move.w  d3,$48(a0)
                move.w  d4,$4A(a0)
                btst    #6,2(a0)
                bne.s   loc_2A08A
                move.w  8(a1),8(a0)
                move.w  $A(a1),$A(a0)
                rts
; ---------------------------------------------------------------------------
loc_2A08A:                                              ; CODE XREF: Projectile_CopyValkirieData+3E   j
                move.l  8(a1),8(a0)
                rts
; End of function Projectile_CopyValkirieData
; Projectile main handler
Projectile_ValkirieMain:                                ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A092
                subq.w  #1,$48(a5)
                bpl.s   loc_2A0A0
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A0A0:                                              ; CODE XREF: Projectile_ValkirieMain+4   j
                bset    #7,2(a5)
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                move.w  $4A(a5),d1
                eor.w   d0,d1
                bne.s   locret_2A0BC
                bclr    #7,2(a5)
locret_2A0BC:                                           ; CODE XREF: Projectile_ValkirieMain+22   j
                rts
; End of function Projectile_ValkirieMain
; Sets graphics tile pattern and velocity values for sprite display
Gfx_SetupTileGraphics:                                  ; CODE XREF: Projectile_ZLeoSpawnDropProjectile+84   p  ; was: sub_2A0BE
                move.w  #$C6B4,$E(a0)
                move.w  #$900,8(a0)
                move.w  #$F4F8,$A(a0)
                clr.b   $20(a0)
                rts
; End of function Gfx_SetupTileGraphics
; Finds free projectile slot and initializes type $424 projectile
Projectile_InitType424:                                 ; CODE XREF: Boss_WolfGaropaDiveInit1+6   p  ; was: sub_2A0D6
                                        ; Boss_WolfGaropaDiveInit2+6   p
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_2A100
                move.w  #$424,(a0)
                move.w  #$C6B4,$E(a0)
                move.w  #$900,8(a0)
                move.w  #$F4F8,$A(a0)
                clr.b   $20(a0)
                move.w  #$40,$48(a0)                    ; '@'
                moveq   #0,d0
locret_2A100:                                           ; CODE XREF: Projectile_InitType424+6   j
                rts
; End of function Projectile_InitType424
; Updates timer and toggles sprite visibility based on condition flags
Projectile_TimerAndVisibility:                          ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A102
                subq.w  #1,$48(a5)
                bpl.s   loc_2A110
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A110:                                              ; CODE XREF: Projectile_TimerAndVisibility+4   j
                bset    #7,2(a5)
                btst    #2,$49(a5)
                beq.s   locret_2A124
                bclr    #7,2(a5)
locret_2A124:                                           ; CODE XREF: Projectile_TimerAndVisibility+1A   j
                rts
; End of function Projectile_TimerAndVisibility
; Sets sprite tile pattern from position table using random frame counter
Gfx_SetTileFromRandomTable:
                movea.w a5,a0                           ; was: sub_2A126
loc_2A128:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+68   p
                move.w  (word_FFA000).w,d0
                asl.w   #2,d0
                andi.w  #$C,d0
                move.w  word_2A140(pc,d0.w),$E(a0)
                move.w  word_2A140+2(pc,d0.w),$A(a0)
                rts
; End of function Gfx_SetTileFromRandomTable
; ---------------------------------------------------------------------------
word_2A140:     dc.w    $C6FC, $F0F0, $CEFC, $F0, $D6FC, $F000, $DEFC, 0, $30BC, $5C
                                        ; DATA XREF: Gfx_SetTileFromRandomTable+C   r
                                        ; Gfx_SetTileFromRandomTable+12   r

; Initializes projectile with position offset and directional velocity
Projectile_InitWithDirection:
                move.w  #$10,$48(a0)                    ; was: sub_2A154
                move.w  #$18,$4A(a0)
                move.w  #$8F00,2(a0)
                add.w   $10(a5),d1
                move.w  d1,$10(a0)
                add.w   $14(a5),d2
                move.w  d2,$14(a0)
                ori.w   #$451F,d0
                move.w  d0,$E(a0)
                move.w  #$400,8(a0)
                move.w  #$F8FC,$A(a0)
                btst    #$B,d0
                beq.s   loc_2A198
                move.w  #$6000,$4C(a0)
                rts
; ---------------------------------------------------------------------------
loc_2A198:                                              ; CODE XREF: Projectile_InitWithDirection+3A   j
                move.w  #$A000,$4C(a0)
                rts
; End of function Projectile_InitWithDirection
; Updates projectile trajectory and spawns child projectiles at intervals
Projectile_UpdateWithSpawning:                          ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A1A0
                tst.b   $48(a5)
                bmi.s   loc_2A202
                subq.w  #1,$48(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_2A200
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_2A200
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_2A200
                movea.l #dword_2ABF0,a1                 ; make offsets?
                bsr.w   Sprite_InitFromTable
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                movea.l #word_1B514,a1
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #2,d1
                asl.l   #2,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
locret_2A200:                                           ; CODE XREF: Projectile_UpdateWithSpawning+10   j
                                        ; Projectile_UpdateWithSpawning+1A   j
                rts
; ---------------------------------------------------------------------------
loc_2A202:                                              ; CODE XREF: Projectile_UpdateWithSpawning+4   j
                subq.w  #1,$4A(a5)
                bmi.s   loc_2A234
                move.w  $4C(a5),d0
                ext.l   d0
                add.l   d0,$18(a5)
                tst.w   (word_FFA400).w
                beq.s   loc_2A234
                move.w  (dword_FFA414).w,d0
                cmp.w   $14(a5),d0
                bmi.s   loc_2A22C
                addi.l  #$2000,$1C(a5)
                bra.s   loc_2A234
; ---------------------------------------------------------------------------
loc_2A22C:                                              ; CODE XREF: Projectile_UpdateWithSpawning+80   j
                subi.l  #$2000,$1C(a5)
loc_2A234:                                              ; CODE XREF: Projectile_UpdateWithSpawning+66   j
                                        ; Projectile_UpdateWithSpawning+76   j
                btst    #0,(word_FFA000+1).w
                bne.s   locret_2A270
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_2A270
                movea.l #dword_2ABF0,a1                 ; make offsets?
                bsr.w   Sprite_InitFromTable
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                btst    #3,$E(a5)
                beq.s   loc_2A26A
                move.w  #$FFFF,$18(a0)
                rts
; ---------------------------------------------------------------------------
loc_2A26A:                                              ; CODE XREF: Projectile_UpdateWithSpawning+C0   j
                move.w  #1,$18(a0)
locret_2A270:                                           ; CODE XREF: Projectile_UpdateWithSpawning+9A   j
                                        ; Projectile_UpdateWithSpawning+A2   j
                rts
; End of function Projectile_UpdateWithSpawning
; Applies downward acceleration and horizontal deceleration to projectile
Projectile_ApplyGravityEffect:                          ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A272
                subq.w  #1,$48(a5)
                bpl.s   loc_2A280
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A280:                                              ; CODE XREF: Projectile_ApplyGravityEffect+4   j
                addi.l  #$4000,$1C(a5)
                tst.w   $18(a5)
                bmi.s   loc_2A298
                subi.l  #$2000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A298:                                              ; CODE XREF: Projectile_ApplyGravityEffect+1A   j
                addi.l  #$2000,$18(a5)
                rts
; End of function Projectile_ApplyGravityEffect
; Checks projectile lifetime timer
Projectile_CheckLifetime:                               ; CODE XREF: Enemy_InitProjectileType+80   p  ; was: sub_2A2A2
                                        ; Projectile_TerrainCollision+36   j
                movea.w a5,a0
loc_2A2A4:                                              ; CODE XREF: Effect_DebrisParticleAnimate+30   p
                                        ; Boss_SunsetStingUpdateFragment+30   p
                move.w  #$C4,(a0)
                move.l  #$FFFDC000,$1C(a0)
                move.w  #$480,d0
                add.w   (word_FF808A).w,d0
                btst    #4,$E(a0)
                beq.s   Projectile_InitializeExplosion
                bset    #$C,d0
                neg.l   $1C(a0)
; Initializes projectile explosion with sprite and sound effect
Projectile_InitializeExplosion:                         ; CODE XREF: Projectile_CheckLifetime+1C   j  ; was: loc_2A2C8
                move.w  d0,$E(a0)
                move.w  #$E500,2(a0)
                move.l  #off_E9560,8(a0)
                clr.w   $C(a0)
                move.b  #$10,$20(a0)
                move.w  #3,$48(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$F010F010,$2C(a0)
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.b  #$BC,d0
                jmp     (Sound_PlaySFX).l
; End of function Projectile_CheckLifetime
; Checks object visibility timer and sets flags
