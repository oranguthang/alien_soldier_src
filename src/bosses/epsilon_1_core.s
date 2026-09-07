Boss_Epsilon1Main:                                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_45AD0
                cmpi.w  #6,4(a5)
                bls.w   loc_45CD4
                btst    #6,(byte_FF8244).w
                bne.s   loc_45AEE
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$C,d0
                bhi.s   loc_45B14
loc_45AEE:                                              ; CODE XREF: Boss_Epsilon1Main+10   j
                tst.w   (word_FF9474).w
                bne.s   loc_45B14
                addq.w  #1,(word_FF9472).w
                tst.w   (word_FFFF0E).w
                bne.s   loc_45B04
                move.w  #$80,d0
                bra.s   loc_45B08
; ---------------------------------------------------------------------------
loc_45B04:                                              ; CODE XREF: Boss_Epsilon1Main+2C   j
                move.w  #$40,d0                         ; '@'
loc_45B08:                                              ; CODE XREF: Boss_Epsilon1Main+32   j
                cmp.w   (word_FF9472).w,d0
                bhi.s   loc_45B14
                move.w  #1,(word_FF9474).w
loc_45B14:                                              ; CODE XREF: Boss_Epsilon1Main+1C   j
                                        ; Boss_Epsilon1Main+22   j
                btst    #1,$4C(a5)
                bne.s   loc_45B30
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_45B30
                move.w  $50(a5),d0
                beq.s   loc_45B30
                sub.w   d0,(word_FF8234).w
loc_45B30:                                              ; CODE XREF: Boss_Epsilon1Main+4A   j
                                        ; Boss_Epsilon1Main+54   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  (dword_FFC690).w,d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$4E(a5)
                move.w  (dword_FF9414).w,d0
                lea     (Math_SineTable).l,a2
                andi.w  #$1FE,d0
                move.w  -$80(a2,d0.w),d0
                ext.l   d0
                asl.l   #5,d0
                swap    d0
                add.w   (dword_FFC694).w,d0
                move.w  d0,(dword_FF940C+2).w
                move.w  (dword_FFC690).w,(dword_FF940C).w
                move.w  #$180,d0
                sub.w   (dword_FF940C).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  #$1C8,d0
                sub.w   (dword_FF940C+2).w,d0
                move.w  d0,(dword_FFA90C).w
                bsr.w   Boss_Epsilon1UpdateRotationMatrix
                bsr.w   Boss_Epsilon1PhaseTransition
                btst    #2,(byte_FF80EC).w
                bne.s   loc_45BC4
                btst    #1,(byte_FF80EC).w
                bne.w   loc_45C5E
                tst.w   (word_FF8200).w
                bne.s   loc_45BC4
                move.b  #2,(byte_FF80EC).w
                bset    #0,$4C(a5)
                move.w  #$5C,4(a5)                      ; '\'
                clr.l   (dword_FFC698).w
                clr.l   (dword_FFC69C).w
                bset    #0,(byte_FFA272).w
                bra.w   loc_45C5E
; ---------------------------------------------------------------------------
loc_45BC4:                                              ; CODE XREF: Boss_Epsilon1Main+BE   j
                                        ; Boss_Epsilon1Main+CE   j
                move.w  (dword_FF940C).w,d2
                move.w  (dword_FF940C+2).w,d3
                move.w  d2,$10(a5)
                move.w  d3,$14(a5)
                move.w  $56(a5),d0
                lea     (Math_SineTable).l,a2
                move.w  Math_QuarterSineTable-Math_SineTable(a2,d0.w),d1
                muls.w  $54(a5),d1
                swap    d1
                move.w  (word_FFC6CC).w,d0
                add.w   d0,$10(a5)
                add.w   d1,$14(a5)
                bsr.w   Boss_Epsilon1RotationDispatcher
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FE,d0
                lea     (word_FF9480).w,a0
                move.w  #$2F,d7                         ; '/'
loc_45C08:                                              ; CODE XREF: Boss_Epsilon1Main+13E   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,loc_45C08
                lea     (word_FF9480).w,a0
                lea     (dword_FF9400).w,a1
                move.w  #5,d7
loc_45C1E:                                              ; CODE XREF: Boss_Epsilon1Main+15A   j
                move.w  (dword_FF9414+2).w,d6
loc_45C22:                                              ; CODE XREF: Boss_Epsilon1Main+154   j
                move.w  (a0)+,d0
                dbf     d6,loc_45C22
                move.w  d0,(a1)+
                dbf     d7,loc_45C1E
                move.w  (dword_FF9410).w,d0
                add.w   d0,(dword_FF9414).w
                cmpi.w  #$12,4(a5)
                bcs.s   loc_45C42
                bsr.w   Boss_Epsilon1BerserkCheck
loc_45C42:                                              ; CODE XREF: Boss_Epsilon1Main+16C   j
                bclr    #2,(byte_FF8308).w
                beq.s   loc_45C5E
                btst    #2,$4C(a5)
                bne.s   loc_45C5E
                bset    #2,$4C(a5)
                move.w  #$4E,4(a5)                      ; 'N'
loc_45C5E:                                              ; CODE XREF: Boss_Epsilon1Main+C6   j
                                        ; Boss_Epsilon1Main+F0   j
                lea     (Math_SineTable).l,a2
                move.w  (dword_FF940C).w,d2
                move.w  (dword_FF940C+2).w,d3
                movea.w #(word_FFC6E0-M68K_RAM),a1
                move.w  $52(a1),d0
                move.w  -$80(a2,d0.w),d1
                move.w  (a2,d0.w),d0
                muls.w  $50(a1),d0
                muls.w  $50(a1),d1
                swap    d0
                swap    d1
                add.w   d2,d0
                add.w   d3,d1
                add.w   $4C(a1),d0
                add.w   $4E(a1),d1
                move.w  d0,$10(a1)
                move.w  d1,$14(a1)
                bsr.w   Boss_Epsilon1PartHandler
                movea.w #(word_FFC740-M68K_RAM),a1
                move.w  $52(a1),d0
                move.w  -$80(a2,d0.w),d1
                move.w  (a2,d0.w),d0
                muls.w  $50(a1),d0
                muls.w  $50(a1),d1
                swap    d0
                swap    d1
                add.w   d2,d0
                add.w   d3,d1
                add.w   $4C(a1),d0
                add.w   $4E(a1),d1
                move.w  d0,$10(a1)
                move.w  d1,$14(a1)
                bsr.w   Boss_Epsilon1PartHandler
loc_45CD4:                                              ; CODE XREF: Boss_Epsilon1Main+6   j
                bsr.w   Boss_Epsilon1Dispatcher
                move.w  (dword_FFA908).w,d0
                neg.w   d0
                move.w  d0,(word_FFE400).w
                rts
; End of function Boss_Epsilon1Main
; Boss state dispatcher
Boss_Epsilon1Dispatcher:                                ; CODE XREF: Boss_Epsilon1Main:loc_45CD4   p  ; was: sub_45CE4
                move.w  4(a5),d0
                lea     off_45CF0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1Dispatcher
; ---------------------------------------------------------------------------
off_45CF0:      dc.w    Boss_Epsilon1BattleInit-*       ; DATA XREF: Boss_Epsilon1Dispatcher+4   o
                dc.w    Boss_Epsilon1InitTimer-*
                dc.w    Boss_Epsilon1BattleSetup-*
                dc.w    Boss_Epsilon1IntroTransition-*
                dc.w    Boss_Epsilon1AttackPhase1Init-*
                dc.w    Boss_Epsilon1RotationSetup-*
                dc.w    Boss_Epsilon1FadeWithButtonCheck-*
                dc.w    Boss_Epsilon1VictoryCheck-*
                dc.w    Boss_Epsilon1AttackState1-*
                dc.w    Boss_Epsilon1AttackState2-*
                dc.w    Boss_Epsilon1AttackPhase1Setup-*
                dc.w    Boss_Epsilon1AttackPhase2Wait-*
                dc.w    Boss_Epsilon1AttackPhase3Setup-*
                dc.w    Boss_Epsilon1AttackPhase4Scale-*
                dc.w    Boss_Epsilon1AttackPhase5Init-*
                dc.w    Boss_Epsilon1AttackPhase6RingWait-*
                dc.w    Boss_Epsilon1AttackPhase7SpawnEntity-*
                dc.w    Boss_Epsilon1ProjectileRingAndUpdate-*
                dc.w    Boss_Epsilon1DualProjectileAim-*
                dc.w    Boss_Epsilon1SpawnProjectile1-*
                dc.w    Boss_Epsilon1SpawnProjectile2-*
                dc.w    Boss_Epsilon1SpawnProjectile3-*
                dc.w    Boss_Epsilon1SpawnProjectile4-*
                dc.w    Boss_Epsilon1SpawnProjectile5-*
                dc.w    Boss_Epsilon1AttackPattern1-*
                dc.w    Projectile_Epsilon1Type1Main-*
                dc.w    Projectile_Epsilon1Type2Main-*
                dc.w    Projectile_Epsilon1Type3Main-*
                dc.w    Projectile_Epsilon1Type4Main-*
                dc.w    Projectile_Epsilon1Type5Main-*
                dc.w    Projectile_Epsilon1HomingInit-*
                dc.w    Projectile_Epsilon1HomingUpdate-*
                dc.w    Projectile_Epsilon1SpiralInit-*
                dc.w    Projectile_Epsilon1SpiralUpdate-*
                dc.w    Projectile_Epsilon1WaveUpdate-*
                dc.w    Projectile_Epsilon1BounceInit-*
                dc.w    Projectile_Epsilon1BounceUpdate-*
                dc.w    Projectile_Epsilon1LaserInit-*
                dc.w    Projectile_Epsilon1LaserUpdate-*
                dc.w    Boss_Epsilon1ResetScrollingPhase-*
                dc.w    Boss_Epsilon1AttackPattern2Transition-*
                dc.w    Boss_Epsilon1BoundsCheckReverse-*
                dc.w    Boss_Epsilon1ScrollAccelerationPhase-*
                dc.w    Boss_Epsilon1DelayTimer-*
                dc.w    Boss_Epsilon1WaitForLowHealth-*
                dc.w    Boss_Epsilon1ClearPhaseFlags-*
                dc.w    Boss_Epsilon1DefeatExplosion1-*
                dc.w    Boss_Epsilon1DefeatExplosion2-*
                dc.w    Boss_Epsilon1DefeatExplosion3-*
                dc.w    Boss_Epsilon1DefeatShake-*
                dc.w    Boss_Epsilon1DefeatFade-*
                dc.w    Boss_Epsilon1DefeatFlash-*
                dc.w    Boss_Epsilon1Defeat_FlashLoop-*
                dc.w    Boss_Epsilon1DefeatBreakup-*
                dc.w    Boss_Epsilon1PartDamageFlash-*
                dc.w    Boss_Epsilon1PartInvulnerable-*
                dc.w    Boss_Epsilon1CoreVulnerableCheck-*
                dc.w    Boss_Epsilon1DamageFlash-*
                dc.w    Boss_Epsilon1HealthBarColor-*
                dc.w    Boss_Epsilon1PartShieldCheck-*
                dc.w    Boss_Epsilon1ShieldBreak-*
                dc.w    Boss_Epsilon1ShieldRegenerate-*
                dc.w    Boss_Epsilon1FinalPhaseTransition-*
                dc.w    Cutscene_PlanetFadeIn-*

; Battle start state
Boss_Epsilon1BattleInit:                                ; DATA XREF: ROM:off_45CF0   o  ; was: sub_45D70
                tst.b   (word_FFF720).w
                bmi.w   locret_45D8C
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                move.b  #1,d0
                jsr     (Sound_PlaySFX).l
locret_45D8C:                                           ; CODE XREF: Boss_Epsilon1BattleInit+4   j
                rts
; End of function Boss_Epsilon1BattleInit
; Initial timer countdown
Boss_Epsilon1InitTimer:                                 ; DATA XREF: ROM:00045CF2   o  ; was: sub_45D8E
                subq.w  #1,$48(a5)
                bne.s   locret_45D98
                addq.w  #2,4(a5)
locret_45D98:                                           ; CODE XREF: Boss_Epsilon1InitTimer+4   j
                rts
; End of function Boss_Epsilon1InitTimer
; Complete battle setup with all objects
Boss_Epsilon1BattleSetup:                               ; DATA XREF: ROM:00045CF4   o  ; was: sub_45D9A
                bsr.w   Boss_Epsilon1UpdateHealthDisplay
                btst    #0,(word_FFA000+1).w
                bne.w   locret_46014
                btst    #1,(word_FFA000+1).w
                bne.w   locret_46014
                btst    #2,(word_FFA000+1).w
                bne.w   locret_46014
                addq.w  #1,$48(a5)
                cmpi.w  #$F,$48(a5)
                bne.w   locret_46014
                addq.w  #2,4(a5)
                clr.l   (dword_FF9400).w
                clr.l   (dword_FF9404).w
                clr.l   (dword_FF9408).w
                clr.l   (dword_FF944E).w
                clr.l   (dword_FF9452).w
                clr.l   (dword_FF9456).w
                clr.l   (dword_FF9466).w
                clr.l   (dword_FF946A).w
                clr.l   (dword_FF946E).w
                clr.l   (dword_FF9478).w
                moveq   #0,d0
                lea     (word_FF9480).w,a0
                move.w  #5,d7
loc_45E00:                                              ; CODE XREF: Boss_Epsilon1BattleSetup+70   j
                move.w  (dword_FF9414+2).w,d6
loc_45E04:                                              ; CODE XREF: Boss_Epsilon1BattleSetup+6C   j
                move.w  d0,(a0)+
                dbf     d6,loc_45E04
                dbf     d7,loc_45E00
                clr.w   (dword_FF9418+2).w
                move.b  #4,(byte_FFA420).w
                move.w  #$264,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$120,$10(a5)
                move.w  #$F0,$14(a5)
                move.w  $10(a5),(dword_FF940C).w
                move.w  $14(a5),(dword_FF940C+2).w
                move.w  #2,$48(a5)
                move.b  #$40,$20(a5)                    ; '@'
                move.l  #word_EC046,8(a5)
                move.w  #$4300,$E(a5)
                move.w  #$CC80,2(a5)
                move.b  #$90,$21(a5)
                move.b  #$88,$23(a5)
                move.w  #$C8,$26(a5)
                move.l  #$F808F808,$2C(a5)
                move.l  #$F808F808,$28(a5)
                move.w  #$16,$24(a5)
                move.w  #$18,$54(a5)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$10,(a0)
                move.b  $20(a5),$20(a0)
                move.w  #$C80,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.w  #$10,(a0)
                move.b  $20(a5),$20(a0)
                move.l  #word_EC082,8(a0)
                move.w  #$4B00,$E(a0)
                move.w  #$CC80,2(a0)
                move.l  #$F404F40A,$28(a0)
                move.b  #$80,$21(a0)
                move.b  #$10,$23(a0)
                move.w  #$FFE6,$4C(a0)
                move.w  #$36,$4E(a0)                    ; '6'
                move.w  #$1C0,$52(a0)
                move.w  #0,$50(a0)
                movea.w #(word_FFC740-M68K_RAM),a0
                move.w  #$10,(a0)
                move.b  $20(a5),$20(a0)
                move.l  #word_EC082,8(a0)
                move.w  #$4300,$E(a0)
                move.w  #$CC80,2(a0)
                move.l  #$F404F60C,$28(a0)
                move.b  #$80,$21(a0)
                move.b  #$10,$23(a0)
                move.w  #$1A,$4C(a0)
                move.w  #$36,$4E(a0)                    ; '6'
                move.w  #$140,$52(a0)
                move.w  #0,$50(a0)
                movea.w #(word_FFC7A0-M68K_RAM),a0
                move.w  #$278,(a0)
                move.w  #$C3C0,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  #$C80,2(a0)
                movea.w #(word_FFC800-M68K_RAM),a0
                movea.w #(word_FFCA40-M68K_RAM),a1
                clr.w   d6
                move.w  #$FFB0,d4
                move.w  #$50,d5                         ; 'P'
                move.w  #5,d7
loc_45F7C:                                              ; CODE XREF: Boss_Epsilon1BattleSetup+276   j
                move.w  #$284,(a0)
                move.w  #$C80,2(a0)
                move.w  #$4308,$E(a0)
                move.w  #$700,8(a0)
                move.w  #$F8F0,$A(a0)
                move.b  #$10,$23(a0)
                move.l  #$FC04F010,$2C(a0)
                move.w  #$C8,$26(a0)
                move.w  #4,$20(a0)
                move.w  d6,$4A(a0)
                move.w  d4,$4C(a0)
                move.w  #$284,(a1)
                move.w  #$C80,2(a1)
                move.w  #$4308,$E(a1)
                move.w  #$700,8(a1)
                move.w  #$F8F0,$A(a1)
                move.b  #$10,$23(a1)
                move.l  #$FC04F010,$2C(a1)
                move.w  #$C8,$26(a1)
                move.w  #4,$20(a1)
                move.w  d6,$4A(a1)
                addi.w  #6,$4A(a1)
                move.w  d5,$4C(a1)
                addi.w  #-$20,d4
                addi.w  #$20,d5                         ; ' '
                addq.w  #1,d6
                lea     $60(a0),a0
                lea     $60(a1),a1
                dbf     d7,loc_45F7C
locret_46014:                                           ; CODE XREF: Boss_Epsilon1BattleSetup+A   j
                                        ; Boss_Epsilon1BattleSetup+14   j
                rts
; End of function Boss_Epsilon1BattleSetup
; Applies palette fade effect
Boss_Epsilon1ApplyPaletteFade:                          ; CODE XREF: Boss_Epsilon1IntroTransition   p  ; was: sub_46016
                                        ; sub_461A6   p
                move.w  #$E,d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Boss_Epsilon1ApplyPaletteFade
; Intro transition with timer states
Boss_Epsilon1IntroTransition:                           ; DATA XREF: ROM:00045CF6   o  ; was: sub_46032
                bsr.w   Boss_Epsilon1ApplyPaletteFade
                tst.w   (word_FFF720).w
                bmi.s   locret_46060
                subq.w  #1,$48(a5)
                bmi.s   loc_46056
                move.w  $48(a5),d0
                add.w   d0,d0
                move.w  d0,d0
                lea     off_46052(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; ---------------------------------------------------------------------------
off_46052:      dc.w    Gfx_LoadEpsilon1AllTiles-*      ; DATA XREF: Boss_Epsilon1IntroTransition+18   o
                dc.w    Gfx_LoadEpsilon1CompressedTiles-*
; ---------------------------------------------------------------------------
loc_46056:                                              ; CODE XREF: Boss_Epsilon1IntroTransition+E   j
                tst.w   (word_FFF720).w
                bmi.s   locret_46060
                addq.w  #2,4(a5)
locret_46060:                                           ; CODE XREF: Boss_Epsilon1IntroTransition+8   j
                                        ; Boss_Epsilon1IntroTransition+28   j
                rts
; End of function Boss_Epsilon1IntroTransition
; Loads all four tile sets for Epsilon1 graphics
Gfx_LoadEpsilon1AllTiles:                               ; DATA XREF: Boss_Epsilon1IntroTransition:off_46052   o  ; was: sub_46062
                bsr.w   Gfx_LoadEpsilon1Tiles4
                bsr.w   Gfx_LoadEpsilon1Tiles3
                bsr.w   Gfx_LoadEpsilon1Tiles2
                bsr.w   Gfx_LoadEpsilon1Tiles1
                rts
; End of function Gfx_LoadEpsilon1AllTiles
; Loads compressed tile data for Epsilon1
Gfx_LoadEpsilon1CompressedTiles:                        ; DATA XREF: Boss_Epsilon1IntroTransition+22   o  ; was: sub_46074
                bsr.w   Gfx_LoadEpsilon1TilesSet3
                bsr.w   Gfx_LoadEpsilon1TilesSet1
                rts
; End of function Gfx_LoadEpsilon1CompressedTiles
; Loads compressed tiles set 1
Gfx_LoadEpsilon1Tiles1:                                 ; CODE XREF: Gfx_LoadEpsilon1AllTiles+C   p  ; was: sub_4607E
                                        ; Boss_Epsilon1PhaseTransition+58   p
                lea     word_4608A(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1Tiles1
; ---------------------------------------------------------------------------
word_4608A:     dc.w    $4130, $2000, $300, $A1A2, $A3A8
                                        ; DATA XREF: Gfx_LoadEpsilon1Tiles1   o

; Loads graphics for phase 2
Boss_Epsilon1LoadGraphicsPhase2:                        ; CODE XREF: Boss_Epsilon1PhaseTransition:loc_47A6C   p  ; was: sub_46094
                                        ; sub_47A0E:loc_47AC0   p
                lea     word_460A0(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_Epsilon1LoadGraphicsPhase2
; ---------------------------------------------------------------------------
word_460A0:     dc.w    $4130, $2000, $300, 0, 0
                                        ; DATA XREF: Boss_Epsilon1LoadGraphicsPhase2   o

; Loads compressed tiles set 2
Gfx_LoadEpsilon1Tiles2:                                 ; CODE XREF: Gfx_LoadEpsilon1AllTiles+8   p  ; was: sub_460AA
                                        ; Boss_Epsilon1PhaseTransition+72   p
                lea     word_460B6(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1Tiles2
; ---------------------------------------------------------------------------
word_460B6:     dc.w    $4330, $2000, $300, $A5A6, $A7AC
                                        ; DATA XREF: Gfx_LoadEpsilon1Tiles2   o

; Loads graphics for phase 3
Boss_Epsilon1LoadGraphicsPhase3:                        ; CODE XREF: Boss_Epsilon1PhaseTransition:loc_47A86   p  ; was: sub_460C0
                                        ; Boss_Epsilon1PhaseTransition+B6   p
                lea     word_460CC(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_Epsilon1LoadGraphicsPhase3
; ---------------------------------------------------------------------------
word_460CC:     dc.w    $4330, $2000, $300, 0, 0
                                        ; DATA XREF: Boss_Epsilon1LoadGraphicsPhase3   o

; Loads compressed tiles set 3
Gfx_LoadEpsilon1Tiles3:                                 ; CODE XREF: Gfx_LoadEpsilon1AllTiles+4   p  ; was: sub_460D6
                                        ; Boss_Epsilon1PhaseTransition+8C   p
                lea     word_460E2(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1Tiles3
; ---------------------------------------------------------------------------
word_460E2:     dc.w    $4530, $2000, $300, $A9AA, $ABAD
                                        ; DATA XREF: Gfx_LoadEpsilon1Tiles3   o

; Loads graphics for phase 4
Boss_Epsilon1LoadGraphicsPhase4:                        ; CODE XREF: Boss_Epsilon1PhaseTransition:loc_47AA0   p  ; was: sub_460EC
                                        ; Boss_Epsilon1PhaseTransition+BA   p
                lea     word_460F8(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_Epsilon1LoadGraphicsPhase4
; ---------------------------------------------------------------------------
word_460F8:     dc.w    $4530, $2000, $300, 0, 0
                                        ; DATA XREF: Boss_Epsilon1LoadGraphicsPhase4   o

; Loads compressed tiles set 4
Gfx_LoadEpsilon1Tiles4:                                 ; CODE XREF: Gfx_LoadEpsilon1AllTiles   p  ; was: sub_46102
                                        ; Boss_Epsilon1PhaseTransition+A6   p
                lea     word_4610E(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1Tiles4
; ---------------------------------------------------------------------------
word_4610E:     dc.w    $4730, $2000, $300, $AE, $AF00
                                        ; DATA XREF: Gfx_LoadEpsilon1Tiles4   o

; Loads graphics for phase 5
Boss_Epsilon1LoadGraphicsPhase5:                        ; CODE XREF: Boss_Epsilon1PhaseTransition:loc_47ABA   p  ; was: sub_46118
                                        ; Boss_Epsilon1PhaseTransition+BE   p
                lea     word_46124(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_Epsilon1LoadGraphicsPhase5
; ---------------------------------------------------------------------------
word_46124:     dc.w    $4730, $2000, $300, 0, 0
                                        ; DATA XREF: Boss_Epsilon1LoadGraphicsPhase5   o

; Loads first compressed tile set to VRAM
Gfx_LoadEpsilon1TilesSet1:                              ; CODE XREF: Gfx_LoadEpsilon1CompressedTiles+4   p  ; was: sub_4612E
                lea     word_4613A(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1TilesSet1
; ---------------------------------------------------------------------------
word_4613A:     dc.w    $4180, $2000, $501, $9A9A, $9A9A, $9A9A, $9E9E, $9E9E, $9E9E
                                        ; DATA XREF: Gfx_LoadEpsilon1TilesSet1   o

; Loads second compressed tile set
Gfx_LoadEpsilon1TilesSet2:
                lea     word_46158(pc),a0               ; was: sub_4614C
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1TilesSet2
; ---------------------------------------------------------------------------
word_46158:     dc.w    $4180, $2000, $501, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: Gfx_LoadEpsilon1TilesSet2   o

; Loads third compressed tile set
Gfx_LoadEpsilon1TilesSet3:                              ; CODE XREF: Gfx_LoadEpsilon1CompressedTiles   p  ; was: sub_4616A
                lea     word_46176(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1TilesSet3
; ---------------------------------------------------------------------------
word_46176:     dc.w    $41D0, $2000, $501, $9A9A, $9A9A, $9A9A, $9E9E, $9E9E, $9E9E
                                        ; DATA XREF: Gfx_LoadEpsilon1TilesSet3   o

; Loads fourth compressed tile set
Gfx_LoadEpsilon1TilesSet4:
                lea     word_46194(pc),a0               ; was: sub_46188
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1TilesSet4
; ---------------------------------------------------------------------------
word_46194:     dc.w    $41D0, $2000, $501, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: Gfx_LoadEpsilon1TilesSet4   o

; Attack phase 1 initialization
