Entity_EmptyState8:                                     ; DATA XREF: ROM:off_5DC   o  ; was: nullsub_8
                rts
; End of function Entity_EmptyState8
; Updates Z-Leo vertical scroll position based on velocity, handles screen wrap-around boundary checks
Boss_ZLeoScrollUpdate:                                  ; CODE XREF: Boss_ZLeoAttackSequence:loc_52438   p  ; was: sub_52EE4
                                        ; sub_52368:loc_52456   p
                move.l  $41C(a5),d0
                bmi.s   loc_52EFE
                add.l   d0,(dword_FFA90C).w
                move.w  (dword_FFA90C).w,d1
                subi.w  #8,d1
                bmi.s   loc_52F14
                addi.w  #-$1FFF,d1
                bra.s   loc_52F14
; ---------------------------------------------------------------------------
loc_52EFE:                                              ; CODE XREF: Boss_ZLeoScrollUpdate+4   j
                add.l   d0,(dword_FFA90C).w
                move.w  (dword_FFA90C).w,d1
                subi.w  #$E8,d1
                cmpi.w  #$E001,d1
                bpl.s   loc_52F14
                subi.w  #$E000,d1
loc_52F14:                                              ; CODE XREF: Boss_ZLeoScrollUpdate+12   j
                                        ; Boss_ZLeoScrollUpdate+18   j
                lea     word_52F22(pc),a0
                nop
                moveq   #0,d0
                jmp     loc_109E0
; End of function Boss_ZLeoScrollUpdate
; ---------------------------------------------------------------------------
word_52F22:     dc.w    $FFFF, $7000, $FFFF, $6800, $FFFF, $4000, 0, $6000
                                        ; DATA XREF: Boss_ZLeoScrollUpdate:loc_52F14   o

; Spawn orb projectile
Boss_ZLeoSpawnOrb:                                      ; CODE XREF: Boss_ZLeoAttackState1+1A   p  ; was: sub_52F32
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_53038
                move.w  #4,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_53038
                move.w  #$C000,$59E(a5)
                btst    #0,(dword_FFFF08).w
                bne.s   loc_52F68
                move.w  #$8000,$59E(a5)
loc_52F68:                                              ; CODE XREF: Boss_ZLeoSpawnOrb+2E   j
                move.w  #3,$59C(a5)
                movea.l #dword_2ADC8,a1
                jsr     (Sprite_InitFromTable).l
                move.b  #4,$20(a0)
                move.w  #$8040,2(a0)
                movea.w a0,a3
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_53038
                move.b  #$36,d0                         ; '6'
                jsr     (Sound_PlaySFX).l
                move.w  #$468,(a0)
                move.w  #$8C80,2(a0)
                move.b  #$42,$21(a0)                    ; 'B'
                move.l  #$FE02FE02,$2C(a0)
                move.w  #$A,$26(a0)
                move.b  #8,$20(a0)
                move.w  $296(a5),d0
                move.w  d0,d2
                lea     (word_1B514).l,a2
                move.w  word_1B494-word_1B514(a2,d0.w),d3
                move.w  (a2,d0.w),d4
                muls.w  #$28,d3                         ; '('
                muls.w  #$28,d4                         ; '('
                move.l  d3,$1C(a0)
                move.l  d4,$18(a0)
                addi.w  #$20,d0                         ; ' '
                asr.w   #4,d0
                andi.w  #$1C,d0
                move.w  word_5303A(pc,d0.w),d5
                move.w  word_5303A+2(pc,d0.w),d6
                add.w   $254(a5),d5
                add.w   $250(a5),d6
                move.w  d5,$14(a0)
                move.w  d6,$10(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d5
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d6
                move.w  d5,$14(a3)
                move.w  d6,$10(a3)
                move.w  #$C489,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
locret_53038:                                           ; CODE XREF: Boss_ZLeoSpawnOrb+8   j
                                        ; Boss_ZLeoSpawnOrb+1E   j
                rts
; End of function Boss_ZLeoSpawnOrb
; ---------------------------------------------------------------------------
word_5303A:     dc.w    0, $20, $18, $18, $20, 0, $18, $FFE8, 0, $FFE0, $FFE8, $FFE8, $FFE0, 0, $FFE8, $18
                                        ; DATA XREF: Boss_ZLeoSpawnOrb+BC   r
                                        ; Boss_ZLeoSpawnOrb+C0   r

; Orb projectile main
Projectile_ZLeoOrbMain:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_5305A
                tst.w   (word_FF808C).w
                bpl.s   loc_53070
                btst    #7,$22(a5)
                beq.s   loc_53096
                btst    #4,$22(a5)
                beq.s   loc_53080
loc_53070:                                              ; CODE XREF: Projectile_ZLeoOrbMain+4   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                bne.s   loc_530AE
                jmp     Sprite_SetPointerClearD7
; ---------------------------------------------------------------------------
loc_53080:                                              ; CODE XREF: Projectile_ZLeoOrbMain+14   j
                neg.l   $18(a5)
                neg.l   $1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp     Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
loc_53096:                                              ; CODE XREF: Projectile_ZLeoOrbMain+C   j
                cmpi.w  #$1C0,$10(a5)
                bpl.s   loc_530AE
                cmpi.w  #$80,$10(a5)
                bmi.s   loc_530AE
                cmpi.w  #$70,$14(a5)                    ; 'p'
                bpl.s   loc_530B6
loc_530AE:                                              ; CODE XREF: Projectile_ZLeoOrbMain+1E   j
                                        ; Projectile_ZLeoOrbMain+42   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_530B6:                                              ; CODE XREF: Projectile_ZLeoOrbMain+52   j
                move.w  (dword_FFDB34).w,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_530D4
                tst.w   $1C(a5)
                bmi.s   loc_530D4
                move.b  #$37,d0                         ; '7'
                jsr     (Sound_PlaySFX).l
                neg.l   $1C(a5)
loc_530D4:                                              ; CODE XREF: Projectile_ZLeoOrbMain+64   j
                                        ; Projectile_ZLeoOrbMain+6A   j
                btst    #0,(word_FFA000+1).w
                bne.s   loc_530E4
                move.w  #$E489,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_530E4:                                              ; CODE XREF: Projectile_ZLeoOrbMain+80   j
                move.w  #$C489,$E(a5)
                rts
; End of function Projectile_ZLeoOrbMain
nullsub_122:
                rts
; End of function nullsub_122

; Spawn laser projectile
Boss_ZLeoSpawnLaser:                                    ; CODE XREF: Boss_ZLeoAttackPattern1+58   p  ; was: sub_530EE
                move.w  (dword_FFFF08).w,d7
                andi.w  #$100,d7
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_53180
                move.w  #8,$4DC(a5)
                move.w  #$8000,$4DE(a5)
                move.w  #$C,$53C(a5)
                move.w  #$8000,$53E(a5)
                move.w  #$E,$59C(a5)
                move.w  #$8000,$59E(a5)
                move.b  #$CB,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$46C,(a0)
                move.w  #$8000,2(a0)
                move.w  #$F00,8(a0)
                move.w  #$F0F0,$A(a0)
                move.b  #4,$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addi.w  #0,$14(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FA06FA06,$2C(a0)
                move.w  #$F3,$26(a0)
                move.w  #$10,$48(a0)
                move.w  #4,$50(a0)
                move.w  d7,$56(a0)
locret_53180:                                           ; CODE XREF: Boss_ZLeoSpawnLaser+E   j
                rts
; End of function Boss_ZLeoSpawnLaser
; Laser projectile main
Projectile_ZLeoLaserMain:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_53182
                cmpi.w  #$180,$14(a5)
                bpl.s   loc_53192
                cmpi.w  #$80,$14(a5)
                bpl.s   loc_5319A
loc_53192:                                              ; CODE XREF: Projectile_ZLeoLaserMain+6   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_5319A:                                              ; CODE XREF: Projectile_ZLeoLaserMain+E   j
                tst.w   (word_FF808C).w
                bpl.s   loc_531B2
                bclr    #7,$22(a5)
                beq.s   loc_531C6
                bclr    #4,$22(a5)
                bne.w   loc_53242
loc_531B2:                                              ; CODE XREF: Projectile_ZLeoLaserMain+1C   j
                move.w  #3,(word_FFA010).w
                move.l  #off_E953C,8(a5)
                jmp     Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
loc_531C6:                                              ; CODE XREF: Projectile_ZLeoLaserMain+24   j
                addi.w  #6,$56(a5)
                addq.w  #5,$50(a5)
                lea     (word_1B514).l,a0
                move.w  $56(a5),d0
                andi.w  #$1FE,d0
                move.w  -$80(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                addi.w  #$80,d0
                andi.w  #$1FE,d0
                move.w  -$80(a0,d0.w),d3
                move.w  (a0,d0.w),d4
                ext.l   d3
                ext.l   d4
                asl.l   #5,d3
                asl.l   #4,d4
                move.l  d3,$1C(a5)
                move.l  d4,$18(a5)
                move.w  $50(a5),d0
                muls.w  d0,d1
                muls.w  d0,d2
                add.l   (dword_FFC634).w,d1
                add.l   (dword_FFC630).w,d2
                move.l  d1,$14(a5)
                move.l  d2,$10(a5)
                move.w  (word_FFA000).w,d0
                asl.w   #1,d0
                andi.w  #6,d0
                move.w  word_5323A(pc,d0.w),$E(a5)
                btst    #0,(word_FFA000+1).w
                bne.w   loc_532BA
                rts
; ---------------------------------------------------------------------------
word_5323A:     dc.w    $C56C, $C50B, $C54B, $C51B
                                        ; DATA XREF: Projectile_ZLeoLaserMain+A6   r
; ---------------------------------------------------------------------------
loc_53242:                                              ; CODE XREF: Projectile_ZLeoLaserMain+2C   j
                move.b  #$7C,d0                         ; '|'
                jsr     (Sound_PlaySFX).l
                move.w  #$498,(a5)
                move.w  #$8E00,2(a5)
                move.b  #1,$21(a5)
                clr.b   $22(a5)
                clr.b   $23(a5)
                move.w  #$154,$26(a5)
                clr.l   $1C(a5)
                move.l  #$100000,$18(a5)
                btst    #3,(word_FFA40E).w
                bne.s   Projectile_ZLeoLaser_CollisionCheck
                neg.l   $18(a5)
; Handles laser projectile collision and spawns particle effects
Projectile_ZLeoLaser_CollisionCheck:                    ; CODE XREF: Projectile_ZLeoLaserMain+FA   j  ; was: loc_53282
                                        ; DATA XREF: ROM:off_5DC   o
                bclr    #7,$22(a5)
                beq.s   loc_532B0
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                move.w  #3,(word_FFA010).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E9850,8(a5)
                jmp     Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
loc_532B0:                                              ; CODE XREF: Projectile_ZLeoLaserMain+106   j
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_53316
loc_532BA:                                              ; CODE XREF: Projectile_ZLeoLaserMain+B2   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_53316
                move.l  #off_E953C,8(a0)
                jsr     (Projectile_InitType88).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subi.w  #8,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subi.w  #8,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  $18(a5),d0
                neg.l   d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                neg.l   d0
                move.l  d0,$1C(a0)
locret_53316:                                           ; CODE XREF: Projectile_ZLeoLaserMain+136   j
                                        ; Projectile_ZLeoLaserMain+13E   j
                rts
; End of function Projectile_ZLeoLaserMain
; Spawns two Z-Leo laser projectiles at different positions with velocities and angles
Projectile_ZLeoSpawnLasers:                             ; CODE XREF: Boss_ZLeoAttackSequence+60   p  ; was: sub_53318
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_533BC
                move.w  #$188,(a0)
                move.w  #$C480,2(a0)
                move.w  #$C380,$E(a0)
                move.l  #word_ED382,8(a0)
                move.b  #0,$20(a0)
                move.l  #$FFFE8000,$1C(a0)
                move.w  $10(a4),$10(a0)
                move.w  $14(a4),$14(a0)
                addi.w  #-$40,$14(a0)
                move.w  #2,$48(a0)
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_533BC
                move.w  #$470,(a0)
                move.w  #$C480,2(a0)
                move.w  #$C380,$E(a0)
                move.l  #word_ED47E,8(a0)
                move.b  #$60,$20(a0)                    ; '`'
                move.l  #$FFF00000,$1C(a0)
                move.w  $10(a4),$10(a0)
                move.w  $14(a4),$14(a0)
                addi.w  #-$68,$14(a0)
                move.w  #$10,$48(a0)
                move.w  #$4000,$59E(a5)
                move.w  #7,$59C(a5)
                move.b  #$EA,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_533BC:                                           ; CODE XREF: Projectile_ZLeoSpawnLasers+6   j
                                        ; Projectile_ZLeoSpawnLasers+4E   j
                rts
; End of function Projectile_ZLeoSpawnLasers
; Z-Leo laser projectile falling behavior - decrements timer, applies downward velocity, destroys on timeout
Projectile_ZLeoLaserFall:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_533BE
                subq.w  #1,$48(a5)
                bpl.s   loc_533CC
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_533CC:                                              ; CODE XREF: Projectile_ZLeoLaserFall+4   j
                subi.l  #$80000,$1C(a5)
                rts
; End of function Projectile_ZLeoLaserFall
; Spawns falling projectile with graphics setup and horizontal velocity based on screen position
Projectile_ZLeoSpawnDropProjectile:                     ; CODE XREF: Boss_ZLeoAttackSequence+1A2   p  ; was: sub_533D6
                                        ; DATA XREF: ROM:off_5DC   o
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_534AA
                move.w  #$6000,$4DE(a5)
                move.w  #3,$4DC(a5)
                move.w  #$6000,$53E(a5)
                move.w  #3,$53C(a5)
                move.b  #$59,d0                         ; 'Y'
                jsr     (Sound_PlaySFX).l
                move.w  #$478,(a0)
                move.w  #$C080,2(a0)
                move.w  #$6380,$E(a0)
                move.l  #word_ED47E,8(a0)
                move.b  #8,$20(a0)
                clr.b   $21(a0)
                move.w  #$C8,$26(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$9070F808,$2C(a0)
                move.w  #$4E0,$14(a0)
                movea.w a0,a3
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_534AA
                move.w  #$424,(a0)
                move.w  #$8080,2(a0)
                move.b  #4,$20(a0)
                jsr     (Gfx_SetupTileGraphics).l
                move.w  #$20,$48(a0)                    ; ' '
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E000,d0
                ext.l   d0
                move.l  d0,$56(a3)
                move.w  #$14C,$14(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$70,d0                         ; 'p'
                subi.w  #$38,d0                         ; '8'
                add.w   (dword_FFA410).w,d0
                move.w  d0,$10(a0)
                move.w  d0,$10(a3)
                cmpi.w  #$120,d0
                bpl.s   loc_534A2
                move.l  #$60000,$18(a3)
                rts
; ---------------------------------------------------------------------------
loc_534A2:                                              ; CODE XREF: Projectile_ZLeoSpawnDropProjectile+C0   j
                move.l  #$FFFA0000,$18(a3)
locret_534AA:                                           ; CODE XREF: Projectile_ZLeoSpawnDropProjectile+6   j
                                        ; Projectile_ZLeoSpawnDropProjectile+70   j
                rts
; End of function Projectile_ZLeoSpawnDropProjectile
; Z-Leo drop projectile main logic - moves horizontally, rises to Y=$F0, delays, then falls offscreen
Projectile_ZLeoDropProjectileMain:                      ; DATA XREF: ROM:off_5DC   o  ; was: sub_534AC
                move.w  #1,(word_FF9500).w
                move.l  $56(a5),d0
                add.l   d0,$10(a5)
                move.w  4(a5),d0
                bne.s   loc_534E0
                subi.w  #$20,$14(a5)                    ; ' '
                cmpi.w  #$F0,$14(a5)
                bpl.s   locret_534FE
                move.w  #$F0,$14(a5)
                addq.w  #2,4(a5)
                move.w  #$10,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_534E0:                                              ; CODE XREF: Projectile_ZLeoDropProjectileMain+12   j
                cmpi.w  #4,d0
                beq.s   loc_534F0
                subq.w  #1,$4A(a5)
                bpl.s   locret_534FE
                addq.w  #2,4(a5)
loc_534F0:                                              ; CODE XREF: Projectile_ZLeoDropProjectileMain+38   j
                subi.w  #$20,$14(a5)                    ; ' '
                bpl.s   locret_534FE
                bset    #4,2(a5)
locret_534FE:                                           ; CODE XREF: Projectile_ZLeoDropProjectileMain+20   j
                                        ; Projectile_ZLeoDropProjectileMain+3E   j
                rts
; End of function Projectile_ZLeoDropProjectileMain
; Main dispatcher for Valkirie Force boss using state-based jumptable
