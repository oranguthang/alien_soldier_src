Boss_DestroyerMK2DefeatStateMachine:                    ; DATA XREF: Boss_DestroyerMK2AnimDamage:off_4AFFC   o  ; was: sub_4B04C
                                        ; Boss_DestroyerMK2AnimDamage+24   o
                move.w  (dword_FF941C).w,d0
                lea     off_4B058(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2DefeatStateMachine
; ---------------------------------------------------------------------------
off_4B058:      dc.w    Boss_DestroyerMK2DefeatExplosion1Alt-*  ; DATA XREF: Boss_DestroyerMK2DefeatStateMachine+4   o
                dc.w    Boss_DestroyerMK2DefeatExplosion2Alt-*
                dc.w    Boss_DestroyerMK2DefeatSpawnExplosions-*
                dc.w    Boss_DestroyerMK2UpdatePalette-*

; First defeat explosion phase
Boss_DestroyerMK2DefeatExplosion1Alt:                   ; DATA XREF: ROM:off_4B058   o  ; was: sub_4B060
                addq.w  #2,(dword_FF941C).w
                move.w  (word_FF8248).w,d0
                cmp.w   $10(a5),d0
                bgt.s   loc_4B074
                movea.w #(word_FFC7A0-M68K_RAM),a0
                bra.s   loc_4B078
; ---------------------------------------------------------------------------
loc_4B074:                                              ; CODE XREF: Boss_DestroyerMK2DefeatExplosion1Alt+C   j
                movea.w #(word_FFC800-M68K_RAM),a0
loc_4B078:                                              ; CODE XREF: Boss_DestroyerMK2DefeatExplosion1Alt+12   j
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
                move.w  #$20,$48(a5)                    ; ' '
                rts
; End of function Boss_DestroyerMK2DefeatExplosion1Alt
; Second defeat explosion phase
Boss_DestroyerMK2DefeatExplosion2Alt:                   ; DATA XREF: ROM:0004B05A   o  ; was: sub_4B084
                subq.w  #1,$48(a5)
                bne.s   locret_4B0AC
                addq.w  #2,(dword_FF941C).w
                move.w  (word_FF8248).w,d0
                cmp.w   $10(a5),d0
                bgt.s   loc_4B09E
                movea.w #(word_FFC860-M68K_RAM),a0
                bra.s   loc_4B0A2
; ---------------------------------------------------------------------------
loc_4B09E:                                              ; CODE XREF: Boss_DestroyerMK2DefeatExplosion2Alt+12   j
                movea.w #(word_FFC8C0-M68K_RAM),a0
loc_4B0A2:                                              ; CODE XREF: Boss_DestroyerMK2DefeatExplosion2Alt+18   j
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
                move.w  #$40,$48(a5)                    ; '@'
locret_4B0AC:                                           ; CODE XREF: Boss_DestroyerMK2DefeatExplosion2Alt+4   j
                rts
; End of function Boss_DestroyerMK2DefeatExplosion2Alt
; Spawns multiple defeat explosions at different positions
Boss_DestroyerMK2DefeatSpawnExplosions:                 ; DATA XREF: ROM:0004B05C   o  ; was: sub_4B0AE
                subq.w  #1,$48(a5)
                bne.s   locret_4B0E4
                addq.w  #2,(dword_FF941C).w
                move.w  (word_FF8248).w,d0
                cmp.w   $10(a5),d0
                bgt.s   loc_4B0D4
                movea.w #(word_FFC7A0-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
                movea.w #(word_FFC860-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
                rts
; ---------------------------------------------------------------------------
loc_4B0D4:                                              ; CODE XREF: Boss_DestroyerMK2DefeatSpawnExplosions+12   j
                movea.w #(word_FFC800-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
                movea.w #(word_FFC8C0-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2DefeatExplosion3
locret_4B0E4:                                           ; CODE XREF: Boss_DestroyerMK2DefeatSpawnExplosions+4   j
                rts
; End of function Boss_DestroyerMK2DefeatSpawnExplosions
; Defeat sequence initialization
Boss_DestroyerMK2DefeatInit:                            ; DATA XREF: ROM:0004B02A   o  ; was: sub_4B0E6
                                        ; ROM:0004B032   o
                move.w  (dword_FF941C).w,d0
                lea     off_4B0F2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2DefeatInit
; ---------------------------------------------------------------------------
off_4B0F2:      dc.w    Boss_DestroyerMK2DefeatStagger-*  ; DATA XREF: Boss_DestroyerMK2DefeatInit+4   o
                dc.w    Boss_DestroyerMK2AdvanceDefeatState-*
                dc.w    Boss_DestroyerMK2UpdatePalette-*

; Staggering during defeat
Boss_DestroyerMK2DefeatStagger:                         ; DATA XREF: ROM:off_4B0F2   o  ; was: sub_4B0F8
                bsr.w   Boss_DestroyerMK2DefeatExplosion2
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2DefeatStagger
; Advances the boss defeat state machine
Boss_DestroyerMK2AdvanceDefeatState:                    ; DATA XREF: ROM:0004B0F4   o  ; was: sub_4B102
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2AdvanceDefeatState
; Flash effect on damage
Boss_DestroyerMK2FlashDamage:                           ; DATA XREF: Boss_DestroyerMK2AnimDamage+1C   o  ; was: sub_4B108
                                        ; Boss_DestroyerMK2AnimDamage+1E   o
                move.w  (dword_FF941C).w,d0
                lea     off_4B114(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2FlashDamage
; ---------------------------------------------------------------------------
off_4B114:      dc.w    Boss_DestroyerMK2ShakeOnLand-*  ; DATA XREF: Boss_DestroyerMK2FlashDamage+4   o
                dc.w    Boss_DestroyerMK2PlaySFX-*

; Screen shake on landing
Boss_DestroyerMK2ShakeOnLand:                           ; DATA XREF: ROM:off_4B114   o  ; was: sub_4B118
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                bmi.s   loc_4B130
                move.w  #$30,$58(a5)                    ; '0'
                move.w  #$1E0,$5A(a5)
                bra.s   loc_4B13C
; ---------------------------------------------------------------------------
loc_4B130:                                              ; CODE XREF: Boss_DestroyerMK2ShakeOnLand+8   j
                move.w  #$FFD0,$58(a5)
                move.w  #$120,$5A(a5)
loc_4B13C:                                              ; CODE XREF: Boss_DestroyerMK2ShakeOnLand+16   j
                move.w  $10(a5),d0
                add.w   d0,$58(a5)
                move.w  #5,$5C(a5)
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2ShakeOnLand
; Plays boss sound effects
Boss_DestroyerMK2PlaySFX:                               ; DATA XREF: ROM:0004B116   o  ; was: sub_4B150
                move.w  #4,d1
                move.w  #$8004,d2
                move.w  $58(a5),d3
                move.w  $14(a5),d4
                move.w  $5A(a5),d6
                andi.w  #$1FE,d6
                jsr     (Boss_DestroyerMK2UpdateSprite).l
                btst    #7,$58(a5)
                bmi.s   loc_4B17E
                addi.w  #$10,$5A(a5)
                bra.s   loc_4B184
; ---------------------------------------------------------------------------
loc_4B17E:                                              ; CODE XREF: Boss_DestroyerMK2PlaySFX+24   j
                addi.w  #-$10,$5A(a5)
loc_4B184:                                              ; CODE XREF: Boss_DestroyerMK2PlaySFX+2C   j
                subq.w  #1,$5C(a5)
                bne.s   locret_4B198
                move.b  #$E9,d0
                jsr     (Sound_PlaySFX).l
                bra.w   Boss_DestroyerMK2UpdatePalette
; ---------------------------------------------------------------------------
locret_4B198:                                           ; CODE XREF: Boss_DestroyerMK2PlaySFX+38   j
                rts
; End of function Boss_DestroyerMK2PlaySFX
; Dispatches to boss state handlers using jump table
Boss_DestroyerMK2StateDispatcher1:                      ; DATA XREF: Boss_DestroyerMK2AnimDamage+20   o  ; was: sub_4B19A
                                        ; Boss_DestroyerMK2AnimDamage+2C   o
                move.w  (dword_FF941C).w,d0
                lea     off_4B1A6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2StateDispatcher1
; ---------------------------------------------------------------------------
off_4B1A6:      dc.w    Boss_DestroyerMK2SpawnThreeProjectiles-*  ; DATA XREF: Boss_DestroyerMK2StateDispatcher1+4   o
                dc.w    Boss_DestroyerMK2SpawnThreeProjectiles_Loop-*
                dc.w    Boss_DestroyerMK2ProjectileDelayLoop-*

; Spawns three projectiles with sequential delay
Boss_DestroyerMK2SpawnThreeProjectiles:                 ; DATA XREF: ROM:off_4B1A6   o  ; was: sub_4B1AC
                move.w  #3,$4A(a5)
                addq.w  #2,(dword_FF941C).w
; Spawn projectile slot and initialize parameters
Boss_DestroyerMK2SpawnThreeProjectiles_Loop:            ; DATA XREF: ROM:0004B1A8   o  ; was: loc_4B1B6
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_4B21E
                move.w  #$258,(a0)
                move.w  #$CD00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.b  #$C0,$21(a0)
                move.l  #$F808FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$30,$24(a0)                    ; '0'
                move.b  d1,$20(a0)
                move.l  #word_EC2D4,8(a0)
                move.w  #$EB00,$E(a0)
                clr.w   $4C(a0)
                move.w  #2,$46(a0)
                move.w  $4A(a5),$44(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
loc_4B21E:                                              ; CODE XREF: Boss_DestroyerMK2SpawnThreeProjectiles+10   j
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2SpawnThreeProjectiles
; Waits for projectile spawn delay and loops
Boss_DestroyerMK2ProjectileDelayLoop:                   ; DATA XREF: ROM:0004B1AA   o  ; was: sub_4B22A
                subq.w  #1,$48(a5)
                bne.s   locret_4B23C
                subq.w  #1,$4A(a5)
                beq.w   Boss_DestroyerMK2UpdatePalette
                subq.w  #2,(dword_FF941C).w
locret_4B23C:                                           ; CODE XREF: Boss_DestroyerMK2ProjectileDelayLoop+4   j
                rts
; End of function Boss_DestroyerMK2ProjectileDelayLoop
; Dispatches to alternate state machine
Boss_DestroyerMK2StateDispatcher2:                      ; DATA XREF: Boss_DestroyerMK2AnimDamage+26   o  ; was: sub_4B23E
                                        ; Boss_DestroyerMK2AnimDamage+30   o
                move.w  (dword_FF941C).w,d0
                lea     off_4B24A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2StateDispatcher2
; ---------------------------------------------------------------------------
off_4B24A:      dc.w    Boss_DestroyerMK2SpawnProjectileSpread-*  ; DATA XREF: Boss_DestroyerMK2StateDispatcher2+4   o
                dc.w    Boss_DestroyerMK2UpdatePalette-*

; Spawns spread pattern of 10 projectiles
Boss_DestroyerMK2SpawnProjectileSpread:                 ; DATA XREF: ROM:off_4B24A   o  ; was: sub_4B24E
                move.w  #(loc_4B252-*),d7
loc_4B252:                                              ; DATA XREF: Boss_DestroyerMK2SpawnProjectileSpread   o
                moveq   #0,d6
loc_4B254:                                              ; CODE XREF: Boss_DestroyerMK2SpawnProjectileSpread:loc_4B2C0   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_4B2C0
                move.w  #$258,(a0)
                move.w  #$CD00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.b  #$C0,$21(a0)
                move.l  #$F808FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$30,$24(a0)                    ; '0'
                move.b  d1,$20(a0)
                move.l  #word_EC2D4,8(a0)
                move.w  #$EB00,$E(a0)
                clr.w   $4C(a0)
                move.w  #4,$46(a0)
                move.w  word_4B2CE(pc,d6.w),$44(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),d0
                move.w  d0,$14(a0)
                addq.w  #2,d6
loc_4B2C0:                                              ; CODE XREF: Boss_DestroyerMK2SpawnProjectileSpread+C   j
                dbf     d7,loc_4B254
                clr.w   (dword_FF941C+2).w
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2SpawnProjectileSpread
; ---------------------------------------------------------------------------
word_4B2CE:     dc.w    0, $FFFE, 2, $FFFC, 4, 0, $FFE0, $20, $FFC0, $40
                                        ; DATA XREF: Boss_DestroyerMK2SpawnProjectileSpread+5C   r

; Falling during defeat
Boss_DestroyerMK2DefeatFall:                            ; DATA XREF: ROM:0004A926   o  ; was: sub_4B2E2
                bsr.w   Boss_DestroyerMK2ShootPattern3
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2DefeatFall
; First explosion in defeat
Boss_DestroyerMK2DefeatExplosion1:                      ; DATA XREF: ROM:0004A928   o  ; was: sub_4B2F2
                bsr.w   Boss_DestroyerMK2ShootPattern3
                subq.w  #1,$48(a5)
                bne.s   locret_4B302
                move.w  #$22,4(a5)                      ; '"'
locret_4B302:                                           ; CODE XREF: Boss_DestroyerMK2DefeatExplosion1+8   j
                rts
; End of function Boss_DestroyerMK2DefeatExplosion1
; Explosion effect 1
Effect_DestroyerMK2Explosion1:                          ; DATA XREF: ROM:0004A92A   o  ; was: sub_4B304
                bsr.w   Boss_DestroyerMK2ShootPattern3
                tst.w   (word_FFC7A4).w
                bne.s   locret_4B334
                tst.w   (word_FFC804).w
                bne.s   locret_4B334
                tst.w   (word_FFC864).w
                bne.s   locret_4B334
                tst.w   (word_FFC8C4).w
                bne.s   locret_4B334
                tst.w   (word_FFC744).w
                bne.s   locret_4B334
                bsr.w   Projectile_DestroyerMK2Laser
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
locret_4B334:                                           ; CODE XREF: Effect_DestroyerMK2Explosion1+8   j
                                        ; Effect_DestroyerMK2Explosion1+E   j
                rts
; End of function Effect_DestroyerMK2Explosion1
; Explosion effect 2
Effect_DestroyerMK2Explosion2:                          ; DATA XREF: ROM:0004A92C   o  ; was: sub_4B336
                jsr     Projectile_DestroyerMK2DebrisMain(pc)  ; (pc)
                nop
                subq.w  #1,$48(a5)
                bne.s   locret_4B346
                addq.w  #2,4(a5)
locret_4B346:                                           ; CODE XREF: Effect_DestroyerMK2Explosion2+A   j
                rts
; End of function Effect_DestroyerMK2Explosion2
; Berserk attack pattern 1
Boss_DestroyerMK2BerserkAttack1:                        ; DATA XREF: ROM:0004A92E   o  ; was: sub_4B348
                bsr.s   Boss_DestroyerMK2BerserkAttack2
                addq.w  #1,$48(a5)
                cmpi.w  #$F,$48(a5)
                bne.s   locret_4B376
                addq.w  #2,4(a5)
                lea     word_4B366(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; ---------------------------------------------------------------------------
word_4B366:     dc.w    $4480, $4000, $104, 0, 0, 0, 0, 0
                                        ; DATA XREF: Boss_DestroyerMK2BerserkAttack1+12   o
; ---------------------------------------------------------------------------
locret_4B376:                                           ; CODE XREF: Boss_DestroyerMK2BerserkAttack1+C   j
                rts
; End of function Boss_DestroyerMK2BerserkAttack1
; Berserk attack pattern 2
Boss_DestroyerMK2BerserkAttack2:                        ; CODE XREF: Boss_DestroyerMK2BerserkAttack1   p  ; was: sub_4B378
                                        ; sub_4B394   p
                move.w  $48(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Boss_DestroyerMK2BerserkAttack2
; Berserk rush attack
Boss_DestroyerMK2BerserkRush:                           ; DATA XREF: ROM:0004A930   o  ; was: sub_4B394
                bsr.s   Boss_DestroyerMK2BerserkAttack2
                addq.w  #2,4(a5)
                lea     word_4B3A6(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_DestroyerMK2BerserkRush
; ---------------------------------------------------------------------------
word_4B3A6:     dc.w    $4490, $4000, $104, 0, 0, 0, 0, 0
                                        ; DATA XREF: Boss_DestroyerMK2BerserkRush+6   o

; Berserk spin attack
Boss_DestroyerMK2BerserkSpin:                           ; DATA XREF: ROM:0004A932   o  ; was: sub_4B3B6
                bsr.s   Boss_DestroyerMK2BerserkAttack2
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                bclr    #3,$4C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2BerserkSpin
; Berserk jump attack
Boss_DestroyerMK2BerserkJump:                           ; DATA XREF: ROM:0004A934   o  ; was: sub_4B3D0
                bsr.s   Boss_DestroyerMK2BerserkAttack2
                move.w  #$240,d0
                move.w  #$3DC,d1
                jsr     (Sprite_ClearAllExcept).l
                move.b  #4,(byte_FFA95A).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2BerserkJump
; Berserk roar attack
Boss_DestroyerMK2BerserkRoar:                           ; DATA XREF: ROM:0004A936   o  ; was: sub_4B3EC
                bsr.s   Boss_DestroyerMK2BerserkAttack2
                subq.w  #1,$48(a5)
                bne.s   locret_4B3FA
                clr.w   (a5)
                addq.w  #2,4(a5)
locret_4B3FA:                                           ; CODE XREF: Boss_DestroyerMK2BerserkRoar+6   j
                rts
; End of function Boss_DestroyerMK2BerserkRoar
; Second explosion in defeat
Boss_DestroyerMK2DefeatExplosion2:                      ; CODE XREF: Boss_DestroyerMK2DefeatStagger   p  ; was: sub_4B3FC
                movea.w #(word_FFC740-M68K_RAM),a0
; End of function Boss_DestroyerMK2DefeatExplosion2
; Third explosion in defeat
Boss_DestroyerMK2DefeatExplosion3:                      ; CODE XREF: Boss_DestroyerMK2DefeatExplosion1Alt:loc_4B078   p  ; was: sub_4B400
                                        ; sub_4B084:loc_4B0A2   p
                tst.w   4(a0)
                bne.s   locret_4B40A
                addq.w  #2,4(a0)
locret_4B40A:                                           ; CODE XREF: Boss_DestroyerMK2DefeatExplosion3+4   j
                rts
; End of function Boss_DestroyerMK2DefeatExplosion3
; Creates horizontal laser beam during defeat
Boss_DestroyerMK2DefeatLaserEffect:
                move.w  (word_FF8248).w,d0              ; was: sub_4B40C
                sub.w   $10(a5),d0
                bmi.s   loc_4B424
                move.w  #$30,$58(a5)                    ; '0'
                move.w  #$1D0,$5A(a5)
                bra.s   loc_4B430
; ---------------------------------------------------------------------------
loc_4B424:                                              ; CODE XREF: Boss_DestroyerMK2DefeatLaserEffect+8   j
                move.w  #$FFD0,$58(a5)
                move.w  #$D0,$5A(a5)
loc_4B430:                                              ; CODE XREF: Boss_DestroyerMK2DefeatLaserEffect+16   j
                move.w  $10(a5),d0
                add.w   d0,$58(a5)
                move.w  #4,$5C(a5)
loc_4B43E:                                              ; CODE XREF: Boss_DestroyerMK2DefeatLaserEffect+56   j
                move.w  #4,d1
                move.w  #$8004,d2
                move.w  $58(a5),d3
                move.w  $14(a5),d4
                move.w  $5A(a5),d6
                jsr     (Boss_DestroyerMK2UpdateSprite).l
                addi.w  #$20,$5A(a5)                    ; ' '
                subq.w  #1,$5C(a5)
                bne.s   loc_4B43E
                move.b  #$E9,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Boss_DestroyerMK2DefeatLaserEffect
; Plays footstep sound
Boss_DestroyerMK2PlayFootstep:                          ; CODE XREF: Boss_DestroyerMK2AnimLand:loc_4AF90   p  ; was: sub_4B470
                cmpi.w  #$110,(word_FF9820).w
                bge.s   loc_4B48A
                move.w  #$FE,d7
                lea     (word_FF9820).w,a0
loc_4B480:                                              ; CODE XREF: Boss_DestroyerMK2PlayFootstep+12   j
                add.w   d0,(a0)+
                dbf     d7,loc_4B480
                clr.w   d0
                rts
; ---------------------------------------------------------------------------
loc_4B48A:                                              ; CODE XREF: Boss_DestroyerMK2PlayFootstep+6   j
                move.w  #1,d0
                rts
; End of function Boss_DestroyerMK2PlayFootstep
; Main state dispatcher for boss component
Boss_DestroyerMK2ComponentStateDispatch:                ; DATA XREF: ROM:off_5DC   o  ; was: sub_4B490
                move.w  4(a5),d0
                lea     off_4B49C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2ComponentStateDispatch
; ---------------------------------------------------------------------------
off_4B49C:      dc.w    nullsub_105-*                   ; DATA XREF: Boss_DestroyerMK2ComponentStateDispatch+4   o
                dc.w    Boss_DestroyerMK2ComponentCheckDefeat-*
                dc.w    Boss_DestroyerMK2ComponentInitProjectile-*
                dc.w    Boss_DestroyerMK2ComponentSpawnProjectile-*
                dc.w    Boss_DestroyerMK2ComponentInitMovement-*
                dc.w    Boss_DestroyerMK2ComponentUpdateMovement-*
                dc.w    Boss_DestroyerMK2ComponentSwitchAnimation-*
                dc.w    Enemy_DecrementTimerAndAdvanceState-*
                dc.w    Enemy_CheckScrollFlagAndDispatch-*
                dc.w    Enemy_ResetStateOnScrollCheck-*

nullsub_105:                                            ; DATA XREF: ROM:off_4B49C   o
                rts
; End of function nullsub_105

; Checks if component is defeated
Boss_DestroyerMK2ComponentCheckDefeat:                  ; DATA XREF: ROM:0004B49E   o  ; was: sub_4B4B2
                tst.w   (word_FFF720).w
                bmi.w   nullsub_108
                move.w  $4E(a5),d0
                movea.w word_4B51C(pc,d0.w),a0
                tst.w   4(a0)
                bne.w   nullsub_108
                addq.w  #2,4(a5)
                ori.w   #$8000,2(a5)
                lea     off_4B4DC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2ComponentCheckDefeat
; ---------------------------------------------------------------------------
off_4B4DC:      dc.w    Boss_DestroyerMK2ScrollUpdate1-*  ; DATA XREF: Boss_DestroyerMK2ComponentCheckDefeat+22   o
                dc.w    Boss_DestroyerMK2ScrollUpdate2-*
                dc.w    Boss_DestroyerMK2ScrollUpdate3-*
                dc.w    Boss_DestroyerMK2ScrollUpdate4-*

; Updates stage 14 scroll position set 1
Boss_DestroyerMK2ScrollUpdate1:                         ; DATA XREF: ROM:off_4B4DC   o  ; was: sub_4B4E4
                move.l  #$44804001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Boss_DestroyerMK2ScrollUpdate1
; Updates stage 14 scroll position set 2
Boss_DestroyerMK2ScrollUpdate2:                         ; DATA XREF: ROM:0004B4DE   o  ; was: sub_4B4F2
                move.l  #$44984001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Boss_DestroyerMK2ScrollUpdate2
; Updates stage 14 scroll position set 3
Boss_DestroyerMK2ScrollUpdate3:                         ; DATA XREF: ROM:0004B4E0   o  ; was: sub_4B500
                move.l  #$4C804001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Boss_DestroyerMK2ScrollUpdate3
; Updates stage 14 scroll position set 4
Boss_DestroyerMK2ScrollUpdate4:                         ; DATA XREF: ROM:0004B4E2   o  ; was: sub_4B50E
                move.l  #$4C984001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Boss_DestroyerMK2ScrollUpdate4
; ---------------------------------------------------------------------------
word_4B51C:     dc.w    $C800, $C7A0, $C8C0, $C860
                                        ; DATA XREF: Boss_DestroyerMK2ComponentCheckDefeat+C   r

; Initializes component for projectile spawning
Boss_DestroyerMK2ComponentInitProjectile:               ; DATA XREF: ROM:0004B4A0   o  ; was: sub_4B524
                tst.w   (word_FFF720).w
                bmi.w   nullsub_108
                move.l  #word_EC2B6,8(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2ComponentInitProjectile
; Spawns projectile from component with offset
Boss_DestroyerMK2ComponentSpawnProjectile:              ; DATA XREF: ROM:0004B4A2   o  ; was: sub_4B540
                subq.w  #1,$48(a5)
                bpl.w   locret_4B5DC
                addq.w  #2,4(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   locret_4B5DC
                move.w  #$248,(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.b  #$10,$23(a0)
                move.l  #$FC04D42C,$2C(a0)
                move.w  #$100,$26(a0)
                move.w  #$CD00,2(a0)
                move.l  #word_EC292,8(a0)
                move.w  #$4300,$E(a0)
                move.b  $20(a5),$20(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  $4E(a5),d0
                move.w  word_4B5DE(pc,d0.w),d1
                add.w   d1,$10(a0)
                move.w  word_4B5E6(pc,d0.w),d1
                add.w   d1,$14(a0)
                move.w  word_4B5EE(pc,d0.w),$4C(a0)
                add.w   d0,d0
                move.l  dword_4B5F6(pc,d0.w),$50(a0)
                tst.w   (word_FFFF0E).w
                beq.s   loc_4B5D0
                move.w  #$C,$48(a5)
                move.w  #$C,$48(a0)
                rts
; ---------------------------------------------------------------------------
loc_4B5D0:                                              ; CODE XREF: Boss_DestroyerMK2ComponentSpawnProjectile+80   j
                move.w  #$18,$48(a5)
                move.w  #$18,$48(a0)
locret_4B5DC:                                           ; CODE XREF: Boss_DestroyerMK2ComponentSpawnProjectile+4   j
                                        ; Boss_DestroyerMK2ComponentSpawnProjectile+12   j
                rts
; End of function Boss_DestroyerMK2ComponentSpawnProjectile
; ---------------------------------------------------------------------------
word_4B5DE:     dc.w    $18, $FFE8                      ; DATA XREF: Boss_DestroyerMK2ComponentSpawnProjectile+5E   r
                dc.w    $18, $FFE8
word_4B5E6:     dc.w    1, 1                            ; DATA XREF: Boss_DestroyerMK2ComponentSpawnProjectile+66   r
                dc.w    $FFFF, $FFFF
word_4B5EE:     dc.w    $FFFF, 1                        ; DATA XREF: Boss_DestroyerMK2ComponentSpawnProjectile+6E   r
                dc.w    $FFFF, 1
dword_4B5F6:    dc.l    $FFFFE000, $2000                ; DATA XREF: Boss_DestroyerMK2ComponentSpawnProjectile+76   r
                dc.l    $FFFFE000, $2000

; Initializes component movement vectors
Boss_DestroyerMK2ComponentInitMovement:                 ; DATA XREF: ROM:0004B4A4   o  ; was: sub_4B606
                subq.w  #1,$48(a5)
                bne.s   locret_4B630
                move.w  $4E(a5),d0
                clr.l   $58(a5)
                add.w   d0,d0
                move.l  dword_4B632(pc,d0.w),$50(a5)
                move.l  dword_4B642(pc,d0.w),$54(a5)
                addq.w  #2,4(a5)
                move.b  #$E7,d0
                jsr     (Sound_PlaySFX).l
locret_4B630:                                           ; CODE XREF: Boss_DestroyerMK2ComponentInitMovement+4   j
                rts
; End of function Boss_DestroyerMK2ComponentInitMovement
; ---------------------------------------------------------------------------
dword_4B632:    dc.l    $20000, $FFFE0000               ; DATA XREF: Boss_DestroyerMK2ComponentInitMovement+10   r
                dc.l    $20000, $FFFE0000
dword_4B642:    dc.l    $FFFFE000, $2000                ; DATA XREF: Boss_DestroyerMK2ComponentInitMovement+16   r
                dc.l    $FFFFE000, $2000

; Updates component physics and scroll layers
Boss_DestroyerMK2ComponentUpdateMovement:               ; DATA XREF: ROM:0004B4A6   o  ; was: sub_4B652
                move.l  $54(a5),d0
                add.l   d0,$50(a5)
                move.l  $50(a5),d0
                add.l   d0,$58(a5)
                move.w  $58(a5),d0
                cmpi.w  #4,$4E(a5)
                bcc.s   loc_4B674
                lea     (word_FFE52C).w,a0
                bra.s   loc_4B678
; ---------------------------------------------------------------------------
loc_4B674:                                              ; CODE XREF: Boss_DestroyerMK2ComponentUpdateMovement+1A   j
                lea     (word_FFE720).w,a0
loc_4B678:                                              ; CODE XREF: Boss_DestroyerMK2ComponentUpdateMovement+20   j
                bsr.s   Gfx_UpdateMultipleScrollLayers
                tst.l   $58(a5)
                bne.s   locret_4B68A
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
locret_4B68A:                                           ; CODE XREF: Boss_DestroyerMK2ComponentUpdateMovement+2C   j
                rts
; End of function Boss_DestroyerMK2ComponentUpdateMovement
; Updates 7 consecutive scroll layer values
