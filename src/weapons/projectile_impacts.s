Weapon_UpdateRotatingProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18A66
                move.w  $48(a5),d0
                addq.w  #2,d0
                andi.w  #$E,d0
                move.w  d0,$48(a5)
                movea.l $4A(a5),a0
                move.w  (a0,d0.w),d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.w  $10(a0,d0.w),8(a5)
                move.w  $20(a0,d0.w),$A(a5)
                cmpi.w  #$80,$10(a5)
                bmi.w Sprite_MarkForRemoval
                cmpi.w  #$1C0,$10(a5)
                bpl.w Sprite_MarkForRemoval
                cmpi.w  #$A0,$14(a5)
                bmi.w Sprite_MarkForRemoval
                cmpi.w  #$160,$14(a5)
                bpl.w Sprite_MarkForRemoval
                btst    #0,(byte_FF8144).w
                bne.s   locret_18AC8
                addi.l  #$4000,$1C(a5)
locret_18AC8:                           ; CODE XREF: Weapon_UpdateRotatingProjectile+58   j
                rts
; End of function Weapon_UpdateRotatingProjectile
; Handles projectile collision
Weapon_HandleProjectileHit:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18ACA
                bclr    #7,$22(a5)
                bne.s   loc_18AE2
                bclr    #6,$23(a5)
                beq.s Weapon_TickLifetimeTimer
                bclr    #4,$23(a5)
                bne.s   loc_18AF6
loc_18AE2:                              ; CODE XREF: Weapon_HandleProjectileHit+6   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (dword_2ACA6).l,a1
                jmp Effect_SpawnObjectType
; ---------------------------------------------------------------------------
loc_18AF6:                              ; CODE XREF: Weapon_HandleProjectileHit+16   j
                move.w  #$44D6,d0
                add.w   (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                move.l  #word_1818E,$4A(a5)
                bra.w   loc_18A2C
; End of function Weapon_HandleProjectileHit
; Attributes: thunk
; Thunk to Effect_SpawnObjectType
Effect_SpawnObjectThunk1:
                jmp Effect_SpawnObjectType  ; was: sub_18B1A
; End of function Effect_SpawnObjectThunk1
; Decrements projectile lifetime
Weapon_TickLifetimeTimer:                              ; CODE XREF: Weapon_HandleProjectileHit+E   j  ; was: sub_18B20
                subq.w  #1,$48(a5)
                bmi.w Sprite_MarkForRemoval
                rts
; End of function Weapon_TickLifetimeTimer
; Handles explosive projectile impact with particle spawn
Weapon_HandleExplosiveImpact:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18B2A
                bclr    #7,$22(a5)
                bne.s   loc_18B44
                bclr    #6,$23(a5)
                beq.w Weapon_AnimateExplosionFade
                bclr    #4,$23(a5)
                bne.s   loc_18BA8
loc_18B44:                              ; CODE XREF: Weapon_HandleExplosiveImpact+6   j
                tst.w   (dword_FF802C).w
                beq.s   loc_18B94
                move.l  $18(a5),d0
                asr.l   #3,d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #3,d0
                move.l  d0,$1C(a5)
                move.w  #$400,(a5)
                move.w  #$EC00,2(a5)
                move.w  #$480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.l  #off_E9560,8(a5)
                clr.w   $C(a5)
                move.w  #5,$26(a5)
                tst.w   (word_FFFF0E).w
                bne.s   locret_18B92
                move.w  #6,$26(a5)
locret_18B92:                           ; CODE XREF: Weapon_HandleExplosiveImpact+60   j
                rts
; ---------------------------------------------------------------------------
loc_18B94:                              ; CODE XREF: Weapon_HandleExplosiveImpact+1E   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (dword_2ACA6).l,a1
                jmp Effect_SpawnObjectType
; ---------------------------------------------------------------------------
loc_18BA8:                              ; CODE XREF: Weapon_HandleExplosiveImpact+18   j
                move.w  #$44D6,d0
                add.w   (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                move.l  #word_1818E,$4A(a5)
                bra.w   loc_18A2C
; End of function Weapon_HandleExplosiveImpact
; Attributes: thunk
; Thunk to Effect_SpawnObjectType
Effect_SpawnObjectThunk2:
                jmp Effect_SpawnObjectType  ; was: sub_18BCC
; End of function Effect_SpawnObjectThunk2
; Animates explosion sprite fading sequence
Weapon_AnimateExplosionFade:                              ; CODE XREF: Weapon_HandleExplosiveImpact+E   j  ; was: sub_18BD2
                subq.w  #2,$5E(a5)
                bmi.w Sprite_MarkForRemoval
                move.w  $5E(a5),d0
                asr.w   #2,d0
                cmpi.w  #6,d0
                bmi.s Weapon_GetExplosionFrameData
                moveq   #6,d0
; Gets explosion animation frame data based on timer
Weapon_GetExplosionFrameData:                              ; CODE XREF: Weapon_AnimateExplosionFade+12   j  ; was: loc_18BE8
                andi.w  #6,d0
                move.w  word_18C06(pc,d0.w),d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.w  word_18C0E(pc,d0.w),8(a5)
                move.w  word_18C16(pc,d0.w),$A(a5)
                rts
; End of function Weapon_AnimateExplosionFade
; ---------------------------------------------------------------------------
word_18C06:     dc.w $45A9, $45A5, $45A1, $45A0
                                        ; DATA XREF: Weapon_AnimateExplosionFade+1A   r
word_18C0E:     dc.w $A00, $500, $500, 0
                                        ; DATA XREF: Weapon_AnimateExplosionFade+26   r
word_18C16:     dc.w $F4F4, $F8F8, $F8F8, $FCFC
                                        ; DATA XREF: Weapon_AnimateExplosionFade+2C   r


; Sets high priority bit on sprite
Sprite_SetPriorityHigh:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18C1E
                bset    #4,2(a5)
                rts
; End of function Sprite_SetPriorityHigh
; Processes projectile hit effects including screen shake and palette change
Weapon_ProcessProjectileHit:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18C26
                move.w  #$A0,(word_FF8140).w
                move.b  #$60,(byte_FF8142).w ; '`'
                move.b  #4,(byte_FF8143).w
                tst.w   $26(a5)
                bpl.s Weapon_CheckProjectileDamage
                clr.b   $21(a5)
; Checks projectile damage threshold and sets transparency flag
Weapon_CheckProjectileDamage:                              ; CODE XREF: Weapon_ProcessProjectileHit+16   j  ; was: loc_18C42
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_18C50
                move.w  #$1000,2(a5)
locret_18C50:                           ; CODE XREF: Weapon_ProcessProjectileHit+22   j
                rts
; End of function Weapon_ProcessProjectileHit
; Spawns particle effect at sprite position with trajectory
Sprite_SpawnParticleEffect:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18C52
                bclr    #6,$23(a5)
                bne.s   loc_18C64
                bclr    #7,$22(a5)
                beq.w Sprite_UpdateParticleAnimation
loc_18C64:                              ; CODE XREF: Sprite_SpawnParticleEffect+6   j
                move.w  a5,d0
                btst    #5,d0
                bne.w   loc_18CEE
                jsr (Sprite_AllocateSlot).l
                bne.w   loc_18CEE
                lea     (dword_2AF5A).l,a1
                btst    #7,(dword_FFFF08).w
                bne.s   loc_18C8C
                lea     (dword_2AF8C).l,a1
loc_18C8C:                              ; CODE XREF: Sprite_SpawnParticleEffect+32   j
                jsr (Projectile_FindFreeSlotComplex).l
                move.w  #$8C80,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                bpl.s   loc_18CB4
                clr.b   $20(a0)
loc_18CB4:                              ; CODE XREF: Sprite_SpawnParticleEffect+5C   j
                move.w  $56(a5),d5
                addi.w  #$20,d5 ; ' '
                andi.w  #$7C,d5 ; '|'
                lea     dword_19772(pc),a1
                nop
                move.l  (a1,d5.w),d0
                move.l  $20(a1,d5.w),d1
                btst    #1,(word_FFA000+1).w
                bne.s   loc_18CDA
                neg.l   d0
                neg.l   d1
loc_18CDA:                              ; CODE XREF: Sprite_SpawnParticleEffect+82   j
                asr.l   #2,d0
                asr.l   #2,d1
                add.l   (dword_FF8024).w,d0
                add.l   (dword_FF8028).w,d1
                move.l  d1,$18(a0)
                move.l  d0,$1C(a0)
loc_18CEE:                              ; CODE XREF: Sprite_SpawnParticleEffect+18   j
                                        ; Sprite_SpawnParticleEffect+22   j ...
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
; Updates particle effect sprite animation with gravity and fading
Sprite_UpdateParticleAnimation:                              ; CODE XREF: Sprite_SpawnParticleEffect+E   j  ; was: loc_18CF6
                move.l  (dword_FF8024).w,d0
                move.l  (dword_FF8028).w,d1
                add.l   d1,$18(a5)
                add.l   d0,$1C(a5)
                subq.w  #2,$48(a5)
                bmi.s   loc_18CEE
                move.w  $48(a5),d0
                move.w  word_18D2E(pc,d0.w),d1
                or.w    (word_FF808A).w,d1
                or.w    (word_FF8092).w,d1
                move.w  d1,$E(a5)
                move.w  word_18D3E(pc,d0.w),8(a5)
                move.w  word_18D4E(pc,d0.w),$A(a5)
                rts
; End of function Sprite_SpawnParticleEffect
; ---------------------------------------------------------------------------
word_18D2E:     dc.w $452B, $451B, $450B, $451B, $452B, $4492, $449B, $44A4
                                        ; DATA XREF: Sprite_SpawnParticleEffect+BE   r
word_18D3E:     dc.w $F00, $F00, $F00, $F00, $F00, $A00, $A00, $500
                                        ; DATA XREF: Sprite_SpawnParticleEffect+CE   r
word_18D4E:     dc.w $F0F0, $F0F0, $F0F0, $F0F0, $F0F0, $F4F4, $F4F4, $F8F8
                                        ; DATA XREF: Sprite_SpawnParticleEffect+D4   r


; Updates seeking missile projectile with target tracking and rotation
Weapon_UpdateSeekingMissile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18D5E
                bclr    #7,$22(a5)
                bne.s   loc_18D6E
                bclr    #4,$23(a5)
                beq.s   loc_18D8A
loc_18D6E:                              ; CODE XREF: Weapon_UpdateSeekingMissile+6   j
                move.w  #3,$48(a5)
                move.l  #off_E9680,8(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jmp Weapon_CopySeekingMissileAddress
; ---------------------------------------------------------------------------
loc_18D8A:                              ; CODE XREF: Weapon_UpdateSeekingMissile+E   j
                subq.w  #1,$48(a5)
                bpl.w   loc_18E18
                cmpi.w  #$FFF1,$48(a5)
                bpl.s   loc_18DA2
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_18DA2:                              ; CODE XREF: Weapon_UpdateSeekingMissile+3A   j
                move.w  a5,d0
                btst    #0,(word_FFA000+1).w
                bne.w   loc_18DB6
                btst    #5,d0
                beq.s   loc_18DBC
                bra.s   loc_18E18
; ---------------------------------------------------------------------------
loc_18DB6:                              ; CODE XREF: Weapon_UpdateSeekingMissile+4C   j
                btst    #5,d0
                beq.s   loc_18E18
loc_18DBC:                              ; CODE XREF: Weapon_UpdateSeekingMissile+54   j
                move.w  (word_FF801C).w,d0
                bne.s   loc_18DC8
                move.w  (dword_FFFF08).w,d2
                bra.s   loc_18DEE
; ---------------------------------------------------------------------------
loc_18DC8:                              ; CODE XREF: Weapon_UpdateSeekingMissile+62   j
                bclr    #0,d0
                movea.w d0,a0
                move.w  $10(a0),d0
                move.w  $14(a0),d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr (Math_Arctan2Lookup).l
                asr.w   #1,d2
                move.w  d2,(dword_FF8040).w
                move.b  (dword_FF8040).w,d2
loc_18DEE:                              ; CODE XREF: Weapon_UpdateSeekingMissile+68   j
                andi.w  #$7C,d2 ; '|'
                move.w  (dword_FFFF08).w,d0
                andi.w  #6,d0
                addq.w  #6,d0
                sub.w   $56(a5),d2
                bmi.s   loc_18E0E
                cmpi.w  #$40,d2 ; '@'
                bpl.s   loc_18E14
loc_18E08:                              ; CODE XREF: Weapon_UpdateSeekingMissile+B4   j
                add.w   d0,$56(a5)
                bra.s   loc_18E18
; ---------------------------------------------------------------------------
loc_18E0E:                              ; CODE XREF: Weapon_UpdateSeekingMissile+A2   j
                cmpi.w  #$FFC0,d2
                bmi.s   loc_18E08
loc_18E14:                              ; CODE XREF: Weapon_UpdateSeekingMissile+A8   j
                sub.w   d0,$56(a5)
loc_18E18:                              ; CODE XREF: Weapon_UpdateSeekingMissile+30   j
                                        ; Weapon_UpdateSeekingMissile+56   j ...
                move.w  $56(a5),d2
                andi.w  #$7E,d2 ; '~'
                move.w  d2,$56(a5)
                andi.w  #$7C,d2 ; '|'
                movea.l (dword_FF802C).w,a0
                move.l  (a0,d2.w),d1
                move.l  $20(a0,d2.w),d0
                move.w  (dword_FF8028+2).w,d2
                asr.l   d2,d1
                asr.l   d2,d0
                move.l  d1,$1C(a5)
                move.l  d0,$18(a5)
                move.w  $48(a5),d0
                bmi.s   loc_18E4C
                moveq   #4,d0
loc_18E4C:                              ; CODE XREF: Weapon_UpdateSeekingMissile+EA   j
                andi.w  #$E,d0
                move.w  word_18E82(pc,d0.w),d1
                or.w    (word_FF808A).w,d1
                or.w    (word_FF8092).w,d1
                move.w  d1,$E(a5)
                cmpi.w  #4,d0
                bmi.s Weapon_SetMissileSize
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                rts
; ---------------------------------------------------------------------------
; Sets seeking missile sprite size based on distance from player
Weapon_SetMissileSize:                              ; CODE XREF: Weapon_UpdateSeekingMissile+106   j  ; was: loc_18E74
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                rts
; End of function Weapon_UpdateSeekingMissile
; ---------------------------------------------------------------------------
word_18E82:     dc.w $45A0, $45A0, $45A4, $45AD, $45AD, $45B6, $45B6, $45AD
                                        ; DATA XREF: Weapon_UpdateSeekingMissile+F2   r


; Matches sprite position and properties to parent sprite
Sprite_MatchParentPosition:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18E92
                movea.w a5,a0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_18EA2
                suba.w  #$300,a0
                bra.s   loc_18EA6
; ---------------------------------------------------------------------------
loc_18EA2:                              ; CODE XREF: Sprite_MatchParentPosition+8   j
                suba.w  #$360,a0
loc_18EA6:                              ; CODE XREF: Sprite_MatchParentPosition+E   j
                move.w  $48(a5),d0
                cmp.w   (a0),d0
                beq.s Sprite_CopyParentTransform
                move.w  #$40,$10(a5) ; '@'
                rts
; ---------------------------------------------------------------------------
; Copies parent sprite transform data including position and tiles
Sprite_CopyParentTransform:                              ; CODE XREF: Sprite_MatchParentPosition+1A   j  ; was: loc_18EB6
                move.w  $10(a0),d0
                sub.w   $18(a0),d0
                move.w  d0,$10(a5)
                move.w  $14(a0),d0
                sub.w   $1C(a0),d0
                move.w  d0,$14(a5)
                move.w  $E(a0),$E(a5)
                move.w  8(a0),8(a5)
                move.w  $A(a0),$A(a5)
                move.b  $20(a0),$20(a5)
                rts
; End of function Sprite_MatchParentPosition
; Updates projectile seeking movement
Sprite_UpdateSeekingProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18EE8
                subq.w  #1,$5E(a5)
                bmi.s Sprite_HandleProjectileCollision
                bne.s Sprite_UpdateSeekingMotion
                move.b  #$40,$21(a5) ; '@'
; Updates sprite seeking motion with velocity subtraction
Sprite_UpdateSeekingMotion:                              ; CODE XREF: Sprite_UpdateSeekingProjectile+6   j  ; was: loc_18EF6
                move.l  $48(a5),d0
                move.l  $4C(a5),d1
                sub.l   d0,$14(a5)
                sub.l   d1,$10(a5)
; End of function Sprite_UpdateSeekingProjectile
; Handles projectile collision and destruction
Sprite_HandleProjectileCollision:                              ; CODE XREF: Sprite_UpdateSeekingProjectile+4   j  ; was: sub_18F06
                                        ; DATA XREF: ROM:off_5DC   o
                btst    #6,$23(a5)
                bne.s   loc_18F30
                tst.w   $26(a5)
                bpl.s   locret_18F2E
                lea     (dword_2AECC).l,a1
                jsr (Sys_PassObjectAddress).l
                move.w  #$8080,2(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
locret_18F2E:                           ; CODE XREF: Sprite_HandleProjectileCollision+C   j
                rts
; ---------------------------------------------------------------------------
loc_18F30:                              ; CODE XREF: Sprite_HandleProjectileCollision+6   j
                btst    #4,$23(a5)
                beq.s   loc_18F42
                move.b  #$C8,d0
                jsr (Sound_PlaySFX).l
loc_18F42:                              ; CODE XREF: Sprite_HandleProjectileCollision+30   j
                movea.w a5,a0
                bsr.s   Effect_SpawnExplosion
loc_18F46:                              ; CODE XREF: Weapon_InitProjectileSprite+32   j
                movea.w a5,a0
                adda.w  #$300,a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
; End of function Sprite_HandleProjectileCollision
; Spawns explosion effect with random velocity
Effect_SpawnExplosion:                              ; CODE XREF: Sprite_HandleProjectileCollision+3E   p  ; was: sub_18F58
                lea     (dword_2AF48).l,a1
                jsr (Sprite_InitFromTable).l
                move.w  #$8C80,2(a0)
                move.b  (dword_FFFF08).w,d3
                move.b  (dword_FFFF08+1).w,d4
                andi.w  #1,d3
                andi.w  #1,d4
                addq.w  #3,d3
                addq.w  #3,d4
                movea.l #word_1B514,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d3,d1
                asl.l   d4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                rts
; End of function Effect_SpawnExplosion
; Updates bomb projectile with gravity and collision detection
Weapon_UpdateBombProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18FA6
                btst    #6,$23(a5)
                bne.w   loc_1905C
                tst.w   $26(a5)
                bpl.s   loc_18FD2
                lea     (dword_2AF1E).l,a1
                jsr (Sys_PassObjectAddress).l
                move.w  #$8080,2(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_18FD2:                              ; CODE XREF: Weapon_UpdateBombProjectile+E   j
                subq.w  #1,$5E(a5)
                bpl.s   loc_1901C
                bset    #4,2(a5)
                clr.b   $21(a5)
                movea.w a5,a0
                adda.w  #$300,a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                lea     (dword_2AF48).l,a1
                jsr (Sprite_InitFromTable).l
                move.w  #$8C80,2(a0)
                rts
; ---------------------------------------------------------------------------
loc_1901C:                              ; CODE XREF: Weapon_UpdateBombProjectile+30   j
                move.w  #$8080,2(a5)
                move.w  $58(a5),d0
                add.w   (dword_FFA410).w,d0
                move.l  $50(a5),d1
                add.l   $18(a5),d1
                move.l  d1,$50(a5)
                swap    d1
                add.w   d1,d0
                move.w  d0,$10(a5)
                move.w  $5A(a5),d0
                add.w   (dword_FFA414).w,d0
                move.l  $54(a5),d1
                add.l   $1C(a5),d1
                move.l  d1,$54(a5)
                swap    d1
                add.w   d1,d0
                move.w  d0,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_1905C:                              ; CODE XREF: Weapon_UpdateBombProjectile+6   j
                btst    #4,$23(a5)
                beq.s   loc_1906E
                move.b  #$C8,d0
                jsr (Sound_PlaySFX).l
loc_1906E:                              ; CODE XREF: Weapon_UpdateBombProjectile+BC   j
                movea.w a5,a0
                bsr.s Effect_CreateExplosionDebris
                movea.w a5,a0
                adda.w  #$300,a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
; End of function Weapon_UpdateBombProjectile
; Creates explosion debris particles with random velocity
Effect_CreateExplosionDebris:                              ; CODE XREF: Weapon_UpdateBombProjectile+CA   p  ; was: sub_19084
                lea     (dword_2AF48).l,a1
                jsr (Sprite_InitFromTable).l
                move.w  #$8C80,2(a0)
                move.b  (dword_FFFF08).w,d3
                move.b  (dword_FFFF08+1).w,d4
                andi.w  #1,d3
                andi.w  #1,d4
                addq.w  #2,d3
                addq.w  #2,d4
                movea.l #word_1B514,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d3,d1
                asl.l   d4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                rts
; End of function Effect_CreateExplosionDebris
; Spawns spark particle during player death sequence
Effect_SpawnPlayerDeathSpark:                              ; CODE XREF: Player_HandleInvulnerabilityTimer:loc_16AFC   j  ; was: sub_190D2
                                        ; DATA XREF: ROM:off_5DC   o
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$F,d7
loc_190D8:                              ; CODE XREF: Effect_SpawnPlayerDeathSpark+E   j
                tst.w   (a0)
                beq.s   loc_190E6
                lea     $60(a0),a0
                dbf     d7,loc_190D8
                rts
; ---------------------------------------------------------------------------
loc_190E6:                              ; CODE XREF: Effect_SpawnPlayerDeathSpark+8   j
                move.w  #$7C,(a0) ; '|'
                move.w  #$EC00,2(a0)
                clr.b   $21(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$480,$E(a0)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a0)
                move.l  #off_E9560,8(a0)
                clr.w   $C(a0)
                lea     (word_1B514).l,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (word_FFA000).w,d0
                asl.w   #5,d0
                andi.w  #$1FE,d0
                move.w  (a1,d0.w),d2
                move.w  d1,$4E(a0)
                move.w  d2,$50(a0)
                ext.l   d1
                ext.l   d2
                asl.l   #5,d1
                asl.l   #5,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                rts
; End of function Effect_SpawnPlayerDeathSpark
; Updates death spark particle motion with deceleration
Effect_UpdateDeathSparkMotion:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_19154
                cmpi.w  #$80,$C(a5)
                bmi.s Effect_ApplySparkDeceleration
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
; Applies deceleration to spark particle velocity
Effect_ApplySparkDeceleration:                              ; CODE XREF: Effect_UpdateDeathSparkMotion+6   j  ; was: loc_19164
                move.w  $4E(a5),d0
                move.w  $50(a5),d1
                ext.l   d0
                ext.l   d1
                sub.l   d0,$1C(a5)
                sub.l   d1,$18(a5)
                rts
; End of function Effect_UpdateDeathSparkMotion
; Destroys sprite when timer expires
Sprite_DestroyOnTimeout:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_1917A
                subq.w  #1,$48(a5)
                bpl.s   locret_19186
                bset    #4,2(a5)
locret_19186:                           ; CODE XREF: Sprite_DestroyOnTimeout+4   j
                rts
; End of function Sprite_DestroyOnTimeout
; Initializes projectile sprite with position and velocity
Sprite_InitProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_19188
                bset    #7,2(a5)
                cmpi.l  #word_E8EBA,(dword_FFA408).w
                beq.s   loc_1919E
                bclr    #7,2(a5)
loc_1919E:                              ; CODE XREF: Sprite_InitProjectile+E   j
                move.w  (dword_FFA410).w,$10(a5)
                move.w  (dword_FFA414).w,$14(a5)
                bclr    #7,$22(a5)
                beq.s   loc_191B8
                move.w  #4,(word_FF813C).w
loc_191B8:                              ; CODE XREF: Sprite_InitProjectile+28   j
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$B,d7
                jsr (Sys_FindFreeObjectSlot).l
                bne.w   locret_19230
                move.l  #off_E9584,8(a0)
                jsr (Sprite_InitializeProperties).l
                move.b  $20(a5),$20(a0)
                lea     (word_1B514).l,a1
                move.w  (word_FFA000).w,d0
                asl.w   #5,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a0)
                swap    d1
                btst    #0,(word_FFA000+1).w
                bne.s   loc_19208
                neg.w   d1
                neg.l   $1C(a0)
loc_19208:                              ; CODE XREF: Sprite_InitProjectile+78   j
                add.w   $14(a5),d1
                move.w  d1,$14(a0)
                move.w  $10(a5),$10(a0)
                tst.w   (word_FFA448).w
                bmi.s   loc_19226
                move.l  #$FFF60000,$18(a0)
                rts
; ---------------------------------------------------------------------------
loc_19226:                              ; CODE XREF: Sprite_InitProjectile+92   j
                move.l  #$A0000,$18(a0)
                rts
; ---------------------------------------------------------------------------
locret_19230:                           ; CODE XREF: Sprite_InitProjectile+3C   j
                rts
; End of function Sprite_InitProjectile
; Increments frame and checks lifetime
Sprite_AnimateAndExpire:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_19232
                addq.w  #1,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   locret_19242
                bset    #4,2(a5)
locret_19242:                           ; CODE XREF: Sprite_AnimateAndExpire+8   j
                rts
; End of function Sprite_AnimateAndExpire
; Clears memory block for system reset operations
Memory_ClearBlock:                              ; CODE XREF: Player_HandleDeathSequence+16   p  ; was: sub_19244
                                        ; Player_InitKnockbackState+12   p ...
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$10,d7
                bra.s Sys_ClearMemoryBlock
; End of function Memory_ClearBlock
; Clears object buffer at FFBFC0 with 16 iterations
Sys_ClearObjectBufferSmall:                              ; CODE XREF: Player_HandleJump+72   p  ; was: sub_1924C
                                        ; Player_InitDeathKnockback+A   p ...
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$F,d7
                bra.s Sys_ClearMemoryBlock
; End of function Sys_ClearObjectBufferSmall
; Clears 8 projectile slots
Sys_ClearProjectileBuffer:
                movea.w #(dword_FFBFC0-M68K_RAM),a0  ; was: sub_19254
                moveq   #7,d7
; End of function Sys_ClearProjectileBuffer
; Clears memory block with unrolled 96-byte loop per iteration
Sys_ClearMemoryBlock:                              ; CODE XREF: Player_InitSpecialAttack+46   p  ; was: sub_1925A
                                        ; Memory_ClearBlock+6   j ...
                moveq   #0,d0
loc_1925C:                              ; CODE XREF: Sys_ClearMemoryBlock+32   j
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d7,loc_1925C
                rts
; End of function Sys_ClearMemoryBlock
; Renders targeting reticle sprite over locked enemy target
