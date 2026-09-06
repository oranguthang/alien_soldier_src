Boss_DestroyerProtoGfxUpdate:                              ; CODE XREF: Boss_DestroyerProtoMain+6   p  ; was: sub_31540
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_30BB8
                move.w  (dword_FF9400).w,d0
                addq.w  #2,d0
                cmpi.w  #$14,d0
                bcs.s   loc_3155A
                clr.w   d0
loc_3155A:                              ; CODE XREF: Boss_DestroyerProtoGfxUpdate+16   j
                move.w  d0,(dword_FF9400).w
                move.w  word_3156C(pc,d0.w),(word_FFE366).w
                move.w  word_31580(pc,d0.w),(word_FFE368).w
                rts
; End of function Boss_DestroyerProtoGfxUpdate
; ---------------------------------------------------------------------------
word_3156C:     dc.w $2C8, $A6, $84, $62, $40, $20, $40, $62, $84, $A6
                                        ; DATA XREF: Boss_DestroyerProtoGfxUpdate+1E   r
word_31580:     dc.w $64, $44, $42, $22, $20, 0, $20, $22, $42, $44
                                        ; DATA XREF: Boss_DestroyerProtoGfxUpdate+24   r


; Intro animation init
Boss_DestroyerProtoIntroInit:                              ; DATA XREF: ROM:off_3150E   o  ; was: sub_31594
                clr.w   (dword_FF9414+2).w
                move.w  #$E0,$14(a5)
                move.w  #$200,$10(a5)
                bsr.w Boss_DestroyerProtoBounds
                tst.w   (word_FFF720).w
                bmi.w   locret_30BB8
                move.b  #4,(byte_FFA95A).w
                move.b  #$50,$21(a5) ; 'P'
                move.b  #$98,$23(a5)
                move.w  #$18,$24(a5)
                move.w  #$4C00,2(a5)
                move.l  #$E020E020,$2C(a5)
                move.l  #$D030D030,$28(a5)
                move.w  #$8C,$26(a5)
                movea.l #word_316AE,a0
                jsr (Gfx_LoadCompressedTiles).l
                addq.w  #2,4(a5)
                movea.w a5,a4
                move.w  #5,d6
loc_315FA:                              ; CODE XREF: Boss_DestroyerProtoIntroInit+DC   j
                adda.w  #$60,a4 ; '`'
                move.w  $10(a5),$10(a4)
                move.w  $14(a5),$14(a4)
                move.w  #$CC00,2(a4)
                move.w  #$3B8,(a4)
                move.w  #$6300,$E(a4)
                move.b  #$30,$20(a4) ; '0'
                move.b  #$C0,$21(a4)
                move.b  #$10,$23(a4)
                move.l  #$FC04FC04,$2C(a4)
                move.l  #$F010F010,$28(a4)
                move.w  #$3C,$26(a4) ; '<'
                move.w  d6,d0
                lsl.w   #1,d0
                move.w  word_31676(pc,d0.w),$40(a4)
                move.w  $40(a4),$46(a4)
                move.w  word_31682(pc,d0.w),$42(a4)
                move.w  word_3168E(pc,d0.w),$44(a4)
                move.w  word_3169A(pc,d0.w),d0
                move.w  d0,$48(a4)
                subq.w  #2,d0
                lsl.w   #1,d0
                move.l  off_316A6(pc,d0.w),8(a4)
                dbf     d6,loc_315FA
                rts
; End of function Boss_DestroyerProtoIntroInit
; ---------------------------------------------------------------------------
word_31676:     dc.w $40, $40, $40, $140, $140, $140
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+B2   r
word_31682:     dc.w $A0, $40, $E0, $A0, $40, $E0
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+BE   r
                                        ; Boss_DestroyerProtoTurretOpen+4   o
word_3168E:     dc.w $C800, $C7A0, $C620, $C6E0, $C680, $C620
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+C4   r
word_3169A:     dc.w 4, 2, 2, 4, 2, 2   ; DATA XREF: Boss_DestroyerProtoIntroInit+CA   r
off_316A6:      dc.l word_ECF70         ; DATA XREF: Boss_DestroyerProtoIntroInit+D6   r
                dc.l word_ECF04
word_316AE:     dc.w $4000, $2000, $303, $5051, $5253, $5455, $5657, $5859, $5A5B, $5C5D, $5E5F
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+50   o


; Intro movement
Boss_DestroyerProtoIntroMove:                              ; DATA XREF: ROM:00031510   o  ; was: sub_316C4
                bsr.w Boss_DestroyerProtoCollision
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w Boss_DestroyerProtoVelocity
                subi.w  #2,$18(a5)
                bsr.w Boss_DestroyerProtoBounds
                cmpi.w  #$160,$10(a5)
                bcc.w   locret_30BB8
                move.w  #3,d0
                jsr (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoIntroMove
; Boss collision handler
Boss_DestroyerProtoCollision:                              ; CODE XREF: Boss_DestroyerProtoIntroMove   p  ; was: sub_316F8
                                        ; sub_317FE   p ...
                addq.w  #8,$40(a5)
                andi.w  #$1FE,$40(a5)
                move.w  $40(a5),d0
                bsr.w Enemy_GustheadGetAngleToPlayer
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a5)
                ext.l   d1
                asl.l   #2,d1
                move.l  d1,$1C(a5)
                rts
; End of function Boss_DestroyerProtoCollision
; Boss boundary check
Boss_DestroyerProtoBounds:                              ; CODE XREF: Boss_DestroyerProtoIntroInit+10   p  ; was: sub_3171C
                                        ; Boss_DestroyerProtoIntroMove+16   p ...
                move.w  #$2C0,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA900).w
                move.w  $14(a5),d0
                subi.w  #$C0,d0
                move.w  d0,(dword_FFA904).w
                rts
; End of function Boss_DestroyerProtoBounds
; Boss velocity handler
Boss_DestroyerProtoVelocity:                              ; CODE XREF: Boss_DestroyerProtoIntroMove+C   p  ; was: sub_31736
                                        ; Boss_DestroyerProtoState3+C   p ...
                lea     (word_FFC680).w,a4
                bsr.w Boss_DestroyerProtoState1
                lea     (word_FFC6E0).w,a4
                bsr.w Boss_DestroyerProtoState1
                lea     (word_FFC7A0).w,a4
                bsr.w Boss_DestroyerProtoState1
                lea     (word_FFC800).w,a4
                bsr.w Boss_DestroyerProtoState1
                lea     (word_FFC740).w,a4
                bsr.w Boss_DestroyerProtoState2
                lea     (word_FFC860).w,a4
                bsr.w Boss_DestroyerProtoState2
                rts
; End of function Boss_DestroyerProtoVelocity
; Boss state handler 1
Boss_DestroyerProtoState1:                              ; CODE XREF: Boss_DestroyerProtoVelocity+4   p  ; was: sub_31768
                                        ; Boss_DestroyerProtoVelocity+C   p ...
                add.w   d0,$40(a4)
                andi.w  #$1FE,$40(a4)
                rts
; End of function Boss_DestroyerProtoState1
; Boss state handler 2
Boss_DestroyerProtoState2:                              ; CODE XREF: Boss_DestroyerProtoVelocity+24   p  ; was: sub_31774
                                        ; Boss_DestroyerProtoVelocity+2C   p ...
                add.w   d1,$40(a4)
                andi.w  #$1FE,$40(a4)
                add.w   d1,$46(a4)
                andi.w  #$1FE,$46(a4)
                rts
; End of function Boss_DestroyerProtoState2
; Close turret hatches
Boss_DestroyerProtoTurretClose:                              ; CODE XREF: Boss_DestroyerProtoAttack3+4   p  ; was: sub_3178A
                                        ; Boss_DestroyerProtoAttack4Retreat+4   p ...
                lea     (word_FFC680).w,a4
                move.w  #5,d0
loc_31792:                              ; CODE XREF: Boss_DestroyerProtoTurretClose+18   j
                tst.w   $42(a4)
                beq.s   loc_3179E
                subi.w  #8,$42(a4)
loc_3179E:                              ; CODE XREF: Boss_DestroyerProtoTurretClose+C   j
                adda.w  #$60,a4 ; '`'
                dbf     d0,loc_31792
                rts
; End of function Boss_DestroyerProtoTurretClose
; Open turret hatches
Boss_DestroyerProtoTurretOpen:                              ; CODE XREF: Boss_DestroyerProtoAttack2   p  ; was: sub_317A8
                                        ; sub_3198C   p ...
                lea     (word_FFC680).w,a4
                lea     word_31682(pc),a0
                move.w  #5,d0
loc_317B4:                              ; CODE XREF: Boss_DestroyerProtoTurretOpen+24   j
                move.w  d0,d1
                lsl.w   #1,d1
                move.w  (a0,d1.w),d2
                cmp.w   $42(a4),d2
                beq.s   loc_317C8
                addi.w  #8,$42(a4)
loc_317C8:                              ; CODE XREF: Boss_DestroyerProtoTurretOpen+18   j
                adda.w  #$60,a4 ; '`'
                dbf     d0,loc_317B4
                rts
; End of function Boss_DestroyerProtoTurretOpen
; Synchronizes rotation angles across multiple Destroyer Proto boss parts using base angle and offset
Boss_DestroyerSyncPartAngles:                              ; CODE XREF: Boss_DestroyerProtoAttack4Retreat+20   p  ; was: sub_317D2
                                        ; Boss_DestroyerProtoAttack5Retreat+20   p ...
                move.w  (word_FFC6C0).w,d2
                move.w  d2,d3
                addi.w  #$100,d3
                andi.w  #$1FE,d3
                move.w  d2,(word_FFC720).w
                move.w  d2,(word_FFC780).w
                move.w  d2,(word_FFC786).w
                move.w  d3,(word_FFC7E0).w
                move.w  d3,(word_FFC840).w
                move.w  d3,(word_FFC8A0).w
                move.w  d3,(word_FFC8A6).w
                rts
; End of function Boss_DestroyerSyncPartAngles
; Boss state handler 3
Boss_DestroyerProtoState3:                              ; DATA XREF: ROM:00031512   o  ; was: sub_317FE
                bsr.w Boss_DestroyerProtoCollision
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w Boss_DestroyerProtoVelocity
                bsr.w Boss_DestroyerProtoBounds
                tst.w   (word_FF80C2).w
                bne.w   locret_30BB8
                clr.b   (byte_FF80EC).w
                andi.b  #$EF,$23(a5)
                move.w  #$20,$4A(a5) ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoState3
; Attack pattern 1
Boss_DestroyerProtoAttack1:                              ; DATA XREF: ROM:00031514   o  ; was: sub_31830
                bsr.w Boss_DestroyerProtoCollision
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w Boss_DestroyerProtoVelocity
                bsr.w Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
loc_3184C:                              ; CODE XREF: Boss_DestroyerProtoAttack4Retreat+24   j
                                        ; Boss_DestroyerProtoAttack5Retreat+24   j ...
                jsr     (RandomNumber).l
                andi.w  #$1C,d0
                move.w  d0,$54(a5)
                move.w  word_3188C(pc,d0.w),d1
                sub.w   $10(a5),d1
                swap    d1
                clr.w   d1
                asr.l   #7,d1
                move.l  d1,$4C(a5)
                move.w  word_3188C+2(pc,d0.w),d1
                sub.w   $14(a5),d1
                swap    d1
                clr.w   d1
                asr.l   #7,d1
                move.l  d1,$50(a5)
                move.w  #$80,$4A(a5)
                move.w  #8,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack1
; ---------------------------------------------------------------------------
word_3188C:     dc.w $C0, $C0, $120, $C0, $180, $C0, $C0, $F8, $180, $F8, $C0, $130, $120, $130, $180, $130
                                        ; DATA XREF: Boss_DestroyerProtoAttack1+2A   r
                                        ; Boss_DestroyerProtoAttack1+3C   r


; Attack pattern 2
Boss_DestroyerProtoAttack2:                              ; DATA XREF: ROM:00031516   o  ; was: sub_318AC
                bsr.w Boss_DestroyerProtoTurretOpen
                bsr.w Boss_DestroyerProtoCollision
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w Boss_DestroyerProtoVelocity
                bsr.w Boss_DestroyerProtoBounds
                move.l  $4C(a5),d0
                add.l   d0,$18(a5)
                move.l  $50(a5),d0
                add.l   d0,$1C(a5)
                bsr.w Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$1C,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack2
; Attack pattern 3
Boss_DestroyerProtoAttack3:                              ; DATA XREF: ROM:00031518   o  ; was: sub_318EC
                bsr.w Boss_DestroyerProtoCollision
                bsr.w Boss_DestroyerProtoTurretClose
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w Boss_DestroyerProtoVelocity
                bsr.w Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jsr     (RandomNumber).l
                andi.w  #3,d0
                beq.s   loc_3197E
                cmpi.w  #1,d0
                beq.w Boss_DestroyerProtoAttack6Aim
                jsr (Math_CalculateAngleToPlayer).l
                addi.w  #$10,d2
                andi.w  #$1E0,d2
                move.w  d2,(word_FFC780).w
                move.w  d2,(word_FFC786).w
                move.w  d2,(word_FFC8A0).w
                move.w  d2,(word_FFC8A6).w
                jsr     (RandomNumber).l
                andi.w  #$60,d0 ; '`'
                addi.w  #$20,d0 ; ' '
                sub.w   d0,d2
                andi.w  #$1FE,d2
                move.w  d2,(word_FFC6C0).w
                move.w  d2,(word_FFC720).w
                add.w   d0,d2
                add.w   d0,d2
                andi.w  #$1FE,d2
                move.w  d2,(word_FFC7E0).w
                move.w  d2,(word_FFC840).w
                move.w  #$1C,$4A(a5)
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_3197E:                              ; CODE XREF: Boss_DestroyerProtoAttack3+32   j
                move.w  #$1C,$4A(a5)
                move.w  #$16,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack3
; Waits for turret open animation during attack 4
Boss_DestroyerProtoAttack4Wait:                              ; DATA XREF: ROM:0003151A   o  ; was: sub_3198C
                bsr.w Boss_DestroyerProtoTurretOpen
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack4Wait
; Rises upward with palette fade during attack phase
Boss_DestroyerProtoAttack4Rise:                              ; DATA XREF: ROM:0003151C   o  ; was: sub_3199E
                move.w  #$2000,d7
                bsr.w Boss_DestroyerProtoApplyPaletteFade
                bsr.w Boss_DestroyerProtoBounds
                addq.w  #1,$4A(a5)
                cmpi.w  #$E,$4A(a5)
                bne.w   locret_30BB8
                bsr.w Boss_JetsripperSpawnProjectiles
                move.b  #$EA,d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack4Rise
; Descends downward with palette fade during attack phase
Boss_DestroyerProtoAttack4Descend:                              ; DATA XREF: ROM:0003151E   o  ; was: sub_319CC
                move.w  #$2000,d7
                bsr.w Boss_DestroyerProtoApplyPaletteFade
                bsr.w Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$20,$4A(a5) ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack4Descend
; Delays before next attack phase
Boss_DestroyerProtoAttack4Delay:                              ; DATA XREF: ROM:00031520   o  ; was: sub_319EC
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$1C,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack4Delay
; Retreats with velocity and collision after attack
Boss_DestroyerProtoAttack4Retreat:                              ; DATA XREF: ROM:00031522   o  ; was: sub_31A00
                bsr.w Boss_DestroyerProtoCollision
                bsr.w Boss_DestroyerProtoTurretClose
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w Boss_DestroyerProtoVelocity
                bsr.w Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                bsr.w Boss_DestroyerSyncPartAngles
                bra.w   loc_3184C
; End of function Boss_DestroyerProtoAttack4Retreat
; Attack pattern 4
Boss_DestroyerProtoAttack4:                              ; DATA XREF: ROM:00031524   o  ; was: sub_31A28
                bsr.w Boss_DestroyerProtoTurretOpen
                move.w  #$FFF8,d0
                move.w  #$20,d1 ; ' '
                bsr.w Boss_DestroyerProtoVelocity
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack4
; Shooting pattern 1
Boss_DestroyerProtoShootPattern1:                              ; DATA XREF: ROM:00031526   o  ; was: sub_31A46
                move.w  #$FFF8,d0
                move.w  #$20,d1 ; ' '
                bsr.w Boss_DestroyerProtoVelocity
                move.w  #$8000,d7
                bsr.w Boss_DestroyerProtoApplyPaletteFade
                addq.w  #1,$4A(a5)
                cmpi.w  #$E,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$80,$4A(a5)
                move.b  #$56,d0 ; 'V'
                jsr (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoShootPattern1
; Shooting pattern 2
Boss_DestroyerProtoShootPattern2:                              ; DATA XREF: ROM:00031528   o  ; was: sub_31A7E
                move.w  #$FFF8,d0
                move.w  #$20,d1 ; ' '
                bsr.w Boss_DestroyerProtoVelocity
                bsr.w Boss_DestroyerProtoShootPattern3
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$E,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoShootPattern2
; Shooting pattern 3
Boss_DestroyerProtoShootPattern3:                              ; CODE XREF: Boss_DestroyerProtoShootPattern2+C   p  ; was: sub_31AA2
                move.w  $4A(a5),d0
                andi.w  #1,d0
                bne.w   locret_30BB8
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                lea     word_31FF8(pc),a1
                nop
                lea     word_32038(pc),a2
                nop
                move.w  $4A(a5),d0
                andi.w  #$E,d0
                lsl.w   #2,d0
                move.w  $4A(a5),d1
                andi.w  #$10,d1
                lsr.w   #2,d1
                add.w   d1,d0
                move.w  (a1,d0.w),$18(a0)
                move.w  (a2,d0.w),$1C(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$3B8,(a0)
                jsr     (RandomNumber).l
                andi.w  #$F,d0
                beq.s   loc_31B3C
loc_31B02:                              ; CODE XREF: Projectile_Stage14BulletMove+2E   p
                                        ; Projectile_Stage14BulletMove+4E   p
                move.w  #$EC00,2(a0)
                move.l  #off_E96E0,8(a0)
                clr.w   $C(a0)
                move.w  #$8480,$E(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  #$FC04FC04,$2C(a0)
                move.w  #$46,$26(a0) ; 'F'
                move.w  #8,$48(a0)
                move.w  #0,4(a0)
                rts
; ---------------------------------------------------------------------------
loc_31B3C:                              ; CODE XREF: Boss_DestroyerProtoShootPattern3+5E   j
                move.w  #$CC00,2(a0)
                move.l  #word_1CEC90,8(a0)
                move.w  #$400,$E(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  #$F010F010,$2C(a0)
                move.w  #$64,$26(a0) ; 'd'
                move.w  #6,$48(a0)
                move.w  #8,4(a0)
                rts
; End of function Boss_DestroyerProtoShootPattern3
; Rises downward-left with palette fade for attack 5
Boss_DestroyerProtoAttack5Rise:                              ; DATA XREF: ROM:0003152A   o  ; was: sub_31B72
                move.w  #$FFF8,d0
                move.w  #$20,d1 ; ' '
                bsr.w Boss_DestroyerProtoVelocity
                move.w  #$8000,d7
                bsr.w Boss_DestroyerProtoApplyPaletteFade
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$1C,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack5Rise
; Retreats downward-left with collision after attack 5
Boss_DestroyerProtoAttack5Retreat:                              ; DATA XREF: ROM:0003152C   o  ; was: sub_31B9A
                bsr.w Boss_DestroyerProtoCollision
                bsr.w Boss_DestroyerProtoTurretClose
                move.w  #$FFF8,d0
                move.w  #$20,d1 ; ' '
                bsr.w Boss_DestroyerProtoVelocity
                bsr.w Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                bsr.w Boss_DestroyerSyncPartAngles
                bra.w   loc_3184C
; End of function Boss_DestroyerProtoAttack5Retreat
; Calculates angles to player for multi-turret aim
Boss_DestroyerProtoAttack6Aim:                              ; CODE XREF: Boss_DestroyerProtoAttack3+38   j  ; was: sub_31BC2
                jsr (Math_CalculateAngleToPlayer).l
                addi.w  #$10,d2
                andi.w  #$1E0,d2
                move.w  d2,(word_FFC6C0).w
                move.w  d2,(word_FFC720).w
                move.w  d2,(word_FFC780).w
                move.w  d2,(word_FFC786).w
                move.w  d2,(word_FFC7E0).w
                move.w  d2,(word_FFC840).w
                move.w  d2,(word_FFC8A0).w
                move.w  d2,(word_FFC8A6).w
                move.w  #$1C,$4A(a5)
                move.w  #$20,4(a5) ; ' '
                rts
; End of function Boss_DestroyerProtoAttack6Aim
; Waits for turret open animation during attack 6
Boss_DestroyerProtoAttack6Wait:                              ; DATA XREF: ROM:0003152E   o  ; was: sub_31BFE
                bsr.w Boss_DestroyerProtoTurretOpen
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6Wait
; Prepares multi-shot attack with palette fade and spawn pointers
Boss_DestroyerProtoAttack6Prepare:                              ; DATA XREF: ROM:00031530   o  ; was: sub_31C10
                move.w  #$C000,d7
                bsr.w Boss_DestroyerProtoApplyPaletteFade
                addq.w  #1,$4A(a5)
                cmpi.w  #$E,$4A(a5)
                bne.w   locret_30BB8
                move.l  #$FFFFC8C0,$58(a5)
                move.l  #$FFFFCEC0,$5C(a5)
                move.w  #$10,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6Prepare
; Delays before multi-shot attack execution
Boss_DestroyerProtoAttack6Delay:                              ; DATA XREF: ROM:00031532   o  ; was: sub_31C42
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$41,$4A(a5) ; 'A'
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6Delay
; Executes multi-shot attack pattern spawning projectiles
Boss_DestroyerProtoAttack6Execute:                              ; DATA XREF: ROM:00031534   o  ; was: sub_31C56
                bsr.w Boss_DestroyerProtoUpdateTurretStates
                bsr.w Boss_DestroyerProtoSpawnDualShots
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$E,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6Execute
; Spawns dual projectiles from left and right turrets with sound
Boss_DestroyerProtoSpawnDualShots:                              ; CODE XREF: Boss_DestroyerProtoAttack6Execute+4   p  ; was: sub_31C72
                move.w  $4A(a5),d0
                cmpi.w  #$40,d0 ; '@'
                bcc.w   locret_30BB8
                cmpi.w  #$C,d0
                bcs.w   locret_30BB8
                andi.w  #3,d0
                bne.w   locret_30BB8
                lea     (word_FFC740).w,a4
                movea.l $58(a5),a0
                addi.l  #$60,$58(a5) ; '`'
                bsr.w Boss_DestroyerProtoInitProjectile
                move.b  #$CE,d0
                jsr (Sound_PlaySFX).l
                lea     (word_FFC860).w,a4
                movea.l $5C(a5),a0
                addi.l  #$60,$5C(a5) ; '`'
; End of function Boss_DestroyerProtoSpawnDualShots
; Initializes projectile position, animation, and properties
Boss_DestroyerProtoInitProjectile:                              ; CODE XREF: Boss_DestroyerProtoSpawnDualShots+2C   p  ; was: sub_31CBC
                bsr.w Boss_JetsripperInitProjectile
                move.l  $4C(a0),$18(a0)
                move.l  $50(a0),$1C(a0)
                move.w  $54(a0),d0
                lea     off_322C8(pc),a1
                nop
                move.l  (a1,d0.w),8(a0)
                lsr.w   #1,d0
                lea     word_320F8(pc),a1
                nop
                move.w  (a1,d0.w),$E(a0)
                move.w  #$CC00,2(a0)
                move.w  #2,4(a0)
                rts
; End of function Boss_DestroyerProtoInitProjectile
; Updates all six turret states during multi-shot attack
Boss_DestroyerProtoUpdateTurretStates:                              ; CODE XREF: Boss_DestroyerProtoAttack6Execute   p  ; was: sub_31CF8
                move.w  #2,d0
                lea     (word_FFC680).w,a4
                bsr.w Boss_DestroyerProtoState1
                move.w  #4,d0
                lea     (word_FFC6E0).w,a4
                bsr.w Boss_DestroyerProtoState1
                move.w  #8,d1
                lea     (word_FFC740).w,a4
                bsr.w Boss_DestroyerProtoState2
                move.w  #$FFFE,d0
                lea     (word_FFC7A0).w,a4
                bsr.w Boss_DestroyerProtoState1
                move.w  #$FFFC,d0
                lea     (word_FFC800).w,a4
                bsr.w Boss_DestroyerProtoState1
                move.w  #$FFF8,d1
                lea     (word_FFC860).w,a4
                bsr.w Boss_DestroyerProtoState2
                rts
; End of function Boss_DestroyerProtoUpdateTurretStates
; Fades out palette after multi-shot attack
Boss_DestroyerProtoAttack6FadeOut:                              ; DATA XREF: ROM:00031536   o  ; was: sub_31D42
                move.w  #$C000,d7
                bsr.w Boss_DestroyerProtoApplyPaletteFade
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$20,$4A(a5) ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6FadeOut
; Waits after palette fade before retreat
Boss_DestroyerProtoAttack6Wait2:                              ; DATA XREF: ROM:00031538   o  ; was: sub_31D5E
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$1C,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6Wait2
; Retreats with velocity and collision after attack 6
Boss_DestroyerProtoAttack6Retreat:                              ; DATA XREF: ROM:0003153A   o  ; was: sub_31D72
                bsr.w Boss_DestroyerProtoCollision
                bsr.w Boss_DestroyerProtoTurretClose
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w Boss_DestroyerProtoVelocity
                bsr.w Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                bsr.w Boss_DestroyerSyncPartAngles
                bra.w   loc_3184C
; End of function Boss_DestroyerProtoAttack6Retreat
; Spawns projectile type 1
Boss_DestroyerProtoSpawnProjectile1:                              ; DATA XREF: ROM:0003153C   o  ; was: sub_31D9A
                clr.b   $21(a5)
                movea.w a5,a4
                lea     word_31FF8(pc),a0
                nop
                lea     word_32038(pc),a1
                nop
                move.w  #5,d7
loc_31DB0:                              ; CODE XREF: Boss_DestroyerProtoSpawnProjectile1+3A   j
                adda.w  #$60,a4 ; '`'
                jsr     (RandomNumber).l
                andi.w  #$3C,d0 ; '<'
                move.l  (a0,d0.w),$18(a4)
                move.l  (a1,d0.w),$1C(a4)
                clr.b   $21(a4)
                move.w  #2,4(a4)
                dbf     d7,loc_31DB0
                move.w  #$100,$4A(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.b   (byte_FFA95A).w
                move.b  #3,(word_FFF7E6+1).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoSpawnProjectile1
; Spawns projectile type 2
Boss_DestroyerProtoSpawnProjectile2:                              ; CODE XREF: Boss_DestroyerProtoSpawnProjectile3   p  ; was: sub_31DF6
                jsr (Gfx_UpdatePaletteFade).l
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                jsr (Effect_PlayRandomExplosionSound).l
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                jsr (Projectile_InitType88).l
                clr.b   $20(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0 ; '?'
                andi.w  #$3F,d1 ; '?'
                subi.w  #$20,d0 ; ' '
                subi.w  #$20,d1 ; ' '
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
                move.w  (dword_FFFF08+2).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$1C(a0)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #7,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_31E7C(pc,d0.w),8(a0)
                ori.w   #$8000,$E(a0)
                rts
; End of function Boss_DestroyerProtoSpawnProjectile2
; ---------------------------------------------------------------------------
off_31E7C:      dc.l off_E953C          ; DATA XREF: Boss_DestroyerProtoSpawnProjectile2+78   r
                dc.l off_E95A4
                dc.l off_E9560
                dc.l off_E95C0
                dc.l off_E9584
                dc.l off_E95DC
                dc.l off_E9584
                dc.l off_E9604


; Spawns projectile type 3
Boss_DestroyerProtoSpawnProjectile3:                              ; DATA XREF: ROM:0003153E   o  ; was: sub_31E9C
                bsr.w Boss_DestroyerProtoSpawnProjectile2
                jsr Boss_DestroyerProtoPaletteFade(pc)   ; (pc)
                nop
                jsr Boss_DestroyerProtoRotateSprites(pc)   ; (pc)
                nop
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                movea.l #word_31EC8,a0
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #$1000,2(a5)
                rts
; End of function Boss_DestroyerProtoSpawnProjectile3
; ---------------------------------------------------------------------------
word_31EC8:     dc.w $4000, $4000, $303, 0, 0, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: Boss_DestroyerProtoSpawnProjectile3+18   o


; Rotates sprite angles in RAM for visual effect
Boss_DestroyerProtoRotateSprites:                              ; CODE XREF: Boss_DestroyerProtoSpawnProjectile3+A   p  ; was: sub_31EDE
                                        ; DATA XREF: Boss_DestroyerProtoSpawnProjectile3+A   o
                move.w  $4A(a5),d0
                cmpi.w  #$40,d0 ; '@'
                bcc.w   locret_30BB8
                andi.w  #1,d0
                bne.w   locret_30BB8
                lea     (word_FFE480).w,a0
                lea     word_31F28(pc),a1
                nop
                clr.w   d1
                move.w  #$BF,d0
loc_31F02:                              ; CODE XREF: Boss_DestroyerProtoRotateSprites+44   j
                move.w  (a0),d2
                andi.w  #$1FF,d2
                cmpi.w  #$140,d2
                bcs.s   loc_31F14
                cmpi.w  #$180,d2
                bcs.s   loc_31F1A
loc_31F14:                              ; CODE XREF: Boss_DestroyerProtoRotateSprites+2E   j
                add.w   (a1,d1.w),d2
                move.w  d2,(a0)
loc_31F1A:                              ; CODE XREF: Boss_DestroyerProtoRotateSprites+34   j
                addq.w  #4,a0
                addq.w  #2,d1
                andi.w  #$1E,d1
                dbf     d0,loc_31F02
                rts
; End of function Boss_DestroyerProtoRotateSprites
; ---------------------------------------------------------------------------
word_31F28:     dc.w 1, $FFFF           ; DATA XREF: Boss_DestroyerProtoRotateSprites+18   o
                dc.w 5, $FFFB
                dc.w 7, $FFF9
                dc.w 3, $FFFD
                dc.w 6, $FFFA
                dc.w 2, $FFFE
                dc.w 8, $FFF8
                dc.w 4, $FFFC


; Applies palette fade effect based on timer and fade direction
Boss_DestroyerProtoApplyPaletteFade:                              ; CODE XREF: Boss_DestroyerProtoAttack4Rise+4   p  ; was: sub_31F48
                                        ; Boss_DestroyerProtoAttack4Descend+4   p ...
                move.w  $4A(a5),d0
                andi.w  #$E,d0
                move.w  #$F,d5
                lea     (word_FFE360).w,a0
                jmp (Gfx_ApplyPaletteFade).l
; End of function Boss_DestroyerProtoApplyPaletteFade
; Palette fade effect
Boss_DestroyerProtoPaletteFade:                              ; CODE XREF: Boss_DestroyerProtoSpawnProjectile3+4   p  ; was: sub_31F5E
                                        ; DATA XREF: Boss_DestroyerProtoSpawnProjectile3+4   o
                cmpi.w  #$E,$4A(a5)
                bcc.w   locret_30BB8
                move.w  #$E000,d7
                move.w  #$F,d0
                sub.w   $4A(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5 ; '?'
                lea     (word_FFE300).w,a0
                jmp (Gfx_ApplyPaletteFade).l
; End of function Boss_DestroyerProtoPaletteFade
; Boss state handler 4
Boss_DestroyerProtoState4:                              ; DATA XREF: ROM:000314D0   o  ; was: sub_31F86
                tst.w   4(a5)
                bne.w Projectile_DestroyerProtoUpdate
; End of function Boss_DestroyerProtoState4
; Updates enemy position with bounds
Enemy_GustheadUpdatePosition:                              ; CODE XREF: Enemy_GustheadSmallEyeWait   p  ; was: sub_31F8E
                                        ; sub_31208   p ...
                movea.w $44(a5),a4
                move.w  $40(a5),d0
                bsr.w Enemy_GustheadGetAngleToPlayer
                move.w  $42(a5),d2
                muls.w  d2,d0
                add.l   $10(a4),d0
                move.l  d0,$10(a5)
                muls.w  d2,d1
                add.l   $14(a4),d1
                move.l  d1,$14(a5)
                rts
; End of function Enemy_GustheadUpdatePosition
; Boss state handler 5
Boss_DestroyerProtoState5:                              ; DATA XREF: ROM:000314D2   o  ; was: sub_31FB4
                tst.w   4(a5)
                bne.w   loc_31FEA
                bsr.w Enemy_GustheadUpdatePosition
loc_31FC0:                              ; CODE XREF: Boss_DestroyerProtoState5+3C   p
                move.w  $46(a5),d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                lsr.w   #3,d0
                lea     off_32118(pc),a0
                nop
                move.l  (a0,d0.w),8(a5)
                lsr.w   #1,d0
                lea     word_320F8(pc),a0
                nop
                move.w  (a0,d0.w),$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_31FEA:                              ; CODE XREF: Boss_DestroyerProtoState5+4   j
                addi.w  #$20,$46(a5) ; ' '
                bsr.w   loc_31FC0
                bra.w Projectile_DestroyerProtoUpdate
; End of function Boss_DestroyerProtoState5
; ---------------------------------------------------------------------------
word_31FF8:     dc.w 4, 0               ; DATA XREF: Boss_DestroyerProtoShootPattern3+16   o
                                        ; Boss_DestroyerProtoSpawnProjectile1+6   o ...
                dc.w 3, $8000
                dc.w 2, $D410
                dc.w 1, $C000
                dc.w 0, 0
                dc.w $FFFE, $4000
                dc.w $FFFD, $2BF0
                dc.w $FFFC, $8000
                dc.w $FFFC, 0
                dc.w $FFFC, $8000
                dc.w $FFFD, $2BF0
                dc.w $FFFE, $4000
                dc.w 0, 0
                dc.w 1, $C000
                dc.w 2, $D410
                dc.w 3, $8000
word_32038:     dc.w 0, 0               ; DATA XREF: Boss_DestroyerProtoShootPattern3+1C   o
                                        ; Boss_DestroyerProtoSpawnProjectile1+C   o ...
                dc.w 1, $C000
                dc.w 2, $D410
                dc.w 3, $8000
                dc.w 4, 0
                dc.w 3, $8000
                dc.w 2, $D410
                dc.w 1, $C000
                dc.w 0, 0
                dc.w $FFFE, $4000
                dc.w $FFFD, $2BF0
                dc.w $FFFC, $8000
                dc.w $FFFC, 0
                dc.w $FFFC, $8000
                dc.w $FFFD, $2BF0
                dc.w $FFFE, $4000
dword_32078:    dc.l $300000, $2AC000   ; DATA XREF: Boss_JetsripperInitProjectile+4C   o
                dc.l $21F0C0, $144000
                dc.l 0, $FFEBC000
                dc.l $FFDE0F40, $FFD54000
                dc.l $FFD00000, $FFD54000
                dc.l $FFDE0F40, $FFEBC000
                dc.l 0, $144000
                dc.l $21F0C0, $2AC000
dword_320B8:    dc.l 0, $144000         ; DATA XREF: Boss_JetsripperInitProjectile+68   o
                dc.l $21F0C0, $2AC000
                dc.l $300000, $2AC000
                dc.l $21F0C0, $144000
                dc.l 0, $FFEBC000
                dc.l $FFDE0F40, $FFD54000
                dc.l $FFD00000, $FFD54000
                dc.l $FFDE0F40, $FFEBC000
word_320F8:     dc.w $6B00, $6B00, $6B00, $6B00
                                        ; DATA XREF: Boss_DestroyerProtoInitProjectile+22   o
                                        ; Boss_DestroyerProtoState5+28   o ...
                dc.w $6300, $6300, $6300, $6300
                dc.w $7300, $7300, $7300, $7300
                dc.w $7B00, $7B00, $7B00, $7B00
off_32118:      dc.l word_ECF04         ; DATA XREF: Boss_DestroyerProtoState5+1A   o
                dc.l word_ECF16
                dc.l word_ECF28
                dc.l word_ECF40
                dc.l word_ECEF2
                dc.l word_ECF40
                dc.l word_ECF28
                dc.l word_ECF16
                dc.l word_ECF04
                dc.l word_ECF16
                dc.l word_ECF28
                dc.l word_ECF40
                dc.l word_ECEF2
                dc.l word_ECF40
                dc.l word_ECF28
                dc.l word_ECF16


; Spawns Jetsripper boss projectiles at two different RAM addresses
Boss_JetsripperSpawnProjectiles:                              ; CODE XREF: Boss_DestroyerProtoAttack4Rise+1A   p  ; was: sub_32158
                lea     (word_FFC740).w,a4
                lea     (word_FFC8C0).w,a0
                bsr.w Boss_JetsripperInitProjectile
                lea     (word_FFC860).w,a4
                lea     (word_FFCEC0).w,a0
; End of function Boss_JetsripperSpawnProjectiles
; Initializes Jetsripper boss projectile with position, velocity, and graphics data
Boss_JetsripperInitProjectile:                              ; CODE XREF: Boss_DestroyerProtoInitProjectile   p  ; was: sub_3216C
                                        ; Boss_JetsripperSpawnProjectiles+8   p
                move.w  #$EC00,word_FFCEC2-word_FFCEC0(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  #$F808F808,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$64,$26(a0) ; 'd'
                move.l  #off_E968C,8(a0)
                move.w  #$3B8,(a0)
                move.w  $40(a4),d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                lsr.w   #3,d0
                move.w  d0,$54(a0)
                lea     word_31FF8(pc),a1
                move.l  (a1,d0.w),d1
                move.l  d1,$4C(a0)
                lea     dword_32078(pc),a1
                move.l  (a1,d0.w),d1
                add.l   $10(a4),d1
                move.l  d1,$10(a0)
                lea     word_32038(pc),a1
                move.l  (a1,d0.w),d1
                move.l  d1,$50(a0)
                lea     dword_320B8(pc),a1
                move.l  (a1,d0.w),d1
                add.l   $14(a4),d1
                move.l  d1,$14(a0)
                move.b  #0,$20(a0)
                move.w  #$480,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a0)
                move.w  #6,$48(a0)
                move.w  #8,$4A(a0)
                clr.w   4(a0)
                rts
; End of function Boss_JetsripperInitProjectile
; Projectile main handler
Projectile_DestroyerProtoMain:                              ; DATA XREF: ROM:000314D4   o  ; was: sub_32208
                bsr.w Enemy_DeathExplode
                move.w  4(a5),d0
                lea     off_32218(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_DestroyerProtoMain
; ---------------------------------------------------------------------------
off_32218:      dc.w Boss_JetsripperProjectileSpreadInit-*        ; DATA XREF: Projectile_DestroyerProtoMain+8   o
                dc.w Projectile_DestroyerProtoUpdate-*
                dc.w Boss_JetsripperProjectileReturn-*
                dc.w Boss_JetsripperProjectileTurretCheck-*
                dc.w Boss_JetsripperProjectileBounce-*


; Creates spread pattern of 7 projectile copies with staggered delays
Boss_JetsripperProjectileSpreadInit:                              ; DATA XREF: ROM:off_32218   o  ; was: sub_32222
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.l  $4C(a5),$18(a5)
                move.l  $50(a5),$1C(a5)
                move.w  $54(a5),d0
                lea     off_322C8(pc),a0
                nop
                move.l  (a0,d0.w),8(a5)
                lsr.w   #1,d0
                lea     word_320F8(pc),a0
                move.w  (a0,d0.w),$E(a5)
                move.w  #$CC00,2(a5)
                movea.w a5,a4
                move.w  #6,d0
loc_3225E:                              ; CODE XREF: Boss_JetsripperProjectileSpreadInit+9C   j
                adda.w  #$60,a4 ; '`'
                move.w  #$CC00,2(a4)
                move.w  #$3B8,(a4)
                move.w  #6,$48(a4)
                move.w  #4,4(a4)
                move.l  $4C(a5),$4C(a4)
                move.l  $50(a5),$50(a4)
                move.l  8(a5),8(a4)
                move.w  $E(a5),$E(a4)
                move.b  $21(a5),$21(a4)
                move.l  $10(a5),$10(a4)
                move.l  $14(a5),$14(a4)
                move.l  $2C(a5),$2C(a4)
                move.l  $28(a5),$28(a4)
                move.w  #$64,$26(a4) ; 'd'
                move.w  d0,d1
                addq.w  #1,d1
                lsl.w   #2,d1
                move.w  d1,$4A(a4)
                dbf     d0,loc_3225E
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperProjectileSpreadInit
; ---------------------------------------------------------------------------
off_322C8:      dc.l word_ECF52         ; DATA XREF: Boss_DestroyerProtoInitProjectile+14   o
                                        ; Boss_JetsripperProjectileSpreadInit+18   o
                dc.l word_ECF58
                dc.l word_ECF5E
                dc.l word_ECF64
                dc.l word_ECF6A
                dc.l word_ECF64
                dc.l word_ECF5E
                dc.l word_ECF58
                dc.l word_ECF52
                dc.l word_ECF58
                dc.l word_ECF5E
                dc.l word_ECF64
                dc.l word_ECF6A
                dc.l word_ECF64
                dc.l word_ECF5E
                dc.l word_ECF58


; Handles projectile bounce behavior when collision flag is set
Boss_JetsripperProjectileBounce:                              ; DATA XREF: ROM:00032220   o  ; was: sub_32308
                bclr    #4,$22(a5)
                bne.s Boss_JetsripperProjectileReflect
                bra.s Projectile_DestroyerProtoUpdate
; End of function Boss_JetsripperProjectileBounce
; Updates projectile state and checks collision flag for turret mode
Boss_JetsripperProjectileTurretCheck:                              ; DATA XREF: ROM:0003221E   o  ; was: sub_32312
                bclr    #4,$22(a5)
                bne.s Enemy_Stage14TurretMain
; End of function Boss_JetsripperProjectileTurretCheck
; Projectile update handler
Projectile_DestroyerProtoUpdate:                              ; CODE XREF: Boss_DestroyerProtoState4+4   j  ; was: sub_3231A
                                        ; Boss_DestroyerProtoState5+40   j ...
                cmpi.w  #$60,$10(a5) ; '`'
                bcs.s   loc_3233C
                cmpi.w  #$1E0,$10(a5)
                bcc.s   loc_3233C
                cmpi.w  #$60,$14(a5) ; '`'
                bcs.s   loc_3233C
                cmpi.w  #$180,$14(a5)
                bcc.s   loc_3233C
                rts
; ---------------------------------------------------------------------------
loc_3233C:                              ; CODE XREF: Projectile_DestroyerProtoUpdate+6   j
                                        ; Projectile_DestroyerProtoUpdate+E   j ...
                move.w  #$1000,2(a5)
                rts
; End of function Projectile_DestroyerProtoUpdate
; Turret enemy main handler
Enemy_Stage14TurretMain:                              ; CODE XREF: Boss_JetsripperProjectileTurretCheck+6   j  ; was: sub_32344
                                        ; Enemy_Stage14TurretInit+18   j
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                jsr (Boss_JetsripperAttackPattern1).l
                andi.w  #$FEFF,2(a5)
                rts
; End of function Enemy_Stage14TurretMain
; Reflects projectile by negating X velocity and advancing state
Boss_JetsripperProjectileReflect:                              ; CODE XREF: Boss_JetsripperProjectileBounce+6   j  ; was: sub_3235C
                neg.l   $18(a5)
                move.w  #2,4(a5)
                rts
; End of function Boss_JetsripperProjectileReflect
; Returns projectile to stored velocity after delay timer expires
Boss_JetsripperProjectileReturn:                              ; DATA XREF: ROM:0003221C   o  ; was: sub_32368
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.l  $4C(a5),$18(a5)
                move.l  $50(a5),$1C(a5)
                subq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperProjectileReturn
; Initializes turret
Enemy_Stage14TurretInit:                              ; DATA XREF: ROM:000314D6   o  ; was: sub_32382
                bsr.w Enemy_DeathExplode
                bsr.w Projectile_DestroyerProtoUpdate
                bclr    #7,$22(a5)
                beq.w   locret_30BB8
                bclr    #4,$22(a5)
                bne.w Enemy_Stage14TurretMain
loc_3239E:                              ; CODE XREF: Enemy_FlierBoundsCheck+E   j
                cmpi.w  #$1A,(word_FFA204).w
                bne.s   loc_323B8
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w ; ' '
                move.b  #8,(byte_FF8143).w
loc_323B8:                              ; CODE XREF: Enemy_Stage14TurretInit+22   j
                jsr (Projectile_FindFreeSlot).l
                bne.s   loc_323DA
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E9560,8(a0)
                jsr (Sprite_InitializeProperties).l
loc_323DA:                              ; CODE XREF: Enemy_Stage14TurretInit+3C   j
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_Stage14TurretInit
; Main state dispatcher for Jetsripper boss using indexed jump table
Boss_JetsripperStateDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_323E2
                move.w  $48(a5),d0
                lea     off_323EE(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JetsripperStateDispatcher
; ---------------------------------------------------------------------------
off_323EE:      dc.w Boss_JetsripperIntroSequence-*        ; DATA XREF: Boss_JetsripperStateDispatcher+4   o
                dc.w Enemy_Stage14FlierAttack-*
                dc.w Boss_JetsripperDeathRotate-*
                dc.w Enemy_Stage14FlierCheckBounds-*
                dc.w Enemy_FlierDeathDispatcher-*
                dc.w Enemy_FlierBoundsCheck-*


; Handles boss intro with palette fade and stage initialization
Boss_JetsripperIntroSequence:                              ; DATA XREF: ROM:off_323EE   o  ; was: sub_323FA
                jsr (Gfx_InitPaletteFade).l
                cmpi.w  #$1E,4(a5)
                bcc.s   loc_32420
                tst.w   (word_FF8200).w
                bne.s   loc_32420
                move.w  #1,(dword_FF9414+2).w
                bset    #0,(byte_FFA272).w
                move.w  #$1E,4(a5)
loc_32420:                              ; CODE XREF: Boss_JetsripperIntroSequence+C   j
                                        ; Boss_JetsripperIntroSequence+12   j
                move.w  4(a5),d0
                lea     off_3242C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JetsripperIntroSequence
; ---------------------------------------------------------------------------
off_3242C:      dc.w Boss_JetsripperSpawnInit-*        ; DATA XREF: Boss_JetsripperIntroSequence+2A   o
                dc.w Boss_JetsripperFlyIn-*
                dc.w Enemy_Stage14FlierMove-*
                dc.w Enemy_Stage14TurretFire-*
                dc.w Boss_JetsripperSpawnCircleShots-*
                dc.w Boss_JetsripperReverseCircle-*
                dc.w Boss_JetsripperRetractCircle-*
                dc.w Boss_JetsripperStabilizeVelocity-*
                dc.w Boss_JetsripperResetComponents-*
                dc.w Boss_JetsripperWindupRotation-*
                dc.w Boss_JetsripperPhase4Init-*
                dc.w Boss_JetsripperPhase5Wait-*
                dc.w Projectile_Stage14BulletMain-*
                dc.w Projectile_Stage14BulletInit-*
                dc.w Boss_JetsripperPhase7Wait-*
                dc.w Boss_JetsripperPhase8Init-*
                dc.w Boss_JetsripperDeathExplosion-*


; Spawns Jetsripper boss with full initialization of graphics, entities, and components
Boss_JetsripperSpawnInit:                              ; DATA XREF: ROM:off_3242C   o  ; was: sub_3244E
                clr.w   (dword_FF9414+2).w
                move.w  #$100,$14(a5)
                move.w  #$200,$10(a5)
                bsr.w Enemy_Stage14FlierInit
                tst.w   (word_FFF720).w
                bmi.w   locret_30BB8
                move.l  #word_32604,(dword_FF9400).w
                move.w  #1,(dword_FF9404).w
                move.b  #4,(byte_FFA95A).w
                move.b  #$50,$21(a5) ; 'P'
                move.b  #$98,$23(a5)
                move.w  #$18,$24(a5)
                move.w  #$8C00,2(a5)
                move.w  #$E00,8(a5)
                move.w  #$F0F8,$A(a5)
                move.w  #$632C,$E(a5)
                move.l  #$D828D828,$2C(a5)
                move.l  #$D030D030,$28(a5)
                move.b  #$54,$20(a5) ; 'T'
                move.w  #$64,$26(a5) ; 'd'
                movea.l #word_32666,a0
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #$FFFE,$18(a5)
                move.l  #$80000,(dword_FF940C+2).w
                addq.w  #2,4(a5)
                movea.w a5,a4
                adda.w  #$60,a4 ; '`'
                bsr.w Enemy_Stage14FlierMain
                move.w  #2,$48(a4)
                move.w  #0,8(a4)
                move.w  #$FCFC,$A(a4)
                move.w  #$6351,$E(a4)
                move.w  #$100,$40(a4)
                move.w  #$14,$42(a4)
                move.w  a5,$44(a4)
                adda.w  #$60,a4 ; '`'
                bsr.w Enemy_Stage14FlierMain
                move.w  #2,$48(a4)
                move.w  #0,8(a4)
                move.w  #$FCFC,$A(a4)
                move.w  #$6352,$E(a4)
                move.w  #$100,$40(a4)
                move.w  #$10,$42(a4)
                move.w  a5,$44(a4)
                adda.w  #$60,a4 ; '`'
                move.w  #7,d6
loc_3254C:                              ; CODE XREF: Boss_JetsripperSpawnInit+130   j
                adda.w  #$60,a4 ; '`'
                bsr.w Enemy_Stage14FlierMain
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
Enemy_Stage14FlierMain:                              ; CODE XREF: Boss_JetsripperSpawnInit+9A   p  ; was: sub_32584
                                        ; Boss_JetsripperSpawnInit+CA   p ...
                move.w  #$8C00,2(a4)
                move.w  #$6300,$E(a4)
                move.b  #$50,$20(a4) ; 'P'
                move.b  #$40,$21(a4) ; '@'
                move.l  #$FC04FC04,$2C(a4)
                move.w  #$32,$26(a4) ; '2'
                move.w  #$3C0,(a4)
                clr.w   4(a4)
                move.w  $10(a5),$10(a4)
                move.w  $14(a5),$14(a4)
                rts
; End of function Enemy_Stage14FlierMain
; Initializes flying enemy
Enemy_Stage14FlierInit:                              ; CODE XREF: Boss_JetsripperSpawnInit+10   p  ; was: sub_325C0
                                        ; Boss_JetsripperFlyIn+4   p ...
                move.w  #$2A8,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                subi.w  #$A8,d0
                move.w  d0,(dword_FFA90C).w
                rts
; End of function Enemy_Stage14FlierInit
; Updates boss animation frames by loading compressed tile data on timer
Boss_JetsripperUpdateAnimation:                              ; CODE XREF: Boss_JetsripperFlyIn+8   p  ; was: sub_325DA
                                        ; Enemy_Stage14FlierMove+8   p ...
                subq.w  #1,(dword_FF9404).w
                bne.w   locret_30BB8
                movea.l (dword_FF9400).w,a0
                tst.w   (a0)
                bpl.s   loc_325F0
                movea.l #word_32604,a0
loc_325F0:                              ; CODE XREF: Boss_JetsripperUpdateAnimation+E   j
                move.w  (a0)+,(dword_FF9404).w
                move.w  (a0)+,d0
                move.l  a0,(dword_FF9400).w
                movea.l off_32636(pc,d0.w),a0
                jmp Gfx_LoadCompressedTiles
; End of function Boss_JetsripperUpdateAnimation
; ---------------------------------------------------------------------------
word_32604:     dc.w 8, 8, 8, $C, 8, 8, $40, 4
                                        ; DATA XREF: Boss_JetsripperSpawnInit+1C   o
                                        ; Boss_JetsripperUpdateAnimation+10   o
                dc.w 8, 8, 8, $C, 8, 8, 8, 4
                dc.w 8, 8, 8, $C, 8, 8, $40, 4
                dc.w $FFFF
off_32636:      dc.l word_32646         ; DATA XREF: Boss_JetsripperUpdateAnimation+20   r
                dc.l word_3264E
                dc.l word_32656
                dc.l word_3265E
word_32646:     dc.w $6206, $2000, 0, $5EFF
                                        ; DATA XREF: ROM:off_32636   o
word_3264E:     dc.w $6206, $2000, 0, $5CFF
                                        ; DATA XREF: ROM:0003263A   o
word_32656:     dc.w $6206, $2000, 0, $60FF
                                        ; DATA XREF: ROM:0003263E   o
word_3265E:     dc.w $6206, $2000, 0, $64FF
                                        ; DATA XREF: ROM:00032642   o
word_32666:     dc.w $6000, $2000, $202, $595A, $5B5D, $5E5F, $6162, $63FF
                                        ; DATA XREF: Boss_JetsripperSpawnInit+76   o


; Handles boss flying in until X position reaches threshold
Boss_JetsripperFlyIn:                              ; DATA XREF: ROM:0003242E   o  ; was: sub_32676
                bsr.w Boss_JetsripperSetScreenShake
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                cmpi.w  #$180,$10(a5)
                bhi.w   locret_30BB8
                clr.w   $18(a5)
                move.w  #3,d0
                jsr (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperFlyIn
; Flying enemy movement
Enemy_Stage14FlierMove:                              ; DATA XREF: ROM:00032430   o  ; was: sub_326A0
                bsr.w Boss_JetsripperSetScreenShake
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                tst.w   (word_FF80C2).w
                bne.w   locret_30BB8
                clr.b   (byte_FF80EC).w
                andi.b  #$EF,$23(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage14FlierMove
; Sets screen shake parameters with specific intensity and duration values
Boss_JetsripperSetScreenShake:                              ; CODE XREF: Boss_JetsripperFlyIn   p  ; was: sub_326C4
                                        ; sub_326A0   p
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w ; ' '
                move.b  #8,(byte_FF8143).w
                rts
; End of function Boss_JetsripperSetScreenShake
; Turret fire state
Enemy_Stage14TurretFire:                              ; DATA XREF: ROM:00032432   o  ; was: sub_326D8
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                jsr     (RandomNumber).l
                andi.w  #3,d0
                beq.s   loc_326F8
                cmpi.w  #2,d0
                beq.s   loc_32700
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_326F8:                              ; CODE XREF: Enemy_Stage14TurretFire+12   j
                move.w  #$10,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_32700:                              ; CODE XREF: Enemy_Stage14TurretFire+18   j
                move.w  #$18,4(a5)
                rts
; End of function Enemy_Stage14TurretFire
; Spawns circular pattern of 12 projectiles around boss position
Boss_JetsripperSpawnCircleShots:                              ; DATA XREF: ROM:00032434   o  ; was: sub_32708
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                lea     (word_FFCD40).w,a4
                lea     (word_FFC620).w,a0
                bsr.w Boss_JetsripperRandomizePattern
                move.w  #$B,d6
loc_32720:                              ; CODE XREF: Boss_JetsripperSpawnCircleShots+5C   j
                adda.w  #$60,a4 ; '`'
                bsr.w Enemy_Stage14FlierMain
                move.b  #$54,$20(a4) ; 'T'
                move.w  #8,$48(a4)
                move.w  #$500,8(a4)
                move.w  #$F8F8,$A(a4)
                move.w  #$6334,$E(a4)
                move.w  #$40,$4A(a4) ; '@'
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
loc_32788:                              ; CODE XREF: Boss_JetsripperSpawnCircleShots+78   j
                move.w  #3,(word_FFCDEC).w
                move.b  #$4B,d0 ; 'K'
                jsr (Sound_PlaySFX).l
                move.w  #$40,$4A(a5) ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperSpawnCircleShots
; Randomizes projectile spawn pattern based on boss X position
Boss_JetsripperRandomizePattern:                              ; CODE XREF: Boss_JetsripperSpawnCircleShots+10   p  ; was: sub_327A4
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
loc_327D6:                              ; CODE XREF: Boss_JetsripperRandomizePattern+12   j
                move.w  #4,d5
                move.w  #4,(dword_FF9404+2).w
                move.w  #2,(dword_FF9408+2).w
                move.w  #$FFFE,(dword_FF9408).w
                move.w  #$180,(dword_FF940C).w
                rts
; ---------------------------------------------------------------------------
loc_327F4:                              ; CODE XREF: Boss_JetsripperRandomizePattern+C   j
                andi.w  #1,d0
                bne.s   loc_32818
                move.w  #$104,d5
                move.w  #$104,(dword_FF9404+2).w
                move.w  #2,(dword_FF9408+2).w
                move.w  #2,(dword_FF9408).w
                move.w  #$C0,(dword_FF940C).w
                rts
; ---------------------------------------------------------------------------
loc_32818:                              ; CODE XREF: Boss_JetsripperRandomizePattern+54   j
                move.w  #$FC,d5
                move.w  #$FC,(dword_FF9404+2).w
                move.w  #$FFFE,(dword_FF9408+2).w
                move.w  #$FFFE,(dword_FF9408).w
                move.w  #$C0,(dword_FF940C).w
                rts
; End of function Boss_JetsripperRandomizePattern
; Reverses direction of circular projectile pattern with sound effect
Boss_JetsripperReverseCircle:                              ; DATA XREF: ROM:00032436   o  ; was: sub_32836
                move.w  #$E0,(word_FF8140).w
                move.b  #$80,(byte_FF8142).w
                move.b  #8,(byte_FF8143).w
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #3,(word_FFA010).w
                move.b  #$53,d0 ; 'S'
                jsr (Sound_PlaySFX).l
                lea     (word_FFCDA0).w,a4
                move.w  #$B,d6
loc_32870:                              ; CODE XREF: Boss_JetsripperReverseCircle+5E   j
                move.w  #$40,$42(a4) ; '@'
                movea.w a4,a3
                adda.w  #$60,a3 ; '`'
                move.w  a3,$44(a4)
                move.w  $40(a3),d0
                eori.w  #$100,d0
                move.w  d0,$40(a4)
                addq.w  #2,4(a4)
                adda.w  #$60,a4 ; '`'
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
Boss_JetsripperRetractCircle:                              ; DATA XREF: ROM:00032438   o  ; was: sub_328C0
                move.w  #$E0,(word_FF8140).w
                move.b  #$80,(byte_FF8142).w
                move.b  #8,(byte_FF8143).w
                bsr.w Enemy_GustheadUpdatePosition
                move.w  #$100,$14(a5)
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                subq.w  #3,$42(a5)
                cmpi.w  #$120,(dword_FF940C).w
                bcc.s   loc_32902
                cmpi.w  #$C0,$10(a5)
                bhi.w   locret_30BB8
                move.w  #$C0,$10(a5)
                bra.s   loc_32912
; ---------------------------------------------------------------------------
loc_32902:                              ; CODE XREF: Boss_JetsripperRetractCircle+2E   j
                cmpi.w  #$180,$10(a5)
                bcs.w   locret_30BB8
                move.w  #$180,$10(a5)
loc_32912:                              ; CODE XREF: Boss_JetsripperRetractCircle+40   j
                lea     (word_FFD1C0).w,a4
                move.w  #$A,d6
loc_3291A:                              ; CODE XREF: Boss_JetsripperRetractCircle+84   j
                movea.w a4,a3
                suba.w  #$60,a3 ; '`'
                move.w  a3,$44(a4)
                move.w  $40(a3),d0
                eori.w  #$100,d0
                move.w  d0,$40(a4)
                move.w  $42(a3),$42(a4)
                move.w  #$10,$4A(a4)
                addq.w  #2,4(a4)
                suba.w  #$60,a4 ; '`'
                dbf     d6,loc_3291A
                lea     (word_FFC620).w,a3
                move.w  a3,$44(a4)
                move.w  (dword_FF9404+2).w,$40(a4)
                move.w  $42(a3),$42(a4)
                move.w  #$10,$4A(a4)
                addq.w  #2,4(a4)
                move.l  #word_EBE94,(dword_FFD1C8).w
                move.w  #$20,$4A(a5) ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperRetractCircle
; Gradually stabilizes boss Y velocity to 0x100 value
Boss_JetsripperStabilizeVelocity:                              ; DATA XREF: ROM:0003243A   o  ; was: sub_3297A
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                cmpi.w  #$100,$14(a5)
                beq.s   loc_32996
                bcs.s   loc_32992
                subq.w  #1,$14(a5)
                bra.s   loc_32996
; ---------------------------------------------------------------------------
loc_32992:                              ; CODE XREF: Boss_JetsripperStabilizeVelocity+10   j
                addq.w  #1,$14(a5)
loc_32996:                              ; CODE XREF: Boss_JetsripperStabilizeVelocity+E   j
                                        ; Boss_JetsripperStabilizeVelocity+16   j
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #6,4(a5)
                rts
; End of function Boss_JetsripperStabilizeVelocity
; Resets state of 8 boss components and initializes rotation parameters
Boss_JetsripperResetComponents:                              ; DATA XREF: ROM:0003243C   o  ; was: sub_329A6
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                lea     (word_FFC7A0).w,a4
                move.w  #7,d6
loc_329B6:                              ; CODE XREF: Boss_JetsripperResetComponents+1A   j
                move.w  #4,4(a4)
                adda.w  #$60,a4 ; '`'
                dbf     d6,loc_329B6
                lea     (word_FFCDA0).w,a4
                move.w  a4,(dword_FF9414).w
                move.l  #$80000,(dword_FF940C+2).w
                move.w  #4,(dword_FF9410+2).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperResetComponents
; Decrements rotation windup counter until ready for next phase
Boss_JetsripperWindupRotation:                              ; DATA XREF: ROM:0003243E   o  ; was: sub_329E0
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                subi.l  #$10000,(dword_FF940C+2).w
                cmpi.l  #$FFF00000,(dword_FF940C+2).w
                bne.w   locret_30BB8
                bsr.w Boss_JetsripperSpawnFlier
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperWindupRotation
; Initializes phase 4 of Jetsripper boss, spawning fliers and managing counter progression
Boss_JetsripperPhase4Init:                              ; DATA XREF: ROM:00032440   o  ; was: sub_32A06
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                addi.l  #$10000,(dword_FF940C+2).w
                cmpi.l  #$80000,(dword_FF940C+2).w
                beq.s   loc_32A36
                cmpi.l  #$100000,(dword_FF940C+2).w
                bne.w   locret_30BB8
                bsr.w Boss_JetsripperSpawnFlier
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_32A36:                              ; CODE XREF: Boss_JetsripperPhase4Init+18   j
                subq.w  #1,(dword_FF9410+2).w
                bne.w   locret_30BB8
                lea     (word_FFC7A0).w,a4
                move.w  #7,d6
loc_32A46:                              ; CODE XREF: Boss_JetsripperPhase4Init+4A   j
                move.w  #0,4(a4)
                adda.w  #$60,a4 ; '`'
                dbf     d6,loc_32A46
                move.w  #$60,$4A(a5) ; '`'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperPhase4Init
; Spawns a stage 14 flier enemy with sound effect and position offset based on boss position
Boss_JetsripperSpawnFlier:                              ; CODE XREF: Boss_JetsripperWindupRotation+1C   p  ; was: sub_32A60
                                        ; Boss_JetsripperPhase4Init+26   p
                move.b  #$CC,d0
                jsr (Sound_PlaySFX).l
                movea.w (dword_FF9414).w,a4
                addi.w  #$60,(dword_FF9414).w ; '`'
                bsr.w Enemy_Stage14FlierMain
                move.w  #$A,$48(a4)
                move.w  #$500,8(a4)
                move.w  #$F8F8,$A(a4)
                move.w  #$6334,$E(a4)
                move.w  $10(a5),$10(a4)
                move.w  $14(a5),$14(a4)
                bsr.w Boss_JetsripperSetFlierDirection
                cmpi.w  #$12,4(a5)
                beq.s   loc_32ABA
                cmpi.w  #$120,$10(a5)
                bcs.w   loc_32AC4
loc_32AB2:                              ; CODE XREF: Boss_JetsripperSpawnFlier+60   j
                addi.w  #$28,$14(a4) ; '('
                rts
; ---------------------------------------------------------------------------
loc_32ABA:                              ; CODE XREF: Boss_JetsripperSpawnFlier+46   j
                cmpi.w  #$120,$10(a5)
                bcs.w   loc_32AB2
loc_32AC4:                              ; CODE XREF: Boss_JetsripperSpawnFlier+4E   j
                subi.w  #$28,$14(a4) ; '('
                rts
; End of function Boss_JetsripperSpawnFlier
; Sets horizontal velocity for spawned flier based on boss X position
Boss_JetsripperSetFlierDirection:                              ; CODE XREF: Boss_JetsripperSpawnFlier+3C   p  ; was: sub_32ACC
                cmpi.w  #$120,$10(a5)
                bcs.w   loc_32ADE
                move.w  #$FFFD,$18(a4)
                rts
; ---------------------------------------------------------------------------
loc_32ADE:                              ; CODE XREF: Boss_JetsripperSetFlierDirection+6   j
                move.w  #3,$18(a4)
                rts
; End of function Boss_JetsripperSetFlierDirection
; Waits for timer countdown and transitions to next phase
Boss_JetsripperPhase5Wait:                              ; DATA XREF: ROM:00032442   o  ; was: sub_32AE6
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #6,4(a5)
                rts
; End of function Boss_JetsripperPhase5Wait
; Bullet projectile handler
Projectile_Stage14BulletMain:                              ; DATA XREF: ROM:00032444   o  ; was: sub_32AFE
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                move.w  #$200,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Projectile_Stage14BulletMain
; Initializes bullet
Projectile_Stage14BulletInit:                              ; DATA XREF: ROM:00032446   o  ; was: sub_32B12
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
                bsr.w Projectile_Stage14BulletMove
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$40,$4A(a5) ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Projectile_Stage14BulletInit
; Bullet movement
Projectile_Stage14BulletMove:                              ; CODE XREF: Projectile_Stage14BulletInit+8   p  ; was: sub_32B32
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
loc_32B56:                              ; CODE XREF: Projectile_Stage14BulletMove+3C   j
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                bsr.w   loc_31B02
                bsr.w Enemy_Stage14SpawnSplitBullet
                addq.w  #2,d6
                cmpi.w  #6,d6
                bne.s   loc_32B56
                rts
; ---------------------------------------------------------------------------
loc_32B72:                              ; CODE XREF: Projectile_Stage14BulletMove+20   j
                move.w  #4,d6
loc_32B76:                              ; CODE XREF: Projectile_Stage14BulletMove+5C   j
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                bsr.w   loc_31B02
                bsr.w Enemy_Stage14SpawnSplitBullet
                addq.w  #2,d6
                cmpi.w  #$A,d6
                bne.s   loc_32B76
                rts
; End of function Projectile_Stage14BulletMove
; Spawns split bullet from dying enemy
Enemy_Stage14SpawnSplitBullet:                              ; CODE XREF: Projectile_Stage14BulletMove+32   p  ; was: sub_32B92
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
loc_32BBE:                              ; CODE XREF: Enemy_Stage14SpawnSplitBullet+1A   j
                add.w   word_32BCE(pc,d6.w),d0
                move.w  d0,$10(a0)
                move.w  #2,$18(a0)
                rts
; End of function Enemy_Stage14SpawnSplitBullet
; ---------------------------------------------------------------------------
word_32BCE:     dc.w 0, $22, $30, $22, 0
                                        ; DATA XREF: Projectile_Stage14BulletMove+C   o
                                        ; Enemy_Stage14SpawnSplitBullet+1C   r ...
word_32BD8:     dc.w $FFD0, $FFDE, 0, $22, $30
                                        ; DATA XREF: Projectile_Stage14BulletMove+12   o
                                        ; Enemy_Stage14SpawnSplitBullet+8   r


; Waits for timer countdown and transitions to next phase
Boss_JetsripperPhase7Wait:                              ; DATA XREF: ROM:00032448   o  ; was: sub_32BE2
                bsr.w Enemy_Stage14FlierInit
                bsr.w Boss_JetsripperUpdateAnimation
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
Boss_JetsripperDeathExplosion:                              ; DATA XREF: ROM:0003244C   o  ; was: sub_32C0A
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w ; ' '
                move.b  #8,(byte_FF8143).w
                jsr (Boss_SpawnExplosionDebris).l
                cmpi.w  #$88,(a0)
                bne.s   loc_32C2E
                ori.w   #$8000,$E(a0)
loc_32C2E:                              ; CODE XREF: Boss_JetsripperDeathExplosion+1C   j
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w ; ' '
                move.b  #8,(byte_FF8143).w
                movea.l #word_32C5C,a0
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperDeathExplosion
; ---------------------------------------------------------------------------
word_32C5C:     dc.w $6000, $2000, $202, 0, 0, 0, 0, $FF
                                        ; DATA XREF: Boss_JetsripperDeathExplosion+3E   o


; Flying enemy attack
Enemy_Stage14FlierAttack:                              ; DATA XREF: ROM:000323F0   o  ; was: sub_32C6C
                bsr.w Enemy_DeathExplode
                movea.w a5,a4
                lea     (word_FFC620).w,a5
                jsr (Math_CalculateAngleToPlayer).l
                movea.w a4,a5
                move.w  d2,$40(a5)
                bra.w Enemy_GustheadUpdatePosition
; End of function Enemy_Stage14FlierAttack
; Handles boss death animation with rotation and position updates
Boss_JetsripperDeathRotate:                              ; DATA XREF: ROM:000323F2   o  ; was: sub_32C86
                bsr.w Enemy_DeathExplode
                bsr.w Boss_JetsripperTrackPlayer
                andi.w  #$1FE,$40(a5)
                bra.w Enemy_GustheadUpdatePosition
; End of function Boss_JetsripperDeathRotate
; Adjusts boss rotation angle to track player position with smooth turning
Boss_JetsripperTrackPlayer:                              ; CODE XREF: Boss_JetsripperDeathRotate+4   p  ; was: sub_32C98
                movea.w a5,a4
                lea     (word_FFC620).w,a5
                jsr (Math_CalculateAngleToPlayer).l
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
loc_32CCC:                              ; CODE XREF: Boss_JetsripperTrackPlayer+2C   j
                subq.w  #2,$40(a5)
                rts
; End of function Boss_JetsripperTrackPlayer
; Checks if flier in bounds
Enemy_Stage14FlierCheckBounds:                              ; DATA XREF: ROM:000323F4   o  ; was: sub_32CD2
                bsr.w Enemy_DeathExplode
                bsr.w Enemy_Stage14FlierOutOfBounds
                andi.w  #$1FE,$40(a5)
                bra.w Enemy_GustheadUpdatePosition
; End of function Enemy_Stage14FlierCheckBounds
; Handles flier out of bounds
Enemy_Stage14FlierOutOfBounds:                              ; CODE XREF: Enemy_Stage14FlierCheckBounds+4   p  ; was: sub_32CE4
                move.w  4(a5),d0
                lea     off_32CF0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage14FlierOutOfBounds
; ---------------------------------------------------------------------------
off_32CF0:      dc.w Enemy_Stage14FlierDespawn-*        ; DATA XREF: Enemy_Stage14FlierOutOfBounds+4   o
                dc.w Enemy_Stage14FlierSpawnBullet-*
                dc.w Enemy_FlierRotateIncrement-*


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
Enemy_Stage14FlierSpawnBullet:                              ; DATA XREF: ROM:00032CF2   o  ; was: sub_32D12
                move.w  (dword_FF940C+2).w,d0
                add.w   d0,$40(a5)
                addq.w  #1,$42(a5)
                cmpi.w  #$A8,$42(a5)
                bne.w   locret_30BB8
                subq.w  #2,4(a5)
                rts
; End of function Enemy_Stage14FlierSpawnBullet
; Rotates enemy and increments counter until reaching maximum value
Enemy_FlierRotateIncrement:                              ; DATA XREF: ROM:00032CF4   o  ; was: sub_32D2E
                move.w  (dword_FF940C+2).w,d0
                add.w   d0,$40(a5)
                cmpi.w  #$A8,$42(a5)
                beq.w   locret_30BB8
                addq.w  #1,$42(a5)
                rts
; End of function Enemy_FlierRotateIncrement
; Dispatches to death behavior states with continuous explosion effects
Enemy_FlierDeathDispatcher:                              ; DATA XREF: ROM:000323F6   o  ; was: sub_32D46
                bsr.w Enemy_DeathExplode
                move.w  4(a5),d0
                lea     off_32D56(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlierDeathDispatcher
; ---------------------------------------------------------------------------
off_32D56:      dc.w Enemy_FlierDeathRotate-*        ; DATA XREF: Enemy_FlierDeathDispatcher+8   o
                dc.w Enemy_FlierDeathSlowdown-*
                dc.w Enemy_FlierDeathFinalize-*


; Updates rotation angle during death sequence
Enemy_FlierDeathRotate:                              ; DATA XREF: ROM:off_32D56   o  ; was: sub_32D5C
                move.w  $4C(a5),d0
                add.w   d0,$42(a5)
                bra.w Enemy_GustheadUpdatePosition
; End of function Enemy_FlierDeathRotate
; Decrements rotation speed and clamps angle during death sequence
Enemy_FlierDeathSlowdown:                              ; DATA XREF: ROM:00032D58   o  ; was: sub_32D68
                cmpa.l  #$FFFFD1C0,a5
                beq.w   locret_30BB8
                andi.w  #$1FE,$40(a5)
                subq.w  #1,$42(a5)
                bra.w Enemy_GustheadUpdatePosition
; End of function Enemy_FlierDeathSlowdown
; Decrements rotation and marks for destruction when timer expires
Enemy_FlierDeathFinalize:                              ; DATA XREF: ROM:00032D5A   o  ; was: sub_32D80
                move.w  $4C(a5),d0
                sub.w   d0,$42(a5)
                bsr.w Enemy_GustheadUpdatePosition
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_FlierDeathFinalize
; Checks if enemy hit boss part or is out of bounds, marks for destruction
Enemy_FlierBoundsCheck:                              ; DATA XREF: ROM:000323F8   o  ; was: sub_32D9C
                bclr    #7,$22(a5)
                beq.s   loc_32DAE
                bclr    #4,$22(a5)
                beq.w   loc_3239E
loc_32DAE:                              ; CODE XREF: Enemy_FlierBoundsCheck+6   j
                bsr.w Enemy_DeathExplode
                cmpi.w  #$60,$10(a5) ; '`'
                bcs.s   loc_32DC4
                cmpi.w  #$1E0,$10(a5)
                bcc.s   loc_32DC4
                rts
; ---------------------------------------------------------------------------
loc_32DC4:                              ; CODE XREF: Enemy_FlierBoundsCheck+1C   j
                                        ; Enemy_FlierBoundsCheck+24   j
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_FlierBoundsCheck
; Enemy death with explosion effect
Enemy_DeathExplode:                              ; CODE XREF: Projectile_DestroyerProtoMain   p  ; was: sub_32DCC
                                        ; sub_32382   p ...
                tst.w   (dword_FF9414+2).w
                beq.w   locret_30BB8
                jsr (Projectile_FindFreeSlot).l
                bne.s   loc_32DF6
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E9560,8(a0)
                jsr (Sprite_InitializeProperties).l
loc_32DF6:                              ; CODE XREF: Enemy_DeathExplode+E   j
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_DeathExplode
; Idle state handler
Boss_WolfGaropaIdleState:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_32DFE
                move.w  4(a5),d0
                lea     off_32E0A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_WolfGaropaIdleState
; ---------------------------------------------------------------------------
off_32E0A:      dc.w Boss_WolfGaropaAttackState1-*        ; DATA XREF: Boss_WolfGaropaIdleState+4   o
                dc.w Boss_WolfGaropaAttackState2-*
                dc.w Boss_WolfGaropaSpawnProjectiles-*


; Attack state 1 handler
Boss_WolfGaropaAttackState1:                              ; DATA XREF: ROM:off_32E0A   o  ; was: sub_32E10
                move.w  #$100,2(a5)
                move.w  #$A300,$E(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                cmpi.w  #$10,(word_FFA204).w
                bne.w   locret_30BB8
                move.w  #$18,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_WolfGaropaAttackState1
; Attack state 2 handler
Boss_WolfGaropaAttackState2:                              ; DATA XREF: ROM:00032E0C   o  ; was: sub_32E3C
                move.w  #$1D0,$10(a5)
                move.w  #$120,$14(a5)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_30BB8
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                subq.w  #1,$48(a5)
                move.w  #$F,d0
                jsr     (loc_2BD20).l
                ori.w   #$800,2(a0)
                move.l  #$FFF78000,$18(a0)
                jsr     (RandomNumber).l
                andi.w  #$70,d0 ; 'p'
                addi.w  #$D0,d0
                move.w  d0,$14(a0)
                move.w  #$1D0,$10(a0)
                tst.w   $48(a5)
                bne.w   locret_30BB8
loc_32E9A:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectiles+3A   j
                move.w  #$1000,2(a5)
                rts
; End of function Boss_WolfGaropaAttackState2
; Spawns random projectiles periodically during Wolf Garopa boss fight
Boss_WolfGaropaSpawnProjectiles:                              ; DATA XREF: ROM:00032E0E   o  ; was: sub_32EA2
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_30BB8
                jsr (Projectile_FindFreeSlot).l
                bne.s   loc_32ED8
                move.w  #$F,d0
                jsr     (loc_2BD20).l
                jsr     (RandomNumber).l
                andi.w  #$70,d0 ; 'p'
                addi.w  #$D0,d0
                move.w  d0,$14(a0)
                move.w  #$1D0,$10(a0)
loc_32ED8:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectiles+12   j
                subq.w  #1,$48(a5)
                beq.s   loc_32E9A
                rts
; End of function Boss_WolfGaropaSpawnProjectiles
; Tracker enemy main update with angle calculation and projectile
Enemy_TrackerMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_32EE0
                lea     (word_FF9800).w,a4
                bsr.w Enemy_TrackerDispatcher
                subq.w  #1,$5A(a5)
                beq.s   loc_32F24
                btst    #7,$22(a5)
                bne.s   loc_32F24
                tst.w   $24(a5)
                bmi.s   loc_32F04
                tst.w   (word_FF808C).w
                bmi.w   locret_330A4
loc_32F04:                              ; CODE XREF: Enemy_TrackerMain+1A   j
                jsr (Math_CalculateAngleToPlayer).l
                move.w  d2,d6
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_32F24
                moveq   #9,d7
                moveq   #0,d0
                moveq   #1,d1
                move.w  (word_FF808A).w,d2
                jsr (Enemy_SetProjectileDifficulty).l
loc_32F24:                              ; CODE XREF: Enemy_TrackerMain+C   j
                                        ; Enemy_TrackerMain+14   j ...
                move.l  #off_E953C,8(a5)
                jmp Enemy_GetEntityAddress
; End of function Enemy_TrackerMain
; Tracker enemy state dispatcher using jump table
Enemy_TrackerDispatcher:                              ; CODE XREF: Enemy_TrackerMain+4   p  ; was: sub_32F32
                movea.w 4(a5),a0
                lea     off_32F3E(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_TrackerDispatcher
; ---------------------------------------------------------------------------
off_32F3E:      dc.w Enemy_TrackerSpawnWave-*        ; DATA XREF: Enemy_TrackerDispatcher+4   o
                dc.w Enemy_TrackerFallState-*
                dc.w Enemy_TrackerWaveMotion-*
                dc.w Enemy_TrackerWaveMotion_Loop-*
                dc.w Enemy_TrackerOffScreen-*
                dc.w Enemy_TrackerSineWave-*
                dc.w Enemy_TrackerSineWave_VerticalAccel-*
                dc.w Enemy_TrackerReverse-*
                dc.w locret_330A4-*
word_32F50:     dc.w 2, 4, $A, $E, 4, 4, 4, 4
                                        ; DATA XREF: Enemy_TrackerSpawnWave+A   r


; Spawns wave of tracker projectiles in formation pattern
Enemy_TrackerSpawnWave:                              ; DATA XREF: ROM:off_32F3E   o  ; was: sub_32F60
                lea     (a5),a0
                move.w  $5E(a5),d7
                andi.w  #$FF,d7
                move.w  word_32F50(pc,d7.w),d5
                move.b  $5E(a5),d7
                moveq   #0,d6
loc_32F74:                              ; CODE XREF: Enemy_TrackerSpawnWave+1E   j
                bsr.w Enemy_TrackerInitProjectile
                jsr (Projectile_UpdateTrajectory).l
                dbne    d7,loc_32F74
                rts
; End of function Enemy_TrackerSpawnWave
; Initializes individual tracker projectile with params
Enemy_TrackerInitProjectile:                              ; CODE XREF: Enemy_TrackerSpawnWave:loc_32F74   p  ; was: sub_32F84
                move.w  $5E(a5),$5E(a0)
                move.w  #$200,$5A(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                add.w   d6,$10(a0)
                move.w  d6,$5C(a0)
                addi.w  #$20,d6 ; ' '
                move.w  d5,4(a0)
                move.w  #$3B4,(a0)
                move.w  #$ED00,2(a0)
                move.w  #$400,$E(a0)
                move.l  #off_EB3C8,8(a0)
                move.b  #$C0,$21(a0)
                move.w  #1,$24(a0)
                move.w  #$32,$26(a0) ; '2'
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.b  #$40,$20(a0) ; '@'
                move.b  #8,$23(a0)
                rts
; End of function Enemy_TrackerInitProjectile
; Tracker falling state with upward negative velocity
Enemy_TrackerFallState:                              ; DATA XREF: ROM:00032F40   o  ; was: sub_32FF4
                move.l  #$FFFEC000,$18(a5)
                move.w  #8,4(a5)
                rts
; End of function Enemy_TrackerFallState
; Tracker enemy off-screen check marking for removal
Enemy_TrackerOffScreen:                              ; CODE XREF: Enemy_TrackerWaveMotion:loc_33056   j  ; was: sub_33004
                                        ; Enemy_TrackerSineWave+24   j
                                        ; DATA XREF: ...
                cmpi.w  #$60,$10(a5) ; '`'
                bcc.w   locret_330A4
                ori.w   #$1000,2(a5)
                rts
; End of function Enemy_TrackerOffScreen
; Tracker wave motion with oscillating vertical acceleration
Enemy_TrackerWaveMotion:                              ; DATA XREF: ROM:00032F42   o  ; was: sub_33016
                move.l  #$FFFF0000,$18(a5)
                subq.w  #1,$5C(a5)
                bpl.w   locret_330A4
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$800,$5C(a5)
                addq.w  #2,4(a5)
; Execute wave motion pattern with acceleration reversal
Enemy_TrackerWaveMotion_Loop:                              ; DATA XREF: ROM:00032F44   o  ; was: loc_3303A
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                move.l  $1C(a5),d0
                bpl.s   loc_3304A
                neg.l   d0
loc_3304A:                              ; CODE XREF: Enemy_TrackerWaveMotion+30   j
                cmpi.l  #$10000,d0
                bne.s   loc_33056
                neg.l   $5C(a5)
loc_33056:                              ; CODE XREF: Enemy_TrackerWaveMotion+3A   j
                bra.w Enemy_TrackerOffScreen
; End of function Enemy_TrackerWaveMotion
; Tracker sine wave motion with smooth oscillation
Enemy_TrackerSineWave:                              ; DATA XREF: ROM:00032F48   o  ; was: sub_3305A
                move.l  #$FFFEC000,$18(a5)
                subq.w  #1,$5C(a5)
                bpl.w   locret_330A4
                move.l  #$1C0,$5C(a5)
                addq.w  #2,4(a5)
; Applies vertical acceleration during sine wave movement pattern
Enemy_TrackerSineWave_VerticalAccel:                              ; CODE XREF: Enemy_TrackerReverse+1C   j  ; was: loc_33076
                                        ; DATA XREF: ROM:00032F4A   o
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                bra.w Enemy_TrackerOffScreen
; End of function Enemy_TrackerSineWave
; Tracker reverse motion returning to wave pattern
Enemy_TrackerReverse:                              ; DATA XREF: ROM:00032F4C   o  ; was: sub_33082
                move.l  #$FFFEC000,$18(a5)
                subq.w  #1,$5C(a5)
                bpl.w   locret_330A4
                move.l  #$FFFFFE40,$5C(a5)
                subq.w  #2,4(a5)
                bra.s Enemy_TrackerSineWave_VerticalAccel
; ---------------------------------------------------------------------------
                addq.w  #2,4(a5)
locret_330A4:                           ; CODE XREF: Enemy_TrackerMain+20   j
                                        ; Enemy_TrackerOffScreen+6   j ...
                rts
; End of function Enemy_TrackerReverse
; Tracker enemy main (win cutscene)
Enemy_TrackerWinMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_330A6
                tst.w   4(a5)
                beq.s   loc_330BC
                cmpi.b  #$80,(byte_FFA958).w
                beq.s   loc_330BC
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_330BC:                              ; CODE XREF: Enemy_TrackerWinMain+4   j
                                        ; Enemy_TrackerWinMain+C   j
                btst    #7,(dword_FF8062).w
                beq.s   loc_330D4
                btst    #7,(dword_FFA960).w
                beq.s   loc_330D4
                bclr    #0,(dword_FF9410).w
                bra.s   loc_330DA
; ---------------------------------------------------------------------------
loc_330D4:                              ; CODE XREF: Enemy_TrackerWinMain+1C   j
                                        ; Enemy_TrackerWinMain+24   j
                bset    #0,(dword_FF9410).w
loc_330DA:                              ; CODE XREF: Enemy_TrackerWinMain+2C   j
                bsr.w Enemy_TrackerWinSpawnBullet
                move.w  4(a5),d0
                lea     off_330EA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_TrackerWinMain
; ---------------------------------------------------------------------------
off_330EA:      dc.w Enemy_TrackerSt21State1-*        ; DATA XREF: Enemy_TrackerWinMain+3C   o
                dc.w Enemy_TrackerSt21State2-*
                dc.w Enemy_TrackerSt21SpawnInit-*
                dc.w Enemy_TrackerSt21Attack2-*


; Tracker state 1 (Stage 21)
Enemy_TrackerSt21State1:                              ; DATA XREF: ROM:off_330EA   o  ; was: sub_330F2
                addq.w  #2,4(a5)
                move.w  #$E000,2(a5)
                move.l  #off_E9680,8(a5)
                move.w  #$8480,$E(a5)
                move.w  #$1B0,$10(a5)
                move.w  #$170,$14(a5)
                move.w  (dword_FFFF08).w,$5C(a5)
                andi.w  #3,$5C(a5)
                rts
; End of function Enemy_TrackerSt21State1
; Tracker state 2 (Stage 21)
Enemy_TrackerSt21State2:                              ; DATA XREF: ROM:000330EC   o  ; was: sub_33124
                btst    #0,(dword_FF9410).w
                bne.s   locret_33138
                cmpi.w  #$FFFC,(dword_FF8062).w
                bgt.s   locret_33138
                addq.w  #2,4(a5)
locret_33138:                           ; CODE XREF: Enemy_TrackerSt21State2+6   j
                                        ; Enemy_TrackerSt21State2+E   j
                rts
; End of function Enemy_TrackerSt21State2
; Tracker spawn init (Stage 21)
Enemy_TrackerSt21SpawnInit:                              ; DATA XREF: ROM:000330EE   o  ; was: sub_3313A
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_331AC
                addq.w  #2,4(a5)
                bsr.w Enemy_TrackerSt21Attack1
                bsr.w Enemy_TrackerWinInitSprite
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addq.w  #1,$5C(a5)
                move.w  $5C(a5),d0
                andi.w  #$3F,d0 ; '?'
                add.w   d0,d0
                move.w  word_331AE(pc,d0.w),d0
                beq.s   loc_3318E
                move.l  #word_1CEC6C,8(a0)
                move.b  #1,$5E(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  #$E818E818,$28(a0)
                rts
; ---------------------------------------------------------------------------
loc_3318E:                              ; CODE XREF: Enemy_TrackerSt21SpawnInit+32   j
                move.l  #word_1CEC90,8(a0)
                move.b  #0,$5E(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
locret_331AC:                           ; CODE XREF: Enemy_TrackerSt21SpawnInit+6   j
                rts
; End of function Enemy_TrackerSt21SpawnInit
; ---------------------------------------------------------------------------
word_331AE:     dc.w 1, 0, 0, 0, 1, 0, 0, 0
                                        ; DATA XREF: Enemy_TrackerSt21SpawnInit+2E   r
                dc.w 1, 0, 0, 0, 0, 0, 0, 0
                dc.w 0, 0, 0, 1, 0, 0, 0, 1
                dc.w 0, 0, 0, 1, 0, 0, 0, 0
                dc.w 0, 1, 0, 0, 0, 1, 0, 0
                dc.w 0, 1, 0, 0, 0, 0, 0, 0
                dc.w 0, 0, 1, 0, 0, 0, 1, 0
                dc.w 0, 0, 1, 0, 0, 0, 1, 0


; Tracker attack 1 (Stage 21)
Enemy_TrackerSt21Attack1:                              ; CODE XREF: Enemy_TrackerSt21SpawnInit+C   p  ; was: sub_3322E
                move.l  (dword_FF8062).w,d0
                bpl.s   loc_33236
                neg.l   d0
loc_33236:                              ; CODE XREF: Enemy_TrackerSt21Attack1+4   j
                swap    d0
                andi.w  #$E,d0
                move.w  word_33244(pc,d0.w),$48(a5)
                rts
; End of function Enemy_TrackerSt21Attack1
; ---------------------------------------------------------------------------
word_33244:     dc.w $30, $20, $18, $10, $C, 8, 4, 2, 2, 2
                                        ; DATA XREF: Enemy_TrackerSt21Attack1+E   r


; Tracker attack 2 (Stage 21)
Enemy_TrackerSt21Attack2:                              ; DATA XREF: ROM:000330F0   o  ; was: sub_33258
                subq.w  #1,$48(a5)
                bne.s   locret_3328E
                lea     word_33290(pc),a1
                nop
                move.w  $5C(a5),d0
                andi.w  #3,d0
                lsl.w   #4,d0
                lea     (a1,d0.w),a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.w  (a1,d0.w),$10(a5)
                move.w  2(a1,d0.w),$14(a5)
                subq.w  #2,4(a5)
locret_3328E:                           ; CODE XREF: Enemy_TrackerSt21Attack2+4   j
                rts
; End of function Enemy_TrackerSt21Attack2
; ---------------------------------------------------------------------------
word_33290:     dc.w $B0, $170, $D0, $170, $F0, $170, $110, $170, $130, $170, $150, $170, $170, $170, $190, $170
                                        ; DATA XREF: Enemy_TrackerSt21Attack2+6   o
                dc.w $1B0, $170, $1D0, $170, $1D0, $150, $1D0, $130, $1D0, $110, $1D0, $F0, $1D0, $D0, $1D0, $B0


; Tracker movement (win cutscene)
Enemy_TrackerWinMovement:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_332D0
                btst    #0,$5F(a5)
                bne.w Enemy_TrackerWinFollow
                tst.w   4(a5)
                beq.s   loc_33346
                btst    #0,$5E(a5)
                bne.s   loc_3330E
                cmpi.l  #$FFFD8000,$18(a5)
                ble.s   loc_332FA
                addi.l  #-$2000,$18(a5)
loc_332FA:                              ; CODE XREF: Enemy_TrackerWinMovement+20   j
                cmpi.l  #$FFFEC000,$1C(a5)
                ble.s   loc_33332
                addi.l  #-$2000,$1C(a5)
                bra.s   loc_33332
; ---------------------------------------------------------------------------
loc_3330E:                              ; CODE XREF: Enemy_TrackerWinMovement+16   j
                cmpi.l  #$FFFE0000,$18(a5)
                ble.s   loc_33320
                addi.l  #-$2000,$18(a5)
loc_33320:                              ; CODE XREF: Enemy_TrackerWinMovement+46   j
                cmpi.l  #$FFFF0000,$1C(a5)
                ble.s   loc_33332
                addi.l  #-$2000,$1C(a5)
loc_33332:                              ; CODE XREF: Enemy_TrackerWinMovement+32   j
                                        ; Enemy_TrackerWinMovement+3C   j ...
                cmpi.w  #$60,$10(a5) ; '`'
                blt.w Enemy_TrackerSt21OffScreen
                cmpi.w  #$60,$14(a5) ; '`'
                blt.w Enemy_TrackerSt21OffScreen
loc_33346:                              ; CODE XREF: Enemy_TrackerWinMovement+E   j
                move.w  4(a5),d0
                lea     off_33352(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_TrackerWinMovement
; ---------------------------------------------------------------------------
off_33352:      dc.w Enemy_TrackerSt21Damage-*        ; DATA XREF: Enemy_TrackerWinMovement+7A   o
                dc.w Enemy_TrackerSt21Damage_CheckCollision-*
                dc.w nullsub_75-*


; Tracker damage (Stage 21)
Enemy_TrackerSt21Damage:                              ; DATA XREF: ROM:off_33352   o  ; was: sub_33358
                clr.w   $48(a5)
                addq.w  #2,4(a5)
                btst    #0,$5E(a5)
                bne.s   loc_33380
                move.w  #$64,$26(a5) ; 'd'
                move.l  #$FFFD8000,$18(a5)
                move.l  #$FFFEC000,$1C(a5)
                bra.s Enemy_TrackerSt21Damage_CheckCollision
; ---------------------------------------------------------------------------
loc_33380:                              ; CODE XREF: Enemy_TrackerSt21Damage+E   j
                move.w  #$C8,$26(a5)
                move.l  #$FFFE0000,$18(a5)
                move.l  #$FFFF0000,$1C(a5)
; Handles collision detection and damage response for tracker enemy
Enemy_TrackerSt21Damage_CheckCollision:                              ; CODE XREF: Enemy_TrackerSt21Damage+26   j  ; was: loc_33396
                                        ; DATA XREF: ROM:00033354   o
                bclr    #7,$22(a5)
                beq.s   locret_333FE
                bclr    #4,$22(a5)
                beq.s   loc_333B4
                move.b  #$32,d0 ; '2'
                jsr (Sound_PlaySFX).l
                bsr.w Enemy_TrackerSt21Destroy
loc_333B4:                              ; CODE XREF: Enemy_TrackerSt21Damage+4C   j
                btst    #0,$5E(a5)
                bne.s   loc_333D6
                move.l  #$FFFFA000,$4C(a5)
                move.l  #$10000,$18(a5)
                move.l  #$FFFC0000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_333D6:                              ; CODE XREF: Enemy_TrackerSt21Damage+62   j
                move.l  #$FFFFE800,$4C(a5)
                move.l  #$FFFFE800,$50(a5)
                move.l  $18(a5),d0
                move.l  $1C(a5),d1
                neg.l   d0
                neg.l   d1
                asr.l   #1,d0
                asr.l   #1,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
locret_333FE:                           ; CODE XREF: Enemy_TrackerSt21Damage+44   j
                rts
; End of function Enemy_TrackerSt21Damage
nullsub_75:                             ; DATA XREF: ROM:00033356   o
                rts
; End of function nullsub_75


; Tracker destroy (Stage 21)
Enemy_TrackerSt21Destroy:                              ; CODE XREF: Enemy_TrackerSt21Damage+58   p  ; was: sub_33402
                tst.w   $48(a5)
                bne.w   locret_334B0
                move.w  #1,$48(a5)
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_334B0
                tst.w   (word_FFFF0E).w
                beq.s   loc_33426
                move.w  #3,d1
                bra.s   loc_3342A
; ---------------------------------------------------------------------------
loc_33426:                              ; CODE XREF: Enemy_TrackerSt21Destroy+1C   j
                move.w  #$F,d1
loc_3342A:                              ; CODE XREF: Enemy_TrackerSt21Destroy+22   j
                move.b  (dword_FFFF08).w,d0
                and.w   d1,d0
                beq.s   loc_33482
                btst    #0,$5E(a5)
                bne.s   loc_33440
                move.w  #1,d0
                bra.s   loc_33444
; ---------------------------------------------------------------------------
loc_33440:                              ; CODE XREF: Enemy_TrackerSt21Destroy+36   j
                move.w  #0,d0
loc_33444:                              ; CODE XREF: Enemy_TrackerSt21Destroy+3C   j
                jsr     (loc_2BD20).l
                bset    #3,2(a0)
                bset    #2,2(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$1C(a0)
                rts
; ---------------------------------------------------------------------------
loc_33482:                              ; CODE XREF: Enemy_TrackerSt21Destroy+2E   j
                bsr.w Enemy_TrackerSt21Collision
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$4C(a0)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$50(a0)
locret_334B0:                           ; CODE XREF: Enemy_TrackerSt21Destroy+4   j
                                        ; Enemy_TrackerSt21Destroy+14   j
                rts
; End of function Enemy_TrackerSt21Destroy
; Tracker follow player (win cutscene)
Enemy_TrackerWinFollow:                              ; CODE XREF: Enemy_TrackerWinMovement+6   j  ; was: sub_334B2
                move.l  (dword_FF8062).w,d0
                move.l  (dword_FFA960).w,d1
                asr.l   #1,d0
                asr.l   #1,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_334D2
                ori.w   #$200,2(a5)
locret_334D2:                           ; CODE XREF: Enemy_TrackerWinFollow+18   j
                rts
; End of function Enemy_TrackerWinFollow
; Tracker off-screen (Stage 21)
Enemy_TrackerSt21OffScreen:                              ; CODE XREF: Enemy_TrackerWinMovement+68   j  ; was: sub_334D4
                                        ; Enemy_TrackerWinMovement+72   j
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_TrackerSt21OffScreen
; Initialize tracker sprite (win)
Enemy_TrackerWinInitSprite:                              ; CODE XREF: Enemy_TrackerSt21SpawnInit+10   p  ; was: sub_334DC
                                        ; Enemy_TrackerWinSpawnBullet+12   p
                move.w  #$3B0,(a0)
                move.w  #$CC00,2(a0)
                move.w  #$6400,$E(a0)
                move.b  #$C0,$21(a0)
                move.b  #$10,$23(a0)
                clr.w   $C(a0)
                rts
; End of function Enemy_TrackerWinInitSprite
; Spawns tracker bullets (win)
Enemy_TrackerWinSpawnBullet:                              ; CODE XREF: Enemy_TrackerWinMain:loc_330DA   p  ; was: sub_334FE
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0 ; '?'
                bne.s   locret_33578
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_33578
                bsr.w Enemy_TrackerWinInitSprite
                move.w  #$400,$E(a0)
                clr.b   $21(a0)
                move.b  #$60,$20(a0) ; '`'
                bset    #0,$5F(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_3357A(pc,d0.w),8(a0)
                clr.w   $C(a0)
                addq.w  #1,$5A(a5)
                move.w  $5A(a5),d0
                andi.w  #7,d0
                add.w   d0,d0
                add.w   d0,d0
                btst    #0,(dword_FF9410).w
                bne.s   loc_33560
                lea     word_3358A(pc),a1
                nop
                bra.s   loc_33566
; ---------------------------------------------------------------------------
loc_33560:                              ; CODE XREF: Enemy_TrackerWinSpawnBullet+58   j
                lea     word_335AA(pc),a1
                nop
loc_33566:                              ; CODE XREF: Enemy_TrackerWinSpawnBullet+60   j
                move.w  (a1,d0.w),$10(a0)
                move.w  2(a1,d0.w),$14(a0)
                move.w  #$40,$48(a0) ; '@'
locret_33578:                           ; CODE XREF: Enemy_TrackerWinSpawnBullet+8   j
                                        ; Enemy_TrackerWinSpawnBullet+10   j
                rts
; End of function Enemy_TrackerWinSpawnBullet
; ---------------------------------------------------------------------------
off_3357A:      dc.l word_1CEC96        ; DATA XREF: Enemy_TrackerWinSpawnBullet+38   r
                dc.l word_1CEC9C
                dc.l word_1CECA8
                dc.l word_1CEC96
word_3358A:     dc.w $1D0, $120, $170, $170, $1D0, $B0, $D0, $170, $1D0, $120, $1D0, $B0, $170, $170, $D0, $170
                                        ; DATA XREF: Enemy_TrackerWinSpawnBullet+5A   o
word_335AA:     dc.w $1D0, $B0, $D0, $80, $170, $80, $1D0, $120, $60, $B0, $D0, $170, $60, $120, $170, $170
                                        ; DATA XREF: Enemy_TrackerWinSpawnBullet:loc_33560   o


; Tracker collision (Stage 21)
Enemy_TrackerSt21Collision:                              ; CODE XREF: Enemy_TrackerSt21Destroy:loc_33482   p  ; was: sub_335CA
                move.w  #$458,(a0)
                move.w  #$8E00,2(a0)
                move.w  #$44C8,$E(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                move.w  #$40,$48(a0) ; '@'
                rts
; End of function Enemy_TrackerSt21Collision
; Tracker bullet (Stage 21)
Projectile_TrackerSt21Bullet:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_335EE
                move.w  4(a5),d0
                lea     off_335FA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_TrackerSt21Bullet
; ---------------------------------------------------------------------------
off_335FA:      dc.w Enemy_TrackerSt21UpdateAI-*        ; DATA XREF: Projectile_TrackerSt21Bullet+4   o
                dc.w Enemy_TrackerSt21UpdateAI_VerticalWave-*
                dc.w Enemy_TrackerSt21Animation-*
                dc.w nullsub_76-*


; Tracker AI update (Stage 21)
Enemy_TrackerSt21UpdateAI:                              ; DATA XREF: ROM:off_335FA   o  ; was: sub_33602
                move.w  $14(a5),$4A(a5)
                addq.w  #2,4(a5)
; Applies sine wave vertical offset to Y position based on frame counter
Enemy_TrackerSt21UpdateAI_VerticalWave:                              ; DATA XREF: ROM:000335FC   o  ; was: loc_3360C
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #3,d0
                move.b  word_3363C(pc,d0.w),d0
                ext.w   d0
                add.w   $4A(a5),d0
                move.w  d0,$14(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_3363A
                move.l  $4C(a5),$18(a5)
                move.l  $50(a5),$1C(a5)
                addq.w  #2,4(a5)
locret_3363A:                           ; CODE XREF: Enemy_TrackerSt21UpdateAI+26   j
                rts
; End of function Enemy_TrackerSt21UpdateAI
; ---------------------------------------------------------------------------
word_3363C:     dc.w $FF00, $100        ; DATA XREF: Enemy_TrackerSt21UpdateAI+14   r


; Tracker animation (Stage 21)
Enemy_TrackerSt21Animation:                              ; DATA XREF: ROM:000335FE   o  ; was: sub_33640
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$10,d0
                bpl.s   locret_33660
                move.w  #$C8,$26(a5)
                jsr (Projectile_CheckLifetime).l
                clr.l   $18(a5)
                clr.l   $1C(a5)
locret_33660:                           ; CODE XREF: Enemy_TrackerSt21Animation+A   j
                rts
; End of function Enemy_TrackerSt21Animation
nullsub_76:                             ; DATA XREF: ROM:00033600   o
                rts
; End of function nullsub_76


; Collision detection
Enemy_FlyerCollision:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_33664
                move.w  4(a5),d0
                lea     off_33670(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyerCollision
; ---------------------------------------------------------------------------
off_33670:      dc.w Enemy_FlyerDamage-*        ; DATA XREF: Enemy_FlyerCollision+4   o
                dc.w Enemy_FlyerUpdateSprites1-*
                dc.w Enemy_FlyerUpdateSprites2-*
                dc.w Enemy_FlyerAnimation1-*
                dc.w Enemy_FlyerRenderUpdate-*


; Damage handler
Enemy_FlyerDamage:                              ; DATA XREF: ROM:off_33670   o  ; was: sub_3367A
                clr.w   $4A(a5)
                cmpi.w  #$3E0,(word_FFDB20).w
                beq.s   loc_336A2
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_33696
                move.w  #$454,(a0)
                move.w  a0,$40(a5)
loc_33696:                              ; CODE XREF: Enemy_FlyerDamage+12   j
                addq.w  #2,4(a5)
                move.w  #$200,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_336A2:                              ; CODE XREF: Enemy_FlyerDamage+A   j
                addq.w  #4,4(a5)
                rts
; End of function Enemy_FlyerDamage
; Updates flyer sprites 1
Enemy_FlyerUpdateSprites1:                              ; DATA XREF: ROM:00033672   o  ; was: sub_336A8
                subq.w  #1,$48(a5)
                bne.s   locret_336B2
                addq.w  #2,4(a5)
locret_336B2:                           ; CODE XREF: Enemy_FlyerUpdateSprites1+4   j
                rts
; End of function Enemy_FlyerUpdateSprites1
; Updates flyer sprites 2
Enemy_FlyerUpdateSprites2:                              ; DATA XREF: ROM:00033674   o  ; was: sub_336B4
                moveq   #0,d0
                move.l  d0,$4C(a5)
                move.l  d0,$50(a5)
                move.l  d0,$54(a5)
                move.l  d0,$58(a5)
                move.l  d0,$5C(a5)
                move.w  #9,d7
                lea     $4C(a5),a1
loc_336D2:                              ; CODE XREF: Enemy_FlyerUpdateSprites2+2C   j
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_336E4
                move.w  #$10,(a0)
                move.w  a0,(a1)+
                dbf     d7,loc_336D2
loc_336E4:                              ; CODE XREF: Enemy_FlyerUpdateSprites2+24   j
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerUpdateSprites2
; Flyer animation 1
Enemy_FlyerAnimation1:                              ; DATA XREF: ROM:00033676   o  ; was: sub_336EA
                cmpi.w  #$3E0,(word_FFDB20).w
                beq.s   loc_336FA
                lea     word_3377A(pc),a1
                nop
                bra.s   loc_33700
; ---------------------------------------------------------------------------
loc_336FA:                              ; CODE XREF: Enemy_FlyerAnimation1+6   j
                lea     word_337A8(pc),a1
                nop
loc_33700:                              ; CODE XREF: Enemy_FlyerAnimation1+E   j
                move.w  $4A(a5),d0
                lea     (a1,d0.w),a1
                lea     $4C(a5),a2
                lea     word_33766(pc),a3
                nop
                move.w  #9,d7
loc_33716:                              ; CODE XREF: Enemy_FlyerAnimation1:loc_33734   j
                move.w  (a1)+,d4
                tst.w   (a2)
                beq.s   loc_33734
                movea.w (a2)+,a0
                move.w  (a3)+,d0
                move.w  #$180,d1
                move.l  #$FFFF0000,d2
                move.l  #$FFFFF000,d3
                bsr.w Enemy_FlyerAnimation2
loc_33734:                              ; CODE XREF: Enemy_FlyerAnimation1+30   j
                dbf     d7,loc_33716
                move.w  (a1)+,$48(a5)
                tst.w   (a1)
                bmi.s   loc_3374C
                addi.w  #$16,$4A(a5)
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_3374C:                              ; CODE XREF: Enemy_FlyerAnimation1+54   j
                move.w  #$1000,2(a5)
                cmpi.w  #$3E0,(word_FFDB20).w
                beq.s   locret_33764
                movea.w $40(a5),a0
                move.w  #$1000,2(a0)
locret_33764:                           ; CODE XREF: Enemy_FlyerAnimation1+6E   j
                rts
; End of function Enemy_FlyerAnimation1
; ---------------------------------------------------------------------------
word_33766:     dc.w $90, $B0, $D0, $F0, $110, $130, $150, $170, $190, $1B0
                                        ; DATA XREF: Enemy_FlyerAnimation1+22   o
word_3377A:     dc.w $200, $1C0, $130, $220, $90, 0, $110, $190
                                        ; DATA XREF: Enemy_FlyerAnimation1+8   o
                dc.w $A0, $30, $200, $1E0, $1B8, $128, $210, $78
                dc.w 0, $F0, $170, $A0, $40, $200, $FFFF
word_337A8:     dc.w 0, $10, $20, $30, $40, $80, $90, $A0
                                        ; DATA XREF: Enemy_FlyerAnimation1:loc_336FA   o
                dc.w $B0, $C0, $100, $C0, $B0, $A0, $90, $80
                dc.w $40, $30, $20, $10, 0, $100, $FFFF


; Render update handler
Enemy_FlyerRenderUpdate:                              ; DATA XREF: ROM:00033678   o  ; was: sub_337D6
                subq.w  #1,$48(a5)
                bne.s   locret_337E2
                move.w  #4,4(a5)
locret_337E2:                           ; CODE XREF: Enemy_FlyerRenderUpdate+4   j
                rts
; End of function Enemy_FlyerRenderUpdate
; Dispatches to appropriate state handler for flyer enemy behavior
Enemy_FlyerStateDispatcher:
                move.w  4(a5),d0  ; was: sub_337E4
                lea     off_337F0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyerStateDispatcher
; ---------------------------------------------------------------------------
off_337F0:      dc.w Enemy_FlyerInitState-*        ; DATA XREF: Enemy_FlyerStateDispatcher+4   o
                dc.w Enemy_FlyerInitState_WaitLoop-*
                dc.w Enemy_FlyerSpawnPair-*
                dc.w Enemy_FlyerSetupAnimation-*
                dc.w Enemy_FlyerVerticalOscillation-*
                dc.w Enemy_FlyerFireMissiray-*


; Initializes flyer with timer and transitions through initialization sequence
Enemy_FlyerInitState:                              ; DATA XREF: ROM:off_337F0   o  ; was: sub_337FC
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
; Wait during initialization and handle Missiray fire
Enemy_FlyerInitState_WaitLoop:                              ; DATA XREF: ROM:000337F2   o  ; was: loc_33806
                bsr.w Enemy_FlyerPeriodicMissirayFire
                subq.w  #1,$48(a5)
                bne.s   locret_3381A
                move.w  #8,$4A(a5)
                addq.w  #2,4(a5)
locret_3381A:                           ; CODE XREF: Enemy_FlyerInitState+12   j
                rts
; End of function Enemy_FlyerInitState
; Spawns pair of projectiles and stores references, handles spawn failure
Enemy_FlyerSpawnPair:                              ; DATA XREF: ROM:000337F4   o  ; was: sub_3381C
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_33840
                move.w  #$10,(a0)
                move.w  a0,$5C(a5)
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_33842
                move.w  #$10,(a0)
                move.w  a0,$5E(a5)
                addq.w  #2,4(a5)
locret_33840:                           ; CODE XREF: Enemy_FlyerSpawnPair+6   j
                rts
; ---------------------------------------------------------------------------
loc_33842:                              ; CODE XREF: Enemy_FlyerSpawnPair+16   j
                movea.w $5C(a5),a0
                move.w  #$1000,2(a0)
                subq.w  #4,4(a5)
                rts
; End of function Enemy_FlyerSpawnPair
; Sets up animation parameters for spawned projectile pair with random offset
Enemy_FlyerSetupAnimation:                              ; DATA XREF: ROM:000337F6   o  ; was: sub_33852
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                add.w   d0,d0
                move.w  word_3389C(pc,d0.w),d0
                move.w  #$170,d1
                movea.w $5C(a5),a0
                move.l  #$FFFF0000,d2
                move.l  #$FFFFF000,d3
                bsr.w Enemy_FlyerAnimation2
                addi.w  #$30,d0 ; '0'
                movea.w $5E(a5),a0
                move.l  #$FFFF0000,d2
                move.l  #$FFFFF000,d3
                bsr.w Enemy_FlyerAnimation2
                move.w  #$30,$48(a5) ; '0'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerSetupAnimation
; ---------------------------------------------------------------------------
word_3389C:     dc.w $90, $A0, $B0, $C0, $D0, $E0, $F0, $100, $110, $120, $130, $140, $150, $160, $170, $180
                                        ; DATA XREF: Enemy_FlyerSetupAnimation+A   r


; Controls vertical oscillation movement for flying enemy
Enemy_FlyerVerticalOscillation:                              ; DATA XREF: ROM:000337F8   o  ; was: sub_338BC
                subq.w  #1,$48(a5)
                bne.s   locret_338CC
                subq.w  #1,$4A(a5)
                beq.s   loc_338CE
                subq.w  #4,4(a5)
locret_338CC:                           ; CODE XREF: Enemy_FlyerVerticalOscillation+4   j
                rts
; ---------------------------------------------------------------------------
loc_338CE:                              ; CODE XREF: Enemy_FlyerVerticalOscillation+A   j
                move.w  #$200,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerVerticalOscillation
; Handles firing Missiray projectile with countdown timer
Enemy_FlyerFireMissiray:                              ; DATA XREF: ROM:000337FA   o  ; was: sub_338DA
                bsr.w Enemy_FlyerPeriodicProjectileFire
                subq.w  #1,$48(a5)
                bne.s   locret_338EA
                move.w  #0,4(a5)
locret_338EA:                           ; CODE XREF: Enemy_FlyerFireMissiray+8   j
                rts
; End of function Enemy_FlyerFireMissiray
; Periodically fires Missiray bullets at random intervals
Enemy_FlyerPeriodicMissirayFire:                              ; CODE XREF: Enemy_FlyerInitState:loc_33806   p  ; was: sub_338EC
                move.w  (word_FFA000).w,d7
                andi.w  #$3F,d7 ; '?'
                bne.s   locret_33922
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_33922
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                addi.w  #$120,d0
                move.w  #$120,d1
                move.l  #$FFFF0000,d2
                move.l  #$FFFFF000,d3
                bsr.w Projectile_MissirayBulletInit
locret_33922:                           ; CODE XREF: Enemy_FlyerPeriodicMissirayFire+8   j
                                        ; Enemy_FlyerPeriodicMissirayFire+10   j
                rts
; End of function Enemy_FlyerPeriodicMissirayFire
; Periodically fires projectiles at intervals with trajectory update
Enemy_FlyerPeriodicProjectileFire:                              ; CODE XREF: Enemy_FlyerFireMissiray   p  ; was: sub_33924
                move.w  (word_FFA000).w,d7
                andi.w  #$3F,d7 ; '?'
                bne.s   locret_33954
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_33954
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                addi.w  #$120,d0
                move.w  #$120,d1
                move.l  #$FFFF0000,d2
                bsr.w Projectile_InitMissirayBullet
locret_33954:                           ; CODE XREF: Enemy_FlyerPeriodicProjectileFire+8   j
                                        ; Enemy_FlyerPeriodicProjectileFire+10   j
                rts
; End of function Enemy_FlyerPeriodicProjectileFire
; Bullet projectile init
Projectile_MissirayBulletInit:                              ; CODE XREF: Enemy_FlyerPeriodicMissirayFire+32   p  ; was: sub_33956
                                        ; Segment_MissirayType1Fire+34   p
                move.b  #0,$47(a0)
                move.l  #word_EB3D8,8(a0)
                move.l  #$F010FE02,$2C(a0)
                move.l  #$F010F808,$28(a0)
                bra.s   loc_33998
; End of function Projectile_MissirayBulletInit
; Flyer animation 2
Enemy_FlyerAnimation2:                              ; CODE XREF: Enemy_FlyerAnimation1+46   p  ; was: sub_33976
                                        ; Enemy_FlyerSetupAnimation+22   p ...
                move.b  #1,$47(a0)
                move.l  #word_EB3FC,8(a0)
                move.l  #$E020FE02,$2C(a0)
                move.l  #$E020F808,$28(a0)
                move.w  d4,$48(a0)
loc_33998:                              ; CODE XREF: Projectile_MissirayBulletInit+1E   j
                move.w  #$3C4,(a0)
                move.w  #$400,$E(a0)
                cmpi.w  #$3E0,(word_FFDB20).w
                bne.s   loc_339B0
                ori.w   #$4000,$E(a0)
loc_339B0:                              ; CODE XREF: Enemy_FlyerAnimation2+32   j
                move.w  #$CC00,2(a0)
                move.w  #$28,$24(a0) ; '('
                move.w  #$64,$26(a0) ; 'd'
                move.b  #$40,$20(a0) ; '@'
                clr.w   $C(a0)
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,$58(a0)
                move.l  d3,$5C(a0)
                rts
; End of function Enemy_FlyerAnimation2
; Flyer animation 3
Enemy_FlyerAnimation3:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_339DE
                tst.w   4(a5)
                beq.s   loc_33A44
                cmpi.w  #$E,4(a5)
                bcc.s   loc_33A44
                cmpi.w  #$3E0,(word_FFDB20).w
                bne.s   loc_33A22
                btst    #1,(byte_FF80EC).w
                bne.w   loc_33A30
                moveq   #0,d0
                move.b  $2C(a5),d0
                ext.w   d0
                add.w   $14(a5),d0
                cmp.w   (dword_FFDB34).w,d0
                bgt.s   loc_33A22
                bset    #6,(byte_FFDB42).w
                move.w  #$12,4(a5)
                clr.b   $21(a5)
                bra.s   loc_33A44
; ---------------------------------------------------------------------------
loc_33A22:                              ; CODE XREF: Enemy_FlyerAnimation3+14   j
                                        ; Enemy_FlyerAnimation3+30   j
                bclr    #7,$22(a5)
                bne.s   loc_33A30
                tst.w   $24(a5)
                bpl.s   loc_33A44
loc_33A30:                              ; CODE XREF: Enemy_FlyerAnimation3+1C   j
                                        ; Enemy_FlyerAnimation3+4A   j
                move.b  #$30,d0 ; '0'
                jsr (Sound_PlaySFX).l
                move.w  #$E,4(a5)
                clr.b   $21(a5)
loc_33A44:                              ; CODE XREF: Enemy_FlyerAnimation3+4   j
                                        ; Enemy_FlyerAnimation3+C   j ...
                move.w  4(a5),d0
                lea     off_33A50(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyerAnimation3
; ---------------------------------------------------------------------------
off_33A50:      dc.w Enemy_FlyerAnimation4-*        ; DATA XREF: Enemy_FlyerAnimation3+6A   o
                dc.w Enemy_FlyerInitFallState-*
                dc.w Enemy_FlyerAccelerateFall-*
                dc.w Projectile_FlyerAccelerateDown-*
                dc.w Projectile_FlyerDecelerate-*
                dc.w Enemy_FlyerAnimation5-*
                dc.w Enemy_FlyerAnimation6-*
                dc.w Projectile_FlyerUpdate3-*
                dc.w Projectile_FlyerUpdate4-*
                dc.w Stage24_UpdateBackground-*
                dc.w Stage24_UpdateForeground-*


; Flyer animation 4
Enemy_FlyerAnimation4:                              ; DATA XREF: ROM:off_33A50   o  ; was: sub_33A66
                tst.b   $47(a5)
                bne.s   loc_33A72
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_33A72:                              ; CODE XREF: Enemy_FlyerAnimation4+4   j
                move.w  #$A,4(a5)
                rts
; End of function Enemy_FlyerAnimation4
; Initializes falling state with velocity and collision parameters
Enemy_FlyerInitFallState:                              ; DATA XREF: ROM:00033A52   o  ; was: sub_33A7A
                move.b  #$C0,$21(a5)
                move.b  #8,$23(a5)
                move.w  #$FFFC,$1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerInitFallState
; Accelerates vertical fall and transitions to flyer projectile state
Enemy_FlyerAccelerateFall:                              ; DATA XREF: ROM:00033A54   o  ; was: sub_33A92
                addi.l  #$1800,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_33ADE
                cmpi.w  #2,$1C(a5)
                bcs.s   locret_33ADE
                clr.l   $1C(a5)
                move.l  #off_EB492,8(a5)
                clr.w   $C(a5)
                ori.w   #$2000,2(a5)
                move.l  #$E020FE02,$2C(a5)
                move.l  #$E020F808,$28(a5)
                move.w  #$18,$48(a5)
                addq.w  #2,4(a5)
                bsr.w Projectile_FlyerUpdate2
locret_33ADE:                           ; CODE XREF: Enemy_FlyerAccelerateFall+E   j
                                        ; Enemy_FlyerAccelerateFall+16   j
                rts
; End of function Enemy_FlyerAccelerateFall
; Projectile update 1
Projectile_FlyerUpdate1:                              ; CODE XREF: Projectile_FlyerAccelerateDown   p  ; was: sub_33AE0
                                        ; sub_33B86   p ...
                move.w  (word_FFA000).w,d7
                andi.w  #3,d7
                beq.s Projectile_FlyerUpdate2
                rts
; End of function Projectile_FlyerUpdate1
; Updates flyer projectile and applies homing behavior on interval
Projectile_FlyerUpdateWithHoming:
                move.w  (word_FFA000).w,d7  ; was: sub_33AEC
                andi.w  #3,d7
                bne.s   locret_33B12
                bsr.s Projectile_FlyerUpdate2
                cmpi.w  #$88,(a0)
                bne.s   locret_33B12
                move.l  #$FE02F40C,$2C(a0)
                move.b  #$40,$21(a0) ; '@'
                move.w  #$32,$26(a0) ; '2'
locret_33B12:                           ; CODE XREF: Projectile_FlyerUpdateWithHoming+8   j
                                        ; Projectile_FlyerUpdateWithHoming+10   j
                rts
; End of function Projectile_FlyerUpdateWithHoming
; Projectile update 2
Projectile_FlyerUpdate2:                              ; CODE XREF: Enemy_FlyerAccelerateFall+48   p  ; was: sub_33B14
                                        ; Projectile_FlyerUpdate1+8   j ...
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_33B52
                jsr (Projectile_InitType88).l
                andi.w  #$FEFF,2(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  #off_E95DC,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $29(a5),d0
                andi.w  #$FF,d0
                add.w   d0,$14(a0)
locret_33B52:                           ; CODE XREF: Projectile_FlyerUpdate2+6   j
                rts
; End of function Projectile_FlyerUpdate2
; Accelerates projectile downward and transitions animation state
Projectile_FlyerAccelerateDown:                              ; DATA XREF: ROM:00033A56   o  ; was: sub_33B54
                bsr.w Projectile_FlyerUpdate1
                addi.l  #$3000,$1C(a5)
                cmpi.w  #$80,$C(a5)
                bcs.s   locret_33B84
                move.l  #word_EB3FC,8(a5)
                clr.w   $C(a5)
                andi.w  #$DFFF,2(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_33B84:                           ; CODE XREF: Projectile_FlyerAccelerateDown+12   j
                rts
; End of function Projectile_FlyerAccelerateDown
; Decelerates projectile and restores original velocity after timer
Projectile_FlyerDecelerate:                              ; DATA XREF: ROM:00033A58   o  ; was: sub_33B86
                bsr.w Projectile_FlyerUpdate1
                addi.l  #-$800,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_33BA2
                move.l  $58(a5),$1C(a5)
                addq.w  #4,4(a5)
locret_33BA2:                           ; CODE XREF: Projectile_FlyerDecelerate+10   j
                rts
; End of function Projectile_FlyerDecelerate
; Flyer animation 5
Enemy_FlyerAnimation5:                              ; DATA XREF: ROM:00033A5A   o  ; was: sub_33BA4
                subq.w  #1,$48(a5)
                bmi.s   loc_33BAC
                rts
; ---------------------------------------------------------------------------
loc_33BAC:                              ; CODE XREF: Enemy_FlyerAnimation5+4   j
                clr.w   $48(a5)
                move.b  #$C0,$21(a5)
                move.b  #8,$23(a5)
                move.l  $58(a5),$1C(a5)
                addq.w  #2,4(a5)
                move.b  #$57,d0 ; 'W'
                jsr (Sound_PlaySFX).l
; End of function Enemy_FlyerAnimation5
; Flyer animation 6
Enemy_FlyerAnimation6:                              ; DATA XREF: ROM:00033A5C   o  ; was: sub_33BD0
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                bsr.w Projectile_FlyerUpdate1
                cmpi.w  #$80,$14(a5)
                bgt.s   locret_33BEA
                move.w  #$1000,2(a5)
locret_33BEA:                           ; CODE XREF: Enemy_FlyerAnimation6+12   j
                rts
; End of function Enemy_FlyerAnimation6
; Projectile update 3
Projectile_FlyerUpdate3:                              ; DATA XREF: ROM:00033A5E   o  ; was: sub_33BEC
                clr.l   $1C(a5)
                btst    #3,(word_FFA40E).w
                bne.s   loc_33C00
                move.w  #$FFFE,$18(a5)
                bra.s   loc_33C06
; ---------------------------------------------------------------------------
loc_33C00:                              ; CODE XREF: Projectile_FlyerUpdate3+A   j
                move.w  #2,$18(a5)
loc_33C06:                              ; CODE XREF: Projectile_FlyerUpdate3+12   j
                addq.w  #2,4(a5)
                move.w  #$18,$48(a5)
                move.l  #$FFFE8000,$1C(a5)
                move.l  #$2000,$5C(a5)
                rts
; End of function Projectile_FlyerUpdate3
; Projectile update 4
Projectile_FlyerUpdate4:                              ; DATA XREF: ROM:00033A60   o  ; was: sub_33C22
                eori.w  #$8000,2(a5)
                bsr.w Projectile_FlyerUpdate1
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_33C48
                move.l  #off_E953C,8(a5)
                jmp Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
locret_33C48:                           ; CODE XREF: Projectile_FlyerUpdate4+16   j
                rts
; End of function Projectile_FlyerUpdate4
; Background update
Stage24_UpdateBackground:                              ; DATA XREF: ROM:00033A62   o  ; was: sub_33C4A
                bclr    #7,2(a5)
                move.w  (dword_FFDB34).w,$14(a5)
                bsr.w Stage24_PaletteUpdate
                move.w  #4,$48(a5)
                move.w  #$20,$4A(a5) ; ' '
                move.w  #4,$4C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Stage24_UpdateBackground
; Foreground update
Stage24_UpdateForeground:                              ; DATA XREF: ROM:00033A64   o  ; was: sub_33C72
                move.w  (dword_FFDB34).w,$14(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_33CD6
                subq.w  #1,$4C(a5)
                beq.s   loc_33CD8
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_33CD0
                move.w  #$10,(a0)
                move.l  #off_E95DC,8(a0)
                jsr (Sprite_InitializeProperties).l
                move.b  #$60,$20(a0) ; '`'
                move.l  #$FE02F40C,$2C(a0)
                move.b  #$40,$21(a0) ; '@'
                move.w  #$32,$26(a0) ; '2'
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),d0
                sub.w   $4A(a5),d0
                move.w  d0,$14(a0)
                addi.w  #8,$4A(a5)
loc_33CD0:                              ; CODE XREF: Stage24_UpdateForeground+18   j
                move.w  #4,$48(a5)
locret_33CD6:                           ; CODE XREF: Stage24_UpdateForeground+A   j
                rts
; ---------------------------------------------------------------------------
loc_33CD8:                              ; CODE XREF: Stage24_UpdateForeground+10   j
                move.w  $4A(a5),d0
                sub.w   d0,$14(a5)
                move.l  #off_E953C,8(a5)
                jmp Sprite_SetObjectPointer
; End of function Stage24_UpdateForeground
; Palette update
Stage24_PaletteUpdate:                              ; CODE XREF: Stage24_UpdateBackground+C   p  ; was: sub_33CEE
                move.w  #2,d7
                move.w  #$40,d6 ; '@'
                lea     (word_1B514).l,a3
loc_33CFC:                              ; CODE XREF: Stage24_PaletteUpdate+28   j
                move.w  d6,d5
                move.w  (a3,d5.w),d2
                move.w  -$80(a3,d5.w),d3
                ext.l   d2
                ext.l   d3
                asl.l   #3,d2
                asl.l   #3,d3
                bsr.w Stage24_TileUpdate
                addi.w  #$40,d6 ; '@'
                dbf     d7,loc_33CFC
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
                rts
; End of function Stage24_PaletteUpdate
; Tile update
Stage24_TileUpdate:                              ; CODE XREF: Stage24_PaletteUpdate+20   p  ; was: sub_33D26
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_33D56
                jsr (Sprite_InitializeProperties).l
                move.b  #$60,$20(a0) ; '`'
                move.l  #off_E953C,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  d2,$18(a0)
                move.l  d3,$1C(a0)
locret_33D56:                           ; CODE XREF: Stage24_TileUpdate+6   j
                rts
; End of function Stage24_TileUpdate
; Initializes Missiray bullet projectile with graphics and parameters
Projectile_InitMissirayBullet:                              ; CODE XREF: Enemy_FlyerPeriodicProjectileFire+2C   p  ; was: sub_33D58
                                        ; Segment_MissirayType1Fire+54   p
                move.w  #$3CC,(a0)
                move.l  #off_ED152,8(a0)
                clr.w   $C(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #$EC00,2(a0)
                move.w  #$300,$E(a0)
                move.b  #$C0,$21(a0)
                move.b  #8,$23(a0)
                move.w  #$28,$24(a0) ; '('
                move.w  #$50,$26(a0) ; 'P'
                move.b  #$60,$20(a0) ; '`'
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,$58(a0)
                rts
; End of function Projectile_InitMissirayBullet
; Dispatches boss projectile state based on damage and conditions
Boss_ProjectileStateDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_33DB0
                tst.w   4(a5)
                beq.s   loc_33DDE
                bclr    #7,$22(a5)
                bne.s   loc_33DCC
                btst    #1,(byte_FF80EC).w
                bne.s   loc_33DCC
                tst.w   $24(a5)
                bpl.s   loc_33DDE
loc_33DCC:                              ; CODE XREF: Boss_ProjectileStateDispatcher+C   j
                                        ; Boss_ProjectileStateDispatcher+14   j
                cmpi.w  #$C,4(a5)
                bcc.s   loc_33DDE
                move.w  #$C,4(a5)
                clr.b   $21(a5)
loc_33DDE:                              ; CODE XREF: Boss_ProjectileStateDispatcher+4   j
                                        ; Boss_ProjectileStateDispatcher+1A   j ...
                move.w  4(a5),d0
                lea     off_33DEA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ProjectileStateDispatcher
; ---------------------------------------------------------------------------
off_33DEA:      dc.w Boss_ProjectileInitFall-*        ; DATA XREF: Boss_ProjectileStateDispatcher+32   o
                dc.w Boss_ProjectileDecelerate-*
                dc.w Boss_ProjectileSetTimer-*
                dc.w Boss_ProjectileTransformAttack-*
                dc.w Boss_ProjectileWaitAnimation-*
                dc.w Boss_ProjectileAccelerateAndExit-*
                dc.w Boss_ProjectileInitSpreadFire-*
                dc.w Boss_ProjectileSpreadFireLoop-*


; Initializes falling motion with velocity for boss projectile
Boss_ProjectileInitFall:                              ; DATA XREF: ROM:off_33DEA   o  ; was: sub_33DFA
                move.l  #$40000,$1C(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ProjectileInitFall
; Decelerates boss projectile fall over timer duration
Boss_ProjectileDecelerate:                              ; DATA XREF: ROM:00033DEC   o  ; was: sub_33E0E
                subi.l  #$3800,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_33E24
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
locret_33E24:                           ; CODE XREF: Boss_ProjectileDecelerate+C   j
                rts
; End of function Boss_ProjectileDecelerate
; Sets timer value for next boss projectile state
Boss_ProjectileSetTimer:                              ; DATA XREF: ROM:00033DEE   o  ; was: sub_33E26
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ProjectileSetTimer
; Transforms projectile graphics and velocity for attack phase
Boss_ProjectileTransformAttack:                              ; DATA XREF: ROM:00033DF0   o  ; was: sub_33E32
                subq.w  #1,$48(a5)
                bne.s   locret_33E64
                move.l  #off_ED156,8(a5)
                clr.w   $C(a5)
                move.l  #$FF01D62A,$2C(a5)
                move.l  #$F808D030,$28(a5)
                move.b  #$10,$23(a5)
                move.l  $58(a5),$1C(a5)
                addq.w  #2,4(a5)
locret_33E64:                           ; CODE XREF: Boss_ProjectileTransformAttack+4   j
                rts
; End of function Boss_ProjectileTransformAttack
; Waits for animation frame threshold before next state
Boss_ProjectileWaitAnimation:                              ; DATA XREF: ROM:00033DF2   o  ; was: sub_33E66
                cmpi.w  #$80,$C(a5)
                bcs.s   locret_33E7E
                move.l  #off_ED13E,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
locret_33E7E:                           ; CODE XREF: Boss_ProjectileWaitAnimation+6   j
                rts
; End of function Boss_ProjectileWaitAnimation
; Accelerates projectile and marks for deletion when off-screen
Boss_ProjectileAccelerateAndExit:                              ; DATA XREF: ROM:00033DF4   o  ; was: sub_33E80
                cmpi.l  #$1C000,$1C(a5)
                bge.s   loc_33E92
                addi.l  #$800,$1C(a5)
loc_33E92:                              ; CODE XREF: Boss_ProjectileAccelerateAndExit+8   j
                cmpi.w  #$180,$14(a5)
                blt.s   locret_33EA0
                move.w  #$1000,2(a5)
locret_33EA0:                           ; CODE XREF: Boss_ProjectileAccelerateAndExit+18   j
                rts
; End of function Boss_ProjectileAccelerateAndExit
; Initializes parameters for spread fire attack pattern
Boss_ProjectileInitSpreadFire:                              ; DATA XREF: ROM:00033DF6   o  ; was: sub_33EA2
                clr.l   $1C(a5)
                move.w  #2,$48(a5)
                move.w  #4,$4A(a5)
                move.w  #8,$4C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ProjectileInitSpreadFire
; Fires projectiles in spread pattern with alternating angles
Boss_ProjectileSpreadFireLoop:                              ; DATA XREF: ROM:00033DF8   o  ; was: sub_33EBE
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_33EFC
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_33EEC
                move.w  $4C(a5),d0
                bsr.w Projectile_SpawnBulletAtOffset
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_33EEC
                move.w  $4C(a5),d0
                neg.w   d0
                bsr.w Projectile_SpawnBulletAtOffset
loc_33EEC:                              ; CODE XREF: Boss_ProjectileSpreadFireLoop+12   j
                                        ; Boss_ProjectileSpreadFireLoop+22   j
                subq.w  #1,$4A(a5)
                beq.s   loc_33EFE
                addq.w  #8,$4C(a5)
                move.w  #2,$48(a5)
locret_33EFC:                           ; CODE XREF: Boss_ProjectileSpreadFireLoop+A   j
                rts
; ---------------------------------------------------------------------------
loc_33EFE:                              ; CODE XREF: Boss_ProjectileSpreadFireLoop+32   j
                move.w  #$1000,2(a5)
                rts
; End of function Boss_ProjectileSpreadFireLoop
; Spawns bullet projectile at offset position from source
Projectile_SpawnBulletAtOffset:                              ; CODE XREF: Boss_ProjectileSpreadFireLoop+18   p  ; was: sub_33F06
                                        ; Boss_ProjectileSpreadFireLoop+2A   p
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E95DC,8(a0)
                jsr (Sprite_InitializeProperties).l
                move.b  #$60,$20(a0) ; '`'
                andi.w  #$FEFF,2(a0)
                rts
; End of function Projectile_SpawnBulletAtOffset
; Loads animation frame data into sprite
Sprite_LoadAnimationFrame:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_33F30
                bsr.w Sprite_InitializeObject
                bsr.w Sprite_UpdateAnimationTimer
                bsr.s Boss_UpdateTimedSoundEffect
                cmpi.w  #2,4(a5)
                bls.w   locret_343CC
                bsr.w Sprite_SetTileProperties
                bsr.w Sprite_ApplyFrameData
                bsr.w Sprite_CalculateFrameOffset
                bsr.w Gfx_SetPaletteUpdateFlag
                rts
; End of function Sprite_LoadAnimationFrame
; Updates timer and plays sound effect at intervals based on offset table
Boss_UpdateTimedSoundEffect:                              ; CODE XREF: Sprite_LoadAnimationFrame+8   p  ; was: sub_33F56
                tst.w   $50(a5)
                beq.s   locret_33F78
                subq.w  #1,(dword_FF9400).w
                bpl.s   locret_33F78
                move.w  $50(a5),d0
                add.w   d0,d0
                move.w  word_33F7A(pc,d0.w),(dword_FF9400).w
                move.b  #$54,d0 ; 'T'
                jsr (Sound_PlaySFX).l
locret_33F78:                           ; CODE XREF: Boss_UpdateTimedSoundEffect+4   j
                                        ; Boss_UpdateTimedSoundEffect+A   j
                rts
; End of function Boss_UpdateTimedSoundEffect
; ---------------------------------------------------------------------------
word_33F7A:     dc.w 0, $28, $20, $2C, $18
                                        ; DATA XREF: Boss_UpdateTimedSoundEffect+12   r


; Initializes sprite object with default values
Sprite_InitializeObject:                              ; CODE XREF: Sprite_LoadAnimationFrame   p  ; was: sub_33F84
                cmpi.w  #2,4(a5)
                bls.w   locret_343CC
                btst    #1,(byte_FF80EC).w
                bne.w   locret_343CC
                tst.w   (word_FF8200).w
                bne.w   locret_343CC
                move.w  #2,4(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #7,d7
                lea     (word_FFC680).w,a0
loc_33FB6:                              ; CODE XREF: Sprite_InitializeObject+6C   j
                move.w  word_FFC6CC-word_FFC680(a0),d2
                add.w   $4C(a5),d2
                add.w   d2,d2
                lea     (word_1B514).l,a1
                move.w  (a1,d2.w),d0
                move.w  -$80(a1,d2.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #4,d0
                asl.l   #4,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                move.l  #off_E95DC,8(a0)
                jsr (Sprite_InitializeProperties).l
                adda.w  #$60,a0 ; '`'
                dbf     d7,loc_33FB6
                move.w  #3,d1
                move.w  #0,d2
                jsr (Gfx_SetAnimationPointer).l
                move.w  #4,d1
                move.w  #$20,d2 ; ' '
                jsr (Gfx_SetAnimationPointer).l
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                move.w  #4,(word_FFA010).w
                move.w  (word_FFA010).w,(word_FFA014).w
                rts
; End of function Sprite_InitializeObject
; Sets palette update flag when sprite flag bit 6 is set
Gfx_SetPaletteUpdateFlag:                              ; CODE XREF: Sprite_LoadAnimationFrame+20   p  ; was: sub_34028
                bclr    #6,$22(a5)
                beq.w   locret_343CC
                move.w  #4,(word_FFA010).w
                move.w  (word_FFA010).w,(word_FFA014).w
                rts
; End of function Gfx_SetPaletteUpdateFlag
; Sets sprite tile VDP properties and flags
Sprite_SetTileProperties:                              ; CODE XREF: Sprite_LoadAnimationFrame+14   p  ; was: sub_34040
                move.l  $50(a5),d0
                add.l   d0,$4C(a5)
                andi.l  #$FFFFFF,$4C(a5)
                move.l  $58(a5),d0
                add.l   d0,$54(a5)
                andi.l  #$FFFFFF,$54(a5)
                tst.l   $58(a5)
                beq.s   loc_34074
                move.w  $5E(a5),d0
                add.w   d0,$5C(a5)
                andi.w  #$FF,$5C(a5)
loc_34074:                              ; CODE XREF: Sprite_SetTileProperties+24   j
                cmpi.w  #$A,4(a5)
                bcs.w   locret_343CC
                move.l  $50(a5),d0
                asr.l   #2,d0
                tst.l   $18(a5)
                bpl.s   loc_3408C
                neg.l   d0
loc_3408C:                              ; CODE XREF: Sprite_SetTileProperties+48   j
                move.l  d0,$18(a5)
                cmpi.w  #$140,$10(a5)
                bcs.s   loc_340A2
                cmpi.w  #$1A0,$10(a5)
                bhi.s   loc_340A2
                rts
; ---------------------------------------------------------------------------
loc_340A2:                              ; CODE XREF: Sprite_SetTileProperties+56   j
                                        ; Sprite_SetTileProperties+5E   j
                neg.l   $18(a5)
                move.l  $18(a5),d0
                add.l   d0,$10(a5)
                rts
; End of function Sprite_SetTileProperties
; Calculates animation frame offset from index
Sprite_CalculateFrameOffset:                              ; CODE XREF: Sprite_LoadAnimationFrame+1C   p  ; was: sub_340B0
                tst.l   (dword_FFC6DC).w
                beq.w   locret_343CC
                move.l  (dword_FFC6DC).w,d0
                add.l   d0,$1C(a5)
                move.l  $1C(a5),d0
                tst.l   d0
                bmi.s   loc_340CA
                neg.l   d0
loc_340CA:                              ; CODE XREF: Sprite_CalculateFrameOffset+16   j
                cmpi.l  #$FFFF8000,d0
                bne.w   locret_343CC
                neg.l   (dword_FFC6DC).w
                rts
; End of function Sprite_CalculateFrameOffset
; Applies frame data to sprite object
Sprite_ApplyFrameData:                              ; CODE XREF: Sprite_LoadAnimationFrame+18   p  ; was: sub_340DA
                move.w  #7,d7
                lea     (word_FFC680).w,a0
loc_340E2:                              ; CODE XREF: Sprite_ApplyFrameData+98   j
                move.w  word_FFC6CC-word_FFC680(a0),d0
                add.w   $4C(a5),d0
                andi.w  #$FF,d0
                add.w   d0,d0
                lea     (word_1B514).l,a1
                move.w  (a1,d0.w),d1
                move.w  -$80(a1,d0.w),d2
                muls.w  $4A(a0),d1
                muls.w  $4A(a0),d2
                swap    d2
                move.w  d2,d5
                move.w  $54(a5),d3
                add.w   d3,d3
                move.w  -$80(a1,d3.w),d4
                muls.w  d4,d2
                asl.l   #2,d2
                move.w  (a1,d3.w),d4
                muls.w  d4,d5
                swap    d5
                andi.w  #$FF,d5
                add.b   $20(a5),d5
                move.b  d5,$20(a0)
                swap    d1
                swap    d2
                move.w  $5C(a5),d0
                add.w   d0,d0
                move.w  (a1,d0.w),d3
                move.w  -$80(a1,d0.w),d4
                muls.w  d1,d3
                muls.w  d2,d4
                sub.l   d4,d3
                asl.l   #2,d3
                move.l  d3,d5
                move.w  (a1,d0.w),d3
                move.w  -$80(a1,d0.w),d4
                muls.w  d1,d4
                muls.w  d2,d3
                add.l   d4,d3
                asl.l   #2,d3
                move.l  d3,d6
                move.l  d5,d1
                move.l  d6,d2
                add.l   $10(a5),d1
                add.l   $14(a5),d2
                move.l  d1,$10(a0)
                move.l  d2,$14(a0)
                adda.w  #$60,a0 ; '`'
                dbf     d7,loc_340E2
                rts
; End of function Sprite_ApplyFrameData
; Updates sprite animation timer and frame
Sprite_UpdateAnimationTimer:                              ; CODE XREF: Sprite_LoadAnimationFrame+4   p  ; was: sub_34178
                move.w  4(a5),d0
                lea     off_34184(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Sprite_UpdateAnimationTimer
; ---------------------------------------------------------------------------
off_34184:      dc.w Sprite_AdvanceToNextFrame-*        ; DATA XREF: Sprite_UpdateAnimationTimer+4   o
                dc.w Sprite_DestroyObject-*
                dc.w Sprite_LoadFrameTiles-*
                dc.w Sprite_ApplyTileMapping-*
                dc.w Boss_CheckPositionAndSetVelocity-*
                dc.w Boss_InitializeAngleOffset-*
                dc.w Boss_HomingProjectileAttack-*
                dc.w Boss_MultiProjectileSpread-*
                dc.w Boss_WaitTimerComplete-*
                dc.w Boss_IncrementVelocityUntilMax-*


; Advances sprite to next animation frame
Sprite_AdvanceToNextFrame:                              ; DATA XREF: ROM:off_34184   o  ; was: sub_34198
                move.l  #word_EB592,8(a5)
                move.w  #$B00,$E(a5)
                move.w  #$CC00,2(a5)
                move.b  #$40,$20(a5) ; '@'
                move.w  #$200,$10(a5)
                move.w  #$118,$14(a5)
                move.l  #$F010F010,$28(a5)
                move.b  #$50,$21(a5) ; 'P'
                move.w  #2,$26(a5)
                clr.w   (word_FF8200).w
                move.w  #$28,$24(a5) ; '('
                move.b  #6,(byte_FF80EC).w
                move.b  #$80,$23(a5)
                move.w  #7,d7
                clr.w   d6
                lea     (word_FFC680).w,a0
loc_341F2:                              ; CODE XREF: Sprite_AdvanceToNextFrame+9E   j
                move.w  #$10,(a0)
                move.l  #word_EB5B0,8(a0)
                move.w  #$B00,$E(a0)
                move.w  #$CC00,2(a0)
                move.b  #$50,$21(a0) ; 'P'
                move.w  #2,$26(a0)
                move.l  #$FC04FC04,$28(a0)
                move.b  #$10,$23(a0)
                move.w  d6,$4C(a0)
                move.w  #$BC,$4A(a0)
                addi.w  #$20,d6 ; ' '
                adda.w  #$60,a0 ; '`'
                dbf     d7,loc_341F2
                move.l  #$FFFF8000,$1C(a5)
                move.l  #$800,(dword_FFC6DC).w
                move.w  #4,4(a5)
                movem.l a5,-(sp)
                lea     stru_34266(pc),a0
                nop
                jsr (Data_ProcessPointer).l
                movem.l (sp)+,a5
                rts
; End of function Sprite_AdvanceToNextFrame
; ---------------------------------------------------------------------------
stru_34266:     dc.w 7                  ; field_0
                                        ; DATA XREF: Sprite_AdvanceToNextFrame+BC   o
                dc.l tiles_10F51C       ; field_2
                dc.w $6000              ; field_6
                dc.w $FFFF


; Clears sprite object flag destroying it
Sprite_DestroyObject:                              ; DATA XREF: ROM:00034186   o  ; was: sub_34270
                clr.w   (a5)
                rts
; End of function Sprite_DestroyObject
; Loads frame tile indices into sprite
Sprite_LoadFrameTiles:                              ; DATA XREF: ROM:00034188   o  ; was: sub_34274
                tst.w   (word_FFF720).w
                bmi.w   locret_343CC
                move.w  #$C0,$54(a5)
                move.l  #$40000,$50(a5)
                move.w  #2,$5E(a5)
                move.l  #$FFFF0000,$18(a5)
                addq.w  #2,4(a5)
                rts
; End of function Sprite_LoadFrameTiles
; Applies tile mapping to sprite object
Sprite_ApplyTileMapping:                              ; DATA XREF: ROM:0003418A   o  ; was: sub_3429E
                cmpi.w  #$1C0,$10(a5)
                bcc.w   locret_343CC
                move.w  #$1E00,(word_FF8202).w
                move.w  #$1E00,(word_FF8200).w
                clr.b   (byte_FF80EC).w
                addq.w  #2,4(a5)
                rts
; End of function Sprite_ApplyTileMapping
; Checks if X position < 0x180 then sets velocity to 0x8000
Boss_CheckPositionAndSetVelocity:                              ; DATA XREF: ROM:0003418C   o  ; was: sub_342BE
                cmpi.w  #$180,$10(a5)
                bcc.w   locret_343CC
                move.l  #$8000,$58(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_CheckPositionAndSetVelocity
; Initializes angle offset from timer with adjustment based on direction flag
Boss_InitializeAngleOffset:                              ; DATA XREF: ROM:0003418E   o  ; was: sub_342D6
                addq.w  #2,4(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                move.w  d0,$48(a5)
                tst.w   (word_FFFF0E).w
                bne.w   locret_343CC
                addi.w  #$40,$48(a5) ; '@'
                rts
; End of function Boss_InitializeAngleOffset
; Calculates angle to player and spawns homing projectiles after timer expires
Boss_HomingProjectileAttack:                              ; DATA XREF: ROM:00034190   o  ; was: sub_342F6
                subq.w  #1,$48(a5)
                bpl.w   loc_34326
                jsr (Math_CalculateAngleToPlayer).l
                move.w  d2,d6
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_343CC
                move.w  #$FFE8,d0
                clr.w   d1
                move.w  #$8004,d2
                jsr (Enemy_InitHomingProjectile).l
                move.w  #$A,4(a5)
loc_34326:                              ; CODE XREF: Boss_HomingProjectileAttack+4   j
                tst.l   $54(a5)
                bne.w   locret_343CC
                eori.b  #1,$4A(a5)
                clr.l   $58(a5)
                move.w  #$E,4(a5)
                rts
; End of function Boss_HomingProjectileAttack
; Spawns 8 spread projectiles in circular pattern when counter reaches zero
Boss_MultiProjectileSpread:                              ; DATA XREF: ROM:00034192   o  ; was: sub_34340
                subi.l  #$800,$50(a5)
                bne.w   locret_343CC
                addq.w  #2,4(a5)
                tst.w   (word_FFFF0E).w
                beq.w   locret_343CC
                move.w  #$20,$48(a5) ; ' '
                movem.w a5,-(sp)
                lea     (word_FFC680).w,a5
                move.w  #7,d4
loc_3436A:                              ; CODE XREF: Boss_MultiProjectileSpread+52   j
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_34396
                clr.w   d0
                clr.w   d1
                move.w  #$8004,d2
                move.w  $4C(a5),d6
                add.w   (word_FFC66C).w,d6
                andi.w  #$FF,d6
                add.w   d6,d6
                jsr (Enemy_InitHomingProjectile).l
                adda.w  #$60,a5 ; '`'
                dbf     d4,loc_3436A
loc_34396:                              ; CODE XREF: Boss_MultiProjectileSpread+30   j
                movem.w (sp)+,a5
                rts
; End of function Boss_MultiProjectileSpread
; Waits for timer countdown then advances to next state
Boss_WaitTimerComplete:                              ; DATA XREF: ROM:00034194   o  ; was: sub_3439C
                subq.w  #1,$48(a5)
                bpl.w   locret_343CC
                addq.w  #2,4(a5)
                rts
; End of function Boss_WaitTimerComplete
; Increases velocity by 0x800 until reaching 0x40000 threshold
Boss_IncrementVelocityUntilMax:                              ; DATA XREF: ROM:00034196   o  ; was: sub_343AA
                addi.l  #$800,$50(a5)
                cmpi.l  #$40000,$50(a5)
                bcs.w   locret_343CC
                move.l  #$8000,$58(a5)
                move.w  #$A,4(a5)
locret_343CC:                           ; CODE XREF: Sprite_LoadAnimationFrame+10   j
                                        ; Sprite_InitializeObject+6   j ...
                rts
; End of function Boss_IncrementVelocityUntilMax
; Initializes metasprite with simple parameter setup
Sprite_InitMetaspriteSimple:                              ; CODE XREF: Boss_AntroidSetupMetasprite+2   j  ; was: sub_343CE
                                        ; Boss_TerobusterInitMetasprite+2   p ...
                bsr.w Sprite_InitMetaspritePointers
                bra.w Sprite_IncrementMetaspriteCount
; End of function Sprite_InitMetaspriteSimple
; Updates metasprite part angles from table
Sprite_UpdateMetaspriteAngles:                              ; CODE XREF: Boss_FlyingNeoUpdateSprites+2E   p  ; was: sub_343D6
                bsr.w Sprite_UpdateMetaspriteRotation
                bra.w Sprite_IncrementMetaspriteCount
; End of function Sprite_UpdateMetaspriteAngles
; Updates metasprite part angles
Sprite_UpdateMetaspriteParts:                              ; CODE XREF: Boss_DeepStriderUpdateParts+D0   j  ; was: sub_343DE
                bsr.w Sprite_CalculateRotationOffset
                bra.w Sprite_IncrementMetaspriteCount
; End of function Sprite_UpdateMetaspriteParts
; Updates metasprite parts
Boss_BackStringerUpdateMetasprite:                              ; CODE XREF: Boss_BackStringerUpdateRender+A   j  ; was: sub_343E6
                bsr.w Boss_CalculateSegmentChain
                bra.w Sprite_IncrementMetaspriteCount
; End of function Boss_BackStringerUpdateMetasprite
; Complex metasprite initialization with flags and rotation
Sprite_InitMetaspriteComplex:                              ; CODE XREF: Boss_AntroidInitPhase+20   p  ; was: sub_343EE
                                        ; Boss_TerobusterSetup+28   p ...
                move.w  a5,(dword_FF8040+2).w
loc_343F2:                              ; CODE XREF: Boss_AntroidInitPhase+3A   p
                moveq   #0,d0
                move.w  d0,d1
                move.w  d0,d2
                move.w  d0,d3
loc_343FA:                              ; CODE XREF: Sprite_InitMetaspriteComplex+108   j
                move.l  (a0,d1.w),d4
                beq.w   loc_34486
                move.l  d4,d5
                move.l  d4,d6
                movea.l d4,a3
                andi.l  #$7FFFFFF,d4
                andi.l  #$F0000000,d5
                andi.l  #$8000000,d6
                bclr    #0,d4
                bne.s   loc_3445A
                bclr    #$16,d4
                beq.s   loc_3443C
                move.w  #$C000,2(a4)
                move.w  (dword_FF8040).w,$E(a4)
                move.l  d4,8(a4)
                clr.l   $4C(a4)
                bra.s   loc_34486
; ---------------------------------------------------------------------------
loc_3443C:                              ; CODE XREF: Sprite_InitMetaspriteComplex+36   j
                move.w  #$C000,2(a4)
                move.w  (dword_FF8040).w,$E(a4)
                move.l  d4,$4C(a4)
                rol.l   #8,d5
                rol.w   #1,d5
                swap    d6
                or.w    d6,d5
                move.w  d5,$50(a4)
                bra.s   loc_34486
; ---------------------------------------------------------------------------
loc_3445A:                              ; CODE XREF: Sprite_InitMetaspriteComplex+30   j
                move.w  #$8000,2(a4)
                movem.l a3,-(sp)
                movea.l d4,a3
                move.w  (a3)+,$E(a4)
                move.w  (a3)+,8(a4)
                move.w  (a3),$A(a4)
                movem.l (sp)+,a3
                clr.l   $4C(a4)
                move.w  (dword_FF8040).w,d4
                andi.w  #$8000,d4
                or.w    d4,$E(a4)
loc_34486:                              ; CODE XREF: Sprite_InitMetaspriteComplex+10   j
                                        ; Sprite_InitMetaspriteComplex+4C   j ...
                move.w  d0,d4
                move.b  (a1,d3.w),d4
                move.w  d4,d5
                andi.w  #$7F,d4
                move.w  d4,$52(a4)
                move.w  d4,$54(a4)
                move.w  d0,$56(a4)
                andi.w  #$80,d5
                beq.s   loc_344AA
                ori.w   #$8000,$E(a4)
loc_344AA:                              ; CODE XREF: Sprite_InitMetaspriteComplex+B4   j
                move.w  (a2,d2.w),d4
                move.w  d4,d5
                andi.w  #$3FE0,d4
                add.w   (dword_FF8040+2).w,d4
                move.w  d4,$4A(a4)
                move.w  (dword_FF8040+2).w,$48(a4)
                move.w  d5,d4
                andi.w  #$C000,d4
                andi.w  #$1F,d5
                asl.w   #2,d5
                move.b  d5,$20(a4)
                move.l  a3,d5
                andi.l  #$3000000,d5
                swap    d5
                asl.w   #5,d5
                lsr.w   #1,d4
                or.w    d4,$E(a4)
                or.w    d5,$E(a4)
                move.w  #$10,(a4)
                addq.w  #4,d1
                addq.w  #2,d2
                addq.w  #1,d3
                lea     $60(a4),a4
                dbf     d7,loc_343FA
                ori.w   #$C00,2(a5)
                rts
; End of function Sprite_InitMetaspriteComplex
; Initializes metasprite pointers and count for rendering
Sprite_InitMetaspritePointers:                              ; CODE XREF: Sprite_InitMetaspriteSimple   p  ; was: sub_34502
                                        ; Boss_MadamBarbarUpdateParts+6   p ...
                movea.w a5,a4
                movea.w a4,a3
                lea     $60(a4),a4
                move.w  d7,(dword_FF8040).w
; End of function Sprite_InitMetaspritePointers
; Updates metasprite rotation and sine-based positioning
Sprite_UpdateMetaspriteRotation:                              ; CODE XREF: Sprite_UpdateMetaspriteAngles   p  ; was: sub_3450E
                lea     (word_1B514).l,a2
                move.w  $54(a5),d3
                move.w  $56(a5),d4
                move.w  $50(a5),d5
                move.w  #$1FE,d6
loc_34524:                              ; CODE XREF: Sprite_UpdateMetaspriteRotation+9E   j
                move.w  $56(a4),d0
                add.w   d4,d0
                move.l  $4C(a4),d1
                beq.s   loc_34574
                movea.l d1,a0
                move.w  $E(a4),d2
                move.w  d0,d1
                add.w   $50(a4),d1
                subi.w  #$10,d1
                and.w   d6,d1
                ori.w   #$1800,d2
                cmpi.w  #$100,d1
                bpl.s   loc_34550
                andi.w  #$E7FF,d2
loc_34550:                              ; CODE XREF: Sprite_UpdateMetaspriteRotation+3C   j
                cmpi.w  #$100,d3
                bmi.s   loc_3455A
                eori.w  #$800,d2
loc_3455A:                              ; CODE XREF: Sprite_UpdateMetaspriteRotation+46   j
                asr.w   #3,d1
                andi.w  #$1C,d1
                move.l  (a0,d1.w),8(a4)
                move.w  $50(a4),d1
                andi.w  #$800,d1
                eor.w   d1,d2
                move.w  d2,$E(a4)
loc_34574:                              ; CODE XREF: Sprite_UpdateMetaspriteRotation+20   j
                move.w  $54(a4),d2
                add.w   d5,d2
                bpl.s   loc_3457E
                moveq   #0,d2
loc_3457E:                              ; CODE XREF: Sprite_UpdateMetaspriteRotation+6C   j
                move.w  d0,d1
                add.w   d3,d1
                and.w   d6,d0
                and.w   d6,d1
                move.w  -$80(a2,d0.w),d0
                move.w  (a2,d1.w),d1
                asl.w   #2,d2
                muls.w  d2,d0
                muls.w  d2,d1
                movea.w $4A(a4),a0
                add.l   $44(a0),d0
                move.l  d0,$44(a4)
                add.l   $40(a0),d1
                move.l  d1,$40(a4)
                lea     $60(a4),a4
                dbf     d7,loc_34524
                rts
; End of function Sprite_UpdateMetaspriteRotation
; Plays intro sound effects
Boss_ValkiriePlayIntroSFX:                              ; CODE XREF: Boss_ValkirieMovePattern3+2   j  ; was: sub_345B2
                movea.w a5,a4
                move.w  d7,(dword_FF8040).w
                lea     $60(a4),a4
                lea     (word_1B514).l,a2
                move.w  $56(a5),d4
                move.w  $50(a5),d5
                move.w  #$1FE,d6
loc_345CE:                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+A4   j
                move.w  $56(a4),d0
                add.w   d4,d0
                move.l  $4C(a4),d1
                beq.s   loc_3461E
                movea.l d1,a0
                move.w  $E(a4),d2
                move.w  d0,d1
                add.w   $50(a4),d1
                subi.w  #$10,d1
                and.w   d6,d1
                ori.w   #$1800,d2
                cmpi.w  #$100,d1
                bpl.s   loc_345FA
                andi.w  #$E7FF,d2
loc_345FA:                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+42   j
                cmpi.w  #$100,d3
                bmi.s   loc_34604
                eori.w  #$800,d2
loc_34604:                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+4C   j
                asr.w   #3,d1
                andi.w  #$1C,d1
                move.l  (a0,d1.w),8(a4)
                move.w  $50(a4),d1
                andi.w  #$800,d1
                eor.w   d1,d2
                move.w  d2,$E(a4)
loc_3461E:                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+26   j
                move.w  $54(a4),d2
                add.w   d5,d2
                bpl.s   loc_34628
                moveq   #0,d2
loc_34628:                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+72   j
                move.w  d0,d1
                add.w   d3,d1
                and.w   d6,d0
                and.w   d6,d1
                move.w  -$80(a2,d0.w),d0
                move.w  (a2,d1.w),d1
                asl.w   #2,d2
                muls.w  d2,d0
                muls.w  d2,d1
                movea.w $4A(a4),a0
                add.l   $44(a0),d0
                move.l  d0,$44(a4)
                add.l   $40(a0),d1
                move.l  d1,$40(a4)
                lea     $60(a4),a4
                dbf     d7,loc_345CE
                movea.w a5,a4
                move.w  (dword_FF8040).w,d7
                addq.w  #1,d7
                movea.w $48(a5),a0
                movea.w $4A(a5),a1
                move.w  $10(a0),d0
                sub.w   $40(a0),d0
                move.w  $14(a1),d1
                sub.w   $44(a1),d1
loc_3467A:                              ; CODE XREF: Boss_ValkiriePlayIntroSFX+E0   j
                move.w  d0,d2
                add.w   $40(a4),d2
                move.w  d2,$10(a4)
                move.w  d1,d2
                add.w   $44(a4),d2
                move.w  d2,$14(a4)
                lea     $60(a4),a4
                dbf     d7,loc_3467A
                rts
; End of function Boss_ValkiriePlayIntroSFX
; Updates metasprite parts with rotation and position calculations
Sprite_CalculateRotationOffset:                              ; CODE XREF: Sprite_UpdateMetaspriteParts   p  ; was: sub_34698
                movea.w a5,a4
                movea.w a4,a3
                lea     $60(a4),a4
                move.w  d7,(dword_FF8040).w
                lea     (word_1B514).l,a2
                move.w  $54(a5),d3
                move.w  $56(a5),d4
                move.w  $50(a5),d5
                move.w  #$1FE,d6
loc_346BA:                              ; CODE XREF: Sprite_CalculateRotationOffset+AA   j
                move.w  $56(a4),d0
                add.w   d4,d0
                move.l  $4C(a4),d1
                beq.s   loc_3470A
                movea.l d1,a0
                move.w  $E(a4),d2
                move.w  d0,d1
                add.w   $50(a4),d1
                subi.w  #$20,d1 ; ' '
                and.w   d6,d1
                ori.w   #$1800,d2
                cmpi.w  #$100,d1
                bpl.s   loc_346E6
                andi.w  #$E7FF,d2
loc_346E6:                              ; CODE XREF: Sprite_CalculateRotationOffset+48   j
                cmpi.w  #$100,d3
                bmi.s   loc_346F0
                eori.w  #$800,d2
loc_346F0:                              ; CODE XREF: Sprite_CalculateRotationOffset+52   j
                asr.w   #4,d1
                andi.w  #$C,d1
                move.l  (a0,d1.w),8(a4)
                move.w  $50(a4),d1
                andi.w  #$800,d1
                eor.w   d1,d2
                move.w  d2,$E(a4)
loc_3470A:                              ; CODE XREF: Sprite_CalculateRotationOffset+2C   j
                move.w  $54(a4),d2
                add.w   d5,d2
                bpl.s   loc_34714
                moveq   #0,d2
loc_34714:                              ; CODE XREF: Sprite_CalculateRotationOffset+78   j
                move.w  d0,d1
                add.w   d3,d1
                and.w   d6,d0
                and.w   d6,d1
                move.w  -$80(a2,d0.w),d0
                move.w  (a2,d1.w),d1
                asl.w   #2,d2
                muls.w  d2,d0
                muls.w  d2,d1
                movea.w $4A(a4),a0
                add.l   $44(a0),d0
                move.l  d0,$44(a4)
                add.l   $40(a0),d1
                move.l  d1,$40(a4)
                lea     $60(a4),a4
                dbf     d7,loc_346BA
                rts
; End of function Sprite_CalculateRotationOffset
; Calculates positions and rotations for chain of sprite segments
Boss_CalculateSegmentChain:                              ; CODE XREF: Boss_BackStringerUpdateMetasprite   p  ; was: sub_34748
                movea.w a5,a4
                movea.w a4,a3
                lea     $60(a4),a4
                move.w  d7,(dword_FF8040).w
                lea     (word_1B514).l,a2
                move.w  $54(a5),d3
                move.w  $56(a5),d4
                move.w  $50(a5),d5
                move.w  #$1FE,d6
loc_3476A:                              ; CODE XREF: Boss_CalculateSegmentChain+EA   j
                move.w  $56(a4),d0
                add.w   d4,d0
                move.l  $4C(a4),d1
                beq.s   loc_347BA
                movea.l d1,a0
                move.w  $E(a4),d2
                move.w  d0,d1
                add.w   $50(a4),d1
                subi.w  #$10,d1
                and.w   d6,d1
                ori.w   #$1800,d2
                cmpi.w  #$100,d1
                bpl.s   loc_34796
                andi.w  #$E7FF,d2
loc_34796:                              ; CODE XREF: Boss_CalculateSegmentChain+48   j
                cmpi.w  #$100,d3
                bmi.s   loc_347A0
                eori.w  #$800,d2
loc_347A0:                              ; CODE XREF: Boss_CalculateSegmentChain+52   j
                asr.w   #3,d1
                andi.w  #$1C,d1
                move.l  (a0,d1.w),8(a4)
                move.w  $50(a4),d1
                andi.w  #$800,d1
                eor.w   d1,d2
                move.w  d2,$E(a4)
loc_347BA:                              ; CODE XREF: Boss_CalculateSegmentChain+2C   j
                move.w  $54(a4),d2
                add.w   d5,d2
                bpl.s   loc_347C4
                moveq   #0,d2
loc_347C4:                              ; CODE XREF: Boss_CalculateSegmentChain+78   j
                move.w  d0,d1
                add.w   d3,d1
                and.w   d6,d0
                and.w   d6,d1
                movea.w $4A(a4),a0
                btst    #1,$20(a4)
                bne.s   loc_347DA
                addq.w  #8,a0
loc_347DA:                              ; CODE XREF: Boss_CalculateSegmentChain+8E   j
                move.w  -$80(a2,d0.w),(word_FF8048).w
                move.w  (a2,d1.w),(word_FF804A).w
                move.w  (word_FF8048).w,d0
                move.w  (word_FF804A).w,d1
                asl.w   #2,d2
                muls.w  d2,d0
                muls.w  d2,d1
                add.l   $3C(a0),d0
                move.l  d0,$44(a4)
                add.l   $38(a0),d1
                move.l  d1,$40(a4)
                btst    #0,$20(a4)
                beq.s   loc_3482E
                move.w  d2,d0
                asr.w   #1,d0
                add.w   d0,d2
                move.w  (word_FF8048).w,d0
                move.w  (word_FF804A).w,d1
                muls.w  d2,d0
                muls.w  d2,d1
                add.l   $3C(a0),d0
                move.l  d0,$3C(a4)
                add.l   $38(a0),d1
                move.l  d1,$38(a4)
loc_3482E:                              ; CODE XREF: Boss_CalculateSegmentChain+C2   j
                lea     $60(a4),a4
                dbf     d7,loc_3476A
                rts
; End of function Boss_CalculateSegmentChain
; Increments metasprite object counter
Sprite_IncrementMetaspriteCount:                              ; CODE XREF: Sprite_InitMetaspriteSimple+4   j  ; was: sub_34838
                                        ; Sprite_UpdateMetaspriteAngles+4   j ...
                move.w  (dword_FF8040).w,d7
                addq.w  #1,d7
; End of function Sprite_IncrementMetaspriteCount
; Updates positions of linked child objects from parent
Sprite_UpdateLinkedPositions:                              ; CODE XREF: Boss_JetsripperRotateState+42   p  ; was: sub_3483E
                                        ; Boss_JetsripperUpdateMovement+A0   p ...
                movea.w $48(a5),a0
                movea.w $4A(a5),a1
                move.w  $10(a0),d0
                sub.w   $40(a0),d0
                move.w  $14(a1),d1
                sub.w   $44(a1),d1
loc_34856:                              ; CODE XREF: Sprite_UpdateLinkedPositions+30   j
                move.w  d0,d2
                add.w   $40(a3),d2
                move.w  d2,$10(a3)
                move.w  d1,d2
                add.w   $44(a3),d2
                move.w  d2,$14(a3)
                lea     $60(a3),a3
                dbf     d7,loc_34856
                rts
; End of function Sprite_UpdateLinkedPositions
; Updates boss blade sprite and flip
Sprite_UpdateBossBladeSprite:                              ; CODE XREF: Boss_SharpssteelCoreMain+10   p  ; was: sub_34874
                                        ; Boss_SharpssteelCoreMain+20   j ...
                move.w  $56(a0),d0
                add.w   $56(a5),d0
                addi.w  #$20,d0 ; ' '
                andi.w  #$1FE,d0
                cmpi.w  #$100,d0
                bmi.s   loc_34890
                eori.w  #$1800,$E(a0)
loc_34890:                              ; CODE XREF: Sprite_UpdateBossBladeSprite+14   j
                tst.w   $54(a5)
                bne.s   loc_3489C
                eori.w  #$800,$E(a0)
loc_3489C:                              ; CODE XREF: Sprite_UpdateBossBladeSprite+20   j
                asr.w   #4,d0
                andi.w  #$C,d0
                move.l  (a1,d0.w),8(a0)
                rts
; End of function Sprite_UpdateBossBladeSprite
; Calculates interpolation deltas for animation blending
Anim_CalculateInterpolationDeltas:                              ; CODE XREF: Boss_AntroidResetAnimation+10   j  ; was: sub_348AA
                                        ; Boss_TerobusterCalculateDeltas+10   j ...
                move.w  #$FF,d4
loc_348AE:                              ; CODE XREF: Anim_CalculateInterpolationDeltas+1C   j
                move.b  (a0)+,d0
                move.w  (a2)+,d1
                asr.w   #8,d1
                sub.b   (a1),d0
                sub.b   (a1)+,d1
                and.w   d4,d0
                and.w   d4,d1
                sub.w   d1,d0
                ext.l   d0
                lsl.w   #8,d0
                divs.w  d3,d0
                move.w  d0,(a2)+
                dbf     d7,loc_348AE
                rts
; End of function Anim_CalculateInterpolationDeltas
; Loads animation frame delays converting bytes to words
Anim_LoadFrameDelays:                              ; CODE XREF: Boss_AntroidLoadFrameDelays+6   j  ; was: sub_348CC
                                        ; Boss_TerobusterLoadFrameDelays+6   j ...
                moveq   #0,d1
loc_348CE:                              ; CODE XREF: Anim_LoadFrameDelays+A   j
                move.b  (a0)+,d0
                asl.w   #8,d0
                move.w  d0,(a1)+
                move.w  d1,(a1)+
                dbf     d7,loc_348CE
                rts
; End of function Anim_LoadFrameDelays
; Applies single interpolation step to animation values
Anim_ApplyInterpolationStep:                              ; CODE XREF: Anim_InterpolateToTarget+8C   p  ; was: sub_348DC
                                        ; Boss_TerobusterInterpolateAnimation+6C   p ...
                movea.l a0,a1
loc_348DE:                              ; CODE XREF: Anim_ApplyInterpolationStep+A   j
                move.w  (a0)+,d1
                add.w   (a0)+,d1
                move.w  d1,(a1)
                addq.w  #4,a1
                dbf     d7,loc_348DE
                rts
; End of function Anim_ApplyInterpolationStep
; Clears 0x11 longwords in RAM buffer starting at 0xFFFF9400
Data_ClearBuffer:
                move.w  #$10,d7  ; was: sub_348EC
                moveq   #0,d0
                movea.l #$FFFF9400,a0
loc_348F8:                              ; CODE XREF: Data_ClearBuffer+E   j
                move.l  d0,(a0)+
                dbf     d7,loc_348F8
                rts
; End of function Data_ClearBuffer
; Updates sprite tile mapping based on rotation angle with horizontal flip
Sprite_UpdateRotatedFrame:                              ; CODE XREF: Projectile_BackStringerChainFalling:loc_45ACA   j  ; was: sub_34900
                movea.l $4C(a5),a0
                move.w  $E(a5),d2
                move.w  $56(a5),d1
                add.w   $50(a5),d1
                subi.w  #$10,d1
                andi.w  #$1FE,d1
                ori.w   #$1800,d2
                cmpi.w  #$100,d1
                bpl.s   loc_34926
                andi.w  #$E7FF,d2
loc_34926:                              ; CODE XREF: Sprite_UpdateRotatedFrame+20   j
                cmpi.w  #$100,d3
                bmi.s   loc_34930
                eori.w  #$800,d2
loc_34930:                              ; CODE XREF: Sprite_UpdateRotatedFrame+2A   j
                asr.w   #3,d1
                andi.w  #$1C,d1
                move.l  (a0,d1.w),8(a5)
                move.w  $50(a5),d1
                andi.w  #$800,d1
                eor.w   d1,d2
                move.w  d2,$E(a5)
                rts
; End of function Sprite_UpdateRotatedFrame
; ---------------------------------------------------------------------------
off_3494C:      dc.l word_EB774         ; DATA XREF: ROM:000349CA   o
                                        ; ROM:000349D2   o ...
                dc.l word_EB76E
                dc.l word_EB768
                dc.l word_EB762
                dc.l word_EB75C
                dc.l word_EB756
                dc.l word_EB750
                dc.l word_EB74A
off_3496C:      dc.l word_EB77A         ; DATA XREF: ROM:000349D6   o
                                        ; ROM:000349EE   o
                dc.l word_EB780
                dc.l word_EB78C
                dc.l word_EB798
                dc.l word_EB7A4
                dc.l word_EB7AA
                dc.l word_EB7B6
                dc.l word_EB7C2
word_3498C:     dc.w $305, $F00, $F0F0  ; DATA XREF: ROM:000349BA   o
word_34992:     dc.w $325, $A00, $F4F4  ; DATA XREF: ROM:off_349B6   o
word_34998:     dc.w $315, $F00, $F0F0  ; DATA XREF: ROM:000349C2   o
word_3499E:     dc.w $337, $A00, $F4F4  ; DATA XREF: ROM:off_349C6   o
word_349A4:     dc.w $32E, $A00, $F4F4  ; DATA XREF: ROM:000349E2   o
word_349AA:     dc.w $300, $500, $F8F8  ; DATA XREF: ROM:000349CE   o
word_349B0:     dc.w $304, 0, $FCFC     ; DATA XREF: ROM:000349EA   o
off_349B6:      dc.l word_34992+1       ; DATA XREF: Boss_AntroidInitPhase+E   o
                dc.l word_3498C+1
                dc.l word_EB732+$400000
                dc.l word_34998+1
off_349C6:      dc.l word_3499E+1       ; DATA XREF: Boss_AntroidInitPhase+28   o
                dc.l off_3494C
                dc.l word_349AA+1
                dc.l off_3494C
                dc.l off_3496C+$8000000
                dc.l 0
                dc.l off_3494C
                dc.l word_349A4+1
                dc.l off_3494C
                dc.l word_349B0+1
                dc.l off_3496C-$18000000
off_349F2:      dc.b $00, $12, $14, $13  ; NOT a pointer! Just sprite data bytes
word_349F6:     dc.w $80C, $D0C, $1A06  ; DATA XREF: Boss_AntroidInitPhase+2E   o
                dc.w $101E, $1222, $600
word_34A02:     dc.w $C009, $C008, $4067
                                        ; DATA XREF: Boss_AntroidInitPhase+1A   o
                dc.w $C009, $C064, $4185
                dc.w $C1E4, $4245, $4244
                dc.w $120, $4366, $C365
                dc.w $4425, $C426, $44E5
word_34A20:     dc.w $C069, $45AA, $C609
                                        ; DATA XREF: Boss_AntroidInitPhase+34   o
                dc.w $466A, $4669, $120
                dc.w $478A, $C789, $4849
                dc.w $C84A, $4909
word_34A36:     dc.w $8080, $C080, $E090
                                        ; DATA XREF: Boss_AntroidResetAnimation   o
                dc.w $80E0, $9080, $8080
                dc.w $8080, $8000
off_34A46:      dc.l word_EB7F8         ; DATA XREF: ROM:00034A90   o
                                        ; ROM:00034A98   o ...
                dc.l word_EB7F2
                dc.l word_EB7EC
                dc.l word_EB7E6
                dc.l word_EB7E0
                dc.l word_EB7DA
                dc.l word_EB7D4
                dc.l word_EB7CE
off_34A66:      dc.l word_EB7FE         ; DATA XREF: ROM:00034AA0   o
                                        ; ROM:00034AB4   o
                dc.l word_EB80A
                dc.l word_EB816
                dc.l word_EB822
                dc.l word_EB82E
                dc.l word_EB83A
                dc.l word_EB846
                dc.l word_EB852
word_34A86:     dc.w $E35E, $F00, $F0F0 ; DATA XREF: ROM:00034A94   o
                                        ; ROM:00034AA8   o
dword_34A8C:    dc.l 0                  ; DATA XREF: Boss_TerobusterSetup+16   o
                dc.l off_34A46
                dc.l word_34A86+1
                dc.l off_34A46
                dc.l 0
                dc.l off_34A66-$30000000
                dc.l off_34A46
                dc.l word_34A86+1
                dc.l off_34A46
                dc.l 0
                dc.l off_34A66-$30000000
word_34AB8:     dc.w $90, $A898, $A484  ; DATA XREF: Boss_TerobusterSetup+1C   o
                dc.w $1028, $1824, $400
word_34AC4:     dc.w 5, 3, 1            ; DATA XREF: Boss_TerobusterSetup+22   o
                dc.w $C3, $C0, $182
                dc.w 7, 5, $2A7
                dc.w $2A0, $366
word_34ADA:     dc.w $A080, $80A0, $8080
                                        ; DATA XREF: Boss_TerobusterCalculateDeltas   o
off_34AE0:      dc.l word_EB984         ; DATA XREF: ROM:00034BE4   o
                                        ; ROM:00034BEC   o ...
                dc.l word_EB97E
                dc.l word_EB978
                dc.l word_EB972
                dc.l word_EB96C
                dc.l word_EB966
                dc.l word_EB960
                dc.l word_EB95A
off_34B00:      dc.l word_EB8EE         ; DATA XREF: ROM:00034C08   o
                dc.l word_EB8E8
                dc.l word_EB8DC
                dc.l word_EB8D0
                dc.l word_EB8C4
                dc.l word_EB8BE
                dc.l word_EB8B2
                dc.l word_EB8AC
off_34B20:      dc.l word_EB94E         ; DATA XREF: ROM:00034BF0   o
                dc.l word_EB942
                dc.l word_EB936
                dc.l word_EB92A
                dc.l word_EB91E
                dc.l word_EB912
                dc.l word_EB906
                dc.l word_EB8FA
off_34B40:      dc.l word_EB95A         ; DATA XREF: ROM:00034BB8   o
                                        ; ROM:00034BC0   o ...
                dc.l word_EB960
                dc.l word_EB966
                dc.l word_EB96C
                dc.l word_EB972
                dc.l word_EB978
                dc.l word_EB97E
                dc.l word_EB984
off_34B60:      dc.l word_EB8AC         ; DATA XREF: ROM:00034BDC   o
                dc.l word_EB8B2
                dc.l word_EB8BE
                dc.l word_EB8C4
                dc.l word_EB8D0
                dc.l word_EB8DC
                dc.l word_EB8E8
                dc.l word_EB8EE
off_34B80:      dc.l word_EB8FA         ; DATA XREF: ROM:00034BC4   o
                                        ; sub_39EE4   o
                dc.l word_EB906
                dc.l word_EB912
                dc.l word_EB91E
                dc.l word_EB92A
                dc.l word_EB936
                dc.l word_EB942
                dc.l word_EB94E
word_34BA0:     dc.w $6457, $A00, $F4F4 ; DATA XREF: ROM:00034BD0   o
                                        ; ROM:00034BFC   o
word_34BA6:     dc.w $6460, $500, $F8F8 ; DATA XREF: ROM:00034BBC   o
                                        ; ROM:00034BD8   o ...
dword_34BAC:    dc.l 0                  ; DATA XREF: Boss_ShellshogunSetupPhase+3C   o
                dc.l word_EB876+$400000
                dc.l word_EB8A0+$400000
                dc.l off_34B40+$48000000
                dc.l word_34BA6+1
                dc.l off_34B40+$48000000
                dc.l off_34B80+$48000000
                dc.l 0
                dc.l off_34B40+$48000000
                dc.l word_34BA0+1
                dc.l off_34B40+$48000000
                dc.l word_34BA6+1
                dc.l off_34B60+$48000000
                dc.l word_EB8A0+$400000
                dc.l off_34AE0-$30000000
                dc.l word_34BA6+1
                dc.l off_34AE0-$30000000
                dc.l off_34B20-$30000000
                dc.l 0
                dc.l off_34AE0-$30000000
                dc.l word_34BA0+1
                dc.l off_34AE0-$30000000
                dc.l word_34BA6+1
                dc.l off_34B00-$30000000
word_34C0C:     dc.w $22, $260C, $1A0C  ; DATA XREF: Boss_ShellshogunSetupPhase+42   o
                dc.w $1C18, $101E, $101C
                dc.w $826, $C1A, $C1C
                dc.w $1810, $1E10, $1C08
word_34C24:     dc.w 4, 4, 4            ; DATA XREF: Boss_ShellshogunSetupPhase+48   o
                dc.w $C7, $C6, $185
                dc.w $183, 4, $2AB
                dc.w $2AA, $36A, $36B
                dc.w $42B, 7, $4EA
                dc.w $4E9, $5A8, $5A3
                dc.w 4, $6CD, $6CC
                dc.w $78C, $78D, $84D
word_34C54:     dc.w $40, $6070, $40E0  ; DATA XREF: Boss_ShellshogunCollisionCheck   o
                dc.w $8000, $4000, $7080
                dc.w $E080, $A000
off_34C64:      dc.l word_EBAB0         ; DATA XREF: ROM:00034D16   o
                                        ; ROM:00034D1E   o ...
                dc.l word_EBAB6
                dc.l word_EBABC
                dc.l word_EBAC2
                dc.l word_EBAC8
                dc.l word_EBACE
                dc.l word_EBAD4
                dc.l word_EBADA
off_34C84:      dc.l word_EBAEC         ; DATA XREF: ROM:00034D3E   o
                dc.l word_EBAF2
                dc.l word_EBAF8
                dc.l word_EBAFE
                dc.l word_EBB04
                dc.l word_EBB0A
                dc.l word_EBB10
                dc.l word_EBB16
off_34CA4:      dc.l word_EBADA         ; DATA XREF: ROM:00034D02   o
                                        ; ROM:00034D0A   o ...
                dc.l word_EBAD4
                dc.l word_EBACE
                dc.l word_EBAC8
                dc.l word_EBAC2
                dc.l word_EBABC
                dc.l word_EBAB6
                dc.l word_EBAB0
off_34CC4:      dc.l word_EBB16         ; DATA XREF: ROM:00034D56   o
                dc.l word_EBB10
                dc.l word_EBB0A
                dc.l word_EBB04
                dc.l word_EBAFE
                dc.l word_EBAF8
                dc.l word_EBAF2
                dc.l word_EBAEC
word_34CE4:     dc.w $62D4, $500, $F8F8 ; DATA XREF: ROM:00034D3A   o
                                        ; ROM:00034D52   o
word_34CEA:     dc.w $62D8, $A00, $F4F4 ; DATA XREF: ROM:00034D06   o
                                        ; ROM:00034D1A   o
word_34CF0:     dc.w $62E1, $A00, $F4F4 ; DATA XREF: ROM:00034D32   o
                                        ; ROM:00034D4A   o
dword_34CF6:    dc.l 0                  ; DATA XREF: Boss_XiTigerSetup+10   o
                dc.l word_EBA2C+$400000
                dc.l word_EBA1A+$400000
                dc.l off_34CA4
                dc.l word_34CEA+1
                dc.l off_34CA4
                dc.l 0
                dc.l word_EBA1A-$7C00000
                dc.l off_34C64+$18000000
                dc.l word_34CEA+1-$8000000
                dc.l off_34C64+$18000000
                dc.l 0
                dc.l word_EBAE0+$400000
                dc.l 0
                dc.l off_34C64+$18000000
                dc.l word_34CF0+1
                dc.l off_34CA4
                dc.l word_34CE4+1
                dc.l off_34C84+$18000000
                dc.l 0
                dc.l off_34C64+$18000000
                dc.l word_34CF0+1+$8000000
                dc.l off_34C64+$8000000
                dc.l word_34CE4+1+$8000000
                dc.l off_34CC4
word_34D5A:     dc.w $E, $2E14, $2410   ; DATA XREF: Boss_XiTigerSetup+16   o
                dc.w $222C, $1424, $1022
                dc.w $3214, $A1C, $E1C
                dc.w $714, $A1C, $E1C
                dc.w $700
word_34D74:     dc.w $8000, $8005, $8005
                                        ; DATA XREF: Boss_XiTigerSetup+1C   o
                dc.w $80C5, $80C5, $8184
                dc.w $8180, $8005, $82A5
                dc.w $82A5, $8364, $8360
                dc.w $8009, $8488, $84E7
                dc.w $84E6, $85A7, $85A7
                dc.w $8667, $8488, $8727
                dc.w $8726, $87E7, $87E7
                dc.w $88A7
word_34DA6:     dc.w $2060, $70C0, $80A0
                                        ; DATA XREF: Boss_XiTigerCalculateDeltas   o
                dc.w $9080, $4000, $8000
                dc.w $E040, $4080
off_34DB6:      dc.l word_EBB7C         ; DATA XREF: ROM:00034E60   o
                                        ; ROM:00034E78   o
                dc.l word_EBB70
                dc.l word_EBB58
                dc.l word_EBB34
                dc.l word_EBB40
                dc.l word_EBB28
                dc.l word_EBB4C
                dc.l word_EBB64
off_34DD6:      dc.l word_EBB64         ; DATA XREF: ROM:00034E5C   o
                                        ; ROM:00034E74   o
                dc.l word_EBB4C
                dc.l word_EBB28
                dc.l word_EBB40
                dc.l word_EBB34
                dc.l word_EBB58
                dc.l word_EBB70
                dc.l word_EBB7C
off_34DF6:      dc.l word_EBB88         ; DATA XREF: ROM:00034E94   o
                                        ; ROM:00034E9C   o ...
                dc.l word_EBB8E
                dc.l word_EBB94
                dc.l word_EBB9A
                dc.l word_EBBA0
                dc.l word_EBBA6
                dc.l word_EBBAC
                dc.l word_EBBB2
off_34E16:      dc.l word_EBBB2         ; DATA XREF: ROM:00034E7C   o
                                        ; ROM:00034E84   o ...
                dc.l word_EBBAC
                dc.l word_EBBA6
                dc.l word_EBBA0
                dc.l word_EBB9A
                dc.l word_EBB94
                dc.l word_EBB8E
                dc.l word_EBB88
word_34E36:     dc.w $6390, $F00, $F0F0 ; DATA XREF: ROM:00034E58   o
                                        ; ROM:00034E70   o
word_34E3C:     dc.w $63A0, $A00, $F4F4 ; DATA XREF: ROM:00034E4C   o
                                        ; ROM:00034E50   o ...
word_34E42:     dc.w $43C4, 0, $FCFC    ; DATA XREF: ROM:00034E80   o
                                        ; ROM:00034E8C   o ...
dword_34E48:    dc.l 0                  ; DATA XREF: Boss_MadamBarbarSetup+14   o
                dc.l word_34E3C+1
                dc.l word_34E3C+1
                dc.l word_34E3C+1
                dc.l word_34E36+1
                dc.l off_34DD6
                dc.l off_34DB6+$18000000
                dc.l word_34E3C+1
                dc.l word_34E3C+1
                dc.l word_34E3C+1
                dc.l word_34E36+1
                dc.l off_34DD6
                dc.l off_34DB6+$18000000
                dc.l off_34E16
                dc.l word_34E42+1
                dc.l off_34E16
                dc.l off_34E16
                dc.l word_34E42+1
                dc.l off_34E16
                dc.l off_34DF6+$18000000
                dc.l word_34E42+1
                dc.l off_34DF6+$18000000
                dc.l off_34DF6+$18000000
                dc.l word_34E42+1
                dc.l off_34DF6+$18000000
                dc.l 0
                dc.l 0
                dc.l 0
                dc.l 0
word_34EBC:     dc.w $10, $C10, $121C   ; DATA XREF: Boss_MadamBarbarSetup+1A   o
                dc.w $1C10, $C10, $121C
                dc.w $1C06, $608, $606
                dc.w $806, $608, $606
                dc.w $80D, $D0D, $D00
word_34EDA:     dc.w $8000, $8007, $8066
                                        ; DATA XREF: Boss_MadamBarbarSetup+20   o
                dc.w $80C5, $8124, $184
                dc.w $184, $8007, $82A6
                dc.w $8305, $8364, $3C4
                dc.w $3C4, 7, $4E6
                dc.w $546, 7, $606
                dc.w $666, 7, $726
                dc.w $786, 7, $846
                dc.w $8A6, $540, $660
                dc.w $780, $8A0
word_34F14:     dc.w $8080, $80, $80    ; DATA XREF: Boss_MadamBarbarCalcDeltas   o
                dc.w $80, $8080, $8080
off_34F20:      dc.l word_EBBDC         ; DATA XREF: ROM:00034F4A   o
                                        ; ROM:00034F52   o ...
                dc.l word_EBBE2
                dc.l word_EBBE8
                dc.l word_EBBEE
                dc.l word_EBBF4
                dc.l word_EBBFA
                dc.l word_EBC00
                dc.l word_EBC06
word_34F40:     dc.w $6380, $600, $F8F4 ; DATA XREF: ROM:00034F4E   o
                                        ; ROM:00034F5E   o
dword_34F46:    dc.l 0                  ; DATA XREF: Boss_FlyingNeoSetup+C   o
                dc.l off_34F20+$18000000
                dc.l word_34F40+1
                dc.l off_34F20+$18000000
                dc.l word_EBC18+$8400000
                dc.l off_34F20+$18000000
                dc.l word_34F40+1
                dc.l off_34F20+$18000000
                dc.l word_EBC18+$8400000
word_34F6A:     dc.w 8, $1810, $1F08    ; DATA XREF: Boss_FlyingNeoSetup+12   o
                dc.w $1810, $1F00
word_34F74:     dc.w 0, $8065, $C064    ; DATA XREF: Boss_FlyingNeoSetup+18   o
                dc.w $8124, $8123, $806B
                dc.w $C06A, $82AA, $82A9
word_34F86:     dc.w $A0A0, $A0A0       ; DATA XREF: Boss_FlyingNeoCalculateDeltas   o
off_34F8A:      dc.l word_EBC24         ; DATA XREF: ROM:0003507E   o
                                        ; ROM:00035086   o
                dc.l word_EBC2A
                dc.l word_EBC30
                dc.l word_EBC36
                dc.l word_EBC3C
                dc.l word_EBC42
                dc.l word_EBC48
                dc.l word_EBC4E
off_34FAA:      dc.l word_EBC4E         ; DATA XREF: ROM:0003505A   o
                                        ; ROM:00035062   o
                dc.l word_EBC48
                dc.l word_EBC42
                dc.l word_EBC3C
                dc.l word_EBC36
                dc.l word_EBC30
                dc.l word_EBC2A
                dc.l word_EBC24
off_34FCA:      dc.l word_EBC54         ; DATA XREF: ROM:0003508E   o
                                        ; ROM:00035096   o
                dc.l word_EBC5A
                dc.l word_EBC60
                dc.l word_EBC66
                dc.l word_EBC6C
                dc.l word_EBC72
                dc.l word_EBC78
                dc.l word_EBC7E
off_34FEA:      dc.l word_EBC7E         ; DATA XREF: ROM:0003506A   o
                                        ; ROM:00035072   o
                dc.l word_EBC78
                dc.l word_EBC72
                dc.l word_EBC6C
                dc.l word_EBC66
                dc.l word_EBC60
                dc.l word_EBC5A
                dc.l word_EBC54
off_3500A:      dc.l word_EBC84         ; DATA XREF: ROM:0003509E   o
                dc.l word_EBC8A
                dc.l word_EBC9C
                dc.l word_EBCA8
                dc.l word_EBCAE
                dc.l word_EBCB4
                dc.l word_EBCC6
                dc.l word_EBCD2
off_3502A:      dc.l word_EBCD2         ; DATA XREF: ROM:0003507A   o
                dc.l word_EBCC6
                dc.l word_EBCB4
                dc.l word_EBCAE
                dc.l word_EBCA8
                dc.l word_EBC9C
                dc.l word_EBC8A
                dc.l word_EBC84
word_3504A:     dc.w $636E, $500, $F8F8 ; DATA XREF: ROM:0003506E   o
                                        ; ROM:00035092   o
word_35050:     dc.w $6366, $500, $F8F8 ; DATA XREF: ROM:00035066   o
                                        ; ROM:0003508A   o
dword_35056:    dc.l 0                  ; DATA XREF: Boss_JokerSetup+32   o
                dc.l off_34FAA
                dc.l 0
                dc.l off_34FAA
                dc.l word_35050+1
                dc.l off_34FEA
                dc.l word_3504A+1
                dc.l off_34FEA
                dc.l 0
                dc.l off_3502A
                dc.l off_34F8A+$18000000
                dc.l 0
                dc.l off_34F8A+$18000000
                dc.l word_35050+1+$8000000
                dc.l off_34FCA+$18000000
                dc.l word_3504A+1+$8000000
                dc.l off_34FCA+$18000000
                dc.l 0
                dc.l off_3500A+$18000000
word_350A2:     dc.w $84, $8888, $928C  ; DATA XREF: Boss_JokerSetup+38   o
                dc.w $9990, $9B81, $8488
                dc.w $8892, $8C99, $909B
                dc.w $8100
word_350B6:     dc.w 0, $728, $720      ; DATA XREF: Boss_JokerSetup+3E   o
                dc.w $C7, $C6, $788
                dc.w $787, $248, $240
                dc.w $309, $7E8, $7E0
                dc.w $427, $426, $848
                dc.w $847, $5A8, $5A0
                dc.w $669
word_350DC:     dc.w $80, $8080, $E080  ; DATA XREF: Boss_JokerCalcDeltas   o
                dc.w $A0A0, $8060
off_350E6:      dc.l word_EC38E         ; DATA XREF: ROM:00035180   o
                                        ; ROM:00035198   o ...
                dc.l word_EC394
                dc.l word_EC39A
                dc.l word_EC3A6
                dc.l word_EC3AC
                dc.l word_EC3B2
                dc.l word_EC3B8
                dc.l word_EC3C4
off_35106:      dc.l word_EC3C4         ; DATA XREF: ROM:0003518C   o
                                        ; ROM:000351A4   o ...
                dc.l word_EC3B8
                dc.l word_EC3B2
                dc.l word_EC3AC
                dc.l word_EC3A6
                dc.l word_EC39A
                dc.l word_EC394
                dc.l word_EC38E
off_35126:      dc.l word_EC3D0         ; DATA XREF: ROM:00035178   o
                                        ; ROM:0003517C   o ...
                dc.l word_EC3D6
                dc.l word_EC3DC
                dc.l word_EC3E2
                dc.l word_EC3E8
                dc.l word_EC3EE
                dc.l word_EC3F4
                dc.l word_EC3FA
off_35146:      dc.l word_EC3FA         ; DATA XREF: ROM:00035184   o
                                        ; ROM:00035188   o ...
                dc.l word_EC3F4
                dc.l word_EC3EE
                dc.l word_EC3E8
                dc.l word_EC3E2
                dc.l word_EC3DC
                dc.l word_EC3D6
                dc.l word_EC3D0
word_35166:     dc.w $63DE, $A00, $F4F4 ; DATA XREF: ROM:off_3516C   o
off_3516C:      dc.l word_35166+1       ; DATA XREF: Boss_BackStringerSpawn+E   o
                dc.l 0
                dc.l 0
                dc.l off_35126+$18000000
                dc.l off_35126+$18000000
                dc.l off_350E6+$18000000
                dc.l off_35146
                dc.l off_35146
                dc.l off_35106
                dc.l off_35126+$18000000
                dc.l off_35126+$18000000
                dc.l off_350E6+$18000000
                dc.l off_35146
                dc.l off_35146
                dc.l off_35106
                dc.l off_35126+$18000000
                dc.l off_35126+$18000000
                dc.l off_350E6+$18000000
                dc.l off_35146
                dc.l off_35146
                dc.l off_35106
word_351C0:     dc.w $98, $9F96, $8E8C  ; DATA XREF: Boss_BackStringerSpawn+14   o
                dc.w $968E, $8C92, $8A8C
                dc.w $928A, $8C96, $8E8C
                dc.w $968E, $8C00
word_351D6:     dc.w 5, 4, 4            ; DATA XREF: Boss_BackStringerSpawn+1A   o
                dc.w 6, $126, $186
                dc.w 6, $246, $2A6
                dc.w 6, $366, $3C6
                dc.w 6, $486, $4E6
                dc.w 6, $5A6, $606
                dc.w 6, $6C6, $726
word_35200:     dc.w $40C0, $80, $8080  ; DATA XREF: Anim_BackStringerCalcInterpolation   o
                dc.w $8080, $80, $8080
                dc.w $8080, $80, $8080
                dc.w $8080
word_35214:     dc.w $63F9, $A00, $F4F4 ; DATA XREF: ROM:00035238   o
                                        ; ROM:0003523C   o ...
word_3521A:     dc.w $6402, $500, $F8F8 ; DATA XREF: ROM:00035240   o
                                        ; ROM:00035250   o
off_35220:      dc.l word_EC142+$400000 ; DATA XREF: Boss_SharpssteelInit+E   o
                dc.l word_EC12A+$400000
                dc.l word_EC112+$400000
                dc.l word_EC15A+$400000
                dc.l word_EC166+$400000
                dc.l word_EC172+$400000
                dc.l word_35214+1
                dc.l word_35214+1
                dc.l word_3521A+1
                dc.l word_EC196+$400000
                dc.l word_35214+1
                dc.l word_35214+1
                dc.l word_3521A+1
                dc.l word_EC196+$400000
                dc.l 0
                dc.l 0
                dc.l 0
                dc.l 0
word_35268:     dc.w $809C, $A098, $9894
                                        ; DATA XREF: Boss_SharpssteelInit+14   o
                dc.w $9C90, $8E92, $9C90
                dc.w $8E92, $A0A0, $C0C0
word_3527A:     dc.w $8007, $8006, $8065
                                        ; DATA XREF: Boss_SharpssteelInit+1A   o
                dc.w $8007, $8127, $8187
                dc.w $8066, $246, $2A6
                dc.w $8304, $8066, $3C6
                dc.w $426, $8484, $360
                dc.w $4E0, $360, $4E0
word_3529E:     dc.w $8080, $8080, $8080, $8080
                                        ; DATA XREF: Boss_SharpssteelCoreDefeat   o
off_352A6:      dc.l word_ED1CC         ; DATA XREF: ROM:00035320   o
                                        ; ROM:00035334   o
                dc.l word_ED1D2
                dc.l word_ED1DE
                dc.l word_ED1E4
                dc.l word_ED1F0
                dc.l word_ED1F6
                dc.l word_ED202
                dc.l word_ED208
off_352C6:      dc.l word_ED214         ; DATA XREF: ROM:00035348   o
                                        ; ROM:0003535C   o
                dc.l word_ED226
                dc.l word_ED238
                dc.l word_ED24A
                dc.l word_ED25C
                dc.l word_ED26E
                dc.l word_ED280
                dc.l word_ED292
off_352E6:      dc.l word_ED2A4         ; DATA XREF: ROM:00035328   o
                                        ; ROM:0003533C   o ...
                dc.l word_ED2B0
                dc.l word_ED2BC
                dc.l word_ED2C8
                dc.l word_ED2D4
                dc.l word_ED2E0
                dc.l word_ED2EC
                dc.l word_ED2F8
word_35306:     dc.w $63DE, $500, $F8F8 ; DATA XREF: ROM:00035324   o
                                        ; ROM:0003532C   o ...
dword_3530C:    dc.l 0                  ; DATA XREF: Boss_WolfGaropaMovement3+1E   o
                dc.l 0
                dc.l 0
                dc.l 0
                dc.l 0
                dc.l off_352A6+$18000000
                dc.l word_35306+1
                dc.l off_352E6+$18000000
                dc.l word_35306+1
                dc.l word_ED304+$8400000
                dc.l off_352A6+$18000000
                dc.l word_35306+1
                dc.l off_352E6+$18000000
                dc.l word_35306+1
                dc.l word_ED304+$8400000
                dc.l off_352C6+$18000000
                dc.l word_35306+1
                dc.l off_352E6+$18000000
                dc.l word_35306+1
                dc.l word_ED304+$8400000
                dc.l off_352C6+$18000000
                dc.l word_35306+1
                dc.l off_352E6+$18000000
                dc.l word_35306+1
                dc.l word_ED304+$8400000
word_35370:     dc.w $2C, $2612, $1891  ; DATA XREF: Boss_WolfGaropaMovement3+24   o
                dc.w $A290, $9F88, $1122
                dc.w $F1F, $893, $A694
                dc.w $A688, $1326, $1426
                dc.w $800
word_3538A:     dc.w 0, 0, 0            ; DATA XREF: Boss_WolfGaropaMovement3+2A   o
                dc.w 0, 0, $4063
                dc.w $64, $4243, $244
                dc.w $4303, $40C8, $C9
                dc.w $4428, $429, $44E8
                dc.w $4123, $124, $4603
                dc.w $604, $46C3, $4188
                dc.w $189, $47E8, $7E9
                dc.w $48A8
off_353BC:      dc.l word_EC6FC         ; DATA XREF: ROM:00035438   o
                                        ; ROM:0003544C   o
                dc.l word_EC702
                dc.l word_EC708
                dc.l word_EC70E
                dc.l word_EC714
                dc.l word_EC71A
                dc.l word_EC720
                dc.l word_EC726
off_353DC:      dc.l word_EC72C         ; DATA XREF: ROM:0003542C   o
                                        ; ROM:00035434   o ...
                dc.l word_EC732
                dc.l word_EC738
                dc.l word_EC744
                dc.l word_EC74A
                dc.l word_EC750
                dc.l word_EC756
                dc.l word_EC762
off_353FC:      dc.l word_EC6C0         ; DATA XREF: ROM:00035454   o
                                        ; ROM:00035464   o
                dc.l word_EC6D2
                dc.l word_EC6D2
                dc.l word_EC6E4
                dc.l word_EC6E4
                dc.l word_EC6E4
                dc.l word_EC6E4
                dc.l word_EC6C0
off_3541C:      dc.l word_EC7D4+$400000 ; DATA XREF: Boss_ValkirieInit+18   o
                dc.l 0
                dc.l word_EC82E+$400000
                dc.l 0
                dc.l off_353DC+$18000000
                dc.l word_EC7DA+$400000
                dc.l off_353DC+$18000000
                dc.l off_353BC+$18000000
                dc.l 0
                dc.l off_353DC+$18000000
                dc.l word_EC7DA+$400000
                dc.l off_353DC+$18000000
                dc.l off_353BC+$18000000
                dc.l 0
                dc.l off_353FC
                dc.l word_EC7E0+$400000
                dc.l word_EC7B0+$400000
                dc.l 0
                dc.l off_353FC
                dc.l word_EC7E0+$400000
                dc.l word_EC7B0+$400000
word_35470:     dc.w 0, $A, $8A95       ; DATA XREF: Boss_ValkirieInit+1E   o
                dc.w $909D, $A0A, $1510
                dc.w $1D0A, $E1C, $100A
                dc.w $E1C, $1000
word_35486:     dc.w $8009, 0, $8007    ; DATA XREF: Boss_ValkirieInit+24   o
                dc.w $60, $8124, $8123
                dc.w $81E4, $81E3, $60
                dc.w $830F, $830E, $83CF
                dc.w $83CF, $C0, $84EA
                dc.w $84E9, $85A8, $C0
                dc.w $866C, $866B, $872A
off_354B0:      dc.l word_EC6FC         ; DATA XREF: ROM:0003552C   o
                                        ; ROM:00035540   o ...
                dc.l word_EC702
                dc.l word_EC708
                dc.l word_EC70E
                dc.l word_EC714
                dc.l word_EC71A
                dc.l word_EC720
                dc.l word_EC726
off_354D0:      dc.l word_EC72C         ; DATA XREF: ROM:00035520   o
                                        ; ROM:00035528   o ...
                dc.l word_EC732
                dc.l word_EC738
                dc.l word_EC744
                dc.l word_EC74A
                dc.l word_EC750
                dc.l word_EC756
                dc.l word_EC762
off_354F0:      dc.l word_EC6C0         ; DATA XREF: ROM:00035548   o
                                        ; ROM:00035558   o
                dc.l word_EC6D2
                dc.l word_EC6D2
                dc.l word_EC6E4
                dc.l word_EC6E4
                dc.l word_EC6E4
                dc.l word_EC6E4
                dc.l word_EC6C0
                dc.l word_EC7D4+$400000
                dc.l 0
                dc.l word_EC82E+$400000
                dc.l 0
                dc.l off_354D0+$18000000
                dc.l word_EC7DA+$400000
                dc.l off_354D0+$18000000
                dc.l off_354B0+$18000000
                dc.l 0
                dc.l off_354D0+$18000000
                dc.l word_EC7DA+$400000
                dc.l off_354D0+$18000000
                dc.l off_354B0+$18000000
                dc.l 0
                dc.l off_354F0
                dc.l word_EC7E0+$400000
                dc.l word_EC7B0+$400000
                dc.l 0
                dc.l off_354F0
                dc.l word_EC7E0+$400000
                dc.l word_EC7B0+$400000
                dc.w 0, $A, $8A95
                dc.w $909D, $A0A, $1510
                dc.w $1D0A, $E1C, $100A
                dc.w $E1C, $1000, $8009
                dc.w 0, $8007, $60
                dc.w $8124, $8123, $81E4
                dc.w $81E3, $60, $830F
                dc.w $830E, $83CF, $83CF
                dc.w $C0, $84EA, $84E9
                dc.w $85A8, $C0, $866C
                dc.w $866B, $872A
dword_355A4:    dc.l 0                  ; DATA XREF: Boss_ZLeoIntroInit+22   o
                                        ; Boss_ValkirieForceInit+10   o ...
                dc.l 0
                dc.l 0
                dc.l word_ED3C4+$400000
                dc.l word_ED3DC+$400000
                dc.l word_ED3C4+$400000
                dc.l word_ED424+$400000
                dc.l word_ED3C4+$400000
                dc.l word_ED3DC+$400000
                dc.l word_ED3EE+$400000
                dc.l word_ED3DC+$400000
                dc.l word_ED3EE+$400000
                dc.l word_ED3E8+$400000
                dc.l word_ED3EE+$400000
                dc.l word_ED3E8+$400000
                dc.l word_ED3AC+$400000
word_355E4:     dc.w $38, $3818, $1818  ; DATA XREF: Boss_ZLeoIntroInit+28   o
                dc.w $1E18, $280C, $1C10
                dc.w $200C, $1C1A
word_355F4:     dc.w $8000, 0, $8000    ; DATA XREF: Boss_ZLeoIntroInit+2E   o
                dc.w $806B, $812A, $8189
                dc.w $81E9, $80CF, $80CE
                dc.w $830D, $830C, $83CB
                dc.w $83CA, $8489, $8488
                dc.w $8547


; Checks if boss position is within valid screen bounds
