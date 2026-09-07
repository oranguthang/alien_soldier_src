Boss_UpdateCollisionSystem:                             ; CODE XREF: Sys_GameplayMainLoop:loc_1C6A6   p  ; was: sub_13ADE
                                        ; Sys_UpdateGameplayLoop+6   p
                tst.b   (byte_FF813E).w
                bmi.s   locret_13B28
                bsr.w   Enemy_BuildCollisionLists
                movea.w #(dword_FFBFC0-M68K_RAM),a5
                btst    #0,(word_FFA000+1).w
                bne.s   loc_13AF8
                movea.w #(byte_FFC020-M68K_RAM),a5
loc_13AF8:                                              ; CODE XREF: Boss_UpdateCollisionSystem+14   j
                bsr.w   Enemy_DetectPlayerCollision
                bsr.w   Collision_CheckTerrainTiles
                bsr.w   Player_DetectProjectileHit
                bsr.w   Sprite_SetBossOAMEntry
                bsr.w   Collision_PlayerWeaponVsEnemy
                tst.w   (word_FFA216).w
                bpl.s   loc_13B16
                clr.w   (word_FFA216).w
loc_13B16:                                              ; CODE XREF: Boss_UpdateCollisionSystem+32   j
                tst.w   (word_FF822A).w
                beq.s   locret_13B28
                move.w  (word_FFA218).w,(word_FFA216).w
                move.w  #$5000,(word_FFA270).w
locret_13B28:                                           ; CODE XREF: Boss_UpdateCollisionSystem+4   j
                                        ; Boss_UpdateCollisionSystem+3C   j
                rts
; End of function Boss_UpdateCollisionSystem
; Builds collision lists for all active enemy entities by type
Enemy_BuildCollisionLists:                              ; CODE XREF: Boss_UpdateCollisionSystem+6   p  ; was: sub_13B2A
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
loc_13B5E:                                              ; CODE XREF: Enemy_BuildCollisionLists+120   j
                tst.w   (a4)
                beq.w   loc_13C46
                move.w  $10(a4),d0
                move.w  $14(a4),d1
                move.b  $21(a4),d6
                move.b  d6,d4
                andi.b  #$42,d4                         ; 'B'
                beq.s   loc_13BD0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_13B88
                btst    #0,d7
                beq.s   loc_13BD0
                bra.s   loc_13B8E
; ---------------------------------------------------------------------------
loc_13B88:                                              ; CODE XREF: Enemy_BuildCollisionLists+54   j
                btst    #0,d7
                bne.s   loc_13BD0
loc_13B8E:                                              ; CODE XREF: Enemy_BuildCollisionLists+5C   j
                move.w  a4,(a0)+
                addq.w  #1,(word_FF8D76).w
                btst    #5,$23(a4)
                beq.s   loc_13BA0
                addq.w  #1,(word_FF8126).w
loc_13BA0:                                              ; CODE XREF: Enemy_BuildCollisionLists+70   j
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
loc_13BD0:                                              ; CODE XREF: Enemy_BuildCollisionLists+4C   j
                                        ; Enemy_BuildCollisionLists+5A   j
                move.b  d6,d4
                andi.b  #$90,d4
                beq.s   loc_13C1A
                move.w  a4,(a1)+
                addq.w  #1,(word_FF8D78).w
                btst    #4,d6
                beq.s   loc_13BEA
                move.w  a4,(a2)+
                addq.w  #1,(word_FF8D7A).w
loc_13BEA:                                              ; CODE XREF: Enemy_BuildCollisionLists+B8   j
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
loc_13C1A:                                              ; CODE XREF: Enemy_BuildCollisionLists+AC   j
                btst    #5,d6
                beq.s   loc_13C3A
                move.w  $48(a4),$4C(a4)
                move.w  $4A(a4),$4E(a4)
                move.w  d0,$48(a4)
                move.w  d1,$4A(a4)
                move.w  a4,(a3)+
                addq.w  #1,(word_FF8D7C).w
loc_13C3A:                                              ; CODE XREF: Enemy_BuildCollisionLists+F4   j
                btst    #0,d6
                beq.s   loc_13C46
                move.w  a4,(a5)+
                addq.w  #1,(word_FF8D7E).w
loc_13C46:                                              ; CODE XREF: Enemy_BuildCollisionLists+36   j
                                        ; Enemy_BuildCollisionLists+114   j
                lea     $60(a4),a4
                dbf     d7,loc_13B5E
                rts
; End of function Enemy_BuildCollisionLists
; Multi-point terrain tile collision check for multiple entities
Collision_CheckTerrainTiles:                            ; CODE XREF: Boss_UpdateCollisionSystem+1E   p  ; was: sub_13C50
                movea.l #$FFFF0000,a0
                movea.l #$FFFF7800,a1
                movea.w a5,a2
                moveq   #3,d6
                moveq   #4,d1
                move.w  (dword_FFA900).w,d4
                move.w  (dword_FFA904).w,d5
                subi.w  #$80,d4
                addi.w  #$80,d5
loc_13C72:                                              ; CODE XREF: Collision_CheckTerrainTiles+74   j
                move.w  (a2),d7
                beq.w   loc_13CC0
                btst    #6,$21(a2)
                beq.s   loc_13CC0
                btst    #6,$23(a2)
                bne.s   loc_13CC0
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
                beq.s   loc_13CC0
                cmp.b   d1,d2
                bmi.s   loc_13CC0
                bclr    #6,$21(a2)
                bset    #6,$23(a2)
loc_13CC0:                                              ; CODE XREF: Collision_CheckTerrainTiles+24   j
                                        ; Collision_CheckTerrainTiles+2E   j
                lea     $C0(a2),a2
                dbf     d6,loc_13C72
                rts
; End of function Collision_CheckTerrainTiles
; Detects collision between enemies and player
Enemy_DetectPlayerCollision:                            ; CODE XREF: Boss_UpdateCollisionSystem:loc_13AF8   p  ; was: sub_13CCA
                tst.w   (word_FF8D78).w
                bpl.s   loc_13CD2
                rts
; ---------------------------------------------------------------------------
loc_13CD2:                                              ; CODE XREF: Enemy_DetectPlayerCollision+4   j
                moveq   #4,d5
                moveq   #3,d6
                movea.w a5,a3
loc_13CD8:                                              ; CODE XREF: Enemy_DetectPlayerCollision+66   j
                move.w  (a3),d4
                beq.w   loc_13D2C
                btst    #6,$21(a3)
                beq.w   loc_13D2C
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
loc_13D04:                                              ; CODE XREF: Enemy_DetectPlayerCollision:loc_13D28   j
                movea.w (a4)+,a2
                cmp.w   $34(a2),d1
                bmi.s   loc_13D28
                cmp.w   $36(a2),d0
                bpl.s   loc_13D28
                cmp.w   $32(a2),d2
                bpl.s   loc_13D28
                cmp.w   $30(a2),d3
                bmi.s   loc_13D28
                btst    d5,$21(a2)
                bne.s   loc_13D36
                bra.w   loc_13DF4
; ---------------------------------------------------------------------------
loc_13D28:                                              ; CODE XREF: Enemy_DetectPlayerCollision+40   j
                                        ; Enemy_DetectPlayerCollision+46   j
                dbf     d7,loc_13D04
loc_13D2C:                                              ; CODE XREF: Enemy_DetectPlayerCollision+10   j
                                        ; Enemy_DetectPlayerCollision+1A   j
                lea     $C0(a3),a3
                dbf     d6,loc_13CD8
                rts
; ---------------------------------------------------------------------------
loc_13D36:                                              ; CODE XREF: Enemy_DetectPlayerCollision+58   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_13D44
                tst.w   (word_FF8200).w
                beq.s   loc_13D28
loc_13D44:                                              ; CODE XREF: Enemy_DetectPlayerCollision+72   j
                btst    #1,$23(a3)
                beq.s   loc_13D52
                cmpa.w  (word_FF801C).w,a2
                bne.s   loc_13D28
loc_13D52:                                              ; CODE XREF: Enemy_DetectPlayerCollision+80   j
                btst    #1,(byte_FF80EC).w
                bne.w   loc_13E7E
                btst    #4,$23(a2)
                bne.w   loc_13E7E
                move.b  $23(a3),d4
                move.b  $23(a2),d0
                andi.b  #$F,d4
                and.b   d4,d0
                bne.w   loc_13E7E
                btst    #7,$23(a2)
                beq.s   loc_13D90
                move.b  #$AE,d0
                jsr     (Sound_PlaySFX).l
                bset    #3,(byte_FF80EC).w
loc_13D90:                                              ; CODE XREF: Enemy_DetectPlayerCollision+B4   j
                bset    #0,(byte_FF80EC).w
                bset    #7,$22(a3)
                bset    #6,$22(a2)
                btst    #7,$23(a3)
                bne.s   loc_13DB2
                moveq   #$11,d0
                jsr     (UI_AddScoreBCD).l
loc_13DB2:                                              ; CODE XREF: Enemy_DetectPlayerCollision+DE   j
                move.w  $26(a3),d4
                move.w  #$FFFF,$26(a3)
                move.w  $24(a2),(word_FF8210).w
                move.w  #$20,(word_FF809A).w            ; ' '
                mulu.w  $24(a2),d4
                sub.w   d4,(word_FF8200).w
                bpl.w   loc_13D2C
                clr.w   (word_FF8200).w
                clr.w   (word_FF8202).w
                clr.b   (byte_FF80EC).w
                clr.w   (word_FF8234).w
                clr.w   (word_FF8236).w
                clr.b   (byte_FF8260).w
                bsr.w   UI_DecrementScoreBCD
                bra.w   loc_13D2C
; ---------------------------------------------------------------------------
loc_13DF4:                                              ; CODE XREF: Enemy_DetectPlayerCollision+5A   j
                tst.w   $24(a2)
                bmi.w   loc_13D28
                btst    #4,$23(a2)
                bne.s   loc_13E7E
                move.b  $23(a3),d4
                move.b  $23(a2),d0
                andi.b  #$F,d4
                and.b   d4,d0
                bne.s   loc_13E7E
                bset    #7,$22(a3)
                bset    #6,$22(a2)
                move.b  #$AE,d0
                jsr     (Sound_PlaySFX).l
                move.w  $26(a3),d4
                move.w  #$FFFF,$26(a3)
                sub.w   d4,$24(a2)
                bpl.s   loc_13E68
                move.w  $24(a2),d4
                neg.w   d4
                move.w  d4,$26(a3)
                btst    #6,$23(a2)
                beq.s   loc_13E56
                subq.w  #1,(word_FF829E).w
                bpl.s   loc_13E56
                clr.w   (word_FF829E).w
loc_13E56:                                              ; CODE XREF: Enemy_DetectPlayerCollision+180   j
                                        ; Enemy_DetectPlayerCollision+186   j
                btst    #7,$23(a2)
                bne.w   loc_13D2C
                bsr.w   UI_DecrementScoreBCD
                bra.w   loc_13D2C
; ---------------------------------------------------------------------------
loc_13E68:                                              ; CODE XREF: Enemy_DetectPlayerCollision+16E   j
                btst    #7,$23(a3)
                bne.w   loc_13D2C
                moveq   #$21,d0                         ; '!'
                jsr     (UI_AddScoreBCD).l
                bra.w   loc_13D2C
; ---------------------------------------------------------------------------
loc_13E7E:                                              ; CODE XREF: Enemy_DetectPlayerCollision+8E   j
                                        ; Enemy_DetectPlayerCollision+98   j
                bclr    #6,$21(a3)
                move.b  #$50,$23(a3)                    ; 'P'
                bset    #3,$22(a2)
                bset    #0,$22(a2)
                bra.w   loc_13D2C
; End of function Enemy_DetectPlayerCollision
; Detects player projectile hits on enemies
Player_DetectProjectileHit:                             ; CODE XREF: Boss_UpdateCollisionSystem+22   p  ; was: sub_13E9A
                btst    #4,(byte_FF8245).w
                bne.w   locret_13F9A
                subq.b  #1,(byte_FF825D).w
                bpl.s   loc_13EB0
                move.b  #$FF,(byte_FF825D).w
loc_13EB0:                                              ; CODE XREF: Player_DetectProjectileHit+E   j
                clr.l   (dword_FF8300).w
                movea.w #(word_FFA400-M68K_RAM),a0
                tst.b   $21(a0)
                beq.w   locret_13F9A
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
                bmi.w   locret_13F9A
loc_13EF4:                                              ; CODE XREF: Player_DetectProjectileHit:loc_13F96   j
                movea.w (a1)+,a2
                cmp.w   $3C(a2),d1
                bmi.w   loc_13F96
                cmp.w   $3E(a2),d0
                bpl.w   loc_13F96
                cmp.w   $3A(a2),d2
                bpl.w   loc_13F96
                cmp.w   $38(a2),d3
                bmi.w   loc_13F96
                btst    #5,$23(a2)
                beq.s   loc_13F26
                bset    #7,$22(a2)
                bra.s   loc_13F96
; ---------------------------------------------------------------------------
loc_13F26:                                              ; CODE XREF: Player_DetectProjectileHit+82   j
                btst    #4,$23(a0)
                bne.s   loc_13F96
                bset    #7,$22(a2)
                move.b  $21(a2),d6
                btst    #6,d6
                beq.s   loc_13F6A
                move.b  $21(a2),d0
                andi.b  #$48,d0                         ; 'H'
                or.b    d0,$22(a0)
                move.w  $26(a2),d4
                cmpi.w  #1,(word_FFA216).w
                bne.s   loc_13F5C
                clr.w   (word_FFA216).w
                bra.s   loc_13F9C
; ---------------------------------------------------------------------------
loc_13F5C:                                              ; CODE XREF: Player_DetectProjectileHit+BA   j
                sub.w   d4,(word_FFA216).w
                bpl.s   loc_13F9C
                move.w  #1,(word_FFA216).w
                bra.s   loc_13F9C
; ---------------------------------------------------------------------------
loc_13F6A:                                              ; CODE XREF: Player_DetectProjectileHit+A2   j
                btst    #1,d6
                beq.s   loc_13F96
                tst.b   (byte_FF825D).w
                bpl.s   loc_13F96
                btst    #0,$21(a0)
                bne.s   loc_13F84
                bclr    #1,d6
                bra.s   loc_13F96
; ---------------------------------------------------------------------------
loc_13F84:                                              ; CODE XREF: Player_DetectProjectileHit+E2   j
                bclr    #0,$21(a0)
                bset    #1,$22(a0)
                bset    #1,$22(a2)
loc_13F96:                                              ; CODE XREF: Player_DetectProjectileHit+60   j
                                        ; Player_DetectProjectileHit+68   j
                dbf     d7,loc_13EF4
locret_13F9A:                                           ; CODE XREF: Player_DetectProjectileHit+6   j
                                        ; Player_DetectProjectileHit+22   j
                rts
; ---------------------------------------------------------------------------
loc_13F9C:                                              ; CODE XREF: Player_DetectProjectileHit+C0   j
                                        ; Player_DetectProjectileHit+C6   j
                movea.w #(word_FFFF46-M68K_RAM),a3
                movea.w #(word_FF804A-M68K_RAM),a4
                move.w  #1,(word_FF8048).w
                sub.w   d1,d1
                abcd    -(a4),-(a3)
                abcd    -(a4),-(a3)
                bcc.s   loc_13FB8
                move.w  #$9999,(word_FFFF44).w
loc_13FB8:                                              ; CODE XREF: Player_DetectProjectileHit+116   j
                move.l  $18(a2),(dword_FF8300).w
                move.w  d4,(word_FF8262).w
                ori.w   #$8000,(word_FF8262).w
                move.w  #$30,(word_FF8268).w            ; '0'
                btst    #1,$21(a2)
                bne.s   locret_1400A
                move.w  #4,(word_FF813C).w
                move.w  #$10,d0
                move.w  #$3C,d1                         ; '<'
                tst.w   (word_FFFF0E).w
                bne.s   loc_13FF2
                move.w  #$20,d0                         ; ' '
                move.w  #$78,d1                         ; 'x'
loc_13FF2:                                              ; CODE XREF: Player_DetectProjectileHit+14E   j
                cmp.w   d4,d0
                bmi.s   loc_13FFC
                move.w  d0,$5E(a0)
                rts
; ---------------------------------------------------------------------------
loc_13FFC:                                              ; CODE XREF: Player_DetectProjectileHit+15A   j
                cmp.w   d4,d1
                bpl.s   loc_14006
                move.w  d1,$5E(a0)
                rts
; ---------------------------------------------------------------------------
loc_14006:                                              ; CODE XREF: Player_DetectProjectileHit+164   j
                move.w  d4,$5E(a0)
locret_1400A:                                           ; CODE XREF: Player_DetectProjectileHit+13A   j
                rts
; End of function Player_DetectProjectileHit
; Sets OAM sprite entry for boss graphics
Sprite_SetBossOAMEntry:                                 ; CODE XREF: Boss_UpdateCollisionSystem+26   p  ; was: sub_1400C
                movea.w #(word_FFC5C0-M68K_RAM),a0
                tst.w   (a0)
                beq.w   locret_140A0
                tst.b   $21(a0)
                beq.w   locret_140A0
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
                bmi.w   loc_14066
loc_14042:                                              ; CODE XREF: Sprite_SetBossOAMEntry:loc_14062   j
                movea.w (a1)+,a2
                cmp.w   $3C(a2),d1
                bmi.s   loc_14062
                cmp.w   $3E(a2),d0
                bpl.s   loc_14062
                cmp.w   $3A(a2),d2
                bpl.s   loc_14062
                cmp.w   $38(a2),d3
                bmi.s   loc_14062
                ori.b   #$90,$22(a2)
loc_14062:                                              ; CODE XREF: Sprite_SetBossOAMEntry+3C   j
                                        ; Sprite_SetBossOAMEntry+42   j
                dbf     d7,loc_14042
loc_14066:                                              ; CODE XREF: Sprite_SetBossOAMEntry+32   j
                movea.w #(word_FFC5C0-M68K_RAM),a3
                movea.w #(byte_FF8E00-M68K_RAM),a4
                moveq   #4,d5
                move.w  (word_FF8D78).w,d7
                bmi.w   locret_140A0
loc_14078:                                              ; CODE XREF: Sprite_SetBossOAMEntry:loc_1409C   j
                movea.w (a4)+,a2
                cmp.w   $34(a2),d1
                bmi.s   loc_1409C
                cmp.w   $36(a2),d0
                bpl.s   loc_1409C
                cmp.w   $32(a2),d2
                bpl.s   loc_1409C
                cmp.w   $30(a2),d3
                bmi.s   loc_1409C
                btst    d5,$21(a2)
                bne.s   loc_140A2
                beq.w   loc_1412A
loc_1409C:                                              ; CODE XREF: Sprite_SetBossOAMEntry+72   j
                                        ; Sprite_SetBossOAMEntry+78   j
                dbf     d7,loc_14078
locret_140A0:                                           ; CODE XREF: Sprite_SetBossOAMEntry+6   j
                                        ; Sprite_SetBossOAMEntry+E   j
                rts
; ---------------------------------------------------------------------------
loc_140A2:                                              ; CODE XREF: Sprite_SetBossOAMEntry+8A   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_140B0
                tst.w   (word_FF8200).w
                beq.s   loc_1409C
loc_140B0:                                              ; CODE XREF: Sprite_SetBossOAMEntry+9C   j
                bset    #7,$22(a3)
                btst    #1,(byte_FF80EC).w
                bne.s   loc_1409C
                btst    #4,$23(a2)
                bne.s   loc_1409C
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
                bpl.s   loc_1409C
                clr.w   (word_FF8200).w
                clr.w   (word_FF8202).w
                clr.b   (byte_FF80EC).w
                clr.w   (word_FF8234).w
                clr.w   (word_FF8236).w
                clr.b   (byte_FF8260).w
                bsr.w   UI_DecrementScoreBCD
                bra.w   loc_1409C
; ---------------------------------------------------------------------------
loc_1412A:                                              ; CODE XREF: Sprite_SetBossOAMEntry+8C   j
                tst.w   $24(a2)
                bmi.w   loc_1409C
                ori.b   #$10,$22(a2)
                ori.b   #$80,$22(a3)
                btst    #4,$23(a2)
                bne.w   loc_1409C
                ori.b   #$50,$22(a2)                    ; 'P'
                movem.l d0,-(sp)
                move.b  #$AE,d0
                jsr     (Sound_PlaySFX).l
                movem.l (sp)+,d0
                move.w  $26(a3),d4
                sub.w   d4,$24(a2)
                bpl.w   loc_1409C
                btst    #6,$23(a2)
                beq.s   loc_1417E
                subq.w  #1,(word_FF829E).w
                bpl.s   loc_1417E
                clr.w   (word_FF829E).w
loc_1417E:                                              ; CODE XREF: Sprite_SetBossOAMEntry+166   j
                                        ; Sprite_SetBossOAMEntry+16C   j
                btst    #7,$23(a2)
                bne.w   loc_1409C
                bsr.w   UI_DecrementScoreBCD
                bra.w   loc_1409C
; End of function Sprite_SetBossOAMEntry
; Detects player weapon projectile collision with enemies calculating damage
