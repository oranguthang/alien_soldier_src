Projectile_UpdateTrajectory:                              ; CODE XREF: Effect_SpawnStarParticle   p  ; was: sub_1C050
                                        ; Projectile_FindFreeSlotAndClear+4   p ...
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
loc_1C0A4:                              ; CODE XREF: Boss_CaterpillarCheckFreeSlot+4   j
                                        ; Boss_SunsetStingInitHomingProjectile+E   p ...
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
loc_1C11C:                              ; CODE XREF: Stage_SpawnIntroProjectile+C   p
                                        ; Enemy_FindFreeSpriteSlot+4   j ...
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
loc_1C144:                              ; CODE XREF: Boss_ShiperSpawnProjectile+16   p
                                        ; Boss_TerobusterSpawnHomingMissile+22   p ...
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
locret_1C168:                           ; CODE XREF: Projectile_UpdateTrajectory+6   j
                                        ; Projectile_UpdateTrajectory+10   j ...
                rts
; End of function Projectile_UpdateTrajectory
; Finds free slot in projectile buffer unrolled search
