; Shared type-$3B8 projectile data and handlers used by Destroyer Proto and
; Victor split shots
Projectile_DestroyerProtoVelocityXTable:    dc.w    4, 0  ; DATA XREF: Boss_DestroyerProtoSpawnSpreadProjectile+16   o  ; was: word_31FF8
                                        ; Boss_DestroyerProtoBeginDefeatScatter+6   o
                dc.w    3, $8000
                dc.w    2, $D410
                dc.w    1, $C000
                dc.w    0, 0
                dc.w    $FFFE, $4000
                dc.w    $FFFD, $2BF0
                dc.w    $FFFC, $8000
                dc.w    $FFFC, 0
                dc.w    $FFFC, $8000
                dc.w    $FFFD, $2BF0
                dc.w    $FFFE, $4000
                dc.w    0, 0
                dc.w    1, $C000
                dc.w    2, $D410
                dc.w    3, $8000
Projectile_DestroyerProtoVelocityYTable:    dc.w    0, 0  ; DATA XREF: Boss_DestroyerProtoSpawnSpreadProjectile+1C   o  ; was: word_32038
                                        ; Boss_DestroyerProtoBeginDefeatScatter+C   o
                dc.w    1, $C000
                dc.w    2, $D410
                dc.w    3, $8000
                dc.w    4, 0
                dc.w    3, $8000
                dc.w    2, $D410
                dc.w    1, $C000
                dc.w    0, 0
                dc.w    $FFFE, $4000
                dc.w    $FFFD, $2BF0
                dc.w    $FFFC, $8000
                dc.w    $FFFC, 0
                dc.w    $FFFC, $8000
                dc.w    $FFFD, $2BF0
                dc.w    $FFFE, $4000
Projectile_DestroyerProtoSpawnOffsetXTable: dc.l    $300000, $2AC000  ; DATA XREF: Projectile_DestroyerProtoInitFromPart+4C   o  ; was: dword_32078
                dc.l    $21F0C0, $144000
                dc.l    0, $FFEBC000
                dc.l    $FFDE0F40, $FFD54000
                dc.l    $FFD00000, $FFD54000
                dc.l    $FFDE0F40, $FFEBC000
                dc.l    0, $144000
                dc.l    $21F0C0, $2AC000
Projectile_DestroyerProtoSpawnOffsetYTable: dc.l    0, $144000  ; DATA XREF: Projectile_DestroyerProtoInitFromPart+68   o  ; was: dword_320B8
                dc.l    $21F0C0, $2AC000
                dc.l    $300000, $2AC000
                dc.l    $21F0C0, $144000
                dc.l    0, $FFEBC000
                dc.l    $FFDE0F40, $FFD54000
                dc.l    $FFD00000, $FFD54000
                dc.l    $FFDE0F40, $FFEBC000
Projectile_DestroyerProtoSpriteAttributeTable:  dc.w    $6B00, $6B00, $6B00, $6B00  ; was: word_320F8
                                        ; DATA XREF: Projectile_DestroyerProtoActivateStreamShot+22   o
                                        ; Boss_DestroyerProtoAnimatedPartMain+28   o
                dc.w    $6300, $6300, $6300, $6300
                dc.w    $7300, $7300, $7300, $7300
                dc.w    $7B00, $7B00, $7B00, $7B00
Boss_DestroyerProtoPartMappingFrameTable:   dc.l    Boss_DestroyerProtoSpriteFrame01  ; DATA XREF: Boss_DestroyerProtoAnimatedPartMain+1A   o  ; was: off_32118
                dc.l    Boss_DestroyerProtoSpriteFrame02
                dc.l    Boss_DestroyerProtoSpriteFrame03
                dc.l    Boss_DestroyerProtoSpriteFrame04
                dc.l    Boss_DestroyerProtoSpriteFrame00
                dc.l    Boss_DestroyerProtoSpriteFrame04
                dc.l    Boss_DestroyerProtoSpriteFrame03
                dc.l    Boss_DestroyerProtoSpriteFrame02
                dc.l    Boss_DestroyerProtoSpriteFrame01
                dc.l    Boss_DestroyerProtoSpriteFrame02
                dc.l    Boss_DestroyerProtoSpriteFrame03
                dc.l    Boss_DestroyerProtoSpriteFrame04
                dc.l    Boss_DestroyerProtoSpriteFrame00
                dc.l    Boss_DestroyerProtoSpriteFrame04
                dc.l    Boss_DestroyerProtoSpriteFrame03
                dc.l    Boss_DestroyerProtoSpriteFrame02

; Initializes two fixed-slot Destroyer Proto projectiles from the inner parts
Boss_DestroyerProtoLaunchTwinProjectiles:               ; CODE XREF: Boss_DestroyerProtoLaunchTwinShots+1A   p  ; was: sub_32158
                lea     (word_FFC740).w,a4
                lea     (word_FFC8C0).w,a0
                bsr.w   Projectile_DestroyerProtoInitFromPart
                lea     (word_FFC860).w,a4
                lea     (word_FFCEC0).w,a0
; End of function Boss_DestroyerProtoLaunchTwinProjectiles
; Initializes one delayed Destroyer Proto projectile from a linked part
Projectile_DestroyerProtoInitFromPart:                  ; CODE XREF: Projectile_DestroyerProtoActivateStreamShot   p  ; was: sub_3216C
                                        ; Boss_DestroyerProtoLaunchTwinProjectiles+8   p
                move.w  #$EC00,word_FFCEC2-word_FFCEC0(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$F808F808,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$64,$26(a0)                    ; 'd'
                move.l  #SharedCombatSpriteAnimation13,8(a0)
                move.w  #$3B8,(a0)
                move.w  $40(a4),d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                lsr.w   #3,d0
                move.w  d0,$54(a0)
                lea     Projectile_DestroyerProtoVelocityXTable(pc),a1
                move.l  (a1,d0.w),d1
                move.l  d1,$4C(a0)
                lea     Projectile_DestroyerProtoSpawnOffsetXTable(pc),a1
                move.l  (a1,d0.w),d1
                add.l   $10(a4),d1
                move.l  d1,$10(a0)
                lea     Projectile_DestroyerProtoVelocityYTable(pc),a1
                move.l  (a1,d0.w),d1
                move.l  d1,$50(a0)
                lea     Projectile_DestroyerProtoSpawnOffsetYTable(pc),a1
                move.l  (a1,d0.w),d1
                add.l   $14(a4),d1
                move.l  d1,$14(a0)
                move.b  #0,$20(a0)
                move.w  #$480,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a0)
                move.w  #6,$48(a0)
                move.w  #8,$4A(a0)
                clr.w   4(a0)
                rts
; End of function Projectile_DestroyerProtoInitFromPart
; Dispatches the delayed spread projectile states
Projectile_DestroyerProtoMain:                          ; DATA XREF: ROM:000314D4   o  ; was: sub_32208
                bsr.w   Entity_RemoveWithExplosionWhenEnabled
                move.w  4(a5),d0
                lea     Projectile_DestroyerProtoStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_DestroyerProtoMain
; ---------------------------------------------------------------------------
Projectile_DestroyerProtoStates:    dc.w    Projectile_DestroyerProtoSpawnSpreadCopies-*  ; DATA XREF: Projectile_DestroyerProtoMain+8   o  ; was: off_32218
                dc.w    Projectile_RemoveOutsideArena-*
                dc.w    Projectile_DestroyerProtoRestoreVelocity-*
                dc.w    Projectile_DestroyerProtoCheckHitForPickup-*
                dc.w    Projectile_DestroyerProtoCheckHorizontalReflection-*

; Activates the lead shot and creates seven staggered spread copies
Projectile_DestroyerProtoSpawnSpreadCopies:             ; DATA XREF: ROM:Projectile_DestroyerProtoStates   o  ; was: sub_32222
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.l  $4C(a5),$18(a5)
                move.l  $50(a5),$1C(a5)
                move.w  $54(a5),d0
                lea     Projectile_DestroyerProtoMappingFrameTable(pc),a0
                nop
                move.l  (a0,d0.w),8(a5)
                lsr.w   #1,d0
                lea     Projectile_DestroyerProtoSpriteAttributeTable(pc),a0
                move.w  (a0,d0.w),$E(a5)
                move.w  #$CC00,2(a5)
                movea.w a5,a4
                move.w  #6,d0
Projectile_DestroyerProtoSpawnNextSpreadCopy:           ; CODE XREF: Projectile_DestroyerProtoSpawnSpreadCopies+9C   j  ; was: loc_3225E
                adda.w  #$60,a4                         ; '`'
                move.w  #$CC00,2(a4)
                move.w  #$3B8,(a4)
                move.w  #6,$48(a4)
                move.w  #4,4(a4)
                move.l  $4C(a5),$4C(a4)
                move.l  $50(a5),$50(a4)
                move.l  8(a5),8(a4)
                move.w  $E(a5),$E(a4)
                move.b  $21(a5),$21(a4)
                move.l  $10(a5),$10(a4)
                move.l  $14(a5),$14(a4)
                move.l  $2C(a5),$2C(a4)
                move.l  $28(a5),$28(a4)
                move.w  #$64,$26(a4)                    ; 'd'
                move.w  d0,d1
                addq.w  #1,d1
                lsl.w   #2,d1
                move.w  d1,$4A(a4)
                dbf     d0,Projectile_DestroyerProtoSpawnNextSpreadCopy
                addq.w  #2,4(a5)
                rts
; End of function Projectile_DestroyerProtoSpawnSpreadCopies
; ---------------------------------------------------------------------------
Projectile_DestroyerProtoMappingFrameTable: dc.l    Boss_DestroyerProtoSpriteFrame05  ; DATA XREF: Projectile_DestroyerProtoActivateStreamShot+14   o  ; was: off_322C8
                                        ; Projectile_DestroyerProtoSpawnSpreadCopies+18   o
                dc.l    Boss_DestroyerProtoSpriteFrame06
                dc.l    Boss_DestroyerProtoSpriteFrame07
                dc.l    Boss_DestroyerProtoSpriteFrame08
                dc.l    Boss_DestroyerProtoSpriteFrame09
                dc.l    Boss_DestroyerProtoSpriteFrame08
                dc.l    Boss_DestroyerProtoSpriteFrame07
                dc.l    Boss_DestroyerProtoSpriteFrame06
                dc.l    Boss_DestroyerProtoSpriteFrame05
                dc.l    Boss_DestroyerProtoSpriteFrame06
                dc.l    Boss_DestroyerProtoSpriteFrame07
                dc.l    Boss_DestroyerProtoSpriteFrame08
                dc.l    Boss_DestroyerProtoSpriteFrame09
                dc.l    Boss_DestroyerProtoSpriteFrame08
                dc.l    Boss_DestroyerProtoSpriteFrame07
                dc.l    Boss_DestroyerProtoSpriteFrame06

; Reflects horizontal velocity when collision flag 4 is set
Projectile_DestroyerProtoCheckHorizontalReflection:     ; DATA XREF: ROM:00032220   o  ; was: sub_32308
                bclr    #4,$22(a5)
                bne.s   Projectile_DestroyerProtoReflectHorizontal
                bra.s   Projectile_RemoveOutsideArena
; End of function Projectile_DestroyerProtoCheckHorizontalReflection
; Converts a collision-flag-4 hit into the shared random-pickup response
Projectile_DestroyerProtoCheckHitForPickup:             ; DATA XREF: ROM:0003221E   o  ; was: sub_32312
                bclr    #4,$22(a5)
                bne.s   Projectile_ConvertHitToRandomPickup
; End of function Projectile_DestroyerProtoCheckHitForPickup
; Marks a projectile or scattered boss part outside the arena for removal
Projectile_RemoveOutsideArena:                          ; CODE XREF: Boss_DestroyerProtoPartMain+4   j  ; was: sub_3231A
                                        ; Boss_DestroyerProtoAnimatedPartMain+40   j
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   Projectile_RemoveOutsideArenaNow
                cmpi.w  #$1E0,$10(a5)
                bcc.s   Projectile_RemoveOutsideArenaNow
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcs.s   Projectile_RemoveOutsideArenaNow
                cmpi.w  #$180,$14(a5)
                bcc.s   Projectile_RemoveOutsideArenaNow
                rts
; ---------------------------------------------------------------------------
Projectile_RemoveOutsideArenaNow:                       ; CODE XREF: Projectile_RemoveOutsideArena+6   j  ; was: loc_3233C
                                        ; Projectile_RemoveOutsideArena+E   j
                move.w  #$1000,2(a5)
                rts
; End of function Projectile_RemoveOutsideArena
Projectile_ConvertHitToRandomPickup:                    ; CODE XREF: Projectile_DestroyerProtoCheckHitForPickup+6   j  ; was: sub_32344
                                        ; Projectile_HitReactiveShotMain+18   j
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                jsr     (Pickup_SpawnRandomFromCurrentObject).l
                andi.w  #$FEFF,2(a5)
                rts
; End of function Projectile_ConvertHitToRandomPickup
; Reflects projectile by negating X velocity and advancing state
Projectile_DestroyerProtoReflectHorizontal:             ; CODE XREF: Projectile_DestroyerProtoCheckHorizontalReflection+6   j  ; was: sub_3235C
                neg.l   $18(a5)
                move.w  #2,4(a5)
                rts
; End of function Projectile_DestroyerProtoReflectHorizontal
; Returns projectile to stored velocity after delay timer expires
Projectile_DestroyerProtoRestoreVelocity:               ; DATA XREF: ROM:0003221C   o  ; was: sub_32368
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.l  $4C(a5),$18(a5)
                move.l  $50(a5),$1C(a5)
                subq.w  #2,4(a5)
                rts
; End of function Projectile_DestroyerProtoRestoreVelocity
; Updates a hit-reactive shot, spawning an impact object before removal
Projectile_HitReactiveShotMain:                         ; DATA XREF: ROM:000314D6   o  ; was: sub_32382
                bsr.w   Entity_RemoveWithExplosionWhenEnabled
                bsr.w   Projectile_RemoveOutsideArena
                bclr    #7,$22(a5)
                beq.w   Entity_UpdateReturn
                bclr    #4,$22(a5)
                bne.w   Projectile_ConvertHitToRandomPickup
Projectile_HitReactiveShotSpawnImpact:                  ; CODE XREF: Boss_VictorOrbitingPartCollisionMain+E   j  ; was: loc_3239E
                cmpi.w  #$1A,(StageTableIndex).w
                bne.s   Projectile_HitReactiveShotAllocateImpact
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w            ; ' '
                move.b  #8,(byte_FF8143).w
Projectile_HitReactiveShotAllocateImpact:               ; CODE XREF: Projectile_HitReactiveShotMain+22   j  ; was: loc_323B8
                jsr     (Projectile_FindFreeSlot).l
                bne.s   Projectile_HitReactiveShotRemove
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #SharedCombatSpriteAnimation01,8(a0)
                jsr     (Sprite_InitType160).l
Projectile_HitReactiveShotRemove:                       ; CODE XREF: Projectile_HitReactiveShotMain+3C   j  ; was: loc_323DA
                move.w  #$1000,2(a5)
                rts
; End of function Projectile_HitReactiveShotMain
