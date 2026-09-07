Projectile_UpdateTrajectory:                            ; CODE XREF: Effect_SpawnStarParticle   p  ; was: sub_1C050
                                        ; Projectile_FindFreeSlotAndClear+4   p
                movea.w #(word_FFCF80-M68K_RAM),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
loc_1C0A4:                                              ; CODE XREF: Boss_CaterpillarCheckFreeSlot+4   j
                                        ; Boss_SunsetStingInitHomingProjectile+E   p
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
loc_1C11C:                                              ; CODE XREF: Stage_SpawnIntroProjectile+C   p
                                        ; Enemy_FindFreeSpriteSlot+4   j
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
loc_1C144:                                              ; CODE XREF: Boss_ShiperSpawnProjectile+16   p
                                        ; Boss_TerobusterSpawnHomingMissile+22   p
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   *+4
locret_1C168:                                           ; CODE XREF: Projectile_UpdateTrajectory+6   j
                                        ; Projectile_UpdateTrajectory+10   j
                rts
; End of function Projectile_UpdateTrajectory
; Finds free slot in projectile buffer unrolled search
Projectile_FindFreeSlot:                                ; CODE XREF: Enemy_SpawnProjectileAtAngle   p  ; was: sub_1C16A
                                        ; sub_2A0D6   p
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   *+4
locret_1C282:                                           ; CODE XREF: Projectile_FindFreeSlot+6   j
                                        ; Projectile_FindFreeSlot+10   j
                rts
; End of function Projectile_FindFreeSlot
; Clear registers d0 and d1
Math_ClearD0D1:
                moveq   #0,d0                           ; was: sub_1C284
                moveq   #0,d1
; End of function Math_ClearD0D1
; Clears all objects except specified types
Sprite_ClearAllExcept:                                  ; CODE XREF: Cutscene_ShipAnimationLoop+26   j  ; was: sub_1C288
                                        ; Stage_CaterpillarShipMovement+A0   p
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                moveq   #0,d3
                moveq   #$3C,d7                         ; '<'
loc_1C290:                                              ; CODE XREF: Sprite_ClearAllExcept+76   j
                                        ; Boss_SireneBattleStart+74   p
                move.w  (a0),d2
                beq.s   loc_1C2FA
                cmp.w   d0,d2
                beq.s   loc_1C2FA
                cmp.w   d1,d2
                beq.s   loc_1C2FA
                move.l  d3,(a0)
                move.l  d3,4(a0)
                move.l  d3,8(a0)
                move.l  d3,$C(a0)
                move.l  d3,$10(a0)
                move.l  d3,$14(a0)
                move.l  d3,$18(a0)
                move.l  d3,$1C(a0)
                move.l  d3,$20(a0)
                move.l  d3,$24(a0)
                move.l  d3,$28(a0)
                move.l  d3,$2C(a0)
                move.l  d3,$30(a0)
                move.l  d3,$34(a0)
                move.l  d3,$38(a0)
                move.l  d3,$3C(a0)
                move.l  d3,$40(a0)
                move.l  d3,$44(a0)
                move.l  d3,$48(a0)
                move.l  d3,$4C(a0)
                move.l  d3,$50(a0)
                move.l  d3,$54(a0)
                move.l  d3,$58(a0)
                move.l  d3,$5C(a0)
loc_1C2FA:                                              ; CODE XREF: Sprite_ClearAllExcept+A   j
                                        ; Sprite_ClearAllExcept+E   j
                lea     $60(a0),a0
                dbf     d7,loc_1C290
                rts
; End of function Sprite_ClearAllExcept
; Finds free projectile slot and clears
Projectile_FindFreeSlotAndClear:                        ; CODE XREF: Projectile_SpawnQuadPattern:loc_E294   p  ; was: sub_1C304
                                        ; sub_2FF1C:loc_2FF62   p
                movem.l d7,-(sp)
                jsr     Projectile_UpdateTrajectory(pc)  ; (pc)
                beq.s   loc_1C32A
                movea.w #(word_FFCF80-M68K_RAM),a0
                moveq   #$1A,d7
loc_1C314:                                              ; CODE XREF: Projectile_FindFreeSlotAndClear+20   j
                move.w  (a0),d0
                beq.s   loc_1C32A
                btst    #6,3(a0)
                bne.s   loc_1C330
                lea     $60(a0),a0
                dbf     d7,loc_1C314
                moveq   #1,d7
loc_1C32A:                                              ; CODE XREF: Projectile_FindFreeSlotAndClear+8   j
                                        ; Projectile_FindFreeSlotAndClear+12   j
                movem.l (sp)+,d7
                rts
; ---------------------------------------------------------------------------
loc_1C330:                                              ; CODE XREF: Projectile_FindFreeSlotAndClear+1A   j
                moveq   #0,d7
                move.l  d7,(a0)
                move.l  d7,4(a0)
                move.l  d7,8(a0)
                move.l  d7,$C(a0)
                move.l  d7,$10(a0)
                move.l  d7,$14(a0)
                move.l  d7,$18(a0)
                move.l  d7,$1C(a0)
                move.l  d7,$20(a0)
                move.l  d7,$24(a0)
                move.l  d7,$28(a0)
                move.l  d7,$2C(a0)
                move.l  d7,$30(a0)
                move.l  d7,$34(a0)
                move.l  d7,$38(a0)
                move.l  d7,$3C(a0)
                move.l  d7,$40(a0)
                move.l  d7,$44(a0)
                move.l  d7,$48(a0)
                move.l  d7,$4C(a0)
                move.l  d7,$50(a0)
                move.l  d7,$54(a0)
                move.l  d7,$58(a0)
                move.l  d7,$5C(a0)
                moveq   #0,d7
                movem.l (sp)+,d7
                rts
; End of function Projectile_FindFreeSlotAndClear
; Clear 96 bytes of object data
Object_Clear96Bytes:                                    ; CODE XREF: Boss_ValkirieMovePattern1:loc_566BC   p  ; was: sub_1C398
                moveq   #0,d3
                move.l  d3,(a0)
                move.l  d3,4(a0)
                move.l  d3,8(a0)
                move.l  d3,$C(a0)
                move.l  d3,$10(a0)
                move.l  d3,$14(a0)
                move.l  d3,$18(a0)
                move.l  d3,$1C(a0)
                move.l  d3,$20(a0)
                move.l  d3,$24(a0)
                move.l  d3,$28(a0)
                move.l  d3,$2C(a0)
                move.l  d3,$30(a0)
                move.l  d3,$34(a0)
                move.l  d3,$38(a0)
                move.l  d3,$3C(a0)
                move.l  d3,$40(a0)
                move.l  d3,$44(a0)
                move.l  d3,$48(a0)
                move.l  d3,$4C(a0)
                move.l  d3,$50(a0)
                move.l  d3,$54(a0)
                move.l  d3,$58(a0)
                move.l  d3,$5C(a0)
                rts
; End of function Object_Clear96Bytes
; Loads stage background graphics with DMA and palette transitions
