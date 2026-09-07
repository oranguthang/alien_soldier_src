Boss_WolfGaropaDefeatInit:                              ; CODE XREF: Projectile_WolfGaropaBullet1+EC   j  ; was: sub_50B7E
                                        ; Projectile_WolfGaropaBullet1+118   j
                btst    #0,(word_FFA000+1).w
                bne.w   locret_50BEA
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_50BEA
                lea     (Effect_StarParticleSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                move.b  #4,$20(a0)
                move.w  #$8C40,2(a0)
                bsr.w   Boss_WolfGaropaDefeatAnim
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a2,d0.w),d1
                move.w  (a2,d0.w),d2
                ext.l   d1
                ext.l   d2
                move.l  d1,d5
                move.l  d2,d6
                asl.l   #6,d1
                asl.l   #6,d2
                swap    d1
                swap    d2
                add.w   d1,d3
                add.w   d2,d4
                move.w  d3,$14(a0)
                move.w  d4,$10(a0)
                neg.l   d5
                neg.l   d6
                asl.l   #2,d5
                asl.l   #2,d6
                move.l  d5,$1C(a0)
                move.l  d6,$18(a0)
locret_50BEA:                                           ; CODE XREF: Boss_WolfGaropaDefeatInit+6   j
                                        ; Boss_WolfGaropaDefeatInit+10   j
                rts
; End of function Boss_WolfGaropaDefeatInit
; Boss collision handler
Boss_WolfGaropaCollision:                               ; CODE XREF: Boss_WolfGaropaShootPattern5+8   p  ; was: sub_50BEC
                tst.w   $5FC(a5)
                bmi.w   locret_50C5A
                subq.w  #1,$5FC(a5)
                btst    #0,(word_FFA000+1).w
                bne.w   locret_50C5A
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_50C5A
                lea     (Boss_SharedCollisionProjectileSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                move.b  #4,$20(a0)
                move.w  #$8C00,2(a0)
                bsr.w   Boss_WolfGaropaDefeatAnim
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,d3
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,d4
                move.w  d3,$14(a0)
                move.w  d4,$10(a0)
                asl.l   #2,d5
                asl.l   #2,d6
                move.l  d5,$1C(a0)
                subi.l  #$30000,d6
                move.l  d6,$18(a0)
locret_50C5A:                                           ; CODE XREF: Boss_WolfGaropaCollision+4   j
                                        ; Boss_WolfGaropaCollision+12   j
                rts
; End of function Boss_WolfGaropaCollision
; Defeat animation
Boss_WolfGaropaDefeatAnim:                              ; CODE XREF: Boss_WolfGaropaDefeatInit+2C   p  ; was: sub_50C5C
                                        ; Boss_WolfGaropaCollision+38   p
                lea     (word_1B514).l,a2
                move.w  $A76(a5),d0
                move.w  -$80(a2,d0.w),d3
                move.w  (a2,d0.w),d4
                ext.l   d3
                ext.l   d4
                move.l  d3,d5
                move.l  d4,d6
                asl.l   #7,d3
                asl.l   #7,d4
                swap    d3
                swap    d4
                add.w   $A34(a5),d3
                add.w   $A30(a5),d4
                rts
; End of function Boss_WolfGaropaDefeatAnim
; Spawn Wolf Garopa bomb projectile with explosion effect type 188
Projectile_SpawnWolfGaropaBomb:                         ; CODE XREF: Boss_WolfGaropaAttack1+1E   p  ; was: sub_50C88
                                        ; DATA XREF: Boss_WolfGaropaAttack1+1E   o
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_50CD2
                move.l  #off_E962C,8(a0)
                jsr     (Effect_SpawnExplosionType188).l
                move.b  #4,$20(a0)
                move.w  #$EC00,2(a0)
                move.w  #$FFFE,$18(a0)
                move.w  #$FFFE,$1C(a0)
                move.w  #$10,$48(a0)
                move.w  $A30(a5),d0
                move.w  $A34(a5),d1
                subq.w  #8,d0
                addq.w  #8,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_50CD2:                                           ; CODE XREF: Projectile_SpawnWolfGaropaBomb+6   j
                rts
; End of function Projectile_SpawnWolfGaropaBomb
; Initializes pair of screen objects for Valkirie boss with different parameters based on direction flag
