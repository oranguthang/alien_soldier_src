; Finds the first free slot in the forward projectile/object pool
Projectile_FindFreePrimarySlot:                         ; CODE XREF: ShipSequence_SpawnStarParticle   p  ; was: sub_1C050
                                        ; Projectile_FindFreeOrRecycleSlot+4   p
                movea.w #(word_FFCF80-M68K_RAM),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
Projectile_FindFreePrimarySlot_CheckExtendedRange:      ; CODE XREF: Boss_CaterpillarFindFreeHomingProjectileSlot+4   j  ; was: loc_1C0A4
                                        ; Boss_SunsetStingInitHomingProjectile+E   p
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
Projectile_FindFreePrimarySlot_CheckEnemyRange:         ; CODE XREF: Stage_SpawnIntroProjectile+C   p  ; was: loc_1C11C
                                        ; Projectile_FindFreeEnemyPoolSlot+4   j
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
Projectile_FindFreePrimarySlot_CheckFinalRange:         ; CODE XREF: Boss_ShiperSpawnOscillatingShot+16   p  ; was: loc_1C144
                                        ; Boss_TerobusterSpawnHomingMissile+22   p
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreePrimarySlot_Return
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   *+4
Projectile_FindFreePrimarySlot_Return:                  ; CODE XREF: Projectile_FindFreePrimarySlot+6   j  ; was: locret_1C168
                                        ; Projectile_FindFreePrimarySlot+10   j
                rts
; End of function Projectile_FindFreePrimarySlot
; Finds free slot in projectile buffer unrolled search
Projectile_FindFreeSlot:                                ; CODE XREF: Enemy_SpawnProjectileAtAngle   p  ; was: sub_1C16A
                                        ; sub_2A0D6   p
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   Projectile_FindFreeSlot_Return
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   *+4
Projectile_FindFreeSlot_Return:                         ; CODE XREF: Projectile_FindFreeSlot+6   j  ; was: locret_1C282
                                        ; Projectile_FindFreeSlot+10   j
                rts
; End of function Projectile_FindFreeSlot
; Clear registers d0 and d1
Math_ClearD0D1:
                moveq   #0,d0                           ; was: sub_1C284
                moveq   #0,d1
; End of function Math_ClearD0D1
; Clears all objects except specified types
Object_ClearAllExceptTypes:                             ; CODE XREF: ShipSequence_Update+26   j  ; was: sub_1C288
                                        ; Stage9_UpdateCaterpillarShipTraversal+A0   p
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                moveq   #0,d3
                moveq   #$3C,d7                         ; '<'
Object_ClearAllExceptTypes_Loop:                        ; CODE XREF: Object_ClearAllExceptTypes+76   j  ; was: loc_1C290
                                        ; Boss_UpdateSireneState4+74   p
                move.w  (a0),d2
                beq.s   Object_ClearAllExceptTypes_Next
                cmp.w   d0,d2
                beq.s   Object_ClearAllExceptTypes_Next
                cmp.w   d1,d2
                beq.s   Object_ClearAllExceptTypes_Next
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
Object_ClearAllExceptTypes_Next:                        ; CODE XREF: Object_ClearAllExceptTypes+A   j  ; was: loc_1C2FA
                                        ; Object_ClearAllExceptTypes+E   j
                lea     $60(a0),a0
                dbf     d7,Object_ClearAllExceptTypes_Loop
                rts
; End of function Object_ClearAllExceptTypes
; Finds free projectile slot and clears
Projectile_FindFreeOrRecycleSlot:                       ; CODE XREF: Projectile_SpawnQuadPattern:loc_E294   p  ; was: sub_1C304
                                        ; sub_2FF1C:loc_2FF62   p
                movem.l d7,-(sp)
                jsr     Projectile_FindFreePrimarySlot(pc)  ; (pc)
                beq.s   Projectile_FindFreeOrRecycleSlot_Return
                movea.w #(word_FFCF80-M68K_RAM),a0
                moveq   #$1A,d7
Projectile_FindFreeOrRecycleSlot_Scan:                  ; CODE XREF: Projectile_FindFreeOrRecycleSlot+20   j  ; was: loc_1C314
                move.w  (a0),d0
                beq.s   Projectile_FindFreeOrRecycleSlot_Return
                btst    #6,3(a0)
                bne.s   Projectile_FindFreeOrRecycleSlot_Clear
                lea     $60(a0),a0
                dbf     d7,Projectile_FindFreeOrRecycleSlot_Scan
                moveq   #1,d7
Projectile_FindFreeOrRecycleSlot_Return:                ; CODE XREF: Projectile_FindFreeOrRecycleSlot+8   j  ; was: loc_1C32A
                                        ; Projectile_FindFreeOrRecycleSlot+12   j
                movem.l (sp)+,d7
                rts
; ---------------------------------------------------------------------------
Projectile_FindFreeOrRecycleSlot_Clear:                 ; CODE XREF: Projectile_FindFreeOrRecycleSlot+1A   j  ; was: loc_1C330
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
; End of function Projectile_FindFreeOrRecycleSlot
; Clear 96 bytes of object data
Object_Clear96Bytes:                                    ; CODE XREF: Entity_InitValkirieAuxiliaryGroup:Entity_ClearValkirieAuxiliaryGroupLoop   p  ; was: sub_1C398
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
