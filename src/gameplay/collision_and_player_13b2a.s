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
                movea.w #(word_FFC620-M68K_RAM),a4
                moveq   #$3B,d7 ; ';'
loc_13B5E:                              ; CODE XREF: Enemy_BuildCollisionLists+120   j
                tst.w   (a4)
                beq.w   loc_13C46
                move.w  $10(a4),d0
                move.w  $14(a4),d1
                move.b  $21(a4),d6
                move.b  d6,d4
                andi.b  #$42,d4 ; 'B'
                beq.s   loc_13BD0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_13B88
                btst    #0,d7
                beq.s   loc_13BD0
                bra.s   loc_13B8E
; ---------------------------------------------------------------------------
loc_13B88:                              ; CODE XREF: Enemy_BuildCollisionLists+54   j
                btst    #0,d7
                bne.s   loc_13BD0
loc_13B8E:                              ; CODE XREF: Enemy_BuildCollisionLists+5C   j
                move.w  a4,(a0)+
                addq.w  #1,(word_FF8D76).w
                btst    #5,$23(a4)
                beq.s   loc_13BA0
                addq.w  #1,(word_FF8126).w
loc_13BA0:                              ; CODE XREF: Enemy_BuildCollisionLists+70   j
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
loc_13BD0:                              ; CODE XREF: Enemy_BuildCollisionLists+4C   j
                                        ; Enemy_BuildCollisionLists+5A   j ...
                move.b  d6,d4
                andi.b  #$90,d4
                beq.s   loc_13C1A
                move.w  a4,(a1)+
                addq.w  #1,(word_FF8D78).w
                btst    #4,d6
                beq.s   loc_13BEA
                move.w  a4,(a2)+
                addq.w  #1,(word_FF8D7A).w
loc_13BEA:                              ; CODE XREF: Enemy_BuildCollisionLists+B8   j
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
loc_13C1A:                              ; CODE XREF: Enemy_BuildCollisionLists+AC   j
                btst    #5,d6
                beq.s   loc_13C3A
                move.w  $48(a4),$4C(a4)
                move.w  $4A(a4),$4E(a4)
                move.w  d0,$48(a4)
                move.w  d1,$4A(a4)
                move.w  a4,(a3)+
                addq.w  #1,(word_FF8D7C).w
loc_13C3A:                              ; CODE XREF: Enemy_BuildCollisionLists+F4   j
                btst    #0,d6
                beq.s   loc_13C46
                move.w  a4,(a5)+
                addq.w  #1,(word_FF8D7E).w
loc_13C46:                              ; CODE XREF: Enemy_BuildCollisionLists+36   j
                                        ; Enemy_BuildCollisionLists+114   j
                lea     $60(a4),a4
                dbf     d7,loc_13B5E
                rts
; End of function Enemy_BuildCollisionLists
; Multi-point terrain tile collision check for multiple entities
Collision_CheckTerrainTiles:                              ; CODE XREF: Boss_UpdateCollisionSystem+1E   p  ; was: sub_13C50
                movea.l #$FFFF0000,a0
                movea.l #$FFFF7800,a1
                movea.w a5,a2
                moveq   #3,d6
                moveq   #4,d1
                move.w  (dword_FFA900).w,d4
                move.w  (dword_FFA904).w,d5
                subi.w  #$80,d4
                addi.w  #$80,d5
loc_13C72:                              ; CODE XREF: Collision_CheckTerrainTiles+74   j
                move.w  (a2),d7
                beq.w   loc_13CC0
                btst    #6,$21(a2)
                beq.s   loc_13CC0
                btst    #6,$23(a2)
                bne.s   loc_13CC0
                move.w  $10(a2),d2
                add.w   d4,d2
                asr.w   #2,d2
                andi.w  #$7E,d2 ; '~'
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
loc_13CC0:                              ; CODE XREF: Collision_CheckTerrainTiles+24   j
                                        ; Collision_CheckTerrainTiles+2E   j ...
                lea     $C0(a2),a2
                dbf     d6,loc_13C72
                rts
; End of function Collision_CheckTerrainTiles
; Detects collision between enemies and player
Enemy_DetectPlayerCollision:                              ; CODE XREF: Boss_UpdateCollisionSystem:loc_13AF8   p  ; was: sub_13CCA
                tst.w   (word_FF8D78).w
                bpl.s   loc_13CD2
                rts
; ---------------------------------------------------------------------------
loc_13CD2:                              ; CODE XREF: Enemy_DetectPlayerCollision+4   j
                moveq   #4,d5
                moveq   #3,d6
                movea.w a5,a3
loc_13CD8:                              ; CODE XREF: Enemy_DetectPlayerCollision+66   j
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
loc_13D04:                              ; CODE XREF: Enemy_DetectPlayerCollision:loc_13D28   j
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
loc_13D28:                              ; CODE XREF: Enemy_DetectPlayerCollision+40   j
                                        ; Enemy_DetectPlayerCollision+46   j ...
                dbf     d7,loc_13D04
loc_13D2C:                              ; CODE XREF: Enemy_DetectPlayerCollision+10   j
                                        ; Enemy_DetectPlayerCollision+1A   j ...
                lea     $C0(a3),a3
                dbf     d6,loc_13CD8
                rts
; ---------------------------------------------------------------------------
loc_13D36:                              ; CODE XREF: Enemy_DetectPlayerCollision+58   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_13D44
                tst.w   (word_FF8200).w
                beq.s   loc_13D28
loc_13D44:                              ; CODE XREF: Enemy_DetectPlayerCollision+72   j
                btst    #1,$23(a3)
                beq.s   loc_13D52
                cmpa.w  (word_FF801C).w,a2
                bne.s   loc_13D28
loc_13D52:                              ; CODE XREF: Enemy_DetectPlayerCollision+80   j
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
                jsr (Sound_PlaySFX).l
                bset    #3,(byte_FF80EC).w
loc_13D90:                              ; CODE XREF: Enemy_DetectPlayerCollision+B4   j
                bset    #0,(byte_FF80EC).w
                bset    #7,$22(a3)
                bset    #6,$22(a2)
                btst    #7,$23(a3)
                bne.s   loc_13DB2
                moveq   #$11,d0
                jsr (UI_AddScoreBCD).l
loc_13DB2:                              ; CODE XREF: Enemy_DetectPlayerCollision+DE   j
                move.w  $26(a3),d4
                move.w  #$FFFF,$26(a3)
                move.w  $24(a2),(word_FF8210).w
                move.w  #$20,(word_FF809A).w ; ' '
                mulu.w  $24(a2),d4
                sub.w   d4,(word_FF8200).w
                bpl.w   loc_13D2C
                clr.w   (word_FF8200).w
                clr.w   (word_FF8202).w
                clr.b   (byte_FF80EC).w
                clr.w   (word_FF8234).w
                clr.w   (word_FF8236).w
                clr.b   (byte_FF8260).w
                bsr.w UI_DecrementScoreBCD
                bra.w   loc_13D2C
; ---------------------------------------------------------------------------
loc_13DF4:                              ; CODE XREF: Enemy_DetectPlayerCollision+5A   j
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
                jsr (Sound_PlaySFX).l
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
loc_13E56:                              ; CODE XREF: Enemy_DetectPlayerCollision+180   j
                                        ; Enemy_DetectPlayerCollision+186   j
                btst    #7,$23(a2)
                bne.w   loc_13D2C
                bsr.w UI_DecrementScoreBCD
                bra.w   loc_13D2C
; ---------------------------------------------------------------------------
loc_13E68:                              ; CODE XREF: Enemy_DetectPlayerCollision+16E   j
                btst    #7,$23(a3)
                bne.w   loc_13D2C
                moveq   #$21,d0 ; '!'
                jsr (UI_AddScoreBCD).l
                bra.w   loc_13D2C
; ---------------------------------------------------------------------------
loc_13E7E:                              ; CODE XREF: Enemy_DetectPlayerCollision+8E   j
                                        ; Enemy_DetectPlayerCollision+98   j ...
                bclr    #6,$21(a3)
                move.b  #$50,$23(a3) ; 'P'
                bset    #3,$22(a2)
                bset    #0,$22(a2)
                bra.w   loc_13D2C
; End of function Enemy_DetectPlayerCollision
; Detects player projectile hits on enemies
Player_DetectProjectileHit:                              ; CODE XREF: Boss_UpdateCollisionSystem+22   p  ; was: sub_13E9A
                btst    #4,(byte_FF8245).w
                bne.w   locret_13F9A
                subq.b  #1,(byte_FF825D).w
                bpl.s   loc_13EB0
                move.b  #$FF,(byte_FF825D).w
loc_13EB0:                              ; CODE XREF: Player_DetectProjectileHit+E   j
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
loc_13EF4:                              ; CODE XREF: Player_DetectProjectileHit:loc_13F96   j
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
loc_13F26:                              ; CODE XREF: Player_DetectProjectileHit+82   j
                btst    #4,$23(a0)
                bne.s   loc_13F96
                bset    #7,$22(a2)
                move.b  $21(a2),d6
                btst    #6,d6
                beq.s   loc_13F6A
                move.b  $21(a2),d0
                andi.b  #$48,d0 ; 'H'
                or.b    d0,$22(a0)
                move.w  $26(a2),d4
                cmpi.w  #1,(word_FFA216).w
                bne.s   loc_13F5C
                clr.w   (word_FFA216).w
                bra.s   loc_13F9C
; ---------------------------------------------------------------------------
loc_13F5C:                              ; CODE XREF: Player_DetectProjectileHit+BA   j
                sub.w   d4,(word_FFA216).w
                bpl.s   loc_13F9C
                move.w  #1,(word_FFA216).w
                bra.s   loc_13F9C
; ---------------------------------------------------------------------------
loc_13F6A:                              ; CODE XREF: Player_DetectProjectileHit+A2   j
                btst    #1,d6
                beq.s   loc_13F96
                tst.b   (byte_FF825D).w
                bpl.s   loc_13F96
                btst    #0,$21(a0)
                bne.s   loc_13F84
                bclr    #1,d6
                bra.s   loc_13F96
; ---------------------------------------------------------------------------
loc_13F84:                              ; CODE XREF: Player_DetectProjectileHit+E2   j
                bclr    #0,$21(a0)
                bset    #1,$22(a0)
                bset    #1,$22(a2)
loc_13F96:                              ; CODE XREF: Player_DetectProjectileHit+60   j
                                        ; Player_DetectProjectileHit+68   j ...
                dbf     d7,loc_13EF4
locret_13F9A:                           ; CODE XREF: Player_DetectProjectileHit+6   j
                                        ; Player_DetectProjectileHit+22   j ...
                rts
; ---------------------------------------------------------------------------
loc_13F9C:                              ; CODE XREF: Player_DetectProjectileHit+C0   j
                                        ; Player_DetectProjectileHit+C6   j ...
                movea.w #(word_FFFF46-M68K_RAM),a3
                movea.w #(word_FF804A-M68K_RAM),a4
                move.w  #1,(word_FF8048).w
                sub.w   d1,d1
                abcd    -(a4),-(a3)
                abcd    -(a4),-(a3)
                bcc.s   loc_13FB8
                move.w  #$9999,(word_FFFF44).w
loc_13FB8:                              ; CODE XREF: Player_DetectProjectileHit+116   j
                move.l  $18(a2),(dword_FF8300).w
                move.w  d4,(word_FF8262).w
                ori.w   #$8000,(word_FF8262).w
                move.w  #$30,(word_FF8268).w ; '0'
                btst    #1,$21(a2)
                bne.s   locret_1400A
                move.w  #4,(word_FF813C).w
                move.w  #$10,d0
                move.w  #$3C,d1 ; '<'
                tst.w   (word_FFFF0E).w
                bne.s   loc_13FF2
                move.w  #$20,d0 ; ' '
                move.w  #$78,d1 ; 'x'
loc_13FF2:                              ; CODE XREF: Player_DetectProjectileHit+14E   j
                cmp.w   d4,d0
                bmi.s   loc_13FFC
                move.w  d0,$5E(a0)
                rts
; ---------------------------------------------------------------------------
loc_13FFC:                              ; CODE XREF: Player_DetectProjectileHit+15A   j
                cmp.w   d4,d1
                bpl.s   loc_14006
                move.w  d1,$5E(a0)
                rts
; ---------------------------------------------------------------------------
loc_14006:                              ; CODE XREF: Player_DetectProjectileHit+164   j
                move.w  d4,$5E(a0)
locret_1400A:                           ; CODE XREF: Player_DetectProjectileHit+13A   j
                rts
; End of function Player_DetectProjectileHit
; Sets OAM sprite entry for boss graphics
Sprite_SetBossOAMEntry:                              ; CODE XREF: Boss_UpdateCollisionSystem+26   p  ; was: sub_1400C
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
loc_14042:                              ; CODE XREF: Sprite_SetBossOAMEntry:loc_14062   j
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
loc_14062:                              ; CODE XREF: Sprite_SetBossOAMEntry+3C   j
                                        ; Sprite_SetBossOAMEntry+42   j ...
                dbf     d7,loc_14042
loc_14066:                              ; CODE XREF: Sprite_SetBossOAMEntry+32   j
                movea.w #(word_FFC5C0-M68K_RAM),a3
                movea.w #(byte_FF8E00-M68K_RAM),a4
                moveq   #4,d5
                move.w  (word_FF8D78).w,d7
                bmi.w   locret_140A0
loc_14078:                              ; CODE XREF: Sprite_SetBossOAMEntry:loc_1409C   j
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
loc_1409C:                              ; CODE XREF: Sprite_SetBossOAMEntry+72   j
                                        ; Sprite_SetBossOAMEntry+78   j ...
                dbf     d7,loc_14078
locret_140A0:                           ; CODE XREF: Sprite_SetBossOAMEntry+6   j
                                        ; Sprite_SetBossOAMEntry+E   j ...
                rts
; ---------------------------------------------------------------------------
loc_140A2:                              ; CODE XREF: Sprite_SetBossOAMEntry+8A   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_140B0
                tst.w   (word_FF8200).w
                beq.s   loc_1409C
loc_140B0:                              ; CODE XREF: Sprite_SetBossOAMEntry+9C   j
                bset    #7,$22(a3)
                btst    #1,(byte_FF80EC).w
                bne.s   loc_1409C
                btst    #4,$23(a2)
                bne.s   loc_1409C
                movem.l d0,-(sp)
                move.b  #$AE,d0
                jsr (Sound_PlaySFX).l
                movem.l (sp)+,d0
                move.b  $21(a3),d4
                or.b    d4,(byte_FF8308).w
                bset    #0,(byte_FF8308).w
                bset    #0,(byte_FF80EC).w
                or.b    d4,$22(a2)
                move.w  $26(a3),d4
                move.w  $24(a2),(word_FF8210).w
                move.w  #$20,(word_FF809A).w ; ' '
                mulu.w  $24(a2),d4
                sub.w   d4,(word_FF8200).w
                bpl.s   loc_1409C
                clr.w   (word_FF8200).w
                clr.w   (word_FF8202).w
                clr.b   (byte_FF80EC).w
                clr.w   (word_FF8234).w
                clr.w   (word_FF8236).w
                clr.b   (byte_FF8260).w
                bsr.w UI_DecrementScoreBCD
                bra.w   loc_1409C
; ---------------------------------------------------------------------------
loc_1412A:                              ; CODE XREF: Sprite_SetBossOAMEntry+8C   j
                tst.w   $24(a2)
                bmi.w   loc_1409C
                ori.b   #$10,$22(a2)
                ori.b   #$80,$22(a3)
                btst    #4,$23(a2)
                bne.w   loc_1409C
                ori.b   #$50,$22(a2) ; 'P'
                movem.l d0,-(sp)
                move.b  #$AE,d0
                jsr (Sound_PlaySFX).l
                movem.l (sp)+,d0
                move.w  $26(a3),d4
                sub.w   d4,$24(a2)
                bpl.w   loc_1409C
                btst    #6,$23(a2)
                beq.s   loc_1417E
                subq.w  #1,(word_FF829E).w
                bpl.s   loc_1417E
                clr.w   (word_FF829E).w
loc_1417E:                              ; CODE XREF: Sprite_SetBossOAMEntry+166   j
                                        ; Sprite_SetBossOAMEntry+16C   j
                btst    #7,$23(a2)
                bne.w   loc_1409C
                bsr.w UI_DecrementScoreBCD
                bra.w   loc_1409C
; End of function Sprite_SetBossOAMEntry
; Detects player weapon projectile collision with enemies calculating damage
Collision_PlayerWeaponVsEnemy:                              ; CODE XREF: Boss_UpdateCollisionSystem+2A   p  ; was: sub_14190
                movea.w #(byte_FF8F80-M68K_RAM),a5
                move.w  (word_FF8D7E).w,d7
                bmi.w   locret_141F0
                moveq   #4,d5
loc_1419E:                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+5C   j
                movea.w (a5)+,a3
                moveq   #$FFFFFFF8,d0
                add.w   $10(a3),d0
                moveq   #8,d1
                add.w   $10(a3),d1
                moveq   #$FFFFFFF8,d2
                add.w   $14(a3),d2
                moveq   #8,d3
                add.w   $14(a3),d3
                movea.w #(byte_FF8E00-M68K_RAM),a4
                move.w  (word_FF8D78).w,d6
                bmi.w   locret_141F0
loc_141C4:                              ; CODE XREF: Collision_PlayerWeaponVsEnemy:loc_141E8   j
                movea.w (a4)+,a2
                cmp.w   $34(a2),d1
                bmi.s   loc_141E8
                cmp.w   $36(a2),d0
                bpl.s   loc_141E8
                cmp.w   $32(a2),d2
                bpl.s   loc_141E8
                cmp.w   $30(a2),d3
                bmi.s   loc_141E8
                btst    d5,$21(a2)
                bne.s   loc_141F2
                beq.w   loc_14278
loc_141E8:                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+3A   j
                                        ; Collision_PlayerWeaponVsEnemy+40   j ...
                dbf     d6,loc_141C4
                dbf     d7,loc_1419E
locret_141F0:                           ; CODE XREF: Collision_PlayerWeaponVsEnemy+8   j
                                        ; Collision_PlayerWeaponVsEnemy+30   j
                rts
; ---------------------------------------------------------------------------
loc_141F2:                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+52   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_14202
                tst.w   (word_FF8200).w
                beq.w   loc_141E8
loc_14202:                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+68   j
                bset    #7,$22(a3)
                btst    #1,(byte_FF80EC).w
                bne.s   loc_141E8
                btst    #4,$23(a2)
                bne.s   loc_141E8
                movem.l d0,-(sp)
                move.b  #$AE,d0
                jsr (Sound_PlaySFX).l
                movem.l (sp)+,d0
                ori.b   #$40,(byte_FF8308).w ; '@'
                bset    #0,(byte_FF80EC).w
                move.b  $21(a3),d4
                or.b    d4,$22(a2)
                move.w  $26(a3),d4
                move.w  $24(a2),(word_FF8210).w
                move.w  #$20,(word_FF809A).w ; ' '
                mulu.w  $24(a2),d4
                sub.w   d4,(word_FF8200).w
                bpl.s   loc_141E8
                clr.w   (word_FF8200).w
                clr.w   (word_FF8202).w
                clr.b   (byte_FF80EC).w
                clr.w   (word_FF8234).w
                clr.w   (word_FF8236).w
                clr.b   (byte_FF8260).w
                bsr.w UI_DecrementScoreBCD
                bra.w   loc_141E8
; ---------------------------------------------------------------------------
loc_14278:                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+54   j
                tst.w   $24(a2)
                bmi.w   loc_141E8
                bset    #7,$22(a3)
                btst    #4,$23(a2)
                bne.w   loc_141E8
                ori.b   #$40,$22(a2) ; '@'
                movem.l d0,-(sp)
                move.b  #$AE,d0
                jsr (Sound_PlaySFX).l
                movem.l (sp)+,d0
                move.w  $26(a3),d4
                sub.w   d4,$24(a2)
                bpl.w   loc_141E8
                btst    #6,$23(a2)
                beq.s   loc_142C6
                subq.w  #1,(word_FF829E).w
                bpl.s   loc_142C6
                clr.w   (word_FF829E).w
loc_142C6:                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+12A   j
                                        ; Collision_PlayerWeaponVsEnemy+130   j
                btst    #7,$23(a2)
                bne.w   loc_141E8
                bsr.w UI_DecrementScoreBCD
                bra.w   loc_141E8
; End of function Collision_PlayerWeaponVsEnemy
; Loops through all active enemies checking collision with projectiles
Collision_CheckAllEnemies:                              ; CODE XREF: Player_ProcessAction+A   p  ; was: sub_142D8
                                        ; Player_UpdateTerrainCheck+A   p ...
                movea.w #(byte_FF8F00-M68K_RAM),a4
                move.w  (word_FF8D7C).w,d7
                bmi.s   locret_142EA
; Processes collision for each enemy in active list
Collision_ProcessEnemyLoop:                              ; CODE XREF: Collision_CheckAllEnemies+E   j  ; was: loc_142E2
                movea.w (a4)+,a2
                bsr.s Collision_ShipCollisionDispatcher
                dbf d7,Collision_ProcessEnemyLoop
locret_142EA:                           ; CODE XREF: Collision_CheckAllEnemies+8   j
                                        ; DATA XREF: ROM:off_142FC   o
                rts
; End of function Collision_CheckAllEnemies
; Dispatcher for ship collision types
Collision_ShipCollisionDispatcher:                              ; CODE XREF: Collision_CheckAllEnemies+C   p  ; was: sub_142EC
                move.w  $46(a2),d0
                movea.w off_142FC(pc,d0.w),a0
                adda.l  #Collision_PlayerShipCollision,a0
                jmp     (a0)
; End of function Collision_ShipCollisionDispatcher
; ---------------------------------------------------------------------------
off_142FC:      dc.w locret_142EA-Collision_PlayerShipCollision
                                        ; DATA XREF: Collision_ShipCollisionDispatcher+4   r
                dc.w Collision_PlayerShipCollision-Collision_PlayerShipCollision
                dc.w Enemy_Stage17Init-Collision_PlayerShipCollision
                dc.w Boss_ZLeoPlayerCollision-Collision_PlayerShipCollision


; Player collision with ship platform
Collision_PlayerShipCollision:                              ; DATA XREF: Collision_ShipCollisionDispatcher+8   o  ; was: sub_14304
                                        ; ROM:off_142FC   o ...
                tst.w   $1C(a5)
                bmi.w   locret_14384
                move.w  $28(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                addq.w  #8,d1
                cmp.w   d1,d0
                bpl.w   locret_14384
                move.w  $2A(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                subq.w  #8,d1
                cmp.w   d1,d0
                bmi.s   locret_14384
                move.w  $4A(a2),d0
                subq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #$26,d1 ; '&'
                cmp.w   d1,d0
                bpl.s   locret_14384
                move.w  $4A(a2),d0
                addq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #-$1A,d1
                cmp.w   d1,d0
                bmi.s   locret_14384
                clr.l   $1C(a5)
                bset    #0,6(a5)
                bset    #0,6(a2)
                move.w  $4C(a2),d5
                sub.w   $48(a2),d5
                neg.w   d5
                add.w   (dword_FFA910).w,d5
                add.w   d5,$10(a5)
                move.w  $4A(a2),d0
                subi.w  #$20,d0 ; ' '
                move.w  d0,$14(a5)
locret_14384:                           ; CODE XREF: Collision_PlayerShipCollision+4   j
                                        ; Collision_PlayerShipCollision+18   j ...
                rts
; End of function Collision_PlayerShipCollision
; Player collision handler
Boss_ZLeoPlayerCollision:                              ; DATA XREF: ROM:00014302   o  ; was: sub_14386
                move.w  $28(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                addq.w  #8,d1
                cmp.w   d1,d0
                bpl.w   locret_14414
                move.w  $2A(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                subq.w  #8,d1
                cmp.w   d1,d0
                bmi.s   locret_14414
                move.w  $4A(a2),d0
                subq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #$26,d1 ; '&'
                cmp.w   d1,d0
                bpl.s   locret_14414
                move.w  $4A(a2),d0
                addq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #-$1A,d1
                cmp.w   d1,d0
                bmi.s   locret_14414
                tst.w   $1C(a5)
                bpl.s   loc_143EA
                move.w  $4A(a2),d0
                subi.w  #$20,d0 ; ' '
                cmp.w   $14(a5),d0
                bpl.s   locret_14414
                move.w  d0,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_143EA:                              ; CODE XREF: Boss_ZLeoPlayerCollision+4E   j
                move.w  $4A(a2),d0
                subi.w  #$20,d0 ; ' '
                move.w  d0,$14(a5)
                clr.l   $1C(a5)
                bset    #0,6(a5)
                bset    #0,6(a2)
                move.w  $4C(a2),d5
                sub.w   $48(a2),d5
                neg.w   d5
                add.w   d5,$10(a5)
locret_14414:                           ; CODE XREF: Boss_ZLeoPlayerCollision+10   j
                                        ; Boss_ZLeoPlayerCollision+24   j ...
                rts
; End of function Boss_ZLeoPlayerCollision
; Initializes Stage 17 enemies
Enemy_Stage17Init:                              ; DATA XREF: ROM:00014300   o  ; was: sub_14416
                clr.w   6(a2)
                tst.l   $1C(a5)
                beq.s   loc_14424
                bpl.w   locret_144A4
loc_14424:                              ; CODE XREF: Enemy_Stage17Init+8   j
                move.w  $28(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                addq.w  #8,d1
                cmp.w   d1,d0
                bpl.w   locret_144A4
                move.w  $2A(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                subq.w  #8,d1
                cmp.w   d1,d0
                bmi.s   locret_144A4
                move.w  $4A(a2),d0
                subq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #$26,d1 ; '&'
                cmp.w   d1,d0
                bpl.s   locret_144A4
                btst    #4,$E(a5)
                bne.s   loc_14476
                move.w  $4A(a2),d0
                addq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #-$1A,d1
                cmp.w   d1,d0
                bmi.s   locret_144A4
loc_14476:                              ; CODE XREF: Enemy_Stage17Init+4C   j
                clr.l   $1C(a5)
                bset    #1,6(a5)
                bset    #1,6(a2)
                move.w  $4C(a2),d5
                sub.w   $48(a2),d5
                neg.w   d5
                add.w   (dword_FFA910).w,d5
                add.w   d5,$10(a5)
                move.w  $4A(a2),d0
                addi.w  #$20,d0 ; ' '
                move.w  d0,$14(a5)
locret_144A4:                           ; CODE XREF: Enemy_Stage17Init+A   j
                                        ; Enemy_Stage17Init+1E   j ...
                rts
; End of function Enemy_Stage17Init
; Decrements score value using BCD arithmetic for display
UI_DecrementScoreBCD:                              ; CODE XREF: Enemy_DetectPlayerCollision+122   p  ; was: sub_144A6
                                        ; Enemy_DetectPlayerCollision+196   p ...
                movem.l d1/a3-a4,-(sp)
                movea.w #(word_FFFF44-M68K_RAM),a3
                movea.w #(word_FF804A-M68K_RAM),a4
                move.w  #1,(word_FF8048).w
                sub.w   d1,d1
                abcd    -(a4),-(a3)
                abcd    -(a4),-(a3)
                bcc.s   loc_144C6
                move.w  #$9999,(word_FFFF42).w
loc_144C6:                              ; CODE XREF: UI_DecrementScoreBCD+18   j
                movem.l (sp)+,d1/a3-a4
                rts
; End of function UI_DecrementScoreBCD
; Gets entity position coordinates for collision detection
Collision_GetEntityPosition:                              ; CODE XREF: Enemy_BouncingProjectile:loc_2B5C0   p  ; was: sub_144CC
                                        ; sub_2B88A:loc_2B8AA   p ...
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                bra.s Collision_CheckTerrainTile
; End of function Collision_GetEntityPosition
; Checks if entity Y is within screen
Collision_CheckScreenBounds:
                add.w   $10(a5),d0  ; was: sub_144D6
                add.w   $14(a5),d1
                cmpi.w  #$A0,d1
                bpl.s Collision_CheckTerrainTile
                moveq   #0,d2
                moveq   #0,d3
                rts
; End of function Collision_CheckScreenBounds
; Adds offset to entity position for collision coordinate calculation
Physics_AddEntityOffset:                              ; CODE XREF: UI_DebugSpritePositionEditor+50   p  ; was: sub_144EA
                                        ; UI_DebugSpritePositionEditor+68   p ...
                add.w   $10(a5),d0
                add.w   $14(a5),d1
; End of function Physics_AddEntityOffset
; Checks collision with terrain by reading tilemap and height data
Collision_CheckTerrainTile:                              ; CODE XREF: Collision_GetEntityPosition+8   j  ; was: sub_144F2
                                        ; Collision_CheckScreenBounds+C   j ...
                movea.l #$FFFF0000,a0
                movea.l #$FFFF7800,a1
                move.w  d0,d2
                subi.w  #$80,d2
                add.w   (dword_FFA900).w,d2
                asr.w   #2,d2
                andi.w  #$7E,d2 ; '~'
                move.w  d1,d3
                subi.w  #$80,d3
                sub.w   (dword_FFA904).w,d3
                asl.w   #4,d3
                andi.w  #$1F80,d3
                add.w   d3,d2
                move.w  (a0,d2.w),d2
                move.w  d2,d3
                andi.w  #$7FF,d2
                move.b  (a1,d2.w),d2
                andi.w  #$FE,d2
                rts
; End of function Collision_CheckTerrainTile
; Aligns entity Y position to terrain surface clearing velocity
Physics_AlignToTerrain:                              ; CODE XREF: Player_InitHardLanding   p  ; was: sub_14534
                                        ; Enemy_UpdateTrajectory+52   p ...
                move.w  d1,d4
                sub.w   (dword_FFA904).w,d4
                andi.w  #7,d4
                sub.w   d4,$14(a5)
                clr.l   $1C(a5)
                rts
; End of function Physics_AlignToTerrain
; Aligns entity to terrain surface from above
Physics_AlignToTerrainTop:                              ; CODE XREF: Enemy_UpdateTrajectory+66   p  ; was: sub_14548
                move.w  d1,d4
                sub.w   (dword_FFA904).w,d4
                neg.w   d4
                subq.w  #1,d4
                andi.w  #7,d4
                add.w   d4,$14(a5)
                clr.l   $1C(a5)
                rts
; End of function Physics_AlignToTerrainTop
; Aligns entity horizontally to wall
Physics_AlignToWallSurface:
                tst.w   $18(a5)  ; was: sub_14560
                bmi.s   loc_14576
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #7,d4
                sub.w   d4,$10(a5)
                rts
; ---------------------------------------------------------------------------
loc_14576:                              ; CODE XREF: Physics_AlignToWallSurface+4   j
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                neg.w   d4
                subq.w  #1,d4
                andi.w  #7,d4
                add.w   d4,$10(a5)
                rts
; End of function Physics_AlignToWallSurface
; Initializes collision buffer pointers
Collision_InitBufferPointers:                              ; CODE XREF: Enemy_UpdateTrajectory:loc_2D0D6   p  ; was: sub_1458A
                                        ; Projectile_BouncingDebrisMain+22   p ...
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
; End of function Collision_InitBufferPointers
; Gets terrain tile data at specified position with screen offset
Physics_GetTerrainTileData:                              ; CODE XREF: Physics_EntityWallCheck+14   p  ; was: sub_1459A
                                        ; Physics_EntityWallCheck+2C   p ...
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                cmpi.w  #$A0,d1
                bpl.s   loc_145AE
                moveq   #0,d2
                moveq   #0,d3
                rts
; ---------------------------------------------------------------------------
loc_145AE:                              ; CODE XREF: Physics_GetTerrainTileData+C   j
                move.w  d0,d2
                sub.w   d7,d2
                add.w   (dword_FFA900).w,d2
                asr.w   #2,d2
                andi.w  #$7E,d2 ; '~'
                move.w  d1,d3
                sub.w   d7,d3
                sub.w   (dword_FFA904).w,d3
                asl.w   #4,d3
                andi.w  #$1F80,d3
                add.w   d3,d2
                move.w  (a0,d2.w),d2
                move.w  d2,d3
                andi.w  #$7FF,d2
                move.b  (a1,d2.w),d2
                andi.w  #$FE,d2
                beq.s   locret_145F2
                btst    #$B,d3
                beq.s   loc_145E8
                addq.w  #8,d2
loc_145E8:                              ; CODE XREF: Physics_GetTerrainTileData+4A   j
                btst    #$C,d3
                beq.s   locret_145F2
                addi.w  #$40,d2 ; '@'
locret_145F2:                           ; CODE XREF: Physics_GetTerrainTileData+44   j
                                        ; Physics_GetTerrainTileData+52   j
                rts
; End of function Physics_GetTerrainTileData
; Checks projectile collision with terrain tile map
Collision_CheckProjectileTile:                              ; CODE XREF: Enemy_HomingProjectileMain:loc_2B30E   p  ; was: sub_145F4
                                        ; sub_2B3E4:loc_2B45A   p
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  d0,d2
                subi.w  #$80,d2
                add.w   (dword_FFA900).w,d2
                asr.w   #2,d2
                andi.w  #$7E,d2 ; '~'
                move.w  d1,d3
                subi.w  #$80,d3
                sub.w   (dword_FFA904).w,d3
                asl.w   #4,d3
                andi.w  #$1F80,d3
                add.w   d3,d2
                move.w  (a0,d2.w),d2
                move.w  d2,d3
                andi.w  #$7FF,d2
                move.b  (a1,d2.w),d2
                andi.w  #$FE,d2
                beq.s   locret_14646
                cmpi.w  #$80,d2
                bpl.s   locret_14646
                moveq   #0,d2
locret_14646:                           ; CODE XREF: Collision_CheckProjectileTile+48   j
                                        ; Collision_CheckProjectileTile+4E   j
                rts
; End of function Collision_CheckProjectileTile
; Entity wall collision detection checking left and right sides
Physics_EntityWallCheck:                              ; CODE XREF: Physics_EntityTerrainWrapper+A   j  ; was: sub_14648
                                        ; sub_2CC34:loc_2CC54   p ...
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #0,d1
                bsr.w Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   loc_14670
                bset    #2,7(a5)
                bsr.w Physics_HandleWallCollision
loc_14670:                              ; CODE XREF: Physics_EntityWallCheck+1C   j
                moveq   #8,d0
                moveq   #0,d1
                bsr.w Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   locret_14688
                bset    #3,7(a5)
                bsr.w Sprite_UpdateBossAnimation
locret_14688:                           ; CODE XREF: Physics_EntityWallCheck+34   j
                rts
; End of function Physics_EntityWallCheck
; Multi-point terrain collision check for boss with wall detection
Physics_BossTerrainCheck:                              ; CODE XREF: Physics_BossTerrainWrapper+A   j  ; was: sub_1468A
                                        ; sub_2C71E:loc_2C850   p ...
                moveq   #$18,d6
                tst.w   $1C(a5)
                bmi.s   loc_14694
                moveq   #$FFFFFFE8,d6
loc_14694:                              ; CODE XREF: Physics_BossTerrainCheck+6   j
                                        ; Player_TerrainCheckFlipped+12   j ...
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #0,d1
                bsr.w Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   loc_146BE
                bset    #2,7(a5)
                bsr.w Physics_HandleWallCollision
                bra.s   loc_146D0
; ---------------------------------------------------------------------------
loc_146BE:                              ; CODE XREF: Physics_BossTerrainCheck+26   j
                moveq   #$FFFFFFF8,d0
                move.w  d6,d1
                bsr.w Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   loc_146D0
                bsr.w Physics_HandleWallCollision
loc_146D0:                              ; CODE XREF: Physics_BossTerrainCheck+32   j
                                        ; Physics_BossTerrainCheck+40   j
                moveq   #8,d0
                moveq   #0,d1
                bsr.w Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   loc_146E8
                bset    #3,7(a5)
                bra.w Sprite_UpdateBossAnimation
; ---------------------------------------------------------------------------
loc_146E8:                              ; CODE XREF: Physics_BossTerrainCheck+52   j
                moveq   #8,d0
                move.w  d6,d1
                bsr.w Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   locret_146FA
                bra.w Sprite_UpdateBossAnimation
; ---------------------------------------------------------------------------
locret_146FA:                           ; CODE XREF: Physics_BossTerrainCheck+6A   j
                rts
; End of function Physics_BossTerrainCheck
; Dispatches player action handlers
Player_ActionDispatcher:                              ; CODE XREF: Player_ProcessAction+10   j  ; was: sub_146FC
                                        ; Player_DirectionDispatcher+16   j ...
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #$18,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1471E
                bsr.w Physics_ProcessTerrainAngle
                bra.s   loc_1472E
; ---------------------------------------------------------------------------
loc_1471E:                              ; CODE XREF: Player_ActionDispatcher+1A   j
                moveq   #8,d0
                moveq   #$18,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1472E
                bsr.w Player_TerrainAngleDispatcher
loc_1472E:                              ; CODE XREF: Player_ActionDispatcher+20   j
                                        ; Player_ActionDispatcher+2C   j
                moveq   #0,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1473E
                bra.w Player_HandleCollision
; ---------------------------------------------------------------------------
loc_1473E:                              ; CODE XREF: Player_ActionDispatcher+3C   j
                moveq   #$FFFFFFF8,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1474E
                bra.w Player_HandleFloorCollision
; ---------------------------------------------------------------------------
loc_1474E:                              ; CODE XREF: Player_ActionDispatcher+4C   j
                moveq   #8,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   locret_1475E
                bra.w Physics_HandleFloorCollision
; ---------------------------------------------------------------------------
locret_1475E:                           ; CODE XREF: Player_ActionDispatcher+5C   j
                rts
; End of function Player_ActionDispatcher
; Checks player collision with terrain
Player_CheckTerrainCollision:                              ; CODE XREF: Player_UpdateTerrainCheck+10   j  ; was: sub_14760
                                        ; Enemy_MainStateMachine+13E   p ...
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #$18,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14782
                bsr.w Physics_ProcessTerrainAngle
                bra.s   loc_14792
; ---------------------------------------------------------------------------
loc_14782:                              ; CODE XREF: Player_CheckTerrainCollision+1A   j
                moveq   #8,d0
                moveq   #$18,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14792
                bsr.w Player_TerrainAngleDispatcher
loc_14792:                              ; CODE XREF: Player_CheckTerrainCollision+20   j
                                        ; Player_CheckTerrainCollision+2C   j
                moveq   #0,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_147A8
                tst.w   $1C(a5)
                bmi.s   locret_147D4
                bra.w Player_HandleCollision
; ---------------------------------------------------------------------------
loc_147A8:                              ; CODE XREF: Player_CheckTerrainCollision+3C   j
                moveq   #$FFFFFFF8,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_147BE
                tst.w   $1C(a5)
                bmi.s   locret_147D4
                bra.w Player_HandleFloorCollision
; ---------------------------------------------------------------------------
loc_147BE:                              ; CODE XREF: Player_CheckTerrainCollision+52   j
                moveq   #8,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   locret_147D4
                tst.w   $1C(a5)
                bmi.s   locret_147D4
                bra.w Physics_HandleFloorCollision
; ---------------------------------------------------------------------------
locret_147D4:                           ; CODE XREF: Player_CheckTerrainCollision+42   j
                                        ; Player_CheckTerrainCollision+58   j ...
                rts
; End of function Player_CheckTerrainCollision
; Performs terrain collision checks at multiple points
Physics_MultiPointTerrainCheck:                              ; CODE XREF: Player_TerrainCheckStandard+10   j  ; was: sub_147D6
                                        ; Player_DirectionDispatcher+1A   j
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #$FFFFFFE8,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_147F8
                bsr.w Physics_UpdateVelocity
                bra.s   loc_14808
; ---------------------------------------------------------------------------
loc_147F8:                              ; CODE XREF: Physics_MultiPointTerrainCheck+1A   j
                moveq   #8,d0
                moveq   #$FFFFFFE8,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14808
                bsr.w Physics_CheckAngleRange
loc_14808:                              ; CODE XREF: Physics_MultiPointTerrainCheck+20   j
                                        ; Physics_MultiPointTerrainCheck+2C   j
                moveq   #0,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14818
                bra.w Physics_HandleCeilingCollision
; ---------------------------------------------------------------------------
loc_14818:                              ; CODE XREF: Physics_MultiPointTerrainCheck+3C   j
                moveq   #$FFFFFFF8,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14828
                bra.w Physics_ApplyAcceleration
; ---------------------------------------------------------------------------
loc_14828:                              ; CODE XREF: Physics_MultiPointTerrainCheck+4C   j
                moveq   #8,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   locret_14838
                bra.w Physics_DispatchSlopeHandler
; ---------------------------------------------------------------------------
locret_14838:                           ; CODE XREF: Physics_MultiPointTerrainCheck+5C   j
                rts
; End of function Physics_MultiPointTerrainCheck
; Terrain collision check with vertical velocity validation
Physics_TerrainCheckWithVelocity:                              ; CODE XREF: Player_TerrainCheckAlternate+10   j  ; was: sub_1483A
                                        ; sub_2C71E:loc_2C86E   j ...
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #$FFFFFFE8,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1485C
                bsr.w Physics_UpdateVelocity
                bra.s   loc_1486C
; ---------------------------------------------------------------------------
loc_1485C:                              ; CODE XREF: Physics_TerrainCheckWithVelocity+1A   j
                moveq   #8,d0
                moveq   #$FFFFFFE8,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1486C
                bsr.w Physics_CheckAngleRange
loc_1486C:                              ; CODE XREF: Physics_TerrainCheckWithVelocity+20   j
                                        ; Physics_TerrainCheckWithVelocity+2C   j
                moveq   #0,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14882
                tst.w   $1C(a5)
                bpl.s   locret_148AE
                bra.w Physics_HandleCeilingCollision
; ---------------------------------------------------------------------------
loc_14882:                              ; CODE XREF: Physics_TerrainCheckWithVelocity+3C   j
                moveq   #$FFFFFFF8,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14898
                tst.w   $1C(a5)
                bpl.s   locret_148AE
                bra.w Physics_ApplyAcceleration
; ---------------------------------------------------------------------------
loc_14898:                              ; CODE XREF: Physics_TerrainCheckWithVelocity+52   j
                moveq   #8,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   locret_148AE
                tst.w   $1C(a5)
                bpl.s   locret_148AE
                bra.w Physics_DispatchSlopeHandler
; ---------------------------------------------------------------------------
locret_148AE:                           ; CODE XREF: Physics_TerrainCheckWithVelocity+42   j
                                        ; Physics_TerrainCheckWithVelocity+58   j ...
                rts
; End of function Physics_TerrainCheckWithVelocity
; Handles player collision states
Player_HandleCollision:                              ; CODE XREF: Player_ActionDispatcher+3E   j  ; was: sub_148B0
                                        ; Player_CheckTerrainCollision+44   j
                bset    #0,6(a5)
                cmpi.w  #$80,d2
                bpl.s Physics_DispatchTerrainHandler
                bset    #2,6(a5)
; Dispatches to appropriate terrain angle handler based on tile type
Physics_DispatchTerrainHandler:                              ; CODE XREF: Player_HandleCollision+A   j  ; was: loc_148C2
                andi.w  #$7E,d2 ; '~'
                cmpi.w  #$40,d2 ; '@'
                bpl.w Player_SnapToFloor
                movea.w off_148DA(pc,d2.w),a4
                adda.l  #Physics_ProcessTerrainAngle,a4
                jmp     (a4)
; End of function Player_HandleCollision
; ---------------------------------------------------------------------------
off_148DA:      dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                                        ; DATA XREF: Player_HandleCollision+1E   r
                dc.w Player_SnapToFloor-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Player_SnapToFloor-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareFloorOffset8-Physics_ProcessTerrainAngle
                dc.w Physics_CalculateFloorOffset4-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset-Physics_ProcessTerrainAngle
                dc.w Physics_SnapToFloorNoOffset-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset8-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset6-Physics_ProcessTerrainAngle
                dc.w Physics_ApplyFloorOffset4-Physics_ProcessTerrainAngle
                dc.w Boss_DestroyerMK2BattleStart-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset5-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset3-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset1-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareOffsetNeg-Physics_ProcessTerrainAngle


; Processes terrain collision based on surface angle
Physics_ProcessTerrainAngle:                              ; CODE XREF: Player_ActionDispatcher+1C   p  ; was: sub_1490A
                                        ; Player_CheckTerrainCollision+1C   p
                                        ; DATA XREF: ...
                cmpi.w  #$10,d2
                bmi.w Physics_TerrainEmptyHandler
                cmpi.w  #$C0,d2
                bpl.w Physics_HandleWallCollision
                move.w  d2,d3
                andi.w  #$7E,d2 ; '~'
                cmpi.w  #$40,d2 ; '@'
                bpl.w Physics_TerrainEmptyHandler
                cmpi.w  #$10,d2
                bmi.s Physics_DispatchAngleHandler
                bset    #0,6(a5)
                cmpi.w  #$80,d3
                bpl.s Physics_DispatchAngleHandler
                bset    #2,6(a5)
; Dispatches to terrain angle calculation handler
Physics_DispatchAngleHandler:                              ; CODE XREF: Physics_ProcessTerrainAngle+22   j  ; was: loc_14940
                                        ; Physics_ProcessTerrainAngle+2E   j
                movea.w off_1494C(pc,d2.w),a4
                adda.l  #Player_TerrainAngleDispatcher,a4
                jmp     (a4)
; End of function Physics_ProcessTerrainAngle
; ---------------------------------------------------------------------------
off_1494C:      dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                                        ; DATA XREF: Physics_ProcessTerrainAngle:loc_14940   r
                dc.w Physics_HandleWallCollision-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_HandleWallCollision-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_SnapFloorMinus12-Player_TerrainAngleDispatcher
                dc.w Physics_CalcFloorMinus12-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_PrepareVertical4Down-Player_TerrainAngleDispatcher
                dc.w Physics_SnapAndSubtract4-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_Prepare8Sub10-Player_TerrainAngleDispatcher
                dc.w Physics_Prepare6Sub10-Player_TerrainAngleDispatcher
                dc.w Physics_Apply4Sub10-Player_TerrainAngleDispatcher
                dc.w Boss_DestroyerMK2EntryMove-Player_TerrainAngleDispatcher
                dc.w Physics_ApplyOffset6Down-Player_TerrainAngleDispatcher
                dc.w Physics_ApplyOffset3Down6-Player_TerrainAngleDispatcher
                dc.w Physics_ApplyOffset1Down6-Player_TerrainAngleDispatcher
                dc.w Physics_ApplyOffsetNegDown6-Player_TerrainAngleDispatcher


; Dispatches player terrain collision handler based on angle range
Player_TerrainAngleDispatcher:                              ; CODE XREF: Player_ActionDispatcher+2E   p  ; was: sub_1497C
                                        ; Player_CheckTerrainCollision+2E   p
                                        ; DATA XREF: ...
                cmpi.w  #$10,d2
                bmi.w Physics_TerrainEmptyHandler
                cmpi.w  #$C0,d2
                bpl.w Sprite_UpdateBossAnimation
                move.w  d2,d3
                andi.w  #$7E,d2 ; '~'
                cmpi.w  #$40,d2 ; '@'
                bpl.w Physics_TerrainEmptyHandler
                cmpi.w  #$10,d2
                bmi.s Physics_DispatchFloorHandler
                bset    #0,6(a5)
                cmpi.w  #$80,d3
                bpl.s Physics_DispatchFloorHandler
                bset    #2,6(a5)
; Dispatches to floor collision handler based on tile type
Physics_DispatchFloorHandler:                              ; CODE XREF: Player_TerrainAngleDispatcher+22   j  ; was: loc_149B2
                                        ; Player_TerrainAngleDispatcher+2E   j
                movea.w off_149BE(pc,d2.w),a4
                adda.l  #Player_HandleFloorCollision,a4
                jmp     (a4)
; End of function Player_TerrainAngleDispatcher
; ---------------------------------------------------------------------------
off_149BE:      dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                                        ; DATA XREF: Player_TerrainAngleDispatcher:loc_149B2   r
                dc.w Sprite_UpdateBossAnimation-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Sprite_UpdateBossAnimation-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_SnapFloorMinus4-Player_HandleFloorCollision
                dc.w Physics_CalcFloorOffsetSubtract4-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_PrepareVertical12Down-Player_HandleFloorCollision
                dc.w Physics_SnapFloorSub12-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_Prepare8Sub6-Player_HandleFloorCollision
                dc.w Physics_Prepare6Sub6-Player_HandleFloorCollision
                dc.w Physics_Apply4Sub6-Player_HandleFloorCollision
                dc.w Boss_DestroyerMK2Sub6-Player_HandleFloorCollision
                dc.w Physics_ApplyOffset10Down-Player_HandleFloorCollision
                dc.w Physics_ApplyOffset3Down10-Player_HandleFloorCollision
                dc.w Physics_ApplyOffset1Down10-Player_HandleFloorCollision
                dc.w Physics_ApplyOffsetNegDown10-Player_HandleFloorCollision


; Handles player collision with floor
Player_HandleFloorCollision:                              ; CODE XREF: Player_ActionDispatcher+4E   j  ; was: sub_149EE
                                        ; Player_CheckTerrainCollision+5A   j
                                        ; DATA XREF: ...
                bset    #0,6(a5)
                cmpi.w  #$80,d2
                bpl.s Physics_ProcessFloorTile
                bset    #2,6(a5)
; Processes floor tile collision and dispatches to angle handler
Physics_ProcessFloorTile:                              ; CODE XREF: Player_HandleFloorCollision+A   j  ; was: loc_14A00
                andi.w  #$7E,d2 ; '~'
                cmpi.w  #$40,d2 ; '@'
                bpl.w Player_SnapToFloor
                movea.w off_14A18(pc,d2.w),a4
                adda.l  #Physics_HandleFloorCollision,a4
                jmp     (a4)
; End of function Player_HandleFloorCollision
; ---------------------------------------------------------------------------
off_14A18:      dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                                        ; DATA XREF: Player_HandleFloorCollision+1E   r
                dc.w Player_SnapToFloor-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Player_SnapToFloor-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_SnapFloorMinus4-Physics_HandleFloorCollision
                dc.w Physics_CalcFloorOffsetSubtract4-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_ApplyVerticalOffset4-Physics_HandleFloorCollision
                dc.w Physics_SnapFloorAdd4-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_Prepare8Sub2-Physics_HandleFloorCollision
                dc.w Physics_Prepare6Sub2-Physics_HandleFloorCollision
                dc.w Physics_Apply4Sub2-Physics_HandleFloorCollision
                dc.w Boss_DestroyerMK2Sub2-Physics_HandleFloorCollision
                dc.w Physics_ApplyOffset5Up-Physics_HandleFloorCollision
                dc.w Physics_ApplyOffset3Up-Physics_HandleFloorCollision
                dc.w Physics_ApplyOffset1Up-Physics_HandleFloorCollision
                dc.w Physics_ApplyOffsetNegUp-Physics_HandleFloorCollision


; Handles floor collision and sets ground state
Physics_HandleFloorCollision:                              ; CODE XREF: Player_ActionDispatcher+5E   j  ; was: sub_14A48
                                        ; Player_CheckTerrainCollision+70   j
                                        ; DATA XREF: ...
                bset    #0,6(a5)
                cmpi.w  #$80,d2
                bpl.s Physics_ProcessCeilingTile
                bset    #2,6(a5)
; Processes ceiling tile collision and dispatches to angle handler
Physics_ProcessCeilingTile:                              ; CODE XREF: Physics_HandleFloorCollision+A   j  ; was: loc_14A5A
                andi.w  #$7E,d2 ; '~'
                cmpi.w  #$40,d2 ; '@'
                bpl.w Player_SnapToFloor
                movea.w off_14A72(pc,d2.w),a4
                adda.l  #Physics_HandleCeilingCollision,a4
                jmp     (a4)
; End of function Physics_HandleFloorCollision
; ---------------------------------------------------------------------------
off_14A72:      dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                                        ; DATA XREF: Physics_HandleFloorCollision+1E   r
                dc.w Player_SnapToFloor-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Player_SnapToFloor-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_SnapAndAdd4-Physics_HandleCeilingCollision
                dc.w Boss_DestroyerMK2EntryInit-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_PrepareVertical4Down-Physics_HandleCeilingCollision
                dc.w Physics_SnapAndSubtract4-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_SnapAndAdd2-Physics_HandleCeilingCollision
                dc.w Physics_Prepare6Add2-Physics_HandleCeilingCollision
                dc.w Physics_Apply4Add2-Physics_HandleCeilingCollision
                dc.w Boss_DestroyerMK2EntryStop-Physics_HandleCeilingCollision
                dc.w Physics_ApplyOffset5Down-Physics_HandleCeilingCollision
                dc.w Physics_ApplyOffset3Down-Physics_HandleCeilingCollision
                dc.w Physics_ApplyOffset1Down-Physics_HandleCeilingCollision
                dc.w Physics_ApplyOffsetNegDown-Physics_HandleCeilingCollision


; Handles ceiling collision based on angle
Physics_HandleCeilingCollision:                              ; CODE XREF: Physics_MultiPointTerrainCheck+3E   j  ; was: sub_14AA2
                                        ; Physics_TerrainCheckWithVelocity+44   j
                                        ; DATA XREF: ...
                cmpi.w  #$80,d2
                bmi.w Physics_SetSolidTerrainFlag
                bset    #1,6(a5)
                andi.w  #$7E,d2 ; '~'
                subi.w  #$40,d2 ; '@'
                bmi.w Physics_SnapToSurface
                movea.w off_14AC8(pc,d2.w),a4
                adda.l  #Physics_UpdateVelocity,a4
                jmp     (a4)
; End of function Physics_HandleCeilingCollision
; ---------------------------------------------------------------------------
off_14AC8:      dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                                        ; DATA XREF: Physics_HandleCeilingCollision+1A   r
                dc.w Physics_SnapToSurface-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_SnapToSurface-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_SnapToFloorNoOffset-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_CalculateFloorOffset4-Physics_UpdateVelocity
                dc.w Physics_PrepareFloorOffset8-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_PrepareOffsetNeg-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset1-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset3-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset5-Physics_UpdateVelocity
                dc.w Boss_DestroyerMK2BattleStart-Physics_UpdateVelocity
                dc.w Physics_ApplyFloorOffset4-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset6-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset8-Physics_UpdateVelocity


; Updates entity velocity with acceleration application
Physics_UpdateVelocity:                              ; CODE XREF: Physics_MultiPointTerrainCheck+1C   p  ; was: sub_14AF8
                                        ; Physics_TerrainCheckWithVelocity+1C   p
                                        ; DATA XREF: ...
                cmpi.w  #$80,d2
                bmi.s   loc_14B06
                cmpi.w  #$C0,d2
                bmi.w Physics_HandleWallCollision
loc_14B06:                              ; CODE XREF: Physics_UpdateVelocity+4   j
                andi.w  #$7E,d2 ; '~'
                subi.w  #$40,d2 ; '@'
                bmi.w Physics_TerrainEmptyHandler
                cmpi.w  #$10,d2
                bmi.s   loc_14B1E
                bset    #1,6(a5)
loc_14B1E:                              ; CODE XREF: Physics_UpdateVelocity+1E   j
                movea.w off_14B2A(pc,d2.w),a4
                adda.l  #Physics_CheckAngleRange,a4
                jmp     (a4)
; End of function Physics_UpdateVelocity
; ---------------------------------------------------------------------------
off_14B2A:      dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                                        ; DATA XREF: Physics_UpdateVelocity:loc_14B1E   r
                dc.w Physics_HandleWallCollision-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_HandleWallCollision-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_SnapFloorAdd12-Physics_CheckAngleRange
                dc.w Physics_PrepareVertical12Up-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Boss_DestroyerMK2EntryInit-Physics_CheckAngleRange
                dc.w Physics_SnapAndAdd4-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange


; Checks angle range for terrain slope
Physics_CheckAngleRange:                              ; CODE XREF: Physics_MultiPointTerrainCheck+2E   p  ; was: sub_14B5A
                                        ; Physics_TerrainCheckWithVelocity+2E   p
                                        ; DATA XREF: ...
                cmpi.w  #$80,d2
                bmi.s   loc_14B68
                cmpi.w  #$C0,d2
                bmi.w Sprite_UpdateBossAnimation
loc_14B68:                              ; CODE XREF: Physics_CheckAngleRange+4   j
                andi.w  #$7E,d2 ; '~'
                subi.w  #$40,d2 ; '@'
                bmi.w Physics_TerrainEmptyHandler
                cmpi.w  #$10,d2
                bmi.s   loc_14B80
                bset    #1,6(a5)
loc_14B80:                              ; CODE XREF: Physics_CheckAngleRange+1E   j
                movea.w off_14B8C(pc,d2.w),a4
                adda.l  #Physics_ApplyAcceleration,a4
                jmp     (a4)
; End of function Physics_CheckAngleRange
; ---------------------------------------------------------------------------
off_14B8C:      dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                                        ; DATA XREF: Physics_CheckAngleRange:loc_14B80   r
                dc.w Sprite_UpdateBossAnimation-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Sprite_UpdateBossAnimation-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_SnapFloorAdd4-Physics_ApplyAcceleration
                dc.w Physics_ApplyVerticalOffset4-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_CalcFloorPlus12-Physics_ApplyAcceleration
                dc.w Physics_SnapFloorPlus12-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration


; Applies acceleration to entity physics state
Physics_ApplyAcceleration:                              ; CODE XREF: Physics_MultiPointTerrainCheck+4E   j  ; was: sub_14BBC
                                        ; Physics_TerrainCheckWithVelocity+5A   j
                                        ; DATA XREF: ...
                cmpi.w  #$80,d2
                bmi.w Physics_SetSolidTerrainFlag
                bset    #1,6(a5)
                andi.w  #$7E,d2 ; '~'
                subi.w  #$40,d2 ; '@'
                bmi.w Physics_SnapToSurface
                movea.w off_14BE2(pc,d2.w),a4
                adda.l  #Physics_DispatchSlopeHandler,a4
                jmp     (a4)
; End of function Physics_ApplyAcceleration
; ---------------------------------------------------------------------------
off_14BE2:      dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                                        ; DATA XREF: Physics_ApplyAcceleration+1A   r
                dc.w Physics_SnapToSurface-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_SnapToSurface-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_SnapFloorAdd4-Physics_DispatchSlopeHandler
                dc.w Physics_ApplyVerticalOffset4-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_CalcFloorOffsetSubtract4-Physics_DispatchSlopeHandler
                dc.w Physics_SnapFloorMinus4-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler


; Processes terrain collision angle for slope handling
Physics_DispatchSlopeHandler:                              ; CODE XREF: Physics_MultiPointTerrainCheck+5E   j  ; was: sub_14C12
                                        ; Physics_TerrainCheckWithVelocity+70   j
                                        ; DATA XREF: ...
                cmpi.w  #$80,d2
                bmi.w Physics_SetSolidTerrainFlag
                bset    #1,6(a5)
                andi.w  #$7E,d2 ; '~'
                subi.w  #$40,d2 ; '@'
                bmi.w Physics_SnapToSurface
                movea.w off_14C38(pc,d2.w),a4
                adda.l  #Physics_TerrainEmptyHandler,a4
                jmp     (a4)
; End of function Physics_DispatchSlopeHandler
; ---------------------------------------------------------------------------
off_14C38:      dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                                        ; DATA XREF: Physics_DispatchSlopeHandler+1A   r
                dc.w Physics_SnapToSurface-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_SnapToSurface-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_SnapAndSubtract4-Physics_TerrainEmptyHandler
                dc.w Physics_PrepareVertical4Down-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Boss_DestroyerMK2EntryInit-Physics_TerrainEmptyHandler
                dc.w Physics_SnapAndAdd4-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler


; Empty terrain angle physics handler
Physics_TerrainEmptyHandler:                             ; CODE XREF: Physics_ProcessTerrainAngle+4   j  ; was: nullsub_35
                                        ; Physics_ProcessTerrainAngle+1A   j ...
                rts
; End of function Physics_TerrainEmptyHandler
; Sets solid terrain collision flag (bit 2 in collision flags)
Physics_SetSolidTerrainFlag:                              ; CODE XREF: Physics_HandleCeilingCollision+4   j  ; was: sub_14C6A
                                        ; Physics_ApplyAcceleration+4   j ...
                bset    #2,6(a5)
                rts
; End of function Physics_SetSolidTerrainFlag
; Snaps player position to floor surface
Player_SnapToFloor:                              ; CODE XREF: Player_HandleCollision+1A   j  ; was: sub_14C72
                                        ; Player_HandleFloorCollision+1A   j ...
                clr.l   $1C(a5)
                move.w  d1,d4
                sub.w   (dword_FFA904).w,d4
                andi.w  #7,d4
                sub.w   d4,$14(a5)
                rts
; End of function Player_SnapToFloor
; Snaps player position to terrain surface
Physics_SnapToSurface:                              ; CODE XREF: Physics_HandleCeilingCollision+16   j  ; was: sub_14C86
                                        ; Physics_ApplyAcceleration+16   j ...
                clr.l   $1C(a5)
                move.w  d1,d4
                sub.w   (dword_FFA904).w,d4
                neg.w   d4
                subq.w  #1,d4
                andi.w  #7,d4
                add.w   d4,$14(a5)
                rts
; End of function Physics_SnapToSurface
; Snaps to floor and subtracts 12 pixels
Physics_SnapFloorMinus12:                              ; DATA XREF: ROM:0001495C   o  ; was: sub_14C9E
                bsr.w Physics_PrepareFloorOffset8
                subi.w  #$C,$14(a5)
                rts
; End of function Physics_SnapFloorMinus12
; Snaps to floor and subtracts 4 pixels
Physics_SnapFloorMinus4:                              ; DATA XREF: ROM:000149CE   o  ; was: sub_14CAA
                                        ; ROM:00014A28   o ...
                bsr.s Physics_PrepareFloorOffset8
                subq.w  #4,$14(a5)
                rts
; End of function Physics_SnapFloorMinus4
; Snaps to floor and adds 4 pixels
Physics_SnapAndAdd4:                              ; DATA XREF: ROM:00014A82   o  ; was: sub_14CB2
                                        ; ROM:00014B44   o ...
                bsr.s Physics_PrepareFloorOffset8
                addq.w  #4,$14(a5)
                rts
; End of function Physics_SnapAndAdd4
; Snaps to floor and adds 12 pixels
Physics_SnapFloorPlus12:                              ; DATA XREF: ROM:00014BA6   o  ; was: sub_14CBA
                bsr.s Physics_PrepareFloorOffset8
                addi.w  #$C,$14(a5)
                rts
; End of function Physics_SnapFloorPlus12
; Calculates floor offset minus 12 pixels
Physics_CalcFloorMinus12:                              ; DATA XREF: ROM:0001495E   o  ; was: sub_14CC4
                bsr.s Physics_CalculateFloorOffset4
                subi.w  #$C,$14(a5)
                rts
; End of function Physics_CalcFloorMinus12
; Calculates floor offset and subtracts 4
Physics_CalcFloorOffsetSubtract4:                              ; DATA XREF: ROM:000149D0   o  ; was: sub_14CCE
                                        ; ROM:00014A2A   o ...
                bsr.s Physics_CalculateFloorOffset4
                subq.w  #4,$14(a5)
                rts
; End of function Physics_CalcFloorOffsetSubtract4
; Boss entry animation init
Boss_DestroyerMK2EntryInit:                              ; DATA XREF: ROM:00014A84   o  ; was: sub_14CD6
                                        ; ROM:00014B42   o ...
                bsr.s Physics_CalculateFloorOffset4
                addq.w  #4,$14(a5)
                rts
; End of function Boss_DestroyerMK2EntryInit
; Calculates floor offset plus 12 pixels
Physics_CalcFloorPlus12:                              ; DATA XREF: ROM:00014BA4   o  ; was: sub_14CDE
                bsr.s Physics_CalculateFloorOffset4
                addi.w  #$C,$14(a5)
                rts
; End of function Physics_CalcFloorPlus12
; Prepares d3=8 for floor offset
Physics_PrepareFloorOffset8:                              ; CODE XREF: Physics_SnapFloorMinus12   p  ; was: sub_14CE8
                                        ; sub_14CAA   p ...
                moveq   #8,d3
                bra.s Physics_AlignToFloorWithOffset
; End of function Physics_PrepareFloorOffset8
; Calculates floor offset d3=4 base
Physics_CalculateFloorOffset4:                              ; CODE XREF: Physics_CalcFloorMinus12   p  ; was: sub_14CEC
                                        ; sub_14CCE   p ...
                moveq   #4,d3
; Aligns entity to floor with calculated pixel offset
Physics_AlignToFloorWithOffset:                              ; CODE XREF: Physics_PrepareFloorOffset8+2   j  ; was: loc_14CEE
                bsr.w Player_SnapToFloor
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #7,d4
                asr.w   #1,d4
                addq.w  #1,d4
                sub.w   d4,d3
                add.w   d3,$14(a5)
                rts
; End of function Physics_CalculateFloorOffset4
; Applies vertical offset of 4 pixels
Physics_ApplyVerticalOffset4:                              ; DATA XREF: ROM:00014A30   o  ; was: sub_14D08
                                        ; ROM:00014B9E   o ...
                bsr.s Physics_PrepareVerticalOffset
                addq.w  #4,$14(a5)
                rts
; End of function Physics_ApplyVerticalOffset4
; Prepares vertical offset 12 pixels down
Physics_PrepareVertical12Down:                              ; DATA XREF: ROM:000149D6   o  ; was: sub_14D10
                bsr.s Physics_PrepareVerticalOffset
                subi.w  #$C,$14(a5)
                rts
; End of function Physics_PrepareVertical12Down
; Prepares vertical offset 4 pixels down
Physics_PrepareVertical4Down:                              ; DATA XREF: ROM:00014964   o  ; was: sub_14D1A
                                        ; ROM:00014A8A   o ...
                bsr.s Physics_PrepareVerticalOffset
                subq.w  #4,$14(a5)
                rts
; End of function Physics_PrepareVertical4Down
; Prepares vertical offset 12 pixels up
Physics_PrepareVertical12Up:                              ; DATA XREF: ROM:00014B3C   o  ; was: sub_14D22
                bsr.s Physics_PrepareVerticalOffset
                addi.w  #$C,$14(a5)
                rts
; End of function Physics_PrepareVertical12Up
; Snaps to floor and adds 4 pixels
Physics_SnapFloorAdd4:                              ; DATA XREF: ROM:00014A32   o  ; was: sub_14D2C
                                        ; ROM:00014B9C   o ...
                bsr.s Physics_SnapToFloorNoOffset
                addq.w  #4,$14(a5)
                rts
; End of function Physics_SnapFloorAdd4
; Snaps to floor and subtracts 12 pixels
Physics_SnapFloorSub12:                              ; DATA XREF: ROM:000149D8   o  ; was: sub_14D34
                bsr.s Physics_SnapToFloorNoOffset
                subi.w  #$C,$14(a5)
                rts
; End of function Physics_SnapFloorSub12
; Snaps to floor and subtracts 4 pixels
Physics_SnapAndSubtract4:                              ; DATA XREF: ROM:00014966   o  ; was: sub_14D3E
                                        ; ROM:00014A8C   o ...
                bsr.s Physics_SnapToFloorNoOffset
                subq.w  #4,$14(a5)
                rts
; End of function Physics_SnapAndSubtract4
; Snaps to floor and adds 12 pixels
Physics_SnapFloorAdd12:                              ; DATA XREF: ROM:00014B3A   o  ; was: sub_14D46
                bsr.s Physics_SnapToFloorNoOffset
                addi.w  #$C,$14(a5)
                rts
; End of function Physics_SnapFloorAdd12
; Prepares d3=4 for vertical offset
Physics_PrepareVerticalOffset:                              ; CODE XREF: Physics_ApplyVerticalOffset4   p  ; was: sub_14D50
                                        ; sub_14D10   p ...
                moveq   #4,d3
                bra.s   loc_14D56
; End of function Physics_PrepareVerticalOffset
; Snaps entity to floor without offset
Physics_SnapToFloorNoOffset:                              ; CODE XREF: Physics_SnapFloorAdd4   p  ; was: sub_14D54
                                        ; sub_14D34   p ...
                moveq   #0,d3
loc_14D56:                              ; CODE XREF: Physics_PrepareVerticalOffset+2   j
                bsr.w Player_SnapToFloor
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #6,d4
                asr.w   #1,d4
                add.w   d4,d3
                add.w   d3,$14(a5)
                rts
; End of function Physics_SnapToFloorNoOffset
; Prepares 8-pixel offset subtracts 10
Physics_Prepare8Sub10:                              ; DATA XREF: ROM:0001496C   o  ; was: sub_14D6E
                bsr.w Physics_PrepareVerticalOffset8
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_Prepare8Sub10
; Prepares 8-pixel offset subtracts 6
Physics_Prepare8Sub6:                              ; DATA XREF: ROM:000149DE   o  ; was: sub_14D7A
                bsr.s Physics_PrepareVerticalOffset8
                subq.w  #6,$14(a5)
                rts
; End of function Physics_Prepare8Sub6
; Prepares 8-pixel offset subtracts 2
Physics_Prepare8Sub2:                              ; DATA XREF: ROM:00014A38   o  ; was: sub_14D82
                bsr.s Physics_PrepareVerticalOffset8
                subq.w  #2,$14(a5)
                rts
; End of function Physics_Prepare8Sub2
; Snaps to floor and adds 2 pixels
Physics_SnapAndAdd2:                              ; DATA XREF: ROM:00014A92   o  ; was: sub_14D8A
                bsr.s Physics_PrepareVerticalOffset8
                addq.w  #2,$14(a5)
                rts
; End of function Physics_SnapAndAdd2
; Prepares 6-pixel offset subtracts 10
Physics_Prepare6Sub10:                              ; DATA XREF: ROM:0001496E   o  ; was: sub_14D92
                bsr.s Physics_PrepareVerticalOffset6
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_Prepare6Sub10
; Prepares 6-pixel offset subtracts 6
Physics_Prepare6Sub6:                              ; DATA XREF: ROM:000149E0   o  ; was: sub_14D9C
                bsr.s Physics_PrepareVerticalOffset6
                subq.w  #6,$14(a5)
                rts
; End of function Physics_Prepare6Sub6
; Prepares 6-pixel offset subtracts 2
Physics_Prepare6Sub2:                              ; DATA XREF: ROM:00014A3A   o  ; was: sub_14DA4
                bsr.s Physics_PrepareVerticalOffset6
                subq.w  #2,$14(a5)
                rts
; End of function Physics_Prepare6Sub2
; Prepares 6-pixel offset adds 2
Physics_Prepare6Add2:                              ; DATA XREF: ROM:00014A94   o  ; was: sub_14DAC
                bsr.s Physics_PrepareVerticalOffset6
                addq.w  #2,$14(a5)
                rts
; End of function Physics_Prepare6Add2
; Applies 4-pixel offset subtracts 10
Physics_Apply4Sub10:                              ; DATA XREF: ROM:00014970   o  ; was: sub_14DB4
                bsr.s Physics_ApplyFloorOffset4
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_Apply4Sub10
; Applies 4-pixel offset subtracts 6
Physics_Apply4Sub6:                              ; DATA XREF: ROM:000149E2   o  ; was: sub_14DBE
                bsr.s Physics_ApplyFloorOffset4
                subq.w  #6,$14(a5)
                rts
; End of function Physics_Apply4Sub6
; Applies 4-pixel offset subtracts 2
Physics_Apply4Sub2:                              ; DATA XREF: ROM:00014A3C   o  ; was: sub_14DC6
                bsr.s Physics_ApplyFloorOffset4
                subq.w  #2,$14(a5)
                rts
; End of function Physics_Apply4Sub2
; Applies 4-pixel offset adds 2
Physics_Apply4Add2:                              ; DATA XREF: ROM:00014A96   o  ; was: sub_14DCE
                bsr.s Physics_ApplyFloorOffset4
                addq.w  #2,$14(a5)
                rts
; End of function Physics_Apply4Add2
; Boss entry movement
Boss_DestroyerMK2EntryMove:                              ; DATA XREF: ROM:00014972   o  ; was: sub_14DD6
                bsr.s Boss_DestroyerMK2BattleStart
                subi.w  #$A,$14(a5)
                rts
; End of function Boss_DestroyerMK2EntryMove
; Starts DestroyerMK2 battle moves 6 down
Boss_DestroyerMK2Sub6:                              ; DATA XREF: ROM:000149E4   o  ; was: sub_14DE0
                bsr.s Boss_DestroyerMK2BattleStart
                subq.w  #6,$14(a5)
                rts
; End of function Boss_DestroyerMK2Sub6
; Starts DestroyerMK2 battle moves 2 down
Boss_DestroyerMK2Sub2:                              ; DATA XREF: ROM:00014A3E   o  ; was: sub_14DE8
                bsr.s Boss_DestroyerMK2BattleStart
                subq.w  #2,$14(a5)
                rts
; End of function Boss_DestroyerMK2Sub2
; Boss entry stop position
Boss_DestroyerMK2EntryStop:                              ; DATA XREF: ROM:00014A98   o  ; was: sub_14DF0
                bsr.s Boss_DestroyerMK2BattleStart
                addq.w  #2,$14(a5)
                rts
; End of function Boss_DestroyerMK2EntryStop
; Prepares d3=8 for vertical offset
Physics_PrepareVerticalOffset8:                              ; CODE XREF: Physics_Prepare8Sub10   p  ; was: sub_14DF8
                                        ; sub_14D7A   p ...
                moveq   #8,d3
                bra.s   loc_14E06
; End of function Physics_PrepareVerticalOffset8
; Prepares d3=6 for vertical offset
Physics_PrepareVerticalOffset6:                              ; CODE XREF: Physics_Prepare6Sub10   p  ; was: sub_14DFC
                                        ; sub_14D9C   p ...
                moveq   #6,d3
                bra.s   loc_14E06
; End of function Physics_PrepareVerticalOffset6
; Applies 4-pixel floor offset for terrain alignment
Physics_ApplyFloorOffset4:                              ; CODE XREF: Physics_Apply4Sub10   p  ; was: sub_14E00
                                        ; sub_14DBE   p ...
                moveq   #4,d3
                bra.s   loc_14E06
; End of function Physics_ApplyFloorOffset4
; Battle start initialization
Boss_DestroyerMK2BattleStart:                              ; CODE XREF: Boss_DestroyerMK2EntryMove   p  ; was: sub_14E04
                                        ; sub_14DE0   p ...
                moveq   #2,d3
loc_14E06:                              ; CODE XREF: Physics_PrepareVerticalOffset8+2   j
                                        ; Physics_PrepareVerticalOffset6+2   j ...
                bsr.w Player_SnapToFloor
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #7,d4
                asr.w   #2,d4
                addq.w  #1,d4
                sub.w   d4,d3
                add.w   d3,$14(a5)
                rts
; End of function Boss_DestroyerMK2BattleStart
; Applies vertical physics offset -6
Physics_ApplyOffset6Down:                              ; DATA XREF: ROM:00014974   o  ; was: sub_14E20
                bsr.w Physics_PrepareVerticalOffset5
                subq.w  #6,$14(a5)
                rts
; End of function Physics_ApplyOffset6Down
; Applies vertical physics offset -10
Physics_ApplyOffset10Down:                              ; DATA XREF: ROM:000149E6   o  ; was: sub_14E2A
                bsr.s Physics_PrepareVerticalOffset5
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_ApplyOffset10Down
; Prepares vertical offset 5 and adds 2 to Y position
Physics_ApplyOffset5Up:                              ; DATA XREF: ROM:00014A40   o  ; was: sub_14E34
                bsr.s Physics_PrepareVerticalOffset5
                addq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset5Up
; Prepares vertical offset 5 and subtracts 2 from Y position
Physics_ApplyOffset5Down:                              ; DATA XREF: ROM:00014A9A   o  ; was: sub_14E3C
                bsr.s Physics_PrepareVerticalOffset5
                subq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset5Down
; Prepares vertical offset 3 and subtracts 6 from Y position
Physics_ApplyOffset3Down6:                              ; DATA XREF: ROM:00014976   o  ; was: sub_14E44
                bsr.s Physics_PrepareVerticalOffset3
                subq.w  #6,$14(a5)
                rts
; End of function Physics_ApplyOffset3Down6
; Prepares vertical offset 3 and subtracts 10 from Y position
Physics_ApplyOffset3Down10:                              ; DATA XREF: ROM:000149E8   o  ; was: sub_14E4C
                bsr.s Physics_PrepareVerticalOffset3
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_ApplyOffset3Down10
; Prepares vertical offset 3 and adds 2 to Y position
Physics_ApplyOffset3Up:                              ; DATA XREF: ROM:00014A42   o  ; was: sub_14E56
                bsr.s Physics_PrepareVerticalOffset3
                addq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset3Up
; Prepares vertical offset 3 and subtracts 2 from Y position
Physics_ApplyOffset3Down:                              ; DATA XREF: ROM:00014A9C   o  ; was: sub_14E5E
                bsr.s Physics_PrepareVerticalOffset3
                subq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset3Down
; Prepares vertical offset 1 and subtracts 6 from Y position
Physics_ApplyOffset1Down6:                              ; DATA XREF: ROM:00014978   o  ; was: sub_14E66
                bsr.s Physics_PrepareVerticalOffset1
                subq.w  #6,$14(a5)
                rts
; End of function Physics_ApplyOffset1Down6
; Prepares vertical offset 1 and subtracts 10 from Y position
Physics_ApplyOffset1Down10:                              ; DATA XREF: ROM:000149EA   o  ; was: sub_14E6E
                bsr.s Physics_PrepareVerticalOffset1
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_ApplyOffset1Down10
; Prepares vertical offset 1 and adds 2 to Y position
Physics_ApplyOffset1Up:                              ; DATA XREF: ROM:00014A44   o  ; was: sub_14E78
                bsr.s Physics_PrepareVerticalOffset1
                addq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset1Up
; Prepares vertical offset 1 and subtracts 2 from Y position
Physics_ApplyOffset1Down:                              ; DATA XREF: ROM:00014A9E   o  ; was: sub_14E80
                bsr.s Physics_PrepareVerticalOffset1
                subq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset1Down
; Prepares negative offset and subtracts 6 from Y position
Physics_ApplyOffsetNegDown6:                              ; DATA XREF: ROM:0001497A   o  ; was: sub_14E88
                bsr.s Physics_PrepareOffsetNeg
                subq.w  #6,$14(a5)
                rts
; End of function Physics_ApplyOffsetNegDown6
; Prepares negative offset and subtracts 10 from Y position
Physics_ApplyOffsetNegDown10:                              ; DATA XREF: ROM:000149EC   o  ; was: sub_14E90
                bsr.s Physics_PrepareOffsetNeg
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_ApplyOffsetNegDown10
; Prepares negative offset and adds 2 to Y position
Physics_ApplyOffsetNegUp:                              ; DATA XREF: ROM:00014A46   o  ; was: sub_14E9A
                bsr.s Physics_PrepareOffsetNeg
                addq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffsetNegUp
; Prepares negative offset and subtracts 2 from Y position
Physics_ApplyOffsetNegDown:                              ; DATA XREF: ROM:00014AA0   o  ; was: sub_14EA2
                bsr.s Physics_PrepareOffsetNeg
                subq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffsetNegDown
; Prepares d3=5 for vertical offset
Physics_PrepareVerticalOffset5:                              ; CODE XREF: Physics_ApplyOffset6Down   p  ; was: sub_14EAA
                                        ; sub_14E2A   p ...
                moveq   #5,d3
                bra.s   loc_14EB8
; End of function Physics_PrepareVerticalOffset5
; Prepares d3=3 for vertical offset
Physics_PrepareVerticalOffset3:                              ; CODE XREF: Physics_ApplyOffset3Down6   p  ; was: sub_14EAE
                                        ; sub_14E4C   p ...
                moveq   #3,d3
                bra.s   loc_14EB8
; End of function Physics_PrepareVerticalOffset3
; Prepares d3=1 for vertical offset
Physics_PrepareVerticalOffset1:                              ; CODE XREF: Physics_ApplyOffset1Down6   p  ; was: sub_14EB2
                                        ; sub_14E6E   p ...
                moveq   #1,d3
                bra.s   loc_14EB8
; End of function Physics_PrepareVerticalOffset1
; Prepares negative vertical offset
Physics_PrepareOffsetNeg:                              ; CODE XREF: Physics_ApplyOffsetNegDown6   p  ; was: sub_14EB6
                                        ; sub_14E90   p ...
                moveq   #$FFFFFFFF,d3
loc_14EB8:                              ; CODE XREF: Physics_PrepareVerticalOffset5+2   j
                                        ; Physics_PrepareVerticalOffset3+2   j ...
                bsr.w Player_SnapToFloor
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #7,d4
                asr.w   #2,d4
                addq.w  #1,d4
                add.w   d4,d3
                add.w   d3,$14(a5)
                rts
; End of function Physics_PrepareOffsetNeg
; Updates boss sprite animation frame
Sprite_UpdateBossAnimation:                              ; CODE XREF: Physics_EntityWallCheck+3C   p  ; was: sub_14ED2
                                        ; Physics_BossTerrainCheck+5A   j ...
                bset    #1,7(a5)
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #7,d4
                addq.w  #1,d4
                sub.w   d4,$10(a5)
                rts
; End of function Sprite_UpdateBossAnimation
; Handles wall collision and adjusts position
Physics_HandleWallCollision:                              ; CODE XREF: Physics_EntityWallCheck+24   p  ; was: sub_14EEA
                                        ; Physics_BossTerrainCheck+2E   p ...
                bset    #0,7(a5)
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                neg.w   d4
                subq.w  #1,d4
                andi.w  #7,d4
                addq.w  #1,d4
                add.w   d4,$10(a5)
                rts
; End of function Physics_HandleWallCollision
; Initializes player stats and parameters
Player_InitializeStats:                              ; CODE XREF: Stage_LoadXiTigerGraphics+3A   j  ; was: sub_14F06
                                        ; Sys_InitStageState+3A   j ...
                lea     (word_FFA400).w,a5
                move.b  #$7F,(byte_FF830F).w
                move.w  (dword_FFA900).w,(word_FFA928).w
                move.w  (dword_FFA904).w,(word_FFA92C).w
                move.w  #8,(a5)
                move.w  #$4D00,2(a5)
                clr.w   4(a5)
                move.w  #$4DC0,$E(a5)
                move.w  #$B800,$DA(a5)
                move.b  #8,$20(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$81,$21(a5)
                move.b  #$10,$23(a5)
                move.l  #$EC24F60A,$28(a5)
                move.w  #$78,(word_FF8304).w ; 'x'
                clr.b   $6B(a5)
                clr.w   $9E(a5)
                move.w  #$40,$5E(a5) ; '@'
                move.l  #$74000,(dword_FFA938).w
                move.l  #$74000,(dword_FFA93C).w
                jmp UI_IncrementWeaponSelection
; End of function Player_InitializeStats
; Clears player state flags
Player_ClearState:                              ; CODE XREF: Player_Update+A   j  ; was: sub_14F82
                clr.w   (a5)
                clr.w   2(a5)
                rts
; End of function Player_ClearState
; Sets player invincibility flag bit based on game state
Player_SetInvincibilityFlag:                              ; CODE XREF: Player_Update+12   j  ; was: sub_14F8A
                tst.w   (word_FF813C).w
                bmi.s Player_SetInvincibilityFlag_Return
                bset    #7,2(a5)
; Return after setting player invincibility
Player_SetInvincibilityFlag_Return:                           ; CODE XREF: Player_SetInvincibilityFlag+4   j  ; was: locret_14F96
                                        ; DATA XREF: ROM:0001508E   o ...
                rts
; End of function Player_SetInvincibilityFlag
; Main player update routine
Player_Update:                              ; CODE XREF: Sys_GameplayMainLoop:loc_1C70E   p  ; was: sub_14F98
                                        ; sub_1EE3C   p ...
                movea.w #(word_FFA400-M68K_RAM),a5
                btst    #1,(byte_FF8144).w
                bne.w Player_ClearState
                tst.b   (byte_FF813E).w
                bmi.s Player_SetInvincibilityFlag
                jsr (Input_MergeButtonState).l
                bsr.w Input_ReadPlayerInput
                clr.b   (byte_FF8244).w
                clr.w   6(a5)
                tst.w   (word_FF80E6).w
                beq.s   loc_14FC8
                bpl.w Player_HandleInvulnerabilityTimer
loc_14FC8:                              ; CODE XREF: Player_Update+2A   j
                tst.w   (word_FFA270).w
                beq.w Player_InitInvulnerabilityState
                tst.w   (word_FFA216).w
                beq.w Player_InitInvulnerabilityState
                btst    #0,(byte_FF8144).w
                bne.w Boss_SylpheedSpawnProjectile1
                btst    #2,(byte_FF8144).w
                bne.w Gfx_SireneBackground
                bsr.w Gfx_LoadPlayerPaletteData
                bsr.w Input_ProcessDirectionInput
                bclr    #6,$22(a5)
                beq.s   loc_15002
                bsr.w Player_InitKnockbackState
                bra.s Player_UpdateCoreAttributes
; ---------------------------------------------------------------------------
loc_15002:                              ; CODE XREF: Player_Update+62   j
                bclr    #1,$22(a5)
                beq.s   loc_15010
                bsr.w Player_InitCutsceneState
                bra.s Player_UpdateCoreAttributes
; ---------------------------------------------------------------------------
loc_15010:                              ; CODE XREF: Player_Update+70   j
                cmpi.w  #$36,4(a5) ; '6'
                beq.s   loc_15030
                tst.w   $1C(a5)
                bmi.s   loc_15030
                btst    #0,(byte_FF8245).w
                bne.s   loc_15030
                cmpi.w  #$171,$14(a5)
                bpl.w Player_HandleDeathSequence
loc_15030:                              ; CODE XREF: Player_Update+7E   j
                                        ; Player_Update+84   j ...
                bsr.w Player_UpdateWeaponSwitchTimer
                bsr.w Player_UpdateState
; Updates core player attributes including direction invulnerability hitbox and center position
Player_UpdateCoreAttributes:                              ; CODE XREF: Player_Update+68   j  ; was: loc_15038
                                        ; Player_Update+76   j
                bsr.w Player_UpdateDirectionBit
                move.b  $69(a5),$6B(a5)
                bsr.w Player_UpdateInvulnerabilityTimer
                bsr.w Player_SetHitbox
                clr.b   (byte_FF8311).w
                bra.w Player_CalculateCenterPosition
; End of function Player_Update
; Updates player state machine
Player_UpdateState:                              ; CODE XREF: Player_Update+9C   p  ; was: sub_15052
                move.w  4(a5),d0
                movea.w off_15062(pc,d0.w),a0
                adda.l  #Player_HandleDeathSequence,a0
                jmp     (a0)
; End of function Player_UpdateState
; ---------------------------------------------------------------------------
off_15062:      dc.w Player_HandleJump-Player_HandleDeathSequence
                                        ; DATA XREF: Player_UpdateState+4   r
                dc.w Boss_UpdateHealthBar-Player_HandleDeathSequence
                dc.w Player_AirAttackState-Player_HandleDeathSequence
                dc.w Player_HandleFallingState-Player_HandleDeathSequence
                dc.w Player_HandleFallingState-Player_HandleDeathSequence
                dc.w Player_HandleAirMovement-Player_HandleDeathSequence
                dc.w Player_HandleGroundedState-Player_HandleDeathSequence
                dc.w Player_HandleAirState-Player_HandleDeathSequence
                dc.w Player_HandleDashCancel-Player_HandleDeathSequence
                dc.w Player_HandleBounceState-Player_HandleDeathSequence
                dc.w Player_HandleFallingState-Player_HandleDeathSequence
                dc.w Player_HandleLandingState-Player_HandleDeathSequence
                dc.w Player_HandleDashState-Player_HandleDeathSequence
                dc.w Sound_PlayBossHitSound-Player_HandleDeathSequence
                dc.w Player_AirControlState-Player_HandleDeathSequence
                dc.w Player_HandleCrouchState-Player_HandleDeathSequence
                dc.w Player_CheckDashCounter-Player_HandleDeathSequence
                dc.w Player_ProcessAirState-Player_HandleDeathSequence
                dc.w Player_HandleDashCancel-Player_HandleDeathSequence
                dc.w Player_ProcessJumpState-Player_HandleDeathSequence
                dc.w Player_HandleFallingState-Player_HandleDeathSequence
                dc.w Player_DefeatState-Player_HandleDeathSequence
                dc.w Player_SetInvincibilityFlag_Return-Player_HandleDeathSequence
                dc.w Player_SetInvincibilityFlag_Return-Player_HandleDeathSequence
                dc.w Player_SetInvincibilityFlag_Return-Player_HandleDeathSequence
                dc.w Player_HandleCutsceneControl-Player_HandleDeathSequence
                dc.w Player_HandleCutsceneControl-Player_HandleDeathSequence
                dc.w Player_HandleDeathSequence_SetFlags-Player_HandleDeathSequence
                dc.w Player_HandleRespawnGravity-Player_HandleDeathSequence
                dc.w Physics_ApplyBossVelocity-Player_HandleDeathSequence
                dc.w Physics_BossCollisionCheck-Player_HandleDeathSequence
                dc.w Player_HandleAirDashState-Player_HandleDeathSequence
                dc.w Player_HandleSlideState-Player_HandleDeathSequence
                dc.w Player_HandleSlideState-Player_HandleDeathSequence
                dc.w Player_DashKickState-Player_HandleDeathSequence
                dc.w Effect_UpdateParticles-Player_HandleDeathSequence
                dc.w Player_UpdateAimDirection-Player_HandleDeathSequence
                dc.w Player_UpdateForceWeapon-Player_HandleDeathSequence
                dc.w Player_JumpApexState-Player_HandleDeathSequence
                dc.w Player_HandleSpecialAttack-Player_HandleDeathSequence
                dc.w Player_TeleportDash-Player_HandleDeathSequence
                dc.w Player_TeleportDash_ApplyVelocity-Player_HandleDeathSequence
                dc.w Player_HandleBossVictory-Player_HandleDeathSequence
                dc.w Player_PhoenixAttackUpdate-Player_HandleDeathSequence
                dc.w Boss_ArtemisSpawnProjectile2-Player_HandleDeathSequence
                dc.w Player_UpdateAnimStateMinus4-Player_HandleDeathSequence
                dc.w Credits_VBlankHandler-Player_HandleDeathSequence
                dc.w Player_TeleportDash_UpdateSprite-Player_HandleDeathSequence


; Handles player death sequence with knockback and respawn countdown
Player_HandleDeathSequence:                              ; CODE XREF: Player_Update+94   j  ; was: sub_150C2
                                        ; DATA XREF: Player_UpdateState+8   o ...
                move.b  #$2B,d0 ; '+'
                jsr (Sound_PlaySFX).l
                move.b  #$73,(byte_FF830F).w ; 's'
                move.w  #$8000,(word_FF80E6).w
                jsr (Memory_ClearBlock).l
                move.b  #1,(word_FF8224).w
                move.b  #1,(word_FF8224+1).w
                move.w  #$36,4(a5) ; '6'
                move.w  #$C100,2(a5)
                bclr    #4,$E(a5)
                move.b  $E(a5),$4C(a5)
                move.b  $20(a5),$4D(a5)
                bset    #3,$E(a5)
                bset    #7,$E(a5)
                move.b  #$81,$21(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$120,$14(a5)
                move.w  #3,$48(a5)
                move.w  #$A0,$4A(a5)
; Sets player death animation flags and counters
Player_HandleDeathSequence_SetFlags:                              ; DATA XREF: ROM:00015098   o  ; was: loc_15134
                bset    #5,(byte_FF8244).w
                bset    #0,(byte_FF8244).w
                move.b  #8,$20(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   loc_15152
                subq.w  #1,(word_FFA216).w
loc_15152:                              ; CODE XREF: Player_HandleDeathSequence+8A   j
                subq.w  #1,(word_FFA216).w
                bpl.s   loc_1515C
                clr.w   (word_FFA216).w
loc_1515C:                              ; CODE XREF: Player_HandleDeathSequence+94   j
                move.w  #$10,$5E(a5)
                subq.w  #1,$4A(a5)
                bmi.s   loc_15186
                move.b  $6A(a5),d0
                andi.w  #$70,d0 ; 'p'
                beq.s   loc_15182
                move.b  #$BD,d0
                jsr (Sound_PlaySFX).l
                subq.w  #1,$48(a5)
                bmi.s   loc_15186
loc_15182:                              ; CODE XREF: Player_HandleDeathSequence+AE   j
                bra.w Player_RenderDeathParticles
; ---------------------------------------------------------------------------
loc_15186:                              ; CODE XREF: Player_HandleDeathSequence+A4   j
                                        ; Player_HandleDeathSequence+BE   j
                clr.w   (word_FF80E6).w
                move.b  #$7F,(byte_FF830F).w
                move.w  #$38,4(a5) ; '8'
                move.w  #$CD00,2(a5)
                move.w  #$C,$5C(a5)
                move.l  #$FFF70000,$1C(a5)
                move.w  #$50,$5E(a5) ; 'P'
                clr.w   $48(a5)
                clr.w   $4A(a5)
                move.b  $4C(a5),$E(a5)
                move.b  $4D(a5),$20(a5)
                move.w  #$170,$14(a5)
                move.w  #$FF80,$52(a5)
; Handles respawn gravity accumulation until landing
Player_HandleRespawnGravity:                              ; DATA XREF: ROM:0001509A   o  ; was: loc_151D0
                bclr    #0,(byte_FF826C).w
                addi.l  #$3000,$1C(a5)
                bmi.w   loc_15D12
                clr.b   (word_FF8224).w
                clr.b   (word_FF8224+1).w
                bra.w   loc_15D12
; End of function Player_HandleDeathSequence
; Initializes player air movement state
Player_InitAirState:                              ; CODE XREF: Physics_ApplyBossVelocity+18   j  ; was: sub_151EE
                                        ; Player_DefeatGroundedState+10   j ...
                move.b  #$7F,(byte_FF830F).w
                bclr    #0,(byte_FF826C).w
                clr.w   (word_FF8224).w
                move.w  #0,4(a5)
                clr.l   $18(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
                bra.w Player_AutoFlipDirection
; End of function Player_InitAirState
nullsub_36:                             ; CODE XREF: Player_HandleJump+1C   j
                                        ; Player_HandleJump+22   j
                rts
; End of function nullsub_36


; Handles player jump mechanics
Player_HandleJump:                              ; DATA XREF: ROM:off_15062   o  ; was: sub_1521E
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                bsr.w Player_ProcessAction
                btst    #0,6(a5)
                beq.w Player_InitFallState
                bsr.w Effect_SpawnParticle
                bsr.w Player_HandleSpecialMove
                bne.s   nullsub_36
                bsr.w Player_CheckSpecialMoveActivation
                bne.s   nullsub_36
                btst    #0,(byte_FF826C).w
                bne.w Player_HandleDamageKnockback
                btst    #4,$69(a5)
                beq.s   loc_1525A
                tst.w   (word_FFA22A).w
                bne.s   loc_15278
loc_1525A:                              ; CODE XREF: Player_HandleJump+34   j
                btst    #1,$69(a5)
                bne.w Player_InitJumpCancelState
                btst    #2,$69(a5)
                bne.w Player_CheckWallCollisionJump
                btst    #3,$69(a5)
                bne.w Player_CheckWallCollisionJump
loc_15278:                              ; CODE XREF: Player_HandleJump+3A   j
                btst    #4,$69(a5)
                beq.w Player_ProcessCollisionDamage
                bra.w Player_RenderSpecialWeapon
; ---------------------------------------------------------------------------
; Handles damage knockback with velocity and timer setup
Player_HandleDamageKnockback:                              ; CODE XREF: Player_HandleJump+2A   j  ; was: loc_15286
                                        ; Player_HandleAirState+2C   j ...
                bsr.w Boss_FlashOnHit
                move.b  #$7F,(byte_FF830F).w
                jsr (Sys_ClearObjectBufferSmall).l
                move.w  #$3A,4(a5) ; ':'
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_152C8
                neg.l   $18(a5)
locret_152C8:                           ; CODE XREF: Player_HandleJump+A4   j
                rts
; End of function Player_HandleJump
; Applies velocity to boss position with bounds
Physics_ApplyBossVelocity:                              ; DATA XREF: ROM:0001509C   o  ; was: sub_152CA
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                bsr.w Player_ProcessAction
                btst    #0,6(a5)
                beq.w Player_SetDeathStateFlags
                subq.w  #1,$4A(a5)
                bmi.w Player_InitAirState
                bsr.w Boss_TakeDamage
                bne.w   loc_15936
                move.l  #$2000,d1
                bsr.w Player_DecelerateHorizontalVelocity
                bra.w Player_AnimateDefeatSprite
; End of function Physics_ApplyBossVelocity
; Initializes player death knockback state and velocity
Player_InitDeathKnockback:                              ; CODE XREF: Player_HandleFallingState+82   j  ; was: sub_152FC
                                        ; Player_HandleSpecialAttack+64   j ...
                bsr.w Boss_FlashOnHit
                move.b  #$7F,(byte_FF830F).w
                jsr (Sys_ClearObjectBufferSmall).l
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$FFFE0000,$1C(a5)
                move.l  #$FFFC0000,$18(a5)
                btst    #3,$E(a5)
                bne.s Player_SetDeathStateFlags
                neg.l   $18(a5)
; Sets player death state flags and animation timer
Player_SetDeathStateFlags:                              ; CODE XREF: Physics_ApplyBossVelocity+10   j  ; was: loc_1533A
                                        ; Player_InitDeathKnockback+38   j ...
                move.w  #$3C,4(a5) ; '<'
                rts
; End of function Player_InitDeathKnockback
; Checks collision between boss and player shots
Physics_BossCollisionCheck:                              ; DATA XREF: ROM:0001509E   o  ; was: sub_15342
                addi.l  #$5000,$1C(a5)
                jsr Physics_BossTerrainWrapper(pc)   ; (pc)
                nop
                tst.w   $1C(a5)
                bmi.s   loc_15366
                bsr.w Player_UpdateTerrainCheck
                btst    #0,6(a5)
                bne.w Player_InitLandingState
                bra.s   loc_15386
; ---------------------------------------------------------------------------
loc_15366:                              ; CODE XREF: Physics_BossCollisionCheck+12   j
                clr.b   6(a5)
                jsr Player_TerrainCheckAlternate(pc)   ; (pc)
                nop
                bra.s   loc_15386
; End of function Physics_BossCollisionCheck
; Handles player defeat with terrain check
Player_DefeatGroundedState:
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)  ; was: sub_15372
                nop
                bsr.w Player_ProcessAction
                btst    #0,6(a5)
                bne.w Player_InitAirState
loc_15386:                              ; CODE XREF: Physics_BossCollisionCheck+22   j
                                        ; Physics_BossCollisionCheck+2E   j
                subq.w  #1,$4A(a5)
                bmi.w   loc_15C3C
                move.l  #$1800,d1
                bsr.w Player_DecelerateHorizontalVelocity
                bra.w Player_AnimateDefeatSprite
; End of function Player_DefeatGroundedState
; Processes damage to boss and updates health
Boss_TakeDamage:                              ; CODE XREF: Physics_ApplyBossVelocity+1C   p  ; was: sub_1539C
                btst    #5,$6A(a5)
                beq.s   locret_153BA
                btst    #1,$69(a5)
                beq.s   locret_153BA
                move.w  (word_FFA216).w,d0
                sub.w   (word_FFA218).w,d0
                move.w  d0,(word_FF8304).w
                moveq   #1,d0
locret_153BA:                           ; CODE XREF: Boss_TakeDamage+6   j
                                        ; Boss_TakeDamage+E   j
                rts
; End of function Boss_TakeDamage
; Flashes boss sprite when taking damage
Boss_FlashOnHit:                              ; CODE XREF: Player_HandleJump:loc_15286   p  ; was: sub_153BC
                                        ; sub_152FC   p ...
                moveq   #$FFFFFFFC,d0
                move.l  #$FFFC0000,d2
                moveq   #$FFFFFFF6,d1
                btst    #4,$E(a5)
                beq.s   loc_153D0
                moveq   #$A,d1
loc_153D0:                              ; CODE XREF: Boss_FlashOnHit+10   j
                bra.w Boss_CheckDefeatCondition
; End of function Boss_FlashOnHit
; Initializes jump cancel state clearing flags and timers
Player_InitJumpCancelState:                              ; CODE XREF: Player_HandleJump+42   j  ; was: sub_153D4
                                        ; Player_HandleAirMovement+30   j ...
                move.w  #2,$48(a5)
; Initializes jump cancel state clearing flags and setting timers
Player_InitJumpCancelCleanup:                              ; CODE XREF: Player_HandleDashCancel+84   j  ; was: loc_153DA
                                        ; Player_HandleSlideState+34   j
                bclr    #0,(byte_FF826C).w
                clr.w   (word_FF8224).w
                move.w  #$E,4(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #8,$5C(a5)
                move.b  #$7F,(byte_FF830F).w
                bra.w Player_AutoFlipDirection
; End of function Player_InitJumpCancelState
nullsub_37:                             ; CODE XREF: Player_HandleAirState+1E   j
                                        ; Player_HandleAirState+24   j
                rts
; End of function nullsub_37


; Handles player airborne state logic
Player_HandleAirState:                              ; DATA XREF: ROM:00015070   o  ; was: sub_15408
                bset    #1,(byte_FF8244).w
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                bsr.w Player_ProcessAction
                btst    #0,6(a5)
                beq.w Player_InitFallState
                bsr.w Player_HandleSpecialMove
                bne.s   nullsub_37
                bsr.w Player_CheckSpecialMoveActivation
                bne.s   nullsub_37
                btst    #0,(byte_FF826C).w
                bne.w Player_HandleDamageKnockback
                bsr.w Player_ApplyKnockbackVelocity
                subq.w  #1,$48(a5)
                bpl.s Player_CheckAirStateTransition
                move.w  #$FFFF,$48(a5)
                btst    #4,$69(a5)
                beq.s   loc_15456
                tst.w   (word_FFA22A).w
                bne.s Player_CheckAirStateTransition
loc_15456:                              ; CODE XREF: Player_HandleAirState+46   j
                btst    #1,$69(a5)
                beq.w Player_InitAirState
; Checks conditions for transitioning between air states
Player_CheckAirStateTransition:                              ; CODE XREF: Player_HandleAirState+38   j  ; was: loc_15460
                                        ; Player_HandleAirState+4C   j
                btst    #4,$69(a5)
                beq.w Player_HandleDefeatByBoss
                bra.w   loc_170F6
; End of function Player_HandleAirState
; Initializes player air state with parameters
Player_InitAirJumpState:                              ; CODE XREF: Player_HandleLandingState+6C   j  ; was: sub_1546E
                                        ; Player_CheckWallCollisionJump+3A   j ...
                move.b  #$7F,(byte_FF830F).w
                clr.w   (word_FF8224).w
                move.w  #$A,4(a5)
                clr.w   $48(a5)
                move.w  #4,$5C(a5)
                bra.w Player_AutoFlipDirection
; End of function Player_InitAirJumpState
; Handles player movement while airborne
Player_HandleAirMovement:                              ; DATA XREF: ROM:0001506C   o  ; was: sub_1548C
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                bsr.w Player_ProcessAction
                btst    #0,6(a5)
                beq.w Player_InitFallState
                bsr.w Player_HandleSpecialMove
                bne.s   locret_15500
                bsr.w Player_CheckSpecialMoveActivation
                bne.s   locret_15500
                btst    #0,(byte_FF826C).w
                bne.w Player_HandleDamageKnockback
                btst    #1,$69(a5)
                bne.w Player_InitJumpCancelState
                bsr.w Player_ApplyKnockbackVelocity
                move.l  $18(a5),d0
                bne.s Player_SelectDeathAnimation
                btst    #2,$69(a5)
                bne.w   loc_1565C
                btst    #3,$69(a5)
                bne.w   loc_1565C
                bra.w Player_InitAirState
; ---------------------------------------------------------------------------
; Selects appropriate death animation based on player state
Player_SelectDeathAnimation:                              ; CODE XREF: Player_HandleAirMovement+3C   j  ; was: loc_154E2
                btst    #4,$69(a5)
                bne.w Player_RenderFallingSprite
                movea.l #word_E8972,a1
                movea.l #word_E89C2,a2
                moveq   #0,d5
                moveq   #6,d6
                bra.w Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
locret_15500:                           ; CODE XREF: Player_HandleAirMovement+18   j
                                        ; Player_HandleAirMovement+1E   j ...
                rts
; End of function Player_HandleAirMovement
; Initializes player landing state
Player_InitLandingState:                              ; CODE XREF: Physics_BossCollisionCheck+1E   j  ; was: sub_15502
                                        ; Player_HandleFallingState+50   j ...
                move.b  #$7F,(byte_FF830F).w
                clr.w   (word_FF8224).w
                move.w  #$16,4(a5)
                move.w  #2,$48(a5)
                move.w  #6,$4A(a5)
                move.w  #8,$5C(a5)
                move.b  #$B1,d0
                jsr (Sound_PlaySFX).l
                bra.w Player_AutoFlipDirection
; End of function Player_InitLandingState
; Handles player landing state logic
Player_HandleLandingState:                              ; DATA XREF: ROM:00015078   o  ; was: sub_15532
                bset    #1,(byte_FF8244).w
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                bsr.w Player_ProcessAction
                btst    #0,6(a5)
                beq.w Player_InitFallState
                bsr.w Player_HandleSpecialMove
                bne.s   locret_15500
                bsr.w Player_CheckSpecialMoveActivation
                bne.s   locret_15500
                btst    #0,(byte_FF826C).w
                bne.w Player_HandleDamageKnockback
                move.l  #$4000,d1
                bsr.w Player_DecelerateHorizontalVelocity
                subq.w  #1,$4A(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_155A2
                btst    #1,$69(a5)
                beq.s   loc_1558A
                bsr.w Player_InitJumpCancelState
                move.w  #$FFFF,$48(a5)
                bra.s   loc_155A2
; ---------------------------------------------------------------------------
loc_1558A:                              ; CODE XREF: Player_HandleLandingState+4A   j
                btst    #2,$69(a5)
                bne.w   loc_1565C
                btst    #3,$69(a5)
                bne.w   loc_1565C
                bra.w Player_InitAirJumpState
; ---------------------------------------------------------------------------
loc_155A2:                              ; CODE XREF: Player_HandleLandingState+42   j
                                        ; Player_HandleLandingState+56   j
                btst    #4,$69(a5)
                beq.w Player_HandleDefeatByBoss
                bra.w   loc_170F6
; End of function Player_HandleLandingState
; Handles player special move action
Player_HandleSpecialMove:                              ; CODE XREF: Player_HandleJump+18   p  ; was: sub_155B0
                                        ; Player_HandleAirState+1A   p ...
                btst    #6,$6A(a5)
                beq.s   loc_155C8
                btst    #1,$69(a5)
                bne.w Player_ToggleDirectionFlag
                tst.w   (word_FF8038).w
                bmi.s   loc_155CC
loc_155C8:                              ; CODE XREF: Player_HandleSpecialMove+6   j
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_155CC:                              ; CODE XREF: Player_HandleSpecialMove+16   j
                move.w  (word_FFA24E).w,(word_FFA220).w
                move.w  #$12,(word_FFA21C).w
                move.b  #$7F,(byte_FF830F).w
                move.w  #0,(word_FF8032).w
                move.w  #$FFEE,(word_FF8034).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$C,4(a5)
                move.w  #4,$5C(a5)
                btst    #1,$69(a5)
                beq.s Player_SetSpecialMoveDuration
                move.w  #8,$5C(a5)
; Sets duration timer for special move based on button state
Player_SetSpecialMoveDuration:                              ; CODE XREF: Player_HandleSpecialMove+54   j  ; was: loc_1560C
                moveq   #1,d0
                rts
; End of function Player_HandleSpecialMove
; Handles player grounded state with terrain and damage checks
Player_HandleGroundedState:                              ; DATA XREF: ROM:0001506E   o  ; was: sub_15610
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                bsr.w Player_ProcessAction
                btst    #0,6(a5)
                beq.w Player_InitFallState
                cmpi.w  #$12,(word_FFA21C).w
                bmi.w Player_InitAirState
                bra.w Player_ProcessCollisionDamage
; End of function Player_HandleGroundedState
; Toggles player direction flag with sound
Player_ToggleDirectionFlag:                              ; CODE XREF: Player_HandleSpecialMove+E   j  ; was: sub_15632
                                        ; Effect_SpawnDebris+10   p
                move.b  #$7F,(byte_FF830F).w
                eori.w  #2,(word_FFA22A).w
                move.b  #$A3,d0
                jsr (Sound_PlaySFX).l
                moveq   #0,d0
                rts
; End of function Player_ToggleDirectionFlag
; Checks wall collision during jump and initiates wall states
Player_CheckWallCollisionJump:                              ; CODE XREF: Player_HandleJump+4C   j  ; was: sub_1564C
                                        ; Player_HandleJump+56   j
                btst    #4,$69(a5)
                beq.s Player_InitWallBounceState
                tst.w   (word_FFA22A).w
                beq.s   loc_1566C
                rts
; ---------------------------------------------------------------------------
loc_1565C:                              ; CODE XREF: Player_HandleAirMovement+44   j
                                        ; Player_HandleAirMovement+4E   j ...
                btst    #4,$69(a5)
                beq.s Player_InitWallBounceState
                tst.w   (word_FFA22A).w
                bne.w Player_InitAirState
loc_1566C:                              ; CODE XREF: Player_CheckWallCollisionJump+C   j
                btst    #3,$69(a5)
                beq.s   loc_15680
                btst    #3,$E(a5)
                bne.w Player_InitIdleWallState
                bra.s Player_InitWallBounceState
; ---------------------------------------------------------------------------
loc_15680:                              ; CODE XREF: Player_CheckWallCollisionJump+26   j
                btst    #2,$69(a5)
                beq.w Player_InitAirJumpState
                btst    #3,$E(a5)
                beq.w Player_InitIdleWallState
; Initializes wall bounce state with velocity and direction flip
Player_InitWallBounceState:                              ; CODE XREF: Player_CheckWallCollisionJump+6   j  ; was: loc_15694
                                        ; Player_CheckWallCollisionJump+16   j ...
                move.b  #$7F,(byte_FF830F).w
                move.w  #2,4(a5)
                move.w  #4,$48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
                bra.w Player_AutoFlipDirection
; End of function Player_CheckWallCollisionJump
nullsub_38:                             ; CODE XREF: Boss_UpdateHealthBar+18   j
                                        ; Boss_UpdateHealthBar+1E   j
                rts
; End of function nullsub_38


; Updates boss health bar display
Boss_UpdateHealthBar:                              ; DATA XREF: ROM:00015064   o  ; was: sub_156B8
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                bsr.w Player_ProcessAction
                btst    #0,6(a5)
                beq.w Player_InitFallState
                bsr.w Player_HandleSpecialMove
                bne.s   nullsub_38
                bsr.w Player_CheckSpecialMoveActivation
                bne.s   nullsub_38
                btst    #0,(byte_FF826C).w
                bne.w Player_HandleDamageKnockback
                btst    #1,$69(a5)
                bne.w Player_InitJumpCancelState
                btst    #4,$69(a5)
                beq.s   loc_156FC
                tst.w   (word_FFA22A).w
                bne.w Player_InitAirJumpState
loc_156FC:                              ; CODE XREF: Boss_UpdateHealthBar+3A   j
                btst    #2,$69(a5)
                bne.s   loc_1570E
                btst    #3,$69(a5)
                beq.w Player_InitAirJumpState
loc_1570E:                              ; CODE XREF: Boss_UpdateHealthBar+4A   j
                bsr.w Physics_ApplyVerticalDecel
                btst    #4,$69(a5)
                beq.w Boss_AnimateDeathSequence
                btst    #3,$69(a5)
                beq.s   loc_15732
                btst    #3,$E(a5)
                beq.w Player_InitIdleWallState
                bra.w Player_RenderDashEffect
; ---------------------------------------------------------------------------
loc_15732:                              ; CODE XREF: Boss_UpdateHealthBar+6A   j
                btst    #3,$E(a5)
                bne.w Player_InitIdleWallState
                bra.w Player_RenderDashEffect
; ---------------------------------------------------------------------------
; Initializes idle wall cling state with cleared velocity
Player_InitIdleWallState:                              ; CODE XREF: Player_CheckWallCollisionJump+2E   j  ; was: loc_15740
                                        ; Player_CheckWallCollisionJump+44   j ...
                move.w  #4,4(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #4,$5C(a5)
locret_15756:                           ; CODE XREF: Player_AirAttackState+18   j
                                        ; Player_AirAttackState+1E   j
                rts
; End of function Boss_UpdateHealthBar
; Player air attack state handler processing jump cancels and directional attacks
Player_AirAttackState:                              ; DATA XREF: ROM:00015066   o  ; was: sub_15758
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                bsr.w Player_ProcessAction
                btst    #0,6(a5)
                beq.w Player_InitFallState
                bsr.w Player_HandleSpecialMove
                bne.s   locret_15756
                bsr.w Player_CheckSpecialMoveActivation
                bne.s   locret_15756
                btst    #1,$69(a5)
                bne.w Player_InitJumpCancelState
                btst    #4,$69(a5)
                beq.w Player_InitWallBounceState
                bsr.w Player_PrepareWeaponSprite
                btst    #2,$69(a5)
                beq.s   loc_157A6
                btst    #3,$E(a5)
                beq.w Player_InitWallBounceState
                bra.w Physics_ApplyDownwardGravity
; ---------------------------------------------------------------------------
loc_157A6:                              ; CODE XREF: Player_AirAttackState+3E   j
                btst    #3,$69(a5)
                beq.w Player_InitAirJumpState
                btst    #3,$E(a5)
                bne.w Player_InitWallBounceState
                bra.w Physics_ApplyUpwardGravity
; End of function Player_AirAttackState
; Initializes Phoenix weapon attack
Player_InitPhoenixAttack:
                move.w  #$56,4(a5) ; 'V'  ; was: sub_157BE
                move.w  #8,$4E(a5)
                move.b  #$73,(byte_FF830F).w ; 's'
                jsr (Sys_ClearObjectBufferSmall).l
                move.b  #1,(word_FF8224).w
                move.b  #1,(word_FF8224+1).w
                move.w  #$C,$50(a5)
                clr.w   $12(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                btst    #2,$69(a5)
                bne.s   loc_1580C
                btst    #3,$69(a5)
                bne.s   loc_1581C
                btst    #3,$E(a5)
                bne.s   loc_1581C
loc_1580C:                              ; CODE XREF: Player_InitPhoenixAttack+3C   j
                move.l  #$FFF88000,$48(a5)
                bclr    #3,$E(a5)
                bra.s   loc_1582A
; ---------------------------------------------------------------------------
loc_1581C:                              ; CODE XREF: Player_InitPhoenixAttack+44   j
                                        ; Player_InitPhoenixAttack+4C   j
                move.l  #$78000,$48(a5)
                bset    #3,$E(a5)
loc_1582A:                              ; CODE XREF: Player_InitPhoenixAttack+5C   j
                move.l  #word_E86AA,8(a5)
                bsr.w Player_SpawnPhoenixTrails
                moveq   #1,d0
                rts
; End of function Player_InitPhoenixAttack
; Updates Phoenix attack state
Player_PhoenixAttackUpdate:                              ; DATA XREF: ROM:000150B8   o  ; was: sub_1583A
                btst    #5,$6A(a5)
                beq.s   loc_15848
                move.w  #7,$50(a5)
loc_15848:                              ; CODE XREF: Player_PhoenixAttackUpdate+6   j
                subq.w  #1,$4E(a5)
                bpl.w   loc_158A0
                jsr (Sys_ClearObjectBufferSmall).l
                clr.w   $4E(a5)
                cmpi.w  #7,$50(a5)
                beq.s   loc_15866
                addq.w  #2,$4E(a5)
loc_15866:                              ; CODE XREF: Player_PhoenixAttackUpdate+26   j
                move.w  #$10,4(a5)
                btst    #4,$E(a5)
                beq.s   loc_1587A
                move.w  #$24,4(a5) ; '$'
loc_1587A:                              ; CODE XREF: Player_PhoenixAttackUpdate+38   j
                tst.w   (word_FF8304).w
                bne.s   loc_15896
                btst    #7,(byte_FF8245).w
                bne.s   loc_15896
                move.l  #word_E8E6A,8(a5)
                bsr.w Player_SpawnProjectile
                bra.s   loc_158A0
; ---------------------------------------------------------------------------
loc_15896:                              ; CODE XREF: Player_PhoenixAttackUpdate+44   j
                                        ; Player_PhoenixAttackUpdate+4C   j
                move.b  #$A6,d0
                jsr (Sound_PlaySFX).l
loc_158A0:                              ; CODE XREF: Player_PhoenixAttackUpdate+12   j
                                        ; Player_PhoenixAttackUpdate+5A   j
                move.w  #1,(word_FF809C).w
                bset    #6,$21(a5)
                bset    #4,$23(a5)
                bset    #4,(byte_FF8244).w
                clr.w   6(a5)
                bsr.w Player_TerrainCheckFlipped
                bsr.w Player_DirectionDispatcher
                rts
; End of function Player_PhoenixAttackUpdate
; Spawns two Phoenix trail objects
Player_SpawnPhoenixTrails:                              ; CODE XREF: Player_InitPhoenixAttack+74   p  ; was: sub_158C6
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                moveq   #0,d7
                bsr.s Player_InitPhoenixTrail
                lea     $60(a0),a0
                addq.w  #2,d7
; End of function Player_SpawnPhoenixTrails
; Initializes single Phoenix trail
Player_InitPhoenixTrail:                              ; CODE XREF: Player_SpawnPhoenixTrails+6   p  ; was: sub_158D4
                move.w  #$10,(a0)
                clr.b   $21(a0)
                move.w  #$C800,2(a0)
                move.l  #word_E8680,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                bpl.s   loc_15906
                clr.b   $20(a0)
loc_15906:                              ; CODE XREF: Player_InitPhoenixTrail+2C   j
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                clr.w   $1A(a0)
                move.w  word_15926(pc,d7.w),d0
                add.w   d0,$10(a0)
                move.w  word_15926+4(pc,d7.w),$18(a0)
                rts
; End of function Player_InitPhoenixTrail
; ---------------------------------------------------------------------------
word_15926:     dc.w $20, $FFE0, $FFF8, 8
                                        ; DATA XREF: Player_InitPhoenixTrail+42   r
                                        ; Player_InitPhoenixTrail+4A   r


; Initializes player dash attack with direction and projectile
Player_InitiateDashAttack:                              ; CODE XREF: Player_CheckDashInput+E   j  ; was: sub_1592E
                                        ; Player_ProcessAirState+34   j
                move.w  #$24,4(a5) ; '$'
                bra.s   loc_1593C
; ---------------------------------------------------------------------------
loc_15936:                              ; CODE XREF: Physics_ApplyBossVelocity+20   j
                                        ; Player_CheckSpecialMoveActivation+1A   j ...
                move.w  #$10,4(a5)
loc_1593C:                              ; CODE XREF: Player_InitiateDashAttack+6   j
                move.b  #$73,(byte_FF830F).w ; 's'
                jsr (Sys_ClearObjectBufferSmall).l
                move.b  #1,(word_FF8224).w
                move.b  #1,(word_FF8224+1).w
                clr.w   $4E(a5)
                move.w  #$C,$50(a5)
                clr.w   $12(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                btst    #2,$69(a5)
                bne.s   loc_15982
                btst    #3,$69(a5)
                bne.s   loc_15992
                btst    #3,$E(a5)
                bne.s   loc_15992
loc_15982:                              ; CODE XREF: Player_InitiateDashAttack+42   j
                move.l  #$FFF88000,$48(a5)
                bclr    #3,$E(a5)
                bra.s   loc_159A0
; ---------------------------------------------------------------------------
loc_15992:                              ; CODE XREF: Player_InitiateDashAttack+4A   j
                                        ; Player_InitiateDashAttack+52   j
                move.l  #$78000,$48(a5)
                bset    #3,$E(a5)
loc_159A0:                              ; CODE XREF: Player_InitiateDashAttack+62   j
                tst.w   (word_FF8304).w
                bne.s Player_PlayDashAttackSound
                btst    #7,(byte_FF8245).w
                bne.s Player_PlayDashAttackSound
                bsr.w Player_SpawnProjectile
                move.l  #word_E8E6A,8(a5)
                move.w  #$78,(word_FF8304).w ; 'x'
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
; Plays dash attack sound effect and sets animation pointer
Player_PlayDashAttackSound:                              ; CODE XREF: Player_InitiateDashAttack+76   j  ; was: loc_159C4
                                        ; Player_InitiateDashAttack+7E   j
                move.b  #$A6,d0
                jsr (Sound_PlaySFX).l
                move.l  #word_E86AA,8(a5)
                move.w  #$78,(word_FF8304).w ; 'x'
                moveq   #1,d0
                rts
; End of function Player_InitiateDashAttack
; Handles dash cancel state and timer management
Player_HandleDashCancel:                              ; DATA XREF: ROM:00015072   o  ; was: sub_159E0
                                        ; ROM:00015086   o
                tst.b   (byte_FF8311).w
                bne.s   loc_159F0
                subq.w  #1,$50(a5)
                bmi.s   loc_159F0
                bra.w   loc_15A6E
; ---------------------------------------------------------------------------
loc_159F0:                              ; CODE XREF: Player_HandleDashCancel+4   j
                                        ; Player_HandleDashCancel+A   j
                bsr.w Player_DirectionDispatcher
loc_159F4:                              ; CODE XREF: Player_HandleDashCancel:loc_15A6C   j
                clr.w   (word_FFC5C0).w
                bclr    #0,(byte_FF826C).w
                bclr    #6,$21(a5)
                bclr    #4,$23(a5)
                moveq   #0,d0
                btst    #4,$E(a5)
                beq.s   loc_15A16
                moveq   #1,d0
loc_15A16:                              ; CODE XREF: Player_HandleDashCancel+32   j
                btst    d0,6(a5)
                bne.s   loc_15A46
                move.w  #$FFE0,$52(a5)
                move.l  $48(a5),$18(a5)
                tst.w   $4E(a5)
                beq.s   loc_15A38
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
loc_15A38:                              ; CODE XREF: Player_HandleDashCancel+4C   j
                btst    #4,$E(a5)
                beq.w   loc_15C3C
                bra.w Player_InitAirDashEnd
; ---------------------------------------------------------------------------
loc_15A46:                              ; CODE XREF: Player_HandleDashCancel+3A   j
                clr.w   (word_FF8224).w
                tst.w   $4E(a5)
                bne.s   loc_15A5E
                btst    #4,$E(a5)
                beq.w Player_InitSlideState
                bra.w Player_InitSlideState
; ---------------------------------------------------------------------------
loc_15A5E:                              ; CODE XREF: Player_HandleDashCancel+6E   j
                btst    #4,$E(a5)
                beq.w Player_InitJumpCancelCleanup
                bra.w Player_InitDashAnimation
; ---------------------------------------------------------------------------
loc_15A6C:                              ; CODE XREF: Player_HandleDashCancel+A4   j
                                        ; Player_HandleDashCancel+AA   j ...
                bra.s   loc_159F4
; ---------------------------------------------------------------------------
loc_15A6E:                              ; CODE XREF: Player_HandleDashCancel+C   j
                move.w  #1,(word_FF809C).w
                bset    #6,$21(a5)
                bset    #4,$23(a5)
                bsr.w Player_ApplyHorizontalMovement
                bne.s   loc_15A6C
                bsr.w Player_ApplyHorizontalMovement
                bne.s   loc_15A6C
                bsr.w Player_ApplyHorizontalMovement
                bne.s   loc_15A6C
                bset    #4,(byte_FF8244).w
                bra.w Effect_CreateDashTrail
; End of function Player_HandleDashCancel
; Applies horizontal movement with boundary checking
Player_ApplyHorizontalMovement:                              ; CODE XREF: Player_HandleDashCancel+A0   p  ; was: sub_15A9C
                                        ; Player_HandleDashCancel+A6   p ...
                clr.w   6(a5)
                bsr.w Player_TerrainCheckFlipped
                bsr.w Player_DirectionDispatcher
                tst.w   $48(a5)
                bmi.s   loc_15AB8
                btst    #1,7(a5)
                beq.s   loc_15AC0
                rts
; ---------------------------------------------------------------------------
loc_15AB8:                              ; CODE XREF: Player_ApplyHorizontalMovement+10   j
                btst    #0,7(a5)
                bne.s   locret_15AF2
loc_15AC0:                              ; CODE XREF: Player_ApplyHorizontalMovement+18   j
                move.l  $48(a5),d0
                add.l   d0,$10(a5)
                btst    #1,(byte_FF8245).w
                bne.s   loc_15AF0
                cmpi.w  #$1AF,$10(a5)
                bmi.s   loc_15AE2
                move.w  #$1AF,$10(a5)
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_15AE2:                              ; CODE XREF: Player_ApplyHorizontalMovement+3A   j
                cmpi.w  #$90,$10(a5)
                bpl.s   loc_15AF0
                move.w  #$90,$10(a5)
loc_15AF0:                              ; CODE XREF: Player_ApplyHorizontalMovement+32   j
                                        ; Player_ApplyHorizontalMovement+4C   j
                moveq   #0,d0
locret_15AF2:                           ; CODE XREF: Player_ApplyHorizontalMovement+22   j
                rts
; End of function Player_ApplyHorizontalMovement
; Initializes player slide knockback state
Player_InitSlideState:                              ; CODE XREF: Player_HandleDashCancel+76   j  ; was: sub_15AF4
                                        ; Player_HandleDashCancel+7A   j ...
                move.b  #$7F,(byte_FF830F).w
                move.w  #$40,4(a5) ; '@'
                move.w  #4,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                tst.w   $48(a5)
                bmi.s   loc_15B18
                neg.l   $18(a5)
loc_15B18:                              ; CODE XREF: Player_InitSlideState+1E   j
                move.w  #2,$48(a5)
                rts
; End of function Player_InitSlideState
; Handles player slide knockback state
Player_HandleSlideState:                              ; DATA XREF: ROM:000150A2   o  ; was: sub_15B20
                                        ; ROM:000150A4   o
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                bsr.w Player_DirectionDispatcher
                moveq   #0,d0
                btst    #4,$E(a5)
                beq.s   loc_15B36
                moveq   #1,d0
loc_15B36:                              ; CODE XREF: Player_HandleSlideState+12   j
                btst    d0,6(a5)
                beq.w Player_InitFallState
                move.l  #$4000,d1
                bsr.w Player_DecelerateHorizontalVelocity
                tst.l   $18(a5)
                bne.s   loc_15B5C
                btst    #4,$E(a5)
                beq.w Player_InitJumpCancelCleanup
                bra.w Player_InitDashAnimation
; ---------------------------------------------------------------------------
loc_15B5C:                              ; CODE XREF: Player_HandleSlideState+2C   j
                subq.w  #1,$48(a5)
                bra.w Player_HandleDefeatByBoss
; End of function Player_HandleSlideState
nullsub_39:
                rts
; End of function nullsub_39


; Initializes dash kick with velocity
Player_InitDashKick:
                move.w  #$44,4(a5) ; 'D'  ; was: sub_15B66
                move.w  #4,$5C(a5)
                bclr    #4,$E(a5)
                move.l  #$FFFCE000,$18(a5)
                tst.w   $48(a5)
                bmi.s   locret_15B8A
                neg.l   $18(a5)
locret_15B8A:                           ; CODE XREF: Player_InitDashKick+1E   j
                rts
; End of function Player_InitDashKick
; Handles dash kick with gravity
Player_DashKickState:                              ; DATA XREF: ROM:000150A6   o  ; was: sub_15B8C
                jsr Physics_BossTerrainWrapper(pc)   ; (pc)
                nop
                addi.l  #$8800,$1C(a5)
                bsr.w Player_UpdateTerrainCheck
                btst    #0,6(a5)
                beq.s   locret_15BB6
                bsr.w Player_InitSlideState
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
locret_15BB6:                           ; CODE XREF: Player_DashKickState+18   j
                rts
; End of function Player_DashKickState
; Checks and activates special move from state flags
Player_CheckSpecialMoveActivation:                              ; CODE XREF: Player_HandleJump+1E   p  ; was: sub_15BB8
                                        ; Player_HandleAirState+20   p ...
                btst    #5,$6A(a5)
                beq.s   locret_15C1E
                btst    #1,$69(a5)
                beq.w   loc_15BF2
                move.b  $69(a5),d0
                andi.b  #$C,d0
                bne.w   loc_15936
                btst    #6,(byte_FF8245).w
                bne.w   loc_15936
                btst    #2,6(a5)
                beq.w   loc_15936
                bsr.w Player_GustheadBossIntro
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
loc_15BF2:                              ; CODE XREF: Player_CheckSpecialMoveActivation+E   j
                move.w  #8,4(a5)
                move.l  #$FFFA8000,$1C(a5)
                move.w  #$C,$5C(a5)
                move.w  #5,$48(a5)
                clr.w   $4A(a5)
                clr.w   (word_FF8224).w
                clr.w   $52(a5)
                move.b  #$7F,(byte_FF830F).w
locret_15C1E:                           ; CODE XREF: Player_CheckSpecialMoveActivation+6   j
                                        ; Player_CheckDashInput+6   j
                rts
; End of function Player_CheckSpecialMoveActivation
; Checks controller input for dash attack activation
Player_CheckDashInput:                              ; CODE XREF: Player_HandleDashState+20   p  ; was: sub_15C20
                                        ; Player_HandleCrouchState+1C   p ...
                btst    #5,$6A(a5)
                beq.s   locret_15C1E
                btst    #0,$69(a5)
                bne.w Player_InitiateDashAttack
                bra.s Sprite_PositionBossParts
; End of function Player_CheckDashInput
; Initializes player falling state with parameters
Player_InitFallState:                              ; CODE XREF: Player_HandleJump+10   j  ; was: sub_15C34
                                        ; Player_HandleAirState+16   j ...
                clr.w   (word_FF8224).w
                clr.w   $52(a5)
loc_15C3C:                              ; CODE XREF: Player_DefeatGroundedState+18   j
                                        ; Player_HandleDashCancel+5E   j ...
                bclr    #0,(byte_FF826C).w
                move.w  #6,4(a5)
                bclr    #4,$E(a5)
                move.w  #$C,$5C(a5)
                move.w  #$FFFF,$48(a5)
                clr.w   $4A(a5)
                move.b  #$7F,(byte_FF830F).w
                rts
; End of function Player_InitFallState
; Positions multiple boss sprite parts
Sprite_PositionBossParts:                              ; CODE XREF: Player_CheckDashInput+12   j  ; was: sub_15C66
                bsr.s Player_EndDashState
                move.l  #$20000,$1C(a5)
                rts
; End of function Sprite_PositionBossParts
; Ends dash attack and transitions to air state
Player_EndDashState:                              ; CODE XREF: Sprite_PositionBossParts   p  ; was: sub_15C72
                                        ; Player_HandleDashState+12   j ...
                clr.w   (word_FF8224).w
                clr.w   $52(a5)
; Initializes end of air dash with gravity and velocity setup
Player_InitAirDashEnd:                              ; CODE XREF: Player_HandleDashCancel+62   j  ; was: loc_15C7A
                bclr    #0,(byte_FF826C).w
                move.w  #$28,4(a5) ; '('
                bclr    #4,$E(a5)
                move.w  #$C,$5C(a5)
                move.l  #$12000,$1C(a5)
                move.w  #$FFFF,$48(a5)
                clr.w   $4A(a5)
                move.b  #$7F,(byte_FF830F).w
                rts
; End of function Player_EndDashState
; Player intro state for Gusthead
Player_GustheadBossIntro:                              ; CODE XREF: Player_CheckSpecialMoveActivation+32   p  ; was: sub_15CAC
                bclr    #0,(byte_FF826C).w
                move.w  #$FFE0,$52(a5)
                move.w  #$14,4(a5)
                move.l  #$3A000,$1C(a5)
                move.w  #$C,$5C(a5)
                move.w  #$FFFF,$48(a5)
                move.w  #4,$4A(a5)
                clr.w   (word_FF8224).w
                move.b  #$7F,(byte_FF830F).w
                rts
; End of function Player_GustheadBossIntro
; Handles player falling state with gravity
Player_HandleFallingState:                              ; CODE XREF: Player_DefeatState+2E   j  ; was: sub_15CE4
                                        ; DATA XREF: ROM:00015068   o ...
                bset    #0,(byte_FF8244).w
                btst    #5,$69(a5)
                bne.s   loc_15CF8
                move.w  #$FFFF,$48(a5)
loc_15CF8:                              ; CODE XREF: Player_HandleFallingState+C   j
                tst.w   $48(a5)
                bmi.s   loc_15D0A
                subq.w  #1,$48(a5)
                tst.l   $1C(a5)
                bmi.s   loc_15D3A
                bpl.s   loc_15D1E
loc_15D0A:                              ; CODE XREF: Player_HandleFallingState+18   j
                addi.l  #$8800,$1C(a5)
loc_15D12:                              ; CODE XREF: Player_HandleDeathSequence+11C   j
                                        ; Player_HandleDeathSequence+128   j
                jsr Physics_BossTerrainWrapper(pc)   ; (pc)
                nop
                tst.w   $1C(a5)
                bmi.s   loc_15D3A
loc_15D1E:                              ; CODE XREF: Player_HandleFallingState+24   j
                tst.w   $4A(a5)
                bmi.s   loc_15D2A
                subq.w  #1,$4A(a5)
                bra.s   loc_15D60
; ---------------------------------------------------------------------------
loc_15D2A:                              ; CODE XREF: Player_HandleFallingState+3E   j
                bsr.w Player_UpdateTerrainCheck
                btst    #0,6(a5)
                bne.w Player_InitLandingState
                bra.s   loc_15D60
; ---------------------------------------------------------------------------
loc_15D3A:                              ; CODE XREF: Player_HandleFallingState+22   j
                                        ; Player_HandleFallingState+38   j
                clr.b   6(a5)
                jsr Player_TerrainCheckAlternate(pc)   ; (pc)
                nop
                btst    #1,6(a5)
                bne.w Player_InitiateLanding
                btst    #2,6(a5)
                beq.s   loc_15D60
                btst    #0,$69(a5)
                bne.w Player_InitHardLanding
loc_15D60:                              ; CODE XREF: Player_HandleFallingState+44   j
                                        ; Player_HandleFallingState+54   j ...
                btst    #0,(byte_FF826C).w
                bne.w Player_InitDeathKnockback
                btst    #5,$6A(a5)
                beq.s   loc_15D8E
                btst    #1,$69(a5)
                bne.s   loc_15D84
                tst.b   (word_FF8224+1).w
                bne.s   loc_15D8E
                bra.w Player_InitSpecialAttack
; ---------------------------------------------------------------------------
loc_15D84:                              ; CODE XREF: Player_HandleFallingState+94   j
                tst.b   (word_FF8224).w
                bne.s   loc_15D8E
                bra.w   loc_15936
; ---------------------------------------------------------------------------
loc_15D8E:                              ; CODE XREF: Player_HandleFallingState+8C   j
                                        ; Player_HandleFallingState+9A   j ...
                tst.w   $52(a5)
                bne.s   loc_15D9E
                btst    #4,$69(a5)
                bne.w   loc_15DBE
loc_15D9E:                              ; CODE XREF: Player_HandleFallingState+AE   j
                bsr.w Player_ApplyAirControl
                move.w  #2,d1
                tst.w   $52(a5)
                bne.w Player_UpdateAnimationState
                bsr.w Gfx_DrawBossHealthUI
                bsr.w Player_SelectFallAnimation
                moveq   #0,d5
                moveq   #0,d6
                bra.w Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
loc_15DBE:                              ; CODE XREF: Player_HandleFallingState+B6   j
                btst    #2,$69(a5)
                beq.s   loc_15DF0
loc_15DC6:                              ; CODE XREF: Player_HandleFallingState+144   j
                move.l  #$FFFC8000,d1
                btst    #3,$E(a5)
                beq.s   loc_15DDA
                move.l  #$FFFD4000,d1
loc_15DDA:                              ; CODE XREF: Player_HandleFallingState+EE   j
                move.l  $18(a5),d0
                bpl.s   loc_15DE8
                cmp.l   d1,d0
                bpl.s   loc_15DE8
                move.l  d1,d0
                bra.s   loc_15E2A
; ---------------------------------------------------------------------------
loc_15DE8:                              ; CODE XREF: Player_HandleFallingState+FA   j
                                        ; Player_HandleFallingState+FE   j
                subi.l  #$7777,d0
                bra.s   loc_15E2A
; ---------------------------------------------------------------------------
loc_15DF0:                              ; CODE XREF: Player_HandleFallingState+E0   j
                btst    #3,$69(a5)
                beq.s   loc_15E22
loc_15DF8:                              ; CODE XREF: Player_HandleFallingState+142   j
                move.l  #$38000,d1
                btst    #3,$E(a5)
                bne.s   loc_15E0C
                move.l  #$2C000,d1
loc_15E0C:                              ; CODE XREF: Player_HandleFallingState+120   j
                move.l  $18(a5),d0
                bmi.s   loc_15E1A
                cmp.l   d1,d0
                bmi.s   loc_15E1A
                move.l  d1,d0
                bra.s   loc_15E2A
; ---------------------------------------------------------------------------
loc_15E1A:                              ; CODE XREF: Player_HandleFallingState+12C   j
                                        ; Player_HandleFallingState+130   j
                addi.l  #$7777,d0
                bra.s   loc_15E2A
; ---------------------------------------------------------------------------
loc_15E22:                              ; CODE XREF: Player_HandleFallingState+112   j
                move.l  $18(a5),d0
                bmi.s   loc_15DF8
                bne.s   loc_15DC6
loc_15E2A:                              ; CODE XREF: Player_HandleFallingState+102   j
                                        ; Player_HandleFallingState+10A   j ...
                move.l  d0,$18(a5)
                bsr.w Player_SelectFallAnimation
                lea     (word_198D2).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #3,d6
                bra.w Sprite_PrepareRendering
; End of function Player_HandleFallingState
; Draws boss health UI elements
Gfx_DrawBossHealthUI:                              ; CODE XREF: Player_HandleFallingState+CA   p  ; was: sub_15E40
                tst.w   $1C(a5)
                bmi.s   loc_15E56
                cmpi.w  #3,$1C(a5)
                bmi.s   loc_15E56
                movea.l #word_E8C9A,a1
                rts
; ---------------------------------------------------------------------------
loc_15E56:                              ; CODE XREF: Gfx_DrawBossHealthUI+4   j
                                        ; Gfx_DrawBossHealthUI+C   j
                movea.l #word_E8C82,a1
                rts
; End of function Gfx_DrawBossHealthUI
; Selects animation based on falling velocity
Player_SelectFallAnimation:                              ; CODE XREF: Player_HandleFallingState+CE   p  ; was: sub_15E5E
                                        ; Player_HandleFallingState+14A   p
                move.w  $1C(a5),d0
                bpl.s   loc_15E66
                neg.w   d0
loc_15E66:                              ; CODE XREF: Player_SelectFallAnimation+4   j
                cmpi.w  #7,d0
                bpl.s   loc_15E80
                cmpi.w  #2,d0
                bmi.s   loc_15E80
                tst.w   $1C(a5)
                bmi.s   loc_15E88
                movea.l #word_E8C6A,a2
                rts
; ---------------------------------------------------------------------------
loc_15E80:                              ; CODE XREF: Player_SelectFallAnimation+C   j
                                        ; Player_SelectFallAnimation+12   j
                movea.l #word_E8C2A,a2
                rts
; ---------------------------------------------------------------------------
loc_15E88:                              ; CODE XREF: Player_SelectFallAnimation+18   j
                movea.l #word_E8C52,a2
                rts
; End of function Player_SelectFallAnimation
; Initializes hard landing state with terrain alignment and downward velocity
Player_InitHardLanding:                              ; CODE XREF: Player_HandleFallingState+78   j  ; was: sub_15E90
                jsr (Physics_AlignToTerrain).l
                move.w  #$12,4(a5)
                move.l  #$FFF86000,$1C(a5)
                clr.l   $18(a5)
                move.w  #6,$52(a5)
                move.b  #$7F,(byte_FF830F).w
                rts
; End of function Player_InitHardLanding
; Handles bounce state with gravity and terrain collision checks
Player_HandleBounceState:                              ; DATA XREF: ROM:00015074   o  ; was: sub_15EB6
                bset    #0,(byte_FF8244).w
                addi.l  #$8800,$1C(a5)
                jsr Physics_BossTerrainWrapper(pc)   ; (pc)
                nop
                tst.w   $1C(a5)
                bmi.s   loc_15EE0
                bsr.w Player_UpdateTerrainCheck
                btst    #0,6(a5)
                bne.w Player_InitLandingState
                bra.s   loc_15EF4
; ---------------------------------------------------------------------------
loc_15EE0:                              ; CODE XREF: Player_HandleBounceState+18   j
                clr.b   6(a5)
                jsr Player_TerrainCheckAlternate(pc)   ; (pc)
                nop
                btst    #1,6(a5)
                bne.w Player_InitiateLanding
loc_15EF4:                              ; CODE XREF: Player_HandleBounceState+28   j
                cmpi.w  #$38,$52(a5) ; '8'
                bpl.w Player_InitFallState
                moveq   #2,d1
                bra.w Anim_SelectFrameData
; End of function Player_HandleBounceState
; Applies horizontal air control input
Player_ApplyAirControl:                              ; CODE XREF: Player_HandleFallingState:loc_15D9E   p  ; was: sub_15F04
                btst    #2,$69(a5)
                beq.s   loc_15F30
                bclr    #3,$E(a5)
                move.l  $18(a5),d0
                bpl.s   loc_15F28
                cmpi.l  #$FFFC8000,d0
                bpl.s   loc_15F28
                move.l  #$FFFC8000,d0
                bra.s Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
loc_15F28:                              ; CODE XREF: Player_ApplyAirControl+12   j
                                        ; Player_ApplyAirControl+1A   j ...
                subi.l  #$7777,d0
                bra.s Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
loc_15F30:                              ; CODE XREF: Player_ApplyAirControl+6   j
                btst    #3,$69(a5)
                beq.s   loc_15F5C
                bset    #3,$E(a5)
                move.l  $18(a5),d0
                bmi.s   loc_15F54
                cmpi.l  #$38000,d0
                bmi.s   loc_15F54
                move.l  #$38000,d0
                bra.s Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
loc_15F54:                              ; CODE XREF: Player_ApplyAirControl+3E   j
                                        ; Player_ApplyAirControl+46   j ...
                addi.l  #$7777,d0
                bra.s Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
loc_15F5C:                              ; CODE XREF: Player_ApplyAirControl+32   j
                move.l  $18(a5),d0
                bmi.s   loc_15F54
                bne.s   loc_15F28
; Applies calculated horizontal velocity to player position
Player_ApplyHorizontalVelocity:                              ; CODE XREF: Player_ApplyAirControl+22   j  ; was: loc_15F64
                                        ; Player_ApplyAirControl+2A   j ...
                move.l  d0,$18(a5)
                rts
; End of function Player_ApplyAirControl
; Initializes special attack state
Player_InitSpecialAttack:                              ; CODE XREF: Player_HandleFallingState+9C   j  ; was: sub_15F6A
                bclr    #0,(byte_FF826C).w
                move.b  #$7F,(byte_FF830F).w
                move.w  #$4E,4(a5) ; 'N'
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
                move.l  #$FFFE8000,$1C(a5)
                move.w  #$C,$5C(a5)
                move.w  #$FFFF,$48(a5)
                clr.w   $4A(a5)
                move.w  #5,$4C(a5)
                move.b  #1,(word_FF8224+1).w
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                moveq   #7,d7
                jsr (Sys_ClearMemoryBlock).l
                move.b  #$B0,d0
                jsr (Sound_PlaySFX).l
                bra.w Player_SpawnTripleShot
; End of function Player_InitSpecialAttack
; Handles special attack state logic
Player_HandleSpecialAttack:                              ; DATA XREF: ROM:000150B0   o  ; was: sub_15FC4
                subq.w  #1,$4C(a5)
                bpl.s   loc_15FE0
                move.w  #$46,4(a5) ; 'F'
                clr.l   $18(a5)
                clr.l   $1C(a5)
                bsr.w Player_AutoFlipDirection
                bra.w Effect_UpdateParticles
; ---------------------------------------------------------------------------
loc_15FE0:                              ; CODE XREF: Player_HandleSpecialAttack+4   j
                bset    #0,(byte_FF8244).w
                bset    #6,(byte_FF8244).w
                jsr Physics_BossTerrainWrapper(pc)   ; (pc)
                nop
                addi.l  #$C000,$1C(a5)
                bmi.s   loc_16010
                clr.b   6(a5)
                bsr.w Player_UpdateTerrainCheck
                btst    #0,6(a5)
                bne.w Player_InitLandingState
                bra.s   loc_16022
; ---------------------------------------------------------------------------
loc_16010:                              ; CODE XREF: Player_HandleSpecialAttack+36   j
                clr.b   6(a5)
                bsr.w Player_TerrainCheckAlternate
                btst    #1,6(a5)
                bne.w Player_InitiateLanding
loc_16022:                              ; CODE XREF: Player_HandleSpecialAttack+4A   j
                btst    #0,(byte_FF826C).w
                bne.w Player_InitDeathKnockback
                btst    #5,$6A(a5)
                beq.s   loc_16056
                tst.b   (word_FF8224).w
                bne.s   loc_16044
                btst    #1,$69(a5)
                bne.w   loc_15936
loc_16044:                              ; CODE XREF: Player_HandleSpecialAttack+74   j
                move.l  #$FFF80000,$1C(a5)
                move.w  #$FFE0,$52(a5)
                bra.w   loc_15C3C
; ---------------------------------------------------------------------------
loc_16056:                              ; CODE XREF: Player_HandleSpecialAttack+6E   j
                movea.l #word_E8F3A,a2
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1606A
                movea.l #word_E8F6A,a2
loc_1606A:                              ; CODE XREF: Player_HandleSpecialAttack+9E   j
                btst    #4,$69(a5)
                bne.w Player_RenderDeathEffect
                bsr.w Player_UpdateHorizontalFacing
                movea.l #word_E8972,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                bra.w Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
; Renders death effect particles using animation data
Player_RenderDeathEffect:                              ; CODE XREF: Player_HandleSpecialAttack+AC   j  ; was: loc_16086
                lea     (word_198B2).l,a4
                moveq   #0,d5
                moveq   #$FFFFFFFF,d6
                lea     off_172F8(pc),a0
                nop
                bra.w   loc_1727A
; End of function Player_HandleSpecialAttack
; Updates particle effects for explosions
Effect_UpdateParticles:                              ; CODE XREF: Player_HandleSpecialAttack+18   j  ; was: sub_1609A
                                        ; DATA XREF: ROM:000150A8   o
                bset    #0,(byte_FF8244).w
                bset    #6,(byte_FF8244).w
                jsr Physics_BossTerrainWrapper(pc)   ; (pc)
                nop
                clr.b   6(a5)
                bsr.w Player_UpdateTerrainCheck
                btst    #0,6(a5)
                bne.w Player_InitLandingState
                clr.b   6(a5)
                bsr.w Player_TerrainCheckAlternate
                btst    #1,6(a5)
                bne.w Player_InitiateLanding
                bsr.w Effect_SpawnDebris
                bne.w   nullsub_40
                btst    #0,(byte_FF826C).w
                bne.w Player_InitDeathKnockback
                btst    #5,$6A(a5)
                beq.s Player_CheckSpecialAttack
                tst.b   (word_FF8224).w
                bne.s   loc_160FA
                btst    #1,$69(a5)
                bne.w   loc_15936
loc_160FA:                              ; CODE XREF: Effect_UpdateParticles+54   j
                move.l  #$FFF80000,$1C(a5)
                bra.s   loc_1610C
; End of function Effect_UpdateParticles
; Sets upward velocity for air recovery
Player_InitAirRecovery:
                move.l  #$FFFD8000,$1C(a5)  ; was: sub_16104
loc_1610C:                              ; CODE XREF: Effect_UpdateParticles+68   j
                move.w  #$FFE0,$52(a5)
                bra.w   loc_15C3C
; End of function Player_InitAirRecovery
; Checks if player can use special attack
Player_CheckSpecialAttack:                              ; CODE XREF: Effect_UpdateParticles+4E   j  ; was: sub_16116
                movea.l #word_E8F3A,a2
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1612A
                movea.l #word_E8F6A,a2
loc_1612A:                              ; CODE XREF: Player_CheckSpecialAttack+C   j
                btst    #4,$69(a5)
                bne.w   loc_16146
                bsr.w Player_UpdateHorizontalFacing
                movea.l #word_E8972,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                bra.w Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
loc_16146:                              ; CODE XREF: Player_CheckSpecialAttack+1A   j
                lea     (word_198B2).l,a4
                moveq   #0,d5
                moveq   #$FFFFFFFF,d6
                lea     off_172F8(pc),a0
                nop
                bra.w   loc_1727A
; End of function Player_CheckSpecialAttack
nullsub_40:                             ; CODE XREF: Effect_UpdateParticles+3A   j
                rts
; End of function nullsub_40


; Spawns debris particles from boss damage
Effect_SpawnDebris:                              ; CODE XREF: Effect_UpdateParticles+36   p  ; was: sub_1615C
                btst    #6,$6A(a5)
                beq.s   loc_1617A
                btst    #1,$69(a5)
                beq.s   loc_16174
                bsr.w Player_ToggleDirectionFlag
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_16174:                              ; CODE XREF: Effect_SpawnDebris+E   j
                tst.w   (word_FF8038).w
                bmi.s Player_InitVictoryState
loc_1617A:                              ; CODE XREF: Effect_SpawnDebris+6   j
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
; Initializes victory state with palette change and position setup
Player_InitVictoryState:                              ; CODE XREF: Effect_SpawnDebris+1C   j  ; was: loc_1617E
                move.w  (word_FFA24E).w,(word_FFA220).w
                move.w  #$12,(word_FFA21C).w
                move.b  #$7F,(byte_FF830F).w
                move.w  #0,(word_FF8032).w
                move.w  #$FFEE,(word_FF8034).w
                move.w  #$54,4(a5) ; 'T'
                moveq   #1,d0
                rts
; End of function Effect_SpawnDebris
; Handles player state during boss defeat sequence
Player_HandleBossVictory:                              ; DATA XREF: ROM:000150B6   o  ; was: sub_161A6
                bset    #0,(byte_FF8244).w
                bset    #6,(byte_FF8244).w
                jsr Physics_BossTerrainWrapper(pc)   ; (pc)
                nop
                clr.b   6(a5)
                bsr.w Player_UpdateTerrainCheck
                btst    #0,6(a5)
                bne.w Player_InitLandingState
                clr.b   6(a5)
                bsr.w Player_TerrainCheckAlternate
                btst    #1,6(a5)
                bne.w Player_InitiateLanding
                cmpi.w  #$12,(word_FFA21C).w
                bpl.s   loc_161EE
                move.w  #$46,4(a5) ; 'F'
                bsr.w Player_AutoFlipDirection
loc_161EE:                              ; CODE XREF: Player_HandleBossVictory+3C   j
                movea.l #word_E8F3A,a2
                btst    #0,(word_FFA000+1).w
                bne.s   loc_16202
                movea.l #word_E8F6A,a2
loc_16202:                              ; CODE XREF: Player_HandleBossVictory+54   j
                movea.l #word_E8972,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                bra.w Stage_HandleBossDefeat
; End of function Player_HandleBossVictory
; Initializes player cutscene state clearing velocities and flags
Player_InitCutsceneState:                              ; CODE XREF: Player_Update+72   p  ; was: sub_16210
                move.b  #$7F,(byte_FF830F).w
                move.w  #$8000,(word_FF80E6).w
                move.w  #$32,4(a5) ; '2'
                move.b  #$80,$21(a5)
                move.w  #4,$5C(a5)
                clr.w   $48(a5)
                clr.w   $4A(a5)
                clr.w   $52(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                bset    #1,(byte_FF825C).w
                rts
; End of function Player_InitCutsceneState
; Handles cutscene player control with timer and position management
Player_HandleCutsceneControl:                              ; DATA XREF: ROM:00015094   o  ; was: sub_1624A
                                        ; ROM:00015096   o
                bset    #3,(byte_FF8244).w
                bclr    #0,(byte_FF825C).w
                bne.s   loc_1625C
                bra.w   loc_1629E
; ---------------------------------------------------------------------------
loc_1625C:                              ; CODE XREF: Player_HandleCutsceneControl+C   j
                bclr    #2,(byte_FF825C).w
                bne.s   loc_16286
                move.b  $6A(a5),d0
                andi.b  #$2C,d0 ; ','
                beq.s   loc_16272
                addq.w  #1,$4A(a5)
loc_16272:                              ; CODE XREF: Player_HandleCutsceneControl+22   j
                move.w  (word_FF824E).w,d0
                cmp.w   $4A(a5),d0
                bpl.s   loc_16286
                bclr    #1,(byte_FF825C).w
                bra.w   loc_1629E
; ---------------------------------------------------------------------------
loc_16286:                              ; CODE XREF: Player_HandleCutsceneControl+18   j
                                        ; Player_HandleCutsceneControl+30   j
                bset    #1,(byte_FF825C).w
                move.w  (word_FF8250).w,$10(a5)
                move.w  (word_FF8252).w,$14(a5)
                moveq   #$FFFFFFFE,d1
                bra.w Anim_SelectFrameData
; ---------------------------------------------------------------------------
loc_1629E:                              ; CODE XREF: Player_HandleCutsceneControl+E   j
                                        ; Player_HandleCutsceneControl+38   j
                move.b  #$30,(byte_FF825D).w ; '0'
                bra.w   *+4
; End of function Player_HandleCutsceneControl
; Initializes player knockback/damaged state with sound and velocity
Player_InitKnockbackState:                              ; CODE XREF: Player_Update+64   p  ; was: sub_162A8
                                        ; Player_HandleCutsceneControl+5A   j
                move.b  #$7F,(byte_FF830F).w
                bclr    #4,$E(a5)
                move.w  #$8000,(word_FF80E6).w
                jsr (Memory_ClearBlock).l
                move.w  #$2A,4(a5) ; '*'
                move.w  #$C,$48(a5)
                tst.w   $5E(a5)
                bpl.s   loc_16312
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_162E6
                move.b  #$19,d0
                jsr (Sound_PlaySFX).l
loc_162E6:                              ; CODE XREF: Player_InitKnockbackState+32   j
                move.l  #$FFFEA000,$1C(a5)
                tst.l   (dword_FF8300).w
                beq.s   loc_162FC
loc_162F4:                              ; CODE XREF: Player_InitKnockbackState+80   j
                move.l  (dword_FF8300).w,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_162FC:                              ; CODE XREF: Player_InitKnockbackState+4A   j
                move.l  #$FFFF7000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_16310
                neg.l   $18(a5)
locret_16310:                           ; CODE XREF: Player_InitKnockbackState+62   j
                rts
; ---------------------------------------------------------------------------
loc_16312:                              ; CODE XREF: Player_InitKnockbackState+28   j
                move.b  #$19,d0
                jsr (Sound_PlaySFX).l
                move.l  #$FFFE8000,$1C(a5)
                tst.w   (dword_FF8300).w
                bne.w   loc_162F4
                bra.s Player_SetKnockbackVelocity
; End of function Player_InitKnockbackState
; Sets horizontal knockback velocity
Player_SetHorizontalKnockback:
                bmi.s   loc_1633A  ; was: sub_1632E
                move.l  #$38000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_1633A:                              ; CODE XREF: Player_SetHorizontalKnockback   j
                move.l  #$FFFC8000,$18(a5)
                rts
; End of function Player_SetHorizontalKnockback
; Sets player horizontal knockback velocity based on facing direction
Player_SetKnockbackVelocity:                              ; CODE XREF: Player_InitKnockbackState+84   j  ; was: sub_16344
                move.l  #$FFFC8000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_16358
                neg.l   $18(a5)
locret_16358:                           ; CODE XREF: Player_SetKnockbackVelocity+E   j
                rts
; End of function Player_SetKnockbackVelocity
; Player death/defeat state handling gravity and landing detection
Player_DefeatState:                              ; DATA XREF: ROM:0001508C   o  ; was: sub_1635A
                movea.l #word_E8BAA,a1
                movea.l #word_E89C2,a2
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFF,d6
                bsr.w Stage_HandleBossDefeat
                subq.w  #1,$48(a5)
                bpl.s   loc_1638C
                bsr.w Player_ClearKnockbackState
                bsr.w Player_InitFallState
                move.b  #1,(word_FF8224).w
                move.b  #1,(word_FF8224+1).w
                bra.w Player_HandleFallingState
; ---------------------------------------------------------------------------
loc_1638C:                              ; CODE XREF: Player_DefeatState+18   j
                addi.l  #$6000,$1C(a5)
                bsr.w Physics_BossTerrainWrapper
                tst.w   $1C(a5)
                bmi.s   loc_163B2
                bsr.w Player_UpdateTerrainCheck
                btst    #0,6(a5)
                beq.s   locret_163BC
                bsr.w Player_ClearKnockbackState
                bra.w Player_InitLandingState
; ---------------------------------------------------------------------------
loc_163B2:                              ; CODE XREF: Player_DefeatState+42   j
                clr.b   6(a5)
                jmp Player_TerrainCheckAlternate(pc)   ; (pc)
; End of function Player_DefeatState
; Empty function that returns
Player_NoOp:
                nop  ; was: sub_163BA
locret_163BC:                           ; CODE XREF: Player_DefeatState+4E   j
                rts
; End of function Player_NoOp
; Clears player knockback flag and resets sprite state after hit
Player_ClearKnockbackState:                              ; CODE XREF: Player_DefeatState+1A   p  ; was: sub_163BE
                                        ; Player_DefeatState+50   p
                clr.w   (word_FF80E6).w
                move.w  #$CD00,2(a5)
                move.b  #$81,$21(a5)
                rts
; End of function Player_ClearKnockbackState
nullsub_41:
                rts
; End of function nullsub_41


; Initializes player landing state after air
Player_InitGroundedState:                              ; CODE XREF: Player_HandleAirDashState+1A   j  ; was: sub_163D2
                                        ; Player_ProcessAirState+66   j ...
                move.b  #$7F,(byte_FF830F).w
                bclr    #0,(byte_FF826C).w
                clr.w   (word_FF8224).w
                move.w  #$18,4(a5)
                clr.l   $18(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
                bra.w Player_AutoFlipDirection
; End of function Player_InitGroundedState
nullsub_42:                             ; CODE XREF: Player_HandleDashState+1E   j
                                        ; Player_HandleDashState+24   j
                rts
; End of function nullsub_42


; Main handler for player dash state with counter and input checks
Player_HandleDashState:                              ; DATA XREF: ROM:0001507A   o  ; was: sub_16402
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                jsr Player_TerrainCheckStandard(pc)   ; (pc)
                nop
                btst    #1,6(a5)
                beq.w Player_EndDashState
                bsr.w Effect_SpawnParticle
                bsr.w Player_CheckCounterInput
                bne.s   nullsub_42
                bsr.w Player_CheckDashInput
                bne.s   nullsub_42
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                btst    #4,$69(a5)
                beq.s   loc_16440
                tst.w   (word_FFA22A).w
                bne.s   loc_1645E
loc_16440:                              ; CODE XREF: Player_HandleDashState+36   j
                btst    #0,$69(a5)
                bne.w Player_InitDashState
                btst    #2,$69(a5)
                bne.w Player_InitWallKickState
                btst    #3,$69(a5)
                bne.w Player_InitWallKickState
loc_1645E:                              ; CODE XREF: Player_HandleDashState+3C   j
                btst    #4,$69(a5)
                beq.w Player_ProcessCollisionDamage
                bra.w Player_UpdateDashSprite
; ---------------------------------------------------------------------------
loc_1646C:                              ; CODE XREF: Player_HandleDashState+2C   j
                                        ; Player_ProcessAirState+3E   j ...
                bsr.w Boss_FlashOnHit
                move.b  #$7F,(byte_FF830F).w
                jsr (Sys_ClearObjectBufferSmall).l
                move.w  #$3E,4(a5) ; '>'
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_164AE
                neg.l   $18(a5)
locret_164AE:                           ; CODE XREF: Player_HandleDashState+A6   j
                rts
; End of function Player_HandleDashState
; Handles player air dash state with terrain check
Player_HandleAirDashState:                              ; DATA XREF: ROM:000150A0   o  ; was: sub_164B0
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                jsr Player_TerrainCheckStandard(pc)   ; (pc)
                nop
                btst    #1,6(a5)
                beq.w Player_SetDeathStateFlags
                subq.w  #1,$4A(a5)
                bmi.w Player_InitGroundedState
                move.l  #$2000,d1
                bsr.w Player_DecelerateHorizontalVelocity
                bra.w Player_AnimateDefeatSprite
; End of function Player_HandleAirDashState
; Updates weapon charge from input
Player_UpdateWeaponCharge:
                btst    #5,$6A(a5)  ; was: sub_164DC
                beq.s   locret_164FA
                btst    #0,$69(a5)
                beq.s   locret_164FA
                move.w  (word_FFA216).w,d0
                sub.w   (word_FFA218).w,d0
                move.w  d0,(word_FF8304).w
                moveq   #1,d0
locret_164FA:                           ; CODE XREF: Player_UpdateWeaponCharge+6   j
                                        ; Player_UpdateWeaponCharge+E   j
                rts
; End of function Player_UpdateWeaponCharge
; Initializes player dash state with animation and counter setup
Player_InitDashState:                              ; CODE XREF: Player_HandleDashState+44   j  ; was: sub_164FC
                                        ; Player_HandleCrouchState+32   j ...
                move.w  #2,$48(a5)
; Initializes dash animation with timer and direction flip
Player_InitDashAnimation:                              ; CODE XREF: Player_HandleDashCancel+88   j  ; was: loc_16502
                                        ; Player_HandleSlideState+38   j
                move.w  #$22,4(a5) ; '"'
                bset    #4,$E(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$14,$5C(a5)
                move.b  #$7F,(byte_FF830F).w
                bra.w Player_AutoFlipDirection
; End of function Player_InitDashState
nullsub_43:                             ; CODE XREF: Player_ProcessAirState+20   j
                rts
; End of function nullsub_43


; Processes player state while airborne
Player_ProcessAirState:                              ; DATA XREF: ROM:00015084   o  ; was: sub_1652C
                bset    #1,(byte_FF8244).w
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                jsr Player_TerrainCheckStandard(pc)   ; (pc)
                nop
                btst    #1,6(a5)
                beq.w Player_EndDashState
                bsr.w Player_CheckCounterInput
                bne.s   nullsub_43
                btst    #5,$6A(a5)
                beq.s   loc_16564
                btst    #0,$69(a5)
                beq.w Player_EndDashState
                bra.w Player_InitiateDashAttack
; ---------------------------------------------------------------------------
loc_16564:                              ; CODE XREF: Player_ProcessAirState+28   j
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                bsr.w Player_ApplyKnockbackVelocity
                subq.w  #1,$48(a5)
                bpl.s Player_CheckGroundTransition
                move.w  #$FFFF,$48(a5)
                btst    #4,$69(a5)
                beq.s   loc_1658C
                tst.w   (word_FFA22A).w
                bne.s Player_CheckGroundTransition
loc_1658C:                              ; CODE XREF: Player_ProcessAirState+58   j
                btst    #0,$69(a5)
                beq.w Player_InitGroundedState
; Checks conditions for transitioning to grounded state
Player_CheckGroundTransition:                              ; CODE XREF: Player_ProcessAirState+4A   j  ; was: loc_16596
                                        ; Player_ProcessAirState+5E   j
                btst    #4,$69(a5)
                beq.w Player_HandleDefeatByBoss
                bra.w Player_RenderWithWeapon
; End of function Player_ProcessAirState
; Initializes player crouch state
Player_InitCrouchState:                              ; CODE XREF: Player_ProcessJumpState+68   j  ; was: sub_165A4
                                        ; Player_InitWallKickState+3A   j ...
                move.b  #$7F,(byte_FF830F).w
                clr.w   (word_FF8224).w
                move.w  #$1E,4(a5)
                clr.w   $48(a5)
                move.w  #$10,$5C(a5)
                bra.w Player_AutoFlipDirection
; End of function Player_InitCrouchState
; Main crouch state handler with input checks
Player_HandleCrouchState:                              ; DATA XREF: ROM:00015080   o  ; was: sub_165C2
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                jsr Player_TerrainCheckStandard(pc)   ; (pc)
                nop
                btst    #1,6(a5)
                beq.w Player_EndDashState
                bsr.w Player_CheckCounterInput
                bne.s   locret_16638
                bsr.w Player_CheckDashInput
                bne.s   locret_16638
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                btst    #0,$69(a5)
                bne.w Player_InitDashState
                bsr.w Player_ApplyKnockbackVelocity
                move.l  $18(a5),d0
                bne.s Player_SelectCrouchAnimation
                btst    #2,$69(a5)
                bne.w   loc_16792
                btst    #3,$69(a5)
                bne.w   loc_16792
                bra.w Player_InitGroundedState
; ---------------------------------------------------------------------------
; Selects appropriate crouch/defeat animation based on state
Player_SelectCrouchAnimation:                              ; CODE XREF: Player_HandleCrouchState+3E   j  ; was: loc_1661A
                btst    #4,$69(a5)
                bne.w   loc_17132
                movea.l #word_E8972,a1
                movea.l #word_E89C2,a2
                moveq   #0,d5
                moveq   #6,d6
                bra.w Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
locret_16638:                           ; CODE XREF: Player_HandleCrouchState+1A   j
                                        ; Player_HandleCrouchState+20   j ...
                rts
; End of function Player_HandleCrouchState
; Initializes player landing recovery state
Player_InitiateLanding:                              ; CODE XREF: Player_HandleFallingState+66   j  ; was: sub_1663A
                                        ; Player_HandleBounceState+3A   j ...
                move.b  #$7F,(byte_FF830F).w
                clr.w   (word_FF8224).w
                move.w  #$26,4(a5) ; '&'
                bset    #4,$E(a5)
                move.w  #2,$48(a5)
                move.w  #6,$4A(a5)
                move.w  #$14,$5C(a5)
                move.b  #$B1,d0
                jsr (Sound_PlaySFX).l
                bra.w Player_AutoFlipDirection
; End of function Player_InitiateLanding
; Processes player state during jump
Player_ProcessJumpState:                              ; DATA XREF: ROM:00015088   o  ; was: sub_16670
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                jsr Player_TerrainCheckStandard(pc)   ; (pc)
                nop
                btst    #1,6(a5)
                beq.w Player_EndDashState
                bsr.w Player_CheckCounterInput
                bne.s   locret_16638
                bsr.w Player_CheckDashInput
                bne.s   locret_16638
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                move.l  #$4000,d1
                bsr.w Player_DecelerateHorizontalVelocity
                subq.w  #1,$4A(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_166DC
                btst    #0,$69(a5)
                beq.s   loc_166C4
                bsr.w Player_InitDashState
                move.w  #$FFFF,$48(a5)
                bra.s   loc_166DC
; ---------------------------------------------------------------------------
loc_166C4:                              ; CODE XREF: Player_ProcessJumpState+46   j
                btst    #2,$69(a5)
                bne.w   loc_16792
                btst    #3,$69(a5)
                bne.w   loc_16792
                bra.w Player_InitCrouchState
; ---------------------------------------------------------------------------
loc_166DC:                              ; CODE XREF: Player_ProcessJumpState+3E   j
                                        ; Player_ProcessJumpState+52   j
                btst    #4,$69(a5)
                beq.w Player_HandleDefeatByBoss
                bra.w Player_RenderWithWeapon
; End of function Player_ProcessJumpState
; Checks controller input for counter/parry activation
Player_CheckCounterInput:                              ; CODE XREF: Player_HandleDashState+1A   p  ; was: sub_166EA
                                        ; Player_ProcessAirState+1C   p ...
                btst    #6,$6A(a5)
                beq.s   loc_16702
                btst    #0,$69(a5)
                bne.w Player_ToggleScreenSide
                tst.w   (word_FF8038).w
                bmi.s   loc_16706
loc_16702:                              ; CODE XREF: Player_CheckCounterInput+6   j
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_16706:                              ; CODE XREF: Player_CheckCounterInput+16   j
                move.w  (word_FFA24E).w,(word_FFA220).w
                move.w  #$12,(word_FFA21C).w
                move.b  #$7F,(byte_FF830F).w
                move.w  #0,(word_FF8032).w
                move.w  #0,(word_FF8034).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$20,4(a5) ; ' '
                move.w  #$10,$5C(a5)
                btst    #0,$69(a5)
                beq.s   loc_16746
                move.w  #$14,$5C(a5)
loc_16746:                              ; CODE XREF: Player_CheckCounterInput+54   j
                moveq   #1,d0
                rts
; End of function Player_CheckCounterInput
; Checks dash counter and transitions to grounded or damage state
Player_CheckDashCounter:                              ; DATA XREF: ROM:00015082   o  ; was: sub_1674A
                cmpi.w  #$12,(word_FFA21C).w
                bmi.w Player_InitGroundedState
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                jsr Player_TerrainCheckStandard(pc)   ; (pc)
                nop
                btst    #1,6(a5)
                beq.w Player_EndDashState
                bra.w Player_ProcessCollisionDamage
; End of function Player_CheckDashCounter
; Toggles player screen side flag with sound effect
Player_ToggleScreenSide:                              ; CODE XREF: Player_CheckCounterInput+E   j  ; was: sub_1676E
                eori.w  #2,(word_FFA22A).w
                move.b  #$A3,d0
                jsr (Sound_PlaySFX).l
                moveq   #0,d0
                rts
; End of function Player_ToggleScreenSide
; Initializes wall kick state from button input
Player_InitWallKickState:                              ; CODE XREF: Player_HandleDashState+4E   j  ; was: sub_16782
                                        ; Player_HandleDashState+58   j
                btst    #4,$69(a5)
                beq.s Player_InitWallKickAnimation
                tst.w   (word_FFA22A).w
                beq.s   loc_167A2
                rts
; ---------------------------------------------------------------------------
loc_16792:                              ; CODE XREF: Player_HandleCrouchState+46   j
                                        ; Player_HandleCrouchState+50   j ...
                btst    #4,$69(a5)
                beq.s Player_InitWallKickAnimation
                tst.w   (word_FFA22A).w
                bne.w Player_InitGroundedState
loc_167A2:                              ; CODE XREF: Player_InitWallKickState+C   j
                btst    #3,$69(a5)
                beq.s   loc_167B6
                btst    #3,$E(a5)
                bne.w   loc_16878
                bra.s Player_InitWallKickAnimation
; ---------------------------------------------------------------------------
loc_167B6:                              ; CODE XREF: Player_InitWallKickState+26   j
                btst    #2,$69(a5)
                beq.w Player_InitCrouchState
                btst    #3,$E(a5)
                beq.w   loc_16878
; Initializes wall kick animation with timer and direction flip
Player_InitWallKickAnimation:                              ; CODE XREF: Player_InitWallKickState+6   j  ; was: loc_167CA
                                        ; Player_InitWallKickState+16   j ...
                move.b  #$7F,(byte_FF830F).w
                move.w  #$1A,4(a5)
                move.w  #4,$48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
                bra.w Player_AutoFlipDirection
; End of function Player_InitWallKickState
nullsub_44:                             ; CODE XREF: Sound_PlayBossHitSound+1A   j
                                        ; Sound_PlayBossHitSound+20   j
                rts
; End of function nullsub_44


; Plays sound effect for boss taking damage
Sound_PlayBossHitSound:                              ; DATA XREF: ROM:0001507C   o  ; was: sub_167EE
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                jsr Player_TerrainCheckStandard(pc)   ; (pc)
                nop
                btst    #1,6(a5)
                beq.w Player_EndDashState
                bsr.w Player_CheckCounterInput
                bne.s   nullsub_44
                bsr.w Player_CheckDashInput
                bne.s   nullsub_44
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                btst    #0,$69(a5)
                bne.w Player_InitDashState
                btst    #4,$69(a5)
                beq.s   loc_16834
                tst.w   (word_FFA22A).w
                bne.w Player_InitCrouchState
loc_16834:                              ; CODE XREF: Sound_PlayBossHitSound+3C   j
                btst    #2,$69(a5)
                bne.s   loc_16846
                btst    #3,$69(a5)
                beq.w Player_InitCrouchState
loc_16846:                              ; CODE XREF: Sound_PlayBossHitSound+4C   j
                bsr.w Physics_ApplyVerticalDecel
                btst    #4,$69(a5)
                beq.w Boss_AnimateDeathSequence
                btst    #3,$69(a5)
                beq.s   loc_1686A
                btst    #3,$E(a5)
                beq.w   loc_16878
                bra.w Player_RenderDashSprite
; ---------------------------------------------------------------------------
loc_1686A:                              ; CODE XREF: Sound_PlayBossHitSound+6C   j
                btst    #3,$E(a5)
                bne.w   loc_16878
                bra.w Player_RenderDashSprite
; ---------------------------------------------------------------------------
loc_16878:                              ; CODE XREF: Player_InitWallKickState+2E   j
                                        ; Player_InitWallKickState+44   j ...
                move.w  #$1C,4(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$5C(a5)
locret_1688E:                           ; CODE XREF: Player_AirControlState+1A   j
                                        ; Player_AirControlState+20   j
                rts
; End of function Sound_PlayBossHitSound
; Handles player air control state with terrain checks and dash/counter inputs during aerial movement
Player_AirControlState:                              ; DATA XREF: ROM:0001507E   o  ; was: sub_16890
                jsr Physics_EntityTerrainWrapper(pc)   ; (pc)
                nop
                jsr Player_TerrainCheckStandard(pc)   ; (pc)
                nop
                btst    #1,6(a5)
                beq.w Player_EndDashState
                bsr.w Player_CheckCounterInput
                bne.s   locret_1688E
                bsr.w Player_CheckDashInput
                bne.s   locret_1688E
                btst    #0,(byte_FF826C).w
                bne.w   loc_1646C
                btst    #0,$69(a5)
                bne.w Player_InitDashState
                btst    #4,$69(a5)
                beq.w Player_InitWallKickAnimation
                bsr.w Player_RenderWeaponSprite
                btst    #2,$69(a5)
                beq.s   loc_168EA
                btst    #3,$E(a5)
                beq.w Player_InitWallKickAnimation
                bra.w Physics_ApplyDownwardGravity
; ---------------------------------------------------------------------------
loc_168EA:                              ; CODE XREF: Player_AirControlState+4A   j
                btst    #3,$69(a5)
                beq.w Player_InitCrouchState
                btst    #3,$E(a5)
                bne.w Player_InitWallKickAnimation
                bra.w Physics_ApplyUpwardGravity
; End of function Player_AirControlState
; Updates aim direction from D-pad
Player_UpdateAimDirection:                              ; DATA XREF: ROM:000150AA   o  ; was: sub_16902
                bset    #4,$E(a5)
                btst    #2,(word_FFF706).w
                beq.s   loc_16918
                bclr    #3,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_16918:                              ; CODE XREF: Player_UpdateAimDirection+C   j
                btst    #3,(word_FFF706).w
                beq.s   locret_16926
                bset    #3,$E(a5)
locret_16926:                           ; CODE XREF: Player_UpdateAimDirection+1C   j
                rts
; End of function Player_UpdateAimDirection
; Attributes: thunk
; Updates force weapon sprite
Player_UpdateForceWeapon:                              ; DATA XREF: ROM:000150AC   o  ; was: sub_16928
                bra.w Player_InitGroundedState
; End of function Player_UpdateForceWeapon
; Handles jump apex for fall transition
Player_JumpApexState:                              ; DATA XREF: ROM:000150AE   o  ; was: sub_1692C
                addi.l  #$8800,$1C(a5)
                bpl.w Player_InitFallState
                bclr    #4,$E(a5)
                bra.w   loc_16EF8
; End of function Player_JumpApexState
; Player dash effect during teleport
Player_TeleportDash:                              ; DATA XREF: ROM:000150B2   o  ; was: sub_16942
                clr.w   (word_FF80E6).w
                move.b  #$70,(byte_FF830F).w ; 'p'
                bset    #0,(byte_FF8245).w
                move.w  #$CD00,2(a5)
                addq.w  #2,4(a5)
                clr.w   $48(a5)
                jsr (Memory_ClearBlock).l
                move.w  #$78,$10(a5) ; 'x'
                move.w  #$100,$14(a5)
                move.l  #$41000,$18(a5)
                move.l  #$18000,$1C(a5)
                bset    #3,$E(a5)
                bclr    #4,$E(a5)
                movea.w #(word_FFC5C0-M68K_RAM),a0
                move.w  #$230,(a0)
                move.b  #$54,$21(a0) ; 'T'
                move.w  #$4000,2(a0)
                move.l  #word_E8F22,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                eori.w  #$1000,$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  #$E0,d0
                jsr (Sound_PlaySFX).l
                move.l  #word_E8E6A,8(a5)
; Applies velocity during player teleport dash
Player_TeleportDash_ApplyVelocity:                              ; DATA XREF: ROM:000150B4   o  ; was: loc_169E0
                tst.w   $48(a5)
                bne.w   loc_16A0E
                subi.l  #$620,$1C(a5)
                subi.l  #$C00,$18(a5)
                bset    #6,$21(a5)
                bset    #4,$23(a5)
                bset    #4,(byte_FF8244).w
                bra.w Effect_CreateDashTrail
; ---------------------------------------------------------------------------
loc_16A0E:                              ; CODE XREF: Player_TeleportDash+A2   j
                bclr    #6,$21(a5)
                bclr    #4,$23(a5)
                jsr (Memory_ClearBlock).l
                bclr    #0,(byte_FF8245).w
                move.w  #$FFE0,$52(a5)
                move.l  #$68000,$18(a5)
                move.w  #$FFFF,$1C(a5)
                bra.w   loc_15C3C
; End of function Player_TeleportDash
; Spawns projectile type 2
Boss_ArtemisSpawnProjectile2:                              ; DATA XREF: ROM:000150BA   o  ; was: sub_16A3E
                moveq   #4,d1
                bra.w Player_UpdateAnimationState
; End of function Boss_ArtemisSpawnProjectile2
; Updates animation state with -4 offset
Player_UpdateAnimStateMinus4:                              ; DATA XREF: ROM:000150BC   o  ; was: sub_16A44
                moveq   #$FFFFFFFC,d1
                bra.w Player_UpdateAnimationState
; End of function Player_UpdateAnimStateMinus4
; VBlank handler for credits
Credits_VBlankHandler:                              ; DATA XREF: ROM:000150BE   o  ; was: sub_16A4A
                addq.w  #2,4(a5)
                move.b  #$70,(byte_FF830F).w ; 'p'
                bset    #0,(byte_FF8245).w
                move.w  #$CD00,2(a5)
                jsr (Memory_ClearBlock).l
                move.w  #$120,$10(a5)
                move.w  #$100,$14(a5)
                bset    #3,$E(a5)
                bclr    #4,$E(a5)
                move.l  #word_E8E6A,8(a5)
; Updates sprite graphics during teleport dash
Player_TeleportDash_UpdateSprite:                              ; DATA XREF: ROM:000150C0   o  ; was: loc_16A86
                bset    #4,$23(a5)
                move.l  #word_E8EBA,8(a5)
                btst    #0,(word_FFA000+1).w
                bne.w   locret_16AA6
                move.l  #word_E8E6A,8(a5)
locret_16AA6:                           ; CODE XREF: Credits_VBlankHandler+50   j
                rts
; End of function Credits_VBlankHandler
; Initializes player invulnerability state with timer and sound effect
Player_InitInvulnerabilityState:                              ; CODE XREF: Player_Update+34   j  ; was: sub_16AA8
                                        ; Player_Update+3C   j
                move.w  #2,(word_FF80E6).w
                move.w  #$100,2(a5)
                clr.b   $21(a5)
                move.b  #$10,$23(a5)
                move.w  #$30,$48(a5) ; '0'
                move.b  #$1F,d0
                jmp (Sound_PlaySFX).l
; End of function Player_InitInvulnerabilityState
; Manages invulnerability timer countdown and triggers palette fade effects when expired
Player_HandleInvulnerabilityTimer:                              ; CODE XREF: Player_Update+2C   j  ; was: sub_16ACE
                bclr    #7,2(a5)
                tst.w   $48(a5)
                bmi.s   locret_16B02
                subq.w  #1,$48(a5)
                bne.s   loc_16AFC
                move.w  #1,(word_FF8230).w
                move.w  #$8002,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
loc_16AFC:                              ; CODE XREF: Player_HandleInvulnerabilityTimer+10   j
                jmp Effect_SpawnPlayerDeathSpark
; ---------------------------------------------------------------------------
locret_16B02:                           ; CODE XREF: Player_HandleInvulnerabilityTimer+A   j
                rts
; End of function Player_HandleInvulnerabilityTimer
; Reads controller input into player state bytes
Input_ReadPlayerInput:                              ; CODE XREF: Player_Update+1A   p  ; was: sub_16B04
                tst.w   (word_FFA02A).w
                bne.s   locret_16B22
                move.b  (word_FFF706).w,$69(a5)
                move.b  (word_FFF708).w,$6A(a5)
                move.b  (byte_FF830F).w,d0
                and.b   d0,$69(a5)
                and.b   d0,$6A(a5)
locret_16B22:                           ; CODE XREF: Input_ReadPlayerInput+4   j
                rts
; End of function Input_ReadPlayerInput
; Updates weapon switch timer and cooldown
Player_UpdateWeaponSwitchTimer:                              ; CODE XREF: Player_Update:loc_15030   p  ; was: sub_16B24
                                        ; sub_19DAE:loc_19DC8   p
                subq.w  #1,(word_FF826A).w
                bmi.s   loc_16B3A
                btst    #4,$6A(a5)
                beq.s   loc_16B4E
                bset    #0,(byte_FF826C).w
                bra.s   loc_16B4E
; ---------------------------------------------------------------------------
loc_16B3A:                              ; CODE XREF: Player_UpdateWeaponSwitchTimer+4   j
                move.w  #$FFFF,(word_FF826A).w
                btst    #4,$6A(a5)
                beq.s   loc_16B4E
                move.w  #$10,(word_FF826A).w
loc_16B4E:                              ; CODE XREF: Player_UpdateWeaponSwitchTimer+C   j
                                        ; Player_UpdateWeaponSwitchTimer+14   j ...
                move.w  (word_FFA216).w,d0
                sub.w   (word_FFA218).w,d0
                move.w  d0,(word_FF8304).w
                rts
; End of function Player_UpdateWeaponSwitchTimer
; Updates player direction bit from controller state
Player_UpdateDirectionBit:                              ; CODE XREF: Player_Update:loc_15038   p  ; was: sub_16B5C
                                        ; sub_19DAE:loc_19DE4   p
                btst    #5,(byte_FF8244).w
                bne.s   locret_16B72
                bclr    #7,$E(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
locret_16B72:                           ; CODE XREF: Player_UpdateDirectionBit+6   j
                rts
; End of function Player_UpdateDirectionBit
; Sets player hit box collision boundaries with direction mirroring
Player_SetHitbox:                              ; CODE XREF: Player_Update+AE   p  ; was: sub_16B74
                                        ; Boss_SylpheedSpawnProjectile1+48   p
                move.w  $5C(a5),d0
                beq.s   locret_16BB0
                clr.w   $5C(a5)
                subq.w  #4,d0
                move.l  dword_16BB2(pc,d0.w),d0
                btst    #4,$E(a5)
                beq.s Player_ApplyHitboxOffset
                move.l  d0,(dword_FF8040).w
                move.l  d0,(dword_FF8044).w
                move.b  (dword_FF8044).w,d1
                neg.b   d1
                move.b  d1,(dword_FF8040+1).w
                move.b  (dword_FF8044+1).w,d1
                neg.b   d1
                move.b  d1,(dword_FF8040).w
                move.l  (dword_FF8040).w,d0
; Applies calculated hitbox offset values to player entity
Player_ApplyHitboxOffset:                              ; CODE XREF: Player_SetHitbox+16   j  ; was: loc_16BAC
                move.l  d0,$28(a5)
locret_16BB0:                           ; CODE XREF: Player_SetHitbox+4   j
                rts
; End of function Player_SetHitbox
; ---------------------------------------------------------------------------
dword_16BB2:    dc.l $E01EF808, $FC1EF808, $E018F808, $E01CF808, $FC1CF808, $E016F808, $E012F808
                                        ; DATA XREF: Player_SetHitbox+C   r


; Calculates player center position from hitbox bounds
Player_CalculateCenterPosition:                              ; CODE XREF: Player_Update+B6   j  ; was: sub_16BCE
                                        ; Boss_SylpheedSpawnProjectile1+52   j
                move.b  $2A(a5),d0
                ext.w   d0
                move.b  $2B(a5),d1
                ext.w   d1
                add.w   d1,d0
                asr.w   #1,d0
                add.w   $10(a5),d0
                move.w  d0,(word_FF8248).w
                move.b  $28(a5),d0
                ext.w   d0
                move.b  $29(a5),d1
                ext.w   d1
                add.w   d1,d0
                asr.w   #1,d0
                add.w   $14(a5),d0
                move.w  d0,(word_FF824A).w
                rts
; End of function Player_CalculateCenterPosition
; Manages player invulnerability and flash timer
Player_UpdateInvulnerabilityTimer:                              ; CODE XREF: Player_Update+AA   p  ; was: sub_16C00
                                        ; Boss_SylpheedSpawnProjectile1+42   p
                bset    #7,2(a5)
                subq.w  #1,$5E(a5)
                bpl.s   loc_16C22
                move.w  #$FFFF,$5E(a5)
                btst    #6,$21(a5)
                bne.s   locret_16C3E
                bclr    #4,$23(a5)
                rts
; ---------------------------------------------------------------------------
loc_16C22:                              ; CODE XREF: Player_UpdateInvulnerabilityTimer+A   j
                bset    #4,$23(a5)
                btst    #5,(byte_FF8244).w
                bne.s   locret_16C3E
                btst    #0,(word_FFA000+1).w
                beq.s   locret_16C3E
                bclr    #7,2(a5)
locret_16C3E:                           ; CODE XREF: Player_UpdateInvulnerabilityTimer+18   j
                                        ; Player_UpdateInvulnerabilityTimer+2E   j ...
                rts
; End of function Player_UpdateInvulnerabilityTimer
; Updates player horizontal facing bit from input
Player_UpdateHorizontalFacing:                              ; CODE XREF: Player_HandleSpecialAttack+B0   p  ; was: sub_16C40
                                        ; Player_CheckSpecialAttack+1E   p ...
                btst    #2,$69(a5)
                beq.s   loc_16C50
                bclr    #3,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_16C50:                              ; CODE XREF: Player_UpdateHorizontalFacing+6   j
                btst    #3,$69(a5)
                beq.w   locret_16C60
                bset    #3,$E(a5)
locret_16C60:                           ; CODE XREF: Player_UpdateHorizontalFacing+16   j
                rts
; End of function Player_UpdateHorizontalFacing
; Finds free object slot for dash trail effect
Effect_FindDashTrailSlot:                              ; CODE XREF: Effect_CreateDashTrail:loc_177D8   p  ; was: sub_16C62
                                        ; Effect_CreateDashTrail+7A   p
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$B,d7
                jmp Sys_FindFreeObjectSlot
; End of function Effect_FindDashTrailSlot
; Loads player sprite palette based on state
Gfx_LoadPlayerPaletteData:                              ; CODE XREF: Player_Update+54   p  ; was: sub_16C6E
                                        ; sub_19DAE   p
                tst.w   (word_FF8304).w
                bne.s   loc_16C8C
                move.w  (word_FFA000).w,d0
                btst    #4,d0
                bne.s   loc_16C8C
                andi.w  #3,d0
                bne.s   loc_16C8C
                lea     word_16CC0(pc),a0
                nop
                bra.s Gfx_CopyPlayerPaletteWords
; ---------------------------------------------------------------------------
loc_16C8C:                              ; CODE XREF: Gfx_LoadPlayerPaletteData+4   j
                                        ; Gfx_LoadPlayerPaletteData+E   j ...
                lea     word_16CB0(pc),a0
                nop
                tst.w   (word_FFA22A).w
                beq.s Gfx_CopyPlayerPaletteWords
                lea     word_16CB8(pc),a0
                nop
; Copies 8 bytes of player palette data to two RAM locations
Gfx_CopyPlayerPaletteWords:                              ; CODE XREF: Gfx_LoadPlayerPaletteData+1C   j  ; was: loc_16C9E
                                        ; Gfx_LoadPlayerPaletteData+28   j
                movea.w #(byte_FFE352-M68K_RAM),a1
                movea.w #(dword_FFE3D2-M68K_RAM),a2
                move.l  (a0),(a1)+
                move.l  (a0)+,(a2)+
                move.l  (a0),(a1)+
                move.l  (a0)+,(a2)+
                rts
; End of function Gfx_LoadPlayerPaletteData
; ---------------------------------------------------------------------------
word_16CB0:     dc.w $22, $46, $488, $8CC
                                        ; DATA XREF: Gfx_LoadPlayerPaletteData:loc_16C8C   o
word_16CB8:     dc.w $220, $442, $888, $CCC
                                        ; DATA XREF: Gfx_LoadPlayerPaletteData+2A   o
word_16CC0:     dc.w $C88, $EAA, $ECC, $EEE
                                        ; DATA XREF: Gfx_LoadPlayerPaletteData+16   o


; Terrain collision wrapper checking flag before testing walls
Physics_EntityTerrainWrapper:                              ; CODE XREF: Player_HandleJump   p  ; was: sub_16CC8
                                        ; sub_152CA   p ...
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jmp Physics_EntityWallCheck
; End of function Physics_EntityTerrainWrapper
; Boss terrain collision wrapper checking flag before testing terrain
Physics_BossTerrainWrapper:                              ; CODE XREF: Physics_BossCollisionCheck+8   p  ; was: sub_16CD8
                                        ; sub_15B8C   p ...
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jmp Physics_BossTerrainCheck
; End of function Physics_BossTerrainWrapper
; Processes player action through dispatcher
Player_ProcessAction:                              ; CODE XREF: Player_HandleJump+6   p  ; was: sub_16CE8
                                        ; Physics_ApplyBossVelocity+6   p ...
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jsr (Collision_CheckAllEnemies).l
                jmp Player_ActionDispatcher
; End of function Player_ProcessAction
; Updates player state and checks terrain collision
Player_UpdateTerrainCheck:                              ; CODE XREF: Physics_BossCollisionCheck+14   p  ; was: sub_16CFE
                                        ; Player_DashKickState+E   p ...
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jsr (Collision_CheckAllEnemies).l
                jmp Player_CheckTerrainCollision
; End of function Player_UpdateTerrainCheck
; Standard terrain collision check for player
Player_TerrainCheckStandard:                              ; CODE XREF: Player_HandleDashState+6   p  ; was: sub_16D14
                                        ; Player_HandleAirDashState+6   p ...
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jsr (Collision_CheckAllEnemies).l
                jmp Physics_MultiPointTerrainCheck
; End of function Player_TerrainCheckStandard
; Alternative terrain collision check with velocity
Player_TerrainCheckAlternate:                              ; CODE XREF: Physics_BossCollisionCheck+28   p  ; was: sub_16D2A
                                        ; Player_HandleFallingState+5A   p ...
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jsr (Collision_CheckAllEnemies).l
                jmp Physics_TerrainCheckWithVelocity
; End of function Player_TerrainCheckAlternate
; Dispatches player action based on facing direction
Player_DirectionDispatcher:                              ; CODE XREF: Player_PhoenixAttackUpdate+86   p  ; was: sub_16D40
                                        ; sub_159E0:loc_159F0   p ...
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                jsr (Collision_CheckAllEnemies).l
                btst    #4,$E(a5)
                beq.w Player_ActionDispatcher
                jmp Physics_MultiPointTerrainCheck
; End of function Player_DirectionDispatcher
; Player terrain collision check with flipped hitbox offset direction
Player_TerrainCheckFlipped:                              ; CODE XREF: Player_PhoenixAttackUpdate+82   p  ; was: sub_16D60
                                        ; Player_ApplyHorizontalMovement+4   p
                btst    #5,(byte_FF8245).w
                bne.w   locret_16D7E
                moveq   #$FFFFFFE8,d6
                btst    #4,$E(a5)
                beq.w   loc_14694
                moveq   #$18,d6
                jmp     loc_14694
; ---------------------------------------------------------------------------
locret_16D7E:                           ; CODE XREF: Physics_EntityTerrainWrapper+6   j
                                        ; Physics_BossTerrainWrapper+6   j ...
                rts
; End of function Player_TerrainCheckFlipped
; Processes D-pad input for character facing direction
Input_ProcessDirectionInput:                              ; CODE XREF: Player_Update+58   p  ; was: sub_16D80
                                        ; Boss_SylpheedSpawnProjectile1+6   p
                tst.w   (word_FFA02A).w
                bne.w   locret_16DE4
                move.b  $69(a5),d1
                move.w  (word_FFA22A).w,d0
                beq.s   loc_16D9C
                btst    #4,$69(a5)
                bne.s   loc_16DA6
                rts
; ---------------------------------------------------------------------------
loc_16D9C:                              ; CODE XREF: Input_ProcessDirectionInput+10   j
                btst    #4,$6A(a5)
                bne.s   loc_16DA6
                rts
; ---------------------------------------------------------------------------
loc_16DA6:                              ; CODE XREF: Input_ProcessDirectionInput+18   j
                                        ; Input_ProcessDirectionInput+22   j
                btst    #2,d1
                beq.s   loc_16DB8
                bclr    #3,$E(a5)
                bclr    #3,d1
                bra.s   loc_16DC8
; ---------------------------------------------------------------------------
loc_16DB8:                              ; CODE XREF: Input_ProcessDirectionInput+2A   j
                btst    #3,d1
                beq.s   loc_16DC8
                bset    #3,$E(a5)
                bclr    #2,d1
loc_16DC8:                              ; CODE XREF: Input_ProcessDirectionInput+36   j
                                        ; Input_ProcessDirectionInput+3C   j
                andi.w  #$F,d1
                bne.s   loc_16DDC
                moveq   #4,d0
                btst    #3,$E(a5)
                beq.s Input_StoreDirectionByte
                moveq   #0,d0
                bra.s Input_StoreDirectionByte
; ---------------------------------------------------------------------------
loc_16DDC:                              ; CODE XREF: Input_ProcessDirectionInput+4C   j
                move.b  byte_16DE6(pc,d1.w),d0
; Stores processed direction input byte to player entity
Input_StoreDirectionByte:                              ; CODE XREF: Input_ProcessDirectionInput+56   j  ; was: loc_16DE0
                                        ; Input_ProcessDirectionInput+5A   j
                move.b  d0,$9E(a5)
locret_16DE4:                           ; CODE XREF: Input_ProcessDirectionInput+4   j
                rts
; End of function Input_ProcessDirectionInput
; ---------------------------------------------------------------------------
byte_16DE6:     dc.b 0, 6, 2, 0, 4, 5, 3, 0, 0, 7, 1, 0, 0, 0, 0, 0
                                        ; DATA XREF: Input_ProcessDirectionInput:loc_16DDC   r


; Auto-flips player direction based on weapon aim angle constraints
Player_AutoFlipDirection:                              ; CODE XREF: Player_InitAirState+2A   j  ; was: sub_16DF6
                                        ; Player_InitJumpCancelState+2E   j ...
                tst.w   (word_FFA22A).w
                bne.s   locret_16E32
                btst    #4,$69(a5)
                beq.s   locret_16E32
                move.b  $9E(a5),d0
                btst    #3,$E(a5)
                beq.s   loc_16E1E
                cmpi.b  #3,d0
                bmi.s   locret_16E32
                cmpi.b  #6,d0
                bmi.s   loc_16E2C
                rts
; ---------------------------------------------------------------------------
loc_16E1E:                              ; CODE XREF: Player_AutoFlipDirection+18   j
                cmpi.b  #2,d0
                bmi.s   loc_16E2C
                cmpi.b  #7,d0
                bpl.s   loc_16E2C
                rts
; ---------------------------------------------------------------------------
loc_16E2C:                              ; CODE XREF: Player_AutoFlipDirection+24   j
                                        ; Player_AutoFlipDirection+2C   j ...
                eori.w  #$800,$E(a5)
locret_16E32:                           ; CODE XREF: Player_AutoFlipDirection+4   j
                                        ; Player_AutoFlipDirection+C   j ...
                rts
; End of function Player_AutoFlipDirection
; Applies vertical momentum deceleration based on direction flag
Physics_ApplyVerticalDecel:                              ; CODE XREF: Boss_UpdateHealthBar:loc_1570E   p  ; was: sub_16E34
                                        ; sub_167EE:loc_16846   p
                btst    #3,$E(a5)
                bne.s   loc_16E56
                move.l  $18(a5),d0
                bpl.s   loc_16E4A
                cmpi.l  #$FFFBE000,d0
                bmi.s   loc_16E6A
loc_16E4A:                              ; CODE XREF: Physics_ApplyVerticalDecel+C   j
                subi.l  #$A800,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_16E56:                              ; CODE XREF: Physics_ApplyVerticalDecel+6   j
                move.l  $18(a5),d0
                bmi.s   loc_16E64
                cmpi.l  #$42000,d0
                bpl.s   loc_16E6A
loc_16E64:                              ; CODE XREF: Physics_ApplyVerticalDecel+26   j
                addi.l  #$A800,d0
loc_16E6A:                              ; CODE XREF: Physics_ApplyVerticalDecel+14   j
                                        ; Physics_ApplyVerticalDecel+2E   j
                move.l  d0,$18(a5)
                rts
; End of function Physics_ApplyVerticalDecel
; Applies downward gravity acceleration with terminal velocity limit
Physics_ApplyDownwardGravity:                              ; CODE XREF: Player_AirAttackState+4A   j  ; was: sub_16E70
                                        ; Player_AirControlState+56   j
                move.l  $18(a5),d0
                bpl.s   loc_16E7E
                cmpi.l  #$FFFD6000,d0
                bmi.s   loc_16E84
loc_16E7E:                              ; CODE XREF: Physics_ApplyDownwardGravity+4   j
                subi.l  #$A800,d0
loc_16E84:                              ; CODE XREF: Physics_ApplyDownwardGravity+C   j
                move.l  d0,$18(a5)
                rts
; End of function Physics_ApplyDownwardGravity
; Applies upward gravity acceleration with maximum upward velocity limit
Physics_ApplyUpwardGravity:                              ; CODE XREF: Player_AirAttackState+62   j  ; was: sub_16E8A
                                        ; Player_AirControlState+6E   j
                move.l  $18(a5),d0
                bmi.s   loc_16E98
                cmpi.l  #$2A000,d0
                bpl.s   loc_16E9E
loc_16E98:                              ; CODE XREF: Physics_ApplyUpwardGravity+4   j
                addi.l  #$A800,d0
loc_16E9E:                              ; CODE XREF: Physics_ApplyUpwardGravity+C   j
                move.l  d0,$18(a5)
                rts
; End of function Physics_ApplyUpwardGravity
; Applies knockback velocity with direction check
Player_ApplyKnockbackVelocity:                              ; CODE XREF: Player_HandleAirState+30   p  ; was: sub_16EA4
                                        ; Player_HandleAirMovement+34   p ...
                move.l  #$C000,d1
; End of function Player_ApplyKnockbackVelocity
; Decelerates horizontal velocity towards zero
Player_DecelerateHorizontalVelocity:                              ; CODE XREF: Physics_ApplyBossVelocity+2A   p  ; was: sub_16EAA
                                        ; Player_DefeatGroundedState+22   p ...
                move.l  $18(a5),d0
                bmi.s   loc_16EBC
                sub.l   d1,d0
                bpl.s Physics_StoreHorizontalVelocity
                moveq   #0,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_16EBC:                              ; CODE XREF: Player_DecelerateHorizontalVelocity+4   j
                add.l   d1,d0
                bmi.s Physics_StoreHorizontalVelocity
                moveq   #0,d0
; Stores final horizontal velocity to player entity after deceleration
Physics_StoreHorizontalVelocity:                              ; CODE XREF: Player_DecelerateHorizontalVelocity+8   j  ; was: loc_16EC2
                                        ; Player_DecelerateHorizontalVelocity+14   j
                move.l  d0,$18(a5)
                rts
; End of function Player_DecelerateHorizontalVelocity
; Processes collision damage and knockback
Player_ProcessCollisionDamage:                              ; CODE XREF: Player_HandleJump+60   j  ; was: sub_16EC8
                                        ; Player_HandleGroundedState+1E   j ...
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #6,d0
                move.b  byte_16EEA(pc,d0.w),d5
                move.b  byte_16EEA+1(pc,d0.w),d6
                movea.l #word_E8972,a1
                movea.l #word_E8942,a2
                bra.w Stage_HandleBossDefeat
; End of function Player_ProcessCollisionDamage
; ---------------------------------------------------------------------------
byte_16EEA:     dc.b 1, $FE, 0, $FF, 0, 0, 0, $FF
                                        ; DATA XREF: Player_ProcessCollisionDamage+A   r
                                        ; Player_ProcessCollisionDamage+E   r


; Handles player defeat state with direction check
Player_HandleDefeatByBoss:                              ; CODE XREF: Player_HandleAirState+5E   j  ; was: sub_16EF2
                                        ; Player_HandleLandingState+76   j ...
                tst.w   $48(a5)
                bpl.s Player_SetupDefeatSequence1
loc_16EF8:                              ; CODE XREF: Player_JumpApexState+12   j
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #6,d0
                move.b  byte_16F2E(pc,d0.w),d5
                move.b  byte_16F2E+1(pc,d0.w),d6
                movea.l #word_E8972,a1
                movea.l #word_E8F0A,a2
                bra.w Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
; Sets up player defeat sequence animation data and parameters (variant 1)
Player_SetupDefeatSequence1:                              ; CODE XREF: Player_HandleDefeatByBoss+4   j  ; was: loc_16F1A
                moveq   #0,d5
                moveq   #8,d6
                movea.l #word_E8972,a1
                movea.l #word_E89C2,a2
                bra.w Stage_HandleBossDefeat
; End of function Player_HandleDefeatByBoss
; ---------------------------------------------------------------------------
byte_16F2E:     dc.b 1, $F, 0, $10, 0, $11, 0, $10
                                        ; DATA XREF: Player_HandleDefeatByBoss+10   r
                                        ; Player_HandleDefeatByBoss+14   r


; Handles boss death animation frame transitions
