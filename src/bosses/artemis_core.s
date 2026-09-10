Boss_ArtemisIntroStop:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_57EBE
                tst.w   4(a5)
                beq.w   loc_57F0E
                tst.w   8(a5)
                beq.s   loc_57F0E
                btst    #2,(byte_FF80EC).w
                bne.s   loc_57EEA
                btst    #1,(byte_FF80EC).w
                bne.s   loc_57EEA
                tst.w   (word_FF8200).w
                bne.s   loc_57EEA
                moveq   #8,d0
                jmp     Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_57EEA:                                              ; CODE XREF: Boss_ArtemisIntroStop+14   j
                                        ; Boss_ArtemisIntroStop+1C   j
                lea     (word_3E4C).l,a2
                jsr     (Gfx_ProcessColorFade).l
                moveq   #$12,d0
                jsr     (Boss_ValkirieUpdatePalette).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
                clr.b   $3BD(a5)
loc_57F0E:                                              ; CODE XREF: Boss_ArtemisIntroStop+4   j
                                        ; Boss_ArtemisIntroStop+C   j
                move.w  4(a5),d0
                movea.w off_57F1E(pc,d0.w),a0
                adda.l  #Boss_ArtemisBattleStart,a0
                jmp     (a0)
; End of function Boss_ArtemisIntroStop
; ---------------------------------------------------------------------------
off_57F1E:      dc.w    Boss_ArtemisBattleStart-Boss_ArtemisBattleStart
                                        ; DATA XREF: Boss_ArtemisIntroStop+54   r
                dc.w    Boss_ArtemisPlayerInputControl-Boss_ArtemisBattleStart
                dc.w    Boss_ArtemisAttackState1-Boss_ArtemisBattleStart
                dc.w    Boss_Medusa_State1-Boss_ArtemisBattleStart
                dc.w    Boss_Medusa_State2-Boss_ArtemisBattleStart
                dc.w    Boss_ArtemisShootPattern2-Boss_ArtemisBattleStart
                dc.w    Boss_ArtemisSpawnProjectile3-Boss_ArtemisBattleStart
                dc.w    Boss_ArtemisSpawnProjectile6-Boss_ArtemisBattleStart
                dc.w    Projectile_ArtemisBullet1-Boss_ArtemisBattleStart
                dc.w    Boss_ArtemisAnimationUpdate-Boss_ArtemisBattleStart
                dc.w    Projectile_ArtemisHoming-Boss_ArtemisBattleStart
                dc.w    Projectile_ArtemisSpread-Boss_ArtemisBattleStart

; Battle start initialization
Boss_ArtemisBattleStart:                                ; DATA XREF: Boss_ArtemisIntroStop+58   o  ; was: sub_57F36
                                        ; ROM:off_57F1E   o
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$1D,d7
                movea.l #Boss_ArtemisMetaspritePartDescriptors,a0
                movea.l #Boss_ArtemisMetaspriteInitialAngles,a1
                movea.l #Boss_ArtemisMetaspritePartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.l  #Boss_ArtemisMetaspritePoseAngles,$2FC(a5)
                move.l  #word_5886C,$35C(a5)
                move.w  #$438,(a5)
                move.w  #$8C00,2(a5)
                clr.w   6(a5)
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  $14(a0),$14(a5)
                move.w  $18(a0),$18(a5)
                move.w  $1C(a0),$1C(a5)
                move.b  #$10,(byte_FFA420).w
                move.w  #2,$1DE(a5)
                bra.w   Boss_ArtemisIdleState
; End of function Boss_ArtemisBattleStart
; Initializes Artemis boss position and state parameters
Boss_ArtemisInitPositionState:
                move.w  #2,4(a5)                        ; was: sub_57FA8
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$CDA0,$4A(a5)
                move.w  #$130,$794(a5)
                move.w  a5,$48(a5)
                move.w  #$120,$10(a5)
                clr.w   (word_FFA02A).w
; End of function Boss_ArtemisInitPositionState
; Processes player directional input to control Artemis during fight
Boss_ArtemisPlayerInputControl:                         ; DATA XREF: ROM:00057F20   o  ; was: sub_57FDA
                btst    #2,(word_FFF706).w
                beq.s   loc_57FE6
                addq.w  #2,$56(a5)
loc_57FE6:                                              ; CODE XREF: Boss_ArtemisPlayerInputControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_57FF2
                subq.w  #2,$56(a5)
loc_57FF2:                                              ; CODE XREF: Boss_ArtemisPlayerInputControl+12   j
                andi.w  #$1FE,$56(a5)
                lea     word_58786(pc),a1
                nop
                bra.w   Boss_ArtemisAttackState2
; End of function Boss_ArtemisPlayerInputControl
; Idle state handler
Boss_ArtemisIdleState:                                  ; CODE XREF: Boss_ArtemisBattleStart+6E   j  ; was: sub_58002
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$FFE0,$50(a5)
                move.l  #$12000,$1C(a5)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
                move.b  #$26,d0                         ; '&'
                jsr     (Sound_PlaySFX).l
; End of function Boss_ArtemisIdleState
; Attack state 1 handler
Boss_ArtemisAttackState1:                               ; DATA XREF: ROM:00057F22   o  ; was: sub_5803C
                cmpi.w  #$30,$14(a5)                    ; '0'
                bmi.s   loc_58066
                addq.w  #2,$50(a5)
                bmi.s   loc_5804E
                clr.w   $50(a5)
loc_5804E:                                              ; CODE XREF: Boss_ArtemisAttackState1+C   j
                subi.l  #$1000,$1C(a5)
                subi.w  #$C,$56(a5)
                lea     word_58786(pc),a1
                nop
                bra.w   Boss_ArtemisAttackState2
; ---------------------------------------------------------------------------
loc_58066:                                              ; CODE XREF: Boss_ArtemisAttackState1+6   j
                addq.w  #2,4(a5)
                clr.w   $50(a5)
                clr.w   $56(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
; Medusa boss initial movement
Boss_Medusa_State1:                                     ; DATA XREF: ROM:00057F24   o  ; was: loc_5807A
                tst.b   (byte_FFA958).w
                bne.s   loc_5808A
                lea     word_58786(pc),a1
                nop
                bra.w   Boss_ArtemisAttackState2
; ---------------------------------------------------------------------------
loc_5808A:                                              ; CODE XREF: Boss_ArtemisAttackState1+42   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CDA0,$4A(a5)
                move.w  #$170,$10(a5)
                move.w  #$FDC0,$794(a5)
                move.w  #$7000,(word_FF8200).w
                move.w  #$7000,(word_FF8202).w
; Medusa boss attack preparation
Boss_Medusa_State2:                                     ; DATA XREF: ROM:00057F26   o  ; was: loc_580B6
                addi.l  #$78000,$794(a5)
                move.w  $794(a5),d0
                bsr.w   Boss_ArtemisShootPattern3
                bpl.s   loc_580D2
                lea     word_58790(pc),a1
                nop
                bra.w   Boss_ArtemisAttackState2
; ---------------------------------------------------------------------------
loc_580D2:                                              ; CODE XREF: Boss_ArtemisAttackState1+8A   j
                addq.w  #2,4(a5)
                move.w  #$C980,d0
                move.w  #$CDA0,d1
                bsr.w   Boss_ArtemisShootPattern5
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$C2,d0
                jsr     (Sound_PlaySFX).l
                movea.l #Boss_ArtemisAttackObjectInitData,a1
                jsr     (Object_InitGroupFromTable).l
; End of function Boss_ArtemisAttackState1
; Shooting pattern 2
Boss_ArtemisShootPattern2:                              ; DATA XREF: ROM:00057F28   o  ; was: sub_58102
                tst.w   $58(a5)
                bmi.s   loc_58112
                lea     word_5879E(pc),a1
                nop
                bra.w   Boss_ArtemisShootPattern6
; ---------------------------------------------------------------------------
loc_58112:                                              ; CODE XREF: Boss_ArtemisShootPattern2+4   j
                addq.w  #2,4(a5)
                move.b  #$F,$3BC(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #0,2(a5)
                move.b  #$39,d0                         ; '9'
                jsr     (Sound_PlaySFX).l
; End of function Boss_ArtemisShootPattern2
; Spawns projectile type 3
Boss_ArtemisSpawnProjectile3:                           ; DATA XREF: ROM:00057F2A   o  ; was: sub_58136
                tst.w   $58(a5)
                bpl.s   loc_58158
                clr.b   (byte_FF80EC).w
                bclr    #0,(byte_FFA272).w
                clr.w   (word_FFA02A).w
                subi.w  #$40,(word_FFA970).w            ; '@'
                addi.w  #$40,(word_FFA974).w            ; '@'
                bra.s   Boss_ArtemisSpawnProjectile5
; ---------------------------------------------------------------------------
loc_58158:                                              ; CODE XREF: Boss_ArtemisSpawnProjectile3+4   j
                lea     word_587B0(pc),a1
                nop
                bra.w   Boss_ArtemisShootPattern6
; End of function Boss_ArtemisSpawnProjectile3
; Spawns projectile type 4
Boss_ArtemisSpawnProjectile4:                           ; CODE XREF: Boss_ArtemisSpawnProjectile5   p  ; was: sub_58162
                                        ; sub_5818A   p
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$F,$3BC(a5)
                move.w  #$C980,d0
                move.w  #$CF80,d1
                bra.w   Boss_ArtemisShootPattern5
; End of function Boss_ArtemisSpawnProjectile4
; Spawns projectile type 5
Boss_ArtemisSpawnProjectile5:                           ; CODE XREF: Boss_ArtemisSpawnProjectile3+20   j  ; was: sub_58184
                                        ; Boss_ArtemisAnimationUpdate+4   j
                bsr.s   Boss_ArtemisSpawnProjectile4
                bra.w   loc_581E0
; End of function Boss_ArtemisSpawnProjectile5
; Spawns Artemis projectile type 5 by calling projectile 4 spawn
Boss_ArtemisSpawnProjectile5Alt:
                bsr.s   Boss_ArtemisSpawnProjectile4    ; was: sub_5818A
; End of function Boss_ArtemisSpawnProjectile5Alt
; Spawns projectile type 6
Boss_ArtemisSpawnProjectile6:                           ; DATA XREF: ROM:00057F2C   o  ; was: sub_5818C
                tst.w   $58(a5)
                bpl.s   loc_58204
                jsr     (Boss_ValkirieSetFacing).l
                cmpi.w  #$A0,d0
                bpl.s   loc_581B2
                cmpi.w  #$E0,$BC(a5)
                bmi.s   loc_581B2
                cmpi.w  #$220,$BC(a5)
                bpl.s   loc_581B2
                bra.w   Projectile_ArtemisLaser
; ---------------------------------------------------------------------------
loc_581B2:                                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+10   j
                                        ; Boss_ArtemisSpawnProjectile6+18   j
                btst    #0,(dword_FFFF08).w
                beq.s   loc_581E0
                move.w  #$1800,$11C(a5)
                tst.w   (word_FFFF0E).w
                bne.s   loc_581D0
                move.w  (word_FFA000).w,d4
                andi.w  #7,d4
                bne.s   loc_581DC
loc_581D0:                                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+38   j
                cmpi.w  #$C0,d0
                bmi.s   loc_581DC
                move.w  #$B00,$11C(a5)
loc_581DC:                                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+42   j
                                        ; Boss_ArtemisSpawnProjectile6+48   j
                bra.w   loc_5822C
; ---------------------------------------------------------------------------
loc_581E0:                                              ; CODE XREF: Boss_ArtemisSpawnProjectile5+2   j
                                        ; Boss_ArtemisSpawnProjectile6+2C   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  (dword_FFFF08).w,d1
                andi.w  #$1C,d1
                bne.s   loc_581FE
                move.b  #$39,d0                         ; '9'
                jsr     (Sound_PlaySFX).l
loc_581FE:                                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+66   j
                move.l  off_5820C(pc,d1.w),$41C(a5)
loc_58204:                                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+4   j
                movea.l $41C(a5),a1
                bra.w   Boss_ArtemisShootPattern6
; ---------------------------------------------------------------------------
off_5820C:      dc.l    word_587B0                      ; DATA XREF: Boss_ArtemisSpawnProjectile6:loc_581FE   r
                dc.l    word_58818
                dc.l    word_58806
                dc.l    word_58806
                dc.l    word_587F4
                dc.l    word_587F4
                dc.l    word_587E2
                dc.l    word_587E2
; ---------------------------------------------------------------------------
loc_5822C:                                              ; CODE XREF: Boss_ArtemisSpawnProjectile6:loc_581DC   j
                move.w  #$10,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $3BC(a5)
                move.l  #$FFFA0000,$1C(a5)
                move.l  #$FFFB0000,d0
                bsr.w   Projectile_ArtemisBullet2
                move.w  a5,d0
                move.w  a5,d1
                jsr     (Boss_ValkirieSpawnProjectile2).l
                move.w  #$8000,(dword_FF8066).w
                lea     word_582A0(pc),a0
                nop
                jsr     (Boss_ValkirieUpdateParts).l
; End of function Boss_ArtemisSpawnProjectile6
; Bullet projectile type 1
Projectile_ArtemisBullet1:                              ; DATA XREF: ROM:00057F2E   o  ; was: sub_5826E
                bclr    #0,$23E(a5)
                bne.s   loc_582C2
                addi.l  #$4000,$1C(a5)
                lea     word_58826(pc),a1
                nop
                bsr.w   Boss_ArtemisAttackState2
                moveq   #0,d0
                move.w  $11C(a5),d0
                tst.w   $18(a5)
                bpl.s   loc_5829A
                add.l   d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_5829A:                                              ; CODE XREF: Projectile_ArtemisBullet1+24   j
                sub.l   d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
word_582A0:     dc.w    $B7, $7840, $C680, $EC14, $EC14, $C6E0, $EC14, $EC14
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile6+D6   o
                dc.w    $C7A0, $FA06, $FA06, 0
word_582B8:     dc.w    $FF00, $60, $C0, $120, 0
                                        ; DATA XREF: Projectile_ArtemisBullet1+6E   o
; ---------------------------------------------------------------------------
loc_582C2:                                              ; CODE XREF: Projectile_ArtemisBullet1+6   j
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                move.b  #1,$3BC(a5)
                move.w  #$C980,d0
                move.w  #$C980,d1
                bsr.w   Boss_ArtemisShootPattern5
                lea     word_582B8(pc),a0
                jsr     (Boss_ValkirieDestroyParts).l
                bsr.w   Projectile_ArtemisInitSprite1
                move.b  #$C2,d0
                jsr     (Sound_PlaySFX).l
; End of function Projectile_ArtemisBullet1
; Animation frame update
Boss_ArtemisAnimationUpdate:                            ; DATA XREF: ROM:00057F30   o  ; was: sub_582F4
                tst.w   $58(a5)
                bmi.w   Boss_ArtemisSpawnProjectile5
                bsr.w   Boss_ArtemisUpdatePaletteFlags
                lea     word_58826(pc),a1
                nop
                bra.w   Boss_ArtemisShootPattern6
; End of function Boss_ArtemisAnimationUpdate
; Updates palette flags from animation state for Artemis
Boss_ArtemisUpdatePaletteFlags:                         ; CODE XREF: Boss_ArtemisAnimationUpdate+8   p  ; was: sub_5830A
                move.b  $23E(a5),d0
                andi.b  #$F,d0
                or.b    d0,$3BC(a5)
                rts
; End of function Boss_ArtemisUpdatePaletteFlags
; Bullet projectile type 2
Projectile_ArtemisBullet2:                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+C2   p  ; was: sub_58318
                tst.w   $54(a5)
                beq.s   loc_58320
                neg.l   d0
loc_58320:                                              ; CODE XREF: Projectile_ArtemisBullet2+4   j
                move.l  d0,$18(a5)
                rts
; End of function Projectile_ArtemisBullet2
; Initializes sprite graphics for Artemis projectile type 1
Projectile_ArtemisInitSprite1:                          ; CODE XREF: Projectile_ArtemisBullet1+78   p  ; was: sub_58326
                lea     (Boss_ArtemisProjectileInitTable).l,a1
                jmp     Object_InitGroupFromTable
; End of function Projectile_ArtemisInitSprite1
; Laser projectile handler
Projectile_ArtemisLaser:                                ; CODE XREF: Boss_ArtemisSpawnProjectile6+22   j  ; was: sub_58332
                move.w  #$14,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CDA0,d0
                move.w  #$CDA0,d1
                bsr.w   Boss_ArtemisShootPattern5
                move.b  #4,$3BC(a5)
                move.b  #$DC,d0
                jsr     (Sound_PlaySFX).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1C,d0
                tst.w   (word_FFFF0E).w
                bne.s   loc_5836E
                moveq   #0,d0
loc_5836E:                                              ; CODE XREF: Projectile_ArtemisLaser+38   j
                lea     off_583D2(pc),a0
                nop
                movea.l (a0,d0.w),a0
                move.l  (a0)+,d5
                move.l  (a0)+,d4
                move.w  (a0)+,d7
                moveq   #$40,d6                         ; '@'
                bsr.w   Boss_ArtemisUpdateSprites
; End of function Projectile_ArtemisLaser
; Homing projectile handler
Projectile_ArtemisHoming:                               ; DATA XREF: ROM:00057F32   o  ; was: sub_58384
                bclr    #7,$23E(a5)
                bne.w   Projectile_ArtemisWave
                bclr    #0,$23E(a5)
                beq.s   loc_583A8
                move.w  #$C980,d0
                move.w  #$C980,d1
                bsr.w   Boss_ArtemisShootPattern5
                move.b  #1,$3BC(a5)
loc_583A8:                                              ; CODE XREF: Projectile_ArtemisHoming+10   j
                bclr    #1,$23E(a5)
                beq.s   loc_583C2
                move.w  #$CBC0,d0
                move.w  #$CBC0,d1
                bsr.w   Boss_ArtemisShootPattern5
                move.b  #3,$3BC(a5)
loc_583C2:                                              ; CODE XREF: Projectile_ArtemisHoming+2A   j
                move.b  #1,$3BD(a5)
                lea     word_58848(pc),a1
                nop
                bra.w   Boss_ArtemisAttackState2
; End of function Projectile_ArtemisHoming
; ---------------------------------------------------------------------------
off_583D2:      dc.l    word_583F2                      ; DATA XREF: Projectile_ArtemisLaser:loc_5836E   o
                dc.l    word_583F2
                dc.l    word_583F2
                dc.l    word_583FC
                dc.l    word_58406
                dc.l    word_58406
                dc.l    word_58406
                dc.l    word_58410
word_583F2:     dc.w    0, 0, 0, 0, $D8                 ; DATA XREF: ROM:off_583D2   o
                                        ; ROM:000583D6   o
word_583FC:     dc.w    0, $2000, $FFFF, $D000, $CA
                                        ; DATA XREF: ROM:000583DE   o
word_58406:     dc.w    0, $2000, 0, $4000, $140
                                        ; DATA XREF: ROM:000583E2   o
                                        ; ROM:000583E6   o
word_58410:     dc.w    0, $2600, 0, $E00, $110
                                        ; DATA XREF: ROM:000583EE   o

; Wave projectile handler
Projectile_ArtemisWave:                                 ; CODE XREF: Projectile_ArtemisHoming+6   j  ; was: sub_5841A
                addq.w  #2,4(a5)
                move.b  #$F,$3BC(a5)
                move.w  #$C980,d0
                move.w  #$CF80,d1
                bsr.w   Boss_ArtemisShootPattern5
; End of function Projectile_ArtemisWave
; Spread projectile handler
Projectile_ArtemisSpread:                               ; DATA XREF: ROM:00057F34   o  ; was: sub_58430
                tst.w   $58(a5)
                bpl.s   loc_5843E
                clr.w   $56(a5)
                bra.w   Boss_ArtemisSpawnProjectile5
; ---------------------------------------------------------------------------
loc_5843E:                                              ; CODE XREF: Projectile_ArtemisSpread+4   j
                move.b  #1,$3BD(a5)
                lea     word_58848(pc),a1
                nop
                bra.w   Boss_ArtemisAttackState2
; End of function Projectile_ArtemisSpread
; Shooting pattern 3
Boss_ArtemisShootPattern3:                              ; CODE XREF: Boss_ArtemisAttackState1+86   p  ; was: sub_5844E
                bmi.s   locret_5845E
                move.w  (dword_FFA904).w,d6
                subi.w  #$E200,d6
                addi.w  #$12A,d6
                cmp.w   d6,d0
locret_5845E:                                           ; CODE XREF: Boss_ArtemisShootPattern3   j
                rts
; End of function Boss_ArtemisShootPattern3
; Shooting pattern 4
Boss_ArtemisShootPattern4:                              ; CODE XREF: Boss_ArtemisShootPattern5+6   p  ; was: sub_58460
                                        ; sub_5847C   p
                move.w  (dword_FFA904).w,d6
                subi.w  #$E200,d6
                addi.w  #$12A,d6
                rts
; End of function Boss_ArtemisShootPattern4
; Shooting pattern 5
Boss_ArtemisShootPattern5:                              ; CODE XREF: Boss_ArtemisAttackState1+A2   p  ; was: sub_5846E
                                        ; Boss_ArtemisSpawnProjectile4+1E   j
                jsr     (Boss_ValkirieSpawnProjectile2).l
                bsr.s   Boss_ArtemisShootPattern4
                move.w  d6,$14(a0)
                rts
; End of function Boss_ArtemisShootPattern5
; Shooting pattern 6
Boss_ArtemisShootPattern6:                              ; CODE XREF: Boss_ArtemisShootPattern2+C   j  ; was: sub_5847C
                                        ; Boss_ArtemisSpawnProjectile3+28   j
                bsr.s   Boss_ArtemisShootPattern4
                movea.w $4A(a5),a0
                move.w  d6,$14(a0)
; End of function Boss_ArtemisShootPattern6
; Attack state 2 handler
Boss_ArtemisAttackState2:                               ; CODE XREF: Boss_ArtemisPlayerInputControl+24   j  ; was: sub_58486
                                        ; Boss_ArtemisAttackState1+26   j
                bsr.w   Boss_ArtemisMovePattern1
                bsr.w   Boss_ArtemisAttackState3
                moveq   #$1C,d7
                jsr     (Sprite_BeginMetaspritePartTraversal).l
                move.w  (dword_FFA904).w,d6
                subi.w  #$E200,d6
                addi.w  #$12A,d6
                btst    #0,$3BC(a5)
                beq.s   loc_584B0
                movea.w #(word_FFC980-M68K_RAM),a0
                bsr.s   Projectile_ArtemisMain
loc_584B0:                                              ; CODE XREF: Boss_ArtemisAttackState2+22   j
                btst    #1,$3BC(a5)
                beq.s   loc_584BE
                movea.w #(byte_FFCBC0-M68K_RAM),a0
                bsr.s   Projectile_ArtemisMain
loc_584BE:                                              ; CODE XREF: Boss_ArtemisAttackState2+30   j
                btst    #2,$3BC(a5)
                beq.s   loc_584CC
                movea.w #(word_FFCDA0-M68K_RAM),a0
                bsr.s   Projectile_ArtemisMain
loc_584CC:                                              ; CODE XREF: Boss_ArtemisAttackState2+3E   j
                btst    #3,$3BC(a5)
                beq.s   locret_584DA
                movea.w #(word_FFCF80-M68K_RAM),a0
                bra.s   Projectile_ArtemisMain
; ---------------------------------------------------------------------------
locret_584DA:                                           ; CODE XREF: Boss_ArtemisAttackState2+4C   j
                rts
; End of function Boss_ArtemisAttackState2
; Projectile main handler
