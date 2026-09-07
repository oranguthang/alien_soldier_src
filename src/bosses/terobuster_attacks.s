Boss_TerobusterAttackPattern1:                          ; DATA XREF: ROM:00038580   o  ; was: sub_38B5C
                addi.l  #$3000,$1C(a5)
                bmi.s   Boss_TerobusterAttackPattern2
                cmpi.w  #$142,$14(a5)
                bmi.s   Boss_TerobusterAttackPattern2
                move.w  #6,(word_FFA010).w
                move.w  #6,(word_FFA014).w
                addq.w  #1,$48(a5)
                beq.s   loc_38B94
                addq.w  #2,4(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$A0,$48(a5)
                bra.s   Boss_TerobusterAttackPattern2
; ---------------------------------------------------------------------------
loc_38B94:                                              ; CODE XREF: Boss_TerobusterAttackPattern1+22   j
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  #$FFFDE000,$1C(a5)
; End of function Boss_TerobusterAttackPattern1
; Second attack pattern with alternate timing
Boss_TerobusterAttackPattern2:                          ; CODE XREF: Boss_TerobusterAttackPattern1+8   j  ; was: sub_38BA6
                                        ; Boss_TerobusterAttackPattern1+10   j
                move.w  #$CC,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$3E,d0                         ; '>'
                move.w  d0,(dword_FFA90C).w
                rts
; End of function Boss_TerobusterAttackPattern2
; Third attack pattern with combined attacks
Boss_TerobusterAttackPattern3:                          ; DATA XREF: ROM:00038582   o  ; was: sub_38BC0
                subq.w  #1,$48(a5)
                bpl.s   loc_38BCE
                addq.w  #2,4(a5)
                clr.w   6(a5)
loc_38BCE:                                              ; CODE XREF: Boss_TerobusterAttackPattern3+4   j
                                        ; Boss_TerobusterDefeatInit+E   j
                bsr.w   Boss_TerobusterAttackPattern2
                cmpi.w  #$40,$48(a5)                    ; '@'
                bpl.s   loc_38BE8
                btst    #0,(word_FFA000+1).w
                bne.s   loc_38BE8
                move.w  #$FFD0,(dword_FFA90C).w
loc_38BE8:                                              ; CODE XREF: Boss_TerobusterAttackPattern3+18   j
                                        ; Boss_TerobusterAttackPattern3+20   j
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_38C64
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                btst    #1,(word_FFA000+1).w
                bne.s   loc_38C18
                movea.l #Boss_TerobusterProjectileSpriteFrames,a1
                move.l  #$FFFD2000,$1C(a0)
loc_38C18:                                              ; CODE XREF: Boss_TerobusterAttackPattern3+48   j
                jsr     (Sprite_InitTypeA4FromTable).l
                move.b  #0,$20(a0)
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                subi.w  #$3C,d0                         ; '<'
                subi.w  #$34,d1                         ; '4'
                move.b  (dword_FFFF08).w,d2
                move.b  (dword_FFFF08+1).w,d3
                andi.w  #$3C,d2                         ; '<'
                andi.w  #$3C,d3                         ; '<'
                add.w   d2,d0
                add.w   d3,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_38C64
                move.b  #$BB,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_38C64:                                           ; CODE XREF: Boss_TerobusterAttackPattern3+3A   j
                                        ; Boss_TerobusterAttackPattern3+98   j
                rts
; End of function Boss_TerobusterAttackPattern3
; Initializes defeat sequence with explosion spawn
Boss_TerobusterDefeatInit:                              ; DATA XREF: ROM:00038584   o  ; was: sub_38C66
                bsr.w   Boss_TerobusterSetFadeParams
                addq.w  #1,6(a5)
                cmpi.w  #$F,6(a5)
                bmi.w   loc_38BCE
                move.w  #$22,4(a5)                      ; '"'
                move.w  #8,$48(a5)
                move.w  #$FFD0,(dword_FFA90C).w
                move.b  #4,(byte_FFA95A).w
                move.w  #$B4,d0
                move.w  #$12C,d1
                jsr     (Object_ClearAllExceptTypes).l
                jsr     (Boss_InitDefeatExplosion).l
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                subi.w  #$18,d0
                subi.w  #$10,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                rts
; End of function Boss_TerobusterDefeatInit
; Defeat timer countdown before final state
Boss_TerobusterDefeatTimer:                             ; DATA XREF: ROM:00038598   o  ; was: sub_38CBE
                subq.w  #1,$48(a5)
                bpl.s   loc_38CCE
                addq.w  #2,4(a5)
                move.w  #$C0,$48(a5)
loc_38CCE:                                              ; CODE XREF: Boss_TerobusterDefeatTimer+4   j
                bra.w   Boss_TerobusterSetFadeParams
; End of function Boss_TerobusterDefeatTimer
; Completes defeat sequence removing boss entity
Boss_TerobusterDefeatComplete:                          ; DATA XREF: ROM:0003859A   o  ; was: sub_38CD2
                subq.w  #1,$48(a5)
                bpl.s   loc_38CE0
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_38CE0:                                              ; CODE XREF: Boss_TerobusterDefeatComplete+4   j
                subq.w  #1,6(a5)
                bpl.w   Boss_TerobusterSetFadeParams
                rts
; End of function Boss_TerobusterDefeatComplete
; Sets graphics fade parameters using boss state value for death sequence
Boss_TerobusterSetFadeParams:                           ; CODE XREF: Boss_TerobusterDefeatInit   p  ; was: sub_38CEA
                                        ; sub_38CBE:loc_38CCE   j
                move.w  6(a5),d0
                jmp     (Gfx_SetFadeParams).l
; End of function Boss_TerobusterSetFadeParams
; Calculates oscillating word values for animation effects
Boss_TerobusterOscillateValue:                          ; CODE XREF: Boss_TerobusterInitMetasprite+C   p  ; was: sub_38CF4
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #$E,d0
                move.w  word_38D0C(pc,d0.w),d0
                move.w  d0,(word_FFE37E).w
                move.w  d0,(word_FFE3FE).w
                rts
; End of function Boss_TerobusterOscillateValue
; ---------------------------------------------------------------------------
word_38D0C:     dc.w    2, 6, $A, $C, $C, $A, 6, 2
                                        ; DATA XREF: Boss_TerobusterOscillateValue+A   r

; Initializes battle state with sound flag and timer setup
Boss_TerobusterInitBattleState:                         ; CODE XREF: Boss_TerobusterDescend+3A   p  ; was: sub_38D1C
                clr.l   $1C(a5)
                move.w  #$C800,$4A(a5)
                move.w  #$14C,$1F4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #5,(word_FFA010).w
                move.w  #5,(word_FFA014).w
                move.b  #$DA,d0
                jmp     (Sound_PlaySFX).l
; End of function Boss_TerobusterInitBattleState
; Updates boss body part positions with offset calculations
Boss_TerobusterUpdateBodyParts:                         ; CODE XREF: Boss_TerobusterInitMetasprite+8   p  ; was: sub_38D4C
                move.w  $1DE(a5),d1
                move.w  $10(a5),$490(a5)
                move.w  $14(a5),$494(a5)
                addi.w  #-$10,$490(a5)
                addi.w  #$18,$494(a5)
                add.w   d1,$494(a5)
                cmpi.w  #$13C,$494(a5)
                bmi.s   loc_38D7A
                move.w  #$13C,$494(a5)
loc_38D7A:                                              ; CODE XREF: Boss_TerobusterUpdateBodyParts+26   j
                move.w  $23C(a5),d0
                beq.s   loc_38D86
                subq.w  #4,d0
                bpl.s   loc_38D86
                moveq   #0,d0
loc_38D86:                                              ; CODE XREF: Boss_TerobusterUpdateBodyParts+32   j
                                        ; Boss_TerobusterUpdateBodyParts+36   j
                move.w  d0,$23C(a5)
                add.w   $10(a5),d0
                addi.w  #-$44,d0
                move.w  d0,$430(a5)
                move.w  $14(a5),$434(a5)
                addi.w  #-$2C,$434(a5)
                add.w   d1,$434(a5)
                move.w  #$CC,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                add.w   $14(a5),d1
                addi.w  #$3E,d1                         ; '>'
                move.w  d1,(dword_FFA90C).w
                jmp     Boss_CheckScreenBounds
; End of function Boss_TerobusterUpdateBodyParts
; Spawns projectiles with trajectory and velocity updates
Boss_TerobusterSpawnProjectile:                         ; CODE XREF: Boss_TerobusterInitMetasprite+10   j  ; was: sub_38DC4
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_38E06
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_38E06
                movea.l #Boss_TerobusterProjectileSpriteFrames,a1
                jsr     (Sprite_InitTypeA4FromTable).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addi.w  #$14,$10(a0)
                addi.w  #-$30,$14(a0)
                move.b  #4,$20(a0)
                move.w  #2,$18(a0)
locret_38E06:                                           ; CODE XREF: Boss_TerobusterSpawnProjectile+8   j
                                        ; Boss_TerobusterSpawnProjectile+10   j
                rts
; End of function Boss_TerobusterSpawnProjectile
; Initializes metasprite and updates boss animation state
Boss_TerobusterInitMetasprite:                          ; CODE XREF: Boss_TerobusterMainAI+82   j  ; was: sub_38E08
                                        ; Boss_TerobusterMainAI+134   j
                moveq   #9,d7
                jsr     (Sprite_InitMetaspriteSimple).l
                bsr.w   Boss_TerobusterUpdateBodyParts
                bsr.w   Boss_TerobusterOscillateValue
                bra.w   Boss_TerobusterSpawnProjectile
; End of function Boss_TerobusterInitMetasprite
; Periodically spawns homing missiles from Terobuster boss body position
Boss_TerobusterSpawnHomingMissile:                      ; CODE XREF: Boss_TerobusterMainAI:loc_387E4   p  ; was: sub_38E1C
                                        ; sub_386EE:loc_3889E   p
                tst.w   (word_FFFF0E).w
                bne.s   loc_38E2A
                cmpi.w  #$1190,$BC(a5)
                bmi.s   locret_38EA0
loc_38E2A:                                              ; CODE XREF: Boss_TerobusterSpawnHomingMissile+4   j
                move.w  (word_FFA000).w,d0
                btst    #8,d0
                bne.s   locret_38EA0
                andi.w  #$1F,d0
                bne.s   locret_38EA0
                movea.w #(byte_FFD880-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckFinalRange).l
                bne.s   locret_38EA0
                move.w  #$138,(a0)
                move.w  #$8D00,2(a0)
                move.b  #$C0,$21(a0)
                move.b  #8,$23(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.b  #8,$20(a0)
                move.w  #$14,$26(a0)
                move.w  $490(a5),$10(a0)
                move.w  $494(a5),$14(a0)
                addi.w  #$C,$10(a0)
                addi.w  #-$30,$14(a0)
                move.w  #$180,$56(a0)
                move.b  #$4A,d0                         ; 'J'
                jsr     (Sound_PlaySFX).l
locret_38EA0:                                           ; CODE XREF: Boss_TerobusterSpawnHomingMissile+C   j
                                        ; Boss_TerobusterSpawnHomingMissile+16   j
                rts
; End of function Boss_TerobusterSpawnHomingMissile
; Updates homing missile trajectory with rotation, trail spawning, and player tracking
