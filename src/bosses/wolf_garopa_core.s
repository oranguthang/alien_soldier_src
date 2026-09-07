; Movement pattern 2
Boss_WolfGaropaMovement2:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_4F8F0
                tst.w   4(a5)
                beq.w   loc_4F920
                tst.w   8(a5)
                beq.s   loc_4F920
                btst    #2,(byte_FF80EC).w
                bne.s   loc_4F916
                btst    #1,(byte_FF80EC).w
                bne.s   loc_4F916
                tst.w   (word_FF8200).w
                beq.w   Boss_WolfGaropaUpdateSprites
loc_4F916:                                              ; CODE XREF: Boss_WolfGaropaMovement2+14   j
                                        ; Boss_WolfGaropaMovement2+1C   j
                bsr.w   Boss_WolfGaropaDamage
                jsr     (Gfx_InitPaletteFade).l
loc_4F920:                                              ; CODE XREF: Boss_WolfGaropaMovement2+4   j
                                        ; Boss_WolfGaropaMovement2+C   j
                move.w  4(a5),d0
                movea.w off_4F930(pc,d0.w),a0
                adda.l  #Boss_WolfGaropaMovement3,a0
                jmp     (a0)
; ---------------------------------------------------------------------------
off_4F930:      dc.w    Boss_WolfGaropaMovement3-Boss_WolfGaropaMovement3
                                        ; DATA XREF: Boss_WolfGaropaMovement2+34   r
                dc.w    Boss_WolfGaropaInitMultiPattern-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaDashAttack-Boss_WolfGaropaMovement3
                dc.w    Projectile_WolfGaropaBullet1-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaMovement_Pattern1-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaDiveLoop-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaMovement_Pattern3-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaDiveActive-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaAnimationScript-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaAnimationUpdate-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaMovement_Pattern4-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaShootAndAdvance-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaAttack1-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaAttack2-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaAttack3-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaAttack4-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaAttack4_Return-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaEmptyState-Boss_WolfGaropaMovement3
                dc.w    Boss_WolfGaropaEmptyState-Boss_WolfGaropaMovement3
; End of function Boss_WolfGaropaMovement2
; Movement pattern 3
Boss_WolfGaropaMovement3:                               ; DATA XREF: Boss_WolfGaropaMovement2+38   o  ; was: sub_4F956
                                        ; sub_4F8F0:off_4F930   o
                tst.w   (word_FFF720).w
                bmi.w   locret_4FA94
                move.b  #$18,(byte_FFA420).w
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$288,(dword_FF8040).w
                moveq   #$18,d7
                movea.l #dword_3530C,a0
                movea.l #word_35370,a1
                movea.l #word_3538A,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$3E8,(a5)
                move.w  #$C00,2(a5)
                move.w  #$1F8,$B6(a5)
                move.w  #$1F8,$116(a5)
                move.w  #$120,$176(a5)
                move.w  #$120,$1D6(a5)
                moveq   #3,d0
                bset    d0,$36E(a5)
                bset    d0,$54E(a5)
                bset    d0,$72E(a5)
                bset    d0,$90E(a5)
                move.w  #$10,d0
                move.w  #$C000,d1
                move.w  #$AA88,d2
                moveq   #$18,d3
                move.w  d0,$960(a5)
                clr.w   $962(a5)
                move.w  d0,$9C0(a5)
                move.w  d1,$9C2(a5)
                move.w  d2,$9CE(a5)
                move.b  d3,$9E0(a5)
                addq.b  #4,$9E0(a5)
                move.l  #word_ED172,$9C8(a5)
                move.w  d0,$A20(a5)
                move.w  d1,$A22(a5)
                move.w  d2,$A2E(a5)
                move.b  #8,$A40(a5)
                move.l  #word_ED190,$A28(a5)
                move.w  #$2A88,d2
                move.w  d0,$A80(a5)
                move.w  d1,$A82(a5)
                move.w  d2,$A8E(a5)
                move.b  d3,$AA0(a5)
                addq.b  #4,$AA0(a5)
                move.l  #word_ED33A,$A88(a5)
                move.w  d0,$AE0(a5)
                move.w  d1,$AE2(a5)
                move.w  d2,$AEE(a5)
                move.b  d3,$B00(a5)
                move.l  #word_ED328,$AE8(a5)
                move.w  #$10,$B40(a5)
                move.w  #$8000,$B42(a5)
                move.w  #0,$B50(a5)
                move.w  #$500,$B48(a5)
                movea.l #word_1BDEC,a1
                jsr     (Sprite_InitFromPointerTable).l
                movea.l #$FFFF2020,a0
                move.w  #$E000,d0
                move.w  #$1E0,d1
                moveq   #$10,d7
                jsr     (Gfx_UpdateTilemapIndices).l
                lea     word_4FA96(pc),a0
                nop
                jsr     (Gfx_LoadCompressedTiles).l
                move.w  #2,$1DE(a5)
                bra.w   Boss_WolfGaropaJumpAttack
; ---------------------------------------------------------------------------
locret_4FA94:                                           ; CODE XREF: Boss_WolfGaropaMovement3+4   j
                                        ; DATA XREF: ROM:off_4FE72   o
                rts
; End of function Boss_WolfGaropaMovement3
; ---------------------------------------------------------------------------
word_4FA96:     dc.w    $6220, $2000, $302, 1, $200, $304, $506, $708, $90A
                                        ; DATA XREF: Boss_WolfGaropaMovement3+128   o

; Initializes wolf garopa boss state 2 with position and attack pattern
Boss_WolfGaropaInitState2:
                move.w  #2,4(a5)                        ; was: sub_4FAA8
                move.w  #$100,$10(a5)
                move.w  #$100,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                bsr.w   Boss_WolfGaropaShootPattern2
; End of function Boss_WolfGaropaInitState2
; Initializes wolf garopa with combined shoot patterns 6 and 5
Boss_WolfGaropaInitMultiPattern:                        ; DATA XREF: Boss_WolfGaropaMovement2+42   o  ; was: sub_4FAD8
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                lea     word_50874(pc),a1
                nop
                bsr.w   Boss_WolfGaropaShootPattern6
                bra.w   Boss_WolfGaropaShootPattern5
; End of function Boss_WolfGaropaInitMultiPattern
; Jump attack pattern
Boss_WolfGaropaJumpAttack:                              ; CODE XREF: Boss_WolfGaropaMovement3+13A   j  ; was: sub_4FAEE
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$10(a5)
                move.w  #$110,$14(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$E0,$47C(a5)
                bsr.w   Boss_WolfGaropaShootPattern2
; End of function Boss_WolfGaropaJumpAttack
; Dash attack pattern
Boss_WolfGaropaDashAttack:                              ; DATA XREF: Boss_WolfGaropaMovement2+44   o  ; was: sub_4FB1C
                btst    #0,$41C(a5)
                beq.s   loc_4FB4C
                btst    #3,$23E(a5)
                beq.s   loc_4FB4C
                addq.w  #2,4(a5)
                moveq   #0,d0
                jsr     (UI_CheckVictoryCondition).l
                bra.s   loc_4FB4C
; End of function Boss_WolfGaropaDashAttack
; Bullet projectile 1
Projectile_WolfGaropaBullet1:                           ; DATA XREF: Boss_WolfGaropaMovement2+46   o  ; was: sub_4FB3A
                tst.w   (word_FF80C2).w
                bne.s   loc_4FB4C
                addq.w  #2,4(a5)
                clr.b   (byte_FF80EC).w
                bra.w   loc_4FB82
; ---------------------------------------------------------------------------
loc_4FB4C:                                              ; CODE XREF: Boss_WolfGaropaDashAttack+6   j
                                        ; Boss_WolfGaropaDashAttack+E   j
                bsr.w   Boss_WolfGaropaShootPattern1
loc_4FB50:                                              ; CODE XREF: Projectile_WolfGaropaBullet1+BA   j
                                        ; Boss_WolfGaropaDiveLoop+2E   j
                btst    #2,$23E(a5)
                beq.s   loc_4FB5E
                move.w  #$1C,$53C(a5)
loc_4FB5E:                                              ; CODE XREF: Projectile_WolfGaropaBullet1+1C   j
                move.b  (dword_FFFF08).w,d2
                andi.w  #$E,d2
                addi.w  #$1A0,d2
                move.w  d2,$53E(a5)
                move.w  (dword_FFFF08).w,d2
                andi.w  #$E,d2
                addi.w  #$170,d2
                moveq   #0,d3
                moveq   #4,d7
                bra.w   Boss_WolfGaropaSpawnProjectile4
; ---------------------------------------------------------------------------
loc_4FB82:                                              ; CODE XREF: Projectile_WolfGaropaBullet1+E   j
                                        ; Boss_WolfGaropaDiveLoop+46   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1C0,d0
                addi.w  #$100,d0
                move.w  d0,$11C(a5)
                move.w  #$80,$4DC(a5)
                move.w  #8,4(a5)
                clr.w   $11E(a5)
; Wolf Garopa movement pattern 1
Boss_WolfGaropaMovement_Pattern1:                       ; DATA XREF: Boss_WolfGaropaMovement2+48   o  ; was: loc_4FBA2
                tst.w   (word_FF8200).w
                beq.s   loc_4FBC6
                subq.w  #1,$11C(a5)
                bpl.s   loc_4FBC6
                tst.w   $4DE(a5)
                bpl.s   loc_4FBC6
                tst.w   $6BC(a5)
                bne.s   loc_4FBC6
                clr.b   $65E(a5)
                clr.w   $6BC(a5)
                bra.w   loc_4FC88
; ---------------------------------------------------------------------------
loc_4FBC6:                                              ; CODE XREF: Projectile_WolfGaropaBullet1+6C   j
                                        ; Projectile_WolfGaropaBullet1+72   j
                subq.w  #1,$11E(a5)
                bpl.s   loc_4FBE8
                move.b  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                move.w  d0,$11E(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                addi.w  #$C8,d0
                move.w  d0,$47C(a5)
loc_4FBE8:                                              ; CODE XREF: Projectile_WolfGaropaBullet1+90   j
                bsr.w   Boss_WolfGaropaShootPattern1
                bsr.w   Boss_WolfGaropaGraphicsUpdate
                tst.w   (word_FF8200).w
                beq.w   loc_4FB50
                bsr.w   Projectile_WolfGaropaBullet2
                move.w  $A76(a5),d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                move.w  d0,$53E(a5)
                tst.w   $4DC(a5)
                bmi.s   loc_4FC48
                subq.w  #1,$4DC(a5)
                bpl.s   loc_4FC20
                move.w  #$14,$4DE(a5)
locret_4FC1E:                                           ; CODE XREF: Projectile_WolfGaropaBullet1+F0   j
                                        ; Projectile_WolfGaropaBullet1+12C   j
                rts
; ---------------------------------------------------------------------------
loc_4FC20:                                              ; CODE XREF: Projectile_WolfGaropaBullet1+DC   j
                cmpi.w  #$40,$4DC(a5)                   ; '@'
                bmi.w   Boss_WolfGaropaDefeatInit
                bne.s   locret_4FC1E
                move.w  #$18,$5FE(a5)
                move.w  #$2000,$65C(a5)
                move.b  #8,$65E(a5)
                move.b  #$ED,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
loc_4FC48:                                              ; CODE XREF: Projectile_WolfGaropaBullet1+D6   j
                cmpi.w  #$14,$4DE(a5)
                bne.s   loc_4FC5E
                tst.w   d3
                beq.w   Boss_WolfGaropaDefeatInit
                clr.b   $65E(a5)
                clr.w   $6BC(a5)
loc_4FC5E:                                              ; CODE XREF: Projectile_WolfGaropaBullet1+114   j
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_4FC1E
                subq.w  #1,$4DE(a5)
                bpl.w   Projectile_WolfGaropaHoming
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                addi.w  #$80,d0
                move.w  d0,$4DC(a5)
                move.w  #$3F,$5FC(a5)                   ; '?'
                rts
; ---------------------------------------------------------------------------
loc_4FC88:                                              ; CODE XREF: Projectile_WolfGaropaBullet1+88   j
                move.w  #$14,4(a5)
                bset    #3,$9CE(a5)
                move.w  #$12C,$47C(a5)
; Wolf Garopa dash attack
Boss_WolfGaropaMovement_Pattern4:                       ; DATA XREF: Boss_WolfGaropaMovement2+54   o  ; was: loc_4FC9A
                bsr.w   Boss_WolfGaropaShootPattern1
                move.w  #$140,d2
                moveq   #0,d3
                moveq   #8,d7
                bsr.w   Boss_WolfGaropaSpawnProjectile4
                tst.w   d3
                beq.s   locret_4FCB8
                addq.w  #2,4(a5)
                move.w  #$20,$11E(a5)                   ; ' '
locret_4FCB8:                                           ; CODE XREF: Projectile_WolfGaropaBullet1+172   j
                rts
; End of function Projectile_WolfGaropaBullet1
; Wolf garopa shoots pattern 1 and advances state after timer expires
Boss_WolfGaropaShootAndAdvance:                         ; DATA XREF: Boss_WolfGaropaMovement2+56   o  ; was: sub_4FCBA
                bsr.w   Boss_WolfGaropaShootPattern1
                subq.w  #1,$11E(a5)
                bpl.s   locret_4FCCE
                addq.w  #2,4(a5)
                move.w  #1,$11E(a5)
locret_4FCCE:                                           ; CODE XREF: Boss_WolfGaropaShootAndAdvance+8   j
                rts
; End of function Boss_WolfGaropaShootAndAdvance
; Wolf Garopa attack state 1: shoot pattern and spawn projectile at angle $C0
Boss_WolfGaropaAttack1:                                 ; DATA XREF: Boss_WolfGaropaMovement2+58   o  ; was: sub_4FCD0
                bsr.w   Boss_WolfGaropaShootPattern1
                move.w  #$C0,d2
                moveq   #0,d3
                moveq   #$16,d7
                bsr.w   Boss_WolfGaropaSpawnProjectile4
                tst.w   d3
                beq.s   locret_4FD0C
                move.b  #$35,d0                         ; '5'
                jsr     (Sound_PlaySFX).l
                jsr     Projectile_SpawnWolfGaropaBomb(pc)  ; (pc)
                nop
                subq.w  #1,$11E(a5)
                bpl.s   loc_4FD08
                addq.w  #4,4(a5)
                bclr    #3,$AEE(a5)
                bra.w   Boss_WolfGaropaSetPattern1
; ---------------------------------------------------------------------------
loc_4FD08:                                              ; CODE XREF: Boss_WolfGaropaAttack1+28   j
                addq.w  #2,4(a5)
locret_4FD0C:                                           ; CODE XREF: Boss_WolfGaropaAttack1+12   j
                rts
; End of function Boss_WolfGaropaAttack1
; Wolf Garopa attack state 2: shoot pattern and spawn projectile at angle $140
Boss_WolfGaropaAttack2:                                 ; DATA XREF: Boss_WolfGaropaMovement2+5A   o  ; was: sub_4FD0E
                bsr.w   Boss_WolfGaropaShootPattern1
                bsr.w   Boss_WolfGaropaSetPattern1
                move.w  #$140,d2
                moveq   #0,d3
                moveq   #$10,d7
                bsr.w   Boss_WolfGaropaSpawnProjectile4
                tst.w   d3
                beq.s   locret_4FD2A
                subq.w  #2,4(a5)
locret_4FD2A:                                           ; CODE XREF: Boss_WolfGaropaAttack2+16   j
                rts
; End of function Boss_WolfGaropaAttack2
; Wolf Garopa attack state 3: shoot pattern and spawn projectile at angle $180
Boss_WolfGaropaAttack3:                                 ; DATA XREF: Boss_WolfGaropaMovement2+5C   o  ; was: sub_4FD2C
                bsr.w   Boss_WolfGaropaShootPattern1
                bsr.w   Boss_WolfGaropaSetPattern1
                move.w  #$180,d2
                moveq   #0,d3
                moveq   #$C,d7
                bsr.w   Boss_WolfGaropaSpawnProjectile4
                tst.w   d3
                beq.s   locret_4FD4E
                addq.w  #2,4(a5)
                move.w  #$30,$11E(a5)                   ; '0'
locret_4FD4E:                                           ; CODE XREF: Boss_WolfGaropaAttack3+16   j
                rts
; End of function Boss_WolfGaropaAttack3
; Wolf Garopa attack state 4: manage countdown timer and transition to dive or retreat
Boss_WolfGaropaAttack4:                                 ; DATA XREF: Boss_WolfGaropaMovement2+5E   o  ; was: sub_4FD50
                bsr.w   Boss_WolfGaropaShootPattern1
                bsr.w   Boss_WolfGaropaSetPattern1
                subq.w  #1,$11E(a5)
                bpl.s   Boss_WolfGaropaAttack4_Return
                bset    #3,$AEE(a5)
                btst    #0,(dword_FFFF08+1).w
                bne.w   Boss_WolfGaropaDiveInit2
                bra.w   Boss_WolfGaropaDiveInit1
; ---------------------------------------------------------------------------
; Return from Wolf Garopa attack pattern 4
Boss_WolfGaropaAttack4_Return:                          ; CODE XREF: Boss_WolfGaropaAttack4+C   j  ; was: locret_4FD72
                                        ; DATA XREF: Boss_WolfGaropaMovement2+60   o
                rts
; End of function Boss_WolfGaropaAttack4
; Empty Wolf Garopa boss movement state
Boss_WolfGaropaEmptyState:                              ; DATA XREF: Boss_WolfGaropaMovement2+62   o  ; was: nullsub_118
                                        ; Boss_WolfGaropaMovement2+64   o
                rts
; End of function Boss_WolfGaropaEmptyState
; Set Wolf Garopa animation pattern pointer to word_ED310
Boss_WolfGaropaSetPattern1:                             ; CODE XREF: Boss_WolfGaropaAttack1+34   j  ; was: sub_4FD76
                                        ; Boss_WolfGaropaAttack2+4   p
                move.l  #word_ED310,$AE8(a5)
                rts
; End of function Boss_WolfGaropaSetPattern1
; Initialize Wolf Garopa dive attack: spawn projectile type 424 and set dive state
Boss_WolfGaropaDiveInit1:                               ; CODE XREF: Boss_WolfGaropaAttack4+1E   j  ; was: sub_4FD80
                tst.w   (word_FFFF0E).w
                bne.s   loc_4FD9A
                jsr     (Projectile_InitType424).l
                bne.s   loc_4FD9A
                move.w  #$1A8,$10(a0)
                move.w  #$C8,$14(a0)
loc_4FD9A:                                              ; CODE XREF: Boss_WolfGaropaDiveInit1+4   j
                                        ; Boss_WolfGaropaDiveInit1+C   j
                move.w  #$A,4(a5)
                bset    #1,$41C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #2,d0
                addq.w  #1,d0
                move.w  d0,$11C(a5)
                move.w  #$40,$11E(a5)                   ; '@'
                move.w  #$140,$47C(a5)
                bset    #3,$9CE(a5)
; End of function Boss_WolfGaropaDiveInit1
; Wolf Garopa dive attack loop: manage bomb state and attack cycles
Boss_WolfGaropaDiveLoop:                                ; DATA XREF: Boss_WolfGaropaMovement2+4A   o  ; was: sub_4FDC6
                tst.b   (byte_FF9DBA).w
                bne.s   loc_4FDF0
                tst.w   $11C(a5)
                bmi.w   loc_4FDF8
                subq.w  #1,$11E(a5)
                bpl.s   loc_4FDF0
                tst.w   (word_FF8200).w
                beq.w   loc_4FDF8
                bsr.w   Boss_WolfGaropaBombTrigger
                tst.b   (byte_FF9DBA).w
                beq.s   loc_4FDF0
                subq.w  #1,$11C(a5)
loc_4FDF0:                                              ; CODE XREF: Boss_WolfGaropaDiveLoop+4   j
                                        ; Boss_WolfGaropaDiveLoop+12   j
                bsr.w   Boss_WolfGaropaShootPattern1
                bra.w   loc_4FB50
; ---------------------------------------------------------------------------
loc_4FDF8:                                              ; CODE XREF: Boss_WolfGaropaDiveLoop+A   j
                                        ; Boss_WolfGaropaDiveLoop+18   j
                addq.w  #2,4(a5)
                bclr    #1,$41C(a5)
                move.w  #$40,$11C(a5)                   ; '@'
; Wolf Garopa charge movement
Boss_WolfGaropaMovement_Pattern3:                       ; DATA XREF: Boss_WolfGaropaMovement2+4C   o  ; was: loc_4FE08
                subq.w  #1,$11C(a5)
                bmi.w   loc_4FB82
                bsr.w   Boss_WolfGaropaShootPattern1
                bra.w   loc_4FB50
; End of function Boss_WolfGaropaDiveLoop
; Initialize Wolf Garopa alternate dive attack with different projectile position
Boss_WolfGaropaDiveInit2:                               ; CODE XREF: Boss_WolfGaropaAttack4+1A   j  ; was: sub_4FE18
                tst.w   (word_FFFF0E).w
                bne.s   loc_4FE32
                jsr     (Projectile_InitType424).l
                bne.s   loc_4FE32
                move.w  #$1A8,$10(a0)
                move.w  #$130,$14(a0)
loc_4FE32:                                              ; CODE XREF: Boss_WolfGaropaDiveInit2+4   j
                                        ; Boss_WolfGaropaDiveInit2+C   j
                move.w  #$E,4(a5)
                bset    #2,$41C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                move.w  d0,$11C(a5)
                bset    #3,$9CE(a5)
; End of function Boss_WolfGaropaDiveInit2
; Wolf Garopa dive attack active state: check flag and shoot pattern
Boss_WolfGaropaDiveActive:                              ; DATA XREF: Boss_WolfGaropaMovement2+4E   o  ; was: sub_4FE50
                btst    #2,$41C(a5)
                beq.w   loc_4FB82
                bsr.w   Boss_WolfGaropaShootPattern1
                bra.w   loc_4FB50
; End of function Boss_WolfGaropaDiveActive
; Shooting pattern 1
Boss_WolfGaropaShootPattern1:                           ; CODE XREF: Projectile_WolfGaropaBullet1:loc_4FB4C   p  ; was: sub_4FE62
                                        ; sub_4FB3A:loc_4FBE8   p
                move.w  $35C(a5),d0
                movea.w off_4FE72(pc,d0.w),a0
                adda.l  #Boss_WolfGaropaShootPattern2,a0
                jmp     (a0)
; End of function Boss_WolfGaropaShootPattern1
; ---------------------------------------------------------------------------
off_4FE72:      dc.w    locret_4FA94-Boss_WolfGaropaShootPattern2
                                        ; DATA XREF: Boss_WolfGaropaShootPattern1+4   r
                dc.w    Boss_WolfGaropaShootPattern3-Boss_WolfGaropaShootPattern2
                dc.w    Boss_WolfGaropaShootPattern4-Boss_WolfGaropaShootPattern2
                dc.w    Boss_WolfGaropaFalling-Boss_WolfGaropaShootPattern2
                dc.w    Boss_WolfGaropa_JumpState-Boss_WolfGaropaShootPattern2
                dc.w    Boss_WolfGaropaFalling2-Boss_WolfGaropaShootPattern2
                dc.w    Boss_WolfGaropaLaunch-Boss_WolfGaropaShootPattern2
                dc.w    Boss_WolfGaropaRising-Boss_WolfGaropaShootPattern2

; Shooting pattern 2
Boss_WolfGaropaShootPattern2:                           ; CODE XREF: Boss_WolfGaropaInitState2+2C   p  ; was: sub_4FE82
                                        ; Boss_WolfGaropaJumpAttack+2A   p
                                        ; DATA XREF:
                move.w  #2,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                rts
; End of function Boss_WolfGaropaShootPattern2
; Shooting pattern 3
Boss_WolfGaropaShootPattern3:                           ; DATA XREF: ROM:0004FE74   o  ; was: sub_4FE94
                bclr    #0,$41C(a5)
                move.w  $47C(a5),d0
                sub.w   $10(a5),d0
                bpl.s   loc_4FED8
                cmpi.w  #$FFFC,d0
                bmi.s   loc_4FEB8
                bset    #0,$41C(a5)
                lea     word_507EA(pc),a1
                nop
                bra.s   loc_4FECE
; ---------------------------------------------------------------------------
loc_4FEB8:                                              ; CODE XREF: Boss_WolfGaropaShootPattern3+14   j
                lea     word_50814(pc),a1
                nop
                tst.l   $18(a5)
                bpl.s   loc_4FECE
                cmpi.l  #$FFFFA000,$18(a5)
                bmi.s   loc_4FF0A
loc_4FECE:                                              ; CODE XREF: Boss_WolfGaropaShootPattern3+22   j
                                        ; Boss_WolfGaropaShootPattern3+2E   j
                subi.l  #$1000,$18(a5)
                bra.s   loc_4FF0A
; ---------------------------------------------------------------------------
loc_4FED8:                                              ; CODE XREF: Boss_WolfGaropaShootPattern3+E   j
                cmpi.w  #4,d0
                bpl.s   loc_4FEEC
                bset    #0,$41C(a5)
                lea     word_507EA(pc),a1
                nop
                bra.s   loc_4FECE
; ---------------------------------------------------------------------------
loc_4FEEC:                                              ; CODE XREF: Boss_WolfGaropaShootPattern3+48   j
                lea     word_507EA(pc),a1
                nop
                tst.l   $18(a5)
                bmi.s   loc_4FF02
                cmpi.l  #$4000,$18(a5)
                bpl.s   loc_4FF0A
loc_4FF02:                                              ; CODE XREF: Boss_WolfGaropaShootPattern3+62   j
                addi.l  #$1000,$18(a5)
loc_4FF0A:                                              ; CODE XREF: Boss_WolfGaropaShootPattern3+38   j
                                        ; Boss_WolfGaropaShootPattern3+42   j
                move.l  a1,$2FC(a5)
                bsr.w   Boss_WolfGaropaShootPattern6
                btst    #2,$23E(a5)
                beq.w   loc_4FF64
                move.w  a5,$4A(a5)
                btst    #1,$41C(a5)
                bne.s   loc_4FF40
                addq.w  #2,$35C(a5)
                addi.l  #$C000,$18(a5)
                move.l  #$FFFD0000,$1C(a5)
                bra.w   Boss_WolfGaropaShootPattern5
; ---------------------------------------------------------------------------
loc_4FF40:                                              ; CODE XREF: Boss_WolfGaropaShootPattern3+92   j
                move.w  #6,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                addi.l  #$10000,$18(a5)
                move.l  #$FFFFE800,$1C(a5)
                bra.w   Boss_WolfGaropaShootPattern5
; ---------------------------------------------------------------------------
loc_4FF64:                                              ; CODE XREF: Boss_WolfGaropaShootPattern3+84   j
                btst    #3,$23E(a5)
                beq.s   loc_4FF9A
loc_4FF6C:                                              ; CODE XREF: Boss_WolfGaropaFalling+EE   j
                                        ; Boss_WolfGaropaLaunch+1C   j
                move.b  $23E(a5),d0
                andi.w  #3,d0
                asl.w   #1,d0
                movea.w word_4FFA8(pc,d0.w),a0
loc_4FF7A:                                              ; CODE XREF: Boss_WolfGaropaShootPattern4+42   j
                                        ; Boss_WolfGaropaShootPattern4+50   j
                move.w  a0,$4A(a5)
                move.w  #$148,$14(a0)
                btst    #7,$23E(a5)
                beq.s   loc_4FF9A
                move.b  #$CF,d0
                jsr     (Sound_PlaySFX).l
                bra.w   Boss_WolfGaropaShootPattern5
; ---------------------------------------------------------------------------
loc_4FF9A:                                              ; CODE XREF: Boss_WolfGaropaShootPattern3+D6   j
                                        ; Boss_WolfGaropaShootPattern3+F6   j
                movea.w $4A(a5),a0
                move.w  #$148,$14(a0)
                bra.w   Boss_WolfGaropaShootPattern5
; End of function Boss_WolfGaropaShootPattern3
; ---------------------------------------------------------------------------
word_4FFA8:     dc.w    $CF20, $CD40, $CB60, $C980
                                        ; DATA XREF: Boss_WolfGaropaShootPattern3+E2   r

; Shooting pattern 4
Boss_WolfGaropaShootPattern4:                           ; DATA XREF: ROM:0004FE76   o  ; was: sub_4FFB0
                subi.l  #$800,$18(a5)
                addi.l  #$3800,$1C(a5)
                movea.l $2FC(a5),a1
                bsr.w   Boss_WolfGaropaShootPattern6
                tst.w   $58(a5)
                bpl.w   Boss_WolfGaropaShootPattern5
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #7,$23E(a5)
                movea.w #(byte_FFCF20-M68K_RAM),a0
                btst    #2,$41C(a5)
                bne.s   loc_4FFF6
                move.w  #2,$35C(a5)
                bra.w   loc_4FF7A
; ---------------------------------------------------------------------------
loc_4FFF6:                                              ; CODE XREF: Boss_WolfGaropaShootPattern4+3A   j
                move.w  #$C,$35C(a5)
                clr.w   $11E(a5)
                bra.w   loc_4FF7A
; End of function Boss_WolfGaropaShootPattern4
; Wolf Garopa falling physics with gravity and horizontal tracking
Boss_WolfGaropaFalling:                                 ; DATA XREF: ROM:0004FE78   o  ; was: sub_50004
                subi.l  #$400,$18(a5)
                addi.l  #$4000,$1C(a5)
                tst.w   $58(a5)
                bmi.s   loc_5003A
                bclr    #6,$23E(a5)
                beq.s   loc_5002C
                move.b  #$EE,d0
                jsr     (Sound_PlaySFX).l
loc_5002C:                                              ; CODE XREF: Boss_WolfGaropaFalling+1C   j
                lea     word_5083E(pc),a1
                nop
                bsr.w   Boss_WolfGaropaShootPattern6
                bra.w   Boss_WolfGaropaShootPattern5
; ---------------------------------------------------------------------------
loc_5003A:                                              ; CODE XREF: Boss_WolfGaropaFalling+14   j
                addq.w  #2,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CD40,$4A(a5)
                move.w  #$148,$734(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
; Wolf Garopa jump attack state
Boss_WolfGaropa_JumpState:                              ; DATA XREF: ROM:0004FE7A   o  ; was: loc_50060
                move.w  $47C(a5),d0
                sub.w   $10(a5),d0
                bpl.s   loc_5008A
                cmpi.w  #$FFFC,d0
                bpl.s   loc_500A8
                tst.l   $18(a5)
                bpl.s   loc_50080
                cmpi.l  #$FFFF0000,$18(a5)
                bmi.s   loc_500A8
loc_50080:                                              ; CODE XREF: Boss_WolfGaropaFalling+70   j
                subi.l  #$1400,$18(a5)
                bra.s   loc_500A8
; ---------------------------------------------------------------------------
loc_5008A:                                              ; CODE XREF: Boss_WolfGaropaFalling+64   j
                cmpi.w  #4,d0
                bmi.s   loc_500A8
                tst.l   $18(a5)
                bmi.s   loc_500A0
                cmpi.l  #$E000,$18(a5)
                bpl.s   loc_500A8
loc_500A0:                                              ; CODE XREF: Boss_WolfGaropaFalling+90   j
                addi.l  #$1400,$18(a5)
loc_500A8:                                              ; CODE XREF: Boss_WolfGaropaFalling+6A   j
                                        ; Boss_WolfGaropaFalling+7A   j
                lea     word_50850(pc),a1
                nop
                bsr.w   Boss_WolfGaropaShootPattern6
                btst    #3,$23E(a5)
                beq.w   loc_500E8
                move.b  $23E(a5),d0
                andi.w  #3,d0
                move.l  #$4000,d1
                cmpi.w  #2,d0
                bpl.s   loc_500D6
                move.l  #$2000,d1
loc_500D6:                                              ; CODE XREF: Boss_WolfGaropaFalling+CA   j
                add.l   d1,$18(a5)
                cmpi.w  #2,d0
                bne.s   loc_500E8
                btst    #1,$41C(a5)
                beq.s   loc_500F6
loc_500E8:                                              ; CODE XREF: Boss_WolfGaropaFalling+B4   j
                                        ; Boss_WolfGaropaFalling+DA   j
                btst    #3,$23E(a5)
                beq.w   loc_4FF9A
                bra.w   loc_4FF6C
; ---------------------------------------------------------------------------
loc_500F6:                                              ; CODE XREF: Boss_WolfGaropaFalling+E2   j
                addq.w  #2,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                addi.l  #$10000,$18(a5)
                move.l  #$FFFA0000,$1C(a5)
                bra.w   Boss_WolfGaropaShootPattern5
; End of function Boss_WolfGaropaFalling
; Wolf Garopa falling physics variant with different gravity values
Boss_WolfGaropaFalling2:                                ; DATA XREF: ROM:0004FE7C   o  ; was: sub_50120
                subi.l  #$800,$18(a5)
                addi.l  #$3800,$1C(a5)
                lea     word_5086A(pc),a1
                nop
                bsr.w   Boss_WolfGaropaShootPattern6
                tst.w   $58(a5)
                bpl.w   Boss_WolfGaropaShootPattern5
                move.w  #2,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #7,$23E(a5)
                movea.w #(byte_FFCF20-M68K_RAM),a0
                bra.w   loc_4FF7A
; End of function Boss_WolfGaropaFalling2
; Wolf Garopa launch upward with high velocity after ground hit
Boss_WolfGaropaLaunch:                                  ; DATA XREF: ROM:0004FE7E   o  ; was: sub_50160
                lea     word_50874(pc),a1
                nop
                bsr.w   Boss_WolfGaropaShootPattern6
                btst    #6,$23E(a5)
                bne.s   loc_50180
                btst    #3,$23E(a5)
                beq.w   loc_4FF9A
                bra.w   loc_4FF6C
; ---------------------------------------------------------------------------
loc_50180:                                              ; CODE XREF: Boss_WolfGaropaLaunch+10   j
                addq.w  #2,$35C(a5)
                move.w  a5,$4A(a5)
                move.l  #$14000,$18(a5)
                move.l  #$FFF80000,$1C(a5)
                move.b  #$2A,d0                         ; '*'
                jsr     (Sound_PlaySFX).l
                bra.w   Boss_WolfGaropaShootPattern5
; End of function Boss_WolfGaropaLaunch
; Wolf Garopa rising state: call bomb check and manage linked object physics
Boss_WolfGaropaRising:                                  ; DATA XREF: ROM:0004FE80   o  ; was: sub_501A6
                tst.w   $11E(a5)
                bne.s   loc_501BA
                bsr.w   Boss_WolfGaropaBombCheck1
                tst.b   (byte_FF9DBA).w
                beq.s   loc_501BA
                addq.w  #1,$11E(a5)
loc_501BA:                                              ; CODE XREF: Boss_WolfGaropaRising+4   j
                                        ; Boss_WolfGaropaRising+E   j
                movea.w $48(a5),a0
                subi.l  #$800,$18(a0)
                addi.l  #$6800,$1C(a5)
                lea     word_50874(pc),a1
                nop
                bsr.w   Boss_WolfGaropaShootPattern6
                tst.w   $58(a5)
                bpl.w   Boss_WolfGaropaShootPattern5
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                tst.w   (word_FF8200).w
                beq.s   loc_501F8
                subq.w  #1,$11C(a5)
                bpl.s   loc_501FE
loc_501F8:                                              ; CODE XREF: Boss_WolfGaropaRising+4A   j
                bclr    #2,$41C(a5)
loc_501FE:                                              ; CODE XREF: Boss_WolfGaropaRising+50   j
                move.w  #2,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #7,$23E(a5)
                movea.w #(byte_FFCF20-M68K_RAM),a0
                bra.w   loc_4FF7A
; End of function Boss_WolfGaropaRising
; Simple wrapper to call Boss_WolfGaropaShootPattern6
Boss_WolfGaropaShootOnly:
                bsr.w   Boss_WolfGaropaShootPattern6    ; was: sub_5021C
; End of function Boss_WolfGaropaShootOnly
; Shooting pattern 5
