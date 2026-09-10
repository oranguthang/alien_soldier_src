; Shared empty entity state handler in the main dispatch table
Entity_EmptyState6:                                     ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: nullsub_6
                rts
; End of function Entity_EmptyState6
; Creates the small pickup variant from the current object
Pickup_SpawnSmallFromCurrentObject:                     ; CODE XREF: Projectile_ExplodeOnWall:loc_2B0FA   p  ; was: sub_2BCFE
                                        ; sub_2B298:loc_2B306   p
                movea.w a5,a0
Pickup_SpawnSmall:                                      ; CODE XREF: Enemy_UpdateBouncingObject+1E   p  ; was: loc_2BD00
                                        ; Effect_InitializeWolfGaropaBoundaryPair+64   p
                moveq   #0,d7
                bra.w   Pickup_InitializeSelectedSize
; End of function Pickup_SpawnSmallFromCurrentObject
; Alternate entry that creates the small pickup from the current object
Pickup_SpawnSmallFromCurrentObjectAlt:
                movea.w a5,a0                           ; was: sub_2BD06
                moveq   #0,d7
                bra.w   Pickup_SpawnSelectedSize
; End of function Pickup_SpawnSmallFromCurrentObjectAlt
; Creates the large pickup variant from the current object
Pickup_SpawnLargeFromCurrentObject:
                movea.w a5,a0                           ; was: sub_2BD0E
; End of function Pickup_SpawnLargeFromCurrentObject
Pickup_SpawnLarge:                                      ; CODE XREF: Boss_JetsripperMain+78   p  ; was: sub_2BD10
                                        ; Boss_JetsripperProjectileUpdate+46   p
                moveq   #1,d7
                bra.w   Pickup_InitializeSelectedSize
; End of function Pickup_SpawnLarge
; Alternate entry that creates the large pickup from the current object
Pickup_SpawnLargeFromCurrentObjectAlt:
                movea.w a5,a0                           ; was: sub_2BD16
Pickup_SelectLargeSize:                                 ; CODE XREF: Pickup_SpawnRandomFromCurrentObject+A   j  ; was: loc_2BD18
                                        ; Projectile_UpdateArtemisRadialEmitter+EC   p
                moveq   #1,d7
                bra.w   Pickup_SpawnSelectedSize
; End of function Pickup_SpawnLargeFromCurrentObjectAlt
; Selects a pickup size randomly with the caller-provided mask
Pickup_SpawnRandomFromCurrentObject:                    ; CODE XREF: Enemy_UpdateDefeatProjectile+26   j  ; was: sub_2BD1E
                                        ; Enemy_ProcessObject+18   j
                movea.w a5,a0
Pickup_SelectRandomSize:                                ; CODE XREF: Stage18_SegmentedWormScatterSegments+36   p  ; was: loc_2BD20
                                        ; Boss_WolfGaropaSpawnFiniteRewardPickups+2A   p
                moveq   #0,d7
                move.w  (dword_FFFF08).w,d1
                and.w   d0,d1
                beq.s   Pickup_SelectLargeSize
                bra.w   *+4
; End of function Pickup_SpawnRandomFromCurrentObject
; Attributes: thunk
Pickup_SpawnSelectedSize:                               ; CODE XREF: Pickup_SpawnSmallFromCurrentObjectAlt+4   j  ; was: sub_2BD2E
                                        ; Pickup_SpawnLargeFromCurrentObjectAlt+4   j
                bra.s   Pickup_InitializeSelectedSize
; End of function Pickup_SpawnSelectedSize
; Suppresses a pickup when the player's resource is already full
Pickup_SpawnSelectedSizeIfResourceNeeded:
                move.w  (word_FFA216).w,d0              ; was: sub_2BD30
                cmp.w   (word_FFA218).w,d0
                bne.s   Pickup_InitializeSelectedSize
Pickup_DeactivateTargetObject:                          ; CODE XREF: Pickup_SpawnSelectedSizeIfResourceNeeded+1C   j  ; was: loc_2BD3A
                move.w  #$10,(a0)
                bset    #4,2(a0)
                rts
; ---------------------------------------------------------------------------
; Initializes the selected pickup size in the target object
Pickup_InitializeSelectedSize:                          ; CODE XREF: Pickup_SpawnSmallFromCurrentObject+4   j  ; was: loc_2BD46
                                        ; Pickup_SpawnLarge+2   j
                cmpi.w  #6,(word_FF8126).w
                bpl.s   Pickup_DeactivateTargetObject
                move.w  #$194,(a0)
                move.w  #$E140,2(a0)
                move.w  #$480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                clr.w   $C(a0)
                clr.b   $20(a0)
                move.b  #$40,$21(a0)                    ; '@'
                clr.b   $22(a0)
                move.b  #$20,$23(a0)                    ; ' '
                move.l  #$FA06FA06,$2C(a0)
                move.b  Pickup_SoundIds(pc,d7.w),$4C(a0)
                asl.w   #1,d7
                move.w  Pickup_ResourceAmounts(pc,d7.w),$48(a0)
                asl.w   #1,d7
                move.l  Pickup_SpriteMappings(pc,d7.w),8(a0)
                move.w  #$A0,$4A(a0)
                rts
; End of function Pickup_SpawnSelectedSizeIfResourceNeeded
; ---------------------------------------------------------------------------
Pickup_SoundIds:        dc.b    $46, $47                ; DATA XREF: Pickup_SpawnSelectedSizeIfResourceNeeded+54   r  ; was: byte_2BDA2
Pickup_ResourceAmounts: dc.w    $1E, $64                ; DATA XREF: Pickup_SpawnSelectedSizeIfResourceNeeded+5C   r  ; was: word_2BDA4
Pickup_SpriteMappings:  dc.l    SharedCombatSpriteAnimation28  ; DATA XREF: Pickup_SpawnSelectedSizeIfResourceNeeded+64   r  ; was: off_2BDA8
                dc.l    SharedCombatSpriteAnimation27

; Updates pickup lifetime, collection, display priority, and motion
Pickup_Update:                                          ; CODE XREF: Effect_WolfGaropaBoundaryFollowerMain:Effect_UpdateWolfGaropaBoundaryFollowerSprite   j  ; was: sub_2BDB0
                                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o
                subq.w  #1,$4A(a5)
                bmi.s   Pickup_Remove
                cmpi.w  #$20,$4A(a5)                    ; ' '
                bpl.s   Pickup_CheckCollection
                bset    #7,2(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   Pickup_CheckCollection
                bclr    #7,2(a5)
Pickup_CheckCollection:                                 ; CODE XREF: Pickup_Update+C   j  ; was: loc_2BDD2
                                        ; Pickup_Update+1A   j
                bclr    #7,$22(a5)
                beq.s   Pickup_UpdateMotion
                bclr    #4,$22(a5)
                bne.s   Pickup_UpdateMotion
                move.b  $4C(a5),d0
                jsr     (Sound_PlaySFX).l
                move.l  #$500,d0
                jsr     (UI_AddScoreBCD).l
                move.w  (word_FFA216).w,d0
                beq.s   Pickup_StoreResourceValue
                bmi.s   Pickup_StoreResourceValue
                add.w   $48(a5),d0
                cmp.w   (word_FFA218).w,d0
                bmi.s   Pickup_StoreResourceValue
                move.w  (word_FFA218).w,d0
Pickup_StoreResourceValue:                              ; CODE XREF: Pickup_Update+4C   j  ; was: loc_2BE0E
                                        ; Pickup_Update+4E   j
                move.w  d0,(word_FFA216).w
                move.w  $48(a5),(word_FF8262).w
                move.w  #$30,(word_FF8268).w            ; '0'
Pickup_Remove:                                          ; CODE XREF: Pickup_Update+4   j  ; was: loc_2BE1E
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
Pickup_UpdateMotion:                                    ; CODE XREF: Pickup_Update+28   j  ; was: loc_2BE26
                                        ; Pickup_Update+30   j
                andi.w  #$E7FF,$E(a5)
                lea     (Object_CameraPriorityTable).l,a0
                move.w  (word_FFA000).w,d0
                asr.w   #1,d0
                andi.w  #6,d0
                move.w  (a0,d0.w),d0
                or.w    d0,$E(a5)
                move.l  (dword_FF8240).w,d0
                add.l   d0,$10(a5)
                move.l  (dword_FF830A).w,d0
                add.l   d0,$14(a5)
                rts
; End of function Pickup_Update
