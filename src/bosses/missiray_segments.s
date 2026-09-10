Segment_MissirayPartMain:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_54458
                move.b  $50(a5),d0
                andi.w  #3,d0
                add.w   d0,d0
                move.w  d0,d0
                lea     off_5446C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Segment_MissirayPartMain
; ---------------------------------------------------------------------------
off_5446C:      dc.w    Segment_MissirayType1Main-*     ; DATA XREF: Segment_MissirayPartMain+C   o
                dc.w    Segment_MissirayPartDispatcher-*
                dc.w    Segment_MissirayType2Main-*

; Segment part dispatcher
Segment_MissirayPartDispatcher:                         ; DATA XREF: ROM:0005446E   o  ; was: sub_54472
                move.w  4(a5),d0
                lea     off_5447E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Segment_MissirayPartDispatcher
; ---------------------------------------------------------------------------
off_5447E:      dc.w    Segment_MissirayPartInit-*      ; DATA XREF: Segment_MissirayPartDispatcher+4   o
                dc.w    Segment_MissirayPartRotate-*
                dc.w    Segment_MissirayPartRetract-*

; Segment part init
Segment_MissirayPartInit:                               ; DATA XREF: ROM:off_5447E   o  ; was: sub_54484
                clr.b   $52(a5)
                rts
; End of function Segment_MissirayPartInit
; Segment part rotation
Segment_MissirayPartRotate:                             ; DATA XREF: ROM:00054480   o  ; was: sub_5448A
                move.b  #1,$52(a5)
                cmpi.w  #$10,(word_FFC624).w
                bcs.s   loc_544B4
                addi.w  #$10,$48(a5)
                move.w  #$40,d0                         ; '@'
                bsr.w   Segment_MissirayCalculateAngle
                andi.w  #$3F0,$48(a5)
                cmpi.w  #$200,$48(a5)
                bne.s   locret_544C8
loc_544B4:                                              ; CODE XREF: Segment_MissirayPartRotate+C   j
                bset    #6,$21(a5)
                addq.w  #2,4(a5)
                move.b  #$57,d0                         ; 'W'
                jsr     (Sound_PlaySFX).l
locret_544C8:                                           ; CODE XREF: Segment_MissirayPartRotate+28   j
                rts
; End of function Segment_MissirayPartRotate
; Segment part retract
Segment_MissirayPartRetract:                            ; DATA XREF: ROM:00054482   o  ; was: sub_544CA
                bsr.s   Segment_MissirayPartMoveToTarget
                cmpi.w  #$10,(word_FFC624).w
                bcs.s   loc_544DA
                bsr.s   Segment_MissirayPartMoveToTarget
                bsr.s   Segment_MissirayPartMoveToTarget
                bsr.s   Segment_MissirayPartMoveToTarget
loc_544DA:                                              ; CODE XREF: Segment_MissirayPartRetract+8   j
                move.w  $4C(a5),d0
                cmp.w   $4E(a5),d0
                bne.s   locret_544F2
                bclr    #6,$21(a5)
                clr.w   $4E(a5)
                clr.w   4(a5)
locret_544F2:                                           ; CODE XREF: Segment_MissirayPartRetract+18   j
                rts
; End of function Segment_MissirayPartRetract
; Move segment to target
Segment_MissirayPartMoveToTarget:                       ; CODE XREF: Segment_MissirayPartRetract   p  ; was: sub_544F4
                                        ; Segment_MissirayPartRetract+A   p
                move.w  $4E(a5),d0
                sub.w   $4C(a5),d0
                beq.s   locret_5450C
                tst.w   d0
                bpl.s   loc_54508
                subq.w  #1,$4C(a5)
                rts
; ---------------------------------------------------------------------------
loc_54508:                                              ; CODE XREF: Segment_MissirayPartMoveToTarget+C   j
                addq.w  #1,$4C(a5)
locret_5450C:                                           ; CODE XREF: Segment_MissirayPartMoveToTarget+8   j
                rts
; End of function Segment_MissirayPartMoveToTarget
; Cycles through 16 graphics frames for body animation
Boss_MissirayUpdateGraphicsFrame:                       ; CODE XREF: Boss_MissirayShuffleSegmentOrder   p  ; was: sub_5450E
                                        ; sub_5420A   p
                addq.w  #2,(dword_FF9410).w
                cmpi.w  #$1E,(dword_FF9410).w
                bne.s   loc_5451E
                clr.w   (dword_FF9410).w
loc_5451E:                                              ; CODE XREF: Boss_MissirayUpdateGraphicsFrame+A   j
                move.w  (dword_FF9410).w,d0
                move.w  word_54542(pc,d0.w),(dword_FF940C+2).w
; End of function Boss_MissirayUpdateGraphicsFrame
; Applies palette fade effect using word_FFE360 palette data
Gfx_ApplyPaletteFadeWrapper:                            ; CODE XREF: Boss_MissirayAttack2Init:loc_54158   p  ; was: sub_54528
                                        ; sub_5434C   p
                move.w  (dword_FF940C+2).w,d0
                andi.w  #$E,d0
                move.w  #$F,d5
                lea     (word_FFE360).w,a0
                move.w  (dword_FF9410+2).w,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Gfx_ApplyPaletteFadeWrapper
; ---------------------------------------------------------------------------
word_54542:     dc.w    $E, $C, $A, 8, 6, 4, 2, 0, 2, 4, 6, 8, $A, $C, $E
                                        ; DATA XREF: Boss_MissirayUpdateGraphicsFrame+14   r

; Segment type 1 main
Segment_MissirayType1Main:                              ; DATA XREF: ROM:off_5446C   o  ; was: sub_54560
                move.w  4(a5),d0
                lea     off_5456C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Segment_MissirayType1Main
; ---------------------------------------------------------------------------
off_5456C:      dc.w    Segment_MissirayType1Idle-*     ; DATA XREF: Segment_MissirayType1Main+4   o
                dc.w    Segment_MissirayType1Fire-*
                dc.w    Segment_MissirayType1Rotate1-*
                dc.w    Segment_MissirayType1Rotate2-*
                dc.w    Segment_MissirayType1WaitEnd-*

; Segment type 1 idle
Segment_MissirayType1Idle:                              ; DATA XREF: ROM:off_5456C   o  ; was: sub_54576
                clr.b   $52(a5)
                rts
; End of function Segment_MissirayType1Idle
; Segment type 1 fire
Segment_MissirayType1Fire:                              ; DATA XREF: ROM:0005456E   o  ; was: sub_5457C
                move.b  #1,$52(a5)
                subq.w  #1,$48(a5)
                bpl.s   locret_545D6
                clr.w   $48(a5)
                addq.w  #2,4(a5)
                cmpi.b  #1,$51(a5)
                beq.s   loc_545B8
                movea.w $54(a5),a0
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                move.l  #$FFFF0000,d2
                move.l  #$FFFFE000,d3
                jsr     (Projectile_InitMissirayFallingShot).l
                rts
; ---------------------------------------------------------------------------
loc_545B8:                                              ; CODE XREF: Segment_MissirayType1Fire+1A   j
                movea.w $54(a5),a0
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                move.l  #$2800,d2
                move.l  #$1000,d3
                jsr     (Projectile_InitMissirayBullet).l
locret_545D6:                                           ; CODE XREF: Segment_MissirayType1Fire+A   j
                rts
; End of function Segment_MissirayType1Fire
; Segment type 1 rotate 1
Segment_MissirayType1Rotate1:                           ; DATA XREF: ROM:00054570   o  ; was: sub_545D8
                addi.w  #$10,$48(a5)
                move.w  #$40,d0                         ; '@'
                bsr.w   Segment_MissirayCalculateAngle
                andi.w  #$1F0,$48(a5)
                cmpi.w  #$100,$48(a5)
                bne.s   locret_545F8
                addq.w  #2,4(a5)
locret_545F8:                                           ; CODE XREF: Segment_MissirayType1Rotate1+1A   j
                rts
; End of function Segment_MissirayType1Rotate1
; Calculate angle from sine
Segment_MissirayCalculateAngle:                         ; CODE XREF: Segment_MissirayPartRotate+18   p  ; was: sub_545FA
                                        ; Segment_MissirayType1Rotate1+A   p
                move.w  $48(a5),d1
                andi.w  #$1FE,d1
                lea     (Math_SineTable).l,a3
                move.w  Math_QuarterSineTable-Math_SineTable(a3,d1.w),d1
                muls.w  d0,d1
                swap    d1
                move.w  d1,$4C(a5)
                rts
; End of function Segment_MissirayCalculateAngle
; Segment type 1 rotate 2
Segment_MissirayType1Rotate2:                           ; DATA XREF: ROM:00054572   o  ; was: sub_54616
                addi.w  #$10,$48(a5)
                move.w  #$20,d0                         ; ' '
                bsr.w   Segment_MissirayCalculateAngle
                andi.w  #$1F0,$48(a5)
                cmpi.w  #0,$48(a5)
                bne.s   locret_5463C
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_5463C:                                           ; CODE XREF: Segment_MissirayType1Rotate2+1A   j
                rts
; End of function Segment_MissirayType1Rotate2
; Segment type 1 wait end
Segment_MissirayType1WaitEnd:                           ; DATA XREF: ROM:00054574   o  ; was: sub_5463E
                subq.w  #1,$48(a5)
                bne.s   locret_54648
                clr.w   4(a5)
locret_54648:                                           ; CODE XREF: Segment_MissirayType1WaitEnd+4   j
                rts
; End of function Segment_MissirayType1WaitEnd
; Segment type 2 main
Segment_MissirayType2Main:                              ; DATA XREF: ROM:00054470   o  ; was: sub_5464A
                move.w  4(a5),d0
                lea     off_54656(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Segment_MissirayType2Main
; ---------------------------------------------------------------------------
off_54656:      dc.w    Segment_MissirayType2Delay-*    ; DATA XREF: Segment_MissirayType2Main+4   o
                dc.w    Segment_MissirayType2Rise-*
                dc.w    nullsub_125-*

; Segment type 2 delay
Segment_MissirayType2Delay:                             ; DATA XREF: ROM:off_54656   o  ; was: sub_5465C
                subq.w  #1,$48(a5)
                bne.s   locret_5467A
                addq.w  #2,4(a5)
                tst.w   (dword_FF9404).w
                bne.s   locret_5467A
                tst.w   (dword_FF9408+2).w
                bne.s   locret_5467A
                move.l  #$FFFC0000,$1C(a5)
locret_5467A:                                           ; CODE XREF: Segment_MissirayType2Delay+4   j
                                        ; Segment_MissirayType2Delay+E   j
                rts
; End of function Segment_MissirayType2Delay
; Segment type 2 rise up
Segment_MissirayType2Rise:                              ; DATA XREF: ROM:00054658   o  ; was: sub_5467C
                addi.l  #$1000,$1C(a5)
                cmpi.w  #$180,$14(a5)
                bgt.s   loc_5469E
                subq.w  #1,$48(a5)
                bpl.s   locret_5469C
                bsr.w   Segment_MissirayType2SpawnDebris
                move.w  #6,$48(a5)
locret_5469C:                                           ; CODE XREF: Segment_MissirayType2Rise+14   j
                rts
; ---------------------------------------------------------------------------
loc_5469E:                                              ; CODE XREF: Segment_MissirayType2Rise+E   j
                move.w  #$1000,2(a5)
                rts
; End of function Segment_MissirayType2Rise
; Segment type 2 spawn debris
Segment_MissirayType2SpawnDebris:                       ; CODE XREF: Segment_MissirayType2Rise+16   p  ; was: sub_546A6
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_546DC
                jsr     (RandomNumber).l
                jsr     (Sprite_InitType160).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                lsl.w   #2,d0
                move.l  off_546DE(pc,d0.w),8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                ori.w   #$8000,$E(a0)
locret_546DC:                                           ; CODE XREF: Segment_MissirayType2SpawnDebris+6   j
                rts
; End of function Segment_MissirayType2SpawnDebris
; ---------------------------------------------------------------------------
off_546DE:      dc.l    SharedCombatSpriteAnimation00   ; DATA XREF: Segment_MissirayType2SpawnDebris+1E   r
                dc.l    SharedCombatSpriteAnimation03
                dc.l    SharedCombatSpriteAnimation05
                dc.l    SharedCombatSpriteAnimation18
                dc.l    SharedCombatSpriteAnimation00
                dc.l    SharedCombatSpriteAnimation19
                dc.l    SharedCombatSpriteAnimation05
                dc.l    SharedCombatSpriteAnimation20

nullsub_125:                                            ; DATA XREF: ROM:0005465A   o
                rts
; End of function nullsub_125

; Handles directional input for Valkirie boss horizontal movement
Boss_ValkirieInputControl:
                btst    #6,(word_FFF706).w              ; was: sub_54700
                beq.s   locret_5472C
                btst    #0,(word_FFF706).w
                beq.s   loc_5471A
                subq.w  #2,$14(a5)
                move.w  $14(a5),$4E(a5)
loc_5471A:                                              ; CODE XREF: Boss_ValkirieInputControl+E   j
                btst    #1,(word_FFF706).w
                beq.s   locret_5472C
                addq.w  #2,$14(a5)
                move.w  $14(a5),$4E(a5)
locret_5472C:                                           ; CODE XREF: Boss_ValkirieInputControl+6   j
                                        ; Boss_ValkirieInputControl+20   j
                rts
; End of function Boss_ValkirieInputControl
; Check player proximity
Boss_MissirayCheckPlayerProximity:                      ; CODE XREF: Boss_MissirayMainAttackLoop   p  ; was: sub_5472E
                tst.w   (dword_FF9408+2).w
                bne.w   locret_547D6
                tst.w   (dword_FF940C).w
                bmi.s   loc_5475A
                jsr     (Physics_GetPlayerDelta).l
                move.w  #$20,d1                         ; ' '
                tst.w   (DifficultyMode).w
                beq.s   loc_5474E
                add.w   d1,d1
loc_5474E:                                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+1C   j
                cmp.w   d1,d0
                bhi.w   locret_547D6
                subq.w  #1,(dword_FF940C).w
                rts
; ---------------------------------------------------------------------------
loc_5475A:                                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+C   j
                tst.w   (dword_FF9404).w
                beq.s   loc_54768
                move.w  #$40,(dword_FF940C).w           ; '@'
                bra.s   loc_5476E
; ---------------------------------------------------------------------------
loc_54768:                                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+30   j
                move.w  #$80,(dword_FF940C).w
loc_5476E:                                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+38   j
                move.w  #$C,d5
                add.w   $10(a5),d5
                move.l  #$F010F804,d3
                tst.w   (dword_FF9404).w
                bne.s   loc_54790
                move.w  #$FFE0,d6
                add.w   $14(a5),d6
                move.w  #$18,d4
                bra.s   loc_5479C
; ---------------------------------------------------------------------------
loc_54790:                                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+52   j
                move.w  #$20,d6                         ; ' '
                add.w   $14(a5),d6
                move.w  #8,d4
loc_5479C:                                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+60   j
                jsr     Boss_MissiraySpawnMissile(pc)   ; (pc)
                nop
                move.w  #$FFF4,d5
                add.w   $10(a5),d5
                move.l  #$F010FC08,d3
                tst.w   (dword_FF9404).w
                bne.s   loc_547C4
                move.w  #$FFE0,d6
                add.w   $14(a5),d6
                move.w  #$18,d4
                bra.s   loc_547D0
; ---------------------------------------------------------------------------
loc_547C4:                                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+86   j
                move.w  #$20,d6                         ; ' '
                add.w   $14(a5),d6
                move.w  #8,d4
loc_547D0:                                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+94   j
                jsr     Boss_MissiraySpawnMissile(pc)   ; (pc)
                nop
locret_547D6:                                           ; CODE XREF: Boss_MissirayCheckPlayerProximity+4   j
                                        ; Boss_MissirayCheckPlayerProximity+22   j
                rts
; End of function Boss_MissirayCheckPlayerProximity
; Spawn missile projectile
Boss_MissiraySpawnMissile:                              ; CODE XREF: Boss_MissirayCheckPlayerProximity:loc_5479C   p  ; was: sub_547D8
                                        ; sub_5472E:loc_547D0   p
                                        ; DATA XREF:
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_54830
                move.w  #$404,(a0)
                move.w  #$EC00,2(a0)
                move.l  #SharedCombatSpriteAnimation12,8(a0)
                move.w  #$8480,$E(a0)
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                clr.w   4(a0)
                move.w  #$20,$46(a0)                    ; ' '
                sub.w   $10(a5),d5
                move.w  d5,$4A(a0)
                sub.w   $14(a5),d6
                move.w  d6,$4C(a0)
                move.w  d4,$50(a0)
                move.l  d3,$54(a0)
                move.w  a5,$48(a0)
                move.b  #$CE,d0
                jsr     (Sound_PlaySFX).l
locret_54830:                                           ; CODE XREF: Boss_MissiraySpawnMissile+6   j
                rts
; End of function Boss_MissiraySpawnMissile
; Missile projectile main
Projectile_MissirayMissileMain:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_54832
                move.w  4(a5),d0
                lea     off_5483E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_MissirayMissileMain
; ---------------------------------------------------------------------------
off_5483E:      dc.w    Projectile_MissirayMissileTrack-*  ; DATA XREF: Projectile_MissirayMissileMain+4   o
                dc.w    Projectile_MissirayMissileFly-*

; Missile tracking state
Projectile_MissirayMissileTrack:                        ; DATA XREF: ROM:off_5483E   o  ; was: sub_54842
                movea.w $48(a5),a4
                move.w  $10(a4),d0
                add.w   $4A(a5),d0
                move.w  d0,$10(a5)
                move.w  $14(a4),d0
                add.w   $4C(a5),d0
                move.w  d0,$14(a5)
                subq.w  #1,$46(a5)
                bne.s   locret_548E2
                move.w  #$1000,2(a5)
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_548E2
                move.w  #$404,(a0)
                move.w  #$8E00,2(a0)
                move.w  #2,4(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$4344,$E(a0)
                move.w  #$300,8(a0)
                move.w  #$FCF0,$A(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  $54(a5),$2C(a0)
                move.w  #$96,$26(a0)
                cmpi.w  #$18,$50(a5)
                beq.s   loc_548D2
                move.l  #$4650,$1C(a0)
                move.l  #$2000,$48(a0)
                ori.w   #$1000,$E(a0)
                rts
; ---------------------------------------------------------------------------
loc_548D2:                                              ; CODE XREF: Projectile_MissirayMissileTrack+76   j
                move.l  #$FFFFB9B0,$1C(a0)
                move.l  #$FFFFE000,$48(a0)
locret_548E2:                                           ; CODE XREF: Projectile_MissirayMissileTrack+20   j
                                        ; Projectile_MissirayMissileTrack+2E   j
                rts
; End of function Projectile_MissirayMissileTrack
; Missile flying state
Projectile_MissirayMissileFly:                          ; DATA XREF: ROM:00054840   o  ; was: sub_548E4
                move.l  $48(a5),d0
                add.l   d0,$1C(a5)
                rts
; End of function Projectile_MissirayMissileFly
; Initializes 9 sub-entities at offset $360 with sprite and tile data
