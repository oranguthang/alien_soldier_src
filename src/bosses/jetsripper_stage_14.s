Enemy_Stage14TurretMain:                                ; CODE XREF: Boss_JetsripperProjectileTurretCheck+6   j  ; was: sub_32344
                                        ; Enemy_Stage14TurretInit+18   j
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                jsr     (Boss_JetsripperAttackPattern1).l
                andi.w  #$FEFF,2(a5)
                rts
; End of function Enemy_Stage14TurretMain
; Reflects projectile by negating X velocity and advancing state
Boss_JetsripperProjectileReflect:                       ; CODE XREF: Boss_JetsripperProjectileBounce+6   j  ; was: sub_3235C
                neg.l   $18(a5)
                move.w  #2,4(a5)
                rts
; End of function Boss_JetsripperProjectileReflect
; Returns projectile to stored velocity after delay timer expires
Boss_JetsripperProjectileReturn:                        ; DATA XREF: ROM:0003221C   o  ; was: sub_32368
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.l  $4C(a5),$18(a5)
                move.l  $50(a5),$1C(a5)
                subq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperProjectileReturn
; Initializes turret
Enemy_Stage14TurretInit:                                ; DATA XREF: ROM:000314D6   o  ; was: sub_32382
                bsr.w   Enemy_DeathExplode
                bsr.w   Projectile_DestroyerProtoUpdate
                bclr    #7,$22(a5)
                beq.w   locret_30BB8
                bclr    #4,$22(a5)
                bne.w   Enemy_Stage14TurretMain
loc_3239E:                                              ; CODE XREF: Enemy_FlierBoundsCheck+E   j
                cmpi.w  #$1A,(StageTableIndex).w
                bne.s   loc_323B8
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w            ; ' '
                move.b  #8,(byte_FF8143).w
loc_323B8:                                              ; CODE XREF: Enemy_Stage14TurretInit+22   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_323DA
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E9560,8(a0)
                jsr     (Sprite_InitType160).l
loc_323DA:                                              ; CODE XREF: Enemy_Stage14TurretInit+3C   j
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_Stage14TurretInit
; Main state dispatcher for Jetsripper boss using indexed jump table
Boss_JetsripperStateDispatcher:                         ; DATA XREF: ROM:off_5DC   o  ; was: sub_323E2
                move.w  $48(a5),d0
                lea     off_323EE(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JetsripperStateDispatcher
; ---------------------------------------------------------------------------
off_323EE:      dc.w    Boss_JetsripperIntroSequence-*  ; DATA XREF: Boss_JetsripperStateDispatcher+4   o
                dc.w    Enemy_Stage14FlierAttack-*
                dc.w    Boss_JetsripperDeathRotate-*
                dc.w    Enemy_Stage14FlierCheckBounds-*
                dc.w    Enemy_FlierDeathDispatcher-*
                dc.w    Enemy_FlierBoundsCheck-*

; Handles boss intro with palette fade and stage initialization
Boss_JetsripperIntroSequence:                           ; DATA XREF: ROM:off_323EE   o  ; was: sub_323FA
                jsr     (Gfx_InitPaletteFade).l
                cmpi.w  #$1E,4(a5)
                bcc.s   loc_32420
                tst.w   (word_FF8200).w
                bne.s   loc_32420
                move.w  #1,(dword_FF9414+2).w
                bset    #0,(byte_FFA272).w
                move.w  #$1E,4(a5)
loc_32420:                                              ; CODE XREF: Boss_JetsripperIntroSequence+C   j
                                        ; Boss_JetsripperIntroSequence+12   j
                move.w  4(a5),d0
                lea     off_3242C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JetsripperIntroSequence
; ---------------------------------------------------------------------------
off_3242C:      dc.w    Boss_JetsripperSpawnInit-*      ; DATA XREF: Boss_JetsripperIntroSequence+2A   o
                dc.w    Boss_JetsripperFlyIn-*
                dc.w    Enemy_Stage14FlierMove-*
                dc.w    Enemy_Stage14TurretFire-*
                dc.w    Boss_JetsripperSpawnCircleShots-*
                dc.w    Boss_JetsripperReverseCircle-*
                dc.w    Boss_JetsripperRetractCircle-*
                dc.w    Boss_JetsripperStabilizeVelocity-*
                dc.w    Boss_JetsripperResetComponents-*
                dc.w    Boss_JetsripperWindupRotation-*
                dc.w    Boss_JetsripperPhase4Init-*
                dc.w    Boss_JetsripperPhase5Wait-*
                dc.w    Projectile_Stage14BulletMain-*
                dc.w    Projectile_Stage14BulletInit-*
                dc.w    Boss_JetsripperPhase7Wait-*
                dc.w    Boss_JetsripperPhase8Init-*
                dc.w    Boss_JetsripperDeathExplosion-*

; Spawns Jetsripper boss with full initialization of graphics, entities, and components
Boss_JetsripperSpawnInit:                               ; DATA XREF: ROM:off_3242C   o  ; was: sub_3244E
                clr.w   (dword_FF9414+2).w
                move.w  #$100,$14(a5)
                move.w  #$200,$10(a5)
                bsr.w   Enemy_Stage14FlierInit
                tst.w   (word_FFF720).w
                bmi.w   locret_30BB8
                move.l  #word_32604,(dword_FF9400).w
                move.w  #1,(dword_FF9404).w
                move.b  #4,(byte_FFA95A).w
                move.b  #$50,$21(a5)                    ; 'P'
                move.b  #$98,$23(a5)
                move.w  #$18,$24(a5)
                move.w  #$8C00,2(a5)
                move.w  #$E00,8(a5)
                move.w  #$F0F8,$A(a5)
                move.w  #$632C,$E(a5)
                move.l  #$D828D828,$2C(a5)
                move.l  #$D030D030,$28(a5)
                move.b  #$54,$20(a5)                    ; 'T'
                move.w  #$64,$26(a5)                    ; 'd'
                movea.l #word_32666,a0
                jsr     (Gfx_LoadCompressedTiles).l
                move.w  #$FFFE,$18(a5)
                move.l  #$80000,(dword_FF940C+2).w
                addq.w  #2,4(a5)
                movea.w a5,a4
                adda.w  #$60,a4                         ; '`'
                bsr.w   Enemy_Stage14FlierMain
                move.w  #2,$48(a4)
                move.w  #0,8(a4)
                move.w  #$FCFC,$A(a4)
                move.w  #$6351,$E(a4)
                move.w  #$100,$40(a4)
                move.w  #$14,$42(a4)
                move.w  a5,$44(a4)
                adda.w  #$60,a4                         ; '`'
                bsr.w   Enemy_Stage14FlierMain
                move.w  #2,$48(a4)
                move.w  #0,8(a4)
                move.w  #$FCFC,$A(a4)
                move.w  #$6352,$E(a4)
                move.w  #$100,$40(a4)
                move.w  #$10,$42(a4)
                move.w  a5,$44(a4)
                adda.w  #$60,a4                         ; '`'
                move.w  #7,d6
loc_3254C:                                              ; CODE XREF: Boss_JetsripperSpawnInit+130   j
                adda.w  #$60,a4                         ; '`'
                bsr.w   Enemy_Stage14FlierMain
                move.w  #6,$48(a4)
                move.w  #$500,8(a4)
                move.w  #$F8F8,$A(a4)
                move.w  #$6334,$E(a4)
                move.w  d6,d0
                lsl.w   #6,d0
                move.w  d0,$40(a4)
                move.w  #$C0,$42(a4)
                move.w  a5,$44(a4)
                dbf     d6,loc_3254C
                rts
; End of function Boss_JetsripperSpawnInit
; Flying enemy main handler
Enemy_Stage14FlierMain:                                 ; CODE XREF: Boss_JetsripperSpawnInit+9A   p  ; was: sub_32584
                                        ; Boss_JetsripperSpawnInit+CA   p
                move.w  #$8C00,2(a4)
                move.w  #$6300,$E(a4)
                move.b  #$50,$20(a4)                    ; 'P'
                move.b  #$40,$21(a4)                    ; '@'
                move.l  #$FC04FC04,$2C(a4)
                move.w  #$32,$26(a4)                    ; '2'
                move.w  #$3C0,(a4)
                clr.w   4(a4)
                move.w  $10(a5),$10(a4)
                move.w  $14(a5),$14(a4)
                rts
; End of function Enemy_Stage14FlierMain
; Initializes flying enemy
Enemy_Stage14FlierInit:                                 ; CODE XREF: Boss_JetsripperSpawnInit+10   p  ; was: sub_325C0
                                        ; Boss_JetsripperFlyIn+4   p
                move.w  #$2A8,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                subi.w  #$A8,d0
                move.w  d0,(dword_FFA90C).w
                rts
; End of function Enemy_Stage14FlierInit
; Updates boss animation frames by loading compressed tile data on timer
Boss_JetsripperUpdateAnimation:                         ; CODE XREF: Boss_JetsripperFlyIn+8   p  ; was: sub_325DA
                                        ; Enemy_Stage14FlierMove+8   p
                subq.w  #1,(dword_FF9404).w
                bne.w   locret_30BB8
                movea.l (dword_FF9400).w,a0
                tst.w   (a0)
                bpl.s   loc_325F0
                movea.l #word_32604,a0
loc_325F0:                                              ; CODE XREF: Boss_JetsripperUpdateAnimation+E   j
                move.w  (a0)+,(dword_FF9404).w
                move.w  (a0)+,d0
                move.l  a0,(dword_FF9400).w
                movea.l off_32636(pc,d0.w),a0
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_JetsripperUpdateAnimation
; ---------------------------------------------------------------------------
word_32604:     dc.w    8, 8, 8, $C, 8, 8, $40, 4
                                        ; DATA XREF: Boss_JetsripperSpawnInit+1C   o
                                        ; Boss_JetsripperUpdateAnimation+10   o
                dc.w    8, 8, 8, $C, 8, 8, 8, 4
                dc.w    8, 8, 8, $C, 8, 8, $40, 4
                dc.w    $FFFF
off_32636:      dc.l    word_32646                      ; DATA XREF: Boss_JetsripperUpdateAnimation+20   r
                dc.l    word_3264E
                dc.l    word_32656
                dc.l    word_3265E
word_32646:     dc.w    $6206, $2000, 0, $5EFF
                                        ; DATA XREF: ROM:off_32636   o
word_3264E:     dc.w    $6206, $2000, 0, $5CFF
                                        ; DATA XREF: ROM:0003263A   o
word_32656:     dc.w    $6206, $2000, 0, $60FF
                                        ; DATA XREF: ROM:0003263E   o
word_3265E:     dc.w    $6206, $2000, 0, $64FF
                                        ; DATA XREF: ROM:00032642   o
word_32666:     dc.w    $6000, $2000, $202, $595A, $5B5D, $5E5F, $6162, $63FF
                                        ; DATA XREF: Boss_JetsripperSpawnInit+76   o

; Handles boss flying in until X position reaches threshold
Boss_JetsripperFlyIn:                                   ; DATA XREF: ROM:0003242E   o  ; was: sub_32676
                bsr.w   Boss_JetsripperSetScreenShake
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                cmpi.w  #$180,$10(a5)
                bhi.w   locret_30BB8
                clr.w   $18(a5)
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperFlyIn
; Flying enemy movement
Enemy_Stage14FlierMove:                                 ; DATA XREF: ROM:00032430   o  ; was: sub_326A0
                bsr.w   Boss_JetsripperSetScreenShake
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                tst.w   (word_FF80C2).w
                bne.w   locret_30BB8
                clr.b   (byte_FF80EC).w
                andi.b  #$EF,$23(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage14FlierMove
; Sets screen shake parameters with specific intensity and duration values
Boss_JetsripperSetScreenShake:                          ; CODE XREF: Boss_JetsripperFlyIn   p  ; was: sub_326C4
                                        ; sub_326A0   p
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w            ; ' '
                move.b  #8,(byte_FF8143).w
                rts
; End of function Boss_JetsripperSetScreenShake
; Turret fire state
Enemy_Stage14TurretFire:                                ; DATA XREF: ROM:00032432   o  ; was: sub_326D8
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                jsr     (RandomNumber).l
                andi.w  #3,d0
                beq.s   loc_326F8
                cmpi.w  #2,d0
                beq.s   loc_32700
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_326F8:                                              ; CODE XREF: Enemy_Stage14TurretFire+12   j
                move.w  #$10,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_32700:                                              ; CODE XREF: Enemy_Stage14TurretFire+18   j
                move.w  #$18,4(a5)
                rts
; End of function Enemy_Stage14TurretFire
; Spawns circular pattern of 12 projectiles around boss position
Boss_JetsripperSpawnCircleShots:                        ; DATA XREF: ROM:00032434   o  ; was: sub_32708
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                lea     (word_FFCD40).w,a4
                lea     (Entity_ObjectPool).w,a0
                bsr.w   Boss_JetsripperRandomizePattern
                move.w  #$B,d6
loc_32720:                                              ; CODE XREF: Boss_JetsripperSpawnCircleShots+5C   j
                adda.w  #$60,a4                         ; '`'
                bsr.w   Enemy_Stage14FlierMain
                move.b  #$54,$20(a4)                    ; 'T'
                move.w  #8,$48(a4)
                move.w  #$500,8(a4)
                move.w  #$F8F8,$A(a4)
                move.w  #$6334,$E(a4)
                move.w  #$40,$4A(a4)                    ; '@'
                move.w  #1,$4C(a4)
                move.w  d5,$40(a4)
                add.w   (dword_FF9408+2).w,d5
                clr.w   $42(a4)
                move.w  a0,$44(a4)
                movea.w a4,a0
                dbf     d6,loc_32720
                move.w  #$CC00,2(a4)
                move.l  #word_EBE94,8(a4)
                move.w  #$2300,$E(a4)
                tst.w   (dword_FF9408).w
                bpl.s   loc_32788
                ori.w   #$1000,$E(a4)
loc_32788:                                              ; CODE XREF: Boss_JetsripperSpawnCircleShots+78   j
                move.w  #3,(word_FFCDEC).w
                move.b  #$4B,d0                         ; 'K'
                jsr     (Sound_PlaySFX).l
                move.w  #$40,$4A(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperSpawnCircleShots
; Randomizes projectile spawn pattern based on boss X position
Boss_JetsripperRandomizePattern:                        ; CODE XREF: Boss_JetsripperSpawnCircleShots+10   p  ; was: sub_327A4
                jsr     (RandomNumber).l
                cmpi.w  #$120,$10(a5)
                bcc.s   loc_327F4
                andi.w  #1,d0
                bne.s   loc_327D6
                move.w  #$1FC,d5
                move.w  #$1FC,(dword_FF9404+2).w
                move.w  #$FFFE,(dword_FF9408+2).w
                move.w  #2,(dword_FF9408).w
                move.w  #$180,(dword_FF940C).w
                rts
; ---------------------------------------------------------------------------
loc_327D6:                                              ; CODE XREF: Boss_JetsripperRandomizePattern+12   j
                move.w  #4,d5
                move.w  #4,(dword_FF9404+2).w
                move.w  #2,(dword_FF9408+2).w
                move.w  #$FFFE,(dword_FF9408).w
                move.w  #$180,(dword_FF940C).w
                rts
; ---------------------------------------------------------------------------
loc_327F4:                                              ; CODE XREF: Boss_JetsripperRandomizePattern+C   j
                andi.w  #1,d0
                bne.s   loc_32818
                move.w  #$104,d5
                move.w  #$104,(dword_FF9404+2).w
                move.w  #2,(dword_FF9408+2).w
                move.w  #2,(dword_FF9408).w
                move.w  #$C0,(dword_FF940C).w
                rts
; ---------------------------------------------------------------------------
loc_32818:                                              ; CODE XREF: Boss_JetsripperRandomizePattern+54   j
                move.w  #$FC,d5
                move.w  #$FC,(dword_FF9404+2).w
                move.w  #$FFFE,(dword_FF9408+2).w
                move.w  #$FFFE,(dword_FF9408).w
                move.w  #$C0,(dword_FF940C).w
                rts
; End of function Boss_JetsripperRandomizePattern
; Reverses direction of circular projectile pattern with sound effect
Boss_JetsripperReverseCircle:                           ; DATA XREF: ROM:00032436   o  ; was: sub_32836
                move.w  #$E0,(word_FF8140).w
                move.b  #$80,(byte_FF8142).w
                move.b  #8,(byte_FF8143).w
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #3,(word_FFA010).w
                move.b  #$53,d0                         ; 'S'
                jsr     (Sound_PlaySFX).l
                lea     (word_FFCDA0).w,a4
                move.w  #$B,d6
loc_32870:                                              ; CODE XREF: Boss_JetsripperReverseCircle+5E   j
                move.w  #$40,$42(a4)                    ; '@'
                movea.w a4,a3
                adda.w  #$60,a3                         ; '`'
                move.w  a3,$44(a4)
                move.w  $40(a3),d0
                eori.w  #$100,d0
                move.w  d0,$40(a4)
                addq.w  #2,4(a4)
                adda.w  #$60,a4                         ; '`'
                dbf     d6,loc_32870
                move.l  #word_EBEA0,(dword_FFD1C8).w
                move.w  (dword_FF9404+2).w,d0
                eori.w  #$100,d0
                move.w  d0,$40(a5)
                move.w  #$C0,$42(a5)
                lea     (word_FFCDA0).w,a4
                move.w  a4,$44(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperReverseCircle
; Retracts circular projectile pattern inward toward center position
Boss_JetsripperRetractCircle:                           ; DATA XREF: ROM:00032438   o  ; was: sub_328C0
                move.w  #$E0,(word_FF8140).w
                move.b  #$80,(byte_FF8142).w
                move.b  #8,(byte_FF8143).w
                bsr.w   Enemy_GustheadUpdatePosition
                move.w  #$100,$14(a5)
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                subq.w  #3,$42(a5)
                cmpi.w  #$120,(dword_FF940C).w
                bcc.s   loc_32902
                cmpi.w  #$C0,$10(a5)
                bhi.w   locret_30BB8
                move.w  #$C0,$10(a5)
                bra.s   loc_32912
; ---------------------------------------------------------------------------
loc_32902:                                              ; CODE XREF: Boss_JetsripperRetractCircle+2E   j
                cmpi.w  #$180,$10(a5)
                bcs.w   locret_30BB8
                move.w  #$180,$10(a5)
loc_32912:                                              ; CODE XREF: Boss_JetsripperRetractCircle+40   j
                lea     (word_FFD1C0).w,a4
                move.w  #$A,d6
loc_3291A:                                              ; CODE XREF: Boss_JetsripperRetractCircle+84   j
                movea.w a4,a3
                suba.w  #$60,a3                         ; '`'
                move.w  a3,$44(a4)
                move.w  $40(a3),d0
                eori.w  #$100,d0
                move.w  d0,$40(a4)
                move.w  $42(a3),$42(a4)
                move.w  #$10,$4A(a4)
                addq.w  #2,4(a4)
                suba.w  #$60,a4                         ; '`'
                dbf     d6,loc_3291A
                lea     (Entity_ObjectPool).w,a3
                move.w  a3,$44(a4)
                move.w  (dword_FF9404+2).w,$40(a4)
                move.w  $42(a3),$42(a4)
                move.w  #$10,$4A(a4)
                addq.w  #2,4(a4)
                move.l  #word_EBE94,(dword_FFD1C8).w
                move.w  #$20,$4A(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperRetractCircle
; Gradually stabilizes boss Y velocity to 0x100 value
Boss_JetsripperStabilizeVelocity:                       ; DATA XREF: ROM:0003243A   o  ; was: sub_3297A
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                cmpi.w  #$100,$14(a5)
                beq.s   loc_32996
                bcs.s   loc_32992
                subq.w  #1,$14(a5)
                bra.s   loc_32996
; ---------------------------------------------------------------------------
loc_32992:                                              ; CODE XREF: Boss_JetsripperStabilizeVelocity+10   j
                addq.w  #1,$14(a5)
loc_32996:                                              ; CODE XREF: Boss_JetsripperStabilizeVelocity+E   j
                                        ; Boss_JetsripperStabilizeVelocity+16   j
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #6,4(a5)
                rts
; End of function Boss_JetsripperStabilizeVelocity
; Resets state of 8 boss components and initializes rotation parameters
Boss_JetsripperResetComponents:                         ; DATA XREF: ROM:0003243C   o  ; was: sub_329A6
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                lea     (word_FFC7A0).w,a4
                move.w  #7,d6
loc_329B6:                                              ; CODE XREF: Boss_JetsripperResetComponents+1A   j
                move.w  #4,4(a4)
                adda.w  #$60,a4                         ; '`'
                dbf     d6,loc_329B6
                lea     (word_FFCDA0).w,a4
                move.w  a4,(dword_FF9414).w
                move.l  #$80000,(dword_FF940C+2).w
                move.w  #4,(dword_FF9410+2).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperResetComponents
; Decrements rotation windup counter until ready for next phase
Boss_JetsripperWindupRotation:                          ; DATA XREF: ROM:0003243E   o  ; was: sub_329E0
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                subi.l  #$10000,(dword_FF940C+2).w
                cmpi.l  #$FFF00000,(dword_FF940C+2).w
                bne.w   locret_30BB8
                bsr.w   Boss_JetsripperSpawnFlier
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperWindupRotation
; Initializes phase 4 of Jetsripper boss, spawning fliers and managing counter progression
Boss_JetsripperPhase4Init:                              ; DATA XREF: ROM:00032440   o  ; was: sub_32A06
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                addi.l  #$10000,(dword_FF940C+2).w
                cmpi.l  #$80000,(dword_FF940C+2).w
                beq.s   loc_32A36
                cmpi.l  #$100000,(dword_FF940C+2).w
                bne.w   locret_30BB8
                bsr.w   Boss_JetsripperSpawnFlier
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_32A36:                                              ; CODE XREF: Boss_JetsripperPhase4Init+18   j
                subq.w  #1,(dword_FF9410+2).w
                bne.w   locret_30BB8
                lea     (word_FFC7A0).w,a4
                move.w  #7,d6
loc_32A46:                                              ; CODE XREF: Boss_JetsripperPhase4Init+4A   j
                move.w  #0,4(a4)
                adda.w  #$60,a4                         ; '`'
                dbf     d6,loc_32A46
                move.w  #$60,$4A(a5)                    ; '`'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperPhase4Init
; Spawns a stage 14 flier enemy with sound effect and position offset based on boss position
Boss_JetsripperSpawnFlier:                              ; CODE XREF: Boss_JetsripperWindupRotation+1C   p  ; was: sub_32A60
                                        ; Boss_JetsripperPhase4Init+26   p
                move.b  #$CC,d0
                jsr     (Sound_PlaySFX).l
                movea.w (dword_FF9414).w,a4
                addi.w  #$60,(dword_FF9414).w           ; '`'
                bsr.w   Enemy_Stage14FlierMain
                move.w  #$A,$48(a4)
                move.w  #$500,8(a4)
                move.w  #$F8F8,$A(a4)
                move.w  #$6334,$E(a4)
                move.w  $10(a5),$10(a4)
                move.w  $14(a5),$14(a4)
                bsr.w   Boss_JetsripperSetFlierDirection
                cmpi.w  #$12,4(a5)
                beq.s   loc_32ABA
                cmpi.w  #$120,$10(a5)
                bcs.w   loc_32AC4
loc_32AB2:                                              ; CODE XREF: Boss_JetsripperSpawnFlier+60   j
                addi.w  #$28,$14(a4)                    ; '('
                rts
; ---------------------------------------------------------------------------
loc_32ABA:                                              ; CODE XREF: Boss_JetsripperSpawnFlier+46   j
                cmpi.w  #$120,$10(a5)
                bcs.w   loc_32AB2
loc_32AC4:                                              ; CODE XREF: Boss_JetsripperSpawnFlier+4E   j
                subi.w  #$28,$14(a4)                    ; '('
                rts
; End of function Boss_JetsripperSpawnFlier
; Sets horizontal velocity for spawned flier based on boss X position
Boss_JetsripperSetFlierDirection:                       ; CODE XREF: Boss_JetsripperSpawnFlier+3C   p  ; was: sub_32ACC
                cmpi.w  #$120,$10(a5)
                bcs.w   loc_32ADE
                move.w  #$FFFD,$18(a4)
                rts
; ---------------------------------------------------------------------------
loc_32ADE:                                              ; CODE XREF: Boss_JetsripperSetFlierDirection+6   j
                move.w  #3,$18(a4)
                rts
; End of function Boss_JetsripperSetFlierDirection
; Waits for timer countdown and transitions to next phase
Boss_JetsripperPhase5Wait:                              ; DATA XREF: ROM:00032442   o  ; was: sub_32AE6
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #6,4(a5)
                rts
; End of function Boss_JetsripperPhase5Wait
; Bullet projectile handler
Projectile_Stage14BulletMain:                           ; DATA XREF: ROM:00032444   o  ; was: sub_32AFE
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                move.w  #$200,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Projectile_Stage14BulletMain
; Initializes bullet
Projectile_Stage14BulletInit:                           ; DATA XREF: ROM:00032446   o  ; was: sub_32B12
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                bsr.w   Projectile_Stage14BulletMove
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$40,$4A(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Projectile_Stage14BulletInit
; Bullet movement
Projectile_Stage14BulletMove:                           ; CODE XREF: Projectile_Stage14BulletInit+8   p  ; was: sub_32B32
                move.w  $4A(a5),d0
                andi.w  #$7F,d0
                bne.w   locret_30BB8
                lea     word_32BCE(pc),a1
                nop
                lea     word_32BD8(pc),a2
                nop
                move.w  $4A(a5),d0
                andi.w  #$80,d0
                bne.s   loc_32B72
                clr.w   d6
loc_32B56:                                              ; CODE XREF: Projectile_Stage14BulletMove+3C   j
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                bsr.w   loc_31B02
                bsr.w   Enemy_Stage14SpawnSplitBullet
                addq.w  #2,d6
                cmpi.w  #6,d6
                bne.s   loc_32B56
                rts
; ---------------------------------------------------------------------------
loc_32B72:                                              ; CODE XREF: Projectile_Stage14BulletMove+20   j
                move.w  #4,d6
loc_32B76:                                              ; CODE XREF: Projectile_Stage14BulletMove+5C   j
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                bsr.w   loc_31B02
                bsr.w   Enemy_Stage14SpawnSplitBullet
                addq.w  #2,d6
                cmpi.w  #$A,d6
                bne.s   loc_32B76
                rts
; End of function Projectile_Stage14BulletMove
; Spawns split bullet from dying enemy
Enemy_Stage14SpawnSplitBullet:                          ; CODE XREF: Projectile_Stage14BulletMove+32   p  ; was: sub_32B92
                                        ; Projectile_Stage14BulletMove+52   p
                move.w  #$3B8,(a0)
                move.w  $14(a5),d0
                add.w   word_32BD8(pc,d6.w),d0
                move.w  d0,$14(a0)
                move.w  $10(a5),d0
                cmpi.w  #$120,$10(a5)
                bcs.s   loc_32BBE
                sub.w   word_32BCE(pc,d6.w),d0
                move.w  d0,$10(a0)
                move.w  #$FFFE,$18(a0)
                rts
; ---------------------------------------------------------------------------
loc_32BBE:                                              ; CODE XREF: Enemy_Stage14SpawnSplitBullet+1A   j
                add.w   word_32BCE(pc,d6.w),d0
                move.w  d0,$10(a0)
                move.w  #2,$18(a0)
                rts
; End of function Enemy_Stage14SpawnSplitBullet
; ---------------------------------------------------------------------------
word_32BCE:     dc.w    0, $22, $30, $22, 0
                                        ; DATA XREF: Projectile_Stage14BulletMove+C   o
                                        ; Enemy_Stage14SpawnSplitBullet+1C   r
word_32BD8:     dc.w    $FFD0, $FFDE, 0, $22, $30
                                        ; DATA XREF: Projectile_Stage14BulletMove+12   o
                                        ; Enemy_Stage14SpawnSplitBullet+8   r

; Waits for timer countdown and transitions to next phase
Boss_JetsripperPhase7Wait:                              ; DATA XREF: ROM:00032448   o  ; was: sub_32BE2
                bsr.w   Enemy_Stage14FlierInit
                bsr.w   Boss_JetsripperUpdateAnimation
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #6,4(a5)
                rts
; End of function Boss_JetsripperPhase7Wait
; Clears visibility flag and initializes timer for next phase
Boss_JetsripperPhase8Init:                              ; DATA XREF: ROM:0003244A   o  ; was: sub_32BFA
                clr.b   $21(a5)
                move.w  #$100,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperPhase8Init
; Spawns explosion debris during boss death sequence and loads new graphics
Boss_JetsripperDeathExplosion:                          ; DATA XREF: ROM:0003244C   o  ; was: sub_32C0A
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w            ; ' '
                move.b  #8,(byte_FF8143).w
                jsr     (Boss_SpawnExplosionDebris).l
                cmpi.w  #$88,(a0)
                bne.s   loc_32C2E
                ori.w   #$8000,$E(a0)
loc_32C2E:                                              ; CODE XREF: Boss_JetsripperDeathExplosion+1C   j
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w            ; ' '
                move.b  #8,(byte_FF8143).w
                movea.l #word_32C5C,a0
                jsr     (Gfx_LoadCompressedTiles).l
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperDeathExplosion
; ---------------------------------------------------------------------------
word_32C5C:     dc.w    $6000, $2000, $202, 0, 0, 0, 0, $FF
                                        ; DATA XREF: Boss_JetsripperDeathExplosion+3E   o

; Flying enemy attack
Enemy_Stage14FlierAttack:                               ; DATA XREF: ROM:000323F0   o  ; was: sub_32C6C
                bsr.w   Enemy_DeathExplode
                movea.w a5,a4
                lea     (Entity_ObjectPool).w,a5
                jsr     (Math_CalculateAngleToPlayer).l
                movea.w a4,a5
                move.w  d2,$40(a5)
                bra.w   Enemy_GustheadUpdatePosition
; End of function Enemy_Stage14FlierAttack
; Handles boss death animation with rotation and position updates
Boss_JetsripperDeathRotate:                             ; DATA XREF: ROM:000323F2   o  ; was: sub_32C86
                bsr.w   Enemy_DeathExplode
                bsr.w   Boss_JetsripperTrackPlayer
                andi.w  #$1FE,$40(a5)
                bra.w   Enemy_GustheadUpdatePosition
; End of function Boss_JetsripperDeathRotate
; Adjusts boss rotation angle to track player position with smooth turning
Boss_JetsripperTrackPlayer:                             ; CODE XREF: Boss_JetsripperDeathRotate+4   p  ; was: sub_32C98
                movea.w a5,a4
                lea     (Entity_ObjectPool).w,a5
                jsr     (Math_CalculateAngleToPlayer).l
                movea.w a4,a5
                move.w  $40(a5),d0
                sub.w   d0,d2
                andi.w  #$1FE,d2
                cmpi.w  #8,d2
                bcs.w   locret_30BB8
                cmpi.w  #$1F8,d2
                bcc.w   locret_30BB8
                cmpi.w  #$100,d2
                bcc.s   loc_32CCC
                addq.w  #2,$40(a5)
                rts
; ---------------------------------------------------------------------------
loc_32CCC:                                              ; CODE XREF: Boss_JetsripperTrackPlayer+2C   j
                subq.w  #2,$40(a5)
                rts
; End of function Boss_JetsripperTrackPlayer
; Checks if flier in bounds
Enemy_Stage14FlierCheckBounds:                          ; DATA XREF: ROM:000323F4   o  ; was: sub_32CD2
                bsr.w   Enemy_DeathExplode
                bsr.w   Enemy_Stage14FlierOutOfBounds
                andi.w  #$1FE,$40(a5)
                bra.w   Enemy_GustheadUpdatePosition
; End of function Enemy_Stage14FlierCheckBounds
; Handles flier out of bounds
Enemy_Stage14FlierOutOfBounds:                          ; CODE XREF: Enemy_Stage14FlierCheckBounds+4   p  ; was: sub_32CE4
                move.w  4(a5),d0
                lea     off_32CF0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage14FlierOutOfBounds
; ---------------------------------------------------------------------------
off_32CF0:      dc.w    Enemy_Stage14FlierDespawn-*     ; DATA XREF: Enemy_Stage14FlierOutOfBounds+4   o
                dc.w    Enemy_Stage14FlierSpawnBullet-*
                dc.w    Enemy_FlierRotateIncrement-*

; Despawns flying enemy
Enemy_Stage14FlierDespawn:                              ; DATA XREF: ROM:off_32CF0   o  ; was: sub_32CF6
                move.w  (dword_FF940C+2).w,d0
                add.w   d0,$40(a5)
                subq.w  #1,$42(a5)
                cmpi.w  #$80,$42(a5)
                bne.w   locret_30BB8
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage14FlierDespawn
; Spawns bullet from flier
Enemy_Stage14FlierSpawnBullet:                          ; DATA XREF: ROM:00032CF2   o  ; was: sub_32D12
                move.w  (dword_FF940C+2).w,d0
                add.w   d0,$40(a5)
                addq.w  #1,$42(a5)
                cmpi.w  #$A8,$42(a5)
                bne.w   locret_30BB8
                subq.w  #2,4(a5)
                rts
; End of function Enemy_Stage14FlierSpawnBullet
; Rotates enemy and increments counter until reaching maximum value
Enemy_FlierRotateIncrement:                             ; DATA XREF: ROM:00032CF4   o  ; was: sub_32D2E
                move.w  (dword_FF940C+2).w,d0
                add.w   d0,$40(a5)
                cmpi.w  #$A8,$42(a5)
                beq.w   locret_30BB8
                addq.w  #1,$42(a5)
                rts
; End of function Enemy_FlierRotateIncrement
; Dispatches to death behavior states with continuous explosion effects
Enemy_FlierDeathDispatcher:                             ; DATA XREF: ROM:000323F6   o  ; was: sub_32D46
                bsr.w   Enemy_DeathExplode
                move.w  4(a5),d0
                lea     off_32D56(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlierDeathDispatcher
; ---------------------------------------------------------------------------
off_32D56:      dc.w    Enemy_FlierDeathRotate-*        ; DATA XREF: Enemy_FlierDeathDispatcher+8   o
                dc.w    Enemy_FlierDeathSlowdown-*
                dc.w    Enemy_FlierDeathFinalize-*

; Updates rotation angle during death sequence
Enemy_FlierDeathRotate:                                 ; DATA XREF: ROM:off_32D56   o  ; was: sub_32D5C
                move.w  $4C(a5),d0
                add.w   d0,$42(a5)
                bra.w   Enemy_GustheadUpdatePosition
; End of function Enemy_FlierDeathRotate
; Decrements rotation speed and clamps angle during death sequence
Enemy_FlierDeathSlowdown:                               ; DATA XREF: ROM:00032D58   o  ; was: sub_32D68
                cmpa.l  #$FFFFD1C0,a5
                beq.w   locret_30BB8
                andi.w  #$1FE,$40(a5)
                subq.w  #1,$42(a5)
                bra.w   Enemy_GustheadUpdatePosition
; End of function Enemy_FlierDeathSlowdown
; Decrements rotation and marks for destruction when timer expires
Enemy_FlierDeathFinalize:                               ; DATA XREF: ROM:00032D5A   o  ; was: sub_32D80
                move.w  $4C(a5),d0
                sub.w   d0,$42(a5)
                bsr.w   Enemy_GustheadUpdatePosition
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_FlierDeathFinalize
; Checks if enemy hit boss part or is out of bounds, marks for destruction
Enemy_FlierBoundsCheck:                                 ; DATA XREF: ROM:000323F8   o  ; was: sub_32D9C
                bclr    #7,$22(a5)
                beq.s   loc_32DAE
                bclr    #4,$22(a5)
                beq.w   loc_3239E
loc_32DAE:                                              ; CODE XREF: Enemy_FlierBoundsCheck+6   j
                bsr.w   Enemy_DeathExplode
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   loc_32DC4
                cmpi.w  #$1E0,$10(a5)
                bcc.s   loc_32DC4
                rts
; ---------------------------------------------------------------------------
loc_32DC4:                                              ; CODE XREF: Enemy_FlierBoundsCheck+1C   j
                                        ; Enemy_FlierBoundsCheck+24   j
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_FlierBoundsCheck
; Enemy death with explosion effect
Enemy_DeathExplode:                                     ; CODE XREF: Projectile_DestroyerProtoMain   p  ; was: sub_32DCC
                                        ; sub_32382   p
                tst.w   (dword_FF9414+2).w
                beq.w   locret_30BB8
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_32DF6
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E9560,8(a0)
                jsr     (Sprite_InitType160).l
loc_32DF6:                                              ; CODE XREF: Enemy_DeathExplode+E   j
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_DeathExplode
; Idle state handler
