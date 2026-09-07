Boss_Epsilon1CheckVulnerable:                           ; CODE XREF: Projectile_Epsilon1DefeatDebris   p  ; was: sub_477D8
                                        ; sub_472C0   p
                btst    #0,(word_FFC66C).w
                bne.s   loc_477E8
                btst    #2,(word_FFC66C).w
                beq.s   locret_477F6
loc_477E8:                                              ; CODE XREF: Boss_Epsilon1CheckVulnerable+6   j
                move.l  #off_E95DC,8(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
locret_477F6:                                           ; CODE XREF: Boss_Epsilon1CheckVulnerable+E   j
                rts
; End of function Boss_Epsilon1CheckVulnerable
; Initializes projectile array
Boss_Epsilon1InitProjectileArray:                       ; CODE XREF: Projectile_Epsilon1Type5Main   p  ; was: sub_477F8
                                        ; sub_4679C:loc_467B0   p
                move.w  (dword_FF9414).w,d0
                addi.w  #$40,d0                         ; '@'
                andi.w  #$180,d0
                lsr.w   #6,d0
                move.w  word_4782A(pc,d0.w),d0
                move.w  (dword_FF9410).w,d1
                muls.w  d0,d1
                cmpi.w  #0,$58(a5)
                bne.s   loc_4781E
                tst.w   d0
                bpl.s   locret_47822
                bra.s   loc_47824
; ---------------------------------------------------------------------------
loc_4781E:                                              ; CODE XREF: Boss_Epsilon1InitProjectileArray+1E   j
                tst.w   d0
                bpl.s   loc_47824
locret_47822:                                           ; CODE XREF: Boss_Epsilon1InitProjectileArray+22   j
                rts
; ---------------------------------------------------------------------------
loc_47824:                                              ; CODE XREF: Boss_Epsilon1InitProjectileArray+24   j
                                        ; Boss_Epsilon1InitProjectileArray+28   j
                add.l   d1,(dword_FFC694).w
                rts
; End of function Boss_Epsilon1InitProjectileArray
; ---------------------------------------------------------------------------
word_4782A:     dc.w    $4000, $4000, $C000, $C000
                                        ; DATA XREF: Boss_Epsilon1InitProjectileArray+E   r

; Spawns ring of projectiles
Boss_Epsilon1SpawnProjectileRing:                       ; CODE XREF: Boss_Epsilon1AttackPhase1Setup   p  ; was: sub_47832
                                        ; sub_462BC   p
                cmpi.w  #$80,(dword_FFC694).w
                bcs.s   loc_47856
                cmpi.w  #$E0,(dword_FFC694).w
                bhi.s   loc_4785E
                move.b  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                bne.s   loc_47864
                move.b  (dword_FFFF08+1).w,d0
                andi.b  #1,d0
                beq.s   loc_4785E
loc_47856:                                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+6   j
                move.w  #1,$58(a5)
                bra.s   loc_47864
; ---------------------------------------------------------------------------
loc_4785E:                                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+E   j
                                        ; Boss_Epsilon1SpawnProjectileRing+22   j
                move.w  #0,$58(a5)
loc_47864:                                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+18   j
                                        ; Boss_Epsilon1SpawnProjectileRing+2A   j
                bsr.w   Boss_Epsilon1InitProjectileArray
                cmpi.w  #0,$58(a5)
                beq.w   loc_4787C
                move.w  (word_FFA000).w,d7
                andi.w  #3,d7
                bne.s   loc_4789C
loc_4787C:                                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+3C   j
                jsr     (Physics_GetPlayerDelta).l
                tst.w   d0
                beq.s   loc_4789C
                tst.w   d1
                bpl.s   loc_47894
loc_4788A:                                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+78   j
                move.l  #$FFFFC000,(dword_FFC6DC).w
                bra.s   loc_4789C
; ---------------------------------------------------------------------------
loc_47894:                                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+56   j
                                        ; Boss_Epsilon1SpawnProjectileRing+80   j
                move.l  #$4000,(dword_FFC6DC).w
loc_4789C:                                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+48   j
                                        ; Boss_Epsilon1SpawnProjectileRing+52   j
                move.l  (dword_FFC6DC).w,d0
                add.l   (dword_FFC6D8).w,d0
                cmpi.l  #$20000,d0
                bge.s   loc_4788A
                cmpi.l  #$FFFE0000,d0
                ble.s   loc_47894
                move.l  d0,(dword_FFC6D8).w
                move.l  (dword_FFC6D8).w,d0
                add.l   d0,(dword_FFC690).w
                rts
; End of function Boss_Epsilon1SpawnProjectileRing
; Checks if boss enters berserk mode
Boss_Epsilon1BerserkCheck:                              ; CODE XREF: Boss_Epsilon1Main+16E   p  ; was: sub_478C2
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_478E8
                move.w  $52(a5),d0
                add.w   d0,d0
                move.w  word_478EA(pc,d0.w),(word_FFE37C).w
                addq.w  #1,$52(a5)
                cmpi.w  #$E,$52(a5)
                bne.s   locret_478E8
                clr.w   $52(a5)
locret_478E8:                                           ; CODE XREF: Boss_Epsilon1BerserkCheck+8   j
                                        ; Boss_Epsilon1BerserkCheck+20   j
                rts
; End of function Boss_Epsilon1BerserkCheck
; ---------------------------------------------------------------------------
word_478EA:     dc.w    $E, $C, $A, 8, 6, 4, 2, 0, 2, 4, 6, 8, $A, $C
                                        ; DATA XREF: Boss_Epsilon1BerserkCheck+10   r

; Updates rotation transformation matrix
Boss_Epsilon1UpdateRotationMatrix:                      ; CODE XREF: Boss_Epsilon1Main+B0   p  ; was: sub_47906
                lea     (dword_FF8A00).w,a1
                move.w  #$13,d7
                move.w  #$30,d0                         ; '0'
loc_47912:                                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+E   j
                move.w  d0,(a1)+
                dbf     d7,loc_47912
                move.w  (dword_FFA90C).w,d2
                lea     (dword_FF8A00).w,a1
                lea     (Math_SineTable).l,a2
                lea     (dword_FF942C).w,a3
                lea     (dword_FF9466).w,a4
                move.w  (dword_FFC690).w,d6
                subi.w  #$40,d6                         ; '@'
                move.w  #7,d7
loc_4793A:                                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+50   j
                move.w  d6,d1
                subi.w  #$80,d1
                bmi.s   loc_47952
                cmpi.w  #$140,d1
                bhi.s   loc_47952
                andi.w  #$1F0,d1
                lsr.w   #3,d1
                move.w  d2,(a1,d1.w)
loc_47952:                                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+3A   j
                                        ; Boss_Epsilon1UpdateRotationMatrix+40   j
                addi.w  #$10,d6
                dbf     d7,loc_4793A
                move.w  d2,d3
                subq.w  #8,d3
                move.w  #5,d7
                lea     (dword_FF9400).w,a0
                move.w  (dword_FFC690).w,d5
                move.w  d5,d6
                subi.w  #$60,d5                         ; '`'
                addi.w  #$40,d6                         ; '@'
loc_47974:                                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+102   j
                move.w  (a0)+,d0
                move.w  -$80(a2,d0.w),d0
                ext.l   d0
                asl.l   #6,d0
                swap    d0
                add.w   d0,d3
                add.w   (a4)+,d3
                cmpi.w  #$120,d3
                bgt.s   loc_479F8
                cmpi.w  #$48,d3                         ; 'H'
                blt.s   loc_479F8
                move.w  d5,d1
                subi.w  #$80,d1
                bmi.s   loc_479A8
                cmpi.w  #$140,d1
                bgt.s   loc_479A8
                andi.w  #$1F0,d1
                lsr.w   #3,d1
                move.w  d3,(a1,d1.w)
loc_479A8:                                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+90   j
                                        ; Boss_Epsilon1UpdateRotationMatrix+96   j
                move.w  d5,d1
                addi.w  #$10,d1
                subi.w  #$80,d1
                bmi.s   loc_479C4
                cmpi.w  #$140,d1
                bgt.s   loc_479C4
                andi.w  #$1F0,d1
                lsr.w   #3,d1
                move.w  d3,(a1,d1.w)
loc_479C4:                                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+AC   j
                                        ; Boss_Epsilon1UpdateRotationMatrix+B2   j
                move.w  d6,d1
                subi.w  #$80,d1
                bmi.s   loc_479DC
                cmpi.w  #$140,d1
                bgt.s   loc_479DC
                andi.w  #$1F0,d1
                lsr.w   #3,d1
                move.w  d3,(a1,d1.w)
loc_479DC:                                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+C4   j
                                        ; Boss_Epsilon1UpdateRotationMatrix+CA   j
                move.w  d6,d1
                addi.w  #$10,d1
                subi.w  #$80,d1
                bmi.s   loc_479F8
                cmpi.w  #$140,d1
                bgt.s   loc_479F8
                andi.w  #$1F0,d1
                lsr.w   #3,d1
                move.w  d3,(a1,d1.w)
loc_479F8:                                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+82   j
                                        ; Boss_Epsilon1UpdateRotationMatrix+88   j
                subi.w  #$20,d5                         ; ' '
                addi.w  #$20,d6                         ; ' '
                move.w  d3,(a3)
                move.w  d3,$C(a3)
                addq.w  #2,a3
                dbf     d7,loc_47974
                rts
; End of function Boss_Epsilon1UpdateRotationMatrix
; Phase transition with graphics load
Boss_Epsilon1PhaseTransition:                           ; CODE XREF: Boss_Epsilon1Main+B4   p  ; was: sub_47A0E
                tst.b   (word_FFF720).w
                bmi.w   locret_47B06
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                tst.w   d0
                beq.s   loc_47A44
                cmpi.w  #$70,4(a5)                      ; 'p'
                bcc.w   locret_47B06
                cmpi.w  #1,d0
                beq.w   loc_47AD2
                cmpi.w  #2,d0
                beq.w   loc_47ADA
                cmpi.w  #3,d0
                beq.w   loc_47AE2
loc_47A44:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+12   j
                cmpi.w  #$180,(dword_FFA908).w
                bgt.s   loc_47AC0
                cmpi.w  #$FF80,(dword_FFA908).w
                blt.w   loc_47AC0
                cmpi.w  #$20,(dword_FFA90C).w           ; ' '
                blt.s   loc_47A6C
                cmpi.w  #$120,(dword_FFA90C).w
                bgt.s   loc_47A6C
                bsr.w   Gfx_LoadEpsilon1Tiles1
                bra.s   loc_47A70
; ---------------------------------------------------------------------------
loc_47A6C:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+4E   j
                                        ; Boss_Epsilon1PhaseTransition+56   j
                bsr.w   Boss_Epsilon1LoadGraphicsPhase2
loc_47A70:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+5C   j
                cmpi.w  #$40,(dword_FFA90C).w           ; '@'
                blt.s   loc_47A86
                cmpi.w  #$140,(dword_FFA90C).w
                bgt.s   loc_47A86
                bsr.w   Gfx_LoadEpsilon1Tiles2
                bra.s   loc_47A8A
; ---------------------------------------------------------------------------
loc_47A86:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+68   j
                                        ; Boss_Epsilon1PhaseTransition+70   j
                bsr.w   Boss_Epsilon1LoadGraphicsPhase3
loc_47A8A:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+76   j
                cmpi.w  #$60,(dword_FFA90C).w           ; '`'
                blt.s   loc_47AA0
                cmpi.w  #$160,(dword_FFA90C).w
                bgt.s   loc_47AA0
                bsr.w   Gfx_LoadEpsilon1Tiles3
                bra.s   loc_47AA4
; ---------------------------------------------------------------------------
loc_47AA0:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+82   j
                                        ; Boss_Epsilon1PhaseTransition+8A   j
                bsr.w   Boss_Epsilon1LoadGraphicsPhase4
loc_47AA4:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+90   j
                cmpi.w  #$80,(dword_FFA90C).w
                blt.s   loc_47ABA
                cmpi.w  #$180,(dword_FFA90C).w
                bgt.s   loc_47ABA
                bsr.w   Gfx_LoadEpsilon1Tiles4
                rts
; ---------------------------------------------------------------------------
loc_47ABA:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+9C   j
                                        ; Boss_Epsilon1PhaseTransition+A4   j
                bsr.w   Boss_Epsilon1LoadGraphicsPhase5
                rts
; ---------------------------------------------------------------------------
loc_47AC0:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+3C   j
                                        ; Boss_Epsilon1PhaseTransition+44   j
                bsr.w   Boss_Epsilon1LoadGraphicsPhase2
                bsr.w   Boss_Epsilon1LoadGraphicsPhase3
                bsr.w   Boss_Epsilon1LoadGraphicsPhase4
                bsr.w   Boss_Epsilon1LoadGraphicsPhase5
                rts
; ---------------------------------------------------------------------------
loc_47AD2:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+22   j
                move.w  #0,(word_FF9444).w
                bra.s   loc_47AE8
; ---------------------------------------------------------------------------
loc_47ADA:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+2A   j
                move.w  #2,(word_FF9444).w
                bra.s   loc_47AE8
; ---------------------------------------------------------------------------
loc_47AE2:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+32   j
                move.w  #4,(word_FF9444).w
loc_47AE8:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+CA   j
                                        ; Boss_Epsilon1PhaseTransition+D2   j
                move.w  #2,(dword_FF9418).w
loc_47AEE:                                              ; CODE XREF: Boss_Epsilon1PhaseTransition+F6   j
                move.w  (word_FF9444).w,d0
                bsr.s   Boss_Epsilon1UpdatePaletteAnim
                move.w  (word_FF9444).w,d0
                addq.w  #6,d0
                bsr.s   Boss_Epsilon1UpdatePaletteAnim
                addq.w  #1,(word_FF9444).w
                subq.w  #1,(dword_FF9418).w
                bne.s   loc_47AEE
locret_47B06:                                           ; CODE XREF: Boss_Epsilon1PhaseTransition+4   j
                                        ; Boss_Epsilon1PhaseTransition+1A   j
                rts
; End of function Boss_Epsilon1PhaseTransition
; Updates palette animation
Boss_Epsilon1UpdatePaletteAnim:                         ; CODE XREF: Boss_Epsilon1PhaseTransition+E4   p  ; was: sub_47B08
                                        ; Boss_Epsilon1PhaseTransition+EC   p
                lea     (word_FF9446).w,a0
                add.w   d0,d0
                move.w  #$4000,d1
                add.w   word_47B56(pc,d0.w),d1
                move.w  d1,(a0)
                move.w  #$2000,2(a0)
                move.w  #1,4(a0)
                lea     (dword_FF944E).w,a1
                move.w  (a1,d0.w),d1
                bne.s   loc_47B40
                cmpi.w  #$C,d0
                bcs.s   loc_47B38
                subi.w  #$C,d0
loc_47B38:                                              ; CODE XREF: Boss_Epsilon1UpdatePaletteAnim+2A   j
                lea     (dword_FF9400).w,a1
                move.w  (a1,d0.w),d1
loc_47B40:                                              ; CODE XREF: Boss_Epsilon1UpdatePaletteAnim+24   j
                addi.w  #$10,d1
                andi.w  #$1E0,d1
                lsr.w   #4,d1
                move.w  word_47B6E(pc,d1.w),6(a0)
                jmp     Gfx_DMATransferTiles
; End of function Boss_Epsilon1UpdatePaletteAnim
; ---------------------------------------------------------------------------
word_47B56:     dc.w    $1A8, $1A0, $198, $190, $188, $180, $1D0, $1D8, $1E0, $1E8, $1F0, $1F8
                                        ; DATA XREF: Boss_Epsilon1UpdatePaletteAnim+A   r
word_47B6E:     dc.w    $989C, $999D, $9A9E, $9B9F, $A0A4, $A0A4, $A0A4, $A0A4, $A0A4, $9B9F, $9A9E, $999D, $989C, $989C, $989C, $989C
                                        ; DATA XREF: Boss_Epsilon1UpdatePaletteAnim+42   r

; Intro controller state dispatcher
Boss_Epsilon1IntroController:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_47B8E
                move.w  4(a5),d0
                lea     off_47B9A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1IntroController
; ---------------------------------------------------------------------------
off_47B9A:      dc.w    Boss_Epsilon1SpawnIntroProjectile-*  ; DATA XREF: Boss_Epsilon1IntroController+4   o
                dc.w    Boss_Epsilon1WaitForProjectile-*
                dc.w    Boss_Epsilon1RepeatIntro-*
                dc.w    Boss_Epsilon1IntroFadeOut-*

; Spawns boss intro projectile
Boss_Epsilon1SpawnIntroProjectile:                      ; DATA XREF: ROM:off_47B9A   o  ; was: sub_47BA2
                tst.b   (word_FF80C2).w
                bne.s   locret_47BD2
                addq.w  #2,4(a5)
                move.w  #2,$4A(a5)
                movea.w #(word_FFC7A0-M68K_RAM),a0
                move.w  #$278,(a0)
                move.w  #$C3C0,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  #$C80,2(a0)
locret_47BD2:                                           ; CODE XREF: Boss_Epsilon1SpawnIntroProjectile+4   j
                rts
; End of function Boss_Epsilon1SpawnIntroProjectile
; Waits for projectile completion
Boss_Epsilon1WaitForProjectile:                         ; DATA XREF: ROM:00047B9C   o  ; was: sub_47BD4
                tst.w   (word_FFC7A4).w
                bne.s   locret_47BE8
                move.w  #1,(word_FFC7FE).w
                addq.w  #2,(word_FFC7A4).w
                addq.w  #2,4(a5)
locret_47BE8:                                           ; CODE XREF: Boss_Epsilon1WaitForProjectile+4   j
                rts
; End of function Boss_Epsilon1WaitForProjectile
; Repeats intro sequence
Boss_Epsilon1RepeatIntro:                               ; DATA XREF: ROM:00047B9E   o  ; was: sub_47BEA
                cmpi.w  #$C,(word_FFC7A4).w
                bne.s   locret_47C00
                addq.w  #2,(word_FFC7A4).w
                subq.w  #1,$4A(a5)
                beq.s   loc_47C02
                subq.w  #2,4(a5)
locret_47C00:                                           ; CODE XREF: Boss_Epsilon1RepeatIntro+6   j
                rts
; ---------------------------------------------------------------------------
loc_47C02:                                              ; CODE XREF: Boss_Epsilon1RepeatIntro+10   j
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1RepeatIntro
; Timer countdown with fade out
Boss_Epsilon1IntroFadeOut:                              ; DATA XREF: ROM:00047BA0   o  ; was: sub_47C0E
                subq.w  #1,$48(a5)
                bne.s   locret_47C1A
                move.w  #$1000,2(a5)
locret_47C1A:                                           ; CODE XREF: Boss_Epsilon1IntroFadeOut+4   j
                rts
; End of function Boss_Epsilon1IntroFadeOut
; Main Sharpsteel boss handler
