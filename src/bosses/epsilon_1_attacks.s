Boss_Epsilon1AttackPhase1Init:                          ; DATA XREF: ROM:00045CF8   o  ; was: sub_461A6
                bsr.w   Boss_Epsilon1ApplyPaletteFade
                move.w  #$20,$48(a5)                    ; ' '
                move.b  #$21,(byte_FFA95A).w            ; '!'
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1AttackPhase1Init
; Sets up rotation parameters
Boss_Epsilon1RotationSetup:                             ; DATA XREF: ROM:00045CFA   o  ; was: sub_461BC
                bsr.w   Boss_Epsilon1ApplyPaletteFade
                subq.w  #1,$48(a5)
                bne.s   locret_461DC
                move.w  #4,(dword_FF9410).w
                move.w  #4,(dword_FF9414+2).w
                move.w  #$E,$48(a5)
                addq.w  #2,4(a5)
locret_461DC:                                           ; CODE XREF: Boss_Epsilon1RotationSetup+8   j
                rts
; End of function Boss_Epsilon1RotationSetup
; Debug mode directional control for positioning
Boss_Epsilon1DebugControl:
                btst    #5,(word_FFF706).w              ; was: sub_461DE
                beq.s   locret_46216
                btst    #2,(word_FFF706).w
                beq.s   loc_461F2
                subq.w  #2,(dword_FFC690).w
loc_461F2:                                              ; CODE XREF: Boss_Epsilon1DebugControl+E   j
                btst    #3,(word_FFF706).w
                beq.s   loc_461FE
                addq.w  #2,(dword_FFC690).w
loc_461FE:                                              ; CODE XREF: Boss_Epsilon1DebugControl+1A   j
                btst    #0,(word_FFF706).w
                beq.s   loc_4620A
                subq.w  #2,(dword_FFC694).w
loc_4620A:                                              ; CODE XREF: Boss_Epsilon1DebugControl+26   j
                btst    #1,(word_FFF706).w
                beq.s   locret_46216
                addq.w  #2,(dword_FFC694).w
locret_46216:                                           ; CODE XREF: Boss_Epsilon1DebugControl+6   j
                                        ; Boss_Epsilon1DebugControl+32   j
                rts
; End of function Boss_Epsilon1DebugControl
; Palette fade with button check
Boss_Epsilon1FadeWithButtonCheck:                       ; DATA XREF: ROM:00045CFC   o  ; was: sub_46218
                move.w  $48(a5),d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                movea.w #(word_FFE300-M68K_RAM),a0
                jsr     (Gfx_ApplyPaletteFade).l
                btst    #0,(word_FFA000+1).w
                bne.s   locret_46248
                btst    #1,(word_FFA000+1).w
                bne.s   locret_46248
                subq.w  #1,$48(a5)
                bge.s   locret_46248
                addq.w  #2,4(a5)
locret_46248:                                           ; CODE XREF: Boss_Epsilon1FadeWithButtonCheck+1C   j
                                        ; Boss_Epsilon1FadeWithButtonCheck+24   j
                rts
; End of function Boss_Epsilon1FadeWithButtonCheck
; Checks victory condition
Boss_Epsilon1VictoryCheck:                              ; DATA XREF: ROM:00045CFE   o  ; was: sub_4624A
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                move.b  #$8D,d0
                jsr     (Sys_WaitVBlank).l
                rts
; End of function Boss_Epsilon1VictoryCheck
; Attack state 1 handler
Boss_Epsilon1AttackState1:                              ; DATA XREF: ROM:00045D00   o  ; was: sub_46264
                tst.w   (word_FF80C2).w
                bne.s   locret_46278
                addq.w  #2,4(a5)
                clr.b   (byte_FF80EC).w
                move.w  #$40,$48(a5)                    ; '@'
locret_46278:                                           ; CODE XREF: Boss_Epsilon1AttackState1+4   j
                rts
; End of function Boss_Epsilon1AttackState1
; Attack state 2 handler
Boss_Epsilon1AttackState2:                              ; DATA XREF: ROM:00045D02   o  ; was: sub_4627A
                clr.l   (dword_FFC698).w
                tst.w   (word_FFC7A4).w
                bne.s   locret_462AA
                tst.w   (word_FF9474).w
                bne.s   loc_462A4
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                beq.s   loc_4629C
                move.w  #$14,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4629C:                                              ; CODE XREF: Boss_Epsilon1AttackState2+18   j
                move.w  #$26,4(a5)                      ; '&'
                rts
; ---------------------------------------------------------------------------
loc_462A4:                                              ; CODE XREF: Boss_Epsilon1AttackState2+E   j
                move.w  #$32,4(a5)                      ; '2'
locret_462AA:                                           ; CODE XREF: Boss_Epsilon1AttackState2+8   j
                rts
; End of function Boss_Epsilon1AttackState2
; Initializes first attack phase with projectile ring
Boss_Epsilon1AttackPhase1Setup:                         ; DATA XREF: ROM:00045D04   o  ; was: sub_462AC
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                move.w  #8,(dword_FF9410).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1AttackPhase1Setup
; Waits for timer before advancing phase
Boss_Epsilon1AttackPhase2Wait:                          ; DATA XREF: ROM:00045D06   o  ; was: sub_462BC
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$60,d0                         ; '`'
                bcc.s   locret_462D2
                addq.w  #2,4(a5)
locret_462D2:                                           ; CODE XREF: Boss_Epsilon1AttackPhase2Wait+10   j
                rts
; End of function Boss_Epsilon1AttackPhase2Wait
; Sets up third attack phase with scaling
Boss_Epsilon1AttackPhase3Setup:                         ; DATA XREF: ROM:00045D08   o  ; was: sub_462D4
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$80,d0
                bcs.s   locret_462FA
                clr.w   (dword_FF9410).w
                move.w  #4,(dword_FF9414+2).w
                move.w  #1,(dword_FFC69C).w
                addq.w  #2,4(a5)
locret_462FA:                                           ; CODE XREF: Boss_Epsilon1AttackPhase3Setup+10   j
                rts
; End of function Boss_Epsilon1AttackPhase3Setup
; Handles boss scaling animation
Boss_Epsilon1AttackPhase4Scale:                         ; DATA XREF: ROM:00045D0A   o  ; was: sub_462FC
                addi.l  #-$400,(dword_FFC69C).w
                bsr.w   Boss_Epsilon1AttackPattern2
                bne.s   locret_4631E
                clr.l   (dword_FFC69C).w
                move.w  #4,(dword_FF9414+2).w
                move.w  #4,(dword_FF9410).w
                addq.w  #2,4(a5)
locret_4631E:                                           ; CODE XREF: Boss_Epsilon1AttackPhase4Scale+C   j
                rts
; End of function Boss_Epsilon1AttackPhase4Scale
; Initializes fifth attack phase
Boss_Epsilon1AttackPhase5Init:                          ; DATA XREF: ROM:00045D0C   o  ; was: sub_46320
                tst.w   (word_FFC7A4).w
                bne.s   locret_46336
                move.w  #0,(word_FFC7FE).w
                nop
                addq.w  #2,(word_FFC7A4).w
                addq.w  #2,4(a5)
locret_46336:                                           ; CODE XREF: Boss_Epsilon1AttackPhase5Init+4   j
                rts
; End of function Boss_Epsilon1AttackPhase5Init
; Spawns projectile rings and waits
Boss_Epsilon1AttackPhase6RingWait:                      ; DATA XREF: ROM:00045D0E   o  ; was: sub_46338
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                cmpi.w  #$A,(word_FFC7A4).w
                bne.s   locret_4634C
                addq.w  #2,(word_FFC7A4).w
                addq.w  #2,4(a5)
locret_4634C:                                           ; CODE XREF: Boss_Epsilon1AttackPhase6RingWait+A   j
                rts
; End of function Boss_Epsilon1AttackPhase6RingWait
; Spawns special entity during attack
Boss_Epsilon1AttackPhase7SpawnEntity:                   ; DATA XREF: ROM:00045D10   o  ; was: sub_4634E
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_46366
                move.w  #$10,(a0)
                move.w  a0,(dword_FF941C).w
                addq.w  #2,4(a5)
locret_46366:                                           ; CODE XREF: Boss_Epsilon1AttackPhase7SpawnEntity+A   j
                rts
; End of function Boss_Epsilon1AttackPhase7SpawnEntity
; Spawns projectile ring and updates trajectory
Boss_Epsilon1ProjectileRingAndUpdate:                   ; DATA XREF: ROM:00045D12   o  ; was: sub_46368
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_46380
                move.w  #$10,(a0)
                move.w  a0,(dword_FF941C+2).w
                addq.w  #2,4(a5)
locret_46380:                                           ; CODE XREF: Boss_Epsilon1ProjectileRingAndUpdate+A   j
                rts
; End of function Boss_Epsilon1ProjectileRingAndUpdate
; Calculates angle and spawns dual spread projectiles
Boss_Epsilon1DualProjectileAim:                         ; DATA XREF: ROM:00045D14   o  ; was: sub_46382
                movea.w (dword_FF9420).w,a0
                move.w  $10(a0),d0
                move.w  $14(a0),d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_CalculateDirectionIndex).l
                move.w  $10(a5),d0
                addq.w  #8,d0
                move.w  $14(a5),d1
                movea.w (dword_FF941C).w,a0
                bsr.s   Projectile_Epsilon1SpreadSetup
                move.w  $10(a5),d0
                subq.w  #8,d0
                move.w  $14(a5),d1
                movea.w (dword_FF941C+2).w,a0
                bsr.s   Projectile_Epsilon1SpreadSetup
                tst.w   (word_FFC7A4).w
                beq.s   loc_463CA
                move.w  #$1E,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_463CA:                                              ; CODE XREF: Boss_Epsilon1DualProjectileAim+3E   j
                move.w  #$12,4(a5)
                rts
; End of function Boss_Epsilon1DualProjectileAim
; Defeat sequence initialization
Boss_Epsilon1DefeatInit:                                ; CODE XREF: Projectile_Epsilon1WaveUpdate+30   p  ; was: sub_463D2
                                        ; Projectile_Epsilon1WaveUpdate+46   p
                move.l  #Projectile_Epsilon1SpreadInit,$48(a0)
                bra.s   loc_463E4
; End of function Boss_Epsilon1DefeatInit
; Initializes spread projectile with trajectory data
Projectile_Epsilon1SpreadSetup:                         ; CODE XREF: Boss_Epsilon1DualProjectileAim+28   p  ; was: sub_463DC
                                        ; Boss_Epsilon1DualProjectileAim+38   p
                move.l  #Projectile_Epsilon1SpreadExpanding,$48(a0)
loc_463E4:                                              ; CODE XREF: Boss_Epsilon1DefeatInit+8   j
                move.l  (dword_FFC69C).w,$1C(a0)
                move.w  d2,$58(a0)
                move.w  #$268,(a0)
                move.l  #Weapon_SpreadShotInitialSpriteFrame,$54(a0)
                move.w  #$8C80,2(a0)
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                rts
; End of function Projectile_Epsilon1SpreadSetup
; Spawns projectile type 1
Boss_Epsilon1SpawnProjectile1:                          ; DATA XREF: ROM:00045D16   o  ; was: sub_4640A
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                move.w  #8,(dword_FF9410).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1SpawnProjectile1
; Spawns projectile type 2
Boss_Epsilon1SpawnProjectile2:                          ; DATA XREF: ROM:00045D18   o  ; was: sub_4641A
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$60,d0                         ; '`'
                bcc.s   locret_46430
                addq.w  #2,4(a5)
locret_46430:                                           ; CODE XREF: Boss_Epsilon1SpawnProjectile2+10   j
                rts
; End of function Boss_Epsilon1SpawnProjectile2
; Spawns projectile type 3
Boss_Epsilon1SpawnProjectile3:                          ; DATA XREF: ROM:00045D1A   o  ; was: sub_46432
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$80,d0
                bcs.s   locret_46458
                clr.w   (dword_FF9410).w
                move.w  #4,(dword_FF9414+2).w
                move.w  #1,(dword_FFC69C).w
                addq.w  #2,4(a5)
locret_46458:                                           ; CODE XREF: Boss_Epsilon1SpawnProjectile3+10   j
                rts
; End of function Boss_Epsilon1SpawnProjectile3
; Spawns projectile type 4
Boss_Epsilon1SpawnProjectile4:                          ; DATA XREF: ROM:00045D1C   o  ; was: sub_4645A
                addi.l  #-$400,(dword_FFC69C).w
                bsr.w   Boss_Epsilon1AttackPattern2
                bne.s   locret_4647C
                clr.l   (dword_FFC69C).w
                move.w  #1,(dword_FF9414+2).w
                move.w  #8,(dword_FF9410).w
                addq.w  #2,4(a5)
locret_4647C:                                           ; CODE XREF: Boss_Epsilon1SpawnProjectile4+C   j
                rts
; End of function Boss_Epsilon1SpawnProjectile4
; Spawns projectile type 5
Boss_Epsilon1SpawnProjectile5:                          ; DATA XREF: ROM:00045D1E   o  ; was: sub_4647E
                tst.w   (word_FFC7A4).w
                bne.s   locret_46494
                move.w  #1,(word_FFC7FE).w
                nop
                addq.w  #2,(word_FFC7A4).w
                addq.w  #2,4(a5)
locret_46494:                                           ; CODE XREF: Boss_Epsilon1SpawnProjectile5+4   j
                rts
; End of function Boss_Epsilon1SpawnProjectile5
; Attack pattern 1 with spawn
Boss_Epsilon1AttackPattern1:                            ; DATA XREF: ROM:00045D20   o  ; was: sub_46496
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                cmpi.w  #$C,(word_FFC7A4).w
                bne.s   locret_464AC
                addq.w  #2,(word_FFC7A4).w
                move.w  #$12,4(a5)
locret_464AC:                                           ; CODE XREF: Boss_Epsilon1AttackPattern1+A   j
                rts
; End of function Boss_Epsilon1AttackPattern1
; Projectile type 1 main handler
Projectile_Epsilon1Type1Main:                           ; DATA XREF: ROM:00045D22   o  ; was: sub_464AE
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                move.w  #8,(dword_FF9410).w
                addq.w  #2,4(a5)
                rts
; End of function Projectile_Epsilon1Type1Main
; Projectile type 2 main handler
Projectile_Epsilon1Type2Main:                           ; DATA XREF: ROM:00045D24   o  ; was: sub_464BE
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$60,d0                         ; '`'
                bcc.s   locret_464D4
                addq.w  #2,4(a5)
locret_464D4:                                           ; CODE XREF: Projectile_Epsilon1Type2Main+10   j
                rts
; End of function Projectile_Epsilon1Type2Main
; Projectile type 3 main handler
Projectile_Epsilon1Type3Main:                           ; DATA XREF: ROM:00045D26   o  ; was: sub_464D6
                bsr.w   Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$80,d0
                bcs.s   locret_464FC
                clr.w   (dword_FF9410).w
                move.w  #4,(dword_FF9414+2).w
                move.w  #1,(dword_FFC69C).w
                addq.w  #2,4(a5)
locret_464FC:                                           ; CODE XREF: Projectile_Epsilon1Type3Main+10   j
                rts
; End of function Projectile_Epsilon1Type3Main
; Projectile type 4 main handler
Projectile_Epsilon1Type4Main:                           ; DATA XREF: ROM:00045D28   o  ; was: sub_464FE
                addi.l  #-$400,(dword_FFC69C).w
                bsr.w   Boss_Epsilon1AttackPattern2
                bne.s   locret_4652C
                clr.l   (dword_FFC69C).w
                move.w  #1,(dword_FF9414+2).w
                move.w  #$10,(dword_FF9410).w
                move.w  #0,$58(a5)
                bset    #4,$23(a5)
                addq.w  #2,4(a5)
locret_4652C:                                           ; CODE XREF: Projectile_Epsilon1Type4Main+C   j
                rts
; End of function Projectile_Epsilon1Type4Main
; Projectile type 5 main handler
Projectile_Epsilon1Type5Main:                           ; DATA XREF: ROM:00045D2A   o  ; was: sub_4652E
                bsr.w   Boss_Epsilon1InitProjectileArray
                cmpi.w  #$40,(dword_FFC694).w           ; '@'
                bgt.s   locret_4655E
                clr.l   (dword_FFC69C).w
                move.l  #$400000,(dword_FFC694).w
                move.w  #$60,(dword_FF9414).w           ; '`'
                move.w  #7,(dword_FF9414+2).w
                clr.w   (dword_FF9410).w
                clr.w   $48(a5)
                addq.w  #2,4(a5)
locret_4655E:                                           ; CODE XREF: Projectile_Epsilon1Type5Main+A   j
                rts
; End of function Projectile_Epsilon1Type5Main
; Homing projectile initialization
Projectile_Epsilon1HomingInit:                          ; DATA XREF: ROM:00045D2C   o  ; was: sub_46560
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_4658E
                move.w  #$10,(a0)
                lea     (dword_FF941C).w,a1
                move.w  $48(a5),d0
                add.w   d0,d0
                move.w  a0,(a1,d0.w)
                addq.w  #1,$48(a5)
                cmpi.w  #2,$48(a5)
                bne.s   locret_4658E
                clr.w   $48(a5)
                addq.w  #2,4(a5)
locret_4658E:                                           ; CODE XREF: Projectile_Epsilon1HomingInit+6   j
                                        ; Projectile_Epsilon1HomingInit+24   j
                rts
; End of function Projectile_Epsilon1HomingInit
; Homing projectile tracking update
Projectile_Epsilon1HomingUpdate:                        ; DATA XREF: ROM:00045D2E   o  ; was: sub_46590
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_465DE
                move.w  $48(a5),d0
                add.w   d0,d0
                lea     word_46616(pc),a1
                nop
                movea.w (a1,d0.w),a1
                move.w  a0,$4E(a1)
                move.w  #$10,(a0)
                move.w  #$CC0,2(a0)
                move.w  #$4300,$E(a0)
                move.w  #$700,8(a0)
                move.w  #$F8F0,$A(a0)
                move.w  #4,$20(a0)
                addq.w  #1,$48(a5)
                cmpi.w  #$C,$48(a5)
                bne.s   locret_465DE
                addq.w  #2,4(a5)
locret_465DE:                                           ; CODE XREF: Projectile_Epsilon1HomingUpdate+6   j
                                        ; Projectile_Epsilon1HomingUpdate+48   j
                rts
; End of function Projectile_Epsilon1HomingUpdate
; Spiral projectile initialization
Projectile_Epsilon1SpiralInit:                          ; DATA XREF: ROM:00045D30   o  ; was: sub_465E0
                clr.w   d0
                move.w  #5,d7
                lea     word_46616(pc),a2
                nop
loc_465EC:                                              ; CODE XREF: Projectile_Epsilon1SpiralInit+26   j
                movea.w (a2,d0.w),a0
                movea.w $C(a2,d0.w),a1
                tst.w   4(a0)
                bne.w   locret_46614
                tst.w   4(a1)
                bne.w   locret_46614
                addq.w  #2,d0
                dbf     d7,loc_465EC
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_46614:                                           ; CODE XREF: Projectile_Epsilon1SpiralInit+18   j
                                        ; Projectile_Epsilon1SpiralInit+20   j
                rts
; End of function Projectile_Epsilon1SpiralInit
; ---------------------------------------------------------------------------
word_46616:     dc.w    $C800, $C860, $C8C0, $C920, $C980, $C9E0, $CA40, $CAA0, $CB00, $CB60, $CBC0, $CC20
                                        ; DATA XREF: Projectile_Epsilon1HomingUpdate+E   o
                                        ; Projectile_Epsilon1SpiralInit+6   o

; Spiral projectile movement
Projectile_Epsilon1SpiralUpdate:                        ; DATA XREF: ROM:00045D32   o  ; was: sub_4662E
                bsr.w   Boss_Epsilon1AttackPattern2
                bne.s   locret_46672
                addq.w  #2,4(a5)
                move.l  #$20000,(dword_FFC69C).w
                move.l  #$4000,(dword_FF9478).w
                move.w  #$120,(dword_FFC690).w
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   locret_46672
                cmpi.w  #1,d0
                beq.s   locret_46672
                cmpi.w  #2,d0
                beq.s   loc_4666C
                addi.w  #-$40,(dword_FFC690).w
                bra.s   locret_46672
; ---------------------------------------------------------------------------
loc_4666C:                                              ; CODE XREF: Projectile_Epsilon1SpiralUpdate+34   j
                addi.w  #$40,(dword_FFC690).w           ; '@'
locret_46672:                                           ; CODE XREF: Projectile_Epsilon1SpiralUpdate+4   j
                                        ; Projectile_Epsilon1SpiralUpdate+28   j
                rts
; End of function Projectile_Epsilon1SpiralUpdate
; Attack pattern 2 with timing
Boss_Epsilon1AttackPattern2:                            ; CODE XREF: Boss_Epsilon1AttackPhase4Scale+8   p  ; was: sub_46674
                                        ; Boss_Epsilon1SpawnProjectile4+8   p
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FE,d0
                lea     (dword_FF9400).w,a0
                move.w  #5,d7
loc_46684:                                              ; CODE XREF: Boss_Epsilon1AttackPattern2+14   j
                cmp.w   (a0)+,d0
                bne.s   loc_4668C
                dbf     d7,loc_46684
loc_4668C:                                              ; CODE XREF: Boss_Epsilon1AttackPattern2+12   j
                addq.w  #1,d7
                move.w  d7,d0
                rts
; End of function Boss_Epsilon1AttackPattern2
; Wave projectile initialization
Projectile_Epsilon1WaveInit:                            ; CODE XREF: Projectile_Epsilon1WaveUpdate   p  ; was: sub_46692
                                        ; Projectile_Epsilon1BounceInit+A   p
                move.l  (dword_FF9478).w,d0
                add.l   d0,(dword_FFC69C).w
                rts
; End of function Projectile_Epsilon1WaveInit
; Wave projectile sine movement
Projectile_Epsilon1WaveUpdate:                          ; DATA XREF: ROM:00045D34   o  ; was: sub_4669C
                bsr.s   Projectile_Epsilon1WaveInit
                cmpi.w  #$90,(dword_FFC694).w
                bcs.s   locret_4670E
                bclr    #4,$23(a5)
                move.l  #$FFFFC000,(dword_FF9478).w
                move.w  #6,(dword_FF9410).w
                move.w  $10(a5),d0
                addq.w  #8,d0
                move.w  $14(a5),d1
                movea.w (dword_FF941C).w,a0
                move.w  #$7C,d2                         ; '|'
                bsr.w   Boss_Epsilon1DefeatInit
                move.w  $10(a5),d0
                subq.w  #8,d0
                move.w  $14(a5),d1
                movea.w (dword_FF941C+2).w,a0
                move.w  #$84,d2
                bsr.w   Boss_Epsilon1DefeatInit
                clr.w   $48(a5)
                clr.w   d0
                move.w  #5,d7
                lea     word_46616(pc),a2
loc_466F4:                                              ; CODE XREF: Projectile_Epsilon1WaveUpdate+6A   j
                movea.w (a2,d0.w),a0
                movea.w $C(a2,d0.w),a1
                addq.w  #2,4(a0)
                addq.w  #2,4(a1)
                addq.w  #2,d0
                dbf     d7,loc_466F4
                addq.w  #2,4(a5)
locret_4670E:                                           ; CODE XREF: Projectile_Epsilon1WaveUpdate+8   j
                rts
; End of function Projectile_Epsilon1WaveUpdate
; Bounce projectile initialization
Projectile_Epsilon1BounceInit:                          ; DATA XREF: ROM:00045D36   o  ; was: sub_46710
                cmpi.l  #$FFFE0000,(dword_FFC69C).w
                blt.s   loc_4671E
                bsr.w   Projectile_Epsilon1WaveInit
loc_4671E:                                              ; CODE XREF: Projectile_Epsilon1BounceInit+8   j
                cmpi.w  #$180,(dword_FF9414).w
                bcs.s   locret_4673C
                move.w  #6,(dword_FF9414+2).w
                clr.w   (dword_FF9410).w
                move.l  #$800,(dword_FF9478).w
                addq.w  #2,4(a5)
locret_4673C:                                           ; CODE XREF: Projectile_Epsilon1BounceInit+14   j
                rts
; End of function Projectile_Epsilon1BounceInit
; Bounce projectile physics
Projectile_Epsilon1BounceUpdate:                        ; DATA XREF: ROM:00045D38   o  ; was: sub_4673E
                bsr.w   Projectile_Epsilon1WaveInit
                clr.w   d0
                move.w  #5,d7
                lea     word_46616(pc),a0
loc_4674C:                                              ; CODE XREF: Projectile_Epsilon1BounceUpdate+24   j
                movea.w (a0,d0.w),a1
                movea.w $C(a0,d0.w),a2
                tst.w   4(a1)
                bne.s   locret_4676A
                tst.w   4(a2)
                bne.s   locret_4676A
                addq.w  #2,d0
                dbf     d7,loc_4674C
                addq.w  #2,4(a5)
locret_4676A:                                           ; CODE XREF: Projectile_Epsilon1BounceUpdate+1A   j
                                        ; Projectile_Epsilon1BounceUpdate+20   j
                rts
; End of function Projectile_Epsilon1BounceUpdate
; Laser projectile initialization
Projectile_Epsilon1LaserInit:                           ; DATA XREF: ROM:00045D3A   o  ; was: sub_4676C
                bsr.w   Boss_Epsilon1AttackPattern2
                bne.s   locret_4679A
                clr.l   (dword_FFC69C).w
                move.w  #1,(dword_FF9414+2).w
                move.w  #$10,(dword_FF9410).w
                move.w  #0,$58(a5)
                move.l  #$3000,(dword_FF9478).w
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_4679A:                                           ; CODE XREF: Projectile_Epsilon1LaserInit+4   j
                rts
; End of function Projectile_Epsilon1LaserInit
; Laser projectile beam update
Projectile_Epsilon1LaserUpdate:                         ; DATA XREF: ROM:00045D3C   o  ; was: sub_4679C
                tst.w   $48(a5)
                bmi.s   loc_467B0
                bsr.w   Projectile_Epsilon1WaveInit
                subq.w  #1,$48(a5)
                bpl.s   loc_467B0
                clr.l   (dword_FFC69C).w
loc_467B0:                                              ; CODE XREF: Projectile_Epsilon1LaserUpdate+4   j
                                        ; Projectile_Epsilon1LaserUpdate+E   j
                bsr.w   Boss_Epsilon1InitProjectileArray
                cmpi.w  #$40,(dword_FFC694).w           ; '@'
                bgt.s   locret_467D6
                move.w  #4,(dword_FF9414+2).w
                move.w  #4,(dword_FF9410).w
                clr.w   (word_FF9474).w
                clr.w   (word_FF9472).w
                move.w  #$12,4(a5)
locret_467D6:                                           ; CODE XREF: Projectile_Epsilon1LaserUpdate+1E   j
                rts
; End of function Projectile_Epsilon1LaserUpdate
; Clears projectile pointers and initializes scrolling
