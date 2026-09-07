Enemy_FlyerMain:                                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E9FC
                move.w  4(a5),d0
                lea     off_2EA08(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyerMain
; ---------------------------------------------------------------------------
off_2EA08:      dc.w    Enemy_FlyerDispatcher-*         ; DATA XREF: Enemy_FlyerMain+4   o
                dc.w    Enemy_FlyerSpawnInit-*
                dc.w    Enemy_FlyerState1-*

; Flying enemy dispatcher
Enemy_FlyerDispatcher:                                  ; DATA XREF: ROM:off_2EA08   o  ; was: sub_2EA0E
                clr.w   (dword_FF9400).w
                clr.w   (dword_FF9400+2).w
                move.w  #$FFFF,(dword_FF9404).w
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerDispatcher
; Flying enemy spawn init
Enemy_FlyerSpawnInit:                                   ; DATA XREF: ROM:0002EA0A   o  ; was: sub_2EA28
                subq.w  #1,$48(a5)
                bne.s   locret_2EA50
                lea     (dword_FF9400).w,a4
                adda.w  $4C(a5),a4
                tst.w   (a4)
                bmi.s   loc_2EA52
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_2EA46
                move.w  a0,(a4)
                bsr.s   Enemy_FlyerMovement1
loc_2EA46:                                              ; CODE XREF: Enemy_FlyerSpawnInit+18   j
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,$4C(a5)
locret_2EA50:                                           ; CODE XREF: Enemy_FlyerSpawnInit+4   j
                rts
; ---------------------------------------------------------------------------
loc_2EA52:                                              ; CODE XREF: Enemy_FlyerSpawnInit+10   j
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerSpawnInit
; Flying enemy movement 1
Enemy_FlyerMovement1:                                   ; CODE XREF: Enemy_FlyerSpawnInit+1C   p  ; was: sub_2EA58
                                        ; Enemy_FlyerState1+20   p
                bsr.w   Enemy_FlyerMovement2
                move.w  a5,$4E(a0)
                move.w  $4A(a5),d0
                move.w  word_2EA8A(pc,d0.w),$10(a0)
                move.w  #$180,$14(a0)
                addq.w  #2,$4A(a5)
                andi.w  #7,$4A(a5)
                cmpi.w  #$120,$10(a0)
                bcs.s   locret_2EA88
                bset    #3,$E(a0)
locret_2EA88:                                           ; CODE XREF: Enemy_FlyerMovement1+28   j
                rts
; End of function Enemy_FlyerMovement1
; ---------------------------------------------------------------------------
word_2EA8A:     dc.w    $1A0, $A0, $1A0, $A0, $1A0, $A0, $1A0, $A0
                                        ; DATA XREF: Enemy_FlyerMovement1+C   r

; Flyer state handler 1
Enemy_FlyerState1:                                      ; DATA XREF: ROM:0002EA0C   o  ; was: sub_2EA9A
                lea     (dword_FF9400).w,a4
loc_2EA9E:                                              ; CODE XREF: Enemy_FlyerState1+12   j
                movea.w (a4),a0
                cmpi.w  #$44C,(a0)
                bne.s   loc_2EAB0
                addq.w  #2,a4
                cmpi.w  #$FFFF,(a4)
                bne.s   loc_2EA9E
locret_2EAAE:                                           ; CODE XREF: Enemy_FlyerState1+1C   j
                rts
; ---------------------------------------------------------------------------
loc_2EAB0:                                              ; CODE XREF: Enemy_FlyerState1+A   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2EAAE
                move.w  a0,(a4)
                bsr.s   Enemy_FlyerMovement1
                rts
; End of function Enemy_FlyerState1
; Flying enemy movement 2
Enemy_FlyerMovement2:                                   ; CODE XREF: Enemy_FlyerMovement1   p  ; was: sub_2EABE
                move.w  #$44C,(a0)
                move.w  #$400,$E(a0)
                move.l  #word_EB408,8(a0)
                move.w  #$CC00,2(a0)
                move.b  #$C0,$21(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #4,$24(a0)
                move.w  #$14,$26(a0)
                move.b  #$60,$20(a0)                    ; '`'
                rts
; End of function Enemy_FlyerMovement2
; Flying enemy attack
Enemy_FlyerAttack:                                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2EB00
                tst.w   4(a5)
                beq.s   loc_2EB68
                tst.w   $24(a5)
                bmi.w   Enemy_FlyerExplode
                tst.w   (word_FF808C).w
                bpl.w   Enemy_FlyerExplode
                cmpi.w  #$1C,4(a5)
                bcc.s   loc_2EB2E
                movea.w $4E(a5),a0
                cmpi.w  #$454,(a0)
                beq.s   loc_2EB2E
                move.w  #$1C,4(a5)
loc_2EB2E:                                              ; CODE XREF: Enemy_FlyerAttack+1C   j
                                        ; Enemy_FlyerAttack+26   j
                jsr     (RandomNumber).l
                movea.w $5C(a5),a0
                move.w  $14(a5),$14(a0)
                addi.w  #$14,$14(a0)
                move.w  $10(a5),$10(a0)
                move.w  $48(a0),d0
                add.w   d0,$10(a0)
                btst    #3,$E(a5)
                bne.s   loc_2EB62
                addi.w  #$14,$10(a0)
                bra.s   loc_2EB68
; ---------------------------------------------------------------------------
loc_2EB62:                                              ; CODE XREF: Enemy_FlyerAttack+58   j
                addi.w  #-$14,$10(a0)
loc_2EB68:                                              ; CODE XREF: Enemy_FlyerAttack+4   j
                                        ; Enemy_FlyerAttack+60   j
                move.w  4(a5),d0
                lea     off_2EB74(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyerAttack
; ---------------------------------------------------------------------------
off_2EB74:      dc.w    Enemy_FlyerSpawnProjectile-*    ; DATA XREF: Enemy_FlyerAttack+6C   o
                dc.w    Enemy_FlyerCheckBounds1-*
                dc.w    Enemy_FlyerCheckBounds2-*
                dc.w    Enemy_FlyerAccelerate-*
                dc.w    Enemy_FlyerTrackPlayer-*
                dc.w    Enemy_FlyerState2-*
                dc.w    Enemy_FlyerState3-*
                dc.w    Enemy_FlyerState4-*
                dc.w    Enemy_FlyerState6-*
                dc.w    Enemy_FlyerState7-*
                dc.w    Enemy_FlyerState8-*
                dc.w    Projectile_FlyerBullet1-*
                dc.w    Projectile_FlyerBullet2-*
                dc.w    Projectile_FlyerBullet3-*
                dc.w    Enemy_FlyerDestroy-*
                dc.w    Enemy_FlyerDecelerate-*

; Spawns flyer projectile
Enemy_FlyerSpawnProjectile:                             ; DATA XREF: ROM:off_2EB74   o  ; was: sub_2EB94
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2EBD0
                move.w  #$10,(a0)
                move.w  #$CC00,2(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  #word_EB486,8(a0)
                move.w  $E(a5),$E(a0)
                clr.w   $C(a0)
                move.w  a0,$5C(a5)
                move.w  #$FFFC,$1C(a5)
                addq.w  #2,4(a5)
locret_2EBD0:                                           ; CODE XREF: Enemy_FlyerSpawnProjectile+6   j
                rts
; End of function Enemy_FlyerSpawnProjectile
; Boundary check 1
Enemy_FlyerCheckBounds1:                                ; DATA XREF: ROM:0002EB76   o  ; was: sub_2EBD2
                cmpi.w  #$160,$14(a5)
                bgt.s   locret_2EBDE
                addq.w  #2,4(a5)
locret_2EBDE:                                           ; CODE XREF: Enemy_FlyerCheckBounds1+6   j
                rts
; End of function Enemy_FlyerCheckBounds1
; Boundary check 2
Enemy_FlyerCheckBounds2:                                ; DATA XREF: ROM:0002EB78   o  ; was: sub_2EBE0
                move.w  (word_FF824A).w,d0
                addi.w  #$40,d0                         ; '@'
                cmp.w   $14(a5),d0
                blt.s   locret_2EBF2
                addq.w  #2,4(a5)
locret_2EBF2:                                           ; CODE XREF: Enemy_FlyerCheckBounds2+C   j
                rts
; End of function Enemy_FlyerCheckBounds2
; Acceleration handler
Enemy_FlyerAccelerate:                                  ; DATA XREF: ROM:0002EB7A   o  ; was: sub_2EBF4
                addi.l  #$4000,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_2EC12
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
locret_2EC12:                                           ; CODE XREF: Enemy_FlyerAccelerate+E   j
                rts
; End of function Enemy_FlyerAccelerate
; Track player movement
Enemy_FlyerTrackPlayer:                                 ; DATA XREF: ROM:0002EB7C   o  ; was: sub_2EC14
                move.w  (word_FF824A).w,d0
                bsr.w   Enemy_FlyerAdjustVelocity
                subq.w  #1,$48(a5)
                bne.s   locret_2EC32
                addq.w  #2,4(a5)
                move.w  (word_FF824A).w,$4C(a5)
                move.w  #$10,$48(a5)
locret_2EC32:                                           ; CODE XREF: Enemy_FlyerTrackPlayer+C   j
                rts
; End of function Enemy_FlyerTrackPlayer
; Flyer state handler 2
Enemy_FlyerState2:                                      ; DATA XREF: ROM:0002EB7E   o  ; was: sub_2EC34
                move.w  $4C(a5),d0
                bsr.w   Enemy_FlyerAdjustVelocity
                subq.w  #1,$48(a5)
                bne.s   locret_2EC82
                btst    #0,(dword_FFFF08+1).w
                bne.s   loc_2EC7C
                btst    #1,(dword_FFFF08+1).w
                bne.s   loc_2EC7C
                move.w  #$10,4(a5)
                move.l  #word_EB432,8(a5)
                clr.w   $C(a5)
                btst    #3,$E(a5)
                beq.s   loc_2EC74
                move.w  #4,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2EC74:                                              ; CODE XREF: Enemy_FlyerState2+36   j
                move.w  #$FFFC,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2EC7C:                                              ; CODE XREF: Enemy_FlyerState2+14   j
                                        ; Enemy_FlyerState2+1C   j
                move.w  #$C,4(a5)
locret_2EC82:                                           ; CODE XREF: Enemy_FlyerState2+C   j
                rts
; End of function Enemy_FlyerState2
; Flyer state handler 3
Enemy_FlyerState3:                                      ; DATA XREF: ROM:0002EB80   o  ; was: sub_2EC84
                move.w  $4C(a5),d0
                bsr.w   Enemy_FlyerAdjustVelocity
                move.w  #8,$48(a5)
                move.w  #$10,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerState3
; Flyer state handler 4
Enemy_FlyerState4:                                      ; DATA XREF: ROM:0002EB82   o  ; was: sub_2EC9E
                move.w  $4C(a5),d0
                bsr.w   Enemy_FlyerAdjustVelocity
                move.w  $48(a5),d0
                movea.w $5C(a5),a0
                bsr.w   Enemy_FlyerState5
                subq.w  #1,$48(a5)
                bne.s   locret_2ED20
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_2ED14
                movem.w a5,-(sp)
                movea.w $5C(a5),a5
                btst    #3,$E(a5)
                beq.s   loc_2ECDA
                move.w  #$100,d6
                move.w  #$FFE8,d0
                bra.s   loc_2ECE0
; ---------------------------------------------------------------------------
loc_2ECDA:                                              ; CODE XREF: Enemy_FlyerState4+30   j
                moveq   #0,d6
                move.w  #$18,d0
loc_2ECE0:                                              ; CODE XREF: Enemy_FlyerState4+3A   j
                moveq   #0,d1
                move.w  #$8004,d2
                jsr     (Enemy_InitHomingProjectile).l
                movem.w (sp)+,a5
                btst    #3,$E(a5)
                beq.s   loc_2ED00
                move.w  #$FFFA,$50(a0)
                bra.s   loc_2ED06
; ---------------------------------------------------------------------------
loc_2ED00:                                              ; CODE XREF: Enemy_FlyerState4+58   j
                move.w  #6,$50(a0)
loc_2ED06:                                              ; CODE XREF: Enemy_FlyerState4+60   j
                subq.w  #1,$4A(a5)
                beq.s   loc_2ED14
                move.w  #8,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_2ED14:                                              ; CODE XREF: Enemy_FlyerState4+20   j
                                        ; Enemy_FlyerState4+6C   j
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #8,4(a5)
locret_2ED20:                                           ; CODE XREF: Enemy_FlyerState4+18   j
                rts
; End of function Enemy_FlyerState4
; Flyer state handler 5
Enemy_FlyerState5:                                      ; CODE XREF: Enemy_FlyerState4+10   p  ; was: sub_2ED22
                btst    #3,$E(a5)
                beq.s   loc_2ED32
                lea     word_2ED52(pc),a1
                nop
                bra.s   loc_2ED38
; ---------------------------------------------------------------------------
loc_2ED32:                                              ; CODE XREF: Enemy_FlyerState5+6   j
                lea     word_2ED42(pc),a1
                nop
loc_2ED38:                                              ; CODE XREF: Enemy_FlyerState5+E   j
                add.w   d0,d0
                move.w  (a1,d0.w),$48(a0)
                rts
; End of function Enemy_FlyerState5
; ---------------------------------------------------------------------------
word_2ED42:     dc.w    0, $FFFF, $FFFE, $FFFD, $FFFC, $FFFD, $FFFE, $FFFF
                                        ; DATA XREF: Enemy_FlyerState5:loc_2ED32   o
word_2ED52:     dc.w    0, 1, 2, 3, 4, 3, 2, 1
                                        ; DATA XREF: Enemy_FlyerState5+8   o

; Flyer state handler 6
Enemy_FlyerState6:                                      ; DATA XREF: ROM:0002EB84   o  ; was: sub_2ED62
                move.w  $4C(a5),d0
                bsr.w   Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2ED7C
                addi.l  #-$4000,$18(a5)
                bra.s   loc_2ED84
; ---------------------------------------------------------------------------
loc_2ED7C:                                              ; CODE XREF: Enemy_FlyerState6+E   j
                addi.l  #$4000,$18(a5)
loc_2ED84:                                              ; CODE XREF: Enemy_FlyerState6+18   j
                tst.l   $18(a5)
                bne.s   locret_2ED9A
                move.l  #word_EB45C,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
locret_2ED9A:                                           ; CODE XREF: Enemy_FlyerState6+26   j
                rts
; End of function Enemy_FlyerState6
; Flyer state handler 7
Enemy_FlyerState7:                                      ; DATA XREF: ROM:0002EB86   o  ; was: sub_2ED9C
                move.w  $4C(a5),d0
                bsr.w   Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2EDC0
                addi.l  #-$4000,$18(a5)
                cmpi.l  #$FFFA0000,$18(a5)
                bgt.s   locret_2EDD6
                bra.s   loc_2EDD2
; ---------------------------------------------------------------------------
loc_2EDC0:                                              ; CODE XREF: Enemy_FlyerState7+E   j
                addi.l  #$4000,$18(a5)
                cmpi.l  #$60000,$18(a5)
                blt.s   locret_2EDD6
loc_2EDD2:                                              ; CODE XREF: Enemy_FlyerState7+22   j
                addq.w  #2,4(a5)
locret_2EDD6:                                           ; CODE XREF: Enemy_FlyerState7+20   j
                                        ; Enemy_FlyerState7+34   j
                rts
; End of function Enemy_FlyerState7
; Flyer state handler 8
Enemy_FlyerState8:                                      ; DATA XREF: ROM:0002EB88   o  ; was: sub_2EDD8
                move.w  $4C(a5),d0
                bsr.w   Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2EDF2
                cmpi.w  #$E0,$10(a5)
                bgt.s   locret_2EE0A
                bra.s   loc_2EDFA
; ---------------------------------------------------------------------------
loc_2EDF2:                                              ; CODE XREF: Enemy_FlyerState8+E   j
                cmpi.w  #$160,$10(a5)
                blt.s   locret_2EE0A
loc_2EDFA:                                              ; CODE XREF: Enemy_FlyerState8+18   j
                move.l  #word_EB408,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
locret_2EE0A:                                           ; CODE XREF: Enemy_FlyerState8+16   j
                                        ; Enemy_FlyerState8+20   j
                rts
; End of function Enemy_FlyerState8
; Flyer bullet projectile 1
Projectile_FlyerBullet1:                                ; DATA XREF: ROM:0002EB8A   o  ; was: sub_2EE0C
                move.w  $4C(a5),d0
                bsr.w   Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2EE28
                addi.l  #$4000,$18(a5)
                bne.s   locret_2EE42
                bra.s   loc_2EE32
; ---------------------------------------------------------------------------
loc_2EE28:                                              ; CODE XREF: Projectile_FlyerBullet1+E   j
                addi.l  #-$4000,$18(a5)
                bne.s   locret_2EE42
loc_2EE32:                                              ; CODE XREF: Projectile_FlyerBullet1+1A   j
                move.l  #word_EB432,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
locret_2EE42:                                           ; CODE XREF: Projectile_FlyerBullet1+18   j
                                        ; Projectile_FlyerBullet1+24   j
                rts
; End of function Projectile_FlyerBullet1
; Flyer bullet projectile 2
Projectile_FlyerBullet2:                                ; DATA XREF: ROM:0002EB8C   o  ; was: sub_2EE44
                move.w  $4C(a5),d0
                bsr.w   Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2EE68
                addi.l  #$4000,$18(a5)
                cmpi.l  #$60000,$18(a5)
                blt.s   locret_2EE7E
                bra.s   loc_2EE7A
; ---------------------------------------------------------------------------
loc_2EE68:                                              ; CODE XREF: Projectile_FlyerBullet2+E   j
                addi.l  #-$4000,$18(a5)
                cmpi.l  #$FFFA0000,$18(a5)
                bgt.s   locret_2EE7E
loc_2EE7A:                                              ; CODE XREF: Projectile_FlyerBullet2+22   j
                addq.w  #2,4(a5)
locret_2EE7E:                                           ; CODE XREF: Projectile_FlyerBullet2+20   j
                                        ; Projectile_FlyerBullet2+34   j
                rts
; End of function Projectile_FlyerBullet2
; Flyer bullet projectile 3
Projectile_FlyerBullet3:                                ; DATA XREF: ROM:0002EB8E   o  ; was: sub_2EE80
                move.w  $4C(a5),d0
                bsr.w   Enemy_FlyerAdjustVelocity
                btst    #3,$E(a5)
                beq.s   loc_2EE9A
                cmpi.w  #$1A0,$10(a5)
                blt.s   locret_2EEBE
                bra.s   loc_2EEA2
; ---------------------------------------------------------------------------
loc_2EE9A:                                              ; CODE XREF: Projectile_FlyerBullet3+E   j
                cmpi.w  #$A0,$10(a5)
                bgt.s   locret_2EEBE
loc_2EEA2:                                              ; CODE XREF: Projectile_FlyerBullet3+18   j
                clr.l   $18(a5)
                move.l  #word_EB408,8(a5)
                clr.w   $C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #8,4(a5)
locret_2EEBE:                                           ; CODE XREF: Projectile_FlyerBullet3+16   j
                                        ; Projectile_FlyerBullet3+20   j
                rts
; End of function Projectile_FlyerBullet3
; Destroy flyer enemy
Enemy_FlyerDestroy:                                     ; DATA XREF: ROM:0002EB90   o  ; was: sub_2EEC0
                ori.w   #$200,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerDestroy
; Deceleration handler
Enemy_FlyerDecelerate:                                  ; DATA XREF: ROM:0002EB92   o  ; was: sub_2EECC
                addi.l  #-$4000,$1C(a5)
                rts
; End of function Enemy_FlyerDecelerate
; Velocity adjustment
Enemy_FlyerAdjustVelocity:                              ; CODE XREF: Enemy_FlyerTrackPlayer+4   p  ; was: sub_2EED6
                                        ; Enemy_FlyerState2+4   p
                sub.w   $14(a5),d0
                beq.w   locret_2EF18
                tst.w   d0
                bpl.s   loc_2EEFE
                addi.l  #-$1000,$1C(a5)
                cmpi.l  #$FFFE0000,$1C(a5)
                bgt.s   locret_2EF18
                move.l  #$FFFE0000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2EEFE:                                              ; CODE XREF: Enemy_FlyerAdjustVelocity+A   j
                addi.l  #$1000,$1C(a5)
                cmpi.l  #$20000,$1C(a5)
                blt.s   locret_2EF18
                move.l  #$20000,$1C(a5)
locret_2EF18:                                           ; CODE XREF: Enemy_FlyerAdjustVelocity+4   j
                                        ; Enemy_FlyerAdjustVelocity+1C   j
                rts
; End of function Enemy_FlyerAdjustVelocity
; Explosion handler
Enemy_FlyerExplode:                                     ; CODE XREF: Enemy_FlyerAttack+A   j  ; was: sub_2EF1A
                                        ; Enemy_FlyerAttack+12   j
                jsr     (Projectile_ExplodeOnImpact).l
                move.w  #$1000,2(a5)
                movea.w $5C(a5),a0
                move.w  #$1000,2(a0)
                rts
; End of function Enemy_FlyerExplode
; Dispatches train end entity state using jump table
