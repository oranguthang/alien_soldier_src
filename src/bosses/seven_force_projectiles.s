Gfx_LoadArtemisTiles:                                   ; CODE XREF: Boss_SylpheedSpawnProjectile4+16   p  ; was: sub_19F70
                                        ; Projectile_SylpheedBullet2+6   p
                btst    #5,$6A(a5)
                beq.w   locret_1A01A
                move.w  #6,4(a5)
                move.b  #$73,(byte_FF830F).w            ; 's'
                jsr     (Sys_ClearObjectBlocks16).l
                move.b  #$A6,d0
                jsr     (Sound_PlaySFX).l
                move.b  #1,(word_FF8224).w
                move.w  #$C,$50(a5)
                clr.w   $12(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                btst    #2,$69(a5)
                bne.s   loc_19FC6
                btst    #3,$69(a5)
                bne.s   loc_19FD6
                btst    #3,$E(a5)
                bne.s   loc_19FD6
loc_19FC6:                                              ; CODE XREF: Gfx_LoadArtemisTiles+44   j
                move.l  #$FFF88000,$48(a5)
                bclr    #3,$E(a5)
                bra.s   loc_19FE4
; ---------------------------------------------------------------------------
loc_19FD6:                                              ; CODE XREF: Gfx_LoadArtemisTiles+4C   j
                                        ; Gfx_LoadArtemisTiles+54   j
                move.l  #$78000,$48(a5)
                bset    #3,$E(a5)
loc_19FE4:                                              ; CODE XREF: Gfx_LoadArtemisTiles+64   j
                tst.w   (word_FF8304).w
                bne.s   loc_1A00A
                btst    #7,(byte_FF8245).w
                bne.s   loc_1A00A
                jsr     (Player_SpawnProjectile).l
                move.l  #word_E8E6A,8(a5)
                move.w  #$78,(word_FF8304).w            ; 'x'
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
loc_1A00A:                                              ; CODE XREF: Gfx_LoadArtemisTiles+78   j
                                        ; Gfx_LoadArtemisTiles+80   j
                move.l  #word_E86AA,8(a5)
                move.w  #$78,(word_FF8304).w            ; 'x'
                moveq   #1,d0
locret_1A01A:                                           ; CODE XREF: Gfx_LoadArtemisTiles+6   j
                rts
; End of function Gfx_LoadArtemisTiles
; Loads Artemis palette
Gfx_LoadArtemisPalette:                                 ; DATA XREF: ROM:00019E1C   o  ; was: sub_1A01C
                tst.b   (byte_FF8311).w
                bne.s   loc_1A028
                subq.w  #1,$50(a5)
                bpl.s   loc_1A046
loc_1A028:                                              ; CODE XREF: Gfx_LoadArtemisPalette+4   j
                clr.w   (word_FFC5C0).w
                bclr    #0,(byte_FF826C).w
                bclr    #6,$21(a5)
                bclr    #4,$23(a5)
                clr.w   (word_FF8224).w
                bra.w   Boss_SylpheedSpawnProjectile3
; ---------------------------------------------------------------------------
loc_1A046:                                              ; CODE XREF: Gfx_LoadArtemisPalette+A   j
                move.w  #1,(word_FF809C).w
                bset    #6,$21(a5)
                bset    #4,$23(a5)
                bsr.s   Gfx_UpdateTrackerSprites
                bsr.s   Gfx_UpdateTrackerSprites
                bsr.s   Gfx_UpdateTrackerSprites
                bset    #4,(byte_FF8244).w
                jmp     Effect_CreateDashTrail
; End of function Gfx_LoadArtemisPalette
; Updates tracker sprites
Gfx_UpdateTrackerSprites:                               ; CODE XREF: Gfx_LoadArtemisPalette+3C   p  ; was: sub_1A06A
                                        ; Gfx_LoadArtemisPalette+3E   p
                move.l  $48(a5),d0
                add.l   d0,$10(a5)
                rts
; End of function Gfx_UpdateTrackerSprites
; Checks if boss takes damage
Boss_SylpheedDamageCheck:                               ; CODE XREF: Boss_SylpheedSpawnProjectile4+22   j  ; was: sub_1A074
                                        ; Projectile_SylpheedBullet2+12   j
                jsr     (Player_SpawnDamageImpactEffect).l
                move.b  #$7F,(byte_FF830F).w
                jsr     (Sys_ClearObjectBlocks16).l
                move.w  #8,4(a5)
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$1C,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_1A0B8
                neg.l   $18(a5)
locret_1A0B8:                                           ; CODE XREF: Boss_SylpheedDamageCheck+3E   j
                rts
; End of function Boss_SylpheedDamageCheck
; Updates boss health
Boss_SylpheedUpdateHealth:                              ; DATA XREF: ROM:00019E1E   o  ; was: sub_1A0BA
                subq.w  #1,$4A(a5)
                bmi.w   Boss_SylpheedSpawnProjectile3
                jmp     Player_AnimateDefeatSprite
; End of function Boss_SylpheedUpdateHealth
; Defeat sequence init
Boss_DestroyerProtoDefeatInit:                          ; CODE XREF: Boss_SylpheedSpawnProjectile1+14   p  ; was: sub_1A0C8
                move.b  #$19,d0
                jsr     (Sound_PlaySFX).l
                move.b  #$7F,(byte_FF830F).w
                move.w  #$8000,(word_FF80E6).w
                jsr     (Sys_ClearObjectBlocks17).l
                move.w  #$A,4(a5)
                move.w  #$10,$48(a5)
                tst.w   (dword_FF8300).w
                beq.s   loc_1A10C
                bmi.s   loc_1A102
                move.l  #$38000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_1A102:                                              ; CODE XREF: Boss_DestroyerProtoDefeatInit+2E   j
                move.l  #$FFFC8000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_1A10C:                                              ; CODE XREF: Boss_DestroyerProtoDefeatInit+2C   j
                move.l  #$FFFC8000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_1A120
                neg.l   $18(a5)
locret_1A120:                                           ; CODE XREF: Boss_DestroyerProtoDefeatInit+52   j
                                        ; Boss_DestroyerProtoDefeatAnim+1A   j
                rts
; End of function Boss_DestroyerProtoDefeatInit
; Defeat animation handler
Boss_DestroyerProtoDefeatAnim:                          ; DATA XREF: ROM:00019E20   o  ; was: sub_1A122
                movea.l #word_E8BAA,a1
                movea.l #word_E89C2,a2
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFF,d6
                jsr     (Player_BuildSpritePieces).l
                subq.w  #1,$48(a5)
                bpl.s   locret_1A120
                clr.w   (word_FF80E6).w
                move.w  #$CC00,2(a5)
                move.b  #$80,$21(a5)
                bra.w   Boss_SylpheedSpawnProjectile3
; End of function Boss_DestroyerProtoDefeatAnim
; Laser projectile handler
Projectile_SylpheedLaser:                               ; CODE XREF: Projectile_SylpheedBullet2+32   p  ; was: sub_1A152
                lea     word_1A1E2(pc),a0
                nop
                move.b  $69(a5),d0
                andi.w  #$F,d0
                move.b  (a0,d0.w),d0
                asl.w   #1,d0
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                move.w  d1,d3
                move.w  d2,d4
                muls.w  #$E,d3
                muls.w  #$12,d4
                ext.l   d1
                ext.l   d2
                asl.l   #1,d1
                asl.l   #1,d2
                add.l   $1C(a5),d1
                bpl.s   loc_1A1A6
                tst.l   d3
                beq.s   loc_1A1AE
                bpl.s   loc_1A19A
                cmp.l   d1,d3
                bpl.s   loc_1A1AE
                bra.s   loc_1A1B0
; ---------------------------------------------------------------------------
loc_1A19A:                                              ; CODE XREF: Projectile_SylpheedLaser+40   j
                                        ; Projectile_SylpheedLaser+56   j
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$1C(a5)
                bra.s   loc_1A1B4
; ---------------------------------------------------------------------------
loc_1A1A6:                                              ; CODE XREF: Projectile_SylpheedLaser+3A   j
                tst.l   d3
                bmi.s   loc_1A19A
                cmp.l   d1,d3
                bpl.s   loc_1A1B0
loc_1A1AE:                                              ; CODE XREF: Projectile_SylpheedLaser+3E   j
                                        ; Projectile_SylpheedLaser+44   j
                move.l  d3,d1
loc_1A1B0:                                              ; CODE XREF: Projectile_SylpheedLaser+46   j
                                        ; Projectile_SylpheedLaser+5A   j
                move.l  d1,$1C(a5)
loc_1A1B4:                                              ; CODE XREF: Projectile_SylpheedLaser+52   j
                add.l   $18(a5),d2
                bpl.s   loc_1A1D2
                tst.l   d4
                beq.s   loc_1A1DA
                bpl.s   loc_1A1C6
                cmp.l   d2,d4
                bpl.s   loc_1A1DA
                bra.s   loc_1A1DC
; ---------------------------------------------------------------------------
loc_1A1C6:                                              ; CODE XREF: Projectile_SylpheedLaser+6C   j
                                        ; Projectile_SylpheedLaser+82   j
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_1A1D2:                                              ; CODE XREF: Projectile_SylpheedLaser+66   j
                tst.l   d4
                bmi.s   loc_1A1C6
                cmp.l   d2,d4
                bpl.s   loc_1A1DC
loc_1A1DA:                                              ; CODE XREF: Projectile_SylpheedLaser+6A   j
                                        ; Projectile_SylpheedLaser+70   j
                move.l  d4,d2
loc_1A1DC:                                              ; CODE XREF: Projectile_SylpheedLaser+72   j
                                        ; Projectile_SylpheedLaser+86   j
                move.l  d2,$18(a5)
                rts
; End of function Projectile_SylpheedLaser
; ---------------------------------------------------------------------------
word_1A1E2:     dc.w    $C0, $4000, $80A0, $6000, $E0, $2000, 0, 0
                                        ; DATA XREF: Projectile_SylpheedLaser   o

; Homing projectile handler
Projectile_SylpheedHoming:                              ; CODE XREF: Boss_SylpheedSpawnProjectile4+6   p  ; was: sub_1A1F2
                                        ; Boss_SylpheedCollisionCheck+A   p
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$1C(a5)
                rts
; End of function Projectile_SylpheedHoming
; Wave projectile handler
Projectile_SylpheedWave:                                ; CODE XREF: Boss_SylpheedSpawnProjectile4:loc_19E96   j  ; was: sub_1A208
                                        ; Projectile_SylpheedBullet2+36   j
                movea.l #word_E8F3A,a2
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1A21C
                movea.l #word_E8F6A,a2
loc_1A21C:                                              ; CODE XREF: Projectile_SylpheedWave+C   j
                btst    #4,$69(a5)
                bne.s   loc_1A23A
                jsr     (Player_UpdateHorizontalFacing).l
                movea.l #word_E8972,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                jmp     Player_BuildSpritePieces
; ---------------------------------------------------------------------------
loc_1A23A:                                              ; CODE XREF: Projectile_SylpheedWave+1A   j
                lea     (word_198B2).l,a4
                moveq   #0,d5
                moveq   #$FFFFFFFF,d6
                lea     (Player_AlternateAnimationLayoutTable).l,a0
                jmp     Player_PrepareSpriteRendering_WithTables
; End of function Projectile_SylpheedWave
; Animation script interpreter
Boss_SireneAnimationScript:                             ; CODE XREF: Boss_SylpheedCollisionCheck+E   j  ; was: sub_1A250
                movea.l #word_E8F3A,a2
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1A264
                movea.l #word_E8F6A,a2
loc_1A264:                                              ; CODE XREF: Boss_SireneAnimationScript+C   j
                movea.l #word_E8972,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                jmp     Player_BuildSpritePieces
; End of function Boss_SireneAnimationScript
; Background graphics setup
Gfx_SireneBackground:                                   ; CODE XREF: Player_Update+50   j  ; was: sub_1A274
                bsr.w   Boss_SylpheedSpawnProjectile1
                bset    #0,2(a5)
                rts
; End of function Gfx_SireneBackground
; Updates object spawner state and triggers
