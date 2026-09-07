Boss_DestroyerMK2Main:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4A84E
                tst.w   4(a5)
                beq.w   loc_4A8F4
                bsr.w   Boss_DestroyerMK2IntroRoar
                btst    #1,$4C(a5)
                bne.s   loc_4A876
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_4A876
                move.w  $50(a5),d0
                beq.s   loc_4A876
                sub.w   d0,(word_FF8234).w
loc_4A876:                                              ; CODE XREF: Boss_DestroyerMK2Main+12   j
                                        ; Boss_DestroyerMK2Main+1C   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_4A8A4
                btst    #1,(byte_FF80EC).w
                bne.s   loc_4A8A4
                tst.w   (word_FF8200).w
                bne.s   loc_4A8A4
                move.b  #2,(byte_FF80EC).w
                bset    #0,$4C(a5)
                move.w  #$2A,4(a5)                      ; '*'
                bset    #0,(byte_FFA272).w
loc_4A8A4:                                              ; CODE XREF: Boss_DestroyerMK2Main+2E   j
                                        ; Boss_DestroyerMK2Main+36   j
                jsr     (Gfx_InitPaletteFade).l
                bsr.w   Boss_DestroyerMK2ShootPattern2
                btst    #3,$4C(a5)
                beq.s   loc_4A8DA
                move.w  #$C70,d0
                sub.w   (dword_FFA900).w,d0
                addi.w  #-$80,d0
                lea     (word_FFE520).w,a0
                lea     (word_FF98B0).w,a1
                move.w  #$B6,d7
loc_4A8CE:                                              ; CODE XREF: Boss_DestroyerMK2Main+88   j
                move.w  d0,(a0)
                move.w  (a1)+,d1
                add.w   d1,(a0)
                addq.w  #4,a0
                dbf     d7,loc_4A8CE
loc_4A8DA:                                              ; CODE XREF: Boss_DestroyerMK2Main+66   j
                lea     (word_FFE6E0).w,a0
                move.w  (a0),d0
                addi.w  #$C0,d0
                move.w  d0,$10(a5)
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$4E(a5)
loc_4A8F4:                                              ; CODE XREF: Boss_DestroyerMK2Main+4   j
                move.w  4(a5),d0
                lea     off_4A900(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2Main
; ---------------------------------------------------------------------------
off_4A900:      dc.w    Boss_DestroyerMK2Dispatcher-*   ; DATA XREF: Boss_DestroyerMK2Main+AA   o
                dc.w    Boss_DestroyerMK2IdleState-*
                dc.w    Boss_DestroyerMK2AttackState1-*
                dc.w    Boss_DestroyerMK2AttackState2-*
                dc.w    Boss_DestroyerMK2MoveLeft-*
                dc.w    Boss_DestroyerMK2MoveRight-*
                dc.w    Boss_DestroyerMK2Jump-*
                dc.w    Boss_DestroyerMK2SpawnMissile-*
                dc.w    Boss_DestroyerMK2SpawnLaser-*
                dc.w    Projectile_DestroyerMK2Spread-*
                dc.w    Projectile_DestroyerMK2Spread_DescendLoop-*
                dc.w    Boss_DestroyerMK2DamageCheck-*
                dc.w    Boss_DestroyerMK2RecoverFromStun-*
                dc.w    Boss_DestroyerMK2Enrage-*
                dc.w    Boss_DestroyerMK2AnimIdle-*
                dc.w    Boss_DestroyerMK2AnimAttack-*
                dc.w    Boss_DestroyerMK2AnimJump-*
                dc.w    Boss_DestroyerMK2AnimLand-*
                dc.w    Boss_DestroyerMK2AnimDamage-*
                dc.w    Boss_DestroyerMK2DefeatFall-*
                dc.w    Boss_DestroyerMK2DefeatExplosion1-*
                dc.w    Effect_DestroyerMK2Explosion1-*
                dc.w    Effect_DestroyerMK2Explosion2-*
                dc.w    Boss_DestroyerMK2BerserkAttack1-*
                dc.w    Boss_DestroyerMK2BerserkRush-*
                dc.w    Boss_DestroyerMK2BerserkSpin-*
                dc.w    Boss_DestroyerMK2BerserkJump-*
                dc.w    Boss_DestroyerMK2BerserkRoar-*

; Boss state dispatcher
Boss_DestroyerMK2Dispatcher:                            ; DATA XREF: ROM:off_4A900   o  ; was: sub_4A938
                tst.w   (word_FFF720).w
                bmi.w   locret_4AB16
                addq.w  #2,4(a5)
                moveq   #0,d0
                move.l  d0,(dword_FF9404).w
                move.l  d0,(dword_FF9408).w
                move.l  d0,(dword_FF940C).w
                clr.w   (dword_FF9418).w
                lea     (word_FF9820).w,a0
                lea     (word_FF9620).w,a1
                move.w  #$7F,d7
loc_4A962:                                              ; CODE XREF: Boss_DestroyerMK2Dispatcher+2E   j
                move.l  d0,(a0)+
                move.l  d0,(a1)+
                dbf     d7,loc_4A962
                move.b  #4,(byte_FFA420).w
                bset    #3,$4C(a5)
                move.w  #$240,d0
                move.w  #$3DC,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$C0,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  #$118,$14(a5)
                move.b  #4,(byte_FFA95B).w
                move.b  #1,(byte_FFA95A).w
                lea     (word_FFE520).w,a0
                move.w  #$FF80,d0
                move.w  #$B7,d7
loc_4A9AE:                                              ; CODE XREF: Boss_DestroyerMK2Dispatcher+7A   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_4A9AE
                move.b  #$40,$20(a5)                    ; '@'
                move.w  #$100,2(a5)
                move.b  #$88,$23(a5)
                move.w  #$96,$26(a5)
                move.l  #$F808E818,$2C(a5)
                move.l  #$F40CE020,$28(a5)
                move.w  #$1C,$24(a5)
                move.w  #8,(dword_FF9410).w
                movea.w #(word_FFC740-M68K_RAM),a0
                move.w  #$25C,(a0)
                move.b  #$10,$23(a0)
                move.w  #$D00,2(a0)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$D00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$96,$26(a0)
                move.b  #$10,$23(a0)
                move.l  #$28E020,$2C(a0)
                move.l  #$34D030,$28(a0)
                move.w  #$FFC0,$4C(a0)
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$D00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$96,$26(a0)
                move.b  #$10,$23(a0)
                move.l  #$D800E020,$2C(a0)
                move.l  #$CC00D030,$28(a0)
                move.w  #$40,$4C(a0)                    ; '@'
                move.b  $20(a5),d1
                move.w  #3,d7
                clr.w   d6
                movea.w #(word_FFC7A0-M68K_RAM),a0
                lea     word_4AB18(pc),a1
                nop
loc_4AA7E:                                              ; CODE XREF: Boss_DestroyerMK2Dispatcher+17C   j
                move.w  #$244,(a0)
                move.w  #$4D00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$96,$26(a0)
                move.b  d1,$20(a0)
                move.l  #word_EC2AA,8(a0)
                move.w  (a1)+,$4E(a0)
                move.w  (a1)+,$4A(a0)
                move.w  (a1)+,$4C(a0)
                move.w  (a1)+,$E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AA7E
                move.w  #$D0,(dword_FF9404).w
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
                clr.w   d6
loc_4AAC8:                                              ; CODE XREF: Boss_DestroyerMK2Dispatcher+1DA   j
                move.w  #$258,(a0)
                move.w  #$CD00,2(a0)
                move.b  #$18,$23(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.l  #$F808F808,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$30,$24(a0)                    ; '0'
                move.b  d1,$20(a0)
                move.l  #word_EC2D4,8(a0)
                move.w  #$EB00,$E(a0)
                move.w  d6,$4C(a0)
                addi.w  #$40,d6                         ; '@'
                lea     $60(a0),a0
                dbf     d7,loc_4AAC8
locret_4AB16:                                           ; CODE XREF: Boss_DestroyerMK2Dispatcher+4   j
                rts
; End of function Boss_DestroyerMK2Dispatcher
; ---------------------------------------------------------------------------
word_4AB18:     dc.w    0, $FFD4, $FFC4, $F300
                                        ; DATA XREF: Boss_DestroyerMK2Dispatcher+140   o
                dc.w    2, $2C, $FFC4, $FB00
                dc.w    4, $FFD4, $3C, $E300
                dc.w    6, $2C, $3C, $EB00

; Idle state handler
Boss_DestroyerMK2IdleState:                             ; DATA XREF: ROM:0004A902   o  ; was: sub_4AB38
                move.b  #3,(word_FFF7E6+1).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2IdleState
; Attack state 1 handler
Boss_DestroyerMK2AttackState1:                          ; DATA XREF: ROM:0004A904   o  ; was: sub_4AB44
                addq.w  #2,4(a5)
                lea     word_4AB56(pc),a0
                nop
                jsr     (Gfx_DMATransferTiles).l
                rts
; End of function Boss_DestroyerMK2AttackState1
; ---------------------------------------------------------------------------
word_4AB56:     dc.w    $4480, $2000, $304, $9697, $9495, $9293, $9091, $8687, $8485, $8A8B, $8889, $8E8F, $8C8D
                                        ; DATA XREF: Boss_DestroyerMK2AttackState1+4   o

; Attack state 2 handler
Boss_DestroyerMK2AttackState2:                          ; DATA XREF: ROM:0004A906   o  ; was: sub_4AB70
                tst.b   (word_FFF720).w
                bmi.s   locret_4AB8E
                move.w  #8,(dword_FF940C).w
                bsr.w   Boss_DestroyerMK2ShootPattern3
                bsr.w   Boss_DestroyerMK2Land
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4AB8E:                                           ; CODE XREF: Boss_DestroyerMK2AttackState2+4   j
                rts
; End of function Boss_DestroyerMK2AttackState2
; Move left state
Boss_DestroyerMK2MoveLeft:                              ; DATA XREF: ROM:0004A908   o  ; was: sub_4AB90
                bsr.w   Boss_DestroyerMK2CollisionCheck
                bsr.w   Boss_DestroyerMK2CollisionCheck
                bsr.w   Boss_DestroyerMK2CollisionCheck
                bsr.w   Boss_DestroyerMK2CollisionCheck
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                subq.w  #1,$48(a5)
                bne.s   locret_4ABC4
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
                move.b  #$5B,d0                         ; '['
                jsr     (Sound_PlaySFX).l
locret_4ABC4:                                           ; CODE XREF: Boss_DestroyerMK2MoveLeft+20   j
                rts
; End of function Boss_DestroyerMK2MoveLeft
; Move right state
Boss_DestroyerMK2MoveRight:                             ; DATA XREF: ROM:0004A90A   o  ; was: sub_4ABC6
                bsr.w   Boss_DestroyerMK2ShootPattern3
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                move.w  #$E0,d0
                bsr.w   Boss_DestroyerMK2ShootPattern1
                addq.w  #4,$4A(a5)
                cmpi.w  #$100,$4A(a5)
                bne.s   locret_4ABFA
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                moveq   #0,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
locret_4ABFA:                                           ; CODE XREF: Boss_DestroyerMK2MoveRight+22   j
                rts
; End of function Boss_DestroyerMK2MoveRight
; Jump attack state
Boss_DestroyerMK2Jump:                                  ; DATA XREF: ROM:0004A90C   o  ; was: sub_4ABFC
                bsr.w   Boss_DestroyerMK2ShootPattern3
                subq.w  #1,$48(a5)
                bne.s   locret_4AC10
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4AC10:                                           ; CODE XREF: Boss_DestroyerMK2Jump+8   j
                rts
; End of function Boss_DestroyerMK2Jump
; Spawns missile projectile
Boss_DestroyerMK2SpawnMissile:                          ; DATA XREF: ROM:0004A90E   o  ; was: sub_4AC12
                bsr.w   Boss_DestroyerMK2ShootPattern3
                subq.w  #1,$48(a5)
                bne.s   locret_4AC2E
                bsr.w   Projectile_DestroyerMK2Missile
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
locret_4AC2E:                                           ; CODE XREF: Boss_DestroyerMK2SpawnMissile+8   j
                rts
; End of function Boss_DestroyerMK2SpawnMissile
; Missile projectile handler
Projectile_DestroyerMK2Missile:                         ; CODE XREF: Boss_DestroyerMK2SpawnMissile+A   p  ; was: sub_4AC30
                                        ; Boss_DestroyerMK2AnimAttack+2A   p
                move.b  #$D0,$21(a5)
                move.b  #$C0,(byte_FFC6A1).w
                move.b  #$C0,(byte_FFC701).w
                movea.w #(word_FFC7A0-M68K_RAM),a0
                move.w  #$B,d7
loc_4AC4A:                                              ; CODE XREF: Projectile_DestroyerMK2Missile+24   j
                move.b  #$C0,$21(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AC4A
                rts
; End of function Projectile_DestroyerMK2Missile
; Laser projectile handler
Projectile_DestroyerMK2Laser:                           ; CODE XREF: Projectile_DestroyerMK2Spread+2E   p  ; was: sub_4AC5A
                                        ; Effect_DestroyerMK2Explosion1+22   p
                clr.b   $21(a5)
                clr.b   (byte_FFC6A1).w
                clr.b   (byte_FFC701).w
                movea.w #(word_FFC7A0-M68K_RAM),a0
                move.w  #$B,d7
loc_4AC6E:                                              ; CODE XREF: Projectile_DestroyerMK2Laser+1C   j
                clr.b   $21(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AC6E
                rts
; End of function Projectile_DestroyerMK2Laser
; Spawns laser projectile
Boss_DestroyerMK2SpawnLaser:                            ; DATA XREF: ROM:0004A910   o  ; was: sub_4AC7C
                bsr.w   Boss_DestroyerMK2ShootPattern3
                tst.w   (word_FF80C2).w
                bne.s   locret_4ACAA
                addq.w  #2,4(a5)
                subi.w  #$A0,(word_FFA970).w
                clr.b   (byte_FF80EC).w
                movea.w #(word_FFC920-M68K_RAM),a0
                move.w  #8,d7
loc_4AC9C:                                              ; CODE XREF: Boss_DestroyerMK2SpawnLaser+2A   j
                move.b  #8,$23(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AC9C
locret_4ACAA:                                           ; CODE XREF: Boss_DestroyerMK2SpawnLaser+8   j
                rts
; End of function Boss_DestroyerMK2SpawnLaser
; Spread shot projectile
Projectile_DestroyerMK2Spread:                          ; DATA XREF: ROM:0004A912   o  ; was: sub_4ACAC
                bsr.w   Boss_DestroyerMK2ShootPattern3
                eori.w  #1,$54(a5)
                bne.s   loc_4ACC0
                move.w  #$20,4(a5)                      ; ' '
                rts
; ---------------------------------------------------------------------------
loc_4ACC0:                                              ; CODE XREF: Projectile_DestroyerMK2Spread+A   j
                addq.w  #2,4(a5)
; Execute spread attack while descending to landing
Projectile_DestroyerMK2Spread_DescendLoop:              ; DATA XREF: ROM:0004A914   o  ; was: loc_4ACC4
                bsr.w   Boss_DestroyerMK2ShootPattern3
                bsr.s   Boss_DestroyerMK2ToggleShields
                subq.w  #4,(dword_FF9404).w
                cmpi.w  #$60,(dword_FF9404).w           ; '`'
                bcc.s   locret_4ACE8
                bsr.s   Boss_DestroyerMK2DisableShields
                bsr.s   Boss_DestroyerMK2Land
                bsr.w   Projectile_DestroyerMK2Laser
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4ACE8:                                           ; CODE XREF: Projectile_DestroyerMK2Spread+28   j
                rts
; End of function Projectile_DestroyerMK2Spread
; Landing after jump
Boss_DestroyerMK2Land:                                  ; CODE XREF: Boss_DestroyerMK2AttackState2+10   p  ; was: sub_4ACEA
                                        ; Projectile_DestroyerMK2Spread+2C   p
                move.w  #$FF,d7
                lea     (dword_FF9420).w,a0
loc_4ACF2:                                              ; CODE XREF: Boss_DestroyerMK2Land+A   j
                move.w  d7,(a0)+
                dbf     d7,loc_4ACF2
                rts
; End of function Boss_DestroyerMK2Land
; Toggles 8 shield sprite priority bits
Boss_DestroyerMK2ToggleShields:                         ; CODE XREF: Projectile_DestroyerMK2Spread+1C   p  ; was: sub_4ACFA
                                        ; Boss_DestroyerMK2AnimAttack+10   p
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
loc_4AD02:                                              ; CODE XREF: Boss_DestroyerMK2ToggleShields+12   j
                eori.w  #$8000,2(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AD02
                rts
; End of function Boss_DestroyerMK2ToggleShields
; Disables all 8 shields
Boss_DestroyerMK2DisableShields:                        ; CODE XREF: Projectile_DestroyerMK2Spread+2A   p  ; was: sub_4AD12
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
loc_4AD1A:                                              ; CODE XREF: Boss_DestroyerMK2DisableShields+16   j
                andi.w  #$7FFF,2(a0)
                clr.b   $21(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AD1A
                rts
; End of function Boss_DestroyerMK2DisableShields
; Enables all 8 shields with palette
Boss_DestroyerMK2EnableShields:                         ; CODE XREF: Boss_DestroyerMK2AnimAttack+20   p  ; was: sub_4AD2E
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
loc_4AD36:                                              ; CODE XREF: Boss_DestroyerMK2EnableShields+18   j
                ori.w   #$8000,2(a0)
                move.b  #$80,$21(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4AD36
                rts
; End of function Boss_DestroyerMK2EnableShields
; Checks if boss takes damage
Boss_DestroyerMK2DamageCheck:                           ; DATA XREF: ROM:0004A916   o  ; was: sub_4AD4C
                bsr.w   Boss_DestroyerMK2ShootPattern3
                tst.w   (word_FFC7A4).w
                bne.s   locret_4AD9C
                tst.w   (word_FFC804).w
                bne.s   locret_4AD9C
                tst.w   (word_FFC864).w
                bne.s   locret_4AD9C
                tst.w   (word_FFC8C4).w
                bne.s   locret_4AD9C
                bsr.s   Boss_DestroyerMK2CollisionCheck
                bsr.s   Boss_DestroyerMK2CollisionCheck
                bsr.s   Boss_DestroyerMK2CollisionCheck
                bsr.s   Boss_DestroyerMK2CollisionCheck
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                cmpi.w  #$40,$48(a5)                    ; '@'
                bne.s   loc_4AD8E
                move.b  #$E6,d0
                jsr     (Sound_PlaySFX).l
loc_4AD8E:                                              ; CODE XREF: Boss_DestroyerMK2DamageCheck+36   j
                subq.w  #1,$48(a5)
                bne.s   locret_4AD9C
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
locret_4AD9C:                                           ; CODE XREF: Boss_DestroyerMK2DamageCheck+8   j
                                        ; Boss_DestroyerMK2DamageCheck+E   j
                rts
; End of function Boss_DestroyerMK2DamageCheck
; Collision detection with player
Boss_DestroyerMK2CollisionCheck:                        ; CODE XREF: Boss_DestroyerMK2MoveLeft   p  ; was: sub_4AD9E
                                        ; Boss_DestroyerMK2MoveLeft+4   p
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                move.w  (dword_FFFF08+2).w,d1
                andi.w  #$FF,d1
                add.w   d0,d0
                add.w   d1,d1
                lea     (dword_FF9420).w,a0
                move.w  (a0,d0.w),d2
                move.w  (a0,d1.w),(a0,d0.w)
                move.w  d2,(a0,d1.w)
                rts
; End of function Boss_DestroyerMK2CollisionCheck
; Applies palette fade to DestroyerMK2
Gfx_DestroyerMK2ApplyPaletteFade:                       ; CODE XREF: Boss_DestroyerMK2MoveLeft+18   p  ; was: sub_4ADCC
                                        ; Boss_DestroyerMK2MoveRight+C   p
                move.w  #$7000,d7
loc_4ADD0:                                              ; CODE XREF: Boss_DestroyerMK2Enrage+14   p
                                        ; Boss_DestroyerMK2AnimIdle+14   p
                movea.w #(word_FFE360-M68K_RAM),a0
                move.w  #$F,d5
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Gfx_DestroyerMK2ApplyPaletteFade
; Shooting pattern 1
Boss_DestroyerMK2ShootPattern1:                         ; CODE XREF: Boss_DestroyerMK2MoveRight+14   p  ; was: sub_4ADE0
                                        ; sub_4AEFA   p
                lea     (dword_FF9420).w,a0
                lea     (word_FF9820).w,a1
                lea     (word_FF9620).w,a2
                move.w  $4A(a5),d1
                add.w   d1,d1
                move.w  #3,d7
loc_4ADF6:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern1+26   j
                move.w  (a0,d1.w),d2
                add.w   d2,d2
                move.w  d0,(a1,d2.w)
                clr.w   (a2,d2.w)
                addq.w  #2,d1
                dbf     d7,loc_4ADF6
                rts
; End of function Boss_DestroyerMK2ShootPattern1
; Boss hit reaction animation
Boss_DestroyerMK2HitReaction:                           ; CODE XREF: Boss_DestroyerMK2Enrage+18   p  ; was: sub_4AE0C
                lea     (dword_FF9420).w,a0
                lea     (word_FF9620).w,a1
                move.w  $4A(a5),d1
                add.w   d1,d1
                move.w  #3,d7
loc_4AE1E:                                              ; CODE XREF: Boss_DestroyerMK2HitReaction+30   j
                move.w  (a0,d1.w),d2
                add.w   d2,d2
                move.w  d7,d0
                andi.w  #1,d0
                beq.s   loc_4AE34
                move.w  #$FFFF,(a1,d2.w)
                bra.s   loc_4AE3A
; ---------------------------------------------------------------------------
loc_4AE34:                                              ; CODE XREF: Boss_DestroyerMK2HitReaction+1E   j
                move.w  #1,(a1,d2.w)
loc_4AE3A:                                              ; CODE XREF: Boss_DestroyerMK2HitReaction+26   j
                addq.w  #2,d1
                dbf     d7,loc_4AE1E
                rts
; End of function Boss_DestroyerMK2HitReaction
; Stun state after heavy damage
Boss_DestroyerMK2StunState:                             ; CODE XREF: Boss_DestroyerMK2Enrage+4   p  ; was: sub_4AE42
                                        ; Boss_DestroyerMK2AnimIdle+4   p
                move.w  #$FE,d7
                lea     (word_FF9820).w,a0
                lea     (word_FF9620).w,a1
loc_4AE4E:                                              ; CODE XREF: Boss_DestroyerMK2StunState+20   j
                tst.w   (a1)
                beq.s   loc_4AE5E
                move.w  (a1),d0
                add.w   d0,(a0)
                tst.w   (a1)
                bmi.s   loc_4AE5C
                addq.w  #1,(a1)
loc_4AE5C:                                              ; CODE XREF: Boss_DestroyerMK2StunState+16   j
                subq.w  #1,(a1)
loc_4AE5E:                                              ; CODE XREF: Boss_DestroyerMK2StunState+E   j
                addq.w  #2,a0
                addq.w  #2,a1
                dbf     d7,loc_4AE4E
                rts
; End of function Boss_DestroyerMK2StunState
; Recovery from stun state
Boss_DestroyerMK2RecoverFromStun:                       ; DATA XREF: ROM:0004A918   o  ; was: sub_4AE68
                bsr.w   Boss_DestroyerMK2ShootPattern3
                move.w  $56(a5),d0
                move.w  #$FFE0,(dword_FF9414).w
                move.w  word_4AE9C(pc,d0.w),$48(a5)
                addq.w  #2,$56(a5)
                andi.w  #$E,$56(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2RecoverFromStun
; ---------------------------------------------------------------------------
                dc.w    $130, $FFF0, $130, $FFF0, $90, $FFF0, $130, $90
word_4AE9C:     dc.w    $2000, $8000, $2000, $8000, $4000, $8000, $2000, $4000
                                        ; DATA XREF: Boss_DestroyerMK2RecoverFromStun+E   r

; Enrage mode at low health
Boss_DestroyerMK2Enrage:                                ; DATA XREF: ROM:0004A91A   o  ; was: sub_4AEAC
                bsr.w   Boss_DestroyerMK2ShootPattern3
                bsr.w   Boss_DestroyerMK2StunState
                move.w  (word_FFA000).w,d0
                andi.w  #$E,d0
                move.w  $48(a5),d7
                bsr.w   loc_4ADD0
                bsr.w   Boss_DestroyerMK2HitReaction
                addq.w  #4,$4A(a5)
                cmpi.w  #$100,$4A(a5)
                bne.s   locret_4AEDC
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
locret_4AEDC:                                           ; CODE XREF: Boss_DestroyerMK2Enrage+26   j
                rts
; End of function Boss_DestroyerMK2Enrage
; Idle animation state
Boss_DestroyerMK2AnimIdle:                              ; DATA XREF: ROM:0004A91C   o  ; was: sub_4AEDE
                bsr.w   Boss_DestroyerMK2ShootPattern3
                bsr.w   Boss_DestroyerMK2StunState
                move.w  (word_FFA000).w,d0
                andi.w  #$E,d0
                move.w  $48(a5),d7
                bsr.w   loc_4ADD0
                move.w  (dword_FF9414).w,d0
; End of function Boss_DestroyerMK2AnimIdle
; Walk animation state
Boss_DestroyerMK2AnimWalk:
                bsr.w   Boss_DestroyerMK2ShootPattern1  ; was: sub_4AEFA
                addq.w  #4,$4A(a5)
                cmpi.w  #$100,$4A(a5)
                bne.s   locret_4AF12
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
locret_4AF12:                                           ; CODE XREF: Boss_DestroyerMK2AnimWalk+E   j
                rts
; End of function Boss_DestroyerMK2AnimWalk
; Attack animation state
Boss_DestroyerMK2AnimAttack:                            ; DATA XREF: ROM:0004A91E   o  ; was: sub_4AF14
                bsr.w   Boss_DestroyerMK2ShootPattern3
                move.w  (word_FFA000).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                bsr.w   Boss_DestroyerMK2ToggleShields
                addq.w  #4,(dword_FF9404).w
                cmpi.w  #$D0,(dword_FF9404).w
                bne.s   locret_4AF48
                bsr.w   Boss_DestroyerMK2EnableShields
                moveq   #0,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                bsr.w   Projectile_DestroyerMK2Missile
                move.w  #$12,4(a5)
locret_4AF48:                                           ; CODE XREF: Boss_DestroyerMK2AnimAttack+1E   j
                rts
; End of function Boss_DestroyerMK2AnimAttack
; Jump animation state
Boss_DestroyerMK2AnimJump:                              ; DATA XREF: ROM:0004A920   o  ; was: sub_4AF4A
                clr.w   $1C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2AnimJump
; Landing animation state
Boss_DestroyerMK2AnimLand:                              ; DATA XREF: ROM:0004A922   o  ; was: sub_4AF5A
                bsr.w   Boss_DestroyerMK2ShootPattern3
                addi.w  #-$10,$1C(a5)
                move.w  $1C(a5),d1
                andi.w  #$1FE,d1
                beq.s   loc_4AF9E
                move.w  (dword_FF9410).w,d6
                add.w   d6,d6
                move.w  word_4AFBE(pc,d6.w),d0
                lea     (Math_SineTable).l,a3
                move.w  Math_QuarterSineTable-Math_SineTable(a3,d1.w),d1
                bpl.s   loc_4AF90
                ext.l   d1
                move.w  word_4AFD0(pc,d6.w),d2
                asl.l   d2,d1
                swap    d1
                add.w   d1,d0
loc_4AF90:                                              ; CODE XREF: Boss_DestroyerMK2AnimLand+28   j
                bsr.w   Boss_DestroyerMK2PlayFootstep
                beq.s   locret_4AFBC
                move.w  #$12,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4AF9E:                                              ; CODE XREF: Boss_DestroyerMK2AnimLand+12   j
                addq.w  #2,4(a5)
                clr.w   (dword_FF941C).w
                addq.w  #2,(dword_FF9418+2).w
                andi.w  #$1E,(dword_FF9418+2).w
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                move.w  d0,$48(a5)
locret_4AFBC:                                           ; CODE XREF: Boss_DestroyerMK2AnimLand+3A   j
                rts
; End of function Boss_DestroyerMK2AnimLand
; ---------------------------------------------------------------------------
word_4AFBE:     dc.w    5, 5, 5, 4, 4, 4, 3, 3, 2
                                        ; DATA XREF: Boss_DestroyerMK2AnimLand+1A   r
word_4AFD0:     dc.w    5, 5, 5, 5, 4, 4, 4, 3, 3
                                        ; DATA XREF: Boss_DestroyerMK2AnimLand+2C   r

; Damage animation state
Boss_DestroyerMK2AnimDamage:                            ; DATA XREF: ROM:0004A924   o  ; was: sub_4AFE2
                bsr.w   Boss_DestroyerMK2ShootPattern3
                move.w  (dword_FF9418+2).w,d0
                tst.w   $48(a5)
                bmi.w   loc_4B01C
                move.w  d0,d0
                lea     off_4AFFC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; ---------------------------------------------------------------------------
off_4AFFC:      dc.w    Boss_DestroyerMK2DefeatStateMachine-*  ; DATA XREF: Boss_DestroyerMK2AnimDamage+12   o
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2StateDispatcher1-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2DefeatStateMachine-*
                dc.w    Boss_DestroyerMK2StateDispatcher2-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2StateDispatcher1-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2StateDispatcher2-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2StateDispatcher2-*
                dc.w    Boss_DestroyerMK2StateDispatcher1-*
; ---------------------------------------------------------------------------
loc_4B01C:                                              ; CODE XREF: Boss_DestroyerMK2AnimDamage+C   j
                move.w  d0,d0
                lea     off_4B026(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2AnimDamage
; ---------------------------------------------------------------------------
off_4B026:      dc.w    Boss_DestroyerMK2DefeatStateMachine-*  ; DATA XREF: Boss_DestroyerMK2AnimDamage+3C   o
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2DefeatInit-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2DefeatStateMachine-*
                dc.w    Boss_DestroyerMK2DefeatInit-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2DefeatInit-*
                dc.w    Boss_DestroyerMK2DefeatInit-*
                dc.w    Boss_DestroyerMK2StateDispatcher2-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2FlashDamage-*
                dc.w    Boss_DestroyerMK2StateDispatcher2-*
                dc.w    Boss_DestroyerMK2DefeatInit-*

; Updates boss palette
Boss_DestroyerMK2UpdatePalette:                         ; CODE XREF: Boss_DestroyerMK2PlaySFX+44   j  ; was: sub_4B046
                                        ; Boss_DestroyerMK2ProjectileDelayLoop+A   j
                                        ; DATA XREF:
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2UpdatePalette
; State machine for defeat sequence
