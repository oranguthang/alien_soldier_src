Boss_ShieldViperDefeatInit:                             ; DATA XREF: ROM:0004E056   o  ; was: sub_4EC5E
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_4EC9E
                bsr.w   Boss_WolfGaropaMovement1
                move.w  #$37C,(a0)
                clr.w   4(a0)
                move.l  #stru_4F558,$4C(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  8(a5),8(a0)
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.w  $56(a5),$56(a0)
loc_4EC9E:                                              ; CODE XREF: Boss_ShieldViperDefeatInit+6   j
                clr.b   $21(a5)
                bclr    #7,2(a5)
                move.w  #2,d6
                move.w  #$17,d7
                lea     $60(a5),a1
loc_4ECB4:                                              ; CODE XREF: Boss_ShieldViperDefeatInit+96   j
                movea.w a1,a0
                tst.w   $5C(a1)
                beq.s   loc_4ECC6
                movea.w $5C(a1),a0
                move.w  #$1000,2(a1)
loc_4ECC6:                                              ; CODE XREF: Boss_ShieldViperDefeatInit+5C   j
                btst    #7,2(a0)
                beq.s   loc_4ECF0
                move.w  #$37C,(a0)
                clr.w   4(a0)
                move.w  d6,$48(a0)
                addq.w  #2,d6
                tst.b   $5E(a1)
                bne.s   loc_4ECEC
                move.l  #stru_4F598,$4C(a0)
                bra.s   loc_4ECF0
; ---------------------------------------------------------------------------
loc_4ECEC:                                              ; CODE XREF: Boss_ShieldViperDefeatInit+82   j
                clr.l   $4C(a0)
loc_4ECF0:                                              ; CODE XREF: Boss_ShieldViperDefeatInit+6E   j
                                        ; Boss_ShieldViperDefeatInit+8C   j
                lea     $60(a1),a1
                dbf     d7,loc_4ECB4
                move.w  d6,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperDefeatInit
; Projectile update 1
Projectile_ShieldViperUpdate1:                          ; DATA XREF: ROM:0004E058   o  ; was: sub_4ED02
                subq.w  #1,$48(a5)
                bne.s   locret_4ED12
                addi.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4ED12:                                           ; CODE XREF: Projectile_ShieldViperUpdate1+4   j
                rts
; End of function Projectile_ShieldViperUpdate1
; Projectile update 2
Projectile_ShieldViperUpdate2:                          ; DATA XREF: ROM:0004E05A   o  ; was: sub_4ED14
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$48(a5)
                bne.s   locret_4ED28
                clr.w   $48(a5)
                addq.w  #2,4(a5)
locret_4ED28:                                           ; CODE XREF: Projectile_ShieldViperUpdate2+A   j
                rts
; End of function Projectile_ShieldViperUpdate2
; Projectile explosion
Projectile_ShieldViperExplode:                          ; DATA XREF: ROM:0004E05C   o  ; was: sub_4ED2A
                move.w  $48(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                btst    #0,(word_FFA000+1).w
                bne.s   locret_4ED70
                btst    #1,(word_FFA000+1).w
                bne.s   locret_4ED70
                addq.w  #1,$48(a5)
                cmpi.w  #$E,$48(a5)
                bne.s   locret_4ED70
                move.w  #$1000,$9C2(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_4ED70:                                           ; CODE XREF: Projectile_ShieldViperExplode+20   j
                                        ; Projectile_ShieldViperExplode+28   j
                rts
; End of function Projectile_ShieldViperExplode
; Transition out of boss
Boss_ShieldViperTransitionOut:                          ; DATA XREF: ROM:0004E05E   o  ; was: sub_4ED72
                move.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                subq.w  #1,$48(a5)
                bne.s   locret_4ED94
                move.w  #$1000,2(a5)
locret_4ED94:                                           ; CODE XREF: Boss_ShieldViperTransitionOut+1A   j
                rts
; End of function Boss_ShieldViperTransitionOut
; Spawns projectile type 2
Boss_ShieldViperSpawnProjectile2:                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4ED96
                movea.w a5,a0
                bsr.w   Boss_ShieldViperCollision
                move.w  4(a5),d0
                lea     off_4EDA8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ShieldViperSpawnProjectile2
; ---------------------------------------------------------------------------
off_4EDA8:      dc.w    nullsub_115-*                   ; DATA XREF: Boss_ShieldViperSpawnProjectile2+A   o
                dc.w    Boss_ShieldViperChildCircularMotion-*
                dc.w    Boss_ShieldViperChildCircularMotion_UpdateLoop-*
                dc.w    Boss_ShieldViperChildBoundsCheck-*
                dc.w    nullsub_116-*
                dc.w    Boss_ShieldViperChildSpinAttack-*
                dc.w    Boss_ShieldViperChildSpinAttack_DecelerateLoop-*
                dc.w    Boss_ShieldViperChildReturnToParent-*

nullsub_115:                                            ; DATA XREF: ROM:off_4EDA8   o
                rts
; End of function nullsub_115

; Controls child entity circular motion
Boss_ShieldViperChildCircularMotion:                    ; DATA XREF: ROM:0004EDAA   o  ; was: sub_4EDBA
                movea.w $5C(a5),a0
                move.w  2(a5),2(a0)
                move.l  8(a5),8(a0)
                move.w  $E(a5),$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                andi.w  #$1FF,d0
                move.w  d0,$56(a0)
                clr.w   $50(a0)
                andi.w  #$7FFF,2(a5)
                move.b  $21(a5),$5A(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
; Update child position during circular motion
Boss_ShieldViperChildCircularMotion_UpdateLoop:         ; DATA XREF: ROM:0004EDAC   o  ; was: loc_4EDFE
                movea.w $5C(a5),a0
                lea     stru_4F598(pc),a1
                nop
                bsr.w   Boss_ShieldViperChildPositionUpdate
                subq.w  #1,$48(a5)
                bne.s   locret_4EE52
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                btst    #7,(dword_FF9400).w
                beq.s   loc_4EE28
                addi.w  #-$80,d0
                bra.s   loc_4EE2C
; ---------------------------------------------------------------------------
loc_4EE28:                                              ; CODE XREF: Boss_ShieldViperChildCircularMotion+66   j
                addi.w  #$80,d0
loc_4EE2C:                                              ; CODE XREF: Boss_ShieldViperChildCircularMotion+6C   j
                andi.w  #$1FE,d0
                lea     (Math_SineTable).l,a3
                move.w  Math_QuarterSineTable-Math_SineTable(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                muls.w  #$10,d0
                muls.w  #$10,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                addq.w  #2,4(a5)
locret_4EE52:                                           ; CODE XREF: Boss_ShieldViperChildCircularMotion+56   j
                rts
; End of function Boss_ShieldViperChildCircularMotion
; Checks child entity screen bounds
Boss_ShieldViperChildBoundsCheck:                       ; DATA XREF: ROM:0004EDAE   o  ; was: sub_4EE54
                movea.w $5C(a5),a0
                tst.b   $5E(a5)
                bne.s   loc_4EE62
                bsr.w   Projectile_ShieldViperUpdateRotation
loc_4EE62:                                              ; CODE XREF: Boss_ShieldViperChildBoundsCheck+8   j
                cmpi.w  #$60,$10(a0)                    ; '`'
                bcs.s   loc_4EE84
                cmpi.w  #$1E0,$10(a0)
                bhi.s   loc_4EE84
                cmpi.w  #$60,$14(a0)                    ; '`'
                bcs.s   loc_4EE84
                cmpi.w  #$1A0,$14(a0)
                bhi.s   loc_4EE84
                rts
; ---------------------------------------------------------------------------
loc_4EE84:                                              ; CODE XREF: Boss_ShieldViperChildBoundsCheck+14   j
                                        ; Boss_ShieldViperChildBoundsCheck+1C   j
                andi.w  #$7FFF,2(a0)
                move.w  #$1000,2(a0)
                clr.w   $5C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperChildBoundsCheck
nullsub_116:                                            ; DATA XREF: ROM:0004EDB0   o
                rts
; End of function nullsub_116

; Spawns spinning child entity
Boss_ShieldViperChildSpinAttack:                        ; DATA XREF: ROM:0004EDB2   o  ; was: sub_4EE9C
                movea.w $5C(a5),a0
                move.w  2(a5),2(a0)
                bset    #7,2(a0)
                move.l  8(a5),8(a0)
                move.w  $E(a5),$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                addi.w  #$80,d0
                andi.w  #$1FF,d0
                move.w  d0,$56(a0)
                move.w  #$300,$50(a0)
                addq.w  #2,4(a5)
; Decelerate child during spin attack
Boss_ShieldViperChildSpinAttack_DecelerateLoop:         ; DATA XREF: ROM:0004EDB4   o  ; was: loc_4EEDC
                movea.w $5C(a5),a0
                lea     stru_4F598(pc),a1
                nop
                bsr.w   Boss_ShieldViperChildPositionUpdate
                subi.w  #$10,$50(a0)
                bne.s   locret_4EEFC
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4EEFC:                                           ; CODE XREF: Boss_ShieldViperChildSpinAttack+54   j
                rts
; End of function Boss_ShieldViperChildSpinAttack
; Returns child to parent after attack
Boss_ShieldViperChildReturnToParent:                    ; DATA XREF: ROM:0004EDB6   o  ; was: sub_4EEFE
                movea.w $5C(a5),a0
                lea     stru_4F598(pc),a1
                nop
                bsr.w   Boss_ShieldViperChildPositionUpdate
                subq.w  #1,$48(a5)
                bne.s   locret_4EF2C
                move.b  $5A(a5),$21(a5)
                ori.w   #$8000,2(a5)
                move.w  #$1000,2(a0)
                clr.w   $5C(a5)
                clr.w   4(a5)
locret_4EF2C:                                           ; CODE XREF: Boss_ShieldViperChildReturnToParent+12   j
                rts
; End of function Boss_ShieldViperChildReturnToParent
; Main handler for bullet state machine
Projectile_ShieldViperBulletMain:                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4EF2E
                btst    #0,(word_FFC678).w
                beq.s   loc_4EF5E
                btst    #7,2(a5)
                beq.s   loc_4EF56
                move.w  #4,$48(a5)
                move.l  #stru_4F598,$4C(a5)
                move.w  #$37C,(a5)
                clr.w   4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4EF56:                                              ; CODE XREF: Projectile_ShieldViperBulletMain+E   j
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_4EF5E:                                              ; CODE XREF: Projectile_ShieldViperBulletMain+6   j
                move.w  4(a5),d0
                lea     off_4EF6A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_ShieldViperBulletMain
; ---------------------------------------------------------------------------
off_4EF6A:      dc.w    Projectile_ShieldViperBulletInit-*  ; DATA XREF: Projectile_ShieldViperBulletMain+34   o
                dc.w    Projectile_ShieldViperBulletBlink-*
                dc.w    Projectile_ShieldViperBulletBounds-*

; Initializes bullet with hitbox and visuals
Projectile_ShieldViperBulletInit:                       ; DATA XREF: ROM:off_4EF6A   o  ; was: sub_4EF70
                subq.w  #1,$4A(a5)
                bne.s   locret_4EFA2
                move.w  #$10,$48(a5)
                move.b  #$C0,$21(a5)
                move.b  #$10,$23(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F808F808,$28(a5)
                move.w  #$80,$26(a5)
                addq.w  #2,4(a5)
locret_4EFA2:                                           ; CODE XREF: Projectile_ShieldViperBulletInit+4   j
                rts
; End of function Projectile_ShieldViperBulletInit
; Animates bullet blinking for 16 frames
Projectile_ShieldViperBulletBlink:                      ; DATA XREF: ROM:0004EF6C   o  ; was: sub_4EFA4
                bsr.w   Projectile_ShieldViperCopyEntity
                btst    #0,(word_FFA000+1).w
                beq.s   loc_4EFB8
                bclr    #7,2(a5)
                bra.s   loc_4EFBE
; ---------------------------------------------------------------------------
loc_4EFB8:                                              ; CODE XREF: Projectile_ShieldViperBulletBlink+A   j
                bset    #7,2(a5)
loc_4EFBE:                                              ; CODE XREF: Projectile_ShieldViperBulletBlink+12   j
                subq.w  #1,$48(a5)
                bne.s   locret_4EFDA
                bset    #7,2(a5)
                move.l  $4C(a5),$18(a5)
                move.l  $50(a5),$1C(a5)
                addq.w  #2,4(a5)
locret_4EFDA:                                           ; CODE XREF: Projectile_ShieldViperBulletBlink+1E   j
                rts
; End of function Projectile_ShieldViperBulletBlink
; Checks bounds and destroys when outside
Projectile_ShieldViperBulletBounds:                     ; DATA XREF: ROM:0004EF6E   o  ; was: sub_4EFDC
                bsr.w   Projectile_ShieldViperCopyEntity
                btst    #7,$18(a5)
                bne.s   loc_4EFF2
                cmpi.w  #$1E0,$10(a5)
                bhi.s   loc_4F016
                bra.s   loc_4EFFA
; ---------------------------------------------------------------------------
loc_4EFF2:                                              ; CODE XREF: Projectile_ShieldViperBulletBounds+A   j
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   loc_4F016
loc_4EFFA:                                              ; CODE XREF: Projectile_ShieldViperBulletBounds+14   j
                btst    #7,$1C(a5)
                bne.s   loc_4F00C
                cmpi.w  #$1A0,$14(a5)
                bhi.s   loc_4F016
                bra.s   locret_4F01C
; ---------------------------------------------------------------------------
loc_4F00C:                                              ; CODE XREF: Projectile_ShieldViperBulletBounds+24   j
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcs.s   loc_4F016
                rts
; ---------------------------------------------------------------------------
loc_4F016:                                              ; CODE XREF: Projectile_ShieldViperBulletBounds+12   j
                                        ; Projectile_ShieldViperBulletBounds+1C   j
                move.w  #$1000,2(a5)
locret_4F01C:                                           ; CODE XREF: Projectile_ShieldViperBulletBounds+2E   j
                rts
; End of function Projectile_ShieldViperBulletBounds
; Copies entity pointer for processing
Projectile_ShieldViperCopyEntity:                       ; CODE XREF: Projectile_ShieldViperBulletBlink   p  ; was: sub_4F01E
                                        ; sub_4EFDC   p
                movea.w a5,a0
; End of function Projectile_ShieldViperCopyEntity
; Updates projectile rotation by 16 per frame
Projectile_ShieldViperUpdateRotation:                   ; CODE XREF: Boss_ShieldViperChildBoundsCheck+A   p  ; was: sub_4F020
                move.w  $56(a0),d0
                lea     stru_4F598(pc),a1
                nop
                bsr.w   Boss_ShieldViperMovement1
                addi.w  #$10,$56(a0)
                rts
; End of function Projectile_ShieldViperUpdateRotation
; Updates child position using circular trajectory
Boss_ShieldViperChildPositionUpdate:                    ; CODE XREF: Boss_ShieldViperChildCircularMotion+4E   p  ; was: sub_4F036
                                        ; Boss_ShieldViperChildSpinAttack+4A   p
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                btst    #7,(dword_FF9400).w
                beq.s   loc_4F04C
                addi.w  #-$80,d0
                bra.s   loc_4F050
; ---------------------------------------------------------------------------
loc_4F04C:                                              ; CODE XREF: Boss_ShieldViperChildPositionUpdate+E   j
                addi.w  #$80,d0
loc_4F050:                                              ; CODE XREF: Boss_ShieldViperChildPositionUpdate+14   j
                andi.w  #$1FE,d0
                lea     (Math_SineTable).l,a3
                move.w  Math_QuarterSineTable-Math_SineTable(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                muls.w  $50(a0),d0
                muls.w  $50(a0),d1
                add.l   $10(a5),d0
                add.l   $14(a5),d1
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                tst.b   $5E(a5)
                bne.s   locret_4F08E
                move.w  $54(a0),d0
                bsr.w   Boss_ShieldViperMovement1
                addi.w  #$10,$54(a0)
locret_4F08E:                                           ; CODE XREF: Boss_ShieldViperChildPositionUpdate+48   j
                rts
; End of function Boss_ShieldViperChildPositionUpdate
; Boss collision handler
Boss_ShieldViperCollision:                              ; CODE XREF: Boss_ShieldViperMain+76   p  ; was: sub_4F090
                                        ; Boss_ShieldViperSpawnProjectile2+2   p
                move.w  #1,d7
loc_4F094:                                              ; CODE XREF: Boss_ShieldViperCollision:loc_4F0B4   j
                move.w  $54(a0),d0
                sub.w   $52(a0),d0
                andi.w  #$1FF,d0
                beq.s   locret_4F0B8
                cmpi.w  #$100,d0
                bcs.w   loc_4F0B0
                subq.w  #1,$52(a0)
                bra.s   loc_4F0B4
; ---------------------------------------------------------------------------
loc_4F0B0:                                              ; CODE XREF: Boss_ShieldViperCollision+16   j
                addq.w  #1,$52(a0)
loc_4F0B4:                                              ; CODE XREF: Boss_ShieldViperCollision+1E   j
                dbf     d7,loc_4F094
locret_4F0B8:                                           ; CODE XREF: Boss_ShieldViperCollision+10   j
                rts
; End of function Boss_ShieldViperCollision
; Spawns collision effect with sound
Projectile_ShieldViperSpawnEffect:                      ; CODE XREF: Boss_ShieldViperSpinAttackUpdate+1C   p  ; was: sub_4F0BA
                                        ; Boss_ShieldViperSpawnProjectileWithAngle+18   p
                move.w  #$374,(a0)
                move.w  #$CC80,2(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FF01FF01,$2C(a0)
                move.l  #word_ECFF4,8(a0)
                move.w  #$8300,$E(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.w  #$10,$48(a0)
                clr.w   $C(a0)
                btst    #1,(word_FFA000+1).w
                bne.s   locret_4F10A
                btst    #0,(word_FFA000+1).w
                bne.s   locret_4F10A
                move.b  #$58,d0                         ; 'X'
                jsr     (Sound_PlaySFX).l
locret_4F10A:                                           ; CODE XREF: Projectile_ShieldViperSpawnEffect+3C   j
                                        ; Projectile_ShieldViperSpawnEffect+44   j
                rts
; End of function Projectile_ShieldViperSpawnEffect
; Handles bullet animation timing
Projectile_ShieldViperBulletAnimation:                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4F10C
                bclr    #4,$22(a5)
                bne.s   loc_4F154
                tst.w   4(a5)
                beq.s   loc_4F126
                subq.w  #1,$48(a5)
                bne.s   locret_4F15C
                clr.w   4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4F126:                                              ; CODE XREF: Projectile_ShieldViperBulletAnimation+C   j
                move.w  $5C(a5),d0
                lea     stru_4F15E(pc),a1
                nop
                move.w  (a1,d0.w),$48(a5)
                bmi.s   loc_4F14C
                move.l  4(a1,d0.w),8(a5)
                clr.w   $C(a5)
                addq.w  #8,$5C(a5)
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4F14C:                                              ; CODE XREF: Projectile_ShieldViperBulletAnimation+2A   j
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_4F154:                                              ; CODE XREF: Projectile_ShieldViperBulletAnimation+6   j
                moveq   #7,d0
                jmp     Pickup_SpawnRandomFromCurrentObject
; ---------------------------------------------------------------------------
locret_4F15C:                                           ; CODE XREF: Projectile_ShieldViperBulletAnimation+12   j
                rts
; End of function Projectile_ShieldViperBulletAnimation
; ---------------------------------------------------------------------------
stru_4F15E:     dc.w    2                               ; field_0
                                        ; DATA XREF: Projectile_ShieldViperBulletAnimation+1E   o
                dc.w    0                               ; field_2
                dc.l    word_ECFF4                      ; field_4
                dc.w    2                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECFFA                      ; field_4
                dc.w    3                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED000                      ; field_4
                dc.w    3                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED006                      ; field_4
                dc.w    4                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED00C                      ; field_4
                dc.w    4                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED012                      ; field_4
                dc.w    3                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED018                      ; field_4
                dc.w    3                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED01E                      ; field_4
                dc.w    $FFFF                           ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED01E                      ; field_4

; Defeat main handler
