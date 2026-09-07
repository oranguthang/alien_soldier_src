Collision_UpdateSystem:                                 ; CODE XREF: Sys_GameplayMainLoop:Sys_GameplayMainLoop_UpdateCollision   p  ; was: sub_13ADE
                                        ; Sys_UpdateGameplayLoop+6   p
                tst.b   (byte_FF813E).w
                bmi.s   Collision_UpdateSystem_Return
                bsr.w   Collision_BuildEntityLists
                movea.w #(dword_FFBFC0-M68K_RAM),a5
                btst    #0,(word_FFA000+1).w
                bne.s   Collision_UpdateSystem_RunDynamicChecks
                movea.w #(byte_FFC020-M68K_RAM),a5
Collision_UpdateSystem_RunDynamicChecks:                ; CODE XREF: Collision_UpdateSystem+14   j  ; was: loc_13AF8
                bsr.w   Collision_CheckWeaponProjectilesAgainstEnemies
                bsr.w   Collision_CheckTerrainTiles
                bsr.w   Collision_CheckPlayerAgainstHostiles
                bsr.w   Collision_CheckSpecialAttackTargets
                bsr.w   Collision_PlayerWeaponVsEnemy
                tst.w   (word_FFA216).w
                bpl.s   Collision_UpdateSystem_CheckResourceRefill
                clr.w   (word_FFA216).w
Collision_UpdateSystem_CheckResourceRefill:             ; CODE XREF: Collision_UpdateSystem+32   j  ; was: loc_13B16
                tst.w   (word_FF822A).w
                beq.s   Collision_UpdateSystem_Return
                move.w  (word_FFA218).w,(word_FFA216).w
                move.w  #$5000,(word_FFA270).w
Collision_UpdateSystem_Return:                          ; CODE XREF: Collision_UpdateSystem+4   j  ; was: locret_13B28
                                        ; Collision_UpdateSystem+3C   j
                rts
; End of function Collision_UpdateSystem
; Builds typed collision lists and cached bounds for active objects
Collision_BuildEntityLists:                             ; CODE XREF: Collision_UpdateSystem+6   p  ; was: sub_13B2A
                movea.w #(byte_FF8D80-M68K_RAM),a0
                movea.w #(byte_FF8E00-M68K_RAM),a1
                movea.w #(byte_FF8E80-M68K_RAM),a2
                movea.w #(byte_FF8F00-M68K_RAM),a3
                movea.w #(byte_FF8F80-M68K_RAM),a5
                moveq   #$FFFFFFFF,d0
                move.w  d0,(word_FF8D76).w
                move.w  d0,(word_FF8D78).w
                move.w  d0,(word_FF8D7A).w
                move.w  d0,(word_FF8D7C).w
                move.w  d0,(word_FF8D7E).w
                move.w  d0,(word_FF8126).w
                movea.w #(Entity_ObjectPool-M68K_RAM),a4
                moveq   #$3B,d7                         ; ';'
Collision_BuildEntityLists_ScanLoop:                    ; CODE XREF: Collision_BuildEntityLists+120   j  ; was: loc_13B5E
                tst.w   (a4)
                beq.w   Collision_BuildEntityLists_NextEntity
                move.w  $10(a4),d0
                move.w  $14(a4),d1
                move.b  $21(a4),d6
                move.b  d6,d4
                andi.b  #$42,d4                         ; 'B'
                beq.s   Collision_BuildEntityLists_CheckTargetFlags
                btst    #0,(word_FFA000+1).w
                bne.s   Collision_BuildEntityLists_CheckEvenSlot
                btst    #0,d7
                beq.s   Collision_BuildEntityLists_CheckTargetFlags
                bra.s   Collision_BuildEntityLists_AddPrimaryEntry
; ---------------------------------------------------------------------------
Collision_BuildEntityLists_CheckEvenSlot:               ; CODE XREF: Collision_BuildEntityLists+54   j  ; was: loc_13B88
                btst    #0,d7
                bne.s   Collision_BuildEntityLists_CheckTargetFlags
Collision_BuildEntityLists_AddPrimaryEntry:             ; CODE XREF: Collision_BuildEntityLists+5C   j  ; was: loc_13B8E
                move.w  a4,(a0)+
                addq.w  #1,(word_FF8D76).w
                btst    #5,$23(a4)
                beq.s   Collision_BuildEntityLists_StorePrimaryBounds
                addq.w  #1,(word_FF8126).w
Collision_BuildEntityLists_StorePrimaryBounds:          ; CODE XREF: Collision_BuildEntityLists+70   j  ; was: loc_13BA0
                move.b  $2E(a4),d4
                ext.w   d4
                add.w   d0,d4
                move.w  d4,$3C(a4)
                move.b  $2F(a4),d4
                ext.w   d4
                add.w   d0,d4
                move.w  d4,$3E(a4)
                move.b  $2C(a4),d4
                ext.w   d4
                add.w   d1,d4
                move.w  d4,$38(a4)
                move.b  $2D(a4),d4
                ext.w   d4
                add.w   d1,d4
                move.w  d4,$3A(a4)
Collision_BuildEntityLists_CheckTargetFlags:            ; CODE XREF: Collision_BuildEntityLists+4C   j  ; was: loc_13BD0
                                        ; Collision_BuildEntityLists+5A   j
                move.b  d6,d4
                andi.b  #$90,d4
                beq.s   Collision_BuildEntityLists_CheckPlatformFlag
                move.w  a4,(a1)+
                addq.w  #1,(word_FF8D78).w
                btst    #4,d6
                beq.s   Collision_BuildEntityLists_StoreTargetBounds
                move.w  a4,(a2)+
                addq.w  #1,(word_FF8D7A).w
Collision_BuildEntityLists_StoreTargetBounds:           ; CODE XREF: Collision_BuildEntityLists+B8   j  ; was: loc_13BEA
                move.b  $2A(a4),d4
                ext.w   d4
                add.w   d0,d4
                move.w  d4,$34(a4)
                move.b  $2B(a4),d4
                ext.w   d4
                add.w   d0,d4
                move.w  d4,$36(a4)
                move.b  $28(a4),d4
                ext.w   d4
                add.w   d1,d4
                move.w  d4,$30(a4)
                move.b  $29(a4),d4
                ext.w   d4
                add.w   d1,d4
                move.w  d4,$32(a4)
Collision_BuildEntityLists_CheckPlatformFlag:           ; CODE XREF: Collision_BuildEntityLists+AC   j  ; was: loc_13C1A
                btst    #5,d6
                beq.s   Collision_BuildEntityLists_CheckWeaponFlag
                move.w  $48(a4),$4C(a4)
                move.w  $4A(a4),$4E(a4)
                move.w  d0,$48(a4)
                move.w  d1,$4A(a4)
                move.w  a4,(a3)+
                addq.w  #1,(word_FF8D7C).w
Collision_BuildEntityLists_CheckWeaponFlag:             ; CODE XREF: Collision_BuildEntityLists+F4   j  ; was: loc_13C3A
                btst    #0,d6
                beq.s   Collision_BuildEntityLists_NextEntity
                move.w  a4,(a5)+
                addq.w  #1,(word_FF8D7E).w
Collision_BuildEntityLists_NextEntity:                  ; CODE XREF: Collision_BuildEntityLists+36   j  ; was: loc_13C46
                                        ; Collision_BuildEntityLists+114   j
                lea     $60(a4),a4
                dbf     d7,Collision_BuildEntityLists_ScanLoop
                rts
; End of function Collision_BuildEntityLists
; Multi-point terrain tile collision check for multiple entities
Collision_CheckTerrainTiles:                            ; CODE XREF: Collision_UpdateSystem+1E   p  ; was: sub_13C50
                movea.l #$FFFF0000,a0
                movea.l #$FFFF7800,a1
                movea.w a5,a2
                moveq   #3,d6
                moveq   #4,d1
                move.w  (dword_FFA900).w,d4
                move.w  (dword_FFA904).w,d5
                subi.w  #$80,d4
                addi.w  #$80,d5
Collision_CheckTerrainTiles_ScanLoop:                   ; CODE XREF: Collision_CheckTerrainTiles+74   j  ; was: loc_13C72
                move.w  (a2),d7
                beq.w   Collision_CheckTerrainTiles_NextEntity
                btst    #6,$21(a2)
                beq.s   Collision_CheckTerrainTiles_NextEntity
                btst    #6,$23(a2)
                bne.s   Collision_CheckTerrainTiles_NextEntity
                move.w  $10(a2),d2
                add.w   d4,d2
                asr.w   #2,d2
                andi.w  #$7E,d2                         ; '~'
                move.w  $14(a2),d3
                sub.w   d5,d3
                asl.w   #4,d3
                andi.w  #$1F80,d3
                add.w   d3,d2
                move.w  (a0,d2.w),d2
                andi.w  #$7FF,d2
                move.b  (a1,d2.w),d2
                beq.s   Collision_CheckTerrainTiles_NextEntity
                cmp.b   d1,d2
                bmi.s   Collision_CheckTerrainTiles_NextEntity
                bclr    #6,$21(a2)
                bset    #6,$23(a2)
Collision_CheckTerrainTiles_NextEntity:                 ; CODE XREF: Collision_CheckTerrainTiles+24   j  ; was: loc_13CC0
                                        ; Collision_CheckTerrainTiles+2E   j
                lea     $C0(a2),a2
                dbf     d6,Collision_CheckTerrainTiles_ScanLoop
                rts
; End of function Collision_CheckTerrainTiles
; Checks alternating weapon-effect slots against collision targets
Collision_CheckWeaponProjectilesAgainstEnemies:         ; CODE XREF: Collision_UpdateSystem:Collision_UpdateSystem_RunDynamicChecks   p  ; was: sub_13CCA
                tst.w   (word_FF8D78).w
                bpl.s   Collision_CheckWeaponProjectilesAgainstEnemies_Begin
                rts
; ---------------------------------------------------------------------------
Collision_CheckWeaponProjectilesAgainstEnemies_Begin:   ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+4   j  ; was: loc_13CD2
                moveq   #4,d5
                moveq   #3,d6
                movea.w a5,a3
Collision_CheckWeaponProjectilesAgainstEnemies_WeaponSlotLoop:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+66   j  ; was: loc_13CD8
                move.w  (a3),d4
                beq.w   Collision_CheckWeaponProjectilesAgainstEnemies_NextWeaponSlot
                btst    #6,$21(a3)
                beq.w   Collision_CheckWeaponProjectilesAgainstEnemies_NextWeaponSlot
                move.w  $10(a3),d0
                move.w  d0,d1
                subq.w  #8,d0
                addq.w  #8,d1
                move.w  $14(a3),d2
                move.w  d2,d3
                subq.w  #8,d2
                addq.w  #8,d3
                movea.w #(byte_FF8E00-M68K_RAM),a4
                move.w  (word_FF8D78).w,d7
Collision_CheckWeaponProjectilesAgainstEnemies_TargetLoop:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies:Collision_CheckWeaponProjectilesAgainstEnemies_NextTarget   j  ; was: loc_13D04
                movea.w (a4)+,a2
                cmp.w   $34(a2),d1
                bmi.s   Collision_CheckWeaponProjectilesAgainstEnemies_NextTarget
                cmp.w   $36(a2),d0
                bpl.s   Collision_CheckWeaponProjectilesAgainstEnemies_NextTarget
                cmp.w   $32(a2),d2
                bpl.s   Collision_CheckWeaponProjectilesAgainstEnemies_NextTarget
                cmp.w   $30(a2),d3
                bmi.s   Collision_CheckWeaponProjectilesAgainstEnemies_NextTarget
                btst    d5,$21(a2)
                bne.s   Collision_CheckWeaponProjectilesAgainstEnemies_ResolveFlaggedTarget
                bra.w   Collision_CheckWeaponProjectilesAgainstEnemies_ResolveStandardTarget
; ---------------------------------------------------------------------------
Collision_CheckWeaponProjectilesAgainstEnemies_NextTarget:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+40   j  ; was: loc_13D28
                                        ; Collision_CheckWeaponProjectilesAgainstEnemies+46   j
                dbf     d7,Collision_CheckWeaponProjectilesAgainstEnemies_TargetLoop
Collision_CheckWeaponProjectilesAgainstEnemies_NextWeaponSlot:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+10   j  ; was: loc_13D2C
                                        ; Collision_CheckWeaponProjectilesAgainstEnemies+1A   j
                lea     $C0(a3),a3
                dbf     d6,Collision_CheckWeaponProjectilesAgainstEnemies_WeaponSlotLoop
                rts
; ---------------------------------------------------------------------------
Collision_CheckWeaponProjectilesAgainstEnemies_ResolveFlaggedTarget:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+58   j  ; was: loc_13D36
                btst    #2,(byte_FF80EC).w
                bne.s   Collision_CheckWeaponProjectilesAgainstEnemies_CheckLinkedTarget
                tst.w   (word_FF8200).w
                beq.s   Collision_CheckWeaponProjectilesAgainstEnemies_NextTarget
Collision_CheckWeaponProjectilesAgainstEnemies_CheckLinkedTarget:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+72   j  ; was: loc_13D44
                btst    #1,$23(a3)
                beq.s   Collision_CheckWeaponProjectilesAgainstEnemies_ApplyFlaggedDamage
                cmpa.w  (word_FF801C).w,a2
                bne.s   Collision_CheckWeaponProjectilesAgainstEnemies_NextTarget
Collision_CheckWeaponProjectilesAgainstEnemies_ApplyFlaggedDamage:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+80   j  ; was: loc_13D52
                btst    #1,(byte_FF80EC).w
                bne.w   Collision_CheckWeaponProjectilesAgainstEnemies_ResolveBlockedHit
                btst    #4,$23(a2)
                bne.w   Collision_CheckWeaponProjectilesAgainstEnemies_ResolveBlockedHit
                move.b  $23(a3),d4
                move.b  $23(a2),d0
                andi.b  #$F,d4
                and.b   d4,d0
                bne.w   Collision_CheckWeaponProjectilesAgainstEnemies_ResolveBlockedHit
                btst    #7,$23(a2)
                beq.s   Collision_CheckWeaponProjectilesAgainstEnemies_MarkFlaggedHit
                move.b  #$AE,d0
                jsr     (Sound_PlaySFX).l
                bset    #3,(byte_FF80EC).w
Collision_CheckWeaponProjectilesAgainstEnemies_MarkFlaggedHit:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+B4   j  ; was: loc_13D90
                bset    #0,(byte_FF80EC).w
                bset    #7,$22(a3)
                bset    #6,$22(a2)
                btst    #7,$23(a3)
                bne.s   Collision_CheckWeaponProjectilesAgainstEnemies_SubtractFlaggedHealth
                moveq   #$11,d0
                jsr     (UI_AddScoreBCD).l
Collision_CheckWeaponProjectilesAgainstEnemies_SubtractFlaggedHealth:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+DE   j  ; was: loc_13DB2
                move.w  $26(a3),d4
                move.w  #$FFFF,$26(a3)
                move.w  $24(a2),(word_FF8210).w
                move.w  #$20,(word_FF809A).w            ; ' '
                mulu.w  $24(a2),d4
                sub.w   d4,(word_FF8200).w
                bpl.w   Collision_CheckWeaponProjectilesAgainstEnemies_NextWeaponSlot
                clr.w   (word_FF8200).w
                clr.w   (word_FF8202).w
                clr.b   (byte_FF80EC).w
                clr.w   (word_FF8234).w
                clr.w   (word_FF8236).w
                clr.b   (byte_FF8260).w
                bsr.w   UI_DecrementCounterBCD
                bra.w   Collision_CheckWeaponProjectilesAgainstEnemies_NextWeaponSlot
; ---------------------------------------------------------------------------
Collision_CheckWeaponProjectilesAgainstEnemies_ResolveStandardTarget:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+5A   j  ; was: loc_13DF4
                tst.w   $24(a2)
                bmi.w   Collision_CheckWeaponProjectilesAgainstEnemies_NextTarget
                btst    #4,$23(a2)
                bne.s   Collision_CheckWeaponProjectilesAgainstEnemies_ResolveBlockedHit
                move.b  $23(a3),d4
                move.b  $23(a2),d0
                andi.b  #$F,d4
                and.b   d4,d0
                bne.s   Collision_CheckWeaponProjectilesAgainstEnemies_ResolveBlockedHit
                bset    #7,$22(a3)
                bset    #6,$22(a2)
                move.b  #$AE,d0
                jsr     (Sound_PlaySFX).l
                move.w  $26(a3),d4
                move.w  #$FFFF,$26(a3)
                sub.w   d4,$24(a2)
                bpl.s   Collision_CheckWeaponProjectilesAgainstEnemies_AwardStandardHit
                move.w  $24(a2),d4
                neg.w   d4
                move.w  d4,$26(a3)
                btst    #6,$23(a2)
                beq.s   Collision_CheckWeaponProjectilesAgainstEnemies_FinishStandardDefeat
                subq.w  #1,(word_FF829E).w
                bpl.s   Collision_CheckWeaponProjectilesAgainstEnemies_FinishStandardDefeat
                clr.w   (word_FF829E).w
Collision_CheckWeaponProjectilesAgainstEnemies_FinishStandardDefeat:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+180   j  ; was: loc_13E56
                                        ; Collision_CheckWeaponProjectilesAgainstEnemies+186   j
                btst    #7,$23(a2)
                bne.w   Collision_CheckWeaponProjectilesAgainstEnemies_NextWeaponSlot
                bsr.w   UI_DecrementCounterBCD
                bra.w   Collision_CheckWeaponProjectilesAgainstEnemies_NextWeaponSlot
; ---------------------------------------------------------------------------
Collision_CheckWeaponProjectilesAgainstEnemies_AwardStandardHit:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+16E   j  ; was: loc_13E68
                btst    #7,$23(a3)
                bne.w   Collision_CheckWeaponProjectilesAgainstEnemies_NextWeaponSlot
                moveq   #$21,d0                         ; '!'
                jsr     (UI_AddScoreBCD).l
                bra.w   Collision_CheckWeaponProjectilesAgainstEnemies_NextWeaponSlot
; ---------------------------------------------------------------------------
Collision_CheckWeaponProjectilesAgainstEnemies_ResolveBlockedHit:  ; CODE XREF: Collision_CheckWeaponProjectilesAgainstEnemies+8E   j  ; was: loc_13E7E
                                        ; Collision_CheckWeaponProjectilesAgainstEnemies+98   j
                bclr    #6,$21(a3)
                move.b  #$50,$23(a3)                    ; 'P'
                bset    #3,$22(a2)
                bset    #0,$22(a2)
                bra.w   Collision_CheckWeaponProjectilesAgainstEnemies_NextWeaponSlot
; End of function Collision_CheckWeaponProjectilesAgainstEnemies
; Checks the player object against hostile collision entries
Collision_CheckPlayerAgainstHostiles:                   ; CODE XREF: Collision_UpdateSystem+22   p  ; was: sub_13E9A
                btst    #4,(byte_FF8245).w
                bne.w   Collision_CheckPlayerAgainstHostiles_Return
                subq.b  #1,(byte_FF825D).w
                bpl.s   Collision_CheckPlayerAgainstHostiles_Begin
                move.b  #$FF,(byte_FF825D).w
Collision_CheckPlayerAgainstHostiles_Begin:             ; CODE XREF: Collision_CheckPlayerAgainstHostiles+E   j  ; was: loc_13EB0
                clr.l   (dword_FF8300).w
                movea.w #(word_FFA400-M68K_RAM),a0
                tst.b   $21(a0)
                beq.w   Collision_CheckPlayerAgainstHostiles_Return
                move.b  $2A(a0),d0
                ext.w   d0
                add.w   $10(a0),d0
                move.b  $2B(a0),d1
                ext.w   d1
                add.w   $10(a0),d1
                move.b  $28(a0),d2
                ext.w   d2
                add.w   $14(a0),d2
                move.b  $29(a0),d3
                ext.w   d3
                add.w   $14(a0),d3
                movea.w #(byte_FF8D80-M68K_RAM),a1
                move.w  (word_FF8D76).w,d7
                bmi.w   Collision_CheckPlayerAgainstHostiles_Return
Collision_CheckPlayerAgainstHostiles_HostileLoop:       ; CODE XREF: Collision_CheckPlayerAgainstHostiles:Collision_CheckPlayerAgainstHostiles_NextHostile   j  ; was: loc_13EF4
                movea.w (a1)+,a2
                cmp.w   $3C(a2),d1
                bmi.w   Collision_CheckPlayerAgainstHostiles_NextHostile
                cmp.w   $3E(a2),d0
                bpl.w   Collision_CheckPlayerAgainstHostiles_NextHostile
                cmp.w   $3A(a2),d2
                bpl.w   Collision_CheckPlayerAgainstHostiles_NextHostile
                cmp.w   $38(a2),d3
                bmi.w   Collision_CheckPlayerAgainstHostiles_NextHostile
                btst    #5,$23(a2)
                beq.s   Collision_CheckPlayerAgainstHostiles_ResolveHit
                bset    #7,$22(a2)
                bra.s   Collision_CheckPlayerAgainstHostiles_NextHostile
; ---------------------------------------------------------------------------
Collision_CheckPlayerAgainstHostiles_ResolveHit:        ; CODE XREF: Collision_CheckPlayerAgainstHostiles+82   j  ; was: loc_13F26
                btst    #4,$23(a0)
                bne.s   Collision_CheckPlayerAgainstHostiles_NextHostile
                bset    #7,$22(a2)
                move.b  $21(a2),d6
                btst    #6,d6
                beq.s   Collision_CheckPlayerAgainstHostiles_CheckContactDamage
                move.b  $21(a2),d0
                andi.b  #$48,d0                         ; 'H'
                or.b    d0,$22(a0)
                move.w  $26(a2),d4
                cmpi.w  #1,(word_FFA216).w
                bne.s   Collision_CheckPlayerAgainstHostiles_SubtractResource
                clr.w   (word_FFA216).w
                bra.s   Collision_CheckPlayerAgainstHostiles_ApplyDamage
; ---------------------------------------------------------------------------
Collision_CheckPlayerAgainstHostiles_SubtractResource:  ; CODE XREF: Collision_CheckPlayerAgainstHostiles+BA   j  ; was: loc_13F5C
                sub.w   d4,(word_FFA216).w
                bpl.s   Collision_CheckPlayerAgainstHostiles_ApplyDamage
                move.w  #1,(word_FFA216).w
                bra.s   Collision_CheckPlayerAgainstHostiles_ApplyDamage
; ---------------------------------------------------------------------------
Collision_CheckPlayerAgainstHostiles_CheckContactDamage:  ; CODE XREF: Collision_CheckPlayerAgainstHostiles+A2   j  ; was: loc_13F6A
                btst    #1,d6
                beq.s   Collision_CheckPlayerAgainstHostiles_NextHostile
                tst.b   (byte_FF825D).w
                bpl.s   Collision_CheckPlayerAgainstHostiles_NextHostile
                btst    #0,$21(a0)
                bne.s   Collision_CheckPlayerAgainstHostiles_MarkContactDamage
                bclr    #1,d6
                bra.s   Collision_CheckPlayerAgainstHostiles_NextHostile
; ---------------------------------------------------------------------------
Collision_CheckPlayerAgainstHostiles_MarkContactDamage:  ; CODE XREF: Collision_CheckPlayerAgainstHostiles+E2   j  ; was: loc_13F84
                bclr    #0,$21(a0)
                bset    #1,$22(a0)
                bset    #1,$22(a2)
Collision_CheckPlayerAgainstHostiles_NextHostile:       ; CODE XREF: Collision_CheckPlayerAgainstHostiles+60   j  ; was: loc_13F96
                                        ; Collision_CheckPlayerAgainstHostiles+68   j
                dbf     d7,Collision_CheckPlayerAgainstHostiles_HostileLoop
Collision_CheckPlayerAgainstHostiles_Return:            ; CODE XREF: Collision_CheckPlayerAgainstHostiles+6   j  ; was: locret_13F9A
                                        ; Collision_CheckPlayerAgainstHostiles+22   j
                rts
; ---------------------------------------------------------------------------
Collision_CheckPlayerAgainstHostiles_ApplyDamage:       ; CODE XREF: Collision_CheckPlayerAgainstHostiles+C0   j  ; was: loc_13F9C
                                        ; Collision_CheckPlayerAgainstHostiles+C6   j
                movea.w #(word_FFFF46-M68K_RAM),a3
                movea.w #(word_FF804A-M68K_RAM),a4
                move.w  #1,(word_FF8048).w
                sub.w   d1,d1
                abcd    -(a4),-(a3)
                abcd    -(a4),-(a3)
                bcc.s   Collision_CheckPlayerAgainstHostiles_StoreDamageFeedback
                move.w  #$9999,(word_FFFF44).w
Collision_CheckPlayerAgainstHostiles_StoreDamageFeedback:  ; CODE XREF: Collision_CheckPlayerAgainstHostiles+116   j  ; was: loc_13FB8
                move.l  $18(a2),(dword_FF8300).w
                move.w  d4,(word_FF8262).w
                ori.w   #$8000,(word_FF8262).w
                move.w  #$30,(word_FF8268).w            ; '0'
                btst    #1,$21(a2)
                bne.s   Collision_CheckPlayerAgainstHostiles_DamageReturn
                move.w  #4,(word_FF813C).w
                move.w  #$10,d0
                move.w  #$3C,d1                         ; '<'
                tst.w   (word_FFFF0E).w
                bne.s   Collision_CheckPlayerAgainstHostiles_SelectLowerResponse
                move.w  #$20,d0                         ; ' '
                move.w  #$78,d1                         ; 'x'
Collision_CheckPlayerAgainstHostiles_SelectLowerResponse:  ; CODE XREF: Collision_CheckPlayerAgainstHostiles+14E   j  ; was: loc_13FF2
                cmp.w   d4,d0
                bmi.s   Collision_CheckPlayerAgainstHostiles_SelectUpperResponse
                move.w  d0,$5E(a0)
                rts
; ---------------------------------------------------------------------------
Collision_CheckPlayerAgainstHostiles_SelectUpperResponse:  ; CODE XREF: Collision_CheckPlayerAgainstHostiles+15A   j  ; was: loc_13FFC
                cmp.w   d4,d1
                bpl.s   Collision_CheckPlayerAgainstHostiles_StoreResponse
                move.w  d1,$5E(a0)
                rts
; ---------------------------------------------------------------------------
Collision_CheckPlayerAgainstHostiles_StoreResponse:     ; CODE XREF: Collision_CheckPlayerAgainstHostiles+164   j  ; was: loc_14006
                move.w  d4,$5E(a0)
Collision_CheckPlayerAgainstHostiles_DamageReturn:      ; CODE XREF: Collision_CheckPlayerAgainstHostiles+13A   j  ; was: locret_1400A
                rts
; End of function Collision_CheckPlayerAgainstHostiles
; Checks the dedicated player special-attack object against collision targets
Collision_CheckSpecialAttackTargets:                    ; CODE XREF: Collision_UpdateSystem+26   p  ; was: sub_1400C
                movea.w #(word_FFC5C0-M68K_RAM),a0
                tst.w   (a0)
                beq.w   Collision_CheckSpecialAttackTargets_Return
                tst.b   $21(a0)
                beq.w   Collision_CheckSpecialAttackTargets_Return
                moveq   #$FFFFFFE4,d0
                add.w   $10(a0),d0
                moveq   #$1C,d1
                add.w   $10(a0),d1
                moveq   #$FFFFFFE2,d2
                add.w   $14(a0),d2
                moveq   #$1E,d3
                add.w   $14(a0),d3
                movea.w #(byte_FF8D80-M68K_RAM),a1
                move.w  (word_FF8D76).w,d7
                bmi.w   Collision_CheckSpecialAttackTargets_CheckTargets
Collision_CheckSpecialAttackTargets_PrimaryLoop:        ; CODE XREF: Collision_CheckSpecialAttackTargets:Collision_CheckSpecialAttackTargets_NextPrimary   j  ; was: loc_14042
                movea.w (a1)+,a2
                cmp.w   $3C(a2),d1
                bmi.s   Collision_CheckSpecialAttackTargets_NextPrimary
                cmp.w   $3E(a2),d0
                bpl.s   Collision_CheckSpecialAttackTargets_NextPrimary
                cmp.w   $3A(a2),d2
                bpl.s   Collision_CheckSpecialAttackTargets_NextPrimary
                cmp.w   $38(a2),d3
                bmi.s   Collision_CheckSpecialAttackTargets_NextPrimary
                ori.b   #$90,$22(a2)
Collision_CheckSpecialAttackTargets_NextPrimary:        ; CODE XREF: Collision_CheckSpecialAttackTargets+3C   j  ; was: loc_14062
                                        ; Collision_CheckSpecialAttackTargets+42   j
                dbf     d7,Collision_CheckSpecialAttackTargets_PrimaryLoop
Collision_CheckSpecialAttackTargets_CheckTargets:       ; CODE XREF: Collision_CheckSpecialAttackTargets+32   j  ; was: loc_14066
                movea.w #(word_FFC5C0-M68K_RAM),a3
                movea.w #(byte_FF8E00-M68K_RAM),a4
                moveq   #4,d5
                move.w  (word_FF8D78).w,d7
                bmi.w   Collision_CheckSpecialAttackTargets_Return
Collision_CheckSpecialAttackTargets_TargetLoop:         ; CODE XREF: Collision_CheckSpecialAttackTargets:Collision_CheckSpecialAttackTargets_NextTarget   j  ; was: loc_14078
                movea.w (a4)+,a2
                cmp.w   $34(a2),d1
                bmi.s   Collision_CheckSpecialAttackTargets_NextTarget
                cmp.w   $36(a2),d0
                bpl.s   Collision_CheckSpecialAttackTargets_NextTarget
                cmp.w   $32(a2),d2
                bpl.s   Collision_CheckSpecialAttackTargets_NextTarget
                cmp.w   $30(a2),d3
                bmi.s   Collision_CheckSpecialAttackTargets_NextTarget
                btst    d5,$21(a2)
                bne.s   Collision_CheckSpecialAttackTargets_ResolveFlaggedTarget
                beq.w   Collision_CheckSpecialAttackTargets_ApplyStandardDamage
Collision_CheckSpecialAttackTargets_NextTarget:         ; CODE XREF: Collision_CheckSpecialAttackTargets+72   j  ; was: loc_1409C
                                        ; Collision_CheckSpecialAttackTargets+78   j
                dbf     d7,Collision_CheckSpecialAttackTargets_TargetLoop
Collision_CheckSpecialAttackTargets_Return:             ; CODE XREF: Collision_CheckSpecialAttackTargets+6   j  ; was: locret_140A0
                                        ; Collision_CheckSpecialAttackTargets+E   j
                rts
; ---------------------------------------------------------------------------
Collision_CheckSpecialAttackTargets_ResolveFlaggedTarget:  ; CODE XREF: Collision_CheckSpecialAttackTargets+8A   j  ; was: loc_140A2
                btst    #2,(byte_FF80EC).w
                bne.s   Collision_CheckSpecialAttackTargets_ApplyFlaggedDamage
                tst.w   (word_FF8200).w
                beq.s   Collision_CheckSpecialAttackTargets_NextTarget
Collision_CheckSpecialAttackTargets_ApplyFlaggedDamage:  ; CODE XREF: Collision_CheckSpecialAttackTargets+9C   j  ; was: loc_140B0
                bset    #7,$22(a3)
                btst    #1,(byte_FF80EC).w
                bne.s   Collision_CheckSpecialAttackTargets_NextTarget
                btst    #4,$23(a2)
                bne.s   Collision_CheckSpecialAttackTargets_NextTarget
                movem.l d0,-(sp)
                move.b  #$AE,d0
                jsr     (Sound_PlaySFX).l
                movem.l (sp)+,d0
                move.b  $21(a3),d4
                or.b    d4,(byte_FF8308).w
                bset    #0,(byte_FF8308).w
                bset    #0,(byte_FF80EC).w
                or.b    d4,$22(a2)
                move.w  $26(a3),d4
                move.w  $24(a2),(word_FF8210).w
                move.w  #$20,(word_FF809A).w            ; ' '
                mulu.w  $24(a2),d4
                sub.w   d4,(word_FF8200).w
                bpl.s   Collision_CheckSpecialAttackTargets_NextTarget
                clr.w   (word_FF8200).w
                clr.w   (word_FF8202).w
                clr.b   (byte_FF80EC).w
                clr.w   (word_FF8234).w
                clr.w   (word_FF8236).w
                clr.b   (byte_FF8260).w
                bsr.w   UI_DecrementCounterBCD
                bra.w   Collision_CheckSpecialAttackTargets_NextTarget
; ---------------------------------------------------------------------------
Collision_CheckSpecialAttackTargets_ApplyStandardDamage:  ; CODE XREF: Collision_CheckSpecialAttackTargets+8C   j  ; was: loc_1412A
                tst.w   $24(a2)
                bmi.w   Collision_CheckSpecialAttackTargets_NextTarget
                ori.b   #$10,$22(a2)
                ori.b   #$80,$22(a3)
                btst    #4,$23(a2)
                bne.w   Collision_CheckSpecialAttackTargets_NextTarget
                ori.b   #$50,$22(a2)                    ; 'P'
                movem.l d0,-(sp)
                move.b  #$AE,d0
                jsr     (Sound_PlaySFX).l
                movem.l (sp)+,d0
                move.w  $26(a3),d4
                sub.w   d4,$24(a2)
                bpl.w   Collision_CheckSpecialAttackTargets_NextTarget
                btst    #6,$23(a2)
                beq.s   Collision_CheckSpecialAttackTargets_FinishStandardDefeat
                subq.w  #1,(word_FF829E).w
                bpl.s   Collision_CheckSpecialAttackTargets_FinishStandardDefeat
                clr.w   (word_FF829E).w
Collision_CheckSpecialAttackTargets_FinishStandardDefeat:  ; CODE XREF: Collision_CheckSpecialAttackTargets+166   j  ; was: loc_1417E
                                        ; Collision_CheckSpecialAttackTargets+16C   j
                btst    #7,$23(a2)
                bne.w   Collision_CheckSpecialAttackTargets_NextTarget
                bsr.w   UI_DecrementCounterBCD
                bra.w   Collision_CheckSpecialAttackTargets_NextTarget
; End of function Collision_CheckSpecialAttackTargets
