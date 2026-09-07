Boss_GustheadTentacleInit:                              ; DATA XREF: ROM:off_4012C   o  ; was: sub_40132
                addq.w  #2,4(a5)
                ori.w   #$100,2(a5)
                lea     (word_1B514).l,a1
                move.w  $4E(a5),d0
                andi.w  #$1FE,d0
                move.w  (a1,d0.w),d1
                move.w  -$80(a1,d0.w),d2
                ext.l   d1
                lsl.l   #2,d1
                move.l  d1,$18(a5)
                ext.l   d2
                lsl.l   #3,d2
                tst.l   d2
                bmi.s   loc_40164
                neg.l   d2
loc_40164:                                              ; CODE XREF: Boss_GustheadTentacleInit+2E   j
                move.l  d2,$1C(a5)
                rts
; End of function Boss_GustheadTentacleInit
; Updates vertical velocity and transitions boss state after reaching Y position threshold
Boss_GustheadBounceTransition:                          ; DATA XREF: ROM:0004012E   o  ; was: sub_4016A
                addi.l  #$1000,$1C(a5)
                cmpi.w  #$150,$14(a5)
                blt.s   locret_40196
                clr.l   $1C(a5)
                clr.l   $18(a5)
                jsr     (Enemy_GetEntityAddress).l
                move.l  #off_1A0E96,8(a5)
                move.w  #$4000,$E(a5)
locret_40196:                                           ; CODE XREF: Boss_GustheadBounceTransition+E   j
                rts
; End of function Boss_GustheadBounceTransition
nullsub_81:                                             ; DATA XREF: ROM:00040130   o
                rts
; End of function nullsub_81

; Boss core defeat state
Boss_GustheadCoreDefeat:                                ; CODE XREF: Boss_GustheadTentacleDefeat+C   p  ; was: sub_4019A
                                        ; Boss_GustheadDefeatPhase1+C   p
                tst.l   (dword_FF9428).w
                beq.w   locret_4076C
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_4076C
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   locret_4076C
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0                         ; '?'
                bne.s   loc_401CC
                move.w  #$D1,d0
                jsr     (Sound_PlaySFX).l
loc_401CC:                                              ; CODE XREF: Boss_GustheadCoreDefeat+26   j
                move.w  #$1E4,(a0)
                move.l  #word_E91FA,8(a0)
                move.w  #$480,$E(a0)
                move.w  #$CC40,2(a0)
                move.b  #$7C,$20(a0)                    ; '|'
                move.w  #$100,$48(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                addi.w  #$F0,d0
                move.w  d0,$14(a0)
                move.l  (dword_FF9428).w,d0
                add.l   d0,d0
                move.l  d0,$18(a0)
                move.l  #$FFFFF000,$1C(a0)
                btst    #7,(dword_FF9428).w
                beq.s   loc_40226
                move.w  #$1C4,$10(a0)
                rts
; ---------------------------------------------------------------------------
loc_40226:                                              ; CODE XREF: Boss_GustheadCoreDefeat+82   j
                move.w  #$7C,$10(a0)                    ; '|'
                rts
; End of function Boss_GustheadCoreDefeat
; Main handler for Gusthead debris
Enemy_GustheadDebrisMain:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_4022E
                subq.w  #1,$48(a5)
                bmi.s   loc_40286
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   loc_40286
                cmpi.w  #$1E0,$10(a5)
                bhi.s   loc_40286
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcs.s   loc_40286
                cmpi.w  #$180,$14(a5)
                bhi.s   loc_40286
                move.l  (dword_FF9428).w,d0
                beq.s   loc_40274
                addq.b  #1,$4A(a5)
                btst    #0,$4A(a5)
                beq.s   loc_4026A
                add.l   d0,$18(a5)
loc_4026A:                                              ; CODE XREF: Enemy_GustheadDebrisMain+36   j
                addi.l  #$400,$1C(a5)
                bra.s   loc_4027C
; ---------------------------------------------------------------------------
loc_40274:                                              ; CODE XREF: Enemy_GustheadDebrisMain+2A   j
                addi.l  #$2000,$1C(a5)
loc_4027C:                                              ; CODE XREF: Enemy_GustheadDebrisMain+44   j
                move.l  $1C(a5),d0
                add.l   d0,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_40286:                                              ; CODE XREF: Enemy_GustheadDebrisMain+4   j
                                        ; Enemy_GustheadDebrisMain+C   j
                bset    #4,2(a5)
                rts
; End of function Enemy_GustheadDebrisMain
; Spawns falling debris projectiles
Boss_GustheadSpawnDebris:                               ; CODE XREF: Boss_GustheadDefeatPhase1+18   p  ; was: sub_4028E
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   locret_402EE
                tst.l   (dword_FF8240).w
                beq.s   locret_402EE
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_402EE
                move.w  #$1E8,(a0)
                move.w  #$ED00,2(a0)
                bsr.w   Enemy_GustheadDebrisSetSprite
                move.b  #$C0,$21(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #2,$24(a0)
                move.w  #8,$26(a0)
                move.b  #$10,$20(a0)
                move.w  #$F0,$14(a0)
                tst.l   (dword_FF8240).w
                bmi.s   loc_402F0
                move.w  #$78,$10(a0)                    ; 'x'
locret_402EE:                                           ; CODE XREF: Boss_GustheadSpawnDebris+8   j
                                        ; Boss_GustheadSpawnDebris+E   j
                rts
; ---------------------------------------------------------------------------
loc_402F0:                                              ; CODE XREF: Boss_GustheadSpawnDebris+58   j
                move.w  #$1C8,$10(a0)
                rts
; End of function Boss_GustheadSpawnDebris
; Sets random debris sprite
Enemy_GustheadDebrisSetSprite:                          ; CODE XREF: Boss_GustheadSpawnDebris+22   p  ; was: sub_402F8
                                        ; Boss_GustheadSpawnDebris4Way+46   p
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_40318(pc,d0.w),8(a0)
                move.w  #$8000,$E(a0)
                rts
; End of function Enemy_GustheadDebrisSetSprite
; ---------------------------------------------------------------------------
off_40318:      dc.l    off_1A0F1A                      ; DATA XREF: Enemy_GustheadDebrisSetSprite+12   r
                dc.l    off_1A0F42
                dc.l    off_1A0F2E
                dc.l    off_1A0F42

; Main physics handler for debris
Enemy_GustheadDebrisPhysicsMain:                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_40328
                tst.w   $24(a5)
                bmi.s   loc_4033E
                bclr    #7,$22(a5)
                beq.s   loc_40358
                bclr    #4,$22(a5)
                beq.s   loc_40342
loc_4033E:                                              ; CODE XREF: Enemy_GustheadDebrisPhysicsMain+4   j
                bra.w   Enemy_GustheadDebrisExplode
; ---------------------------------------------------------------------------
loc_40342:                                              ; CODE XREF: Enemy_GustheadDebrisPhysicsMain+14   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_40358:                                              ; CODE XREF: Enemy_GustheadDebrisPhysicsMain+C   j
                move.w  4(a5),d0
                lea     off_40364(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_GustheadDebrisPhysicsMain
; ---------------------------------------------------------------------------
off_40364:      dc.w    Enemy_GustheadDebrisInit-*      ; DATA XREF: Enemy_GustheadDebrisPhysicsMain+34   o
                dc.w    Enemy_GustheadDebrisUpdate-*
                dc.w    nullsub_82-*

; Initializes debris with velocity
Enemy_GustheadDebrisInit:                               ; DATA XREF: ROM:off_40364   o  ; was: sub_4036A
                addq.w  #2,4(a5)
                move.l  (dword_FF8240).w,d0
                add.l   d0,d0
                add.l   d0,d0
                tst.w   (word_FFFF0E).w
                bne.s   loc_4037E
                add.l   d0,d0
loc_4037E:                                              ; CODE XREF: Enemy_GustheadDebrisInit+10   j
                move.l  d0,$18(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FFF,d0
                subi.w  #$800,d0
                ext.l   d0
                move.l  d0,$4C(a5)
                rts
; End of function Enemy_GustheadDebrisInit
; Updates debris position with gravity
Enemy_GustheadDebrisUpdate:                             ; DATA XREF: ROM:00040366   o  ; was: sub_40396
                bsr.w   Enemy_GustheadDebrisFlip
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   loc_403CE
                cmpi.w  #$1E0,$10(a5)
                bhi.s   loc_403CE
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcs.s   loc_403CE
                cmpi.w  #$180,$14(a5)
                bhi.s   loc_403CE
                move.l  $4C(a5),d0
                add.l   d0,$1C(a5)
                btst    #7,$1C(a5)
                beq.w   Boss_GustheadDebrisGroundBounce
                rts
; ---------------------------------------------------------------------------
loc_403CE:                                              ; CODE XREF: Enemy_GustheadDebrisUpdate+A   j
                                        ; Enemy_GustheadDebrisUpdate+12   j
                bset    #4,2(a5)
                rts
; End of function Enemy_GustheadDebrisUpdate
nullsub_82:                                             ; DATA XREF: ROM:00040368   o
                rts
; End of function nullsub_82

; Flips debris sprite based on velocity
Enemy_GustheadDebrisFlip:                               ; CODE XREF: Enemy_GustheadDebrisUpdate   p  ; was: sub_403D8
                                        ; sub_4046C:loc_4049C   p
                btst    #7,$1C(a5)
                bne.s   loc_403E8
                ori.w   #$1000,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_403E8:                                              ; CODE XREF: Enemy_GustheadDebrisFlip+6   j
                andi.w  #$EFFF,$E(a5)
                rts
; End of function Enemy_GustheadDebrisFlip
; Spawns 4 debris projectiles with trajectories from angle table
Boss_GustheadSpawnDebris4Way:                           ; CODE XREF: Boss_GustheadBounceAttackLogic+2A   p  ; was: sub_403F0
                lea     (word_1B514).l,a1
                move.w  #3,d7
                move.w  #$120,d6
loc_403FE:                                              ; CODE XREF: Boss_GustheadSpawnDebris4Way+76   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4046A
                move.w  (a1,d6.w),d0
                ext.l   d0
                asl.l   #4,d0
                move.l  d0,$18(a0)
                move.l  #$FFFA0000,$1C(a0)
                move.w  #$214,(a0)
                move.w  #$ED40,2(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                addi.w  #$10,$14(a0)
                bsr.w   Enemy_GustheadDebrisSetSprite
                move.b  #$10,$20(a0)
                move.b  #$C0,$21(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #2,$24(a0)
                move.w  #$10,$26(a0)
                addi.w  #$40,d6                         ; '@'
                dbf     d7,loc_403FE
locret_4046A:                                           ; CODE XREF: Boss_GustheadSpawnDebris4Way+14   j
                rts
; End of function Boss_GustheadSpawnDebris4Way
; Updates debris physics with gravity, boundary checks, and collision detection
Boss_GustheadDebrisUpdate:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4046C
                tst.w   $24(a5)
                bmi.s   loc_40482
                bclr    #7,$22(a5)
                beq.s   loc_4049C
                bclr    #4,$22(a5)
                beq.s   loc_40486
loc_40482:                                              ; CODE XREF: Boss_GustheadDebrisUpdate+4   j
                bra.w   Enemy_GustheadDebrisExplode
; ---------------------------------------------------------------------------
loc_40486:                                              ; CODE XREF: Boss_GustheadDebrisUpdate+14   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_4049C:                                              ; CODE XREF: Boss_GustheadDebrisUpdate+C   j
                bsr.w   Enemy_GustheadDebrisFlip
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   loc_404D4
                cmpi.w  #$1E0,$10(a5)
                bhi.s   loc_404D4
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcs.s   loc_404D4
                cmpi.w  #$180,$14(a5)
                bhi.s   loc_404D4
                addi.l  #$2000,$1C(a5)
                btst    #7,$1C(a5)
                beq.w   Boss_GustheadDebrisGroundBounce
                rts
; ---------------------------------------------------------------------------
loc_404D4:                                              ; CODE XREF: Boss_GustheadDebrisUpdate+3A   j
                                        ; Boss_GustheadDebrisUpdate+42   j
                bset    #4,2(a5)
                rts
; End of function Boss_GustheadDebrisUpdate
; Clears debris velocity and resets animation state
Boss_GustheadDebrisReset:
                clr.l   $18(a5)                         ; was: sub_404DC
                clr.l   $1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp     Enemy_GetEntityAddress
; End of function Boss_GustheadDebrisReset
; Checks ground collision and applies upward bounce velocity to debris
Boss_GustheadDebrisGroundBounce:                        ; CODE XREF: Enemy_GustheadDebrisUpdate+32   j  ; was: sub_404F2
                                        ; Boss_GustheadDebrisUpdate+62   j
                cmpi.w  #$150,$14(a5)
                blt.s   locret_4051A
                move.l  #off_1A0E96,8(a5)
                jsr     (Enemy_GetEntityAddress).l
                move.w  #$C000,$E(a5)
                move.l  #$FFFD8000,$1C(a5)
                clr.w   $18(a5)
locret_4051A:                                           ; CODE XREF: Boss_GustheadDebrisGroundBounce+6   j
                rts
; End of function Boss_GustheadDebrisGroundBounce
; Updates boss rotation animation
Boss_GustheadUpdateRotation:                            ; CODE XREF: Boss_GustheadDefeatComplete+A2   p  ; was: sub_4051C
                movea.w a5,a0
                clr.w   d0
                move.b  $20(a0),d0
                addi.w  #2,d0
                andi.w  #$7F,d0
                subi.w  #$20,d0                         ; ' '
                andi.w  #$3C,d0                         ; '<'
                move.l  off_4054A(pc,d0.w),8(a0)
                clr.w   $C(a0)
                lsr.w   #1,d0
                lea     (word_FF9502).w,a1
                addq.w  #1,(a1,d0.w)
                rts
; End of function Boss_GustheadUpdateRotation
; ---------------------------------------------------------------------------
off_4054A:      dc.l    word_EC010                      ; DATA XREF: Boss_GustheadUpdateRotation+18   r
                dc.l    word_EC010
                dc.l    word_EC010
                dc.l    word_EC016
                dc.l    word_EC016
                dc.l    word_EC01C
                dc.l    word_EC01C
                dc.l    word_EC022
                dc.l    word_EC022
                dc.l    word_EC028
                dc.l    word_EC028
                dc.l    word_EC02E
                dc.l    word_EC02E
                dc.l    word_EC034
                dc.l    word_EC034
                dc.l    word_EC034

; Updates scroll based on boss movement
Boss_GustheadUpdateScroll:                              ; CODE XREF: Boss_GustheadTentacleDefeat+8   p  ; was: sub_4058A
                                        ; Boss_GustheadDefeatPhase1+8   p
                move.l  (dword_FF940C).w,d0
                bne.s   loc_40596
                move.l  (dword_FF9414).w,d0
                beq.s   loc_405A2
loc_40596:                                              ; CODE XREF: Boss_GustheadUpdateScroll+4   j
                tst.w   (word_FFFF0E).w
                bne.s   loc_405A0
                asr.l   #5,d0
                bra.s   loc_405A2
; ---------------------------------------------------------------------------
loc_405A0:                                              ; CODE XREF: Boss_GustheadUpdateScroll+10   j
                asr.l   #4,d0
loc_405A2:                                              ; CODE XREF: Boss_GustheadUpdateScroll+A   j
                                        ; Boss_GustheadUpdateScroll+14   j
                move.l  d0,(dword_FF8240).w
                rts
; End of function Boss_GustheadUpdateScroll
; Updates tentacle positions
Boss_GustheadUpdateTentacles:                           ; CODE XREF: Boss_GustheadIntroReveal+48   p  ; was: sub_405A8
                                        ; Boss_GustheadBattleStart+20   p
                tst.l   (dword_FF940C).w
                beq.s   loc_405BC
                move.l  (dword_FF940C).w,d0
                add.l   d0,(dword_FF9400).w
                andi.w  #$1FF,(dword_FF9400).w
loc_405BC:                                              ; CODE XREF: Boss_GustheadUpdateTentacles+4   j
                tst.l   (dword_FF9410).w
                beq.s   loc_405D0
                move.l  (dword_FF9410).w,d0
                add.l   d0,(dword_FF9404).w
                andi.w  #$1FF,(dword_FF9404).w
loc_405D0:                                              ; CODE XREF: Boss_GustheadUpdateTentacles+18   j
                tst.l   (dword_FF9414).w
                beq.s   locret_405E4
                move.l  (dword_FF9414).w,d0
                add.l   d0,(dword_FF9408).w
                andi.w  #$1FF,(dword_FF9408).w
locret_405E4:                                           ; CODE XREF: Boss_GustheadUpdateTentacles+2C   j
                rts
; End of function Boss_GustheadUpdateTentacles
; Sets tentacle sprite priority value to 0
Boss_GustheadTentaclesClearPriority:
                clr.w   d0                              ; was: sub_405E6
                bra.s   loc_405EE
; End of function Boss_GustheadTentaclesClearPriority
; Sets sprite priority for all 4 tentacle segments
Boss_GustheadTentaclesSetPriority:
                move.w  #2,d0                           ; was: sub_405EA
loc_405EE:                                              ; CODE XREF: Boss_GustheadTentaclesClearPriority+2   j
                move.w  #3,d7
                movea.l (Entity_ObjectPool).w,a0
                lea     $60(a0),a0
loc_405FA:                                              ; CODE XREF: Boss_GustheadTentaclesSetPriority+18   j
                move.w  d0,4(a0)
                lea     $60(a0),a0
                dbf     d7,loc_405FA
                rts
; End of function Boss_GustheadTentaclesSetPriority
; Updates sine/cosine angle offsets for tentacle animation
Boss_GustheadTentaclesUpdateAngles:
                move.w  #3,d7                           ; was: sub_40608
                movea.w (Entity_ObjectPool).w,a0
                lea     $60(a0),a0
loc_40614:                                              ; CODE XREF: Boss_GustheadTentaclesUpdateAngles+4C   j
                clr.w   d0
                move.b  $4B(a0),d0
                add.w   d0,d0
                add.w   (dword_FF9400).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$4E(a0)
                clr.w   d0
                move.b  $4C(a0),d0
                add.w   d0,d0
                add.w   (dword_FF9404).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$50(a0)
                clr.w   d0
                move.b  $4C(a0),d0
                add.w   d0,d0
                add.w   (dword_FF9408).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$52(a0)
                lea     $60(a0),a0
                dbf     d7,loc_40614
                rts
; End of function Boss_GustheadTentaclesUpdateAngles
; Updates tentacle rotation angles
Boss_GustheadUpdateTentacleAngles:                      ; CODE XREF: Boss_GustheadIntroReveal+4C   p  ; was: sub_4065A
                                        ; Boss_GustheadBattleStart+24   p
                move.l  $10(a5),$670(a5)
                move.l  $14(a5),$674(a5)
                addi.w  #$1A,$670(a5)
                addi.w  #-6,$674(a5)
                move.w  #4,$5C(a5)
                movea.w a5,a0
                lea     $60(a0),a0
loc_4067E:                                              ; CODE XREF: Boss_GustheadUpdateTentacleAngles+10E   j
                move.w  #3,d0
                movea.w a5,a1
loc_40684:                                              ; CODE XREF: Boss_GustheadUpdateTentacleAngles+106   j
                lea     (word_1B514).l,a2
                move.w  $48(a0),d4
                move.w  $4E(a0),d5
                move.w  $50(a0),d6
                move.w  $52(a0),d7
                andi.w  #$1FE,d5
                andi.w  #$1FE,d6
                andi.w  #$1FE,d7
                move.w  -$80(a2,d5.w),d1
                muls.w  d4,d1
                swap    d1
                add.w   d1,d1
                add.w   d1,d1
                move.w  (a2,d6.w),d2
                muls.w  d2,d1
                swap    d1
                add.w   d1,d1
                add.w   d1,d1
                asr.w   #2,d1
                cmpi.w  #$3F,d1                         ; '?'
                blt.s   loc_406CC
                move.w  #$3F,d1                         ; '?'
                bra.s   loc_406D6
; ---------------------------------------------------------------------------
loc_406CC:                                              ; CODE XREF: Boss_GustheadUpdateTentacleAngles+6A   j
                cmpi.w  #$FFC1,d1
                bgt.s   loc_406D6
                move.w  #$FFC1,d1
loc_406D6:                                              ; CODE XREF: Boss_GustheadUpdateTentacleAngles+70   j
                                        ; Boss_GustheadUpdateTentacleAngles+76   j
                clr.w   d2
                move.b  $20(a1),d2
                add.w   d2,d1
                move.b  d1,$20(a0)
                move.w  (a2,d5.w),d1
                move.w  (a2,d7.w),d2
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                move.l  d2,d3
                move.w  -$80(a2,d5.w),d1
                move.w  -$80(a2,d6.w),d2
                muls.w  d1,d2
                swap    d2
                add.w   d2,d2
                add.w   d2,d2
                move.w  -$80(a2,d7.w),d1
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                sub.l   d2,d3
                swap    d3
                muls.w  d4,d3
                add.l   d3,d3
                add.l   d3,d3
                add.l   $10(a1),d3
                move.l  d3,$10(a0)
                move.w  (a2,d5.w),d1
                move.w  -$80(a2,d7.w),d2
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                move.l  d2,d3
                move.w  -$80(a2,d5.w),d1
                move.w  -$80(a2,d6.w),d2
                muls.w  d1,d2
                swap    d2
                add.w   d2,d2
                add.w   d2,d2
                move.w  (a2,d7.w),d1
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                add.l   d2,d3
                swap    d3
                muls.w  d4,d3
                add.l   d3,d3
                add.l   d3,d3
                add.l   $14(a1),d3
                move.l  d3,$14(a0)
                lea     (a0),a1
                lea     $60(a0),a0
                dbf     d0,loc_40684
                subq.w  #1,$5C(a5)
                bne.w   loc_4067E
locret_4076C:                                           ; CODE XREF: Boss_GustheadInitBattle+4   j
                                        ; Boss_GustheadTentacleDamage+56   j
                rts
; End of function Boss_GustheadUpdateTentacleAngles
; Debris explosion with particle spawn
Enemy_GustheadDebrisExplode:                            ; CODE XREF: Enemy_GustheadDebrisPhysicsMain:loc_4033E   j  ; was: sub_4076E
                                        ; sub_4046C:loc_40482   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_40798
                jsr     (Projectile_InitType88).l
                move.l  #off_E95DC,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
loc_40798:                                              ; CODE XREF: Enemy_GustheadDebrisExplode+E   j
                jmp     Sprite_SetPointerClearD7
; End of function Enemy_GustheadDebrisExplode
; Main handler for Snake boss
