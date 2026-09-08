; Dispatches type $3B8 through the subtype index stored at entity offset $48
Entity_DispatchStoredSubtype:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_314C2
                move.w  $48(a5),d0
                lea     Entity_StoredSubtypeHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Entity_DispatchStoredSubtype
; ---------------------------------------------------------------------------
Entity_StoredSubtypeHandlers:   dc.w    Boss_DestroyerProtoMain-*  ; DATA XREF: Entity_DispatchStoredSubtype+4   o  ; was: off_314CE
                dc.w    Boss_DestroyerProtoState4-*
                dc.w    Boss_DestroyerProtoState5-*
                dc.w    Projectile_DestroyerProtoMain-*
                dc.w    Enemy_Stage14TurretInit-*

; Main boss handler
Boss_DestroyerProtoMain:                                ; DATA XREF: ROM:Entity_StoredSubtypeHandlers   o  ; was: sub_314D8
                jsr     (Gfx_InitPaletteFade).l
                bsr.w   Boss_DestroyerProtoGfxUpdate
                cmpi.w  #$2E,4(a5)                      ; '.'
                bcc.s   loc_31502
                tst.w   (word_FF8200).w
                bne.s   loc_31502
                bset    #0,(byte_FFA272).w
                move.w  #1,(dword_FF9414+2).w
                move.w  #$2E,4(a5)                      ; '.'
loc_31502:                                              ; CODE XREF: Boss_DestroyerProtoMain+10   j
                                        ; Boss_DestroyerProtoMain+16   j
                move.w  4(a5),d0
                lea     off_3150E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerProtoMain
; ---------------------------------------------------------------------------
off_3150E:      dc.w    Boss_DestroyerProtoIntroInit-*  ; DATA XREF: Boss_DestroyerProtoMain+2E   o
                dc.w    Boss_DestroyerProtoIntroMove-*
                dc.w    Boss_DestroyerProtoState3-*
                dc.w    Boss_DestroyerProtoAttack1-*
                dc.w    Boss_DestroyerProtoAttack2-*
                dc.w    Boss_DestroyerProtoAttack3-*
                dc.w    Boss_DestroyerProtoAttack4Wait-*
                dc.w    Boss_DestroyerProtoAttack4Rise-*
                dc.w    Boss_DestroyerProtoAttack4Descend-*
                dc.w    Boss_DestroyerProtoAttack4Delay-*
                dc.w    Boss_DestroyerProtoAttack4Retreat-*
                dc.w    Boss_DestroyerProtoAttack4-*
                dc.w    Boss_DestroyerProtoShootPattern1-*
                dc.w    Boss_DestroyerProtoShootPattern2-*
                dc.w    Boss_DestroyerProtoAttack5Rise-*
                dc.w    Boss_DestroyerProtoAttack5Retreat-*
                dc.w    Boss_DestroyerProtoAttack6Wait-*
                dc.w    Boss_DestroyerProtoAttack6Prepare-*
                dc.w    Boss_DestroyerProtoAttack6Delay-*
                dc.w    Boss_DestroyerProtoAttack6Execute-*
                dc.w    Boss_DestroyerProtoAttack6FadeOut-*
                dc.w    Boss_DestroyerProtoAttack6Wait2-*
                dc.w    Boss_DestroyerProtoAttack6Retreat-*
                dc.w    Boss_DestroyerProtoSpawnProjectile1-*
                dc.w    Boss_DestroyerProtoSpawnProjectile3-*

; Boss graphics update
Boss_DestroyerProtoGfxUpdate:                           ; CODE XREF: Boss_DestroyerProtoMain+6   p  ; was: sub_31540
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   Entity_UpdateReturn
                move.w  (dword_FF9400).w,d0
                addq.w  #2,d0
                cmpi.w  #$14,d0
                bcs.s   loc_3155A
                clr.w   d0
loc_3155A:                                              ; CODE XREF: Boss_DestroyerProtoGfxUpdate+16   j
                move.w  d0,(dword_FF9400).w
                move.w  word_3156C(pc,d0.w),(word_FFE366).w
                move.w  word_31580(pc,d0.w),(word_FFE368).w
                rts
; End of function Boss_DestroyerProtoGfxUpdate
; ---------------------------------------------------------------------------
word_3156C:     dc.w    $2C8, $A6, $84, $62, $40, $20, $40, $62, $84, $A6
                                        ; DATA XREF: Boss_DestroyerProtoGfxUpdate+1E   r
word_31580:     dc.w    $64, $44, $42, $22, $20, 0, $20, $22, $42, $44
                                        ; DATA XREF: Boss_DestroyerProtoGfxUpdate+24   r

; Intro animation init
Boss_DestroyerProtoIntroInit:                           ; DATA XREF: ROM:off_3150E   o  ; was: sub_31594
                clr.w   (dword_FF9414+2).w
                move.w  #$E0,$14(a5)
                move.w  #$200,$10(a5)
                bsr.w   Boss_DestroyerProtoBounds
                tst.w   (word_FFF720).w
                bmi.w   Entity_UpdateReturn
                move.b  #4,(byte_FFA95A).w
                move.b  #$50,$21(a5)                    ; 'P'
                move.b  #$98,$23(a5)
                move.w  #$18,$24(a5)
                move.w  #$4C00,2(a5)
                move.l  #$E020E020,$2C(a5)
                move.l  #$D030D030,$28(a5)
                move.w  #$8C,$26(a5)
                movea.l #word_316AE,a0
                jsr     (Gfx_LoadCompressedTiles).l
                addq.w  #2,4(a5)
                movea.w a5,a4
                move.w  #5,d6
loc_315FA:                                              ; CODE XREF: Boss_DestroyerProtoIntroInit+DC   j
                adda.w  #$60,a4                         ; '`'
                move.w  $10(a5),$10(a4)
                move.w  $14(a5),$14(a4)
                move.w  #$CC00,2(a4)
                move.w  #$3B8,(a4)
                move.w  #$6300,$E(a4)
                move.b  #$30,$20(a4)                    ; '0'
                move.b  #$C0,$21(a4)
                move.b  #$10,$23(a4)
                move.l  #$FC04FC04,$2C(a4)
                move.l  #$F010F010,$28(a4)
                move.w  #$3C,$26(a4)                    ; '<'
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
word_31676:     dc.w    $40, $40, $40, $140, $140, $140
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+B2   r
word_31682:     dc.w    $A0, $40, $E0, $A0, $40, $E0
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+BE   r
                                        ; Boss_DestroyerProtoTurretOpen+4   o
word_3168E:     dc.w    $C800, $C7A0, $C620, $C6E0, $C680, $C620
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+C4   r
word_3169A:     dc.w    4, 2, 2, 4, 2, 2                ; DATA XREF: Boss_DestroyerProtoIntroInit+CA   r
off_316A6:      dc.l    word_ECF70                      ; DATA XREF: Boss_DestroyerProtoIntroInit+D6   r
                dc.l    word_ECF04
word_316AE:     dc.w    $4000, $2000, $303, $5051, $5253, $5455, $5657, $5859, $5A5B, $5C5D, $5E5F
                                        ; DATA XREF: Boss_DestroyerProtoIntroInit+50   o

; Intro movement
Boss_DestroyerProtoIntroMove:                           ; DATA XREF: ROM:00031510   o  ; was: sub_316C4
                bsr.w   Boss_DestroyerProtoCollision
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w   Boss_DestroyerProtoVelocity
                subi.w  #2,$18(a5)
                bsr.w   Boss_DestroyerProtoBounds
                cmpi.w  #$160,$10(a5)
                bcc.w   Entity_UpdateReturn
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoIntroMove
; Boss collision handler
Boss_DestroyerProtoCollision:                           ; CODE XREF: Boss_DestroyerProtoIntroMove   p  ; was: sub_316F8
                                        ; sub_317FE   p
                addq.w  #8,$40(a5)
                andi.w  #$1FE,$40(a5)
                move.w  $40(a5),d0
                bsr.w   Math_LookupSineCosinePairDuplicate
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
                                        ; Boss_DestroyerProtoIntroMove+16   p
                move.w  #$2C0,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA900).w
                move.w  $14(a5),d0
                subi.w  #$C0,d0
                move.w  d0,(dword_FFA904).w
                rts
; End of function Boss_DestroyerProtoBounds
; Boss velocity handler
Boss_DestroyerProtoVelocity:                            ; CODE XREF: Boss_DestroyerProtoIntroMove+C   p  ; was: sub_31736
                                        ; Boss_DestroyerProtoState3+C   p
                lea     (word_FFC680).w,a4
                bsr.w   Boss_DestroyerProtoState1
                lea     (word_FFC6E0).w,a4
                bsr.w   Boss_DestroyerProtoState1
                lea     (word_FFC7A0).w,a4
                bsr.w   Boss_DestroyerProtoState1
                lea     (word_FFC800).w,a4
                bsr.w   Boss_DestroyerProtoState1
                lea     (word_FFC740).w,a4
                bsr.w   Boss_DestroyerProtoState2
                lea     (word_FFC860).w,a4
                bsr.w   Boss_DestroyerProtoState2
                rts
; End of function Boss_DestroyerProtoVelocity
; Boss state handler 1
Boss_DestroyerProtoState1:                              ; CODE XREF: Boss_DestroyerProtoVelocity+4   p  ; was: sub_31768
                                        ; Boss_DestroyerProtoVelocity+C   p
                add.w   d0,$40(a4)
                andi.w  #$1FE,$40(a4)
                rts
; End of function Boss_DestroyerProtoState1
; Boss state handler 2
Boss_DestroyerProtoState2:                              ; CODE XREF: Boss_DestroyerProtoVelocity+24   p  ; was: sub_31774
                                        ; Boss_DestroyerProtoVelocity+2C   p
                add.w   d1,$40(a4)
                andi.w  #$1FE,$40(a4)
                add.w   d1,$46(a4)
                andi.w  #$1FE,$46(a4)
                rts
; End of function Boss_DestroyerProtoState2
; Close turret hatches
Boss_DestroyerProtoTurretClose:                         ; CODE XREF: Boss_DestroyerProtoAttack3+4   p  ; was: sub_3178A
                                        ; Boss_DestroyerProtoAttack4Retreat+4   p
                lea     (word_FFC680).w,a4
                move.w  #5,d0
loc_31792:                                              ; CODE XREF: Boss_DestroyerProtoTurretClose+18   j
                tst.w   $42(a4)
                beq.s   loc_3179E
                subi.w  #8,$42(a4)
loc_3179E:                                              ; CODE XREF: Boss_DestroyerProtoTurretClose+C   j
                adda.w  #$60,a4                         ; '`'
                dbf     d0,loc_31792
                rts
; End of function Boss_DestroyerProtoTurretClose
; Open turret hatches
Boss_DestroyerProtoTurretOpen:                          ; CODE XREF: Boss_DestroyerProtoAttack2   p  ; was: sub_317A8
                                        ; sub_3198C   p
                lea     (word_FFC680).w,a4
                lea     word_31682(pc),a0
                move.w  #5,d0
loc_317B4:                                              ; CODE XREF: Boss_DestroyerProtoTurretOpen+24   j
                move.w  d0,d1
                lsl.w   #1,d1
                move.w  (a0,d1.w),d2
                cmp.w   $42(a4),d2
                beq.s   loc_317C8
                addi.w  #8,$42(a4)
loc_317C8:                                              ; CODE XREF: Boss_DestroyerProtoTurretOpen+18   j
                adda.w  #$60,a4                         ; '`'
                dbf     d0,loc_317B4
                rts
; End of function Boss_DestroyerProtoTurretOpen
; Synchronizes rotation angles across multiple Destroyer Proto boss parts using base angle and offset
Boss_DestroyerSyncPartAngles:                           ; CODE XREF: Boss_DestroyerProtoAttack4Retreat+20   p  ; was: sub_317D2
                                        ; Boss_DestroyerProtoAttack5Retreat+20   p
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
                bsr.w   Boss_DestroyerProtoCollision
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w   Boss_DestroyerProtoVelocity
                bsr.w   Boss_DestroyerProtoBounds
                tst.w   (word_FF80C2).w
                bne.w   Entity_UpdateReturn
                clr.b   (byte_FF80EC).w
                andi.b  #$EF,$23(a5)
                move.w  #$20,$4A(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoState3
; Attack pattern 1
Boss_DestroyerProtoAttack1:                             ; DATA XREF: ROM:00031514   o  ; was: sub_31830
                bsr.w   Boss_DestroyerProtoCollision
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w   Boss_DestroyerProtoVelocity
                bsr.w   Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
loc_3184C:                                              ; CODE XREF: Boss_DestroyerProtoAttack4Retreat+24   j
                                        ; Boss_DestroyerProtoAttack5Retreat+24   j
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
word_3188C:     dc.w    $C0, $C0, $120, $C0, $180, $C0, $C0, $F8, $180, $F8, $C0, $130, $120, $130, $180, $130
                                        ; DATA XREF: Boss_DestroyerProtoAttack1+2A   r
                                        ; Boss_DestroyerProtoAttack1+3C   r

; Attack pattern 2
Boss_DestroyerProtoAttack2:                             ; DATA XREF: ROM:00031516   o  ; was: sub_318AC
                bsr.w   Boss_DestroyerProtoTurretOpen
                bsr.w   Boss_DestroyerProtoCollision
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w   Boss_DestroyerProtoVelocity
                bsr.w   Boss_DestroyerProtoBounds
                move.l  $4C(a5),d0
                add.l   d0,$18(a5)
                move.l  $50(a5),d0
                add.l   d0,$1C(a5)
                bsr.w   Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$1C,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack2
; Attack pattern 3
Boss_DestroyerProtoAttack3:                             ; DATA XREF: ROM:00031518   o  ; was: sub_318EC
                bsr.w   Boss_DestroyerProtoCollision
                bsr.w   Boss_DestroyerProtoTurretClose
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w   Boss_DestroyerProtoVelocity
                bsr.w   Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jsr     (RandomNumber).l
                andi.w  #3,d0
                beq.s   loc_3197E
                cmpi.w  #1,d0
                beq.w   Boss_DestroyerProtoAttack6Aim
                jsr     (Math_CalculateAngleToPlayer).l
                addi.w  #$10,d2
                andi.w  #$1E0,d2
                move.w  d2,(word_FFC780).w
                move.w  d2,(word_FFC786).w
                move.w  d2,(word_FFC8A0).w
                move.w  d2,(word_FFC8A6).w
                jsr     (RandomNumber).l
                andi.w  #$60,d0                         ; '`'
                addi.w  #$20,d0                         ; ' '
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
loc_3197E:                                              ; CODE XREF: Boss_DestroyerProtoAttack3+32   j
                move.w  #$1C,$4A(a5)
                move.w  #$16,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack3
; Waits for turret open animation during attack 4
Boss_DestroyerProtoAttack4Wait:                         ; DATA XREF: ROM:0003151A   o  ; was: sub_3198C
                bsr.w   Boss_DestroyerProtoTurretOpen
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack4Wait
; Rises upward with palette fade during attack phase
Boss_DestroyerProtoAttack4Rise:                         ; DATA XREF: ROM:0003151C   o  ; was: sub_3199E
                move.w  #$2000,d7
                bsr.w   Boss_DestroyerProtoApplyPaletteFade
                bsr.w   Boss_DestroyerProtoBounds
                addq.w  #1,$4A(a5)
                cmpi.w  #$E,$4A(a5)
                bne.w   Entity_UpdateReturn
                bsr.w   Boss_JetsripperSpawnProjectiles
                move.b  #$EA,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack4Rise
; Descends downward with palette fade during attack phase
Boss_DestroyerProtoAttack4Descend:                      ; DATA XREF: ROM:0003151E   o  ; was: sub_319CC
                move.w  #$2000,d7
                bsr.w   Boss_DestroyerProtoApplyPaletteFade
                bsr.w   Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$20,$4A(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack4Descend
; Delays before next attack phase
Boss_DestroyerProtoAttack4Delay:                        ; DATA XREF: ROM:00031520   o  ; was: sub_319EC
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$1C,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack4Delay
; Retreats with velocity and collision after attack
Boss_DestroyerProtoAttack4Retreat:                      ; DATA XREF: ROM:00031522   o  ; was: sub_31A00
                bsr.w   Boss_DestroyerProtoCollision
                bsr.w   Boss_DestroyerProtoTurretClose
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w   Boss_DestroyerProtoVelocity
                bsr.w   Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                bsr.w   Boss_DestroyerSyncPartAngles
                bra.w   loc_3184C
; End of function Boss_DestroyerProtoAttack4Retreat
; Attack pattern 4
Boss_DestroyerProtoAttack4:                             ; DATA XREF: ROM:00031524   o  ; was: sub_31A28
                bsr.w   Boss_DestroyerProtoTurretOpen
                move.w  #$FFF8,d0
                move.w  #$20,d1                         ; ' '
                bsr.w   Boss_DestroyerProtoVelocity
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack4
; Shooting pattern 1
Boss_DestroyerProtoShootPattern1:                       ; DATA XREF: ROM:00031526   o  ; was: sub_31A46
                move.w  #$FFF8,d0
                move.w  #$20,d1                         ; ' '
                bsr.w   Boss_DestroyerProtoVelocity
                move.w  #$8000,d7
                bsr.w   Boss_DestroyerProtoApplyPaletteFade
                addq.w  #1,$4A(a5)
                cmpi.w  #$E,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$80,$4A(a5)
                move.b  #$56,d0                         ; 'V'
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoShootPattern1
; Shooting pattern 2
Boss_DestroyerProtoShootPattern2:                       ; DATA XREF: ROM:00031528   o  ; was: sub_31A7E
                move.w  #$FFF8,d0
                move.w  #$20,d1                         ; ' '
                bsr.w   Boss_DestroyerProtoVelocity
                bsr.w   Boss_DestroyerProtoShootPattern3
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$E,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoShootPattern2
; Shooting pattern 3
Boss_DestroyerProtoShootPattern3:                       ; CODE XREF: Boss_DestroyerProtoShootPattern2+C   p  ; was: sub_31AA2
                move.w  $4A(a5),d0
                andi.w  #1,d0
                bne.w   Entity_UpdateReturn
                jsr     (Projectile_FindFreeSlot).l
                bne.w   Entity_UpdateReturn
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
loc_31B02:                                              ; CODE XREF: Projectile_Stage14BulletMove+2E   p
                                        ; Projectile_Stage14BulletMove+4E   p
                move.w  #$EC00,2(a0)
                move.l  #off_E96E0,8(a0)
                clr.w   $C(a0)
                move.w  #$8480,$E(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FC04FC04,$2C(a0)
                move.w  #$46,$26(a0)                    ; 'F'
                move.w  #8,$48(a0)
                move.w  #0,4(a0)
                rts
; ---------------------------------------------------------------------------
loc_31B3C:                                              ; CODE XREF: Boss_DestroyerProtoShootPattern3+5E   j
                move.w  #$CC00,2(a0)
                move.l  #word_1CEC90,8(a0)
                move.w  #$400,$E(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$F010F010,$2C(a0)
                move.w  #$64,$26(a0)                    ; 'd'
                move.w  #6,$48(a0)
                move.w  #8,4(a0)
                rts
; End of function Boss_DestroyerProtoShootPattern3
; Rises downward-left with palette fade for attack 5
Boss_DestroyerProtoAttack5Rise:                         ; DATA XREF: ROM:0003152A   o  ; was: sub_31B72
                move.w  #$FFF8,d0
                move.w  #$20,d1                         ; ' '
                bsr.w   Boss_DestroyerProtoVelocity
                move.w  #$8000,d7
                bsr.w   Boss_DestroyerProtoApplyPaletteFade
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$1C,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack5Rise
; Retreats downward-left with collision after attack 5
Boss_DestroyerProtoAttack5Retreat:                      ; DATA XREF: ROM:0003152C   o  ; was: sub_31B9A
                bsr.w   Boss_DestroyerProtoCollision
                bsr.w   Boss_DestroyerProtoTurretClose
                move.w  #$FFF8,d0
                move.w  #$20,d1                         ; ' '
                bsr.w   Boss_DestroyerProtoVelocity
                bsr.w   Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                bsr.w   Boss_DestroyerSyncPartAngles
                bra.w   loc_3184C
; End of function Boss_DestroyerProtoAttack5Retreat
; Calculates angles to player for multi-turret aim
Boss_DestroyerProtoAttack6Aim:                          ; CODE XREF: Boss_DestroyerProtoAttack3+38   j  ; was: sub_31BC2
                jsr     (Math_CalculateAngleToPlayer).l
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
                move.w  #$20,4(a5)                      ; ' '
                rts
; End of function Boss_DestroyerProtoAttack6Aim
; Waits for turret open animation during attack 6
Boss_DestroyerProtoAttack6Wait:                         ; DATA XREF: ROM:0003152E   o  ; was: sub_31BFE
                bsr.w   Boss_DestroyerProtoTurretOpen
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6Wait
; Prepares multi-shot attack with palette fade and spawn pointers
Boss_DestroyerProtoAttack6Prepare:                      ; DATA XREF: ROM:00031530   o  ; was: sub_31C10
                move.w  #$C000,d7
                bsr.w   Boss_DestroyerProtoApplyPaletteFade
                addq.w  #1,$4A(a5)
                cmpi.w  #$E,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.l  #$FFFFC8C0,$58(a5)
                move.l  #$FFFFCEC0,$5C(a5)
                move.w  #$10,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6Prepare
; Delays before multi-shot attack execution
Boss_DestroyerProtoAttack6Delay:                        ; DATA XREF: ROM:00031532   o  ; was: sub_31C42
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$41,$4A(a5)                    ; 'A'
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6Delay
; Executes multi-shot attack pattern spawning projectiles
Boss_DestroyerProtoAttack6Execute:                      ; DATA XREF: ROM:00031534   o  ; was: sub_31C56
                bsr.w   Boss_DestroyerProtoUpdateTurretStates
                bsr.w   Boss_DestroyerProtoSpawnDualShots
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$E,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6Execute
; Spawns dual projectiles from left and right turrets with sound
Boss_DestroyerProtoSpawnDualShots:                      ; CODE XREF: Boss_DestroyerProtoAttack6Execute+4   p  ; was: sub_31C72
                move.w  $4A(a5),d0
                cmpi.w  #$40,d0                         ; '@'
                bcc.w   Entity_UpdateReturn
                cmpi.w  #$C,d0
                bcs.w   Entity_UpdateReturn
                andi.w  #3,d0
                bne.w   Entity_UpdateReturn
                lea     (word_FFC740).w,a4
                movea.l $58(a5),a0
                addi.l  #$60,$58(a5)                    ; '`'
                bsr.w   Boss_DestroyerProtoInitProjectile
                move.b  #$CE,d0
                jsr     (Sound_PlaySFX).l
                lea     (word_FFC860).w,a4
                movea.l $5C(a5),a0
                addi.l  #$60,$5C(a5)                    ; '`'
; End of function Boss_DestroyerProtoSpawnDualShots
; Initializes projectile position, animation, and properties
Boss_DestroyerProtoInitProjectile:                      ; CODE XREF: Boss_DestroyerProtoSpawnDualShots+2C   p  ; was: sub_31CBC
                bsr.w   Boss_JetsripperInitProjectile
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
Boss_DestroyerProtoUpdateTurretStates:                  ; CODE XREF: Boss_DestroyerProtoAttack6Execute   p  ; was: sub_31CF8
                move.w  #2,d0
                lea     (word_FFC680).w,a4
                bsr.w   Boss_DestroyerProtoState1
                move.w  #4,d0
                lea     (word_FFC6E0).w,a4
                bsr.w   Boss_DestroyerProtoState1
                move.w  #8,d1
                lea     (word_FFC740).w,a4
                bsr.w   Boss_DestroyerProtoState2
                move.w  #$FFFE,d0
                lea     (word_FFC7A0).w,a4
                bsr.w   Boss_DestroyerProtoState1
                move.w  #$FFFC,d0
                lea     (word_FFC800).w,a4
                bsr.w   Boss_DestroyerProtoState1
                move.w  #$FFF8,d1
                lea     (word_FFC860).w,a4
                bsr.w   Boss_DestroyerProtoState2
                rts
; End of function Boss_DestroyerProtoUpdateTurretStates
; Fades out palette after multi-shot attack
Boss_DestroyerProtoAttack6FadeOut:                      ; DATA XREF: ROM:00031536   o  ; was: sub_31D42
                move.w  #$C000,d7
                bsr.w   Boss_DestroyerProtoApplyPaletteFade
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$20,$4A(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6FadeOut
; Waits after palette fade before retreat
Boss_DestroyerProtoAttack6Wait2:                        ; DATA XREF: ROM:00031538   o  ; was: sub_31D5E
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$1C,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerProtoAttack6Wait2
; Retreats with velocity and collision after attack 6
Boss_DestroyerProtoAttack6Retreat:                      ; DATA XREF: ROM:0003153A   o  ; was: sub_31D72
                bsr.w   Boss_DestroyerProtoCollision
                bsr.w   Boss_DestroyerProtoTurretClose
                move.w  #$C,d0
                move.w  #$10,d1
                bsr.w   Boss_DestroyerProtoVelocity
                bsr.w   Boss_DestroyerProtoBounds
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                bsr.w   Boss_DestroyerSyncPartAngles
                bra.w   loc_3184C
; End of function Boss_DestroyerProtoAttack6Retreat
; Spawns projectile type 1
Boss_DestroyerProtoSpawnProjectile1:                    ; DATA XREF: ROM:0003153C   o  ; was: sub_31D9A
                clr.b   $21(a5)
                movea.w a5,a4
                lea     word_31FF8(pc),a0
                nop
                lea     word_32038(pc),a1
                nop
                move.w  #5,d7
loc_31DB0:                                              ; CODE XREF: Boss_DestroyerProtoSpawnProjectile1+3A   j
                adda.w  #$60,a4                         ; '`'
                jsr     (RandomNumber).l
                andi.w  #$3C,d0                         ; '<'
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
Boss_DestroyerProtoSpawnProjectile2:                    ; CODE XREF: Boss_DestroyerProtoSpawnProjectile3   p  ; was: sub_31DF6
                jsr     (Gfx_UpdatePaletteFade).l
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                jsr     (Projectile_UpdateWithExplosionSound).l
                jsr     (Projectile_FindFreeSlot).l
                bne.w   Entity_UpdateReturn
                jsr     (Projectile_InitType88).l
                clr.b   $20(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$20,d0                         ; ' '
                subi.w  #$20,d1                         ; ' '
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
off_31E7C:      dc.l    off_E953C                       ; DATA XREF: Boss_DestroyerProtoSpawnProjectile2+78   r
                dc.l    off_E95A4
                dc.l    off_E9560
                dc.l    off_E95C0
                dc.l    off_E9584
                dc.l    off_E95DC
                dc.l    off_E9584
                dc.l    off_E9604

; Spawns projectile type 3
Boss_DestroyerProtoSpawnProjectile3:                    ; DATA XREF: ROM:0003153E   o  ; was: sub_31E9C
                bsr.w   Boss_DestroyerProtoSpawnProjectile2
                jsr     Boss_DestroyerProtoPaletteFade(pc)  ; (pc)
                nop
                jsr     Boss_DestroyerProtoRotateSprites(pc)  ; (pc)
                nop
                subq.w  #1,$4A(a5)
                bne.w   Entity_UpdateReturn
                movea.l #word_31EC8,a0
                jsr     (Gfx_LoadCompressedTiles).l
                move.w  #$1000,2(a5)
                rts
; End of function Boss_DestroyerProtoSpawnProjectile3
; ---------------------------------------------------------------------------
word_31EC8:     dc.w    $4000, $4000, $303, 0, 0, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: Boss_DestroyerProtoSpawnProjectile3+18   o

; Rotates sprite angles in RAM for visual effect
Boss_DestroyerProtoRotateSprites:                       ; CODE XREF: Boss_DestroyerProtoSpawnProjectile3+A   p  ; was: sub_31EDE
                                        ; DATA XREF: Boss_DestroyerProtoSpawnProjectile3+A   o
                move.w  $4A(a5),d0
                cmpi.w  #$40,d0                         ; '@'
                bcc.w   Entity_UpdateReturn
                andi.w  #1,d0
                bne.w   Entity_UpdateReturn
                lea     (word_FFE480).w,a0
                lea     word_31F28(pc),a1
                nop
                clr.w   d1
                move.w  #$BF,d0
loc_31F02:                                              ; CODE XREF: Boss_DestroyerProtoRotateSprites+44   j
                move.w  (a0),d2
                andi.w  #$1FF,d2
                cmpi.w  #$140,d2
                bcs.s   loc_31F14
                cmpi.w  #$180,d2
                bcs.s   loc_31F1A
loc_31F14:                                              ; CODE XREF: Boss_DestroyerProtoRotateSprites+2E   j
                add.w   (a1,d1.w),d2
                move.w  d2,(a0)
loc_31F1A:                                              ; CODE XREF: Boss_DestroyerProtoRotateSprites+34   j
                addq.w  #4,a0
                addq.w  #2,d1
                andi.w  #$1E,d1
                dbf     d0,loc_31F02
                rts
; End of function Boss_DestroyerProtoRotateSprites
; ---------------------------------------------------------------------------
word_31F28:     dc.w    1, $FFFF                        ; DATA XREF: Boss_DestroyerProtoRotateSprites+18   o
                dc.w    5, $FFFB
                dc.w    7, $FFF9
                dc.w    3, $FFFD
                dc.w    6, $FFFA
                dc.w    2, $FFFE
                dc.w    8, $FFF8
                dc.w    4, $FFFC

; Applies palette fade effect based on timer and fade direction
Boss_DestroyerProtoApplyPaletteFade:                    ; CODE XREF: Boss_DestroyerProtoAttack4Rise+4   p  ; was: sub_31F48
                                        ; Boss_DestroyerProtoAttack4Descend+4   p
                move.w  $4A(a5),d0
                andi.w  #$E,d0
                move.w  #$F,d5
                lea     (word_FFE360).w,a0
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_DestroyerProtoApplyPaletteFade
; Palette fade effect
Boss_DestroyerProtoPaletteFade:                         ; CODE XREF: Boss_DestroyerProtoSpawnProjectile3+4   p  ; was: sub_31F5E
                                        ; DATA XREF: Boss_DestroyerProtoSpawnProjectile3+4   o
                cmpi.w  #$E,$4A(a5)
                bcc.w   Entity_UpdateReturn
                move.w  #$E000,d7
                move.w  #$F,d0
                sub.w   $4A(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                lea     (word_FFE300).w,a0
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_DestroyerProtoPaletteFade
; Boss state handler 4
Boss_DestroyerProtoState4:                              ; DATA XREF: ROM:000314D0   o  ; was: sub_31F86
                tst.w   4(a5)
                bne.w   Projectile_DestroyerProtoUpdate
; End of function Boss_DestroyerProtoState4
; Recomputes an entity's position from its parent, polar angle, and radius
Entity_UpdatePolarPositionFromParent:                   ; CODE XREF: Boss_GustheadLinkedChainBeginAttackCycle   p  ; was: sub_31F8E
                                        ; Boss_GustheadLinkedChainTerminalBeginAttackCycle   p
                movea.w $44(a5),a4
                move.w  $40(a5),d0
                bsr.w   Math_LookupSineCosinePairDuplicate
                move.w  $42(a5),d2
                muls.w  d2,d0
                add.l   $10(a4),d0
                move.l  d0,$10(a5)
                muls.w  d2,d1
                add.l   $14(a4),d1
                move.l  d1,$14(a5)
                rts
; End of function Entity_UpdatePolarPositionFromParent
; Boss state handler 5
Boss_DestroyerProtoState5:                              ; DATA XREF: ROM:000314D2   o  ; was: sub_31FB4
                tst.w   4(a5)
                bne.w   loc_31FEA
                bsr.w   Entity_UpdatePolarPositionFromParent
loc_31FC0:                                              ; CODE XREF: Boss_DestroyerProtoState5+3C   p
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
loc_31FEA:                                              ; CODE XREF: Boss_DestroyerProtoState5+4   j
                addi.w  #$20,$46(a5)                    ; ' '
                bsr.w   loc_31FC0
                bra.w   Projectile_DestroyerProtoUpdate
; End of function Boss_DestroyerProtoState5
; ---------------------------------------------------------------------------
word_31FF8:     dc.w    4, 0                            ; DATA XREF: Boss_DestroyerProtoShootPattern3+16   o
                                        ; Boss_DestroyerProtoSpawnProjectile1+6   o
                dc.w    3, $8000
                dc.w    2, $D410
                dc.w    1, $C000
                dc.w    0, 0
                dc.w    $FFFE, $4000
                dc.w    $FFFD, $2BF0
                dc.w    $FFFC, $8000
                dc.w    $FFFC, 0
                dc.w    $FFFC, $8000
                dc.w    $FFFD, $2BF0
                dc.w    $FFFE, $4000
                dc.w    0, 0
                dc.w    1, $C000
                dc.w    2, $D410
                dc.w    3, $8000
word_32038:     dc.w    0, 0                            ; DATA XREF: Boss_DestroyerProtoShootPattern3+1C   o
                                        ; Boss_DestroyerProtoSpawnProjectile1+C   o
                dc.w    1, $C000
                dc.w    2, $D410
                dc.w    3, $8000
                dc.w    4, 0
                dc.w    3, $8000
                dc.w    2, $D410
                dc.w    1, $C000
                dc.w    0, 0
                dc.w    $FFFE, $4000
                dc.w    $FFFD, $2BF0
                dc.w    $FFFC, $8000
                dc.w    $FFFC, 0
                dc.w    $FFFC, $8000
                dc.w    $FFFD, $2BF0
                dc.w    $FFFE, $4000
dword_32078:    dc.l    $300000, $2AC000                ; DATA XREF: Boss_JetsripperInitProjectile+4C   o
                dc.l    $21F0C0, $144000
                dc.l    0, $FFEBC000
                dc.l    $FFDE0F40, $FFD54000
                dc.l    $FFD00000, $FFD54000
                dc.l    $FFDE0F40, $FFEBC000
                dc.l    0, $144000
                dc.l    $21F0C0, $2AC000
dword_320B8:    dc.l    0, $144000                      ; DATA XREF: Boss_JetsripperInitProjectile+68   o
                dc.l    $21F0C0, $2AC000
                dc.l    $300000, $2AC000
                dc.l    $21F0C0, $144000
                dc.l    0, $FFEBC000
                dc.l    $FFDE0F40, $FFD54000
                dc.l    $FFD00000, $FFD54000
                dc.l    $FFDE0F40, $FFEBC000
word_320F8:     dc.w    $6B00, $6B00, $6B00, $6B00
                                        ; DATA XREF: Boss_DestroyerProtoInitProjectile+22   o
                                        ; Boss_DestroyerProtoState5+28   o
                dc.w    $6300, $6300, $6300, $6300
                dc.w    $7300, $7300, $7300, $7300
                dc.w    $7B00, $7B00, $7B00, $7B00
off_32118:      dc.l    word_ECF04                      ; DATA XREF: Boss_DestroyerProtoState5+1A   o
                dc.l    word_ECF16
                dc.l    word_ECF28
                dc.l    word_ECF40
                dc.l    word_ECEF2
                dc.l    word_ECF40
                dc.l    word_ECF28
                dc.l    word_ECF16
                dc.l    word_ECF04
                dc.l    word_ECF16
                dc.l    word_ECF28
                dc.l    word_ECF40
                dc.l    word_ECEF2
                dc.l    word_ECF40
                dc.l    word_ECF28
                dc.l    word_ECF16

; Spawns Jetsripper boss projectiles at two different RAM addresses
